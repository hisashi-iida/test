import urllib.request as ur

url = 'http://avpro.global.yamaha.com/2018/test_scenario.txt'
conn = ur.urlopen(url)
print("HTTP status is ", conn.status)
if conn.status == 200:
    print("http get is success")
else:
    print("http get is failed")

for key, value in conn.getheaders():
    print(key, value)

print(conn.read())
