

--Remoção do Banco de dados uvv e o usuario jun caso exista um antes da nova criação.
DROP DATABASE   	IF EXISTS uvv;
DROP USER 	    	IF EXISTS jun;

--Criar o usuario.
CREATE USER jun
WITH  		createdb
      		createrole
      		encrypted
      		password 'abcd2023xx';

--Criar o banco de dados com nome uvv.
CREATE DATABASE uvv
WITH   		owner = jun
       		template = template0
       		encoding = 'UTF8'
       		lc_collate = 'pt_BR.UTF-8'
       		lc_ctype = 'pt_BR.UTF-8'
       		allow_connections = TRUE;

--
\c "dbname=uvv user=jun password=abcd2023xx";

--Criar uma schema caso lojas não tenha autorizado por usuario jun.
CREATE SCHEMA   	IF NOT EXISTS lojas AUTHORIZATION jun;

ALTER USER jun
SET SEARCH_PATH TO lojas, "$user", public;

--
CREATE TABLE lojas.produtos (
    		 produto_id       		    NUMERIC(38) 	NOT NULL,
      		 nome            			NUMERIC(255) 	NOT NULL,
      		 preco_unitario   			NUMERIC(10,2),
      		 detalhes 					BYTEA,
      	 	 imagem 					BYTEA,
     		 imagem_mime_type 			VARCHAR(512),
     		 imagem_arquivo   			VARCHAR(512),
     		 imagem_charset   			VARCHAR(512),
      		 imagem_ultima_atualizacao 	DATE,      
  CONSTRAINT pk_produtos 				PRIMARY KEY (produto_id)
);

--Checkagem da tabela lojas.produtos para o preço da unidade do produto não ser negativo e nem zero.
ALTER TABLE lojas.produtos
ADD CONSTRAINT ck_preco_unitario_produtos
CHECK (preco_unitario > 0);

COMMENT ON TABLE  lojas.produtos
			   IS 'A tabela produtos que tem por sua responsabilidade de guardar os dados dos produtos.';
			  
COMMENT ON COLUMN lojas.produtos.produto_id
			   IS 'Coluna produto_id que é responsável como identificador único da tabela produtos. Ele tambem é uma chave primária da tabela produtos.';

COMMENT ON COLUMN lojas.produtos.nome
			   IS 'Coluna nome que é responsável por guardar o nome dos produtos.';

COMMENT ON COLUMN lojas.produtos.preco_unitario
			   IS 'Coluna preco_unitario que é responsável por mostrar o preço de unidade por cada produto.';

COMMENT ON COLUMN lojas.produtos.detalhes 
			   IS 'Coluna detalhes que é responsável para detalhar objeto de tipo de arquivo como forma de armazenamento dos produtos.';

COMMENT ON COLUMN lojas.produtos.imagem
			   IS 'Coluna imagem que é responsável por armazenar a imagem do produto.';

COMMENT ON COLUMN lojas.produtos.imagem_mime_type
			   IS 'Coluna loja que é responsável por armazenar o tipo de arquivo da imagem do produto.';

COMMENT ON COLUMN lojas.produtos.imagem_arquivo
			   IS 'Coluna imagem_arquivo que é responsável por armazenar o arquivo da imagem do produto.';

COMMENT ON COLUMN lojas.produtos.imagem_charset
			   IS 'Coluna imagem_charset que é responsável por armazenar codificação dos caracteres da imagem do produto.';

COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao
			   IS 'Coluna imagem_ultima_atualizacao que é responsável por armazenar a ultima atualização de um imagem do produto.';


--
CREATE TABLE lojas.lojas (
	    	 loja_id 					NUMERIC(38) 	NOT NULL,
             nome 						VARCHAR(255) 	NOT NULL,
             endereco_web 				VARCHAR(200),
             endereco_fisico 			VARCHAR(512),
             latitude 					NUMERIC,
             longitude 					NUMERIC,
             logo BYTEA,
             logo_mime_type 			VARCHAR(512),
             logo_arquivo 				VARCHAR(512),
             logo_charset 				VARCHAR(512),
             logo_ultima_atualizacao 	DATE,
  CONSTRAINT pk_lojas 					PRIMARY KEY (loja_id)
);

--Checkagem da tabela lojas.lojas para o preço do produto não ser negativo e nem zero.
ALTER TABLE lojas.lojas
ADD CONSTRAINT ck_endereco_fisico_e_web_lojas
CHECK (endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);

COMMENT ON TABLE lojas.lojas
                           IS 'A tabela lojas que tem por sua responsabilidade de guardar os dados das lojas.';
			  
COMMENT ON COLUMN lojas.lojas.loja_id
			   IS 'Coluna loja_id que é responsável como identificador único da tabela lojas. Ele tambem é uma chave primária da tabela lojas.';

COMMENT ON COLUMN lojas.lojas.nome
			   IS 'Coluna nome que é responsável por guardar o nome da loja.';

COMMENT ON COLUMN lojas.lojas.endereco_web
			   IS 'Coluna endereco_web que é responsável por guardar o url da loja.';

COMMENT ON COLUMN lojas.lojas.endereco_fisico
			   IS 'Coluna endereco_fisico que é responsável por guardar o endereço físico da loja.';

COMMENT ON COLUMN lojas.lojas.latitude
			   IS 'Coluna latitude que é responsável por guardar a latitude de coordenada geográfica da loja.';

COMMENT ON COLUMN lojas.lojas.longitude
			   IS 'Coluna longitude que é responsável por guardar a longitude de coordenada geográfica da loja.';

COMMENT ON COLUMN lojas.lojas.logo
			   IS 'Coluna logo que é responsável por armazenar a imagem de um logo da loja.';

COMMENT ON COLUMN lojas.lojas.logo_mime_type
			   IS 'Coluna loja que é responsável por armazenar o tipo de arquivo da imagem de um logo da loja.';

COMMENT ON COLUMN lojas.lojas.logo_arquivo
			   IS 'Coluna logo_arquivo que é responsável por armazenar o arquivo da imagem de um logo da loja.';

COMMENT ON COLUMN lojas.lojas.logo_charset
			   IS 'Coluna logo_charset que é responsável por armazenar codificação dos caracteres da imagem de um logo da loja.';

COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao
			   IS 'Coluna logo_ultima_atualizacao que é responsável por armazenar a ultima atualização de um logo da loja.';


CREATE TABLE lojas.estoques (
             estoque_id 				NUMERIC(38) 	NOT NULL,
             loja_id 					NUMERIC(38) 	NOT NULL,
             produto_id 				NUMERIC(38) 	NOT NULL,
             quantidade 				NUMERIC(38) 	NOT NULL,
  CONSTRAINT pk_estoques 				PRIMARY KEY (estoque_id)
);

--Checkagem da tabela lojas.estoques para a quantidade do estoque ser maior que zero.
ALTER TABLE lojas.estoques
ADD CONSTRAINT ck_quantidades_lojas_estoques
CHECK (quantidade > 0);

COMMENT ON TABLE  lojas.estoques
			   IS 'A tabela estoques que tem por sua responsabilidade de guardar os estoques dos produtos para as lojas.';
			  
COMMENT ON COLUMN lojas.estoques.estoque_id
			   IS 'Coluna estoques_id que é responsável como identificador único da tabela estoques. Ele tambem é uma chave primária da tabela estoques.';

COMMENT ON COLUMN lojas.estoques.loja_id
			   IS 'Coluna loja_id que é responsável como identificador da tabela estoques. Ele tambem é uma chave estrangeira da tabela lojas.';

COMMENT ON COLUMN lojas.estoques.produto_id
			   IS 'Coluna produto_id que é responsável como identificador da tabela estoques. Ele tambem é uma chave estrangeira da tabela produtos.';

COMMENT ON COLUMN lojas.estoques.quantidade
			   IS 'Coluna quantidade que é responsável por guardar os informações de quantidade dos estoques.';


--
CREATE TABLE lojas.clientes (
             cliente_id 				NUMERIC(38) 	NOT NULL,
             email 						VARCHAR(255) 	NOT NULL,
             nome 						VARCHAR(255) 	NOT NULL,
             telefone1 					VARCHAR(20),
             telefone2 					VARCHAR(20),
             telefone3 					VARCHAR(20),
  CONSTRAINT pk_clientes 				PRIMARY KEY (cliente_id)
);


COMMENT ON TABLE  lojas.clientes
			   IS 'A tabela Clientes que tem por sua responsabilidade de guardar os dados dos seus clientes.';

COMMENT ON COLUMN lojas.clientes.cliente_id
			   IS 'Coluna cliente_id que é responsável como identificador único da tabela clientes. Ele tambem é uma chave primária da tabela clientes.';

COMMENT ON COLUMN lojas.clientes.email
			   IS 'Coluna email que é responsável por guardar o email do cliente.';

COMMENT ON COLUMN lojas.clientes.nome
			   IS 'Coluna nome que é responsável por guardar o nome do cliente.';

COMMENT ON COLUMN lojas.clientes.telefone1
			   IS 'Coluna telefone1 que é responsável por guardar o número de telefone do cliente.';

COMMENT ON COLUMN lojas.clientes.telefone2
			   IS 'Coluna telefone2 que é responsável por guardar o segundo número de telefone do cliente.';

COMMENT ON COLUMN lojas.clientes.telefone3
			   IS 'Coluna telefone3 que é responsável por guardar o terceiro número de telefone do cliente.';

--
CREATE TABLE lojas.envios (
			 envio_id 					NUMERIC(38) 	NOT NULL,
			 loja_id 					NUMERIC(38) 	NOT NULL,
			 cliente_id 				NUMERIC(38) 	NOT NULL,
			 endereco_entrega 			VARCHAR(512) 	NOT NULL,
			 status 					VARCHAR(15) 	NOT NULL,
  CONSTRAINT pk_envios 					PRIMARY KEY (envio_id)
);

COMMENT ON TABLE  lojas.envios
			   IS 'A tabela envios que tem por sua responsabilidade de guardar os dados de envios dos itens de pedidos para seus clientes e das lojas.';
			  
COMMENT ON COLUMN lojas.envios.envio_id
			   IS 'Coluna envio_id que é responsável como identificador da tabela envios. Ele tambem é uma chave primária da tabela envios.';
			  
COMMENT ON COLUMN lojas.envios.loja_id
			   IS 'Coluna loja_id que é responsável como identificador da tabela envios. Ele tambem é uma chave estrangeira da tabela lojas.';
			  
COMMENT ON COLUMN lojas.envios.cliente_id
			   IS 'Coluna cliente_id que é responsável como identificador da tabela envios. Ele tambem é uma chave estrangeira da tabela clientes.';
			  
COMMENT ON COLUMN lojas.envios.endereco_entrega
			   IS 'Coluna endereco_entrega que é responsável por guardar o endereçi de entrega dos envios.';
			  
COMMENT ON COLUMN lojas.envios.status
			   IS 'Coluna status que é responsável por mostrar o estado atual dos envios.';


--
CREATE TABLE lojas.pedidos (
			 pedidos_id 				NUMERIC(38) 	NOT NULL,
			 data_hora 					TIMESTAMP 		NOT NULL,
			 cliente_id 				NUMERIC(38) 	NOT NULL,
			 status 					VARCHAR(15) 	NOT NULL,
			 loja_id 					NUMERIC(38) 	NOT NULL,
  CONSTRAINT pk_pedidos 				PRIMARY KEY (pedidos_id)
);

COMMENT ON TABLE  lojas.pedidos
			   IS 'A tabela pedidos que tem por sua responsabilidade de guardar pedidos dos seus clientes à loja.';
			  
COMMENT ON COLUMN lojas.pedidos.pedidos_id
			   IS 'Coluna pedidos_id que é responsável como identificador único da tabela pedidos. Ele tambem é uma chave primária da tabela pedidos.';

COMMENT ON COLUMN lojas.pedidos.cliente_id
			   IS 'Coluna cliente_id que é responsável como identificador da tabela pedidos. Ele tambem é uma chave estrangeira da tabela clientes.';

COMMENT ON COLUMN lojas.pedidos.status
			   IS 'Coluna status que é responsável por mostrar o estado atual dos pedidos.';

COMMENT ON COLUMN lojas.pedidos.loja_id
			   IS 'Coluna loja_id que é responsável como identificador da tabela pedidos. Ele tambem é uma chave estrangeira da tabela lojas.';


--
CREATE TABLE lojas.pedidos_itens (
             pedidos_id 				NUMERIC(38) 	NOT NULL,
             produto_id 				NUMERIC(38) 	NOT NULL,
             numero_da_linha 			NUMERIC(38) 	NOT NULL,
             preco_unitario 			NUMERIC(10,2) 	NOT NULL,
             quantidade 				NUMERIC(38) 	NOT NULL,
             envio_id 					NUMERIC(38),
  CONSTRAINT pk_pedidos_itens 			PRIMARY KEY (pedidos_id, produto_id)
);

COMMENT ON TABLE  lojas.pedidos_itens
			   IS 'A tabela pedidos_itens que tem por sua responsabilidade de verificar os pedidos de produto e é responsável para remeter essas informações à tabela envios.';
			  
COMMENT ON COLUMN lojas.pedidos_itens.pedidos_id
			   IS 'Coluna pedido_id que é responsável como identificador da tabela pedidos_itens. Ele tambem é uma chave primária da tabela pedidos_itens e uma chave estrangeira da tabela pedidos.';

COMMENT ON COLUMN lojas.pedidos_itens.produto_id
			   IS 'Coluna produto_id que é responsável como identificador da tabela pedidos_itens. Ele tambem é uma chave primária da tabela pedidos_itens e uma chave estrangeira da tabela produtos.';

COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha
			   IS 'Coluna numero_da_linha que é responsável pelo identificar sequencialmente o registro de cada itens de pedidos.';

COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario
			   IS 'Coluna preco_unitario que é responsável por mostrar o preço de unidade por cada iten de pedido.';

COMMENT ON COLUMN lojas.pedidos_itens.quantidade
			   IS 'Coluna quantidade que é responsável por guardar os informações de quantidade dos pedidos de itens.';

COMMENT ON COLUMN lojas.pedidos_itens.envio_id
			   IS 'Coluna envio_id que é responsável como identificador da tabela pedidos_itens. Ele tambem é uma chave estrangeira da tabela envios.';


			  
ALTER TABLE lojas.estoques 				ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens 		ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos 				ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios 				ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques 				ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos 				ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios 				ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens 		ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens 		ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedidos_id)
REFERENCES lojas.pedidos (pedidos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
