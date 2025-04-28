# Kubernetes HTML App with Docker and Python Flask

This project demonstrates how to create a simple, responsive web application using **Python Flask**, **SQLite**, **Bootstrap**, and **Docker**, and how to push the Docker image to **Docker Hub** for further deployment.

---

## 📦 Project Structure

```
kubernetes-html-app/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── templates/
│       └── index.html
├── Dockerfile
└── README.md
```

---

## Application Files

### 1. `app.py`

Python Flask application serving an HTML page.
- Connects to a lightweight SQLite database.
- Tracks page visit counts.

```python
from flask import Flask, render_template
import sqlite3

app = Flask(__name__)

def init_db():
    conn = sqlite3.connect('data.db')
    c = conn.cursor()
    c.execute('CREATE TABLE IF NOT EXISTS visits (count INTEGER)')
    c.execute('INSERT INTO visits (count) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM visits)')
    conn.commit()
    conn.close()

@app.route('/')
def home():
    conn = sqlite3.connect('data.db')
    c = conn.cursor()
    c.execute('UPDATE visits SET count = count + 1')
    conn.commit()
    c.execute('SELECT count FROM visits')
    visit_count = c.fetchone()[0]
    conn.close()
    return render_template('index.html', visits=visit_count)

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=80)
```

### 2. `templates/index.html`

Responsive HTML page using Bootstrap 5.
- Displays visit counter dynamically.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Kubernetes Networking</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <div class="container text-center mt-5">
    <h1 class="mb-4">Connecting Applications with Services</h1>
    <h2 class="text-primary mb-3">The Kubernetes model for connecting containers</h2>
    <p class="lead">
      Now that you have a continuously running, replicated application you can expose it on a network.
    </p>
    <div class="alert alert-info mt-5">
      Page visited {{ visits }} times
    </div>
  </div>
</body>
</html>
```

### 3. `requirements.txt`

Python dependencies:

```
flask
```

(SQLite3 is built into Python — no need to install separately.)

---

Step 2: Create Dockerfile

Create a `Dockerfile` at the root of your project:

```Dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ .
EXPOSE 80
CMD ["python", "app.py"]
```

---

Step 3: Build and Push Docker Image to Docker Hub

### 1. Build Docker Image

```bash
docker build -t kubernetes-html-app .
```

### 2. Login to Docker Hub

```bash
docker login
```
(Enter your Docker Hub username and password when prompted.)

### 3. Tag Docker Image

Replace `yourdockerhubusername` with your actual Docker Hub username:

```bash
docker tag kubernetes-html-app yourdockerhubusername/kubernetes-html-app:latest
```

### 4. Push Docker Image

```bash
docker push yourdockerhubusername/kubernetes-html-app:latest
```


