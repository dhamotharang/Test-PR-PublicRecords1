EXPORT BuildLayouts := MODULE
	
	EXPORT Layout_Delta_Rec := Record
		String5   Customer_Num;
		Unsigned6 LexId;
		String2   Line_Of_Business;
		String20  Reference_Num;
		Unsigned6 Date_Added;
	End;
	
	EXPORT Layout_Delta_Rec_Unload := Record
		String5   Customer_Num;
		String12  LexId;
		String2   Line_Of_Business;
		String20  Reference_Num;
		string20  Date_Added;
	End;
	
	EXPORT Layout_ldl_Rec := Record
		String5   Customer_Num;
		String5   Zip;
		String4   Zip4;
		String2   State;
		String100 RoutingInformation;
	End;
	
	EXPORT Layout_DNS_Rec_Spray := Record
		STRING5		 Customer_Number;
		STRING20	 First_Name;
		STRING20	 Middle_Name;
		STRING28	 Last_Name;
		STRING5	   Suffix;
		STRING60	 AddressLine;
		STRING25	 City;
		STRING2	   State;
		STRING5	   Zip;
		STRING4	   Zip4;
		STRING8	   Date_of_birth;
		STRING9	   SSN;
		STRING25	 Driver_License_Number;
		STRING2		 Driver_License_State;
	  STRING10	 Phone;
	End;
	
	EXPORT Layout_DNS_Rec := Record
		Unsigned8	 IDL;
		STRING5		 Customer_Number;
		STRING20	 First_Name;
		STRING20	 Middle_Name;
		STRING28	 Last_Name;
		STRING5	   Suffix;
		STRING60	 AddressLine;
		STRING25	 City;
		STRING2	   State;
		STRING5	   Zip;
		STRING4	   Zip4;
		STRING60	 CleanedAddressLine;
		STRING25	 CleanedCity;
		STRING2	   CleanedState;
		STRING5	   CleanedZip;
		STRING4	   CleanedZip4;
		STRING8	   Date_of_birth;
		STRING9	   SSN;
		STRING25	 Driver_License_Number;
		STRING2		 Driver_License_State;
	  STRING10	 Phone;
	End;
	
END;