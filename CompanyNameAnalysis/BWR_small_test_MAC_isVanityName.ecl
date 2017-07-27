import CompanyNameAnalysis;

//-------------- test test test test ---------------------------
// The following is a set of 101 company names from NGBDL2.Layout_Header
CompanyName_with_id_rec := RECORD
  integer coname_id;
	string company_name;
END;

sampleCompanyNameAndAddress_with_id := 
      DATASET([
               {101,'DR. CLAYBORN TAYLOR, D.D.S., INC.'},
               {102,'PEGGY J BLEVINS'},
               {103,'SIMONE KOOS'},
               {104,'WAGNER,TERRY'},
               {105,'GARY E. CROSSETT'},
               {106,'MICHAEL D CERVERIS PC'},
               {107,'ELVIS JACKSON'},
               {108,'JAMES MIELKE'},
               {109,'LANE/AURELIA L'},
               {110,'MICHELLE ESCAGNE'},
               {111,'JASON LIGHTLE'},
               {112,'DANIEL C DANILA MD'},
               {113,'MARY E WOOD'},
               {114,'RICHARD D SIMONS SR'},
               {115,'KNIPRATH D PHILLIP'},
               {116,'GLEN GILLETTE'},
               {117,'JANE FRANCES'},
               {118,'SCHAFER STUART E'},
               {119,'TERRI  BILLINGSLEY'},
               {120,'GEORGE A. HUNTER, M.D.'},
               {121,'TONY B HINKEN'},
               {122,'RON HARRIS'},
               {123,'PAUL L. GANT ELECT. MAINT.'},
               {124,'RICHARD R JONES COMM'},
               {125,'TUBBS MITFORD E'},
               {126,'MASON ALBERT MD'},
               {127,'CHAPMAN MICHAEL'},
               {128,'RODRIGUEZ MARICELA'},
               {129,'DICKEY, TERRY DBA SONIC OF HUNTINGDON'},
               {130,'GARVIE, WILLIAM H.'},
               {131,'ROBERT A BUSH ATT AT LAW'},
               {132,'EARNIST LINDA R'},
               {133,'HODOSH ALEX J DMD'},
               {134,'JACK JUDY'},
               {135,'KAREN J WISMAN'},
               {136,'CHRISTOPHER P JUDGE ATT AT LAW'},
               {137,'RICHARD E. HAMILTON, JR., M.D., INC.'},
               {138,'MCQUEEN WILLIAM D'},
               {139,'DANIEL D KAUFFMAN'},
               {140,'BRENT G LOVELESS'},
               {141,'HILL DAVID E'},
               {142,'DAVID MALICKA'},
               {143,'MCASEY, WILLIAM J'},
               {144,'SEAN D, GIBSON'},
               {145,'BRIAN C. HARDEBECK'},
               {146,'DOROTHY L FRAZER'},
               {147,'GOLDEN ROBERT E'},
               {148,'SCOTT W ELY SR'},
               {149,'DAVIS, SHELLEY'},
               {150,'BERRYL A ANDERSON ATT AT LAW'},
               {151,'SPROHNLE C DC'},
               {152,'LOCKE JOSEPH M'},
               {153,'TRENT A. MILLICAN, CPA, A PROFESSIONAL ACCOUNTINGCORPORATION'},
               {154,'PAUL BALSAVAGE SR'},
               {155,'RANDALL W HOMEWONERS ASSOCIATION'},
               {156,'COLEMAN PLECKER'},
               {157,'GEORGE MCDONELL'},
               {158,'KENNETH W ANGLE'},
               {159,'FOSTER DAN W ATTY'},
               {160,'CHURCH TERESA'},
               {161,'RANJINI CHUGH MD'},
               {162,'DAVID ARENDT OD'},
               {163,'DONALD L. MANSFIELD M.D., P.C.'},
               {164,'CRAWFORD KIMBERLY MD'},
               {165,'SMITH WILL'},
               {166,'CUNI THOS L'},
               {167,'MALLARD, RICHARD L.'},
               {168,'DAVID M. THOMAS'},
               {169,'MARSHALL FIELD'},
               {170,'PENN GERRI M'},
               {171,'SHAW DOUGLAS A'},
               {172,'DANIEL R HILLARD'},
               {173,'HARLEY A FEINSTEIN'},
               {174,'DAVIDSON JON'},
               {175,'BONNIE REED'},
               {176,'LAYTON, MARK L'},
               {177,'MITTILEDER, TAMI F.'},
               {178,'HARRINGA, ROYCE M'},
               {179,'ROBERT M. MAHER, D.D.S., INC.'},
               {180,'LESLIE WILDER'},
               {181,'BOERNER, MICHAEL C.'},
               {182,'HIGHT-BRYANT CAROLYN S.'},
               {183,'MARILEE A ALDER'},
               {184,'JAMES B GRAHAM'},
               {185,'MICHAEL STEVENS'},
               {186,'D&apos;AGNESE, FELICE A. &amp; SUSAN J.'},
               {187,'ILSE F. COOPER'},
               {188,'SUSAN E EDWARDS'},
               {189,'ALICE E LETT, TRUSTEE'},
               {190,'ARCHIE LIDEY'},
               {191,'BROOKS              JACK          R'},
               {192,'DAVID C WEAVER INC'},
               {193,'HART/SHANNON'},
               {194,'GOGA, JULIE A'},
               {195,'RAYMOND E MATTHISEN'},
               {196,'PERECHMAN STEVEN C'},
               {197,'JOHNSON, ROB CONSTRUCTION'},
               {198,'ANTHONY ROBINSON'},
               {199,'MESHEL, ROBERT W., TRUSTEE'},
               {200,'TYLER, SHARON'}
							 ]
				      , CompanyName_with_id_rec
						 );

output(COUNT(sampleCompanyNameAndAddress_with_id),NAMED('c_sampleCompanyNameAndAddress_with_id'));
output(sampleCompanyNameAndAddress_with_id,NAMED('sampleCompanyNameAndAddress_with_id'));

CompanyNameAnalysis.MAC_isVanityName(sampleCompanyNameAndAddress_with_id, company_name, vanity_company_names, company_name_token_patterns);
//CompanyNameAnalysis.MAC_isVanityName(sampleCompanyNameAndAddress_with_id, company_name, vanity_company_names, company_name_token_patterns,'^N N$');
//CompanyNameAnalysis.MAC_isVanityName(sampleCompanyNameAndAddress_with_id, company_name, vanity_company_names);

outputted_vanity_names := vanity_company_names : PERSIST('thumphrey::small_sample::vanity_names');

output(COUNT(company_name_token_patterns),NAMED('c_company_name_token_patterns'));
output(company_name_token_patterns, NAMED('company_name_token_patterns'));

output(COUNT(vanity_company_names),NAMED('c_vanity_company_names'));
output(vanity_company_names, NAMED('vanity_company_names'));