IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared, ut;
EXPORT Build_Input_IdentityData(
	 string pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
	,dataset(Layouts.OutputF.SkipModules) pSkipModules = FraudGovPlatform.Files().OutputF.SkipModules
	,dataset(Layouts.Input.IdentityData) IdentityData_Sprayed =  files().Input.IdentityData.sprayed	
	,dataset(Layouts.Input.IdentityData) ByPassed_IdentityData_Sprayed = files().Input.ByPassed_IdentityData.sprayed
	,boolean PSkipValidations = false	 
) :=
module

	shared SkipNACBuild := pSkipModules[1].SkipNACBuild;
	shared SkipInquiryLogsBuild := pSkipModules[1].SkipInquiryLogsBuild;

	SHARED fn_dedup(inputs):=FUNCTIONMACRO
		in_srt:=sort(inputs, RECORD, EXCEPT processdate);
		in_ddp:=rollup(in_srt,
		TRANSFORM(Layouts.Input.IdentityData,SELF := LEFT; SELF := []),
		RECORD,
		EXCEPT ProcessDate,
		LOCAL);	
		return in_ddp;
	ENDMACRO;
	
	inIdentityDataUpdate :=	  if( nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.IdentityData)) > 0, 
		Files(pversion).Sprayed.IdentityData, 
		dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.IdentityData})
		)   
		+ if (nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.NAC)) > 0 and SkipNACBuild = false, 
				Build_Prepped_NAC(pversion).NACIDDTUpdate,
				dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.IdentityData})
		)
		+ if (nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.InquiryLogs)) > 0 and SkipInquiryLogsBuild = false, 
				Build_Prepped_InquiryLogs(pversion),
				dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.IdentityData})
		);

	Functions.CleanFields(inIdentityDataUpdate ,inIdentityDataUpdateUpper); 

	max_uid := max(IdentityData_Sprayed, IdentityData_Sprayed.unique_id) :	global;

	Layouts.Input.IdentityData tr(inIdentityDataUpdateUpper l, integer cnt) := transform
		sub:=stringlib.stringfind(l.fn,'20',1);
		sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
		FileDate := (unsigned)l.fn[sub..sub+7];
		FileTime := ut.CleanSpacesAndUpper(l.fn[sub2..sub2+5]);
		self.FileName := l.fn;
		self.ProcessDate := (unsigned)pversion;
		self.FileDate := if(FileDate>20130000,FileDate,self.ProcessDate);
		self.FileTime := FileTime;
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
		self.ind_type 	:= functions.ind_type_fn(l.Customer_Program);
		self.file_type := 3 ;
		source_input := if (l.source_input = '', 'IDDT',l.source_input);
		self.source_input := source_input;
		SELF.unique_id := max_uid + cnt; 
		self.Deltabase := 0;
		self:=l;
		self:=[];
	end;

	shared f1:=project(inIdentityDataUpdateUpper,tr(left, counter));
	
	f1_errors:=f1
		((	 
				Customer_Account_Number = ''
			or	Customer_County = ''
			or 	(LexID = 0 and raw_Full_Name = '' and (raw_First_name = '' or raw_Last_Name=''))
			or 	((SSN = '' or length(STD.Str.CleanSpaces(SSN))<>9 or regexfind('^[0-9]*$',STD.Str.CleanSpaces(ssn)) =false) and (Drivers_License_Number='' and Drivers_License_State='') and LexID = 0)
			or 	(Street_1='' and City='' and State='' and Zip='')
			or 	(Customer_State in FraudGovPlatform_Validation.Mod_Sets.States) = FALSE
			or 	(Customer_Agency_Vertical_Type in FraudGovPlatform_Validation.Mod_Sets.Agency_Vertical_Type) = FALSE
			or 	(Customer_Program in FraudGovPlatform_Validation.Mod_Sets.IES_Benefit_Type) = FALSE				
		) and PSkipValidations = false);
	
	NotInMbs := join(	f1,
					MBS_Sprayed(status = 1),
					left.Customer_Account_Number =(string)right.gc_id and
					left.file_type = right.file_type and
					left.ind_type = right.ind_type and
					left.customer_State = right.Customer_State and
					left.Customer_County = right.Customer_County and 	
					left.Customer_Agency_Vertical_Type = right.Customer_Vertical,
					TRANSFORM(Layouts.Input.IdentityData,SELF := LEFT),LEFT ONLY, lookup);

	//Exclude Errors
	shared ByPassed_records := f1_errors + NotInMbs;
	f1_bypass_dedup := ByPassed_IdentityData_Sprayed + project(ByPassed_records,FraudGovPlatform.Layouts.Input.IdentityData);
	
	tools.mac_WriteFile(Filenames().Input.ByPassed_IdentityData.New(pversion),
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
	shared f1_dedup :=	join (	f1,
							ByPassed_records,
							left.Unique_Id = right.Unique_Id,
							TRANSFORM(Layouts.Input.IdentityData,SELF := LEFT),
							left only);
																						
	shared new_addresses := Functions.New_Addresses(f1_dedup);

	tools.mac_WriteFile(Filenames().Input.AddressCache_IDDT.New(pversion),
		new_addresses,
		Build_Address_Cache,
		pCompress := true,
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
	
	input_file_1 := fn_dedup(IdentityData_Sprayed  + project(dCleanInputFields,Layouts.Input.IdentityData));

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

	tools.mac_WriteFile(Filenames(pversion).Input.IdentityData.New(pversion),
		input_file_3,
		Build_Input_File,
		pCompress := true,
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
		,output('No Valid version parameter passed, skipping Build_Input_IdentityData atribute')
	);

end;


