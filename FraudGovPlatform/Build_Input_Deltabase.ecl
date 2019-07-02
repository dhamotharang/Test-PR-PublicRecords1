IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared, ut, _Validate;
EXPORT Build_Input_Deltabase(
	 string pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
	,dataset(Layouts.Input.Deltabase) Deltabase_Sprayed =  files().Input.Deltabase.sprayed	
	,dataset(Layouts.Input.Deltabase) ByPassed_Deltabase_Sprayed = files().Input.ByPassed_Deltabase.sprayed	
) :=
module

	deltabaseUpdate :=	if ( nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.Deltabase)) > 0,
		Files(pversion).Sprayed.Deltabase, 
		dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.Deltabase}));

	Functions.CleanFields(deltabaseUpdate ,deltabaseUpdateUpper); 

	Layouts.Input.Deltabase tr(deltabaseUpdateUpper l) := transform
		sub:=stringlib.stringfind(l.fn,'20',1);
		sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
		self.FileName := l.fn;
		self.Process_Date := (unsigned)pversion;
		self.FileDate := (unsigned)l.fn[sub..sub+7];
		self.FileTime := ut.CleanSpacesAndUpper(l.fn[sub2..sub2+5]);
		self.address_1 := tools.AID_Helpers.fRawFixLine1( trim(l.Street_1));
		self.address_2 := tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(l.city) + if(l.state != '', ', ', '') + trim(l.state)  + ' ' + trim(l.zip)[1..5]));
		self.mailing_address_1 := tools.AID_Helpers.fRawFixLine1( trim(l.Mailing_Street_1));
		self.mailing_address_2 := tools.AID_Helpers.fRawFixLineLast(  stringlib.stringtouppercase(trim(l.Mailing_City) + if(l.Mailing_State != '', ', ', '') + trim(l.Mailing_State)  + ' ' + trim(l.Mailing_Zip)[1..5]));		
		self.ind_type 	:= functions.ind_type_fn(l.Customer_Program);
		self.file_type := 3 ;
		self:=l;
		self:=[];
	end;

	shared f1:=project(deltabaseUpdateUpper,tr(left));


	max_uid := max(Deltabase_Sprayed, Deltabase_Sprayed.source_rec_id) + 1;

	MAC_Sequence_Records( f1, source_rec_id, f1_source_rec_id, max_uid);
	
	shared d_source_rec_id := distribute(f1_source_rec_id);
	
	shared append_source := join(
		d_source_rec_id,
		MBS_Sprayed(status = 1 and regexfind('DELTA', fdn_file_code, nocase)),
		left.Customer_Id =(string)right.gc_id,
		TRANSFORM(Layouts.Input.Deltabase,SELF.source := RIGHT.fdn_file_code; SELF := LEFT),LEFT OUTER, lookup);

	shared f1_errors:=append_source
		(	InqLog_ID = 0 
			or (_Validate.Date.fIsValid(STD.Str.FindReplace( STD.Str.FindReplace( reported_date,':',''),'-','')[1..8]) = false  
			or (unsigned)STD.Str.FindReplace( STD.Str.FindReplace( reported_date,':',''),'-','')[1..8] > (unsigned)(STRING8)Std.Date.Today())
			or reported_by = ''
			or source = '');

	EXPORT fn_dedup(inputs):=FUNCTIONMACRO

		in_srt := sort(inputs , InqLog_ID,customer_id,transaction_id,Date_of_Transaction,Household_ID,Customer_Person_ID,Customer_Program,Reason_for_Transaction_Activity,inquiry_source,customer_county,customer_state,customer_agency_vertical_type,ssn,dob,Rawlinkid,raw_full_name,raw_title,raw_first_name,raw_middle_name,raw_last_name,raw_Orig_Suffix,full_address,street_1,city,state,zip,county,mailing_street_1,mailing_city,mailing_state,mailing_zip,mailing_county,phone_number,ultid,orgid,seleid,tin,Email_Address,appended_provider_id,lnpid,npi,ip_address,device_id,professional_id,bank_routing_number_1,bank_account_number_1,Drivers_License_State,Drivers_License,geo_lat,geo_long,reported_date,file_type,deceitful_confidence,reported_by,reason_description,event_type_1,event_entity_1,filename);

		{inputs} RollupUpdate({inputs} l, {inputs} r) := 
		transform
			SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous source_rec_id 
			self := l;
		end;

		in_ddp := rollup( in_srt
			,RollupUpdate(left, right)
			,InqLog_ID,customer_id,transaction_id,Date_of_Transaction,Household_ID,Customer_Person_ID,Customer_Program,Reason_for_Transaction_Activity,inquiry_source,customer_county,customer_state,customer_agency_vertical_type,ssn,dob,Rawlinkid,raw_full_name,raw_title,raw_first_name,raw_middle_name,raw_last_name,raw_Orig_Suffix,full_address,street_1,city,state,zip,county,mailing_street_1,mailing_city,mailing_state,mailing_zip,mailing_county,phone_number,ultid,orgid,seleid,tin,Email_Address,appended_provider_id,lnpid,npi,ip_address,device_id,professional_id,bank_routing_number_1,bank_account_number_1,Drivers_License_State,Drivers_License,geo_lat,geo_long,reported_date,file_type,deceitful_confidence,reported_by,reason_description,event_type_1,event_entity_1,filename
		);
		return in_ddp;
	ENDMACRO;
	//Exclude Errors
	shared f1_bypass_dedup := fn_dedup(ByPassed_Deltabase_Sprayed + project( f1_errors,FraudGovPlatform.Layouts.Input.Deltabase)); 
	
	tools.mac_WriteFile(Filenames().Input.ByPassed_Deltabase.New(pversion),
		distribute(f1_bypass_dedup,hash(source_rec_id)),
		Build_Bypass_Records,
		pCompress := true,
		pHeading := false,
		pOverwrite := true);
									
	//Move only Valid Records
	shared Valid_Recs :=	join (	
		append_source,
		f1_bypass_dedup,
		left.source_rec_id = right.source_rec_id,
		TRANSFORM(Layouts.Input.Deltabase,SELF := LEFT),
		LEFT ONLY,
		LOOKUP);

	dappendName := Standardize_Entity.Clean_Name(Valid_Recs);	
	dAppendPhone := Standardize_Entity.Clean_Phone (dappendName);
	dCleanInputFields := Standardize_Entity.Clean_InputFields (dAppendPhone);	
	
	input_file_1 := fn_dedup(Deltabase_Sprayed  + project(dCleanInputFields,Layouts.Input.Deltabase)); 

	tools.mac_WriteFile(Filenames(pversion).Input.Deltabase.New(pversion),
		distribute(input_file_1,hash(source_rec_id)),
		Build_Input_File,
		pCompress := true,
		pHeading := false,
		pOverwrite := true);

// Return
	export build_prepped := 
			 sequential(
			   Build_Input_File
				,Build_Bypass_Records 
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_Deltabase atribute')
	);

end;


