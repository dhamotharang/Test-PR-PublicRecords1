EXPORT Layout_OSFI_Canada_Entities_of_Concern := module;


export layout_entities := record
   string ID;
   string entity;
   string Address;
   string basis3;
end;


export layout_individuals := record
   string ID;
   string LastName;
   string First_Name;
   string SecondName;
   string ThirdName;
   string FourthName;
   string POB;
   string ALTPOB;
   string DOB4;
   string ALTDOB1;
   string ALTDOB2;
   string ALTDOB3;
   string Nationality;
   string ALTNAtionality1;
   string ALTNationality2;
   string OtherInfo;
   string basis5;
end;


export layout_parse_address_and_count := record
   integer Address_Count;
   string ID;
   string entity;
   string Address;
   string addresses_parsed;
   string addresses_no_parsed;
   string basis3;
end;


export layout_clean_norm := record
  string6 ID;
  string350 entity;
  string1000 Address;
  string1000 comments;
  string1050 basis3;
  string10 last_vend_upd;
end;

export layout_Rollup := record
  string6 ID;
  string350 entity;
  string1000 Address;
  string1000 comments;
  string1050 basis3;
  string10 last_vend_upd;
end;


export layout_party_key_and_lkps := record
  string10 pty_key;
  string60 source;
  string350 orig_pty_name;
  string350 orig_vessel_name;
  string100 country;
  string10 name_type;
  string750 addr_1;
  string750 addr_2;
  string750 addr_3;
  string1050 remarks_1;
  string1050 remarks_2;
  string1050 remarks_3;
  string1050 remarks_4;
  string1050 remarks_5;
  string1050 remarks_6;
  string1050 remarks_7;
  string1050 remarks_8;
  string1050 remarks_9;
  string350 cname_clean;
  string73 pname_clean;
  string182 addr_clean;
end;



// individual
export layout_individuals_clean := record
  string6 ID;
  string35 LastName;
  string30 First_Name;
  string30 SecondName;
  string30 ThirdName;
  string30 FourthName;
  string80 POB;
  string80 ALTPOB;
  string25 DOB4;
  string25 ALTDOB1;
  string20 ALTDOB2;
  string20 ALTDOB3;
  string35 Nationality;
  string60 ALTNAtionality1;
  string60 ALTNationality2;
  string1500 OtherInfo;
  string200 basis5;
  string200 lstd_entity;
  string10 last_vend_upd;
end;

export layout_reformat_DOB := record
  string6 ID;
  string35 LastName;
  string30 First_Name;
  string30 SecondName;
  string30 ThirdName;
  string30 FourthName;
  string80 POB;
  string80 ALTPOB;
  string25 DOB4;
  string25 ALTDOB1;
  string20 ALTDOB2;
  string20 ALTDOB3;
  string35 Nationality;
  string60 ALTNAtionality1;
  string60 ALTNationality2;
  string1500 OtherInfo;
  string200 basis5;
  string200 lstd_entity;
  string73 name;
end;

export layout_aka_and_remarks := record
  string10 pty_key;
  string60 source;
  string350 orig_pty_name;
  string350 orig_vessel_name;
  string100 country;
  string10 name_type;
  string750 addr_1;
  string750 addr_2;
  string750 addr_3;
  string remarks_1;
  string1050 remarks_2;
  string1050 remarks_3;
  string1050 remarks_4;
  string1050 remarks_5;
  string1050 remarks_6;
  string1050 remarks_7;
  string1050 remarks_8;
  string1050 remarks_9;
  string350 cname_clean; 
  string73 pname_clean;
  string182 addr_clean;
end;

end;

