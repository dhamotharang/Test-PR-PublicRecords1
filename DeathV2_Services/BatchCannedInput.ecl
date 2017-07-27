import DeathV2_Services;

_canned_layout := RECORD
	// Layouts.BatchIn.acctno;
		STRING20  acctno        := '';
		STRING20  name_last     := '';
		STRING100 addr          := '';
		STRING5   z5      		  := '';
		STRING25  p_city_name		:= '';
		STRING2   st          	:= '';		
		STRING120 comp_name     := '';
		STRING20  name_first    := '';
		STRING14  filing_number := '';
		STRING72  sic_code      := '';		
		STRING9   fein          := '';
		STRING9   ssn           := '';
		// UNSIGNED8 DOB           :=  0;
		STRING8 	DOB           :=  '';
		STRING20  name_middle   := '';
		UNSIGNED6 did			:= 	0;
		UNSIGNED6 bdid			:= 	0;
		UNSIGNED3 score_did		:= 	0;
		UNSIGNED3 score_bdid	:= 	0;
	END;

_canned_recs := 
			DATASET([
			/*{'_acct_tst00','','','','','','','','', '', '', '', 0}, 
			{'_acct_tst01','','','','','','','','','', '', '284013432', 0},
			{'_acct_tst02','','','','','','','','','', '', '', 19171024},
			{'_acct_tst03','','','','','','','','','', '', '284013432', 19171024},
			{'_acct_tst04','','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','','', '', '', '', 0},
			{'_acct_tst05','','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','','', '', '', '284013432', 0},
			{'_acct_tst06','','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','','', '', '', '',19171024},
			{'_acct_tst07','','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','','', '', '', '284013432',19171024},
			{'_acct_tst08','STEPHENSON','','','','','','ESTHER','', '', '', '', 0}, 
			{'_acct_tst09','STEPHENSON','','','','','','ESTHER','', '', '', '284013432', 0},
			{'_acct_tst10','STEPHENSON','','','','','','ESTHER','', '', '', '', 19171024},
			{'_acct_tst11','STEPHENSON','','','','','','ESTHER','', '', '', '284013432', 19171024},
			{'_acct_tst12','STEPHENSON','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','ESTHER','', '', '', '', 0},
			{'_acct_tst13','STEPHENSON','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','ESTHER','', '', '', '284013432', 0},
			{'_acct_tst14','STEPHENSON','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','ESTHER','', '', '', '',19171024},
			{'_acct_tst15','STEPHENSON','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','ESTHER','', '', '', '284013432',19171024},			
			
			{'_acct_tst17','','','','','','','','','', '', '284013232', 0},
			{'_acct_tst19','','','','','','','','','', '', '284013232', 19171024},
			{'_acct_tst21','','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','','', '', '', '284013232', 0},
			{'_acct_tst23','','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','','', '', '', '284013232',19171024},*/
			// {'_acct_tst25','STEPHENSON','','','','','','ESTHER','', '', '', '284013232', 0},
			// {'_acct_tst27','STEPHENSON','','','','','','ESTHER','', '', '', '284013232', 19171024},
			// {'_acct_tst29','STEPHENSON','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','ESTHER','', '', '', '284013232', 0},			
			// {'_acct_tst31','STEPHENSON','2541 CANTERBURY DRIVE','32763','RIVIERA BEACH','FL','','ESTHER','', '', '', '284013232',19171024},
			/*{'_acct_smith', 'SMITH', '', '', '', 'CA', '', 'JIM', '', '', '', '', 0}, 
			// {'_acct_jones', 'JONES', '', '', '', 'MN', '', 'JOHN', '', '', '', '', 0},*/
			// {'_acct_did1_snc',  'JONES', '', '', 'SAINT PAUL', 'MN', '', 'JOHN', '', '', '', '477603388', 0, '', 001277340228},
			// {'_acct_did1_nc',  'JONES', '', '', 'SAINT PAUL', 'MN', '', 'JOHN', '', '', '', '', 0, '', 001277340228},
			// {'_acct_did1_n',  'JONES', '', '', 'SAINT PAUL', '', '', 'JOHN', '', '', '', '', 0, '', 001277340228},
			// {'_acct_did1_c',  '', '', '', 'SAINT PAUL', 'MN', '', '', '', '', '', '', 0, '', 001277340228},
			// {'_acct_did1_sc',  '', '', '', 'SAINT PAUL', 'MN', '', '', '', '', '', '477603388', 0, '', 001277340228},			
			// {'_acct_did2',  ''     , '', '', '', '',   '', '',     '', '', '', '', 0, '', 001632467548},
			// {'_acct_did3',  ''     , '', '', '', '',   '', '',     '', '', '', '', 0, '', 000070632365},
			// {'_acct_did4',  ''     , '', '', '', '',   '', '',     '', '', '', '', 0, '', 0},
			
			/* extra address tests */
			// {'_acct_0', '', '', '', '', '', '', '', '', '', '', '587905404', 0},
			// {'_acct_1', 'RUSH', '1009 SHADYSIDE LN APT C', '75223', 'DALLAS', 'TX', '', 'HERMAN', '', '', '', '587905404', 0},
			// {'_acct_2', 'RUSH', '', '', '', '', '', 'HERMAN', '', '', '', '587905404', 0},
			// {'_acct_3', 'RUSH', '3921 SHERATON DR', '75227', 'DALLAS', 'TX', '', 'HERMAN', '', '', '', '587905404', 0},
			// {'77211950', 'WILLIAMSON', 'PO BOX 39', '36919', 'SILAS', 'AL', '', 'PINKIE', '', '', '', '587962220', 0},
			/*{'77211953', 'CLAYTON', '316 COUNTY ROAD 463', '39212', 'JACKSON', 'MS', '', 'JERRY', '', '', '', '587962951', 0},
			{'77211953b', 'CLAYTON', '', '', '', '', '', 'JERRY', '', '', '', '587962951', 0},
			{'77211955', 'TATUM', '2167 SOUTH 481', '39117', 'MORTON', 'MS', '', 'ROBERT', '', '', '', '587982449', 0},
			{'77211955b', 'TATUM', '', '', '', '', '', 'ROBERT', '', '', '', '587982449', 0},
			{'77211968', 'KAMIHIRA', '1102 WATERVIEW DR', '33461', 'PALM SPRINGS', 'FL', '', 'AUDREY', '', '', '', '589129955', 0},
			{'77211969', 'KAMIHIRA', '898 WORCESTER LN', '33467', 'LAKE WORTH', 'FL', '', 'AUDREY', '', '', '', '589129955', 0},
			{'77211971', 'FLEMISTER', '1805 WINDERMERE RD', '34787', 'GARDEN', 'FL', '', 'COELA', '', '', '', '589181703', 0},
			{'77211973', 'WITHERELL', '', '', '', '', '', 'ANDREW', '', '', '', '589219784', 0},
			{'77211974', 'PIKE', '', '31520', '', 'GA', '', 'MARIA', '', '', '', '589237241', 0},
			{'77212196', 'SILVA', '', '00687', '', 'PR', '', 'LUCRECIA', '', '', '', '597096110', 0},
			{'77212197', 'GONZALEZ', '', '32738', '', 'FL', '', 'OMAR', '', '', '', '597146470', 0},
			{'77212198', 'VASQUEZ', '', '06790', '', 'CT', '', '', '', '', '', '597449894', 0},
			{'77212199', 'REYES', '', '00659', '', 'PR', '', 'JUANITA', '', '', '', '598039455', 0},
			{'77212200', 'CRUZ', '', '00717', '', 'PR', '', 'ERASTO', '', '', '', '598161420', 0},
			{'77212600', 'NORRIS', 'PO BOX 222', '97022', 'EAGLE CREEK', 'OR', '', 'CLAIR', '', '', '', '700056437', 0},
			{'77212602', 'RITZAU', '1136 OXFORD RD', '94010', 'BURLINGAME', 'CA', '', 'VIOLA', '', '', '', '700123565', 0},
			{'77212603', 'RITZAU', '119 BURTON DR', '95065', 'SANTA CRUZ', 'CA', '', 'VIOLA', '', '', '', '700123565', 0},
			
			{'1166533', 'THOMPSON', '3538 RUTH DR', '891213220', 'LAS VEGAS', 'NV', '', 'JEAN', '', '', '', '564483435', 0},
			{'1166540', 'DURDEN', '2820 S DECATUR BLVD APT 9', '891025548', 'LAS VEGAS', 'NV', '', 'BYRON', '', '', '', '563241096', 0},	
			{'1166558', 'GROSSMAN', 'CMKR IS DECEASED', 'NC', ' VERY BY VERY ', 'CH', '', 'RUTH', '', '', '', '151180386', 0},
			{'269282', 'NETTLES', '217 COLUMBIA AVENUE', '', '', 'NJ', '', 'JOHN', '', '', '', '116340249', 0}
			*/
			/*
			{'1166533_a', 'GREGORY', '', '', '', 'AL', '', 'JANE', '', '', '', '', 0, '', 0},
			{'1166533_b', 'GREGORY', '', '', '', 'OR', '', 'JANE', '', '', '', '', 0, '', 0},
			{'1166533_c', 'GREGORY', '', '', '', 'OR', '', 'JANE', '', '', '', '124285176', 0, '', 0},
			{'1166533_d', 'GREGORY', '', '', '', 'OR', '', 'JANE', '', '', '', '124285176', 0, '', 000996114669},
			{'1166533_e', 'GREGORY', '', '55045', '', 'OR', '', 'JANE', '', '', '', '124285176', 0, '', 000996114669},
			{'1166533_f', 'GREGORY', 'FOOBAR ST', '55045', '', 'OR', '', 'JANE', '', '', '', '124285176', 0, '', 000996114669}
			*/
			// {'4030359', 'Winters', '', '', '', '', '', 'Chris', '', '', '', '456430465', 0, '', '002747835663'},
			{'100', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '554521162', '', '', 001960713480,0},
			{'200', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '', '', '', 001960713480,0,0,100},
			{'300', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '', '', '', 001960713480,0,0,50},
			{'400', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '', '', '', 001960713480,0,0,100},
			{'500', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '', '', '', 001960713480,0,0,50},
			{'600', 'KYLE', '', '', '', '', '', 'MARTHA', '', '', '', '410984106', '', '', 001437941820},
			{'700', 'KYLE', '', '', '', '', '', 'MARTHA', '', '', '', '410984106', '', '', 001437941820},
			{'800', 'KYLE', '', '', '', '', '', 'MARTHA', '', '', '', '410984106', '', '', 001437941820},
			{'900', 'CRAWFORD','7942 E SABINO SUNRISE CIR','85750','TUCSON','AZ','','BEVERLY','','','','519209136','','J',000532862035,0,100,0} 

			// {'774269ssn', '', '', '', '', '', '', '', '', '', '', '554521162', 0, ''},
			// {'775016ssn', '', '', '', '', '', '', '', '', '', '', '410984106', 0, ''}
			], _canned_layout);

EXPORT BatchCannedInput := project(_canned_recs, DeathV2_Services.Layouts.BatchIn);				

