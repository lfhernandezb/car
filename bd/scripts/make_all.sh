DIR=`dirname $0`

cd $DIR


/usr/bin/mysql -u root -p --execute="drop database car;"
/usr/bin/mysql -u root -p --default-character-set=latin1 < create.sql
/usr/bin/mysql -u root -p --default-character-set=latin1 < users.sql
/usr/bin/mysql -u root -p --default-character-set=latin1 -D amigo_seguro < /home/lfhernandez/java/ASDaemon/bd/scripts/sp.sql
/usr/bin/mysql -u root -p --default-character-set=latin1 -D amigo_seguro --execute="call carga_datos();"
