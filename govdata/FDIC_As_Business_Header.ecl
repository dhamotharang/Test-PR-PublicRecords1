import Business_Header, ut;

FDIC_In := File_FDIC_BDID;

Business_Header.Layout_Business_Header Translate_FDIC_To_BHF(Layout_FDIC_BDID l) := transform
self.source := 'FD';          // Source file type
self.source_group := '';
self.vendor_id := l.FED_RSSD; // A unique number assigned by the Federal Reserve Board (FRB) used to identify as the entity's unique identifier.
self.dt_first_seen := (unsigned4)(l.EFFDATE[1..4] + l.EFFDATE[6..7] + l.EFFDATE[9..10]);
self.dt_last_seen := if(l.ENDEFYMD[1..4] = '9999' or l.ACTIVE = '1',
                         (unsigned4)(l.REPDTE[1..4] + l.REPDTE[6..7] + l.REPDTE[9..10]),
                         (unsigned4)(l.ENDEFYMD[1..4] + l.ENDEFYMD[6..7] + l.ENDEFYMD[9..10]));
self.dt_vendor_first_reported := (unsigned4)(l.EFFDATE[1..4] + l.EFFDATE[6..7] + l.EFFDATE[9..10]);
self.dt_vendor_last_reported := if(l.ENDEFYMD[1..4] = '9999' or l.ACTIVE = '1',
                         (unsigned4)(l.REPDTE[1..4] + l.REPDTE[6..7] + l.REPDTE[9..10]),
                         (unsigned4)(l.ENDEFYMD[1..4] + l.ENDEFYMD[6..7] + l.ENDEFYMD[9..10]));
self.company_name := Stringlib.StringToUpperCase(l.NAME);
self.city := l.p_city_name;
self.state := l.st;
self.zip := (unsigned3)l.zip5;
self.zip4 := (unsigned2)l.zip4;
self.county := l.fipscounty;
self.msa := l.msa_code;
self.phone := 0;
self.current := if(l.ACTIVE = '1', true, false);          // Current/Historical indicator
self := l;
end;

FDIC_Init := project(FDIC_In, Translate_FDIC_To_BHF(left));

// Rollup
Business_Header.Layout_Business_Header RollupFDIC(Business_Header.Layout_Business_Header L, Business_Header.Layout_Business_Header R) := TRANSFORM
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
		    ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
SELF.vendor_id := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
                     L.vendor_id = '', R.vendor_id, L.vendor_id);
SELF.source_group := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
                     L.source_group = '', R.source_group, L.source_group);
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
SELF := L;
END;

FDIC_Init_Dist := DISTRIBUTE(FDIC_Init,
                    HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
FDIC_Init_Sort := SORT(FDIC_Init_Dist, zip, prim_range, prim_name, source_group, company_name,
                    IF(sec_range <> '', 0, 1), sec_range,
                    IF(phone <> 0, 0, 1), phone,
                    IF(fein <> 0, 0, 1), fein,
                    dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
FDIC_Init_Rollup := ROLLUP(FDIC_Init_Sort,
			        left.zip = right.zip and
			          left.prim_name = right.prim_name and
			          left.prim_range = right.prim_range and
			          left.company_name = right.company_name and
                      left.source_group = right.source_group and
			          (right.sec_range = '' OR left.sec_range = right.sec_range) and
                      (right.phone = 0 OR left.phone = right.phone) and
			          (right.fein = 0 OR left.fein = right.fein),
                    RollupFDIC(LEFT, RIGHT),
                    LOCAL) : PERSIST('TMTEMP::FDIC_Company_Rollup');












export FDIC_As_Business_Header := FDIC_Init_Rollup;