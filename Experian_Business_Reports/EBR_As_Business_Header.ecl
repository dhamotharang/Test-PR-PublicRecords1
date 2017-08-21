#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut;

//*************************************************************************
// Translate Experian_Business_Reports file to Common Business Header Format
//*************************************************************************
string8 fixdate(string8 mmddyydate) :=
MAP(
mmddyydate = '' => '',
(integer)(mmddyydate[7..8]) > (integer)(stringlib.GetDateYYYYMMDD()[3..4]) => 
		'19' + mmddyydate[7..8] + mmddyydate[1..2] + mmddyydate[4..5],
		'20' + mmddyydate[7..8] + mmddyydate[1..2] + mmddyydate[4..5]);

string6 fixmmyydate(string4 mmyydate) :=
MAP(
mmyydate = '' => '',
(integer)(mmyydate[3..4]) > (integer)(stringlib.GetDateYYYYMMDD()[3..4]) => 
		'19' + mmyydate[3..4] + mmyydate[1..2],
		'20' + mmyydate[3..4] + mmyydate[1..2]);





Experian_Business_Reports_base := Experian_Business_Reports.File_Header_Records_In;

Layout_Experian_Business_Reports_Local := RECORD
UNSIGNED6 record_id := 0;
Experian_Business_Reports.Layout_Header_Records_In;
END;

//--------------------------------------------
// Add unique record id to Experian_Business_Reports file
//--------------------------------------------
Layout_Experian_Business_Reports_Local AddRecordID(Layout_Header_Records_In L) := TRANSFORM
SELF := L;
END;

Experian_Business_Reports_Init := PROJECT(Experian_Business_Reports_base, AddRecordID(LEFT));

ut.MAC_Sequence_Records(Experian_Business_Reports_Init, record_id, Experian_Business_Reports_Seq);

bh_layout := business_header.Layout_Business_Header;

bh_layout Translate_Experian_Business_Reports_To_BHF(Layout_Experian_Business_Reports_Local L) := transform
  SELF.group1_id := L.record_id;
  SELF.vendor_id := L.FILE_NUMBER;
  SELF.phone := (UNSIGNED6)((UNSIGNED8)L.PHONE_NUMBER);
  SELF.phone_score := IF((UNSIGNED8)L.PHONE_NUMBER = 0, 0, 1);
  SELF.source := 'EB';
  SELF.source_group := L.FILE_NUMBER;
  SELF.company_name := L.COMPANY_NAME;
  SELF.dt_first_seen := if(L.FILE_ESTAB_DATE_MMYY <> '' and 
		(integer)(fixmmyydate(L.FILE_ESTAB_DATE_MMYY)) <= (integer)(stringlib.GetDateYYYYMMDD()[1..6]), 
			(UNSIGNED4)(fixmmyydate(L.FILE_ESTAB_DATE_MMYY) + '01'),
			if(L.EXTRACT_DATE_MDY <> '' and 
				(integer)(fixdate(L.EXTRACT_DATE_MDY)) <= (integer)(stringlib.GetDateYYYYMMDD()),
					(UNSIGNED4)(fixdate(L.EXTRACT_DATE_MDY)),
			0));
  SELF.dt_last_seen := self.dt_first_seen;
  SELF.dt_vendor_first_reported := if(L.EXTRACT_DATE_MDY <> '' and 
				(integer)(fixdate(L.EXTRACT_DATE_MDY)) <= (integer)(stringlib.GetDateYYYYMMDD()),
					(UNSIGNED4)(fixdate(L.EXTRACT_DATE_MDY)),
			0);
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
  SELF.city := L.p_city_name;
  SELF.state := L.st;
  SELF.zip := (UNSIGNED3)L.zip5;
  SELF.zip4 := (UNSIGNED2)L.zip4;
  SELF.county := L.county;
  SELF.msa := L.msa;
  SELF.geo_lat := L.geo_lat;
  SELF.geo_long := L.geo_long;
END;

//--------------------------------------------
// Normalize names
//--------------------------------------------
from_Experian_Business_Reports_norm := project(Experian_Business_Reports_Seq, Translate_Experian_Business_Reports_To_BHF(LEFT));

//--------------------------------------------
// Rollup on name and address
//--------------------------------------------

from_Experian_Business_Reports_norm_dist := DISTRIBUTE(from_Experian_Business_Reports_norm, HASH(group1_id, ut.CleanCompany(company_name)));
from_Experian_Business_Reports_norm_sort := SORT(from_Experian_Business_Reports_norm_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

bh_layout RollupExperian_Business_ReportsNorm(bh_layout L, bh_layout R) := TRANSFORM
SELF := L;
END;

from_Experian_Business_Reports_norm_rollup := ROLLUP(from_Experian_Business_Reports_norm_sort,
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
							  RollupExperian_Business_ReportsNorm(LEFT, RIGHT),
							  LOCAL);


// Final Rollup
bh_layout RollupExperian_Business_Reports(bh_layout L, bh_layout R) := TRANSFORM
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

Experian_Business_Reports_clean_dist := DISTRIBUTE(from_Experian_Business_Reports_norm_rollup,
                    HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
Experian_Business_Reports_clean_sort := SORT(Experian_Business_Reports_clean_dist, zip, prim_range, prim_name, source_group, company_name,
                    IF(sec_range <> '', 0, 1), sec_range,
                    IF(phone <> 0, 0, 1), phone,
                    IF(fein <> 0, 0, 1), fein,
                    dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
Experian_Business_Reports_clean_rollup := ROLLUP(Experian_Business_Reports_clean_sort,
			        left.zip = right.zip and
			          left.prim_name = right.prim_name and
			          left.prim_range = right.prim_range and
			          left.company_name = right.company_name and
                      left.source_group = right.source_group and
			          (right.sec_range = '' OR left.sec_range = right.sec_range) and
                      (right.phone = 0 OR left.phone = right.phone) and
			          (right.fein = 0 OR left.fein = right.fein),
                    RollupExperian_Business_Reports(LEFT, RIGHT),
                    LOCAL) : PERSIST('TEMP::Experian_Business_Reports_Company_Rollup');

EXPORT EBR_As_Business_Header := Experian_Business_Reports_clean_rollup;