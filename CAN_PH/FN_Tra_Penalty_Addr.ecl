// simplified version of doxie.FN_Tra_Penalty_Addr
// 'postalcode' is explicitely passed

IMPORT doxie, ut;

// Main differencies from standard address penalty calculations (doxie.FN_Tra_Penalty_Addr):
// no wild;
// no post-dir in Can. address
// postal code inetead of zip

EXPORT FN_Tra_Penalty_Addr (
  string predir_field, string prange_field, string pname_field, string suffix_field,
  string sec_range_field, string city_field, string province_field,
  string postalcode_field) := FUNCTION

  doxie.MAC_Header_Field_Declare();
  uprange := (unsigned8) prange_field;

  pen := 
  MAP (city_value = '' or city_field = city_value or city_field = input_city_value => 0, 
       city_field='' => 3,
       ut.stringsimilar (city_field, city_value)<3 or ut.stringsimilar (city_field, input_city_value)<3 => 1,	 
       5) +
  IF (state_value = '' or province_field = state_value, 0, 10) +
  MAP ((zip_val = '') or (zip_val = stringlib.stringtouppercase(postalcode_field)) => 0,
       postalcode_field = '' => 2, 
       10) +
  MAP (predir_value = '' or predir_field = predir_value => 0, 1) +
  MAP (addr_suffix_value = '' or suffix_field = addr_suffix_value => 0, 1) +
  MAP (pname_value='' or ut.StripOrdinal (pname_field) = pname_value => 0,
       pname_field='' => 8, 
       ut.stringsimilar (pname_value, pname_field)) +
  MAP ((unsigned8)prange_value=0 or uprange = (unsigned8)prange_value => 0,
       addr_range AND (uprange >= prange_beg_value) AND (uprange <= prange_end_value) => 0,
       uprange=0 => 2,
       ut.stringsimilar (prange_value,prange_field));

  RETURN pen;
END;
