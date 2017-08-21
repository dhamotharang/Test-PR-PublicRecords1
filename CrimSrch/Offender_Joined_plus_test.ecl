import crim_header;
unsigned4 rnd_sample_size := 500;
unsigned2 min_sample_size := 5;

ch:=crim_header.file_crim_header;
//ch_dids := crim_header.ch_as_did_append;
//
old := crimsrch.Offender_Joined;
new := crimsrch.Offender_Joined_plus;
//new := crimsrch.File_Moxie_Offender_Dev;

my_layout := record
unsigned6		hval;
crimsrch.layout_moxie_offender;
end;

my_layout to_hash(crimsrch.Layout_Moxie_Offender l) := transform
self.hval := hash(
	l.did+
  l.date_first_reported+
	l.date_last_reported+
	l.offender_key+
	l.vendor+
	l.state_of_origin+
	l.data_type+
	l.source_file+
	l.off_name_type+
	l.off_name+
	l.orig_lname+
	l.orig_fname+
	l.orig_mname+
	l.orig_name_suffix+
	l.place_of_birth+
	l.dob+
	l.dob_alias+
	l.orig_ssn+
	l.offender_id_num_1+
	l.offender_id_num_type_1+
	l.offender_id_num_2+
	l.offender_id_num_type_2+
	l.sor_date_1+
	l.sor_date_type_1+
	l.sor_date_2+
	l.sor_date_type_2+
	l.sor_date_3+
	l.sor_date_type_3+
	l.sor_status+
	l.sor_offender_category+
	l.sor_risk_level_code+
	l.sor_risk_level_desc+
	l.sor_registration_type+
	l.offender_status+
	l.offender_address_1+
	l.offender_address_2+
	l.offender_address_3+
	l.offender_address_4+
	l.offender_address_5+
	l.case_number+
	l.case_court+
	l.case_name+
	l.case_type+
	l.case_type_desc+
	l.case_filing_date+
	l.race_desc+
	l.sex+
	l.hair_color_desc+
	l.eye_color_desc+
	l.skin_color_desc+
	l.height+
	l.weight+
	l.ethnicity+
	l.age+
	l.build_type+
	l.scars_marks_tattoos+
	l.fcra_conviction_flag+
	l.fcra_traffic_flag+
	l.fcra_date+
	l.fcra_date_type+
	l.conviction_override_date+
	l.conviction_override_date_type+
	l.offense_score+
	l.prim_range+
	l.predir+
	l.prim_name+
	l.addr_suffix+
	l.postdir+
	l.unit_desig+
	l.sec_range+
	l.p_city_name+
	l.v_city_name+
	l.state+
	l.zip5+
	l.zip4+
	l.cart+
	l.cr_sort_sz+
	l.lot+
	l.lot_order+
	l.dpbc+
	l.chk_digit+
	l.rec_type+
	l.ace_fips_st+
	l.ace_fips_county+
	l.geo_lat+
	l.geo_long+
	l.msa+
	l.geo_blk+
	l.geo_match+
	l.err_stat+
	l.title+
	l.fname+
	l.mname+
	l.lname+
	l.name_suffix+
	l.cleaning_score+
	l.ssn);
self := l;
end;
	
ds_new := project(new,to_hash(left));
ds_old := project(old,to_hash(left));

crimsrch.Layout_Moxie_Offender to_ltest(ds_new l, ds_old r) := transform
self := l;
end;
//
diff_recs := join(distribute(ds_new,hval),distribute(ds_old,hval),left.hval=right.hval,to_ltest(left,right),left only, local);
//
count_old := count(ds_old);
s1:=output(count_old,named('Total_original_records'));
count_new := count(ds_new);
s2:=output(count_new,named('Total_after_append_records'));
count_diff := count(diff_recs);
s3:=output(count_diff,named('Total_changed_records'));
//
ts_record := record
string2 vendor := diff_recs.vendor;
string20 source_file := diff_recs.source_file;
integer	ttl_records := count(group);
end;
ts := table(diff_recs,ts_record,vendor,source_file,few);
dist_by_vendor := sort(ts,-ttl_records);
s4:=output(dist_by_vendor,all,named('Vendor_distribution'));
//
layout_slim_diffs := record
	string2		vendor;
	string20	source_file;
	string1		data_type;
    unsigned6 	cdl;
	string60	offender_key;
  string12		did;
end;
layout_slim_diffs to_slim_cdl(diff_recs l,ch r) := transform
self.cdl := r.cdl;
self := l;
end;
//
slim_diff_recs_j := join(distribute(diff_recs,hash(offender_key)),distribute(ch,hash(offender_key)),left.offender_key=right.offender_key,to_slim_cdl(left,right),local,keep(1));
slim_diff_recs   := dedup(sort(distribute(slim_diff_recs_j,hash(cdl)),cdl,source_file,offender_key,did,local),cdl,source_file,offender_key,did,local);

rnd_diff_recs := enth(distribute(slim_diff_recs,hash(offender_key)),rnd_sample_size);
//
grouped_diff_recs := group(sort(distribute(slim_diff_recs,hash(source_file)),source_file,local),source_file,local);
min_diff_recs := dedup(grouped_diff_recs,source_file,keep min_sample_size);
//
s5:=output(count(rnd_diff_recs),named('Total_random_sample_records'));
s6:=output(count(min_diff_recs),named('Total_minimum_sample_records'));
s7:=output(dedup(sort(distribute(rnd_diff_recs+min_diff_recs,hash(vendor)),vendor,cdl,offender_key,did,local),vendor,cdl,offender_key,did,local),all,named('Test_records'));
//
export offender_joined_plus_test := sequential(s1,s2,s3,s4,s5,s6,s7);
