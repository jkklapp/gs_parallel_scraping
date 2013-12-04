#!/bin/bash

#Job submitter code

#if [ $# -ne 3 ]; then
#	echo "usage: ./submit.sh <begin-offset> <end-offset> <limit>"
#	exit 1
#fi

INPUT_DIR=/grid/vo.aginfra.eu/aggsscraper_input_data
#SCHEMA=/grid/vo.semagrow.eu/convertor/schemas/
#SCHEMA=lom.xslt
#rm -f job-ids-scrap.txt
export LFC_HOST=lfc.ipb.ac.rs

file=scraper

#voms-proxy-init -voms vo.aginfra.eu
#myproxy-init -d -n
#glite-wms-job-delegate-proxy -a
#./login.sh


for offset in {14300..100000..100}
do 
  echo "[" > ${file}.jdl
  echo "Type = \"Job\";" >> ${file}.jdl
  echo "Executable = \"scraper.sh\";" >> ${file}.jdl
  echo "Arguments = \"${offset} 100\";" >> ${file}.jdl
  echo "StdOutput = \"std.out\";" >> ${file}.jdl
  echo "StdError = \"std.err\";" >> ${file}.jdl
  echo "InputSandbox = {\"scraper.sh\"};" >> ${file}.jdl
  echo "OutputSandbox = {\"std.out\",\"std.err\",\"scrap-output.tar.gz\"};" >> ${file}.jdl
  echo "Requirements =  RegExp(\"cream.ipb.ac.rs*\",other.GlueCEUniqueID);" >> ${file}.jdl
  echo "]" >> ${file}.jdl
  echo "Submitting job for offset ${offset}"
  glite-wms-job-submit -a -o job-ids-scrap.txt ${file}.jdl
  sleep 300
done
rm scraper.jdl
#cat job-ids-scrap.txt |grep http://wms.ipb.ac.rs:9000 > ids.txt
#mv ids.txt job-ids-scrap.txt
