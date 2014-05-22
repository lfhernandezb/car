CREATE USER 'car'@'localhost' IDENTIFIED BY 'car';

GRANT ALL ON car.* TO 'car'@'localhost' IDENTIFIED BY 'car';

GRANT ALL ON car.* TO 'car'@'186.64.120.139' IDENTIFIED BY 'car';

GRANT ALL ON car.* TO 'car'@'192.168.1.115' IDENTIFIED BY 'car';

GRANT SELECT, INSERT, UPDATE, DELETE ON car.* TO 'car'@'localhost' IDENTIFIED BY 'car';

GRANT CREATE, DROP ON car.* TO 'car'@'localhost';

GRANT EXECUTE ON car.* TO 'car'@'localhost';

CREATE USER 'batchas'@'localhost' IDENTIFIED BY 'batchas';

grant SELECT on TABLE `amigo_seguro`.`umbral_usuario` to 'batchas'@'localhost';
grant DELETE on TABLE `amigo_seguro`.`notificacion` to 'batchas'@'localhost';

