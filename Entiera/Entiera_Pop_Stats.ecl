import STRATA;

export	Entiera_Pop_Stats(string pVersion)
 :=
	function

		pEntiera_base:=File_Entiera_Base;

		rPopulationStats_Entiera_base
		 :=
			record
				pEntiera_base.orig_state;
				CountGroup													:= count(group);
				orig_pmghousehold_id_CountNonBlank	:= sum(group,if(pEntiera_base.orig_pmghousehold_id<>'',1,0));
				orig_pmgindividual_id_CountNonBlank	:= sum(group,if(pEntiera_base.orig_pmgindividual_id<>'',1,0));
				orig_first_name_CountNonBlank				:= sum(group,if(pEntiera_base.orig_first_name<>'',1,0));
				orig_last_name_CountNonBlank				:= sum(group,if(pEntiera_base.orig_last_name<>'',1,0));
				orig_address_CountNonBlank					:= sum(group,if(pEntiera_base.orig_address<>'',1,0));
				orig_city_CountNonBlank							:= sum(group,if(pEntiera_base.orig_city<>'',1,0));
				orig_zip_CountNonBlank							:= sum(group,if(pEntiera_base.orig_zip<>'',1,0));
				orig_zip4_CountNonBlank							:= sum(group,if(pEntiera_base.orig_zip4<>'',1,0));
				orig_email_CountNonBlank						:= sum(group,if(pEntiera_base.orig_email<>'',1,0));
				orig_ip_CountNonBlank								:= sum(group,if(pEntiera_base.orig_ip<>'',1,0));
				orig_login_date_CountNonBlank				:= sum(group,if(pEntiera_base.orig_login_date<>'',1,0));
				orig_site_CountNonBlank							:= sum(group,if(pEntiera_base.orig_site<>'',1,0));
				orig_e360_id_CountNonBlank					:= sum(group,if(pEntiera_base.orig_e360_id<>'',1,0));
				orig_teramedia_id_CountNonBlank			:= sum(group,if(pEntiera_base.orig_teramedia_id<>'',1,0));
				did_CountNonZero										:= sum(group,if(pEntiera_base.did<>0,1,0));
				did_score_CountNonZero							:= sum(group,if(pEntiera_base.did_score<>0,1,0));
				title_CountNonBlank									:= sum(group,if(pEntiera_base.clean_name.title<>'',1,0));
				fname_CountNonBlank									:= sum(group,if(pEntiera_base.clean_name.fname<>'',1,0));
				mname_CountNonBlank									:= sum(group,if(pEntiera_base.clean_name.mname<>'',1,0));
				lname_CountNonBlank									:= sum(group,if(pEntiera_base.clean_name.lname<>'',1,0));
				name_suffix_CountNonBlank						:= sum(group,if(pEntiera_base.clean_name.name_suffix<>'',1,0));
				name_score_CountNonBlank						:= sum(group,if(pEntiera_base.clean_name.name_score<>'',1,0));
				prim_range_CountNonBlank						:= sum(group,if(pEntiera_base.clean_address.prim_range<>'',1,0));
				predir_CountNonBlank								:= sum(group,if(pEntiera_base.clean_address.predir<>'',1,0));
				prim_name_CountNonBlank							:= sum(group,if(pEntiera_base.clean_address.prim_name<>'',1,0));
				addr_suffix_CountNonBlank						:= sum(group,if(pEntiera_base.clean_address.addr_suffix<>'',1,0));
				postdir_CountNonBlank								:= sum(group,if(pEntiera_base.clean_address.postdir<>'',1,0));
				unit_desig_CountNonBlank						:= sum(group,if(pEntiera_base.clean_address.unit_desig<>'',1,0));
				sec_range_CountNonBlank							:= sum(group,if(pEntiera_base.clean_address.sec_range<>'',1,0));
				p_city_name_CountNonBlank						:= sum(group,if(pEntiera_base.clean_address.p_city_name<>'',1,0));
				v_city_name_CountNonBlank						:= sum(group,if(pEntiera_base.clean_address.v_city_name<>'',1,0));
				st_CountNonBlank										:= sum(group,if(pEntiera_base.clean_address.st<>'',1,0));
				zip_CountNonBlank										:= sum(group,if(pEntiera_base.clean_address.zip<>'',1,0));
				zip4_CountNonBlank									:= sum(group,if(pEntiera_base.clean_address.zip4<>'',1,0));
				cart_CountNonBlank									:= sum(group,if(pEntiera_base.clean_address.cart<>'',1,0));
				cr_sort_sz_CountNonBlank						:= sum(group,if(pEntiera_base.clean_address.cr_sort_sz<>'',1,0));
				lot_CountNonBlank										:= sum(group,if(pEntiera_base.clean_address.lot<>'',1,0));
				lot_order_CountNonBlank							:= sum(group,if(pEntiera_base.clean_address.lot_order<>'',1,0));
				dbpc_CountNonBlank									:= sum(group,if(pEntiera_base.clean_address.dbpc<>'',1,0));
				chk_digit_CountNonBlank							:= sum(group,if(pEntiera_base.clean_address.chk_digit<>'',1,0));
				rec_type_CountNonBlank							:= sum(group,if(pEntiera_base.clean_address.rec_type<>'',1,0));
				county_CountNonBlank								:= sum(group,if(pEntiera_base.clean_address.county<>'',1,0));
				geo_lat_CountNonBlank								:= sum(group,if(pEntiera_base.clean_address.geo_lat<>'',1,0));
				geo_long_CountNonBlank							:= sum(group,if(pEntiera_base.clean_address.geo_long<>'',1,0));
				msa_CountNonBlank										:= sum(group,if(pEntiera_base.clean_address.msa<>'',1,0));
				geo_blk_CountNonBlank								:= sum(group,if(pEntiera_base.clean_address.geo_blk<>'',1,0));
				geo_match_CountNonBlank							:= sum(group,if(pEntiera_base.clean_address.geo_match<>'',1,0));
				err_stat_CountNonBlank							:= sum(group,if(pEntiera_base.clean_address.err_stat<>'',1,0));
				best_ssn_CountNonBlank							:= sum(group,if(pEntiera_base.best_ssn<>'',1,0));
				best_dob_CountNonZero								:= sum(group,if(pEntiera_base.best_dob<>0,1,0));
				process_date_CountNonBlank					:= sum(group,if(pEntiera_base.process_date<>'',1,0));
			end
		 ;

		dPopulationStats_Entiera_base := table(pEntiera_base
																					,rPopulationStats_Entiera_base
																					,orig_state
																					,few);

		STRATA.createXMLStats(dPopulationStats_Entiera_base
							 ,'Email Addresses'
							 ,'Entiera Email Addresses'
							 ,pVersion
							 ,'jbello@seisint.com'
							 ,zEntiera_base);

		return	zEntiera_base;
	end
 ;