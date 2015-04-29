DIR=`dirname $0`

cd $DIR


/usr/bin/mysql -u root -ptoor --execute="drop database car2;"
/usr/bin/mysql -u root -ptoor --default-character-set=latin1 < create.sql
/usr/bin/mysql -u root -ptoor --default-character-set=latin1 < users.sql
echo "datos geograficos"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/geografico.sql
echo "tipo_vehiculo"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/tipo_vehiculo.sql
echo "marca"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/marca.sql
echo "modelo"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/modelo.sql
#/usr/bin/mysql -u car -pcar car < ../data/red_social.sql
#/usr/bin/mysql -u car -pcar car < ../data/combustible.sql
#/usr/bin/mysql -u car -pcar car < ../data/traccion.sql
#/usr/bin/mysql -u car -pcar car < ../data/tipo_transmision.sql
#echo "usuario"
#/usr/bin/mysql -u car -pcar car < ../data/usuario.sql
#echo "autenticacion"
#/usr/bin/mysql -u car -pcar car < ../data/autenticacion.sql
#echo "vehiculo"
#/usr/bin/mysql -u car -pcar car < ../data/vehiculo.sql
#echo "mantencion_usuario"
#/usr/bin/mysql -u car -pcar car < ../data/mantencion_usuario.sql
echo "mantencion_base"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/mantencion_base.sql
echo "cambio_revision"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/cambio_revision.sql
echo "proveedor"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/proveedor.sql
echo "proveedor_mantencion_base"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/proveedor_mantencion_base.sql
#echo "mantencion_usuario_hecha"
#/usr/bin/mysql -u car -pcar car < ../data/mantencion_usuario_hecha.sql
#echo "recordatorio"
#/usr/bin/mysql -u car -pcar car < ../data/recordatorio.sql
#echo "carga_combustible"
#/usr/bin/mysql -u car -pcar car < ../data/carga_combustible.sql
#echo "reparacion"
#/usr/bin/mysql -u car -pcar car < ../data/reparacion.sql
echo "cia_seguros"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/cia_seguros.sql
echo "parametro"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/parametro.sql
echo "usuario_web"
/usr/bin/mysql -u car2 -pcar2 car2 < ../data/usuario_web.sql
#
# respaldos utiles para generar la bd sqlite
#
/usr/bin/mysqldump --opt --skip-extended-insert -u car2 -pcar2 car2 tipo_vehiculo | grep -E "^INSERT" > ../../mobile/bd/tipo_vehiculo.sql
/usr/bin/mysqldump --opt --skip-extended-insert -u car2 -pcar2 car2 marca | grep -E "^INSERT" > ../../mobile/bd/marca.sql
/usr/bin/mysqldump --opt --skip-extended-insert -u car2 -pcar2 car2 modelo | grep -E "^INSERT" > ../../mobile/bd/modelo.sql
/usr/bin/mysqldump --opt --skip-extended-insert -u car2 -pcar2 car2 mantencion_base | grep -E "^INSERT" > ../../mobile/bd/mantencion_base.sql
/usr/bin/mysqldump --opt --skip-extended-insert -u car2 -pcar2 car2 cambio_revision | grep -E "^INSERT" > ../../mobile/bd/cambio_revision.sql
/usr/bin/mysqldump --opt --skip-extended-insert -u car2 -pcar2 car2 cambio_revision | grep -E "^INSERT" > ../../mobile/bd/cambio_revision.sql
/usr/bin/mysqldump --opt --skip-extended-insert -u car2 -pcar2 car2 cia_seguros | grep -E "^INSERT" > ../../mobile/bd/cia_seguros.sql
/usr/bin/mysqldump --opt --skip-extended-insert -u car2 -pcar2 car2 parametro | grep -E "^INSERT" > ../../mobile/bd/parametro.sql
#/usr/bin/mysqldump --opt --skip-extended-insert -u car -pcar car perfil_uso | grep -E "^INSERT" > ../../mobile/bd/perfil_uso.sql
#/usr/bin/mysqldump --opt --skip-extended-insert -u car -pcar car tipo_seguro | grep -E "^INSERT" > ../../mobile/bd/tipo_seguro.sql

