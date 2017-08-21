import std, address, ut;

EXPORT ProcessInnovativeSystemsFBI := FUNCTION

	IntermediaryLayoutInnovativeSystems.TempLayoutCFT_FBI NormFBIMostWantedAliases1TO20(Layouts.rInnovativeSystems L, INTEGER C) := TRANSFORM
		self.Original_Primary_Name 	:= case(C, 1 => L.Original_Alias_01
																					,2 => L.Original_Alias_02
																					,3 => L.Original_Alias_03
																					,4 => L.Original_Alias_04
																					,5 => L.Original_Alias_05
																					,6 => L.Original_Alias_06
																					,7 => L.Original_Alias_07
																					,8 => L.Original_Alias_08
																					,9 => L.Original_Alias_09
																					,10 => L.Original_Alias_10
																					,11 => L.Original_Alias_11
																					,12 => L.Original_Alias_12
																					,13 => L.Original_Alias_13
																					,14 => L.Original_Alias_14
																					,15 => L.Original_Alias_15
																					,16 => L.Original_Alias_16
																					,17 => L.Original_Alias_17
																					,18 => L.Original_Alias_18
																					,19 => L.Original_Alias_19
																					,20 => L.Original_Alias_20
																					,'');
		self.Primary_Record 				:= 'N';
		self.Original_Height				:= REGEXREPLACE('[^0-9]',L.Original_Height,' ');
		self.Original_Scars_And_Marks := REGEXREPLACE('"',L.Original_Scars_And_Marks,'');
		self.orig_raw_name					:= ut.CleanSpacesAndUpper(L.line_data_1);
		self 												:= L;
	END;
	
	NormalizedFBIMostWantedAliases1TO20	:= NORMALIZE(Files.dsInnovativeSystemsFBI, 20, NormFBIMostWantedAliases1TO20(LEFT,COUNTER));
	
	IntermediaryLayoutInnovativeSystems.TempLayoutCFT_FBI NormFBIMostWantedAliases21TO25Plus(Layouts.rInnovativeSystems L, INTEGER C) := TRANSFORM
		self.Original_Primary_Name 	:= case(C, 1 => L.Original_Alias_21
																						,2 => L.Original_Alias_22
																						,3 => L.Original_Alias_23
																						,4 => L.Original_Alias_24
																						,5 => L.Original_Alias_25
																						,6 => STD.Str.CleanSpaces(L.Original_Primary_Name_01
																								 + L.Original_Primary_Name_02
																								 + L.Original_Primary_Name_03)
																					,'');
			self.Primary_Record 				:= IF(C = 6,'Y','N');
			self.Original_Height				:= REGEXREPLACE('[^0-9]',L.Original_Height,' ');
			self.Original_Scars_And_Marks := REGEXREPLACE('"',L.Original_Scars_And_Marks,'');
			self.orig_raw_name					:= ut.CleanSpacesAndUpper(L.line_data_1);
			self 												:= L;
	END;
	
	NormalizedFBIMostWantedAliases21TO20Plus	:= NORMALIZE(Files.dsInnovativeSystemsFBI, 6, NormFBIMostWantedAliases21TO25Plus(LEFT,COUNTER));
	
	NormalizedFBI 				:= sort(NormalizedFBIMostWantedAliases1TO20 + NormalizedFBIMostWantedAliases21TO20Plus,serial_number);
	NotNullNormalizedFBI 	:= dedup(NormalizedFBI(TRIM(Original_Primary_Name, left, right) <> '' or TRIM(line_data_1, left, right) <> ''),all);
	
	rOutLayout ReformatFBI(IntermediaryLayoutInnovativeSystems.TempLayoutCFT_FBI L) := TRANSFORM
		
		v_account_no 										:= regexfind('(^[0]*)(\\d+)', regexfind('\\d+', L.Account_Number[1..9], 0), 2);
		self.pty_key 										:= ut.CleanSpacesAndUpper(L.Application_Code) + ut.CleanSpacesAndUpper(v_account_no);
		self.source 										:= 'FBI Fugitives 10 Most Wanted';
		self.orig_pty_name 							:= ut.CleanSpacesAndUpper(REGEXREPLACE('^(Jr.  )',STD.Str.Filter(L.Original_Primary_Name,' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890()-_/\':;,^&.),'),''));
		self.orig_vessel_name 					:= '';
		self.country 										:= ut.CleanSpacesAndUpper(L.Original_Country_01);
		self.name_type 									:= if(L.Primary_Record = 'N', 'AKA', '');
		self.remarks_1 									:= if(TRIM(TRIM(L.Original_Language_01, left, right)
																					+ TRIM(L.Original_Language_02, left, right)
																					+ TRIM(L.Original_Language_03, left, right)
																					+ TRIM(L.Original_Language_04, left, right)
																					+ TRIM(L.Original_Language_05, left, right)
																					+ TRIM(L.Original_Language_06, left, right)
																					+ TRIM(L.Original_Language_07, left, right)
																					+ TRIM(L.Original_Language_08, left, right)
																					+ TRIM(L.Original_Language_09, left, right)
																					+ TRIM(L.Original_Language_10, left, right), left, right) <> '' 
																				,ut.CleanSpacesAndUpper('Language/s: ' + TRIM(L.Original_Language_01, left, right)
																							+ if(TRIM(L.Original_Language_02, left, right) <> '', '; ' + TRIM(L.Original_Language_02, left, right), '')
																							+ if(TRIM(L.Original_Language_03, left, right) <> '', '; ' + TRIM(L.Original_Language_03, left, right), '')
																							+ if(TRIM(L.Original_Language_04, left, right) <> '', '; ' + TRIM(L.Original_Language_04, left, right), '')
																							+ if(TRIM(L.Original_Language_05, left, right) <> '', '; ' + TRIM(L.Original_Language_05, left, right), '')
																							+ if(TRIM(L.Original_Language_06, left, right) <> '', '; ' + TRIM(L.Original_Language_06, left, right), '')
																							+ if(TRIM(L.Original_Language_07, left, right) <> '', '; ' + TRIM(L.Original_Language_07, left, right), '')
																							+ if(TRIM(L.Original_Language_08, left, right) <> '', '; ' + TRIM(L.Original_Language_08, left, right), '')
																							+ if(TRIM(L.Original_Language_09, left, right) <> '', '; ' + TRIM(L.Original_Language_09, left, right), '')
																							+ if(TRIM(L.Original_Language_10, left, right) <> '', '; ' + TRIM(L.Original_Language_10, left, right), ''))																							
																				,'');
		self.remarks_2 									:= if(TRIM(TRIM(L.Original_POB_01, left, right)
																					+ TRIM(L.Original_DOB_01, left, right)
																				  + TRIM(L.Original_DOB_02, left, right)
																				  + TRIM(L.Original_DOB_03, left, right)
																					+ TRIM(L.Original_DOB_04, left, right)
																				  + TRIM(L.Original_DOB_05, left, right)
																					+ TRIM(L.Original_DOB_06, left, right)
																				  + TRIM(L.Original_DOB_07, left, right)
																					+ TRIM(L.Original_DOB_08, left, right)
																				  + TRIM(L.Original_DOB_09, left, right)
																					+ TRIM(L.Original_DOB_10, left, right), left, right) <> ''
																				,ut.CleanSpacesAndUpper('Original Place and Date/s of Birth: '
																							+ TRIM(L.Original_POB_01, left, right))
																							+ if(TRIM(L.Original_DOB_01, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_01), '')                                                                                    
																							+ if(TRIM(L.Original_DOB_02, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_02), '')
																							+ if(TRIM(L.Original_DOB_03, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_03), '')
																							+ if(TRIM(L.Original_DOB_04, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_04), '')
																							+ if(TRIM(L.Original_DOB_05, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_05), '')
																							+ if(TRIM(L.Original_DOB_06, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_06), '')
																							+ if(TRIM(L.Original_DOB_07, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_07), '')
																							+ if(TRIM(L.Original_DOB_08, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_08), '')
																							+ if(TRIM(L.Original_DOB_09, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_09), '')
																							+ if(TRIM(L.Original_DOB_10, left, right) <> '', '; ' + ut.CleanSpacesAndUpper(L.Original_DOB_10), '')                       
																				,'');
		self.remarks_3 									:= if(TRIM(L.Original_Crimes, left, right) <> '',ut.CleanSpacesAndUpper('Crimes: ' + TRIM(L.Original_Crimes, left, right)), '');
		self.remarks_4 									:= if(TRIM(L.Original_NCIC, left, right) <> '', ut.CleanSpacesAndUpper('National Crime Information Center Number: ' + TRIM(L.Original_NCIC, left, right)), '');																							 
		self.remarks_5 									:=ut.CleanSpacesAndUpper(if(TRIM(L.Original_Gender, left, right)
																				  + TRIM(L.Original_Height, left, right)
																					+ TRIM(L.Original_Weight, left, right)
																					+ TRIM(L.Original_Build, left, right)
																					+ TRIM(L.Original_Hair, left, right)
																					+ TRIM(L.Original_Eyes, left, right)
																					+ TRIM(L.Original_Complexion, left, right)
																					+ TRIM(L.Original_Race, left, right)
																					+ TRIM(L.Original_Scars_And_Marks, left, right)
																					+ TRIM(L.Original_Country_01, left, right)
																					+ TRIM(L.Original_Occupation, left, right) <> ''
																				,if(TRIM(L.Original_Gender, left, right) <> ''
																													,'Gender: ' + if(TRIM(L.Original_Gender, left, right) = 'M', 'Male', if(TRIM(L.Original_Gender, left, right) = 'F', 'Female', 'Unknown'))
																													,'')
																							+ if(TRIM(L.Original_Height, left, right) <> '', '; Height: ' + TRIM(L.Original_Height, left, right), '')
																							+ if(TRIM(L.Original_Weight, left, right) <> '', '; Weight: ' + TRIM(L.Original_Weight, left, right), '')
																							+ if(TRIM(L.Original_Build, left, right) <> '', '; Build: ' + TRIM(L.Original_Build, left, right), '')
																							+ if(TRIM(L.Original_Hair, left, right) <> '', '; Hair: ' + TRIM(L.Original_Hair, left, right), '')
																							+ if(TRIM(L.Original_Eyes, left, right) <> '', '; Eyes: ' + TRIM(L.Original_Eyes, left, right), '')
																							+ if(TRIM(L.Original_Complexion, left, right) <> '', '; Complexion: ' + TRIM(L.Original_Complexion, left, right), '')
																							+ if(TRIM(L.Original_Race, left, right) <> '', '; Race: ' + TRIM(L.Original_Race, left, right), '')
																							+ if(TRIM(L.Original_Scars_And_Marks, left, right) <> '', '; Scars and Marks: ' + TRIM(L.Original_Scars_And_Marks, left, right), '')
																							+ if(TRIM(L.Original_Occupation, left, right) <> '', '; Occupation: ' + TRIM(L.Original_Occupation, left, right), '')
																							+ if(TRIM(L.Original_Country_01, left, right) <> '', '; Nationality: ' + TRIM(L.Original_Country_01, left, right), '')
																				,''));
		self.remarks_6 									:= if(TRIM(L.Original_Additional_Info, left, right) <> '', ut.CleanSpacesAndUpper('Additional Information: ' + TRIM(L.Original_Additional_Info, left, right)), '');
		self.remarks_7 									:= if(TRIM(L.Original_Caution, left, right) <> '',ut.CleanSpacesAndUpper('Caution: ' + TRIM(L.Original_Caution[1..785], left, right)), '');
		self.remarks_8 									:= if(TRIM(L.Original_Reward, left, right) <> '', ut.CleanSpacesAndUpper('Reward: ' + TRIM(L.Original_Reward, left, right)), '');
		self.cname_clean 								:= '';
		self.pname_clean 								:= address.CleanPersonFML73((string)TRIM(self.orig_pty_name));
		self.addr_clean 								:= '';
		self.date_first_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeFBI_Version;
		self.date_last_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeFBI_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.InnovativeFBI_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.InnovativeFBI_Version;
		self.orig_entity_id 						:= ut.CleanSpacesAndUpper(L.Application_Code + L.Serial_Number);
		self.orig_first_name 						:= if(self.name_type = '', ut.CleanSpacesAndUpper(L.Cleaned_First_Name), '');
		self.orig_last_name 						:= if(self.name_type = '', ut.CleanSpacesAndUpper(L.Cleaned_Last_Name), '');
		self.orig_aka_id 								:= '';
		self.orig_aka_type 							:= self.name_type;
		self.orig_aka_category 					:= '';
		self.orig_giv_designator 				:= 'I';
		self.orig_address_id 						:= '';
		self.orig_nationality_1 				:= ut.CleanSpacesAndUpper(L.Original_Country_01);
		self.orig_dob_1 								:= TRIM(L.Original_DOB_01, left, right);
		self.orig_dob_2 								:= TRIM(L.Original_DOB_02, left, right);
		self.orig_dob_3 								:= TRIM(L.Original_DOB_03, left, right);
		self.orig_dob_4 								:= TRIM(L.Original_DOB_04, left, right);
		self.orig_dob_5 								:= TRIM(L.Original_DOB_05, left, right);
		self.orig_dob_6 								:= TRIM(L.Original_DOB_06, left, right);
		self.orig_dob_7 								:= TRIM(L.Original_DOB_07, left, right);
		self.orig_dob_8 								:= TRIM(L.Original_DOB_08, left, right);
		self.orig_dob_9 								:= TRIM(L.Original_DOB_09, left, right);
		self.orig_dob_10 								:= TRIM(L.Original_DOB_10, left, right);
		self.orig_language_1 						:= ut.CleanSpacesAndUpper(L.Original_Language_01);
		self.orig_language_2 						:= ut.CleanSpacesAndUpper(L.Original_Language_02);
		self.orig_language_3 						:= ut.CleanSpacesAndUpper(L.Original_Language_03);
		self.orig_language_4 						:= ut.CleanSpacesAndUpper(L.Original_Language_04);
		self.orig_language_5 						:= ut.CleanSpacesAndUpper(L.Original_Language_05);
		self.orig_language_6 						:= ut.CleanSpacesAndUpper(L.Original_Language_06);
		self.orig_language_7 						:= ut.CleanSpacesAndUpper(L.Original_Language_07);
		self.orig_language_8 						:= ut.CleanSpacesAndUpper(L.Original_Language_08);
		self.orig_language_9 						:= ut.CleanSpacesAndUpper(L.Original_Language_09);
		self.orig_language_10 					:= ut.CleanSpacesAndUpper(L.Original_Language_10);
		self.orig_gender 								:= ut.CleanSpacesAndUpper(L.Original_Gender);
		self.orig_occupation_1 					:= ut.CleanSpacesAndUpper(L.Original_Occupation);
		self.orig_height 								:= L.Original_Height;
		self.orig_weight 								:= L.Original_Weight;
		self.orig_physique 							:= ut.CleanSpacesAndUpper(L.Original_Build);
		self.orig_hair_color 						:= ut.CleanSpacesAndUpper(L.Original_Hair);
		self.orig_eyes 									:= ut.CleanSpacesAndUpper(L.Original_Eyes);
		self.orig_complexion 						:= ut.CleanSpacesAndUpper(L.Original_Complexion);
		self.orig_race 									:= ut.CleanSpacesAndUpper(L.Original_Race);
		self.orig_scars_marks 					:= ut.CleanSpacesAndUpper(STD.Str.FindReplace(
																							STD.Str.FindReplace(
																								STD.Str.FindReplace(
																									STD.Str.FindReplace(L.Original_Scars_And_Marks
																									,' and ', ' & ')
																								,'approximately', 'approx.')
																							,' five ', ' 5 ')
																						,'has the following tattoos on his body:', 'has the following tattoos:'))[1..400];
		self.orig_remarks 							:= ut.CleanSpacesAndUpper(L.Original_Additional_Info);
		self.orig_ncic 									:= ut.CleanSpacesAndUpper(L.Original_NCIC);
		self.orig_caution 							:= ut.CleanSpacesAndUpper(L.Original_Caution);
		self.orig_reward 								:= ut.CleanSpacesAndUpper(L.Original_Reward);
		self.orig_raw_name							:= ut.CleanSpacesAndUpper(L.orig_raw_name);
	END;

	NormFBI	:= SORT(project(NotNullNormalizedFBI, ReformatFBI(LEFT)),pty_key,orig_pty_name)(orig_pty_name <> '');
	return DEDUP(NormFBI,ALL);

END;