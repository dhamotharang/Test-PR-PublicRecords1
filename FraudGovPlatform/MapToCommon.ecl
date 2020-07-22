import FraudShared, STD, data_services; 
EXPORT MapToCommon  (
	 string pversion
  ,dataset(FraudShared.Layouts.Base.Main) pBaseMainFile = IF(_Flags.FileExists.Base.MainOrigQA, FraudGovPlatform.Files().Base.Main_Orig.QA, DATASET([], FraudShared.Layouts.Base.Main))
	,dataset(Layouts.Input.IdentityData) inIdentityData = Files().Input.IdentityData.Sprayed
	,dataset(Layouts.Input.KnownFraud) inKnownFraud = Files().Input.KnownFraud.Sprayed
	,dataset(Layouts.Input.Deltabase) inDeltabase = Files().Input.Deltabase.Sprayed
) :=
module  
 
	Export IdentityData := project (inIdentityData , transform(FraudShared.Layouts.Base.Main , 
		self.ln_report_date		:= left.Date_of_Transaction;
		self.Reported_Date		:= left.Date_of_Transaction;
		self.Event_Date				:= left.Date_of_Transaction;
		self.investigation_referral_case_id	:= left.Household_ID;
		self.additional_address.Street_1		:= left.Mailing_Street_1; 
		self.additional_address.Street_2		:= left.Mailing_Street_2;
		self.additional_address.City				:= left.Mailing_City;
		self.additional_address.State				:= left.Mailing_State;
		self.additional_address.Zip					:= left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.dt_first_seen	:= left.Process_Date;
		self.dt_last_seen		:= left.Process_Date;
		self.dt_vendor_last_reported	:= left.FileDate;
		self.dt_vendor_first_reported := left.FileDate;
		self:= left; 
		self:= [];
	)); 
	
	extra_dedup_KnownFraud := fn_dedup_knownfraud(inKnownFraud); // remove duplicate records with different customer_event_id
 
	Export KnownFraud := project (extra_dedup_KnownFraud , transform(FraudShared.Layouts.Base.Main , 
		self.ln_report_date := left.reported_date;
		self.event_date			:= if(left.event_date = '', left.reported_date, left.event_date);
		self.transaction_id := left.customer_event_id;
		self.additional_address.Street_1	:= left.Mailing_Street_1; 
		self.additional_address.Street_2	:= left.Mailing_Street_2;
		self.additional_address.City			:= left.Mailing_City;
		self.additional_address.State			:= left.Mailing_State;
		self.additional_address.Zip				:= left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.dt_first_seen	:= left.Process_Date; 
		self.dt_last_seen		:= left.Process_Date;
		self.dt_vendor_last_reported	:= left.FileDate; 
		self.dt_vendor_first_reported	:= left.FileDate; 
		self:= left; 
		self:= [];
	)); 


	extra_dedup_delta := fn_dedup_delta(inDeltabase); // remove records submitted by same user/date

	Export Deltabase := project (extra_dedup_delta, transform(FraudShared.Layouts.Base.Main , 
		v_datetime := STD.Str.FindReplace( STD.Str.FindReplace( left.reported_date,':',''),'-','');
		v_date := v_datetime[1..8];
		v_time := v_datetime[10..];
		self.reported_date	:= v_date;
		self.reported_time	:= v_time;
		self.event_date	:= v_date;
		self.ln_report_date	:= v_date;
		self.ln_report_Time	:= v_time;		
		//Risk codes handleing https://jira.rsi.lexisnexis.com/browse/GRP-4633
		self.ssn_risk_code 					:= if(left.event_entity_1 = 'FULL_SSN'	, left.event_type_1, '') ;
		self.drivers_license_risk_code 		:= if(left.event_entity_1 = 'DLN'				, left.event_type_1, '') ;
		self.physical_address_risk_code		:= if(left.event_entity_1 = 'PHYSICAL_ADDRESS'	, left.event_type_1, '') ;
		self.phone_risk_code 				:= if(left.event_entity_1 = 'PHONENO'		, left.event_type_1, '') ;
		self.bank_account_1_risk_code 		:= if(left.event_entity_1 = 'BANK_ACCOUNT'			, left.event_type_1, '') ;
		self.email_address_risk_code 			:= if(left.event_entity_1 = 'EMAIL'			, left.event_type_1, '') ;	
		self.ip_address_fraud_code 			:= if(left.event_entity_1 = 'IP_ADDRESS', left.event_type_1, '') ;
		self.identity_risk_code 				:= if(left.event_entity_1 = 'LEXID'			, left.event_type_1, '') ;
		self.investigation_referral_case_id  	:= left.Household_ID;
		self.additional_address.Street_1		:= left.mailing_street_1; 
		self.additional_address.City			:= left.Mailing_City;
		self.additional_address.State			:= left.Mailing_State;
		self.additional_address.Zip				:= left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.classification_Activity.Confidence_that_activity_was_deceitful_id	:= (unsigned2)left.deceitful_confidence;
		self.classification_Permissible_use_access.file_type := left.file_type;
		self:= left; 
		self:= [];
	)); 

	// Apply MBS classification and Sharing Rules
	CombinedClassification := Functions.Classification(IdentityData + KnownFraud + Deltabase):independent;
		 
	// Filter header records
	EXPORT NewBaseCombined := CombinedClassification (Customer_event_id not in ['CUST_ID_NUM','CUSTOMERID']):independent;

 	// Append RID
	EXPORT NewBaseRID := Append_RID (NewBaseCombined,pBaseMainFile):independent;

 	// Append Values from Previous Build
	EXPORT NewBasePreviousValues := Append_PreviousValues(NewBaseRID,pBaseMainFile):independent;

	// Append Clean Phones
	NewBaseCleanPhones := Standardize_Entity.Clean_Phone (NewBasePreviousValues);

	// Append Clean Address
	EXPORT NewBaseCleanAddress := Append_CleanAddress(NewBaseCleanPhones):independent;

	// Append Clean Additional Address
	EXPORT Append_CleanAdditionalAddress := Append_CleanAdditionalAddress(NewBaseCleanAddress):independent;
	
	// Append Lexid
	EXPORT NewBaseLexid := Append_Lexid (Append_CleanAdditionalAddress):independent;

	// Append RinID
	EXPORT NewBaseRinID := Append_RinID (NewBaseLexid):independent;
	
	//Validate Deltabase 
	Export NewBaseDelta	:= fn_validate_delta(NewBaseRinID):independent;

	//Label RIN Source
	EXPORT AppendRinSourceLabel := FraudGovPlatform.Append_RinSource(NewBaseDelta):independent;
	//Add demo data GRP-5144
	Demo_main := dataset('~fraudgov::base::main_demo_anon',fraudshared.Layouts.base.main,thor);
	
	Export Build_Main_Prep := dedup(AppendRinSourceLabel + Demo_main,all);
	// Build Main File
	EXPORT Build_Main_Base := FraudShared.Build_Base_Main(pversion,Build_Main_Prep);

END;