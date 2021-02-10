IMPORT PublicRecords_KEL, STD, InsuranceHeader_BestOfBest, Business_Risk_BIP, ut;

EXPORT FnRoxie_Prep_InputPII(DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) Input,
                PublicRecords_KEL.Interface_Options Options) := FUNCTION
	
  ds_input_slim := 
    PROJECT(
      Input,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_Layout_Slim,
        SELF.G_ProcUID := COUNTER,
        SELF := LEFT ));
	
	mytemp := record
		string dl_source;
	end;

	dl_temp := record
		dataset(mytemp) InsuranceSources;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII;
		string verified_dl;
	end;

	InputEcho := PublicRecords_KEL.ECL_Functions.Fn_InputEcho_Roxie( ds_input_slim );	

	cleanInput := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( InputEcho);
		
  // Append LexID
  withLexIDPre := IF(Options.isFCRA, 
		PublicRecords_KEL.ECL_Functions.Neutral_Lexid_Soapcall(cleanInput, Options), //FCRA uses soapcall
		PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanInput, Options ));
		
	withLexID := withLexIDPre(PullIDFlag = False);
	pullidlexids := withLexIDPre(PullIDFlag = true);
		
		
	//only run if phone is on input, nonFCRA only
	//this key is set up like this because we are not able to return PII from this key, we can only use it for phone verification
	CheckBureauPhone := IF(~Options.isFCRA, PublicRecords_KEL.ECL_Functions.FnRoxie_get_bureau_phones(withLexID), withLexID);
	
	//only run if phone is on input, FCRA & nonFCRA 
	CheckTPMPhone := PublicRecords_KEL.ECL_Functions.FnRoxie_Get_TPM_Phones.Consumer(CheckBureauPhone, Options);

	InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Layout_Input into_insurance_input(RECORDOF(CheckTPMPhone) le) := transform
		self.FirstName := le.P_InpClnNameFirst;
		self.LastName := le.P_InpClnNameLast;
		self.DateOfBirth := le.P_InpClnDOB;
		self.DL_St := le.P_InpClnDLState;
		self.Seq := le.G_ProcUID;
		self.dl_number :=le.P_InpClnDL;
		self.did := le.P_LexID;
		self:=le;
	end;

	Slimmed_dl_did :=  GROUP(project(CheckTPMPhone, into_insurance_input(left)),Seq);
	
	//FCRA boolean set inside these functions are not being used in the InsuranceHeader_BestOfBest functions.
	// since the isFCRA booleans passed here do not serve the purpose we made sure that the isFCRA options is checked before returning the results from these Insurance functions
	Insurance_dl_did := InsuranceHeader_BestOfBest.search_Insurance_DL_by_Did(Slimmed_dl_did,options.DPPAPurpose,options.isFCRA, options.Data_Permission_Mask);

	Insurance_dl_dl := InsuranceHeader_BestOfBest.search_Insurance_DL_by_DL(Slimmed_dl_did,options.DPPAPurpose,options.isFCRA, options.Data_Permission_Mask);

	InputPII_Dl_did := JOIN(CheckTPMPhone(P_LexID <> 0), Insurance_dl_did, LEFT.G_ProcUID = RIGHT.Seq, TRANSFORM(dl_temp,
		SELF.InsuranceDLDataUsed := RIGHT.dl_data_used,
		SELF.InsuranceDLNumber := RIGHT.dl_nbr,
		SELF.InsuranceDLState := RIGHT.dl_state,		
		DL_Match := LEFT.P_InpClnDL = RIGHT.dl_nbr;
		Exact_Match := DL_Match AND LEFT.P_InpClnDLState = RIGHT.dl_state;
		verified_rec := Exact_Match OR DL_Match;
		self.verified_dl := if(verified_rec, RIGHT.dl_nbr, ''),//To check if the input parameters matches the insurance records
		SELF.InsuranceSources := dataset([{RIGHT.src}], mytemp),
		SELF := LEFT)); // Append the Insurance DL Did Verification Results to the RepInput Dataset

	InputPII_Dl := JOIN(CheckTPMPhone(P_LexID = 0), Insurance_dl_dl, LEFT.G_ProcUID = RIGHT.Seq, TRANSFORM(dl_temp,
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

	InputPII_did_dl := InputPII_Dl_did + InputPII_Dl; 

	dl_temp roll_dl(dl_temp le, dl_temp rt) := transform
		// count a blank as already seen so it doesn't get added
		source_already_seen := rt.InsuranceSources[1].dl_source='' or rt.InsuranceSources[1].dl_source in set(le.InsuranceSources, dl_source);
		// don't add the same source to the list more than once
		self.InsuranceSources := le.InsuranceSources + if(~source_already_seen, rt.InsuranceSources);																	
		self.InsuranceDLDataUsed := le.InsuranceDLDataUsed or rt.InsuranceDLDataUsed;
		self := rt;
	end;

	InputPII_pre := rollup(group(sort(InputPII_did_dl, G_ProcUID, -verified_dl), G_ProcUID), true, roll_dl(left,right)); //Rollup to avoid duplicates and pick the verified DL's

	InputPII_NonFCRA := project(InputPII_pre, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
	deduped_dl_sources := dedup(sort(left.InsuranceSources, dl_source), dl_source);
	self.InsuranceSource := Business_Risk_BIP.Common.convertDelimited(deduped_dl_sources, dl_source, Business_Risk_BIP.Constants.FieldDelimiter);
	self := left));
//Check isFCRA to return the insurance DL data only for NonFCRA query
	InputPII := IF(~Options.isFCRA, UNGROUP(InputPII_NonFCRA), CheckTPMPhone); 


	FinalPII := project(InputPII, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
			temp_age :=  if(~options.IncludeMinors AND (integer)left.P_InpClnDOB != 0, 
														(integer)ut.Age((unsigned)left.P_InpClnDOB, (unsigned)left.P_InpClnArchDt),0);	//remove minors if Includeminors is FALSE
			SELF.PI_InpDOBAgeIsMinorFlag  := IF(~options.IncludeMinors AND temp_age >= 0 AND temp_age <= options.upperage,TRUE, FALSE);//remove minors if Includeminors is FALSE
			self := left));

 RETURN FinalPII+pullidlexids;
 
 END;				