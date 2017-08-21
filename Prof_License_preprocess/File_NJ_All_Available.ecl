EXPORT File_NJ_All_Available := module

Layout_raw := record                        
string PN_PROFESSION_NAME ;   
string CIL_ITEM_TEXT      ;   
string L_LICENSE_NO       ;   
string CI_ITEM_TEXT       ;   
string L_ISSUE_DATE       ;   
string L_EXPIRATION_DATE  ;   
string L_DATE_LAST_RENEWAL;   
string CIS_ITEM_TEXT      ;   
string P_IS_ORGANIZATION  ;   
string P_FIRST_NAME       ;   
string P_MIDDLE_NAME      ;   
string P_LAST_NAME        ;   
string field13            ;       
string ORG_NAME           ;      
string ADDR_1             ;        
string ADDR_2             ;        
string ADDR_3             ;         
string ADDR_4             ;         
string CITY               ;           
string STATE              ;          
string ZIP                ;            
string COUNTY             ;        
string COUNTRY           ;      
end;                           

export raw := dataset('~thor_data400::in::prolic::nj::all_available::raw',Layout_raw,CSV( separator('%'),terminator(['\n']),Quote('"')));

end;