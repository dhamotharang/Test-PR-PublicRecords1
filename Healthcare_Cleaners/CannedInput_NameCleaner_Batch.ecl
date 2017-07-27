#Stored('DPPAPurpose',1);
#Stored('GLBPurpose',1);
#Stored('DataRestrictionMask','00000000000000000');
#WORKUNIT('name','Healthcare_Cleaners.CannedInput_NameCleaner_Batch Test');    //name it "MyJob"
Import Healthcare_Cleaners;
myInput := record
	string20	 	acctno := '';
	String100 	nameFull := '';
	string10		EnclarityPrefix := '';
	string50		EnclarityFirst := '';
	string50		EnclarityMiddle := '';
	string50		EnclarityLast := '';
	string10		EnclaritySuffix := '';
	string15		EnclarityProfessionalSuffix := '';
	string5			EnclarityGender := '';
	string15		EnclarityPreferred := '';
	string15		EnclarityConfidence := '';
end;

ds_batch := dataset([
{'1','Arturo Briones, DC','','Arturo','','Briones','','DC','1','ARTHUR','24'},
{'2','Jack Barning Jr, DC','','Jack','','Barning','Jr','DC','1','JACK','24'},
{'3','Jed Seitzinger Do','','Jed','Seitzinger','Do','','','1','JED','43'},
{'4','Robert Buse, MD','','Robert','','Buse','','MD','1','ROBERT','24'},
{'5','Ronald Hammer, DC','','Ronald','','Hammer','','DC','1','RONALD','24'},
{'6','John E. Oxler, MD','','John','E.','Oxler','','MD','1','JOHN','31'},
{'7','Clifford Soults, MD','','Clifford','','Soults','','MD','1','CLIFFORD','24'},
{'8','Edward Cohn, MD','','Edward','','Cohn','','MD','1','EDWARD','24'},
{'9','Mark Mossuto','','Mark','','Mossuto','','','1','MARK','24'},
{'10','John C. Breckinridge Sr sr, MD','','John','C.','Breckinridge','Sr sr','MD','1','JOHN','30'},
{'11','Gary Stuck Do','','Gary','Stuck','Do','','','1','GARRETT','43'},
{'12','Connie J. Grass, DC','','Connie','J.','Grass','','DC','5','CONSTANCE','31'},
{'13','Anthony Bilotti, MD','','Anthony','','Bilotti','','MD','1','ANTHONY','24'},
{'14','John A. Dacbr','','John','A.','Dacbr','','','1','JOHN','27'},
{'15','John Hogan','','John','','Hogan','','','1','JOHN','24'},
{'16','Charles Gottlob, MD','','Charles','','Gottlob','','MD','1','CHARLES','24'},
{'17','Kenneth A. Hermens, MD','','Kenneth','A.','Hermens','','MD','1','KENNETH','31'},
{'18','Martin S. McLeod, DC','','Martin','S.','McLeod','','DC','1','MARTIN','29'},
{'19','Tammy Tryboski, PT','','Tammy','','Tryboski','','PT','5','TAMARA','24'},
{'20','Daniel S. Krop, MD','','Daniel','S.','Krop','','MD','1','DANIEL','31'},
{'21','Mark Malnor, MD','','Mark','','Malnor','','MD','1','MARK','24'},
{'22','Julie Perreault','','Julie','','Perreault','','','5','JULIA','24'},
{'23','Macdonald Andre J., MD','','Macdonald','Andre','J.','','MD','1','MACDONALD','0'},
{'24','Janet F. Schuster, CMT','','Janet','F.','Schuster','','CMT','5','JANET','31'},
{'25','David Jolgren, MD','','David','','Jolgren','','MD','1','DAVID','24'},
{'26','Arundathi Reddy','','Arundathi','','Reddy','','','5','ARUNDATHI','24'},
{'27','Gordon Davis Do','','Gordon','Davis','Do','','','1','GORDON','42'},
{'28','Barbara A. Luikens, MD','','Barbara','A.','Luikens','','MD','5','BARBARA','31'},
{'29','Amy Jermann, PAC','','Amy','','Jermann','','PAC','5','AMY','24'},
{'30','Todd B. Flitton, DPM','','Todd','B.','Flitton','','DPM','1','TOD','31'},
{'31','Leif E. McGuire, PT','','Leif','E.','McGuire','','PT','1','LEIF','31'},
{'32','R. L. Burdett, DC','','R.','L.','Burdett','','DC','3','R.','28'},
{'33','Joe Tsou, MD','','Joe','','Tsou','','MD','1','JOSEPH','24'},
{'34','Steven Goldstein Jr, DC','','Steven','','Goldstein','Jr','DC','1','STEVEN','24'},
{'35','Kerby Lamb Do','','Kerby','Lamb','Do','','','1','KERBY','39'},
{'36','N. Diamond Do','','N.','Diamond','Do','','','3','N.','0'},
{'37','Huma H. Naqvi, MD','','Huma','H.','Naqvi','','MD','0','HUMA','29'},
{'38','Van Warren, MD','','','','Van Warren','','MD','3','','0'},
{'39','Health Metro, DNT','','Health','','Metro','','DNT','0','HEALTH','0'},
{'40','Little Prairie, DNT','','Little','','Prairie','','DNT','2','LITTLE','19'},
{'41','Paula Wells, MD','','Paula','','Wells','','MD','5','PAULA','24'},
{'42','Nancy K. Wild, GNP','','Nancy','K.','Wild','','GNP','5','NANCY','31'},
{'43','Allison L. Wheeler, APRN CPNP-AC','','Allison','L.','Wheeler','','APRN CPNP-AC','4','ALLISON','29'},
{'44','Brenda Kay Ames, RN C-ANP','','Brenda','Kay','Ames','','RN C-ANP','5','BRENDA','32'},
{'45','Kamie Dawn Theobald','','Kamie','Dawn','Theobald','','','5','KAMIE','32'},
{'46','Brad Wellington','','Brad','','Wellington','','','1','BRADLEY','22'},
{'47','Peter Wells III, MD','','Peter','','Wells','III','MD','1','PETER','24'},
{'48','Daniel Wells Jr, MD','','Daniel','','Wells','Jr','MD','1','DANIEL','24'},
{'49','Wesley Austin, ED.D.','','Wesley','','Austin','','ED.D.','1','WESLEY','24'},
{'50','Larry Aycock, ED.D.','','Larry','','Aycock','','ED.D.','1','LAURENCE','24'},
{'51','Karen J. Richardson, ANP CS','','Karen','J.','Richardson','','ANP CS','5','KAREN','31'},
{'52','The Aroostook Center, MED','','The','Aroostook','Center','','MED','0','Aroostook','0'},
{'53','Dr. Susan M. June','Dr.','Susan','M.','June','','','5','SUSAN','27'},
{'54','Dr. Susan M. June','Dr.','Susan','M.','June','','','5','SUSAN','27'},
{'55','Dr Susan M. June','Dr','Susan','M.','June','','','5','SUSAN','27'},
{'56','Dr Susan M. June','Dr','Susan','M.','June','','','5','SUSAN','27'},
{'57','Dr Susan M. June','Dr','Susan','M.','June','','','5','SUSAN','27'},
{'58','Dr. D.r. Susan M. June','Dr.','D.r.','Susan M.','June','','','5','SUSAN','0'},
{'59','Mrs. Ester Lynn Cravitt','Mrs.','Ester','Lynn','Cravitt','','','4','ESTHER','33'},
{'60','Mrs Ester Lynn Cravitt','Mrs','Ester','Lynn','Cravitt','','','4','ESTHER','33'},
{'61','Clark Daniel Medicine','','Clark','Daniel','Medicine','','','1','CLARK','0'},
{'62','Kayla Reed','','Kayla','','Reed','','','5','KAYLA','24'},
{'63','Peter Qw Hanson','','Peter','Qw','Hanson','','','1','PETER','14'},
{'64','Peter Qw Hanson','','Peter','Qw','Hanson','','','1','PETER','14'},
{'65','Peter Hanson','','Peter','','Hanson','','','1','PETER','24'},
{'66','Peter Hanson','','Peter','','Hanson','','','1','PETER','24'},
{'67','Peter-Hanson','','','','Peter-Hanson','','','3','','0'},
{'68','Peter Hanson','','Peter','','Hanson','','','1','PETER','24'},
{'69','Peter Hanson','','Peter','','Hanson','','','1','PETER','24'},
{'70','Betty Lou Johnson-Taggert','','Betty','Lou','Johnson-Taggert','','','5','ELIZABETH','32'},
{'71','Mr T.J. Cully','Mr','T.J.','','Cully','','','1','TJ','24'},
{'72','Sandra K. Broz, EDD','','Sandra','K.','Broz','','EDD','5','SANDRA','31'},
{'73','Dr Michael Nesbit, EDD','Dr','Michael','','Nesbit','','EDD','1','MICHAEL','24'},
{'74','Dr Frank Williams IV, DDS','Dr','Frank','','Williams','IV','DDS','1','FRANCIS','24'},
{'75','Rob Hensen, M.A.M.F.C.','','Rob','','Hensen','','M.A.M.F.C.','1','ROBERT','24'},
{'76','Michael Dan Potts, TH.M.','','Michael','Dan','Potts','','TH.M.','1','MICHAEL','33'},
{'77','Abby M. Jamison Duran M.s.','','Abby','M. Jamison','Duran M.s.','','','5','ABIGAIL','61'},
{'78','Edwin S. Dan Beard IV, M.ED.','','Edwin','S.','Dan Beard','IV','M.ED.','1','EDWIN','40'},
{'79','Ronald J. Lechnyr, MSW DSW PHD','','Ronald','J.','Lechnyr','','MSW DSW PHD','1','RONALD','31'},
{'80','Gary E. Cockran M.a.','','Gary','E. Cockran','M.a.','','','1','GARRETT','49'},
{'81','Connie Cook II, PA-C','','Connie','','Cook','II','PA-C','5','CONSTANCE','24'},
{'82','E. Dean Schroeder VIII, PHY.D.','','E.','Dean','Schroeder','VIII','PHY.D.','3','E.','30'},
{'83','Julie Andrews, D.P.M.','','Julie','','Andrews','','D.P.M.','5','JULIA','24'},
{'84','Raymond Dieter Jr., MD F.A.C.S.','','Raymond','','Dieter','Jr.','MD F.A.C.S.','1','RAYMOND','21'},
{'85','Peggy Alexander, APRN FNP M.S.N.','','Peggy','','Alexander','','APRN FNP M.S.N.','5','MARGARET','22'},
{'86','Kelly Powell Ccc-A, M.C.D','','Kelly','Powell','Ccc-A','','M.C.D','3','KELLY','26'},
{'87','Qin Pu Pa','','Qin','Pu','Pa','','','3','QIN','39'},
{'88','Glenn Nelson, MD F.A.A.F.P.','','Glenn','','Nelson','','MD F.A.A.F.P.','1','GLENN','24'},
{'89','Masue Li, MD F.A.C.O.G.','','Masue','','Li','','MD F.A.C.O.G.','5','MASUE','22'},
{'90','Mia Taormina, D.O. F.A.C.O.I.','','Mia','','Taormina','','D.O. F.A.C.O.I.','5','MICHELLE','24'},
{'91','Dominic Costabile, D.O. F.A.A.F.P.','','Dominic','','Costabile','','D.O. F.A.A.F.P.','1','DOMINICK','24'},
{'92','Jose Silva, MD ND','','Jose','','Silva','','MD ND','1','JOSEPH','24'},
{'93','Malcolm Andry Jr, MD','','Malcolm','','Andry','Jr','MD','1','MALCOLM','24'},
{'94','Regina Ri Xia, L.AC.','','Regina','Ri','Xia','','L.AC.','5','REGINA','1'},
{'95','Regina Xia Ri, L.AC.','','Regina','Xia','Ri','','L.AC.','5','REGINA','17'},
{'96','Van Le','','Van','','Le','','','2','VANCE','21'},
{'97','Van Le','','Van','','Le','','','2','VANCE','21'},
{'98','Xin Du','','Xin','','Du','','','3','XIN','21'},
{'99','Du Chang Xin','','Du','Chang','Xin','','','2','DU','27'},
{'100','Dawn Doctor','','Dawn','','Doctor','','','5','DAWN','23'},
{'101','Dawn Doctor, MD','','Dawn','','Doctor','','MD','5','DAWN','23'},
{'102','Doctor Dawn Michels','','Doctor','Dawn','Michels','','','0','Doctor','30'},
{'103','Michels Doctor Dawn, MD','','Michels','Doctor','Dawn','','MD','3','MICHELS','21'},
{'104','Dr. Dawn Marie Michels, MD','Dr.','Dawn','Marie','Michels','','MD','5','DAWN','33'},
{'105','Dawn Do','','Dawn','','Do','','','5','DAWN','22'},
{'106','Dawn Do, DO','','Dawn','','Do','','DO','5','DAWN','22'},
{'107','Deanna J. Schroeder, APRN-CNP','','Deanna','J.','Schroeder','','APRN-CNP','5','DEANNA','31'},
{'108','Joan L. Oliver Schroeder, APRN CNP','','Joan','L.','Oliver Schroeder','','APRN CNP','5','JOAN','41'},
{'109','Courtney M. Hillen, CNM APRN','','Courtney','M.','Hillen','','CNM APRN','3','COURTNEY','29'},
{'110','Gretchen Lee Hahn, APRN CNM','','Gretchen','Lee','Hahn','','APRN CNM','5','GRETCHEN','31'},
{'111','Anna Lisa Burdette, APRN CNM','','Anna','Lisa','Burdette','','APRN CNM','5','ANNA','32'},
{'112','Deanna J. Smith, APRN-CNP','','Deanna','J.','Smith','','APRN-CNP','5','DEANNA','31'},
{'113','Sen Wu, DMD','','Sen','','Wu','','DMD','2','SEN','22'},
{'114','Di Zhao, MD','','','','Di Zhao','','MD','3','','0'},
{'115','Haicam Marie Therese Yan','','Haicam','Marie','Therese Yan','','','0','Haicam','37'},
{'116','Marino J. Alea Iglesias','','Marino','J. Alea','Iglesias','','','3','J.','0'},
{'117','Syed Ismail M. Thiwan','','Syed','Ismail M.','Thiwan','','','1','ISMAIL','0'},
{'118','James D.k. Park','','James','D.k.','Park','','','1','JAMES','14'},
{'119','Sat Siri Kaur Khalsa','','Sat','Siri','Kaur Khalsa','','','0','Sat','41'},
{'120','Jo Anne Marie Neiner','','Jo','Anne','Marie Neiner','','','5','JOSEPHINE','42'},
{'121','Michael E. Sherr, PHD','','Michael','E.','Sherr','','PHD','1','MICHAEL','30'},
{'122','Dr. Albert Yun-Szu Yeh','Dr.','Albert','Yun-Szu','Yeh','','','1','ALBERT','29'},
{'123','Dr. Yun Szu Yeh','Dr.','Yun','Szu','Yeh','','','3','YUN','29'},
{'124','Dr. Elaine Yee','Dr.','Elaine','','Yee','','','5','ELAINE','24'},
{'125','Dr. Betty H. Yao','Dr.','Betty','H.','Yao','','','5','ELIZABETH','29'},
{'126','Yun Szu Yeh','','Yun','Szu','Yeh','','','3','YUN','29'},
{'127','Elaine Yee, MD','','Elaine','','Yee','','MD','5','ELAINE','24'},
{'128','Betty H. Yao, MD','','Betty','H.','Yao','','MD','5','ELIZABETH','29'},
{'129','Wenwei Wu, MD','','Wenwei','','Wu','','MD','5','WENWEI','24'},
{'130','Dr. Lisa Yao','Dr.','Lisa','','Yao','','','5','ELIZABETH','22'},
{'131','Dr. Albert Yeh','Dr.','Albert','','Yeh','','','1','ALBERT','24'},
{'132','Dr. Yun-Szu Yeh','Dr.','Yun-Szu','','Yeh','','','0','Yun-Szu','21'},
{'133','Lisa Kwok-Yin Yao','','Lisa','Kwok-Yin','Yao','','','5','ELIZABETH','28'},
{'134','Albert Szu-Yun Yeh','','Albert','Szu-Yun','Yeh','','','1','ALBERT','29'},
{'135','Wenwei Wu','','Wenwei','','Wu','','','5','WENWEI','24'},
{'136','Betty Hong Yao','','Betty','Hong','Yao','','','5','ELIZABETH','29'},
{'137','Elaine May-Yin Yee','','Elaine','May-Yin','Yee','','','5','ELAINE','32'},
{'138','Burlin Harris Ackles III','','Burlin','Harris','Ackles','III','','1','BURLIN','29'},
{'139','David Evans Williams IV, MD','','David','Evans','Williams','IV','MD','1','DAVID','29'},
{'140','Martha Jenny Anja Van Duyne','','Martha','Jenny','Anja Van Duyne','','','5','MARTHA','42'},
{'141','Dr. Angelita Alonzo De La Cruz','Dr.','Angelita','Alonzo','De La Cruz','','','5','ANGELA','33'},
{'142','A. Pierre Bamdad Fscai, MD FACC','','A.','Pierre Bamdad','Fscai','','MD FACC','3','A.','24'},
{'143','Violeta Tammy De La Melena, MD','','Violeta','Tammy','De La Melena','','MD','5','VIOLETA','33'},
{'144','Dr. J. Eugene McMurry Jr., MD','Dr.','J.','Eugene','McMurry','Jr.','MD','3','J.','31'},
{'145','Shimona R. Bhatia, DO MPH','','Shimona','R.','Bhatia','','DO MPH','0','Shimona','28'},
{'146','G. Matt Howard III, DC','','G.','Matt','Howard','III','DC','3','G.','28'},
{'147','Miss Miss Geraldine May Herrero Ugaddan','Miss','Miss','Geraldine May','Herrero Ugaddan','','','5','GERALDINE','0'},
{'1001','Svend Egenes Abrahamsen, DPM','','Svend','Egenes','Abrahamsen','','DPM','1','SVEND','29'},
{'1002','Daniel Fisher Abram','','Daniel','Fisher','Abram','','','1','DANIEL','26'},
{'1003','Irving Abrams','','Irving','','Abrams','','','1','IRVIN','24'},
{'1004','Hussain Abrar','','Hussain','','Abrar','','','1','HUSSAIN','17'},
{'1005','Judy Abreu-Boswell','','Judy','','Abreu-Boswell','','','5','JUDITH','24'},
{'1006','Olga Abuseridze','','Olga','','Abuseridze','','','5','OLGA','23'},
{'1007','Victor Abuseridze','','Victor','','Abuseridze','','','1','VICTOR','23'},
{'1008','Vincent Accardi','','Vincent','','Accardi','','','1','VINCENT','24'},
{'1009','Elizabeth Acevedo','','Elizabeth','','Acevedo','','','5','ELIZABETH','24'},
{'1010','Nelson Acevedo','','Nelson','','Acevedo','','','1','NELSON','20'},
{'1011','Gloria Chioumga Achara','','Gloria','Chioumga','Achara','','','5','GLORIA','26'},
{'1012','C. Ackerley Miranda','','C.','','Ackerley Miranda','','','3','C.','34'},
{'1013','Norman M. Ackerman, MD','','Norman','M.','Ackerman','','MD','1','NORMAN','31'},
{'1014','Joseph Ackman','','Joseph','','Ackman','','','1','JOSEPH','24'},
{'1015','Marcello Acosta','','Marcello','','Acosta','','','1','MARCELLO','23'},
{'1016','Mary J. Adam','','Mary','J.','Adam','','','5','MARY','27'},
{'1017','Beverly Jean Shackelford Adams, MD','','Beverly','Jean Shackelford','Adams','','MD','5','BEVERLY','28'},
{'1018','Cynthia Adams','','Cynthia','','Adams','','','5','CYNTHIA','24'},
{'1019','Richard N. Adams Jr, DO','','Richard','N.','Adams','Jr','DO','1','RICHARD','31'},
{'1020','Roberta Adams','','Roberta','','Adams','','','5','ROBERTA','24'},
{'1021','Michelle Adams-Embrack','','Michelle','','Adams-Embrack','','','5','MICHELLE','24'},
{'1022','Robert Adasek','','Robert','','Adasek','','','1','ROBERT','24'},
{'1023','Charles Addo-Yobo','','Charles','','Addo-Yobo','','','1','CHARLES','24'},
{'1024','Albert Ades, MD','','Albert','','Ades','','MD','1','ALBERT','24'},
{'1025','Andrew G. Adler, PHD','','Andrew','G.','Adler','','PHD','1','ANDREW','31'},
{'1026','M. Stuart Adler, MD','','M.','Stuart','Adler','','MD','3','M.','31'},
{'1027','Stephen C. Adler','','Stephen','C.','Adler','','','1','STEVEN','31'},
{'1028','Naveed Ahmad, MD','','Naveed','','Ahmad','','MD','1','NAVEED','22'},
{'1029','Rauf Ahmad','','Rauf','','Ahmad','','','1','RAUF','21'},
{'1030','Emad Ali Ahmed','','Emad','Ali','Ahmed','','','1','EMAD','29'},
{'1031','Halima Ahmed, P.C.','','Halima','','Ahmed','','P.C.','5','HALIMA','22'},
{'1032','A-k-a Mirza Ahmed Ahmed Mirza','','A-k-a','Mirza Ahmed','Ahmed Mirza','','','2','MIRZA','23'},
{'1033','Mohammed Hassan Ahmed','','Mohammed','Hassan','Ahmed','','','1','MOHAMMAD','29'},
{'1034','Muhammad K. Ahmed, MD','','Muhammad','K.','Ahmed','','MD','1','MOHAMMAD','27'},
{'1035','Syed Imran Ahmed, MD','','Syed','Imran','Ahmed','','MD','1','SYED','31'},
{'1036','Angelo Michael Aiello','','Angelo','Michael','Aiello','','','1','ANGELO','33'},
{'1037','Mohammed Aiti, MD','','Mohammed','','Aiti','','MD','1','MOHAMMAD','22'},
{'1038','Peter Joseph Ajemian, PC MD','','Peter','Joseph','Ajemian','','PC MD','1','PETER','33'},
{'1039','Jack K. Wilson Jr, MD','','Jack','K.','Wilson','Jr','MD','1','JACK','100'},
{'1040','Carol A. Akerman','','Carol','A.','Akerman','','','5','CAROLYN','100'},
{'1041','Neil S. Arnet','','Neil','S.','Arnet','','','1','NEIL','100'},
{'1042','Vicente D. Alcaraz-Micheli','','Vicente','D.','Alcaraz-Micheli','','','1','VINCENT','100'},
{'1043','William J. W. Au','','William','J. W.','Au','','','1','WILLIAM','100'},
{'1044','Hagop L. Der Krikorian, MD PC','','Hagop','L.','Der Krikorian','','MD PC','1','HAGOP','100'},
{'1045','Hans Johannes Anderson','','Hans','Johannes','Anderson','','','1','HANS','100'},
{'1046','Victor A. M. Berdecia-Rodriguez','','Victor','A. M.','Berdecia-Rodriguez','','','1','VICTOR','100'},
{'1047','Paul W. Andrus','','Paul','W.','Andrus','','','1','PAUL','100'},
{'1048','Eric Paul Bachelor, MD F.A.C.S.','','Eric','Paul','Bachelor','','MD F.A.C.S.','1','ERIC','100'},
{'1049','Federico L. Ampil','','Federico','L.','Ampil','','','1','FREDERICK','100'},
{'1050','Irving Victor, MD','','Irving','','Victor','','MD','1','IRVIN','100'},
{'1051','Gordon Kinsella Ahlers, MD','','Gordon','Kinsella','Ahlers','','MD','1','GORDON','100'},
{'1052','Kenneth J. S. De Simone, MD','','Kenneth','J. S.','De Simone','','MD','1','KENNETH','100'},
{'1053','Timothy S. Arnett, DDS','','Timothy','S.','Arnett','','DDS','1','TIMOTHY','100'},
{'1054','Joseph W. Burke III, DO','','Joseph','W.','Burke','III','DO','1','JOSEPH','100'},
{'1055','Ernestina Theresa Agresti','','Ernestina','Theresa','Agresti','','','5','ERNESTINE','100'},
{'1056','Robert Paul Abend, MD','','Robert','Paul','Abend','','MD','1','ROBERT','100'},
{'1057','Nilda Burgos-Declet, MD','','Nilda','','Burgos-Declet','','MD','5','NILDA','100'},
{'1058','Arthur M. Inc. Dumke Jr, DO','','Arthur','M. Inc.','Dumke','Jr','DO','1','ARTHUR','100'},
{'1059','George V. Deland III, MD','','George','V.','Deland','III','MD','1','GEORGE','100'},
{'1060','Andre A. D\'Hemecourt, MD','','Andre','A.','D\'Hemecourt','','MD','1','ANDREAS','100'},
{'1061','Donald A. Drake II, DDS MSD','','Donald','A.','Drake','II','DDS MSD','1','DONALD','100'},
{'1062','Harlan C. Amstutz, MD','','Harlan','C.','Amstutz','','MD','1','HARLAN','100'},
{'1063','Robert S. Amonic, MD','','Robert','S.','Amonic','','MD','1','ROBERT','100'},
{'1064','Jeffrey Alan Applebaum','','Jeffrey','Alan','Applebaum','','','1','JEFFREY','100'},
{'1065','Steven Leonard Abrams, MD','','Steven','Leonard','Abrams','','MD','1','STEVEN','100'},
{'1066','Frederick Alexander M. Augusta','','Frederick','Alexander M','Augusta','','','1','FREDERICK','100'},
{'1067','Robert L. Amstadter, MD','','Robert','L.','Amstadter','','MD','1','ROBERT','100'},
{'1068','Kathleen A. Cahoon, DO','','Kathleen','A.','Cahoon','','DO','5','CATHERINE','100'},
{'1069','Carol L. Meldman, DO','','Carol','L.','Meldman','','DO','5','CAROLYN','100'},
{'1070','Itamar B. Abrass, MD','','Itamar','B.','Abrass','','MD','1','ITAMAR','100'},
{'1071','Kenneth Jay Arenson, MD','','Kenneth','Jay','Arenson','','MD','1','KENNETH','100'},
{'1072','A. E. Amorteguy, MD','','A.','E.','Amorteguy','','MD','3','A.','100'},
{'1073','Merle Arden Anderson, DDS','','Merle','Arden','Anderson','','DDS','3','MERLE','100'},
{'1074','John W. Applegate, MD','','John','W.','Applegate','','MD','1','JOHN','100'},
{'1075','Anthony Hersch Alter','','Anthony','Hersch','Alter','','','1','ANTHONY','100'},
{'1076','Stanley M. Abramow','','Stanley','M.','Abramow','','','1','STANLEY','100'},
{'1077','Waleed Shareef Al-Fadly, MD','','Waleed','Shareef','Al-Fadly','','MD','1','WALEED','100'},
{'1078','Walter Burke Anderson, MD','','Walter','Burke','Anderson','','MD','1','WALTER','100'},
{'1079','Dennis K. Anderson, MD','','Dennis','K.','Anderson','','MD','1','DENNIS','100'},
{'1080','Michael Charles Appleton, MD','','Michael','Charles','Appleton','','MD','1','MICHAEL','100'},
{'1081','John Thomas Alexander, MD','','John','Thomas','Alexander','','MD','1','JOHN','100'},
{'1082','James H. Aldrich, MD','','James','H.','Aldrich','','MD','1','JAMES','100'},
{'1083','George E. Argoud, MD','','George','E.','Argoud','','MD','1','GEORGE','100'},
{'1084','Gregory S. Aposperis, DPM','','Gregory','S.','Aposperis','','DPM','1','GREGORY','100'},
{'1085','Constante U. Abaya, MD','','Constante','U.','Abaya','','MD','1','CONSTANTE','100'},
{'1086','Robert Peter Gale, MD','','Robert','Peter','Gale','','MD','1','ROBERT','100'},
{'1087','Seymour L. Alban, MD','','Seymour','L.','Alban','','MD','1','SEYMOUR','100'},
{'1088','Kermit Adkins, DDS','','Kermit','','Adkins','','DDS','1','KERMIT','100'},
{'1089','William R. Adkins, MD','','William','R.','Adkins','','MD','1','WILLIAM','100'},
{'1090','Abraham K. Asseff, DDS','','Abraham','K.','Asseff','','DDS','1','ABRAHAM','100'},
{'1091','Robert E. Ashmore, DDS','','Robert','E.','Ashmore','','DDS','1','ROBERT','100'},
{'1092','Richard M. Arnold, DDS','','Richard','M.','Arnold','','DDS','1','RICHARD','100'},
{'1093','John R. Arnold, MD','','John','R.','Arnold','','MD','1','JOHN','100'},
{'1094','Joseph A. Arena, MD','','Joseph','A.','Arena','','MD','1','JOSEPH','100'},
{'1095','Matthew W. Allen IV, DDS PA','','Matthew','W.','Allen','IV','DDS PA','1','MATTHEW','100'},
{'1096','Douglas R. Anderson, MD','','Douglas','R.','Anderson','','MD','1','DOUGLAS','100'},
{'1097','Herman Allen, DDS','','Herman','','Allen','','DDS','1','HERMAN','100'},
{'1098','Ronald J. Amalong, MD','','Ronald','J.','Amalong','','MD','1','RONALD','100'},
{'1099','Martin E. Amundson, MD','','Martin','E.','Amundson','','MD','1','MARTIN','100'},
{'1100','Richard M. Anderson, MD','','Richard','M.','Anderson','','MD','1','RICHARD','100'},
{'1101','David M. Adelman, DDS PA','','David','M.','Adelman','','DDS PA','1','DAVID','100'},
{'1102','T. A. Aliapoulios, DDS','','T.','A.','Aliapoulios','','DDS','3','T.','100'},
{'1103','Edward A. Amley, DDS','','Edward','A.','Amley','','DDS','1','EDWARD','100'},
{'1104','Arthur Angelo Mauceri, MD','','Arthur','Angelo','Mauceri','','MD','1','ARTHUR','100'},
{'1105','Roy Davis Altman, MD','','Roy','Davis','Altman','','MD','1','ROY','100'},
{'1106','Hubert Alan Aronson, MD','','Hubert','Alan','Aronson','','MD','1','HERBERT','100'},
{'1107','Claborn J. Adkins Jr, DDS','','Claborn','J.','Adkins','Jr','DDS','1','CLABORN','100'},
{'1108','Allan J. Adeeb, MD','','Allan','J.','Adeeb','','MD','1','ALAN','100'},
{'1109','Herbert H. Applebaum, MD','','Herbert','H.','Applebaum','','MD','1','HERBERT','100'},
{'1110','Joseph J. Angella, MD','','Joseph','J.','Angella','','MD','1','JOSEPH','100'},
{'1111','Shafaat Ahmed, MD','','Shafaat','','Ahmed','','MD','0','SHAFAAT','100'},
{'1112','Donald Lewis Ames, MD','','Donald','Lewis','Ames','','MD','1','DONALD','100'},
{'1113','Orlando A. Arana, MD','','Orlando','A.','Arana','','MD','1','ORLANDO','100'},
{'1114','Ildiko Soltesz Agha, MD','','Ildiko','Soltesz','Agha','','MD','5','ILDIKO','100'},
{'1115','Philip Howard Andersen, MD','','Philip','Howard','Andersen','','MD','1','PHILLIP','100'},
{'1116','Juan Fernando Aleman, MD','','Juan','Fernando','Aleman','','MD','1','JOHN','100'},
{'1117','Earl W. Ah Moo, DDS','','Earl','W.','Ah Moo','','DDS','1','EARL','100'},
{'1118','Lorene Inc Anastasi, MD','','Lorene','Inc','Anastasi','','MD','5','LAURA','100'},
{'1119','Kelly D. Alexander Jr, DDS','','Kelly','D.','Alexander','Jr','DDS','3','KELLY','100'},
{'1120','John G. Alexander, MD','','John','G.','Alexander','','MD','1','JOHN','100'},
{'1121','Audie Macon Adams, MD','','Audie','Macon','Adams','','MD','2','AUDREY','100'},
{'1122','Larry B. Aycock, MD','','Larry','B.','Aycock','','MD','1','LAURENCE','100'},
{'1123','William K. Austin, MD','','William','K.','Austin','','MD','1','WILLIAM','100'},
{'1124','Ww Anderson, DDS','','Ww','','Anderson','','DDS','0','WW','100'},
{'1125','Evan L. Allred','','Evan','L.','Allred','','','1','EVAN','100'},
{'1126','Lloyd B. Austin, DDS','','Lloyd','B.','Austin','','DDS','1','LLOYD','100'},
{'1127','Marsden Ronald Avery Jr, MD','','Marsden','Ronald','Avery','Jr','MD','2','MARSDEN','100'},
{'1128','Joost Henri Van Adelsberg, MD','','Joost','Henri','Van Adelsberg','','MD','1','JOOST','100'},
{'1129','Kenneth W. Albertson, MD','','Kenneth','W.','Albertson','','MD','1','KENNETH','100'},
{'1130','Derek Ronald Allen, MD','','Derek','Ronald','Allen','','MD','1','DEREK','100'},
{'1131','Richard Earle Adams, MD','','Richard','Earle','Adams','','MD','1','RICHARD','100'},
{'1132','Peter George Alexakis, MD','','Peter','George','Alexakis','','MD','1','PETER','100'},
{'1133','Horacio F. Ariza, MD','','Horacio','F.','Ariza','','MD','1','HORACE','100'},
{'1134','Stephan Ariyan','','Stephan','','Ariyan','','','1','STEVEN','100'},
{'1135','David Jay Astrachan, DDS','','David','Jay','Astrachan','','DDS','1','DAVID','100'},
{'1136','James Edward Allison','','James','Edward','Allison','','','1','JAMES','100'},
{'1137','James C. Arthur, DDS','','James','C.','Arthur','','DDS','1','JAMES','100'},
{'1138','Jerry P. Andes, MD','','Jerry','P.','Andes','','MD','1','JEROME','100'}],myInput);

rec_in := Healthcare_Cleaners.Layouts.rawNameInput;
ds := project(ds_batch,transform(rec_in, 
																// self.isLFM :=if((integer)left.acctno>1000,true,false);
																self := left));
output(ds,all,named('RawInputFormat'));

rawCln :=project(ds,transform(Healthcare_Cleaners.Layouts.cleanNameOutput,
															cln:=Healthcare_Cleaners.Functions.doNameClean(left);
															self := cln[1];));
output(rawCln,all,named('FormattedOutput'));
myOutput := record
	string20	 	acctno := '';
	String100 	nameFull := '';
	string10		EnclarityPrefix := '';
	string10		LNPrefix := '';
	string50		EnclarityFirst := '';
	string50		LNFirst := '';
	string50		EnclarityMiddle := '';
	string50		LNMiddle := '';
	string50		EnclarityLast := '';
	string50		LNLast := '';
	string10		EnclaritySuffix := '';
	string10		LNSuffix := '';
	string15		EnclarityProfessionalSuffix := '';
	string15		LNProfessionalSuffix := '';
	string5			EnclarityGender := '';
	string5			LNGender := '';
	string15		EnclarityPreferred := '';
	string15		LNPreferred := '';
	string15		EnclarityConfidence := '';
	string15		LNConfidence := '';
	boolean			MatchPrefix := false;
	boolean			MatchFirst := false;
	boolean			MatchMiddle := false;
	boolean			MatchLast := false;
	boolean			MatchSuffix := false;
	boolean			MatchProfessionalSuffix := false;
	boolean			MatchGender := false;
	boolean			MatchPreferred := false;
	boolean			MatchConfidence := false;
end;

results := join(ds_batch,rawCln,left.acctno=right.acctno,transform(myOutput, 
													self.LNPrefix := right.name_prefix;
													self.LNFirst := right.fname;
													self.LNMiddle := right.mname;
													self.LNLast := right.lname;
													self.LNSuffix := right.name_suffix;
													self.LNProfessionalSuffix := right.name_prof;
													self.LNGender := right.name_gender;
													self.LNPreferred := right.name_prefered;
													self.LNConfidence := right.name_score;
													self.MatchPrefix := trim(left.EnclarityPrefix,left,right) = trim(right.name_prefix,left,right);
													self.MatchFirst := trim(left.EnclarityFirst,left,right) = trim(right.fname,left,right);
													self.MatchMiddle := trim(left.EnclarityMiddle,left,right) = trim(right.mname,left,right);
													self.MatchLast := trim(left.EnclarityLast,left,right) = trim(right.lname,left,right);
													self.MatchSuffix := trim(left.EnclaritySuffix,left,right) = trim(right.name_suffix,left,right);
													self.MatchProfessionalSuffix := trim(left.EnclarityProfessionalSuffix,left,right) = trim(right.name_prof,left,right);
													self.MatchGender := trim(left.EnclarityGender,left,right) = trim(right.name_gender,left,right);
													self.MatchPreferred := trim(left.EnclarityPreferred,left,right) = trim(right.name_prefered,left,right);
													self.MatchConfidence := trim(left.EnclarityConfidence,left,right) = trim(right.name_score,left,right);
													self := left));
output(results,all,named('StatisticsOutputFormat'));
output(results(MatchPrefix=false),all,named('PrefixProblems'));
output(results(MatchFirst=false),all,named('FirstNameProblems'));
output(results(MatchMiddle=false),all,named('MiddleNameProblems'));
output(results(MatchLast=false),all,named('LastNameProblems'));
output(results(MatchSuffix=false),all,named('SuffixProblems'));
output(results(MatchProfessionalSuffix=false),all,named('ProfSuffixProblems'));
output(results(MatchGender=false),all,named('GenderProblems'));