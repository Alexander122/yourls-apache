1. Install docker and docker-compose
2. Go to {BASE_PATH}/yourls-apache/
3. Run "sudo make build"
4. Run "sudo make init"
5. Go to "http://localhost:8080/admin/install.php" and click "install YOURLS"
6. You can find all urls in "http://localhost:8080/admin" (login: admin, password:pwd)

API examples:
make shorturl URL=http://test.lnk/?utm=test/ KEYWORD=test.lnk TITLE=Test\ link FORMAT=json
make expand SHORTURL=ozh FORMAT=json
make stats FILTER=top LIMIT=1 FORMAT=json
make db-stats FORMAT=json
