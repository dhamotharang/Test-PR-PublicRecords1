EXPORT Layouts := module

  //Vendor Input files 
	
  EXPORT COREXT_LayoutIn := record
		STRING Entity_Number;
		STRING Entity_Name;
		STRING Formation_Date;
		STRING Approval_Date;
		STRING Business_Type;
		STRING Status;
		STRING Character_of_Business;
		STRING Domicile;
		STRING Known_Place_of_Business_Street_Address_1;
		STRING Known_Place_of_Business_Street_Address_2;
		STRING Known_Place_of_Business_City;
		STRING Known_Place_of_Business_State;
		STRING Known_Place_of_Business_Zip_Code;
		STRING Known_Place_of_Business_County;
		STRING Principal_Street_Address_1;
		STRING Principal_Street_Address_2;
		STRING Principal_Address_City;
		STRING Principal_Address_State;
		STRING Principal_Address_Zip_Code;
		STRING Statutory_Agent_Name;
		STRING Statutory_Agent_Physical_Street_Address_1;
		STRING Statutory_Agent_Physical_Street_Address_2;
		STRING Statutory_Agent_Physical_Address_City;
		STRING Statutory_Agent_Physical_Address_State;
		STRING Statutory_Agent_Physical_Address_Zip_Code;
		STRING Statutory_Agent_Mailing_Street_Address_1;
		STRING Statutory_Agent_Mailing_Street_Address_2;
		STRING Statutory_Agent_Mailing_Address_City;
		STRING Statutory_Agent_Mailing_Address_State;
		STRING Statutory_Agent_Mailing_Address_Zip_Code;
		STRING Statutory_Agent_Status_Date;
		STRING Statutory_Agent_Status;
	END;

  EXPORT OFFEXT_LayoutIn := record
		STRING Entity_Number;
		STRING Officer_Title;
		STRING Officer_Name;
		STRING Officer_Address_1;
		STRING Officer_Address_2;
		STRING Officer_City;
		STRING Officer_State;
		STRING Officer_Zip_Code;
	END;

  EXPORT FLMEXT_LayoutIn := record
		STRING Entity_Number;
		STRING Entity_Name;
		STRING Microfilm_Location;
		STRING Date_Document_Received;
		STRING Document_Description;
	END;

  EXPORT CHGEXT_LayoutIn := record
		STRING Entity_Number;
		STRING Current_Name;
		STRING Change_Type;
		STRING Entity_Name;
		STRING Change_Date;
	END;

  EXPORT INACTV_LayoutIn := record
		STRING Entity_Number;
		STRING Entity_Name;
		STRING Formation_Date;
		STRING Approval_Date;
		STRING Business_Type;
		STRING Status;
		STRING Character_of_Business;
		STRING Domicile;
		STRING Known_Place_of_Business_Street_Address_1;
		STRING Known_Place_of_Business_Street_Address_2;
		STRING Known_Place_of_Business_City;
		STRING Known_Place_of_Business_State;
		STRING Known_Place_of_Business_Zip_Code;
		STRING Known_Place_of_Business_County;
		STRING Principal_Street_Address_1;
		STRING Principal_Street_Address_2;
		STRING Principal_Address_City;
		STRING Principal_Address_State;
		STRING Principal_Address_Zip_Code;
		STRING Statutory_Agent_Name;
		STRING Statutory_Agent_Physical_Street_Address_1;
		STRING Statutory_Agent_Physical_Street_Address_2;
		STRING Statutory_Agent_Physical_Address_City;
		STRING Statutory_Agent_Physical_Address_State;
		STRING Statutory_Agent_Physical_Address_Zip_Code;
		STRING Statutory_Agent_Mailing_Street_Address_1;
		STRING Statutory_Agent_Mailing_Street_Address_2;
		STRING Statutory_Agent_Mailing_Address_City;
		STRING Statutory_Agent_Mailing_Address_State;
		STRING Statutory_Agent_Mailing_Address_Zip_Code;
		STRING Statutory_Agent_Status_Date;
		STRING Statutory_Agent_Status;
	END;
	
	//Intermediate Files
	
	export normLayout := record
		COREXT_LayoutIn;
		string 	Norm_Street1;
		string 	Norm_Street2;
		string  Norm_City;
    string  Norm_State;
		string  Norm_Zip;
		string 	Norm_Type;
	end;
		
	export OFFEXT_COREXT := record
    OFFEXT_LayoutIn;
	  COREXT_LayoutIn.Entity_Name;
	end;
	
	export CHGEXT_TempLay := record
		CHGEXT_LayoutIn;
		COREXT_LayoutIn.BUSINESS_TYPE;
		COREXT_LayoutIn.FORMATION_DATE;
	end;
	
end;	 