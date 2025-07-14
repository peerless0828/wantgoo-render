FROM python:3.9-slim

RUN apt-get update && apt-get install -y wget gnupg unzip curl

# 安裝 Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# 安裝 chromedriver（自動對應 Chrome 版本）
RUN CHROME_VER=$(google-chrome --product-version | grep -o "[0-9]\+\.[0-9]\+\.[0-9]\+") && \
    DRIVER_VER=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VER") && \
    wget -q -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/$DRIVER_VER/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && chmod +x /usr/local/bin/chromedriver

WORKDIR /app
COPY requirements.txt app.py ./
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "app.py"]
