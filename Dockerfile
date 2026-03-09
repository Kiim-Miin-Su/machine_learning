FROM python:3.12

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["jupyter", "lab", "--port", "8888", "--ip", "0.0.0.0", "--no-browser"]