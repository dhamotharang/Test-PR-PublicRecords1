import tools, FraudShared,ut; 
EXPORT MapToCommon  (
	 string pversion
	,dataset(Layouts.Base.IdentityData) inBaseIdentityData = Files().Base.IdentityData.Built
	,dataset(Layouts.Base.KnownFraud) inBaseKnownFraud = Files().Base.KnownFraud.Built
) :=
module  
	
	MBS_CVD := RECORD
		string20 gc_id := inBaseIdentityData.Customer_Account_Number;
		string100 file_code := inBaseIdentityData.Source;
	END;

	MBS_CVD_IDDT := DEDUP(TABLE(inBaseIdentityData,MBS_CVD),ALL);
	
 
	Export	IdentityData := project (inBaseIdentityData , transform(FraudShared.Layouts.Base.Main , 
		self.Record_ID := left.source_rec_id; 
		self.customer_id := left.Customer_Account_Number;
		self.Sub_Customer_ID := ''; 
		self.ln_report_date := left.Date_of_Transaction[1..8];
		self.Reported_Date := left.Date_of_Transaction[1..8];
		self.Event_Date := left.Date_of_Transaction[1..8];
		self.Reported_Time := '';			
		self.Reason_Description := left.Reason_for_Transaction_Activity;
		self.Fraud_Point_Score := '';  
		self.Drivers_License := left.Drivers_License_Number;
		self.Business_Name := ''; 
		self.clean_business_name := ''; 
		self.FEIN := '';  
		self.Rawlinkid := left.lexid; 
		self.work_phone := '';
		self.transaction_id := left.Transaction_ID_Number;
		self.investigation_referral_case_id := left.Case_ID;
		self.additional_address.Street_1 := left.Mailing_Street_1; 
		self.additional_address.Street_2 := left.Mailing_Street_2;
		self.additional_address.City := left.Mailing_City;
		self.additional_address.State := left.Mailing_State;
		self.additional_address.Zip := left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.additional_address.address_1 := left.mailing_address_1;
		self.additional_address.address_2 := left.mailing_address_2;
		self.Household_ID := left.Case_ID;
		self.Customer_Person_ID := left.Client_ID;
		self:= left; 
		self:= [];
	)); 
 
	Export	KnownFraud := project (inBaseKnownFraud , transform(FraudShared.Layouts.Base.Main , 
		self.Record_ID := left.source_rec_id;
		self.customer_id := left.Customer_Account_Number;
		self.Sub_Customer_ID := ''; 
		self.ln_report_date := left.reported_date;
		self.Fraud_Point_Score:= '';  
		self.clean_business_name    := ''; 
		self.Rawlinkid := left.lexid; 
		self.transaction_id := left.customer_event_id;
		self.Drivers_License := left.drivers_license_number;
		self.investigation_referral_case_id  := left.investigation_referral_case_id;
		self.additional_address.Street_1 := left.Mailing_Street_1; 
		self.additional_address.Street_2 := left.Mailing_Street_2;
		self.additional_address.City := left.Mailing_City;
		self.additional_address.State := left.Mailing_State;
		self.additional_address.Zip := left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.additional_address.address_1 := left.mailing_address_1;
		self.additional_address.address_2 := left.mailing_address_2;		
		self.Household_ID := left.Case_ID;
		self.Customer_Person_ID := left.Client_ID;
		self:= left; 
		self:= [];
	)); 
	
	// Append MBS classification attributes 
	CombinedClassification := Functions.Classification(IdentityData + KnownFraud); 
	
	// append rid 
	// Filter header records
	NewBaseRid := CombinedClassification (Customer_event_id not in ['CUST_ID_NUM','CUSTOMERID']);
 
	// Append RinID
	NewBaseRinID := Append_RinID (NewBaseRid);

	EXPORT Build_Base_Main := FraudShared.Build_Base_Main(pversion,NewBaseRinID);

END;