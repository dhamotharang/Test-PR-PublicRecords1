IMPORT BIPV2_Company_Names,DidVille,Drivers,MDR,Phones,Phonesplus_v2,STD,ut, D2C;

EXPORT Functions :=
MODULE

  //NOTE: This function should ONLY be used for checking phone data restrictions for the
	// PhonesPlusV2 data or the phones "Last Resort" (AKA Wired_Assets_Royalty) data.

	// Important!: IF you change this permission logic, you might also need to modify all the
	//  attributes that call it when using Phonesplus_v2.Key_Phonesplus_Did or Key_Phonesplus_Fdid.
	EXPORT BOOLEAN isPhoneRestricted(STRING2 state,
																	 UNSIGNED1 glb_purpose,
																	 UNSIGNED1 dppa_purpose,
																	 STRING5 industry_class = '',
																	 BOOLEAN checkRNA = FALSE,
																	 UNSIGNED3 dt_first_seen = 0,
																	 UNSIGNED3 dt_nonglb_last_seen = 0,
																	 UNSIGNED8 rules = 0,
																   UNSIGNED8 src_all = 0,
																	 STRING data_restriction_mask
																	) :=
	FUNCTION
				
 		// Set some easier to understand booleans
    GLB_OK  := ut.glb_ok(glb_purpose, checkRNA);
    DPPA_OK := ut.dppa_ok(dppa_purpose, checkRNA);
				is_CNSMR  := ut.IndustryClass.is_Knowx;

    // Check if specific Insurance bit is set
    ins_bit := Phonesplus_v2.Translation_Codes.rules_bitmap_code (Phones.Constants.InsVeriBelow);
    boolean INSURANCE_RESTRICTED := NOT GLB_OK AND (rules & ins_bit = ins_bit);

 		// Decode the input "src_all" value to see all the 2 char source codes that were rolled into
		// that phonesplus record.  The decode function output is a string with 1 or more 2 char
		// "src" codes each separated by a space. i.e. "AA BB CC ..."
    STRING src_all_decoded := Phonesplus_v2.Translation_Codes.fGet_all_sources(src_all);

		// Use the decoded src_all string to create a set
    SET OF STRING2 set_src_all := STD.Str.SplitWords(src_all_decoded,' ');

    // Turn the set into a dataset
		ds_src_all := DATASET(set_src_all, {STRING2 src});

    // Use mutiple filters against the dataset of all sources to check for specific sources
		// that are restricted via: GLB/preGLB or DPPA or Utility/Industry_Class or DRM.
    // A phone is restricted if:
    boolean restricted (string2 src) :=
       // Sources that might be restricted via GLB
			 (src in MDR.sourceTools.set_GLB
			   and NOT GLB_OK
			   and NOT ut.PermissionTools.glb.HeaderIsPreGLB(dt_nonglb_last_seen, dt_first_seen, src))

       // 2 additonal PhonesPlus sources that might also be restricted via GLB: IQ & L9,
			 // but the additional PreGLB restriction/permission does not apply to them.
			 OR ((src = MDR.sourceTools.src_InquiryAcclogs or src = MDR.sourceTools.src_Link2Tek)
			     and NOT GLB_OK)

		   // Sources that might be restricted via DPPA
       OR (src in MDR.sourceTools.set_DPPA_sources
			     and NOT DPPA_OK
			     and Drivers.state_dppa_ok(state,dppa_purpose,src))

       // Utility data that might be restricted via input Industry_Class value
       OR (src in MDR.sourceTools.set_Utilities and industry_class = 'UTILI')

       //Sources that might be restricted via DataRestrictionMask
			 // Instead of trying to re-create some of the coding in AutoStandardI.DataRestrictionI,
			 // just used a subset of the coding here.
       OR (src = MDR.sourceTools.src_LnPropV2_Fares_Asrs    and data_restriction_mask[1] != '0')
       OR (src = MDR.sourceTools.src_Experian_Credit_Header and data_restriction_mask[6] != '0')
		     OR (src = MDR.sourceTools.src_Certegy         and data_restriction_mask[7] not in ['0',''])
	      OR (src = MDR.sourceTools.src_Equifax         and data_restriction_mask[8] not in ['0',''])
		     OR (src = MDR.sourceTools.src_TU_CreditHeader and data_restriction_mask[10] not in ['0',''])
 		    OR (src = MDR.sourceTools.src_InquiryAcclogs  and data_restriction_mask[16] not in ['0',''])
			    OR(src in D2C.Constants.PhonesPlusV2RestrictedSources and is_CNSMR);
      //end of filters

		// remove restricted sources from the dataset of all sources
    ds_srcs_not_restricted := ds_src_all (NOT restricted (src));

    // debugging outputs have to be here before the "RETURN"
		//output(GLB_OK,                 NAMED('GLB_OK'),EXTEND);
		//output(DPPA_OK,                NAMED('DPPA_OK'),EXTEND);
    //output(rules,                  NAMED('rules'),EXTEND);
	  //output(INSURANCE_RESTRICTED,   NAMED('INSURANCE_RESTRICTED'),EXTEND);
    //output(src_all,                NAMED('src_all'),EXTEND);
    //output(src_all_decoded,        NAMED('src_all_decoded'),EXTEND);
    //output(ds_src_all,             NAMED('ds_src_all'),EXTEND);
    // output(ds_srcs_not_restricted, NAMED('ds_srcs_not_restricted'),EXTEND);

	  // "TRUE"(restricted) is returned if either the input rec is restricted by Insurance verified/GLB
	  // OR the dataset of sources that are not-restricted is empty
    RETURN (INSURANCE_RESTRICTED OR
						NOT EXISTS(ds_srcs_not_restricted)
		       );

  END; // end of isPhoneRestricted function

	// Phones(phonesplus, last resort and inhouse qsent) data
	EXPORT GetPhonesPlusData( dIn,
														inAKMod,
														phoneSrc,
														skipAutoKeys      = FALSE,
														doPhoneOnlySearch = FALSE,
														isPhone7Search    = FALSE
													) :=
	FUNCTIONMACRO
		IMPORT Autokey_Batch,AutokeyB2_batch,Data_Services,Header,MDR,Phones,Phonesplus,Phonesplus_v2,ut;

		l_BatchIn := Phones.Layouts.BatchIn;
		l_Common  := Phones.Layouts.PhonesCommon;

		modpenalty := Phones.GetPenalty;

		// BOOLEAN variables for phone sources
		BOOLEAN isPhonesPlus   := phoneSrc = MDR.SourceTools.src_Phones_Plus;
		BOOLEAN isLastResort   := phoneSrc = MDR.SourceTools.src_wired_Assets_Royalty;
		BOOLEAN isInHouseQSent := phoneSrc = MDR.SourceTools.src_InHouse_QSent;

		// doOnlyPhoneSearch - check to search by only phone number or not
		#IF(doPhoneOnlySearch)
			l_BatchIn tKeepPhoneOnly(dIn pInput) :=
			TRANSFORM
				SELF.acctno    := pInput.acctno;
				SELF.homephone := pInput.homephone;
				SELF           := [];
			END;

			dInReformat := PROJECT(dIn,tKeepPhoneOnly(LEFT));
		#ELSE
			dInReformat := dIn;
		#END

		// Phones index
		#IF(isPhonesPlus)
			keyDID      := Phonesplus_v2.Key_Phonesplus_Did;
			keyFDID     := Phonesplus_v2.Key_Phonesplus_fdid;
			keyCompName := Phonesplus_v2.Key_Phonesplus_Companyname;
		#ELSEIF(isLastResort)
			keyDID      := Phonesplus_v2.Key_Royalty_Did;
			keyFDID     := Phonesplus_v2.Key_Royalty_Fdid;
			keyCompName := Phonesplus_v2.Key_Royalty_Companyname;
		#ELSE
			keyDID      := Phonesplus.key_qsent_did;
			keyFDID     := Phonesplus.key_qsent_fdid;
			keyCompName := Phonesplus.key_qsent_companyname;
		#END

		// Phones layout
		rPhones_Layout :=
		RECORD(Phonesplus_v2.layoutCommonOut)
			l_BatchIn batch_in;
			STRING120 listed_name;
			BOOLEAN   isDeepDive := FALSE;
		END;

		// Search by DID
		#IF(~doPhoneOnlySearch)
			rPhones_Layout tGetByDID(dInReformat le,keyDID	ri) :=
			TRANSFORM
				SELF.glb_dppa_flag :=
				                   #IF(isPhonesPlus or isLastResort)
				                      IF( Phones.Functions.isPhoneRestricted(ri.origstate,
																																		 inAKMod.GLBPurpose,
																																		 inAKMod.DPPAPurpose,
																																		 inAKMod.IndustryClass,
																																		 , //checkRNA
																																		 ri.datefirstseen,
																																		 ri.dt_nonglb_last_seen,
																																		 ri.rules,
																																		 ri.src_all,
																																		 inAKMod.DataRestrictionMask
																																		 ),
																	SKIP,
																	ri.glb_dppa_flag
																);
													 #ELSE
													  ri.glb_dppa_flag;
													 #END
				SELF.listed_name   := IF(ri.origname != '',ri.origname,ri.company);
				SELF.isDeepDive    := TRUE;
				SELF.batch_in      := le;
				SELF               := ri;
			END;

			dDIDs := JOIN(dInReformat,
										keyDID,
										KEYED(LEFT.did = RIGHT.l_did),
										tGetByDID(LEFT,RIGHT),
										LIMIT(ut.Limits.PHONE_PER_PERSON,SKIP));
		#END

		// Autokey Fake DIDs
		dFDIDs := MAP(isPhonesPlus   => AutoKey_Batch.get_fids(dInReformat,Data_Services.Data_location.Prefix('PHONES')+'thor_data400::key::phonesplusv2_',inAKMod),
									isLastResort   => AutoKey_Batch.get_fids(dInReformat,Data_Services.Data_location.Prefix('PHONES')+'thor_data400::key::phonesplusv2_royalty_',inAKMod),
									isInHouseQSent => AutoKey_Batch.get_fids(dInReformat,Data_Services.Data_location.Prefix('PHONES')+'thor_data400::key::qsent_',inAKMod));

		// Get fake ids by company name
		#IF(doPhoneOnlySearch)
			dFDIDsAll := dFDIDs;
		#ELSE
			AutokeyB2_batch.Layouts.rec_output_IDs_batch tGetByComp(dInReformat le,keyCompName ri) :=
			TRANSFORM
				SELF.acctno := le.acctno;
				SELF.id     := ri.fdid;
				SELF.isDID  := TRUE;
			END;

			dCompFDIDs := JOIN( dInReformat,
													keyCompName,
													LEFT.comp_name != '' and
													(LEFT.comp_name = RIGHT.company or
													(TRIM(LEFT.comp_name)+' ') = RIGHT.company[1..length(TRIM(LEFT.comp_name))+1]),
													tGetByComp(LEFT,RIGHT),
													LIMIT(ut.Limits.PHONE_PER_ADDRESS));

			// Combine the FDIDs
			dFDIDsAll := dFDIDs + dCompFDIDs;
		#END

		// JOIN to the payload key to get the phone data
		rPhones_Layout tGetByFDID(dFDIDsAll le,keyFDID ri) :=
		TRANSFORM
			SELF.batch_in.acctno := le.acctno;
			SELF.vendor          := ri.vendor;
			SELF.glb_dppa_flag   :=
			                     #IF(isPhonesPlus or isLastResort)
				                      IF( Phones.Functions.isPhoneRestricted(ri.origstate,
																																		 inAKMod.GLBPurpose,
																																		 inAKMod.DPPAPurpose,
																																		 inAKMod.IndustryClass,
																																		 , //checkRNA
																																		 ri.datefirstseen,
																																		 ri.dt_nonglb_last_seen,
																																		 ri.rules,
																																		 ri.src_all,
																																		 inAKMod.DataRestrictionMask
																																		 ),
																	SKIP,
																	ri.glb_dppa_flag
																);
													 #ELSE
													  ri.glb_dppa_flag;
													 #END
			SELF.listed_name     := IF(ri.origname != '',ri.origname,ri.company);
			SELF                 := ri;
			SELF                 := [];
		END;

		dFDIDsPayload := JOIN(dFDIDsAll,
													keyFDID,
													KEYED(LEFT.id = RIGHT.fdid),
													tGetByFDID(LEFT,RIGHT),
													LIMIT(ut.Limits.PHONE_PER_PERSON,SKIP));

		// Append input data to the phone recs for use in penalty calculations
		rPhones_Layout tAppendInputData(dInReformat le,dFDIDsPayload ri) :=
		TRANSFORM
			SELF.batch_in := le;
			SELF          := ri;
		END;

		dPayloadWInput := JOIN( dInReformat,
														dFDIDsPayload,
														LEFT.acctno = RIGHT.batch_in.acctno,
														tAppendInputData(LEFT,RIGHT),
														// This function and limit are originally designed to work for phone10 search.
														// Since we are essentially using the same for phone7 search too, I had to increase the limit
														// and did it conditionally depending on the type of search
														LIMIT(IF(isPhone7Search,ut.Limits.PHONE7_LIMIT,ut.Limits.PHONE_PER_PERSON),SKIP));

		#IF(doPhoneOnlySearch)
			dPPRecs := IF(skipAutokeys,
										PROJECT(dInReformat,TRANSFORM(rPhones_Layout,SELF.batch_in := LEFT,SELF := [])),
										dPayloadWInput);
		#ELSE
			dPPRecs := IF(skipAutoKeys,dDIDs,dDIDs + dPayloadWInput);
		#END

		// Filter records below the confidence score threshold
		#IF(isPhonesPlus)
			// Filter records by source
			Header.MAC_Filter_Sources(dPPRecs,dPPFilterSources,src,inAKMod.DataRestrictionMask);
			dPPFilterByPhoneThreshold := dPPFilterSources(confidencescore >= Phones.Constants.PhoneConfidenceScore);
		#ELSE
			dPPFilterByPhoneThreshold := dPPRecs(confidencescore >= Phones.Constants.PhoneConfidenceScore);
		#END

		// Format to common layout
		l_Common tFormat2PPCommon(dPPFilterByPhoneThreshold pInput) :=
		TRANSFORM
			dls_value := IF(pInput.datelastseen=0,pInput.datevendorlastreported,pInput.datelastseen);

			SELF.penalt                   := 0;
			SELF.vendor_id                := pInput.vendor;
			SELF.src                      := MAP( isPhonesPlus and pInput.vendor = 'GH' => MDR.SourceTools.src_Gong_phone_append,
																						isInHouseQSent                        => MDR.SourceTools.src_InHouse_QSent,
																						pInput.src);
			SELF.tnt                      := MAP( isPhonesPlus and pInput.vendor = MDR.SourceTools.src_Gong_phone_append => Phones.Constants.TNT.History,
																						isInHouseQSent and pInput.activeFlag = 'Y'                             => Phones.Constants.TNT.Verified,
																						isInHouseQSent                                                         => Phones.Constants.TNT.History,
																						'');
			SELF.phone                    := pInput.cellphone;
			SELF.listing_type_res         := MAP( isLastResort and pInput.ListingType in ['R','BR','RS','RG','RB'] => Phones.Constants.ListingType.Residential,
																						pInput.ListingType in ['R','BR','RS']                            => Phones.Constants.ListingType.Residential,
																						'');
			SELF.listing_type_bus         := MAP( isLastResort and pInput.ListingType in ['B','BG','BR','RB'] => Phones.Constants.ListingType.Business,
																						pInput.ListingType in ['B','BG','BR']                       => Phones.Constants.ListingType.Business,
																						'');
			SELF.listing_type_gov         := MAP( isLastResort and pInput.ListingType in ['G','BG','RG'] => Phones.Constants.ListingType.Government,
																						pInput.ListingType in ['G','BG']                       => Phones.Constants.ListingType.Government,
																						'');
			SELF.dt_last_seen             := ut.date6_to_date8(dls_value);
			SELF.dt_first_seen            := ut.date6_to_date8(IF(pInput.datefirstseen<=dls_value,pInput.datefirstseen,0));
			SELF.dob                      := (INTEGER4)pInput.dob;
			SELF.ssn                      := '';
			SELF.suffix                   := pInput.addr_suffix;
			SELF.city_name                := pInput.p_city_name;
			SELF.st                       := pInput.state;
			SELF.zip                      := pInput.zip5;
			SELF.vendor_dt_last_seen_used := pInput.datelastseen = 0 and pInput.datevendorlastreported <> 0;
			SELF.county_code              := IF(pInput.ace_fips_st='','00',pInput.ace_fips_st) + pInput.ace_fips_county;
			SELF                          := pInput;
		END;

		dPPCommon := PROJECT(dPPFilterByPhoneThreshold,tFormat2PPCommon(LEFT));

		// Dedup records
		dPPCommonDedup := DEDUP(SORT(dPPCommon,RECORD),RECORD, EXCEPT isDeepDive);

		// Calculate penalty
		l_Common tGetPenalty(dPPCommonDedup pInput) :=
		TRANSFORM
			#IF(doPhoneOnlySearch)
				SELF.penalt := modpenalty.GetPhonePenalty(pInput);
			#ELSE
				SELF.penalt :=   modpenalty.GetPhonePenalty(pInput)
											 + modpenalty.GetAddrPenalty(pInput)
											 + modpenalty.GetNamePenalty(pInput)
											 + modpenalty.GetDIDPenalty(pInput)
											 + modpenalty.GetDOBPenalty(pInput)
											 + modpenalty.GetSSNPenalty(pInput)
											 + modpenalty.GetCountyPenalty(pInput)
											 + IF(pInput.batch_in.comp_name != '',ut.CompanySimilar(pInput.batch_in.comp_name,pInput.listed_name)+3,0);
			#END
			SELF        := pInput;
		END;

		dPPPenalty := PROJECT(dPPCommonDedup,tGetPenalty(LEFT));

		// Filter out records which don't fall with in the penalty threshold
		dPPPenaltyFilter := dPPPenalty(penalt <= inAKMod.PenaltyThreshold);

		// Debug
		#IF(Phones.Constants.Debug.PhonesPlus)
			OUTPUT(dIn,NAMED('dPP_In'),EXTEND);
			OUTPUT(dInReformat,NAMED('dPP_InReformat'),EXTEND);
			#IF(~doPhoneOnlySearch)
				OUTPUT(dDIDs,NAMED('dPP_DIDs'),EXTEND);
				OUTPUT(dCompFDIDs,NAMED('dPP_CompFDIDs'),EXTEND);
			#END
			OUTPUT(dFDIDs,NAMED('dPP_FDIDs'),EXTEND);
			OUTPUT(dFDIDsAll,NAMED('dPP_FDIDsAll'),EXTEND);
			OUTPUT(dFDIDsPayload,NAMED('dPP_FDIDsPayload'),EXTEND);
			OUTPUT(dPPRecs,NAMED('dPPRecs'),EXTEND);
			OUTPUT(dPPFilterByPhoneThreshold,NAMED('dPPFilterByPhoneThreshold'),EXTEND);
			OUTPUT(dPPCommon,NAMED('dPPCommon'),EXTEND);
			OUTPUT(dPPCommonDedup,NAMED('dPPCommonDedup'),EXTEND);
			OUTPUT(dPPPenalty,NAMED('dPPPenalty'),EXTEND);
		#END

		RETURN dPPPenaltyFilter;
	ENDMACRO;

	EXPORT getSSCDescription(STRING ssc) := FUNCTION
		ssc_out := CASE(ssc,
										Phones.Constants.SSC.Intralata 				=> 'INTRALATA USE ONLY',
										Phones.Constants.SSC.Paging 					=> 'PAGING SERVICES',
										Phones.Constants.SSC.Cellular 				=> 'CELLULAR SERVICES',
										Phones.Constants.SSC.Pseudo800 				=> 'PSEUDO 800 SERVICE CODE',
										Phones.Constants.SSC.Extended 				=> 'EXTENDED/EXPANDED CALLING SCOPE',
										Phones.Constants.SSC.LocalMassCalling => 'LOCAL MASS CALLING CODE',
										Phones.Constants.SSC.NotApplicable 		=> 'N/A',
										Phones.Constants.SSC.Other 						=> 'OTHER',
										Phones.Constants.SSC.Radio 						=> 'TWO-WAY CONVENTIONAL MOBILE RADIO',
										Phones.Constants.SSC.MiscServices 		=> 'MISCELLANEOUS SERVICES',
										Phones.Constants.SSC.Time 						=> 'TIME',
										Phones.Constants.SSC.VOIP 						=> 'VOICE OVER INTERNET PROTOCOL',
										Phones.Constants.SSC.Weather 					=> 'WEATHER',
										Phones.Constants.SSC.Exchange 				=> 'LOCAL EXCHANGE INTRALATA SPECIAL BILLING OPTION',
										Phones.Constants.SSC.SelectiveLocal 	=> 'SELECTIVE LOCAL EXCHANGE INTRALATA SPECIAL BILLING OPTION',
										Phones.Constants.SSC.PRnUSVI 					=> 'PUERTO RICO and U.S. VIRGIN ISLANDS CODES',
										'');
		RETURN ssc_out;

	END;

	EXPORT STRING LineServiceTypeDesc(INTEGER LineServiceType) := CASE(LineServiceType,
		0 => Phones.Constants.PhoneServiceType.Landline,
		1 => Phones.Constants.PhoneServiceType.Wireless,
		2 => Phones.Constants.PhoneServiceType.VoIP,
		Phones.Constants.PhoneServiceType.Other);

	EXPORT GetDIDs(DATASET(DidVille.Layout_Did_OutBatch) dBatchIn, STRING32 ApplicationType='',UNSIGNED1 GLBPurpose,UNSIGNED1 DPPAPurpose) := FUNCTION

		dDIDsbyAcctno	:= didville.did_service_common_function(dBatchIn,appType := ApplicationType,glb_purpose_value:=GLBPurpose,dppa_purpose_value:=DPPAPurpose);

		dBatchInwDID	:= JOIN(dBatchIn, dDIDsbyAcctno,
								LEFT.seq = RIGHT.seq,
								TRANSFORM(DidVille.Layout_Did_OutBatch,
									SELF.did		:= RIGHT.did,
									SELF			:= LEFT,
									SELF:=[]),
								LEFT OUTER,ALL);
		RETURN dBatchInwDID;
	END;

	//Taken from PhonesInfo._Functions. Spoke with Ricardo about this, decided it's best to seperate it to avoid :PERSIST
	EXPORT STRING StandardName(string name):= FUNCTION
		stdName := STD.Str.Filter(STD.Str.ToUpperCase(XMLDECODE(trim(name, left, right))), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		return stdName;
	END;
	EXPORT BOOLEAN isPassZumigo(INTEGER zumigoScore):= FUNCTION
		RETURN	zumigoScore BETWEEN Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MIN AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX;
	END;
	EXPORT BOOLEAN isValidZumigo(INTEGER zumigoScore):= FUNCTION
		RETURN	zumigoScore BETWEEN 0 AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX;
	END;	
	EXPORT GetCleanCompanyName(STRING inputCompanyName) := FUNCTION
		dInputPrep:=DATASET([{1,inputCompanyName}],{UNSIGNED rid; STRING company_name;});
		BIPV2_Company_Names.functions.mac_go(dInputPrep,dsCleanCompanyName,rid,company_name);
		RETURN dsCleanCompanyName[1].cnp_name; 
	END;			

END;