echo "PRAGMA journal_mode = OFF;" > car.sql
sed -f script.sed ../../bd/scripts/create.sql >> car.sql
cat triggers.sql >> car.sql
#cat tablas_desde_vistas.sql >> car.sql
#cat vistas.sql >> car.sql
rm car_clean.db3 
cat car.sql | sqlite3 car_clean.db3
sed -f script.sed geografico.sql >> car.sql
sed -f script.sed tipo_vehiculo.sql >> car.sql
sed -f script.sed marca.sql >> car.sql
sed -f script.sed modelo.sql >> car.sql
sed -f script.sed mantencion_base.sql >> car.sql
echo "PRAGMA foreign_keys = ON;" >> car.sql
rm car.db3 
cat car.sql | sqlite3 car.db3

