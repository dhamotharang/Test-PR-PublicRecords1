import marriage_divorce_v2,strata;
export Out_Base_Dev_Stats(string filedate) := function

ds_mar_div_base   := marriage_divorce_v2.file_mar_div_base;
ds_mar_div_search := marriage_divorce_v2.file_mar_div_search;


rPopulationStats_ds_mar_div_base :=
  record
    CountGroup 											:= count(group);
    dt_first_seen 									:= sum(group,if(ds_mar_div_base.dt_first_seen!=0,1,0));
    dt_last_seen 										:= sum(group,if(ds_mar_div_base.dt_last_seen!=0,1,0));
    dt_vendor_first_reported 				:= sum(group,if(ds_mar_div_base.dt_vendor_first_reported!=0,1,0));
    dt_vendor_last_reported 				:= sum(group,if(ds_mar_div_base.dt_vendor_last_reported!=0,1,0));
	  record_id 											:= sum(group,if(ds_mar_div_base.record_id!=0,1,0));
	  ds_mar_div_base.filing_type;		//									:= sum(group,if(ds_mar_div_base.filing_type<>'',1,0));
    filing_subtype									:= sum(group,if(ds_mar_div_base.filing_subtype<>'',1,0));
    ds_mar_div_base.vendor;													
    source_file										  := sum(group,if(ds_mar_div_base.source_file<>'',1,0));
    ds_mar_div_base.state_origin;										
		party1_type							  			:= sum(group,if(ds_mar_div_base.party1_type<>'',1,0));
		party1_name_format							:= sum(group,if(ds_mar_div_base.party1_name_format<>'',1,0)); 
		party1_name											:= sum(group,if(ds_mar_div_base.party1_name<>'',1,0));
		party1_alias										:= sum(group,if(ds_mar_div_base.party1_alias<>'',1,0));
		party1_dob											:= sum(group,if(ds_mar_div_base.party1_dob<>'',1,0));
		party1_birth_state							:= sum(group,if(ds_mar_div_base.party1_birth_state<>'',1,0));
		party1_age											:= sum(group,if(ds_mar_div_base.party1_age<>'',1,0));
		party1_race											:= sum(group,if(ds_mar_div_base.party1_race<>'',1,0));
		party1_addr1										:= sum(group,if(ds_mar_div_base.party1_addr1<>'',1,0));
		party1_csz											:= sum(group,if(ds_mar_div_base.party1_csz<>'',1,0));
		party1_county										:= sum(group,if(ds_mar_div_base.party1_county<>'',1,0));
		party1_previous_marital_status	:= sum(group,if(ds_mar_div_base.party1_previous_marital_status<>'',1,0));
		party1_how_marriage_ended				:= sum(group,if(ds_mar_div_base.party1_how_marriage_ended<>'',1,0));
		party1_times_married						:= sum(group,if(ds_mar_div_base.party1_times_married<>'',1,0));
		party1_last_marriage_end_dt			:= sum(group,if(ds_mar_div_base.party1_last_marriage_end_dt<>'',1,0)); 
		party2_type											:= sum(group,if(ds_mar_div_base.party2_type<>'',1,0));
		party2_name_format							:= sum(group,if(ds_mar_div_base.party2_name_format<>'',1,0));
		party2_name											:= sum(group,if(ds_mar_div_base.party2_name<>'',1,0));
		party2_alias										:= sum(group,if(ds_mar_div_base.party2_alias<>'',1,0));
		party2_dob											:= sum(group,if(ds_mar_div_base.party2_dob<>'',1,0));
		party2_birth_state							:= sum(group,if(ds_mar_div_base.party2_birth_state<>'',1,0));
		party2_age											:= sum(group,if(ds_mar_div_base.party2_age<>'',1,0));
		party2_race											:= sum(group,if(ds_mar_div_base.party2_race<>'',1,0));
		party2_addr1										:= sum(group,if(ds_mar_div_base.party2_addr1<>'',1,0));
		party2_csz											:= sum(group,if(ds_mar_div_base.party2_csz<>'',1,0));
		party2_county										:= sum(group,if(ds_mar_div_base.party2_county<>'',1,0));
		party2_previous_marital_status	:= sum(group,if(ds_mar_div_base.party2_previous_marital_status<>'',1,0));
		party2_how_marriage_ended				:= sum(group,if(ds_mar_div_base.party2_how_marriage_ended<>'',1,0));
		party2_times_married						:= sum(group,if(ds_mar_div_base.party2_times_married<>'',1,0));
		party2_last_marriage_end_dt			:= sum(group,if(ds_mar_div_base.party2_last_marriage_end_dt<>'',1,0));
		number_of_children							:= sum(group,if(ds_mar_div_base.number_of_children<>'',1,0));
		marriage_filing_dt							:= sum(group,if(ds_mar_div_base.marriage_filing_dt<>'',1,0));
		marriage_dt											:= sum(group,if(ds_mar_div_base.marriage_dt<>'',1,0));
		marriage_city										:= sum(group,if(ds_mar_div_base.marriage_city<>'',1,0));
		marriage_county									:= sum(group,if(ds_mar_div_base.marriage_county<>'',1,0));
		place_of_marriage								:= sum(group,if(ds_mar_div_base.place_of_marriage<>'',1,0));
		type_of_ceremony								:= sum(group,if(ds_mar_div_base.type_of_ceremony<>'',1,0));
		marriage_filing_number					:= sum(group,if(ds_mar_div_base.marriage_filing_number<>'',1,0)); 
		marriage_docket_volume					:= sum(group,if(ds_mar_div_base.marriage_docket_volume<>'',1,0));
		divorce_filing_dt								:= sum(group,if(ds_mar_div_base.divorce_filing_dt<>'',1,0));
		divorce_dt											:= sum(group,if(ds_mar_div_base.divorce_dt<>'',1,0));
		divorce_docket_volume						:= sum(group,if(ds_mar_div_base.divorce_docket_volume<>'',1,0));
		divorce_filing_number						:= sum(group,if(ds_mar_div_base.divorce_filing_number<>'',1,0));
		divorce_city										:= sum(group,if(ds_mar_div_base.divorce_city<>'',1,0));
		divorce_county									:= sum(group,if(ds_mar_div_base.divorce_county<>'',1,0));
		grounds_for_divorce							:= sum(group,if(ds_mar_div_base.grounds_for_divorce<>'',1,0));
		marriage_duration_cd						:= sum(group,if(ds_mar_div_base.marriage_duration_cd<>'',1,0));
		marriage_duration								:= sum(group,if(ds_mar_div_base.marriage_duration<>'',1,0)); 
	  

end;
  


rPopulationStats_ds_mar_div_search
 :=
  record
    CountGroup 									:= count(group);
    did													:= sum(group,if(ds_mar_div_search.did!=0,1,0));
    dt_first_seen								:= sum(group,if(ds_mar_div_search.dt_first_seen!=0,1,0));
    dt_last_seen								:= sum(group,if(ds_mar_div_search.dt_last_seen!=0,1,0));
    dt_vendor_first_reported		:= sum(group,if(ds_mar_div_search.dt_vendor_first_reported!=0,1,0));
    dt_vendor_last_reported			:= sum(group,if(ds_mar_div_search.dt_vendor_last_reported!=0,1,0));
    record_id										:= sum(group,if(ds_mar_div_search.record_id!=0,1,0));
		ds_mar_div_search.vendor;											
		party_type									:= sum(group,if(ds_mar_div_search.party_type<>'',1,0));
		which_party									:= sum(group,if(ds_mar_div_search.which_party<>'',1,0));
		name_sequence								:= sum(group,if(ds_mar_div_search.name_sequence<>'',1,0));  
		fname												:= sum(group,if(ds_mar_div_search.fname<>'',1,0));
		mname												:= sum(group,if(ds_mar_div_search.mname<>'',1,0));
		lname												:= sum(group,if(ds_mar_div_search.lname<>'',1,0));
		name_suffix									:= sum(group,if(ds_mar_div_search.name_suffix<>'0',1,0));
		nameasis_name_format				:= sum(group,if(ds_mar_div_search.nameasis_name_format<>'',1,0));
		nameasis										:= sum(group,if(ds_mar_div_search.nameasis<>'',1,0));
    prim_range									:= sum(group,if(ds_mar_div_search.prim_range<>'',1,0));
		predir											:= sum(group,if(ds_mar_div_search.predir<>'',1,0));
		prim_name										:= sum(group,if(ds_mar_div_search.prim_name<>'',1,0));
		suffix											:= sum(group,if(ds_mar_div_search.suffix<>'',1,0));
		postdir											:= sum(group,if(ds_mar_div_search.postdir<>'',1,0));
		unit_desig									:= sum(group,if(ds_mar_div_search.unit_desig<>'',1,0));
		sec_range										:= sum(group,if(ds_mar_div_search.sec_range<>'',1,0));
		p_city_name									:= sum(group,if(ds_mar_div_search.p_city_name<>'',1,0));
		v_city_name									:= sum(group,if(ds_mar_div_search.v_city_name<>'',1,0));
		st													:= sum(group,if(ds_mar_div_search.st<>'',1,0));
		zip													:= sum(group,if(ds_mar_div_search.zip<>'',1,0));
		zip4												:= sum(group,if(ds_mar_div_search.zip4<>'',1,0));
		cart												:= sum(group,if(ds_mar_div_search.cart<>'',1,0));
		cr_sort_sz									:= sum(group,if(ds_mar_div_search.cr_sort_sz<>'',1,0));
		lot													:= sum(group,if(ds_mar_div_search.lot<>'',1,0));
		lot_order										:= sum(group,if(ds_mar_div_search.lot_order<>'',1,0));
		dbpc												:= sum(group,if(ds_mar_div_search.dbpc<>'',1,0));
		chk_digit										:= sum(group,if(ds_mar_div_search.chk_digit<>'',1,0));
		rec_type										:= sum(group,if(ds_mar_div_search.rec_type<>'',1,0));
		county											:= sum(group,if(ds_mar_div_search.county<>'',1,0));
		geo_lat											:= sum(group,if(ds_mar_div_search.geo_lat	<>'',1,0));
		geo_long										:= sum(group,if(ds_mar_div_search.geo_long<>'',1,0));
		msa													:= sum(group,if(ds_mar_div_search.msa<>'',1,0));
		geo_blk											:= sum(group,if(ds_mar_div_search.geo_blk<>'',1,0));
		geo_match										:= sum(group,if(ds_mar_div_search.geo_match<>'',1,0));
		err_stat										:= sum(group,if(ds_mar_div_search.err_stat<>'',1,0)); 
	 	 
end;

tStats_mar_div_base   := table(ds_mar_div_base,  rPopulationStats_ds_mar_div_base,  state_origin,vendor,filing_type,few);
tStats_mar_div_search := table(ds_mar_div_search,rPopulationStats_ds_mar_div_search,vendor,few);

yOrig_Stats_mar_div_base   :=     output(choosen(tStats_mar_div_base,  all));
yOrig_Stats_mar_div_search :=     output(choosen(tStats_mar_div_search,all));


STRATA.createXMLStats(tStats_mar_div_base,  'Marriage_Divorce_v2','Base',      filedate,'khumayun@seisint.com',zOrig_Stats_mar_div_base,  'View','Population')
STRATA.createXMLStats(tStats_mar_div_search,'Marriage_Divorce_v2','Search',    filedate,'khumayun@seisint.com',zOrig_Stats_mar_div_search,'View','Population')

return parallel( yOrig_Stats_mar_div_base
																			 ,yOrig_Stats_mar_div_search
																			 ,zOrig_Stats_mar_div_base
																			 ,zOrig_Stats_mar_div_search
																		 );
										
									
end;
