#!/bin/bash 

# Setup Discover-Flask
APP_SETTINGS="config.ProductionConfig"
export APP_SETTINGS



# create DB tables, set folder and file permissions
cd ./www/
python db_create_users.py
python db_create_posts.py
	
	
	
# run tests
pylint -f parseable project/ > pylint.out
nosetests --with-xcoverage --with-xunit --all-modules --traverse-namespace --cover-package=project --cover-inclusive --cover-erase -x tests.py > /dev/null
clonedigger --cpd-output -o clonedigger.xml project > /dev/null
sloccount --duplicates --wide --details . | fgrep -v .svn > sloccount.sc || :

exit 0;
