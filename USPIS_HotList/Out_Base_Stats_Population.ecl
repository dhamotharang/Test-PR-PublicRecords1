import STRATA, TXBUS;

export Out_Base_Stats_Population(

	 string									pVersion
	,dataset(layouts.Base)	pBaseFile = Files().base.built

) := 
function

	dDataset := pBaseFile;

	Layout_pInput_stat :=
	record
		unsigned8 CountGroup                  		:= count(group);
		dDataset.state;
		unsigned8 dt_first_reported_CountNonBlank	:= sum(group, if(dDataset.Dt_First_Reported <> '',1,0));
		unsigned8 dt_last_reported_CountNonBlank	:= sum(group, if(dDataset.Dt_Last_Reported <> '',1,0));
		unsigned8 address_CountNonBlank       		:= sum(group, if(dDataset.ADDRESS <> '',1,0));
		unsigned8 suffix_CountNonBlank        		:= sum(group, if(dDataset.SUFFIX <> '',1,0));
		unsigned8 city_CountNonBlank          		:= sum(group, if(dDataset.CITY <> '',1,0));
		unsigned8 state_CountNonBlank         		:= sum(group, if(dDataset.STATE <> '',1,0));
		unsigned8 zip_code_CountNonBlank      		:= sum(group, if(dDataset.ZIP_CODE <> '',1,0));
		unsigned8 comments_CountNonBlank     		:= sum(group, if(dDataset.COMMENTS <> '',1,0));
		unsigned8 prim_range_CountNonBlank 			:= sum(group, if(dDataset.prim_range <>'',1,0));
		unsigned8 predir_CountNonBlank 				:= sum(group, if(dDataset.predir <>'',1,0));
		unsigned8 prim_name_CountNonBlank 			:= sum(group, if(dDataset.prim_name <>'',1,0));
		unsigned8 addr_suffix_CountNonBlank 		:= sum(group, if(dDataset.addr_suffix <>'',1,0));
		unsigned8 postdir_CountNonBlank 			:= sum(group, if(dDataset.postdir <>'',1,0));
		unsigned8 unit_desig_CountNonBlank 			:= sum(group, if(dDataset.unit_desig <>'',1,0));
		unsigned8 sec_range_CountNonBlank 			:= sum(group, if(dDataset.sec_range <>'',1,0));
		unsigned8 p_city_name_CountNonBlank 		:= sum(group, if(dDataset.p_city_name <>'',1,0));
		unsigned8 v_city_name_CountNonBlank 		:= sum(group, if(dDataset.v_city_name <>'',1,0));
		unsigned8 st_CountNonBlank 					:= sum(group, if(dDataset.st <>'',1,0));
		unsigned8 zip_CountNonBlank 				:= sum(group, if(dDataset.zip <>'',1,0));
		unsigned8 zip4_CountNonBlank 				:= sum(group, if(dDataset.zip4 <>'',1,0));
		unsigned8 cart_CountNonBlank 				:= sum(group, if(dDataset.cart <>'',1,0));
		unsigned8 cr_sort_sz_CountNonBlank 			:= sum(group, if(dDataset.cr_sort_sz <>'',1,0));
		unsigned8 lot_CountNonBlank 				:= sum(group, if(dDataset.lot <>'',1,0));
		unsigned8 lot_order_CountNonBlank 			:= sum(group, if(dDataset.lot_order <>'',1,0));
		unsigned8 dpbc_CountNonBlank 				:= sum(group, if(dDataset.dpbc <>'',1,0));
		unsigned8 chk_digit_CountNonBlank 			:= sum(group, if(dDataset.chk_digit <>'',1,0));
		unsigned8 record_type_CountNonBlank 		:= sum(group, if(dDataset.record_type <>'',1,0));
		unsigned8 county_CountNonBlank 				:= sum(group, if(dDataset.county <>'',1,0));
		unsigned8 geo_lat_CountNonBlank 			:= sum(group, if(dDataset.geo_lat <>'',1,0));
		unsigned8 geo_long_CountNonBlank 			:= sum(group, if(dDataset.geo_long <>'',1,0));
		unsigned8 msa_CountNonBlank 				:= sum(group, if(dDataset.msa <>'',1,0));
		unsigned8 geo_blk_CountNonBlank 			:= sum(group, if(dDataset.geo_blk <>'',1,0));
		unsigned8 geo_match_CountNonBlank 			:= sum(group, if(dDataset.geo_match <>'',1,0));
		unsigned8 err_stat_CountNonBlank 			:= sum(group, if(dDataset.err_stat <>'',1,0));
		unsigned8 raw_aid_CountNonZero      		:= sum(group, if(dDataset.raw_aid <> 0,1,0));
		unsigned8 ace_aid_CountNonZero      		:= sum(group, if(dDataset.ace_aid <> 0,1,0));																																					 
	end;                                                                           
																																								 
	dstat := table(dDataset, Layout_pInput_stat, state, few);                       
									
	sort_uspis_hotlist_base := sort(dstat, state);
	
	STRATA.createXMLStats(sort_uspis_hotlist_base
							 ,'USPIS_Hotlist'
							 ,'Base'
							 ,pVersion
							 ,Email_Notification_Lists.Stats
							 ,uspsis_result_base);
			
	return output(sort_uspis_hotlist_base);

end;
