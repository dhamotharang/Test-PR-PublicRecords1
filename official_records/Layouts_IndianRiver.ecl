EXPORT Layouts_IndianRiver := module

export document := module

export raw :=  record                         
  string Update_Record_Type;   
  string County_Number;        
  string Instrument_Number;    
  string Unmapped_doctype;     
  string Document_Description; 
  string Legal_Description_1;  
  string Book_Type;            
  string Book_Number;          
  string Page_Number;          
  string Page_suffix;          
  string Document_Page_Count;  
  string Record_Date;          
  string Record_Time;          
   string County_Info;         
  string lf;                   
end;   

export fixed := record                             
   string8 process_date;           
  string3 Update_Record_Type;      
  string2 County_Number;           
  string16 Instrument_Number;      
  string12 Unmapped_doctype;       
  string128 Document_Description;  
  string128 Legal_Description;     
  string40 Book_Type;              
  string6 Book_Number;             
  string6 Page_Number;             
  string3 Page_suffix;             
  string6 Document_Page_Count;     
  string10 Record_Date;            
  string8 Record_Time;             
   string255 County_Info; 
	    string1 lf;
end;

end;

export party := module

export raw := record                         
                          
  string Update_RecordType;   
  string County_Number;       
  string Instrument_Number;   
  string Party_ID;            
  string Party_Type;          
  string Party_Name;          
  string lf;              
end;  

export fixed := record                       
   string8 process_date;     
  string3 Update_RecordType; 
  string2 County_Number;     
  string16 Instrument_Number;
  string16 Party_ID;         
  string3 Party_Type;        
  string128 Party_Name;      
  string1 lf;                 
                             
end;

end;

export Layout_common := 
record                             
  string3 Update_Record_Type;      
  string2 County_Number;           
  string16 Instrument_Number;      
  string12 Unmapped_doctype;       
  string128 Document_Description;  
  string128 Legal_Description;     
  string40 Book_Type;              
  string6 Book_Number;             
  string6 Page_Number;             
  string3 Page_suffix;             
  string6 Document_Page_Count;     
  string10 Record_Date;            
  string8 Record_Time;             
   string255 County_Info;          
  string16 Party_ID;                
  string3 Party_Type;              
  string128 Party_Name;            
end;  

end;                                            
                       
                                                             