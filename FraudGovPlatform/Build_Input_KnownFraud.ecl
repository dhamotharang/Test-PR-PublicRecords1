IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared,ut,_Validate; 
EXPORT Build_Input_KnownFraud(
	 string pversion
	,dataset(Layouts.Input.mbs) MBS_Sprayed = Files().Input.MBS.sprayed
	,dataset(Layouts.Input.KnownFraud) KnownFraud_Sprayed =  files().Input.KnownFraud.sprayed	
	,dataset(Layouts.Input.KnownFraud) ByPassed_KnownFraud_Sprayed = files().Input.ByPassed_KnownFraud.sprayed	
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
		fn := StringLib.SplitWords( StringLib.StringFindReplace(filename, '.dat',''), '_', true );

		self.Customer_Id := STD.Str.FindReplace(fn[1],'FRAUDGOV::IN::','');
		self.Customer_State := fn[2];
		self.Customer_Agency_Vertical_Type := fn[3];
		self.Customer_Program_fn := fn[4];
		self.Process_Date := (unsigned)pversion;
		self.FileDate :=(unsigned)fn[6];
		self.FileTime :=fn[7];
		self.ind_type 	:= functions.ind_type_fn(fn[4]);
		self.file_type := 1 ;
		//https://confluence.rsi.lexisnexis.com/display/GTG/Data+Source+Identification:
		self.RIN_Source := map(
														regexfind('KnownRisk',filename,nocase) => 2, //knownrisk
														regexfind('Safelist',filename,nocase) => 3, //safelist
														l.RIN_Source);  // NAC
		self:=l;
		self:=[];
	end;

	shared f1:=project(inKnownFraudUpdateUpper, tr(left, counter));

	max_uid := max(KnownFraud_Sprayed, KnownFraud_Sprayed.source_rec_id) + 1;
	
	MAC_Sequence_Records( f1, source_rec_id, f1_source_rec_id, max_uid);
	
	shared d_source_rec_id := distribute(f1_source_rec_id);
	
	shared append_source := join(	
		d_source_rec_id,
		MBS_Sprayed(status = 1 and regexfind('DELTA', fdn_file_code, nocase)  = false),
		left.Customer_Id =(string)right.gc_id
		AND	left.customer_State = right.Customer_State
		AND left.file_type = right.file_type //1=events
		AND left.ind_type = right.ind_type //program
		AND (( regexfind('KnownRisk|NAC',left.filename,nocase) and right.confidence_that_activity_was_deceitful != 3 )
			OR ( regexfind('Safelist',left.filename,nocase) and right.confidence_that_activity_was_deceitful = 3 )),
		TRANSFORM(Layouts.Input.knownfraud,SELF.source := RIGHT.fdn_file_code; SELF := LEFT),
		LEFT OUTER,
		LOOKUP);

	shared f1_errors:=append_source
		(
			customer_event_id = ''
			or (_Validate.Date.fIsValid(reported_date) = false  or (unsigned)reported_date > (unsigned)(STRING8)Std.Date.Today())
			or 	reported_time = ''
			or 	reported_by = ''
			or  source = ''
			or  event_type_1 = ''
		);

	shared fn_dedup(inputs):=FUNCTIONMACRO
			in_dst := inputs;
			in_srt := sort(in_dst , customer_event_id,reported_date,reported_time,reported_by,event_date,event_end_date,event_location,event_type_1,event_type_2,event_type_3,Household_ID,Customer_Person_ID,head_of_household_indicator,relationship_indicator,Rawlinkid,raw_Title,raw_First_name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,raw_Full_Name,name_risk_code,ssn,ssn_risk_code,dob,dob_risk_code,Drivers_License,Drivers_License_State,drivers_license_risk_code,street_1,street_2,city,state,zip,physical_address_risk_code,mailing_street_1,mailing_street_2,mailing_city,mailing_state,mailing_zip,mailing_address_risk_code,address_date,address_type,county,phone_number,phone_risk_code,cell_phone,cell_phone_risk_code,work_phone,work_phone_risk_code,contact_type,contact_date,carrier,contact_location,contact,call_records,in_service,email_address,email_address_risk_code,email_address_type,email_date,host,alias,location,ip_address,ip_address_fraud_code,ip_address_date,version,isp,device_id,device_date,device_risk_code,unique_number,MAC_Address,serial_number,device_type,device_identification_provider,bank_routing_number_1,bank_account_number_1,bank_account_1_risk_code,bank_routing_number_2,bank_account_number_2,bank_account_2_risk_code,appended_provider_id,business_name,tin,fein,npi,tax_preparer_id,business_type_1,business_date,business_risk_code,Customer_Program,start_date,end_date,amount_paid,region_code,investigator_id,reason_description,investigation_referral_case_id,investigation_referral_date_opened,investigation_referral_date_closed,customer_fraud_code_1,customer_fraud_code_2,type_of_referral,referral_reason,disposition,mitigated,mitigated_amount,external_referral_or_casenumber,cleared_fraud,reason_cleared_code,filename);

			{inputs} RollupUpdate({inputs} l, {inputs} r) := 
			transform
					SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous Unique_Id 
					self := l;
			end;

			in_ddp := rollup( in_srt
					,RollupUpdate(left, right)
					,customer_event_id,reported_date,reported_time,reported_by,event_date,event_end_date,event_location,event_type_1,event_type_2,event_type_3,Household_ID,Customer_Person_ID,head_of_household_indicator,relationship_indicator,Rawlinkid,raw_Title,raw_First_name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,raw_Full_Name,name_risk_code,ssn,ssn_risk_code,dob,dob_risk_code,Drivers_License,Drivers_License_State,drivers_license_risk_code,street_1,street_2,city,state,zip,physical_address_risk_code,mailing_street_1,mailing_street_2,mailing_city,mailing_state,mailing_zip,mailing_address_risk_code,address_date,address_type,county,phone_number,phone_risk_code,cell_phone,cell_phone_risk_code,work_phone,work_phone_risk_code,contact_type,contact_date,carrier,contact_location,contact,call_records,in_service,email_address,email_address_risk_code,email_address_type,email_date,host,alias,location,ip_address,ip_address_fraud_code,ip_address_date,version,isp,device_id,device_date,device_risk_code,unique_number,MAC_Address,serial_number,device_type,device_identification_provider,bank_routing_number_1,bank_account_number_1,bank_account_1_risk_code,bank_routing_number_2,bank_account_number_2,bank_account_2_risk_code,appended_provider_id,business_name,tin,fein,npi,tax_preparer_id,business_type_1,business_date,business_risk_code,Customer_Program,start_date,end_date,amount_paid,region_code,investigator_id,reason_description,investigation_referral_case_id,investigation_referral_date_opened,investigation_referral_date_closed,customer_fraud_code_1,customer_fraud_code_2,type_of_referral,referral_reason,disposition,mitigated,mitigated_amount,external_referral_or_casenumber,cleared_fraud,reason_cleared_code,filename
			);
			return in_ddp;
	ENDMACRO;	

	//Exclude Errors
	shared f1_bypass_dedup:= fn_dedup(ByPassed_KnownFraud_Sprayed + PROJECT(f1_errors,FraudGovPlatform.Layouts.Input.KnownFraud));
	
	tools.mac_WriteFile(Filenames().Input.ByPassed_KnownFraud.New(pversion),
		distribute(f1_bypass_dedup,hash(source_rec_id)),
		Build_Bypass_KnownFraud,
		pCompress := true,
		pHeading := false,
		pOverwrite := true);


	//Move only Valid Records
	shared Valid_Recs :=	join (
		append_source,
		f1_bypass_dedup,
		left.source_rec_id = right.source_rec_id,
		TRANSFORM(Layouts.Input.knownfraud,SELF := LEFT),
		LEFT ONLY,
		LOOKUP);
																															
	input_file_1 := fn_dedup(KnownFraud_Sprayed  + project(Valid_Recs,Layouts.Input.KnownFraud));


	tools.mac_WriteFile(
		Filenames(pversion).Input.KnownFraud.New(pversion),
		distribute(input_file_1,hash(source_rec_id)),
		Build_KnownFraud,
		pCompress	:= true,
		pHeading := false,
		pOverwrite := true);

// Return
	export build_prepped := 
		sequential(
			 Build_KnownFraud
			,Build_Bypass_KnownFraud);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_KnownFraud atribute')  
	);

end;


