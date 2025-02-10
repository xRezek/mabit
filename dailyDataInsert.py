import schedule
import time
import mysql.connector as mysql
import os
from dotenv.main import load_dotenv

load_dotenv()


def insert_daily_data():
  connection = mysql.connect(
    host=os.getenv("DB_HOST"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    database=os.getenv("DB_DATABASE")
  )
  sqlInsertDailyData = """
    INSERT INTO daily_data (date, quality, availability, effectiveness)
    SELECT
      CURRENT_DATE() as date,
      (
        SELECT 
          ROUND(
            SUM(CASE WHEN status = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 
            2
          ) 
        FROM `produkty`
        WHERE status IN (1, 2, 3) AND DATE(timestamp) = CURRENT_DATE()
      ) AS quality,
      (
        SELECT
          ROUND(
            (SELECT (COUNT(*) * 20) / 3600 FROM machine_status
            WHERE isOn = 1 AND DATE(timestamp) = CURRENT_DATE()) 
            /
            (SELECT (COUNT(*) * 20) / 3600 FROM machine_status
            WHERE DATE(timestamp) = CURRENT_DATE()), 2
          )
      ) AS availability,
      (
        SELECT
          ROUND(AVG(COALESCE(scale, 0)) / 100, 2) AS effectiveness
        FROM `produkty`
        WHERE DATE(timestamp) = CURRENT_DATE()
      ) AS effectiveness;
  """
  
  if connection.is_connected():
    print("Connected to MySQL Server")
    mysql_cursor = connection.cursor()
    mysql_cursor.execute(sqlInsertDailyData)
    connection.commit()
    print("Insert successfull")
    mysql_cursor.close()
  else:
    print("Connection error")
  connection.close()


schedule.every().day.at("22:04").do(insert_daily_data)

while True:
  schedule.run_pending()
  time.sleep(1)