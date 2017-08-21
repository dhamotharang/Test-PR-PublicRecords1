import STRATA;
pOptinCellphones_base:=Files.File_Base;
pVersion:=Version;

rPopulationStats_OptinCellphones_base
 :=
  record
    state										:= pOptinCellphones_base.Orig_State;
    CountGroup									:= count(group);
	did_CountNonBlank							:= sum(group,if(pOptinCellphones_base.did<>0,1,0));
	did_score_CountNonBlank						:= sum(group,if(pOptinCellphones_base.DID_Score_field<>0,1,0));
	aid_raw_CountNonBlank						:= sum(group,if(pOptinCellphones_base.rawAIDin<>0,1,0));
	aid_clean_CountNonBlank						:= sum(group,if(pOptinCellphones_base.cleanaid<>0,1,0));
	date_first_seen_CountNonBlank				:= sum(group,if(pOptinCellphones_base.date_first_seen<>0,1,0));
	date_last_seen_CountNonBlank				:= sum(group,if(pOptinCellphones_base.date_last_seen<>0,1,0));
	date_vendor_first_reported_CountNonBlank	:= sum(group,if(pOptinCellphones_base.date_vendor_first_reported<>0,1,0));
	date_vendor_last_reported_CountNonBlank		:= sum(group,if(pOptinCellphones_base.date_vendor_last_reported<>0,1,0));
	current_rec_flag_CountNonBlank				:= sum(group,if(pOptinCellphones_base.current_rec_flag<>0,1,0));
	//---Original data
	Orig_Telephone_CountNonBlank				:= sum(group,if(pOptinCellphones_base.Orig_Phone<>'',1,0));
	Orig_fname_CountNonBlank					:= sum(group,if(pOptinCellphones_base.Orig_fname<>'',1,0));
	Orig_lname_CountNonBlank					:= sum(group,if(pOptinCellphones_base.Orig_lname<>'',1,0));		
	Orig_Address_CountNonBlank					:= sum(group,if(pOptinCellphones_base.Orig_Address<>'',1,0));
	Orig_City_CountNonBlank						:= sum(group,if(pOptinCellphones_base.Orig_City<>'',1,0));
	Orig_State_CountNonBlank					:= sum(group,if(pOptinCellphones_base.Orig_State<>'',1,0));
	Orig_ZipCode_CountNonBlank					:= sum(group,if(pOptinCellphones_base.Orig_Zip5<>'',1,0));
	Orig_ZipCode4_CountNonBlank					:= sum(group,if(pOptinCellphones_base.Orig_Zip4<>'',1,0));

	//-------clean name data
	title_CountNonBlank							:= sum(group,if(pOptinCellphones_base.title<>'',1,0));
	fname_CountNonBlank							:= sum(group,if(pOptinCellphones_base.fname<>'',1,0));
	mname_CountNonBlank							:= sum(group,if(pOptinCellphones_base.mname<>'',1,0));
	lname_CountNonBlank							:= sum(group,if(pOptinCellphones_base.lname<>'',1,0));
	name_suffix_CountNonBlank					:= sum(group,if(pOptinCellphones_base.name_suffix<>'',1,0));
	name_score_CountNonBlank					:= sum(group,if(pOptinCellphones_base.name_score<>'',1,0));

	//-------clean address data
	prim_range_CountNonBlank					:= sum(group,if(pOptinCellphones_base.prim_range<>'',1,0));
	predir_CountNonBlank						:= sum(group,if(pOptinCellphones_base.predir<>'',1,0));
	prim_name_CountNonBlank						:= sum(group,if(pOptinCellphones_base.prim_name<>'',1,0));
	addr_suffix_CountNonBlank					:= sum(group,if(pOptinCellphones_base.addr_suffix<>'',1,0));
	postdir_CountNonBlank						:= sum(group,if(pOptinCellphones_base.postdir<>'',1,0));
	unit_desig_CountNonBlank					:= sum(group,if(pOptinCellphones_base.unit_desig<>'',1,0));
	sec_range_CountNonBlank						:= sum(group,if(pOptinCellphones_base.sec_range<>'',1,0));
	p_city_name_CountNonBlank					:= sum(group,if(pOptinCellphones_base.p_city_name<>'',1,0));
	v_city_name_CountNonBlank					:= sum(group,if(pOptinCellphones_base.v_city_name<>'',1,0));
	st_CountNonBlank							:= sum(group,if(pOptinCellphones_base.st<>'',1,0));
	zip_CountNonBlank							:= sum(group,if(pOptinCellphones_base.zip<>'',1,0));
	zip4_CountNonBlank							:= sum(group,if(pOptinCellphones_base.zip4<>'',1,0));
	cart_CountNonBlank							:= sum(group,if(pOptinCellphones_base.cart<>'',1,0));
	cr_sort_sz_CountNonBlank					:= sum(group,if(pOptinCellphones_base.cr_sort_sz<>'',1,0));
	lot_CountNonBlank							:= sum(group,if(pOptinCellphones_base.lot<>'',1,0));
	lot_order_CountNonBlank						:= sum(group,if(pOptinCellphones_base.lot_order<>'',1,0));
	dbpc_CountNonBlank							:= sum(group,if(pOptinCellphones_base.dbpc<>'',1,0));
	chk_digit_CountNonBlank						:= sum(group,if(pOptinCellphones_base.chk_digit<>'',1,0));
	rec_type_CountNonBlank						:= sum(group,if(pOptinCellphones_base.rec_type<>'',1,0));
	county_CountNonBlank						:= sum(group,if(pOptinCellphones_base.county<>'',1,0));
	geo_lat_CountNonBlank						:= sum(group,if(pOptinCellphones_base.geo_lat<>'',1,0));
	geo_long_CountNonBlank						:= sum(group,if(pOptinCellphones_base.geo_long<>'',1,0));
	msa_CountNonBlank							:= sum(group,if(pOptinCellphones_base.msa<>'',1,0));
	geo_blk_CountNonBlank						:= sum(group,if(pOptinCellphones_base.geo_blk<>'',1,0));
	geo_match_CountNonBlank						:= sum(group,if(pOptinCellphones_base.geo_match<>'',1,0));
	err_stat_CountNonBlank						:= sum(group,if(pOptinCellphones_base.err_stat<>'',1,0));
  end;

dPopulationStats_OptinCellphones_base := table(pOptinCellphones_base
							  	    ,rPopulationStats_OptinCellphones_base
									,orig_state
									,few);
STRATA.createXMLStats(dPopulationStats_OptinCellphones_base
					 ,'--'
					 ,'OptinCellphones'
					 ,pVersion
					 ,'nirav.bhatt@lexisnexis.com'
					 ,zOptinCellphones_base);

EXPORT Strata_Stat_OptinCellphones_Build := zOptinCellphones_base;