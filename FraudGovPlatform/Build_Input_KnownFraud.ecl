IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared,ut; 
EXPORT Build_Input_KnownFraud(
	 string pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
	,dataset(Layouts.Input.KnownFraud) KnownFraud_Sprayed =  files().Input.KnownFraud.sprayed	
	,dataset(Layouts.Input.KnownFraud) ByPassed_KnownFraud_Sprayed = files().Input.ByPassed_KnownFraud.sprayed	
	,dataset(Layouts.CustomerSettings) pCustomerSettings = files().CustomerSettings
) :=
module
	
	inKnownFraudUpdate := 	
			if	(nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.KnownFraud)) > 0,
				Files(pversion).Sprayed.KnownFraud, 
				dataset([],{string75 fn { virtual(logicalfilename)}, FraudGovPlatform.Layouts.Sprayed.KnownFraud})
			)    											
		+ 	if	(nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.NAC)) > 0, 
				Build_Prepped_NAC(pversion).NACKNFDUpdate,
				dataset([],{string75 fn { virtual(logicalfilename)}, FraudGovPlatform.Layouts.Sprayed.KnownFraud})
			);
	
	Functions.CleanFields(inKnownFraudUpdate ,inKnownFraudUpdateUpper); 
	
	Layouts.Input.knownfraud tr(inKnownFraudUpdateUpper l, integer cnt) := transform

		filename := ut.CleanSpacesAndUpper(l.fn);
		
		self.FileName := filename;	
		
		fn := STD.Str.SplitWords( STD.Str.FindReplace(l.fn,'.dat',''), '_' );
		
		Customer_Account_Number := STD.Str.FindReplace(fn[1],'FRAUDGOV::IN::','');
		Customer_State := fn[2];
		Customer_Agency_Vertical_Type := fn[3]; // ignore
		Customer_Program_fn := fn[4];
		FileType := fn[5]; // ignore 
		FileDate := (unsigned)fn[6];
		FileTime := fn[7];
		MemberID := fn[8];
		InstanceID := fn[9];

		self.Customer_Account_Number := Customer_Account_Number;
		self.Customer_State := Customer_State;
		self.Customer_Agency_Vertical_Type := Customer_Agency_Vertical_Type;
		self.Customer_Program_fn := Customer_Program_fn;
		
		self.ProcessDate := (unsigned)pversion;
		self.FileDate :=FileDate;;
		self.FileTime :=FileTime;
		address_1 := tools.AID_Helpers.fRawFixLine1( trim(l.Street_1) + ' ' +  trim(l.Street_2));
		address_2 := tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(l.city) + if(l.state != '', ', ', '') + trim(l.state)  + ' ' + trim(l.zip)[1..5]));
		self.address_1 := address_1;
		self.address_2 := address_2;
		self.address_id := hash64(address_1 + address_2);
		mailing_address_1 := tools.AID_Helpers.fRawFixLine1( trim(l.Mailing_Street_1) + ' ' + trim(l.Mailing_Street_2));
		mailing_address_2 := tools.AID_Helpers.fRawFixLineLast(  stringlib.stringtouppercase(trim(l.Mailing_City) + if(l.Mailing_State != '', ', ', '') + trim(l.Mailing_State)  + ' ' + trim(l.Mailing_Zip)[1..5]));
		self.mailing_address_1 := mailing_address_1;
		self.mailing_address_2 := mailing_address_2;
		self.mailing_address_id := hash64(mailing_address_1 + mailing_address_2);
		self.raw_full_name := if(l.raw_full_name='', ut.CleanSpacesAndUpper(l.raw_first_name + ' ' + l.raw_middle_name + ' ' + l.raw_last_name), l.raw_full_name);
		self.ind_type 	:= functions.ind_type_fn(Customer_Program_fn);
		self.file_type := 1 ;		
		source_input := map(
			 STD.Str.Contains( l.fn, 'KnownRisk', true) => 'KNFD'
			,STD.Str.Contains( l.fn, 'SafeList', true) => 'SAFELIST'
			,'KNFD');
		self.source_input := source_input;
		SELF.unique_id := 0;
		self:=l;
		self:=[];
	end;

	shared f1:=project(inKnownFraudUpdateUpper, tr(left, counter));

	max_uid := max(KnownFraud_Sprayed, KnownFraud_Sprayed.unique_id) + 1;
	
	MAC_Sequence_Records( f1, unique_id, f1_unique_id, max_uid);
	
	shared rs_unique_id := f1_unique_id;

	shared NotInMbs := join(	
		rs_unique_id,
		MBS_Sprayed(status = 1 and regexfind('DELTA', fdn_file_code, nocase)  = false),
		left.Customer_Account_Number =(string)right.gc_id
		AND	left.customer_State = right.Customer_State
		AND left.file_type = right.file_type //1=events
		AND left.ind_type = right.ind_type //program
		AND (( left.source_input = 'KNFD' and right.confidence_that_activity_was_deceitful != 3 )
			OR ( left.source_input = 'SAFELIST' and right.confidence_that_activity_was_deceitful = 3 )),
		TRANSFORM(Layouts.Input.knownfraud,SELF := LEFT),
		LEFT ONLY,
		LOOKUP);

	shared EnforceValidations := join(
		  rs_unique_id
		, pCustomerSettings
		, left.Customer_Account_Number = right.Customer_Account_Number and 
		  left.Customer_State = right.Customer_State and
		  left.file_type = right.file_type and //3=transactions
		  left.ind_type = right.ind_type and //program
		  right.validate_data = true
		, TRANSFORM(Layouts.Input.knownfraud,SELF := LEFT),INNER, LOOKUP);


	shared f1_errors:=EnforceValidations
		(
				Customer_Account_Number =''
			or 	(Customer_State in FraudGovPlatform_Validation.Mod_Sets.States) = FALSE
			or 	(Customer_Program_fn in FraudGovPlatform_Validation.Mod_Sets.IES_Benefit_Type) = FALSE
			or 	customer_event_id = ''
			or 	reported_date = ''
			or 	reported_time = ''
			or 	reported_by = ''
			// https://jira.rsi.lexisnexis.com/browse/GRP-203
			// 26/Oct/17 Sundeep Commented:
			// lets say we have name and address only but no ssn, dl, lexid, the entire record will be in the payload keys but not in the ssn key, dl key, or the lexid key.
			// The only records that we can truly discard are the ones that dont have a name, address, and any identifying information. 
			// If we get an inquiry with only an IP address and nothing else, we will still keep that inquiry.			
			//
			or (
					(	raw_Full_Name = '' and 
						(raw_First_name = '' or raw_Last_Name='') and 
						(Street_1='' and City='' and State='' and Zip='')
					) and (
						(SSN = '' or length(STD.Str.CleanSpaces(SSN))<>9 or regexfind('^[0-9]*$',STD.Str.CleanSpaces(ssn)) =false) and 
						(Drivers_License_Number='' and Drivers_License_State='') and
						LexID = 0
					) and 
					//DOB = '' and ??
					IP_Address = ''
			)		
		);


	//Exclude Errors
	shared ByPassed_records := NotInMbs + f1_errors;
	f1_bypass_dedup := fn_dedup(ByPassed_KnownFraud_Sprayed + project(ByPassed_records, FraudGovPlatform.Layouts.Input.knownfraud));

	tools.mac_WriteFile(Filenames().Input.ByPassed_KnownFraud.New(pversion),
		f1_bypass_dedup,
		Build_Bypass_Records,
		pCompress	:= true,
		pHeading := false,
		pCsvout := true,
		pSeparator := Constants().validDelimiter,
		pOverwrite := true,
		pTerminator := Constants().validTerminators,
		pQuote:= Constants().validQuotes);


	//Move only Valid Records
	shared f1_dedup :=	join (
		rs_unique_id,
		ByPassed_records,
		left.Customer_Account_Number = right.Customer_Account_Number and
		left.Unique_Id = right.Unique_Id,
		TRANSFORM(Layouts.Input.knownfraud,SELF := LEFT),
		left only);	
																							
	shared new_addresses := Functions.New_Addresses(f1_dedup);

	tools.mac_WriteFile(Filenames().Input.AddressCache_KNFD.New(pversion),
		new_addresses,
		Build_Address_Cache,
		pCompress	:= true,
		pHeading := false,
		pCsvout := true,
		pSeparator := Constants().validDelimiter,
		pOverwrite := true,
		pTerminator := Constants().validTerminators,
		pQuote:= Constants().validQuotes);
									
	dAppendAID := Standardize_Entity.Clean_Address(f1_dedup, new_addresses);
	dappendName := Standardize_Entity.Clean_Name(dAppendAID);	
	dAppendPhone := Standardize_Entity.Clean_Phone (dappendName);
	dAppendLexid := Standardize_Entity.Append_Lexid (dAppendPhone);
	dCleanInputFields := Standardize_Entity.Clean_InputFields (dAppendLexid);	

	input_file_1 := fn_dedup(KnownFraud_Sprayed  + project(dCleanInputFields,Layouts.Input.KnownFraud));

	// Refresh Addresses every 90 days
	IsTimeForRefresh := AddressesInfo(pversion).IsTimeForRefresh;
	dRefreshAID := Standardize_Entity.dRefreshAID(input_file_1);
	input_file_2 := if(	IsTimeForRefresh,
					dRefreshAID,
					input_file_1);  
	// Refresh Lexid when new header is released
	IsNewHeader := HeaderInfo.IsNew;
	dRefreshLexid := Standardize_Entity.dRefreshLexid(input_file_2);
	input_file_3 := if(	IsNewHeader,
					dRefreshLexid,
					input_file_2); 

	tools.mac_WriteFile(Filenames(pversion).Input.KnownFraud.New(pversion),
		input_file_3,
		Build_Input_File,
		pCompress	:= true,
		pHeading := false,
		pCsvout := true,
		pSeparator := Constants().validDelimiter,
		pOverwrite := true,
		pTerminator := Constants().validTerminators,
		pQuote:= Constants().validQuotes);

// Return
	export build_prepped := 
		sequential(
			 Build_Address_Cache
			,Build_Input_File
			,Build_Bypass_Records);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_KnownFraud atribute')  
	);

end;


