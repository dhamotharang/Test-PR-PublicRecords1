import header,doxie;
r := doxie.File_Relatives_Plus;

doxie.Layout_Relatives_Plus swap(doxie.Layout_Relatives_Plus le) := transform
  self.person1 := le.person2;
  self.person2 := le.person1;
  self := le;
  end;

res := r + project(r,swap(left));

export key_prep_relatives := INDEX(res(number_cohabits>=6),{person1,same_lname,number_cohabits,recent_cohabit,person2,(big_endian unsigned8 )__filepos},'key::relatives' +  thorlib.wuid());