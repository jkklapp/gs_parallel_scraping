#!/bin/sh
cd scraper
rm -f aggsscraper.tar.gz
tar cvzf aggsscraper.tar.gz agris2scrapper.py conf.xml gsDatabase.sql phantomjs scraperGS-1.1-jar-with-dependencies.jar selenium-server-standalone-2.34.0.jar
lfc-rm -fa /grid/vo.aginfra.eu/aggsscraper/aggsscraper.tar.gz
lcg-cr -l /grid/vo.aginfra.eu/aggsscraper/aggsscraper.tar.gz aggsscraper.tar.gz
cd ..
