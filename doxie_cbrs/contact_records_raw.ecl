import business_header, census_data, suppress, doxie, ut, doxie_cbrs_raw;
doxie_cbrs.mac_Selection_Declare()

export contact_records_raw(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

outf1 := doxie_cbrs_raw.contacts(bdids,Include_AssociatedPeople_val or Include_Executives_val,Max_AssociatedPeople_val,application_type_value).records;
			 
outlayout := doxie_cbrs.layout_contacts;


outlayout into_out(outf1 L) := transform
	self.record_type_decoded := map(L.record_type = 'C' => 'Current',
							  L.record_type = 'H' => 'Historical',
							  '');
	self.county_decoded := '';
	self.ssn := if(l.ssn > 0, intformat(l.ssn,9,1), '');
	self := L;
end;

outf2 := project(outf1,into_out(LEFT));

outlayout map_county(outf2 L, census_data.Key_Fips2County R) := transform
	self.county_decoded := R.county_name;
	self := L;
end;

return join(outf2,census_data.Key_Fips2County, left.state != '' and 
									    keyed (left.state = right.state_code) and 
									    keyed (left.county = right.county_fips),
									    map_county(LEFT,RIGHT),left outer, KEEP (1));
END;