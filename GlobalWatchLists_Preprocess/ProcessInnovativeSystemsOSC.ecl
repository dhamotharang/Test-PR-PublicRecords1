import std, address, ut;

EXPORT ProcessInnovativeSystemsOSC := FUNCTION	

	 l_tempCountryName	:= RECORD
		 integer seq_num;
		 string	CountryName;
	END;
	
	slimOSC	:= dedup(project(GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsOSC, TRANSFORM(l_tempCountryName, self.seq_num := 0; self.CountryName := left.Original_Sanction_Name_01)),ALL);
	
  l_tempCountryName GetSequence(slimOSC L, INTEGER Ctr) := TRANSFORM
		self.seq_num := Ctr;
		self.CountryName	:= L.CountryName;
	END;
	
	dsCountrySeq	:= project(slimOSC, GetSequence(LEFT, counter));
	
	//Join back to main file to add seqence
	l_AddSeq	:= RECORD
	 integer	seq_num;
	 GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems;
	 string orig_raw_name;
	END;
	
	AddSeq	:= project(GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsOSC, TRANSFORM(l_AddSeq, self.seq_num := 0; self.orig_raw_name := left.Original_Primary_Name_01 + left.Original_Primary_Name_02; self := left));
	
	jPopSequence := join(AddSeq,dsCountrySeq,
											 trim(left.Original_Sanction_Name_01,left,right) = trim(right.CountryName,left,right),
											 transform(l_AddSeq, self.seq_num := right.seq_num; self := left),
											 left outer);

	GlobalWatchLists_Preprocess.rOutLayout ReformatOSC(jPopSequence L) := TRANSFORM
		self.pty_key 										:= ut.CleanSpacesAndUpper(L.Application_Code) + (string)L.seq_num;
		self.source 										:= 'OFAC Sanctioned Countries';
		self.orig_pty_name 							:= ut.CleanSpacesAndUpper(L.Original_Primary_Name_01 + L.Original_Primary_Name_02);
		self.orig_vessel_name 					:= '';
		self.country 										:= if(TRIM(L.Original_Sanction_Name_01, left, right) = 'Cote d\'Ivoire (Ivory'
																				,'COTE D\'IVOIRE (IVORY COAST)'
																				,ut.CleanSpacesAndUpper(L.Original_Sanction_Name_01));
		self.name_type 									:= 'COUNTRY';
		self.remarks_1 									:= ut.CleanSpacesAndUpper(if(TRIM(L.Original_Primary_Name_01, left, right) <> ''
																													,'Primary Name: ' + if(TRIM(L.Original_Sanction_Name_01, left, right) = 'Cote d\'Ivoire (Ivory'
																																									,'Cote d\'Ivoire (Ivory Coast)'
																																									,TRIM(L.Original_Sanction_Name_01, left, right))
																												,''));

		self.remarks_2 									:= ut.CleanSpacesAndUpper(if(TRIM(L.Original_Date_Added_To_List, left, right) <> ''
																													,'Date Added To List: ' + TRIM(L.Original_Date_Added_To_List, left, right)
																												,''));

		self.remarks_3 									:= ut.CleanSpacesAndUpper(if(TRIM(L.Original_Date_Removed_From_List, left, right) <> ''
																													,'Date Removed From List: ' + TRIM(L.Original_Date_Removed_From_List, left, right)
																												,''));
		self.cname_clean 								:= '';
		self.pname_clean 								:= '';
		self.addr_clean 								:= '';
		self.date_first_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeOSC_Version;
		self.date_last_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeOSC_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.InnovativeOSC_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.InnovativeOSC_Version;
		self.orig_aka_id 								:= ut.CleanSpacesAndUpper(L.Serial_Number);
		self.orig_aka_type 							:= '';
		self.orig_aka_category 					:= '';
		self.orig_giv_designator 				:= '';
		self.orig_address_id 						:= '';
		self.orig_address_country 			:= ut.CleanSpacesAndUpper(L.Original_Primary_Name_01 + L.Original_Primary_Name_02);
		self.orig_date_added_to_list 		:= if(TRIM(L.Original_Date_Added_To_List, left, right) <> '', TRIM(L.Original_Date_Added_To_List, left, right), '');
		self.orig_expiration_date 			:= if(TRIM(L.Original_Date_Removed_From_List, left, right) <> '', TRIM(L.Original_Date_Removed_From_List, left, right), '');
		self.orig_raw_name							:= ut.CleanSpacesAndUpper(L.orig_raw_name);
	END;

	ds_out := PROJECT(sort(jPopSequence, Original_Sanction_Name_01, Original_Primary_Name_01, local), ReformatOSC(LEFT));
	RETURN DEDUP(sort(ds_out,orig_pty_name),ALL);

END;