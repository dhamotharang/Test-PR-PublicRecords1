IMPORT Business_Header, codes, ut, mdr;

export fGov_Phones_As_Business_Header(dataset(Layout_Gov_Phones_Base) pBasefile) :=
function

	gp_base := pBasefile; //(zip != '' AND prim_name != '');

	Business_Header.Layout_Business_Header_New Proj(gp_base l) := TRANSFORM
		SELF.source := MDR.sourceTools.src_Employee_Directories;          // Source file type
		SELF.source_group := '';
		SELF.vl_id := l.vendor + l.unique_id; // Synthetic uniqe id.
		SELF.vendor_id := l.vendor + l.unique_id; // Synthetic uniqe id.
		SELF.dt_first_seen := (UNSIGNED4) l.record_date;   // Date record first seen at Seisint
		SELF.dt_last_seen := (UNSIGNED4) l.record_date;    // Date record last (most recently seen) at Seisint
		SELF.dt_vendor_first_reported := (UNSIGNED4) l.record_date;
		SELF.dt_vendor_last_reported := (UNSIGNED4) l.record_date;
		SELF.company_name := if(l.state_origin = '' or StringLib.StringFind(Stringlib.StringToUpperCase(l.agency), trim(codes.St2Name(l.state_origin)), 1) > 0, Stringlib.StringToUpperCase(l.agency),
								trim(codes.St2Name(l.state_origin)) + ' ' + Stringlib.StringToUpperCase(l.agency));
		SELF.city := l.v_city_name;
		SELF.state := l.st;
		SELF.zip := (UNSIGNED3) l.zip;
		SELF.zip4 := (UNSIGNED2) l.zip4;
		SELF.county := l.fipscounty;
		SELF.phone := l.phone;
		SELF.phone_score := IF(SELF.phone = 0, 0, 1);
		SELF.fein := 0;
		SELF.current := TRUE;          // Current/Historical indicator
		SELF := l;
	END;

	gp_companies_init := PROJECT(gp_base(agency <> ''), Proj(LEFT));

	// Rollup
	Business_Header.Layout_Business_Header_New RollupGP(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSFORM
	SELF.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := max(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
	SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
	SELF.vl_id := IF(L.vl_id = '', R.vl_id, L.vl_id);
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

	gp_companies_dist := DISTRIBUTE(gp_companies_init,
								   HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name), phone));
	gp_companies_sort := SORT(gp_companies_dist, zip, prim_range, prim_name, source_group, company_name, phone,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	gp_companies_rollup := ROLLUP(gp_companies_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  left.phone = right.phone and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.fein = 0 OR left.fein = right.fein),
						RollupGP(LEFT, RIGHT),
						LOCAL);

	return gp_companies_rollup;

end;