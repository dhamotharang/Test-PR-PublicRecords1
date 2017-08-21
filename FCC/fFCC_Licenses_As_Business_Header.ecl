IMPORT Business_Header, ut,mdr;

export fFCC_Licenses_As_Business_Header(dataset(Layout_FCC_base_bip_AID) pfccInput) := 
function

string8 validatedate(string8 mydate) :=
map(mydate = '' or (integer)mydate > (integer)(stringlib.GetDateYYYYMMDD()) or (integer)mydate < 16000101 => '',
	mydate);

//*************************************************************************
// Translate FCC_Licenses file to Common Business Header Format
//*************************************************************************

FCC_Licenses_base := pfccInput;

Layout_FCC_Licenses_Local := RECORD
UNSIGNED6 record_id := 0;
FCC.Layout_FCC_base_bip_AID;
END;

//--------------------------------------------
// Add unique record id to FCC_Licenses file
//--------------------------------------------
Layout_FCC_Licenses_Local AddRecordID(Layout_FCC_base_bip_AID L) := TRANSFORM
SELF := L;
END;

FCC_Licenses_Init := PROJECT(FCC_Licenses_base, AddRecordID(LEFT));

ut.MAC_Sequence_Records(FCC_Licenses_Init, record_id, FCC_Licenses_Seq);

bh_layout := business_header.Layout_Business_Header_New;

bh_layout Translate_FCC_Licenses_To_BHF(Layout_FCC_Licenses_Local L, integer CTR) := transform
  SELF.group1_id := L.record_id;
	SELF.vl_id := trim(L.license_type) + '-' + (string34)hash64(trim(l.unique_key));
  SELF.vendor_id := trim(L.license_type) + '-' + (qstring34)hash64(trim(l.unique_key));
  SELF.phone := (UNSIGNED6)((UNSIGNED8)L.licensees_phone);
  SELF.phone_score := IF((UNSIGNED8)L.licensees_phone = 0, 0, 1);
  SELF.source := MDR.sourceTools.src_FCC_Radio_Licenses;
  SELF.source_group := '';
  SELF.company_name := choose(CTR,stringlib.stringtouppercase(L.licensees_name), stringlib.stringtouppercase(L.DBA_name));
  SELF.dt_first_seen := (UNSIGNED4)validatedate(L.date_of_last_change);
  SELF.dt_last_seen := self.dt_first_seen;
  SELF.dt_vendor_first_reported := (UNSIGNED4)(l.process_date);
  SELF.dt_vendor_last_reported  := self.dt_vendor_first_reported;

  SELF.fein := 0;
  SELF.current := TRUE;
  SELF.prim_range := L.prim_range;
  SELF.predir := L.predir;
  SELF.prim_name := L.prim_name;
  SELF.addr_suffix := L.addr_suffix;
  SELF.postdir := L.postdir;
  SELF.unit_desig := L.unit_desig;
  SELF.sec_range := L.sec_range;
  SELF.city := L.v_city_name;
  SELF.state := L.st;
  SELF.zip := (UNSIGNED3)L.zip5;
  SELF.zip4 := (UNSIGNED2)L.zip4;
  SELF.county := L.fips_county;
  SELF.msa := L.cbsa;
  SELF.geo_lat := L.geo_lat;
  SELF.geo_long := L.geo_long;
END;

//--------------------------------------------
// Normalize names
//--------------------------------------------
from_FCC_Licenses_norm := normalize(FCC_Licenses_Seq, 2, Translate_FCC_Licenses_To_BHF(LEFT, counter));

//--------------------------------------------
// Rollup on name and address
//--------------------------------------------

from_FCC_Licenses_norm_dist := DISTRIBUTE(from_FCC_Licenses_norm(company_name <> '' and 
	Datalib.CompanyClean(company_name)[41..120] <> ''), HASH(group1_id, ut.CleanCompany(company_name)));
from_FCC_Licenses_norm_sort := SORT(from_FCC_Licenses_norm_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

bh_layout RollupFCC_LicensesNorm(bh_layout L, bh_layout R) := TRANSFORM
SELF := L;
END;

from_FCC_Licenses_norm_rollup := ROLLUP(from_FCC_Licenses_norm_sort,
                              LEFT.group1_id = RIGHT.group1_id AND
							  ut.CleanCompany(LEFT.company_name) = ut.CleanCompany(RIGHT.company_name) AND
							  ((LEFT.zip = RIGHT.zip AND
							   LEFT.prim_name = RIGHT.prim_name AND
							   LEFT.prim_range = RIGHT.prim_range AND
							   LEFT.city = RIGHT.city AND
							   LEFT.state = RIGHT.state)
							  OR
							   (RIGHT.zip = 0 AND
							    RIGHT.prim_name = '' AND
								RIGHT.prim_range = '' AND
								RIGHT.city = '' AND
								RIGHT.state = '' AND
								RIGHT.city = '')
							  ),
							  RollupFCC_LicensesNorm(LEFT, RIGHT),
							  LOCAL);


// Final Rollup
bh_layout RollupFCC_Licenses(bh_layout L, bh_layout R) := TRANSFORM
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

FCC_Licenses_clean_dist := DISTRIBUTE(from_FCC_Licenses_norm_rollup,
                    HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
FCC_Licenses_clean_sort := SORT(FCC_Licenses_clean_dist, zip, prim_range, prim_name, source_group, company_name,
                    IF(sec_range <> '', 0, 1), sec_range,
                    IF(phone <> 0, 0, 1), phone,
                    IF(fein <> 0, 0, 1), fein,
                    dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
FCC_Licenses_clean_rollup := ROLLUP(FCC_Licenses_clean_sort,
			        left.zip = right.zip and
			          left.prim_name = right.prim_name and
			          left.prim_range = right.prim_range and
			          left.company_name = right.company_name and
                      left.source_group = right.source_group and
			          (right.sec_range = '' OR left.sec_range = right.sec_range) and
                      (right.phone = 0 OR left.phone = right.phone) and
			          (right.fein = 0 OR left.fein = right.fein),
                    RollupFCC_Licenses(LEFT, RIGHT),
                    LOCAL);

return FCC_Licenses_clean_rollup;

end;
