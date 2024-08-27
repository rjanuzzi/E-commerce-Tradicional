-- Database: Projeto final da disciplina de BD

 -- drop table estoques;
 -- drop table pedido_produtos;
 -- drop table pedidos;
 -- drop table funcionario_produto;
 -- drop table funcionaros;
 -- drop table produtos;
 -- drop table categorias;
 -- drop table endereco_clientes;
 -- drop table clientes;
 -- drop view nota_fiscal;
 -- drop trigger atualizar_estoque_trigger on pedido_produtos;

-- Criação das tabelas 
create table clientes (
	codigo serial primary key,
	nome varchar (100) not null,
	cpf varchar(14) unique not null,
	data_de_nascimento date not null,
	email varchar(100) not null unique,
	telefone varchar (100),
	celular varchar (100) not null unique,
	usuario varchar (100) not null unique,
	senha varchar (100) not null 
	);
	
create table endereco_clientes (
	codigo serial primary key,
	cd_cliente int references clientes(codigo),
	rua text not null,
	bairro varchar(50) not null,
	cidade varchar(50) not null,
	uf varchar (20) not null,
	cep varchar(20)not null,
	numero int not null
	);

create table categorias(
	codigo serial primary key,
	nome varchar (100) not null,
	descricao text not null
);

create table produtos(
	codigo serial primary key,
	nome varchar (100) not null,
	descricao text ,
	data_de_fabricacao date not null,
	cd_categoria int references categorias(codigo)not null,
	valoruni decimal not null
);

create table estoques(
	codigo serial primary key,
	cd_produto int references produtos(codigo) not null,
	quantidade numeric not null check (quantidade >= 0)
);

create table pedidos (
	codigo serial primary key,
	cd_cliente int references clientes(codigo) not null,
	data_do_pedido date default current_date not null	
);

create table pedido_produtos(
	codigo serial primary key,
	cd_pedido int not null references pedidos(codigo),
	cd_produto int not null references produtos(codigo),
	qntd_produto int not null
);

create table funcionarios (
	codigo serial primary key,
	nome varchar(100) not null,
	cpf varchar(14)not null unique
);

create table funcionario_produto(
	codigo serial primary key,
	cd_funcionario int not null references funcionarios(codigo),
	cd_produto int not null references produtos(codigo),
	acao text not null,
	data_acao date default current_date not null
);

-- Inserção de dados nas tabelas

insert into clientes (nome,cpf,data_de_nascimento,email,celular,telefone,usuario,senha)
values 
('Bob','023.456.789-10','1995-01-01','bob@email.com','(21)9-12345-6789','','bob12','123456'),
('Bia','123.456.789-11','1995-02-02','bia@email.com','(21)9-79345-6789','(21)2742-7899','bia12','987654'),
('Bob','123.456.789-12','1995-03-03','jon@email.com','(21)9-99345-6789','','jon12','147852'),
('Bob','123.456.789-13','1995-04-04','alex@email.com','(21)9-5555-5555','(21)9-5555-5555','alex12','alex123'),
('Bob','123.456.789-14','1995-05-05','cris@email.com','(21)9-7070-7070','','cris12','naotem'),
('Bob','123.456.789-15','1995-06-06','ana@email.com','(21)9-6969-6969','(21)9999-9999','ana12','senha');

select * from clientes;

insert into endereco_clientes (cd_cliente,rua,bairro,cidade,uf,cep,numero)
values
(1,'Rua la em baixo','morro baixo','petrópolis','rj','29845-023','195'),
(1,,'Rua ali na frente','morro acima','petrópolis','rj','29845-500','05'),
(2,'Rua ali atras','morro acima','teresópolis','rj','29845-500','1002'),
(3,'Rua ali na beira','Vila luiz','belo horizonte','bh','55555-55','200'),
(4,'Rua ali na lateral','morro alto','areado','mg','99999-11','30'),
(5,'Rua ali na rua de cima','alto','teresópolis','rj','25959-500','500'),
(6,'Rua ali na esquina','alto','teresópolis','rj','25959-500','999');

select * from endereco_clientes;

insert into categorias (nome, descricao) 
values
('Bebidas','Agua,cervejas,sucos,refrígerante.'),
('Escola','material escolar'),
('Comida','comida prontas,frutas,legumes,frios'),
('Limpeza','material e produtos de limpeza'),
('Roupas','tecido para por no corpo');

select * from categorias;

insert into produtos (nome,	descricao,data_de_fabricacao,cd_categoria,valoruni)
values
('cerveja','Pilsen, IPA, Lager, Stout, entre outros,teor alcoólico.',NOW(),1,3.99),
('Agua mineral','Água pura e cristalina, sem sabor',NOW(),1,1.99),
('Coca-Cola','',NOW(),1,5.50),
('Lapis de Cor','Todas as cores do arco-ires',NOW(),2,7.99),
('Mochila Bem10','Mochila do desenho bem10',NOW(),2,29.99),
('Caderno','caderno diversos modelos',NOW(),2,15.39),
('Biscoito','biscoito recheado',NOW(),3,3.55),
('Morango','Fruta',NOW(),3,7.99),
('Cenoura','Legumes',NOW(),3,3.99),
('Sabao em Pó','OMO',NOW(),4,15.99),
('Pano','tecido branco',NOW(),4,2.50),
('Camisa','Marca Nike ',NOW(),5,50.00)

select * from produtos;

insert into estoques (cd_produto,quantidade)
values
(1,80),(2,90),(3,30),
(4,20),(5,20),(6,10),
(7,0),(8,10),(9,13),
(10,20),(11,20),(12,15);

select * from estoques;

insert into pedidos (cd_cliente,data_do_pedido)
values 
(1,now()),
(2,now()),
(3,now()),
(4,now()),
(5,now());

select * from pedidos;

insert into pedido_produtos (cd_pedido,cd_produto,qntd_produto)
values 
 (1,1,10),
 (1,9,5),
 (1,2,5),
 (2,6,5),
 (5,5,5),
 (3,8,15),
 (4,12,5);
 
select * from pedido_produtos;

insert into funcionarios (nome,cpf)
values 
('Gustavo','123.456.789-20'),
('Thago','123.456.789-21'),
('Rafael','123.456.789-22'),
('Vinicius','123.456.789-23'),
('Alex','123.456.789-24'),
('Vitor','123.456.789-25');

select * from funcionarios;

insert into funcionario_produto (cd_funcionario,cd_produto,acao)
values
(2,1,'atualizar produtos'),
(3,6,'atualizar produtos'),
(6,11,'atualizar produtos'),
(1,10,'atualizar produtos'),
(1,3,'atualizar data fabricaçao'),
(4,4,'atualizar produtos'),
(5,5,'trocar de valor');

select *from funcionario_produto;

--Um comando SQL de atualização em algum registro em uma tabela 

update clientes set nome = CASE
	when codigo = 3 then 'Jon'
	when codigo = 4 then 'Alex'
	when codigo = 5 then 'Cris'
	when codigo = 6 then 'Ana'
	else nome
end;

select * from clientes;

-- Um comando SQL de exclusão de algum registro em uma tabela
select * from funcionario_produto;
delete from funcionario_produto
	where codigo = 12 ;

-- 5 SQLs de consulta
-- a. Pelo menos 2 com algum tipo de junção
-- b. Pelo menos 1 com usando count() e group by()
-- c. 1 SQL para construção de nota fiscal

--a

select c.nome,string_agg(p.nome || ' : '|| pp.qntd_produto, ', ' ) as produtos
from 
clientes c
join pedidos pe on c.codigo = pe.cd_cliente
join pedido_produtos pp on pe.codigo = pp.cd_pedido
join produtos p on p.codigo = pp.cd_produto
group by c.nome

select p.codigo,p.nome,e.quantidade
from produtos p
join estoques e on e.cd_produto = p.codigo


--b 

select c.nome,count(e.quantidade)
from categorias c 
join produtos p on p.cd_categoria = c.codigo
join estoques e on e.cd_produto = p.codigo
group by c.nome

-- c. 1 SQL para construção de nota fiscal

create view nota_fiscal as
select
	pe.codigo as numero_nota,pe.data_do_pedido, c.nome, c.cpf, e.rua,
    e.numero, e.bairro,  e.cidade, e.uf,
    STRING_AGG(po.nome||' -' || pp.qntd_produto || ' (R$ ' || po.valoruni || ')', ', ') as produtos_quantidade_valor_unitario,
    sum(pp.qntd_produto * po.valoruni) as valor_total
from clientes c
join endereco_clientes e on e.cd_cliente = c.codigo
join pedidos pe on pe.cd_cliente = c.codigo
join pedido_produtos pp on pp.cd_pedido = pe.codigo
join produtos po on pp.cd_produto = po.codigo
group by 
	numero_nota, c.nome, c.cpf, e.rua,
    e.numero, e.bairro, e.cidade, e.uf;

select * from nota_fiscal

-- atualizar estoque
create or replace function atualizar_estoque()
returns trigger as $$
begin
	update estoques set quantidade = quantidade - NEW.qntd_produto
	where cd_produto = NEW.cd_produto;

	return NEW;

end;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizar_estoque_trigger
AFTER INSERT ON pedido_produtos
FOR EACH ROW
EXECUTE FUNCTION atualizar_estoque();


