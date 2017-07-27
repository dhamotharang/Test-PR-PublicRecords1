import gong, doxie, ut, NID;

doxie.MAC_Header_Field_Declare();

clean_names := Gong.Key_History_CleanName (
  KEYED (ut.phoneticLnameMatch (dph_name_last, lname_value)),
  KEYED (name_last = lname_value),
  KEYED (state_value = '' or st = state_value),
  KEYED (fname_value = '' or NID.mod_PFirstTools.RinPFL (fname_value, p_name_first)),
  KEYED (fname_value = '' or name_first = fname_value or nicknames));

// by usage: if there are more than 5000, then gong/key_surname is used to get the count
res := CHOOSEN (clean_names, 5000);
//TODO: create a constant for 5 thousand.

res_d := dedup(sort(res(did<>0), did),did) + res(did=0); 		

export SurnameSearch := res_d(lname_value<>'');