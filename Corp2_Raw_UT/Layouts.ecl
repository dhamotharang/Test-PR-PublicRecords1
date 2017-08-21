EXPORT Layouts := module

	export  BusentityLayoutIn:= record

		string		Entity_Number;
		string		Entity_ID;
		string		Entity_Type;
		string		License_Type;
		string		Business_Name;
		string		Address;
		string		Address2;
		string		City;
		string		State;
		string		Zip;
		string		Registration_Date;
		string		Expiration_Date;		
		string		Home_State;
		string		License_Status;
		string		Status_Reason;
		string	  Last_Renewal_Date;
		string		Date_Status_Changed;
		string		Applicant_Name;
		string		NAICS_Code;
		string	  newline1;

	end;
	export BusentityLayoutBase := RECORD

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		BusentityLayoutIn;
		
	end;
	export PrincipalsLayoutIn:= record
	
		string		Prin_Entity_ID;
		string		Prin_Entity_Type;
		string		Prin_License_Type;	
		string		Prin_Business_Name;	
		string		Prin_Member_Position;
		string		Prin_Full_name;	
		string		Prin_Address;	
		string		Prin_Address2;	
		string		Prin_City;	
		string		Prin_State;
		string		Prin_Zip_Code;	
		string		newlin2;
		
	end;
	export PrincipalsLayoutBase := RECORD

	string1		action_flag;
	UNSIGNED4	dt_first_received;
	UNSIGNED4	dt_last_received;
	PrincipalsLayoutIn;

	end;


	export BusinfoLayoutIn := record
	
	string	Info_Entity_ID;
	string	Info_Entity_Type;
	string	Info_License_Type;
	string	Info_Business_Name;	
	string	Information_Type;
	string	Information;
	string	newline3;
	
	end;

	export BusinfoLayoutBase := RECORD

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		BusinfoLayoutIn;

	end;

	export  Busentity_Principals:= record
	
		BusentityLayoutIn;
		PrincipalsLayoutIn;
	
	end;

	export  Busentity_Businfo:= record
	
		BusentityLayoutIn;
		BusinfoLayoutIn;
		
	end;

	export  Busentity_Businfo_Principals:= record
	
		BusentityLayoutIn;
		BusinfoLayoutIn;
		PrincipalsLayoutIn;
		
	end;
	
	export	OfficerFileWithTitles := record	
				
			Busentity_Principals;
			string      Title1;
			string      Title2;
			string      Title3;
			string      Title4;
			string      Title5;
			
	end;

end;