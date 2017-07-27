// NOTE:  If you add a new MODULE to this attribute, as a courtsey to others, 
// NOTE:  If you add a new MODULE to this attribute, as a courtsey to others, 
// please add it in alphabetic order by product name, i.e. AKA, Bankruptcy, 
// Business, etc.; leaving the default ds_default_sample_input at the front/top.

/* For reference, the sample batch records input test data layout,
   BatchServices._Sample_layout_input_raw:
  EXPORT _Sample_layout_input_raw := RECORD
		STRING20  acctno        := '';
		STRING20  name_last     := '';
		STRING100 addr          := '';
		STRING10  zip           := '';
		STRING20  city          := '';
		STRING2   state         := '';
		STRING120 comp_name     := '';
		STRING20  name_first    := '';
		STRING14  filing_number := '';
		STRING8   sic_code      := '';
		STRING9   fein          := '';
		STRING9   ssn           := '';
		UNSIGNED8 DOB           :=  0;
		STRING20  name_middle   := '';
		UNSIGNED6 did			:= '';
		UNSIGNED6 bdid			:= 	0;
		UNSIGNED3 score_did		:= 	0;
		UNSIGNED3 score_bdid	:= 	0;
	END;
*/
	
EXPORT _Sample_Records := MODULE
	
	// Default set...:

	EXPORT ds_default_sample_input := DATASET([
		{'acct__EVANS_1','EVANS','2303 FLATROCK COURT','60564','NAPERVILLE','IL','','WILLIAM','','', 0},
		{'acct__EVANS_2','EVANS','4219 FALKNER DR','60564','NAPERVILLE','IL','','WILLIAM','','', 0},
		{'acct__WILSON_1','WILSON','5553 WOODSONG TRAIL','30338','DUNWOODY','GA','','DANIEL','','', 0},
		{'acct__SMITH_il','SMITH','','','','IL','','JOHN','','', 0}
		], BatchServices._Sample_layout_input_raw);

	EXPORT Address := MODULE
		EXPORT ds_sample_input :=dataset([
			 {'','ACKER','2214 EASTLAND','','FAIRBANKS','AK','','TONY','','','','568718816','',''}
			,{'','AADLAND','','','','','','TROY','','','','504849528','','SCOTT',000000014275}
			,{'','SPARANO',''            ,'',''         ,''  ,'','Peter','','','','078369079','19450723',''}
			,{'','AADLAND','','','','','','JACK','','','','504886895','','LEE',000000014256}
			,{'','BENNETT','939 23RD ST S','35205','BIRMINGHAM','AL','','Joseph','','','','416628251','',''}
			], BatchServices._Sample_layout_input_raw);
	END;


  // AKAs sample dataset
	EXPORT AKA := MODULE
	
		EXPORT ds_sample_input := DATASET([
	  //acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did
		{'acctno_bug40979','WRIGHT','313 BROOKE WOODE DR','45309','BROOKVILLE','OH','','DAVID','','','','',0,''},
		{'acctno_bug40981','Miller','21 Brush Dr','14075','Hamburg','NY','','Keith','','','','525027074',0,'L'},
		{'acctno_bug41003','Williams','3518 Nayland Rock','77066','Houston','TX','','Robert','','','','',0,'W'},
		{'acctno_bug41026','Balli','21885 Rose Heart Way #A','93908','Salinas','CA','','Corrine','','','','',0,'C'},
	  {'acctno_bug41025','Bruce','5021 S 20th ST','85040','Phoenix','AZ','','Ethel','','','','',0,'L'},
	  {'acctno_bug41048','Johnson','6316 NW 28TH CT','33063','Pomano Beach','FL','','Henry','','','','021240213',0,'b'},
	  {'acctno_bug41030','Francis','1669 E 1240 S','84660','Spanish Fork','UT','','Questin','','','','604362172',0,''}
			], BatchServices._Sample_layout_input_raw);
	END;

	EXPORT Bankruptcy := MODULE
	
		EXPORT ds_sample_input := DATASET([
			/*{'__AABERG','AABERG','','','','CA','','KIMBERLY','','', 0},
			{'__HAYGOOD','','','','','','HAYGOOD CLEVELAND PIERCE ','','','', 0},
			{'__ESPY','','','','','','ESPY METCALF PC','','','', 0}, 
			{'__SMITH', 'SMITH', '', '', '', 'CA', '', 'JOHN', '', '', 0},
			{'215_ssn', 'MATHES','','','','','','GENE','','','','306942002',0,''},
			{'215_nameonly', 'MATHES','','','','','','GENE','','','','',0,'R'},
			{'215_full', 'MATHES','4707COPENCT','462213201','INDIANAPOLIS','IN','','GENE','','','','306942002',0,'R'},
			{'215_noaddr', 'MATHES','','462213201','INDIANAPOLIS','IN','','GENE','','','','306942002',0,'R'},
			{'115', 'LUKKES','6969 W 90TH AVE APT 214','800216456','ANYTOWN','CO','','JODI','','','','504088024',0,'L'},
			{'_acct_did1',  ''     , '', '', '', '',   '', '',     '', '', '', '', 0, '', 001277340228},
			{'_acct_did2',  ''     , '', '', '', '',   '', '',     '', '', '', '', 0, '', 001632467548},
			{'_acct_did3',  ''     , '', '', '', '',   '', '',     '', '', '', '', 0, '', 000070632365},
			{'_acct_did2_nc',  'MATHES', '', '', 'INDIANAPOLIS', 'IN', '', 'GENE', '', '', '', '', 0, '', 001632467548},
			{'_acct_did2_sn',  'MATHES', '', '', '', '', '', 'GENE', '', '', '', '317644578', 0, '', 001632467548},
			{'194', 'GORDON','801 CHURCH ST','367014569','SELMA','AL','','MELVIN','','','','264869280',0,''},
			{'194_N', 'GORDON','','','','','','MELVIN','','','','',0,''},
			{'194_SN', 'GORDON','','','','','','MELVIN','','','','264869280',0,''},
			{'194_NC', 'GORDON','','','SELMA','AL','','MELVIN','','','','',0,''},
			{'194_NA', 'GORDON','801 CHURCH ST','367014569','SELMA','AL','','MELVIN','','','','',0,''},
			{'194_S', '','','','','','','','','','','264869280',0,''},
			*/
			/*
			{'196', 'JACKSON','2424 WYLIE AVE','152194530','PITTSBURGH','PA','','WILLIAM','','','','162288229',0,''},
			{'200', 'THOMAS','248678 TH AVE','191501825','PHILADELPHIA','PA','','CHRISTOPHER','','','','211486485',0,'T'},
			{'385', 'CARTER','794 NORMANDY ST APT 741','770153476','HOUSTON','TX','','ROBERT','','','','454513799',0,''},
			{'453', 'BROWN','PO BOX 673','922770673','TWENTYNINEPALMS','CA','','DAVID','','','','573354515',0,'A'},
			{'468', 'RODRIGUEZ','390 ROESCH AVE','142071341','BUFFALO','NY','','CARMEN','','','','141728082',0,''},
			{'558', 'GARCIA','50 E ROSEVILLE RD','176013863','LANCASTER','PA','','FELIX','','','','203687144',0,'M'},
			{'588', 'JONES','7527 LIMEKILN PIKE','191501803','PHILADELPHIA','PA','','TERRY','','','','203482901',0,''},
			{'600', 'HARRIS','1719 ONTARIO AVE','381278608','MEMPHIS','TN','','SHONN','','','','409252419',0,''},
			{'603', 'RIVAS','3205 GRAND CONCOURSE APT 4A','104681236','BRONX','NY','','JOSE','','','','132665569',0,''},
			{'631', 'GARCIA','7083 SGULL LN','857568718','TUCSON','AZ','','REBEKAH','','','','282885095',0,''},
			{'284', 'BROWN','1952 NDARIEN ST ','191222011','PHILADELPHIA','PA','','NAIMAH','','','','171580459',0,''},
			{'767', 'GUTIERREZ','5120 SFICKETT AVE ','857461102','TUCSON','AZ','','JOSEPH','','','','600780445',0,'B'},
			{'842', 'HARRIS','6702 SPARNELL AVE FL 2','606212540','CHICAGO','IL','','BRENDA','','','','351463071',0,'D'},
			{'844', 'HOLMES','9615 SWOODLAWN AVE','606281639','CHICAGO','IL','','JACKLYN','','','','353745135',0,'M'},
			{'855', 'DAVIS','8572 MEYERS RD','482284019','DETROIT','MI','','AARON','','','','363087076',0,'M'},
			*/
			
			{'1', 'MATHES','foobar ave','11111','foobar city','fb','','GENE','','','','317644578',0,'',0,0,0,0},
			{'1a', 'MATHES','foobar ave','11111','foobar city','fb','','GENE','','','','317644578',0,'',0,0,0,0},
			{'1b', 'MATHES','foobar ave','11111','foobar city','fb','','GENE','','','','317644578',0,'',0,0,0,0},
			{'1c', 'MATHES','foobar ave','11111','foobar city','fb','','GENE','','','','317644578',0,'',0,0,0,0},
			{'2', 'MATHES','foobar ave','11111','foobar city','fb','','GENE','','','','317644578',0,'',001632467548,0,100,0},
			{'3', 'MATHES','foobar ave','11111','foobar city','fb','','GENE','','','','317644578',0,'',001632467548,0,10,0},
			{'4', 'MATHES','foobar ave','11111','foobar city','fb','','GENE','','','','',0,'',001632467548,0,50,0},
			{'5', 'MATHES','foobar ave','11111','foobar city','fb','','GENE','','','','',0,'',001632467548,0,100,0},
			{'6', 'MATHES','foobar ave','11111','foobar city','fb','','GENE','','','','317644578',0,'',001632467548,0,0,0}
			
			/*
			{'acctno', 'name_last','addr','zip','city','state','comp_name','name_first','filing_number','sic_code','fein','ssn',DOB,'name_middle',DID,BDID,did_score,bdid_score,name_suffix} 
			*/
			], BatchServices._Sample_layout_input_raw);
	
	END;


  EXPORT Benefit_Assessment := MODULE
		EXPORT ds_sample_input :=dataset([
			 {'4','ACKER','2214 EASTLAND','','FAIRBANKS','AK','','TONY','','','','568718816','',''}
			,{'1','AADLAND','','','','','','TROY','','','','504849528','','SCOTT',000000014275}
			,{'3','SPARANO',''            ,'',''         ,''  ,'','Peter','','','','078369079','19450723',''}
			,{'2','AADLAND','','','','','','JACK','','','','504886895','','LEE',000000014256}
			,{'5','BENNETT','','','','MN','','Joseph','','','','416628251','',''}
			], BatchServices._Sample_layout_input_raw);
	END;	
	
	EXPORT BkReport := MODULE
		EXPORT ds_sample_input := DATASET([
		
		/*
			{'BKVA0030773049', false, '1a'},
			{'BKMN0030640288', false, '1b'},
			{'BKCA0010910564', false, 'att1'},
			{'BKAK0010100411', false, 'att2'},
			
			{'BKFL0010920906', false, 'cd1'}
    */
			{'BKFL0060917185', false, 'ct1'},
			{'BKOH0020955221', false, 'ct2'},
			{'BKCA0090961377', false, 'ct3'},
			{'BKFL0010827467', false, 'no_city_st'},
			{'BKAK0010000061', false, 'atty_suff'},
			{'BKAK0010000944', false, 'atty_suff2'}                                    

			/* case status tests */
			/*
			{'BKAK0010000001', false, 'cs_empty'},
			{'BKAK0010201136', false, 'cs_1'},
			{'BKAL0040907084', false, 'cs_2'},
			{'BKAL0050884125', false, 'cs_3'},
			{'BKAL0050585110', false, 'cs_4'},
			
			/*
			{'BKAK0010100411', false, '1'},
			{'BKAK0010101163', false, '2'},
			{'BKAK0010201416', false, '3'},
			{'BKNC0020731534', false,'4'},
			{'BKAR0080771765', false,'5'},
			{'BKOH0040016558', false,'6'},
			{'BKCA0030993161', false,'7'},
			{'BKCA0010961083', false,'8'},
			{'BKAK0010000061', false,'9'},
			{'BKAK0010000490', false,'10'}
			
			/*
			{'', false, 'cc1', '', 'AKA0', '0100411'},
			{'', false, 'cc2', '', 'AKA0', '0101163'},
			{'', false, 'cc3', '', 'AKA0', '0201416'},
			{'', false, 'cc4', '', 'NCW3', '0731534'},
			{'', false, 'cc5', '', 'ARWE', '0771765'},
			{'', false, 'cc6', '', 'OHSI', '0016558'},
			{'', false, 'cc7', '', 'CAE9', '0993161'},
			{'', false, 'cc8', '', 'CAEF', '0961083'},
			{'', false, 'cc9', '', 'AKA0', '0000061'},
			{'', false, 'cc10', '', 'AKA0', '0000490'},
			{'', false, 'excel1', '', 'MDAB', '0934006'},
			{'', false, 'excel2', '', 'KYE1', '0962002'},
			{'', false, 'excel3', '', 'FLM0', '0918833'},
			{'', false, 'excel4', '', 'CAB1', '1050216'},
			{'', false, 'excel5', '', 'CAB1', '1050675'},
			{'', false, 'excel6', '', 'FLM0', '1001289'},
			{'', false, 'excel7', '', 'FLM0', '1011613'},
			{'', false, 'excel8', '', 'NJAC', '1011602'},
			{'', false, 'excel9', '', 'NJAC', '1011609'},
			
			/* some more case/court tests */
			/*
			{'', false, 'cc11', '', 'MDAG', '0934006'},
			{'BKMD0020934006', false, 'cc11b'},
			
			/* empty trustee info and trusteeID = 9999*/
			/*
			{'BKIL0069251236', false, 'et1'},
			{'BKTX2121020027', false, 'et2'},
			{'BKCA0029452866', false, 'et3'},
			{'BKTX2088851913', false, 'et4'},
			
			/* Should return results if Use_FixCase is true */
			/*
			{'', false, '11', '', 'FLM8', '00080313'},
			{'', false, '12', '', 'FLM0', '0080318'},
			{'', false, '13', '', 'FLM0', '0080321'},
			{'', false, '14', '', 'FLM0', '9280095'},
			
			{'', false, '15', '', 'FLNC', '9820010'},
			{'', false, '16', '', 'FLNC', '9840280'},
			
			{'', false, '17', '', 'PAM0', '9050006'},
			{'', false, '18', '', 'PAM0', '9250125'},
			
			{'', false, '19', '', 'VAW5', '04551685'},
			{'', false, '20', '', 'VAW5', '04651699'},
			
			/* should return results if Use_FixCase is set to false or is not set to true*/
			/*
			{'', false, '21', '', 'FLM8', '0080313'},
			{'', false, '22', '', 'FLM0', '0000318'},
			{'', false, '23', '', 'FLM0', '0000321'},
			{'', false, '24', '', 'FLM0', '9200095'},
			
			{'', false, '25', '', 'FLNC', '9800010'},
			{'', false, '26', '', 'FLNC', '9800280'},
			
			{'', false, '27', '', 'PAM0', '9000006'},
			{'', false, '28', '', 'PAM0', '9200125'},
			
			{'', false, '29', '', 'VAW5', '0451685'},
			{'', false, '30', '', 'VAW5', '0451699'},
			
			/* case numbers shouldn't be fixed (but values returned) */
			/*
			{'', false, '31', '', 'FLM8', '0000313'},
			{'', false, '32', '', 'FLM8', '0010318'},
			{'', false, '33', '', 'FLM8', '0010321'},
			{'', false, '34', '', 'FLS3', '9230095'},
			
			{'', false, '35', '', 'FLM8', '9720010'},
			{'', false, '36', '', 'FLSM', '9740280'},
			
			{'', false, '37', '', 'PAM5', '0050006'},
			{'', false, '38', '', 'PAM5', '0250125'},
			
			{'', false, '39', '', 'WAWT', '0451685'},
			{'', false, '40', '', 'VAEE', '0451685'},
			
			/*
			{'BKCO0010913558 ', false, 'tst1', ''},
			{'BKAL0010731138 ', false, 'tst2', ''},
			{'BKWA0020603212', false, 'tst3', ''},
			{'BKPA0010436342 ', false, 'tst4', ''},
			{'BKUT0010241388 ', false, 'tst4', ''}, /* this record uses a court that has a fax number, which is rare */
			
			/* research for andi and shannon in 'questions.TXT' */
			/*
			{'BKNY0021070363', false, 'as1', ''}
			
			/* method_dismiss not empty */
			/*
			{'BKCA0040040989', false, 'mdY1', ''},
			{'BKCA0060016844', false, 'mdN1',''},
			{'BKCA0010011533', false, 'mdN2',''}
			
			/*
			{'BKNY0040512661 ', false, 'tstANDI1', ''},
			{'BKNY0020183711', false, 'tstANDI2', ''},
			{'BKAZ0010305731 ', false, 'tstANDI2', ''},
			{'BKIN0039764002 ', false, 'tst5', ''} /* this person has an associated phone number, which is rare */
			/*{'tmsid', isdeepdive, 'acctno', 'matchcode', 'court', 'case_number'}*/
			], BatchServices.layout_BkReport_Batch_in);

	END;
	
	EXPORT Business := MODULE
	
		EXPORT ds_sample_input := DATASET([
		  //acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did
			{'acct__DLM','','6177 FAR HILLS AVE','45459','DAYTON','OH','DOROTHY LANE MARKET','','','541105,549901,829924', 0},
			// WHY?{'acct__RSNBM','ROSENBALM','8177 KEISTER RD','45042','MIDDLETOWN','OH','','TERRY','','', 0},
			{'acct__TRIUNE','','','45431','BEAVERCREEK','OH','TRIUNE SOFTWARE, INC.','','','', 0},
			{'acct__MERKER','','317 S FINDLAY ST','45403','DAYTON','OH','MERKER ORNAMENTAL IRON','','','769204,344604,349620,503904', 0},
			{'acct__LN1','','9443 SPRINGBORO PIKE','45342','MIAMISBURG','OH','LEXISNEXIS'},
			//{'acct__FL_PTLR','','','','DAYTON','OH','FLOWER PETALER', 0}, // NO HITS!!
			// {'acct__JOBE1','','','11434','JAMAICA','NY','JOBE DEVELOPMENT CORP','','','655202', 0}
			{'acct__JOBE2','','','','','','JOBE DEVELOPMENT CORP'}
			], BatchServices._Sample_layout_input_raw);
	END; 

	EXPORT CompaniesForperson := MODULE
	
		EXPORT ds_sample_input := DATASET([
	  //acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did
	  {'acctno_1','Schreier','325 Brooke Woode Dr','45309','Brookville','OH','','Steven','','','','',0,'',0} // returns 4 recs
		//{'acctno_2','Gebhart','148 Timberwolf Way','45309','Brookville','OH','','Timothy','','','','',19640627,'',0} // returns 26 recs
		//{'acctno_3','Funk','1213 California St','98201','Everett','WA','','Allen','','','','',0,'',0} // returns 40 recs
		  ], BatchServices._Sample_layout_input_raw);
	END;

	EXPORT Corp2 := MODULE
	
		EXPORT ds_sample_input := DATASET([
			{'acct__HORA','HORA','','','','','','SCOTT','','', 0},
			{'acct__PECK','PECK','','','','','','JAMES','','', 0},
			{'acct__PECK','FOGLIA','','','','','','KENNETH','','', 0},
			{'acct__SINCLAIR','SINCLAIR','','','','','','JOHN','','', 0}			
			], BatchServices._Sample_layout_input_raw);	
		
	END;
	
	EXPORT Criminal := MODULE
	
		EXPORT ds_sample_input := DATASET([
			{'__FUSSELL_FN_LN','FUSSELL','','','','','','WETONA','','', 0},
			{'__FUSSELL_SSN','','','','','','','','','265611569', 0},
			{'__OPEL_FN_LN','OPEL','','','','','','ROGER','','', 0}
			], BatchServices._Sample_layout_input_raw);
	
	END;
	
	EXPORT DEA := MODULE
    EXPORT ds_sample_input := DATASET([
	    // acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did
      //    filing_number is dea_registration_number here.
      //{'_acct_JOHNSON','JOHNSON','REDDING, CA','','','','','DAVID'  ,'','','','',0},
      //{'_acct_JONES'  ,'JONES'  ,'SC'         ,'','','','','RICHARD','','','','',0},
      //{'_acct_JOHNSON_REG','','','','','','','','AJ4712813','','','',0}
			//{'_acct_Oppenheim'  ,'','','','','','','','BO8249270','','','',0},     
			//{'_acct_Speakman'   ,'','','','','','','','AS3266360','','','',0},     
			//{'_acct_Wedel'      ,'','','','','','','','BP7016404','','','',0},     
      //{'acct_WEDEL'       ,'','','','','','','','BW4470693','','','',0},
			//{'acct_carpenter'   ,'','','','','','','','AC9044429','','','',0},
			//{'acct_carpenter2'  ,'CARPENTER','1221 N HIGHLAND AVE','60506','AURORA','IL','','LOWELL','','','','',0},
			{'acct_caddrt1'     ,'','535 S Dixie Dr','45377','VANDALIA','OH','','','','','','',0}, // Hock's Pharmacy DEA#=AH2785511
			{'acct_cnamet1'     ,'','','45377','VANDALIA','OH','B K DRUGS INC','','','','','',0}   // Ken's Pharmacy DEA#=AB1026930 
      ], BatchServices._Sample_layout_input_raw);
  END;
	
	EXPORT Death := MODULE
	
		EXPORT ds_sample_input := 
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
			{'1', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '554521162', 0, '', 001960713480,0},
			{'2', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '', 0, '', 001960713480,0,0,100},
			{'3', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '', 0, '', 001960713480,0,0,50},
			{'4', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '', 0, '', 001960713480,0,0,100},
			{'5', 'PETERSON', '1071 HOLLY HILL DR', '95122', 'SAN JOSE', 'CA', '', 'HELEN', '', '', '', '', 0, '', 001960713480,0,0,50},
			{'6', 'KYLE', '', '', '', '', '', 'MARTHA', '', '', '', '410984106', 0, '', 001437941820},
			{'7', 'KYLE', '', '', '', '', '', 'MARTHA', '', '', '', '410984106', 0, '', 001437941820},
			{'8', 'KYLE', '', '', '', '', '', 'MARTHA', '', '', '', '410984106', 0, '', 001437941820},
			{'9', 'CRAWFORD','7942 E SABINO SUNRISE CIR','85750','TUCSON','AZ','','BEVERLY','','','','519209136',0,'J',000532862035,0,100,0} 

			// {'774269ssn', '', '', '', '', '', '', '', '', '', '', '554521162', 0, ''},
			// {'775016ssn', '', '', '', '', '', '', '', '', '', '', '410984106', 0, ''}
			], BatchServices._Sample_layout_input_raw);
	
	END;
	
	EXPORT DiversityCert := MODULE
		EXPORT DS_sample_input := DATASET([
			//acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did, bdid, score_did, score_bdid
				{'1','AGUIRRE','','','','','GIBSON TRUCK','','','','','','','',1626526759,0,0,0},
				{'3','','','','','','GIBSON TRUCK','','','','','','','',0,2632761,0,0}
			], BatchServices._Sample_layout_input_raw);						
	END;
	
	EXPORT Email := MODULE
		EXPORT DS_sample_input := DATASET([
			// acctno, lname, addr,zip, city,st,compname, namefirst, filing_num,  sic_code, fein, ssn, DOB
		  {'acct_TAYLOR','TAYLOR',''   ,''  ,'FRANKFORT' ,'KY',''      ,'JOEL','','','',''},
			{'acct_SMITH',''       ,''   ,''  ,''          ,''  ,''      ,''    ,'','esol@aol.com','',''}
			], BatchServices._Sample_layout_input_raw);								
	END;
 
  EXPORT FIRMOGRAPHICS := MODULE
		EXPORT DS_sample_input := DATASET([
			// acctno, lname, addr,zip, city,st,compname, namefirst, filing_num,  sic_code, fein, ssn, DOB, name_middle, did, bdid, score_did, score_bdid
		  {'acct_1','','','','','','','','','','','','','','','12876','',''},
			{'acct_2','','','','','','','','','','','','','','','12572','',''},
			{'acct_3','','','','','','','','','','','','','','','27552','',''},			
			{'acct_4','','','','','','','','','','','','','','','32489','',''},
			{'acct_5','','1937 W MAIN ST','06904','STAMFORD','CT','Cytec Industries Inc','','','','','','','','','','',''}			
			], BatchServices._Sample_layout_input_raw);								
	END;
	
	EXPORT JUDGEMENTSLIENS := MODULE
		EXPORT DS_sample_input := DATASET([
			// acctno, lname, addr,zip, city,st,compname, namefirst, filing_num,  sic_code, fein, ssn, DOB, name_middle, did, bdid, score_did, score_bdid		 
			//{'acct_5','','4055 DORR ST','43615','TOLEDO','OH','DANA CORP','','','','','','','','','','',''}	
			//{'acct_1','','1 N CAPITOL AVE','46204','INDIANAPOLIS','IN','ARVIN_MERITOR INC','','','','','','','','','','',''}
			{'acct_2','','30009 VAN DYKE AVE','48093','WARREN','MI','General Motors Corp','','','','','','','','','','',''}
			//{'acct_40','','', '48093','WARREN','MI','General Motors Corp','','','','','','','','','','',''}
			], BatchServices._Sample_layout_input_raw);								
	END;

  // NOTE: Medlic_Batch_Service is in prof_LicenseV2_Services, not Batch_Services
	EXPORT Medlic := MODULE
	  // The Medlic_Batch_Service is set up to use license_number, taxid and/or upin for
		// searching, but is not yet set up for that here.  
		// Add special input mappings for the 3(?) fields below to Medlic_BS or add 3 new 
		// fields to BatchServices._Sample_layout_input_raw and update the sample below?
		// string20 license_number = filing_number, but it is only string14
		// string10 taxid 10       = fein, but it is only string9
		// string20 upin           = ??? NOTE: Medlic_B_S does not search on upin even 
		//                           though it is on the Medlic_B_S input layout.
	  EXPORT ds_sample_input := DATASET([
		  //actno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did
			{'acct_MLt1','STUDEBAKER','','','BROOKVILLE', 'OH','','MATTHEW','','','',0},
			{'acct_MLt2','STUDEBAKER','','','BROOKVILLE', 'OH','','','','','',0}, 
			{'acct2_MLPLt3','SMITH','614 w 39th st','64111','KANSAS CITY','MO','','JAMES','','','','',0,'D'},
      {'acct2_MLPLt4','SMITH','','','ENGLEWOOD', 'OH','','MARVIN','','','','',0},
      {'acct2_MLTLt5','YUNGER','','','DAYTON', 'OH','','THOMAS','','','','',0,'MATTHEW'}
      ], BatchServices._Sample_layout_input_raw);	
	END;

  // NOTE: MLPL_Combined_Batch_Service is in prof_LicenseV2_Services, not Batch_Services
	EXPORT MedlicPL := MODULE
	  // Medlic_PL_Combined_Batch_Service is set up to use license_number, taxid, upin
		// (does not really work) and npi for searching, but is not yet set up for that here.
		// See comments above in Medlic and below in PL MODULEs
	  EXPORT ds_sample_input := DATASET([
		  //acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did
			{'acct2_MLPLt1','STUDEBAKER','','','BROOKVILLE', 'OH','','','','','',''}
			//{'acct2_MLPLt2','STUDEBAKER','','','BROOKVILLE', 'OH','','MATTHEW','','','',''}
			//{'acct2_MLPLt3','SMITH','614 w 39th st','64111','KANSAS CITY','MO','','JAMES','','','','',0,'D'}
			//{'acct2_MLPLt4','SMITH','','','ENGLEWOOD', 'OH','','MARVIN','','','',''}
			
      ], BatchServices._Sample_layout_input_raw);	
	END;
    //{'acctno_bug41030','Francis','1669 E 1240 S','84660','Spanish Fork','UT','','Questin','','','','604362172',0,''}

  // NonRegistered_Vehicles_BatchService search samples
	EXPORT NonRegVeh := MODULE
	  EXPORT ds_sample_input := DATASET([
		  //acctno,name_last,addr,zip,city,state,,name_first,,,,ssn,DOB,name_middle,did
      // to test specific requirements/output data fields		
			// 1. xxx
			{'acctno1','lname','1234 main st','12345-6789','Cityname','OH','','fname','','','','123456789',19550624,'mname',0} // returns ???
  	  ], BatchServices._Sample_layout_input_raw);
	END;

	EXPORT PeopleAtWork := MODULE
	  EXPORT ds_sample_input := DATASET([
					 // acct            lname,    addr,                     zip,    city,            st,  compname, namefirst, filing_num,  sic_code, fein, ssn,         DOB
			     {'acct__DLM','','6177 FAR HILLS AVE','45459','DAYTON','OH','DOROTHY LANE MARKET','','','541105,549901,829924', 0},					 
					 {'_acct_CALDWELL','CALDWELL','1081 JACKSON HEIGHTS RD','37072','GOODLETTESVLLE','TN','',       'KEVIN',   '',          '',       '',   '413171183',  19591206}
						], BatchServices._Sample_layout_input_raw);
	END;

	EXPORT PossibleLitigiousDebtor := MODULE
	  EXPORT DS_sample_input := DATASET([
		  // acctno, lname, addr, zip, city, st, compname, namefirst, filing_num,  sic_code, fein, ssn,
			//DOB  String1 CaseTypeSearch_FDCPA, CaseTypeSearch_FCRA, CaseTypeSearch_TCPA
			// {'acct_JONES','JONES',''   ,''  ,'' ,'VA',''      ,'JOHN','','Y','Y','Y'},
			{'acct_WYNN','WYNN',''   ,''  ,'' ,'CA',''      ,'DEBORAH','','Y','Y','Y'},
			{'acct_MATA','MATA',''   ,''  ,'' ,'',''      ,'JUAN','','Y','Y','Y'}								
			//  st field is CourtJurisdiction, sic_code is CaseTypeSearch_FDCPA,
			//  fein field is CaseTypeSearch_FCRA, ssn field is CaseTypeSearch_TCPA																										
			], BatchServices._Sample_layout_input_raw);								
	END;
	
  // NOTE: PL_Batch_Service is in prof_LicenseV2_Services, not Batch_Services
	EXPORT Proflic := MODULE
	  // The PL_Batch_Service is set up to use NPI for searching, but is not yet set 
		// up for that here.
		// Add special input mapping for the NPI field to PL_B_S or add the NPI field
		// to BatchServices._Sample_layout_input_raw and update the sample below?
		// string10 npi = filing_number?
	  EXPORT ds_sample_input := DATASET([
		  //acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did
			//{'acct__EPSTEIN','EPSTEIN','','','','AZ','','SHELDON','','', 0},
			//{'acct__WONG',   'WONG','','','','NY','','CHING','','', 0},
			//{'acct__COUPEY', 'COUPEY','','','','NY','','SUSAN','','', 0},
			//{'acct__MCNEIL', 'MCNEIL','','','','OH','','','','', 0}, // see Bug 36282
			//{'acct__CARL'  , 'CARL','','','KANSAS CITY','MO','','JAMES','','','', 0},
      //{'acct__MARK'  , 'Schloneger','','','DAYTON', 'OH','','MARK','','','',0}
			//{'acct__cnamet1','','','46219','INDIANAPOLIS','IN','IMMEDIADENT','','','','',0}, //Comp_name search
			//{'acct__exflgt1','phillips','','','BROOKVILLE','OH','','nancy','','','',0}  // search to show new output expired_flag=Y,N&U
			//{'acct_MLPLt1','STUDEBAKER','','','BROOKVILLE', 'OH','','MATTHEW','','','',0}
			{'acct_MLPLt2','STUDEBAKER','','','BROOKVILLE', 'OH','','','','','',0} //
			], BatchServices._Sample_layout_input_raw);	
	END;	
		
	EXPORT Property := MODULE
	
		EXPORT ds_sample_input := DATASET([
			// {'acct__CAMPBELL','','2321 CAMPBELL CIRCLE','94533','FAIRFIELD','CA','','','','', 0},
			// {'acct__G_WOO','','2200 G WOO AVE','92231','CALEXICO','CA','','','','', 0},
      {'acct__NEVIN','NEVIN','649 W MARTINDALE RD','45322','UNION','OH','','CHERI','','', 0},
			{'acct__ALBEE','','3140 BROOKES ST','45410','DAYTON','OH','','','','','','536880451'}
			// {'acct__ALBEE','ALBEE','3140 BROOKS ST','45420','DAYTON','OH','','CHRISTOPHER','','','','536880451'} // ,
			// {'acct__ALBEE','ALBEE','','','DAYTON','OH','','CHRISTOPHER','','','',''} // ,
			// {'acct__EVANS_1','EVANS','2303 FLATROCK COURT','60564','NAPERVILLE','IL','','WILLIAM','','', 0},
			// {'acct__EVANS_2','EVANS','4219 FALKNER DR','60564','NAPERVILLE','IL','','WILLIAM','','', 0},
			// {'acct__WILSON_1','WILSON','5553 WOODSONG TRAIL','30338','DUNWOODY','GA','','DANIEL','','', 0}
			// {'acct__DICKSON','DICKSON','11806 VIRGINIA AVE','90262','LYNWOOD','CA','','JOSEPH','','', 0},
			// {'acct__THURMAN','THURMAN','','','SARASOTA','FL','','TIMOTHY','','', 0}
			], BatchServices._Sample_layout_input_raw);	
		
	END;
	
	EXPORT  SearchPoint_PRACTITIONER := MODULE
	   export ds_sample_Input := DATASET([
		     {'acct__1', '','','','','','','','AH2785511'//NO NCPDP NUMBER just dea_number in filing number field				 				   
							 },
				 {'acct__2', '','','','','','','','AB1026930'}, // NO NCPDP number just dea_number in filing number field	
				  {'acct__3', '','','','','','','','A90777889','',//FEIN,
				       //NCPDP included here
							 3912020}							 
				],  BatchServices._Sample_layout_input_raw);
    //  Hock's Pharmacy DEA#=AH2785511
   // Ken's Pharmacy DEA#=AB1026930	
	
	END;
	
	// the raw layout doesn't have dea or ncpdp numbers, so for this service is assigning the filing 
  // number to the dea number and the sic code to the ncpdp number.
  // Layout for _Sample_layout_input_raw: STRING20  acctno        := '';
  //                                      STRING20  name_last     := '';
	//	                                    STRING100 addr          := '';
	//	                                    STRING10  zip           := '';
	//	                                    STRING20  city          := '';
	//	                                    STRING2   state         := '';
	//	                                    STRING120 comp_name     := '';
	//	                                    STRING20  name_first    := '';
	//	                                    STRING14  filing_number := '';
	//	                                    STRING72  sic_code      := '';		
	//	                                    STRING9   fein          := '';
	//	                                    STRING9   ssn           := '';
	//	                                    UNSIGNED8 DOB           :=  0;
	//	                                    STRING20  name_middle   := '';
	//	                                    UNSIGNED6 did			:= 	0;
	//	                                    UNSIGNED6 bdid			:= 	0;
	//	                                    UNSIGNED3 score_did		:= 	0;
	//	                                    UNSIGNED3 score_bdid	:= 	0;
  
  EXPORT  SearchPoint_OUTLET := MODULE
	   export ds_sample_Input := DATASET([
		     {'acct__1', '','','','','','','','AH2785511'//NO NCPDP NUMBER just dea_number in filing number field				 				   
							 },
				 {'acct__2', '','','','','','','','AB1026930'}, // NO NCPDP number just dea_number in filing number field	
				 {'acct__3', '','','','','','','','A90777889','3912020'}, //NCPDP included here in the sicCode field,		
         {'acct_4',  '','','','','','','','AF4208876','4001587'} // test case sent by Jason Ding where match code is incorrect
														 
				],  BatchServices._Sample_layout_input_raw);
    //  Hock's Pharmacy DEA#=AH2785511
   // Ken's Pharmacy DEA#=AB1026930	
	
	END;

	EXPORT SexPredator := MODULE
	
		EXPORT ds_sample_input := DATASET([
			{'acct__Villarreal_il','Villarreal','','','','IL','','Daniel','','','','','',''},
			{'acct__Somerstorfer_il','Somerstorfer','','','','IL','','Larry','','','','','',''},
			{'acct__Rambo_il','KEARNS ','','','','IL','','Melissa','','','','','',''}
			], BatchServices._Sample_layout_input_raw);
			
	END;

	EXPORT WorkPlace := MODULE
	  EXPORT ds_sample_input := DATASET([
		  //acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did
			// test cases to return a record for each different source (8 sources total)
			//INITIAL TEST USING POE AUTOKEYS{'acct_spoke','Abdul','170 West Tasman Dr','95134','San Jose','CA','','Aziz','','','','',0,'',0}, // returns spoke rec w 2 phone#s
			
      {'acct_spoke','Abdul','1790 Nantucket Cir','95054','Santa Clara','CA','','Aziz','','','','',0,'',0}, // returns spoke rec w 2 phone#s
			//INITIAL TEST USING POE AUTOKEYS{'acct_zoom','Clark','1505 Dillingham Blvd Ste 212','96817','Honolulu','HI','','Patti','','','','',0,'',0}, // returns zoom rec w 2 phone#s
			{'acct_zoom','Clark','886 W Galveston St','85225','Chandler','AZ','','Patti','','','','',0,'',0}, // returns zoom rec w 2 phone#s
			//INITIAL TEST USING POE AUTOKEYS{'acct_jigsaw','Abd-Elfattah','1250 E Marshall St','23298','Richmond','VA','','Anwar','','','','',0,'S',0}, // returns jigsaw rec
			{'acct_jigsaw','Abd-Elfattah','11814 Crown Prince Dr','23238','Henrico','VA','','Anwar','','','','',0,'S',0}, // returns jigsaw rec
			{'acct_garn1','last','addr','zip','city','xx','','first','','','','',0,'MI',0}, // returns garnishment rec
			{'acct_corp','Aagaard ','36408 E Eldorado Lake Dr ','32736','Eustis','FL','','Douglas','','','','',0,'L',0}, // returns corp rec w 1 phone from gong; also has prolic data in output
			{'acct_oneclick','Aaenson','17304 Redhawk Dr','98223','Arlington','WA','','Jason','','','','',0,'',0}, // returns one_click rec instead of tt one for the same dt_last_seen
			{'acct_clarity','last','addr','zip','city','xx','','first','','','','',0,'MI',0}, // returns clarity rec
			{'acct_tt','Arellano','3037 Heritage Dr','84119','Salt Lake City','UT','','Sherry','','','','',0,'A',0}  // returns teletrack rec
      
      // to test specific requirements/output data fields		
			// 1. subject & spouse both in poe test case
			//ONLY WORKS USING POE AUTOKEYS, NEED TO FIND ANOTHER EXAMPLE
			// {'acct_zoomss','Morgan','','44720','Canton','OH','','Michael','','','','495900945',0,'',0} // returns zoom rec for both subject & spouse
			// 2. self employed indicator test - this req removed on 09/17, but may be added back in the future
			//{'acct_zoom_se2','Arader','1234 Summer St Ste 4','06905','Stamford','CT','','Alexander','','','','',0,'J',0} // returns zoom rec
      // 3. data from garn test case1 (limited recs on garn key did due to only 1 test county in-house as of 09/16)
			//DONT USE inital test only!{'acct_tt_wgarn','Flory','2085 W Wayne St','45805','Lima','OH','','David','','','','',0,'',0}  // returns teletrack rec with garn data
			// 4. prof lic data in output, see acct_corp example above for Douglas Aagaard
			// 5. parent comp info test case
			//{'acct_oneclick_wparco3','miller','511 grant st','83605','caldwell','id','','shannon','','','','',0,'',0}  // returns one click rec with parent comp data
			// 6. no gong phone, so phone# from yellow pages test case
      //{'acct_zoom_yp','Bailey','10155 peppermint cir','95327','Jamestown','CA','','Kimberly','','','','557434742',0,'',0}  // returns one zoom rec phone2 from yp instead of gong
  	  ], BatchServices._Sample_layout_input_raw);
	END;

END;
