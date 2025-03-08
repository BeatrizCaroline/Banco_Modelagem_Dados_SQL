-- Criação do banco de dados para cenário de Oficina

-- drop database oficina;
create database oficina;
use oficina;

show tables;

-- Criar tabela cliente
create table cliente(
	idCliente int auto_increment primary key,
    Pnome varchar(10),
    Snome varchar(20),
    Contato char(11) NOT NULL,
    Veiculo varchar(20) NOT NULL
);

-- Criar tabela oficina
create table oficina(
	idOficina int auto_increment primary key,
    ofNome varchar(20) NOT NULL,
    Endereco varchar(255)
);

-- Criar tabela veiculo
create table veiculo(
	idVeiculo int auto_increment primary key,
    vNome varchar(20) NOT NULL,
    Marca varchar(20) NOT NULL,
    constraint fk_veiculo_cliente foreign key(idVeiculo) references cliente(idCliente)
);

--  Criar tabela equipe
create table equipe(
	idEquipe int auto_increment primary key,
	nEquipe enum('Nº1','Nº2','Nº3')
);

-- Criar tabela mecanico
create table mecanico(
	idMecanico int,
    idMeEquipe int,
    primary key (idMecanico, idMeEquipe),
    meName varchar(15) NOT NULL,
	codigo char(15),
    meEndereco varchar(255),
    especalidade enum('Mecânica automotiva','Mecânica industrial','Mecânica de sistemas'),
	constraint unique_codigo unique (codigo),
	constraint fk_mecanico_veiculo foreign key(idMecanico) references veiculo(idVeiculo),
    constraint fk_mecanico_equipe foreign key(idMeEquipe) references equipe(idEquipe)
);

    
-- Criar tabela estoque
create table servicos(
	idServicos int auto_increment primary key,
    avaliação enum('Problemas no motor','Problemas no sistema de suspensão','Problemas no sistema elétrico'),
	conserto enum('Reparo de motor','Reparo de sistema de suspensão','Reparo de sistema elétrico'),
    revisoes enum('Revisão de óleo e filtros','Revisão de freios','Revisão de pneus e alinhamento')
    );
    
-- Create tabela OS
create table os(
	idOs int auto_increment primary key,
	valor double NOT NULL,
    numero int,
    emissao date,
    conclusao date
);

--

insert into cliente (Pnome, Snome, Contato, Veiculo) values
					('Joao', 'Silva', 123456789, 'Fusca'),
                    ('Julia', 'Pinto', 987654321, 'Camaro'),
                    ('Paulo', 'Moreira', 123456987, 'Ferrari'),
                    ('Beatriz', 'Reis', 987654123, 'Prisma');
                    
insert into oficina (ofNome, Endereco) values
					('Carreta Furacão', 'Rua de lá');
                    

insert into veiculo (vNome, Marca) values
					('Fusca', 'Volkswagen'),
                    ('Camaro', 'Chevrolet'),
                    ('Ferrari GT', 'Ferrari'),
                    ('Prisma', 'Chevrolet');
                    
insert into equipe(idEquipe, nEquipe) values
				  (1, 'Nº1'),
                  (2, 'Nº2'),
                  (3, 'Nº3'),
                  (4, 'Nº2'),
                  (5, null);
			
	-- ('Mecânica automotiva','Mecânica industrial','Mecânica de sistemas'),
insert into mecanico (idMecanico, idMeEquipe, meName, codigo, meEndereco, especalidade) values
					(1, 5, 'Caio', 1234567801, 'rua vitoria 10', 'Mecânica industrial'),
                    (2, 4, 'Rafael', 1234567890, 'rua booleana 15', 'Mecânica de sistemas'),
                    (3, 3, 'Julio', 1234567809, 'rua Maria 118', 'Mecânica industrial'),
                    (4, 2, 'Fabio', 1234567806, 'rua Piraci 80', 'Mecânica automotiva'),
                    (2, 1, 'Bianca', 1234567804, 'rua gatuna 123', 'Mecânica de sistemas');
				
-- ('Problemas no motor','Problemas no sistema de suspensão','Problemas no sistema elétrico'),
-- ('Reparo de motor','Reparo de sistema de suspensão','Reparo de sistema elétrico'),
-- ('Revisão de óleo e filtros','Revisão de freios','Revisão de pneus e alinhamento')
insert into servicos (avaliação, conserto, revisoes) values
					('Problemas no motor', 'Reparo de motor', 'Revisão de pneus e alinhamento'),
                    ('Problemas no sistema de suspensão', null, 'Revisão de óleo e filtros'),
                    ('Problemas no sistema elétrico', 'Reparo de sistema elétrico', null),
                    (null, null, 'Revisão de freios'),
                    ('Problemas no sistema de suspensão', 'Reparo de sistema de suspensão', 'Revisão de freios');
                    
insert into os (idOs, valor, numero, emissao, conclusao) values
			   (1, 150.8, 2, '2004-09-08', '2004-09-22'),
               (2, 180, 1, '2004-10-06', '2004-10-15'),
               (3, 320, 1, '2004-09-18', '2004-09-30'),
               (4, 460.5, 2, '2004-05-08', '2004-05-25');
               
--

-- Recuperações simples com SELECT Statement;
SELECT * FROM cliente;
SELECT Pnome, veiculo FROM cliente;

-- Filtros com WHERE Statement;
SELECT * FROM os WHERE valor > 300;
SELECT * FROM cliente WHERE veiculo = 'Ferrari';

-- Crie expressões para gerar atributos derivados;
SELECT (conclusao - emissao) as dias_espera FROM os;

-- Defina ordenações dos dados com ORDER BY;
SELECT * FROM os ORDER BY valor;
SELECT * FROM mecanico ORDER BY meName DESC;

-- Condições de filtros aos grupos – HAVING Statement;
SELECT Veiculo, COUNT(*) AS num_veiculo FROM cliente GROUP BY veiculo HAVING COUNT(*) > 0;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;
SELECT cliente.Pnome, veiculo.vNome FROM cliente
INNER JOIN veiculo ON cliente.Veiculo = veiculo.vNome;

SELECT equipe.nEquipe, mecanico.meName FROM equipe
LEFT JOIN mecanico ON equipe.idEquipe = mecanico.idMecanico;
