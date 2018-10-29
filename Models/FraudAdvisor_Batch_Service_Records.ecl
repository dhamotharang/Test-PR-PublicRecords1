import  address, risk_indicators, models, riskwise, ut, Gateway, Royalty, Easi;



EXPORT FraudAdvisor_Batch_Service_Records ( Models.FraudAdvisor_Batch_Service_Interfaces.Input args ,
																					  dataset(Models.FraudAdvisor_Batch_Service_Layouts.BatchInput) batchin ,
																					  dataset(Gateway.Layouts.Config) gateways,
																						dataset(riskwise.Layout_IP2O) inIPdata = dataset([], riskwise.Layout_IP2O)) :=  function

Boolean VALIDATION := false; //True when validating model, false for production mode.

//These 2 value types are being used multiple times.
    boolean  doVersion1               := args.doVersion1;
    boolean  doVersion2               := args.doVersion2;
    boolean  doParo                   := args.doParo_attrs;
    string   requestedattributegroups := StringLib.StringToLowerCase(args.requestedattributegroups);
		
		string	model_name 	:= StringLib.StringToLowerCase(args.ModelName_in);
		boolean	isUtility 	:= StringLib.StringToUpperCase(args.industry_class_val) = 'UTILI';

		fraudpoint2_models := ['fp1109_0', 'fp1109_9', 'fp1307_2'];
		fraudpoint3_models := ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9']; // FP3 Flagship models
		FP3_models_requiring_GLB	:= ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9']; //these models require valid GLB, else fail
		fraudpoint3_custom_models := ['fp1702_2','fp1702_1','fp1508_1'];

		bill_to_ship_to_models := ['fp1409_2']; // Populate with real model ids when the time comes.
  
		bsVersion := MAP( doParo or requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'] or model_name IN ['fp1508_1','msn1803_1','rsn804_1','msnrsn_1'] => 53, // bs 53
                      model_name IN ['fp3fdn1505_0', 'fp31505_0', 'fp3fdn1505_9', 
                                     'fp31505_9','fp1702_2','fp1702_1'] => 51, //run 51 shell for both FP3 models
                      requestedattributegroups IN ['fraudpointattrv201'] => 50,
											model_name IN ['fp1210_1', 'fp1307_2', 'fp1409_2'] => 41, 
											doVersion2 or model_name in fraudpoint2_models	=> 4,
											model_name IN ['fp31105_1'] => 3,
																										 2
										);

		// Add model name to this list if clam_ip/netacuity is used. 
		boolean	trackNetacuityRoyalties := ~exists(inIPdata) AND model_name IN ['fp1109_0', 'fp1109_9', 'fp1307_2', 'fp3710_0', 'fp31105_1', 
																																						'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'];

		// add sequence to any input Ipdata to matchup later in a Models.getFDAttributes join
		RiskWise.Layout_IP2O tf_seq_ipdata(inIPdata le, integer C) := TRANSFORM
			self.seq := C;
			self     := le;
		END;
		inIPdata_seq := project(inIPdata, tf_seq_ipdata(left,counter));

		// new options for fp attributes 2.0
		IncludeDLverification := doVersion2 OR requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'] ;
		unsigned8 BSOptions := if(doVersion2 OR requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'] or model_name in ['fp1210_1','fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 
		                                                       'fp3fdn1505_9','fp1702_2','fp1702_1','fp1508_1'], 
			risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary +
			risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
			risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
			0);

		// add sequence to matchup later to add acctno to output
		Models.FraudAdvisor_Batch_Service_Layouts.BatchInput into_seq(batchin le, integer C) := TRANSFORM
			self.seq := C;
			self := le;
		END;
    
#IF(VALIDATION)
    batchinseq := batchin;	//To retain sequence number during validation...this is for validation only...do not implement!!!
#ELSE
		batchinseq := project(batchin, into_seq(left,counter));  
#END		


		risk_indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
			// clean up input
			dob_val := riskwise.cleandob(le.dob);
			dl_num_clean := riskwise.cleanDL_num(le.dl_number);

			self.seq := le.seq;	
			self.ssn := IF(le.ssn='000000000','',le.ssn);	// blank out social if it is all 0's
			self.dob := dob_val;
			self.age := if ((integer)Le.age = 0 and (integer)dob_val != 0,(STRING3)ut.Age((integer)dob_val), (Le.age));
			
			self.phone10 := le.Home_Phone;
			self.wphone10 := le.Work_Phone;
			
			cleaned_name := address.CleanPerson73(le.UnParsedFullName);
			boolean valid_cleaned := le.UnParsedFullName <> '';
			
			self.fname := stringlib.stringtouppercase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
			self.lname := stringlib.stringtouppercase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
			self.mname := stringlib.stringtouppercase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
			self.suffix := stringlib.stringtouppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
			self.title := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[1..5],''));

			street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
			clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

			SELF.in_streetAddress := street_address;
			SELF.in_city := le.p_City_name;
			SELF.in_state := le.St;
			SELF.in_zipCode := le.Z5;
				
			self.prim_range := clean_a2[1..10];
			self.predir := clean_a2[11..12];
			self.prim_name := clean_a2[13..40];
			self.addr_suffix := clean_a2[41..44];
			self.postdir := clean_a2[45..46];
			self.unit_desig := clean_a2[47..56];
			self.sec_range := clean_a2[57..65];
			self.p_city_name := clean_a2[90..114];
			self.st := clean_a2[115..116];
			self.z5 := clean_a2[117..121];
			self.zip4 := clean_a2[122..125];
			self.lat := clean_a2[146..155];
			self.long := clean_a2[156..166];
			// addr_type is position 139
			// carrier route is 126..129
			self.addr_type := risk_indicators.iid_constants.override_addr_type(street_address, clean_a2[139], clean_a2[126..129]);
			self.addr_status := clean_a2[179..182];
			self.county := clean_a2[143..145];
			self.geo_blk := clean_a2[171..177];
			
			self.dl_number := stringlib.stringtouppercase(dl_num_clean);
			self.dl_state := stringlib.stringtouppercase(le.dl_state);
			//self.email_address := stringlib.stringtouppercase(le.email);
			self.email_address := le.email;
			
			self.ip_address := le.ip_addr;
			self.historydate := if(le.historydateyyyymm=0, 999999, le.historydateyyyymm);
			self := [];
		END;
		cleanIn := project(batchinseq, into_in(left));

		risk_indicators.layout_input into_in2(batchinseq le) := TRANSFORM
			self.seq    := le.seq;
			
			// Allow for one person / two addresses if second person name data is blank.
			self.fname  := IF( le.Name_First2 != '' , stringlib.stringtouppercase(le.Name_First2) , stringlib.stringtouppercase(le.Name_First) );
			self.mname  := IF( le.Name_Middle2 != '', stringlib.stringtouppercase(le.Name_Middle2), stringlib.stringtouppercase(le.Name_Middle) );
			self.lname  := IF( le.Name_Last2 != ''  , stringlib.stringtouppercase(le.Name_Last2)  , stringlib.stringtouppercase(le.Name_Last) );
			self.suffix := IF( le.Name_Suffix2 != '', stringlib.stringtouppercase(le.Name_Suffix2), stringlib.stringtouppercase(le.Name_Suffix) );
			
			SELF.in_streetAddress := stringlib.stringtouppercase(le.Street_Addr2);
			SELF.in_city          := stringlib.stringtouppercase(le.p_City_name2);
			SELF.in_state         := stringlib.stringtouppercase(le.St2);
			SELF.in_zipCode       := le.Z52;
			SELF.phone10          := le.Home_Phone2;	
			SELF.historydate      := if(le.historydateyyyymm=0, 999999, le.historydateyyyymm);
			SELF := [];
		END;
		cleanIn2 := PROJECT(batchinseq, into_in2(left));;

		// set variables for passing to bocashell function
		boolean 	require2ele := false;
		boolean   isLn := false;	// not needed anymore
		boolean   doRelatives := true;
		boolean   doDL := false;
		boolean   doVehicle := MAP(
																model_name IN ['fp31105_1','fp1702_2','fp1702_1','fp1508_1'] or doVersion2 => TRUE,
																															 FALSE
															 );
		boolean   doDerogs := true;
		boolean   suppressNearDups := false;
		boolean   fromBIID := false;
		boolean   isFCRA := false;
		boolean   fromIT1O := IF(doParo or model_name IN ['msn1803_1','rsn804_1','msnrsn_1'], true, false);
		integer2  dobradius := if(args.usedobFilter, args.dobradius, -1);
		boolean   doScore := false;
		boolean   nugen := true;		

		boolean   glb_ok 	:= Risk_Indicators.iid_constants.glb_ok(args.glb, isFCRA);
		InvalidFP3GLBRequest := model_name in FP3_models_requiring_GLB and ~glb_ok; 
		if(InvalidFP3GLBRequest, fail('Valid Gramm-Leach-Bliley Act (GLBA) purpose required'));

		iid := risk_indicators.InstantID_Function(cleanIn, gateways, args.dppa, args.glb, isUtility, isLn, args.ofac_only, 
																							suppressNearDups, require2Ele, fromBIID, isFCRA, args.excludewatchlists, fromIT1O, 
																							args.OFACVersion, args.IncludeOfac, args.addtl_watchlists, args.gwThreshold, dobradius, BSversion, 
																							in_runDLverification:=IncludeDLverification,
																							in_DataRestriction:=args.DataRestriction,
																							in_BSOptions := BSOptions,
																							in_DataPermission := args.DataPermission);

		clam := risk_indicators.Boca_Shell_Function(iid, gateways, args.dppa, args.glb, isUtility, isLn, doRelatives, doDL, 
																								doVehicle, doDerogs, bsVersion, doScore, nugen, DataRestriction:=args.DataRestriction,
																								BSOptions := BSOptions, DataPermission:=args.DataPermission);

		// Run Bill-to-Ship-to Shell if necessary.
		clam_BtSt := 
			IF( model_name IN bill_to_ship_to_models,
						Models.FraudAdvisor_BtSt_Function(cleanIn, cleanIn2, gateways, args.dppa, args.glb, isUtility, isLn,
																							args.ofac_only, suppressNearDups, require2Ele, fromBIID, isFCRA, args.excludewatchlists,
																							fromIT1O, args.OFACVersion, args.IncludeOfac, args.addtl_watchlists, args.gwThreshold, dobradius,
																							bsVersion, args.DataRestriction, IncludeDLverification, args.DataPermission,
																							doRelatives, doDL, doVehicle, doDerogs, doScore, nugen, BSOptions)
			);
	
		ip_prep := project( batchinseq( ip_addr!='' ), transform( riskwise.Layout_IPAI, self.ipaddr := left.ip_addr, self.seq := left.seq ) );
		ipdata_gw := risk_indicators.getNetAcuity( ip_prep, gateways, args.dppa, args.glb);
    ipdata := IF(exists(inIPdata), inIPdata_seq, ipdata_gw);
    
    //Added for Paro 9-2018
    skiptrace_Prep := project(ungroup(iid), transform(risk_indicators.Layout_input, self := left));
    skiptrace_call := riskwise.skip_trace(skiptrace_Prep, args.DPPA, args.GLB, args.DataRestriction, '', args.DataPermission);
    								
    easi_census := join(ungroup(iid), Easi.Key_Easi_Census,
                        keyed(left.st+left.county+left.geo_blk=right.geolink) and model_name IN Models.FraudAdvisor_Constants.Paro_models,
                        transform(easi.layout_census, 
                              self.state:= left.st,
                              self.county:=left.county,
                              self.tract:=left.geo_blk[1..6],
                              self.blkgrp:=left.geo_blk[7],
                              self.geo_blk:=left.geo_blk,
                              self := right));
    //End for Paro
		
		combined_layouts := record
			unsigned seq;
			riskwise.layouts.red_flags_online_layout;
			riskwise.layouts.red_flags_batch_layout;
		end;

		red_flags_ret := if(args.RedFlag_version<>0, risk_indicators.Red_Flags_Function(iid), dataset([], combined_layouts));

    model_indicator := map(doParo       => Models.FraudAdvisor_Constants.attrvparo,
                           requestedattributegroups IN ['fraudpointattrv201'] => 'fraudpointattrv201',
                           requestedattributegroups IN ['fraudpointattrv202'] => 'fraudpointattrv202',
                           requestedattributegroups IN ['fraudpointattrv203'] => 'fraudpointattrv203',
                                           model_name);

		attr := if(doVersion1 or doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'] or doParo,
			Models.getFDAttributes(clam, iid, ''/*account_value*/, ipdata, model_indicator),
			project(group(clam), transform(Models.Layout_FraudAttributes, self.input.seq:=left.seq, self := []) )
		);

		checkBoolean(boolean x) := if(x, '1', '0');
		cap2Byte := '99';
		getMin(string l, string r) := IF((unsigned)l < (unsigned)r, l, r);	// get smaller number


		Layout_working := RECORD
			unsigned seq;
			models.Layout_FD_Batch_Out;
			Royalty.RoyaltyNetAcuity.IPData.Royalty_NAG;
		END;

		Layout_working intoAttributes(attr le, red_flags_ret rt) := TRANSFORM
			self.seq := le.input.seq;
			
			// Version 1
			self.index1 := if(doVersion1, '0', '');
			
		// Identity Authentication Attributes
			self.SSNFirstSeen := if(doVersion1, (string)le.version1.SSNFirstSeen, '');
			self.DateLastSeen := if(doVersion1, (string)le.version1.DateLastSeen, '');
			self.isRecentUpdate := if(doVersion1, checkBoolean(le.version1.isRecentUpdate), '');
			self.NumSources := getMin(if(doVersion1, (string)le.version1.NumSources, ''),cap2Byte);
			self.isPhoneFullNameMatch := if(doVersion1, checkBoolean(le.version1.isPhoneFullNameMatch), '');
			self.isPhoneLastNameMatch := if(doVersion1, checkBoolean(le.version1.isPhoneLastNameMatch), '');
			self.inferredAge := if(doVersion1, (string)le.version1.inferredAge, '');
			self.isSSNInvalid := if(doVersion1, checkBoolean(le.version1.isSSNInvalid), '');
			self.isPhoneInvalid := if(doVersion1, checkBoolean(le.version1.isPhoneInvalid), '');
			self.isAddrInvalid := if(doVersion1, checkBoolean(le.version1.isAddrInvalid), '');
			self.isDLInvalid := if(doVersion1, checkBoolean(le.version1.isDLInvalid), '');
			self.isNoVer := if(doVersion1, checkBoolean(le.version1.isNoVer), '');
			
			// SSN Attributes
			self.isDeceased := if(doVersion1, checkBoolean(le.version1.isDeceased), '');
			self.DeceasedDate := if(doVersion1, (string)le.version1.DeceasedDate, '');
			self.isSSNValid := if(doVersion1, checkBoolean(le.version1.isSSNValid), '');
			self.isRecentIssue := if(doVersion1, checkBoolean(le.version1.isRecentIssue), '');
			self.LowIssueDate := if(doVersion1, (string)le.version1.LowIssueDate, '');
			self.HighIssueDate := if(doVersion1, (string)le.version1.HighIssueDate, '');
			self.IssueState := if(doVersion1, le.version1.IssueState, '');
			self.isNonUS := if(doVersion1, checkBoolean(le.version1.isNonUS), '');
			self.isIssued3 := if(doVersion1, checkBoolean(le.version1.isIssued3), '');
			self.isIssuedAge5 := if(doVersion1, checkBoolean(le.version1.isIssuedAge5), '');
			self.ssnCode := if(doVersion1, le.version1.ssnCode, '');
			
			// Evidence of Compromised Identity
			self.isSSNNotFound := if(doVersion1, checkBoolean(le.version1.isSSNNotFound), '');
			self.isFoundOther := if(doVersion1, checkBoolean(le.version1.isFoundOther), '');
			self.isIssuedPrior := if(doVersion1, checkBoolean(le.version1.isIssuedPrior), '');
			self.isPhoneOther := if(doVersion1, checkBoolean(le.version1.isPhoneOther), '');
			self.SSNPerID := getMin(if(doVersion1, (string)le.version1.SSNPerID, ''),cap2Byte);
			self.AddrPerID := getMin(if(doVersion1, (string)le.version1.AddrPerID, ''),cap2Byte);
			self.PhonePerID := getMin(if(doVersion1, (string)le.version1.PhonePerID, ''),cap2Byte);
			self.IDPerSSN := getMin(if(doVersion1, (string)le.version1.IDPerSSN, ''),cap2Byte);
			self.AddrPerSSN := getMin(if(doVersion1, (string)le.version1.AddrPerSSN, ''),cap2Byte);
			self.IDPerAddr := getMin(if(doVersion1, (string)le.version1.IDPerAddr, ''),cap2Byte);
			self.SSNPerAddr := getMin(if(doVersion1, (string)le.version1.SSNPerAddr, ''),cap2Byte);
			self.PhonePerAddr := getMin(if(doVersion1, (string)le.version1.PhonePerAddr, ''),cap2Byte);
			self.IDPerPhone := getMin(if(doVersion1, (string)le.version1.IDPerPhone, ''),cap2Byte);
			self.SSNPerID6 := getMin(if(doVersion1, (string)le.version1.SSNPerID6, ''),cap2Byte);
			self.AddrPerID6 := getMin(if(doVersion1, (string)le.version1.AddrPerID6, ''),cap2Byte);
			self.PhonePerID6 := getMin(if(doVersion1, (string)le.version1.PhonePerID6, ''),cap2Byte);
			self.IDPerSSN6 := getMin(if(doVersion1, (string)le.version1.IDPerSSN6, ''),cap2Byte);
			self.AddrPerSSN6 := getMin(if(doVersion1, (string)le.version1.AddrPerSSN6, ''),cap2Byte);
			self.IDPerAddr6 := getMin(if(doVersion1, (string)le.version1.IDPerAddr6, ''),cap2Byte);
			self.SSNPerAddr6 := getMin(if(doVersion1, (string)le.version1.SSNPerAddr6, ''),cap2Byte);
			self.PhonePerAddr6 := getMin(if(doVersion1, (string)le.version1.PhonePerAddr6, ''),cap2Byte);
			self.IDPerPhone6 := getMin(if(doVersion1, (string)le.version1.IDPerPhone6, ''),cap2Byte);
			
			// Identity Change Information
			self.LastPerSSN := getMin(if(doVersion1, (string)le.version1.LastPerSSN, ''),cap2Byte);
			self.LastPerID := getMin(if(doVersion1, (string)le.version1.LastPerID, ''),cap2Byte);
			self.DateLastNameChange := if(doVersion1, (string)le.version1.DateLastNameChange, '');
			self.NewLastName := if(doVersion1, le.version1.NewLastName, '');
			self.LastNames30 := getMin(if(doVersion1, (string)le.version1.LastNames30, ''),cap2Byte);
			self.LastNames90 := getMin(if(doVersion1, (string)le.version1.LastNames90, ''),cap2Byte);
			self.LastNames180 := getMin(if(doVersion1, (string)le.version1.LastNames180, ''),cap2Byte);
			self.LastNames12 := getMin(if(doVersion1, (string)le.version1.LastNames12, ''),cap2Byte);
			self.LastNames24 := getMin(if(doVersion1, (string)le.version1.LastNames24, ''),cap2Byte);
			self.LastNames36 := getMin(if(doVersion1, (string)le.version1.LastNames36, ''),cap2Byte);
			self.LastNames60 := getMin(if(doVersion1, (string)le.version1.LastNames60, ''),cap2Byte);
			self.IDPerSFDUAddr := getMin(if(doVersion1, (string)le.version1.IDPerSFDUAddr, ''),cap2Byte);
			self.SSNPerSFDUAddr := getMin(if(doVersion1, (string)le.version1.SSNPerSFDUAddr, ''),cap2Byte);

			// Characteristics of Input Address
			self.IAAddress := if(doVersion1, le.version1.IAAddress, '');
			self.IACity := if(doVersion1, le.version1.IACity, '');
			self.IAState := if(doVersion1, le.version1.IAState, '');
			self.IAZip := if(doVersion1, le.version1.IAZip, '');
			self.IAZip4 := if(doVersion1, le.version1.IAZip4, '');
			self.IADateFirstReported := if(doVersion1, (string)le.version1.IADateFirstReported, '');
			self.IADateLastReported := if(doVersion1, (string)le.version1.IADateLastReported, '');
			self.IALenOfRes := if(doVersion1, (string)le.version1.IALenOfRes, '');
			self.IADwellType := if(doVersion1, le.version1.IADwellType, '');
			self.IAisNotPrimaryRes := if(doVersion1, checkBoolean(le.version1.IAisNotPrimaryRes), '');
			self.IAPhoneListed := getMin(if(doVersion1, (string)le.version1.IAPhoneListed, ''),'9');
			self.IAPhoneNumber := if(doVersion1, (string)le.version1.IAPhoneNumber, '');
			self.IAMED_HHINC := if(doVersion1, le.version1.IAMED_HHINC, '');
			self.IAMED_HVAL := if(doVersion1, le.version1.IAMED_HVAL, '');
			self.IAMURDERS := if(doVersion1, le.version1.IAMURDERS, '');
			self.IACARTHEFT := if(doVersion1, le.version1.IACARTHEFT, '');
			self.IABURGLARY := if(doVersion1, le.version1.IABURGLARY, '');
			self.IATOTCRIME := if(doVersion1, le.version1.IATOTCRIME, '');
			
			// Characteristics of Current Address (most recently reported)
			self.CAAddress := if(doVersion1, le.version1.CAAddress, '');
			self.CACity := if(doVersion1, le.version1.CACity, '');
			self.CAState := if(doVersion1, le.version1.CAState, '');
			self.CAZip := if(doVersion1, le.version1.CAZip, '');
			self.CAZip4 := if(doVersion1, le.version1.CAZip4, '');
			self.CADateFirstReported := if(doVersion1, (string)le.version1.CADateFirstReported, '');
			self.CADateLastReported := if(doVersion1, (string)le.version1.CADateLastReported, '');
			self.CALenOfRes := if(doVersion1, (string)le.version1.CALenOfRes, '');
			self.CADwellType := if(doVersion1, le.version1.CADwellType, '');
			self.CAisNotPrimaryRes := if(doVersion1, checkBoolean(le.version1.CAisNotPrimaryRes), '');
			self.CAPhoneListed := getMin(if(doVersion1, (string)le.version1.CAPhoneListed, ''),'9');
			self.CAPhoneNumber := if(doVersion1, (string)le.version1.CAPhoneNumber, '');
			self.CAMED_HHINC := if(doVersion1, le.version1.CAMED_HHINC, '');
			self.CAMED_HVAL := if(doVersion1, le.version1.CAMED_HVAL, '');
			self.CAMURDERS := if(doVersion1, le.version1.CAMURDERS, '');
			self.CACARTHEFT := if(doVersion1, le.version1.CACARTHEFT, '');
			self.CABURGLARY := if(doVersion1, le.version1.CABURGLARY, '');
			self.CATOTCRIME := if(doVersion1, le.version1.CATOTCRIME, '');
			
			// Characteristics of Previous Address (next most recently reported)
			self.PAAddress := if(doVersion1, le.version1.PAAddress, '');
			self.PACity := if(doVersion1, le.version1.PACity, '');
			self.PAState := if(doVersion1, le.version1.PAState, '');
			self.PAZip := if(doVersion1, le.version1.PAZip, '');
			self.PAZip4 := if(doVersion1, le.version1.PAZip4, '');
			self.PADateFirstReported := if(doVersion1, (string)le.version1.PADateFirstReported, '');
			self.PADateLastReported := if(doVersion1, (string)le.version1.PADateLastReported, '');
			self.PALenOfRes := if(doVersion1, (string)le.version1.PALenOfRes, '');
			self.PADwellType := if(doVersion1, le.version1.PADwellType, '');
			self.PAisNotPrimaryRes := if(doVersion1, checkBoolean(le.version1.PAisNotPrimaryRes), '');
			self.PAPhoneListed := getMin(if(doVersion1, (string)le.version1.PAPhoneListed, ''),'9');
			self.PAPhoneNumber := if(doVersion1, (string)le.version1.PAPhoneNumber, '');
			self.PAMED_HHINC := if(doVersion1, le.version1.PAMED_HHINC, '');
			self.PAMED_HVAL := if(doVersion1, le.version1.PAMED_HVAL, '');
			self.PAMURDERS := if(doVersion1, le.version1.PAMURDERS, '');
			self.PACARTHEFT := if(doVersion1, le.version1.PACARTHEFT, '');
			self.PABURGLARY := if(doVersion1, le.version1.PABURGLARY, '');
			self.PATOTCRIME := if(doVersion1, le.version1.PATOTCRIME, '');
			
			// Differences between Input Address and Current Address
			self.isInputCurrMatch := if(doVersion1, checkBoolean(le.version1.isInputCurrMatch), '');
			self.DistInputCurr := getMin(if(doVersion1, (string)le.version1.DistInputCurr, ''),'9999');
			self.isDiffState := if(doVersion1, checkBoolean(le.version1.isDiffState), '');
			self.IncomeDiff := if(doVersion1, (string)le.version1.IncomeDiff, '');
			self.HomeValueDiff := if(doVersion1, (string)le.version1.HomeValueDiff, '');
			self.CrimeDiff := getMin(if(doVersion1, (string)le.version1.CrimeDiff, ''),'9999');
			self.EcoTrajectory := if(doVersion1, le.version1.EcoTrajectory, '');
			
			// Differences between Current Address and Previous Address
			self.isInputPrevMatch := if(doVersion1, checkBoolean(le.version1.isInputPrevMatch), '');
			self.DistCurrPrev := getMin(if(doVersion1, (string)le.version1.DistCurrPrev, ''),'9999');
			self.isDiffState2 := if(doVersion1, checkBoolean(le.version1.isDiffState2), '');
			self.IncomeDiff2 := if(doVersion1, (string)le.version1.IncomeDiff2, '');
			self.HomeValueDiff2 := if(doVersion1, (string)le.version1.HomeValueDiff2, '');
			self.CrimeDiff2 := getMin(if(doVersion1, (string)le.version1.CrimeDiff2, ''),'9999');
			self.EcoTrajectory2 := if(doVersion1, le.version1.EcoTrajectory2, '');
			
			// Transient Person Attributes
			self.mobility_indicator := if(doVersion1, le.version1.mobility_indicator, '');
			self.statusAddr := if(doVersion1, le.version1.statusAddr, '');
			self.statusAddr2 := if(doVersion1, le.version1.statusAddr2, '');
			self.statusAddr3 := if(doVersion1, le.version1.statusAddr3, '');
			self.PADateFirstReported2 := if(doVersion1, (string)le.version1.PADateFirstReported2, '');
			self.NPADateFirstReported := if(doVersion1, (string)le.version1.NPADateFirstReported, '');
			self.addrChanges30 := getMin(if(doVersion1, (string)le.version1.addrChanges30, ''),cap2Byte);
			self.addrChanges90 := getMin(if(doVersion1, (string)le.version1.addrChanges90, ''),cap2Byte);
			self.addrChanges180 := getMin(if(doVersion1, (string)le.version1.addrChanges180, ''),cap2Byte);
			self.addrChanges12 := getMin(if(doVersion1, (string)le.version1.addrChanges12, ''),cap2Byte);
			self.addrChanges24 := getMin(if(doVersion1, (string)le.version1.addrChanges24, ''),cap2Byte);
			self.addrChanges36 := getMin(if(doVersion1, (string)le.version1.addrChanges36, ''),cap2Byte);
			self.addrChanges60 := getMin(if(doVersion1, (string)le.version1.addrChanges60, ''),cap2Byte);

			// Higher Risk Address and Phone Attributes
			self.isAddrHighRisk := if(doVersion1, checkBoolean(le.version1.isAddrHighRisk), '');
			self.isPhoneHighRisk := if(doVersion1, checkBoolean(le.version1.isPhoneHighRisk), '');
			self.hriskcmpy := if(doVersion1, le.version1.hriskcmpy, '');
			self.sic := if(doVersion1, le.version1.sic, '');
			self.isAddrPrison := if(doVersion1, checkBoolean(le.version1.isAddrPrison), '');
			self.isZipPOBox := if(doVersion1, checkBoolean(le.version1.isZipPOBox), '');
			self.isZipCorpMil := if(doVersion1, checkBoolean(le.version1.isZipCorpMil), '');
			self.phoneStatus := if(doVersion1, le.version1.phoneStatus, '');
			self.isPhonePager := if(doVersion1, checkBoolean(le.version1.isPhonePager), '');
			self.isPhoneMobile := if(doVersion1, checkBoolean(le.version1.isPhoneMobile), '');
			self.isPhoneZipMismatch := if(doVersion1, checkBoolean(le.version1.isPhoneZipMismatch), '');
			self.phoneAddrDist := getMin(if(doVersion1, (string)le.version1.phoneAddrDist, ''),'9999');
			self.hphonetypeflag := if(doVersion1, le.version1.hphonetypeflag, '');
			self.hphonesrvcflag := if(doVersion1, le.version1.hphonesrvcflag, '');
			self.areacodesplit := if(doVersion1, le.version1.areacodesplit, '');
			self.altareacode := if(doVersion1, le.version1.altareacode, '');
			self.addrval := if(doVersion1, le.version1.addrval, '');
			self.invalidaddr := if(doVersion1, le.version1.invalidaddr, '');
			
			// Higher Risk Internet Connection Attributes
			self.IPinvalid := if(doVersion1, checkBoolean(le.version1.IPinvalid), '');
			self.IPNonUS := if(doVersion1, checkBoolean(le.version1.IPNonUS), '');
			self.IPState := if(doVersion1, le.version1.IPState, '');
			self.IPCountry := if(doVersion1, le.version1.IPCountry, '');
			self.IPContinent := if(doVersion1, le.version1.IPContinent, '');
			
			// version2
			self.index4 := if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], '0', '');	
			self.v2_IdentityRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IdentityRiskLevel, '');
			self.v2_IdentityAgeOldest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IdentityAgeOldest, '');
			self.v2_IdentityAgeNewest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IdentityAgeNewest, '');
			self.v2_IdentityRecentUpdate	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IdentityRecentUpdate, '');
			self.v2_IdentityRecordCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IdentityRecordCount, '');
			self.v2_IdentitySourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IdentitySourceCount, '');
			self.v2_IdentityAgeRiskIndicator	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IdentityAgeRiskIndicator, '');
			self.v2_IDVerRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerRiskLevel, '');
			self.v2_IDVerSSN	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerSSN, '');
			self.v2_IDVerName	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerName, '');
			self.v2_IDVerAddress	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerAddress, '');
			self.v2_IDVerAddressNotCurrent	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerAddressNotCurrent, '');
			self.v2_IDVerAddressAssocCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerAddressAssocCount, '');
			self.v2_IDVerPhone	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerPhone, '');
			self.v2_IDVerDriversLicense	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerDriversLicense, '');
			self.v2_IDVerDOB	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerDOB, '');
			self.v2_IDVerSSNSourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerSSNSourceCount, '');
			self.v2_IDVerAddressSourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerAddressSourceCount, '');
			self.v2_IDVerDOBSourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerDOBSourceCount, '');
			self.v2_IDVerSSNCreditBureauCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerSSNCreditBureauCount, '');
			self.v2_IDVerSSNCreditBureauDelete	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerSSNCreditBureauDelete, '');
			self.v2_IDVerAddrCreditBureauCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IDVerAddrCreditBureauCount, '');
			self.v2_SourceRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceRiskLevel, '');
			self.v2_SourceFirstReportingIdentity	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceFirstReportingIdentity, '');
			self.v2_SourceCreditBureau	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceCreditBureau, '');
			self.v2_SourceCreditBureauCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceCreditBureauCount, '');
			self.v2_SourceCreditBureauAgeOldest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceCreditBureauAgeOldest, '');
			self.v2_SourceCreditBureauAgeNewest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceCreditBureauAgeNewest, '');
			self.v2_SourceCreditBureauAgeChange	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceCreditBureauAgeChange, '');
			self.v2_SourcePublicRecord	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourcePublicRecord, '');
			self.v2_SourcePublicRecordCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourcePublicRecordCount, '');
			self.v2_SourcePublicRecordCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourcePublicRecordCountYear, '');
			self.v2_SourceEducation	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceEducation, '');
			self.v2_SourceOccupationalLicense	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceOccupationalLicense, '');
			self.v2_SourceVoterRegistration	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceVoterRegistration, '');
			self.v2_SourceOnlineDirectory	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceOnlineDirectory, '');
			self.v2_SourceDoNotMail	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceDoNotMail, '');
			self.v2_SourceAccidents	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceAccidents, '');
			self.v2_SourceBusinessRecords	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceBusinessRecords, '');
			self.v2_SourceProperty	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceProperty, '');
			self.v2_SourceAssets	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourceAssets, '');
			self.v2_SourcePhoneDirectoryAssistance	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourcePhoneDirectoryAssistance, '');
			self.v2_SourcePhoneNonPublicDirectory	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SourcePhoneNonPublicDirectory, '');
			self.v2_VariationRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationRiskLevel, '');
			self.v2_VariationIdentityCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationIdentityCount, '');
			self.v2_VariationSSNCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationSSNCount, '');
			self.v2_VariationSSNCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationSSNCountNew, '');
			self.v2_VariationMSourcesSSNCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationMSourcesSSNCount, '');
			self.v2_VariationMSourcesSSNUnrelCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationMSourcesSSNUnrelCount, '');
			self.v2_VariationLastNameCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationLastNameCount, '');
			self.v2_VariationLastNameCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationLastNameCountNew, '');
			self.v2_VariationAddrCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationAddrCountYear, '');
			self.v2_VariationAddrCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationAddrCountNew, '');
			self.v2_VariationAddrStability	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationAddrStability, '');
			self.v2_VariationAddrChangeAge	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationAddrChangeAge, '');
			self.v2_VariationDOBCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationDOBCount, '');
			self.v2_VariationDOBCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationDOBCountNew, '');
			self.v2_VariationPhoneCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationPhoneCount, '');
			self.v2_VariationPhoneCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationPhoneCountNew, '');
			self.v2_VariationSearchSSNCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationSearchSSNCount, '');
			self.v2_VariationSearchAddrCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationSearchAddrCount, '');
			self.v2_VariationSearchPhoneCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.VariationSearchPhoneCount, '');
			self.v2_SearchVelocityRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchVelocityRiskLevel, '');
			self.v2_SearchCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchCount, '');
			self.v2_SearchCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchCountYear, '');
			self.v2_SearchCountMonth	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchCountMonth, '');
			self.v2_SearchCountWeek	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchCountWeek, '');
			self.v2_SearchCountDay	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchCountDay, '');
			self.v2_SearchUnverifiedSSNCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchUnverifiedSSNCountYear, '');
			self.v2_SearchUnverifiedAddrCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchUnverifiedAddrCountYear, '');
			self.v2_SearchUnverifiedDOBCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchUnverifiedDOBCountYear, '');
			self.v2_SearchUnverifiedPhoneCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchUnverifiedPhoneCountYear, '');
			self.v2_SearchBankingSearchCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchBankingSearchCount, '');
			self.v2_SearchBankingSearchCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchBankingSearchCountYear, '');
			self.v2_SearchBankingSearchCountMonth	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchBankingSearchCountMonth, '');
			self.v2_SearchBankingSearchCountWeek	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchBankingSearchCountWeek, '');
			self.v2_SearchBankingSearchCountDay	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchBankingSearchCountDay, '');
			self.v2_SearchHighRiskSearchCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchHighRiskSearchCount, '');
			self.v2_SearchHighRiskSearchCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchHighRiskSearchCountYear, '');
			self.v2_SearchHighRiskSearchCountMonth	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchHighRiskSearchCountMonth, '');
			self.v2_SearchHighRiskSearchCountWeek	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchHighRiskSearchCountWeek, '');
			self.v2_SearchHighRiskSearchCountDay	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchHighRiskSearchCountDay, '');
			self.v2_SearchFraudSearchCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchFraudSearchCount, '');
			self.v2_SearchFraudSearchCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchFraudSearchCountYear, '');
			self.v2_SearchFraudSearchCountMonth	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchFraudSearchCountMonth, '');
			self.v2_SearchFraudSearchCountWeek	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchFraudSearchCountWeek, '');
			self.v2_SearchFraudSearchCountDay	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchFraudSearchCountDay, '');
			self.v2_SearchLocateSearchCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchLocateSearchCount, '');
			self.v2_SearchLocateSearchCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchLocateSearchCountYear, '');
			self.v2_SearchLocateSearchCountMonth	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchLocateSearchCountMonth, '');
			self.v2_SearchLocateSearchCountWeek	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchLocateSearchCountWeek, '');
			self.v2_SearchLocateSearchCountDay	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchLocateSearchCountDay, '');
			self.v2_AssocRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AssocRiskLevel, '');
			self.v2_AssocCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AssocCount, '');
			self.v2_AssocDistanceClosest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AssocDistanceClosest, '');
			self.v2_AssocSuspicousIdentitiesCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AssocSuspicousIdentitiesCount, '');
			self.v2_AssocCreditBureauOnlyCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AssocCreditBureauOnlyCount, '');
			self.v2_AssocCreditBureauOnlyCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AssocCreditBureauOnlyCountNew, '');
			self.v2_AssocCreditBureauOnlyCountMonth	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AssocCreditBureauOnlyCountMonth, '');
			self.v2_AssocHighRiskTopologyCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AssocHighRiskTopologyCount, '');
			self.v2_ValidationRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.ValidationRiskLevel, '');
			self.v2_ValidationSSNProblems	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.ValidationSSNProblems, '');
			self.v2_ValidationAddrProblems	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.ValidationAddrProblems, '');
			self.v2_ValidationPhoneProblems	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.ValidationPhoneProblems, '');
			self.v2_ValidationDLProblems	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.ValidationDLProblems, '');
			self.v2_ValidationIPProblems	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.ValidationIPProblems, '');
			self.v2_CorrelationRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CorrelationRiskLevel, '');
			self.v2_CorrelationSSNNameCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CorrelationSSNNameCount, '');
			self.v2_CorrelationSSNAddrCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CorrelationSSNAddrCount, '');
			self.v2_CorrelationAddrNameCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CorrelationAddrNameCount, '');
			self.v2_CorrelationAddrPhoneCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CorrelationAddrPhoneCount, '');
			self.v2_CorrelationPhoneLastNameCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CorrelationPhoneLastNameCount, '');
			self.v2_DivRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivRiskLevel, '');
			self.v2_DivSSNIdentityCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSSNIdentityCount, '');
			self.v2_DivSSNIdentityCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSSNIdentityCountNew, '');
			self.v2_DivSSNIdentityMSourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSSNIdentityMSourceCount, '');
			self.v2_DivSSNIdentityMSourceUrelCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSSNIdentityMSourceUrelCount, '');
			self.v2_DivSSNLNameCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSSNLNameCount, '');
			self.v2_DivSSNLNameCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSSNLNameCountNew, '');
			self.v2_DivSSNAddrCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSSNAddrCount, '');
			self.v2_DivSSNAddrCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSSNAddrCountNew, '');
			self.v2_DivSSNAddrMSourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSSNAddrMSourceCount, '');
			self.v2_DivAddrIdentityCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrIdentityCount, '');
			self.v2_DivAddrIdentityCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrIdentityCountNew, '');
			self.v2_DivAddrIdentityMSourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrIdentityMSourceCount, '');
			self.v2_DivAddrSuspIdentityCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrSuspIdentityCountNew, '');
			self.v2_DivAddrSSNCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrSSNCount, '');
			self.v2_DivAddrSSNCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrSSNCountNew, '');
			self.v2_DivAddrSSNMSourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrSSNMSourceCount, '');
			self.v2_DivAddrPhoneCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrPhoneCount, '');
			self.v2_DivAddrPhoneCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrPhoneCountNew, '');
			self.v2_DivAddrPhoneMSourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivAddrPhoneMSourceCount, '');
			self.v2_DivPhoneIdentityCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivPhoneIdentityCount, '');
			self.v2_DivPhoneIdentityCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivPhoneIdentityCountNew, '');
			self.v2_DivPhoneIdentityMSourceCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivPhoneIdentityMSourceCount, '');
			self.v2_DivPhoneAddrCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivPhoneAddrCount, '');
			self.v2_DivPhoneAddrCountNew	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivPhoneAddrCountNew, '');
			self.v2_DivSearchSSNIdentityCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSearchSSNIdentityCount, '');
			self.v2_DivSearchAddrIdentityCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSearchAddrIdentityCount, '');
			self.v2_DivSearchAddrSuspIdentityCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSearchAddrSuspIdentityCount, '');
			self.v2_DivSearchPhoneIdentityCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.DivSearchPhoneIdentityCount, '');
			self.v2_SearchComponentRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchComponentRiskLevel, '');
			self.v2_SearchSSNSearchCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchSSNSearchCount, '');
			self.v2_SearchSSNSearchCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchSSNSearchCountYear, '');
			self.v2_SearchSSNSearchCountMonth	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchSSNSearchCountMonth, '');
			self.v2_SearchSSNSearchCountWeek	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchSSNSearchCountWeek, '');
			self.v2_SearchSSNSearchCountDay	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchSSNSearchCountDay, '');
			self.v2_SearchAddrSearchCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchAddrSearchCount, '');
			self.v2_SearchAddrSearchCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchAddrSearchCountYear, '');
			self.v2_SearchAddrSearchCountMonth	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchAddrSearchCountMonth, '');
			self.v2_SearchAddrSearchCountWeek	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchAddrSearchCountWeek, '');
			self.v2_SearchAddrSearchCountDay	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchAddrSearchCountDay, '');
			self.v2_SearchPhoneSearchCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchPhoneSearchCount, '');
			self.v2_SearchPhoneSearchCountYear	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchPhoneSearchCountYear, '');
			self.v2_SearchPhoneSearchCountMonth	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchPhoneSearchCountMonth, '');
			self.v2_SearchPhoneSearchCountWeek	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchPhoneSearchCountWeek, '');
			self.v2_SearchPhoneSearchCountDay	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SearchPhoneSearchCountDay, '');
			self.v2_ComponentCharRiskLevel	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.ComponentCharRiskLevel, '');
			self.v2_SSNHighIssueAge	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SSNHighIssueAge, '');
			self.v2_SSNLowIssueAge	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SSNLowIssueAge, '');
			self.v2_SSNIssueState	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SSNIssueState, '');
			self.v2_SSNNonUS	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.SSNNonUS, '');
			self.v2_InputPhoneType	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputPhoneType, '');
			self.v2_IPState	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IPState, '');
			self.v2_IPCountry	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IPCountry, '');
			self.v2_IPContinent	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.IPContinent, '');
			self.v2_InputAddrAgeOldest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrAgeOldest, '');
			self.v2_InputAddrAgeNewest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrAgeNewest, '');
			self.v2_InputAddrType	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrType, '');
			self.v2_InputAddrLenOfRes	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrLenOfRes, '');
			self.v2_InputAddrDwellType	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrDwellType, '');
			self.v2_InputAddrDelivery	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrDelivery, '');
			self.v2_InputAddrActivePhoneList	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrActivePhoneList, '');
			self.v2_InputAddrOccupantOwned	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrOccupantOwned, '');
			self.v2_InputAddrBusinessCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrBusinessCount, '');
			self.v2_InputAddrNBRHDBusinessCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDBusinessCount, '');
			self.v2_InputAddrNBRHDSingleFamilyCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDSingleFamilyCount, '');
			self.v2_InputAddrNBRHDMultiFamilyCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDMultiFamilyCount, '');
			self.v2_InputAddrNBRHDMedianIncome	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDMedianIncome, '');
			self.v2_InputAddrNBRHDMedianValue	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDMedianValue, '');
			self.v2_InputAddrNBRHDMurderIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDMurderIndex, '');
			self.v2_InputAddrNBRHDCarTheftIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDCarTheftIndex, '');
			self.v2_InputAddrNBRHDBurglaryIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDBurglaryIndex, '');
			self.v2_InputAddrNBRHDCrimeIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDCrimeIndex, '');
			self.v2_InputAddrNBRHDMobilityIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDMobilityIndex, '');
			self.v2_InputAddrNBRHDVacantPropCount	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.InputAddrNBRHDVacantPropCount, '');
			self.v2_AddrChangeDistance	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AddrChangeDistance, '');
			self.v2_AddrChangeStateDiff	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AddrChangeStateDiff, '');
			self.v2_AddrChangeIncomeDiff	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AddrChangeIncomeDiff, '');
			self.v2_AddrChangeValueDiff	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AddrChangeValueDiff, '');
			self.v2_AddrChangeCrimeDiff	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AddrChangeCrimeDiff, '');
			self.v2_AddrChangeEconTrajectory	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AddrChangeEconTrajectory, '');
			self.v2_AddrChangeEconTrajectoryIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.AddrChangeEconTrajectoryIndex, '');
			self.v2_CurrAddrAgeOldest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrAgeOldest, '');
			self.v2_CurrAddrAgeNewest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrAgeNewest, '');
			self.v2_CurrAddrLenOfRes	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrLenOfRes, '');
			self.v2_CurrAddrDwellType	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrDwellType, '');
			self.v2_CurrAddrStatus	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrStatus, '');
			self.v2_CurrAddrActivePhoneList	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrActivePhoneList, '');
			self.v2_CurrAddrMedianIncome	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrMedianIncome, '');
			self.v2_CurrAddrMedianValue	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrMedianValue, '');
			self.v2_CurrAddrMurderIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrMurderIndex, '');
			self.v2_CurrAddrCarTheftIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrCarTheftIndex, '');
			self.v2_CurrAddrBurglaryIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrBurglaryIndex, '');
			self.v2_CurrAddrCrimeIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.CurrAddrCrimeIndex, '');
			self.v2_PrevAddrAgeOldest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrAgeOldest, '');
			self.v2_PrevAddrAgeNewest	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrAgeNewest, '');
			self.v2_PrevAddrLenOfRes	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrLenOfRes, '');
			self.v2_PrevAddrDwellType	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrDwellType, '');
			self.v2_PrevAddrStatus	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrStatus, '');
			self.v2_PrevAddrOccupantOwned	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrOccupantOwned, '');
			self.v2_PrevAddrMedianIncome	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrMedianIncome, '');
			self.v2_PrevAddrMedianValue	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrMedianValue, '');
			self.v2_PrevAddrMurderIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrMurderIndex, '');
			self.v2_PrevAddrCarTheftIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrCarTheftIndex, '');
			self.v2_PrevAddrBurglaryIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrBurglaryIndex, '');
			self.v2_PrevAddrCrimeIndex	:= if(doVersion2 or requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version2.PrevAddrCrimeIndex, '');
      // version201
			self.v201_IDVerAddressMatchesCurrent	:= if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version201.IDVerAddressMatchesCurrent, '');
      self.v201_IDVerAddressVoter	:= if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version201.IDVerAddressVoter, '');
      self.v201_IDVerAddressVehicleRegistation	:= if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version201.IDVerAddressVehicleRegistation, '');
      self.v201_IDVerAddressDriversLicense	:= if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version201.IDVerAddressDriversLicense, '');
      self.v201_IDVerDriversLicenseType	:= if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version201.IDVerDriversLicenseType, '');
      self.v201_IDVerSSNDriversLicense	:= if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version201.IDVerSSNDriversLicense, '');
      self.v201_SourceVehicleRegistration	:= if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version201.SourceVehicleRegistration, '');
      self.v201_SourceDriversLicense	:= if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version201.SourceDriversLicense, '');
      self.v201_IdentityDriversLicenseComp	:= if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version201.IdentityDriversLicenseComp, '');
      // version202
      self.v202_IDVerFNameBest := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.IDVerFNameBest, '');
      self.v202_IDVerLNameBest := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.IDVerLNameBest, '');
      self.v202_IDVerSSNBest := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.IDVerSSNBest, '');
      self.v202_VariationSearchSSNCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchSSNCtDay, '');
      self.v202_VariationSearchSSNCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchSSNCtWeek, '');
      self.v202_VariationSearchSSNCtMonth := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchSSNCtMonth, '');
      self.v202_VariationSearchSSNCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchSSNCt3Month, '');
      self.v202_VariationSearchSSNCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchSSNCtNew, '');
      self.v202_VariationSearchAddrCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchAddrCtDay, '');
      self.v202_VariationSearchAddrCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchAddrCtWeek, '');
      self.v202_VariationSearchAddrCtMonth := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchAddrCtMonth, '');
      self.v202_VariationSearchAddrCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchAddrCt3Month, '');
      self.v202_VariationSearchAddrCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchAddrCtNew, '');
      self.v202_VariationSearchPhoneCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchPhoneCtDay, '');
      self.v202_VariationSearchPhoneCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchPhoneCtWeek, '');
      self.v202_VariationSearchPhoneCtMonth := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchPhoneCtMonth, '');
      self.v202_VariationSearchPhoneCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchPhoneCt3Month, '');
      self.v202_VariationSearchLNameCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchLNameCtDay, '');
      self.v202_VariationSearchLNameCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchLNameCtWeek, '');
      self.v202_VariationSearchLNameCtMonth := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchLNameCtMonth, '');
      self.v202_VariationSearchLNameCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchLNameCt3Month, '');
      self.v202_VariationSearchFNameCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchFNameCtDay, '');
      self.v202_VariationSearchFNameCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchFNameCtWeek, '');
      self.v202_VariationSearchFNameCtMonth := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchFNameCtMonth, '');
      self.v202_VariationSearchFNameCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchFNameCt3Month, '');
      self.v202_VariationSearchFNameCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchFNameCtNew, '');
      self.v202_VariationSearchDOBCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDOBCtDay, '');
      self.v202_VariationSearchDOBCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDOBCtWeek, '');
      self.v202_VariationSearchDOBCtMonth := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDOBCtMonth, '');
      self.v202_VariationSearchDOBCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDOBCt3Month, '');
      self.v202_VariationSearchDOBCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDOBCtNew, '');
      self.v202_VariationSearchEmailCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchEmailCt, '');
      self.v202_VariationSearchEmailCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchEmailCtDay, '');
      self.v202_VariationSearchEmailCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchEmailCtWeek, '');
      self.v202_VariationSearchEmailCtMonth := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchEmailCtMonth, '');
      self.v202_VariationSearchEmailCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchEmailCt3Month, '');
      self.v202_VariationSearchEmailCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchEmailCtNew, '');
      self.v202_VariationSearchSSN1SubCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchSSN1SubCt, '');
      self.v202_VariationSearchPhone1SubCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchPhone1SubCt, '');
      self.v202_VariationSearchAddr1SubCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchAddr1SubCt, '');
      self.v202_VariationSearchDOB1SubCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDOB1SubCt, '');
      self.v202_VariationSearchFName1SubCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchFName1SubCt, '');
      self.v202_VariationSearchLName1SubCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchLName1SubCt, '');
      self.v202_VariationSearchDOB1SubDayCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDOB1SubDayCt, '');
      self.v202_VariationSearchDOB1SubMoCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDOB1SubMoCt, '');
      self.v202_VariationSearchDOB1SubYrCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDOB1SubYrCt, '');
      self.v202_VariationSearchSSNSeqCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchSSNSeqCt, '');
      self.v202_VariationSearchPhoneSeqCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchPhoneSeqCt, '');
      self.v202_VariationSearchAddrSeqCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchAddrSeqCt, '');
      self.v202_VariationSearchDobSeqCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.VariationSearchDobSeqCt, '');
      self.v202_SearchSSNBestSearchCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchSSNBestSearchCt, '');
      self.v202_DivSearchSSNBestIdentityCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNBestIdentityCt, '');
      self.v202_DivSearchSSNBestLNameCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNBestLNameCt, '');
      self.v202_DivSearchSSNBestAddrCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNBestAddrCt, '');
      self.v202_DivSearchSSNBestDOBCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNBestDOBCt, '');
      self.v202_CorrNameDOBCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrNameDOBCt, '');
      self.v202_CorrAddrDOBCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrAddrDOBCt, '');
      self.v202_CorrSSNDOBCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSSNDOBCt, '');
      self.v202_CorrSearchSSNNameCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchSSNNameCt, '');
      self.v202_CorrSearchVerSSNNameCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerSSNNameCt, '');
      self.v202_CorrSearchNamePhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchNamePhoneCt, '');
      self.v202_CorrSearchVerNamePhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerNamePhoneCt, '');
      self.v202_CorrSearchSSNAddrCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchSSNAddrCt, '');
      self.v202_CorrSearchVerSSNAddrCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerSSNAddrCt, '');
      self.v202_CorrSearchAddrDOBCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchAddrDOBCt, '');
      self.v202_CorrSearchVerAddrDOBCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerAddrDOBCt, '');
      self.v202_CorrSearchAddrPhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchAddrPhoneCt, '');
      self.v202_CorrSearchVerAddrPhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerAddrPhoneCt, '');
      self.v202_CorrSearchSSNDOBCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchSSNDOBCt, '');
      self.v202_CorrSearchVerSSNDOBCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerSSNDOBCt, '');
      self.v202_CorrSearchSSNPhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchSSNPhoneCt, '');
      self.v202_CorrSearchVerSSNPhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerSSNPhoneCt, '');
      self.v202_CorrSearchDOBPhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchDOBPhoneCt, '');
      self.v202_CorrSearchVerDOBPhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerDOBPhoneCt, '');
      self.v202_CorrSearchSSNAddrNameCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchSSNAddrNameCt, '');
      self.v202_CorrSearchVerSSNAddrNameCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerSSNAddrNameCt, '');
      self.v202_CorrSearchSSNNamePhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchSSNNamePhoneCt, '');
      self.v202_CorrSearchVerSSNNamePhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerSSNNamePhoneCt, '');
      self.v202_CorrSearchSSNAddrNamePhoneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchSSNAddrNamePhoneCt, '');
      self.v202_CorrSearchVerSSNAddrNamePhneCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.CorrSearchVerSSNAddrNamePhneCt, '');
      self.v202_DivSearchAddrSSNCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrSSNCtDay, '');
      self.v202_DivSearchAddrSSNCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrSSNCtWeek, '');
      self.v202_DivSearchAddrSSNCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrSSNCt1Month, '');
      self.v202_DivSearchAddrSSNCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrSSNCt3Month, '');
      self.v202_DivSearchAddrSSNCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrSSNCtNew, '');
      self.v202_DivSearchSSNIdentityCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNIdentityCtDay, '');
      self.v202_DivSearchSSNIdentityCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNIdentityCtWeek, '');
      self.v202_DivSearchSSNIdentityCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNIdentityCt1Month, '');
      self.v202_DivSearchSSNIdentityCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNIdentityCt3Month, '');
      self.v202_DivSearchSSNIdentityCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNIdentityCtNew, '');
      self.v202_DivSearchAddrIdentityCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrIdentityCtDay, '');
      self.v202_DivSearchAddrIdentityCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrIdentityCtWeek, '');
      self.v202_DivSearchAddrIdentityCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrIdentityCt1Month, '');
      self.v202_DivSearchAddrIdentityCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrIdentityCt3Month, '');
      self.v202_DivSearchAddrIdentityCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrIdentityCtNew, '');
      self.v202_DivSearchPhoneIdentityCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchPhoneIdentityCt, '');
      self.v202_DivSearchPhoneIdentityCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchPhoneIdentityCtDay, '');
      self.v202_DivSearchPhoneIdentityCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchPhoneIdentityCtWeek, '');
      self.v202_DivSearchPhoneIdentityCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchPhoneIdentityCt1Month, '');
      self.v202_DivSearchPhoneIdentityCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchPhoneIdentityCt3Month, '');
      self.v202_DivSearchPhoneIdentityCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchPhoneIdentityCtNew, '');
      self.v202_DivSearchSSNLNameCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNLNameCtDay, '');
      self.v202_DivSearchSSNLNameCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNLNameCtWeek, '');
      self.v202_DivSearchSSNLNameCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNLNameCt1Month, '');
      self.v202_DivSearchSSNLNameCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNLNameCt3Month, '');
      self.v202_DivSearchSSNLNameCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNLNameCtNew, '');
      self.v202_DivSearchSSNAddrCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNAddrCtDay, '');
      self.v202_DivSearchSSNAddrCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNAddrCtWeek, '');
      self.v202_DivSearchSSNAddrCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNAddrCt1Month, '');
      self.v202_DivSearchSSNAddrCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNAddrCt3Month, '');
      self.v202_DivSearchSSNAddrCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNAddrCtNew, '');
      self.v202_DivSearchSSNDOBCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNDOBCtDay, '');
      self.v202_DivSearchSSNDOBCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNDOBCtWeek, '');
      self.v202_DivSearchSSNDOBCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNDOBCt1Month, '');
      self.v202_DivSearchSSNDOBCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNDOBCt3Month, '');
      self.v202_DivSearchSSNDOBCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchSSNDOBCtNew, '');
      self.v202_DivSearchAddrLNameCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrLNameCtDay, '');
      self.v202_DivSearchAddrLNameCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrLNameCtWeek, '');
      self.v202_DivSearchAddrLNameCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrLNameCt1Month, '');
      self.v202_DivSearchAddrLNameCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrLNameCt3Month, '');
      self.v202_DivSearchAddrLNameCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchAddrLNameCtNew, '');
      self.v202_DivSearchEmailIdentityCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchEmailIdentityCt, '');
      self.v202_DivSearchEmailIdentityCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchEmailIdentityCtDay, '');
      self.v202_DivSearchEmailIdentityCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchEmailIdentityCtWeek, '');
      self.v202_DivSearchEmailIdentityCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchEmailIdentityCt1Month, '');
      self.v202_DivSearchEmailIdentityCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchEmailIdentityCt3Month, '');
      self.v202_DivSearchEmailIdentityCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.DivSearchEmailIdentityCtNew, '');
      self.v202_SearchPhoneSearchCtDay := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchPhoneSearchCtDay, '');
      self.v202_SearchPhnSearchCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchPhnSearchCtWeek, '');
      self.v202_SearchPhnSearchCt1Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchPhnSearchCt1Month, '');
      self.v202_SearchPhnSearchCt3Month := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchPhnSearchCt3Month, '');
      self.v202_SearchPhnSearchCtNew := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchPhnSearchCtNew, '');
      self.v202_SourceTypeIndicator := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceTypeIndicator, '');
      self.v202_SourceTypeEmergence := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceTypeEmergence, '');
      self.v202_SourceTypeCredentialCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceTypeCredentialCt, '');
      self.v202_SourceTypeCredentialAgeOldest := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceTypeCredentialAgeOldest, '');
      self.v202_SourceTypeOtherCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceTypeOtherCt, '');
      self.v202_SourceTypeOtherAgeOldest := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceTypeOtherAgeOldest, '');
      self.v202_SourceCreditBureauCBOCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceCreditBureauCBOCt, '');
      self.v202_SourceCreditBureauVerSSN := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceCreditBureauVerSSN, '');
      self.v202_SourceCreditBureauVerAddr := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceCreditBureauVerAddr, '');
      self.v202_SourceCreditBureauVerDOB := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceCreditBureauVerDOB, '');
      self.v202_IDVerAddressMatchesCurrentV2 := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.IDVerAddressMatchesCurrentV2, '');
      self.v202_SearchSSNUnVerAddrCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchSSNUnVerAddrCt, '');
      self.v202_SearchSSNIdentitySearchCtDiff := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchSSNIdentitySearchCtDiff, '');
      self.v202_SearchNonBankSearchCtWeek := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchNonBankSearchCtWeek, '');
      self.v202_SearchNonBankSearchCtYear := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchNonBankSearchCtYear, '');
      self.v202_SearchNonBankSearchCtRecency := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SearchNonBankSearchCtRecency, '');
      self.v202_AssocCBOIdentityCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.AssocCBOIdentityCt, '');
      self.v202_AssocCBOHHMemberCt := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.AssocCBOHHMemberCt, '');
      self.v202_SourceCreditBureauFSAge := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceCreditBureauFSAge, '');
      self.v202_SourceCreditBureauFSAge25to59 := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceCreditBureauFSAge25to59, '');
      self.v202_SourceCreditBureauCBOFSAge := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceCreditBureauCBOFSAge, '');
      self.v202_SourceCreditBureauNotSSNVer := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.SourceCreditBureauNotSSNVer, '');
      self.v202_IdentitySyntheticRiskLevel := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.IdentitySyntheticRiskLevel, '');
      self.v202_IdentitySynthetic := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.IdentitySynthetic, '');
      self.v202_IdentityManipSSNRiskLevel := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.IdentityManipSSNRiskLevel, '');
      self.v202_IdentitySSNManip := if(requestedattributegroups IN ['fraudpointattrv202','fraudpointattrv203'], le.version202.IdentitySSNManip, '');
      // version203
      self.v203_IDVerSSNVerAgeOldest := if(requestedattributegroups IN ['fraudpointattrv203'], le.version203.IDVerSSNVerAgeOldest, '');
      self.v203_IDVerSSNNotVerAgeOldest := if(requestedattributegroups IN ['fraudpointattrv203'], le.version203.IDVerSSNNotVerAgeOldest, '');
      // self.clam := if(requestedattributegroups IN ['fraudpointattrv201','fraudpointattrv202','fraudpointattrv203'], le.version203.clam, le.version203.clam);
      // paro
      self.paro_bansmatchflag     := IF(doParo, le.ParoAttributes.paro_bansmatchflag, '');
      self.paro_banscasenum       := IF(doParo, le.ParoAttributes.paro_banscasenum, '');
      self.paro_bansprcode        := IF(doParo, le.ParoAttributes.paro_bansprcode, '');
      self.paro_bansdispcode      := IF(doParo, le.ParoAttributes.paro_bansdispcode, '');
      self.paro_bansdatefiled     := IF(doParo, le.ParoAttributes.paro_bansdatefiled, '');
      self.paro_bansfirst         := IF(doParo, le.ParoAttributes.paro_bansfirst, '');
      self.paro_bansmiddle        := IF(doParo, le.ParoAttributes.paro_bansmiddle, '');
      self.paro_banslast          := IF(doParo, le.ParoAttributes.paro_banslast, '');
      self.paro_banscnty          := IF(doParo, le.ParoAttributes.paro_banscnty, '');
      self.paro_bansecoaflag      := IF(doParo, le.ParoAttributes.paro_bansecoaflag, '');
      self.paro_decsflag          := IF(doParo, le.ParoAttributes.paro_decsflag, '');
      self.paro_decsdob           := IF(doParo, le.ParoAttributes.paro_decsdob, '');
      self.paro_decszip           := IF(doParo, le.ParoAttributes.paro_decszip, '');
      self.paro_decszip2          := IF(doParo, le.ParoAttributes.paro_decszip2, '');
      self.paro_decslast          := IF(doParo, le.ParoAttributes.paro_decslast, '');
      self.paro_decsfirst         := IF(doParo, le.ParoAttributes.paro_decsfirst, '');
      self.paro_decsdod           := IF(doParo, le.ParoAttributes.paro_decsdod, '');
      self.paro_inputaddrcharflag := IF(doParo, le.ParoAttributes.paro_inputaddrcharflag, '');
      self.paro_inputsocscharflag := IF(doParo, le.ParoAttributes.paro_inputsocscharflag, '');
      self.paro_correctsocs       := IF(doParo, le.ParoAttributes.paro_correctsocs, '');
      self.paro_phonestatusflag   := IF(doParo, le.ParoAttributes.paro_phonestatusflag, '');
      self.paro_phone             := IF(doParo, le.ParoAttributes.paro_phone, '');
      self.paro_altareacode       := IF(doParo, le.ParoAttributes.paro_altareacode, '');
      self.paro_splitdate         := IF(doParo, le.ParoAttributes.paro_splitdate, '');
      self.paro_addrstatusflag    := IF(doParo, le.ParoAttributes.paro_addrstatusflag, '');
      self.paro_addrcharflag      := IF(doParo, le.ParoAttributes.paro_addrcharflag, '');
      self.paro_first             := IF(doParo, le.ParoAttributes.paro_first, '');
      self.paro_last              := IF(doParo, le.ParoAttributes.paro_last, '');
      self.paro_addr              := IF(doParo, le.ParoAttributes.paro_addr, '');
      self.paro_city              := IF(doParo, le.ParoAttributes.paro_city, '');
      self.paro_state             := IF(doParo, le.ParoAttributes.paro_state, '');
      self.paro_zip               := IF(doParo, le.ParoAttributes.paro_zip, '');
      self.paro_hownstatusflag    := IF(doParo, le.ParoAttributes.paro_hownstatusflag, '');
      self.paro_estincome         := IF(doParo, le.ParoAttributes.paro_estincome, '');
      self.paro_median_hh_size    := IF(doParo, le.ParoAttributes.paro_median_hh_size, ''); // takes the place of score2

			self := rt;  // map the red flags fields
			self := [];
		END;
		attributes := join(ungroup(attr), red_flags_ret, left.input.seq=right.seq, intoAttributes(left, right), left outer);


		wAcctNoa := join(attributes, batchinseq, left.seq=right.seq, 
									transform(layout_working, 
															self.seq := right.seq;
															self.acctno := right.acctno;
															self.Royalty_NAG := 0;
															self := left;
															), 
											right outer);
		
		wAcctNob := join( wAcctNoa, ipdata, left.seq=right.seq,
			transform( layout_working, 
				self.Royalty_NAG := Royalty.RoyaltyNetAcuity.GetCount(right.ipaddr, right.iptype);
				self := left),
			left outer
			);

		// wAcctNo is the normal processing results
		wAcctNo := IF(trackNetacuityRoyalties, wAcctNob, wAcctNoa);
		
		bs_with_ip := record
			risk_indicators.Layout_Boca_Shell bs;
			riskwise.Layout_IP2O ip;
		end;


		clam_ip := join( clam, ipdata, left.seq=right.seq,
			transform( bs_with_ip,
				self.bs := left,
				self.ip := right
			),
			left outer
		);
		
		
#IF(VALIDATION)
	wmodel := Models.MSN1803_1_0(ungroup(clam )); 	// For validation only 
  // RETURN wmodel ;	
#ELSE

		model_temp := map(
			model_name = 'fp3710_0' 	=> Models.FP3710_0_0( clam_ip ),
			model_name = 'fp31105_1' 	=> Models.FP31105_1_0( clam_ip ), // Key Bank - Custom FraudPoint Model
			model_name = 'fp1210_1' 	=> ungroup(Models.FP1210_1_0( clam )), 	// TRIS - Custom FraudPoint Model
		  model_name = 'fp1409_2' 	=> Models.FP1409_2_0( ungroup(clam_BtSt)), //Synchrony - Custom BTST model
      model_name IN ['msn1803_1', 'msnrsn_1']  => Models.MSN1803_1_0( ungroup(clam) ),
      model_name = 'rsn804_1'  => Models.RSN804_1_0( clam, skiptrace_call, easi_census ),
			model_name = '' or model_name in fraudpoint2_models + fraudpoint3_models => dataset( [], Models.Layout_ModelOut ),
			fail(Models.Layout_ModelOut, 'Invalid fraud version/model input combination')
		);

		original_models := project(model_temp, transform(Models.Layouts.layout_fp1109, 
																										 self.seq := if(model_name in bill_to_ship_to_models, left.seq / 2, left.seq), 
																										 self 		:= left, 
																										 self 		:= []));
	
		model_fp1109_0 := Models.FP1109_0_0( clam_ip, 6, false);
		model_fp1307_2 := Models.FP1307_2_0( clam_ip, 6, false);
		
		model_fraudpoint2 := case( model_name,
			'fp1109_0' => model_fp1109_0, 
			'fp1109_9' => Models.FP1109_0_0( clam_ip, 6, true), // FP1109_9 is simply FP1109_0 with criminal risk codes returned
			'fp1307_2' => join(model_fp1109_0, model_fp1307_2, //model_fraudpoint2 = fp1307_2
																	left.seq = right.seq,
																	transform(models.layouts.layout_fp1109, 
																		self.StolenIdentityIndex := right.StolenIdentityIndex,
																		self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
																		self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
																		self.VulnerableVictimIndex := right.VulnerableVictimIndex,
																		self.FriendlyFraudIndex := right.FriendlyFraudIndex,
																		self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
																		self := left)),
			dataset( [], Models.Layouts.layout_fp1109 )
		);

		model_fraudpoint3 := case( model_name,
			'fp31505_0' 		=> Models.FP31505_0_Base( clam_ip, 6, false), 
			'fp1702_2'	  	=> Models.fp1702_2_0( ungroup(clam), 6), 
			'fp1702_1'	  	=> Models.fp1702_1_0( ungroup(clam), 6), 
			'fp3fdn1505_0'	=> Models.FP3FDN1505_0_Base( clam_ip, 6, false), 
			'fp31505_9' 		=> Models.FP31505_0_Base( clam_ip, 6, true), // '_9' indicates to use criminal data
			'fp3fdn1505_9'	=> Models.FP3FDN1505_0_Base( clam_ip, 6, true), // '_9' indicates to use criminal data
			'fp1508_1'	=> Models.fp1508_1_0( ungroup(clam), 6),
												 dataset( [], Models.Layouts.layout_fp1109 )
		);
    
    Second_model_score := CASE(model_name,
                               'msnrsn_1' => Models.RSN804_1_0( clam, skiptrace_call, easi_census ),
                                             dataset( [], Models.Layout_ModelOut )
                              );
		
		//fp1307_2 uses everything from 1109_0 execpt the indices
		model := map(model_name in fraudpoint2_models		=> model_fraudpoint2,
								 model_name in fraudpoint3_models		=> model_fraudpoint3,
								 model_name in fraudpoint3_custom_models => model_fraudpoint3,
																											 original_models);
                                                       
		Layout_FD_Batch_Out_Ext := record
			models.Layout_FD_Batch_Out;
			Royalty.RoyaltyNetAcuity.IPData.Royalty_NAG;
		end;
    
		wmodel_1 := join(wAcctNo, model, left.seq=right.seq,
			transform({unsigned seq, Layout_FD_Batch_Out_Ext},
        self.seq := left.seq,
				self.score1 := right.score,
				self.index2 := map(
					model_name='fp3710_0' => Risk_Indicators.BillingIndex.FP3710_0,
					model_name='fp31105_1' => Risk_Indicators.BillingIndex.FP31105_1,
					model_name='fp1109_0' => Risk_Indicators.BillingIndex.FP1109_0,
					model_name='fp1109_9' => Risk_Indicators.BillingIndex.FP1109_9,
					model_name='fp1307_2' => Risk_Indicators.BillingIndex.FP1307_2,
					model_name='fp1210_1' => Risk_Indicators.BillingIndex.FP1210_1,
					model_name='fp1409_2' => Risk_Indicators.BillingIndex.FP1409_2,
					model_name='fp31505_0' => Risk_Indicators.BillingIndex.FP31505_0,
					model_name='fp3fdn1505_0' => Risk_Indicators.BillingIndex.FP3FDN1505_0,
					model_name='fp31505_9' => Risk_Indicators.BillingIndex.FP31505_9,
					model_name='fp3fdn1505_9' => Risk_Indicators.BillingIndex.FP3FDN1505_9,
					model_name='fp1702_2' => Risk_Indicators.BillingIndex.fp1702_2,
					model_name='fp1702_1' => Risk_Indicators.BillingIndex.fp1702_1,
					model_name='fp1508_1' => Risk_Indicators.BillingIndex.fp1508_1,
					model_name='msn1803_1' => Risk_Indicators.BillingIndex.MSN1803_1,
					model_name='rsn804_1' => Risk_Indicators.BillingIndex.RSN804_1,
					model_name='msnrsn_1' => Risk_Indicators.BillingIndex.MSNRSN_1,
					''
				),
				
				self.modelname1 := map(
					model_name IN ['fp3710_0', 'fp31105_1', 'fp1109_0', 'fp1109_9', 'fp1210_1', 'fp1307_2', 
												 'fp1409_2'] 																															=> 'FraudPoint',
					model_name IN ['fp31505_0'] 																														=> 'FraudPointFP31505_0',
					model_name IN ['fp3fdn1505_0'] 																													=> 'FraudPointFP3FDN1505_0',
					model_name IN ['fp31505_9'] 																														=> 'FraudPointFP31505_9',
					model_name IN ['fp3fdn1505_9'] 																													=> 'FraudPointFP3FDN1505_9',
					model_name IN ['fp1702_2'] 																													    => 'FraudPointfp1702_2',
					model_name IN ['fp1702_1'] 																													    => 'FraudPointfp1702_1',
					model_name IN ['fp1508_1'] 																													    => 'FraudPointfp1508_1',
					model_name IN ['msn1803_1', 'msnrsn_1'] 																								=> 'FraudPointMSN1803_1',
					model_name IN ['rsn804_1'] 																													    => 'FraudPointRSN804_1',
					''
				),
				
				self.scorename1 := map(
					model_name IN ['fp3710_0', 'fp31105_1', 'fp1109_0', 'fp1109_9', 'fp1210_1', 'fp1307_2', 
												 'fp1409_2', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9',
												 'fp1702_2','fp1702_1','fp1508_1', 'msn1803_1', 'msnrsn_1'] 		=> '0 to 999',
          model_name IN ['rsn804_1'] => '250 to 999',
					''
				),
				self.reason1 := right.ri[1].hri,  
				self.reason2 := right.ri[2].hri,
				self.reason3 := right.ri[3].hri,
				self.reason4 := right.ri[4].hri,
				self.reason5 := right.ri[5].hri,
				self.reason6 := right.ri[6].hri,
				
				self.StolenIdentityIndex        :=  right.StolenIdentityIndex;
				self.SyntheticIdentityIndex     :=  right.SyntheticIdentityIndex;
				self.ManipulatedIdentityIndex   :=  right.ManipulatedIdentityIndex;
				self.VulnerableVictimIndex      :=  right.VulnerableVictimIndex;
				self.FriendlyFraudIndex         :=  right.FriendlyFraudIndex;
				self.SuspiciousActivityIndex    :=  right.SuspiciousActivityIndex;
			
				self.Royalty_NAG := left.Royalty_NAG;
				self := left
				
			),
			left outer
		);
    
    Layout_FD_Batch_Out_Ext add_model_2(Recordof(wmodel_1) le, Models.Layout_ModelOut rt) := TRANSFORM
      self.score2 := rt.score;
      self.modelname2 := map(model_name IN ['msnrsn_1'] => 'FraudPointRSN804_1',
                                                           '');
      self.scorename2 := map(model_name IN ['msnrsn_1'] => '250 to 999',
                                                          '');
      self := le
    END;
    
    wmodel := join(wmodel_1, Second_model_score,left.seq=right.seq,
                   add_model_2(left,right), left outer, Atmost(riskwise.max_atmost));
    
	
	// DEBUGs:
	// OUTPUT( model_name, NAMED('model_name') );
	// OUTPUT( model_temp, NAMED('model_temp') );
	// OUTPUT( original_models, NAMED('original_models') );
	// OUTPUT( model, NAMED('model') );
	// OUTPUT( wmodel, NAMED('wmodel') );
	// OUTPUT( wAcctNo, NAMED('wAcctNo') );
	// OUTPUT( attr, NAMED('attr') );
#END	

	return wmodel;

end;
