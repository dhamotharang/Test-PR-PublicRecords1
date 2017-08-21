export Layouts_CtyState_Product := 
module
 SHARED INTEGER mlength := 129;
 
 EXPORT Generic_Record_Sprayed := RECORD, MAXLENGTH(mlength)
  STRING1 Copyright_Detail_Code;
  STRING128 Stuff;
 end;
 
 EXPORT Generic_Record_Lookup := RECORD, MAXLENGTH(mlength + 8)
  Generic_Record_Sprayed;
  UNSIGNED4 date_first_seen;
  UNSIGNED4 date_last_seen;
 end;
  
 EXPORT Copyright_Record_Sprayed := RECORD,MAXLENGTH(mlength)
   STRING1    Copyright_Detail_Code;             
   STRING5    Filler_1;                            
   STRING12   Copyright_Statement;               
   STRING1    Filler_2;                            
   STRING2    File_Version_Month;                
   STRING1    Dash;                              
   STRING2    File_Version_Year;                 
   STRING1    Filler_3;                            
   STRING4    Copyright_Owner;                   
   STRING1    Filler_4;                            
   STRING3    Volume_Sequence_Number;            
   STRING96   Filler_5; 
 end;

 EXPORT Scheme_Record_Sprayed := RECORD,MAXLENGTH(mlength)
   STRING1    Copyright_Detail_Code;            
   STRING5    Label_Zip_Code;                   
   STRING5    Combined_Zip_Code;                
   STRING118  Filler;
 end;  

 EXPORT Scheme_Record_Lookup := RECORD,MAXLENGTH(mlength + 8)
   Scheme_Record_Sprayed; 
   UNSIGNED4 date_first_seen;
   UNSIGNED4 date_last_seen; 
 end;

//---------------ALIAS RECORD---------------
 SHARED Alias_Street_Information := RECORD,MAXLENGTH(36)
   STRING2   Street_Pre_Drctn_Abbrev;                              
   STRING28  Street_Name;                                          
   STRING4   Street_Suffix_Abbrev;                                 
   STRING2   Street_Post_Drctn_Abbrev;  
 end;

 SHARED Street_Information := RECORD,MAXLENGTH(36)
   STRING2   Street_Pre_Drctn_Abbrev;                              
   STRING28  Street_Name;                                          
   STRING4   Street_Suffix_Abbrev;                                 
   STRING2   Street_Post_Drctn_Abbrev;        
 end;
 
 SHARED Alias_Date := RECORD,MAXLENGTH(9)
   STRING1   Alias_Type_Code;                 
   STRING2   Alias_Century;                                        
   STRING2   Alias_Year;                                           
   STRING2   Alias_Month;                                          
   STRING2   Alias_Day;  
 end;
 
 SHARED Alias_Delivery_Address_Range := RECORD,MAXLENGTH(20)
   STRING10  Delivery_Address_Low_No;                              
   STRING10  Delivery_Address_High_No;       
 end;
 
 EXPORT Alias_Record_Sprayed := RECORD,MAXLENGTH(mlength)
   STRING1   Copyright_Detail_Code;          
   STRING5   Zip_Code;                                            
   Alias_Street_Information     Alias_Street_Information;
   Street_Information           Street_Information;  
   STRING1 Alias_Type_Code;
   Alias_Date                   Alias_Date;
   Alias_Delivery_Address_Range Alias_Delivery_Address_Range;                        
   STRING1   Alias_Range_Odd_Even_Code;                            
   STRING21  Filler_1;   
 end;
 
 EXPORT Alias_Record_Lookup := RECORD,MAXLENGTH(mlength + 8) 
   Alias_Record_Sprayed;
   UNSIGNED4   date_first_seen;
   UNSIGNED4   date_last_seen;
 end;

//-----------ZONE SPLIT RECORD------------
 
 SHARED Old_Zip_Carrier_Route := RECORD,MAXLENGTH(9)  
   STRING5  Zip_Code;    
   STRING4  Carrier_Route_Id;   
 end;  
 
 SHARED New_Zip_Carrier_Route := RECORD,MAXLENGTH(9)           
   STRING5  Zip_Code;                     
   STRING4  Carrier_Route_Id;             
 end;  

 SHARED Transaction_Date := RECORD,MAXLENGTH(8)
   STRING2  Transaction_Century;        
   STRING2  Transaction_Year;             
   STRING2  Transaction_Month;            
   STRING2  Transaction_Day;              
 end;  

 EXPORT Zone_Split_Record_Sprayed := RECORD,MAXLENGTH(mlength)
  STRING1                Copyright_Detail_Code; 
  Old_Zip_Carrier_Route  Old_Zip_Carrier_Route;
  New_Zip_Carrier_Route  New_Zip_Carrier_Route;
  Transaction_Date       Transaction_Date;
  STRING102              Filler;
 end;
 
 EXPORT Zone_Split_Record_Lookup := RECORD,MAXLENGTH(mlength + 8)
   Zone_Split_Record_Sprayed;
   UNSIGNED4     date_first_seen;
   UNSIGNED4     date_last_seen;
 end;
 
 //----------Detail Record
 EXPORT Detail_Record_Sprayed := RECORD, MAXLENGTH(mlength)
   STRING1  Copyright_Detail_Code;    
   STRING5  Zip_Code;                  
   STRING6  City_State_Key;            
   STRING1  Zip_Classification_Code;     
   STRING28 City_State_Name;           
   STRING13 City_State_Name_Abbrev;    
   STRING1  Ctyst_Name_Facility_Code;  
   STRING1  Ctyst_Mailing_Name_Ind;    
   STRING6  Prefd_Last_Line_Ctyst_Key;  
   STRING28 Prefd_Last_Line_Ctyst_Nam; 
   STRING1  City_Delv_Ind;             
   STRING1  Carr_Rte_Rate_Sort_Ind;    
   STRING1  Unique_Zip_Name_Inc;       
   STRING6  Finance_No;                
   STRING2  State_Abbrev;              
   STRING3  County_No;                 
   STRING25 County_Name;  
 end; 
 
  EXPORT Detail_Record_Lookup := RECORD, MAXLENGTH(mlength + 8)
    Detail_Record_Sprayed;
    UNSIGNED4  date_first_seen;
    UNSIGNED4  date_last_seen;
  end;
end;