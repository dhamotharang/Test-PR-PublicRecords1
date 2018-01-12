import std, address, bo_address;

ReformatDOB := FUNCTION

		GlobalWatchlists_Preprocess.Layouts.rInputBOE xFormDOB(GlobalWatchlists_Preprocess.Layouts.rInputBOE L) := TRANSFORM
  		YmdDate := REGEXFIND('(.*)/(.*)/(.*)',L.DOB,3)+REGEXFIND('(.*)/(.*)/(.*)',L.DOB,1)+REGEXFIND('(.*)/(.*)/(.*)',L.DOB,2);
   		self.DOB := if(L.DOB <> '', YmdDate, L.DOB);
   		self.Post_Zip_Code := TRIM(regexreplace('[(].+[)]', L.Post_Zip_Code, ''), left, right);
   		self := L;
   	END;
   	
   	return PROJECT(GlobalWatchlists_Preprocess.Files.dsBankOfEngland, xFormDOB(left));
		
END;

MapToOld(DATASET(GlobalWatchlists_Preprocess.Layouts.rInputBOE) ds_in) := FUNCTION

	GlobalWatchlists_Preprocess.IntermediaryLayoutBankOfEngland.BaseLayout xFormToOld(GlobalWatchlists_Preprocess.Layouts.rInputBOE L) := TRANSFORM
		self.ent_key 						:= 'BES' + TRIM(L.Group_ID, left, right);
		self.source 						:= 'Bank of England Sanctions';
		self.lst_vend_upd 			:= GlobalWatchLists_Preprocess.Versions.BankOfEngland_Version;
		self.lstd_entity 				:= STD.Str.ToUpperCase(TRIM(if(TRIM(L.Title, left, right) = '', '', TRIM(L.Title, left, right) + ' ')
																	 + if(TRIM(L.Name_1, left, right) = '', '', TRIM(L.Name_1, left, right) + ' ')
																	 + if(TRIM(L.Name_2, left, right) = '', '', TRIM(L.Name_2, left, right) + ' ')
																	 + if(TRIM(L.Name_3, left, right) = '', '', TRIM(L.Name_3, left, right) + ' ')
																	 + if(TRIM(L.Name_4, left, right) = '', '', TRIM(L.Name_4, left, right) + ' ')
																	 + if(TRIM(L.Name_5, left, right) = '', '', TRIM(L.Name_5, left, right) + ' ')
																	 + if(TRIM(L.Name_6, left, right) = '', '', TRIM(L.Name_6, left, right) + ' '), left, right))[1..80];
			 
		self.first_name 				:=  STD.Str.ToUpperCase(TRIM(if(TRIM(L.Name_1, left, right) = '', '', TRIM(L.Name_1, left, right) + ' ')
																									+ if(TRIM(L.Name_2, left, right) = '', '', TRIM(L.Name_2, left, right) + ' ')
																									+ if(TRIM(L.Name_3, left, right) = '', '', TRIM(L.Name_3, left, right) + ' ')
																									+ if(TRIM(L.Name_4, left, right) = '', '', TRIM(L.Name_4, left, right) + ' ')
																									+ if(TRIM(L.Name_5, left, right) = '', '', TRIM(L.Name_5, left, right) + ' '), left, right));
		
		self.last_name 					:= STD.Str.ToUpperCase(TRIM(L.Name_6, left, right));
		self.title 							:= STD.Str.ToUpperCase(TRIM(L.Title, left, right));
		self.dob 								:= IF(L.DOB[5..8] = '0000',TRIM(L.DOB,left,right)[1..4],TRIM(L.DOB, left, right));
		self.Town_of_Birth 			:= STD.Str.ToUpperCase(if(length(L.Town_of_Birth) > 225, regexreplace('Province', TRIM(L.Town_of_Birth, left, right), 'Prov.')
																										 ,TRIM(L.Town_of_Birth, left, right)));
		self.Country_of_Birth 	:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Country_of_Birth,'Afghanistan (in the area bordering Chaman district, Quetta, Pakistan)','Afghanistan (area bordering Chaman dist., Quetta, Pakistan)'), left, right));
		self.Nationality 				:= STD.Str.ToUpperCase(TRIM(L.Nationality, left, right));
		self.Passport_Details 	:= STD.Str.ToUpperCase(TRIM(L.Passport_Details, left, right));
		self.NI_Number 					:= TRIM(L.NI_Number, left, right)[1..125];
		v_pos										:= STD.Str.FindReplace(
																STD.Str.FindReplace(
																	STD.Str.FindReplace(
																		STD.Str.FindReplace(
																			STD.Str.FindReplace(
																				STD.Str.FindReplace(
																					STD.Str.FindReplace(L.Position, ' and the ', ' (2) ')
																				,') and', '(2) and')
																			, '. Possibly', '(2) Possibly')
																		, ', ZANU', '(2) ZANU')
																	, ' (ZANU (', ' (2) ZANU (')
																, ' and ZANU', ' (2) ZANU')
															, 'as well as Ministry', '(2) Minister.');
		self.position 					:= STD.Str.ToUpperCase(if(length(L.Position) < 120
																									,TRIM(v_pos, left, right)
																									,TRIM(STD.Str.FindReplace(v_pos, ' and ', ' & '), left, right)));
		self.Address_1 					:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_1,', ',','), left, right));
		self.Address_2 					:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_2,', ',','), left, right));
		self.Address_3 					:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_3,', ',','), left, right));
		self.Address_4 					:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_4,', ',','), left, right));
		self.Address_5 					:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_5,', ',','), left, right));
		self.Address_6 					:= STD.Str.ToUpperCase(TRIM(STD.Str.FindReplace(L.Address_6,', ',','), left, right));
		self.Post_Zip_Code 			:= TRIM(L.Post_Zip_Code, left, right);
		self.Country 						:= STD.Str.ToUpperCase(TRIM(L.Country, left, right));
		self.address_addl_info 	:= STD.Str.ToUpperCase(TRIM(L.Other_Information, left, right));
		self.Group_Type 				:= STD.Str.ToUpperCase(TRIM(L.Group_Type, left, right));
		self.alias_type 				:= STD.Str.ToUpperCase(TRIM(L.alias_type, left, right));
		self.Regime 						:= STD.Str.ToUpperCase(TRIM(L.Regime, left, right));
		self.Listed_On 					:= STD.Str.ToUpperCase(TRIM(L.Listed_On, left, right));
		self.Last_Updated 			:= TRIM(L.Last_Updated, left, right);
		self.Group_ID 					:= TRIM(L.Group_ID, left, right);
		self										:= [];
	END;
	
	return PROJECT(ds_in, xFormToOld(left));
END;

CleanNameAndAddress(DATASET(GlobalWatchlists_Preprocess.IntermediaryLayoutBankOfEngland.BaseLayout) ds_in) := FUNCTION
	
	GlobalWatchlists_Preprocess.IntermediaryLayoutBankOfEngland.BaseLayout xForm(GlobalWatchlists_Preprocess.IntermediaryLayoutBankOfEngland.BaseLayout L) := TRANSFORM
		integer4 	v_name_length 				:= 0;
		string73 	v_fname_cleaned 			:= if(TRIM(L.Group_Type, left, right) = 'INDIVIDUAL'
																				,Address.CleanPersonFML73((string)(L.first_name + ' ' + L.last_name))
																				,'');
		string73 	v_lname_cleaned 			:= if(TRIM(L.Group_Type, left, right) = 'INDIVIDUAL'
																				,Address.CleanPersonLFM73((string)(L.last_name + ', ' + L.first_name))
																				,'');
		integer4 	v_fname_clean_length 	:= length(TRIM(v_fname_cleaned[6..25], left, right))
																				+ length(TRIM(v_fname_cleaned[26..45], left, right))
																				+ length(TRIM(v_fname_cleaned[46..65], left, right));
		integer4 	v_lname_clean_length 	:= length(TRIM(v_lname_cleaned[6..25], left, right))
																				+ length(TRIM(v_lname_cleaned[26..45], left, right))
																				+ length(TRIM(v_lname_cleaned[46..65], left, right));
		string73 	v_name_cleaned 				:= if(v_fname_clean_length > v_lname_clean_length
																				,if(length(TRIM(L.title, left, right)) = 2 and TRIM(v_fname_cleaned[1..5], left, right) = ''
																							,TRIM(STD.Str.ToUpperCase(L.title), left, right) + '   ' + v_fname_cleaned[6..73]
																							,v_fname_cleaned)
																				,if(length(TRIM(L.title, left, right)) = 2 and TRIM(v_lname_cleaned[1..5], left, right) = ''
																							,TRIM(STD.Str.ToUpperCase(L.title), left, right) + '   ' + v_lname_cleaned[6..73]                                                                                                                            
                                              ,v_lname_cleaned));
		self.first_name 								:= if(TRIM(L.Group_Type, left, right) = 'INDIVIDUAL', L.first_name, '');
		self.last_name 									:= if(TRIM(L.Group_Type, left, right) = 'INDIVIDUAL', L.last_name, '');
		self.dob 												:= L.dob;																	
		self.position 									:= TRIM(STD.Str.FindReplace(L.position,'. MAYOR OF NAYPYIDAW',' OR MAYOR OF NAYPYIDAW'), left, right);
		
		self.the_name.name_prefix				:= v_name_cleaned[1..5];
		self.the_name.name_first				:= v_name_cleaned[6..25];
		self.the_name.name_middle				:= v_name_cleaned[26..45];
		self.the_name.name_last					:= v_name_cleaned[46..65];
		self.the_name.name_suffix				:= v_name_cleaned[66..70];
		self.the_name.name_score				:= v_name_cleaned[71..73];
		self.the_name.name							:= v_name_cleaned;
		
		string line1 										:= (string)(REGEXREPLACE('\\(AKA (.*)\\)',STD.Str.FindReplace(TRIM(L.Address_1, left, right), 'FORMER LOCATION - ',''),'')
																			+ ' ' + TRIM(L.Address_2, left, right) + ' '
																			+ TRIM(L.Address_3, left, right) + ' ' + TRIM(L.Address_4, left, right));
		string line2 										:= (string)(TRIM(L.Address_5, left, right) + ' ' + TRIM(L.Address_6) + ' '
																			+ TRIM(L.Post_Zip_Code, left, right) + ' ');
																			
 		string182 clean_addr := bo_address.CleanAddress182(line1, line2);
				
		self.the_address.prim_range 	:=  clean_addr[1..10];
    self.the_address.predir 			:= 	clean_addr[11..12];
    self.the_address.prim_name 		:= 	clean_addr[13..40];
    self.the_address.addr_suffix 	:= 	clean_addr[41..44];
    self.the_address.postdir 			:= 	clean_addr[45..46];
    self.the_address.unit_desig 	:= 	clean_addr[47..56];
    self.the_address.sec_range 		:= 	clean_addr[57..64];
    self.the_address.p_city_name 	:= 	clean_addr[65..89];
    self.the_address.v_city_name 	:= 	clean_addr[90..114];
    self.the_address.st 					:= 	clean_addr[115..116];
    self.the_address.zip 					:= 	clean_addr[117..121];
    self.the_address.zip4 				:= 	clean_addr[122..125];
    self.the_address.cart 				:= 	clean_addr[126..129];
    self.the_address.cr_sort_sz 	:= 	clean_addr[130];
    self.the_address.lot 					:= 	clean_addr[131..134];
    self.the_address.lot_order 		:= 	clean_addr[135];
    self.the_address.dpbc 				:= 	clean_addr[136..137];
    self.the_address.chk_digit 		:= 	clean_addr[138];
    self.the_address.record_type 	:= 	clean_addr[139..140];
    self.the_address.ace_fips_st 	:= 	clean_addr[141..142];
    self.the_address.fipscounty 	:= 	clean_addr[143..145];
    self.the_address.geo_lat 			:= 	clean_addr[146..155];
    self.the_address.geo_long 		:= 	clean_addr[156..166];
    self.the_address.msa 					:= 	clean_addr[167..170];
    self.the_address.geo_blk 			:= 	clean_addr[171..177];
    self.the_address.geo_match 		:= 	clean_addr[178];//' ';
    self.the_address.err_stat 		:= 	clean_addr[179..182];
		self.the_address.address			:= 	clean_addr;//clean_addr[1..177] + ' ' + clean_addr[179..182];
		self := L;
	END;
	
	return PROJECT(ds_in, xForm(left));
	
END;

ReformatToCommonlayout(DATASET(GlobalWatchlists_Preprocess.IntermediaryLayoutBankOfEngland.BaseLayout) ds_in) := FUNCTION
	
	GlobalWatchlists_Preprocess.rOutLayout xForm(GlobalWatchlists_Preprocess.IntermediaryLayoutBankOfEngland.BaseLayout L) := TRANSFORM
		integer2 v_max_passports := if(STD.Str.Find(L.Passport_Details, '(8)', 1) > 0
																	,8
																	,if(STD.Str.Find(L.Passport_Details, '(7)', 1) > 0
																	,6
																	,if(STD.Str.Find(L.Passport_Details, '(6)', 1) > 0
																	,5
																	,if(STD.Str.Find(L.Passport_Details, '(5)', 1) > 0
																	,4
																	,if(STD.Str.Find(L.Passport_Details, '(4)', 1) > 0
																	,4
																	,if(STD.Str.Find(L.Passport_Details, '(3)', 1) > 0
																	,3
																	,if(STD.Str.Find(L.Passport_Details, '(2)', 1) > 0
																	,2
																	,if(STD.Str.Find(L.Passport_Details, '(1)', 1) > 0
																	,1
																	,if(TRIM(L.Passport_Details, left, right) <> ''
																	,1
																	,0)))))))));
																	
		integer2 v_max_towns_of_birth := if(STD.Str.Find(L.Town_of_Birth, '(10)', 1) > 0
																	,10
																	,if(STD.Str.Find(L.Town_of_Birth, '(9)', 1) > 0
																	,9
																	,if(STD.Str.Find(L.Town_of_Birth, '(8)', 1) > 0
																	,8
																	,if(STD.Str.Find(L.Town_of_Birth, '(7)', 1) > 0
																	,7
																	,if(STD.Str.Find(L.Town_of_Birth, '(6)', 1) > 0
																	,6
																	,if(STD.Str.Find(L.Town_of_Birth, '(5)', 1) > 0
																	,5
																	,if(STD.Str.Find(L.Town_of_Birth, '(4)', 1) > 0
																	,4
																	,if(STD.Str.Find(L.Town_of_Birth, '(3)', 1) > 0
																	,3
																	,if(STD.Str.Find(L.Town_of_Birth, '(2)', 1) > 0 or STD.Str.Find(L.Town_of_Birth, ' OR ', 1) > 0
																	,2
																	,if(STD.Str.Find(L.Town_of_Birth, '(1)', 1) > 0
																	,1
																	,if(TRIM(L.Town_of_Birth, left, right) <> ''
																	,1
																	,0)))))))))));

		string176 v_temp_country_of_birth := STD.Str.FindReplace(L.Country_of_Birth
													,'(1) TO (6) ALGERIA'
													,'(1) ALGERIA (2) ALGERIA (3) ALGERIA  (4) ALGERIA  (5) ALGERIA  (6) ALGERIA');
		
		integer2 v_max_countries_of_birth := if(STD.Str.Find(v_temp_country_of_birth, '(10)', 1) > 0
																	,10
																	,if(STD.Str.Find(v_temp_country_of_birth, '(9)', 1) > 0
																	,9
																	,if(STD.Str.Find(v_temp_country_of_birth, '(8)', 1) > 0
																	,8
																	,if(STD.Str.Find(v_temp_country_of_birth, '(7)', 1) > 0
																	,7
																	,if(STD.Str.Find(v_temp_country_of_birth, '(6)', 1) > 0
																	,6
																	,if(STD.Str.Find(v_temp_country_of_birth, '(5)', 1) > 0
																	,5
																	,if(STD.Str.Find(v_temp_country_of_birth, '(4)', 1) > 0
																	,4
																	,if(STD.Str.Find(v_temp_country_of_birth, '(3)', 1) > 0
																	,3
																	,if(STD.Str.Find(v_temp_country_of_birth, '(2)', 1) > 0 or STD.Str.Find(v_temp_country_of_birth, ' OR ', 1) > 0
																	,2
																	,if(STD.Str.Find(v_temp_country_of_birth, '(1)', 1) > 0
																	,1
																	,if(TRIM(v_temp_country_of_birth, left, right) <> ''
																	,1
																	,0)))))))))));
																	
		integer2 v_max_positions := if(STD.Str.Find(L.position, '(10)', 1) > 0
																,10
																,if(STD.Str.Find(L.position, '(9)', 1) > 0
																,9
																,if(STD.Str.Find(L.position, '(8)', 1) > 0
																,8
																,if(STD.Str.Find(L.position, '(7)', 1) > 0
																,7
																,if(STD.Str.Find(L.position, '(6)', 1) > 0
																,6
																,if(STD.Str.Find(L.position, '(5)', 1) > 0
																,5
																,if(STD.Str.Find(L.position, '(4)', 1) > 0
																,4
																,if(STD.Str.Find(L.position, '(3)', 1) > 0
																,3
																,if(STD.Str.Find(L.position, '(2)', 1) > 0 or STD.Str.Find(L.position, ' OR ', 1) > 0
																,2
																,if(STD.Str.Find(L.position, '(1)', 1) > 0
																,1
																,if(TRIM(L.Town_of_Birth, left, right) <> ''
																,1
																,0)))))))))));
		 
		string1 v_keep_compname := if(STD.Str.Find(STD.Str.ToUpperCase(L.Group_Type), 'ENTITY', 1) <> 0, 'Y', '');
		string1 v_keep_lfmname 	:= if(STD.Str.Find(STD.Str.ToUpperCase(L.Group_Type), 'ENTITY', 1) <> 0, '', 'Y');
		self.pty_key 						:= L.ent_key;
		self.source 						:= L.source;
		self.orig_pty_name 			:= L.lstd_entity;
		self.orig_vessel_name 	:= '';
		self.country 						:= TRIM(L.Country, left, right);
		self.name_type 					:= if(STD.Str.Find(STD.Str.ToUpperCase(L.alias_type),'PRIME', 1) = 0, TRIM(L.alias_type, left, right), '');
		self.addr_1 						:= TRIM(TRIM(L.Address_1, left, right) + ' ' + TRIM(L.Address_2, left, right));
		self.addr_2 						:= TRIM(TRIM(L.Address_3, left, right) + ' ' + TRIM(L.Address_4, left, right));
		self.addr_3 						:= STD.Str.FindReplace(TRIM(TRIM(L.Address_5, left, right) + ' '
																						+ TRIM(L.Address_6, left, right) + ' '
																						+ TRIM(L.Post_Zip_Code, left, right) + ' '
																						+ TRIM(L.Country, left, right))
																,'  ',' ');
		self.remarks_1 					:= if(TRIM(L.position, left, right) <> ''
																			,'POSITION: ' + TRIM(L.position, left, right)
                                      ,'');
		self.remarks_2 					:= if(TRIM(STD.Str.FindReplace(TRIM(L.dob, left, right),'/  /',''), left, right) <> ''
																			,TRIM('DATE OF BIRTH: ' + TRIM(L.dob, left, right), left, right)
																			,'');
		self.remarks_3 					:= if(L.Town_of_Birth <> ''
																			,TRIM('TOWN OF BIRTH: ' + TRIM(L.Town_of_Birth, left, right), left, right)
																			,'');
		self.remarks_4 					:= if(L.Country_of_Birth <> ''
																			,TRIM('COUNTRY OF BIRTH: ' + TRIM(L.Country_of_Birth, left, right), left, right)
																			,'');
		self.remarks_5 					:= if(L.Nationality <> ''
																			,TRIM('NATIONALITY: ' + TRIM(L.Nationality, left, right), left, right)
																			,'');
		self.remarks_6 					:= if(L.Passport_Details <> ''
																			,TRIM('PASSPORT DETAILS: ' + TRIM(L.Passport_Details, left, right), left, right)
																			,'');
		self.remarks_7 					:= if(L.NI_Number <> '' and STD.Str.Find(L.NI_Number, 'SSN ', 1) = 0
																			,TRIM('NI NUMBER: ' + TRIM(L.NI_Number, left, right), left, right)
																			,if(L.NI_Number <> '' and STD.Str.Find(L.NI_Number, 'SSN ', 1)  > 0
																				,TRIM('NI NUMBER: ' + regexreplace('....%%%%', regexreplace('SSN ...-..-....', TRIM(L.NI_Number, left, right), '$0%%%%'), 'xxxx'), left, right)
                                        ,''));
		self.remarks_8 					:= if(L.Regime <> ''
																			,TRIM('REGIME: ' + TRIM(L.Regime, left, right), left, right)
																			,'');
		self.remarks_9 					:= (string)if(L.address_addl_info <> ''
																			,'OTHER INFORMATION: ' + TRIM(L.address_addl_info, left, right)
																			,'');
		self.cname_clean 				:= if(v_keep_compname = 'Y'
																			,STD.Str.ToUpperCase(TRIM(L.lstd_entity, left, right))
																			,'');
 		self.pname_clean 				:= if(v_keep_lfmname = 'Y'
   																			,L.the_name.name
   																			,'');
		self.addr_clean 				:= if(L.the_address.err_stat[1..2] <> 'E5' and
																	L.the_address.err_stat[1..4] <> 'E213' and
																	L.the_address.err_stat[1..4] <> 'E101'
																,L.the_address.address
																,'');
		self.date_first_seen 		:= L.lst_vend_upd;
		self.date_last_seen 		:= L.lst_vend_upd;
		self.date_vendor_first_reported := GlobalWatchlists_Preprocess.fSlashedDMYtoYMD(L.Listed_On);
		self.date_vendor_last_reported 	:= GlobalWatchlists_Preprocess.fSlashedDMYtoYMD(L.Last_Updated);
		self.orig_entity_id 		:= L.Group_ID;
		self.orig_first_name 		:= L.first_name;
		self.orig_last_name 		:= L.last_name;
		self.orig_title_1 			:= L.title;
		self.orig_aka_id 				:= '';
		self.orig_aka_type 			:= L.alias_type;
		self.orig_aka_category 	:= '';
		self.orig_giv_designator := if(v_keep_lfmname = 'Y', 'I', 'G');
		self.orig_entity_type 	:= L.Group_Type;
		self.orig_address_id 		:= '';
		self.orig_address_line_1 			:= TRIM(TRIM(L.Address_1, left, right) + ' ' + TRIM(L.Address_2, left, right), left, right);
		self.orig_address_line_2 			:= TRIM(TRIM(L.Address_3, left, right) + ' ' + TRIM(L.Address_4, left, right), left, right);
		self.orig_address_line_3 			:= TRIM(TRIM(L.Address_5, left, right) + ' ' + TRIM(L.Address_6, left, right), left, right);
		self.orig_address_postal_code := L.Post_Zip_Code;
		self.orig_address_country 		:= TRIM(L.Country[1..60]);
		self.orig_remarks 						:= STD.Str.CleanSpaces(REGEXREPLACE('(\\[|\\])',(string)L.address_addl_info,' '));
		self.orig_passport_details 		:= if(length(TRIM(L.Passport_Details, left, right)) > 350
																					,TRIM(STD.Str.FindReplace(L.Passport_Details,'IVORIAN PASSPORT - NO DETAILS',''), left, right)[1..350]
                                          ,TRIM(L.Passport_Details, left, right));
		self.orig_ni_number_details 	:= TRIM(L.NI_Number, left, right);
		self.orig_nationality_1 			:= TRIM(if(STD.Str.Find(L.Nationality, '.', 1) > 0
																							,TRIM(L.Nationality[1..STD.Str.Find(L.Nationality, '.', 1)-1], left, right)
																							,if(STD.Str.Find(L.Nationality, '(2)', 1) > 0
																									,STD.Str.FindReplace(TRIM(L.Nationality[1..STD.Str.Find(L.Nationality, '(2)', 1)-1], left, right), '(1)', '')
																									,if(STD.Str.Find(L.Nationality, ' OR ', 1) > 0
																											,TRIM(L.Nationality[1..STD.Str.Find(L.Nationality, ' OR ', 1)-1], left, right)
																											,TRIM(L.Nationality, left, right)
																					))), left, right);
		self.orig_nationality_2 			:= if(STD.Str.Find(L.Nationality, '.', 1) > 0
																					,TRIM(L.Nationality[STD.Str.Find(L.Nationality, '.', 1)+1..60+STD.Str.Find(L.Nationality, '.', 1)+1-1], left, right)
																					,if(STD.Str.Find(L.Nationality, '(2)', 1) > 0
																							,TRIM(L.Nationality[STD.Str.Find(L.Nationality, '(2)', 1)+3..60+STD.Str.Find(L.Nationality, '.', 1)+3-1], left, right)
																							,if(STD.Str.Find(L.Nationality, ' OR ', 1) > 0
																									,TRIM(L.Nationality[STD.Str.Find(L.Nationality, ' OR ', 1)+4..60+STD.Str.Find(L.Nationality, '.', 1)+4-1], left, right)
																									,'')));
		self.orig_dob_1 							:= L.dob;
		self.orig_pob_1 							:= TRIM(if(STD.Str.Find(L.Town_of_Birth, '(2)', 1) > 0
																						,STD.Str.FindReplace(TRIM(L.Town_of_Birth[1..STD.Str.Find(L.Town_of_Birth,'(2)', 1)-1], left, right), '(1)', '')
																						,if(STD.Str.Find(L.Town_of_Birth, ' OR ') > 0
																								,TRIM(L.Town_of_Birth[1..STD.Str.Find(L.Town_of_Birth,' OR ', 1)-1], left, right)
																								,TRIM(L.Town_of_Birth, left, right)
																			)), left, right)[1..80];

		self.orig_pob_2 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.Town_of_Birth, '(2)', 1) > 0
																								,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, '(2)', 1)+3..
																												if(v_max_towns_of_birth > 2
																														,(STD.Str.Find(L.Town_of_Birth, '(3)', 1) - STD.Str.Find(L.Town_of_Birth, '(2)', 1) - 3) + STD.Str.Find(L.Town_of_Birth, '(2)', 1)+3-1
																														,60 + STD.Str.Find(L.Town_of_Birth, '(2)', 1)+3-1)], left, right)
																								,if(STD.Str.Find(L.Town_of_Birth, ' OR ', 1) > 0
																										,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, ' or ', 1)+4..60+STD.Str.Find(L.Town_of_Birth, ' OR ', 1)+4-1], left, right)
																										,'')
																	), '-'), left, right);
		self.orig_pob_3 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.Town_of_Birth, '(3)', 1) > 0
																								,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, '(3)', 1)+3..
                                                        if(v_max_towns_of_birth > 3
																														,(STD.Str.Find(L.Town_of_Birth, '(4)', 1) - STD.Str.Find(L.Town_of_Birth, '(3)', 1) - 3) + STD.Str.Find(L.Town_of_Birth, '(3)', 1)+3-1
																														,60 + STD.Str.Find(L.Town_of_Birth, '(3)', 1)+3-1)], left, right)
																								,'')
                                  ,'-'), left, right);
		self.orig_pob_4 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.Town_of_Birth, '(4)', 1) > 0
																								,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, '(4)', 1)+3..
																												if(v_max_towns_of_birth > 4
																														,(STD.Str.Find(L.Town_of_Birth, '(5)', 1) - STD.Str.Find(L.Town_of_Birth, '(4)', 1) - 3) + STD.Str.Find(L.Town_of_Birth, '(4)', 1)+3-1
																														,60 + STD.Str.Find(L.Town_of_Birth, '(4)', 1)+3-1)], left, right)
																								,'')
																	 ,'-'), left, right);
		self.orig_pob_5 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.Town_of_Birth, '(5)', 1) > 0
																								,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, '(5)', 1)+3..
                                                         if(v_max_towns_of_birth > 5
																														,(STD.Str.Find(L.Town_of_Birth, '(6)', 1) - STD.Str.Find(L.Town_of_Birth, '(5)', 1) - 3) + STD.Str.Find(L.Town_of_Birth, '(5)', 1)+3-1
																														,60 + STD.Str.Find(L.Town_of_Birth, '(5)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_pob_6 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.Town_of_Birth, '(6)', 1) > 0
																								,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, '(6)', 1)+3..
                                                          if(v_max_towns_of_birth > 6 
                                                             ,(STD.Str.Find(L.Town_of_Birth, '(7)', 1) - STD.Str.Find(L.Town_of_Birth, '(6)', 1) - 3) + STD.Str.Find(L.Town_of_Birth, '(6)', 1)+3-1
																														 ,60 + STD.Str.Find(L.Town_of_Birth, '(6)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_pob_7 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.Town_of_Birth, '(7)', 1) > 0
																								,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, '(7)', 1)+3..
                                                          if(v_max_towns_of_birth > 7
                                                             ,(STD.Str.Find(L.Town_of_Birth, '(8)', 1) - STD.Str.Find(L.Town_of_Birth, '(7)', 1) - 3) + STD.Str.Find(L.Town_of_Birth, '(7)', 1)+3-1
																														 ,60 + STD.Str.Find(L.Town_of_Birth, '(7)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_pob_8 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.Town_of_Birth, '(8)', 1) > 0
																								,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, '(8)', 1)+3..
                                                          if(v_max_towns_of_birth > 8
                                                             ,(STD.Str.Find(L.Town_of_Birth, '(9)', 1) - STD.Str.Find(L.Town_of_Birth, '(8)', 1) - 3) + STD.Str.Find(L.Town_of_Birth, '(8)', 1)+3-1
																														 ,60 + STD.Str.Find(L.Town_of_Birth, '(8)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_pob_9 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.Town_of_Birth, '(9)', 1) > 0
																								,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, '(9)', 1)+3..
                                                          if(v_max_towns_of_birth > 9
                                                             ,(STD.Str.Find(L.Town_of_Birth, '(10)', 1) - STD.Str.Find(L.Town_of_Birth, '(9)', 1) - 4) + STD.Str.Find(L.Town_of_Birth, '(9)', 1)+3-1
																														 ,60 + STD.Str.Find(L.Town_of_Birth, '(9)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_pob_10 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.Town_of_Birth, '(10)', 1) > 0
																								,TRIM(L.Town_of_Birth[STD.Str.Find(L.Town_of_Birth, '(10)', 1)+4..
																															60 + STD.Str.Find(L.Town_of_Birth, '(10)', 1)+4-1], left, right)
                                                ,'')
																		,'-'), left, right);
		self.orig_country_of_birth_1 	:= TRIM(if(STD.Str.Find(v_temp_country_of_birth, '(2)', 1) > 0
																								,STD.Str.FindReplace(TRIM(v_temp_country_of_birth[1..STD.Str.Find(v_temp_country_of_birth,'(2)', 1)-1], left, right), '(1)', '')
																								,if(STD.Str.Find(v_temp_country_of_birth, ' OR ', 1) > 0
																											,TRIM(v_temp_country_of_birth[1..STD.Str.Find(v_temp_country_of_birth, ' OR ', 1)-1], left, right)
																											,TRIM(v_temp_country_of_birth)
																					)), left, right)[1..60];
		self.orig_country_of_birth_2 	:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(v_temp_country_of_birth, '(2)', 1) > 0
																								,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, '(2)', 1)+3..
                                                      if(v_max_towns_of_birth > 2
																														,(STD.Str.Find(v_temp_country_of_birth, '(3)', 1) - STD.Str.Find(v_temp_country_of_birth, '(2)', 1) - 3) + STD.Str.Find(v_temp_country_of_birth, '(2)', 1)+3-1
																														,60 + STD.Str.Find(v_temp_country_of_birth, '(2)', 1)+3-1)], left, right)
																								,if(STD.Str.Find(v_temp_country_of_birth, ' OR ', 1) > 0
																											,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, ' OR ', 1)+4..60 + STD.Str.Find(v_temp_country_of_birth, ' or ', 1)+4-1], left, right)
																								,''))
																		,'-'), left, right);
		self.orig_country_of_birth_3 	:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(v_temp_country_of_birth, '(3)', 1) > 0
																								,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, '(3)', 1)+3..
                                                       if(v_max_towns_of_birth > 3
																														,(STD.Str.Find(v_temp_country_of_birth, '(4)', 1) - STD.Str.Find(v_temp_country_of_birth, '(3)', 1) - 3) + STD.Str.Find(v_temp_country_of_birth, '(3)', 1)+3-1
																														,60 + STD.Str.Find(v_temp_country_of_birth, '(3)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_country_of_birth_4 	:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(v_temp_country_of_birth, '(4)', 1) > 0
																								,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, '(4)', 1)+3..
                                                       if(v_max_towns_of_birth > 4
																														,(STD.Str.Find(v_temp_country_of_birth, '(5)', 1) - STD.Str.Find(v_temp_country_of_birth, '(4)', 1) - 3) + STD.Str.Find(v_temp_country_of_birth, '(4)', 1)+3-1
																														,60 + STD.Str.Find(v_temp_country_of_birth, '(4)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_country_of_birth_5 	:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(v_temp_country_of_birth, '(5)', 1) > 0
																								,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, '(5)', 1)+3..
                                                       if(v_max_towns_of_birth > 5
																														,(STD.Str.Find(v_temp_country_of_birth, '(6)', 1) - STD.Str.Find(v_temp_country_of_birth, '(5)', 1) - 3) + STD.Str.Find(v_temp_country_of_birth, '(5)', 1)+3-1
																														,60 + STD.Str.Find(v_temp_country_of_birth, '(5)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_country_of_birth_6 	:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(v_temp_country_of_birth, '(6)', 1) > 0
																								,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, '(6)', 1)+3..
                                                       if(v_max_towns_of_birth > 6
																														,(STD.Str.Find(v_temp_country_of_birth, '(7)', 1) - STD.Str.Find(v_temp_country_of_birth, '(6)', 1) - 3) + STD.Str.Find(v_temp_country_of_birth, '(6)', 1)+3-1
																														,60 + STD.Str.Find(v_temp_country_of_birth, '(6)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_country_of_birth_7 	:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(v_temp_country_of_birth, '(7)', 1) > 0
																								,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, '(7)', 1)+3..
                                                       if(v_max_towns_of_birth > 7
																														,(STD.Str.Find(v_temp_country_of_birth, '(8)', 1) - STD.Str.Find(v_temp_country_of_birth, '(7)', 1) - 3) + STD.Str.Find(v_temp_country_of_birth, '(7)', 1)+3-1
																														,60 + STD.Str.Find(v_temp_country_of_birth, '(7)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_country_of_birth_8 	:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(v_temp_country_of_birth, '(8)', 1) > 0
																								,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, '(8)', 1)+3..
                                                       if(v_max_towns_of_birth > 8
																														,(STD.Str.Find(v_temp_country_of_birth, '(9)', 1) - STD.Str.Find(v_temp_country_of_birth, '(8)', 1) - 3) + STD.Str.Find(v_temp_country_of_birth, '(8)', 1)+3-1
																														,60 + STD.Str.Find(v_temp_country_of_birth, '(8)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_country_of_birth_9 	:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(v_temp_country_of_birth, '(9)', 1) > 0
																								,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, '(9)', 1)+3..
                                                       if(v_max_towns_of_birth > 9
																														,(STD.Str.Find(v_temp_country_of_birth, '(10)', 1) - STD.Str.Find(v_temp_country_of_birth, '(9)', 1) - 4) + STD.Str.Find(v_temp_country_of_birth, '(9)', 1)+3-1
																														,60 + STD.Str.Find(v_temp_country_of_birth, '(9)', 1)+3-1)], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_country_of_birth_10 := TRIM(STD.Str.FilterOut(if(STD.Str.Find(v_temp_country_of_birth, '(10)', 1) > 0
																								,TRIM(v_temp_country_of_birth[STD.Str.Find(v_temp_country_of_birth, '(10)', 1)+4..                                                   
																														60 + STD.Str.Find(v_temp_country_of_birth, '(10)', 1)+4-1], left, right)
																								,'')
																		,'-'), left, right);
		self.orig_membership_1 				:= TRIM(L.Regime, left, right);
		self.orig_position_1 					:= TRIM(if(STD.Str.Find(L.position, '(2)', 1) > 0
																								,STD.Str.FindReplace(TRIM(L.position[1..STD.Str.Find(L.position, '(2)', 1)-1], left, right), '(1)', '')
																								,if(STD.Str.Find(L.position, ' or ', 1) > 0
																										,TRIM(L.position[1..STD.Str.Find(L.position, ' or ', 1)-1], left, right)
																										,if(STD.Str.Find(L.position, 'MINISTER OF STATE FOR NATIONAL SECURITY, LAND REFORM & RESETTLEMENT IN THE OFFICE', 1) > 0
																												,L.position[1..100]
																												,if(STD.Str.Find(L.position, 'DEPUTY MINISTER. PROGRESS OF BORDER AREAS AND NATIONAL RACES AND DEVELOPMENT AFFAIRS') > 0
																														,STD.Str.FindReplace(L.position, 'DEPUTY MINISTER.', 'DEP. MIN.')
																														,if(length(TRIM(L.position, left, right)) > 100
																																,TRIM(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(STD.Str.FindReplace(L.position,'Limited','Ltd'),', ',','),'Minister','Min.'),'Employment','Empl'),', ',','),'January','Jan'),'February','Feb'),'March','Mar'),'April','Apr'),'June','Jun'),'July','Jul'),'August','Aug'),'September','Sep'),'October','Oct'),'November','Nov'),'December','Dec'), left, right)[1..100]
																																,TRIM(L.position, left, right)
 
																					))))), left, right)[1..100];
		self.orig_position_2 					:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.position, '(2)', 1) > 0
																									,TRIM(L.position[STD.Str.Find(L.position, '(2)', 1) + 3..
                                                       if(v_max_positions > 2
																														,(STD.Str.Find(L.position, '(3)', 1) - STD.Str.Find(L.position, '(2)') - 3) + STD.Str.Find(L.position, '(2)', 1) + 3-1
																														,100 + STD.Str.Find(L.position, '(2)', 1) + 3-1)], left, right)
																									,if(STD.Str.Find(L.position, ' OR ') > 0
																												,TRIM(L.position[STD.Str.Find(L.position, ' OR ', 1)+4..60 + STD.Str.Find(L.position, ' OR ', 1)+4-1], left, right)
																												,'')
																					),'-'), left, right);
		self.orig_position_3 					:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.position, '(3)', 1) > 0
																									,TRIM(L.position[STD.Str.Find(L.position, '(3)', 1) + 3..
                                                       if(v_max_positions > 3
																														,(STD.Str.Find(L.position, '(4)', 1) - STD.Str.Find(L.position, '(3)') - 3) + STD.Str.Find(L.position, '(3)', 1) + 3-1
																														,100 + STD.Str.Find(L.position, '(3)', 1) + 3-1)], left, right)
																									,'')
																					,'-'), left, right);
		self.orig_position_4 					:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.position, '(4)', 1) > 0
																									,TRIM(L.position[STD.Str.Find(L.position, '(4)', 1) + 3..
                                                       if(v_max_positions > 4
																														,(STD.Str.Find(L.position, '(5)', 1) - STD.Str.Find(L.position, '(4)') - 3) + STD.Str.Find(L.position, '(4)', 1) + 3-1
																														,100 + STD.Str.Find(L.position, '(4)', 1) + 3-1)], left, right)
																									,'')
																					,'-'), left, right);
		self.orig_position_5 					:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.position, '(5)', 1) > 0
																									,TRIM(L.position[STD.Str.Find(L.position, '(5)', 1) + 3..
                                                       if(v_max_positions > 5
																														,(STD.Str.Find(L.position, '(6)', 1) - STD.Str.Find(L.position, '(5)') - 3) + STD.Str.Find(L.position, '(5)', 1) + 3-1
																														,100 + STD.Str.Find(L.position, '(5)', 1) + 3-1)], left, right)
																									,'')
																					,'-'), left, right);
		self.orig_position_6 					:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.position, '(6)', 1) > 0
																									,TRIM(L.position[STD.Str.Find(L.position, '(6)', 1) + 3..
                                                       if(v_max_positions > 6
																														,(STD.Str.Find(L.position, '(7)', 1) - STD.Str.Find(L.position, '(6)') - 3) + STD.Str.Find(L.position, '(6)', 1) + 3-1
																														,100 + STD.Str.Find(L.position, '(6)', 1) + 3-1)], left, right)
																									,'')
																					,'-'), left, right);
		self.orig_position_7 					:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.position, '(7)', 1) > 0
																									,TRIM(L.position[STD.Str.Find(L.position, '(7)', 1) + 3..
                                                       if(v_max_positions > 7
																														,(STD.Str.Find(L.position, '(8)', 1) - STD.Str.Find(L.position, '(7)') - 3) + STD.Str.Find(L.position, '(7)', 1) + 3-1
																														,100 + STD.Str.Find(L.position, '(7)', 1) + 3-1)], left, right)
																									,'')
																					,'-'), left, right);
		self.orig_position_8 					:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.position, '(8)', 1) > 0
																									,TRIM(L.position[STD.Str.Find(L.position, '(8)', 1) + 3..
                                                       if(v_max_positions > 8
																														,(STD.Str.Find(L.position, '(9)', 1) - STD.Str.Find(L.position, '(8)') - 3) + STD.Str.Find(L.position, '(8)', 1) + 3-1
																														,100 + STD.Str.Find(L.position, '(8)', 1) + 3-1)], left, right)
																									,'')
																					,'-'), left, right);
		self.orig_position_9					:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.position, '(9)', 1) > 0
																									,TRIM(L.position[STD.Str.Find(L.position, '(9)', 1) + 3..
                                                       if(v_max_positions > 9
																														,(STD.Str.Find(L.position, '(10)', 1) - STD.Str.Find(L.position, '(9)') - 4) + STD.Str.Find(L.position, '(9)', 1) + 3-1
																														,100 + STD.Str.Find(L.position, '(9)', 1) + 3-1)], left, right)
																									,'')
																					,'-'), left, right);
		self.orig_position_10					:= TRIM(STD.Str.FilterOut(if(STD.Str.Find(L.position, '(10)', 1) > 0
																									,TRIM(L.position[STD.Str.Find(L.position, '(10)', 1) + 4..
                                                       60 + STD.Str.Find(L.position, '(10)', 1) + 4-1], left, right)
																									,'')
																					,'-'), left, right);
		self.orig_date_added_to_list 	:= GlobalWatchlists_Preprocess.fSlashedDMYtoYMD(L.Listed_On);
		self.orig_date_last_updated 	:= GlobalWatchlists_Preprocess.fSlashedDMYtoYMD(L.Last_Updated);
		self.orig_raw_name := L.lstd_entity;
		self	:= [];
	END;
	
	return PROJECT(ds_in, xForm(left));
	
END;


EXPORT  ProcessBankOfEngland := FUNCTION
	return dedup(sort(ReformatToCommonlayout(CleanNameAndAddress(MapToOld(ReformatDOB))), pty_key, orig_pty_name, country, name_type, addr_1, addr_2, addr_3, remarks_1, remarks_2,remarks_3, remarks_4,remarks_5, remarks_6, remarks_7, remarks_8, remarks_9, cname_clean, pname_clean, addr_clean), RECORD);
END;