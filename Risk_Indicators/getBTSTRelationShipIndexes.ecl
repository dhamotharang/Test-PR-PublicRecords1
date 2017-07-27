IMPORT ut, models, Risk_Indicators;
/* This will be called from the BTST boca shell. 
*/
EXPORT getBTSTRelationShipIndexes (GROUPED DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
			Layout_Debug := RECORD
				REAL rel_st_addr_is_bt_business_addr_w ;
				REAL rel_btst_economic_trajectory_w ;
				REAL rel_btst_cbd_ids_per_bt_id_ct_w ;
				REAL rel_btst_st_bip_addr_ct_w;
				REAL rel_btst_overlap_mths_w  ;
				real rel_btst_any_lname_match_w ;
				real rel_btst_curr_lname_match_w ;
				real rel_btst_personal_association_w ;
				REAL rel_btst_addrs_in_common_w ;
				REAL rel_btst_phones_in_common_w  ;
				REAL rel_btst_cellphones_in_common_w ;
				REAL rel_btst_emails_in_common_w ;
				REAL rel_bt_addr_st_inq_cnt_w  ;
				REAL rel_st_phone_bt_inq_cnt_w ;
				REAL rel_st_addr_bt_inq_cnt_w ;
				REAL rel_st_addr_bt_inq_collection_cnt_w;
				REAL rel_bt_phone_st_inq_retail_cnt_w ;
				REAL rel_st_addr_bt_inq_retail_cnt_w ;
				real rel_final_score ;
				real base  ;
				real pts  ;
				real lgt  ;
				real offset ;
				real rel_score0   ;
				INTEGER btst_relationship_index_v1 ;
				INTEGER btst_relationship_index_v2 ;

				Risk_Indicators.Layout_BocaShell_BtSt_Out clam;
			END;
			Layout_Debug doModel( clam le) := TRANSFORM
	#else
			Risk_Indicators.Layout_BocaShell_BtSt.RelationShipModel doModel( clam le) := TRANSFORM
	#end
		
		/* ***********************************************************
		 *             Model Input Variable Assignments              *
		 ************************************************************* */
			truedid                           := le.Bill_To_Out.truedid;
			did                           		:= le.Bill_To_Out.did;	
			truedid_s                         := le.Ship_To_Out.truedid;
			did_s                       			:= le.Ship_To_Out.did;
			st_addr_is_bt_business_addr 			:= le.st_addr_is_bt_business_addr;
			btst_economic_trajectory   				:= le.btst_economic_trajectory;
			btst_cbd_ids_per_bt_id_ct  				:= le.btst_cbd_ids_per_bt_id_ct;
			btst_st_bip_addr_ct        				:= le.btst_st_bip_addr_ct;
			btst_overlap_mths          				:= le.btst_overlap_mths;
			btst_any_lname_match       				:= le.btst_any_lname_match;
			btst_curr_lname_match      				:= le.btst_curr_lname_match;
			btst_personal_association  				:= le.btst_personal_association;
			btst_addrs_in_common       				:= le.btst_addrs_in_common;
			btst_phones_in_common      				:= le.btst_phones_in_common;
			btst_cellphones_in_common  				:= le.btst_cellphones_in_common;
			btst_emails_in_common      				:= le.btst_emails_in_common;
			bt_addr_st_inq_cnt  			 				:= le.bt_addr_found_on_st_inq_count;
			bt_phone_st_inq_Collection_cnt 		:= le.bt_phone_found_on_st_inq_Collection_count;
			bt_phone_st_inq_Retail_cnt 				:= le.bt_phone_found_on_st_inq_Retail_count;
			st_phone_bt_inq_cnt 							:= le.st_phone_found_on_bt_inq_count;
			st_addr_bt_inq_cnt   			 				:= le.st_addr_found_on_bt_inq_count;
			st_addr_bt_inq_Collection_cnt 		:= le.st_addr_found_on_bt_inq_Collection_count;
			st_addr_bt_inq_Retail_cnt  				:= le.st_addr_found_on_bt_inq_Retail_count;
			
		/* ***********************************************************
		 *             Model code            *
		 ************************************************************* */
		 
			NULL := -999999999;

			rel_st_addr_is_bt_business_addr_w := map(
					st_addr_is_bt_business_addr = NULL => 0.00000,
					st_addr_is_bt_business_addr <= 0.5 => 0.08870,
																								-1.34257);

			rel_btst_economic_trajectory_w := map(
					btst_economic_trajectory = NULL => 0.00000,
					btst_economic_trajectory <= 9.5 => 0.11493,
																						 -0.15304);

			rel_btst_cbd_ids_per_bt_id_ct_w := map(
					btst_cbd_ids_per_bt_id_ct = NULL => 0.00000,
					btst_cbd_ids_per_bt_id_ct = -1   => 0.02195,
																							-0.41388);

			rel_btst_st_bip_addr_ct_w := map(
					btst_st_bip_addr_ct = NULL => 0.00000,
					btst_st_bip_addr_ct <= 0.5 => 0.45518,
					btst_st_bip_addr_ct <= 1.5 => -0.38885,
					btst_st_bip_addr_ct <= 3.5 => -0.45725,
					btst_st_bip_addr_ct <= 9.5 => -0.58079,
																				-0.72206);

			rel_btst_overlap_mths_w := map(
					btst_overlap_mths = NULL   => 0.00000,
					btst_overlap_mths <= 24    => 0.17191,
					btst_overlap_mths <= 83    => -0.53442,
					btst_overlap_mths <= 121.5 => -0.71322,
					btst_overlap_mths <= 170.5 => -0.86438,
					btst_overlap_mths <= 250.5 => -0.96800,
																				-1.41944);

			rel_btst_any_lname_match_w := map(
					btst_any_lname_match = false => 0.15405,
																				 -1.02504);

			rel_btst_curr_lname_match_w := map(
					btst_curr_lname_match = false => 0.09698,
																					-1.00086);

			rel_btst_personal_association_w := map(
					btst_personal_association = false=> 0.18490,
																						-0.89869);

			rel_btst_addrs_in_common_w := map(
					btst_addrs_in_common = NULL => 0.00000,
					btst_addrs_in_common <= 0.5 => 0.18219,
																				 -0.88113);

			rel_btst_phones_in_common_w := map(
					btst_phones_in_common = NULL => 0.00000,
					btst_phones_in_common <= 0.5 => 0.10817,
					btst_phones_in_common <= 2.5 => -0.75686,
																					-1.14889);

			rel_btst_cellphones_in_common_w := map(
					btst_cellphones_in_common = NULL => 0.00000,
					btst_cellphones_in_common <= 0.5 => 0.08369,
																							-0.74025);

			rel_btst_emails_in_common_w := map(
					btst_emails_in_common = NULL => 0.00000,
					btst_emails_in_common <= 0.5 => 0.06258,
																					-1.33941);

			rel_bt_addr_st_inq_cnt_w := map(
					bt_addr_st_inq_cnt = NULL => 0.00000,
					bt_addr_st_inq_cnt <= 0.5 => 0.09558,
																			 -1.00218);

			rel_st_phone_bt_inq_cnt_w := map(
					st_phone_bt_inq_cnt = NULL  => 0.00000,
					st_phone_bt_inq_cnt <= 1.5  => 0.02414,
					st_phone_bt_inq_cnt <= 3.5  => -0.55137,
					st_phone_bt_inq_cnt <= 4.5  => -0.85349,
					st_phone_bt_inq_cnt <= 8.5  => -0.63872,
					st_phone_bt_inq_cnt <= 12.5 => -0.37844,
					st_phone_bt_inq_cnt <= 35.5 => 0.16264,
																				 1.21891);

			rel_st_addr_bt_inq_cnt_w := map(
					st_addr_bt_inq_cnt = NULL => 0.00000,
					st_addr_bt_inq_cnt <= 0.5 => 0.11306,
					st_addr_bt_inq_cnt <= 1.5 => -0.91198,
																			 -1.27399);

			rel_st_addr_bt_inq_collection_cnt_w := map(
					st_addr_bt_inq_collection_cnt = NULL => 0.00000,
					st_addr_bt_inq_collection_cnt <= 0.5 => 0.03033,
																									-1.37825);

			rel_bt_phone_st_inq_retail_cnt_w := map(
					bt_phone_st_inq_retail_cnt = NULL => 0.00000,
					bt_phone_st_inq_retail_cnt <= 0.5 => 0.02983,
																							 -0.78290);

			rel_st_addr_bt_inq_retail_cnt_w := map(
					st_addr_bt_inq_retail_cnt = NULL => 0.00000,
					st_addr_bt_inq_retail_cnt <= 0.5 => 0.05422,
					st_addr_bt_inq_retail_cnt <= 1.5 => -1.17627,
																							-1.42148);

			rel_final_score := -1.97319061261528 +
					rel_st_addr_is_bt_business_addr_w * 0.177609670021983 +
					rel_btst_economic_trajectory_w * 0.246401025731492 +
					rel_btst_cbd_ids_per_bt_id_ct_w * 0.886697820227598 +
					rel_btst_st_bip_addr_ct_w * 1.22639506901677 +
					rel_btst_overlap_mths_w * 0.0514550181507379 +
					rel_btst_any_lname_match_w * 0.26767513511957 +
					rel_btst_curr_lname_match_w * 0.0260778570866957 +
					rel_btst_personal_association_w * 0.325261252673261 +
					rel_btst_addrs_in_common_w * 0.290090453931757 +
					rel_btst_phones_in_common_w * 0.0970742553705686 +
					rel_btst_cellphones_in_common_w * 0.089163048062099 +
					rel_btst_emails_in_common_w * 0.561302414411773 +
					rel_bt_addr_st_inq_cnt_w * 0.20853361292315 +
					rel_st_phone_bt_inq_cnt_w * 0.755230553773399 +
					rel_st_addr_bt_inq_cnt_w * 0.240890386796881 +
					rel_st_addr_bt_inq_collection_cnt_w * 0.0279823335368041 +
					rel_bt_phone_st_inq_retail_cnt_w * 0.193902091289881 +
					rel_st_addr_bt_inq_retail_cnt_w * 0.0935606239428468;

			base := 700;

			pts := -40;

			lgt := ln(1 / 99);

			offset := 2.187174;

			rel_score0 := base + pts * (rel_final_score - offset - lgt);

			btst_relationship_index_v1 := if(not(truedid and (boolean)(integer)truedid_s) and 
				did != did_s and did != 0 and did_s != 0, -1, 
				round(min(if(max(rel_score0, (real)301) = NULL, -NULL, max(rel_score0, (real)301)), 999)));

			btst_relationship_index_v2 := map(
					not(truedid and (boolean)(integer)truedid_s) and did != did_s and did != 0 and did_s != 0 => -1,
					-1 * rel_final_score <= 1.0556230                                                         => 1,
					-1 * rel_final_score <= 1.3596646                                                         => 2,
					-1 * rel_final_score <= 2.0907463                                                         => 3,
					-1 * rel_final_score <= 2.1567730                                                         => 4,
					-1 * rel_final_score <= 2.2406597                                                         => 5,
					-1 * rel_final_score <= 2.3992060                                                         => 6,
					-1 * rel_final_score <= 2.6271090                                                         => 7,
					-1 * rel_final_score <= 3.2896790                                                         => 8,
																																																	 9);
		/* ***********************************************************
		 *             Model Output Variable Assignments              *
		 ************************************************************* */
		 
		#if(MODEL_DEBUG)
				self.rel_st_addr_is_bt_business_addr_w := rel_st_addr_is_bt_business_addr_w;
				self.rel_btst_economic_trajectory_w   := rel_btst_economic_trajectory_w;
				self.rel_btst_cbd_ids_per_bt_id_ct_w  := rel_btst_cbd_ids_per_bt_id_ct_w;
				self.rel_btst_st_bip_addr_ct_w        := rel_btst_st_bip_addr_ct_w;
				self.rel_btst_overlap_mths_w          := rel_btst_overlap_mths_w;
				self.rel_btst_any_lname_match_w       := rel_btst_any_lname_match_w;
				self.rel_btst_curr_lname_match_w      := rel_btst_curr_lname_match_w;
				self.rel_btst_personal_association_w  := rel_btst_personal_association_w;
				self.rel_btst_addrs_in_common_w       := rel_btst_addrs_in_common_w;
				self.rel_btst_phones_in_common_w      := rel_btst_phones_in_common_w;
				self.rel_btst_cellphones_in_common_w  := rel_btst_cellphones_in_common_w;
				self.rel_btst_emails_in_common_w      := rel_btst_emails_in_common_w;
				self.rel_bt_addr_st_inq_cnt_w         := rel_bt_addr_st_inq_cnt_w;
				self.rel_st_phone_bt_inq_cnt_w        := rel_st_phone_bt_inq_cnt_w;
				self.rel_st_addr_bt_inq_cnt_w         := rel_st_addr_bt_inq_cnt_w;
				self.rel_st_addr_bt_inq_collection_cnt_w := rel_st_addr_bt_inq_collection_cnt_w;
				self.rel_bt_phone_st_inq_retail_cnt_w := rel_bt_phone_st_inq_retail_cnt_w;
				self.rel_st_addr_bt_inq_retail_cnt_w  := rel_st_addr_bt_inq_retail_cnt_w;
				self.rel_final_score                  := rel_final_score;
				self.base                             := base;
				self.pts                              := pts;
				self.lgt                              := lgt;
				self.offset                           := offset;
				self.rel_score0                       := rel_score0;
				self.btst_relationship_index_v1       := btst_relationship_index_v1;
				self.btst_relationship_index_v2       := btst_relationship_index_v2;
				self.clam.Bill_To_Out									:= le.Bill_to_out;
				self.clam.Ship_To_Out									:= le.Ship_To_Out;	
				self.clam.eddo												:= le.eddo;	
				self.clam.ip2o												:= le.ip2o;
				self.clam.isShipToBillToDifferent			:= le.isShipToBillToDifferent;
				self.clam 														:= le;
		#else
			self.seq 																:= le.Bill_To_Out.seq;
			self.btst_relationship_index_v1    			:= btst_relationship_index_v1;
			self.btst_relationship_index_v2       	:= btst_relationship_index_v2;
		#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);

END;





