
#OPTION('multiplePersistInstances',false);

import Address;

entites	:= 	DATASET('~thor::in::globalwatchlists::osfi_canada::entities', 
                             Layout_OSFI_Canada_Entities_of_Concern.layout_entities, CSV(separator('\t') , heading(5), TERMINATOR(['\n', '\r\n'])))(id <> ''  );	
                              //(regexfind('188.',id) = true and id <> '');

//output(entites, named('entites'));

individuals	:= 	DATASET('~thor::in::globalwatchlists::osfi_canada::individuals', 
                             Layout_OSFI_Canada_Entities_of_Concern.layout_individuals, CSV(separator('\t') , heading(6),quote('"'), TERMINATOR(['\n', '\r\n'])))(id <> '');

//output(individuals, named('individuals'));

//****** set up address and count
Layout_OSFI_Canada_Entities_of_Concern.layout_parse_address_and_count 
                                                    tr_parse_address_and_count(entites l) := TRANSFORM

reformat_address := StringLib.StringFindReplace(
                 StringLib.StringFindReplace(
								  StringLib.StringFindReplace(
                  StringLib.StringFindReplace(
									  StringLib.StringFindReplace(
										  StringLib.StringFindReplace(
											  StringLib.StringFindReplace(
												  StringLib.StringFindReplace(
													  StringLib.StringFindReplace(
														  StringLib.StringFindReplace(
															  StringLib.StringFindReplace(
                                                         l.Address
                                                        ,'Italy, Fiscal'
                                                        ,'Italy;Fiscal')
                                                          ,'United Kingdom, Email address'
                                                          ,'United Kingdom;Email address')
                                                             ,'Alternate Address: '
                                                             ,';')
                                                               ,'a) '
                                                               ,';')
                                                                ,'b) '
                                                                ,';')
                                                                 ,'c) '
                                                                  ,';')
                                                                    ,'d) '
                                                                    ,';')
                                                                    ,'e) '
                                                                     ,';')
                                                                      ,'f) '
                                                                       ,';')
																																			   ,'; Branch Office'
																																				  ,';Branch Office')
																																					 ,' Branch Office'
																																				    ,';Branch Office')
																																				   ;
																																			 

addresses_parsed := map(StringLib.StringFind(reformat_address, ';', 16) > 0
                        => reformat_address[1..StringLib.StringFind(reformat_address, ';', 16)-1],
												    reformat_address);
												
addresses_no_parsed := map(StringLib.StringFind(reformat_address, ';', 16) > 0
															=> reformat_address[StringLib.StringFind(reformat_address, ';', 16)..], '');																																				 
																														 

self.addresses_parsed := trim(addresses_parsed,left,right);
self.addresses_no_parsed := trim(addresses_no_parsed,left,right);
self.Address_Count := StringLib.StringFindCount(StringLib.StringFilter(addresses_parsed,';'),';');
self := l;
end;

parse_address_and_count := PROJECT(entites,tr_parse_address_and_count(left));
//output(parse_address_and_count, named('parse_address_and_count'));

////////******** add normalizer fire count 
layout_add_normalizer_fire_count  := record
integer normalizer_fire_count;
Layout_OSFI_Canada_Entities_of_Concern.layout_parse_address_and_count;
end;

layout_add_normalizer_fire_count  tr_add_normalizer_fire_count (parse_address_and_count l ) := TRANSFORM

self.normalizer_fire_count := l.Address_Count + 1;
self := l;
end;

ds_normalizer_fire_count  := PROJECT(parse_address_and_count,tr_add_normalizer_fire_count (left));
//output(ds_normalizer_fire_count);
// output(sort(ds_normalizer_fire_count,-normalizer_fire_count),named('max_norm_count'));

OutRec := record
string address_format;
//string address;
layout_add_normalizer_fire_count;
end;
 
//aa := ds_normalizer_fire_count(addresses_no_parsed <> ''); 
 
OutRec NormIt(ds_normalizer_fire_count L, integer C) := TRANSFORM

								 
address_format := trim(map(l.normalizer_fire_count = 1 => '(.*)', 
                        l.normalizer_fire_count = 2 => '(.*)(;)(.*)',
												 l.normalizer_fire_count = 3 => '(.*)(;)(.*)(;)(.*)',
												  l.normalizer_fire_count = 4 => '(.*)(;)(.*)(;)(.*)(;)(.*)',
													 l.normalizer_fire_count = 5 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
													  l.normalizer_fire_count = 6 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
														 l.normalizer_fire_count = 7 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
														  l.normalizer_fire_count = 8 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
															 l.normalizer_fire_count = 9 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
															  l.normalizer_fire_count = 10 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
																 l.normalizer_fire_count = 11 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
																  l.normalizer_fire_count = 12 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
																   l.normalizer_fire_count = 13 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
																    l.normalizer_fire_count = 14 => '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
																     l.normalizer_fire_count = 15=> '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)',
/*l.normalizer_fire_count = 16 => */  '(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)(;)(.*)'));
	


self.address_format := address_format;

self.address :=  trim(choose(C, regexreplace(address_format,l.addresses_parsed,'$1'),
											    regexreplace(address_format,l.addresses_parsed,'$3'),
											    regexreplace(address_format,l.addresses_parsed,'$5'),
											    regexreplace(address_format,l.addresses_parsed,'$7'),
											    regexreplace(address_format,l.addresses_parsed,'$9'),
											    regexreplace(address_format,l.addresses_parsed,'$11'),
											    regexreplace(address_format,l.addresses_parsed,'$13'),
											    regexreplace(address_format,l.addresses_parsed,'$15'),
											    regexreplace(address_format,l.addresses_parsed,'$17'),
											    regexreplace(address_format,l.addresses_parsed,'$19'),
													regexreplace(address_format,l.addresses_parsed,'$21'),
													regexreplace(address_format,l.addresses_parsed,'$23'),	
													regexreplace(address_format,l.addresses_parsed,'$25'),	
													regexreplace(address_format,l.addresses_parsed,'$27'),	
													regexreplace(address_format,l.addresses_parsed,'$29'),	
													regexreplace(address_format,l.addresses_parsed,'$31')	+ l.addresses_no_parsed
                          		 ),left,right);
self :=l;
end;

Norm_addresses :=
     normalize(ds_normalizer_fire_count,left.normalizer_fire_count,NormIt(left,counter));
//output(Norm_addresses);

Layout_OSFI_Canada_Entities_of_Concern.layout_clean_norm  tr_clean_norm(Norm_addresses l ) := TRANSFORM

self.entity := StringLib.StringFilter(StringLib.StringFindReplace(l.entity,'Ã¢â‚¬â„¢','\''),' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890()[]-_/\':;,!@%$^&*+=?<>.Ãƒâ‚¬ÃƒÂÃƒâ€šÃƒÆ’Ãƒâ€žÃƒâ€¦Ãƒâ€ Ãƒâ€¡ÃƒË†Ãƒâ€°ÃƒÅ Ãƒâ€¹ÃƒÅ’ÃƒÂÃƒÅ½ÃƒÂÃƒÂÃƒâ€˜Ãƒâ€™Ãƒâ€œÃƒâ€Ãƒâ€¢Ãƒâ€“Ãƒâ„¢ÃƒÅ¡Ãƒâ€ºÃƒÅ“ÃƒÂÃƒÂ ÃƒÂ¡ÃƒÂ¢ÃƒÂ£ÃƒÂ¤ÃƒÂ¥ÃƒÂ¦ÃƒÂ§ÃƒÂ¨ÃƒÂ©ÃƒÂªÃƒÂ«ÃƒÂ¬ÃƒÂ­ÃƒÂ®ÃƒÂ¯ÃƒÂ°ÃƒÂ±ÃƒÂ²ÃƒÂ³ÃƒÂ´ÃƒÂµÃƒÂ¹ÃƒÂºÃƒÂ»ÃƒÂ¼ÃƒÂ½ÃƒÂ¿');
self.last_vend_upd := 'test'; //:: '${OSFI_CANADA_ENTITIES_DATE}'; fix
self.Address := regexreplace(',$',StringLib.StringFindReplace(
                     if(regexfind('Fiscal Code|See various addresses|other locations within|Other foreign locations|A branch of GIA|Registration number|formerly c/o|Company dissolved|Liquidated and deleted|In liquidation|Email address|E-mail|Regional offices|http://|Closed by Bosnian|Charity number',l.Address) = false,trim(l.Address,left,right),'')
                    ,'last address listed for this entry in the Foreign Investment Archives of the Turkish Treasury is '
                      ,'')
											 ,'');
self.comments := if(regexfind('Fiscal Code|See various addresses|other locations within|Other foreign locations|A branch of GIA|Registration number|formerly c/o|Company dissolved|Liquidated and deleted|In liquidation|Email address|E-mail|Regional offices|http://|Closed by Bosnian|Charity number',l.Address) = true, l.Address,'');
self.basis3 := StringLib.StringFindReplace(l.basis3,'"','');														 
self := l;
end;

clean_norm := PROJECT(Norm_addresses,tr_clean_norm(left));
//output(clean_norm, named('clean_norm'));

Layout_OSFI_Canada_Entities_of_Concern.layout_party_key_and_lkps 
                      tr_party_key_and_lkps(clean_norm l) := TRANSFORM	

clean_up_address := 
map(StringLib.StringFind(l.Address,'Alabama',1) > 0  => StringLib.StringFindReplace(l.Address,'Alabama','AL') ,
   StringLib.StringFind(l.Address,'Alaska',1) > 0  => StringLib.StringFindReplace(l.Address,'Alaska','AK') ,
   StringLib.StringFind(l.Address,'American Samoa',1) > 0  => StringLib.StringFindReplace(l.Address,'American Samoa','AS') ,
   StringLib.StringFind(l.Address,'Arizona',1) > 0  => StringLib.StringFindReplace(l.Address,'Arizona','AZ') ,
   StringLib.StringFind(l.Address,'Arkansas',1) > 0  => StringLib.StringFindReplace(l.Address,'Arkansas','AR') ,
   StringLib.StringFind(l.Address,'California',1) > 0  => StringLib.StringFindReplace(l.Address,'California','CA') ,
   StringLib.StringFind(l.Address,'Colorado',1) > 0  => StringLib.StringFindReplace(l.Address,'Colorado','CO') ,
   StringLib.StringFind(l.Address,'Connecticut',1) > 0  => StringLib.StringFindReplace(l.Address,'Connecticut','CT') ,
   StringLib.StringFind(l.Address,'Delaware',1) > 0  => StringLib.StringFindReplace(l.Address,'Delaware','DE') ,
   StringLib.StringFind(l.Address,'Dist. of Columbia',1) > 0  => StringLib.StringFindReplace(l.Address,'Dist. of Columbia','DC') ,
   StringLib.StringFind(l.Address,'Florida',1) > 0  => StringLib.StringFindReplace(l.Address,'Florida','FL') ,
   StringLib.StringFind(l.Address,'Georgia',1) > 0  => StringLib.StringFindReplace(l.Address,'Georgia','GA') ,
   StringLib.StringFind(l.Address,'Guam',1) > 0  => StringLib.StringFindReplace(l.Address,'Guam','GU') ,
   StringLib.StringFind(l.Address,'Hawaii',1) > 0  => StringLib.StringFindReplace(l.Address,'Hawaii','HI') ,
   StringLib.StringFind(l.Address,'Idaho',1) > 0  => StringLib.StringFindReplace(l.Address,'Idaho','ID') ,
   StringLib.StringFind(l.Address,'Illinois',1) > 0  => StringLib.StringFindReplace(l.Address,'Illinois','IL') ,
   StringLib.StringFind(l.Address,'Indiana',1) > 0  => StringLib.StringFindReplace(l.Address,'Indiana','IN') ,
   StringLib.StringFind(l.Address,'Iowa',1) > 0  => StringLib.StringFindReplace(l.Address,'Iowa','IA') ,
   StringLib.StringFind(l.Address,'Kansas',1) > 0  => StringLib.StringFindReplace(l.Address,'Kansas','KS') ,
   StringLib.StringFind(l.Address,'Kentucky',1) > 0  => StringLib.StringFindReplace(l.Address,'Kentucky','KY') ,
   StringLib.StringFind(l.Address,'Louisiana',1) > 0  => StringLib.StringFindReplace(l.Address,'Louisiana','LA') ,
   StringLib.StringFind(l.Address,'Maine',1) > 0  => StringLib.StringFindReplace(l.Address,'Maine','ME') ,
   StringLib.StringFind(l.Address,'Maryland',1) > 0  => StringLib.StringFindReplace(l.Address,'Maryland','MD') ,
   StringLib.StringFind(l.Address,'Marshall Islands',1) > 0  => StringLib.StringFindReplace(l.Address,'Marshall Islands','MH') ,
   StringLib.StringFind(l.Address,'Massachusetts',1) > 0  => StringLib.StringFindReplace(l.Address,'Massachusetts','MA') ,
   StringLib.StringFind(l.Address,'Michigan',1) > 0  => StringLib.StringFindReplace(l.Address,'Michigan','MI') ,
   StringLib.StringFind(l.Address,'Micronesia',1) > 0  => StringLib.StringFindReplace(l.Address,'Micronesia','FM') ,
   StringLib.StringFind(l.Address,'Minnesota',1) > 0  => StringLib.StringFindReplace(l.Address,'Minnesota','MN') ,
   StringLib.StringFind(l.Address,'Mississippi',1) > 0  => StringLib.StringFindReplace(l.Address,'Mississippi','MS') ,
   StringLib.StringFind(l.Address,'Missouri',1) > 0  => StringLib.StringFindReplace(l.Address,'Missouri','MO') ,
   StringLib.StringFind(l.Address,'Montana',1) > 0  => StringLib.StringFindReplace(l.Address,'Montana','MT') ,
   StringLib.StringFind(l.Address,'Nebraska',1) > 0  => StringLib.StringFindReplace(l.Address,'Nebraska','NE') ,
   StringLib.StringFind(l.Address,'Nevada',1) > 0  => StringLib.StringFindReplace(l.Address,'Nevada','NV') ,
   StringLib.StringFind(l.Address,'New Hampshire',1) > 0  => StringLib.StringFindReplace(l.Address,'New Hampshire','NH') ,
   StringLib.StringFind(l.Address,'New Jersey',1) > 0  => StringLib.StringFindReplace(l.Address,'New Jersey','NJ') ,
   StringLib.StringFind(l.Address,'New Mexico',1) > 0  => StringLib.StringFindReplace(l.Address,'New Mexico','NM') ,
   StringLib.StringFind(l.Address,'New York',1) > 0  => StringLib.StringFindReplace(l.Address,'New York','NY') ,
   StringLib.StringFind(l.Address,'North Carolina',1) > 0  => StringLib.StringFindReplace(l.Address,'North Carolina','NC') ,
   StringLib.StringFind(l.Address,'North Dakota',1) > 0  => StringLib.StringFindReplace(l.Address,'North Dakota','ND') ,
   StringLib.StringFind(l.Address,'Northern Marianas',1) > 0  => StringLib.StringFindReplace(l.Address,'Northern Marianas','MP') ,
   StringLib.StringFind(l.Address,'Ohio',1) > 0  => StringLib.StringFindReplace(l.Address,'Ohio','OH') ,
   StringLib.StringFind(l.Address,'Oklahoma',1) > 0  => StringLib.StringFindReplace(l.Address,'Oklahoma','OK') ,
   StringLib.StringFind(l.Address,'Oregon',1) > 0  => StringLib.StringFindReplace(l.Address,'Oregon','OR') ,
   StringLib.StringFind(l.Address,'Palau',1) > 0  => StringLib.StringFindReplace(l.Address,'Palau','PW') ,
   StringLib.StringFind(l.Address,'Pennsylvania',1) > 0  => StringLib.StringFindReplace(l.Address,'Pennsylvania','PA') ,
   StringLib.StringFind(l.Address,'Puerto Rico',1) > 0  => StringLib.StringFindReplace(l.Address,'Puerto Rico','PR') ,
   StringLib.StringFind(l.Address,'Rhode Island',1) > 0  => StringLib.StringFindReplace(l.Address,'Rhode Island','RI') ,
   StringLib.StringFind(l.Address,'South Carolina',1) > 0  => StringLib.StringFindReplace(l.Address,'South Carolina','SC') ,
   StringLib.StringFind(l.Address,'South Dakota',1) > 0  => StringLib.StringFindReplace(l.Address,'South Dakota','SD') ,
   StringLib.StringFind(l.Address,'Tennessee',1) > 0  => StringLib.StringFindReplace(l.Address,'Tennessee','TN') ,
   StringLib.StringFind(l.Address,'Texas',1) > 0  => StringLib.StringFindReplace(l.Address,'Texas','TX') ,
   StringLib.StringFind(l.Address,'Utah',1) > 0  => StringLib.StringFindReplace(l.Address,'Utah','UT') ,
   StringLib.StringFind(l.Address,'Vermont',1) > 0  => StringLib.StringFindReplace(l.Address,'Vermont','VT') ,
   StringLib.StringFind(l.Address,'Virginia',1) > 0  => StringLib.StringFindReplace(l.Address,'Virginia','VA') ,
   StringLib.StringFind(l.Address,'Virgin Islands',1) > 0  => StringLib.StringFindReplace(l.Address,'Virgin Islands','VI') ,
   StringLib.StringFind(l.Address,'Washington',1) > 0  => StringLib.StringFindReplace(l.Address,'Washington','WA') ,
   StringLib.StringFind(l.Address,'West Virginia',1) > 0  => StringLib.StringFindReplace(l.Address,'West Virginia','WV') ,
   StringLib.StringFind(l.Address,'Wisconsin',1) > 0  => StringLib.StringFindReplace(l.Address,'Wisconsin','WI') ,
   StringLib.StringFind(l.Address,'Wyoming',1) > 0  => StringLib.StringFindReplace(l.Address,'Wyoming','WY'),l.Address);

self.pty_key := 'OCE' + trim(l.id[1..StringLib.StringFind(l.id,'.',1)-1]);
self.source := 'OSFI - Canada Entities';
self.orig_pty_name := trim(l.entity);
self.addr_1 := clean_up_address; 
self.addr_2 := '';
self.addr_3 := '';
self.pname_clean := '';
self.cname_clean := trim(StringLib.StringToUpperCase(l.entity));
self.addr_clean := ''; // fix call address cleaner here
self.orig_vessel_name := '';
self.country := ''; //fix
self.name_type := if(l.id[StringLib.StringFind(l.id,'.', 1)+1..StringLib.StringFind(l.id,'.', 1)+1+1] = '00' , '' , 'AKA');
self.remarks_1 := if(l.basis3 <> '', 'Basis : ' + trim(l.basis3) ,'') 
                   + ' ' + if(l.comments <> '', 'Additional comments: ' + trim(l.comments),'');
//self.remarks_2 := if(l.comments <> '', 'Additional comments: ' + trim(l.comments),'');
self := [];
end;


party_key_and_lkps := PROJECT(clean_norm,tr_party_key_and_lkps(left));

//output(party_key_and_lkps,named('party_key_and_lkps'));

layout_patriot_common tr_patriot_common_entity(party_key_and_lkps l) := TRANSFORM	

addr_1 := l.addr_1[1..50];
addr_2 := l.addr_1[51..100];
addr_3 := l.addr_1[101..150];
addr_4 := l.addr_1[151..200];
addr_5 := l.addr_1[201..250];
addr_6 := l.addr_1[251..300];
addr_7 := l.addr_1[301..350];
addr_8 := l.addr_1[351..400];
addr_9 := l.addr_1[401..450];
addr_10 := l.addr_1[451..500];

remarks_1 := l.remarks_1[1..75];
remarks_2 := l.remarks_1[76..150];
remarks_3 := l.remarks_1[151..225];
remarks_4 := l.remarks_1[226..300];
remarks_5 := l.remarks_1[301..375];
remarks_6 := l.remarks_1[376..450];
remarks_7 := l.remarks_1[451..525];
remarks_8 := l.remarks_1[526..600];
remarks_9 := l.remarks_1[601..675];
remarks_10 := l.remarks_1[676..750];
remarks_11 := l.remarks_1[751..825];
remarks_12 := l.remarks_1[826..900];
remarks_13 := l.remarks_1[901..975];
remarks_14 := l.remarks_1[976..1050];
remarks_15 := l.remarks_1[1051..1125];
remarks_16 := l.remarks_1[1126..1200];
remarks_17 := l.remarks_1[1201..1275];
remarks_18 := l.remarks_1[1276..1350];
remarks_19 := l.remarks_1[1351..1425];
remarks_20 := l.remarks_1[1426..1500];
remarks_21 := l.remarks_1[1501..1575];
remarks_22 := l.remarks_1[1576..1650];
remarks_23 := l.remarks_1[1651..1725];
remarks_24 := l.remarks_1[1726..1800];
remarks_25 := l.remarks_1[1801..1875];
remarks_26 := l.remarks_1[1876..1950];
remarks_27 := l.remarks_1[1951..2025];
remarks_28 := l.remarks_1[2026..2100];
remarks_29 := l.remarks_1[2101..2175];
remarks_30 := l.remarks_1[2176..2250];

self.addr_1 := addr_1;
self.addr_2 := addr_2;
self.addr_3 := addr_3;
self.addr_4 := addr_4;
self.addr_5 := addr_5;
self.addr_6 := addr_6;
self.addr_7 := addr_7;
self.addr_8 := addr_8;
self.addr_9 := addr_9;
self.addr_10 := addr_10;

self.remarks_1 := remarks_1;
self.remarks_2 := remarks_2;
self.remarks_3 := remarks_3;
self.remarks_4 := remarks_4;
self.remarks_5 := remarks_5;
self.remarks_6 := remarks_6;
self.remarks_7 := remarks_7;
self.remarks_8 := remarks_8;
self.remarks_9 := remarks_9;
self.remarks_10 := remarks_10;
self.remarks_11 := remarks_11;
self.remarks_12 := remarks_12;
self.remarks_13 := remarks_13;
self.remarks_14 := remarks_14;
self.remarks_15 := remarks_15;
self.remarks_16 := remarks_16;
self.remarks_17 := remarks_17;
self.remarks_18 := remarks_18;
self.remarks_19 := remarks_19;
self.remarks_20 := remarks_20;
self.remarks_21 := remarks_21;
self.remarks_22 := remarks_22;
self.remarks_23 := remarks_23;
self.remarks_24 := remarks_24;
self.remarks_25 := remarks_25;
self.remarks_26 := remarks_26;
self.remarks_27 := remarks_27;
self.remarks_28 := remarks_28;
self.remarks_29 := remarks_29;
self.remarks_30 := remarks_30;
//self.cname := l.cname_clean;
self.entity_flag := 'Y';  
self := l;
self := [];
end;

patriot_common_entity := PROJECT(party_key_and_lkps,tr_patriot_common_entity(left));

//********* process individuals
//***** clean up
Layout_OSFI_Canada_Entities_of_Concern.layout_individuals_clean 
                      tr_clean_individuals(individuals l) := TRANSFORM												
				
self.POB := if(length(trim(l.POB)) > 80, StringLib.StringFindReplace(l.POB,'Soviet Socialist Republic', 'SSR')[1..80], trim(l.POB));
self.lstd_entity := StringLib.StringFindReplace(
                              trim(l.LastName)
                            + if(trim(l.LastName) <> '' and (trim(l.First_Name) <> '' or trim(l.SecondName) <> '' or trim(l.ThirdName) <> '' or trim(l.FourthName)<> '') ,  ',' , '')
                            + ' ' + trim(l.First_Name)
                            + ' ' + trim(l.SecondName)
                            + ' ' + trim(l.ThirdName)
                            + ' ' + trim(l.FourthName)
                                       ,'  ',' ');
self.Nationality := StringLib.StringFindReplace(l.Nationality,'Citizenship','Ctzship');
self.last_vend_upd := ''; //fix $OSFI_CANADA_INDIVIDUALS_DATE;
self.basis5 := StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(
                                   //trim(l.basis5)[1..200],', ',','),'; ',';'),' )',')'),'( ','(');
																	 trim(l.basis5),', ',','),'; ',';'),' )',')'),'( ','(');
self.ALTDOB1 := l.ALTDOB1;
self.ALTDOB2 := StringLib.StringFindReplace(StringLib.StringFindReplace(trim(l.ALTDOB2),'(from false passport)',''),'Between','');
self.ALTPOB := l.ALTPOB;
self.SecondName := l.SecondName;
self := l;
end;

clean_individuals := PROJECT(individuals,tr_clean_individuals(left));

Layout_OSFI_Canada_Entities_of_Concern.layout_reformat_DOB
                      tr_reformat_DOB(clean_individuals l) := TRANSFORM	
											
get_YYYYMMDD_format_DOB4 := 
				intformat((integer2)regexreplace('.*/.*/([0-9]+)',l.DOB4,'$1'),4,1)
			+ intformat((integer1)regexreplace('.*/([0-9]+)/.*',l.DOB4,'$1'),2,1)
			+ intformat((integer1)regexreplace('([0-9]+)/.*/.*',l.DOB4,'$1'),2,1);
			
get_MM_slash_DD_slash_YYYY_format_DOB4	:= 	get_YYYYMMDD_format_DOB4[5..6] + '/' + get_YYYYMMDD_format_DOB4[7..8] + '/' + get_YYYYMMDD_format_DOB4[1..4]; 
											

get_YYYYMMDD_format_ALTDOB1 := 
				intformat((integer2)regexreplace('.*/.*/([0-9]+)',l.ALTDOB1,'$1'),4,1)
			+ intformat((integer1)regexreplace('.*/([0-9]+)/.*',l.ALTDOB1,'$1'),2,1)
			+ intformat((integer1)regexreplace('([0-9]+)/.*/.*',l.ALTDOB1,'$1'),2,1);
			
get_MM_slash_DD_slash_YYYY_format_ALTDOB1	:= 	get_YYYYMMDD_format_ALTDOB1[5..6] + '/' + get_YYYYMMDD_format_ALTDOB1[7..8] + '/' + get_YYYYMMDD_format_ALTDOB1[1..4]; 


get_YYYYMMDD_format_ALTDOB2 := 
				intformat((integer2)regexreplace('.*/.*/([0-9]+)',l.ALTDOB2,'$1'),4,1)
			+ intformat((integer1)regexreplace('.*/([0-9]+)/.*',l.ALTDOB2,'$1'),2,1)
			+ intformat((integer1)regexreplace('([0-9]+)/.*/.*',l.ALTDOB2,'$1'),2,1);
			
get_MM_slash_DD_slash_YYYY_format_ALTDOB2	:= 	get_YYYYMMDD_format_ALTDOB2[5..6] + '/' + get_YYYYMMDD_format_ALTDOB2[7..8] + '/' + get_YYYYMMDD_format_ALTDOB2[1..4]; 


get_YYYYMMDD_format_ALTDOB3 := 
				intformat((integer2)regexreplace('.*/.*/([0-9]+)',l.ALTDOB3,'$1'),4,1)
			+ intformat((integer1)regexreplace('.*/([0-9]+)/.*',l.ALTDOB3,'$1'),2,1)
			+ intformat((integer1)regexreplace('([0-9]+)/.*/.*',l.ALTDOB3,'$1'),2,1);
			
get_MM_slash_DD_slash_YYYY_format_ALTDOB3	:= 	get_YYYYMMDD_format_ALTDOB3[5..6] + '/' + get_YYYYMMDD_format_ALTDOB3[7..8] + '/' + get_YYYYMMDD_format_ALTDOB3[1..4]; 

											
self.POB := trim(l.POB);
self.ALTPOB := trim(l.ALTPOB);
self.DOB4 := if(length(trim(l.DOB4,left, right)) = 10, trim(get_MM_slash_DD_slash_YYYY_format_DOB4), trim(l.DOB4));
self.ALTDOB1 := if(length(trim(l.ALTDOB1,left, right)) = 10 ,trim(get_MM_slash_DD_slash_YYYY_format_ALTDOB1), trim(l.ALTDOB1));
self.ALTDOB2 := if(length(trim(l.ALTDOB2,left, right)) = 10 ,trim(get_MM_slash_DD_slash_YYYY_format_ALTDOB2), trim(l.ALTDOB2));
self.ALTDOB3 := if(length(trim(l.ALTDOB3,left, right)) = 10 ,trim(get_MM_slash_DD_slash_YYYY_format_ALTDOB3), trim(l.ALTDOB3));
self.Nationality := trim(l.Nationality);
self.OtherInfo := trim(l.OtherInfo);
self.basis5 := trim(l.basis5);		
self.name := Address.CleanPersonLFM73(l.lstd_entity);
self := l; 		
end;		
									
reformat_DOB := PROJECT(clean_individuals,tr_reformat_DOB(left));

Layout_OSFI_Canada_Entities_of_Concern.layout_aka_and_remarks
                      tr_aka_and_remarks(reformat_DOB l) := TRANSFORM	

nationality := trim(l.Nationality) + trim(l.ALTNAtionality1) +  trim(l.ALTNationality2);
pobs := trim(l.POB) + trim(l.ALTPOB);
dobs := trim(l.DOB4) + ' ' + trim(l.ALTDOB1) + ' ' + trim(l.ALTDOB2) + ' ' + trim(l.ALTDOB3);

self.pty_key := 'OCI' + trim(l.ID[1..StringLib.StringFind(l.ID,'.',1)-1]);
               
self.source := 'OSFI - Canada Individuals';
self.orig_pty_name := trim(l.lstd_entity,left,right);
self.orig_vessel_name := '';
self.name_type := if(l.id[StringLib.StringFind(l.id,'.', 1)+1..StringLib.StringFind(l.id,'.', 1)+1+1] = '00' , '' , 'AKA');
self.addr_1 := '';
self.addr_2 := '';
self.addr_3 := '';
																								
self.remarks_1 := trim(if(dobs <> '', 'DOB(s): ' + trim(dobs) + ' ', '') 
                     + if(pobs <> '', 'POB(s): ' + trim(pobs) + ' ', '')
                      + if(nationality <> '','Nationality(s): ' + trim(nationality) + ' ' , '')
                       + if(l.basis5 <> '' ,'Basis : ' + trim(l.basis5) + ' ','')
                        + if(l.OtherInfo <> '' and  StringLib.StringFind(l.OtherInfo,'SSN ',1) = 0,
                          // trim('NI Number: ' + trim(l.OtherInfo)[1..1050]) ,
													  trim('NI Number: ' + trim(l.OtherInfo)) , 
                           if (l.OtherInfo <> '' and  StringLib.StringFind(l.OtherInfo,'SSN ',1) > 0,
                            trim('NI Number: ' +
										         regexreplace('....%%%%',
										           regexreplace('SSN ...-..-....',trim(l.OtherInfo),'&%%%%')
                                          ,'xxxx')
																					)
																					       , '')
																								      ));																											
																											
self.cname_clean := '';
self := [];
end;

aka_and_remarks := PROJECT(reformat_DOB,tr_aka_and_remarks(left));


layout_patriot_common tr_patriot_common_individual(aka_and_remarks l) := TRANSFORM	

addr_1 := l.addr_1[1..50];
addr_2 := l.addr_1[51..100];
addr_3 := l.addr_1[101..150];
addr_4 := l.addr_1[151..200];
addr_5 := l.addr_1[201..250];
addr_6 := l.addr_1[251..300];
addr_7 := l.addr_1[301..350];
addr_8 := l.addr_1[351..400];
addr_9 := l.addr_1[401..450];
addr_10 := l.addr_1[451..500];

remarks_1 := l.remarks_1[1..75];
remarks_2 := l.remarks_1[76..150];
remarks_3 := l.remarks_1[151..225];
remarks_4 := l.remarks_1[226..300];
remarks_5 := l.remarks_1[301..375];
remarks_6 := l.remarks_1[376..450];
remarks_7 := l.remarks_1[451..525];
remarks_8 := l.remarks_1[526..600];
remarks_9 := l.remarks_1[601..675];
remarks_10 := l.remarks_1[676..750];
remarks_11 := l.remarks_1[751..825];
remarks_12 := l.remarks_1[826..900];
remarks_13 := l.remarks_1[901..975];
remarks_14 := l.remarks_1[976..1050];
remarks_15 := l.remarks_1[1051..1125];
remarks_16 := l.remarks_1[1126..1200];
remarks_17 := l.remarks_1[1201..1275];
remarks_18 := l.remarks_1[1276..1350];
remarks_19 := l.remarks_1[1351..1425];
remarks_20 := l.remarks_1[1426..1500];
remarks_21 := l.remarks_1[1501..1575];
remarks_22 := l.remarks_1[1576..1650];
remarks_23 := l.remarks_1[1651..1725];
remarks_24 := l.remarks_1[1726..1800];
remarks_25 := l.remarks_1[1801..1875];
remarks_26 := l.remarks_1[1876..1950];
remarks_27 := l.remarks_1[1951..2025];
remarks_28 := l.remarks_1[2026..2100];
remarks_29 := l.remarks_1[2101..2175];
remarks_30 := l.remarks_1[2176..2250];

self.addr_1 := addr_1;
self.addr_2 := addr_2;
self.addr_3 := addr_3;
self.addr_4 := addr_4;
self.addr_5 := addr_5;
self.addr_6 := addr_6;
self.addr_7 := addr_7;
self.addr_8 := addr_8;
self.addr_9 := addr_9;
self.addr_10 := addr_10;

self.remarks_1 := remarks_1;
self.remarks_2 := remarks_2;
self.remarks_3 := remarks_3;
self.remarks_4 := remarks_4;
self.remarks_5 := remarks_5;
self.remarks_6 := remarks_6;
self.remarks_7 := remarks_7;
self.remarks_8 := remarks_8;
self.remarks_9 := remarks_9;
self.remarks_10 := remarks_10;
self.remarks_11 := remarks_11;
self.remarks_12 := remarks_12;
self.remarks_13 := remarks_13;
self.remarks_14 := remarks_14;
self.remarks_15 := remarks_15;
self.remarks_16 := remarks_16;
self.remarks_17 := remarks_17;
self.remarks_18 := remarks_18;
self.remarks_19 := remarks_19;
self.remarks_20 := remarks_20;
self.remarks_21 := remarks_21;
self.remarks_22 := remarks_22;
self.remarks_23 := remarks_23;
self.remarks_24 := remarks_24;
self.remarks_25 := remarks_25;
self.remarks_26 := remarks_26;
self.remarks_27 := remarks_27;
self.remarks_28 := remarks_28;
self.remarks_29 := remarks_29;
self.remarks_30 := remarks_30;
self := l;
self := [];
end;

patriot_common_individual := PROJECT(aka_and_remarks,tr_patriot_common_individual(left));

// output(choosen(aka_and_remarks,all));

concat_ind_and_entity := patriot_common_individual + patriot_common_entity;

EXPORT Mapping_OSFI_Canada_Entities_of_Concern := concat_ind_and_entity
         : persist('~thor::persist::out::patriot::preprocess::OSFI_Canada_Entities_of_Concern');