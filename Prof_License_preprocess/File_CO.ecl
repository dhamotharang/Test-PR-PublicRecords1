EXPORT File_CO := module




export common_lt := 
record                           
   string  LastName;             
   string  FirstName;            
   string  MiddleName;           
   string Suffix;
	 string BusinessName;
   string  Phone;                
   string  Address;              
   string  Address_2;            
   string  City;                 
   string StateCode;             
   string  ZipCode;              
   string  Description;          
   string CredentialNumber;      
   string EffectiveDate;         
   string ExpirationDate;        
   string FirstEffectiveDate;    
   string  Status;               
   string  License_Method;       
   string  License_Title;
	 string  Speciality;
   string  Degree;               
   string  SchoolName;           
   string attendedFromDate;      
   string attendedToDate;        
   string  FormattedCaseNumber;  
   string  CaseActionTypeDesc;   
   string DateEffective;         
   string DateCompleted;
	 string Entity_Name;
	 string  Authority1;  
  string  Authority2;  
  string  Authority3;  
  string  Authority4;  
  string  Authority5;  
  string  Degree1;     
  string  Degree2;     
  string  Degree3;     
  string  Degree4;     
  string  Degree5;     
  string  Specialty1;  
  string  Specialty2;  
  string  Specialty3;  
  string  Specialty4;  
  string  Specialty5;  

   string lf;                    
end;                              
shared Layout_in := record                         
   string  LastName;           
   string  FirstName;          
   string  MiddleName;         
   string Suffix;  
	 string Entity_Name;
	 string FormattedName;
	 string Attention;
   string  Address;            
   string  Address_2;          
   string  City;               
   string StateCode; 
	 string County;
   string  ZipCode;
	  string ZipCode_4;
		string LicenseType;
		string subcategory;
		string LicenseNumber;
		string FirstIssueDate;
		string LastRenewalDate;
		string ExpirationDate;
		string  Status;             
	 string Speciality;
	 string License_Title;
   string  Degree;             
  string CaseNumber;
	string ProgramAction;
	string DisciplineEffectiveDate;
	string DisciplineCompletedDate;
 
end;                            
/*****Files missing License Title field********/
export med := dataset('~thor_data400::in::prolic::co::medical::raw',Layout_in,CSV( heading(1),separator(','),terminator(['\n','\r\n']),Quote('')));
/*
export aud_had := dataset('~thor_data400::in::prolic::co::medical::aud_had',Layout_in,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

export pn := dataset('~thor_data400::in::prolic::co::medical::pn',Layout_in,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

export rn := dataset('~thor_data400::in::prolic::co::medical::rn',Layout_in,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

export rtl := dataset('~thor_data400::in::prolic::co::medical::rtl',Layout_in,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

export dd_mi := dataset('~thor_data400::in::prolic::co::medical::dd_mi',Layout_in,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

export mft := dataset('~thor_data400::in::prolic::co::medical::mft',Layout_in,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

export lpc := dataset('~thor_data400::in::prolic::co::medical::lpc',Layout_in,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

export nlc := dataset('~thor_data400::in::prolic::co::medical::phaco',Layout_in,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));
/*************************************************************/
/**********Files with Lic Title field ***********/
//export med2 := dataset('~thor_data400::in::prolic::co::medical::raw2',common_lt,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));
/*
export optin := dataset('~thor_data400::in::prolic::co::medical::opt',common_lt,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

export pod := dataset('~thor_data400::in::prolic::co::medical::pod',common_lt,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

export nha := dataset('~thor_data400::in::prolic::co::medical::nha',common_lt,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));


export pha := dataset('~thor_data400::in::prolic::co::medical::phaco',common_lt,CSV( separator(','),terminator(['\n','\r\n']),Quote('')));

/*****************************************************/

available_lt := record
   string  Last_Name;
   string  First_Name;
   string  Middle_Name;
   string Suffix;
   string  Entity_Name;
   string  Formatted_Name;
   string  Attention;
   string  Address_Line_1;
   string  Address_Line_2;
   string  City;
   string State;
   string  County;
   string  Mail_Zip_Code;
   string  Mail_Zip_Code_4;
   string  License_Type;
   string  Sub_Category;
   string  License_Number;
   string  License_First_Issue_Date;
   string  License_Last_Renewed_Date;
   string  License_Expiration_Date;
   string  License_Status_Description;
   string  Specialty;
   string  Title;
   string  Degree;
   string  Case_Number;
   string  Program_Action;
   string  Discipline_Effective_Date;
   string  Discipline_Complete_Date;
   string lf;
end;

export available := dataset('~thor_data400::in::prolic::co::all_available::raw',available_lt,CSV( heading(1),separator(','),terminator(['\n','\r\n']),Quote('"')));

end;