import ln_propertyv2, ut,property,ln_property;

export fn_junk_deed := module
export ln_deeds(dataset(recordof(LN_PropertyV2.layout_deed_mortgage_common_model_base )) in_deed) :=
function

/*if we're not provided either a valid state or fips_code assume the record is junk*/
/*as of the 20070705 build there 76 records*/

keep_the_good := in_deed((state in ln_property.valid_states or fips_code in ln_property.valid_fips));

return keep_the_good;

end;

export fares_deeds(dataset(recordof(LN_PropertyV2_Fast.Layout_Fares_Deeds)) in_deeds0) := function

temp_rec := record 
recordof(in_deeds0); 
string2 temp_state ; 
end ; 

temp_rec reformat(in_deeds0 L) := transform

self.temp_state := if(trim(L.prop_state)!='',StringLib.StringToUpperCase(L.prop_state),StringLib.StringToUpperCase(L.prop_ace_state));
self := L;
end;

clean_st := project(in_deeds0, reformat(left));

filterout_bad := clean_st((temp_state in ln_property.valid_states or fips in ln_property.valid_fips));

recordof(in_deeds0) 	format(filterout_bad L) := transform
self := L;
end;

keep_the_good := project(filterout_bad, format(left));

return keep_the_good;

end;
end;