import FraudShared, STD, data_services, ut,tools; 
EXPORT Build_Base_Main  (
	 string pversion
	,dataset(FraudShared.Layouts.Base.Main) pBaseMainFile = IF($._Flags.FileExists.Base.MainOrigQA, $.Files().Base.Main_Orig.QA, DATASET([], FraudShared.Layouts.Base.Main))
	,dataset($.Layouts.Input.IdentityData) inIdentityData = $.Files().Input.IdentityData.Sprayed
	,dataset($.Layouts.Input.KnownFraud) inKnownFraud = $.Files().Input.KnownFraud.Sprayed
	,dataset($.Layouts.Input.Deltabase) inDeltabase = $.Files().Input.Deltabase.Sprayed
) :=
module  
 
    dedup_IdentityData := $.fn_dedup_identitydata(inIdentityData); // remove duplicate records with different transaction_id

	Export IdentityData := project (dedup_IdentityData , transform(FraudShared.Layouts.Base.Main , 
		self.ln_report_date := left.Date_of_Transaction;
		self.Reported_Date := left.Date_of_Transaction;
		self.Event_Date := left.Date_of_Transaction;
		self.investigation_referral_case_id := left.Household_ID;
		self.additional_address.Street_1 := left.Mailing_Street_1; 
		self.additional_address.Street_2 := left.Mailing_Street_2;
		self.additional_address.City := left.Mailing_City;
		self.additional_address.State := left.Mailing_State;
		self.additional_address.Zip := left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.dt_first_seen := left.Process_Date;
		self.dt_last_seen := left.Process_Date;
		self.dt_vendor_last_reported := left.FileDate;
		self.dt_vendor_first_reported := left.FileDate;
		self:= left; 
		self:= [];
	)); 

	dedup_KnownFraud := $.fn_dedup_KnownFraud(inKnownFraud); // remove duplicate records with different customer_event_id
 
	Export KnownFraud := project (dedup_KnownFraud , transform(FraudShared.Layouts.Base.Main , 
		self.ln_report_date := left.reported_date;
		self.event_date := if(left.event_date = '', left.reported_date, left.event_date);
		self.transaction_id := left.customer_event_id;
		self.additional_address.Street_1 := left.Mailing_Street_1; 
		self.additional_address.Street_2 := left.Mailing_Street_2;
		self.additional_address.City := left.Mailing_City;
		self.additional_address.State := left.Mailing_State;
		self.additional_address.Zip := left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.dt_first_seen := left.Process_Date; 
		self.dt_last_seen := left.Process_Date;
		self.dt_vendor_last_reported := left.FileDate; 
		self.dt_vendor_first_reported := left.FileDate; 
		self:= left; 
		self:= [];
	)); 


	dedup_deltabase := $.fn_dedup_delta(inDeltabase); // remove records submitted by same user/date

	Export Deltabase := project (dedup_deltabase, transform(FraudShared.Layouts.Base.Main , 
		v_datetime := STD.Str.FindReplace( STD.Str.FindReplace( left.reported_date,':',''),'-','');
		v_date := v_datetime[1..8];
		v_time := v_datetime[10..];
		self.reported_date := v_date;
		self.reported_time := v_time;
		self.event_date := v_date;
		self.ln_report_date := v_date;
		self.ln_report_Time := v_time;
		//Risk codes handleing https://jira.rsi.lexisnexis.com/browse/GRP-4633
		self.ssn_risk_code := if(left.event_entity_1 = 'FULL_SSN', left.event_type_1, '') ;
		self.drivers_license_risk_code := if(left.event_entity_1 = 'DLN', left.event_type_1, '') ;
		self.physical_address_risk_code := if(left.event_entity_1 = 'PHYSICAL_ADDRESS', left.event_type_1, '') ;
		self.phone_risk_code := if(left.event_entity_1 = 'PHONENO', left.event_type_1, '') ;
		self.bank_account_1_risk_code := if(left.event_entity_1 = 'BANK_ACCOUNT', left.event_type_1, '') ;
		self.email_address_risk_code := if(left.event_entity_1 = 'EMAIL', left.event_type_1, '') ;
		self.ip_address_fraud_code := if(left.event_entity_1 = 'IP_ADDRESS', left.event_type_1, '') ;
		self.identity_risk_code := if(left.event_entity_1 = 'LEXID', left.event_type_1, '') ;
		self.investigation_referral_case_id := left.Household_ID;
		self.additional_address.Street_1 := left.mailing_street_1; 
		self.additional_address.City := left.Mailing_City;
		self.additional_address.State := left.Mailing_State;
		self.additional_address.Zip := left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.classification_Activity.Confidence_that_activity_was_deceitful_id	:= (unsigned2)left.deceitful_confidence;
		self.classification_Permissible_use_access.file_type := left.file_type;
		self:= left; 
		self:= [];
	)); 

	// Apply MBS classification and Sharing Rules
	CombinedClassification := $.Functions.Classification(IdentityData + KnownFraud + Deltabase):independent;

	// Append RID
	EXPORT NewBaseRID := $.Append_RID (CombinedClassification,pBaseMainFile):independent;

	// Append Values from Previous Build
	EXPORT NewBasePreviousValues := $.Append_PreviousValues(NewBaseRID,pBaseMainFile):independent;

	//Clean names
	$.Standardize_Name(NewBasePreviousValues, raw_first_name, raw_middle_name, raw_last_name, raw_Orig_Suffix  ,NewBaseCleanedName);

	//Clean other Fields: SSN, DOB, IP, ZIP, DL 
	dCleanInputFields := $.Standardize_Entity.Clean_InputFields (NewBaseCleanedName):independent;

	// Append Clean Phones
	NewBaseCleanPhones := $.Standardize_Entity.Clean_Phone (dCleanInputFields):independent;

	// Append Clean Address
	EXPORT NewBaseCleanAddress := $.Append_CleanAddress(NewBaseCleanPhones):independent;

	// Append Clean Additional Address
	EXPORT Append_CleanAdditionalAddress := $.Append_CleanAdditionalAddress(NewBaseCleanAddress):independent;
	
	// Append Lexid
	EXPORT NewBaseLexid := $.Append_Lexid (Append_CleanAdditionalAddress):independent;

	// Append RinID
	EXPORT NewBaseRinID := $.Append_RinID (NewBaseLexid):independent;
	
	//Label RIN Source
	EXPORT AppendRinSourceLabel := $.Append_RinSource(NewBaseRinID):independent;

	// Rollup Main Base 
	pDataset_sort := sort(AppendRinSourceLabel , record, -dt_last_seen,-process_date);
			
	pDataset_sort RollupBase(pDataset_sort l, pDataset_sort r) := 
	transform
		SELF.dt_first_seen := ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		SELF.dt_last_seen := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous rid 
    	SELF.Record_id := if(l.record_id < r.record_id,l.record_id, r.record_id);		
		SELF := l;
	end;

	pDataset_rollup := rollup( pDataset_sort
		,RollupBase(left, right)
		,Record																						
		,except process_date, dt_first_seen ,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported, source_rec_id , record_id
	);
	// Return
	
	ut.MAC_Append_Rcid (pDataset_rollup,UID,addUID);

  	// Append Industry type description 
	
	Combined := join (addUID , FraudShared.Files().Input.MBSFdnIndType.Sprayed(status = 1), 
		left.classification_Permissible_use_access.ind_type = right.ind_type , 
		transform (FraudShared.Layouts.Base.main , 
			self.classification_Permissible_use_access.ind_type_description := StringLib.StringToUppercase(right.description), 
			self := left), left outer , lookup ); 
																							 
	
	tools.mac_WriteFile($.Filenames(pversion).Base.Main_Orig.New,Combined,Build_Base_File);

	export full_build :=
		 sequential(
			 Build_Base_File
			,$.Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping FDN.Build_Base_Main atribute')
	);
	
end;