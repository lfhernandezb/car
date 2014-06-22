DIR=`dirname $0`

cd $DIR


/usr/bin/mysql -u root -ptoor --execute="drop database car;"
/usr/bin/mysql -u root -ptoor --default-character-set=latin1 < create.sql
/usr/bin/mysql -u root -ptoor --default-character-set=latin1 < users.sql
/usr/bin/mysql -u car -pcar car < ../data/geografico.sql
#/usr/bin/mysql -u car -pcar car < ../data/tipo_vehiculo.sql
/usr/bin/mysql -u car -pcar car < ../data/marca.sql
/usr/bin/mysql -u car -pcar car < ../data/modelo.sql
#/usr/bin/mysql -u car -pcar car < ../data/red_social.sql
#/usr/bin/mysql -u car -pcar car < ../data/combustible.sql
#/usr/bin/mysql -u car -pcar car < ../data/traccion.sql
#/usr/bin/mysql -u car -pcar car < ../data/tipo_transmision.sql
/usr/bin/mysql -u car -pcar car < ../data/usuario.sql
/usr/bin/mysql -u car -pcar car < ../data/autenticacion.sql
/usr/bin/mysql -u car -pcar car < ../data/vehiculo.sql
/usr/bin/mysql -u car -pcar car < ../data/mantencion_usuario.sql
/usr/bin/mysql -u car -pcar car < ../data/mantencion_usuario_hecha.sql
/usr/bin/mysql -u car -pcar car < ../data/recordatorio.sql
/usr/bin/mysql -u car -pcar car < ../data/carga_combustible.sql
/usr/bin/mysql -u car -pcar car < ../data/reparacion.sql

