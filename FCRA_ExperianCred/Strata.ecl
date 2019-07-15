import STRATA;
pFCRA_ExperianCred_EN_base:=Files.Base;

rPopulationStats_FCRA_ExperianCred_EN_base
 :=
  record
	CountGroup									:= count(group);
	prepped_rec_type_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.prepped_rec_type<>'',1,0));
	isupdating_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.isupdating=true,1,0));
	iscurrent_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.iscurrent=true,1,0));
	isdelete_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.isdelete=true,1,0));
	did_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.did>0,1,0));
	did_score_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.did_score>0,1,0));
	title_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.title<>'',1,0));
	fname_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.fname<>'',1,0));
	mname_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.mname<>'',1,0));
	lname_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.lname<>'',1,0));
	name_suffix_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.name_suffix<>'',1,0));
	dt_first_seen_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.dt_first_seen>0,1,0));
	dt_last_seen_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.dt_last_seen>0,1,0));
	prepped_addr1_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.prepped_addr1<>'',1,0));
	prepped_addr2_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.prepped_addr2<>'',1,0));
	dt_vendor_first_reported_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.dt_vendor_first_reported>0,1,0));
	dt_vendor_last_reported_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.dt_vendor_last_reported>0,1,0));
	phone_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.phone<>'',1,0));
	ssn_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.ssn<>'',1,0));
	dob_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.dob>0,1,0));
	prim_range_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.prim_range<>'',1,0));
	predir_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.predir<>'',1,0));
	prim_name_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.prim_name<>'',1,0));
	addr_suffix_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.addr_suffix<>'',1,0));
	postdir_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.postdir<>'',1,0));
	unit_desig_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.unit_desig<>'',1,0));
	sec_range_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.sec_range<>'',1,0));
	p_city_name_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.p_city_name<>'',1,0));
	v_city_name_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.v_city_name<>'',1,0));
	pFCRA_ExperianCred_EN_base.st;
	zip_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.zip<>'',1,0));
	zip4_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.zip4<>'',1,0));
	cart_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.cart<>'',1,0));
	cr_sort_sz_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.cr_sort_sz<>'',1,0));
	lot_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.lot<>'',1,0));
	lot_order_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.lot_order<>'',1,0));
	dbpc_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.dbpc<>'',1,0));
	chk_digit_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.chk_digit<>'',1,0));
	rec_type_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.rec_type<>'',1,0));
	fips_st_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.fips_st<>'',1,0));
	fips_county_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.fips_county<>'',1,0));
	geo_lat_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.geo_lat<>'',1,0));
	geo_long_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.geo_long<>'',1,0));
	msa_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.msa<>'',1,0));
	geo_blk_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.geo_blk<>'',1,0));
	geo_match_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.geo_match<>'',1,0));
	err_stat_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.err_stat<>'',1,0));
	rawaid_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.rawaid>0,1,0));
	nid_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.nid>0,1,0));
	orig_fname_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_fname<>'',1,0));
	orig_mname_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_mname<>'',1,0));
	orig_lname_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_lname<>'',1,0));
	orig_name_suffix_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_name_suffix<>'',1,0));
	orig_crdt_ccyymmdd_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_crdt_ccyymmdd<>'',1,0));
	orig_updt_ccyymmdd_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_updt_ccyymmdd<>'',1,0));
	orig_prim_range_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_prim_range<>'',1,0));
	orig_predir_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_predir<>'',1,0));
	orig_prim_name_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_prim_name<>'',1,0));
	orig_addr_suffix_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_addr_suffix<>'',1,0));
	orig_postdir_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_postdir<>'',1,0));
	orig_unit_desig_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_unit_desig<>'',1,0));
	orig_sec_range_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_sec_range<>'',1,0));
	orig_city_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_city<>'',1,0));
	orig_st_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_st<>'',1,0));
	orig_zip_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_zip<>'',1,0));
	orig_zip4_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_zip4<>'',1,0));
	orig_ssn_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_ssn<>'',1,0));
	orig_dob_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_dob<>'',1,0));
	orig_phone_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_phone<>'',1,0));
	orig_gender_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.orig_gender<>'',1,0));
	experian_encrypted_pin_CountNonBlank := sum(group,if(pFCRA_ExperianCred_EN_base.experian_encrypted_pin<>'',1,0));
 end;

dPopulationStats_FCRA_ExperianCred_EN_base := table(pFCRA_ExperianCred_EN_base
							  	    ,rPopulationStats_FCRA_ExperianCred_EN_base
									,st
									,few);

CreateXMLStats(string ver) :=  function									
	STRATA.createXMLStats(dPopulationStats_FCRA_ExperianCred_EN_base
					 ,'EN'
					 ,'FCRA_ExperianCred'
					 ,ver
					 ,'jose.bello@lexisnexis.com'
					 ,zFCRA_ExperianCred_EN_base);
	return zFCRA_ExperianCred_EN_base;
END;

EXPORT Strata(string ver) := CreateXMLStats(ver);