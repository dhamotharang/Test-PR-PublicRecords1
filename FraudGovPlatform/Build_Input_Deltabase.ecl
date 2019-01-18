IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared, ut;
EXPORT Build_Input_Deltabase(
	 string			pversion
	,boolean		PSkipValidations	= false
) :=
module

	SHARED fn_dedup(inputs):=FUNCTIONMACRO
		in_srt:=sort(inputs, RECORD, EXCEPT processdate);
		in_ddp:=rollup(in_srt,
								TRANSFORM(Layouts.Input.Deltabase,SELF := LEFT; SELF := []),
								RECORD,
								EXCEPT ProcessDate);	
		return in_ddp;
	ENDMACRO;	
	
	deltabaseUpdate :=	  if ( nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.Deltabase)) > 0,
													Files(pversion).Sprayed.Deltabase, 
													dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.Deltabase})
											);

	Functions.CleanFields(deltabaseUpdate ,deltabaseUpdateUpper); 

	Layouts.Input.Deltabase tr(deltabaseUpdateUpper l) := transform
		sub:=stringlib.stringfind(l.fn,'20',1);
		sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
		FileDate := (unsigned)l.fn[sub..sub+7];
		FileTime := ut.CleanSpacesAndUpper(l.fn[sub2..sub2+5]);
		self.FileName := l.fn;
		self.ProcessDate := (unsigned)pversion;
		self.FileDate := if(FileDate>20130000,FileDate,self.ProcessDate);
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
		SELF.unique_id := hash64(hashmd5(
									(string) l.InqLog_ID + ',' + 
                                    ut.CleanSpacesAndUpper(l.customer_account_number) + ',' + 
                                    ut.CleanSpacesAndUpper(l.Transaction_ID_Number) + ',' + 
                                    ut.CleanSpacesAndUpper(l.Date_of_Transaction) + ',' + 
                                    ut.CleanSpacesAndUpper(l.Case_ID) + ',' + 
                                    (string) l.client_uid + ',' + 
                                    ut.CleanSpacesAndUpper(l.Customer_Program) + ',' + 
                                    ut.CleanSpacesAndUpper(l.Reason_for_Transaction_Activity) + ',' + 
                                    ut.CleanSpacesAndUpper(l.inquiry_source) + ',' + 
                                    ut.CleanSpacesAndUpper(l.customer_county) + ',' + 
                                    ut.CleanSpacesAndUpper(l.customer_state) + ',' + 
                                    ut.CleanSpacesAndUpper(l.customer_agency_vertical_type) + ',' + 
                                    ut.CleanSpacesAndUpper(l.ssn) + ',' + 
                                    ut.CleanSpacesAndUpper(l.dob) + ',' + 
                                    (string) l.lexid + ',' + 
                                    ut.CleanSpacesAndUpper(l.raw_full_name) + ',' + 
                                    ut.CleanSpacesAndUpper(l.raw_title) + ',' + 
                                    ut.CleanSpacesAndUpper(l.raw_first_name) + ',' + 
                                    ut.CleanSpacesAndUpper(l.raw_middle_name) + ',' + 
                                    ut.CleanSpacesAndUpper(l.raw_last_name) + ',' + 
                                    ut.CleanSpacesAndUpper(l.raw_Orig_Suffix) + ',' + 
                                    ut.CleanSpacesAndUpper(l.full_address) + ',' + 
                                    ut.CleanSpacesAndUpper(l.street_1) + ',' + 
                                    ut.CleanSpacesAndUpper(l.city) + ',' + 
                                    ut.CleanSpacesAndUpper(l.state) + ',' + 
                                    ut.CleanSpacesAndUpper(l.zip) + ',' + 
                                    ut.CleanSpacesAndUpper(l.county) + ',' + 
                                    ut.CleanSpacesAndUpper(l.mailing_street_1) + ',' + 
                                    ut.CleanSpacesAndUpper(l.mailing_city) + ',' + 
                                    ut.CleanSpacesAndUpper(l.mailing_state) + ',' + 
                                    ut.CleanSpacesAndUpper(l.mailing_zip) + ',' + 
                                    ut.CleanSpacesAndUpper(l.mailing_county) + ',' + 
                                    ut.CleanSpacesAndUpper(l.phone_number) + ',' + 
                                    (string) l.ultid + ',' + 
                                    (string) l.orgid + ',' + 
                                    (string) l.seleid + ',' + 
                                    ut.CleanSpacesAndUpper(l.tin) + ',' + 
                                    ut.CleanSpacesAndUpper(l.Email_Address) + ',' + 
                                    (string) l.appended_provider_id + ',' + 
                                    (string) l.lnpid + ',' + 
                                    ut.CleanSpacesAndUpper(l.npi) + ',' + 
                                    ut.CleanSpacesAndUpper(l.ip_address) + ',' + 
                                    ut.CleanSpacesAndUpper(l.device_id) + ',' + 
                                    ut.CleanSpacesAndUpper(l.professional_id) + ',' + 
                                    ut.CleanSpacesAndUpper(l.bank_routing_number_1) + ',' + 
                                    ut.CleanSpacesAndUpper(l.bank_account_number_1) + ',' + 
                                    ut.CleanSpacesAndUpper(l.Drivers_License_State) + ',' + 
                                    ut.CleanSpacesAndUpper(l.Drivers_License_Number) + ',' + 
                                    ut.CleanSpacesAndUpper(l.geo_lat) + ',' + 
                                    ut.CleanSpacesAndUpper(l.geo_long) + ',' + 
                                    ut.CleanSpacesAndUpper(l.reported_date) + ',' + 		
                                     (string) l.file_type + ',' + 
                                    ut.CleanSpacesAndUpper(l.deceitful_confidence) + ',' + 
                                    ut.CleanSpacesAndUpper(l.user_added) + ',' + 
                                    ut.CleanSpacesAndUpper(l.reason_description) + ',' + 
                                    ut.CleanSpacesAndUpper(l.event_type_1) + ',' + 
                                    ut.CleanSpacesAndUpper(l.event_entity_1))); 
		self.Deltabase := 1;					 
		self:=l;
		self:=[];
	end;

	shared f1:=project(deltabaseUpdateUpper,tr(left));
	
	f1_errors:=f1
			((	 
					Customer_Account_Number = '' or reported_date = '' or file_type = 0
				or 	(Customer_Program in FraudGovPlatform_Validation.Mod_Sets.IES_Benefit_Type) 			= FALSE				
			)and PSkipValidations = false);

	MBS_Layout := Record
		FraudShared.Layouts.Input.MBS;
		unsigned1 Deltabase := 0;
	end;
	MBS	:= project(FraudShared.Files().Input.MBS.sprayed(status = 1), transform(MBS_Layout, self.Deltabase := If(regexfind('DELTA', left.fdn_file_code, nocase),1,0); self := left));


	NotInMbs := join(f1,
								MBS(Deltabase = 1),
										left.Customer_Account_Number =(string)right.gc_id and
										left.Deltabase = right.Deltabase,
										TRANSFORM(Layouts.Input.Deltabase,SELF := LEFT),LEFT ONLY, lookup);
	//Exclude Errors
	shared ByPassed_records := f1_errors + NotInMbs;
	f1_bypass_dedup := files().Input.ByPassed_Deltabase.sprayed + project(ByPassed_records,FraudGovPlatform.Layouts.Input.Deltabase);
	
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
	shared f1_dedup :=	join (f1,
											ByPassed_records,
											left.Unique_Id = right.Unique_Id,
											TRANSFORM(Layouts.Input.Deltabase,SELF := LEFT),
											left only);
																							

	shared new_addresses := Functions.New_Addresses(f1_dedup);

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

																							
	dAppendAID	:= Standardize_Entity.Clean_Address(f1_dedup, new_addresses);
	dappendName	:= Standardize_Entity.Clean_Name(dAppendAID);	
	dAppendPhone	:= Standardize_Entity.Clean_Phone (dappendName);
	dAppendLexid	:= Standardize_Entity.Append_Lexid (dAppendPhone);
	dCleanInputFields := Standardize_Entity.Clean_InputFields (dAppendLexid);	
	
	input_file_1 := fn_dedup(files().Input.Deltabase.sprayed  + project(dCleanInputFields,Layouts.Input.Deltabase));

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


