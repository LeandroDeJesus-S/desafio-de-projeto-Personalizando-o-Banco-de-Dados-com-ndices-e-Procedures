USE company;

# criei o index para o atributo Dno na tabela employee
# pois ele foi o atributo com maior uso durante as queries
# juntamente com Dnumber de 'departament' que já é um index 
# por ser primary key e acredito ser o suficiente para as
# perguntas levantadas.
ALTER TABLE employee ADD INDEX idx_employee_dno (Dno);
SHOW INDEX FROM employee;
SHOW INDEX FROM departament;

# Qual o departamento com maior número de pessoas? 
SELECT d.Dnumber, count(*) n_people 
FROM departament d
	INNER JOIN employee e ON d.Dnumber = e.Dno
    GROUP BY d.Dnumber;

# Quais são os departamentos por cidade?
SELECT d.Dnumber, e.address 
FROM departament d
	INNER JOIN employee e ON d.Dnumber = e.Dno
    GROUP BY e.address;

# Relação de empregrados por departamento 
SELECT d.Dnumber, e.Fname, e.Super_ssn FROM departament d
	INNER JOIN employee e ON d.Dnumber = e.Dno
    WHERE e.Super_ssn is not null
    GROUP BY e.Fname;
