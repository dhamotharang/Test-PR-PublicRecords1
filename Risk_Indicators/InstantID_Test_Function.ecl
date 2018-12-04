import Seed_Files, Models;

export InstantID_Test_Function(string20 TestDataTableName,string30 fname_val,string30 lname_val,string9 ssn_value,
				string5 zip_value,string10 phone_value,string30 Account_Value, unsigned1 NumReturnCodes) := 
				FUNCTION
	
	
	risk_indicators.Layout_InstandID_NuGen Make_InstantID_rec(Seed_files.Key_InstantID Le) := Transform
		
		_ri := dataset([{le.outhri_1,le.outhri_desc_1},{le.outhri_2,le.outhri_desc_2},{le.outhri_3,le.outhri_desc_3},
			{le.outhri_4,le.outhri_desc_4},{le.outhri_5,le.outhri_desc_5},{le.outhri_6,le.outhri_desc_6},{le.outhri_7,le.outhri_desc_7},
			{le.outhri_8,le.outhri_desc_8},{le.outhri_9,le.outhri_desc_9},{le.outhri_10,le.outhri_desc_10},{le.outhri_11,le.outhri_desc_11},
			{le.outhri_12,le.outhri_desc_12},{le.outhri_13,le.outhri_desc_13},{le.outhri_14,le.outhri_desc_14},{le.outhri_15,le.outhri_desc_15},
			{le.outhri_16,le.outhri_desc_16},{le.outhri_17,le.outhri_desc_17},{le.outhri_18,le.outhri_desc_18},{le.outhri_19,le.outhri_desc_19},
			{le.outhri_20,le.outhri_desc_20}],risk_indicators.Layout_Desc);
		risk_indicators.mac_add_sequence(_ri, ri_with_seq);
		self.ri := choosen(ri_with_seq(hri <>'' or desc <> ''), NumReturnCodes);
		fua :=dataset([{le.outfua_1,le.outfua_desc_1},{le.outfua_2,le.outfua_desc_2},{le.outfua_3,le.outfua_desc_3},
			{le.outfua_4,le.outfua_desc_4}],risk_indicators.Layout_Desc);
		self.fua :=fua(hri <>'' or desc <> '');

		chron :=dataset([
				{1,le.outChron_Address_1,le.outChronPrimRange1,le.outChronPreDir1,le.outChronPrimName1,le.outChronAddrSuffix1,le.outChronPostDir1,le.outChronUnitDesignation1,le.outChronSecRange1,le.outChron_City_1,le.outChron_St_1,le.outChron_Zip_1,le.outChron_Zip4_1,le.outChron_phone_1,le.outChron_dt_first_seen_1,le.outChron_dt_last_seen_1, le.Chron_addr_1_isBest, le.outchron_dpbc_1},
				{2,le.outChron_Address_2,le.outChronPrimRange2,le.outChronPreDir2,le.outChronPrimName2,le.outChronAddrSuffix2,le.outChronPostDir2,le.outChronUnitDesignation2,le.outChronSecRange2,le.outChron_City_2,le.outChron_St_2,le.outChron_Zip_2,le.outChron_Zip4_2,le.outChron_phone_2,le.outChron_dt_first_seen_2,le.outChron_dt_last_seen_2, le.Chron_addr_2_isBest, le.outchron_dpbc_2},
				{3,le.outChron_Address_3,le.outChronPrimRange3,le.outChronPreDir3,le.outChronPrimName3,le.outChronAddrSuffix3,le.outChronPostDir3,le.outChronUnitDesignation3,le.outChronSecRange3,le.outChron_City_3,le.outChron_St_3,le.outChron_Zip_3,le.outChron_Zip4_3,le.outChron_phone_3,le.outChron_dt_first_seen_3,le.outChron_dt_last_seen_3, le.Chron_addr_3_isBest, le.outchron_dpbc_3}],Layout_AddressHistory);
		
		self.chronology := chron(~(address='' and city='' and  st='' and zip='' and phone=''));

		
		Addl_Lname :=dataset([{le.outadditional_fname_1,le.outadditional_lname_1,le.outadditional_lname_date_last_1},
				{le.outadditional_fname_2,le.outadditional_lname_2,le.outadditional_lname_date_last_2},
				{le.outadditional_fname_3,le.outadditional_lname_3,le.outadditional_lname_date_last_3}],Layout_LastNames);
		self.Additional_Lname :=Addl_lname(fname1 <> '' or lname1 <> '' or date_last <> '');
		self.acctno := Account_Value;
		self.fname := le.fname;
		//self.mname := le.mname;
		self.lname := le.lname;
		//self.suffix := le.suffix;
		//self.in_streetAddress := le.streetAddress;
		//self.in_city :=le.city;
		//self.in_state :=le.state;
		self.in_zipCode :=le.zipCode;
		//self.in_country :=le.country;
		self.ssn :=le.ssn;
		//self.dob :=le.dob;
		//self.age :=le.age;
		//self.dl_number :=le.dl_number;
		//self.dl_state :=le.dl_state;
		//self.email_address :=le.email_address;
		//self.ip_address :=le.ip_address;
		//self.dppa :=le.dppa;
		//self.glb :=le.glb;
		self.did := (unsigned6) le.outdid;
		self.seq := (unsigned4) le.outseq;
		self.prim_range := le.outprim_range;
		self.predir := le.outpredir;
		self.prim_name := le.outprim_name;
		self.addr_suffix := le.outaddr_suffix;
		self.postdir := le.outpostdir;
		self.unit_desig := le.outunit_desig;
		self.sec_range := le.outsec_range;
		self.p_city_name := le.outp_city_name;
		self.st := le.outst;
		self.z5 := le.outz5;
		self.zip4 := le.outzip4;
		self.country := le.outcountRy;	
		self.lat := le.outlat;
		self.long := le.outlong;
		self.county := le.outcounty;
		self.geo_blk := le.outgeo_blk;
		
		self.addr_status :=le.outaddr_status;
		self.addr_type :=le.outaddr_type;
		self.phone10 	:=	le.outphone10;
		self.wphone10	:=	le.outwphone10;
		self.employer_name	:=	le.outemployer_name;
		self.lname_prev	:=	le.outlname_prev;
		self.transaction_id	:=	(unsigned6) le.outtransaction_id;
		self.verfirst	:=	le.outverfirst;
		self.verlast	:=	le.outverlast;
		self.veraddr	:=	le.outveraddr;
		self.VerPrimRange :=	le.outverprimrange;
		self.VerPreDir :=	le.outverpredir;
		self.VerPrimName :=	le.outverprimname;
		self.VerAddrSuffix :=	le.outveraddrsuffix;
		self.VerPostDir :=	le.outverpostdir;
		self.VerUnitDesignation :=	le.outverunitdesignation;
		self.VerSecRange :=	le.outversecrange;
		self.vercity	:=	le.outvercity;
		self.verstate	:=	le.outverstate;
		self.verzip	:=	le.outverzip;
		self.verzip4 := le.outverzip4;
		self.verDPBC := le.outverdpbc;
		self.vercounty := le.outvercounty;
		self.verssn	:=	le.outverssn;
		self.verdob	:=	le.outverdob;
		self.verhphone	:=	le.outverhphone;
		self.verify_addr	:=	le.outverify_addr;
		self.verify_dob	:=	le.outverify_dob;
		self.valid_ssn	:=	le.outvalid_ssn;
		self.NAS_Summary	:=	(INTEGER1) le.outNAS_Summary;
		self.NAP_Summary	:=	(INTEGER1) le.outNAP_Summary;
		self.NAP_Type	:=	le.outNAP_Type;
		self.NAP_Status	:=	le.outNAP_Status;
		self.CVI	:=	le.outCVI;
		self.additional_score1	:=	(INTEGER1) le.outadditional_score1;
		self.additional_score2	:=	(INTEGER1) le.outadditional_score2;
		self.corrected_lname	:=	le.outcorrected_lname;
		self.corrected_dob	:=	le.outcorrected_dob;
		self.corrected_phone	:=	le.outcorrected_phone;
		self.corrected_ssn	:=	le.outcorrected_ssn;
		self.corrected_address	:=	le. outcorrected_address;
		self.correctedPrimRange :=	le.outcorrectedprimrange;
		self.correctedPreDir :=	le.outcorrectedpredir;
		self.correctedPrimName :=	le.outcorrectedprimname;
		self.correctedAddrSuffix :=	le.outcorrectedaddrsuffix;
		self.correctedPostDir :=	le.outcorrectedpostdir;
		self.correctedUnitDesignation :=	le.outcorrectedunitdesignation;
		self.correctedSecRange :=	le.outcorrectedsecrange;
		self.area_code_split	:=	le.outarea_code_split;
		self.area_code_split_date	:=	le.outarea_code_split_date;
		self.phone_fname	:=	le.outphone_fname;
		self.phone_lname	:=	le.outphone_lname;
		self.phone_address	:=	le.outphone_address;
		self.phonePrimRange :=	le.outphoneprimrange;
		self.phonePreDir :=	le.outphonepredir;
		self.phonePrimName :=	le.outphoneprimname;
		self.phoneAddrSuffix :=	le.outphoneaddrsuffix;
		self.phonePostDir :=	le.outphonepostdir;
		self.phoneUnitDesignation :=	le.outphoneunitdesignation;
		self.phoneSecRange :=	le.outphonesecrange;
		self.phone_city	:=	le.outphone_city;
		self.phone_st	:=	le.outphone_st;
		self.phone_zip	:=	le.outphone_zip;
		self.name_addr_phone	:=	le.outname_addr_phone;
		self.ssa_date_first	:=	le.outssa_date_first;
		self.ssa_date_last	:=	le.outssa_date_last;
		self.ssa_state	:=	le.outssa_state;
		self.ssa_state_name	:=	le.outssa_state_name;
		self.current_fname	:=	le.outcurrent_fname;
		self.current_lname	:=	le.outcurrent_lname;
		self.Watchlist_Table :=		le.outWatchlist_Table;
		self.Watchlist_Program	:=	le.outWatchlist_Program;
		self.Watchlist_Record_Number	:=	le.outWatchlist_Record_Number;
		self.Watchlist_fname	:=	le.outWatchlist_fname;
		self.Watchlist_lname	:=	le.outWatchlist_lname;
		self.Watchlist_address	:=	le.outWatchlist_address;
		self.WatchlistPrimRange :=	le.outWatchlistprimrange;
		self.WatchlistPreDir :=	le.outWatchlistpredir;
		self.WatchlistPrimName :=	le.outWatchlistprimname;
		self.WatchlistAddrSuffix :=	le.outWatchlistaddrsuffix;
		self.WatchlistPostDir :=	le.outWatchlistpostdir;
		self.WatchlistUnitDesignation :=	le.outWatchlistunitdesignation;
		self.WatchlistSecRange :=	le.outWatchlistsecrange;
		self.Watchlist_city	:=	le.outWatchlist_city;
		self.Watchlist_state	:=	le.outWatchlist_state;
		self.Watchlist_zip	:=	le.outWatchlist_zip;
		self.Watchlist_contry	:=	le.outWatchlist_contry;
		self.Watchlist_Entity_Name	:=	le.outWatchlist_Entity_Name;
		
		watchlists := dataset([
													{le.outWatchlist_Table, le.outWatchlist_Program, le.outWatchlist_Record_Number, le.outWatchlist_fname, le.outWatchlist_lname,	le.outWatchlist_address,
															le.outWatchlistPrimRange, le.outWatchlistPreDir, le.outWatchlistPrimName, le.outWatchlistAddrSuffix, 
															le.outWatchlistPostDir, le.outWatchlistUnitDesignation, le.outWatchlistSecRange,
															le.outWatchlist_city, le.outWatchlist_state, le.outWatchlist_zip,	le.outWatchlist_contry, le.outWatchlist_Entity_Name},
													{le.Watchlist_Table_2, le.Watchlist_Program_2, le.Watchlist_Record_Number_2, le.Watchlist_fname_2, le.Watchlist_lname_2,	le.Watchlist_address_2, 
															le.WatchlistPrimRange2, le.WatchlistPreDir2, le.WatchlistPrimName2, le.WatchlistAddrSuffix2, 
															le.WatchlistPostDir2, le.WatchlistUnitDesignation2, le.WatchlistSecRange2,
															le.Watchlist_city_2, le.Watchlist_state_2, le.Watchlist_zip_2,	le.Watchlist_contry_2, le.Watchlist_Entity_Name_2},		
													{le.Watchlist_Table_3, le.Watchlist_Program_3, le.Watchlist_Record_Number_3, le.Watchlist_fname_3, le.Watchlist_lname_3,	le.Watchlist_address_3, 
															le.WatchlistPrimRange3, le.WatchlistPreDir3, le.WatchlistPrimName3, le.WatchlistAddrSuffix3, 
															le.WatchlistPostDir3, le.WatchlistUnitDesignation3, le.WatchlistSecRange3,
															le.Watchlist_city_3, le.Watchlist_state_3, le.Watchlist_zip_3,	le.Watchlist_contry_3, le.Watchlist_Entity_Name_3},		
													{le.Watchlist_Table_4, le.Watchlist_Program_4, le.Watchlist_Record_Number_4, le.Watchlist_fname_4, le.Watchlist_lname_4,	le.Watchlist_address_4, 
															le.WatchlistPrimRange4, le.WatchlistPreDir4, le.WatchlistPrimName4, le.WatchlistAddrSuffix4, 
															le.WatchlistPostDir4, le.WatchlistUnitDesignation4, le.WatchlistSecRange4,
															le.Watchlist_city_4, le.Watchlist_state_4, le.Watchlist_zip_4,	le.Watchlist_contry_4, le.Watchlist_Entity_Name_4},		
													{le.Watchlist_Table_5, le.Watchlist_Program_5, le.Watchlist_Record_Number_5, le.Watchlist_fname_5, le.Watchlist_lname_5,	le.Watchlist_address_5, 
															le.WatchlistPrimRange5, le.WatchlistPreDir5, le.WatchlistPrimName5, le.WatchlistAddrSuffix5, 
															le.WatchlistPostDir5, le.WatchlistUnitDesignation5, le.WatchlistSecRange5,
															le.Watchlist_city_5, le.Watchlist_state_5, le.Watchlist_zip_5,	le.Watchlist_contry_5, le.Watchlist_Entity_Name_5},		
													{le.Watchlist_Table_6, le.Watchlist_Program_6, le.Watchlist_Record_Number_6, le.Watchlist_fname_6, le.Watchlist_lname_6,	le.Watchlist_address_6, 
															le.WatchlistPrimRange6, le.WatchlistPreDir6, le.WatchlistPrimName6, le.WatchlistAddrSuffix6, 
															le.WatchlistPostDir6, le.WatchlistUnitDesignation6, le.WatchlistSecRange6,
															le.Watchlist_city_6, le.Watchlist_state_6, le.Watchlist_zip_6,	le.Watchlist_contry_6, le.Watchlist_Entity_Name_6},		
													{le.Watchlist_Table_7, le.Watchlist_Program_7, le.Watchlist_Record_Number_7, le.Watchlist_fname_7, le.Watchlist_lname_7,	le.Watchlist_address_7,
															le.WatchlistPrimRange7, le.WatchlistPreDir7, le.WatchlistPrimName7, le.WatchlistAddrSuffix7, 
															le.WatchlistPostDir7, le.WatchlistUnitDesignation7, le.WatchlistSecRange7,
															le.Watchlist_city_7, le.Watchlist_state_7, le.Watchlist_zip_7,	le.Watchlist_contry_7, le.Watchlist_Entity_Name_7}
													], risk_indicators.layouts.layout_watchlists);
		
		risk_indicators.mac_add_sequence(watchlists, watchlists_with_seq);
		
		self.watchlists := watchlists_with_seq(watchlist_table<>'');	

		self.addressPOBox := (BOOLEAN)le.addressPOBox;
		self.addressCMRA := (BOOLEAN)le.addressCMRA;	
	
		self.SSNFoundForLexID := (BOOLEAN)le.SSNFoundForLexID;
		self.cviCustomScore := le.cviCustomScore;
    self.AddressSecondaryRangeMismatch := le.AddressSecondaryRangeMismatch;
		
		self := le;
		self := [];  // blank out sections which have now been broken out into their own testseed files, like red flags and models for example
	END;
	
	fname_value :=stringlib.stringtouppercase(fname_val);
	lname_value :=stringlib.stringtouppercase(lname_val);
	Test_Data_Table_Name :=stringlib.stringtouppercase(TestDataTableName);
	
	hash_from_input :=Seed_Files.Hash_InstantID((string20)fname_value,(string20)lname_value,(string9)ssn_value,Risk_Indicators.nullstring
						,(string5)zip_value,(string10)phone_value,Risk_Indicators.nullstring);
	
	SeedFile_rec := Choosen(Seed_Files.Key_InstantID(keyed(dataset_name=Test_Data_Table_Name), keyed(hashvalue = hash_from_input)),1);
	
	InstantID_rec :=project(SeedFile_rec,Make_InstantID_rec(left));
	
	return InstantID_rec;

END;
