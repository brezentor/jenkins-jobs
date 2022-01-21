echo "=============system dockerfile build============"
cat <<EOF> Dockerfile
FROM ubuntu:16.04
RUN apt-get -y update
RUN apt-get -y install apache2
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
EXPOSE 80
EOF
sudo docker build -t testcont:$BUILD_ID .
sudo docker run -d -p 1233:80 testcont:$BUILD_ID
echo "==========end system config==============="

echo "=============build index============"
cat <<EOF> index1.html
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>DEPLOY FROM JENKINS</title>
  </head>
  <body>
	<br><br>
	<center><h1>INSHALLA</h1></center>
	<br><br>
	<center><h2>ALLAYAVBAR</h2></center>
    <br><br>
	<table>
		<tr>
			<td><h3>do sho tam</h3></td>
			<td><h3>ty sho daun</h3></td>
		</tr>
		<tr>
			<td><h3>odoshov</h3></td>
			<td><h3>bystree</h3></td>
		</tr>
		<tr>
			<td><h3>suka</h3></td>
			<td><h3>yak uebu blyad</h3></td>
		</tr>
	</table>
</body>
</html>
EOF

echo "==========end building index==============="

echo "=============build test============"
ls -la
loc=`pwd`
cat <<EOF> test.py
abuse_words = ["daun", "suka", "uebu", "blyad"]
change_words = {"daun": 'umnica', "suka": 'milaya', "uebu": 'pociomayu', "blyad": 'kotik'}
loc = ".//index1.html"
end = ".//index.html"
l = open(loc, mode="r")
e = open(end, mode="a")
re = l.readlines()
for i in re:
    for j in range(4):
        if (i.lower().find(abuse_words[j])):
            i = i.replace(abuse_words[j], '{i}'.format(i = change_words[abuse_words[j]]))
    e.write(i)
l.close()
e.close()
EOF
python test.py
ls -ls
echo "==========end building test==============="

echo "=============push testfile to docker============"
sudo docker ps
echo "==========end push testfile to docker==============="