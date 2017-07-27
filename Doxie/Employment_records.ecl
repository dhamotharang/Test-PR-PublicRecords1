import doxie, doxie_crs, suppress, census_data, Doxie_Raw, ut;

doxie.MAC_Header_Field_Declare();
doxie.MAC_Selection_Declare(); //TODO: find out if Max_PeopleAtWork is used at all.

export Employment_records (dataset (doxie.layout_references) dids) := function

//***** RAW RECORDS
outf1 := Doxie_Raw.paw_raw(
	dids,
	dateVal,
	dppa_purpose,
	glb_purpose);


//***** ADD COUNTY AND DECODE SCORE
doxie_crs.Layout_employment xt(outf1 L, census_data.Key_Fips2County R) := transform
	self.county_name := r.county_name;
	self.active_phone_flag_name := if(l.active_phone_flag='Y', true, false);
	self.verified := l.active_phone_flag='Y' and l.company_phone <> '';
	self.score_name := map((unsigned)l.score > 6 => '1',
                            (unsigned)l.score > 4 => '2',
                            '3');
	self := l;
	self.company_timezone := '';
	self.timezone := '';
end;

outf2 := join(outf1,census_data.Key_Fips2County,
                    keyed(left.state = right.state_code and
                    left.county = right.county_fips),
                    xt(left, right),left outer, KEEP (1), limit(0));

 
outf4 := topn(outf2, Max_PeopleAtWork, -(unsigned)dt_last_seen, -(unsigned)dt_first_seen);

ut.getTimeZone(outf4,company_phone,company_timezone,outf4_w_company_tzone)
ut.getTimeZone(outf4_w_company_tzone,phone,timezone,outf4_w_tzones)	

//***** MASK
suppress.MAC_Mask(outf4_w_tzones, out_mskd, ssn, blank, true, false);

return out_mskd;
end;
