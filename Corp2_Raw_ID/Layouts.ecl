EXPORT Layouts := module

	export vendorRawLayoutIn := record
	
			string1 	File_Type;
			string7 	File_Number;
			string1 	Dup_Number_Indicator;
			string77 	File_Name;
			string50 	Additional_Name_Line;
			string1 	Officer_Type;
			string1 	Office_Held;
			string9 	Date_Appointed;
			string40 	Officer_Name;
			string30 	Officer_Street;
			string30 	Officer_Bldng;
			string20 	Officer_City;
			string2 	Officer_State;
			string5 	Officer_Zip5;
			string4 	Officer_Zip4;
			string20 	Officer_Country;
			string8 	Officer_Foreign_Zip;
			string20 	State_of_Origin;
			string1 	Corporation_Type;
			string9 	File_Date;
			string1 	Current_Status;
			string9 	Status_Change_Date;
			string40 	Entity_Name;
			string30 	Entity_Street;
			string30 	Entity_Bldng;
			string20 	Entity_City;
			string2 	Entity_State;
			string5 	Entity_Zip5;
			string4 	Entity_Zip4;
			string20 	Entity_Country;
			string8 	Entity_Foreign_Zip;
			string40 	Nature_of_Business;
			string2 	lf;
			
		end;

	export vendorRawLayoutBase := record
	
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		vendorRawLayoutIn;
		
	end;

end;