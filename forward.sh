#/bin/bash

ports=""
for var in "$@"
do
    ports="$ports -R $var:localhost:$var"
    echo "Forwarding ports $var..."
done

ssh -p $LC_REVERSE_PORT $ports -N $LC_USER@localhost 