EXPORT Files_IA := module

medicalrec := record                       
   string  LastName;         
   string  FirstName;        
   string  MiddleName;       
   string Suffix;            
   string  AddressLine1;     
//   string  AddressLine2;     
   string  City;             
   string  State;            
   string  Zipcode; 
   string County;            
   string LicenseType;       
   string BirthYear;         
//   string County;            
   string  BusinessPhone;    
   string  ExpirationDate;   
   string  MedicalSchool;    
   string  GraduationYear;   
   string  Specialty1;       
   string  Specialty2;       
   string Profession;        
   string  OriginalIssueDate;
   string  LicenseNumber;    
   string  LicenseStatus;    
   string PublicDiscipline;  
   string lf;                
end;                         


export Medical := dataset('~thor_data400::in::prolic::ia::medical::raw',medicalrec,CSV( separator(','),terminator(['\n','\r\n']),Quote('"'))) ( LicenseType <> 'LicenseType' );

dentalrec := record
   string  last_name;
   string  first_name;
   string  middle_name;
   string license_number;
   string lic_type;
   string license_status;
   string  orig_issue;
   string  expires;
   string  specialty;
   string formal_action;
   string address_type;
   string  address1;
   string  city;
   string state;
   string zip;
   string  county;
   string lf;
end;

export Dentist := dataset('~thor_data400::in::prolic::ia::dentist::raw',dentalrec,CSV( separator(','),terminator(['\n','\r\n']),Quote('"'))) ;

end;