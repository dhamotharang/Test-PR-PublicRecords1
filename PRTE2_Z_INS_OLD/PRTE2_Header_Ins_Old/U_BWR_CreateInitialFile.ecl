IMPORT prte_csv, address, doxie, NID, ut, PRTE2_X_Ins_PropertyScramble, PRTE2_Header_Ins;
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'CustTest Initial Alpha PersonHdr-Base');

	// ------------------------------------------------------------------------------------------------------------------
	// CHOOSE_DESIRED_DID_HANDLING - search for this below to decide if re-numbering DIDs or keeping existing in Spreadsheet
	// ------------------------------------------------------------------------------------------------------------------

	Alpharetta_Common_Header_Layout := RECORD
			STRING  Tmp_Source := '';
			STRING  lname := '';
			STRING  fname := '';
			STRING  mname := '';
			STRING  SSN := '';
			STRING  dob := '';
			STRING  address := '';
			STRING  apt := '';
			STRING  city := '';
			STRING  st := '';
			STRING  zip := '';
	END;
	
  // ds1 := prte_csv.ge_header_base.Foreclosure_file_on_lz;
  // ds2 := prte_csv.ge_header_base.LNProperty_file_on_lz;
	ds3 := PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_SF_DS;
	// Alpharetta_Common_Header_Layout PROJECT_FORCLOSURE_HDRS(DS1 L) := TRANSFORM
		// SELF.Tmp_Source := 'F';		// IN CASE WE CARE TO LATER OFFSET DID DIFFERENTLY
		// SELF := L;
	// END;
	// Alpharetta_Common_Header_Layout PROJECT_LNPROPERTY_HDRS(DS2 L) := TRANSFORM
		// SELF.Tmp_Source := 'L';		// IN CASE WE CARE TO LATER OFFSET DID DIFFERENTLY
		// SELF := L;
	// END;
	Alpharetta_Common_Header_Layout PROJECT_XREF_HDRS(ds3 L) := TRANSFORM
		SELF.Tmp_Source := 'X';		// IN CASE WE CARE TO LATER OFFSET DID DIFFERENTLY
		SELF.address := L.street;
		SELF.apt := L.apt;
		SELF.city := L.city;
		SELF.st := L.state;
		SELF.zip := L.zip;
		SELF := L;
	END;
	
	// ds1a := PROJECT(ds1,PROJECT_FORCLOSURE_HDRS(LEFT) );
	// ds2a := PROJECT(ds2,PROJECT_LNPROPERTY_HDRS(LEFT) );
	// dsus := ds1a + ds2a;
	dsus := PROJECT( ds3,PROJECT_XREF_HDRS(LEFT) );
	ds := SORT(dsus, lname,fname,-Tmp_Source);
	
	prte_csv.ge_header_base.layout_payload proj_recs(ds l,integer c) := TRANSFORM
		string st_address := TRIM(l.address + ' '+l.apt);
		string cszString := l.city + ' ' + l.st + ' ' + l.zip;
		string clean_address := address.CleanAddress182(st_address, cszString);
	  self.prim_range := clean_address[1..10];
		self.predir := clean_address[11..12];
		self.prim_name := clean_address[13..40];
		self.suffix      := clean_address[41..44];
		self.addr_suffix := clean_address[41..44];
		self.postdir := clean_address[45..46];
		self.unit_desig := clean_address[47..56];
		// This had simply assigned l.apt, not sure why not taking cleanaddress outright, but I'll provide it as a backup anyway.
		AptString := IF(l.apt>'',l.apt, clean_address[57..64]);
		self.sec_range := AptString;
		// or this could come from clean_address[57..64];
		self.city_name := clean_address[65..89];
		self.p_city_name := clean_address[65..89];
		self.v_city_name := clean_address[90..114];
		self.st := clean_address[115..116];
		self.zip := clean_address[117..121]; 
		self.zip4 := clean_address[122..125];
		self.cart := clean_address[126..129];
		self.cr_sort_sz := clean_address[130];
		self.lot := clean_address[131..134];
		self.lot_order := clean_address[135];
		self.dbpc := clean_address[136..137];
		self.chk_digit := clean_address[138];
		self.rec_type := clean_address[139..140];
		self.county := clean_address[143..145];
		self.geo_lat := clean_address[146..155];
		self.geo_long := clean_address[156..166];
		self.msa := clean_address[167..170];
		self.geo_blk := clean_address[171..177];
		self.geo_match := clean_address[178];
		self.err_stat := clean_address[179..182];
		self.src := 'EQ';
		self.ssn4 := ((string)l.ssn)[6..9];
		self.ssn5 := ((string)l.ssn)[1..5];
		self.s1 := ((string)l.ssn)[1..1];
		self.s2 := ((string)l.ssn)[2..2];
		self.s3 := ((string)l.ssn)[3..3];
		self.s4 := ((string)l.ssn)[4..4];
		self.s5 := ((string)l.ssn)[5..5];
		self.s6 := ((string)l.ssn)[6..6];
		self.s7 := ((string)l.ssn)[7..7];
		self.s8 := ((string)l.ssn)[8..8];
		self.s9 := ((string)l.ssn)[9..9];
		self.dph_lname := metaphonelib.DMetaPhone1(l.lname);
		self.city_code := doxie.Make_CityCode(self.v_city_name);
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.dt_first_seen := 198801;
		self.dt_last_seen := (unsigned)ut.GetDate[1..6];
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		self.number_cohabits := 8;
		self.recent_cohabit := 198001;
		self.same_lname := true;
			lookups := 	  doxie.lookup_setter(2,			'SEX') |
							doxie.lookup_setter(3, 		'CRIM') |
							doxie.lookup_setter(4, 			'CCW') |
							doxie.lookup_setter(3, 			'VEH') |
							doxie.lookup_setter(4, 			'DL') |
							doxie.lookup_setter(3, 		'REL') |
							doxie.lookup_setter(3, 		'FIRE') |
							doxie.lookup_setter(3, 		'FAA') |
							doxie.lookup_setter(3, 		'VESS') |
							doxie.lookup_setter(3, 		'PROF') |
							doxie.lookup_setter(3, 		'BUS') | 
							doxie.lookup_setter(3, 		'PROP') | 
							doxie.lookup_setter(3, 		'BK') |
							doxie.lookup_setter(3, 		'PAW') | 
							doxie.lookup_setter(3, 		'BC') | 
							doxie.lookup_setter(3, 	'PROP_ASSES') | 
							doxie.lookup_setter(3, 	'PROP_DEEDS') | 
							doxie.lookup_setter(3, 	'PROV') | 
							doxie.lookup_setter(3, 	'SANC') | ut.bit_set(0,0);
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;
		self.dob     := (integer) l.dob;
		self.yob     := (unsigned2) l.dob[1..4];
		self := l;
		self := [];
	END;
	
	before_itr0 := project( ds,proj_recs(left, counter));
	before_itr  := sort(before_itr0,fname,lname);

	// ------------------------------------------------------------------------------------------------------------------
	// CHOOSE_DESIRED_DID_HANDLING
	// ------------------------------------------------------------------------------------------------------------------
	//TODO - need to create an "Add" process that will do this ONLY for new records added
	// ------------------------------------------------------------------------------------------------------------------
	// TRANSFORM TO ASSIGN DID VALUES TO THE FIELDS		SHOULD ONLY NEED TO DO ONE TIME DURING INITIAL FILE CREATION
	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		init := prte_csv.ge_header_base.Alpharetta_Ins_INIT_DID;
		new_id := l.fname<>r.fname or l.lname<>r.lname;
		rid := map( l.did=0 => init, l.rid + 1 );
		did := map( l.did=0 => rid, ~new_id => l.did, rid );
		self.did := did;
		self.s_did := did;
		self.hhid := did;
		self.rid := rid;
		self.uid := rid;
		self := r;
	END;
	retds0 := iterate(before_itr,itr_hdr(left,right));
	// ------------------------------------------------------------------------------------------------------------------
	// ------------------------------------------------------------------------------------------------------------------
	// TRANSFORM/ITERATE to SIMPLY SPREAD THE RID,DID VALUES AROUND TO OTHER FIELDS.
	// prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l) := TRANSFORM
		// self.s_did := l.did;
		// self.hhid := l.did;
		// self.rid := l.rid;
		// self.uid := l.rid;
		// self := l;			
	// END;
	// retds0 := iterate(before_itr,itr_hdr(left));
	// ------------------------------------------------------------------------------------------------------------------

	// ------------------------------------------------------------------------------------------------------------------
	AlphaSpreadsheetBase	:= PRTE2_Header_Ins.files.HDR_BASE_ALPHA_NAME;
	retds1 := dedup(retds0, RECORD, all) : PERSIST(AlphaSpreadsheetBase);
	// ------------------------------------------------------------------------------------------------------------------

	// ------------------------------------------------------------------------------------------------------------------
	// NOTE: Danny designed this to make everyone related to everyone.
	// However, it looks like he actually made relationships only if streetNums are equal.
	//TODO - will this cause any issues with alpharetta test cases?
	// For alpharetta here, I'm thinking about adding street name and/or zip - RESEARCH WHAT TO DO
	// Long term I think we might need to bring in related people from spreadsheet for alpha data.
	retds2 := join(retds1,retds1
				,left.prim_range = right.prim_range
				// AND left.prim_name = right.prim_name
				// AND left.zip+left.zip4 = right.zip+right.zip4
				AND left.did <> right.did
				,TRANSFORM({retds1}
					,self.person1:=left.did
					,self.person2:=right.did
					,self:=left)
				,left outer
				);

	// ------------------------------------------------------------------------------------------------------------------
	
	retds3 := SORT(retds2, did);	// : PERSIST('~prte::persist::custtest::PeopleHeader_LNProperty_Dedup_Sort');
	retds := dedup(retds3, RECORD, all);

	AlphaRelatedPersistName := PRTE2_Header_Ins.files.HDR_BASE_ALPHA_RELATES_Name;
	AlphaHeaderFinalDS := retds  : PERSIST(AlphaRelatedPersistName);
	// NOTE: Also might want to bring in relationships from the spreadsheet ???
	// LATER: Only new spreadsheet items without the existing DID need to have a new DID assigned (MAX(DID)+CNTR).
	// ------------------------------------------------------------------------------------------------------------------
	
	buildStep := OUTPUT(AlphaHeaderFinalDS);
	
	SEQUENTIAL(buildStep);