import schedule
import time
import pymysql
import os
from dotenv import load_dotenv

load_dotenv()

def insert_daily_data():
  try:
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
              FROM produkty
              WHERE status IN (1, 2, 3) AND DATE(timestamp) = CURRENT_DATE()
            ) AS quality,
            (
              SELECT
                ROUND(
                  (SELECT (COUNT(*) * 20) / 3600 FROM machine_status
                    WHERE isOn = 1 AND DATE(timestamp) = CURRENT_DATE()) 
                  /
                  (SELECT (COUNT(*) * 20) / 3600 FROM machine_status
                    WHERE DATE(timestamp) = CURRENT_DATE()), 
                  2
                )
            ) AS availability,
            (
              SELECT
                ROUND(AVG(COALESCE(scale, 0)) / 100, 2)
              FROM produkty
              WHERE DATE(timestamp) = CURRENT_DATE()
            ) AS effectiveness;
      """
      
      cursor.execute(sqlInsertDailyData)
      connection.commit()
      print("Insert successful")
      cursor.close()
      
  except Exception as e:
      print("Error inserting daily data:", e)
      
  finally:
      try:
          connection.close()
          print("Connection closed")
      except Exception as e:
          print("Error closing connection:", e)

schedule.every().day.at("23:00").do(insert_daily_data)

while True:
    print("Running schedule")
    schedule.run_pending()
    time.sleep(1)
