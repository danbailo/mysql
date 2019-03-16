create DATABASE COMERCIO;

USE COMERCIO;

CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT, #O BANCO INCREMENTA SOZINHO A VARIAVEL EX I++
	NOME VARCHAR(30) NOT NULL, #O BANCO NAO DEIXA O DADO ENTRAR SEM UM NOME
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE, #UMA COLUNA N TENHA VALORES REPITIDOS, EX: UM EMAIL E UNICO NO MUNDO INTEIRO
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('COM','RES','CEL'),#SE EU COLOCAR UNIQUE AQUI, SOMENTE UMA PESSOA TERA CEL, UMA TERA COM, E SO UMA TERA RES
	NUMERO VARCHAR(10),
	ID_CLIENTE INT,
	FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE) #CONVENCIONAR, CHAVE PRIMARIA NAO TEM UNDERLINE, CHAVE ESTRAGEIRA SIM
);

CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(30) NOT NULL,# SE EU COLOCAR UNIQUE, EU N VOU PODER TER CLIENTE MORANDO NA MESMA RUA
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE,
	FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE) #CONVENCIONAR, CHAVE PRIMARIA NAO TEM UNDERLINE, CHAVE ESTRAGEIRA SIM
);

/* FOREIGN KEY - CHAVE ESTRANGEIRA - FK */

/* É A CHAVE PRIMÁRIA DE UMA TABELA, QUE VAI ATE OUTRA TABELA FAZER REFERENCIA */

/* EM RELACIONAMENTOS 1 X 1 A CHAVE ESTRANGEIRA FICA NA TABELA MAIS FRACA 
   SE É RELACIONAMENTO 1 X 1, VAI TER UNIQUE NA CHAVE!
*/

/* É INSERIDA NA ENTIDADE MAIS FRACA DE UM RELACIONAMENTO, EX:
   NO RELACIONAMENTO CLIENTE E ENDEREÇO, QUAL É A ENTIDADE MAIS FRACA ?
   É O ENDEREÇO, POIS PODEMOS CADASTRAR UM CLIENTE SEM UM ENDEREÇO, MAS NAO PODEMOS 
   CADASTRAR UM ENDEREÇO SEM UM CLIENTE!
*/

/* EM RELACIONAMENTOS 1 X N, A CHAVE ESTRANGEIRA FICARA SEMPRE NA TABELA N */

SHOW DATABASES; #MOSTRA OS BANCOS

SHOW TABLES;

#passar null no auto increment, pois o banco que irá cuidar disso
INSERT INTO CLIENTE VALUES(NULL,'JOAO','M','JOAO@IG.COM','98547-6');
INSERT INTO CLIENTE VALUES(NULL,'CARLOS','M','CARLOS@TERA.COM','86664-7');
INSERT INTO CLIENTE VALUES(NULL,'ANA','F','ANA@GLOBO.COM','75658-5');
INSERT INTO CLIENTE VALUES(NULL,'JORGE','M','JORGE@IG.COM','88657-5');
INSERT INTO CLIENTE VALUES(NULL,'CLARA','M',NULL,'99754-7');
INSERT INTO CLIENTE VALUES(NULL,'CELIA','F','JOAO@TERRA.COM','77558-5');

SELECT * FROM CLIENTE;

/* INSERINDO UM REGISTRO ERRADO */

INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','M','JOAO@IG.COM');

/*CORRIGINDO*/

INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','M',NULL,'78558-6');
INSERT INTO CLIENTE VALUES(NULL,'JOAO','M',NULL,'86695-6');

#ELE NAO DEIXA ENTRAR, SO PODE SER 'M' OU 'F'
INSERT INTO CLIENTE VALUES(NULL,'DANIEL','G',NULL,'86695-6');

#CONTA A QTD DE REGISTROS DA TABLE;
SELECT COUNT(*) FROM CLIENTE;

DESC ENDERECO;

INSERT INTO ENDERECO VALUES(NULL,'RUA A','CENTRO','B. HORIZONTE','MG',4);
INSERT INTO ENDERECO VALUES(NULL,'RUA B','CENTRO','RIO DE JANEIRO','RJ',1);
INSERT INTO ENDERECO VALUES(NULL,'RUA C','JARDINS','SAO PAULO','SP',3);
INSERT INTO ENDERECO VALUES(NULL,'RUA B','ESTACIO','RIO DE JANEIRO','RJ',8);
INSERT INTO ENDERECO VALUES(NULL,'RUA Z','CRUZEIRO','B. HORIZONTE','MG',2);
INSERT INTO ENDERECO VALUES(NULL,'RUA X','FLAMENGO','RIO DE JANEIRO','RJ',7);
INSERT INTO ENDERECO VALUES(NULL,'RUA Z','CRUZEIRO','B. HORIZONTE','MG',5);
INSERT INTO ENDERECO VALUES(NULL,'RUA X','CENTRO','NITERÓI','RJ',6);

#isso da erro, pq nao existe essa chave na table cliente
INSERT INTO ENDERECO VALUES(NULL,'RUA X','CENTRO','NITERÓI','RJ',10);

#isso da erro pq n pode duplicar chave primaria/estrangeira
INSERT INTO ENDERECO VALUES(NULL,'RUA X','CENTRO','NITERÓI','RJ',1);

/*
"DELETA SOMENTE OS REGISTROS DA TABELA, POREM NAO RESETA O CONTADOR"
DELETE FROM ENDERECO
WHERE IDENDERECO = 2;

DELETE FROM ENDERECO WHERE IDENDERECO > 2 AND IDENDERECO < 10;
 */

/*
"DELETA A TABLE INTEIRA"
DROP TABLE ENDERECO;
*/

INSERT INTO TELEFONE VALUES(NULL,'CEL','9955331',1);
INSERT INTO TELEFONE VALUES(NULL,'COM','6574565',3);
INSERT INTO TELEFONE VALUES(NULL,'CEL','8864566',2);
INSERT INTO TELEFONE VALUES(NULL,'CEL','5557798',7);
INSERT INTO TELEFONE VALUES(NULL,'COM','6765768',1);
INSERT INTO TELEFONE VALUES(NULL,'RES','5676765',6);
INSERT INTO TELEFONE VALUES(NULL,'CEL','5765547',1);
INSERT INTO TELEFONE VALUES(NULL,'CEL','8865645',7);
INSERT INTO TELEFONE VALUES(NULL,'RES','7555446',7);
INSERT INTO TELEFONE VALUES(NULL,'CEL','5788654',3);
INSERT INTO TELEFONE VALUES(NULL,'CEL','7865644',6);
INSERT INTO TELEFONE VALUES(NULL,'RES','5754644',6);

SELECT * FROM TELEFONE WHERE TIPO='CEL' AND ID_CLIENTE=1;

SELECT * FROM CLIENTE;
SELECT * FROM ENDERECO;
SELECT * FROM TELEFONE;

/*SELECAO, PROJECAO E JUNCAO*/

/* PROJECAO - TUDO O QUE VÊ NA TELA*/

SELECT NOW() AS "DATA";

SELECT NOME, NOW() AS "DATA"
FROM CLIENTE;

/* SELECAO - TEORIA DOS CONJUNTOS - WHERE É A CLAUSULA DE SELEÇÃO */
SELECT NOME, NOW() AS "DATA"
FROM CLIENTE
WHERE SEXO = "M";

SELECT NOME, NOW() AS DATA FROM CLIENTE WHERE SEXO = 'M';

#MUDANDO O SEXO DA CLARA PARA FEMININO
UPDATE CLIENTE
SET SEXO = 'F'
WHERE IDCLIENTE = 5; #SELEÇÃO

SELECT NOME, SEXO, BAIRRO, CIDADE, NOW() AS "DATA"
FROM CLIENTE, ENDERECO #A VIRGULA SERIA PRA SETAR OUTRA TABELA
WHERE IDCLIENTE = ID_CLIENTE; #AQUI, SETAMOS AS CHAVES PRIMARIAS COMO A MESMA ESTRANGEIRA

-- SELECT IDCLIENTE, NOME, SEXO, BAIRRO, CIDADE, NOW() AS "DATA"
-- FROM CLIENTE, ENDERECO
-- WHERE IDCLIENTE = ID_CLIENTE;

-- SELECT ID_CLIENTE, NOME, SEXO, BAIRRO, CIDADE, NOW() AS "DATA"
-- FROM CLIENTE, ENDERECO
-- WHERE IDCLIENTE = ID_CLIENTE;

SELECT NOME, SEXO, BAIRRO, CIDADE, NOW() AS "DATA"
FROM CLIENTE, ENDERECO
WHERE IDCLIENTE = ID_CLIENTE /* WHERE E UM COMANDO DE SELECT NAO DE JOIN*/
AND BAIRRO = 'CENTRO'; /* SELECAO - NAO FAZER ISSO, POIS ISSO SERIA UM COMANDO DE JUNCAO,
 E DA MANEIRA QUE CONFIGURAMOS, ESSAS CHAVES SEMPRE SERAO IGUAIS*/

/* JUNÇÃO - JOIN, INNER JOIN */

SELECT NOME, SEXO, BAIRRO, CIDADE /* PROJECAO */
FROM CLIENTE
INNER JOIN ENDERECO /* JUNCAO */
ON IDCLIENTE = ID_CLIENTE
WHERE BAIRRO = 'CENTRO'; /* SELECAO */


#ESSE SCRIPT DARÁ UM ERRO DE AMBIGUIDADE
SELECT NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE
INNER JOIN TELEFONE
ON IDCLIENTE = ID_CLIENTE;

#CORREÇÃO DO ERRO DE AMBIGUIDADE E MANEIRA DE TRABALHO
#1 forma
SELECT CLIENTE.NOME, CLIENTE.SEXO, 
ENDERECO.BAIRRO, ENDERECO.CIDADE, 
TELEFONE.TIPO, TELEFONE.NUMERO
FROM CLIENTE
INNER JOIN ENDERECO
ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
INNER JOIN TELEFONE
ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

#2 forma
SELECT C.NOME, C.SEXO, 
E.BAIRRO, E.CIDADE, 
T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

#PROJECAO, JOIN E SELECAO
SELECT C.NOME, C.SEXO, 
E.BAIRRO, E.CIDADE, 
T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'M';

/* A23 Queries - SELECAO - PROJECAO E JUNCAO */

/* PARA UMA CAMPANHA DE MARKETING, O SETOR SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
DOS CLIENTES QUE MORAM NO ESTADO DO RIO DE JANEIRO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */

SELECT C.NOME, C.EMAIL, T.NUMERO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
WHERE TIPO = 'CEL' AND ESTADO = 'RJ';

+---------+----------------+---------+
| NOME    | EMAIL          | NUMERO  |
+---------+----------------+---------+
| JOAO    | JOAO@IG.COM    | 9955331 |
| JOAO    | JOAO@IG.COM    | 5765547 |
| ANTONIO | NULL           | 5557798 |
| ANTONIO | NULL           | 8865645 |
| CELIA   | JOAO@TERRA.COM | 7865644 |
+---------+----------------+---------+


/* PARA UMA CAMPANHA DE PRODUTOS DE BELEZA, O COMERCIAL SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
DAS MULHERES QUE MORAM NO ESTADO DE SÃO PAULO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */

SELECT C.NOME, C.EMAIL, T.NUMERO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
WHERE SEXO = 'F' AND TIPO = 'CEL' AND ESTADO = 'SP';

+------+---------------+---------+
| NOME | EMAIL         | NUMERO  |
+------+---------------+---------+
| ANA  | ANA@GLOBO.COM | 5788654 |
+------+---------------+---------+

/* IFNULL */

SELECT C.NOME,
	   IFNULL(C.EMAIL,'SEM EMAIL'), 
	   T.NUMERO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
WHERE TIPO = 'CEL' AND ESTADO = 'RJ';

+---------+-----------------------------+---------+
| NOME    | IFNULL(C.EMAIL,'SEM EMAIL') | NUMERO  |
+---------+-----------------------------+---------+
| JOAO    | JOAO@IG.COM                 | 9955331 |
| JOAO    | JOAO@IG.COM                 | 5765547 |
| ANTONIO | SEM EMAIL                   | 5557798 |
| ANTONIO | SEM EMAIL                   | 8865645 |
| CELIA   | JOAO@TERRA.COM              | 7865644 |
+---------+-----------------------------+---------+

SELECT C.NOME AS "CLIENTE",
	   IFNULL(C.EMAIL,'SEM EMAIL') AS "EMAIL", 
	   T.NUMERO AS "CELULAR"
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
WHERE TIPO = 'CEL' AND ESTADO = 'RJ';

+---------+----------------+---------+
| CLIENTE | EMAIL          | CELULAR |
+---------+----------------+---------+
| JOAO    | JOAO@IG.COM    | 9955331 |
| JOAO    | JOAO@IG.COM    | 5765547 |
| ANTONIO | SEM EMAIL      | 5557798 |
| ANTONIO | SEM EMAIL      | 8865645 |
| CELIA   | JOAO@TERRA.COM | 7865644 |
+---------+----------------+---------+

/* VIEW OU VISÕES - GERALMENTE É SOLICITADO PELO PROGRAMADOR */

SELECT C.NOME, 
	   C.SEXO,
	   IFNULL(C.EMAIL, "SEM EMAIL") AS "EMAIL",
	   T.TIPO,
	   T.NUMERO,
	   E.BAIRRO,
	   E.CIDADE,
	   E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

/* CRIANDO A VIEW */

CREATE VIEW RELATORIO AS
SELECT C.NOME, 
	   C.SEXO,
	   IFNULL(C.EMAIL, "SEM EMAIL") AS "EMAIL",
	   T.TIPO,
	   T.NUMERO,
	   E.BAIRRO,
	   E.CIDADE,
	   E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

SELECT * FROM RELATORIO;
#EM TERMOS DE PERFORMANCE, A VIEW É MAIS PESADA DO QUE FAZER A QUERY MANUALMENTE

SELECT * FROM RELATORIO
WHERE SEXO = 'F';

SELECT * FROM CLIENTE; #CELIA COM EMAIL DO JOAO

UPDATE CLIENTE
SET EMAIL = 'CELIA@GMAIL.COM'
WHERE IDCLIENTE = 6; #SELEÇÃO

SHOW TABLES;
+--------------------+
| Tables_in_COMERCIO |
+--------------------+
| CLIENTE            |
| ENDERECO           |
| RELATORIO          |
| TELEFONE           |
+--------------------+

/* COMO SABER QUEM É TABELA E QUEM É VIEW? */

/* APAGANDO UMA VIEW */

DROP VIEW RELATORIO;

/* É UMA QUESTÃO DE ORGANIZAÇÃO, LOGO, SEMPRE QUE EU CRIAR UMA VIEW, DEVO INDICAR QUE É UMA
VIEW PELO SEU NOME, EX: V_RELATORIO */ /* OUTRA FORMA É UTILIZANDO DICIONÁRIO DE DADOS, MAIS A FRENTE */


CREATE VIEW V_RELATORIO AS
SELECT C.NOME, 
	   C.SEXO,
	   IFNULL(C.EMAIL, "SEM EMAIL") AS "EMAIL",
	   T.TIPO,
	   T.NUMERO,
	   E.BAIRRO,
	   E.CIDADE,
	   E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

DESC V_RELATORIO;

SELECT NOME, CIDADE, SEXO
FROM V_RELATORIO;

+---------+----------------+------+
| NOME    | CIDADE         | SEXO |
+---------+----------------+------+
| JOAO    | RIO DE JANEIRO | M    |
| JOAO    | RIO DE JANEIRO | M    |
| JOAO    | RIO DE JANEIRO | M    |
| CARLOS  | B. HORIZONTE   | M    |
| ANA     | SAO PAULO      | F    |
| ANA     | SAO PAULO      | F    |
| CELIA   | NITERÓI        | F    |
| CELIA   | NITERÓI        | F    |
| CELIA   | NITERÓI        | F    |
| ANTONIO | RIO DE JANEIRO | M    |
| ANTONIO | RIO DE JANEIRO | M    |
| ANTONIO | RIO DE JANEIRO | M    |
+---------+----------------+------+

/* NAO É POSSIVEL INSERIR NEM DELETAR VALORES NUMA VIEW DE JOIN! */

----

/* TODA QUERY RETORNA UM DATASET (CONJUNTO DE DADOS) */
/* ORDER BY - ORDERNA O DATASET*/

SELECT NOME, SEXO, CPF, CIDADE
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE;
+---------+------+---------+----------------+
| NOME    | SEXO | CPF     | CIDADE         |
+---------+------+---------+----------------+
| JOAO    | M    | 98547-6 | RIO DE JANEIRO |
| CARLOS  | M    | 86664-7 | B. HORIZONTE   |
| ANA     | F    | 75658-5 | SAO PAULO      |
| JORGE   | M    | 88657-5 | B. HORIZONTE   |
| CLARA   | F    | 99754-7 | B. HORIZONTE   |
| CELIA   | F    | 77558-5 | NITERÓI        |
| ANTONIO | M    | 78558-6 | RIO DE JANEIRO |
| JOAO    | M    | 86695-6 | RIO DE JANEIRO |
+---------+------+---------+----------------+


SELECT NOME, SEXO, CPF, CIDADE
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE
ORDER BY NOME;
+---------+------+---------+----------------+
| NOME    | SEXO | CPF     | CIDADE         |
+---------+------+---------+----------------+
| ANA     | F    | 75658-5 | SAO PAULO      |
| ANTONIO | M    | 78558-6 | RIO DE JANEIRO |
| CARLOS  | M    | 86664-7 | B. HORIZONTE   |
| CELIA   | F    | 77558-5 | NITERÓI        |
| CLARA   | F    | 99754-7 | B. HORIZONTE   |
| JOAO    | M    | 98547-6 | RIO DE JANEIRO |
| JOAO    | M    | 86695-6 | RIO DE JANEIRO |
| JORGE   | M    | 88657-5 | B. HORIZONTE   |
+---------+------+---------+----------------+

SELECT NOME, SEXO, CPF, CIDADE
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE
ORDER BY NOME, CPF ASC;
+---------+------+---------+----------------+
| NOME    | SEXO | CPF     | CIDADE         |
+---------+------+---------+----------------+
| ANA     | F    | 75658-5 | SAO PAULO      |
| ANTONIO | M    | 78558-6 | RIO DE JANEIRO |
| CARLOS  | M    | 86664-7 | B. HORIZONTE   |
| CELIA   | F    | 77558-5 | NITERÓI        |
| CLARA   | F    | 99754-7 | B. HORIZONTE   |
| JOAO    | M    | 86695-6 | RIO DE JANEIRO |
| JOAO    | M    | 98547-6 | RIO DE JANEIRO |
| JORGE   | M    | 88657-5 | B. HORIZONTE   |
+---------+------+---------+----------------+

#ORDENACAO PELA ORDEM DA COLUNA
SELECT NOME, SEXO, CPF, CIDADE
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE
ORDER BY 4;
+---------+------+---------+----------------+
| NOME    | SEXO | CPF     | CIDADE         |
+---------+------+---------+----------------+
| CARLOS  | M    | 86664-7 | B. HORIZONTE   |
| CLARA   | F    | 99754-7 | B. HORIZONTE   |
| JORGE   | M    | 88657-5 | B. HORIZONTE   |
| CELIA   | F    | 77558-5 | NITERÓI        |
| JOAO    | M    | 86695-6 | RIO DE JANEIRO |
| JOAO    | M    | 98547-6 | RIO DE JANEIRO |
| ANTONIO | M    | 78558-6 | RIO DE JANEIRO |
| ANA     | F    | 75658-5 | SAO PAULO      |
+---------+------+---------+----------------+

SELECT NOME, SEXO, CPF, CIDADE
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = ID_CLIENTE
ORDER BY 2;

/* DELIMITADOR E ESTADO DE SERVIDOR  */

SELECT * FROM V_RELATORIO

SELECT * FROM V_RELATORIO;

SELECT 'DANIEL', "BAILO"; #sempre abrir e fechar as strings

#trocando o delimitador, por default é o ;
DELIMITER $

SELECT * FROM V_RELATORIO;
SELECT * FROM V_RELATORIO$

STATUS #mostra o status do banco bem como o delimitador

#nao reconhece por q precisa dar um espaco apos o comando para definir o delimiter
DELIMITER# 
#nessa versao do banco, mesmo tendo mais de um espaço ele reconhece
DELIMITER  #

/* PROCEDURES */

/* SEMPRE */
#DELIMITER $

SELECT 10 + 10 AS "CONTA";
+-------+
| CONTA |
+-------+
|    20 |
+-------+

#ESTRUTURA DE UM PROCEDURE
CREATE PROCEDURE CONTA()
BEGIN

END
$

DELIMITER $
CREATE PROCEDURE CONTA()
BEGIN
		SELECT 10 + 10 AS "CONTA";
END
$

/* CHAMANDO A PROCEDURE */

CALL CONTA()$

DELIMITER ;

CALL CONTA();

DROP PROCEDURE CONTA; # APAGA O PROCEDURE

/*PROCEDURES COM PARAMETROS */

DELIMITER $

CREATE PROCEDURE SOMA(NUMERO1 INT, NUMERO2 INT)
BEGIN
		SELECT NUMERO1 + NUMERO2 AS "SOMA"; #ESSE ALIAS N TEM NADA HAVER COM O NOME DO PROCEDURE
END
$

DELIMITER ;

CALL SOMA(100,78);
+------+
| SOMA |
+------+
|  178 |
+------+

CALL SOMA(47456,346435);
CALL SOMA(64577,85546);

/* PROCEDURES COM TABELAS */

CREATE TABLE CURSOS(
	IDCURSO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	HORAS INT(3) NOT NULL,
	VALOR FLOAT(10,2) NOT NULL#10 CASAS NO TOTAL ONDE APENAS 2 SAO DECIMAIS
);

INSERT INTO CURSOS VALUES(1, "TESTE", 64, 500.00);

DELETE FROM CURSOS
WHERE IDCURSO=1;

#INSERT INTO CURSOS VALUES("TESTANDO", 64, 500.00); #MESMO COM O AUTOINCREMENT E IMPOSSIVEL INSERIR VALORES
# SEM DEFINIR UM VALOR NO PARAMETRO

#PARA INSERIR COM O AUTOINCREMENT, SEMPRE COLOCAR NULL NO PARAMETRO, POIS O BANCO Q VAI INCREMENTAR
INSERT INTO CURSOS VALUES(NULL, "TESTE", 64, 500.00);

SELECT * FROM CURSOS;
+---------+-------+-------+--------+
| IDCURSO | NOME  | HORAS | VALOR  |
+---------+-------+-------+--------+
|       2 | TESTE |    64 | 500.00 |
|       3 | TESTE |    64 | 500.00 |
|       4 | TESTE |    64 | 500.00 |
+---------+-------+-------+--------+


DELIMITER $

#O P_ SERVE PARA DIFERENCIAR PARAMETRO DE VARIÁVEL
CREATE PROCEDURE CAD_CURSO(P_NOME VARCHAR(30), P_HORAS INT(3), P_PRECO FLOAT(10,2))
BEGIN
		INSERT INTO CURSOS VALUE(NULL, P_NOME, P_HORAS, P_PRECO);
END
$

DELIMITER ;

CALL CAD_CURSO("ALGEBRA LINEAR", 64, 127.00);
SELECT * FROM CURSOS;

CALL CAD_CURSO("TEORIA DOS GRAFOS", 64, 200.1234); #SO VAI ADD 2 CASAS DECIMAIS, COMO FOI SETADO

DELIMITER $

CREATE PROCEDURE SEL_CURSO()
BEGIN
		SELECT IDCURSO, NOME, HORAS, VALOR
		FROM CURSOS;
END
$

DELIMITER ;

CALL SEL_CURSO();

/* FUNCOES DE AGREGAÇÃO NUMERICAS */

CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	SEXO CHAR(1),
	JANEIRO FLOAT(10,2),
	FEVEREIRO FLOAT(10,2),
	MARCO FLOAT(10,2)
);

INSERT INTO VENDEDORES VALUES(NULL,'CARLOS','M',76234.78,88346.87,5756.90);
INSERT INTO VENDEDORES VALUES(NULL,'MARIA','F',5865.78,6768.87,4467.90);
INSERT INTO VENDEDORES VALUES(NULL,'ANTONIO','M',78769.78,6685.87,6664.90);
INSERT INTO VENDEDORES VALUES(NULL,'CLARA','F',5779.78,446886.87,8965.90);
INSERT INTO VENDEDORES VALUES(NULL,'ANDERSON','M',676545.78,77544.87,578665.90);
INSERT INTO VENDEDORES VALUES(NULL,'IVONE','F',57789.78,44774.87,68665.90);
INSERT INTO VENDEDORES VALUES(NULL,'JOAO','M',4785.78,66478.87,6887.90);
INSERT INTO VENDEDORES VALUES(NULL,'CELIA','F',89667.78,57654.87,5755.90);

UPDATE VENDEDORES
SET NOME = 'JOAO'
WHERE IDVENDEDOR = 7;

SELECT * FROM VENDEDORES;

/* MAX - TRAZ O VALOR MÁXIMO DE UMA COLUNA */ 

SELECT MAX(FEVEREIRO) AS "MAX_VALUE"
FROM VENDEDORES;

/* MIN - TRAZ O VALOR MINIMO DE UMA COLUNA */ 

SELECT MIN(FEVEREIRO) AS "MIN_VALUE"
FROM VENDEDORES;

/* AVERAGE - TRAZ O VALOR MÉDIO DE UMA COLUNA */

SELECT AVG(FEVEREIRO) AS "MEDIA_FEVEREIRO"
FROM VENDEDORES;

/* VARIAS FUNÇÕES */

SELECT MAX(JANEIRO) AS MAX_JAN,
	   MIN(JANEIRO) AS MIN_JAN,
	   AVG(JANEIRO) AS AVG_JAN
	   FROM VENDEDORES;

/* TRUNCATE(X,Y) */

SELECT MAX(JANEIRO) AS MAX_JAN,
	   MIN(JANEIRO) AS MIN_JAN,
	   TRUNCATE(AVG(JANEIRO),2) AS AVG_JAN
	   FROM VENDEDORES;

/* AGREGANDO VALORES COM SUM() */

SELECT SUM(JANEIRO) AS SUM_JAN
FROM VENDEDORES;

SELECT SUM(JANEIRO) AS SUM_JAN,
       SUM(FEVEREIRO) AS SUM_FEV,
       SUM(MARCO) AS SUM_MAR
	   FROM VENDEDORES;

/* AGRUPANDO VALORES */

SELECT SEXO, SUM(MARCO) AS TOTAL_MARCO
FROM VENDEDORES
GROUP BY SEXO;

+------+-------------+
| SEXO | TOTAL_MARCO |
+------+-------------+
| F    |    87855.60 |
| M    |   597975.57 |
+------+-------------+

/*  SUBQUERIES

VENDEDOR QUE VENDEU MENOS EM MARCO E O SEU NOME */

SELECT * FROM VENDEDORES;

SELECT NOME, MIN(MARCO) AS VALOR
FROM VENDEDORES; #ERRO

#ESSA QUERY TRAZ O VALOR MINIMO DE MARCO
SELECT MIN(MARCO)
FROM VENDEDORES;

SELECT NOME, MARCO AS VALOR
FROM VENDEDORES
WHERE MARCO = (SELECT MIN(MARCO) FROM VENDEDORES); #INNER QUERY, ELA É RESOLVIDA PRIMEIRO

SELECT NOME, MARCO AS VALOR
FROM VENDEDORES
WHERE MARCO = (SELECT MAX(MARCO) FROM VENDEDORES);


#VALOR MAIOR QUE A MEDIA
SELECT NOME, FEVEREIRO AS VALOR
FROM VENDEDORES
WHERE FEVEREIRO > (SELECT AVG(FEVEREIRO) FROM VENDEDORES);

#VALOR MENOR QUE A MEDIA
SELECT NOME, FEVEREIRO AS VALOR
FROM VENDEDORES
WHERE FEVEREIRO < (SELECT AVG(FEVEREIRO) FROM VENDEDORES);

/*A INNER QUERY TROUXE 1 RESULTADO, MAS SE O SELECTION TIVESSE UM AND POR EXEMPLO,
ELA PRECISARIA TRAZER 2 RESULTADOS, PARA BATER COM A LOGICA DO WHERE*/

SELECT NOME,MARCO FROM VENDEDORES;
SELECT AVG(MARCO) FROM VENDEDORES;