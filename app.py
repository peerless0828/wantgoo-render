import time
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By

def get_data():
    options = Options()
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')

    driver = webdriver.Chrome(options=options)
    driver.get('https://www.wantgoo.com/index/000-')
    try:
        elem = driver.find_element(By.XPATH, '/html/body/div[1]/main/div/div[1]/div[2]/div[1]/span[1]')
        return elem.text
    except Exception as e:
        return f"錯誤: {e}"
    finally:
        driver.quit()

def main():
    start = datetime.strptime('09:00', '%H:%M').time()
    end = datetime.strptime('13:30', '%H:%M').time()
    while True:
        now = datetime.now().time()
        if start <= now <= end:
            print(f"{datetime.now()} 抓取：{get_data()}")
            time.sleep(300)
        else:
            print(f"{datetime.now()} 結束執行")
            break

if __name__ == '__main__':
    main()
