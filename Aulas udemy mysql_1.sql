SELECT C.NOME, C.EMAIL, E.ESTADO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE;
+---------+-------------------+--------+----------+
| NOME    | EMAIL             | ESTADO | NUMERO   |
+---------+-------------------+--------+----------+
| JORGE   | JORGE@IG.COM      | ES     | 78458743 |
| JORGE   | JORGE@IG.COM      | ES     | 56576876 |
| JOAO    | JOAOA@IG.COM      | RJ     | 87866896 |
| CARLOS  | CARLOSA@IG.COM    | RJ     | 54768899 |
| JOAO    | JOAOA@IG.COM      | RJ     | 99667587 |
| ANA     | ANA@IG.COM        | SP     | 78989765 |
| ANA     | ANA@IG.COM        | SP     | 99766676 |
| JOAO    | JOAOA@IG.COM      | RJ     | 66687899 |
| JORGE   | JORGE@IG.COM      | ES     | 89986668 |
| CARLOS  | CARLOSA@IG.COM    | RJ     | 88687909 |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 68976565 |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 99656675 |
| GIOVANA | NULL              | RJ     | 33567765 |
| GIOVANA | NULL              | RJ     | 88668786 |
| GIOVANA | NULL              | RJ     | 55689654 |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 88687979 |
| DANIELE | DANIELE@GMAIL.COM | ES     | 88965676 |
| EDUARDO | NULL              | PR     | 89966809 |
| ANTONIO | ANTONIO@IG.COM    | SP     | 88679978 |
| ANTONIO | ANTONIO@UOL.COM   | PR     | 99655768 |
| ELAINE  | ELAINE@GLOBO.COM  | SP     | 89955665 |
| CARMEM  | CARMEM@IG.COM     | RJ     | 77455786 |
| CARMEM  | CARMEM@IG.COM     | RJ     | 89766554 |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 77755785 |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 44522578 |
+---------+-------------------+--------+----------+

IFNULL()

SELECT 	C.NOME, 
		IFNULL(C.EMAIL,'NAO TEM EMAIL'), 
		E.ESTADO, 
		T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE;




SELECT  C.NOME, 
		IFNULL(C.EMAIL,'NAO TEM EMAIL'), 
		E.ESTADO, 
		T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+---------------------------------+--------+----------+
| NOME    | IFNULL(C.EMAIL,'NAO TEM EMAIL') | ESTADO | NUMERO   |
+---------+---------------------------------+--------+----------+
| JORGE   | JORGE@IG.COM                    | ES     | 78458743 |
| JORGE   | JORGE@IG.COM                    | ES     | 56576876 |
| JOAO    | JOAOA@IG.COM                    | RJ     | 87866896 |
| CARLOS  | CARLOSA@IG.COM                  | RJ     | 54768899 |
| JOAO    | JOAOA@IG.COM                    | RJ     | 99667587 |
| ANA     | ANA@IG.COM                      | SP     | 78989765 |
| ANA     | ANA@IG.COM                      | SP     | 99766676 |
| JOAO    | JOAOA@IG.COM                    | RJ     | 66687899 |
| JORGE   | JORGE@IG.COM                    | ES     | 89986668 |
| CARLOS  | CARLOSA@IG.COM                  | RJ     | 88687909 |
| FLAVIO  | FLAVIO@IG.COM                   | MG     | 68976565 |
| FLAVIO  | FLAVIO@IG.COM                   | MG     | 99656675 |
| GIOVANA | NAO TEM EMAIL                   | RJ     | 33567765 |
| GIOVANA | NAO TEM EMAIL                   | RJ     | 88668786 |
| GIOVANA | NAO TEM EMAIL                   | RJ     | 55689654 |
| KARLA   | KARLA@GMAIL.COM                 | RJ     | 88687979 |
| DANIELE | DANIELE@GMAIL.COM               | ES     | 88965676 |
| EDUARDO | NAO TEM EMAIL                   | PR     | 89966809 |
| ANTONIO | ANTONIO@IG.COM                  | SP     | 88679978 |
| ANTONIO | ANTONIO@UOL.COM                 | PR     | 99655768 |
| ELAINE  | ELAINE@GLOBO.COM                | SP     | 89955665 |
| CARMEM  | CARMEM@IG.COM                   | RJ     | 77455786 |
| CARMEM  | CARMEM@IG.COM                   | RJ     | 89766554 |
| ADRIANA | ADRIANA@GMAIL.COM               | RJ     | 77755785 |
| ADRIANA | ADRIANA@GMAIL.COM               | RJ     | 44522578 |
+---------+---------------------------------+--------+----------+



SELECT  C.NOME, 
		IFNULL(C.EMAIL,'*****************'), 
		E.ESTADO, 
		T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+-------------------------------------+--------+----------+
| NOME    | IFNULL(C.EMAIL,'*****************') | ESTADO | NUMERO   |
+---------+-------------------------------------+--------+----------+
| JORGE   | JORGE@IG.COM                        | ES     | 78458743 |
| JORGE   | JORGE@IG.COM                        | ES     | 56576876 |
| JOAO    | JOAOA@IG.COM                        | RJ     | 87866896 |
| CARLOS  | CARLOSA@IG.COM                      | RJ     | 54768899 |
| JOAO    | JOAOA@IG.COM                        | RJ     | 99667587 |
| ANA     | ANA@IG.COM                          | SP     | 78989765 |
| ANA     | ANA@IG.COM                          | SP     | 99766676 |
| JOAO    | JOAOA@IG.COM                        | RJ     | 66687899 |
| JORGE   | JORGE@IG.COM                        | ES     | 89986668 |
| CARLOS  | CARLOSA@IG.COM                      | RJ     | 88687909 |
| FLAVIO  | FLAVIO@IG.COM                       | MG     | 68976565 |
| FLAVIO  | FLAVIO@IG.COM                       | MG     | 99656675 |
| GIOVANA | *****************                   | RJ     | 33567765 |
| GIOVANA | *****************                   | RJ     | 88668786 |
| GIOVANA | *****************                   | RJ     | 55689654 |
| KARLA   | KARLA@GMAIL.COM                     | RJ     | 88687979 |
| DANIELE | DANIELE@GMAIL.COM                   | ES     | 88965676 |
| EDUARDO | *****************                   | PR     | 89966809 |
| ANTONIO | ANTONIO@IG.COM                      | SP     | 88679978 |
| ANTONIO | ANTONIO@UOL.COM                     | PR     | 99655768 |
| ELAINE  | ELAINE@GLOBO.COM                    | SP     | 89955665 |
| CARMEM  | CARMEM@IG.COM                       | RJ     | 77455786 |
| CARMEM  | CARMEM@IG.COM                       | RJ     | 89766554 |
| ADRIANA | ADRIANA@GMAIL.COM                   | RJ     | 77755785 |
| ADRIANA | ADRIANA@GMAIL.COM                   | RJ     | 44522578 |
+---------+-------------------------------------+--------+----------++---------+-------------------------------------+--------+----------+

SELECT  C.NOME, 
		IFNULL(C.EMAIL,'*****************') AS "E-MAIL",
		E.ESTADO, 
		T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+-------------------+--------+----------+
| NOME    | E-MAIL            | ESTADO | NUMERO   |
+---------+-------------------+--------+----------+
| JORGE   | JORGE@IG.COM      | ES     | 78458743 |
| JORGE   | JORGE@IG.COM      | ES     | 56576876 |
| JOAO    | JOAOA@IG.COM      | RJ     | 87866896 |
| CARLOS  | CARLOSA@IG.COM    | RJ     | 54768899 |
| JOAO    | JOAOA@IG.COM      | RJ     | 99667587 |
| ANA     | ANA@IG.COM        | SP     | 78989765 |
| ANA     | ANA@IG.COM        | SP     | 99766676 |
| JOAO    | JOAOA@IG.COM      | RJ     | 66687899 |
| JORGE   | JORGE@IG.COM      | ES     | 89986668 |
| CARLOS  | CARLOSA@IG.COM    | RJ     | 88687909 |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 68976565 |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 99656675 |
| GIOVANA | ***************** | RJ     | 33567765 |
| GIOVANA | ***************** | RJ     | 88668786 |
| GIOVANA | ***************** | RJ     | 55689654 |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 88687979 |
| DANIELE | DANIELE@GMAIL.COM | ES     | 88965676 |
| EDUARDO | ***************** | PR     | 89966809 |
| ANTONIO | ANTONIO@IG.COM    | SP     | 88679978 |
| ANTONIO | ANTONIO@UOL.COM   | PR     | 99655768 |
| ELAINE  | ELAINE@GLOBO.COM  | SP     | 89955665 |
| CARMEM  | CARMEM@IG.COM     | RJ     | 77455786 |
| CARMEM  | CARMEM@IG.COM     | RJ     | 89766554 |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 77755785 |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 44522578 |
+---------+-------------------+--------+----------+

/* VIEW */  


CREATE VIEW V_RELATORIO AS
SELECT 	C.NOME, 
		C.SEXO, 
		IFNULL(C.EMAIL,'CLIENTE SEM EMAIL') AS "E-MAIL",
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

SHOW TABLES;
SHOW DATABASES;
SHOW VIEWS; --- NAO EXISTE 


CREATE VIEW V_RELATORIO AS
SELECT 	C.NOME, 
		C.SEXO, 
		IFNULL(C.EMAIL,'CLIENTE SEM EMAIL') AS "E-MAIL",
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


SELECT NOME, NUMERO, ESTADO
FROM V_RELATORIO;


/*OPERACOES DE DML EM VIEWS */

/* UPDATE INSERT E DELETE */ 

INSERT INTO V_RELATORIO VALUES(
'ANDREIA','F','ANDREIA@UOL.COM.BR','CEL','873547864','CENTRO','VITORIA','ES'
);

CREATE TABLE JOGADORES(
	IDJOGADOR INT,
	NOME VARCHAR(30),
	ESTADO CHAR(2)
);

INSERT INTO JOGADORES VALUES(1,'GUERRERO','RS');
INSERT INTO JOGADORES VALUES(2,'GABIGOL','RJ');
INSERT INTO JOGADORES VALUES(3,'GANSO','RJ');
INSERT INTO JOGADORES VALUES(4,'NENÊ', 'RJ');
INSERT INTO JOGADORES VALUES(5,'LOVE','SP');


CREATE VIEW V_JOGADORES AS 
SELECT NOME, ESTADO
FROM JOGADORES;

SELECT * FROM V_JOGADORES;

/* NEM INSERT,DELETE FUNCIONAM COM VIEW, POREM UPDATE FUNCIONA (ISSO COM JOIN) */


DELETE FROM V_JOGADORES
WHERE NOME = 'GUERRERO'

INSERT INTO V_JOGADORES VALUES('GUERRERO','RS');

SELECT * FROM JOGADORES;

SELECT * FROM V_RELATORIO
WHERE SEXO = 'F';



/* ORDER BY */

CREATE TABLE ALUNOS(
	NUMERO INT,
	NOME VARCHAR(30)
);

INSERT INTO ALUNOS VALUES(1,'JOAO');
INSERT INTO ALUNOS VALUES(1,'MARIA');
INSERT INTO ALUNOS VALUES(2,'ZOE');
INSERT INTO ALUNOS VALUES(2,'ANDRE');
INSERT INTO ALUNOS VALUES(3,'CLARA');
INSERT INTO ALUNOS VALUES(1,'CLARA');
INSERT INTO ALUNOS VALUES(4,'MAFRA');
INSERT INTO ALUNOS VALUES(5,'JANAINA');
INSERT INTO ALUNOS VALUES(1,'JANAINA');
INSERT INTO ALUNOS VALUES(3,'MARCELO');
INSERT INTO ALUNOS VALUES(4,'GIOVANI');
INSERT INTO ALUNOS VALUES(5,'ANTONIO');
INSERT INTO ALUNOS VALUES(6,'ANA');
INSERT INTO ALUNOS VALUES(6,'VIVIANE'); 

SELECT * FROM ALUNOS
ORDER BY NUMERO;

SELECT * FROM ALUNOS
ORDER BY 1;

SELECT * FROM ALUNOS
ORDER BY 2;

/* ORDENANDO POR MAIS DE UMA COLUNA */

SELECT * FROM ALUNOS
ORDER BY 1;

SELECT * FROM ALUNOS
ORDER BY NUMERO, NOME;

SELECT * FROM ALUNOS
ORDER BY 1, 2;

/* MESCLANDO ORDER BY COM PROJECAO */

SELECT NOME FROM ALUNOS
ORDER BY 1, 2;

SELECT NOME FROM ALUNOS
ORDER BY NUMERO, NOME;

/* ORDER BY DESC / ASC */

SELECT NOME FROM ALUNOS
ORDER BY 1 ASC;

SELECT NOME FROM ALUNOS
ORDER BY 1 DESC;

SELECT NOME FROM ALUNOS
ORDER BY 1, 2 DESC;

SELECT NOME FROM ALUNOS
ORDER BY 1 DESC, 2 DESC;

/* ORDENANDO COM JOINS */

SELECT  C.NOME, 
		C.SEXO, 
		IFNULL(C.EMAIL,'CLIENTE SEM EMAIL') AS "E-MAIL", 
		T.TIPO, 
		T.NUMERO, 
		E.BAIRRO, 
		E.CIDADE, 
		E.ESTADO
FROM CLIENTE C 
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
ORDER BY 1;

SHOW TABLES;

SELECT * FROM V_RELATORIO
ORDER BY 1;







