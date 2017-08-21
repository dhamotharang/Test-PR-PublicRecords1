import ln_propertyv2, ut,property,ln_property;

/*if we're not provided either a valid state_code or fips_code assume the record is junk*/
/*as of the 20070705 build there 7464 records*/

export Mac_junk_tax := module

export fares_asses(dataset(recordof(property.Layout_Fares_Assessor)) in_asses0) := function

temp_rec := record 
property.Layout_Fares_Assessor ; 
string2 temp_state ; 
end ; 

temp_rec reformat(in_asses0 L) := transform

self.temp_state := if(trim(L.prop_st)!='',StringLib.StringToUpperCase(L.prop_st),StringLib.StringToUpperCase(L.prop_state));
self := L;
end;

clean_st := project(in_asses0, reformat(left));

filterout_bad := clean_st((temp_state in ln_property.valid_states or fips_code in ln_property.valid_fips));

property.Layout_Fares_Assessor 	format(filterout_bad L) := transform
self := L;
end;

keep_the_good := project(filterout_bad, format(left));

return keep_the_good;
end;

export ln_asses(dataset(recordof(ln_propertyv2.Layout_Property_Common_Model_BASE)) in_assr) :=
function

keep_the_good := in_assr((state_code in ln_property.valid_states or fips_code in ln_property.valid_fips));

return keep_the_good;

end;

end;


