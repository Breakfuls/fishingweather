#!/bin/bash

URL="https://forecast.weather.gov/shmrn.php?mz=amz254&syn=amz200"
curl -O ${URL} &> /dev/null

HTML=$(ls -ltr | grep shmrn.php | tail -1 | awk {'print $9'}) 

STARTLINE=$(grep -n 'Coastal waters from Little River' ${HTML} | cut -d : -f 1)
ENDLINE=$(grep -n '&nbsp;\$\$' ${HTML} | cut -d : -f 1 | tail -1)

sed -n ${STARTLINE},${ENDLINE}p ${HTML} > ${HTML}.tmp
sed 's/<strong.*">//g' ${HTML}.tmp | sed 's/&nbsp;//g' | sed 's/<.*ong>//g' | grep -v \$\$ 

rm -f ${HTML}.tmp
rm -f ${HTML}
