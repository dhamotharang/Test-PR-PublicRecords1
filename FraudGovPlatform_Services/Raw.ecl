IMPORT Address, AutoStandardI, Business_Risk,iesp, CriminalRecords_BatchService, DeathV2_Services, 
			 FraudShared_Services, Gateway, patriot, risk_indicators, riskwise, ut;

EXPORT Raw := MODULE

	SHARED boolean Include_ALL_Watchlist  := FALSE : STORED('Include_ALL_Watchlist');
	SHARED boolean Include_BES_Watchlist  := FALSE : STORED('Include_BES_Watchlist');
	SHARED boolean Include_CFTC_Watchlist := FALSE : STORED('Include_CFTC_Watchlist');
	SHARED boolean Include_DTC_Watchlist  := FALSE : STORED('Include_DTC_Watchlist');
	SHARED boolean Include_EUDT_Watchlist := FALSE : STORED('Include_EUDT_Watchlist');
	SHARED boolean Include_FBI_Watchlist  := FALSE : STORED('Include_FBI_Watchlist');
	SHARED boolean Include_FCEN_Watchlist := FALSE : STORED('Include_FCEN_Watchlist');
	SHARED boolean Include_FAR_Watchlist  := FALSE : STORED('Include_FAR_Watchlist');
	SHARED boolean Include_IMW_Watchlist  := FALSE : STORED('Include_IMW_Watchlist');
	SHARED boolean Include_OFAC_Watchlist := FALSE : STORED('Include_OFAC_Watchlist');
	SHARED boolean Include_OCC_Watchlist  := FALSE : STORED('Include_OCC_Watchlist');
	SHARED boolean Include_OSFI_Watchlist := FALSE : STORED('Include_OSFI_Watchlist');
	SHARED boolean Include_PEP_Watchlist  := FALSE : STORED('Include_PEP_Watchlist');
	SHARED boolean Include_SDT_Watchlist  := FALSE : STORED('Include_SDT_Watchlist');
	SHARED boolean Include_BIS_Watchlist  := FALSE : STORED('Include_BIS_Watchlist');
	SHARED boolean Include_UNNT_Watchlist := FALSE : STORED('Include_UNNT_Watchlist');
	SHARED boolean Include_WBIF_Watchlist := FALSE : STORED('Include_WBIF_Watchlist');

	SHARED boolean Include_ADFA_Watchlist := FALSE : STORED('Include_ADFA_Watchlist');
	SHARED boolean Include_FAJC_Watchlist := FALSE : STORED('Include_FAJC_Watchlist');
	SHARED boolean Include_FATF_Watchlist := FALSE : STORED('Include_FATF_Watchlist');
	SHARED boolean Include_FBIH_Watchlist := FALSE : STORED('Include_FBIH_Watchlist');
	SHARED boolean Include_FBIS_Watchlist := FALSE : STORED('Include_FBIS_Watchlist');
	SHARED boolean Include_FBIT_Watchlist := FALSE : STORED('Include_FBIT_Watchlist');
	SHARED boolean Include_FBIW_Watchlist := FALSE : STORED('Include_FBIW_Watchlist');
	SHARED boolean Include_HKMA_Watchlist := FALSE : STORED('Include_HKMA_Watchlist');
	SHARED boolean Include_MASI_Watchlist := FALSE : STORED('Include_MASI_Watchlist');
	SHARED boolean Include_OFFC_Watchlist := FALSE : STORED('Include_OFFC_Watchlist');
	SHARED boolean Include_PMLC_Watchlist := FALSE : STORED('Include_PMLC_Watchlist');
	SHARED boolean Include_PMLJ_Watchlist := FALSE : STORED('Include_PMLJ_Watchlist');
	
	SHARED GetWatchlist() := FUNCTION
		dWL := DATASET([], iesp.share.t_StringArrayItem) 
      + IF(Include_ALL_Watchlist,  DATASET([{patriot.constants.wlALL}],  iesp.share.t_StringArrayItem))
		  + IF(Include_BES_Watchlist,  DATASET([{patriot.constants.wlBES}],  iesp.share.t_StringArrayItem))
		  + IF(Include_CFTC_Watchlist, DATASET([{patriot.constants.wlCFTC}], iesp.share.t_StringArrayItem))
		  + IF(Include_DTC_Watchlist,  DATASET([{patriot.constants.wlDTC}],  iesp.share.t_StringArrayItem))
		  + IF(Include_EUDT_Watchlist, DATASET([{patriot.constants.wlEUDT}], iesp.share.t_StringArrayItem))
		  + IF(Include_FBI_Watchlist,  DATASET([{patriot.constants.wlFBI}],  iesp.share.t_StringArrayItem))
		  + IF(Include_FCEN_Watchlist, DATASET([{patriot.constants.wlFCEN}], iesp.share.t_StringArrayItem))
		  + IF(Include_FAR_Watchlist,  DATASET([{patriot.constants.wlFAR}],  iesp.share.t_StringArrayItem))
		  + IF(Include_IMW_Watchlist,  DATASET([{patriot.constants.wlIMW}],  iesp.share.t_StringArrayItem))
		  + IF(Include_OFAC_Watchlist, DATASET([{patriot.constants.wlOFAC}], iesp.share.t_StringArrayItem))
		  + IF(Include_OCC_Watchlist,  DATASET([{patriot.constants.wlOCC}],  iesp.share.t_StringArrayItem))
		  + IF(Include_OSFI_Watchlist, DATASET([{patriot.constants.wlOSFI}], iesp.share.t_StringArrayItem))
		  + IF(Include_PEP_Watchlist,  DATASET([{patriot.constants.wlPEP}],  iesp.share.t_StringArrayItem))
		  + IF(Include_SDT_Watchlist,  DATASET([{patriot.constants.wlSDT}],  iesp.share.t_StringArrayItem))
		  + IF(Include_BIS_Watchlist,  DATASET([{patriot.constants.wlBIS}],  iesp.share.t_StringArrayItem))
		  + IF(Include_UNNT_Watchlist, DATASET([{patriot.constants.wlUNNT}], iesp.share.t_StringArrayItem))
		  + IF(Include_WBIF_Watchlist, DATASET([{patriot.constants.wlWBIF}], iesp.share.t_StringArrayItem))
		  + IF(Include_ADFA_Watchlist, DATASET([{patriot.constants.wlADFA}], iesp.share.t_StringArrayItem))
		  + IF(Include_FAJC_Watchlist, DATASET([{patriot.constants.wlFAJC}], iesp.share.t_StringArrayItem))
		  + IF(Include_FATF_Watchlist, DATASET([{patriot.constants.wlFATF}], iesp.share.t_StringArrayItem))
		  + IF(Include_FBIH_Watchlist, DATASET([{patriot.constants.wlFBIH}], iesp.share.t_StringArrayItem))
		  + IF(Include_FBIS_Watchlist, DATASET([{patriot.constants.wlFBIS}], iesp.share.t_StringArrayItem))
		  + IF(Include_FBIT_Watchlist, DATASET([{patriot.constants.wlFBIT}], iesp.share.t_StringArrayItem))
		  + IF(Include_FBIW_Watchlist, DATASET([{patriot.constants.wlFBIW}], iesp.share.t_StringArrayItem))
		  + IF(Include_HKMA_Watchlist, DATASET([{patriot.constants.wlHKMA}], iesp.share.t_StringArrayItem))
		  + IF(Include_MASI_Watchlist, DATASET([{patriot.constants.wlMASI}], iesp.share.t_StringArrayItem))
		  + IF(Include_OFFC_Watchlist, DATASET([{patriot.constants.wlOFFC}], iesp.share.t_StringArrayItem))
		  + IF(Include_PMLC_Watchlist, DATASET([{patriot.constants.wlPMLC}], iesp.share.t_StringArrayItem))
		  + IF(Include_PMLJ_Watchlist, DATASET([{patriot.constants.wlPMLJ}], iesp.share.t_StringArrayItem));
		
		RETURN dWL;
		
	END;

	EXPORT GetDeath(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
									FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
									
		death_batch_params := DeathV2_Services.IParam.getBatchParams();		
		ds_death_in := PROJECT(ds_batch_in, DeathV2_Services.Layouts.BatchIn);

		ds_death := DeathV2_Services.BatchRecords(ds_death_in, death_batch_params);
		
		RETURN ds_death;
	
	END;
	
	EXPORT GetCriminal(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
										 FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
									
		crim_batch_params := MODULE(
      PROJECT(batch_params, CriminalRecords_BatchService.IParam.batch_params, OPT))
		END;
		
		ds_crim_in := PROJECT(ds_batch_in, TRANSFORM(CriminalRecords_BatchService.Layouts.batch_in, SELF := LEFT, SELF := []));
		
		ds_criminal := CriminalRecords_BatchService.BatchRecords(crim_batch_params, ds_crim_in);
		ds_criminal_records := ds_criminal.Records;
									
		RETURN ds_criminal_records;
	
	END;
	
	EXPORT GetRedFlags(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
										 FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

		boolean ln_branded_value := FALSE : STORED('LnBranded');
		unsigned3 history_date := 999999 : STORED('HistoryDateYYYYMM');
	
		// The default version of 0 will cause nothing to be returned.
		// unsigned1 RedFlag_version := 0 : STORED('RedFlag_version');
		unsigned1 RedFlag_version := 1 : STORED('RedFlag_version');
		boolean	IncludeTargus := TRUE	: STORED('Targus');	// default to TRUE so existing batch jobs work the same as they were
		boolean IncludeTargus3220 := FALSE : STORED('IncludeTargusE3220');
		string DataRestriction := batch_params.DataRestrictionMask;

		boolean IIDVersionOverride := FALSE	: STORED('IIDVersionOverride');	// back office tag that, if true, allows a version lower than the lowestAllowedVersion
		string1 IIDVersion := '0' : STORED('InstantIDVersion');	// this is passed in by the customer, if nothing passed in, then 0
		boolean EnableEmergingID := FALSE : stored('EnableEmergingID');
		string3 NameInputOrder := '' : STORED('NameInputOrder');	// sequence of name (FML = First/Middle/Last, LFM = Last/First/Middle) if not specified, uses default name parser

		unsigned1 lowestAllowedVersion := 1;	// lowest allowed version according to product, unless the IIDVersionOveride is true
		unsigned1 maxAllowedVersion := 1;	// maximum allowed version as of 1/28/2014

		// calculate the actual iidVersion that will be used.  To start, versions 0 and 1 will be supported.  0 will represent the historical iid, while version 1 will
		// represent the new logic implemented for 1/28/2014 release (new cvi, phones plus, inquiries, insurance header, reason codes etc).  A new input tag will allow the customer
		// to choose the version they want to use.  This version cannot be lower than the lowest allowed version unless the override tag is set to true, in which case
		// the customer can choose any version and if no version is passed in, it will be considered version 0.
		actualIIDVersion := MAP((unsigned)IIDVersion > maxAllowedVersion => 99,	// they asked for a version that doesn't exist
														IIDVersionOverride = false => ut.imin2(ut.max2((unsigned)IIDversion, lowestAllowedVersion), maxAllowedVersion),	// choose the higher of the allowed or asked for because they can't override lowestAllowedVersion, however, don't let them pick a version that is higher than the highest one we currently support
														(unsigned)IIDversion); // they can override, give them whatever they asked for
		in_format := RECORD
			risk_indicators.Layout_Batch_In;
			string20 HistoryDateTimeStamp := '';
			string6 Gender := '';
			string44 PassportUpperLine := '';
			string44 PassportLowerLine := '';
			// fields below requested by Deni/Mike to be added for fraudpoint 2.0, even though we do nothing with them
			string5 Grade := '';
			string16 Channel := '';
			string8 Income := '';
			string16 OwnOrRent := '';
			string16 LocationIdentifier := '';
			string16 OtherApplicationIdentifier := '';
			string16 OtherApplicationIdentifier2 := '';
			string16 OtherApplicationIdentifier3 := '';
			string8 DateofApplication := '';
			string8 TimeofApplication := '';
			string50 email := '';
			string64 custom_input1 := '';
			string64 custom_input2 := '';
			string64 custom_input3 := '';
			string64 custom_input4 := '';
			string64 custom_input5 := '';
			string64 custom_input6 := '';
			string64 custom_input7 := '';
			string64 custom_input8 := '';
			string64 custom_input9 := '';
			string64 custom_input10 := '';
			string64 custom_input11 := '';
			string64 custom_input12 := '';
			string64 custom_input13 := '';
			string64 custom_input14 := '';
			string64 custom_input15 := '';
			string64 custom_input16 := '';
			string64 custom_input17 := '';
			string64 custom_input18 := '';
			string64 custom_input19 := '';
			string64 custom_input20 := '';
			string64 custom_input21 := '';
			string64 custom_input22 := '';
			string64 custom_input23 := '';
			string64 custom_input24 := '';
			string64 custom_input25 := '';
			string120 UnparsedFullName2;
			string30  Name_First2;
			string30  Name_Middle2;
			string30  Name_Last2;
			string5   Name_Suffix2;
			string65  Street_Addr2;
			string10  Prim_Range2;
			string2   Predir2;
			string28  Prim_Name2;
			string4   Suffix2;
			string2   Postdir2;
			string10  Unit_Desig2;
			string8   Sec_Range2;
			string25  p_City_name2;
			string2   St2;
			string5   Z52;
			string10  Home_Phone2;	
		END;

		ds_red_flags := PROJECT(ds_batch_in, 
												TRANSFORM(in_format, 
														SELF.seq := COUNTER,
														SELF := LEFT, 
														SELF := []));

		Gateway.Layouts.Config gw_switch(batch_params.gateways le) := TRANSFORM
			SELF.servicename := MAP(IncludeTargus = FALSE AND le.servicename = 'targus' => '',	// don't call TG when Targus = FALSE
															IncludeTargus3220 AND le.servicename = 'targus' => 'targuse3220',	// if E3220 requested, change servicename for later use
															le.servicename);
			SELF.url := MAP(IncludeTargus = FALSE AND le.servicename = 'targus' => '',	// don't call TG when Targus = FALSE
											IncludeTargus3220 AND le.servicename = 'targus' => le.url + '?ver_=1.39',	// need version 1.39 for E3220,
											le.url); 
			SELF := le;
		END;
		gateways := PROJECT(batch_params.gateways, gw_switch(left));

		fseqrec := RECORD
			ds_red_flags;
		END;

		fseqrec into_seq(ds_red_flags L, integer C) := TRANSFORM
			SELF.seq := C;
			SELF := l;
		END;

		ds_red_flags_pre := PROJECT(ds_red_flags, into_seq(LEFT,COUNTER));

		boolean IsInstantID := TRUE;
		reasoncode_settings := DATASET([{IsInstantID, actualIIDVersion, EnableEmergingID}],riskwise.layouts.reasoncode_settings);

		risk_indicators.Layout_Input into(ds_red_flags_pre le) := TRANSFORM
			historydate := if(le.HistoryDateYYYYMM=0, history_date, le.HistoryDateYYYYMM);
			
			SELF.historydate := if(le.historyDateTimeStamp<>'',(unsigned)le.historyDateTimeStamp[1..6], historydate);
			SELF.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(le.historydateTimeStamp, historydate);
			// clean up input
			dob_val := riskwise.cleandob(le.dob);
			dl_num_clean := riskwise.cleanDL_num(le.dl_number);

			SELF.seq := le.seq;	
			SELF.ssn := IF(le.ssn='000000000','',le.ssn);	// blank out social if it is all 0's
			SELF.dob := dob_val;
			SELF.age := IF ((integer)le.age = 0 AND (integer)dob_val != 0,(string3)ut.GetAgeI((integer)dob_val), (le.age));
			
			SELF.phone10 := le.Home_Phone;
			SELF.wphone10 := le.Work_Phone;

			cleaned_name := Stringlib.StringToUppercase(
												MAP(TRIM(Stringlib.StringToUppercase(NameInputOrder)) = 'FML' => Address.CleanPersonFML73(le.UnParsedFullName),
														TRIM(Stringlib.StringToUppercase(NameInputOrder)) = 'LFM' => Address.CleanPersonLFM73(le.UnParsedFullName),
																																												 Address.CleanPerson73(le.UnParsedFullName)));
			
			boolean valid_cleaned := le.UnParsedFullName <> '';
			
			clnName := Address.CleanNameFields(cleaned_name);
			SELF.fname := stringlib.stringtouppercase(IF(le.Name_First='' AND valid_cleaned, clnName.fname, le.Name_First));
			SELF.lname := stringlib.stringtouppercase(IF(le.Name_Last='' AND valid_cleaned, clnName.lname, le.Name_Last));
			SELF.mname := stringlib.stringtouppercase(IF(le.Name_Middle='' AND valid_cleaned, clnName.mname, le.Name_Middle));
			SELF.suffix := stringlib.stringtouppercase(IF(le.Name_Suffix ='' AND valid_cleaned, clnName.name_suffix, le.Name_Suffix));	
			SELF.title := stringlib.stringtouppercase(IF(valid_cleaned, clnName.title,''));

			street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
			clean_a2 := risk_indicators.MOD_AddressClean.clean_addr(street_address, le.p_City_name, le.St, le.Z5 );	
			
			SELF.in_streetAddress := street_address;
			SELF.in_city := le.p_City_name;
			SELF.in_state := le.St;
			SELF.in_zipCode := le.Z5;
			
			clnAddress := Address.CleanFields(clean_a2);	
				
			SELF.prim_range := clnAddress.prim_range;
			SELF.predir := clnAddress.PreDir;
			SELF.prim_name := clnAddress.prim_name;
			SELF.addr_suffix := clnAddress.addr_suffix;
			SELF.postdir := clnAddress.PostDir;
			SELF.unit_desig := clnAddress.unit_desig;
			SELF.sec_range := clnAddress.sec_range;
			SELF.p_city_name := clnAddress.p_city_name;
			SELF.st := clnAddress.st;
			SELF.z5 := clnAddress.Zip;
			SELF.zip4 := clnAddress.Zip4;
			SELF.lat := clnAddress.geo_lat;
			SELF.long := clnAddress.geo_long;
			SELF.addr_type := risk_indicators.iid_constants.override_addr_type(street_address, clean_a2[139],clean_a2[126..129]);

			SELF.addr_status := clean_a2[179..182];
			SELF.county := clean_a2[143..145];
			SELF.geo_blk := clean_a2[171..177];
			
			SELF.dl_number := stringlib.stringtouppercase(dl_num_clean);
			SELF.dl_state := stringlib.stringtouppercase(le.dl_state);
			
			SELF.ip_address := le.ip_addr;
			SELF.email_address := le.email;
			
			SELF := [];
		end;

		ds_red_flags_in := PROJECT(ds_red_flags_pre, into(LEFT));

		ds_red_flags_out := Risk_Indicators.InstantID_Function(ds_red_flags_in, gateways, batch_params.DPPAPurpose,  
																													 batch_params.GLBPurpose, batch_params.IndustryClass='UTILI', 
																													 ln_branded_value);
		
		red_flags_ret := IF(RedFlag_version<>0, risk_indicators.Red_Flags_Function(ds_red_flags_out, reasoncode_settings), DATASET([], FraudGovPlatform_Services.Layouts.combined_layouts) );
		
		IF(actualIIDVersion=99, FAIL('Not an allowable InstantIDVersion.  Currently versions 0 and 1 are supported'));
		
		RETURN red_flags_ret;
								
	END;
	
 	EXPORT GetGlobalWatchlist(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
														FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
														
		  string20 search_type := 'BOTH' : STORED('search_type');
			
  		patriot.Layout_batch_in xform_in(ds_batch_in le) := TRANSFORM
      //SELF.seq := C;
  			 SELF.name_first := Stringlib.StringToUpperCase(le.name_first);
		    SELF.name_middle := Stringlib.StringToUpperCase(le.name_middle);
  			 SELF.name_last := Stringlib.StringToUpperCase(le.name_last);
		  	 SELF.name_unparsed := '';
	  		 SELF.country := '';
	  		 SELF.search_type := Stringlib.StringToUpperCase(search_type);
		  	 SELF.dob := le.dob;	
		  	 SELF := le;
		  END;
			
	   ds_global_watchlist_in := GROUP(PROJECT(ds_batch_in, xform_in(LEFT)), acctno);
		
    // Parameters to function call from Michele Walklin
		  ds_global_watchlist_out := Patriot.Search_Batch_Function(ds_global_watchlist_in, FALSE, 0.00, 2, TRUE);
									
		  RETURN UNGROUP(ds_global_watchlist_out);
										 
 	END;
	
END;
