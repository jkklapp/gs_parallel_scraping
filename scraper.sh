#!/bin/bash

SCRAPER_DIR=/grid/vo.aginfra.eu/aggsscraper

offset=$1
limit=$2

export LFC_HOST=lfc.ipb.ac.rs
#Downloads the input file from the grid to the worker node
lcg-cp lfn:/grid/vo.aginfra.eu/aggsscraper/aggsscraper.tar.gz file:aggsscraper.tar.gz
echo "Copying aggsscraper.tar.gz to WN storage. Error code: "$? 1>&2
tar xvf aggsscraper.tar.gz
python agris2scrapper.py ${offset} ${limit}
sed -i 's/queries/queries'$offset'/g' gsDatabase.sql
sed -i 's/resources/resources'$offset'/g' gsDatabase.sql
sed -i 's/>queries</>queries'$offset'</g' conf.xml
sed -i 's/>queries_result</>queries'$offset'_result</g' conf.xml
sed -i 's/>resources</>resources'$offset'</g' conf.xml
#mysql -u agdbuser -h aginfra.ipb.ac.rs -P 3333 agscraper < gsDatabase.sql
#netstat -plant |grep 8085
for p in `ps -A | grep selenium | awk '{print $1}'`;do
	kill $p
done
isSelenium=`ps -A | grep selenium | wc -l`
echo "isSelenium value is "${isSelenium} 1>&2
selenium=false
if [ ${isSelenium} -eq 0 ];then
	echo "Starting selenium..." 1>&2
	java -jar selenium-server-standalone-2.34.0.jar -role hub &
	sPid=$!
	selenium=true
fi
sleep 5
#netstat -plant |grep 4444
for p in `ps -A | grep phantomjs | awk '{print $1}'`;do
        kill $p
done
isPhantom=`ps -A | grep phantomjs | wc -l`
phantom=false
echo "isPhantom value is "${isPhantom} 1>&2
if [ ${isPhantom} -eq 0 ];then
	echo "Starting phantomJS..." 1>&2
	./phantomjs --webdriver=8085 --webdriver-selenium-grid-hub=http://127.0.0.1:4444 &
	pPid=$!
	phantom=true
fi
sleep 3
java -jar scraperGS-1.1-jar-with-dependencies.jar -configFilePath conf.xml -dataFilePath data.txt -noversions
#rm -rf selenium-server-standalone-2.35.0.jar scraperGS-1.1-jar-with-dependencies.jar agris2scrapper.py aggsscraper.tar.gz phantomjs conf.xml data.txt gsDatabase.sql
if ${selenium} ; then
	kill $sPid
fi
if ${phantom} ; then
	kill $pPid
fi
