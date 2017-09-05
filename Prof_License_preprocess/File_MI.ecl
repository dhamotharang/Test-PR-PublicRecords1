EXPORT File_MI := module

tlrec := record  
 string RecordType;                                     
 string LICENSE;       
 string  LastName; 
 string FirstName;
 string  Address_1;      
 string  City;   
 string  Zip;          
 string  Date_Expired; 
 string Status;        
 string lf;            

    
end;                                         
             


export TradeLic := dataset('~thor_data400::in::prolic::mi::trade_license::raw',tlrec,CSV( separator(','),terminator(['\n']),Quote('"')));

healthrec := record
string orig_prof_id;
   string  orig_license_no;
   string  name;
   string orig_name_type;
   string orig_issue_date;
   string orig_zip;
   string  orig_county_desc;
   string orig_country_code;
   string  orig_address_1;
   string  orig_city;
   string orig_st;
   string  orig_address_2;
   string  orig_address_3;
   string orig_license_code;
   string orig_license_status_code;
   string orig_status_change_date;
   string orig_expiration_date;
   string  orig_prev_license_no;
   string orig_prev_license_zip;
end;

export Health := dataset('~thor_data400::in::prolic::mi::health::raw',healthrec,CSV( separator(','),terminator(['\n']),Quote('"')));

end;