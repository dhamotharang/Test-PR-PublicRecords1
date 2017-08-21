import address;
export layout_phone :=
module

	export	Response	:=
	module
	    export PrivatePhone_Extract := 
		record
			string	Record_ID;    				//unique identifier
			string	First_Name;
			string  Middle_Name;
			string  Last_Name;
			string	Street_Address		;
			string	Secondary_Address	;
			string	City;
			string	State;
			string	Zip_Code;
			string	Phone_Number;
			string	Line_Type;					//Wireless, Landline, Page
			string	Original_Carrier;           //Carrier name
			string	First_Reported;
		end;
		
		export	PhoneVerification_Extract:=
		record
			string	Record_ID;
			string	First_Name;
			string  Middle_Name;
			string  Last_Name;
			string	Phone_Number;
			string	Carrier;                    //Carrier name
			string	Line_Type;                  //Wireless, Landline, Page
			string	Status;                     //Active, Inactive, Unknown
		end;
		
	    export PrivatePhone_Append := 
		record
			consumer_Layouts.Input.ConsumerRec SearchCriteria;
			PrivatePhone_Extract  - Record_ID	Appended_data	;

		end;
		
		export	PhoneVerification_Append := 
		record
			consumer_Layouts.Input.ConsumerRec SearchCriteria;
			PhoneVerification_Extract - Record_ID	Appended_data	;
		end;
end;
	export Temporary	:=
	module
	    export PrivatePhone_Append_Temp := 
		record
			Response.PrivatePhone_Append;
			address.Layout_Clean_Name			clean_name		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned8											clean_phone		;
			unsigned8											clean_ssn			;
			boolean												didmatch			;

		end;
		
		export	PhoneVerification_Temp  := 
		record
			Response.PhoneVerification_Append;
			address.Layout_Clean_Name			clean_name		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned8											clean_phone		;
			unsigned8											clean_ssn			;
			boolean												didmatch			;

		end;

	
	end;
end;

