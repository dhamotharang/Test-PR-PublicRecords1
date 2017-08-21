import GlobalWatchLists_Preprocess, std, address, ut;

EXPORT ProcessInnovativeSystemsCFT := FUNCTION

	IntermediaryLayoutInnovativeSystems.TempLayoutCFT_FBI NormCommodityFutureTradingAliases1TO20(Layouts.rInnovativeSystems L, INTEGER C) := TRANSFORM
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
		self.orig_raw_name					:= ut.CleanSpacesAndUpper(L.line_data_1);
		self 												:= L;
	END;
	
	NormalizedCommodityFutureTradingAliases1TO20	:= NORMALIZE(Files.dsInnovativeSystemsCFT, 20, NormCommodityFutureTradingAliases1TO20(LEFT,COUNTER));
	
	IntermediaryLayoutInnovativeSystems.TempLayoutCFT_FBI NormCommodityFutureTradingAliases21TO25Plus(Layouts.rInnovativeSystems L, INTEGER C) := TRANSFORM
		self.Original_Primary_Name 	:= case(C, 1 => L.Original_Alias_21
																						,2 => L.Original_Alias_22
																						,3 => L.Original_Alias_23
																						,4 => L.Original_Alias_24
																						,5 => L.Original_Alias_25
																						,6 => ''
																						,'');
			self.Primary_Record 				:= 'N';
			self.orig_raw_name					:= ut.CleanSpacesAndUpper(L.line_data_1);
			self 												:= L;
	END;
	
	NormalizedCommodityFutureTradingAliases21TO25Plus	:= NORMALIZE(Files.dsInnovativeSystemsCFT, 7, NormCommodityFutureTradingAliases21TO25Plus(LEFT,COUNTER));
	
	NormalizedCFT 				:= NormalizedCommodityFutureTradingAliases1TO20 + NormalizedCommodityFutureTradingAliases21TO25Plus;
	NotNullNormalizedCFT 	:= dedup(NormalizedCFT(TRIM(Original_Primary_Name, left, right) <> '' or TRIM(line_data_1, left, right) <> ''),all);
	
	rOutLayout ReformatCFT(IntermediaryLayoutInnovativeSystems.TempLayoutCFT_FBI L, integer C) := TRANSFORM
		
		v_serial_no 										:= regexfind('(^[0]*)(\\d+)', regexfind('\\d+', regexreplace('^94', L.Serial_Number, ''), 0), 2);
		self.pty_key 										:= TRIM(L.Application_Code, left, right) + TRIM(v_serial_no, left, right);
		self.source 										:= 'Cmmdty. Fut. Trad. Commission Lst. of Reg. & Self-Reg. Auth.';
		self.orig_pty_name 							:= ut.CleanSpacesAndUpper(CHOOSE(C,L.line_data_1, L.Original_Primary_Name));
		self.orig_vessel_name 					:= '';
		self.country 										:= TRIM(L.Original_Add_01_Line_01, left, right);
		self.name_type 									:= CHOOSE(C,'',if(L.Primary_Record = 'N', 'AKA', ''));
		self.addr_1 										:= TRIM(L.Original_Add_01_Line_01);
		self.remarks_1 									:= if(TRIM(L.Original_Date_Added_To_List) <> ''
																				,'DATE ADDED TO LIST: ' + TRIM(L.Original_Date_Added_To_List)
                                        ,'');
		self.remarks_2 									:= if(TRIM(L.Original_Grounds_For_Addition) <> ''
																				,'GROUNDS FOR ADDITION: ' + TRIM(L.Original_Grounds_For_Addition)
                                        ,'');
		self.cname_clean 								:= STD.Str.ToUpperCase(TRIM(self.orig_pty_name));
		self.pname_clean 								:= '';
		self.addr_clean 								:= '';
		self.date_first_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeCFT_Version;
		self.date_last_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeCFT_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.InnovativeCFT_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.InnovativeCFT_Version;
		self.orig_entity_id 						:= L.Application_Code + L.Serial_Number;
		self.orig_aka_id 								:= '';
		self.orig_aka_type 							:= self.name_type;
		self.orig_aka_category 					:= '';
		self.orig_giv_designator 				:= 'G';
		self.orig_address_id 						:= '';
		self.orig_address_line_1 				:= TRIM(L.Original_Add_01_Line_01);
		self.orig_date_added_to_list 		:= L.Original_Date_Added_To_List;
		self.orig_grounds 							:= L.Original_Grounds_For_Addition;
		self.orig_raw_name							:= L.orig_raw_name;
	END;

	NormCFT	:= SORT(NORMALIZE(NotNullNormalizedCFT,2,ReformatCFT(LEFT,COUNTER)),pty_key,orig_pty_name)(orig_pty_name <> '');
	
	RETURN DEDUP(NormCFT,ALL);

END;