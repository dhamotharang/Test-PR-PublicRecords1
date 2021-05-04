EXPORT fn_dedup_main(
	dataset(FraudGovPlatform.Layouts.Base.Main) FileBase
) := FUNCTION

    m_sort := sort(FileBase, Customer_ID,Sub_Customer_ID,Vendor_ID,offender_key,Sub_Sub_Customer_ID/*,Customer_Event_ID*/,Sub_Customer_Event_ID,Sub_Sub_Customer_Event_ID,LN_Product_ID,LN_Sub_Product_ID,LN_Sub_Sub_Product_ID,LN_Product_Key,LN_Report_Date,LN_Report_Time,Reported_Date,Reported_Time,Event_Date,Event_End_Date,Event_Location,Event_Type_1,Event_Type_2,Event_Type_3,Household_ID,Reason_Description,Investigation_Referral_Case_ID,Investigation_Referral_Date_Opened,Investigation_Referral_Date_Closed,Customer_Fraud_Code_1,Customer_Fraud_Code_2,Type_of_Referral,Referral_Reason,Disposition,Mitigated,Mitigated_Amount,External_Referral_or_CaseNumber,Fraud_Point_Score,Customer_Person_ID,raw_title,raw_First_Name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,raw_Full_name,SSN,DOB,Drivers_License,Drivers_License_State,Person_Date,Name_Type,income,own_or_rent,Rawlinkid,Street_1,Street_2,City,State,Zip,GPS_coordinates,Address_Date,Address_Type,Appended_Provider_ID,lnpid,Business_Name,TIN,FEIN,NPI,Business_Type_1,Business_Type_2,Business_Date,phone_number,cell_phone,Work_phone,Contact_Type,Contact_Date,Carrier,Contact_Location,Contact,Call_records,In_service,Email_Address,Email_Address_Type,Email_Date,Host,Alias,Location,IP_Address,IP_Address_Date,Version,Class,Subnet_mask,Reserved,ISP,Device_ID,Device_Date,Unique_number,MAC_Address,Serial_Number,Device_Type,Device_identification_Provider,/*Transaction_ID,*/Transaction_Type,Amount_of_Loss,Professional_ID,Profession_Type,Corresponding_Professional_IDs,Licensed_PR_State,vin,head_of_household_indicator,relationship_indicator,county,additional_address.Street_1,additional_address.Street_2,additional_address.City,additional_address.State,additional_address.Zip,additional_address.Address_Type,Race,Ethnicity,bank_routing_number_1,bank_account_number_1,bank_routing_number_2,bank_account_number_2,reported_by,name_risk_code,ssn_risk_code,dob_risk_code,drivers_license_risk_code,physical_address_risk_code,phone_risk_code,cell_phone_risk_code,work_phone_risk_code,bank_account_1_risk_code,bank_account_2_risk_code,email_address_risk_code,ip_address_fraud_code,business_risk_code,mailing_address_risk_code,device_risk_code,identity_risk_code,tax_preparer_id,start_date,end_date,amount_paid,region_code,investigator_id,source, rin_source, cleared_fraud,reason_cleared_code,geo_lat,geo_long,record_id);
    m_deduped := dedup(m_sort,Customer_ID,Sub_Customer_ID,Vendor_ID,offender_key,Sub_Sub_Customer_ID/*,Customer_Event_ID*/,Sub_Customer_Event_ID,Sub_Sub_Customer_Event_ID,LN_Product_ID,LN_Sub_Product_ID,LN_Sub_Sub_Product_ID,LN_Product_Key,LN_Report_Date,LN_Report_Time,Reported_Date,Reported_Time,Event_Date,Event_End_Date,Event_Location,Event_Type_1,Event_Type_2,Event_Type_3,Household_ID,Reason_Description,Investigation_Referral_Case_ID,Investigation_Referral_Date_Opened,Investigation_Referral_Date_Closed,Customer_Fraud_Code_1,Customer_Fraud_Code_2,Type_of_Referral,Referral_Reason,Disposition,Mitigated,Mitigated_Amount,External_Referral_or_CaseNumber,Fraud_Point_Score,Customer_Person_ID,raw_title,raw_First_Name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,raw_Full_name,SSN,DOB,Drivers_License,Drivers_License_State,Person_Date,Name_Type,income,own_or_rent,Rawlinkid,Street_1,Street_2,City,State,Zip,GPS_coordinates,Address_Date,Address_Type,Appended_Provider_ID,lnpid,Business_Name,TIN,FEIN,NPI,Business_Type_1,Business_Type_2,Business_Date,phone_number,cell_phone,Work_phone,Contact_Type,Contact_Date,Carrier,Contact_Location,Contact,Call_records,In_service,Email_Address,Email_Address_Type,Email_Date,Host,Alias,Location,IP_Address,IP_Address_Date,Version,Class,Subnet_mask,Reserved,ISP,Device_ID,Device_Date,Unique_number,MAC_Address,Serial_Number,Device_Type,Device_identification_Provider,/*Transaction_ID,*/Transaction_Type,Amount_of_Loss,Professional_ID,Profession_Type,Corresponding_Professional_IDs,Licensed_PR_State,vin,head_of_household_indicator,relationship_indicator,county,additional_address.Street_1,additional_address.Street_2,additional_address.City,additional_address.State,additional_address.Zip,additional_address.Address_Type,Race,Ethnicity,bank_routing_number_1,bank_account_number_1,bank_routing_number_2,bank_account_number_2,reported_by,name_risk_code,ssn_risk_code,dob_risk_code,drivers_license_risk_code,physical_address_risk_code,phone_risk_code,cell_phone_risk_code,work_phone_risk_code,bank_account_1_risk_code,bank_account_2_risk_code,email_address_risk_code,ip_address_fraud_code,business_risk_code,mailing_address_risk_code,device_risk_code,identity_risk_code,tax_preparer_id,start_date,end_date,amount_paid,region_code,investigator_id,source, rin_source, cleared_fraud,reason_cleared_code,geo_lat,geo_long);

    return( m_deduped );

END;