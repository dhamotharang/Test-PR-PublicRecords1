import GlobalWatchLists_Preprocess, std, address, bo_address, ut;

EXPORT ProcessInnovativeSystemsPEP := FUNCTION

	rOutLayout ReformatPEP(Layouts.rInnovativeSystems L) := TRANSFORM
		
		v_serial_no 										:= regexfind('(^[0]*)(\\d+)', regexfind('\\d+', regexreplace('^95', L.Serial_Number, ''), 0), 2);
		self.pty_key 										:= ut.CleanSpacesAndUpper(L.Application_Code) + ut.CleanSpacesAndUpper(v_serial_no);
		self.source 										:= 'Politically Exposed Persons';
		self.orig_pty_name 							:= ut.CleanSpacesAndUpper(L.Original_Primary_Name_01 + L.Original_Primary_Name_02 + L.Original_Primary_Name_03);
		self.orig_vessel_name 					:= '';
		self.country 										:= ut.CleanSpacesAndUpper(L.Original_Add_01_Line_01);
		self.name_type 									:= '';
		self.remarks_1 									:= ut.CleanSpacesAndUpper(if(TRIM(L.Original_Designation_01, left, right) <> ''
																												,'Title: ' + TRIM(L.Original_Designation_01, left, right)
																											,''));
		self.remarks_2 									:= ut.CleanSpacesAndUpper(if(TRIM(L.Line_Gender_1, left, right) <> ''
																													,'Gender: ' + if(L.Line_Gender_1 = 'M','Male'
																																				 ,if(L.Line_Gender_1 = 'F', 'Female', L.Line_Gender_1 )) 
																												,''));
		self.remarks_3 									:= ut.CleanSpacesAndUpper(if(TRIM(L.Original_Add_01_Line_01, left, right) <> ''
																												 ,'Country: ' + TRIM(L.Original_Add_01_Line_01, left, right)
																												,''));
		self.cname_clean 								:= '';
		self.pname_clean 								:= if(TRIM(L.Original_Primary_Name_01, left, right) <> ''		
																				,Address.CleanPersonFML73(TRIM(L.Cleaned_First_Name, left, right) + ' ' + TRIM(L.Cleaned_Last_Name, left, right))
																				,'');
		self.addr_clean 								:= '';
		self.date_first_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativePEP_Version;
		self.date_last_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativePEP_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.InnovativePEP_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.InnovativePEP_Version;
		self.orig_entity_id 						:= ut.CleanSpacesAndUpper(L.Application_Code + L.Serial_Number);
		self.orig_first_name 						:= ut.CleanSpacesAndUpper(L.Cleaned_First_Name);
		self.orig_last_name 						:= ut.CleanSpacesAndUpper(L.Cleaned_Last_Name);
		self.orig_title_1 							:= ut.CleanSpacesAndUpper(L.Original_Designation_01);
		self.orig_aka_id 								:= '';
		self.orig_aka_type 							:= '';
		self.orig_aka_category 					:= '';
		self.orig_giv_designator 				:= 'I';
		self.orig_address_id 						:= '';
		self.orig_address_country 			:= ut.CleanSpacesAndUpper(L.Original_Add_01_Line_01);
		self.orig_gender 								:= if(TRIM(L.Line_Gender_1, left, right) <> '', ut.CleanSpacesAndUpper(L.Line_Gender_1), '');
		self.orig_raw_name							:= ut.CleanSpacesAndUpper(L.Original_Primary_Name_01 + L.Original_Primary_Name_02 + L.Original_Primary_Name_03);
	END;

	ds_out := PROJECT(Files.dsInnovativeSystemsPEP, ReformatPEP(LEFT));
	return DEDUP(SORT(ds_out,pty_key,orig_pty_name),ALL);

END;