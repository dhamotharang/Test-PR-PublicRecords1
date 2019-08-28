IMPORT Address, Risk_Indicators, Models, RiskWise, ut, gateway, STD;

EXPORT LeadIntegrity_Search_Function(
														DATASET(Models.Layout_LeadIntegrity_In) indata,
														UNSIGNED1 GLBPurpose,
														UNSIGNED1 DPPAPurpose,
														UNSIGNED3 historyDate,
														STRING50 DataRestriction = Risk_Indicators.iid_constants.default_DataRestriction,
														unsigned1 attributesVersion,
														STRING16 modelName,
														BOOLEAN DisableDoNotMailMask = FALSE,
														STRING50 DataPermission = Risk_Indicators.iid_constants.default_DataPermission,
                            dataset(Gateway.Layouts.Config) gateways =  dataset([],Gateway.Layouts.Config),
                            unsigned1 ofac_version = 1,
                            unsigned1 LexIdSourceOptout = 1,
                            string TransactionID = '',
                            string BatchUID = '',
                            unsigned6 GlobalCompanyId = 0
													) := FUNCTION

/* ***************************************
	 *            Clean Input:             *
   *************************************** */
	AccountNumber := indata[1].AccountNumber; // There should only be 1 record
	 
	risk_indicators.Layout_Input intoInput(Models.Layout_LeadIntegrity_In le) := TRANSFORM
		cleanDOB := RiskWise.cleanDOB(le.DateOfBirth);
		cleanDLNum := RiskWise.cleanDL_Num(le.DLNumber);

		self.DID := le.did; 
		self.score := if(self.did<>0, 100, 0);
		
		SELF.seq := (INTEGER)le.Seq;	
		SELF.ssn := IF(le.SSN='000000000', '', le.SSN);	// blank out social if it is all 0's
		SELF.dob := cleanDOB;
		SELF.age := IF(TRIM(cleanDOB) = '', '', (STRING3)ut.Age((INTEGER)cleanDOB));
	
		SELF.phone10 := le.HomePhone;
		SELF.wphone10 := le.WorkPhone;
	
		SELF.fname := STD.Str.ToUpperCase(le.FirstName);
		SELF.mname := STD.Str.ToUpperCase(le.MiddleName);
		SELF.lname := STD.Str.ToUpperCase(le.LastName);
		SELF.suffix := STD.Str.ToUpperCase(le.SuffixName);
	
		clean_addr := risk_indicators.MOD_AddressClean.clean_addr(le.streetAddr, le.City, le.State, le.Zip) ;											
	
		SELF.in_streetAddress := le.streetAddr;
		SELF.in_city := le.City;
		SELF.in_state := le.State;
		SELF.in_zipCode := le.Zip;
		SELF.in_country := le.Country;

		SELF.prim_range := Address.CleanFields(clean_addr).prim_range;
		SELF.predir := Address.CleanFields(clean_addr).predir;
		SELF.prim_name := Address.CleanFields(clean_addr).prim_name;
		SELF.addr_suffix := Address.CleanFields(clean_addr).addr_suffix;
		SELF.postdir := Address.CleanFields(clean_addr).postdir;
		SELF.unit_desig := Address.CleanFields(clean_addr).unit_desig;
		SELF.sec_range := Address.CleanFields(clean_addr).sec_range;
		SELF.p_city_name := Address.CleanFields(clean_addr).p_city_name;
		SELF.st := Address.CleanFields(clean_addr).st;
		SELF.z5 := Address.CleanFields(clean_addr).zip;
		SELF.zip4 := Address.CleanFields(clean_addr).zip4;
		SELF.lat := Address.CleanFields(clean_addr).geo_lat;
		SELF.long := Address.CleanFields(clean_addr).geo_long;
		SELF.addr_type := Address.CleanFields(clean_addr).rec_type[1];
		SELF.addr_status := Address.CleanFields(clean_addr).err_stat;
		SELF.county := Address.CleanFields(clean_addr).county[3..5]; // we only want the county fips, not all 5.  first 2 are the state fips
		SELF.geo_blk := Address.CleanFields(clean_addr).geo_blk;
	
		SELF.dl_number := STD.Str.ToUpperCase(cleanDLNum);
		SELF.dl_state := STD.Str.ToUpperCase(le.DLState);
		self.historydate := historydate;
		SELF := [];
	END;
	
	cleanIn := project(indata, intoInput(LEFT));
		
/* ***************************************
	 *     Set Boca Shell Parameters:      *
   *************************************** */
	bsVersionTemp := IF(attributesVersion >= 4, 41, attributesVersion); // Attributes 4.1 return iBehavior attributes which requires Boca Shell 4.1 (41)
	UNSIGNED1 bsVersion := max(
		bsVersionTemp,
		map(
			// modelname is already lowercase
			modelname in ['msn1106_0', 'msn1210_1'] => 4,
			3
		)
	);
	BOOLEAN includeDLverification := IF(attributesVersion >= 4, TRUE, FALSE);
	BOOLEAN	require2Ele := FALSE;
	BOOLEAN isLn := FALSE;
	BOOLEAN doRelatives := TRUE;
	BOOLEAN doDL := FALSE;
	BOOLEAN doVehicle := FALSE;
	BOOLEAN doDerogs := TRUE;
	BOOLEAN suppressNearDups := FALSE;
	BOOLEAN fromBIID := FALSE;
	BOOLEAN isFCRA := FALSE;
	BOOLEAN fromIT1O := FALSE;
	BOOLEAN doScore := FALSE;
	BOOLEAN nugen := TRUE;
	BOOLEAN isUtility := FALSE;
	BOOLEAN ofacOnly := FALSE;
	BOOLEAN include_ofac := IF(attributesVersion >= 4, TRUE, FALSE);
	UNSIGNED1 ofacVersion := map(attributesVersion >= 4 and ofac_version = 4 => 4,
                               attributesVersion >= 4 => 2, 
                                                         1);
	BOOLEAN includeAdditionalWatchlists := IF(attributesVersion >= 4, TRUE, FALSE);
  REAL    global_watchlist_threshold := if(ofacVersion in [1, 2, 3], 0.84, 0.85);
	BOOLEAN excludeWatchlists := IF(attributesVersion >= 4, FALSE, TRUE); // Attributes 4.1 return a watchlist hit, so don't exclude watchlists
	// For ITA we can't use FARES Data
	BOOLEAN filterOutFares := TRUE;
	gateways_BS := if(ofacVersion = 4 and attributesVersion >= 4, gateways, Gateway.Constants.void_gateway);
	append_best := if( modelname in ['msn1106_0', 'msn1210_1'] or attributesVersion >= 4, 2, 0 );
	unsigned8 BSOptions := IF(attributesVersion >= 4, risk_indicators.iid_constants.BSOptions.IncludeDoNotMail + 
																										risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
																										risk_indicators.iid_constants.BSOptions.IncludeDoNotMail);

/* ***************************************
	 *     Gather Boca Shell Results:      *
   *************************************** */
	iid := Risk_Indicators.InstantID_Function(cleanIn, gateways_BS, DPPAPurpose, GLBPurpose, isUtility, isLn, ofacOnly, 
																					suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, include_ofac, includeAdditionalWatchlists, global_watchlist_threshold,
																					in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions,
																					in_DataPermission := DataPermission,
                                                                                    LexIdSourceOptout := LexIdSourceOptout, 
                                                                                    TransactionID := TransactionID, 
                                                                                    BatchUID := BatchUID, 
                                                                                    GlobalCompanyID := GlobalCompanyID);

	clam := Risk_Indicators.Boca_Shell_Function(iid, gateways_BS, DPPAPurpose, GLBPurpose, isUtility, isLn, doRelatives, doDL, 
																						doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																						BSOptions := BSOptions, DataPermission := DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                                        TransactionID := TransactionID, 
                                                                                        BatchUID := BatchUID, 
                                                                                        GlobalCompanyID := GlobalCompanyID);

/* ***************************************
	 *       Gather ITA Attributes:        *
   *************************************** */
	ita := Models.get_LeadIntegrity_Attributes(clam, attributesVersion);

/* ***************************************
	 *    Suppress the Do Not Mail List:   *
   *************************************** */
	models.layouts.layout_LeadIntegrity_attributes_batch dnmSuppression( cleanIn le, clam ri ) := TRANSFORM
		dnm := if( risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsDoNotMail, ri.iid.iid_flags), '1', '0' );
		self.DoNotMail := dnm; 
		self.Version4.DoNotMail := dnm;
		self.seq := (string)le.seq;
    self.did := ri.did;
		self := [];
	END;
	suppressedDoNotMail := join(cleanIn, clam, left.seq=right.seq, dnmSuppression(left,right), keep(1), left outer );

	withDNM := JOIN(ita, suppressedDoNotMail, LEFT.seq=RIGHT.seq,
		TRANSFORM(models.layouts.layout_LeadIntegrity_attributes_batch,
			SELF.acctno := AccountNumber;
			SELF.DoNotMail := RIGHT.DoNotMail;
			SELF.Version4.DoNotMail := RIGHT.Version4.DoNotMail;
			SELF := IF(RIGHT.DoNotMail='1' AND DisableDoNotMailMask = FALSE, RIGHT, LEFT)
		)
	);

/* ***************************************
	 *  Gather Model Scores/Reason Codes:  *
   *************************************** */
	
	// model := UNGROUP(Models.MSN1210_1_0(clam, ita));
	model := CASE(TRIM(modelName),
		'anmk909_0' => UNGROUP(Models.ANMK909_0_1(clam)),
		'msn1106_0' => UNGROUP(Models.MSN1106_0_0(clam)),
		'msn1210_1' => UNGROUP(Models.MSN1210_1_0(clam, ita)),
		''          => DATASET([], Models.Layout_ModelOut),
		FAIL(Models.Layout_ModelOut, 'Invalid model name requested')
	);

	Models.Layouts.layout_LeadIntegrity_Attributes_Batch addScore(withDNM le, model ri) := TRANSFORM
		// LI4 requirements state a 210 score override is thrown for DoNotMail hits.
		override210 := Risk_Indicators.rcSet.isCodeFM(le.DoNotMail) and modelname in ['msn1106_0', 'msn1210_1'];

		self.scorename1 := STD.Str.ToUpperCase(trim(modelname));
		self.score1  := if( override210, '210', ri.score );
		self.reason1 := if( override210, 'FM', ri.ri[1].hri );
		SELF.reason2 := if( override210, '00', ri.ri[2].hri );
		SELF.reason3 := if( override210, '00', ri.ri[3].hri );
		SELF.reason4 := if( override210, '00', ri.ri[4].hri );
		SELF.reason5 := if(modelname = 'msn1210_1' AND override210, '00', ri.ri[5].hri ); // Only MSN1210_1 currently allows for 6 reason codes
		SELF.reason6 := if(modelname = 'msn1210_1' AND override210, '00', ri.ri[6].hri );
		SELF := le;
	END;

	withModel := JOIN(withDNM, model, (INTEGER)LEFT.seq=RIGHT.seq, addScore(LEFT, RIGHT), FULL OUTER);

	RETURN(withModel);

END;
