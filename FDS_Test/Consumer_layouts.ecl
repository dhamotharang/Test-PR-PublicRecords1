import address;
export Consumer_Layouts := module
		
	export	Input	:=	module

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

		export CleanConsumerRec	:=	record
			ConsumerRec;
			address.Layout_Clean_Name;
			address.Layout_Clean182;
			unsigned8 did := 0;
			unsigned did_score := 0;
			unsigned8 bdid := 0;
			unsigned bdid_score := 0;
			string9 app_ssn := '';
			string9 app_tax_id := '';
		end;
		
	end;
	
	export Response := 
	module

		export Consumer_Extract :=
		record
			string	Record_ID					;
			string	first_Name			;
			string	middle_Name			;
			string	last_Name			;
			string	Street_Address		;
			string	Secondary_Address	;
			string	City							;
			string	State							;
			string	Zip_Code					;
			string	phone							;
			string	SSN 						;
			string	SSN_issuing_state 						;
			string	SSN_issuing_date 						;
			string	date_of_birth 						;
			string	added_date 						;
			string	last_report_date	;
		end;

		export CnsDemo_Extract :=
		record
			string	Record_ID					;
			string	SSN 						;
			string	last_report_date	;
			string	first_Name			;
			string	middle_Name			;
			string	last_Name			;
			string	Street_Address		;
			string	Secondary_Address	;
			string	City							;
			string	State							;
			string	Zip_Code					;
			string	phone							;
			String2	Num_units:=''	;
			String1	Length_of_Residence;
			String1	RentOwn	;
			String3	Estimated_income	;
			string1	household_member_cnt;
			string	date_of_birth 						;
			string1	gender;
		end;

		export AddrHist_Extract :=
		record
			string	Record_ID					;
			string	SSN 						;
			string	first_Name			;
			string	middle_Name			;
			string	last_Name			;
			string	Street_Address		;
			string	Secondary_Address	;
			string	City							;
			string	State							;
			string	Zip_Code					;
			string	added_date 						;
			string	last_report_date	;
			string	dob 						;
			string	phone							;
			string	count_of_total_previous_addresses_available:=''		;
		end;



		export SSN_Append :=
		record
			input.ConsumerRec 				SearchCriteria;
			Consumer_Extract - Record_ID 	Appended_data;
		end;

		export SSN_Append_temp :=
		record
			unsigned6 						did					;
			input.ConsumerRec				SearchCriteria		;
			Consumer_Extract 				Appended_data			;

		end;	

		export Consumer_extract_temp :=
		record
			unsigned6 						did					;
			Consumer_Extract				Extract				;
			Address.Layout_Clean182_fips	Clean_Address	;
		end;



		export CnsDemo_Extract_temp :=
		record
			unsigned6 							did					;
			CnsDemo_Extract						Extract				;
			Address.Layout_Clean182_fips		Clean_Address	;
		end;

		export CnsDemo_Append_temp :=
		record
			unsigned6 							did					;
			input.ConsumerRec					SearchCriteria		;
			CnsDemo_Extract		 				Appended_data			;
		end;	

		export CnsDemo_Append :=
		record
			input.ConsumerRec 					SearchCriteria;
			CnsDemo_Extract - Record_ID			Appended_data;
		end;



		export AddrHist_Extract_temp :=
		record
			unsigned6 							did					;
			AddrHist_Extract						Extract				;
			Address.Layout_Clean182_fips		Clean_Address	;
		end;

		export AddrHist_Append_temp :=
		record
			unsigned6 							did					;
			input.ConsumerRec					SearchCriteria		;
			AddrHist_Extract		 				Appended_data			;
		end;	

		export AddrHist_Append :=
		record
			input.ConsumerRec 					SearchCriteria;
			AddrHist_Extract - Record_ID			Appended_data;
		end;

	end;
	
end;