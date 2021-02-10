IMPORT census_data, doxie_cbrs_raw;
doxie_cbrs.mac_Selection_Declare()

EXPORT contact_records_raw(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

outf1 := doxie_cbrs_raw.contacts(bdids,Include_AssociatedPeople_val OR Include_Executives_val,Max_AssociatedPeople_val,application_type_value).records;
       
outlayout := doxie_cbrs.layout_contact.raw_rec;

outlayout into_out(outf1 L) := TRANSFORM
  SELF.record_type_decoded := MAP(L.record_type = 'C' => 'Current',
                L.record_type = 'H' => 'Historical',
                '');
  SELF.county_decoded := '';
  SELF.ssn := IF(l.ssn > 0, INTFORMAT(l.ssn,9,1), '');
  SELF := L;
END;

outf2 := PROJECT(outf1,into_out(LEFT));

outlayout map_county(outf2 L, census_data.Key_Fips2County R) := TRANSFORM
  SELF.county_decoded := R.county_name;
  SELF := L;
END;

RETURN JOIN(outf2,census_data.Key_Fips2County, LEFT.state != '' AND
                      KEYED (LEFT.state = RIGHT.state_code) AND
                      KEYED (LEFT.county = RIGHT.county_fips),
                      map_county(LEFT,RIGHT),LEFT OUTER, KEEP (1));
END;
