gs_parallel_scraping
====================

Some scripts that use gLite grid interface to scrap bibliographic records from AGRIS in Google Scholar and store PDF links in a MySQL database

login.sh
--------------------
- Script to initialize a proxy certificate for the VO, and delegate it to the WMS to long-term jobs

	./login.sh

update_files.sh
-------------------
- Script to remove the working ZIP of executables to submit to worker nodes, and update if modifications have been made to scraper/ directory contents.

	./update.sh

empty_db.sh
-------------------
- Empty target relational DB tables.

	./empty_db.sh <db-user> <db-pass> <db> <host> <port>

submit.sh
-------------------
- Script that submit jobs using 'glite-wms-submit-job' command for each offset value in AGRIS.

	./submit.sh

scraper.sh
-------------------
- The actual script that will be executed in the Worker Node. It gets the software package from the grid storage, prepares the MySQL tables, gets records from AGRIS to a text file, starts the selenium and phantomJS servers and executes the scraper JAR file.
