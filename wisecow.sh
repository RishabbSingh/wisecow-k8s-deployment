#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response

rm -f $RSPFILE
mkfifo $RSPFILE

get_api() {
	read line
	echo $line
}

handleRequest() {
    # 1) Process the request
	get_api
	mod=`fortune`

cat <<EOF > $RSPFILE
HTTP/1.1 200


<pre>`cowsay $mod`</pre>
EOF
}

prerequisites() {
    command -v cowsay >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "cowsay not found"
        exit 1
    fi

    command -v fortune >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "fortune not found"
        exit 1
    fi

    echo "All prerequisites are installed."
}

main() {
	prerequisites
	echo "Wisdom served on port=$SRVPORT..."

	while [ 1 ]; do
		cat $RSPFILE | nc -lN $SRVPORT | handleRequest
		sleep 0.01
	done
}

main
