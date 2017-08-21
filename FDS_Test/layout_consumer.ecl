import address;
export layout_consumer :=
module

	export	Input	:=
	module
	
		export ConsumerRec	:=	
		record
			string	Record_ID;
			string	Name;
			string	Business_Name;
			string	Address;
			string	Secondary_Address;
			string	City;
			string	State;
			string	Zip_Code;
			string	Phone_Number;
			string	SSN;
			string	Tax_ID_Number;
			string	VIN;
			string	Craft_ID;
			string	License_Plate_Number;
			string	License_Plate_State;
		end;

		export	rConsumerIn_layout	:=
		record
			string	Record_ID;
			string	Name;
			string	Business_Name;
			string	Address;
			string	Secondary_Address;
			string	City;
			string	State;
			string	Zip_Code;
			string	Phone_Number;
			string	SSN;
			string	Email;
			string	Phone;
		end;
		
	end;
	
	export	Response	:=
	module
	
		export	rFDSEmail_layout	:=
		record
			string	Record_ID;
			string	Zip;
			string	Count_Results;
		end;
		
		export	rFDSCanadianPhone_layout	:=
		record
			string	Record_ID;
			string	First_Name;
			string	Middle_Name;
			string	Last_Name;
			string	Company_Name;
			string	Address_Line1;
			string	Address_Line2;
			string	City;
			string	State;
			string	Zip;
			string	Phone_Number;
			string	Publish_Date;
		end;
		
		export Employment_Extract :=
		record

			string	Record_ID					;
			string	first_Name				;
			string	middle_Name				;
			string	last_Name					;
			string	Company_Name			;
			string	tax_ID 						;
			string	title 						;
			string	Street_Address		;
			string	Secondary_Address	;
			string	City							;
			string	State							;
			string	Zip_Code					;
			string	phone							;
			string	email							;
			string	ssn								;
			string	date_last_reported;
			string	date_added				;
			boolean	confidence_level	;

		end;
		
		export Employment_Append :=
		record

			Input.ConsumerRec								SearchCriteria;
			Employment_Extract - Record_ID	Appended_data	;

		end;

		
		export count_extract :=
		record

			string	Record_ID												;
			string	Zip_Code												;
			unsigned8	count_records										;
		
		end;
		
		export Relatives_Extract :=
		record

			string	Record_ID												;
			string	first_Name											;
			string	middle_Name											;
			string	last_Name												;
			string	Alias_fName											;
			string	Alias_mName											;
			string	Alias_lName											;
			string	Street_Address									;
			string	Secondary_Address								;
			string	City														;
			string	State														;
			string	Zip_Code												;
			string	phone														;
			string	date_added											;
			string	date_last_reported							;
			string	date_of_birth										;
			boolean	deceased_indicator							;
			string	count_of_all_relatives_available;
			string	rel_first_Name									;
			string	rel_middle_Name									;
			string	rel_last_Name										;
			string	rel_Street_Address							;
			string	rel_Secondary_Address						;
			string	rel_City												;
			string	rel_State												;
			string	rel_Zip_Code										;
			string	rel_phone												;

		end;

		export Relatives_Append :=
		record

			Input.ConsumerRec								SearchCriteria;
			Relatives_Extract - Record_ID		Appended_data	;

		end;

		export Associates_Extract :=
		record

			string	Record_ID													;
			string	first_Name												;
			string	middle_Name												;
			string	last_Name													;
			string	Street_Address										;
			string	Secondary_Address									;
			string	City															;
			string	State															;
			string	Zip_Code													;
			string	phone															;
			string	date_added												;
			string	date_last_reported								;
			string	date_of_birth											;
			string	count_of_all_associates_available	;
			string	assoc_first_Name									;
			string	assoc_middle_Name									;
			string	assoc_last_Name										;
			string	assoc_Street_Address							;
			string	assoc_Secondary_Address						;
			string	assoc_City												;
			string	assoc_State												;
			string	assoc_Zip_Code										;
			string	assoc_phone												;

		end;
		
		export rel_ass_extract :=
		record
		
			Relatives_Extract;
			string	count_of_all_associates_available;

		end;

		export Associates_Append :=
		record

			Input.ConsumerRec								SearchCriteria;
			Associates_Extract - Record_ID	Appended_data	;

		end;

	end;

	export Temporary	:=
	module

		export relatives_info_temp :=
		record
			unsigned6											DID1						;
			unsigned6											DID2						;
			string	rel_first_Name									;
			string	rel_middle_Name									;
			string	rel_last_Name										;
			string	rel_Street_Address							;
			string	rel_Secondary_Address						;
			string	rel_City												;
			string	rel_State												;
			string	rel_Zip_Code										;
			string	rel_phone												;
		end;

		export associates_info_temp :=
		record
			unsigned6											DID1						;
			unsigned6											DID2						;
			string	assoc_first_Name									;
			string	assoc_middle_Name									;
			string	assoc_last_Name										;
			string	assoc_Street_Address							;
			string	assoc_Secondary_Address						;
			string	assoc_City												;
			string	assoc_State												;
			string	assoc_Zip_Code										;
			string	assoc_phone												;
		end;

		export Relatives_Append_Temp := 
		record

			Response.Relatives_Append				;
			address.Layout_Clean_Name			clean_name		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned8											clean_phone		;
			unsigned8											clean_ssn			;
			boolean												didmatch			;
		end;
		
		export Associates_Append_Temp := 
		record

			Response.Associates_Append				;
			address.Layout_Clean_Name			clean_name		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned8											clean_phone		;
			unsigned8											clean_ssn			;
			boolean												didmatch			;
		end;

		export Employment_Append_Temp := 
		record

			Response.Employment_Append				;
			address.Layout_Clean_Name			clean_name		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned8											clean_phone		;
			unsigned8											clean_ssn			;
			unsigned8											date_last_reported			;
			boolean												didmatch			;
		end;

		export Paw_Temp := 
		record

			Response.Employment_Extract	- Record_ID	Appended_data				;
			address.Layout_Clean_Name			clean_name		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned8											clean_phone		;
			unsigned8											clean_ssn			;
			unsigned8											date_last_reported			;
			
		end;

		export fileassociates := 
		record

			Response.Associates_Extract		Appended_data				;
			address.Layout_Clean_Name			clean_name		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned6											DID2					;
			unsigned8											clean_phone		;
			unsigned8											clean_ssn			;
			unsigned8											count_associates		;
			
		end;

		export filerelatives := 
		record

			Response.Relatives_Extract		Appended_data				;
			address.Layout_Clean_Name			clean_name		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned6											DID2					;
			unsigned8											clean_phone		;
			unsigned8											clean_ssn			;
			unsigned8											count_relatives			;
			
		end;

		export StandardizeInput := 
		record

			unsigned8										unique_id	;

			string100 									address1	;
			string50										address2	;

			Input.ConsumerRec							Extract				;
			address.Layout_Clean_Name			clean_name		;
			address.Layout_Clean_Name			clean_name2		;
			Address.Layout_Clean182_fips	Clean_Address	;
			unsigned6											DID						;
			unsigned6											DID_score			;
			unsigned8											clean_phone		;
			unsigned4											clean_ssn			;
			
		end;
		
		export DidSlim := 
		record
		
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix			;
			string20 		fname2					;
			string20 		mname2					;
			string20 		lname2					;
			string5  		name_suffix2		;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range				;
			string5			zip5						;
			string2			state						;
			string9			ssn							;
			string10		phone						;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	
		end;
	
	end;

end;