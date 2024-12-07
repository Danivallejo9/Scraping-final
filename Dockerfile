# Usa una imagen base de Python
FROM python:3.10-slim

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    gnupg \
    && apt-get clean

# Instala Google Chrome
RUN wget -q -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome.deb && \
    rm google-chrome.deb

# Instala ChromeDriver
RUN CHROMEDRIVER_VERSION=$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE) && \
    wget -q -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver.zip

# Copia los archivos del proyecto al contenedor
COPY . /app
WORKDIR /app

# Instala las dependencias de Python desde requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Comando para ejecutar tu script principal
CMD ["python", "scraping_ebay.py"]
