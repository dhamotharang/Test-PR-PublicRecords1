import ln_mortgage;

export fn_junk_deed(dataset(recordof(ln_mortgage.Layout_Deed_Mortgage_Common_Model_BASE )) in_deed) :=
function

/*if we're not provided either a valid state or fips_code assume the record is junk*/
/*as of the 20070705 build there 76 records*/

keep_the_good := in_deed((state in ln_property.valid_states or fips_code in ln_property.valid_fips));

return keep_the_good;

end;