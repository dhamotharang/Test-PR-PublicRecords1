import address, AID;

EXPORT layout := module

export tiger_direct := record

string App_Number;
string Loan_Number;
string Primary_Fraud_Code;
string Location_Identifier;
string FIRST_NAME;
string MID_NAME;
string LAST_NAME;
string HOME_PHONE;
string CELL_PHONE;
string SSN;
string EMAIL;
string OWN_RENT_OTHER;
string CUST_ID_TYPE;
string CUST_ID_NUM;
string CUST_ID_SOURCE;
string DOB;
string App_Source;
string app_date;
string IP_ADDRESS;
string ADDRESS1;
string CITY;
string STATE;
string ZIPCODE;
string NET_INCOME;
string FP1_Score;
string FP2_Score;

end;

EXPORT preclean_CFD := record
tiger_direct;
//string address1;
string address2;
string name_clean;
Address.Layout_Clean182_fips;
AID.Common.xAID							Append_RawAID; 
 string5         title;
	string20        fname;
	string20        mname;
	string20        lname;
	string5         name_suffix;
	unsigned8 nid:=0;
	unsigned2  name_ind:=0;  // name indicator bitmap
	unsigned6  did := 0;
	unsigned1  did_score := 0;
end;


export base := record

string customer_ID;
string vendor_ID;
unsigned6 appended_LexID;
string Date_Fraud_Reported_LN;
string first_name;
string middle_name;
string Last_name;
string suffix;
string street_address;
string city;
string state;
string zip_code;
string10 Phone_number;
string9 SSN;
string8 DOB;
string Driver_License_Number;
string Driver_License_State;
string50 IP_Address;
string50 Email_Address;
string Device_Identification;
string Device_identification_Provider;
string Origination_Channel;
string Income;
string Own_or_Rent;
string Location_Identifier;
string Other_Application_Identifier;
string Other_Application_Identifier2;
string Other_Application_Identifier3;
string Date_Application;
string Time_Application;
string Application_ID;
string FraudPoint_Score;
string Date_Fraud_Detected;
string Financial_Loss;
string Gross_Fraud_Dollar_Loss;
string Application_Fraud;
string Primary_Fraud_Code;
string Secondary_Fraud_Code;
string Source_Identifier;
string LN_Product_ID;
string LN_Sub_Product_ID;
string Industry;
string Fraud_Index_Type;
string5         title;
string20        fname;
string20        mname;
string20        lname;
string5         name_suffix;
Address.Layout_Clean182_fips;

end;

export credit_fraud := record

string customer_ID;
string vendor_ID;
unsigned6 appended_LexID;
string Date_Fraud_Reported_LN;
string first_name;
string middle_name;
string Last_name;
string suffix;
string street_address;
string city;
string state;
string zip_code;
string10 Phone_Number;
string9 SSN;
string8 DOB;
string Driver_License_Number;
string Driver_License_State;
string50 IP_Address;
string50 Email_Address;
string Device_Identification;
string Device_identification_Provider;
string Origination_Channel;
string Income;
string Own_or_Rent;
string Location_Identifier;
string Other_Application_Identifier;
string Other_Application_Identifier2;
string Other_Application_Identifier3;
string Date_Application;
string Time_Application;
string Application_ID;
string FraudPoint_Score;
string Date_Fraud_Detected;
string Financial_Loss;
string Gross_Fraud_Dollar_Loss;
string Application_Fraud;
string Primary_Fraud_Code;
string Secondary_Fraud_Code;
string Source_Identifier;
string LN_Product_ID;
string LN_Sub_Product_ID;
string Industry;
string Fraud_Index_Type;


end;

EXPORT preclean_TFD := record
credit_fraud;
string address1;
string address2;
string name_clean;
Address.Layout_Clean182_fips;
AID.Common.xAID							Append_RawAID; 
 string5         title;
	string20        fname;
	string20        mname;
	string20        lname;
	string5         name_suffix;
	unsigned8 nid:=0;
	unsigned2  name_ind:=0;  // name indicator bitmap
	unsigned6  did := 0;
	unsigned1  did_score := 0;
	
end;



end;

