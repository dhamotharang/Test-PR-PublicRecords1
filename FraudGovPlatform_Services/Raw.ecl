 IMPORT Address, AutoStandardI, Business_Risk, codes, iesp, CriminalRecords_BatchService, DeathV2_Services, 
							 doxie, FraudDefenseNetwork_Services, FraudShared_Services, Gateway, IntlIID, patriot, risk_indicators, 
							 riskwise, ut;

EXPORT Raw(FraudGovPlatform_Services.IParam.BatchParams batch_params) := MODULE

	EXPORT GetDeath(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in) := FUNCTION
									
		death_batch_params := DeathV2_Services.IParam.getBatchParams();		
		ds_death_in := PROJECT(ds_batch_in, DeathV2_Services.Layouts.BatchIn);

		ds_death := DeathV2_Services.BatchRecords(ds_death_in, death_batch_params);
		
		RETURN ds_death;
	
	END;
	
	EXPORT GetCriminal(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in) := FUNCTION
			
		// As per GRP-247 only following offense Categories needs to be returned. 
		crim_batch_params := MODULE(CriminalRecords_BatchService.IParam.batch_params) 
				EXPORT BOOLEAN IncludeBadChecks:= TRUE;
				EXPORT BOOLEAN IncludeBribery:= TRUE;
				EXPORT BOOLEAN IncludeBurglaryComm:= TRUE;
				EXPORT BOOLEAN IncludeBurglaryRes:= TRUE;
				EXPORT BOOLEAN IncludeBurglaryVeh:= TRUE;
				EXPORT BOOLEAN IncludeComputer:= TRUE;
				EXPORT BOOLEAN IncludeCounterfeit:= TRUE;
				EXPORT BOOLEAN IncludeFraud:= TRUE;
				EXPORT BOOLEAN IncludeIdTheft:= TRUE;
				EXPORT BOOLEAN IncludeMVTheft:= TRUE;    
				EXPORT BOOLEAN IncludeRobberyComm:= TRUE;
				EXPORT BOOLEAN IncludeRobberyRes:= TRUE;
				EXPORT BOOLEAN IncludeShoplift:= TRUE;
				EXPORT BOOLEAN IncludeStolenProp:= TRUE;
				EXPORT BOOLEAN IncludeTheft:= TRUE;
				EXPORT BOOLEAN IncludeAtLeast1Offense := TRUE; //This is internal option for Crim Batch Record which needs to be set true if any of the offense categories are TRUE...
		END;
		
		ds_crim_in := PROJECT(ds_batch_in, TRANSFORM(CriminalRecords_BatchService.Layouts.batch_in, SELF := LEFT, SELF := []));
		ds_criminal := CriminalRecords_BatchService.BatchRecords(crim_batch_params, ds_crim_in);
		ds_criminal_records := ds_criminal.Records;
									
		RETURN ds_criminal_records;
	
	END;
	
		SHARED getInstantIDPre(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in) := FUNCTION
		
		ds_instantID := PROJECT(ds_batch_in, 
												TRANSFORM(FraudGovPlatform_Services.Layouts.instantID_in, 
														SELF.seq := COUNTER,
														SELF.home_phone := LEFT.phoneno,
														SELF.street_addr := LEFT.addr,
														SELF := LEFT, 
														SELF := []));
		RETURN ds_instantID;
												
	END;
	
	SHARED GetInstantIDIn(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in) := FUNCTION

			ds_instantID_pre := getInstantIDPre(ds_batch_in);
			
			risk_indicators.Layout_Input into(ds_instantID_pre le) := TRANSFORM
				historydate := if(le.HistoryDateYYYYMM=0, batch_params.history_date, le.HistoryDateYYYYMM);
				
				SELF.historydate := if(le.historyDateTimeStamp<>'',(unsigned)le.historyDateTimeStamp[1..6], historydate);
				SELF.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(le.historydateTimeStamp,historydate);
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
													MAP(TRIM(Stringlib.StringToUppercase(batch_params.NameInputOrder)) = 'FML' => Address.CleanPersonFML73(le.UnParsedFullName),
															TRIM(Stringlib.StringToUppercase(batch_params.NameInputOrder)) = 'LFM' => Address.CleanPersonLFM73(le.UnParsedFullName),
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

			ds_instantID_in := PROJECT(ds_instantID_pre, into(LEFT));
	 
			RETURN ds_instantID_in;
			
	END;
	
	EXPORT GetInstantIDRaw(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in) := FUNCTION
	
		ds_instantID_in := getInstantIDIn(ds_batch_in);
	
		Gateway.Layouts.Config gw_switch(batch_params.gateways le) := TRANSFORM
			SELF.servicename := MAP(batch_params.IncludeTargus = FALSE AND le.servicename = 'targus' => '',	// don't call TG when Targus = FALSE
															batch_params.IncludeTargus3220 AND le.servicename = 'targus' => 'targuse3220',	// if E3220 requested, change servicename for later use
															le.servicename);
			SELF.url := MAP(batch_params.IncludeTargus = FALSE AND le.servicename = 'targus' => '',	// don't call TG when Targus = FALSE
											batch_params.IncludeTargus3220 AND le.servicename = 'targus' => le.url + '?ver_=1.39',	// need version 1.39 for E3220,
											le.url); 
			SELF := le;
		END;
			
				// hardcode gateways to null for now.  Using gateways will be a later story.		
				// gateways := PROJECT(batch_params.gateways, gw_switch(left));
			 gateways := dataset([], Gateway.Layouts.Config);
			
				ds_instantID_out := Risk_Indicators.InstantID_Function(ds_instantID_in, gateways, batch_params.DPPAPurpose,  
																															 batch_params.GLBPurpose, batch_params.IndustryClass='UTILI', 
																															 batch_params.ln_branded_value);
																													 																								 
		RETURN ds_instantID_out;

	END;
	
	EXPORT GetCIID(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
																GROUPED DATASET(risk_indicators.layout_output) ds_instantIDRaw) := FUNCTION

		ds_instantID_pre := getInstantIDPre(ds_batch_in);
		
		FraudGovPlatform_Services.Layouts.Layout_InstandID_NuGenExt format_out(ds_instantIDRaw le, ds_instantID_pre R) := TRANSFORM
			SELF.acctNo		:=R.acctno;
			
			SELF.transaction_id := 0;

			self.verfirst := IF(le.combo_firstcount>0, le.combo_first, '');
			verlast := IF(le.combo_lastcount>0, le.combo_last, '');
			self.verlast := verlast;
			veraddr := IF(le.combo_addrcount>0, Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,
												le.combo_predir,le.combo_prim_name,le.combo_suffix,le.combo_postdir,le.combo_unit_desig,le.combo_sec_range),'');	
			SELF.veraddr := veraddr;	
			
			// clean the verified address to get the delivery point barcode information from the cleaner
			clean_ver_address := risk_indicators.MOD_AddressClean.clean_addr( veraddr, le.combo_city, le.combo_state, le.combo_zip ) ;
			// don't reference the clean fields unless the option to IncludeDPBC is turned on
			ver_zip5 := if(batch_params.IncludeDPBC, clean_ver_address[117..121], le.combo_zip[1..5]);
			ver_zip4 := if(batch_params.IncludeDPBC, clean_ver_address[122..125], le.combo_zip[6..9]);
			// delivery point barcode = zip5 + zip5 + barcode + check_digit
			ver_dpbc := ver_zip5 + ver_zip4 + clean_ver_address[136..138];  // include the 2 character code and 1 character check_digit
			
			// parsed verified address
			SELF.VerPrimRange := IF(le.combo_addrcount>0, le.combo_prim_range, '');
			SELF.VerPreDir := IF(le.combo_addrcount>0, le.combo_predir, '');
			SELF.VerPrimName := IF(le.combo_addrcount>0, le.combo_prim_name, '');
			SELF.VerAddrSuffix := IF(le.combo_addrcount>0, le.combo_suffix, '');
			SELF.VerPostDir := IF(le.combo_addrcount>0, le.combo_postdir, '');
			SELF.VerUnitDesignation := IF(le.combo_addrcount>0, le.combo_unit_desig, '');
			SELF.VerSecRange := IF(le.combo_addrcount>0, le.combo_sec_range, '');
			//
			SELF.vercity := IF(le.combo_addrcount>0, le.combo_city, '');
			SELF.verstate := IF(le.combo_addrcount>0, le.combo_state, '');
			SELF.verzip := IF(le.combo_addrcount>0, ver_zip5, '');
			SELF.verzip4 := IF(le.combo_addrcount>0, ver_zip4, '');
			self.verDPBC := if(le.combo_addrcount>0 and batch_params.IncludeDPBC and ver_zip4<>'', ver_DPBC, '');
			self.vercounty := if(le.combo_addrcount>0, le.combo_county, '');

			SELF.verdob := IF(le.combo_dobcount>0, le.combo_dob, '');
			SELF.verssn := IF(le.combo_ssncount>0 and le.combo_ssnscore between 90 and 100, le.combo_ssn, ''); // don't output ssn for verlevel=1, per Bug 182049
			SELF.verhphone := IF(le.combo_hphonecount>0, le.combo_hphone, '');
			
			SELF.verify_addr := IF(le.addrmultiple,'O','');
			SELF.verify_dob := IF(le.combo_dobcount>0,'Y','N');
			//new for Emerging Identities - a fake DID means we verified first, last and SSN in getDIDprepOutput so set NAS to 9
			SELF.NAS_summary := If(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, 9, le.socsverlevel); 
			SELF.NAP_summary := le.phoneverlevel;
			SELF.NAP_Type    := le.nap_type;
			SELF.NAP_Status  := le.nap_status;
			
			SELF.valid_ssn := IF(le.socllowissue != '', 'G', '');
			
			SELF.corrected_lname := le.correctlast;
			SELF.corrected_dob := le.correctdob;
			SELF.corrected_phone := le.correcthphone;
			SELF.corrected_ssn := le.correctssn;
			SELF.corrected_address := le.correctaddr;
			// parsed corrected address - if correctaddr is populated, it will always be the same as verified address, don't clean le.correctaddr
			haveCorrected := le.correctaddr<>'';
			SELF.CorrectedPrimRange := if(haveCorrected, le.combo_prim_range, '');
			SELF.CorrectedPreDir := if(haveCorrected, le.combo_predir, '');
			SELF.CorrectedPrimName := if(haveCorrected, le.combo_prim_name, '');
			SELF.CorrectedAddrSuffix := if(haveCorrected, le.combo_suffix, '');
			SELF.CorrectedPostDir := if(haveCorrected, le.combo_postdir, '');
			SELF.CorrectedUnitDesignation := if(haveCorrected, le.combo_unit_desig, '');
			SELF.CorrectedSecRange := if(haveCorrected, le.combo_sec_range, '');
			//
			SELF.area_code_split := if(le.areacodesplitflag='Y', le.altareacode, '');
			SELF.area_code_split_date := if(le.areacodesplitflag='Y', le.areacodesplitdate, '');
			
			SELF.additional_score1 := 0;
			SELF.additional_score2 := 0;
			
			SELF.phone_fname := le.dirsfirst;
			SELF.phone_lname := le.dirslast;
			SELF.phone_address := Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range,le.dirs_predir,le.dirs_prim_name,
													le.dirs_suffix,le.dirs_postdir,le.dirs_unit_desig,le.dirs_sec_range);
			// parsed phone address
			SELF.PhonePrimRange := le.dirs_prim_range;
			SELF.PhonePreDir := le.dirs_predir;
			SELF.PhonePrimName := le.dirs_prim_name;
			SELF.PhoneAddrSuffix := le.dirs_suffix;
			SELF.PhonePostDir := le.dirs_postdir;
			SELF.PhoneUnitDesignation := le.dirs_unit_desig;
			SELF.PhoneSecRange := le.dirs_sec_range;
			//
			SELF.phone_city := le.dirscity;
			SELF.phone_st := le.dirsstate;
			SELF.phone_zip := le.dirszip;
			
			SELF.name_addr_phone := MAP(le.phonever_type='U' => le.utiliphone,
									 le.phonever_type='A' => le.dirsaddr_phone,  
									 le.phoneaddr_phonecount >= le.utiliaddr_phonecount => le.dirsaddr_phone,
									 le.utiliphone);
			
			SELF.ssa_date_first := le.socllowissue;
			SELF.ssa_date_last := le.soclhighissue;
			SELF.ssa_state := le.soclstate;
			SELF.ssa_state_name := Codes.GENERAL.STATE_LONG(le.soclstate);
			
			SELF.current_fname := le.verfirst;
			SELF.current_lname := le.verlast;
			
			addr1 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range, le.chronopredir, 
													 le.chronoprim_name, le.chronosuffix,
													 le.chronopostdir, le.chronounit_desig, le.chronosec_range);
			addr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2, le.chronopredir2, 
													 le.chronoprim_name2, le.chronosuffix2,
													 le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2);
			addr3 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range3, le.chronopredir3, 
													 le.chronoprim_name3, le.chronosuffix3,
													 le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3);
			
			// clean the chrono address1 to get the delivery point barcode information from the cleaner
			clean_chrono_address1 := risk_indicators.MOD_AddressClean.clean_addr( addr1, le.chronocity, le.chronostate, le.chronozip ) ;
			// don't reference the clean fields unless the option to IncludeDPBC is turned on
			chrono_zipz5_1 := if(batch_params.IncludeDPBC, clean_chrono_address1[117..121], le.chronozip);
			chrono_zip4_1 := if(batch_params.IncludeDPBC, clean_chrono_address1[122..125], le.chronozip4);
			// delivery point barcode = zip5 + zip5 + barcode[136..137] + check_digit[138]
			chrono1_dpbc := if(batch_params.IncludeDPBC and chrono_zip4_1<>'', chrono_zipz5_1 + chrono_zip4_1 + clean_chrono_address1[136..138], '');  // include the 2 character code and 1 character check_digit
			
			
			// clean the chrono address2 to get the delivery point barcode information from the cleaner
			clean_chrono_address2 := risk_indicators.MOD_AddressClean.clean_addr( addr2, le.chronocity2, le.chronostate2, le.chronozip2 ) ;
			// don't reference the clean fields unless the option to IncludeDPBC is turned on
			chrono_zipz5_2 := if(batch_params.IncludeDPBC, clean_chrono_address2[117..121], le.chronozip2);
			chrono_zip4_2 := if(batch_params.IncludeDPBC, clean_chrono_address2[122..125], le.chronozip4_2);
			// delivery point barcode = zip5 + zip5 + barcode[136..137] + check_digit[138]
			chrono2_dpbc := if(batch_params.IncludeDPBC and chrono_zip4_2<>'',chrono_zipz5_2 + chrono_zip4_2 + clean_chrono_address2[136..138], '');  // include the 2 character code and 1 character check_digit
			
			// clean the chrono address3 to get the delivery point barcode information from the cleaner
			clean_chrono_address3 := risk_indicators.MOD_AddressClean.clean_addr( addr3, le.chronocity3, le.chronostate3, le.chronozip3 ) ;
			// don't reference the clean fields unless the option to IncludeDPBC is turned on
			chrono_zipz5_3 := if(batch_params.IncludeDPBC, clean_chrono_address3[117..121], le.chronozip3);
			chrono_zip4_3 := if(batch_params.IncludeDPBC, clean_chrono_address3[122..125], le.chronozip4_3);
			// delivery point barcode = zip5 + zip5 + barcode[136..137] + check_digit[138]
			chrono3_dpbc := if(batch_params.IncludeDPBC and chrono_zip4_3<>'',chrono_zipz5_3 + chrono_zip4_3 + clean_chrono_address3[136..138], '');  // include the 2 character code and 1 character check_digit
			
			
			Chronology := DATASET([{1, addr1, le.chronoprim_range, le.chronopredir, le.chronoprim_name, le.chronosuffix, le.chronopostdir, le.chronounit_desig, le.chronosec_range, 
												le.chronocity, le.chronostate, le.chronozip, le.chronozip4, le.chronophone, le.chronodate_first, le.chronodate_last, le.chronoaddr_isbest, if(batch_params.IncludeDPBC,chrono1_dpbc,'')},
											{2, addr2, le.chronoprim_range2, le.chronopredir2, le.chronoprim_name2, le.chronosuffix2, le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2, 
													le.chronocity2, le.chronostate2, le.chronozip2, le.chronozip4_2, le.chronophone2, le.chronodate_first2, le.chronodate_last2, le.chronoaddr_isbest2, if(batch_params.IncludeDPBC,chrono2_dpbc,'')},
											{3, addr3, le.chronoprim_range3, le.chronopredir3, le.chronoprim_name3, le.chronosuffix3, le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3, 
													le.chronocity3, le.chronostate3, le.chronozip3, le.chronozip4_3, le.chronophone3, le.chronodate_first3, le.chronodate_last3, le.chronoaddr_isbest3, if(batch_params.IncludeDPBC,chrono3_dpbc,'')}], 
											Risk_Indicators.Layout_AddressHistory);
			self.chronology := chronology(Address<>'');
			
			SELF.Additional_Lname := if(le.socsverlevel IN risk_indicators.iid_constants.ssn_name_match, DATASET([{le.altfirst,le.altlast,le.altlast_date},
											{le.altfirst2,le.altlast2,le.altlast_date2},
											{le.altfirst3,le.altlast3,le.altlast_date3}], Risk_Indicators.Layout_LastNames), 
										dataset([], Risk_Indicators.Layout_LastNames));

			SELF.fua := risk_indicators.getActionCodes(le,4, SELF.NAS_summary, SELF.NAP_summary, ac_settings := batch_params.actioncode_settings /*, rc*/);
			
			cvi_temp := if(batch_params.actualIIDVersion=0, risk_indicators.cviScore(le.phoneverlevel,le.socsverlevel,le,le.correctssn,le.correctaddr,le.correcthphone,'',veraddr,verlast,
																														batch_params.OFAC),	
																					risk_indicators.cviScoreV1(le.phoneverlevel,le.socsverlevel,le,le.correctssn,le.correctaddr,le.correcthphone,'',veraddr,verlast,
																														batch_params.OFAC, batch_params.IncludeDOBinCVI, batch_params.IncludeDriverLicenseInCVI));
			isCodeDI := risk_indicators.rcSet.isCodeDI(le.DIDdeceased) and batch_params.actualIIDVersion=1;
			SELF.CVI := map(batch_params.IncludeMSoverride and risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months) and (integer)cvi_temp > 10 => '10',
									batch_params.IsPOBoxCompliant AND risk_indicators.rcSet.isCodePO(le.addr_type) and (integer)cvi_temp > 10 => '10',
									batch_params.IncludeCLoverride and risk_indicators.rcSet.isCodeCL(le.ssn, le.bestSSN, le.socsverlevel, le.combo_ssn) and (integer)cvi_temp > 10 => '10',
									batch_params.IncludeMIoverride AND risk_indicators.rcSet.isCodeMI(le.adls_per_ssn_seen_18months) and (INTEGER)cvi_temp > 10 and batch_params.actualIIDVersion=1 => '10',
									isCodeDI AND (INTEGER)cvi_temp > 10 => '10',
									cvi_temp);
			
			
			self.verdl := le.verified_dl;
				
			self.SubjectSSNCount := if(risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months), (string)le.ssns_per_adl_seen_18months, '');

			self.age := if (le.age = '***','',le.age);
			
			self.ssn := r.ssn;	// get back the original input (4 byte input could be overwritten in IIDCommon)
			self.dob := r.dob;	// get back the original input (dob can be blanked out if not 8 bytes)
			
			// if DID is flagged as deceased, use that information otherwise if ssn is verified and flagged as deceased, return the information about the deceased SSN
			ssn_verified := le.socsverlevel IN risk_indicators.iid_constants.ssn_name_match;
			isCode02 := risk_indicators.rcSet.isCode02(le.decsflag);

			self.deceasedDate := MAP(	ssn_verified and isCode02 => if(le.deceasedDate=0, '', (string)le.deceasedDate),
																isCodeDI => if(le.DIDdeceasedDate=0, '', (STRING)le.DIDdeceasedDate),
																
																'');
			self.deceasedDOB := MAP(ssn_verified and isCode02 => if(le.deceasedDOB=0, '', (string)le.deceasedDOB),
															isCodeDI => if(le.DIDdeceasedDOB=0, '', (STRING)le.DIDdeceasedDOB),
															'');
															
			self.deceasedFirst := MAP( ssn_verified and isCode02 => le.deceasedFirst,
																isCodeDI => le.DIDdeceasedFirst,
																'');
			self.deceasedLast := MAP(	ssn_verified and isCode02 => le.deceasedLast,
																isCodeDI => le.DIDdeceasedLast,
																'');
			
			risk_indicators.mac_add_sequence(le.watchlists, watchlists_with_seq);
			self.watchlists := watchlists_with_seq;

			// add a sequence number to the reason codes for sorting in XML
			risk_indicators.mac_add_sequence(risk_indicators.reasonCodes(le, batch_params.NumReturnCodes, batch_params.reasoncode_settings), reasons_with_seq);
			self.ri := reasons_with_seq;
				
			passportline := r.PassportUpperLine + r.PassportLowerLine;
			self.passportValidated := if(IntlIID.ValidationFunctions().passportValidation(passportline, r.dob[3..8], r.gender), 'Y','N');
			
			self.dobmatchlevel := le.dobmatchlevel;
			
			self.SSNFoundForLexID := le.bestssn<>'' and batch_params.actualIIDVersion=1;	// is this correct?
			self.addressPOBox := (Risk_Indicators.rcSet.isCode12(le.addr_type) or Risk_Indicators.rcSet.isCodePO(le.zipclass)) and batch_params.actualIIDVersion=1;
			self.addressCMRA := (le.hrisksic in risk_indicators.iid_constants.setCRMA or le.ADVODropIndicator='C') and batch_params.actualIIDVersion=1;
			
			self.cviCustomScore := '';	// new field for future use
			
			self.InstantIDVersion := (string)batch_params.actualIIDVersion;	
			
			//new for Emerging Identities
			self.EmergingID := if(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, true, false);  //a fake DID indicates an Emerging Identity
			isReasonCodeSR	:= exists(reasons_with_seq(hri='SR')); //check if reason code 'SR' is set
			self.AddressSecondaryRangeMismatch := map(le.sec_range = '' and isReasonCodeSR															=> 'D',	 //no input sec range, but our data has one
																								le.sec_range <> '' and ~isReasonCodeSR and self.versecrange = ''	=> 'I',	 //input sec range, but our data does not have one
																								le.sec_range <> '' and isReasonCodeSR															=> 'M',	 //input sec range, but our data shows different sec range
																								le.sec_range = '' and ~isReasonCodeSR															=> 'N',	 //no input sec range and our data does not have one
																																																										 'V'); //input sec range matches our data
			self.StandardizedAddress := if(le.addr_status[1] in ['E',''], false, true); //check address status to see if it standardized successfully
			self.StreetAddress1 := address.Addr1FromComponents(le.prim_range,le.predir,le.prim_name,le.addr_suffix,le.postdir,le.unit_desig,le.sec_range);
			self.StreetAddress2 := address.Addr2FromComponents(le.p_city_name,le.st,le.z5);
			self.DID := if(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, 0, le.DID); //if DID is fake, zero it out
			
			SELF := le;
			SELF := [];  // default models and red flags datasets to empty
		END;

		ds_ciid_out := join(ds_instantIDRaw, ds_instantID_pre, left.seq = right.seq, format_out(LEFT, RIGHT));

		IF(batch_params.actualIIDVersion=99, FAIL('Not an allowable InstantIDVersion.  Currently versions 0 and 1 are supported'));

		RETURN ds_ciid_out;
								
	END;
	
	EXPORT GetRedFlags(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
																				GROUPED DATASET(risk_indicators.layout_output) ds_instantIDRaw) := FUNCTION
		
		red_flags_ret := IF(batch_params.RedFlag_version<>0, risk_indicators.Red_Flags_Function(ds_instantIDRaw, batch_params.reasoncode_settings), 
													DATASET([], FraudGovPlatform_Services.Layouts.combined_layouts) );
		
		IF(batch_params.actualIIDVersion=99, FAIL('Not an allowable InstantIDVersion.  Currently versions 0 and 1 are supported'));

		RETURN red_flags_ret;
								
	END;
	
 	EXPORT GetGlobalWatchlist(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in) := FUNCTION						

		patriot.Layout_batch_in xform_in(ds_batch_in le) := TRANSFORM
			SELF.name_first := Stringlib.StringToUpperCase(le.name_first);
			SELF.name_middle := Stringlib.StringToUpperCase(le.name_middle);
			SELF.name_last := Stringlib.StringToUpperCase(le.name_last);
			SELF.name_unparsed := '';
			SELF.country := '';
			SELF.search_type := Stringlib.StringToUpperCase(batch_params.search_type);
			SELF.dob := le.dob;	
			SELF := le;
		END;

		ds_global_watchlist_in := GROUP(PROJECT(ds_batch_in, xform_in(LEFT)), acctno);

		// Parameters to function call from Michele Walklin
		ds_global_watchlist_out := Patriot.Search_Batch_Function(ds_global_watchlist_in, FALSE, 0.00, 2, TRUE);
								
		RETURN UNGROUP(ds_global_watchlist_out);
										 
 	END;
	
	EXPORT getFDN(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in) := FUNCTION
	
		ds_fdn_in := PROJECT(ds_batch_in, 
										TRANSFORM(FraudDefenseNetwork_Services.Layouts.batch_search_rec, 	
												SELF.v_city_name := LEFT.p_city_name,
												SELF.zip5 := LEFT.z5,
												SELF.phone10 := LEFT.phoneno,
												SELF.emailaddress := LEFT.email_address,
												SELF.ipaddress := LEFT.ip_address,
												SELF.deviceid := 	LEFT.device_id,
												SELF := LEFT,
												SELF := []));

		ds_fdn_raw := FraudDefenseNetwork_Services.Search_Records(ds_fdn_in, 
																																																												FraudGovPlatform_Services.Constants.FDN.gc_id, 
																																																												FraudGovPlatform_Services.Constants.FDN.industry_type, 
																																																												FraudGovPlatform_Services.Constants.FDN.product_code, 	
																																																												DATASET([], iesp.frauddefensenetwork.t_FDNIndType),
																																																												DATASET([],iesp.frauddefensenetwork.t_FDNFileType));
	 
	  ds_fdn_filter := ds_fdn_raw(doxie.DataPermission.use_FDNContributoryData OR
															  classification_Permissible_use_access.file_type <> FraudShared_Services.Constants.FileTypeCodes.CONTRIBUTORY);


		RETURN ds_fdn_filter;
	END;
END;
