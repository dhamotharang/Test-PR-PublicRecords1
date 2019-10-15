
#OPTION('multiplePersistInstances',false);

import nid, Address;

ds_Worldbank_Debarred	:= 	DATASET('~thor::in::globalwatchlists::world_bank', 
                             patriot_preprocess.Layout_Worldbank_Debarred.layout_Worldbank_Debarred_Firms, CSV(separator('\t') , heading(1),quote('"'),TERMINATOR(['\n', '\r\n'])));	


filter_Worldbank_Debarred := ds_Worldbank_Debarred(orig_firm_name <> '');

layout_normalizer_fire_count := record
integer count_tilda_marks;
integer normalizer_fire_count;
layout_patriot_common;
end;

layout_normalizer_fire_count tr_normalizer_fire_count
                                               (filter_Worldbank_Debarred l, integer c) := TRANSFORM

remarks_1 := map(l.IneligibilityPeriodfrom <> '' => 'Ineligible Start Date: ' + l.IneligibilityPeriodfrom,'');
remarks_2 := map(l.Ineligibilityperiodto <> '' => 'Ineligible End Date: ' + l.Ineligibilityperiodto,'');  
remarks_3 := map(l.grounds<> '' => 'Grounds: ' + l.grounds[1..75],'');
remarks_4 := map(l.grounds<> '' and length(trim(l.grounds,left,right)) > 66 =>  l.grounds[67..],''); // need to take length of 'Grounds: ' 
remarks_5 := map(l.country <> '' => 'Country: ' + l.country, '');   

left_pad_with_zeros := map(length((string) c) = 1 => '00',
                           length((string) c) = 2 => '0', '');

pty_key := 'WBI' + trim(left_pad_with_zeros,left,right) + (string) c;
 
clean_orig_firm_name_1 := StringLib.StringFindReplace(
                          StringLib.StringFindReplace(
													 StringLib.StringFindReplace(
														StringLib.StringFindReplace(
														 StringLib.StringFindReplace(
															StringLib.StringFindReplace(
															 StringLib.StringFindReplace(l.orig_firm_name,'*','~'),'?',''),'MR.',''),'(MS.)',''),'MS.',''),'MRS.',''),'DR.','');

clean_orig_pty_name_2 := 
           map(regexfind('(.*)(~)(.*)',clean_orig_firm_name_1) 
					         => regexreplace('(.*)(~)(.*)', clean_orig_firm_name_1,'$1'),
	                                clean_orig_firm_name_1);	

clean_orig_pty_name_3 := 
           map(regexfind('(.*)(Registration)(.*)',clean_orig_pty_name_2) 
					         => regexreplace('(.*)(Registration)(.*)', clean_orig_pty_name_2,'$1'),
	                                clean_orig_pty_name_2);	   
																	
clean_orig_pty_name_4 := 
           map(regexfind('(.*)(Guidelines 1.22)(.*)',clean_orig_pty_name_3) 
					         => regexreplace('(.*)(Guidelines 1.22)(.*)', clean_orig_pty_name_3,'$1'),
	                                clean_orig_pty_name_3);	 	                                                                                                                                                                                                            

clean_orig_pty_name_5 := 
           map(regexfind('(.*)(REG. NO)(.*)',clean_orig_pty_name_4) 
					         => regexreplace('(.*)(REG. NO)(.*)', clean_orig_pty_name_4,'$1'),
	                                clean_orig_pty_name_4);		

clean_orig_pty_name_6 := 
           map(regexfind('(.*)(REG.NO)(.*)',clean_orig_pty_name_5) 
					         => regexreplace('(.*)(REG.NO)(.*)', clean_orig_pty_name_5,'$1'),
	                                clean_orig_pty_name_5);
																	
clean_orig_pty_name_7 := 
           map(regexfind('(.*)(NATIONAL ID)(.*)',clean_orig_pty_name_6) 
					         => regexreplace('(.*)(NATIONAL ID)(.*)', clean_orig_pty_name_6,'$1'),
	                                clean_orig_pty_name_6);				
																	
clean_orig_pty_name_8 := 
           map(regexfind('(.*)(TIN)(.*)',clean_orig_pty_name_7) 
					         => regexreplace('(.*)(TIN)(.*)', clean_orig_pty_name_7,'$1'),
	                                clean_orig_pty_name_7);
																	
clean_orig_pty_name_9 := StringLib.StringFindReplace(clean_orig_pty_name_8,'()','');	

 
clean_orig_pty_name_10 := 
           map(
					     regexfind('(.*)(\\(also known as)(.*)(\\))',clean_orig_pty_name_9) 
					     => regexreplace('(.*)(\\(also known as)(.*)(\\))', clean_orig_pty_name_9,'$1~$3'),
               regexfind('(.*)(\\(CURRENTLY KNOWN)(.*)(\\))',clean_orig_pty_name_9) 
					     => regexreplace('(.*)(\\(CURRENTLY KNOWN)(.*)(\\))', clean_orig_pty_name_9,'$1~$3'), 
							 regexfind('(.*)(f/k/a)(.*)',clean_orig_pty_name_9) 
					     => regexreplace('(.*)(f/k/a)(.*)', clean_orig_pty_name_9,'$1~$3'),
							 regexfind('(.*)(\\(A.K.A.)(.*)(\\))',clean_orig_pty_name_9) 
					     => regexreplace('(.*)(\\(A.K.A.)(.*)(\\))', clean_orig_pty_name_9,'$1~$3'),
               regexfind('(.*)(\\(FORMERLY)(.*)(\\))',clean_orig_pty_name_9) 
					     => regexreplace('(.*)(\\(FORMERLY)(.*)(\\))', clean_orig_pty_name_9,'$1~$3'), 	
							 regexfind('(.*)(\\(AKA)(.*)(\\))',clean_orig_pty_name_9)
							 => regexreplace('(.*)(\\(AKA)(.*)(\\))', clean_orig_pty_name_9,'$1~$3'), 	
							 regexfind('(.*)(A.K.A.)(.*)',clean_orig_pty_name_9) 
					     => regexreplace('(.*)(A.K.A.)(.*)', clean_orig_pty_name_9,'$1~$3'),
               regexfind('(.*)(FORMERLY KNOWN AS)(.*)',clean_orig_pty_name_9) 
					     => regexreplace('(.*)(FORMERLY KNOWN AS)(.*)', clean_orig_pty_name_9,'$1~$3'),
							 regexfind('(.*)( AKA )(.*)',clean_orig_pty_name_9) 
					     => regexreplace('(.*)( AKA )(.*)', clean_orig_pty_name_9,'$1~$3'),
               regexfind('(.*)(Also Doing Business Under)(.*)( or )(.*)',clean_orig_pty_name_9) 
               => regexreplace('(.*)(Also Doing Business Under)(.*)( or )(.*)', clean_orig_pty_name_9,'$1~$3~$5'),
               regexfind('(.*)(\\(CURRENTLY D/B/A)(.*)(\\))',clean_orig_pty_name_9) 
               => regexreplace('(.*)(\\(CURRENTLY D/B/A)(.*)(\\))', clean_orig_pty_name_9,'$1~$3'), 	
               regexfind('(.*)(\\(a.k.a.)(.*)(\\))(, also d.b.a.)(.*)',clean_orig_pty_name_9) 
               => regexreplace('(.*)(\\(a.k.a.)(.*)(\\))(, also d.b.a.)(.*)', clean_orig_pty_name_9,'$1~$3~$6'), 	
							
							 regexfind('(.*)(d/b/a)( Groupe SystÃƒÂ¨mes et Solutions DÃ‚â€™entreprise, ESS Group)(,)( Enterprise Systems and Solutions Group)',clean_orig_pty_name_9) 
               => regexreplace('(.*)(d/b/a)( Groupe SystÃƒÂ¨mes et Solutions DÃ‚â€™entreprise, ESS Group)(,)( Enterprise Systems and Solutions Group)', clean_orig_pty_name_9,'$1~$3~$5'),
						 
						   regexfind('(.*)(as the successor or assign to)(.*)',clean_orig_pty_name_9) 
               => regexreplace('(.*)(as the successor or assign to)(.*)', clean_orig_pty_name_9,'$1~$3'),
   
	             regexfind('M/S',clean_orig_pty_name_9) => clean_orig_pty_name_9, // need before '(.*)(/)(.*)' search
							 
               regexfind('(.*)(/)(.*)',clean_orig_pty_name_9) // needs be last
							 => regexreplace('(.*)(/)(.*)', clean_orig_pty_name_9,'$1~$3'),										 
							
							// else part
							 map(clean_orig_pty_name_9[length(trim(clean_orig_pty_name_9,left,right))..length(trim(clean_orig_pty_name_9,left,right))] = '('
							      => clean_orig_pty_name_9[..length(trim(clean_orig_pty_name_9,left,right))-1],
										    clean_orig_pty_name_9)							 
							 );                                                                                                                                                                                                                                                                                                                    
									
									
                                                                                                                                                                                                                                                                                                  
		

count_tilda_marks := StringLib.StringFindCount(clean_orig_pty_name_10 ,'~');
normalizer_fire_count := count_tilda_marks + 1;

self.count_tilda_marks := count_tilda_marks; 
self.normalizer_fire_count := normalizer_fire_count; 																
self.pty_key := pty_key;
self.source := 'World Bank Ineligible Firms';
//self.orig_pty_name := l.orig_firm_name;
self.orig_pty_name := trim(clean_orig_pty_name_10,left,right);
self.orig_vessel_name := '';
self.country := l.country;,
self.name_type := '';
self.addr_1 := regexreplace(',  ',regexreplace(',  , ',map(l.address <> ',' => l.address,''),''),'');        
self.remarks_1 := remarks_1;
self.remarks_2 := remarks_2;  
self.remarks_3 := remarks_3; 
self.remarks_4 := map(remarks_4 <> '' => remarks_4, remarks_5);
self.remarks_5 := map(remarks_4 <> '' => remarks_5, '');    

// entity_string1 := 'ELECTRICAL|NETWORK|SHIPPING|TELECOM|CANADA|COMMUNICATION|CORPORATE|GRAPHIC |ACCOUNTS|REVOLUTIONARY|ORGANIZATION|ORGANISATION|AMBULANCE|AB HIDROSTATYBA|AB PANEVEZIO STATYBOS TRESTAS|INDUSTRIE|AMERICAN|NORTHERN|SOUTHERN|ADMINISTRATION|ALIGNMENT|AMUSEMENT|ANTIQUE|'; 
// entity_string2 := 'APARTMENTS|APLC|ARCHITECT|ARCHETECT|AIR CONDITIONING|APPLIANCE|ASSOCIATES|ASSOCIATION|AGENT|AUTOMOTIVE|AVIATION|AIRLINES|BOOKKEEPING|BOOKBINDER|BROKERAGE| BROKERS |BUILDING|BUSINESS|BOUTIQUE|CHEMICAL|COMPUTER|CORPORATION|CORP.|CO.|CARBURETOR|CHIROPRACTIC|CLEANING|COMPANY|';  
// entity_string3 := 'CONSTRUCTION|CONSULT|COOPERATIVE|CABLEVISION|COMMUNITY|CMNTY|COMMUNICATIONS|COUNTRY CLUB| COUNTY | CREDIT |DEVELOPMENT|DETROIT|DVLPMNTL|DISTRICT|DISTRIBUTING|DIVISION|ELEVATOR|ENTERPRISE|ENGINEERING|ESTATES|EQUIPMENT|EQUITY|EXCAVATING|';  
// entity_string4 := 'EXPRESS|FINANCIAL | FINANCE | FABRICATORS| FREIGHTLINER| FREIGHT | FULLFILLMENT| FULFILLMENT| FUNERAL HOME| FURNITURE| GOVERNMENT| GVRNMNT|  GROWERS | DEVELOPMENT| DVLPMNTL| FREIGHT| HEALTHCARE| INNOVATIVE| HOSPICE|  HOSPITAL| INDUSTRIES|';  
// entity_string5 := 'INSTITUTE|INDUSTRIAL|INTERNATIONAL|INTERIORS|INVESTMENTS|LANDSCAPING| LEASING | LEASE |LIMITED|MACHINE|MANAGEMENT|MATUSHITA|MATSUSHITA|MISSIONARY|MINISTRIES|MNGMNT|MOBILE PARK|MOBILE HOME|MOUNTAIN|NATIONAL|OPTICAL|PACKAGING|PARTNERSHIP|PEDIATRICS|';  
// entity_string6 := 'PEER REVIEW|PHARMACY|PHARMACEUTICAL|PENSION PLAN|PRODUCTIONS|PROFESSIONAL|PROPERTIES|RAILROAD|REALTY|REBUILDERS|REPAIR|RESTARAUNT|RESTAURANT|SAVINGS|SECURITIES|SEAFOOD|SERVICES|SOLUTION|SPECIALTY| SQUARE |SYSTEMS|STATE BANK|SPECIALIST|SPRCNTR|SCHOOL|SUPERCENTER|SUPPLY|SURGERY|TELEPHONE|TRAVEL |TRADE NAME|TRUCKING|';  
// entity_string7 := ' TRANSPORT |TECHNOLOGY|TRANSPORTATION|TRANSMISSION| STORAGE | TRANSPORT |VALLEY |WAREHOUSE|WELLS FARGO| AGENCY| MARKET | SALES | RADIO| COUNCIL | PARTNERS| PLAZA| CLINIC|CENTER |REPAIR |TRUST | INC | INC.|INC |INC. | LLC|';  
// entity_string8 := ' L L C|LTD|LLP|L L P|LP|L.P.|BANK N.A.|BANK NA| N.A.| N. A.| N A|N.A.|N. A.| PSC| P S C| F S B|CITY  |COUNTY  |STATE  |PROVINCE  |LIQUOR | CORP | OFFICE | DELI | MOTEL | INN | USA | U S A | & SONS|SH.P.K.|SISTEMAS |CONSULTING |DIGIDATA |UNIVERSAL |TECHNOLOGIES|EQUIPOS | THE|';
// entity_string9 := 'ASOCIADOS|SOLUCIONES|SNC-LAVALIN|SOCIETE|HOLDINGS|CENTRAL|INTREPRINDEREA|CABINET|DE FORMATION|HOLDING|TECNOLOGIA|S.A.|S.L.|GRANDS|PLUS|MODERN|R&B|ITANSUCA|TIPAZA|GROUP'; 

// concat_entity := entity_string1 + entity_string2 + entity_string3 + entity_string4 + entity_string5 + entity_string6  + entity_string7  + entity_string8 + entity_string9; 

                                                                                                                                                                                                                                                                                                                                                   
 // keep_as_names_overide := [                                                                                                                                                                                                                                                                                                                                                
						// 'EDUARDO OSVALDO MADRID',                                                                                                                                                                                                                                                                                                                           
						// 'JUAN CARLOS SALAZAR PRIETO',                                                                                                                                                                                                                                                                   
						// 'NABOR MIRANDA GAMBINI',                                                                                                                                                                                                                                                                                                           
						// 'KHOTAMOV RUSTAM URAKOVICH',                                                                                                                                                                                                                                                                        
						// 'M/S SHIMUL ENTERPRISE',                                                                                                                                                                                                                                                                                                          
						// 'GUNNAR DEMOULIN',                                                                                                                                                                                                                                                                                                
						// 'MANUEL MONTARROSO',                                                                                                                                                                                                                                                                      
						// 'HUBEI GEKE TES',                                                                                                                                                                                                                                                                                                                               
						// 'PATRICIA GIOCONDA PAEZ MORENO',                                                                                                                                                                                                                                                                                                                                     
						// 'SERGIO ANDRES NAVAS ALVARADO',                                                                                                                                                                                                                                                                                                          
						// 'FAUSTO ALEJANDRO LOPEZ CIFUENTES',                                                                                                                                                                                                                                                                                                   
						// 'DAVID KALISILIRA',                                                                                                                                                                                                                                                                                                                                         
						// 'ALFREDO ECHALAR FRANCO',                                                                                                                                                                                                                                                                                                                                            
						// 'SAMUEL CÃƒÂRDENAS COLQUE',                                                                                                                                                                                                                                                                                                               
						// 'LAXMINARAYAN MALLICK',                                                                                                                                                                                                                                                                                                            
						// 'ANGELO ALBERTO NAPANGA GARCIA',                                                                                                                                                                                                                                                                                                                                     
						// 'LEHYLA VIRGINIA FARFAN AGUIRRE',                                                                                                                                                                                                                                                                                                                  
						// 'RENÃƒâ€° SANDOVAL SOLIZ',                                                                                                                                                                                                                                                                                                            
						// 'SANJAY GUPTA',                                                                                                                                                                                                                                                                                                                                  
						// 'ZAKIR HOSSAIN',                                                                                                                                                                                                                                                                                                                                                     
						// 'NICOLE BURDA ',                                                                                                                                                                                                                                                                                                                                      
						// 'DENNIS VAN VOGELPOEL',                                                                                                                                                                                                                                                                                
						// 'LUIS ARTURO ARCHILA DE LEON',                                                                                                                                                                                                                                                                          
						// 'ANA PATRICIA ESPINOZA ROJAS DE SALALA',                                                                                                                                                                                                                                                                                                   
						// 'LUIS ANTONIO ARGUETA LOPEZ',                                                                                                                                                                                                                                          
						// 'HERBERT ERNESTO LOPEZ GALLARDO',                                                                                                                                                                                                                                                                                                       
						// 'CELSO NUNEZ SCARPELLINO',                                                                                                                                                                                                                                                                                                                                           
						// 'EDULFO FIDEL NUNEZ SCARPELLINO',                                                                                                                                                                                                                                                                                                                                    
						// 'JORGE HERIBERTO NUNEZ SCARPELLINO',                                                                                                                                                                                                                                                                                                      
						// 'RAMON ARTURO GOMEZ VELASCO',                                                                                                                                                                                                                                                                                                    
						// 'LUIS ADOLFO PEREZ BRENES',                                                                                                                                                                                                                                                                                                                                          
						// 'MARYLYN PAUL THEODORE',                                                                                                                                                                                                                                                                                                                                             
						// 'RONALD THEODORE',                                                                                                                                                                                                                                                                                                                              
						// 'EDWIN DITTER ACARAPI COLQUE',                                                                                                                                                                                                                                                              
						// 'INDARYATI MOTIK ADISURYO',                                                                                                                                                                                                                                                                                                         
						// 'DMITRY GENNADYEVICH KOSTOUSOV',                                                                                                                                                                                                                                                                                 
						// 'SYANI PHIROM',                                                                                                                                                                                                                                                                                                                 
						// 'MD. SHAMSUL ALAM',                                                                                                                                                                                                                                                                                
						// 'ANSHAR M. NOOR',                                                                                                                                                                                                                                                                                                                                                    
						// 'DENI CASMADI',                                                                                                                                                                                                                                                                                                                                                      
						// 'SATRIO BUDI HANDOKO',                                                                                                                                                                                                                                                                                                                                               
						// 'JOKO SESWANTO',                                                                                                                                                                                                                                                                                                                                        
						// 'H. SYAEFULLAH SIRIN',                                                                                                                                                                                                                                                                                                                                               
						// 'ROZALI USMAN',                                                                                                                                                                                                                                                                                                                                         
						// 'IOANNIS ARISTIDOU'];   
  
// self.entity_flag := map(trim(clean_orig_pty_name_10,left,right) in keep_as_names_overide => '',
                          // regexfind(concat_entity,clean_orig_pty_name_10,nocase) = true => 'Y','');	
													
													

self.entity_flag := map(
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ELECTRICAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'NETWORK',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SHIPPING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TELECOM',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CANADA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COMMUNICATION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CORPORATE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'GRAPHIC',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ACCOUNTS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'REVOLUTIONARY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ORGANIZATION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ORGANISATION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AMBULANCE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AB HIDROSTATYBA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AB PANEVEZIO STATYBOS TRESTAS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INDUSTRIE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AMERICAN',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'NORTHERN',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SOUTHERN',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ADMINISTRATION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ALIGNMENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AMUSEMENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ANTIQUE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'APARTMENTS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'APLC',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ARCHITECT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ARCHETECT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AIR CONDITIONING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'APPLIANCE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ASSOCIATES',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ASSOCIATION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AGENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AUTOMOTIVE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AVIATION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AIRLINES',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'BOOKKEEPING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'BOOKBINDER',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'BROKERAGE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),' BROKERS ',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'BUILDING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'BUSINESS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'BOUTIQUE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CHEMICAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COMPUTER',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CORPORATION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CORP.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CO.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CARBURETOR',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CHIROPRACTIC',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CLEANING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COMPANY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSTRUCTION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSULT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COOPERATIVE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CABLEVISION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COMMUNITY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CMNTY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COMMUNICATIONS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COUNTRY CLUB',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COUNTY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CREDIT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DEVELOPMENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DETROIT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DVLPMNTL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DISTRICT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DISTRIBUTING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DIVISION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ELEVATOR',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ENTERPRISE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ENGINEERING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ESTATES',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'EQUIPMENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'EQUITY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'EXCAVATING',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'EXPRESS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FINANCIAL',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FINANCE',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FABRICATORS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FREIGHTLINER',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FREIGHT',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FULLFILLMENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FULFILLMENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FUNERAL HOME',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FURNITURE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'GOVERNMENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'GVRNMNT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'GROWERS',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DEVELOPMENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DVLPMNTL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'FREIGHT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'HEALTHCARE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INNOVATIVE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'HOSPICE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),' HOSPITAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INDUSTRIES',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INSTITUTE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INDUSTRIAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INTERNATIONAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INTERIORS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INVESTMENTS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'LANDSCAPING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'LEASING',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'LEASE',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'LIMITED',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MACHINE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MANAGEMENT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MATUSHITA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MATSUSHITA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MISSIONARY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MINISTRIES',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MNGMNT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MOBILE PARK',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MOBILE HOME',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MOUNTAIN',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'NATIONAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'OPTICAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PACKAGING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PARTNERSHIP',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PEDIATRICS',1) > 0 => 'Y',  
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PEER REVIEW',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PHARMACY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PHARMACEUTICAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PENSION PLAN',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PRODUCTIONS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PROFESSIONAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PROPERTIES',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'RAILROAD',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'REALTY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'REBUILDERS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'REPAIR',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'RESTARAUNT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'RESTAURANT',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SAVINGS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SECURITIES',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SEAFOOD',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SERVICES',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SOLUTION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SPECIALTY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SQUARE',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SYSTEMS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'STATE BANK',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SPECIALIST',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SPRCNTR',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SCHOOL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SUPERCENTER',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SUPPLY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SURGERY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TELEPHONE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TRAVEL',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TRADE NAME',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TRUCKING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TRANSPORT',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TECHNOLOGY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TRANSPORTATION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TRANSMISSION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'STORAGE',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TRANSPORT',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'VALLEY',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'WAREHOUSE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'WELLS FARGO',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AGENCY',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MARKET',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SALES',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'RADIO',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COUNCIL',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PARTNERS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PLAZA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CLINIC',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CENTER',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'REPAIR',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TRUST',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INC',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INC.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INC',1) > 0 => 'Y',
							 StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),' LLC',1) > 0 => 'Y',
							 StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'L L C',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'LTD',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'LLP',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'L L P',1) > 0 => 'Y',
						//StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'LP',1) > 0 => 'Y',
						  StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'AFRICA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'L.P.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'BANK N.A.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'BANK NA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'N.A.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'N. A.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'N A',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'N.A.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'N. A.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PSC',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'P S C',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'F S B',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CITY',1) > 0 => 'Y',  
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COUNTY',1) > 0 => 'Y',  
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'STATE',1) > 0 => 'Y',  
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PROVINCE',1) > 0 => 'Y',  
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'LIQUOR',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CORP',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'OFFICE',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DELI',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MOTEL',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),' INN',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),' USA',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),' U S A',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),' & SONS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SH.P.K.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SISTEMAS',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSULTING',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DIGIDATA',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'UNIVERSAL',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TECHNOLOGIES',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'EQUIPOS',1) > 0 => 'Y', 
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),' THE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ASOCIADOS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SOLUCIONES',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SNC-LAVALIN',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SOCIETE',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'HOLDINGS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CENTRAL',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INTREPRINDEREA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CABINET',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DE FORMATION',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'HOLDING',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TECNOLOGIA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'S.A.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'S.L.',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'GRANDS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PLUS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MODERN',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'R&B',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ITANSUCA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'TIPAZA',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'GROUP',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'DIGITAL',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                     
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSTRUCCION',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                               
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CIVIL',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                       
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INFRAESTRUCTURA',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                  
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SERVICIOS',1) > 0 => 'Y',
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PROFESIONALES  ',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                     
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'MEXICO',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                    
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PORTUGAL',1) > 0 => 'Y',                                                                                                                                                                                                                                                                            
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'ITALIA',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                             
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CHILE',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                          
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSTRUCCION',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                          
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COSTA RICA',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                              
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PROJECTOS',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSTRUCOES',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                               
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SERVICOS',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                       
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'WATER AND POWER',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                            
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SERVICIOS',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                   
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSTRUCCIONES',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                     
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSTRUCTORA',1) > 0 => 'Y',  
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'INVESTMENT',1) > 0 => 'Y',  
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSUL',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                   
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'POSTRISORT',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                     
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PT SNC LAVALIN TPS',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                              
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'VENEZUELA',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                        
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'COINPRO, SC',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                                     
							StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'PT.',1) > 0 => 'Y',  
              StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'CONSORCIO ROPRUCSA',1) > 0 => 'Y',                                                                                                                                                                                                                                                                                                                                            
              StringLib.StringFind(StringLib.StringToUpperCase(clean_orig_pty_name_10),'SWECO ENVIRONMENT AB',1) > 0 => 'Y',   							 
							 
					  	'');
    													
self := [];
end;

normalizer_fire_count := PROJECT(filter_Worldbank_Debarred,tr_normalizer_fire_count(left,counter));

OutRec := record
string name_format;
string name_normalized;
layout_normalizer_fire_count;
end;

OutRec NormIt(normalizer_fire_count L, integer C) := TRANSFORM
								 
name_format := trim(map(
                       l.normalizer_fire_count = 1 => '(.*)', 
                        l.normalizer_fire_count = 2 => '(.*)(~)(.*)',
												 l.normalizer_fire_count = 3 => '(.*)(~)(.*)(~)(.*)','(.*)(~)(.*)(~)(.*)(~)(.*)'
													  )
														  ,left,right);

self.name_format := name_format;

self.name_normalized :=  choose(C, trim(regexreplace(name_format,l.orig_pty_name,'$1'),left,right),
											             trim(regexreplace(name_format,l.orig_pty_name,'$3'),left,right),
											             trim(regexreplace(name_format,l.orig_pty_name,'$5'),left,right),
											             trim(regexreplace(name_format,l.orig_pty_name,'$7'),left,right)
                          		 );

self.name_type := choose(C, 'Primary',
											      'AKA',
											      'AKA',
											      'AKA'
                          		 );
self :=l;															 
															 
end;

Norm_names :=
     normalize(normalizer_fire_count,left.normalizer_fire_count,NormIt(left,counter));
//output(choosen(Norm_names,all), named('Norm_names'));

Patriot_preprocess.layout_patriot_common tr_patriot_common(Norm_names l) := TRANSFORM 
 self.orig_pty_name := l.name_normalized;
 self := l;
 end;

patriot_common := PROJECT(Norm_names,tr_patriot_common(left));

EXPORT Mapping_Worldbank_Debarred := patriot_common
         : persist('~thor::persist::out::patriot::preprocess::Worldbank_Debarred');
