

EXPORT Layout_Bank_of_England := MODULE


// need lenghts
export Layout_sanctionsconlist := record
   string Name_6;
   string Name_1;
   string Name_2;
   string Name_3;
   string Name_4;
   string Name_5;
   string Title;
   string DOB;
   string Town_of_Birth;
   string Country_of_Birth;
   string Nationality;
   string Passport_Details;
   string NI_Number;
   string Position;
   string Address_1;
   string Address_2;
   string Address_3;
   string Address_4;
   string Address_5;
   string Address_6;
   string Post_Zip_Code;
   string Country;
   string Other_Information;
   string Group_Type;
   string Alias_Type;
   string Regime;
   string Listed_On;
   string Last_updated;
   string Group_ID;
end;

export layout_clean_up := record
  string ent_key;
  string source;
  string lstd_entity;
  string first_name;
  string last_name;
  string title;
  string dob;
  string Town_of_Birth;
  string Country_of_Birth;
  string Nationality;
  string Passport_Details;
  string NI_Number;
  string position;
  string Address_1;
  string Address_2;
  string Address_3;
  string Address_4;
  string Address_5;
  string Address_6;
  string Post_Zip_Code;
  string Country;
  string address_addl_info;
  string Group_Type;
  string alias_type;
  string Regime;
 // string Listed_On;
 // string Last_Updated;
  string Group_ID;
  string lf;
end;

end;


