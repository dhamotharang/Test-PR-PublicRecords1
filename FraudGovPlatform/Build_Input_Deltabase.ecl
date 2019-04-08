IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared, ut;
EXPORT Build_Input_Deltabase(
	 string pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
	,dataset(Layouts.Input.Deltabase) Deltabase_Sprayed =  files().Input.Deltabase.sprayed	
	,dataset(Layouts.Input.Deltabase) ByPassed_Deltabase_Sprayed = files().Input.ByPassed_Deltabase.sprayed	
	,dataset(Layouts.CustomerSettings) pCustomerSettings = files().CustomerSettings
) :=
module

	deltabaseUpdate :=	if ( nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.Deltabase)) > 0,
		Files(pversion).Sprayed.Deltabase, 
		dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.Deltabase}));

	Functions.CleanFields(deltabaseUpdate ,deltabaseUpdateUpper); 

	Layouts.Input.Deltabase tr(deltabaseUpdateUpper l) := transform
		sub:=stringlib.stringfind(l.fn,'20',1);
		sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
		FileDate := (unsigned)l.fn[sub..sub+7];
		FileTime := ut.CleanSpacesAndUpper(l.fn[sub2..sub2+5]);
		self.FileName := l.fn;
		self.ProcessDate := (unsigned)pversion;
		self.FileDate := FileDate;
		self.FileTime := FileTime;
		address_1 := tools.AID_Helpers.fRawFixLine1( trim(l.Street_1));
		address_2 := tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(l.city) + if(l.state != '', ', ', '') + trim(l.state)  + ' ' + trim(l.zip)[1..5]));
		self.address_1 := address_1;
		self.address_2 := address_2;
		self.address_id := hash64(address_1 + address_2);
		mailing_address_1 := tools.AID_Helpers.fRawFixLine1( trim(l.Mailing_Street_1));
		mailing_address_2 := tools.AID_Helpers.fRawFixLineLast(  stringlib.stringtouppercase(trim(l.Mailing_City) + if(l.Mailing_State != '', ', ', '') + trim(l.Mailing_State)  + ' ' + trim(l.Mailing_Zip)[1..5]));
		self.mailing_address_1 := mailing_address_1;
		self.mailing_address_2 := mailing_address_2;
		self.mailing_address_id := hash64(mailing_address_1 + mailing_address_2);
		self.raw_full_name := if(l.raw_full_name='', ut.CleanSpacesAndUpper(l.raw_first_name + ' ' + l.raw_middle_name + ' ' + l.raw_last_name), l.raw_full_name);
		self.cell_phone := '';
		self.ind_type 	:= functions.ind_type_fn(l.Customer_Program);
		source_input := if (l.inquiry_source = '', 'Deltabase','Deltabase-' + l.inquiry_source);
		self.source_input := source_input;
		SELF.unique_id := 0;
		self:=l;
		self:=[];
	end;

	shared f1:=project(deltabaseUpdateUpper,tr(left));


	max_uid := max(Deltabase_Sprayed, Deltabase_Sprayed.unique_id) + 1;

	MAC_Sequence_Records( f1, unique_id, f1_unique_id, max_uid);
	
	shared rs_unique_id := f1_unique_id;
	
	shared MBS_Deltabase	:= MBS_Sprayed(status = 1 and regexfind('DELTA', fdn_file_code, nocase));

	shared NotInMbs := join(
		rs_unique_id,
		MBS_Deltabase,
		left.Customer_Account_Number =(string)right.gc_id,
		TRANSFORM(Layouts.Input.Deltabase,SELF := LEFT),LEFT ONLY, lookup);


	shared EnforceValidations := join(
		  rs_unique_id
		, pCustomerSettings
		, left.Customer_Account_Number = right.Customer_Account_Number and 
		  left.Customer_State = right.Customer_State and
		  left.file_type = right.file_type and //3=transactions
		  left.ind_type = right.ind_type and //program
		  right.validate_data = true
		, TRANSFORM(Layouts.Input.Deltabase,SELF := LEFT),INNER, LOOKUP);

	
	shared f1_errors:=EnforceValidations
		(Customer_Account_Number = '' or reported_date = '' or file_type = 0
			or 	(Customer_Program in FraudGovPlatform_Validation.Mod_Sets.IES_Benefit_Type) = FALSE	);


	EXPORT fn_dedup_delta(inputs):=FUNCTIONMACRO
		in_dst := DISTRIBUTE(inputs, InqLog_ID);
		in_srt := sort(in_dst , InqLog_ID, -ProcessDate, -did, -clean_address.err_stat,local);

		{inputs} RollupUpdate({inputs} l, {inputs} r) := 
		transform
			SELF.Unique_Id := if(l.Unique_Id < r.Unique_Id,l.Unique_Id, r.Unique_Id); // leave always previous Unique_Id 
			self := l;
		end;

		in_ddp := rollup( in_srt
			,RollupUpdate(left, right)
			,InqLog_ID
			,local
		);
		return in_ddp;
	ENDMACRO;
	//Exclude Errors
	shared ByPassed_records := NotInMbs + f1_errors;
	f1_bypass_dedup := fn_dedup_delta(ByPassed_Deltabase_Sprayed + project(ByPassed_records,FraudGovPlatform.Layouts.Input.Deltabase)); 
	
	tools.mac_WriteFile(Filenames().Input.ByPassed_Deltabase.New(pversion),
		f1_bypass_dedup,
		Build_Bypass_Records,
		pCompress	:= true,
		pHeading := false,
		pCsvout := true,
		pSeparator := Constants().validDelimiter,
		pOverwrite := true,
		pTerminator := Constants().validTerminators,
		pQuote := Constants().validQuotes);
									
	//Move only Valid Records
	shared Valid_Recs :=	join (	
		rs_unique_id,
		ByPassed_records,
		left.Unique_Id = right.Unique_Id,
		TRANSFORM(Layouts.Input.Deltabase,SELF := LEFT),
		left only);
																							

	shared new_addresses := Functions.New_Addresses(Valid_Recs);

	tools.mac_WriteFile(Filenames().Input.AddressCache_Deltabase.New(pversion),
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
	
	input_file_1 := fn_dedup_delta(Deltabase_Sprayed  + project(dCleanInputFields,Layouts.Input.Deltabase)); 

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

	tools.mac_WriteFile(Filenames(pversion).Input.Deltabase.New(pversion),
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
				,Build_Bypass_Records 
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_Deltabase atribute')
	);

end;


