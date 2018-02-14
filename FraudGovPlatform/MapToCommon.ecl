import tools, FraudShared,ut; 
EXPORT MapToCommon  (
	 string pversion
	,dataset(Layouts.Base.IdentityData) inBaseIdentityData = Files().Base.IdentityData.Built
	,dataset(Layouts.Base.KnownFraud) inBaseKnownFraud = Files().Base.KnownFraud.Built
	,dataset(Layouts.Base.InquiryLogs) inBaseInquiryLogs = Files().Base.InquiryLogs.Built
) :=
module  
	
	MBS_CVD := RECORD
		string20 gc_id := inBaseIdentityData.Client_ID;
		string100 file_code := inBaseIdentityData.Source;
	END;

	MBS_CVD_IDDT := DEDUP(TABLE(inBaseIdentityData,MBS_CVD),ALL);
	
 
	Export	IdentityData := project (inBaseIdentityData , transform(FraudShared.Layouts.Base.Main , 
		self.Record_ID := left.source_rec_id; 
		self.customer_id := left.Client_ID;
		self.Sub_Customer_ID := ''; 
		self.ln_report_date := left.Date_of_Transaction[1..8];
		self.Reported_Date := left.Date_of_Transaction[1..8];
		self.Event_Date := left.Date_of_Transaction[1..8];
		self.Reported_Time := '';			
		self.Reason_Description := left.Reason_for_Transaction_Activity;
		self.Fraud_Point_Score := '';  
		self.raw_title := left.Title;
		self.raw_First_Name := left.First_name;
		self.raw_Middle_Name := left.Middle_Name;
		self.raw_Last_Name := left.Last_Name;
		self.raw_Orig_Suffix := left.Suffix;
		self.raw_Full_name := left.Full_Name; 
		self.Drivers_License := left.Drivers_License_Number;
		self.Street_1 := left.Physical_Address_1;
		self.Street_2 := left.Physical_Address_2;
		self.Business_Name := left.Customer_Name; 
		self.clean_business_name := trim(left.Customer_Name,left,right); 
		self.FEIN := '';  
		self.Rawlinkid := left.lexid; 
		self.work_phone := '';
		self.address_1 := tools.AID_Helpers.fRawFixLine1( trim(left.Physical_Address_1) + ' ' +  trim(left.Physical_Address_2));
		self.address_2 := tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(left.city) + if(left.state != '', ', ', '') + trim(left.state)  + ' ' + trim(left.zip)[1..5]));  
		self.transaction_id := left.Transaction_ID_Number;
		self.investigation_referral_case_id := left.Case_ID;
		self.additional_address.Street_1 := left.Mailing_Address_1; 
		self.additional_address.Street_2 := left.Mailing_Address_2;
		self.additional_address.City := left.Mailing_City;
		self.additional_address.State := left.Mailing_State;
		self.additional_address.Zip := left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.additional_address.address_1 := tools.AID_Helpers.fRawFixLine1( trim(left.Mailing_Address_1) + ' ' + trim(left.Mailing_Address_2));;
		self.additional_address.address_2 := tools.AID_Helpers.fRawFixLineLast(  stringlib.stringtouppercase(trim(left.Mailing_City) + if(left.Mailing_State != '', ', ', '') + trim(left.Mailing_State)  + ' ' + trim(left.Mailing_Zip)[1..5]));
		self:= left; 
		self:= [];
	)); 
 
	Export	KnownFraud := project (inBaseKnownFraud , transform(FraudShared.Layouts.Base.Main , 
		self.Record_ID := left.source_rec_id;
		self.customer_id := left.client_id;
		self.Sub_Customer_ID := ''; 
		self.ln_report_date := left.reported_date;
		self.Reason_Description := left.reason_description;
		self.Fraud_Point_Score:= '';  
		self.raw_title := left.Title;
		self.raw_First_Name := left.First_name;
		self.raw_Middle_Name := left.Middle_Name;
		self.raw_Last_Name := left.Last_Name;
		self.raw_Orig_Suffix := left.orig_suffix;
		self.raw_Full_name := left.Full_Name; 
		self.Street_1 := left.physical_address_1;
		self.Street_2 := left.physical_address_2;
		self.clean_business_name    := trim(left.business_name,left,right); 		self.address_1				 :=	tools.AID_Helpers.fRawFixLine1(	trim(left.Physical_Address_1) + ' ' + 	trim(left.Physical_Address_2));
		self.address_2 :=	tools.AID_Helpers.fRawFixLineLast(  stringlib.stringtouppercase(trim(left.city) + if(left.state != '', ', ', '')  + trim(left.state) + ' ' + trim(left.zip)[1..5]));    
		self.Rawlinkid := left.lexid; 
		self.transaction_id := left.customer_event_id;
		self.Drivers_License := left.drivers_license_number;
		gc_id := (unsigned6) left.Client_ID; 
		self.investigation_referral_case_id  := left.investigation_referral_case_id;
		self.additional_address.Street_1 := left.Mailing_Address_1; 
		self.additional_address.Street_2 := left.Mailing_Address_2;
		self.additional_address.City := left.Mailing_City;
		self.additional_address.State := left.Mailing_State;
		self.additional_address.Zip := left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.additional_address.address_1 := tools.AID_Helpers.fRawFixLine1(	trim(left.Mailing_Address_1) + ' ' + trim(left.Mailing_Address_2));
		self.additional_address.address_2 := tools.AID_Helpers.fRawFixLineLast(stringlib.stringtouppercase(trim(left.Mailing_City)+ if(left.Mailing_State != '', ', ', '')+ trim(left.Mailing_State)+ ' ' + trim(left.Mailing_Zip)[1..5]));
		self:= left; 
		self:= [];
	)); 
	
	Export	InquiryLogs := project (inBaseInquiryLogs , transform(FraudShared.Layouts.Base.Main , 
		self.Record_ID := left.source_rec_id;
		self.customer_id := left.Client_ID;
		self.Sub_Customer_ID := ''; 
		self.ln_report_date := left.Date_of_Transaction[1..8];
		self.Reported_Date := left.Reported_Date[1..8];
		self.Reported_Time := left.Reported_Date[9..14];
		self.Event_Date := left.Date_of_Transaction[1..8];
		self.Reason_Description := left.Reason_for_Transaction_Activity;
		self.Fraud_Point_Score := '';  
		self.raw_title := left.Title;
		self.raw_First_Name := left.First_name;
		self.raw_Middle_Name := left.Middle_Name;
		self.raw_Last_Name := left.Last_Name;
		self.raw_Orig_Suffix := left.Suffix;
		self.raw_Full_name := left.Full_Name; 
		self.Drivers_License := left.Drivers_License_Number;
		self.Street_1 := left.Physical_Address;
		self.Street_2 := '';
		self.Business_Name := ''; 
		self.clean_business_name := ''; 
		self.FEIN := '';  
		self.work_phone := '';
		self.address_1 :=	tools.AID_Helpers.fRawFixLine1(trim(left.Physical_Address));
		self.address_2 :=  tools.AID_Helpers.fRawFixLineLast(stringlib.stringtouppercase(trim(left.city)+ if(left.state != '', ', ', '')+ trim(left.state)+ ' '+ trim(left.zip)[1..5]));  
		self.Rawlinkid := left.lexid; 
		self.transaction_id		 := left.Transaction_ID_Number;
		self.investigation_referral_case_id := left.Case_ID;
		self.additional_address.Street_1 := left.Mailing_Address; 
		self.additional_address.Street_2 := '';
		self.additional_address.City := left.Mailing_City;
		self.additional_address.State := left.Mailing_State;
		self.additional_address.Zip := left.Mailing_Zip;
		self.additional_address.Address_Type := 'Mailing';
		self.additional_address.address_1 := tools.AID_Helpers.fRawFixLine1(trim(left.Mailing_Address));
		self.additional_address.address_2 := tools.AID_Helpers.fRawFixLineLast(stringlib.stringtouppercase(trim(left.Mailing_City)+ if(left.Mailing_State != '', ', ', '')+ trim(left.Mailing_State)+ ' '+ trim(left.Mailing_Zip)[1..5]));     
		self:= left; 
		self:= [];
	)); 
 	
// Append MBS classification attributes 
		seed_In := FraudGovPlatform.testseed.test_lexid	+ FraudGovPlatform.testseed.test_ssn	+ FraudGovPlatform.testseed.test_ip ;
		Fraudshared.layouts.base.main seedprep (seed_In l,integer c) := transform
																		self.source_rec_id := max(inBaseIdentityData,source_rec_id) +c;
																		self:=l;
																		self:=[];
																		end;
		seed_Out := Project(seed_In,seedprep(left,counter));
  CombinedClassification := Functions.Classification(IdentityData + KnownFraud + InquiryLogs + If(Fraudshared.Platform.Source = 'FraudGov'  ,seed_Out)) ; 
	
	// append rid 
	

 // Filter header records
 NewBaseRid := CombinedClassification (Customer_event_id not in ['CUST_ID_NUM','CUSTOMERID']);

 EXPORT Build_Base_Main := FraudShared.Build_Base_Main(pversion,NewBaseRid);

END;