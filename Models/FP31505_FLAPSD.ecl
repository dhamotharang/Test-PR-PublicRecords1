Import Models;

export FP31505_FLAPSD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

Models.Layout_FP31505 doScore(allVars le) := TRANSFORM

// *** The first section of code simply maps all of the fields from the 'allVars' record to the exact variable name that 
//     the Modeler's code uses...this is to avoid having to make any modifications to the Modeler's code...

seqa                          		:= le.seqa                          	;
sysdate                          	:= le.sysdate                          	;
pii_profile_n                    	:= le.pii_profile_n                    	;
r_nas_ssn_verd_d                 	:= le.r_nas_ssn_verd_d                 	;
r_nas_addr_verd_d                	:= le.r_nas_addr_verd_d                	;
r_nas_lname_verd_d               	:= le.r_nas_lname_verd_d               	;
r_nas_fname_verd_d               	:= le.r_nas_fname_verd_d               	;
r_nas_nothing_found_i            	:= le.r_nas_nothing_found_i            	;
r_nas_contradictory_i            	:= le.r_nas_contradictory_i            	;
r_f00_nas_ssn_no_addr_verd_i     	:= le.r_f00_nas_ssn_no_addr_verd_i     	;
k_nap_phn_verd_d                 	:= le.k_nap_phn_verd_d                 	;
k_nap_addr_verd_d                	:= le.k_nap_addr_verd_d                	;
k_nap_lname_verd_d               	:= le.k_nap_lname_verd_d               	;
k_nap_fname_verd_d               	:= le.k_nap_fname_verd_d               	;
k_nap_nothing_found_i            	:= le.k_nap_nothing_found_i            	;
k_nap_contradictory_i            	:= le.k_nap_contradictory_i            	;
k_inf_phn_verd_d                 	:= le.k_inf_phn_verd_d                 	;
k_inf_addr_verd_d                	:= le.k_inf_addr_verd_d                	;
k_inf_lname_verd_d               	:= le.k_inf_lname_verd_d               	;
k_inf_fname_verd_d               	:= le.k_inf_fname_verd_d               	;
k_inf_nothing_found_i            	:= le.k_inf_nothing_found_i            	;
k_inf_contradictory_i            	:= le.k_inf_contradictory_i            	;
r_s65_ssn_prior_dob_i            	:= le.r_s65_ssn_prior_dob_i            	;
r_s65_ssn_invalid_i              	:= le.r_s65_ssn_invalid_i              	;
r_c16_inv_ssn_per_adl_i          	:= le.r_c16_inv_ssn_per_adl_i          	;
r_c16_inv_ssn_per_adl_c6_i       	:= le.r_c16_inv_ssn_per_adl_c6_i       	;
r_f00_addr_not_ver_w_ssn_i       	:= le.r_f00_addr_not_ver_w_ssn_i       	;
r_s65_ssn_problem_i              	:= le.r_s65_ssn_problem_i              	;
r_p88_phn_dst_to_inp_add_i       	:= le.r_p88_phn_dst_to_inp_add_i       	;
r_l70_zip_not_issued_i           	:= le.r_l70_zip_not_issued_i           	;
r_p85_phn_not_issued_i           	:= le.r_p85_phn_not_issued_i           	;
r_p85_phn_disconnected_i         	:= le.r_p85_phn_disconnected_i         	;
r_p85_phn_invalid_i              	:= le.r_p85_phn_invalid_i              	;
r_p85_phn_hirisk_i               	:= le.r_p85_phn_hirisk_i               	;
r_phn_cell_n                     	:= le.r_phn_cell_n                     	;
r_p86_phn_pager_i                	:= le.r_p86_phn_pager_i                	;
r_phn_pcs_n                      	:= le.r_phn_pcs_n                      	;
r_p86_phn_pay_phone_i            	:= le.r_p86_phn_pay_phone_i            	;
r_p86_phn_fax_i                  	:= le.r_p86_phn_fax_i                  	;
r_p87_phn_corrections_i          	:= le.r_p87_phn_corrections_i          	;
r_c17_inv_phn_per_adl_i          	:= le.r_c17_inv_phn_per_adl_i          	;
r_l77_add_po_box_i               	:= le.r_l77_add_po_box_i               	;
r_l70_add_invalid_i              	:= le.r_l70_add_invalid_i              	;
r_l71_add_hirisk_comm_i          	:= le.r_l71_add_hirisk_comm_i          	;
r_l71_add_corp_zip_i             	:= le.r_l71_add_corp_zip_i             	;
r_l72_add_vacant_i               	:= le.r_l72_add_vacant_i               	;
r_l74_add_throwback_i            	:= le.r_l74_add_throwback_i            	;
r_l75_add_drop_delivery_i        	:= le.r_l75_add_drop_delivery_i        	;
r_l76_add_seasonal_i             	:= le.r_l76_add_seasonal_i             	;
r_l71_add_business_i             	:= le.r_l71_add_business_i             	;
r_l70_add_standardized_i         	:= le.r_l70_add_standardized_i         	;
r_l70_inp_addr_dnd_i             	:= le.r_l70_inp_addr_dnd_i             	;
r_l71_add_curr_hirisk_comm_i     	:= le.r_l71_add_curr_hirisk_comm_i     	;
r_l72_add_curr_vacant_i          	:= le.r_l72_add_curr_vacant_i          	;
r_l74_add_curr_throwback_i       	:= le.r_l74_add_curr_throwback_i       	;
r_l75_add_curr_drop_delivery_i   	:= le.r_l75_add_curr_drop_delivery_i   	;
r_l76_add_curr_seasonal_i        	:= le.r_l76_add_curr_seasonal_i        	;
r_l71_add_curr_business_i        	:= le.r_l71_add_curr_business_i        	;
r_f03_input_add_not_most_rec_i   	:= le.r_f03_input_add_not_most_rec_i   	;
r_c18_inv_add_per_adl_c6_i       	:= le.r_c18_inv_add_per_adl_c6_i       	;
r_c19_add_prison_hist_i          	:= le.r_c19_add_prison_hist_i          	;
r_l77_apartment_i                	:= le.r_l77_apartment_i                	;
r_f00_ssn_score_d                	:= le.r_f00_ssn_score_d                	;
r_f00_dob_score_d                	:= le.r_f00_dob_score_d                	;
r_f01_inp_addr_address_score_d   	:= le.r_f01_inp_addr_address_score_d   	;
r_l70_inp_addr_dirty_i           	:= le.r_l70_inp_addr_dirty_i           	;
r_f00_input_dob_match_level_d    	:= le.r_f00_input_dob_match_level_d    	;
r_d30_derog_count_i              	:= le.r_d30_derog_count_i              	;
r_d32_criminal_count_i           	:= le.r_d32_criminal_count_i           	;
r_d32_felony_count_i             	:= le.r_d32_felony_count_i             	;
r_d32_mos_since_crim_ls_d        	:= le.r_d32_mos_since_crim_ls_d        	;
r_d32_mos_since_fel_ls_d         	:= le.r_d32_mos_since_fel_ls_d         	;
r_d31_mostrec_bk_i               	:= le.r_d31_mostrec_bk_i               	;
r_d31_attr_bankruptcy_recency_d  	:= le.r_d31_attr_bankruptcy_recency_d  	;
r_d31_bk_filing_count_i          	:= le.r_d31_bk_filing_count_i          	;
r_d31_bk_disposed_recent_count_i 	:= le.r_d31_bk_disposed_recent_count_i 	;
r_d31_bk_disposed_hist_count_i   	:= le.r_d31_bk_disposed_hist_count_i   	;
r_d33_eviction_recency_d         	:= le.r_d33_eviction_recency_d         	;
r_d33_eviction_count_i           	:= le.r_d33_eviction_count_i           	;
r_d34_unrel_liens_ct_i           	:= le.r_d34_unrel_liens_ct_i           	;
r_d34_unrel_lien60_count_i       	:= le.r_d34_unrel_lien60_count_i       	;
r_c21_m_bureau_adl_fs_d          	:= le.r_c21_m_bureau_adl_fs_d          	;
f_m_bureau_adl_fs_all_d          	:= le.f_m_bureau_adl_fs_all_d          	;
f_m_bureau_adl_fs_notu_d         	:= le.f_m_bureau_adl_fs_notu_d         	;
r_c10_m_hdr_fs_d                 	:= le.r_c10_m_hdr_fs_d                 	;
r_c12_nonderog_recency_i         	:= le.r_c12_nonderog_recency_i         	;
r_c12_num_nonderogs_d            	:= le.r_c12_num_nonderogs_d            	;
r_c15_ssns_per_adl_i             	:= le.r_c15_ssns_per_adl_i             	;
r_c15_ssns_per_adl_c6_i          	:= le.r_c15_ssns_per_adl_c6_i          	;
r_s66_adlperssn_count_i          	:= le.r_s66_adlperssn_count_i          	;
k_comb_age_d                     	:= le.k_comb_age_d                     	;
r_f03_address_match_d            	:= le.r_f03_address_match_d            	;
r_a48_inp_addr_conv_mortgage_d   	:= le.r_a48_inp_addr_conv_mortgage_d   	;
r_a44_curr_add_naprop_d          	:= le.r_a44_curr_add_naprop_d          	;
r_a48_curr_addr_conv_mortg_d     	:= le.r_a48_curr_addr_conv_mortg_d     	;
r_l80_inp_avm_autoval_d          	:= le.r_l80_inp_avm_autoval_d          	;
r_a46_curr_avm_autoval_d         	:= le.r_a46_curr_avm_autoval_d         	;
r_a49_curr_avm_chg_1yr_i         	:= le.r_a49_curr_avm_chg_1yr_i         	;
r_a49_curr_avm_chg_1yr_pct_i     	:= le.r_a49_curr_avm_chg_1yr_pct_i     	;
r_c13_curr_addr_lres_d           	:= le.r_c13_curr_addr_lres_d           	;
r_c14_addr_stability_v2_d        	:= le.r_c14_addr_stability_v2_d        	;
r_c13_max_lres_d                 	:= le.r_c13_max_lres_d                 	;
r_add_curr_pop_i                 	:= le.r_add_curr_pop_i                 	;
r_c14_addrs_5yr_i                	:= le.r_c14_addrs_5yr_i                	;
r_c14_addrs_10yr_i               	:= le.r_c14_addrs_10yr_i               	;
r_c14_addrs_per_adl_c6_i         	:= le.r_c14_addrs_per_adl_c6_i         	;
r_c14_addrs_15yr_i               	:= le.r_c14_addrs_15yr_i               	;
r_a41_prop_owner_d               	:= le.r_a41_prop_owner_d               	;
r_a41_prop_owner_inp_only_d      	:= le.r_a41_prop_owner_inp_only_d      	;
r_prop_owner_history_d           	:= le.r_prop_owner_history_d           	;
r_a43_aircraft_cnt_d             	:= le.r_a43_aircraft_cnt_d             	;
r_a43_watercraft_cnt_d           	:= le.r_a43_watercraft_cnt_d           	;
r_ever_asset_owner_d             	:= le.r_ever_asset_owner_d             	;
r_c20_email_count_i              	:= le.r_c20_email_count_i              	;
r_c20_email_domain_free_count_i  	:= le.r_c20_email_domain_free_count_i  	;
r_c20_email_domain_isp_count_i   	:= le.r_c20_email_domain_isp_count_i   	;
r_e57_prof_license_flag_d        	:= le.r_e57_prof_license_flag_d        	;
r_l79_adls_per_addr_curr_i       	:= le.r_l79_adls_per_addr_curr_i       	;
r_l79_adls_per_addr_c6_i         	:= le.r_l79_adls_per_addr_c6_i         	;
r_c18_invalid_addrs_per_adl_i    	:= le.r_c18_invalid_addrs_per_adl_i    	;
r_has_pb_record_d                	:= le.r_has_pb_record_d                	;
r_a50_pb_average_dollars_d       	:= le.r_a50_pb_average_dollars_d       	;
r_a50_pb_total_dollars_d         	:= le.r_a50_pb_total_dollars_d         	;
r_a50_pb_total_orders_d          	:= le.r_a50_pb_total_orders_d          	;
r_pb_order_freq_d                	:= le.r_pb_order_freq_d                	;
r_l78_no_phone_at_addr_vel_i     	:= le.r_l78_no_phone_at_addr_vel_i     	;
r_i60_inq_count12_i              	:= le.r_i60_inq_count12_i              	;
r_i60_credit_seeking_i           	:= le.r_i60_credit_seeking_i           	;
r_i60_inq_recency_d              	:= le.r_i60_inq_recency_d              	;
r_i61_inq_collection_count12_i   	:= le.r_i61_inq_collection_count12_i   	;
r_i61_inq_collection_recency_d   	:= le.r_i61_inq_collection_recency_d   	;
r_i60_inq_auto_count12_i         	:= le.r_i60_inq_auto_count12_i         	;
r_i60_inq_auto_recency_d         	:= le.r_i60_inq_auto_recency_d         	;
r_i60_inq_banking_count12_i      	:= le.r_i60_inq_banking_count12_i      	;
r_i60_inq_banking_recency_d      	:= le.r_i60_inq_banking_recency_d      	;
r_i60_inq_mortgage_count12_i     	:= le.r_i60_inq_mortgage_count12_i     	;
r_i60_inq_mortgage_recency_d     	:= le.r_i60_inq_mortgage_recency_d     	;
r_i60_inq_hiriskcred_count12_i   	:= le.r_i60_inq_hiriskcred_count12_i   	;
r_i60_inq_hiriskcred_recency_d   	:= le.r_i60_inq_hiriskcred_recency_d   	;
r_i60_inq_retail_count12_i       	:= le.r_i60_inq_retail_count12_i       	;
r_i60_inq_retail_recency_d       	:= le.r_i60_inq_retail_recency_d       	;
r_i60_inq_comm_count12_i         	:= le.r_i60_inq_comm_count12_i         	;
r_i60_inq_comm_recency_d         	:= le.r_i60_inq_comm_recency_d         	;
f_bus_addr_match_count_d         	:= le.f_bus_addr_match_count_d         	;
f_bus_fname_verd_d               	:= le.f_bus_fname_verd_d               	;
f_bus_lname_verd_d               	:= le.f_bus_lname_verd_d               	;
f_bus_name_nover_i               	:= le.f_bus_name_nover_i               	;
f_bus_ssn_match_d                	:= le.f_bus_ssn_match_d                	;
f_bus_phone_match_d              	:= le.f_bus_phone_match_d              	;
f_adl_util_inf_n                 	:= le.f_adl_util_inf_n                 	;
f_adl_util_conv_n                	:= le.f_adl_util_conv_n                	;
f_adl_util_misc_n                	:= le.f_adl_util_misc_n                	;
f_util_adl_count_n               	:= le.f_util_adl_count_n               	;
f_util_add_input_inf_n           	:= le.f_util_add_input_inf_n           	;
f_util_add_input_conv_n          	:= le.f_util_add_input_conv_n          	;
f_util_add_input_misc_n          	:= le.f_util_add_input_misc_n          	;
f_util_add_curr_inf_n            	:= le.f_util_add_curr_inf_n            	;
f_util_add_curr_conv_n           	:= le.f_util_add_curr_conv_n           	;
f_util_add_curr_misc_n           	:= le.f_util_add_curr_misc_n           	;
f_add_input_has_occ_1yr_d        	:= le.f_add_input_has_occ_1yr_d        	;
f_add_input_mobility_index_i     	:= le.f_add_input_mobility_index_i     	;
f_add_input_has_bus_ct_i         	:= le.f_add_input_has_bus_ct_i         	;
f_add_input_nhood_bus_pct_i      	:= le.f_add_input_nhood_bus_pct_i      	;
f_add_input_has_mfd_ct_i         	:= le.f_add_input_has_mfd_ct_i         	;
f_add_input_nhood_mfd_pct_i      	:= le.f_add_input_nhood_mfd_pct_i      	;
f_add_input_has_sfd_ct_d         	:= le.f_add_input_has_sfd_ct_d         	;
f_add_input_nhood_sfd_pct_d      	:= le.f_add_input_nhood_sfd_pct_d      	;
f_add_input_has_vac_ct_i         	:= le.f_add_input_has_vac_ct_i         	;
f_add_input_nhood_vac_pct_i      	:= le.f_add_input_nhood_vac_pct_i      	;
f_add_curr_has_occ_1yr_d         	:= le.f_add_curr_has_occ_1yr_d         	;
f_add_curr_mobility_index_i      	:= le.f_add_curr_mobility_index_i      	;
f_add_curr_has_bus_ct_i          	:= le.f_add_curr_has_bus_ct_i          	;
f_add_curr_nhood_bus_pct_i       	:= le.f_add_curr_nhood_bus_pct_i       	;
f_add_curr_has_mfd_ct_i          	:= le.f_add_curr_has_mfd_ct_i          	;
f_add_curr_nhood_mfd_pct_i       	:= le.f_add_curr_nhood_mfd_pct_i       	;
f_add_curr_has_sfd_ct_d          	:= le.f_add_curr_has_sfd_ct_d          	;
f_add_curr_nhood_sfd_pct_d       	:= le.f_add_curr_nhood_sfd_pct_d       	;
f_add_curr_has_vac_ct_i          	:= le.f_add_curr_has_vac_ct_i          	;
f_add_curr_nhood_vac_pct_i       	:= le.f_add_curr_nhood_vac_pct_i       	;
f_recent_disconnects_i           	:= le.f_recent_disconnects_i           	;
f_inq_count_i                    	:= le.f_inq_count_i                    	;
f_inq_count24_i                  	:= le.f_inq_count24_i                  	;
f_inq_auto_count_i               	:= le.f_inq_auto_count_i               	;
f_inq_auto_count24_i             	:= le.f_inq_auto_count24_i             	;
f_inq_banking_count_i            	:= le.f_inq_banking_count_i            	;
f_inq_banking_count24_i          	:= le.f_inq_banking_count24_i          	;
f_inq_collection_count_i         	:= le.f_inq_collection_count_i         	;
f_inq_collection_count24_i       	:= le.f_inq_collection_count24_i       	;
f_inq_communications_count_i     	:= le.f_inq_communications_count_i     	;
f_inq_communications_count24_i   	:= le.f_inq_communications_count24_i   	;
f_inq_highriskcredit_count_i     	:= le.f_inq_highriskcredit_count_i     	;
f_inq_highriskcredit_count24_i   	:= le.f_inq_highriskcredit_count24_i   	;
f_inq_mortgage_count_i           	:= le.f_inq_mortgage_count_i           	;
f_inq_mortgage_count24_i         	:= le.f_inq_mortgage_count24_i         	;
f_inq_other_count_i              	:= le.f_inq_other_count_i              	;
f_inq_other_count24_i            	:= le.f_inq_other_count24_i            	;
f_inq_retail_count_i             	:= le.f_inq_retail_count_i             	;
f_inq_retail_count24_i           	:= le.f_inq_retail_count24_i           	;
k_inq_per_ssn_i                  	:= le.k_inq_per_ssn_i                  	;
k_inq_adls_per_ssn_i             	:= le.k_inq_adls_per_ssn_i             	;
k_inq_lnames_per_ssn_i           	:= le.k_inq_lnames_per_ssn_i           	;
k_inq_addrs_per_ssn_i            	:= le.k_inq_addrs_per_ssn_i            	;
k_inq_dobs_per_ssn_i             	:= le.k_inq_dobs_per_ssn_i             	;
k_inq_per_addr_i                 	:= le.k_inq_per_addr_i                 	;
k_inq_adls_per_addr_i            	:= le.k_inq_adls_per_addr_i            	;
k_inq_lnames_per_addr_i          	:= le.k_inq_lnames_per_addr_i          	;
k_inq_ssns_per_addr_i            	:= le.k_inq_ssns_per_addr_i            	;
k_inq_per_phone_i                	:= le.k_inq_per_phone_i                	;
k_inq_adls_per_phone_i           	:= le.k_inq_adls_per_phone_i           	;
f_mos_inq_banko_am_fseen_d       	:= le.f_mos_inq_banko_am_fseen_d       	;
f_mos_inq_banko_am_lseen_d       	:= le.f_mos_inq_banko_am_lseen_d       	;
f_mos_inq_banko_cm_fseen_d       	:= le.f_mos_inq_banko_cm_fseen_d       	;
f_mos_inq_banko_cm_lseen_d       	:= le.f_mos_inq_banko_cm_lseen_d       	;
f_mos_inq_banko_om_fseen_d       	:= le.f_mos_inq_banko_om_fseen_d       	;
f_mos_inq_banko_om_lseen_d       	:= le.f_mos_inq_banko_om_lseen_d       	;
f_attr_arrests_i                 	:= le.f_attr_arrests_i                 	;
f_attr_arrest_recency_d          	:= le.f_attr_arrest_recency_d          	;
f_mos_liens_unrel_cj_fseen_d     	:= le.f_mos_liens_unrel_cj_fseen_d     	;
f_mos_liens_unrel_cj_lseen_d     	:= le.f_mos_liens_unrel_cj_lseen_d     	;
f_liens_unrel_cj_total_amt_i     	:= le.f_liens_unrel_cj_total_amt_i     	;
f_mos_liens_rel_cj_fseen_d       	:= le.f_mos_liens_rel_cj_fseen_d       	;
f_mos_liens_rel_cj_lseen_d       	:= le.f_mos_liens_rel_cj_lseen_d       	;
f_liens_rel_cj_total_amt_i       	:= le.f_liens_rel_cj_total_amt_i       	;
f_mos_liens_unrel_ft_fseen_d     	:= le.f_mos_liens_unrel_ft_fseen_d     	;
f_mos_liens_unrel_ft_lseen_d     	:= le.f_mos_liens_unrel_ft_lseen_d     	;
f_liens_unrel_ft_total_amt_i     	:= le.f_liens_unrel_ft_total_amt_i     	;
f_mos_liens_rel_ft_fseen_d       	:= le.f_mos_liens_rel_ft_fseen_d       	;
f_mos_liens_rel_ft_lseen_d       	:= le.f_mos_liens_rel_ft_lseen_d       	;
f_liens_rel_ft_total_amt_i       	:= le.f_liens_rel_ft_total_amt_i       	;
f_mos_liens_unrel_fc_fseen_d     	:= le.f_mos_liens_unrel_fc_fseen_d     	;
f_mos_liens_unrel_fc_lseen_d     	:= le.f_mos_liens_unrel_fc_lseen_d     	;
f_liens_unrel_fc_total_amt_i     	:= le.f_liens_unrel_fc_total_amt_i     	;
f_mos_liens_rel_fc_fseen_d       	:= le.f_mos_liens_rel_fc_fseen_d       	;
f_mos_liens_rel_fc_lseen_d       	:= le.f_mos_liens_rel_fc_lseen_d       	;
f_liens_rel_fc_total_amt_i       	:= le.f_liens_rel_fc_total_amt_i       	;
f_mos_liens_unrel_lt_fseen_d     	:= le.f_mos_liens_unrel_lt_fseen_d     	;
f_mos_liens_unrel_lt_lseen_d     	:= le.f_mos_liens_unrel_lt_lseen_d     	;
f_mos_liens_rel_lt_fseen_d       	:= le.f_mos_liens_rel_lt_fseen_d       	;
f_mos_liens_rel_lt_lseen_d       	:= le.f_mos_liens_rel_lt_lseen_d       	;
f_mos_liens_unrel_o_fseen_d      	:= le.f_mos_liens_unrel_o_fseen_d      	;
f_mos_liens_unrel_o_lseen_d      	:= le.f_mos_liens_unrel_o_lseen_d      	;
f_liens_unrel_o_total_amt_i      	:= le.f_liens_unrel_o_total_amt_i      	;
f_mos_liens_rel_o_fseen_d        	:= le.f_mos_liens_rel_o_fseen_d        	;
f_mos_liens_rel_o_lseen_d        	:= le.f_mos_liens_rel_o_lseen_d        	;
f_liens_rel_o_total_amt_i        	:= le.f_liens_rel_o_total_amt_i        	;
f_mos_liens_unrel_ot_fseen_d     	:= le.f_mos_liens_unrel_ot_fseen_d     	;
f_mos_liens_unrel_ot_lseen_d     	:= le.f_mos_liens_unrel_ot_lseen_d     	;
f_liens_unrel_ot_total_amt_i     	:= le.f_liens_unrel_ot_total_amt_i     	;
f_mos_liens_rel_ot_fseen_d       	:= le.f_mos_liens_rel_ot_fseen_d       	;
f_mos_liens_rel_ot_lseen_d       	:= le.f_mos_liens_rel_ot_lseen_d       	;
f_liens_rel_ot_total_amt_i       	:= le.f_liens_rel_ot_total_amt_i       	;
f_mos_liens_unrel_sc_fseen_d     	:= le.f_mos_liens_unrel_sc_fseen_d     	;
f_mos_liens_unrel_sc_lseen_d     	:= le.f_mos_liens_unrel_sc_lseen_d     	;
f_liens_unrel_sc_total_amt_i     	:= le.f_liens_unrel_sc_total_amt_i     	;
f_foreclosure_flag_i             	:= le.f_foreclosure_flag_i             	;
f_mos_foreclosure_lseen_d        	:= le.f_mos_foreclosure_lseen_d        	;
k_estimated_income_d             	:= le.k_estimated_income_d             	;
r_wealth_index_d                 	:= le.r_wealth_index_d                 	;
f_college_income_d               	:= le.f_college_income_d               	;
f_has_relatives_n                	:= le.f_has_relatives_n                	;
f_rel_count_i                    	:= le.f_rel_count_i                    	;
f_rel_incomeover25_count_d       	:= le.f_rel_incomeover25_count_d       	;
f_rel_incomeover50_count_d       	:= le.f_rel_incomeover50_count_d       	;
f_rel_incomeover75_count_d       	:= le.f_rel_incomeover75_count_d       	;
f_rel_incomeover100_count_d      	:= le.f_rel_incomeover100_count_d      	;
f_rel_homeover50_count_d         	:= le.f_rel_homeover50_count_d         	;
f_rel_homeover100_count_d        	:= le.f_rel_homeover100_count_d        	;
f_rel_homeover150_count_d        	:= le.f_rel_homeover150_count_d        	;
f_rel_homeover200_count_d        	:= le.f_rel_homeover200_count_d        	;
f_rel_homeover300_count_d        	:= le.f_rel_homeover300_count_d        	;
f_rel_homeover500_count_d        	:= le.f_rel_homeover500_count_d        	;
f_rel_ageover20_count_d          	:= le.f_rel_ageover20_count_d          	;
f_rel_ageover30_count_d          	:= le.f_rel_ageover30_count_d          	;
f_rel_ageover40_count_d          	:= le.f_rel_ageover40_count_d          	;
f_rel_ageover50_count_d          	:= le.f_rel_ageover50_count_d          	;
f_rel_ageover60_count_d          	:= le.f_rel_ageover60_count_d          	;
f_rel_educationover8_count_d     	:= le.f_rel_educationover8_count_d     	;
f_rel_educationover12_count_d    	:= le.f_rel_educationover12_count_d    	;
f_crim_rel_under25miles_cnt_i    	:= le.f_crim_rel_under25miles_cnt_i    	;
f_crim_rel_under100miles_cnt_i   	:= le.f_crim_rel_under100miles_cnt_i   	;
f_crim_rel_under500miles_cnt_i   	:= le.f_crim_rel_under500miles_cnt_i   	;
f_rel_under25miles_cnt_d         	:= le.f_rel_under25miles_cnt_d         	;
f_rel_under100miles_cnt_d        	:= le.f_rel_under100miles_cnt_d        	;
f_rel_under500miles_cnt_d        	:= le.f_rel_under500miles_cnt_d        	;
f_rel_bankrupt_count_i           	:= le.f_rel_bankrupt_count_i           	;
f_rel_criminal_count_i           	:= le.f_rel_criminal_count_i           	;
f_rel_felony_count_i             	:= le.f_rel_felony_count_i             	;
f_current_count_d                	:= le.f_current_count_d                	;
f_historical_count_d             	:= le.f_historical_count_d             	;
f_accident_count_i               	:= le.f_accident_count_i               	;
f_acc_damage_amt_total_i         	:= le.f_acc_damage_amt_total_i         	;
f_mos_acc_lseen_d                	:= le.f_mos_acc_lseen_d                	;
f_acc_damage_amt_last_i          	:= le.f_acc_damage_amt_last_i          	;
f_acc_damage_amt_last_1mo_i      	:= le.f_acc_damage_amt_last_1mo_i      	;
f_acc_damage_amt_last_3mos_i     	:= le.f_acc_damage_amt_last_3mos_i     	;
f_acc_damage_amt_last_6mos_i     	:= le.f_acc_damage_amt_last_6mos_i     	;
f_accident_recency_d             	:= le.f_accident_recency_d             	;
f_idrisktype_i                   	:= le.f_idrisktype_i                   	;
f_idverrisktype_i                	:= le.f_idverrisktype_i                	;
f_sourcerisktype_i               	:= le.f_sourcerisktype_i               	;
f_varrisktype_i                  	:= le.f_varrisktype_i                  	;
f_varmsrcssncount_i              	:= le.f_varmsrcssncount_i              	;
f_varmsrcssnunrelcount_i         	:= le.f_varmsrcssnunrelcount_i         	;
f_vardobcount_i                  	:= le.f_vardobcount_i                  	;
f_vardobcountnew_i               	:= le.f_vardobcountnew_i               	;
f_srchvelocityrisktype_i         	:= le.f_srchvelocityrisktype_i         	;
f_srchcountwk_i                  	:= le.f_srchcountwk_i                  	;
f_srchcountday_i                 	:= le.f_srchcountday_i                 	;
f_srchunvrfdssncount_i           	:= le.f_srchunvrfdssncount_i           	;
f_srchunvrfdaddrcount_i          	:= le.f_srchunvrfdaddrcount_i          	;
f_srchunvrfddobcount_i           	:= le.f_srchunvrfddobcount_i           	;
f_srchunvrfdphonecount_i         	:= le.f_srchunvrfdphonecount_i         	;
f_srchfraudsrchcount_i           	:= le.f_srchfraudsrchcount_i           	;
f_srchfraudsrchcountyr_i         	:= le.f_srchfraudsrchcountyr_i         	;
f_srchfraudsrchcountmo_i         	:= le.f_srchfraudsrchcountmo_i         	;
f_srchfraudsrchcountwk_i         	:= le.f_srchfraudsrchcountwk_i         	;
f_srchfraudsrchcountday_i        	:= le.f_srchfraudsrchcountday_i        	;
f_srchlocatesrchcountwk_i        	:= le.f_srchlocatesrchcountwk_i        	;
f_srchlocatesrchcountday_i       	:= le.f_srchlocatesrchcountday_i       	;
f_assocrisktype_i                	:= le.f_assocrisktype_i                	;
f_assocsuspicousidcount_i        	:= le.f_assocsuspicousidcount_i        	;
f_assoccredbureaucount_i         	:= le.f_assoccredbureaucount_i         	;
f_assoccredbureaucountnew_i      	:= le.f_assoccredbureaucountnew_i      	;
f_assoccredbureaucountmo_i       	:= le.f_assoccredbureaucountmo_i       	;
f_validationrisktype_i           	:= le.f_validationrisktype_i           	;
f_corrrisktype_i                 	:= le.f_corrrisktype_i                 	;
f_corrssnnamecount_d             	:= le.f_corrssnnamecount_d             	;
f_corrssnaddrcount_d             	:= le.f_corrssnaddrcount_d             	;
f_corraddrnamecount_d            	:= le.f_corraddrnamecount_d            	;
f_corraddrphonecount_d           	:= le.f_corraddrphonecount_d           	;
f_corrphonelastnamecount_d       	:= le.f_corrphonelastnamecount_d       	;
f_divrisktype_i                  	:= le.f_divrisktype_i                  	;
f_divssnidmsrcurelcount_i        	:= le.f_divssnidmsrcurelcount_i        	;
f_divaddrsuspidcountnew_i        	:= le.f_divaddrsuspidcountnew_i        	;
f_divsrchaddrsuspidcount_i       	:= le.f_divsrchaddrsuspidcount_i       	;
f_srchcomponentrisktype_i        	:= le.f_srchcomponentrisktype_i        	;
f_srchssnsrchcount_i             	:= le.f_srchssnsrchcount_i             	;
f_srchssnsrchcountmo_i           	:= le.f_srchssnsrchcountmo_i           	;
f_srchssnsrchcountwk_i           	:= le.f_srchssnsrchcountwk_i           	;
f_srchssnsrchcountday_i          	:= le.f_srchssnsrchcountday_i          	;
f_srchaddrsrchcount_i            	:= le.f_srchaddrsrchcount_i            	;
f_srchaddrsrchcountmo_i          	:= le.f_srchaddrsrchcountmo_i          	;
f_srchaddrsrchcountwk_i          	:= le.f_srchaddrsrchcountwk_i          	;
f_srchaddrsrchcountday_i         	:= le.f_srchaddrsrchcountday_i         	;
f_srchphonesrchcount_i           	:= le.f_srchphonesrchcount_i           	;
f_srchphonesrchcountmo_i         	:= le.f_srchphonesrchcountmo_i         	;
f_srchphonesrchcountwk_i         	:= le.f_srchphonesrchcountwk_i         	;
f_srchphonesrchcountday_i        	:= le.f_srchphonesrchcountday_i        	;
f_componentcharrisktype_i        	:= le.f_componentcharrisktype_i        	;
f_inputaddractivephonelist_d     	:= le.f_inputaddractivephonelist_d     	;
f_addrchangeincomediff_d         	:= le.f_addrchangeincomediff_d         	;
f_addrchangevaluediff_d          	:= le.f_addrchangevaluediff_d          	;
f_addrchangecrimediff_i          	:= le.f_addrchangecrimediff_i          	;
f_addrchangeecontrajindex_d      	:= le.f_addrchangeecontrajindex_d      	;
f_curraddractivephonelist_d      	:= le.f_curraddractivephonelist_d      	;
f_curraddrmedianincome_d         	:= le.f_curraddrmedianincome_d         	;
f_curraddrmedianvalue_d          	:= le.f_curraddrmedianvalue_d          	;
f_curraddrmurderindex_i          	:= le.f_curraddrmurderindex_i          	;
f_curraddrcartheftindex_i        	:= le.f_curraddrcartheftindex_i        	;
f_curraddrburglaryindex_i        	:= le.f_curraddrburglaryindex_i        	;
f_curraddrcrimeindex_i           	:= le.f_curraddrcrimeindex_i           	;
f_prevaddrageoldest_d            	:= le.f_prevaddrageoldest_d            	;
f_prevaddrlenofres_d             	:= le.f_prevaddrlenofres_d             	;
f_prevaddrdwelltype_apt_n        	:= le.f_prevaddrdwelltype_apt_n        	;
f_prevaddrdwelltype_sfd_n        	:= le.f_prevaddrdwelltype_sfd_n        	;
f_prevaddrstatus_i               	:= le.f_prevaddrstatus_i               	;
f_prevaddroccupantowned_i        	:= le.f_prevaddroccupantowned_i        	;
f_prevaddrmedianincome_d         	:= le.f_prevaddrmedianincome_d         	;
f_prevaddrmedianvalue_d          	:= le.f_prevaddrmedianvalue_d          	;
f_prevaddrmurderindex_i          	:= le.f_prevaddrmurderindex_i          	;
f_prevaddrcartheftindex_i        	:= le.f_prevaddrcartheftindex_i        	;
f_fp_prevaddrburglaryindex_i     	:= le.f_fp_prevaddrburglaryindex_i     	;
f_fp_prevaddrcrimeindex_i        	:= le.f_fp_prevaddrcrimeindex_i        	;
r_s65_ssn_deceased_i             	:= le.r_s65_ssn_deceased_i             	;
r_d31_all_bk_i                   	:= le.r_d31_all_bk_i                   	;
r_d31_bk_chapter_n               	:= le.r_d31_bk_chapter_n               	;
r_d31_bk_dism_recent_count_i     	:= le.r_d31_bk_dism_recent_count_i     	;
r_d31_bk_dism_hist_count_i       	:= le.r_d31_bk_dism_hist_count_i       	;
r_c22_stl_inq_count90_i          	:= le.r_c22_stl_inq_count90_i          	;
r_c22_stl_inq_count180_i         	:= le.r_c22_stl_inq_count180_i         	;
r_c22_stl_inq_count12_i          	:= le.r_c22_stl_inq_count12_i          	;
r_c22_stl_inq_count24_i          	:= le.r_c22_stl_inq_count24_i          	;
r_c22_stl_recency_d              	:= le.r_c22_stl_recency_d              	;
r_c12_source_profile_d           	:= le.r_c12_source_profile_d           	;
r_c12_source_profile_index_d     	:= le.r_c12_source_profile_index_d     	;
r_f01_inp_addr_not_verified_i    	:= le.r_f01_inp_addr_not_verified_i    	;
r_c23_inp_addr_occ_index_d       	:= le.r_c23_inp_addr_occ_index_d       	;
r_c23_inp_addr_owned_not_occ_d   	:= le.r_c23_inp_addr_owned_not_occ_d   	;
r_f04_curr_add_occ_index_d       	:= le.r_f04_curr_add_occ_index_d       	;
r_e55_college_ind_d              	:= le.r_e55_college_ind_d              	;
r_e57_br_source_count_d          	:= le.r_e57_br_source_count_d          	;
r_i60_inq_prepaidcards_count12_i 	:= le.r_i60_inq_prepaidcards_count12_i 	;
r_i60_inq_prepaidcards_recency_d 	:= le.r_i60_inq_prepaidcards_recency_d 	;
r_i60_inq_retpymt_count12_i      	:= le.r_i60_inq_retpymt_count12_i      	;
r_i60_inq_retpymt_recency_d      	:= le.r_i60_inq_retpymt_recency_d      	;
r_i60_inq_stdloan_count12_i      	:= le.r_i60_inq_stdloan_count12_i      	;
r_i60_inq_stdloan_recency_d      	:= le.r_i60_inq_stdloan_recency_d      	;
r_i60_inq_util_count12_i         	:= le.r_i60_inq_util_count12_i         	;
r_i60_inq_util_recency_d         	:= le.r_i60_inq_util_recency_d         	;
f_phone_ver_insurance_d          	:= le.f_phone_ver_insurance_d          	;
f_phone_ver_experian_d           	:= le.f_phone_ver_experian_d           	;
f_addrs_per_ssn_i                	:= le.f_addrs_per_ssn_i                	;
f_phones_per_addr_curr_i         	:= le.f_phones_per_addr_curr_i         	;
f_addrs_per_ssn_c6_i             	:= le.f_addrs_per_ssn_c6_i             	;
f_phones_per_addr_c6_i           	:= le.f_phones_per_addr_c6_i           	;
f_adls_per_phone_c6_i            	:= le.f_adls_per_phone_c6_i            	;
f_dl_addrs_per_adl_i             	:= le.f_dl_addrs_per_adl_i             	;
f_inq_email_ver_count_i          	:= le.f_inq_email_ver_count_i          	;
f_inq_count_day_i                	:= le.f_inq_count_day_i                	;
f_inq_count_week_i               	:= le.f_inq_count_week_i               	;
f_inq_auto_count_day_i           	:= le.f_inq_auto_count_day_i           	;
f_inq_auto_count_week_i          	:= le.f_inq_auto_count_week_i          	;
f_inq_banking_count_day_i        	:= le.f_inq_banking_count_day_i        	;
f_inq_banking_count_week_i       	:= le.f_inq_banking_count_week_i       	;
f_inq_collection_count_day_i     	:= le.f_inq_collection_count_day_i     	;
f_inq_collection_count_week_i    	:= le.f_inq_collection_count_week_i    	;
f_inq_communications_cnt_day_i   	:= le.f_inq_communications_cnt_day_i   	;
f_inq_communications_cnt_week_i  	:= le.f_inq_communications_cnt_week_i  	;
f_inq_highriskcredit_cnt_day_i   	:= le.f_inq_highriskcredit_cnt_day_i   	;
f_inq_highriskcredit_cnt_week_i  	:= le.f_inq_highriskcredit_cnt_week_i  	;
f_inq_mortgage_count_day_i       	:= le.f_inq_mortgage_count_day_i       	;
f_inq_mortgage_count_week_i      	:= le.f_inq_mortgage_count_week_i      	;
f_inq_other_count_day_i          	:= le.f_inq_other_count_day_i          	;
f_inq_other_count_week_i         	:= le.f_inq_other_count_week_i         	;
f_inq_prepaidcards_count_i       	:= le.f_inq_prepaidcards_count_i       	;
f_inq_prepaidcards_count_day_i   	:= le.f_inq_prepaidcards_count_day_i   	;
f_inq_prepaidcards_count_week_i  	:= le.f_inq_prepaidcards_count_week_i  	;
f_inq_prepaidcards_count24_i     	:= le.f_inq_prepaidcards_count24_i     	;
f_inq_quizprovider_count_i       	:= le.f_inq_quizprovider_count_i       	;
f_inq_quizprovider_count_day_i   	:= le.f_inq_quizprovider_count_day_i   	;
f_inq_quizprovider_count_week_i  	:= le.f_inq_quizprovider_count_week_i  	;
f_inq_quizprovider_count24_i     	:= le.f_inq_quizprovider_count24_i     	;
f_inq_retail_count_day_i         	:= le.f_inq_retail_count_day_i         	;
f_inq_retail_count_week_i        	:= le.f_inq_retail_count_week_i        	;
f_inq_retailpayments_cnt_i       	:= le.f_inq_retailpayments_cnt_i       	;
f_inq_retailpayments_cnt_day_i   	:= le.f_inq_retailpayments_cnt_day_i   	;
f_inq_retailpayments_cnt_week_i  	:= le.f_inq_retailpayments_cnt_week_i  	;
f_inq_retailpayments_count24_i   	:= le.f_inq_retailpayments_count24_i   	;
f_inq_studentloan_count_i        	:= le.f_inq_studentloan_count_i        	;
f_inq_studentloan_count_day_i    	:= le.f_inq_studentloan_count_day_i    	;
f_inq_studentloan_count_week_i   	:= le.f_inq_studentloan_count_week_i   	;
f_inq_studentloan_count24_i      	:= le.f_inq_studentloan_count24_i      	;
f_inq_utilities_count_i          	:= le.f_inq_utilities_count_i          	;
f_inq_utilities_count_day_i      	:= le.f_inq_utilities_count_day_i      	;
f_inq_utilities_count_week_i     	:= le.f_inq_utilities_count_week_i     	;
f_inq_utilities_count24_i        	:= le.f_inq_utilities_count24_i        	;
f_inq_billgrp_count_i            	:= le.f_inq_billgrp_count_i            	;
f_inq_billgrp_count24_i          	:= le.f_inq_billgrp_count24_i          	;
f_inq_email_per_adl_i            	:= le.f_inq_email_per_adl_i            	;
f_inq_adls_per_email_i           	:= le.f_inq_adls_per_email_i           	;
f_nae_email_verd_d               	:= le.f_nae_email_verd_d               	;
f_nae_addr_verd_d                	:= le.f_nae_addr_verd_d                	;
f_nae_lname_verd_d               	:= le.f_nae_lname_verd_d               	;
f_nae_fname_verd_d               	:= le.f_nae_fname_verd_d               	;
f_nae_nothing_found_i            	:= le.f_nae_nothing_found_i            	;
f_nae_contradictory_i            	:= le.f_nae_contradictory_i            	;
f_adl_per_email_i                	:= le.f_adl_per_email_i                	;
r_c20_email_verification_d       	:= le.r_c20_email_verification_d       	;
f_vf_hi_risk_ct_i                	:= le.f_vf_hi_risk_ct_i                	;
f_vf_lo_risk_ct_d                	:= le.f_vf_lo_risk_ct_d                	;
f_vf_lexid_phn_hi_risk_ct_i      	:= le.f_vf_lexid_phn_hi_risk_ct_i      	;
f_vf_lexid_phn_lo_risk_ct_d      	:= le.f_vf_lexid_phn_lo_risk_ct_d      	;
f_vf_altlexid_phn_hi_risk_ct_i   	:= le.f_vf_altlexid_phn_hi_risk_ct_i   	;
f_vf_altlexid_phn_lo_risk_ct_d   	:= le.f_vf_altlexid_phn_lo_risk_ct_d   	;
f_vf_lexid_addr_hi_risk_ct_i     	:= le.f_vf_lexid_addr_hi_risk_ct_i     	;
f_vf_lexid_addr_lo_risk_ct_d     	:= le.f_vf_lexid_addr_lo_risk_ct_d     	;
f_vf_altlexid_addr_hi_risk_ct_i  	:= le.f_vf_altlexid_addr_hi_risk_ct_i  	;
f_vf_altlexid_addr_lo_risk_ct_d  	:= le.f_vf_altlexid_addr_lo_risk_ct_d  	;
f_vf_lexid_ssn_hi_risk_ct_i      	:= le.f_vf_lexid_ssn_hi_risk_ct_i      	;
f_vf_lexid_ssn_lo_risk_ct_d      	:= le.f_vf_lexid_ssn_lo_risk_ct_d      	;
f_vf_altlexid_ssn_hi_risk_ct_i   	:= le.f_vf_altlexid_ssn_hi_risk_ct_i   	;
f_vf_altlexid_ssn_lo_risk_ct_d   	:= le.f_vf_altlexid_ssn_lo_risk_ct_d   	;
f_mos_liens_rel_sc_fseen_d       	:= le.f_mos_liens_rel_sc_fseen_d       	;
f_mos_liens_rel_sc_lseen_d       	:= le.f_mos_liens_rel_sc_lseen_d       	;
f_liens_rel_sc_total_amt_i       	:= le.f_liens_rel_sc_total_amt_i       	;
f_liens_unrel_st_ct_i            	:= le.f_liens_unrel_st_ct_i            	;
f_mos_liens_unrel_st_fseen_d     	:= le.f_mos_liens_unrel_st_fseen_d     	;
f_mos_liens_unrel_st_lseen_d     	:= le.f_mos_liens_unrel_st_lseen_d     	;
f_liens_unrel_st_total_amt_i     	:= le.f_liens_unrel_st_total_amt_i     	;
f_liens_rel_st_ct_i              	:= le.f_liens_rel_st_ct_i              	;
f_mos_liens_rel_st_fseen_d       	:= le.f_mos_liens_rel_st_fseen_d       	;
f_mos_liens_rel_st_lseen_d       	:= le.f_mos_liens_rel_st_lseen_d       	;
f_liens_rel_st_total_amt_i       	:= le.f_liens_rel_st_total_amt_i       	;
f_has_professional_license_d     	:= le.f_has_professional_license_d     	;
f_prof_license_category_ix_d     	:= le.f_prof_license_category_ix_d     	;
f_has_hh_members_n               	:= le.f_has_hh_members_n               	;
f_hh_members_ct_d                	:= le.f_hh_members_ct_d                	;
f_property_owners_ct_d           	:= le.f_property_owners_ct_d           	;
f_hh_age_65_plus_d               	:= le.f_hh_age_65_plus_d               	;
f_hh_age_30_plus_d               	:= le.f_hh_age_30_plus_d               	;
f_hh_age_18_plus_d               	:= le.f_hh_age_18_plus_d               	;
f_hh_age_lt18_i                  	:= le.f_hh_age_lt18_i                  	;
f_hh_collections_ct_i            	:= le.f_hh_collections_ct_i            	;
f_hh_workers_paw_d               	:= le.f_hh_workers_paw_d               	;
f_hh_payday_loan_users_i         	:= le.f_hh_payday_loan_users_i         	;
f_hh_members_w_derog_i           	:= le.f_hh_members_w_derog_i           	;
f_hh_tot_derog_i                 	:= le.f_hh_tot_derog_i                 	;
f_hh_bankruptcies_i              	:= le.f_hh_bankruptcies_i              	;
f_hh_lienholders_i               	:= le.f_hh_lienholders_i               	;
f_hh_prof_license_holders_d      	:= le.f_hh_prof_license_holders_d      	;
f_hh_criminals_i                 	:= le.f_hh_criminals_i                 	;
f_hh_college_attendees_d         	:= le.f_hh_college_attendees_d         	;
f_prof_lic_ix_sanct_ct_n         	:= le.f_prof_lic_ix_sanct_ct_n         	;
f_mos_prof_lic_ix_sanct_fs_n     	:= le.f_mos_prof_lic_ix_sanct_fs_n     	;
f_mos_prof_lic_ix_sanct_ls_n     	:= le.f_mos_prof_lic_ix_sanct_ls_n     	;
f_prof_lic_ix_sanct_type_n       	:= le.f_prof_lic_ix_sanct_type_n       	;
nf_vf_hi_risk_ind                	:= le.nf_vf_hi_risk_ind                	;
nf_vf_lo_risk_ind                	:= le.nf_vf_lo_risk_ind                	;
nf_vf_lexid_addr_hi_risk_ind     	:= le.nf_vf_lexid_addr_hi_risk_ind     	;
nf_vf_lexid_phone_hi_risk_ind    	:= le.nf_vf_lexid_phone_hi_risk_ind    	;
nf_vf_lexid_ssn_hi_risk_ind      	:= le.nf_vf_lexid_ssn_hi_risk_ind      	;
nf_vf_altlexid_addr_hi_risk_ind  	:= le.nf_vf_altlexid_addr_hi_risk_ind  	;
nf_vf_altlexid_phone_hi_risk_ind 	:= le.nf_vf_altlexid_phone_hi_risk_ind 	;
nf_vf_altlexid_ssn_hi_risk_ind   	:= le.nf_vf_altlexid_ssn_hi_risk_ind   	;
nf_vf_lexid_addr_lo_risk_ind     	:= le.nf_vf_lexid_addr_lo_risk_ind     	;
nf_vf_lexid_phone_lo_risk_ind    	:= le.nf_vf_lexid_phone_lo_risk_ind    	;
nf_vf_lexid_ssn_lo_risk_ind      	:= le.nf_vf_lexid_ssn_lo_risk_ind      	;
nf_vf_altlexid_addr_lo_risk_ind  	:= le.nf_vf_altlexid_addr_lo_risk_ind  	;
nf_vf_altlexid_phone_lo_risk_ind 	:= le.nf_vf_altlexid_phone_lo_risk_ind 	;
nf_vf_altlexid_ssn_lo_risk_ind   	:= le.nf_vf_altlexid_ssn_lo_risk_ind   	;
nf_vf_type                       	:= le.nf_vf_type                       	;
nf_vf_lexid_hi_summary           	:= le.nf_vf_lexid_hi_summary           	;
nf_vf_altlexid_hi_summary        	:= le.nf_vf_altlexid_hi_summary        	;
nf_vf_lexid_lo_summary           	:= le.nf_vf_lexid_lo_summary           	;
nf_vf_hi_summary                 	:= le.nf_vf_hi_summary                 	;
nf_vf_lo_summary                 	:= le.nf_vf_lo_summary                 	;
_vf_lexid_lo_summary             	:= le._vf_lexid_lo_summary             	;
_vf_lexid_hi_summary             	:= le._vf_lexid_hi_summary             	;
nf_vf_level                      	:= le.nf_vf_level                      	;
nf_vf_hi_additional_entries      	:= le.nf_vf_hi_additional_entries      	;
nf_vf_lo_additional_entries      	:= le.nf_vf_lo_additional_entries      	;
nf_vf_hi_addr_add_entries        	:= le.nf_vf_hi_addr_add_entries        	;
nf_vf_hi_phone_add_entries       	:= le.nf_vf_hi_phone_add_entries       	;
nf_vf_hi_ssn_add_entries         	:= le.nf_vf_hi_ssn_add_entries         	;
nf_vf_lo_addr_add_entries        	:= le.nf_vf_lo_addr_add_entries        	;
nf_vf_lo_phone_add_entries       	:= le.nf_vf_lo_phone_add_entries       	;
nf_vf_lo_ssn_add_entries         	:= le.nf_vf_lo_ssn_add_entries         	;
nf_altlexid_addr_hi_no_hi_lexid  	:= le.nf_altlexid_addr_hi_no_hi_lexid  	;
nf_altlexid_phone_hi_no_hi_lexid 	:= le.nf_altlexid_phone_hi_no_hi_lexid 	;
nf_altlexid_ssn_hi_no_hi_lexid   	:= le.nf_altlexid_ssn_hi_no_hi_lexid   	;
nf_max_altlexid_hi_no_hi_lexid   	:= le.nf_max_altlexid_hi_no_hi_lexid   	;
nf_vf_hi_risk_hit_type           	:= le.nf_vf_hi_risk_hit_type           	;
nf_vf_hi_risk_index              	:= le.nf_vf_hi_risk_index              	;
nf_seg_fraudpoint_3_0            	:= le.nf_seg_fraudpoint_3_0            	;
truedid                          	:= le.truedid                          	;
out_unit_desig                   	:= le.out_unit_desig                   	;
out_sec_range                    	:= le.out_sec_range                    	;
out_z5                           	:= le.out_z5                           	;
out_addr_type                    	:= le.out_addr_type                    	;
out_addr_status                  	:= le.out_addr_status                  	;
in_dob                           	:= le.in_dob                           	;
nas_summary                      	:= le.nas_summary                      	;
nap_summary                      	:= le.nap_summary                      	;
nap_type                         	:= le.nap_type                         	;
nap_status                       	:= le.nap_status                       	;
rc_ssndod                        	:= le.rc_ssndod                        	;
rc_input_addr_not_most_recent    	:= le.rc_input_addr_not_most_recent    	;
rc_hriskphoneflag                	:= le.rc_hriskphoneflag                	;
rc_hphonetypeflag                	:= le.rc_hphonetypeflag                	;
rc_phonevalflag                  	:= le.rc_phonevalflag                  	;
rc_hphonevalflag                 	:= le.rc_hphonevalflag                 	;
rc_pwphonezipflag                	:= le.rc_pwphonezipflag                	;
rc_hriskaddrflag                 	:= le.rc_hriskaddrflag                 	;
rc_decsflag                      	:= le.rc_decsflag                      	;
rc_ssndobflag                    	:= le.rc_ssndobflag                    	;
rc_pwssndobflag                  	:= le.rc_pwssndobflag                  	;
rc_ssnvalflag                    	:= le.rc_ssnvalflag                    	;
rc_pwssnvalflag                  	:= le.rc_pwssnvalflag                  	;
rc_addrvalflag                   	:= le.rc_addrvalflag                   	;
rc_dwelltype                     	:= le.rc_dwelltype                     	;
rc_ssnmiskeyflag                 	:= le.rc_ssnmiskeyflag                 	;
rc_addrmiskeyflag                	:= le.rc_addrmiskeyflag                	;
rc_addrcommflag                  	:= le.rc_addrcommflag                  	;
rc_hrisksicphone                 	:= le.rc_hrisksicphone                 	;
rc_disthphoneaddr                	:= le.rc_disthphoneaddr                	;
rc_phonetype                     	:= le.rc_phonetype                     	;
rc_ziptypeflag                   	:= le.rc_ziptypeflag                   	;
rc_zipclass                      	:= le.rc_zipclass                      	;
combo_ssnscore                   	:= le.combo_ssnscore                   	;
combo_dobscore                   	:= le.combo_dobscore                   	;
hdr_source_profile               	:= le.hdr_source_profile               	;
hdr_source_profile_index         	:= le.hdr_source_profile_index         	;
ver_sources                      	:= le.ver_sources                      	;
ver_sources_first_seen           	:= le.ver_sources_first_seen           	;
bus_addr_match_count             	:= le.bus_addr_match_count             	;
bus_name_match                   	:= le.bus_name_match                   	;
bus_ssn_match                    	:= le.bus_ssn_match                    	;
bus_phone_match                  	:= le.bus_phone_match                  	;
fnamepop                         	:= le.fnamepop                         	;
lnamepop                         	:= le.lnamepop                         	;
addrpop                          	:= le.addrpop                          	;
ssnlength                        	:= le.ssnlength                        	;
dobpop                           	:= le.dobpop                           	;
emailpop                         	:= le.emailpop                         	;
hphnpop                          	:= le.hphnpop                          	;
util_adl_type_list               	:= le.util_adl_type_list               	;
util_adl_count                   	:= le.util_adl_count                   	;
util_add_input_type_list         	:= le.util_add_input_type_list         	;
util_add_curr_type_list          	:= le.util_add_curr_type_list          	;
add_input_address_score          	:= le.add_input_address_score          	;
add_input_house_number_match     	:= le.add_input_house_number_match     	;
add_input_isbestmatch            	:= le.add_input_isbestmatch            	;
add_input_dirty_address          	:= le.add_input_dirty_address          	;
add_input_addr_not_verified      	:= le.add_input_addr_not_verified      	;
add_input_owned_not_occ          	:= le.add_input_owned_not_occ          	;
add_input_occ_index              	:= le.add_input_occ_index              	;
add_input_advo_vacancy           	:= le.add_input_advo_vacancy           	;
add_input_advo_throw_back        	:= le.add_input_advo_throw_back        	;
add_input_advo_seasonal          	:= le.add_input_advo_seasonal          	;
add_input_advo_dnd               	:= le.add_input_advo_dnd               	;
add_input_advo_drop              	:= le.add_input_advo_drop              	;
add_input_advo_res_or_bus        	:= le.add_input_advo_res_or_bus        	;
add_input_avm_auto_val           	:= le.add_input_avm_auto_val           	;
add_input_naprop                 	:= le.add_input_naprop                 	;
add_input_mortgage_date          	:= le.add_input_mortgage_date          	;
add_input_mortgage_type          	:= le.add_input_mortgage_type          	;
add_input_financing_type         	:= le.add_input_financing_type         	;
add_input_occupants_1yr          	:= le.add_input_occupants_1yr          	;
add_input_turnover_1yr_in        	:= le.add_input_turnover_1yr_in        	;
add_input_turnover_1yr_out       	:= le.add_input_turnover_1yr_out       	;
add_input_nhood_vac_prop         	:= le.add_input_nhood_vac_prop         	;
add_input_nhood_bus_ct           	:= le.add_input_nhood_bus_ct           	;
add_input_nhood_sfd_ct           	:= le.add_input_nhood_sfd_ct           	;
add_input_nhood_mfd_ct           	:= le.add_input_nhood_mfd_ct           	;
add_input_pop                    	:= le.add_input_pop                    	;
property_owned_total             	:= le.property_owned_total             	;
add_curr_isbestmatch             	:= le.add_curr_isbestmatch             	;
add_curr_lres                    	:= le.add_curr_lres                    	;
add_curr_occ_index               	:= le.add_curr_occ_index               	;
add_curr_advo_vacancy            	:= le.add_curr_advo_vacancy            	;
add_curr_advo_throw_back         	:= le.add_curr_advo_throw_back         	;
add_curr_advo_seasonal           	:= le.add_curr_advo_seasonal           	;
add_curr_advo_drop               	:= le.add_curr_advo_drop               	;
add_curr_advo_res_or_bus         	:= le.add_curr_advo_res_or_bus         	;
add_curr_avm_auto_val            	:= le.add_curr_avm_auto_val            	;
add_curr_avm_auto_val_2          	:= le.add_curr_avm_auto_val_2          	;
add_curr_naprop                  	:= le.add_curr_naprop                  	;
add_curr_mortgage_date           	:= le.add_curr_mortgage_date           	;
add_curr_mortgage_type           	:= le.add_curr_mortgage_type           	;
add_curr_financing_type          	:= le.add_curr_financing_type          	;
add_curr_hr_address              	:= le.add_curr_hr_address              	;
add_curr_occupants_1yr           	:= le.add_curr_occupants_1yr           	;
add_curr_turnover_1yr_in         	:= le.add_curr_turnover_1yr_in         	;
add_curr_turnover_1yr_out        	:= le.add_curr_turnover_1yr_out        	;
add_curr_nhood_vac_prop          	:= le.add_curr_nhood_vac_prop          	;
add_curr_nhood_bus_ct            	:= le.add_curr_nhood_bus_ct            	;
add_curr_nhood_sfd_ct            	:= le.add_curr_nhood_sfd_ct            	;
add_curr_nhood_mfd_ct            	:= le.add_curr_nhood_mfd_ct            	;
add_curr_pop                     	:= le.add_curr_pop                     	;
add_prev_naprop                  	:= le.add_prev_naprop                  	;
max_lres                         	:= le.max_lres                         	;
addrs_5yr                        	:= le.addrs_5yr                        	;
addrs_10yr                       	:= le.addrs_10yr                       	;
addrs_15yr                       	:= le.addrs_15yr                       	;
addrs_prison_history             	:= le.addrs_prison_history             	;
telcordia_type                   	:= le.telcordia_type                   	;
recent_disconnects               	:= le.recent_disconnects               	;
phone_ver_insurance              	:= le.phone_ver_insurance              	;
phone_ver_experian               	:= le.phone_ver_experian               	;
header_first_seen                	:= le.header_first_seen                	;
inputssncharflag                 	:= le.inputssncharflag                 	;
ssns_per_adl                     	:= le.ssns_per_adl                     	;
adls_per_ssn                     	:= le.adls_per_ssn                     	;
addrs_per_ssn                    	:= le.addrs_per_ssn                    	;
adls_per_addr_curr               	:= le.adls_per_addr_curr               	;
phones_per_addr_curr             	:= le.phones_per_addr_curr             	;
ssns_per_adl_c6                  	:= le.ssns_per_adl_c6                  	;
addrs_per_adl_c6                 	:= le.addrs_per_adl_c6                 	;
lnames_per_adl_c6                	:= le.lnames_per_adl_c6                	;
addrs_per_ssn_c6                 	:= le.addrs_per_ssn_c6                 	;
adls_per_addr_c6                 	:= le.adls_per_addr_c6                 	;
phones_per_addr_c6               	:= le.phones_per_addr_c6               	;
adls_per_phone_c6                	:= le.adls_per_phone_c6                	;
dl_addrs_per_adl                 	:= le.dl_addrs_per_adl                 	;
invalid_phones_per_adl           	:= le.invalid_phones_per_adl           	;
invalid_phones_per_adl_c6        	:= le.invalid_phones_per_adl_c6        	;
invalid_ssns_per_adl             	:= le.invalid_ssns_per_adl             	;
invalid_ssns_per_adl_c6          	:= le.invalid_ssns_per_adl_c6          	;
invalid_addrs_per_adl            	:= le.invalid_addrs_per_adl            	;
invalid_addrs_per_adl_c6         	:= le.invalid_addrs_per_adl_c6         	;
inq_email_ver_count              	:= le.inq_email_ver_count              	;
inq_count                        	:= le.inq_count                        	;
inq_count_day                    	:= le.inq_count_day                    	;
inq_count_week                   	:= le.inq_count_week                   	;
inq_count01                      	:= le.inq_count01                      	;
inq_count03                      	:= le.inq_count03                      	;
inq_count06                      	:= le.inq_count06                      	;
inq_count12                      	:= le.inq_count12                      	;
inq_count24                      	:= le.inq_count24                      	;
inq_auto_count                   	:= le.inq_auto_count                   	;
inq_auto_count_day               	:= le.inq_auto_count_day               	;
inq_auto_count_week              	:= le.inq_auto_count_week              	;
inq_auto_count01                 	:= le.inq_auto_count01                 	;
inq_auto_count03                 	:= le.inq_auto_count03                 	;
inq_auto_count06                 	:= le.inq_auto_count06                 	;
inq_auto_count12                 	:= le.inq_auto_count12                 	;
inq_auto_count24                 	:= le.inq_auto_count24                 	;
inq_banking_count                	:= le.inq_banking_count                	;
inq_banking_count_day            	:= le.inq_banking_count_day            	;
inq_banking_count_week           	:= le.inq_banking_count_week           	;
inq_banking_count01              	:= le.inq_banking_count01              	;
inq_banking_count03              	:= le.inq_banking_count03              	;
inq_banking_count06              	:= le.inq_banking_count06              	;
inq_banking_count12              	:= le.inq_banking_count12              	;
inq_banking_count24              	:= le.inq_banking_count24              	;
inq_collection_count             	:= le.inq_collection_count             	;
inq_collection_count_day         	:= le.inq_collection_count_day         	;
inq_collection_count_week        	:= le.inq_collection_count_week        	;
inq_collection_count01           	:= le.inq_collection_count01           	;
inq_collection_count03           	:= le.inq_collection_count03           	;
inq_collection_count06           	:= le.inq_collection_count06           	;
inq_collection_count12           	:= le.inq_collection_count12           	;
inq_collection_count24           	:= le.inq_collection_count24           	;
inq_communications_count         	:= le.inq_communications_count         	;
inq_communications_count_day     	:= le.inq_communications_count_day     	;
inq_communications_count_week    	:= le.inq_communications_count_week    	;
inq_communications_count01       	:= le.inq_communications_count01       	;
inq_communications_count03       	:= le.inq_communications_count03       	;
inq_communications_count06       	:= le.inq_communications_count06       	;
inq_communications_count12       	:= le.inq_communications_count12       	;
inq_communications_count24       	:= le.inq_communications_count24       	;
inq_highriskcredit_count         	:= le.inq_highriskcredit_count         	;
inq_highriskcredit_count_day     	:= le.inq_highriskcredit_count_day     	;
inq_highriskcredit_count_week    	:= le.inq_highriskcredit_count_week    	;
inq_highriskcredit_count01       	:= le.inq_highriskcredit_count01       	;
inq_highriskcredit_count03       	:= le.inq_highriskcredit_count03       	;
inq_highriskcredit_count06       	:= le.inq_highriskcredit_count06       	;
inq_highriskcredit_count12       	:= le.inq_highriskcredit_count12       	;
inq_highriskcredit_count24       	:= le.inq_highriskcredit_count24       	;
inq_mortgage_count               	:= le.inq_mortgage_count               	;
inq_mortgage_count_day           	:= le.inq_mortgage_count_day           	;
inq_mortgage_count_week          	:= le.inq_mortgage_count_week          	;
inq_mortgage_count01             	:= le.inq_mortgage_count01             	;
inq_mortgage_count03             	:= le.inq_mortgage_count03             	;
inq_mortgage_count06             	:= le.inq_mortgage_count06             	;
inq_mortgage_count12             	:= le.inq_mortgage_count12             	;
inq_mortgage_count24             	:= le.inq_mortgage_count24             	;
inq_other_count                  	:= le.inq_other_count                  	;
inq_other_count_day              	:= le.inq_other_count_day              	;
inq_other_count_week             	:= le.inq_other_count_week             	;
inq_other_count24                	:= le.inq_other_count24                	;
inq_prepaidcards_count           	:= le.inq_prepaidcards_count           	;
inq_prepaidcards_count_day       	:= le.inq_prepaidcards_count_day       	;
inq_prepaidcards_count_week      	:= le.inq_prepaidcards_count_week      	;
inq_prepaidcards_count01         	:= le.inq_prepaidcards_count01         	;
inq_prepaidcards_count03         	:= le.inq_prepaidcards_count03         	;
inq_prepaidcards_count06         	:= le.inq_prepaidcards_count06         	;
inq_prepaidcards_count12         	:= le.inq_prepaidcards_count12         	;
inq_prepaidcards_count24         	:= le.inq_prepaidcards_count24         	;
inq_quizprovider_count           	:= le.inq_quizprovider_count           	;
inq_quizprovider_count_day       	:= le.inq_quizprovider_count_day       	;
inq_quizprovider_count_week      	:= le.inq_quizprovider_count_week      	;
inq_quizprovider_count24         	:= le.inq_quizprovider_count24         	;
inq_retail_count                 	:= le.inq_retail_count                 	;
inq_retail_count_day             	:= le.inq_retail_count_day             	;
inq_retail_count_week            	:= le.inq_retail_count_week            	;
inq_retail_count01               	:= le.inq_retail_count01               	;
inq_retail_count03               	:= le.inq_retail_count03               	;
inq_retail_count06               	:= le.inq_retail_count06               	;
inq_retail_count12               	:= le.inq_retail_count12               	;
inq_retail_count24               	:= le.inq_retail_count24               	;
inq_retailpayments_count         	:= le.inq_retailpayments_count         	;
inq_retailpayments_count_day     	:= le.inq_retailpayments_count_day     	;
inq_retailpayments_count_week    	:= le.inq_retailpayments_count_week    	;
inq_retailpayments_count01       	:= le.inq_retailpayments_count01       	;
inq_retailpayments_count03       	:= le.inq_retailpayments_count03       	;
inq_retailpayments_count06       	:= le.inq_retailpayments_count06       	;
inq_retailpayments_count12       	:= le.inq_retailpayments_count12       	;
inq_retailpayments_count24       	:= le.inq_retailpayments_count24       	;
inq_studentloan_count            	:= le.inq_studentloan_count            	;
inq_studentloan_count_day        	:= le.inq_studentloan_count_day        	;
inq_studentloan_count_week       	:= le.inq_studentloan_count_week       	;
inq_studentloan_count01          	:= le.inq_studentloan_count01          	;
inq_studentloan_count03          	:= le.inq_studentloan_count03          	;
inq_studentloan_count06          	:= le.inq_studentloan_count06          	;
inq_studentloan_count12          	:= le.inq_studentloan_count12          	;
inq_studentloan_count24          	:= le.inq_studentloan_count24          	;
inq_utilities_count              	:= le.inq_utilities_count              	;
inq_utilities_count_day          	:= le.inq_utilities_count_day          	;
inq_utilities_count_week         	:= le.inq_utilities_count_week         	;
inq_utilities_count01            	:= le.inq_utilities_count01            	;
inq_utilities_count03            	:= le.inq_utilities_count03            	;
inq_utilities_count06            	:= le.inq_utilities_count06            	;
inq_utilities_count12            	:= le.inq_utilities_count12            	;
inq_utilities_count24            	:= le.inq_utilities_count24            	;
inq_billgroup_count              	:= le.inq_billgroup_count              	;
inq_billgroup_count24            	:= le.inq_billgroup_count24            	;
inq_perssn                       	:= le.inq_perssn                       	;
inq_adlsperssn                   	:= le.inq_adlsperssn                   	;
inq_lnamesperssn                 	:= le.inq_lnamesperssn                 	;
inq_addrsperssn                  	:= le.inq_addrsperssn                  	;
inq_dobsperssn                   	:= le.inq_dobsperssn                   	;
inq_peraddr                      	:= le.inq_peraddr                      	;
inq_adlsperaddr                  	:= le.inq_adlsperaddr                  	;
inq_lnamesperaddr                	:= le.inq_lnamesperaddr                	;
inq_ssnsperaddr                  	:= le.inq_ssnsperaddr                  	;
inq_perphone                     	:= le.inq_perphone                     	;
inq_adlsperphone                 	:= le.inq_adlsperphone                 	;
inq_email_per_adl                	:= le.inq_email_per_adl                	;
inq_adls_per_email               	:= le.inq_adls_per_email               	;
inq_banko_am_first_seen          	:= le.inq_banko_am_first_seen          	;
inq_banko_am_last_seen           	:= le.inq_banko_am_last_seen           	;
inq_banko_cm_first_seen          	:= le.inq_banko_cm_first_seen          	;
inq_banko_cm_last_seen           	:= le.inq_banko_cm_last_seen           	;
inq_banko_om_first_seen          	:= le.inq_banko_om_first_seen          	;
inq_banko_om_last_seen           	:= le.inq_banko_om_last_seen           	;
pb_number_of_sources             	:= le.pb_number_of_sources             	;
pb_average_days_bt_orders        	:= le.pb_average_days_bt_orders        	;
pb_average_dollars               	:= le.pb_average_dollars               	;
pb_total_dollars                 	:= le.pb_total_dollars                 	;
pb_total_orders                  	:= le.pb_total_orders                  	;
br_source_count                  	:= le.br_source_count                  	;
infutor_nap                      	:= le.infutor_nap                      	;
stl_inq_count                    	:= le.stl_inq_count                    	;
stl_inq_count90                  	:= le.stl_inq_count90                  	;
stl_inq_count180                 	:= le.stl_inq_count180                 	;
stl_inq_count12                  	:= le.stl_inq_count12                  	;
stl_inq_count24                  	:= le.stl_inq_count24                  	;
email_count                      	:= le.email_count                      	;
email_domain_free_count          	:= le.email_domain_free_count          	;
email_domain_isp_count           	:= le.email_domain_isp_count           	;
email_name_addr_verification     	:= le.email_name_addr_verification     	;
email_verification               	:= le.email_verification               	;
adl_per_email                    	:= le.adl_per_email                    	;
attr_num_aircraft                	:= le.attr_num_aircraft                	;
attr_total_number_derogs         	:= le.attr_total_number_derogs         	;
attr_arrests                     	:= le.attr_arrests                     	;
attr_arrests30                   	:= le.attr_arrests30                   	;
attr_arrests90                   	:= le.attr_arrests90                   	;
attr_arrests180                  	:= le.attr_arrests180                  	;
attr_arrests12                   	:= le.attr_arrests12                   	;
attr_arrests24                   	:= le.attr_arrests24                   	;
attr_arrests36                   	:= le.attr_arrests36                   	;
attr_arrests60                   	:= le.attr_arrests60                   	;
attr_num_unrel_liens60           	:= le.attr_num_unrel_liens60           	;
attr_bankruptcy_count30          	:= le.attr_bankruptcy_count30          	;
attr_bankruptcy_count90          	:= le.attr_bankruptcy_count90          	;
attr_bankruptcy_count180         	:= le.attr_bankruptcy_count180         	;
attr_bankruptcy_count12          	:= le.attr_bankruptcy_count12          	;
attr_bankruptcy_count24          	:= le.attr_bankruptcy_count24          	;
attr_bankruptcy_count36          	:= le.attr_bankruptcy_count36          	;
attr_bankruptcy_count60          	:= le.attr_bankruptcy_count60          	;
attr_eviction_count              	:= le.attr_eviction_count              	;
attr_eviction_count90            	:= le.attr_eviction_count90            	;
attr_eviction_count180           	:= le.attr_eviction_count180           	;
attr_eviction_count12            	:= le.attr_eviction_count12            	;
attr_eviction_count24            	:= le.attr_eviction_count24            	;
attr_eviction_count36            	:= le.attr_eviction_count36            	;
attr_eviction_count60            	:= le.attr_eviction_count60            	;
attr_num_nonderogs               	:= le.attr_num_nonderogs               	;
attr_num_nonderogs90             	:= le.attr_num_nonderogs90             	;
attr_num_nonderogs180            	:= le.attr_num_nonderogs180            	;
attr_num_nonderogs12             	:= le.attr_num_nonderogs12             	;
attr_num_nonderogs24             	:= le.attr_num_nonderogs24             	;
attr_num_nonderogs36             	:= le.attr_num_nonderogs36             	;
attr_num_nonderogs60             	:= le.attr_num_nonderogs60             	;
vf_hi_risk_ct                    	:= le.vf_hi_risk_ct                    	;
vf_lo_risk_ct                    	:= le.vf_lo_risk_ct                    	;
vf_lexid_phone_hi_risk_ct        	:= le.vf_lexid_phone_hi_risk_ct        	;
vf_lexid_phone_lo_risk_ct        	:= le.vf_lexid_phone_lo_risk_ct        	;
vf_altlexid_phone_hi_risk_ct     	:= le.vf_altlexid_phone_hi_risk_ct     	;
vf_altlexid_phone_lo_risk_ct     	:= le.vf_altlexid_phone_lo_risk_ct     	;
vf_lexid_addr_hi_risk_ct         	:= le.vf_lexid_addr_hi_risk_ct         	;
vf_lexid_addr_lo_risk_ct         	:= le.vf_lexid_addr_lo_risk_ct         	;
vf_altlexid_addr_hi_risk_ct      	:= le.vf_altlexid_addr_hi_risk_ct      	;
vf_altlexid_addr_lo_risk_ct      	:= le.vf_altlexid_addr_lo_risk_ct      	;
vf_lexid_ssn_hi_risk_ct          	:= le.vf_lexid_ssn_hi_risk_ct          	;
vf_lexid_ssn_lo_risk_ct          	:= le.vf_lexid_ssn_lo_risk_ct          	;
vf_altlexid_ssn_hi_risk_ct       	:= le.vf_altlexid_ssn_hi_risk_ct       	;
vf_altlexid_ssn_lo_risk_ct       	:= le.vf_altlexid_ssn_lo_risk_ct       	;
fp_idrisktype                    	:= le.fp_idrisktype                    	;
fp_idverrisktype                 	:= le.fp_idverrisktype                 	;
fp_sourcerisktype                	:= le.fp_sourcerisktype                	;
fp_varrisktype                   	:= le.fp_varrisktype                   	;
fp_varmsrcssncount               	:= le.fp_varmsrcssncount               	;
fp_varmsrcssnunrelcount          	:= le.fp_varmsrcssnunrelcount          	;
fp_vardobcount                   	:= le.fp_vardobcount                   	;
fp_vardobcountnew                	:= le.fp_vardobcountnew                	;
fp_srchvelocityrisktype          	:= le.fp_srchvelocityrisktype          	;
fp_srchcountwk                   	:= le.fp_srchcountwk                   	;
fp_srchcountday                  	:= le.fp_srchcountday                  	;
fp_srchunvrfdssncount            	:= le.fp_srchunvrfdssncount            	;
fp_srchunvrfdaddrcount           	:= le.fp_srchunvrfdaddrcount           	;
fp_srchunvrfddobcount            	:= le.fp_srchunvrfddobcount            	;
fp_srchunvrfdphonecount          	:= le.fp_srchunvrfdphonecount          	;
fp_srchfraudsrchcount            	:= le.fp_srchfraudsrchcount            	;
fp_srchfraudsrchcountyr          	:= le.fp_srchfraudsrchcountyr          	;
fp_srchfraudsrchcountmo          	:= le.fp_srchfraudsrchcountmo          	;
fp_srchfraudsrchcountwk          	:= le.fp_srchfraudsrchcountwk          	;
fp_srchfraudsrchcountday         	:= le.fp_srchfraudsrchcountday         	;
fp_srchlocatesrchcountwk         	:= le.fp_srchlocatesrchcountwk         	;
fp_srchlocatesrchcountday        	:= le.fp_srchlocatesrchcountday        	;
fp_assocrisktype                 	:= le.fp_assocrisktype                 	;
fp_assocsuspicousidcount         	:= le.fp_assocsuspicousidcount         	;
fp_assoccredbureaucount          	:= le.fp_assoccredbureaucount          	;
fp_assoccredbureaucountnew       	:= le.fp_assoccredbureaucountnew       	;
fp_assoccredbureaucountmo        	:= le.fp_assoccredbureaucountmo        	;
fp_validationrisktype            	:= le.fp_validationrisktype            	;
fp_corrrisktype                  	:= le.fp_corrrisktype                  	;
fp_corrssnnamecount              	:= le.fp_corrssnnamecount              	;
fp_corrssnaddrcount              	:= le.fp_corrssnaddrcount              	;
fp_corraddrnamecount             	:= le.fp_corraddrnamecount             	;
fp_corraddrphonecount            	:= le.fp_corraddrphonecount            	;
fp_corrphonelastnamecount        	:= le.fp_corrphonelastnamecount        	;
fp_divrisktype                   	:= le.fp_divrisktype                   	;
fp_divssnidmsrcurelcount         	:= le.fp_divssnidmsrcurelcount         	;
fp_divaddrsuspidcountnew         	:= le.fp_divaddrsuspidcountnew         	;
fp_divsrchaddrsuspidcount        	:= le.fp_divsrchaddrsuspidcount        	;
fp_srchcomponentrisktype         	:= le.fp_srchcomponentrisktype         	;
fp_srchssnsrchcount              	:= le.fp_srchssnsrchcount              	;
fp_srchssnsrchcountmo            	:= le.fp_srchssnsrchcountmo            	;
fp_srchssnsrchcountwk            	:= le.fp_srchssnsrchcountwk            	;
fp_srchssnsrchcountday           	:= le.fp_srchssnsrchcountday           	;
fp_srchaddrsrchcount             	:= le.fp_srchaddrsrchcount             	;
fp_srchaddrsrchcountmo           	:= le.fp_srchaddrsrchcountmo           	;
fp_srchaddrsrchcountwk           	:= le.fp_srchaddrsrchcountwk           	;
fp_srchaddrsrchcountday          	:= le.fp_srchaddrsrchcountday          	;
fp_srchphonesrchcount            	:= le.fp_srchphonesrchcount            	;
fp_srchphonesrchcountmo          	:= le.fp_srchphonesrchcountmo          	;
fp_srchphonesrchcountwk          	:= le.fp_srchphonesrchcountwk          	;
fp_srchphonesrchcountday         	:= le.fp_srchphonesrchcountday         	;
fp_componentcharrisktype         	:= le.fp_componentcharrisktype         	;
fp_inputaddractivephonelist      	:= le.fp_inputaddractivephonelist      	;
fp_addrchangeincomediff          	:= le.fp_addrchangeincomediff          	;
fp_addrchangevaluediff           	:= le.fp_addrchangevaluediff           	;
fp_addrchangecrimediff           	:= le.fp_addrchangecrimediff           	;
fp_addrchangeecontrajindex       	:= le.fp_addrchangeecontrajindex       	;
fp_curraddractivephonelist       	:= le.fp_curraddractivephonelist       	;
fp_curraddrmedianincome          	:= le.fp_curraddrmedianincome          	;
fp_curraddrmedianvalue           	:= le.fp_curraddrmedianvalue           	;
fp_curraddrmurderindex           	:= le.fp_curraddrmurderindex           	;
fp_curraddrcartheftindex         	:= le.fp_curraddrcartheftindex         	;
fp_curraddrburglaryindex         	:= le.fp_curraddrburglaryindex         	;
fp_curraddrcrimeindex            	:= le.fp_curraddrcrimeindex            	;
fp_prevaddrageoldest             	:= le.fp_prevaddrageoldest             	;
fp_prevaddrlenofres              	:= le.fp_prevaddrlenofres              	;
fp_prevaddrdwelltype             	:= le.fp_prevaddrdwelltype             	;
fp_prevaddrstatus                	:= le.fp_prevaddrstatus                	;
fp_prevaddroccupantowned         	:= le.fp_prevaddroccupantowned         	;
fp_prevaddrmedianincome          	:= le.fp_prevaddrmedianincome          	;
fp_prevaddrmedianvalue           	:= le.fp_prevaddrmedianvalue           	;
fp_prevaddrmurderindex           	:= le.fp_prevaddrmurderindex           	;
fp_prevaddrcartheftindex         	:= le.fp_prevaddrcartheftindex         	;
fp_prevaddrburglaryindex         	:= le.fp_prevaddrburglaryindex         	;
fp_prevaddrcrimeindex            	:= le.fp_prevaddrcrimeindex            	;
bankrupt                         	:= le.bankrupt                         	;
disposition                      	:= le.disposition                      	;
filing_count                     	:= le.filing_count                     	;
bk_dismissed_recent_count        	:= le.bk_dismissed_recent_count        	;
bk_dismissed_historical_count    	:= le.bk_dismissed_historical_count    	;
bk_chapter                       	:= le.bk_chapter                       	;
bk_disposed_recent_count         	:= le.bk_disposed_recent_count         	;
bk_disposed_historical_count     	:= le.bk_disposed_historical_count     	;
liens_recent_unreleased_count    	:= le.liens_recent_unreleased_count    	;
liens_historical_unreleased_ct   	:= le.liens_historical_unreleased_ct   	;
liens_unrel_cj_first_seen        	:= le.liens_unrel_cj_first_seen        	;
liens_unrel_cj_last_seen         	:= le.liens_unrel_cj_last_seen         	;
liens_unrel_cj_total_amount      	:= le.liens_unrel_cj_total_amount      	;
liens_rel_cj_first_seen          	:= le.liens_rel_cj_first_seen          	;
liens_rel_cj_last_seen           	:= le.liens_rel_cj_last_seen           	;
liens_rel_cj_total_amount        	:= le.liens_rel_cj_total_amount        	;
liens_unrel_ft_first_seen        	:= le.liens_unrel_ft_first_seen        	;
liens_unrel_ft_last_seen         	:= le.liens_unrel_ft_last_seen         	;
liens_unrel_ft_total_amount      	:= le.liens_unrel_ft_total_amount      	;
liens_rel_ft_first_seen          	:= le.liens_rel_ft_first_seen          	;
liens_rel_ft_last_seen           	:= le.liens_rel_ft_last_seen           	;
liens_rel_ft_total_amount        	:= le.liens_rel_ft_total_amount        	;
liens_unrel_fc_first_seen        	:= le.liens_unrel_fc_first_seen        	;
liens_unrel_fc_last_seen         	:= le.liens_unrel_fc_last_seen         	;
liens_unrel_fc_total_amount      	:= le.liens_unrel_fc_total_amount      	;
liens_rel_fc_first_seen          	:= le.liens_rel_fc_first_seen          	;
liens_rel_fc_last_seen           	:= le.liens_rel_fc_last_seen           	;
liens_rel_fc_total_amount        	:= le.liens_rel_fc_total_amount        	;
liens_unrel_lt_first_seen        	:= le.liens_unrel_lt_first_seen        	;
liens_unrel_lt_last_seen         	:= le.liens_unrel_lt_last_seen         	;
liens_rel_lt_first_seen          	:= le.liens_rel_lt_first_seen          	;
liens_rel_lt_last_seen           	:= le.liens_rel_lt_last_seen           	;
liens_unrel_o_first_seen         	:= le.liens_unrel_o_first_seen         	;
liens_unrel_o_last_seen          	:= le.liens_unrel_o_last_seen          	;
liens_unrel_o_total_amount       	:= le.liens_unrel_o_total_amount       	;
liens_rel_o_first_seen           	:= le.liens_rel_o_first_seen           	;
liens_rel_o_last_seen            	:= le.liens_rel_o_last_seen            	;
liens_rel_o_total_amount         	:= le.liens_rel_o_total_amount         	;
liens_unrel_ot_first_seen        	:= le.liens_unrel_ot_first_seen        	;
liens_unrel_ot_last_seen         	:= le.liens_unrel_ot_last_seen         	;
liens_unrel_ot_total_amount      	:= le.liens_unrel_ot_total_amount      	;
liens_rel_ot_first_seen          	:= le.liens_rel_ot_first_seen          	;
liens_rel_ot_last_seen           	:= le.liens_rel_ot_last_seen           	;
liens_rel_ot_total_amount        	:= le.liens_rel_ot_total_amount        	;
liens_unrel_sc_first_seen        	:= le.liens_unrel_sc_first_seen        	;
liens_unrel_sc_last_seen         	:= le.liens_unrel_sc_last_seen         	;
liens_unrel_sc_total_amount      	:= le.liens_unrel_sc_total_amount      	;
liens_rel_sc_first_seen          	:= le.liens_rel_sc_first_seen          	;
liens_rel_sc_last_seen           	:= le.liens_rel_sc_last_seen           	;
liens_rel_sc_total_amount        	:= le.liens_rel_sc_total_amount        	;
liens_unrel_st_ct                	:= le.liens_unrel_st_ct                	;
liens_unrel_st_first_seen        	:= le.liens_unrel_st_first_seen        	;
liens_unrel_st_last_seen         	:= le.liens_unrel_st_last_seen         	;
liens_unrel_st_total_amount      	:= le.liens_unrel_st_total_amount      	;
liens_rel_st_ct                  	:= le.liens_rel_st_ct                  	;
liens_rel_st_first_seen          	:= le.liens_rel_st_first_seen          	;
liens_rel_st_last_seen           	:= le.liens_rel_st_last_seen           	;
liens_rel_st_total_amount        	:= le.liens_rel_st_total_amount        	;
criminal_count                   	:= le.criminal_count                   	;
criminal_last_date               	:= le.criminal_last_date               	;
felony_count                     	:= le.felony_count                     	;
felony_last_date                 	:= le.felony_last_date                 	;
foreclosure_flag                 	:= le.foreclosure_flag                 	;
foreclosure_last_date            	:= le.foreclosure_last_date            	;
hh_members_ct                    	:= le.hh_members_ct                    	;
hh_property_owners_ct            	:= le.hh_property_owners_ct            	;
hh_age_65_plus                   	:= le.hh_age_65_plus                   	;
hh_age_30_to_65                  	:= le.hh_age_30_to_65                  	;
hh_age_18_to_30                  	:= le.hh_age_18_to_30                  	;
hh_age_lt18                      	:= le.hh_age_lt18                      	;
hh_collections_ct                	:= le.hh_collections_ct                	;
hh_workers_paw                   	:= le.hh_workers_paw                   	;
hh_payday_loan_users             	:= le.hh_payday_loan_users             	;
hh_members_w_derog               	:= le.hh_members_w_derog               	;
hh_tot_derog                     	:= le.hh_tot_derog                     	;
hh_bankruptcies                  	:= le.hh_bankruptcies                  	;
hh_lienholders                   	:= le.hh_lienholders                   	;
hh_prof_license_holders          	:= le.hh_prof_license_holders          	;
hh_criminals                     	:= le.hh_criminals                     	;
hh_college_attendees             	:= le.hh_college_attendees             	;
rel_count                        	:= le.rel_count                        	;
rel_bankrupt_count               	:= le.rel_bankrupt_count               	;
rel_criminal_count               	:= le.rel_criminal_count               	;
rel_felony_count                 	:= le.rel_felony_count                 	;
crim_rel_within25miles           	:= le.crim_rel_within25miles           	;
crim_rel_within100miles          	:= le.crim_rel_within100miles          	;
crim_rel_within500miles          	:= le.crim_rel_within500miles          	;
rel_within25miles_count          	:= le.rel_within25miles_count          	;
rel_within100miles_count         	:= le.rel_within100miles_count         	;
rel_within500miles_count         	:= le.rel_within500miles_count         	;
rel_incomeunder50_count          	:= le.rel_incomeunder50_count          	;
rel_incomeunder75_count          	:= le.rel_incomeunder75_count          	;
rel_incomeunder100_count         	:= le.rel_incomeunder100_count         	;
rel_incomeover100_count          	:= le.rel_incomeover100_count          	;
rel_homeunder100_count           	:= le.rel_homeunder100_count           	;
rel_homeunder150_count           	:= le.rel_homeunder150_count           	;
rel_homeunder200_count           	:= le.rel_homeunder200_count           	;
rel_homeunder300_count           	:= le.rel_homeunder300_count           	;
rel_homeunder500_count           	:= le.rel_homeunder500_count           	;
rel_homeover500_count            	:= le.rel_homeover500_count            	;
rel_educationunder12_count       	:= le.rel_educationunder12_count       	;
rel_educationover12_count        	:= le.rel_educationover12_count        	;
rel_ageunder30_count             	:= le.rel_ageunder30_count             	;
rel_ageunder40_count             	:= le.rel_ageunder40_count             	;
rel_ageunder50_count             	:= le.rel_ageunder50_count             	;
rel_ageunder60_count             	:= le.rel_ageunder60_count             	;
rel_ageunder70_count             	:= le.rel_ageunder70_count             	;
rel_ageover70_count              	:= le.rel_ageover70_count              	;
current_count                    	:= le.current_count                    	;
historical_count                 	:= le.historical_count                 	;
watercraft_count                 	:= le.watercraft_count                 	;
acc_count                        	:= le.acc_count                        	;
acc_damage_amt_total             	:= le.acc_damage_amt_total             	;
acc_last_seen                    	:= le.acc_last_seen                    	;
acc_damage_amt_last              	:= le.acc_damage_amt_last              	;
acc_count_30                     	:= le.acc_count_30                     	;
acc_count_90                     	:= le.acc_count_90                     	;
acc_count_180                    	:= le.acc_count_180                    	;
acc_count_12                     	:= le.acc_count_12                     	;
acc_count_24                     	:= le.acc_count_24                     	;
acc_count_36                     	:= le.acc_count_36                     	;
acc_count_60                     	:= le.acc_count_60                     	;
college_income_level_code        	:= le.college_income_level_code        	;
college_file_type                	:= le.college_file_type                	;
college_attendance               	:= le.college_attendance               	;
prof_license_flag                	:= le.prof_license_flag                	;
prof_license_category            	:= le.prof_license_category            	;
prof_license_source              	:= le.prof_license_source              	;
prof_license_ix_sanct_ct         	:= le.prof_license_ix_sanct_ct         	;
prof_license_ix_sanct_fs         	:= le.prof_license_ix_sanct_fs         	;
prof_license_ix_sanct_ls         	:= le.prof_license_ix_sanct_ls         	;
prof_license_ix_sanct_type       	:= le.prof_license_ix_sanct_type       	;
wealth_index                     	:= le.wealth_index                     	;
input_dob_match_level            	:= le.input_dob_match_level            	;
inferred_age                     	:= le.inferred_age                     	;
addr_stability_v2                	:= le.addr_stability_v2                	;
estimated_income                 	:= le.estimated_income                 	;
//fields from EASI census	:= le.//fields from EASI census	;
c_POP00														:= le.c_POP00	;
c_FAMILIES	:= le.c_FAMILIES	;
c_HH00	:= le.c_HH00	;
c_HHSIZE	:= le.c_HHSIZE	;
c_MED_AGE	:= le.c_MED_AGE	;
c_MED_RENT	:= le.c_MED_RENT	;
c_MED_HVAL	:= le.c_MED_HVAL	;
c_MED_YEARBLT	:= le.c_MED_YEARBLT	;
c_MED_HHINC	:= le.c_MED_HHINC	;
c_URBAN_P	:= le.c_URBAN_P	;
c_RURAL_P	:= le.c_RURAL_P	;
c_FAMMAR_P	:= le.c_FAMMAR_P	;
c_FAMMAR18_P	:= le.c_FAMMAR18_P	;
c_FAMOTF18_P	:= le.c_FAMOTF18_P	;
c_POP_0_5_P	:= le.c_POP_0_5_P	;
c_POP_6_11_P	:= le.c_POP_6_11_P	;
c_POP_12_17_P	:= le.c_POP_12_17_P	;
c_POP_18_24_P	:= le.c_POP_18_24_P	;
c_POP_25_34_P	:= le.c_POP_25_34_P	;
c_POP_35_44_P	:= le.c_POP_35_44_P	;
c_POP_45_54_P	:= le.c_POP_45_54_P	;
c_POP_55_64_P	:= le.c_POP_55_64_P	;
c_POP_65_74_P	:= le.c_POP_65_74_P	;
c_POP_75_84_P	:= le.c_POP_75_84_P	;
c_POP_85P_P	:= le.c_POP_85P_P	;
c_CHILD	:= le.c_CHILD	;
c_YOUNG	:= le.c_YOUNG	;
c_RETIRED	:= le.c_RETIRED	;
c_FEMDIV_P	:= le.c_FEMDIV_P	;
c_HH1_P	:= le.c_HH1_P	;
c_HH2_P	:= le.c_HH2_P	;
c_HH3_P	:= le.c_HH3_P	;
c_HH4_P	:= le.c_HH4_P	;
c_HH5_P	:= le.c_HH5_P	;
c_HH6_P	:= le.c_HH6_P	;
c_HH7P_P	:= le.c_HH7P_P	;
c_VACANT_P	:= le.c_VACANT_P	;
c_OCCUNIT_P	:= le.c_OCCUNIT_P	;
c_OWNOCC_P	:= le.c_OWNOCC_P	;
c_RENTOCC_P	:= le.c_RENTOCC_P	;
c_SFDU_P	:= le.c_SFDU_P	;
c_BIGAPT_P	:= le.c_BIGAPT_P	;
c_TRAILER_P	:= le.c_TRAILER_P	;
c_RNT250_P	:= le.c_RNT250_P	;
c_RNT500_P	:= le.c_RNT500_P	;
c_RNT750_P	:= le.c_RNT750_P	;
c_RNT1000_P	:= le.c_RNT1000_P	;
c_RNT1250_P	:= le.c_RNT1250_P	;
c_RNT1500_P	:= le.c_RNT1500_P	;
c_RNT2000_P	:= le.c_RNT2000_P	;
c_RNT2001_P	:= le.c_RNT2001_P	;
c_HIGHRENT	:= le.c_HIGHRENT	;
c_LOWRENT	:= le.c_LOWRENT	;
c_HVAL_20K_P	:= le.c_HVAL_20K_P	;
c_HVAL_40K_P	:= le.c_HVAL_40K_P	;
c_HVAL_60K_P	:= le.c_HVAL_60K_P	;
c_HVAL_80K_P	:= le.c_HVAL_80K_P	;
c_HVAL_100K_P	:= le.c_HVAL_100K_P	;
c_HVAL_125K_P	:= le.c_HVAL_125K_P	;
c_HVAL_150K_P	:= le.c_HVAL_150K_P	;
c_HVAL_175K_P	:= le.c_HVAL_175K_P	;
c_HVAL_200K_P	:= le.c_HVAL_200K_P	;
c_HVAL_250K_P	:= le.c_HVAL_250K_P	;
c_HVAL_300K_P	:= le.c_HVAL_300K_P	;
c_HVAL_400K_P	:= le.c_HVAL_400K_P	;
c_HVAL_500K_P	:= le.c_HVAL_500K_P	;
c_HVAL_750K_P	:= le.c_HVAL_750K_P	;
c_HVAL_1000K_P	:= le.c_HVAL_1000K_P	;
c_HVAL_1001K_P	:= le.c_HVAL_1001K_P	;
c_LOW_HVAL	:= le.c_LOW_HVAL	;
c_HIGH_HVAL	:= le.c_HIGH_HVAL	;
c_NEWHOUSE	:= le.c_NEWHOUSE	;
c_OLDHOUSE	:= le.c_OLDHOUSE	;
C_INC_15K_P	:= le.C_INC_15K_P	;
C_INC_25K_P	:= le.C_INC_25K_P	;
C_INC_35K_P	:= le.C_INC_35K_P	;
C_INC_50K_P	:= le.C_INC_50K_P	;
C_INC_75K_P	:= le.C_INC_75K_P	;
C_INC_100K_P	:= le.C_INC_100K_P	;
C_INC_125K_P	:= le.C_INC_125K_P	;
C_INC_150K_P	:= le.C_INC_150K_P	;
C_INC_200K_P	:= le.C_INC_200K_P	;
C_INC_201K_P	:= le.C_INC_201K_P	;
c_LOWINC	:= le.c_LOWINC	;
c_HIGHINC	:= le.c_HIGHINC	;
c_POPOVER25	:= le.c_POPOVER25	;
c_POPOVER18	:= le.c_POPOVER18	;
c_LOW_ED	:= le.c_LOW_ED	;
c_HIGH_ED	:= le.c_HIGH_ED	;
c_INCOLLEGE	:= le.c_INCOLLEGE	;
c_UNEMP	:= le.c_UNEMP	;
c_CIV_EMP	:= le.c_CIV_EMP	;
c_MIL_EMP	:= le.c_MIL_EMP	;
c_WHITE_COL	:= le.c_WHITE_COL	;
c_BLUE_COL	:= le.c_BLUE_COL	;
c_MURDERS	:= le.c_MURDERS	;
c_RAPE	:= le.c_RAPE	;
c_ROBBERY	:= le.c_ROBBERY	;
c_ASSAULT	:= le.c_ASSAULT	;
c_BURGLARY	:= le.c_BURGLARY	;
c_LARCENY	:= le.c_LARCENY	;
c_CARTHEFT	:= le.c_CARTHEFT	;
c_TOTCRIME	:= le.c_TOTCRIME	;
c_EASIQLIFE	:= le.c_EASIQLIFE	;
c_CPIALL	:= le.c_CPIALL	;
c_HOUSINGCPI	:= le.c_HOUSINGCPI	;
c_DOMIN_PROF	:= le.c_DOMIN_PROF	;
c_BUSINESS	:= le.c_BUSINESS	;
c_EMPLOYEES	:= le.c_EMPLOYEES	;
c_AGRICULTURE	:= le.c_AGRICULTURE	;
c_MINING	:= le.c_MINING	;
c_CONSTRUCTION	:= le.c_CONSTRUCTION	;
c_MANUFACTURING	:= le.c_MANUFACTURING	;
c_WHOLESALE	:= le.c_WHOLESALE	;
c_RETAIL	:= le.c_RETAIL	;
c_TRANSPORT	:= le.c_TRANSPORT	;
c_INFO	:= le.c_INFO	;
c_FINANCE	:= le.c_FINANCE	;
c_PROFESSIONAL	:= le.c_PROFESSIONAL	;
c_HEALTH	:= le.c_HEALTH	;
c_FOOD	:= le.c_FOOD	;
c_CULT_INDX	:= le.c_CULT_INDX	;
c_AMUS_INDX	:= le.c_AMUS_INDX	;
c_REST_INDX	:= le.c_REST_INDX	;
c_MEDI_INDX	:= le.c_MEDI_INDX	;
c_RELIG_INDX	:= le.c_RELIG_INDX	;
c_EDU_INDX	:= le.c_EDU_INDX	;
c_BARGAINS	:= le.c_BARGAINS	;
c_EXP_PROD	:= le.c_EXP_PROD	;
c_LUX_PROD	:= le.c_LUX_PROD	;
c_MORT_INDX	:= le.c_MORT_INDX	;
c_AB_AV_EDU	:= le.c_AB_AV_EDU	;
c_APT20	:= le.c_APT20	;
c_RENTAL	:= le.c_RENTAL	;
c_PRESCHL	:= le.c_PRESCHL	;
c_BEL_EDU	:= le.c_BEL_EDU	;
c_BLUE_EMPL	:= le.c_BLUE_EMPL	;
c_BORN_USA	:= le.c_BORN_USA	;
c_EXP_HOMES	:= le.c_EXP_HOMES	;
c_NO_TEENS	:= le.c_NO_TEENS	;
c_FOR_SALE	:= le.c_FOR_SALE	;
c_ARMFORCE	:= le.c_ARMFORCE	;
c_LAR_FAM	:= le.c_LAR_FAM	;
c_NO_MOVE	:= le.c_NO_MOVE	;
c_MANY_CARS	:= le.c_MANY_CARS	;
c_MED_INC	:= le.c_MED_INC	;
c_NO_CAR	:= le.c_NO_CAR	;
c_NO_LABFOR	:= le.c_NO_LABFOR	;
c_RICH_OLD	:= le.c_RICH_OLD	;
c_OLD_HOMES	:= le.c_OLD_HOMES	;
c_NEW_HOMES	:= le.c_NEW_HOMES	;
c_RECENT_MOV	:= le.c_RECENT_MOV	;
c_RETIRED2	:= le.c_RETIRED2	;
c_SERV_EMPL	:= le.c_SERV_EMPL	;
c_SUB_BUS	:= le.c_SUB_BUS	;
c_TRAILER	:= le.c_TRAILER	;
c_UNATTACH	:= le.c_UNATTACH	;
c_UNEMPL	:= le.c_UNEMPL	;
c_ASIAN_LANG	:= le.c_ASIAN_LANG	;
c_RICH_ASIAN	:= le.c_RICH_ASIAN	;
c_RICH_BLK	:= le.c_RICH_BLK	;
c_RICH_FAM	:= le.c_RICH_FAM	;
c_RICH_HISP	:= le.c_RICH_HISP	;
c_VERY_RICH	:= le.c_VERY_RICH	;
c_RICH_NFAM	:= le.c_RICH_NFAM	;
c_RICH_WHT	:= le.c_RICH_WHT	;
c_SPAN_LANG	:= le.c_SPAN_LANG	;
c_WORK_HOME	:= le.c_WORK_HOME	;
c_RICH_YOUNG	:= le.c_RICH_YOUNG	;
c_TOTSALES	:= le.c_TOTSALES	;

NULL := models.common.NULL;

// *** Here begins the actual tree code that came directly from the Modeler and is unchanged...

woFDN_FLAPSD_lgt_0 :=  -2.2011724703;

// Tree: 1 
woFDN_FLAPSD_lgt_1 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 7.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0463856816,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 47) => 0.2854108915,
      (c_fammar_p > 47) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.3191397572,
         (r_F00_dob_score_d > 92) => 0.0314958253,
         (r_F00_dob_score_d = NULL) => -0.0158000279, 0.0419795920),
      (c_fammar_p = NULL) => -0.0706822793, 0.0607527109),
   (nf_seg_FraudPoint_3_0 = '') => -0.0196187165, -0.0196187165),
(f_srchfraudsrchcount_i > 7.5) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3.5) => 0.4834006459,
   (r_A44_curr_add_naprop_d > 3.5) => 0.1038006117,
   (r_A44_curr_add_naprop_d = NULL) => 0.3337246229, 0.3337246229),
(f_srchfraudsrchcount_i = NULL) => 0.2671098414, -0.0053600532);

// Tree: 2 
woFDN_FLAPSD_lgt_2 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0384353552,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 43.1) => 0.2782947515,
      (c_fammar_p > 43.1) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0043107200,
         (f_corrrisktype_i > 6.5) => 0.1324863090,
         (f_corrrisktype_i = NULL) => 0.0468140496, 0.0468140496),
      (c_fammar_p = NULL) => -0.0175216972, 0.0618601224),
   (f_inq_Communications_count_i > 1.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 14.5) => 0.2802843441,
      (f_srchfraudsrchcount_i > 14.5) => 0.5807549730,
      (f_srchfraudsrchcount_i = NULL) => 0.3680324039, 0.3680324039),
   (f_inq_Communications_count_i = NULL) => 0.1980308016, 0.0868647515),
(nf_seg_FraudPoint_3_0 = '') => -0.0048606557, -0.0048606557);

// Tree: 3 
woFDN_FLAPSD_lgt_3 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0099841512,
   (f_phone_ver_experian_d > 0.5) => -0.0628388575,
   (f_phone_ver_experian_d = NULL) => -0.0222996739, -0.0335318049),
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 1.5) => 0.1685869545,
      (f_srchunvrfdphonecount_i > 1.5) => 0.3864313034,
      (f_srchunvrfdphonecount_i = NULL) => 0.2082364489, 0.2082364489),
   (r_I60_inq_comm_recency_d > 549) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 12.5) => 0.0314608504,
      (k_inq_per_addr_i > 12.5) => 0.3637154305,
      (k_inq_per_addr_i = NULL) => 0.0390697340, 0.0390697340),
   (r_I60_inq_comm_recency_d = NULL) => 0.1602896218, 0.0673640299),
(nf_seg_FraudPoint_3_0 = '') => -0.0069497095, -0.0069497095);

// Tree: 4 
woFDN_FLAPSD_lgt_4 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => -0.0341693883,
      (f_divrisktype_i > 1.5) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0417625385,
         (f_rel_felony_count_i > 1.5) => 0.4155523063,
         (f_rel_felony_count_i = NULL) => 0.0634499994, 0.0634499994),
      (f_divrisktype_i = NULL) => -0.0214492600, -0.0214492600),
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 46.8) => 0.3199809282,
      (c_fammar_p > 46.8) => 0.0741560407,
      (c_fammar_p = NULL) => 0.0348208410, 0.0967189107),
   (nf_seg_FraudPoint_3_0 = '') => -0.0125740099, -0.0125740099),
(f_inq_HighRiskCredit_count_i > 2.5) => 0.1711899301,
(f_inq_HighRiskCredit_count_i = NULL) => 0.1820196375, -0.0048191890);

// Tree: 5 
woFDN_FLAPSD_lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0025547981,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 0.1171435894,
      (nf_seg_FraudPoint_3_0 = '') => 0.0148626941, 0.0148626941),
   (k_nap_phn_verd_d > 0.5) => -0.0457260089,
   (k_nap_phn_verd_d = NULL) => -0.0239136420, -0.0239136420),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 34.05) => 0.1467295861,
      (c_high_ed > 34.05) => 0.0033594916,
      (c_high_ed = NULL) => 0.0854642081, 0.0854642081),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.3006170956,
   (f_inq_PrepaidCards_count_i = NULL) => 0.1028053467, 0.1028053467),
(f_varrisktype_i = NULL) => 0.1127299523, -0.0087124231);

// Tree: 6 
woFDN_FLAPSD_lgt_6 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.1343365252,
   (f_varrisktype_i > 2.5) => 0.2397795200,
   (f_varrisktype_i = NULL) => 0.1700850049, 0.1700850049),
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1379948344,
      (f_phone_ver_experian_d > 0.5) => -0.0353532022,
      (f_phone_ver_experian_d = NULL) => 0.0823500025, 0.0713617578),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0266604449,
      (k_inq_per_phone_i > 2.5) => 0.1084788117,
      (k_inq_per_phone_i = NULL) => -0.0205435375, -0.0205435375),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0111331821, -0.0111331821),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0873996532, -0.0052488099);

// Tree: 7 
woFDN_FLAPSD_lgt_7 := map(
(NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 0.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.0534487282,
      (r_F01_inp_addr_address_score_d > 95) => -0.0288533133,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0212544237, -0.0212544237),
   (k_inq_ssns_per_addr_i > 2.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 128.5) => 0.2317864683,
      (c_lux_prod > 128.5) => -0.0005231982,
      (c_lux_prod = NULL) => 0.1322984434, 0.1322984434),
   (k_inq_ssns_per_addr_i = NULL) => -0.0153654694, -0.0153654694),
(f_inq_Communications_count24_i > 0.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0395837642,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1538833410,
   (nf_seg_FraudPoint_3_0 = '') => 0.0949577117, 0.0949577117),
(f_inq_Communications_count24_i = NULL) => 0.0977347503, -0.0082003817);

// Tree: 8 
woFDN_FLAPSD_lgt_8 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 16.5) => 
         map(
         (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0540008013,
         (k_nap_phn_verd_d > 0.5) => -0.0299652024,
         (k_nap_phn_verd_d = NULL) => 0.0141698790, 0.0141698790),
      (f_phones_per_addr_curr_i > 16.5) => 0.2355943251,
      (f_phones_per_addr_curr_i = NULL) => 0.0220969097, 0.0220969097),
   (k_inq_per_addr_i > 3.5) => 0.1826165512,
   (k_inq_per_addr_i = NULL) => 0.0390845354, 0.0390845354),
(f_phone_ver_experian_d > 0.5) => -0.0406845616,
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 10.5) => -0.0087820490,
   (f_srchaddrsrchcount_i > 10.5) => 0.2029360455,
   (f_srchaddrsrchcount_i = NULL) => 0.0472783688, 0.0021783762), -0.0051802619);

// Tree: 9 
woFDN_FLAPSD_lgt_9 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1627876853,
   (r_F00_input_dob_match_level_d > 4.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => -0.0272686319,
      (r_D33_eviction_count_i > 0.5) => 0.0805346728,
      (r_D33_eviction_count_i = NULL) => -0.0233259308, -0.0233259308),
   (r_F00_input_dob_match_level_d = NULL) => -0.0194600199, -0.0194600199),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => 0.0405392277,
   (f_crim_rel_under25miles_cnt_i > 1.5) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 137.5) => 0.1063969029,
      (c_cartheft > 137.5) => 0.2456403610,
      (c_cartheft = NULL) => 0.1549488981, 0.1549488981),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0549187843, 0.0661844218),
(f_varrisktype_i = NULL) => 0.0613350122, -0.0092650703);

// Tree: 10 
woFDN_FLAPSD_lgt_10 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 61.25) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 45) => 0.1304457955,
      (r_F01_inp_addr_address_score_d > 45) => 0.0299797342,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0393794764, 0.0393794764),
   (c_fammar_p > 61.25) => -0.0283333847,
   (c_fammar_p = NULL) => -0.0404292172, -0.0172959241),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0771979915,
   (f_assocrisktype_i > 5.5) => 0.1931602894,
   (f_assocrisktype_i = NULL) => 0.0998247813, 0.0998247813),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0729056002,
   (r_S66_adlperssn_count_i > 1.5) => 0.1471640990,
   (r_S66_adlperssn_count_i = NULL) => 0.0454512128, 0.0454512128), -0.0106504301);

// Tree: 11 
woFDN_FLAPSD_lgt_11 := map(
(NULL < c_fammar_p and c_fammar_p <= 61.35) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0377759107,
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 4.5) => 0.2214539378,
      (f_corrssnaddrcount_d > 4.5) => 0.0605696803,
      (f_corrssnaddrcount_d = NULL) => 0.1567923223, 0.1567923223),
   (f_rel_felony_count_i = NULL) => 0.0494595321, 0.0494595321),
(c_fammar_p > 61.35) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 6.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0079878584,
      (f_corrphonelastnamecount_d > 0.5) => -0.0445829480,
      (f_corrphonelastnamecount_d = NULL) => -0.0230199718, -0.0230199718),
   (f_varrisktype_i > 6.5) => 0.2153469337,
   (f_varrisktype_i = NULL) => -0.0013313891, -0.0214162888),
(c_fammar_p = NULL) => -0.0252456688, -0.0095109182);

// Tree: 12 
woFDN_FLAPSD_lgt_12 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 18.5) => 
      map(
      (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 202) => 0.2087860512,
      (r_D32_Mos_Since_Fel_LS_d > 202) => -0.0296629896,
      (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0282090321, -0.0282090321),
   (f_addrchangecrimediff_i > 18.5) => 0.0931750679,
   (f_addrchangecrimediff_i = NULL) => 0.0039676252, -0.0172406956),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 14.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1079694334,
      (f_phone_ver_experian_d > 0.5) => 0.0098279758,
      (f_phone_ver_experian_d = NULL) => 0.0454793630, 0.0520731910),
   (f_srchfraudsrchcount_i > 14.5) => 0.1393255974,
   (f_srchfraudsrchcount_i = NULL) => 0.0602480950, 0.0602480950),
(f_srchvelocityrisktype_i = NULL) => 0.0510321197, -0.0067485091);

// Tree: 13 
woFDN_FLAPSD_lgt_13 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => -0.0149650829,
      (k_inq_per_phone_i > 5.5) => 0.1215333905,
      (k_inq_per_phone_i = NULL) => -0.0128233826, -0.0128233826),
   (f_assocrisktype_i > 7.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0724558196,
      (f_varrisktype_i > 3.5) => 0.1678807148,
      (f_varrisktype_i = NULL) => 0.0834426446, 0.0834426446),
   (f_assocrisktype_i = NULL) => -0.0068702915, -0.0068702915),
(f_inq_PrepaidCards_count_i > 2.5) => 0.2148995826,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 98.5) => -0.0560792073,
   (c_larceny > 98.5) => 0.1597681642,
   (c_larceny = NULL) => 0.0538430652, 0.0538430652), -0.0050579859);

// Tree: 14 
woFDN_FLAPSD_lgt_14 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 16.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
            map(
            (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0537055889,
            (f_corrphonelastnamecount_d > 0.5) => -0.0265333870,
            (f_corrphonelastnamecount_d = NULL) => 0.0188771474, 0.0188771474),
         (f_phone_ver_experian_d > 0.5) => -0.0384314733,
         (f_phone_ver_experian_d = NULL) => -0.0138434974, -0.0145655920),
      (f_srchfraudsrchcount_i > 16.5) => 0.1307794151,
      (f_srchfraudsrchcount_i = NULL) => -0.0135195070, -0.0135195070),
   (f_srchcomponentrisktype_i > 1.5) => 0.1044188869,
   (f_srchcomponentrisktype_i = NULL) => -0.0092666462, -0.0092666462),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.1469068165,
(f_inq_PrepaidCards_count24_i = NULL) => 0.0266858531, -0.0068363871);

// Tree: 15 
woFDN_FLAPSD_lgt_15 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 3.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 28.45) => -0.0145812256,
   (c_famotf18_p > 28.45) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0223335656,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.0993007446,
      (nf_seg_FraudPoint_3_0 = '') => 0.0477798575, 0.0477798575),
   (c_famotf18_p = NULL) => -0.0374843464, -0.0100440002),
(f_divrisktype_i > 3.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0339940348,
   (f_varrisktype_i > 2.5) => 0.1697939808,
   (f_varrisktype_i = NULL) => 0.0891627628, 0.0891627628),
(f_divrisktype_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 86.5) => -0.0554068506,
   (c_larceny > 86.5) => 0.1297546955,
   (c_larceny = NULL) => 0.0380079835, 0.0380079835), -0.0063662835);

// Tree: 16 
woFDN_FLAPSD_lgt_16 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 0.0050887479,
      (k_inq_per_ssn_i > 3.5) => 0.1443998100,
      (k_inq_per_ssn_i = NULL) => 0.0122738457, 0.0122738457),
   (f_assocrisktype_i > 4.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 16.15) => 0.2713414019,
         (c_hh2_p > 16.15) => 0.0682071936,
         (c_hh2_p = NULL) => 0.0835838867, 0.0835838867),
      (k_inq_per_phone_i > 1.5) => 0.2915167943,
      (k_inq_per_phone_i = NULL) => 0.0977889616, 0.0977889616),
   (f_assocrisktype_i = NULL) => 0.0926879059, 0.0287964742),
(k_nap_phn_verd_d > 0.5) => -0.0252896015,
(k_nap_phn_verd_d = NULL) => -0.0049769437, -0.0049769437);

// Tree: 17 
woFDN_FLAPSD_lgt_17 := map(
(NULL < c_unempl and c_unempl <= 175.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 165.5) => 0.0310595204,
      (c_sub_bus > 165.5) => 0.1430699050,
      (c_sub_bus = NULL) => 0.0545273869, 0.0545273869),
   (f_corrssnaddrcount_d > 2.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 6.5) => -0.0251956251,
      (f_srchaddrsrchcount_i > 6.5) => 0.0444888449,
      (f_srchaddrsrchcount_i = NULL) => -0.0176090619, -0.0176090619),
   (f_corrssnaddrcount_d = NULL) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0810509261,
      (r_S66_adlperssn_count_i > 1.5) => 0.1028874316,
      (r_S66_adlperssn_count_i = NULL) => 0.0100076668, 0.0100076668), -0.0107513311),
(c_unempl > 175.5) => 0.1003899805,
(c_unempl = NULL) => -0.0484253513, -0.0073341227);

// Tree: 18 
woFDN_FLAPSD_lgt_18 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -10912.5) => 0.0716205328,
   (f_addrchangevaluediff_d > -10912.5) => -0.0210151089,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0130289008,
      (k_inq_per_phone_i > 2.5) => 0.1630632410,
      (k_inq_per_phone_i = NULL) => -0.0040171692, -0.0040171692), -0.0139404245),
(f_assocrisktype_i > 5.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 3) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1443265615,
      (r_D33_Eviction_Recency_d > 79.5) => 0.0332909649,
      (r_D33_Eviction_Recency_d = NULL) => 0.0400410797, 0.0400410797),
   (f_idrisktype_i > 3) => 0.2097599328,
   (f_idrisktype_i = NULL) => 0.0488348026, 0.0488348026),
(f_assocrisktype_i = NULL) => 0.0195311105, -0.0060145375);

// Tree: 19 
woFDN_FLAPSD_lgt_19 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0435274112,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1760625086,
      (nf_seg_FraudPoint_3_0 = '') => 0.0856267950, 0.0856267950),
   (r_F00_input_dob_match_level_d > 4.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 2.5) => 0.2598089066,
      (f_M_Bureau_ADL_FS_all_d > 2.5) => -0.0116732046,
      (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0104273446, -0.0104273446),
   (r_F00_input_dob_match_level_d = NULL) => 0.0224278166, -0.0081230981),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1190360513,
   (f_phone_ver_experian_d > 0.5) => 0.0130601747,
   (f_phone_ver_experian_d = NULL) => 0.1236714829, 0.0695792646),
(k_inq_ssns_per_addr_i = NULL) => -0.0047050517, -0.0047050517);

// Tree: 20 
woFDN_FLAPSD_lgt_20 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 8.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 35.15) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 58.5) => 0.2680469129,
      (c_easiqlife > 58.5) => 0.0529151632,
      (c_easiqlife = NULL) => 0.0830456603, 0.0830456603),
   (c_fammar_p > 35.15) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0188794903,
      (k_inq_per_ssn_i > 2.5) => 0.0432406105,
      (k_inq_per_ssn_i = NULL) => -0.0120837728, -0.0120837728),
   (c_fammar_p = NULL) => -0.0318228168, -0.0097919318),
(k_inq_per_addr_i > 8.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1490583175,
   (f_phone_ver_experian_d > 0.5) => 0.0129361353,
   (f_phone_ver_experian_d = NULL) => 0.1043181934, 0.0816873978),
(k_inq_per_addr_i = NULL) => -0.0071019996, -0.0071019996);

// Tree: 21 
woFDN_FLAPSD_lgt_21 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1416183698,
      (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
         map(
         (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 0.0139074387,
         (r_D32_felony_count_i > 0.5) => 0.1545749064,
         (r_D32_felony_count_i = NULL) => 0.0167132219, 0.0167132219),
      (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0464303515, 0.0194991086),
   (k_inq_per_phone_i > 2.5) => 0.1452353481,
   (k_inq_per_phone_i = NULL) => 0.0238193984, 0.0238193984),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => -0.0240550663,
   (r_D30_Derog_Count_i > 11.5) => 0.1594882516,
   (r_D30_Derog_Count_i = NULL) => -0.0219105419, -0.0219105419),
(k_nap_phn_verd_d = NULL) => -0.0047036830, -0.0047036830);

// Tree: 22 
woFDN_FLAPSD_lgt_22 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 66.5) => 0.0968180022,
      (c_born_usa > 66.5) => 0.0143789417,
      (c_born_usa = NULL) => 0.0028492875, 0.0481858517),
   (f_phone_ver_experian_d > 0.5) => -0.0239191995,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < c_unempl and c_unempl <= 174.5) => 0.0066364291,
      (c_unempl > 174.5) => 0.1617132054,
      (c_unempl = NULL) => -0.0642972389, 0.0120006732), 0.0160444973),
(f_corrphonelastnamecount_d > 0.5) => -0.0292524702,
(f_corrphonelastnamecount_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0742642644,
   (k_comb_age_d > 25.5) => 0.0914834064,
   (k_comb_age_d = NULL) => 0.0054822564, 0.0054822564), -0.0092258072);

// Tree: 23 
woFDN_FLAPSD_lgt_23 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 9.5) => -0.0195501358,
   (r_D30_Derog_Count_i > 9.5) => 0.1050770131,
   (r_D30_Derog_Count_i = NULL) => -0.0175777857, -0.0175777857),
(f_divrisktype_i > 1.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0275572478,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 84.5) => -0.0256897641,
      (c_unattach > 84.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1045065259,
         (f_phone_ver_experian_d > 0.5) => 0.0783564066,
         (f_phone_ver_experian_d = NULL) => 0.2428883661, 0.1290255641),
      (c_unattach = NULL) => 0.0897327824, 0.0897327824),
   (f_rel_felony_count_i = NULL) => 0.0387015864, 0.0387015864),
(f_divrisktype_i = NULL) => 0.0161930205, -0.0094444221);

// Tree: 24 
woFDN_FLAPSD_lgt_24 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1682877130,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0193583773,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0179969005, -0.0179969005),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 0.1967187405,
   (f_attr_arrest_recency_d > 99.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => 0.0263658472,
      (k_inq_per_ssn_i > 10.5) => 0.1610184942,
      (k_inq_per_ssn_i = NULL) => 0.0283377479, 0.0283377479),
   (f_attr_arrest_recency_d = NULL) => 0.0311520355, 0.0311520355),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.1057620548,
   (k_comb_age_d > 26.5) => 0.0689534496,
   (k_comb_age_d = NULL) => -0.0114466055, -0.0114466055), -0.0028703419);

// Tree: 25 
woFDN_FLAPSD_lgt_25 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 6.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 43.15) => 0.1479343640,
      (c_fammar_p > 43.15) => 0.0283798712,
      (c_fammar_p = NULL) => 0.0574587450, 0.0387692182),
   (f_corrssnaddrcount_d > 2.5) => -0.0186321180,
   (f_corrssnaddrcount_d = NULL) => 0.0046410443, -0.0129077510),
(f_phones_per_addr_curr_i > 6.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 25.35) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 4.5) => 0.2253977033,
      (f_prevaddrageoldest_d > 4.5) => 0.0618308429,
      (f_prevaddrageoldest_d = NULL) => 0.0761291947, 0.0761291947),
   (c_high_ed > 25.35) => 0.0101059926,
   (c_high_ed = NULL) => 0.0398263215, 0.0398263215),
(f_phones_per_addr_curr_i = NULL) => -0.0031424900, -0.0031424900);

// Tree: 26 
woFDN_FLAPSD_lgt_26 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.1560316145,
      (r_F00_dob_score_d > 55) => -0.0122335133,
      (r_F00_dob_score_d = NULL) => -0.0084059208, -0.0112192920),
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1361022144,
      (f_phone_ver_experian_d > 0.5) => 0.0007568255,
      (f_phone_ver_experian_d = NULL) => 0.0371453011, 0.0474718859),
   (k_inq_per_phone_i = NULL) => -0.0086216523, -0.0086216523),
(f_inq_Communications_count_i > 1.5) => 0.0664606986,
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 77.5) => -0.0647778641,
   (c_bel_edu > 77.5) => 0.0839899312,
   (c_bel_edu = NULL) => 0.0216034364, 0.0216034364), -0.0058034745);

// Tree: 27 
woFDN_FLAPSD_lgt_27 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1849974651,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => 0.0119106015,
      (k_inq_per_phone_i > 1.5) => 0.0950440164,
      (k_inq_per_phone_i = NULL) => 0.0183940384, 0.0183940384),
   (f_phone_ver_experian_d > 0.5) => -0.0303751003,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 15.5) => -0.0152142947,
      (f_rel_under500miles_cnt_d > 15.5) => 0.0796514076,
      (f_rel_under500miles_cnt_d = NULL) => -0.0612530325, -0.0072146945), -0.0095568674),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0635170527,
   (r_S66_adlperssn_count_i > 1.5) => 0.0901137040,
   (r_S66_adlperssn_count_i = NULL) => 0.0147755445, 0.0147755445), -0.0079310003);

// Tree: 28 
woFDN_FLAPSD_lgt_28 := map(
(NULL < c_unemp and c_unemp <= 8.25) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0120413666,
   (f_corrrisktype_i > 8.5) => 0.0641448536,
   (f_corrrisktype_i = NULL) => -0.0093275147, -0.0097256676),
(c_unemp > 8.25) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1479662544,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 33) => -0.0014114254,
      (c_rnt750_p > 33) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 87.5) => 0.1423956612,
         (c_rich_wht > 87.5) => -0.0119818819,
         (c_rich_wht = NULL) => 0.0974083403, 0.0974083403),
      (c_rnt750_p = NULL) => 0.0385083313, 0.0385083313),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0460832741, 0.0460832741),
(c_unemp = NULL) => -0.0314049725, -0.0063550586);

// Tree: 29 
woFDN_FLAPSD_lgt_29 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => -0.0135009626,
   (k_comb_age_d > 73.5) => 0.1127662747,
   (k_comb_age_d = NULL) => -0.0080132518, -0.0080132518),
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 14.55) => 0.1519112295,
   (c_hh2_p > 14.55) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1455691408,
      (r_F00_dob_score_d > 92) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 168.5) => 0.0107163968,
         (r_C13_Curr_Addr_LRes_d > 168.5) => 0.1577108879,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0197019535, 0.0197019535),
      (r_F00_dob_score_d = NULL) => 0.0186616660, 0.0254449489),
   (c_hh2_p = NULL) => -0.0219897202, 0.0277595887),
(f_corrrisktype_i = NULL) => 0.0013457454, -0.0010200534);

// Tree: 30 
woFDN_FLAPSD_lgt_30 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0124146179,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 0.0399592086,
         (r_L79_adls_per_addr_curr_i > 4.5) => 0.1558496052,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0630383772, 0.0630383772),
      (r_D30_Derog_Count_i > 8.5) => 0.1783200308,
      (r_D30_Derog_Count_i = NULL) => 0.0722428024, 0.0722428024),
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0070638823,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0340539609, 0.0340539609),
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 29.5) => -0.0614403894,
   (k_comb_age_d > 29.5) => 0.0994485336,
   (k_comb_age_d = NULL) => 0.0139309980, 0.0139309980), -0.0054253478);

// Tree: 31 
woFDN_FLAPSD_lgt_31 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 178.5) => 0.0188332769,
      (c_sub_bus > 178.5) => 0.1472665435,
      (c_sub_bus = NULL) => 0.0237570987, 0.0370471614),
   (f_corrssnaddrcount_d > 1.5) => -0.0119911900,
   (f_corrssnaddrcount_d = NULL) => -0.0095350096, -0.0095350096),
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 10.55) => -0.0023627711,
   (c_blue_col > 10.55) => 0.1060046667,
   (c_blue_col = NULL) => 0.0582686973, 0.0582686973),
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 76.5) => -0.0804387051,
   (c_bel_edu > 76.5) => 0.0767336517,
   (c_bel_edu = NULL) => 0.0110304534, 0.0110304534), -0.0067613190);

// Tree: 32 
woFDN_FLAPSD_lgt_32 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 5.5) => 0.0094007561,
   (f_phones_per_addr_curr_i > 5.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 6.45) => -0.0158912628,
      (c_pop_18_24_p > 6.45) => 0.1269008738,
      (c_pop_18_24_p = NULL) => 0.0871230643, 0.0871230643),
   (f_phones_per_addr_curr_i = NULL) => 0.0382145478, 0.0382145478),
(r_I60_inq_comm_recency_d > 549) => 
   map(
   (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 0.5) => -0.0200197658,
   (f_hh_age_65_plus_d > 0.5) => 
      map(
      (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => 0.0220009000,
      (f_srchaddrsrchcountmo_i > 0.5) => 0.1635393917,
      (f_srchaddrsrchcountmo_i = NULL) => 0.0287542277, 0.0287542277),
   (f_hh_age_65_plus_d = NULL) => -0.0092934110, -0.0092934110),
(r_I60_inq_comm_recency_d = NULL) => 0.0042331362, -0.0049049642);

// Tree: 33 
woFDN_FLAPSD_lgt_33 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => -0.0162615597,
(f_rel_criminal_count_i > 1.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 8331.5) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 10.5) => 0.0009380882,
         (f_assocsuspicousidcount_i > 10.5) => 0.1305739017,
         (f_assocsuspicousidcount_i = NULL) => 0.0057212450, 0.0057212450),
      (f_addrchangeincomediff_d > 8331.5) => 
         map(
         (NULL < c_construction and c_construction <= 5) => 0.2150165405,
         (c_construction > 5) => 0.0289502145,
         (c_construction = NULL) => 0.1072939307, 0.1072939307),
      (f_addrchangeincomediff_d = NULL) => 0.0184857243, 0.0126369823),
   (f_hh_payday_loan_users_i > 0.5) => 0.0732559587,
   (f_hh_payday_loan_users_i = NULL) => 0.0198391146, 0.0198391146),
(f_rel_criminal_count_i = NULL) => 0.0012960526, -0.0021623010);

// Tree: 34 
woFDN_FLAPSD_lgt_34 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 185.5) => -0.0207950075,
   (c_unempl > 185.5) => 0.0994572569,
   (c_unempl = NULL) => -0.0330789872, -0.0195482203),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 67908.5) => 0.0141716128,
   (f_addrchangevaluediff_d > 67908.5) => 0.1515134285,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_business and c_business <= 6.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 54.85) => 0.2467489377,
         (c_civ_emp > 54.85) => 0.0316379826,
         (c_civ_emp = NULL) => 0.1160185230, 0.1160185230),
      (c_business > 6.5) => 0.0094390238,
      (c_business = NULL) => 0.0332549365, 0.0332549365), 0.0208660381),
(f_hh_lienholders_i = NULL) => 0.0002311368, -0.0069290451);

// Tree: 35 
woFDN_FLAPSD_lgt_35 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 54.5) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => -0.0140636261,
         (f_assocsuspicousidcount_i > 14.5) => 0.1301537386,
         (f_assocsuspicousidcount_i = NULL) => -0.0131347151, -0.0131347151),
      (f_addrchangecrimediff_i > 54.5) => 0.0706117133,
      (f_addrchangecrimediff_i = NULL) => 0.0027094261, -0.0084354900),
   (f_srchssnsrchcount_i > 21.5) => 0.0933978637,
   (f_srchssnsrchcount_i = NULL) => -0.0048046537, -0.0077526920),
(k_comb_age_d > 73.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 4.05) => 0.3091646952,
   (C_INC_125K_P > 4.05) => 0.0802440500,
   (C_INC_125K_P = NULL) => 0.1093441320, 0.1093441320),
(k_comb_age_d = NULL) => -0.0032940585, -0.0032940585);

// Tree: 36 
woFDN_FLAPSD_lgt_36 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 0.1287473434,
   (r_I60_inq_comm_recency_d > 4.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0134280894,
      (f_assocsuspicousidcount_i > 13.5) => 0.1411322337,
      (f_assocsuspicousidcount_i = NULL) => -0.0124004467, -0.0124004467),
   (r_I60_inq_comm_recency_d = NULL) => 0.0151888918, -0.0112712640),
(k_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 80178) => 0.1237870234,
   (r_L80_Inp_AVM_AutoVal_d > 80178) => 0.0241644041,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 37.5) => 0.1396905706,
      (f_mos_inq_banko_om_lseen_d > 37.5) => 0.0219035945,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0418165442, 0.0418165442), 0.0405891530),
(k_inq_ssns_per_addr_i = NULL) => -0.0043619928, -0.0043619928);

// Tree: 37 
woFDN_FLAPSD_lgt_37 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0095879770,
   (f_hh_tot_derog_i > 4.5) => 0.0622572059,
   (f_hh_tot_derog_i = NULL) => -0.0062259082, -0.0062259082),
(f_divaddrsuspidcountnew_i > 2.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.55) => 0.0078360479,
   (c_pop_6_11_p > 7.55) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 125) => 0.1938465825,
      (c_lux_prod > 125) => 0.0197692063,
      (c_lux_prod = NULL) => 0.1403649790, 0.1403649790),
   (c_pop_6_11_p = NULL) => 0.0792639783, 0.0792639783),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0852409151,
   (k_comb_age_d > 26.5) => 0.0628162819,
   (k_comb_age_d = NULL) => -0.0070996167, -0.0070996167), -0.0041373789);

// Tree: 38 
woFDN_FLAPSD_lgt_38 := map(
(NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 5.5) => 
   map(
   (NULL < c_child and c_child <= 23.5) => 0.0116732763,
   (c_child > 23.5) => 0.2392152418,
   (c_child = NULL) => 0.1254442591, 0.1254442591),
(f_M_Bureau_ADL_FS_all_d > 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','6: Other']) => -0.0306080700,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 0.75) => 0.1941920063,
         (c_pop_85p_p > 0.75) => 0.0240199740,
         (c_pop_85p_p = NULL) => 0.0940908108, 0.0940908108),
      (r_F00_input_dob_match_level_d > 4.5) => 0.0121155767,
      (r_F00_input_dob_match_level_d = NULL) => 0.0135910054, 0.0135910054),
   (nf_seg_FraudPoint_3_0 = '') => -0.0027022386, -0.0027022386),
(f_M_Bureau_ADL_FS_all_d = NULL) => 0.0005035748, -0.0009873703);

// Tree: 39 
woFDN_FLAPSD_lgt_39 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 86.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 74.35) => 
         map(
         (NULL < r_C15_ssns_per_adl_c6_i and r_C15_ssns_per_adl_c6_i <= 0.5) => 0.0174147430,
         (r_C15_ssns_per_adl_c6_i > 0.5) => 0.1596773236,
         (r_C15_ssns_per_adl_c6_i = NULL) => 0.0233382370, 0.0233382370),
      (c_fammar_p > 74.35) => -0.0409085439,
      (c_fammar_p = NULL) => -0.0157580619, -0.0111061428),
   (f_prevaddrageoldest_d > 86.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.2527534424,
      (r_F00_dob_score_d > 92) => 0.0514785836,
      (r_F00_dob_score_d = NULL) => 0.0627367954, 0.0627367954),
   (f_prevaddrageoldest_d = NULL) => 0.0214406090, 0.0124137596),
(k_nap_phn_verd_d > 0.5) => -0.0223189361,
(k_nap_phn_verd_d = NULL) => -0.0092363330, -0.0092363330);

// Tree: 40 
woFDN_FLAPSD_lgt_40 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 52.85) => -0.0030405152,
   (c_low_ed > 52.85) => 0.2058147107,
   (c_low_ed = NULL) => 0.0921728966, 0.0921728966),
(f_attr_arrest_recency_d > 99.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 19.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 0.0983791666,
         (r_I60_inq_banking_recency_d > 9) => 0.0121580838,
         (r_I60_inq_banking_recency_d = NULL) => 0.0185084597, 0.0185084597),
      (f_phone_ver_experian_d > 0.5) => -0.0212139123,
      (f_phone_ver_experian_d = NULL) => -0.0058096429, -0.0051971558),
   (k_inq_per_addr_i > 19.5) => 0.1060961575,
   (k_inq_per_addr_i = NULL) => -0.0044812129, -0.0044812129),
(f_attr_arrest_recency_d = NULL) => -0.0016079046, -0.0034193570);

// Tree: 41 
woFDN_FLAPSD_lgt_41 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 83.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 14.75) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 0.1092556943,
      (f_phone_ver_insurance_d > 3.5) => -0.0163129845,
      (f_phone_ver_insurance_d = NULL) => 0.0566857268, 0.0566857268),
   (c_hh2_p > 14.75) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.0694741200,
      (r_F00_input_dob_match_level_d > 4.5) => -0.0083242208,
      (r_F00_input_dob_match_level_d = NULL) => 
         map(
         (NULL < c_larceny and c_larceny <= 86.5) => -0.0788954516,
         (c_larceny > 86.5) => 0.0583419021,
         (c_larceny = NULL) => -0.0176287758, -0.0176287758), -0.0069241603),
   (c_hh2_p = NULL) => -0.0250366805, -0.0049630996),
(k_comb_age_d > 83.5) => 0.1652588472,
(k_comb_age_d = NULL) => -0.0032454481, -0.0032454481);

// Tree: 42 
woFDN_FLAPSD_lgt_42 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
         map(
         (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.0163187422,
         (f_prevaddrstatus_i > 2.5) => -0.0081436599,
         (f_prevaddrstatus_i = NULL) => -0.0249855731, -0.0125553255),
      (f_inq_PrepaidCards_count_i > 2.5) => 0.1017326421,
      (f_inq_PrepaidCards_count_i = NULL) => 0.0082544673, -0.0117870678),
   (k_comb_age_d > 73.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 146.5) => 0.0302642045,
      (c_span_lang > 146.5) => 0.1869353963,
      (c_span_lang = NULL) => 0.0703585525, 0.0703585525),
   (k_comb_age_d = NULL) => -0.0087118894, -0.0087118894),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1372630740,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0081365053, -0.0081365053);

// Tree: 43 
woFDN_FLAPSD_lgt_43 := map(
(NULL < c_unemp and c_unemp <= 10.85) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 81.5) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1955.5) => 0.1458660903,
         (c_med_yearblt > 1955.5) => 0.0173140809,
         (c_med_yearblt = NULL) => 0.0421523010, 0.0421523010),
      (r_I60_inq_recency_d > 2) => -0.0106411156,
      (r_I60_inq_recency_d = NULL) => -0.0090688930, -0.0076646498),
   (f_phones_per_addr_curr_i > 81.5) => 0.1700795323,
   (f_phones_per_addr_curr_i = NULL) => -0.0068444047, -0.0068444047),
(c_unemp > 10.85) => 
   map(
   (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 0.1210265933,
   (r_Prop_Owner_History_d > 0.5) => 0.0143295383,
   (r_Prop_Owner_History_d = NULL) => 0.0555177397, 0.0555177397),
(c_unemp = NULL) => -0.0419261180, -0.0062606700);

// Tree: 44 
woFDN_FLAPSD_lgt_44 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 482004.5) => -0.0055337296,
   (f_prevaddrmedianvalue_d > 482004.5) => 0.0489492653,
   (f_prevaddrmedianvalue_d = NULL) => 
      map(
      (NULL < c_larceny and c_larceny <= 80.5) => -0.0983995978,
      (c_larceny > 80.5) => 0.0444192904,
      (c_larceny = NULL) => -0.0262968581, -0.0262968581), 0.0010363892),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 79769) => 0.1588385458,
   (r_L80_Inp_AVM_AutoVal_d > 79769) => 0.0284751114,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 12.65) => 0.0724125172,
      (c_pop_18_24_p > 12.65) => -0.1020172757,
      (c_pop_18_24_p = NULL) => 0.0339918580, 0.0339918580), 0.0445881240),
(k_inq_ssns_per_addr_i = NULL) => 0.0029178516, 0.0029178516);

// Tree: 45 
woFDN_FLAPSD_lgt_45 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 14.5) => -0.0038059811,
   (r_D30_Derog_Count_i > 14.5) => 0.0957394346,
   (r_D30_Derog_Count_i = NULL) => -0.0093792893, -0.0032037801),
(r_L79_adls_per_addr_c6_i > 3.5) => 
   map(
   (NULL < c_professional and c_professional <= 1.45) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 121.5) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 94) => 0.0596075588,
         (f_curraddrcartheftindex_i > 94) => 0.2624282946,
         (f_curraddrcartheftindex_i = NULL) => 0.1822433526, 0.1822433526),
      (f_M_Bureau_ADL_FS_all_d > 121.5) => 0.0502798017,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1034776081, 0.1034776081),
   (c_professional > 1.45) => 0.0178260086,
   (c_professional = NULL) => 0.0443624908, 0.0443624908),
(r_L79_adls_per_addr_c6_i = NULL) => 0.0007935116, 0.0007935116);

// Tree: 46 
woFDN_FLAPSD_lgt_46 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1108515846,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0076008267,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 114.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.85) => 0.0328803758,
         (c_pop_35_44_p > 13.85) => 
            map(
            (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 4.5) => 0.2611403193,
            (f_srchaddrsrchcount_i > 4.5) => 0.0375698609,
            (f_srchaddrsrchcount_i = NULL) => 0.1588531815, 0.1588531815),
         (c_pop_35_44_p = NULL) => 0.0895681384, 0.0895681384),
      (c_many_cars > 114.5) => -0.0078843325,
      (c_many_cars = NULL) => 0.0450451245, 0.0450451245),
   (f_hh_tot_derog_i = NULL) => -0.0049369668, -0.0049369668),
(r_C10_M_Hdr_FS_d = NULL) => 0.0110697711, -0.0041497796);

// Tree: 47 
woFDN_FLAPSD_lgt_47 := map(
(NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1125714853,
   (f_attr_arrest_recency_d > 79.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0121887049,
      (k_inq_per_phone_i > 1.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.305) => -0.0462953796,
         (c_hhsize > 2.305) => 
            map(
            (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1177305730,
            (k_nap_phn_verd_d > 0.5) => 0.0374323406,
            (k_nap_phn_verd_d = NULL) => 0.0579317571, 0.0579317571),
         (c_hhsize = NULL) => 0.0302796596, 0.0302796596),
      (k_inq_per_phone_i = NULL) => -0.0084068028, -0.0084068028),
   (f_attr_arrest_recency_d = NULL) => -0.0076260989, -0.0076260989),
(f_srchunvrfdssncount_i > 0.5) => 0.0528108017,
(f_srchunvrfdssncount_i = NULL) => -0.0068456001, -0.0037937943);

// Tree: 48 
woFDN_FLAPSD_lgt_48 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 15.7) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 25.5) => 0.1992054205,
         (c_hh2_p > 25.5) => 0.0364017803,
         (c_hh2_p = NULL) => 0.0727728063, 0.0727728063),
      (r_D32_Mos_Since_Crim_LS_d > 14.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0104651371,
         (k_comb_age_d > 81.5) => 0.1086494428,
         (k_comb_age_d = NULL) => -0.0087811137, -0.0087811137),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0068905913, -0.0068905913),
   (c_unemp > 15.7) => 0.1199405257,
   (c_unemp = NULL) => -0.0282572353, -0.0068517207),
(r_D33_eviction_count_i > 3.5) => 0.1019345167,
(r_D33_eviction_count_i = NULL) => -0.0175806383, -0.0061541950);

// Tree: 49 
woFDN_FLAPSD_lgt_49 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 67343.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 6.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 64892) => -0.0061760138,
      (r_L80_Inp_AVM_AutoVal_d > 64892) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','6: Other']) => 0.0511118945,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 0.2361007761,
         (nf_seg_FraudPoint_3_0 = '') => 0.1370926423, 0.1370926423),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0290604457, 0.0332028656),
   (f_sourcerisktype_i > 6.5) => 0.1655439848,
   (f_sourcerisktype_i = NULL) => 0.0491784702, 0.0491784702),
(r_A46_Curr_AVM_AutoVal_d > 67343.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0193192017,
   (r_L70_Add_Standardized_i > 0.5) => 0.0798159251,
   (r_L70_Add_Standardized_i = NULL) => -0.0137707622, -0.0137707622),
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0067530973, -0.0074418937);

// Tree: 50 
woFDN_FLAPSD_lgt_50 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21902.5) => 0.1403618699,
   (r_A46_Curr_AVM_AutoVal_d > 21902.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -25.5) => 0.1154067753,
      (f_addrchangecrimediff_i > -25.5) => 0.0099923421,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 8788.5) => 
            map(
            (NULL < c_born_usa and c_born_usa <= 38.5) => 0.1907307177,
            (c_born_usa > 38.5) => -0.0476489300,
            (c_born_usa = NULL) => 0.0035055008, 0.0035055008),
         (r_A49_Curr_AVM_Chg_1yr_i > 8788.5) => 0.1426640023,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0063660726, 0.0366248704), 0.0181317374),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0023225155, 0.0118668062),
(f_phone_ver_insurance_d > 3.5) => -0.0218622912,
(f_phone_ver_insurance_d = NULL) => -0.0149462987, -0.0048362880);

// Tree: 51 
woFDN_FLAPSD_lgt_51 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 19.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0161393262,
   (f_crim_rel_under100miles_cnt_i > 0.5) => 
      map(
      (NULL < c_construction and c_construction <= 2.15) => 
         map(
         (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 0.0891194447,
         (r_Ever_Asset_Owner_d > 0.5) => 0.0300135977,
         (r_Ever_Asset_Owner_d = NULL) => 0.0435302025, 0.0435302025),
      (c_construction > 2.15) => 0.0035234307,
      (c_construction = NULL) => 0.0140577582, 0.0140577582),
   (f_crim_rel_under100miles_cnt_i = NULL) => 
      map(
      (NULL < c_child and c_child <= 27.95) => -0.0226788617,
      (c_child > 27.95) => 0.1170577035,
      (c_child = NULL) => 0.0010418516, 0.0010418516), -0.0018601076),
(k_inq_per_ssn_i > 19.5) => 0.1386857165,
(k_inq_per_ssn_i = NULL) => -0.0012174858, -0.0012174858);

// Tree: 52 
woFDN_FLAPSD_lgt_52 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 59.5) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => -0.0129953952,
   (f_divaddrsuspidcountnew_i > 0.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 170.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 2.5) => 0.1274709620,
         (f_M_Bureau_ADL_FS_all_d > 2.5) => 0.0054745382,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0086058002, 0.0086058002),
      (c_no_car > 170.5) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 351.5) => 0.1643886175,
         (c_hh00 > 351.5) => 0.0571388605,
         (c_hh00 = NULL) => 0.0746314679, 0.0746314679),
      (c_no_car = NULL) => 0.0190647582, 0.0190647582),
   (f_divaddrsuspidcountnew_i = NULL) => 0.0078312617, -0.0066760246),
(f_phones_per_addr_curr_i > 59.5) => 0.1079265677,
(f_phones_per_addr_curr_i = NULL) => -0.0053479536, -0.0053479536);

// Tree: 53 
woFDN_FLAPSD_lgt_53 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0135536077,
(f_crim_rel_under25miles_cnt_i > 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 5.5) => 0.0170768470,
   (k_inq_per_ssn_i > 5.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 0.1398871433,
      (r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0440781515,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0954037319, 0.0954037319),
   (k_inq_per_ssn_i = NULL) => 0.0207742276, 0.0207742276),
(f_crim_rel_under25miles_cnt_i = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 157.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1030641155,
      (k_nap_phn_verd_d > 0.5) => -0.0409226065,
      (k_nap_phn_verd_d = NULL) => 0.0383994200, 0.0383994200),
   (c_asian_lang > 157.5) => -0.0680528963,
   (c_asian_lang = NULL) => -0.0114365370, -0.0114365370), 0.0004881866);

// Tree: 54 
woFDN_FLAPSD_lgt_54 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 3.5) => -0.0284029856,
(f_corrrisktype_i > 3.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 128.5) => 0.0002169134,
   (f_prevaddrageoldest_d > 128.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < c_med_rent and c_med_rent <= 853.5) => 0.0387267821,
         (c_med_rent > 853.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02759615385) => 0.1054906085,
            (f_add_curr_nhood_BUS_pct_i > 0.02759615385) => 0.2364201758,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1685700357, 0.1685700357),
         (c_med_rent = NULL) => 0.0955196576, 0.0955196576),
      (f_phone_ver_experian_d > 0.5) => 0.0156139134,
      (f_phone_ver_experian_d = NULL) => 0.0638464019, 0.0615172929),
   (f_prevaddrageoldest_d = NULL) => 0.0111257531, 0.0111257531),
(f_corrrisktype_i = NULL) => 0.0003294492, -0.0045994770);

// Tree: 55 
woFDN_FLAPSD_lgt_55 := map(
(NULL < c_hval_40k_p and c_hval_40k_p <= 35.05) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.4391646324) => 
         map(
         (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1078061450,
         (r_F00_input_dob_match_level_d > 4.5) => 
            map(
            (NULL < c_hh2_p and c_hh2_p <= 14.35) => 0.1058088703,
            (c_hh2_p > 14.35) => 0.0123141230,
            (c_hh2_p = NULL) => 0.0159554974, 0.0159554974),
         (r_F00_input_dob_match_level_d = NULL) => 0.0238873589, 0.0188380961),
      (f_add_input_mobility_index_i > 0.4391646324) => -0.0485775701,
      (f_add_input_mobility_index_i = NULL) => 0.0109332612, 0.0109332612),
   (k_nap_phn_verd_d > 0.5) => -0.0162938175,
   (k_nap_phn_verd_d = NULL) => -0.0063244294, -0.0063244294),
(c_hval_40k_p > 35.05) => -0.1350774544,
(c_hval_40k_p = NULL) => 0.0037383150, -0.0068710079);

// Tree: 56 
woFDN_FLAPSD_lgt_56 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 0.5) => 0.1815796578,
   (f_divssnidmsrcurelcount_i > 0.5) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 0.1035847150,
      (f_historical_count_d > 1.5) => -0.0547794937,
      (f_historical_count_d = NULL) => 0.0343596417, 0.0343596417),
   (f_divssnidmsrcurelcount_i = NULL) => 0.0682813044, 0.0682813044),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 15.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0001806356,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0629556218,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0024052725, -0.0024052725),
   (k_inq_per_ssn_i > 15.5) => 0.1233934921,
   (k_inq_per_ssn_i = NULL) => -0.0017226909, -0.0017226909),
(r_D33_Eviction_Recency_d = NULL) => 0.0247925552, -0.0002743112);

// Tree: 57 
woFDN_FLAPSD_lgt_57 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 54.5) => -0.0375475266,
   (c_unempl > 54.5) => 
      map(
      (NULL < r_C15_ssns_per_adl_c6_i and r_C15_ssns_per_adl_c6_i <= 0.5) => 0.0035514564,
      (r_C15_ssns_per_adl_c6_i > 0.5) => 
         map(
         (NULL < c_rnt2000_p and c_rnt2000_p <= 0.1) => 0.1928183526,
         (c_rnt2000_p > 0.1) => -0.0393459929,
         (c_rnt2000_p = NULL) => 0.0875927860, 0.0875927860),
      (r_C15_ssns_per_adl_c6_i = NULL) => -0.0000993890, 0.0047147898),
   (c_unempl = NULL) => 0.0016026401, -0.0037071573),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 5.2) => 0.0092692547,
   (c_hval_150k_p > 5.2) => 0.2622302329,
   (c_hval_150k_p = NULL) => 0.1293456684, 0.1293456684),
(f_nae_nothing_found_i = NULL) => -0.0020289191, -0.0020289191);

// Tree: 58 
woFDN_FLAPSD_lgt_58 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 13.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 2.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 345989) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 44.5) => -0.0286342829,
         (f_phones_per_addr_curr_i > 44.5) => 0.0742225648,
         (f_phones_per_addr_curr_i = NULL) => -0.0268010299, -0.0268010299),
      (f_prevaddrmedianvalue_d > 345989) => 0.0192928162,
      (f_prevaddrmedianvalue_d = NULL) => -0.0150877702, -0.0150877702),
   (f_srchaddrsrchcount_i > 2.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 13.5) => 0.1363367085,
      (r_C13_max_lres_d > 13.5) => 0.0144015112,
      (r_C13_max_lres_d = NULL) => 0.0160505222, 0.0160505222),
   (f_srchaddrsrchcount_i = NULL) => -0.0076288193, -0.0051540018),
(r_L79_adls_per_addr_curr_i > 13.5) => 0.1156177369,
(r_L79_adls_per_addr_curr_i = NULL) => -0.0042209604, -0.0042209604);

// Tree: 59 
woFDN_FLAPSD_lgt_59 := map(
(NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0180707568,
   (f_nae_nothing_found_i > 0.5) => 0.2240317579,
   (f_nae_nothing_found_i = NULL) => -0.0162723426, -0.0162723426),
(f_util_add_input_misc_n > 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -70638) => 0.1210631712,
   (f_addrchangevaluediff_d > -70638) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 3.55) => -0.0366845566,
         (c_femdiv_p > 3.55) => 0.1354642517,
         (c_femdiv_p = NULL) => 0.0710404645, 0.0710404645),
      (r_D33_Eviction_Recency_d > 549) => -0.0006063294,
      (r_D33_Eviction_Recency_d = NULL) => 0.0018997709, 0.0018997709),
   (f_addrchangevaluediff_d = NULL) => 0.0348764012, 0.0105865983),
(f_util_add_input_misc_n = NULL) => -0.0036654735, -0.0036654735);

// Tree: 60 
woFDN_FLAPSD_lgt_60 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 135.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 8.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0187263678,
      (f_util_adl_count_n > 4.5) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 11.5) => 0.0184870577,
         (f_srchfraudsrchcount_i > 11.5) => 0.1156027728,
         (f_srchfraudsrchcount_i = NULL) => 0.0251033985, 0.0251033985),
      (f_util_adl_count_n = NULL) => -0.0125191357, -0.0125191357),
   (r_D32_criminal_count_i > 8.5) => 0.1201877616,
   (r_D32_criminal_count_i = NULL) => -0.0112509569, -0.0112509569),
(f_prevaddrageoldest_d > 135.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 10229) => 0.0208490334,
   (f_addrchangeincomediff_d > 10229) => 0.1619818664,
   (f_addrchangeincomediff_d = NULL) => 0.0526562390, 0.0292413774),
(f_prevaddrageoldest_d = NULL) => -0.0161079278, -0.0001916962);

// Tree: 61 
woFDN_FLAPSD_lgt_61 := map(
(NULL < c_hh3_p and c_hh3_p <= 36.15) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 2.5) => -0.0178694947,
   (f_phones_per_addr_curr_i > 2.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0017691482,
      (r_C23_inp_addr_occ_index_d > 2) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.57277289965) => 0.0238676578,
         (f_add_curr_nhood_MFD_pct_i > 0.57277289965) => 0.1131463066,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0152256429, 0.0356784611),
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0057994419, 0.0092519810),
   (f_phones_per_addr_curr_i = NULL) => -0.0005725900, -0.0005725900),
(c_hh3_p > 36.15) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 13.55) => 0.0006992764,
   (c_famotf18_p > 13.55) => 0.2178718260,
   (c_famotf18_p = NULL) => 0.0998804408, 0.0998804408),
(c_hh3_p = NULL) => -0.0142874189, 0.0001195845);

// Tree: 62 
woFDN_FLAPSD_lgt_62 := map(
(NULL < c_hhsize and c_hhsize <= 2.905) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0531027111) => 0.0025640380,
      (f_add_curr_nhood_VAC_pct_i > 0.0531027111) => 0.1469468596,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0589635776, 0.0589635776),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0129170788,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0272829010, -0.0115541758),
(c_hhsize > 2.905) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 6.5) => 0.0236564858,
   (f_srchphonesrchcount_i > 6.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0044273902,
      (r_D30_Derog_Count_i > 0.5) => 0.1797646972,
      (r_D30_Derog_Count_i = NULL) => 0.0864196561, 0.0864196561),
   (f_srchphonesrchcount_i = NULL) => 0.0263170777, 0.0263170777),
(c_hhsize = NULL) => -0.0439933862, -0.0024184224);

// Tree: 63 
woFDN_FLAPSD_lgt_63 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 3.5) => -0.0046665660,
(f_srchphonesrchcount_i > 3.5) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 0.55) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 3.5) => 
         map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.2572175269,
         (f_corrssnaddrcount_d > 2.5) => 
            map(
            (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 6.5) => 0.0337484746,
            (f_rel_homeover150_count_d > 6.5) => 0.1983441128,
            (f_rel_homeover150_count_d = NULL) => 0.0968078425, 0.0968078425),
         (f_corrssnaddrcount_d = NULL) => 0.1190252503, 0.1190252503),
      (f_inq_count24_i > 3.5) => -0.0090261348,
      (f_inq_count24_i = NULL) => 0.0726462151, 0.0726462151),
   (c_wholesale > 0.55) => -0.0170319649,
   (c_wholesale = NULL) => 0.0344465847, 0.0344465847),
(f_srchphonesrchcount_i = NULL) => 0.0014755994, -0.0015524381);

// Tree: 64 
woFDN_FLAPSD_lgt_64 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => -0.0062448591,
   (f_inq_Communications_count_i > 1.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 56.25) => 
         map(
         (NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 0.1497637593,
         (r_A41_Prop_Owner_d > 0.5) => -0.0025676558,
         (r_A41_Prop_Owner_d = NULL) => 0.0786016383, 0.0786016383),
      (c_civ_emp > 56.25) => 0.0062233413,
      (c_civ_emp = NULL) => 0.0310129081, 0.0310129081),
   (f_inq_Communications_count_i = NULL) => -0.0531468801, -0.0054034310),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 43) => 0.0194429947,
   (r_C13_Curr_Addr_LRes_d > 43) => 0.1608523047,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0833052637, 0.0833052637),
(k_nap_contradictory_i = NULL) => -0.0038229686, -0.0038229686);

// Tree: 65 
woFDN_FLAPSD_lgt_65 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0068472026,
   (r_D33_eviction_count_i > 3.5) => 0.1015924561,
   (r_D33_eviction_count_i = NULL) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 110.5) => -0.0817428337,
      (c_span_lang > 110.5) => 0.0380846184,
      (c_span_lang = NULL) => -0.0223593176, -0.0223593176), -0.0063025668),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 85.5) => 0.1736799843,
      (c_mort_indx > 85.5) => 0.0200518652,
      (c_mort_indx = NULL) => 0.0843961099, 0.0843961099),
   (f_phone_ver_experian_d > 0.5) => 0.0067878080,
   (f_phone_ver_experian_d = NULL) => 0.0328077251, 0.0387221200),
(r_L70_Add_Standardized_i = NULL) => -0.0025543548, -0.0025543548);

// Tree: 66 
woFDN_FLAPSD_lgt_66 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.285) => -0.0324741917,
   (c_hhsize > 2.285) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 25.5) => -0.0057544168,
      (r_P88_Phn_Dst_to_Inp_Add_i > 25.5) => -0.0434473168,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 235.5) => 0.0048647734,
         (r_C13_max_lres_d > 235.5) => 0.0945521886,
         (r_C13_max_lres_d = NULL) => 0.0200763919, 0.0200763919), -0.0006247741),
   (c_hhsize = NULL) => 0.0114879940, -0.0078751080),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_child and c_child <= 20.85) => 0.2990746462,
   (c_child > 20.85) => 0.0298071474,
   (c_child = NULL) => 0.0986609371, 0.0986609371),
(r_P85_Phn_Disconnected_i = NULL) => -0.0059686293, -0.0059686293);

// Tree: 67 
woFDN_FLAPSD_lgt_67 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.1064385732,
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 8296.5) => -0.0101771212,
   (f_addrchangeincomediff_d > 8296.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 2.65) => -0.0225823721,
         (c_femdiv_p > 2.65) => 0.1555969972,
         (c_femdiv_p = NULL) => 0.1029740747, 0.1029740747),
      (r_Phn_Cell_n > 0.5) => -0.0043165194,
      (r_Phn_Cell_n = NULL) => 0.0449860631, 0.0449860631),
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 126666.5) => 0.0756155548,
      (r_L80_Inp_AVM_AutoVal_d > 126666.5) => 0.0066990923,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0113482942, 0.0057656115), -0.0047933567),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0203395943, -0.0030316615);

// Tree: 68 
woFDN_FLAPSD_lgt_68 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 460.5) => 
   map(
   (NULL < c_employees and c_employees <= 6.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.1383435369,
      (r_F01_inp_addr_address_score_d > 95) => 0.0332475755,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0466185629, 0.0466185629),
   (c_employees > 6.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => -0.0061623135,
      (r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.0786551126,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0066549462, -0.0066549462),
   (c_employees = NULL) => -0.0083040267, -0.0049666247),
(r_C10_M_Hdr_FS_d > 460.5) => 0.0767097429,
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_child and c_child <= 24.45) => -0.0589071699,
   (c_child > 24.45) => 0.0744487479,
   (c_child = NULL) => 0.0053012350, 0.0053012350), -0.0020702620);

// Tree: 69 
woFDN_FLAPSD_lgt_69 := map(
(NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0098892710,
(f_phones_per_addr_c6_i > 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 126.5) => -0.0030867698,
   (c_easiqlife > 126.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 25.6) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
            map(
            (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 113239) => 0.1691754623,
            (r_A46_Curr_AVM_AutoVal_d > 113239) => 0.0701715051,
            (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0375982343, 0.0638139363),
         (f_corrphonelastnamecount_d > 0.5) => 0.0120308929,
         (f_corrphonelastnamecount_d = NULL) => 0.0338948445, 0.0338948445),
      (C_INC_50K_P > 25.6) => 0.2361074165,
      (C_INC_50K_P = NULL) => 0.0394001083, 0.0394001083),
   (c_easiqlife = NULL) => -0.0290684349, 0.0145105538),
(f_phones_per_addr_c6_i = NULL) => -0.0012007406, -0.0012007406);

// Tree: 70 
woFDN_FLAPSD_lgt_70 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 59.5) => 
   map(
   (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 0.5) => -0.0080575840,
   (f_hh_age_65_plus_d > 0.5) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 8.5) => 0.0167646117,
      (r_P88_Phn_Dst_to_Inp_Add_i > 8.5) => -0.0142937816,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0707356683, 0.0252781736),
   (f_hh_age_65_plus_d = NULL) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 1.95) => 0.0370413377,
      (c_hval_750k_p > 1.95) => -0.0743125596,
      (c_hval_750k_p = NULL) => -0.0140719266, -0.0140719266), -0.0011815627),
(f_phones_per_addr_curr_i > 59.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 4.5) => 0.0343086628,
   (f_rel_homeover200_count_d > 4.5) => 0.2303914853,
   (f_rel_homeover200_count_d = NULL) => 0.1193740049, 0.1193740049),
(f_phones_per_addr_curr_i = NULL) => 0.0001394640, 0.0001394640);

// Tree: 71 
woFDN_FLAPSD_lgt_71 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 3.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32794875715) => 0.0060494845,
      (f_add_input_mobility_index_i > 0.32794875715) => -0.0240658269,
      (f_add_input_mobility_index_i = NULL) => 0.0749269242, -0.0012744453),
   (k_inq_per_phone_i > 3.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 1.5) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 222041.5) => 0.0394436768,
         (c_med_hval > 222041.5) => 0.1960329437,
         (c_med_hval = NULL) => 0.1083429542, 0.1083429542),
      (f_srchfraudsrchcountyr_i > 1.5) => -0.0120677397,
      (f_srchfraudsrchcountyr_i = NULL) => 0.0444252132, 0.0444252132),
   (k_inq_per_phone_i = NULL) => 0.0000879247, 0.0000879247),
(f_inq_PrepaidCards_count24_i > 1.5) => 0.0904406069,
(f_inq_PrepaidCards_count24_i = NULL) => 0.0119937328, 0.0006089829);

// Tree: 72 
woFDN_FLAPSD_lgt_72 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21648) => 0.1094791068,
(r_A46_Curr_AVM_AutoVal_d > 21648) => -0.0005677822,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 29.55) => -0.0421749790,
   (c_low_ed > 29.55) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 63871) => 0.0080847388,
      (f_addrchangevaluediff_d > 63871) => 0.1166575296,
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 126416.5) => 
            map(
            (NULL < c_hval_100k_p and c_hval_100k_p <= 7.2) => 0.1737263144,
            (c_hval_100k_p > 7.2) => -0.0240710006,
            (c_hval_100k_p = NULL) => 0.0684879994, 0.0684879994),
         (r_L80_Inp_AVM_AutoVal_d > 126416.5) => -0.0556513524,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0024535710, 0.0018580162), 0.0085115675),
   (c_low_ed = NULL) => 0.0222431600, -0.0044440048), -0.0014611950);

// Tree: 73 
woFDN_FLAPSD_lgt_73 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 105.95) => -0.0056061416,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 105.95) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -58658.5) => 0.1194007023,
   (f_addrchangevaluediff_d > -58658.5) => 0.0159516198,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 191.7) => 
         map(
         (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1433514271,
         (k_nap_phn_verd_d > 0.5) => -0.0099898755,
         (k_nap_phn_verd_d = NULL) => 0.0388940968, 0.0388940968),
      (c_oldhouse > 191.7) => 0.1948208385,
      (c_oldhouse = NULL) => 0.0639302215, 0.0639302215), 0.0244342907),
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -92) => 0.1116819064,
   (f_addrchangecrimediff_i > -92) => -0.0110911790,
   (f_addrchangecrimediff_i = NULL) => -0.0089939065, -0.0091796375), -0.0011892969);

// Tree: 74 
woFDN_FLAPSD_lgt_74 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 2.5) => -0.0176601332,
   (f_srchphonesrchcount_i > 2.5) => 
      map(
      (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => -0.0182647153,
      (f_util_add_input_misc_n > 0.5) => 
         map(
         (NULL < c_employees and c_employees <= 140.5) => 0.2204901463,
         (c_employees > 140.5) => 0.0322309071,
         (c_employees = NULL) => 0.1056201020, 0.1056201020),
      (f_util_add_input_misc_n = NULL) => 0.0403527530, 0.0403527530),
   (f_srchphonesrchcount_i = NULL) => -0.0186840636, -0.0137948774),
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 0.0879363183,
   (r_I60_inq_comm_recency_d > 4.5) => 0.0120920001,
   (r_I60_inq_comm_recency_d = NULL) => 0.0134774191, 0.0134774191),
(k_inq_per_ssn_i = NULL) => -0.0026989119, -0.0026989119);

// Tree: 75 
woFDN_FLAPSD_lgt_75 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 6.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 29.2) => -0.0286899132,
   (c_low_ed > 29.2) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 14.5) => 0.1821961859,
      (r_C13_max_lres_d > 14.5) => 0.0207008944,
      (r_C13_max_lres_d = NULL) => 0.1045542188, 0.1045542188),
   (c_low_ed = NULL) => 0.0542884684, 0.0542884684),
(r_C10_M_Hdr_FS_d > 6.5) => 
   map(
   (NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => -0.0049748665,
   (f_srchunvrfdssncount_i > 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32257074395) => 0.0685573481,
      (f_add_input_mobility_index_i > 0.32257074395) => -0.0241605640,
      (f_add_input_mobility_index_i = NULL) => 0.0398294410, 0.0398294410),
   (f_srchunvrfdssncount_i = NULL) => -0.0019958567, -0.0019958567),
(r_C10_M_Hdr_FS_d = NULL) => 0.0123850484, -0.0011301585);

// Tree: 76 
woFDN_FLAPSD_lgt_76 := map(
(NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => -0.0060284315,
   (f_srchphonesrchcount_i > 1.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 42615.5) => 0.1276774553,
      (r_A46_Curr_AVM_AutoVal_d > 42615.5) => 0.0129225882,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 72.6) => 0.0156202435,
         (c_lowrent > 72.6) => 0.1870146087,
         (c_lowrent = NULL) => 0.0298498130, 0.0298498130), 0.0228744395),
   (f_srchphonesrchcount_i = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 139.5) => 0.0659251597,
      (c_asian_lang > 139.5) => -0.0547128210,
      (c_asian_lang = NULL) => 0.0109917935, 0.0109917935), 0.0001701379),
(k_inq_addrs_per_ssn_i > 2.5) => 0.0998446802,
(k_inq_addrs_per_ssn_i = NULL) => 0.0008930436, 0.0008930436);

// Tree: 77 
woFDN_FLAPSD_lgt_77 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0139327899,
(f_corrrisktype_i > 5.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.0034116715,
      (f_corrssnnamecount_d > 3.5) => 0.1597330141,
      (f_corrssnnamecount_d = NULL) => 0.0747757627, 0.0747757627),
   (r_F00_input_dob_match_level_d > 4.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 3.5) => 0.1219179882,
         (f_rel_under500miles_cnt_d > 3.5) => 0.0233848921,
         (f_rel_under500miles_cnt_d = NULL) => 0.0454947575, 0.0454947575),
      (r_I60_inq_comm_recency_d > 549) => 0.0014790457,
      (r_I60_inq_comm_recency_d = NULL) => 0.0065786475, 0.0065786475),
   (r_F00_input_dob_match_level_d = NULL) => 0.0090624695, 0.0090624695),
(f_corrrisktype_i = NULL) => 0.0153074794, -0.0067829002);

// Tree: 78 
woFDN_FLAPSD_lgt_78 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 23.5) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1541.5) => -0.0005997928,
      (f_liens_unrel_SC_total_amt_i > 1541.5) => -0.0668614255,
      (f_liens_unrel_SC_total_amt_i = NULL) => -0.0018939653, -0.0018939653),
   (f_inq_Other_count24_i > 3.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 26.6) => 0.0247181074,
      (c_rnt750_p > 26.6) => 0.1918589802,
      (c_rnt750_p = NULL) => 0.0809752792, 0.0809752792),
   (f_inq_Other_count24_i = NULL) => -0.0005341482, -0.0005341482),
(f_srchssnsrchcount_i > 23.5) => 0.0901315233,
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0844095526,
   (k_comb_age_d > 25.5) => 0.0461823667,
   (k_comb_age_d = NULL) => -0.0105501884, -0.0105501884), -0.0001301561);

// Tree: 79 
woFDN_FLAPSD_lgt_79 := map(
(NULL < C_INC_75K_P and C_INC_75K_P <= 31.95) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 77.25) => -0.0061201580,
   (r_C12_source_profile_d > 77.25) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 118.15) => -0.0026172966,
      (c_oldhouse > 118.15) => 0.1006297937,
      (c_oldhouse = NULL) => 0.0245154925, 0.0245154925),
   (r_C12_source_profile_d = NULL) => 0.0054996668, -0.0016376948),
(C_INC_75K_P > 31.95) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 43.5) => 0.2589623546,
   (c_no_teens > 43.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 101) => -0.0597235236,
      (f_curraddrburglaryindex_i > 101) => 0.2013463544,
      (f_curraddrburglaryindex_i = NULL) => 0.0388623044, 0.0388623044),
   (c_no_teens = NULL) => 0.1012787366, 0.1012787366),
(C_INC_75K_P = NULL) => -0.0187279132, -0.0004084226);

// Tree: 80 
woFDN_FLAPSD_lgt_80 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 6.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 77.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 187.5) => 0.0230376981,
      (r_D32_Mos_Since_Crim_LS_d > 187.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 18.5) => -0.0061593463,
         (f_addrs_per_ssn_i > 18.5) => -0.0593826029,
         (f_addrs_per_ssn_i = NULL) => -0.0095765037, -0.0095765037),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0045823539, -0.0045823539),
   (k_comb_age_d > 77.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.0068784941,
      (k_inq_per_ssn_i > 0.5) => 0.1948947910,
      (k_inq_per_ssn_i = NULL) => 0.0611943132, 0.0611943132),
   (k_comb_age_d = NULL) => -0.0031595290, -0.0031595290),
(f_varrisktype_i > 6.5) => 0.1021639320,
(f_varrisktype_i = NULL) => 0.0199227583, -0.0022260890);

// Tree: 81 
woFDN_FLAPSD_lgt_81 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21625) => 0.1399860724,
(r_A46_Curr_AVM_AutoVal_d > 21625) => -0.0052494348,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.34805944345) => 
      map(
      (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 3.5) => 0.0025051822,
      (f_inq_Other_count_i > 3.5) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 52428) => -0.0302934532,
         (f_prevaddrmedianincome_d > 52428) => 0.2012068116,
         (f_prevaddrmedianincome_d = NULL) => 0.0876406440, 0.0876406440),
      (f_inq_Other_count_i = NULL) => 0.0091818447, 0.0049435730),
   (f_add_input_mobility_index_i > 0.34805944345) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 9.5) => -0.0430116489,
      (r_C14_addrs_15yr_i > 9.5) => 0.0711647323,
      (r_C14_addrs_15yr_i = NULL) => -0.0387772930, -0.0387772930),
   (f_add_input_mobility_index_i = NULL) => 0.1103346795, -0.0060391820), -0.0047001730);

// Tree: 82 
woFDN_FLAPSD_lgt_82 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.15) => -0.0053075829,
(r_C12_source_profile_d > 78.15) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 2.5) => 0.0270747926,
   (r_P88_Phn_Dst_to_Inp_Add_i > 2.5) => -0.0291489697,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 7.75) => 0.0117141123,
      (c_rnt1000_p > 7.75) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.15) => 0.0980533024,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.15) => 0.2891212191,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0820489797, 0.1358461682),
      (c_rnt1000_p = NULL) => 0.0809828645, 0.0809828645), 0.0314865269),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 95) => -0.0356666337,
   (c_larceny > 95) => 0.0803080337,
   (c_larceny = NULL) => 0.0172340918, 0.0172340918), -0.0001112915);

// Tree: 83 
woFDN_FLAPSD_lgt_83 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 0.5) => -0.0098957186,
      (k_inq_ssns_per_addr_i > 0.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.51067758805) => 0.1729101627,
         (f_add_curr_nhood_MFD_pct_i > 0.51067758805) => 0.0031620902,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1109583114, 0.1109583114),
      (k_inq_ssns_per_addr_i = NULL) => 0.0445239323, 0.0445239323),
   (r_C10_M_Hdr_FS_d > 11.5) => -0.0081750349,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0067365285, -0.0067365285),
(f_inq_HighRiskCredit_count_i > 21.5) => 0.1160337057,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 0.95) => 0.0650659263,
   (c_pop_85p_p > 0.95) => -0.0845222068,
   (c_pop_85p_p = NULL) => -0.0119066082, -0.0119066082), -0.0062958124);

// Tree: 84 
woFDN_FLAPSD_lgt_84 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 3.5) => -0.0110722263,
(f_srchaddrsrchcount_i > 3.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 33.45) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 27.5) => 0.0114101824,
      (f_addrchangecrimediff_i > 27.5) => 0.1284803735,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => -0.0464031576,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0540747838,
         (nf_seg_FraudPoint_3_0 = '') => 0.0268325251, 0.0268325251), 0.0166523378),
   (c_hval_100k_p > 33.45) => 0.1457746234,
   (c_hval_100k_p = NULL) => 0.0204423644, 0.0204423644),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0700546785,
   (k_comb_age_d > 26.5) => 0.0587824440,
   (k_comb_age_d = NULL) => -0.0000827930, -0.0000827930), -0.0035508344);

// Tree: 85 
woFDN_FLAPSD_lgt_85 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 16.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
         map(
         (NULL < c_professional and c_professional <= 12.15) => 0.0763227979,
         (c_professional > 12.15) => -0.0742199773,
         (c_professional = NULL) => 0.0480223284, 0.0480223284),
      (r_F00_dob_score_d > 92) => -0.0031889711,
      (r_F00_dob_score_d = NULL) => 0.0121171681, -0.0009050084),
   (r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.0985640912,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0013351213, -0.0013351213),
(f_inq_HighRiskCredit_count_i > 16.5) => 0.0736537985,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 317.5) => -0.0644463954,
   (c_employees > 317.5) => 0.0425835588,
   (c_employees = NULL) => -0.0128774175, -0.0128774175), -0.0009345441);

// Tree: 86 
woFDN_FLAPSD_lgt_86 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -84225.5) => 0.1228997094,
      (f_addrchangevaluediff_d > -84225.5) => 0.0229705843,
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 262310.5) => 0.0141237354,
         (f_prevaddrmedianvalue_d > 262310.5) => 0.1402027182,
         (f_prevaddrmedianvalue_d = NULL) => 0.0460752584, 0.0460752584), 0.0321348024),
   (f_corrphonelastnamecount_d > 0.5) => -0.0160382777,
   (f_corrphonelastnamecount_d = NULL) => 0.0111598081, 0.0111598081),
(f_phone_ver_experian_d > 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 0.1876995571,
   (r_C10_M_Hdr_FS_d > 10.5) => -0.0172556245,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0155101366, -0.0155101366),
(f_phone_ver_experian_d = NULL) => -0.0084347551, -0.0053838941);

// Tree: 87 
woFDN_FLAPSD_lgt_87 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 69464) => 0.0048285330,
   (f_addrchangevaluediff_d > 69464) => 
      map(
      (NULL < c_health and c_health <= 19.6) => 0.0348926591,
      (c_health > 19.6) => 0.2060782256,
      (c_health = NULL) => 0.0664767120, 0.0664767120),
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => -0.0092970379,
      (r_L79_adls_per_addr_curr_i > 3.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.139410299) => 0.0429672381,
         (f_add_curr_nhood_BUS_pct_i > 0.139410299) => 0.1913931957,
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0836277665, 0.0487615802),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0038672890, 0.0038672890), 0.0060034773),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0648297042,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0118960406, 0.0029332844);

// Tree: 88 
woFDN_FLAPSD_lgt_88 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.73148774985) => 
         map(
         (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 
            map(
            (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 47148) => 0.1679689986,
            (f_curraddrmedianvalue_d > 47148) => 0.0361252375,
            (f_curraddrmedianvalue_d = NULL) => 0.0442774090, 0.0442774090),
         (f_srchssnsrchcount_i > 6.5) => 0.1406488450,
         (f_srchssnsrchcount_i = NULL) => 0.0509213531, 0.0509213531),
      (f_add_curr_nhood_MFD_pct_i > 0.73148774985) => -0.0027375202,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0315251614, 0.0245889595),
   (r_Ever_Asset_Owner_d > 0.5) => -0.0047975956,
   (r_Ever_Asset_Owner_d = NULL) => 0.0008933510, 0.0008933510),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0578467207,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0036926689, -0.0015467744);

// Tree: 89 
woFDN_FLAPSD_lgt_89 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 111.5) => 0.1018105841,
(r_D32_Mos_Since_Fel_LS_d > 111.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 218.4) => 
      map(
      (NULL < r_P85_Phn_Not_Issued_i and r_P85_Phn_Not_Issued_i <= 0.5) => -0.0081023278,
      (r_P85_Phn_Not_Issued_i > 0.5) => -0.0880638184,
      (r_P85_Phn_Not_Issued_i = NULL) => -0.0098332834, -0.0098332834),
   (c_cpiall > 218.4) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 78.5) => 0.0189216079,
      (k_comb_age_d > 78.5) => 0.1471364978,
      (k_comb_age_d = NULL) => 0.0211551672, 0.0211551672),
   (c_cpiall = NULL) => -0.0204139571, -0.0026881336),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_work_home and c_work_home <= 102) => 0.0788352805,
   (c_work_home > 102) => -0.0448259297,
   (c_work_home = NULL) => 0.0152380867, 0.0152380867), -0.0020111059);

// Tree: 90 
woFDN_FLAPSD_lgt_90 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 57) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 470.5) => 0.2039938362,
   (c_hh00 > 470.5) => 0.0255552015,
   (c_hh00 = NULL) => 0.0838909090, 0.0838909090),
(f_mos_liens_unrel_OT_fseen_d > 57) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0024908923,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.2054289644,
      (f_phone_ver_experian_d > 0.5) => 0.0247248534,
      (f_phone_ver_experian_d = NULL) => 0.0950753088, 0.0950753088),
   (f_nae_nothing_found_i = NULL) => -0.0011238027, -0.0011238027),
(f_mos_liens_unrel_OT_fseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 15.8) => 0.0607957431,
   (c_hh3_p > 15.8) => -0.0625318852,
   (c_hh3_p = NULL) => 0.0026223335, 0.0026223335), -0.0000326988);

// Tree: 91 
woFDN_FLAPSD_lgt_91 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0669777315,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
      map(
      (NULL < f_idrisktype_i and f_idrisktype_i <= 6.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 33.45) => -0.0045985832,
         (C_INC_75K_P > 33.45) => 0.1059242471,
         (C_INC_75K_P = NULL) => -0.0296653646, -0.0040300456),
      (f_idrisktype_i > 6.5) => 0.0866463672,
      (f_idrisktype_i = NULL) => -0.0033112150, -0.0033112150),
   (r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0812646920,
   (r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => -0.0048597941, -0.0048597941),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 69) => 0.0692329782,
   (c_old_homes > 69) => -0.0534935224,
   (c_old_homes = NULL) => -0.0004507128, -0.0004507128), -0.0043593661);

// Tree: 92 
woFDN_FLAPSD_lgt_92 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.15) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
      map(
      (NULL < f_srchfraudsrchcountwk_i and f_srchfraudsrchcountwk_i <= 0.5) => 
         map(
         (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 19.5) => -0.0048384506,
         (k_inq_per_addr_i > 19.5) => 0.0967025360,
         (k_inq_per_addr_i = NULL) => -0.0044145153, -0.0044145153),
      (f_srchfraudsrchcountwk_i > 0.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01408954925) => -0.0348255477,
         (f_add_curr_nhood_VAC_pct_i > 0.01408954925) => 0.1541680046,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0647206745, 0.0647206745),
      (f_srchfraudsrchcountwk_i = NULL) => -0.0036664597, -0.0036664597),
   (r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0750987360,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0059126754, -0.0040645346),
(c_pop_0_5_p > 19.15) => 0.1111584801,
(c_pop_0_5_p = NULL) => -0.0197785733, -0.0035637493);

// Tree: 93 
woFDN_FLAPSD_lgt_93 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => -0.0057811463,
   (k_inq_addrs_per_ssn_i > 2.5) => 0.1076631515,
   (k_inq_addrs_per_ssn_i = NULL) => -0.0051474882, -0.0051474882),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 88.5) => 0.1566540809,
   (r_D32_Mos_Since_Crim_LS_d > 88.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => 0.0098716221,
      (k_comb_age_d > 63.5) => 
         map(
         (NULL < c_construction and c_construction <= 7.2) => 0.3240457449,
         (c_construction > 7.2) => 0.0154080010,
         (c_construction = NULL) => 0.1654795646, 0.1654795646),
      (k_comb_age_d = NULL) => 0.0289957075, 0.0289957075),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0401336864, 0.0401336864),
(r_L70_Add_Standardized_i = NULL) => -0.0014064815, -0.0014064815);

// Tree: 94 
woFDN_FLAPSD_lgt_94 := map(
(NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 0.1041062083,
   (r_C10_M_Hdr_FS_d > 11.5) => 0.0116090250,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0223938725, 0.0133041962),
(r_Phn_Cell_n > 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 3.5) => -0.0192201652,
   (f_srchphonesrchcount_i > 3.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1298282273,
      (k_nap_phn_verd_d > 0.5) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 11.9) => 0.1704396151,
         (c_lowinc > 11.9) => -0.0241189047,
         (c_lowinc = NULL) => 0.0132206092, 0.0132206092),
      (k_nap_phn_verd_d = NULL) => 0.0386622713, 0.0386622713),
   (f_srchphonesrchcount_i = NULL) => -0.0155506875, -0.0155506875),
(r_Phn_Cell_n = NULL) => -0.0006216688, -0.0006216688);

// Tree: 95 
woFDN_FLAPSD_lgt_95 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 235.5) => -0.0030585944,
(r_C13_Curr_Addr_LRes_d > 235.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 192.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 125.5) => 0.1620668989,
         (c_new_homes > 125.5) => -0.0325580257,
         (c_new_homes = NULL) => 0.0831649025, 0.0831649025),
      (f_corraddrnamecount_d > 4.5) => 0.0217362868,
      (f_corraddrnamecount_d = NULL) => 0.0279378114, 0.0279378114),
   (c_work_home > 192.5) => 0.2723788912,
   (c_work_home = NULL) => 0.0378562322, 0.0378562322),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 25.45) => 0.0406951693,
   (c_hh1_p > 25.45) => -0.0612833366,
   (c_hh1_p = NULL) => -0.0063718335, -0.0063718335), 0.0019253752);

// Tree: 96 
woFDN_FLAPSD_lgt_96 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 6.45) => 0.0425579862,
   (c_high_ed > 6.45) => -0.0125399275,
   (c_high_ed = NULL) => -0.0009331972, -0.0093131937),
(f_hh_collections_ct_i > 1.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 9.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 22.55) => 
         map(
         (NULL < c_rural_p and c_rural_p <= 6.55) => 0.0453658056,
         (c_rural_p > 6.55) => -0.0182166811,
         (c_rural_p = NULL) => 0.0258209074, 0.0258209074),
      (c_famotf18_p > 22.55) => -0.0293722933,
      (c_famotf18_p = NULL) => 0.0827813306, 0.0182637594),
   (r_L79_adls_per_addr_curr_i > 9.5) => 0.1079693468,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0206410713, 0.0206410713),
(f_hh_collections_ct_i = NULL) => -0.0034976924, -0.0008869042);

// Tree: 97 
woFDN_FLAPSD_lgt_97 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => -0.0150419726,
(r_L79_adls_per_addr_curr_i > 2.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 238) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 152817.5) => 0.0202864663,
      (c_med_hval > 152817.5) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 7.25) => 0.0310265723,
         (c_rnt750_p > 7.25) => 0.2422160907,
         (c_rnt750_p = NULL) => 0.1605150361, 0.1605150361),
      (c_med_hval = NULL) => 0.0944614241, 0.0944614241),
   (f_mos_liens_unrel_SC_fseen_d > 238) => 
      map(
      (NULL < c_unempl and c_unempl <= 183.5) => 0.0098581560,
      (c_unempl > 183.5) => 0.0881349674,
      (c_unempl = NULL) => -0.0139253728, 0.0113890128),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0148180654, 0.0148180654),
(r_L79_adls_per_addr_curr_i = NULL) => -0.0000919449, -0.0000919449);

// Tree: 98 
woFDN_FLAPSD_lgt_98 := map(
(NULL < r_C22_stl_inq_Count24_i and r_C22_stl_inq_Count24_i <= 0.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0100143405,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => 0.0041952272,
         (f_phones_per_addr_curr_i > 8.5) => 0.0578362920,
         (f_phones_per_addr_curr_i = NULL) => 0.0119902583, 0.0119902583),
      (k_comb_age_d > 73.5) => 0.1465957425,
      (k_comb_age_d = NULL) => 0.0155725406, 0.0155725406),
   (f_inq_Other_count_i = NULL) => -0.0043910078, -0.0043910078),
(r_C22_stl_inq_Count24_i > 0.5) => -0.0750985695,
(r_C22_stl_inq_Count24_i = NULL) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 31.9) => 0.0753219067,
   (c_high_ed > 31.9) => -0.0570287475,
   (c_high_ed = NULL) => 0.0144171809, 0.0144171809), -0.0047095349);

// Tree: 99 
woFDN_FLAPSD_lgt_99 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 50.1) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 8.5) => -0.0462792948,
   (f_mos_inq_banko_om_fseen_d > 8.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 465.5) => 0.0159191203,
         (r_C10_M_Hdr_FS_d > 465.5) => 0.1282879363,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0188931381, 0.0188931381),
      (f_phone_ver_experian_d > 0.5) => -0.0090422052,
      (f_phone_ver_experian_d = NULL) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 3.785) => -0.0141220324,
         (c_hhsize > 3.785) => 0.1106371092,
         (c_hhsize = NULL) => -0.0094380540, -0.0094380540), -0.0002789869),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0068087765, -0.0024122843),
(c_hval_500k_p > 50.1) => 0.1225328886,
(c_hval_500k_p = NULL) => 0.0072979639, -0.0011537627);

// Tree: 100 
woFDN_FLAPSD_lgt_100 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0016930336,
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 354.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 79.95) => 
            map(
            (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.1167206885,
            (f_hh_age_18_plus_d > 1.5) => 0.0250487827,
            (f_hh_age_18_plus_d = NULL) => 0.0535860707, 0.0535860707),
         (c_fammar_p > 79.95) => -0.0140847768,
         (c_fammar_p = NULL) => 0.0256205441, 0.0256205441),
      (r_C13_max_lres_d > 354.5) => 0.1545095634,
      (r_C13_max_lres_d = NULL) => 0.0309232111, 0.0309232111),
   (k_inq_per_ssn_i = NULL) => 0.0087359421, 0.0087359421),
(k_nap_phn_verd_d > 0.5) => -0.0110014801,
(k_nap_phn_verd_d = NULL) => -0.0035950844, -0.0035950844);

// Tree: 101 
woFDN_FLAPSD_lgt_101 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0144374472,
(f_crim_rel_under25miles_cnt_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 6.5) => -0.0369741855,
      (f_sourcerisktype_i > 6.5) => 0.0935645286,
      (f_sourcerisktype_i = NULL) => -0.0267892968, -0.0267892968),
   (f_mos_inq_banko_cm_fseen_d > 41.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.1219468236,
      (k_estimated_income_d > 26500) => 0.0183203181,
      (k_estimated_income_d = NULL) => 0.0214605152, 0.0214605152),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0130167981, 0.0130167981),
(f_crim_rel_under25miles_cnt_i = NULL) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 11.3) => -0.0421749425,
   (c_hval_175k_p > 11.3) => 0.1116517122,
   (c_hval_175k_p = NULL) => -0.0099134253, -0.0099134253), -0.0030614308);

// Tree: 102 
woFDN_FLAPSD_lgt_102 := map(
(NULL < c_cpiall and c_cpiall <= 208.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1353016321,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < c_unemp and c_unemp <= 11.25) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 205.8) => -0.0076341976,
         (c_cpiall > 205.8) => 
            map(
            (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => 0.2195802334,
            (f_rel_homeover200_count_d > 0.5) => 0.0562132858,
            (f_rel_homeover200_count_d = NULL) => 0.0839939596, 0.0839939596),
         (c_cpiall = NULL) => 0.0161190512, 0.0161190512),
      (c_unemp > 11.25) => 0.1467516416,
      (c_unemp = NULL) => 0.0204571009, 0.0204571009),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0252825014, 0.0252825014),
(c_cpiall > 208.5) => -0.0048531617,
(c_cpiall = NULL) => -0.0326895569, -0.0014832039);

// Tree: 103 
woFDN_FLAPSD_lgt_103 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0041612955,
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 0.5) => 0.1653178691,
      (k_inq_adls_per_addr_i > 0.5) => 0.0329357356,
      (k_inq_adls_per_addr_i = NULL) => 0.1021083819, 0.1021083819),
   (k_nap_phn_verd_d > 0.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1984.5) => -0.0444273242,
      (c_med_yearblt > 1984.5) => 0.1072215610,
      (c_med_yearblt = NULL) => 0.0084331443, 0.0084331443),
   (k_nap_phn_verd_d = NULL) => 0.0446629400, 0.0446629400),
(f_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < c_totsales and c_totsales <= 4840) => -0.0703990539,
   (c_totsales > 4840) => 0.0397529950,
   (c_totsales = NULL) => -0.0092034712, -0.0092034712), -0.0031051339);

// Tree: 104 
woFDN_FLAPSD_lgt_104 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 62.5) => -0.0052387726,
(f_addrchangecrimediff_i > 62.5) => 0.0447895314,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 77.5) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => 
         map(
         (NULL < c_retail and c_retail <= 1.05) => 
            map(
            (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 41069) => 0.1849408999,
            (f_curraddrmedianincome_d > 41069) => 0.0383474194,
            (f_curraddrmedianincome_d = NULL) => 0.0886612835, 0.0886612835),
         (c_retail > 1.05) => 0.0031314249,
         (c_retail = NULL) => 0.0305419248, 0.0305419248),
      (f_bus_addr_match_count_d > 6.5) => 0.1935008307,
      (f_bus_addr_match_count_d = NULL) => 0.0446003480, 0.0446003480),
   (c_new_homes > 77.5) => -0.0061852004,
   (c_new_homes = NULL) => 0.0026372079, 0.0090895141), -0.0012520786);

// Tree: 105 
woFDN_FLAPSD_lgt_105 := map(
(NULL < c_families and c_families <= 202.5) => -0.0329727948,
(c_families > 202.5) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0166989129,
   (f_idverrisktype_i > 1.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => -0.0037760391,
      (r_L79_adls_per_addr_curr_i > 2.5) => 
         map(
         (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0269361365,
         (r_L70_Add_Standardized_i > 0.5) => 
            map(
            (NULL < c_high_ed and c_high_ed <= 21.2) => 0.0092227518,
            (c_high_ed > 21.2) => 0.1865037574,
            (c_high_ed = NULL) => 0.1125460373, 0.1125460373),
         (r_L70_Add_Standardized_i = NULL) => 0.0321275107, 0.0321275107),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0132509090, 0.0132509090),
   (f_idverrisktype_i = NULL) => -0.0089250058, -0.0014607854),
(c_families = NULL) => 0.0204436470, -0.0040305693);

// Tree: 106 
woFDN_FLAPSD_lgt_106 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0033750427,
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 84) => -0.0283975462,
      (c_ab_av_edu > 84) => 0.1448672618,
      (c_ab_av_edu = NULL) => 0.0662316951, 0.0662316951),
   (r_D33_eviction_count_i = NULL) => -0.0074071282, -0.0026772813),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32939559275) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 9.05) => 0.0175472838,
      (C_INC_35K_P > 9.05) => 0.1448055137,
      (C_INC_35K_P = NULL) => 0.0758739725, 0.0758739725),
   (f_add_input_mobility_index_i > 0.32939559275) => 0.0113601678,
   (f_add_input_mobility_index_i = NULL) => 0.0497612420, 0.0497612420),
(k_nap_contradictory_i = NULL) => -0.0018008945, -0.0018008945);

// Tree: 107 
woFDN_FLAPSD_lgt_107 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => -0.0074244261,
      (f_addrs_per_ssn_c6_i > 1.5) => 
         map(
         (NULL < c_young and c_young <= 25.2) => 0.2261840711,
         (c_young > 25.2) => -0.0069295872,
         (c_young = NULL) => 0.1185931519, 0.1185931519),
      (f_addrs_per_ssn_c6_i = NULL) => -0.0057967967, -0.0057967967),
   (f_inq_Other_count_i > 0.5) => 0.0257599179,
   (f_inq_Other_count_i = NULL) => 0.0012509793, 0.0012509793),
(r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.0579747689,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 20.8) => 0.0832029641,
   (C_RENTOCC_P > 20.8) => -0.0344100037,
   (C_RENTOCC_P = NULL) => 0.0141286814, 0.0141286814), 0.0009327037);

// Tree: 108 
woFDN_FLAPSD_lgt_108 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 3.75) => -0.0896424692,
(c_pop_35_44_p > 3.75) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 82) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 66) => 0.0041594445,
      (f_phones_per_addr_curr_i > 66) => 0.1166341217,
      (f_phones_per_addr_curr_i = NULL) => 0.0050278842, 0.0050278842),
   (f_addrchangecrimediff_i > 82) => 0.0725640725,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => -0.0203507237,
      (f_util_add_input_conv_n > 0.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 6) => 0.1322021490,
         (c_high_ed > 6) => 0.0212192794,
         (c_high_ed = NULL) => 0.0266351101, 0.0266351101),
      (f_util_add_input_conv_n = NULL) => 0.0045241295, 0.0045241295), 0.0054610697),
(c_pop_35_44_p = NULL) => 0.0162710699, 0.0041903361);

// Tree: 109 
woFDN_FLAPSD_lgt_109 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 360.5) => -0.0118640980,
   (r_pb_order_freq_d > 360.5) => 0.0422512041,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21939) => 0.1302757380,
      (r_A46_Curr_AVM_AutoVal_d > 21939) => 0.0107288799,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0090651784, 0.0111748255), -0.0002341066),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 14.55) => 0.0124315502,
   (c_blue_col > 14.55) => -0.1501890880,
   (c_blue_col = NULL) => -0.0536330841, -0.0536330841),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 98) => -0.0249280467,
   (c_larceny > 98) => 0.0773615772,
   (c_larceny = NULL) => 0.0176926300, 0.0176926300), -0.0006005242);

// Tree: 110 
woFDN_FLAPSD_lgt_110 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 146.5) => 0.0084592274,
         (f_curraddrmurderindex_i > 146.5) => 0.0616265193,
         (f_curraddrmurderindex_i = NULL) => 0.0219250990, 0.0219250990),
      (f_hh_age_18_plus_d > 1.5) => -0.0073608912,
      (f_hh_age_18_plus_d = NULL) => -0.0005202647, -0.0005202647),
   (r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0686430371,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 7.65) => -0.0746922429,
      (c_pop_12_17_p > 7.65) => 0.0328188227,
      (c_pop_12_17_p = NULL) => -0.0199029498, -0.0199029498), -0.0012397987),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1080087022,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0008005655, -0.0008005655);

// Tree: 111 
woFDN_FLAPSD_lgt_111 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -97.5) => 0.0842163260,
   (f_addrchangecrimediff_i > -97.5) => -0.0012097988,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => -0.0168193274,
      (f_bus_addr_match_count_d > 6.5) => 0.0727691131,
      (f_bus_addr_match_count_d = NULL) => -0.0095798574, -0.0095798574), -0.0025894710),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 103.5) => 0.2260206980,
      (c_rich_wht > 103.5) => 0.0569091531,
      (c_rich_wht = NULL) => 0.1398069693, 0.1398069693),
   (f_phone_ver_insurance_d > 3.5) => -0.0345192234,
   (f_phone_ver_insurance_d = NULL) => 0.0805807628, 0.0805807628),
(f_nae_nothing_found_i = NULL) => -0.0015469746, -0.0015469746);

// Tree: 112 
woFDN_FLAPSD_lgt_112 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => -0.0057079126,
(f_util_adl_count_n > 3.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -100231) => 0.1315156324,
   (f_addrchangevaluediff_d > -100231) => 
      map(
      (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.25548538175) => 0.0180236997,
         (f_add_curr_nhood_BUS_pct_i > 0.25548538175) => -0.1180876480,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1894372700, 0.0178333631),
      (f_hh_tot_derog_i > 4.5) => 0.1297931288,
      (f_hh_tot_derog_i = NULL) => 0.0232590492, 0.0232590492),
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 14.45) => 0.1054438649,
      (c_high_ed > 14.45) => -0.0130575601,
      (c_high_ed = NULL) => 0.0134693644, 0.0134693644), 0.0230826249),
(f_util_adl_count_n = NULL) => 0.0059525810, -0.0006995482);

// Tree: 113 
woFDN_FLAPSD_lgt_113 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_liens_unrel_ST_ct_i and f_liens_unrel_ST_ct_i <= 0.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 113.5) => -0.0183486220,
      (r_A50_pb_average_dollars_d > 113.5) => 0.0078702376,
      (r_A50_pb_average_dollars_d = NULL) => -0.0056131280, -0.0056131280),
   (f_liens_unrel_ST_ct_i > 0.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 508) => -0.0334723817,
      (f_liens_unrel_SC_total_amt_i > 508) => -0.1238587456,
      (f_liens_unrel_SC_total_amt_i = NULL) => -0.0505782123, -0.0505782123),
   (f_liens_unrel_ST_ct_i = NULL) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 10.85) => -0.0875190336,
      (c_pop_55_64_p > 10.85) => 0.0504494365,
      (c_pop_55_64_p = NULL) => -0.0224395666, -0.0224395666), -0.0072830373),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0944815100,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0068658708, -0.0068658708);

// Tree: 114 
woFDN_FLAPSD_lgt_114 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 15.85) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 14.5) => 0.1294701364,
      (r_C13_max_lres_d > 14.5) => 0.0175941754,
      (r_C13_max_lres_d = NULL) => 0.0117966099, 0.0187048779),
   (r_Phn_Cell_n > 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 3.5) => -0.0160863738,
      (k_inq_per_phone_i > 3.5) => 
         map(
         (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 0.1409470589,
         (r_I60_Inq_Count12_i > 1.5) => 0.0168309098,
         (r_I60_Inq_Count12_i = NULL) => 0.0582029595, 0.0582029595),
      (k_inq_per_phone_i = NULL) => -0.0139494556, -0.0139494556),
   (r_Phn_Cell_n = NULL) => 0.0030077790, 0.0030077790),
(C_INC_25K_P > 15.85) => -0.0318432637,
(C_INC_25K_P = NULL) => 0.0033280526, -0.0006500604);

// Tree: 115 
woFDN_FLAPSD_lgt_115 := map(
(NULL < c_fammar_p and c_fammar_p <= 28.4) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 2.5) => -0.0953354969,
   (f_rel_ageover40_count_d > 2.5) => -0.0052796656,
   (f_rel_ageover40_count_d = NULL) => -0.0645626500, -0.0645626500),
(c_fammar_p > 28.4) => 
   map(
   (NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 1.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 23.65) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 49019) => 0.0463361681,
         (r_L80_Inp_AVM_AutoVal_d > 49019) => 0.0079803126,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0103222145, 0.0013789105),
      (C_INC_35K_P > 23.65) => 0.1004778818,
      (C_INC_35K_P = NULL) => 0.0021965866, 0.0021965866),
   (r_I60_inq_auto_count12_i > 1.5) => -0.0635719991,
   (r_I60_inq_auto_count12_i = NULL) => 0.0047099632, 0.0003392673),
(c_fammar_p = NULL) => 0.0021967205, -0.0006944758);

// Tree: 116 
woFDN_FLAPSD_lgt_116 := map(
(NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0314490629,
   (f_addrs_per_ssn_i > 3.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
         map(
         (NULL < c_hval_20k_p and c_hval_20k_p <= 13.85) => 0.0070594029,
         (c_hval_20k_p > 13.85) => 
            map(
            (NULL < c_oldhouse and c_oldhouse <= 217.45) => 0.0385371761,
            (c_oldhouse > 217.45) => 0.1712770263,
            (c_oldhouse = NULL) => 0.0558661383, 0.0558661383),
         (c_hval_20k_p = NULL) => 0.0414481762, 0.0094930891),
      (r_C23_inp_addr_occ_index_d > 4.5) => -0.0838836435,
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0304996604, 0.0075342012),
   (f_addrs_per_ssn_i = NULL) => 0.0009488351, 0.0009488351),
(k_inq_addrs_per_ssn_i > 2.5) => 0.0961899002,
(k_inq_addrs_per_ssn_i = NULL) => 0.0015645046, 0.0015645046);

// Tree: 117 
woFDN_FLAPSD_lgt_117 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 121.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 
         map(
         (NULL < c_lux_prod and c_lux_prod <= 111.5) => 0.1246739819,
         (c_lux_prod > 111.5) => -0.0129595048,
         (c_lux_prod = NULL) => 0.0558572386, 0.0558572386),
      (r_D32_Mos_Since_Crim_LS_d > 14.5) => -0.0137364552,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0120042314, -0.0120042314),
   (r_C13_Curr_Addr_LRes_d > 121.5) => 0.0205150896,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0020358668, -0.0020358668),
(f_inq_PrepaidCards_count24_i > 1.5) => 0.0899198054,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 15.75) => 0.0945057873,
   (c_hh3_p > 15.75) => -0.0176482839,
   (c_hh3_p = NULL) => 0.0353700043, 0.0353700043), -0.0012778973);

// Tree: 118 
woFDN_FLAPSD_lgt_118 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0027592012,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 749.5) => -0.0155191980,
   (c_med_rent > 749.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => 0.0240044311,
      (f_rel_criminal_count_i > 0.5) => 
         map(
         (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 33) => 0.2600233899,
         (f_fp_prevaddrburglaryindex_i > 33) => 
            map(
            (NULL < c_serv_empl and c_serv_empl <= 145.5) => 0.0260548881,
            (c_serv_empl > 145.5) => 0.2262130699,
            (c_serv_empl = NULL) => 0.0846118030, 0.0846118030),
         (f_fp_prevaddrburglaryindex_i = NULL) => 0.1301911917, 0.1301911917),
      (f_rel_criminal_count_i = NULL) => 0.0800781051, 0.0800781051),
   (c_med_rent = NULL) => 0.0279286495, 0.0316271116),
(r_L70_Add_Standardized_i = NULL) => 0.0001684471, 0.0001684471);

// Tree: 119 
woFDN_FLAPSD_lgt_119 := map(
(NULL < c_rape and c_rape <= 122.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 16.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 101) => 0.0003896020,
      (f_fp_prevaddrburglaryindex_i > 101) => 0.0350375336,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0098130673, 0.0098130673),
   (f_inq_HighRiskCredit_count_i > 16.5) => 0.1132187703,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0183616734, 0.0105322970),
(c_rape > 122.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 61.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 16) => 0.0369367218,
      (r_pb_order_freq_d > 16) => -0.0764982037,
      (r_pb_order_freq_d = NULL) => -0.1124851524, -0.0653858373),
   (r_I60_inq_hiRiskCred_recency_d > 61.5) => -0.0179010119,
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0207946637, -0.0207946637),
(c_rape = NULL) => 0.0213553048, 0.0025879063);

// Tree: 120 
woFDN_FLAPSD_lgt_120 := map(
(NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1991.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 197.5) => 
      map(
      (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => -0.0088919052,
      (f_util_add_curr_misc_n > 0.5) => 
         map(
         (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 555) => 0.0135411794,
         (f_liens_unrel_SC_total_amt_i > 555) => 0.1508023818,
         (f_liens_unrel_SC_total_amt_i = NULL) => 0.0152554563, 0.0152554563),
      (f_util_add_curr_misc_n = NULL) => 0.0024121581, 0.0024121581),
   (f_curraddrcrimeindex_i > 197.5) => 0.1138981444,
   (f_curraddrcrimeindex_i = NULL) => 0.0030243722, 0.0030243722),
(f_liens_unrel_SC_total_amt_i > 1991.5) => 
   map(
   (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 0.5) => -0.0239573090,
   (f_inq_Collection_count24_i > 0.5) => -0.1437624612,
   (f_inq_Collection_count24_i = NULL) => -0.0621042232, -0.0621042232),
(f_liens_unrel_SC_total_amt_i = NULL) => 0.0046555426, 0.0020053655);

// Tree: 121 
woFDN_FLAPSD_lgt_121 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 25.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.3) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 4.5) => 
         map(
         (NULL < c_bargains and c_bargains <= 50.5) => 0.2008137003,
         (c_bargains > 50.5) => 
            map(
            (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0861325998,
            (f_phone_ver_experian_d > 0.5) => -0.0600214384,
            (f_phone_ver_experian_d = NULL) => -0.0123532714, -0.0012552730),
         (c_bargains = NULL) => 0.0349442489, 0.0349442489),
      (c_born_usa > 4.5) => -0.0063195244,
      (c_born_usa = NULL) => -0.0050534114, -0.0050534114),
   (c_pop_0_5_p > 21.3) => 0.1273537931,
   (c_pop_0_5_p = NULL) => 0.0184705525, -0.0039966547),
(f_srchssnsrchcount_i > 25.5) => 0.0833456408,
(f_srchssnsrchcount_i = NULL) => 0.0088101548, -0.0035068971);

// Tree: 122 
woFDN_FLAPSD_lgt_122 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 76.35) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => -0.0021259764,
   (f_srchfraudsrchcount_i > 8.5) => 
      map(
      (NULL < c_armforce and c_armforce <= 128.5) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 100.5) => -0.1071174080,
         (c_new_homes > 100.5) => -0.0090661902,
         (c_new_homes = NULL) => -0.0612547416, -0.0612547416),
      (c_armforce > 128.5) => 0.0377666138,
      (c_armforce = NULL) => -0.0366494351, -0.0366494351),
   (f_srchfraudsrchcount_i = NULL) => -0.0032060508, -0.0032060508),
(r_C12_source_profile_d > 76.35) => 0.0363541475,
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 125.5) => 0.0683040956,
   (c_asian_lang > 125.5) => -0.0522353467,
   (c_asian_lang = NULL) => -0.0002955870, -0.0002955870), 0.0027979814);

// Tree: 123 
woFDN_FLAPSD_lgt_123 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 233.45) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 208.5) => 0.1126800926,
      (c_cpiall > 208.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 0.5) => -0.0420270357,
         (f_addrchangecrimediff_i > 0.5) => 0.0461860059,
         (f_addrchangecrimediff_i = NULL) => 
            map(
            (NULL < c_construction and c_construction <= 6.65) => -0.0525742204,
            (c_construction > 6.65) => 0.1270841992,
            (c_construction = NULL) => 0.0204576575, 0.0204576575), -0.0035170637),
      (c_cpiall = NULL) => 0.0119323709, 0.0119323709),
   (c_cpiall > 233.45) => 0.1575363498,
   (c_cpiall = NULL) => 0.0555717918, 0.0277490813),
(f_corrssnaddrcount_d > 1.5) => -0.0021957869,
(f_corrssnaddrcount_d = NULL) => 0.0222948082, -0.0004773085);

// Tree: 124 
woFDN_FLAPSD_lgt_124 := map(
(NULL < c_easiqlife and c_easiqlife <= 143.5) => -0.0070246967,
(c_easiqlife > 143.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 624690.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 22.05) => 0.0745606846,
      (c_white_col > 22.05) => 0.0021173393,
      (c_white_col = NULL) => 0.0085748916, 0.0085748916),
   (f_prevaddrmedianvalue_d > 624690.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 84747.5) => 
         map(
         (NULL < c_food and c_food <= 21.75) => 0.0705200928,
         (c_food > 21.75) => 0.3707542617,
         (c_food = NULL) => 0.1964924713, 0.1964924713),
      (r_A49_Curr_AVM_Chg_1yr_i > 84747.5) => 0.0051585156,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0424342887, 0.0810158617),
   (f_prevaddrmedianvalue_d = NULL) => 0.0183549575, 0.0183549575),
(c_easiqlife = NULL) => -0.0367384708, -0.0007880516);

// Tree: 125 
woFDN_FLAPSD_lgt_125 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 2.5) => -0.0419431242,
(f_addrs_per_ssn_i > 2.5) => 
   map(
   (NULL < r_C15_ssns_per_adl_c6_i and r_C15_ssns_per_adl_c6_i <= 0.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 33.85) => -0.0177157971,
      (c_med_age > 33.85) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.18364809175) => 0.0069600270,
         (f_add_curr_nhood_BUS_pct_i > 0.18364809175) => 
            map(
            (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 2.5) => -0.0213289167,
            (f_phones_per_addr_curr_i > 2.5) => 0.1405077814,
            (f_phones_per_addr_curr_i = NULL) => 0.0747310953, 0.0747310953),
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0085920156, 0.0107388343),
      (c_med_age = NULL) => 0.0270811535, 0.0025086604),
   (r_C15_ssns_per_adl_c6_i > 0.5) => 0.0957394482,
   (r_C15_ssns_per_adl_c6_i = NULL) => 0.0004397070, 0.0030821923),
(f_addrs_per_ssn_i = NULL) => -0.0017451179, -0.0017451179);

// Tree: 126 
woFDN_FLAPSD_lgt_126 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 17638.5) => -0.0995049934,
(r_L80_Inp_AVM_AutoVal_d > 17638.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1012692196,
   (r_D33_Eviction_Recency_d > 79.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 14.5) => 0.0862145616,
      (r_C13_max_lres_d > 14.5) => -0.0013528132,
      (r_C13_max_lres_d = NULL) => -0.0004808044, -0.0004808044),
   (r_D33_Eviction_Recency_d = NULL) => 0.0103348250, 0.0009789123),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 33.25) => -0.0089669140,
      (C_INC_75K_P > 33.25) => 0.1515284396,
      (C_INC_75K_P = NULL) => 0.0100700045, -0.0065596789),
   (f_attr_arrests_i > 0.5) => 0.0954370046,
   (f_attr_arrests_i = NULL) => 0.0028671569, -0.0055487050), -0.0023513404);

// Tree: 127 
woFDN_FLAPSD_lgt_127 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 5.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 34.5) => 0.0047894084,
      (f_rel_count_i > 34.5) => -0.0506396098,
      (f_rel_count_i = NULL) => 0.0033226885, 0.0033226885),
   (f_varrisktype_i > 5.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 37.25) => -0.0055946046,
      (c_white_col > 37.25) => 0.1211525425,
      (c_white_col = NULL) => 0.0543400928, 0.0543400928),
   (f_varrisktype_i = NULL) => 0.0038846193, 0.0038846193),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0610076109,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 9.7) => -0.0778792370,
   (c_retail > 9.7) => 0.0228981317,
   (c_retail = NULL) => -0.0284595658, -0.0284595658), 0.0010411765);

// Tree: 128 
woFDN_FLAPSD_lgt_128 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 3.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 4.5) => 0.0020685386,
   (r_C14_addrs_15yr_i > 4.5) => -0.0277974085,
   (r_C14_addrs_15yr_i = NULL) => -0.0149555435, -0.0048974768),
(k_inq_per_phone_i > 3.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 16.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 116.5) => 0.0323288319,
      (c_easiqlife > 116.5) => 0.1711159332,
      (c_easiqlife = NULL) => 0.1042007237, 0.1042007237),
   (r_C13_Curr_Addr_LRes_d > 16.5) => 
      map(
      (NULL < c_finance and c_finance <= 0.75) => 0.0778477705,
      (c_finance > 0.75) => -0.0501474480,
      (c_finance = NULL) => -0.0046491477, -0.0046491477),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0286186414, 0.0286186414),
(k_inq_per_phone_i = NULL) => -0.0039092995, -0.0039092995);

// Tree: 129 
woFDN_FLAPSD_lgt_129 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 5.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0100829606,
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 157) => 0.1869720105,
         (c_asian_lang > 157) => -0.0116385217,
         (c_asian_lang = NULL) => 0.0893498845, 0.0893498845),
      (f_M_Bureau_ADL_FS_noTU_d > 8.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 24.95) => 0.0028561960,
         (c_hval_750k_p > 24.95) => 0.0637568611,
         (c_hval_750k_p = NULL) => 0.0091816614, 0.0131309252),
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0149024117, 0.0149024117),
   (k_inq_per_ssn_i = NULL) => 0.0000186054, 0.0000186054),
(k_inq_adls_per_addr_i > 5.5) => -0.0837262454,
(k_inq_adls_per_addr_i = NULL) => -0.0004963412, -0.0004963412);

// Tree: 130 
woFDN_FLAPSD_lgt_130 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 3.5) => 0.0920758424,
(r_D32_Mos_Since_Crim_LS_d > 3.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -26353) => -0.0510327445,
   (f_addrchangeincomediff_d > -26353) => 
      map(
      (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => -0.0027537838,
      (r_F03_input_add_not_most_rec_i > 0.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 1.4) => 0.3131399449,
         (c_rnt1000_p > 1.4) => 0.0320797973,
         (c_rnt1000_p = NULL) => 0.1363140242, 0.1363140242),
      (r_F03_input_add_not_most_rec_i = NULL) => -0.0005496021, -0.0005496021),
   (f_addrchangeincomediff_d = NULL) => -0.0056383847, -0.0024899648),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 5.8) => -0.0370372979,
   (C_INC_15K_P > 5.8) => 0.0575160820,
   (C_INC_15K_P = NULL) => 0.0102393920, 0.0102393920), -0.0016773827);

// Tree: 131 
woFDN_FLAPSD_lgt_131 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 140) => -0.0058081366,
(f_curraddrcrimeindex_i > 140) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 13.95) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 194.5) => 0.0044726894,
      (r_pb_order_freq_d > 194.5) => -0.0423149033,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 7.35) => 0.0292310818,
         (c_hh6_p > 7.35) => 0.1507586227,
         (c_hh6_p = NULL) => 0.0394220706, 0.0394220706), 0.0142810563),
   (c_femdiv_p > 13.95) => 0.2133962423,
   (c_femdiv_p = NULL) => 0.0187019085, 0.0187019085),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0824069319,
   (k_comb_age_d > 26.5) => 0.0589559320,
   (k_comb_age_d = NULL) => -0.0055253744, -0.0055253744), -0.0014349433);

// Tree: 132 
woFDN_FLAPSD_lgt_132 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 23.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 3.25) => -0.0288818147,
   (c_incollege > 3.25) => 0.0019352437,
   (c_incollege = NULL) => 0.0010874731, -0.0040558218),
(f_srchaddrsrchcount_i > 23.5) => 
   map(
   (NULL < c_young and c_young <= 21.45) => -0.1209058394,
   (c_young > 21.45) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 122) => 0.0489875616,
      (c_sub_bus > 122) => -0.0938050158,
      (c_sub_bus = NULL) => -0.0210087999, -0.0210087999),
   (c_young = NULL) => -0.0595233212, -0.0595233212),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 102.5) => 0.0324860594,
   (c_very_rich > 102.5) => -0.0859772526,
   (c_very_rich = NULL) => -0.0278424791, -0.0278424791), -0.0049923299);

// Tree: 133 
woFDN_FLAPSD_lgt_133 := map(
(NULL < c_newhouse and c_newhouse <= 117.15) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 136.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 4.5) => -0.0054637164,
      (f_srchfraudsrchcountyr_i > 4.5) => -0.0831656756,
      (f_srchfraudsrchcountyr_i = NULL) => -0.0121146436, -0.0067396395),
   (c_easiqlife > 136.5) => 
      map(
      (NULL < c_murders and c_murders <= 181.5) => 0.0135794861,
      (c_murders > 181.5) => 0.1312766283,
      (c_murders = NULL) => 0.0168630767, 0.0168630767),
   (c_easiqlife = NULL) => 0.0010232877, 0.0010232877),
(c_newhouse > 117.15) => -0.0500761461,
(c_newhouse = NULL) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.0952009375,
   (f_corrssnaddrcount_d > 2.5) => -0.0335984900,
   (f_corrssnaddrcount_d = NULL) => 0.0087146793, 0.0087146793), -0.0009304769);

// Tree: 134 
woFDN_FLAPSD_lgt_134 := map(
(NULL < c_unempl and c_unempl <= 184.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 36.5) => -0.0153584386,
   (k_comb_age_d > 36.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 4.5) => -0.0011275983,
      (f_corrrisktype_i > 4.5) => 0.0337510163,
      (f_corrrisktype_i = NULL) => 0.0088734206, 0.0088734206),
   (k_comb_age_d = NULL) => -0.0011061614, -0.0011061614),
(c_unempl > 184.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 96) => -0.0538312426,
   (f_fp_prevaddrburglaryindex_i > 96) => 
      map(
      (NULL < c_murders and c_murders <= 166.5) => 0.1973588025,
      (c_murders > 166.5) => 0.0212133359,
      (c_murders = NULL) => 0.1152235569, 0.1152235569),
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0747659980, 0.0747659980),
(c_unempl = NULL) => -0.0068473907, 0.0001768753);

// Tree: 135 
woFDN_FLAPSD_lgt_135 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 52205) => 
   map(
   (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 128.5) => 0.0461971628,
      (c_bel_edu > 128.5) => 0.1938559032,
      (c_bel_edu = NULL) => 0.1076231988, 0.1076231988),
   (f_property_owners_ct_d > 0.5) => 0.0019734001,
   (f_property_owners_ct_d = NULL) => 0.0344030745, 0.0344030745),
(r_A46_Curr_AVM_AutoVal_d > 52205) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => -0.0101509705,
   (f_inq_QuizProvider_count_i > 5.5) => 0.1339992313,
   (f_inq_QuizProvider_count_i = NULL) => -0.0087502176, -0.0087502176),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => -0.0003130511,
   (k_inq_per_phone_i > 4.5) => 0.0590136363,
   (k_inq_per_phone_i = NULL) => 0.0009978563, 0.0009978563), -0.0031234635);

// Tree: 136 
woFDN_FLAPSD_lgt_136 := map(
(NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 1.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 139272) => 
      map(
      (NULL < k_inq_lnames_per_addr_i and k_inq_lnames_per_addr_i <= 2.5) => 0.0252235690,
      (k_inq_lnames_per_addr_i > 2.5) => 0.1077270839,
      (k_inq_lnames_per_addr_i = NULL) => 0.0284694742, 0.0284694742),
   (r_L80_Inp_AVM_AutoVal_d > 139272) => 
      map(
      (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.35) => -0.0150691956,
      (c_hval_1000k_p > 41.35) => 0.1653274291,
      (c_hval_1000k_p = NULL) => -0.0117125985, -0.0117125985),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0072795882,
      (f_assocrisktype_i > 3.5) => 0.0325466468,
      (f_assocrisktype_i = NULL) => 0.0013629375, 0.0013629375), 0.0010620143),
(r_D31_MostRec_Bk_i > 1.5) => -0.0342199485,
(r_D31_MostRec_Bk_i = NULL) => 0.0184686144, -0.0020995321);

// Tree: 137 
woFDN_FLAPSD_lgt_137 := map(
(NULL < f_mos_liens_unrel_ST_lseen_d and f_mos_liens_unrel_ST_lseen_d <= 28) => -0.1308404831,
(f_mos_liens_unrel_ST_lseen_d > 28) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0682130608,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 105.5) => -0.0041031916,
      (f_addrchangecrimediff_i > 105.5) => -0.0721643764,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
            map(
            (NULL < c_famotf18_p and c_famotf18_p <= 37) => 0.0244968624,
            (c_famotf18_p > 37) => 0.1207230868,
            (c_famotf18_p = NULL) => 0.0048348100, 0.0258253964),
         (r_D30_Derog_Count_i > 0.5) => -0.0246473285,
         (r_D30_Derog_Count_i = NULL) => 0.0081848016, 0.0081848016), -0.0017326094),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0013352862, -0.0013352862),
(f_mos_liens_unrel_ST_lseen_d = NULL) => -0.0099453171, -0.0021572659);

// Tree: 138 
woFDN_FLAPSD_lgt_138 := map(
(NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 76.5) => -0.0908930835,
(f_mos_liens_rel_CJ_lseen_d > 76.5) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 43.85) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 1.5) => -0.0267187543,
      (f_phones_per_addr_curr_i > 1.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0605897708,
         (r_F00_dob_score_d > 92) => 0.0039979470,
         (r_F00_dob_score_d = NULL) => 0.0124888330, 0.0060104103),
      (f_phones_per_addr_curr_i = NULL) => -0.0004206693, -0.0004206693),
   (c_hval_125k_p > 43.85) => 
      map(
      (NULL < c_white_col and c_white_col <= 35.65) => 0.2217239721,
      (c_white_col > 35.65) => -0.0288684239,
      (c_white_col = NULL) => 0.0927783703, 0.0927783703),
   (c_hval_125k_p = NULL) => 0.0049720276, 0.0004764179),
(f_mos_liens_rel_CJ_lseen_d = NULL) => -0.0079726350, -0.0005654997);

// Tree: 139 
woFDN_FLAPSD_lgt_139 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 128.5) => -0.0081995415,
(f_prevaddrageoldest_d > 128.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 3.5) => -0.0024707517,
   (f_corrrisktype_i > 3.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 121.5) => 0.0100269922,
      (c_asian_lang > 121.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 3.75) => 
            map(
            (NULL < c_rich_wht and c_rich_wht <= 156.5) => 0.0811436712,
            (c_rich_wht > 156.5) => 0.2934068007,
            (c_rich_wht = NULL) => 0.1593973595, 0.1593973595),
         (c_hval_250k_p > 3.75) => 0.0446918607,
         (c_hval_250k_p = NULL) => 0.0854301475, 0.0854301475),
      (c_asian_lang = NULL) => 0.0591417579, 0.0462047392),
   (f_corrrisktype_i = NULL) => 0.0160327426, 0.0160327426),
(f_prevaddrageoldest_d = NULL) => -0.0173310518, -0.0014479284);

// Tree: 140 
woFDN_FLAPSD_lgt_140 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.31705992955) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 14.5) => 0.1092223761,
   (f_mos_liens_unrel_CJ_lseen_d > 14.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 0.5) => 0.0677791881,
      (f_rel_under100miles_cnt_d > 0.5) => 0.0047358511,
      (f_rel_under100miles_cnt_d = NULL) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 114) => 0.1865769319,
         (c_old_homes > 114) => -0.0412788382,
         (c_old_homes = NULL) => 0.0788632951, 0.0788632951), 0.0069858884),
   (f_mos_liens_unrel_CJ_lseen_d = NULL) => -0.0227308324, 0.0074039018),
(f_add_input_mobility_index_i > 0.31705992955) => 
   map(
   (NULL < f_liens_rel_CJ_total_amt_i and f_liens_rel_CJ_total_amt_i <= 871) => -0.0180602134,
   (f_liens_rel_CJ_total_amt_i > 871) => -0.1103613159,
   (f_liens_rel_CJ_total_amt_i = NULL) => -0.0199628128, -0.0199628128),
(f_add_input_mobility_index_i = NULL) => 0.0013305200, -0.0006633143);

// Tree: 141 
woFDN_FLAPSD_lgt_141 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 25.5) => 
   map(
   (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 0.5) => -0.0095017499,
   (f_addrs_per_ssn_c6_i > 0.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 204.35) => 
         map(
         (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 7.5) => 0.0226416127,
         (f_rel_under100miles_cnt_d > 7.5) => 0.2195482542,
         (f_rel_under100miles_cnt_d = NULL) => 0.1042327625, 0.1042327625),
      (c_housingcpi > 204.35) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.23428153775) => 0.0014681698,
         (f_add_input_nhood_BUS_pct_i > 0.23428153775) => 0.1545068711,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0103884584, 0.0103884584),
      (c_housingcpi = NULL) => 0.0235323142, 0.0235323142),
   (f_addrs_per_ssn_c6_i = NULL) => -0.0058940060, -0.0058940060),
(f_srchssnsrchcount_i > 25.5) => 0.0879457393,
(f_srchssnsrchcount_i = NULL) => 0.0067687099, -0.0053769161);

// Tree: 142 
woFDN_FLAPSD_lgt_142 := map(
(NULL < c_construction and c_construction <= 2.15) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6564) => 0.0108455393,
   (f_addrchangeincomediff_d > 6564) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 55.5) => -0.0323342667,
      (c_many_cars > 55.5) => 0.1928135769,
      (c_many_cars = NULL) => 0.0980144849, 0.0980144849),
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 59.5) => -0.0005278872,
      (k_comb_age_d > 59.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.485) => 0.0096953625,
         (c_hhsize > 2.485) => 0.2790215103,
         (c_hhsize = NULL) => 0.1334398088, 0.1334398088),
      (k_comb_age_d = NULL) => 0.0187843391, 0.0187843391), 0.0159321080),
(c_construction > 2.15) => -0.0084616238,
(c_construction = NULL) => -0.0244818247, -0.0021249377);

// Tree: 143 
woFDN_FLAPSD_lgt_143 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 76.35) => -0.0032550501,
(r_C12_source_profile_d > 76.35) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
         map(
         (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 190) => 0.1529161024,
         (f_mos_acc_lseen_d > 190) => 
            map(
            (NULL < c_burglary and c_burglary <= 30.5) => 0.1526608646,
            (c_burglary > 30.5) => 0.0042363543,
            (c_burglary = NULL) => 0.0354024157, 0.0354024157),
         (f_mos_acc_lseen_d = NULL) => 0.0533148872, 0.0533148872),
      (k_inq_per_addr_i > 3.5) => 0.1757893618,
      (k_inq_per_addr_i = NULL) => 0.0636463229, 0.0636463229),
   (f_phone_ver_experian_d > 0.5) => 0.0155210645,
   (f_phone_ver_experian_d = NULL) => -0.0107695440, 0.0284669961),
(r_C12_source_profile_d = NULL) => 0.0174813347, 0.0015681795);

// Tree: 144 
woFDN_FLAPSD_lgt_144 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 559) => -0.0626268176,
(f_mos_inq_banko_am_fseen_d > 559) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 14.5) => 
      map(
      (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 13200) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 10.45) => 0.0081855071,
         (c_pop_75_84_p > 10.45) => -0.0488910015,
         (c_pop_75_84_p = NULL) => 0.0038404684, 0.0046150946),
      (f_liens_unrel_CJ_total_amt_i > 13200) => 0.1050049822,
      (f_liens_unrel_CJ_total_amt_i = NULL) => 0.0054250343, 0.0054250343),
   (f_inq_Collection_count_i > 14.5) => -0.0708132670,
   (f_inq_Collection_count_i = NULL) => 0.0045418910, 0.0045418910),
(f_mos_inq_banko_am_fseen_d = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 84.5) => 0.0630933061,
   (c_many_cars > 84.5) => -0.0172358007,
   (c_many_cars = NULL) => 0.0173888143, 0.0173888143), 0.0011983831);

// Tree: 145 
woFDN_FLAPSD_lgt_145 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 55.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0086396716) => 0.1616850792,
   (f_add_curr_nhood_MFD_pct_i > 0.0086396716) => 
      map(
      (NULL < c_retail and c_retail <= 21.05) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 5.5) => -0.0464129753,
         (f_rel_incomeover50_count_d > 5.5) => 0.0585650151,
         (f_rel_incomeover50_count_d = NULL) => 0.0034979750, 0.0034979750),
      (c_retail > 21.05) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 0.65) => -0.0096684648,
         (c_bigapt_p > 0.65) => 0.1857775543,
         (c_bigapt_p = NULL) => 0.0944626109, 0.0944626109),
      (c_retail = NULL) => 0.0210022109, 0.0210022109),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0143543180, 0.0335021562),
(r_D32_Mos_Since_Crim_LS_d > 55.5) => -0.0025067919,
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0098135597, 0.0001766921);

// Tree: 146 
woFDN_FLAPSD_lgt_146 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 26.95) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -80983) => 
         map(
         (NULL < c_professional and c_professional <= 8.3) => 0.0903568715,
         (c_professional > 8.3) => -0.0652287311,
         (c_professional = NULL) => 0.0439426791, 0.0439426791),
      (f_addrchangevaluediff_d > -80983) => -0.0026293239,
      (f_addrchangevaluediff_d = NULL) => -0.0007466701, -0.0013225259),
   (c_hval_40k_p > 26.95) => -0.0858475795,
   (c_hval_40k_p = NULL) => -0.0178268165, -0.0027404778),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0972343597,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.55) => -0.0660883894,
   (c_pop_35_44_p > 14.55) => 0.0336502369,
   (c_pop_35_44_p = NULL) => -0.0162190762, -0.0162190762), -0.0023859850);

// Tree: 147 
woFDN_FLAPSD_lgt_147 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 27.95) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 5.95) => -0.0608335332,
   (c_fammar18_p > 5.95) => 
      map(
      (NULL < c_professional and c_professional <= 3.75) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 2.5) => -0.0015965460,
         (f_srchaddrsrchcount_i > 2.5) => 0.0346585233,
         (f_srchaddrsrchcount_i = NULL) => 0.0107355304, 0.0107355304),
      (c_professional > 3.75) => -0.0111953656,
      (c_professional = NULL) => -0.0014596789, -0.0014596789),
   (c_fammar18_p = NULL) => -0.0029698379, -0.0029698379),
(C_INC_50K_P > 27.95) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 68.8) => 0.2140366507,
   (c_sfdu_p > 68.8) => -0.0043542598,
   (c_sfdu_p = NULL) => 0.1058811522, 0.1058811522),
(C_INC_50K_P = NULL) => 0.0062383002, -0.0018699259);

// Tree: 148 
woFDN_FLAPSD_lgt_148 := map(
(NULL < C_INC_35K_P and C_INC_35K_P <= 23.45) => 
   map(
   (NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 56.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.14872847485) => -0.0532402364,
      (f_add_curr_nhood_MFD_pct_i > 0.14872847485) => 0.1606187852,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0564787399, 0.0564787399),
   (f_mos_liens_unrel_OT_fseen_d > 56.5) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 89.15) => -0.0059976182,
      (c_lowrent > 89.15) => 0.0795544373,
      (c_lowrent = NULL) => -0.0042084525, -0.0042084525),
   (f_mos_liens_unrel_OT_fseen_d = NULL) => 0.0099057619, -0.0033600806),
(C_INC_35K_P > 23.45) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12) => -0.0538925613,
   (c_pop_35_44_p > 12) => 0.1372486893,
   (c_pop_35_44_p = NULL) => 0.0690794321, 0.0690794321),
(C_INC_35K_P = NULL) => 0.0072918996, -0.0023100135);

// Tree: 149 
woFDN_FLAPSD_lgt_149 := map(
(NULL < r_P85_Phn_Not_Issued_i and r_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 3.5) => 0.0008030235,
      (r_D30_Derog_Count_i > 3.5) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 22.35) => 0.0271306075,
         (c_hval_300k_p > 22.35) => 0.2288069289,
         (c_hval_300k_p = NULL) => 0.0401587937, 0.0401587937),
      (r_D30_Derog_Count_i = NULL) => 0.0034640898, 0.0034640898),
   (f_rel_criminal_count_i > 6.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 75.5) => -0.0892127275,
      (r_pb_order_freq_d > 75.5) => 0.0092959076,
      (r_pb_order_freq_d = NULL) => -0.0032213938, -0.0322442500),
   (f_rel_criminal_count_i = NULL) => 0.0030661122, 0.0012941796),
(r_P85_Phn_Not_Issued_i > 0.5) => -0.0568329286,
(r_P85_Phn_Not_Issued_i = NULL) => -0.0001126018, -0.0001126018);

// Tree: 150 
woFDN_FLAPSD_lgt_150 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 23.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 1.5) => -0.0030444406,
   (f_inq_HighRiskCredit_count24_i > 1.5) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 1.65) => 0.0090274275,
      (c_rnt2000_p > 1.65) => 0.1444834917,
      (c_rnt2000_p = NULL) => 0.0434814090, 0.0434814090),
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0019606126, -0.0019606126),
(f_srchaddrsrchcount_i > 23.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => 0.0165443792,
   (f_phones_per_addr_curr_i > 7.5) => -0.1103510569,
   (f_phones_per_addr_curr_i = NULL) => -0.0562890959, -0.0562890959),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 83.5) => -0.0458263066,
   (c_bel_edu > 83.5) => 0.0859432854,
   (c_bel_edu = NULL) => 0.0231372182, 0.0231372182), -0.0024667814);

// Tree: 151 
woFDN_FLAPSD_lgt_151 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 35.5) => 0.1306835872,
(f_mos_liens_unrel_SC_fseen_d > 35.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 2.5) => 0.0066952772,
      (f_addrchangecrimediff_i > 2.5) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 4.65) => 
            map(
            (NULL < c_unempl and c_unempl <= 119.5) => 0.0446372044,
            (c_unempl > 119.5) => 0.1822553009,
            (c_unempl = NULL) => 0.1093986616, 0.1093986616),
         (c_pop_75_84_p > 4.65) => -0.0082802313,
         (c_pop_75_84_p = NULL) => 0.0662080041, 0.0662080041),
      (f_addrchangecrimediff_i = NULL) => 0.0201922424, 0.0202027176),
   (f_corrssnaddrcount_d > 2.5) => -0.0020268242,
   (f_corrssnaddrcount_d = NULL) => 0.0001614935, 0.0001614935),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0268599116, 0.0006811584);

// Tree: 152 
woFDN_FLAPSD_lgt_152 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.25826651785) => -0.0365977840,
   (f_add_input_mobility_index_i > 0.25826651785) => -0.0680871596,
   (f_add_input_mobility_index_i = NULL) => -0.0576259241, -0.0576259241),
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 1.05) => -0.0270733388,
   (c_hh5_p > 1.05) => 
      map(
      (NULL < r_L71_Add_Curr_Business_i and r_L71_Add_Curr_Business_i <= 0.5) => 0.0035917518,
      (r_L71_Add_Curr_Business_i > 0.5) => 0.1297296952,
      (r_L71_Add_Curr_Business_i = NULL) => 0.0043228067, 0.0043228067),
   (c_hh5_p = NULL) => -0.0370698716, -0.0012113145),
(f_corrssnaddrcount_d = NULL) => 
   map(
   (NULL < c_bargains and c_bargains <= 113) => -0.0668355239,
   (c_bargains > 113) => 0.0578193397,
   (c_bargains = NULL) => -0.0080360599, -0.0080360599), -0.0026408176);

// Tree: 153 
woFDN_FLAPSD_lgt_153 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 23.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0005107009,
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 151.5) => 0.0485779878,
      (c_work_home > 151.5) => -0.0509877789,
      (c_work_home = NULL) => 0.0277471776, 0.0277471776),
   (f_hh_collections_ct_i = NULL) => 0.0030542745, 0.0030542745),
(f_rel_under500miles_cnt_d > 23.5) => -0.0446843328,
(f_rel_under500miles_cnt_d = NULL) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 209.3) => 0.1264074428,
   (c_cpiall > 209.3) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 37.3) => -0.0574175369,
      (c_lowrent > 37.3) => 0.0727422132,
      (c_lowrent = NULL) => -0.0348985490, -0.0348985490),
   (c_cpiall = NULL) => -0.0099008368, -0.0099008368), 0.0008507178);

// Tree: 154 
woFDN_FLAPSD_lgt_154 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 11.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 70.05) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0008994304,
      (r_P85_Phn_Disconnected_i > 0.5) => 
         map(
         (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 0.1928302276,
         (f_rel_criminal_count_i > 1.5) => -0.0080913337,
         (f_rel_criminal_count_i = NULL) => 0.0970638759, 0.0970638759),
      (r_P85_Phn_Disconnected_i = NULL) => 0.0008610792, 0.0008610792),
   (c_rnt1000_p > 70.05) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 1.9) => 0.0096225364,
      (c_rnt750_p > 1.9) => 0.1944719335,
      (c_rnt750_p = NULL) => 0.0767864653, 0.0767864653),
   (c_rnt1000_p = NULL) => 0.0042181305, 0.0028269049),
(r_D32_criminal_count_i > 11.5) => 0.0786844748,
(r_D32_criminal_count_i = NULL) => -0.0205949582, 0.0030240243);

// Tree: 155 
woFDN_FLAPSD_lgt_155 := map(
(NULL < c_lar_fam and c_lar_fam <= 59.5) => -0.0297039070,
(c_lar_fam > 59.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 59.5) => 
      map(
      (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 2.5) => 0.0013768055,
      (f_hh_age_65_plus_d > 2.5) => 0.0815603086,
      (f_hh_age_65_plus_d = NULL) => 0.0198739758, 0.0033160833),
   (f_phones_per_addr_curr_i > 59.5) => 0.0861788936,
   (f_phones_per_addr_curr_i = NULL) => 0.0040283030, 0.0040283030),
(c_lar_fam = NULL) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 72.1) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.2211055890,
      (r_F01_inp_addr_address_score_d > 95) => -0.0154114507,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0629348187, 0.0629348187),
   (r_C12_source_profile_d > 72.1) => -0.0565974796,
   (r_C12_source_profile_d = NULL) => 0.0150371247, 0.0150371247), -0.0008575196);

// Tree: 156 
woFDN_FLAPSD_lgt_156 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 8.5) => -0.0022740760,
   (f_srchssnsrchcount_i > 8.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => -0.1003719699,
      (f_mos_inq_banko_cm_fseen_d > 41.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 66) => 0.0278808732,
         (f_mos_inq_banko_cm_lseen_d > 66) => -0.0840880703,
         (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0261730995, -0.0261730995),
      (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0461907804, -0.0461907804),
   (f_srchssnsrchcount_i = NULL) => -0.0032527408, -0.0032527408),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 117.5) => 0.0009115799,
   (c_blue_empl > 117.5) => 0.3000799807,
   (c_blue_empl = NULL) => 0.1433727231, 0.1433727231),
(f_historical_count_d = NULL) => 0.0414438891, -0.0016449674);

// Tree: 157 
woFDN_FLAPSD_lgt_157 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 71.25) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 62.5) => -0.0040307264,
   (f_addrchangecrimediff_i > 62.5) => 
      map(
      (NULL < c_retail and c_retail <= 7.25) => -0.0170633316,
      (c_retail > 7.25) => 0.1213272686,
      (c_retail = NULL) => 0.0476808088, 0.0476808088),
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 33.55) => -0.0135593920,
      (c_rnt1000_p > 33.55) => 0.0480210727,
      (c_rnt1000_p = NULL) => -0.0005414193, -0.0005414193), -0.0025714059),
(c_rnt2001_p > 71.25) => 
   map(
   (NULL < c_food and c_food <= 12.75) => -0.0342061403,
   (c_food > 12.75) => 0.2870384595,
   (c_food = NULL) => 0.1286470249, 0.1286470249),
(c_rnt2001_p = NULL) => 0.0098590812, -0.0008152729);

// Tree: 158 
woFDN_FLAPSD_lgt_158 := map(
(NULL < c_hval_40k_p and c_hval_40k_p <= 35.05) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 0.5) => -0.0092625332,
   (f_rel_bankrupt_count_i > 0.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 170.5) => 0.0068316196,
      (c_sub_bus > 170.5) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 0.0286141424,
         (r_F04_curr_add_occ_index_d > 2) => 0.1385383019,
         (r_F04_curr_add_occ_index_d = NULL) => 0.0520687995, 0.0520687995),
      (c_sub_bus = NULL) => 0.0123431859, 0.0123431859),
   (f_rel_bankrupt_count_i = NULL) => -0.0159368050, 0.0007851075),
(c_hval_40k_p > 35.05) => -0.1236651276,
(c_hval_40k_p = NULL) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 85) => 0.1210256358,
   (r_F01_inp_addr_address_score_d > 85) => -0.0584485300,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0221503841, -0.0221503841), -0.0004471554);

// Tree: 159 
woFDN_FLAPSD_lgt_159 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 75.85) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 7.5) => 0.0018838904,
      (f_idverrisktype_i > 7.5) => -0.0700257606,
      (f_idverrisktype_i = NULL) => -0.0246425050, 0.0010401495),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_no_move and c_no_move <= 91) => 0.0059567642,
      (c_no_move > 91) => 0.1327838401,
      (c_no_move = NULL) => 0.0508248335, 0.0508248335),
   (k_nap_contradictory_i = NULL) => 0.0019067521, 0.0019067521),
(c_rnt1000_p > 75.85) => 
   map(
   (NULL < c_work_home and c_work_home <= 63.5) => 0.2365780242,
   (c_work_home > 63.5) => 0.0351396721,
   (c_work_home = NULL) => 0.0880058459, 0.0880058459),
(c_rnt1000_p = NULL) => -0.0050048757, 0.0032514967);

// Tree: 160 
woFDN_FLAPSD_lgt_160 := map(
(NULL < c_hh5_p and c_hh5_p <= 24.05) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 0.0032448111,
   (f_srchcomponentrisktype_i > 1.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 162) => 
         map(
         (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 0.5) => 
            map(
            (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 4.5) => 0.1058410831,
            (f_rel_under500miles_cnt_d > 4.5) => -0.0495336960,
            (f_rel_under500miles_cnt_d = NULL) => -0.0026746356, -0.0026746356),
         (f_inq_QuizProvider_count_i > 0.5) => 0.1007096336,
         (f_inq_QuizProvider_count_i = NULL) => 0.0307892199, 0.0307892199),
      (f_curraddrcrimeindex_i > 162) => 0.1387939194,
      (f_curraddrcrimeindex_i = NULL) => 0.0433479059, 0.0433479059),
   (f_srchcomponentrisktype_i = NULL) => 0.0072100906, 0.0046853540),
(c_hh5_p > 24.05) => -0.0746296705,
(c_hh5_p = NULL) => -0.0293584056, 0.0030772806);

// Tree: 161 
woFDN_FLAPSD_lgt_161 := map(
(NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 4.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 45.5) => -0.0126920365,
   (k_comb_age_d > 45.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 834) => 0.0627216235,
      (c_med_rent > 834) => 0.3418338662,
      (c_med_rent = NULL) => 0.1902470447, 0.1902470447),
   (k_comb_age_d = NULL) => 0.0391504799, 0.0391504799),
(r_C20_email_verification_d > 4.5) => -0.0782851461,
(r_C20_email_verification_d = NULL) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => -0.0048861739,
   (k_inq_per_ssn_i > 10.5) => 
      map(
      (NULL < c_rental and c_rental <= 132.5) => 0.1094098046,
      (c_rental > 132.5) => -0.0396974581,
      (c_rental = NULL) => 0.0555655153, 0.0555655153),
   (k_inq_per_ssn_i = NULL) => -0.0041552467, -0.0041552467), -0.0034799390);

// Tree: 162 
woFDN_FLAPSD_lgt_162 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => 
   map(
   (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 1.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 29.95) => 
         map(
         (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 5.5) => 0.0003270559,
         (f_srchcomponentrisktype_i > 5.5) => -0.0829133914,
         (f_srchcomponentrisktype_i = NULL) => -0.0001853634, -0.0001853634),
      (C_INC_50K_P > 29.95) => 0.1293535752,
      (C_INC_50K_P = NULL) => 0.0057748822, 0.0004981989),
   (f_divsrchaddrsuspidcount_i > 1.5) => -0.0719988894,
   (f_divsrchaddrsuspidcount_i = NULL) => -0.0001771132, -0.0001771132),
(f_hh_criminals_i > 3.5) => -0.0744016112,
(f_hh_criminals_i = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 139.5) => 0.0606352642,
   (c_asian_lang > 139.5) => -0.0412677216,
   (c_asian_lang = NULL) => 0.0091793011, 0.0091793011), -0.0008493772);

// Tree: 163 
woFDN_FLAPSD_lgt_163 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 50.85) => -0.0031083322,
(c_hval_750k_p > 50.85) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0210361273,
   (f_idverrisktype_i > 1.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 99.5) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 128) => 0.0569552619,
         (r_A50_pb_average_dollars_d > 128) => 0.2684937119,
         (r_A50_pb_average_dollars_d = NULL) => 0.1750232340, 0.1750232340),
      (c_unempl > 99.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 90.5) => 0.0869675254,
         (c_rest_indx > 90.5) => -0.0711530228,
         (c_rest_indx = NULL) => -0.0024049583, -0.0024049583),
      (c_unempl = NULL) => 0.0913992909, 0.0913992909),
   (f_idverrisktype_i = NULL) => 0.0359997189, 0.0359997189),
(c_hval_750k_p = NULL) => -0.0027359121, -0.0016048786);

// Tree: 164 
woFDN_FLAPSD_lgt_164 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 6.5) => 
      map(
      (NULL < c_totsales and c_totsales <= 56413.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 153.7) => 0.0029010949,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 153.7) => 0.0844526514,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0059333084, -0.0002108316),
      (c_totsales > 56413.5) => -0.0456860087,
      (c_totsales = NULL) => 0.0010679379, -0.0052466560),
   (f_divaddrsuspidcountnew_i > 6.5) => 0.0948227930,
   (f_divaddrsuspidcountnew_i = NULL) => 0.0207886864, -0.0045774053),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0679750617,
   (f_idverrisktype_i > 1.5) => 0.1385743080,
   (f_idverrisktype_i = NULL) => 0.0624000723, 0.0624000723),
(f_nae_nothing_found_i = NULL) => -0.0038223576, -0.0038223576);

// Tree: 165 
woFDN_FLAPSD_lgt_165 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 195.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 22160) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => -0.0141174727,
      (f_srchfraudsrchcount_i > 0.5) => 0.1382026155,
      (f_srchfraudsrchcount_i = NULL) => 0.0669335834, 0.0669335834),
   (r_A46_Curr_AVM_AutoVal_d > 22160) => -0.0039727991,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => -0.0009882865,
      (k_inq_per_ssn_i > 10.5) => 0.0905388344,
      (k_inq_per_ssn_i = NULL) => 0.0000086647, 0.0000086647), -0.0016746419),
(f_curraddrcrimeindex_i > 195.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 2.5) => 0.0180772561,
   (f_rel_homeover200_count_d > 2.5) => 0.2187119740,
   (f_rel_homeover200_count_d = NULL) => 0.0917798055, 0.0917798055),
(f_curraddrcrimeindex_i = NULL) => 0.0282729880, -0.0003192918);

// Tree: 166 
woFDN_FLAPSD_lgt_166 := map(
(NULL < c_unempl and c_unempl <= 29.5) => -0.0589304270,
(c_unempl > 29.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -9196.5) => -0.0245914916,
   (r_A49_Curr_AVM_Chg_1yr_i > -9196.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 25.4) => 0.1640774905,
      (c_med_age > 25.4) => 0.0123960522,
      (c_med_age = NULL) => 0.0157457143, 0.0157457143),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0054600069,
         (r_D33_eviction_count_i > 3.5) => 0.0779109893,
         (r_D33_eviction_count_i = NULL) => -0.0046552403, -0.0046552403),
      (f_hh_collections_ct_i > 4.5) => 0.0915753922,
      (f_hh_collections_ct_i = NULL) => 0.0003386177, -0.0035111629), 0.0010356341),
(c_unempl = NULL) => -0.0261198946, -0.0036194619);

// Tree: 167 
woFDN_FLAPSD_lgt_167 := map(
(NULL < c_hh3_p and c_hh3_p <= 40.25) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 85.5) => 
         map(
         (NULL < c_white_col and c_white_col <= 46.05) => 
            map(
            (NULL < c_burglary and c_burglary <= 72.5) => 0.0860205301,
            (c_burglary > 72.5) => -0.0053255974,
            (c_burglary = NULL) => 0.0306192686, 0.0306192686),
         (c_white_col > 46.05) => -0.0683579015,
         (c_white_col = NULL) => -0.0066086309, -0.0066086309),
      (c_born_usa > 85.5) => -0.0651999414,
      (c_born_usa = NULL) => -0.0310601227, -0.0310601227),
   (r_F01_inp_addr_address_score_d > 75) => 0.0019741385,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0105609518, -0.0001764637),
(c_hh3_p > 40.25) => 0.1361697954,
(c_hh3_p = NULL) => 0.0005029039, 0.0003767666);

// Tree: 168 
woFDN_FLAPSD_lgt_168 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 61.5) => -0.0639365958,
(f_mos_inq_banko_am_fseen_d > 61.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 87.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 3.5) => -0.0092347385,
      (f_srchfraudsrchcountyr_i > 3.5) => -0.0871454926,
      (f_srchfraudsrchcountyr_i = NULL) => -0.0109447139, -0.0109447139),
   (c_new_homes > 87.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.75) => -0.0000463402,
      (c_incollege > 6.75) => 
         map(
         (NULL < r_I60_credit_seeking_i and r_I60_credit_seeking_i <= 1.5) => 0.0304176342,
         (r_I60_credit_seeking_i > 1.5) => 0.1473269549,
         (r_I60_credit_seeking_i = NULL) => 0.0344712957, 0.0344712957),
      (c_incollege = NULL) => 0.0126249273, 0.0126249273),
   (c_new_homes = NULL) => 0.0046925402, 0.0038766600),
(f_mos_inq_banko_am_fseen_d = NULL) => -0.0126127642, 0.0008510537);

// Tree: 169 
woFDN_FLAPSD_lgt_169 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 5.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 1.35) => -0.0274938739,
   (C_INC_150K_P > 1.35) => 0.0019627789,
   (C_INC_150K_P = NULL) => 0.0003262219, -0.0011864267),
(f_varrisktype_i > 5.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 143.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => -0.0665256406,
      (r_C14_addrs_10yr_i > 2.5) => 0.1023593234,
      (r_C14_addrs_10yr_i = NULL) => 0.0126858912, 0.0126858912),
   (c_easiqlife > 143.5) => 0.1197744120,
   (c_easiqlife = NULL) => 0.0494197443, 0.0494197443),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 25.7) => 0.0771667074,
   (C_RENTOCC_P > 25.7) => -0.0476897508,
   (C_RENTOCC_P = NULL) => 0.0186402426, 0.0186402426), -0.0002779674);

// Tree: 170 
woFDN_FLAPSD_lgt_170 := map(
(NULL < c_hh6_p and c_hh6_p <= 12.35) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 26.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.15) => -0.0031453472,
      (r_C12_source_profile_d > 78.15) => 
         map(
         (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 54.5) => 0.0239445195,
         (r_P88_Phn_Dst_to_Inp_Add_i > 54.5) => -0.0818590792,
         (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
            map(
            (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 2.5) => 0.0379308922,
            (f_bus_addr_match_count_d > 2.5) => 0.1843845505,
            (f_bus_addr_match_count_d = NULL) => 0.0673766013, 0.0673766013), 0.0306136364),
      (r_C12_source_profile_d = NULL) => 0.0013699169, 0.0013699169),
   (f_srchssnsrchcount_i > 26.5) => 0.0855169085,
   (f_srchssnsrchcount_i = NULL) => -0.0069791269, 0.0016860296),
(c_hh6_p > 12.35) => -0.0749976285,
(c_hh6_p = NULL) => 0.0225390866, 0.0006191112);

// Tree: 171 
woFDN_FLAPSD_lgt_171 := map(
(NULL < k_inq_lnames_per_addr_i and k_inq_lnames_per_addr_i <= 4.5) => 
   map(
   (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => -0.0116120667,
   (f_util_add_input_misc_n > 0.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0015169735,
      (r_C23_inp_addr_occ_index_d > 2) => 
         map(
         (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0385737674,
         (r_L70_Add_Standardized_i > 0.5) => 0.1519574445,
         (r_L70_Add_Standardized_i = NULL) => 0.0471482370, 0.0471482370),
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0112109848, 0.0112109848),
   (f_util_add_input_misc_n = NULL) => -0.0009250678, -0.0009250678),
(k_inq_lnames_per_addr_i > 4.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 17.35) => -0.1308019265,
   (c_hh3_p > 17.35) => 0.0156708656,
   (c_hh3_p = NULL) => -0.0748962807, -0.0748962807),
(k_inq_lnames_per_addr_i = NULL) => -0.0016948116, -0.0016948116);

// Tree: 172 
woFDN_FLAPSD_lgt_172 := map(
(NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 7.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 37.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 2.5) => -0.0415651304,
      (f_addrs_per_ssn_i > 2.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 154.5) => -0.0002855020,
         (c_sub_bus > 154.5) => 
            map(
            (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 15.5) => 0.1389915058,
            (r_D32_Mos_Since_Crim_LS_d > 15.5) => 0.0192675799,
            (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0219750202, 0.0219750202),
         (c_sub_bus = NULL) => 0.0018297389, 0.0050172950),
      (f_addrs_per_ssn_i = NULL) => 0.0006478055, 0.0006478055),
   (f_rel_educationover8_count_d > 37.5) => -0.0846760959,
   (f_rel_educationover8_count_d = NULL) => -0.0156323750, -0.0003911462),
(f_assoccredbureaucount_i > 7.5) => 0.0855261670,
(f_assoccredbureaucount_i = NULL) => 0.0061304639, 0.0001130381);

// Tree: 173 
woFDN_FLAPSD_lgt_173 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 54.25) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 22.5) => 
         map(
         (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 0.0226328284,
         (f_util_add_input_conv_n > 0.5) => 0.2026067908,
         (f_util_add_input_conv_n = NULL) => 0.1191551769, 0.1191551769),
      (k_comb_age_d > 22.5) => 0.0224073106,
      (k_comb_age_d = NULL) => 0.0338533569, 0.0338533569),
   (r_Ever_Asset_Owner_d > 0.5) => -0.0025703056,
   (r_Ever_Asset_Owner_d = NULL) => 0.0055036431, 0.0028072862),
(C_RENTOCC_P > 54.25) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 63.6) => -0.0419232401,
   (r_C12_source_profile_d > 63.6) => 0.0163232635,
   (r_C12_source_profile_d = NULL) => -0.0265307707, -0.0265307707),
(C_RENTOCC_P = NULL) => -0.0353402425, -0.0027792761);

// Tree: 174 
woFDN_FLAPSD_lgt_174 := map(
(NULL < c_hh3_p and c_hh3_p <= 40.25) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 15.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 10.5) => 
         map(
         (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 7.5) => 0.0033224688,
         (f_inq_Collection_count_i > 7.5) => -0.0570774865,
         (f_inq_Collection_count_i = NULL) => 0.0018405406, 0.0018405406),
      (f_inq_Collection_count_i > 10.5) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.65) => -0.0468660461,
         (c_pop_65_74_p > 4.65) => 0.1393068951,
         (c_pop_65_74_p = NULL) => 0.0648377186, 0.0648377186),
      (f_inq_Collection_count_i = NULL) => 0.0026734235, 0.0026734235),
   (f_inq_Collection_count_i > 15.5) => -0.0778019191,
   (f_inq_Collection_count_i = NULL) => -0.0130921615, 0.0016080428),
(c_hh3_p > 40.25) => 0.1209525875,
(c_hh3_p = NULL) => -0.0082853357, 0.0018694875);

// Tree: 175 
woFDN_FLAPSD_lgt_175 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 21.5) => 
   map(
   (NULL < f_hh_bankruptcies_i and f_hh_bankruptcies_i <= 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 42.5) => 
         map(
         (NULL < c_larceny and c_larceny <= 144.5) => -0.0670840059,
         (c_larceny > 144.5) => 0.0883663422,
         (c_larceny = NULL) => -0.0264708519, -0.0264708519),
      (f_M_Bureau_ADL_FS_all_d > 42.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 10.55) => 0.0447013654,
         (c_famotf18_p > 10.55) => 0.2262826238,
         (c_famotf18_p = NULL) => 0.1363405051, 0.1363405051),
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0127652184, 0.0127652184),
   (f_hh_bankruptcies_i > 0.5) => 0.1837662563,
   (f_hh_bankruptcies_i = NULL) => 0.0383170976, 0.0383170976),
(k_comb_age_d > 21.5) => -0.0038857166,
(k_comb_age_d = NULL) => -0.0020126237, -0.0020126237);

// Tree: 176 
woFDN_FLAPSD_lgt_176 := map(
(NULL < c_assault and c_assault <= 167.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => -0.0685754488,
   (r_D33_Eviction_Recency_d > 30) => -0.0056786474,
   (r_D33_Eviction_Recency_d = NULL) => -0.0203565034, -0.0063039772),
(c_assault > 167.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 180.5) => 0.0097698099,
      (c_unempl > 180.5) => 0.1054299673,
      (c_unempl = NULL) => 0.0158900479, 0.0158900479),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 5.5) => 0.1916743875,
      (f_corraddrnamecount_d > 5.5) => 0.0129322985,
      (f_corraddrnamecount_d = NULL) => 0.0978347908, 0.0978347908),
   (f_inq_Communications_count_i = NULL) => 0.0236881201, 0.0236881201),
(c_assault = NULL) => 0.0079248616, -0.0029693500);

// Tree: 177 
woFDN_FLAPSD_lgt_177 := map(
(NULL < C_INC_35K_P and C_INC_35K_P <= 26.45) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0023412296,
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 43.5) => 0.2657425757,
      (c_no_car > 43.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04605384475) => -0.0729725621,
         (f_add_curr_nhood_BUS_pct_i > 0.04605384475) => 0.0956784410,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0079343380, 0.0079343380),
      (c_no_car = NULL) => 0.0702068592, 0.0702068592),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0011266183, -0.0011266183),
(C_INC_35K_P > 26.45) => 0.1152270080,
(C_INC_35K_P = NULL) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => -0.0579433007,
   (f_srchfraudsrchcount_i > 0.5) => 0.0970029401,
   (f_srchfraudsrchcount_i = NULL) => -0.0100400736, -0.0100400736), -0.0007991656);

// Tree: 178 
woFDN_FLAPSD_lgt_178 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 7.5) => 
   map(
   (NULL < c_rnt1500_p and c_rnt1500_p <= 17.85) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.8619167536) => 
            map(
            (NULL < C_INC_150K_P and C_INC_150K_P <= 10.35) => 0.0365199463,
            (C_INC_150K_P > 10.35) => 0.1732552349,
            (C_INC_150K_P = NULL) => 0.0462310130, 0.0462310130),
         (f_add_curr_nhood_MFD_pct_i > 0.8619167536) => -0.0259591911,
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0213798057, 0.0292956998),
      (r_Ever_Asset_Owner_d > 0.5) => 0.0022955727,
      (r_Ever_Asset_Owner_d = NULL) => 0.0078496248, 0.0078496248),
   (c_rnt1500_p > 17.85) => -0.0269193398,
   (c_rnt1500_p = NULL) => 0.0307396502, 0.0031413111),
(r_C18_invalid_addrs_per_adl_i > 7.5) => -0.0550228292,
(r_C18_invalid_addrs_per_adl_i = NULL) => 0.0173308480, 0.0010239551);

// Tree: 179 
woFDN_FLAPSD_lgt_179 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -94327.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.06040561345) => 0.1824122802,
      (f_add_input_nhood_BUS_pct_i > 0.06040561345) => 0.0457619682,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.1185569943, 0.1185569943),
   (f_phone_ver_experian_d > 0.5) => -0.0248896252,
   (f_phone_ver_experian_d = NULL) => -0.0088335113, 0.0428686334),
(f_addrchangevaluediff_d > -94327.5) => -0.0027382753,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 3.05) => -0.0078927582,
   (c_hh7p_p > 3.05) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 16.35) => 0.0172418873,
      (c_rnt1250_p > 16.35) => 0.1373153043,
      (c_rnt1250_p = NULL) => 0.0514670893, 0.0514670893),
   (c_hh7p_p = NULL) => -0.0067577934, 0.0008693197), -0.0010073110);

// Tree: 180 
woFDN_FLAPSD_lgt_180 := map(
(NULL < c_sub_bus and c_sub_bus <= 103.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 2.5) => -0.0106770653,
   (f_srchfraudsrchcountyr_i > 2.5) => -0.0621799177,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0124650889, -0.0124650889),
(c_sub_bus > 103.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 60.75) => 0.0188758737,
   (c_low_ed > 60.75) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 18) => -0.0621230698,
      (r_I60_inq_recency_d > 18) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0104849600,
         (k_inq_per_ssn_i > 1.5) => 0.1338735806,
         (k_inq_per_ssn_i = NULL) => 0.0025328794, 0.0025328794),
      (r_I60_inq_recency_d = NULL) => -0.0214016251, -0.0214016251),
   (c_low_ed = NULL) => 0.0131766591, 0.0131766591),
(c_sub_bus = NULL) => 0.0241202633, 0.0026344465);

// Tree: 181 
woFDN_FLAPSD_lgt_181 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 198.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 29.5) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 93.5) => -0.0151460807,
         (c_new_homes > 93.5) => 0.0067792808,
         (c_new_homes = NULL) => -0.0037197268, -0.0019737442),
      (f_addrs_per_ssn_i > 29.5) => 0.1040958096,
      (f_addrs_per_ssn_i = NULL) => -0.0014520766, -0.0014520766),
   (f_curraddrmurderindex_i > 198.5) => 0.1550511845,
   (f_curraddrmurderindex_i = NULL) => -0.0008237009, -0.0008237009),
(f_hh_criminals_i > 3.5) => -0.0766622376,
(f_hh_criminals_i = NULL) => 
   map(
   (NULL < c_retired2 and c_retired2 <= 104.5) => 0.0432629996,
   (c_retired2 > 104.5) => -0.0421509456,
   (c_retired2 = NULL) => 0.0054692185, 0.0054692185), -0.0014661465);

// Tree: 182 
woFDN_FLAPSD_lgt_182 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 3.25) => -0.0435128583,
(c_pop_18_24_p > 3.25) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 8.5) => 0.1032197512,
      (f_M_Bureau_ADL_FS_all_d > 8.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.9586534122) => 0.0074256035,
         (f_add_curr_nhood_MFD_pct_i > 0.9586534122) => 0.1227303946,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0252460958, 0.0123867860),
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0300336402, 0.0139006019),
   (r_Phn_Cell_n > 0.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 0.1083481861,
      (f_mos_liens_unrel_SC_fseen_d > 66.5) => -0.0146427927,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0131664467, -0.0131664467),
   (r_Phn_Cell_n = NULL) => 0.0007728786, 0.0007728786),
(c_pop_18_24_p = NULL) => 0.0104482863, -0.0030927877);

// Tree: 183 
woFDN_FLAPSD_lgt_183 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 125885) => -0.0230581037,
(f_prevaddrmedianvalue_d > 125885) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.028477754) => -0.0048258680,
   (f_add_curr_nhood_VAC_pct_i > 0.028477754) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
         map(
         (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => 0.0170418015,
         (f_divaddrsuspidcountnew_i > 0.5) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 120) => 0.2758405808,
            (c_span_lang > 120) => 0.0852204424,
            (c_span_lang = NULL) => 0.1576560950, 0.1576560950),
         (f_divaddrsuspidcountnew_i = NULL) => 0.0703904405, 0.0703904405),
      (r_C12_Num_NonDerogs_d > 1.5) => 0.0192884326,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0260838215, 0.0260838215),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0050823146, 0.0050823146),
(f_prevaddrmedianvalue_d = NULL) => -0.0176814275, -0.0022969961);

// Tree: 184 
woFDN_FLAPSD_lgt_184 := map(
(NULL < c_transport and c_transport <= 28.25) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 23.35) => 0.0411596495,
      (c_white_col > 23.35) => 0.0042814302,
      (c_white_col = NULL) => 0.0079922723, 0.0079922723),
   (r_C14_addrs_10yr_i > 2.5) => -0.0154805553,
   (r_C14_addrs_10yr_i = NULL) => 0.0007645243, 0.0001552038),
(c_transport > 28.25) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 30.55) => 0.0329311594,
      (c_hh2_p > 30.55) => 0.2100877856,
      (c_hh2_p = NULL) => 0.1167028974, 0.1167028974),
   (f_phone_ver_insurance_d > 3.5) => -0.0019014359,
   (f_phone_ver_insurance_d = NULL) => 0.0613215351, 0.0613215351),
(c_transport = NULL) => 0.0075851040, 0.0015188756);

// Tree: 185 
woFDN_FLAPSD_lgt_185 := map(
(NULL < c_med_inc and c_med_inc <= 13.5) => -0.0444509195,
(c_med_inc > 13.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 3.5) => -0.0018423267,
   (f_inq_HighRiskCredit_count24_i > 3.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 2074.5) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 96.5) => 0.1490290934,
         (c_mort_indx > 96.5) => 0.0159959532,
         (c_mort_indx = NULL) => 0.0856207742, 0.0856207742),
      (r_A50_pb_total_dollars_d > 2074.5) => -0.0423141541,
      (r_A50_pb_total_dollars_d = NULL) => 0.0437804203, 0.0437804203),
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0026281266, -0.0012459184),
(c_med_inc = NULL) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.1362589561,
   (r_F01_inp_addr_address_score_d > 95) => -0.0184926319,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0170241260, 0.0170241260), -0.0022752375);

// Tree: 186 
woFDN_FLAPSD_lgt_186 := map(
(NULL < r_C22_stl_inq_Count24_i and r_C22_stl_inq_Count24_i <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 13.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 29.35) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 153.5) => 0.0042435984,
         (f_prevaddrmurderindex_i > 153.5) => 0.0436937470,
         (f_prevaddrmurderindex_i = NULL) => 0.0097183912, 0.0097183912),
      (c_rnt750_p > 29.35) => -0.0151822506,
      (c_rnt750_p = NULL) => 0.0114239425, 0.0019477615),
   (k_inq_per_ssn_i > 13.5) => 0.0967103862,
   (k_inq_per_ssn_i = NULL) => 0.0025701512, 0.0025701512),
(r_C22_stl_inq_Count24_i > 0.5) => -0.0638695820,
(r_C22_stl_inq_Count24_i = NULL) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 12.45) => -0.0391264078,
   (C_INC_100K_P > 12.45) => 0.0668871178,
   (C_INC_100K_P = NULL) => 0.0109355348, 0.0109355348), 0.0021713034);

// Tree: 187 
woFDN_FLAPSD_lgt_187 := map(
(NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.2688741879) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 11.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 14.5) => 0.0047784754,
      (f_hh_members_ct_d > 14.5) => -0.0790381554,
      (f_hh_members_ct_d = NULL) => 0.0042896829, 0.0042896829),
   (f_crim_rel_under100miles_cnt_i > 11.5) => 0.1277348882,
   (f_crim_rel_under100miles_cnt_i = NULL) => 
      map(
      (NULL < c_child and c_child <= 27.85) => -0.0318845289,
      (c_child > 27.85) => 0.0837413615,
      (c_child = NULL) => -0.0102046745, -0.0102046745), 0.0045704806),
(f_add_input_nhood_BUS_pct_i > 0.2688741879) => -0.0629484657,
(f_add_input_nhood_BUS_pct_i = NULL) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0069162215,
   (f_srchvelocityrisktype_i > 4.5) => 0.1032412118,
   (f_srchvelocityrisktype_i = NULL) => 0.0021626879, 0.0021626879), 0.0020946643);

// Tree: 188 
woFDN_FLAPSD_lgt_188 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 9.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => -0.0005089625,
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.85) => -0.0160093807,
      (c_pop_6_11_p > 8.85) => 0.1299806115,
      (c_pop_6_11_p = NULL) => 0.0419998878, 0.0419998878),
   (f_inq_PrepaidCards_count24_i = NULL) => 0.0000193766, 0.0000193766),
(f_srchssnsrchcount_i > 9.5) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 38.65) => -0.1680438656,
   (c_sfdu_p > 38.65) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => -0.0934004748,
      (f_util_adl_count_n > 3.5) => -0.0033697342,
      (f_util_adl_count_n = NULL) => -0.0516470879, -0.0516470879),
   (c_sfdu_p = NULL) => -0.0742923754, -0.0742923754),
(f_srchssnsrchcount_i = NULL) => -0.0072035404, -0.0015692471);

// Tree: 189 
woFDN_FLAPSD_lgt_189 := map(
(NULL < c_born_usa and c_born_usa <= 10.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 94.5) => -0.0790630579,
   (c_medi_indx > 94.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 9.5) => -0.0458063899,
      (f_addrs_per_ssn_i > 9.5) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 140) => 0.0002987879,
         (c_lar_fam > 140) => 0.1343166599,
         (c_lar_fam = NULL) => 0.0460225325, 0.0460225325),
      (f_addrs_per_ssn_i = NULL) => -0.0186096707, -0.0186096707),
   (c_medi_indx = NULL) => -0.0367972306, -0.0367972306),
(c_born_usa > 10.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 0.0002856508,
   (f_hh_tot_derog_i > 4.5) => 0.0364320573,
   (f_hh_tot_derog_i = NULL) => 0.0040486799, 0.0021100763),
(c_born_usa = NULL) => -0.0210440282, -0.0009191746);

// Tree: 190 
woFDN_FLAPSD_lgt_190 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3742808472) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 166.5) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 2137) => 0.0130491789,
         (c_popover18 > 2137) => 
            map(
            (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.45) => 0.0210154203,
            (c_pop_18_24_p > 7.45) => 0.2660217977,
            (c_pop_18_24_p = NULL) => 0.1212453020, 0.1212453020),
         (c_popover18 = NULL) => 0.0236808575, 0.0236808575),
      (c_lar_fam > 166.5) => 0.1188431363,
      (c_lar_fam = NULL) => 0.0285218966, 0.0285218966),
   (f_hh_age_18_plus_d > 1.5) => -0.0016388850,
   (f_hh_age_18_plus_d = NULL) => -0.0048146487, 0.0046466467),
(f_add_input_mobility_index_i > 0.3742808472) => -0.0164015475,
(f_add_input_mobility_index_i = NULL) => 0.1004265828, 0.0015813369);

// Tree: 191 
woFDN_FLAPSD_lgt_191 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 24) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 87109) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 11.15) => -0.0108793906,
      (c_pop_35_44_p > 11.15) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 0.65) => 0.0103438568,
         (c_hh6_p > 0.65) => 
            map(
            (NULL < C_INC_35K_P and C_INC_35K_P <= 14.55) => 0.0638528232,
            (C_INC_35K_P > 14.55) => 0.2289969667,
            (C_INC_35K_P = NULL) => 0.1048284378, 0.1048284378),
         (c_hh6_p = NULL) => 0.0612889214, 0.0612889214),
      (c_pop_35_44_p = NULL) => 0.0363394873, 0.0363394873),
   (f_curraddrmedianvalue_d > 87109) => -0.0011330390,
   (f_curraddrmedianvalue_d = NULL) => 0.0005579363, 0.0023854177),
(c_hval_60k_p > 24) => -0.0510014231,
(c_hval_60k_p = NULL) => -0.0524926644, -0.0001337584);

// Tree: 192 
woFDN_FLAPSD_lgt_192 := map(
(NULL < c_unempl and c_unempl <= 193.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5801) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 2.5) => -0.0381766640,
      (f_addrs_per_ssn_i > 2.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 0.0707751213,
         (r_C21_M_Bureau_ADL_FS_d > 8.5) => 0.0041254620,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0050014707, 0.0050014707),
      (f_addrs_per_ssn_i = NULL) => 0.0006146147, 0.0006146147),
   (f_liens_unrel_SC_total_amt_i > 5801) => 0.1136819457,
   (f_liens_unrel_SC_total_amt_i = NULL) => 
      map(
      (NULL < c_highrent and c_highrent <= 5.35) => -0.0611363856,
      (c_highrent > 5.35) => 0.0415554974,
      (c_highrent = NULL) => -0.0084272775, -0.0084272775), 0.0010258671),
(c_unempl > 193.5) => -0.0848263479,
(c_unempl = NULL) => 0.0024410235, 0.0006422475);

// Tree: 193 
woFDN_FLAPSD_lgt_193 := map(
(NULL < c_rnt1500_p and c_rnt1500_p <= 36.55) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -163485.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 58587.5) => 0.1472479213,
      (f_curraddrmedianincome_d > 58587.5) => -0.0107213235,
      (f_curraddrmedianincome_d = NULL) => 0.0546452606, 0.0546452606),
   (f_addrchangevaluediff_d > -163485.5) => 0.0009591960,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 39.35) => -0.0139015595,
      (c_rnt500_p > 39.35) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 158.5) => 0.0120783400,
         (f_curraddrmurderindex_i > 158.5) => 0.1519508469,
         (f_curraddrmurderindex_i = NULL) => 0.0459422101, 0.0459422101),
      (c_rnt500_p = NULL) => -0.0043710642, -0.0043710642), 0.0005031277),
(c_rnt1500_p > 36.55) => -0.0600792214,
(c_rnt1500_p = NULL) => 0.0065261019, -0.0020651602);

// Tree: 194 
woFDN_FLAPSD_lgt_194 := map(
(NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 37) => -0.1361088704,
(f_mos_liens_rel_CJ_lseen_d > 37) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => -0.0024623373,
   (f_phones_per_addr_curr_i > 8.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 21.65) => 0.0136303032,
      (c_hval_500k_p > 21.65) => 
         map(
         (NULL < c_rental and c_rental <= 99.5) => 0.0036278342,
         (c_rental > 99.5) => 0.1941370980,
         (c_rental = NULL) => 0.1134982562, 0.1134982562),
      (c_hval_500k_p = NULL) => 0.0274177708, 0.0274177708),
   (f_phones_per_addr_curr_i = NULL) => 0.0008308747, 0.0008308747),
(f_mos_liens_rel_CJ_lseen_d = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 105) => 0.0588723401,
   (c_many_cars > 105) => -0.0563937748,
   (c_many_cars = NULL) => 0.0002787317, 0.0002787317), 0.0002749986);

// Tree: 195 
woFDN_FLAPSD_lgt_195 := map(
(NULL < C_INC_150K_P and C_INC_150K_P <= 1.35) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1372) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0018780154) => 0.0748876371,
      (f_add_input_nhood_VAC_pct_i > 0.0018780154) => -0.0502109360,
      (f_add_input_nhood_VAC_pct_i = NULL) => -0.0377330732, -0.0377330732),
   (c_popover25 > 1372) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 55.6) => -0.0511425765,
      (c_fammar_p > 55.6) => 
         map(
         (NULL < c_rich_fam and c_rich_fam <= 106.5) => 0.2164117795,
         (c_rich_fam > 106.5) => 0.0141729230,
         (c_rich_fam = NULL) => 0.1038756416, 0.1038756416),
      (c_fammar_p = NULL) => 0.0538970904, 0.0538970904),
   (c_popover25 = NULL) => -0.0253670556, -0.0253670556),
(C_INC_150K_P > 1.35) => 0.0029601278,
(C_INC_150K_P = NULL) => -0.0192394530, -0.0005475069);

// Tree: 196 
woFDN_FLAPSD_lgt_196 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 3.5) => 
   map(
   (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0081905224,
   (f_phones_per_addr_c6_i > 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 65.5) => 
         map(
         (NULL < c_food and c_food <= 55.1) => 0.0014295913,
         (c_food > 55.1) => 0.1282415559,
         (c_food = NULL) => 0.0089179604, 0.0089179604),
      (f_addrchangecrimediff_i > 65.5) => 0.1089236841,
      (f_addrchangecrimediff_i = NULL) => 0.0381445532, 0.0167939109),
   (f_phones_per_addr_c6_i = NULL) => 0.0009409827, 0.0009409827),
(r_C18_invalid_addrs_per_adl_i > 3.5) => -0.0285928925,
(r_C18_invalid_addrs_per_adl_i = NULL) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 8.7) => -0.0458077067,
   (C_INC_15K_P > 8.7) => 0.0616368727,
   (C_INC_15K_P = NULL) => 0.0006302047, 0.0006302047), -0.0048779550);

// Tree: 197 
woFDN_FLAPSD_lgt_197 := map(
(NULL < r_I60_inq_banking_count12_i and r_I60_inq_banking_count12_i <= 4.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 20.35) => -0.0055303986,
   (c_pop_45_54_p > 20.35) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 6.5) => 
         map(
         (NULL < c_pop00 and c_pop00 <= 2756.5) => 0.0117960834,
         (c_pop00 > 2756.5) => 0.2072714862,
         (c_pop00 = NULL) => 0.0249860566, 0.0249860566),
      (f_rel_incomeover100_count_d > 6.5) => 0.1832709751,
      (f_rel_incomeover100_count_d = NULL) => 0.0348037287, 0.0348037287),
   (c_pop_45_54_p = NULL) => -0.0115534937, -0.0005373890),
(r_I60_inq_banking_count12_i > 4.5) => -0.0889196216,
(r_I60_inq_banking_count12_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0918233245,
   (r_S66_adlperssn_count_i > 1.5) => 0.0425866739,
   (r_S66_adlperssn_count_i = NULL) => -0.0258863441, -0.0258863441), -0.0013135774);

// Tree: 198 
woFDN_FLAPSD_lgt_198 := map(
(NULL < r_I60_inq_banking_count12_i and r_I60_inq_banking_count12_i <= 4.5) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 6.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0027063649) => -0.0465471856,
      (f_add_curr_nhood_BUS_pct_i > 0.0027063649) => 0.0087222876,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0028299598, 0.0053801768),
   (f_assoccredbureaucount_i > 6.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 249.5) => 0.1435426509,
      (r_C10_M_Hdr_FS_d > 249.5) => -0.0210231023,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0691303103, 0.0691303103),
   (f_assoccredbureaucount_i = NULL) => 0.0059669127, 0.0059669127),
(r_I60_inq_banking_count12_i > 4.5) => -0.0961397065,
(r_I60_inq_banking_count12_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 5.8) => -0.0320875738,
   (c_hval_250k_p > 5.8) => 0.0707529309,
   (c_hval_250k_p = NULL) => 0.0164759979, 0.0164759979), 0.0054318478);

// Tree: 199 
woFDN_FLAPSD_lgt_199 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 874.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 61.5) => 0.0511036199,
      (r_I60_inq_hiRiskCred_recency_d > 61.5) => -0.0104101090,
      (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0078988233, -0.0078988233),
   (f_rel_criminal_count_i > 6.5) => -0.0542270911,
   (f_rel_criminal_count_i = NULL) => -0.0108970286, -0.0108970286),
(r_pb_order_freq_d > 874.5) => 0.1062405254,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < c_white_col and c_white_col <= 33.35) => -0.0144427232,
   (c_white_col > 33.35) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => 0.0207178554,
      (r_D32_criminal_count_i > 5.5) => 0.1191927987,
      (r_D32_criminal_count_i = NULL) => 0.0085020219, 0.0226903806),
   (c_white_col = NULL) => 0.0440273470, 0.0095323545), -0.0023158265);

// Tree: 200 
woFDN_FLAPSD_lgt_200 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 17538.5) => -0.0857919457,
(r_L80_Inp_AVM_AutoVal_d > 17538.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -129395.5) => 0.1049490420,
   (f_addrchangevaluediff_d > -129395.5) => -0.0052868690,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 34) => -0.1068107462,
      (C_OWNOCC_P > 34) => 
         map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.1144158594,
         (f_corrssnaddrcount_d > 2.5) => 0.0047501496,
         (f_corrssnaddrcount_d = NULL) => 0.0129417993, 0.0129417993),
      (C_OWNOCC_P = NULL) => 0.0042957649, 0.0042957649), -0.0028823097),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_inq_Auto_count_i and f_inq_Auto_count_i <= 4.5) => 0.0013464859,
   (f_inq_Auto_count_i > 4.5) => 0.1615224481,
   (f_inq_Auto_count_i = NULL) => -0.0216770090, 0.0026200435), -0.0009691990);

// Tree: 201 
woFDN_FLAPSD_lgt_201 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0033207492,
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 7137) => 0.1338227089,
   (r_A49_Curr_AVM_Chg_1yr_i > 7137) => 0.0086738441,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < c_assault and c_assault <= 42.5) => -0.0793169265,
      (c_assault > 42.5) => 
         map(
         (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 0.5) => 
            map(
            (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.75) => 0.0619331900,
            (c_pop_45_54_p > 16.75) => 0.2072993811,
            (c_pop_45_54_p = NULL) => 0.0940938517, 0.0940938517),
         (k_inq_adls_per_phone_i > 0.5) => -0.0154241921,
         (k_inq_adls_per_phone_i = NULL) => 0.0418699697, 0.0418699697),
      (c_assault = NULL) => 0.0133427888, 0.0133427888), 0.0228792870),
(f_varrisktype_i = NULL) => -0.0118125286, -0.0019923979);

// Tree: 202 
woFDN_FLAPSD_lgt_202 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 53.5) => -0.0036189808,
   (f_phones_per_addr_curr_i > 53.5) => 
      map(
      (NULL < c_employees and c_employees <= 485.5) => 0.1747552765,
      (c_employees > 485.5) => -0.0155711513,
      (c_employees = NULL) => 0.0754545316, 0.0754545316),
   (f_phones_per_addr_curr_i = NULL) => -0.0026803501, -0.0026803501),
(f_addrchangecrimediff_i > 98.5) => -0.0751125997,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 40.5) => -0.0383262351,
   (c_serv_empl > 40.5) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 12.25) => 0.0158904013,
      (c_pop_6_11_p > 12.25) => 0.1237081122,
      (c_pop_6_11_p = NULL) => 0.0220164076, 0.0220164076),
   (c_serv_empl = NULL) => -0.0028529383, 0.0068013647), -0.0009309423);

// Tree: 203 
woFDN_FLAPSD_lgt_203 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.35) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 145.5) => -0.0075462613,
   (f_prevaddrageoldest_d > 145.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00885226205) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 193.5) => 0.2637227785,
         (r_C13_max_lres_d > 193.5) => 
            map(
            (NULL < c_exp_prod and c_exp_prod <= 87.5) => 0.1872632566,
            (c_exp_prod > 87.5) => -0.0077058320,
            (c_exp_prod = NULL) => 0.0519488892, 0.0519488892),
         (r_C13_max_lres_d = NULL) => 0.0852466705, 0.0852466705),
      (f_add_curr_nhood_MFD_pct_i > 0.00885226205) => 0.0108850760,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0169852767, 0.0198683365),
   (f_prevaddrageoldest_d = NULL) => 0.0040629036, -0.0006737665),
(c_pop_0_5_p > 19.35) => 0.0886913054,
(c_pop_0_5_p = NULL) => 0.0079121040, 0.0000916831);

// Tree: 204 
woFDN_FLAPSD_lgt_204 := map(
(NULL < c_hval_125k_p and c_hval_125k_p <= 43.85) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 14.45) => 0.0015472369,
   (C_INC_25K_P > 14.45) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 5.5) => 
         map(
         (NULL < c_retired and c_retired <= 3.35) => 0.0676231905,
         (c_retired > 3.35) => -0.0284354633,
         (c_retired = NULL) => -0.0200310709, -0.0200310709),
      (k_inq_per_addr_i > 5.5) => -0.0850579864,
      (k_inq_per_addr_i = NULL) => -0.0245426861, -0.0245426861),
   (C_INC_25K_P = NULL) => -0.0021568355, -0.0021568355),
(c_hval_125k_p > 43.85) => 
   map(
   (NULL < c_white_col and c_white_col <= 36.05) => 0.1728557853,
   (c_white_col > 36.05) => 0.0112402379,
   (c_white_col = NULL) => 0.0853758101, 0.0853758101),
(c_hval_125k_p = NULL) => 0.0141338610, -0.0010296821);

// Tree: 205 
woFDN_FLAPSD_lgt_205 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 10.5) => 
   map(
   (NULL < f_srchaddrsrchcountwk_i and f_srchaddrsrchcountwk_i <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0904882012) => 0.0213431812,
      (f_add_curr_nhood_MFD_pct_i > 0.0904882012) => -0.0037028268,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0158164834, 0.0016955094),
   (f_srchaddrsrchcountwk_i > 0.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 139.5) => 
         map(
         (NULL < C_INC_100K_P and C_INC_100K_P <= 14.05) => 0.0311870318,
         (C_INC_100K_P > 14.05) => 0.2059093391,
         (C_INC_100K_P = NULL) => 0.1112125161, 0.1112125161),
      (c_new_homes > 139.5) => -0.0450568082,
      (c_new_homes = NULL) => 0.0524254846, 0.0524254846),
   (f_srchaddrsrchcountwk_i = NULL) => 0.0272455324, 0.0027559575),
(k_inq_per_phone_i > 10.5) => -0.0760508543,
(k_inq_per_phone_i = NULL) => 0.0023707764, 0.0023707764);

// Tree: 206 
woFDN_FLAPSD_lgt_206 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -168409) => -0.0627756914,
(f_addrchangevaluediff_d > -168409) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 18.5) => 0.0005404933,
   (k_inq_per_addr_i > 18.5) => 0.0997099819,
   (k_inq_per_addr_i = NULL) => 0.0010809265, 0.0010809265),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 1049.15) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 16) => -0.0811125785,
      (r_F01_inp_addr_address_score_d > 16) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 28.85) => -0.0062744187,
         (C_INC_75K_P > 28.85) => 0.0923889129,
         (C_INC_75K_P = NULL) => -0.0020506767, -0.0020506767),
      (r_F01_inp_addr_address_score_d = NULL) => -0.0155689699, -0.0063487871),
   (c_oldhouse > 1049.15) => 0.1530630807,
   (c_oldhouse = NULL) => -0.0059886426, -0.0036553654), -0.0007544107);

// Tree: 207 
woFDN_FLAPSD_lgt_207 := map(
(NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 3.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 17.15) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 127.2) => 0.0222771608,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 127.2) => 0.1388515789,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 6.5) => -0.0090699681,
         (f_rel_homeover300_count_d > 6.5) => 0.1069395988,
         (f_rel_homeover300_count_d = NULL) => 0.0146518761, 0.0146518761), 0.0305383596),
   (c_hh2_p > 17.15) => -0.0050347595,
   (c_hh2_p = NULL) => 0.0011478445, -0.0027902654),
(f_hh_workers_paw_d > 3.5) => -0.0749046645,
(f_hh_workers_paw_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 104.5) => -0.0511569551,
   (c_no_teens > 104.5) => 0.0619964527,
   (c_no_teens = NULL) => 0.0064484161, 0.0064484161), -0.0043274664);

// Tree: 208 
woFDN_FLAPSD_lgt_208 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 15.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -22.5) => -0.0448372320,
   (f_addrchangecrimediff_i > -22.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => -0.0059800299,
      (r_C23_inp_addr_occ_index_d > 2) => 
         map(
         (NULL < C_INC_201K_P and C_INC_201K_P <= 6.25) => 
            map(
            (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 12.5) => 0.0446763994,
            (f_rel_homeover200_count_d > 12.5) => 0.1338196590,
            (f_rel_homeover200_count_d = NULL) => 0.0526131500, 0.0526131500),
         (C_INC_201K_P > 6.25) => -0.0277539094,
         (C_INC_201K_P = NULL) => 0.0273058238, 0.0273058238),
      (r_C23_inp_addr_occ_index_d = NULL) => -0.0011552712, -0.0011552712),
   (f_addrchangecrimediff_i = NULL) => 0.0018096046, -0.0017532597),
(k_inq_per_ssn_i > 15.5) => 0.0871632170,
(k_inq_per_ssn_i = NULL) => -0.0012695989, -0.0012695989);

// Tree: 209 
woFDN_FLAPSD_lgt_209 := map(
(NULL < k_inq_lnames_per_addr_i and k_inq_lnames_per_addr_i <= 4.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 34.5) => 
      map(
      (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 0.0017818806,
      (k_inq_addrs_per_ssn_i > 2.5) => 0.0686470080,
      (k_inq_addrs_per_ssn_i = NULL) => 0.0021957865, 0.0021957865),
   (f_rel_homeover100_count_d > 34.5) => -0.0951791276,
   (f_rel_homeover100_count_d = NULL) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 20.85) => 0.0671182259,
      (C_RENTOCC_P > 20.85) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => 0.0050784031,
         (f_phones_per_addr_curr_i > 4.5) => -0.0991445562,
         (f_phones_per_addr_curr_i = NULL) => -0.0242484036, -0.0242484036),
      (C_RENTOCC_P = NULL) => 0.0021776369, 0.0021776369), 0.0013197905),
(k_inq_lnames_per_addr_i > 4.5) => -0.0723962663,
(k_inq_lnames_per_addr_i = NULL) => 0.0006398710, 0.0006398710);

// Tree: 210 
woFDN_FLAPSD_lgt_210 := map(
(NULL < c_lar_fam and c_lar_fam <= 173.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 5.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 20.35) => -0.0042529086,
      (c_hh3_p > 20.35) => 
         map(
         (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 1.5) => 0.0174472665,
         (k_inq_addrs_per_ssn_i > 1.5) => 0.1544501898,
         (k_inq_addrs_per_ssn_i = NULL) => 0.0211764453, 0.0211764453),
      (c_hh3_p = NULL) => 0.0025455828, 0.0025455828),
   (r_I60_Inq_Count12_i > 5.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 174.5) => -0.0746562635,
      (c_bargains > 174.5) => 0.0556278740,
      (c_bargains = NULL) => -0.0541043995, -0.0541043995),
   (r_I60_Inq_Count12_i = NULL) => 0.0169157339, 0.0009971399),
(c_lar_fam > 173.5) => -0.0549812807,
(c_lar_fam = NULL) => 0.0099679137, -0.0004464391);

// Tree: 211 
woFDN_FLAPSD_lgt_211 := map(
(NULL < c_food and c_food <= 40.75) => -0.0045031873,
(c_food > 40.75) => 
   map(
   (NULL < c_families and c_families <= 635.5) => 
      map(
      (NULL < c_assault and c_assault <= 168.5) => 
         map(
         (NULL < c_young and c_young <= 29.65) => 0.0270654534,
         (c_young > 29.65) => -0.0537947914,
         (c_young = NULL) => 0.0089458559, 0.0089458559),
      (c_assault > 168.5) => 
         map(
         (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.2485873332,
         (f_hh_age_18_plus_d > 1.5) => 0.0302455381,
         (f_hh_age_18_plus_d = NULL) => 0.1017925670, 0.1017925670),
      (c_assault = NULL) => 0.0200924429, 0.0200924429),
   (c_families > 635.5) => 0.2042721375,
   (c_families = NULL) => 0.0299153600, 0.0299153600),
(c_food = NULL) => -0.0107632201, -0.0003683712);

// Tree: 212 
woFDN_FLAPSD_lgt_212 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 764602.5) => 
   map(
   (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 2107) => -0.0157625518,
      (c_hh00 > 2107) => 0.1968985090,
      (c_hh00 = NULL) => -0.0038989418, -0.0122311517),
   (f_util_add_input_misc_n > 0.5) => 0.0101322111,
   (f_util_add_input_misc_n = NULL) => -0.0015671997, -0.0015671997),
(f_curraddrmedianvalue_d > 764602.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 98.5) => 0.1899927458,
   (c_medi_indx > 98.5) => 0.0162545149,
   (c_medi_indx = NULL) => 0.0625013821, 0.0625013821),
(f_curraddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 76) => -0.0317982693,
   (c_assault > 76) => 0.0594046858,
   (c_assault = NULL) => 0.0166280786, 0.0166280786), 0.0000133959);

// Tree: 213 
woFDN_FLAPSD_lgt_213 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00140944395) => 0.1156076101,
(f_add_curr_nhood_MFD_pct_i > 0.00140944395) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0865221563,
   (f_attr_arrest_recency_d > 79.5) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 27693.5) => -0.0422531643,
      (c_med_hhinc > 27693.5) => 
         map(
         (NULL < c_unempl and c_unempl <= 175.5) => -0.0013912264,
         (c_unempl > 175.5) => 
            map(
            (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => -0.0205042997,
            (f_util_add_input_conv_n > 0.5) => 0.0903151300,
            (f_util_add_input_conv_n = NULL) => 0.0434739277, 0.0434739277),
         (c_unempl = NULL) => 0.0004634167, 0.0004634167),
      (c_med_hhinc = NULL) => -0.0174826252, -0.0017653543),
   (f_attr_arrest_recency_d = NULL) => -0.0011129401, -0.0011129401),
(f_add_curr_nhood_MFD_pct_i = NULL) => -0.0088383744, -0.0016114302);

// Tree: 214 
woFDN_FLAPSD_lgt_214 := map(
(NULL < f_hh_age_30_plus_d and f_hh_age_30_plus_d <= 7.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 8.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0060589186,
         (k_inq_per_phone_i > 2.5) => 0.1180060388,
         (k_inq_per_phone_i = NULL) => -0.0053136699, -0.0053136699),
      (f_srchphonesrchcount_i > 1.5) => 0.0200117150,
      (f_srchphonesrchcount_i = NULL) => -0.0000613911, -0.0000613911),
   (f_srchfraudsrchcountyr_i > 8.5) => -0.0589680371,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0004439324, -0.0004439324),
(f_hh_age_30_plus_d > 7.5) => -0.0792766493,
(f_hh_age_30_plus_d = NULL) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 26.55) => 0.0390983418,
   (c_hh1_p > 26.55) => -0.0675379749,
   (c_hh1_p = NULL) => -0.0123155966, -0.0123155966), -0.0011543790);

// Tree: 215 
woFDN_FLAPSD_lgt_215 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 135.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 13.55) => -0.0464809871,
      (c_pop_55_64_p > 13.55) => 0.0294423345,
      (c_pop_55_64_p = NULL) => -0.0315719520, -0.0315719520),
   (r_F01_inp_addr_address_score_d > 75) => -0.0067845923,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0085344474, -0.0085344474),
(f_prevaddrageoldest_d > 135.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < c_unattach and c_unattach <= 113.5) => -0.0089048755,
      (c_unattach > 113.5) => 0.1165062238,
      (c_unattach = NULL) => 0.0456216894, 0.0456216894),
   (r_F01_inp_addr_address_score_d > 25) => 0.0140770372,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0151788316, 0.0151788316),
(f_prevaddrageoldest_d = NULL) => -0.0195995559, -0.0022516505);

// Tree: 216 
woFDN_FLAPSD_lgt_216 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 57.35) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 225.5) => -0.0668049611,
   (f_mos_liens_unrel_FT_lseen_d > 225.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -4902.5) => 
         map(
         (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 169.5) => -0.0194223661,
         (r_P88_Phn_Dst_to_Inp_Add_i > 169.5) => 0.1885562956,
         (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => -0.0308667303, -0.0165653433),
      (r_A49_Curr_AVM_Chg_1yr_i > -4902.5) => 0.0134634870,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0082545777, -0.0022136083),
   (f_mos_liens_unrel_FT_lseen_d = NULL) => 
      map(
      (NULL < c_retired and c_retired <= 10.1) => 0.0482295571,
      (c_retired > 10.1) => -0.0536161804,
      (c_retired = NULL) => -0.0040696054, -0.0040696054), -0.0031144632),
(c_hval_500k_p > 57.35) => 0.1030022165,
(c_hval_500k_p = NULL) => -0.0004919026, -0.0026282789);

// Tree: 217 
woFDN_FLAPSD_lgt_217 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 46.5) => -0.0816444500,
(f_mos_inq_banko_am_fseen_d > 46.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => -0.0023291066,
      (f_inq_PrepaidCards_count24_i > 0.5) => 0.0453026110,
      (f_inq_PrepaidCards_count24_i = NULL) => -0.0016534514, -0.0016534514),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3559299691) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.03498022745) => 0.0190336917,
         (f_add_input_nhood_BUS_pct_i > 0.03498022745) => 0.1004089203,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0608620802, 0.0608620802),
      (f_add_input_mobility_index_i > 0.3559299691) => -0.0323793645,
      (f_add_input_mobility_index_i = NULL) => 0.0290870627, 0.0290870627),
   (k_nap_contradictory_i = NULL) => -0.0011987249, -0.0011987249),
(f_mos_inq_banko_am_fseen_d = NULL) => -0.0216896087, -0.0035168320);

// Tree: 218 
woFDN_FLAPSD_lgt_218 := map(
(NULL < f_mos_liens_unrel_OT_lseen_d and f_mos_liens_unrel_OT_lseen_d <= 28.5) => -0.0819454373,
(f_mos_liens_unrel_OT_lseen_d > 28.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 17.75) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 13.55) => -0.0304923185,
         (C_INC_25K_P > 13.55) => 0.0889595139,
         (C_INC_25K_P = NULL) => -0.0018911755, -0.0018911755),
      (c_pop_45_54_p > 17.75) => 0.1192003859,
      (c_pop_45_54_p = NULL) => 0.0287003768, 0.0287003768),
   (r_F00_dob_score_d > 92) => -0.0003658694,
   (r_F00_dob_score_d = NULL) => -0.0145182325, 0.0001219235),
(f_mos_liens_unrel_OT_lseen_d = NULL) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 5.35) => 0.0487330096,
   (c_hval_750k_p > 5.35) => -0.0785715151,
   (c_hval_750k_p = NULL) => -0.0044844556, -0.0044844556), -0.0005628733);

// Tree: 219 
woFDN_FLAPSD_lgt_219 := map(
(NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => -0.0076179709,
(f_inq_Collection_count_i > 3.5) => 
   map(
   (NULL < c_murders and c_murders <= 17) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 0.5) => 0.0327992345,
      (k_inq_adls_per_phone_i > 0.5) => 0.2051044287,
      (k_inq_adls_per_phone_i = NULL) => 0.0827985096, 0.0827985096),
   (c_murders > 17) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 425) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 64.75) => 0.0175024345,
         (c_civ_emp > 64.75) => 0.1452823749,
         (c_civ_emp = NULL) => 0.0531996877, 0.0531996877),
      (c_hh00 > 425) => -0.0099890875,
      (c_hh00 = NULL) => 0.0042385495, 0.0042385495),
   (c_murders = NULL) => 0.0150810825, 0.0150810825),
(f_inq_Collection_count_i = NULL) => -0.0416976726, -0.0049609166);

// Tree: 220 
woFDN_FLAPSD_lgt_220 := map(
(NULL < c_info and c_info <= 26.65) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 8.5) => 
      map(
      (NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 555.5) => -0.0001226714,
      (f_liens_unrel_O_total_amt_i > 555.5) => -0.0641831989,
      (f_liens_unrel_O_total_amt_i = NULL) => -0.0012322894, -0.0012322894),
   (f_inq_HighRiskCredit_count_i > 8.5) => 
      map(
      (NULL < c_medi_indx and c_medi_indx <= 104.5) => 
         map(
         (NULL < c_rape and c_rape <= 95.5) => 0.0753359719,
         (c_rape > 95.5) => -0.0719511277,
         (c_rape = NULL) => 0.0064218244, 0.0064218244),
      (c_medi_indx > 104.5) => -0.1160249453,
      (c_medi_indx = NULL) => -0.0379740804, -0.0379740804),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0129040860, -0.0018352688),
(c_info > 26.65) => 0.1657579433,
(c_info = NULL) => -0.0170854840, -0.0012026125);

// Tree: 221 
woFDN_FLAPSD_lgt_221 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 6.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 3.5) => -0.0014416155,
   (r_E57_br_source_count_d > 3.5) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 97.55) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 168.5) => 0.0091576467,
         (c_serv_empl > 168.5) => 0.1420088453,
         (c_serv_empl = NULL) => 0.0243013066, 0.0243013066),
      (c_occunit_p > 97.55) => 0.3103118418,
      (c_occunit_p = NULL) => 0.0470366433, 0.0470366433),
   (r_E57_br_source_count_d = NULL) => 0.0009975909, 0.0009975909),
(f_divaddrsuspidcountnew_i > 6.5) => 0.0951968798,
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.95) => 0.0395672303,
   (c_pop_65_74_p > 4.95) => -0.0505141519,
   (c_pop_65_74_p = NULL) => -0.0099369527, -0.0099369527), 0.0012789121);

// Tree: 222 
woFDN_FLAPSD_lgt_222 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 70.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 169.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 28.65) => 0.0353840416,
         (c_hval_250k_p > 28.65) => 0.1592390931,
         (c_hval_250k_p = NULL) => 0.0480983655, 0.0480983655),
      (f_M_Bureau_ADL_FS_all_d > 169.5) => 0.0015497196,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0128499905, 0.0128499905),
   (f_mos_inq_banko_cm_fseen_d > 70.5) => -0.0091760802,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0093870144, -0.0047465165),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 7.25) => -0.0207630530,
   (c_pop_12_17_p > 7.25) => 0.1639200918,
   (c_pop_12_17_p = NULL) => 0.0849521264, 0.0849521264),
(f_nae_nothing_found_i = NULL) => -0.0037141159, -0.0037141159);

// Tree: 223 
woFDN_FLAPSD_lgt_223 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0012656627,
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 0.1607530401,
   (f_corrssnnamecount_d > 1.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 3.5) => 
         map(
         (NULL < c_child and c_child <= 32.55) => 
            map(
            (NULL < c_sfdu_p and c_sfdu_p <= 97.1) => 0.0404724074,
            (c_sfdu_p > 97.1) => -0.0695528043,
            (c_sfdu_p = NULL) => 0.0230679768, 0.0230679768),
         (c_child > 32.55) => 0.1236330867,
         (c_child = NULL) => 0.0322653889, 0.0322653889),
      (k_inq_per_phone_i > 3.5) => -0.0646143003,
      (k_inq_per_phone_i = NULL) => 0.0252555412, 0.0252555412),
   (f_corrssnnamecount_d = NULL) => 0.0316051146, 0.0316051146),
(f_hh_payday_loan_users_i = NULL) => -0.0068844944, 0.0016146134);

// Tree: 224 
woFDN_FLAPSD_lgt_224 := map(
(NULL < r_D31_bk_dism_hist_count_i and r_D31_bk_dism_hist_count_i <= 0.5) => 
   map(
   (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 0.0016353249,
   (r_D34_unrel_liens_ct_i > 0.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.35) => -0.0153668662,
      (c_unemp > 9.35) => -0.1087483976,
      (c_unemp = NULL) => -0.0208020761, -0.0208020761),
   (r_D34_unrel_liens_ct_i = NULL) => -0.0012984357, -0.0012984357),
(r_D31_bk_dism_hist_count_i > 0.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 14.55) => 0.1681206050,
   (C_INC_100K_P > 14.55) => -0.0355045029,
   (C_INC_100K_P = NULL) => 0.0686396362, 0.0686396362),
(r_D31_bk_dism_hist_count_i = NULL) => 
   map(
   (NULL < C_INC_201K_P and C_INC_201K_P <= 3.25) => 0.0383967916,
   (C_INC_201K_P > 3.25) => -0.0602599946,
   (C_INC_201K_P = NULL) => -0.0113532117, -0.0113532117), -0.0006508237);

// Tree: 225 
woFDN_FLAPSD_lgt_225 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 4.5) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 9) => 
            map(
            (NULL < C_INC_200K_P and C_INC_200K_P <= 4.65) => 0.1260112803,
            (C_INC_200K_P > 4.65) => 0.0159337399,
            (C_INC_200K_P = NULL) => 0.0752798921, 0.0752798921),
         (r_I60_inq_recency_d > 9) => 0.0225227883,
         (r_I60_inq_recency_d = NULL) => 0.0322067448, 0.0322067448),
      (f_inq_Collection_count_i > 4.5) => -0.0427603462,
      (f_inq_Collection_count_i = NULL) => 0.0232625836, 0.0232625836),
   (f_phone_ver_experian_d > 0.5) => -0.0240061179,
   (f_phone_ver_experian_d = NULL) => 0.0034488169, 0.0065698838),
(k_nap_phn_verd_d > 0.5) => -0.0086226309,
(k_nap_phn_verd_d = NULL) => -0.0030091255, -0.0030091255);

// Tree: 226 
woFDN_FLAPSD_lgt_226 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 0.0012442516,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 5.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0551570912) => 
         map(
         (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 0.5) => 0.0619397508,
         (k_inq_per_addr_i > 0.5) => 
            map(
            (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity','6: Other']) => 0.1086448228,
            (nf_seg_FraudPoint_3_0 in ['2: Synth ID','5: Vuln Vic/Friendly']) => 0.3668599034,
            (nf_seg_FraudPoint_3_0 = '') => 0.2071009327, 0.2071009327),
         (k_inq_per_addr_i = NULL) => 0.1202559482, 0.1202559482),
      (f_add_curr_nhood_BUS_pct_i > 0.0551570912) => -0.0119753020,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0758404611, 0.0758404611),
   (r_A50_pb_total_orders_d > 5.5) => -0.0185994772,
   (r_A50_pb_total_orders_d = NULL) => 0.0405587234, 0.0405587234),
(k_comb_age_d = NULL) => 0.0039964196, 0.0039964196);

//Adjustment trees FA: 6/2019

adj_FLAPSD_tree_0 :=  0.0845161317233255;

// Tree: 1
adj_FLAPSD_tree_1 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d < 25) => map(
   (NULL < c_high_ed and c_high_ed < 29.05) => map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d < 3.5) => map(
         (NULL < c_med_hval and c_med_hval < 140822.5) => map(
            (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i < 4.5) => 0.143460187368441, 
            (f_componentcharrisktype_i >= 4.5) => map(
               (NULL < c_pop_12_17_p and c_pop_12_17_p < 7.55) => -0.080940847038477, 
               (c_pop_12_17_p >= 7.55) => 0.0880356395930539, 
               (c_pop_12_17_p = NULL) => 0.0163486452645256, 0.0163486452645256), 
            (f_componentcharrisktype_i = NULL) => 0.0714484982795274, 0.0714484982795274), 
         (c_med_hval >= 140822.5) => map(
            (NULL < c_oldhouse and c_oldhouse < 165.05) => -0.0742873748019058, 
            (c_oldhouse >= 165.05) => 0.0752601198236653, 
            (c_oldhouse = NULL) => -0.0234976596460515, -0.0234976596460515), 
         (c_med_hval = NULL) => 0.0329371740188972, 0.0329371740188972), 
      (f_rel_homeover300_count_d >= 3.5) => 0.130103903551989, 
      (f_rel_homeover300_count_d = NULL) => 0.0564300970201283, 0.0564300970201283), 
   (c_high_ed >= 29.05) => -0.0151204296293473, 
   (c_high_ed = NULL) => 0.0258117803393829, 0.0247308024103101), 
(r_F01_inp_addr_address_score_d >= 25) => -0.00138089530078971, 
(r_F01_inp_addr_address_score_d = NULL) => -0.00826104562303358, -4.32282830829457e-05);

// Tree: 2
adj_FLAPSD_tree_2 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 79.5) => map(
   (NULL < c_bel_edu and c_bel_edu < 99.5) => -0.0313528661692686, 
   (c_bel_edu >= 99.5) => 0.155495951764267, 
   (c_bel_edu = NULL) => 0.0739349598091523, 0.0739349598091523), 
(f_attr_arrest_recency_d >= 79.5) => map(
   (NULL < c_many_cars and c_many_cars < 22.5) => map(
      (NULL < C_INC_35K_P and C_INC_35K_P < 12.95) => 0.00906820196530072, 
      (C_INC_35K_P >= 12.95) => map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i < 4.5) => -0.0193230033473217, 
         (f_corrrisktype_i >= 4.5) => map(
            (NULL < k_comb_age_d and k_comb_age_d < 32.5) => 0.0570998901609317, 
            (k_comb_age_d >= 32.5) => 0.193435172565307, 
            (k_comb_age_d = NULL) => 0.119794217106009, 0.119794217106009), 
         (f_corrrisktype_i = NULL) => 0.0667224106576732, 0.0667224106576732), 
      (C_INC_35K_P = NULL) => 0.0249419213255997, 0.0249419213255997), 
   (c_many_cars >= 22.5) => -0.00696675943705075, 
   (c_many_cars = NULL) => -0.0218512424236281, -0.00458099768102574), 
(f_attr_arrest_recency_d = NULL) => map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i < 3.5) => -0.0782598734044957, 
   (f_addrs_per_ssn_i >= 3.5) => 0.047490156458184, 
   (f_addrs_per_ssn_i = NULL) => -0.0150128169646864, -0.0150128169646864), -0.00414958184341004);

// Tree: 3
adj_FLAPSD_tree_3 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i < 0.5) => map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d < 25) => map(
      (NULL < c_high_ed and c_high_ed < 41.15) => map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d < 0.5) => map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d < 125.5) => 0.0616325111080753, 
            (r_C13_max_lres_d >= 125.5) => 0.229158152326407, 
            (r_C13_max_lres_d = NULL) => 0.133627001549011, 0.133627001549011), 
         (f_rel_under25miles_cnt_d >= 0.5) => map(
            (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i < 0.3039405685) => 0.0171815397453632, 
            (f_add_input_nhood_MFD_pct_i >= 0.3039405685) => 0.0805652743590173, 
            (f_add_input_nhood_MFD_pct_i = NULL) => -0.0647921953567423, 0.0295829220378264), 
         (f_rel_under25miles_cnt_d = NULL) => 0.0480423554994883, 0.0480423554994883), 
      (c_high_ed >= 41.15) => -0.0506523574640201, 
      (c_high_ed = NULL) => -0.0361185478321935, 0.0174593655992676), 
   (r_F01_inp_addr_address_score_d >= 25) => -0.00180842052185846, 
   (r_F01_inp_addr_address_score_d = NULL) => map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p < 2) => -0.11272083472321, 
      (c_pop_75_84_p >= 2) => 0.0319959743615525, 
      (c_pop_75_84_p = NULL) => -0.0222728290452332, -0.0222728290452332), -0.000939321881030501), 
(r_S65_SSN_Prior_DoB_i >= 0.5) => 0.104702421448161, 
(r_S65_SSN_Prior_DoB_i = NULL) => -0.000567285255377105, -0.000567285255377105);

// Tree: 4
adj_FLAPSD_tree_4 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i < 4.5) => map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d < 1.5) => map(
      (NULL < c_med_inc and c_med_inc < 70.5) => map(
         (NULL < c_unempl and c_unempl < 71.5) => -0.0299195809774553, 
         (c_unempl >= 71.5) => map(
            (NULL < c_pop_12_17_p and c_pop_12_17_p < 8.25) => map(
               (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i < 0.5) => 0.10880906959659, 
               (f_crim_rel_under100miles_cnt_i >= 0.5) => 0.230258231313104, 
               (f_crim_rel_under100miles_cnt_i = NULL) => 0.164189887339321, 0.164189887339321), 
            (c_pop_12_17_p >= 8.25) => 0.0499674190830086, 
            (c_pop_12_17_p = NULL) => 0.114031325191984, 0.114031325191984), 
         (c_unempl = NULL) => 0.0874871864657041, 0.0874871864657041), 
      (c_med_inc >= 70.5) => map(
         (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i < 3.5) => 0.0785748561446113, 
         (f_componentcharrisktype_i >= 3.5) => -0.0224405865006719, 
         (f_componentcharrisktype_i = NULL) => 0.00749706858540628, 0.00749706858540628), 
      (c_med_inc = NULL) => -0.0430304281522038, 0.0266849501455031), 
   (f_corrssnaddrcount_d >= 1.5) => 0.00111134060944077, 
   (f_corrssnaddrcount_d = NULL) => -0.0115236263204282, 0.00222211966194145), 
(k_inq_adls_per_phone_i >= 4.5) => -0.121015633491716, 
(k_inq_adls_per_phone_i = NULL) => 0.00185940803233065, 0.00185940803233065);

// Tree: 5
adj_FLAPSD_tree_5 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i < 6.5) => -0.0110650876835226, 
(f_corrrisktype_i >= 6.5) => map(
   (NULL < c_employees and c_employees < 18.5) => map(
      (NULL < c_hh1_p and c_hh1_p < 28.9) => 0.0385925775810537, 
      (c_hh1_p >= 28.9) => 0.169219832243144, 
      (c_hh1_p = NULL) => 0.0898718717665851, 0.0898718717665851), 
   (c_employees >= 18.5) => map(
      (NULL < r_L70_Add_Invalid_i and r_L70_Add_Invalid_i < 0.5) => map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d < 227282) => map(
            (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d < -4256.5) => 0.132847858546778, 
            (f_addrchangeincomediff_d >= -4256.5) => 0.0230512512171439, 
            (f_addrchangeincomediff_d = NULL) => 0.0548954569204574, 0.0371541522277165), 
         (r_L80_Inp_AVM_AutoVal_d >= 227282) => -0.037861601938959, 
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0199072300010132, 0.0132994723982223), 
      (r_L70_Add_Invalid_i >= 0.5) => -0.0699320246135618, 
      (r_L70_Add_Invalid_i = NULL) => 0.00774892690978013, 0.00774892690978013), 
   (c_employees = NULL) => 0.00232525806236524, 0.0126736295049259), 
(f_corrrisktype_i = NULL) => map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i < 4.5) => -0.0939032745040185, 
   (f_addrs_per_ssn_i >= 4.5) => 0.0464358926476241, 
   (f_addrs_per_ssn_i = NULL) => -0.0329665308723842, -0.0329665308723842), -0.00664626509860851);

// Tree: 6
adj_FLAPSD_tree_6 := map(
(NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i < 30) => map(
   (NULL < c_exp_prod and c_exp_prod < 23.5) => map(
      (NULL < c_high_ed and c_high_ed < 6.85) => map(
         (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d < 0.5) => map(
            (NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d < 0.5) => 0.211166737718513, 
            (r_A41_Prop_Owner_d >= 0.5) => 0.0749565472778293, 
            (r_A41_Prop_Owner_d = NULL) => 0.134086552430374, 0.134086552430374), 
         (k_nap_phn_verd_d >= 0.5) => 0.0198333426530066, 
         (k_nap_phn_verd_d = NULL) => 0.086223721307423, 0.086223721307423), 
      (c_high_ed >= 6.85) => map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i < 0.24873080995) => 0.0623217815388056, 
         (f_add_curr_nhood_MFD_pct_i >= 0.24873080995) => -0.0417657134928376, 
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.119325525595646, 0.019345925498758), 
      (c_high_ed = NULL) => 0.0377207654362873, 0.0377207654362873), 
   (c_exp_prod >= 23.5) => -0.00139138226286696, 
   (c_exp_prod = NULL) => -0.0103637231348564, 7.37533780664549e-05), 
(r_C12_NonDerog_Recency_i >= 30) => 0.134917172672994, 
(r_C12_NonDerog_Recency_i = NULL) => map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i < 0.5) => -0.0858650421689882, 
   (k_inf_nothing_found_i >= 0.5) => 0.0143319356019682, 
   (k_inf_nothing_found_i = NULL) => -0.0342106995914144, -0.0342106995914144), 0.000152171461592488);

// Tree: 7
adj_FLAPSD_tree_7 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d < 30) => map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d < 6.5) => 0.00964865706839783, 
   (f_rel_incomeover50_count_d >= 6.5) => 0.130010268130619, 
   (f_rel_incomeover50_count_d = NULL) => 0.0690772025303693, 0.0690772025303693), 
(r_D33_Eviction_Recency_d >= 30) => map(
   (NULL < f_liens_unrel_OT_total_amt_i and f_liens_unrel_OT_total_amt_i < 327.5) => map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i < 4.5) => map(
         (NULL < c_hh5_p and c_hh5_p < 29.8) => map(
            (NULL < r_F00_dob_score_d and r_F00_dob_score_d < 95) => 0.041500653785493, 
            (r_F00_dob_score_d >= 95) => -0.00209887832910389, 
            (r_F00_dob_score_d = NULL) => 0.00819227531320194, -0.000488301531294258), 
         (c_hh5_p >= 29.8) => 0.143778601472655, 
         (c_hh5_p = NULL) => -0.0112215674672887, -0.000194986240398961), 
      (k_inq_adls_per_phone_i >= 4.5) => -0.10551504436842, 
      (k_inq_adls_per_phone_i = NULL) => -0.000513891943825584, -0.000513891943825584), 
   (f_liens_unrel_OT_total_amt_i >= 327.5) => -0.0586403781957161, 
   (f_liens_unrel_OT_total_amt_i = NULL) => -0.0022192006037031, -0.0022192006037031), 
(r_D33_Eviction_Recency_d = NULL) => map(
   (NULL < c_robbery and c_robbery < 138) => 0.0389773472318306, 
   (c_robbery >= 138) => -0.112678716949349, 
   (c_robbery = NULL) => -0.0149674272755689, -0.0149674272755689), -0.00171842579822719);

// Tree: 8
adj_FLAPSD_tree_8 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d < 26.5) => 0.110923420523317, 
(f_mos_liens_unrel_SC_fseen_d >= 26.5) => map(
   (NULL < c_cartheft and c_cartheft < 135.5) => -0.00921618335218774, 
   (c_cartheft >= 135.5) => map(
      (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i < 1.5) => map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d < 0.5) => map(
            (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d < 42.5) => 0.136481033067255, 
            (r_C21_M_Bureau_ADL_FS_d >= 42.5) => map(
               (NULL < c_robbery and c_robbery < 152.5) => 0.0632033578258438, 
               (c_robbery >= 152.5) => -0.000896630914459704, 
               (c_robbery = NULL) => 0.0292374597331959, 0.0292374597331959), 
            (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0380957643687783, 0.0380957643687783), 
         (f_phone_ver_experian_d >= 0.5) => -0.0005260925873436, 
         (f_phone_ver_experian_d = NULL) => 0.00900785569661051, 0.0146553302244216), 
      (r_I60_inq_comm_count12_i >= 1.5) => -0.0980470965030437, 
      (r_I60_inq_comm_count12_i = NULL) => 0.0123181264394163, 0.0123181264394163), 
   (c_cartheft = NULL) => -0.00436761582690621, -0.00384819673620094), 
(f_mos_liens_unrel_SC_fseen_d = NULL) => map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p < 13.45) => -0.0901385520195225, 
   (c_pop_35_44_p >= 13.45) => 0.0128764933393086, 
   (c_pop_35_44_p = NULL) => -0.0315487449716873, -0.0315487449716873), -0.00369903328474459);

// Tree: 9
adj_FLAPSD_tree_9 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i < 0.5) => map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i < 4.5) => -0.000641854111088901, 
   (f_inq_HighRiskCredit_count_i >= 4.5) => map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i < 0.0328061229) => map(
         (NULL < c_hh6_p and c_hh6_p < 3.25) => map(
            (NULL < f_historical_count_d and f_historical_count_d < 0.5) => 0.193140691466992, 
            (f_historical_count_d >= 0.5) => 0.0749898882487515, 
            (f_historical_count_d = NULL) => 0.119887193471683, 0.119887193471683), 
         (c_hh6_p >= 3.25) => 0.0048546363564613, 
         (c_hh6_p = NULL) => 0.086631335727472, 0.086631335727472), 
      (f_add_curr_nhood_VAC_pct_i >= 0.0328061229) => map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i < 21.5) => 0.0308723676451743, 
         (f_srchfraudsrchcount_i >= 21.5) => -0.117355040311521, 
         (f_srchfraudsrchcount_i = NULL) => -0.0207574036655846, -0.0207574036655846), 
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0376180136455128, 0.0376180136455128), 
   (f_inq_HighRiskCredit_count_i = NULL) => map(
      (NULL < c_hh3_p and c_hh3_p < 12.55) => -0.111689457384435, 
      (c_hh3_p >= 12.55) => 0.00943865852809815, 
      (c_hh3_p = NULL) => -0.0356711225703625, -0.0356711225703625), -0.000131832049456336), 
(r_S65_SSN_Prior_DoB_i >= 0.5) => 0.113810620524738, 
(r_S65_SSN_Prior_DoB_i = NULL) => 0.000293393397732509, 0.000293393397732509);

// Tree: 10
adj_FLAPSD_tree_10 := map(
(NULL < C_INC_125K_P and C_INC_125K_P < 6.95) => map(
   (NULL < r_D31_bk_chapter_n and r_D31_bk_chapter_n < 9) => -0.0252443881348831, 
   (r_D31_bk_chapter_n >= 9) => -0.0496942960142164, 
   (r_D31_bk_chapter_n = NULL) => map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d < 21939) => 0.0922359016772541, 
      (r_A46_Curr_AVM_AutoVal_d >= 21939) => map(
         (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d < 95) => map(
            (NULL < c_unemp and c_unemp < 6.45) => 0.019281277736475, 
            (c_unemp >= 6.45) => 0.147736430149759, 
            (c_unemp = NULL) => 0.0628253971986051, 0.0628253971986051), 
         (r_F01_inp_addr_address_score_d >= 95) => 0.0112476379061229, 
         (r_F01_inp_addr_address_score_d = NULL) => 0.0172115532383257, 0.0172115532383257), 
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0192766626644428, 0.0197580225769194), 0.0138459261213571), 
(C_INC_125K_P >= 6.95) => map(
   (NULL < c_robbery and c_robbery < 191.5) => -0.0111976409172551, 
   (c_robbery >= 191.5) => map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 0.0370216584092421, 
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 0.222152344144767, 
      (nf_seg_FraudPoint_3_0 = '') => 0.0953780702171794, 0.0953780702171794), 
   (c_robbery = NULL) => -0.00969496422386535, -0.00969496422386535), 
(C_INC_125K_P = NULL) => 0.0179251381683787, -0.0022052436521421);

// Tree: 11
adj_FLAPSD_tree_11 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i < 0.5) => map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d < 2) => map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i < 0.5) => map(
         (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i < 2.5) => -0.000590489254521156, 
         (f_inq_HighRiskCredit_count_i >= 2.5) => 0.0418655003008555, 
         (f_inq_HighRiskCredit_count_i = NULL) => 0.000486591129573225, 0.000486591129573225), 
      (r_P85_Phn_Disconnected_i >= 0.5) => map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d < 5.5) => -0.00685927858066324, 
         (r_C14_Addr_Stability_v2_d >= 5.5) => map(
            (NULL < c_young and c_young < 20.8) => 0.0787241025248507, 
            (c_young >= 20.8) => 0.339332144426321, 
            (c_young = NULL) => 0.192372722301432, 0.192372722301432), 
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0853528299357117, 0.0853528299357117), 
      (r_P85_Phn_Disconnected_i = NULL) => 0.00199070312934896, 0.00199070312934896), 
   (r_D31_attr_bankruptcy_recency_d >= 2) => -0.0376172718116597, 
   (r_D31_attr_bankruptcy_recency_d = NULL) => map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p < 4.65) => -0.0954372710987163, 
      (c_pop_65_74_p >= 4.65) => 0.0356160951963515, 
      (c_pop_65_74_p = NULL) => -0.0285733087032736, -0.0285733087032736), -0.00242260558569139), 
(r_S65_SSN_Prior_DoB_i >= 0.5) => 0.102328817354486, 
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0020812163814078, -0.0020812163814078);

// Tree: 12
adj_FLAPSD_tree_12 := map(
(NULL < c_exp_prod and c_exp_prod < 37.5) => map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d < 3.5) => map(
      (NULL < c_mort_indx and c_mort_indx < 170.5) => map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i < 0.85169927215) => 0.0291752094598925, 
         (f_add_input_nhood_MFD_pct_i >= 0.85169927215) => 0.129192254379981, 
         (f_add_input_nhood_MFD_pct_i = NULL) => -0.0314832222641231, 0.0380899402838325), 
      (c_mort_indx >= 170.5) => 0.23168295992592, 
      (c_mort_indx = NULL) => 0.0531204542311995, 0.0531204542311995), 
   (f_phone_ver_insurance_d >= 3.5) => -0.00521806665695224, 
   (f_phone_ver_insurance_d = NULL) => 0.0289571978536327, 0.0289571978536327), 
(c_exp_prod >= 37.5) => map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d < 18) => 0.083580091524483, 
   (r_D33_Eviction_Recency_d >= 18) => map(
      (NULL < f_mos_liens_unrel_ST_fseen_d and f_mos_liens_unrel_ST_fseen_d < 19.5) => 0.174663574735162, 
      (f_mos_liens_unrel_ST_fseen_d >= 19.5) => -0.00545467289433395, 
      (f_mos_liens_unrel_ST_fseen_d = NULL) => -0.00488293742542556, -0.00488293742542556), 
   (r_D33_Eviction_Recency_d = NULL) => map(
      (NULL < c_transport and c_transport < 0.2) => 0.0299282777069573, 
      (c_transport >= 0.2) => -0.0883406111420579, 
      (c_transport = NULL) => -0.0155597564657409, -0.0155597564657409), -0.00458096036078009), 
(c_exp_prod = NULL) => -0.00732284860682382, -0.00171245090923464);

// Tree: 13
adj_FLAPSD_tree_13 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i < 37.5) => map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i < 0.94948431685) => map(
      (NULL < r_L70_Add_Invalid_i and r_L70_Add_Invalid_i < 0.5) => map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d < 1.5) => map(
            (NULL < c_finance and c_finance < 3.05) => map(
               (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i < 85.5) => 0.146033977401127, 
               (f_prevaddrmurderindex_i >= 85.5) => 0.0317277247803125, 
               (f_prevaddrmurderindex_i = NULL) => 0.0834744742775732, 0.0834744742775732), 
            (c_finance >= 3.05) => -0.00733835206799205, 
            (c_finance = NULL) => 0.041535459928894, 0.041535459928894), 
         (f_corrssnaddrcount_d >= 1.5) => 0.00368197198406, 
         (f_corrssnaddrcount_d = NULL) => 0.00512176578555783, 0.00512176578555783), 
      (r_L70_Add_Invalid_i >= 0.5) => -0.0615859503413673, 
      (r_L70_Add_Invalid_i = NULL) => 0.00418029873447216, 0.00418029873447216), 
   (f_add_input_nhood_MFD_pct_i >= 0.94948431685) => -0.0450951015160685, 
   (f_add_input_nhood_MFD_pct_i = NULL) => -0.0156561307136573, -0.000879668329875001), 
(f_srchaddrsrchcount_i >= 37.5) => 0.0940526856793467, 
(f_srchaddrsrchcount_i = NULL) => map(
   (NULL < c_incollege and c_incollege < 8.3) => 0.031822623623909, 
   (c_incollege >= 8.3) => -0.101840377052715, 
   (c_incollege = NULL) => -0.0176821914415072, -0.0176821914415072), -0.000650602792705538);

// Tree: 14
adj_FLAPSD_tree_14 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d < 525) => map(
   (NULL < c_exp_prod and c_exp_prod < 23.5) => map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p < 8.55) => -0.0179101264063249, 
      (c_pop_45_54_p >= 8.55) => map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i < 5.5) => 0.111464900303964, 
         (r_L79_adls_per_addr_curr_i >= 5.5) => -0.0534993526790626, 
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0839104316738322, 0.0839104316738322), 
      (c_pop_45_54_p = NULL) => 0.0375065648932822, 0.0375065648932822), 
   (c_exp_prod >= 23.5) => map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i < 6.5) => -0.00158234520470514, 
      (f_srchfraudsrchcount_i >= 6.5) => map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p < 12.05) => 0.0162188874390029, 
         (c_pop_25_34_p >= 12.05) => -0.0627212603182047, 
         (c_pop_25_34_p = NULL) => -0.0332762414885932, -0.0332762414885932), 
      (f_srchfraudsrchcount_i = NULL) => -0.00282768849182227, -0.00282768849182227), 
   (c_exp_prod = NULL) => -0.00919173368816681, -0.00118868884001077), 
(r_C13_Curr_Addr_LRes_d >= 525) => 0.177010233214301, 
(r_C13_Curr_Addr_LRes_d = NULL) => map(
   (NULL < c_cartheft and c_cartheft < 65) => 0.0825381799366667, 
   (c_cartheft >= 65) => -0.0597611582111929, 
   (c_cartheft = NULL) => -0.0113600227867509, -0.0113600227867509), -0.000803268682289071);

// Tree: 15
adj_FLAPSD_tree_15 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d < 30) => map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i < 136.5) => 0.142359201014046, 
   (f_curraddrmurderindex_i >= 136.5) => -0.0715637012359706, 
   (f_curraddrmurderindex_i = NULL) => 0.0633303581446132, 0.0633303581446132), 
(r_D33_Eviction_Recency_d >= 30) => map(
   (NULL < f_historical_count_d and f_historical_count_d < 0.5) => map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i < 2.5) => 0.00654963867766034, 
      (f_rel_felony_count_i >= 2.5) => map(
         (NULL < c_lowrent and c_lowrent < 16.15) => -0.00734287249532202, 
         (c_lowrent >= 16.15) => 0.158043768399604, 
         (c_lowrent = NULL) => 0.0857739757396366, 0.0857739757396366), 
      (f_rel_felony_count_i = NULL) => 0.00761520384536106, 0.00761520384536106), 
   (f_historical_count_d >= 0.5) => map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i < 8.5) => -0.0140178238450275, 
      (r_L79_adls_per_addr_c6_i >= 8.5) => -0.126648013976622, 
      (r_L79_adls_per_addr_c6_i = NULL) => -0.0149251815181947, -0.0149251815181947), 
   (f_historical_count_d = NULL) => -0.00390385744453181, -0.00390385744453181), 
(r_D33_Eviction_Recency_d = NULL) => map(
   (NULL < c_hh4_p and c_hh4_p < 10.9) => -0.0922642521298652, 
   (c_hh4_p >= 10.9) => 0.0160397679037403, 
   (c_hh4_p = NULL) => -0.0240728321087062, -0.0240728321087062), -0.00352610198762433);

// Tree: 16
adj_FLAPSD_tree_16 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d < 0.5) => map(
   (NULL < c_exp_prod and c_exp_prod < 36.5) => map(
      (NULL < c_exp_prod and c_exp_prod < 31.5) => 0.0347403835180991, 
      (c_exp_prod >= 31.5) => 0.191544951616544, 
      (c_exp_prod = NULL) => 0.0638700858921185, 0.0638700858921185), 
   (c_exp_prod >= 36.5) => map(
      (NULL < k_comb_age_d and k_comb_age_d < 72.5) => map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d < 86866) => -0.0516703759486237, 
         (r_L80_Inp_AVM_AutoVal_d >= 86866) => map(
            (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d < -9020.5) => 0.15077140496849, 
            (f_addrchangeincomediff_d >= -9020.5) => 0.0086693221514769, 
            (f_addrchangeincomediff_d = NULL) => 0.0454192240374018, 0.0176729080342959), 
         (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.00189310650412266, 0.00346099502879229), 
      (k_comb_age_d >= 72.5) => map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p < 6.45) => 0.201901877808252, 
         (c_pop_6_11_p >= 6.45) => 0.0224420905914879, 
         (c_pop_6_11_p = NULL) => 0.0899915610607194, 0.0899915610607194), 
      (k_comb_age_d = NULL) => 0.00629858544030354, 0.00629858544030354), 
   (c_exp_prod = NULL) => -0.0430743923114928, 0.00948074379680836), 
(f_phone_ver_experian_d >= 0.5) => -0.0206118892506838, 
(f_phone_ver_experian_d = NULL) => 0.000631495190030922, -0.00638436351557991);

// Tree: 17
adj_FLAPSD_tree_17 := map(
(NULL < r_C22_stl_inq_Count24_i and r_C22_stl_inq_Count24_i < 0.5) => map(
   (NULL < C_INC_75K_P and C_INC_75K_P < 1.75) => -0.143823873034733, 
   (C_INC_75K_P >= 1.75) => map(
      (NULL < f_inq_count24_i and f_inq_count24_i < 13.5) => map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i < 5.5) => -0.00120652110299935, 
         (f_srchvelocityrisktype_i >= 5.5) => map(
            (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i < 0.35518776515) => 0.0500408887646673, 
            (f_add_input_nhood_MFD_pct_i >= 0.35518776515) => -0.0227852437861852, 
            (f_add_input_nhood_MFD_pct_i = NULL) => 0.0322293340166642, 0.023736825943223), 
         (f_srchvelocityrisktype_i = NULL) => 0.000846400825928223, 0.000846400825928223), 
      (f_inq_count24_i >= 13.5) => -0.0852504508691137, 
      (f_inq_count24_i = NULL) => 5.68250855069156e-05, 5.68250855069156e-05), 
   (C_INC_75K_P = NULL) => -0.00908107777096227, -0.000612803125160159), 
(r_C22_stl_inq_Count24_i >= 0.5) => map(
   (NULL < c_hh5_p and c_hh5_p < 6.45) => 0.162064478018237, 
   (c_hh5_p >= 6.45) => 0.00784695508221491, 
   (c_hh5_p = NULL) => 0.084955716550226, 0.084955716550226), 
(r_C22_stl_inq_Count24_i = NULL) => map(
   (NULL < c_hval_1001k_p and c_hval_1001k_p < 0.45) => -0.0451061305620172, 
   (c_hval_1001k_p >= 0.45) => 0.0636007094859139, 
   (c_hval_1001k_p = NULL) => -0.0119638012791114, -0.0119638012791114), -0.000191350421503199);

// Tree: 18
adj_FLAPSD_tree_18 := map(
(NULL < c_wholesale and c_wholesale < 5.35) => map(
   (NULL < f_historical_count_d and f_historical_count_d < 0.5) => map(
      (NULL < c_cpiall and c_cpiall < 207.35) => map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d < 23.5) => 0.222519693595489, 
         (f_mos_inq_banko_cm_lseen_d >= 23.5) => map(
            (NULL < C_INC_150K_P and C_INC_150K_P < 3.05) => 0.133321329048171, 
            (C_INC_150K_P >= 3.05) => map(
               (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i < 112.9) => -0.00890056862637211, 
               (r_A49_Curr_AVM_Chg_1yr_Pct_i >= 112.9) => 0.230632958489074, 
               (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0268501604507436, 0.0233724607902883), 
            (C_INC_150K_P = NULL) => 0.0494942221474525, 0.0494942221474525), 
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0663583031852728, 0.0663583031852728), 
      (c_cpiall >= 207.35) => 0.0107254900390786, 
      (c_cpiall = NULL) => 0.0146350288259276, 0.0146350288259276), 
   (f_historical_count_d >= 0.5) => -0.0098175657105832, 
   (f_historical_count_d = NULL) => 0.0147295558917719, 0.00205974037334983), 
(c_wholesale >= 5.35) => map(
   (NULL < f_mos_liens_unrel_ST_fseen_d and f_mos_liens_unrel_ST_fseen_d < 98.5) => 0.129521766950025, 
   (f_mos_liens_unrel_ST_fseen_d >= 98.5) => -0.0306437525563548, 
   (f_mos_liens_unrel_ST_fseen_d = NULL) => -0.0281380341660797, -0.0281380341660797), 
(c_wholesale = NULL) => -0.00920503172678402, -0.00335311957892878);

// Tree: 19
adj_FLAPSD_tree_19 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i < 17.5) => map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d < 2) => 0.109147072619279, 
   (r_I60_inq_hiRiskCred_recency_d >= 2) => map(
      (NULL < f_mos_liens_unrel_OT_lseen_d and f_mos_liens_unrel_OT_lseen_d < 104.5) => map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d < 2.5) => -0.100976312707463, 
         (r_C14_Addr_Stability_v2_d >= 2.5) => -0.0397646158784844, 
         (r_C14_Addr_Stability_v2_d = NULL) => -0.0547049115500123, -0.0547049115500123), 
      (f_mos_liens_unrel_OT_lseen_d >= 104.5) => 0.000782041482388347, 
      (f_mos_liens_unrel_OT_lseen_d = NULL) => -0.000480653865831227, -0.000480653865831227), 
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.000116207804593864, -0.000116207804593864), 
(f_srchfraudsrchcount_i >= 17.5) => map(
   (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n < 0.5) => -0.146799106328575, 
   (f_util_add_input_misc_n >= 0.5) => map(
      (NULL < c_rest_indx and c_rest_indx < 89.5) => -0.131411832049728, 
      (c_rest_indx >= 89.5) => 0.0581818217599843, 
      (c_rest_indx = NULL) => -0.0153918349422921, -0.0153918349422921), 
   (f_util_add_input_misc_n = NULL) => -0.0617335296823821, -0.0617335296823821), 
(f_srchfraudsrchcount_i = NULL) => map(
   (NULL < c_hh4_p and c_hh4_p < 10.95) => -0.0842097131745546, 
   (c_hh4_p >= 10.95) => 0.0330069331353331, 
   (c_hh4_p = NULL) => -0.0108594191646862, -0.0108594191646862), -0.000882546773423309);

// Tree: 20
adj_FLAPSD_tree_20 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i < 25.5) => map(
   (NULL < C_INC_35K_P and C_INC_35K_P < 21.55) => map(
      (NULL < C_INC_100K_P and C_INC_100K_P < 3.55) => map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p < 18.15) => map(
            (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d < 0.5) => 0.063222068034895, 
            (f_curraddractivephonelist_d >= 0.5) => -0.0680789988374152, 
            (f_curraddractivephonelist_d = NULL) => 0.0105027002755583, 0.0105027002755583), 
         (c_pop_25_34_p >= 18.15) => 0.162131768729836, 
         (c_pop_25_34_p = NULL) => 0.0469599626361497, 0.0469599626361497), 
      (C_INC_100K_P >= 3.55) => -0.00196029769591947, 
      (C_INC_100K_P = NULL) => -0.000967846319524741, -0.000967846319524741), 
   (C_INC_35K_P >= 21.55) => map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d < 40.5) => -0.135619133638746, 
      (f_mos_inq_banko_cm_lseen_d >= 40.5) => -0.0329882828964714, 
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0554950484101281, -0.0554950484101281), 
   (C_INC_35K_P = NULL) => -0.0063799395266748, -0.00208302200185003), 
(f_srchphonesrchcount_i >= 25.5) => -0.102991953538438, 
(f_srchphonesrchcount_i = NULL) => map(
   (NULL < c_hval_80k_p and c_hval_80k_p < 0.45) => -0.0769234797751582, 
   (c_hval_80k_p >= 0.45) => 0.0553590974454707, 
   (c_hval_80k_p = NULL) => -0.0268450755416344, -0.0268450755416344), -0.00262836063798605);


// Final Score Sum 

   woFDN_FLAPSD_lgt := sum(
      woFDN_FLAPSD_lgt_0, woFDN_FLAPSD_lgt_1, woFDN_FLAPSD_lgt_2, woFDN_FLAPSD_lgt_3, woFDN_FLAPSD_lgt_4, 
      woFDN_FLAPSD_lgt_5, woFDN_FLAPSD_lgt_6, woFDN_FLAPSD_lgt_7, woFDN_FLAPSD_lgt_8, woFDN_FLAPSD_lgt_9, 
      woFDN_FLAPSD_lgt_10, woFDN_FLAPSD_lgt_11, woFDN_FLAPSD_lgt_12, woFDN_FLAPSD_lgt_13, woFDN_FLAPSD_lgt_14, 
      woFDN_FLAPSD_lgt_15, woFDN_FLAPSD_lgt_16, woFDN_FLAPSD_lgt_17, woFDN_FLAPSD_lgt_18, woFDN_FLAPSD_lgt_19, 
      woFDN_FLAPSD_lgt_20, woFDN_FLAPSD_lgt_21, woFDN_FLAPSD_lgt_22, woFDN_FLAPSD_lgt_23, woFDN_FLAPSD_lgt_24, 
      woFDN_FLAPSD_lgt_25, woFDN_FLAPSD_lgt_26, woFDN_FLAPSD_lgt_27, woFDN_FLAPSD_lgt_28, woFDN_FLAPSD_lgt_29, 
      woFDN_FLAPSD_lgt_30, woFDN_FLAPSD_lgt_31, woFDN_FLAPSD_lgt_32, woFDN_FLAPSD_lgt_33, woFDN_FLAPSD_lgt_34, 
      woFDN_FLAPSD_lgt_35, woFDN_FLAPSD_lgt_36, woFDN_FLAPSD_lgt_37, woFDN_FLAPSD_lgt_38, woFDN_FLAPSD_lgt_39, 
      woFDN_FLAPSD_lgt_40, woFDN_FLAPSD_lgt_41, woFDN_FLAPSD_lgt_42, woFDN_FLAPSD_lgt_43, woFDN_FLAPSD_lgt_44, 
      woFDN_FLAPSD_lgt_45, woFDN_FLAPSD_lgt_46, woFDN_FLAPSD_lgt_47, woFDN_FLAPSD_lgt_48, woFDN_FLAPSD_lgt_49, 
      woFDN_FLAPSD_lgt_50, woFDN_FLAPSD_lgt_51, woFDN_FLAPSD_lgt_52, woFDN_FLAPSD_lgt_53, woFDN_FLAPSD_lgt_54, 
      woFDN_FLAPSD_lgt_55, woFDN_FLAPSD_lgt_56, woFDN_FLAPSD_lgt_57, woFDN_FLAPSD_lgt_58, woFDN_FLAPSD_lgt_59, 
      woFDN_FLAPSD_lgt_60, woFDN_FLAPSD_lgt_61, woFDN_FLAPSD_lgt_62, woFDN_FLAPSD_lgt_63, woFDN_FLAPSD_lgt_64, 
      woFDN_FLAPSD_lgt_65, woFDN_FLAPSD_lgt_66, woFDN_FLAPSD_lgt_67, woFDN_FLAPSD_lgt_68, woFDN_FLAPSD_lgt_69, 
      woFDN_FLAPSD_lgt_70, woFDN_FLAPSD_lgt_71, woFDN_FLAPSD_lgt_72, woFDN_FLAPSD_lgt_73, woFDN_FLAPSD_lgt_74, 
      woFDN_FLAPSD_lgt_75, woFDN_FLAPSD_lgt_76, woFDN_FLAPSD_lgt_77, woFDN_FLAPSD_lgt_78, woFDN_FLAPSD_lgt_79, 
      woFDN_FLAPSD_lgt_80, woFDN_FLAPSD_lgt_81, woFDN_FLAPSD_lgt_82, woFDN_FLAPSD_lgt_83, woFDN_FLAPSD_lgt_84, 
      woFDN_FLAPSD_lgt_85, woFDN_FLAPSD_lgt_86, woFDN_FLAPSD_lgt_87, woFDN_FLAPSD_lgt_88, woFDN_FLAPSD_lgt_89, 
      woFDN_FLAPSD_lgt_90, woFDN_FLAPSD_lgt_91, woFDN_FLAPSD_lgt_92, woFDN_FLAPSD_lgt_93, woFDN_FLAPSD_lgt_94, 
      woFDN_FLAPSD_lgt_95, woFDN_FLAPSD_lgt_96, woFDN_FLAPSD_lgt_97, woFDN_FLAPSD_lgt_98, woFDN_FLAPSD_lgt_99, 
      woFDN_FLAPSD_lgt_100, woFDN_FLAPSD_lgt_101, woFDN_FLAPSD_lgt_102, woFDN_FLAPSD_lgt_103, woFDN_FLAPSD_lgt_104, 
      woFDN_FLAPSD_lgt_105, woFDN_FLAPSD_lgt_106, woFDN_FLAPSD_lgt_107, woFDN_FLAPSD_lgt_108, woFDN_FLAPSD_lgt_109, 
      woFDN_FLAPSD_lgt_110, woFDN_FLAPSD_lgt_111, woFDN_FLAPSD_lgt_112, woFDN_FLAPSD_lgt_113, woFDN_FLAPSD_lgt_114, 
      woFDN_FLAPSD_lgt_115, woFDN_FLAPSD_lgt_116, woFDN_FLAPSD_lgt_117, woFDN_FLAPSD_lgt_118, woFDN_FLAPSD_lgt_119, 
      woFDN_FLAPSD_lgt_120, woFDN_FLAPSD_lgt_121, woFDN_FLAPSD_lgt_122, woFDN_FLAPSD_lgt_123, woFDN_FLAPSD_lgt_124, 
      woFDN_FLAPSD_lgt_125, woFDN_FLAPSD_lgt_126, woFDN_FLAPSD_lgt_127, woFDN_FLAPSD_lgt_128, woFDN_FLAPSD_lgt_129, 
      woFDN_FLAPSD_lgt_130, woFDN_FLAPSD_lgt_131, woFDN_FLAPSD_lgt_132, woFDN_FLAPSD_lgt_133, woFDN_FLAPSD_lgt_134, 
      woFDN_FLAPSD_lgt_135, woFDN_FLAPSD_lgt_136, woFDN_FLAPSD_lgt_137, woFDN_FLAPSD_lgt_138, woFDN_FLAPSD_lgt_139, 
      woFDN_FLAPSD_lgt_140, woFDN_FLAPSD_lgt_141, woFDN_FLAPSD_lgt_142, woFDN_FLAPSD_lgt_143, woFDN_FLAPSD_lgt_144, 
      woFDN_FLAPSD_lgt_145, woFDN_FLAPSD_lgt_146, woFDN_FLAPSD_lgt_147, woFDN_FLAPSD_lgt_148, woFDN_FLAPSD_lgt_149, 
      woFDN_FLAPSD_lgt_150, woFDN_FLAPSD_lgt_151, woFDN_FLAPSD_lgt_152, woFDN_FLAPSD_lgt_153, woFDN_FLAPSD_lgt_154, 
      woFDN_FLAPSD_lgt_155, woFDN_FLAPSD_lgt_156, woFDN_FLAPSD_lgt_157, woFDN_FLAPSD_lgt_158, woFDN_FLAPSD_lgt_159, 
      woFDN_FLAPSD_lgt_160, woFDN_FLAPSD_lgt_161, woFDN_FLAPSD_lgt_162, woFDN_FLAPSD_lgt_163, woFDN_FLAPSD_lgt_164, 
      woFDN_FLAPSD_lgt_165, woFDN_FLAPSD_lgt_166, woFDN_FLAPSD_lgt_167, woFDN_FLAPSD_lgt_168, woFDN_FLAPSD_lgt_169, 
      woFDN_FLAPSD_lgt_170, woFDN_FLAPSD_lgt_171, woFDN_FLAPSD_lgt_172, woFDN_FLAPSD_lgt_173, woFDN_FLAPSD_lgt_174, 
      woFDN_FLAPSD_lgt_175, woFDN_FLAPSD_lgt_176, woFDN_FLAPSD_lgt_177, woFDN_FLAPSD_lgt_178, woFDN_FLAPSD_lgt_179, 
      woFDN_FLAPSD_lgt_180, woFDN_FLAPSD_lgt_181, woFDN_FLAPSD_lgt_182, woFDN_FLAPSD_lgt_183, woFDN_FLAPSD_lgt_184, 
      woFDN_FLAPSD_lgt_185, woFDN_FLAPSD_lgt_186, woFDN_FLAPSD_lgt_187, woFDN_FLAPSD_lgt_188, woFDN_FLAPSD_lgt_189, 
      woFDN_FLAPSD_lgt_190, woFDN_FLAPSD_lgt_191, woFDN_FLAPSD_lgt_192, woFDN_FLAPSD_lgt_193, woFDN_FLAPSD_lgt_194, 
      woFDN_FLAPSD_lgt_195, woFDN_FLAPSD_lgt_196, woFDN_FLAPSD_lgt_197, woFDN_FLAPSD_lgt_198, woFDN_FLAPSD_lgt_199, 
      woFDN_FLAPSD_lgt_200, woFDN_FLAPSD_lgt_201, woFDN_FLAPSD_lgt_202, woFDN_FLAPSD_lgt_203, woFDN_FLAPSD_lgt_204, 
      woFDN_FLAPSD_lgt_205, woFDN_FLAPSD_lgt_206, woFDN_FLAPSD_lgt_207, woFDN_FLAPSD_lgt_208, woFDN_FLAPSD_lgt_209, 
      woFDN_FLAPSD_lgt_210, woFDN_FLAPSD_lgt_211, woFDN_FLAPSD_lgt_212, woFDN_FLAPSD_lgt_213, woFDN_FLAPSD_lgt_214, 
      woFDN_FLAPSD_lgt_215, woFDN_FLAPSD_lgt_216, woFDN_FLAPSD_lgt_217, woFDN_FLAPSD_lgt_218, woFDN_FLAPSD_lgt_219, 
      woFDN_FLAPSD_lgt_220, woFDN_FLAPSD_lgt_221, woFDN_FLAPSD_lgt_222, woFDN_FLAPSD_lgt_223, woFDN_FLAPSD_lgt_224, 
      woFDN_FLAPSD_lgt_225, woFDN_FLAPSD_lgt_226); 
      
      adjusted_tree_score := sum(adj_FLAPSD_tree_0, adj_FLAPSD_tree_1, adj_FLAPSD_tree_2, adj_FLAPSD_tree_3, adj_FLAPSD_tree_4,
      adj_FLAPSD_tree_5, adj_FLAPSD_tree_6, adj_FLAPSD_tree_7, adj_FLAPSD_tree_8, adj_FLAPSD_tree_9, adj_FLAPSD_tree_10, 
      adj_FLAPSD_tree_11, adj_FLAPSD_tree_12, adj_FLAPSD_tree_13, adj_FLAPSD_tree_14, adj_FLAPSD_tree_15, 
      adj_FLAPSD_tree_16, adj_FLAPSD_tree_17, adj_FLAPSD_tree_18, adj_FLAPSD_tree_19, adj_FLAPSD_tree_20);
      
// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
		
    
		FP3_woFDN_LGT := woFDN_FLAPSD_lgt + adjusted_tree_score;
			
self.final_score_0	:= 	woFDN_FLAPSD_lgt_0	;
self.final_score_1	:= 	woFDN_FLAPSD_lgt_1	;
self.final_score_2	:= 	woFDN_FLAPSD_lgt_2	;
self.final_score_3	:= 	woFDN_FLAPSD_lgt_3	;
self.final_score_4	:= 	woFDN_FLAPSD_lgt_4	;
self.final_score_5	:= 	woFDN_FLAPSD_lgt_5	;
self.final_score_6	:= 	woFDN_FLAPSD_lgt_6	;
self.final_score_7	:= 	woFDN_FLAPSD_lgt_7	;
self.final_score_8	:= 	woFDN_FLAPSD_lgt_8	;
self.final_score_9	:= 	woFDN_FLAPSD_lgt_9	;
self.final_score_10	:= 	woFDN_FLAPSD_lgt_10	;
self.final_score_11	:= 	woFDN_FLAPSD_lgt_11	;
self.final_score_12	:= 	woFDN_FLAPSD_lgt_12	;
self.final_score_13	:= 	woFDN_FLAPSD_lgt_13	;
self.final_score_14	:= 	woFDN_FLAPSD_lgt_14	;
self.final_score_15	:= 	woFDN_FLAPSD_lgt_15	;
self.final_score_16	:= 	woFDN_FLAPSD_lgt_16	;
self.final_score_17	:= 	woFDN_FLAPSD_lgt_17	;
self.final_score_18	:= 	woFDN_FLAPSD_lgt_18	;
self.final_score_19	:= 	woFDN_FLAPSD_lgt_19	;
self.final_score_20	:= 	woFDN_FLAPSD_lgt_20	;
self.final_score_21	:= 	woFDN_FLAPSD_lgt_21	;
self.final_score_22	:= 	woFDN_FLAPSD_lgt_22	;
self.final_score_23	:= 	woFDN_FLAPSD_lgt_23	;
self.final_score_24	:= 	woFDN_FLAPSD_lgt_24	;
self.final_score_25	:= 	woFDN_FLAPSD_lgt_25	;
self.final_score_26	:= 	woFDN_FLAPSD_lgt_26	;
self.final_score_27	:= 	woFDN_FLAPSD_lgt_27	;
self.final_score_28	:= 	woFDN_FLAPSD_lgt_28	;
self.final_score_29	:= 	woFDN_FLAPSD_lgt_29	;
self.final_score_30	:= 	woFDN_FLAPSD_lgt_30	;
self.final_score_31	:= 	woFDN_FLAPSD_lgt_31	;
self.final_score_32	:= 	woFDN_FLAPSD_lgt_32	;
self.final_score_33	:= 	woFDN_FLAPSD_lgt_33	;
self.final_score_34	:= 	woFDN_FLAPSD_lgt_34	;
self.final_score_35	:= 	woFDN_FLAPSD_lgt_35	;
self.final_score_36	:= 	woFDN_FLAPSD_lgt_36	;
self.final_score_37	:= 	woFDN_FLAPSD_lgt_37	;
self.final_score_38	:= 	woFDN_FLAPSD_lgt_38	;
self.final_score_39	:= 	woFDN_FLAPSD_lgt_39	;
self.final_score_40	:= 	woFDN_FLAPSD_lgt_40	;
self.final_score_41	:= 	woFDN_FLAPSD_lgt_41	;
self.final_score_42	:= 	woFDN_FLAPSD_lgt_42	;
self.final_score_43	:= 	woFDN_FLAPSD_lgt_43	;
self.final_score_44	:= 	woFDN_FLAPSD_lgt_44	;
self.final_score_45	:= 	woFDN_FLAPSD_lgt_45	;
self.final_score_46	:= 	woFDN_FLAPSD_lgt_46	;
self.final_score_47	:= 	woFDN_FLAPSD_lgt_47	;
self.final_score_48	:= 	woFDN_FLAPSD_lgt_48	;
self.final_score_49	:= 	woFDN_FLAPSD_lgt_49	;
self.final_score_50	:= 	woFDN_FLAPSD_lgt_50	;
self.final_score_51	:= 	woFDN_FLAPSD_lgt_51	;
self.final_score_52	:= 	woFDN_FLAPSD_lgt_52	;
self.final_score_53	:= 	woFDN_FLAPSD_lgt_53	;
self.final_score_54	:= 	woFDN_FLAPSD_lgt_54	;
self.final_score_55	:= 	woFDN_FLAPSD_lgt_55	;
self.final_score_56	:= 	woFDN_FLAPSD_lgt_56	;
self.final_score_57	:= 	woFDN_FLAPSD_lgt_57	;
self.final_score_58	:= 	woFDN_FLAPSD_lgt_58	;
self.final_score_59	:= 	woFDN_FLAPSD_lgt_59	;
self.final_score_60	:= 	woFDN_FLAPSD_lgt_60	;
self.final_score_61	:= 	woFDN_FLAPSD_lgt_61	;
self.final_score_62	:= 	woFDN_FLAPSD_lgt_62	;
self.final_score_63	:= 	woFDN_FLAPSD_lgt_63	;
self.final_score_64	:= 	woFDN_FLAPSD_lgt_64	;
self.final_score_65	:= 	woFDN_FLAPSD_lgt_65	;
self.final_score_66	:= 	woFDN_FLAPSD_lgt_66	;
self.final_score_67	:= 	woFDN_FLAPSD_lgt_67	;
self.final_score_68	:= 	woFDN_FLAPSD_lgt_68	;
self.final_score_69	:= 	woFDN_FLAPSD_lgt_69	;
self.final_score_70	:= 	woFDN_FLAPSD_lgt_70	;
self.final_score_71	:= 	woFDN_FLAPSD_lgt_71	;
self.final_score_72	:= 	woFDN_FLAPSD_lgt_72	;
self.final_score_73	:= 	woFDN_FLAPSD_lgt_73	;
self.final_score_74	:= 	woFDN_FLAPSD_lgt_74	;
self.final_score_75	:= 	woFDN_FLAPSD_lgt_75	;
self.final_score_76	:= 	woFDN_FLAPSD_lgt_76	;
self.final_score_77	:= 	woFDN_FLAPSD_lgt_77	;
self.final_score_78	:= 	woFDN_FLAPSD_lgt_78	;
self.final_score_79	:= 	woFDN_FLAPSD_lgt_79	;
self.final_score_80	:= 	woFDN_FLAPSD_lgt_80	;
self.final_score_81	:= 	woFDN_FLAPSD_lgt_81	;
self.final_score_82	:= 	woFDN_FLAPSD_lgt_82	;
self.final_score_83	:= 	woFDN_FLAPSD_lgt_83	;
self.final_score_84	:= 	woFDN_FLAPSD_lgt_84	;
self.final_score_85	:= 	woFDN_FLAPSD_lgt_85	;
self.final_score_86	:= 	woFDN_FLAPSD_lgt_86	;
self.final_score_87	:= 	woFDN_FLAPSD_lgt_87	;
self.final_score_88	:= 	woFDN_FLAPSD_lgt_88	;
self.final_score_89	:= 	woFDN_FLAPSD_lgt_89	;
self.final_score_90	:= 	woFDN_FLAPSD_lgt_90	;
self.final_score_91	:= 	woFDN_FLAPSD_lgt_91	;
self.final_score_92	:= 	woFDN_FLAPSD_lgt_92	;
self.final_score_93	:= 	woFDN_FLAPSD_lgt_93	;
self.final_score_94	:= 	woFDN_FLAPSD_lgt_94	;
self.final_score_95	:= 	woFDN_FLAPSD_lgt_95	;
self.final_score_96	:= 	woFDN_FLAPSD_lgt_96	;
self.final_score_97	:= 	woFDN_FLAPSD_lgt_97	;
self.final_score_98	:= 	woFDN_FLAPSD_lgt_98	;
self.final_score_99	:= 	woFDN_FLAPSD_lgt_99	;
self.final_score_100	:= 	woFDN_FLAPSD_lgt_100	;
self.final_score_101	:= 	woFDN_FLAPSD_lgt_101	;
self.final_score_102	:= 	woFDN_FLAPSD_lgt_102	;
self.final_score_103	:= 	woFDN_FLAPSD_lgt_103	;
self.final_score_104	:= 	woFDN_FLAPSD_lgt_104	;
self.final_score_105	:= 	woFDN_FLAPSD_lgt_105	;
self.final_score_106	:= 	woFDN_FLAPSD_lgt_106	;
self.final_score_107	:= 	woFDN_FLAPSD_lgt_107	;
self.final_score_108	:= 	woFDN_FLAPSD_lgt_108	;
self.final_score_109	:= 	woFDN_FLAPSD_lgt_109	;
self.final_score_110	:= 	woFDN_FLAPSD_lgt_110	;
self.final_score_111	:= 	woFDN_FLAPSD_lgt_111	;
self.final_score_112	:= 	woFDN_FLAPSD_lgt_112	;
self.final_score_113	:= 	woFDN_FLAPSD_lgt_113	;
self.final_score_114	:= 	woFDN_FLAPSD_lgt_114	;
self.final_score_115	:= 	woFDN_FLAPSD_lgt_115	;
self.final_score_116	:= 	woFDN_FLAPSD_lgt_116	;
self.final_score_117	:= 	woFDN_FLAPSD_lgt_117	;
self.final_score_118	:= 	woFDN_FLAPSD_lgt_118	;
self.final_score_119	:= 	woFDN_FLAPSD_lgt_119	;
self.final_score_120	:= 	woFDN_FLAPSD_lgt_120	;
self.final_score_121	:= 	woFDN_FLAPSD_lgt_121	;
self.final_score_122	:= 	woFDN_FLAPSD_lgt_122	;
self.final_score_123	:= 	woFDN_FLAPSD_lgt_123	;
self.final_score_124	:= 	woFDN_FLAPSD_lgt_124	;
self.final_score_125	:= 	woFDN_FLAPSD_lgt_125	;
self.final_score_126	:= 	woFDN_FLAPSD_lgt_126	;
self.final_score_127	:= 	woFDN_FLAPSD_lgt_127	;
self.final_score_128	:= 	woFDN_FLAPSD_lgt_128	;
self.final_score_129	:= 	woFDN_FLAPSD_lgt_129	;
self.final_score_130	:= 	woFDN_FLAPSD_lgt_130	;
self.final_score_131	:= 	woFDN_FLAPSD_lgt_131	;
self.final_score_132	:= 	woFDN_FLAPSD_lgt_132	;
self.final_score_133	:= 	woFDN_FLAPSD_lgt_133	;
self.final_score_134	:= 	woFDN_FLAPSD_lgt_134	;
self.final_score_135	:= 	woFDN_FLAPSD_lgt_135	;
self.final_score_136	:= 	woFDN_FLAPSD_lgt_136	;
self.final_score_137	:= 	woFDN_FLAPSD_lgt_137	;
self.final_score_138	:= 	woFDN_FLAPSD_lgt_138	;
self.final_score_139	:= 	woFDN_FLAPSD_lgt_139	;
self.final_score_140	:= 	woFDN_FLAPSD_lgt_140	;
self.final_score_141	:= 	woFDN_FLAPSD_lgt_141	;
self.final_score_142	:= 	woFDN_FLAPSD_lgt_142	;
self.final_score_143	:= 	woFDN_FLAPSD_lgt_143	;
self.final_score_144	:= 	woFDN_FLAPSD_lgt_144	;
self.final_score_145	:= 	woFDN_FLAPSD_lgt_145	;
self.final_score_146	:= 	woFDN_FLAPSD_lgt_146	;
self.final_score_147	:= 	woFDN_FLAPSD_lgt_147	;
self.final_score_148	:= 	woFDN_FLAPSD_lgt_148	;
self.final_score_149	:= 	woFDN_FLAPSD_lgt_149	;
self.final_score_150	:= 	woFDN_FLAPSD_lgt_150	;
self.final_score_151	:= 	woFDN_FLAPSD_lgt_151	;
self.final_score_152	:= 	woFDN_FLAPSD_lgt_152	;
self.final_score_153	:= 	woFDN_FLAPSD_lgt_153	;
self.final_score_154	:= 	woFDN_FLAPSD_lgt_154	;
self.final_score_155	:= 	woFDN_FLAPSD_lgt_155	;
self.final_score_156	:= 	woFDN_FLAPSD_lgt_156	;
self.final_score_157	:= 	woFDN_FLAPSD_lgt_157	;
self.final_score_158	:= 	woFDN_FLAPSD_lgt_158	;
self.final_score_159	:= 	woFDN_FLAPSD_lgt_159	;
self.final_score_160	:= 	woFDN_FLAPSD_lgt_160	;
self.final_score_161	:= 	woFDN_FLAPSD_lgt_161	;
self.final_score_162	:= 	woFDN_FLAPSD_lgt_162	;
self.final_score_163	:= 	woFDN_FLAPSD_lgt_163	;
self.final_score_164	:= 	woFDN_FLAPSD_lgt_164	;
self.final_score_165	:= 	woFDN_FLAPSD_lgt_165	;
self.final_score_166	:= 	woFDN_FLAPSD_lgt_166	;
self.final_score_167	:= 	woFDN_FLAPSD_lgt_167	;
self.final_score_168	:= 	woFDN_FLAPSD_lgt_168	;
self.final_score_169	:= 	woFDN_FLAPSD_lgt_169	;
self.final_score_170	:= 	woFDN_FLAPSD_lgt_170	;
self.final_score_171	:= 	woFDN_FLAPSD_lgt_171	;
self.final_score_172	:= 	woFDN_FLAPSD_lgt_172	;
self.final_score_173	:= 	woFDN_FLAPSD_lgt_173	;
self.final_score_174	:= 	woFDN_FLAPSD_lgt_174	;
self.final_score_175	:= 	woFDN_FLAPSD_lgt_175	;
self.final_score_176	:= 	woFDN_FLAPSD_lgt_176	;
self.final_score_177	:= 	woFDN_FLAPSD_lgt_177	;
self.final_score_178	:= 	woFDN_FLAPSD_lgt_178	;
self.final_score_179	:= 	woFDN_FLAPSD_lgt_179	;
self.final_score_180	:= 	woFDN_FLAPSD_lgt_180	;
self.final_score_181	:= 	woFDN_FLAPSD_lgt_181	;
self.final_score_182	:= 	woFDN_FLAPSD_lgt_182	;
self.final_score_183	:= 	woFDN_FLAPSD_lgt_183	;
self.final_score_184	:= 	woFDN_FLAPSD_lgt_184	;
self.final_score_185	:= 	woFDN_FLAPSD_lgt_185	;
self.final_score_186	:= 	woFDN_FLAPSD_lgt_186	;
self.final_score_187	:= 	woFDN_FLAPSD_lgt_187	;
self.final_score_188	:= 	woFDN_FLAPSD_lgt_188	;
self.final_score_189	:= 	woFDN_FLAPSD_lgt_189	;
self.final_score_190	:= 	woFDN_FLAPSD_lgt_190	;
self.final_score_191	:= 	woFDN_FLAPSD_lgt_191	;
self.final_score_192	:= 	woFDN_FLAPSD_lgt_192	;
self.final_score_193	:= 	woFDN_FLAPSD_lgt_193	;
self.final_score_194	:= 	woFDN_FLAPSD_lgt_194	;
self.final_score_195	:= 	woFDN_FLAPSD_lgt_195	;
self.final_score_196	:= 	woFDN_FLAPSD_lgt_196	;
self.final_score_197	:= 	woFDN_FLAPSD_lgt_197	;
self.final_score_198	:= 	woFDN_FLAPSD_lgt_198	;
self.final_score_199	:= 	woFDN_FLAPSD_lgt_199	;
self.final_score_200	:= 	woFDN_FLAPSD_lgt_200	;
self.final_score_201	:= 	woFDN_FLAPSD_lgt_201	;
self.final_score_202	:= 	woFDN_FLAPSD_lgt_202	;
self.final_score_203	:= 	woFDN_FLAPSD_lgt_203	;
self.final_score_204	:= 	woFDN_FLAPSD_lgt_204	;
self.final_score_205	:= 	woFDN_FLAPSD_lgt_205	;
self.final_score_206	:= 	woFDN_FLAPSD_lgt_206	;
self.final_score_207	:= 	woFDN_FLAPSD_lgt_207	;
self.final_score_208	:= 	woFDN_FLAPSD_lgt_208	;
self.final_score_209	:= 	woFDN_FLAPSD_lgt_209	;
self.final_score_210	:= 	woFDN_FLAPSD_lgt_210	;
self.final_score_211	:= 	woFDN_FLAPSD_lgt_211	;
self.final_score_212	:= 	woFDN_FLAPSD_lgt_212	;
self.final_score_213	:= 	woFDN_FLAPSD_lgt_213	;
self.final_score_214	:= 	woFDN_FLAPSD_lgt_214	;
self.final_score_215	:= 	woFDN_FLAPSD_lgt_215	;
self.final_score_216	:= 	woFDN_FLAPSD_lgt_216	;
self.final_score_217	:= 	woFDN_FLAPSD_lgt_217	;
self.final_score_218	:= 	woFDN_FLAPSD_lgt_218	;
self.final_score_219	:= 	woFDN_FLAPSD_lgt_219	;
self.final_score_220	:= 	woFDN_FLAPSD_lgt_220	;
self.final_score_221	:= 	woFDN_FLAPSD_lgt_221	;
self.final_score_222	:= 	woFDN_FLAPSD_lgt_222	;
self.final_score_223	:= 	woFDN_FLAPSD_lgt_223	;
self.final_score_224	:= 	woFDN_FLAPSD_lgt_224	;
self.final_score_225	:= 	woFDN_FLAPSD_lgt_225	;
self.final_score_226	:= 	woFDN_FLAPSD_lgt_226	;
self.final_adj_score0 :=  adj_FLAPSD_tree_0     ;
self.final_adj_score1 :=  adj_FLAPSD_tree_1     ;
self.final_adj_score2 :=  adj_FLAPSD_tree_2     ;
self.final_adj_score3 :=  adj_FLAPSD_tree_3     ;
self.final_adj_score4 :=  adj_FLAPSD_tree_4     ;
self.final_adj_score5 :=  adj_FLAPSD_tree_5     ;
self.final_adj_score6 :=  adj_FLAPSD_tree_6     ;
self.final_adj_score7 :=  adj_FLAPSD_tree_7     ;
self.final_adj_score8 :=  adj_FLAPSD_tree_8     ;
self.final_adj_score9 :=  adj_FLAPSD_tree_9     ;
self.final_adj_score10 :=  adj_FLAPSD_tree_10   ;
self.final_adj_score11 :=  adj_FLAPSD_tree_11   ;
self.final_adj_score12 :=  adj_FLAPSD_tree_12   ;
self.final_adj_score13 :=  adj_FLAPSD_tree_13   ;
self.final_adj_score14 :=  adj_FLAPSD_tree_14   ;
self.final_adj_score15 :=  adj_FLAPSD_tree_15   ;
self.final_adj_score16 :=  adj_FLAPSD_tree_16   ;
self.final_adj_score17 :=  adj_FLAPSD_tree_17   ;
self.final_adj_score18 :=  adj_FLAPSD_tree_18   ;
self.final_adj_score19 :=  adj_FLAPSD_tree_19   ;
self.final_adj_score20 :=  adj_FLAPSD_tree_20   ;
// self.woFDN_submodel_lgt	:= 	woFDN_FLAPSD_lgt	;
self.orig_FDN_FLAPSD_LGT := woFDN_FLAPSD_lgt;
self.adj_FDN_FLAPSD_LGT := adjusted_tree_score;
self.FP3_woFDN_LGT		:= 	FP3_woFDN_LGT	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
