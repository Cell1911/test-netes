import psycopg2
from os import getenv

def init_db():
    conn = psycopg2.connect(getenv('DATABASE_URL'))
    cur = conn.cursor()
    cur.execute('''
        CREATE TABLE IF NOT EXISTS visits (
            id SERIAL PRIMARY KEY,
            email VARCHAR(255),
            visit_time TIMESTAMP
        )
    ''')
    conn.commit()
    conn.close()

if __name__ == '__main__':
    init_db()

