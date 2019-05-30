IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared,ut,_Validate; 
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
		st := StringLib.SplitWords( StringLib.StringFindReplace(filename, '.dat',''), '::', true )[3][1..2];
		self.FileName := filename;	
		fn := map(	
					regexfind('MSH',filename,nocase) => [(string)MBS_Mappings( contribution_source = 'NAC' and file_type = 1 and customer_state = st)[1].Customer_Account_Number, 
														 MBS_Mappings( contribution_source = 'NAC' and file_type = 1 and customer_state = st)[1].Customer_State, 
														 MBS_Mappings( contribution_source = 'NAC' and file_type = 1 and customer_state = st)[1].Customer_Agency_Vertical_Type, 
														 MBS_Mappings( contribution_source = 'NAC' and file_type = 1 and customer_state = st)[1].Customer_Program; 
														 'MSH', 
														 trim(regexfind('([0-9])+_([0-9])\\w+',FileName, 0)[1..8]), 
														 trim(regexfind('([0-9])+_([0-9])\\w+',FileName, 0)[10..15]),
														 '',
														 ''],
					StringLib.SplitWords( StringLib.StringFindReplace(filename, '.dat',''), '_', true )
		);
		

		Customer_Account_Number := STD.Str.FindReplace(fn[1],'FRAUDGOV::IN::','');
		Customer_State := fn[2];
		Customer_Agency_Vertical_Type := fn[3];
		Customer_Program_fn := fn[4];
		FileType := fn[5];
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
	
	shared rs_unique_id := distribute(f1_unique_id,hash(unique_id));

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

	shared f1_errors:=rs_unique_id
		(
			customer_event_id = ''
			or (_Validate.Date.fIsValid(reported_date) = false  or (unsigned)reported_date > (unsigned)(STRING8)Std.Date.Today())
			or 	reported_time = ''
			or 	reported_by = ''
		);


	//Exclude Errors
	shared f1_bypass_dedup:= fn_dedup(ByPassed_KnownFraud_Sprayed + PROJECT(NotInMbs + f1_errors,FraudGovPlatform.Layouts.Input.KnownFraud));
	
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
	shared Valid_Recs :=	join (
		rs_unique_id,
		f1_bypass_dedup,
		left.Unique_Id = right.Unique_Id,
		TRANSFORM(Layouts.Input.knownfraud,SELF := LEFT),
		left only);	
																							
	shared new_addresses := Functions.New_Addresses(Valid_Recs);

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
									
	dAppendAID := Standardize_Entity.Clean_Address(Valid_Recs, new_addresses);
	dappendName := Standardize_Entity.Clean_Name(dAppendAID);	
	dAppendPhone := Standardize_Entity.Clean_Phone (dappendName);
	dAppendLexid := Standardize_Entity.Append_Lexid (dAppendPhone);
	dCleanInputFields := Standardize_Entity.Clean_InputFields (dAppendLexid);	

	input_file_1 := fn_dedup(KnownFraud_Sprayed  + project(dCleanInputFields,Layouts.Input.KnownFraud));

	// Refresh Addresses every 90 days
	// IsTimeForRefresh := AddressesInfo(pversion).IsTimeForRefresh;
	// dRefreshAID := Standardize_Entity.dRefreshAID(input_file_1);
	// input_file_2 := if(	IsTimeForRefresh, dRefreshAID,input_file_1);  
	// Refresh Lexid when new header is released
	// IsNewHeader := HeaderInfo.IsNew;
	// dRefreshLexid := Standardize_Entity.dRefreshLexid(input_file_2);
	// input_file_3 := if(IsNewHeader, dRefreshLexid, input_file_2); 

	tools.mac_WriteFile(
		Filenames(pversion).Input.KnownFraud.New(pversion),
		input_file_1,
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


