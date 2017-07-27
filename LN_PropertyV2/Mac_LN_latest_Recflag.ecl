import ut;

export Mac_LN_latest_Recflag := module

//******************** setup current record for assessor ********************************************************
export current_assessor(dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)) inAssessor) := function

ds1 := distribute(inAssessor, hash(fips_code, apna_or_pin_number, property_full_street_address, property_unit_number, property_city_state_zip, tax_year));

ds2 := sort(ds1,fips_code, apna_or_pin_number, property_full_street_address, property_unit_number, property_city_state_zip, tax_year, -process_date, local);

ds3 := dedup(ds2, fips_code, apna_or_pin_number, property_full_street_address, property_unit_number, property_city_state_zip, local);


LN_PropertyV2.Layout_Property_Common_Model_BASE tsetupflagA(ds1 L, ds3 R) := transform

self.current_record := if(L.ln_fares_id = r.ln_fares_id, 'Y', '');

self := L;

end;

assessor_flag := join(ds1, ds3, left.fips_code = right.fips_code and left.apna_or_pin_number = right.apna_or_pin_number 
                 and left.property_full_street_address = right.property_full_street_address and left.property_unit_number = right.property_unit_number
				 and left.property_city_state_zip = right.property_city_state_zip, tsetupflagA(left, right), left outer, local);			   

return assessor_flag;
end;

//******************** setup current record for deeds ********************************************************

export current_Deeds(dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeeds) := function
										 
deeds1 := distribute(inDeeds, hash(fips_code, apnt_or_pin_number, name1, property_full_street_address, property_address_unit_number, property_address_citystatezip));
deeds2 := sort(deeds1, fips_code, apnt_or_pin_number, name1, property_full_street_address,property_address_unit_number, property_address_citystatezip, -process_date, -recording_date,local);
deeds3 := dedup(deeds2,   fips_code, apnt_or_pin_number, name1, property_full_street_address,property_address_unit_number, property_address_citystatezip, local);


LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE tsetupflagA(deeds1 L, deeds3 R) := transform

self.current_record := if(L.ln_fares_id = r.ln_fares_id, 'Y', '');

self := L;

end;

deeds_flag := join(deeds1, deeds3, left.fips_code = right.fips_code and left.name1 = right.name1
                 and left.property_full_street_address = right.property_full_street_address and left.property_address_unit_number = right.property_address_unit_number
				 and left.property_address_citystatezip = right.property_address_citystatezip, tsetupflagA(left, right), left outer, local);			   


return deeds_flag;

end;

end;