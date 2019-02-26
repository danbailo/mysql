/* Modelagem Básica - 
ENTIDADE = TABELA 
CAMPOS = ATRIBUTOS
*/
/*Structured Query Language, ou Linguagem de Consulta Estruturada*/

/*

1 caracter = 1 byte

char - estatico -> char(10) = 10bytes
varchar - variante, dinamico -> varchar(10) = joao = 4bytes

char - n gasta tempo variando, usar quando ter certeza do tamanhado da string
varchar - usar quando nao ter certeza da qtd de caracteres q pode ser inserido, um uso generico

 */

-- CLIENTE

-- NOME - CARACTER(30)
-- CPF - NUMÉRICO(11)
-- EMAIL - CARACTER(30)
-- TELEFONE - CARACTER(30)
-- ENDERECO - CARACTER(100)
-- SEXO - CARACTER(1)

/* PROCESSOS DE MODELAGEM */

/* FASE 01 E FASE 02 - AD ADM DE DADOS */
-- MODELAGEM CONCEITUAL - RASCUNHO
-- MODELAGEM LÓGICA - MODELAGEM

/* FASE 03 - DBA / AD */
-- MODELAGEM FÍSICA - SCRIPTS DE BANCO

/* INICIANDO A MODELAGEM FÍSICA*/

/* CRIANDO O BANCO DE DADOS */ 

CREATE DATABASE PROJETO;

/* CONECTANDO-SE AO BANCO */

USE PROJETO;

/* CRIANDO A TABELA DE CLIENTES */

CREATE TABLE CLIENTE(
    NOME VARCHAR(30),
    SEXO CHAR(1),
    EMAIL VARCHAR(30),
    CPF INT(11),
    TELEFONE VARCHAR(30),
    ENDERECO VARCHAR(100)
);

/* VERIFICANDO AS TABELAS DO BANCO */

SHOW TABLES; #so existe no mysql, ele é um ponteiro pra um select from dic. dados - todo banco tem

/* DESCOBRINDO COMO É A ESTRUTURA DE UMA TABELA */

DESC CLIENTE;

/* sintaxe basica de inserção(qqr banco) - INSERT INTO NOME_TABELA */

/* FORMA 1 - OMITINDO AS COLUNAS */ -- NÃO RECOMENDADO

INSERT INTO CLIENTE VALUES('JOAO','M','JOAO@GMAIL.COM',988638273,'22923110','MAIA LARCERDA - ESTACIO - RIO DE JANEIRO - RJ');
INSERT INTO CLIENTE VALUES('CELIA','F','CELIA@GMAIL.COM',541521456,'25078869','RIACHUELO - CENTRO - RIO DE JANEIRO - RJ');
INSERT INTO CLIENTE VALUES('JORGE','M','JORGE@GMAIL.COM',885755896,'58748895','OSCAR CURY - BOM RETIRO - PASSOS DE MINAS - MG');

/* FORMA 2 - COLOCANDO AS COLUNAS */ -- MELHOR MODO

INSERT INTO	CLIENTE(NOME,SEXO,ENDERECO,TELEFONE,CPF) VALUES('LILIAN','F','SENADOR SOARES - TIJUCA - RIO DE JANEIRO - RJ','947785696',887774856);

/* FORMA 3 - INSERT COMPACTO - SOMENTE NO MYSQL */

INSERT INTO CLIENTE VALUES('ANA','F','ANA@GMAIL.COM',85548962,'548556985','PIRES ANTONIO - CENTRO - RIO DE JANEIRO - RJ'),('CARLA','F','CARLA@GMAIL.COM',7745828,'66587458','ITIBERE VIEIRA - ESTACIO - PONTA PORA - MS');

/* O COMANDO SELECT
projecao, selecao e juncao
 */

#PROJECAO - SELECT
#SELECAO - WHERE
#JUNCAO - INTERSESSAO

#SELECT - FAZ PARTE DA PROJECAO; PROJETA NA TELA

SELECT NOW();

SELECT NOW() as DATA_HORA, 'DANIEL BAILO' as ALUNO; #so esta projetando, n quer dizer que criou

/*alias de colunas*/

#projetando dados do banco;
SELECT NOME, SEXO, EMAIL FROM CLIENTE;

#alias para a coluna
SELECT NOME AS CLIENTE, SEXO, EMAIL FROM CLIENTE;

SELECT NOME AS CLIENTE, EMAIL, SEXO, ENDERECO FROM CLIENTE; #query maior/ consula maior

SELECT NOME AS CLIENTE, EMAIL, SEXO, ENDERECO, NOW() AS DATA_HORA FROM CLIENTE; #mesclado com uma projecao nao existente

SELECT NOME FROM CLIENTE WHERE SEXO='M'; #query específica

#ex: SELECT NOME, SOBRENOME FROM USUARIOS WHERE RG=''55.555.555-55''

/* APENAS PARA FINS ACADEMICOS */ #mostra toda a query
SELECT * FROM CLIENTE;
# nao usar pois trafega mais dados na rede, o ideal e mostrar o que o usuario quer, nao todo o banco
#ele mata o indice, faz um full scan
#o indice faz um intervalo

/* FILTRANDO DADOS COM WHERE E LIKE */

SELECT NOME, TELEFONE FROM CLIENTE; 
/* FILTRANDO */

SELECT NOME, SEXO FROM CLIENTE #so projeta os parametros do select, filtrando pelo sexo;
WHERE SEXO = 'M';

SELECT NOME, ENDERECO FROM CLIENTE
WHERE SEXO = 'F';

SELECT NOME FROM CLIENTE
WHERE ENDERECO = 'PONTA PORA'; #empty set - conjunto vazio, logo n tem nenhum dado corresponde a esta query

#logo, banco de dados = teoria dos conjuntos;

SELECT NOME, SEXO FROM CLIENTE
WHERE ENDERECO = 'RJ'; #ira trazer somente os "IGUAIS"
#Empty set, conjunto vazio!

/* UTILIZANDO LIKE - VAI NO LUGAR DO IGUAL, SIGNIFICA "COMO" */

SELECT NOME, SEXO FROM CLIENTE
WHERE ENDERECO LIKE 'RJ';

/* CARACTER CORINGA % -> QQR COISA*/

SELECT NOME, SEXO FROM CLIENTE
WHERE ENDERECO LIKE '%RJ'; #significa que ja começa com algo, ou seja, qqr string q venha antes e contenha RJ/termine com RJ

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE ENDERECO LIKE '%RJ';

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE ENDERECO LIKE 'OSCAR CURY%'; #pegando a partir de um comeco, supondo q eu nao saiba o resto

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE ENDERECO LIKE '%CENTRO%'; #PEGANDO NO MEIO DE DUAS STRINGS

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE ENDERECO LIKE '____________CENTRO%';#vamos supor q tenha centro, mas contenha 5 caracteres, eu 
#os represento utilizando "underline", pode ser no comeco, fim, meio,etc
#deixa a query mais específica ainda, *intervalo fechado, pegara exatamente a qtd de caracteres, nem mais e nem menos

#LIKE DEGRADA PERFORMANCE, E PREFERIVEL USAR IGUALDADE, POREM AS VEZES E INEVITÁVEL
#AJAX - vai mostrando o conteudo conforme a pessoa vai digitando numa caixa de pesquisa, sem submeter a entrada

/* A11 - OPERADORES LÓGICOS */

/* OR */

SELECT NOME, EMAIL FROM CLIENTE
WHERE
SEXO = 'M' OR ENDERECO LIKE '%RJ';

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'M' OR ENDERECO LIKE '%RJ';

SELECT NOME, SEXO, ENDERECO FROM CLIENTE
WHERE
SEXO = 'F' OR ENDERECO LIKE '%PLANALTO%'; #so contem uma verdade

/* AND */

SELECT NOME, EMAIL FROM CLIENTE
WHERE
SEXO = 'M' AND ENDERECO LIKE '%RJ';

SELECT NOME, SEXO, ENDERECO FROM CLIENTE 
WHERE
SEXO = 'F' AND ENDERECO LIKE '%ESTACIO'; #EMPTY

SELECT NOME, SEXO, ENDERECO FROM CLIENTE 
WHERE
SEXO = 'F' AND ENDERECO LIKE '%ESTACIO%'; #TRUE

SELECT NOME FROM CLIENTE
WHERE
SEXO LIKE 'M' AND ENDERECO = '%RJ'; #EMPTY -> o igual precisa ser realmente igual

SELECT NOME FROM CLIENTE
WHERE
SEXO LIKE 'M' AND ENDERECO LIKE '%RJ'; #TRUE

/* COUNT (*), GROUP BY, PERFORMANCE COM OPERADORES LOGICOS */

/* CONTANDO OS REGISTROS DE UMA TABELA */

SELECT COUNT(*) FROM CLIENTE; #retorna a qtd de registro de uma table

SELECT COUNT(*) AS "QUANTIDADE" FROM CLIENTE;

/* OPERADOR GROUP BY */

SELECT SEXO, COUNT(*) AS "QUANTIDADE" #ele conta a qtd de sexo total e depois agrupa por distinção de sexo
FROM CLIENTE
GROUP BY SEXO; #agrupar por

/* PERFORMANCE EM OPERADORES LÓGICOS - AVANÇADO*/

/* 1 MILHÃO DE REGISTROS

PARA CONTAR
SELECT COUNT(*) FROM CLIENTE;

SELECT SEXO, COUNT(*) FROM CLIENTE
GROUP BY SEXO;

SELECT CIDADE, COUNT(*) FROM CLIENTE
GROUP BY CIDADE;

*DADOS DO CLIENTE FILTRANDO PELO SEXO E PELA CIDADE

CONDICAO
SEXO = F
CIDADE = RIO DE JANEIRO

SITUACAO - TRATANDO COM OU/OR
70% MULHERES = SEXO = F
30% MORA NO RIO DE JANEIRO - PESSOAS

SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE SEXO = 'F'             --- COLOCAR O QUE CONTEM MAIOR PORCENTAGEM NA FRENTE, POIS ASSIM,
OR CIDADE = 'RIO DE JANEIRO'; -- COMO É UM OR, ELE NEM VAI VERIFICAR A SEGUNDA, PQ ELE JA VAI TRAZER
							-- TODAS AS CONDICOES NA PRIMEIRA VERIFICACAO, "PERFORMANCE"

SITUACAO - TRATANDO COM E/AND
70% MULHERES = SEXO = F
30% MORA NO RIO DE JANEIRO - PESSOAS

#nesse caso eu inverto a ordem, pq no and, para ele retornar o valor, as duas clausulas precisam
#ser verdadeiras, logo, se eu tiver uma q e mentira, ele ja nao ira precisar verificar a outra;
#sendo assim, se eu colocar a menor antes, ele nao vai perder tempo verificando a outra e 
# eu ganho performance com isso
SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE CIDADE = 'RIO DE JANEIRO'
AND SEXO = 'F';

REGRA NUMA QUERY ESPECIFICA - INTERVALO
PARA OU - MAIOR PORCENTAGEM NA FRENTE
PARA E - MENOR PORCENTAGEM NA FRENTE

*/

/* FILTRANDO VALORES NULOS - vale p qqr banco */

SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE EMAIL = NULL; #isso esta errado, pois null eu nao sei o q, logo eu n posso igualar algo a null
#aqui ira retornar empty set;

SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE EMAIL IS NULL;
#aqui retorna a query solicitada!

SELECT NOME, SEXO, ENDERECO
FROM CLIENTE
WHERE EMAIL IS NOT NULL; #inverte o valor

/* UTILIZANDO UPDATE PARA ATUALIZAR VALORES */

SELECT NOME, EMAIL FROM CLIENTE;

UPDATE CLIENTE
SET EMAIL = 'LILIAN@HOTMAIL.COM';
## UTILIZAR O UPDATE SEMPRE COM A CLAUSULA WHERE!
--Nesse caso, como eu nao especifiquei, ele alterou todos os emails para o solicitado

#MANEIRA CORRETA!!
UPDATE CLIENTE
SET EMAIL = 'JOAO@GMAIL.COM'
WHERE NOME = 'JOAO';

UPDATE CLIENTE
SET EMAIL = 'JORGE@GMAIL.COM'
WHERE NOME = 'JORGE';

UPDATE CLIENTE
SET EMAIL = 'CELIA@GMAIL.COM'
WHERE NOME = 'CELIA';

UPDATE CLIENTE
SET EMAIL = 'ANA@GMAIL.COM'
WHERE NOME = 'ANA';

UPDATE CLIENTE
SET EMAIL = 'CARLA@GMAIL.COM'
WHERE NOME = 'CARLA';

/* DELETANDO REGISTROS COM A CLAUSULA DELETE */

--DELETE FROM CLIENTE; /* NUNCA FAZER */

SELECT COUNT(*) FROM CLIENTE;

DELETE FROM CLIENTE
WHERE NOME = 'ANA';

SELECT COUNT(*) FROM CLIENTE; #1 REGISTRO FOI DELETADO!

########################################################################################

/* - ENTRANDO COM MAIS TELEFONES */

#ira substituir o telefone que ja existe no banco, em vez de add mais um
UPDATE CLIENTE 
SET TELEFONE = '97865434'
WHERE NOME = 'JOAO';

UPDATE CLIENTE 
SET TELEFONE = '22923110 - 97865434'
WHERE NOME = 'JOAO';

SELECT ENDERECO, COUNT(*) AS "QUANTIDADE"
FROM CLIENTE
GROUP BY ENDERECO;

/* A17 - HISTORIA DA MODELAGEM 

DECADA DE 70, EUA - CRISE DO SOFTWARE
FOI A CRISE QUE ATINGIU NAO SOMENTE A AREA DE TECNOLOGIA
MAS TAMBÉM TODAS AS EMPRESAS QUE UTILIZAVAM DE SISTEMAS
TECNOLOGICOS PARA CONTROLAR SEUS NEGOCIOS.

NAQUELA EPOCA, PROGRAMAR ERA UM PROCESSO ARTESANAL.
BASTAVA OLHAR O CODIGO QUE VOCE SABERIA QUEM O
ESCREVEU, TAO POUCOS ERAM OS PROGRAMADORES EACHTAO ARCAICO ERAM
OS METODOS DE PROGRAMACAO. EM UM PRIMEIRO MOMENTO,
OS PROFISSIONAIS DE TI VIRAM A NECESSIDADE DE SE PROGRAMAR
E INICIARAM SUA CAMINHADA, CONSTRUINDO SISTEMAS QUE ATENDIAM
NUM PRIMEIRO MOMENTO, MAS DEPOIS TRAZIAM INFORMACOES ERRADAS,
PROVOCANDO A FALENCIA DE DIVERSAS EMPRESAS. LEMBRE-SE: INFORMACOES
ERRADAS PODEM LEVAR A SUA EMPRESA A FALENCIA, E FOI ISSO QUE ACONTECEU.
ISSO OCORRIA POIS OS PROFISSIONAIS SABIAM PROGRAMAR MAS ENTENDIAM APENAS
DO NEGOCIO DAS EMPRESAS DAS QUAIS FAZIAM PARTE. SER TER O KNOW HOW
DOS DEMAIS NEGOCIOS, OS PROGRAMADORES PROGRAMAVAM VOLTADOS PARA OS
PROCEDIMENTOS, E ESSE FOI UM ERRO MORTAL.

PETER CHEN, VENDO TODO ESSE CENARIO AFIRMOU: NAO PODEMOS CRIAR BANCOS
DE DADOS VOLTADOS PARA PROCEDIMENTOS EMPRESARIAIS, POIS OS PROCEDIMENTOS
SOFREM INTERFERENCIAS EXTERNAS E PODEM SER ALTERADOS. A UNICA COISA
QUE NAO SOFRE ALTERACAO SAO OS DADOS.

POR EXEMPLO, ARMAZENAMOS NO BANCO A VENDA DE JANEIRO, FEVEREIRO E MARCO
O TOTAL DAS VENDAS E O IMPOSTO PAGO AO GOVERNO. 
FAZEMOS ISSO DURANTE MUITO TEMPO. DE UMA HORA PRA OUTRA O GOVERNO
MUDA A ALIQUOTA DO IMPOSTO. COMO FARÁ SENTIDO OS PAGAMENTOS ARMAZENADOS
ANTERIORMENTE? AQUI NOTA-SE QUE ARMAZENAMOS DADOS E ARMAZENAMOS
INFORMACOES CORRESPONDENTES AOS PROCEDIMENTOS EXTERNOS. DEVEMOS
APENAS ARMAZENAR OS DADOS, POIS ELES SAO SUFICIENTES PARA GERAR
A INFORMACAO.

MODELAR É UMA ARTE, ALGO QUE SE APRENDE COM A PRATICA. E VOCES PODEM
SE PERGUNTAR: MAS SE É ALGO QUE SE APRENDE COM A PRATICA, COMO QUEM
ESTA COMEÇANDO, APRENDE?

ASSIM COMO PETER CHEN CRIOU O MODELO DE ENTIDADE E RELACIONAMENTO, O MER,
FORAM CRIADAS FORMAS NORMAIS, QUE SAO DIRETRIZES PARA APLICAR EM
MODELAGEM DE AMBIENTES OLTP OU AMBIENTES TRANSACIONAIS DE BANCOS
DE DADOS.

HOJE TEMOS MAIS DO QUE 3 FORMAS NORMAIS, MAS AO NORMALIZARMOS UM
BANCO ATE A SUA TERCEIRA FORMA, É O SUFICIENTE PARA TER UM
TRABALHO LIMPO E LIVRE DE ERROS. VEREMOS AS TRES FORMAS NORMAIS,
UMA A UMA, DETALHADAMENTE NAS PROXIMAS AULAS.


ESTE BANCO NAO FOI MODELADO DE FORMA CORRETA, LOGO QUANDO EU QUERO TRAZER DADOS PARA O USUARIO
ESTES DADOS NAO IRAO SER MOSTRADOS CORRETAMENTE, EX:

*/

SELECT ENDERECO, COUNT(*) AS "QUANTIDADE"
FROM CLIENTE
GROUP BY ENDERECO; #NO CASO EU TENHO MAIS DE UMA PESSOA QUE MORA NO RJ, POREM ELE MOSTROU APENAS 
				# OS REGISTROS LINHA A LINHA.

/*

LOGO, IREMOS APRENDER COMO MODELAR UM BANCO PARA FAZE-LO DE FORMA CORRETA E EFICIENTE!

 */

/*  Adicionando mais um telefone para a celia de forma ERRADA, da maneira q o banco foi modelado */

INSERT INTO CLIENTE VALUES('CELIA','F','CELIA@GMAIL.COM',541521456,'58749965','RIACHUELO - CENTRO - RIO DE JANEIRO - RJ');

SELECT SEXO, COUNT(*) AS QUANTIDADE
FROM CLIENTE
GROUP BY SEXO;
#porem, agora o banco ira retornar mais registros, que na vdd nao eram pra existir pq o 
#BANCO FOI "MODELADO" de forma incorreta, isso acarreta em varios problemas, ex:falencia de uma empresa

/* 1a FORMA NORMAL */

/* 1 - TODO CAMPO VETORIZADO SE TORNARA
OUTRA TABELA

[AZUL,AMARELO,VERDE,LARANJA] - ELEMENTOS DE UM MESMO TIPO
[KA,FIT,FIESTA,CIVIC,UNO] - VETOR DE CARROS

2 - TODO CAMPO MULTIVALORADO SE TORNARÁ
OUTRA TABELA. UM CAMPO DIVISIVEL.


OBS: diferenca de um campo "MULTIVALORADO" para um campo "VETORIZADO" é que no MULTIVALORADO
os elementos NÃO SÃO da mesma natureza!

ex: telefone e vetorizado, pois e de mesma natureza!

ex: nessa modelagem, apenas um endereço contem mais de uma natureza, no caso, o endereço é multivalorado
pois ele contem rua,bairro,cidade e estado!

3 - TODA TABELA NECESSITA DE PELO MENOS
UM CAMPO QUE IDENTIFIQUE TODO O RESGISTRO
COMO SENDO ÚNICO - É O QUE CHAMAMOS DE CHAVE PRIMÁRIA
OU PRIMARY KEY*/

/*
CHAVE PRIMEIRA PODE SER DE DUAS FORMAS:
NATURAL - ex: CPF
ARTIFICIAL - criado para atribuir a um registro do banco, ex: senha da fila de um banco


 */