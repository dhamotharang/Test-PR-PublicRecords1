IMPORT PublicRecords_KEL, STD, InsuranceHeader_BestOfBest, Business_Risk_BIP;

EXPORT FnRoxie_Prep_InputRepPII(DATASET(PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout) Input,
                PublicRecords_KEL.Interface_Options Options) := FUNCTION
		
	// Get the 5 Rep's information into a dataset with unique RepNumbers	
	echoReps := SORT(PublicRecords_KEL.ECL_Functions.Fn_InputEchoBusReps_Roxie( Input ), G_ProcBusUID);
	
	// cleanReps
	cleanReps := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( echoReps );	
	
	// Append Rep LexIDs
	withRepLexIDsPre := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanReps, Options );

	withRepLexIDs := withRepLexIDsPre(PullIDFlag = False);
	pullidlexids := withRepLexIDsPre(PullIDFlag = true);

	//only run if phone is on input, nonFCRA only
	//this key is set up like this because we are not able to return PII from this key, we can only use it for phone verification
	CheckBureauPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_get_bureau_phones(withRepLexIDs);
	
	//only run if phone is on input, FCRA & nonFCRA 
	CheckTPMPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_Get_TPM_Phones.Consumer(CheckBureauPhone, Options);
	
	mytemp := record
		string dl_source;
	end;

	dl_temp := record
		dataset(mytemp) InsuranceSources;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII;
		string verified_dl;
	end;
	
	InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Layout_Input into_insurance_input(RECORDOF(CheckTPMPhone) le) := transform
		self.FirstName := le.P_InpClnNameFirst;
		self.LastName := le.P_InpClnNameLast;
		self.DateOfBirth := le.P_InpClnDOB;
		self.DL_St := le.P_InpClnDL;
		self.Seq := le.G_ProcBusUID;
		self.dl_number :=le.P_InpClnDLState;
		self.did := le.P_LexID;
		self:=le;
	end;
	Slimmed_dl_did :=  GROUP(PROJECT(CheckTPMPhone, into_insurance_input(left)),Seq);
	//FCRA boolean set inside these functions are not being used in the InsuranceHeader_BestOfBest functions.
	// since the isFCRA booleans passed here do not serve the purpose we made sure that the isFCRA options is checked before returning the results from these Insurance functions
	Insurance_dl_did := InsuranceHeader_BestOfBest.search_Insurance_DL_by_Did(Slimmed_dl_did,options.DPPAPurpose,options.isFCRA, options.Data_Permission_Mask);

	Insurance_dl_dl := InsuranceHeader_BestOfBest.search_Insurance_DL_by_DL(Slimmed_dl_did,options.DPPAPurpose,options.isFCRA, options.Data_Permission_Mask);

	RepInput_Dl_did := JOIN(CheckTPMPhone(P_LexID <> 0), Insurance_dl_did, LEFT.G_ProcBusUID = RIGHT.Seq, TRANSFORM(dl_temp,
		SELF.InsuranceDLDataUsed := RIGHT.dl_data_used,
		SELF.InsuranceDLNumber := RIGHT.dl_nbr,
		SELF.InsuranceDLState := RIGHT.dl_state,
		DL_Match := LEFT.P_InpClnDL = RIGHT.dl_nbr;
		Exact_Match := DL_Match AND LEFT.P_InpClnDLState = RIGHT.dl_state;
		verified_rec := Exact_Match OR DL_Match;
		self.verified_dl := if(verified_rec, RIGHT.dl_nbr, ''),//To check if the input parameters matches the insurance records
		SELF.InsuranceSources := dataset([{RIGHT.src}], mytemp),
		SELF := LEFT)); // Append the Insurance DL Did Verification Results to the RepInput Dataset

	RepInput_Dl := JOIN(CheckTPMPhone(P_LexID = 0), Insurance_dl_dl, LEFT.G_ProcBusUID = RIGHT.Seq, TRANSFORM(dl_temp,
		SELF.InsuranceDLDataUsed := RIGHT.dl_data_used,
		SELF.InsuranceDLNumber := RIGHT.dl_nbr,
		SELF.InsuranceDLState := RIGHT.dl_state,
		DL_Match := LEFT.P_InpClnDL = RIGHT.dl_nbr AND LEFT.P_InpClnDLState = RIGHT.dl_state;
		DL_Name_Match := LEFT.P_InpClnNameFirst = RIGHT.fname AND LEFT.P_InpClnNameLast = RIGHT.lname;
		Exact_Match := DL_Match AND DL_Name_Match;
		verified_rec := DL_Match OR Exact_Match;
		self.verified_dl := if(verified_rec, RIGHT.dl_nbr, ''), //To check if the input parameters matches the insurance records
		SELF.InsuranceSources := dataset([{RIGHT.src}], mytemp),
		SELF := LEFT)); // Append the Insurance DL Verification Results to the RepInput Dataset

	RepInput_Did_DL := RepInput_Dl_did + RepInput_Dl;

	dl_temp roll_dl(dl_temp le, dl_temp rt) := transform
		// count a blank as already seen so it doesn't get added
		source_already_seen := rt.InsuranceSources[1].dl_source='' or rt.InsuranceSources[1].dl_source in set(le.InsuranceSources, dl_source);
		// don't add the same source to the list more than once
		self.InsuranceSources := le.InsuranceSources + if(~source_already_seen, rt.InsuranceSources);																	
		self.InsuranceDLDataUsed := le.InsuranceDLDataUsed or rt.InsuranceDLDataUsed;
		self := rt;
	end;

	RepInput_pre := rollup(group(sort(RepInput_Did_DL, G_ProcBusUID, RepNumber, -verified_dl), G_ProcBusUID, RepNumber), true, roll_dl(left,right)); //Rollup to avoid duplicates and pick the verified DL's
	
	RepInput_NonFCRA := project(RepInput_pre, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
	deduped_dl_sources := dedup(sort(left.InsuranceSources, dl_source), dl_source);
	self.InsuranceSource := Business_Risk_BIP.Common.convertDelimited(deduped_dl_sources, dl_source, Business_Risk_BIP.Constants.FieldDelimiter);
	self := left));
	//Check isFCRA to return the insurance DL data only for NonFCRA query
	RepInput := IF(~Options.isFCRA, UNGROUP(RepInput_NonFCRA), CheckTPMPhone); 

	RETURN RepInput+pullidlexids;
	
END;									