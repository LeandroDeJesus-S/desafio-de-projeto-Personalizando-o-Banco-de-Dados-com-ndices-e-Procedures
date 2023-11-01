USE ecommerce;
show tables;

select * from product;
show index from product;

ALTER TABLE product CHANGE Description Pname varchar(100);

# Full text index para o nome do produto para agilizar a 
# busca pelos nomes dos produtos.
CREATE FULLTEXT INDEX idx_product_name ON product (Pname);

# index criado para os valores dos produtos que tambem
# é um dado muito requisitado.
CREATE INDEX idx_product_price ON product (Price);

# index para a categoria que pode ser uma boa ao realizar
# buscas de filtrage e/ou ordenação por categoria 
CREATE INDEX idx_pdt_category ON product (Category);

-- Quais são as categorias de produtos mais pedidos?
SELECT
	p.Category, count(*) quantity
FROM purchaseorder po
	INNER JOIN ordertoproduct op USING(IdOrder)
    INNER JOIN product p USING(IdProduct)
    WHERE po.Status != 'Cancelado'
    GROUP BY p.Category;

-- Historico de pedidos de um cliente
SELECT 
	po.IdClientFP, p.Pname, p.Price, p.Category, po.Status
FROM purchaseorder po
	INNER JOIN ordertoproduct op USING(IdOrder)
    INNER JOIN product p USING(IdProduct)
    ORDER BY po.IdClientFP
;

-- quais categorias de produtos com baixo estoque?
SELECT 
	p.IdProduct, p.Category, p.Pname, sum(ps.Quantity) stock
FROM product p
	INNER JOIN productstocked ps USING (IdProduct)
    GROUP BY p.Category
    HAVING stock < 100;

-- receita total
SELECT 
	sum(p.Price) Receita
FROM purchaseorder po
	INNER JOIN ordertoproduct op USING(IdOrder)
    INNER JOIN product p USING(IdProduct)
WHERE po.Status in ('Confirmado', 'Entregue');

-- FULLTEXT SEARCH POR ARROZ
SELECT 
	*
FROM product
WHERE MATCH (Pname) AGAINST ('Arroz' IN BOOLEAN MODE);

-- PRODUTOS ENTRE 100 E 500 ORDENADO DO MAIOR PARA O MENOR
SELECT
	*
FROM product
WHERE Price BETWEEN 100 AND 500
ORDER BY price ASC;
