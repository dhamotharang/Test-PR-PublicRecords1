export Layout_FL_Hillsborough := module

export payload := 
record
string unparsedRec;
end;

export criminal := 
record
   string2 Blank1;
   string35 Name_Type;
   string1 Blank12;
   string9 ID;
   string2 Blank2;
   string4 Party_Code;
   string1 Blank3;
   string12 Defendant_Case_Number;
   string2 Blank4;
   string1 Division;
   string3 Blank5;
   string1 Sex;
   string1 Blank6;
   string1 Race;
   string2 Blank7;
   string10 Date_of_Birth;
   string2 Blank8;
   string8 Date_of_Filing;
   string2 Blank9;
   string3 Number_of_Count;
   string1 Blank10;
   string2 Level_of_Count;
   string2 Blank11;
   string46 Charge_Description;
   string2 blank_12;
   string5 Disposition_Code;
   string1 blank_13;
   string8 Disposition_Date;
   string1 lf;
end;

export traffic := 
record
   string19 Uniform_Case_Number;
   string1 blank_space_1;
   string24 Defendant_Name;
   string1 blank_space_2;
   string24 Defendant_Address;
   string1 blank_space_3;
   string24 Defendant_City_State;
   string1 blank_space_4;
   string5 Defendant_Zip;
   string1 blank_space_5;
   string10 Citation_Number;
   string1 blank_space_6;
   string8 Date_of_Offense;
   string2 blank_space_7;
   string10 Statute_Violated;
   string1 blank_space_8;
   string25 Statute_Description;
   string2 crlf;
end;
end;

