EXPORT Layouts_Broward := module

export CFN := module

export raw := 
record
string Instrument_Number;    
string Record_Date_YMD;      
string Record_Date_MDY;      
string Record_Time;          
string Document_Type_Code;   
string Consideration_Amount; 
string Book_Number;          
string Page_Number;          
string Book_Type;            
string Legal_1;              
string Parcel_ID;            
string Documentary_Tax;      
string Intangible_Tax;       
string Number_of_Names;      
string Confidential;         
string Status;               
string Re_record_Flag;       
string Source;               
string Case_Number;          
string lf;             

end;

export fixed :=  record                           
  string8 process_year;          
  string9 Instrument_Number;     
  string10 Record_Date;          
  string6 Record_Time;           
  string10 Document_Type_Code;   
  string10 Execution_Date;       
  string22 Consideration_Amount; 
  string6 Book_Number;           
  string4 Page_Number;           
  string1 Book_Type;             
  string60 Legal_1;              
  string15 Parcel_ID;            
  string12 Documentary_Tax;      
  string12 Intangible_Tax;       
  string3 Number_of_Names;       
  string1 Confidential;          
  string1 Status;                
  string2 Re_record_Flag;        
  string1 Source;                
  string20 Case_Number;          
  string50 Address_1;            
  string50 Address_2;            
  string50 City;                 
  string30 State;                
  string12 Zip_Code;             
  string1 lf;                    
end;                             

end;

export NME := module

export raw := record
  string Instrument_Number;
  string Party_Name;
  string Direct_Reverse;
  string Name_Sequence;
  string lf;
end;

export fixed := record
   string8 process_year;
   string9 Instrument_Number;
   string60 Party_Name;
   string1 Direct_Reverse;
   string1 Company_Individual;
   string4 Name_Sequence;
   string1 lf;
end;

end;

export Layout_CFN_NME := record                             
  string9 Instrument_Number;       
  string10 Record_Date;            
  string6 Record_Time;             
  string10 Document_Type_Code;     
  string10 Execution_Date;         
  string22 Consideration_Amount;   
  string6 Book_Number;             
  string4 Page_Number;             
  string1 Book_Type;               
  string60 Legal_1;                
  string20 Parcel_ID;              
  string12 Documentary_Tax;        
  string12 Intangible_Tax;         
  string3 Number_of_Names;         
  string1 Confidential;            
  string1 Status;                  
  string2 Re_record_Flag;          
  string1 Source;                  
  string25 Case_Number;            
  string50 Address_1;              
  string50 Address_2;              
  string50 City;                   
  string30 State;                  
  string12 Zip_Code;               
  string60 Party_Name;             
  string1 Direct_Reverse;          
  string1 Company_Individual;      
  string4 Name_Sequence;           
end;                               

export LNK := module

export raw := record                                 
   string Instrument_Number;            
   string Book_Number;                  
   string Page_Number;                  
   string Book_Type;                    
   string Document_Type_Code;           
   string Prior_Instrument_Number;      
   string Prior_Book_Number;            
   string Prior_Page_Number;            
   string Prior_Book_Type;              
   string Prior_Document_Type_Code;     
   string Keypunch;                     
   string lf;                     
 end;                                   
                                        


export fixed := 
record                                 
  string8 process_year;                
  string9 Instrument_Number;           
  string6 Book_Number;                 
  string4 Page_Number;                 
  string1 Book_Type;                   
  string10 Document_Type_Code;         
  string9 Prior_Instrument_Number;     
  string8 Prior_Book_Number;           
  string4 Prior_Page_Number;           
  string1 Prior_Book_Type;             
  string10 Prior_Document_Type_Code;   
  string24 Keypunch;                   
  string1 lf;                          
end;                                   


end;

export Layout_all := record                                      
 string9 Instrument_Number;                 
  string10 Record_Date;                     
  string6 Record_Time;                      
  string10 Document_Type_Code;              
  string10 Execution_Date;                  
  string22 Consideration_Amount;            
  string6 Book_Number;                      
  string4 Page_Number;                      
  string1 Book_Type;                        
  string60 Legal_1;                         
  string20 Parcel_ID;                       
  string12 Documentary_Tax;                 
  string12 Intangible_Tax;                  
  string3 Number_of_Names;                  
  string1 Confidential;                     
  string1 Status;                           
  string2 Re_record_Flag;                   
  string1 Source;                           
  string25 Case_Number;                     
  string50 Address_1;                       
  string50 Address_2;                       
  string50 City;                            
  string30 State;                           
  string12 Zip_Code;                        
  string60 Party_Name;                      
  string1 Direct_Reverse;                   
  string1 Company_Individual;               
  string4 Name_Sequence;                    
  string9 Prior_Instrument_Number;     
  string8 Prior_Book_Number;          
  string4 Prior_Page_Number;           
  string1 Prior_Book_Type;             
  string10 Prior_Document_Type_Code;   
end;                                        


end;
