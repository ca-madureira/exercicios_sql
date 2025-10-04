CREATE TABLE Cardapio (
    codigo_cardapio INT PRIMARY KEY,
    nome_cafe VARCHAR(100) UNIQUE NOT NULL,
    descricao TEXT,
    preco_unitario DECIMAL(10,2) NOT NULL
);

CREATE TABLE Comanda (
    codigo_comanda INT PRIMARY KEY,
    data DATE NOT NULL,
    mesa INT NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL
);

CREATE TABLE ItemComanda (
    codigo_comanda INT,
    codigo_cardapio INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (codigo_comanda, codigo_cardapio),
    FOREIGN KEY (codigo_comanda) REFERENCES Comanda(codigo_comanda),
    FOREIGN KEY (codigo_cardapio) REFERENCES Cardapio(codigo_cardapio)
);

INSERT INTO Cardapio VALUES
(1, 'Expresso', 'Café forte e curto', 5.00),
(2, 'Cappuccino', 'Café com leite e espuma', 7.50),
(3, 'Latte', 'Café com leite vaporizado', 6.50),
(4, 'Mocha', 'Café com chocolate e leite', 8.00);

INSERT INTO Comanda VALUES
(101, '2025-10-01', 5, 'João Silva'),
(102, '2025-10-01', 3, 'Maria Souza'),
(103, '2025-10-02', 2, 'Carlos Lima');

INSERT INTO ItemComanda VALUES
(101, 1, 2),
(101, 2, 1),
(102, 3, 1),
(103, 2, 2),
(103, 4, 1);

SELECT nome_cafe, descricao, preco_unitario
FROM Cardapio
ORDER BY nome_cafe;

SELECT 
    Comanda.codigo_comanda,
    Comanda.data,
    Comanda.mesa,
    Comanda.nome_cliente,
    Cardapio.nome_cafe,
    Cardapio.descricao,
    ItemComanda.quantidade,
    Cardapio.preco_unitario,
    (ItemComanda.quantidade * Cardapio.preco_unitario) AS preco_total_cafe
FROM Comanda
JOIN ItemComanda ON Comanda.codigo_comanda = ItemComanda.codigo_comanda
JOIN Cardapio ON ItemComanda.codigo_cardapio = Cardapio.codigo_cardapio
ORDER BY Comanda.data, Comanda.codigo_comanda, Cardapio.nome_cafe;

SELECT 
    Comanda.codigo_comanda,
    Comanda.data,
    Comanda.mesa,
    Comanda.nome_cliente,
    SUM(ItemComanda.quantidade * Cardapio.preco_unitario) AS valor_total_comanda
FROM Comanda
JOIN ItemComanda ON Comanda.codigo_comanda = ItemComanda.codigo_comanda
JOIN Cardapio ON ItemComanda.codigo_cardapio = Cardapio.codigo_cardapio
GROUP BY Comanda.codigo_comanda, Comanda.data, Comanda.mesa, Comanda.nome_cliente
ORDER BY Comanda.data;

SELECT 
    Comanda.codigo_comanda,
    Comanda.data,
    Comanda.mesa,
    Comanda.nome_cliente,
    SUM(ItemComanda.quantidade * Cardapio.preco_unitario) AS valor_total_comanda
FROM Comanda
JOIN ItemComanda ON Comanda.codigo_comanda = ItemComanda.codigo_comanda
JOIN Cardapio ON ItemComanda.codigo_cardapio = Cardapio.codigo_cardapio
GROUP BY Comanda.codigo_comanda, Comanda.data, Comanda.mesa, Comanda.nome_cliente
HAVING COUNT(DISTINCT ItemComanda.codigo_cardapio) > 1
ORDER BY Comanda.data;

SELECT 
    Comanda.data,
    SUM(ItemComanda.quantidade * Cardapio.preco_unitario) AS faturamento_total
FROM Comanda
JOIN ItemComanda ON Comanda.codigo_comanda = ItemComanda.codigo_comanda
JOIN Cardapio ON ItemComanda.codigo_cardapio = Cardapio.codigo_cardapio
GROUP BY Comanda.data
ORDER BY Comanda.data;
