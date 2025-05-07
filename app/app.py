from flask import Flask, render_template
import os
import psycopg2

app = Flask(__name__)

def init_db():
    conn = psycopg2.connect(os.getenv('DATABASE_URL'))
    cursor = conn.cursor()
    cursor.execute('CREATE TABLE IF NOT EXISTS visits (count INTEGER)')
    cursor.execute('INSERT INTO visits (count) SELECT 0 WHERE NOT EXISTS (SELECT 1 FROM visits)')
    conn.commit()
    conn.close()

init_db()

@app.route('/')
def home():
    conn = psycopg2.connect(os.getenv('DATABASE_URL'))
    cursor = conn.cursor()
    cursor.execute('UPDATE visits SET count = count + 1')
    conn.commit()
    cursor.execute('SELECT count FROM visits')
    visit_count = cursor.fetchone()[0]
    conn.close()
    return render_template('index.html', visits=visit_count)


