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
string sort_name         ;   
string last_name         ;
string first_name         ;
string middle_name    ;
string name_suffix      ;
string profession_id   ;
string license_type     ;
string license_no        ;
string expiration_date;
string addr_line_1      ;
string addr_line_2      ;
string addr_line_3      ;
string addr_city          ;
string addr_state        ;
string addr_zipcode   ;
string addr_country   ;
string addr_county         ;
string issue_date        ;

end;

export Health := dataset('~thor_data400::in::prolic::mi::health::raw',healthrec,CSV( separator(','),terminator(['\n']),Quote('"')));

occuprec := record
string sort_name         ;   
string last_name         ;
string first_name         ;
string middle_name    ;
string name_suffix      ;
string owner_name ;
string Is_Org;
string profession_id   ;
string license_type     ;
string license_no        ;
string expiration_date;
string addr_line_1      ;
string addr_line_2      ;
string addr_line_3      ;
string addr_city          ;
string addr_state        ;
string addr_zipcode   ;
string addr_country_no   ;
string addr_county                     ;
string issue_date        ;

end;

export Occup := dataset('~thor_data400::in::prolic::mi::occup::raw',occuprec,CSV( separator(','),terminator(['\n']),Quote('"')));

end;