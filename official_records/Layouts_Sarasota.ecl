EXPORT Layouts_Sarasota := module

export raw := module

export document := record                       
  string instrument_number;  
  string multi_seq;          
  string timeReceived;       
  string document_type_code; 
  string image_status;       
  string indx_status;        
  string number_pgs_recorded;
  string book_type;          
  string book;               
  string page;               
  string microfilm_code;     
  string location;           
  string document_date;      
  string exemption_typ;      
  string consideration;      
  string county_tax;         
  string state_tax;          
  string min_number;         
  string cin_number;         
  string lf;                                 
end;                         


export grantor := record                         
  string instrument_number;    
  string seq_no;               
  string grantor_seqno;        
  string grantor_last_name;    
  string grantor_first_name;   
  string grantor_status;       
  string grantor_ind_or_cflag; 
  string grantor_middle_name;  
  string grantor_suffix;     
  string lf;                                           
end;                           

export grantee := record                           
  string instrument_number;      
  string seq_no;                 
  string grantor_seqno;          
  string grantee_last_name;      
  string grantee_first_name;     
  string grantee_status;         
  string grantee_ind_or_cflag;   
  string grantee_middle_name;    
  string grantee_suffix;         
  string lf;                                              
end;                             

export legal := record                      
  string instrument_number; 
  string multi_seq;         
  string legal_seq;         
  string combo;             
  string section;           
  string township;          
  string range1;             
  string qtr1;              
  string qtr2;              
  string lot;               
  string lotto;             
  string block;             
  string unit;              
  string building;          
    string survey_name;     
  string addition;          
  string street_number;     
  string street_addr;       
  string pin_id;            
  string freeform_legal;    
  string mapcase_number;    
  string slide_number;      
  string town;              
  string pd_page;           
  string pd_volume;         
  string acrreage;          
  string condo;             
  string abstract;  
end;                        

export crossref := record                          
  string instrument_number;     
  string ref_book_type;         
  string ref_book;              
  string ref_page;              
  string ref_instrument_number; 
  string ref_multi_seq;         
  string ref_document_type;     
  string ref_type;      
end;                            
end;
export Layout_Common := record                           
  string instrument_number;      
  string multi_seq;              
  string timeReceived;           
  string document_type_code;     
  string image_status ;          
  string indx_status ;           
  string number_pgs_recorded ;   
  string book_type ;             
  string book ;                  
  string page ;                  
  string microfilm_code ;        
  string location ;              
  string document_date ;         
  string exemption_typ ;         
  string consideration ;         
  string county_tax ;            
  string state_tax ;             
  string min_number ;            
  string cin_number ;            
  string grantor_seqno;          
  string grantor_last_name;      
  string grantor_first_name;     
  string grantor_from_to;        
  string grantor_status ;        
  string grantor_ind_or_cflag ;  
  string grantor_middle_name ;   
  string grantor_suffix;         
  string grantee_last_name;      
  string grantee_first_name;     
  string grantee_from_to;        
  string grantee_status ;        
  string grantee_ind_or_cflag;   
  string grantee_middle_name;    
  string grantee_suffix;         
  string legal_seq ;             
  string combo;                  
  string section ;               
  string township ;              
  string range1 ;                 
  string qtr1 ;                  
  string qtr2 ;                  
  string lot ;                   
  string lotto ;                 
  string block ;                 
  string unit ;                  
  string building ;              
  string survey_name ;           
  string addition ;              
  string street_number ;         
  string street_addr ;           
  string pin_id ;                
  string freeform_legal;         
  string mapcase_number ;        
  string slide_number ;          
  string town ;                  
  string pd_page ;               
  string pd_volume ;             
  string acrreage ;              
  string condo ;                 
  string abstract ;              
  string ref_book_type ;         
  string ref_book ;              
  string ref_page ;              
  string ref_instrument_number ; 
  string ref_multi_seq ;         
  string ref_document_type ;     
  string ref_type ;              
end;                             


end;
/*
export fixed := module

export idx := record
  string10 document_number;
  string7 document_type_code;
  string141 freeform_legal_description;
  string81 return_mail_name;
  string50 return_mail_address;
  string25 return_mail_city;
  string2 return_mail_state;
  string14 return_mail_zip_code;
  string4 book;
  string4 page;
  string10 filing_date;
  string8 filing_time;
  string1 lf;
end;

export pty := record
  string10 document_number;
  string120 party_name;
  string1 from_to;
  string4 sequence;
  string lf;
end;
end;
Layout_common := record
  string10 document_number;
  string7 document_type_code;
  string141 freeform_legal_description;
  string81 return_mail_name;
  string50 return_mail_address;
  string25 return_mail_city;
  string2 return_mail_state;
  string14 return_mail_zip_code;
  string4 book;
  string4 page;
  string10 filing_date;
  string8 filing_time;
  string120 party_name;
  string1 from_to;
  string4 sequence;
end;

end;*/