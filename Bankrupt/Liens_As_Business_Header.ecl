import Business_Header, ut;

//*************************************************************************
// Translate Liens/Judgements to Common Business Header Format
//*************************************************************************

Business_Header.Layout_Business_Header  Translate_Liens_to_BHF(Layout_Liens l) := transform

dt_first_seen := (unsigned4)if((integer)l.filing_date <> 0 and (integer)l.uploaddate <> 0 and (integer)l.filing_date <= (integer)l.uploaddate, l.filing_date, l.uploaddate);
dt_last_seen := (unsigned4)if((integer)l.release_date <> 0 and (integer)l.uploaddate <> 0 and (integer)l.release_date <= (integer)l.uploaddate,
                                  l.release_date,
								  if((integer)l.filing_date <> 0 and (integer)l.uploaddate <> 0 and (integer)l.filing_date <= (integer)l.uploaddate, l.filing_date, l.uploaddate));
dt_vendor_first_reported :=  (unsigned4)if((integer)l.filing_date <> 0 and (integer)l.uploaddate <> 0 and (integer)l.filing_date <= (integer)l.uploaddate, l.filing_date, l.uploaddate);
dt_vendor_last_reported := (unsigned4)l.uploaddate;

minimum_date := 18000101;

self.bdid := 0;
self.company_name := if(l.def_company <> '', l.def_company, l.defname);
self.vendor_id := l.courtid + l.casenumber;
self.zip := (unsigned3)l.zip;
self.zip4 := (unsigned2)l.zip4;
self.phone := 0;
self.addr_suffix := l.suffix;
self.city := l.p_city_name;
self.county := l.county[3..5];
self.source := 'LJ';
self.source_group := l.courtid + l.casenumber;
self.dt_first_seen := if(dt_first_seen <> 0 and dt_first_seen >= minimum_date, dt_first_seen, (unsigned4)stringlib.GetDateYYYYMMDD());
self.dt_last_seen := if(dt_last_seen <> 0 and dt_last_seen >= minimum_date, dt_last_seen, (unsigned4)stringlib.GetDateYYYYMMDD());
self.dt_vendor_first_reported :=  if(dt_vendor_first_reported <> 0 and dt_vendor_first_reported >= minimum_date, dt_vendor_first_reported, (unsigned4)stringlib.GetDateYYYYMMDD());
self.dt_vendor_last_reported := if(dt_vendor_last_reported <> 0 and dt_vendor_last_reported >= minimum_date, dt_vendor_last_reported, (unsigned4)stringlib.GetDateYYYYMMDD());
self.fein := if(Business_Header.ValidFEIN((unsigned4)l.orig_ssn), (unsigned4)l.orig_ssn, 0);
self.current := true;
self := l;
end;

liens_init := project(File_Liens(indivbusun='B' or aka_yn = 'B'), Translate_Liens_to_BHF(left));

// Rollup
Business_Header.Layout_Business_Header RollupLiens(Business_Header.Layout_Business_Header L, Business_Header.Layout_Business_Header R) := transform
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
self.unit_desig := if(l.unit_desig = '' and l.zip4 = 0, r.unit_desig, l.unit_desig);
self.sec_range := if(l.sec_range = '' and l .zip4 = 0, r.sec_range, l.sec_range);
self.city := if(l.city = '' and l.zip4 = 0, r.city, l.city);
self.state := if(l.state = '' and l.zip4 = 0, r.state, l.state);
self.zip := if(l.zip = 0 and l.zip4 = 0, r.zip, l.zip);
self.zip4 := if(l.zip4 = 0, r.zip4, l.zip4);
self.county := if(l.county = '' and l.zip4 = 0, r.county, l.county);
self.msa := if(l.msa = '' and l.zip4 = 0, r.msa, l.msa);
self.geo_lat := if(l.geo_lat = '' and l.zip4 = 0, r.geo_lat, l.geo_lat);
self.geo_long := if(l.geo_long = '' and l.zip4 = 0, r.geo_long, l.geo_long);
self := l;
end;

liens_dist := distribute(liens_init,
                               hash(zip, trim(prim_name), trim(prim_range), trim(source_group), trim(company_name)));
liens_sort := sort(liens_dist, zip, prim_range, prim_name, source_group, company_name,
                      if(sec_range <> '', 0, 1), sec_range,
                      if(phone <> 0, 0, 1), phone,
                      if(fein <> 0, 0, 1), fein,
                      dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
liens_rollup := rollup(liens_sort,
			            left.zip = right.zip and
			            left.prim_name = right.prim_name and
			            left.prim_range = right.prim_range and
			            left.company_name = right.company_name and
                        left.source_group = right.source_group and
			            (right.sec_range = '' OR left.sec_range = right.sec_range) and
                        (right.phone = 0 OR left.phone = right.phone) and
			            (right.fein = 0 OR left.fein = right.fein),
                       RollupLiens(left, right),
                         local);

export Liens_As_Business_Header := liens_rollup : persist('TEMP::Liens_As_Business_Header');