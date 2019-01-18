IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared,ut;
EXPORT Build_Input_KnownFraud(
	 string		pversion
	,dataset(Layouts.OutputF.SkipModules) pSkipModules = FraudGovPlatform.Files().OutputF.SkipModules
	,boolean	PSkipValidations = false
) :=
module

	shared SkipNACBuild := pSkipModules[1].SkipNACBuild;

	SHARED fn_dedup(inputs):=FUNCTIONMACRO
		in_srt:=sort(inputs, RECORD, EXCEPT processdate);
		in_ddp:=rollup(in_srt,
								TRANSFORM(Layouts.Input.KnownFraud,SELF := LEFT; SELF := []),
								RECORD,
								EXCEPT ProcessDate,
								LOCAL);	
		return in_ddp;
	ENDMACRO;
	
	inKnownFraudUpdate := 	if	(nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.KnownFraud)) > 0, 
													Files(pversion).Sprayed.KnownFraud, 
													dataset([],{string75 fn { virtual(logicalfilename)},		FraudGovPlatform.Layouts.Sprayed.KnownFraud})
										)    											
									+ 	if	(nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.NAC)) > 0 and SkipNACBuild = false, 
													Build_Prepped_NAC(pversion).NACKNFDUpdate,
													dataset([],{string75 fn { virtual(logicalfilename)}, 	FraudGovPlatform.Layouts.Sprayed.KnownFraud})
										);
	
	Functions.CleanFields(inKnownFraudUpdate ,inKnownFraudUpdateUpper); 
	
	Layouts.Input.knownfraud tr(inKnownFraudUpdateUpper l) := transform
		sub:=stringlib.stringfind(l.fn,'20',1);
		sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
		FileDate := (unsigned)l.fn[sub..sub+7];
		FileTime := ut.CleanSpacesAndUpper(l.fn[sub2..sub2+5]);
		self.FileName := l.fn;
		self.ProcessDate := (unsigned)pversion;
		self.FileDate := if(FileDate>20130000,FileDate,self.ProcessDate);
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

		self.ind_type 	:= functions.ind_type_fn(l.Customer_Program);
		self.file_type := 1 ;
		
		source_input := map(
						 STD.Str.Contains( l.fn, 'KnownFraud'	, true	) => 'KNFD'
						,STD.Str.Contains( l.fn, 'SafeList'		, true	)	=> 'SAFELIST'
						,'UNKNOWN'
				 );
		self.source_input := source_input;
		SELF.unique_id := hash64(hashmd5(
								ut.CleanSpacesAndUpper(l.customer_name) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_account_number) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_state) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_county) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_agency) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_agency_vertical_type) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_event_id) + ',' +  
								ut.CleanSpacesAndUpper(l.reported_date) + ',' +  
								ut.CleanSpacesAndUpper(l.reported_time) + ',' +  
								ut.CleanSpacesAndUpper(l.reported_by) + ',' +  
								ut.CleanSpacesAndUpper(l.event_date) + ',' +  
								ut.CleanSpacesAndUpper(l.event_end_date) + ',' +  
								ut.CleanSpacesAndUpper(l.event_location) + ',' +  
								ut.CleanSpacesAndUpper(l.event_type_1) + ',' +  
								ut.CleanSpacesAndUpper(l.event_type_2) + ',' +  
								ut.CleanSpacesAndUpper(l.event_type_3) + ',' +  
								(string) l.case_id + ',' +  
								ut.CleanSpacesAndUpper(l.client_id) + ',' +  
								ut.CleanSpacesAndUpper(l.head_of_household_indicator) + ',' +  
								ut.CleanSpacesAndUpper(l.relationship_indicator) + ',' +  
								(string)l.lexid + ',' +  
								ut.CleanSpacesAndUpper(l.raw_title) + ',' +  
								ut.CleanSpacesAndUpper(l.raw_first_name) + ',' +  
								ut.CleanSpacesAndUpper(l.raw_middle_name) + ',' +  
								ut.CleanSpacesAndUpper(l.raw_last_name) + ',' +  
								ut.CleanSpacesAndUpper(l.raw_orig_suffix) + ',' +  
								ut.CleanSpacesAndUpper(l.raw_full_name) + ',' +  
								ut.CleanSpacesAndUpper(l.name_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.ssn) + ',' +  
								ut.CleanSpacesAndUpper(l.ssn_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.dob) + ',' +  
								ut.CleanSpacesAndUpper(l.dob_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.Drivers_License_Number) + ',' +  
								ut.CleanSpacesAndUpper(l.Drivers_License_State) + ',' +  
								ut.CleanSpacesAndUpper(l.drivers_license_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.street_1) + ',' +  
								ut.CleanSpacesAndUpper(l.street_2) + ',' +  
								ut.CleanSpacesAndUpper(l.city) + ',' +  
								ut.CleanSpacesAndUpper(l.state) + ',' +  
								ut.CleanSpacesAndUpper(l.zip) + ',' +  
								ut.CleanSpacesAndUpper(l.physical_address_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_street_1) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_street_2) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_city) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_state) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_zip) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_address_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.address_date) + ',' +  
								ut.CleanSpacesAndUpper(l.address_type) + ',' +  
								ut.CleanSpacesAndUpper(l.county) + ',' +  
								ut.CleanSpacesAndUpper(l.phone_number) + ',' +  
								ut.CleanSpacesAndUpper(l.phone_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.cell_phone) + ',' +  
								ut.CleanSpacesAndUpper(l.cell_phone_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.work_phone) + ',' +  
								ut.CleanSpacesAndUpper(l.work_phone_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.contact_type) + ',' +  
								ut.CleanSpacesAndUpper(l.contact_date) + ',' +  
								ut.CleanSpacesAndUpper(l.carrier) + ',' +  
								ut.CleanSpacesAndUpper(l.contact_location) + ',' +  
								ut.CleanSpacesAndUpper(l.contact) + ',' +  
								ut.CleanSpacesAndUpper(l.call_records) + ',' +  
								ut.CleanSpacesAndUpper(l.in_service) + ',' +  
								ut.CleanSpacesAndUpper(l.email_address) + ',' +  
								ut.CleanSpacesAndUpper(l.email_address_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.email_address_type) + ',' +  
								ut.CleanSpacesAndUpper(l.email_date) + ',' +  
								ut.CleanSpacesAndUpper(l.host) + ',' +  
								ut.CleanSpacesAndUpper(l.alias) + ',' +  
								ut.CleanSpacesAndUpper(l.location) + ',' +  
								ut.CleanSpacesAndUpper(l.ip_address) + ',' +  
								ut.CleanSpacesAndUpper(l.ip_address_fraud_code) + ',' +  
								ut.CleanSpacesAndUpper(l.ip_address_date) + ',' +  
								ut.CleanSpacesAndUpper(l.version) + ',' +  
								ut.CleanSpacesAndUpper(l.isp) + ',' +  
								ut.CleanSpacesAndUpper(l.device_id) + ',' +  
								ut.CleanSpacesAndUpper(l.device_date) + ',' +  
								ut.CleanSpacesAndUpper(l.device_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.unique_number) + ',' +  
								ut.CleanSpacesAndUpper(l.mac_address) + ',' +  
								ut.CleanSpacesAndUpper(l.serial_number) + ',' +  
								ut.CleanSpacesAndUpper(l.device_type) + ',' +  
								ut.CleanSpacesAndUpper(l.device_identification_provider) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_routing_number_1) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_account_number_1) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_account_1_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_routing_number_2) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_account_number_2) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_account_2_risk_code) + ',' +  
								(string)l.appended_provider_id + ',' +  
								ut.CleanSpacesAndUpper(l.business_name) + ',' +  
								ut.CleanSpacesAndUpper(l.tin) + ',' +  
								ut.CleanSpacesAndUpper(l.fein) + ',' +  
								ut.CleanSpacesAndUpper(l.npi) + ',' +  
								ut.CleanSpacesAndUpper(l.tax_preparer_id) + ',' +  
								ut.CleanSpacesAndUpper(l.business_type_1) + ',' +  
								ut.CleanSpacesAndUpper(l.business_date) + ',' +  
								ut.CleanSpacesAndUpper(l.business_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.Customer_Program) + ',' +  
								ut.CleanSpacesAndUpper(l.start_date) + ',' +  
								ut.CleanSpacesAndUpper(l.end_date) + ',' +  
								ut.CleanSpacesAndUpper(l.amount_paid) + ',' +  
								ut.CleanSpacesAndUpper(l.region_code) + ',' +  
								ut.CleanSpacesAndUpper(l.investigator_id) + ',' +  
								ut.CleanSpacesAndUpper(l.reason_description) + ',' +  
								ut.CleanSpacesAndUpper(l.investigation_referral_case_id) + ',' +  
								ut.CleanSpacesAndUpper(l.investigation_referral_date_opened) + ',' +  
								ut.CleanSpacesAndUpper(l.investigation_referral_date_closed) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_fraud_code_1) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_fraud_code_2) + ',' +  
								ut.CleanSpacesAndUpper(l.type_of_referral) + ',' +  
								ut.CleanSpacesAndUpper(l.referral_reason) + ',' +  
								ut.CleanSpacesAndUpper(l.disposition) + ',' +  
								ut.CleanSpacesAndUpper(l.mitigated) + ',' +  
								ut.CleanSpacesAndUpper(l.mitigated_amount) + ',' +  
								ut.CleanSpacesAndUpper(l.external_referral_or_casenumber) + ',' +  
								ut.CleanSpacesAndUpper(l.cleared_fraud) + ',' +  
								ut.CleanSpacesAndUpper(l.reason_cleared_code)));	
		self.Deltabase := if(l.source_input[1..9] = 'DELTABASE', 1, 0);
		self:=l;
		self:=[];
	end;

	shared f1:=project(inKnownFraudUpdateUpper, tr(left));
	

	f1_errors:=f1
			((	 
					Customer_Account_Number =''
				or	Customer_County =''
				or 	(LexID = 0 and raw_Full_Name = '' and (raw_First_name = '' or raw_Last_Name=''))
				or 	((SSN = '' or length(STD.Str.CleanSpaces(SSN))<>9 or regexfind('^[0-9]*$',STD.Str.CleanSpaces(ssn)) =false) and (Drivers_License_Number='' and Drivers_License_State='') and LexID = 0)
				or 	(Street_1='' and City='' and State='' and Zip='')
				or 	(Customer_State in FraudGovPlatform_Validation.Mod_Sets.States) = FALSE
				or 	(Customer_Agency_Vertical_Type in FraudGovPlatform_Validation.Mod_Sets.Agency_Vertical_Type) = FALSE
				or 	(Customer_Program in FraudGovPlatform_Validation.Mod_Sets.IES_Benefit_Type) = FALSE
			)and PSkipValidations = false and source_input = 'KNFD' );
			
	NotInMbs := join(	f1,
								FraudShared.Files().Input.MBS.sprayed(status = 1) 
								,left.Customer_Account_Number =(string)right.gc_id
								AND left.file_type = right.file_type
								AND left.ind_type = right.ind_type
								AND (		( left.source_input = 'KNFD' 			and	right.confidence_that_activity_was_deceitful != 3 )
											OR	( left.source_input = 'SAFELIST' 	and	right.confidence_that_activity_was_deceitful = 3 ))	
								AND	left.customer_State 	= right.Customer_State
								AND	left.Customer_County 	= right.Customer_County
								AND	left.Customer_Agency_Vertical_Type = right.Customer_Vertical,
								TRANSFORM(Layouts.Input.knownfraud,SELF := LEFT),
								LEFT ONLY,
								LOOKUP);
	//Exclude Errors
	shared ByPassed_records := f1_errors + NotInMbs;
	f1_bypass_dedup := files().Input.ByPassed_KnownFraud.sprayed + project(ByPassed_records, FraudGovPlatform.Layouts.Input.knownfraud);

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
	shared f1_dedup :=	join (	f1,
											ByPassed_records,
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
									
	dAppendAID	:= Standardize_Entity.Clean_Address(f1_dedup, new_addresses);
	dappendName	:= Standardize_Entity.Clean_Name(dAppendAID);	
	dAppendPhone := Standardize_Entity.Clean_Phone (dappendName);
	dAppendLexid := Standardize_Entity.Append_Lexid (dAppendPhone);
	dCleanInputFields := Standardize_Entity.Clean_InputFields (dAppendLexid);	

	input_file_1 := fn_dedup(files().Input.KnownFraud.sprayed  + project(dCleanInputFields,Layouts.Input.KnownFraud));

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
				,Build_Bypass_Records 
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_KnownFraud atribute')  
	);

end;


