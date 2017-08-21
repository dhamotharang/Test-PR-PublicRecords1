IMPORT ut;

EXPORT Layout_Business_Header_New TRA_Merge_Business_Headers(Layout_Business_Header_New L, Layout_Business_Header_New R) := TRANSFORM
SELF.source := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
                  L.source = '', R.source, L.source);
SELF.source_group := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
                        L.source_group = '', R.source_group, L.source_group);
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
		    ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
SELF.dt_last_seen := max(L.dt_last_seen,R.dt_last_seen);
SELF.dt_vendor_last_reported := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
SELF.vendor_id := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
                     L.vendor_id = '', R.vendor_id, L.vendor_id);
SELF.phone := IF(L.phone = 0, R.phone, L.phone);
SELF.phone_score := IF(L.phone = 0, R.phone_score, L.phone_score);
SELF.fein := IF(L.fein = 0, R.fein, L.fein);
SELF.prim_range := IF(l.prim_range = '' AND l.zip4 = 0, r.prim_range, l.prim_range);
SELF.predir := IF(l.predir = '' AND l.zip4 = 0, r.predir, l.predir);
SELF.prim_name := IF(l.prim_name = '' AND l.zip4 = 0, r.prim_name, l.prim_name);
SELF.addr_suffix := IF(l.addr_suffix = '' AND l.zip4 = 0, r.addr_suffix, l.addr_suffix);
SELF.postdir := IF(l.postdir = '' AND l.zip4 = 0, r.postdir, l.postdir);
SELF.unit_desig := IF(l.unit_desig = ''AND l.zip4 = 0, r.unit_desig, l.unit_desig);
SELF.sec_range := IF(l.sec_range = '' AND l .zip4 = 0, r.sec_range, l.sec_range);
SELF.city := IF(l.city = '' AND l.zip4 = 0, r.city, l.city);
SELF.state := IF(l.state = '' AND l.zip4 = 0, r.state, l.state);
SELF.zip := IF(l.zip = 0 AND l.zip4 = 0, r.zip, l.zip);
SELF.zip4 := IF(l.zip4 = 0, r.zip4, l.zip4);
SELF.county := IF(l.county = '' AND l.zip4 = 0, r.county, l.county);
SELF.msa := IF(l.msa = '' AND l.zip4 = 0, r.msa, l.msa);
SELF.geo_lat := IF(l.geo_lat = '' AND l.zip4 = 0, r.geo_lat, l.geo_lat);
SELF.geo_long := IF(l.geo_long = '' AND l.zip4 = 0, r.geo_long, l.geo_long);
SELF.pflag := IF(l.pflag = '', r.pflag, l.pflag);
SELF.current := IF(L.current = TRUE, L.current, R.current);
SELF := L;
END;