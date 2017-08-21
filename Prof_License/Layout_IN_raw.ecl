import address,AID; 
export Layout_IN_raw := module

export Input:=record,maxlength(999999)
string  DartID;
string  DateAdded;
string  DateUpdated;
string  Website;
string  State;
string  BusinessName;
string  DBA;
string  NameFirst;
string  NameMiddle;
string  NameLast;
string  NameSuffix;
string  NameTitle;
string  Address;
string  AddressCity;
string  AddrState;
string  Zip;
string  Zip4;
string  County;
string  LicenseNo;
string  LicenseType;
string  Profession;
string  LicenseStatus;
string  LicenseDateFrom;
string  LicenseDateTo;
string  ProfileLastUpdated;
end;

 export  Clean_input:=record
	    input;
		string5         title;
		string20        fname;
		string20        mname;
		string20        lname;
		string5         name_suffix;
	end;
	
end;