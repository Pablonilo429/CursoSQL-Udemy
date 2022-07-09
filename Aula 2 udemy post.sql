select * from funcionarios;

/* contando o numero de ocorrencias */

select count(*) from funcionarios;
select count(*) from departamentos;
select count(*) from localizacao;

/* agrupando por sexo com group by */

select count(*) from funcionarios 
group by sexo;

/* colocando o nome na coluna */

select sexo, count(*) as "Quantidade" from funcionarios
group by sexo;

/* mostrando o numero de funcionarios em cada departamento */

select departamento, count(*)
from funcionarios
group by departamento;

/* exibindo o maximo de salarios - 149929 */

select max(salario) as "SALARIO MAXIMO" from funcionarios;

/* exibindo o minimo de salarios 40138 */

select min(salario) as "SALARIO MINIMO" from funcionarios 

/* exibindo o maximo e o munimo */

select min(salario) as "SALARIO MINIMO", max(salario) as "SALARIO MAXIMO"
from funcionarios;

/* exibindo o maximo e o minimo de cada departamento */

select departamento, min(salario), max(salario)
from funcionarios
group by departamento;


/* exibindo o maximo e o minimo por sexo */

select sexo, min(salario), max(salario)
from funcionarios
group by sexo;

/*Estatisticas */

/* Mostrando uma quantidade limitada de linhas */
select * from funcionarios
limit 10;

/* Qual o gasto total de salario pago pela empresa */
select sum(salario) from funcionarios;


/* Qual o montante total que cada departamento recebe de salario */
select departamento, sum(salario)
from funcionarios
group by departamento; 

/* Por departamento, qual o total e a media paga para os funcionarios? */

select sum(salario), avg(salario)
from funcionarios;

select departamento, sum(salario), avg(salario)
from funcionarios
group by departamento;

/* ordenando */
select departamento, sum(salario), avg(salario)
from funcionarios
group by departamento
order by 3;

select departamento, sum(salario), avg(salario)
from funcionarios
group by departamento
order by 3 ASC;

select departamento, sum(salario), avg(salario)
from funcionarios
group by departamento
order by 3 DESC;

/* Modelagem Banco de Dados x Data Science */

/* Banco de Dados -> 1,2 e 3 Formas normais
Evitam redundancia, consequemente popuam espaço em disco.
Consomem muito processamento em função de Joins, Queries lenats

Data Science e B.I -> Focam em agregaçoes e performance. Não se
preocupam com espaço em disco. Em B.I, modelagem minima(DW)
em Data Science, preferencialemente modelagem Colunar */


/* Importando arquivos CSV */

CREATE TABLE MAQUINAS(
	MAQUINA VARCHAR(20),
	DIA INT,
	QTD NUMERIC(10,2)
);

D:\Arquivos do Usuario\Jogos Salvos\Aulas UDEMY BANCO

COPY MAQUINAS
FROM 'D:\Arquivos do Usuario\Jogos Salvos\Aulas UDEMY BANCO\LogMaquinas.csv'
DELIMITER ',' 
CSV HEADER;

/* QUAL A MEDIA DE CADA MAQUINA */
 
SELECT MAQUINA, AVG(QTD) AS MEDIA_QTD
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 2 DESC;

/*ARREDONDANDO */

ROUND(COLUNA,2)

SELECT MAQUINA, ROUND(AVG(QTD),2) AS MEDIA_QTD
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 2 DESC;

/* QUAL A MODA DAS QUANTIDADES */

select maquina, qtd, count(*) as moda
from maquinas
group by maquina, qtd
order by 3 desc


/* QUAL A MODA DAS QUANTIDADES DE CADA MAQUINA */

SELECT MAQUINA, QTD, COUNT(*) FROM MAQUINAS
WHERE MAQUINA = 'Maquina 01'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

SELECT MAQUINA, QTD, COUNT(*) FROM MAQUINAS
WHERE MAQUINA = 'Maquina 02'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;


SELECT MAQUINA, QTD, COUNT(*) FROM MAQUINAS
WHERE MAQUINA = 'Maquina 03'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

/* moda do dataset inteiro */

SELECT  QTD, COUNT(*) AS MODA
FROM MAQUINAS
GROUP BY QTD
ORDER BY 2 DESC;


/* QUAL O MAXIMO E MINIMO E AMPLITUDE DE CADA MAQUINA  */

SELECT MAQUINA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   MAX(QTD) - MIN(QTD) AS AMPLITUDE
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;
		

/* ACRESCENTE A MEDIA AO RELATORIO */

SELECT MAQUINA,
	   ROUND(AVG(QTD),2) AS MEDIA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   MAX(QTD) - MIN(QTD) AS AMPLITUDE
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;

/* DESVIO PADRAO E VARIANCIA */

STDDEV_POP(coluna)
VAR_POP(coluna)

SELECT MAQUINA,
	   ROUND(AVG(QTD),2) AS MEDIA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   MAX(QTD) - MIN(QTD) AS AMPLITUDE,
	   ROUND(STDDEV_POP(QTD),2) AS DESV_PAD,
	   ROUND(VAR_POP(QTD),2) AS VARIANCIA
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;  

CREATE OR REPLACE FUNCTION _final_median(numeric[])
   RETURNS numeric AS
$$
   SELECT AVG(val)
   FROM (
     SELECT val
     FROM unnest($1) val
     ORDER BY 1
     LIMIT  2 - MOD(array_upper($1, 1), 2)
     OFFSET CEIL(array_upper($1, 1) / 2.0) - 1
   ) sub;
$$
LANGUAGE 'sql' IMMUTABLE;

CREATE AGGREGATE median(numeric) (
  SFUNC=array_append,
  STYPE=numeric[],
  FINALFUNC=_final_median,
  INITCOND='{}'
);


SELECT MEDIAN(QTD) AS MEDIANA
FROM MAQUINAS;

SELECT MEDIAN(QTD) AS MEDIANA
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 01'
;

SELECT MEDIAN(QTD) AS MEDIANA
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 02'
;

SELECT MEDIAN(QTD) AS MEDIANA
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 03'
;

/* moda do dataset inteiro */

SELECT  QTD, COUNT(*) AS MODA
FROM MAQUINAS
GROUP BY QTD
ORDER BY 2 DESC;


/* QUAL O MAXIMO E MINIMO E AMPLITUDE DE CADA MAQUINA  */

SELECT MAQUINA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   MAX(QTD) - MIN(QTD) AS AMPLITUDE
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;
		

/* ACRESCENTE A MEDIA AO RELATORIO */

SELECT MAQUINA,
	   ROUND(AVG(QTD),2) AS MEDIA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   MAX(QTD) - MIN(QTD) AS AMPLITUDE
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;


/* DESVIO PADRAO E VARIANCIA */

STDDEV_POP(coluna)
VAR_POP(coluna)

SELECT MAQUINA,
	   ROUND(AVG(QTD),2) AS MEDIA,
	   MAX(QTD) AS MAXIMO,
	   MIN(QTD) AS MINIMO,
	   MAX(QTD) - MIN(QTD) AS AMPLITUDE,
	   ROUND(STDDEV_POP(QTD),2) AS DESV_PAD,
	   ROUND(VAR_POP(QTD),2) AS VARIANCIA
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 4 DESC;   

/* FUNCAO E ANALISE DA MEDIANA NO ARQUIVO 02 - Funcao de Mediana.sql */

/*
	QUANTIDADE
	TOTAL
	MEDIA
	MAXIMO
	MINIMO
	AMPLITUDE
	VARIANCIA
	DESVIO PADRAO
	MEDIANA
	COEF VAR.
*/

SELECT MAQUINA,
	   COUNT(QTD) AS "QUANTIDADE",
	   SUM(QTD) AS "TOTAL",
	   ROUND(AVG(QTD),2) AS "MEDIA",
	   MAX(QTD) AS "MAXIMO",
	   MIN(QTD) AS "MINIMO",
	   MAX(QTD) - MIN(QTD) AS "AMPLIT. TOTAL",
	   ROUND(VAR_POP(QTD),2) AS "VARIANCIA",
	   ROUND(STDDEV_POP(QTD),2) AS "DESV. PADRAO",
	   ROUND(MEDIAN(QTD),2) AS "MEDIANA",
	   ROUND((STDDEV_POP(QTD) / AVG(QTD)) * 100,2) AS "COEF. VARIACAO"
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 1;

delete from maquinas where dia = 11 or dia = 12;

/* MODA - MODE() WITHIN GROUP(ORDER BY COLUNA)  */

SELECT * FROM MAQUINAS;

SELECT MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA" FROM MAQUINAS;

SELECT MAQUINA, MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA" 
FROM MAQUINAS
GROUP BY MAQUINA;

SELECT MAQUINA,
	   COUNT(QTD) AS "QUANTIDADE",
	   SUM(QTD) AS "TOTAL",
	   ROUND(AVG(QTD),2) AS "MEDIA",
	   MAX(QTD) AS "MAXIMO",
	   MIN(QTD) AS "MINIMO",
	   MAX(QTD) - MIN(QTD) AS "AMPLIT. TOTAL",
	   ROUND(VAR_POP(QTD),2) AS "VARIANCIA",
	   ROUND(STDDEV_POP(QTD),2) AS "DESV. PADRAO",
	   ROUND(MEDIAN(QTD),2) AS "MEDIANA",
	   ROUND((STDDEV_POP(QTD) / AVG(QTD)) * 100,2) AS "COEF. VARIACAO",
	   MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA"
	   FROM MAQUINAS
	   GROUP BY MAQUINA
	   ORDER BY 1;
	   
/* create table as select */

/*Podemos criar uma tabela com o resultado de uma querie
e essa é a forma de realizar uma modelagem colunar 
CREATE TABLE AS SELECT
*/


CREATE TABLE GENERO(
	IDGENERO INT PRIMARY KEY,
	NOME VARCHAR(30)
);

INSERT INTO GENERO VALUES(1,'FANTASIA');
INSERT INTO GENERO VALUES(2,'AVENTURA');
INSERT INTO GENERO VALUES(3,'SUSPENSE');
INSERT INTO GENERO VALUES(4,'AÇÃO');
INSERT INTO GENERO VALUES(5,'DRAMA');

CREATE TABLE FILME(
	IDFILME INT PRIMARY KEY,
	NOME VARCHAR(50),
	ANO INT,
    ID_GENERO INT,
	FOREIGN KEY(ID_GENERO)
	REFERENCES GENERO(IDGENERO)
);

INSERT INTO FILME VALUES(100,'KILL BILL I',2007,2);
INSERT INTO FILME VALUES(200,'DRACULA',1998,3);
INSERT INTO FILME VALUES(300,'SENHOR DOS ANEIS',2008,1);
INSERT INTO FILME VALUES(400,'UM SONHO DE LIBERDADE',2008,5);
INSERT INTO FILME VALUES(500,'OS BAD BOYS',2008,4);
INSERT INTO FILME VALUES(600,'GUERRA CIVIL',2016,2);
INSERT INTO FILME VALUES(700,'CADILLAC RECORDS',2009,5);
INSERT INTO FILME VALUES(800,'O HOBBIT',2008,1);
INSERT INTO FILME VALUES(900,'TOMATES VERDES FRITOS',2008,5);
INSERT INTO FILME VALUES(1000,'CORRIDA MORTAL',2008,4);

CREATE TABLE LOCACAO(
	IDLOCACAO INT PRIMARY KEY,
	DATA DATE,
	MIDIA INT,
	DIAS INT,
	ID_FILME INT,
	FOREIGN KEY(ID_FILME)
	REFERENCES FILME(IDFILME)

);

select * from locacao

INSERT INTO LOCACAO VALUES(1,'01/08/2019',23,3,100);
INSERT INTO LOCACAO VALUES(2,'01/02/2019',56,1,400);
INSERT INTO LOCACAO VALUES(3,'02/07/2019',23,3,400);
INSERT INTO LOCACAO VALUES(4,'02/02/2019',43,1,500);
INSERT INTO LOCACAO VALUES(5,'02/02/2019',23,2,100);
INSERT INTO LOCACAO VALUES(6,'03/07/2019',76,3,700);
INSERT INTO LOCACAO VALUES(7,'03/02/2019',45,1,700);
INSERT INTO LOCACAO VALUES(8,'04/08/2019',89,3,100);
INSERT INTO LOCACAO VALUES(9,'04/02/2019',23,3,800);
INSERT INTO LOCACAO VALUES(10,'05/07/2019',23,3,500);
INSERT INTO LOCACAO VALUES(11,'05/02/2019',38,3,800);
INSERT INTO LOCACAO VALUES(12,'01/10/2019',56,1,100);
INSERT INTO LOCACAO VALUES(13,'06/12/2019',23,3,400);
INSERT INTO LOCACAO VALUES(14,'01/02/2019',56,2,300);
INSERT INTO LOCACAO VALUES(15,'04/10/2019',76,3,300);
INSERT INTO LOCACAO VALUES(16,'01/09/2019',32,2,400);
INSERT INTO LOCACAO VALUES(17,'08/02/2019',89,3,100);
INSERT INTO LOCACAO VALUES(18,'01/02/2019',23,1,200);
INSERT INTO LOCACAO VALUES(19,'08/09/2019',45,3,300);
INSERT INTO LOCACAO VALUES(20,'01/12/2019',89,1,400);
INSERT INTO LOCACAO VALUES(21,'09/07/2019',23,3,1000);
INSERT INTO LOCACAO VALUES(22,'01/12/2019',21,3,1000);
INSERT INTO LOCACAO VALUES(23,'01/02/2019',34,2,100);
INSERT INTO LOCACAO VALUES(24,'09/08/2019',67,1,1000);
INSERT INTO LOCACAO VALUES(25,'01/02/2019',76,3,1000);
INSERT INTO LOCACAO VALUES(26,'01/02/2019',66,3,200);
INSERT INTO LOCACAO VALUES(27,'09/12/2019',90,1,400);
INSERT INTO LOCACAO VALUES(28,'03/02/2019',23,3,100);
INSERT INTO LOCACAO VALUES(29,'01/12/2019',65,5,1000);
INSERT INTO LOCACAO VALUES(30,'03/08/2019',43,1,1000);
INSERT INTO LOCACAO VALUES(31,'01/02/2019',27,31,200);

SELECT F.NOME, G.NOME, L.DATA, L.DIAS, L.MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

SELECT * FROM FUNCIONARIOS;

CREATE TABLE REL_LOCADORA AS
SELECT F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

SELECT * FROM REL_LOCADORA;

COPY REL_LOCADORA TO
'D:\Arquivos do Usuario\Jogos Salvos\Aulas UDEMY BANCO\REL_LOCADORA.CSV'
DELIMITER ';'
CSV HEADER;

drop tabLE LOCACAO;

CREATE TABLE LOCACAO(
	IDLOCACAO INT PRIMARY KEY,
	DATA TIMESTAMP,
	MIDIA INT,
	DIAS INT,
	ID_FILME INT,
	FOREIGN KEY(ID_FILME)
	REFERENCES FILME(IDFILME)

);

/* SINCRONIZANDO TABELAS E RELATORIOS */

DROP TABLE LOCACAO;

CREATE TABLE LOCACAO(
	IDLOCACAO INT PRIMARY KEY,
	DATA TIMESTAMP,
	MIDIA INT,
	DIAS INT,
	ID_FILME INT,
	FOREIGN KEY(ID_FILME)
	REFERENCES FILME(IDFILME)

);

CREATE SEQUENCE SEQ_LOCACAO;

NEXTVAL('SEQ_LOCACAO');

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/08/2018',23,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',56,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/07/2018',23,3,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/02/2018',43,1,500);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/02/2018',23,2,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/07/2018',76,3,700);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/02/2018',45,1,700);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/08/2018',89,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/02/2018',23,3,800);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'05/07/2018',23,3,500);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'05/02/2018',38,3,800);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/10/2018',56,1,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'06/12/2018',23,3,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',56,2,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/10/2018',76,3,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/09/2018',32,2,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'08/02/2018',89,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',23,1,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'08/09/2018',45,3,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',89,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/07/2018',23,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',21,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',34,2,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/08/2018',67,1,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',76,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',66,3,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/12/2018',90,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/02/2018',23,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',65,5,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/08/2018',43,1,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',27,31,200);

SELECT * FROM LOCACAO;

DROP TABLE REL_LOCADORA;

SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

CREATE TABLE RELATORIO_LOCADORA AS 
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

SELECT * FROM RELATORIO_LOCADORA;
SELECT * FROM LOCACAO;

/* SELECT PARA TRAZER OS REGISTROS NOVOS */

SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;
					
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

/* INSERINDO OS REGISTROS NOVOS */

INSERT INTO RELATORIO_LOCADORA
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;

/* VAMOS DEIXAR ESSE PROCEDIMENTO AUTOMATICO POR MEIO 
DE UMA TRIGGER */

CREATE OR REPLACE FUNCTION ATUALIZA_REL()
RETURNS TRIGGER AS $$
BEGIN

INSERT INTO RELATORIO_LOCADORA
SELECT L.IDLOCACAO, F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

COPY RELATORIO_LOCADORA TO  
'D:\Arquivos do Usuario\Jogos Salvos\Aulas UDEMY BANCO\RELATORIO_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;

RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;

/* COMANDO PARA APAGAR UMA TRIGGER */

DROP TRIGGER TG_RELATORIO ON LOCACAO;

CREATE TRIGGER TG_RELATORIO
AFTER INSERT ON LOCACAO
FOR EACH ROW
	EXECUTE PROCEDURE ATUALIZA_REL();

/* INSERINDO NOVOS REGISTROS */

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),100,7,300);

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),500,1,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),800,6,500);

SELECT * FROM LOCACAO;
SELECT * FROM RELATORIO_LOCADORA;

/* SINCRONIZANDO COM REGISTROS DELETADOS */

DELETE FROM LOCACAO WHERE IDLOCACAO = X 

CREATE OR REPLACE FUNCTION DELETE_LOCACAO()
RETURNS TRIGGER AS 
$$
BEGIN

DELETE FROM RELATORIO_LOCADORA
WHERE IDLOCACAO = OLD.IDLOCACAO

COPY RELATORIO_LOCADORA TO  
'D:\Arquivos do Usuario\Jogos Salvos\Aulas UDEMY BANCO\RELATORIO_LOCADORA.csv'
DELIMITER ';'
CSV HEADER;


END;
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER DELETE_REG
	BEFORE DELETE ON LOCACAO
	FOR EACH ROW
	EXECUTE PROCEDURE DELETE_LOCACAO();

SELECT * FROM LOCACAO;

SELECT * FROM RELATORIO_LOCADORA;

DELETE FROM LOCACAO 
WHERE IDLOCACAO = 1;


/* VARIAVEIS DUMMY PARA MACGINE LEARNING */

/* UTILIZANDO O CASE */ 

SELECT NOME, SEXO FROM FUNCIONARIOS;

SELECT NOME, CARGO, 
CASE 
		WHEN CARGO = 'Financial Advisor' THEN 'CONDICAO 01'
		WHEN CARGO = 'Structural Engineer' THEN 'CONDICAO 02'
		WHEN CARGO = 'Executive Secretary' THEN 'CONDICAO 03'
		WHEN CARGO = 'Sales Associative' THEN 'CONDICAO 04'
		ELSE 'OUTRAS CONDICOES'
END AS "CONDICOES"
FROM FUNCIONARIOS;

SELECT CARGO FROM FUNCIONARIOS;

SELECT NOME,
CASE 
		WHEN SEXO = 'Masculino' THEN 'M'
		ELSE 'F'
END AS "SEXO"
FROM FUNCIONARIOS;

/* UTILIZANDO VALORES BOOLEANOS */

SELECT NOME, CARGO, (SEXO = 'Masculino') AS Masculino, (SEXO = 'Feminino') AS Feminino
FROM FUNCIONARIOS;

/* MESCLANDO AS TECNICAS */

SELECT NOME, CARGO,
CASE
		WHEN (SEXO = 'Masculino') = true THEN 1
		ELSE 0
END AS "MASCULINO",
CASE
		WHEN (SEXO = 'Feminino') = true THEN 1
		ELSE 0
END AS "FEMININO"
FROM FUNCIONARIOS;
$$

/* Filtros de grupo */

/* FILTROS BASEADOS EM VALORES NUMERICOS */

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE SALARIO > 100000;

SELECT NOME, DEPARTAMENTO, 
FROM FUNCIONARIOS
WHERE SALARIO > 100000;

/* FILTROS BASEADOS EM STRINGS */

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARAMENTO = 'Ferramentas';

--FILTRO E CASE SENSITIVE, A COLUNA E CASE INSENSITIVE

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARAMENTO = 'FERRAMENTAS';

/* FILTROS BASEADOS EM MULTIPLAS TIPOS E COLUNAS - CONSIDERAR OR E AND */

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARAMENTO = 'Ferramentas'
and
SALARIO > 100000;


/* FILTRO BASEADOS EM UNICO TIPO E COLUNA - ATENCAO PARA A REGRA DO
AND E OR */

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARAMENTO = 'Ferramentas'
and
DEPARTAMENTO = 'Books';

/* FILTROS BASEADOS EM PADRAO CARACTERES */

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARAMENTO LIKE 'B%'

SELECT DEPARTAMENTO, sum(salario) as "total"
FROM FUNCIONARIOS
WHERE DEPARAMENTO LIKE 'B%'
GROUP BY DEPARTAMENTO;

/* FILTROS BASEADOS EM PADRAO DE CARACTERES COM MAIS LETRAS */

SELECT DEPARTAMENTO, sum(salario) as "total"
FROM FUNCIONARIOS
WHERE 
DEPARAMENTO LIKE 'Bo%'
GROUP BY DEPARTAMENTO;


/* UTILIZANDO O CARACTER CORINGA NO MEIO DA PALAVRA */

SELECT DEPARTAMENTO, sum(salario) as "total"
FROM FUNCIONARIOS
WHERE DEPARAMENTO LIKE 'B%s%'
GROUP BY DEPARTAMENTO;

/* e se eu quisesse filtrar o agrupamento pelo salario?
por exemplo, maior que 40.000.000 
COLUNAS NAO AGREGADAS - WHERE 
COLUNAS AGREGADAS - HAVING
*/

SELECT DEPARTAMENTO, sum(salario) as "total"
FROM FUNCIONARIOS
WHERE 
DEPARAMENTO LIKE 'B%' and sum(salario) > 40000000
GROUP BY DEPARTAMENTO;


SELECT DEPARTAMENTO, sum(salario) as "total"
FROM FUNCIONARIOS
WHERE
DEPARAMENTO LIKE 'B%' 
GROUP BY DEPARTAMENTO
HAVING sum(salario) > 40000000;

/* FILTROS CONTADORES */

/* MULTIPLOS CONTADORES */

SELECT COUNT(*) FROM FUNCIONARIOS;

SELECT COUNT(*) AS "QUANTIDADE TOTAL", 
COUNT('Masculino') AS "Masculino"
FROM FUNCIONARIOS;

SELECT SEXO, COUNT(*)
FROM FUNCIONARIOS 
WHERE SEXO = 'Masculino'
GROUP BY SEXO;

SELECT COUNT(*) AS "QUANTIDADE TOTAL",

COUNT(SELECT SEXO, COUNT(*)
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino'
GROUP BY SEXO) AS "Masculino"

FROM FUNCIONARIOS;


SELECT COUNT(*) AS "QUANTIDADE TOTAL",

(SELECT SEXO, COUNT(*)
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino'
GROUP BY SEXO) AS "Masculino"

FROM FUNCIONARIOS;


SELECT COUNT(*) AS "QUANTIDADE TOTAL",

(SELECT COUNT(*)
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino'
GROUP BY SEXO) AS "Masculino"

FROM FUNCIONARIOS;

SELECT COINT(*) AS "QUANTIDADE TOTAL",
COUNT(*) FILTER( WHERE SEXO = 'Masculino') AS "MASCULINO"
FROM FUNCIONARIOS;

SELECT COINT(*) AS "QUANTIDADE TOTAL",
COUNT(*) FILTER( WHERE SEXO = 'Masculino') AS "MASCULINO",
COUNT(*) FILTER( WHERE DEPARTAMENTO = 'Books') AS "Books",
FROM FUNCIONARIOS;

SELECT COINT(*) AS "QUANTIDADE TOTAL",
COUNT(*) FILTER( WHERE SEXO = 'Masculino') AS "MASCULINO",
COUNT(*) FILTER( WHERE DEPARTAMENTO = 'Books') AS "Books",
COUNT(*) FILTER( WHERE SALARIO > 140000) AS "SALARIO > 140K"
FROM FUNCIONARIOS;

/* REFORMATANDO STRINGS */

/* LISTANDO */

SELECT DEPARTAMENTO FORM FUNCIONARIOS;

/* DISTINCT */

SELECT DISTINCT DEPARTAMENTO FROM FUNCIONARIOS;

/* UPPER CASE */

SELECT DISTINCT UPPER (DEPARTAMENTO) FROM FUNCIONARIOS;

/* LOWER CASE */

SELECT DISTINCT LOWER (DEPARTAMENTO) FROM FUNCIONARIOS;


/* CONCATENANDO STRINGS */

SELECT CARGO || ' - ' || DEPARTAMENTO
FROM FUNCIONARIOS;

SELECT (CARGO || ' - ' || DEPARTAMENTO) AS "CARGO COMPLETO"
FROM FUNCIONARIOS;

/* REMOVER ESPACOS */

SELECT '   UNIDADOS   ';

/* CONTANDO CARACTERES */

SELECT LENGTH('   UNIDADOS    ');

/* APLICANDO TRIM */

SELECT TRIM('   UNIDADOS    ');

SELECT LENGTH(TRIM('   UNIDADOS    '));





















