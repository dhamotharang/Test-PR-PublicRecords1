EXPORT Layouts := module

 export ImportMasterLayoutIn := Record
			string  BusinessNumber;
			string  BusinessType;
			string  BusinessStatus;
			string  Corp_Name;
			string  DateOfIncorporation;
			string  BusinessAgentName;
			string  AddressLine1;
			string  AddressLine2;
			string  City;
			string  StateCode;
			string  Country;
			string  Zip;
	end;
	export ImportMasterLayoutBase := Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			ImportMasterLayoutIn;
	end;

end;