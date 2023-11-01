USE company;

DROP PROCEDURE operation;
DELIMITER //
CREATE PROCEDURE operation(
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
CALL operation(1, 'employee', '*', null, null, null);

# UPDATE
CALL operation(2, 'employee', 'Salary', '29000', 'Ssn', '123455789');
SELECT * FROM employee WHERE ssn = '123455789';

# DELETE
CALL operation(3, 'dependent', NULL, NULL, 'Essn', '333448888');  # Já execultada
