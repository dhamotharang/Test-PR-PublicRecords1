import STRATA;
pTransunion_TN_base:=Files.Base;

rPopulationStats_Transunion_TN_base
 :=
  record
	CountGroup									:= count(group);
	record_type_CountNonBlank := sum(group,if(pTransunion_TN_base.record_type<>'',1,0));
	first_name_CountNonBlank := sum(group,if(pTransunion_TN_base.first_name<>'',1,0));
	middle_name_CountNonBlank := sum(group,if(pTransunion_TN_base.middle_name<>'',1,0));
	last_name_CountNonBlank := sum(group,if(pTransunion_TN_base.last_name<>'',1,0));
	name_prefix_CountNonBlank := sum(group,if(pTransunion_TN_base.name_prefix<>'',1,0));
	name_suffix__CountNonBlank := sum(group,if(pTransunion_TN_base.name_suffix_<>'',1,0));
	perm_id_CountNonBlank := sum(group,if(pTransunion_TN_base.perm_id<>'',1,0));
	ssn_CountNonBlank := sum(group,if(pTransunion_TN_base.ssn<>'',1,0));
	aka1_CountNonBlank := sum(group,if(pTransunion_TN_base.aka1<>'',1,0));
	aka2_CountNonBlank := sum(group,if(pTransunion_TN_base.aka2<>'',1,0));
	aka3_CountNonBlank := sum(group,if(pTransunion_TN_base.aka3<>'',1,0));
	new_subject_flag_CountNonBlank := sum(group,if(pTransunion_TN_base.new_subject_flag<>'',1,0));
	name_change_flag_CountNonBlank := sum(group,if(pTransunion_TN_base.name_change_flag<>'',1,0));
	address_change_flag_CountNonBlank := sum(group,if(pTransunion_TN_base.address_change_flag<>'',1,0));
	ssn_change_flag_CountNonBlank := sum(group,if(pTransunion_TN_base.ssn_change_flag<>'',1,0));
	file_since_date_change_flag_CountNonBlank := sum(group,if(pTransunion_TN_base.file_since_date_change_flag<>'',1,0));
	deceased_indicator_flag_CountNonBlank := sum(group,if(pTransunion_TN_base.deceased_indicator_flag<>'',1,0));
	dob_change_flag_CountNonBlank := sum(group,if(pTransunion_TN_base.dob_change_flag<>'',1,0));
	phone_change_flag_CountNonBlank := sum(group,if(pTransunion_TN_base.phone_change_flag<>'',1,0));
	filler2_CountNonBlank := sum(group,if(pTransunion_TN_base.filler2<>'',1,0));
	file_since_date_CountNonBlank := sum(group,if(pTransunion_TN_base.file_since_date<>'',1,0));
	house_number_CountNonBlank := sum(group,if(pTransunion_TN_base.house_number<>'',1,0));
	street_direction_CountNonBlank := sum(group,if(pTransunion_TN_base.street_direction<>'',1,0));
	street_name_CountNonBlank := sum(group,if(pTransunion_TN_base.street_name<>'',1,0));
	street_type_CountNonBlank := sum(group,if(pTransunion_TN_base.street_type<>'',1,0));
	street_post_direction_CountNonBlank := sum(group,if(pTransunion_TN_base.street_post_direction<>'',1,0));
	unit_type_CountNonBlank := sum(group,if(pTransunion_TN_base.unit_type<>'',1,0));
	unit_number_CountNonBlank := sum(group,if(pTransunion_TN_base.unit_number<>'',1,0));
	cty_CountNonBlank := sum(group,if(pTransunion_TN_base.cty<>'',1,0));
	state_CountNonBlank := sum(group,if(pTransunion_TN_base.state<>'',1,0));
	pTransunion_TN_base.state;
	zip_code_CountNonBlank := sum(group,if(pTransunion_TN_base.zip_code<>'',1,0));
	zp4_CountNonBlank := sum(group,if(pTransunion_TN_base.zp4<>'',1,0));
	address_standardization_indicator_CountNonBlank := sum(group,if(pTransunion_TN_base.address_standardization_indicator<>'',1,0));
	date_address_reported_CountNonBlank := sum(group,if(pTransunion_TN_base.date_address_reported<>'',1,0));
	party_id_CountNonBlank := sum(group,if(pTransunion_TN_base.party_id<>'',1,0));
	deceased_indicator_CountNonBlank := sum(group,if(pTransunion_TN_base.deceased_indicator<>'',1,0));
	date_of_birth_CountNonBlank := sum(group,if(pTransunion_TN_base.date_of_birth<>'',1,0));
	date_of_birth_estimated_ind_CountNonBlank := sum(group,if(pTransunion_TN_base.date_of_birth_estimated_ind<>'',1,0));
	phone_CountNonBlank := sum(group,if(pTransunion_TN_base.phone<>'',1,0));
	filler3_CountNonBlank := sum(group,if(pTransunion_TN_base.filler3<>'',1,0));
	prepped_name_CountNonBlank := sum(group,if(pTransunion_TN_base.prepped_name<>'',1,0));
	prepped_addr1_CountNonBlank := sum(group,if(pTransunion_TN_base.prepped_addr1<>'',1,0));
	prepped_addr2_CountNonBlank := sum(group,if(pTransunion_TN_base.prepped_addr2<>'',1,0));
	prepped_rec_type_CountNonBlank := sum(group,if(pTransunion_TN_base.prepped_rec_type<>'',1,0));
	isupdating_CountNonBlank := sum(group,if(pTransunion_TN_base.isupdating=true,1,0));
	iscurrent_CountNonBlank := sum(group,if(pTransunion_TN_base.iscurrent=true,1,0));
	did_CountNonBlank := sum(group,if(pTransunion_TN_base.did>0,1,0));
	did_score_CountNonBlank := sum(group,if(pTransunion_TN_base.did_score>0,1,0));
	dt_first_seen_CountNonBlank := sum(group,if(pTransunion_TN_base.dt_first_seen>0,1,0));
	dt_last_seen_CountNonBlank := sum(group,if(pTransunion_TN_base.dt_last_seen>0,1,0));
	dt_vendor_last_reported_CountNonBlank := sum(group,if(pTransunion_TN_base.dt_vendor_last_reported>0,1,0));
	dt_vendor_first_reported_CountNonBlank := sum(group,if(pTransunion_TN_base.dt_vendor_first_reported>0,1,0));
	clean_phone_CountNonBlank := sum(group,if(pTransunion_TN_base.clean_phone<>'',1,0));
	clean_ssn_CountNonBlank := sum(group,if(pTransunion_TN_base.clean_ssn<>'',1,0));
	clean_dob_CountNonBlank := sum(group,if(pTransunion_TN_base.clean_dob>0,1,0));
	title_CountNonBlank := sum(group,if(pTransunion_TN_base.title<>'',1,0));
	fname_CountNonBlank := sum(group,if(pTransunion_TN_base.fname<>'',1,0));
	mname_CountNonBlank := sum(group,if(pTransunion_TN_base.mname<>'',1,0));
	lname_CountNonBlank := sum(group,if(pTransunion_TN_base.lname<>'',1,0));
	name_suffix_CountNonBlank := sum(group,if(pTransunion_TN_base.name_suffix<>'',1,0));
	name_score_CountNonBlank := sum(group,if(pTransunion_TN_base.name_score<>'',1,0));
	prim_range_CountNonBlank := sum(group,if(pTransunion_TN_base.prim_range<>'',1,0));
	predir_CountNonBlank := sum(group,if(pTransunion_TN_base.predir<>'',1,0));
	prim_name_CountNonBlank := sum(group,if(pTransunion_TN_base.prim_name<>'',1,0));
	addr_suffix_CountNonBlank := sum(group,if(pTransunion_TN_base.addr_suffix<>'',1,0));
	postdir_CountNonBlank := sum(group,if(pTransunion_TN_base.postdir<>'',1,0));
	unit_desig_CountNonBlank := sum(group,if(pTransunion_TN_base.unit_desig<>'',1,0));
	sec_range_CountNonBlank := sum(group,if(pTransunion_TN_base.sec_range<>'',1,0));
	p_city_name_CountNonBlank := sum(group,if(pTransunion_TN_base.p_city_name<>'',1,0));
	v_city_name_CountNonBlank := sum(group,if(pTransunion_TN_base.v_city_name<>'',1,0));
	st_CountNonBlank := sum(group,if(pTransunion_TN_base.st<>'',1,0));
	zip_CountNonBlank := sum(group,if(pTransunion_TN_base.zip<>'',1,0));
	zip4_CountNonBlank := sum(group,if(pTransunion_TN_base.zip4<>'',1,0));
	cart_CountNonBlank := sum(group,if(pTransunion_TN_base.cart<>'',1,0));
	cr_sort_sz_CountNonBlank := sum(group,if(pTransunion_TN_base.cr_sort_sz<>'',1,0));
	lot_CountNonBlank := sum(group,if(pTransunion_TN_base.lot<>'',1,0));
	lot_order_CountNonBlank := sum(group,if(pTransunion_TN_base.lot_order<>'',1,0));
	dbpc_CountNonBlank := sum(group,if(pTransunion_TN_base.dbpc<>'',1,0));
	chk_digit_CountNonBlank := sum(group,if(pTransunion_TN_base.chk_digit<>'',1,0));
	rec_type_CountNonBlank := sum(group,if(pTransunion_TN_base.rec_type<>'',1,0));
	fips_county_CountNonBlank := sum(group,if(pTransunion_TN_base.fips_county<>'',1,0));
	county_CountNonBlank := sum(group,if(pTransunion_TN_base.county<>'',1,0));
	geo_lat_CountNonBlank := sum(group,if(pTransunion_TN_base.geo_lat<>'',1,0));
	geo_long_CountNonBlank := sum(group,if(pTransunion_TN_base.geo_long<>'',1,0));
	msa_CountNonBlank := sum(group,if(pTransunion_TN_base.msa<>'',1,0));
	geo_blk_CountNonBlank := sum(group,if(pTransunion_TN_base.geo_blk<>'',1,0));
	geo_match_CountNonBlank := sum(group,if(pTransunion_TN_base.geo_match<>'',1,0));
	err_stat_CountNonBlank := sum(group,if(pTransunion_TN_base.err_stat<>'',1,0));
	rawaid_CountNonBlank := sum(group,if(pTransunion_TN_base.rawaid>0,1,0));
 end;

dPopulationStats_Transunion_TN_base := table(pTransunion_TN_base
							  	    ,rPopulationStats_Transunion_TN_base
									,state
									,few);

CreateXMLstatus(string ver) := function
						
	STRATA.createXMLStats(dPopulationStats_Transunion_TN_base
						 ,'TN'
						 ,'TransunionCred'
						 ,ver
						 ,'jose.bello@lexisnexis.com,michael.gould@lexisnexis.com'
						 ,zTransunion_TN_base);
	return zTransunion_TN_base;

end;

EXPORT Strata(string ver) := CreateXMLstatus(ver);