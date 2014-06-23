echo "PRAGMA foreign_keys = ON;" > car.sql
sed -f script.sed ../../bd/scripts/create.sql >> car.sql
#cat tablas_desde_vistas.sql >> car.sql
cat geografico.sql >> car.sql
cat marca.sql >> car.sql
cat modelo.sql >> car.sql
cat triggers.sql >> car.sql
#cat vistas.sql >> car.sql
rm car_clean.db3 
cat car.sql | sqlite3 car_clean.db3
cp car_clean.db3 car.db3
