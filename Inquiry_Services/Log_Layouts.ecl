import address, iesp;

EXPORT log_layouts := module
  EXPORT temp_layout := record  
    string4 product_id := '';
	  string Industry := '';
	  string Sub_Market := '';
	  string Use := '';
	  string Vertical := '';
	  string GC_ID := '';
	  string2 transaction_type := '';
	  string40 function_name := '';
	  string200 description := '';
  end;
	
  EXPORT input_layout := record
   string20  company_ID        ; 
   string2   Transaction_Type ;
   string40  Function_Name    ;
	 string    FirstName ;
	 string    LastName;
   string120 address ;
   string25  city ;
   string2   state   ;
   string5   zip ;
	 string    SSN;
	 string    Phone;
	 string    Email;
	 string    DOB;

  end;

  EXPORT in_layout_w_cleanAddr := record
		unsigned seq;
	  input_layout input;
    address.Layout_AddressCleaning_Out cleanAddr;
  END;
  
	EXPORT response := record
		string Description {xpath('description')};
		//company
		string Industry {xpath('industry')};
		string Sub_Market {xpath('sub_market')};
		string Use {xpath('use')};
		string Vertical {xpath('vertical')};
		string GC_ID {xpath('gc_id')};
		string Product_Id {xpath('product_id')};
		string15 powid {xpath('powid')};
		string15 proxid {xpath('proxid')};
		string15 seleid {xpath('seleid')};
		string15 orgid {xpath('orgid')};
		string15 ultid {xpath('ultid')};
		string10 bus_prim_range {xpath('bus_prim_range')};
		string2 bus_predir {xpath('bus_predir')};
		string28 bus_prim_name {xpath('bus_prim_name')};
		string4 bus_addr_suffix {xpath('bus_addr_suffix')};
		string2 bus_postdir {xpath('bus_postdir')};
		string10 bus_unit_desig {xpath('bus_unit_desig')};
		string8 bus_sec_range {xpath('bus_sec_range')};
		string25 bus_v_city_name {xpath('bus_v_city_name')};
		string2 bus_St {xpath('bus_st')};
		string5 bus_Zip {xpath('bus_zip')};
		string4 bus_Zip4 {xpath('bus_zip4')};
		string bus_rec_type {xpath('bus_rec_type')};
		string bus_fips_state {xpath('bus_fips_state')};
		string bus_fips_county {xpath('bus_fips_county')};
		string bus_geo_lat {xpath('bus_geo_lat')};
		string bus_geo_long {xpath('bus_geo_long')};
		string bus_msa {xpath('bus_msa')};
		string bus_geo_blk {xpath('bus_geo_blk')};
		string bus_geo_match {xpath('bus_geo_match')};
		string bus_err_stat {xpath('bus_err_stat')};	
		//auth rep 1
		string did {xpath('did')};
		string10 prim_range {xpath('prim_range')};
		string2 predir {xpath('predir')};
		string28 prim_name {xpath('prim_name')};
		string4 addr_suffix {xpath('addr_suffix')};
		string2 postdir {xpath('postdir')};
		string10 unit_desig {xpath('unit_desig')};
		string8 sec_range {xpath('sec_range')};
		string25 v_city_name {xpath('v_city_name')};
		string2 St {xpath('st')};
		string5 Zip {xpath('zip')};
		string4 Zip4 {xpath('zip4')};
		string rec_type {xpath('rec_type')};
		string fips_state {xpath('fips_state')};
		string fips_county {xpath('fips_county')};
		string geo_lat {xpath('geo_lat')};
		string geo_long {xpath('geo_long')};
		string msa {xpath('msa')};
		string geo_blk {xpath('geo_blk')};
		string geo_match {xpath('geo_match')};
		string err_stat {xpath('err_stat')};	
		//auth rep 2
		string did_2 {xpath('did_2')};
		string10 prim_range_2 {xpath('prim_range_2')};
		string2 predir_2 {xpath('predir_2')};
		string28 prim_name_2 {xpath('prim_name_2')};
		string4 addr_suffix_2 {xpath('addr_suffix_2')};
		string2 postdir_2 {xpath('postdir_2')};
		string10 unit_desig_2 {xpath('unit_desig_2')};
		string8 sec_range_2 {xpath('sec_range_2')};
		string25 v_city_name_2 {xpath('v_city_name_2')};
		string2 St_2 {xpath('st_2')};
		string5 Zip_2 {xpath('zip_2')};
		string4 Zip4_2 {xpath('zip4_2')};
		string rec_type_2 {xpath('rec_type_2')};
		string fips_state_2 {xpath('fips_state_2')};
		string fips_county_2 {xpath('fips_county_2')};
		string geo_lat_2 {xpath('geo_lat_2')};
		string geo_long_2 {xpath('geo_long_2')};
		string msa_2 {xpath('msa_2')};
		string geo_blk_2 {xpath('geo_blk_2')};
		string geo_match_2 {xpath('geo_match_2')};
		string err_stat_2 {xpath('err_stat_2')};	
		//auth rep 3
		string did_3 {xpath('did_3')};
		string10 prim_range_3 {xpath('prim_range_3')};
		string2 predir_3 {xpath('predir_3')};
		string28 prim_name_3 {xpath('prim_name_3')};
		string4 addr_suffix_3 {xpath('addr_suffix_3')};
		string2 postdir_3 {xpath('postdir_3')};
		string10 unit_desig_3 {xpath('unit_desig_3')};
		string8 sec_range_3 {xpath('sec_range_3')};
		string25 v_city_name_3 {xpath('v_city_name_3')};
		string2 St_3 {xpath('st_3')};
		string5 Zip_3 {xpath('zip_3')};
		string4 Zip4_3 {xpath('zip4_3')};
		string rec_type_3 {xpath('rec_type_3')};
		string fips_state_3 {xpath('fips_state_3')};
		string fips_county_3 {xpath('fips_county_3')};
		string geo_lat_3 {xpath('geo_lat_3')};
		string geo_long_3 {xpath('geo_long_3')};
		string msa_3 {xpath('msa_3')};
		string geo_blk_3 {xpath('geo_blk_3')};
		string geo_match_3 {xpath('geo_match_3')};
		string err_stat_3 {xpath('err_stat_3')};		 
		//auth rep 4
		string did_4 {xpath('did_4')};
		string10 prim_range_4 {xpath('prim_range_4')};
		string2 predir_4 {xpath('predir_4')};
		string28 prim_name_4 {xpath('prim_name_4')};
		string4 addr_suffix_4 {xpath('addr_suffix_4')};
		string2 postdir_4 {xpath('postdir_4')};
		string10 unit_desig_4 {xpath('unit_desig_4')};
		string8 sec_range_4 {xpath('sec_range_4')};
		string25 v_city_name_4 {xpath('v_city_name_4')};
		string2 St_4 {xpath('st_4')};
		string5 Zip_4 {xpath('zip_4')};
		string4 Zip4_4 {xpath('zip4_4')};
		string rec_type_4 {xpath('rec_type_4')};
		string fips_state_4 {xpath('fips_state_4')};
		string fips_county_4 {xpath('fips_county_4')};
		string geo_lat_4 {xpath('geo_lat_4')};
		string geo_long_4 {xpath('geo_long_4')};
		string msa_4 {xpath('msa_4')};
		string geo_blk_4 {xpath('geo_blk_4')};
		string geo_match_4 {xpath('geo_match_4')};
		string err_stat_4 {xpath('err_stat_4')};	
		//auth rep 5
		string did_5 {xpath('did_5')};
		string10 prim_range_5 {xpath('prim_range_5')};
		string2 predir_5 {xpath('predir_5')};
		string28 prim_name_5 {xpath('prim_name_5')};
		string4 addr_suffix_5 {xpath('addr_suffix_5')};
		string2 postdir_5 {xpath('postdir_5')};
		string10 unit_desig_5 {xpath('unit_desig_5')};
		string8 sec_range_5 {xpath('sec_range_5')};
		string25 v_city_name_5 {xpath('v_city_name_5')};
		string2 St_5 {xpath('st_5')};
		string5 Zip_5 {xpath('zip_5')};
		string4 Zip4_5 {xpath('zip4_5')};
		string rec_type_5 {xpath('rec_type_5')};
		string fips_state_5 {xpath('fips_state_5')};
		string fips_county_5 {xpath('fips_county_5')};
		string geo_lat_5 {xpath('geo_lat_5')};
		string geo_long_5 {xpath('geo_long_5')};
		string msa_5 {xpath('msa_5')};
		string geo_blk_5 {xpath('geo_blk_5')};
		string geo_match_5 {xpath('geo_match_5')};
		string err_stat_5 {xpath('err_stat_5')};	
		//auth rep 6
		string did_6 {xpath('did_6')};
		string10 prim_range_6 {xpath('prim_range_6')};
		string2 predir_6 {xpath('predir_6')};
		string28 prim_name_6 {xpath('prim_name_6')};
		string4 addr_suffix_6 {xpath('addr_suffix_6')};
		string2 postdir_6 {xpath('postdir_6')};
		string10 unit_desig_6 {xpath('unit_desig_6')};
		string8 sec_range_6 {xpath('sec_range_6')};
		string25 v_city_name_6 {xpath('v_city_name_6')};
		string2 St_6 {xpath('st_6')};
		string5 Zip_6 {xpath('zip_6')};
		string4 Zip4_6 {xpath('zip4_6')};
		string rec_type_6 {xpath('rec_type_6')};
		string fips_state_6 {xpath('fips_state_6')};
		string fips_county_6 {xpath('fips_county_6')};
		string geo_lat_6 {xpath('geo_lat_6')};
		string geo_long_6 {xpath('geo_long_6')};
		string msa_6 {xpath('msa_6')};
		string geo_blk_6 {xpath('geo_blk_6')};
		string geo_match_6 {xpath('geo_match_6')};
		string err_stat_6 {xpath('err_stat_6')};	
		//auth rep 7
		string did_7 {xpath('did_7')};
		string10 prim_range_7 {xpath('prim_range_7')};
		string2 predir_7 {xpath('predir_7')};
		string28 prim_name_7 {xpath('prim_name_7')};
		string4 addr_suffix_7 {xpath('addr_suffix_7')};
		string2 postdir_7 {xpath('postdir_7')};
		string10 unit_desig_7 {xpath('unit_desig_7')};
		string8 sec_range_7 {xpath('sec_range_7')};
		string25 v_city_name_7 {xpath('v_city_name_7')};
		string2 St_7 {xpath('st_7')};
		string5 Zip_7 {xpath('zip_7')};
		string4 Zip4_7 {xpath('zip4_7')};
		string rec_type_7 {xpath('rec_type_7')};
		string fips_state_7 {xpath('fips_state_7')};
		string fips_county_7 {xpath('fips_county_7')};
		string geo_lat_7 {xpath('geo_lat_7')};
		string geo_long_7 {xpath('geo_long_7')};
		string msa_7 {xpath('msa_7')};
		string geo_blk_7 {xpath('geo_blk_7')};
		string geo_match_7 {xpath('geo_match_7')};
		string err_stat_7 {xpath('err_stat_7')};	
		//auth rep 8
		string did_8 {xpath('did_8')};
		string10 prim_range_8 {xpath('prim_range_8')};
		string2 predir_8 {xpath('predir_8')};
		string28 prim_name_8 {xpath('prim_name_8')};
		string4 addr_suffix_8 {xpath('addr_suffix_8')};
		string2 postdir_8 {xpath('postdir_8')};
		string10 unit_desig_8 {xpath('unit_desig_8')};
		string8 sec_range_8 {xpath('sec_range_8')};
		string25 v_city_name_8 {xpath('v_city_name_8')};
		string2 St_8 {xpath('st_8')};
		string5 Zip_8 {xpath('zip_8')};
		string4 Zip4_8 {xpath('zip4_8')};
		string rec_type_8 {xpath('rec_type_8')};
		string fips_state_8 {xpath('fips_state_8')};
		string fips_county_8 {xpath('fips_county_8')};
		string geo_lat_8 {xpath('geo_lat_8')};
		string geo_long_8 {xpath('geo_long_8')};
		string msa_8 {xpath('msa_8')};
		string geo_blk_8 {xpath('geo_blk_8')};
		string geo_match_8 {xpath('geo_match_8')};
		string err_stat_8 {xpath('err_stat_8')};		 		
	end;
END;	