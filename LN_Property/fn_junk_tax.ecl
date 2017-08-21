export fn_junk_tax(dataset(recordof(ln_property.Layout_Property_Common_Model_BASE)) in_assr) :=
function

/*if we're not provided either a valid state_code or fips_code assume the record is junk*/
/*as of the 20070705 build there 7464 records*/

keep_the_good := in_assr((state_code in ln_property.valid_states or fips_code in ln_property.valid_fips));

return keep_the_good;

end;