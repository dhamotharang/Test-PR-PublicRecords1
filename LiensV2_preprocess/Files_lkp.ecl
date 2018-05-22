// Used in LiensV2.file_liens_main
Import LiensV2_preprocess;

EXPORT Files_lkp := MODULE

	//Filing Type Lookup
	filing_in 		:= DATASET(root + 'filing_type_lkp', LiensV2_preprocess.Layouts_CA_Federal.lookup_files,CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n'])));
	
	LiensV2_preprocess.Layouts_CA_Federal.filing_type_lkp xfrmFilingType(filing_in L) := TRANSFORM
		self.filing_type_cd 	:= L.line_data[1..5];
		self.filing_type_desc := L.line_data[6..];
	END;
	
	EXPORT filing_type	:= project(filing_in, xfrmFilingType(left));
	
	//Change filing type lookup
	change_in		:= DATASET(root + 'change_filing_type_lkp', LiensV2_preprocess.Layouts_CA_Federal.lookup_files,CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n'])));
	
	LiensV2_preprocess.Layouts_CA_Federal.change_filing_lkp xfrmChngFilingType(change_in L) := TRANSFORM
		self.change_filing_cd 	:= L.line_data[1..5];
		self.change_filing_desc := L.line_data[6..];
	END;
	
	EXPORT change_filing	:= project(change_in, xfrmChngFilingType(left));
	
	//Filing status lookup
	status_in		:= DATASET(root + 'filing_status_lkp', LiensV2_preprocess.Layouts_CA_Federal.lookup_files,CSV(HEADING(0),SEPARATOR('|'),TERMINATOR(['\n', '\r\n'])));
	
	LiensV2_preprocess.Layouts_CA_Federal.filing_status_lkp xfrmFilingStatus(status_in L) := TRANSFORM
		self.filing_status_cd 	:= L.line_data[1];
		self.filing_status_desc := L.line_data[2..];
	END;
	
	EXPORT filing_status	:= project(status_in, xfrmFilingStatus(left));
	
	//State ISO lookup
	ISO_in				:= DATASET(root + 'iso_state_lkp', LiensV2_preprocess.Layouts_CA_Federal.lookup_files,CSV(HEADING(0),SEPARATOR('|'),TERMINATOR(['\n', '\r\n'])));
	
	LiensV2_preprocess.Layouts_CA_Federal.ISO_state_lkp xfrmISO(ISO_in L) := TRANSFORM
		self.code			:= L.line_data[1..3];
		self.Iso_desc	:= L.line_data[4..42];
		self.Iso_code	:= L.line_data[43..];
	END;
	
	EXPORT ISO_State	:= project(ISO_in, xfrmISO(left));
	
	//Province lookup
	province_in	:= DATASET(root + 'province_lkp', LiensV2_preprocess.Layouts_CA_Federal.lookup_files,CSV(HEADING(0),SEPARATOR('|'),TERMINATOR(['\n', '\r\n'])));
	
	LiensV2_preprocess.Layouts_CA_Federal.province_lkp xfrmProvince(province_in L) := TRANSFORM
		self.code						:= L.line_data[1..2];
		self.province_desc	:= L.line_data[3..23];
		self.province_code	:= L.line_data[24..];
	END;
	
	EXPORT province	:= project(province_in, xfrmProvince(left));
	
	//State code lookup
	state_in			:= DATASET(root + 'state_code_lkp', LiensV2_preprocess.Layouts_CA_Federal.lookup_files,CSV(HEADING(0),SEPARATOR('|'),TERMINATOR(['\n', '\r\n'])));
	
	LiensV2_preprocess.Layouts_CA_Federal.state_lkp xfrmState(state_in L) := TRANSFORM
		self.state_cd 	:= L.line_data[1..2];
		self.state_desc := REGEXREPLACE('"ARMED FORCES EUROPE, THE IDDLE EAST, AND CANADA"',L.line_data[3..],
												'ARMED FORCES EUROPE, THE MIDDLE EAST, AND CANADA');
	END;
	
	EXPORT state_code	:= project(state_in, xfrmState(left));
	
	//HOGAN LOOKUPS
	//Filing Type Description
	EXPORT HGFiling_type	:= DATASET(root + 'hg_filing_type_lkp', LiensV2_preprocess.Layouts_Hogan.filing_type_lkp,CSV(HEADING(0),SEPARATOR('\t'),TERMINATOR(['\n', '\r\n'])));
	
	//Court Description
	HGCourt_in	:= DATASET(root + 'hg_court_id_lkp', LiensV2_preprocess.Layouts_Hogan.court_lookup,CSV(HEADING(0),SEPARATOR('\t'),TERMINATOR(['\n', '\r\n'])));
	
	LiensV2_preprocess.Layouts_Hogan.court_lkp xfrmHGCourt(HGCourt_in L) := TRANSFORM
		self.court_cd	:= L.line_data[1..7];
		self.court_desc	:= L.line_data[8..];
	END;
	
	EXPORT HGCourt	:= project(HGCourt_in, xfrmHGCourt(left));
	
	//Generation Code Description
	EXPORT HGGeneration	:= DATASET(LiensV2_preprocess.root + 'hg_generation_code_lkp', LiensV2_preprocess.Layouts_Hogan.generation_lkp,CSV(HEADING(1),SEPARATOR('\t'),TERMINATOR(['\n', '\r\n'])));
			
END;