s/`//g
s/\([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]\)\.[0-9]*/\1/g
s/\tMATCH SIMPLE//g
s/\tNOT DEFERRABLE//g
s/SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;//g
s/SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;//g
s/SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';//g
s/SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';//g
s/CREATE SCHEMA IF NOT EXISTS .* DEFAULT CHARACTER .*;//g
s/^USE .* *;//g
s/ENGINE = InnoDB//g
s/SET SQL_MODE=@OLD_SQL_MODE;//g
s/SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;//g
s/SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;//g
s/ AUTO_INCREMENT//g
s/'::character varying/'/g
s/TINYINT(1)/BOOLEAN/g
s/BIT(1)/BOOLEAN/g
s/ DEFAULT CURRENT_TIMESTAMP/ DEFAULT (datetime('now', 'localtime'))/g
s/ DEFAULT now()/ DEFAULT (datetime('now', 'localtime'))/g
s/SET client_encoding = 'UTF8';//g
s/SET check_function_bodies = 0;//g
s/SELECT pg_catalog\.setval('[a-z_]*_seq', [0-9]*, 0);//g
s/CONSTRAINT [a-zA-Z0-9_]* PRIMARY KEY/PRIMARY KEY/g
s/CONSTRAINT [a-zA-Z0-9_]* FOREIGN KEY/FOREIGN KEY/g
s/CONSTRAINT [a-zA-Z0-9_]* CHECK(.*),//g
s/^DROP .*//g
s/^ALTER .*//g
s/^GRANT .*//g
s/^-- .*//g
s/^CREATE TRIGGER .*//g
s/ON .* FOR EACH ROW//g
s/EXECUTE PROCEDURE .*//g
s/::bpchar//g
s/int8/LONG/g
s/WITH (//g
s/	OIDS = 0//g
s/^)$//g
s/ON DELETE NO ACTION//g
s/ON UPDATE NO ACTION//g
s/ USING BTREE//g
s/AUTO_INCREMENT = [0-9]*//g
s/b'0'/'false'/g
s/b'1'/'true'/g
s/'0'/'false'/g
s/'1'/'true'/g
s/START TRANSACTION;//g
s/COMMIT;//g
s/COMMENT '.*'//g
#s/true/'true'/g
#s/false/'false'/g
s/`//g
s/DEFAULT CHARACTER SET = [a-zA-Z0-9_]*//g
s/COLLATE = [a-zA-Z0-9_]*//g
