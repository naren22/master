!/bin/bash

cd "$(dirname $0)"

echo "starting catalina ..."
$CATALINA_HOME/bin/catalina.sh run
