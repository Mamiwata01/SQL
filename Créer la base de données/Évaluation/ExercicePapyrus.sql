-- Active: 1664375272525@@127.0.0.1@3306@phpmyadmin
DROP DATABASE if EXISTS papyrus;
CREATE DATABASE papyrus;
USE papyrus;

CREATE TABLE fournis (
  numfou int(11) NOT NULL,
  nomfou varchar(25) NOT NULL,
  ruefou varchar(50) NOT NULL,
  posfou char(5) NOT NULL,
  vilfou varchar(30) NOT NULL,
  confou varchar(15) NOT NULL,
  satisf tinyint(4) DEFAULT NULL, CHECK (satisf >=0 AND satisf <=10),
  PRIMARY KEY (numfou)
) ;

INSERT INTO fournis(numfou,nomfou,ruefou,posfou,vilfou,confou,satisf)
VALUES
	(00120, "Grobrigan", "20 rue du papier", 92200, "papercity", "Goerges", 08),	
	(00540, "Eclipse", "53 rue laisse flotter les rubans", 78250, "Bugbugville", "Nestor", 07),
	(08700, "Medicis", "120 rue des plantes", 75014, "Paris", "Lison", NULL),
	(09120, "Discobol", "11 rue des sports", 85100," La Roche sur Yon", "Hercule", 08),
	(09150, "Depanpap", "26 avenue des locomotives", 59987, "Coroncountry", "Pollux", 05),
	(09180, "Hurrytape", "68 boulevard des octets", 04044, "Dumpville", "Track" ,NULL);

CREATE TABLE produit (
  codart char(4) NOT NULL,
  libart varchar(30) NOT NULL,
  stkale int(11) NOT NULL,
  stkphy int(11) NOT NULL,
  qteann int(11) NOT NULL,
  unimes char(5) NOT NULL,
  PRIMARY KEY (codart)
) ;
INSERT INTO produit( codart, libart, stkale, stkphy, qteann, unimes)
VALUES 
('I100', 'Papier 1 ex continu', 100, 557, 3500,'B1000'),
('I105', 'Papier 2 ex continu', 75, 5, 2300, 'B1000'),
('I108', 'Papier 3 ex continu', 200, 557, 3500, 'B500'),
('I110', 'Papier 4 ex continu', 10, 12, 63, 'B400'),
('P220', 'Pré imprimé commande', 500, 2500, 24500, 'B500'),
('P230', 'Pré imprimé facture', 500, 250, 12500, 'B500'),
('P240', 'Pré imprimé bulletin paie', 500, 3000, 6250, 'B500'),
('P250', 'Pré imprimé bon livraison', 500, 2500, 24500, 'B500'),
('P270', 'Pré imprimé bon fabrication', 500, 2500, 24500, 'B500'),
('R080', 'Ruban Epson 850', 10, 2, 120, 'unité'),
('R132', 'Ruban imp1200 lignes', 25, 200, 182, 'unité'),
('B002', 'Bande magnétique 6250', 20, 12, 410, 'unité'),
('B001', 'Bande magnétique 1200', 20, 87, 240, 'unité'),
('D035', 'CD R slim 80 mm',40, 42, 150, 'B010'),
('D050', 'CD R-W 80mm', 50, 4, 0, 'B010')
;

 
CREATE TABLE entcom (
  numcom int(11) NOT NULL AUTO_INCREMENT,
  obscom varchar(50) DEFAULT NULL,
  datcom timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  numfou int(11) DEFAULT NULL,
  PRIMARY KEY (numcom),
  KEY numfou (numfou),
  FOREIGN KEY (numfou) REFERENCES fournis (numfou)
);

INSERT INTO entcom (numcom,obscom,datcom,numfou)
VALUES 
	(70010,NULL, "2007/02/10", 00120),
	(70011, "Commande urgente", "2007/03/01", 00540),
	(70020,NULL, "2007/04/25", 09180),
	(70025, "Commande urente", "2007/04/30", 09150),
	(70210, "Commande cadencée", "2007/05/05", 00120),
	(70300, NULL, "2007/06/06", 09120),
	(70250, "Commande cadencée", "2007/10/02", 08700),
	(70620, NULL, "2007/10/02", 00540),
	(70625, NULL, "2007/10/09", 00120),
	(70629, NULL, "2007/10/12", 09180);

CREATE TABLE ligcom (
  numcom int(11) NOT NULL,
  numlig tinyint(4) NOT NULL,
  codart char(4) NOT NULL,
  qtecde int(11) NOT NULL,
  priuni decimal(5,0) NOT NULL,
  qteliv int(11) DEFAULT NULL,
  derliv date NOT NULL,
  PRIMARY KEY (numcom,numlig),
  KEY codart (codart),
  FOREIGN KEY (numcom) REFERENCES entcom (numcom),
  FOREIGN KEY (codart) REFERENCES produit (codart)
) ;


INSERT INTO ligcom (numcom,numlig,codart,qtecde,priuni,qteliv,derliv)
VALUES
	(70010, 01, "I100", 3000, 470, 3000, "2007/03/15"),
	(70010, 02, "I105", 2000, 485, 2000, "2007/07/05"),
	(70010, 03, "I108", 1000, 680, 1000, "2007/08/20"),
	(70010, 04, "D035", 200, 40, 250, "2007/02/20"),
	(70010, 05, "P220", 6000, 3500, 6000, "2007/03/31"),
	(70010, 06, "P240", 6000, 2000, 2000, "2007/03/31"),
	(70011, 01, "I105", 1000, 600, 1000, "2007/05/16"),
	(70020, 01, "B001", 200, 140, NULL, "2007/12/31"),
	(70020, 02, "B002", 200, 140, NULL, "2007/12/31"),
	(70025, 01, "I100", 1000, 590, 1000, "2007/05/15"),
	(70025, 02, "I105", 50, 590, 500, "2007/05/15"),
	(70210, 01, "I100", 1000, 470, 1000, "2007/07/15"),
	(70010, 09, "P220", 10000, 3500, 10000, "2007/08/31"),
	(70300, 01, "I110", 50, 790, 50, "2007/10/31"),
	(70250, 01, "P230", 15000, 4900, 12000, "2007/12/15"),
	(70250, 02, "P220", 10000, 3350, 10000, "2007/11/10"),
	(70620, 01, "I105", 200, 600, 200, "2007/11/01"),
	(70625, 01, "I100", 1000, 470, 1000, "2007/10/15"),
	(70625, 02, "P220", 10000, 3500, 10000, "2007/10/31"),
	(70629, 01, "B001", 200, 140, NULL,"2007/12/31"),
	(70629, 02, "B002", 200, 140, NULL,"2007/12/31");




CREATE TABLE vente (
  codart char(4) NOT NULL,
  numfou int(11) NOT NULL,
  delliv smallint(6) NOT NULL,
  qte1 int(11) NOT NULL,
  prix1 decimal(5,0) NOT NULL,
  qte2 int(11) DEFAULT NULL,
  prix2 decimal(5,0) DEFAULT NULL,
  qte3 int(11) DEFAULT NULL,
  prix3 decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (codart,numfou),
  KEY numfou (numfou),
  FOREIGN KEY (numfou) REFERENCES fournis (numfou),
  FOREIGN KEY (codart) REFERENCES produit (codart)
) ;

INSERT INTO vente(codart, numfou, delliv, qte1, prix1, qte2, prix2, qte3, prix3)
VALUES
('I100', 00120, 90, 0, 700, 50, 600, 120 , 500),
('I100', 00540, 70, 0, 710, 60, 630, 100, 600),
('I100', 09120, 60, 0, 800, 70, 600, 90, 500),
('I100', 09150, 90, 0, 650, 90, 600 ,200, 590),
('I100', 09180, 30, 0, 720, 50, 670, 100, 490),
('I105', 00120, 90, 10, 705, 50, 630 , 120, 500),
('I105', 00540, 70, 0, 810, 60, 645 ,100, 600),
('B002', 09120, 60, 0, 920, 70, 800 ,90, 700),
('I105', 09150, 90, 0, 685, 90, 600 ,200, 590),
('I105', 08700, 30, 0, 720, 50, 670 ,100, 510),
('I108', 00120, 90, 5, 795, 30, 720 ,100, 680),
('I108', 09120, 60, 0, 920, 70, 820 ,100 ,780),
('I110', 09180, 90, 0, 900, 70, 870 ,90 ,835),
('I110', 09120, 60, 0, 950, 70, 850 ,90 ,790),
('D035', 00120, 0, 0, 40, NULL, NULL, NULL, NULL),
('D035', 09120, 5, 0, 40 ,100 ,30, NULL, NULL),
('I105', 09120, 8, 0 ,37, NULL, NULL, NULL, NULL),
('B001', 00120, 0, 0, 40, NULL, NULL, NULL, NULL),
('B001', 09120, 8, 0, 37, NULL, NULL, NULL, NULL),
('P220', 00120, 15, 0, 3700, 100,3500, NULL, NULL),
('P230', 00120, 30, 0, 5200, 100, 5000, NULL, NULL),
('P240', 00120, 15, 0, 2200, 100, 2000, NULL, NULL),
('P250', 00120, 30, 0, 1500, 100, 1400, 500 ,1200),
('P250', 09120, 30, 0, 1500, 100, 1400, 500 ,1200),
('P220', 08700, 20, 50, 3500, 100, 3350, NULL, NULL),
('P230', 08700, 60, 0, 5000, 50, 4900, NULL, NULL),
('R080', 09120, 10, 0, 120, 100, 100, NULL, NULL),
('R132', 09120, 5, 0, 275, NULL, NULL, NULL, NULL),
('B001', 08700, 15, 0, 150, 50, 145, 100, 140),
('B002', 08700, 15, 0, 210, 50, 200, 100, 185)
;
	