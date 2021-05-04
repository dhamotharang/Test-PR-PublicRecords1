import ut;
EXPORT File_AZ := module

Layout_Ost := record
   string License_Number;
   string License_Type_ID;
   string License_Status;
   string Licensed_Date;
   string Due_To_Renew_By;
   string Expiration_Date;
   string Last_Name;
   string First_Name;
   string MI_Name;
   string Suffix;
	 string PracticeName;
   string Street;
   string Street_2;
   string Office_City;
   string Office_State;
   string Office_Zip;
   string Office_Phone;
   string In_State;
   string Medical_School;
   string Graduation_Date;
   string Area_Of_Interest;
   string Area_Of_Interest1;
   string Area_Of_Interest2;
   string Area_Of_Interest3;
   string Board_Action ;
   string lf;
end;

export ostp := dataset(ut.foreign_prod+'thor_data400::in::prolic::az::osteopath::raw',Layout_Ost,CSV( heading(1),separator(','),terminator(['\n']),Quote('')));

Layout_acu := record
   string  First_Name;
   string  Last_Name;
   string License_Issue_Date;
   string License_Expiration_Date;
   string  Address1;
   string Email;
    string License_Number;
    string Discipline;
    string License_Type;  
   string Status_of_License;  
   string lf;
end;

export acup := dataset(ut.foreign_prod+'thor_data400::in::prolic::az::acupuncturist::raw',Layout_acu,CSV( heading(1),separator(','),terminator(['\n']),Quote('"')));

Layout_nurse := record
   string  LASTNAME;
   string  FIRSTNAME;
   string  MIDDLENAME;
   string  ADDRESS1;
   string  ADDRESS2;
   string  ADDRESS3;
   string  CITY;
   string STATE;
   string  ZIPCODE;
   string  COUNTY;
   string LICENSENUMBER;
   string  EXPIRATIONDATE;
   string  ORIGINALISSUEDATE;
   string  LICENSESTATUS;
   string  OTHERLLICENSES;
   string  HIGHESTDEGREE;
   string  ADVANCEDTYPE;
   string  ADVANCEDSPECIALTY;
   string HASPRESCRIBING;
   string HASDISPENSING;
   string lf;
end;

export nurse := dataset(ut.foreign_prod+'thor_data400::in::prolic::az::nurse::raw',Layout_nurse,CSV( heading(1),separator(','),terminator(['\n']),Quote('"')));

Layout_pharm := record
	 string License_Number;
   string License_Type;
	  string sub_License_Type;
   string  Status;
   string FirstName;
	 string MiddleName;
	 string LastName;
   string  Address;
	  string suite;
   string  City;
   string  State;
   string  Zip;
   string  Original_Licensure_Date;
   string  Effective_From;
   string  Effective_To;
end;

export pharm := dataset(ut.foreign_prod+'thor_data400::in::prolic::az::pharmacy::raw',Layout_pharm,CSV( heading(1),separator(','),terminator(['\n']),Quote('"')));

end;