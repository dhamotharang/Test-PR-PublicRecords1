IMPORT Address,Census_data;
EXPORT fn_getCounty(string40 city, string2 st) := FUNCTION
  zip := ziplib.CityToZip5(st,city);
  a := Address.CleanFields(address.GetCleanAddress('',city+' '+st+' '+zip,address.Components.Country.US).str_addr);
  RETURN Census_data.Key_Fips2County(KEYED(state_code=a.st AND county_fips=a.county[3..5]))[1].county_name;
END;
