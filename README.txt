1. Go to "http://localhost:8080/admin/install.php" and click "install YOURLS"
2. You can fild all urls in "http://localhost:8080"

API examples:
make shorturl URL=http://test.lnk/?utm=test/ KEYWORD=test.lnk TITLE=Test\ link FORMAT=json
make expand SHORTURL=ozh FORMAT=json
make stats FILTER=top LIMIT=1 FORMAT=json
make db-stats FORMAT=json
