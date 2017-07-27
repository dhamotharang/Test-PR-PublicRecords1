export Layout_Liens_CA_Fedral_Person_Secured_party := 
record
string8     process_date  ;
string16    TMSID;
string16    RMSID;
string1	    Record_Code;
string14	Initial_Filing_Number;
string12	Static;
string50	Personal_Secured_Party_Last_Name;
string50	Personal_Secured_Party_First_Name;
string50	Personal_Secured_Party_Middle_Name;
string6	    Personal_Secured_Party_Suffix;
string110	Personal_Secured_Party_Street_Address;
string64	Personal_Secured_Party_City;
string32	Personal_Secured_Party_State;
string15	Personal_Secured_Party_Zip_Code;
string6	    Personal_Secured_Party_Zip_Code_Extension;
string3	    Personal_Secured_Party_Country_Code;
string2     Filing_Jurisdiction;
string182   clean_secured_party_addr;
string73    clean_secured_party_pname;
end;