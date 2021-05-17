cd /_
nginx -g "daemon off;" &
find source | entr sh -c "make html && echo Running at http://localhost:12800"
wait
