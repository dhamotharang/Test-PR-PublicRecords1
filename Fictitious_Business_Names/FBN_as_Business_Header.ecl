IMPORT Business_Header, ut;

//*************************************************************************
// Translate FBN file to Common Business Header Format
//*************************************************************************

FBN_base := Fictitious_Business_Names.Cleaned_File;

Layout_FBN_Local := RECORD
UNSIGNED6 record_id := 0;
Fictitious_Business_Names.Layout_Cleaned_File;
END;

//--------------------------------------------
// Add unique record id to fbn file
//--------------------------------------------
Layout_FBN_Local AddRecordID(FBN_base L) := TRANSFORM
SELF := L;
END;

fbn_Init := PROJECT(FBN_base, AddRecordID(LEFT));

//ut.MAC_Sequence_Records(fbn_Init, record_id, fbn_Seq);

bh_layout := business_header.Layout_Business_Header;

bh_layout Translate_fbn_To_BHF(Layout_fbn_Local L) := transform
  SELF.group1_id := L.record_id;
  SELF.vendor_id := L.infousa_fbn_key;
  SELF.phone := (UNSIGNED6)((UNSIGNED8)l.BusinessTelephone_clean);
  SELF.phone_score := IF((UNSIGNED8)l.BusinessTelephone_clean = 0, 0, 1);
  SELF.source := 'IF';
  SELF.source_group := '';
  SELF.company_name := L.businessName;
  SELF.dt_first_seen := map(L.filingdate <> ''=> (UNSIGNED4)L.filingdate, 
														L.date_last_updated >'200308' => (UNSIGNED4)L.date_last_updated,
														0);
  SELF.dt_last_seen := map(L.date_last_updated >'200308' => (UNSIGNED4)L.date_last_updated,
												   L.filingdate <> ''=> (UNSIGNED4)L.filingdate,
														0);
	
  SELF.dt_vendor_first_reported := (UNSIGNED4)L.date_first_updated_app;
  SELF.dt_vendor_last_reported := (UNSIGNED4)L.date_last_updated_app;
  SELF.fein := 0;
  SELF.current := TRUE;
	self.prim_range										:= l.Business_Address_Clean_prim_range;
	self.predir											  := l.Business_Address_Clean_predir;
	self.prim_name										:= l.Business_Address_Clean_prim_name;
	self.addr_suffix									:= l.Business_Address_Clean_addr_suffix;
	self.postdir										  := l.Business_Address_Clean_postdir;
	self.unit_desig										:= l.Business_Address_Clean_unit_desig;
	self.sec_range										:= l.Business_Address_Clean_sec_range;
	self.city											    := l.Business_Address_Clean_p_city_name;
	self.state										  	:= l.Business_Address_Clean_st;
	self.zip 											    := (unsigned3)l.Business_Address_Clean_zip;
	self.zip4											    := (unsigned2)l.Business_Address_Clean_zip4;
	self.county										  	:= l.Business_Address_Clean_fipscounty;
	self.msa										    	:= l.Business_Address_Clean_msa;
	self.geo_lat									  	:= l.Business_Address_Clean_geo_lat;
	self.geo_long										  := l.Business_Address_Clean_geo_long;

 
END;
file_fbn := Project(fbn_Init,Translate_fbn_To_BHF(left));


///##################################################3
//--------------------------------------------
// Rollup on name and address
//--------------------------------------------

file_fbn_dist := DISTRIBUTE(file_fbn, HASH(group1_id, ut.CleanCompany(company_name)));
file_fbn_sort := SORT(file_fbn_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

bh_layout RollupfbnNorm(bh_layout L, bh_layout R) := TRANSFORM
SELF := L;
END;

file_fbn_rollup := ROLLUP(file_fbn_sort,
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
							  RollupfbnNorm(LEFT, RIGHT),
							  LOCAL);


// Final Rollup
bh_layout Rollupfbn(bh_layout L, bh_layout R) := TRANSFORM
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

fbn_clean_dist := DISTRIBUTE(file_fbn_rollup,
                    HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
fbn_clean_sort := SORT(fbn_clean_dist, zip, prim_range, prim_name, source_group, company_name,
                    IF(sec_range <> '', 0, 1), sec_range,
                    IF(phone <> 0, 0, 1), phone,
                    IF(fein <> 0, 0, 1), fein,
                    dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
fbn_clean_rollup := ROLLUP(fbn_clean_sort,
			        left.zip = right.zip and
			          left.prim_name = right.prim_name and
			          left.prim_range = right.prim_range and
			          left.company_name = right.company_name and
                      left.source_group = right.source_group and
			          (right.sec_range = '' OR left.sec_range = right.sec_range) and
                      (right.phone = 0 OR left.phone = right.phone) and
			          (right.fein = 0 OR left.fein = right.fein),
                    Rollupfbn(LEFT, RIGHT),
                    LOCAL) : PERSIST('TEMP::Infousa_fbn_Company_Rollup');

EXPORT FBN_as_Business_Header := fbn_clean_rollup;

