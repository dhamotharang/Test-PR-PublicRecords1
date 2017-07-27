import lib_ziplib,lib_stringlib;
export set of integer4 ZipsWithinCity(string2 st,string city) := 
FUNCTION

// In case the caller doesn't pass in all uppercase values, convert the input 
// state & city to all uppercase, which is required by certain functions below.
tst := trim(stringlib.StringToUpperCase(st),LEFT,RIGHT);
tcity := trim(stringlib.StringToUpperCase(city),LEFT,RIGHT);

azip := ziplib.CityToZip5(tst,tcity);

set_acircle := ziplib.ZipsWithinRadius(azip, 50);

ds_acircle := dataset(set_acircle,{integer4 zip});

// Since ZipToCities returns a string with a count followed by a comma followed by 
// city name(s) delimited by commas; the line below was revised to do a find on a "," 
// then a city name in the output of ZipToCities so just the input city is found 
// instead of some variation thereof.
// i.e. now only "LEBANON" is found instead of "SOUTH LEBANON" & "NEW LEBANON"
// This was done in case multiple city name variations exist within 50 miles of each 
// other in the same state.
acity := ds_acircle(stringlib.StringFind(ziplib.ZipToCities((string5)zip),','+tcity, 1)>0);

// Filter to make sure zip(s) being returned are for the input state.
// Since there are a few cases where 2 cities with the exact same name are within 
// 50 miles of each other, but are in different states. 
// i.e Brookville OH & Brookville IN
acityinst := acity(ziplib.ZipToState2((string) zip)=tst);

return set(acityinst, zip);

END;