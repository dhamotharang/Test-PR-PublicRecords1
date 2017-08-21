IMPORT GlobalWatchLists_Preprocess, std, bo_address, ut;

EXPORT ProcessOSFICanadaEnt := FUNCTION

	OSFIEntWOheader := GlobalWatchLists_Preprocess.Files.dsOSFICanadaEnt(	TRIM(row_data, left, right) <> u'' and
   																						regexfind(u'[a-z,A-Z,0-9]', row_data) = true and
   																						STD.Uni.Find(row_data, u'Consolidated List of Names subject', 1) = 0 and
   																						STD.Uni.Find(row_data, u'or the United Nations Al-Qaida and Taliban Regulations', 1) = 0 and
   																						STD.Uni.Find(row_data, u'http://www.osfi-bsif.gc.ca', 1) = 0 and
   																						STD.Uni.Find(row_data, u'PART B ', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Names added to the list', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Entity	Address', 1) = 0 and
   																						STD.Uni.Find(row_data, u'This consolidated list has a number ', 1) = 0 and
   																						STD.Uni.Find(row_data, u'http://www.osfi.gc.ca', 1) = 0 and
   																						STD.Uni.Find(row_data, u'ID number reflects each entity', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Basis includes', 1) = 0 and
   																						STD.Uni.Find(row_data, u'is included on the UN list', 1) = 0 and
   																						STD.Uni.Find(row_data, u'the listing was changed to all of', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Minus the National Council of Resistance', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Only the Pakistan and Afghanistan offices', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Only the Somalia, Bosnia-Herzegovina', 1) = 0 and
   																						STD.Uni.Find(row_data, u'DISCLAIMER: This list has been prepared', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Acts as passed by Parliament', 1) = 0 and
   																						STD.Uni.Find(row_data, u'of the Privy Council and published', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Links to the United Nations Act', 1) = 0);

	GlobalWatchLists_Preprocess.Layouts.rOSFICanada RemoveDoubleQuote(GlobalWatchLists_Preprocess.Layouts.rOSFICanada L) := TRANSFORM
		self.row_data := STD.Uni.FindReplace(L.row_data, u'"', u'');
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.tempLayoutEnt SplitData(GlobalWatchLists_Preprocess.Layouts.rOSFICanada L) := TRANSFORM
		WordCount			:= STD.Str.CountWords((string)L.row_data,'\t');	
		self.ID				:= (string)L.row_data[1..STD.Uni.Find(L.row_data, u'\t',1) - 1];
		self.entity		:= IF(WordCount > 2, L.row_data[STD.Uni.Find(L.row_data, u'\t',1) + 1..STD.Uni.Find(L.row_data, u'\t',2) - 1],
												L.row_data[STD.Uni.Find(L.row_data, u'\t',1) + 1..]);
	  self.Address	:= IF(WordCount > 2, L.row_data[STD.Uni.Find(L.row_data, u'\t',2) + 1..STD.Uni.Find(L.row_data, u'\t',3) - 1],'');
		self.basis3		:= IF(WordCount > 2, L.row_data[STD.Uni.Find(L.row_data, u'\t',3) + 1..],'');
		self.orig_raw_name	:= (string)L.row_data[STD.Uni.Find(L.row_data, u'\t',1) + 1..STD.Uni.Find(L.row_data, u'\t',2) - 1];
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.tempLayoutEnt1 ParseIndividualAddressesANDcomments(GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.tempLayoutEnt L) := TRANSFORM
		v_temp_address := 	STD.Uni.FindReplace(
 												STD.Uni.FindReplace(
   												STD.Uni.FindReplace(
   												STD.Uni.FindReplace(
   												STD.Uni.FindReplace(
   												STD.Uni.FindReplace(

												STD.Uni.FindReplace(
													STD.Uni.FindReplace(
														STD.Uni.FindReplace(
															STD.Uni.FindReplace(
																STD.Uni.FindReplace(
																	STD.Uni.FindReplace(
																		STD.Uni.FindReplace(
																			STD.Uni.FindReplace(L.Address
																			,u'Italy, Fiscal', u'Italy;Fiscal')
																		,u'United Kingdom, Email address',u'United Kingdom;Email address"')                                                                                                                       
																	,u'Alternate Address: ',u';')                                                                                                        
																,u'a) ' ,u';')                                                                                        
															,u'b) ',u';')                                                                          
														,u'c) ',u';')                                                           
													,u'd) ',u';')                                            
												,u'e) ',u';')                              
											,u'f) ',u';')//;
 											,u'â€™', u'\'')
   											,u'"', u'')
   											,u'â€œ', u'')
   											,u'â€', u'')
   											,u'â€“', u'-');

              
		self.Addresses_Parsed := if(TRIM(v_temp_address, left, right) <> '', TRIM(STD.Uni.FindReplace(v_temp_address, '"', ''), left, right), '');
		self.orig_raw_name	:= L.orig_raw_name;
		self 								:= L;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.tempLayoutEnt2 AddAddressCount(GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.tempLayoutEnt1 L) := TRANSFORM
		self.Address_Count 	:= length(STD.Uni.Filter(L.Addresses_Parsed, ';')) + 1;
		self 								:= L;
	END;
	
	max_addr_count := max(PROJECT(PROJECT(PROJECT(PROJECT(OSFIEntWOheader, RemoveDoubleQuote(left)), SplitData(left)), ParseIndividualAddressesANDcomments(left)), AddAddressCount(left)), Address_Count);
	
	/*
	IntermediaryLayoutOSFICanada.tempLayoutEnt2 AdjustAddressCount(IntermediaryLayoutOSFICanada.tempLayoutEnt2 L) := TRANSFORM
		self.Address_Count 	:= if(L.Address_Count >= max_addr_count, max_addr_count-1,  L.Address_Count);
		self 								:= L;
	END;
	*/
	
 	GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments NormAddress(GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.tempLayoutEnt2 L, INTEGER C) := TRANSFORM
   		//string1000 temp_address := STD.Str.SplitWords((string)L.Addresses_Parsed, ';')[C];
			string2800 temp_address := (string)if(STD.Uni.Find(L.Addresses_Parsed, ';', C) > 0		
					,STD.Uni.FindReplace(L.Addresses_Parsed[STD.Uni.Find(L.Addresses_Parsed, ';', C)+1..1500], ', ', ',')
					,trim(STD.Uni.FindReplace(L.Addresses_Parsed, ', ', ',')));
					
			string1000 temp_address_vector := if(temp_address <> ''
										,if(STD.Str.Find(temp_address,';', 1) > 0
											,STD.Str.FindReplace(temp_address[1..STD.Str.Find(temp_address, ';', 1)-1], ', ', ',')
											,trim(STD.Str.FindReplace(temp_address, ', ', ',')))
										,'');
   		self.ID 						:= L.id;		
   		self.entity 				:= STD.Uni.Filter(STD.Uni.FindReplace(L.entity,u'â€™',u'\''),u' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890()[]-_/\'`:;,!@%$^&*+=?<>.Ã€ÃÃ‚ÃƒÃ„Ã…Ã†Ã‡ÃˆÃ‰ÃŠÃ‹ÃŒÃÃŽÃÃÃ‘Ã’Ã“Ã”Ã•Ã–Ã™ÃšÃ›ÃœÃÃ Ã¡Ã¢Ã£Ã¤Ã¥Ã¦Ã§Ã¨Ã©ÃªÃ«Ã¬Ã­Ã®Ã¯Ã°Ã±Ã²Ã³Ã´ÃµÃ¹ÃºÃ»Ã¼Ã½Ã¿');
   		self.Address 				:= temp_address_vector;//TRIM((unicode)STD.Str.FindReplace(temp_address, ', ', ','), left, right);
   		self.basis3 				:= L.basis3;
   		self.last_vend_upd 	:= GlobalWatchLists_Preprocess.Versions.OSFI_Ent_Version;//'';
			self.orig_raw_name	:= L.orig_raw_name;
  END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments CreateComments(GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments L) := TRANSFORM	  
		self.Address 	:= regexreplace(u',$', STD.Uni.FindReplace(if(regexfind(u'Fiscal Code|See various addresses|other locations within|Other foreign locations|A branch of GIA|Registration number|formerly c/o|Company dissolved|Liquidated and deleted|In liquidation|Email address|E-mail|Regional offices|http://|Closed by Bosnian|Charity number',L.Address) = false																															
																										,TRIM(L.Address)
																										,'')
																				 ,u'last address listed for this entry in the Foreign Investment Archives of the Turkish Treasury is '
																				 ,u'')
										 ,'');
		self.comments := if(regexfind(u'Fiscal Code|See various addresses|other locations within|Other foreign locations|A branch of GIA|Registration number|formerly c/o|Company dissolved|Liquidated and deleted|In liquidation|Email address|E-mail|Regional offices|http://|Closed by Bosnian|Charity number', L.Address) = true
												,L.Address
												,u'');
		self.basis3 	:= STD.Uni.FindReplace(L.basis3, u'"', u'');
		self.orig_raw_name := L.orig_raw_name;
		self := L;
	END;
		
	//OSFIEnt := PROJECT(NORMALIZE(PROJECT(PROJECT(PROJECT(PROJECT(PROJECT(OSFIEntWOheader, RemoveDoubleQuote(left)), SplitData(left)), ParseIndividualAddressesANDcomments(left)), AddAddressCount(left)), AdjustAddressCount(left)), LEFT.Address_Count, NormAddress(LEFT,COUNTER)), CreateComments(left));
	OSFIEnt := PROJECT(NORMALIZE(PROJECT(PROJECT(PROJECT(PROJECT(OSFIEntWOheader, RemoveDoubleQuote(left)), SplitData(left)), ParseIndividualAddressesANDcomments(left)), AddAddressCount(left)), LEFT.Address_Count, NormAddress(LEFT,COUNTER)), CreateComments(left));

	EntWithFilteredAddresses := OSFIEnt(TRIM(Address) <> '' or (TRIM(Address, left, right) = '' and TRIM(comments, left, right) = ''));
	EntWithFilteredComments	 := OSFIEnt(TRIM(comments, left, right) <> '');
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments rollrecs(GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments l, GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments r) := TRANSFORM
		self.comments := TRIM(l.comments) + TRIM(r.comments) + u'; ';
		self := l;
	END;
	
	EntWithRolledUpComments		 := project(rollup(EntWithFilteredComments, id, rollrecs(left, right)), TRANSFORM(GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments, self.comments := regexreplace(u';$', left.comments, u''); self := left;));

	GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments doJoin(GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments l, GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments r) := TRANSFORM
		self.id 			:= if(TRIM(l.id, left, right) <> '', l.id, r.id);
		self.entity 	:= if(TRIM(l.entity, left, right) <> '', l.entity, r.entity);
		self.address 	:= if(TRIM(l.Address, left, right) <> ''
											,STD.Uni.FindReplace(
													STD.Uni.FindReplace(
														STD.Uni.FindReplace(
															STD.Uni.FindReplace(
																STD.Uni.FindReplace(l.Address, u'â€™', u'\'')
															,u'"', u'')																																										
														,u'â€œ', u'')																																			 
													,u'â€', u'')																													
												,u'â€“', u'-')																					
											,u'');
		self.comments := if(TRIM(r.comments, left, right) <> '', TRIM(r.comments, left, right), '');
		self.basis3		:= if(TRIM(l.basis3, left, right) <> '', l.basis3, r.basis3);
		self.last_vend_upd	:= if(TRIM(l.last_vend_upd, left, right) <> '', l.last_vend_upd, r.last_vend_upd);
		self.orig_raw_name := if(trim(l.orig_raw_name,left,right) <> '',l.orig_raw_name, r.orig_raw_name);
	END;
	
	j1 := join(EntWithFilteredAddresses, EntWithRolledUpComments, left.id = right.id and left.entity = right.entity, doJoin(left, right), full outer);
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments xFromAddress(GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments L) := TRANSFORM
		self.address := STD.Uni.FindReplace(TRIM(L.Address, left, right), ',United States of America', '');
		self := L;
	END;
	
	GlobalWatchLists_Preprocess.rOutLayout  ReformatToCommonlayout(GlobalWatchLists_Preprocess.IntermediaryLayoutOSFICanada.BaseLayoutEntWithComments L) := TRANSFORM
		v_temp_address1 := if(STD.Uni.Find(L.Address,'Alabama',1) > 0, STD.Uni.FindReplace(L.Address,'Alabama','AL')
											,if(STD.Uni.Find(L.Address,'Alaska',1) > 0, STD.Uni.FindReplace(L.Address,'Alaska','AK')
											,if(STD.Uni.Find(L.Address,'American Samoa',1) > 0, STD.Uni.FindReplace(L.Address,'American Samoa','AS')
											,if(STD.Uni.Find(L.Address,'Arizona',1) > 0, STD.Uni.FindReplace(L.Address,'Arizona','AZ')
											,if(STD.Uni.Find(L.Address,'Arkansas',1) > 0, STD.Uni.FindReplace(L.Address,'Arkansas','AR')
											,if(STD.Uni.Find(L.Address,'California',1) > 0, STD.Uni.FindReplace(L.Address,'California','CA')
											,if(STD.Uni.Find(L.Address,'Colorado',1) > 0, STD.Uni.FindReplace(L.Address,'Colorado','CO')
											,if(STD.Uni.Find(L.Address,'Connecticut',1) > 0, STD.Uni.FindReplace(L.Address,'Connecticut','CT')
											,if(STD.Uni.Find(L.Address,'Delaware',1) > 0, STD.Uni.FindReplace(L.Address,'Delaware','DE')
											,if(STD.Uni.Find(L.Address,'Dist. of Columbia',1) > 0, STD.Uni.FindReplace(L.Address,'Dist. of Columbia','DC')
											,if(STD.Uni.Find(L.Address,'Florida',1) > 0, STD.Uni.FindReplace(L.Address,'Florida','FL')
											,if(STD.Uni.Find(L.Address,'Georgia',1) > 0, STD.Uni.FindReplace(L.Address,'Georgia','GA')
											,if(STD.Uni.Find(L.Address,'Guam',1) > 0, STD.Uni.FindReplace(L.Address,'Guam','GU')
											,if(STD.Uni.Find(L.Address,'Hawaii',1) > 0, STD.Uni.FindReplace(L.Address,'Hawaii','HI')
											,if(STD.Uni.Find(L.Address,'Idaho',1) > 0, STD.Uni.FindReplace(L.Address,'Idaho','ID')
											,if(STD.Uni.Find(L.Address,'Illinois',1) > 0, STD.Uni.FindReplace(L.Address,'Illinois','IL')
											,if(STD.Uni.Find(L.Address,'Indiana',1) > 0, STD.Uni.FindReplace(L.Address,'Indiana','IN')
											,if(STD.Uni.Find(L.Address,'Iowa',1) > 0, STD.Uni.FindReplace(L.Address,'Iowa','IA')
											,if(STD.Uni.Find(L.Address,'Kansas',1) > 0, STD.Uni.FindReplace(L.Address,'Kansas','KS')
											,if(STD.Uni.Find(L.Address,'Kentucky',1) > 0, STD.Uni.FindReplace(L.Address,'Kentucky','KY')
											,if(STD.Uni.Find(L.Address,'Louisiana',1) > 0, STD.Uni.FindReplace(L.Address,'Louisiana','LA')
											,if(STD.Uni.Find(L.Address,'Maine',1) > 0, STD.Uni.FindReplace(L.Address,'Maine','ME')
											,if(STD.Uni.Find(L.Address,'Maryland',1) > 0, STD.Uni.FindReplace(L.Address,'Maryland','MD')
											,if(STD.Uni.Find(L.Address,'Marshall Islands',1) > 0, STD.Uni.FindReplace(L.Address,'Marshall Islands','MH')
											,if(STD.Uni.Find(L.Address,'Massachusetts',1) > 0, STD.Uni.FindReplace(L.Address,'Massachusetts','MA')
											,if(STD.Uni.Find(L.Address,'Michigan',1) > 0, STD.Uni.FindReplace(L.Address,'Michigan','MI')
											,if(STD.Uni.Find(L.Address,'Micronesia',1) > 0, STD.Uni.FindReplace(L.Address,'Micronesia','FM')
											,if(STD.Uni.Find(L.Address,'Minnesota',1) > 0, STD.Uni.FindReplace(L.Address,'Minnesota','MN')
											,if(STD.Uni.Find(L.Address,'Mississippi',1) > 0, STD.Uni.FindReplace(L.Address,'Mississippi','MS')
											,if(STD.Uni.Find(L.Address,'Missouri',1) > 0, STD.Uni.FindReplace(L.Address,'Missouri','MO')
											,L.Address))))))))))))))))))))))))))))));
		v_temp_address := if(STD.Uni.Find(v_temp_address1,'Montana',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Montana','MT')
											,if(STD.Uni.Find(v_temp_address1,'Nebraska',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Nebraska','NE')
											,if(STD.Uni.Find(v_temp_address1,'Nevada',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Nevada','NV')
											,if(STD.Uni.Find(v_temp_address1,'New Hampshire',1) > 0, STD.Uni.FindReplace(v_temp_address1,'New Hampshire','NH')
											,if(STD.Uni.Find(v_temp_address1,'New Jersey',1) > 0, STD.Uni.FindReplace(v_temp_address1,'New Jersey','NJ')
											,if(STD.Uni.Find(v_temp_address1,'New Mexico',1) > 0, STD.Uni.FindReplace(v_temp_address1,'New Mexico','NM')
											,if(STD.Uni.Find(v_temp_address1,'New York',1) > 0, STD.Uni.FindReplace(v_temp_address1,'New York','NY')
											,if(STD.Uni.Find(v_temp_address1,'North Carolina',1) > 0, STD.Uni.FindReplace(v_temp_address1,'North Carolina','NC')
											,if(STD.Uni.Find(v_temp_address1,'North Dakota',1) > 0, STD.Uni.FindReplace(v_temp_address1,'North Dakota','ND')
											,if(STD.Uni.Find(v_temp_address1,'Northern Marianas',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Northern Marianas','MP')
											,if(STD.Uni.Find(v_temp_address1,'Ohio',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Ohio','OH')
											,if(STD.Uni.Find(v_temp_address1,'Oklahoma',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Oklahoma','OK')
											,if(STD.Uni.Find(v_temp_address1,'Oregon',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Oregon','OR')
											,if(STD.Uni.Find(v_temp_address1,'Palau',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Palau','PW')
											,if(STD.Uni.Find(v_temp_address1,'Pennsylvania',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Pennsylvania','PA')
											,if(STD.Uni.Find(v_temp_address1,'Puerto Rico',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Puerto Rico','PR')
											,if(STD.Uni.Find(v_temp_address1,'Rhode Island',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Rhode Island','RI')
											,if(STD.Uni.Find(v_temp_address1,'South Carolina',1) > 0, STD.Uni.FindReplace(v_temp_address1,'South Carolina','SC')
											,if(STD.Uni.Find(v_temp_address1,'South Dakota',1) > 0, STD.Uni.FindReplace(v_temp_address1,'South Dakota','SD')
											,if(STD.Uni.Find(v_temp_address1,'Tennessee',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Tennessee','TN')
											,if(STD.Uni.Find(v_temp_address1,'Texas',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Texas','TX')
											,if(STD.Uni.Find(v_temp_address1,'Utah',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Utah','UT')
											,if(STD.Uni.Find(v_temp_address1,'Vermont',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Vermont','VT')
											,if(STD.Uni.Find(v_temp_address1,'Virginia',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Virginia','VA')
											,if(STD.Uni.Find(v_temp_address1,'Virgin Islands',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Virgin Islands','VI')
											,if(STD.Uni.Find(v_temp_address1,'Washington',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Washington','WA')
											,if(STD.Uni.Find(v_temp_address1,'West Virginia',1) > 0, STD.Uni.FindReplace(v_temp_address1,'West Virginia','WV')
											,if(STD.Uni.Find(v_temp_address1,'Wisconsin',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Wisconsin','WI')
											,if(STD.Uni.Find(v_temp_address1,'Wyoming',1) > 0, STD.Uni.FindReplace(v_temp_address1,'Wyoming','WY')
											,v_temp_address1)))))))))))))))))))))))))))));
		self.pty_key 					:= 'OCE' + (string)TRIM(L.ID[1..STD.Uni.Find(L.ID, '.', 1)-1], left, right);
		self.source 					:= 'OSFI - Canada Entities';
		self.orig_pty_name 		:= (string)STD.Uni.ToUpperCase(TRIM(L.entity, left, right));
		self.addr_3 					:= '';
		self.pname_clean 			:= '';
		self.cname_clean 			:= (string)TRIM(STD.Uni.ToUpperCase(L.entity), left, right);
		self.addr_clean 			:= '';
		self.orig_vessel_name := '';
		self.country 					:= (string)if(count(GlobalWatchLists_Preprocess.LookupFiles.dsCountryCodes(country_name_short = (string)STD.Uni.ToUpperCase(L.Address[1..44]))) > 0
															,STD.Uni.ToUpperCase(L.Address[1..44])
															,if(count(GlobalWatchLists_Preprocess.LookupFiles.dsCountryCodes(country_name_alt = (string)STD.Uni.ToUpperCase(L.Address[1..55]))) > 0
																,STD.Uni.ToUpperCase(L.Address[1..55])
																,if(count(GlobalWatchLists_Preprocess.LookupFiles.dsCountryCodes(country_name_short = (string)STD.Uni.ToUpperCase(L.Address[STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2..44 + STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2-1]))) > 0
																	,STD.Uni.ToUpperCase(L.Address[STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2..44 + STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2-1])
																	,if(count(GlobalWatchLists_Preprocess.LookupFiles.dsCountryCodes(country_name_alt = (string)STD.Uni.ToUpperCase(L.Address[STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2..55 + STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2-1]))) > 0
																		,STD.Uni.ToUpperCase(L.Address[STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2..55 + STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2-1])
																		,if(STD.Uni.Find(L.Address, ' USA', 1) > 0 or STD.Uni.Find(L.Address, ' U.S.A.', 1) > 0
																			,'UNITED STATES'
																			,'')))));
		self.name_type 				:= if(STD.Str.Find(L.ID,'.00',1) > 0, '', 'AKA');
		self.remarks_1 := STD.Str.ToUpperCase(if(L.basis3 <> '', 'Basis : ' + (string)TRIM(L.basis3, left, right), ''));
		self.remarks_2 := STD.Str.ToUpperCase(if(TRIM(L.comments, left, right) <> '', 'Additional comments: ' + (string)TRIM(L.comments, left, right), ''));
		self.date_first_seen := L.last_vend_upd;
		self.date_last_seen := L.last_vend_upd;
		self.date_vendor_first_reported := L.last_vend_upd;
		self.date_vendor_last_reported := L.last_vend_upd;
		self.orig_entity_id := L.ID;
		self.orig_aka_id := '';
		self.orig_aka_type := if(L.ID[STD.Uni.Find(L.ID, '.', 1)+1..2+STD.Uni.Find(L.ID, '.', 1)+1-1] = '00', '', 'AKA');
		self.orig_aka_category := '';
		self.orig_giv_designator := 'G';
		self.orig_address_id := '';
		self.orig_address_line_1 := STD.Str.ToUpperCase((string)TRIM(L.Address[1..150], left, right));
		self.orig_address_country := (string)if(count(GlobalWatchLists_Preprocess.LookupFiles.dsCountryCodes(country_name_short = (string)STD.Uni.ToUpperCase(L.Address[1..44]))) > 0
																	,L.Address[1..44]
																	,if(count(GlobalWatchLists_Preprocess.LookupFiles.dsCountryCodes(country_name_alt = (string)STD.Uni.ToUpperCase(L.Address[1..55]))) > 0
																		,L.Address[1..55]
																		,if(count(GlobalWatchLists_Preprocess.LookupFiles.dsCountryCodes(country_name_short = (string)STD.Uni.ToUpperCase(L.Address[STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2..44 + STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2-1]))) > 0
																			,L.Address[STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2..44 + STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2-1]
																			,if(count(GlobalWatchLists_Preprocess.LookupFiles.dsCountryCodes(country_name_alt = (string)STD.Uni.ToUpperCase(L.Address[STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2..55 + STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2-1]))) > 0
																				,L.Address[STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2..55 + STD.Uni.Find(L.Address, ',', STD.Str.FindCount((string)L.Address, ','))+2-1]
																				,if(STD.Uni.Find(L.Address, ' USA', 1) > 0 or STD.Uni.Find(L.Address, ' U.S.A.', 1) > 0
																					,'UNITED STATES'
																					,'')))));
		self.orig_remarks := STD.Str.ToUpperCase((string)TRIM(L.comments, left, right));
		self.orig_grounds := STD.Str.ToUpperCase(if(L.basis3 <> '', 'Basis : ' + (string)TRIM(L.basis3, left, right)[1..200], ''));
		self.addr_1 := STD.Str.ToUpperCase((string)if(length(STD.Uni.Filter(TRIM(v_temp_address, left, right), ',')) >= 3
											,TRIM(v_temp_address, left, right)[1..STD.Uni.Find(trim(v_temp_address, left, right), ',', STD.Str.FindCount((string)v_temp_address, ','))-1][
												1..STD.Uni.Find(trim(v_temp_address, left, right)[1..STD.Uni.Find(trim(v_temp_address, left, right), ',', STD.Str.FindCount((string)v_temp_address, ','))-1]
												, ',', STD.Str.FindCount((string)trim(v_temp_address, left, right)[1..STD.Uni.Find(trim(v_temp_address, left, right), ',', STD.Str.FindCount((string)v_temp_address, ','))-1], ','))-1]
											,TRIM(v_temp_address, left, right)[1..STD.Uni.Find(TRIM(v_temp_address, left, right), ',', 1)-1]));
		self.addr_2 := STD.Str.ToUpperCase((string)if(length(STD.Uni.Filter(TRIM(v_temp_address, left, right), ',')) >= 3
											,TRIM(v_temp_address, left, right)
												[STD.Uni.Find(TRIM(v_temp_address, left, right)[1..STD.Uni.Find(TRIM(v_temp_address, left, right), ',', STD.Str.FindCount((string)v_temp_address, ','))-1], ',', STD.Str.FindCount((string)TRIM(v_temp_address, left, right)[1..STD.Uni.Find(TRIM(v_temp_address, left, right), ',', STD.Str.FindCount((string)v_temp_address, ','))-1], ','))+1
												..(length(TRIM(v_temp_address, left, right))-(STD.Uni.Find(TRIM(v_temp_address, left, right)[1..STD.Uni.Find(TRIM(v_temp_address, left, right), ',', STD.Str.FindCount((string)v_temp_address, ','))-1], ',', STD.Str.FindCount((string)TRIM(v_temp_address, left, right)[1..STD.Uni.Find(TRIM(v_temp_address, left, right), ',', STD.Str.FindCount((string)v_temp_address, ','))-1], ','))+1))+2+
												STD.Uni.Find(TRIM(v_temp_address, left, right)[1..STD.Uni.Find(TRIM(v_temp_address, left, right), ',', STD.Str.FindCount((string)v_temp_address, ','))-1], ',', STD.Str.FindCount((string)TRIM(v_temp_address, left, right)[1..STD.Uni.Find(TRIM(v_temp_address, left, right), ',', STD.Str.FindCount((string)v_temp_address, ','))-1], ','))+1-1]
											,TRIM(v_temp_address, left, right)[
												STD.Uni.Find(TRIM(v_temp_address, left, right), ',', 1)+1..(length(TRIM(v_temp_address, left, right))- (STD.Uni.Find(TRIM(v_temp_address, left, right), ',', 1))+2) + STD.Uni.Find(TRIM(v_temp_address, left, right), ',', 1)+1-1]));
	self.orig_raw_name	:= ut.CleanSpacesAndUpper(L.orig_raw_name);
	END;
	
	GlobalWatchLists_Preprocess.rOutLayout  CleanAddress(GlobalWatchLists_Preprocess.rOutLayout L) := TRANSFORM
		line1 := TRIM(L.addr_1, left, right);
		line2 := TRIM(L.addr_2, left, right)[1..STD.Uni.Find(TRIM(L.addr_2, left, right), ',', 1)-1] + ' ' + TRIM(L.addr_2, left, right)[STD.Uni.Find(TRIM(L.addr_2, left, right), ',', 1)+1..2+STD.Uni.Find(TRIM(L.addr_2, left, right), ',', 1)+1-1];
		v_addr_clean := bo_address.CleanAddress182(line1, line2);
		self.addr_clean := if(v_addr_clean[179..180] <> 'E5' and v_addr_clean[179..182] not in ['E213', 'E101'],
													if(v_addr_clean[178] = '5' and v_addr_clean[179] = 'E', v_addr_clean[1..177] + ' ' + v_addr_clean[179..182], v_addr_clean), 
													'');
		self.orig_raw_name	:= ut.CleanSpacesAndUpper(L.orig_raw_name);
		self := L;
	END;
	
	dsCommonOut	:= project(project(project(j1, xFromAddress(left)), ReformatToCommonlayout(left)), CleanAddress(left));
	
	return dsCommonOut(orig_pty_name <> '');
	
END;