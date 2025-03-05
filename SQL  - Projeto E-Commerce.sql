-- Criação do banco de dados para cenário de E-commerce

-- drop database ecommerce;
create database ecommerce;
use ecommerce;

show tables;

-- Criar tabela cliente
create table clients(
	idclient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) NOT NULL,
    Address varchar(255),
    constraint unique_cof_client unique (CPF)
);
alter table clients auto_increment=1;
-- DESAFIO - Acrescentando pontos: Cliente PJ e PF
ALTER TABLE clients
	ADD COLUMN Tipo enum('PJ','PF') NOT NULL;
desc clients;

-- Criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(255) not null,
    classification_kids bool default false,
    category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
    avaliação float default 0,
	size varchar(10) -- Dimensão
);

-- Para o Desafio: Implemntar tabela e criar conexões com as tabelas nezessárias
-- Também reflita essa modificação no diagrama ER
-- Criar constraints relacionadas ao pagamento
create table payments(
	idClient int,
	idpayment int,
    typePayment enum('Boleto','Cartão','Dois cartões', 'PIX') NOT NULL,
    limitAvailable float,
    primary key(idClient, idpayment)
);
    
-- Criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
	orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false,
    constraint fk_order_client foreign key (idOrderclient) references clients(idClient)
		on update cascade
    );
 alter table orders auto_increment=1;
-- idPayment 
    
-- Criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
    quantity int default 0
    );
    
--  Criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
	SocialName varchar(255) NOT NULL,
    CNPJ char(15) NOT NULL,
    contact char(11) NOT NULL,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;
	desc supplier;

-- Create tabela vendedor
create table seller(
	idseller int auto_increment primary key,
	SocialName varchar(255) NOT NULL,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) NOT NULL,
    constraint unique_cnpj_supplier unique (CNPJ),
    constraint unique_cpf_supplier unique (CPF)
);
alter table seller auto_increment=1;

-- Tabelas de relacionamentos M:N

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key(idPseller) references seller(idSeller),
    constraint fk_product_product foreign key(idPproduct) references product(idProduct)
);
	desc productSeller;

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key(idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key(idPOorder) references orders(idOrder)
    );
    
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) NOT NULL,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_seller foreign key(idLproduct) references product(idProduct),
    constraint fk_storage_location_product foreign key(idLstorage) references productStorage(idprodStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int NOT NULL,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key(idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key(idPsProduct) references product(idProduct)
    );
    desc productSupplier;
    
    -- DESAFIO - Acrescentando pontos: Entrega   
    create table productEntrega(
	idPeEntrega int,
	idPeProduct int,
    peQuantity int default 1,
    peStatus enum('A caminho','Entregue') default 'A caminho',
    codigo char (15) NOT NULL,
    primary key (idPeEntrega, idPeProduct),
	constraint fk_product_entrega foreign key(idPeProduct) references product(idProduct),
    constraint fk_product_client_entrega foreign key(idPeEntrega) references clients(idclient)
    );
    
    show tables;
    show databases;
    use information_schema;
