from datetime import datetime
import mysql.connector as mysql 


sum = 0

mysql_connection = mysql.connect(
  host="sql7.freesqldatabase.com",
  user="sql7756592",
  password="3pUyiJRjCG",
  database="sql7756592"
)
mysql_cursor = mysql_connection.cursor()
if mysql_connection.is_connected():
  sql_select_machine_status = "SELECT machineId, timestamp FROM machine_status WHERE isOn = 1 AND machineId = %s AND EXTRACT(DAY FROM timestamp) = 16"
  machineId = ("1103_05_UA",)
  mysql_cursor.execute(sql_select_machine_status, machineId)
  result = mysql_cursor.fetchall()


  for i in range(len(result) - 1):
    if i % 2 == 0:
      print(result[i][1])
      print(result[i+1][1])
      difference = result[i+1][1] - result[i][1]
      print("Różnica:", difference)
      print("W sekundach:", difference.total_seconds())
      sum += difference.total_seconds()

print("\n\n")
print("Suma:", sum)




# # Konwersja na obiekty datetime
# format = "%Y-%m-%d %H:%M:%S"
# datetime1 = datetime.strptime(timestamp1, format)
# datetime2 = datetime.strptime(timestamp2, format)

# # Obliczenie różnicy
# difference = datetime2 - datetime1

# # Wynik w dniach, sekundach lub całkowitej liczbie sekund
# print("Różnica:", difference)                # np. 0:04:45 (4 minuty, 45 sekund)
# print("W sekundach:", difference.total_seconds())  # Całkowita liczba sekund
