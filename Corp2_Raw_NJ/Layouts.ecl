EXPORT Layouts := module

  export BlobRec := record  string blob;  end;
	
  export BusinessLayoutIn := Record, MAXLENGTH(1000)
		string Business_ID;
		string Business_Name;
		string Status;
		string Filing_Date;
		string TypeCode;  
		string StateDomicile; 
		string Registered_Agent;
		string Registered_Office_Address;
		string Registered_Office_Address2;
		string Registered_Office_City;
		string Registered_Office_State;
		string Registered_Office_Zip;
		string Registered_Office_Zip_Ext;
		string Main_Business_Address;
		string Main_Business_Address2;
		string Main_Business_City;
		string Main_Business_State;
		string Main_Business_Zip;
		string Main_Business_Zip_Ext;
		string Principal_Business_Address;
		string Principal_Business_Address2;
		string Principal_Business_City;
		string Principal_Business_State;
		string Principal_Business_Zip;
		string Principal_Business_Zip_Ext;
		string Last_Annual_Report_Filed;
	end;	

  export BusinessLayoutBase := Record
		string1		action_type;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		BusinessLayoutIn;
  end;

end;
