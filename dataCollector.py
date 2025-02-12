import paho.mqtt.client as mqtt
import pymysql
import json
import os
from dotenv import load_dotenv

load_dotenv()

def on_connect(client, userdata, flags, reason_code, properties):
    print(f"Connected with result code {reason_code}")
    client.subscribe("ZONE_01/#")

def on_message(client, userdata, msg):
    try:
        data = json.loads(msg.payload)
    except json.JSONDecodeError:
        print("Invalid JSON payload")
        print("Payload:", msg.payload)
        return

    print("\n\n\n")

    if data is not None:
        try:
            # Nawiązanie połączenia przy użyciu PyMySQL
            connection = pymysql.connect(
                host=os.getenv("DB_HOST"),
                user=os.getenv("DB_USER"),
                password=os.getenv("DB_PASSWORD"),
                database=os.getenv("DB_DATABASE"),
                port=int(os.getenv("DB_PORT", 3306)),
                connect_timeout=10
            )
            print("Connected to MySQL Server (PyMySQL)")
            cursor = connection.cursor()

            # Wstawianie alarmu
            if data["Alarm"]["message"] != "":
                sql_insert_query_alarmy = (
                    "INSERT INTO alarmy(alarmId, machineId, message, code, timestamp) "
                    "VALUES (NULL, %s, %s, %s, CURRENT_TIMESTAMP)"
                )
                alarm_values = (data["MachineID"], data["Alarm"]["message"], data["Alarm"]["code"])
                cursor.execute(sql_insert_query_alarmy, alarm_values)
                connection.commit()
                print("Alarm inserted successfully")
            else:
                print("Alarm not inserted")

            # Wstawianie eventu
            if data["Event"]["message"] != "":
                sql_insert_query_events = (
                    "INSERT INTO events(eventId, machineId, code, message, timestamp) "
                    "VALUES (NULL, %s, %s, %s, CURRENT_TIMESTAMP)"
                )
                events_values = (data["MachineID"], data["Event"]["code"], data["Event"]["message"])
                cursor.execute(sql_insert_query_events, events_values)
                connection.commit()
                print("Event inserted successfully")
            else:
                print("Event not inserted")

            # Wstawianie produktu
            if data["product"]["Comment"] != "":
                sql_insert_query_product = (
                    "INSERT INTO produkty (id, machineId, status, program, cycletime, progress, scale, timestamp) "
                    "VALUES (%s, %s, %s, %s, %s, %s, %s, CURRENT_TIMESTAMP)"
                )
                product_values = (
                    data["product"]["ID"],
                    data["MachineID"],
                    data["product"]["Status"],
                    data["product"]["Serial"],
                    data["product"]["CycleTime"],
                    data["product"]["Comment"]["PROGRESS"],
                    data["product"]["Comment"]["SCALE"]
                )
                cursor.execute(sql_insert_query_product, product_values)
                connection.commit()
                print("Product inserted successfully")
            else:
                print("Product not inserted")

            # Wstawianie statusu maszyny
            if data.get("MachineStatus") is not None:
                sql_insert_query_machine_status = (
                    "INSERT INTO machine_status (machineId, isOn, timestamp) "
                    "VALUES (%s, %s, CURRENT_TIMESTAMP)"
                )
                machine_status_values = (data["MachineID"], data["MachineStatus"][0])
                cursor.execute(sql_insert_query_machine_status, machine_status_values)
                connection.commit()
                print("Machine status inserted successfully")

            # Wstawianie rekordu do tabeli 'maszyny' jeśli OperatorID nie jest pusty
            if data.get("OperatorID", "") != "":
                sql_unique_machineid_query = "SELECT COUNT(*) FROM maszyny WHERE machineId = %s"
                unique_value = (data["MachineID"],)
                cursor.execute(sql_unique_machineid_query, unique_value)
                result_unique = cursor.fetchone()

                if result_unique[0] > 0:
                    print("Machine already exists")
                else:
                    sql_insert_query_maszyny = (
                        "INSERT INTO maszyny (id, machineId, operatorId) VALUES (NULL, %s, %s)"
                    )
                    values = (data["MachineID"], data["OperatorID"])
                    cursor.execute(sql_insert_query_maszyny, values)
                    connection.commit()

                    if cursor.rowcount > 0:
                        print("Record inserted successfully to maszyny")
                    else:
                        print("Record not inserted")

            cursor.close()
            connection.close()
            print("MySQL connection closed")
        except pymysql.MySQLError as e:
            print("MySQL Error:", e)
    else:
        print("No data received")

# Konfiguracja klienta MQTT
mqttc = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
mqttc.on_connect = on_connect
mqttc.on_message = on_message

mqttc.connect("broker.emqx.io", 1883, 60)
mqttc.loop_forever()