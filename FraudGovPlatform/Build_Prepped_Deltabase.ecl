IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared, ut;
EXPORT Build_Prepped_Deltabase (
	 string		pversion
) :=
FUNCTION

	Deltabase := Files().Sprayed.Deltabase;

	IdentityData := RECORD 
		string75 fn { virtual(logicalfilename) }; 
		Layouts.Sprayed.IdentityData;		
	END;
	
	IdentityData MapIDDT(Deltabase L) := TRANSFORM 
			
			SELF.Customer_Name	:= '';
			SELF.Customer_Account_Number	:= '248283691'; 
			SELF.Customer_State		:= 'FL';
			SELF.Customer_County	:= '000';//L.Customer_County; 
			SELF.Customer_Agency	:= ''; 														
			SELF.Customer_Agency_Vertical_Type	:= 'S'; 
			SELF.Customer_Program	:= 'S'; 
			SELF.Customer_Job_ID	:= ''; 
			SELF.Batch_Record_ID	:= ''; 
			SELF.Transaction_ID_Number	:= L.Transaction_ID_Number; 
			SELF.Reason_for_Transaction_Activity	:= L.Reason_for_Transaction_Activity; 	
			SELF.Date_of_Transaction	:= L.Date_of_Transaction; 												
			SELF.LexID					:= L.lexid; 
			SELF.raw_Full_Name		:= L.raw_Full_Name; 
			SELF.raw_Title				:= L.raw_Title;
			SELF.raw_First_name		:= L.raw_First_name;
			SELF.raw_Middle_Name	:= L.raw_Middle_Name;
			SELF.raw_Last_Name		:= L.raw_Last_Name;
			SELF.raw_Orig_Suffix	:= L.raw_Orig_Suffix; 
			SELF.SSN				:= L.SSN;
			SELF.SSN4				:= ''; 
			SELF.Address_Type	:= ''; 
			SELF.Street_1		:= L.Street_1;
			SELF.Street_2		:= '';
			SELF.City							:= L.city;
			SELF.State						:= L.state;
			SELF.Zip							:= L.zip;
			SELF.Mailing_Street_1		:= L.mailing_street_1;
			SELF.Mailing_Street_2		:= ''; 
			SELF.Mailing_City				:= L.Mailing_City; 
			SELF.Mailing_State			:= L.Mailing_State; 
			SELF.Mailing_Zip				:= L.Mailing_Zip; 
			SELF.County						:= L.County;
			SELF.Contact_Type				:= ''; 
			SELF.phone_number				:= L.phone_number; 
			SELF.Cell_Phone				:= ''; 
			SELF.dob							:= L.dob;
			SELF.Email_Address			:= L.email_address; 
			SELF.Drivers_License_State	:= L.Drivers_License_State; 
			SELF.Drivers_License_Number	:= L.Drivers_License_Number; 
			SELF.Bank_Routing_Number_1	:= L.bank_routing_number_1; 
			SELF.Bank_Account_Number_1	:= L.bank_account_number_1; 
			SELF.Bank_Routing_Number_2	:= ''; 
			SELF.Bank_Account_Number_2	:= ''; 
			SELF.Ethnicity		:= ''; 
			SELF.Race				:= ''; 
			SELF.Case_ID			:= L.Case_ID; 
			SELF.Head_of_Household_indicator	:= ''; 
			SELF.Relationship_Indicator			:= ''; 
			SELF.IP_Address							:= L.ip_address; 
			SELF.Device_ID								:= L.device_id; 
			SELF.Unique_number						:= ''; 
			SELF.MAC_Address							:= ''; 
			SELF.Serial_Number						:= ''; 
			SELF.Device_Type							:= ''; 
			SELF.Device_identification_Provider	:= '';  
			SELF.geo_lat				:= L.geo_lat; 
			SELF.geo_long			:= L.geo_long;  
			SELF.source_input 	:= 'Deltabase-' + L.inquiry_source;			
			SELF := L;
			SELF := [];
	END;

	RETURN(Project(Deltabase,MapIDDT(Left)));

end;


