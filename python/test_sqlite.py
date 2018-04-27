import sqlite3

conn = sqlite3.connect('mydb.db')
curs = conn.cursor()
sql='create table if not exists zoo (critter VARCHAR(20) PRIMARY KEY, count INT, damages FLOAT)'
curs.execute(sql)
sql='insert or replace into zoo values(?, ?, ?)'
curs.execute(sql, ('weasel', 3, 2000.0))
curs.execute(sql, ('hogehoge', 3, 2000.0))
sql='select * from zoo'
curs.execute(sql)
dump=curs.fetchall()
print(dump)
curs.close()
conn.close()