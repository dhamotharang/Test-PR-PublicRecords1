 #workunit('name', 'OutwardMediaStrata' );
 EXPORT proc_build_strata(STRING version) := FUNCTION
 IMPORT STRATA;
 
 Basefile:=OutwardMedia.Files.File_OutwardMedia_Base;
 
  Layout_Strata:=RECORD
  basefile.clean_st;
  CountGroup:=COUNT(GROUP);
  email_Cnt  := sum(group,if(basefile.email<>'',1,0));  
	firstname_Cnt := sum(group,if(basefile.firstname<>'',1,0));
  lastname_Cnt := sum(group,if(basefile.lastname<>'',1,0));
  address1_Cnt := sum(group,if(basefile.address1<>'',1,0));
	address2_Cnt := sum(group,if(basefile.address2<>'',1,0));
  city_Cnt  := sum(group,if(basefile.city<>'',1,0));
  state_Cnt  := sum(group,if(basefile.state<>'',1,0));
  zip_Cnt  := sum(group,if(basefile.zip<>'',1,0));
  phone_Cnt  := sum(group,if(basefile.phone<>'',1,0));
  ipaddress_Cnt  := sum(group,if(basefile.ipaddress<>'',1,0));
  optin_Cnt  := sum(group,if(basefile.optin<>'',1,0));
  weburl_Cnt  := sum(group,if(basefile.weburl<>'',1,0));
  did_Cnt  := sum(group,if(basefile.did>0,1,0));
  did_score_Cnt  := sum(group,if(basefile.did_score>0,1,0));
  clean_title_Cnt  := sum(group,if(basefile.clean_title<>'',1,0));
  clean_fname_Cnt  := sum(group,if(basefile.clean_fname<>'',1,0));
  clean_mname_Cnt  := sum(group,if(basefile.clean_mname<>'',1,0));
  clean_lname_Cnt  := sum(group,if(basefile.clean_lname<>'',1,0));
  clean_name_suffix_Cnt  := sum(group,if(basefile.clean_name_suffix<>'',1,0));
  clean_name_score_Cnt  := sum(group,if(basefile.clean_name_score<>'',1,0));
  clean_prim_range_Cnt  := sum(group,if(basefile.clean_prim_range<>'',1,0));
  clean_predir_Cnt  := sum(group,if(basefile.clean_predir<>'',1,0));
  clean_prim_name_Cnt  := sum(group,if(basefile.clean_prim_name<>'',1,0));
  clean_addr_suffix_Cnt  := sum(group,if(basefile.clean_addr_suffix<>'',1,0));
  clean_postdir_Cnt  := sum(group,if(basefile.clean_postdir<>'',1,0));
  clean_unit_desig_Cnt  := sum(group,if(basefile.clean_unit_desig<>'',1,0));
  clean_sec_range_Cnt  := sum(group,if(basefile.clean_sec_range<>'',1,0));
  clean_p_city_name_Cnt  := sum(group,if(basefile.clean_p_city_name<>'',1,0));
  clean_v_city_name_Cnt  := sum(group,if(basefile.clean_v_city_name<>'',1,0));
	clean_st_Cnt := sum(group,if(basefile.clean_st<>'',1,0));
	clean_zip_Cnt  := sum(group,if(basefile.clean_zip<>'',1,0));
  clean_zip4_Cnt  := sum(group,if(basefile.clean_zip4<>'',1,0));
  clean_cart_Cnt  := sum(group,if(basefile.clean_cart<>'',1,0));
  clean_cr_sort_sz_Cnt  := sum(group,if(basefile.clean_cr_sort_sz<>'',1,0));
  clean_lot_Cnt  := sum(group,if(basefile.clean_lot<>'',1,0));
  clean_lot_order_Cnt  := sum(group,if(basefile.clean_lot_order<>'',1,0));
  clean_dbpc_Cnt  := sum(group,if(basefile.clean_dbpc<>'',1,0));
  clean_chk_digit_Cnt  := sum(group,if(basefile.clean_chk_digit<>'',1,0));
  clean_rec_type_Cnt  := sum(group,if(basefile.clean_rec_type<>'',1,0));
  clean_county_Cnt  := sum(group,if(basefile.clean_county<>'',1,0));
  clean_geo_lat_Cnt  := sum(group,if(basefile.clean_geo_lat<>'',1,0));
  clean_geo_long_Cnt  := sum(group,if(basefile.clean_geo_long<>'',1,0));
  clean_msa_Cnt  := sum(group,if(basefile.clean_msa<>'',1,0));
  clean_geo_blk_Cnt  := sum(group,if(basefile.clean_geo_blk<>'',1,0));
  clean_geo_match_Cnt  := sum(group,if(basefile.clean_geo_match<>'',1,0));
  clean_err_stat_Cnt  := sum(group,if(basefile.clean_err_stat<>'',1,0));
  date_first_seen_Cnt  := sum(group,if(basefile.date_first_seen<>'',1,0));
  date_last_seen_Cnt  := sum(group,if(basefile.date_last_seen<>'',1,0));
  date_vendor_first_reported_Cnt := sum(group,if(basefile.date_vendor_first_reported<>'',1,0));
  date_vendor_last_reported_Cnt := sum(group,if(basefile.date_vendor_last_reported<>'',1,0));
 END;
 
 basestrata:=Sort(Table(basefile,Layout_Strata),clean_st);
 strata.createXMLStats(basestrata,'Outward_Media stats','data',version,'',strataResults);
 
 RETURN strataResults;
END;