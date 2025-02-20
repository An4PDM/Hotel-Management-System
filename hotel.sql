CREATE DATABASE hotel;
USE hotel;

CREATE TABLE cliente (
	idC INT PRIMARY KEY AUTO_INCREMENT,
    cpf CHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    data_nascimento DATE NOT NULL,
    estado_civil ENUM('Casado','Solteiro','Viúvo')
);

CREATE TABLE endereco (
	idE INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(45),
    bairro VARCHAR(45),
    cidade VARCHAR(45),
    sigla_estado CHAR(2),
    pais VARCHAR(45)
);

CREATE TABLE contato (
	idCo INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('e-mail', 'telefone'),
    contato VARCHAR(45)
);

CREATE TABLE quarto (
	idQ INT PRIMARY KEY AUTO_INCREMENT,
    tamanho ENUM('15m x 15m','24m x 24m') NOT NULL,
    andar ENUM('Terreo','1','2','3','4','5') NOT NULL,
	quantid_cama ENUM ('1','2','3') NOT NULL
);

DROP TABLE quarto;

CREATE TABLE reserva (
	idR INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,2) NOT NULL,
    modo_pagamento ENUM('Dinheiro','Cartão de Débito','Cartão de Crédito','Cheque'),
    status ENUM('Pendente','Em andamento','Confirmado'),
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    idCliente INT NOT NULL,
    CONSTRAINT fk_cliente_reserva FOREIGN KEY (idCliente) REFERENCES cliente(idC)
);

CREATE TABLE reserva_quarto (
	idR INT,
    idQ INT,
    PRIMARY KEY(idR,idQ),
    CONSTRAINT fk_reserva_reserva_quarto FOREIGN KEY (idR) REFERENCES reserva(idR),
    CONSTRAINT fk_quarto_reserva_quarto FOREIGN KEY (idQ) REFERENCES quarto(idQ)
);

DROP TABLE reserva_quarto;

CREATE TABLE cliente_endereco (
	idC INT,
    idE INT,
    PRIMARY KEY(idC,idE),
    CONSTRAINT fk_cliente_cliente_endereco FOREIGN KEY (idC) REFERENCES cliente(idC),
    CONSTRAINT fk_endereco_cliente_endereco FOREIGN KEY (idE) REFERENCES endereco(idE)
);

CREATE TABLE cliente_contato (
	idC INT,
    idCo INT,
    PRIMARY KEY (idC,idCo),
    CONSTRAINT fk_cliente_cliente_contato FOREIGN KEY (idC) REFERENCES cliente(idC),
    CONSTRAINT fk_contato_cliente_contato FOREIGN KEY (idCo) REFERENCES contato(idCo)
);

CREATE TABLE cupom (
	idCupom INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,2) NOT NULL,
    data_expiracao DATE NOT NULL,
    status ENUM('Aplicado','Não aplicado') NOT NULL DEFAULT ('Não aplicado'),
    idCliente INT NOT NULL,
    idReserva INT,
    CONSTRAINT fk_cupom_cliente FOREIGN KEY (idCliente) REFERENCES cliente(idC),
    CONSTRAINT fk_cupom_reserva FOREIGN KEY (idReserva) REFERENCES reserva(idR)
);

-- Inserção de dados
-- Inserindo clientes
INSERT INTO cliente (cpf, nome, sobrenome, data_nascimento, estado_civil) VALUES
('12345678901', 'João', 'Silva', '1985-07-20', 'Casado'),
('98765432100', 'Maria', 'Oliveira', '1990-05-15', 'Solteiro'),
('55566677788', 'Carlos', 'Santos', '1978-12-10', 'Viúvo'),
('11122233344', 'Ana', 'Souza', '1995-08-30', 'Solteiro'),
('99988877766', 'Fernando', 'Almeida', '1982-04-18', 'Casado'),
('44455566677', 'Beatriz', 'Mendes', '1993-11-25', 'Solteiro'),
('77788899900', 'Ricardo', 'Lima', '1987-06-05', 'Casado'),
('66655544433', 'Camila', 'Ferreira', '2000-09-12', 'Solteiro');

-- Inserindo endereços
INSERT INTO endereco (rua, bairro, cidade, sigla_estado, pais) VALUES
('Av. Paulista', 'Centro', 'São Paulo', 'SP', 'Brasil'),
('Rua das Flores', 'Jardins', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Rua 7 de Setembro', 'Centro', 'Curitiba', 'PR', 'Brasil'),
('Rua Amazonas', 'Boa Vista', 'Belo Horizonte', 'MG', 'Brasil'),
('Av. Brasil', 'Copacabana', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Rua das Acácias', 'Jardim Botânico', 'Brasília', 'DF', 'Brasil'),
('Av. das Américas', 'Centro', 'Salvador', 'BA', 'Brasil'),
('Rua São João', 'Centro', 'Porto Alegre', 'RS', 'Brasil');

-- Relacionando clientes com endereços
INSERT INTO cliente_endereco (idC, idE) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8);

-- Inserindo contatos
INSERT INTO contato (tipo, contato) VALUES
('telefone', '11987654321'),
('e-mail', 'maria@email.com'),
('telefone', '41999887766'),
('e-mail', 'ana@email.com'),
('telefone', '31988776655'),
('e-mail', 'beatriz@email.com'),
('telefone', '71998877665'),
('e-mail', 'camila@email.com');

-- Relacionando clientes com contatos
INSERT INTO cliente_contato (idC, idCo) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8);

-- Inserindo quartos
INSERT INTO quarto (tamanho, andar, quantid_cama) VALUES
('15m x 15m', '1', '1'),
('24m x 24m', '2', '2'),
('15m x 15m', '3', '3'),
('24m x 24m', '4', '1'),
('15m x 15m', '5', '2'),
('24m x 24m', 'Terreo', '3'),
('15m x 15m', '2', '1'),
('24m x 24m', '3', '2');

-- Inserindo reservas
INSERT INTO reserva (valor, modo_pagamento, status, data_checkin, data_checkout, idCliente) VALUES
(500.00, 'Cartão de Crédito', 'Confirmado', '2025-03-10', '2025-03-15', 1),
(750.00, 'Dinheiro', 'Pendente', '2025-04-05', '2025-04-10', 2),
(600.00, 'Cartão de Débito', 'Em andamento', '2025-02-20', '2025-02-25', 3),
(900.00, 'Cartão de Crédito', 'Confirmado', '2025-05-12', '2025-05-17', 4),
(1100.00, 'Cheque', 'Em andamento', '2025-06-01', '2025-06-07', 5),
(850.00, 'Cartão de Débito', 'Pendente', '2025-07-20', '2025-07-25', 6),
(950.00, 'Dinheiro', 'Confirmado', '2025-08-15', '2025-08-20', 7),
(700.00, 'Cartão de Crédito', 'Em andamento', '2025-09-10', '2025-09-15', 8);

-- Adicionando mais reservas para os clientes já existentes
INSERT INTO reserva (valor, modo_pagamento, status, data_checkin, data_checkout, idCliente) VALUES
(1200.00, 'Cartão de Crédito', 'Confirmado', '2025-03-18', '2025-03-22', 1), 
(650.00, 'Dinheiro', 'Pendente', '2025-04-12', '2025-04-16', 2), 
(900.00, 'Cartão de Débito', 'Em andamento', '2025-05-02', '2025-05-07', 3), 
(750.00, 'Cartão de Crédito', 'Confirmado', '2025-06-15', '2025-06-20', 1), 
(500.00, 'Cheque', 'Pendente', '2025-07-01', '2025-07-05', 4), 
(1050.00, 'Cartão de Débito', 'Confirmado', '2025-08-10', '2025-08-15', 5), 
(1350.00, 'Cartão de Crédito', 'Confirmado', '2025-09-05', '2025-09-10', 2); 

-- Relacionando as novas reservas com quartos existentes
INSERT INTO reserva_quarto (idR, idQ) VALUES
(9, 3), (10, 4), (11, 5), (12, 1), (13, 2), (14, 6), (15, 7);

-- Inserindo mais um valor para causar empate proposital e testar o RANK() e DENSE_RANK()
INSERT INTO reserva (valor, modo_pagamento, status, data_checkin, data_checkout, idCliente) VALUES
(100, 'Cartão de Crédito', 'Confirmado', '2024-12-10', '2024-12-25', 6);

INSERT INTO reserva_quarto (idR, idQ) VALUES
(16,2);

-- Relacionando reservas com quartos
INSERT INTO reserva_quarto (idR, idQ) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8);

-- Consultas 
SELECT * FROM cliente;
SELECT * FROM contato;
SELECT * FROM reserva;
SELECT * FROM quarto;
SELECT * FROM endereco;

-- Nome e contato dos clientes
SELECT c.nome, co.contato FROM cliente_contato cco
INNER JOIN cliente c ON c.idC = cco.idC
INNER JOIN contato co ON co.idCo = cco.idCo;

-- Nome, contato e valor da reserva com status 'Pendente'
SELECT c.nome, co.contato, r.valor, r.status FROM reserva r
INNER JOIN cliente c ON c.idC = r.idCliente
INNER JOIN contato co ON c.idC = co.idCo
WHERE r.status = 'Pendente';

-- Seleção de clientes que residem em SP
SELECT CONCAT(c.nome, ' ', c.sobrenome) AS nome_completo, e.cidade FROM cliente c
INNER JOIN cliente_endereco ce ON ce.idC = c.idC
INNER JOIN endereco e ON e.idE = ce.idE
WHERE e.sigla_estado = 'SP';

--  Lista com todas as reservas com informações do cliente e do quarto
SELECT CONCAT(c.nome, ' ', c.sobrenome) AS nome_completo, 
				r.status, 
                r.data_checkin, 
                r.data_checkout, 
                q.idQ, q.andar,
                r.idCliente
				FROM reserva r
                INNER JOIN reserva_quarto rq ON r.idR = rq.idR
                INNER JOIN cliente c ON r.idCliente = c.idC
                INNER JOIN quarto q ON q.idQ = rq.idQ;
                
-- Quantidade de reservas por status
SELECT count(*) AS quantidade_reservas, status FROM reserva GROUP BY status;

-- Clientes que gastaram mais de R$ 900,00 em reservas
SELECT CONCAT(c.nome, ' ', c.sobrenome) AS nome_completo, 
				r.valor, 
                r.status 
                FROM reserva r
INNER JOIN cliente c ON c.idC = r.idCliente
WHERE r.valor >= 900;

-- Ranking de quem mais gastou
SELECT c.idC, concat(c.nome, ' ', c.sobrenome) AS nome_completo,
		SUM(r.valor) AS total_gasto FROM cliente c
        INNER JOIN reserva r ON c.idC = r.idCliente
        GROUP BY r.idCliente
        ORDER BY SUM(r.valor) DESC;
        
-- Utilizando window function
SELECT c.idC, concat(c.nome, ' ', c.sobrenome) AS nome_completo,
		SUM(r.valor) AS total_gasto, 
        RANK() OVER (ORDER BY SUM(r.valor) DESC) AS ranking -- RANK: Sequencia contínua
        FROM cliente c
        INNER JOIN reserva r ON c.idC = r.idCliente
        GROUP BY r.idCliente;
        
-- Cupom de 10% para gastos acima de 500 reais


-- Cupom de 25% para gastos acima de 700 reais
