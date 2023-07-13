# Используйте базовый образ Python
FROM python:3.7

# Установите Google Chrome
RUN apt-get update && apt-get install -y wget --no-install-recommends \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y google-chrome-stable --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Установите ChromeDriver
RUN apt-get update && apt-get install -y chromedriver

# Установите зависимости Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Укажите переменную окружения PATH
ENV PATH="/usr/bin:${PATH}"

# Скопируйте ваше приложение в контейнер
COPY . /app
WORKDIR /app

# Укажите команду запуска вашего приложения
CMD ["python", "LinkBot.py"]
