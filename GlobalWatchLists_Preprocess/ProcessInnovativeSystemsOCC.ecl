import std, address, bo_address, ut;

EXPORT ProcessInnovativeSystemsOCC := FUNCTION

	GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutOCC NormAddress(GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems L, INTEGER C) := TRANSFORM
		self.Original_Primary_Name := TRIM(L.Original_Primary_Name_01+L.Original_Primary_Name_02+L.Original_Primary_Name_03,LEFT,RIGHT);
		self.Original_Address_01 	:= CASE(C, 1 => TRIM(L.Original_Add_01_Line_01, left, right)
																				 ,2 => TRIM(L.Original_Add_02_Line_01, left, right)
																				 ,3 => TRIM(L.Original_Add_03_Line_01, left, right)
																				 ,4 => TRIM(L.Original_Add_04_Line_01, left, right)
																				 ,5 => TRIM(L.Original_Add_05_Line_01, left, right)
																				 ,6 => TRIM(L.Original_Add_06_Line_01, left, right)
																				 ,7 => TRIM(L.Original_Add_07_Line_01, left, right)
																				 ,8 => TRIM(L.Original_Add_08_Line_01, left, right)
																				 ,9 => TRIM(L.Original_Add_09_Line_01, left, right)
																				 ,10 => TRIM(L.Original_Add_10_Line_01, left, right)
																				 ,'');																				 
		self.Original_Address_02 	:= CASE(C, 1 => TRIM(L.Original_Add_01_Line_02, left, right)
																				 ,2 => TRIM(L.Original_Add_02_Line_02, left, right)
																				 ,3 => TRIM(L.Original_Add_03_Line_02, left, right)
																				 ,4 => TRIM(L.Original_Add_04_Line_02, left, right)
																				 ,5 => TRIM(L.Original_Add_05_Line_02, left, right)
																				 ,6 => TRIM(L.Original_Add_06_Line_02, left, right)
																				 ,7 => TRIM(L.Original_Add_07_Line_02, left, right)
																				 ,8 => TRIM(L.Original_Add_08_Line_02, left, right)
																				 ,9 => TRIM(L.Original_Add_09_Line_02, left, right)
																				 ,10 => TRIM(L.Original_Add_10_Line_02, left, right)
																				 ,'');		
		self.Original_Address_03 	:= CASE(C, 1 => TRIM(L.Original_Add_01_Line_03, left, right)
																				 ,2 => TRIM(L.Original_Add_02_Line_03, left, right)
																				 ,3 => TRIM(L.Original_Add_03_Line_03, left, right)
																				 ,4 => TRIM(L.Original_Add_04_Line_03, left, right)
																				 ,5 => TRIM(L.Original_Add_05_Line_03, left, right)
																				 ,6 => TRIM(L.Original_Add_06_Line_03, left, right)
																				 ,7 => TRIM(L.Original_Add_07_Line_03, left, right)
																				 ,8 => TRIM(L.Original_Add_08_Line_03, left, right)
																				 ,9 => TRIM(L.Original_Add_09_Line_03, left, right)
																				 ,10 => TRIM(L.Original_Add_10_Line_03, left, right)
																				 ,'');		
		self.Original_Address_04 	:= CASE(C, 1 => TRIM(L.Original_Add_01_Line_04, left, right)
																				 ,2 => TRIM(L.Original_Add_02_Line_04, left, right)
																				 ,3 => TRIM(L.Original_Add_03_Line_04, left, right)
																				 ,4 => TRIM(L.Original_Add_04_Line_04, left, right)
																				 ,5 => TRIM(L.Original_Add_05_Line_04, left, right)
																				 ,6 => TRIM(L.Original_Add_06_Line_04, left, right)
																				 ,7 => TRIM(L.Original_Add_07_Line_04, left, right)
																				 ,8 => TRIM(L.Original_Add_08_Line_04, left, right)
																				 ,9 => TRIM(L.Original_Add_09_Line_04, left, right)
																				 ,10 => TRIM(L.Original_Add_10_Line_04, left, right)
																				 ,'');		
		self.Primary_Flag 				:= if(C = 1, 'Y', 'N');
		self.orig_raw_name				:= self.Original_Primary_Name;
		self											:= L;
	END;
	
	NormalizedOSC	:= NORMALIZE(GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsOCC, 10, NormAddress(LEFT,COUNTER));
	NotNullNormalizedOSC := NormalizedOSC((Primary_Flag = 'N'  and TRIM(Original_Address_01) <> '') or Primary_Flag = 'Y');
	
	GlobalWatchLists_Preprocess.rOutLayout ReformatOCC(GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutOCC L) := TRANSFORM
		
		v_serial_no 										:= regexfind('(^[0]*)(\\d+)', regexfind('\\d+', regexreplace('^93', L.Serial_Number, ''), 0), 2);
		self.pty_key 										:= ut.CleanSpacesAndUpper(L.Application_Code) + ut.CleanSpacesAndUpper(v_serial_no);
		self.source 										:= 'Office of the Comptroller of the Currency Alerts';
		self.orig_pty_name 							:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(TRIM(L.Original_Primary_Name,left,right), u'â€™', u'\''));
		self.orig_vessel_name 					:= '';
		self.name_type 									:= 'ENTITY';
		self.addr_1 										:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(TRIM(L.Original_Address_01, left, right), u'â€™', u'\''));
		self.addr_2 										:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(TRIM(L.Original_Address_02, left, right), u'â€™', u'\''));              
		self.addr_3 										:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(TRIM(L.Original_Address_03, left, right)
																				+ ' '
																				+ TRIM(L.Original_Address_04, left, right)
																				,u'â€™', u'\''));

		self.remarks_1 									:= ut.CleanSpacesAndUpper('Date added to alert list: ' + L.Original_Date_Added_To_List);
		self.remarks_2 									:= ut.CleanSpacesAndUpper('Found in: ' + L.Original_Grounds_For_Addition);
		self.remarks_3 									:= (string)STD.Uni.ToUpperCase(TRIM('Additional information: ' + STD.Uni.FindReplace(
																																																			STD.Uni.FindReplace(
																																																				STD.Uni.FindReplace(L.Original_Additional_Info
																																																					,u'â€™',u'\'')
																																																				,u'â€œ',u'"') 
																																																			,u'â€',u'"'),left,right));
		self.remarks_4 									:= ut.CleanSpacesAndUpper(if(STD.Str.Find(L.Original_Address_01, 'www.', 1) > 0
																												or STD.Str.Find(L.Original_Address_01, 'http', 1) > 0
																												or STD.Str.Find(L.Original_Address_01, '.com', 1) > 0
																												,'Website: ' + TRIM(L.Original_Address_01, left, right)
																											,''));
		self.remarks_5 									:= ut.CleanSpacesAndUpper(if(STD.Str.Find(L.Original_Address_02, 'www.', 1) > 0
																												or STD.Str.Find(L.Original_Address_02, 'http', 1) > 0
																												or STD.Str.Find(L.Original_Address_02, '.com', 1) > 0
																												,'Website: ' + TRIM(L.Original_Address_02, left, right)
																											,''));
		self.cname_clean 								:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(TRIM(L.Original_Primary_Name, left, right), u'â€™', u'\''));
		self.pname_clean 								:= '';
		TempAddrClean		 								:= if((STD.Str.Find(TRIM(L.Original_Address_01, left, right), 'www.', 1) = 0)
																						and (STD.Str.Find(TRIM(L.Original_Address_01, left, right), 'http', 1) = 0)
																						and (STD.Str.Find(TRIM(L.Original_Address_01, left, right), '.com', 1) = 0)
																					,bo_address.CleanAddress182((string)TRIM(L.Original_Address_01, left, right)
                                                    ,(string)TRIM(L.Original_Address_02, left, right) + ' ' + (string)TRIM(L.Original_Address_03, left, right) + ' ' + (string)TRIM(L.Original_Address_04, left, right))
																					,bo_address.CleanAddress182((string)TRIM(L.Original_Address_03, left, right)
                                                    ,(string)TRIM(L.Original_Address_04, left, right))
                                         );
		self.addr_clean 								:= if(TempAddrClean[179..180] <> 'E5' 
																					and TempAddrClean[179..182] <> 'E213'
																					and TempAddrClean[179..182] <> 'E101'
																					,TempAddrClean
																					,'');
		self.date_first_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeOCC_Version;
		self.date_last_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeOCC_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.InnovativeOCC_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.InnovativeOCC_Version;
		self.orig_entity_id 						:= ut.CleanSpacesAndUpper(trim(L.Application_Code,left,right) + trim(L.Serial_Number,left,right));
		self.orig_aka_id 								:= '';
		self.orig_aka_type 							:= '';
		self.orig_aka_category 					:= '';		
		self.orig_giv_designator 				:= 'G';
		self.orig_address_id 						:= '';
		self.orig_address_line_1 				:= ut.CleanSpacesAndUpper(L.Original_Address_01);
		self.orig_address_line_2 				:= ut.CleanSpacesAndUpper(L.Original_Address_02);
		self.orig_address_line_3 				:= ut.CleanSpacesAndUpper(L.Original_Address_03) + ' ' + ut.CleanSpacesAndUpper(L.Original_Address_04);
		self.orig_remarks 							:= (string)STD.Uni.ToUpperCase(TRIM(STD.Uni.FindReplace(L.Original_Additional_Info, u'â€™', u'\''),left,right));
		self.orig_date_added_to_list 		:= ut.CleanSpacesAndUpper(L.Original_Date_Added_To_List);
		self.orig_grounds 							:= ut.CleanSpacesAndUpper(L.Original_Grounds_For_Addition);
		self.orig_linked_with_1 				:= if(STD.Str.Find(L.Original_Address_01, 'www.', 1) > 0 
																					or STD.Str.Find(L.Original_Address_01, 'http', 1) > 0
																					or STD.Str.Find(L.Original_Address_01, '.com', 1) > 0
																				,ut.CleanSpacesAndUpper(L.Original_Address_01)
																				,'');
		self.orig_linked_with_2 				:= if(STD.Str.Find(L.Original_Address_02, 'www.', 1) > 0
																						or STD.Str.Find(L.Original_Address_02, 'http', 1) > 0
																						or STD.Str.Find(L.Original_Address_02, '.com', 1) > 0
																					,ut.CleanSpacesAndUpper(L.Original_Address_02)
																					,'');		
				self.orig_raw_name					:= ut.CleanSpacesAndUpper(L.orig_raw_name);
	END;
	
	return PROJECT(NotNullNormalizedOSC, ReformatOCC(LEFT));

END;