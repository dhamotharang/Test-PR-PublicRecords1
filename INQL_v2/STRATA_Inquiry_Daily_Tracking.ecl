import strata;

export STRATA_Inquiry_Daily_Tracking(string filedate, boolean omit_output_to_screen = true) := function 

ds := INQL_V2.File_Inquiry_BaseSourced.updates;

rSTRATA_Inquiry_Daily_Tracking := record	 
    CountGroup              			   := count(group);
    ds.search_info.function_description;
    ds.search_info.transaction_type;
    mbs_company_id									 := sum(group,if(ds.mbs.company_id<>'',1,0));
    mbs_global_company_id						 := sum(group,if(ds.mbs.global_company_id<>'',1,0));
    allow_flags_allowflags					 := sum(group,if(ds.allow_flags.allowflags<>0,1,0));
    bus_intel_primary_market_code		 := sum(group,if(ds.bus_intel.primary_market_code<>'',1,0));
    bus_intel_secondary_market_code	 := sum(group,if(ds.bus_intel.secondary_market_code<>'',1,0));
    bus_intel_industry_1_code				 := sum(group,if(ds.bus_intel.industry_1_code<>'',1,0));
    bus_intel_industry_2_code				 := sum(group,if(ds.bus_intel.industry_2_code<>'',1,0));
    bus_intel_sub_market						 := sum(group,if(ds.bus_intel.sub_market<>'',1,0));
    bus_intel_vertical							 := sum(group,if(ds.bus_intel.vertical<>'',1,0));
    bus_intel_use										 := sum(group,if(ds.bus_intel.use<>'',1,0));
    bus_intel_industry							 := sum(group,if(ds.bus_intel.industry<>'',1,0));
    person_q_full_name							 := sum(group,if(ds.person_q.full_name<>'',1,0));
    person_q_first_name							 := sum(group,if(ds.person_q.first_name<>'',1,0));
    person_q_middle_name						 := sum(group,if(ds.person_q.middle_name<>'',1,0));
    person_q_last_name							 := sum(group,if(ds.person_q.last_name<>'',1,0));
    person_q_address								 := sum(group,if(ds.person_q.address<>'',1,0));
    person_q_city										 := sum(group,if(ds.person_q.city<>'',1,0));
    person_q_state									 := sum(group,if(ds.person_q.state<>'',1,0));
    person_q_zip										 := sum(group,if(ds.person_q.zip<>'',1,0));
    person_q_personal_phone					 := sum(group,if(ds.person_q.personal_phone<>'',1,0));
    person_q_work_phone							 := sum(group,if(ds.person_q.work_phone<>'',1,0));
    person_q_dob										 := sum(group,if(ds.person_q.dob<>'',1,0));
    person_q_dl											 := sum(group,if(ds.person_q.dl<>'',1,0));
    person_q_dl_st									 := sum(group,if(ds.person_q.dl_st<>'',1,0));
    person_q_email_address					 := sum(group,if(ds.person_q.email_address<>'',1,0));
    person_q_ssn										 := sum(group,if(ds.person_q.ssn<>'',1,0));
    person_q_linkid									 := sum(group,if(ds.person_q.linkid<>'',1,0));
    person_q_ipaddr									 := sum(group,if(ds.person_q.ipaddr<>'',1,0));
    person_q_title									 := sum(group,if(ds.person_q.title<>'',1,0));
    person_q_fname									 := sum(group,if(ds.person_q.fname<>'',1,0));
    person_q_mname									 := sum(group,if(ds.person_q.mname<>'',1,0));
    person_q_lname									 := sum(group,if(ds.person_q.lname<>'',1,0));
    person_q_name_suffix						 := sum(group,if(ds.person_q.name_suffix<>'',1,0));
    person_q_prim_range							 := sum(group,if(ds.person_q.prim_range<>'',1,0));
    person_q_predir									 := sum(group,if(ds.person_q.predir<>'',1,0));
    person_q_prim_name							 := sum(group,if(ds.person_q.prim_name<>'',1,0));
    person_q_addr_suffix						 := sum(group,if(ds.person_q.addr_suffix<>'',1,0));
    person_q_postdir								 := sum(group,if(ds.person_q.postdir<>'',1,0));
    person_q_unit_desig							 := sum(group,if(ds.person_q.unit_desig<>'',1,0));
    person_q_sec_range							 := sum(group,if(ds.person_q.sec_range<>'',1,0));
    person_q_v_city_name						 := sum(group,if(ds.person_q.v_city_name<>'',1,0));
    person_q_st											 := sum(group,if(ds.person_q.st<>'',1,0));
    person_q_zip5										 := sum(group,if(ds.person_q.zip5<>'',1,0));
    person_q_zip4										 := sum(group,if(ds.person_q.zip4<>'',1,0));
    person_q_addr_rec_type					 := sum(group,if(ds.person_q.addr_rec_type<>'',1,0));
    person_q_fips_state							 := sum(group,if(ds.person_q.fips_state<>'',1,0));
    person_q_fips_county						 := sum(group,if(ds.person_q.fips_county<>'',1,0));
    person_q_geo_lat								 := sum(group,if(ds.person_q.geo_lat<>'',1,0));
    person_q_geo_long								 := sum(group,if(ds.person_q.geo_long<>'',1,0));
    person_q_cbsa										 := sum(group,if(ds.person_q.cbsa<>'',1,0));
    person_q_geo_blk								 := sum(group,if(ds.person_q.geo_blk<>'',1,0));
    person_q_geo_match							 := sum(group,if(ds.person_q.geo_match<>'',1,0));
    person_q_err_stat								 := sum(group,if(ds.person_q.err_stat<>'',1,0));
    person_q_appended_ssn						 := sum(group,if(ds.person_q.appended_ssn<>'',1,0));
    person_q_appended_adl						 := sum(group,if(ds.person_q.appended_adl<>0,1,0));
    permissions_glb_purpose					 := sum(group,if(ds.permissions.glb_purpose<>'',1,0));
    permissions_dppa_purpose				 := sum(group,if(ds.permissions.dppa_purpose<>'',1,0));
    permissions_fcra_purpose				 := sum(group,if(ds.permissions.fcra_purpose<>'',1,0));
    search_info_datetime						 := sum(group,if(ds.search_info.datetime<>'',1,0));
    search_info_start_monitor				 := sum(group,if(ds.search_info.start_monitor<>'',1,0));
    search_info_stop_monitor				 := sum(group,if(ds.search_info.stop_monitor<>'',1,0));
    search_info_login_history_id		 := sum(group,if(ds.search_info.login_history_id<>'',1,0));
    search_info_transaction_id			 := sum(group,if(ds.search_info.transaction_id<>'',1,0));
    search_info_sequence_number			 := sum(group,if(ds.search_info.sequence_number<>'',1,0));
    search_info_method							 := sum(group,if(ds.search_info.method<>'',1,0));
    search_info_product_code				 := sum(group,if(ds.search_info.product_code<>'',1,0));
    search_info_ipaddr							 := sum(group,if(ds.search_info.ipaddr<>'',1,0));
END;
 
 
tStats := table(ds,rSTRATA_Inquiry_Daily_Tracking,search_info.function_description,search_info.transaction_type, few);

strata.createXMLStats(tStats,'Inquiry_Tracking_Update_v3','data',filedate,'',resultsOut,,,,,omit_output_to_screen);
return resultsOut;
end;






