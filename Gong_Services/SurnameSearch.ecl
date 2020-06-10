import dx_gong, doxie, Suppress, ut, NID;

export SurnameSearch(doxie.IDataAccess mod_access) := function
  doxie.MAC_Header_Field_Declare();

  clean_names := dx_gong.key_history_clean_name () (
    KEYED (ut.phoneticLnameMatch (dph_name_last, lname_value)),
    KEYED (name_last = lname_value),
    KEYED (state_value = '' or st = state_value),
    KEYED (fname_value = '' or NID.mod_PFirstTools.RinPFL (fname_value, p_name_first)),
    KEYED (fname_value = '' or name_first = fname_value or nicknames));

  // by usage: if there are more than 5000, then gong/key_surname is used to get the count
  res := CHOOSEN(clean_names, 5000);
  //TODO: create a constant for 5 thousand.
  res_d := dedup(sort(res(did<>0), did),did) + res(did=0);
  res_optout := Suppress.MAC_SuppressSource(res_d, mod_access);

  return res_d(lname_value<>'');
end;
