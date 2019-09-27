
#OPTION('multiplePersistInstances',false);

DeniedPersons	:= 	DATASET('~thor::in::globalwatchlists::denied_persons', 
                             Layout_US_Bureau_of_Industry_And_Security_Denied_Persons.Layout_Denied_Persons_List, CSV(separator('\t') , heading(1),TERMINATOR(['\n', '\r\n'])))
														         (name <> 'Name and Address');	

//output(DeniedPersons, named('DeniedPersons'));

country_lkp := dataset('~thor::in::globalwatchlists::county_code_lookup',
	                      patriot_preprocess.layout_lookup.layout_country_name_code_alt_lkup , thor);
												
//output(choosen(country_lkp,all));		

Layout_Denied_Persons_add_country_code := record
string country_code; 
Layout_US_Bureau_of_Industry_And_Security_Denied_Persons.Layout_Denied_Persons_List;
end;

Layout_Denied_Persons_add_country_code tr_add_country_code(DeniedPersons l) := TRANSFORM

country_code_1 := trim(l.Street_Address[length(trim(l.Street_Address,left,right))-3..]);

contry_code := map( // type1 format
                     regexfind('(.*)( US,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( US,)( [0-9]+)',l.Street_Address,'$2'),
                     
										 regexfind('(.*)( ZA,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( ZA,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( FR,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( FR,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( JO,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( JO,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( KW,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( KW,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( SA,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( SA,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( DE,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( DE,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( PH,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( PH,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( CN,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( CN,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( IN,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( IN,)( [0-9]+)',l.Street_Address,'$2'),
										 
                     regexfind('(.*)( LB,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( LB,)( [0-9]+)',l.Street_Address,'$2'),  

										 regexfind('(.*)( TR,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( TR,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( BE,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( BE,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( ES,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( ES,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( IR,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( IR,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( AE,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( AE,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( SG,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( SG,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( AT,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( AT,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( RU,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( RU,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( ZA,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( ZA,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( TW,)( [0-9]+)',l.Street_Address)  
	                   => regexreplace('(.*)( TW,)( [0-9]+)',l.Street_Address,'$2'),
										 
										 // type2 format
										  regexfind('(.*)( GB,)(.*)',l.Street_Address)  
	                   => regexreplace('(.*)( GB,)(.*)',l.Street_Address,'$2'),	
										 
										 regexfind('(.*)( CH,)(.*)',l.Street_Address)  
	                   => regexreplace('(.*)( CH,)(.*)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( SE,)(.*)',l.Street_Address)  
	                   => regexreplace('(.*)( SE,)(.*)',l.Street_Address,'$2'),										 
										  
										 regexfind('(.*)( NL,)(.*)',l.Street_Address)  
	                   => regexreplace('(.*)( NL,)(.*)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( DE,)(.*)',l.Street_Address)  
	                   => regexreplace('(.*)( DE,)(.*)',l.Street_Address,'$2'),
										 
										 regexfind('(.*)( KR,)(.*)',l.Street_Address)  
	                   => regexreplace('(.*)( KR,)(.*)',l.Street_Address,'$2'),	
										 
										 regexfind('(.*)( CA,)( US)',l.Street_Address)  
	                   => regexreplace('(.*)( CA,)( US)',l.Street_Address,'$3'),  
										 
										 regexfind('(.*)( CA,)(.*)',l.Street_Address)  
	                   => regexreplace('(.*)( CA,)(.*)',l.Street_Address,'$2'),
										 
                     // type3 format
                     regexfind('(, )([A-Z]+)',country_code_1)
										 => country_code_1,
       							
							       '');

self.country_code := StringLib.StringFilter(contry_code, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
self := l;
end;

add_country_code := PROJECT(DeniedPersons,tr_add_country_code(left));	
//output(add_country_code);

join_Denied_Persons_and_country_lkp :=
                join(add_country_code,country_lkp,
								        left.country_code = right.country_code,left outer);

Patriot_preprocess.layout_patriot_common tr_patriot_common(join_Denied_Persons_and_country_lkp l, integer c) := TRANSFORM

 
   Street_Address_1 :=  map(regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = false  
                             and  regexfind('(.*)( US,)( [0-9]+)',l.Street_Address) = true	        								 
												        => regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$1'),
																
															regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = false  
                                and regexfind('(.*)(, )(.*)(, )(CA,)( US)',l.Street_Address) = true
																 => regexreplace('(.*)(, )(.*)(, )(CA,)( US)',l.Street_Address,'$1'),																 
                             
														 
														 	regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('UPON THE DATE OF THE ORDER INCARCERATED AT USM NO:(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$5'),
																	
											     	regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('UPON THE DATE OF THE ORDER INCARCERATED AT OAKDALE FDC, FEDERAL BUREAU OF PRISONS(.*)(US,)(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$5'),
																																 
																														
															regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('UPON THE DATE OF THE ORDER INCARCERATED AT FEDERAL CORRECTION INSTITUTE(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$3'),
																		
											    		regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('UPON THE DATE OF THE ORDER INCARCERATED AT FCI ALLENWOOD LOW FEDERAL CORRECTIONAL INSTITUTION(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )([A-Z0-9. ]+)(\\()(.*)(\\))(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$3'),
					                     
															regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('INMATE NUMBER|FEDERAL CORRECTIONAL INSTITUTION(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )([A-Z0-9. ]+)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$7'),
					                     
															regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('CURRENTLY INCARCERATED AT|INMATE NUMBER(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )([A-Z0-9. ]+)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$5'),	 
																														 
                             regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('INMATE #(.*)FEDERAL CORRECTIONAL INSTITUTION(.*)(US,)(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )([A-Z0-9. ]+)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$7'),
					                     	
															regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('INMATE #(.*)CORRECTIONAL INSTITUTION(.*)(US,)(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )([A-Z0-9. ]+)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$7'),
					                    	
																 regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('(.*)(SUITE)(.*)(US,)(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$1$2$3'),
					                     
																 
																 'use_raw_street');
												    
 
	 Street_Address_2 :=  map(regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = false  
                             and  regexfind('(.*)( US,)( [0-9]+)',l.Street_Address) = true	        								 
												        => regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$3$4$5$8$9'),
                             
														  regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = false  
                                and regexfind('(.*)(, )(.*)(, )(CA,)( US)',l.Street_Address) = true
																 => regexreplace('(.*)(, )(.*)(, )(CA,)( US)',l.Street_Address,'$3$4$5')	,	
																
                          													
													regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('UPON THE DATE OF THE ORDER INCARCERATED AT USM NO:(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$7$8$9$10$13'),														
																																
																				
                                regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('UPON THE DATE OF THE ORDER INCARCERATED AT OAKDALE FDC, FEDERAL BUREAU OF PRISONS(.*)(US,)(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$7$8$9$10$13'),									
															
															
															regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('UPON THE DATE OF THE ORDER INCARCERATED AT FEDERAL CORRECTION INSTITUTE(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$5$6$7$8$11'),																
																
															
															 regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('UPON THE DATE OF THE ORDER INCARCERATED AT FCI ALLENWOOD LOW FEDERAL CORRECTIONAL INSTITUTION(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )([A-Z0-9. ]+)(\\()(.*)(\\))(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$8$9$10$11$14'),																
																
																
																	 regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('INMATE NUMBER|FEDERAL CORRECTIONAL INSTITUTION(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )([A-Z0-9. ]+)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$9$10$11$12$15'),																
																
																
																 regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('CURRENTLY INCARCERATED AT|INMATE NUMBER(.*)US,(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )([A-Z0-9. ]+)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$7$8$9$10$13'),																
																
																regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('INMATE #(.*)FEDERAL CORRECTIONAL INSTITUTION(.*)(US,)(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )([A-Z0-9. ]+)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$9$10$11$12$15'),
															
															 regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('INMATE #(.*)CORRECTIONAL INSTITUTION(.*)(US,)(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )([A-Z0-9. ]+)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$9$10$11$12$15'),
															
															regexfind('JAIL|P.O. BOX|SUITE|UPON THE DATE OF THE ORDER|INMATE|CURRENTLY INCARCERATED AT|UNIVISION TECHNOLOGY|SUIE',l.Street_Address) = true  
																 and  regexfind('(.*)(SUITE)(.*)(US,)(.*)',l.Street_Address) = true
																	=> regexreplace('(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)(, )(.*)',l.Street_Address,'$5$6$7$8$11'),
															
																
																
																 'use_raw_street');
	
	addr_1 := map(Street_Address_1 = 'use_raw_street' => l.Street_Address[1..50],Street_Address_1);
   addr_2 := map(Street_Address_2 = 'use_raw_street' => l.Street_Address[51..100],Street_Address_2);
   addr_3 := map(Street_Address_1 = 'use_raw_street' =>  l.Street_Address[101..150],'');
   addr_4 := map(Street_Address_1 = 'use_raw_street' =>  l.Street_Address[151..200],'');
   addr_5 := map(Street_Address_1 = 'use_raw_street' =>  l.Street_Address[201..250],'');
								
	remarks_1 := if(l.eff_date <> '', 'Effective Date: ' + l.eff_date, '');
  remarks_2 := if(l.exp_date <> '', 'Expiration Date: ' + l.exp_date, '');  
  remarks_3 := if(l.country_name_short <> '', 'Country: ' + l.country_name_short, '');
  remarks_4 := if(trim(l.standard_order) <> '', 'Denial Order: ' + trim(l.standard_order),'');
	
	federal_citation_remarks := if(trim(l.federal_citation) <> '', trim(l.federal_citation), '');
	remarks_5 := federal_citation_remarks[1..75];
	remarks_6 := federal_citation_remarks[76..];
	
  left_pad_with_zeros := map(length((string) c) = 1 => '00',
                           length((string) c) = 2 => '0', '');

  pty_key := 'DPL' + trim(left_pad_with_zeros,left,right) + (string) c;	
	
	self.name_type := 'Primary';
  self.pty_key := pty_key;
  self.source := 'US Bureau of Industry and Security - Denied Person List';
	self.orig_pty_name := if(length(trim(l.Name)) > 54,
	                           trim(l.Name)[1..StringLib.StringFind(trim(l.Name),',',1)-1]
                                                      ,trim(l.Name));
	self.country := map(l.country_name_short <> '' => l.country_name_short,l.country_code);																										
	self.addr_1 := addr_1;
  self.addr_2 := addr_2;		
	self.addr_3 := addr_3;	
	self.addr_4 := addr_4;	
	self.addr_5 := addr_5;	
	self.remarks_1 := remarks_1;
	self.remarks_2 := remarks_2;
	self.remarks_3 := remarks_3;
	self.remarks_4 := remarks_4;
	self.remarks_5 := remarks_5;	
	self.remarks_6 := remarks_6;
	
  // entity_string1 := 'ELECTRICAL|ELECTRONIC|NETWORK| DIGITAL | TECHNIK |SHIPPING|TELECOM| GMBH|ING. DIETMAR|INTERNATIONAL| METALS | TRADE | GLOBE | INTL | AB | AG | NV |COMMUNICATION|CORPORATE|ACCOUNTS|AMBULANCE|AMERICAN|NORTHERN|SOUTHERN|ADMINISTRATION|ALIGNMENT|AMUSEMENT|ANTIQUE|APARTMENTS|';
  // entity_string2 := 'REVOLUTIONARY|ORGANIZATION|ORGANISATION|APLC|ARCHITECT|ARCHETECT|AIR CONDITIONING|APPLIANCE|ASSOCIATES|ASSOCIATION|AS AGENT|AUTOMOTIVE|AVIATION|AIRLINES|BOOKKEEPING|BOOKBINDER|BROKERAGE| BROKERS |BUILDING|BUSINESS|BOUTIQUE|CHEMICAL|COMPUTER|CORPORATION|CORP.|CARBURETOR|CHIROPRACTIC|CLEANING|COMPANY|CONSTRUCTION|CONST.|';
  // entity_string3 := 'CONSULTANTS|COOPERATIVE|COTRICOM S.A.|CABLEVISION|COMMUNITY|CMNTY|COMMUNICATIONS|COUNTRY CLUB| COUNTY | CREDIT |DEVELOPMENT|DETROIT|DVLPMNTL|DISTRICT|DISTRIBUTION|DISTRIBUTING|DIVISION|ELEVATOR|ENTERPRISE|ENGINEERING|ESTATES|EQUIPMENT|EQUITY|EXCAVATING|EXPRESS|FINANCIAL |FINANCE|'; 
  // entity_string4 := 'FABRICATORS|FREIGHTLINER|FREIGHT |FULLFILLMENT|FULFILLMENT|FUNERAL HOME|FURNITURE|GOVERNMENT|GVRNMNT| GROWERS |DEVELOPMENT|DVLPMNTL|FREIGHT|HEALTHCARE|HELLING KG|HM-EDV|INNOVATIVE|HOSPICE| HOSPITAL|INDUSTRIES|INSTITUTE|INDUSTRIAL|INTERNATIONAL|INTERIORS|INVESTMENTS|KINTRACO|';
  // entity_string5 := 'LABORATOR|LANDSCAPING| LEASING | LEASE |LIMITED|MACHINE|MANAGEMENT|MATUSHITA|MATSUSHITA|MISSIONARY|MINISTRIES|MNGMNT|MOBILE PARK|MOBILE HOME|MOUNTAIN|NATIONAL|OPTICAL|PACKAGING|PARTNERSHIP|PEDIATRICS|PEER REVIEW|PHARMACY|PHARMACEUTICAL|PENSION PLAN|PRODUCTIONS|PROFESSIONAL|PROPERTIES|';
  // entity_string6 := 'RAILROAD|REALTY|REBUILDERS|REPAIR|RESTARAUNT|RESTAURANT|SAVINGS|SECURITIES|SEAFOOD|SERVICES|SOCIETE |SOLUTION|SPECIALTY| SQUARE |SUNITRON|SYSTEM|SYSTEM|STATE BANK|SPECIALIST|SPRCNTR|SCHOOL|SUPERCENTER|SUPPLIES|SUPPLY|SURGERY|TELEPHONE|TRAVEL |TRADE NAME|TRUCKING| TRANSPORT |TECHNOLOG|TRANSPORTATION|TRANSMISSION|';
  // entity_string7 := 'UNIVERSITY| STORAGE | TRANSFER | TRANSPORT |VALLEY |WAREHOUSE|WELLS FARGO| AGENCY| MARKET | SALES | RADIO| COUNCIL | PARTNERS| PLAZA| CLINIC| CENTER | REPAIR | SERVICE | GROUP | TRUST | INC | INC.|,INC |,INC. | LLC| L L C| LTD| LLP| L L P| LP| L.P.|BANK N.A.|BANK NA|N.A.|, N. A.|, N A|,N.A.|,N. A.| PSC|';
  // entity_string8 := 'P S C| F S B|CITY OF|COUNTY OF |STATE OF |PROVINCE OF |LIQUOR | CORP | OFFICE | DELI | MOTEL | INN | USA | U S A | AND SONS| & SONS| THE|'; 
  // entity_string9 := 'COOLING TOWERS|TRADING|DESARROLLOS IND|SYNAPTIX.NET|SKY BLUE|PETROM|INTERNACIONAL|TRADE|S.L|GROUP|RESULTS|ELMONT AG|SATS|DATASAAB CONTRACTING AB|THANE-COAT, INC|GLOBE|METALS|MKTG CO|MOTORS|NET CORP|AIRCRAFT|PRODUCTS|S.A|ELMONT INT|XTREME';  
	// concat_entity := entity_string1 + entity_string2 + entity_string3 + entity_string4 + entity_string5 + entity_string6  + entity_string7  + entity_string8 + entity_string9; 
  
  
  // keep_as_names_overide := 
						// ['ZHANG, MING SUAN',                                                                                                                                                                                                                                                                                                                                              
						// 'SIMMONS, ALAN C. T.',                                                                                                                                                                                                                                                                                                                              
						// 'STASHYNSKI, ALIAKSANDR',                                                                                                                                                                                                                                                                                                                                        
						// 'NEDIM SULYAK',                                                                                                                                                                                                                                                                                                                                                  
						// 'SULYAK, NEDIM',                                                                                                                                                                                                                                                                                                                                                 
						// 'AVANESSIAN, JIRAIR HIJIABADI',                                                                                                                                                                                                                                                                                                                                  
						// 'IHSAN MEDHAT SAMMY ELASHI',                                                                                                                                                                                                                                                                                                                                     
						// 'MUSTAFA, YAUDAT',                                                                                                                                                                                                                                                                                                                                               
						// 'BANIAMERY, DAVOUD',                                                                                                                                                                                                                                                                                                                                             
						// 'ISSAM ANWAR',                                                                                                                                                                                                                                                                                                                                                   
						// 'AIMAN AMMAR',                                                                                                                                                                                                                                                                                                                                                   
						// 'DUBOUSKAYA, VOLHA',                                                                                                                                                                                                                                                                                                                                             
						// 'BANIAMERI, DAVOUD',                                                                                                                                                                                                                                                                                                                                             
						// 'FLIDER, PAVEL SEMENOVICH',                                                                                                                                                                                                                                                                                                                                      
						// 'SALINAS-LUCIO, MARIO',                                                                                                                                                                                                                                                                                                                           
						// 'FLIDER, GENNADIY',                                                                                                                                                                                                                                                                                                                                              
						// 'VIACHESLAV ZHUKOV',                                                                                                                                                                                                                                                                                                                                             
						// 'TALYI, YAUDAT MUSTAFA',                                                                                                                                                                                                                                                                                                                                         
						// 'SABERI, MOSTAFA',                                                                                                                                                                                                                                                                                                                           
						// 'SALGADO-GUZMAN, ERNESTO',                                                                                                                                                                                                                                                                                                                                       
						// 'GREENOE, STEVEN NEAL',                                                                                                                                                                                                                                                                                                                                          
						// 'NAGHIBI, (SEAN)',                                                                                                                                                                                                                                                                                                                                               
						// 'ALI ESLAMIAN',                                                                                                                                                                                                                                                                                                                                                  
						// 'ALMEIDA, LUIS ALEJANDRO YANEZ',                                                                                                                                                                                                                                                                                                                                 
						// 'BAHAR SAFWA GENERAL TRADING',                                                                                                                                                                                                                                                                                                                                   
						// 'ISSAM SHAMMOUT',                                                                                                                                                                                                                                                                                                                                                
						// 'AVANESSIAN, JIRAIR H.',                                                                                                                                                                                                                                                                                                                                         
						// 'BANIAMERI, DAVID',                                                                                                                                                                                                                                                                                                                                              
						// 'LARRISON, JAMES ALLEN',                                                                                                                                                                                                                                                                                                                                         
						// 'AL-MASHAN, MOHAMMAD',                                                                                                                                                                                                                                                                                                                                           
						// 'BANIAMERY, DAVID',                                                                                                                                                                                                                                                                                                                                              
						// 'RUF S. LOPEZ S.A',                                                                                                                                                                                                                                                                                                                                             
						// 'RODRIGUEZ-ARANDA, GREGORIO',                                                                                                                                                                                                                                                                                                                                    
						// 'CASTANEDA, IVON',                                                                                                                                                                                                                                                                                                                                               
						// 'ARASTAFAR, KIARASH',                                                                                                                                                                                                                                                                                                              
						// 'ELASHI, GHASSAN',                                                                                                                                                                                                                                                                                                                                               
						// 'SALEM, MAJIDA',                                                                                                                                                                                                                                                                                                                                                 
						// 'FLIDER, GENNADIY SEMENOVICH',                                                                                                                                                                                                                                                                                                                                   
						// 'EMENIKE NWANKWOALA',                                                                                                                                                                                                                                                                                                                                            
						// 'CORTEZ-SALGADO, DEMETRIO',                                                                                                                                                                                                                                                                                                                                      
						// 'ANDY FARMER',                                                                                                                                                                                                                                                                                                                                                   
						// 'TEHRANI, MOSTAFA SABERI',                                                                                                                                                                                                                                                                                                                                       
						// 'EMENIKE CHARLES NWANKWOALA',                                                                                                                                                                                                                                                                                                                                    
						// 'AVANESSIAN, JIRAIR',                                                                                                                                                                                                                                                                                                          
						// 'MUHAMMAD ISAM MUHAMMAD ANWAR NUR SHAMMOUT',                                                                                                                                                                                                                                                                            
						// 'ASSI, FAWZI MUSTAPHA',                                                                                                                                                                                                                                                                                                                                          
						// 'AVANESSIAN, JERRY',                                                                                                                                                                                                                                                                                                                                             
						// 'LEV STEINBERG',                                                                                                                                                                                                                                                                                                                                                 
						// 'AYMAN AMMAR',                                                                                                                                                                                                                                                                                                                                      
						// 'SILCOX, ANDREW',                                                                                                                                                                                                                                                                                                                                                
						// 'FLIDER, PAVEL',                                                                                                                                                                                                                                                                                                                              
						// 'NAGHIBI, AFSHIN (SEAN)',                                                                                                                                                                                                                                                                                                           
						// 'MANZARPOUR, ALI AGAR',                                                                                                                                                                                                                                                                                                                                          
						// 'MAGHAZEHE, BENJAMIN',                                                                                                                                                                                                                                                                                                                                           
						// 'ELYAZGI, NAJMEDDIN A.',                                                                                                                                                                                                                                                                                                                                         
						// 'JEFFREY JOHN JAMES ASHFIELD',                                                                                                                                                                                                                                                                                                                                   
						// 'ELASHI, BASMAN',                                                                                                                                                                                                                                                                                                                                                
						// 'NAJMEDDIN A. ELYAZGI',                                                                                                                                                                                                                                                                                                                                          
						// 'COLLINS-AVILA, LUIS ARMANDO'];                                                                                                                                                                                                                                                                                                                                   
	
	
	// self.entity_flag := map(l.Name in keep_as_names_overide => '',
                          // regexfind(concat_entity,l.Name,nocase) = true => 'Y','');
			
		self.entity_flag :=
	      map(
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ELECTRICAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ELECTRONIC',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'NETWORK',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DIGITAL ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TECHNIK ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SHIPPING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TELECOM',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'GMBH',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ING. DIETMAR',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INTERNATIONAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'METALS ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRADE ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'GLOBE ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INTL ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AB ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AG ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'NV ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COMMUNICATION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CORPORATE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ACCOUNTS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AMBULANCE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AMERICAN',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'NORTHERN',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SOUTHERN',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ADMINISTRATION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ALIGNMENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AMUSEMENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ANTIQUE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'APARTMENTS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'REVOLUTIONARY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ORGANIZATION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ORGANISATION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'APLC',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ARCHITECT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ARCHETECT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AIR CONDITIONING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'APPLIANCE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ASSOCIATES',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ASSOCIATION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AS AGENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AUTOMOTIVE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AVIATION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AIRLINES',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'BOOKKEEPING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'BOOKBINDER',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'BROKERAGE',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'BROKERS ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'BUILDING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'BUSINESS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'BOUTIQUE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CHEMICAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COMPUTER',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CORPORATION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CORP.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CARBURETOR',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CHIROPRACTIC',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CLEANING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COMPANY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CONSTRUCTION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CONST.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CONSULTANTS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COOPERATIVE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COTRICOM S.A.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CABLEVISION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COMMUNITY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CMNTY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COMMUNICATIONS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COUNTRY CLUB',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COUNTY ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CREDIT ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DEVELOPMENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DETROIT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DVLPMNTL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DISTRICT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DISTRIBUTION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DISTRIBUTING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DIVISION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ELEVATOR',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ENTERPRISE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ENGINEERING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ESTATES',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'EQUIPMENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'EQUITY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'EXCAVATING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'EXPRESS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FINANCIAL ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FINANCE',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FABRICATORS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FREIGHTLINER',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FREIGHT ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FULLFILLMENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FULFILLMENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FUNERAL HOME',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FURNITURE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'GOVERNMENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'GVRNMNT',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'GROWERS ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DEVELOPMENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DVLPMNTL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'FREIGHT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'HEALTHCARE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'HELLING KG',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'HM-EDV',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INNOVATIVE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'HOSPICE',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'HOSPITAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INDUSTRIES',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INSTITUTE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INDUSTRIAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INTERNATIONAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INTERIORS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INVESTMENTS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'KINTRACO',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LABORATOR',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LANDSCAPING',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LEASING ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LEASE ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LIMITED',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MACHINE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MANAGEMENT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MATUSHITA',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MATSUSHITA',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MISSIONARY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MINISTRIES',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MNGMNT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MOBILE PARK',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MOBILE HOME',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MOUNTAIN',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'NATIONAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'OPTICAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PACKAGING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PARTNERSHIP',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PEDIATRICS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PEER REVIEW',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PHARMACY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PHARMACEUTICAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PENSION PLAN',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PRODUCTIONS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PROFESSIONAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PROPERTIES',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'RAILROAD',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'REALTY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'REBUILDERS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'REPAIR',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'RESTARAUNT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'RESTAURANT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SAVINGS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SECURITIES',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SEAFOOD',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SERVICES',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SOCIETE ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SOLUTION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SPECIALTY',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SQUARE ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SUNITRON',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SYSTEM',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SYSTEM',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'STATE BANK',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SPECIALIST',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SPRCNTR',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SCHOOL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SUPERCENTER',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SUPPLIES',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SUPPLY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SURGERY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TELEPHONE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRAVEL ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRADE NAME',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRUCKING',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRANSPORT ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TECHNOLOG',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRANSPORTATION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRANSMISSION',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'UNIVERSITY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'STORAGE ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRANSFER ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRANSPORT ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'VALLEY ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'WAREHOUSE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'WELLS FARGO',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AGENCY',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MARKET ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SALES ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'RADIO',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COUNCIL ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PARTNERS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PLAZA',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CLINIC',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CENTER ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'REPAIR ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SERVICE ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'GROUP ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRUST ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INC ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INC.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),',INC ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),',INC. ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LLC',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'L L C',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LTD',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LLP',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'L L P',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LP',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'L.P.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'BANK N.A.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'BANK NA',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'N.A.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),', N. A.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),', N A',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),',N.A.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),',N. A.',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PSC',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'P S C',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'F S B',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CITY OF',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COUNTY OF ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'STATE OF ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PROVINCE OF ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'LIQUOR ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'CORP ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'OFFICE ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DELI ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MOTEL ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INN ',1) > 0 => 'Y', 
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'USA ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'U S A ',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AND SONS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'& SONS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'THE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'COOLING TOWERS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRADING',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DESARROLLOS IND',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SYNAPTIX.NET',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SKY BLUE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PETROM',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'INTERNACIONAL',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'TRADE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'S.L',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'GROUP',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'RESULTS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ELMONT AG',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'SATS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'DATASAAB CONTRACTING AB',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'THANE-COAT, INC',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'GLOBE',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'METALS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MKTG CO',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'MOTORS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'NET CORP',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'AIRCRAFT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'PRODUCTS',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'S.A',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'ELMONT INT',1) > 0 => 'Y',
					StringLib.StringFind(StringLib.StringToUpperCase(l.Name),'XTREME',1) > 0 => 'Y',
					
					'');
										
	self := [];
	end;
	
	patriot_common := PROJECT(join_Denied_Persons_and_country_lkp,tr_patriot_common(left, counter));	
		
  patriot_common_primary_only := patriot_common(regexfind('A.K.A|"',orig_pty_name) = false);	 
	
	patriot_common_primary_and_aka := patriot_common(regexfind('A.K.A|"',orig_pty_name) = true);	 
 
  // Parse to get primary  	
	 Patriot_preprocess.layout_patriot_common tr_primary(patriot_common_primary_and_aka l) := TRANSFORM
	
	 self.orig_pty_name := 
	                    trim(
										   regexreplace('  ',     
	                        map(	
	                         regexfind('A.K.A',l.orig_pty_name) = true
                            => regexreplace('(.*)(\\(A.K.A.)(.*)(\\))',l.orig_pty_name,'$1'),	
														     regexfind('"',l.orig_pty_name) = true
	                               => regexreplace('(.*)(")(.*)(")(.*)',l.orig_pty_name,'$1$5'),
																 l.orig_pty_name)																 
																  ,' ')
																	,left, right);															
															
	self.name_type := 'Primary'; 
	self := l;
	end;
	
	patriot_common_primary_rec := PROJECT(patriot_common_primary_and_aka,tr_primary(left));	
	
  // Parse to get AKA
	Patriot_preprocess.layout_patriot_common tr_aka(patriot_common_primary_and_aka l) := TRANSFORM
	
	self.orig_pty_name := trim(
	                        map(	
	                         regexfind('A.K.A',l.orig_pty_name) = true
                            => regexreplace('(.*)(\\(A.K.A.)(.*)(\\))',l.orig_pty_name,'$3'),	
														     regexfind('"',l.orig_pty_name) = true
	                               => regexreplace('(.*)(")(.*)(")(.*)',l.orig_pty_name,'$3'),
																 l.orig_pty_name)
																 ,left, right);																													
	self.name_type := 'AKA'; 
	self := l;
	end;
	
	patriot_common_aka_rec := PROJECT(patriot_common_primary_and_aka,tr_aka(left));	

	
EXPORT Mapping_US_Bureau_of_Industry_And_Security_Denied_Persons := patriot_common_primary_only
                                                                    + patriot_common_primary_rec
																																		+ patriot_common_aka_rec
          : persist('~thor::persist::out::patriot::preprocess::US_Bureau_of_Industry_And_Security_Denied_Persons');	