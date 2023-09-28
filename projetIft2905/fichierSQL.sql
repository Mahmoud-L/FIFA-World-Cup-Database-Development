
CREATE TABLE Coupe_Du_Monde (
  Id_CdM SERIAL NOT NULL,
  Annee_CdM INTEGER NOT NULL,
  Pays_organisateur VARCHAR(255) NOT NULL,
  PRIMARY KEY(Id_CdM)
);
CREATE TABLE Equipe_Rank (
  Id_Equipe SERIAL NOT NULL,
  FIFA_rank INTEGER Unique NOT NULL,
  primary key(id_equipe)
);
CREATE TABLE Equipe (
  Id_Equipe SERIAL NOT NULL,
  Pays_Represente VARCHAR(255) Unique NOT NULL,
  PRIMARY KEY (Id_Equipe, Pays_Represente)
);
CREATE TABLE Personnel_Equipe (
  Matricule SERIAL  NOT NULL ,
  Nom VARCHAR(255) NOT NULL,
  Prenom VARCHAR(255) NOT NULL,
  Date_Naissance DATE NOT NULL,
  Lieu_Naissance VARCHAR(255) NOT NULL,
  Fonction VARCHAR(255) NOT NULL,
  id_equipe integer not null,
  primary key (matricule)
);

ALTER TABLE Personnel_Equipe
    ADD CONSTRAINT fk_personnel_equipe
        FOREIGN KEY (id_equipe)
            REFERENCES Equipe_Rank(id_equipe);
CREATE TABLE Joueur (
  Matricule INTEGER UNIQUE NOT NULL,
  Numero INTEGER NOT NULL ,
  Nom VARCHAR(255) NOT NULL,
  Prenom VARCHAR(255) NOT NULL,
  Date_Naissance DATE NOT NULL,
  Lieu_Naissance VARCHAR(255) NOT NULL,
  Fonction VARCHAR(255) NOT NULL,
  Poste VARCHAR(255) NOT NULL,
  Taille INTEGER NOT NULL,
  Poids INTEGER NOT NULL,
  Pied_Fort VARCHAR(255) NOT NULL,
  id_equipe integer not null,
  PRIMARY KEY (matricule)
);
ALTER TABLE Joueur 
    ADD CONSTRAINT fk_Joueur 
        FOREIGN KEY (id_equipe)
            REFERENCES Equipe_Rank(id_equipe);
CREATE TABLE Participer (
  ID_CdM INTEGER NOT NULL ,
  Id_Equipe INTEGER NOT NULL,
  PRIMARY KEY (ID_CdM, Id_Equipe)
);
ALTER TABLE Participer 
    ADD CONSTRAINT fk_Participer_CDM  
        FOREIGN KEY (ID_CdM)
            REFERENCES Coupe_Du_Monde(ID_CdM),
    ADD CONSTRAINT fk_Participer_equipe  
        FOREIGN KEY (Id_Equipe)
            REFERENCES Equipe_Rank(Id_Equipe);

CREATE TABLE Match (
  ID_Match SERIAL PRIMARY KEY,
  Date DATE NOT NULL,
  Lieu VARCHAR(255) NOT NULL,
  Rang VARCHAR(255) NOT NULL,
  But_Eq_Dom INTEGER NOT NULL CHECK (But_Eq_Dom >= 0),
  But_Eq_Ext INTEGER NOT NULL CHECK (But_Eq_Ext >= 0),
  ID_CdM INTEGER NOT NULL,
  Id_equipe_dom SERIAL NOT NULL ,
  Id_equipe_ext SERIAL NOT NULL 
);
ALTER TABLE Match 
    ADD CONSTRAINT fk_Match 
        FOREIGN KEY (ID_CdM)
            REFERENCES Coupe_Du_Monde(ID_CdM),
    ADD CONSTRAINT fk_Match_equipe_dom 
        FOREIGN KEY (Id_equipe_dom)
          REFERENCES Equipe_Rank(Id_Equipe),
    ADD CONSTRAINT fk_Match_equipe_ext 
        FOREIGN KEY (Id_equipe_ext)
            REFERENCES Equipe_Rank(Id_Equipe);
CREATE TABLE Arbitre (
  ID_Arbitre SERIAL PRIMARY KEY,
  Nom VARCHAR(255) NOT NULL,
  Prenom VARCHAR(255) NOT NULL,
  Nationalite VARCHAR(255) NOT NULL,
  Status VARCHAR(255) NOT NULL,
  Licence VARCHAR(255) Unique NOT NULL
);

CREATE TABLE Sanctionner (
  Matricule serial NOT NULL ,
  ID_Match serial NOT NULL ,
  Carton_ROUGE BOOLEAN ,
  carton_jaune boolean , 
  PRIMARY KEY (matricule, ID_Match)
);
ALTER TABLE Sanctionner 
    ADD CONSTRAINT fk_Sanctionner_matricule
        FOREIGN KEY(matricule)
            REFERENCES Joueur(matricule),
    ADD CONSTRAINT fk_Sanctionner_match 
        FOREIGN KEY(ID_Match )
            REFERENCES Match(ID_Match);

CREATE TABLE Gerer (
  ID_Match serial NOT NULL ,
  ID_Arbitre serial NOT NULL ,
  fonction VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID_Match, ID_Arbitre)
);
ALTER TABLE Gerer 
    ADD CONSTRAINT fk_Gerer_match
        FOREIGN KEY(ID_Match)
            REFERENCES Match(ID_Match),
    ADD CONSTRAINT fk_Gerer_arbitre
        FOREIGN KEY(ID_Arbitre )
            REFERENCES Arbitre(ID_Arbitre);

INSERT INTO Coupe_Du_Monde (id_CdM, Annee_CdM, Pays_organisateur) 
VALUES 
(1, 1930, 'Uruguay'), 
(2, 1934, 'Italie'), 
(3, 1938, 'France'), 
(4, 1950, 'Brésil'), 
(5, 1954, 'Suisse'), 
(6, 1958, 'Suede'), 
(7, 1962, 'Chili'), 
(8, 1966, 'Angleterre'), 
(9, 1970, 'Mexique'), 
(10, 1974, 'France'), 
(11, 1978, 'Argentine'), 
(12, 1982, 'Espagne'), 
(13, 1986, 'Mexique'), 
(14, 1990, 'Italie'), 
(15, 1994, 'États-Unis');

INSERT INTO Equipe_Rank (Id_Equipe, FIFA_rank) 
VALUES 
(1, 5),
(2, 12),
(3, 8),
(4, 25),
(5, 2),
(6, 14),
(7, 17),
(8, 10),
(9, 3),
(10, 29),
(11, 6),
(12, 20),
(13, 11),
(14, 7),
(15, 16),
(16,28),
(17,99);

INSERT INTO Equipe (Id_Equipe, Pays_Represente) 
VALUES (1, 'France'),
       (2, 'Brésil'),
       (3, 'Allemagne'),
       (4, 'Espagne'),
       (5, 'Argentine'),
       (6, 'Portugal'),
       (7, 'Belgique'),
       (8, 'Italie'),
       (9, 'Pays-Bas'),
       (10, 'Angleterre'),
       (11, 'Uruguay'),
       (12, 'Colombie'),
       (13, 'Mexique'),
       (14, 'Suisse'),
       (15, 'Chili'),
	(16,'Suede'),
	(17,'États-Unis');

INSERT INTO Personnel_Equipe (Matricule, Nom, Prenom, Date_naissance,Lieu_Naissance ,Fonction,id_equipe)
VALUES
(1, 'Amara', 'Rayen', '1980-05-25', 'France', 'Entraîneur', 1),
(2, 'Martin', 'Marie', '1985-02-10', 'France', 'Entraîneur adjoint', 1),
(3, 'Lefevre', 'Paul', '1990-09-03', 'Suisse', 'Médecin', 1),
(4, 'Girard', 'Julie', '1987-07-15', 'France', 'Kinésithérapeute', 1),
(5, 'Coulon', 'Pierre', '1978-12-29', 'Angleterre', 'Préparateur physique', 2),
(6, 'Garcia', 'Isabelle', '1984-03-08', 'Colombie', 'Médecin', 2),
(7, 'Durand', 'Luc', '1976-11-22', 'Pays-Bas', 'Entraîneur', 3),
(8, 'Bouchard', 'Sophie', '1992-06-16', 'États-Unis', 'Kinésithérapeute', 3),
(9, 'Petit', 'Thomas', '1981-04-18', 'États-Unis', 'Entraîneur adjoint', 4),
(10, 'Vidal', 'Julie', '1993-01-12', 'Suisse', 'Médecin', 4),
(11, 'Robert', 'Cécile', '1988-08-05', 'Belgique', 'Préparateur physique', 5),
(12, 'Gonzalez', 'Ana', '1983-10-17', 'Italie', 'Stagiaire', 12),
(13, 'Sanchez', 'Manuel', '1979-07-29', 'Chili', 'Entraîneur', 13),
(14, 'Garcia', 'Carmen', '1994-12-03', 'États-Unis', 'Médecin', 14),
(15,'Rodriguez', 'Maria', '1997-06-08', 'Suisse', 'Entraîneur', 15);

INSERT INTO Joueur (Matricule, Numero, Nom, Prenom, date_naissance, Lieu_Naissance, Fonction, Poste, Taille, Poids, Pied_Fort, Id_Equipe)
VALUES
(16, 7, 'Ronaldo', 'Cristiano', '1985-02-05', 'Funchal', 'Joueur', 'Attaquant', 187, 83, 'Droit', 1),
(17, 10, 'Messi', 'Lionel', '1987-06-24', 'Rosario', 'Joueur', 'Attaquant', 170, 72, 'Gauche', 2),
(18, 9, 'Salah', 'Mohamed', '1992-06-15', 'Nagrig', 'Joueur', 'Attaquant', 175, 71, 'Gauche', 3),
(19, 11, 'Neymar', 'Junior', '1992-02-05', 'Mogi das Cruzes', 'Joueur', 'Attaquant', 175, 68, 'Droit', 4),
(20, 8, 'Mbappe', 'Kylian', '1998-12-20', 'Bondy', 'Joueur', 'Attaquant', 178, 73, 'Droit', 5),
(21, 17, 'Lewandowski', 'Robert', '1988-08-21', 'Varsovie', 'Joueur', 'Attaquant', 185, 80, 'Droit', 6),
(22, 6, 'Suarez', 'Luis', '1987-01-24', 'Salto', 'Joueur', 'Attaquant', 182, 86, 'Droit', 7),
(23, 25, 'Kane', 'Harry', '1993-07-28', 'Londres', 'Joueur','Attaquant', 185, 80, 'Droit', 8),
(24, 1, 'Doe', 'John', '1990-01-01', 'Paris', 'Joueur', 'Attaquant', 180, 75, 'Droit', 9),
 (25, 2, 'Smith', 'Emma', '1995-02-14', 'Lyon', 'Joueur', 'Milieu', 175, 68, 'Gauche', 10),
(26, 3, 'Lee', 'David', '1992-05-21', 'Marseille', 'Joueur', 'Défenseur', 185, 80, 'Droit', 11),
(27, 4, 'Garcia', 'Maria', '1993-08-08', 'Lille', 'Joueur', 'Attaquant', 178, 70, 'Gauche', 12),
(28, 5, 'Gonzalez', 'Carlos', '1991-06-15', 'Nice', 'Joueur', 'Milieu', 182, 74, 'Droit', 13),
(29, 13, 'Lopez', 'Sophie', '1994-09-02', 'Nantes', 'Joueur', 'Défenseur', 187, 85, 'Gauche', 14),
(30, 15, 'Wang', 'Yong', '1993-03-12', 'Toulouse', 'Joueur', 'Attaquant', 183, 77, 'Droit', 15);

INSERT INTO Participer (ID_CdM, ID_equipe)
VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (5, 8), (5, 9), (4, 10), (4, 11), (3, 12), (3, 13), (2, 14), (2, 15),(1,11),(2,8),(3,1),(4,2),(5,14),(6,16),(7,15),(8,10),(9,13),(10,1),(11,5),(12,4),(13,13),(14,8),(15,17);

INSERT INTO Match (ID_Match, Date, Lieu, Rang, But_Eq_Dom,But_Eq_Ext,ID_CdM,id_equipe_dom,id_equipe_ext)
VALUES (1, '1938-06-05', 'Parc des Princes, Paris, France', '1er tour',3,0, 3 ,1, 2),
       (2, '1938-06-05', 'Stade Olympique de Colombes, Paris, France', '1er tour', 6,0, 3,3,4),
       (3, '1938-06-05', 'Stade de la Meinau, Strasbourg, France', '1er tour', 3,1, 3,5,6),
       (4, '1938-06-05', 'Stade du Fort Carré, Antibes, France', '1er tour', 1,0, 3,7,8),
       (5, '1938-06-12', 'Parc des Princes, Paris, France', '2eme tour', 4,2, 3,9,10),
       (6, '1950-06-24', 'Estádio do Maracanã, Rio de Janeiro, Brésil', '2eme tour', 2,1, 4,11,12),
       (7, '1950-06-24', 'Estádio dos Eucaliptos, Porto Alegre, Brésil', '1er tour', 4,0, 4,13,14),
       (8, '1950-06-25', 'Estádio Independência, Belo Horizonte, Brésil', '2eme tour', 2,1, 4,15,1),
       (9, '1950-06-25', 'Estádio do Pacaembu, São Paulo, Brésil', '2eme tour', 2,0, 4,12,3),
       (10, '1966-07-23', 'Wembley Stadium, Londres, Angleterre', '1/4 de final', 1,0, 4,4,5),
       (11, '1966-07-23', 'Hillsborough Stadium, Sheffield, Angleterre', '1/4 de final', 3,1, 8,6,7),
       (12, '1966-07-23', 'Goodison Park, Liverpool, Angleterre', '1/4 de final', 1,0, 8,8,9),
       (13, '1966-07-23', 'Old Trafford, Manchester, Angleterre', '1/4 de final', 1,0, 8,10,11),
       (14, '1966-07-26', 'Hillsborough Stadium, Sheffield, Angleterre', '1/2 de final', 2,1, 8,12,13),
       (15, '1966-07-26', 'Wembley Stadium, Londres, Angleterre', '1/2 de final',2,1, 8,14,15);

INSERT INTO Arbitre (ID_Arbitre, Nom, Prenom, Nationalite, Status, Licence) 
VALUES 
(1, 'Douet', 'Owen', 'France', 'International', '12345'), 
(2, 'Garcia', 'Maria', 'Espagne', 'National', '23456'), 
(3, 'Smith', 'John', 'Angleterre', 'International', '34567'), 
(4, 'Müller', 'Hans', 'Allemagne', 'National', '45678'), 
(5, 'Lopez', 'Juan', 'Argentine', 'International', '56789'), 
(6, 'Dubois', 'Anne', 'France', 'National', '67890'), 
(7, 'Silva', 'Carlos', 'Brésil', 'International', '78901'), 
(8, 'Taylor', 'Emma', 'Angleterre', 'National', '89012'), 
(9, 'Bianchi', 'Luigi', 'Italie', 'International', '90123'), 
(10, 'Kim', 'Soo-Young', 'Corée du Sud', 'National', '01234'), 
(11, 'Pereira', 'Miguel', 'Portugal', 'International', '23451'), 
(12, 'Wang', 'Li', 'Chine', 'National', '34562'), 
(13, 'Kovacs', 'Gabor', 'Hongrie', 'International', '45673'), 
(14, 'Mori', 'Takeshi', 'Japon', 'National', '56784'), 
(15, 'Gonzalez', 'Ricardo', 'Mexique', 'International', '67895'),
(16,'Isam','Chaweli','Tunisie','international','32325');

INSERT INTO Gerer (ID_Match, ID_Arbitre,fonction) VALUES
  (1, 1, 'principal'),
  (1, 2, 'assistant'),
  (1, 3, 'assistant'),
  (1, 4, 'assistant'),
  (2, 5, 'principal'),
  (2, 6, 'assistant'),
  (2, 7, 'assistant'),
  (2, 8, 'assistant'),
  (3, 9, 'principal'),
  (3, 10, 'assistant'),
  (3, 11, 'assistant'),
  (3, 12, 'assistant'),
  (4, 13, 'principal'),
  (4, 14, 'assistant'),
  (4, 15, 'assistant'),
  (4, 16, 'assistant');

INSERT INTO Sanctionner(Matricule, ID_Match,Carton_Rouge,carton_jaune) VALUES
(16,1,true,false),
(17,9,true,false),
(18,2,true,false),
(19,2,false,true),
(20,3,true,true),
(21,3,false,true),
(22,4,true,false),
(23,4,true,false),
(24,5,false,true),
(27,6,false,true),
(30,15,false,true);
INSERT INTO Match (ID_Match, Date, Lieu, Rang, But_Eq_Dom,But_Eq_Ext,ID_CdM,id_equipe_dom,id_equipe_ext)
VALUES (16, '1966-06-22' ,'Stade Wembley, London, Anglettere', 'Finale', 1, 0, 8,10,12);
INSERT INTO sanctionner (matricule, id_match, carton_rouge,carton_jaune)
VALUES (21, 1, false,true), (21, 2, false,true), (30, 14, false,true), (23, 15, false,true);
INSERT INTO Joueur (matricule,numero, nom, prenom, date_naissance, 
					lieu_naissance, fonction, poste, taille, 
					poids, pied_fort, id_equipe)
VALUES (31, 1, 'Seaman', 'David', '1940-01-01', 'London', 'Joueur',
		'Gardien', 180, 72, 'Droit', 10),
	   (32, 3, 'Campbell', 'Sol', '1942-03-07', 'London', 'Joueur', 
		'Defenseur', 188, 82, 'Gauche', 10),
		(33, 9, 'Linkeer', 'Gary', '1941-05-06', 'Liverpool', 'Joueur', 
		'Attaquant', 177, 75, 'Droit', 10);
INSERT INTO Sanctionner (matricule, id_match,carton_rouge,carton_jaune)
VALUES (25, 16, false,true), (31, 16, false,true), (32, 16, false,true), (33, 16, false,true);
INSERT INTO gerer (id_match, id_arbitre, fonction)
VALUES (16, 1, 'Principal');


WITH  equipes_gagnantes_dom AS (   
	 SELECT date, id_equipe_dom as id_equipe  
	 FROM match 
	 WHERE rang='Finale' AND but_eq_dom>but_eq_ext
), 
equipes_gagnantes_ext AS (
	SELECT date, id_equipe_ext as id_equipe
	FROM match 
	WHERE rang='Finale' AND but_eq_dom<but_eq_ext
), 
equipes_gagnantes AS (
	SELECT * 
	FROM equipes_gagnantes_dom 
	UNION 
	SELECT * 
	FROM equipes_gagnantes_ext
), 
nations_gagnantes AS (
	SELECT pays_represente, date  
	FROM equipes_gagnantes 
	JOIN (SELECT id_equipe, pays_represente FROM equipe) t
	ON equipes_gagnantes.id_equipe= t.id_equipe
) 
SELECT pays_represente, date  
FROM (nations_gagnantes JOIN coupe_du_monde 
ON (EXTRACT(YEAR FROM date::DATE)=annee_cdm AND pays_represente=pays_organisateur));  


WITH 
sanctions_carton_jaune AS (  SELECT matricule, id_cdm  
 FROM (SELECT matricule, id_match 
 FROM sanctionner  
 WHERE carton_jaune=true) t1 
 JOIN (SELECT id_match, id_cdm  
 FROM match) t2  
 ON t1.id_match=t2.id_match 
), 
sanctions_joueur_par_cdm AS ( 
 SELECT matricule, id_cdm, COUNT (*) as count_sanctions   
from sanctions_carton_jaune  
 group by matricule, id_cdm 
), 
plus_sanctionne_par_cdm AS ( 
 SELECT matricule, t1.id_cdm, max_sanctions  from sanctions_joueur_par_cdm t1  
 JOIN (SELECT id_cdm, 
MAX(count_sanctions) as max_sanctions  
	  	 	 	FROM sanctions_joueur_par_cdm  
	  	 	 	group by id_cdm) t2  
 on t1.id_cdm=t2.id_cdm AND t1.count_sanctions=t2.max_sanctions 
), 
t1 AS ( 
 SELECT nom, prenom, id_cdm, max_sanctions  
 FROM plus_sanctionne_par_cdm   JOIN (SELECT nom, prenom, matricule  
	  	  from joueur) t2  
 ON plus_sanctionne_par_cdm.matricule=t2.matricule 
), 
t2 AS ( 
 SELECT nom, prenom, annee_cdm, max_sanctions 
 FROM t1  
 JOIN (SELECT id_cdm, annee_cdm from coupe_du_monde) t2 
 ON  t1.id_cdm=t2.id_cdm) 
SELECT * FROM t2;

WITH  entraineurs as (SELECT nom, prenom, id_equipe, lieu_naissance from 
personnel_equipe where fonction='Entraîneur'), 
t1 as (
SELECT nom,prenom,pays_represente 
FROM entraineurs 
join (select id_equipe, pays_represente from equipe) t 
on entraineurs.id_equipe=t.id_equipe
AND entraineurs.lieu_naissance=t.pays_represente) 
SELECT * FROM t1 ;

WITH sanctions_en_finales AS ( 
 SELECT t1.id_match 
 FROM (select id_match from sanctionner) t  
 JOIN (SELECT id_match 
FROM match 
WHERE rang='Finale') t1  
on t.id_match=t1.id_match 
), 
matchs AS (  SELECT id_match 
 FROM ( 
	 	SELECT id_match, count(*) as total_sanctions 
	 	FROM sanctions_en_finales 
	 	GROUP BY id_match) t1 
	 	WHERE t1.total_sanctions>2 
), 
t0 as ( 
 SELECT id_arbitre  
 FROM matchs 
 JOIN (SELECT id_arbitre, id_match 
FROM gerer 
WHERE fonction='Principal') t1  
 ON t1.id_match=matchs.id_match 
) 
SELECT nom, prenom from t0 
JOIN (SELECT id_arbitre, nom, prenom 
FROM arbitre) t1 on t0.id_arbitre=t1.id_arbitre ;
