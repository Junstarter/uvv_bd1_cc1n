-- Remoção do Banco de dados uvv e o usuário jun caso exista um antes da nova criação.
DROP DATABASE   IF EXISTS uvv;
DROP USER       IF EXISTS 'jun'@'localhost';

-- Criar o usuário.
CREATE USER     'jun'@'localhost' IDENTIFIED BY 'abcd2023xx';

-- Criar o banco de dados com o nome uvv.
CREATE DATABASE uvv;
GRANT ALL ON    uvv.* TO 'jun'@'localhost';
FLUSH           PRIVILEGES;

-- Ligação do usuário jun com o banco de dados uvv através da mesma senha.
USE             uvv;

-- Criação de tabela com o nome de produtos que tem como sua função de armazenar os dados como o id do produto, nome do produto, o preço unitário, os detalhes, a imagem, o mime type da imagem, o arquivo da imagem, o charset da imagem e a ultima atualização da imagem dos produtos.
CREATE TABLE 	produtos (
                produto_id                  NUMERIC(38)     NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                preco_unitario              NUMERIC(10,2),
                detalhes                    BLOB,
                imagem                      BLOB,
                imagem_mime_type            VARCHAR(512),
                imagem_arquivo              VARCHAR(512),
                imagem_charset              VARCHAR(512),
                imagem_ultima_atualizacao   DATE,
CONSTRAINT      pk_produtos                 PRIMARY KEY     (produto_id)
);

-- Checkagem da tabela produtos para o preço da unidade do produto não ser negativo e nem zero.
ALTER TABLE     produtos
ADD CHECK       (preco_unitario > 0);

-- Comentários para explicações de tabela e colunas de tabela lojas.produto.
ALTER TABLE     produtos                    COMMENT 'A tabela produtos que tem por sua responsabilidade de guardar os dados dos produtos.';
ALTER TABLE     produtos                    MODIFY COLUMN   produto_id          NUMERIC(38)     COMMENT 'Coluna produto_id que é responsável como identificador único da tabela produtos. Ele também é uma chave primária da tabela produtos.';
ALTER TABLE     produtos                    MODIFY COLUMN   nome                VARCHAR(255)    COMMENT 'Coluna nome que é responsável por guardar o nome dos produtos.';
ALTER TABLE     produtos                    MODIFY COLUMN   preco_unitario      NUMERIC(10,2)   COMMENT 'Coluna preco_unitario que é responsável por mostrar o preço de unidade por cada produto.';
ALTER TABLE     produtos                    MODIFY COLUMN   detalhes            BLOB            COMMENT 'Coluna detalhes que é responsável para detalhar objeto de tipo de arquivo como forma de armazenamento dos produtos.';
ALTER TABLE     produtos                    MODIFY COLUMN   imagem              BLOB            COMMENT 'Coluna imagem que é responsável por armazenar a imagem do produto.';
ALTER TABLE     produtos                    MODIFY COLUMN   imagem_mime_type    VARCHAR(512)    COMMENT 'Coluna loja que é responsável por armazenar o tipo de arquivo da imagem do produto.';
ALTER TABLE     produtos                    MODIFY COLUMN   imagem_arquivo      VARCHAR(512)    COMMENT 'Coluna imagem_arquivo que é responsável por armazenar o arquivo da imagem do produto.';
ALTER TABLE     produtos                    MODIFY COLUMN   imagem_charset      VARCHAR(512)    COMMENT 'Coluna imagem_charset que é responsável por armazenar codificação dos caracteres da imagem do produto.';
ALTER TABLE     produtos                    MODIFY COLUMN   imagem_ultima_atualizacao   DATE    COMMENT 'Coluna imagem_ultima_atualizacao que é responsável por armazenar a última atualização de um imagem do produto.';

-- Criação de tabela com nome de lojas que tem como sua função de armazenar os dados como o id da loja, nome da loja, endereço web, endereço físico, latitude, longitude, logo, o mime type do logo, o arquivo do logo,  o charset do logo e a ultima atualização do logo das lojas.
CREATE TABLE 	lojas (
                loja_id                     NUMERIC(38)     NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                endereco_web                VARCHAR(200),
                endereco_fisico             VARCHAR(512),
                latitude                    NUMERIC,
                longitude                   NUMERIC,
                logo                        BLOB,
                logo_mime_type              VARCHAR(512),
                logo_arquivo                VARCHAR(512),
                logo_charset                VARCHAR(512),
                logo_ultima_atualizacao     DATE,
CONSTRAINT      pk_lojas                    PRIMARY KEY     (loja_id)
);

-- Checkagem da tabela lojas para o preço do produto não ser negativo e nem zero.
ALTER TABLE     lojas
ADD CONSTRAINT  ck_endereco_fisico_e_web_lojas
CHECK           (endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);

-- Comentários para explicações de tabela e colunas de tabela lojas.
ALTER TABLE     lojas                       COMMENT 'A tabela lojas que tem por sua responsabilidade de guardar os dados das lojas.';
ALTER TABLE     lojas                       MODIFY COLUMN   loja_id             NUMERIC(38)     COMMENT 'Coluna loja_id que é responsável como identificador único da tabela lojas. Ele também é uma chave primária da tabela lojas.';
ALTER TABLE     lojas                       MODIFY COLUMN   nome                VARCHAR(255)    COMMENT 'Coluna nome que é responsável por guardar o nome da loja.';
ALTER TABLE     lojas                       MODIFY COLUMN   endereco_web        VARCHAR(200)    COMMENT 'Coluna endereco_web que é responsável por guardar o URL da loja.';
ALTER TABLE     lojas                       MODIFY COLUMN   endereco_fisico     VARCHAR(512)    COMMENT 'Coluna endereco_fisico que é responsável por guardar o endereço físico da loja.';
ALTER TABLE     lojas                       MODIFY COLUMN   latitude            NUMERIC         COMMENT 'Coluna latitude que é responsável por guardar a latitude de coordenada geográfica da loja.';
ALTER TABLE     lojas                       MODIFY COLUMN   longitude           NUMERIC         COMMENT 'Coluna longitude que é responsável por guardar a longitude de coordenada geográfica da loja.';
ALTER TABLE     lojas                       MODIFY COLUMN   logo                BLOB            COMMENT 'Coluna logo que é responsável por armazenar a imagem de um logo da loja.';
ALTER TABLE     lojas                       MODIFY COLUMN   logo_mime_type      VARCHAR(512)    COMMENT 'Coluna logo_mime_type que é responsável por armazenar o tipo de arquivo da imagem de um logo da loja.';
ALTER TABLE     lojas                       MODIFY COLUMN   logo_arquivo        VARCHAR(512)    COMMENT 'Coluna logo_arquivo que é responsável por armazenar o arquivo da imagem de um logo da loja.';
ALTER TABLE     lojas                       MODIFY COLUMN   logo_charset        VARCHAR(512)    COMMENT 'Coluna logo_charset que é responsável por armazenar codificação dos caracteres da imagem de um logo da loja.';
ALTER TABLE     lojas                       MODIFY COLUMN   logo_ultima_atualizacao     DATE    COMMENT 'Coluna logo_ultima_atualizacao que é responsável por armazenar a última atualização de um logo da loja.';

-- Criação de tabela com o nome de estoques que tem como sua função de armazenar os dados como o id do estoque, o id da loja, o id do produto e a quantidade dos seus estoques.
CREATE TABLE 	estoques (
                estoque_id                  NUMERIC(38)     NOT NULL,
                loja_id                     NUMERIC(38)     NOT NULL,
                produto_id                  NUMERIC(38)     NOT NULL,
                quantidade                  NUMERIC(38)     NOT NULL,
CONSTRAINT      pk_estoques                 PRIMARY KEY     (estoque_id)
);

-- Checkagem da tabela estoques para a quantidade do estoque ser maior que zero.
ALTER TABLE     estoques
ADD CONSTRAINT  ck_quantidades_estoques
CHECK           (quantidade > 0);

-- Comentários para explicações de tabela e colunas de tabela estoques.
ALTER TABLE     estoques                    COMMENT 'A tabela estoques que tem por sua responsabilidade de guardar os estoques dos produtos para as lojas.';
ALTER TABLE     estoques                    MODIFY COLUMN   estoque_id          NUMERIC(38)     COMMENT 'Coluna estoques_id que é responsável como identificador único da tabela estoques. Ele também é uma chave primária da tabela estoques.';
ALTER TABLE     estoques                    MODIFY COLUMN   loja_id             NUMERIC(38)     COMMENT 'Coluna loja_id que é responsável como identificador da tabela estoques. Ele também é uma chave estrangeira da tabela lojas.';
ALTER TABLE     estoques                    MODIFY COLUMN   produto_id          NUMERIC(38)     COMMENT 'Coluna produto_id que é responsável como identificador da tabela estoques. Ele também é uma chave estrangeira da tabela produtos.';
ALTER TABLE     estoques                    MODIFY COLUMN   quantidade          NUMERIC(38)     COMMENT 'Coluna quantidade que é responsável por guardar as informações de quantidade dos estoques.';

-- Criação de tabela com o nome de clientes que tem como sua função de armazenar os dados como o id do cliente, email, nome e os telefones dos seus clientes.
CREATE TABLE    clientes (
                cliente_id                  NUMERIC(38)     NOT NULL,
                email                       VARCHAR(255)    NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                telefone1                   VARCHAR(20),
                telefone2                   VARCHAR(20),
                telefone3                   VARCHAR(20),
CONSTRAINT      pk_clientes                 PRIMARY KEY     (cliente_id)
);

-- Comentários para explicações de tabela e colunas de tabela clientes.
ALTER TABLE     clientes                    COMMENT 'A tabela Clientes que tem por sua responsabilidade de guardar os dados dos seus clientes.';
ALTER TABLE     clientes                    MODIFY COLUMN   cliente_id          NUMERIC(38)  	COMMENT 'Coluna cliente_id que é responsável como identificador único da tabela clientes. Ele também é uma chave primária da tabela clientes.';
ALTER TABLE     clientes                    MODIFY COLUMN   email               VARCHAR(255)   	COMMENT 'Coluna email que é responsável por guardar o email do cliente.';
ALTER TABLE     clientes                    MODIFY COLUMN   nome                VARCHAR(255)   	COMMENT 'Coluna nome que é responsável por guardar o nome do cliente.';
ALTER TABLE     clientes                    MODIFY COLUMN   telefone1           VARCHAR(20) 	COMMENT 'Coluna telefone1 que é responsável por guardar o número de telefone do cliente.';
ALTER TABLE     clientes                    MODIFY COLUMN   telefone2           VARCHAR(20) 	COMMENT 'Coluna telefone2 que é responsável por guardar o segundo número de telefone do cliente.';
ALTER TABLE     clientes                    MODIFY COLUMN   telefone3           VARCHAR(20) 	COMMENT 'Coluna telefone3 que é responsável por guardar o terceiro número de telefone do cliente.';

-- Criação de tabela com o nome de envios que tem como sua função de armazenar os dados como o id do envio, o id da loja, o id do cliente, o endereço de entrega e o status dos seus envios.
CREATE TABLE    envios (
                envio_id                    NUMERIC (38)    NOT NULL,
                loja_id                     NUMERIC (38)    NOT NULL,
                cliente_id                  NUMERIC (38)    NOT NULL,
                endereco_entrega            VARCHAR(512)    NOT NULL,
                status                      VARCHAR(15)     NOT NULL,
CONSTRAINT      pk_envios                   PRIMARY KEY     (envio_id)
);

--Checagem da tabela envios para restringir a inserção de dados da coluna status para ser: Criado, Envios, Transito, Entregue.
ALTER TABLE     envios
ADD CONSTRAINT  ck_status
CHECK           (status in ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));


-- Comentários para explicações de tabela e colunas de tabela lojas.envios.
ALTER TABLE     envios                      COMMENT 'A tabela envios que tem por sua responsabilidade de guardar os dados dos envios realizados.';
ALTER TABLE     envios                      MODIFY COLUMN   envio_id            NUMERIC(38)  	COMMENT 'Coluna envio_id que é responsável como identificador único da tabela envios. Ele também é uma chave primária da tabela envios.';
ALTER TABLE     envios                      MODIFY COLUMN   loja_id             NUMERIC(38)  	COMMENT 'Coluna loja_id que é responsável como identificador da tabela envios. Ele também é uma chave estrangeira da tabela lojas.';
ALTER TABLE     envios                      MODIFY COLUMN   cliente_id          NUMERIC(38) 	COMMENT 'Coluna cliente_id que é responsável como identificador da tabela envios. Ele também é uma chave estrangeira da tabela clientes.';
ALTER TABLE     envios                      MODIFY COLUMN   endereco_entrega    VARCHAR(512)  	COMMENT 'Coluna endereco_entrega que é responsável por guardar o endereço de entrega do envio.';
ALTER TABLE     envios                      MODIFY COLUMN   status              VARCHAR(15) 	COMMENT 'Coluna status que é responsável por guardar o status do envio.';



-- Criação de tabela com o nome de pedidos que tem como sua função de armazenar os dados como o id do pedido, a data e a hora, id do cliente, o status e o id da loja dos seus pedidos.
CREATE TABLE    pedidos (
                pedido_id                   NUMERIC (38)    NOT NULL,
                data_hora                   TIMESTAMP       NOT NULL,
                cliente_id                  NUMERIC (38)    NOT NULL,
                status                      VARCHAR (15)    NOT NULL,
                loja_id                     NUMERIC (38)    NOT NULL,
CONSTRAINT      pk_pedidos                  PRIMARY KEY     (pedido_id)
);

--Checagem da tabela pedidos para restringir a inserção de dados da coluna status para ser: Cancelado, Completo, Aberto, Pago, Reembolsa, Enviado.
ALTER TABLE     pedidos
ADD CONSTRAINT  ck_status
CHECK           (status in ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));


-- Comentários para explicações de tabela e colunas de tabela lojas.pedidos.
ALTER TABLE     pedidos                     COMMENT 'A tabela pedidos que tem por sua responsabilidade de guardar pedidos dos seus clientes à loja.';
ALTER TABLE     pedidos                     MODIFY COLUMN   pedido_id 	        NUMERIC(38)    	COMMENT 'Coluna pedido_id que é responsável como identificador único da tabela pedidos. Ele também é uma chave primária da tabela pedidos.';
ALTER TABLE     pedidos                     MODIFY COLUMN   cliente_id 	        NUMERIC(38)   	COMMENT 'Coluna cliente_id que é responsável como identificador da tabela pedidos. Ele também é uma chave estrangeira da tabela clientes.';
ALTER TABLE     pedidos                     MODIFY COLUMN   status              VARCHAR(15)   	COMMENT 'Coluna status que é responsável por mostrar o estado atual dos pedidos.';
ALTER TABLE     pedidos                     MODIFY COLUMN   loja_id 	        NUMERIC(38)   	COMMENT 'Coluna loja_id que é responsável como identificador da tabela pedidos. Ele também é uma chave estrangeira da tabela lojas.';

-- Criação de tabela com o nome de pedidos_itens que tem como sua função de armazenar os dados como o id pedido, o id do produto, o numero da linha, o preço unitário, a quantidade e o id do envio dos seus itens de pedidos.
CREATE TABLE 	pedidos_itens (
                pedido_id                   NUMERIC(38)     NOT NULL,
                produto_id                  NUMERIC(38)     NOT NULL,
                numero_da_linha             NUMERIC(38)     NOT NULL,
                preco_unitario              NUMERIC(10, 2)  NOT NULL,
                quantidade                  NUMERIC(38)     NOT NULL,
                envio_id                    NUMERIC(38),
CONSTRAINT      pk_pedidos_itens            PRIMARY KEY     (pedido_id, produto_id)
);

-- Comentários para explicações de tabela e colunas de tabela pedidos_itens.
ALTER TABLE     pedidos_itens               COMMENT 'A tabela pedidos_itens que tem por sua responsabilidade de verificar os pedidos de produto e é responsável para remeter essas informações à tabela envios.';
ALTER TABLE     pedidos_itens               MODIFY COLUMN   pedido_id           NUMERIC(38)   	COMMENT 'Coluna pedido_id que é responsável como identificador da tabela pedidos_itens. Ele também é uma chave primária da tabela pedidos_itens e uma chave estrangeira da tabela pedidos.';
ALTER TABLE     pedidos_itens               MODIFY COLUMN   produto_id          NUMERIC(38)   	COMMENT 'Coluna produto_id que é responsável como identificador da tabela pedidos_itens. Ele também é uma chave primária da tabela pedidos_itens e uma chave estrangeira da tabela produtos.';
ALTER TABLE     pedidos_itens               MODIFY COLUMN   numero_da_linha     NUMERIC(38)   	COMMENT 'Coluna numero_da_linha que é responsável por identificar sequencialmente o registro de cada item de pedido.';
ALTER TABLE     pedidos_itens               MODIFY COLUMN   preco_unitario      NUMERIC(10, 2)	COMMENT 'Coluna preco_unitario que é responsável por mostrar o preço de unidade por cada item de pedido.';
ALTER TABLE     pedidos_itens               MODIFY COLUMN   quantidade 	        NUMERIC(38)     COMMENT 'Coluna quantidade que é responsável por guardar os informações de quantidade dos pedidos de itens.';


-- Alteração de tabela estoques para adicionar uma fk na coluna produto_id.
ALTER TABLE     estoques                    ADD CONSTRAINT  produtos_estoques_fk
                FOREIGN KEY (produto_id)    REFERENCES      produtos (produto_id)
ON DELETE       NO ACTION
ON UPDATE       NO ACTION;
  
-- Alteração de tabela pedidos_itens para adicionar uma fk na coluna produto_id.
ALTER TABLE     pedidos_itens               ADD CONSTRAINT  produtos_pedidos_itens_fk
                FOREIGN KEY (produto_id)    REFERENCES      produtos (produto_id)
ON DELETE       NO ACTION
ON UPDATE       NO ACTION;

-- Alteração de tabela pedidos para adicionar uma fk na coluna loja_id.
ALTER TABLE     pedidos                     ADD CONSTRAINT  lojas_pedidos_fk
                FOREIGN KEY (loja_id)       REFERENCES      lojas (loja_id)
ON DELETE       NO ACTION
ON UPDATE       NO ACTION;

-- Alteração de tabela envios para adicionar uma fk na coluna loja_id.
ALTER TABLE     envios                      ADD CONSTRAINT  lojas_envios_fk
                FOREIGN KEY (loja_id)       REFERENCES      lojas (loja_id)
ON DELETE       NO ACTION
ON UPDATE       NO ACTION;

-- Alteração de tabela estoques para adicionar uma fk na coluna loja_id.
ALTER TABLE     estoques                    ADD CONSTRAINT  lojas_estoques_fk
                FOREIGN KEY (loja_id)       REFERENCES      lojas (loja_id)
ON DELETE       NO ACTION
ON UPDATE       NO ACTION;

-- Alteração de tabela pedidos para adicionar uma fk na coluna cliente_id.
ALTER TABLE     pedidos                     ADD CONSTRAINT  clientes_pedidos_fk
                FOREIGN KEY (cliente_id)    REFERENCES      clientes (cliente_id)
ON DELETE       NO ACTION
ON UPDATE       NO ACTION;

-- Alteração de tabela envios para adicionar uma fk na coluna cliente_id.
ALTER TABLE     envios                      ADD CONSTRAINT  clientes_envios_fk
                FOREIGN KEY (cliente_id)    REFERENCES      clientes (cliente_id)
ON DELETE       NO ACTION
ON UPDATE       NO ACTION;

-- Alteração de tabela pedidos_itens para adicionar uma fk na coluna envio_id.
ALTER TABLE     pedidos_itens               ADD CONSTRAINT  envios_pedidos_itens_fk
                FOREIGN KEY (envio_id)      REFERENCES      envios (envio_id)
ON DELETE       NO ACTION
ON UPDATE       NO ACTION;

-- Alteração de tabela pedidos_itens para adicionar uma fk na coluna pedido_id.
ALTER TABLE     pedidos_itens               ADD CONSTRAINT  pedido_pedidos_itens_fk
                FOREIGN KEY (pedido_id)     REFERENCES      pedidos (pedido_id)
ON DELETE       NO ACTION
ON UPDATE       NO ACTION;

