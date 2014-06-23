DIR=`dirname $0`

cd $DIR


/usr/bin/mysql -u root -ptoor --execute="drop database car;"
/usr/bin/mysql -u root -ptoor --default-character-set=latin1 < create.sql
/usr/bin/mysql -u root -ptoor --default-character-set=latin1 < users.sql
echo "datos geograficos"
/usr/bin/mysql -u car -pcar car < ../data/geografico.sql
#/usr/bin/mysql -u car -pcar car < ../data/tipo_vehiculo.sql
echo "marca"
/usr/bin/mysql -u car -pcar car < ../data/marca.sql
echo "modelo"
/usr/bin/mysql -u car -pcar car < ../data/modelo.sql
#/usr/bin/mysql -u car -pcar car < ../data/red_social.sql
#/usr/bin/mysql -u car -pcar car < ../data/combustible.sql
#/usr/bin/mysql -u car -pcar car < ../data/traccion.sql
#/usr/bin/mysql -u car -pcar car < ../data/tipo_transmision.sql
echo "usuario"
/usr/bin/mysql -u car -pcar car < ../data/usuario.sql
echo "autenticacion"
/usr/bin/mysql -u car -pcar car < ../data/autenticacion.sql
echo "vehiculo"
/usr/bin/mysql -u car -pcar car < ../data/vehiculo.sql
echo "mantencion_usuario"
/usr/bin/mysql -u car -pcar car < ../data/mantencion_usuario.sql
echo "mantencion_usuario_hecha"
/usr/bin/mysql -u car -pcar car < ../data/mantencion_usuario_hecha.sql
echo "recordatorio"
/usr/bin/mysql -u car -pcar car < ../data/recordatorio.sql
echo "carga_combustible"
/usr/bin/mysql -u car -pcar car < ../data/carga_combustible.sql
echo "reparacion"
/usr/bin/mysql -u car -pcar car < ../data/reparacion.sql
/usr/bin/mysqldump --opt -u car -pcar car marca | grep -E "^INSERT" > ../../mobile/bd/marca.sql
/usr/bin/mysqldump --opt -u car -pcar car modelo | grep -E "^INSERT" > ../../mobile/bd/modelo.sql

