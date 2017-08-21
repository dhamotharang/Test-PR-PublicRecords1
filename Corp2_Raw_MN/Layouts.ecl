export Layouts := module

	export FullFileLayoutIn							:= Record
		string 			payload;
	end;
	
	export FullFileLayoutBase						:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		FullFileLayoutIn;
	end;	
	
	export MasterLayoutIn								:= Record
		string   		Master_ID;
		string   		Record_Type;
		string  	 	Bus_Type_Code;
		string	   	Original_Filing_Number;
		string  	 	Minnesota_Business_Name;
		string   		Business_Filing_Status;
		string	   	Filing_Date;
		string  	 	Expiration_Date;
		string   		Next_Renewal_Due_Date;
		string	   	Home_Jurisdiction;
		string  	 	Governing_Statute;
		string   		Is_LLC_Non_Profit;
		string   		Is_LLL_Partnership;
		string   		Is_Professional;
		string   		Home_BusName;
		string   		Number_of_Shares;
		string   		Business_Mark_Type;
		string   		Mark_First_Use_Date;
		string   		Mark_Classification_Number;
		string   		Mark_Logo;
		string  	 	Services_Description;
		string	   	Export_Date;
	end;		

	export MasterLayoutBase							:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		MasterLayoutIn;
	end;		

	export FilingHistLayoutIn 					:= Record
		string 			Master_ID;
		string			Record_Type;
		string 			Bus_Type_Code;
		string 			Original_Filing_Number;
		string 			Filing_Number;
		string 			Filing_Action;
		string 			Filing_Rank;
		string 			Filing_Date;
		string 			Effective_Date;
	end;

	export FilingHistLayoutBase					:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		FilingHistLayoutIn;
	end;
	
	export NameAddrLayoutIn							:= Record
		string   		Master_ID;
		string  		Record_Type;
		string   		Bus_Type_Code;
		string   		Original_Filing_Number;
		string   		Filing_Number;
		string   		Name_Type_Number;
		string  		Addr_Type_Number;
		string   		Party_name;
		string   		Street_Addr_Line1;
		string   		Street_Addr_Line2;
		string   		City;
		string   		RegionCode;
		string   		PostalCode;
		string   		PostalCode_extension;
		string   		CountryName;
	end;
	
	export NameAddrLayoutBase						:= Record
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;	
		NameAddrLayoutIn;
	end;
	
	export Temp_NameAddrLayout					:= Record
		unsigned6 	record_id;		
		NameAddrLayoutIn;
	end;

	export Temp_MasterNameAddrLayout	 	:= Record
		MasterLayoutIn;
		NameAddrLayoutIn;
	end;
	
	export Temp_MasterNormalizedLayout 	:= Record
		MasterLayoutIn;
		string legal_name;
		string name_type_desc;
	end;
	
end;