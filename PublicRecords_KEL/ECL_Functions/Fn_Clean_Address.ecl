/* Cleans input address
*/
IMPORT Address;
EXPORT Fn_Clean_Address(STRING street_addr, STRING p_city_name, STRING st, STRING z5) := FUNCTION
  city_st_zip := Address.Addr2FromComponents(p_city_name, St, z5);
  CleanedAddr := Address.CleanAddress182(street_addr, city_st_zip);
  //this will export out the parsed address fields for easier usability.
  mod_CleanedAddr := Address.CleanFields(CleanedAddr); 
  RETURN mod_CleanedAddr;
END;