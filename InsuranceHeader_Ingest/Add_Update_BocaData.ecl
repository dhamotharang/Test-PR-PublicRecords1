IMPORT idl_header, header,insuranceHeader_postprocess,insuranceHeader_preprocess, STD;

EXPORT Add_Update_BocaData(DATASET(header.layout_header_v2_dl) ds_boca  ) := MODULE

	header_layout 	 	:= idl_header.Layout_Header_Link;
	
  // Base File
	 base_boca := ds_boca(src != 'TS');
	
  // filter records 
	 noIRSDummyDid 			:= base_boca(did NOT IN insuranceHeader_preprocess.IRS_DummyDids);
	
	// Transform records to insurance header layout format
	 header_layout xformToIdlLayout(noIRSDummyDid L) := TRANSFORM
		SELF.SRC											:= idl_header.Constants.Boca_Header_Records + L.SRC;
		SELF.DID											:= 0;
		SELF.RID                      := 0; 
		SELF.Source_rid               := L.RID; 
		SELF.SNAME										:= if(L.NAME_SUFFIX[1..2] = 'UN', '', L.NAME_SUFFIX);
		self.prim_name    						:= if(L.prim_name[1..4] = 'DOD:' or L.prim_name[1..5] = 'DOD :', '', L.prim_name);
		SELF.ADDR_SUFFIX							:= L.SUFFIX;
		SELF.CITY											:= L.CITY_NAME;
		SELF.dl_nbr										:= if(L.dl_number[1..4] = 'LNID', 						'', 									L.dl_number);
		SELF.dl_state									:= if(L.dl_number[1..4] = 'LNID', 						'', 									L.dl_state);
		SELF.BOCA_DID									:= L.DID;
		self.DT_FIRST_SEEN 						:= L.dt_first_seen * 100; // Added Day 00 to all dates
		self.DT_LAST_SEEN  						:= L.dt_last_seen * 100;
		self.DT_VENDOR_FIRST_REPORTED := L.dt_vendor_first_reported * 100;
		self.DT_VENDOR_LAST_REPORTED  := L.dt_vendor_last_reported * 100;
		SELF.DT_EFFECTIVE_FIRST       := Std.Date.Today() ; 
		SELF.DT_EFFECTIVE_LAST        := 0 ; 
		SELF 													:= L;
		SELF													:= [];
	end;
	base_boca_asheader := project(noIRSDummyDid, xformToIdlLayout(left));
  clean_name_adr := insuranceHeader_preprocess.mod_clean_record(base_boca_asheader).records;
  clean_suffix   := insuranceHeader_preprocess.mod_clean_suffix(clean_name_adr).records;

	EXPORT getRecords         := Project(clean_suffix ,  TRANSFORM({Layout_Base}, 
	                             Self.src_orig              := LEFT.src ; 
															 SELF.ssn                   := IF((INTEGER4)LEFT.ssn = 0, '', LEFT.ssn);
															 Self := left)); 
															 
END;

