import GlobalWatchLists_Preprocess, std, address, bo_address, ut;

EXPORT ProcessInterpolMostWanted := FUNCTION

	FilteredIPMostWantedRecs := GlobalWatchLists_Preprocess.Files.dsInterpolMostWanted(FamilyName <> 'LastName' and FamilyName <> '');
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout1 ParseIndividualCitiations1(GlobalWatchLists_Preprocess.Layouts.rInterpolMostWanted L) := TRANSFORM
		integer2 v_pob_count 						:= if(TRIM(L.BirthPlace, left, right) <> '', length(STD.Str.Filter(L.BirthPlace, '/')) + 1, 0);
		integer2 v_language_count 			:= if(TRIM(L.Language, left, right) <> '', length(STD.Str.Filter(L.Language, ',')) + 1, 0);
		integer2 v_nationality_count 		:= if(TRIM(L.Nationality, left, right) <> '', length(STD.Str.Filter(L.Nationality, ',')) + 1, 0);
		string10 v_pob_padding					:= '//////////';
		string10 v_language_padding			:= ',,,,,,,,,,';
		string10 v_nationality_padding	:= ',,,,,,,,,,';
		
		self.FamilyName 							:= STD.Str.ToUpperCase(IF(STD.Str.Find(L.FamilyName, '(ALIAS', 1) > 0
																													,TRIM(L.FamilyName[1..STD.Str.Find(L.FamilyName, '(ALIAS', 1)-1], left, right)
																													,L.FamilyName));
		self.Name_Type 								:= '';
		self.BirthPlace_Parsed 				:= STD.Str.ToUpperCase(IF(TRIM(L.BirthPlace, left, right) <> ''
																												,TRIM(TRIM(STD.Str.FindReplace(STD.Str.FindReplace(L.BirthPlace, 'Former Yugoslav Republic of', 'Former Yugoslav Rep. of'), '"', ''), left, right) + v_pob_padding[1..10 - v_pob_count], left, right) 
																												,'/////////'));
		self.Language_Parsed 					:= STD.Str.ToUpperCase(IF(TRIM(L.Language, left, right) <> ''
																													,TRIM(TRIM(STD.Str.FindReplace(L.Language, '"', ''), left, right) + v_language_padding[1..10 - v_language_count], left, right)
																													,',,,,,,,,,'));
		self.Nationality_Parsed 			:= STD.Str.ToUpperCase(IF(TRIM(L.Nationality, left, right) <> ''
																													,TRIM(TRIM(STD.Str.FindReplace(L.Nationality, '"', ''), left, right) + v_nationality_padding[1..10 - v_nationality_count], left, right)
																													,',,,,,,,,,'));
		self.orig_raw_name						:= ut.CleanSpacesAndUpper(L.FamilyName+' '+L.Forename);
		self := L;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout1 ParseIndividualCitiations2(GlobalWatchLists_Preprocess.Layouts.rInterpolMostWanted L) := TRANSFORM
		integer2 v_pob_count 						:= if(TRIM(L.BirthPlace, left, right) <> '', length(STD.Str.Filter(L.BirthPlace, '/')) + 1, 0);
		integer2 v_language_count 			:= if(TRIM(L.Language, left, right) <> '', length(STD.Str.Filter(L.Language, ',')) + 1, 0);
		integer2 v_nationality_count 		:= if(TRIM(L.Nationality, left, right) <> '', length(STD.Str.Filter(L.Nationality, ',')) + 1, 0);
		string10 v_pob_padding					:= '//////////';
		string10 v_language_padding			:= ',,,,,,,,,,';
		string10 v_nationality_padding	:= ',,,,,,,,,,';
		
		
		self.FamilyName 				:= if(STD.Str.Find(L.FamilyName, '(ALIAS', 1) > 0
																,STD.Str.FindReplace(TRIM(L.FamilyName[STD.Str.Find(L.FamilyName, '(ALIAS', 1)+6..50+STD.Str.Find(L.FamilyName, '(ALIAS', 1)+6-1], left, right), ')', '')
																,'');
		self.Name_Type 					:= 'AKA';
		self.BirthPlace_Parsed 	:= if(TRIM(L.BirthPlace, left, right) <> ''
																,TRIM(TRIM(STD.Str.FindReplace(STD.Str.FindReplace(L.BirthPlace, 'Former Yugoslav Republic of', 'Former Yugoslav Rep. of'), '"', ''), left, right) + v_pob_padding[1..10 - v_pob_count], left, right)
																,'/////////');
		self.Language_Parsed 		:= if(TRIM(L.Language, left, right) <> ''
																,TRIM(TRIM(STD.Str.FindReplace(L.Language, '"', ''), left, right) + v_language_padding[1..10 - v_language_count], left, right)
																,',,,,,,,,,');
		self.Nationality_Parsed := if(TRIM(L.Nationality, left, right) <> ''
																,TRIM(TRIM(STD.Str.FindReplace(L.Nationality, '"', ''), left, right) + v_nationality_padding[1..10 - v_nationality_count], left, right)
																,',,,,,,,,,');
		self := L;
		self.orig_raw_name			:= ut.CleanSpacesAndUpper(L.FamilyName+' '+L.Forename);
	END;
	
	uniqIPrecs := dedup(sort(FilteredIPMostWantedRecs, Forename, FamilyName, Sex, DateofBirth, BirthPlace, Language, Nationality, Offenses, WarrantBy_1, Height, Weight, Hair, Eyes, PhotoName), Forename, FamilyName, Sex, DateofBirth, BirthPlace, Language, Nationality, Offenses, WarrantBy_1, Height, Weight, Hair, Eyes, PhotoName);
	
	IPMostWantedRecs 							:= PROJECT(uniqIPrecs, ParseIndividualCitiations1(left)) + PROJECT(uniqIPrecs, ParseIndividualCitiations2(left));
	IPMostWantedRecsNotNullNames  := IPMostWantedRecs(TRIM(FamilyName, left, right) <> '');

	GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout2 RedfineWithSeparateCitations(GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout1 L) := TRANSFORM
		self.Original_POB_01 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[1..STD.Str.Find(L.BirthPlace_Parsed, '/', 1)-1]
													,'');
		self.Original_POB_02 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[STD.Str.Find(L.BirthPlace_Parsed, '/', 1) + 1..STD.Str.Find(L.BirthPlace_Parsed, '/', 2)-1]
													,'');
		self.Original_POB_03 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[STD.Str.Find(L.BirthPlace_Parsed, '/', 2) + 1..STD.Str.Find(L.BirthPlace_Parsed, '/', 3)-1]
													,'');
		self.Original_POB_04 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[STD.Str.Find(L.BirthPlace_Parsed, '/', 3) + 1..STD.Str.Find(L.BirthPlace_Parsed, '/', 4)-1]
													,'');
		self.Original_POB_05 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[STD.Str.Find(L.BirthPlace_Parsed, '/', 4) + 1..STD.Str.Find(L.BirthPlace_Parsed, '/', 5)-1]
													,'');
		self.Original_POB_06 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[STD.Str.Find(L.BirthPlace_Parsed, '/', 5) + 1..STD.Str.Find(L.BirthPlace_Parsed, '/', 6)-1]
													,'');
		self.Original_POB_07 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[STD.Str.Find(L.BirthPlace_Parsed, '/', 6) + 1..STD.Str.Find(L.BirthPlace_Parsed, '/', 7)-1]
													,'');	
		self.Original_POB_08 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[STD.Str.Find(L.BirthPlace_Parsed, '/', 7) + 1..STD.Str.Find(L.BirthPlace_Parsed, '/', 8)-1]
													,'');
		self.Original_POB_09 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[STD.Str.Find(L.BirthPlace_Parsed, '/', 8) + 1..STD.Str.Find(L.BirthPlace_Parsed, '/', 9)-1]
													,'');
		self.Original_POB_10 := if(TRIM(L.BirthPlace_Parsed, left, right) <> ''
													,L.BirthPlace_Parsed[STD.Str.Find(L.BirthPlace_Parsed, '/', 9) + 1..]
													,'');
		self.Original_Language_01 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[1..STD.Str.Find(L.Language_Parsed, ',', 1)-1]
													,'');
		self.Original_Language_02 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[STD.Str.Find(L.Language_Parsed, ',', 1) + 1..STD.Str.Find(L.Language_Parsed, ',', 2)-1]
													,'');
		self.Original_Language_03 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[STD.Str.Find(L.Language_Parsed, ',', 2) + 1..STD.Str.Find(L.Language_Parsed, ',', 3)-1]
													,'');
		self.Original_Language_04 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[STD.Str.Find(L.Language_Parsed, ',', 3) + 1..STD.Str.Find(L.Language_Parsed, ',', 4)-1]
													,'');
		self.Original_Language_05 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[STD.Str.Find(L.Language_Parsed, ',', 4) + 1..STD.Str.Find(L.Language_Parsed, ',', 5)-1]
													,'');
		self.Original_Language_06 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[STD.Str.Find(L.Language_Parsed, ',', 5) + 1..STD.Str.Find(L.Language_Parsed, ',', 6)-1]
													,'');
		self.Original_Language_07 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[STD.Str.Find(L.Language_Parsed, ',', 6) + 1..STD.Str.Find(L.Language_Parsed, ',', 7)-1]
													,'');	
		self.Original_Language_08 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[STD.Str.Find(L.Language_Parsed, ',', 7) + 1..STD.Str.Find(L.Language_Parsed, ',', 8)-1]
													,'');
		self.Original_Language_09 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[STD.Str.Find(L.Language_Parsed, ',', 8) + 1..STD.Str.Find(L.Language_Parsed, ',', 9)-1]
													,'');
		self.Original_Language_10 := if(TRIM(L.Language_Parsed, left, right) <> ''
													,L.Language_Parsed[STD.Str.Find(L.Language_Parsed, ',', 9) + 1..]
													,'');
    self.Original_Nationality_01 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[1..STD.Str.Find(L.Nationality_Parsed, ',', 1)-1]
													,'');
		self.Original_Nationality_02 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[STD.Str.Find(L.Nationality_Parsed, ',', 1) + 1..STD.Str.Find(L.Nationality_Parsed, ',', 2)-1]
													,'');
		self.Original_Nationality_03 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[STD.Str.Find(L.Nationality_Parsed, ',', 2) + 1..STD.Str.Find(L.Nationality_Parsed, ',', 3)-1]
													,'');
		self.Original_Nationality_04 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[STD.Str.Find(L.Nationality_Parsed, ',', 3) + 1..STD.Str.Find(L.Nationality_Parsed, ',', 4)-1]
													,'');
		self.Original_Nationality_05 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[STD.Str.Find(L.Nationality_Parsed, ',', 4) + 1..STD.Str.Find(L.Nationality_Parsed, ',', 5)-1]
													,'');
		self.Original_Nationality_06 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[STD.Str.Find(L.Nationality_Parsed, ',', 5) + 1..STD.Str.Find(L.Nationality_Parsed, ',', 6)-1]
													,'');
		self.Original_Nationality_07 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[STD.Str.Find(L.Nationality_Parsed, ',', 6) + 1..STD.Str.Find(L.Nationality_Parsed, ',', 7)-1]
													,'');	
		self.Original_Nationality_08 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[STD.Str.Find(L.Nationality_Parsed, ',', 7) + 1..STD.Str.Find(L.Nationality_Parsed, ',', 8)-1]
													,'');
		self.Original_Nationality_09 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[STD.Str.Find(L.Nationality_Parsed, ',', 8) + 1..STD.Str.Find(L.Nationality_Parsed, ',', 9)-1]
													,'');
		self.Original_Nationality_10 := if(TRIM(L.Nationality_Parsed, left, right) <> ''
													,L.Nationality_Parsed[STD.Str.Find(L.Nationality_Parsed, ',', 9) + 1..]
													,'');
		self.Linked_With 						 := ' ';
		self 												 := L;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout2 RollUpRecs(GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout2 L, GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout2 R) := TRANSFORM
		self.offenses 		:= if(TRIM(L.offenses, left, right) <> TRIM(R.offenses, left, right)
														,TRIM(L.offenses, left, right) + ', ' + TRIM(R.offenses, left, right)
														,TRIM(L.offenses, left, right));		
		self 							:= L;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout3 ReformatInterpolData(GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout2 L) := TRANSFORM
		self.last_update_date := GlobalWatchLists_Preprocess.Versions.IMW_Version;
		self.pty_key 					:= 'IMW' + TRIM(if(STD.Str.Find(L.ID, '/', 1) > 0, L.ID[9..18], STD.Str.Filter(L.ID, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')), left, right);
		self.Interpol_ID 			:= if(STD.Str.Find(L.ID, '/', 1) > 0
															,L.ID[9..18]
															,STD.Str.Filter(L.ID, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
		self.source 					:= 'Interpol Most Wanted';
		self.FamilyName 			:= L.FamilyName;
		self.Forename 				:= L.Forename;
		self.Original_Primary_Name 	:= STD.Str.CleanSpaces(STD.Str.ToUpperCase(TRIM(L.Forename, left, right) + ' ' + TRIM(L.FamilyName, left, right)));
		self.Original_Country 			:= STD.Str.ToUpperCase(TRIM(L.Nationality, left, right))[ 1..60];
		self.Original_Languages 		:= TRIM(L.Language, left, right);
		self.Original_DOB 					:= TRIM(L.DateofBirth[1..STD.Str.Find(L.DateofBirth, '(', 1)-1], left, right);
		self.Original_POBs 					:= TRIM(L.BirthPlace, left, right);
		self.Original_Crimes 				:= TRIM(L.Offenses, left, right);
		self.Original_Gender 				:= TRIM(L.Sex[1], left, right);
		self.Original_Warrant_Issued_By := if(STD.Str.Find(L.WarrantBy_1, ',', 1) <> 0
																					,TRIM(L.WarrantBy_1, left, right)[1..STD.Str.Find(L.WarrantBy_1, ',', 1)]
																					,L.WarrantBy_1);
		self.Original_Linked_With 			:= TRIM(L.Linked_With, left, right);
		self.Original_POB_01 						:= TRIM(L.Original_POB_01[1..50], left, right);
		self.Original_Photo_File 				:= TRIM(L.PhotoName, left, right);
		self.Original_Height 						:= TRIM(L.Height, left, right);
		self.Original_Weight 						:= TRIM(L.Weight, left, right);
		self.Original_Hair 							:= TRIM(L.Hair, left, right);
		self.Original_Eyes 							:= TRIM(L.Eyes, left, right)[1..25];
		self.Original_Scars_And_Marks 	:= ' ';
		self.Original_Language_02 			:= if(length(L.Original_Language_02) > 20
																					,regexreplace('(other)', TRIM(L.Original_Language_02, left, right),'')
																					,TRIM(L.Original_Language_02, left, right));
		self.Original_Language_03 			:= if(length(L.Original_Language_03) > 20
																					,regexreplace('(other)', TRIM(L.Original_Language_03, left, right),'')
																					,TRIM(L.Original_Language_03, left, right));
		self.Original_Language_01 			:= if(length(L.Original_Language_01) > 20
																					,regexreplace('(other)', TRIM(L.Original_Language_01, left, right),'')
																					,TRIM(L.Original_Language_01, left, right));
		self.orig_raw_name							:= L.orig_raw_name;
		self := L;
	END;
	
	IMWrolledRecs := rollup(sort(PROJECT(IPMostWantedRecsNotNullNames, RedfineWithSeparateCitations(left)), ID, FamilyName, Forename, Offenses), left.ID = right.ID and left.FamilyName = right.FamilyName, RollUpRecs(left, right));
	
	IMWRecs1 := PROJECT(IMWrolledRecs, ReformatInterpolData(left))(TRIM(FamilyName, left, right) <> 'FERNANDO'); //I don't understand this step
	IMWRecs2 := PROJECT(IMWrolledRecs, ReformatInterpolData(left))(TRIM(FamilyName, left, right) = 'FERNANDO');  //as both files go through same transform
	
	GlobalWatchLists_Preprocess.rOutLayout ReformatRecs(GlobalWatchLists_Preprocess.IntermediaryLayoutInterpolMostwanted.TempLayout3 L) := TRANSFORM
		string100 temp_name := TRIM(if(TRIM(L.Original_Primary_Name, left, right) <> ''
																	and STD.Str.Find(TRIM(L.Original_Primary_Name), '(', 1) > 0
																	and length(STD.Str.Filter(TRIM(L.Original_Primary_Name, left, right), '1234567890')) > 0
															,STD.Str.FilterOut(STD.Str.FindReplace(
																									STD.Str.FindReplace(L.Original_Primary_Name, '(', '')
																								 ,')', '')
																						,'1234567890')
															,if(TRIM(L.Original_Primary_Name, left, right) <> '', L.Original_Primary_Name, '')), left, right);
		string25 v_dob 			:= TRIM(L.Original_DOB, left, right);

		self.pty_key 	:= if(TRIM(L.pty_key, left, right) <> '', TRIM(L.pty_key, left, right), '');
		self.source 	:= if(TRIM(L.source, left, right) <> '', TRIM(L.source, left, right), '');
		self.orig_pty_name := STD.Str.ToUpperCase(if(TRIM(L.Original_Primary_Name, left, right) <> '' and ~REGEXFIND('KIDNAPPING',L.Original_Primary_Name)
																								, TRIM(L.Original_Primary_Name, left, right), ''));
		self.orig_vessel_name := '';
		self.country := ut.CleanSpacesAndUpper(if(TRIM(L.Original_Country, left, right) <> '', STD.Str.FindReplace(TRIM(L.Original_Country, left, right),',',''), ''));
		self.name_type := ut.CleanSpacesAndUpper(L.Name_Type);
		self.addr_1 := ut.CleanSpacesAndUpper(if(TRIM(L.Original_Country, left, right) <> '', STD.Str.FindReplace(TRIM(L.Original_Country, left, right),',',''), ''));
		self.remarks_1 := if(TRIM(L.Original_DOB, left, right) <> '' and TRIM(L.Original_DOB, left, right) <> '00000000', 'DATE OF BIRTH: ' + TRIM(L.Original_DOB, left, right), '')
													+ if(TRIM(L.Original_DOB, left, right) <> '' and TRIM(L.Original_DOB, left, right) <> '00000000' and L.Original_POBs <> '', '; ', '')
													+ if(L.Original_POBs <> '', 'PLACE/S OF BIRTH: ' + STD.Str.ToUpperCase(TRIM(L.Original_POBs, left, right)), '');
		self.remarks_2 := if(L.Original_Gender <> '', 'GENDER: ' + if(L.Original_Gender = 'F', 'FEMALE', 'MALE'), '');
		self.remarks_3 := regexreplace('^; ',
													if(L.Original_Hair <> '', 'HAIR: ' + STD.Str.ToUpperCase(TRIM(L.Original_Hair,left,right)), '')
												+ if(L.Original_Hair <> '' and L.Original_Eyes <> '', '; ', '')
												+ if(L.Original_Eyes <> '', 'EYES: ' + STD.Str.ToUpperCase(TRIM(L.Original_Eyes,left,right)), '')
												+ if(L.Original_Height <> '', '; HEIGHT: ' + STD.Str.ToUpperCase(TRIM(L.Original_Height,left,right)), '')
												+ if(L.Original_Height <> '' and L.Original_Weight<> '', '; ', '')
												+ if(L.Original_Weight <> '', 'WEIGHT: ' + STD.Str.ToUpperCase(TRIM(L.Original_Weight,left,right)), '')							 
												,'');
		self.remarks_4 := if(L.Original_Scars_And_Marks <> ''
													,'DISTINGUISHING FEATURES: ' + STD.Str.ToUpperCase(TRIM(L.Original_Scars_And_Marks,left,right))
													,'');
		self.remarks_5 := if(L.Original_Languages <> ''
													,'LANGUAGES: ' + STD.Str.ToUpperCase(TRIM(L.Original_Languages,left,right))
													,'');
		self.remarks_6 := if(TRIM(L.Original_Crimes, left, right) <> ''
													,'CRIMES: ' + STD.Str.ToUpperCase(TRIM(L.Original_Crimes,left,right))
													,'');
		self.remarks_7 := if(L.Original_Warrant_Issued_By <> ''
													,'WARRANT ISSUED BY: ' + STD.Str.ToUpperCase(TRIM(L.Original_Warrant_Issued_By,left,right))
													,'');
		self.remarks_8 := if(TRIM(L.Interpol_ID, left, right) <> ''
													,'INTERPOL ID: ' +  L.Interpol_ID
													,'');
		self.remarks_9 := if(L.Original_Linked_With  <> ''
													,'LINKED WITH: ' + STD.Str.ToUpperCase(TRIM(regexreplace('/Public/Data/Wanted/Notices/Data/..../[0-9]*/'
																																,regexreplace('/Public/Data/Children/Missing/Notices/Data/..../[0-9]*/'
																																				,L.Original_Linked_With																																		
																																				,'MISSING CHILDREN ')
																																,''), left, right))
													,'');
		self.cname_clean := '';
		self.pname_clean := if(STD.Str.Find(temp_name, ',', 1) > 0 and TRIM(temp_name, left, right) <> ''
														,address.CleanPersonLFM73(TRIM(temp_name, left, right))
														,if(TRIM(temp_name, left, right) <> '' and ~REGEXFIND('KIDNAPPING',temp_name)
															,address.CleanPersonFML73(TRIM(temp_name, left, right))
															,''));
		self.date_first_seen 						:= TRIM(L.last_update_date, left, right);
		self.date_last_seen 						:= TRIM(L.last_update_date, left, right);
		self.date_vendor_first_reported := TRIM(L.last_update_date, left, right);
		self.date_vendor_last_reported 	:= TRIM(L.last_update_date, left, right);
		self.orig_entity_id 						:= L.Interpol_ID;
		self.orig_first_name 						:= STD.Str.ToUpperCase(TRIM(L.Forename, left, right));
		self.orig_last_name 						:= STD.Str.ToUpperCase(L.FamilyName);
		self.addr_clean 								:= '';
		self.orig_aka_id 								:= '';
		self.orig_aka_type 							:= '';
		self.orig_aka_category 					:= '';
		self.orig_giv_designator 				:= 'I';
		self.orig_address_id 						:= '';
		self.orig_address_country 			:= STD.Str.ToUpperCase(TRIM(L.Original_Country, left, right));
		self.orig_remarks 							:= if(STD.Str.Find(L.source, 'Red', 1) > 0
																					,'TO SEEK THE ARREST OR PROVISIONAL ARREST OF WANTED PERSONS WITH A VIEW TO EXTRADITION.'
																					,'');
		self.orig_nationality_1 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_01, left, right));
		self.orig_nationality_2 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_02, left, right));
		self.orig_nationality_3 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_03, left, right));
		self.orig_nationality_4 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_04, left, right));
		self.orig_nationality_5 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_05, left, right));
		self.orig_nationality_6 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_06, left, right));
		self.orig_nationality_7 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_07, left, right));
		self.orig_nationality_8 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_08, left, right));
		self.orig_nationality_9 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_09, left, right));
		self.orig_nationality_10 				:= STD.Str.ToUpperCase(TRIM(L.Original_Nationality_10, left, right));
		TempDOB					 								:= if(regexfind('[A-Z]', v_dob) = true
																				,GlobalWatchLists_Preprocess.fSlashedDMYtoYMD(
																						regexreplace(' December | DECEMBER ',
																							regexreplace(' November | NOVEMBER ',
																								regexreplace(' October | OCTOBER ',
																									regexreplace(' September | SEPTEMBER ',
																										regexreplace(' August | AUGUST ',
																											regexreplace(' July | JULY ',
																												regexreplace(' June | JUNE ',
																													regexreplace(' May | MAY ',
																														regexreplace(' April | APRIL ',
																															regexreplace(' March | MARCH ',
																																regexreplace(' February | FEBRUARY ',
																																	regexreplace(' January | JANUARY ', TRIM(v_dob, left, right), '/01/')																																																									
																																,'/02/')
																															,'/03/')
																														,'/04/')
																													,'/05/')
																												,'/06/')
																											,'/07/')
																										,'/08/')
																									,'/09/')
																								,'/10/')
																							,'/11/')
																						,'/12/')) 
																				,TRIM(v_dob, left, right));
		self.orig_dob_1 								:= IF(STD.Str.Find(TempDOB, '/', 1) > 0, GlobalWatchLists_Preprocess.DateCleaner.ToYYYYMMDD(TempDOB),TempDOB);
		self.orig_pob_1 								:= STD.Str.ToUpperCase(TRIM(L.Original_POB_01, left, right));
		self.orig_pob_2 								:= STD.Str.ToUpperCase(TRIM(L.Original_POB_02, left, right));
		self.orig_pob_3 								:= STD.Str.ToUpperCase(TRIM(L.Original_POB_03, left, right));
		self.orig_pob_4									:= STD.Str.ToUpperCase(TRIM(L.Original_POB_04, left, right));
		self.orig_pob_5 								:= STD.Str.ToUpperCase(TRIM(L.Original_POB_05, left, right));
		self.orig_pob_6 								:= STD.Str.ToUpperCase(TRIM(L.Original_POB_06, left, right));
		self.orig_pob_7 								:= STD.Str.ToUpperCase(TRIM(L.Original_POB_07, left, right));
		self.orig_pob_8 								:= STD.Str.ToUpperCase(TRIM(L.Original_POB_08, left, right));
		self.orig_pob_9 								:= STD.Str.ToUpperCase(TRIM(L.Original_POB_09, left, right));
		self.orig_pob_10 								:= STD.Str.ToUpperCase(TRIM(L.Original_POB_10, left, right));
		self.orig_language_1 						:= STD.Str.ToUpperCase(if(length(TRIM(L.Original_Language_01, left, right)) > 20
																													,TRIM(STD.Str.FindReplace(L.Original_Language_01, '(Other)', ''), left, right)
																													,TRIM(L.Original_Language_01, left, right)));
		self.orig_language_2 						:= STD.Str.ToUpperCase(if(length(TRIM(L.Original_Language_02, left, right)) > 20
																													,TRIM(STD.Str.FindReplace(TRIM(STD.Str.FindReplace(L.Original_Language_02,'(Other)',''), left, right),'South American Indian','SouthAmerican Indian'))
																													,TRIM(L.Original_Language_02)[1.. 20]));
		self.orig_language_3 						:= STD.Str.ToUpperCase(if(length(TRIM(L.Original_Language_03, left, right)) > 20
																														,TRIM(STD.Str.FindReplace(L.Original_Language_03,'(Other)',''), left, right)
																														,TRIM(L.Original_Language_03, left, right)[1..20]));
		self.orig_language_4 						:= STD.Str.ToUpperCase(if(length(TRIM(L.Original_Language_04, left, right)) > 20
																														,TRIM(STD.Str.FindReplace(L.Original_Language_04,'(Other)',''), left, right)
																														,TRIM(L.Original_Language_04, left, right)));
		self.orig_language_5 						:= STD.Str.ToUpperCase(TRIM(L.Original_Language_05, left, right));
		self.orig_language_6 						:= STD.Str.ToUpperCase(TRIM(L.Original_Language_06, left, right));
		self.orig_language_7 						:= STD.Str.ToUpperCase(TRIM(L.Original_Language_07, left, right));
		self.orig_language_8 						:= STD.Str.ToUpperCase(TRIM(L.Original_Language_08, left, right));
		self.orig_language_9 						:= STD.Str.ToUpperCase(TRIM(L.Original_Language_09, left, right));
		self.orig_language_10 					:= STD.Str.ToUpperCase(TRIM(L.Original_Language_10, left, right));
		self.orig_gender 								:= STD.Str.ToUpperCase(TRIM(L.Original_Gender, left, right));
		self.orig_height 								:= TRIM(L.Original_Height, left, right);
		self.orig_weight 								:= TRIM(L.Original_Weight, left, right);
		self.orig_hair_color 						:= STD.Str.ToUpperCase(TRIM(L.Original_Hair, left, right));
		self.orig_eyes 									:= STD.Str.ToUpperCase(TRIM(L.Original_Eyes, left, right));
		self.orig_scars_marks 					:= STD.Str.ToUpperCase(TRIM(L.Original_Scars_And_Marks, left, right));
		self.orig_photo_file 						:= STD.Str.ToUpperCase(TRIM(L.Original_Photo_File, left, right));
		self.orig_offenses 							:= ut.CleanSpacesAndUpper(REGEXREPLACE('^-|\\?',TRIM(L.Original_Crimes, left, right),''));
		self.orig_warrant_by 						:= STD.Str.ToUpperCase(TRIM(L.Original_Warrant_Issued_By, left, right));
		self.orig_linked_with_1 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_01, left, right));
		self.orig_linked_with_2 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_02, left, right));
		self.orig_linked_with_3 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_03, left, right));
		self.orig_linked_with_4 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_04, left, right));
		self.orig_linked_with_5 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_05, left, right));
		self.orig_linked_with_6 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_06, left, right));
		self.orig_linked_with_7 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_07, left, right));
		self.orig_linked_with_8 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_08, left, right));
		self.orig_linked_with_9 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_09, left, right));
		self.orig_linked_with_10 				:= STD.Str.ToUpperCase(TRIM(L.Original_Linked_With_10, left, right));
		self.orig_linked_with_id_1 			:= TRIM(L.Original_Linked_With_ID_01, left, right);
		self.orig_linked_with_id_2 			:= TRIM(L.Original_Linked_With_ID_02, left, right);
		self.orig_linked_with_id_3 			:= TRIM(L.Original_Linked_With_ID_03, left, right);
		self.orig_linked_with_id_4 			:= TRIM(L.Original_Linked_With_ID_04, left, right);
		self.orig_linked_with_id_5 			:= TRIM(L.Original_Linked_With_ID_05, left, right);
		self.orig_linked_with_id_6 			:= TRIM(L.Original_Linked_With_ID_06, left, right);
		self.orig_linked_with_id_7 			:= TRIM(L.Original_Linked_With_ID_07, left, right);
		self.orig_linked_with_id_8 			:= TRIM(L.Original_Linked_With_ID_08, left, right);
		self.orig_linked_with_id_9 			:= TRIM(L.Original_Linked_With_ID_09, left, right);
		self.orig_linked_with_id_10 		:= TRIM(L.Original_Linked_With_ID_10, left, right);
		self.orig_raw_name							:= L.orig_raw_name;
	END;
	
	ds_CombineAll	:= PROJECT(IMWRecs1, ReformatRecs(left)) + PROJECT(IMWRecs2, ReformatRecs(left)) + PROJECT(GlobalWatchLists_Preprocess.ProcessInterpolMostWantedINT, ReformatRecs(left));
	
	return ds_CombineAll(orig_pty_name <> '');
	
END;