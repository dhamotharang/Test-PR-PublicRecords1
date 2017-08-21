import header, idl_header, insuranceHeader_preprocess;
export fn_updateBocaHeader(dataset(header.Layout_Header_v2_dl) BocaHeader) := module;

	// Base File
	shared base_boca := BocaHeader;
	// base_boca := choosen(idl_header.files.DS_HEADER_BOCA_PERSONAL, 30);
	
  // filter records 
	export noIRSDummyDid 			:= base_boca(did NOT IN IRS_DummyDids);
	
	// Transform records to insurance header layout format
	shared idl_header.Layout_Header_Link xformToIdlLayout(noIRSDummyDid L) := transform
		SELF.SRC											:= idl_header.Constants.Boca_Header_Records + L.SRC;
		SELF.DID											:= L.RID;
		SELF.SNAME										:= if(L.NAME_SUFFIX[1..2] = 'UN', '', L.NAME_SUFFIX);
		self.prim_name    						:= if(L.prim_name[1..4] = 'DOD:' or L.prim_name[1..5] = 'DOD :', '', L.prim_name);
		SELF.ADDR_SUFFIX							:= L.SUFFIX;
		SELF.CITY											:= L.CITY_NAME;
		self.dl_nbr										:= if(L.dl_number[1..4] = 'LNID', 				'', L.dl_number);
		self.dl_state									:= if(L.dl_number[1..4] = 'LNID', 				'', L.dl_state);
		SELF.BOCA_DID									:= L.DID;
		self.DT_FIRST_SEEN 						:= l.dt_first_seen * 100; // Added Day 00 to all dates
		self.DT_LAST_SEEN  						:= l.dt_last_seen * 100;
		self.DT_VENDOR_FIRST_REPORTED := l.dt_vendor_first_reported * 100;
		self.DT_VENDOR_LAST_REPORTED  := l.dt_vendor_last_reported * 100;
		SELF 													:= L;
		SELF													:= [];
	end;
	export base_boca_asheader := project(noIRSDummyDid, xformToIdlLayout(left));

	shared clean_name_adr := InsuranceHeader_PreProcess.mod_clean_record(base_boca_asheader).records;
	shared clean_suffix   := InsuranceHeader_PreProcess.mod_clean_suffix(clean_name_adr).records;
	shared updatedGender  := InsuranceHeader_PreProcess.UpdateGender(clean_suffix);
														
	output('-----------------------------------------------');
	output(count(base_boca),   								named('BOCA_Base_RecordCount'));
	output(count(base_boca_asheader),   			named('BOCA_Base_AsHeader_RecordCount'));
	output(count(clean_suffix),								named('BOCA_Hdr_New_Clean_RecordCount'));
	output(count(updatedGender),							named('BOCA_Hdr_Updated_Gender_RecordCount'));
	output('-----------------------------------------------');

	// covert record back to boca header layout.
	export getRecords := updatedGender;
END;