export Layouts_DL_WV_In := module

   //Vendor Update record lenght = 201
	export Layout_WV_Update := record
		string7	 orig_DLNum;
		string17 orig_LName;
		string12 orig_FName;
		string17 orig_MName;
		string3	 orig_NameSuf;
		string10 orig_DOB;
		string1	 orig_Sex;
		string3  orig_Height;
		string3	 orig_Weight;
		string1	 orig_Eyes;
		string5	 orig_StreetNum; 
		string20 orig_Street;
		string15 orig_City;
		string2	 orig_County; 
		string2	 orig_State;
		string5	 orig_Zip;
		string4	 orig_Zip4;
		string10 orig_DLExpireDate;
		string10 orig_DLIssueDate;
		string2	 orig_DLType;
		string6	 orig_Restrictions;
		string2	 orig_LicenseStatus;
		string1	 orig_CDLStatus;
		string1	 orig_LicenseClass; 
		string2	 orig_TotalPoints;
		string10 orig_EarliestPointsDate; 
		string2	 orig_EarliestPointsTotal;
		string5	 orig_Endorsements;
		string9	 orig_SSN;
		string13 orig_Filler;
		string1	 orig_LF;
	end;
	
	export Layout_WV_With_ProcessDte := record
	  string8 Process_date;
		Layout_WV_Update;
	end;

end;