import STRATA;

EXPORT STRATA_Stats_new(string filedate) := function

pCertegy_base:=Files.certegy_base;
pVersion:=filedate;

rPopulationStats_Certegy_base
 :=
  record
    CountGroup								:= count(group);
	did_CountNonBlank						:= sum(group,if(pCertegy_base.did<>0,1,0));
	did_score_CountNonBlank					:= sum(group,if(pCertegy_base.did_score<>0,1,0));
	orig_dl_state_CountNonBlank				:= sum(group,if(pCertegy_base.orig_dl_state<>'',1,0));
	orig_dl_num_CountNonBlank				:= sum(group,if(pCertegy_base.orig_dl_num<>'',1,0));
	orig_ssn_CountNonBlank					:= sum(group,if(pCertegy_base.orig_ssn<>'',1,0));
	orig_dl_issue_dte_CountNonBlank			:= sum(group,if(pCertegy_base.orig_dl_issue_dte<>'',1,0));
	orig_dl_expire_dte_CountNonBlank		:= sum(group,if(pCertegy_base.orig_dl_expire_dte<>'',1,0));
	orig_professional_title_CountNonBlank	:= sum(group,if(pCertegy_base.orig_professional_title<>'',1,0));
	orig_functional_title_CountNonBlank		:= sum(group,if(pCertegy_base.orig_functional_title<>'',1,0));
	orig_house_bldg_num_CountNonBlank		:= sum(group,if(pCertegy_base.orig_house_bldg_num<>'',1,0));
	orig_street_suffix_CountNonBlank		:= sum(group,if(pCertegy_base.orig_street_suffix<>'',1,0));
	orig_apt_num_CountNonBlank				:= sum(group,if(pCertegy_base.orig_apt_num<>'',1,0));
	orig_unit_desc_CountNonBlank			:= sum(group,if(pCertegy_base.orig_unit_desc<>'',1,0));
	orig_street_post_dir_CountNonBlank		:= sum(group,if(pCertegy_base.orig_street_post_dir<>'',1,0));
	orig_street_pre_dir_CountNonBlank		:= sum(group,if(pCertegy_base.orig_street_pre_dir<>'',1,0));
	pCertegy_base.orig_DL_State;
	orig_zip_CountNonBlank					:= sum(group,if(pCertegy_base.orig_zip<>'',1,0));
	orig_dob_CountNonBlank					:= sum(group,if(pCertegy_base.orig_dob<>'',1,0));
	orig_deceased_dte_CountNonBlank			:= sum(group,if(pCertegy_base.orig_deceased_dte<>'',1,0));
	orig_home_tel_area_CountNonBlank		:= sum(group,if(pCertegy_base.orig_home_tel_area<>'',1,0));
	orig_home_tel_num_CountNonBlank			:= sum(group,if(pCertegy_base.orig_home_tel_num<>'',1,0));
	orig_work_tel_area_CountNonBlank		:= sum(group,if(pCertegy_base.orig_work_tel_area<>'',1,0));
	orig_work_tel_num_CountNonBlank			:= sum(group,if(pCertegy_base.orig_work_tel_num<>'',1,0));
	orig_work_tel_ext_CountNonBlank			:= sum(group,if(pCertegy_base.orig_work_tel_ext<>'',1,0));
	orig_first_name_CountNonBlank			:= sum(group,if(pCertegy_base.orig_first_name<>'',1,0));
	orig_mid_name_CountNonBlank				:= sum(group,if(pCertegy_base.orig_mid_name<>'',1,0));
	orig_last_name_CountNonBlank			:= sum(group,if(pCertegy_base.orig_last_name<>'',1,0));
	orig_street_name_CountNonBlank			:= sum(group,if(pCertegy_base.orig_street_name<>'',1,0));
	orig_city_CountNonBlank					:= sum(group,if(pCertegy_base.orig_city<>'',1,0));
	clean_ssn_CountNonBlank					:= sum(group,if(pCertegy_base.clean_ssn<>'',1,0));
	clean_dob_CountNonBlank					:= sum(group,if(pCertegy_base.clean_dob<>'',1,0));
	clean_hphone_CountNonBlank				:= sum(group,if(pCertegy_base.clean_hphone<>'',1,0));
	clean_wphone_CountNonBlank				:= sum(group,if(pCertegy_base.clean_wphone<>'',1,0));
	date_first_seen_CountNonBlank			:= sum(group,if(pCertegy_base.date_first_seen<>'',1,0));
	date_last_seen_CountNonBlank			:= sum(group,if(pCertegy_base.date_last_seen<>'',1,0));
	date_vendor_first_reported_CountNonBlank:= sum(group,if(pCertegy_base.date_vendor_first_reported<>'',1,0));
	date_vendor_last_reported_CountNonBlank	:= sum(group,if(pCertegy_base.date_vendor_last_reported<>'',1,0));
	title_CountNonBlank						:= sum(group,if(pCertegy_base.title<>'',1,0));
	fname_CountNonBlank						:= sum(group,if(pCertegy_base.fname<>'',1,0));
	mname_CountNonBlank						:= sum(group,if(pCertegy_base.mname<>'',1,0));
	lname_CountNonBlank						:= sum(group,if(pCertegy_base.lname<>'',1,0));
	name_suffix_CountNonBlank				:= sum(group,if(pCertegy_base.name_suffix<>'',1,0));
	name_score_CountNonBlank				:= sum(group,if(pCertegy_base.name_score<>'',1,0));
	prim_range_CountNonBlank				:= sum(group,if(pCertegy_base.prim_range<>'',1,0));
	predir_CountNonBlank					:= sum(group,if(pCertegy_base.predir<>'',1,0));
	prim_name_CountNonBlank					:= sum(group,if(pCertegy_base.prim_name<>'',1,0));
	addr_suffix_CountNonBlank				:= sum(group,if(pCertegy_base.addr_suffix<>'',1,0));
	postdir_CountNonBlank					:= sum(group,if(pCertegy_base.postdir<>'',1,0));
	unit_desig_CountNonBlank				:= sum(group,if(pCertegy_base.unit_desig<>'',1,0));
	sec_range_CountNonBlank					:= sum(group,if(pCertegy_base.sec_range<>'',1,0));
	p_city_name_CountNonBlank				:= sum(group,if(pCertegy_base.p_city_name<>'',1,0));
	v_city_name_CountNonBlank				:= sum(group,if(pCertegy_base.v_city_name<>'',1,0));
	st_CountNonBlank						:= sum(group,if(pCertegy_base.st<>'',1,0));
	zip_CountNonBlank						:= sum(group,if(pCertegy_base.zip<>'',1,0));
	zip4_CountNonBlank						:= sum(group,if(pCertegy_base.zip4<>'',1,0));
	cart_CountNonBlank						:= sum(group,if(pCertegy_base.cart<>'',1,0));
	cr_sort_sz_CountNonBlank				:= sum(group,if(pCertegy_base.cr_sort_sz<>'',1,0));
	lot_CountNonBlank						:= sum(group,if(pCertegy_base.lot<>'',1,0));
	lot_order_CountNonBlank					:= sum(group,if(pCertegy_base.lot_order<>'',1,0));
	dbpc_CountNonBlank						:= sum(group,if(pCertegy_base.dbpc<>'',1,0));
	chk_digit_CountNonBlank					:= sum(group,if(pCertegy_base.chk_digit<>'',1,0));
	rec_type_CountNonBlank					:= sum(group,if(pCertegy_base.rec_type<>'',1,0));
	fips_county								:= sum(group,if(pCertegy_base.fips_county<>'',1,0));
	county_CountNonBlank					:= sum(group,if(pCertegy_base.county<>'',1,0));
	geo_lat_CountNonBlank					:= sum(group,if(pCertegy_base.geo_lat<>'',1,0));
	geo_long_CountNonBlank					:= sum(group,if(pCertegy_base.geo_long<>'',1,0));
	msa_CountNonBlank						:= sum(group,if(pCertegy_base.msa<>'',1,0));
	geo_blk_CountNonBlank					:= sum(group,if(pCertegy_base.geo_blk<>'',1,0));
	geo_match_CountNonBlank					:= sum(group,if(pCertegy_base.geo_match<>'',1,0));
	err_stat_CountNonBlank					:= sum(group,if(pCertegy_base.err_stat<>'',1,0));
  end;

dPopulationStats_Certegy_base := table(pCertegy_base
							  	    ,rPopulationStats_Certegy_base
									,orig_DL_State
									,few);
									
STRATA.createXMLStats(dPopulationStats_Certegy_base
					 ,'DL'
					 ,'Certegy DL New'
					 ,pVersion
					 ,_Control.MyInfo.EmailAddressNotify
					 ,zCertegy_base);

retval := zCertegy_base;
return retval;
end;