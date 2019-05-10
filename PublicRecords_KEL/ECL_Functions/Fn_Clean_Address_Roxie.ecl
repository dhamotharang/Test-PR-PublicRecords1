/* Cleans input address
*/
IMPORT Address, STD;
EXPORT Fn_Clean_Address_Roxie(STRING street_addr, STRING p_city_name, STRING st, STRING z5) := FUNCTION

	CleanSpacesAndUpper(STRING pStr) := STD.Str.ToUpperCase(STD.Str.CleanSpaces(pStr));

	address_line1    :=  STD.Str.Filter(CleanSpacesAndUpper(street_addr),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.\\/#- '); 
	address_line1_filtered := IF(LENGTH(TRIM(address_line1)) <= 2,'',address_line1);
  city_st_zip := Address.Addr2FromComponents(p_city_name, St, z5);
  CleanedAddr := Address.CleanAddress182(address_line1_filtered, city_st_zip);
  //this will export out the parsed address fields for easier usability.
  mod_CleanedAddr := Address.CleanFields(CleanedAddr); 
  RETURN mod_CleanedAddr;
END;



