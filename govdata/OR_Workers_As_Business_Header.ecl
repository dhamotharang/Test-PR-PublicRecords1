import business_header, ut;

f := govdata.File_OR_Workers_Comp_BDID;

Business_Header.Layout_Business_Header TranslateORWC(f l, unsigned1 cnt, unsigned1 addrtype) := transform
self.bdid := L.bdid;
self.vendor_id := 'OR' + l.employer_number;
self.dt_first_seen := (unsigned4)l.date_first_seen;
self.dt_last_seen := (unsigned4)l.date_last_seen;
self.dt_vendor_first_reported := (unsigned4)l.date_first_seen;
self.dt_vendor_last_reported := (unsigned4)l.date_last_seen;
self.source := 'WC';
self.source_group := ''; 
self.company_name := choose(cnt, l.Employer_Legal_Name, l.Doing_Business_as_Name_1, l.Doing_Business_as_Name_2,
	                                 l.Doing_Business_as_Name_3, l.Doing_Business_as_Name_4, l.Doing_Business_as_Name_5, '');
self.prim_range := choose(addrtype, l.mailing_prim_range, l.ppb_prim_range);
self.predir := choose(addrtype, l.mailing_predir, l.ppb_predir);
self.prim_name := choose(addrtype, l.mailing_prim_name, l.ppb_prim_name);
self.addr_suffix := choose(addrtype, l.mailing_addr_suffix, l.ppb_addr_suffix);
self.postdir := choose(addrtype, l.mailing_postdir, l.ppb_postdir);
self.unit_desig := choose(addrtype, l.mailing_unit_desig, l.ppb_unit_desig);
self.sec_range := choose(addrtype, l.mailing_sec_range, l.ppb_sec_range);
self.city := choose(addrtype, l.mailing_p_city_name, l.ppb_p_city_name);
self.state := choose(addrtype, l.mailing_st, l.ppb_st);
self.zip := (unsigned3)choose(addrtype, l.mailing_zip5, l.ppb_zip5);
self.zip4 := (unsigned2)choose(addrtype, l.mailing_zip4, l.ppb_zip4);
self.county := choose(addrtype, l.mailing_fipscounty, l.ppb_fipscounty);
self.msa := choose(addrtype, l.mailing_msa, l.ppb_msa);
self.geo_lat := choose(addrtype, l.mailing_geo_lat, l.ppb_geo_lat);
self.geo_long := choose(addrtype, l.mailing_geo_long, l.ppb_geo_long);
self.phone := (unsigned6)l.PPB_Phone_Number;	
self.phone_score := if(self.phone = 0, 0, 1);
self.current := true;
end;

orwc_mailing_norm := normalize(f, 6, TranslateORWC(left, counter, 1));
orwc_ppb_norm := normalize(f(ppb_address_line_1[1..3] <> 'NO ',
                             ppb_address_line_2[1..3] <> 'NO ',
                             ppb_address_line_1 not in ['STATEWIDE', 'UNKNOWN'],
                             ppb_address_line_2 not in ['STATEWIDE', 'UNKNOWN'],
					    (integer)ppb_zip5 <> 0,  ppb_prim_name <> ''), 6, TranslateORWC(left, counter, 2));

orwc_combined := orwc_mailing_norm(company_name <> '') + orwc_ppb_norm(company_name <> '');

// Rollup
Business_Header.Layout_Business_Header RollupORWC(Business_Header.Layout_Business_Header L, Business_Header.Layout_Business_Header R) := TRANSForM
self.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
		    ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
self.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
self.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
self.company_name := if(L.company_name = '', R.company_name, L.company_name);
self.group1_id := if(L.group1_id = 0, R.group1_id, L.group1_id);
self.vendor_id := if((L.group1_id = 0 and R.group1_id <> 0) or
                     L.vendor_id = '', R.vendor_id, L.vendor_id);
self.source_group := if((L.group1_id = 0 and R.group1_id <> 0) or
                     L.source_group = '', R.source_group, L.source_group);
self.phone := if(L.phone = 0, R.phone, L.phone);
self.phone_score := if(L.phone = 0, R.phone_score, L.phone_score);
self.fein := if(L.fein = 0, R.fein, L.fein);
self.prim_range := if(l.prim_range = '' and l.zip4 = 0, r.prim_range, l.prim_range);
self.predir := if(l.predir = '' and l.zip4 = 0, r.predir, l.predir);
self.prim_name := if(l.prim_name = '' and l.zip4 = 0, r.prim_name, l.prim_name);
self.addr_suffix := if(l.addr_suffix = '' and l.zip4 = 0, r.addr_suffix, l.addr_suffix);
self.postdir := if(l.postdir = '' and l.zip4 = 0, r.postdir, l.postdir);
self.unit_desig := if(l.unit_desig = ''and l.zip4 = 0, r.unit_desig, l.unit_desig);
self.sec_range := if(l.sec_range = '' and l .zip4 = 0, r.sec_range, l.sec_range);
self.city := if(l.city = '' and l.zip4 = 0, r.city, l.city);
self.state := if(l.state = '' and l.zip4 = 0, r.state, l.state);
self.zip := if(l.zip = 0 and l.zip4 = 0, r.zip, l.zip);
self.zip4 := if(l.zip4 = 0, r.zip4, l.zip4);
self.county := if(l.county = '' and l.zip4 = 0, r.county, l.county);
self.msa := if(l.msa = '' and l.zip4 = 0, r.msa, l.msa);
self.geo_lat := if(l.geo_lat = '' and l.zip4 = 0, r.geo_lat, l.geo_lat);
self.geo_long := if(l.geo_long = '' and l.zip4 = 0, r.geo_long, l.geo_long);
SELF := L;
END;

orwc_combined_dist := distribute(orwc_combined,
                        hash(zip, trim(prim_name), trim(prim_range), trim(source_group), trim(company_name)));
orwc_combined_sort := sort(orwc_combined, zip, prim_range, prim_name, source_group, company_name,
                           if(sec_range <> '', 0, 1), sec_range,
                           if(phone <> 0, 0, 1), phone,
                           if(fein <> 0, 0, 1), fein,
                            dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
orwc_combined_rollup := rollup(orwc_combined_sort,
			                left.zip = right.zip and
			                left.prim_name = right.prim_name and
			                left.prim_range = right.prim_range and
                               left.source_group = right.source_group and
			                left.company_name = right.company_name and
			                (right.sec_range = '' or left.sec_range = right.sec_range) and
                               (right.phone = 0 or left.phone = right.phone) and
			                (right.fein = 0 or left.fein = right.fein),
                               RollupORWC(left, right),
                               local);

export OR_Workers_As_Business_Header := orwc_combined_rollup : persist('TEMP::OR_Workers_As_Business_Header');
