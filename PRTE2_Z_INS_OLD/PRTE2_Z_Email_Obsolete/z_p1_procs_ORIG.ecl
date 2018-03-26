//TODO - almost sure we do not need statistics and strata

EXPORT z_p1_procs_ORIG := MODULE
		// --------------------------------------------------------------
		// --------------------------------------------------------------
		// -- Don't think we need to bother will calling this in CT -----
		// --------------------------------------------------------------
		EXPORT build_strata(STRING version) := FUNCTION
			IMPORT STRATA;
			
			basefile:= _files.Phase1_Output_File;
			
			layout_strata:=RECORD
				basefile.clean_st;
				CountGroup:=COUNT(GROUP);
				fname_CountNonBlank							 					:= SUM(GROUP,IF(basefile.fname<>'',1,0));
				lname_CountNonBlank							 					:= SUM(GROUP,IF(basefile.lname<>'',1,0));
				address_CountNonBlank							 				:= SUM(GROUP,IF(basefile.address<>'',1,0));
				city_CountNonBlank				 								:= SUM(GROUP,IF(basefile.city<>'',1,0));
				state_CountNonBlank				 								:= SUM(GROUP,IF(basefile.state<>'',1,0));
				zip_CountNonBlank				 									:= SUM(GROUP,IF(basefile.zip<>'',1,0));
				phone_CountNonBlank				 								:= SUM(GROUP,IF(basefile.phone<>'',1,0));
				email_CountNonBlank				 								:= SUM(GROUP,IF(basefile.email<>'',1,0));
				source_CountNonBlank				 							:= SUM(GROUP,IF(basefile.source<>'',1,0));
				ip_CountNonBlank				 									:= SUM(GROUP,IF(basefile.ip<>'',1,0));
				date_time_CountNonBlank				 						:= SUM(GROUP,IF(basefile.date_time<>'',1,0));
				gender_CountNonBlank				 							:= SUM(GROUP,IF(basefile.gender<>'',1,0));
				dob_CountNonBlank				 									:= SUM(GROUP,IF(basefile.dob<>'',1,0));
				nonincentivized_opt_in_CountNonBlank			:= SUM(GROUP,IF(basefile.nonincentivized_opt_in<>'',1,0));
				incentivized_opt_in_CountNonBlank					:= SUM(GROUP,IF(basefile.incentivized_opt_in<>'',1,0));
				did_CountNonBlank				 									:= SUM(GROUP,IF(basefile.did>0,1,0));
				did_score_CountNonBlank				 						:= SUM(GROUP,IF(basefile.did_score>0,1,0));
				aid_CountNonBlank								 					:= SUM(GROUP,IF(basefile.aid>0,1,0));
				clean_title_CountNonBlank				 					:= SUM(GROUP,IF(basefile.clean_title<>'',1,0));
				clean_fname_CountNonBlank				 					:= SUM(GROUP,IF(basefile.clean_fname<>'',1,0));
				clean_mname_CountNonBlank				 					:= SUM(GROUP,IF(basefile.clean_mname<>'',1,0));
				clean_lname_CountNonBlank				 					:= SUM(GROUP,IF(basefile.clean_lname<>'',1,0));
				clean_name_suffix_CountNonBlank				 		:= SUM(GROUP,IF(basefile.clean_name_suffix<>'',1,0));
				clean_name_score_CountNonBlank				 		:= SUM(GROUP,IF(basefile.clean_name_score<>'',1,0));
				clean_prim_range_CountNonBlank				 		:= SUM(GROUP,IF(basefile.clean_prim_range<>'',1,0));
				clean_predir_CountNonBlank				 				:= SUM(GROUP,IF(basefile.clean_predir<>'',1,0));
				clean_prim_name_CountNonBlank				 			:= SUM(GROUP,IF(basefile.clean_prim_name<>'',1,0));
				clean_addr_suffix_CountNonBlank				 		:= SUM(GROUP,IF(basefile.clean_addr_suffix<>'',1,0));
				clean_postdir_CountNonBlank				 				:= SUM(GROUP,IF(basefile.clean_postdir<>'',1,0));
				clean_unit_desig_CountNonBlank				 		:= SUM(GROUP,IF(basefile.clean_unit_desig<>'',1,0));
				clean_sec_range_CountNonBlank				 			:= SUM(GROUP,IF(basefile.clean_sec_range<>'',1,0));
				clean_p_city_name_CountNonBlank				 		:= SUM(GROUP,IF(basefile.clean_p_city_name<>'',1,0));
				clean_v_city_name_CountNonBlank				 		:= SUM(GROUP,IF(basefile.clean_v_city_name<>'',1,0));
				clean_zip_CountNonBlank				 						:= SUM(GROUP,IF(basefile.clean_zip<>'',1,0));
				clean_zip4_CountNonBlank						 			:= SUM(GROUP,IF(basefile.clean_zip4<>'',1,0));
				clean_cart_CountNonBlank						 			:= SUM(GROUP,IF(basefile.clean_cart<>'',1,0));
				clean_cr_sort_sz_CountNonBlank				 		:= SUM(GROUP,IF(basefile.clean_cr_sort_sz<>'',1,0));
				clean_lot_CountNonBlank				 						:= SUM(GROUP,IF(basefile.clean_lot<>'',1,0));
				clean_lot_order_CountNonBlank				 			:= SUM(GROUP,IF(basefile.clean_lot_order<>'',1,0));
				clean_dbpc_CountNonBlank				 					:= SUM(GROUP,IF(basefile.clean_dbpc<>'',1,0));
				clean_chk_digit_CountNonBlank				 			:= SUM(GROUP,IF(basefile.clean_chk_digit<>'',1,0));
				clean_rec_type_CountNonBlank				 			:= SUM(GROUP,IF(basefile.clean_rec_type<>'',1,0));
				clean_county_CountNonBlank				 				:= SUM(GROUP,IF(basefile.clean_county<>'',1,0));
				clean_geo_lat_CountNonBlank				 				:= SUM(GROUP,IF(basefile.clean_geo_lat<>'',1,0));
				clean_geo_long_CountNonBlank				 			:= SUM(GROUP,IF(basefile.clean_geo_long<>'',1,0));
				clean_msa_CountNonBlank				 						:= SUM(GROUP,IF(basefile.clean_msa<>'',1,0));
				clean_geo_blk_CountNonBlank				 				:= SUM(GROUP,IF(basefile.clean_geo_blk<>'',1,0));
				clean_geo_match_CountNonBlank				 			:= SUM(GROUP,IF(basefile.clean_geo_match<>'',1,0));
				clean_err_stat_CountNonBlank				 			:= SUM(GROUP,IF(basefile.clean_err_stat<>'',1,0));
				date_first_seen_CountNonBlank				 			:= SUM(GROUP,IF(basefile.date_first_seen<>'',1,0));
				date_last_seen_CountNonBlank				 			:= SUM(GROUP,IF(basefile.date_last_seen<>'',1,0));
				date_vendor_first_reported_CountNonBlank	:= SUM(GROUP,IF(basefile.date_vendor_first_reported<>'',1,0));
				date_vendor_last_reported_CountNonBlank		:= SUM(GROUP,IF(basefile.date_vendor_last_reported<>'',1,0));
			END;
			
			basestrata:=SORT(TABLE(basefile,layout_strata),clean_st);
			strata.createXMLStats(basestrata,'PRTE2_Email stats','data',version,'',strataResults);
			
			RETURN strataResults;
		END;

END;
