IMPORT Header, ut;
EXPORT Append_RID(
                 dataset(FraudGovPlatform.Layouts.Base.Main) Current_Build
                ,dataset(FraudGovPlatform.Layouts.Base.Main) Previous_Build = $.Files().Base.Main_Orig.QA
) := FUNCTION


		d_Current_Build  := distribute(Current_Build,hash32(Customer_ID,Sub_Customer_ID,Vendor_ID,offender_key,Sub_Sub_Customer_ID,Customer_Event_ID,Sub_Customer_Event_ID,Sub_Sub_Customer_Event_ID,LN_Product_ID,LN_Sub_Product_ID,LN_Sub_Sub_Product_ID,LN_Product_Key,LN_Report_Date,LN_Report_Time,Reported_Date,Reported_Time,Event_Date,Event_End_Date,Event_Location,Event_Type_1,Event_Type_2,Event_Type_3,Household_ID,Reason_Description,Investigation_Referral_Case_ID,Investigation_Referral_Date_Opened,Investigation_Referral_Date_Closed,Customer_Fraud_Code_1,Customer_Fraud_Code_2,Type_of_Referral,Referral_Reason,Disposition,Mitigated,Mitigated_Amount,External_Referral_or_CaseNumber,Fraud_Point_Score,Customer_Person_ID,raw_title,raw_First_Name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,raw_Full_name,SSN,DOB,Drivers_License,Drivers_License_State,Person_Date,Name_Type,income,own_or_rent,Rawlinkid,Street_1,Street_2,City,State,Zip,GPS_coordinates,Address_Date,Address_Type,Appended_Provider_ID,lnpid,Business_Name,TIN,FEIN,NPI,Business_Type_1,Business_Type_2,Business_Date,phone_number,cell_phone,Work_phone,Contact_Type,Contact_Date,Carrier,Contact_Location,Contact,Call_records,In_service,Email_Address,Email_Address_Type,Email_Date,Host,Alias,Location,IP_Address,IP_Address_Date,Version,Class,Subnet_mask,Reserved,ISP,Device_ID,Device_Date,Unique_number,MAC_Address,Serial_Number,Device_Type,Device_identification_Provider,Transaction_ID,Transaction_Type,Amount_of_Loss,Professional_ID,Profession_Type,Corresponding_Professional_IDs,Licensed_PR_State,vin,head_of_household_indicator,relationship_indicator,county,additional_address.Street_1,additional_address.Street_2,additional_address.City,additional_address.State,additional_address.Zip,additional_address.Address_Type,Race,Ethnicity,bank_routing_number_1,bank_account_number_1,bank_routing_number_2,bank_account_number_2,reported_by,name_risk_code,ssn_risk_code,dob_risk_code,drivers_license_risk_code,physical_address_risk_code,phone_risk_code,cell_phone_risk_code,work_phone_risk_code,bank_account_1_risk_code,bank_account_2_risk_code,email_address_risk_code,ip_address_fraud_code,business_risk_code,mailing_address_risk_code,device_risk_code,identity_risk_code,tax_preparer_id,start_date,end_date,amount_paid,region_code,investigator_id,cleared_fraud,reason_cleared_code,geo_lat,geo_long, source_rec_id));
    	d_Previous_Build := distribute(Previous_Build,hash32(Customer_ID,Sub_Customer_ID,Vendor_ID,offender_key,Sub_Sub_Customer_ID,Customer_Event_ID,Sub_Customer_Event_ID,Sub_Sub_Customer_Event_ID,LN_Product_ID,LN_Sub_Product_ID,LN_Sub_Sub_Product_ID,LN_Product_Key,LN_Report_Date,LN_Report_Time,Reported_Date,Reported_Time,Event_Date,Event_End_Date,Event_Location,Event_Type_1,Event_Type_2,Event_Type_3,Household_ID,Reason_Description,Investigation_Referral_Case_ID,Investigation_Referral_Date_Opened,Investigation_Referral_Date_Closed,Customer_Fraud_Code_1,Customer_Fraud_Code_2,Type_of_Referral,Referral_Reason,Disposition,Mitigated,Mitigated_Amount,External_Referral_or_CaseNumber,Fraud_Point_Score,Customer_Person_ID,raw_title,raw_First_Name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,raw_Full_name,SSN,DOB,Drivers_License,Drivers_License_State,Person_Date,Name_Type,income,own_or_rent,Rawlinkid,Street_1,Street_2,City,State,Zip,GPS_coordinates,Address_Date,Address_Type,Appended_Provider_ID,lnpid,Business_Name,TIN,FEIN,NPI,Business_Type_1,Business_Type_2,Business_Date,phone_number,cell_phone,Work_phone,Contact_Type,Contact_Date,Carrier,Contact_Location,Contact,Call_records,In_service,Email_Address,Email_Address_Type,Email_Date,Host,Alias,Location,IP_Address,IP_Address_Date,Version,Class,Subnet_mask,Reserved,ISP,Device_ID,Device_Date,Unique_number,MAC_Address,Serial_Number,Device_Type,Device_identification_Provider,Transaction_ID,Transaction_Type,Amount_of_Loss,Professional_ID,Profession_Type,Corresponding_Professional_IDs,Licensed_PR_State,vin,head_of_household_indicator,relationship_indicator,county,additional_address.Street_1,additional_address.Street_2,additional_address.City,additional_address.State,additional_address.Zip,additional_address.Address_Type,Race,Ethnicity,bank_routing_number_1,bank_account_number_1,bank_routing_number_2,bank_account_number_2,reported_by,name_risk_code,ssn_risk_code,dob_risk_code,drivers_license_risk_code,physical_address_risk_code,phone_risk_code,cell_phone_risk_code,work_phone_risk_code,bank_account_1_risk_code,bank_account_2_risk_code,email_address_risk_code,ip_address_fraud_code,business_risk_code,mailing_address_risk_code,device_risk_code,identity_risk_code,tax_preparer_id,start_date,end_date,amount_paid,region_code,investigator_id,cleared_fraud,reason_cleared_code,geo_lat,geo_long, source_rec_id));

		JoinRec		:= JOIN(d_Current_Build, 
											d_Previous_Build,
											ut.CleanSpacesandUpper(left.Customer_ID)= ut.CleanSpacesandUpper(right.Customer_ID) and
											ut.CleanSpacesandUpper(left.Sub_Customer_ID)= ut.CleanSpacesandUpper(right.Sub_Customer_ID) and
											ut.CleanSpacesandUpper(left.Vendor_ID)= ut.CleanSpacesandUpper(right.Vendor_ID) and
											ut.CleanSpacesandUpper(left.offender_key)= ut.CleanSpacesandUpper(right.offender_key) and
											ut.CleanSpacesandUpper(left.Sub_Sub_Customer_ID)= ut.CleanSpacesandUpper(right.Sub_Sub_Customer_ID) and
											ut.CleanSpacesandUpper(left.Customer_Event_ID)= ut.CleanSpacesandUpper(right.Customer_Event_ID) and
											ut.CleanSpacesandUpper(left.Sub_Customer_Event_ID)= ut.CleanSpacesandUpper(right.Sub_Customer_Event_ID) and
											ut.CleanSpacesandUpper(left.Sub_Sub_Customer_Event_ID)= ut.CleanSpacesandUpper(right.Sub_Sub_Customer_Event_ID) and
											ut.CleanSpacesandUpper(left.LN_Product_ID)= ut.CleanSpacesandUpper(right.LN_Product_ID) and
											ut.CleanSpacesandUpper(left.LN_Sub_Product_ID)= ut.CleanSpacesandUpper(right.LN_Sub_Product_ID) and
											ut.CleanSpacesandUpper(left.LN_Sub_Sub_Product_ID)= ut.CleanSpacesandUpper(right.LN_Sub_Sub_Product_ID) and
											ut.CleanSpacesandUpper(left.LN_Product_Key)= ut.CleanSpacesandUpper(right.LN_Product_Key) and
											ut.CleanSpacesandUpper(left.LN_Report_Date)= ut.CleanSpacesandUpper(right.LN_Report_Date) and
											ut.CleanSpacesandUpper(left.LN_Report_Time)= ut.CleanSpacesandUpper(right.LN_Report_Time) and
											ut.CleanSpacesandUpper(left.Reported_Date)= ut.CleanSpacesandUpper(right.Reported_Date) and
											ut.CleanSpacesandUpper(left.Reported_Time)= ut.CleanSpacesandUpper(right.Reported_Time) and
											ut.CleanSpacesandUpper(left.Event_Date)= ut.CleanSpacesandUpper(right.Event_Date) and
											ut.CleanSpacesandUpper(left.Event_End_Date)= ut.CleanSpacesandUpper(right.Event_End_Date) and
											ut.CleanSpacesandUpper(left.Event_Location)= ut.CleanSpacesandUpper(right.Event_Location) and
											ut.CleanSpacesandUpper(left.Event_Type_1)= ut.CleanSpacesandUpper(right.Event_Type_1) and
											ut.CleanSpacesandUpper(left.Event_Type_2)= ut.CleanSpacesandUpper(right.Event_Type_2) and
											ut.CleanSpacesandUpper(left.Event_Type_3)= ut.CleanSpacesandUpper(right.Event_Type_3) and
											ut.CleanSpacesandUpper(left.Household_ID)= ut.CleanSpacesandUpper(right.Household_ID) and
											ut.CleanSpacesandUpper(left.Reason_Description)= ut.CleanSpacesandUpper(right.Reason_Description) and
											ut.CleanSpacesandUpper(left.Investigation_Referral_Case_ID)= ut.CleanSpacesandUpper(right.Investigation_Referral_Case_ID) and
											ut.CleanSpacesandUpper(left.Investigation_Referral_Date_Opened)= ut.CleanSpacesandUpper(right.Investigation_Referral_Date_Opened) and
											ut.CleanSpacesandUpper(left.Investigation_Referral_Date_Closed)= ut.CleanSpacesandUpper(right.Investigation_Referral_Date_Closed) and
											ut.CleanSpacesandUpper(left.Customer_Fraud_Code_1)= ut.CleanSpacesandUpper(right.Customer_Fraud_Code_1) and
											ut.CleanSpacesandUpper(left.Customer_Fraud_Code_2)= ut.CleanSpacesandUpper(right.Customer_Fraud_Code_2) and
											ut.CleanSpacesandUpper(left.Type_of_Referral)= ut.CleanSpacesandUpper(right.Type_of_Referral) and
											ut.CleanSpacesandUpper(left.Referral_Reason)= ut.CleanSpacesandUpper(right.Referral_Reason) and
											ut.CleanSpacesandUpper(left.Disposition)= ut.CleanSpacesandUpper(right.Disposition) and
											ut.CleanSpacesandUpper(left.Mitigated)= ut.CleanSpacesandUpper(right.Mitigated) and
											ut.CleanSpacesandUpper(left.Mitigated_Amount)= ut.CleanSpacesandUpper(right.Mitigated_Amount) and
											ut.CleanSpacesandUpper(left.External_Referral_or_CaseNumber)= ut.CleanSpacesandUpper(right.External_Referral_or_CaseNumber) and
											ut.CleanSpacesandUpper(left.Fraud_Point_Score)= ut.CleanSpacesandUpper(right.Fraud_Point_Score) and
											ut.CleanSpacesandUpper(left.Customer_Person_ID)= ut.CleanSpacesandUpper(right.Customer_Person_ID) and
											ut.CleanSpacesandUpper(left.raw_title)= ut.CleanSpacesandUpper(right.raw_title) and
											ut.CleanSpacesandUpper(left.raw_First_Name)= ut.CleanSpacesandUpper(right.raw_First_Name) and
											ut.CleanSpacesandUpper(left.raw_Middle_Name)= ut.CleanSpacesandUpper(right.raw_Middle_Name) and
											ut.CleanSpacesandUpper(left.raw_Last_Name)= ut.CleanSpacesandUpper(right.raw_Last_Name) and
											ut.CleanSpacesandUpper(left.raw_Orig_Suffix)= ut.CleanSpacesandUpper(right.raw_Orig_Suffix) and
											ut.CleanSpacesandUpper(left.raw_Full_name)= ut.CleanSpacesandUpper(right.raw_Full_name) and
											ut.CleanSpacesandUpper(left.SSN)= ut.CleanSpacesandUpper(right.SSN) and
											ut.CleanSpacesandUpper(left.DOB)= ut.CleanSpacesandUpper(right.DOB) and
											ut.CleanSpacesandUpper(left.Drivers_License)= ut.CleanSpacesandUpper(right.Drivers_License) and
											ut.CleanSpacesandUpper(left.Drivers_License_State)= ut.CleanSpacesandUpper(right.Drivers_License_State) and
											ut.CleanSpacesandUpper(left.Person_Date)= ut.CleanSpacesandUpper(right.Person_Date) and
											ut.CleanSpacesandUpper(left.Name_Type)= ut.CleanSpacesandUpper(right.Name_Type) and
											ut.CleanSpacesandUpper(left.income)= ut.CleanSpacesandUpper(right.income) and
											ut.CleanSpacesandUpper(left.own_or_rent)= ut.CleanSpacesandUpper(right.own_or_rent) and
											left.Rawlinkid = right.Rawlinkid and
											ut.CleanSpacesandUpper(left.Street_1)= ut.CleanSpacesandUpper(right.Street_1) and
											ut.CleanSpacesandUpper(left.Street_2)= ut.CleanSpacesandUpper(right.Street_2) and
											ut.CleanSpacesandUpper(left.City)= ut.CleanSpacesandUpper(right.City) and
											ut.CleanSpacesandUpper(left.State)= ut.CleanSpacesandUpper(right.State) and
											ut.CleanSpacesandUpper(left.Zip)= ut.CleanSpacesandUpper(right.Zip) and
											ut.CleanSpacesandUpper(left.GPS_coordinates)= ut.CleanSpacesandUpper(right.GPS_coordinates) and
											ut.CleanSpacesandUpper(left.Address_Date)= ut.CleanSpacesandUpper(right.Address_Date) and
											ut.CleanSpacesandUpper(left.Address_Type)= ut.CleanSpacesandUpper(right.Address_Type) and
											left.Appended_Provider_ID = right.Appended_Provider_ID and
											left.lnpid = right.lnpid and
											ut.CleanSpacesandUpper(left.Business_Name)= ut.CleanSpacesandUpper(right.Business_Name) and
											ut.CleanSpacesandUpper(left.TIN)= ut.CleanSpacesandUpper(right.TIN) and
											ut.CleanSpacesandUpper(left.FEIN)= ut.CleanSpacesandUpper(right.FEIN) and
											ut.CleanSpacesandUpper(left.NPI)= ut.CleanSpacesandUpper(right.NPI) and
											ut.CleanSpacesandUpper(left.Business_Type_1)= ut.CleanSpacesandUpper(right.Business_Type_1) and
											ut.CleanSpacesandUpper(left.Business_Type_2)= ut.CleanSpacesandUpper(right.Business_Type_2) and
											ut.CleanSpacesandUpper(left.Business_Date)= ut.CleanSpacesandUpper(right.Business_Date) and
											ut.CleanSpacesandUpper(left.phone_number)= ut.CleanSpacesandUpper(right.phone_number ) and
											ut.CleanSpacesandUpper(left.cell_phone)= ut.CleanSpacesandUpper(right.cell_phone) and
											ut.CleanSpacesandUpper(left.Work_phone)= ut.CleanSpacesandUpper(right.Work_phone ) and
											ut.CleanSpacesandUpper(left.Contact_Type)= ut.CleanSpacesandUpper(right.Contact_Type) and
											ut.CleanSpacesandUpper(left.Contact_Date)= ut.CleanSpacesandUpper(right.Contact_Date) and
											ut.CleanSpacesandUpper(left.Carrier)= ut.CleanSpacesandUpper(right.Carrier) and
											ut.CleanSpacesandUpper(left.Contact_Location)= ut.CleanSpacesandUpper(right.Contact_Location) and
											ut.CleanSpacesandUpper(left.Contact)= ut.CleanSpacesandUpper(right.Contact) and
											ut.CleanSpacesandUpper(left.Call_records)= ut.CleanSpacesandUpper(right.Call_records) and
											ut.CleanSpacesandUpper(left.In_service)= ut.CleanSpacesandUpper(right.In_service) and
											ut.CleanSpacesandUpper(left.Email_Address)= ut.CleanSpacesandUpper(right.Email_Address) and
											ut.CleanSpacesandUpper(left.Email_Address_Type)= ut.CleanSpacesandUpper(right.Email_Address_Type) and
											ut.CleanSpacesandUpper(left.Email_Date)= ut.CleanSpacesandUpper(right.Email_Date) and
											ut.CleanSpacesandUpper(left.Host)= ut.CleanSpacesandUpper(right.Host) and
											ut.CleanSpacesandUpper(left.Alias)= ut.CleanSpacesandUpper(right.Alias) and
											ut.CleanSpacesandUpper(left.Location)= ut.CleanSpacesandUpper(right.Location) and
											ut.CleanSpacesandUpper(left.IP_Address)= ut.CleanSpacesandUpper(right.IP_Address) and
											ut.CleanSpacesandUpper(left.IP_Address_Date)= ut.CleanSpacesandUpper(right.IP_Address_Date) and
											ut.CleanSpacesandUpper(left.Version)= ut.CleanSpacesandUpper(right.Version) and
											ut.CleanSpacesandUpper(left.Class)= ut.CleanSpacesandUpper(right.Class) and
											ut.CleanSpacesandUpper(left.Subnet_mask)= ut.CleanSpacesandUpper(right.Subnet_mask) and
											ut.CleanSpacesandUpper(left.Reserved)= ut.CleanSpacesandUpper(right.Reserved) and
											ut.CleanSpacesandUpper(left.ISP)= ut.CleanSpacesandUpper(right.ISP) and
											ut.CleanSpacesandUpper(left.Device_ID)= ut.CleanSpacesandUpper(right.Device_ID) and
											ut.CleanSpacesandUpper(left.Device_Date)= ut.CleanSpacesandUpper(right.Device_Date) and
											ut.CleanSpacesandUpper(left.Unique_number)= ut.CleanSpacesandUpper(right.Unique_number) and
											ut.CleanSpacesandUpper(left.MAC_Address)= ut.CleanSpacesandUpper(right.MAC_Address) and
											ut.CleanSpacesandUpper(left.Serial_Number)= ut.CleanSpacesandUpper(right.Serial_Number) and
											ut.CleanSpacesandUpper(left.Device_Type )= ut.CleanSpacesandUpper(right.Device_Type ) and
											ut.CleanSpacesandUpper(left.Device_identification_Provider)= ut.CleanSpacesandUpper(right.Device_identification_Provider) and
											ut.CleanSpacesandUpper(left.Transaction_ID)= ut.CleanSpacesandUpper(right.Transaction_ID) and
											ut.CleanSpacesandUpper(left.Transaction_Type)= ut.CleanSpacesandUpper(right.Transaction_Type) and
											ut.CleanSpacesandUpper(left.Amount_of_Loss)= ut.CleanSpacesandUpper(right.Amount_of_Loss) and
											ut.CleanSpacesandUpper(left.Professional_ID)= ut.CleanSpacesandUpper(right.Professional_ID) and
											ut.CleanSpacesandUpper(left.Profession_Type)= ut.CleanSpacesandUpper(right.Profession_Type) and
											ut.CleanSpacesandUpper(left.Corresponding_Professional_IDs)= ut.CleanSpacesandUpper(right.Corresponding_Professional_IDs) and
											ut.CleanSpacesandUpper(left.Licensed_PR_State)= ut.CleanSpacesandUpper(right.Licensed_PR_State) and
											ut.CleanSpacesandUpper(left.vin)= ut.CleanSpacesandUpper(right.vin) and
											ut.CleanSpacesandUpper(left.head_of_household_indicator)= ut.CleanSpacesandUpper(right.head_of_household_indicator) and
											ut.CleanSpacesandUpper(left.relationship_indicator)= ut.CleanSpacesandUpper(right.relationship_indicator) and
											ut.CleanSpacesandUpper(left.county)= ut.CleanSpacesandUpper(right.county) and
											ut.CleanSpacesandUpper(left.additional_address.Street_1)= ut.CleanSpacesandUpper(right.additional_address.Street_1) and
											ut.CleanSpacesandUpper(left.additional_address.Street_2)= ut.CleanSpacesandUpper(right.additional_address.Street_2) and
											ut.CleanSpacesandUpper(left.additional_address.City)= ut.CleanSpacesandUpper(right.additional_address.City) and
											ut.CleanSpacesandUpper(left.additional_address.State)= ut.CleanSpacesandUpper(right.additional_address.State) and
											ut.CleanSpacesandUpper(left.additional_address.Zip)= ut.CleanSpacesandUpper(right.additional_address.Zip) and
											ut.CleanSpacesandUpper(left.additional_address.Address_Type)= ut.CleanSpacesandUpper(right.additional_address.Address_Type) and
											ut.CleanSpacesandUpper(left.Race)= ut.CleanSpacesandUpper(right.Race) and
											ut.CleanSpacesandUpper(left.Ethnicity)= ut.CleanSpacesandUpper(right.Ethnicity) and
											ut.CleanSpacesandUpper(left.bank_routing_number_1)= ut.CleanSpacesandUpper(right.bank_routing_number_1) and
											ut.CleanSpacesandUpper(left.bank_account_number_1)= ut.CleanSpacesandUpper(right.bank_account_number_1) and
											ut.CleanSpacesandUpper(left.bank_routing_number_2)= ut.CleanSpacesandUpper(right.bank_routing_number_2) and
											ut.CleanSpacesandUpper(left.bank_account_number_2)= ut.CleanSpacesandUpper(right.bank_account_number_2) and
											ut.CleanSpacesandUpper(left.reported_by)= ut.CleanSpacesandUpper(right.reported_by) and
											ut.CleanSpacesandUpper(left.name_risk_code)= ut.CleanSpacesandUpper(right.name_risk_code) and
											ut.CleanSpacesandUpper(left.ssn_risk_code)= ut.CleanSpacesandUpper(right.ssn_risk_code) and
											ut.CleanSpacesandUpper(left.dob_risk_code)= ut.CleanSpacesandUpper(right.dob_risk_code) and
											ut.CleanSpacesandUpper(left.drivers_license_risk_code)= ut.CleanSpacesandUpper(right.drivers_license_risk_code) and
											ut.CleanSpacesandUpper(left.physical_address_risk_code)= ut.CleanSpacesandUpper(right.physical_address_risk_code) and
											ut.CleanSpacesandUpper(left.phone_risk_code)= ut.CleanSpacesandUpper(right.phone_risk_code) and
											ut.CleanSpacesandUpper(left.cell_phone_risk_code)= ut.CleanSpacesandUpper(right.cell_phone_risk_code) and
											ut.CleanSpacesandUpper(left.work_phone_risk_code)= ut.CleanSpacesandUpper(right.work_phone_risk_code) and
											ut.CleanSpacesandUpper(left.bank_account_1_risk_code)= ut.CleanSpacesandUpper(right.bank_account_1_risk_code) and
											ut.CleanSpacesandUpper(left.bank_account_2_risk_code)= ut.CleanSpacesandUpper(right.bank_account_2_risk_code) and
											ut.CleanSpacesandUpper(left.email_address_risk_code)= ut.CleanSpacesandUpper(right.email_address_risk_code) and
											ut.CleanSpacesandUpper(left.ip_address_fraud_code)= ut.CleanSpacesandUpper(right.ip_address_fraud_code) and
											ut.CleanSpacesandUpper(left.business_risk_code)= ut.CleanSpacesandUpper(right.business_risk_code) and
											ut.CleanSpacesandUpper(left.mailing_address_risk_code)= ut.CleanSpacesandUpper(right.mailing_address_risk_code) and
											ut.CleanSpacesandUpper(left.device_risk_code)= ut.CleanSpacesandUpper(right.device_risk_code) and
											ut.CleanSpacesandUpper(left.identity_risk_code)= ut.CleanSpacesandUpper(right.identity_risk_code) and
											ut.CleanSpacesandUpper(left.tax_preparer_id)= ut.CleanSpacesandUpper(right.tax_preparer_id) and
											ut.CleanSpacesandUpper(left.start_date)= ut.CleanSpacesandUpper(right.start_date) and
											ut.CleanSpacesandUpper(left.end_date)= ut.CleanSpacesandUpper(right.end_date) and
											ut.CleanSpacesandUpper(left.amount_paid)= ut.CleanSpacesandUpper(right.amount_paid) and
											ut.CleanSpacesandUpper(left.region_code)= ut.CleanSpacesandUpper(right.region_code) and
											ut.CleanSpacesandUpper(left.investigator_id)= ut.CleanSpacesandUpper(right.investigator_id) and 
                                            ut.CleanSpacesandUpper(left.cleared_fraud)= ut.CleanSpacesandUpper(right.cleared_fraud) and 
                                            ut.CleanSpacesandUpper(left.reason_cleared_code)= ut.CleanSpacesandUpper(right.reason_cleared_code) and 
                                            ut.CleanSpacesandUpper(left.geo_lat)= ut.CleanSpacesandUpper(right.geo_lat) and 
                                            ut.CleanSpacesandUpper(left.geo_long)= ut.CleanSpacesandUpper(right.geo_long) and 
											left.source_rec_id = right.source_rec_id  and 
											ut.CleanSpacesandUpper(left.Duration) = ut.CleanSpacesandUpper(right.Duration) and
											ut.CleanSpacesandUpper(left.TransactionStatus) = ut.CleanSpacesandUpper(right.TransactionStatus) and
											ut.CleanSpacesandUpper(left.Reason) = ut.CleanSpacesandUpper(right.Reason),
											transform(FraudGovPlatform.Layouts.Base.Main, 
												SELF.Record_ID := if( left.source = right.source and left.source_rec_id = right.source_rec_id, RIGHT.Record_ID, LEFT.Record_ID); 
												SELF:=LEFT; SELF:=[]),
											LEFT OUTER,
        KEEP(1),
        LOCAL
											);
		
		old_RIDs := JoinRec(record_id > 0);
		new_recs := JoinRec(record_id = 0); 

		max_rid := max(Previous_Build, Previous_Build.Record_ID) + 1;
		
		MAC_Sequence_Records(new_recs, record_id,new_RIDs, max_rid);
									 
		prj_new_RIDs := project(new_RIDs, transform(FraudGovPlatform.Layouts.Base.Main, self := left));

		return prj_new_RIDs + old_RIDs;

END;
