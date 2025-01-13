import paho.mqtt.client as mqtt
import mysql.connector as mysql
import json

# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, reason_code, properties):
    print(f"Connected with result code {reason_code}")
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe("ZONE_01/#")

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
  # Parsing a JSON payload data.
  try:
    DATA = json.loads(msg.payload)
  except json.JSONDecodeError:
    print("Invalid JSON payload")
    return
  
  print("\n\n\n")

  if DATA is not None:
    connection = mysql.connect(
    host="sql7.freesqldatabase.com",
    user="sql7756592",
    password="3pUyiJRjCG",
    database="sql7756592"
    )

    if connection.is_connected():
      print("Connected to MySQL Server")
      mysql_cursor = connection.cursor()

      if DATA["Alarm"]["message"] != "":
        sql_insert_query_alarmy = "INSERT INTO alarmy(alarmId, machineId, message, code, timestamp) VALUES (NULL, %s, %s, %s, CURRENT_TIMESTAMP)"
        alarm_values = (DATA["MachineID"], DATA["Alarm"]["message"], DATA["Alarm"]["code"])
        mysql_cursor.execute(sql_insert_query_alarmy, alarm_values)
        connection.commit()
        print("Alarm inserted successfully")
      else:
        print("Alarm not inserted")

      if DATA["Event"]["message"] != "":
        sql_insert_query_events = "INSERT INTO events(eventId, machineId, code, message, timestamp) VALUES (NULL, %s, %s, %s, CURRENT_TIMESTAMP)"
        events_values = (DATA["MachineID"], DATA["Event"]["code"], DATA["Event"]["message"])
        mysql_cursor.execute(sql_insert_query_events, events_values)
        connection.commit()
        print("Event inserted successfully")
      else:
        print("Event not inserted")
      
      if DATA["product"]["Comment"] != "":
        sql_insert_query_product = "INSERT INTO produkty (id, machineId, status, program, cycletime, progress, timestamp) VALUES (%s, %s, %s, %s, %s, %s, CURRENT_TIMESTAMP)"
        product_values = (DATA["product"]["ID"], DATA["MachineID"], DATA["product"]["Status"], DATA["product"]["Serial"], DATA["product"]["CycleTime"], DATA["product"]["Comment"]["PROGRESS"])
        mysql_cursor.execute(sql_insert_query_product, product_values)
        connection.commit()
        print("Product inserted successfully")
      else:
        print("Product not inserted")


      sql_last_machine_status = "SELECT mode, isOn, timestamp FROM machine_status WHERE machineID = %s ORDER BY timestamp DESC LIMIT 1"
      machine_last_status_values = (DATA["MachineID"],)
      mysql_cursor.execute(sql_is_same_status, value_is_same_status)
      result_is_same_status = mysql_cursor.fetchone()
      if result_is_same_status[1] == DATA["MachineStatus"][1]:
        time_diff = result_is_same_status[2] - DATA["MachineStatus"][2]
      #todo: implementacja obliczania czasu pracy maszyny

      sql_insert_machine_status = "INSERT INTO machine_status(machineID, mode, isOn, timestamp) VALUES (%s, %s, %s, CURRENT_TIMESTAMP)"
      
      machines_status_values = (DATA["MachineID"], DATA["MachineStatus"][0], DATA["MachineStatus"][1])
      mysql_cursor.execute(sql_insert_machine_status, machines_status_values)
      connection.commit()
      print("Machine status inserted successfully")

      sql_unique_machineid_query = "SELECT COUNT(*) FROM maszyny WHERE machineId = %s"
      unique_value = (DATA["MachineID"],)
      mysql_cursor.execute(sql_unique_machineid_query, unique_value)
      result_unique = mysql_cursor.fetchone()

      if result_unique[0] > 0:
        print("Machine already exists")
      else:
        sql_insert_query_maszyny = "INSERT INTO maszyny (id, machineId, operatorId) VALUES (NULL, %s, %s)"
        values = (DATA["MachineID"], DATA["OperatorID"])
        mysql_cursor.execute(sql_insert_query_maszyny, values)
        connection.commit()

        if mysql_cursor.rowcount > 0:
          print("Record inserted successfully to maszyny")
        else:
          print("Record not inserted")

        mysql_cursor.close()
        connection.close()
    else:
      print("Connection failed")


# MQTT client setup
mqttc = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
mqttc.on_connect = on_connect
mqttc.on_message = on_message

# Connect to the MQTT broker
mqttc.connect("broker.emqx.io", 1883, 60)

# Blocking call to process network traffic, dispatch callbacks, and handle reconnecting
mqttc.loop_forever()