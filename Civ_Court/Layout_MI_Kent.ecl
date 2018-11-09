export Layout_MI_Kent := Module

Export Old_layout := 
 record
string Case_Number;	
string Plaintiff_Name;
string Defendant_Name;	
string Mailing_Address;	
string City;
string State;	
string Zip;
string In_Favor_Of;
string Amount;
string Judgement_Date;
string Judgement;
 end; 
 
 Export new_layout := 
  record
string Case_Number;	
string Plaintiff_Name;
string Defendant_Name;	
string Mailing_Address;	
// string City;
// string State;	
// string Zip;
string In_Favor_Of;
string Judgement;
string Amount;
string Judgement_Date;
 end;

Export Common_layout := 
  record
string Case_Number;	
string Plaintiff_Name;
string Defendant_Name;	
string Mailing_Address;	
string City;
string State;	
string Zip;
string In_Favor_Of;
string Judgement;
string Amount;
string Judgement_Date;
 end;
	
end;