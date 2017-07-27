export layout_mar_div_intermediate := record
  
 marriage_divorce_v2.layout_mar_div_base;

 //if the incoming data has both parties together, just map to here and we'll call the conjunctive cleaner
 string1   conjunctive_name_format;
 string100 conjunctive_party;
 
 string73  pname_party1;
 string73  pname_party2;
 string73  pname_party1_alias;
 string73  pname_party2_alias;
 string182 ca_party1;
 string182 ca_party2;

 string1   touched;
 
 string9   party1_ssn;
 string9   party2_ssn;
 
end;
