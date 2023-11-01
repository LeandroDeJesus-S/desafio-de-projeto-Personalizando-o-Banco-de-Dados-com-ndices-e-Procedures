USE ecommerce;

DELIMITER //
CREATE PROCEDURE operation_ecommerce_product(
	IN option_ INT,
    IN table_name VARCHAR(50),
    IN columns VARCHAR(40),
    IN values_ VARCHAR(100),
    IN where_col VARCHAR(40),
    IN where_val VARCHAR(40)
)
BEGIN
	CASE option_
		WHEN 1 THEN
			SET @CMD = concat('SELECT ', columns, 'FROM ', table_name, ';');
			PREPARE stmt FROM @CMD;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            
        WHEN 2 THEN
			SET @CMD = concat('UPDATE ', table_name, ' SET ', columns, ' = ', values_, ' WHERE ', where_col, ' = ', where_val, ';');
            PREPARE stmt FROM @CMD;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            
        WHEN 3 THEN
			SET @CMD = concat('DELETE FROM ', table_name, ' WHERE ', where_col, '="', where_val, '";');
            PREPARE stmt FROM @CMD;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
            
		ELSE
			SELECT 'Argumento inválido! argumentos validos: 1, 2, 3' AS msg;
            
	END CASE;
END
//
DELIMITER ;

# SELECT
CALL operation_ecommerce_product(1, 'product', '*', null, null, null);

# UPDATE
CALL operation_ecommerce_product(2, 'product', 'Price', '6.99', 'IdProduct', '8');
SELECT * FROM product WHERE IdProduct = 8;

# DELETE
CALL operation_ecommerce_product(3, 'clientfp', NULL, NULL, 'IdClientFP', '10');
SELECT * FROM clientfp WHERE IdClientFP = 10;
