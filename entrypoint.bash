cd /_
nginx -g "daemon off;" &
find source | entr -d make html
wait
