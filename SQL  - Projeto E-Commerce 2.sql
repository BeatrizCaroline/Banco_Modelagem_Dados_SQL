use ecommerce;

show tables;

-- idclient, Fname, Minit, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, Address)
	values('Maria','M','Silva',123456789, 'rua daqui 10, Carangola - Cidade Dali'),
		  ('Matheus','O','Pimentel',987654321, 'rua daqui 20, Centro - Cidade Dali'),
          ('Ricardo','F','Silva',45678913, 'rua daqui 30, Carangola - Cidade Dali'),
          ('Julia','S','França',789123456, 'rua daqui 40, Carangola - Cidade Dali'),
          ('Roberta','G','Assis',98745631, 'rua daqui 50, Carangola - Cidade Dali'),
          ('Isabela','M','Cruz',654789123, 'rua daqui 60, Carangola - Cidade Dali');

-- DESAFIO - Acrescentando pontos: Cliente PJ e PF
-- O SET no SQL é usado para atribuir ou modificar valores em uma tabela
UPDATE Clients 
	SET Tipo = 'PJ' 
	WHERE CPF IN (123456789, 98745631, 654789123);

UPDATE Clients 
	SET Tipo = 'PF' 
	WHERE CPF IN (987654321, 45678913, 789123456);

select * from Clients;
          
-- classification_kids, category ('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), Avaliação, Size
 insert into product (Pname, classification_kids, category, avaliação, size) values
					 ('Fone de ouvido', false, 'Eletrônico','4',null),
                     ('Barbie Elsa', true, 'Brinquedos','3',null),
                     ('Body Carters', true, 'Vestimenta','5',null),
                     ('Microfone Vedo - Youtuber', false, 'Eletrônico','4',null),
                     ('Sofá retrátil', false, 'Móveis','3','3x57x80');

-- DESAFIO - Acrescentando pontos: Forma de Pagamento;                    
-- typePayment ('Boleto','Cartão','Dois cartões', 'PIX'), limitAvailable
insert into payments (idClient, idPayment, typePayment, limitAvailable) values
						(1, 101, 'PIX', NULL), 
						(2, 102, 'Cartão', 500.5), 
						(3, 103, 'Dois cartões', 800), 
						(4, 104, 'Boleto', NULL);

-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash					
delete from orders where idOrderClient in (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
				   (1, default, 'compra via app',null,1),
                   (2, default, 'compra via app',50,0),
                   (3,'Confirmado',null, null,1),
                   (4, default, 'compra via web site', 150,0);
                   
-- idPOproduct, idPOorder, poQuantity, poStatus
select * from orders;
INSERT IGNORE INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) VALUES
								(1,1,2,null),
								(2,2,1,null),
								(3,3,1,null);
                         
-- storageLocation, quantity
insert into productStorage (storageLocation, quantity) values
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo', 10),
                            ('São Paulo', 100),
                            ('São Paulo', 10),
                            ('Brasília', 60);
                            
-- idLproduct, idLstorage, location                            
insert into storageLocation (idLproduct, idLstorage, location) values
							(1,2,'RJ'),
                            (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values					
					('Almeida e filhos',123456789123456,'21985474'),
					('Eletrônicos Silva',854519649143457,'21985484'),
                    ('Eletrônicos Valma',934567893934695,'21975474');

select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
							(1,1,500),
                            (1,2,400),
                            (2,4,633),
                            (3,3,5),
                            (2,5,10);
						
insert into seller(SocialName, AbstName, CNPJ, CPF, location, contact) values
				('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
                ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
                ('Tech eletronics', null, 456789123654485, null, 'São Paulo', 1198657484);

select * from seller;

-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values
						   (1,2,3),
                           (2,3,1);

SELECT idProduct FROM product;
SELECT idseller FROM seller;

select * from productSeller;

-- DESAFIO - Acrescentando pontos: Entrega 
-- productEntrega(idPeEntrega, idPeProduct, peQuantity, peStatus ('A caminho','Entregue'), codigo
insert into productEntrega (idPeEntrega, idPeProduct, peQuantity, peStatus, codigo) values
							(1, 2, 3, 'A caminho', 123456789),
                            (3, 1, 2, 'A caminho', 1234567890),
                            (2, 3, 1, 'Entregue', 0123456789);
select * from productEntrega;


select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;
select Fname,Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname,' ', Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
				(2, default,'compra via app',null,1);
                
select count(*) from clients c, orders o where c.idClient = idOrderClient;

-- Recuperação de pedido com produto associado
select * from clients c 
		inner join orders o on c.idClient = o.idOrderClient
		inner join productOrder p on p.idPOorder = o.idOrder
            group by idClient;
            
select * from productOrder;
-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idClient,Fname, count(*) as Numeber_of_orders from clients c inner join orders o on c.idClient = o.idOrderClient
		inner join productOrder p on p.idPOorder = o.idOrder
            group by idClient;
