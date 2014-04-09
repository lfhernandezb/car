echo "PRAGMA foreign_keys = ON;" > car.sql
sed -f script.sed ../../bd/scripts/create.sql >> car.sql
#cat tablas_desde_vistas.sql >> car.sql
#cat triggers.sql >> car.sql
#cat vistas.sql >> car.sql
rm car.db3 
cat car.sql | sqlite3.exe car_clean.db3
