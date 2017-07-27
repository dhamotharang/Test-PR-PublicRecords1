export Layout_Liens_CA_Fedral_Person_Debtor := 
record
string8     process_date  ;
string16    TMSID;
string16    RMSID;
string1 	Record_Code; 
string14 	Initial_Filing_Number;
string12 	Static; 
string50 	Personal_Debtor_Last_Name;
string50 	Personal_Debtor_First_Name;
string50 	Personal_Debtor_Middle_Name;
string6 	Personal_Debtor_Suffix;
string110 	Personal_Debtor_Street_Address;
string64 	Personal_Debtor_City;
string32 	Personal_Debtor_State;
string15 	Personal_Debtor_Zip_Code;
string6	    Personal_Debtor_Zip_Code_Extension;
string3 	Personal_Debtor_Country_Code;


string182   clean_Person_debtor_addr ;
string73    clean_person_debtor_pname;
string2     Filing_Jurisdiction;

end;