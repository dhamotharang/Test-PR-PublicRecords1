export fFL_FBN_As_Business_Header(dataset(Layout_FL_FBN_In) pInputFBN, dataset(Layout_FL_FBN_Events_In) pInputFBNEvents) :=
function
import Business_Header, ut,mdr;

	f := pInputFBN;
	fev := pInputFBNEvents;

	// Extract Filings
	Business_Header.Layout_Business_Header_New ExtractFilings(govdata.Layout_FL_FBN_In l) := transform
	self.source := MDR.sourceTools.src_FL_FBN;          // Source file type
	self.source_group := 'FL' + l.fic_fil_doc_num;
	self.vl_id := 'FL' + l.fic_fil_doc_num;
	self.vendor_id := 'FL' + l.fic_fil_doc_num;
	self.dt_first_seen := (unsigned4)l.fic_fil_date;
	self.dt_last_seen := (unsigned4)map(l.fic_fil_cancellation_date <> '' and l.fic_fil_cancellation_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_cancellation_date,
							 l.fic_fil_expiration_date <> '' and l.fic_fil_expiration_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_expiration_date,
							 Stringlib.GetDateYYYYMMDD());
	self.dt_vendor_first_reported := (unsigned4)l.fic_fil_date;
	self.dt_vendor_last_reported := (unsigned4)map(l.fic_fil_cancellation_date <> '' and l.fic_fil_cancellation_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_cancellation_date,
							 l.fic_fil_expiration_date <> '' and l.fic_fil_expiration_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_expiration_date,
							 Stringlib.GetDateYYYYMMDD());
	self.company_name := Stringlib.StringToUpperCase(l.fic_fil_name);
	self.prim_range := l.fic_fil_prim_range;
	self.predir := l.fic_fil_predir;
	self.prim_name := l.fic_fil_prim_name;
	self.addr_suffix := l.fic_fil_addr_suffix;
	self.postdir := l.fic_fil_postdir;
	self.unit_desig := l.fic_fil_unit_desig;
	self.sec_range := l.fic_fil_sec_range;
	self.city := l.fic_fil_v_city_name;
	self.state := l.fic_fil_st;
	self.zip := (unsigned3)l.fic_fil_zip;
	self.zip4 := (unsigned2)l.fic_fil_zip4;
	self.county := l.fic_fil_fips_county;
	self.msa := l.fic_fil_msa;
	self.geo_lat := l.fic_fil_geo_lat;
	self.geo_long := l.fic_fil_geo_long;
	self.phone := 0;
	self.fein := (unsigned4)l.fic_fil_fei_num;        // Federal Tax ID
	self.current := if(l.fic_fil_status = 'A', true, false);          // Current/Historical indicator
	end;

	FL_FBN_Filings := project(f, ExtractFilings(left));

	// Extract Owners
	Business_Header.Layout_Business_Header_New ExtractOwners(govdata.Layout_FL_FBN_In l, unsigned1 c) := transform
	self.source := MDR.sourceTools.src_FL_FBN;          // Source file type
	self.source_group := 'FL' + l.fic_fil_doc_num;
	self.vl_id := 'FL' + l.fic_fil_doc_num;
	self.vendor_id := 'FL' + l.fic_fil_doc_num;
	self.dt_first_seen := (unsigned4)l.fic_fil_date;
	self.dt_last_seen := (unsigned4)map(l.fic_fil_cancellation_date <> '' and l.fic_fil_cancellation_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_cancellation_date,
							 l.fic_fil_expiration_date <> '' and l.fic_fil_expiration_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_expiration_date,
							 Stringlib.GetDateYYYYMMDD());
	self.dt_vendor_first_reported := (unsigned4)l.fic_fil_date;
	self.dt_vendor_last_reported := (unsigned4)map(l.fic_fil_cancellation_date <> '' and l.fic_fil_cancellation_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_cancellation_date,
							 l.fic_fil_expiration_date <> '' and l.fic_fil_expiration_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_expiration_date,
							 Stringlib.GetDateYYYYMMDD());
	self.company_name := Stringlib.StringToUpperCase(choose(c,if(l.fic_company1 <> '', l.fic_company1, if(datalib.companyclean(l.fic_owner1_name)[41..80] <> '', l.fic_owner1_name, '')),
	  if(l.fic_company2 <> '', l.fic_company2, if(datalib.companyclean(l.fic_owner2_name)[41..80] <> '', l.fic_owner2_name, '')),
	  if(l.fic_company3 <> '', l.fic_company3, if(datalib.companyclean(l.fic_owner3_name)[41..80] <> '', l.fic_owner3_name, '')),
	  if(l.fic_company4 <> '', l.fic_company4, if(datalib.companyclean(l.fic_owner4_name)[41..80] <> '', l.fic_owner4_name, '')),
	  if(l.fic_company5 <> '', l.fic_company5, if(datalib.companyclean(l.fic_owner5_name)[41..80] <> '', l.fic_owner5_name, '')),
	  if(l.fic_company6 <> '', l.fic_company6, if(datalib.companyclean(l.fic_owner6_name)[41..80] <> '', l.fic_owner6_name, '')),
	  if(l.fic_company7 <> '', l.fic_company7, if(datalib.companyclean(l.fic_owner7_name)[41..80] <> '', l.fic_owner7_name, '')),
	  if(l.fic_company8 <> '', l.fic_company8, if(datalib.companyclean(l.fic_owner8_name)[41..80] <> '', l.fic_owner8_name, '')),
	  if(l.fic_company9 <> '', l.fic_company9, if(datalib.companyclean(l.fic_owner9_name)[41..80] <> '', l.fic_owner9_name, '')),
	  if(l.fic_company10 <> '', l.fic_company10, if(datalib.companyclean(l.fic_owner10_name)[41..80] <> '', l.fic_owner10_name, ''))));
	self.prim_range := choose(c,l.fic_owner1_prim_range,l.fic_owner2_prim_range,l.fic_owner3_prim_range,l.fic_owner4_prim_range,l.fic_owner5_prim_range,
								l.fic_owner6_prim_range,l.fic_owner7_prim_range,l.fic_owner8_prim_range,l.fic_owner9_prim_range,l.fic_owner10_prim_range);
	self.predir := choose(c,l.fic_owner1_predir,l.fic_owner2_predir,l.fic_owner3_predir,l.fic_owner4_predir,l.fic_owner5_predir,
								l.fic_owner6_predir,l.fic_owner7_predir,l.fic_owner8_predir,l.fic_owner9_predir,l.fic_owner10_predir);
	self.prim_name := choose(c,l.fic_owner1_prim_name,l.fic_owner2_prim_name,l.fic_owner3_prim_name,l.fic_owner4_prim_name,l.fic_owner5_prim_name,
								l.fic_owner6_prim_name,l.fic_owner7_prim_name,l.fic_owner8_prim_name,l.fic_owner9_prim_name,l.fic_owner10_prim_name);
	self.addr_suffix := choose(c,l.fic_owner1_addr_suffix,l.fic_owner2_addr_suffix,l.fic_owner3_addr_suffix,l.fic_owner4_addr_suffix,l.fic_owner5_addr_suffix,
								l.fic_owner6_addr_suffix,l.fic_owner7_addr_suffix,l.fic_owner8_addr_suffix,l.fic_owner9_addr_suffix,l.fic_owner10_addr_suffix);
	self.postdir := choose(c,l.fic_owner1_postdir,l.fic_owner2_postdir,l.fic_owner3_postdir,l.fic_owner4_postdir,l.fic_owner5_postdir,
								l.fic_owner6_postdir,l.fic_owner7_postdir,l.fic_owner8_postdir,l.fic_owner9_postdir,l.fic_owner10_postdir);
	self.unit_desig := choose(c,l.fic_owner1_unit_desig,l.fic_owner2_unit_desig,l.fic_owner3_unit_desig,l.fic_owner4_unit_desig,l.fic_owner5_unit_desig,
								l.fic_owner6_unit_desig,l.fic_owner7_unit_desig,l.fic_owner8_unit_desig,l.fic_owner9_unit_desig,l.fic_owner10_unit_desig);
	self.sec_range := choose(c,l.fic_owner1_sec_range,l.fic_owner2_sec_range,l.fic_owner3_sec_range,l.fic_owner4_sec_range,l.fic_owner5_sec_range,
								l.fic_owner6_sec_range,l.fic_owner7_sec_range,l.fic_owner8_sec_range,l.fic_owner9_sec_range,l.fic_owner10_sec_range);
	self.city := choose(c,l.fic_owner1_v_city_name,l.fic_owner2_v_city_name,l.fic_owner3_v_city_name,l.fic_owner4_v_city_name,l.fic_owner5_v_city_name,
								l.fic_owner6_v_city_name,l.fic_owner7_v_city_name,l.fic_owner8_v_city_name,l.fic_owner9_v_city_name,l.fic_owner10_v_city_name);
	self.state :=choose(c,l.fic_owner1_st,l.fic_owner2_st,l.fic_owner3_st,l.fic_owner4_st,l.fic_owner5_st,
								l.fic_owner6_st,l.fic_owner7_st,l.fic_owner8_st,l.fic_owner9_st,l.fic_owner10_st);
	self.zip := (unsigned3)choose(c,l.fic_owner1_zip,l.fic_owner2_zip,l.fic_owner3_zip,l.fic_owner4_zip,l.fic_owner5_zip,
								l.fic_owner6_zip,l.fic_owner7_zip,l.fic_owner8_zip,l.fic_owner9_zip,l.fic_owner10_zip);
	self.zip4 := (unsigned2)choose(c,l.fic_owner1_zip4,l.fic_owner2_zip4,l.fic_owner3_zip4,l.fic_owner4_zip4,l.fic_owner5_zip4,
								l.fic_owner6_zip4,l.fic_owner7_zip4,l.fic_owner8_zip4,l.fic_owner9_zip4,l.fic_owner10_zip4);
	self.county := choose(c,l.fic_owner1_fips_county,l.fic_owner2_fips_county,l.fic_owner3_fips_county,l.fic_owner4_fips_county,l.fic_owner5_fips_county,
								l.fic_owner6_fips_county,l.fic_owner7_fips_county,l.fic_owner8_fips_county,l.fic_owner9_fips_county,l.fic_owner10_fips_county);
	self.msa := choose(c,l.fic_owner1_msa,l.fic_owner2_msa,l.fic_owner3_msa,l.fic_owner4_msa,l.fic_owner5_msa,
								l.fic_owner6_msa,l.fic_owner7_msa,l.fic_owner8_msa,l.fic_owner9_msa,l.fic_owner10_msa);
	self.geo_lat := choose(c,l.fic_owner1_geo_lat,l.fic_owner2_geo_lat,l.fic_owner3_geo_lat,l.fic_owner4_geo_lat,l.fic_owner5_geo_lat,
								l.fic_owner6_geo_lat,l.fic_owner7_geo_lat,l.fic_owner8_geo_lat,l.fic_owner9_geo_lat,l.fic_owner10_geo_lat);
	self.geo_long := choose(c,l.fic_owner1_geo_long,l.fic_owner2_geo_long,l.fic_owner3_geo_long,l.fic_owner4_geo_long,l.fic_owner5_geo_long,
								l.fic_owner6_geo_long,l.fic_owner7_geo_long,l.fic_owner8_geo_long,l.fic_owner9_geo_long,l.fic_owner10_geo_long);
	self.phone := 0;
	self.fein := (unsigned4)choose(c,l.fic_owner1_fei_num,l.fic_owner2_fei_num,l.fic_owner3_fei_num,l.fic_owner4_fei_num,l.fic_owner5_fei_num,
								l.fic_owner6_fei_num,l.fic_owner7_fei_num,l.fic_owner8_fei_num,l.fic_owner9_fei_num,l.fic_owner10_fei_num);
	self.current := if(l.fic_fil_status = 'A', true, false);          // Current/Historical indicator
	end;

	FL_FBN_Owners_Norm := normalize(f, 10, ExtractOwners(left, counter));

	FL_FBN_Owners := FL_FBN_Owners_Norm(company_name <> '');

	// Extract Change Filer Address Event Information
	Business_Header.Layout_Business_Header_New ExtractAddressChange(govdata.Layout_FL_FBN_Events_In l, unsigned1 c) := transform
	self.source := MDR.sourceTools.src_FL_FBN;          // Source file type
	self.source_group := 'FL' + l.event_orig_doc_number;
	self.vl_id := 'FL' + l.event_orig_doc_number;
	self.vendor_id := 'FL' + l.event_orig_doc_number;
	self.dt_first_seen := (unsigned4)l.event_date;
	self.dt_last_seen := (unsigned4)l.event_date;
	self.dt_vendor_first_reported := (unsigned4)l.event_date;
	self.dt_vendor_last_reported := (unsigned4)l.event_date;
	self.company_name := Stringlib.StringToUpperCase(l.event_fic_name);
	self.prim_range := choose(c,l.old_prim_range,l.new_prim_range);
	self.predir := choose(c,l.old_predir,l.new_predir);
	self.prim_name := choose(c,l.old_prim_name,l.new_prim_name);
	self.addr_suffix := choose(c,l.old_addr_suffix,l.new_addr_suffix);
	self.postdir := choose(c,l.old_postdir,l.new_postdir);
	self.unit_desig := choose(c,l.old_unit_desig,l.new_unit_desig);
	self.sec_range := choose(c,l.old_sec_range,l.new_sec_range);
	self.city := choose(c,l.old_v_city_name,l.new_v_city_name);
	self.state := choose(c,l.old_st,l.new_st);
	self.zip := (unsigned3)choose(c,l.old_zip,l.new_zip);
	self.zip4 := (unsigned2)choose(c,l.old_zip4,l.new_zip4);
	self.county := choose(c,l.old_fipscounty,l.new_fipscounty);
	self.msa := choose(c,l.old_msa,l.new_msa);
	self.geo_lat := choose(c,l.old_geo_lat,l.new_geo_lat);
	self.geo_long := choose(c,l.old_geo_long,l.new_geo_long);
	self.phone := 0;
	self.fein := (unsigned4)choose(c,l.action_old_fei,l.action_new_fei);        // Federal Tax ID
	self.current := true;          // Current/Historical indicator
	end;

	FL_FBN_Event_CHF := normalize(fev(action_code = 'CHF'), 2, ExtractAddressChange(left,counter));

	// Extract Change Owner Event Information
	Business_Header.Layout_Business_Header_New ExtractOwnerChange(govdata.Layout_FL_FBN_Events_In l) := transform
	self.source := MDR.sourceTools.src_FL_FBN;          // Source file type
	self.source_group := 'FL' + l.event_orig_doc_number;
	self.vl_id := 'FL' + l.event_orig_doc_number;
	self.vendor_id := 'FL' + l.event_orig_doc_number;
	self.dt_first_seen := (unsigned4)l.event_date;
	self.dt_last_seen := (unsigned4)l.event_date;
	self.dt_vendor_first_reported := (unsigned4)l.event_date;
	self.dt_vendor_last_reported := (unsigned4)l.event_date;
	self.company_name := Stringlib.StringToUpperCase(if(l.own_name_company <> '', l.own_name_company, if(datalib.companyclean(l.action_own_name)[41..80] <> '', l.action_own_name, '')));
	self.prim_range := l.own_prim_range;
	self.predir := l.own_predir;
	self.prim_name := l.own_prim_name;
	self.addr_suffix := l.own_addr_suffix;
	self.postdir := l.own_postdir;
	self.unit_desig := l.own_unit_desig;
	self.sec_range := l.own_sec_range;
	self.city := l.own_v_city_name;
	self.state := l.own_st;
	self.zip := (unsigned3)l.own_zip;
	self.zip4 := (unsigned2)l.own_zip4;
	self.county := l.own_fipscounty;
	self.msa := l.own_msa;
	self.geo_lat := l.own_geo_lat;
	self.geo_long := l.own_geo_long;
	self.phone := 0;
	self.fein := (unsigned4)l.action_own_fei;        // Federal Tax ID
	self.current := true;          // Current/Historical indicator
	end;

	FL_FBN_Event_CHO_Init := project(fev(action_code = 'CHO'), ExtractOwnerChange(left));

	FL_FBN_Event_CHO := FL_FBN_Event_CHO_Init(company_name <> '');

	FL_FBN_Combined := FL_FBN_Filings + FL_FBN_Owners + FL_FBN_Event_CHF + FL_FBN_Event_CHO;

	// Rollup
	Business_Header.Layout_Business_Header_New RollupFLFBN(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSFORM
	SELF.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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

	FL_FBN_Combined_Dist := DISTRIBUTE(FL_FBN_Combined(company_name <> '', NOT (prim_name='' AND city='' AND state='' AND zip=0)),
						HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	FL_FBN_Combined_Sort := SORT(FL_FBN_Combined_Dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	FL_FBN_Combined_Rollup := ROLLUP(FL_FBN_Combined_Sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						RollupFLFBN(LEFT, RIGHT),
						LOCAL);

	return FL_FBN_Combined_Rollup;

end;