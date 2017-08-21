EXPORT Layout_OFAC_Specially_Designated_Nationals := module;

export Layout_Primary := record
  string Record_Type;
  string SDN_ID;
  string First_Name;
  string Last_Name;
  string Title;
  string AKA_ID;
  string AKA_Type;
  string AKA_Category;
  string GIV_Designator;
  string Remarks;
  string Call_Sign;
  string Vessel_Type;
  string Tonnage;
  string Gross_Registered_Tonnage;
  string Vessel_Flag;
  string Vessel_Owner;
end;

export Layout_Program := record
  string Record_Type;
  string SDN_ID;
  string Program;
end;

export Layout_Address := record
  string Record_Type;
  string SDN_ID;
  string Address_ID;
  string Address_Line_1;
  string Address_Line_2;
  string Address_Line_3;
  string Address_City;
  string Address_State;
  string Address_Postal_Code;
  string Address_Country;
end;

export Layout_ID := record
  string Record_Type;
  string SDN_ID;
  string ID_ID;
  string ID_Type;
  string ID_Number;
  string ID_Country;
  string ID_Issue_Date;
  string ID_Expiration_Date;
end;

export Layout_Nationality := record
  string Record_Type;
  string SDN_ID;
  string Nationality_ID;
  string Nationality;
  string Primary_Nationality_Flag;
end;

export Layout_Citizenship := record
  string Record_Type;
  string SDN_ID;
  string Citizenship_ID;
  string Citizenship;
  string Primary_Citizenship_Flag;
end;

export Layout_DOB := record
  string Record_Type;
  string SDN_ID;
  string Date_of_Birth_ID;
  string DOB;
  string Primary_Date_of_Birth_Flag;
end;

export Layout_POB := record
  string Record_Type;
  string SDN_ID;
  string Place_of_Birth_ID;
  string POB;
  string Primary_Place_of_Birth_Flag;
end;

end;

