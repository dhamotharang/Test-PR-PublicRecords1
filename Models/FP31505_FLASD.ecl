Import Models;

export FP31505_FLASD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   woFDN_FLA_SD_lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FLA_SD_lgt_1 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0417804703,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 50.45) => 0.2546471475,
      (c_fammar_p > 50.45) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0184083232,
         (f_varrisktype_i > 3.5) => 0.2569983054,
         (f_varrisktype_i = NULL) => 0.0405112022, 0.0405112022),
      (c_fammar_p = NULL) => -0.0415916125, 0.0597197667),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.1839563121,
      (f_srchvelocityrisktype_i > 5.5) => 0.5423947311,
      (f_srchvelocityrisktype_i = NULL) => 0.3323001330, 0.3323001330),
   (f_inq_Communications_count_i = NULL) => 0.3008293658, 0.1076665066),
(nf_seg_FraudPoint_3_0 = '') => -0.0016766067, -0.0016766067);

// Tree: 2 
woFDN_FLA_SD_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1542790099,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0376530475,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1948119016,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0325886325, -0.0325886325),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0222640179, -0.0222640179),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0610995614,
   (f_rel_under500miles_cnt_d > 5.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.2134211339,
      (f_srchvelocityrisktype_i > 4.5) => 0.4443052413,
      (f_srchvelocityrisktype_i = NULL) => 0.3294871987, 0.3294871987),
   (f_rel_under500miles_cnt_d = NULL) => 0.1127298041, 0.2044301636),
(f_varrisktype_i = NULL) => 0.2137325290, -0.0075126913);

// Tree: 3 
woFDN_FLA_SD_lgt_3 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0331716734,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 28.75) => 
         map(
         (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 0.0108076642,
         (f_srchcomponentrisktype_i > 3.5) => 0.2492127152,
         (f_srchcomponentrisktype_i = NULL) => 0.0179747472, 0.0179747472),
      (c_famotf18_p > 28.75) => 0.1853252395,
      (c_famotf18_p = NULL) => -0.0387706105, 0.0334524939),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 0.1396750165,
      (f_inq_count_i > 8.5) => 0.3271543594,
      (f_inq_count_i = NULL) => 0.1947953477, 0.1947953477),
   (f_inq_Communications_count_i = NULL) => 0.1108194097, 0.0604954276),
(nf_seg_FraudPoint_3_0 = '') => -0.0076818167, -0.0076818167);

// Tree: 4 
woFDN_FLA_SD_lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0350961904,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 23.55) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0015834276,
         (f_varrisktype_i > 2.5) => 0.1027252477,
         (f_varrisktype_i = NULL) => 0.0206575223, 0.0206575223),
      (c_famotf18_p > 23.55) => 0.1402610306,
      (c_famotf18_p = NULL) => -0.0297704464, 0.0384079707),
   (nf_seg_FraudPoint_3_0 = '') => -0.0163285321, -0.0163285321),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 35.5) => 0.2271678486,
   (r_pb_order_freq_d > 35.5) => 0.0512653637,
   (r_pb_order_freq_d = NULL) => 0.2775503375, 0.1905675708),
(f_srchfraudsrchcount_i = NULL) => 0.1251960619, -0.0097772692);

// Tree: 5 
woFDN_FLA_SD_lgt_5 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.35) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0542634169,
      (f_rel_felony_count_i > 2.5) => 0.3673612195,
      (f_rel_felony_count_i = NULL) => 0.0656119457, 0.0656119457),
   (c_fammar_p > 59.35) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.2964650085,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0308786496,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0289425088, -0.0289425088),
   (c_fammar_p = NULL) => -0.0239600456, -0.0160734300),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1571378708,
   (r_I60_inq_comm_recency_d > 549) => 0.0640289991,
   (r_I60_inq_comm_recency_d = NULL) => 0.0874531426, 0.0874531426),
(f_srchvelocityrisktype_i = NULL) => 0.0940619328, -0.0060066735);

// Tree: 6 
woFDN_FLA_SD_lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 0.0582439303,
      (r_L79_adls_per_addr_curr_i > 3.5) => 0.2699940914,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0977747129, 0.0977747129),
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.2274166931,
      (r_D33_Eviction_Recency_d > 48) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => -0.0277495424,
         (f_assocsuspicousidcount_i > 14.5) => 0.2671115871,
         (f_assocsuspicousidcount_i = NULL) => -0.0258294682, -0.0258294682),
      (r_D33_Eviction_Recency_d = NULL) => -0.0235328514, -0.0235328514),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0166389023, -0.0166389023),
(f_inq_HighRiskCredit_count_i > 2.5) => 0.1310003587,
(f_inq_HighRiskCredit_count_i = NULL) => 0.0761563168, -0.0111231287);

// Tree: 7 
woFDN_FLA_SD_lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 50) => 0.3881401561,
      (r_F01_inp_addr_address_score_d > 50) => 0.1071457217,
      (r_F01_inp_addr_address_score_d = NULL) => 0.1482310698, 0.1482310698),
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => -0.0308581145,
      (f_divrisktype_i > 1.5) => 0.0554280575,
      (f_divrisktype_i = NULL) => -0.0197667810, -0.0197667810),
   (r_F00_dob_score_d = NULL) => 0.0086953504, -0.0134959248),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < c_employees and c_employees <= 38.5) => 0.3163201352,
   (c_employees > 38.5) => 0.0807934305,
   (c_employees = NULL) => 0.1267498607, 0.1267498607),
(f_inq_Communications_count_i = NULL) => 0.0548959527, -0.0082984252);

// Tree: 8 
woFDN_FLA_SD_lgt_8 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0562607188,
      (f_rel_felony_count_i > 1.5) => 0.2908041050,
      (f_rel_felony_count_i = NULL) => 0.0738572611, 0.0738572611),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 12.5) => -0.0351611215,
      (f_srchaddrsrchcount_i > 12.5) => 0.0906869651,
      (f_srchaddrsrchcount_i = NULL) => -0.0307666223, -0.0307666223),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0213105201, -0.0213105201),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0441029488,
   (f_rel_felony_count_i > 0.5) => 0.1935530868,
   (f_rel_felony_count_i = NULL) => 0.0727374631, 0.0727374631),
(f_varrisktype_i = NULL) => 0.0510246100, -0.0106166050);

// Tree: 9 
woFDN_FLA_SD_lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 0.0264070155,
         (r_D30_Derog_Count_i > 5.5) => 0.1815583182,
         (r_D30_Derog_Count_i = NULL) => 0.0370231435, 0.0370231435),
      (r_F01_inp_addr_not_verified_i > 0.5) => 0.1574807768,
      (r_F01_inp_addr_not_verified_i = NULL) => 0.0502802127, 0.0502802127),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 3.5) => -0.0346992664,
      (f_assocsuspicousidcount_i > 3.5) => 0.0266947951,
      (f_assocsuspicousidcount_i = NULL) => -0.0220290155, -0.0220290155),
   (c_fammar_p = NULL) => -0.0386344215, -0.0118442105),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1506489433,
(f_inq_PrepaidCards_count_i = NULL) => 0.0896011075, -0.0064105682);

// Tree: 10 
woFDN_FLA_SD_lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0278477905,
      (k_inq_per_addr_i > 3.5) => 0.0584805559,
      (k_inq_per_addr_i = NULL) => -0.0187119090, -0.0187119090),
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 103.5) => 0.0267828778,
      (f_prevaddrageoldest_d > 103.5) => 0.1857864122,
      (f_prevaddrageoldest_d = NULL) => 0.0663922992, 0.0663922992),
   (nf_seg_FraudPoint_3_0 = '') => -0.0127998490, -0.0127998490),
(f_inq_Communications_count_i > 1.5) => 0.1180750111,
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0726727422,
   (f_addrs_per_ssn_i > 4.5) => 0.1744126590,
   (f_addrs_per_ssn_i = NULL) => 0.0386269881, 0.0386269881), -0.0078205473);

// Tree: 11 
woFDN_FLA_SD_lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1275953949,
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2934883609,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
            map(
            (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0276324338,
            (f_inq_HighRiskCredit_count_i > 2.5) => 0.0713231916,
            (f_inq_HighRiskCredit_count_i = NULL) => -0.0250111519, -0.0250111519),
         (f_inq_PrepaidCards_count24_i > 0.5) => 0.1494444932,
         (f_inq_PrepaidCards_count24_i = NULL) => -0.0229229825, -0.0229229825),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0214880742, -0.0214880742),
   (r_F00_dob_score_d = NULL) => 0.0129391579, -0.0156777681),
(k_inq_ssns_per_addr_i > 2.5) => 0.1286339499,
(k_inq_ssns_per_addr_i = NULL) => -0.0089655952, -0.0089655952);

// Tree: 12 
woFDN_FLA_SD_lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 7.5) => 0.0237200698,
      (f_addrchangecrimediff_i > 7.5) => 0.1581532033,
      (f_addrchangecrimediff_i = NULL) => 0.0591267029, 0.0571048941),
   (f_corrssnaddrcount_d > 2.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1360233280,
      (r_C10_M_Hdr_FS_d > 7.5) => -0.0209919603,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0186943831, -0.0186943831),
   (f_corrssnaddrcount_d = NULL) => -0.0115897521, -0.0115897521),
(f_srchfraudsrchcount_i > 8.5) => 0.0903833681,
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0471907533,
   (f_addrs_per_ssn_i > 3.5) => 0.1760720532,
   (f_addrs_per_ssn_i = NULL) => 0.0594122083, 0.0594122083), -0.0080905330);

// Tree: 13 
woFDN_FLA_SD_lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 51.45) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 24.95) => 0.0529251416,
      (c_vacant_p > 24.95) => 0.2171842647,
      (c_vacant_p = NULL) => 0.0647935754, 0.0647935754),
   (c_fammar_p > 51.45) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.1840709544,
         (r_F00_dob_score_d > 55) => -0.0187868739,
         (r_F00_dob_score_d = NULL) => -0.0115943275, -0.0174228598),
      (f_inq_PrepaidCards_count_i > 1.5) => 0.1323772136,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0161449317, -0.0161449317),
   (c_fammar_p = NULL) => -0.0549918890, -0.0103261557),
(f_assocsuspicousidcount_i > 13.5) => 0.1912022223,
(f_assocsuspicousidcount_i = NULL) => 0.0433564080, -0.0081416364);

// Tree: 14 
woFDN_FLA_SD_lgt_14 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 60.05) => 
         map(
         (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 0.2228907483,
         (r_F00_input_dob_match_level_d > 5.5) => 
            map(
            (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 4.5) => 0.0111641720,
            (r_D32_criminal_count_i > 4.5) => 0.1815995045,
            (r_D32_criminal_count_i = NULL) => 0.0173193708, 0.0173193708),
         (r_F00_input_dob_match_level_d = NULL) => 0.0235262361, 0.0235262361),
      (c_fammar_p > 60.05) => -0.0236767967,
      (c_fammar_p = NULL) => -0.0552968794, -0.0175333919),
   (f_srchcomponentrisktype_i > 1.5) => 0.0726592956,
   (f_srchcomponentrisktype_i = NULL) => -0.0115412342, -0.0115412342),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1024340737,
(f_inq_PrepaidCards_count_i = NULL) => 0.0114216042, -0.0080140869);

// Tree: 15 
woFDN_FLA_SD_lgt_15 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 61.05) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0232808509,
         (r_L79_adls_per_addr_c6_i > 4.5) => 0.1385001285,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0315633869, 0.0315633869),
      (k_comb_age_d > 69.5) => 0.2562165741,
      (k_comb_age_d = NULL) => 0.0422720074, 0.0422720074),
   (c_fammar_p > 61.05) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0260383650,
      (f_varrisktype_i > 3.5) => 0.0504867351,
      (f_varrisktype_i = NULL) => -0.0223671422, -0.0223671422),
   (c_fammar_p = NULL) => -0.0311788545, -0.0123031400),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.1352693370,
(f_inq_PrepaidCards_count24_i = NULL) => 0.0526815043, -0.0099978795);

// Tree: 16 
woFDN_FLA_SD_lgt_16 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => 0.0315120698,
      (f_inq_HighRiskCredit_count_i > 4.5) => 0.1179178463,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0380317033, 0.0380317033),
   (r_D30_Derog_Count_i > 5.5) => 0.1427762895,
   (r_D30_Derog_Count_i = NULL) => 0.0500733464, 0.0500733464),
(r_I60_inq_comm_recency_d > 549) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.0553447111,
   (f_corrssnaddrcount_d > 2.5) => -0.0154289287,
   (f_corrssnaddrcount_d = NULL) => -0.0091756116, -0.0091756116),
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0783956832,
   (r_S66_adlperssn_count_i > 1.5) => 0.1038682277,
   (r_S66_adlperssn_count_i = NULL) => 0.0153400424, 0.0153400424), -0.0034471401);

// Tree: 17 
woFDN_FLA_SD_lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 53.5) => 0.1293629797,
      (c_born_usa > 53.5) => 0.0092990658,
      (c_born_usa = NULL) => 0.0291289239, 0.0509916769),
   (f_corrssnaddrcount_d > 1.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => -0.0341370517,
      (f_assocrisktype_i > 4.5) => 0.0227678783,
      (f_assocrisktype_i = NULL) => -0.0249118315, -0.0249118315),
   (f_corrssnaddrcount_d = NULL) => -0.0008322372, -0.0208851713),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0343381578,
   (f_hh_payday_loan_users_i > 0.5) => 0.1262956239,
   (f_hh_payday_loan_users_i = NULL) => 0.0493664838, 0.0493664838),
(k_inq_per_addr_i = NULL) => -0.0131428131, -0.0131428131);

// Tree: 18 
woFDN_FLA_SD_lgt_18 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 0.0099999488,
      (f_hh_criminals_i > 0.5) => 0.1065480033,
      (f_hh_criminals_i = NULL) => 0.0405939979, 0.0405939979),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 0.0409473622,
         (r_L79_adls_per_addr_c6_i > 3.5) => 0.2682593775,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0988682123, 0.0988682123),
      (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0171951769,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0150348918, -0.0150348918),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0094142752, -0.0094142752),
(r_D33_eviction_count_i > 2.5) => 0.1238397150,
(r_D33_eviction_count_i = NULL) => 0.0209051462, -0.0077566010);

// Tree: 19 
woFDN_FLA_SD_lgt_19 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 2.5) => -0.0138761005,
      (k_inq_per_addr_i > 2.5) => 0.0371621175,
      (k_inq_per_addr_i = NULL) => -0.0058636121, -0.0058636121),
   (f_inq_PrepaidCards_count_i > 1.5) => 0.1111491967,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0047695780, -0.0047695780),
(f_rel_felony_count_i > 1.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0314891305,
   (f_corrrisktype_i > 6.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 4.35) => 0.0858471018,
      (c_bigapt_p > 4.35) => 0.2351524218,
      (c_bigapt_p = NULL) => 0.1388504904, 0.1388504904),
   (f_corrrisktype_i = NULL) => 0.0676944639, 0.0676944639),
(f_rel_felony_count_i = NULL) => 0.0091618786, -0.0012302302);

// Tree: 20 
woFDN_FLA_SD_lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1237769217,
   (r_F00_input_dob_match_level_d > 4.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0209078544,
      (k_inq_per_addr_i > 3.5) => 0.0486692059,
      (k_inq_per_addr_i = NULL) => -0.0142400792, -0.0142400792),
   (r_F00_input_dob_match_level_d = NULL) => -0.0114050421, -0.0114050421),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 11.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 168.5) => 0.0311995351,
      (f_curraddrcrimeindex_i > 168.5) => 0.1553457719,
      (f_curraddrcrimeindex_i = NULL) => 0.0443466404, 0.0443466404),
   (f_assocsuspicousidcount_i > 11.5) => 0.1759300118,
   (f_assocsuspicousidcount_i = NULL) => 0.0496940052, 0.0496940052),
(f_varrisktype_i = NULL) => 0.0271626315, -0.0044332698);

// Tree: 21 
woFDN_FLA_SD_lgt_21 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 4.5) => -0.0207885446,
   (f_srchaddrsrchcount_i > 4.5) => 
      map(
      (NULL < c_professional and c_professional <= 1.65) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.1399773598) => 0.0528280546,
         (f_add_input_nhood_BUS_pct_i > 0.1399773598) => 0.2224982812,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0690353598, 0.0690353598),
      (c_professional > 1.65) => -0.0041733931,
      (c_professional = NULL) => 0.0219200881, 0.0219200881),
   (f_srchaddrsrchcount_i = NULL) => -0.0187364698, -0.0136652237),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 82096.5) => 0.2184476867,
   (r_L80_Inp_AVM_AutoVal_d > 82096.5) => 0.0599586221,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0338154787, 0.0585276476),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0100513118, -0.0100513118);

// Tree: 22 
woFDN_FLA_SD_lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 32.95) => 
         map(
         (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 5.5) => 0.0023349571,
         (f_rel_under100miles_cnt_d > 5.5) => 0.2452019309,
         (f_rel_under100miles_cnt_d = NULL) => 0.1005152231, 0.1005152231),
      (c_fammar_p > 32.95) => -0.0268107649,
      (c_fammar_p = NULL) => -0.0445535285, -0.0250345603),
   (f_hh_lienholders_i > 0.5) => 0.0236015111,
   (f_hh_lienholders_i = NULL) => -0.0103864626, -0.0103864626),
(f_assocrisktype_i > 8.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 0.2038854941,
   (r_C12_Num_NonDerogs_d > 1.5) => 0.0585969773,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0785194829, 0.0785194829),
(f_assocrisktype_i = NULL) => -0.0072995385, -0.0061674902);

// Tree: 23 
woFDN_FLA_SD_lgt_23 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 0.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 4.5) => 0.0575003662,
      (f_rel_educationover12_count_d > 4.5) => 0.3685086517,
      (f_rel_educationover12_count_d = NULL) => 0.2174474845, 0.2174474845),
   (f_util_adl_count_n > 0.5) => 0.0145658320,
   (f_util_adl_count_n = NULL) => 0.1041922648, 0.1041922648),
(r_F00_input_dob_match_level_d > 4.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 29.5) => -0.0154291881,
      (f_addrchangecrimediff_i > 29.5) => 0.0690060557,
      (f_addrchangecrimediff_i = NULL) => 0.0092316928, -0.0079524681),
   (r_D33_eviction_count_i > 3.5) => 0.1278443123,
   (r_D33_eviction_count_i = NULL) => -0.0070721000, -0.0070721000),
(r_F00_input_dob_match_level_d = NULL) => 0.0229056191, -0.0046611668);

// Tree: 24 
woFDN_FLA_SD_lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => -0.0156074083,
   (c_unemp > 8.95) => 0.0752014587,
   (c_unemp = NULL) => -0.0254146963, -0.0117549734),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 60.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 76922) => 0.1570440304,
         (r_L80_Inp_AVM_AutoVal_d > 76922) => -0.0055841114,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0070779693, 0.0093106505),
      (k_comb_age_d > 60.5) => 0.1781532279,
      (k_comb_age_d = NULL) => 0.0270596007, 0.0270596007),
   (f_rel_felony_count_i > 0.5) => 0.1060400288,
   (f_rel_felony_count_i = NULL) => 0.0412131730, 0.0412131730),
(k_inq_per_addr_i = NULL) => -0.0060510327, -0.0060510327);

// Tree: 25 
woFDN_FLA_SD_lgt_25 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0161407801,
(f_assocrisktype_i > 3.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 7.5) => 0.0110012214,
      (r_D30_Derog_Count_i > 7.5) => 0.0924217919,
      (r_D30_Derog_Count_i = NULL) => 0.0162426334, 0.0162426334),
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 241991.5) => 0.1442198496,
      (f_curraddrmedianvalue_d > 241991.5) => 0.0247350887,
      (f_curraddrmedianvalue_d = NULL) => 0.0927397132, 0.0927397132),
   (f_phones_per_addr_curr_i = NULL) => 0.0254911549, 0.0254911549),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 97.5) => -0.0695884032,
   (c_burglary > 97.5) => 0.0955640774,
   (c_burglary = NULL) => 0.0129878371, 0.0129878371), -0.0056835206);

// Tree: 26 
woFDN_FLA_SD_lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62494) => 0.0768063773,
   (f_addrchangevaluediff_d > -62494) => -0.0087506743,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 5.5) => -0.0104991675,
      (f_phones_per_addr_curr_i > 5.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 51564.5) => 0.1458004505,
         (f_curraddrmedianincome_d > 51564.5) => 0.0203401005,
         (f_curraddrmedianincome_d = NULL) => 0.0677960063, 0.0677960063),
      (f_phones_per_addr_curr_i = NULL) => 0.0086709669, 0.0086709669), -0.0031282414),
(r_D30_Derog_Count_i > 11.5) => 0.1099556445,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 78) => -0.0646459363,
   (c_burglary > 78) => 0.0881838053,
   (c_burglary = NULL) => 0.0139522165, 0.0139522165), -0.0014392164);

// Tree: 27 
woFDN_FLA_SD_lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1312148297) => 0.0236676900,
      (f_add_curr_nhood_VAC_pct_i > 0.1312148297) => 0.1351501073,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0406696144, 0.0406696144),
   (f_srchcomponentrisktype_i > 2.5) => 0.1770674830,
   (f_srchcomponentrisktype_i = NULL) => 0.0483131665, 0.0483131665),
(c_fammar_p > 50.45) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0896444739,
      (r_F00_dob_score_d > 92) => -0.0174770895,
      (r_F00_dob_score_d = NULL) => -0.0080831909, -0.0143782332),
   (r_D33_eviction_count_i > 0.5) => 0.0672437276,
   (r_D33_eviction_count_i = NULL) => 0.0014451680, -0.0114731459),
(c_fammar_p = NULL) => -0.0111532928, -0.0065407931);

// Tree: 28 
woFDN_FLA_SD_lgt_28 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1351659746,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => -0.0094606143,
         (f_inq_PrepaidCards_count24_i > 0.5) => 
            map(
            (NULL < c_apt20 and c_apt20 <= 96.5) => 0.0058153935,
            (c_apt20 > 96.5) => 0.1531465890,
            (c_apt20 = NULL) => 0.0707112773, 0.0707112773),
         (f_inq_PrepaidCards_count24_i = NULL) => -0.0083408770, -0.0083408770),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0075297765, -0.0075297765),
   (r_D33_eviction_count_i > 2.5) => 0.1005734281,
   (r_D33_eviction_count_i = NULL) => -0.0106175961, -0.0063642735),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.2032534339,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0053727825, -0.0053727825);

// Tree: 29 
woFDN_FLA_SD_lgt_29 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 32.25) => 0.0000585868,
      (c_rnt1000_p > 32.25) => 0.1526827662,
      (c_rnt1000_p = NULL) => 0.0009382325, 0.0310564866),
   (k_inq_per_addr_i > 3.5) => 0.1925732938,
   (k_inq_per_addr_i = NULL) => 0.0443078655, 0.0443078655),
(f_corrssnaddrcount_d > 1.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 154.5) => -0.0251231187,
   (r_A50_pb_average_dollars_d > 154.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0024825832,
      (f_rel_felony_count_i > 0.5) => 0.0656360250,
      (f_rel_felony_count_i = NULL) => 0.0115331161, 0.0115331161),
   (r_A50_pb_average_dollars_d = NULL) => -0.0096231016, -0.0096231016),
(f_corrssnaddrcount_d = NULL) => -0.0106890652, -0.0068856731);

// Tree: 30 
woFDN_FLA_SD_lgt_30 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 92) => 0.1673162182,
(r_D32_Mos_Since_Fel_LS_d > 92) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6762.5) => -0.0203997948,
      (f_addrchangeincomediff_d > 6762.5) => 0.0466487046,
      (f_addrchangeincomediff_d = NULL) => 0.0007230924, -0.0133518891),
   (k_inq_per_ssn_i > 3.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => 0.0079535106,
         (k_comb_age_d > 63.5) => 0.2089414036,
         (k_comb_age_d = NULL) => 0.0289733960, 0.0289733960),
      (f_varrisktype_i > 4.5) => 0.0997676977,
      (f_varrisktype_i = NULL) => 0.0387900148, 0.0387900148),
   (k_inq_per_ssn_i = NULL) => -0.0092365192, -0.0092365192),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0005747634, -0.0082792314);

// Tree: 31 
woFDN_FLA_SD_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1198833265,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 8.35) => -0.0126017007,
         (c_unemp > 8.35) => 0.0445211309,
         (c_unemp = NULL) => -0.0386379835, -0.0093530144),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0086808841, -0.0086808841),
   (k_comb_age_d > 69.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 59.45) => 0.1760648026,
      (c_fammar_p > 59.45) => 0.0668093259,
      (c_fammar_p = NULL) => 0.0794481343, 0.0794481343),
   (k_comb_age_d = NULL) => -0.0030998019, -0.0030998019),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1605163904,
(f_inq_PrepaidCards_count_i = NULL) => 0.0032337267, -0.0023488654);

// Tree: 32 
woFDN_FLA_SD_lgt_32 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 18.5) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 4.255) => -0.0112238808,
      (c_hhsize > 4.255) => 0.1454796324,
      (c_hhsize = NULL) => -0.0122053350, -0.0097456647),
   (f_srchaddrsrchcount_i > 18.5) => 0.0721929308,
   (f_srchaddrsrchcount_i = NULL) => -0.0085418445, -0.0085418445),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => 0.0204818231,
   (f_rel_under100miles_cnt_d > 8.5) => 0.1010942279,
   (f_rel_under100miles_cnt_d = NULL) => 0.0487070485, 0.0487070485),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0735694945,
   (k_comb_age_d > 27.5) => 0.0977566827,
   (k_comb_age_d = NULL) => 0.0251608449, 0.0251608449), -0.0031194823);

// Tree: 33 
woFDN_FLA_SD_lgt_33 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 24.45) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0223258308,
   (f_corrrisktype_i > 6.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 15.5) => 0.1579079799,
      (r_D32_Mos_Since_Crim_LS_d > 15.5) => 0.0122386624,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0168159933, 0.0168159933),
   (f_corrrisktype_i = NULL) => -0.0574883924, -0.0102447884),
(c_famotf18_p > 24.45) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 4.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 1.5) => 0.0616152330,
      (k_inq_per_addr_i > 1.5) => 0.2135482962,
      (k_inq_per_addr_i = NULL) => 0.1107155522, 0.1107155522),
   (f_prevaddrageoldest_d > 4.5) => 0.0187797492,
   (f_prevaddrageoldest_d = NULL) => 0.0289056536, 0.0289056536),
(c_famotf18_p = NULL) => -0.0282470747, -0.0059789207);

// Tree: 34 
woFDN_FLA_SD_lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1034403079,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
      map(
      (NULL < c_unempl and c_unempl <= 125.5) => 0.0419797338,
      (c_unempl > 125.5) => 0.1645318733,
      (c_unempl = NULL) => 0.0757997605, 0.0757997605),
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 5.35) => -0.0106543388,
      (c_hh7p_p > 5.35) => 0.0469661248,
      (c_hh7p_p = NULL) => 0.0055801550, -0.0060506211),
   (r_F00_dob_score_d = NULL) => 0.0280984854, -0.0024663125),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0672246736,
   (f_addrs_per_ssn_i > 5.5) => 0.0666347527,
   (f_addrs_per_ssn_i = NULL) => -0.0034225171, -0.0034225171), -0.0018398569);

// Tree: 35 
woFDN_FLA_SD_lgt_35 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0133040790,
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 0.0201845943,
      (k_comb_age_d > 66.5) => 0.1986633373,
      (k_comb_age_d = NULL) => 0.0290179331, 0.0290179331),
   (f_srchvelocityrisktype_i = NULL) => -0.0078427271, -0.0078427271),
(f_hh_tot_derog_i > 5.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 53.5) => 
      map(
      (NULL < r_C20_email_count_i and r_C20_email_count_i <= 1.5) => 0.2847453395,
      (r_C20_email_count_i > 1.5) => 0.0258544933,
      (r_C20_email_count_i = NULL) => 0.1679007983, 0.1679007983),
   (c_no_teens > 53.5) => 0.0263066514,
   (c_no_teens = NULL) => 0.0706283650, 0.0706283650),
(f_hh_tot_derog_i = NULL) => 0.0100443348, -0.0054195804);

// Tree: 36 
woFDN_FLA_SD_lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0192664999,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 80) => 0.1569202819,
   (r_F00_dob_score_d > 80) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0003166872,
         (f_varrisktype_i > 2.5) => 0.0629284703,
         (f_varrisktype_i = NULL) => 0.0061660565, 0.0061660565),
      (k_inq_per_addr_i > 6.5) => 
         map(
         (NULL < c_for_sale and c_for_sale <= 102.5) => 0.1464025677,
         (c_for_sale > 102.5) => 0.0282197668,
         (c_for_sale = NULL) => 0.0802428179, 0.0802428179),
      (k_inq_per_addr_i = NULL) => 0.0101549499, 0.0101549499),
   (r_F00_dob_score_d = NULL) => 0.0019592386, 0.0119102932),
(f_hh_criminals_i = NULL) => -0.0087949569, -0.0091120329);

// Tree: 37 
woFDN_FLA_SD_lgt_37 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0165658688,
   (f_crim_rel_under100miles_cnt_i > 0.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6643.5) => 0.0062860323,
      (f_addrchangeincomediff_d > 6643.5) => 0.1052532762,
      (f_addrchangeincomediff_d = NULL) => 0.0404339239, 0.0169330803),
   (f_crim_rel_under100miles_cnt_i = NULL) => 0.0105550881, -0.0007003701),
(f_srchcomponentrisktype_i > 3.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1895.5) => 0.0385944530,
   (c_popover18 > 1895.5) => 0.2156319545,
   (c_popover18 = NULL) => 0.0714728462, 0.0714728462),
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0841818238,
   (r_S66_adlperssn_count_i > 1.5) => 0.0718636271,
   (r_S66_adlperssn_count_i = NULL) => 0.0023746373, 0.0023746373), 0.0009408298);

// Tree: 38 
woFDN_FLA_SD_lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 95.5) => 0.1569253798,
      (c_rest_indx > 95.5) => -0.0006302632,
      (c_rest_indx = NULL) => 0.0645456323, 0.0645456323),
   (r_F00_input_dob_match_level_d > 5.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4) => 0.0233950301,
         (f_srchvelocityrisktype_i > 4) => 0.1984158354,
         (f_srchvelocityrisktype_i = NULL) => 0.0684761466, 0.0684761466),
      (r_D32_Mos_Since_Crim_LS_d > 9.5) => -0.0082300851,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0069864040, -0.0069864040),
   (r_F00_input_dob_match_level_d = NULL) => -0.0052936087, -0.0052936087),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1077489403,
(f_inq_PrepaidCards_count_i = NULL) => 0.0101732427, -0.0045547218);

// Tree: 39 
woFDN_FLA_SD_lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0051932026,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 100.5) => 
            map(
            (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.3031350436,
            (f_curraddractivephonelist_d > 0.5) => 0.1036153574,
            (f_curraddractivephonelist_d = NULL) => 0.2092434266, 0.2092434266),
         (c_medi_indx > 100.5) => 0.0176681410,
         (c_medi_indx = NULL) => 0.1059779381, 0.1059779381),
      (f_inq_count_i > 2.5) => 0.0117706984,
      (f_inq_count_i = NULL) => 0.0293051503, 0.0293051503),
   (k_comb_age_d > 69.5) => 0.2614591533,
   (k_comb_age_d = NULL) => 0.0390672109, 0.0390672109),
(k_inq_per_ssn_i = NULL) => 0.0001173492, 0.0001173492);

// Tree: 40 
woFDN_FLA_SD_lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 28.5) => 0.0051451668,
   (r_pb_order_freq_d > 28.5) => -0.0282330528,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.0045894272,
      (f_assocrisktype_i > 7.5) => 0.0762016231,
      (f_assocrisktype_i = NULL) => 0.0099734985, 0.0099734985), -0.0062522416),
(f_addrchangecrimediff_i > 98.5) => 0.1025136708,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => -0.0004644370,
   (r_L79_adls_per_addr_c6_i > 4.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 46521) => 0.1269490639,
      (f_curraddrmedianincome_d > 46521) => 0.0135223363,
      (f_curraddrmedianincome_d = NULL) => 0.0649600384, 0.0649600384),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0036575111, 0.0036575111), -0.0033000540);

// Tree: 41 
woFDN_FLA_SD_lgt_41 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 
      map(
      (NULL < c_construction and c_construction <= 5) => 0.1863848099,
      (c_construction > 5) => 0.0204749479,
      (c_construction = NULL) => 0.0967399651, 0.0967399651),
   (r_I60_inq_comm_recency_d > 4.5) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1335482568,
      (f_attr_arrest_recency_d > 48) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 36.5) => -0.0111947393,
         (r_pb_order_freq_d > 36.5) => -0.0313290539,
         (r_pb_order_freq_d = NULL) => 0.0082304386, -0.0114223445),
      (f_attr_arrest_recency_d = NULL) => -0.0107803134, -0.0107803134),
   (r_I60_inq_comm_recency_d = NULL) => -0.0031430928, -0.0096383921),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1462817476,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0090237590, -0.0090237590);

// Tree: 42 
woFDN_FLA_SD_lgt_42 := map(
(NULL < c_business and c_business <= 5.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 8.5) => 0.0247081184,
   (f_srchaddrsrchcount_i > 8.5) => 0.0992396950,
   (f_srchaddrsrchcount_i = NULL) => 0.0319124009, 0.0319124009),
(c_business > 5.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1321831820,
   (r_D32_Mos_Since_Fel_LS_d > 125) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 75.5) => -0.0235729938,
      (f_prevaddrageoldest_d > 75.5) => 
         map(
         (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 47.5) => 0.0074478077,
         (f_bus_addr_match_count_d > 47.5) => 0.3047475962,
         (f_bus_addr_match_count_d = NULL) => 0.0107580784, 0.0107580784),
      (f_prevaddrageoldest_d = NULL) => -0.0080509665, -0.0080509665),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0176226645, -0.0073455870),
(c_business = NULL) => -0.0410166508, -0.0027559771);

// Tree: 43 
woFDN_FLA_SD_lgt_43 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -108.5) => 0.1700963680,
(f_addrchangecrimediff_i > -108.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 35.5) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => 0.0289075327,
      (r_F03_address_match_d > 3) => -0.0098527514,
      (r_F03_address_match_d = NULL) => -0.0066800574, -0.0066800574),
   (f_rel_under25miles_cnt_d > 35.5) => 0.1408398181,
   (f_rel_under25miles_cnt_d = NULL) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 11.5) => 0.1420171526,
      (f_M_Bureau_ADL_FS_all_d > 11.5) => -0.0368161338,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0163228999, 0.0163228999), -0.0054572991),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => -0.0051406175,
   (f_srchunvrfddobcount_i > 0.5) => 0.1089095147,
   (f_srchunvrfddobcount_i = NULL) => 0.0054636314, -0.0007450082), -0.0036339573);

// Tree: 44 
woFDN_FLA_SD_lgt_44 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 6.5) => 0.0127934532,
   (f_rel_homeover100_count_d > 6.5) => 
      map(
      (NULL < c_employees and c_employees <= 85.5) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 24.85) => 0.2786736644,
         (c_lowrent > 24.85) => 0.0220260475,
         (c_lowrent = NULL) => 0.1667521473, 0.1667521473),
      (c_employees > 85.5) => 0.0379515080,
      (c_employees = NULL) => 0.0726286032, 0.0726286032),
   (f_rel_homeover100_count_d = NULL) => 0.0393985375, 0.0393985375),
(f_corrssnaddrcount_d > 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0904949502,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0092242342,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0087429217, -0.0087429217),
(f_corrssnaddrcount_d = NULL) => 0.0128095062, -0.0040672706);

// Tree: 45 
woFDN_FLA_SD_lgt_45 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 2.05) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 295.5) => 0.0009747713,
      (r_C10_M_Hdr_FS_d > 295.5) => 0.1342680026,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0360109595, 0.0360109595),
   (f_corrssnaddrcount_d > 2.5) => -0.0123698391,
   (f_corrssnaddrcount_d = NULL) => 0.0115195173, -0.0078662297),
(c_hh7p_p > 2.05) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 11.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 0.0159097660,
      (k_comb_age_d > 68.5) => 0.1598007304,
      (k_comb_age_d = NULL) => 0.0241321068, 0.0241321068),
   (k_inq_per_addr_i > 11.5) => 0.1443633089,
   (k_inq_per_addr_i = NULL) => 0.0267505722, 0.0267505722),
(c_hh7p_p = NULL) => -0.0497779837, -0.0013193449);

// Tree: 46 
woFDN_FLA_SD_lgt_46 := map(
(NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 218.4) => 
      map(
      (NULL < c_unempl and c_unempl <= 186.5) => -0.0120808524,
      (c_unempl > 186.5) => 0.0801537678,
      (c_unempl = NULL) => -0.0105461165, -0.0105461165),
   (c_cpiall > 218.4) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 71703.5) => 0.1723146360,
      (r_A46_Curr_AVM_AutoVal_d > 71703.5) => 0.0272349797,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0203056826, 0.0276488227),
   (c_cpiall = NULL) => 0.0015816959, -0.0011809435),
(f_attr_arrests_i > 0.5) => 
   map(
   (NULL < c_rich_old and c_rich_old <= 133.5) => 0.1799086345,
   (c_rich_old > 133.5) => -0.0215941524,
   (c_rich_old = NULL) => 0.0963586985, 0.0963586985),
(f_attr_arrests_i = NULL) => -0.0154017918, -0.0003551063);

// Tree: 47 
woFDN_FLA_SD_lgt_47 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0064374692,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
         map(
         (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.27334196835) => 0.2148761221,
         (f_add_input_mobility_index_i > 0.27334196835) => 0.0208794478,
         (f_add_input_mobility_index_i = NULL) => 0.1346429296, 0.1346429296),
      (r_D30_Derog_Count_i > 0.5) => 0.0186104431,
      (r_D30_Derog_Count_i = NULL) => 0.0499238459, 0.0499238459),
   (f_hh_tot_derog_i = NULL) => -0.0036147300, -0.0036147300),
(f_srchcomponentrisktype_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 57.5) => 0.0305929180,
   (k_comb_age_d > 57.5) => 0.1963156693,
   (k_comb_age_d = NULL) => 0.0532204475, 0.0532204475),
(f_srchcomponentrisktype_i = NULL) => 0.0009151696, -0.0012473724);

// Tree: 48 
woFDN_FLA_SD_lgt_48 := map(
(NULL < c_employees and c_employees <= 31.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 218) => 0.0032314279,
   (r_A50_pb_average_dollars_d > 218) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.15) => 0.0438371686,
      (c_unemp > 9.15) => 0.1490281344,
      (c_unemp = NULL) => 0.0601019902, 0.0601019902),
   (r_A50_pb_average_dollars_d = NULL) => 0.0286926654, 0.0286926654),
(c_employees > 31.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0078996436,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0346414096,
      (f_addrs_per_ssn_i > 5.5) => 0.2696419504,
      (f_addrs_per_ssn_i = NULL) => 0.1154717147, 0.1154717147),
   (f_nae_nothing_found_i = NULL) => -0.0062280960, -0.0062280960),
(c_employees = NULL) => 0.0117519222, -0.0021534832);

// Tree: 49 
woFDN_FLA_SD_lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => -0.0012760735,
      (f_hh_criminals_i > 3.5) => 0.1279026576,
      (f_hh_criminals_i = NULL) => 0.0001913574, 0.0001913574),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 33) => 0.1426615145,
      (r_C10_M_Hdr_FS_d > 33) => 0.0312378244,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0561147834, 0.0561147834),
   (f_varrisktype_i = NULL) => 0.0026619074, 0.0026619074),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0754836406,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0783074377,
   (k_comb_age_d > 27.5) => 0.0928853687,
   (k_comb_age_d = NULL) => 0.0097345770, 0.0097345770), -0.0004521901);

// Tree: 50 
woFDN_FLA_SD_lgt_50 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 153.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0171205373,
   (f_nae_nothing_found_i > 0.5) => 0.2199273772,
   (f_nae_nothing_found_i = NULL) => -0.0149813570, -0.0149813570),
(r_A50_pb_average_dollars_d > 153.5) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 0.0137915150,
   (f_hh_members_w_derog_i > 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 85.5) => 0.2501450182,
      (c_easiqlife > 85.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 1.45) => -0.0750577957,
         (c_rnt1000_p > 1.45) => 0.1158799167,
         (c_rnt1000_p = NULL) => 0.0505851550, 0.0505851550),
      (c_easiqlife = NULL) => 0.0960848038, 0.0960848038),
   (f_hh_members_w_derog_i = NULL) => 0.0176344705, 0.0176344705),
(r_A50_pb_average_dollars_d = NULL) => 0.0268735026, -0.0005197208);

// Tree: 51 
woFDN_FLA_SD_lgt_51 := map(
(NULL < c_employees and c_employees <= 71.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 32338.5) => 0.0742526230,
   (f_curraddrmedianincome_d > 32338.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 2.5) => 0.1291563867,
      (f_prevaddrageoldest_d > 2.5) => 0.0078113097,
      (f_prevaddrageoldest_d = NULL) => 0.0117015999, 0.0117015999),
   (f_curraddrmedianincome_d = NULL) => 0.0199319976, 0.0199319976),
(c_employees > 71.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 6.1) => -0.0302729895,
      (c_hval_175k_p > 6.1) => 0.1380328103,
      (c_hval_175k_p = NULL) => 0.0642144770, 0.0642144770),
   (r_D33_Eviction_Recency_d > 48) => -0.0105772032,
   (r_D33_Eviction_Recency_d = NULL) => -0.0400946293, -0.0099594770),
(c_employees = NULL) => -0.0121646893, -0.0037736051);

// Tree: 52 
woFDN_FLA_SD_lgt_52 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0089459680,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < c_murders and c_murders <= 131) => 0.0272458003,
      (c_murders > 131) => 
         map(
         (NULL < c_retired and c_retired <= 12.7) => 0.3489452322,
         (c_retired > 12.7) => 0.0398833933,
         (c_retired = NULL) => 0.1690435648, 0.1690435648),
      (c_murders = NULL) => 0.0576472410, 0.0576472410),
   (k_comb_age_d = NULL) => -0.0052068083, -0.0052068083),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.45) => 0.0271052699,
   (c_unemp > 9.45) => 0.1442090818,
   (c_unemp = NULL) => 0.0344433678, 0.0344433678),
(f_phones_per_addr_curr_i = NULL) => 0.0157348588, -0.0013980371);

// Tree: 53 
woFDN_FLA_SD_lgt_53 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 134.5) => 
      map(
      (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0162543394,
      (r_D32_felony_count_i > 0.5) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 4.5) => -0.0119171297,
         (c_hval_125k_p > 4.5) => 0.1916993504,
         (c_hval_125k_p = NULL) => 0.0889396315, 0.0889396315),
      (r_D32_felony_count_i = NULL) => 0.0005639017, -0.0147290354),
   (c_easiqlife > 134.5) => 
      map(
      (NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 0.0195442956,
      (f_attr_arrests_i > 0.5) => 0.1291958154,
      (f_attr_arrests_i = NULL) => 0.0212757714, 0.0212757714),
   (c_easiqlife = NULL) => -0.0139895593, -0.0025153559),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1155046344,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0020408569, -0.0020408569);

// Tree: 54 
woFDN_FLA_SD_lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1390569825,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_unempl and c_unempl <= 190.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 218.4) => -0.0124373251,
      (c_cpiall > 218.4) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','6: Other']) => 0.0035106325,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly']) => 0.0685566163,
         (nf_seg_FraudPoint_3_0 = '') => 0.0191439065, 0.0191439065),
      (c_cpiall = NULL) => -0.0048156169, -0.0048156169),
   (c_unempl > 190.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 140.5) => -0.0166984576,
      (f_fp_prevaddrburglaryindex_i > 140.5) => 0.1508930210,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0697574639, 0.0697574639),
   (c_unempl = NULL) => -0.0124490610, -0.0042452840),
(f_attr_arrest_recency_d = NULL) => 0.0102581885, -0.0035718158);

// Tree: 55 
woFDN_FLA_SD_lgt_55 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 40627.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 79.5) => 
         map(
         (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
            map(
            (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => 0.1618847670,
            (k_comb_age_d > 24.5) => 0.0356350666,
            (k_comb_age_d = NULL) => 0.0624276076, 0.0624276076),
         (r_I60_inq_comm_recency_d > 549) => 0.0057766758,
         (r_I60_inq_comm_recency_d = NULL) => 0.0134368670, 0.0134368670),
      (k_comb_age_d > 79.5) => 0.2502821049,
      (k_comb_age_d = NULL) => 0.0185747262, 0.0185747262),
   (f_curraddrmedianincome_d > 40627.5) => -0.0125180576,
   (f_curraddrmedianincome_d = NULL) => -0.0327584127, -0.0069106942),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1224123494,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0063805146, -0.0063805146);

// Tree: 56 
woFDN_FLA_SD_lgt_56 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00563981495) => 0.1732951172,
   (f_add_curr_nhood_MFD_pct_i > 0.00563981495) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 163.5) => 0.0071160312,
      (c_rich_wht > 163.5) => 
         map(
         (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => 0.0412245948,
         (f_phones_per_addr_c6_i > 0.5) => 0.2253448827,
         (f_phones_per_addr_c6_i = NULL) => 0.1062082258, 0.1062082258),
      (c_rich_wht = NULL) => 0.0253824237, 0.0253824237),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < c_unattach and c_unattach <= 112.5) => -0.0417379680,
      (c_unattach > 112.5) => 0.0906849943,
      (c_unattach = NULL) => 0.0485687118, 0.0117358102), 0.0304806621),
(f_corrssnaddrcount_d > 2.5) => -0.0045576321,
(f_corrssnaddrcount_d = NULL) => -0.0021257521, -0.0012538415);

// Tree: 57 
woFDN_FLA_SD_lgt_57 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 19.5) => 0.1889449141,
      (r_C13_max_lres_d > 19.5) => 0.0202834504,
      (r_C13_max_lres_d = NULL) => 0.0903611008, 0.0903611008),
   (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 34.5) => 0.0279388119,
      (c_born_usa > 34.5) => -0.0116441113,
      (c_born_usa = NULL) => -0.0198119297, -0.0037808077),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0026687412, -0.0026687412),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0600424027,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0963364325,
   (k_comb_age_d > 25.5) => 0.0555869664,
   (k_comb_age_d = NULL) => -0.0079219955, -0.0079219955), -0.0051707059);

// Tree: 58 
woFDN_FLA_SD_lgt_58 := map(
(NULL < c_hh1_p and c_hh1_p <= 32.05) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.1) => 0.2035376603,
      (r_C12_source_profile_d > 60.1) => 0.0098189915,
      (r_C12_source_profile_d = NULL) => 0.0972495411, 0.0972495411),
   (f_mos_liens_unrel_SC_fseen_d > 66.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.3434018939) => 0.0026633386,
      (f_add_curr_nhood_MFD_pct_i > 0.3434018939) => 
         map(
         (NULL < c_young and c_young <= 28.55) => 0.0660887534,
         (c_young > 28.55) => -0.0262156372,
         (c_young = NULL) => 0.0342217614, 0.0342217614),
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0130087826, 0.0050227452),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0012747056, 0.0061396105),
(c_hh1_p > 32.05) => -0.0252677916,
(c_hh1_p = NULL) => -0.0331409691, -0.0032490080);

// Tree: 59 
woFDN_FLA_SD_lgt_59 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => -0.0132886375,
(r_L79_adls_per_addr_curr_i > 3.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 9.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 1.9) => -0.0114501779,
      (c_hval_250k_p > 1.9) => 0.1649025824,
      (c_hval_250k_p = NULL) => 0.0775992357, 0.0775992357),
   (r_C10_M_Hdr_FS_d > 9.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0033766545,
      (f_srchvelocityrisktype_i > 4.5) => 0.0495626141,
      (f_srchvelocityrisktype_i = NULL) => 0.0101233410, 0.0101233410),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0119590560, 0.0119590560),
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 89) => -0.0954409799,
   (c_assault > 89) => 0.0559864666,
   (c_assault = NULL) => -0.0226393229, -0.0226393229), -0.0058342274);

// Tree: 60 
woFDN_FLA_SD_lgt_60 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => -0.0052571796,
(k_inq_per_ssn_i > 3.5) => 
   map(
   (NULL < f_inq_Mortgage_count24_i and f_inq_Mortgage_count24_i <= 0.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2201148299) => 
         map(
         (NULL < c_high_hval and c_high_hval <= 1) => 0.2227113640,
         (c_high_hval > 1) => 
            map(
            (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => 0.2000731990,
            (f_inq_count_i > 5.5) => -0.0403793075,
            (f_inq_count_i = NULL) => 0.0564936448, 0.0564936448),
         (c_high_hval = NULL) => 0.1017466364, 0.1017466364),
      (f_add_curr_mobility_index_i > 0.2201148299) => 0.0234272784,
      (f_add_curr_mobility_index_i = NULL) => 0.0425126775, 0.0425126775),
   (f_inq_Mortgage_count24_i > 0.5) => -0.0968976527,
   (f_inq_Mortgage_count24_i = NULL) => 0.0252770459, 0.0252770459),
(k_inq_per_ssn_i = NULL) => -0.0030570785, -0.0030570785);

// Tree: 61 
woFDN_FLA_SD_lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 8.95) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0177409879) => 0.0041263747,
      (f_add_curr_nhood_BUS_pct_i > 0.0177409879) => 0.1271807557,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0859295712, 0.0859295712),
   (c_low_hval > 8.95) => -0.0499136058,
   (c_low_hval = NULL) => 0.0515460285, 0.0515460285),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0032246287,
   (c_lar_fam > 181.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.0125950126,
      (k_inq_per_ssn_i > 0.5) => 0.2039435867,
      (k_inq_per_ssn_i = NULL) => 0.0981220268, 0.0981220268),
   (c_lar_fam = NULL) => -0.0260517439, -0.0026305966),
(r_D33_Eviction_Recency_d = NULL) => -0.0144020990, -0.0016850026);

// Tree: 62 
woFDN_FLA_SD_lgt_62 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0065683098,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 241.75) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1964.5) => -0.0596179851,
         (c_med_yearblt > 1964.5) => 0.0348545495,
         (c_med_yearblt = NULL) => 0.0096881708, 0.0096881708),
      (c_housingcpi > 241.75) => 0.1040821175,
      (c_housingcpi = NULL) => 0.0238003340, 0.0238003340),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 9.85) => 0.0241633853,
      (C_INC_35K_P > 9.85) => 0.1670516606,
      (C_INC_35K_P = NULL) => 0.0956075230, 0.0956075230),
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0277261743, 0.0277261743),
(f_prevaddrageoldest_d = NULL) => 0.0298718292, 0.0018495353);

// Tree: 63 
woFDN_FLA_SD_lgt_63 := map(
(NULL < f_mos_liens_rel_SC_fseen_d and f_mos_liens_rel_SC_fseen_d <= 273) => -0.1015727420,
(f_mos_liens_rel_SC_fseen_d > 273) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0034654305,
   (c_hval_200k_p > 16.45) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0233327919,
      (f_assocrisktype_i > 4.5) => 
         map(
         (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 4.5) => 0.2043717660,
         (f_rel_criminal_count_i > 4.5) => 0.0121251491,
         (f_rel_criminal_count_i = NULL) => 0.1229496694, 0.1229496694),
      (f_assocrisktype_i = NULL) => 0.0391597724, 0.0391597724),
   (c_hval_200k_p = NULL) => 0.0231694974, 0.0007699715),
(f_mos_liens_rel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.85) => -0.0747060700,
   (c_pop_35_44_p > 15.85) => 0.0303792554,
   (c_pop_35_44_p = NULL) => -0.0212574993, -0.0212574993), -0.0004809181);

// Tree: 64 
woFDN_FLA_SD_lgt_64 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1027827491) => 0.0158967027,
      (f_add_curr_nhood_VAC_pct_i > 0.1027827491) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 86756.5) => 0.0392258080,
         (c_med_hval > 86756.5) => 0.2434560407,
         (c_med_hval = NULL) => 0.1148175175, 0.1148175175),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0376620724, 0.0376620724),
   (k_estimated_income_d > 28500) => -0.0081066557,
   (k_estimated_income_d = NULL) => -0.0088285391, -0.0053691087),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 1.95) => 0.1605560666,
   (C_INC_150K_P > 1.95) => 0.0383854055,
   (C_INC_150K_P = NULL) => 0.0530693792, 0.0530693792),
(k_comb_age_d = NULL) => -0.0014117843, -0.0014117843);

// Tree: 65 
woFDN_FLA_SD_lgt_65 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0049739805,
(f_prevaddrageoldest_d > 151.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.2656152588,
      (f_adl_per_email_i > 0.5) => -0.0775017776,
      (f_adl_per_email_i = NULL) => 0.0198168345, 0.0228003779),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 56) => -0.0149719290,
      (f_prevaddrcartheftindex_i > 56) => 0.1462707559,
      (f_prevaddrcartheftindex_i = NULL) => 0.0860598799, 0.0860598799),
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0261398371, 0.0261398371),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0933733754,
   (k_comb_age_d > 25.5) => 0.0763403074,
   (k_comb_age_d = NULL) => 0.0038130925, 0.0038130925), 0.0024483091);

// Tree: 66 
woFDN_FLA_SD_lgt_66 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 132.5) => -0.0193731401,
   (c_span_lang > 132.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 4646.5) => 0.0020228846,
      (f_addrchangeincomediff_d > 4646.5) => 
         map(
         (NULL < c_rental and c_rental <= 98.5) => -0.0112805684,
         (c_rental > 98.5) => 0.1578390342,
         (c_rental = NULL) => 0.0782533389, 0.0782533389),
      (f_addrchangeincomediff_d = NULL) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 11.5) => 0.0230937111,
         (f_srchaddrsrchcount_i > 11.5) => 0.1400993015,
         (f_srchaddrsrchcount_i = NULL) => 0.0307026636, 0.0307026636), 0.0112713239),
   (c_span_lang = NULL) => -0.0078763440, -0.0078763440),
(c_hh3_p > 23.25) => 0.0361801959,
(c_hh3_p = NULL) => -0.0059346001, -0.0011362345);

// Tree: 67 
woFDN_FLA_SD_lgt_67 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0304840636,
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 20.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.75) => 0.0407429753,
      (c_incollege > 6.75) => 0.2166537560,
      (c_incollege = NULL) => 0.1098042448, 0.1098042448),
   (k_comb_age_d > 20.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 27.85) => -0.0016931427,
      (c_hval_750k_p > 27.85) => 
         map(
         (NULL < c_business and c_business <= 1.5) => 0.1957772175,
         (c_business > 1.5) => 0.0412422458,
         (c_business = NULL) => 0.0471858986, 0.0471858986),
      (c_hval_750k_p = NULL) => -0.0118983605, 0.0047033388),
   (k_comb_age_d = NULL) => 0.0060655539, 0.0060655539),
(f_addrs_per_ssn_i = NULL) => -0.0002503122, -0.0002503122);

// Tree: 68 
woFDN_FLA_SD_lgt_68 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 306.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.38172203545) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 325.5) => 0.0021437569,
      (f_prevaddrageoldest_d > 325.5) => 0.1647644399,
      (f_prevaddrageoldest_d = NULL) => 0.0033719082, 0.0033719082),
   (f_add_input_mobility_index_i > 0.38172203545) => -0.0287208621,
   (f_add_input_mobility_index_i = NULL) => -0.0207861867, -0.0023610173),
(r_C13_Curr_Addr_LRes_d > 306.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0359785943,
   (f_corrrisktype_i > 6.5) => 0.2073104662,
   (f_corrrisktype_i = NULL) => 0.0564328486, 0.0564328486),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0950878429,
   (f_addrs_per_ssn_i > 3.5) => 0.0563282995,
   (f_addrs_per_ssn_i = NULL) => -0.0264976246, -0.0264976246), 0.0010269557);

// Tree: 69 
woFDN_FLA_SD_lgt_69 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => -0.0065986101,
   (f_inq_Communications_count24_i > 2.5) => 0.0898798064,
   (f_inq_Communications_count24_i = NULL) => -0.0060853850, -0.0060853850),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 2.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 11.7) => 0.1137645910,
      (C_INC_75K_P > 11.7) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 11.15) => -0.0340301318,
         (c_hval_175k_p > 11.15) => 0.0838764358,
         (c_hval_175k_p = NULL) => -0.0018737951, -0.0018737951),
      (C_INC_75K_P = NULL) => 0.0179272984, 0.0179272984),
   (f_inq_Banking_count24_i > 2.5) => 0.1389208987,
   (f_inq_Banking_count24_i = NULL) => 0.0360934763, 0.0360934763),
(f_varrisktype_i = NULL) => -0.0050091385, -0.0049020382);

// Tree: 70 
woFDN_FLA_SD_lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 4.75) => -0.0854749127,
   (c_pop_35_44_p > 4.75) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => -0.0070492861,
      (f_phones_per_addr_curr_i > 50.5) => 0.0803292024,
      (f_phones_per_addr_curr_i = NULL) => -0.0031609160, -0.0057328645),
   (c_pop_35_44_p = NULL) => -0.0076198795, -0.0076198795),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < c_med_inc and c_med_inc <= 45.5) => 0.1651425588,
   (c_med_inc > 45.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 0.0198963827,
      (k_inq_per_ssn_i > 2.5) => 0.1175325423,
      (k_inq_per_ssn_i = NULL) => 0.0346339162, 0.0346339162),
   (c_med_inc = NULL) => 0.0431630080, 0.0431630080),
(c_hval_750k_p = NULL) => 0.0159774149, -0.0032602125);

// Tree: 71 
woFDN_FLA_SD_lgt_71 := map(
(NULL < c_hhsize and c_hhsize <= 2.615) => -0.0098829226,
(c_hhsize > 2.615) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0100247645,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 3.5) => 0.1026798192,
      (f_corrssnaddrcount_d > 3.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 163.5) => -0.0016954738,
         (r_C13_Curr_Addr_LRes_d > 163.5) => 
            map(
            (NULL < c_for_sale and c_for_sale <= 118.5) => 0.2703120561,
            (c_for_sale > 118.5) => 0.0045948643,
            (c_for_sale = NULL) => 0.1632319937, 0.1632319937),
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0326751026, 0.0326751026),
      (f_corrssnaddrcount_d = NULL) => 0.0524980659, 0.0524980659),
   (f_rel_felony_count_i = NULL) => -0.0268399122, 0.0159811912),
(c_hhsize = NULL) => -0.0166042936, 0.0023277854);

// Tree: 72 
woFDN_FLA_SD_lgt_72 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => -0.0073144247,
         (k_comb_age_d > 73.5) => 
            map(
            (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.010485108) => 0.3340911352,
            (f_add_input_nhood_MFD_pct_i > 0.010485108) => 0.0373729169,
            (f_add_input_nhood_MFD_pct_i = NULL) => -0.0130501582, 0.0579569447),
         (k_comb_age_d = NULL) => -0.0046735698, -0.0046735698),
      (r_L72_Add_Vacant_i > 0.5) => 0.1140015034,
      (r_L72_Add_Vacant_i = NULL) => -0.0038913065, -0.0038913065),
   (f_assocsuspicousidcount_i > 15.5) => 0.0837830140,
   (f_assocsuspicousidcount_i = NULL) => -0.0034706380, -0.0034706380),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0912705910,
(f_inq_PrepaidCards_count_i = NULL) => -0.0088518240, -0.0031207762);

// Tree: 73 
woFDN_FLA_SD_lgt_73 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 190.5) => -0.0015673053,
   (f_curraddrcrimeindex_i > 190.5) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 0.1729562193,
      (r_I60_inq_recency_d > 4.5) => 0.0348955552,
      (r_I60_inq_recency_d = NULL) => 0.0586991179, 0.0586991179),
   (f_curraddrcrimeindex_i = NULL) => -0.0001528295, -0.0001528295),
(f_hh_collections_ct_i > 4.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 11.75) => -0.0468221799,
   (c_pop_45_54_p > 11.75) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 12.75) => 0.0327746921,
      (c_pop_25_34_p > 12.75) => 0.2190500411,
      (c_pop_25_34_p = NULL) => 0.1146830016, 0.1146830016),
   (c_pop_45_54_p = NULL) => 0.0600897008, 0.0600897008),
(f_hh_collections_ct_i = NULL) => 0.0051720017, 0.0009377312);

// Tree: 74 
woFDN_FLA_SD_lgt_74 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 1.5) => -0.0061919071,
   (f_vardobcountnew_i > 1.5) => 0.1127256772,
   (f_vardobcountnew_i = NULL) => -0.0053033191, -0.0053033191),
(f_prevaddroccupantowned_i > 0.5) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 3.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 3.55) => 0.1678812959,
      (c_pop_18_24_p > 3.55) => 
         map(
         (NULL < f_historical_count_d and f_historical_count_d <= 2.5) => 0.0332566109,
         (f_historical_count_d > 2.5) => -0.0728472289,
         (f_historical_count_d = NULL) => 0.0063897003, 0.0063897003),
      (c_pop_18_24_p = NULL) => 0.0242921972, 0.0242921972),
   (f_assoccredbureaucount_i > 3.5) => 0.1430613016,
   (f_assoccredbureaucount_i = NULL) => 0.0315172121, 0.0315172121),
(f_prevaddroccupantowned_i = NULL) => 0.0241623720, -0.0023396033);

// Tree: 75 
woFDN_FLA_SD_lgt_75 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0102419294,
   (k_inq_ssns_per_addr_i > 1.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -21849.5) => 0.1393374294,
      (f_addrchangevaluediff_d > -21849.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 6.5) => 0.0898848175,
         (f_prevaddrlenofres_d > 6.5) => 
            map(
            (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 97584.5) => 0.0716406554,
            (r_A46_Curr_AVM_AutoVal_d > 97584.5) => -0.0242718530,
            (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0206472059, -0.0102373261),
         (f_prevaddrlenofres_d = NULL) => 0.0005450586, 0.0005450586),
      (f_addrchangevaluediff_d = NULL) => 0.0414028812, 0.0129628650),
   (k_inq_ssns_per_addr_i = NULL) => -0.0071268459, -0.0071268459),
(f_bus_addr_match_count_d > 52.5) => 0.1547434376,
(f_bus_addr_match_count_d = NULL) => -0.0060932241, -0.0060932241);

// Tree: 76 
woFDN_FLA_SD_lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0107333052,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => 
         map(
         (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => -0.0037143326,
         (f_inq_Communications_count24_i > 1.5) => 0.1109316966,
         (f_inq_Communications_count24_i = NULL) => -0.0008767862, -0.0008767862),
      (f_prevaddrlenofres_d > 123.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0462602517,
         (f_rel_homeover500_count_d > 3.5) => 0.1807818626,
         (f_rel_homeover500_count_d = NULL) => 0.0679291382, 0.0679291382),
      (f_prevaddrlenofres_d = NULL) => 0.0177518920, 0.0177518920),
   (f_nae_nothing_found_i > 0.5) => 0.2118217952,
   (f_nae_nothing_found_i = NULL) => 0.0207850960, 0.0207850960),
(c_rnt1250_p = NULL) => 0.0021657142, -0.0017079775);

// Tree: 77 
woFDN_FLA_SD_lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => -0.0150707868,
   (c_pop_35_44_p > 14.75) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 0.0041422721,
      (f_divrisktype_i > 1.5) => 
         map(
         (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.1006532125,
         (f_prevaddrstatus_i > 2.5) => 0.0185544550,
         (f_prevaddrstatus_i = NULL) => 0.0313381325, 0.0497840836),
      (f_divrisktype_i = NULL) => 0.0105060103, 0.0105060103),
   (c_pop_35_44_p = NULL) => -0.0021899471, -0.0021899471),
(c_transport > 29.05) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.1730802305,
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0229589137,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0994770606, 0.0994770606),
(c_transport = NULL) => -0.0011633475, -0.0004904250);

// Tree: 78 
woFDN_FLA_SD_lgt_78 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0077904688,
      (f_corrrisktype_i > 7.5) => 0.0251331841,
      (f_corrrisktype_i = NULL) => -0.0018442136, -0.0018442136),
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 30.5) => 0.1450506198,
      (r_C10_M_Hdr_FS_d > 30.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => -0.0231874519,
         (k_inq_per_ssn_i > 3.5) => 0.0953717318,
         (k_inq_per_ssn_i = NULL) => 0.0252842586, 0.0252842586),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0562075404, 0.0562075404),
   (f_varrisktype_i = NULL) => -0.0006669672, -0.0006669672),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0583999343,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0200417635, -0.0029278133);

// Tree: 79 
woFDN_FLA_SD_lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30362.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 65619) => -0.0171383778,
      (f_prevaddrmedianvalue_d > 65619) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => 
            map(
            (NULL < c_retired and c_retired <= 12.2) => 0.0734516150,
            (c_retired > 12.2) => 0.2399631130,
            (c_retired = NULL) => 0.1519692320, 0.1519692320),
         (f_mos_inq_banko_cm_fseen_d > 41.5) => 0.0336459397,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0601486877, 0.0601486877),
      (f_prevaddrmedianvalue_d = NULL) => 0.0201885099, 0.0201885099),
   (f_curraddrmedianincome_d > 30362.5) => -0.0067155227,
   (f_curraddrmedianincome_d = NULL) => -0.0041939408, -0.0041939408),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0889644011,
(f_inq_PrepaidCards_count_i = NULL) => -0.0053440293, -0.0038291899);

// Tree: 80 
woFDN_FLA_SD_lgt_80 := map(
(NULL < c_bel_edu and c_bel_edu <= 196.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0089759684,
   (f_hh_lienholders_i > 0.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 2.55) => 0.1697678565,
         (c_hval_200k_p > 2.55) => 0.0105388675,
         (c_hval_200k_p = NULL) => 0.0872582895, 0.0872582895),
      (r_D32_Mos_Since_Crim_LS_d > 10.5) => 
         map(
         (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => -0.0407523485,
         (f_mos_inq_banko_om_fseen_d > 21.5) => 0.0211295599,
         (f_mos_inq_banko_om_fseen_d = NULL) => 0.0150550628, 0.0150550628),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0170811738, 0.0170811738),
   (f_hh_lienholders_i = NULL) => 0.0069060229, -0.0005066513),
(c_bel_edu > 196.5) => -0.0790474119,
(c_bel_edu = NULL) => 0.0344242428, -0.0005466796);

// Tree: 81 
woFDN_FLA_SD_lgt_81 := map(
(NULL < c_easiqlife and c_easiqlife <= 136.5) => -0.0160027025,
(c_easiqlife > 136.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 114.5) => 0.0001381907,
   (r_C13_Curr_Addr_LRes_d > 114.5) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 26.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 79.5) => 
            map(
            (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0274201398,
            (r_L70_Add_Standardized_i > 0.5) => 0.1716859597,
            (r_L70_Add_Standardized_i = NULL) => 0.0380542988, 0.0380542988),
         (k_comb_age_d > 79.5) => 0.2202612198,
         (k_comb_age_d = NULL) => 0.0458011917, 0.0458011917),
      (f_rel_educationover8_count_d > 26.5) => 0.1893904690,
      (f_rel_educationover8_count_d = NULL) => 0.0534315398, 0.0534315398),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0161684816, 0.0161684816),
(c_easiqlife = NULL) => 0.0152115937, -0.0046895762);

// Tree: 82 
woFDN_FLA_SD_lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3696198472) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 29953.5) => 
         map(
         (NULL < c_hval_40k_p and c_hval_40k_p <= 1.8) => 0.2112943944,
         (c_hval_40k_p > 1.8) => -0.0093570542,
         (c_hval_40k_p = NULL) => 0.0964097558, 0.0964097558),
      (r_A46_Curr_AVM_AutoVal_d > 29953.5) => 
         map(
         (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => -0.0044160138,
         (f_divaddrsuspidcountnew_i > 2.5) => 0.0933326047,
         (f_divaddrsuspidcountnew_i = NULL) => -0.0026860956, -0.0026860956),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0056998548, 0.0018661479),
   (f_add_input_mobility_index_i > 0.3696198472) => -0.0227619302,
   (f_add_input_mobility_index_i = NULL) => 0.1264531402, -0.0017727070),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0749823996,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0015952058, -0.0022797070);

// Tree: 83 
woFDN_FLA_SD_lgt_83 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0189632991,
   (k_inq_per_ssn_i > 2.5) => 0.0485807280,
   (k_inq_per_ssn_i = NULL) => -0.0139905543, -0.0139905543),
(f_srchaddrsrchcount_i > 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 0.1021864910,
   (r_C10_M_Hdr_FS_d > 8.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
         map(
         (NULL < c_med_age and c_med_age <= 39.35) => 0.0122458361,
         (c_med_age > 39.35) => 0.2332312514,
         (c_med_age = NULL) => 0.0989616320, 0.0989616320),
      (r_F00_dob_score_d > 95) => 0.0110749348,
      (r_F00_dob_score_d = NULL) => -0.0055772475, 0.0132273833),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0147548514, 0.0147548514),
(f_srchaddrsrchcount_i = NULL) => 0.0012519056, -0.0011694180);

// Tree: 84 
woFDN_FLA_SD_lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 309.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 0.0001860938,
   (k_inq_adls_per_addr_i > 3.5) => -0.0498149932,
   (k_inq_adls_per_addr_i = NULL) => -0.0009119958, -0.0009119958),
(r_C13_Curr_Addr_LRes_d > 309.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 159.9) => 0.0341040349,
   (c_oldhouse > 159.9) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 5.55) => 0.0302462392,
      (c_rnt1250_p > 5.55) => 0.2593497896,
      (c_rnt1250_p = NULL) => 0.1476381410, 0.1476381410),
   (c_oldhouse = NULL) => 0.0533713937, 0.0533713937),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0879673900,
   (k_comb_age_d > 25.5) => 0.0748264351,
   (k_comb_age_d = NULL) => 0.0027701519, 0.0027701519), 0.0022216578);

// Tree: 85 
woFDN_FLA_SD_lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => -0.0071540580,
   (f_srchssnsrchcount_i > 6.5) => -0.0545208881,
   (f_srchssnsrchcount_i = NULL) => -0.0085733855, -0.0085733855),
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 8.5) => 0.0080956090,
      (f_inq_Collection_count_i > 8.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 10.8) => 0.0144999235,
         (c_hval_250k_p > 10.8) => 0.1806606620,
         (c_hval_250k_p = NULL) => 0.0881885989, 0.0881885989),
      (f_inq_Collection_count_i = NULL) => 0.0144790421, 0.0144790421),
   (r_F01_inp_addr_not_verified_i > 0.5) => 0.1429863141,
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0218246730, 0.0218246730),
(f_util_adl_count_n = NULL) => 0.0059145461, -0.0047083710);

// Tree: 86 
woFDN_FLA_SD_lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => -0.0029124021,
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 9.15) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => -0.0259820670,
      (r_C23_inp_addr_occ_index_d > 2) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','5: Vuln Vic/Friendly']) => -0.0246705196,
         (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','6: Other']) => 0.1407892963,
         (nf_seg_FraudPoint_3_0 = '') => 0.0763554257, 0.0763554257),
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0172825641, 0.0172825641),
   (c_pop_12_17_p > 9.15) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 94.65) => 0.1490782241,
      (c_occunit_p > 94.65) => -0.0281955078,
      (c_occunit_p = NULL) => 0.0899869801, 0.0899869801),
   (c_pop_12_17_p = NULL) => 0.0350398638, 0.0350398638),
(f_phones_per_addr_curr_i = NULL) => -0.0187651734, -0.0010674913);

// Tree: 87 
woFDN_FLA_SD_lgt_87 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -83313) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.017799068) => 0.1848573727,
      (f_add_input_nhood_BUS_pct_i > 0.017799068) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 15.85) => 0.0943065255,
         (c_high_ed > 15.85) => -0.0426216486,
         (c_high_ed = NULL) => 0.0058560279, 0.0058560279),
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0482734082, 0.0482734082),
   (f_addrchangevaluediff_d > -83313) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 58.5) => 0.1102943323,
      (f_mos_liens_unrel_SC_fseen_d > 58.5) => -0.0092618089,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0080505132, -0.0080505132),
   (f_addrchangevaluediff_d = NULL) => -0.0071382149, -0.0068559009),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1045794598,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0064166603, -0.0064166603);

// Tree: 88 
woFDN_FLA_SD_lgt_88 := map(
(NULL < c_hh6_p and c_hh6_p <= 10.65) => 0.0005885821,
(c_hh6_p > 10.65) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 67.15) => 
      map(
      (NULL < c_rnt1500_p and c_rnt1500_p <= 3.65) => 
         map(
         (NULL < c_pop00 and c_pop00 <= 1923) => 
            map(
            (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => -0.0120844433,
            (f_srchvelocityrisktype_i > 2.5) => 0.1814874164,
            (f_srchvelocityrisktype_i = NULL) => 0.0800926327, 0.0800926327),
         (c_pop00 > 1923) => 0.3037992754,
         (c_pop00 = NULL) => 0.1532274967, 0.1532274967),
      (c_rnt1500_p > 3.65) => -0.0289233029,
      (c_rnt1500_p = NULL) => 0.0816429412, 0.0816429412),
   (r_C12_source_profile_d > 67.15) => -0.0319951214,
   (r_C12_source_profile_d = NULL) => 0.0465128950, 0.0465128950),
(c_hh6_p = NULL) => -0.0425202575, 0.0009876447);

// Tree: 89 
woFDN_FLA_SD_lgt_89 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 283.5) => -0.0074097945,
   (r_C13_Curr_Addr_LRes_d > 283.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 43.65) => 0.0238691132,
      (c_hval_750k_p > 43.65) => 0.2210130300,
      (c_hval_750k_p = NULL) => 0.0379508215, 0.0379508215),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0037959694, -0.0037959694),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 235.5) => 0.1256135761,
   (f_M_Bureau_ADL_FS_all_d > 235.5) => -0.0234873077,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0516236639, 0.0516236639),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1173.5) => 0.0759172358,
   (c_popover25 > 1173.5) => -0.0646886437,
   (c_popover25 = NULL) => 0.0029613549, 0.0029613549), -0.0031547089);

// Tree: 90 
woFDN_FLA_SD_lgt_90 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 48.95) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 0.65) => 0.1487358333,
         (c_pop_25_34_p > 0.65) => 
            map(
            (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => -0.0032700411,
            (r_D32_criminal_count_i > 2.5) => 0.0382623093,
            (r_D32_criminal_count_i = NULL) => -0.0008342988, -0.0008342988),
         (c_pop_25_34_p = NULL) => 0.0001696108, 0.0001696108),
      (k_inq_adls_per_addr_i > 4.5) => -0.0700690768,
      (k_inq_adls_per_addr_i = NULL) => -0.0005333523, -0.0005333523),
   (c_hval_80k_p > 48.95) => -0.1272933560,
   (c_hval_80k_p = NULL) => 0.0018457180, -0.0010981912),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0837931831,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0380324096, -0.0017530346);

// Tree: 91 
woFDN_FLA_SD_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.45) => 0.0311828318,
   (c_retired > 15.45) => 0.1943888227,
   (c_retired = NULL) => 0.0742510794, 0.0742510794),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 62) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.0458306069,
         (r_F00_dob_score_d > 98) => -0.0115373518,
         (r_F00_dob_score_d = NULL) => -0.0496722730, -0.0109436369),
      (k_comb_age_d > 68.5) => 0.0388158228,
      (k_comb_age_d = NULL) => -0.0075078154, -0.0075078154),
   (c_famotf18_p > 62) => 0.1032970053,
   (c_famotf18_p = NULL) => -0.0044602037, -0.0069919738),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0095845259, -0.0054597246);

// Tree: 92 
woFDN_FLA_SD_lgt_92 := map(
(NULL < c_hh3_p and c_hh3_p <= 21.55) => -0.0041197733,
(c_hh3_p > 21.55) => 
   map(
   (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 117) => 0.0354415419,
      (r_pb_order_freq_d > 117) => -0.0396157830,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.95) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 0.1261320689,
            (f_prevaddrlenofres_d > 1.5) => 0.0087331482,
            (f_prevaddrlenofres_d = NULL) => 0.0183620818, 0.0183620818),
         (r_C12_source_profile_d > 78.95) => 0.2513296688,
         (r_C12_source_profile_d = NULL) => 0.0351812051, 0.0351812051), 0.0189462312),
   (f_acc_damage_amt_total_i > 275) => 0.1739810415,
   (f_acc_damage_amt_total_i = NULL) => 0.0235130562, 0.0235130562),
(c_hh3_p = NULL) => -0.0432890202, 0.0006803022);

// Tree: 93 
woFDN_FLA_SD_lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0021664248,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_food and c_food <= 18.7) => 0.1314361523,
         (c_food > 18.7) => -0.0008992155,
         (c_food = NULL) => 0.0717095704, 0.0717095704),
      (r_D33_eviction_count_i = NULL) => 0.0028387704, 0.0028387704),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 55.5) => 0.0813104300,
      (r_pb_order_freq_d > 55.5) => -0.0514686427,
      (r_pb_order_freq_d = NULL) => 0.1357208773, 0.0765139917),
   (f_curraddrcartheftindex_i = NULL) => -0.0123836139, 0.0040936292),
(c_cartheft > 189.5) => -0.0576606294,
(c_cartheft = NULL) => -0.0022701649, 0.0019558037);

// Tree: 94 
woFDN_FLA_SD_lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 4.5) => 0.0142229277,
         (k_inq_per_ssn_i > 4.5) => 0.1802412254,
         (k_inq_per_ssn_i = NULL) => 0.0188220223, 0.0188220223),
      (r_Ever_Asset_Owner_d > 0.5) => -0.0172985823,
      (r_Ever_Asset_Owner_d = NULL) => -0.0101857325, -0.0101857325),
   (f_inq_Other_count_i > 0.5) => 0.0230145119,
   (f_inq_Other_count_i = NULL) => -0.0023574082, -0.0025240455),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 1990) => -0.0032497428,
   (r_A50_pb_total_dollars_d > 1990) => 0.1172330053,
   (r_A50_pb_total_dollars_d = NULL) => 0.0612607050, 0.0612607050),
(c_famotf18_p = NULL) => 0.0093866663, -0.0015999381);

// Tree: 95 
woFDN_FLA_SD_lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0653355532,
   (f_corrssnaddrcount_d > 0.5) => -0.0070463942,
   (f_corrssnaddrcount_d = NULL) => -0.0207127960, -0.0083862396),
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 30.45) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30897.5) => 0.1454543164,
      (f_curraddrmedianincome_d > 30897.5) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0041580332,
         (f_hh_collections_ct_i > 2.5) => 0.1000999862,
         (f_hh_collections_ct_i = NULL) => 0.0139137016, 0.0139137016),
      (f_curraddrmedianincome_d = NULL) => 0.0191398944, 0.0191398944),
   (C_INC_75K_P > 30.45) => 0.1836102017,
   (C_INC_75K_P = NULL) => 0.0263959374, 0.0263959374),
(c_rnt1000_p = NULL) => -0.0069446320, -0.0040654874);

// Tree: 96 
woFDN_FLA_SD_lgt_96 := map(
(NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.14192992865) => 
   map(
   (NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 29730.5) => 0.0690725109,
      (r_L80_Inp_AVM_AutoVal_d > 29730.5) => -0.0033547250,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0124380573, -0.0063842934),
   (f_assoccredbureaucountmo_i > 0.5) => 0.1203464336,
   (f_assoccredbureaucountmo_i = NULL) => -0.0056630714, -0.0056630714),
(f_add_curr_nhood_BUS_pct_i > 0.14192992865) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0183137450,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < c_food and c_food <= 10.5) => 0.1924661608,
      (c_food > 10.5) => 0.0419885362,
      (c_food = NULL) => 0.0932322678, 0.0932322678),
   (f_rel_felony_count_i = NULL) => 0.0287504368, 0.0287504368),
(f_add_curr_nhood_BUS_pct_i = NULL) => -0.0191775194, -0.0029275272);

// Tree: 97 
woFDN_FLA_SD_lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 0.0009533193,
      (k_inq_adls_per_addr_i > 3.5) => -0.0538382420,
      (k_inq_adls_per_addr_i = NULL) => -0.0001152942, -0.0001152942),
   (f_rel_incomeover50_count_d > 22.5) => -0.0708617958,
   (f_rel_incomeover50_count_d = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.2) => 0.1871087282,
      (c_bigapt_p > 1.2) => -0.0614336813,
      (c_bigapt_p = NULL) => 0.0112171768, 0.0112171768), -0.0013484737),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1463017476,
   (r_A50_pb_average_dollars_d > 99) => -0.0045897693,
   (r_A50_pb_average_dollars_d = NULL) => 0.0631331950, 0.0631331950),
(r_D33_eviction_count_i = NULL) => -0.0023157277, -0.0007113585);

// Tree: 98 
woFDN_FLA_SD_lgt_98 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0044400700,
(f_rel_homeover500_count_d > 14.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.24094392385) => 0.1972476591,
   (f_add_input_mobility_index_i > 0.24094392385) => -0.0304063561,
   (f_add_input_mobility_index_i = NULL) => 0.0792814876, 0.0792814876),
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 172.5) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 15.7) => 0.1589607640,
      (c_hh1_p > 15.7) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.02662506885) => -0.0516091187,
         (f_add_input_nhood_VAC_pct_i > 0.02662506885) => 0.0988407081,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0250532134, 0.0250532134),
      (c_hh1_p = NULL) => 0.0607201779, 0.0607201779),
   (c_no_teens > 172.5) => -0.1083806656,
   (c_no_teens = NULL) => 0.0164040947, 0.0164040947), -0.0032227443);

// Tree: 99 
woFDN_FLA_SD_lgt_99 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 116.5) => 0.0978163217,
(r_D32_Mos_Since_Fel_LS_d > 116.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => -0.0098640345,
   (r_C14_Addr_Stability_v2_d > 4.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 4.5) => -0.0076994134,
         (f_rel_homeover150_count_d > 4.5) => 
            map(
            (NULL < c_retail and c_retail <= 7.9) => 0.2404395015,
            (c_retail > 7.9) => 0.0535411742,
            (c_retail = NULL) => 0.1442685175, 0.1442685175),
         (f_rel_homeover150_count_d = NULL) => 0.0622327318, 0.0622327318),
      (r_F00_dob_score_d > 95) => 0.0103570986,
      (r_F00_dob_score_d = NULL) => 0.1147809634, 0.0139807515),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0026991215, 0.0026991215),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0082008343, 0.0032571554);

// Tree: 100 
woFDN_FLA_SD_lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_transport and c_transport <= 26.6) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 82.1) => 0.1647235769,
         (c_occunit_p > 82.1) => 0.0388267102,
         (c_occunit_p = NULL) => 0.0625997887, 0.0625997887),
      (k_estimated_income_d > 30500) => 0.0019987751,
      (k_estimated_income_d = NULL) => 0.0058673628, 0.0058673628),
   (c_transport > 26.6) => 0.1594679029,
   (c_transport = NULL) => -0.0035911094, 0.0083022118),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 36.05) => -0.0140534390,
   (c_famotf18_p > 36.05) => -0.0719509666,
   (c_famotf18_p = NULL) => 0.0922879221, -0.0156253701),
(f_historical_count_d = NULL) => 0.0169641300, -0.0036595749);

// Tree: 101 
woFDN_FLA_SD_lgt_101 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 0.0009989704,
   (r_D31_ALL_Bk_i > 1.5) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 319585) => -0.0587989128,
      (c_med_hval > 319585) => 0.0299076008,
      (c_med_hval = NULL) => -0.0362877656, -0.0362877656),
   (r_D31_ALL_Bk_i = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0727460033,
      (f_addrs_per_ssn_i > 3.5) => 0.0597588824,
      (f_addrs_per_ssn_i = NULL) => -0.0095894690, -0.0095894690), -0.0025088881),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => -0.0070286780,
   (f_addrs_per_ssn_i > 7.5) => 0.2105455160,
   (f_addrs_per_ssn_i = NULL) => 0.0672025176, 0.0672025176),
(f_nae_nothing_found_i = NULL) => -0.0015746398, -0.0015746398);

// Tree: 102 
woFDN_FLA_SD_lgt_102 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0094630052,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 44) => -0.1221534792,
   (f_mos_inq_banko_am_fseen_d > 44) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 79.25) => 
            map(
            (NULL < c_hh7p_p and c_hh7p_p <= 9.55) => 0.0101601991,
            (c_hh7p_p > 9.55) => 0.0876150164,
            (c_hh7p_p = NULL) => 0.0123027721, 0.0123027721),
         (c_rnt1000_p > 79.25) => 0.1881190752,
         (c_rnt1000_p = NULL) => 0.0166919179, 0.0151986195),
      (f_addrs_per_ssn_c6_i > 1.5) => 0.1213415575,
      (f_addrs_per_ssn_c6_i = NULL) => 0.0168042849, 0.0168042849),
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0133256217, 0.0133256217),
(k_inq_per_ssn_i = NULL) => -0.0001786833, -0.0001786833);

// Tree: 103 
woFDN_FLA_SD_lgt_103 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 701.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 76) => 0.1981284035,
         (c_no_teens > 76) => 0.0392284032,
         (c_no_teens = NULL) => 0.1011586598, 0.1011586598),
      (c_popover25 > 701.5) => -0.0195111480,
      (c_popover25 = NULL) => 0.1120207033, 0.0447622668),
   (k_estimated_income_d > 27500) => 
      map(
      (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => -0.0040515940,
      (r_D34_unrel_liens_ct_i > 7.5) => 0.1258036735,
      (r_D34_unrel_liens_ct_i = NULL) => -0.0033722971, -0.0033722971),
   (k_estimated_income_d = NULL) => -0.0009574680, -0.0009574680),
(f_srchaddrsrchcount_i > 32.5) => -0.0800391615,
(f_srchaddrsrchcount_i = NULL) => 0.0009259497, -0.0014756495);

// Tree: 104 
woFDN_FLA_SD_lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.25) => -0.0155679029,
   (c_pop_35_44_p > 13.25) => 0.0108194079,
   (c_pop_35_44_p = NULL) => -0.0061879612, 0.0007183673),
(f_prevaddrmedianvalue_d > 809865.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 77750) => 0.3089125847,
   (r_A49_Curr_AVM_Chg_1yr_i > 77750) => 0.0049559184,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < c_rich_nfam and c_rich_nfam <= 151) => 0.2198474286,
      (c_rich_nfam > 151) => -0.1147221911,
      (c_rich_nfam = NULL) => 0.0525626187, 0.0525626187), 0.1106949638),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 65) => -0.0615966261,
   (c_born_usa > 65) => 0.0309368561,
   (c_born_usa = NULL) => -0.0131678877, -0.0131678877), 0.0023795534);

// Tree: 105 
woFDN_FLA_SD_lgt_105 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 6.05) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 42727) => 0.2428069531,
      (f_prevaddrmedianincome_d > 42727) => 
         map(
         (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 1.5) => -0.0023409444,
         (r_A50_pb_total_orders_d > 1.5) => 0.2168829719,
         (r_A50_pb_total_orders_d = NULL) => 0.0652106112, 0.0652106112),
      (f_prevaddrmedianincome_d = NULL) => 0.1128215454, 0.1128215454),
   (c_pop_12_17_p > 6.05) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 148.5) => -0.0186365582,
      (c_rich_fam > 148.5) => 0.0936241739,
      (c_rich_fam = NULL) => 0.0098887098, 0.0098887098),
   (c_pop_12_17_p = NULL) => 0.0114802196, 0.0341883614),
(f_corraddrnamecount_d > 1.5) => -0.0040448987,
(f_corraddrnamecount_d = NULL) => -0.0100610010, -0.0010635083);

// Tree: 106 
woFDN_FLA_SD_lgt_106 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 30.5) => 0.1043008954,
   (f_mos_liens_unrel_SC_fseen_d > 30.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 36.15) => -0.0065522260,
      (c_hh3_p > 36.15) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 33.75) => -0.0002140018,
         (c_fammar18_p > 33.75) => 0.2209817887,
         (c_fammar18_p = NULL) => 0.0959580810, 0.0959580810),
      (c_hh3_p = NULL) => -0.0367711479, -0.0062982031),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0056677812, -0.0056677812),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 126.5) => -0.0329068781,
   (c_blue_empl > 126.5) => 0.2734502631,
   (c_blue_empl = NULL) => 0.1341970171, 0.1341970171),
(f_historical_count_d = NULL) => 0.0017923135, -0.0043849369);

// Tree: 107 
woFDN_FLA_SD_lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0810783856,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 13.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45573.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 32900) => -0.0749525773,
         (r_L80_Inp_AVM_AutoVal_d > 32900) => 0.0274045866,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0188541086, 0.0186219028),
      (f_curraddrmedianincome_d > 45573.5) => -0.0110027892,
      (f_curraddrmedianincome_d = NULL) => -0.0038638770, -0.0038638770),
   (r_D30_Derog_Count_i > 13.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 44.85) => 0.1843020069,
      (c_low_ed > 44.85) => -0.0259280371,
      (c_low_ed = NULL) => 0.0762939109, 0.0762939109),
   (r_D30_Derog_Count_i = NULL) => -0.0031646773, -0.0031646773),
(f_attr_arrest_recency_d = NULL) => 0.0069505203, -0.0024763418);

// Tree: 108 
woFDN_FLA_SD_lgt_108 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => -0.0016749325,
(f_phones_per_addr_curr_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 57.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.05) => -0.0157367352,
         (c_pop_35_44_p > 12.05) => 
            map(
            (NULL < c_pop00 and c_pop00 <= 1085) => 0.2274751660,
            (c_pop00 > 1085) => 0.0733116043,
            (c_pop00 = NULL) => 0.1229865297, 0.1229865297),
         (c_pop_35_44_p = NULL) => 0.0672206990, 0.0672206990),
      (c_very_rich > 57.5) => 0.0072839480,
      (c_very_rich = NULL) => 0.0206278549, 0.0206278549),
   (r_C12_source_profile_d > 81.3) => 0.2137308028,
   (r_C12_source_profile_d = NULL) => 0.0287642150, 0.0287642150),
(f_phones_per_addr_curr_i = NULL) => -0.0171118199, 0.0016143441);

// Tree: 109 
woFDN_FLA_SD_lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 0.0075605935,
   (f_srchssnsrchcount_i > 21.5) => 0.0986323538,
   (f_srchssnsrchcount_i = NULL) => 0.0079604612, 0.0079604612),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 21.5) => -0.0865684663,
   (f_mos_inq_banko_cm_lseen_d > 21.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 24.9) => -0.0499774574,
      (c_rnt750_p > 24.9) => 
         map(
         (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 0.1261362394,
         (f_historical_count_d > 1.5) => -0.0347784603,
         (f_historical_count_d = NULL) => 0.0462262184, 0.0462262184),
      (c_rnt750_p = NULL) => -0.0078883493, -0.0078883493),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0321586273, -0.0321586273),
(r_D33_eviction_count_i = NULL) => 0.0184627174, 0.0064894481);

// Tree: 110 
woFDN_FLA_SD_lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 103.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 110081.5) => 0.0208405710,
   (r_A46_Curr_AVM_AutoVal_d > 110081.5) => -0.0254922025,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0019792820, -0.0089152890),
(f_prevaddrageoldest_d > 103.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 60) => 0.1406353755,
   (f_prevaddrlenofres_d > 60) => 
      map(
      (NULL < c_highrent and c_highrent <= 92.85) => 0.0115600675,
      (c_highrent > 92.85) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 11.55) => 0.0261243359,
         (c_hh5_p > 11.55) => 0.4131440169,
         (c_hh5_p = NULL) => 0.1413087648, 0.1413087648),
      (c_highrent = NULL) => 0.0237122528, 0.0166373890),
   (f_prevaddrlenofres_d = NULL) => 0.0180003037, 0.0180003037),
(f_prevaddrageoldest_d = NULL) => -0.0258276955, 0.0005809885);

// Tree: 111 
woFDN_FLA_SD_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2024414868,
   (r_C12_source_profile_d > 57.95) => -0.0223319600,
   (r_C12_source_profile_d = NULL) => 0.0822138292, 0.0822138292),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 21.55) => -0.0006351638,
   (c_hval_150k_p > 21.55) => 
      map(
      (NULL < c_families and c_families <= 910.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 3.5) => -0.0076467915,
         (f_srchaddrsrchcount_i > 3.5) => 0.0861747586,
         (f_srchaddrsrchcount_i = NULL) => 0.0158344564, 0.0158344564),
      (c_families > 910.5) => 0.2767485899,
      (c_families = NULL) => 0.0355160526, 0.0355160526),
   (c_hval_150k_p = NULL) => -0.0043090854, 0.0021314109),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0256850048, 0.0027243297);

// Tree: 112 
woFDN_FLA_SD_lgt_112 := map(
(NULL < c_high_ed and c_high_ed <= 42.45) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0051142602,
      (f_corrrisktype_i > 6.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
            map(
            (NULL < c_easiqlife and c_easiqlife <= 129.5) => 0.0171342503,
            (c_easiqlife > 129.5) => 0.1409964612,
            (c_easiqlife = NULL) => 0.0655738026, 0.0655738026),
         (f_prevaddrlenofres_d > 2.5) => 0.0140934796,
         (f_prevaddrlenofres_d = NULL) => 0.0209323928, 0.0209323928),
      (f_corrrisktype_i = NULL) => 0.0034269931, 0.0034269931),
   (f_util_adl_count_n > 13.5) => 0.1446641922,
   (f_util_adl_count_n = NULL) => 0.0233738071, 0.0045717675),
(c_high_ed > 42.45) => -0.0218113326,
(c_high_ed = NULL) => 0.0137714115, -0.0025659299);

// Tree: 113 
woFDN_FLA_SD_lgt_113 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0118319587,
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 17714) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 7.5) => 0.0818736532,
         (f_M_Bureau_ADL_FS_all_d > 7.5) => -0.0057343302,
         (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0015746180, -0.0015746180),
      (f_inq_Collection_count24_i > 1.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 123.5) => 0.1515163129,
         (c_easiqlife > 123.5) => -0.0108708946,
         (c_easiqlife = NULL) => 0.0786266005, 0.0786266005),
      (f_inq_Collection_count24_i = NULL) => 0.0032347225, 0.0032347225),
   (f_addrchangeincomediff_d > 17714) => 0.0732801300,
   (f_addrchangeincomediff_d = NULL) => 0.0041854926, 0.0064625800),
(f_corrrisktype_i = NULL) => 0.0349761904, -0.0053822246);

// Tree: 114 
woFDN_FLA_SD_lgt_114 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0054975278) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 39.5) => 0.0493868428,
      (c_no_car > 39.5) => 0.2711713725,
      (c_no_car = NULL) => 0.1613557316, 0.1613557316),
   (f_hh_members_ct_d > 1.5) => 0.0217737084,
   (f_hh_members_ct_d = NULL) => 0.0402768595, 0.0402768595),
(f_add_input_nhood_MFD_pct_i > 0.0054975278) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => -0.0087904686,
   (f_srchssnsrchcount_i > 6.5) => -0.0464134748,
   (f_srchssnsrchcount_i = NULL) => 0.0019902488, -0.0101958039),
(f_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 18.5) => -0.0064276290,
   (f_srchaddrsrchcount_i > 18.5) => 0.1093950263,
   (f_srchaddrsrchcount_i = NULL) => -0.0039044711, -0.0039044711), -0.0058755810);

// Tree: 115 
woFDN_FLA_SD_lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.0923065779,
   (r_F00_dob_score_d > 55) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13229074905) => -0.0098723768,
      (f_add_curr_nhood_BUS_pct_i > 0.13229074905) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0022993096,
         (c_easiqlife > 132.5) => 0.0740159823,
         (c_easiqlife = NULL) => 0.0287003364, 0.0287003364),
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0084868172, -0.0052640702),
   (r_F00_dob_score_d = NULL) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 54.7) => -0.0407391031,
      (r_C12_source_profile_d > 54.7) => 0.1279676421,
      (r_C12_source_profile_d = NULL) => -0.0093211233, -0.0070887221), -0.0048061684),
(c_pop_0_5_p > 21.15) => 0.1563825053,
(c_pop_0_5_p = NULL) => 0.0113325207, -0.0037204818);

// Tree: 116 
woFDN_FLA_SD_lgt_116 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.45) => -0.0849774982,
(C_OWNOCC_P > 1.45) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 5.5) => -0.0037821287,
   (f_bus_addr_match_count_d > 5.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 19.5) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 773049.5) => 0.0091115520,
         (c_med_hval > 773049.5) => 0.2034094460,
         (c_med_hval = NULL) => 0.0198535307, 0.0198535307),
      (c_bigapt_p > 19.5) => 
         map(
         (NULL < c_employees and c_employees <= 367) => 0.2412898603,
         (c_employees > 367) => 0.0266629945,
         (c_employees = NULL) => 0.1260539592, 0.1260539592),
      (c_bigapt_p = NULL) => 0.0332635848, 0.0332635848),
   (f_bus_addr_match_count_d = NULL) => -0.0002191699, -0.0002191699),
(C_OWNOCC_P = NULL) => 0.0094488099, -0.0010335900);

// Tree: 117 
woFDN_FLA_SD_lgt_117 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 10.85) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 72.1) => 0.0079955881,
   (c_lowinc > 72.1) => 0.0907977082,
   (c_lowinc = NULL) => 0.0086621287, 0.0086621287),
(c_pop_18_24_p > 10.85) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0377479238,
   (f_hh_criminals_i > 0.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 9.15) => -0.0001704519,
      (c_hh6_p > 9.15) => 0.0992321061,
      (c_hh6_p = NULL) => 0.0089910742, 0.0089910742),
   (f_hh_criminals_i = NULL) => -0.0212240356, -0.0212240356),
(c_pop_18_24_p = NULL) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 2.5) => 0.1230506854,
   (r_C14_Addr_Stability_v2_d > 2.5) => -0.0394984443,
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0074632143, -0.0074632143), 0.0010264476);

// Tree: 118 
woFDN_FLA_SD_lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => -0.0068659576,
   (f_inq_Communications_count_i > 3.5) => 0.0691521698,
   (f_inq_Communications_count_i = NULL) => -0.0062825872, -0.0062825872),
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 107.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0326976663) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 176.5) => -0.0161111162,
         (r_C21_M_Bureau_ADL_FS_d > 176.5) => 0.1333143374,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0571366552, 0.0571366552),
      (f_add_curr_nhood_BUS_pct_i > 0.0326976663) => -0.0406897399,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0048732387, 0.0048732387),
   (c_medi_indx > 107.5) => 0.1379074779,
   (c_medi_indx = NULL) => 0.0394275865, 0.0394275865),
(f_srchunvrfdaddrcount_i = NULL) => -0.0136114411, -0.0051964927);

// Tree: 119 
woFDN_FLA_SD_lgt_119 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 32.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 23.5) => 0.0081081858,
      (f_rel_homeover300_count_d > 23.5) => 0.1442588147,
      (f_rel_homeover300_count_d = NULL) => 0.0088033047, 0.0088033047),
   (f_rel_under500miles_cnt_d > 32.5) => -0.0556251172,
   (f_rel_under500miles_cnt_d = NULL) => 0.0471412223, 0.0082402594),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 6.65) => -0.0972084192,
   (c_vacant_p > 6.65) => -0.0067564912,
   (c_vacant_p = NULL) => -0.0517279001, -0.0517279001),
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0253344101,
   (c_rich_nfam > 124) => -0.0782894246,
   (c_rich_nfam = NULL) => -0.0237505642, -0.0237505642), 0.0054131489);

// Tree: 120 
woFDN_FLA_SD_lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1920.5) => -0.0070835280,
(c_popover18 > 1920.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 127.5) => 0.1644472451,
   (f_mos_liens_unrel_SC_fseen_d > 127.5) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 7.55) => 
         map(
         (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 1.5) => 0.0392932931,
         (k_inq_adls_per_addr_i > 1.5) => 
            map(
            (NULL < c_construction and c_construction <= 7.45) => 0.0514758824,
            (c_construction > 7.45) => 0.3033048486,
            (c_construction = NULL) => 0.1534825522, 0.1534825522),
         (k_inq_adls_per_addr_i = NULL) => 0.0595650942, 0.0595650942),
      (c_hval_400k_p > 7.55) => -0.0101612468,
      (c_hval_400k_p = NULL) => 0.0170564915, 0.0170564915),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0202812571, 0.0202812571),
(c_popover18 = NULL) => -0.0307444710, -0.0025399837);

// Tree: 121 
woFDN_FLA_SD_lgt_121 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 197.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0004792014,
   (f_curraddrcrimeindex_i > 189) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 69.25) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 43.5) => -0.0109794147,
         (c_fammar_p > 43.5) => 0.1959564933,
         (c_fammar_p = NULL) => 0.1213469482, 0.1213469482),
      (c_fammar_p > 69.25) => -0.0415129459,
      (c_fammar_p = NULL) => 0.0505655327, 0.0505655327),
   (f_curraddrcrimeindex_i = NULL) => 0.0005968458, 0.0005968458),
(f_prevaddrcartheftindex_i > 197.5) => -0.0900716887,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.85) => -0.0393731500,
   (c_hh4_p > 11.85) => 0.0632671695,
   (c_hh4_p = NULL) => 0.0129532874, 0.0129532874), -0.0000198689);

// Tree: 122 
woFDN_FLA_SD_lgt_122 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0029042957,
(f_prevaddroccupantowned_i > 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 78500) => 0.1259926480,
   (r_A46_Curr_AVM_AutoVal_d > 78500) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 12.75) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 168563) => 
            map(
            (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 6.5) => 0.0539720241,
            (f_rel_homeover150_count_d > 6.5) => 0.1616533748,
            (f_rel_homeover150_count_d = NULL) => 0.0943525306, 0.0943525306),
         (r_L80_Inp_AVM_AutoVal_d > 168563) => 0.0068665497,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.1328134460, 0.0506059623),
      (c_hh5_p > 12.75) => -0.0848682712,
      (c_hh5_p = NULL) => 0.0290588721, 0.0290588721),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0037968368, 0.0306504873),
(f_prevaddroccupantowned_i = NULL) => 0.0056985478, -0.0003768179);

// Tree: 123 
woFDN_FLA_SD_lgt_123 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 129.5) => -0.0041759486,
   (c_easiqlife > 129.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72571) => 0.1010183828,
      (f_addrchangevaluediff_d > -72571) => 
         map(
         (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 14.5) => 0.0209581063,
         (f_rel_under500miles_cnt_d > 14.5) => -0.0279933505,
         (f_rel_under500miles_cnt_d = NULL) => 0.1023576466, 0.0140850829),
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 24.65) => 0.0243950523,
         (c_hval_150k_p > 24.65) => 0.2070442915,
         (c_hval_150k_p = NULL) => 0.0346407486, 0.0346407486), 0.0197413851),
   (c_easiqlife = NULL) => 0.0021868981, 0.0047778130),
(r_L77_Add_PO_Box_i > 0.5) => -0.0911965645,
(r_L77_Add_PO_Box_i = NULL) => 0.0026744723, 0.0026744723);

// Tree: 124 
woFDN_FLA_SD_lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 1.55) => -0.0790905549,
   (c_sfdu_p > 1.55) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
         map(
         (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 6.5) => 0.0288433834,
         (f_rel_incomeover25_count_d > 6.5) => -0.0053919240,
         (f_rel_incomeover25_count_d = NULL) => 0.0086939483, 0.0086939483),
      (f_rel_homeover500_count_d > 14.5) => 0.1071329860,
      (f_rel_homeover500_count_d = NULL) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 0.0664896441,
         (c_bigapt_p > 1.15) => -0.0456305466,
         (c_bigapt_p = NULL) => 0.0052337350, 0.0052337350), 0.0093496119),
   (c_sfdu_p = NULL) => 0.0081828817, 0.0081828817),
(c_high_ed > 42.55) => -0.0257727563,
(c_high_ed = NULL) => -0.0314468729, -0.0023561293);

// Tree: 125 
woFDN_FLA_SD_lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5693) => -0.0013174035,
      (f_liens_unrel_SC_total_amt_i > 5693) => 0.1188141205,
      (f_liens_unrel_SC_total_amt_i = NULL) => -0.0007853954, -0.0007853954),
   (f_inq_Auto_count24_i > 1.5) => -0.0478818855,
   (f_inq_Auto_count24_i = NULL) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.26975069405) => -0.0342594805,
      (f_add_input_mobility_index_i > 0.26975069405) => 0.0798848547,
      (f_add_input_mobility_index_i = NULL) => 0.0228126871, 0.0228126871), -0.0030639040),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 7.5) => 0.0043945727,
   (f_rel_count_i > 7.5) => 0.1673805454,
   (f_rel_count_i = NULL) => 0.0782335216, 0.0782335216),
(f_nae_nothing_found_i = NULL) => -0.0018974766, -0.0018974766);

// Tree: 126 
woFDN_FLA_SD_lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 3.35) => -0.0495701735,
      (c_rnt1000_p > 3.35) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.67) => 0.1339835573,
         (c_hhsize > 2.67) => 0.0252349181,
         (c_hhsize = NULL) => 0.0811337514, 0.0811337514),
      (c_rnt1000_p = NULL) => 0.0378380762, 0.0378380762),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.55) => -0.0764036693,
      (C_OWNOCC_P > 1.55) => 0.0049756281,
      (C_OWNOCC_P = NULL) => -0.0215279639, 0.0033757319),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0001623721, 0.0037956396),
(r_L72_Add_Vacant_i > 0.5) => 0.1130693172,
(r_L72_Add_Vacant_i = NULL) => 0.0045453289, 0.0045453289);

// Tree: 127 
woFDN_FLA_SD_lgt_127 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 10.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => -0.0007161205,
   (f_assocsuspicousidcount_i > 16.5) => 0.0931635156,
   (f_assocsuspicousidcount_i = NULL) => -0.0002980330, -0.0002980330),
(f_srchssnsrchcount_i > 10.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 244.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.05) => -0.0751089330,
      (c_bigapt_p > 1.05) => 0.0603504788,
      (c_bigapt_p = NULL) => -0.0068919630, -0.0068919630),
   (r_C10_M_Hdr_FS_d > 244.5) => -0.1016198310,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0435475293, -0.0435475293),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0893959164,
   (r_S66_adlperssn_count_i > 1.5) => 0.0389757839,
   (r_S66_adlperssn_count_i = NULL) => -0.0233761848, -0.0233761848), -0.0012732471);

// Tree: 128 
woFDN_FLA_SD_lgt_128 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 54.5) => -0.0104596742,
(r_C13_Curr_Addr_LRes_d > 54.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 41.45) => 0.0090640041,
   (c_hval_750k_p > 41.45) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 17.45) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 512101) => 0.2497400969,
         (f_prevaddrmedianvalue_d > 512101) => 
            map(
            (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 113.5) => -0.0133428293,
            (r_A50_pb_average_dollars_d > 113.5) => 0.1575936980,
            (r_A50_pb_average_dollars_d = NULL) => 0.0685507161, 0.0685507161),
         (f_prevaddrmedianvalue_d = NULL) => 0.1044571482, 0.1044571482),
      (c_pop_25_34_p > 17.45) => -0.0594553205,
      (c_pop_25_34_p = NULL) => 0.0652854910, 0.0652854910),
   (c_hval_750k_p = NULL) => -0.0225883514, 0.0118565444),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0188011362, 0.0017532043);

// Tree: 129 
woFDN_FLA_SD_lgt_129 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
   map(
   (NULL < c_totsales and c_totsales <= 33963.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 63.5) => 0.0716799399,
      (r_C13_Curr_Addr_LRes_d > 63.5) => -0.0506095587,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0151047270, 0.0151047270),
   (c_totsales > 33963.5) => 0.2072556057,
   (c_totsales = NULL) => 0.0498375389, 0.0498375389),
(r_I61_inq_collection_recency_d > 4.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.005) => -0.0067981335,
   (c_hhsize > 4.005) => 0.0590178488,
   (c_hhsize = NULL) => 0.0234274623, -0.0050840111),
(r_I61_inq_collection_recency_d = NULL) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.6) => -0.0825953007,
   (c_hval_175k_p > 2.6) => 0.0341552631,
   (c_hval_175k_p = NULL) => -0.0179655243, -0.0179655243), -0.0036818350);

// Tree: 130 
woFDN_FLA_SD_lgt_130 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 48.45) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 555) => -0.0061319858,
   (r_C13_max_lres_d > 555) => 0.1531985724,
   (r_C13_max_lres_d = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 98.5) => 0.0461801012,
      (c_many_cars > 98.5) => -0.0694797621,
      (c_many_cars = NULL) => -0.0078665639, -0.0078665639), -0.0054092700),
(c_rnt2001_p > 48.45) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 143.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 179.5) => -0.0242650704,
      (c_work_home > 179.5) => 0.2039074487,
      (c_work_home = NULL) => 0.0372018123, 0.0372018123),
   (c_lar_fam > 143.5) => 0.2181616048,
   (c_lar_fam = NULL) => 0.0688850083, 0.0688850083),
(c_rnt2001_p = NULL) => 0.0320466009, -0.0027869046);

// Tree: 131 
woFDN_FLA_SD_lgt_131 := map(
(NULL < c_white_col and c_white_col <= 11.65) => -0.1084957696,
(c_white_col > 11.65) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 29947) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 2.5) => 0.1587914287,
      (r_C14_addrs_15yr_i > 2.5) => -0.0401906925,
      (r_C14_addrs_15yr_i = NULL) => 0.0571530790, 0.0571530790),
   (r_L80_Inp_AVM_AutoVal_d > 29947) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.0978006729,
      (r_C10_M_Hdr_FS_d > 7.5) => 0.0008296052,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0644655466, 0.0023436779),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 7019) => -0.0316878762,
      (r_A49_Curr_AVM_Chg_1yr_i > 7019) => 0.0694456840,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0031819274, -0.0016932660), 0.0012563309),
(c_white_col = NULL) => -0.0010575003, 0.0005801157);

// Tree: 132 
woFDN_FLA_SD_lgt_132 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0005355568,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2110401682,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0136234291,
   (f_crim_rel_under25miles_cnt_i > 0.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 54.5) => 0.1309863321,
         (c_mort_indx > 54.5) => 0.0247385011,
         (c_mort_indx = NULL) => 0.0353175370, 0.0353175370),
      (c_pop_18_24_p > 11.15) => -0.0173999388,
      (c_pop_18_24_p = NULL) => 0.0221434888, 0.0221434888),
   (f_crim_rel_under25miles_cnt_i = NULL) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 55.9) => 0.1001810050,
      (c_oldhouse > 55.9) => -0.0182001411,
      (c_oldhouse = NULL) => 0.0126236290, 0.0126236290), 0.0005473642), 0.0009292146);

// Tree: 133 
woFDN_FLA_SD_lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 127.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 21.2) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 10.5) => 0.0618711786,
      (f_rel_under100miles_cnt_d > 10.5) => 0.2014028788,
      (f_rel_under100miles_cnt_d = NULL) => 0.1191981562, 0.1191981562),
   (c_hh1_p > 21.2) => 0.0012063128,
   (c_hh1_p = NULL) => 0.0486235957, 0.0486235957),
(f_mos_liens_unrel_SC_fseen_d > 127.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 12.5) => -0.0126100556,
      (k_inq_per_addr_i > 12.5) => 0.1106336743,
      (k_inq_per_addr_i = NULL) => -0.0113559252, -0.0113559252),
   (f_bus_name_nover_i > 0.5) => 0.0161356869,
   (f_bus_name_nover_i = NULL) => -0.0001842317, -0.0001842317),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0016862456, 0.0010750841);

// Tree: 134 
woFDN_FLA_SD_lgt_134 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 44.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -63.5) => -0.0570303975,
   (f_addrchangecrimediff_i > -63.5) => 0.0026625245,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32844350435) => 0.0260928374,
      (f_add_input_mobility_index_i > 0.32844350435) => -0.0320119043,
      (f_add_input_mobility_index_i = NULL) => 0.0367448584, 0.0068315629), 0.0027471787),
(f_rel_count_i > 44.5) => 
   map(
   (NULL < r_C20_email_count_i and r_C20_email_count_i <= 0.5) => 0.0259871668,
   (r_C20_email_count_i > 0.5) => -0.1213788572,
   (r_C20_email_count_i = NULL) => -0.0711010373, -0.0711010373),
(f_rel_count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 74.5) => -0.0669497166,
   (c_assault > 74.5) => 0.0473171625,
   (c_assault = NULL) => -0.0071464901, -0.0071464901), 0.0016709159);

// Tree: 135 
woFDN_FLA_SD_lgt_135 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => -0.0037273704,
(f_srchcomponentrisktype_i > 2.5) => 
   map(
   (NULL < c_food and c_food <= 3.45) => 0.1539660662,
   (c_food > 3.45) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 4.95) => -0.0316514793,
      (c_hval_150k_p > 4.95) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 38.5) => 0.2085584159,
         (f_prevaddrmurderindex_i > 38.5) => 
            map(
            (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 87) => 0.1201856104,
            (r_A50_pb_average_dollars_d > 87) => -0.0479162910,
            (r_A50_pb_average_dollars_d = NULL) => 0.0223558153, 0.0223558153),
         (f_prevaddrmurderindex_i = NULL) => 0.0764844783, 0.0764844783),
      (c_hval_150k_p = NULL) => 0.0128446563, 0.0128446563),
   (c_food = NULL) => 0.0364585974, 0.0364585974),
(f_srchcomponentrisktype_i = NULL) => -0.0003781456, -0.0020797472);

// Tree: 136 
woFDN_FLA_SD_lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.25) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 23.45) => 0.0101065630,
      (c_hh3_p > 23.45) => 
         map(
         (NULL < c_med_age and c_med_age <= 42.05) => 0.0467919958,
         (c_med_age > 42.05) => 0.2676076298,
         (c_med_age = NULL) => 0.0848379328, 0.0848379328),
      (c_hh3_p = NULL) => 0.0199861903, 0.0199861903),
   (c_hh7p_p > 7.25) => 0.1461509596,
   (c_hh7p_p = NULL) => 0.0788306450, 0.0265795983),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -33816.5) => -0.0807357205,
   (f_addrchangeincomediff_d > -33816.5) => -0.0063470116,
   (f_addrchangeincomediff_d = NULL) => -0.0055245377, -0.0069500820),
(f_hh_members_ct_d = NULL) => -0.0086069553, -0.0006100975);

// Tree: 137 
woFDN_FLA_SD_lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 0.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 87.5) => 0.1766476235,
      (c_rest_indx > 87.5) => 0.0109102572,
      (c_rest_indx = NULL) => 0.0593806191, 0.0593806191),
   (f_rel_under500miles_cnt_d > 0.5) => -0.0017317940,
   (f_rel_under500miles_cnt_d = NULL) => 0.0168462037, -0.0003367890),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.25) => -0.1102207568,
   (C_INC_75K_P > 15.25) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 100.5) => -0.0687175947,
      (c_blue_empl > 100.5) => 0.0563178802,
      (c_blue_empl = NULL) => -0.0019756858, -0.0019756858),
   (C_INC_75K_P = NULL) => -0.0339337544, -0.0339337544),
(f_inq_HighRiskCredit_count24_i = NULL) => -0.0135787269, -0.0010104644);

// Tree: 138 
woFDN_FLA_SD_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 59.45) => 0.0019863942,
   (c_lowinc > 59.45) => -0.0409636649,
   (c_lowinc = NULL) => -0.0187204600, -0.0000054148),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < c_larceny and c_larceny <= 131.5) => -0.1005731187,
      (c_larceny > 131.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.31149303095) => 0.1418504376,
         (f_add_curr_mobility_index_i > 0.31149303095) => -0.0490465147,
         (f_add_curr_mobility_index_i = NULL) => 0.0457344895, 0.0457344895),
      (c_larceny = NULL) => -0.0037120633, -0.0037120633),
   (f_vardobcountnew_i > 0.5) => 0.1495338907,
   (f_vardobcountnew_i = NULL) => 0.0409226806, 0.0409226806),
(f_curraddrcrimeindex_i = NULL) => -0.0294085938, 0.0007551416);

// Tree: 139 
woFDN_FLA_SD_lgt_139 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.1455324267,
      (f_prevaddrstatus_i > 2.5) => 0.0446053685,
      (f_prevaddrstatus_i = NULL) => 0.0901565187, 0.0901565187),
   (c_pop_45_54_p > 16.5) => -0.0422609735,
   (c_pop_45_54_p = NULL) => 0.0505610921, 0.0505610921),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_highinc and c_highinc <= 33.65) => -0.0073446852,
   (c_highinc > 33.65) => 0.0282465964,
   (c_highinc = NULL) => -0.0337182124, -0.0011284421),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 7.05) => -0.0514132063,
   (C_INC_25K_P > 7.05) => 0.0669528807,
   (C_INC_25K_P = NULL) => 0.0056177265, 0.0056177265), -0.0002156379);

// Tree: 140 
woFDN_FLA_SD_lgt_140 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => -0.0018401397,
   (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0668097355,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0015133938, -0.0015133938),
(f_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.0894647487,
      (f_adl_util_conv_n > 0.5) => -0.1271498495,
      (f_adl_util_conv_n = NULL) => -0.0028627850, -0.0028627850),
   (r_C23_inp_addr_occ_index_d > 2) => 0.1532805251,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0474500594, 0.0474500594),
(f_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 1.45) => -0.0716533622,
   (c_hval_125k_p > 1.45) => 0.0395462960,
   (c_hval_125k_p = NULL) => -0.0155030398, -0.0155030398), -0.0009388135);

// Tree: 141 
woFDN_FLA_SD_lgt_141 := map(
(NULL < c_rich_blk and c_rich_blk <= 166.5) => -0.0100265466,
(c_rich_blk > 166.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 375.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 25.65) => 0.0069465689,
      (c_hval_150k_p > 25.65) => 
         map(
         (NULL < c_health and c_health <= 8.1) => 0.2234104305,
         (c_health > 8.1) => -0.0122282371,
         (c_health = NULL) => 0.1161420818, 0.1161420818),
      (c_hval_150k_p = NULL) => 0.0114391076, 0.0114391076),
   (r_C21_M_Bureau_ADL_FS_d > 375.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 76206.5) => 0.1733739232,
      (f_prevaddrmedianincome_d > 76206.5) => 0.0224724353,
      (f_prevaddrmedianincome_d = NULL) => 0.0999998052, 0.0999998052),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0143069377, 0.0143069377),
(c_rich_blk = NULL) => -0.0223914659, -0.0038102565);

// Tree: 142 
woFDN_FLA_SD_lgt_142 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 17.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 7.7) => -0.0101443445,
      (c_famotf18_p > 7.7) => 0.1238256483,
      (c_famotf18_p = NULL) => 0.0714026077, 0.0714026077),
   (r_C13_max_lres_d > 17.5) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 25.5) => 0.0047108546,
      (f_rel_incomeover25_count_d > 25.5) => -0.0460625959,
      (f_rel_incomeover25_count_d = NULL) => -0.0380104528, 0.0027262493),
   (r_C13_max_lres_d = NULL) => 0.0035884867, 0.0035884867),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0521325473,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 1.55) => -0.0517794342,
   (c_hval_200k_p > 1.55) => 0.0581587995,
   (c_hval_200k_p = NULL) => 0.0031896826, 0.0031896826), 0.0011996508);

// Tree: 143 
woFDN_FLA_SD_lgt_143 := map(
(NULL < c_unempl and c_unempl <= 60.5) => -0.0240218321,
(c_unempl > 60.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 5.65) => -0.0595301061,
   (c_pop_35_44_p > 5.65) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 16940.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.45) => -0.0524097958,
         (c_pop_35_44_p > 12.45) => 
            map(
            (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.2150895993,
            (r_C18_invalid_addrs_per_adl_i > 0.5) => 0.0421960009,
            (r_C18_invalid_addrs_per_adl_i = NULL) => 0.1030740285, 0.1030740285),
         (c_pop_35_44_p = NULL) => 0.0488686586, 0.0488686586),
      (f_curraddrmedianincome_d > 16940.5) => 0.0062961002,
      (f_curraddrmedianincome_d = NULL) => 0.0253435155, 0.0074935277),
   (c_pop_35_44_p = NULL) => 0.0052265098, 0.0052265098),
(c_unempl = NULL) => 0.0019672998, -0.0018285043);

// Tree: 144 
woFDN_FLA_SD_lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 53) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 11.5) => -0.0022992988,
      (f_srchssnsrchcount_i > 11.5) => 
         map(
         (NULL < c_highrent and c_highrent <= 10.55) => 0.0833374498,
         (c_highrent > 10.55) => -0.0398211219,
         (c_highrent = NULL) => 0.0430310082, 0.0430310082),
      (f_srchssnsrchcount_i = NULL) => -0.0016619862, -0.0016619862),
   (f_assocsuspicousidcount_i > 9.5) => -0.0438434904,
   (f_assocsuspicousidcount_i = NULL) => -0.0135305570, -0.0028371728),
(c_rnt2001_p > 53) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 629990) => 0.0218276813,
   (f_prevaddrmedianvalue_d > 629990) => 0.1907170567,
   (f_prevaddrmedianvalue_d = NULL) => 0.0761372060, 0.0761372060),
(c_rnt2001_p = NULL) => 0.0140427641, -0.0008681083);

// Tree: 145 
woFDN_FLA_SD_lgt_145 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 57.5) => -0.0072356371,
(k_comb_age_d > 57.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 430261) => 0.0094886480,
      (f_curraddrmedianvalue_d > 430261) => 
         map(
         (NULL < c_hval_1000k_p and c_hval_1000k_p <= 1.65) => 0.2018564132,
         (c_hval_1000k_p > 1.65) => 0.0270519638,
         (c_hval_1000k_p = NULL) => 0.0610292993, 0.0610292993),
      (f_curraddrmedianvalue_d = NULL) => 0.0180714396, 0.0180714396),
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 13.75) => 0.0098579373,
      (C_INC_50K_P > 13.75) => 0.1625484696,
      (C_INC_50K_P = NULL) => 0.0750516477, 0.0750516477),
   (k_inq_per_addr_i = NULL) => 0.0220980710, 0.0220980710),
(k_comb_age_d = NULL) => -0.0013781454, -0.0013781454);

// Tree: 146 
woFDN_FLA_SD_lgt_146 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 163.5) => 0.0094730230,
      (r_C13_Curr_Addr_LRes_d > 163.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.55) => 0.0521392953,
         (r_C12_source_profile_d > 78.55) => 0.2985257332,
         (r_C12_source_profile_d = NULL) => 0.1199999668, 0.1199999668),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0208041953, 0.0208041953),
   (f_hh_members_ct_d > 1.5) => -0.0093947680,
   (f_hh_members_ct_d = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0589633416,
      (c_high_hval > 3.7) => 0.0827977103,
      (c_high_hval = NULL) => 0.0126053448, 0.0126053448), -0.0036826808),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1004090446,
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0029359447, -0.0029359447);

// Tree: 147 
woFDN_FLA_SD_lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 56.85) => -0.0010872062,
   (c_fammar18_p > 56.85) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 55.15) => 0.0194111998,
      (c_low_ed > 55.15) => 
         map(
         (NULL < c_rich_fam and c_rich_fam <= 84) => 0.0457981632,
         (c_rich_fam > 84) => 0.2660596861,
         (c_rich_fam = NULL) => 0.1559289246, 0.1559289246),
      (c_low_ed = NULL) => 0.0421315098, 0.0421315098),
   (c_fammar18_p = NULL) => -0.0360857442, 0.0005952636),
(f_prevaddrcartheftindex_i > 194.5) => -0.0706329751,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 38.6) => 0.0815845867,
   (c_low_ed > 38.6) => -0.0270900778,
   (c_low_ed = NULL) => 0.0185715459, 0.0185715459), -0.0002888595);

// Tree: 148 
woFDN_FLA_SD_lgt_148 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0066783922,
(k_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 20.45) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 6.5) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 22.5) => -0.0871649094,
         (r_A50_pb_total_dollars_d > 22.5) => 0.0225837957,
         (r_A50_pb_total_dollars_d = NULL) => 0.0154018764, 0.0154018764),
      (r_D30_Derog_Count_i > 6.5) => -0.0907073567,
      (r_D30_Derog_Count_i = NULL) => 0.0114332239, 0.0114332239),
   (c_hval_150k_p > 20.45) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 71.5) => 0.1726264038,
      (c_old_homes > 71.5) => -0.0071658435,
      (c_old_homes = NULL) => 0.0976210491, 0.0976210491),
   (c_hval_150k_p = NULL) => 0.0197263854, 0.0197263854),
(k_inq_ssns_per_addr_i = NULL) => -0.0031126544, -0.0031126544);

// Tree: 149 
woFDN_FLA_SD_lgt_149 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 46344) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => -0.0077881019,
   (r_D30_Derog_Count_i > 1.5) => -0.1051302400,
   (r_D30_Derog_Count_i = NULL) => -0.0399142201, -0.0399142201),
(r_L80_Inp_AVM_AutoVal_d > 46344) => 0.0100643524,
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 82.5) => 0.1009448969,
   (f_mos_liens_rel_CJ_lseen_d > 82.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => -0.0050570151,
      (f_inq_PrepaidCards_count_i > 0.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 118) => -0.0065426009,
         (c_sub_bus > 118) => 0.0971657513,
         (c_sub_bus = NULL) => 0.0453115752, 0.0453115752),
      (f_inq_PrepaidCards_count_i = NULL) => -0.0033660498, -0.0033660498),
   (f_mos_liens_rel_CJ_lseen_d = NULL) => -0.0248817334, -0.0023266779), 0.0034039965);

// Tree: 150 
woFDN_FLA_SD_lgt_150 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0168954152,
(f_corrrisktype_i > 5.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 22.85) => 
      map(
      (NULL < c_unempl and c_unempl <= 33.5) => -0.0665549986,
      (c_unempl > 33.5) => 0.0101848010,
      (c_unempl = NULL) => 0.0041346064, 0.0041346064),
   (C_INC_50K_P > 22.85) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.4105308332) => 
         map(
         (NULL < c_rental and c_rental <= 67.5) => 0.1643227252,
         (c_rental > 67.5) => 0.0026195982,
         (c_rental = NULL) => 0.0579206676, 0.0579206676),
      (f_add_curr_mobility_index_i > 0.4105308332) => 0.1625726467,
      (f_add_curr_mobility_index_i = NULL) => 0.0765420162, 0.0765420162),
   (C_INC_50K_P = NULL) => 0.0183412792, 0.0080070823),
(f_corrrisktype_i = NULL) => -0.0032759443, -0.0046456267);

// Tree: 151 
woFDN_FLA_SD_lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.99061691115) => 0.0028709677,
      (f_add_curr_nhood_MFD_pct_i > 0.99061691115) => -0.0840466458,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0188385561, -0.0019903162),
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.75) => -0.0290473342,
      (c_pop_45_54_p > 13.75) => 0.1865618181,
      (c_pop_45_54_p = NULL) => 0.0738120779, 0.0738120779),
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0013179440, -0.0013179440),
(r_C14_addrs_10yr_i > 10.5) => 0.1136772102,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.605) => 0.0460444504,
   (c_hhsize > 2.605) => -0.0580696758,
   (c_hhsize = NULL) => -0.0103109023, -0.0103109023), -0.0009211309);

// Tree: 152 
woFDN_FLA_SD_lgt_152 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.2816185383) => 
   map(
   (NULL < f_mos_liens_unrel_ST_fseen_d and f_mos_liens_unrel_ST_fseen_d <= 55.5) => 0.1458726071,
   (f_mos_liens_unrel_ST_fseen_d > 55.5) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 0.0086303442,
      (f_historical_count_d > 16.5) => 0.2030734505,
      (f_historical_count_d = NULL) => 0.0101661879, 0.0101661879),
   (f_mos_liens_unrel_ST_fseen_d = NULL) => 0.0233277300, 0.0113778551),
(f_add_input_mobility_index_i > 0.2816185383) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 178.5) => -0.0056744163,
   (c_serv_empl > 178.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 18.55) => -0.0704716104,
      (c_pop_35_44_p > 18.55) => 0.0230860397,
      (c_pop_35_44_p = NULL) => -0.0505545756, -0.0505545756),
   (c_serv_empl = NULL) => 0.0577565494, -0.0105626595),
(f_add_input_mobility_index_i = NULL) => 0.0532033990, 0.0027561372);

// Tree: 153 
woFDN_FLA_SD_lgt_153 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 7.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 42.5) => 0.0002779458,
      (r_C13_Curr_Addr_LRes_d > 42.5) => 0.1038797795,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0529876507, 0.0529876507),
   (r_I60_inq_recency_d > 2) => 0.0005968340,
   (r_I60_inq_recency_d = NULL) => 0.0035755284, 0.0035755284),
(f_rel_incomeover75_count_d > 7.5) => -0.0305374744,
(f_rel_incomeover75_count_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.15) => -0.0862215591,
   (c_pop_35_44_p > 13.15) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 36.4) => -0.0673528691,
      (c_sfdu_p > 36.4) => 0.0603096383,
      (c_sfdu_p = NULL) => 0.0138869083, 0.0138869083),
   (c_pop_35_44_p = NULL) => -0.0244724110, -0.0244724110), -0.0007218027);

// Tree: 154 
woFDN_FLA_SD_lgt_154 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 16.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 8.5) => -0.0088088850,
   (f_util_adl_count_n > 8.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','6: Other']) => 0.0201610469,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','5: Vuln Vic/Friendly']) => 0.1462226744,
      (nf_seg_FraudPoint_3_0 = '') => 0.0464386819, 0.0464386819),
   (f_util_adl_count_n = NULL) => -0.0235574054, -0.0069861657),
(c_hval_500k_p > 16.15) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 0.0152092474,
   (k_comb_age_d > 71.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1974.5) => 0.2529969963,
      (c_med_yearblt > 1974.5) => -0.0617660620,
      (c_med_yearblt = NULL) => 0.1045238556, 0.1045238556),
   (k_comb_age_d = NULL) => 0.0192157427, 0.0192157427),
(c_hval_500k_p = NULL) => 0.0213917540, -0.0014564293);

// Tree: 155 
woFDN_FLA_SD_lgt_155 := map(
(NULL < c_unempl and c_unempl <= 190.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72593) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 91.5) => 0.1198636323,
      (c_easiqlife > 91.5) => -0.0004124303,
      (c_easiqlife = NULL) => 0.0363246097, 0.0363246097),
   (f_addrchangevaluediff_d > -72593) => -0.0010135616,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 79.5) => -0.0585398911,
      (c_span_lang > 79.5) => 0.0073668358,
      (c_span_lang = NULL) => -0.0142332906, -0.0142332906), -0.0029806522),
(c_unempl > 190.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.27882212485) => -0.0207270699,
   (f_add_curr_mobility_index_i > 0.27882212485) => 0.1434956341,
   (f_add_curr_mobility_index_i = NULL) => 0.0669511535, 0.0669511535),
(c_unempl = NULL) => 0.0244273976, -0.0016989867);

// Tree: 156 
woFDN_FLA_SD_lgt_156 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => -0.0047827648,
   (f_crim_rel_under500miles_cnt_i > 2.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 9.85) => 0.0057935907,
      (c_hval_200k_p > 9.85) => 0.0912842220,
      (c_hval_200k_p = NULL) => 0.0241827080, 0.0241827080),
   (f_crim_rel_under500miles_cnt_i = NULL) => -0.0216349268, 0.0004108733),
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 41) => 0.0303885088,
   (f_fp_prevaddrburglaryindex_i > 41) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 7.5) => -0.0863720202,
      (r_C14_addrs_15yr_i > 7.5) => 0.0118519313,
      (r_C14_addrs_15yr_i = NULL) => -0.0637670560, -0.0637670560),
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0394626724, -0.0394626724),
(f_srchssnsrchcount_i = NULL) => 0.0004657926, -0.0011351932);

// Tree: 157 
woFDN_FLA_SD_lgt_157 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0137553948,
   (f_util_add_curr_conv_n > 0.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 14.5) => 
         map(
         (NULL < c_hval_1001k_p and c_hval_1001k_p <= 22.8) => 0.0076813737,
         (c_hval_1001k_p > 22.8) => 
            map(
            (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 113.5) => 0.0313472691,
            (f_prevaddrcartheftindex_i > 113.5) => 0.2807482808,
            (f_prevaddrcartheftindex_i = NULL) => 0.1127417415, 0.1127417415),
         (c_hval_1001k_p = NULL) => 0.0074385181, 0.0112346476),
      (f_inq_HighRiskCredit_count_i > 14.5) => 0.0967505516,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0118837703, 0.0118837703),
   (f_util_add_curr_conv_n = NULL) => 0.0006838880, 0.0006838880),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0903847143,
(r_S65_SSN_Prior_DoB_i = NULL) => 0.0010516303, 0.0010516303);

// Tree: 158 
woFDN_FLA_SD_lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0012294240,
      (f_assocsuspicousidcount_i > 13.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 64353.5) => 0.1615411795,
         (f_curraddrmedianincome_d > 64353.5) => -0.0345780912,
         (f_curraddrmedianincome_d = NULL) => 0.0625106566, 0.0625106566),
      (f_assocsuspicousidcount_i = NULL) => -0.0007086548, -0.0007086548),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 5728) => -0.1491692880,
      (r_A50_pb_total_dollars_d > 5728) => 0.0145273909,
      (r_A50_pb_total_dollars_d = NULL) => -0.0605002536, -0.0605002536),
   (r_I60_inq_comm_count12_i = NULL) => -0.0013971236, -0.0013971236),
(r_D33_eviction_count_i > 3.5) => 0.0792679331,
(r_D33_eviction_count_i = NULL) => 0.0202718499, -0.0007425353);

// Tree: 159 
woFDN_FLA_SD_lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0009030282,
   (f_srchunvrfdaddrcount_i > 0.5) => 0.0362125646,
   (f_srchunvrfdaddrcount_i = NULL) => -0.0000237838, -0.0000237838),
(f_rel_homeover500_count_d > 19.5) => 0.1143194999,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.14038461535) => 
      map(
      (NULL < c_burglary and c_burglary <= 96.5) => -0.0681548399,
      (c_burglary > 96.5) => 
         map(
         (NULL < C_INC_100K_P and C_INC_100K_P <= 12.35) => -0.0322986588,
         (C_INC_100K_P > 12.35) => 0.1149469890,
         (C_INC_100K_P = NULL) => 0.0384925180, 0.0384925180),
      (c_burglary = NULL) => -0.0244882051, -0.0244882051),
   (f_add_input_nhood_BUS_pct_i > 0.14038461535) => 0.1361558789,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0047664683, 0.0047664683), 0.0006458317);

// Tree: 160 
woFDN_FLA_SD_lgt_160 := map(
(NULL < c_hval_40k_p and c_hval_40k_p <= 21.75) => -0.0020164848,
(c_hval_40k_p > 21.75) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 6.15) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 52.95) => -0.1215913282,
      (r_C12_source_profile_d > 52.95) => 0.0580995401,
      (r_C12_source_profile_d = NULL) => -0.0124933010, -0.0124933010),
   (c_pop_65_74_p > 6.15) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 144.5) => 0.0409844824,
      (f_curraddrcrimeindex_i > 144.5) => 0.2425869507,
      (f_curraddrcrimeindex_i = NULL) => 0.1434942120, 0.1434942120),
   (c_pop_65_74_p = NULL) => 0.0595009358, 0.0595009358),
(c_hval_40k_p = NULL) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 14.5) => 0.1240094340,
   (r_C13_Curr_Addr_LRes_d > 14.5) => -0.0432084372,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0142780096, -0.0142780096), -0.0010368690);

// Tree: 161 
woFDN_FLA_SD_lgt_161 := map(
(NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 124.5) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 55.3) => -0.0252983321,
   (C_RENTOCC_P > 55.3) => -0.1167025197,
   (C_RENTOCC_P = NULL) => -0.0387665326, -0.0387665326),
(f_mos_liens_unrel_CJ_fseen_d > 124.5) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 6499) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 150.5) => -0.0093450663,
      (c_easiqlife > 150.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -2.5) => 0.1009894633,
         (f_addrchangecrimediff_i > -2.5) => 0.0144073179,
         (f_addrchangecrimediff_i = NULL) => 0.0228356465, 0.0195589245),
      (c_easiqlife = NULL) => -0.0315817094, -0.0047960693),
   (f_liens_unrel_CJ_total_amt_i > 6499) => 0.0844823747,
   (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0040640970, -0.0040640970),
(f_mos_liens_unrel_CJ_fseen_d = NULL) => -0.0071715779, -0.0054838045);

// Tree: 162 
woFDN_FLA_SD_lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0006266520,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_rental and c_rental <= 119) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 11.5) => 0.0261092667,
      (f_rel_educationover12_count_d > 11.5) => 0.1692940683,
      (f_rel_educationover12_count_d = NULL) => 0.0936996078, 0.0936996078),
   (c_rental > 119) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 4.65) => 0.0421271474,
      (c_hval_150k_p > 4.65) => -0.0824492139,
      (c_hval_150k_p = NULL) => -0.0229500562, -0.0229500562),
   (c_rental = NULL) => 0.0407129807, 0.0407129807),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.45) => -0.0413839308,
   (c_pop_55_64_p > 9.45) => 0.0579345292,
   (c_pop_55_64_p = NULL) => 0.0139883080, 0.0139883080), 0.0004772058);

// Tree: 163 
woFDN_FLA_SD_lgt_163 := map(
(NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 16.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 37.45) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 3.65) => 
         map(
         (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.79765908125) => 0.0946513998,
         (f_add_input_nhood_SFD_pct_d > 0.79765908125) => -0.0186341641,
         (f_add_input_nhood_SFD_pct_d = NULL) => 0.0387442384, 0.0387442384),
      (c_high_ed > 3.65) => -0.0029272831,
      (c_high_ed = NULL) => -0.0018678668, -0.0018678668),
   (c_hval_20k_p > 37.45) => 0.0923094347,
   (c_hval_20k_p = NULL) => 0.0116541007, -0.0010887226),
(f_inq_Collection_count_i > 16.5) => -0.0665946106,
(f_inq_Collection_count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 30.5) => -0.0858000620,
   (k_comb_age_d > 30.5) => 0.0429332001,
   (k_comb_age_d = NULL) => -0.0214334309, -0.0214334309), -0.0018745021);

// Tree: 164 
woFDN_FLA_SD_lgt_164 := map(
(NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 4.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 98.5) => -0.0073918282,
         (c_burglary > 98.5) => 0.1239653208,
         (c_burglary = NULL) => 0.0540688562, 0.0540688562),
      (f_attr_arrest_recency_d > 99.5) => -0.0026974976,
      (f_attr_arrest_recency_d = NULL) => -0.0021553973, -0.0021553973),
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 186.5) => 0.0281487790,
      (c_rich_blk > 186.5) => 0.1473677883,
      (c_rich_blk = NULL) => 0.0563362370, 0.0414049367),
   (r_L70_Add_Standardized_i = NULL) => 0.0015430228, 0.0015430228),
(f_inq_Other_count24_i > 4.5) => 0.0913463435,
(f_inq_Other_count24_i = NULL) => 0.0022886883, 0.0023207418);

// Tree: 165 
woFDN_FLA_SD_lgt_165 := map(
(NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 9.5) => 0.0079952150,
(f_rel_homeover150_count_d > 9.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 65.4) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 37387) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0106394781,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1143563118,
         (nf_seg_FraudPoint_3_0 = '') => 0.0304550281, 0.0304550281),
      (f_prevaddrmedianincome_d > 37387) => -0.0338431413,
      (f_prevaddrmedianincome_d = NULL) => -0.0280412051, -0.0280412051),
   (c_rnt1000_p > 65.4) => 0.0945589034,
   (c_rnt1000_p = NULL) => -0.0233295528, -0.0233295528),
(f_rel_homeover150_count_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 197213) => 0.1018653376,
   (r_L80_Inp_AVM_AutoVal_d > 197213) => -0.0369113031,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0028832899, 0.0156555368), 0.0019303101);

// Tree: 166 
woFDN_FLA_SD_lgt_166 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 45.5) => 0.1404573803,
   (f_mos_inq_banko_cm_lseen_d > 45.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 82.5) => 0.1256280252,
      (c_rich_fam > 82.5) => -0.0503751887,
      (c_rich_fam = NULL) => 0.0163449839, 0.0163449839),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0490061409, 0.0490061409),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 194.5) => 0.0010172488,
   (c_asian_lang > 194.5) => -0.0507397125,
   (c_asian_lang = NULL) => 0.0201140412, -0.0008182934),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.95) => -0.0580729281,
   (c_pop_6_11_p > 7.95) => 0.0382948188,
   (c_pop_6_11_p = NULL) => -0.0063198789, -0.0063198789), -0.0000459537);

// Tree: 167 
woFDN_FLA_SD_lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 57.25) => 
         map(
         (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 194) => 0.0257509632,
         (f_liens_unrel_CJ_total_amt_i > 194) => -0.0822238943,
         (f_liens_unrel_CJ_total_amt_i = NULL) => 0.0181344795, 0.0181344795),
      (c_rnt750_p > 57.25) => 0.1446968617,
      (c_rnt750_p = NULL) => 0.0265883075, 0.0265883075),
   (r_C12_source_profile_d > 81.3) => 0.1861673066,
   (r_C12_source_profile_d = NULL) => 0.0346552606, 0.0346552606),
(c_many_cars > 22.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.49) => -0.0066972309,
   (c_hhsize > 4.49) => -0.1225609919,
   (c_hhsize = NULL) => -0.0073124912, -0.0073124912),
(c_many_cars = NULL) => 0.0087901229, -0.0033101361);

// Tree: 168 
woFDN_FLA_SD_lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => 
   map(
   (NULL < f_hh_age_30_plus_d and f_hh_age_30_plus_d <= 5.5) => -0.0047722647,
   (f_hh_age_30_plus_d > 5.5) => -0.0539190562,
   (f_hh_age_30_plus_d = NULL) => 0.0260125056, -0.0059916099),
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.05) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 17.5) => 0.0132166135,
      (f_rel_under500miles_cnt_d > 17.5) => 0.1363208749,
      (f_rel_under500miles_cnt_d = NULL) => 0.0250662215, 0.0250662215),
   (r_C12_source_profile_d > 81.05) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 1.05) => 0.3030724630,
      (c_hval_80k_p > 1.05) => 0.0232900027,
      (c_hval_80k_p = NULL) => 0.1645662945, 0.1645662945),
   (r_C12_source_profile_d = NULL) => 0.0413358605, 0.0413358605),
(c_hval_150k_p = NULL) => -0.0099138991, -0.0028266292);

// Tree: 169 
woFDN_FLA_SD_lgt_169 := map(
(NULL < c_unempl and c_unempl <= 189.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 12.05) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 36.25) => -0.0053335292,
      (c_hval_500k_p > 36.25) => 
         map(
         (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 0.1174776066,
         (f_rel_incomeover100_count_d > 0.5) => -0.0002964785,
         (f_rel_incomeover100_count_d = NULL) => 0.0537800732, 0.0537800732),
      (c_hval_500k_p = NULL) => -0.0035698119, -0.0035698119),
   (c_unemp > 12.05) => -0.0985760628,
   (c_unemp = NULL) => -0.0040193439, -0.0040193439),
(c_unempl > 189.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 69.5) => 0.1389167486,
   (c_blue_empl > 69.5) => -0.0183312682,
   (c_blue_empl = NULL) => 0.0503263166, 0.0503263166),
(c_unempl = NULL) => -0.0005192984, -0.0033323437);

// Tree: 170 
woFDN_FLA_SD_lgt_170 := map(
(NULL < c_low_ed and c_low_ed <= 77.45) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 7.95) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 1.5) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.19220044965) => 0.2439682791,
            (f_add_curr_mobility_index_i > 0.19220044965) => 0.0558484106,
            (f_add_curr_mobility_index_i = NULL) => 0.0788079221, 0.0788079221),
         (f_rel_homeover300_count_d > 1.5) => 0.0022828987,
         (f_rel_homeover300_count_d = NULL) => 0.0448154063, 0.0448154063),
      (c_femdiv_p > 7.95) => -0.0539679661,
      (c_femdiv_p = NULL) => 0.0287988993, 0.0287988993),
   (r_I60_inq_comm_recency_d > 549) => 0.0014192232,
   (r_I60_inq_comm_recency_d = NULL) => 0.0147854849, 0.0040363289),
(c_low_ed > 77.45) => -0.0457530876,
(c_low_ed = NULL) => -0.0277133410, 0.0020396120);

// Tree: 171 
woFDN_FLA_SD_lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 11.5) => 0.1277282738,
   (r_D32_Mos_Since_Crim_LS_d > 11.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 183.5) => 
         map(
         (NULL < c_hval_100k_p and c_hval_100k_p <= 1.95) => 0.0409058350,
         (c_hval_100k_p > 1.95) => -0.0173469740,
         (c_hval_100k_p = NULL) => 0.0276014177, 0.0123316772),
      (f_curraddrcartheftindex_i > 183.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 95) => 0.1552562334,
         (c_relig_indx > 95) => 0.0246435463,
         (c_relig_indx = NULL) => 0.0737460603, 0.0737460603),
      (f_curraddrcartheftindex_i = NULL) => 0.0169127837, 0.0169127837),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0204039833, 0.0204039833),
(f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0017677174,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0127648818, 0.0013590779);

// Tree: 172 
woFDN_FLA_SD_lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.55) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 5.5) => -0.0102324818,
         (f_corrssnnamecount_d > 5.5) => -0.0911842673,
         (f_corrssnnamecount_d = NULL) => -0.0396976911, -0.0396976911),
      (f_corrssnaddrcount_d > 0.5) => 0.0023070960,
      (f_corrssnaddrcount_d = NULL) => 0.0216580957, 0.0015007248),
   (c_manufacturing > 16.55) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 4.5) => -0.0424318022,
      (r_D30_Derog_Count_i > 4.5) => -0.1214188935,
      (r_D30_Derog_Count_i = NULL) => -0.0466287784, -0.0466287784),
   (c_manufacturing = NULL) => -0.0022087306, -0.0022087306),
(c_pop_0_5_p > 20.55) => 0.1369316821,
(c_pop_0_5_p = NULL) => 0.0019947381, -0.0014857150);

// Tree: 173 
woFDN_FLA_SD_lgt_173 := map(
(NULL < c_low_hval and c_low_hval <= 71.55) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 142258) => 
      map(
      (NULL < c_food and c_food <= 3.95) => 
         map(
         (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 549) => -0.1063663150,
         (r_I60_inq_hiRiskCred_recency_d > 549) => -0.0124368633,
         (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0239790417, -0.0239790417),
      (c_food > 3.95) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -1654.5) => 0.1012552889,
         (f_addrchangevaluediff_d > -1654.5) => 0.0256620061,
         (f_addrchangevaluediff_d = NULL) => 0.0580386008, 0.0342427012),
      (c_food = NULL) => 0.0225197078, 0.0225197078),
   (r_L80_Inp_AVM_AutoVal_d > 142258) => -0.0089253723,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0028434080, -0.0003327686),
(c_low_hval > 71.55) => -0.1104979949,
(c_low_hval = NULL) => -0.0394847056, -0.0018956304);

// Tree: 174 
woFDN_FLA_SD_lgt_174 := map(
(NULL < c_info and c_info <= 27.55) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 1.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 26.5) => 0.1866547158,
         (r_C13_max_lres_d > 26.5) => 
            map(
            (NULL < c_very_rich and c_very_rich <= 171) => 0.0059689641,
            (c_very_rich > 171) => 0.2225980400,
            (c_very_rich = NULL) => 0.0446793144, 0.0446793144),
         (r_C13_max_lres_d = NULL) => 0.0682740803, 0.0682740803),
      (f_rel_count_i > 1.5) => 0.0006117825,
      (f_rel_count_i = NULL) => 0.0026309481, 0.0026309481),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0527415619,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0333103547, -0.0000021577),
(c_info > 27.55) => 0.2286753842,
(c_info = NULL) => -0.0065564778, 0.0010305742);

// Tree: 175 
woFDN_FLA_SD_lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0093691509,
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2) => 0.0037894523,
   (f_idverrisktype_i > 2) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 136.5) => 0.0243787048,
      (c_serv_empl > 136.5) => 
         map(
         (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 
            map(
            (NULL < c_bargains and c_bargains <= 107.5) => -0.0132730344,
            (c_bargains > 107.5) => 0.1748436216,
            (c_bargains = NULL) => 0.0798540230, 0.0798540230),
         (f_util_add_input_misc_n > 0.5) => 0.2555180946,
         (f_util_add_input_misc_n = NULL) => 0.1453188944, 0.1453188944),
      (c_serv_empl = NULL) => 0.0623345928, 0.0623345928),
   (f_idverrisktype_i = NULL) => 0.0151633383, 0.0151633383),
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0081702492, -0.0039538578);

// Tree: 176 
woFDN_FLA_SD_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0046116276,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 91.5) => -0.0173238859,
         (c_many_cars > 91.5) => 
            map(
            (NULL < c_rape and c_rape <= 112.5) => 0.0567798021,
            (c_rape > 112.5) => 0.2295510197,
            (c_rape = NULL) => 0.0905690071, 0.0905690071),
         (c_many_cars = NULL) => 0.0351697838, 0.0351697838),
      (c_pop_55_64_p > 17.45) => 0.2615629176,
      (c_pop_55_64_p = NULL) => 0.0548400069, 0.0548400069),
   (f_util_adl_count_n = NULL) => 0.0019402580, 0.0078118004),
(c_pop_18_24_p > 11.15) => -0.0242170130,
(c_pop_18_24_p = NULL) => 0.0240564912, 0.0008961428);

// Tree: 177 
woFDN_FLA_SD_lgt_177 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 104.5) => -0.0043158170,
(f_prevaddrageoldest_d > 104.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 556.25) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 113500) => 0.0082990521,
      (k_estimated_income_d > 113500) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 35.5) => 
            map(
            (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 312) => 0.3200353456,
            (f_M_Bureau_ADL_FS_all_d > 312) => 0.0817193518,
            (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1907792134, 0.1907792134),
         (c_born_usa > 35.5) => 0.0247674583,
         (c_born_usa = NULL) => 0.0755171658, 0.0755171658),
      (k_estimated_income_d = NULL) => 0.0142431969, 0.0142431969),
   (c_oldhouse > 556.25) => 0.1027887307,
   (c_oldhouse = NULL) => 0.0630459919, 0.0167809049),
(f_prevaddrageoldest_d = NULL) => -0.0183275289, 0.0031209911);

// Tree: 178 
woFDN_FLA_SD_lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 14.55) => -0.0077486141,
(c_rnt1250_p > 14.55) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.35) => 0.0044621516,
   (c_pop_6_11_p > 9.35) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 2.435) => 0.2579913572,
      (c_hhsize > 2.435) => 
         map(
         (NULL < c_hval_400k_p and c_hval_400k_p <= 15.15) => 
            map(
            (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 184) => 0.0326728714,
            (r_pb_order_freq_d > 184) => 0.1847127805,
            (r_pb_order_freq_d = NULL) => 0.1264902937, 0.0882762312),
         (c_hval_400k_p > 15.15) => 0.0071646708,
         (c_hval_400k_p = NULL) => 0.0478782556, 0.0478782556),
      (c_hhsize = NULL) => 0.0576237612, 0.0576237612),
   (c_pop_6_11_p = NULL) => 0.0200732154, 0.0200732154),
(c_rnt1250_p = NULL) => 0.0035319509, 0.0005670551);

// Tree: 179 
woFDN_FLA_SD_lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0009199651,
   (f_assocsuspicousidcount_i > 13.5) => 0.0852376304,
   (f_assocsuspicousidcount_i = NULL) => -0.0004931959, -0.0004931959),
(f_rel_incomeover50_count_d > 22.5) => -0.0523934287,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.85) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 158.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 92.85) => 0.1703471212,
         (c_occunit_p > 92.85) => 0.0625910938,
         (c_occunit_p = NULL) => 0.1219841798, 0.1219841798),
      (c_asian_lang > 158.5) => -0.0266293191,
      (c_asian_lang = NULL) => 0.0591612007, 0.0591612007),
   (c_pop_45_54_p > 16.85) => -0.0989645249,
   (c_pop_45_54_p = NULL) => 0.0181656422, 0.0181656422), -0.0011202940);

// Tree: 180 
woFDN_FLA_SD_lgt_180 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 996) => 
   map(
   (NULL < k_inq_adls_per_ssn_i and k_inq_adls_per_ssn_i <= 1.5) => 
      map(
      (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 69.5) => 
            map(
            (NULL < c_hh4_p and c_hh4_p <= 31.2) => 0.0254812254,
            (c_hh4_p > 31.2) => 0.1634686964,
            (c_hh4_p = NULL) => 0.0309714431, 0.0309714431),
         (c_ab_av_edu > 69.5) => 0.0000383193,
         (c_ab_av_edu = NULL) => 0.0389157763, 0.0074502188),
      (f_dl_addrs_per_adl_i > 0.5) => -0.0147869649,
      (f_dl_addrs_per_adl_i = NULL) => -0.0014725047, -0.0014725047),
   (k_inq_adls_per_ssn_i > 1.5) => 0.1281625447,
   (k_inq_adls_per_ssn_i = NULL) => -0.0009232476, -0.0009232476),
(f_liens_rel_SC_total_amt_i > 996) => -0.1037770460,
(f_liens_rel_SC_total_amt_i = NULL) => 0.0066729597, -0.0014708879);

// Tree: 181 
woFDN_FLA_SD_lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 5.35) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1951.5) => 0.1003426577,
      (c_med_yearblt > 1951.5) => -0.0250500296,
      (c_med_yearblt = NULL) => -0.0020138730, -0.0020138730),
   (c_hval_200k_p > 5.35) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0611586751) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 10.5) => 0.1496259204,
         (f_M_Bureau_ADL_FS_all_d > 10.5) => 0.0160732152,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0573277158, 0.0573277158),
      (f_add_input_nhood_VAC_pct_i > 0.0611586751) => 0.2417120070,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0979675187, 0.0979675187),
   (c_hval_200k_p = NULL) => 0.0296749251, 0.0296749251),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0046760044,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0129397083, -0.0024151067);

// Tree: 182 
woFDN_FLA_SD_lgt_182 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 897809.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37644446705) => 
      map(
      (NULL < c_incollege and c_incollege <= 26.65) => 0.0039516011,
      (c_incollege > 26.65) => 0.1619855115,
      (c_incollege = NULL) => -0.0442433990, 0.0043752126),
   (f_add_input_mobility_index_i > 0.37644446705) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 64.95) => -0.0306445045,
      (c_rnt750_p > 64.95) => 0.0768893584,
      (c_rnt750_p = NULL) => 0.0322555037, -0.0225479694),
   (f_add_input_mobility_index_i = NULL) => 0.0576107021, 0.0001913896),
(f_curraddrmedianvalue_d > 897809.5) => 0.1464262620,
(f_curraddrmedianvalue_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0517943023,
   (k_nap_lname_verd_d > 0.5) => -0.0757877028,
   (k_nap_lname_verd_d = NULL) => -0.0114114617, -0.0114114617), 0.0009447731);

// Tree: 183 
woFDN_FLA_SD_lgt_183 := map(
(NULL < c_oldhouse and c_oldhouse <= 613.2) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 189) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0035770834,
      (k_inq_adls_per_addr_i > 3.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => -0.0305115229,
         (r_D30_Derog_Count_i > 1.5) => -0.1197122395,
         (r_D30_Derog_Count_i = NULL) => -0.0512737587, -0.0512737587),
      (k_inq_adls_per_addr_i = NULL) => -0.0045300395, -0.0045300395),
   (c_totcrime > 189) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => -0.0079361166,
      (f_sourcerisktype_i > 4.5) => 0.1285928800,
      (f_sourcerisktype_i = NULL) => 0.0610273356, 0.0610273356),
   (c_totcrime = NULL) => -0.0029087105, -0.0029087105),
(c_oldhouse > 613.2) => -0.0564897199,
(c_oldhouse = NULL) => 0.0155811349, -0.0041334978);

// Tree: 184 
woFDN_FLA_SD_lgt_184 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => 0.0001102598,
(f_util_adl_count_n > 7.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 163.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 3.5) => 0.2154704542,
      (f_rel_ageover30_count_d > 3.5) => 
         map(
         (NULL < c_retired and c_retired <= 13.65) => -0.0004125855,
         (c_retired > 13.65) => 
            map(
            (NULL < c_business and c_business <= 31.5) => 0.2018810428,
            (c_business > 31.5) => 0.0161243243,
            (c_business = NULL) => 0.1205277355, 0.1205277355),
         (c_retired = NULL) => 0.0437709451, 0.0437709451),
      (f_rel_ageover30_count_d = NULL) => 0.0681310585, 0.0681310585),
   (c_sub_bus > 163.5) => -0.0722081390,
   (c_sub_bus = NULL) => 0.0400120936, 0.0400120936),
(f_util_adl_count_n = NULL) => -0.0100106904, 0.0017966541);

// Tree: 185 
woFDN_FLA_SD_lgt_185 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.03169679135) => -0.0655843149,
   (f_add_curr_nhood_MFD_pct_i > 0.03169679135) => 
      map(
      (NULL < c_child and c_child <= 21.15) => -0.0607277605,
      (c_child > 21.15) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 161) => 
            map(
            (NULL < c_med_yearblt and c_med_yearblt <= 1957.5) => 0.1893087973,
            (c_med_yearblt > 1957.5) => 0.0773728238,
            (c_med_yearblt = NULL) => 0.1087148964, 0.1087148964),
         (c_old_homes > 161) => -0.0178637585,
         (c_old_homes = NULL) => 0.0777073735, 0.0777073735),
      (c_child = NULL) => 0.0486984197, 0.0486984197),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0508505024, 0.0348109019),
(k_estimated_income_d > 27500) => 0.0012358149,
(k_estimated_income_d = NULL) => -0.0063326763, 0.0028214714);

// Tree: 186 
woFDN_FLA_SD_lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.99152143005) => -0.0020727478,
   (f_add_input_nhood_SFD_pct_d > 0.99152143005) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 0.05) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00698434375) => 0.0176271581,
         (f_add_curr_nhood_VAC_pct_i > 0.00698434375) => 0.2060542570,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1146001002, 0.1146001002),
      (c_hval_250k_p > 0.05) => 
         map(
         (NULL < c_food and c_food <= 56.75) => 0.0068399131,
         (c_food > 56.75) => 0.1810296431,
         (c_food = NULL) => 0.0168747563, 0.0168747563),
      (c_hval_250k_p = NULL) => 0.0370269195, 0.0370269195),
   (f_add_input_nhood_SFD_pct_d = NULL) => 0.0016195481, 0.0016195481),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0758028983,
(f_inq_PrepaidCards_count_i = NULL) => 0.0315202706, 0.0021615453);

// Tree: 187 
woFDN_FLA_SD_lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 1.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => -0.0024635282,
      (r_L79_adls_per_addr_c6_i > 4.5) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 52.95) => 0.0021737443,
         (c_low_ed > 52.95) => 0.0954276346,
         (c_low_ed = NULL) => 0.0326378101, 0.0326378101),
      (r_L79_adls_per_addr_c6_i = NULL) => -0.0008489522, -0.0008489522),
   (f_divsrchaddrsuspidcount_i > 1.5) => -0.0665695200,
   (f_divsrchaddrsuspidcount_i = NULL) => -0.0014155088, -0.0014155088),
(f_rel_bankrupt_count_i > 7.5) => -0.0781925777,
(f_rel_bankrupt_count_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.95) => -0.0483217473,
   (c_hh4_p > 11.95) => 0.0463014067,
   (c_hh4_p = NULL) => -0.0005761191, -0.0005761191), -0.0023764454);

// Tree: 188 
woFDN_FLA_SD_lgt_188 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 19.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog','6: Other']) => -0.0147169596,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0106113036,
      (nf_seg_FraudPoint_3_0 = '') => -0.0013888832, -0.0013888832),
   (f_srchfraudsrchcount_i > 12.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.15) => -0.0025870388,
      (c_pop_45_54_p > 14.15) => 0.1254376142,
      (c_pop_45_54_p = NULL) => 0.0531783008, 0.0531783008),
   (f_srchfraudsrchcount_i = NULL) => -0.0006786340, -0.0006786340),
(f_inq_count24_i > 19.5) => -0.1253418697,
(f_inq_count24_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 96.5) => -0.0558651815,
   (c_burglary > 96.5) => 0.0643035901,
   (c_burglary = NULL) => 0.0019518690, 0.0019518690), -0.0011668589);

// Tree: 189 
woFDN_FLA_SD_lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 38.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 160500) => -0.0062822209,
      (k_estimated_income_d > 160500) => 0.1739571375,
      (k_estimated_income_d = NULL) => -0.0053395777, -0.0053395777),
   (f_rel_homeover500_count_d > 14.5) => 
      map(
      (NULL < c_burglary and c_burglary <= 45.5) => 0.1791029323,
      (c_burglary > 45.5) => -0.0431099858,
      (c_burglary = NULL) => 0.0711709435, 0.0711709435),
   (f_rel_homeover500_count_d = NULL) => -0.0001145407, -0.0046041635),
(f_phones_per_addr_curr_i > 38.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => -0.0040295714,
   (f_rel_under25miles_cnt_d > 4.5) => 0.1380875222,
   (f_rel_under25miles_cnt_d = NULL) => 0.0544522415, 0.0544522415),
(f_phones_per_addr_curr_i = NULL) => -0.0006354741, -0.0034837773);

// Tree: 190 
woFDN_FLA_SD_lgt_190 := map(
(NULL < c_hh2_p and c_hh2_p <= 51.15) => -0.0079627893,
(c_hh2_p > 51.15) => 
   map(
   (NULL < c_rape and c_rape <= 14.5) => 0.2486247932,
   (c_rape > 14.5) => 
      map(
      (NULL < f_varmsrcssnunrelcount_i and f_varmsrcssnunrelcount_i <= 0.5) => 0.1615249309,
      (f_varmsrcssnunrelcount_i > 0.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 12.8) => -0.0641534261,
         (c_hh3_p > 12.8) => 
            map(
            (NULL < c_mort_indx and c_mort_indx <= 100.5) => 0.1955705826,
            (c_mort_indx > 100.5) => -0.0159985928,
            (c_mort_indx = NULL) => 0.0786507752, 0.0786507752),
         (c_hh3_p = NULL) => -0.0185520845, -0.0185520845),
      (f_varmsrcssnunrelcount_i = NULL) => 0.0177050327, 0.0177050327),
   (c_rape = NULL) => 0.0420365383, 0.0420365383),
(c_hh2_p = NULL) => -0.0268615234, -0.0064166850);

// Tree: 191 
woFDN_FLA_SD_lgt_191 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 169.5) => -0.0038447305,
(f_fp_prevaddrcrimeindex_i > 169.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.09515227815) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 15.5) => 0.0385507768,
      (f_rel_count_i > 15.5) => 0.1877090337,
      (f_rel_count_i = NULL) => 0.0755420245, 0.0755420245),
   (f_add_input_nhood_MFD_pct_i > 0.09515227815) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => -0.0689787419,
      (f_corrssnaddrcount_d > 2.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0022961263,
         (f_varrisktype_i > 2.5) => 0.0910812283,
         (f_varrisktype_i = NULL) => 0.0126499441, 0.0126499441),
      (f_corrssnaddrcount_d = NULL) => 0.0033839852, 0.0033839852),
   (f_add_input_nhood_MFD_pct_i = NULL) => 0.1296573014, 0.0274881770),
(f_fp_prevaddrcrimeindex_i = NULL) => -0.0333424440, -0.0015050540);

// Tree: 192 
woFDN_FLA_SD_lgt_192 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 4.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 224) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 114.5) => 0.1631805287,
      (c_bel_edu > 114.5) => -0.0270407237,
      (c_bel_edu = NULL) => 0.0724327753, 0.0724327753),
   (r_D32_Mos_Since_Fel_LS_d > 224) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 24.5) => -0.0039034049,
      (f_srchaddrsrchcount_i > 24.5) => 0.0613620150,
      (f_srchaddrsrchcount_i = NULL) => -0.0032372681, -0.0032372681),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0025697353, -0.0025697353),
(f_divrisktype_i > 4.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 1018) => -0.1415620313,
   (r_A50_pb_total_dollars_d > 1018) => -0.0137795182,
   (r_A50_pb_total_dollars_d = NULL) => -0.0514297230, -0.0514297230),
(f_divrisktype_i = NULL) => 0.0004781706, -0.0034073078);

// Tree: 193 
woFDN_FLA_SD_lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0079069278,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 14.35) => 0.2140525587,
      (C_INC_75K_P > 14.35) => 
         map(
         (NULL < c_rental and c_rental <= 142.5) => -0.0331082504,
         (c_rental > 142.5) => 0.1893293970,
         (c_rental = NULL) => 0.0332543626, 0.0332543626),
      (C_INC_75K_P = NULL) => 0.0841935369, 0.0841935369),
   (f_hh_members_ct_d > 1.5) => 0.0114010970,
   (f_hh_members_ct_d = NULL) => 0.0177670689, 0.0177670689),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 3.3) => -0.0714392334,
   (c_high_hval > 3.3) => 0.0573745809,
   (c_high_hval = NULL) => -0.0089082556, -0.0089082556), -0.0018982050);

// Tree: 194 
woFDN_FLA_SD_lgt_194 := map(
(NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 28.55) => 0.0008046369,
   (c_hval_20k_p > 28.55) => 0.1227171062,
   (c_hval_20k_p = NULL) => 0.0012665928, 0.0018426524),
(r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 3.25) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.215919342) => 0.0028701637,
      (f_add_curr_mobility_index_i > 0.215919342) => -0.0850703452,
      (f_add_curr_mobility_index_i = NULL) => -0.0597802642, -0.0597802642),
   (c_hh5_p > 3.25) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 140.5) => -0.0368726376,
      (c_oldhouse > 140.5) => 0.0581014298,
      (c_oldhouse = NULL) => -0.0044814820, -0.0044814820),
   (c_hh5_p = NULL) => -0.0131068529, -0.0253139307),
(r_F00_Addr_Not_Ver_w_SSN_i = NULL) => -0.0021502716, 0.0000022902);

// Tree: 195 
woFDN_FLA_SD_lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < r_I60_inq_auto_recency_d and r_I60_inq_auto_recency_d <= 18) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 131.5) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 130.5) => -0.0398192974,
         (f_curraddrcartheftindex_i > 130.5) => 0.0918424645,
         (f_curraddrcartheftindex_i = NULL) => -0.0146525622, -0.0146525622),
      (c_bel_edu > 131.5) => -0.1053206590,
      (c_bel_edu = NULL) => -0.0392472806, -0.0392472806),
   (r_I60_inq_auto_recency_d > 18) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 2.15) => -0.0518983524,
      (c_pop_18_24_p > 2.15) => 0.0091406055,
      (c_pop_18_24_p = NULL) => 0.0063586120, 0.0063586120),
   (r_I60_inq_auto_recency_d = NULL) => -0.0032975839, 0.0037382246),
(c_hval_80k_p > 40.05) => -0.1148125541,
(c_hval_80k_p = NULL) => 0.0150588436, 0.0029160745);

// Tree: 196 
woFDN_FLA_SD_lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0850458648,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 25.75) => -0.0271701235,
      (c_vacant_p > 25.75) => 0.1357062500,
      (c_vacant_p = NULL) => -0.0791272803, -0.0233731505),
   (f_addrs_per_ssn_i > 4.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 16.5) => 0.0069728236,
      (k_inq_per_ssn_i > 16.5) => -0.0821666508,
      (k_inq_per_ssn_i = NULL) => 0.0063969252, 0.0063969252),
   (f_addrs_per_ssn_i = NULL) => -0.0008019452, -0.0008019452),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.595) => 0.0863268140,
   (c_hhsize > 2.595) => -0.0353835649,
   (c_hhsize = NULL) => 0.0194409301, 0.0194409301), -0.0027337855);

// Tree: 197 
woFDN_FLA_SD_lgt_197 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -91324) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => 0.0042680792,
   (r_L79_adls_per_addr_c6_i > 1.5) => 0.1212430308,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0403847693, 0.0403847693),
(f_addrchangevaluediff_d > -91324) => -0.0014079707,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','6: Other']) => -0.0195885310,
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 66.75) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.08714198935) => 0.1453018334,
         (f_add_input_nhood_BUS_pct_i > 0.08714198935) => -0.0117474505,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0883193499, 0.0883193499),
      (c_fammar_p > 66.75) => 0.0069145517,
      (c_fammar_p = NULL) => 0.1148605176, 0.0310106921),
   (nf_seg_FraudPoint_3_0 = '') => -0.0013240576, -0.0013240576), -0.0006743553);

// Tree: 198 
woFDN_FLA_SD_lgt_198 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.1019199375,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 24.5) => -0.0301036825,
   (r_A50_pb_average_dollars_d > 24.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0113891815,
      (f_srchfraudsrchcount_i > 6.5) => 
         map(
         (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 2.5) => -0.0596096559,
         (r_C20_email_domain_free_count_i > 2.5) => 
            map(
            (NULL < f_adl_util_misc_n and f_adl_util_misc_n <= 0.5) => 0.1195478562,
            (f_adl_util_misc_n > 0.5) => -0.0164272281,
            (f_adl_util_misc_n = NULL) => 0.0465241998, 0.0465241998),
         (r_C20_email_domain_free_count_i = NULL) => -0.0320556741, -0.0320556741),
      (f_srchfraudsrchcount_i = NULL) => 0.0097064012, 0.0097064012),
   (r_A50_pb_average_dollars_d = NULL) => 0.0156076575, 0.0052407528),
(c_pop_45_54_p = NULL) => -0.0342797986, 0.0029064496);

// Tree: 199 
woFDN_FLA_SD_lgt_199 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 93.25) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 18.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 20.1) => 0.0001167925,
         (C_INC_75K_P > 20.1) => 0.1552819197,
         (C_INC_75K_P = NULL) => 0.0612054252, 0.0612054252),
      (r_D33_Eviction_Recency_d > 48) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 0.0291225543,
         (f_corraddrnamecount_d > 1.5) => -0.0021897667,
         (f_corraddrnamecount_d = NULL) => -0.0001480546, -0.0001480546),
      (r_D33_Eviction_Recency_d = NULL) => 0.0004924100, 0.0004924100),
   (r_D30_Derog_Count_i > 18.5) => -0.0851404511,
   (r_D30_Derog_Count_i = NULL) => -0.0012301161, 0.0001027650),
(C_RENTOCC_P > 93.25) => -0.1159386059,
(C_RENTOCC_P = NULL) => -0.0403862049, -0.0014993980);

// Tree: 200 
woFDN_FLA_SD_lgt_200 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 10.5) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 22.85) => -0.0028369177,
   (c_hval_40k_p > 22.85) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0532379238) => -0.0873399817,
         (f_add_input_nhood_BUS_pct_i > 0.0532379238) => 0.0915554680,
         (f_add_input_nhood_BUS_pct_i = NULL) => -0.0000390022, -0.0000390022),
      (f_rel_under100miles_cnt_d > 8.5) => 0.1360050013,
      (f_rel_under100miles_cnt_d = NULL) => 0.0547654542, 0.0547654542),
   (c_hval_40k_p = NULL) => -0.0349407000, -0.0025769113),
(f_inq_HighRiskCredit_count_i > 10.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 39.5) => -0.0052150266,
   (k_comb_age_d > 39.5) => -0.1092404712,
   (k_comb_age_d = NULL) => -0.0572277489, -0.0572277489),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0133783078, -0.0028869927);

// Tree: 201 
woFDN_FLA_SD_lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0062196150,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_larceny and c_larceny <= 178.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -16129) => 0.1005541175,
      (f_addrchangevaluediff_d > -16129) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 24.5) => 0.1380337668,
         (f_prevaddrmurderindex_i > 24.5) => -0.0168432844,
         (f_prevaddrmurderindex_i = NULL) => 0.0039192188, 0.0039192188),
      (f_addrchangevaluediff_d = NULL) => -0.0055615201, 0.0105222747),
   (c_larceny > 178.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 4.55) => -0.0217801999,
      (c_hval_175k_p > 4.55) => 0.2643687845,
      (c_hval_175k_p = NULL) => 0.1200714334, 0.1200714334),
   (c_larceny = NULL) => 0.0892587004, 0.0299289966),
(r_L70_Add_Standardized_i = NULL) => -0.0032160173, -0.0032160173);

// Tree: 202 
woFDN_FLA_SD_lgt_202 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 14.5) => 
   map(
   (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 1.5) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 166.5) => -0.0524080417,
      (c_cartheft > 166.5) => -0.1281968519,
      (c_cartheft = NULL) => -0.0623083817, -0.0623083817),
   (f_phones_per_addr_c6_i > 1.5) => 0.0880759829,
   (f_phones_per_addr_c6_i = NULL) => -0.0450161228, -0.0450161228),
(f_mos_inq_banko_om_fseen_d > 14.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 70.85) => -0.0222893167,
      (c_sfdu_p > 70.85) => 0.0984893413,
      (c_sfdu_p = NULL) => 0.0483272374, 0.0483272374),
   (f_mos_inq_banko_om_fseen_d > 36.5) => 0.0002026888,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0032660500, 0.0032660500),
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0072904411, 0.0002259802);

// Tree: 203 
woFDN_FLA_SD_lgt_203 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 111) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 60.25) => 0.0008409312,
   (c_low_hval > 60.25) => -0.0905263461,
   (c_low_hval = NULL) => -0.0002543528, -0.0002543528),
(f_addrchangecrimediff_i > 111) => 0.0779041370,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 55.45) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => -0.0059963641,
      (r_L79_adls_per_addr_c6_i > 4.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 56151.5) => 0.1303148006,
         (f_curraddrmedianincome_d > 56151.5) => -0.0078207163,
         (f_curraddrmedianincome_d = NULL) => 0.0641490488, 0.0641490488),
      (r_L79_adls_per_addr_c6_i = NULL) => -0.0021867425, -0.0021867425),
   (c_rnt750_p > 55.45) => -0.0775648366,
   (c_rnt750_p = NULL) => -0.0099507460, -0.0097521956), -0.0020021797);

// Tree: 204 
woFDN_FLA_SD_lgt_204 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 47409) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => -0.0099627855,
   (f_inq_count_i > 3.5) => -0.1003450439,
   (f_inq_count_i = NULL) => -0.0398086403, -0.0398086403),
(r_L80_Inp_AVM_AutoVal_d > 47409) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.7398458792) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 0.5) => 0.1312068356,
      (f_corrssnnamecount_d > 0.5) => 0.0029839583,
      (f_corrssnnamecount_d = NULL) => 0.0073551927, 0.0073551927),
   (f_add_curr_nhood_MFD_pct_i > 0.7398458792) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 21.05) => 0.1874339447,
      (c_hh1_p > 21.05) => 0.0150323122,
      (c_hh1_p = NULL) => 0.0622950650, 0.0622950650),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0046716375, 0.0069949564),
(r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0029837223, 0.0014384898);

// Tree: 205 
woFDN_FLA_SD_lgt_205 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5922.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 2916) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 204.35) => 
         map(
         (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 0.5) => 0.0209700179,
         (f_divsrchaddrsuspidcount_i > 0.5) => 0.1050494283,
         (f_divsrchaddrsuspidcount_i = NULL) => 0.0264934828, 0.0264934828),
      (c_housingcpi > 204.35) => -0.0014754829,
      (c_housingcpi = NULL) => -0.0127337395, 0.0022811012),
   (f_liens_unrel_SC_total_amt_i > 2916) => -0.0754423744,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0014679902, 0.0014679902),
(f_liens_unrel_ST_total_amt_i > 5922.5) => 0.1481796567,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1256) => 0.0628750859,
   (c_popover18 > 1256) => -0.0325626657,
   (c_popover18 = NULL) => 0.0124551416, 0.0124551416), 0.0021548531);

// Tree: 206 
woFDN_FLA_SD_lgt_206 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184.5) => -0.0868101055,
(f_mos_liens_unrel_FT_lseen_d > 184.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 26.05) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 27.1) => -0.0549488642,
      (c_fammar_p > 27.1) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 50.05) => -0.0043004269,
         (c_famotf18_p > 50.05) => 0.0899155567,
         (c_famotf18_p = NULL) => -0.0037300931, -0.0037300931),
      (c_fammar_p = NULL) => -0.0044309055, -0.0044309055),
   (C_INC_25K_P > 26.05) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 38) => 0.1554758745,
      (c_exp_prod > 38) => -0.0450090260,
      (c_exp_prod = NULL) => 0.0719404993, 0.0719404993),
   (C_INC_25K_P = NULL) => 0.0168408747, -0.0032285473),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0102322225, -0.0041661344);

// Tree: 207 
woFDN_FLA_SD_lgt_207 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 129.5) => 
      map(
      (NULL < c_murders and c_murders <= 24.5) => 0.1658878386,
      (c_murders > 24.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 231.5) => 0.1021817278,
         (r_C21_M_Bureau_ADL_FS_d > 231.5) => -0.0739004919,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0141406180, 0.0141406180),
      (c_murders = NULL) => 0.0383456961, 0.0383456961),
   (f_mos_liens_unrel_SC_fseen_d > 129.5) => -0.0015643418,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0005152560, -0.0005152560),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < c_bargains and c_bargains <= 117.5) => -0.1075416491,
   (c_bargains > 117.5) => 0.0081855730,
   (c_bargains = NULL) => -0.0496780381, -0.0496780381),
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0131736400, -0.0010211088);

// Tree: 208 
woFDN_FLA_SD_lgt_208 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => -0.0040271225,
      (f_srchssnsrchcount_i > 22.5) => 0.0738102359,
      (f_srchssnsrchcount_i = NULL) => -0.0035789535, -0.0035789535),
   (f_addrchangecrimediff_i > 98.5) => 0.0683354930,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => -0.0085779611,
      (f_srchaddrsrchcountmo_i > 0.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02904598265) => 0.1365389376,
         (f_add_curr_nhood_BUS_pct_i > 0.02904598265) => -0.0007522641,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0636325754, 0.0636325754),
      (f_srchaddrsrchcountmo_i = NULL) => -0.0108795608, -0.0046029952), -0.0033432423),
(r_L72_Add_Vacant_i > 0.5) => 0.1091003619,
(r_L72_Add_Vacant_i = NULL) => -0.0026159686, -0.0026159686);

// Tree: 209 
woFDN_FLA_SD_lgt_209 := map(
(NULL < c_hh2_p and c_hh2_p <= 17.75) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.10033912975) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 14.85) => -0.0048645644,
      (c_pop_0_5_p > 14.85) => 0.1392637252,
      (c_pop_0_5_p = NULL) => 0.0129849650, 0.0129849650),
   (f_add_input_nhood_BUS_pct_i > 0.10033912975) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 38568) => 0.1445987129,
      (f_curraddrmedianincome_d > 38568) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 136) => -0.0755630604,
         (c_asian_lang > 136) => 0.1188107522,
         (c_asian_lang = NULL) => 0.0188861866, 0.0188861866),
      (f_curraddrmedianincome_d = NULL) => 0.0623352164, 0.0623352164),
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0272978332, 0.0272978332),
(c_hh2_p > 17.75) => -0.0001820109,
(c_hh2_p = NULL) => 0.0134245195, 0.0018447869);

// Tree: 210 
woFDN_FLA_SD_lgt_210 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0007686242,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 21.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 11.05) => 
         map(
         (NULL < c_professional and c_professional <= 1.65) => 0.0446850499,
         (c_professional > 1.65) => -0.0547656150,
         (c_professional = NULL) => -0.0249617880, -0.0249617880),
      (C_INC_25K_P > 11.05) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 9.2) => -0.1279793546,
         (c_pop_18_24_p > 9.2) => -0.0333533586,
         (c_pop_18_24_p = NULL) => -0.0834091391, -0.0834091391),
      (C_INC_25K_P = NULL) => -0.0426886769, -0.0426886769),
   (f_addrs_per_ssn_i > 21.5) => 0.0590008766,
   (f_addrs_per_ssn_i = NULL) => -0.0321827386, -0.0321827386),
(f_srchfraudsrchcount_i = NULL) => -0.0008471519, -0.0005763327);

// Tree: 211 
woFDN_FLA_SD_lgt_211 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => -0.0031952290,
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.6309497965) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.3238764426) => 
            map(
            (NULL < c_no_move and c_no_move <= 67) => 0.0312283028,
            (c_no_move > 67) => 0.1723410911,
            (c_no_move = NULL) => 0.1017846970, 0.1017846970),
         (f_add_input_nhood_MFD_pct_i > 0.3238764426) => 0.0220290614,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0738448247, 0.0738448247),
      (f_inq_count24_i > 2.5) => -0.0367293609,
      (f_inq_count24_i = NULL) => 0.0272872728, 0.0272872728),
   (f_add_curr_nhood_MFD_pct_i > 0.6309497965) => -0.0360906101,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1146664847, 0.0343868078),
(f_srchaddrsrchcount_i = NULL) => -0.0187635718, -0.0020829294);

// Tree: 212 
woFDN_FLA_SD_lgt_212 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 22.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00477897935) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 10.5) => -0.0222277498,
      (f_rel_under25miles_cnt_d > 10.5) => -0.0979508588,
      (f_rel_under25miles_cnt_d = NULL) => -0.0355136001, -0.0355136001),
   (f_add_curr_nhood_BUS_pct_i > 0.00477897935) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 0.0040417770,
      (f_rel_felony_count_i > 4.5) => 0.0888868873,
      (f_rel_felony_count_i = NULL) => 0.0044968413, 0.0044968413),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0199222611, -0.0009177211),
(f_srchaddrsrchcount_i > 22.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 16.05) => -0.0095680713,
   (c_hh3_p > 16.05) => 0.0980104078,
   (c_hh3_p = NULL) => 0.0471766210, 0.0471766210),
(f_srchaddrsrchcount_i = NULL) => 0.0103327068, -0.0001407631);

// Tree: 213 
woFDN_FLA_SD_lgt_213 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 74.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 149006.5) => 
      map(
      (NULL < c_rental and c_rental <= 101.5) => -0.0098076949,
      (c_rental > 101.5) => 0.0468245222,
      (c_rental = NULL) => 0.0201768513, 0.0201768513),
   (r_A46_Curr_AVM_AutoVal_d > 149006.5) => -0.0113722909,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0004718683, -0.0004852834),
(k_comb_age_d > 74.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 19.1) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 136) => -0.0177710724,
      (c_totcrime > 136) => 0.1377470910,
      (c_totcrime = NULL) => 0.0177881771, 0.0177881771),
   (c_hval_500k_p > 19.1) => 0.2409877156,
   (c_hval_500k_p = NULL) => 0.0448099130, 0.0448099130),
(k_comb_age_d = NULL) => 0.0010215809, 0.0010215809);

// Tree: 214 
woFDN_FLA_SD_lgt_214 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 48.95) => 
      map(
      (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0017211647,
      (r_L70_Add_Standardized_i > 0.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 134) => 0.0128321143,
         (f_curraddrcrimeindex_i > 134) => 0.1036997680,
         (f_curraddrcrimeindex_i = NULL) => 0.0378135679, 0.0378135679),
      (r_L70_Add_Standardized_i = NULL) => 0.0045428268, 0.0045428268),
   (c_hval_80k_p > 48.95) => -0.1207045556,
   (c_hval_80k_p = NULL) => -0.0015281617, 0.0038765813),
(f_inq_PrepaidCards_count24_i > 1.5) => 0.0920970072,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 12.1) => 0.0347760329,
   (C_INC_100K_P > 12.1) => -0.0706173245,
   (C_INC_100K_P = NULL) => -0.0173988965, -0.0173988965), 0.0040726732);

// Tree: 215 
woFDN_FLA_SD_lgt_215 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 42.5) => 0.1248650010,
(f_mos_liens_unrel_FT_fseen_d > 42.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1327013824) => 
      map(
      (NULL < c_food and c_food <= 51.65) => -0.0066802284,
      (c_food > 51.65) => 0.0425240495,
      (c_food = NULL) => 0.0824461910, -0.0026214588),
   (f_add_curr_nhood_BUS_pct_i > 0.1327013824) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 0.0134823453,
      (f_hh_lienholders_i > 1.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => 0.0125322923,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.1732711812,
         (nf_seg_FraudPoint_3_0 = '') => 0.0993682438, 0.0993682438),
      (f_hh_lienholders_i = NULL) => 0.0237110560, 0.0237110560),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0259644624, -0.0008893864),
(f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0151987434, -0.0004733852);

// Tree: 216 
woFDN_FLA_SD_lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 176.5) => -0.0808733277,
(f_mos_liens_unrel_FT_lseen_d > 176.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1908.5) => -0.0041015960,
   (c_popover18 > 1908.5) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 29.65) => 0.0133393708,
         (c_famotf18_p > 29.65) => 0.1451397722,
         (c_famotf18_p = NULL) => 0.0170684715, 0.0170684715),
      (f_srchcomponentrisktype_i > 3.5) => 0.1341031592,
      (f_srchcomponentrisktype_i = NULL) => 0.0201907394, 0.0201907394),
   (c_popover18 = NULL) => 0.0244799894, 0.0010993614),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 9.3) => 0.0661373978,
   (c_newhouse > 9.3) => -0.0377733015,
   (c_newhouse = NULL) => 0.0121837654, 0.0121837654), 0.0002787266);

// Tree: 217 
woFDN_FLA_SD_lgt_217 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -45425.5) => -0.0919726249,
(f_addrchangeincomediff_d > -45425.5) => 0.0012753646,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 33.35) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 2.5) => -0.0041479809,
      (f_hh_criminals_i > 2.5) => -0.0997196817,
      (f_hh_criminals_i = NULL) => -0.0091580458, -0.0070171194),
   (c_retail > 33.35) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 111) => 0.0021790941,
      (c_for_sale > 111) => 0.1492344669,
      (c_for_sale = NULL) => 0.0736297272, 0.0736297272),
   (c_retail = NULL) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2067873879) => 0.1622421119,
      (f_add_curr_mobility_index_i > 0.2067873879) => -0.0781762280,
      (f_add_curr_mobility_index_i = NULL) => 0.0366359875, 0.0343017509), 0.0019532991), 0.0008633058);

// Tree: 218 
woFDN_FLA_SD_lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_exp_homes and c_exp_homes <= 188.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.1089076809,
      (r_F01_inp_addr_address_score_d > 95) => 
         map(
         (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0158468185,
         (f_prevaddroccupantowned_i > 0.5) => 0.1473610434,
         (f_prevaddroccupantowned_i = NULL) => 0.0045541643, 0.0045541643),
      (r_F01_inp_addr_address_score_d = NULL) => 0.0172134433, 0.0172134433),
   (c_exp_homes > 188.5) => 0.2707851238,
   (c_exp_homes = NULL) => 0.0415491030, 0.0382685494),
(f_rel_incomeover25_count_d > 1.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0080270636,
   (f_inq_Other_count_i > 0.5) => 0.0194247781,
   (f_inq_Other_count_i = NULL) => -0.0016226648, -0.0016226648),
(f_rel_incomeover25_count_d = NULL) => -0.0272093942, 0.0003449208);

// Tree: 219 
woFDN_FLA_SD_lgt_219 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 15.45) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 25.35) => 
      map(
      (NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 6.5) => 0.0069553881,
         (f_assocsuspicousidcount_i > 6.5) => 
            map(
            (NULL < c_old_homes and c_old_homes <= 168.5) => -0.0357606371,
            (c_old_homes > 168.5) => 0.1046715169,
            (c_old_homes = NULL) => -0.0253897395, -0.0253897395),
         (f_assocsuspicousidcount_i = NULL) => 0.0027794509, 0.0046528401),
      (r_L77_Add_PO_Box_i > 0.5) => -0.0871982870,
      (r_L77_Add_PO_Box_i = NULL) => 0.0029239857, 0.0029239857),
   (c_pop_45_54_p > 25.35) => -0.0790448953,
   (c_pop_45_54_p = NULL) => 0.0007702336, 0.0007702336),
(c_femdiv_p > 15.45) => 0.1034352063,
(c_femdiv_p = NULL) => -0.0017125936, 0.0012811855);

// Tree: 220 
woFDN_FLA_SD_lgt_220 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 82.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 42.75) => -0.0012565191,
   (c_famotf18_p > 42.75) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 9.5) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 123.5) => -0.0544432954,
         (c_lar_fam > 123.5) => 0.0523321321,
         (c_lar_fam = NULL) => -0.0203905915, -0.0203905915),
      (f_rel_under100miles_cnt_d > 9.5) => -0.0895020045,
      (f_rel_under100miles_cnt_d = NULL) => -0.0454136893, -0.0454136893),
   (c_famotf18_p = NULL) => -0.0105086999, -0.0025273357),
(k_comb_age_d > 82.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 40.85) => 0.1426040267,
   (c_med_age > 40.85) => 0.0032354057,
   (c_med_age = NULL) => 0.0564295358, 0.0564295358),
(k_comb_age_d = NULL) => -0.0019184788, -0.0019184788);

// Tree: 221 
woFDN_FLA_SD_lgt_221 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 14.05) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 42.05) => 0.0141841654,
   (c_high_ed > 42.05) => -0.0168868510,
   (c_high_ed = NULL) => 0.0040074617, 0.0040074617),
(C_INC_25K_P > 14.05) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 191.5) => -0.0171636365,
      (c_sub_bus > 191.5) => 0.1082420307,
      (c_sub_bus = NULL) => -0.0075492020, -0.0075492020),
   (r_I60_Inq_Count12_i > 0.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog']) => -0.0913884463,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0421898492,
      (nf_seg_FraudPoint_3_0 = '') => -0.0524734657, -0.0524734657),
   (r_I60_Inq_Count12_i = NULL) => -0.0235677733, -0.0235677733),
(C_INC_25K_P = NULL) => -0.0124081910, -0.0004611789);

// Tree: 222 
woFDN_FLA_SD_lgt_222 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0046829607,
(f_addrchangecrimediff_i > 61.5) => 
   map(
   (NULL < c_health and c_health <= 11.15) => -0.0052823707,
   (c_health > 11.15) => 0.1355093767,
   (c_health = NULL) => 0.0511934149, 0.0511934149),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 984.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0390781883,
      (f_varrisktype_i > 3.5) => -0.0880225371,
      (f_varrisktype_i = NULL) => -0.0427833771, -0.0427833771),
   (c_popover18 > 984.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => -0.0249314806,
      (r_L79_adls_per_addr_c6_i > 0.5) => 0.0424704822,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0179177532, 0.0179177532),
   (c_popover18 = NULL) => 0.0147983917, -0.0004644334), -0.0029495074);

// Tree: 223 
woFDN_FLA_SD_lgt_223 := map(
(NULL < c_hval_250k_p and c_hval_250k_p <= 5.05) => -0.0117792839,
(c_hval_250k_p > 5.05) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.37378671655) => -0.0053327766,
   (f_add_curr_nhood_MFD_pct_i > 0.37378671655) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -32926) => -0.1185576370,
      (f_addrchangevaluediff_d > -32926) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.6167465487) => 0.0185532382,
         (f_add_curr_mobility_index_i > 0.6167465487) => 0.2320826031,
         (f_add_curr_mobility_index_i = NULL) => 0.0273767657, 0.0273767657),
      (f_addrchangevaluediff_d = NULL) => 0.0835874912, 0.0344495622),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 0.0081378155,
      (k_inq_ssns_per_addr_i > 1.5) => 0.1024376664,
      (k_inq_ssns_per_addr_i = NULL) => 0.0208756313, 0.0208756313), 0.0085184849),
(c_hval_250k_p = NULL) => -0.0095770537, -0.0001357534);

// Tree: 224 
woFDN_FLA_SD_lgt_224 := map(
(NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.39263219665) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 8) => -0.0500377676,
         (c_famotf18_p > 8) => 0.0872181012,
         (c_famotf18_p = NULL) => 0.0279100097, 0.0279100097),
      (f_add_curr_mobility_index_i > 0.39263219665) => -0.0584254209,
      (f_add_curr_mobility_index_i = NULL) => 0.0026502986, 0.0026502986),
   (c_hval_20k_p > 0.65) => 0.1598641759,
   (c_hval_20k_p = NULL) => 0.0393335366, 0.0393335366),
(f_M_Bureau_ADL_FS_all_d > 10.5) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 4.5) => 0.0033786581,
   (f_divaddrsuspidcountnew_i > 4.5) => -0.0751552406,
   (f_divaddrsuspidcountnew_i = NULL) => 0.0028476346, 0.0028476346),
(f_M_Bureau_ADL_FS_all_d = NULL) => 0.0202205593, 0.0038702180);

// Tree: 225 
woFDN_FLA_SD_lgt_225 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 65039) => -0.0188570137,
(r_A46_Curr_AVM_AutoVal_d > 65039) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0120456855,
   (f_srchunvrfddobcount_i > 0.5) => 
      map(
      (NULL < c_rental and c_rental <= 92.5) => -0.0149642466,
      (c_rental > 92.5) => 0.1287445636,
      (c_rental = NULL) => 0.0681538220, 0.0681538220),
   (f_srchunvrfddobcount_i = NULL) => 0.0136490228, 0.0136490228),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_liens_unrel_OT_lseen_d and f_mos_liens_unrel_OT_lseen_d <= 210.5) => -0.0879987798,
   (f_mos_liens_unrel_OT_lseen_d > 210.5) => -0.0045547891,
   (f_mos_liens_unrel_OT_lseen_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 3.35) => -0.0505386122,
      (c_hval_200k_p > 3.35) => 0.0702462638,
      (c_hval_200k_p = NULL) => 0.0076170688, 0.0076170688), -0.0069287364), 0.0030054957);

// Tree: 226 
woFDN_FLA_SD_lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 13.5) => -0.0079245616,
   (f_addrs_per_ssn_i > 13.5) => -0.1393499359,
   (f_addrs_per_ssn_i = NULL) => -0.0717232870, -0.0717232870),
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.6) => 0.1084563075,
      (r_C12_source_profile_d > 60.6) => -0.0307556518,
      (r_C12_source_profile_d = NULL) => 0.0509307045, 0.0509307045),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 125.5) => 0.0060909933,
      (c_serv_empl > 125.5) => -0.0154352399,
      (c_serv_empl = NULL) => -0.0035799370, -0.0010786552),
   (r_D33_Eviction_Recency_d = NULL) => -0.0005743169, -0.0005743169),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0077870905, -0.0010834819);

// Tree: 227 
woFDN_FLA_SD_lgt_227 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 14.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -100) => -0.0772357001,
   (f_addrchangecrimediff_i > -100) => -0.0022469581,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 112.65) => 0.0100267543,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 112.65) => 
         map(
         (NULL < c_construction and c_construction <= 2.5) => 0.1816122241,
         (c_construction > 2.5) => 0.0482036151,
         (c_construction = NULL) => 0.0875617105, 0.0875617105),
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0105810015, 0.0033285956), -0.0014871950),
(r_D30_Derog_Count_i > 14.5) => 0.0795143817,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 30.5) => -0.0607404978,
   (k_comb_age_d > 30.5) => 0.0623356932,
   (k_comb_age_d = NULL) => -0.0018322354, -0.0018322354), -0.0008709724);

// Tree: 228 
woFDN_FLA_SD_lgt_228 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.2172637622) => -0.0339398858,
   (f_add_input_mobility_index_i > 0.2172637622) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 61.5) => 0.0247330992,
      (r_A50_pb_average_dollars_d > 61.5) => -0.0920414350,
      (r_A50_pb_average_dollars_d = NULL) => -0.0604149986, -0.0604149986),
   (f_add_input_mobility_index_i = NULL) => -0.0557002525, -0.0557002525),
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 50.5) => -0.0085885086,
      (k_comb_age_d > 50.5) => 0.1991450446,
      (k_comb_age_d = NULL) => 0.0270927841, 0.0270927841),
   (f_adl_per_email_i > 0.5) => -0.0744458126,
   (f_adl_per_email_i = NULL) => -0.0029208319, -0.0029013858),
(f_corrssnaddrcount_d = NULL) => 0.0035170957, -0.0040906483);

// Tree: 229 
woFDN_FLA_SD_lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 297159) => -0.0130456131,
   (r_L80_Inp_AVM_AutoVal_d > 297159) => 
      map(
      (NULL < c_finance and c_finance <= 1.95) => 0.0611371521,
      (c_finance > 1.95) => -0.0188756178,
      (c_finance = NULL) => 0.0143084522, 0.0143084522),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 7971) => -0.0150860854,
      (r_A49_Curr_AVM_Chg_1yr_i > 7971) => 
         map(
         (NULL < c_construction and c_construction <= 4.35) => 0.1728527923,
         (c_construction > 4.35) => 0.0065488684,
         (c_construction = NULL) => 0.0736950536, 0.0736950536),
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0041020386, 0.0057585862), -0.0006234669),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0669022115,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0243117024, -0.0035600334);

// Tree: 230 
woFDN_FLA_SD_lgt_230 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
      map(
      (NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 1925) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 189) => 0.0010755723,
         (f_fp_prevaddrcrimeindex_i > 189) => 
            map(
            (NULL < c_med_yearblt and c_med_yearblt <= 1954.5) => 0.1487423693,
            (c_med_yearblt > 1954.5) => 0.0149309509,
            (c_med_yearblt = NULL) => 0.0587056900, 0.0587056900),
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0023334838, 0.0023334838),
      (f_acc_damage_amt_last_i > 1925) => 0.1159037982,
      (f_acc_damage_amt_last_i = NULL) => 0.0032294660, 0.0032294660),
   (f_fp_prevaddrcrimeindex_i > 197.5) => -0.0988464358,
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0026249832, 0.0026249832),
(f_inq_count24_i > 14.5) => -0.0915333304,
(f_inq_count24_i = NULL) => -0.0099959874, 0.0018005795);

// Tree: 231 
woFDN_FLA_SD_lgt_231 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 12.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -268669.5) => -0.0801603864,
   (f_addrchangevaluediff_d > -268669.5) => -0.0012918972,
   (f_addrchangevaluediff_d = NULL) => 0.0083295105, 0.0004441088),
(f_srchssnsrchcount_i > 12.5) => 
   map(
   (NULL < c_employees and c_employees <= 465.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 15.65) => 0.0193773950,
      (c_rnt1000_p > 15.65) => 0.1546637699,
      (c_rnt1000_p = NULL) => 0.0876527617, 0.0876527617),
   (c_employees > 465.5) => -0.0238819605,
   (c_employees = NULL) => 0.0484466170, 0.0484466170),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 72.8) => -0.0282422642,
   (c_sfdu_p > 72.8) => 0.0873656470,
   (c_sfdu_p = NULL) => 0.0279994223, 0.0279994223), 0.0013340097);

// Tree: 232 
woFDN_FLA_SD_lgt_232 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 7.5) => 0.1438624461,
   (f_rel_homeover100_count_d > 7.5) => 0.0033701764,
   (f_rel_homeover100_count_d = NULL) => 0.0698531254, 0.0698531254),
(r_F00_dob_score_d > 65) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.0668126499,
   (r_D32_Mos_Since_Fel_LS_d > 127.5) => -0.0025392956,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0021243251, -0.0021243251),
(r_F00_dob_score_d = NULL) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 22.15) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 11.65) => -0.0631470942,
      (c_hval_750k_p > 11.65) => 0.0217101452,
      (c_hval_750k_p = NULL) => -0.0281142890, -0.0281142890),
   (c_low_hval > 22.15) => 0.1156793759,
   (c_low_hval = NULL) => 0.1175707550, -0.0008896698), -0.0014195229);

// Tree: 233 
woFDN_FLA_SD_lgt_233 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => 
   map(
   (NULL < c_bargains and c_bargains <= 161.5) => -0.0772057255,
   (c_bargains > 161.5) => 0.0389728205,
   (c_bargains = NULL) => -0.0556598861, -0.0556598861),
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 17.25) => 0.0146255067,
      (c_hval_250k_p > 17.25) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 0.0323927819,
         (f_rel_under25miles_cnt_d > 5.5) => 0.1884795521,
         (f_rel_under25miles_cnt_d = NULL) => 0.0972157029, 0.0972157029),
      (c_hval_250k_p = NULL) => 0.0249639438, 0.0326843573),
   (f_corrssnaddrcount_d > 2.5) => -0.0086932072,
   (f_corrssnaddrcount_d = NULL) => -0.0057048650, -0.0057048650),
(f_corrssnaddrcount_d = NULL) => 0.0066924263, -0.0068025104);

// Tree: 234 
woFDN_FLA_SD_lgt_234 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 52.5) => 
      map(
      (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 8.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 16.5) => 
            map(
            (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0058668023,
            (f_srchfraudsrchcountmo_i > 0.5) => 0.0306727821,
            (f_srchfraudsrchcountmo_i = NULL) => -0.0046095198, -0.0046095198),
         (r_D30_Derog_Count_i > 16.5) => -0.0707598917,
         (r_D30_Derog_Count_i = NULL) => -0.0050002036, -0.0050002036),
      (f_hh_tot_derog_i > 8.5) => 0.0737252715,
      (f_hh_tot_derog_i = NULL) => -0.0046338293, -0.0046338293),
   (f_rel_educationover8_count_d > 52.5) => -0.0944573650,
   (f_rel_educationover8_count_d = NULL) => -0.0221646946, -0.0054100864),
(f_rel_felony_count_i > 4.5) => 0.0727538229,
(f_rel_felony_count_i = NULL) => 0.0367431929, -0.0047412941);

// Tree: 235 
woFDN_FLA_SD_lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0630942593) => 0.0076935652,
   (f_add_curr_nhood_VAC_pct_i > 0.0630942593) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 30.5) => 0.1740622165,
      (f_mos_inq_banko_cm_fseen_d > 30.5) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 0.0222707762,
         (r_F04_curr_add_occ_index_d > 2) => 
            map(
            (NULL < c_lar_fam and c_lar_fam <= 100.5) => 0.0662456024,
            (c_lar_fam > 100.5) => 0.2443886806,
            (c_lar_fam = NULL) => 0.1342863614, 0.1342863614),
         (r_F04_curr_add_occ_index_d = NULL) => 0.0575034440, 0.0575034440),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0699273442, 0.0699273442),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0212948485, 0.0212948485),
(f_hh_members_ct_d > 1.5) => -0.0059860083,
(f_hh_members_ct_d = NULL) => 0.0063415716, -0.0007965897);

// Tree: 236 
woFDN_FLA_SD_lgt_236 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.65) => -0.0379737478,
(c_pop_45_54_p > 7.65) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0001338165,
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.1531961256,
      (f_corrssnnamecount_d > 3.5) => 
         map(
         (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
            map(
            (NULL < c_retired2 and c_retired2 <= 52) => 0.0880023384,
            (c_retired2 > 52) => -0.0290853044,
            (c_retired2 = NULL) => -0.0068534735, -0.0068534735),
         (r_F01_inp_addr_not_verified_i > 0.5) => 0.1117543557,
         (r_F01_inp_addr_not_verified_i = NULL) => 0.0090129247, 0.0090129247),
      (f_corrssnnamecount_d = NULL) => 0.0327793864, 0.0327793864),
   (f_rel_felony_count_i = NULL) => -0.0005704435, 0.0016810350),
(c_pop_45_54_p = NULL) => 0.0098699806, -0.0009348260);

// Tree: 237 
woFDN_FLA_SD_lgt_237 := map(
(NULL < C_INC_35K_P and C_INC_35K_P <= 5.35) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => -0.0273005638,
   (f_hh_collections_ct_i > 4.5) => 0.1382352290,
   (f_hh_collections_ct_i = NULL) => -0.0250323288, -0.0250323288),
(C_INC_35K_P > 5.35) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 109780) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 48120) => -0.0002784748,
      (f_addrchangevaluediff_d > 48120) => 0.0529331215,
      (f_addrchangevaluediff_d = NULL) => 0.0026512528, 0.0017168989),
   (f_curraddrmedianincome_d > 109780) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 101.5) => 0.0217479087,
      (f_prevaddrageoldest_d > 101.5) => 0.2212140717,
      (f_prevaddrageoldest_d = NULL) => 0.0830556904, 0.0830556904),
   (f_curraddrmedianincome_d = NULL) => 0.0043117304, 0.0038963527),
(C_INC_35K_P = NULL) => 0.0041042643, -0.0044957696);

// Tree: 238 
woFDN_FLA_SD_lgt_238 := map(
(NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 10.5) => -0.0035930716,
   (f_rel_criminal_count_i > 10.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 69.5) => 0.1120288428,
      (c_mort_indx > 69.5) => 0.0111963633,
      (c_mort_indx = NULL) => 0.0416199563, 0.0416199563),
   (f_rel_criminal_count_i = NULL) => -0.0027113853, -0.0027113853),
(f_inq_Auto_count24_i > 1.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 58.35) => -0.0257917135,
   (c_low_ed > 58.35) => -0.0976632366,
   (c_low_ed = NULL) => -0.0402510731, -0.0402510731),
(f_inq_Auto_count24_i = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 91.5) => 0.0601528033,
   (c_many_cars > 91.5) => -0.0631463374,
   (c_many_cars = NULL) => -0.0009096283, -0.0009096283), -0.0047084210);

// Tree: 239 
woFDN_FLA_SD_lgt_239 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 30.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 23.5) => -0.0027998266,
   (f_rel_homeover300_count_d > 23.5) => 0.1310887780,
   (f_rel_homeover300_count_d = NULL) => -0.0022331023, -0.0022331023),
(f_rel_homeover200_count_d > 30.5) => -0.0890650597,
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 33.45) => -0.0924970126,
   (c_sfdu_p > 33.45) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 17.25) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 10.95) => -0.0297843305,
         (c_hval_750k_p > 10.95) => 0.1070075284,
         (c_hval_750k_p = NULL) => 0.0164291353, 0.0164291353),
      (c_famotf18_p > 17.25) => 0.1299143333,
      (c_famotf18_p = NULL) => 0.0467667625, 0.0467667625),
   (c_sfdu_p = NULL) => 0.0022211106, 0.0022211106), -0.0027834994);

// Tree: 240 
woFDN_FLA_SD_lgt_240 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.85) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => 0.0059555543,
   (f_rel_ageover50_count_d > 4.5) => -0.0774957774,
   (f_rel_ageover50_count_d = NULL) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 142) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 1034.5) => -0.0631977444,
         (c_hh00 > 1034.5) => 0.0661677082,
         (c_hh00 = NULL) => -0.0345770691, -0.0345770691),
      (c_totcrime > 142) => 0.0803886921,
      (c_totcrime = NULL) => -0.0085916573, -0.0085916573), 0.0039427273),
(c_famotf18_p > 54.85) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.30788979955) => 0.1262619742,
   (f_add_input_mobility_index_i > 0.30788979955) => -0.0007952215,
   (f_add_input_mobility_index_i = NULL) => 0.0575261142, 0.0575261142),
(c_famotf18_p = NULL) => -0.0315458388, 0.0036327585);

// Tree: 241 
woFDN_FLA_SD_lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0015705283,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 144) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.35) => -0.0257881797,
      (c_pop_45_54_p > 14.35) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 41.5) => 0.1286409288,
         (r_pb_order_freq_d > 41.5) => 0.0065906953,
         (r_pb_order_freq_d = NULL) => 0.1324291367, 0.0662508019),
      (c_pop_45_54_p = NULL) => 0.0244852136, 0.0244852136),
   (f_curraddrcrimeindex_i > 144) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.05777029435) => 0.1904285370,
      (f_add_input_nhood_BUS_pct_i > 0.05777029435) => 0.0066494428,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.1254182452, 0.1254182452),
   (f_curraddrcrimeindex_i = NULL) => 0.0414218221, 0.0414218221),
(k_comb_age_d = NULL) => 0.0014255488, 0.0014255488);

// Tree: 242 
woFDN_FLA_SD_lgt_242 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0028116820,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 5.75) => -0.0029337249,
   (c_incollege > 5.75) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 11.5) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.05127642275) => 0.0500940011,
         (f_add_input_nhood_BUS_pct_i > 0.05127642275) => 
            map(
            (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 3.5) => 0.0424033912,
            (f_rel_homeover200_count_d > 3.5) => 0.1884076124,
            (f_rel_homeover200_count_d = NULL) => 0.1106237042, 0.1106237042),
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0739106712, 0.0739106712),
      (f_rel_homeover150_count_d > 11.5) => -0.0193818109,
      (f_rel_homeover150_count_d = NULL) => 0.0527132780, 0.0527132780),
   (c_incollege = NULL) => 0.0262286794, 0.0262286794),
(k_inq_per_ssn_i = NULL) => 0.0006955969, 0.0006955969);

// Tree: 243 
woFDN_FLA_SD_lgt_243 := map(
(NULL < c_info and c_info <= 27.85) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 20.5) => 
         map(
         (NULL < f_idrisktype_i and f_idrisktype_i <= 3.5) => -0.0361330014,
         (f_idrisktype_i > 3.5) => 
            map(
            (NULL < c_new_homes and c_new_homes <= 116.5) => 0.1892735093,
            (c_new_homes > 116.5) => 0.0355569066,
            (c_new_homes = NULL) => 0.1206500259, 0.1206500259),
         (f_idrisktype_i = NULL) => 0.0422585123, 0.0422585123),
      (r_C13_max_lres_d > 20.5) => 0.0042923063,
      (r_C13_max_lres_d = NULL) => 0.0050185599, 0.0050185599),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0519986107,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0072396362, 0.0026152930),
(c_info > 27.85) => 0.1525080892,
(c_info = NULL) => 0.0158893620, 0.0036500333);

// Tree: 244 
woFDN_FLA_SD_lgt_244 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 56.05) => -0.0400723822,
   (c_fammar_p > 56.05) => -0.0075476633,
   (c_fammar_p = NULL) => 0.0054072907, -0.0096758037),
(f_curraddrcrimeindex_i > 121) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 23.55) => 0.0077235352,
   (c_hh4_p > 23.55) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 2.4) => 
         map(
         (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => -0.0690674824,
         (f_util_add_curr_misc_n > 0.5) => 0.1415811015,
         (f_util_add_curr_misc_n = NULL) => 0.0208092467, 0.0208092467),
      (c_bigapt_p > 2.4) => 0.1705488370,
      (c_bigapt_p = NULL) => 0.0689156309, 0.0689156309),
   (c_hh4_p = NULL) => 0.0118465392, 0.0118465392),
(f_curraddrcrimeindex_i = NULL) => 0.0001765778, -0.0040079543);

// Tree: 245 
woFDN_FLA_SD_lgt_245 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 16) => -0.0310470816,
(f_curraddrburglaryindex_i > 16) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 18.65) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 52052) => 0.0574259824,
      (f_curraddrmedianvalue_d > 52052) => 0.0001322161,
      (f_curraddrmedianvalue_d = NULL) => 0.0016968919, 0.0016968919),
   (c_hh5_p > 18.65) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0300228814,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.1529425024,
      (nf_seg_FraudPoint_3_0 = '') => 0.0547441460, 0.0547441460),
   (c_hh5_p = NULL) => 0.0034744019, 0.0034744019),
(f_curraddrburglaryindex_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.9) => -0.0914207217,
   (c_hh4_p > 11.9) => 0.0330450261,
   (c_hh4_p = NULL) => -0.0262243776, -0.0262243776), -0.0018326102);

// Tree: 246 
woFDN_FLA_SD_lgt_246 := map(
(NULL < c_hhsize and c_hhsize <= 4.425) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0960758094,
   (c_pop_45_54_p > 3.35) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 24.75) => 0.0005415289,
      (c_hval_40k_p > 24.75) => 
         map(
         (NULL < c_low_hval and c_low_hval <= 57.35) => 0.1626576481,
         (c_low_hval > 57.35) => -0.0215405072,
         (c_low_hval = NULL) => 0.0557380292, 0.0557380292),
      (c_hval_40k_p = NULL) => 0.0013342809, 0.0013342809),
   (c_pop_45_54_p = NULL) => -0.0000449489, -0.0000449489),
(c_hhsize > 4.425) => 0.0888051517,
(c_hhsize = NULL) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.0796866567,
   (k_estimated_income_d > 26500) => -0.0553966193,
   (k_estimated_income_d = NULL) => -0.0182810866, -0.0182810866), 0.0000611125);

// Tree: 247 
woFDN_FLA_SD_lgt_247 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 27.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 17.85) => 
         map(
         (NULL < c_for_sale and c_for_sale <= 178.5) => 0.0020124655,
         (c_for_sale > 178.5) => -0.0338685460,
         (c_for_sale = NULL) => -0.0014638134, -0.0014638134),
      (c_hh6_p > 17.85) => -0.0911621378,
      (c_hh6_p = NULL) => -0.0101224865, -0.0020894883),
   (r_D33_eviction_count_i > 3.5) => 0.0639790108,
   (r_D33_eviction_count_i = NULL) => -0.0017251691, -0.0017251691),
(f_srchfraudsrchcount_i > 27.5) => -0.0872358805,
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 1) => -0.0447541585,
   (c_hh6_p > 1) => 0.0586711709,
   (c_hh6_p = NULL) => 0.0084360109, 0.0084360109), -0.0020550023);

// Tree: 248 
woFDN_FLA_SD_lgt_248 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 40.45) => 
   map(
   (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 4.5) => -0.0013896516,
   (f_hh_workers_paw_d > 4.5) => -0.1011303250,
   (f_hh_workers_paw_d = NULL) => -0.0069968670, -0.0020886863),
(c_famotf18_p > 40.45) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 4.5) => 0.0386312372,
   (f_prevaddrlenofres_d > 4.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 170.5) => -0.0498517938,
         (c_sub_bus > 170.5) => -0.1279608287,
         (c_sub_bus = NULL) => -0.0879837636, -0.0879837636),
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0285446300,
      (nf_seg_FraudPoint_3_0 = '') => -0.0525852987, -0.0525852987),
   (f_prevaddrlenofres_d = NULL) => -0.0400555547, -0.0400555547),
(c_famotf18_p = NULL) => 0.0248684711, -0.0025819558);

// Tree: 249 
woFDN_FLA_SD_lgt_249 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 31422.5) => 
   map(
   (NULL < c_mort_indx and c_mort_indx <= 121.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 78.5) => 
         map(
         (NULL < c_white_col and c_white_col <= 17.55) => -0.0343065208,
         (c_white_col > 17.55) => 0.0882515373,
         (c_white_col = NULL) => 0.0600721298, 0.0600721298),
      (c_rest_indx > 78.5) => -0.0300082657,
      (c_rest_indx = NULL) => 0.0040829337, 0.0040829337),
   (c_mort_indx > 121.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 8.5) => 0.0311128931,
      (f_addrs_per_ssn_i > 8.5) => 0.1620555893,
      (f_addrs_per_ssn_i = NULL) => 0.0823513394, 0.0823513394),
   (c_mort_indx = NULL) => -0.0054994835, 0.0196088073),
(f_curraddrmedianincome_d > 31422.5) => -0.0028982171,
(f_curraddrmedianincome_d = NULL) => -0.0172425380, -0.0008313617);

// Tree: 250 
woFDN_FLA_SD_lgt_250 := map(
(NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => 
   map(
   (NULL < c_rnt2000_p and c_rnt2000_p <= 1.75) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 0.0144703794,
      (k_inq_per_addr_i > 3.5) => 0.0497848864,
      (k_inq_per_addr_i = NULL) => 0.0180882906, 0.0180882906),
   (c_rnt2000_p > 1.75) => -0.0216894839,
   (c_rnt2000_p = NULL) => -0.0311425480, 0.0073440136),
(f_rel_incomeover75_count_d > 1.5) => -0.0080159544,
(f_rel_incomeover75_count_d = NULL) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 3.35) => -0.0387662601,
   (c_femdiv_p > 3.35) => 
      map(
      (NULL < c_medi_indx and c_medi_indx <= 100.5) => 0.1239786548,
      (c_medi_indx > 100.5) => 0.0171976070,
      (c_medi_indx = NULL) => 0.0615960427, 0.0615960427),
   (c_femdiv_p = NULL) => 0.0227461190, 0.0227461190), -0.0003451899);

// Tree: 251 
woFDN_FLA_SD_lgt_251 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1334) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 22.5) => 0.0040800646,
      (f_phones_per_addr_curr_i > 22.5) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 161.5) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 161.5) => -0.0160971580,
            (r_C13_max_lres_d > 161.5) => 0.0977596495,
            (r_C13_max_lres_d = NULL) => 0.0184049049, 0.0184049049),
         (c_bel_edu > 161.5) => 0.1316653131,
         (c_bel_edu = NULL) => 0.0379651982, 0.0379651982),
      (f_phones_per_addr_curr_i = NULL) => 0.0050782949, 0.0050782949),
   (k_inq_adls_per_addr_i > 4.5) => -0.0616780286,
   (k_inq_adls_per_addr_i = NULL) => 0.0043482226, 0.0043482226),
(f_liens_rel_SC_total_amt_i > 1334) => -0.1205008232,
(f_liens_rel_SC_total_amt_i = NULL) => -0.0237494852, 0.0036092588);

// Tree: 252 
woFDN_FLA_SD_lgt_252 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 119.5) => 0.0785827929,
(r_D32_Mos_Since_Fel_LS_d > 119.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 56.5) => 0.1149697203,
      (c_many_cars > 56.5) => 
         map(
         (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 4.5) => -0.0978487192,
         (f_rel_homeover100_count_d > 4.5) => 
            map(
            (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 32.5) => 0.1553212803,
            (f_curraddrmurderindex_i > 32.5) => 0.0012099547,
            (f_curraddrmurderindex_i = NULL) => 0.0452417620, 0.0452417620),
         (f_rel_homeover100_count_d = NULL) => 0.0011269101, 0.0011269101),
      (c_many_cars = NULL) => 0.0345544389, 0.0345544389),
   (r_F00_dob_score_d > 95) => 0.0025320635,
   (r_F00_dob_score_d = NULL) => -0.0229430724, 0.0027027735),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0070435568, 0.0031687145);

// Tree: 253 
woFDN_FLA_SD_lgt_253 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 5.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 31.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 43.55) => 0.0022883801,
      (c_famotf18_p > 43.55) => -0.0424824729,
      (c_famotf18_p = NULL) => 0.0099111519, 0.0014547913),
   (f_rel_under500miles_cnt_d > 31.5) => -0.0588291652,
   (f_rel_under500miles_cnt_d = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 105.5) => -0.0365869046,
      (c_many_cars > 105.5) => 0.0951533512,
      (c_many_cars = NULL) => -0.0030304243, -0.0030304243), 0.0004211753),
(r_D34_unrel_liens_ct_i > 5.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 33.85) => -0.1214496353,
   (c_hh2_p > 33.85) => -0.0227901085,
   (c_hh2_p = NULL) => -0.0751400615, -0.0751400615),
(r_D34_unrel_liens_ct_i = NULL) => -0.0145991549, -0.0005906733);

// Tree: 254 
woFDN_FLA_SD_lgt_254 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 37.45) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 6.5) => -0.0111584215,
   (f_inq_HighRiskCredit_count24_i > 6.5) => -0.0758558825,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0067431596, -0.0116166474),
(c_fammar18_p > 37.45) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 9.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 135.5) => 0.0007279987,
      (c_serv_empl > 135.5) => 0.0395143260,
      (c_serv_empl = NULL) => 0.0084204238, 0.0084204238),
   (f_inq_Collection_count_i > 9.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 9.65) => -0.0056477856,
      (c_rnt1000_p > 9.65) => 0.1583792491,
      (c_rnt1000_p = NULL) => 0.0787637878, 0.0787637878),
   (f_inq_Collection_count_i = NULL) => 0.0106336189, 0.0106336189),
(c_fammar18_p = NULL) => 0.0338843554, -0.0009191295);

// Tree: 255 
woFDN_FLA_SD_lgt_255 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 44721) => 0.0001986416,
   (f_addrchangeincomediff_d > 44721) => 0.0794199569,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 36.5) => -0.0709690579,
         (c_no_teens > 36.5) => 0.0023612808,
         (c_no_teens = NULL) => 0.0047986166, -0.0078660381),
      (f_addrs_per_ssn_c6_i > 1.5) => 0.1340729130,
      (f_addrs_per_ssn_c6_i = NULL) => -0.0052267865, -0.0052267865), -0.0004774347),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0078986947,
   (f_phones_per_addr_c6_i > 0.5) => 0.1455657440,
   (f_phones_per_addr_c6_i = NULL) => 0.0557329018, 0.0557329018),
(f_hh_lienholders_i = NULL) => -0.0106065102, -0.0000306081);

// Tree: 256 
woFDN_FLA_SD_lgt_256 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 72.5) => -0.0234999618,
(r_C13_max_lres_d > 72.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 33.5) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 774776) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 0.55) => 0.0578576308,
         (c_pop_85p_p > 0.55) => -0.0056845207,
         (c_pop_85p_p = NULL) => 0.0179269860, 0.0179269860),
      (c_med_hval > 774776) => 0.1423647106,
      (c_med_hval = NULL) => 0.0251955446, 0.0251955446),
   (c_born_usa > 33.5) => 0.0025602077,
   (c_born_usa = NULL) => -0.0488334489, 0.0054149139),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 109.5) => -0.0545390922,
   (c_preschl > 109.5) => 0.0673381923,
   (c_preschl = NULL) => 0.0034977099, 0.0034977099), -0.0010986091);

// Tree: 257 
woFDN_FLA_SD_lgt_257 := map(
(NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 786.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 184.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 8.35) => 0.0160348194,
      (c_newhouse > 8.35) => -0.0076796700,
      (c_newhouse = NULL) => 0.0020385172, 0.0020385172),
   (c_span_lang > 184.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.4602345542) => 
         map(
         (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => -0.0340901256,
         (f_acc_damage_amt_total_i > 275) => 0.1101440250,
         (f_acc_damage_amt_total_i = NULL) => -0.0248257154, -0.0248257154),
      (f_add_curr_mobility_index_i > 0.4602345542) => -0.1302572163,
      (f_add_curr_mobility_index_i = NULL) => -0.0325762225, -0.0325762225),
   (c_span_lang = NULL) => 0.0167275578, -0.0000323636),
(f_liens_unrel_O_total_amt_i > 786.5) => -0.0610785186,
(f_liens_unrel_O_total_amt_i = NULL) => 0.0388816852, -0.0007370532);

// Tree: 258 
woFDN_FLA_SD_lgt_258 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 4.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 132703.5) => -0.0044652227,
   (f_addrchangevaluediff_d > 132703.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 190797) => 0.1453327412,
      (f_curraddrmedianvalue_d > 190797) => -0.0006206897,
      (f_curraddrmedianvalue_d = NULL) => 0.0425607987, 0.0425607987),
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_trailer_p and c_trailer_p <= 33.55) => 0.0026557771,
      (c_trailer_p > 33.55) => 0.1373471831,
      (c_trailer_p = NULL) => 0.0135202675, 0.0088001361), -0.0010339903),
(r_D33_eviction_count_i > 4.5) => -0.0799102981,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 2.45) => -0.0635275765,
   (c_high_hval > 2.45) => 0.0602954810,
   (c_high_hval = NULL) => 0.0069234735, 0.0069234735), -0.0012671073);

// Tree: 259 
woFDN_FLA_SD_lgt_259 := map(
(NULL < c_old_homes and c_old_homes <= 160.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 599.5) => -0.0095968218,
   (r_pb_order_freq_d > 599.5) => -0.0689631465,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 79818.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 75520.5) => 0.0142906903,
         (r_A46_Curr_AVM_AutoVal_d > 75520.5) => 0.1677126469,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.1143636127, 0.0583989461),
      (r_L80_Inp_AVM_AutoVal_d > 79818.5) => 0.0094996503,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0051678742, 0.0114913830), -0.0029008221),
(c_old_homes > 160.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 24500) => -0.0978862073,
   (k_estimated_income_d > 24500) => -0.0263862243,
   (k_estimated_income_d = NULL) => -0.0287776636, -0.0287776636),
(c_old_homes = NULL) => -0.0513048687, -0.0076637391);

// Tree: 260 
woFDN_FLA_SD_lgt_260 := map(
(NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 1.25) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.7) => 0.1553512518,
      (c_pop_55_64_p > 8.7) => -0.0191587075,
      (c_pop_55_64_p = NULL) => 0.0680962721, 0.0680962721),
   (c_rnt500_p > 1.25) => 
      map(
      (NULL < c_retired and c_retired <= 2.95) => 0.0553770181,
      (c_retired > 2.95) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0481829977,
         (f_srchvelocityrisktype_i > 4.5) => -0.1069868906,
         (f_srchvelocityrisktype_i = NULL) => -0.0576250862, -0.0576250862),
      (c_retired = NULL) => -0.0431074548, -0.0431074548),
   (c_rnt500_p = NULL) => -0.0266571993, -0.0266571993),
(C_INC_150K_P > 0.55) => 0.0041814240,
(C_INC_150K_P = NULL) => -0.0120492268, 0.0021579780);

// Tree: 261 
woFDN_FLA_SD_lgt_261 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 142.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0346120846,
         (f_srchaddrsrchcount_i > 1.5) => 0.0846972276,
         (f_srchaddrsrchcount_i = NULL) => -0.0071545991, -0.0071545991),
      (c_serv_empl > 142.5) => 
         map(
         (NULL < c_families and c_families <= 257.5) => -0.0066689804,
         (c_families > 257.5) => 0.1375356254,
         (c_families = NULL) => 0.0913577460, 0.0913577460),
      (c_serv_empl = NULL) => 0.1026798803, 0.0316766343),
   (f_corrssnaddrcount_d > 1.5) => 0.0026807344,
   (f_corrssnaddrcount_d = NULL) => 0.0113507688, 0.0041426461),
(r_L77_Add_PO_Box_i > 0.5) => -0.0951267134,
(r_L77_Add_PO_Box_i = NULL) => 0.0020688281, 0.0020688281);

// Tree: 262 
woFDN_FLA_SD_lgt_262 := map(
(NULL < c_hval_100k_p and c_hval_100k_p <= 47.85) => 
   map(
   (NULL < f_srchaddrsrchcountwk_i and f_srchaddrsrchcountwk_i <= 1.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0019924450,
      (f_srchvelocityrisktype_i > 4.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 5.95) => -0.0029716587,
         (c_incollege > 5.95) => 
            map(
            (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.87182511395) => 0.0762954523,
            (f_add_curr_nhood_SFD_pct_d > 0.87182511395) => -0.0006197809,
            (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0480833011, 0.0480833011),
         (c_incollege = NULL) => 0.0215764253, 0.0215764253),
      (f_srchvelocityrisktype_i = NULL) => 0.0011384465, 0.0011384465),
   (f_srchaddrsrchcountwk_i > 1.5) => -0.0781181844,
   (f_srchaddrsrchcountwk_i = NULL) => -0.0127653236, 0.0006642822),
(c_hval_100k_p > 47.85) => 0.1007367541,
(c_hval_100k_p = NULL) => -0.0165959776, 0.0008455841);

// Tree: 263 
woFDN_FLA_SD_lgt_263 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 49.95) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 5.05) => -0.0088017404,
   (c_hval_250k_p > 5.05) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 71.15) => 0.0079160029,
      (c_lowrent > 71.15) => 
         map(
         (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 1.5) => 
            map(
            (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => 0.1019606504,
            (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.2861014576,
            (nf_seg_FraudPoint_3_0 = '') => 0.1718071634, 0.1718071634),
         (f_property_owners_ct_d > 1.5) => -0.0006434560,
         (f_property_owners_ct_d = NULL) => 0.0722584094, 0.0722584094),
      (c_lowrent = NULL) => 0.0109578033, 0.0109578033),
   (c_hval_250k_p = NULL) => 0.0029954819, 0.0029954819),
(c_hval_500k_p > 49.95) => 0.0918879476,
(c_hval_500k_p = NULL) => 0.0055170892, 0.0037404793);

// Tree: 264 
woFDN_FLA_SD_lgt_264 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -26347.5) => -0.0546852889,
(f_addrchangeincomediff_d > -26347.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 4.5) => 
      map(
      (NULL < c_health and c_health <= 9.2) => 0.2162819141,
      (c_health > 9.2) => 0.0124634507,
      (c_health = NULL) => 0.1095198618, 0.1095198618),
   (r_D32_Mos_Since_Crim_LS_d > 4.5) => 0.0026679065,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0038365998, 0.0038365998),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 262) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 151.5) => 0.0077471891,
      (c_easiqlife > 151.5) => 0.0728811665,
      (c_easiqlife = NULL) => 0.0085104725, 0.0168298302),
   (f_liens_unrel_CJ_total_amt_i > 262) => -0.0535067656,
   (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0156672197, 0.0104237213), 0.0044633682);

// Tree: 265 
woFDN_FLA_SD_lgt_265 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 35.9) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
         map(
         (NULL < c_exp_homes and c_exp_homes <= 196.5) => 0.0025491714,
         (c_exp_homes > 196.5) => 0.0733247816,
         (c_exp_homes = NULL) => 0.0040220284, 0.0040220284),
      (f_rel_incomeover50_count_d > 22.5) => -0.0644422235,
      (f_rel_incomeover50_count_d = NULL) => -0.0039255671, 0.0024984368),
   (c_hval_200k_p > 35.9) => 0.1291583824,
   (c_hval_200k_p = NULL) => 0.0001187763, 0.0031769255),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0675026933,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0533938809,
   (c_rich_nfam > 124) => -0.0672026471,
   (c_rich_nfam = NULL) => -0.0069043831, -0.0069043831), 0.0034054959);

// Tree: 266 
woFDN_FLA_SD_lgt_266 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0047924672,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 17.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 100572.5) => 0.0025493829,
      (f_curraddrmedianincome_d > 100572.5) => 0.1776000745,
      (f_curraddrmedianincome_d = NULL) => 0.0251457957, 0.0251457957),
   (f_addrchangecrimediff_i > 17.5) => 0.1420107116,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.3530250069) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 3.25) => 0.1316152466,
         (C_INC_150K_P > 3.25) => -0.0798366144,
         (C_INC_150K_P = NULL) => -0.0009366663, -0.0009366663),
      (f_add_curr_nhood_MFD_pct_i > 0.3530250069) => 0.1221647633,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0455971808, 0.0078250841), 0.0269375860),
(r_L70_Add_Standardized_i = NULL) => -0.0022460585, -0.0022460585);

// Tree: 267 
woFDN_FLA_SD_lgt_267 := map(
(NULL < c_unempl and c_unempl <= 169.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.65) => -0.0013146962,
   (c_unemp > 8.65) => 
      map(
      (NULL < c_food and c_food <= 6.25) => 0.1429328728,
      (c_food > 6.25) => 0.0058588368,
      (c_food = NULL) => 0.0491453745, 0.0491453745),
   (c_unemp = NULL) => -0.0004946985, -0.0004946985),
(c_unempl > 169.5) => -0.0286385260,
(c_unempl = NULL) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.4444870892) => 0.0268226236,
      (f_add_input_mobility_index_i > 0.4444870892) => 0.1771965861,
      (f_add_input_mobility_index_i = NULL) => 0.0970908304, 0.0970908304),
   (k_estimated_income_d > 27500) => -0.0443492902,
   (k_estimated_income_d = NULL) => 0.0137156014, 0.0137156014), -0.0017362304);

// Tree: 268 
woFDN_FLA_SD_lgt_268 := map(
(NULL < c_retail and c_retail <= 28.75) => -0.0049714414,
(c_retail > 28.75) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 11.75) => 
      map(
      (NULL < c_bargains and c_bargains <= 132.5) => -0.0144176874,
      (c_bargains > 132.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 58.25) => 0.2419394712,
         (c_oldhouse > 58.25) => 0.0198278492,
         (c_oldhouse = NULL) => 0.0682634054, 0.0682634054),
      (c_bargains = NULL) => 0.0113499153, 0.0113499153),
   (c_hh5_p > 11.75) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 9.7) => 0.1917455202,
      (c_newhouse > 9.7) => 0.0214562875,
      (c_newhouse = NULL) => 0.0919207976, 0.0919207976),
   (c_hh5_p = NULL) => 0.0261616781, 0.0261616781),
(c_retail = NULL) => -0.0236846126, -0.0023048470);

// Tree: 269 
woFDN_FLA_SD_lgt_269 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 86242) => 0.0003819967,
(f_addrchangevaluediff_d > 86242) => -0.0535631519,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 25.05) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 5.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 88.95) => 
            map(
            (NULL < c_many_cars and c_many_cars <= 40.5) => 0.1034449524,
            (c_many_cars > 40.5) => 0.0315144363,
            (c_many_cars = NULL) => 0.0470050905, 0.0470050905),
         (c_occunit_p > 88.95) => -0.0154294912,
         (c_occunit_p = NULL) => 0.0017738455, 0.0017738455),
      (r_C14_addrs_15yr_i > 5.5) => -0.0490829470,
      (r_C14_addrs_15yr_i = NULL) => -0.0191105831, -0.0087613112),
   (c_pop_35_44_p > 25.05) => 0.1235809615,
   (c_pop_35_44_p = NULL) => 0.0040627116, -0.0047353194), -0.0017456315);

// Tree: 270 
woFDN_FLA_SD_lgt_270 := map(
(NULL < c_pop00 and c_pop00 <= 740.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 20.8) => -0.0611509371,
   (C_INC_25K_P > 20.8) => 0.0728753390,
   (C_INC_25K_P = NULL) => -0.0485578642, -0.0485578642),
(c_pop00 > 740.5) => 
   map(
   (NULL < c_transport and c_transport <= 8.45) => -0.0004265435,
   (c_transport > 8.45) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1105) => 0.0135484995,
      (c_med_rent > 1105) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 272) => -0.0065051165,
         (r_A50_pb_total_dollars_d > 272) => 0.2479488359,
         (r_A50_pb_total_dollars_d = NULL) => 0.1499496785, 0.1499496785),
      (c_med_rent = NULL) => 0.0354912979, 0.0354912979),
   (c_transport = NULL) => 0.0023728816, 0.0023728816),
(c_pop00 = NULL) => -0.0243025582, -0.0006194105);

// Tree: 271 
woFDN_FLA_SD_lgt_271 := map(
(NULL < c_hh2_p and c_hh2_p <= 52.15) => -0.0046033125,
(c_hh2_p > 52.15) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 125.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 132) => -0.0639532864,
      (c_born_usa > 132) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.9640750571) => 0.0051916414,
         (f_add_curr_nhood_SFD_pct_d > 0.9640750571) => 0.2718302711,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0990784828, 0.0990784828),
      (c_born_usa = NULL) => 0.0080020933, 0.0080020933),
   (c_span_lang > 125.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 85.5) => 0.2657670009,
      (c_many_cars > 85.5) => -0.0077905687,
      (c_many_cars = NULL) => 0.1478542554, 0.1478542554),
   (c_span_lang = NULL) => 0.0448722087, 0.0448722087),
(c_hh2_p = NULL) => 0.0183620913, -0.0023549043);

// Tree: 272 
woFDN_FLA_SD_lgt_272 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 187.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 32.5) => 0.1777401762,
   (f_fp_prevaddrcrimeindex_i > 32.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 99.5) => -0.0573663003,
      (c_robbery > 99.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => 0.0044205951,
         (r_L79_adls_per_addr_c6_i > 1.5) => 0.1143891937,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0482771196, 0.0482771196),
      (c_robbery = NULL) => 0.0002573833, 0.0002573833),
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0375742782, 0.0375742782),
(f_mos_liens_unrel_SC_fseen_d > 187.5) => 
   map(
   (NULL < r_I60_credit_seeking_i and r_I60_credit_seeking_i <= 2.5) => -0.0005254778,
   (r_I60_credit_seeking_i > 2.5) => 0.0963463705,
   (r_I60_credit_seeking_i = NULL) => -0.0000960672, -0.0000960672),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0248710000, 0.0008414075);

// Tree: 273 
woFDN_FLA_SD_lgt_273 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 196.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 166.5) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 4.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 382.5) => 
            map(
            (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 9.5) => 0.0110028950,
            (r_D30_Derog_Count_i > 9.5) => -0.0457406452,
            (r_D30_Derog_Count_i = NULL) => 0.0099284234, 0.0099284234),
         (f_prevaddrageoldest_d > 382.5) => -0.0693837010,
         (f_prevaddrageoldest_d = NULL) => 0.0080966745, 0.0080966745),
      (f_inq_Other_count24_i > 4.5) => 0.0806460200,
      (f_inq_Other_count24_i = NULL) => 0.0087186385, 0.0087186385),
   (c_new_homes > 166.5) => -0.0229676299,
   (c_new_homes = NULL) => -0.0059082646, 0.0008553094),
(f_fp_prevaddrcrimeindex_i > 196.5) => -0.0789342533,
(f_fp_prevaddrcrimeindex_i = NULL) => 0.0316248958, 0.0004162059);

// Tree: 274 
woFDN_FLA_SD_lgt_274 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 24.65) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 10.5) => 0.0025187434,
   (f_rel_homeover300_count_d > 10.5) => -0.0344052662,
   (f_rel_homeover300_count_d = NULL) => -0.0200556456, -0.0004420656),
(c_rnt2001_p > 24.65) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 53.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 5.3) => 0.0472253837,
      (c_pop_18_24_p > 5.3) => 0.2513608053,
      (c_pop_18_24_p = NULL) => 0.1526953515, 0.1526953515),
   (c_exp_prod > 53.5) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 11.65) => -0.0062375675,
      (c_pop_12_17_p > 11.65) => 0.2467684957,
      (c_pop_12_17_p = NULL) => 0.0218742173, 0.0218742173),
   (c_exp_prod = NULL) => 0.0441416444, 0.0441416444),
(c_rnt2001_p = NULL) => -0.0056373568, 0.0019137340);

// Tree: 275 
woFDN_FLA_SD_lgt_275 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 16.65) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 0.1090904662,
      (r_D32_Mos_Since_Crim_LS_d > 14.5) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 47.5) => 0.0625990385,
         (c_serv_empl > 47.5) => -0.0127057335,
         (c_serv_empl = NULL) => 0.0047901745, 0.0047901745),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0094645397, 0.0094645397),
   (c_hval_200k_p > 16.65) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => 0.0274718365,
      (f_srchaddrsrchcount_i > 1.5) => 0.1621205459,
      (f_srchaddrsrchcount_i = NULL) => 0.0906121917, 0.0906121917),
   (c_hval_200k_p = NULL) => 0.0735622243, 0.0188619559),
(f_mos_inq_banko_cm_lseen_d > 44.5) => -0.0068291009,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0050248010, -0.0025294973);

// Tree: 276 
woFDN_FLA_SD_lgt_276 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 22.5) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 24.7) => -0.0026359825,
      (c_hval_40k_p > 24.7) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity']) => -0.0360663385,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','5: Vuln Vic/Friendly','6: Other']) => 
            map(
            (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => 0.2542557376,
            (f_crim_rel_under25miles_cnt_i > 0.5) => 0.0469513727,
            (f_crim_rel_under25miles_cnt_i = NULL) => 0.1516098870, 0.1516098870),
         (nf_seg_FraudPoint_3_0 = '') => 0.0676494704, 0.0676494704),
      (c_hval_40k_p = NULL) => -0.0027858185, -0.0015700153),
   (f_inq_HighRiskCredit_count_i > 22.5) => -0.0595440504,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0051771237, -0.0017697426),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0776448699,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0014504565, -0.0014504565);

// Tree: 277 
woFDN_FLA_SD_lgt_277 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 39.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 28.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 52.5) => 0.1619066218,
         (c_span_lang > 52.5) => 0.0077756022,
         (c_span_lang = NULL) => 0.0315879788, 0.0315879788),
      (r_F00_dob_score_d > 92) => -0.0031458566,
      (r_F00_dob_score_d = NULL) => -0.0207201349, -0.0026372395),
   (f_srchaddrsrchcount_i > 28.5) => 0.0747147745,
   (f_srchaddrsrchcount_i = NULL) => -0.0023220467, -0.0023220467),
(f_srchaddrsrchcount_i > 39.5) => -0.0832503950,
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0718233944,
   (c_assault > 90) => 0.0263259094,
   (c_assault = NULL) => -0.0276119963, -0.0276119963), -0.0028870604);

// Tree: 278 
woFDN_FLA_SD_lgt_278 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 24.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 176.5) => -0.0081106918,
   (c_sub_bus > 176.5) => 0.0211306526,
   (c_sub_bus = NULL) => 0.0239776877, -0.0037459729),
(f_rel_homeover200_count_d > 24.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => 0.0130654648,
   (f_srchvelocityrisktype_i > 2.5) => 0.1218319492,
   (f_srchvelocityrisktype_i = NULL) => 0.0519481694, 0.0519481694),
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 35.95) => -0.0832096105,
   (c_sfdu_p > 35.95) => 
      map(
      (NULL < c_unempl and c_unempl <= 112.5) => -0.0047606748,
      (c_unempl > 112.5) => 0.1003732246,
      (c_unempl = NULL) => 0.0302839583, 0.0302839583),
   (c_sfdu_p = NULL) => -0.0122761300, -0.0122761300), -0.0030563508);

// Tree: 279 
woFDN_FLA_SD_lgt_279 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < c_retail and c_retail <= 33.35) => -0.0035727689,
   (c_retail > 33.35) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 158.5) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 15.75) => 0.1194017915,
         (c_pop_45_54_p > 15.75) => -0.0138351410,
         (c_pop_45_54_p = NULL) => 0.0640958950, 0.0640958950),
      (c_span_lang > 158.5) => -0.0337093156,
      (c_span_lang = NULL) => 0.0385599338, 0.0385599338),
   (c_retail = NULL) => -0.0013495249, -0.0008664593),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0864702893,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 101.5) => -0.0772775946,
   (c_for_sale > 101.5) => 0.0343923762,
   (c_for_sale = NULL) => -0.0199058664, -0.0199058664), -0.0013869837);

// Tree: 280 
woFDN_FLA_SD_lgt_280 := map(
(NULL < c_cpiall and c_cpiall <= 208.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 8.55) => 
         map(
         (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 0.5) => 
            map(
            (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 101.5) => 0.0020731213,
            (f_fp_prevaddrcrimeindex_i > 101.5) => 0.1282166077,
            (f_fp_prevaddrcrimeindex_i = NULL) => 0.0292045416, 0.0292045416),
         (f_addrs_per_ssn_c6_i > 0.5) => 0.1899363962,
         (f_addrs_per_ssn_c6_i = NULL) => 0.0495900451, 0.0495900451),
      (c_unemp > 8.55) => 0.1466156650,
      (c_unemp = NULL) => 0.0606966495, 0.0606966495),
   (f_historical_count_d > 0.5) => 0.0006057828,
   (f_historical_count_d = NULL) => 0.0170006392, 0.0170006392),
(c_cpiall > 208.5) => -0.0067018420,
(c_cpiall = NULL) => -0.0102626989, -0.0035874773);

// Tree: 281 
woFDN_FLA_SD_lgt_281 := map(
(NULL < c_for_sale and c_for_sale <= 178.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => 0.0031615642,
   (r_S66_adlperssn_count_i > 3.5) => 
      map(
      (NULL < c_trailer and c_trailer <= 172.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 143.5) => -0.0107637097,
         (c_relig_indx > 143.5) => 0.1077205621,
         (c_relig_indx = NULL) => 0.0244151257, 0.0244151257),
      (c_trailer > 172.5) => 0.1976520529,
      (c_trailer = NULL) => 0.0423472290, 0.0423472290),
   (r_S66_adlperssn_count_i = NULL) => 0.0050525146, 0.0050525146),
(c_for_sale > 178.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 11.5) => -0.0258869631,
   (f_srchaddrsrchcount_i > 11.5) => -0.0892348584,
   (f_srchaddrsrchcount_i = NULL) => -0.0292041671, -0.0292041671),
(c_for_sale = NULL) => -0.0066945824, 0.0015687412);

// Tree: 282 
woFDN_FLA_SD_lgt_282 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0055088829,
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 2.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 6.35) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 6.25) => 
            map(
            (NULL < f_rel_count_i and f_rel_count_i <= 18.5) => 0.0657390603,
            (f_rel_count_i > 18.5) => 0.2388584862,
            (f_rel_count_i = NULL) => 0.1080029577, 0.1080029577),
         (c_pop_6_11_p > 6.25) => 0.0169793126,
         (c_pop_6_11_p = NULL) => 0.0393932276, 0.0393932276),
      (c_unemp > 6.35) => -0.0465432493,
      (c_unemp = NULL) => 0.0212807037, 0.0212807037),
   (f_idrisktype_i > 2.5) => 0.1651021184,
   (f_idrisktype_i = NULL) => 0.0295095976, 0.0295095976),
(f_hh_payday_loan_users_i = NULL) => -0.0021001519, -0.0022485171);

// Tree: 283 
woFDN_FLA_SD_lgt_283 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 16.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => -0.0906543409,
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => -0.0428440223,
      (r_F01_inp_addr_not_verified_i > 0.5) => 0.0593245069,
      (r_F01_inp_addr_not_verified_i = NULL) => -0.0341666951, -0.0341666951),
   (r_D33_Eviction_Recency_d = NULL) => -0.0389681450, -0.0389681450),
(f_mos_inq_banko_om_fseen_d > 16.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => 
      map(
      (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 1.5) => -0.0775869665,
      (f_hh_members_w_derog_i > 1.5) => 0.0513714480,
      (f_hh_members_w_derog_i = NULL) => -0.0498113080, -0.0498113080),
   (f_corrssnaddrcount_d > 0.5) => 0.0047719525,
   (f_corrssnaddrcount_d = NULL) => 0.0035674331, 0.0035674331),
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0162489804, 0.0007239524);

// Tree: 284 
woFDN_FLA_SD_lgt_284 := map(
(NULL < c_hh4_p and c_hh4_p <= 9.95) => -0.0157594567,
(c_hh4_p > 9.95) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 24.35) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 461.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 6.5) => 0.0070598463,
         (k_inq_per_ssn_i > 6.5) => 0.0587253654,
         (k_inq_per_ssn_i = NULL) => 0.0084299603, 0.0084299603),
      (r_C10_M_Hdr_FS_d > 461.5) => -0.0680892506,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0225199582, 0.0058756916),
   (C_INC_25K_P > 24.35) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.75) => 0.2018524130,
      (c_pop_6_11_p > 8.75) => -0.0192715870,
      (c_pop_6_11_p = NULL) => 0.0883551387, 0.0883551387),
   (C_INC_25K_P = NULL) => 0.0069719252, 0.0069719252),
(c_hh4_p = NULL) => -0.0121365358, -0.0004497076);

// Tree: 285 
woFDN_FLA_SD_lgt_285 := map(
(NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.23621115115) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.1572828997) => -0.0299715918,
   (f_add_input_mobility_index_i > 0.1572828997) => 
      map(
      (NULL < c_retail and c_retail <= 11.35) => -0.0115330450,
      (c_retail > 11.35) => 
         map(
         (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 18) => 
            map(
            (NULL < c_burglary and c_burglary <= 59.5) => 0.2456746732,
            (c_burglary > 59.5) => 0.0566064372,
            (c_burglary = NULL) => 0.1351629578, 0.1351629578),
         (r_I61_inq_collection_recency_d > 18) => 0.0270909493,
         (r_I61_inq_collection_recency_d = NULL) => 0.0357611330, 0.0357611330),
      (c_retail = NULL) => 0.0118525047, 0.0090742265),
   (f_add_input_mobility_index_i = NULL) => 0.0022255730, 0.0022255730),
(f_add_curr_mobility_index_i > 0.23621115115) => -0.0074929326,
(f_add_curr_mobility_index_i = NULL) => 0.0490064902, -0.0026635735);

// Tree: 286 
woFDN_FLA_SD_lgt_286 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 21.05) => -0.0040561345,
(c_pop_35_44_p > 21.05) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 31.85) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -5.5) => 0.1174066514,
      (f_addrchangecrimediff_i > -5.5) => 
         map(
         (NULL < c_hval_40k_p and c_hval_40k_p <= 2.95) => 0.0056101754,
         (c_hval_40k_p > 2.95) => 
            map(
            (NULL < C_INC_200K_P and C_INC_200K_P <= 2.25) => -0.0022926866,
            (C_INC_200K_P > 2.25) => 0.2541149746,
            (C_INC_200K_P = NULL) => 0.1379644956, 0.1379644956),
         (c_hval_40k_p = NULL) => 0.0225156945, 0.0225156945),
      (f_addrchangecrimediff_i = NULL) => -0.0139381439, 0.0200102949),
   (c_hval_500k_p > 31.85) => 0.1796798315,
   (c_hval_500k_p = NULL) => 0.0269634418, 0.0269634418),
(c_pop_35_44_p = NULL) => 0.0153464787, -0.0005577013);

// Tree: 287 
woFDN_FLA_SD_lgt_287 := map(
(NULL < c_hhsize and c_hhsize <= 4.255) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 3.925) => 
      map(
      (NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 22.5) => -0.0870733027,
      (f_mos_liens_unrel_OT_fseen_d > 22.5) => -0.0024467470,
      (f_mos_liens_unrel_OT_fseen_d = NULL) => 0.0043619614, -0.0028975341),
   (c_hhsize > 3.925) => -0.0704749998,
   (c_hhsize = NULL) => -0.0036734011, -0.0036734011),
(c_hhsize > 4.255) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 3.5) => 0.1409593148,
   (c_lowrent > 3.5) => -0.0088157597,
   (c_lowrent = NULL) => 0.0546482549, 0.0546482549),
(c_hhsize = NULL) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2063427743) => 0.1323659979,
   (f_add_curr_mobility_index_i > 0.2063427743) => -0.0743528678,
   (f_add_curr_mobility_index_i = NULL) => 0.0135945895, 0.0181903838), -0.0026379263);

// Tree: 288 
woFDN_FLA_SD_lgt_288 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 14.35) => 
      map(
      (NULL < c_business and c_business <= 22.5) => 0.0099357037,
      (c_business > 22.5) => -0.0117885832,
      (c_business = NULL) => -0.0014547988, -0.0014547988),
   (c_pop_12_17_p > 14.35) => -0.0435950211,
   (c_pop_12_17_p = NULL) => 0.0089372908, -0.0023533402),
(f_inq_QuizProvider_count_i > 5.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0593671140,
   (f_inq_Collection_count_i > 1.5) => 0.1777423254,
   (f_inq_Collection_count_i = NULL) => 0.0420176118, 0.0420176118),
(f_inq_QuizProvider_count_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0500968804,
   (k_nap_lname_verd_d > 0.5) => -0.0426335310,
   (k_nap_lname_verd_d = NULL) => 0.0019345737, 0.0019345737), -0.0018025378);

// Tree: 289 
woFDN_FLA_SD_lgt_289 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 26.25) => -0.0045298232,
   (c_rnt1250_p > 26.25) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 159.5) => 0.0068421747,
      (c_rich_fam > 159.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.55) => 0.0646780883,
         (r_C12_source_profile_d > 78.55) => 0.2556210043,
         (r_C12_source_profile_d = NULL) => 0.0950148132, 0.0950148132),
      (c_rich_fam = NULL) => 0.0269368974, 0.0269368974),
   (c_rnt1250_p = NULL) => 0.0216149555, 0.0007650320),
(r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.0705927846,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 86) => 0.0694543181,
   (c_robbery > 86) => -0.0370450569,
   (c_robbery = NULL) => 0.0162046306, 0.0162046306), 0.0004904049);

// Tree: 290 
woFDN_FLA_SD_lgt_290 := map(
(NULL < r_C22_stl_inq_Count24_i and r_C22_stl_inq_Count24_i <= 0.5) => 
   map(
   (NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
      map(
      (NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i <= 9) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 23371) => -0.0359273979,
         (f_prevaddrmedianincome_d > 23371) => 0.0044311684,
         (f_prevaddrmedianincome_d = NULL) => 0.0019767991, 0.0019767991),
      (r_C12_NonDerog_Recency_i > 9) => 0.1036248444,
      (r_C12_NonDerog_Recency_i = NULL) => 0.0024344523, 0.0024344523),
   (f_assoccredbureaucountmo_i > 0.5) => 0.0955830962,
   (f_assoccredbureaucountmo_i = NULL) => 0.0028742195, 0.0028742195),
(r_C22_stl_inq_Count24_i > 0.5) => 0.0726012174,
(r_C22_stl_inq_Count24_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0236348018) => -0.0426380808,
   (f_add_input_nhood_VAC_pct_i > 0.0236348018) => 0.0581533703,
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0047425159, 0.0047425159), 0.0032817250);

// Tree: 291 
woFDN_FLA_SD_lgt_291 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 28001) => 0.0021802514,
(f_addrchangeincomediff_d > 28001) => -0.0536460265,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1161488498) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 41.65) => -0.0658027090,
      (c_fammar_p > 41.65) => -0.0023015317,
      (c_fammar_p = NULL) => 0.0180304568, -0.0030963756),
   (f_add_curr_nhood_VAC_pct_i > 0.1161488498) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 21.75) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 115.5) => 0.1001550693,
         (c_relig_indx > 115.5) => -0.0698749518,
         (c_relig_indx = NULL) => 0.0262574063, 0.0262574063),
      (c_famotf18_p > 21.75) => 0.1558585374,
      (c_famotf18_p = NULL) => 0.0498953484, 0.0498953484),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0160337480, 0.0036464991), 0.0016901756);

// Tree: 292 
woFDN_FLA_SD_lgt_292 := map(
(NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 7.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -267911) => -0.0738703572,
   (f_addrchangevaluediff_d > -267911) => -0.0011565122,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => -0.0000021538,
      (f_bus_addr_match_count_d > 6.5) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 279247.5) => 0.0212354370,
         (f_curraddrmedianvalue_d > 279247.5) => 0.1489182939,
         (f_curraddrmedianvalue_d = NULL) => 0.0647770564, 0.0647770564),
      (f_bus_addr_match_count_d = NULL) => 0.0051715998, 0.0051715998), -0.0001366932),
(f_inq_Banking_count24_i > 7.5) => -0.1117772480,
(f_inq_Banking_count24_i = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 11.45) => 0.0715654335,
   (c_newhouse > 11.45) => -0.0375509156,
   (c_newhouse = NULL) => 0.0141852844, 0.0141852844), -0.0004356116);

// Tree: 293 
woFDN_FLA_SD_lgt_293 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 194.5) => -0.0005935187,
      (c_relig_indx > 194.5) => 0.0645227548,
      (c_relig_indx = NULL) => 0.0015233666, 0.0015233666),
   (r_D34_unrel_liens_ct_i > 7.5) => 0.0945203293,
   (r_D34_unrel_liens_ct_i = NULL) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 40.55) => 0.0622313411,
      (c_low_ed > 40.55) => -0.0611689327,
      (c_low_ed = NULL) => 0.0005312042, 0.0005312042), 0.0020738143),
(c_cartheft > 189.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0940565175) => -0.0642644232,
   (f_add_curr_nhood_BUS_pct_i > 0.0940565175) => -0.0469440951,
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0590104419, -0.0590104419),
(c_cartheft = NULL) => 0.0138752338, 0.0004621343);

// Tree: 294 
woFDN_FLA_SD_lgt_294 := map(
(NULL < c_span_lang and c_span_lang <= 185.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30362.5) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => -0.0142160585,
      (r_C14_addrs_15yr_i > 1.5) => 0.0669235695,
      (r_C14_addrs_15yr_i = NULL) => 0.0267574352, 0.0267574352),
   (f_curraddrmedianincome_d > 30362.5) => 0.0000277122,
   (f_curraddrmedianincome_d = NULL) => 0.0168070662, 0.0020139447),
(c_span_lang > 185.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 118) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.0884202334,
      (r_F01_inp_addr_address_score_d > 95) => -0.0214105355,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0109972426, -0.0109972426),
   (f_prevaddrmurderindex_i > 118) => -0.0737811759,
   (f_prevaddrmurderindex_i = NULL) => -0.0331134833, -0.0331134833),
(c_span_lang = NULL) => 0.0157744577, -0.0001033188);

// Tree: 295 
woFDN_FLA_SD_lgt_295 := map(
(NULL < c_serv_empl and c_serv_empl <= 141.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 1.5) => -0.0030220679,
   (r_L70_Add_Standardized_i > 1.5) => -0.0878948534,
   (r_L70_Add_Standardized_i = NULL) => -0.0042273287, -0.0042273287),
(c_serv_empl > 141.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 6008) => -0.0176713682,
   (r_A49_Curr_AVM_Chg_1yr_i > 6008) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 71250) => 0.0859926364,
      (r_L80_Inp_AVM_AutoVal_d > 71250) => 0.0379610846,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.1233929770, 0.0509151753),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 4.5) => 0.0144911516,
      (r_D32_criminal_count_i > 4.5) => 0.0861615726,
      (r_D32_criminal_count_i = NULL) => 0.0170152966, 0.0170152966), 0.0172508280),
(c_serv_empl = NULL) => -0.0167546791, 0.0011031614);

// Tree: 296 
woFDN_FLA_SD_lgt_296 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 4.5) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 58.5) => 0.0043330479,
   (c_old_homes > 58.5) => -0.1052841240,
   (c_old_homes = NULL) => -0.0580644192, -0.0580644192),
(r_I60_inq_hiRiskCred_recency_d > 4.5) => 
   map(
   (NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 3820) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 16.5) => -0.0010581997,
      (f_inq_count24_i > 16.5) => -0.1024299546,
      (f_inq_count24_i = NULL) => -0.0015984125, -0.0015984125),
   (f_liens_unrel_ST_total_amt_i > 3820) => 0.1233964535,
   (f_liens_unrel_ST_total_amt_i = NULL) => -0.0010457825, -0.0010457825),
(r_I60_inq_hiRiskCred_recency_d = NULL) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 697) => -0.0628293379,
   (c_hh00 > 697) => 0.0372814961,
   (c_hh00 = NULL) => -0.0160485744, -0.0160485744), -0.0017694529);

// Tree: 297 
woFDN_FLA_SD_lgt_297 := map(
(NULL < c_fammar_p and c_fammar_p <= 62.05) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 2.5) => -0.0210726572,
   (f_inq_Banking_count24_i > 2.5) => 0.0847117769,
   (f_inq_Banking_count24_i = NULL) => -0.0182517390, -0.0182517390),
(c_fammar_p > 62.05) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 261887.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => 0.0077052024,
      (f_inq_HighRiskCredit_count_i > 4.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 77) => -0.0095094523,
         (c_sub_bus > 77) => 0.1103010982,
         (c_sub_bus = NULL) => 0.0495638053, 0.0495638053),
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0084598837, 0.0084598837),
   (f_addrchangevaluediff_d > 261887.5) => 0.0987502297,
   (f_addrchangevaluediff_d = NULL) => -0.0025137701, 0.0068529545),
(c_fammar_p = NULL) => -0.0088815097, 0.0019833779);

// Tree: 298 
woFDN_FLA_SD_lgt_298 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
   map(
   (NULL < c_info and c_info <= 5.05) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 4.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 39.5) => 0.0084084299,
         (f_mos_inq_banko_cm_fseen_d > 39.5) => 0.0713560189,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0251323103, 0.0251323103),
      (f_historical_count_d > 4.5) => -0.0371438807,
      (f_historical_count_d = NULL) => 0.0099840476, 0.0099840476),
   (c_info > 5.05) => 0.1449052393,
   (c_info = NULL) => 0.1124000709, 0.0209631346),
(f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0036175333,
(f_mos_inq_banko_cm_lseen_d = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1266.5) => 0.0681031221,
   (c_popover18 > 1266.5) => -0.0601857692,
   (c_popover18 = NULL) => 0.0080780445, 0.0080780445), -0.0002744980);

// Tree: 299 
woFDN_FLA_SD_lgt_299 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 23.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 181.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 5.05) => 0.0481580305,
      (c_high_ed > 5.05) => -0.0011916109,
      (c_high_ed = NULL) => 0.0003137907, 0.0003137907),
   (c_span_lang > 181.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 24.15) => 0.0875274125,
      (c_med_age > 24.15) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 11.15) => 0.0672873424,
         (C_RENTOCC_P > 11.15) => -0.0436001157,
         (C_RENTOCC_P = NULL) => -0.0346731913, -0.0346731913),
      (c_med_age = NULL) => -0.0285913179, -0.0285913179),
   (c_span_lang = NULL) => -0.0312599491, -0.0028876309),
(f_inq_count_i > 23.5) => -0.0958063330,
(f_inq_count_i = NULL) => -0.0200260780, -0.0038127087);

// Tree: 300 
woFDN_FLA_SD_lgt_300 := map(
(NULL < c_assault and c_assault <= 179.5) => 0.0024413354,
(c_assault > 179.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0665782115) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 21.45) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 17.5) => 
            map(
            (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 0.5) => 0.0032541011,
            (f_srchaddrsrchcount_i > 0.5) => 0.1848292590,
            (f_srchaddrsrchcount_i = NULL) => 0.0957875951, 0.0957875951),
         (f_prevaddrageoldest_d > 17.5) => -0.0155664540,
         (f_prevaddrageoldest_d = NULL) => 0.0157330625, 0.0157330625),
      (C_INC_75K_P > 21.45) => 0.2437109051,
      (C_INC_75K_P = NULL) => 0.0528697246, 0.0528697246),
   (f_add_curr_nhood_BUS_pct_i > 0.0665782115) => 0.0064509497,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0322911242, 0.0322911242),
(c_assault = NULL) => 0.0078773024, 0.0044949732);

// Tree: 301 
woFDN_FLA_SD_lgt_301 := map(
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','6: Other']) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 5.5) => 
      map(
      (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => -0.0154984747,
      (f_srchaddrsrchcountmo_i > 0.5) => -0.0849050228,
      (f_srchaddrsrchcountmo_i = NULL) => -0.0165226923, -0.0165226923),
   (f_crim_rel_under25miles_cnt_i > 5.5) => 0.0811690348,
   (f_crim_rel_under25miles_cnt_i = NULL) => 
      map(
      (NULL < c_business and c_business <= 46.5) => -0.0389618042,
      (c_business > 46.5) => 0.0791780383,
      (c_business = NULL) => -0.0048830035, -0.0048830035), -0.0148217209),
(nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 197.5) => 0.0108349172,
   (c_serv_empl > 197.5) => -0.1127865376,
   (c_serv_empl = NULL) => 0.0394647309, 0.0097466726),
(nf_seg_FraudPoint_3_0 = '') => -0.0015468475, -0.0015468475);

// Tree: 302 
woFDN_FLA_SD_lgt_302 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 18.75) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 0.5) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.3708080063) => -0.0687129471,
      (f_add_input_nhood_VAC_pct_i > 0.3708080063) => 0.1192703218,
      (f_add_input_nhood_VAC_pct_i = NULL) => -0.0476458566, -0.0476458566),
   (f_rel_homeover100_count_d > 0.5) => 
      map(
      (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.0395202908,
      (f_adl_per_email_i > 0.5) => -0.0923219920,
      (f_adl_per_email_i = NULL) => 0.0042787041, 0.0041500580),
   (f_rel_homeover100_count_d = NULL) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 28) => -0.1163052874,
      (c_bel_edu > 28) => 0.0191672793,
      (c_bel_edu = NULL) => -0.0073472292, -0.0073472292), 0.0018963346),
(c_hh7p_p > 18.75) => -0.1246522519,
(c_hh7p_p = NULL) => -0.0390418152, 0.0003589138);

// Tree: 303 
woFDN_FLA_SD_lgt_303 := map(
(NULL < c_hhsize and c_hhsize <= 4.73) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 157.5) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0817679613,
      (f_attr_arrest_recency_d > 79.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -108) => 0.0697854261,
         (f_addrchangecrimediff_i > -108) => 0.0058113228,
         (f_addrchangecrimediff_i = NULL) => 
            map(
            (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => -0.0141443819,
            (f_inq_count_i > 14.5) => 0.1023066205,
            (f_inq_count_i = NULL) => -0.0107780253, -0.0107780253), 0.0028439071),
      (f_attr_arrest_recency_d = NULL) => 0.0023249006, 0.0034390921),
   (c_relig_indx > 157.5) => -0.0238854106,
   (c_relig_indx = NULL) => -0.0028856549, -0.0028856549),
(c_hhsize > 4.73) => -0.0965222839,
(c_hhsize = NULL) => -0.0057974908, -0.0033676644);

// Tree: 304 
woFDN_FLA_SD_lgt_304 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 0.5) => -0.0790256057,
(f_vardobcount_i > 0.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 11) => -0.0700916292,
   (r_F01_inp_addr_address_score_d > 11) => 
      map(
      (NULL < c_transport and c_transport <= 57.55) => 
         map(
         (NULL < c_totsales and c_totsales <= 951.5) => -0.0140888306,
         (c_totsales > 951.5) => 0.0095974020,
         (c_totsales = NULL) => 0.0043699602, 0.0043699602),
      (c_transport > 57.55) => 0.1059956511,
      (c_transport = NULL) => 0.0160808158, 0.0050214736),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0045810514, 0.0045810514),
(f_vardobcount_i = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 93.5) => 0.0171206370,
   (c_many_cars > 93.5) => -0.0764837970,
   (c_many_cars = NULL) => -0.0292441761, -0.0292441761), 0.0035125099);

// Tree: 305 
woFDN_FLA_SD_lgt_305 := map(
(NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 26.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 4.35) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 5.05) => 
            map(
            (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.45) => 0.0061197361,
            (c_pop_55_64_p > 12.45) => 0.1598913294,
            (c_pop_55_64_p = NULL) => 0.0412675288, 0.0412675288),
         (c_high_ed > 5.05) => -0.0233538710,
         (c_high_ed = NULL) => -0.0181624043, -0.0181624043),
      (c_incollege > 4.35) => 0.0097622899,
      (c_incollege = NULL) => -0.0096295262, 0.0004860515),
   (f_addrs_per_ssn_i > 26.5) => -0.0849072872,
   (f_addrs_per_ssn_i = NULL) => -0.0003818920, -0.0003818920),
(f_assoccredbureaucountmo_i > 0.5) => 0.1022233931,
(f_assoccredbureaucountmo_i = NULL) => -0.0064710194, 0.0001267146);

// Tree: 306 
woFDN_FLA_SD_lgt_306 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 270.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 28.35) => -0.1381898341,
   (c_hh2_p > 28.35) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 325) => 0.0942125272,
      (r_A50_pb_total_dollars_d > 325) => -0.0772367230,
      (r_A50_pb_total_dollars_d = NULL) => -0.0011802887, -0.0011802887),
   (c_hh2_p = NULL) => -0.0442606097, -0.0442606097),
(f_mos_liens_unrel_FT_fseen_d > 270.5) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 127.5) => 0.0121924887,
   (c_lux_prod > 127.5) => -0.0094889078,
   (c_lux_prod = NULL) => 0.0263616081, 0.0022631576),
(f_mos_liens_unrel_FT_fseen_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0613384412,
   (c_pop_35_44_p > 15.55) => 0.0390816016,
   (c_pop_35_44_p = NULL) => -0.0111284198, -0.0111284198), 0.0014291778);

// Tree: 307 
woFDN_FLA_SD_lgt_307 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 2.5) => 0.0017071246,
(r_I60_Inq_Count12_i > 2.5) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 177.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 112.5) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 142.5) => -0.0272149411,
         (f_curraddrcartheftindex_i > 142.5) => 0.0930478012,
         (f_curraddrcartheftindex_i = NULL) => -0.0181612842, -0.0181612842),
      (f_prevaddrmurderindex_i > 112.5) => -0.0813941761,
      (f_prevaddrmurderindex_i = NULL) => -0.0356206839, -0.0356206839),
   (c_apt20 > 177.5) => 0.0455517966,
   (c_apt20 = NULL) => -0.0247636252, -0.0247636252),
(r_I60_Inq_Count12_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 13.9) => -0.0638104828,
   (c_hh4_p > 13.9) => 0.0465732350,
   (c_hh4_p = NULL) => -0.0149681298, -0.0149681298), -0.0011237828);

// Tree: 308 
woFDN_FLA_SD_lgt_308 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 14.15) => -0.0071736159,
(c_rnt1000_p > 14.15) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => 0.0056799541,
   (f_hh_collections_ct_i > 1.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 90927.5) => 
         map(
         (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 0.0119663703,
         (f_inq_HighRiskCredit_count24_i > 2.5) => 0.1096204160,
         (f_inq_HighRiskCredit_count24_i = NULL) => 0.0154662694, 0.0154662694),
      (f_curraddrmedianincome_d > 90927.5) => 
         map(
         (NULL < f_accident_count_i and f_accident_count_i <= 0.5) => 0.0881713000,
         (f_accident_count_i > 0.5) => 0.2620797739,
         (f_accident_count_i = NULL) => 0.1298299839, 0.1298299839),
      (f_curraddrmedianincome_d = NULL) => 0.0333059235, 0.0333059235),
   (f_hh_collections_ct_i = NULL) => 0.0236740223, 0.0138417364),
(c_rnt1000_p = NULL) => 0.0174074269, 0.0030389875);

// Tree: 309 
woFDN_FLA_SD_lgt_309 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.3444255197) => 0.0065628705,
   (f_add_curr_nhood_MFD_pct_i > 0.3444255197) => 0.0714662744,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0347817418, 0.0347817418),
(r_I60_inq_comm_recency_d > 4.5) => 
   map(
   (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 1.5) => 
      map(
      (NULL < c_rnt2001_p and c_rnt2001_p <= 25.05) => -0.0053376201,
      (c_rnt2001_p > 25.05) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => -0.0289208040,
         (f_srchfraudsrchcount_i > 0.5) => 0.0844423278,
         (f_srchfraudsrchcount_i = NULL) => 0.0333719930, 0.0333719930),
      (c_rnt2001_p = NULL) => -0.0247655838, -0.0035794267),
   (f_divsrchaddrsuspidcount_i > 1.5) => -0.0684802992,
   (f_divsrchaddrsuspidcount_i = NULL) => -0.0041481833, -0.0041481833),
(r_I60_inq_comm_recency_d = NULL) => -0.0144575773, -0.0038326603);

// Tree: 310 
woFDN_FLA_SD_lgt_310 := map(
(NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 2) => 0.1132635494,
(r_I60_inq_retail_recency_d > 2) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 178.5) => 
      map(
      (NULL < c_finance and c_finance <= 2.35) => 0.0162586053,
      (c_finance > 2.35) => -0.0061345646,
      (c_finance = NULL) => 0.0045742463, 0.0045742463),
   (c_for_sale > 178.5) => 
      map(
      (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 3.5) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 52.85) => -0.0284410582,
         (c_hh2_p > 52.85) => 0.1632323127,
         (c_hh2_p = NULL) => -0.0173865822, -0.0173865822),
      (f_hh_tot_derog_i > 3.5) => -0.1043298008,
      (f_hh_tot_derog_i = NULL) => -0.0268533961, -0.0268533961),
   (c_for_sale = NULL) => -0.0032039858, 0.0015147282),
(r_I60_inq_retail_recency_d = NULL) => 0.0344446398, 0.0022982578);

// Tree: 311 
woFDN_FLA_SD_lgt_311 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 1.5) => -0.0195479303,
(f_phones_per_addr_curr_i > 1.5) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => 
      map(
      (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 0.0056441403,
      (r_D32_felony_count_i > 0.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 236.5) => 0.1279220638,
         (r_C10_M_Hdr_FS_d > 236.5) => -0.0332436296,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0461541752, 0.0461541752),
      (r_D32_felony_count_i = NULL) => 0.0061976784, 0.0061976784),
   (f_inq_QuizProvider_count_i > 6.5) => 0.0978777798,
   (f_inq_QuizProvider_count_i = NULL) => 0.0069649524, 0.0069649524),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 22.2) => 0.0484632013,
   (C_RENTOCC_P > 22.2) => -0.0406425153,
   (C_RENTOCC_P = NULL) => 0.0017887783, 0.0017887783), 0.0016103536);

// Tree: 312 
woFDN_FLA_SD_lgt_312 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.1) => 
   map(
   (NULL < c_totsales and c_totsales <= 1229.5) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.92485121655) => -0.0355377967,
      (f_add_curr_nhood_SFD_pct_d > 0.92485121655) => 
         map(
         (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => -0.0053799449,
         (r_D34_UnRel_Lien60_Count_i > 0.5) => 0.1349265762,
         (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0010772195, 0.0010772195),
      (f_add_curr_nhood_SFD_pct_d = NULL) => -0.0204054786, -0.0204054786),
   (c_totsales > 1229.5) => 0.0063827997,
   (c_totsales = NULL) => -0.0004519258, -0.0004519258),
(c_famotf18_p > 54.1) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 170.5) => 0.1225130294,
   (f_prevaddrmurderindex_i > 170.5) => -0.0261966479,
   (f_prevaddrmurderindex_i = NULL) => 0.0593114166, 0.0593114166),
(c_famotf18_p = NULL) => -0.0102823477, -0.0001119565);

// Tree: 313 
woFDN_FLA_SD_lgt_313 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 15250) => 0.1091881341,
(r_L80_Inp_AVM_AutoVal_d > 15250) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 42.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -49677) => 0.1086312048,
      (f_addrchangevaluediff_d > -49677) => -0.0035222086,
      (f_addrchangevaluediff_d = NULL) => -0.0022094715, -0.0022094715),
   (f_addrchangecrimediff_i > 42.5) => -0.0848467880,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 128500) => -0.0120577627,
      (k_estimated_income_d > 128500) => 0.1616288487,
      (k_estimated_income_d = NULL) => -0.0049739370, -0.0039838087), -0.0032421263),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.75) => -0.0185445805,
   (c_pop_45_54_p > 13.75) => 0.0159552549,
   (c_pop_45_54_p = NULL) => -0.0178720290, -0.0017617628), -0.0021471901);

// Tree: 314 
woFDN_FLA_SD_lgt_314 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -111) => 0.0889934409,
(f_addrchangecrimediff_i > -111) => -0.0011728623,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 11.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.0168541323,
         (f_util_adl_count_n > 2.5) => 0.1563801551,
         (f_util_adl_count_n = NULL) => 0.0662515441, 0.0662515441),
      (c_born_usa > 11.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1404023083) => -0.0185987205,
         (f_add_curr_nhood_VAC_pct_i > 0.1404023083) => 0.0567630009,
         (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0092583021, -0.0092583021),
      (c_born_usa = NULL) => -0.0132946560, -0.0051010728),
   (f_srchunvrfdaddrcount_i > 0.5) => -0.0680907721,
   (f_srchunvrfdaddrcount_i = NULL) => 0.0265221130, -0.0059741486), -0.0018966471);

// Tree: 315 
woFDN_FLA_SD_lgt_315 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 185.5) => -0.0776508766,
(f_mos_liens_unrel_FT_lseen_d > 185.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0450812247,
   (f_mos_inq_banko_om_fseen_d > 5.5) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => 0.0000631616,
      (f_inq_Collection_count24_i > 2.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 65.5) => -0.0301975384,
         (r_pb_order_freq_d > 65.5) => 0.0807887676,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0580606772) => 0.0152671917,
            (f_add_input_nhood_BUS_pct_i > 0.0580606772) => 0.1591113459,
            (f_add_input_nhood_BUS_pct_i = NULL) => 0.0781234608, 0.0781234608), 0.0370164591),
      (f_inq_Collection_count24_i = NULL) => 0.0011008276, 0.0011008276),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0008280614, -0.0008280614),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0175212786, -0.0017677651);

// Tree: 316 
woFDN_FLA_SD_lgt_316 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 0.0022718447,
(r_I60_Inq_Count12_i > 1.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.70903850085) => 
      map(
      (NULL < c_food and c_food <= 38.75) => -0.0210202067,
      (c_food > 38.75) => -0.0763554782,
      (c_food = NULL) => -0.0286441775, -0.0286441775),
   (f_add_input_nhood_MFD_pct_i > 0.70903850085) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 278884) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 49854.5) => -0.0007607323,
         (f_curraddrmedianincome_d > 49854.5) => 0.2202234667,
         (f_curraddrmedianincome_d = NULL) => 0.0838715141, 0.0838715141),
      (f_curraddrmedianvalue_d > 278884) => -0.0233971881,
      (f_curraddrmedianvalue_d = NULL) => 0.0271877183, 0.0271877183),
   (f_add_input_nhood_MFD_pct_i = NULL) => -0.0354293868, -0.0228007717),
(r_I60_Inq_Count12_i = NULL) => -0.0076960592, -0.0024254944);

// Tree: 317 
woFDN_FLA_SD_lgt_317 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 37500) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -48) => -0.0802663213,
   (f_addrchangecrimediff_i > -48) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 9077) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 174.5) => 
            map(
            (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 16) => 0.0710134592,
            (r_F01_inp_addr_address_score_d > 16) => 0.0092546141,
            (r_F01_inp_addr_address_score_d = NULL) => 0.0121107086, 0.0121107086),
         (c_exp_prod > 174.5) => 0.1675995262,
         (c_exp_prod = NULL) => 0.0190608325, 0.0190608325),
      (f_addrchangeincomediff_d > 9077) => 0.1091269524,
      (f_addrchangeincomediff_d = NULL) => 0.0214753517, 0.0214753517),
   (f_addrchangecrimediff_i = NULL) => 0.0061182302, 0.0150756514),
(k_estimated_income_d > 37500) => -0.0101676896,
(k_estimated_income_d = NULL) => 0.0107859207, -0.0042322162);

// Tree: 318 
woFDN_FLA_SD_lgt_318 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 4.55) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 110.5) => -0.0079926740,
   (c_for_sale > 110.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1495) => 0.0324401671,
      (c_med_rent > 1495) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.945) => 0.0601160515,
         (c_hhsize > 2.945) => 0.3643703832,
         (c_hhsize = NULL) => 0.1485981786, 0.1485981786),
      (c_med_rent = NULL) => 0.0474579575, 0.0474579575),
   (c_for_sale = NULL) => 0.0176519744, 0.0176519744),
(c_famotf18_p > 4.55) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 89.15) => -0.0093728599,
   (r_C12_source_profile_d > 89.15) => 0.1431121526,
   (r_C12_source_profile_d = NULL) => -0.0018636699, -0.0080076322),
(c_famotf18_p = NULL) => -0.0240074097, -0.0017400520);

// Tree: 319 
woFDN_FLA_SD_lgt_319 := map(
(NULL < c_span_lang and c_span_lang <= 181.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27836.5) => 
      map(
      (NULL < c_construction and c_construction <= 11.55) => 
         map(
         (NULL < c_unattach and c_unattach <= 84.5) => -0.1175011329,
         (c_unattach > 84.5) => 0.0293118941,
         (c_unattach = NULL) => 0.0059069188, 0.0059069188),
      (c_construction > 11.55) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 39.5) => 0.1703836036,
         (k_comb_age_d > 39.5) => -0.0118068557,
         (k_comb_age_d = NULL) => 0.0907506876, 0.0907506876),
      (c_construction = NULL) => 0.0261141886, 0.0261141886),
   (f_curraddrmedianincome_d > 27836.5) => -0.0049518132,
   (f_curraddrmedianincome_d = NULL) => 0.0135539906, -0.0030720216),
(c_span_lang > 181.5) => -0.0291451719,
(c_span_lang = NULL) => 0.0279880727, -0.0045492193);

// Tree: 320 
woFDN_FLA_SD_lgt_320 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => 0.0012041361,
(f_srchfraudsrchcount_i > 4.5) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 71.95) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 10.35) => 
            map(
            (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 42.5) => -0.0802849365,
            (f_mos_inq_banko_cm_lseen_d > 42.5) => -0.0387664527,
            (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0527484127, -0.0527484127),
         (c_incollege > 10.35) => 0.0253777376,
         (c_incollege = NULL) => -0.0406170229, -0.0406170229),
      (f_srchssnsrchcount_i > 22.5) => 0.0504495962,
      (f_srchssnsrchcount_i = NULL) => -0.0333316933, -0.0333316933),
   (c_lowrent > 71.95) => 0.0907616044,
   (c_lowrent = NULL) => -0.0258674348, -0.0258674348),
(f_srchfraudsrchcount_i = NULL) => 0.0233425930, -0.0006113351);

// Tree: 321 
woFDN_FLA_SD_lgt_321 := map(
(NULL < C_INC_15K_P and C_INC_15K_P <= 27.85) => -0.0048374522,
(C_INC_15K_P > 27.85) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 20.4) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 48.5) => 0.1097301237,
      (c_serv_empl > 48.5) => 
         map(
         (NULL < c_health and c_health <= 32.6) => -0.0146966586,
         (c_health > 32.6) => 0.1166369453,
         (c_health = NULL) => 0.0003206973, 0.0003206973),
      (c_serv_empl = NULL) => 0.0162559957, 0.0162559957),
   (c_hh4_p > 20.4) => 0.1373235572,
   (c_hh4_p = NULL) => 0.0304880758, 0.0304880758),
(C_INC_15K_P = NULL) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => -0.0549531143,
   (f_rel_criminal_count_i > 0.5) => 0.0856864051,
   (f_rel_criminal_count_i = NULL) => -0.0117159647, -0.0117159647), -0.0032234094);

// Tree: 322 
woFDN_FLA_SD_lgt_322 := map(
(NULL < c_asian_lang and c_asian_lang <= 196.5) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 33.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 23.15) => -0.0011221892,
         (c_hh3_p > 23.15) => 0.0352214391,
         (c_hh3_p = NULL) => 0.0042041464, 0.0042041464),
      (f_rel_ageover30_count_d > 33.5) => 
         map(
         (NULL < c_rape and c_rape <= 94) => 0.1890517230,
         (c_rape > 94) => -0.0145654069,
         (c_rape = NULL) => 0.1017872387, 0.1017872387),
      (f_rel_ageover30_count_d = NULL) => 0.0064296790, 0.0052706975),
   (f_inq_Auto_count24_i > 1.5) => -0.0501571054,
   (f_inq_Auto_count24_i = NULL) => 0.0046717487, 0.0023118318),
(c_asian_lang > 196.5) => -0.0685487976,
(c_asian_lang = NULL) => 0.0263079583, 0.0007528098);

// Tree: 323 
woFDN_FLA_SD_lgt_323 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 1.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 109.5) => -0.0073004605,
      (c_many_cars > 109.5) => 
         map(
         (NULL < c_murders and c_murders <= 139) => 0.0143032607,
         (c_murders > 139) => 0.0906610478,
         (c_murders = NULL) => 0.0274227766, 0.0274227766),
      (c_many_cars = NULL) => 0.0259385663, 0.0081659740),
   (k_inq_per_ssn_i > 3.5) => 
      map(
      (NULL < c_highinc and c_highinc <= 33.45) => 0.0231347674,
      (c_highinc > 33.45) => 0.2035199274,
      (c_highinc = NULL) => 0.0393337392, 0.0393337392),
   (k_inq_per_ssn_i = NULL) => 0.0104741839, 0.0104741839),
(f_rel_incomeover100_count_d > 1.5) => -0.0158439070,
(f_rel_incomeover100_count_d = NULL) => -0.0023352794, 0.0031422379);

// Tree: 324 
woFDN_FLA_SD_lgt_324 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 5.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 0.35) => 0.0563873867,
      (c_pop_75_84_p > 0.35) => -0.0523324357,
      (c_pop_75_84_p = NULL) => -0.0384860432, -0.0384860432),
   (C_INC_150K_P > 0.55) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0073959258,
      (r_D33_eviction_count_i > 2.5) => 0.0772690474,
      (r_D33_eviction_count_i = NULL) => 0.0079214780, 0.0079214780),
   (C_INC_150K_P = NULL) => 0.0216060479, 0.0057578236),
(f_srchssnsrchcount_i > 5.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => 0.0510078423,
   (k_comb_age_d > 27.5) => -0.0424116836,
   (k_comb_age_d = NULL) => -0.0293764009, -0.0293764009),
(f_srchssnsrchcount_i = NULL) => -0.0181607456, 0.0037827797);

// Tree: 325 
woFDN_FLA_SD_lgt_325 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 86.55) => -0.0378193462,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 86.55) => 0.0128552657,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 4.55) => -0.0191817042,
   (c_hval_125k_p > 4.55) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 176.5) => 0.0030011385,
      (c_sub_bus > 176.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 35) => 
            map(
            (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.25) => 0.1990785027,
            (c_pop_55_64_p > 9.25) => 0.0199799343,
            (c_pop_55_64_p = NULL) => 0.1203368907, 0.1203368907),
         (f_prevaddrlenofres_d > 35) => -0.0031581292,
         (f_prevaddrlenofres_d = NULL) => 0.0674104536, 0.0674104536),
      (c_sub_bus = NULL) => 0.0071343566, 0.0071343566),
   (c_hval_125k_p = NULL) => -0.0412225607, -0.0078547199), -0.0013561021);

// Tree: 326 
woFDN_FLA_SD_lgt_326 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 4.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.85) => -0.0027489232,
   (r_C12_source_profile_d > 78.85) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 19.45) => 0.1564441802,
      (C_OWNOCC_P > 19.45) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 4.5) => 0.0116596907,
         (f_srchaddrsrchcount_i > 4.5) => 0.1006009828,
         (f_srchaddrsrchcount_i = NULL) => 0.0224101021, 0.0224101021),
      (C_OWNOCC_P = NULL) => 0.0274460646, 0.0274460646),
   (r_C12_source_profile_d = NULL) => 0.0006458517, 0.0006458517),
(f_dl_addrs_per_adl_i > 4.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 1.5) => 0.0151927591,
   (k_inq_per_addr_i > 1.5) => 0.1710398222,
   (k_inq_per_addr_i = NULL) => 0.0619468781, 0.0619468781),
(f_dl_addrs_per_adl_i = NULL) => -0.0222839676, 0.0013241034);

// Tree: 327 
woFDN_FLA_SD_lgt_327 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 5.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 18.55) => -0.0727067134,
   (c_fammar_p > 18.55) => 
      map(
      (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 1.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 4.5) => 0.0917819354,
         (f_mos_inq_banko_cm_fseen_d > 4.5) => 0.0012097847,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0020876928, 0.0020876928),
      (r_I61_inq_collection_count12_i > 1.5) => -0.0369553382,
      (r_I61_inq_collection_count12_i = NULL) => 0.0007581141, 0.0007581141),
   (c_fammar_p = NULL) => -0.0024390182, 0.0001374524),
(f_divrisktype_i > 5.5) => -0.0684990966,
(f_divrisktype_i = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.05) => 0.0799303124,
   (c_bigapt_p > 1.05) => -0.0321767325,
   (c_bigapt_p = NULL) => 0.0238767900, 0.0238767900), -0.0004162812);

// Tree: 328 
woFDN_FLA_SD_lgt_328 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 242.5) => -0.0007359250,
   (r_C21_M_Bureau_ADL_FS_d > 242.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => 0.0316381770,
      (f_srchaddrsrchcount_i > 1.5) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 3.5) => -0.0621942570,
         (f_rel_educationover12_count_d > 3.5) => 
            map(
            (NULL < c_hval_100k_p and c_hval_100k_p <= 2.2) => 0.2245529526,
            (c_hval_100k_p > 2.2) => 0.0568403278,
            (c_hval_100k_p = NULL) => 0.1477237055, 0.1477237055),
         (f_rel_educationover12_count_d = NULL) => 0.1013781813, 0.1013781813),
      (f_srchaddrsrchcount_i = NULL) => 0.0539214136, 0.0539214136),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0173542030, 0.0173542030),
(f_corraddrnamecount_d > 3.5) => -0.0019676275,
(f_corraddrnamecount_d = NULL) => 0.0257591319, 0.0017305489);

// Tree: 329 
woFDN_FLA_SD_lgt_329 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 42.5) => 0.1112721290,
(f_mos_liens_unrel_FT_fseen_d > 42.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 183.5) => 0.0019313528,
   (c_bel_edu > 183.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 6.5) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 53081.5) => 
            map(
            (NULL < C_INC_35K_P and C_INC_35K_P <= 11.35) => -0.0488425969,
            (C_INC_35K_P > 11.35) => 0.0676763668,
            (C_INC_35K_P = NULL) => 0.0321459205, 0.0321459205),
         (f_prevaddrmedianincome_d > 53081.5) => 0.1417856002,
         (f_prevaddrmedianincome_d = NULL) => 0.0520621192, 0.0520621192),
      (r_L79_adls_per_addr_curr_i > 6.5) => -0.0495320016,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0365781008, 0.0365781008),
   (c_bel_edu = NULL) => -0.0067491666, 0.0035150883),
(f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0151537695, 0.0037720534);

// Tree: 330 
woFDN_FLA_SD_lgt_330 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 897809.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 0.5) => -0.0003677801,
   (r_I60_inq_comm_count12_i > 0.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.1917873727) => 0.1018264783,
      (f_add_curr_mobility_index_i > 0.1917873727) => 
         map(
         (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 3.5) => -0.0793597417,
         (f_crim_rel_under500miles_cnt_i > 3.5) => 
            map(
            (NULL < c_no_teens and c_no_teens <= 96.5) => -0.0805512831,
            (c_no_teens > 96.5) => 0.0919006612,
            (c_no_teens = NULL) => 0.0065118344, 0.0065118344),
         (f_crim_rel_under500miles_cnt_i = NULL) => -0.0551274887, -0.0551274887),
      (f_add_curr_mobility_index_i = NULL) => -0.0360583151, -0.0360583151),
   (r_I60_inq_comm_count12_i = NULL) => -0.0015951417, -0.0015951417),
(f_curraddrmedianvalue_d > 897809.5) => 0.1054147588,
(f_curraddrmedianvalue_d = NULL) => -0.0138834453, -0.0010651313);

// Tree: 331 
woFDN_FLA_SD_lgt_331 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 161.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 0.0837269850,
   (f_mos_liens_unrel_SC_fseen_d > 87.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 
         map(
         (NULL < c_work_home and c_work_home <= 65.5) => -0.0853677851,
         (c_work_home > 65.5) => 
            map(
            (NULL < c_med_hhinc and c_med_hhinc <= 40342) => 0.0511581060,
            (c_med_hhinc > 40342) => -0.0494307278,
            (c_med_hhinc = NULL) => -0.0276732684, -0.0276732684),
         (c_work_home = NULL) => -0.0462923057, -0.0462923057),
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0131406543,
      (nf_seg_FraudPoint_3_0 = '') => -0.0166391401, -0.0166391401),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0154047016, -0.0154047016),
(r_C21_M_Bureau_ADL_FS_d > 161.5) => 0.0051577407,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0010532724, -0.0026554284);

// Tree: 332 
woFDN_FLA_SD_lgt_332 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 105.5) => -0.0112260093,
(r_C13_Curr_Addr_LRes_d > 105.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 27.25) => -0.0017476683,
   (c_newhouse > 27.25) => 
      map(
      (NULL < c_food and c_food <= 15.1) => -0.0099311761,
      (c_food > 15.1) => 
         map(
         (NULL < c_rich_asian and c_rich_asian <= 175.5) => 0.0547594924,
         (c_rich_asian > 175.5) => 
            map(
            (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.1283647860,
            (k_inq_per_ssn_i > 0.5) => 0.3928001118,
            (k_inq_per_ssn_i = NULL) => 0.2534078470, 0.2534078470),
         (c_rich_asian = NULL) => 0.1044215811, 0.1044215811),
      (c_food = NULL) => 0.0466964848, 0.0466964848),
   (c_newhouse = NULL) => 0.0051019169, 0.0097044937),
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0300022355, -0.0039925185);

// Tree: 333 
woFDN_FLA_SD_lgt_333 := map(
(NULL < c_exp_prod and c_exp_prod <= 37.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08761168605) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.97349733205) => -0.0069950915,
      (f_add_input_nhood_SFD_pct_d > 0.97349733205) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.00512262865) => 0.0026588977,
         (f_add_input_nhood_VAC_pct_i > 0.00512262865) => 0.2851849960,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.1506487587, 0.1506487587),
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.0113153114, 0.0113153114),
   (f_add_curr_nhood_VAC_pct_i > 0.08761168605) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 0.1473284449,
      (r_Prop_Owner_History_d > 0.5) => 0.0268519602,
      (r_Prop_Owner_History_d = NULL) => 0.0671975736, 0.0671975736),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0220522966, 0.0220522966),
(c_exp_prod > 37.5) => -0.0048924923,
(c_exp_prod = NULL) => -0.0011322005, -0.0023954221);

// Tree: 334 
woFDN_FLA_SD_lgt_334 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 3749.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 10.95) => -0.0000126822,
   (c_hh6_p > 10.95) => 
      map(
      (NULL < c_hval_1000k_p and c_hval_1000k_p <= 1.65) => 
         map(
         (NULL < C_INC_15K_P and C_INC_15K_P <= 18.6) => 
            map(
            (NULL < c_pop_55_64_p and c_pop_55_64_p <= 5.75) => 0.1133934663,
            (c_pop_55_64_p > 5.75) => -0.0664876464,
            (c_pop_55_64_p = NULL) => -0.0180932353, -0.0180932353),
         (C_INC_15K_P > 18.6) => 0.1068301053,
         (C_INC_15K_P = NULL) => 0.0103207010, 0.0103207010),
      (c_hval_1000k_p > 1.65) => 0.1567409903,
      (c_hval_1000k_p = NULL) => 0.0411460250, 0.0411460250),
   (c_hh6_p = NULL) => -0.0039787967, 0.0009674263),
(f_liens_unrel_ST_total_amt_i > 3749.5) => 0.1022717036,
(f_liens_unrel_ST_total_amt_i = NULL) => 0.0213156024, 0.0016342076);

// Tree: 335 
woFDN_FLA_SD_lgt_335 := map(
(NULL < c_hh6_p and c_hh6_p <= 14.55) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0048846338,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < c_construction and c_construction <= 19.35) => 
         map(
         (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.99892354255) => 0.0041600682,
         (f_add_input_nhood_SFD_pct_d > 0.99892354255) => 0.1691490623,
         (f_add_input_nhood_SFD_pct_d = NULL) => 0.0076659966, 0.0076659966),
      (c_construction > 19.35) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 129.5) => 0.0402011821,
         (c_no_labfor > 129.5) => 0.2048055544,
         (c_no_labfor = NULL) => 0.0695043780, 0.0695043780),
      (c_construction = NULL) => 0.0176861047, 0.0176861047),
   (f_inq_Other_count_i = NULL) => -0.0050484217, 0.0002915580),
(c_hh6_p > 14.55) => -0.0710089268,
(c_hh6_p = NULL) => -0.0012203829, -0.0005481002);

// Tree: 336 
woFDN_FLA_SD_lgt_336 := map(
(NULL < c_rape and c_rape <= 184.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 1.5) => 0.0011709413,
   (f_srchfraudsrchcountmo_i > 1.5) => 0.0556340102,
   (f_srchfraudsrchcountmo_i = NULL) => -0.0174887408, 0.0014236254),
(c_rape > 184.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 5.35) => -0.0302973199,
      (c_hval_150k_p > 5.35) => 
         map(
         (NULL < c_hval_60k_p and c_hval_60k_p <= 11.6) => 0.0393012744,
         (c_hval_60k_p > 11.6) => 0.2311009370,
         (c_hval_60k_p = NULL) => 0.0858811925, 0.0858811925),
      (c_hval_150k_p = NULL) => 0.0300925009, 0.0300925009),
   (f_inq_Communications_count_i > 0.5) => 0.1034809328,
   (f_inq_Communications_count_i = NULL) => 0.0390267448, 0.0390267448),
(c_rape = NULL) => 0.0084342439, 0.0029559039);

// Tree: 337 
woFDN_FLA_SD_lgt_337 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 123358) => 0.1433798686,
      (r_L80_Inp_AVM_AutoVal_d > 123358) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 122.5) => -0.0435930985,
         (c_exp_prod > 122.5) => 0.1193460120,
         (c_exp_prod = NULL) => 0.0138235405, 0.0138235405),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0043535093, 0.0228017760),
   (f_assocrisktype_i > 3.5) => 0.1444852445,
   (f_assocrisktype_i = NULL) => 0.0321492029, 0.0321492029),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => 0.0003726174,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 96.5) => -0.0449499718,
   (c_burglary > 96.5) => 0.0390646947,
   (c_burglary = NULL) => -0.0040779719, -0.0040779719), 0.0021570487);

// Tree: 338 
woFDN_FLA_SD_lgt_338 := map(
(NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1806294705) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 6.5) => 0.0003521509,
      (f_rel_homeover150_count_d > 6.5) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 46.5) => 0.1252487794,
         (c_ab_av_edu > 46.5) => 0.0244048424,
         (c_ab_av_edu = NULL) => 0.0348581773, 0.0348581773),
      (f_rel_homeover150_count_d = NULL) => 0.0092044692, 0.0098686699),
   (f_add_curr_nhood_VAC_pct_i > 0.1806294705) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.1680542767,
      (r_C18_invalid_addrs_per_adl_i > 0.5) => 0.0030608340,
      (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0706020094, 0.0706020094),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0136812253, 0.0136812253),
(r_Ever_Asset_Owner_d > 0.5) => -0.0059277254,
(r_Ever_Asset_Owner_d = NULL) => 0.0194259599, -0.0014930077);

// Tree: 339 
woFDN_FLA_SD_lgt_339 := map(
(NULL < r_D31_bk_chapter_n and r_D31_bk_chapter_n <= 12) => -0.0322494005,
(r_D31_bk_chapter_n > 12) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 65) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 12.5) => -0.0048928098,
      (f_rel_count_i > 12.5) => 0.2056393339,
      (f_rel_count_i = NULL) => 0.0916815680, 0.0916815680),
   (f_curraddrburglaryindex_i > 65) => -0.0407058795,
   (f_curraddrburglaryindex_i = NULL) => 0.0095736738, 0.0095736738),
(r_D31_bk_chapter_n = NULL) => 
   map(
   (NULL < c_young and c_young <= 10.85) => -0.0387253486,
   (c_young > 10.85) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 0.0088469787,
      (f_srchaddrsrchcount_i > 14.5) => 0.0397177900,
      (f_srchaddrsrchcount_i = NULL) => -0.0016179791, 0.0096890765),
   (c_young = NULL) => -0.0066680153, 0.0055952768), 0.0025884991);

// Tree: 340 
woFDN_FLA_SD_lgt_340 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.90284633155) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => -0.0062068367,
      (k_inq_per_ssn_i > 10.5) => 0.0588271480,
      (k_inq_per_ssn_i = NULL) => -0.0055810510, -0.0055810510),
   (f_add_curr_mobility_index_i > 0.90284633155) => 0.1108388036,
   (f_add_curr_mobility_index_i = NULL) => 0.0619548037, -0.0043756635),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_totsales and c_totsales <= 6619) => 0.1015864588,
   (c_totsales > 6619) => -0.0055852433,
   (c_totsales = NULL) => 0.0537419489, 0.0537419489),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < c_retired and c_retired <= 10.45) => -0.0554602371,
   (c_retired > 10.45) => 0.0541141856,
   (c_retired = NULL) => 0.0002555711, 0.0002555711), -0.0038130359);

// Tree: 341 
woFDN_FLA_SD_lgt_341 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 14.45) => 0.0067867205,
   (C_INC_25K_P > 14.45) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 201348) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 10.5) => -0.0162146347,
         (f_srchaddrsrchcount_i > 10.5) => -0.0925898252,
         (f_srchaddrsrchcount_i = NULL) => -0.0244375110, -0.0244375110),
      (r_L80_Inp_AVM_AutoVal_d > 201348) => 
         map(
         (NULL < c_pop_12_17_p and c_pop_12_17_p <= 7.85) => -0.0242855911,
         (c_pop_12_17_p > 7.85) => 0.1581057245,
         (c_pop_12_17_p = NULL) => 0.0600129161, 0.0600129161),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0244137261, -0.0186373200),
   (C_INC_25K_P = NULL) => 0.0229023132, 0.0036622116),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0810521799,
(r_S65_SSN_Prior_DoB_i = NULL) => 0.0039794586, 0.0039794586);

// Tree: 342 
woFDN_FLA_SD_lgt_342 := map(
(NULL < c_pop_85p_p and c_pop_85p_p <= 9.55) => 
   map(
   (NULL < c_mort_indx and c_mort_indx <= 169.5) => -0.0023306686,
   (c_mort_indx > 169.5) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 0.15) => -0.0843633219,
      (c_hval_300k_p > 0.15) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 6.35) => 
            map(
            (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.55323366285) => -0.0231236567,
            (f_add_input_nhood_MFD_pct_i > 0.55323366285) => 0.1154877683,
            (f_add_input_nhood_MFD_pct_i = NULL) => 0.0178856407, 0.0178856407),
         (c_pop_6_11_p > 6.35) => 0.3055242033,
         (c_pop_6_11_p = NULL) => 0.1039672543, 0.1039672543),
      (c_hval_300k_p = NULL) => 0.0574020019, 0.0574020019),
   (c_mort_indx = NULL) => -0.0005471650, -0.0005471650),
(c_pop_85p_p > 9.55) => -0.0873748707,
(c_pop_85p_p = NULL) => -0.0203141899, -0.0024482999);

// Tree: 343 
woFDN_FLA_SD_lgt_343 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.02115602875) => -0.0150009243,
(f_add_curr_nhood_MFD_pct_i > 0.02115602875) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 0.0544672247,
   (f_corrssnnamecount_d > 1.5) => 0.0037352875,
   (f_corrssnnamecount_d = NULL) => 0.0065540757, 0.0065540757),
(f_add_curr_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 32.85) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1949.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0316122585) => -0.0233744870,
         (f_add_input_nhood_VAC_pct_i > 0.0316122585) => 0.1533344226,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0641051712, 0.0641051712),
      (c_med_yearblt > 1949.5) => -0.0304882543,
      (c_med_yearblt = NULL) => -0.0263307539, -0.0263307539),
   (c_trailer_p > 32.85) => 0.1225610658,
   (c_trailer_p = NULL) => -0.0134399653, -0.0203080051), -0.0023084283);

// Tree: 344 
woFDN_FLA_SD_lgt_344 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 16) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 5.5) => 0.0535105162,
   (r_C13_Curr_Addr_LRes_d > 5.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 143.5) => -0.0680958530,
      (c_span_lang > 143.5) => 
         map(
         (NULL < c_for_sale and c_for_sale <= 112.5) => 
            map(
            (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.1031020430,
            (f_corrssnaddrcount_d > 2.5) => -0.0153779325,
            (f_corrssnaddrcount_d = NULL) => 0.0416679816, 0.0416679816),
         (c_for_sale > 112.5) => -0.0587453048,
         (c_for_sale = NULL) => -0.0007526046, -0.0007526046),
      (c_span_lang = NULL) => -0.0436904510, -0.0436904510),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0305342691, -0.0305342691),
(r_F01_inp_addr_address_score_d > 16) => -0.0020558967,
(r_F01_inp_addr_address_score_d = NULL) => -0.0097806154, -0.0035479941);

// Tree: 345 
woFDN_FLA_SD_lgt_345 := map(
(NULL < c_hh6_p and c_hh6_p <= 11.85) => -0.0018427080,
(c_hh6_p > 11.85) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => -0.0799118895,
   (r_C14_addrs_10yr_i > 0.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 126.5) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 8.05) => 0.0438439267,
         (c_rnt750_p > 8.05) => 0.1853258405,
         (c_rnt750_p = NULL) => 0.1182529332, 0.1182529332),
      (c_new_homes > 126.5) => -0.0272562143,
      (c_new_homes = NULL) => 0.0699899981, 0.0699899981),
   (r_C14_addrs_10yr_i = NULL) => 0.0356613216, 0.0356613216),
(c_hh6_p = NULL) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 61.5) => 0.1576717025,
   (r_I60_inq_recency_d > 61.5) => -0.0119149857,
   (r_I60_inq_recency_d = NULL) => 0.0301676369, 0.0301676369), -0.0003728316);

// Tree: 346 
woFDN_FLA_SD_lgt_346 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 9.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 13.5) => 0.0010406758,
      (f_inq_count_i > 13.5) => 0.0645063354,
      (f_inq_count_i = NULL) => 0.0022789794, 0.0022789794),
   (f_assocsuspicousidcount_i > 13.5) => 0.0693258654,
   (f_assocsuspicousidcount_i = NULL) => 0.0028349780, 0.0028349780),
(f_srchssnsrchcount_i > 9.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 145) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => -0.0920981290,
      (f_divrisktype_i > 1.5) => 0.0008701840,
      (f_divrisktype_i = NULL) => -0.0548139618, -0.0548139618),
   (c_exp_prod > 145) => 0.0400468657,
   (c_exp_prod = NULL) => -0.0302746744, -0.0302746744),
(f_srchssnsrchcount_i = NULL) => 0.0185300713, 0.0023110030);


//Adjustment trees FA: 6/2019

adj_FLA_SD_tree_0 :=  0.0932259318531994;

// Tree: 1
adj_FLA_SD_tree_1 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i < 8.5) => map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d < 95) => map(
      (NULL < c_child and c_child < 27.95) => 0.0111853093922521, 
      (c_child >= 27.95) => map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d < -13770) => 0.160371321236723, 
         (f_addrchangeincomediff_d >= -13770) => map(
            (NULL < c_mort_indx and c_mort_indx < 58.5) => -0.071458925666349, 
            (c_mort_indx >= 58.5) => 0.0747059932825261, 
            (c_mort_indx = NULL) => 0.0316395439493754, 0.0316395439493754), 
         (f_addrchangeincomediff_d = NULL) => 0.093754082723776, 0.0697126357315077), 
      (c_child = NULL) => 0.0388853641576289, 0.0256092187460652), 
   (r_F01_inp_addr_address_score_d >= 95) => -0.000420938659542549, 
   (r_F01_inp_addr_address_score_d = NULL) => 0.00211679280614752, 0.00211679280614752), 
(f_srchssnsrchcount_i >= 8.5) => map(
   (NULL < c_civ_emp and c_civ_emp < 51.75) => -0.157696709730835, 
   (c_civ_emp >= 51.75) => -0.0306169257356384, 
   (c_civ_emp = NULL) => -0.0468161069921689, -0.0468161069921689), 
(f_srchssnsrchcount_i = NULL) => map(
   (NULL < c_high_ed and c_high_ed < 35.55) => 0.0770477410885012, 
   (c_high_ed >= 35.55) => -0.0719714120755583, 
   (c_high_ed = NULL) => 0.0187358985460431, 0.0187358985460431), 0.00108649041191785);

// Tree: 2
adj_FLA_SD_tree_2 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 79.5) => map(
   (NULL < c_bel_edu and c_bel_edu < 99.5) => -0.0125751705470041, 
   (c_bel_edu >= 99.5) => 0.166189238086291, 
   (c_bel_edu = NULL) => 0.0881571549527096, 0.0881571549527096), 
(f_attr_arrest_recency_d >= 79.5) => map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d < -98543.5) => map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d < 0.5) => 0.195627454821654, 
      (f_rel_under25miles_cnt_d >= 0.5) => map(
         (NULL < c_totsales and c_totsales < 670) => 0.15464468276786, 
         (c_totsales >= 670) => 0.00829158826674965, 
         (c_totsales = NULL) => 0.0370099313386656, 0.0370099313386656), 
      (f_rel_under25miles_cnt_d = NULL) => 0.0638605465991087, 0.0638605465991087), 
   (f_addrchangevaluediff_d >= -98543.5) => map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i < 2.5) => -0.00647223965535345, 
      (r_D33_eviction_count_i >= 2.5) => -0.0702217664729137, 
      (r_D33_eviction_count_i = NULL) => -0.00706251305181234, -0.00706251305181234), 
   (f_addrchangevaluediff_d = NULL) => -0.00284802951394946, -0.00490552362635564), 
(f_attr_arrest_recency_d = NULL) => map(
   (NULL < c_preschl and c_preschl < 130.5) => -0.0224303101341096, 
   (c_preschl >= 130.5) => 0.115020859053093, 
   (c_preschl = NULL) => 0.0203136510155692, 0.0203136510155692), -0.00405770531325792);

// Tree: 3
adj_FLA_SD_tree_3 := map(
(NULL < f_divrisktype_i and f_divrisktype_i < 4.5) => map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i < 5.5) => map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d < 7.5) => 0.0116039517787692, 
      (f_corraddrnamecount_d >= 7.5) => -0.0161887401295856, 
      (f_corraddrnamecount_d = NULL) => -0.000644340542661469, -0.000644340542661469), 
   (f_srchfraudsrchcountyr_i >= 5.5) => map(
      (NULL < c_rnt750_p and c_rnt750_p < 11.55) => 0.0399022242993047, 
      (c_rnt750_p >= 11.55) => map(
         (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d < 9) => -0.197173761622074, 
         (r_I60_inq_hiRiskCred_recency_d >= 9) => -0.0537377450935252, 
         (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.120422910672587, -0.120422910672587), 
      (c_rnt750_p = NULL) => -0.06698119901529, -0.06698119901529), 
   (f_srchfraudsrchcountyr_i = NULL) => -0.00126554571860665, -0.00126554571860665), 
(f_divrisktype_i >= 4.5) => map(
   (NULL < c_unemp and c_unemp < 4.35) => -0.00762095653338757, 
   (c_unemp >= 4.35) => map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i < 3.5) => 0.199735534914261, 
      (r_C14_addrs_15yr_i >= 3.5) => 0.0316091947654321, 
      (r_C14_addrs_15yr_i = NULL) => 0.127512247948919, 0.127512247948919), 
   (c_unemp = NULL) => 0.0592393746041998, 0.0592393746041998), 
(f_divrisktype_i = NULL) => 0.0223541139922357, -0.000153582545889911);

// Tree: 4
adj_FLA_SD_tree_4 := map(
(NULL < f_divrisktype_i and f_divrisktype_i < 5.5) => map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 79.5) => map(
      (NULL < c_no_car and c_no_car < 93.5) => -0.0276451618641129, 
      (c_no_car >= 93.5) => 0.142240488109022, 
      (c_no_car = NULL) => 0.0528269881231617, 0.0528269881231617), 
   (f_attr_arrest_recency_d >= 79.5) => map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i < 3.5) => 0.00205869087924844, 
      (f_srchfraudsrchcountyr_i >= 3.5) => -0.0363845302738217, 
      (f_srchfraudsrchcountyr_i = NULL) => 0.001175701058188, 0.001175701058188), 
   (f_attr_arrest_recency_d = NULL) => 0.0015434537979975, 0.0015434537979975), 
(f_divrisktype_i >= 5.5) => map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i < 11.5) => map(
      (NULL < c_sub_bus and c_sub_bus < 149.5) => 0.2555292509968, 
      (c_sub_bus >= 149.5) => 0.072383152649612, 
      (c_sub_bus = NULL) => 0.169043593443961, 0.169043593443961), 
   (f_addrs_per_ssn_i >= 11.5) => -0.0546102920659377, 
   (f_addrs_per_ssn_i = NULL) => 0.0851733863777491, 0.0851733863777491), 
(f_divrisktype_i = NULL) => map(
   (NULL < c_rnt750_p and c_rnt750_p < 12.9) => -0.0665702250377022, 
   (c_rnt750_p >= 12.9) => 0.0617945349453511, 
   (c_rnt750_p = NULL) => 0.00379840844698361, 0.00379840844698361), 0.00233729756627484);

// Tree: 5
adj_FLA_SD_tree_5 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i < 6.5) => -0.017174792455676, 
(f_corrrisktype_i >= 6.5) => map(
   (NULL < c_unemp and c_unemp < 10.05) => map(
      (NULL < c_wholesale and c_wholesale < 4.25) => map(
         (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i < 4.5) => map(
            (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i < 2129.5) => map(
               (NULL < C_INC_201K_P and C_INC_201K_P < 5.55) => 0.0323477632818283, 
               (C_INC_201K_P >= 5.55) => -0.0111623959535408, 
               (C_INC_201K_P = NULL) => 0.0167578688845506, 0.0167578688845506), 
            (f_liens_unrel_SC_total_amt_i >= 2129.5) => -0.12151337526816, 
            (f_liens_unrel_SC_total_amt_i = NULL) => 0.0148521874807287, 0.0148521874807287), 
         (f_divaddrsuspidcountnew_i >= 4.5) => 0.144028725040964, 
         (f_divaddrsuspidcountnew_i = NULL) => 0.0167218100461742, 0.0167218100461742), 
      (c_wholesale >= 4.25) => -0.0351007119584927, 
      (c_wholesale = NULL) => 0.00523463402468907, 0.00523463402468907), 
   (c_unemp >= 10.05) => map(
      (NULL < c_retail and c_retail < 5.9) => 0.139890727252464, 
      (c_retail >= 5.9) => -0.00178398728280457, 
      (c_retail = NULL) => 0.07884389903808, 0.07884389903808), 
   (c_unemp = NULL) => 0.0129030349598868, 0.0085034712498624), 
(f_corrrisktype_i = NULL) => -0.0125410755037826, -0.00854052892412233);

// Tree: 6
adj_FLA_SD_tree_6 := map(
(NULL < c_totcrime and c_totcrime < 198.5) => map(
   (NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i < 30) => map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i < 4.5) => map(
         (NULL < c_many_cars and c_many_cars < 22.5) => map(
            (NULL < c_lowinc and c_lowinc < 70.5) => 0.0250143223056155, 
            (c_lowinc >= 70.5) => map(
               (NULL < c_pop_85p_p and c_pop_85p_p < 0.55) => 0.271058922163904, 
               (c_pop_85p_p >= 0.55) => 0.0198650873134291, 
               (c_pop_85p_p = NULL) => 0.144218470902773, 0.144218470902773), 
            (c_lowinc = NULL) => 0.0325864097322274, 0.0325864097322274), 
         (c_many_cars >= 22.5) => map(
            (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i < 33.5) => -0.00138076715604351, 
            (f_srchaddrsrchcount_i >= 33.5) => -0.0852277889182806, 
            (f_srchaddrsrchcount_i = NULL) => -0.00181967755877002, -0.00181967755877002), 
         (c_many_cars = NULL) => 0.00118447833319516, 0.00118447833319516), 
      (f_inq_Communications_count_i >= 4.5) => -0.085075015461374, 
      (f_inq_Communications_count_i = NULL) => 0.000732117828208889, 0.000732117828208889), 
   (r_C12_NonDerog_Recency_i >= 30) => 0.140413343045044, 
   (r_C12_NonDerog_Recency_i = NULL) => -0.0216677553660399, 0.000916966946380976), 
(c_totcrime >= 198.5) => 0.19639522762181, 
(c_totcrime = NULL) => -0.00916163367741516, 0.00125075265686466);

// Tree: 7
adj_FLA_SD_tree_7 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 79.5) => map(
   (NULL < C_INC_75K_P and C_INC_75K_P < 18.2) => 0.00916663762894704, 
   (C_INC_75K_P >= 18.2) => 0.15955156214255, 
   (C_INC_75K_P = NULL) => 0.0810898623963222, 0.0810898623963222), 
(f_attr_arrest_recency_d >= 79.5) => map(
   (NULL < c_hh7p_p and c_hh7p_p < 12.05) => map(
      (NULL < r_C20_email_count_i and r_C20_email_count_i < 0.5) => map(
         (NULL < c_unemp and c_unemp < 7.85) => 0.0112652122309832, 
         (c_unemp >= 7.85) => map(
            (NULL < c_cpiall and c_cpiall < 208.5) => 0.225814428474659, 
            (c_cpiall >= 208.5) => 0.0316517058880442, 
            (c_cpiall = NULL) => 0.0592929268118332, 0.0592929268118332), 
         (c_unemp = NULL) => 0.0162497101766714, 0.0162497101766714), 
      (r_C20_email_count_i >= 0.5) => -0.00932836849106857, 
      (r_C20_email_count_i = NULL) => -0.0014347777100434, -0.0014347777100434), 
   (c_hh7p_p >= 12.05) => -0.0663836828578824, 
   (c_hh7p_p = NULL) => -0.0212986069637122, -0.00294236041554815), 
(f_attr_arrest_recency_d = NULL) => map(
   (NULL < c_rnt750_p and c_rnt750_p < 14.95) => -0.0638824706263548, 
   (c_rnt750_p >= 14.95) => 0.075634183622097, 
   (c_rnt750_p = NULL) => 0.00633783217419048, 0.00633783217419048), -0.00225728780297404);

// Tree: 8
adj_FLA_SD_tree_8 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i < 1.5) => map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d < 21798) => map(
      (NULL < c_rnt1000_p and c_rnt1000_p < 2.05) => -0.0343967268688249, 
      (c_rnt1000_p >= 2.05) => 0.201282046903638, 
      (c_rnt1000_p = NULL) => 0.0890540593929414, 0.0890540593929414), 
   (r_A46_Curr_AVM_AutoVal_d >= 21798) => -0.0051566995962595, 
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.00410813523432599, -0.000450226116287275), 
(r_D33_eviction_count_i >= 1.5) => map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d < 30.5) => map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p < 2.45) => -0.215027060784711, 
      (c_pop_75_84_p >= 2.45) => -0.0569110889345552, 
      (c_pop_75_84_p = NULL) => -0.128910326116322, -0.128910326116322), 
   (f_mos_inq_banko_om_lseen_d >= 30.5) => map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d < 1.5) => -0.0625875286459422, 
      (f_rel_incomeover75_count_d >= 1.5) => 0.039746366259936, 
      (f_rel_incomeover75_count_d = NULL) => -0.00989320962724369, -0.00989320962724369), 
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0455363564924626, -0.0455363564924626), 
(r_D33_eviction_count_i = NULL) => map(
   (NULL < c_rnt750_p and c_rnt750_p < 13.8) => -0.0837957446646087, 
   (c_rnt750_p >= 13.8) => 0.038222689435739, 
   (c_rnt750_p = NULL) => -0.0198104682461337, -0.0198104682461337), -0.00153719496030076);

// Tree: 9
adj_FLA_SD_tree_9 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i < 14.5) => map(
   (NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i < 0.5) => map(
      (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i < 8.5) => map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d < -13787) => map(
            (NULL < r_F03_address_match_d and r_F03_address_match_d < 2.5) => 0.0631187842667056, 
            (r_F03_address_match_d >= 2.5) => -0.0854710588613832, 
            (r_F03_address_match_d = NULL) => 0.0262059390264646, 0.0262059390264646), 
         (f_addrchangeincomediff_d >= -13787) => -0.00175662954904325, 
         (f_addrchangeincomediff_d = NULL) => 0.00294053676997986, 7.82112445142718e-06), 
      (f_assoccredbureaucount_i >= 8.5) => -0.10933533824604, 
      (f_assoccredbureaucount_i = NULL) => map(
         (NULL < c_hh3_p and c_hh3_p < 12.55) => -0.102779278973753, 
         (c_hh3_p >= 12.55) => 0.0317363830011772, 
         (c_hh3_p = NULL) => -0.0191614350433909, -0.0191614350433909), -0.000478358393785253), 
   (r_S65_SSN_Prior_DoB_i >= 0.5) => 0.0794617371443236, 
   (r_S65_SSN_Prior_DoB_i = NULL) => -0.000178419336383903, -0.000178419336383903), 
(k_inq_per_ssn_i >= 14.5) => map(
   (NULL < c_hhsize and c_hhsize < 2.625) => -0.0027738338324874, 
   (c_hhsize >= 2.625) => 0.170921761186138, 
   (c_hhsize = NULL) => 0.0832140844935649, 0.0832140844935649), 
(k_inq_per_ssn_i = NULL) => 0.000268631454106178, 0.000268631454106178);

// Tree: 10
adj_FLA_SD_tree_10 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d < 21939) => map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d < 0.5) => 0.169440760669006, 
   (f_rel_incomeover75_count_d >= 0.5) => -0.0135798783915699, 
   (f_rel_incomeover75_count_d = NULL) => 0.0890049384067145, 0.0890049384067145), 
(r_A46_Curr_AVM_AutoVal_d >= 21939) => map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d < 1.5) => map(
      (NULL < c_many_cars and c_many_cars < 37) => 0.133825737818489, 
      (c_many_cars >= 37) => map(
         (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i < 0.2166247881) => 0.1570302029647, 
         (f_add_input_mobility_index_i >= 0.2166247881) => -0.00282433949784798, 
         (f_add_input_mobility_index_i = NULL) => 0.0263383135189681, 0.0263383135189681), 
      (c_many_cars = NULL) => 0.0478357983788723, 0.0478357983788723), 
   (f_corrssnaddrcount_d >= 1.5) => -0.00514364193048815, 
   (f_corrssnaddrcount_d = NULL) => -0.00323944470465435, -0.00323944470465435), 
(r_A46_Curr_AVM_AutoVal_d = NULL) => map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d < 2.5) => -0.0980355937452636, 
   (r_C10_M_Hdr_FS_d >= 2.5) => map(
      (NULL < r_C20_email_count_i and r_C20_email_count_i < 1.5) => 0.0142909204603025, 
      (r_C20_email_count_i >= 1.5) => -0.0225052668436425, 
      (r_C20_email_count_i = NULL) => -0.000364993122691448, -0.000364993122691448), 
   (r_C10_M_Hdr_FS_d = NULL) => 0.0121332575095403, -0.000818922249349177), -0.00142390955367554);

// Tree: 11
adj_FLA_SD_tree_11 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d < 1.5) => -0.115582117421049, 
(f_M_Bureau_ADL_FS_noTU_d >= 1.5) => map(
   (NULL < r_D31_bk_chapter_n and r_D31_bk_chapter_n < 9) => -0.0319245475898643, 
   (r_D31_bk_chapter_n >= 9) => -0.041204933902109, 
   (r_D31_bk_chapter_n = NULL) => map(
      (NULL < c_unemp and c_unemp < 7.75) => -0.000121469029620482, 
      (c_unemp >= 7.75) => map(
         (NULL < c_blue_empl and c_blue_empl < 17.5) => 0.145567453313663, 
         (c_blue_empl >= 17.5) => map(
            (NULL < f_util_adl_count_n and f_util_adl_count_n < 7.5) => map(
               (NULL < c_hh1_p and c_hh1_p < 35.25) => 0.0518570010545317, 
               (c_hh1_p >= 35.25) => -0.0210151884873065, 
               (c_hh1_p = NULL) => 0.0320693988174018, 0.0320693988174018), 
            (f_util_adl_count_n >= 7.5) => -0.114593170960931, 
            (f_util_adl_count_n = NULL) => 0.0258054599019796, 0.0258054599019796), 
         (c_blue_empl = NULL) => 0.0330938799712937, 0.0330938799712937), 
      (c_unemp = NULL) => 0.00268246815722146, 0.00280557775039731), -0.00112666120883315), 
(f_M_Bureau_ADL_FS_noTU_d = NULL) => map(
   (NULL < c_low_ed and c_low_ed < 48.55) => -0.0534609913155104, 
   (c_low_ed >= 48.55) => 0.0722558932522754, 
   (c_low_ed = NULL) => -0.0131367075862206, -0.0131367075862206), -0.00156893709535797);

// Tree: 12
adj_FLA_SD_tree_12 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i < 0.5) => map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d < 1.5) => map(
      (NULL < c_hh2_p and c_hh2_p < 25.05) => 0.194684721770489, 
      (c_hh2_p >= 25.05) => 0.0269919360393018, 
      (c_hh2_p = NULL) => 0.0704938302457185, 0.0704938302457185), 
   (f_mos_inq_banko_om_fseen_d >= 1.5) => map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i < 7.5) => -0.00160725192568008, 
      (f_srchfraudsrchcount_i >= 7.5) => map(
         (NULL < c_rest_indx and c_rest_indx < 66.5) => map(
            (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i < 0.5) => -0.0387026524989009, 
            (f_inq_Communications_count_i >= 0.5) => -0.212003956565982, 
            (f_inq_Communications_count_i = NULL) => -0.126133941037248, -0.126133941037248), 
         (c_rest_indx >= 66.5) => -0.0143594750086521, 
         (c_rest_indx = NULL) => -0.0354239329529207, -0.0354239329529207), 
      (f_srchfraudsrchcount_i = NULL) => -0.0027013806108035, -0.0027013806108035), 
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.00471264341959015, -0.00167690880282698), 
(f_nae_nothing_found_i >= 0.5) => map(
   (NULL < c_hh3_p and c_hh3_p < 13.05) => 0.201344134794733, 
   (c_hh3_p >= 13.05) => 0.0196753845803943, 
   (c_hh3_p = NULL) => 0.0818810266771329, 0.0818810266771329), 
(f_nae_nothing_found_i = NULL) => -0.000548281619437601, -0.000548281619437601);

// Tree: 13
adj_FLA_SD_tree_13 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i < 37.5) => map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i < 21.5) => map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i < 19.5) => map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i < 0.94344744785) => map(
            (NULL < r_L70_Add_Invalid_i and r_L70_Add_Invalid_i < 0.5) => map(
               (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d < -231652.5) => 0.088493388422228, 
               (f_addrchangevaluediff_d >= -231652.5) => 0.00374380166791299, 
               (f_addrchangevaluediff_d = NULL) => 0.0182045164885892, 0.00711872593182299), 
            (r_L70_Add_Invalid_i >= 0.5) => -0.0633593741174071, 
            (r_L70_Add_Invalid_i = NULL) => 0.00611300645642036, 0.00611300645642036), 
         (f_add_input_nhood_MFD_pct_i >= 0.94344744785) => -0.03407288862135, 
         (f_add_input_nhood_MFD_pct_i = NULL) => -0.0190226648033316, 0.000121401058959287), 
      (f_srchfraudsrchcount_i >= 19.5) => -0.09526782166661, 
      (f_srchfraudsrchcount_i = NULL) => -0.000250536408136459, -0.000250536408136459), 
   (f_inq_HighRiskCredit_count_i >= 21.5) => 0.093793474072571, 
   (f_inq_HighRiskCredit_count_i = NULL) => 3.49158841794429e-05, 3.49158841794429e-05), 
(f_srchaddrsrchcount_i >= 37.5) => 0.113679665184823, 
(f_srchaddrsrchcount_i = NULL) => map(
   (NULL < c_pop_85p_p and c_pop_85p_p < 0.65) => 0.0567006669094875, 
   (c_pop_85p_p >= 0.65) => -0.0645514683671127, 
   (c_pop_85p_p = NULL) => -0.0160506142564726, -0.0160506142564726), 0.000343440074154569);

// Tree: 14
adj_FLA_SD_tree_14 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d < -91554) => map(
   (NULL < f_inq_Banking_count_i and f_inq_Banking_count_i < 1.5) => map(
      (NULL < c_rnt1250_p and c_rnt1250_p < 21.65) => map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i < 0.0349044228) => 0.183415066172412, 
         (f_add_input_nhood_BUS_pct_i >= 0.0349044228) => 0.0645650187733372, 
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.110961026581532, 0.110961026581532), 
      (c_rnt1250_p >= 21.65) => -0.0307833376759458, 
      (c_rnt1250_p = NULL) => 0.0722069494624464, 0.0722069494624464), 
   (f_inq_Banking_count_i >= 1.5) => -0.063384078956677, 
   (f_inq_Banking_count_i = NULL) => 0.0504612184895681, 0.0504612184895681), 
(f_addrchangevaluediff_d >= -91554) => map(
   (NULL < c_newhouse and c_newhouse < 608.55) => -0.00806853745859226, 
   (c_newhouse >= 608.55) => 0.251844622898186, 
   (c_newhouse = NULL) => -0.00716089267455546, -0.00716089267455546), 
(f_addrchangevaluediff_d = NULL) => map(
   (NULL < c_hval_150k_p and c_hval_150k_p < 28.4) => map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i < 179.5) => 0.0108352545401009, 
      (f_curraddrburglaryindex_i >= 179.5) => -0.0641106622600908, 
      (f_curraddrburglaryindex_i = NULL) => -0.00310848618017327, 0.00528051823085095), 
   (c_hval_150k_p >= 28.4) => 0.118024068006715, 
   (c_hval_150k_p = NULL) => -0.0020082948507218, 0.00791116295691228), -0.00271956048198878);

// Tree: 15
adj_FLA_SD_tree_15 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i < 8.5) => map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i < 4.5) => 6.73845872711201e-05, 
   (f_inq_HighRiskCredit_count_i >= 4.5) => 0.104837645413568, 
   (f_inq_HighRiskCredit_count_i = NULL) => 0.000421473231110335, 0.000421473231110335), 
(f_srchfraudsrchcount_i >= 8.5) => map(
   (NULL < C_INC_50K_P and C_INC_50K_P < 19.75) => map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i < 0.09354486165) => map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d < 2) => -0.0877760463665457, 
         (r_I60_inq_recency_d >= 2) => map(
            (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i < 93.5) => -0.0238912949785354, 
            (f_prevaddrcartheftindex_i >= 93.5) => map(
               (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i < 10.5) => 0.0187880300622649, 
               (f_inq_HighRiskCredit_count_i >= 10.5) => 0.130718738627298, 
               (f_inq_HighRiskCredit_count_i = NULL) => 0.0618964786312303, 0.0618964786312303), 
            (f_prevaddrcartheftindex_i = NULL) => 0.017331401431352, 0.017331401431352), 
         (r_I60_inq_recency_d = NULL) => -0.000984909847102006, -0.000984909847102006), 
      (f_add_curr_nhood_VAC_pct_i >= 0.09354486165) => -0.123254226704421, 
      (f_add_curr_nhood_VAC_pct_i = NULL) => -0.021226362749656, -0.021226362749656), 
   (C_INC_50K_P >= 19.75) => -0.1308412686412, 
   (C_INC_50K_P = NULL) => -0.0343887825515934, -0.0343887825515934), 
(f_srchfraudsrchcount_i = NULL) => -0.0121840639950305, -0.000627866774628261);

// Tree: 16
adj_FLA_SD_tree_16 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d < 1.5) => -0.0934802971684509, 
(r_C21_M_Bureau_ADL_FS_d >= 1.5) => map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d < 4.5) => map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i < 16.5) => map(
         (NULL < c_unemp and c_unemp < 5.25) => -0.000532836993119582, 
         (c_unemp >= 5.25) => map(
            (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d < 5.5) => map(
               (NULL < f_divrisktype_i and f_divrisktype_i < 4.5) => 0.0138619680952065, 
               (f_divrisktype_i >= 4.5) => 0.133805756413147, 
               (f_divrisktype_i = NULL) => 0.0180240553869963, 0.0180240553869963), 
            (r_C14_Addr_Stability_v2_d >= 5.5) => map(
               (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d < 3.5) => 0.000749542730551323, 
               (f_rel_incomeover75_count_d >= 3.5) => 0.132182871265928, 
               (f_rel_incomeover75_count_d = NULL) => 0.0363266493908366, 0.0363266493908366), 
            (r_C14_Addr_Stability_v2_d = NULL) => 0.0231018183603834, 0.0231018183603834), 
         (c_unemp = NULL) => -0.0133625658669054, 0.00575448157201631), 
      (f_inq_HighRiskCredit_count_i >= 16.5) => 0.107810707088399, 
      (f_inq_HighRiskCredit_count_i = NULL) => 0.00627291626338059, 0.00627291626338059), 
   (f_corrssnaddrcount_d >= 4.5) => -0.0184673886129726, 
   (f_corrssnaddrcount_d = NULL) => -0.00420416811796321, -0.00420416811796321), 
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.00580060929809258, -0.00444476118767251);

// Tree: 17
adj_FLA_SD_tree_17 := map(
(NULL < C_INC_75K_P and C_INC_75K_P < 1.75) => -0.131249814045309, 
(C_INC_75K_P >= 1.75) => map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n < 17.5) => map(
      (NULL < c_oldhouse and c_oldhouse < 99.35) => -0.00893354896739843, 
      (c_oldhouse >= 99.35) => map(
         (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 79.5) => 0.100027077078014, 
         (f_attr_arrest_recency_d >= 79.5) => map(
            (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d < -15189) => 0.0585217759741838, 
            (f_addrchangeincomediff_d >= -15189) => 0.00602079704836, 
            (f_addrchangeincomediff_d = NULL) => map(
               (NULL < c_newhouse and c_newhouse < 25.85) => 0.00333962221947528, 
               (c_newhouse >= 25.85) => 0.094190873192508, 
               (c_newhouse = NULL) => 0.0211148669750686, 0.0211148669750686), 0.0110496301197369), 
         (f_attr_arrest_recency_d = NULL) => 0.0117344835900111, 0.0117344835900111), 
      (c_oldhouse = NULL) => 0.000474382861301424, 0.000474382861301424), 
   (f_util_adl_count_n >= 17.5) => -0.142674977011203, 
   (f_util_adl_count_n = NULL) => map(
      (NULL < c_child and c_child < 25.8) => -0.039520166096877, 
      (c_child >= 25.8) => 0.0816805817390352, 
      (c_child = NULL) => 0.000627581623768947, 0.000627581623768947), 4.19935115819277e-05), 
(C_INC_75K_P = NULL) => -0.010012439682548, -0.000646899442770343);

// Tree: 18
adj_FLA_SD_tree_18 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i < 2.5) => map(
   (NULL < c_hh3_p and c_hh3_p < 23.25) => map(
      (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d < 0.5) => map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d < 29900) => 0.0957364081429742, 
         (r_A46_Curr_AVM_AutoVal_d >= 29900) => 0.0172341397949155, 
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0165821269451856, 0.0181546477364609), 
      (f_curraddractivephonelist_d >= 0.5) => -0.00874565702067296, 
      (f_curraddractivephonelist_d = NULL) => -0.00235275766284933, 0.00314533986595306), 
   (c_hh3_p >= 23.25) => map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d < 42.5) => map(
         (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d < 6.5) => 0.0015902255253478, 
         (f_rel_homeover100_count_d >= 6.5) => -0.101717089134088, 
         (f_rel_homeover100_count_d = NULL) => -0.0645602348151626, -0.0645602348151626), 
      (f_mos_inq_banko_cm_fseen_d >= 42.5) => -0.0126523769899905, 
      (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0195609092430333, -0.0195609092430333), 
   (c_hh3_p = NULL) => -0.0155612833258231, -0.000705259641506576), 
(r_D33_eviction_count_i >= 2.5) => map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i < 0.5) => 0.00426572189993636, 
   (r_I60_Inq_Count12_i >= 0.5) => -0.111485932188962, 
   (r_I60_Inq_Count12_i = NULL) => -0.0616236811968209, -0.0616236811968209), 
(r_D33_eviction_count_i = NULL) => 0.0075526990937188, -0.00125320159062555);

// Tree: 19
adj_FLA_SD_tree_19 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d < 549) => map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i < 3.5) => map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i < 4.5) => -0.0654023967044741, 
      (k_inq_per_addr_i >= 4.5) => -0.15416172617444, 
      (k_inq_per_addr_i = NULL) => -0.0786356058254508, -0.0786356058254508), 
   (f_sourcerisktype_i >= 3.5) => map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i < 11.5) => map(
         (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i < 139.5) => -0.015019121982298, 
         (f_fp_prevaddrburglaryindex_i >= 139.5) => map(
            (NULL < c_unempl and c_unempl < 132.5) => 0.127909344066993, 
            (c_unempl >= 132.5) => -0.0169768335364615, 
            (c_unempl = NULL) => 0.0612950095366691, 0.0612950095366691), 
         (f_fp_prevaddrburglaryindex_i = NULL) => 0.00389696359761628, 0.00389696359761628), 
      (f_srchaddrsrchcount_i >= 11.5) => -0.0801876979973075, 
      (f_srchaddrsrchcount_i = NULL) => -0.00543791893436853, -0.00543791893436853), 
   (f_sourcerisktype_i = NULL) => -0.0285884237015308, -0.0285884237015308), 
(r_I60_inq_comm_recency_d >= 549) => 0.00272984156374307, 
(r_I60_inq_comm_recency_d = NULL) => map(
   (NULL < c_hh4_p and c_hh4_p < 10.95) => -0.0665037473977328, 
   (c_hh4_p >= 10.95) => 0.042184391645542, 
   (c_hh4_p = NULL) => 0.000280530809580637, 0.000280530809580637), -0.000154677527339459);

// Tree: 20
adj_FLA_SD_tree_20 := map(
(NULL < c_hval_750k_p and c_hval_750k_p < 75.15) => map(
   (NULL < c_unempl and c_unempl < 173.5) => map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i < 67.35) => -0.0776946180835278, 
      (r_A49_Curr_AVM_Chg_1yr_Pct_i >= 67.35) => 0.0025366121636857, 
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.011294516773382, -0.00586222418383157), 
   (c_unempl >= 173.5) => map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d < 35.5) => map(
         (NULL < r_C20_email_count_i and r_C20_email_count_i < 0.5) => map(
            (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i < 0.5) => 0.0670227953872295, 
            (f_rel_criminal_count_i >= 0.5) => 0.194219048487433, 
            (f_rel_criminal_count_i = NULL) => 0.136199704968042, 0.136199704968042), 
         (r_C20_email_count_i >= 0.5) => 0.0200399325802662, 
         (r_C20_email_count_i = NULL) => 0.0740163485539336, 0.0740163485539336), 
      (r_C13_Curr_Addr_LRes_d >= 35.5) => map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i < 9.5) => -0.0281739175380872, 
         (f_phones_per_addr_curr_i >= 9.5) => 0.0880071630092627, 
         (f_phones_per_addr_curr_i = NULL) => -0.0137052699606291, -0.0137052699606291), 
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0219255861247562, 0.0219255861247562), 
   (c_unempl = NULL) => -0.00448987541730813, -0.00448987541730813), 
(c_hval_750k_p >= 75.15) => 0.140777723753601, 
(c_hval_750k_p = NULL) => -0.00336801537261333, -0.00383041971905212);


// Final Score Sum 

   woFDN_FLA_SD_lgt := sum(
      woFDN_FLA_SD_lgt_0, woFDN_FLA_SD_lgt_1, woFDN_FLA_SD_lgt_2, woFDN_FLA_SD_lgt_3, woFDN_FLA_SD_lgt_4, 
      woFDN_FLA_SD_lgt_5, woFDN_FLA_SD_lgt_6, woFDN_FLA_SD_lgt_7, woFDN_FLA_SD_lgt_8, woFDN_FLA_SD_lgt_9, 
      woFDN_FLA_SD_lgt_10, woFDN_FLA_SD_lgt_11, woFDN_FLA_SD_lgt_12, woFDN_FLA_SD_lgt_13, woFDN_FLA_SD_lgt_14, 
      woFDN_FLA_SD_lgt_15, woFDN_FLA_SD_lgt_16, woFDN_FLA_SD_lgt_17, woFDN_FLA_SD_lgt_18, woFDN_FLA_SD_lgt_19, 
      woFDN_FLA_SD_lgt_20, woFDN_FLA_SD_lgt_21, woFDN_FLA_SD_lgt_22, woFDN_FLA_SD_lgt_23, woFDN_FLA_SD_lgt_24, 
      woFDN_FLA_SD_lgt_25, woFDN_FLA_SD_lgt_26, woFDN_FLA_SD_lgt_27, woFDN_FLA_SD_lgt_28, woFDN_FLA_SD_lgt_29, 
      woFDN_FLA_SD_lgt_30, woFDN_FLA_SD_lgt_31, woFDN_FLA_SD_lgt_32, woFDN_FLA_SD_lgt_33, woFDN_FLA_SD_lgt_34, 
      woFDN_FLA_SD_lgt_35, woFDN_FLA_SD_lgt_36, woFDN_FLA_SD_lgt_37, woFDN_FLA_SD_lgt_38, woFDN_FLA_SD_lgt_39, 
      woFDN_FLA_SD_lgt_40, woFDN_FLA_SD_lgt_41, woFDN_FLA_SD_lgt_42, woFDN_FLA_SD_lgt_43, woFDN_FLA_SD_lgt_44, 
      woFDN_FLA_SD_lgt_45, woFDN_FLA_SD_lgt_46, woFDN_FLA_SD_lgt_47, woFDN_FLA_SD_lgt_48, woFDN_FLA_SD_lgt_49, 
      woFDN_FLA_SD_lgt_50, woFDN_FLA_SD_lgt_51, woFDN_FLA_SD_lgt_52, woFDN_FLA_SD_lgt_53, woFDN_FLA_SD_lgt_54, 
      woFDN_FLA_SD_lgt_55, woFDN_FLA_SD_lgt_56, woFDN_FLA_SD_lgt_57, woFDN_FLA_SD_lgt_58, woFDN_FLA_SD_lgt_59, 
      woFDN_FLA_SD_lgt_60, woFDN_FLA_SD_lgt_61, woFDN_FLA_SD_lgt_62, woFDN_FLA_SD_lgt_63, woFDN_FLA_SD_lgt_64, 
      woFDN_FLA_SD_lgt_65, woFDN_FLA_SD_lgt_66, woFDN_FLA_SD_lgt_67, woFDN_FLA_SD_lgt_68, woFDN_FLA_SD_lgt_69, 
      woFDN_FLA_SD_lgt_70, woFDN_FLA_SD_lgt_71, woFDN_FLA_SD_lgt_72, woFDN_FLA_SD_lgt_73, woFDN_FLA_SD_lgt_74, 
      woFDN_FLA_SD_lgt_75, woFDN_FLA_SD_lgt_76, woFDN_FLA_SD_lgt_77, woFDN_FLA_SD_lgt_78, woFDN_FLA_SD_lgt_79, 
      woFDN_FLA_SD_lgt_80, woFDN_FLA_SD_lgt_81, woFDN_FLA_SD_lgt_82, woFDN_FLA_SD_lgt_83, woFDN_FLA_SD_lgt_84, 
      woFDN_FLA_SD_lgt_85, woFDN_FLA_SD_lgt_86, woFDN_FLA_SD_lgt_87, woFDN_FLA_SD_lgt_88, woFDN_FLA_SD_lgt_89, 
      woFDN_FLA_SD_lgt_90, woFDN_FLA_SD_lgt_91, woFDN_FLA_SD_lgt_92, woFDN_FLA_SD_lgt_93, woFDN_FLA_SD_lgt_94, 
      woFDN_FLA_SD_lgt_95, woFDN_FLA_SD_lgt_96, woFDN_FLA_SD_lgt_97, woFDN_FLA_SD_lgt_98, woFDN_FLA_SD_lgt_99, 
      woFDN_FLA_SD_lgt_100, woFDN_FLA_SD_lgt_101, woFDN_FLA_SD_lgt_102, woFDN_FLA_SD_lgt_103, woFDN_FLA_SD_lgt_104, 
      woFDN_FLA_SD_lgt_105, woFDN_FLA_SD_lgt_106, woFDN_FLA_SD_lgt_107, woFDN_FLA_SD_lgt_108, woFDN_FLA_SD_lgt_109, 
      woFDN_FLA_SD_lgt_110, woFDN_FLA_SD_lgt_111, woFDN_FLA_SD_lgt_112, woFDN_FLA_SD_lgt_113, woFDN_FLA_SD_lgt_114, 
      woFDN_FLA_SD_lgt_115, woFDN_FLA_SD_lgt_116, woFDN_FLA_SD_lgt_117, woFDN_FLA_SD_lgt_118, woFDN_FLA_SD_lgt_119, 
      woFDN_FLA_SD_lgt_120, woFDN_FLA_SD_lgt_121, woFDN_FLA_SD_lgt_122, woFDN_FLA_SD_lgt_123, woFDN_FLA_SD_lgt_124, 
      woFDN_FLA_SD_lgt_125, woFDN_FLA_SD_lgt_126, woFDN_FLA_SD_lgt_127, woFDN_FLA_SD_lgt_128, woFDN_FLA_SD_lgt_129, 
      woFDN_FLA_SD_lgt_130, woFDN_FLA_SD_lgt_131, woFDN_FLA_SD_lgt_132, woFDN_FLA_SD_lgt_133, woFDN_FLA_SD_lgt_134, 
      woFDN_FLA_SD_lgt_135, woFDN_FLA_SD_lgt_136, woFDN_FLA_SD_lgt_137, woFDN_FLA_SD_lgt_138, woFDN_FLA_SD_lgt_139, 
      woFDN_FLA_SD_lgt_140, woFDN_FLA_SD_lgt_141, woFDN_FLA_SD_lgt_142, woFDN_FLA_SD_lgt_143, woFDN_FLA_SD_lgt_144, 
      woFDN_FLA_SD_lgt_145, woFDN_FLA_SD_lgt_146, woFDN_FLA_SD_lgt_147, woFDN_FLA_SD_lgt_148, woFDN_FLA_SD_lgt_149, 
      woFDN_FLA_SD_lgt_150, woFDN_FLA_SD_lgt_151, woFDN_FLA_SD_lgt_152, woFDN_FLA_SD_lgt_153, woFDN_FLA_SD_lgt_154, 
      woFDN_FLA_SD_lgt_155, woFDN_FLA_SD_lgt_156, woFDN_FLA_SD_lgt_157, woFDN_FLA_SD_lgt_158, woFDN_FLA_SD_lgt_159, 
      woFDN_FLA_SD_lgt_160, woFDN_FLA_SD_lgt_161, woFDN_FLA_SD_lgt_162, woFDN_FLA_SD_lgt_163, woFDN_FLA_SD_lgt_164, 
      woFDN_FLA_SD_lgt_165, woFDN_FLA_SD_lgt_166, woFDN_FLA_SD_lgt_167, woFDN_FLA_SD_lgt_168, woFDN_FLA_SD_lgt_169, 
      woFDN_FLA_SD_lgt_170, woFDN_FLA_SD_lgt_171, woFDN_FLA_SD_lgt_172, woFDN_FLA_SD_lgt_173, woFDN_FLA_SD_lgt_174, 
      woFDN_FLA_SD_lgt_175, woFDN_FLA_SD_lgt_176, woFDN_FLA_SD_lgt_177, woFDN_FLA_SD_lgt_178, woFDN_FLA_SD_lgt_179, 
      woFDN_FLA_SD_lgt_180, woFDN_FLA_SD_lgt_181, woFDN_FLA_SD_lgt_182, woFDN_FLA_SD_lgt_183, woFDN_FLA_SD_lgt_184, 
      woFDN_FLA_SD_lgt_185, woFDN_FLA_SD_lgt_186, woFDN_FLA_SD_lgt_187, woFDN_FLA_SD_lgt_188, woFDN_FLA_SD_lgt_189, 
      woFDN_FLA_SD_lgt_190, woFDN_FLA_SD_lgt_191, woFDN_FLA_SD_lgt_192, woFDN_FLA_SD_lgt_193, woFDN_FLA_SD_lgt_194, 
      woFDN_FLA_SD_lgt_195, woFDN_FLA_SD_lgt_196, woFDN_FLA_SD_lgt_197, woFDN_FLA_SD_lgt_198, woFDN_FLA_SD_lgt_199, 
      woFDN_FLA_SD_lgt_200, woFDN_FLA_SD_lgt_201, woFDN_FLA_SD_lgt_202, woFDN_FLA_SD_lgt_203, woFDN_FLA_SD_lgt_204, 
      woFDN_FLA_SD_lgt_205, woFDN_FLA_SD_lgt_206, woFDN_FLA_SD_lgt_207, woFDN_FLA_SD_lgt_208, woFDN_FLA_SD_lgt_209, 
      woFDN_FLA_SD_lgt_210, woFDN_FLA_SD_lgt_211, woFDN_FLA_SD_lgt_212, woFDN_FLA_SD_lgt_213, woFDN_FLA_SD_lgt_214, 
      woFDN_FLA_SD_lgt_215, woFDN_FLA_SD_lgt_216, woFDN_FLA_SD_lgt_217, woFDN_FLA_SD_lgt_218, woFDN_FLA_SD_lgt_219, 
      woFDN_FLA_SD_lgt_220, woFDN_FLA_SD_lgt_221, woFDN_FLA_SD_lgt_222, woFDN_FLA_SD_lgt_223, woFDN_FLA_SD_lgt_224, 
      woFDN_FLA_SD_lgt_225, woFDN_FLA_SD_lgt_226, woFDN_FLA_SD_lgt_227, woFDN_FLA_SD_lgt_228, woFDN_FLA_SD_lgt_229, 
      woFDN_FLA_SD_lgt_230, woFDN_FLA_SD_lgt_231, woFDN_FLA_SD_lgt_232, woFDN_FLA_SD_lgt_233, woFDN_FLA_SD_lgt_234, 
      woFDN_FLA_SD_lgt_235, woFDN_FLA_SD_lgt_236, woFDN_FLA_SD_lgt_237, woFDN_FLA_SD_lgt_238, woFDN_FLA_SD_lgt_239, 
      woFDN_FLA_SD_lgt_240, woFDN_FLA_SD_lgt_241, woFDN_FLA_SD_lgt_242, woFDN_FLA_SD_lgt_243, woFDN_FLA_SD_lgt_244, 
      woFDN_FLA_SD_lgt_245, woFDN_FLA_SD_lgt_246, woFDN_FLA_SD_lgt_247, woFDN_FLA_SD_lgt_248, woFDN_FLA_SD_lgt_249, 
      woFDN_FLA_SD_lgt_250, woFDN_FLA_SD_lgt_251, woFDN_FLA_SD_lgt_252, woFDN_FLA_SD_lgt_253, woFDN_FLA_SD_lgt_254, 
      woFDN_FLA_SD_lgt_255, woFDN_FLA_SD_lgt_256, woFDN_FLA_SD_lgt_257, woFDN_FLA_SD_lgt_258, woFDN_FLA_SD_lgt_259, 
      woFDN_FLA_SD_lgt_260, woFDN_FLA_SD_lgt_261, woFDN_FLA_SD_lgt_262, woFDN_FLA_SD_lgt_263, woFDN_FLA_SD_lgt_264, 
      woFDN_FLA_SD_lgt_265, woFDN_FLA_SD_lgt_266, woFDN_FLA_SD_lgt_267, woFDN_FLA_SD_lgt_268, woFDN_FLA_SD_lgt_269, 
      woFDN_FLA_SD_lgt_270, woFDN_FLA_SD_lgt_271, woFDN_FLA_SD_lgt_272, woFDN_FLA_SD_lgt_273, woFDN_FLA_SD_lgt_274, 
      woFDN_FLA_SD_lgt_275, woFDN_FLA_SD_lgt_276, woFDN_FLA_SD_lgt_277, woFDN_FLA_SD_lgt_278, woFDN_FLA_SD_lgt_279, 
      woFDN_FLA_SD_lgt_280, woFDN_FLA_SD_lgt_281, woFDN_FLA_SD_lgt_282, woFDN_FLA_SD_lgt_283, woFDN_FLA_SD_lgt_284, 
      woFDN_FLA_SD_lgt_285, woFDN_FLA_SD_lgt_286, woFDN_FLA_SD_lgt_287, woFDN_FLA_SD_lgt_288, woFDN_FLA_SD_lgt_289, 
      woFDN_FLA_SD_lgt_290, woFDN_FLA_SD_lgt_291, woFDN_FLA_SD_lgt_292, woFDN_FLA_SD_lgt_293, woFDN_FLA_SD_lgt_294, 
      woFDN_FLA_SD_lgt_295, woFDN_FLA_SD_lgt_296, woFDN_FLA_SD_lgt_297, woFDN_FLA_SD_lgt_298, woFDN_FLA_SD_lgt_299, 
      woFDN_FLA_SD_lgt_300, woFDN_FLA_SD_lgt_301, woFDN_FLA_SD_lgt_302, woFDN_FLA_SD_lgt_303, woFDN_FLA_SD_lgt_304, 
      woFDN_FLA_SD_lgt_305, woFDN_FLA_SD_lgt_306, woFDN_FLA_SD_lgt_307, woFDN_FLA_SD_lgt_308, woFDN_FLA_SD_lgt_309, 
      woFDN_FLA_SD_lgt_310, woFDN_FLA_SD_lgt_311, woFDN_FLA_SD_lgt_312, woFDN_FLA_SD_lgt_313, woFDN_FLA_SD_lgt_314, 
      woFDN_FLA_SD_lgt_315, woFDN_FLA_SD_lgt_316, woFDN_FLA_SD_lgt_317, woFDN_FLA_SD_lgt_318, woFDN_FLA_SD_lgt_319, 
      woFDN_FLA_SD_lgt_320, woFDN_FLA_SD_lgt_321, woFDN_FLA_SD_lgt_322, woFDN_FLA_SD_lgt_323, woFDN_FLA_SD_lgt_324, 
      woFDN_FLA_SD_lgt_325, woFDN_FLA_SD_lgt_326, woFDN_FLA_SD_lgt_327, woFDN_FLA_SD_lgt_328, woFDN_FLA_SD_lgt_329, 
      woFDN_FLA_SD_lgt_330, woFDN_FLA_SD_lgt_331, woFDN_FLA_SD_lgt_332, woFDN_FLA_SD_lgt_333, woFDN_FLA_SD_lgt_334, 
      woFDN_FLA_SD_lgt_335, woFDN_FLA_SD_lgt_336, woFDN_FLA_SD_lgt_337, woFDN_FLA_SD_lgt_338, woFDN_FLA_SD_lgt_339, 
      woFDN_FLA_SD_lgt_340, woFDN_FLA_SD_lgt_341, woFDN_FLA_SD_lgt_342, woFDN_FLA_SD_lgt_343, woFDN_FLA_SD_lgt_344, 
      woFDN_FLA_SD_lgt_345, woFDN_FLA_SD_lgt_346); 

      adjusted_tree_score := sum(adj_FLA_SD_tree_0, adj_FLA_SD_tree_1, adj_FLA_SD_tree_2,
      adj_FLA_SD_tree_3, adj_FLA_SD_tree_4, adj_FLA_SD_tree_5, adj_FLA_SD_tree_6, adj_FLA_SD_tree_7,
      adj_FLA_SD_tree_8, adj_FLA_SD_tree_9, adj_FLA_SD_tree_10, adj_FLA_SD_tree_11, adj_FLA_SD_tree_12,
      adj_FLA_SD_tree_13, adj_FLA_SD_tree_14, adj_FLA_SD_tree_15, adj_FLA_SD_tree_16, adj_FLA_SD_tree_17,
      adj_FLA_SD_tree_18, adj_FLA_SD_tree_19, adj_FLA_SD_tree_20);
      
// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
		
		FP3_woFDN_LGT := woFDN_FLA_SD_lgt + adjusted_tree_score;
			
self.final_score_0	:= 	woFDN_FLA_SD_lgt_0	;
self.final_score_1	:= 	woFDN_FLA_SD_lgt_1	;
self.final_score_2	:= 	woFDN_FLA_SD_lgt_2	;
self.final_score_3	:= 	woFDN_FLA_SD_lgt_3	;
self.final_score_4	:= 	woFDN_FLA_SD_lgt_4	;
self.final_score_5	:= 	woFDN_FLA_SD_lgt_5	;
self.final_score_6	:= 	woFDN_FLA_SD_lgt_6	;
self.final_score_7	:= 	woFDN_FLA_SD_lgt_7	;
self.final_score_8	:= 	woFDN_FLA_SD_lgt_8	;
self.final_score_9	:= 	woFDN_FLA_SD_lgt_9	;
self.final_score_10	:= 	woFDN_FLA_SD_lgt_10	;
self.final_score_11	:= 	woFDN_FLA_SD_lgt_11	;
self.final_score_12	:= 	woFDN_FLA_SD_lgt_12	;
self.final_score_13	:= 	woFDN_FLA_SD_lgt_13	;
self.final_score_14	:= 	woFDN_FLA_SD_lgt_14	;
self.final_score_15	:= 	woFDN_FLA_SD_lgt_15	;
self.final_score_16	:= 	woFDN_FLA_SD_lgt_16	;
self.final_score_17	:= 	woFDN_FLA_SD_lgt_17	;
self.final_score_18	:= 	woFDN_FLA_SD_lgt_18	;
self.final_score_19	:= 	woFDN_FLA_SD_lgt_19	;
self.final_score_20	:= 	woFDN_FLA_SD_lgt_20	;
self.final_score_21	:= 	woFDN_FLA_SD_lgt_21	;
self.final_score_22	:= 	woFDN_FLA_SD_lgt_22	;
self.final_score_23	:= 	woFDN_FLA_SD_lgt_23	;
self.final_score_24	:= 	woFDN_FLA_SD_lgt_24	;
self.final_score_25	:= 	woFDN_FLA_SD_lgt_25	;
self.final_score_26	:= 	woFDN_FLA_SD_lgt_26	;
self.final_score_27	:= 	woFDN_FLA_SD_lgt_27	;
self.final_score_28	:= 	woFDN_FLA_SD_lgt_28	;
self.final_score_29	:= 	woFDN_FLA_SD_lgt_29	;
self.final_score_30	:= 	woFDN_FLA_SD_lgt_30	;
self.final_score_31	:= 	woFDN_FLA_SD_lgt_31	;
self.final_score_32	:= 	woFDN_FLA_SD_lgt_32	;
self.final_score_33	:= 	woFDN_FLA_SD_lgt_33	;
self.final_score_34	:= 	woFDN_FLA_SD_lgt_34	;
self.final_score_35	:= 	woFDN_FLA_SD_lgt_35	;
self.final_score_36	:= 	woFDN_FLA_SD_lgt_36	;
self.final_score_37	:= 	woFDN_FLA_SD_lgt_37	;
self.final_score_38	:= 	woFDN_FLA_SD_lgt_38	;
self.final_score_39	:= 	woFDN_FLA_SD_lgt_39	;
self.final_score_40	:= 	woFDN_FLA_SD_lgt_40	;
self.final_score_41	:= 	woFDN_FLA_SD_lgt_41	;
self.final_score_42	:= 	woFDN_FLA_SD_lgt_42	;
self.final_score_43	:= 	woFDN_FLA_SD_lgt_43	;
self.final_score_44	:= 	woFDN_FLA_SD_lgt_44	;
self.final_score_45	:= 	woFDN_FLA_SD_lgt_45	;
self.final_score_46	:= 	woFDN_FLA_SD_lgt_46	;
self.final_score_47	:= 	woFDN_FLA_SD_lgt_47	;
self.final_score_48	:= 	woFDN_FLA_SD_lgt_48	;
self.final_score_49	:= 	woFDN_FLA_SD_lgt_49	;
self.final_score_50	:= 	woFDN_FLA_SD_lgt_50	;
self.final_score_51	:= 	woFDN_FLA_SD_lgt_51	;
self.final_score_52	:= 	woFDN_FLA_SD_lgt_52	;
self.final_score_53	:= 	woFDN_FLA_SD_lgt_53	;
self.final_score_54	:= 	woFDN_FLA_SD_lgt_54	;
self.final_score_55	:= 	woFDN_FLA_SD_lgt_55	;
self.final_score_56	:= 	woFDN_FLA_SD_lgt_56	;
self.final_score_57	:= 	woFDN_FLA_SD_lgt_57	;
self.final_score_58	:= 	woFDN_FLA_SD_lgt_58	;
self.final_score_59	:= 	woFDN_FLA_SD_lgt_59	;
self.final_score_60	:= 	woFDN_FLA_SD_lgt_60	;
self.final_score_61	:= 	woFDN_FLA_SD_lgt_61	;
self.final_score_62	:= 	woFDN_FLA_SD_lgt_62	;
self.final_score_63	:= 	woFDN_FLA_SD_lgt_63	;
self.final_score_64	:= 	woFDN_FLA_SD_lgt_64	;
self.final_score_65	:= 	woFDN_FLA_SD_lgt_65	;
self.final_score_66	:= 	woFDN_FLA_SD_lgt_66	;
self.final_score_67	:= 	woFDN_FLA_SD_lgt_67	;
self.final_score_68	:= 	woFDN_FLA_SD_lgt_68	;
self.final_score_69	:= 	woFDN_FLA_SD_lgt_69	;
self.final_score_70	:= 	woFDN_FLA_SD_lgt_70	;
self.final_score_71	:= 	woFDN_FLA_SD_lgt_71	;
self.final_score_72	:= 	woFDN_FLA_SD_lgt_72	;
self.final_score_73	:= 	woFDN_FLA_SD_lgt_73	;
self.final_score_74	:= 	woFDN_FLA_SD_lgt_74	;
self.final_score_75	:= 	woFDN_FLA_SD_lgt_75	;
self.final_score_76	:= 	woFDN_FLA_SD_lgt_76	;
self.final_score_77	:= 	woFDN_FLA_SD_lgt_77	;
self.final_score_78	:= 	woFDN_FLA_SD_lgt_78	;
self.final_score_79	:= 	woFDN_FLA_SD_lgt_79	;
self.final_score_80	:= 	woFDN_FLA_SD_lgt_80	;
self.final_score_81	:= 	woFDN_FLA_SD_lgt_81	;
self.final_score_82	:= 	woFDN_FLA_SD_lgt_82	;
self.final_score_83	:= 	woFDN_FLA_SD_lgt_83	;
self.final_score_84	:= 	woFDN_FLA_SD_lgt_84	;
self.final_score_85	:= 	woFDN_FLA_SD_lgt_85	;
self.final_score_86	:= 	woFDN_FLA_SD_lgt_86	;
self.final_score_87	:= 	woFDN_FLA_SD_lgt_87	;
self.final_score_88	:= 	woFDN_FLA_SD_lgt_88	;
self.final_score_89	:= 	woFDN_FLA_SD_lgt_89	;
self.final_score_90	:= 	woFDN_FLA_SD_lgt_90	;
self.final_score_91	:= 	woFDN_FLA_SD_lgt_91	;
self.final_score_92	:= 	woFDN_FLA_SD_lgt_92	;
self.final_score_93	:= 	woFDN_FLA_SD_lgt_93	;
self.final_score_94	:= 	woFDN_FLA_SD_lgt_94	;
self.final_score_95	:= 	woFDN_FLA_SD_lgt_95	;
self.final_score_96	:= 	woFDN_FLA_SD_lgt_96	;
self.final_score_97	:= 	woFDN_FLA_SD_lgt_97	;
self.final_score_98	:= 	woFDN_FLA_SD_lgt_98	;
self.final_score_99	:= 	woFDN_FLA_SD_lgt_99	;
self.final_score_100	:= 	woFDN_FLA_SD_lgt_100	;
self.final_score_101	:= 	woFDN_FLA_SD_lgt_101	;
self.final_score_102	:= 	woFDN_FLA_SD_lgt_102	;
self.final_score_103	:= 	woFDN_FLA_SD_lgt_103	;
self.final_score_104	:= 	woFDN_FLA_SD_lgt_104	;
self.final_score_105	:= 	woFDN_FLA_SD_lgt_105	;
self.final_score_106	:= 	woFDN_FLA_SD_lgt_106	;
self.final_score_107	:= 	woFDN_FLA_SD_lgt_107	;
self.final_score_108	:= 	woFDN_FLA_SD_lgt_108	;
self.final_score_109	:= 	woFDN_FLA_SD_lgt_109	;
self.final_score_110	:= 	woFDN_FLA_SD_lgt_110	;
self.final_score_111	:= 	woFDN_FLA_SD_lgt_111	;
self.final_score_112	:= 	woFDN_FLA_SD_lgt_112	;
self.final_score_113	:= 	woFDN_FLA_SD_lgt_113	;
self.final_score_114	:= 	woFDN_FLA_SD_lgt_114	;
self.final_score_115	:= 	woFDN_FLA_SD_lgt_115	;
self.final_score_116	:= 	woFDN_FLA_SD_lgt_116	;
self.final_score_117	:= 	woFDN_FLA_SD_lgt_117	;
self.final_score_118	:= 	woFDN_FLA_SD_lgt_118	;
self.final_score_119	:= 	woFDN_FLA_SD_lgt_119	;
self.final_score_120	:= 	woFDN_FLA_SD_lgt_120	;
self.final_score_121	:= 	woFDN_FLA_SD_lgt_121	;
self.final_score_122	:= 	woFDN_FLA_SD_lgt_122	;
self.final_score_123	:= 	woFDN_FLA_SD_lgt_123	;
self.final_score_124	:= 	woFDN_FLA_SD_lgt_124	;
self.final_score_125	:= 	woFDN_FLA_SD_lgt_125	;
self.final_score_126	:= 	woFDN_FLA_SD_lgt_126	;
self.final_score_127	:= 	woFDN_FLA_SD_lgt_127	;
self.final_score_128	:= 	woFDN_FLA_SD_lgt_128	;
self.final_score_129	:= 	woFDN_FLA_SD_lgt_129	;
self.final_score_130	:= 	woFDN_FLA_SD_lgt_130	;
self.final_score_131	:= 	woFDN_FLA_SD_lgt_131	;
self.final_score_132	:= 	woFDN_FLA_SD_lgt_132	;
self.final_score_133	:= 	woFDN_FLA_SD_lgt_133	;
self.final_score_134	:= 	woFDN_FLA_SD_lgt_134	;
self.final_score_135	:= 	woFDN_FLA_SD_lgt_135	;
self.final_score_136	:= 	woFDN_FLA_SD_lgt_136	;
self.final_score_137	:= 	woFDN_FLA_SD_lgt_137	;
self.final_score_138	:= 	woFDN_FLA_SD_lgt_138	;
self.final_score_139	:= 	woFDN_FLA_SD_lgt_139	;
self.final_score_140	:= 	woFDN_FLA_SD_lgt_140	;
self.final_score_141	:= 	woFDN_FLA_SD_lgt_141	;
self.final_score_142	:= 	woFDN_FLA_SD_lgt_142	;
self.final_score_143	:= 	woFDN_FLA_SD_lgt_143	;
self.final_score_144	:= 	woFDN_FLA_SD_lgt_144	;
self.final_score_145	:= 	woFDN_FLA_SD_lgt_145	;
self.final_score_146	:= 	woFDN_FLA_SD_lgt_146	;
self.final_score_147	:= 	woFDN_FLA_SD_lgt_147	;
self.final_score_148	:= 	woFDN_FLA_SD_lgt_148	;
self.final_score_149	:= 	woFDN_FLA_SD_lgt_149	;
self.final_score_150	:= 	woFDN_FLA_SD_lgt_150	;
self.final_score_151	:= 	woFDN_FLA_SD_lgt_151	;
self.final_score_152	:= 	woFDN_FLA_SD_lgt_152	;
self.final_score_153	:= 	woFDN_FLA_SD_lgt_153	;
self.final_score_154	:= 	woFDN_FLA_SD_lgt_154	;
self.final_score_155	:= 	woFDN_FLA_SD_lgt_155	;
self.final_score_156	:= 	woFDN_FLA_SD_lgt_156	;
self.final_score_157	:= 	woFDN_FLA_SD_lgt_157	;
self.final_score_158	:= 	woFDN_FLA_SD_lgt_158	;
self.final_score_159	:= 	woFDN_FLA_SD_lgt_159	;
self.final_score_160	:= 	woFDN_FLA_SD_lgt_160	;
self.final_score_161	:= 	woFDN_FLA_SD_lgt_161	;
self.final_score_162	:= 	woFDN_FLA_SD_lgt_162	;
self.final_score_163	:= 	woFDN_FLA_SD_lgt_163	;
self.final_score_164	:= 	woFDN_FLA_SD_lgt_164	;
self.final_score_165	:= 	woFDN_FLA_SD_lgt_165	;
self.final_score_166	:= 	woFDN_FLA_SD_lgt_166	;
self.final_score_167	:= 	woFDN_FLA_SD_lgt_167	;
self.final_score_168	:= 	woFDN_FLA_SD_lgt_168	;
self.final_score_169	:= 	woFDN_FLA_SD_lgt_169	;
self.final_score_170	:= 	woFDN_FLA_SD_lgt_170	;
self.final_score_171	:= 	woFDN_FLA_SD_lgt_171	;
self.final_score_172	:= 	woFDN_FLA_SD_lgt_172	;
self.final_score_173	:= 	woFDN_FLA_SD_lgt_173	;
self.final_score_174	:= 	woFDN_FLA_SD_lgt_174	;
self.final_score_175	:= 	woFDN_FLA_SD_lgt_175	;
self.final_score_176	:= 	woFDN_FLA_SD_lgt_176	;
self.final_score_177	:= 	woFDN_FLA_SD_lgt_177	;
self.final_score_178	:= 	woFDN_FLA_SD_lgt_178	;
self.final_score_179	:= 	woFDN_FLA_SD_lgt_179	;
self.final_score_180	:= 	woFDN_FLA_SD_lgt_180	;
self.final_score_181	:= 	woFDN_FLA_SD_lgt_181	;
self.final_score_182	:= 	woFDN_FLA_SD_lgt_182	;
self.final_score_183	:= 	woFDN_FLA_SD_lgt_183	;
self.final_score_184	:= 	woFDN_FLA_SD_lgt_184	;
self.final_score_185	:= 	woFDN_FLA_SD_lgt_185	;
self.final_score_186	:= 	woFDN_FLA_SD_lgt_186	;
self.final_score_187	:= 	woFDN_FLA_SD_lgt_187	;
self.final_score_188	:= 	woFDN_FLA_SD_lgt_188	;
self.final_score_189	:= 	woFDN_FLA_SD_lgt_189	;
self.final_score_190	:= 	woFDN_FLA_SD_lgt_190	;
self.final_score_191	:= 	woFDN_FLA_SD_lgt_191	;
self.final_score_192	:= 	woFDN_FLA_SD_lgt_192	;
self.final_score_193	:= 	woFDN_FLA_SD_lgt_193	;
self.final_score_194	:= 	woFDN_FLA_SD_lgt_194	;
self.final_score_195	:= 	woFDN_FLA_SD_lgt_195	;
self.final_score_196	:= 	woFDN_FLA_SD_lgt_196	;
self.final_score_197	:= 	woFDN_FLA_SD_lgt_197	;
self.final_score_198	:= 	woFDN_FLA_SD_lgt_198	;
self.final_score_199	:= 	woFDN_FLA_SD_lgt_199	;
self.final_score_200	:= 	woFDN_FLA_SD_lgt_200	;
self.final_score_201	:= 	woFDN_FLA_SD_lgt_201	;
self.final_score_202	:= 	woFDN_FLA_SD_lgt_202	;
self.final_score_203	:= 	woFDN_FLA_SD_lgt_203	;
self.final_score_204	:= 	woFDN_FLA_SD_lgt_204	;
self.final_score_205	:= 	woFDN_FLA_SD_lgt_205	;
self.final_score_206	:= 	woFDN_FLA_SD_lgt_206	;
self.final_score_207	:= 	woFDN_FLA_SD_lgt_207	;
self.final_score_208	:= 	woFDN_FLA_SD_lgt_208	;
self.final_score_209	:= 	woFDN_FLA_SD_lgt_209	;
self.final_score_210	:= 	woFDN_FLA_SD_lgt_210	;
self.final_score_211	:= 	woFDN_FLA_SD_lgt_211	;
self.final_score_212	:= 	woFDN_FLA_SD_lgt_212	;
self.final_score_213	:= 	woFDN_FLA_SD_lgt_213	;
self.final_score_214	:= 	woFDN_FLA_SD_lgt_214	;
self.final_score_215	:= 	woFDN_FLA_SD_lgt_215	;
self.final_score_216	:= 	woFDN_FLA_SD_lgt_216	;
self.final_score_217	:= 	woFDN_FLA_SD_lgt_217	;
self.final_score_218	:= 	woFDN_FLA_SD_lgt_218	;
self.final_score_219	:= 	woFDN_FLA_SD_lgt_219	;
self.final_score_220	:= 	woFDN_FLA_SD_lgt_220	;
self.final_score_221	:= 	woFDN_FLA_SD_lgt_221	;
self.final_score_222	:= 	woFDN_FLA_SD_lgt_222	;
self.final_score_223	:= 	woFDN_FLA_SD_lgt_223	;
self.final_score_224	:= 	woFDN_FLA_SD_lgt_224	;
self.final_score_225	:= 	woFDN_FLA_SD_lgt_225	;
self.final_score_226	:= 	woFDN_FLA_SD_lgt_226	;
self.final_score_227	:= 	woFDN_FLA_SD_lgt_227	;
self.final_score_228	:= 	woFDN_FLA_SD_lgt_228	;
self.final_score_229	:= 	woFDN_FLA_SD_lgt_229	;
self.final_score_230	:= 	woFDN_FLA_SD_lgt_230	;
self.final_score_231	:= 	woFDN_FLA_SD_lgt_231	;
self.final_score_232	:= 	woFDN_FLA_SD_lgt_232	;
self.final_score_233	:= 	woFDN_FLA_SD_lgt_233	;
self.final_score_234	:= 	woFDN_FLA_SD_lgt_234	;
self.final_score_235	:= 	woFDN_FLA_SD_lgt_235	;
self.final_score_236	:= 	woFDN_FLA_SD_lgt_236	;
self.final_score_237	:= 	woFDN_FLA_SD_lgt_237	;
self.final_score_238	:= 	woFDN_FLA_SD_lgt_238	;
self.final_score_239	:= 	woFDN_FLA_SD_lgt_239	;
self.final_score_240	:= 	woFDN_FLA_SD_lgt_240	;
self.final_score_241	:= 	woFDN_FLA_SD_lgt_241	;
self.final_score_242	:= 	woFDN_FLA_SD_lgt_242	;
self.final_score_243	:= 	woFDN_FLA_SD_lgt_243	;
self.final_score_244	:= 	woFDN_FLA_SD_lgt_244	;
self.final_score_245	:= 	woFDN_FLA_SD_lgt_245	;
self.final_score_246	:= 	woFDN_FLA_SD_lgt_246	;
self.final_score_247	:= 	woFDN_FLA_SD_lgt_247	;
self.final_score_248	:= 	woFDN_FLA_SD_lgt_248	;
self.final_score_249	:= 	woFDN_FLA_SD_lgt_249	;
self.final_score_250	:= 	woFDN_FLA_SD_lgt_250	;
self.final_score_251	:= 	woFDN_FLA_SD_lgt_251	;
self.final_score_252	:= 	woFDN_FLA_SD_lgt_252	;
self.final_score_253	:= 	woFDN_FLA_SD_lgt_253	;
self.final_score_254	:= 	woFDN_FLA_SD_lgt_254	;
self.final_score_255	:= 	woFDN_FLA_SD_lgt_255	;
self.final_score_256	:= 	woFDN_FLA_SD_lgt_256	;
self.final_score_257	:= 	woFDN_FLA_SD_lgt_257	;
self.final_score_258	:= 	woFDN_FLA_SD_lgt_258	;
self.final_score_259	:= 	woFDN_FLA_SD_lgt_259	;
self.final_score_260	:= 	woFDN_FLA_SD_lgt_260	;
self.final_score_261	:= 	woFDN_FLA_SD_lgt_261	;
self.final_score_262	:= 	woFDN_FLA_SD_lgt_262	;
self.final_score_263	:= 	woFDN_FLA_SD_lgt_263	;
self.final_score_264	:= 	woFDN_FLA_SD_lgt_264	;
self.final_score_265	:= 	woFDN_FLA_SD_lgt_265	;
self.final_score_266	:= 	woFDN_FLA_SD_lgt_266	;
self.final_score_267	:= 	woFDN_FLA_SD_lgt_267	;
self.final_score_268	:= 	woFDN_FLA_SD_lgt_268	;
self.final_score_269	:= 	woFDN_FLA_SD_lgt_269	;
self.final_score_270	:= 	woFDN_FLA_SD_lgt_270	;
self.final_score_271	:= 	woFDN_FLA_SD_lgt_271	;
self.final_score_272	:= 	woFDN_FLA_SD_lgt_272	;
self.final_score_273	:= 	woFDN_FLA_SD_lgt_273	;
self.final_score_274	:= 	woFDN_FLA_SD_lgt_274	;
self.final_score_275	:= 	woFDN_FLA_SD_lgt_275	;
self.final_score_276	:= 	woFDN_FLA_SD_lgt_276	;
self.final_score_277	:= 	woFDN_FLA_SD_lgt_277	;
self.final_score_278	:= 	woFDN_FLA_SD_lgt_278	;
self.final_score_279	:= 	woFDN_FLA_SD_lgt_279	;
self.final_score_280	:= 	woFDN_FLA_SD_lgt_280	;
self.final_score_281	:= 	woFDN_FLA_SD_lgt_281	;
self.final_score_282	:= 	woFDN_FLA_SD_lgt_282	;
self.final_score_283	:= 	woFDN_FLA_SD_lgt_283	;
self.final_score_284	:= 	woFDN_FLA_SD_lgt_284	;
self.final_score_285	:= 	woFDN_FLA_SD_lgt_285	;
self.final_score_286	:= 	woFDN_FLA_SD_lgt_286	;
self.final_score_287	:= 	woFDN_FLA_SD_lgt_287	;
self.final_score_288	:= 	woFDN_FLA_SD_lgt_288	;
self.final_score_289	:= 	woFDN_FLA_SD_lgt_289	;
self.final_score_290	:= 	woFDN_FLA_SD_lgt_290	;
self.final_score_291	:= 	woFDN_FLA_SD_lgt_291	;
self.final_score_292	:= 	woFDN_FLA_SD_lgt_292	;
self.final_score_293	:= 	woFDN_FLA_SD_lgt_293	;
self.final_score_294	:= 	woFDN_FLA_SD_lgt_294	;
self.final_score_295	:= 	woFDN_FLA_SD_lgt_295	;
self.final_score_296	:= 	woFDN_FLA_SD_lgt_296	;
self.final_score_297	:= 	woFDN_FLA_SD_lgt_297	;
self.final_score_298	:= 	woFDN_FLA_SD_lgt_298	;
self.final_score_299	:= 	woFDN_FLA_SD_lgt_299	;
self.final_score_300	:= 	woFDN_FLA_SD_lgt_300	;
self.final_score_301	:= 	woFDN_FLA_SD_lgt_301	;
self.final_score_302	:= 	woFDN_FLA_SD_lgt_302	;
self.final_score_303	:= 	woFDN_FLA_SD_lgt_303	;
self.final_score_304	:= 	woFDN_FLA_SD_lgt_304	;
self.final_score_305	:= 	woFDN_FLA_SD_lgt_305	;
self.final_score_306	:= 	woFDN_FLA_SD_lgt_306	;
self.final_score_307	:= 	woFDN_FLA_SD_lgt_307	;
self.final_score_308	:= 	woFDN_FLA_SD_lgt_308	;
self.final_score_309	:= 	woFDN_FLA_SD_lgt_309	;
self.final_score_310	:= 	woFDN_FLA_SD_lgt_310	;
self.final_score_311	:= 	woFDN_FLA_SD_lgt_311	;
self.final_score_312	:= 	woFDN_FLA_SD_lgt_312	;
self.final_score_313	:= 	woFDN_FLA_SD_lgt_313	;
self.final_score_314	:= 	woFDN_FLA_SD_lgt_314	;
self.final_score_315	:= 	woFDN_FLA_SD_lgt_315	;
self.final_score_316	:= 	woFDN_FLA_SD_lgt_316	;
self.final_score_317	:= 	woFDN_FLA_SD_lgt_317	;
self.final_score_318	:= 	woFDN_FLA_SD_lgt_318	;
self.final_score_319	:= 	woFDN_FLA_SD_lgt_319	;
self.final_score_320	:= 	woFDN_FLA_SD_lgt_320	;
self.final_score_321	:= 	woFDN_FLA_SD_lgt_321	;
self.final_score_322	:= 	woFDN_FLA_SD_lgt_322	;
self.final_score_323	:= 	woFDN_FLA_SD_lgt_323	;
self.final_score_324	:= 	woFDN_FLA_SD_lgt_324	;
self.final_score_325	:= 	woFDN_FLA_SD_lgt_325	;
self.final_score_326	:= 	woFDN_FLA_SD_lgt_326	;
self.final_score_327	:= 	woFDN_FLA_SD_lgt_327	;
self.final_score_328	:= 	woFDN_FLA_SD_lgt_328	;
self.final_score_329	:= 	woFDN_FLA_SD_lgt_329	;
self.final_score_330	:= 	woFDN_FLA_SD_lgt_330	;
self.final_score_331	:= 	woFDN_FLA_SD_lgt_331	;
self.final_score_332	:= 	woFDN_FLA_SD_lgt_332	;
self.final_score_333	:= 	woFDN_FLA_SD_lgt_333	;
self.final_score_334	:= 	woFDN_FLA_SD_lgt_334	;
self.final_score_335	:= 	woFDN_FLA_SD_lgt_335	;
self.final_score_336	:= 	woFDN_FLA_SD_lgt_336	;
self.final_score_337	:= 	woFDN_FLA_SD_lgt_337	;
self.final_score_338	:= 	woFDN_FLA_SD_lgt_338	;
self.final_score_339	:= 	woFDN_FLA_SD_lgt_339	;
self.final_score_340	:= 	woFDN_FLA_SD_lgt_340	;
self.final_score_341	:= 	woFDN_FLA_SD_lgt_341	;
self.final_score_342	:= 	woFDN_FLA_SD_lgt_342	;
self.final_score_343	:= 	woFDN_FLA_SD_lgt_343	;
self.final_score_344	:= 	woFDN_FLA_SD_lgt_344	;
self.final_score_345	:= 	woFDN_FLA_SD_lgt_345	;
self.final_score_346	:= 	woFDN_FLA_SD_lgt_346	;
self.final_adj_score0 :=  adj_FLA_SD_tree_0     ;
self.final_adj_score1 :=  adj_FLA_SD_tree_1     ;
self.final_adj_score2 :=  adj_FLA_SD_tree_2     ;
self.final_adj_score3 :=  adj_FLA_SD_tree_3     ;
self.final_adj_score4 :=  adj_FLA_SD_tree_4     ;
self.final_adj_score5 :=  adj_FLA_SD_tree_5     ;
self.final_adj_score6 :=  adj_FLA_SD_tree_6     ;
self.final_adj_score7 :=  adj_FLA_SD_tree_7     ;
self.final_adj_score8 :=  adj_FLA_SD_tree_8     ;
self.final_adj_score9 :=  adj_FLA_SD_tree_9     ;
self.final_adj_score10 :=  adj_FLA_SD_tree_10   ;
self.final_adj_score11 :=  adj_FLA_SD_tree_11   ;
self.final_adj_score12 :=  adj_FLA_SD_tree_12   ;
self.final_adj_score13 :=  adj_FLA_SD_tree_13   ;
self.final_adj_score14 :=  adj_FLA_SD_tree_14   ;
self.final_adj_score15 :=  adj_FLA_SD_tree_15   ;
self.final_adj_score16 :=  adj_FLA_SD_tree_16   ;
self.final_adj_score17 :=  adj_FLA_SD_tree_17   ;
self.final_adj_score18 :=  adj_FLA_SD_tree_18   ;
self.final_adj_score19 :=  adj_FLA_SD_tree_19   ;
self.final_adj_score20 :=  adj_FLA_SD_tree_20   ;
// self.woFDN_submodel_lgt	:= 	woFDN_FLA_SD_lgt	;
self.orig_FDN_FLA_SD_lgt := woFDN_FLA_SD_lgt;
self.adj_FDN_FLA_SD_lgt := adjusted_tree_score;
self.FP3_woFDN_LGT		:= 	FP3_woFDN_LGT	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
