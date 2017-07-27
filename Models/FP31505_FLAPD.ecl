
export FP31505_FLAPD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

NULL := -999999999;

// *** Here begins the actual tree code that came directly from the Modeler and is unchanged...

   woFDN_FLAP_D_lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FLAP_D_lgt_1 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 51.85) => 0.4570221840,
      (c_fammar_p > 51.85) => 0.0895795090,
      (c_fammar_p = NULL) => 0.1544508113, 0.1544508113),
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0356468688,
      (f_varrisktype_i > 3.5) => 0.1553929443,
      (f_varrisktype_i = NULL) => -0.0275430722, -0.0275430722),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0154603034, -0.0154603034),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.1926921169,
   (f_inq_Communications_count_i > 0.5) => 0.5856528605,
   (f_inq_Communications_count_i = NULL) => 0.3328252499, 0.3328252499),
(f_inq_HighRiskCredit_count_i = NULL) => 0.2204202967, -0.0011217040);

// Tree: 2 
woFDN_FLAP_D_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1268453419,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0370023321,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1649431690,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0325505912, -0.0325505912),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0236411006, -0.0236411006),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0487195739,
   (f_rel_under500miles_cnt_d > 5.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.1813839524,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.4653590976,
      (nf_seg_FraudPoint_3_0 = '') => 0.3343518973, 0.3343518973),
   (f_rel_under500miles_cnt_d = NULL) => 0.1040888163, 0.2027859090),
(f_varrisktype_i = NULL) => 0.1316883272, -0.0085272998);

// Tree: 3 
woFDN_FLAP_D_lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 4.05) => 
         map(
         (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 85) => 0.3522629324,
         (r_F01_inp_addr_address_score_d > 85) => 0.1133494592,
         (r_F01_inp_addr_address_score_d = NULL) => 0.1585621683, 0.1585621683),
      (C_INC_125K_P > 4.05) => 0.0098424745,
      (C_INC_125K_P = NULL) => -0.0419466398, 0.0276838752),
   (f_phone_ver_experian_d > 0.5) => -0.0505053277,
   (f_phone_ver_experian_d = NULL) => 0.0028164145, -0.0142319541),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.1140318383,
   (f_srchvelocityrisktype_i > 4.5) => 0.3282874702,
   (f_srchvelocityrisktype_i = NULL) => 0.2016599844, 0.2016599844),
(f_inq_Communications_count_i = NULL) => 0.1173649122, -0.0049465465);

// Tree: 4 
woFDN_FLAP_D_lgt_4 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0386482611,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 61.95) => 0.1640290880,
      (c_fammar_p > 61.95) => 0.0331215068,
      (c_fammar_p = NULL) => -0.0386027175, 0.0526537867),
   (f_corrrisktype_i = NULL) => -0.0249227326, -0.0249227326),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0356588198,
      (f_assocrisktype_i > 4.5) => 0.1849700048,
      (f_assocrisktype_i = NULL) => 0.0740442799, 0.0740442799),
   (f_varrisktype_i > 4.5) => 0.2682291174,
   (f_varrisktype_i = NULL) => 0.0949951718, 0.0949951718),
(f_srchvelocityrisktype_i = NULL) => 0.1134604197, -0.0075491031);

// Tree: 5 
woFDN_FLAP_D_lgt_5 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => -0.0308092672,
   (k_inq_ssns_per_addr_i > 2.5) => 0.1166535858,
   (k_inq_ssns_per_addr_i = NULL) => -0.0248579860, -0.0248579860),
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 27.25) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 0.0345004086,
      (f_inq_Communications_count_i > 1.5) => 0.1923157837,
      (f_inq_Communications_count_i = NULL) => 0.0606564285, 0.0454087512),
   (c_famotf18_p > 27.25) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.1670463722,
      (f_rel_felony_count_i > 1.5) => 0.3610315341,
      (f_rel_felony_count_i = NULL) => 0.2052243030, 0.2052243030),
   (c_famotf18_p = NULL) => -0.0354393603, 0.0638560549),
(nf_seg_FraudPoint_3_0 = '') => -0.0049401627, -0.0049401627);

// Tree: 6 
woFDN_FLAP_D_lgt_6 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0443220012,
      (r_D33_eviction_count_i > 0.5) => 0.2200308756,
      (r_D33_eviction_count_i = NULL) => 0.0651688168, 0.0651688168),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.2592863030,
   (f_inq_PrepaidCards_count_i = NULL) => 0.0880630718, 0.0880630718),
(r_I60_inq_comm_recency_d > 549) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0045335033,
      (f_rel_felony_count_i > 1.5) => 0.1719139777,
      (f_rel_felony_count_i = NULL) => 0.0141337824, 0.0141337824),
   (k_nap_phn_verd_d > 0.5) => -0.0428638050,
   (k_nap_phn_verd_d = NULL) => -0.0212280273, -0.0212280273),
(r_I60_inq_comm_recency_d = NULL) => 0.0711022259, -0.0095299122);

// Tree: 7 
woFDN_FLAP_D_lgt_7 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 31.05) => -0.0266471064,
   (c_famotf18_p > 31.05) => 0.0892930562,
   (c_famotf18_p = NULL) => -0.0292055658, -0.0196492051),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0235875172,
      (f_hh_payday_loan_users_i > 0.5) => 0.1807844306,
      (f_hh_payday_loan_users_i = NULL) => 0.0382137883, 0.0382137883),
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.2499665414,
      (f_phone_ver_experian_d > 0.5) => 0.0254421098,
      (f_phone_ver_experian_d = NULL) => 0.2268254805, 0.1823921767),
   (f_rel_felony_count_i = NULL) => 0.0653793644, 0.0653793644),
(f_varrisktype_i = NULL) => 0.0576905378, -0.0093782693);

// Tree: 8 
woFDN_FLAP_D_lgt_8 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1245266578,
      (f_phone_ver_experian_d > 0.5) => -0.0280043665,
      (f_phone_ver_experian_d = NULL) => 0.0828514734, 0.0692131280),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 61.65) => 0.0282755221,
      (c_fammar_p > 61.65) => -0.0440528876,
      (c_fammar_p = NULL) => -0.0594327792, -0.0338055674),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0234799936, -0.0234799936),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0460771237,
   (f_assocrisktype_i > 5.5) => 0.1434530812,
   (f_assocrisktype_i = NULL) => 0.0669476596, 0.0669476596),
(f_srchvelocityrisktype_i = NULL) => 0.0373379741, -0.0109758082);

// Tree: 9 
woFDN_FLAP_D_lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 59.25) => 0.0479696426,
      (c_fammar_p > 59.25) => -0.0292007004,
      (c_fammar_p = NULL) => -0.0413941078, -0.0183870746),
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.2828055874,
      (f_phone_ver_experian_d > 0.5) => 0.0332299189,
      (f_phone_ver_experian_d = NULL) => 0.0998342012, 0.1178540287),
   (k_inq_per_phone_i = NULL) => -0.0119512830, -0.0119512830),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1469154827,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1463070376,
   (k_nap_phn_verd_d > 0.5) => -0.0928630065,
   (k_nap_phn_verd_d = NULL) => 0.0743119733, 0.0743119733), -0.0061222907);

// Tree: 10 
woFDN_FLAP_D_lgt_10 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.15) => 0.0629934421,
      (c_unemp > 9.15) => 0.2363742004,
      (c_unemp = NULL) => -0.0409568448, 0.0701058995),
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => -0.0229956264,
      (f_rel_felony_count_i > 1.5) => 0.0884903815,
      (f_rel_felony_count_i = NULL) => -0.0184088969, -0.0184088969),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0128132599, -0.0128132599),
(f_srchfraudsrchcount_i > 8.5) => 0.1137218783,
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.9) => -0.0312490787,
   (c_pop_35_44_p > 15.9) => 0.1542720913,
   (c_pop_35_44_p = NULL) => 0.0561254078, 0.0561254078), -0.0080752729);

// Tree: 11 
woFDN_FLAP_D_lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3575001202,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => 0.0442455032,
         (r_D33_eviction_count_i > 1.5) => 0.2135261798,
         (r_D33_eviction_count_i = NULL) => 0.0543926799, 0.0543926799),
      (r_I60_inq_comm_recency_d > 549) => -0.0239512196,
      (r_I60_inq_comm_recency_d = NULL) => -0.0170126978, -0.0170126978),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0326196091, -0.0144117256),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1897662627,
   (f_phone_ver_experian_d > 0.5) => 0.0342355642,
   (f_phone_ver_experian_d = NULL) => 0.1990527367, 0.1176746855),
(k_inq_ssns_per_addr_i = NULL) => -0.0082681716, -0.0082681716);

// Tree: 12 
woFDN_FLAP_D_lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -12155) => 0.2113571172,
         (f_addrchangeincomediff_d > -12155) => 0.0628156479,
         (f_addrchangeincomediff_d = NULL) => 0.0548046623, 0.0676705524),
      (f_corrphonelastnamecount_d > 0.5) => -0.0285456405,
      (f_corrphonelastnamecount_d = NULL) => 0.0261287421, 0.0261287421),
   (f_phone_ver_experian_d > 0.5) => -0.0432712951,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 10.5) => -0.0125124924,
      (f_assocsuspicousidcount_i > 10.5) => 0.2876426295,
      (f_assocsuspicousidcount_i = NULL) => -0.0062179772, -0.0062179772), -0.0128118524),
(f_srchfraudsrchcount_i > 8.5) => 0.0941535727,
(f_srchfraudsrchcount_i = NULL) => 0.0346817231, -0.0090273283);

// Tree: 13 
woFDN_FLAP_D_lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 51.45) => 0.0631327498,
   (c_fammar_p > 51.45) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0172692956,
         (f_phone_ver_experian_d > 0.5) => -0.0423947380,
         (f_phone_ver_experian_d = NULL) => -0.0236125386, -0.0200425367),
      (f_inq_PrepaidCards_count_i > 1.5) => 0.1422703675,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0186071763, -0.0186071763),
   (c_fammar_p = NULL) => -0.0484041834, -0.0124152341),
(f_assocsuspicousidcount_i > 13.5) => 0.2126430375,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 71.6) => 0.1598740682,
   (c_fammar_p > 71.6) => -0.0150232396,
   (c_fammar_p = NULL) => 0.0507025003, 0.0507025003), -0.0094827236);

// Tree: 14 
woFDN_FLAP_D_lgt_14 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1016408708,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 20500) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 75000) => 0.1757362323,
      (r_L80_Inp_AVM_AutoVal_d > 75000) => 0.2720530067,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0356792012, 0.0876071126),
   (k_estimated_income_d > 20500) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0219532534,
      (k_inq_per_phone_i > 1.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 0.0223141775,
         (r_L79_adls_per_addr_c6_i > 2.5) => 0.1396802442,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0460935632, 0.0460935632),
      (k_inq_per_phone_i = NULL) => -0.0152677481, -0.0152677481),
   (k_estimated_income_d = NULL) => -0.0116633116, -0.0116633116),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0146438598, -0.0079610358);

// Tree: 15 
woFDN_FLAP_D_lgt_15 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 61.05) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0075947153,
      (f_idverrisktype_i > 1.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0566881012,
         (r_L79_adls_per_addr_c6_i > 4.5) => 0.2059643644,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0693153228, 0.0693153228),
      (f_idverrisktype_i = NULL) => 0.0390434693, 0.0390434693),
   (c_fammar_p > 61.05) => -0.0203682940,
   (c_fammar_p = NULL) => -0.0284784344, -0.0110697755),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.1435674243,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 70) => -0.0319210455,
   (c_burglary > 70) => 0.1289084136,
   (c_burglary = NULL) => 0.0645766299, 0.0645766299), -0.0082081965);

// Tree: 16 
woFDN_FLAP_D_lgt_16 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 0.0485568149,
         (f_srchaddrsrchcount_i > 14.5) => 0.2149440617,
         (f_srchaddrsrchcount_i = NULL) => 0.0531616280, 0.0531616280),
      (f_phone_ver_experian_d > 0.5) => -0.0324795016,
      (f_phone_ver_experian_d = NULL) => 0.0149682724, 0.0154741411),
   (f_corrphonelastnamecount_d > 0.5) => -0.0303885695,
   (f_corrphonelastnamecount_d = NULL) => -0.0100762874, -0.0100762874),
(r_D30_Derog_Count_i > 5.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.95) => 0.0765759170,
   (c_unemp > 7.95) => 0.2207243050,
   (c_unemp = NULL) => 0.0940056240, 0.0940056240),
(r_D30_Derog_Count_i = NULL) => 0.0184289188, -0.0046137359);

// Tree: 17 
woFDN_FLAP_D_lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0299172226,
      (f_varrisktype_i > 2.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 51.05) => 0.1221055864,
         (c_fammar_p > 51.05) => 0.0170717023,
         (c_fammar_p = NULL) => 0.0309258649, 0.0309258649),
      (f_varrisktype_i = NULL) => -0.0230158790, -0.0243399907),
   (k_nap_contradictory_i > 0.5) => 0.1302668033,
   (k_nap_contradictory_i = NULL) => -0.0218059022, -0.0218059022),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0422240226,
   (f_hh_payday_loan_users_i > 0.5) => 0.1337170958,
   (f_hh_payday_loan_users_i = NULL) => 0.0572413238, 0.0572413238),
(k_inq_per_addr_i = NULL) => -0.0130941938, -0.0130941938);

// Tree: 18 
woFDN_FLAP_D_lgt_18 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.0497299034,
(r_F01_inp_addr_address_score_d > 95) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 0.0508421064,
         (r_L79_adls_per_addr_c6_i > 3.5) => 0.3062331019,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.1153347820, 0.1153347820),
      (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0193480128,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0169325061, -0.0169325061),
   (k_inq_per_phone_i > 5.5) => 0.1248985489,
   (k_inq_per_phone_i = NULL) => -0.0147193599, -0.0147193599),
(r_F01_inp_addr_address_score_d = NULL) => 
   map(
   (NULL < c_unemp and c_unemp <= 4.15) => -0.0371474902,
   (c_unemp > 4.15) => 0.1476304661,
   (c_unemp = NULL) => 0.0393123538, 0.0393123538), -0.0074075219);

// Tree: 19 
woFDN_FLAP_D_lgt_19 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0171499380,
      (f_rel_felony_count_i > 1.5) => 0.1101735324,
      (f_rel_felony_count_i = NULL) => 0.0462223967, 0.0230579373),
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0538795588,
      (r_Phn_Cell_n > 0.5) => 0.3120175768,
      (r_Phn_Cell_n = NULL) => 0.1492783915, 0.1492783915),
   (k_inq_per_phone_i = NULL) => 0.0278713184, 0.0278713184),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0213950320,
   (r_D33_eviction_count_i > 2.5) => 0.1738462932,
   (r_D33_eviction_count_i = NULL) => -0.0972281305, -0.0202973275),
(k_nap_phn_verd_d = NULL) => -0.0019753948, -0.0019753948);

// Tree: 20 
woFDN_FLAP_D_lgt_20 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 0.1281059793,
      (r_F00_input_dob_match_level_d > 5.5) => -0.0222865653,
      (r_F00_input_dob_match_level_d = NULL) => -0.0188784050, -0.0188784050),
   (f_varrisktype_i > 2.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 162.5) => 0.0286793733,
      (f_curraddrcrimeindex_i > 162.5) => 0.1538297540,
      (f_curraddrcrimeindex_i = NULL) => 0.0472336449, 0.0472336449),
   (f_varrisktype_i = NULL) => 0.0020599797, -0.0124904786),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -3406.5) => 0.2065407478,
   (f_addrchangeincomediff_d > -3406.5) => 0.0440853900,
   (f_addrchangeincomediff_d = NULL) => 0.1088712479, 0.0630656133),
(k_inq_per_addr_i = NULL) => -0.0040860918, -0.0040860918);

// Tree: 21 
woFDN_FLAP_D_lgt_21 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1660401884,
      (f_attr_arrest_recency_d > 79.5) => -0.0172139630,
      (f_attr_arrest_recency_d = NULL) => -0.0159248374, -0.0159248374),
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < c_employees and c_employees <= 12.5) => 0.1731254035,
      (c_employees > 12.5) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 4.45) => -0.0092597204,
         (c_hval_125k_p > 4.45) => 0.0767381395,
         (c_hval_125k_p = NULL) => 0.0240252813, 0.0240252813),
      (c_employees = NULL) => 0.0342576426, 0.0342576426),
   (k_inq_per_addr_i = NULL) => -0.0105177126, -0.0105177126),
(f_assocsuspicousidcount_i > 16.5) => 0.1686717188,
(f_assocsuspicousidcount_i = NULL) => -0.0089921995, -0.0095763064);

// Tree: 22 
woFDN_FLAP_D_lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2080563847,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 2.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0232442884,
         (f_assocrisktype_i > 3.5) => 0.0270090120,
         (f_assocrisktype_i = NULL) => -0.0116502437, -0.0116502437),
      (f_inq_Communications_count_i > 2.5) => 
         map(
         (NULL < c_work_home and c_work_home <= 69.5) => 0.1631536261,
         (c_work_home > 69.5) => 0.0227920989,
         (c_work_home = NULL) => 0.0918223582, 0.0918223582),
      (f_inq_Communications_count_i = NULL) => -0.0100778906, -0.0100778906),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0090370558, -0.0090370558),
(r_D33_eviction_count_i > 2.5) => 0.1459290720,
(r_D33_eviction_count_i = NULL) => -0.0011481744, -0.0072495884);

// Tree: 23 
woFDN_FLAP_D_lgt_23 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 6.05) => 0.0029146359,
      (c_unemp > 6.05) => 0.0765704234,
      (c_unemp = NULL) => 0.0048332890, 0.0174991853),
   (k_inq_per_phone_i > 5.5) => 0.1832038219,
   (k_inq_per_phone_i = NULL) => 0.0203147564, 0.0203147564),
(f_phone_ver_experian_d > 0.5) => -0.0306727576,
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < c_business and c_business <= 2.5) => 0.1399621089,
   (c_business > 2.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0168613107,
      (f_assocrisktype_i > 8.5) => 0.1414334500,
      (f_assocrisktype_i = NULL) => 0.0140852029, -0.0086804044),
   (c_business = NULL) => -0.0826980483, 0.0000956058), -0.0077174532);

// Tree: 24 
woFDN_FLAP_D_lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => -0.0156885112,
   (c_unemp > 8.95) => 0.0697504601,
   (c_unemp = NULL) => -0.0350895050, -0.0123068164),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 60.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 76922) => 0.1559405879,
         (r_L80_Inp_AVM_AutoVal_d > 76922) => 0.0014420744,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0075909707, 0.0132423454),
      (k_comb_age_d > 60.5) => 0.1726317581,
      (k_comb_age_d = NULL) => 0.0298992570, 0.0298992570),
   (f_rel_felony_count_i > 0.5) => 0.1064601944,
   (f_rel_felony_count_i = NULL) => 0.0436960581, 0.0436960581),
(k_inq_per_addr_i = NULL) => -0.0062760772, -0.0062760772);

// Tree: 25 
woFDN_FLAP_D_lgt_25 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0074752124,
   (f_assocrisktype_i > 3.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => 0.0446641288,
      (f_phones_per_addr_curr_i > 8.5) => 0.1578139147,
      (f_phones_per_addr_curr_i = NULL) => 0.0614304534, 0.0614304534),
   (f_assocrisktype_i = NULL) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 65.5) => -0.0144686950,
      (c_bel_edu > 65.5) => 0.1315719584,
      (c_bel_edu = NULL) => 0.0606379268, 0.0606379268), 0.0226722167),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0260316477,
   (r_D33_eviction_count_i > 3.5) => 0.1178080454,
   (r_D33_eviction_count_i = NULL) => -0.0250359621, -0.0250359621),
(k_nap_phn_verd_d = NULL) => -0.0068478066, -0.0068478066);

// Tree: 26 
woFDN_FLAP_D_lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62494) => 0.0811561809,
   (f_addrchangevaluediff_d > -62494) => -0.0097574151,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => -0.0150859635,
      (f_phones_per_addr_curr_i > 4.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 51564.5) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.25802895045) => -0.0066360808,
            (f_add_curr_mobility_index_i > 0.25802895045) => 0.1940111439,
            (f_add_curr_mobility_index_i = NULL) => 0.1318752292, 0.1318752292),
         (f_curraddrmedianincome_d > 51564.5) => 0.0210385401,
         (f_curraddrmedianincome_d = NULL) => 0.0642216657, 0.0642216657),
      (f_phones_per_addr_curr_i = NULL) => 0.0102338864, 0.0102338864), -0.0034766014),
(r_D30_Derog_Count_i > 11.5) => 0.1127218876,
(r_D30_Derog_Count_i = NULL) => 0.0167626065, -0.0016142473);

// Tree: 27 
woFDN_FLAP_D_lgt_27 := map(
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0417375042,
(nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 50.45) => 0.0670827433,
   (c_fammar_p > 50.45) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 
         map(
         (NULL < f_adl_util_misc_n and f_adl_util_misc_n <= 0.5) => 0.0291050693,
         (f_adl_util_misc_n > 0.5) => 0.2190447655,
         (f_adl_util_misc_n = NULL) => 0.1154412949, 0.1154412949),
      (r_D33_Eviction_Recency_d > 48) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 146.5) => -0.0090184022,
         (c_span_lang > 146.5) => 0.0406055434,
         (c_span_lang = NULL) => 0.0057645655, 0.0057645655),
      (r_D33_Eviction_Recency_d = NULL) => 0.0100243484, 0.0076832069),
   (c_fammar_p = NULL) => -0.0180504887, 0.0124245816),
(nf_seg_FraudPoint_3_0 = '') => -0.0071864913, -0.0071864913);

// Tree: 28 
woFDN_FLAP_D_lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1246005502,
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.1593930954,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0126999326,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0117834880, -0.0117834880),
   (r_F00_dob_score_d = NULL) => 0.0043626404, -0.0078945434),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => 0.0397879413,
   (f_phones_per_addr_curr_i > 8.5) => 0.1534629634,
   (f_phones_per_addr_curr_i = NULL) => 0.0625229457, 0.0625229457),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 99.5) => -0.0317206647,
   (c_burglary > 99.5) => 0.0914165930,
   (c_burglary = NULL) => 0.0226712528, 0.0226712528), -0.0046816262);

// Tree: 29 
woFDN_FLAP_D_lgt_29 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1158718919,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0111639161,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0266654664, -0.0107846283),
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 175) => 0.0532705800,
      (c_sub_bus > 175) => 0.2500479735,
      (c_sub_bus = NULL) => 0.0719563583, 0.0719563583),
   (k_comb_age_d = NULL) => -0.0049570504, -0.0049570504),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 82.5) => 0.1700321325,
   (c_many_cars > 82.5) => 0.0403891669,
   (c_many_cars = NULL) => 0.1045688528, 0.1045688528),
(k_nap_contradictory_i = NULL) => -0.0030661420, -0.0030661420);

// Tree: 30 
woFDN_FLAP_D_lgt_30 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 12.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0194454276,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < c_employees and c_employees <= 20.5) => 0.1093776733,
      (c_employees > 20.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 127.5) => 0.0051381907,
         (r_C13_Curr_Addr_LRes_d > 127.5) => 0.1534889457,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0203384677, 0.0203384677),
      (c_employees = NULL) => -0.0239531627, 0.0235728043),
   (f_corrrisktype_i = NULL) => -0.0127619361, -0.0127619361),
(f_srchaddrsrchcount_i > 12.5) => 0.0539909691,
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 78.5) => -0.0722141792,
   (c_unempl > 78.5) => 0.0644319853,
   (c_unempl = NULL) => 0.0129678454, 0.0129678454), -0.0095268219);

// Tree: 31 
woFDN_FLAP_D_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0073666978,
      (f_assocsuspicousidcount_i > 15.5) => 0.1369819234,
      (f_assocsuspicousidcount_i = NULL) => -0.0065622169, -0.0065622169),
   (k_comb_age_d > 69.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 59.45) => 0.1954643580,
      (c_fammar_p > 59.45) => 0.0602435210,
      (c_fammar_p = NULL) => 0.0758860343, 0.0758860343),
   (k_comb_age_d = NULL) => -0.0013132234, -0.0013132234),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1708857286,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 105) => -0.0324755613,
   (c_assault > 105) => 0.0841719557,
   (c_assault = NULL) => 0.0113651162, 0.0113651162), -0.0004178405);

// Tree: 32 
woFDN_FLAP_D_lgt_32 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => -0.0078285208,
(f_phones_per_addr_curr_i > 8.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 12.5) => 0.0134917179,
   (f_rel_count_i > 12.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0489390914,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 44.5) => 0.2743124551,
         (f_prevaddrmurderindex_i > 44.5) => 0.0713886192,
         (f_prevaddrmurderindex_i = NULL) => 0.1328806907, 0.1328806907),
      (nf_seg_FraudPoint_3_0 = '') => 0.0804769219, 0.0804769219),
   (f_rel_count_i = NULL) => 0.0393344723, 0.0393344723),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.8) => 0.0749205917,
   (c_construction > 4.8) => -0.0401051768,
   (c_construction = NULL) => 0.0122462948, 0.0122462948), -0.0024585236);

// Tree: 33 
woFDN_FLAP_D_lgt_33 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 23.55) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 119.5) => 0.1814033089,
   (r_D32_Mos_Since_Fel_LS_d > 119.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0277060313,
      (f_crim_rel_under100miles_cnt_i > 0.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 0.0460392088,
         (r_C12_Num_NonDerogs_d > 2.5) => -0.0105336793,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0046395319, 0.0046395319),
      (f_crim_rel_under100miles_cnt_i = NULL) => 0.0565194164, -0.0115059121),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0326848364, -0.0108560751),
(c_famotf18_p > 23.55) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 0.1164602537,
   (f_prevaddrlenofres_d > 1.5) => 0.0233585313,
   (f_prevaddrlenofres_d = NULL) => 0.0308228707, 0.0308228707),
(c_famotf18_p = NULL) => -0.0432866850, -0.0061673299);

// Tree: 34 
woFDN_FLAP_D_lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1197572089,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1815780248,
         (r_F00_dob_score_d > 92) => 0.0351556137,
         (r_F00_dob_score_d = NULL) => 0.1335258471, 0.0440341671),
      (f_corrphonelastnamecount_d > 0.5) => -0.0143406593,
      (f_corrphonelastnamecount_d = NULL) => 0.0186061215, 0.0186061215),
   (f_phone_ver_experian_d > 0.5) => -0.0228267898,
   (f_phone_ver_experian_d = NULL) => -0.0094922276, -0.0065593622),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.3) => -0.0611944456,
   (c_hh4_p > 11.3) => 0.0748294583,
   (c_hh4_p = NULL) => 0.0196589238, 0.0196589238), -0.0055126279);

// Tree: 35 
woFDN_FLAP_D_lgt_35 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 34.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => 0.0073372600,
      (f_prevaddrageoldest_d > 151.5) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0809323484,
         (r_C23_inp_addr_occ_index_d > 2) => 0.2447447021,
         (r_C23_inp_addr_occ_index_d = NULL) => 0.1023282476, 0.1023282476),
      (f_prevaddrageoldest_d = NULL) => 0.0251095333, 0.0251095333),
   (c_born_usa > 34.5) => -0.0152557524,
   (c_born_usa = NULL) => 0.0086447919, -0.0060561956),
(f_hh_tot_derog_i > 5.5) => 0.0806909890,
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 24.95) => 0.0831522839,
   (C_RENTOCC_P > 24.95) => -0.0412768262,
   (C_RENTOCC_P = NULL) => 0.0142118310, 0.0142118310), -0.0032741145);

// Tree: 36 
woFDN_FLAP_D_lgt_36 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 1.55) => 0.0610458856,
   (c_hh7p_p > 1.55) => 0.2595876271,
   (c_hh7p_p = NULL) => 0.1099477924, 0.1099477924),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => -0.0190789426,
   (f_crim_rel_under500miles_cnt_i > 2.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 34.5) => 0.0292655092,
      (r_pb_order_freq_d > 34.5) => -0.0262459110,
      (r_pb_order_freq_d = NULL) => 0.0418239234, 0.0129477234),
   (f_crim_rel_under500miles_cnt_i = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 0.1933433415,
      (c_bigapt_p > 1.15) => -0.0129479148,
      (c_bigapt_p = NULL) => 0.0459924442, 0.0459924442), -0.0116041527),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0104888551, -0.0096341454);

// Tree: 37 
woFDN_FLAP_D_lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.05) => -0.0153684306,
   (c_unemp > 9.05) => 0.0605414227,
   (c_unemp = NULL) => -0.0113425792, -0.0120755261),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6742) => 0.0214092828,
   (f_addrchangeincomediff_d > 6742) => 0.1106574126,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 110.8) => -0.0306320950,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 110.8) => 0.1854663676,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0393457907, 0.0369018589), 0.0278941927),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0835926914,
   (k_comb_age_d > 26.5) => 0.0486448057,
   (k_comb_age_d = NULL) => 0.0006217146, 0.0006217146), 0.0004695069);

// Tree: 38 
woFDN_FLAP_D_lgt_38 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 123.5) => 0.0641566175,
   (f_fp_prevaddrburglaryindex_i > 123.5) => 0.2467396391,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.1058422389, 0.1058422389),
(r_F00_input_dob_match_level_d > 4.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0172996856,
      (f_inq_Other_count_i > 0.5) => 0.0239149792,
      (f_inq_Other_count_i = NULL) => -0.0079725823, -0.0079725823),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1202636528,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0072835892, -0.0072835892),
(r_F00_input_dob_match_level_d = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 114.5) => 0.0860844994,
   (c_employees > 114.5) => -0.0228383832,
   (c_employees = NULL) => 0.0187242957, 0.0187242957), -0.0049573778);

// Tree: 39 
woFDN_FLAP_D_lgt_39 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => -0.0073525900,
   (k_comb_age_d > 69.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1331939940,
      (f_phone_ver_experian_d > 0.5) => 0.0786669111,
      (f_phone_ver_experian_d = NULL) => -0.0585364262, 0.0676096722),
   (k_comb_age_d = NULL) => -0.0027737433, -0.0027737433),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 90.5) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.8087860432) => 0.0577886865,
      (f_add_input_nhood_SFD_pct_d > 0.8087860432) => 0.2205149742,
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.0997825672, 0.0997825672),
   (c_lux_prod > 90.5) => 0.0166341717,
   (c_lux_prod = NULL) => 0.0493137313, 0.0493137313),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0001005903, -0.0001005903);

// Tree: 40 
woFDN_FLAP_D_lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 55.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.0897465884,
   (r_F00_dob_score_d > 98) => -0.0088595166,
   (r_F00_dob_score_d = NULL) => 0.0055401889, -0.0059942164),
(f_addrchangecrimediff_i > 55.5) => 0.0777756037,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => -0.0044440701,
      (f_srchcomponentrisktype_i > 2.5) => 0.1170693930,
      (f_srchcomponentrisktype_i = NULL) => 
         map(
         (NULL < c_burglary and c_burglary <= 55) => -0.0722718963,
         (c_burglary > 55) => 0.0581586095,
         (c_burglary = NULL) => 0.0008964362, 0.0008964362), 0.0000326454),
   (k_nap_contradictory_i > 0.5) => 0.1351818191,
   (k_nap_contradictory_i = NULL) => 0.0039165081, 0.0039165081), -0.0024491566);

// Tree: 41 
woFDN_FLAP_D_lgt_41 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 0.0765145667,
   (r_D32_Mos_Since_Crim_LS_d > 14.5) => -0.0124859429,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.4) => -0.0653387131,
      (c_pop_35_44_p > 13.4) => 0.0485488305,
      (c_pop_35_44_p = NULL) => 0.0068435329, 0.0068435329), -0.0101686839),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0349651968,
      (r_Phn_Cell_n > 0.5) => 0.2027914694,
      (r_Phn_Cell_n = NULL) => 0.0929195931, 0.0929195931),
   (f_inq_count24_i > 2.5) => 0.0006185820,
   (f_inq_count24_i = NULL) => 0.0405869326, 0.0405869326),
(k_inq_per_phone_i = NULL) => -0.0075758862, -0.0075758862);

// Tree: 42 
woFDN_FLAP_D_lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1436519346,
(r_D32_Mos_Since_Fel_LS_d > 125) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0087199649,
      (f_srchfraudsrchcountmo_i > 0.5) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 0.0166688876,
         (r_F04_curr_add_occ_index_d > 2) => 0.1472829779,
         (r_F04_curr_add_occ_index_d = NULL) => 0.0524535699, 0.0524535699),
      (f_srchfraudsrchcountmo_i = NULL) => -0.0065335913, -0.0065335913),
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.25) => 0.1766336639,
      (c_pop_0_5_p > 8.25) => 0.0126627248,
      (c_pop_0_5_p = NULL) => 0.0778675427, 0.0778675427),
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0053587123, -0.0053587123),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0107988861, -0.0046044448);

// Tree: 43 
woFDN_FLAP_D_lgt_43 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => -0.0071777233,
(f_phones_per_addr_curr_i > 7.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.1283304213,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 23.35) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -68225) => 0.1298041463,
         (f_addrchangevaluediff_d > -68225) => 0.0088352404,
         (f_addrchangevaluediff_d = NULL) => 0.0306586335, 0.0173800076),
      (c_pop_35_44_p > 23.35) => 0.1599116963,
      (c_pop_35_44_p = NULL) => 0.0243074286, 0.0243074286),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0285237630, 0.0285237630),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 0.2) => -0.0662247852,
   (c_high_hval > 0.2) => 0.0606622358,
   (c_high_hval = NULL) => 0.0064013387, 0.0064013387), -0.0021287378);

// Tree: 44 
woFDN_FLAP_D_lgt_44 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 10.55) => 0.1492957836,
      (c_pop_25_34_p > 10.55) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 83275.5) => 0.1668494968,
         (f_curraddrmedianvalue_d > 83275.5) => 0.0186772996,
         (f_curraddrmedianvalue_d = NULL) => 0.0407194446, 0.0407194446),
      (c_pop_25_34_p = NULL) => 0.0737915479, 0.0737915479),
   (f_historical_count_d > 0.5) => -0.0011082314,
   (f_historical_count_d = NULL) => 0.0339484874, 0.0339484874),
(r_I60_inq_comm_recency_d > 549) => -0.0083357789,
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 91.5) => 0.0645934322,
   (c_many_cars > 91.5) => -0.0390360939,
   (c_many_cars = NULL) => 0.0087411551, 0.0087411551), -0.0042401034);

// Tree: 45 
woFDN_FLAP_D_lgt_45 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 2.05) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 139.5) => 0.0082796484,
      (c_serv_empl > 139.5) => 
         map(
         (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 4.5) => 0.0864818404,
         (f_rel_homeover200_count_d > 4.5) => 0.1867074081,
         (f_rel_homeover200_count_d = NULL) => 0.1243329856, 0.1243329856),
      (c_serv_empl = NULL) => 0.0443403856, 0.0443403856),
   (f_corraddrnamecount_d > 1.5) => -0.0106378072,
   (f_corraddrnamecount_d = NULL) => 0.0085190756, -0.0067851416),
(c_hh7p_p > 2.05) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 20.5) => 0.0262626870,
   (f_srchaddrsrchcount_i > 20.5) => 0.1431402960,
   (f_srchaddrsrchcount_i = NULL) => 0.0286681064, 0.0286681064),
(c_hh7p_p = NULL) => -0.0621753056, -0.0003558818);

// Tree: 46 
woFDN_FLAP_D_lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 87.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 80.5) => 0.0418835728,
         (f_prevaddrageoldest_d > 80.5) => 0.1752896078,
         (f_prevaddrageoldest_d = NULL) => 0.0755824931, 0.0755824931),
      (c_rest_indx > 87.5) => 0.0016405577,
      (c_rest_indx = NULL) => 0.0413256084, 0.0259258489),
   (r_F01_inp_addr_address_score_d > 95) => -0.0058499149,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0025060490, -0.0025060490),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 7.05) => 0.1864415957,
   (C_INC_25K_P > 7.05) => 0.0390748234,
   (C_INC_25K_P = NULL) => 0.0825182072, 0.0825182072),
(r_D32_felony_count_i = NULL) => -0.0203946901, -0.0016186475);

// Tree: 47 
woFDN_FLAP_D_lgt_47 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1525896315,
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0114716258,
      (f_srchvelocityrisktype_i > 4.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 0.0177767614,
         (k_comb_age_d > 66.5) => 0.2377220723,
         (k_comb_age_d = NULL) => 0.0258039626, 0.0258039626),
      (f_srchvelocityrisktype_i = NULL) => -0.0067171348, -0.0067171348),
   (f_hh_age_18_plus_d = NULL) => -0.0059389159, -0.0059389159),
(f_hh_tot_derog_i > 4.5) => 
   map(
   (NULL < c_med_yearblt and c_med_yearblt <= 1964.5) => 0.1229147686,
   (c_med_yearblt > 1964.5) => 0.0192457327,
   (c_med_yearblt = NULL) => 0.0519576263, 0.0519576263),
(f_hh_tot_derog_i = NULL) => -0.0131987464, -0.0030906008);

// Tree: 48 
woFDN_FLAP_D_lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 29850) => 0.0962819290,
   (r_A46_Curr_AVM_AutoVal_d > 29850) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 45.5) => 0.2232323521,
         (c_old_homes > 45.5) => 0.0188057079,
         (c_old_homes = NULL) => 0.1086829394, 0.1086829394),
      (r_C13_max_lres_d > 18.5) => -0.0029302603,
      (r_C13_max_lres_d = NULL) => -0.0009918984, -0.0009918984),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0160673654, -0.0063221941),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 29.55) => 0.0098482972,
   (c_rnt1000_p > 29.55) => 0.1319468233,
   (c_rnt1000_p = NULL) => 0.0441389547, 0.0441389547),
(k_inq_per_phone_i = NULL) => -0.0038319553, -0.0038319553);

// Tree: 49 
woFDN_FLAP_D_lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 0.0939451958,
      (r_F00_input_dob_match_level_d > 5.5) => -0.0019469836,
      (r_F00_input_dob_match_level_d = NULL) => -0.0000333183, -0.0000333183),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 33) => 0.1543994914,
      (r_C10_M_Hdr_FS_d > 33) => 0.0301952096,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0575108129, 0.0575108129),
   (f_varrisktype_i = NULL) => 0.0025163176, 0.0025163176),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0706833873,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 7.3) => 0.0754559660,
   (c_rnt500_p > 7.3) => -0.0626864176,
   (c_rnt500_p = NULL) => 0.0165280960, 0.0165280960), -0.0002204768);

// Tree: 50 
woFDN_FLAP_D_lgt_50 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_apt20 and c_apt20 <= 193.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -63331) => 0.1418838495,
         (f_addrchangevaluediff_d > -63331) => 0.0251555274,
         (f_addrchangevaluediff_d = NULL) => 0.0389274703, 0.0312876174),
      (c_apt20 > 193.5) => 0.1888327909,
      (c_apt20 = NULL) => 0.0102925458, 0.0352572834),
   (f_phone_ver_experian_d > 0.5) => -0.0208655075,
   (f_phone_ver_experian_d = NULL) => 0.0203048137, 0.0133735753),
(f_corrphonelastnamecount_d > 0.5) => -0.0160385905,
(f_corrphonelastnamecount_d = NULL) => 
   map(
   (NULL < c_young and c_young <= 21.05) => 0.0808567220,
   (c_young > 21.05) => -0.0358391637,
   (c_young = NULL) => 0.0152629562, 0.0152629562), -0.0028119630);

// Tree: 51 
woFDN_FLAP_D_lgt_51 := map(
(NULL < c_employees and c_employees <= 54.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 141.5) => 0.0090749325,
   (f_curraddrcartheftindex_i > 141.5) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 12.5) => 0.0466082438,
      (r_P88_Phn_Dst_to_Inp_Add_i > 12.5) => -0.0285161302,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 6.75) => 0.2438866898,
         (c_high_ed > 6.75) => 0.0784731086,
         (c_high_ed = NULL) => 0.1264687591, 0.1264687591), 0.0651658536),
   (f_curraddrcartheftindex_i = NULL) => 0.0257184813, 0.0257184813),
(c_employees > 54.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.0753734907,
   (r_D33_Eviction_Recency_d > 48) => -0.0110860021,
   (r_D33_Eviction_Recency_d = NULL) => -0.0195865722, -0.0101889901),
(c_employees = NULL) => -0.0258822447, -0.0046009805);

// Tree: 52 
woFDN_FLAP_D_lgt_52 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => -0.0061655399,
   (k_comb_age_d > 71.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 175) => 0.0485416181,
      (c_sub_bus > 175) => 0.2355837566,
      (c_sub_bus = NULL) => 0.0647217339, 0.0647217339),
   (k_comb_age_d = NULL) => -0.0027948441, -0.0027948441),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 4.75) => 0.0470009722,
   (c_femdiv_p > 4.75) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.26110471735) => 0.4257252007,
      (f_add_curr_mobility_index_i > 0.26110471735) => 0.0482948182,
      (f_add_curr_mobility_index_i = NULL) => 0.2281915426, 0.2281915426),
   (c_femdiv_p = NULL) => 0.1317038811, 0.1317038811),
(r_P85_Phn_Disconnected_i = NULL) => -0.0000804827, -0.0000804827);

// Tree: 53 
woFDN_FLAP_D_lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 136.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33631.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 2.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 4.5) => 0.0116026694,
         (r_D30_Derog_Count_i > 4.5) => 0.1198001731,
         (r_D30_Derog_Count_i = NULL) => 0.0212808865, 0.0212808865),
      (f_srchfraudsrchcountyr_i > 2.5) => 0.1456731231,
      (f_srchfraudsrchcountyr_i = NULL) => 0.0285348614, 0.0285348614),
   (f_curraddrmedianincome_d > 33631.5) => -0.0226942164,
   (f_curraddrmedianincome_d = NULL) => 0.0398061948, -0.0161878263),
(c_easiqlife > 136.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -16060.5) => 0.0899575449,
   (f_addrchangeincomediff_d > -16060.5) => 0.0131005486,
   (f_addrchangeincomediff_d = NULL) => 0.0402256684, 0.0209032300),
(c_easiqlife = NULL) => -0.0290601309, -0.0042993106);

// Tree: 54 
woFDN_FLAP_D_lgt_54 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 141.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 2.65) => -0.0509448237,
      (c_hh5_p > 2.65) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 9.5) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 143.5) => -0.0846053497,
            (c_span_lang > 143.5) => 0.0801352185,
            (c_span_lang = NULL) => -0.0242548445, -0.0242548445),
         (f_addrchangecrimediff_i > 9.5) => 0.1205273598,
         (f_addrchangecrimediff_i = NULL) => 0.0483009774, 0.0306273725),
      (c_hh5_p = NULL) => 0.0038091162, 0.0038091162),
   (f_prevaddrageoldest_d > 141.5) => 0.1231116220,
   (f_prevaddrageoldest_d = NULL) => 0.0232304544, 0.0232304544),
(r_F01_inp_addr_address_score_d > 25) => -0.0049736851,
(r_F01_inp_addr_address_score_d = NULL) => -0.0076207941, -0.0033867589);

// Tree: 55 
woFDN_FLAP_D_lgt_55 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1367732011,
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 65.5) => -0.0120443633,
      (k_comb_age_d > 65.5) => 
         map(
         (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 4.5) => 0.0298324987,
         (k_inq_per_addr_i > 4.5) => 0.1478977904,
         (k_inq_per_addr_i = NULL) => 0.0354454388, 0.0354454388),
      (k_comb_age_d = NULL) => -0.0072781937, -0.0072781937),
   (f_assoccredbureaucountnew_i > 0.5) => 0.0674101585,
   (f_assoccredbureaucountnew_i = NULL) => -0.0057023885, -0.0057023885),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 114) => -0.0468696370,
   (c_totcrime > 114) => 0.0540175015,
   (c_totcrime = NULL) => -0.0132405908, -0.0132405908), -0.0051278394);

// Tree: 56 
woFDN_FLAP_D_lgt_56 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
      map(
      (NULL < c_food and c_food <= 62.6) => 0.0066937259,
      (c_food > 62.6) => 0.1234069256,
      (c_food = NULL) => 0.0024356851, 0.0111509166),
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 3726) => 0.0687679039,
      (r_A49_Curr_AVM_Chg_1yr_i > 3726) => 0.2887031575,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0690737464, 0.1016800810),
   (r_L70_Add_Standardized_i = NULL) => 0.0188312291, 0.0188312291),
(f_phone_ver_experian_d > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => -0.0229918447,
   (f_inq_HighRiskCredit_count_i > 1.5) => 0.0720182603,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0196941360, -0.0196941360),
(f_phone_ver_experian_d = NULL) => -0.0103570775, -0.0053166819);

// Tree: 57 
woFDN_FLAP_D_lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 241.75) => -0.0111918800,
   (c_housingcpi > 241.75) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => 0.0765969994,
      (r_F03_address_match_d > 3) => 0.0044154813,
      (r_F03_address_match_d = NULL) => 0.0218781907, 0.0218781907),
   (c_housingcpi = NULL) => -0.0206613362, -0.0058343243),
(r_D30_Derog_Count_i > 11.5) => 0.0690188676,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => -0.0910673571,
   (k_comb_age_d > 24.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0329034664,
      (c_pop_35_44_p > 16.05) => 0.0947649031,
      (c_pop_35_44_p = NULL) => 0.0290714703, 0.0290714703),
   (k_comb_age_d = NULL) => -0.0065003613, -0.0065003613), -0.0048583215);

// Tree: 58 
woFDN_FLAP_D_lgt_58 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0094320493,
   (r_P85_Phn_Disconnected_i > 0.5) => 0.0837578418,
   (r_P85_Phn_Disconnected_i = NULL) => -0.0075373171, -0.0075373171),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 21.75) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 38.5) => 0.0887805095,
         (k_comb_age_d > 38.5) => 0.2691352860,
         (k_comb_age_d = NULL) => 0.1789578977, 0.1789578977),
      (c_lowrent > 21.75) => -0.0385895098,
      (c_lowrent = NULL) => 0.1108369923, 0.1108369923),
   (f_srchfraudsrchcount_i > 1.5) => 0.0157315137,
   (f_srchfraudsrchcount_i = NULL) => 0.0459308837, 0.0459308837),
(k_inq_per_phone_i = NULL) => -0.0048607457, -0.0048607457);

// Tree: 59 
woFDN_FLAP_D_lgt_59 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0070770050,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 6.5) => 0.0258160975,
      (f_rel_under25miles_cnt_d > 6.5) => 0.2525584764,
      (f_rel_under25miles_cnt_d = NULL) => 0.1013968905, 0.1013968905),
   (f_nae_nothing_found_i = NULL) => -0.0056094589, -0.0056094589),
(f_divaddrsuspidcountnew_i > 2.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.95) => -0.0235863471,
   (c_pop_35_44_p > 12.95) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.3487641756) => 0.1924009305,
      (f_add_input_nhood_MFD_pct_i > 0.3487641756) => 0.0637475887,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.1256917903, 0.1256917903),
   (c_pop_35_44_p = NULL) => 0.0694701541, 0.0694701541),
(f_divaddrsuspidcountnew_i = NULL) => -0.0218173535, -0.0039817624);

// Tree: 60 
woFDN_FLAP_D_lgt_60 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 50) => 0.2621649536,
   (f_curraddrmurderindex_i > 50) => 0.0133859355,
   (f_curraddrmurderindex_i = NULL) => 0.0810263137, 0.0810263137),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => -0.0110720034,
   (f_divaddrsuspidcountnew_i > 0.5) => 0.0208206228,
   (f_divaddrsuspidcountnew_i = NULL) => -0.0048812497, -0.0048812497),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => -0.1123249786,
   (k_comb_age_d > 24.5) => 
      map(
      (NULL < c_young and c_young <= 21.2) => 0.0811443390,
      (c_young > 21.2) => -0.0319823361,
      (c_young = NULL) => 0.0245810015, 0.0245810015),
   (k_comb_age_d = NULL) => -0.0162506066, -0.0162506066), -0.0035649090);

// Tree: 61 
woFDN_FLAP_D_lgt_61 := map(
(NULL < c_hhsize and c_hhsize <= 2.615) => -0.0160197412,
(c_hhsize > 2.615) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 85) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.25) => -0.0169873134,
      (c_pop_18_24_p > 7.25) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 138621) => 0.1623934670,
         (r_L80_Inp_AVM_AutoVal_d > 138621) => 0.0866524584,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 
            map(
            (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0032148229,
            (f_hh_criminals_i > 0.5) => 0.1725620153,
            (f_hh_criminals_i = NULL) => 0.0515180848, 0.0515180848), 0.0789473104),
      (c_pop_18_24_p = NULL) => 0.0490901060, 0.0490901060),
   (r_F01_inp_addr_address_score_d > 85) => 0.0121245102,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0019421917, 0.0144028006),
(c_hhsize = NULL) => -0.0461524054, -0.0021944725);

// Tree: 62 
woFDN_FLAP_D_lgt_62 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0855951147,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0775123713,
      (r_D33_Eviction_Recency_d > 30) => -0.0114066124,
      (r_D33_Eviction_Recency_d = NULL) => -0.0102269862, -0.0102269862),
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 0.0118761053,
      (k_nap_contradictory_i > 0.5) => 0.1264556047,
      (k_nap_contradictory_i = NULL) => 0.0130034721, 0.0130034721),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0003625340, -0.0003625340),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 241976.5) => -0.0201594860,
   (c_med_hval > 241976.5) => 0.1220322351,
   (c_med_hval = NULL) => 0.0379626774, 0.0379626774), 0.0005184762);

// Tree: 63 
woFDN_FLAP_D_lgt_63 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1095289907,
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0105816766,
      (f_prevaddrageoldest_d > 151.5) => 0.0256882284,
      (f_prevaddrageoldest_d = NULL) => -0.0019479554, -0.0019479554),
   (f_hh_age_18_plus_d = NULL) => -0.0013965368, -0.0013965368),
(f_inq_PrepaidCards_count24_i > 0.5) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0286281026) => -0.0273349490,
   (f_add_input_nhood_BUS_pct_i > 0.0286281026) => 0.0992839225,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0464019232, 0.0464019232),
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 105) => -0.0431820523,
   (c_assault > 105) => 0.0524842058,
   (c_assault = NULL) => -0.0047936812, -0.0047936812), -0.0007767158);

// Tree: 64 
woFDN_FLAP_D_lgt_64 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 
   map(
   (NULL < c_retail and c_retail <= 12.8) => -0.0035015864,
   (c_retail > 12.8) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 34.2) => 0.2074114985,
      (c_high_ed > 34.2) => 0.0245345157,
      (c_high_ed = NULL) => 0.1215388283, 0.1215388283),
   (c_retail = NULL) => 0.0467769020, 0.0467769020),
(r_C21_M_Bureau_ADL_FS_d > 8.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => -0.0067968683,
   (f_prevaddrageoldest_d > 271.5) => 0.0557981397,
   (f_prevaddrageoldest_d = NULL) => -0.0013502563, -0.0013502563),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 1.85) => -0.0519563524,
   (c_hh6_p > 1.85) => 0.0509743074,
   (c_hh6_p = NULL) => -0.0088541386, -0.0088541386), -0.0003536146);

// Tree: 65 
woFDN_FLAP_D_lgt_65 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 3.75) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 64.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => -0.0090150951,
      (f_assocsuspicousidcount_i > 16.5) => 0.0851037540,
      (f_assocsuspicousidcount_i = NULL) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.1053881150,
         (k_comb_age_d > 25.5) => 0.0399186074,
         (k_comb_age_d = NULL) => -0.0130145557, -0.0130145557), -0.0085038272),
   (k_comb_age_d > 64.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 21.55) => 0.1633670543,
      (c_white_col > 21.55) => 0.0282629813,
      (c_white_col = NULL) => 0.0383735657, 0.0383735657),
   (k_comb_age_d = NULL) => -0.0032248024, -0.0032248024),
(c_hh7p_p > 3.75) => 0.0353957570,
(c_hh7p_p = NULL) => -0.0170336454, 0.0013103958);

// Tree: 66 
woFDN_FLAP_D_lgt_66 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.365) => -0.0067150684,
   (c_hhsize > 4.365) => 0.1298252330,
   (c_hhsize = NULL) => -0.0054502026, -0.0054502026),
(c_hh3_p > 23.25) => 
   map(
   (NULL < c_larceny and c_larceny <= 182) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 39118.5) => 0.1072777978,
      (f_curraddrmedianincome_d > 39118.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.00885467455) => 0.0828458294,
         (f_add_input_nhood_VAC_pct_i > 0.00885467455) => -0.0084543514,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0308634440, 0.0308634440),
      (f_curraddrmedianincome_d = NULL) => 0.0401719478, 0.0401719478),
   (c_larceny > 182) => -0.0797182884,
   (c_larceny = NULL) => 0.0337670233, 0.0337670233),
(c_hh3_p = NULL) => -0.0129389892, 0.0003416002);

// Tree: 67 
woFDN_FLAP_D_lgt_67 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 38.55) => -0.0046725953,
   (c_hval_750k_p > 38.55) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 65500) => 0.1916490685,
      (k_estimated_income_d > 65500) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => -0.0089940727,
         (r_C14_Addr_Stability_v2_d > 4.5) => 0.0789430915,
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0350657305, 0.0350657305),
      (k_estimated_income_d = NULL) => 0.0430719582, 0.0430719582),
   (c_hval_750k_p = NULL) => 0.0042110235, -0.0005768295),
(r_D33_eviction_count_i > 3.5) => 0.0718169637,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 72.35) => 0.0715897761,
   (c_fammar_p > 72.35) => -0.0525935997,
   (c_fammar_p = NULL) => -0.0095433627, -0.0095433627), -0.0002247253);

// Tree: 68 
woFDN_FLAP_D_lgt_68 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.15) => -0.0058248389,
   (c_pop_6_11_p > 8.15) => 0.1718289726,
   (c_pop_6_11_p = NULL) => 0.0816354990, 0.0816354990),
(f_attr_arrest_recency_d > 99.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 306.5) => -0.0045564339,
   (r_C13_Curr_Addr_LRes_d > 306.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => 0.0418784011,
      (f_corrrisktype_i > 7.5) => 0.2006148942,
      (f_corrrisktype_i = NULL) => 0.0527902483, 0.0527902483),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0009812506, -0.0009812506),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.95) => -0.0431753414,
   (c_pop_35_44_p > 16.95) => 0.0605325818,
   (c_pop_35_44_p = NULL) => -0.0068102255, -0.0068102255), -0.0002209565);

// Tree: 69 
woFDN_FLAP_D_lgt_69 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0053254957,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < c_health and c_health <= 13.05) => 
         map(
         (NULL < f_rel_count_i and f_rel_count_i <= 7.5) => 0.0463443179,
         (f_rel_count_i > 7.5) => 0.2669977478,
         (f_rel_count_i = NULL) => 0.1597075479, 0.1597075479),
      (c_health > 13.05) => -0.0755060422,
      (c_health = NULL) => 0.0847332161, 0.0847332161),
   (f_nae_nothing_found_i = NULL) => -0.0041607875, -0.0041607875),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0984628411,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0283279247,
   (k_nap_phn_verd_d > 0.5) => -0.1069057588,
   (k_nap_phn_verd_d = NULL) => -0.0172564630, -0.0172564630), -0.0038753212);

// Tree: 70 
woFDN_FLAP_D_lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => -0.0095009914,
   (f_phones_per_addr_curr_i > 50.5) => 0.0794628852,
   (f_phones_per_addr_curr_i = NULL) => 0.0048805501, -0.0080151909),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => 0.0027969549,
   (r_C14_Addr_Stability_v2_d > 3.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 2997.5) => 0.0278481617,
      (r_A50_pb_total_dollars_d > 2997.5) => 
         map(
         (NULL < c_hval_1000k_p and c_hval_1000k_p <= 7.65) => 0.2635970161,
         (c_hval_1000k_p > 7.65) => 0.0488861090,
         (c_hval_1000k_p = NULL) => 0.1482299615, 0.1482299615),
      (r_A50_pb_total_dollars_d = NULL) => 0.0722458530, 0.0722458530),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0425967966, 0.0425967966),
(c_hval_750k_p = NULL) => 0.0104002867, -0.0037798496);

// Tree: 71 
woFDN_FLAP_D_lgt_71 := map(
(NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 36.15) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 0.1193744265,
         (r_I60_inq_banking_recency_d > 9) => 0.0229364693,
         (r_I60_inq_banking_recency_d = NULL) => 0.0299435718, 0.0299435718),
      (f_phone_ver_experian_d > 0.5) => -0.0067417361,
      (f_phone_ver_experian_d = NULL) => 0.0115979134, 0.0106592814),
   (c_hh3_p > 36.15) => 0.1319081885,
   (c_hh3_p = NULL) => -0.0375883396, 0.0106026395),
(k_inf_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.0817337859,
   (r_D33_Eviction_Recency_d > 79.5) => -0.0217584858,
   (r_D33_Eviction_Recency_d = NULL) => -0.0199786824, -0.0199786824),
(k_inf_phn_verd_d = NULL) => -0.0008560143, -0.0008560143);

// Tree: 72 
woFDN_FLAP_D_lgt_72 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i <= 48) => 
      map(
      (NULL < r_P85_Phn_Not_Issued_i and r_P85_Phn_Not_Issued_i <= 0.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
            map(
            (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0289459175,
            (f_phone_ver_experian_d > 0.5) => -0.0197243594,
            (f_phone_ver_experian_d = NULL) => 0.0080874377, 0.0071300760),
         (f_corrphonelastnamecount_d > 0.5) => -0.0173354310,
         (f_corrphonelastnamecount_d = NULL) => -0.0068930838, -0.0068930838),
      (r_P85_Phn_Not_Issued_i > 0.5) => -0.0734044780,
      (r_P85_Phn_Not_Issued_i = NULL) => -0.0084698974, -0.0084698974),
   (r_C12_NonDerog_Recency_i > 48) => 0.1329877881,
   (r_C12_NonDerog_Recency_i = NULL) => -0.0078772135, -0.0078772135),
(f_assocsuspicousidcount_i > 15.5) => 0.1019464447,
(f_assocsuspicousidcount_i = NULL) => -0.0195630897, -0.0074878395);

// Tree: 73 
woFDN_FLAP_D_lgt_73 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.15) => -0.0085992338,
   (c_pop_12_17_p > 10.15) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.1631338536,
      (r_C10_M_Hdr_FS_d > 13.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 138) => 0.0075852441,
         (f_curraddrcrimeindex_i > 138) => 
            map(
            (NULL < c_employees and c_employees <= 40.5) => 0.1629641612,
            (c_employees > 40.5) => 0.0359096714,
            (c_employees = NULL) => 0.0717455531, 0.0717455531),
         (f_curraddrcrimeindex_i = NULL) => 0.0178649513, 0.0178649513),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0207410805, 0.0207410805),
   (c_pop_12_17_p = NULL) => -0.0002758301, -0.0013646182),
(f_inq_PrepaidCards_count_i > 1.5) => 0.0712837038,
(f_inq_PrepaidCards_count_i = NULL) => -0.0074716914, -0.0006523213);

// Tree: 74 
woFDN_FLAP_D_lgt_74 := map(
(NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 0.0070382628,
   (k_inq_ssns_per_addr_i > 1.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 356) => 0.1529508971,
      (c_hh00 > 356) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 11.65) => 
            map(
            (NULL < c_hh3_p and c_hh3_p <= 11.75) => 0.1139095151,
            (c_hh3_p > 11.75) => -0.0272435692,
            (c_hh3_p = NULL) => 0.0045850674, 0.0045850674),
         (c_hval_200k_p > 11.65) => 0.1686688685,
         (c_hval_200k_p = NULL) => 0.0395952358, 0.0395952358),
      (c_hh00 = NULL) => 0.0587300589, 0.0587300589),
   (k_inq_ssns_per_addr_i = NULL) => 0.0154470310, 0.0154470310),
(f_prevaddrstatus_i > 2.5) => -0.0161788402,
(f_prevaddrstatus_i = NULL) => -0.0059170587, -0.0027773074);

// Tree: 75 
woFDN_FLAP_D_lgt_75 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0083444304,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.45) => -0.0150687331,
      (c_hval_125k_p > 4.45) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.10997263455) => 
            map(
            (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 0.0271362937,
            (f_sourcerisktype_i > 5.5) => 0.1847448004,
            (f_sourcerisktype_i = NULL) => 0.0576573061, 0.0576573061),
         (f_add_curr_nhood_VAC_pct_i > 0.10997263455) => 0.2541336718,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0854959192, 0.0854959192),
      (c_hval_125k_p = NULL) => 0.0308357786, 0.0308357786),
   (f_util_adl_count_n = NULL) => -0.0282138604, -0.0060462475),
(f_bus_addr_match_count_d > 52.5) => 0.1716414335,
(f_bus_addr_match_count_d = NULL) => -0.0049116237, -0.0049116237);

// Tree: 76 
woFDN_FLAP_D_lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0115647515,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => -0.0007596418,
         (f_prevaddrlenofres_d > 123.5) => 
            map(
            (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0450617552,
            (f_rel_homeover500_count_d > 3.5) => 0.1995906315,
            (f_rel_homeover500_count_d = NULL) => 0.0700741897, 0.0700741897),
         (f_prevaddrlenofres_d = NULL) => 0.0184201106, 0.0184201106),
      (f_nae_nothing_found_i > 0.5) => 0.1910079524,
      (f_nae_nothing_found_i = NULL) => 0.0212111518, 0.0212111518),
   (f_inq_Communications_count24_i > 1.5) => 0.1312547709,
   (f_inq_Communications_count24_i = NULL) => 0.0234925053, 0.0234925053),
(c_rnt1250_p = NULL) => 0.0002135994, -0.0015840236);

// Tree: 77 
woFDN_FLAP_D_lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27836.5) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 6.5) => -0.0025516312,
      (f_rel_homeover50_count_d > 6.5) => 0.0800041252,
      (f_rel_homeover50_count_d = NULL) => 0.0364299200, 0.0364299200),
   (f_curraddrmedianincome_d > 27836.5) => -0.0044822624,
   (f_curraddrmedianincome_d = NULL) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0392508010,
      (k_nap_phn_verd_d > 0.5) => -0.1083107207,
      (k_nap_phn_verd_d = NULL) => -0.0127074813, -0.0127074813), -0.0019474626),
(c_transport > 29.05) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.1730705266,
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0014236627,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0889299070, 0.0889299070),
(c_transport = NULL) => -0.0113185187, -0.0006710397);

// Tree: 78 
woFDN_FLAP_D_lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0468704202,
         (f_varrisktype_i > 2.5) => 0.1926743361,
         (f_varrisktype_i = NULL) => 0.1046892144, 0.1046892144),
      (r_C13_max_lres_d > 18.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 0.0010348619,
         (f_varrisktype_i > 4.5) => 0.0607699042,
         (f_varrisktype_i = NULL) => 0.0021291573, 0.0021291573),
      (r_C13_max_lres_d = NULL) => 0.0036554530, 0.0036554530),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0593554650,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0213757055, 0.0012378150),
(r_L77_Add_PO_Box_i > 0.5) => -0.1038277474,
(r_L77_Add_PO_Box_i = NULL) => -0.0012138528, -0.0012138528);

// Tree: 79 
woFDN_FLAP_D_lgt_79 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 2.5) => -0.0088135960,
(f_srchfraudsrchcount_i > 2.5) => 
   map(
   (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 0.0096485115,
   (r_I61_inq_collection_count12_i > 0.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.35) => -0.0609019606,
      (C_INC_200K_P > 0.35) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 55) => -0.0013068000,
         (f_curraddrcartheftindex_i > 55) => 
            map(
            (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.3377891311) => 0.0199166499,
            (f_add_curr_nhood_SFD_pct_d > 0.3377891311) => 0.1733881759,
            (f_add_curr_nhood_SFD_pct_d = NULL) => 0.1308883687, 0.1308883687),
         (f_curraddrcartheftindex_i = NULL) => 0.0869742202, 0.0869742202),
      (C_INC_200K_P = NULL) => 0.0642570098, 0.0642570098),
   (r_I61_inq_collection_count12_i = NULL) => 0.0187106412, 0.0187106412),
(f_srchfraudsrchcount_i = NULL) => -0.0184077230, -0.0044347263);

// Tree: 80 
woFDN_FLAP_D_lgt_80 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0096374235,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 27.5) => 0.1910428729,
      (c_born_usa > 27.5) => 0.0435343994,
      (c_born_usa = NULL) => 0.0733340910, 0.0733340910),
   (f_prevaddrlenofres_d > 3.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.0689469036,
      (r_F00_dob_score_d > 98) => 0.0069884088,
      (r_F00_dob_score_d = NULL) => 0.1322960946, 0.0113069288),
   (f_prevaddrlenofres_d = NULL) => 0.0159788215, 0.0159788215),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 6.35) => -0.0316464724,
   (c_hval_250k_p > 6.35) => 0.0628968424,
   (c_hval_250k_p = NULL) => 0.0153121277, 0.0153121277), -0.0012440042);

// Tree: 81 
woFDN_FLAP_D_lgt_81 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 22.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0065245682,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 28.15) => 
         map(
         (NULL < c_unempl and c_unempl <= 126.5) => 0.0467765524,
         (c_unempl > 126.5) => -0.0662016425,
         (c_unempl = NULL) => 0.0158648429, 0.0158648429),
      (c_rnt1000_p > 28.15) => 
         map(
         (NULL < c_professional and c_professional <= 2.45) => 0.2025990497,
         (c_professional > 2.45) => 0.0550165586,
         (c_professional = NULL) => 0.0944771177, 0.0944771177),
      (c_rnt1000_p = NULL) => 0.0403656686, 0.0403656686),
   (k_inq_per_phone_i = NULL) => -0.0042405489, -0.0042405489),
(f_srchphonesrchcount_i > 22.5) => -0.1174742716,
(f_srchphonesrchcount_i = NULL) => -0.0148607976, -0.0048978367);

// Tree: 82 
woFDN_FLAP_D_lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => -0.0087361485,
   (f_srchphonesrchcount_i > 1.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 0.0174481154,
      (f_inq_HighRiskCredit_count_i > 2.5) => 
         map(
         (NULL < c_no_car and c_no_car <= 134) => 0.1453798443,
         (c_no_car > 134) => -0.0238451601,
         (c_no_car = NULL) => 0.0847789981, 0.0847789981),
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0212298880, 0.0212298880),
   (f_srchphonesrchcount_i = NULL) => -0.0023750346, -0.0023750346),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0824892831,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0240753563,
   (k_nap_phn_verd_d > 0.5) => -0.1078169957,
   (k_nap_phn_verd_d = NULL) => -0.0230816858, -0.0230816858), -0.0032545865);

// Tree: 83 
woFDN_FLAP_D_lgt_83 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0122988333,
(f_srchaddrsrchcount_i > 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 3) => 0.0219916849,
      (c_hval_175k_p > 3) => 0.2177453193,
      (c_hval_175k_p = NULL) => 0.1109706096, 0.1109706096),
   (r_C10_M_Hdr_FS_d > 10.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0592518973,
         (f_corrphonelastnamecount_d > 0.5) => -0.0045037106,
         (f_corrphonelastnamecount_d = NULL) => 0.0307266610, 0.0307266610),
      (f_phone_ver_experian_d > 0.5) => -0.0021463757,
      (f_phone_ver_experian_d = NULL) => 0.0054475747, 0.0092160368),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0112383748, 0.0112383748),
(f_srchaddrsrchcount_i = NULL) => 0.0032287267, -0.0017032051);

// Tree: 84 
woFDN_FLAP_D_lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 309.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 67.5) => -0.0038040799,
   (f_bus_addr_match_count_d > 67.5) => 0.1976436443,
   (f_bus_addr_match_count_d = NULL) => -0.0027263619, -0.0027263619),
(r_C13_Curr_Addr_LRes_d > 309.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 0.0401633315,
   (f_srchunvrfdphonecount_i > 0.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 0.3715277146,
      (f_inq_count_i > 3.5) => 0.0146988215,
      (f_inq_count_i = NULL) => 0.1896149456, 0.1896149456),
   (f_srchunvrfdphonecount_i = NULL) => 0.0612769944, 0.0612769944),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0909808175,
   (k_comb_age_d > 25.5) => 0.0496993404,
   (k_comb_age_d = NULL) => 0.0030567212, 0.0030567212), 0.0010018099);

// Tree: 85 
woFDN_FLAP_D_lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 24.5) => -0.0539642800,
   (f_mos_inq_banko_om_fseen_d > 24.5) => -0.0061212655,
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0093218766, -0.0093218766),
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 8.5) => 0.0093885938,
      (f_inq_Collection_count_i > 8.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 10.8) => 0.0122056679,
         (c_hval_250k_p > 10.8) => 0.1772263444,
         (c_hval_250k_p = NULL) => 0.0850898000, 0.0850898000),
      (f_inq_Collection_count_i = NULL) => 0.0157186467, 0.0157186467),
   (r_F01_inp_addr_not_verified_i > 0.5) => 0.1206118739,
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0218131531, 0.0218131531),
(f_util_adl_count_n = NULL) => 0.0009079467, -0.0053601457);

// Tree: 86 
woFDN_FLAP_D_lgt_86 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 14.25) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30263) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.2938063876) => 0.0210588245,
         (f_add_input_nhood_MFD_pct_i > 0.2938063876) => 0.1315271706,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0792344624, 0.0792344624),
      (f_curraddrmedianincome_d > 30263) => 0.0300485955,
      (f_curraddrmedianincome_d = NULL) => 0.0349027898, 0.0349027898),
   (c_pop_18_24_p > 14.25) => -0.0478030138,
   (c_pop_18_24_p = NULL) => 0.0434602791, 0.0219892792),
(f_hh_members_ct_d > 1.5) => -0.0079651239,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0376302831,
   (c_construction > 7.45) => -0.0782825997,
   (c_construction = NULL) => -0.0073622175, -0.0073622175), -0.0021828896);

// Tree: 87 
woFDN_FLAP_D_lgt_87 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 48.5) => 0.2060627662,
   (c_exp_prod > 48.5) => 0.0260569570,
   (c_exp_prod = NULL) => 0.0634775195, 0.0634775195),
(r_F00_dob_score_d > 92) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2586) => -0.0119126021,
   (f_addrchangeincomediff_d > 2586) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 153.5) => 0.0227938597,
      (c_easiqlife > 153.5) => 0.2115955426,
      (c_easiqlife = NULL) => 0.0439858854, 0.0439858854),
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 375.5) => -0.0129428163,
      (r_C21_M_Bureau_ADL_FS_d > 375.5) => 0.1366622604,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0068810222, -0.0068810222), -0.0085226508),
(r_F00_dob_score_d = NULL) => -0.0064347047, -0.0066755954);

// Tree: 88 
woFDN_FLAP_D_lgt_88 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 107) => -0.0203817346,
   (c_rich_fam > 107) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 9.05) => 0.1947547225,
      (c_high_hval > 9.05) => 0.0453725167,
      (c_high_hval = NULL) => 0.1207365124, 0.1207365124),
   (c_rich_fam = NULL) => 0.0521373645, 0.0521373645),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0147798214,
   (f_crim_rel_under100miles_cnt_i > 0.5) => 0.0137143155,
   (f_crim_rel_under100miles_cnt_i = NULL) => -0.0041028200, -0.0014497515),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 16.35) => -0.0358713807,
   (c_retail > 16.35) => 0.0801525440,
   (c_retail = NULL) => 0.0058638440, 0.0058638440), -0.0004283129);

// Tree: 89 
woFDN_FLAP_D_lgt_89 := map(
(NULL < c_newhouse and c_newhouse <= 8.95) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 0.1208699994,
      (r_D32_Mos_Since_Crim_LS_d > 9.5) => 0.0076180451,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0258677877, 0.0098634624),
   (f_nae_nothing_found_i > 0.5) => 0.1477248689,
   (f_nae_nothing_found_i = NULL) => 0.0113784229, 0.0113784229),
(c_newhouse > 8.95) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 29.5) => -0.0123570760,
   (f_rel_under100miles_cnt_d > 29.5) => -0.0983169743,
   (f_rel_under100miles_cnt_d = NULL) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 39.65) => 0.0585246609,
      (c_high_ed > 39.65) => -0.0717675446,
      (c_high_ed = NULL) => 0.0121836187, 0.0121836187), -0.0130627719),
(c_newhouse = NULL) => 0.0086268573, -0.0022083545);

// Tree: 90 
woFDN_FLAP_D_lgt_90 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => 
      map(
      (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 118) => 0.0879971531,
      (r_D32_Mos_Since_Fel_LS_d > 118) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0052655887,
         (k_comb_age_d > 81.5) => 0.0934586625,
         (k_comb_age_d = NULL) => -0.0039223469, -0.0039223469),
      (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0034455396, -0.0034455396),
   (f_srchphonesrchcountwk_i > 0.5) => 0.0838284286,
   (f_srchphonesrchcountwk_i = NULL) => -0.0025771419, -0.0025771419),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0967074218,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 329.5) => -0.0558268259,
   (c_employees > 329.5) => 0.0353639875,
   (c_employees = NULL) => -0.0146643059, -0.0146643059), -0.0031453570);

// Tree: 91 
woFDN_FLAP_D_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.35) => -0.0198232000,
   (c_pop_65_74_p > 4.35) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 2.5) => 0.0409386076,
      (r_D30_Derog_Count_i > 2.5) => 0.2024446991,
      (r_D30_Derog_Count_i = NULL) => 0.1330475504, 0.1330475504),
   (c_pop_65_74_p = NULL) => 0.0711882235, 0.0711882235),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => -0.0086216256,
   (c_food > 65.55) => 0.0543706816,
   (c_food = NULL) => 0.0082072448, -0.0060358386),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 53.5) => -0.0646558113,
   (c_bel_edu > 53.5) => 0.0375411602,
   (c_bel_edu = NULL) => 0.0032468745, 0.0032468745), -0.0045981617);

// Tree: 92 
woFDN_FLAP_D_lgt_92 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => -0.0389272055,
   (f_mos_inq_banko_om_fseen_d > 21.5) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0947097730,
         (r_D33_Eviction_Recency_d > 30) => 0.0011114249,
         (r_D33_Eviction_Recency_d = NULL) => 0.0017531857, 0.0017531857),
      (r_D32_criminal_count_i > 10.5) => 0.1086126937,
      (r_D32_criminal_count_i = NULL) => 0.0024808827, 0.0024808827),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0309862871, -0.0007810365),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 9.55) => 0.1566821811,
   (c_newhouse > 9.55) => 0.0083022752,
   (c_newhouse = NULL) => 0.0660055719, 0.0660055719),
(k_nap_contradictory_i = NULL) => 0.0003614699, 0.0003614699);

// Tree: 93 
woFDN_FLAP_D_lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0018159124,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_food and c_food <= 18.7) => 0.1424317606,
         (c_food > 18.7) => -0.0014827348,
         (c_food = NULL) => 0.0780489600, 0.0780489600),
      (r_D33_eviction_count_i = NULL) => 0.0025627814, 0.0025627814),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 58.5) => 0.0994740883,
      (r_pb_order_freq_d > 58.5) => -0.0417318913,
      (r_pb_order_freq_d = NULL) => 0.1286429748, 0.0788717674),
   (f_curraddrcartheftindex_i = NULL) => 0.0046079620, 0.0039925615),
(c_cartheft > 189.5) => -0.0586644102,
(c_cartheft = NULL) => -0.0086140807, 0.0016911324);

// Tree: 94 
woFDN_FLAP_D_lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 118.5) => -0.0074303556,
      (c_sub_bus > 118.5) => 
         map(
         (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 0.1171905406,
         (r_F00_input_dob_match_level_d > 5.5) => 0.0200790366,
         (r_F00_input_dob_match_level_d = NULL) => 0.0436372789, 0.0227401142),
      (c_sub_bus = NULL) => 0.0049092403, 0.0049092403),
   (c_asian_lang > 181.5) => -0.0287142768,
   (c_asian_lang = NULL) => 0.0001074468, 0.0001074468),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 0.0180895939,
   (f_sourcerisktype_i > 5.5) => 0.1408665590,
   (f_sourcerisktype_i = NULL) => 0.0711292428, 0.0711292428),
(c_famotf18_p = NULL) => 0.0048720323, 0.0009431007);

// Tree: 95 
woFDN_FLAP_D_lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => -0.0097054103,
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 30.45) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 29862) => 0.1595819451,
      (f_curraddrmedianincome_d > 29862) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0000879697,
         (f_hh_collections_ct_i > 2.5) => 
            map(
            (NULL < c_high_ed and c_high_ed <= 27.35) => 0.0104774811,
            (c_high_ed > 27.35) => 0.2412265223,
            (c_high_ed = NULL) => 0.1105225199, 0.1105225199),
         (f_hh_collections_ct_i = NULL) => 0.0110745568, 0.0110745568),
      (f_curraddrmedianincome_d = NULL) => 0.0165262216, 0.0165262216),
   (C_INC_75K_P > 30.45) => 0.1821486098,
   (C_INC_75K_P = NULL) => 0.0238330917, 0.0238330917),
(c_rnt1000_p = NULL) => -0.0193577729, -0.0057848544);

// Tree: 96 
woFDN_FLAP_D_lgt_96 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 32768.5) => 
   map(
   (NULL < c_young and c_young <= 23.7) => -0.0311253252,
   (c_young > 23.7) => 0.1339647131,
   (c_young = NULL) => 0.0584448020, 0.0584448020),
(r_L80_Inp_AVM_AutoVal_d > 32768.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -26.5) => 0.0769650342,
   (f_addrchangecrimediff_i > -26.5) => -0.0054894042,
   (f_addrchangecrimediff_i = NULL) => 0.0122689303, -0.0008616785),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => -0.0099115986,
   (f_rel_felony_count_i > 2.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 0.0041818000,
      (c_bigapt_p > 1.15) => 0.1532476739,
      (c_bigapt_p = NULL) => 0.0680671745, 0.0680671745),
   (f_rel_felony_count_i = NULL) => -0.0227170711, -0.0084626560), -0.0033604638);

// Tree: 97 
woFDN_FLAP_D_lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.55) => -0.0060175911,
   (c_unemp > 8.55) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 68391) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 102.5) => 0.1808329374,
         (c_blue_empl > 102.5) => 0.0129011534,
         (c_blue_empl = NULL) => 0.1020684724, 0.1020684724),
      (r_A46_Curr_AVM_AutoVal_d > 68391) => -0.0106888324,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0350510124, 0.0294536818),
   (c_unemp = NULL) => 0.0211006045, -0.0032708680),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 11.5) => 0.1363910371,
   (f_rel_under500miles_cnt_d > 11.5) => -0.0040709700,
   (f_rel_under500miles_cnt_d = NULL) => 0.0569047850, 0.0569047850),
(r_D33_eviction_count_i = NULL) => -0.0172111248, -0.0028556253);

// Tree: 98 
woFDN_FLAP_D_lgt_98 := map(
(NULL < c_hh4_p and c_hh4_p <= 10.15) => -0.0202006957,
(c_hh4_p > 10.15) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0000362140,
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < c_preschl and c_preschl <= 178.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 10.8) => 
            map(
            (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 7.5) => -0.0056568840,
            (f_rel_homeover100_count_d > 7.5) => 0.1008719674,
            (f_rel_homeover100_count_d = NULL) => 0.0510281929, 0.0510281929),
         (c_incollege > 10.8) => -0.0883667984,
         (c_incollege = NULL) => 0.0295215371, 0.0295215371),
      (c_preschl > 178.5) => 0.1377139377,
      (c_preschl = NULL) => 0.0459514008, 0.0459514008),
   (f_phones_per_addr_curr_i = NULL) => 0.0278322636, 0.0036567011),
(c_hh4_p = NULL) => -0.0153008368, -0.0043345036);

// Tree: 99 
woFDN_FLAP_D_lgt_99 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.38111460565) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0093822415,
      (f_util_add_curr_conv_n > 0.5) => 0.0220522643,
      (f_util_add_curr_conv_n = NULL) => 0.0080555210, 0.0080555210),
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 1.3) => -0.0053101783,
      (c_high_hval > 1.3) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0791032922,
         (f_corrrisktype_i > 6.5) => 0.2340593130,
         (f_corrrisktype_i = NULL) => 0.1565813026, 0.1565813026),
      (c_high_hval = NULL) => 0.0873104286, 0.0873104286),
   (r_P85_Phn_Disconnected_i = NULL) => 0.0096661779, 0.0096661779),
(f_add_input_mobility_index_i > 0.38111460565) => -0.0261648690,
(f_add_input_mobility_index_i = NULL) => 0.0164996246, 0.0037130204);

// Tree: 100 
woFDN_FLAP_D_lgt_100 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.75) => -0.0797009430,
(C_OWNOCC_P > 1.75) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < c_transport and c_transport <= 26.6) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 43715.5) => 
            map(
            (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 0.0815132329,
            (r_Ever_Asset_Owner_d > 0.5) => 0.0051940219,
            (r_Ever_Asset_Owner_d = NULL) => 0.0363524436, 0.0363524436),
         (f_prevaddrmedianincome_d > 43715.5) => -0.0031341902,
         (f_prevaddrmedianincome_d = NULL) => 0.0051621854, 0.0051621854),
      (c_transport > 26.6) => 0.1441336201,
      (c_transport = NULL) => 0.0077900950, 0.0077900950),
   (f_historical_count_d > 0.5) => -0.0174797217,
   (f_historical_count_d = NULL) => 0.0120076111, -0.0050221776),
(C_OWNOCC_P = NULL) => 0.0162503721, -0.0056206268);

// Tree: 101 
woFDN_FLAP_D_lgt_101 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 2.55) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => -0.0250452468,
      (r_D34_UnRel_Lien60_Count_i > 0.5) => -0.1432613117,
      (r_D34_UnRel_Lien60_Count_i = NULL) => -0.0337623434, -0.0337623434),
   (C_INC_125K_P > 2.55) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.0325653089,
      (k_estimated_income_d > 26500) => -0.0027591048,
      (k_estimated_income_d = NULL) => -0.0094765017, -0.0009669058),
   (C_INC_125K_P = NULL) => 0.0086403163, -0.0028172391),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 303) => -0.0210777550,
   (r_C13_max_lres_d > 303) => 0.2240872133,
   (r_C13_max_lres_d = NULL) => 0.0946522921, 0.0946522921),
(k_comb_age_d = NULL) => -0.0015646742, -0.0015646742);

// Tree: 102 
woFDN_FLAP_D_lgt_102 := map(
(NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 4.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 6.35) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 163312.5) => 0.1284455026,
      (r_A46_Curr_AVM_AutoVal_d > 163312.5) => 0.0053724890,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => 0.1060809881,
         (f_crim_rel_under500miles_cnt_i > 0.5) => 0.2090291152,
         (f_crim_rel_under500miles_cnt_i = NULL) => 0.1558101681, 0.1558101681), 0.0845091193),
   (c_vacant_p > 6.35) => -0.0069559381,
   (c_vacant_p = NULL) => 0.0383437906, 0.0383437906),
(r_I60_inq_banking_recency_d > 4.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 68.3) => 0.0000467614,
   (c_low_hval > 68.3) => -0.0982095998,
   (c_low_hval = NULL) => 0.0235891740, -0.0003014935),
(r_I60_inq_banking_recency_d = NULL) => -0.0079672076, 0.0015601834);

// Tree: 103 
woFDN_FLAP_D_lgt_103 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => 
      map(
      (NULL < c_rnt2001_p and c_rnt2001_p <= 78.75) => -0.0162827206,
      (c_rnt2001_p > 78.75) => 0.2164437421,
      (c_rnt2001_p = NULL) => 0.0291575722, -0.0129477172),
   (f_crim_rel_under25miles_cnt_i > 0.5) => 0.0140521727,
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0013097045, -0.0015230824),
(f_srchaddrsrchcount_i > 32.5) => -0.0890519475,
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.45) => -0.0748217922,
   (c_pop_35_44_p > 13.45) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 4.15) => 0.1094965214,
      (c_femdiv_p > 4.15) => -0.0068816029,
      (c_femdiv_p = NULL) => 0.0535455001, 0.0535455001),
   (c_pop_35_44_p = NULL) => 0.0056010897, 0.0056010897), -0.0020081054);

// Tree: 104 
woFDN_FLAP_D_lgt_104 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0033999986,
(k_inq_per_phone_i > 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity','6: Other']) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.85) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 5.95) => 0.0619471108,
         (c_famotf18_p > 5.95) => -0.0452549179,
         (c_famotf18_p = NULL) => -0.0077178161, -0.0077178161),
      (c_incollege > 6.85) => 0.0586387768,
      (c_incollege = NULL) => 0.0190066199, 0.0190066199),
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1039) => 0.0545137650,
      (c_med_rent > 1039) => 0.2356250117,
      (c_med_rent = NULL) => 0.1182149621, 0.1182149621),
   (nf_seg_FraudPoint_3_0 = '') => 0.0307570515, 0.0307570515),
(k_inq_per_phone_i = NULL) => -0.0000125671, -0.0000125671);

// Tree: 105 
woFDN_FLAP_D_lgt_105 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 6.05) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 42727) => 0.2168389670,
      (f_prevaddrmedianincome_d > 42727) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.245) => -0.0263579063,
         (c_hhsize > 2.245) => 0.1470667548,
         (c_hhsize = NULL) => 0.0577889707, 0.0577889707),
      (f_prevaddrmedianincome_d = NULL) => 0.1009792714, 0.1009792714),
   (c_pop_12_17_p > 6.05) => 0.0086625839,
   (c_pop_12_17_p = NULL) => 0.0180548917, 0.0320114411),
(f_corraddrnamecount_d > 1.5) => -0.0040646353,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 88.5) => -0.0560160985,
   (c_serv_empl > 88.5) => 0.0539096159,
   (c_serv_empl = NULL) => -0.0026697959, -0.0026697959), -0.0012773205);

// Tree: 106 
woFDN_FLAP_D_lgt_106 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 55.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 198.5) => 0.2114046395,
   (f_M_Bureau_ADL_FS_all_d > 198.5) => -0.0096119920,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0760533690, 0.0760533690),
(f_mos_liens_unrel_SC_fseen_d > 55.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 21.55) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => -0.0726831499,
      (r_D33_Eviction_Recency_d > 79.5) => -0.0086093429,
      (r_D33_Eviction_Recency_d = NULL) => -0.0097409340, -0.0097409340),
   (c_hh3_p > 21.55) => 0.0197766422,
   (c_hh3_p = NULL) => -0.0312796769, -0.0038535853),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 18.45) => -0.0453488956,
   (c_rnt1000_p > 18.45) => 0.0616136901,
   (c_rnt1000_p = NULL) => 0.0049447705, 0.0049447705), -0.0029175108);

// Tree: 107 
woFDN_FLAP_D_lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0999599182,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0054421489,
   (f_addrchangecrimediff_i > 61.5) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 83.5) => 0.1701742962,
      (c_old_homes > 83.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.05567917035) => -0.0885571894,
         (f_add_input_nhood_VAC_pct_i > 0.05567917035) => 0.0736615824,
         (f_add_input_nhood_VAC_pct_i = NULL) => -0.0137954946, -0.0137954946),
      (c_old_homes = NULL) => 0.0464519223, 0.0464519223),
   (f_addrchangecrimediff_i = NULL) => 0.0075821059, -0.0019257093),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 16.75) => -0.0188906334,
   (c_hh4_p > 16.75) => 0.0922383196,
   (c_hh4_p = NULL) => 0.0252564849, 0.0252564849), -0.0011689350);

// Tree: 108 
woFDN_FLAP_D_lgt_108 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 0.0001534571,
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 
      map(
      (NULL < c_employees and c_employees <= 31.5) => 0.1606238281,
      (c_employees > 31.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 11.15) => 0.0151927102,
         (c_hval_150k_p > 11.15) => 
            map(
            (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.55) => 0.2354626870,
            (c_pop_6_11_p > 8.55) => 0.0439351020,
            (c_pop_6_11_p = NULL) => 0.1330944950, 0.1330944950),
         (c_hval_150k_p = NULL) => 0.0421682665, 0.0421682665),
      (c_employees = NULL) => 0.0563582557, 0.0563582557),
   (k_inf_lname_verd_d > 0.5) => -0.0396546280,
   (k_inf_lname_verd_d = NULL) => 0.0282145515, 0.0282145515),
(f_srchcomponentrisktype_i = NULL) => -0.0166473422, 0.0017409777);

// Tree: 109 
woFDN_FLAP_D_lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 12.5) => 0.0081592847,
   (f_inq_HighRiskCredit_count_i > 12.5) => 0.0827725523,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0085510044, 0.0085510044),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 21.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => -0.0046601041,
      (f_srchvelocityrisktype_i > 2.5) => -0.1366974126,
      (f_srchvelocityrisktype_i = NULL) => -0.0866440538, -0.0866440538),
   (f_mos_inq_banko_cm_lseen_d > 21.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 20.5) => 0.0609571050,
      (r_C13_Curr_Addr_LRes_d > 20.5) => -0.0381140990,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0070103489, -0.0070103489),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0315253527, -0.0315253527),
(r_D33_eviction_count_i = NULL) => 0.0116472874, 0.0070266963);

// Tree: 110 
woFDN_FLAP_D_lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 121.5) => -0.0073064228,
(f_prevaddrageoldest_d > 121.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 64.85) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 122.5) => 0.1579517464,
         (f_prevaddrlenofres_d > 122.5) => 0.0338284234,
         (f_prevaddrlenofres_d = NULL) => 0.0398063417, 0.0398063417),
      (c_high_hval > 64.85) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 34.5) => 0.3764913039,
         (c_born_usa > 34.5) => 0.0524413322,
         (c_born_usa = NULL) => 0.1909465620, 0.1909465620),
      (c_high_hval = NULL) => 0.0546099652, 0.0546099652),
   (f_corrphonelastnamecount_d > 0.5) => -0.0026240695,
   (f_corrphonelastnamecount_d = NULL) => 0.0170740399, 0.0170740399),
(f_prevaddrageoldest_d = NULL) => -0.0168087972, -0.0001178529);

// Tree: 111 
woFDN_FLAP_D_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.75) => 0.1930915436,
   (r_C12_source_profile_d > 57.75) => -0.0147493943,
   (r_C12_source_profile_d = NULL) => 0.0875215434, 0.0875215434),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 0.0021509254,
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 5.1) => 0.1879057706,
      (C_INC_200K_P > 5.1) => -0.0326469521,
      (C_INC_200K_P = NULL) => 0.0835220393, 0.0835220393),
   (f_hh_lienholders_i = NULL) => 0.0030244006, 0.0030244006),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 17.75) => -0.0599223339,
   (c_hh4_p > 17.75) => 0.0388289852,
   (c_hh4_p = NULL) => -0.0228905892, -0.0228905892), 0.0035184492);

// Tree: 112 
woFDN_FLAP_D_lgt_112 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_adl_util_inf_n and f_adl_util_inf_n <= 0.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00718649775) => 0.0886329318,
      (f_add_input_nhood_MFD_pct_i > 0.00718649775) => 0.0040743191,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0078813061, 0.0104751530),
   (f_adl_util_inf_n > 0.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 51930.5) => 0.2397741573,
      (f_prevaddrmedianincome_d > 51930.5) => 0.0206357832,
      (f_prevaddrmedianincome_d = NULL) => 0.0973961176, 0.0973961176),
   (f_adl_util_inf_n = NULL) => 0.0128771844, 0.0128771844),
(f_phone_ver_insurance_d > 3.5) => -0.0173797771,
(f_phone_ver_insurance_d = NULL) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 127.5) => 0.0786434568,
   (c_ab_av_edu > 127.5) => -0.0234070775,
   (c_ab_av_edu = NULL) => 0.0384816337, 0.0384816337), -0.0012919302);

// Tree: 113 
woFDN_FLAP_D_lgt_113 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 21.5) => -0.0996426998,
(f_mos_inq_banko_am_fseen_d > 21.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 946) => -0.0024309681,
   (f_addrchangevaluediff_d > 946) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 10.65) => 0.0099737493,
      (c_hval_150k_p > 10.65) => 0.1352503619,
      (c_hval_150k_p = NULL) => 0.0375202320, 0.0375202320),
   (f_addrchangevaluediff_d = NULL) => -0.0056219825, -0.0014053729),
(f_mos_inq_banko_am_fseen_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.4) => -0.0566681339,
   (c_pop_35_44_p > 13.4) => 
      map(
      (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0965542071,
      (k_nap_lname_verd_d > 0.5) => 0.0063025200,
      (k_nap_lname_verd_d = NULL) => 0.0514283636, 0.0514283636),
   (c_pop_35_44_p = NULL) => 0.0149189505, 0.0149189505), -0.0028322900);

// Tree: 114 
woFDN_FLAP_D_lgt_114 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0054975278) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 40.5) => 0.0175185487,
      (c_no_car > 40.5) => 0.2502498013,
      (c_no_car = NULL) => 0.1310914000, 0.1310914000),
   (f_hh_age_18_plus_d > 1.5) => 0.0219855369,
   (f_hh_age_18_plus_d = NULL) => 0.0395832568, 0.0395832568),
(f_add_input_nhood_MFD_pct_i > 0.0054975278) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0089002305,
   (k_inq_adls_per_addr_i > 3.5) => -0.0659220897,
   (k_inq_adls_per_addr_i = NULL) => -0.0101624410, -0.0101624410),
(f_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 18.5) => -0.0082063828,
   (f_srchaddrsrchcount_i > 18.5) => 0.1401121045,
   (f_srchaddrsrchcount_i = NULL) => -0.0197041850, -0.0052912601), -0.0061573537);

// Tree: 115 
woFDN_FLAP_D_lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 63.85) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0079947119,
      (f_corrrisktype_i > 7.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1281742351) => 0.0105862647,
         (f_add_curr_nhood_BUS_pct_i > 0.1281742351) => 0.0922279145,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0025906342, 0.0207549614),
      (f_corrrisktype_i = NULL) => 0.0049185227, -0.0013969708),
   (C_RENTOCC_P > 63.85) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 91) => -0.0208770890,
      (f_addrchangeincomediff_d > 91) => -0.1217392646,
      (f_addrchangeincomediff_d = NULL) => -0.0422056319, -0.0308054676),
   (C_RENTOCC_P = NULL) => -0.0043736553, -0.0043736553),
(c_pop_0_5_p > 21.15) => 0.1680778698,
(c_pop_0_5_p = NULL) => 0.0120478827, -0.0032362753);

// Tree: 116 
woFDN_FLAP_D_lgt_116 := map(
(NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1672953964) => -0.0058202617,
(f_add_curr_nhood_BUS_pct_i > 0.1672953964) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 2.5) => 0.0179160176,
   (r_D30_Derog_Count_i > 2.5) => 
      map(
      (NULL < c_health and c_health <= 11.9) => 0.0485532743,
      (c_health > 11.9) => 0.2148166717,
      (c_health = NULL) => 0.1072996747, 0.1072996747),
   (r_D30_Derog_Count_i = NULL) => 0.0311645834, 0.0311645834),
(f_add_curr_nhood_BUS_pct_i = NULL) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 12.15) => 0.1500169677,
   (r_C12_source_profile_d > 12.15) => -0.0008169440,
   (r_C12_source_profile_d = NULL) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 11.1) => 0.0405942702,
      (c_rnt500_p > 11.1) => -0.0792256118,
      (c_rnt500_p = NULL) => -0.0014617149, -0.0014617149), 0.0080466877), -0.0019349716);

// Tree: 117 
woFDN_FLAP_D_lgt_117 := map(
(NULL < c_unempl and c_unempl <= 191.5) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 5.5) => -0.0053041976,
      (f_bus_addr_match_count_d > 5.5) => 0.0393208101,
      (f_bus_addr_match_count_d = NULL) => -0.0009071920, -0.0009071920),
   (f_adls_per_phone_c6_i > 1.5) => 
      map(
      (NULL < c_young and c_young <= 23.4) => 0.0225627128,
      (c_young > 23.4) => 0.2482419255,
      (c_young = NULL) => 0.0927740234, 0.0927740234),
   (f_adls_per_phone_c6_i = NULL) => 0.0004628615, 0.0004628615),
(c_unempl > 191.5) => 
   map(
   (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.1416658808,
   (f_property_owners_ct_d > 0.5) => -0.0006576481,
   (f_property_owners_ct_d = NULL) => 0.0705041163, 0.0705041163),
(c_unempl = NULL) => -0.0067539244, 0.0008635185);

// Tree: 118 
woFDN_FLAP_D_lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0069344246,
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0333244262) => 
      map(
      (NULL < c_construction and c_construction <= 8.8) => 0.1626979506,
      (c_construction > 8.8) => 0.0018191570,
      (c_construction = NULL) => 0.1028087647, 0.1028087647),
   (f_add_curr_nhood_BUS_pct_i > 0.0333244262) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 142.5) => -0.0698057818,
      (f_curraddrcartheftindex_i > 142.5) => 0.0907427477,
      (f_curraddrcartheftindex_i = NULL) => -0.0138250445, -0.0138250445),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0418866375, 0.0418866375),
(f_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 83.75) => 0.0445812949,
   (c_fammar_p > 83.75) => -0.0632430779,
   (c_fammar_p = NULL) => 0.0082144946, 0.0082144946), -0.0054858833);

// Tree: 119 
woFDN_FLAP_D_lgt_119 := map(
(NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => 
   map(
   (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 1.5) => 
      map(
      (NULL < c_employees and c_employees <= 30.5) => 0.1009776312,
      (c_employees > 30.5) => 0.0176203150,
      (c_employees = NULL) => 0.0324815240, 0.0324815240),
   (f_addrchangeecontrajindex_d > 1.5) => 0.0005159032,
   (f_addrchangeecontrajindex_d = NULL) => 0.0186964982, 0.0082319432),
(r_D31_attr_bankruptcy_recency_d > 9) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.16692287985) => 0.0572616424,
   (f_add_curr_mobility_index_i > 0.16692287985) => -0.0416662595,
   (f_add_curr_mobility_index_i = NULL) => -0.0328118500, -0.0328118500),
(r_D31_attr_bankruptcy_recency_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 68.4) => 0.0546835197,
   (c_fammar_p > 68.4) => -0.0483295270,
   (c_fammar_p = NULL) => -0.0155228242, -0.0155228242), 0.0038821894);

// Tree: 120 
woFDN_FLAP_D_lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1920.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 37.5) => -0.1224234573,
   (f_mos_inq_banko_am_fseen_d > 37.5) => -0.0053081114,
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0050986616, -0.0070836630),
(c_popover18 > 1920.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 22.75) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 30.7) => 0.0148235899,
      (c_low_hval > 30.7) => 0.1956353084,
      (c_low_hval = NULL) => 0.0194534281, 0.0194534281),
   (c_hval_150k_p > 22.75) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 18.5) => 0.2897770837,
      (c_hh1_p > 18.5) => 0.0474651802,
      (c_hh1_p = NULL) => 0.1470657786, 0.1470657786),
   (c_hval_150k_p = NULL) => 0.0283048380, 0.0283048380),
(c_popover18 = NULL) => -0.0364671260, -0.0011785606);

// Tree: 121 
woFDN_FLAP_D_lgt_121 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 16556.5) => 0.0847484182,
(r_A46_Curr_AVM_AutoVal_d > 16556.5) => 0.0008174279,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 15.95) => -0.0069142299,
   (c_hh5_p > 15.95) => 
      map(
      (NULL < c_business and c_business <= 19.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 79) => 
            map(
            (NULL < c_no_car and c_no_car <= 134.5) => 0.2791680992,
            (c_no_car > 134.5) => 0.0418406761,
            (c_no_car = NULL) => 0.1596860173, 0.1596860173),
         (c_born_usa > 79) => -0.0266966998,
         (c_born_usa = NULL) => 0.0984213278, 0.0984213278),
      (c_business > 19.5) => -0.0491169808,
      (c_business = NULL) => 0.0523743398, 0.0523743398),
   (c_hh5_p = NULL) => -0.0153764255, -0.0039334063), -0.0007909045);

// Tree: 122 
woFDN_FLAP_D_lgt_122 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1288079234) => -0.0064471306,
   (f_add_curr_nhood_BUS_pct_i > 0.1288079234) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 974.5) => -0.0200490091,
      (c_popover18 > 974.5) => 0.0550286069,
      (c_popover18 = NULL) => 0.0276882034, 0.0276882034),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0020683151, -0.0018707135),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 93) => -0.0383530743,
   (c_ab_av_edu > 93) => 
      map(
      (NULL < c_robbery and c_robbery <= 104) => 0.0650064685,
      (c_robbery > 104) => 0.2598563155,
      (c_robbery = NULL) => 0.1369309087, 0.1369309087),
   (c_ab_av_edu = NULL) => 0.0772102596, 0.0772102596),
(r_P85_Phn_Disconnected_i = NULL) => -0.0003869712, -0.0003869712);

// Tree: 123 
woFDN_FLAP_D_lgt_123 := map(
(NULL < c_easiqlife and c_easiqlife <= 132.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1891163272) => 0.0971078329,
      (f_add_curr_nhood_MFD_pct_i > 0.1891163272) => -0.0210423117,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0348274692, 0.0301648955),
   (r_I60_inq_comm_recency_d > 549) => -0.0139153824,
   (r_I60_inq_comm_recency_d = NULL) => 0.0272267001, -0.0093231742),
(c_easiqlife > 132.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72571) => 0.1259509062,
   (f_addrchangevaluediff_d > -72571) => 0.0170826041,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 24.05) => 0.0101137164,
      (c_hval_150k_p > 24.05) => 0.1710313627,
      (c_hval_150k_p = NULL) => 0.0188700154, 0.0188700154), 0.0194159828),
(c_easiqlife = NULL) => -0.0140355734, 0.0006098677);

// Tree: 124 
woFDN_FLAP_D_lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 6.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 54.9) => 0.0259077329,
      (c_famotf18_p > 54.9) => 0.1245242649,
      (c_famotf18_p = NULL) => 0.0273125268, 0.0273125268),
   (f_rel_incomeover25_count_d > 6.5) => -0.0042233268,
   (f_rel_incomeover25_count_d = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 
         map(
         (NULL < c_robbery and c_robbery <= 98) => 0.1306557056,
         (c_robbery > 98) => -0.0049096583,
         (c_robbery = NULL) => 0.0576589712, 0.0576589712),
      (c_bigapt_p > 1.15) => -0.0385314890,
      (c_bigapt_p = NULL) => 0.0039375066, 0.0039375066), 0.0086111401),
(c_high_ed > 42.55) => -0.0280017512,
(c_high_ed = NULL) => -0.0326688437, -0.0027217324);

// Tree: 125 
woFDN_FLAP_D_lgt_125 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 345.5) => -0.0065386585,
(r_C21_M_Bureau_ADL_FS_d > 345.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 120) => 0.0098147881,
   (f_prevaddrmurderindex_i > 120) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0469547686) => 
         map(
         (NULL < f_rel_count_i and f_rel_count_i <= 5.5) => 0.0560011036,
         (f_rel_count_i > 5.5) => 0.3425459360,
         (f_rel_count_i = NULL) => 0.2374107817, 0.2374107817),
      (f_add_input_nhood_BUS_pct_i > 0.0469547686) => 0.0197836118,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.1216360583, 0.1216360583),
   (f_prevaddrmurderindex_i = NULL) => 0.0325439246, 0.0325439246),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 7) => 0.0621460306,
   (c_hh5_p > 7) => -0.0383440921,
   (c_hh5_p = NULL) => 0.0214245430, 0.0214245430), -0.0016163119);

// Tree: 126 
woFDN_FLAP_D_lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.55) => -0.0755279651,
   (C_OWNOCC_P > 1.55) => 
      map(
      (NULL < c_unempl and c_unempl <= 184.5) => 0.0035311249,
      (c_unempl > 184.5) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 5.5) => 
            map(
            (NULL < r_C20_email_count_i and r_C20_email_count_i <= 0.5) => 0.1823540631,
            (r_C20_email_count_i > 0.5) => 0.0484732560,
            (r_C20_email_count_i = NULL) => 0.1154136595, 0.1154136595),
         (f_corraddrnamecount_d > 5.5) => -0.0159533057,
         (f_corraddrnamecount_d = NULL) => 0.0409155104, 0.0409155104),
      (c_unempl = NULL) => 0.0042478666, 0.0042478666),
   (C_OWNOCC_P = NULL) => -0.0036193975, 0.0030759507),
(r_L72_Add_Vacant_i > 0.5) => 0.1122421262,
(r_L72_Add_Vacant_i = NULL) => 0.0038249025, 0.0038249025);

// Tree: 127 
woFDN_FLAP_D_lgt_127 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0021254559,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 104.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 46.5) => -0.0130895720,
         (c_born_usa > 46.5) => -0.1111854399,
         (c_born_usa = NULL) => -0.0796199379, -0.0796199379),
      (c_many_cars > 104.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 0.85) => 0.1190036527,
         (c_hval_750k_p > 0.85) => -0.0444461502,
         (c_hval_750k_p = NULL) => 0.0306880334, 0.0306880334),
      (c_many_cars = NULL) => -0.0376623046, -0.0376623046),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0031323129, -0.0031323129),
(f_prevaddroccupantowned_i > 0.5) => 0.0390597219,
(f_prevaddroccupantowned_i = NULL) => -0.0167144470, -0.0003460101);

// Tree: 128 
woFDN_FLAP_D_lgt_128 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 54.5) => -0.0107892475,
(r_C13_Curr_Addr_LRes_d > 54.5) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 1076) => 0.0014769612,
   (r_P88_Phn_Dst_to_Inp_Add_i > 1076) => 0.1655120000,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 186.4) => 0.2043890158,
      (c_housingcpi > 186.4) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 10.5) => 0.1297198611,
         (c_born_usa > 10.5) => 
            map(
            (NULL < c_high_ed and c_high_ed <= 4.05) => 0.1373823729,
            (c_high_ed > 4.05) => 0.0178224571,
            (c_high_ed = NULL) => 0.0228002793, 0.0228002793),
         (c_born_usa = NULL) => 0.0307372076, 0.0307372076),
      (c_housingcpi = NULL) => -0.0511129731, 0.0344654272), 0.0102157037),
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0054905383, 0.0004694272);

// Tree: 129 
woFDN_FLAP_D_lgt_129 := map(
(NULL < c_hhsize and c_hhsize <= 4.005) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 196.5) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 113) => -0.0066711311,
         (c_cartheft > 113) => 0.0239848370,
         (c_cartheft = NULL) => 0.0022934023, 0.0022934023),
      (c_bel_edu > 196.5) => -0.1254647393,
      (c_bel_edu = NULL) => 0.0014438390, 0.0014438390),
   (c_pop_18_24_p > 11.15) => -0.0264575607,
   (c_pop_18_24_p = NULL) => -0.0047922988, -0.0047922988),
(c_hhsize > 4.005) => 
   map(
   (NULL < c_med_age and c_med_age <= 26.65) => 0.1944858111,
   (c_med_age > 26.65) => 0.0065765244,
   (c_med_age = NULL) => 0.0692129533, 0.0692129533),
(c_hhsize = NULL) => 0.0146263506, -0.0031864231);

// Tree: 130 
woFDN_FLAP_D_lgt_130 := map(
(NULL < c_lar_fam and c_lar_fam <= 181.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 12.45) => -0.0919482909,
   (c_white_col > 12.45) => 
      map(
      (NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 1900) => -0.0050024751,
      (f_acc_damage_amt_last_i > 1900) => 0.1336639376,
      (f_acc_damage_amt_last_i = NULL) => -0.0004790219, -0.0037818197),
   (c_white_col = NULL) => -0.0044076750, -0.0044076750),
(c_lar_fam > 181.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 7.65) => -0.0514857551,
   (C_INC_15K_P > 7.65) => 0.1714654458,
   (C_INC_15K_P = NULL) => 0.0836361849, 0.0836361849),
(c_lar_fam = NULL) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 3.5) => 0.1735684353,
   (r_C18_invalid_addrs_per_adl_i > 3.5) => -0.0648588954,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0517055774, 0.0517055774), -0.0021776848);

// Tree: 131 
woFDN_FLAP_D_lgt_131 := map(
(NULL < c_med_hval and c_med_hval <= 822417.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 12.05) => -0.0991715347,
   (c_white_col > 12.05) => 
      map(
      (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => -0.0007910838,
      (r_L72_Add_Vacant_i > 0.5) => 0.0874820711,
      (r_L72_Add_Vacant_i = NULL) => -0.0000750362, -0.0000750362),
   (c_white_col = NULL) => -0.0007497778, -0.0007497778),
(c_med_hval > 822417.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.6) => 
      map(
      (NULL < c_rich_asian and c_rich_asian <= 178.5) => 0.0672955221,
      (c_rich_asian > 178.5) => 0.3183759843,
      (c_rich_asian = NULL) => 0.1623855695, 0.1623855695),
   (c_pop_0_5_p > 7.6) => -0.0389407251,
   (c_pop_0_5_p = NULL) => 0.0954674545, 0.0954674545),
(c_med_hval = NULL) => -0.0044007945, 0.0018367157);

// Tree: 132 
woFDN_FLAP_D_lgt_132 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 12.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0003950306,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2167724770,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0019321875, 0.0017584077),
   (f_assocsuspicousidcount_i > 16.5) => 0.1014193169,
   (f_assocsuspicousidcount_i = NULL) => 0.0022421594, 0.0022421594),
(f_srchphonesrchcount_i > 12.5) => 
   map(
   (NULL < c_no_car and c_no_car <= 77.5) => 0.0210136361,
   (c_no_car > 77.5) => -0.1345248535,
   (c_no_car = NULL) => -0.0605099860, -0.0605099860),
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0585903979,
   (c_construction > 7.45) => -0.0402707887,
   (c_construction = NULL) => 0.0169646352, 0.0169646352), 0.0017203867);

// Tree: 133 
woFDN_FLAP_D_lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 127.5) => 
   map(
   (NULL < c_rape and c_rape <= 66) => 
      map(
      (NULL < c_rape and c_rape <= 28.5) => 0.0140431890,
      (c_rape > 28.5) => 0.2147814143,
      (c_rape = NULL) => 0.1319370673, 0.1319370673),
   (c_rape > 66) => 0.0035493625,
   (c_rape = NULL) => 0.0542604935, 0.0542604935),
(f_mos_liens_unrel_SC_fseen_d > 127.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 20.5) => 0.0581007041,
   (k_comb_age_d > 20.5) => -0.0006279495,
   (k_comb_age_d = NULL) => 0.0009005384, 0.0009005384),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 7) => -0.0504572775,
   (c_professional > 7) => 0.0544794154,
   (c_professional = NULL) => -0.0128785970, -0.0128785970), 0.0020509669);

// Tree: 134 
woFDN_FLAP_D_lgt_134 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 31.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0049467147,
   (r_C13_Curr_Addr_LRes_d > 158.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 41.5) => 0.0572965783,
      (r_pb_order_freq_d > 41.5) => -0.0102573537,
      (r_pb_order_freq_d = NULL) => 0.0554011885, 0.0249783261),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0019575432, 0.0019575432),
(f_rel_under100miles_cnt_d > 31.5) => -0.0718538298,
(f_rel_under100miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 226530.5) => 0.0703089555,
   (r_L80_Inp_AVM_AutoVal_d > 226530.5) => -0.0303856071,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 164.5) => -0.0532137499,
      (c_cartheft > 164.5) => 0.0762787235,
      (c_cartheft = NULL) => -0.0214085810, -0.0214085810), -0.0019425915), 0.0008824065);

// Tree: 135 
woFDN_FLAP_D_lgt_135 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => -0.0062520075,
   (f_adls_per_phone_c6_i > 1.5) => 
      map(
      (NULL < c_young and c_young <= 23.2) => 0.0340390194,
      (c_young > 23.2) => 0.2274306185,
      (c_young = NULL) => 0.1031074477, 0.1031074477),
   (f_adls_per_phone_c6_i = NULL) => -0.0049454761, -0.0049454761),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 111.5) => 0.0102339674,
   (c_bel_edu > 111.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 156.5) => 0.0665054303,
      (f_curraddrmurderindex_i > 156.5) => 0.2164038498,
      (f_curraddrmurderindex_i = NULL) => 0.0955555116, 0.0955555116),
   (c_bel_edu = NULL) => 0.0359895385, 0.0359895385),
(k_comb_age_d = NULL) => -0.0020990016, -0.0020990016);

// Tree: 136 
woFDN_FLAP_D_lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.75) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 21205.5) => 0.0872660317,
      (f_curraddrmedianincome_d > 21205.5) => 0.0123591655,
      (f_curraddrmedianincome_d = NULL) => 0.0159594955, 0.0159594955),
   (c_hh7p_p > 7.75) => 0.1359055918,
   (c_hh7p_p = NULL) => 0.0597212533, 0.0215745676),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -29731.5) => -0.0839855626,
   (f_addrchangeincomediff_d > -29731.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 201458.5) => -0.0082380839,
      (f_addrchangevaluediff_d > 201458.5) => 0.1114665590,
      (f_addrchangevaluediff_d = NULL) => -0.0071323723, -0.0071323723),
   (f_addrchangeincomediff_d = NULL) => -0.0061792140, -0.0078924673),
(f_hh_members_ct_d = NULL) => -0.0048683803, -0.0022693964);

// Tree: 137 
woFDN_FLAP_D_lgt_137 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.31123348195) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 197.5) => -0.0075634157,
   (r_A50_pb_average_dollars_d > 197.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 
         map(
         (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 21.5) => 0.0115798719,
         (f_rel_homeover200_count_d > 21.5) => 0.0955070642,
         (f_rel_homeover200_count_d = NULL) => 0.0276767316, 0.0147525572),
      (k_comb_age_d > 70.5) => 
         map(
         (NULL < C_INC_201K_P and C_INC_201K_P <= 2.15) => 0.2252223459,
         (C_INC_201K_P > 2.15) => 0.0646397411,
         (C_INC_201K_P = NULL) => 0.1250091414, 0.1250091414),
      (k_comb_age_d = NULL) => 0.0193763301, 0.0193763301),
   (r_A50_pb_average_dollars_d = NULL) => -0.0227389119, 0.0023974062),
(f_add_input_mobility_index_i > 0.31123348195) => -0.0169108434,
(f_add_input_mobility_index_i = NULL) => 0.0362403200, -0.0034346579);

// Tree: 138 
woFDN_FLAP_D_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0014404883,
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 68.15) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 3.75) => -0.0204618372,
         (C_INC_125K_P > 3.75) => 0.1669101727,
         (C_INC_125K_P = NULL) => 0.0657887706, 0.0657887706),
      (c_fammar_p > 68.15) => -0.1056501955,
      (c_fammar_p = NULL) => -0.0047094959, -0.0047094959),
   (f_vardobcountnew_i > 0.5) => 0.1494956923,
   (f_vardobcountnew_i = NULL) => 0.0397824928, 0.0397824928),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0373846523,
   (c_rich_nfam > 124) => -0.0489396526,
   (c_rich_nfam = NULL) => -0.0034444108, -0.0034444108), -0.0004777525);

// Tree: 139 
woFDN_FLAP_D_lgt_139 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0245475732) => -0.0331844843,
   (f_add_curr_nhood_BUS_pct_i > 0.0245475732) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.23185783165) => 0.0278095199,
      (f_add_input_nhood_MFD_pct_i > 0.23185783165) => 0.0830793137,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0641614648, 0.0641614648),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0314401374, 0.0314401374),
(r_C21_M_Bureau_ADL_FS_d > 7.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 48607) => -0.0472277179,
   (r_L80_Inp_AVM_AutoVal_d > 48607) => 0.0051319409,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0069916892, -0.0015585021),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 111.5) => 0.0413499699,
   (c_lar_fam > 111.5) => -0.0508432068,
   (c_lar_fam = NULL) => -0.0010245337, -0.0010245337), -0.0009002828);

// Tree: 140 
woFDN_FLAP_D_lgt_140 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 41.35) => 0.0000134197,
      (c_hval_80k_p > 41.35) => -0.1015232038,
      (c_hval_80k_p = NULL) => -0.0333054361, -0.0015266101),
   (f_inq_Communications_count24_i > 2.5) => 0.0685998357,
   (f_inq_Communications_count24_i = NULL) => -0.0010317605, -0.0010317605),
(f_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < c_robbery and c_robbery <= 55.5) => 0.1909043336,
   (c_robbery > 55.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0792375214,
      (f_idverrisktype_i > 1.5) => 0.0550278552,
      (f_idverrisktype_i = NULL) => -0.0020613600, -0.0020613600),
   (c_robbery = NULL) => 0.0532265634, 0.0532265634),
(f_srchaddrsrchcountmo_i = NULL) => -0.0076998649, -0.0003543531);

// Tree: 141 
woFDN_FLAP_D_lgt_141 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 204.35) => 
      map(
      (NULL < c_unemp and c_unemp <= 11.25) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 194.5) => 0.0066529479,
         (c_new_homes > 194.5) => 
            map(
            (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 69847.5) => 0.3132237711,
            (f_curraddrmedianincome_d > 69847.5) => 0.0185151115,
            (f_curraddrmedianincome_d = NULL) => 0.1282241745, 0.1282241745),
         (c_new_homes = NULL) => 0.0162249353, 0.0162249353),
      (c_unemp > 11.25) => 0.1476309333,
      (c_unemp = NULL) => 0.0199668146, 0.0199668146),
   (c_housingcpi > 204.35) => -0.0057320345,
   (c_housingcpi = NULL) => -0.0144066211, -0.0021894738),
(r_L77_Add_PO_Box_i > 0.5) => -0.0881999820,
(r_L77_Add_PO_Box_i = NULL) => -0.0041558157, -0.0041558157);

// Tree: 142 
woFDN_FLAP_D_lgt_142 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 25.5) => 0.0054027280,
   (f_rel_under500miles_cnt_d > 25.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 117.5) => -0.0881587777,
      (c_rest_indx > 117.5) => 
         map(
         (NULL < c_highinc and c_highinc <= 12.45) => 0.1376196465,
         (c_highinc > 12.45) => -0.0679562900,
         (c_highinc = NULL) => 0.0171649962, 0.0171649962),
      (c_rest_indx = NULL) => -0.0509172222, -0.0509172222),
   (f_rel_under500miles_cnt_d = NULL) => 0.0010258252, 0.0036135453),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0530890973,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 0.9) => -0.0602748803,
   (c_hval_150k_p > 0.9) => 0.0431216457,
   (c_hval_150k_p = NULL) => -0.0038767752, -0.0038767752), 0.0011331511);

// Tree: 143 
woFDN_FLAP_D_lgt_143 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.0754938763,
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0048103268,
      (c_hval_200k_p > 16.45) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0072989784) => 0.2276635108,
         (f_add_curr_nhood_MFD_pct_i > 0.0072989784) => 0.0218305613,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0191863778, 0.0344386081),
      (c_hval_200k_p = NULL) => 0.0184817981, -0.0008869726),
   (f_hh_age_18_plus_d = NULL) => -0.0005483232, -0.0005483232),
(f_inq_QuizProvider_count_i > 6.5) => 0.1007312173,
(f_inq_QuizProvider_count_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 110.5) => -0.0445190528,
   (c_larceny > 110.5) => 0.0424902371,
   (c_larceny = NULL) => -0.0047282190, -0.0047282190), 0.0001575290);

// Tree: 144 
woFDN_FLAP_D_lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1263304915,
   (f_mos_liens_unrel_FT_lseen_d > 39.5) => -0.0047265213,
   (f_mos_liens_unrel_FT_lseen_d = NULL) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 19.1) => 0.0690356910,
      (C_RENTOCC_P > 19.1) => -0.0351723055,
      (C_RENTOCC_P = NULL) => 0.0029691834, 0.0029691834), -0.0040660464),
(c_rnt2001_p > 49) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => 0.0142730547,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 9.45) => 0.0259377935,
      (c_pop_12_17_p > 9.45) => 0.3815459808,
      (c_pop_12_17_p = NULL) => 0.1792171846, 0.1792171846),
   (k_inf_nothing_found_i = NULL) => 0.0774199823, 0.0774199823),
(c_rnt2001_p = NULL) => 0.0018640144, -0.0019882684);

// Tree: 145 
woFDN_FLAP_D_lgt_145 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 21102.5) => -0.0711762331,
   (c_med_hhinc > 21102.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 328.5) => -0.0027587829,
      (r_C13_Curr_Addr_LRes_d > 328.5) => 0.0596518175,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0000516408, -0.0000516408),
   (c_med_hhinc = NULL) => 0.0237907950, -0.0006026774),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < c_health and c_health <= 7.05) => 0.1663972627,
   (c_health > 7.05) => -0.0076109863,
   (c_health = NULL) => 0.0678778865, 0.0678778865),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 94.5) => 0.0606591951,
   (c_easiqlife > 94.5) => -0.0420085958,
   (c_easiqlife = NULL) => -0.0071149675, -0.0071149675), 0.0000411692);

// Tree: 146 
woFDN_FLAP_D_lgt_146 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 190.5) => -0.0044875251,
      (f_fp_prevaddrcrimeindex_i > 190.5) => 
         map(
         (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 1.5) => 0.1612187517,
         (f_addrchangeecontrajindex_d > 1.5) => 0.0199105817,
         (f_addrchangeecontrajindex_d = NULL) => 0.0396251645, 0.0691600617),
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0031344981, -0.0031344981),
   (f_fp_prevaddrcrimeindex_i > 197.5) => -0.1041369805,
   (f_fp_prevaddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 12.45) => -0.0318287784,
      (c_hh4_p > 12.45) => 0.0611957392,
      (c_hh4_p = NULL) => 0.0174194956, 0.0174194956), -0.0032769274),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1087402962,
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0024733352, -0.0024733352);

// Tree: 147 
woFDN_FLAP_D_lgt_147 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 56.85) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0126026597,
      (k_inf_nothing_found_i > 0.5) => 0.0149521702,
      (k_inf_nothing_found_i = NULL) => -0.0012791799, -0.0012791799),
   (k_inq_adls_per_phone_i > 2.5) => -0.0740916205,
   (k_inq_adls_per_phone_i = NULL) => -0.0018950746, -0.0018950746),
(c_fammar18_p > 56.85) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 165.5) => 0.0142571613,
   (c_lar_fam > 165.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 39) => 0.0308003494,
      (f_fp_prevaddrcrimeindex_i > 39) => 0.2808375147,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.1646785166, 0.1646785166),
   (c_lar_fam = NULL) => 0.0415872385, 0.0415872385),
(c_fammar18_p = NULL) => -0.0451844427, -0.0003861251);

// Tree: 148 
woFDN_FLAP_D_lgt_148 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0069371504,
(k_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 7.25) => -0.0012578596,
   (c_hval_150k_p > 7.25) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 1.5) => 
         map(
         (NULL < c_families and c_families <= 642) => 
            map(
            (NULL < c_bargains and c_bargains <= 85.5) => 0.1935243918,
            (c_bargains > 85.5) => 0.0093383708,
            (c_bargains = NULL) => 0.0659418797, 0.0659418797),
         (c_families > 642) => 0.2260375323,
         (c_families = NULL) => 0.1058191851, 0.1058191851),
      (f_rel_homeover200_count_d > 1.5) => 0.0075239655,
      (f_rel_homeover200_count_d = NULL) => 0.0599352838, 0.0599352838),
   (c_hval_150k_p = NULL) => 0.0178514514, 0.0178514514),
(k_inq_ssns_per_addr_i = NULL) => -0.0035896632, -0.0035896632);

// Tree: 149 
woFDN_FLAP_D_lgt_149 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 59163.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => -0.0118697254,
   (r_D30_Derog_Count_i > 1.5) => -0.0868739408,
   (r_D30_Derog_Count_i = NULL) => -0.0338297225, -0.0338297225),
(r_L80_Inp_AVM_AutoVal_d > 59163.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 2.5) => 0.0432406580,
   (f_rel_under25miles_cnt_d > 2.5) => -0.0006820500,
   (f_rel_under25miles_cnt_d = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 150.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 72) => 0.1878673739,
         (c_old_homes > 72) => -0.0159896442,
         (c_old_homes = NULL) => 0.0849681171, 0.0849681171),
      (c_asian_lang > 150.5) => -0.0528572636,
      (c_asian_lang = NULL) => 0.0405083169, 0.0405083169), 0.0098048567),
(r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0009201535, 0.0033978926);

// Tree: 150 
woFDN_FLAP_D_lgt_150 := map(
(NULL < c_low_ed and c_low_ed <= 77.75) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 6.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0025755767,
      (f_srchfraudsrchcount_i > 6.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 39) => 0.0287445096,
         (c_burglary > 39) => -0.0541205162,
         (c_burglary = NULL) => -0.0319989995, -0.0319989995),
      (f_srchfraudsrchcount_i = NULL) => 0.0012376782, 0.0012376782),
   (f_inq_Other_count_i > 6.5) => 0.0835706986,
   (f_inq_Other_count_i = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 6.4) => -0.0427630536,
      (c_hval_250k_p > 6.4) => 0.0755309731,
      (c_hval_250k_p = NULL) => 0.0112407412, 0.0112407412), 0.0020288620),
(c_low_ed > 77.75) => -0.0493324627,
(c_low_ed = NULL) => 0.0038427076, 0.0006361323);

// Tree: 151 
woFDN_FLAP_D_lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 80.5) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => -0.0008098754,
      (k_inq_adls_per_phone_i > 3.5) => -0.0944386331,
      (k_inq_adls_per_phone_i = NULL) => -0.0012411003, -0.0012411003),
   (f_bus_addr_match_count_d > 80.5) => 0.1215074048,
   (f_bus_addr_match_count_d = NULL) => -0.0006881791, -0.0006881791),
(r_C14_addrs_10yr_i > 10.5) => 0.1139726805,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 9.95) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => -0.0199667791,
      (c_hval_250k_p > 8.05) => 0.0977428562,
      (c_hval_250k_p = NULL) => 0.0309077243, 0.0309077243),
   (c_construction > 9.95) => -0.0713939790,
   (c_construction = NULL) => 0.0000356126, 0.0000356126), -0.0001976955);

// Tree: 152 
woFDN_FLAP_D_lgt_152 := map(
(NULL < c_white_col and c_white_col <= 30.85) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => -0.0097761495,
   (f_inq_QuizProvider_count_i > 1.5) => -0.0673690289,
   (f_inq_QuizProvider_count_i = NULL) => -0.0146115067, -0.0146115067),
(c_white_col > 30.85) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37763534975) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30920.5) => 
         map(
         (NULL < c_finance and c_finance <= 3.85) => 0.1273468303,
         (c_finance > 3.85) => 0.0138068455,
         (c_finance = NULL) => 0.0756972686, 0.0756972686),
      (f_curraddrmedianincome_d > 30920.5) => 0.0117605847,
      (f_curraddrmedianincome_d = NULL) => 0.0317904911, 0.0141287437),
   (f_add_input_mobility_index_i > 0.37763534975) => -0.0253652638,
   (f_add_input_mobility_index_i = NULL) => 0.0074867071, 0.0074867071),
(c_white_col = NULL) => 0.0172218558, 0.0020479411);

// Tree: 153 
woFDN_FLAP_D_lgt_153 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 15.5) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 0.5) => -0.0122643287,
   (f_hh_members_w_derog_i > 0.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 56.45) => 0.0130881631,
      (c_rnt1000_p > 56.45) => 
         map(
         (NULL < c_no_car and c_no_car <= 77.5) => 0.0199397307,
         (c_no_car > 77.5) => 
            map(
            (NULL < c_new_homes and c_new_homes <= 107.5) => 0.0904813709,
            (c_new_homes > 107.5) => 0.3345239252,
            (c_new_homes = NULL) => 0.1693025685, 0.1693025685),
         (c_no_car = NULL) => 0.0932550261, 0.0932550261),
      (c_rnt1000_p = NULL) => 0.0243155623, 0.0181944342),
   (f_hh_members_w_derog_i = NULL) => 0.0030978587, 0.0030978587),
(f_rel_incomeover25_count_d > 15.5) => -0.0202638315,
(f_rel_incomeover25_count_d = NULL) => -0.0205668830, -0.0008444931);

// Tree: 154 
woFDN_FLAP_D_lgt_154 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 16.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 8.5) => -0.0102625158,
   (f_util_adl_count_n > 8.5) => 0.0524859797,
   (f_util_adl_count_n = NULL) => 
      map(
      (NULL < c_assault and c_assault <= 90) => -0.0569161719,
      (c_assault > 90) => 0.0487253121,
      (c_assault = NULL) => -0.0069179123, -0.0069179123), -0.0079986009),
(c_hval_500k_p > 16.15) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 0.0177307814,
   (k_comb_age_d > 71.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1974.5) => 0.2727613640,
      (c_med_yearblt > 1974.5) => -0.0608432644,
      (c_med_yearblt = NULL) => 0.1154006902, 0.1154006902),
   (k_comb_age_d = NULL) => 0.0221139357, 0.0221139357),
(c_hval_500k_p = NULL) => 0.0079728599, -0.0020252721);

// Tree: 155 
woFDN_FLAP_D_lgt_155 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 34701) => -0.0010806063,
(f_addrchangevaluediff_d > 34701) => 
   map(
   (NULL < C_INC_200K_P and C_INC_200K_P <= 1.85) => 0.1415323817,
   (C_INC_200K_P > 1.85) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3344839322) => -0.0256764201,
      (f_add_curr_mobility_index_i > 0.3344839322) => 0.0698303746,
      (f_add_curr_mobility_index_i = NULL) => 0.0061591781, 0.0061591781),
   (C_INC_200K_P = NULL) => 0.0304208692, 0.0304208692),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 79.5) => -0.0522033509,
   (c_span_lang > 79.5) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => -0.0009638352,
      (f_bus_addr_match_count_d > 6.5) => 0.1072614975,
      (f_bus_addr_match_count_d = NULL) => 0.0069385279, 0.0069385279),
   (c_span_lang = NULL) => 0.0163840861, -0.0096098034), -0.0020697194);

// Tree: 156 
woFDN_FLAP_D_lgt_156 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0018229548,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 39.5) => 0.0518555792,
   (r_A50_pb_total_dollars_d > 39.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 48.5) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.8300998483) => -0.0409040366,
         (f_add_curr_nhood_SFD_pct_d > 0.8300998483) => -0.1635599798,
         (f_add_curr_nhood_SFD_pct_d = NULL) => -0.0938309162, -0.0938309162),
      (f_mos_inq_banko_cm_fseen_d > 48.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0010881509) => 0.0669070962,
         (f_add_input_nhood_VAC_pct_i > 0.0010881509) => -0.0413228694,
         (f_add_input_nhood_VAC_pct_i = NULL) => -0.0193984712, -0.0193984712),
      (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0431777644, -0.0431777644),
   (r_A50_pb_total_dollars_d = NULL) => -0.0278329309, -0.0278329309),
(f_srchfraudsrchcount_i = NULL) => -0.0004094396, 0.0005185456);

// Tree: 157 
woFDN_FLAP_D_lgt_157 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0061328778,
      (f_util_adl_count_n > 4.5) => 0.0279738683,
      (f_util_adl_count_n = NULL) => -0.0018444068, -0.0018444068),
   (f_prevaddrmedianvalue_d > 809865.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 56044) => 0.2651820981,
      (r_A49_Curr_AVM_Chg_1yr_i > 56044) => 0.0837360900,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0120294144, 0.0920688838),
   (f_prevaddrmedianvalue_d = NULL) => -0.0002498381, -0.0002498381),
(f_inq_HighRiskCredit_count24_i > 8.5) => 0.0778531400,
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0626124912,
   (k_nap_lname_verd_d > 0.5) => -0.0479107792,
   (k_nap_lname_verd_d = NULL) => 0.0031461663, 0.0031461663), 0.0002550484);

// Tree: 158 
woFDN_FLAP_D_lgt_158 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 98.5) => 0.1720037076,
      (r_C13_max_lres_d > 98.5) => 0.0015787675,
      (r_C13_max_lres_d = NULL) => 0.0820572115, 0.0820572115),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => -0.0017750862,
      (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0691246496,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0014109050, -0.0014109050),
   (r_D33_Eviction_Recency_d = NULL) => -0.0006823382, -0.0006823382),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < r_has_pb_record_d and r_has_pb_record_d <= 0.5) => 0.0041606809,
   (r_has_pb_record_d > 0.5) => -0.1451676568,
   (r_has_pb_record_d = NULL) => -0.0663554785, -0.0663554785),
(r_I60_inq_comm_count12_i = NULL) => 0.0186396475, -0.0011719589);

// Tree: 159 
woFDN_FLAP_D_lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0007014238,
   (f_srchunvrfdaddrcount_i > 0.5) => 0.0439034895,
   (f_srchunvrfdaddrcount_i = NULL) => 0.0003339429, 0.0003339429),
(f_rel_homeover500_count_d > 19.5) => 0.1242422111,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.14038461535) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.72711108105) => -0.0860474900,
      (f_add_curr_nhood_SFD_pct_d > 0.72711108105) => 0.0717546211,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 
         map(
         (NULL < c_burglary and c_burglary <= 97.5) => -0.0430593737,
         (c_burglary > 97.5) => 0.0679460731,
         (c_burglary = NULL) => 0.0053490167, 0.0053490167), -0.0174731030),
   (f_add_input_nhood_BUS_pct_i > 0.14038461535) => 0.1026132183,
   (f_add_input_nhood_BUS_pct_i = NULL) => -0.0212815067, -0.0008417617), 0.0009193392);

// Tree: 160 
woFDN_FLAP_D_lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.55) => -0.0043301023,
(r_C12_source_profile_d > 79.55) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 49.85) => 0.0122594316,
      (C_RENTOCC_P > 49.85) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 20.35) => 0.0144469728,
         (c_rnt1000_p > 20.35) => 0.2163287422,
         (c_rnt1000_p = NULL) => 0.1218702997, 0.1218702997),
      (C_RENTOCC_P = NULL) => 0.0239842448, 0.0239842448),
   (f_srchcomponentrisktype_i > 1.5) => 0.1490372279,
   (f_srchcomponentrisktype_i = NULL) => 0.0321919155, 0.0321919155),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 85.5) => 0.0542316249,
   (c_very_rich > 85.5) => -0.0515542879,
   (c_very_rich = NULL) => -0.0114066222, -0.0114066222), -0.0012787849);

// Tree: 161 
woFDN_FLAP_D_lgt_161 := map(
(NULL < c_easiqlife and c_easiqlife <= 146.5) => -0.0113808662,
(c_easiqlife > 146.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -2.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 3.05) => -0.0043467521,
      (c_hval_250k_p > 3.05) => 0.1700891003,
      (c_hval_250k_p = NULL) => 0.0959195253, 0.0959195253),
   (f_addrchangecrimediff_i > -2.5) => 0.0088626633,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0255231591) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.9) => 0.0131450810,
         (c_pop_55_64_p > 11.9) => 0.2004209880,
         (c_pop_55_64_p = NULL) => 0.0809211235, 0.0809211235),
      (f_add_input_nhood_BUS_pct_i > 0.0255231591) => -0.0169031854,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0182733641, 0.0182733641), 0.0145498888),
(c_easiqlife = NULL) => -0.0357992444, -0.0058703394);

// Tree: 162 
woFDN_FLAP_D_lgt_162 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 44.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0054075803,
   (f_hh_payday_loan_users_i > 0.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 191.5) => 0.0225771413,
      (c_asian_lang > 191.5) => 0.1652355757,
      (c_asian_lang = NULL) => 0.0299516415, 0.0299516415),
   (f_hh_payday_loan_users_i = NULL) => -0.0021515290, -0.0021515290),
(f_phones_per_addr_curr_i > 44.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 56.5) => 0.1701905386,
   (f_mos_inq_banko_cm_lseen_d > 56.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 21.45) => -0.0504754204,
      (C_INC_75K_P > 21.45) => 0.1702604919,
      (C_INC_75K_P = NULL) => 0.0261064267, 0.0261064267),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0669764392, 0.0669764392),
(f_phones_per_addr_curr_i = NULL) => 0.0091056736, -0.0008547262);

// Tree: 163 
woFDN_FLAP_D_lgt_163 := map(
(NULL < c_high_ed and c_high_ed <= 3.65) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.79765908125) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 2.9) => 0.0163573191,
      (C_INC_125K_P > 2.9) => 0.1849605366,
      (C_INC_125K_P = NULL) => 0.1027404491, 0.1027404491),
   (f_add_input_nhood_SFD_pct_d > 0.79765908125) => -0.0059993049,
   (f_add_input_nhood_SFD_pct_d = NULL) => 0.0482032802, 0.0482032802),
(c_high_ed > 3.65) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 37.45) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 20.25) => -0.0014481422,
      (c_hval_80k_p > 20.25) => -0.0488582967,
      (c_hval_80k_p = NULL) => -0.0039604348, -0.0039604348),
   (c_hval_20k_p > 37.45) => 0.1360860986,
   (c_hval_20k_p = NULL) => -0.0033456869, -0.0033456869),
(c_high_ed = NULL) => 0.0047154875, -0.0018432107);

// Tree: 164 
woFDN_FLAP_D_lgt_164 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0000025191,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 163.5) => 
      map(
      (NULL < c_rnt2001_p and c_rnt2001_p <= 7.15) => 0.0012120267,
      (c_rnt2001_p > 7.15) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 55) => 0.0025171075,
         (c_many_cars > 55) => 0.2320322759,
         (c_many_cars = NULL) => 0.1172746917, 0.1172746917),
      (c_rnt2001_p = NULL) => 0.0161243206, 0.0161243206),
   (c_totcrime > 163.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 2.9) => 0.0327987242,
      (c_hval_200k_p > 2.9) => 0.2946399664,
      (c_hval_200k_p = NULL) => 0.1290887294, 0.1290887294),
   (c_totcrime = NULL) => 0.0671949036, 0.0368972426),
(r_L70_Add_Standardized_i = NULL) => 0.0031216704, 0.0031216704);

// Tree: 165 
woFDN_FLAP_D_lgt_165 := map(
(NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 25.05) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 18.5) => 0.0107768223,
      (f_rel_incomeover50_count_d > 18.5) => -0.0527112656,
      (f_rel_incomeover50_count_d = NULL) => 
         map(
         (NULL < c_child and c_child <= 17.75) => -0.1048726212,
         (c_child > 17.75) => 
            map(
            (NULL < c_serv_empl and c_serv_empl <= 129.5) => 0.0794248367,
            (c_serv_empl > 129.5) => -0.0241054375,
            (c_serv_empl = NULL) => 0.0440065850, 0.0440065850),
         (c_child = NULL) => 0.0042735492, 0.0042735492), 0.0083456509),
   (c_pop_55_64_p > 25.05) => 0.1773572186,
   (c_pop_55_64_p = NULL) => -0.0013383465, 0.0095751361),
(k_inf_lname_verd_d > 0.5) => -0.0216440764,
(k_inf_lname_verd_d = NULL) => -0.0007393865, -0.0007393865);

// Tree: 166 
woFDN_FLAP_D_lgt_166 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 113.5) => 0.1007200574,
      (c_bargains > 113.5) => -0.0632861451,
      (c_bargains = NULL) => 0.0304316849, 0.0304316849),
   (f_inq_Collection_count_i > 3.5) => 0.1404417866,
   (f_inq_Collection_count_i = NULL) => 0.0565004294, 0.0565004294),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 44.35) => -0.0079756039,
   (c_fammar18_p > 44.35) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 755.5) => -0.0017403367,
      (c_hh00 > 755.5) => 0.0557770043,
      (c_hh00 = NULL) => 0.0219367761, 0.0219367761),
   (c_fammar18_p = NULL) => 0.0293685757, 0.0003756093),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0313260189, 0.0008818260);

// Tree: 167 
woFDN_FLAP_D_lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 206.5) => -0.0765064346,
   (f_mos_liens_unrel_CJ_lseen_d > 206.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 76.45) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 50.4) => 
            map(
            (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0040393541,
            (f_hh_collections_ct_i > 2.5) => 0.1503390211,
            (f_hh_collections_ct_i = NULL) => 0.0165995432, 0.0165995432),
         (c_rnt750_p > 50.4) => 0.1434581092,
         (c_rnt750_p = NULL) => 0.0292992038, 0.0292992038),
      (r_C12_source_profile_d > 76.45) => 0.1683233562,
      (r_C12_source_profile_d = NULL) => 0.0415741537, 0.0415741537),
   (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0332954409, 0.0332954409),
(c_many_cars > 22.5) => -0.0080433316,
(c_many_cars = NULL) => 0.0024231591, -0.0042234184);

// Tree: 168 
woFDN_FLAP_D_lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 4.5) => -0.0072240437,
   (f_idrisktype_i > 4.5) => 0.1024865058,
   (f_idrisktype_i = NULL) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 7.15) => -0.0610631998,
      (c_rnt750_p > 7.15) => 0.0480845643,
      (c_rnt750_p = NULL) => 0.0055091953, 0.0055091953), -0.0065068066),
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.05) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 17.5) => 0.0148544852,
      (f_rel_under500miles_cnt_d > 17.5) => 0.1352536834,
      (f_rel_under500miles_cnt_d = NULL) => 0.0266122194, 0.0266122194),
   (r_C12_source_profile_d > 81.05) => 0.2001927355,
   (r_C12_source_profile_d = NULL) => 0.0426659088, 0.0426659088),
(c_hval_150k_p = NULL) => -0.0095982791, -0.0031960035);

// Tree: 169 
woFDN_FLAP_D_lgt_169 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.1307358310,
   (r_C12_source_profile_d > 57.95) => -0.0098357456,
   (r_C12_source_profile_d = NULL) => 0.0550434436, 0.0550434436),
(f_mos_liens_unrel_SC_fseen_d > 66.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 36.25) => 
      map(
      (NULL < c_unempl and c_unempl <= 192.5) => -0.0071055445,
      (c_unempl > 192.5) => 0.0731472712,
      (c_unempl = NULL) => -0.0065590493, -0.0065590493),
   (c_hval_500k_p > 36.25) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 114.5) => 0.0206266352,
      (c_no_labfor > 114.5) => 0.1612857976,
      (c_no_labfor = NULL) => 0.0558882985, 0.0558882985),
   (c_hval_500k_p = NULL) => 0.0082175245, -0.0044212187),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0059409529, -0.0037719500);

// Tree: 170 
woFDN_FLAP_D_lgt_170 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.35) => 0.1443711729,
      (C_INC_200K_P > 0.35) => 0.0397325385,
      (C_INC_200K_P = NULL) => 0.0546108444, 0.0546108444),
   (f_current_count_d > 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 31.5) => 0.0127864911,
      (c_famotf18_p > 31.5) => -0.1064929984,
      (c_famotf18_p = NULL) => -0.0047202833, -0.0047202833),
   (f_current_count_d = NULL) => 0.0285556428, 0.0285556428),
(r_I60_inq_comm_recency_d > 549) => -0.0013242467,
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 7.75) => -0.0293761520,
   (C_INC_150K_P > 7.75) => 0.0659711084,
   (C_INC_150K_P = NULL) => 0.0033635700, 0.0033635700), 0.0015122376);

// Tree: 171 
woFDN_FLAP_D_lgt_171 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 183.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 23.75) => -0.0790310067,
   (c_fammar_p > 23.75) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 1.5) => -0.0010897567,
      (f_inq_Other_count24_i > 1.5) => 0.0422786104,
      (f_inq_Other_count24_i = NULL) => 0.0013275709, 0.0013275709),
   (c_fammar_p = NULL) => -0.0005883503, 0.0007346731),
(f_curraddrcartheftindex_i > 183.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 11.95) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 9.65) => 0.0078357824,
      (c_femdiv_p > 9.65) => 0.1395370640,
      (c_femdiv_p = NULL) => 0.0242165388, 0.0242165388),
   (c_pop_12_17_p > 11.95) => 0.1389482198,
   (c_pop_12_17_p = NULL) => 0.0350695357, 0.0350695357),
(f_curraddrcartheftindex_i = NULL) => -0.0130811887, 0.0023374475);

// Tree: 172 
woFDN_FLAP_D_lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.55) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 20247.5) => 0.0897043949,
      (r_L80_Inp_AVM_AutoVal_d > 20247.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.74120745405) => -0.0004764920,
         (f_add_curr_nhood_MFD_pct_i > 0.74120745405) => 
            map(
            (NULL < k_inf_contradictory_i and k_inf_contradictory_i <= 0.5) => 0.0351987327,
            (k_inf_contradictory_i > 0.5) => 0.2015927785,
            (k_inf_contradictory_i = NULL) => 0.0680323404, 0.0680323404),
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0178894016, -0.0016833261),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0014109208, 0.0001239478),
   (c_manufacturing > 16.55) => -0.0527562004,
   (c_manufacturing = NULL) => -0.0039506626, -0.0039506626),
(c_pop_0_5_p > 20.55) => 0.1300312954,
(c_pop_0_5_p = NULL) => -0.0005867983, -0.0032693702);

// Tree: 173 
woFDN_FLAP_D_lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0076278068,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 119.5) => 0.2029393206,
      (c_easiqlife > 119.5) => 0.0344273602,
      (c_easiqlife = NULL) => 0.1117264246, 0.1117264246),
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 15.35) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.75) => 0.0696182872,
         (c_pop_55_64_p > 8.75) => 0.0017489385,
         (c_pop_55_64_p = NULL) => 0.0261541821, 0.0261541821),
      (C_INC_25K_P > 15.35) => -0.0421529138,
      (C_INC_25K_P = NULL) => 0.0139579481, 0.0139579481),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0200274676, 0.0200274676),
(f_rel_felony_count_i = NULL) => -0.0225586536, -0.0039321407);

// Tree: 174 
woFDN_FLAP_D_lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 16.5) => 
   map(
   (NULL < c_info and c_info <= 27.55) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0039617456,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0538295023,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0015094731, 0.0015094731),
   (c_info > 27.55) => 0.1919146832,
   (c_info = NULL) => 0.0002492875, 0.0024942356),
(f_srchphonesrchcount_i > 16.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 6.85) => 0.0080677155,
   (c_vacant_p > 6.85) => -0.1697360331,
   (c_vacant_p = NULL) => -0.0817143753, -0.0817143753),
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 3.95) => 0.0350429302,
   (c_femdiv_p > 3.95) => -0.0617753854,
   (c_femdiv_p = NULL) => -0.0240877190, -0.0240877190), 0.0014503948);

// Tree: 175 
woFDN_FLAP_D_lgt_175 := map(
(NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 18.5) => -0.0487937123,
   (f_mos_inq_banko_om_fseen_d > 18.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 18.55) => 0.0128838226,
      (c_pop_0_5_p > 18.55) => 0.1240098812,
      (c_pop_0_5_p = NULL) => 0.0467238024, 0.0144952462),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0283181549, 0.0094152390),
(r_Phn_Cell_n > 0.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 15.35) => 0.1115089241,
   (c_white_col > 15.35) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 14.5) => -0.0168812160,
      (f_rel_criminal_count_i > 14.5) => -0.1137419328,
      (f_rel_criminal_count_i = NULL) => -0.0537533572, -0.0182463066),
   (c_white_col = NULL) => 0.0030573953, -0.0156851818),
(r_Phn_Cell_n = NULL) => -0.0024592289, -0.0024592289);

// Tree: 176 
woFDN_FLAP_D_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 0.0024314856,
   (f_util_adl_count_n > 4.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 209920.5) => 0.0093261984,
         (r_A46_Curr_AVM_AutoVal_d > 209920.5) => 0.2011125930,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 
            map(
            (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0810444345) => 0.1517875610,
            (f_add_input_nhood_BUS_pct_i > 0.0810444345) => -0.0267358114,
            (f_add_input_nhood_BUS_pct_i = NULL) => 0.0941278382, 0.0941278382), 0.0915597145),
      (f_phone_ver_experian_d > 0.5) => 0.0019662695,
      (f_phone_ver_experian_d = NULL) => 0.0482877871, 0.0344952972),
   (f_util_adl_count_n = NULL) => 0.0072044350, 0.0063850412),
(c_pop_18_24_p > 11.15) => -0.0233082388,
(c_pop_18_24_p = NULL) => 0.0089582243, -0.0003104066);

// Tree: 177 
woFDN_FLAP_D_lgt_177 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72490) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => -0.0094173323,
      (f_util_adl_count_n > 1.5) => 0.1190958334,
      (f_util_adl_count_n = NULL) => 0.0500598353, 0.0500598353),
   (f_addrchangevaluediff_d > -72490) => 0.0001150828,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.15) => -0.0147958493,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.15) => 
         map(
         (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1225175559,
         (k_nap_phn_verd_d > 0.5) => 0.0140896514,
         (k_nap_phn_verd_d = NULL) => 0.0534932758, 0.0534932758),
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0039639746, 0.0028569784), 0.0016800850),
(f_inq_PrepaidCards_count24_i > 1.5) => 0.0823648915,
(f_inq_PrepaidCards_count24_i = NULL) => -0.0251682465, 0.0016298501);

// Tree: 178 
woFDN_FLAP_D_lgt_178 := map(
(NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0100931739,
(f_phones_per_addr_c6_i > 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 23.75) => -0.0002721021,
      (c_hh3_p > 23.75) => 0.0777296838,
      (c_hh3_p = NULL) => 0.0092288673, 0.0092288673),
   (f_addrchangeincomediff_d > 1.5) => 
      map(
      (NULL < c_rental and c_rental <= 162.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 0.5) => 0.1010657707,
         (f_addrchangecrimediff_i > 0.5) => -0.0628833702,
         (f_addrchangecrimediff_i = NULL) => 0.0435207080, 0.0435207080),
      (c_rental > 162.5) => 0.1811089508,
      (c_rental = NULL) => 0.0782583337, 0.0782583337),
   (f_addrchangeincomediff_d = NULL) => 0.0237127650, 0.0154885057),
(f_phones_per_addr_c6_i = NULL) => -0.0009858136, -0.0009858136);

// Tree: 179 
woFDN_FLAP_D_lgt_179 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 53.75) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.078796035) => 0.0042093653,
      (f_add_curr_nhood_VAC_pct_i > 0.078796035) => 
         map(
         (NULL < c_unemp and c_unemp <= 4.15) => -0.0136733591,
         (c_unemp > 4.15) => 0.1132622362,
         (c_unemp = NULL) => 0.0559579779, 0.0559579779),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0131590799, 0.0131590799),
   (c_hh2_p > 53.75) => 0.2495738773,
   (c_hh2_p = NULL) => -0.0210606333, 0.0178996284),
(f_hh_members_ct_d > 1.5) => -0.0069204830,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 127.5) => -0.0071200997,
   (c_totcrime > 127.5) => 0.0849295613,
   (c_totcrime = NULL) => 0.0224052633, 0.0224052633), -0.0019384260);

// Tree: 180 
woFDN_FLAP_D_lgt_180 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 148.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 46.5) => 0.0043810737,
   (c_famotf18_p > 46.5) => 0.1387032632,
   (c_famotf18_p = NULL) => 0.0464252947, 0.0060849908),
(f_prevaddrcartheftindex_i > 148.5) => 
   map(
   (NULL < c_retail and c_retail <= 46.35) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => -0.0293579621,
      (f_inq_Communications_count24_i > 1.5) => 0.0622849948,
      (f_inq_Communications_count24_i = NULL) => -0.0259485648, -0.0259485648),
   (c_retail > 46.35) => 0.0923554461,
   (c_retail = NULL) => -0.0230517460, -0.0230517460),
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 6.35) => -0.0381022053,
   (c_professional > 6.35) => 0.0552344908,
   (c_professional = NULL) => 0.0016289559, 0.0016289559), 0.0007569744);

// Tree: 181 
woFDN_FLAP_D_lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 6.75) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1006) => 
         map(
         (NULL < c_robbery and c_robbery <= 77.5) => -0.0810536379,
         (c_robbery > 77.5) => 0.1434815881,
         (c_robbery = NULL) => 0.0619539168, 0.0619539168),
      (c_popover18 > 1006) => -0.0308705671,
      (c_popover18 = NULL) => -0.0023614020, -0.0023614020),
   (c_hval_200k_p > 6.75) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 0.0600052401,
      (f_corrrisktype_i > 8.5) => 0.1988175836,
      (f_corrrisktype_i = NULL) => 0.1067274435, 0.1067274435),
   (c_hval_200k_p = NULL) => 0.0273769136, 0.0273769136),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0054970552,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0029210171, -0.0034066252);

// Tree: 182 
woFDN_FLAP_D_lgt_182 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0103698756,
(f_srchaddrsrchcount_i > 1.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.65) => -0.0214681875,
         (c_pop_75_84_p > 2.65) => 0.1431067289,
         (c_pop_75_84_p = NULL) => 0.0601609710, 0.0601609710),
      (r_C10_M_Hdr_FS_d > 10.5) => 0.0150670707,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0161504845, 0.0161504845),
   (r_I60_inq_comm_count12_i > 0.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 27.8) => -0.0988192262,
      (c_fammar18_p > 27.8) => 0.0074474890,
      (c_fammar18_p = NULL) => -0.0340971116, -0.0340971116),
   (r_I60_inq_comm_count12_i = NULL) => 0.0139160470, 0.0139160470),
(f_srchaddrsrchcount_i = NULL) => -0.0006050549, 0.0003537565);

// Tree: 183 
woFDN_FLAP_D_lgt_183 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0026137941,
   (k_inq_adls_per_addr_i > 3.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 12.25) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => 0.0736774345,
         (f_phones_per_addr_curr_i > 7.5) => -0.0626854207,
         (f_phones_per_addr_curr_i = NULL) => -0.0146485058, -0.0146485058),
      (C_INC_25K_P > 12.25) => -0.1117191825,
      (C_INC_25K_P = NULL) => -0.0428303152, -0.0428303152),
   (k_inq_adls_per_addr_i = NULL) => -0.0034264126, -0.0034264126),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0742378975,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 1.85) => -0.0490547633,
   (c_hh6_p > 1.85) => 0.0438996092,
   (c_hh6_p = NULL) => -0.0038509246, -0.0038509246), -0.0039623534);

// Tree: 184 
woFDN_FLAP_D_lgt_184 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 92.2) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => -0.0013770480,
      (f_util_adl_count_n > 7.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 162.5) => 0.0704822073,
         (c_sub_bus > 162.5) => -0.0608730746,
         (c_sub_bus = NULL) => 0.0441605323, 0.0441605323),
      (f_util_adl_count_n = NULL) => 0.0005950818, 0.0005950818),
   (f_phones_per_addr_curr_i > 50.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 130) => 0.0033464785,
      (r_C13_max_lres_d > 130) => 0.1589559060,
      (r_C13_max_lres_d = NULL) => 0.0624606744, 0.0624606744),
   (f_phones_per_addr_curr_i = NULL) => -0.0023784717, 0.0014576040),
(C_RENTOCC_P > 92.2) => -0.0951909771,
(C_RENTOCC_P = NULL) => 0.0197407892, 0.0011210907);

// Tree: 185 
woFDN_FLAP_D_lgt_185 := map(
(NULL < c_high_ed and c_high_ed <= 4.25) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < c_retired and c_retired <= 11.45) => 0.0330840848,
      (c_retired > 11.45) => 0.2116100228,
      (c_retired = NULL) => 0.0864196347, 0.0864196347),
   (r_C12_Num_NonDerogs_d > 3.5) => -0.0354132049,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0387325384, 0.0387325384),
(c_high_ed > 4.25) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 0.0015211610,
   (f_rel_felony_count_i > 4.5) => 0.0802684056,
   (f_rel_felony_count_i = NULL) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 111.5) => -0.0473427722,
      (c_for_sale > 111.5) => 0.0596206917,
      (c_for_sale = NULL) => -0.0023055242, -0.0023055242), 0.0019062167),
(c_high_ed = NULL) => -0.0069751650, 0.0028552249);

// Tree: 186 
woFDN_FLAP_D_lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3923820453) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.75) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30263) => 0.0373364089,
         (f_curraddrmedianincome_d > 30263) => 0.0020638942,
         (f_curraddrmedianincome_d = NULL) => 0.0043151146, 0.0043151146),
      (c_pop_6_11_p > 15.75) => 0.1376217946,
      (c_pop_6_11_p = NULL) => -0.0350464414, 0.0046396402),
   (f_add_input_mobility_index_i > 0.3923820453) => -0.0261387351,
   (f_add_input_mobility_index_i = NULL) => -0.0026047542, 0.0000416017),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0850717595,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0580866750,
   (k_nap_lname_verd_d > 0.5) => -0.0335515278,
   (k_nap_lname_verd_d = NULL) => 0.0071765623, 0.0071765623), 0.0005131639);

// Tree: 187 
woFDN_FLAP_D_lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 80.45) => -0.0028692108,
      (c_high_hval > 80.45) => 
         map(
         (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0057725411,
         (k_inf_nothing_found_i > 0.5) => 0.1243925099,
         (k_inf_nothing_found_i = NULL) => 0.0408597980, 0.0408597980),
      (c_high_hval = NULL) => -0.0082613362, -0.0006987176),
   (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0683643223,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0010384704, -0.0010384704),
(f_rel_bankrupt_count_i > 7.5) => -0.0844007415,
(f_rel_bankrupt_count_i = NULL) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.85) => -0.0462496463,
   (c_pop_0_5_p > 7.85) => 0.0494468471,
   (c_pop_0_5_p = NULL) => 0.0006843027, 0.0006843027), -0.0020457844);

// Tree: 188 
woFDN_FLAP_D_lgt_188 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 25.05) => -0.0024055657,
   (c_pop_35_44_p > 25.05) => 0.0623482900,
   (c_pop_35_44_p = NULL) => -0.0193775033, -0.0011626577),
(f_srchfraudsrchcount_i > 12.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.85) => 0.0333157746,
      (c_pop_45_54_p > 13.85) => 0.1673740001,
      (c_pop_45_54_p = NULL) => 0.0937023627, 0.0937023627),
   (r_L79_adls_per_addr_curr_i > 3.5) => -0.0371367253,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0417933767, 0.0417933767),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 16.15) => 0.0832269559,
   (C_INC_75K_P > 16.15) => -0.0153882393,
   (C_INC_75K_P = NULL) => 0.0251813031, 0.0251813031), -0.0001532854);

// Tree: 189 
woFDN_FLAP_D_lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0039716503,
   (f_rel_homeover500_count_d > 14.5) => 
      map(
      (NULL < c_burglary and c_burglary <= 45.5) => 0.1945807547,
      (c_burglary > 45.5) => -0.0350333176,
      (c_burglary = NULL) => 0.0808466815, 0.0808466815),
   (f_rel_homeover500_count_d = NULL) => 0.0082911921, -0.0030160442),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 0.0126905315,
   (f_rel_under25miles_cnt_d > 5.5) => 0.1527505089,
   (f_rel_under25miles_cnt_d = NULL) => 0.0630114814, 0.0630114814),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 28.7) => 0.0853290453,
   (c_fammar18_p > 28.7) => -0.0271312987,
   (c_fammar18_p = NULL) => 0.0130331099, 0.0130331099), -0.0019055262);

// Tree: 190 
woFDN_FLAP_D_lgt_190 := map(
(NULL < c_hh2_p and c_hh2_p <= 51.15) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.75) => -0.0096300685,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.75) => 0.1244727869,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 16.65) => -0.0136320287,
      (c_hval_200k_p > 16.65) => 0.0529039596,
      (c_hval_200k_p = NULL) => -0.0084399442, -0.0084399442), -0.0084059748),
(c_hh2_p > 51.15) => 
   map(
   (NULL < f_varmsrcssnunrelcount_i and f_varmsrcssnunrelcount_i <= 0.5) => 0.1632061830,
   (f_varmsrcssnunrelcount_i > 0.5) => 
      map(
      (NULL < c_rape and c_rape <= 17) => 0.2391891178,
      (c_rape > 17) => -0.0092247115,
      (c_rape = NULL) => 0.0219830560, 0.0219830560),
   (f_varmsrcssnunrelcount_i = NULL) => 0.0498860126, 0.0498860126),
(c_hh2_p = NULL) => -0.0237290809, -0.0064484502);

// Tree: 191 
woFDN_FLAP_D_lgt_191 := map(
(NULL < c_totcrime and c_totcrime <= 163.5) => -0.0041231155,
(c_totcrime > 163.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 21.5) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 161.5) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.2146293122,
         (f_corraddrnamecount_d > 3.5) => 0.0558082498,
         (f_corraddrnamecount_d = NULL) => 0.0830590487, 0.0830590487),
      (c_cartheft > 161.5) => -0.0049753820,
      (c_cartheft = NULL) => 0.0229946713, 0.0229946713),
   (f_rel_educationover8_count_d > 21.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 5.85) => 0.1955806592,
      (c_unemp > 5.85) => 0.0123515361,
      (c_unemp = NULL) => 0.1022042792, 0.1022042792),
   (f_rel_educationover8_count_d = NULL) => 0.0279266873, 0.0293791519),
(c_totcrime = NULL) => -0.0323064670, -0.0012472754);

// Tree: 192 
woFDN_FLAP_D_lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 120) => 0.0826739544,
(r_D32_Mos_Since_Fel_LS_d > 120) => 
   map(
   (NULL < c_unempl and c_unempl <= 165.5) => -0.0017124738,
   (c_unempl > 165.5) => 
      map(
      (NULL < c_rental and c_rental <= 190.5) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => -0.1186736086,
         (r_D33_Eviction_Recency_d > 549) => -0.0346188936,
         (r_D33_Eviction_Recency_d = NULL) => -0.0404708042, -0.0404708042),
      (c_rental > 190.5) => 0.0741112641,
      (c_rental = NULL) => -0.0321326724, -0.0321326724),
   (c_unempl = NULL) => 0.0095528836, -0.0035728112),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 1.85) => -0.0503038200,
   (c_high_hval > 1.85) => 0.0492393513,
   (c_high_hval = NULL) => 0.0013342001, 0.0013342001), -0.0030206665);

// Tree: 193 
woFDN_FLAP_D_lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0089404011,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.2047928610,
   (f_adl_per_email_i > 0.5) => -0.0301935425,
   (f_adl_per_email_i = NULL) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 14.35) => 0.2211528148,
         (C_INC_75K_P > 14.35) => 0.0370625297,
         (C_INC_75K_P = NULL) => 0.0900926530, 0.0900926530),
      (f_hh_members_ct_d > 1.5) => 
         map(
         (NULL < c_hval_80k_p and c_hval_80k_p <= 1.55) => 0.0348650503,
         (c_hval_80k_p > 1.55) => -0.0306293888,
         (c_hval_80k_p = NULL) => 0.0092647858, 0.0092647858),
      (f_hh_members_ct_d = NULL) => 0.0163974956, 0.0163974956), 0.0194299613),
(f_prevaddrageoldest_d = NULL) => -0.0169116171, -0.0024698014);

// Tree: 194 
woFDN_FLAP_D_lgt_194 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 45) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 24.15) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 0.95) => -0.0943179399,
      (c_hh5_p > 0.95) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 15.55) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 44762.5) => 0.0130983564,
            (f_prevaddrmedianincome_d > 44762.5) => -0.0621832043,
            (f_prevaddrmedianincome_d = NULL) => -0.0358346581, -0.0358346581),
         (c_vacant_p > 15.55) => 0.0827690812,
         (c_vacant_p = NULL) => -0.0201781066, -0.0201781066),
      (c_hh5_p = NULL) => -0.0364092848, -0.0364092848),
   (c_hval_125k_p > 24.15) => 0.0808435171,
   (c_hval_125k_p = NULL) => -0.0283867247, -0.0283867247),
(r_F01_inp_addr_address_score_d > 45) => 0.0027106894,
(r_F01_inp_addr_address_score_d = NULL) => -0.0051306903, 0.0006332875);

// Tree: 195 
woFDN_FLAP_D_lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 2.15) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 4.5) => 
         map(
         (NULL < c_bargains and c_bargains <= 125.5) => -0.0754979649,
         (c_bargains > 125.5) => 0.0708017640,
         (c_bargains = NULL) => -0.0430536718, -0.0430536718),
      (f_inq_Collection_count_i > 4.5) => -0.1664513503,
      (f_inq_Collection_count_i = NULL) => -0.0547512213, -0.0547512213),
   (c_pop_18_24_p > 2.15) => 0.0061410535,
   (c_pop_18_24_p = NULL) => 0.0034201658, 0.0034201658),
(c_hval_80k_p > 40.05) => -0.1127079064,
(c_hval_80k_p = NULL) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 26.5) => 0.2099886882,
   (f_mos_inq_banko_cm_lseen_d > 26.5) => -0.0060243267,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0331084659, 0.0331084659), 0.0030605488);

// Tree: 196 
woFDN_FLAP_D_lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0910246155,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 44.45) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 25.95) => -0.0016617954,
      (c_hval_60k_p > 25.95) => 0.0765124031,
      (c_hval_60k_p = NULL) => -0.0005294085, -0.0005294085),
   (c_hval_60k_p > 44.45) => -0.1189367140,
   (c_hval_60k_p = NULL) => 0.0242646458, -0.0005122180),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0100067257) => -0.0549212723,
   (f_add_input_nhood_VAC_pct_i > 0.0100067257) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 1.85) => -0.0083044614,
      (c_hval_150k_p > 1.85) => 0.0902788165,
      (c_hval_150k_p = NULL) => 0.0442118642, 0.0442118642),
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0011330667, 0.0011330667), -0.0027493627);

// Tree: 197 
woFDN_FLAP_D_lgt_197 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -91324) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 1.5) => 0.1014414855,
      (f_rel_homeover300_count_d > 1.5) => -0.0549226030,
      (f_rel_homeover300_count_d = NULL) => -0.0003022707, -0.0003022707),
   (r_L79_adls_per_addr_c6_i > 1.5) => 0.1227976128,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0388135801, 0.0388135801),
(f_addrchangevaluediff_d > -91324) => -0.0003774007,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 10.45) => -0.0164501132,
   (c_hh5_p > 10.45) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 137441) => 0.1141588255,
      (r_L80_Inp_AVM_AutoVal_d > 137441) => 0.0530338383,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0013657206, 0.0391501429),
   (c_hh5_p = NULL) => -0.0065287560, -0.0053852210), -0.0008559744);

// Tree: 198 
woFDN_FLAP_D_lgt_198 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0998085258,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5701) => 0.0048929366,
      (f_liens_unrel_SC_total_amt_i > 5701) => 0.1204935826,
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0054548572, 0.0054548572),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 2.5) => 0.0413643764,
      (f_srchaddrsrchcount_i > 2.5) => -0.1002128602,
      (f_srchaddrsrchcount_i = NULL) => -0.0477401781, -0.0477401781),
   (r_I60_inq_comm_count12_i = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 85.5) => 0.0476193370,
      (c_many_cars > 85.5) => -0.0351529999,
      (c_many_cars = NULL) => 0.0032182821, 0.0032182821), 0.0048050443),
(c_pop_45_54_p = NULL) => -0.0295794391, 0.0026252104);

// Tree: 199 
woFDN_FLAP_D_lgt_199 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 27.65) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.67821663315) => 
         map(
         (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 2.5) => 0.0275297540,
         (f_srchphonesrchcount_i > 2.5) => 
            map(
            (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => 0.0293651279,
            (f_crim_rel_under100miles_cnt_i > 0.5) => 0.1843359332,
            (f_crim_rel_under100miles_cnt_i = NULL) => 0.1053885419, 0.1053885419),
         (f_srchphonesrchcount_i = NULL) => 0.0337446461, 0.0337446461),
      (f_add_curr_nhood_SFD_pct_d > 0.67821663315) => -0.0027396787,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0099697166, 0.0099697166),
   (f_phone_ver_experian_d > 0.5) => -0.0080145093,
   (f_phone_ver_experian_d = NULL) => -0.0135711690, -0.0035576107),
(C_INC_25K_P > 27.65) => 0.0830601096,
(C_INC_25K_P = NULL) => -0.0396037890, -0.0037625953);

// Tree: 200 
woFDN_FLAP_D_lgt_200 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 9.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3271977105) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 9.15) => 
         map(
         (NULL < c_child and c_child <= 25.05) => 0.0568207585,
         (c_child > 25.05) => 0.1813582584,
         (c_child = NULL) => 0.1179363834, 0.1179363834),
      (c_high_hval > 9.15) => -0.0160129082,
      (c_high_hval = NULL) => 0.0525488145, 0.0525488145),
   (f_add_curr_mobility_index_i > 0.3271977105) => -0.0168030017,
   (f_add_curr_mobility_index_i = NULL) => 0.0300149436, 0.0300149436),
(r_C21_M_Bureau_ADL_FS_d > 9.5) => -0.0059961462,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1310.5) => 0.0685805505,
   (c_popover18 > 1310.5) => -0.0340401224,
   (c_popover18 = NULL) => 0.0133830673, 0.0133830673), -0.0048461098);

// Tree: 201 
woFDN_FLAP_D_lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0055109938,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 5.55) => 0.0032160677,
   (c_finance > 5.55) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 234980) => 
         map(
         (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => 0.0524231141,
         (f_crim_rel_under500miles_cnt_i > 0.5) => 0.2404171365,
         (f_crim_rel_under500miles_cnt_i = NULL) => 0.1441821012, 0.1441821012),
      (f_curraddrmedianvalue_d > 234980) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.56608381695) => -0.0520250965,
         (f_add_input_nhood_MFD_pct_i > 0.56608381695) => 0.0272882605,
         (f_add_input_nhood_MFD_pct_i = NULL) => -0.0147410398, -0.0147410398),
      (f_curraddrmedianvalue_d = NULL) => 0.0758451506, 0.0758451506),
   (c_finance = NULL) => 0.0826764468, 0.0316017352),
(r_L70_Add_Standardized_i = NULL) => -0.0024272874, -0.0024272874);

// Tree: 202 
woFDN_FLAP_D_lgt_202 := map(
(NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 448.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 14.5) => -0.0026057567,
   (r_D30_Derog_Count_i > 14.5) => 0.0935865879,
   (r_D30_Derog_Count_i = NULL) => -0.0129223710, -0.0020186819),
(r_P88_Phn_Dst_to_Inp_Add_i > 448.5) => -0.0645363616,
(r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 8.55) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 342.5) => 0.0249438756,
      (r_C21_M_Bureau_ADL_FS_d > 342.5) => 
         map(
         (NULL < c_unempl and c_unempl <= 96.5) => 0.0480324677,
         (c_unempl > 96.5) => 0.2618830247,
         (c_unempl = NULL) => 0.1311209007, 0.1311209007),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0362761618, 0.0362761618),
   (c_famotf18_p > 8.55) => -0.0116619138,
   (c_famotf18_p = NULL) => -0.0018756783, 0.0094635990), -0.0001338453);

// Tree: 203 
woFDN_FLAP_D_lgt_203 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 111) => 0.0002390013,
(f_addrchangecrimediff_i > 111) => 0.0807714872,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 35818) => 0.1094882200,
   (r_A46_Curr_AVM_AutoVal_d > 35818) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => 
         map(
         (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 1.5) => -0.0277442476,
         (f_inq_Other_count24_i > 1.5) => 0.1275408162,
         (f_inq_Other_count24_i = NULL) => -0.0200091834, -0.0200091834),
      (f_bus_addr_match_count_d > 6.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 8) => 0.2041488522,
         (C_INC_35K_P > 8) => -0.0270418606,
         (C_INC_35K_P = NULL) => 0.0929155847, 0.0929155847),
      (f_bus_addr_match_count_d = NULL) => -0.0096906947, -0.0096906947),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0137390659, -0.0100042228), -0.0017181468);

// Tree: 204 
woFDN_FLAP_D_lgt_204 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 41) => 0.1389368721,
      (f_curraddrmurderindex_i > 41) => -0.0009040048,
      (f_curraddrmurderindex_i = NULL) => 0.0511644068, 0.0511644068),
   (r_C10_M_Hdr_FS_d > 11.5) => 0.0021703839,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0029245084, 0.0029245084),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.6) => -0.0323045764,
   (c_pop_0_5_p > 8.6) => -0.1148199691,
   (c_pop_0_5_p = NULL) => -0.0632840396, -0.0632840396),
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 0.45) => 0.0482900632,
   (c_wholesale > 0.45) => -0.0503890434,
   (c_wholesale = NULL) => 0.0029845614, 0.0029845614), 0.0014326254);

// Tree: 205 
woFDN_FLAP_D_lgt_205 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 24245.5) => -0.0347090105,
(f_prevaddrmedianincome_d > 24245.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 12.55) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 0.0008113451,
      (r_P85_Phn_Disconnected_i > 0.5) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 145) => 0.0060594877,
         (c_ab_av_edu > 145) => 0.3077290328,
         (c_ab_av_edu = NULL) => 0.1016706003, 0.1016706003),
      (r_P85_Phn_Disconnected_i = NULL) => 0.0024240356, 0.0024240356),
   (c_hh6_p > 12.55) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 176.5) => 0.1545275517,
      (c_bel_edu > 176.5) => -0.0311028732,
      (c_bel_edu = NULL) => 0.0875194959, 0.0875194959),
   (c_hh6_p = NULL) => 0.0039214236, 0.0039214236),
(f_prevaddrmedianincome_d = NULL) => -0.0086346496, 0.0012185710);

// Tree: 206 
woFDN_FLAP_D_lgt_206 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 186.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.27619818655) => -0.0167869031,
   (f_add_curr_mobility_index_i > 0.27619818655) => -0.1531563829,
   (f_add_curr_mobility_index_i = NULL) => -0.0806424532, -0.0806424532),
(f_mos_liens_unrel_FT_fseen_d > 186.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 28.45) => -0.0039970877,
   (c_hval_20k_p > 28.45) => 
      map(
      (NULL < c_rental and c_rental <= 145.5) => 0.0006219871,
      (c_rental > 145.5) => 0.1636955694,
      (c_rental = NULL) => 0.0712444046, 0.0712444046),
   (c_hval_20k_p = NULL) => 0.0190177545, -0.0027664107),
(f_mos_liens_unrel_FT_fseen_d = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 9.35) => -0.0405820371,
   (c_high_hval > 9.35) => 0.0677566847,
   (c_high_hval = NULL) => -0.0008802695, -0.0008802695), -0.0035236826);

// Tree: 207 
woFDN_FLAP_D_lgt_207 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 16.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 20) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => -0.0416634369,
      (r_D33_eviction_count_i > 0.5) => -0.1081560167,
      (r_D33_eviction_count_i = NULL) => -0.0474414128, -0.0474414128),
   (c_hval_300k_p > 20) => 0.1367676310,
   (c_hval_300k_p = NULL) => -0.0351133944, -0.0351133944),
(f_mos_inq_banko_om_fseen_d > 16.5) => 
   map(
   (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => -0.0006744144,
   (f_validationrisktype_i > 1.5) => 
      map(
      (NULL < c_professional and c_professional <= 4.35) => -0.0253719946,
      (c_professional > 4.35) => 0.1426000981,
      (c_professional = NULL) => 0.0294639883, 0.0569747837),
   (f_validationrisktype_i = NULL) => 0.0008444807, 0.0008444807),
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0052615032, -0.0014729468);

// Tree: 208 
woFDN_FLAP_D_lgt_208 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => -0.0025180215,
   (f_addrchangecrimediff_i > 98.5) => 0.0731693446,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 130141) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 21.35) => 0.0122113833,
         (c_hval_250k_p > 21.35) => 0.1939234735,
         (c_hval_250k_p = NULL) => 0.0399860292, 0.0399860292),
      (r_L80_Inp_AVM_AutoVal_d > 130141) => -0.0097559812,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 131.5) => 0.0013060440,
         (c_mort_indx > 131.5) => -0.0829829744,
         (c_mort_indx = NULL) => -0.0017415517, -0.0152252359), -0.0060321990), -0.0028290922),
(r_L72_Add_Vacant_i > 0.5) => 0.0982813193,
(r_L72_Add_Vacant_i = NULL) => -0.0021751204, -0.0021751204);

// Tree: 209 
woFDN_FLAP_D_lgt_209 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 12.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 17.65) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 9.45) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.05821185275) => -0.0047841933,
         (f_add_input_nhood_BUS_pct_i > 0.05821185275) => 0.0409103522,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0169718664, 0.0169718664),
      (c_femdiv_p > 9.45) => 0.1491455264,
      (c_femdiv_p = NULL) => 0.0266131811, 0.0266131811),
   (c_hh2_p > 17.65) => 0.0006224378,
   (c_hh2_p = NULL) => 0.0245593761, 0.0027044132),
(f_inq_count24_i > 12.5) => -0.0722452855,
(f_inq_count24_i = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 66.5) => -0.0592935537,
   (c_serv_empl > 66.5) => 0.0457903619,
   (c_serv_empl = NULL) => 0.0032247252, 0.0032247252), 0.0017609743);

// Tree: 210 
woFDN_FLAP_D_lgt_210 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0005454011,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 85) => 0.0313157452,
   (r_F01_inp_addr_address_score_d > 85) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.06151789385) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 87.5) => 0.0278006309,
         (c_ab_av_edu > 87.5) => 
            map(
            (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 3.5) => -0.0277570708,
            (r_D30_Derog_Count_i > 3.5) => -0.1244463001,
            (r_D30_Derog_Count_i = NULL) => -0.0499694613, -0.0499694613),
         (c_ab_av_edu = NULL) => -0.0220980988, -0.0220980988),
      (f_add_input_nhood_VAC_pct_i > 0.06151789385) => -0.1008439218,
      (f_add_input_nhood_VAC_pct_i = NULL) => -0.0394607635, -0.0394607635),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0312406572, -0.0312406572),
(f_srchfraudsrchcount_i = NULL) => -0.0050746648, -0.0007978368);

// Tree: 211 
woFDN_FLAP_D_lgt_211 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => -0.0035427201,
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 37.6) => 
      map(
      (NULL < c_white_col and c_white_col <= 31.55) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 5.65) => -0.0887132483,
         (c_pop_65_74_p > 5.65) => 0.1170769983,
         (c_pop_65_74_p = NULL) => -0.0024629243, -0.0024629243),
      (c_white_col > 31.55) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0689137419,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.1515783121,
         (nf_seg_FraudPoint_3_0 = '') => 0.1050794913, 0.1050794913),
      (c_white_col = NULL) => 0.0556681112, 0.0556681112),
   (c_high_ed > 37.6) => -0.0339406590,
   (c_high_ed = NULL) => 0.0295143553, 0.0295143553),
(f_srchaddrsrchcount_i = NULL) => 0.0030376364, -0.0023537885);

// Tree: 212 
woFDN_FLAP_D_lgt_212 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00477897935) => -0.0394518103,
   (f_add_curr_nhood_BUS_pct_i > 0.00477897935) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 4.47) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 20.15) => -0.0014124133,
         (c_hh3_p > 20.15) => 0.0240268657,
         (c_hh3_p = NULL) => 0.0054178254, 0.0054178254),
      (c_hhsize > 4.47) => -0.1101233516,
      (c_hhsize = NULL) => -0.0156680995, 0.0047549656),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0184327015, -0.0009636547),
(r_C14_addrs_10yr_i > 10.5) => 0.0993793621,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 8.05) => -0.0270484018,
   (c_hval_300k_p > 8.05) => 0.0602914500,
   (c_hval_300k_p = NULL) => 0.0073775252, 0.0073775252), -0.0003917330);

// Tree: 213 
woFDN_FLAP_D_lgt_213 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 74.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125511) => 
      map(
      (NULL < c_families and c_families <= 1369) => 0.0213669668,
      (c_families > 1369) => 0.2063111391,
      (c_families = NULL) => 0.0276684719, 0.0276684719),
   (r_A46_Curr_AVM_AutoVal_d > 125511) => -0.0113427668,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0013314207, 0.0000829100),
(k_comb_age_d > 74.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 19.1) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 136) => -0.0088587820,
      (c_totcrime > 136) => 0.1340507675,
      (c_totcrime = NULL) => 0.0238175062, 0.0238175062),
   (c_hval_500k_p > 19.1) => 0.2132619152,
   (c_hval_500k_p = NULL) => 0.0467526647, 0.0467526647),
(k_comb_age_d = NULL) => 0.0016356250, 0.0016356250);

// Tree: 214 
woFDN_FLAP_D_lgt_214 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 39048.5) => -0.1330618083,
         (r_A46_Curr_AVM_AutoVal_d > 39048.5) => -0.0612100265,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0130448627, -0.0378174151),
      (C_INC_150K_P > 0.55) => 0.0028231082,
      (C_INC_150K_P = NULL) => 0.0077879598, 0.0007695885),
   (r_L70_Add_Standardized_i > 0.5) => 0.0389405073,
   (r_L70_Add_Standardized_i = NULL) => 0.0039226382, 0.0039226382),
(f_inq_PrepaidCards_count24_i > 1.5) => 0.0861327036,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 92.5) => 0.0541330308,
   (c_very_rich > 92.5) => -0.0481771561,
   (c_very_rich = NULL) => -0.0058194354, -0.0058194354), 0.0041297583);

// Tree: 215 
woFDN_FLAP_D_lgt_215 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 42.5) => 0.1270006896,
(f_mos_liens_unrel_FT_fseen_d > 42.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 11.5) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 98) => 0.1785423890,
         (f_curraddrmurderindex_i > 98) => 0.0194252573,
         (f_curraddrmurderindex_i = NULL) => 0.0989838232, 0.0989838232),
      (f_rel_under100miles_cnt_d > 11.5) => -0.0364431947,
      (f_rel_under100miles_cnt_d = NULL) => 0.0559217760, 0.0559217760),
   (r_I60_inq_hiRiskCred_recency_d > 9) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 18.45) => -0.0068489113,
      (C_INC_50K_P > 18.45) => 0.0236938417,
      (C_INC_50K_P = NULL) => 0.0406745381, -0.0014009615),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0003835887, -0.0003835887),
(f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0081273641, 0.0000387595);

// Tree: 216 
woFDN_FLAP_D_lgt_216 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 87.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1889.5) => -0.0017209813,
      (c_popover18 > 1889.5) => 0.0342463047,
      (c_popover18 = NULL) => 0.0050835480, 0.0050835480),
   (c_asian_lang > 181.5) => -0.0270889224,
   (c_asian_lang = NULL) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2141259506) => 
         map(
         (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.20072381555) => 0.0895080528,
         (f_add_input_mobility_index_i > 0.20072381555) => 0.1019079792,
         (f_add_input_mobility_index_i = NULL) => 0.0956466302, 0.0956466302),
      (f_add_curr_mobility_index_i > 0.2141259506) => -0.0782453096,
      (f_add_curr_mobility_index_i = NULL) => -0.0306045554, -0.0013092183), 0.0003236194),
(k_comb_age_d > 87.5) => -0.0926654175,
(k_comb_age_d = NULL) => -0.0001015907, -0.0001015907);

// Tree: 217 
woFDN_FLAP_D_lgt_217 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -46332) => -0.0811676423,
(f_addrchangeincomediff_d > -46332) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => -0.0024327562,
   (r_L79_adls_per_addr_curr_i > 5.5) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 53.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 89.5) => 0.1870906173,
         (c_easiqlife > 89.5) => 0.0515096217,
         (c_easiqlife = NULL) => 0.0762000906, 0.0762000906),
      (c_no_teens > 53.5) => 0.0046426588,
      (c_no_teens = NULL) => 0.0263456395, 0.0263456395),
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0006397975, 0.0006397975),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 29.55) => -0.0084563679,
   (c_hval_150k_p > 29.55) => 0.0905703472,
   (c_hval_150k_p = NULL) => 0.0153315021, -0.0029255298), -0.0006898523);

// Tree: 218 
woFDN_FLAP_D_lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_hval_1001k_p and c_hval_1001k_p <= 14.35) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => 0.0032851916,
      (f_inq_count_i > 5.5) => 0.1290672871,
      (f_inq_count_i = NULL) => 0.0181911867, 0.0181911867),
   (c_hval_1001k_p > 14.35) => 0.2655918924,
   (c_hval_1001k_p = NULL) => 0.0696202316, 0.0425723841),
(f_rel_incomeover25_count_d > 1.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0087482344,
   (f_inq_Other_count_i > 0.5) => 0.0176988419,
   (f_inq_Other_count_i = NULL) => -0.0025650219, -0.0025650219),
(f_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 537.5) => 0.0549709343,
   (c_med_rent > 537.5) => -0.0307594116,
   (c_med_rent = NULL) => -0.0161717873, -0.0161717873), -0.0001293446);

// Tree: 219 
woFDN_FLAP_D_lgt_219 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 145) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 13.25) => 0.1421671845,
      (c_lowinc > 13.25) => -0.0297564853,
      (c_lowinc = NULL) => 0.0213759855, 0.0213759855),
   (f_fp_prevaddrburglaryindex_i > 145) => 0.1554324066,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0427907492, 0.0427907492),
(r_F00_dob_score_d > 92) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 25.15) => 0.0043588308,
   (c_pop_45_54_p > 25.15) => -0.0826125972,
   (c_pop_45_54_p = NULL) => -0.0282582295, 0.0015081148),
(r_F00_dob_score_d = NULL) => 
   map(
   (NULL < c_retired2 and c_retired2 <= 47.5) => 0.0427115643,
   (c_retired2 > 47.5) => -0.0377253885,
   (c_retired2 = NULL) => 0.0310547012, -0.0179000683), 0.0015689695);

// Tree: 220 
woFDN_FLAP_D_lgt_220 := map(
(NULL < c_food and c_food <= 61.05) => -0.0052974985,
(c_food > 61.05) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.91311896135) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.22472891255) => -0.1147110503,
      (f_add_curr_mobility_index_i > 0.22472891255) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 127.5) => 0.0318502231,
         (r_pb_order_freq_d > 127.5) => -0.0930179265,
         (r_pb_order_freq_d = NULL) => 0.0756487595, 0.0275495223),
      (f_add_curr_mobility_index_i = NULL) => -0.0050353016, -0.0050353016),
   (f_add_input_nhood_SFD_pct_d > 0.91311896135) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 1.5) => -0.0352147860,
      (f_srchvelocityrisktype_i > 1.5) => 0.1919968145,
      (f_srchvelocityrisktype_i = NULL) => 0.1270792144, 0.1270792144),
   (f_add_input_nhood_SFD_pct_d = NULL) => 0.0423963548, 0.0423963548),
(c_food = NULL) => -0.0152227153, -0.0033712644);

// Tree: 221 
woFDN_FLAP_D_lgt_221 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0037081532,
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < r_I60_inq_banking_count12_i and r_I60_inq_banking_count12_i <= 1.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 16.45) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 2.5) => -0.0303221530,
         (f_srchfraudsrchcount_i > 2.5) => -0.1386714097,
         (f_srchfraudsrchcount_i = NULL) => -0.0779958259, -0.0779958259),
      (c_high_ed > 16.45) => -0.0231350308,
      (c_high_ed = NULL) => -0.0389776696, -0.0389776696),
   (r_I60_inq_banking_count12_i > 1.5) => 
      map(
      (NULL < c_business and c_business <= 24.5) => 0.1191205171,
      (c_business > 24.5) => -0.0256293605,
      (c_business = NULL) => 0.0460289947, 0.0460289947),
   (r_I60_inq_banking_count12_i = NULL) => -0.0267498784, -0.0267498784),
(f_varrisktype_i = NULL) => -0.0088458109, 0.0017979715);

// Tree: 222 
woFDN_FLAP_D_lgt_222 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0038688956,
(f_addrchangecrimediff_i > 61.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 12.5) => 
      map(
      (NULL < c_health and c_health <= 11.25) => -0.0611253719,
      (c_health > 11.25) => 0.1058771019,
      (c_health = NULL) => 0.0111985341, 0.0111985341),
   (f_rel_ageover20_count_d > 12.5) => 0.1566068024,
   (f_rel_ageover20_count_d = NULL) => 0.0528604537, 0.0528604537),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 984.5) => -0.0385745294,
   (c_popover18 > 984.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1957.5) => 0.0824739866,
      (c_med_yearblt > 1957.5) => 0.0038505701,
      (c_med_yearblt = NULL) => 0.0142170137, 0.0142170137),
   (c_popover18 = NULL) => 0.0086915979, -0.0021681739), -0.0026755438);

// Tree: 223 
woFDN_FLAP_D_lgt_223 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 27052) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','6: Other']) => -0.0091067587,
   (nf_seg_FraudPoint_3_0 in ['3: Derog','5: Vuln Vic/Friendly']) => 0.0180372411,
   (nf_seg_FraudPoint_3_0 = '') => 0.0010300988, 0.0010300988),
(f_addrchangeincomediff_d > 27052) => -0.0609363502,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 4.5) => 
      map(
      (NULL < c_trailer_p and c_trailer_p <= 29.05) => -0.0086571896,
      (c_trailer_p > 29.05) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.25) => 0.2741737594,
         (c_pop_6_11_p > 7.25) => -0.0085957153,
         (c_pop_6_11_p = NULL) => 0.1006561272, 0.1006561272),
      (c_trailer_p = NULL) => -0.0097246518, -0.0033564973),
   (f_inq_QuizProvider_count_i > 4.5) => 0.1450182803,
   (f_inq_QuizProvider_count_i = NULL) => 0.0048866734, -0.0000785539), -0.0001863178);

// Tree: 224 
woFDN_FLAP_D_lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 7.9) => -0.0553480125,
      (c_famotf18_p > 7.9) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 40500) => -0.0041145420,
         (k_estimated_income_d > 40500) => 0.1435573679,
         (k_estimated_income_d = NULL) => 0.0643515254, 0.0643515254),
      (c_famotf18_p = NULL) => 0.0104867333, 0.0104867333),
   (c_hval_20k_p > 0.65) => 0.1802844435,
   (c_hval_20k_p = NULL) => 0.0455243561, 0.0455243561),
(r_C10_M_Hdr_FS_d > 10.5) => 0.0020333203,
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 67.5) => -0.0548175027,
   (c_serv_empl > 67.5) => 0.0515635611,
   (c_serv_empl = NULL) => 0.0066138158, 0.0066138158), 0.0029789089);

// Tree: 225 
woFDN_FLAP_D_lgt_225 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.25) => -0.0112689850,
(c_pop_35_44_p > 14.25) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 19375.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 2.2) => 0.1470972089,
      (c_hval_200k_p > 2.2) => -0.0170941506,
      (c_hval_200k_p = NULL) => 0.0673742367, 0.0673742367),
   (f_curraddrmedianincome_d > 19375.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -1029.5) => -0.0038468468,
      (r_A49_Curr_AVM_Chg_1yr_i > -1029.5) => 
         map(
         (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 2.5) => 0.0572586350,
         (f_hh_members_w_derog_i > 2.5) => -0.0468293905,
         (f_hh_members_w_derog_i = NULL) => 0.0468744396, 0.0468744396),
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0036400757, 0.0130693666),
   (f_curraddrmedianincome_d = NULL) => 0.0366264153, 0.0147992055),
(c_pop_35_44_p = NULL) => -0.0121335657, 0.0023633613);

// Tree: 226 
woFDN_FLAP_D_lgt_226 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 18.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 14.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0747382294,
      (r_D33_Eviction_Recency_d > 30) => 0.0022157033,
      (r_D33_Eviction_Recency_d = NULL) => 0.0027835904, 0.0027835904),
   (f_rel_under100miles_cnt_d > 14.5) => 
      map(
      (NULL < c_health and c_health <= 4.75) => -0.0595674239,
      (c_health > 4.75) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => 0.0352144116,
         (r_C14_Addr_Stability_v2_d > 3.5) => -0.0309538222,
         (r_C14_Addr_Stability_v2_d = NULL) => -0.0073103750, -0.0073103750),
      (c_health = NULL) => -0.0283627253, -0.0283627253),
   (f_rel_under100miles_cnt_d = NULL) => -0.0087919248, -0.0008119587),
(r_D30_Derog_Count_i > 18.5) => -0.1035372527,
(r_D30_Derog_Count_i = NULL) => -0.0038365631, -0.0013419602);

// Tree: 227 
woFDN_FLAP_D_lgt_227 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 26965.5) => 0.0012124412,
(f_addrchangeincomediff_d > 26965.5) => -0.0597078003,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 112.65) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0092239411) => 0.1523235452,
      (f_add_curr_nhood_MFD_pct_i > 0.0092239411) => 0.0048571909,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0577565179, 0.0085379809),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 112.65) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 76.5) => 0.1800341127,
      (c_mort_indx > 76.5) => 
         map(
         (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 12.5) => -0.0311958870,
         (f_rel_homeover100_count_d > 12.5) => 0.1313804575,
         (f_rel_homeover100_count_d = NULL) => 0.0236051280, 0.0236051280),
      (c_mort_indx = NULL) => 0.0729404232, 0.0729404232),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0066229060, 0.0036139403), 0.0008592733);

// Tree: 228 
woFDN_FLAP_D_lgt_228 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 13.5) => -0.0411918106,
   (c_no_teens > 13.5) => -0.0002337758,
   (c_no_teens = NULL) => 0.0060587306, -0.0022768254),
(f_assocsuspicousidcount_i > 9.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 282.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 0.0576753758,
      (f_hh_criminals_i > 0.5) => -0.0567958162,
      (f_hh_criminals_i = NULL) => 0.0004397798, 0.0004397798),
   (r_C10_M_Hdr_FS_d > 282.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0334700354,
      (f_inq_Collection_count_i > 1.5) => -0.1426142717,
      (f_inq_Collection_count_i = NULL) => -0.0975482645, -0.0975482645),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0428312939, -0.0428312939),
(f_assocsuspicousidcount_i = NULL) => -0.0017671733, -0.0033918352);

// Tree: 229 
woFDN_FLAP_D_lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 50.1) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 19.45) => -0.0041244805,
      (c_hval_150k_p > 19.45) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
            map(
            (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.11721769) => 0.0113070573,
            (f_add_curr_nhood_VAC_pct_i > 0.11721769) => 0.1118163121,
            (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0200354926, 0.0200354926),
         (r_L79_adls_per_addr_c6_i > 4.5) => 0.1236352749,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0255424577, 0.0255424577),
      (c_hval_150k_p = NULL) => -0.0010579460, -0.0010579460),
   (c_hval_500k_p > 50.1) => 0.0922456830,
   (c_hval_500k_p = NULL) => 0.0213867738, 0.0000774889),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0609084603,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0246192288, -0.0027653040);

// Tree: 230 
woFDN_FLAP_D_lgt_230 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
         map(
         (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 0.0007985988,
         (f_acc_damage_amt_total_i > 275) => 
            map(
            (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 94) => -0.0067611926,
            (f_curraddrcrimeindex_i > 94) => 0.1671045712,
            (f_curraddrcrimeindex_i = NULL) => 0.0567429694, 0.0567429694),
         (f_acc_damage_amt_total_i = NULL) => 0.0020820606, 0.0020820606),
      (f_fp_prevaddrcrimeindex_i > 197.5) => -0.0988827218,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0014859887, 0.0014859887),
   (f_inq_count24_i > 14.5) => -0.0918254793,
   (f_inq_count24_i = NULL) => -0.0107812307, 0.0006087718),
(f_bus_addr_match_count_d > 52.5) => 0.1274532206,
(f_bus_addr_match_count_d = NULL) => 0.0012587434, 0.0012587434);

// Tree: 231 
woFDN_FLAP_D_lgt_231 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0009625317,
(f_srchvelocityrisktype_i > 6.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 37.5) => -0.0558948825,
   (f_mos_inq_banko_cm_fseen_d > 37.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 15.4) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 142.5) => -0.0077711211,
         (c_exp_prod > 142.5) => 0.1183225453,
         (c_exp_prod = NULL) => 0.0231749435, 0.0231749435),
      (c_rnt500_p > 15.4) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03975503185) => 0.1972961100,
         (f_add_curr_nhood_BUS_pct_i > 0.03975503185) => 0.0433584858,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1164788573, 0.1164788573),
      (c_rnt500_p = NULL) => 0.0519928612, 0.0519928612),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0319565660, 0.0319565660),
(f_srchvelocityrisktype_i = NULL) => 0.0091671700, 0.0004560117);

// Tree: 232 
woFDN_FLAP_D_lgt_232 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1077007899,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.0603361273,
   (r_D32_Mos_Since_Fel_LS_d > 127.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 2.35) => -0.1312730979,
      (c_pop_35_44_p > 2.35) => -0.0010047611,
      (c_pop_35_44_p = NULL) => -0.0045265123, -0.0019742805),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0016037131, -0.0016037131),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 48) => -0.0714930115,
   (c_bel_edu > 48) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 2.2) => -0.0206036755,
      (c_high_hval > 2.2) => 0.0795242307,
      (c_high_hval = NULL) => 0.0254010381, 0.0254010381),
   (c_bel_edu = NULL) => -0.0059122828, -0.0059122828), -0.0012201730);

// Tree: 233 
woFDN_FLAP_D_lgt_233 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.35) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184) => 
      map(
      (NULL < r_wealth_index_d and r_wealth_index_d <= 3.5) => -0.1401693341,
      (r_wealth_index_d > 3.5) => -0.0128126836,
      (r_wealth_index_d = NULL) => -0.0672686307, -0.0672686307),
   (f_mos_liens_unrel_FT_lseen_d > 184) => 
      map(
      (NULL < c_unempl and c_unempl <= 70.5) => 
         map(
         (NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 4.5) => 0.1564190642,
         (r_I60_inq_retail_recency_d > 4.5) => -0.0269226120,
         (r_I60_inq_retail_recency_d = NULL) => -0.0242626826, -0.0242626826),
      (c_unempl > 70.5) => 0.0039107241,
      (c_unempl = NULL) => -0.0049631031, -0.0049631031),
   (f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0023672911, -0.0056604371),
(c_hh6_p > 17.35) => -0.1091179228,
(c_hh6_p = NULL) => -0.0098349651, -0.0062967239);

// Tree: 234 
woFDN_FLAP_D_lgt_234 := map(
(NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 55) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.0635985228,
      (r_I60_inq_comm_recency_d > 549) => -0.0630188861,
      (r_I60_inq_comm_recency_d = NULL) => -0.0462088661, -0.0462088661),
   (r_F01_inp_addr_address_score_d > 55) => -0.0142358939,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0102441506, -0.0163457589),
(f_util_add_input_conv_n > 0.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 418.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','5: Vuln Vic/Friendly','6: Other']) => -0.0062238314,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity']) => 0.1780209984,
      (nf_seg_FraudPoint_3_0 = '') => 0.0823279473, 0.0823279473),
   (c_popover25 > 418.5) => 0.0046210950,
   (c_popover25 = NULL) => 0.0062157347, 0.0060567613),
(f_util_add_input_conv_n = NULL) => -0.0038596874, -0.0038596874);

// Tree: 235 
woFDN_FLAP_D_lgt_235 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 5.5) => 0.0350773497,
      (r_C14_addrs_15yr_i > 5.5) => -0.0294113185,
      (r_C14_addrs_15yr_i = NULL) => 0.0216169263, 0.0216169263),
   (f_hh_members_ct_d > 1.5) => -0.0073147313,
   (f_hh_members_ct_d = NULL) => -0.0018486937, -0.0018486937),
(f_inq_QuizProvider_count_i > 6.5) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 111.5) => -0.0224821078,
   (c_rich_fam > 111.5) => 0.1589690281,
   (c_rich_fam = NULL) => 0.0682434601, 0.0682434601),
(f_inq_QuizProvider_count_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 7.75) => -0.0335116564,
   (c_high_hval > 7.75) => 0.0744075298,
   (c_high_hval = NULL) => 0.0033387974, 0.0033387974), -0.0011181559);

// Tree: 236 
woFDN_FLAP_D_lgt_236 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.65) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 5.5) => -0.0515772025,
   (f_hh_age_18_plus_d > 5.5) => 0.0628574478,
   (f_hh_age_18_plus_d = NULL) => -0.0419338331, -0.0419338331),
(c_pop_45_54_p > 7.65) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0007581463,
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 9.05) => 0.0255399640,
         (c_pop_18_24_p > 9.05) => 0.1918964164,
         (c_pop_18_24_p = NULL) => 0.1040099887, 0.1040099887),
      (f_corraddrnamecount_d > 3.5) => 0.0101286777,
      (f_corraddrnamecount_d = NULL) => 0.0285231675, 0.0285231675),
   (f_rel_felony_count_i = NULL) => 0.0038887171, 0.0021096773),
(c_pop_45_54_p = NULL) => 0.0066907439, -0.0009063646);

// Tree: 237 
woFDN_FLAP_D_lgt_237 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 5.35) => -0.0277316889,
   (C_INC_35K_P > 5.35) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 12.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 107057.5) => -0.0004587323,
         (f_curraddrmedianincome_d > 107057.5) => 0.0912753072,
         (f_curraddrmedianincome_d = NULL) => 0.0024834946, 0.0024834946),
      (f_hh_members_ct_d > 12.5) => 0.1187760493,
      (f_hh_members_ct_d = NULL) => 0.0034460674, 0.0034460674),
   (C_INC_35K_P = NULL) => 0.0112774647, -0.0054913336),
(f_hh_collections_ct_i > 4.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 103.5) => 0.1749118320,
   (c_easiqlife > 103.5) => 0.0120673895,
   (c_easiqlife = NULL) => 0.0631728263, 0.0631728263),
(f_hh_collections_ct_i = NULL) => -0.0034871716, -0.0044111887);

// Tree: 238 
woFDN_FLAP_D_lgt_238 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 10.5) => -0.0062514084,
(f_rel_criminal_count_i > 10.5) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.01273358415) => -0.0818622892,
   (f_add_input_nhood_BUS_pct_i > 0.01273358415) => 
      map(
      (NULL < c_food and c_food <= 11) => 0.1435440547,
      (c_food > 11) => 
         map(
         (NULL < k_inq_lnames_per_addr_i and k_inq_lnames_per_addr_i <= 0.5) => 0.0843926218,
         (k_inq_lnames_per_addr_i > 0.5) => -0.0721643773,
         (k_inq_lnames_per_addr_i = NULL) => 0.0184057874, 0.0184057874),
      (c_food = NULL) => 0.0634290794, 0.0634290794),
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0331600443, 0.0331600443),
(f_rel_criminal_count_i = NULL) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 10.05) => 0.0264219212,
   (c_pop_18_24_p > 10.05) => -0.0716493939,
   (c_pop_18_24_p = NULL) => -0.0064754187, -0.0064754187), -0.0054716929);

// Tree: 239 
woFDN_FLAP_D_lgt_239 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 30.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 23.5) => -0.0030061064,
   (f_rel_homeover300_count_d > 23.5) => 0.1674294174,
   (f_rel_homeover300_count_d = NULL) => -0.0022927530, -0.0022927530),
(f_rel_homeover200_count_d > 30.5) => -0.0864833437,
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 10.15) => -0.0506987955,
   (c_hh4_p > 10.15) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.05) => -0.0001886137,
      (c_pop_0_5_p > 8.05) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1444555243,
         (r_Phn_Cell_n > 0.5) => 0.0190857214,
         (r_Phn_Cell_n = NULL) => 0.0871744937, 0.0871744937),
      (c_pop_0_5_p = NULL) => 0.0450529955, 0.0450529955),
   (c_hh4_p = NULL) => 0.0079033935, 0.0079033935), -0.0026274959);

// Tree: 240 
woFDN_FLAP_D_lgt_240 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 16.95) => 
      map(
      (NULL < c_white_col and c_white_col <= 46.5) => 0.0661614846,
      (c_white_col > 46.5) => -0.1053875064,
      (c_white_col = NULL) => 0.0419020313, 0.0419020313),
   (c_hh2_p > 16.95) => 0.0103838538,
   (c_hh2_p = NULL) => -0.0290017439, 0.0113148630),
(f_dl_addrs_per_adl_i > 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 63.5) => -0.0133480735,
   (f_addrchangecrimediff_i > 63.5) => 0.0816370169,
   (f_addrchangecrimediff_i = NULL) => -0.0274338562, -0.0146304743),
(f_dl_addrs_per_adl_i = NULL) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 24.25) => -0.0454084900,
   (c_high_ed > 24.25) => 0.0528221538,
   (c_high_ed = NULL) => 0.0139126130, 0.0139126130), 0.0011004022);

// Tree: 241 
woFDN_FLAP_D_lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0142672855) => 0.1536918886,
      (f_add_input_nhood_BUS_pct_i > 0.0142672855) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 57.5) => 0.1202109160,
         (c_new_homes > 57.5) => -0.0380246275,
         (c_new_homes = NULL) => 0.0170138224, 0.0170138224),
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0535025369, 0.0535025369),
   (r_F00_dob_score_d > 95) => -0.0028037309,
   (r_F00_dob_score_d = NULL) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 180.5) => -0.0258609450,
      (c_rich_blk > 180.5) => 0.0940692988,
      (c_rich_blk = NULL) => -0.0221863170, -0.0115115418), -0.0019826216),
(k_comb_age_d > 67.5) => 0.0430042267,
(k_comb_age_d = NULL) => 0.0015144639, 0.0015144639);

// Tree: 242 
woFDN_FLAP_D_lgt_242 := map(
(NULL < c_incollege and c_incollege <= 3.25) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 238017) => -0.0585993269,
   (r_L80_Inp_AVM_AutoVal_d > 238017) => 0.0112698987,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0000677611, -0.0180733413),
(c_incollege > 3.25) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0050932005,
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < c_finance and c_finance <= 18.45) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 23.75) => 0.0114439156,
         (c_hval_150k_p > 23.75) => 0.1350987847,
         (c_hval_150k_p = NULL) => 0.0192277679, 0.0192277679),
      (c_finance > 18.45) => 0.1642575163,
      (c_finance = NULL) => 0.0264737659, 0.0264737659),
   (f_srchvelocityrisktype_i = NULL) => 0.0128701598, 0.0080227751),
(c_incollege = NULL) => -0.0249718190, 0.0023125680);

// Tree: 243 
woFDN_FLAP_D_lgt_243 := map(
(NULL < c_info and c_info <= 27.85) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 89.45) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 409.5) => -0.0001308069,
         (f_M_Bureau_ADL_FS_noTU_d > 409.5) => 0.0640867705,
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0007773747, 0.0007773747),
      (r_C12_source_profile_d > 89.45) => 0.1411876772,
      (r_C12_source_profile_d = NULL) => 0.0072909780, 0.0015812234),
   (f_adls_per_phone_c6_i > 1.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 8.15) => 0.1884109004,
      (C_INC_125K_P > 8.15) => 0.0250905577,
      (C_INC_125K_P = NULL) => 0.0817723237, 0.0817723237),
   (f_adls_per_phone_c6_i = NULL) => 0.0026873076, 0.0026873076),
(c_info > 27.85) => 0.1583917492,
(c_info = NULL) => 0.0204558847, 0.0038548894);

// Tree: 244 
woFDN_FLAP_D_lgt_244 := map(
(NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 4.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => -0.0097495525,
   (f_curraddrcrimeindex_i > 121) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 99.65) => 0.0117698318,
      (c_lowrent > 99.65) => 0.1955477832,
      (c_lowrent = NULL) => 0.0153344904, 0.0153344904),
   (f_curraddrcrimeindex_i = NULL) => -0.0031750650, -0.0031750650),
(f_hh_workers_paw_d > 4.5) => -0.0923158995,
(f_hh_workers_paw_d = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0215374804) => -0.0042376907,
      (f_add_input_nhood_VAC_pct_i > 0.0215374804) => 0.0896076783,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0348645463, 0.0348645463),
   (k_nap_phn_verd_d > 0.5) => -0.0997891332,
   (k_nap_phn_verd_d = NULL) => -0.0100200135, -0.0100200135), -0.0038765394);

// Tree: 245 
woFDN_FLAP_D_lgt_245 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 16) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 55.9) => -0.1009973615,
   (c_fammar_p > 55.9) => -0.0265131388,
   (c_fammar_p = NULL) => -0.0006923097, -0.0268109047),
(f_curraddrburglaryindex_i > 16) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 18.65) => 0.0036787004,
   (c_hh5_p > 18.65) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0178101141,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.1430759908,
      (nf_seg_FraudPoint_3_0 = '') => 0.0456861824, 0.0456861824),
   (c_hh5_p = NULL) => 0.0050830376, 0.0050830376),
(f_curraddrburglaryindex_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 14.55) => -0.0620532875,
   (c_hh4_p > 14.55) => 0.0299661949,
   (c_hh4_p = NULL) => -0.0216116042, -0.0216116042), 0.0000535989);

// Tree: 246 
woFDN_FLAP_D_lgt_246 := map(
(NULL < c_hhsize and c_hhsize <= 4.255) => 
   map(
   (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 2.5) => -0.0032873170,
   (r_C20_email_domain_free_count_i > 2.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 97.5) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0194912348) => 0.1734690719,
         (f_add_input_nhood_BUS_pct_i > 0.0194912348) => 0.0159975808,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0692738637, 0.0692738637),
      (c_lux_prod > 97.5) => -0.0018114811,
      (c_lux_prod = NULL) => 0.0226982283, 0.0226982283),
   (r_C20_email_domain_free_count_i = NULL) => 0.0208928693, -0.0008879792),
(c_hhsize > 4.255) => 
   map(
   (NULL < c_rnt2000_p and c_rnt2000_p <= 4.5) => -0.0206815747,
   (c_rnt2000_p > 4.5) => 0.1581917780,
   (c_rnt2000_p = NULL) => 0.0708677790, 0.0708677790),
(c_hhsize = NULL) => -0.0291608014, -0.0008716573);

// Tree: 247 
woFDN_FLAP_D_lgt_247 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 11.05) => -0.0017197756,
      (c_hh7p_p > 11.05) => -0.0535948942,
      (c_hh7p_p = NULL) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => 0.0226736648,
         (r_C14_Addr_Stability_v2_d > 4.5) => -0.0351969241,
         (r_C14_Addr_Stability_v2_d = NULL) => -0.0126186262, -0.0126186262), -0.0029336841),
   (r_D33_eviction_count_i > 3.5) => 0.0702918923,
   (r_D33_eviction_count_i = NULL) => -0.0025160924, -0.0025160924),
(f_inq_HighRiskCredit_count_i > 21.5) => -0.0833210326,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_incollege and c_incollege <= 4.55) => 0.0597502279,
   (c_incollege > 4.55) => -0.0222078974,
   (c_incollege = NULL) => 0.0038934164, 0.0038934164), -0.0027411210);

// Tree: 248 
woFDN_FLAP_D_lgt_248 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 40.45) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 27.05) => -0.0036269031,
   (C_INC_25K_P > 27.05) => 0.0862584285,
   (C_INC_25K_P = NULL) => -0.0030440085, -0.0030440085),
(c_famotf18_p > 40.45) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 22.5) => -0.1007336959,
   (f_mos_inq_banko_cm_lseen_d > 22.5) => 
      map(
      (NULL < c_assault and c_assault <= 96.5) => 0.0869431217,
      (c_assault > 96.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => -0.1020867611,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0269416765,
         (nf_seg_FraudPoint_3_0 = '') => -0.0491720973, -0.0491720973),
      (c_assault = NULL) => -0.0249324008, -0.0249324008),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0397585494, -0.0397585494),
(c_famotf18_p = NULL) => 0.0275957469, -0.0034216806);

// Tree: 249 
woFDN_FLAP_D_lgt_249 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 31.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 31424) => 0.0243562108,
   (f_curraddrmedianincome_d > 31424) => -0.0022267291,
   (f_curraddrmedianincome_d = NULL) => 0.0003224697, 0.0003224697),
(f_rel_homeover200_count_d > 31.5) => -0.0768635579,
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 22.5) => -0.0898648052,
   (k_comb_age_d > 22.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 197564) => 0.0839777902,
      (r_L80_Inp_AVM_AutoVal_d > 197564) => 0.0336350246,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 7.5) => -0.0626905930,
         (f_sourcerisktype_i > 7.5) => 0.0818819930,
         (f_sourcerisktype_i = NULL) => -0.0321095772, -0.0157871041), 0.0141474468),
   (k_comb_age_d = NULL) => -0.0014057872, -0.0014057872), -0.0003321558);

// Tree: 250 
woFDN_FLAP_D_lgt_250 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 22.55) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 38.05) => 0.0003041686,
   (c_hh3_p > 38.05) => -0.1075176761,
   (c_hh3_p = NULL) => -0.0004355883, -0.0004355883),
(C_INC_50K_P > 22.55) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 3.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 18.5) => 0.1500704983,
      (c_many_cars > 18.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 9.75) => 0.1004006257,
         (c_pop_35_44_p > 9.75) => -0.0292322146,
         (c_pop_35_44_p = NULL) => -0.0013934918, -0.0013934918),
      (c_many_cars = NULL) => 0.0136937416, 0.0136937416),
   (f_crim_rel_under25miles_cnt_i > 3.5) => 0.1242357772,
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0252890600, 0.0252890600),
(C_INC_50K_P = NULL) => 0.0017512857, 0.0008255746);

// Tree: 251 
woFDN_FLAP_D_lgt_251 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1334) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 1.85) => -0.0327339419,
   (C_INC_125K_P > 1.85) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 4.5) => 
         map(
         (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 1.5) => 0.0030839608,
         (f_hh_members_w_derog_i > 1.5) => 0.0261376773,
         (f_hh_members_w_derog_i = NULL) => 0.0086004427, 0.0086004427),
      (k_inq_ssns_per_addr_i > 4.5) => -0.0616908808,
      (k_inq_ssns_per_addr_i = NULL) => 0.0080342573, 0.0080342573),
   (C_INC_125K_P = NULL) => -0.0296471827, 0.0055284572),
(f_liens_rel_SC_total_amt_i > 1334) => -0.1272150613,
(f_liens_rel_SC_total_amt_i = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 114.5) => 0.0673929813,
   (c_employees > 114.5) => -0.0395381324,
   (c_employees = NULL) => -0.0045933240, -0.0045933240), 0.0048519323);

// Tree: 252 
woFDN_FLAP_D_lgt_252 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => -0.0796421665,
      (r_D33_Eviction_Recency_d > 30) => 0.0152377260,
      (r_D33_Eviction_Recency_d = NULL) => 0.0143631863, 0.0143631863),
   (f_phone_ver_insurance_d > 3.5) => -0.0103091213,
   (f_phone_ver_insurance_d = NULL) => -0.0107150505, 0.0019050193),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < c_professional and c_professional <= 7.4) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 11.5) => 0.1729549109,
      (r_P88_Phn_Dst_to_Inp_Add_i > 11.5) => 0.0623892797,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.1151361864, 0.1151361864),
   (c_professional > 7.4) => -0.0080179816,
   (c_professional = NULL) => 0.0707199291, 0.0707199291),
(k_nap_contradictory_i = NULL) => 0.0029845753, 0.0029845753);

// Tree: 253 
woFDN_FLAP_D_lgt_253 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 5.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 31.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01708840145) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 73.05) => 0.0096787779,
         (c_low_ed > 73.05) => 0.0912049601,
         (c_low_ed = NULL) => 0.0234824841, 0.0125088390),
      (f_add_curr_nhood_VAC_pct_i > 0.01708840145) => -0.0107196791,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0009482007, 0.0009482007),
   (f_rel_under500miles_cnt_d > 31.5) => -0.0599520194,
   (f_rel_under500miles_cnt_d = NULL) => 0.0059656123, 0.0000582479),
(r_D34_unrel_liens_ct_i > 5.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 33.85) => -0.1211975934,
   (c_hh2_p > 33.85) => -0.0078782737,
   (c_hh2_p = NULL) => -0.0687208614, -0.0687208614),
(r_D34_unrel_liens_ct_i = NULL) => -0.0198861393, -0.0010459365);

// Tree: 254 
woFDN_FLAP_D_lgt_254 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 23.65) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 19.85) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 68) => -0.0998846225,
      (c_rest_indx > 68) => -0.0356888328,
      (c_rest_indx = NULL) => -0.0458479723, -0.0458479723),
   (C_INC_25K_P > 19.85) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 145) => 0.1510896231,
      (f_prevaddrmurderindex_i > 145) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 10.75) => 0.0700437545,
         (C_INC_50K_P > 10.75) => -0.0986149814,
         (C_INC_50K_P = NULL) => -0.0238184985, -0.0238184985),
      (f_prevaddrmurderindex_i = NULL) => 0.0354894278, 0.0354894278),
   (C_INC_25K_P = NULL) => -0.0338054623, -0.0338054623),
(C_OWNOCC_P > 23.65) => 0.0016728853,
(C_OWNOCC_P = NULL) => 0.0358584291, -0.0008919632);

// Tree: 255 
woFDN_FLAP_D_lgt_255 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184) => -0.0762725982,
   (f_mos_liens_unrel_FT_lseen_d > 184) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 0.0000417398,
      (f_inq_Other_count24_i > 3.5) => 
         map(
         (NULL < c_young and c_young <= 24.5) => 0.0113821842,
         (c_young > 24.5) => 0.1504876524,
         (c_young = NULL) => 0.0629858256, 0.0629858256),
      (f_inq_Other_count24_i = NULL) => 0.0010039359, 0.0010039359),
   (f_mos_liens_unrel_FT_lseen_d = NULL) => 0.0001789862, 0.0001789862),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0114785610,
   (f_phones_per_addr_c6_i > 0.5) => 0.1455526628,
   (f_phones_per_addr_c6_i = NULL) => 0.0525901783, 0.0525901783),
(f_hh_lienholders_i = NULL) => 0.0050681024, 0.0007706123);

// Tree: 256 
woFDN_FLAP_D_lgt_256 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 72.5) => -0.0239235506,
(r_C13_max_lres_d > 72.5) => 
   map(
   (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 4.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 60.5) => 0.2181187275,
      (c_serv_empl > 60.5) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 90.5) => -0.0984241970,
         (f_prevaddrmurderindex_i > 90.5) => 0.1328695083,
         (f_prevaddrmurderindex_i = NULL) => 0.0210351892, 0.0210351892),
      (c_serv_empl = NULL) => 0.0774551826, 0.0774551826),
   (r_C20_email_verification_d > 4.5) => -0.0546785925,
   (r_C20_email_verification_d = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 55.85) => 0.0038692576,
      (c_rnt1000_p > 55.85) => 0.0543820095,
      (c_rnt1000_p = NULL) => -0.0473189565, 0.0057524152), 0.0068884646),
(r_C13_max_lres_d = NULL) => 0.0209584550, 0.0001439381);

// Tree: 257 
woFDN_FLAP_D_lgt_257 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 33.5) => 0.0854212448,
(f_mos_liens_unrel_SC_fseen_d > 33.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 184.5) => 0.0000594922,
   (c_span_lang > 184.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.48283511925) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 27) => -0.0418224264,
         (c_hh4_p > 27) => 0.0599599155,
         (c_hh4_p = NULL) => -0.0290044507, -0.0290044507),
      (f_add_curr_mobility_index_i > 0.48283511925) => -0.1220943500,
      (f_add_curr_mobility_index_i = NULL) => -0.0344674729, -0.0344674729),
   (c_span_lang = NULL) => 0.0138107507, -0.0020293644),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0708675241,
   (k_nap_lname_verd_d > 0.5) => -0.0285734452,
   (k_nap_lname_verd_d = NULL) => 0.0187017697, 0.0187017697), -0.0011925536);

// Tree: 258 
woFDN_FLAP_D_lgt_258 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.19628412385) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => -0.0327386937,
   (f_inq_count_i > 14.5) => 0.0820654147,
   (f_inq_count_i = NULL) => -0.0304575268, -0.0304575268),
(f_add_input_mobility_index_i > 0.19628412385) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 27.05) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 3.15) => -0.0144214056,
         (c_bigapt_p > 3.15) => 0.1227239370,
         (c_bigapt_p = NULL) => 0.0429397643, 0.0429397643),
      (r_I61_inq_collection_recency_d > 4.5) => -0.0000133665,
      (r_I61_inq_collection_recency_d = NULL) => -0.0034385869, 0.0011014015),
   (C_INC_25K_P > 27.05) => 0.0681402575,
   (C_INC_25K_P = NULL) => -0.0323499687, 0.0012236681),
(f_add_input_mobility_index_i = NULL) => 0.1046972785, -0.0047057637);

// Tree: 259 
woFDN_FLAP_D_lgt_259 := map(
(NULL < c_old_homes and c_old_homes <= 160.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 599.5) => -0.0104099276,
   (r_pb_order_freq_d > 599.5) => -0.0711669871,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 79818.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 63.55) => 0.1161637490,
         (c_fammar_p > 63.55) => 0.0068833734,
         (c_fammar_p = NULL) => 0.0495710201, 0.0495710201),
      (r_L80_Inp_AVM_AutoVal_d > 79818.5) => 0.0081953047,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0029107078, 0.0091475394), -0.0042193324),
(c_old_homes > 160.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -16897.5) => 0.0715884339,
   (f_addrchangeincomediff_d > -16897.5) => -0.0402038354,
   (f_addrchangeincomediff_d = NULL) => -0.0281260327, -0.0329341173),
(c_old_homes = NULL) => -0.0519328356, -0.0093613293);

// Tree: 260 
woFDN_FLAP_D_lgt_260 := map(
(NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 1.25) => 0.0528481435,
   (c_rnt500_p > 1.25) => 
      map(
      (NULL < c_retired and c_retired <= 2.7) => 0.0604204617,
      (c_retired > 2.7) => -0.0636753700,
      (c_retired = NULL) => -0.0483788352, -0.0483788352),
   (c_rnt500_p = NULL) => -0.0334044301, -0.0334044301),
(C_INC_150K_P > 0.55) => 
   map(
   (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 4.5) => 0.0114849679,
   (r_A50_pb_total_orders_d > 4.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 3.5) => -0.0182162481,
      (f_inq_HighRiskCredit_count_i > 3.5) => -0.0879542487,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0196186142, -0.0196186142),
   (r_A50_pb_total_orders_d = NULL) => -0.0068722175, 0.0034672368),
(C_INC_150K_P = NULL) => -0.0109449006, 0.0011671322);

// Tree: 261 
woFDN_FLAP_D_lgt_261 := map(
(NULL < c_business and c_business <= 243.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 17.5) => -0.0293343973,
   (f_mos_inq_banko_om_fseen_d > 17.5) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 1103) => 0.0040861324,
      (r_P88_Phn_Dst_to_Inp_Add_i > 1103) => -0.0859091168,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
         map(
         (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 2.5) => 0.0105949877,
         (f_bus_addr_match_count_d > 2.5) => 
            map(
            (NULL < c_rnt2001_p and c_rnt2001_p <= 2.7) => 0.0416588330,
            (c_rnt2001_p > 2.7) => 0.1905658334,
            (c_rnt2001_p = NULL) => 0.0741745055, 0.0741745055),
         (f_bus_addr_match_count_d = NULL) => 0.0197885814, 0.0197885814), 0.0072829808),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0101204796, 0.0049574571),
(c_business > 243.5) => -0.0404090491,
(c_business = NULL) => -0.0001949655, 0.0017556769);

// Tree: 262 
woFDN_FLAP_D_lgt_262 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => -0.0014115382,
   (r_C23_inp_addr_occ_index_d > 3.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 15.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 158.5) => 
            map(
            (NULL < c_oldhouse and c_oldhouse <= 140.75) => -0.0391711285,
            (c_oldhouse > 140.75) => 0.0651389098,
            (c_oldhouse = NULL) => -0.0021223200, -0.0021223200),
         (c_burglary > 158.5) => -0.0907413227,
         (c_burglary = NULL) => -0.0549371375, -0.0256622827),
      (f_rel_ageover30_count_d > 15.5) => -0.1035124106,
      (f_rel_ageover30_count_d = NULL) => -0.0343577635, -0.0343577635),
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0048291785, -0.0048291785),
(f_util_adl_count_n > 1.5) => 0.0163039986,
(f_util_adl_count_n = NULL) => -0.0100263448, 0.0032384477);

// Tree: 263 
woFDN_FLAP_D_lgt_263 := map(
(NULL < c_business and c_business <= 24.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 155.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 2.5) => 0.0050332560,
      (f_srchphonesrchcount_i > 2.5) => 0.0418050777,
      (f_srchphonesrchcount_i = NULL) => 0.0175595124, 0.0098583479),
   (c_easiqlife > 155.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 10.25) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 91.5) => 0.0610332959,
         (f_curraddrcartheftindex_i > 91.5) => 0.2712326954,
         (f_curraddrcartheftindex_i = NULL) => 0.1335158475, 0.1335158475),
      (c_pop_18_24_p > 10.25) => -0.0575971155,
      (c_pop_18_24_p = NULL) => 0.0743618351, 0.0743618351),
   (c_easiqlife = NULL) => 0.0119672896, 0.0119672896),
(c_business > 24.5) => -0.0086151297,
(c_business = NULL) => -0.0047441814, 0.0018958041);

// Tree: 264 
woFDN_FLAP_D_lgt_264 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -26347.5) => -0.0544160937,
(f_addrchangeincomediff_d > -26347.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 4.5) => 
      map(
      (NULL < c_health and c_health <= 9.55) => 0.1949664428,
      (c_health > 9.55) => 0.0023866198,
      (c_health = NULL) => 0.0949730732, 0.0949730732),
   (r_D32_Mos_Since_Crim_LS_d > 4.5) => 0.0033519051,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0043503963, 0.0043503963),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 111.5) => -0.0140396028,
   (c_span_lang > 111.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 59.9) => -0.0038556344,
      (r_C12_source_profile_d > 59.9) => 0.0779279059,
      (r_C12_source_profile_d = NULL) => -0.0142030667, 0.0305064830),
   (c_span_lang = NULL) => 0.0071328584, 0.0081291021), 0.0043446069);

// Tree: 265 
woFDN_FLAP_D_lgt_265 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => 
   map(
   (NULL < c_exp_homes and c_exp_homes <= 196.5) => 0.0003458497,
   (c_exp_homes > 196.5) => 0.0779895538,
   (c_exp_homes = NULL) => -0.0026975286, 0.0018610763),
(k_inq_per_phone_i > 4.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 1.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 0.0126129339,
      (f_phone_ver_insurance_d > 2.5) => 0.1657015543,
      (f_phone_ver_insurance_d = NULL) => 0.0884676557, 0.0884676557),
   (f_srchfraudsrchcountyr_i > 1.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 40.5) => 0.0534360925,
      (k_comb_age_d > 40.5) => -0.0686716054,
      (k_comb_age_d = NULL) => 0.0016818365, 0.0016818365),
   (f_srchfraudsrchcountyr_i = NULL) => 0.0384498744, 0.0384498744),
(k_inq_per_phone_i = NULL) => 0.0026196774, 0.0026196774);

// Tree: 266 
woFDN_FLAP_D_lgt_266 := map(
(NULL < c_med_rent and c_med_rent <= 1970) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0061948483,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 17.5) => 0.0195171469,
      (f_addrchangecrimediff_i > 17.5) => 0.1346935549,
      (f_addrchangecrimediff_i = NULL) => 0.0172081018, 0.0271129524),
   (r_L70_Add_Standardized_i = NULL) => -0.0036805823, -0.0036805823),
(c_med_rent > 1970) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 107.5) => -0.0002698362,
   (r_C13_Curr_Addr_LRes_d > 107.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 38.5) => 0.2620681850,
      (c_born_usa > 38.5) => 0.0410603749,
      (c_born_usa = NULL) => 0.1152143112, 0.1152143112),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0504630841, 0.0504630841),
(c_med_rent = NULL) => -0.0193892002, -0.0025440029);

// Tree: 267 
woFDN_FLAP_D_lgt_267 := map(
(NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 33.55) => 0.1506550579,
      (c_fammar18_p > 33.55) => 0.0161238261,
      (c_fammar18_p = NULL) => 0.0833894420, 0.0833894420),
   (r_C10_M_Hdr_FS_d > 15.5) => 0.0061286593,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0037184316, 0.0075485618),
(r_Phn_Cell_n > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 24.5) => 0.0118642876,
      (c_hval_250k_p > 24.5) => 0.1503028363,
      (c_hval_250k_p = NULL) => 0.0276147812, 0.0276147812),
   (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0213764077,
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0383633645, -0.0172965513),
(r_Phn_Cell_n = NULL) => -0.0041306979, -0.0041306979);

// Tree: 268 
woFDN_FLAP_D_lgt_268 := map(
(NULL < c_retail and c_retail <= 28.75) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 14.05) => 0.0007805974,
   (C_INC_25K_P > 14.05) => -0.0258351833,
   (C_INC_25K_P = NULL) => -0.0031405202, -0.0031405202),
(c_retail > 28.75) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 2.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 16.45) => -0.0073015145,
      (c_rnt1000_p > 16.45) => 0.2282363642,
      (c_rnt1000_p = NULL) => 0.1047689278, 0.1047689278),
   (f_corraddrnamecount_d > 2.5) => 
      map(
      (NULL < f_hh_bankruptcies_i and f_hh_bankruptcies_i <= 0.5) => 0.0414619670,
      (f_hh_bankruptcies_i > 0.5) => -0.0579583389,
      (f_hh_bankruptcies_i = NULL) => 0.0206862439, 0.0206862439),
   (f_corraddrnamecount_d = NULL) => 0.0291012986, 0.0291012986),
(c_retail = NULL) => -0.0256684562, -0.0004453435);

// Tree: 269 
woFDN_FLAP_D_lgt_269 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 2.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 9.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 42.05) => 0.0143646973,
      (c_high_ed > 42.05) => -0.0257851459,
      (c_high_ed = NULL) => 0.0009831458, 0.0029883601),
   (f_rel_homeover300_count_d > 9.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 4.55) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 9.35) => -0.0649906063,
         (c_pop_25_34_p > 9.35) => 0.0908620403,
         (c_pop_25_34_p = NULL) => 0.0152276677, 0.0152276677),
      (c_famotf18_p > 4.55) => -0.0510288753,
      (c_famotf18_p = NULL) => -0.0323920814, -0.0323920814),
   (f_rel_homeover300_count_d = NULL) => 0.0209465256, 0.0003667003),
(f_dl_addrs_per_adl_i > 2.5) => -0.0371549557,
(f_dl_addrs_per_adl_i = NULL) => -0.0190328123, -0.0030323802);

// Tree: 270 
woFDN_FLAP_D_lgt_270 := map(
(NULL < c_pop00 and c_pop00 <= 740.5) => -0.0472944526,
(c_pop00 > 740.5) => 
   map(
   (NULL < c_transport and c_transport <= 8.45) => 
      map(
      (NULL < c_assault and c_assault <= 183.5) => -0.0039335619,
      (c_assault > 183.5) => 0.0504867248,
      (c_assault = NULL) => -0.0013535484, -0.0013535484),
   (c_transport > 8.45) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1105) => 0.0145403009,
      (c_med_rent > 1105) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 272) => 0.0021756128,
         (r_A50_pb_total_dollars_d > 272) => 0.2337905439,
         (r_A50_pb_total_dollars_d = NULL) => 0.1445874961, 0.1445874961),
      (c_med_rent = NULL) => 0.0354609367, 0.0354609367),
   (c_transport = NULL) => 0.0015157609, 0.0015157609),
(c_pop00 = NULL) => -0.0212351515, -0.0012887245);

// Tree: 271 
woFDN_FLAP_D_lgt_271 := map(
(NULL < c_hh00 and c_hh00 <= 517.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 33.85) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -12096.5) => 0.0709739065,
      (f_addrchangeincomediff_d > -12096.5) => 0.0028798508,
      (f_addrchangeincomediff_d = NULL) => 0.0012457799, 0.0046429757),
   (c_hval_100k_p > 33.85) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.45) => 0.1585608309,
      (c_pop_75_84_p > 3.45) => -0.0081671697,
      (c_pop_75_84_p = NULL) => 0.0701858797, 0.0701858797),
   (c_hval_100k_p = NULL) => 0.0073007092, 0.0073007092),
(c_hh00 > 517.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 2.5) => -0.0895797294,
   (r_F00_input_dob_match_level_d > 2.5) => -0.0099742451,
   (r_F00_input_dob_match_level_d = NULL) => -0.0018495131, -0.0107144561),
(c_hh00 = NULL) => 0.0247239416, -0.0034865577);

// Tree: 272 
woFDN_FLAP_D_lgt_272 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.821130781) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.74387464705) => 0.0056797958,
   (f_add_curr_nhood_MFD_pct_i > 0.74387464705) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 32.5) => 0.2615176941,
      (c_totcrime > 32.5) => 
         map(
         (NULL < C_INC_201K_P and C_INC_201K_P <= 0.85) => 0.1002537489,
         (C_INC_201K_P > 0.85) => -0.0077963611,
         (C_INC_201K_P = NULL) => 0.0206378784, 0.0206378784),
      (c_totcrime = NULL) => 0.0499419922, 0.0499419922),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < r_I60_inq_banking_count12_i and r_I60_inq_banking_count12_i <= 0.5) => -0.0288766751,
      (r_I60_inq_banking_count12_i > 0.5) => 0.1407886439,
      (r_I60_inq_banking_count12_i = NULL) => 0.0051081911, -0.0019199075), 0.0072222322),
(f_add_input_nhood_MFD_pct_i > 0.821130781) => -0.0278200422,
(f_add_input_nhood_MFD_pct_i = NULL) => -0.0151687593, 0.0003681443);

// Tree: 273 
woFDN_FLAP_D_lgt_273 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 196.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 10.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 127.5) => -0.0034141780,
      (c_no_labfor > 127.5) => 
         map(
         (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 0.0225044844,
         (f_inq_Communications_count24_i > 1.5) => 0.1051420007,
         (f_inq_Communications_count24_i = NULL) => 0.0244219011, 0.0244219011),
      (c_no_labfor = NULL) => 0.0032549451, 0.0032089821),
   (f_rel_homeover300_count_d > 10.5) => -0.0297071594,
   (f_rel_homeover300_count_d = NULL) => -0.0170539487, 0.0005389474),
(f_fp_prevaddrcrimeindex_i > 196.5) => -0.0840688905,
(f_fp_prevaddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 6.4) => -0.0529776042,
   (c_famotf18_p > 6.4) => 0.0476982620,
   (c_famotf18_p = NULL) => 0.0121656034, 0.0121656034), -0.0000516037);

// Tree: 274 
woFDN_FLAP_D_lgt_274 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0107383257,
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 19.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 29.5) => 
         map(
         (NULL < c_med_hhinc and c_med_hhinc <= 46305.5) => 0.1751163299,
         (c_med_hhinc > 46305.5) => 
            map(
            (NULL < c_hhsize and c_hhsize <= 3.085) => 0.0020348241,
            (c_hhsize > 3.085) => 0.1061824756,
            (c_hhsize = NULL) => 0.0277641043, 0.0277641043),
         (c_med_hhinc = NULL) => 0.0372420364, 0.0372420364),
      (c_bargains > 29.5) => 0.0043836068,
      (c_bargains = NULL) => -0.0107513306, 0.0088541505),
   (k_inq_per_addr_i > 19.5) => 0.1224537584,
   (k_inq_per_addr_i = NULL) => 0.0097243986, 0.0097243986),
(f_util_add_curr_conv_n = NULL) => 0.0006327223, 0.0006327223);

// Tree: 275 
woFDN_FLAP_D_lgt_275 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 76.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 101) => 0.1880006586,
      (c_rest_indx > 101) => 0.0190945551,
      (c_rest_indx = NULL) => 0.1027276743, 0.1027276743),
   (r_D32_Mos_Since_Crim_LS_d > 14.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 0.75) => 0.1179710577,
      (c_pop_65_74_p > 0.75) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 16.65) => 0.0026928574,
         (c_hval_200k_p > 16.65) => 0.0784195427,
         (c_hval_200k_p = NULL) => 0.0097333567, 0.0097333567),
      (c_pop_65_74_p = NULL) => 0.0904885656, 0.0153209758),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0188626319, 0.0188626319),
(f_mos_inq_banko_cm_fseen_d > 76.5) => -0.0093053922,
(f_mos_inq_banko_cm_fseen_d = NULL) => 0.0128494012, -0.0033567875);

// Tree: 276 
woFDN_FLAP_D_lgt_276 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 24.5) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 24.7) => -0.0016054048,
   (c_hval_40k_p > 24.7) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 6.15) => 0.2047930031,
      (c_pop_18_24_p > 6.15) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 7.5) => -0.0493096066,
         (f_rel_under25miles_cnt_d > 7.5) => 0.0527414292,
         (f_rel_under25miles_cnt_d = NULL) => -0.0064637519, -0.0064637519),
      (c_pop_18_24_p = NULL) => 0.0535776416, 0.0535776416),
   (c_hval_40k_p = NULL) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => 0.0529826893,
      (r_C14_Addr_Stability_v2_d > 3.5) => -0.0282788710,
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0084589782, -0.0084589782), -0.0009000742),
(f_srchphonesrchcount_i > 24.5) => -0.0926365696,
(f_srchphonesrchcount_i = NULL) => 0.0333009241, -0.0008231747);

// Tree: 277 
woFDN_FLAP_D_lgt_277 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 25.55) => 0.1356989477,
   (c_hh2_p > 25.55) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 72) => 0.0997604159,
      (c_span_lang > 72) => -0.0450925587,
      (c_span_lang = NULL) => 0.0050760325, 0.0050760325),
   (c_hh2_p = NULL) => 0.0400643134, 0.0400643134),
(r_F00_dob_score_d > 92) => -0.0024017222,
(r_F00_dob_score_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.60686360515) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 26.15) => 0.0774803685,
      (c_fammar18_p > 26.15) => -0.0205878706,
      (c_fammar18_p = NULL) => 0.0057588205, 0.0057588205),
   (f_add_input_nhood_MFD_pct_i > 0.60686360515) => -0.0741177492,
   (f_add_input_nhood_MFD_pct_i = NULL) => -0.0348226964, -0.0197883176), -0.0022129578);

// Tree: 278 
woFDN_FLAP_D_lgt_278 := map(
(NULL < c_sub_bus and c_sub_bus <= 176.5) => -0.0060866658,
(c_sub_bus > 176.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 43.8) => -0.0154547370,
   (r_C12_source_profile_d > 43.8) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 18.55) => 0.0229049967,
      (c_hh4_p > 18.55) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 101.2) => 0.2120409043,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 101.2) => -0.0329148902,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
            map(
            (NULL < C_INC_15K_P and C_INC_15K_P <= 11.4) => 0.0254639377,
            (C_INC_15K_P > 11.4) => 0.2142716366,
            (C_INC_15K_P = NULL) => 0.1276626004, 0.1276626004), 0.1009805428),
      (c_hh4_p = NULL) => 0.0408052439, 0.0408052439),
   (r_C12_source_profile_d = NULL) => 0.0199887051, 0.0199887051),
(c_sub_bus = NULL) => 0.0262110490, -0.0019719061);

// Tree: 279 
woFDN_FLAP_D_lgt_279 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 76.5) => -0.0022331103,
   (f_addrchangecrimediff_i > 76.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 73.8) => -0.0947706421,
      (c_fammar_p > 73.8) => 0.0419427521,
      (c_fammar_p = NULL) => -0.0386569355, -0.0386569355),
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 47.55) => 0.0033748251,
      (c_hh2_p > 47.55) => 0.1146207440,
      (c_hh2_p = NULL) => 0.0081415894, 0.0113249791), 0.0003281990),
(r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.0728769551,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 110.5) => -0.0440710307,
   (c_for_sale > 110.5) => 0.0460492846,
   (c_for_sale = NULL) => -0.0009946536, -0.0009946536), -0.0001235017);

// Tree: 280 
woFDN_FLAP_D_lgt_280 := map(
(NULL < c_cpiall and c_cpiall <= 208.9) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 12.85) => 0.1528591616,
      (c_high_ed > 12.85) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 5.85) => 
            map(
            (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 1.5) => 0.3172681645,
            (f_rel_ageover40_count_d > 1.5) => 0.0238778706,
            (f_rel_ageover40_count_d = NULL) => 0.1525182302, 0.1525182302),
         (c_pop_18_24_p > 5.85) => -0.0013478571,
         (c_pop_18_24_p = NULL) => 0.0498154384, 0.0498154384),
      (c_high_ed = NULL) => 0.0657829575, 0.0657829575),
   (f_historical_count_d > 0.5) => 0.0042292168,
   (f_historical_count_d = NULL) => 0.0208542227, 0.0208542227),
(c_cpiall > 208.9) => -0.0079422123,
(c_cpiall = NULL) => -0.0125311329, -0.0039348553);

// Tree: 281 
woFDN_FLAP_D_lgt_281 := map(
(NULL < c_hval_200k_p and c_hval_200k_p <= 14.95) => -0.0013319863,
(c_hval_200k_p > 14.95) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 119405) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 11.5) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 7.5) => 0.0468792352,
         (f_rel_educationover12_count_d > 7.5) => 0.2659016724,
         (f_rel_educationover12_count_d = NULL) => 0.1228407741, 0.1228407741),
      (f_rel_homeover100_count_d > 11.5) => -0.0140553865,
      (f_rel_homeover100_count_d = NULL) => 0.0854531672, 0.0854531672),
   (r_A46_Curr_AVM_AutoVal_d > 119405) => -0.0167376959,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 0.15) => 0.1024854019,
      (c_hval_100k_p > 0.15) => -0.0017650141,
      (c_hval_100k_p = NULL) => 0.0403082154, 0.0403082154), 0.0226898187),
(c_hval_200k_p = NULL) => -0.0018011248, 0.0012237563);

// Tree: 282 
woFDN_FLAP_D_lgt_282 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0052504588,
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 2) => 
      map(
      (NULL < c_unemp and c_unemp <= 6.35) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 2.5) => -0.0029608798,
         (f_srchaddrsrchcount_i > 2.5) => 
            map(
            (NULL < c_pop_6_11_p and c_pop_6_11_p <= 6.25) => 0.1644401434,
            (c_pop_6_11_p > 6.25) => 0.0394470053,
            (c_pop_6_11_p = NULL) => 0.0712518750, 0.0712518750),
         (f_srchaddrsrchcount_i = NULL) => 0.0306788118, 0.0306788118),
      (c_unemp > 6.35) => -0.0573388058,
      (c_unemp = NULL) => 0.0120982047, 0.0120982047),
   (f_idrisktype_i > 2) => 0.1841894384,
   (f_idrisktype_i = NULL) => 0.0210781578, 0.0210781578),
(f_hh_payday_loan_users_i = NULL) => 0.0039843454, -0.0026923467);

// Tree: 283 
woFDN_FLAP_D_lgt_283 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 16.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => -0.0481808326,
      (r_D33_eviction_count_i > 0.5) => -0.1047445318,
      (r_D33_eviction_count_i = NULL) => -0.0524889282, -0.0524889282),
   (r_F01_inp_addr_not_verified_i > 0.5) => 0.0553604218,
   (r_F01_inp_addr_not_verified_i = NULL) => -0.0415536329, -0.0415536329),
(f_mos_inq_banko_om_fseen_d > 16.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 47.5) => -0.0117297928,
      (f_prevaddrageoldest_d > 47.5) => 0.0129710255,
      (f_prevaddrageoldest_d = NULL) => 0.0026012623, 0.0026012623),
   (f_rel_felony_count_i > 4.5) => 0.0727521884,
   (f_rel_felony_count_i = NULL) => 0.0029548033, 0.0029548033),
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0245290171, -0.0002257759);

// Tree: 284 
woFDN_FLAP_D_lgt_284 := map(
(NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 2) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 10.65) => 
      map(
      (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 4.5) => -0.0223786286,
      (f_componentcharrisktype_i > 4.5) => 0.0988431607,
      (f_componentcharrisktype_i = NULL) => 0.0187803976, 0.0187803976),
   (c_hh5_p > 10.65) => 0.1499068358,
   (c_hh5_p = NULL) => 0.0439211808, 0.0439211808),
(r_I60_inq_banking_recency_d > 2) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 0.5) => -0.0402371049,
   (f_rel_homeover100_count_d > 0.5) => 0.0004293024,
   (f_rel_homeover100_count_d = NULL) => -0.0294448599, -0.0021016733),
(r_I60_inq_banking_recency_d = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 2.25) => -0.0375523514,
   (c_high_hval > 2.25) => 0.0557250757,
   (c_high_hval = NULL) => 0.0087602173, 0.0087602173), -0.0009833606);

// Tree: 285 
woFDN_FLAP_D_lgt_285 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 5.15) => -0.0726467530,
(c_pop_35_44_p > 5.15) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 6.5) => -0.0044198086,
   (f_rel_ageover40_count_d > 6.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 74.35) => 0.0223565065,
      (c_low_ed > 74.35) => 0.1532895052,
      (c_low_ed = NULL) => 0.0261644013, 0.0261644013),
   (f_rel_ageover40_count_d = NULL) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 662.5) => 0.0722150054,
      (c_med_rent > 662.5) => -0.0246744508,
      (c_med_rent = NULL) => 0.0056561616, 0.0056561616), 0.0004028097),
(c_pop_35_44_p = NULL) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2153826723) => 0.1190837228,
   (f_add_curr_mobility_index_i > 0.2153826723) => -0.1069764427,
   (f_add_curr_mobility_index_i = NULL) => 0.1099016970, 0.0318188966), -0.0008904969);

// Tree: 286 
woFDN_FLAP_D_lgt_286 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 21.05) => -0.0040883917,
(c_pop_35_44_p > 21.05) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 31.85) => 
      map(
      (NULL < c_assault and c_assault <= 147.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 21.7) => -0.0012231057,
         (c_hval_150k_p > 21.7) => 0.1497843317,
         (c_hval_150k_p = NULL) => 0.0088733218, 0.0088733218),
      (c_assault > 147.5) => 
         map(
         (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => 0.0356584471,
         (k_inf_nothing_found_i > 0.5) => 0.1986610492,
         (k_inf_nothing_found_i = NULL) => 0.0967844229, 0.0967844229),
      (c_assault = NULL) => 0.0216815617, 0.0216815617),
   (c_hval_500k_p > 31.85) => 0.2042449880,
   (c_hval_500k_p = NULL) => 0.0296316713, 0.0296316713),
(c_pop_35_44_p = NULL) => 0.0107828515, -0.0004179887);

// Tree: 287 
woFDN_FLAP_D_lgt_287 := map(
(NULL < c_hhsize and c_hhsize <= 4.255) => 
   map(
   (NULL < r_L70_inp_addr_dirty_i and r_L70_inp_addr_dirty_i <= 0.5) => -0.0032505313,
   (r_L70_inp_addr_dirty_i > 0.5) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 5.5) => 0.0232428604,
      (f_rel_incomeover25_count_d > 5.5) => -0.0968730016,
      (f_rel_incomeover25_count_d = NULL) => -0.0588702430, -0.0588702430),
   (r_L70_inp_addr_dirty_i = NULL) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 13.35) => 0.0340759180,
      (c_hh3_p > 13.35) => -0.0474870185,
      (c_hh3_p = NULL) => -0.0123221597, -0.0123221597), -0.0041890958),
(c_hhsize > 4.255) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 3.5) => 0.1816823614,
   (c_lowrent > 3.5) => 0.0058722622,
   (c_lowrent = NULL) => 0.0803680669, 0.0803680669),
(c_hhsize = NULL) => 0.0185064123, -0.0028908175);

// Tree: 288 
woFDN_FLAP_D_lgt_288 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 16.5) => -0.0036440922,
(f_addrchangecrimediff_i > 16.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 57.5) => 0.1099661052,
      (r_C21_M_Bureau_ADL_FS_d > 57.5) => 
         map(
         (NULL < c_bargains and c_bargains <= 118.5) => -0.0648157803,
         (c_bargains > 118.5) => 
            map(
            (NULL < c_pop_12_17_p and c_pop_12_17_p <= 7.45) => -0.0219033835,
            (c_pop_12_17_p > 7.45) => 0.1021582878,
            (c_pop_12_17_p = NULL) => 0.0278845240, 0.0278845240),
         (c_bargains = NULL) => -0.0144927579, -0.0144927579),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0043646456, 0.0043646456),
   (r_L79_adls_per_addr_c6_i > 2.5) => 0.1091503655,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0237694085, 0.0237694085),
(f_addrchangecrimediff_i = NULL) => -0.0008608122, -0.0021301311);

// Tree: 289 
woFDN_FLAP_D_lgt_289 := map(
(NULL < c_hh5_p and c_hh5_p <= 23.95) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 26.25) => -0.0050489169,
   (c_rnt1250_p > 26.25) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 159.5) => 0.0129918717,
      (c_rich_fam > 159.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.75) => 
            map(
            (NULL < C_INC_50K_P and C_INC_50K_P <= 11.75) => 0.1485455254,
            (C_INC_50K_P > 11.75) => -0.0203072499,
            (C_INC_50K_P = NULL) => 0.0695660015, 0.0695660015),
         (r_C12_source_profile_d > 78.75) => 0.2559569226,
         (r_C12_source_profile_d = NULL) => 0.0931930197, 0.0931930197),
      (c_rich_fam = NULL) => 0.0314834037, 0.0314834037),
   (c_rnt1250_p = NULL) => 0.0005393944, 0.0005393944),
(c_hh5_p > 23.95) => -0.0886360289,
(c_hh5_p = NULL) => 0.0247649839, 0.0001206561);

// Tree: 290 
woFDN_FLAP_D_lgt_290 := map(
(NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 11.5) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 7.05) => 0.0083630529,
      (c_rnt2000_p > 7.05) => 0.1426083925,
      (c_rnt2000_p = NULL) => 0.0589229860, 0.0589229860),
   (r_C13_max_lres_d > 11.5) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 16929) => -0.0955688171,
      (c_med_hhinc > 16929) => 0.0026348247,
      (c_med_hhinc = NULL) => -0.0219714072, 0.0014271929),
   (r_C13_max_lres_d = NULL) => 0.0022220231, 0.0022220231),
(f_assoccredbureaucountmo_i > 0.5) => 0.1251201083,
(f_assoccredbureaucountmo_i = NULL) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 95.5) => 0.0682049096,
   (c_rest_indx > 95.5) => -0.0123643275,
   (c_rest_indx = NULL) => 0.0212506522, 0.0212506522), 0.0030860352);

// Tree: 291 
woFDN_FLAP_D_lgt_291 := map(
(NULL < c_born_usa and c_born_usa <= 121.5) => -0.0047240055,
(c_born_usa > 121.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 171.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1980.5) => -0.0051117736,
      (c_med_yearblt > 1980.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0906522044,
         (f_corrphonelastnamecount_d > 0.5) => 0.0141991674,
         (f_corrphonelastnamecount_d = NULL) => 0.0448182615, 0.0448182615),
      (c_med_yearblt = NULL) => 0.0128960214, 0.0128960214),
   (c_sub_bus > 171.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0455064873,
      (f_phone_ver_experian_d > 0.5) => 0.0505503338,
      (f_phone_ver_experian_d = NULL) => 0.0482285632, 0.0482285632),
   (c_sub_bus = NULL) => 0.0146205270, 0.0146205270),
(c_born_usa = NULL) => 0.0078541281, 0.0009892430);

// Tree: 292 
woFDN_FLAP_D_lgt_292 := map(
(NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 7.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 30.95) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -28578.5) => -0.1167739418,
      (f_addrchangeincomediff_d > -28578.5) => -0.0242297171,
      (f_addrchangeincomediff_d = NULL) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.56876119615) => 
            map(
            (NULL < c_retired and c_retired <= 5.1) => 0.1773706674,
            (c_retired > 5.1) => -0.0180096225,
            (c_retired = NULL) => 0.0732629217, 0.0732629217),
         (f_add_curr_nhood_SFD_pct_d > 0.56876119615) => -0.0336536611,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0000189178, 0.0000189178), -0.0212875663),
   (c_med_age > 30.95) => 0.0054840515,
   (c_med_age = NULL) => 0.0235274464, 0.0015831556),
(f_inq_Banking_count24_i > 7.5) => -0.1323907850,
(f_inq_Banking_count24_i = NULL) => 0.0176124889, 0.0012850588);

// Tree: 293 
woFDN_FLAP_D_lgt_293 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 189.5) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 194.5) => -0.0015102022,
      (c_relig_indx > 194.5) => 0.0717106644,
      (c_relig_indx = NULL) => 0.0008780432, 0.0008780432),
   (c_cartheft > 189.5) => -0.0542817964,
   (c_cartheft = NULL) => 0.0176431032, -0.0004677895),
(r_D34_unrel_liens_ct_i > 7.5) => 0.1009039248,
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.28702704115) => -0.0828141903,
   (f_add_input_nhood_SFD_pct_d > 0.28702704115) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 2.2) => -0.0290969266,
      (c_high_hval > 2.2) => 0.0780878650,
      (c_high_hval = NULL) => 0.0254356867, 0.0254356867),
   (f_add_input_nhood_SFD_pct_d = NULL) => -0.0102230963, -0.0102230963), -0.0000231414);

// Tree: 294 
woFDN_FLAP_D_lgt_294 := map(
(NULL < c_span_lang and c_span_lang <= 185.5) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 4.5) => 0.0012113421,
   (f_inq_QuizProvider_count_i > 4.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 135) => -0.0169685594,
      (r_C13_max_lres_d > 135) => 0.2009909193,
      (r_C13_max_lres_d = NULL) => 0.0704483438, 0.0704483438),
   (f_inq_QuizProvider_count_i = NULL) => -0.0011809262, 0.0023092053),
(c_span_lang > 185.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 27.05) => -0.0417368408,
   (c_hh4_p > 27.05) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01395604065) => 0.1661764315,
      (f_add_curr_nhood_VAC_pct_i > 0.01395604065) => -0.0625771967,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0539991715, 0.0539991715),
   (c_hh4_p = NULL) => -0.0300563923, -0.0300563923),
(c_span_lang = NULL) => 0.0120834421, 0.0002911547);

// Tree: 295 
woFDN_FLAP_D_lgt_295 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 7905.5) => -0.0142760852,
(r_A49_Curr_AVM_Chg_1yr_i > 7905.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 58105) => 0.1052777871,
   (r_L80_Inp_AVM_AutoVal_d > 58105) => 0.0154113303,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 103.5) => -0.0180837779,
      (c_serv_empl > 103.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 127.5) => 0.0552873194,
         (r_C13_max_lres_d > 127.5) => 0.2429689331,
         (r_C13_max_lres_d = NULL) => 0.1464970756, 0.1464970756),
      (c_serv_empl = NULL) => 0.0669894169, 0.0669894169), 0.0209001273),
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => -0.0034502452,
   (f_inq_count_i > 14.5) => 0.0757800930,
   (f_inq_count_i = NULL) => -0.0111848225, -0.0015145557), 0.0003898061);

// Tree: 296 
woFDN_FLAP_D_lgt_296 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 4.5) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 58.5) => 0.0053438797,
   (c_old_homes > 58.5) => -0.1119174415,
   (c_old_homes = NULL) => -0.0606156135, -0.0606156135),
(r_I60_inq_hiRiskCred_recency_d > 4.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 10.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 0.0189550159,
      (r_Ever_Asset_Owner_d > 0.5) => -0.0048904752,
      (r_Ever_Asset_Owner_d = NULL) => 0.0003308077, 0.0003308077),
   (f_inq_count24_i > 10.5) => -0.0593464163,
   (f_inq_count24_i = NULL) => -0.0006102451, -0.0006102451),
(r_I60_inq_hiRiskCred_recency_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0230482281,
   (r_Phn_Cell_n > 0.5) => -0.0640092694,
   (r_Phn_Cell_n = NULL) => -0.0094837841, -0.0094837841), -0.0013533799);

// Tree: 297 
woFDN_FLAP_D_lgt_297 := map(
(NULL < c_fammar_p and c_fammar_p <= 62.05) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 6.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 151.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 30.4) => 0.0204812209,
         (c_famotf18_p > 30.4) => 0.1335218486,
         (c_famotf18_p = NULL) => 0.0756229905, 0.0756229905),
      (r_C13_max_lres_d > 151.5) => -0.0444365374,
      (r_C13_max_lres_d = NULL) => 0.0316836788, 0.0316836788),
   (f_mos_inq_banko_om_lseen_d > 6.5) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 0.5) => 0.0228691903,
      (f_rel_homeover150_count_d > 0.5) => -0.0340020816,
      (f_rel_homeover150_count_d = NULL) => -0.0327173442, -0.0245550835),
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0196887499, -0.0196887499),
(c_fammar_p > 62.05) => 0.0072199090,
(c_fammar_p = NULL) => -0.0057240797, 0.0020908128);

// Tree: 298 
woFDN_FLAP_D_lgt_298 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.05220712715) => -0.0035153728,
   (f_add_curr_nhood_BUS_pct_i > 0.05220712715) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 232.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 38.5) => 0.0374356363,
         (f_mos_inq_banko_cm_fseen_d > 38.5) => 
            map(
            (NULL < C_RENTOCC_P and C_RENTOCC_P <= 31.7) => 0.0349186945,
            (C_RENTOCC_P > 31.7) => 0.2488649243,
            (C_RENTOCC_P = NULL) => 0.1439893214, 0.1439893214),
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0713996235, 0.0713996235),
      (r_C21_M_Bureau_ADL_FS_d > 232.5) => -0.0110840499,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0335771607, 0.0335771607),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1566772712, 0.0195482739),
(f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0032692722,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0014934318, -0.0002706657);

// Tree: 299 
woFDN_FLAP_D_lgt_299 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 16.5) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.0750948708) => -0.0401795701,
   (f_add_input_nhood_SFD_pct_d > 0.0750948708) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 164.5) => -0.0648215767,
         (c_serv_empl > 164.5) => 0.0353644720,
         (c_serv_empl = NULL) => -0.0448194584, -0.0448194584),
      (f_mos_inq_banko_om_lseen_d > 5.5) => 0.0019430034,
      (f_mos_inq_banko_om_lseen_d = NULL) => -0.0004016782, -0.0004016782),
   (f_add_input_nhood_SFD_pct_d = NULL) => -0.0037074442, -0.0037074442),
(f_inq_count24_i > 16.5) => -0.1272540154,
(f_inq_count24_i = NULL) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 135.5) => -0.0370267622,
   (c_apt20 > 135.5) => 0.0603191546,
   (c_apt20 = NULL) => -0.0036891195, -0.0036891195), -0.0044084469);

// Tree: 300 
woFDN_FLAP_D_lgt_300 := map(
(NULL < c_no_teens and c_no_teens <= 8.5) => 
   map(
   (NULL < c_unattach and c_unattach <= 74.5) => 0.0481422049,
   (c_unattach > 74.5) => -0.0729406827,
   (c_unattach = NULL) => -0.0404550299, -0.0404550299),
(c_no_teens > 8.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 0.0052004681,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 21599) => 0.0819221456,
         (r_A49_Curr_AVM_Chg_1yr_i > 21599) => -0.0325756747,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.1000711606, 0.0642694132),
      (r_D31_ALL_Bk_i > 1.5) => -0.0369467825,
      (r_D31_ALL_Bk_i = NULL) => 0.0323330843, 0.0323330843),
   (f_hh_tot_derog_i = NULL) => 0.0020447089, 0.0065089064),
(c_no_teens = NULL) => -0.0053843376, 0.0048886650);

// Tree: 301 
woFDN_FLAP_D_lgt_301 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 40.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 198.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 45.5) => -0.0101379625,
      (r_C13_Curr_Addr_LRes_d > 45.5) => 
         map(
         (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 0.0093488827,
         (f_srchunvrfdaddrcount_i > 0.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.033422124) => 0.1362431151,
            (f_add_curr_nhood_BUS_pct_i > 0.033422124) => -0.0039824883,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0679593430, 0.0679593430),
         (f_srchunvrfdaddrcount_i = NULL) => 0.0103774298, 0.0103774298),
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0107040832, 0.0016479148),
   (c_serv_empl > 198.5) => -0.0978580386,
   (c_serv_empl = NULL) => 0.0021665312, 0.0009722201),
(f_bus_addr_match_count_d > 40.5) => -0.0857077682,
(f_bus_addr_match_count_d = NULL) => 0.0002615604, 0.0002615604);

// Tree: 302 
woFDN_FLAP_D_lgt_302 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 18.75) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 13.75) => -0.0082997091,
   (C_INC_50K_P > 13.75) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 3.5) => -0.0106174877,
      (f_rel_homeover150_count_d > 3.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
            map(
            (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 34127.5) => 0.1679894606,
            (f_curraddrmedianincome_d > 34127.5) => 0.0515797262,
            (f_curraddrmedianincome_d = NULL) => 0.0607371069, 0.0607371069),
         (f_phone_ver_experian_d > 0.5) => 0.0029525125,
         (f_phone_ver_experian_d = NULL) => 0.0457018494, 0.0305181533),
      (f_rel_homeover150_count_d = NULL) => -0.0087074797, 0.0101693086),
   (C_INC_50K_P = NULL) => -0.0011424406, -0.0011424406),
(c_hh7p_p > 18.75) => -0.1167864529,
(c_hh7p_p = NULL) => -0.0409759456, -0.0026035401);

// Tree: 303 
woFDN_FLAP_D_lgt_303 := map(
(NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 5089) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 157.5) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0811848662,
      (f_attr_arrest_recency_d > 79.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 9.5) => -0.0390215889,
         (f_mos_inq_banko_cm_lseen_d > 9.5) => 0.0060514858,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0041087229, 0.0041087229),
      (f_attr_arrest_recency_d = NULL) => 0.0047199794, 0.0047199794),
   (c_relig_indx > 157.5) => -0.0227454589,
   (c_relig_indx = NULL) => 0.0064520982, -0.0014696168),
(f_liens_unrel_O_total_amt_i > 5089) => -0.1058575344,
(f_liens_unrel_O_total_amt_i = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 130) => 0.0239035024,
   (c_easiqlife > 130) => -0.0605455772,
   (c_easiqlife = NULL) => -0.0075579194, -0.0075579194), -0.0022903320);

// Tree: 304 
woFDN_FLAP_D_lgt_304 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 0.5) => -0.0578778562,
(f_vardobcount_i > 0.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 11) => -0.0711536047,
   (r_F01_inp_addr_address_score_d > 11) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 2.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 124.5) => 0.0173723367,
         (f_curraddrcrimeindex_i > 124.5) => 0.1078347810,
         (f_curraddrcrimeindex_i = NULL) => 0.0396923188, 0.0396923188),
      (r_C13_Curr_Addr_LRes_d > 2.5) => 0.0015455127,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0034460211, 0.0034460211),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0030233262, 0.0030233262),
(f_vardobcount_i = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 91.5) => 0.0444221885,
   (c_rich_nfam > 91.5) => -0.0476289575,
   (c_rich_nfam = NULL) => -0.0016033845, -0.0016033845), 0.0022205016);

// Final Score Sum 

   woFDN_FLAP_D_lgt := sum(
      woFDN_FLAP_D_lgt_0, woFDN_FLAP_D_lgt_1, woFDN_FLAP_D_lgt_2, woFDN_FLAP_D_lgt_3, woFDN_FLAP_D_lgt_4, 
      woFDN_FLAP_D_lgt_5, woFDN_FLAP_D_lgt_6, woFDN_FLAP_D_lgt_7, woFDN_FLAP_D_lgt_8, woFDN_FLAP_D_lgt_9, 
      woFDN_FLAP_D_lgt_10, woFDN_FLAP_D_lgt_11, woFDN_FLAP_D_lgt_12, woFDN_FLAP_D_lgt_13, woFDN_FLAP_D_lgt_14, 
      woFDN_FLAP_D_lgt_15, woFDN_FLAP_D_lgt_16, woFDN_FLAP_D_lgt_17, woFDN_FLAP_D_lgt_18, woFDN_FLAP_D_lgt_19, 
      woFDN_FLAP_D_lgt_20, woFDN_FLAP_D_lgt_21, woFDN_FLAP_D_lgt_22, woFDN_FLAP_D_lgt_23, woFDN_FLAP_D_lgt_24, 
      woFDN_FLAP_D_lgt_25, woFDN_FLAP_D_lgt_26, woFDN_FLAP_D_lgt_27, woFDN_FLAP_D_lgt_28, woFDN_FLAP_D_lgt_29, 
      woFDN_FLAP_D_lgt_30, woFDN_FLAP_D_lgt_31, woFDN_FLAP_D_lgt_32, woFDN_FLAP_D_lgt_33, woFDN_FLAP_D_lgt_34, 
      woFDN_FLAP_D_lgt_35, woFDN_FLAP_D_lgt_36, woFDN_FLAP_D_lgt_37, woFDN_FLAP_D_lgt_38, woFDN_FLAP_D_lgt_39, 
      woFDN_FLAP_D_lgt_40, woFDN_FLAP_D_lgt_41, woFDN_FLAP_D_lgt_42, woFDN_FLAP_D_lgt_43, woFDN_FLAP_D_lgt_44, 
      woFDN_FLAP_D_lgt_45, woFDN_FLAP_D_lgt_46, woFDN_FLAP_D_lgt_47, woFDN_FLAP_D_lgt_48, woFDN_FLAP_D_lgt_49, 
      woFDN_FLAP_D_lgt_50, woFDN_FLAP_D_lgt_51, woFDN_FLAP_D_lgt_52, woFDN_FLAP_D_lgt_53, woFDN_FLAP_D_lgt_54, 
      woFDN_FLAP_D_lgt_55, woFDN_FLAP_D_lgt_56, woFDN_FLAP_D_lgt_57, woFDN_FLAP_D_lgt_58, woFDN_FLAP_D_lgt_59, 
      woFDN_FLAP_D_lgt_60, woFDN_FLAP_D_lgt_61, woFDN_FLAP_D_lgt_62, woFDN_FLAP_D_lgt_63, woFDN_FLAP_D_lgt_64, 
      woFDN_FLAP_D_lgt_65, woFDN_FLAP_D_lgt_66, woFDN_FLAP_D_lgt_67, woFDN_FLAP_D_lgt_68, woFDN_FLAP_D_lgt_69, 
      woFDN_FLAP_D_lgt_70, woFDN_FLAP_D_lgt_71, woFDN_FLAP_D_lgt_72, woFDN_FLAP_D_lgt_73, woFDN_FLAP_D_lgt_74, 
      woFDN_FLAP_D_lgt_75, woFDN_FLAP_D_lgt_76, woFDN_FLAP_D_lgt_77, woFDN_FLAP_D_lgt_78, woFDN_FLAP_D_lgt_79, 
      woFDN_FLAP_D_lgt_80, woFDN_FLAP_D_lgt_81, woFDN_FLAP_D_lgt_82, woFDN_FLAP_D_lgt_83, woFDN_FLAP_D_lgt_84, 
      woFDN_FLAP_D_lgt_85, woFDN_FLAP_D_lgt_86, woFDN_FLAP_D_lgt_87, woFDN_FLAP_D_lgt_88, woFDN_FLAP_D_lgt_89, 
      woFDN_FLAP_D_lgt_90, woFDN_FLAP_D_lgt_91, woFDN_FLAP_D_lgt_92, woFDN_FLAP_D_lgt_93, woFDN_FLAP_D_lgt_94, 
      woFDN_FLAP_D_lgt_95, woFDN_FLAP_D_lgt_96, woFDN_FLAP_D_lgt_97, woFDN_FLAP_D_lgt_98, woFDN_FLAP_D_lgt_99, 
      woFDN_FLAP_D_lgt_100, woFDN_FLAP_D_lgt_101, woFDN_FLAP_D_lgt_102, woFDN_FLAP_D_lgt_103, woFDN_FLAP_D_lgt_104, 
      woFDN_FLAP_D_lgt_105, woFDN_FLAP_D_lgt_106, woFDN_FLAP_D_lgt_107, woFDN_FLAP_D_lgt_108, woFDN_FLAP_D_lgt_109, 
      woFDN_FLAP_D_lgt_110, woFDN_FLAP_D_lgt_111, woFDN_FLAP_D_lgt_112, woFDN_FLAP_D_lgt_113, woFDN_FLAP_D_lgt_114, 
      woFDN_FLAP_D_lgt_115, woFDN_FLAP_D_lgt_116, woFDN_FLAP_D_lgt_117, woFDN_FLAP_D_lgt_118, woFDN_FLAP_D_lgt_119, 
      woFDN_FLAP_D_lgt_120, woFDN_FLAP_D_lgt_121, woFDN_FLAP_D_lgt_122, woFDN_FLAP_D_lgt_123, woFDN_FLAP_D_lgt_124, 
      woFDN_FLAP_D_lgt_125, woFDN_FLAP_D_lgt_126, woFDN_FLAP_D_lgt_127, woFDN_FLAP_D_lgt_128, woFDN_FLAP_D_lgt_129, 
      woFDN_FLAP_D_lgt_130, woFDN_FLAP_D_lgt_131, woFDN_FLAP_D_lgt_132, woFDN_FLAP_D_lgt_133, woFDN_FLAP_D_lgt_134, 
      woFDN_FLAP_D_lgt_135, woFDN_FLAP_D_lgt_136, woFDN_FLAP_D_lgt_137, woFDN_FLAP_D_lgt_138, woFDN_FLAP_D_lgt_139, 
      woFDN_FLAP_D_lgt_140, woFDN_FLAP_D_lgt_141, woFDN_FLAP_D_lgt_142, woFDN_FLAP_D_lgt_143, woFDN_FLAP_D_lgt_144, 
      woFDN_FLAP_D_lgt_145, woFDN_FLAP_D_lgt_146, woFDN_FLAP_D_lgt_147, woFDN_FLAP_D_lgt_148, woFDN_FLAP_D_lgt_149, 
      woFDN_FLAP_D_lgt_150, woFDN_FLAP_D_lgt_151, woFDN_FLAP_D_lgt_152, woFDN_FLAP_D_lgt_153, woFDN_FLAP_D_lgt_154, 
      woFDN_FLAP_D_lgt_155, woFDN_FLAP_D_lgt_156, woFDN_FLAP_D_lgt_157, woFDN_FLAP_D_lgt_158, woFDN_FLAP_D_lgt_159, 
      woFDN_FLAP_D_lgt_160, woFDN_FLAP_D_lgt_161, woFDN_FLAP_D_lgt_162, woFDN_FLAP_D_lgt_163, woFDN_FLAP_D_lgt_164, 
      woFDN_FLAP_D_lgt_165, woFDN_FLAP_D_lgt_166, woFDN_FLAP_D_lgt_167, woFDN_FLAP_D_lgt_168, woFDN_FLAP_D_lgt_169, 
      woFDN_FLAP_D_lgt_170, woFDN_FLAP_D_lgt_171, woFDN_FLAP_D_lgt_172, woFDN_FLAP_D_lgt_173, woFDN_FLAP_D_lgt_174, 
      woFDN_FLAP_D_lgt_175, woFDN_FLAP_D_lgt_176, woFDN_FLAP_D_lgt_177, woFDN_FLAP_D_lgt_178, woFDN_FLAP_D_lgt_179, 
      woFDN_FLAP_D_lgt_180, woFDN_FLAP_D_lgt_181, woFDN_FLAP_D_lgt_182, woFDN_FLAP_D_lgt_183, woFDN_FLAP_D_lgt_184, 
      woFDN_FLAP_D_lgt_185, woFDN_FLAP_D_lgt_186, woFDN_FLAP_D_lgt_187, woFDN_FLAP_D_lgt_188, woFDN_FLAP_D_lgt_189, 
      woFDN_FLAP_D_lgt_190, woFDN_FLAP_D_lgt_191, woFDN_FLAP_D_lgt_192, woFDN_FLAP_D_lgt_193, woFDN_FLAP_D_lgt_194, 
      woFDN_FLAP_D_lgt_195, woFDN_FLAP_D_lgt_196, woFDN_FLAP_D_lgt_197, woFDN_FLAP_D_lgt_198, woFDN_FLAP_D_lgt_199, 
      woFDN_FLAP_D_lgt_200, woFDN_FLAP_D_lgt_201, woFDN_FLAP_D_lgt_202, woFDN_FLAP_D_lgt_203, woFDN_FLAP_D_lgt_204, 
      woFDN_FLAP_D_lgt_205, woFDN_FLAP_D_lgt_206, woFDN_FLAP_D_lgt_207, woFDN_FLAP_D_lgt_208, woFDN_FLAP_D_lgt_209, 
      woFDN_FLAP_D_lgt_210, woFDN_FLAP_D_lgt_211, woFDN_FLAP_D_lgt_212, woFDN_FLAP_D_lgt_213, woFDN_FLAP_D_lgt_214, 
      woFDN_FLAP_D_lgt_215, woFDN_FLAP_D_lgt_216, woFDN_FLAP_D_lgt_217, woFDN_FLAP_D_lgt_218, woFDN_FLAP_D_lgt_219, 
      woFDN_FLAP_D_lgt_220, woFDN_FLAP_D_lgt_221, woFDN_FLAP_D_lgt_222, woFDN_FLAP_D_lgt_223, woFDN_FLAP_D_lgt_224, 
      woFDN_FLAP_D_lgt_225, woFDN_FLAP_D_lgt_226, woFDN_FLAP_D_lgt_227, woFDN_FLAP_D_lgt_228, woFDN_FLAP_D_lgt_229, 
      woFDN_FLAP_D_lgt_230, woFDN_FLAP_D_lgt_231, woFDN_FLAP_D_lgt_232, woFDN_FLAP_D_lgt_233, woFDN_FLAP_D_lgt_234, 
      woFDN_FLAP_D_lgt_235, woFDN_FLAP_D_lgt_236, woFDN_FLAP_D_lgt_237, woFDN_FLAP_D_lgt_238, woFDN_FLAP_D_lgt_239, 
      woFDN_FLAP_D_lgt_240, woFDN_FLAP_D_lgt_241, woFDN_FLAP_D_lgt_242, woFDN_FLAP_D_lgt_243, woFDN_FLAP_D_lgt_244, 
      woFDN_FLAP_D_lgt_245, woFDN_FLAP_D_lgt_246, woFDN_FLAP_D_lgt_247, woFDN_FLAP_D_lgt_248, woFDN_FLAP_D_lgt_249, 
      woFDN_FLAP_D_lgt_250, woFDN_FLAP_D_lgt_251, woFDN_FLAP_D_lgt_252, woFDN_FLAP_D_lgt_253, woFDN_FLAP_D_lgt_254, 
      woFDN_FLAP_D_lgt_255, woFDN_FLAP_D_lgt_256, woFDN_FLAP_D_lgt_257, woFDN_FLAP_D_lgt_258, woFDN_FLAP_D_lgt_259, 
      woFDN_FLAP_D_lgt_260, woFDN_FLAP_D_lgt_261, woFDN_FLAP_D_lgt_262, woFDN_FLAP_D_lgt_263, woFDN_FLAP_D_lgt_264, 
      woFDN_FLAP_D_lgt_265, woFDN_FLAP_D_lgt_266, woFDN_FLAP_D_lgt_267, woFDN_FLAP_D_lgt_268, woFDN_FLAP_D_lgt_269, 
      woFDN_FLAP_D_lgt_270, woFDN_FLAP_D_lgt_271, woFDN_FLAP_D_lgt_272, woFDN_FLAP_D_lgt_273, woFDN_FLAP_D_lgt_274, 
      woFDN_FLAP_D_lgt_275, woFDN_FLAP_D_lgt_276, woFDN_FLAP_D_lgt_277, woFDN_FLAP_D_lgt_278, woFDN_FLAP_D_lgt_279, 
      woFDN_FLAP_D_lgt_280, woFDN_FLAP_D_lgt_281, woFDN_FLAP_D_lgt_282, woFDN_FLAP_D_lgt_283, woFDN_FLAP_D_lgt_284, 
      woFDN_FLAP_D_lgt_285, woFDN_FLAP_D_lgt_286, woFDN_FLAP_D_lgt_287, woFDN_FLAP_D_lgt_288, woFDN_FLAP_D_lgt_289, 
      woFDN_FLAP_D_lgt_290, woFDN_FLAP_D_lgt_291, woFDN_FLAP_D_lgt_292, woFDN_FLAP_D_lgt_293, woFDN_FLAP_D_lgt_294, 
      woFDN_FLAP_D_lgt_295, woFDN_FLAP_D_lgt_296, woFDN_FLAP_D_lgt_297, woFDN_FLAP_D_lgt_298, woFDN_FLAP_D_lgt_299, 
      woFDN_FLAP_D_lgt_300, woFDN_FLAP_D_lgt_301, woFDN_FLAP_D_lgt_302, woFDN_FLAP_D_lgt_303, woFDN_FLAP_D_lgt_304); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_woFDN_LGT := woFDN_FLAP_D_lgt;
			
self.final_score_0	:= 	woFDN_FLAP_D_lgt_0	;
self.final_score_1	:= 	woFDN_FLAP_D_lgt_1	;
self.final_score_2	:= 	woFDN_FLAP_D_lgt_2	;
self.final_score_3	:= 	woFDN_FLAP_D_lgt_3	;
self.final_score_4	:= 	woFDN_FLAP_D_lgt_4	;
self.final_score_5	:= 	woFDN_FLAP_D_lgt_5	;
self.final_score_6	:= 	woFDN_FLAP_D_lgt_6	;
self.final_score_7	:= 	woFDN_FLAP_D_lgt_7	;
self.final_score_8	:= 	woFDN_FLAP_D_lgt_8	;
self.final_score_9	:= 	woFDN_FLAP_D_lgt_9	;
self.final_score_10	:= 	woFDN_FLAP_D_lgt_10	;
self.final_score_11	:= 	woFDN_FLAP_D_lgt_11	;
self.final_score_12	:= 	woFDN_FLAP_D_lgt_12	;
self.final_score_13	:= 	woFDN_FLAP_D_lgt_13	;
self.final_score_14	:= 	woFDN_FLAP_D_lgt_14	;
self.final_score_15	:= 	woFDN_FLAP_D_lgt_15	;
self.final_score_16	:= 	woFDN_FLAP_D_lgt_16	;
self.final_score_17	:= 	woFDN_FLAP_D_lgt_17	;
self.final_score_18	:= 	woFDN_FLAP_D_lgt_18	;
self.final_score_19	:= 	woFDN_FLAP_D_lgt_19	;
self.final_score_20	:= 	woFDN_FLAP_D_lgt_20	;
self.final_score_21	:= 	woFDN_FLAP_D_lgt_21	;
self.final_score_22	:= 	woFDN_FLAP_D_lgt_22	;
self.final_score_23	:= 	woFDN_FLAP_D_lgt_23	;
self.final_score_24	:= 	woFDN_FLAP_D_lgt_24	;
self.final_score_25	:= 	woFDN_FLAP_D_lgt_25	;
self.final_score_26	:= 	woFDN_FLAP_D_lgt_26	;
self.final_score_27	:= 	woFDN_FLAP_D_lgt_27	;
self.final_score_28	:= 	woFDN_FLAP_D_lgt_28	;
self.final_score_29	:= 	woFDN_FLAP_D_lgt_29	;
self.final_score_30	:= 	woFDN_FLAP_D_lgt_30	;
self.final_score_31	:= 	woFDN_FLAP_D_lgt_31	;
self.final_score_32	:= 	woFDN_FLAP_D_lgt_32	;
self.final_score_33	:= 	woFDN_FLAP_D_lgt_33	;
self.final_score_34	:= 	woFDN_FLAP_D_lgt_34	;
self.final_score_35	:= 	woFDN_FLAP_D_lgt_35	;
self.final_score_36	:= 	woFDN_FLAP_D_lgt_36	;
self.final_score_37	:= 	woFDN_FLAP_D_lgt_37	;
self.final_score_38	:= 	woFDN_FLAP_D_lgt_38	;
self.final_score_39	:= 	woFDN_FLAP_D_lgt_39	;
self.final_score_40	:= 	woFDN_FLAP_D_lgt_40	;
self.final_score_41	:= 	woFDN_FLAP_D_lgt_41	;
self.final_score_42	:= 	woFDN_FLAP_D_lgt_42	;
self.final_score_43	:= 	woFDN_FLAP_D_lgt_43	;
self.final_score_44	:= 	woFDN_FLAP_D_lgt_44	;
self.final_score_45	:= 	woFDN_FLAP_D_lgt_45	;
self.final_score_46	:= 	woFDN_FLAP_D_lgt_46	;
self.final_score_47	:= 	woFDN_FLAP_D_lgt_47	;
self.final_score_48	:= 	woFDN_FLAP_D_lgt_48	;
self.final_score_49	:= 	woFDN_FLAP_D_lgt_49	;
self.final_score_50	:= 	woFDN_FLAP_D_lgt_50	;
self.final_score_51	:= 	woFDN_FLAP_D_lgt_51	;
self.final_score_52	:= 	woFDN_FLAP_D_lgt_52	;
self.final_score_53	:= 	woFDN_FLAP_D_lgt_53	;
self.final_score_54	:= 	woFDN_FLAP_D_lgt_54	;
self.final_score_55	:= 	woFDN_FLAP_D_lgt_55	;
self.final_score_56	:= 	woFDN_FLAP_D_lgt_56	;
self.final_score_57	:= 	woFDN_FLAP_D_lgt_57	;
self.final_score_58	:= 	woFDN_FLAP_D_lgt_58	;
self.final_score_59	:= 	woFDN_FLAP_D_lgt_59	;
self.final_score_60	:= 	woFDN_FLAP_D_lgt_60	;
self.final_score_61	:= 	woFDN_FLAP_D_lgt_61	;
self.final_score_62	:= 	woFDN_FLAP_D_lgt_62	;
self.final_score_63	:= 	woFDN_FLAP_D_lgt_63	;
self.final_score_64	:= 	woFDN_FLAP_D_lgt_64	;
self.final_score_65	:= 	woFDN_FLAP_D_lgt_65	;
self.final_score_66	:= 	woFDN_FLAP_D_lgt_66	;
self.final_score_67	:= 	woFDN_FLAP_D_lgt_67	;
self.final_score_68	:= 	woFDN_FLAP_D_lgt_68	;
self.final_score_69	:= 	woFDN_FLAP_D_lgt_69	;
self.final_score_70	:= 	woFDN_FLAP_D_lgt_70	;
self.final_score_71	:= 	woFDN_FLAP_D_lgt_71	;
self.final_score_72	:= 	woFDN_FLAP_D_lgt_72	;
self.final_score_73	:= 	woFDN_FLAP_D_lgt_73	;
self.final_score_74	:= 	woFDN_FLAP_D_lgt_74	;
self.final_score_75	:= 	woFDN_FLAP_D_lgt_75	;
self.final_score_76	:= 	woFDN_FLAP_D_lgt_76	;
self.final_score_77	:= 	woFDN_FLAP_D_lgt_77	;
self.final_score_78	:= 	woFDN_FLAP_D_lgt_78	;
self.final_score_79	:= 	woFDN_FLAP_D_lgt_79	;
self.final_score_80	:= 	woFDN_FLAP_D_lgt_80	;
self.final_score_81	:= 	woFDN_FLAP_D_lgt_81	;
self.final_score_82	:= 	woFDN_FLAP_D_lgt_82	;
self.final_score_83	:= 	woFDN_FLAP_D_lgt_83	;
self.final_score_84	:= 	woFDN_FLAP_D_lgt_84	;
self.final_score_85	:= 	woFDN_FLAP_D_lgt_85	;
self.final_score_86	:= 	woFDN_FLAP_D_lgt_86	;
self.final_score_87	:= 	woFDN_FLAP_D_lgt_87	;
self.final_score_88	:= 	woFDN_FLAP_D_lgt_88	;
self.final_score_89	:= 	woFDN_FLAP_D_lgt_89	;
self.final_score_90	:= 	woFDN_FLAP_D_lgt_90	;
self.final_score_91	:= 	woFDN_FLAP_D_lgt_91	;
self.final_score_92	:= 	woFDN_FLAP_D_lgt_92	;
self.final_score_93	:= 	woFDN_FLAP_D_lgt_93	;
self.final_score_94	:= 	woFDN_FLAP_D_lgt_94	;
self.final_score_95	:= 	woFDN_FLAP_D_lgt_95	;
self.final_score_96	:= 	woFDN_FLAP_D_lgt_96	;
self.final_score_97	:= 	woFDN_FLAP_D_lgt_97	;
self.final_score_98	:= 	woFDN_FLAP_D_lgt_98	;
self.final_score_99	:= 	woFDN_FLAP_D_lgt_99	;
self.final_score_100	:= 	woFDN_FLAP_D_lgt_100	;
self.final_score_101	:= 	woFDN_FLAP_D_lgt_101	;
self.final_score_102	:= 	woFDN_FLAP_D_lgt_102	;
self.final_score_103	:= 	woFDN_FLAP_D_lgt_103	;
self.final_score_104	:= 	woFDN_FLAP_D_lgt_104	;
self.final_score_105	:= 	woFDN_FLAP_D_lgt_105	;
self.final_score_106	:= 	woFDN_FLAP_D_lgt_106	;
self.final_score_107	:= 	woFDN_FLAP_D_lgt_107	;
self.final_score_108	:= 	woFDN_FLAP_D_lgt_108	;
self.final_score_109	:= 	woFDN_FLAP_D_lgt_109	;
self.final_score_110	:= 	woFDN_FLAP_D_lgt_110	;
self.final_score_111	:= 	woFDN_FLAP_D_lgt_111	;
self.final_score_112	:= 	woFDN_FLAP_D_lgt_112	;
self.final_score_113	:= 	woFDN_FLAP_D_lgt_113	;
self.final_score_114	:= 	woFDN_FLAP_D_lgt_114	;
self.final_score_115	:= 	woFDN_FLAP_D_lgt_115	;
self.final_score_116	:= 	woFDN_FLAP_D_lgt_116	;
self.final_score_117	:= 	woFDN_FLAP_D_lgt_117	;
self.final_score_118	:= 	woFDN_FLAP_D_lgt_118	;
self.final_score_119	:= 	woFDN_FLAP_D_lgt_119	;
self.final_score_120	:= 	woFDN_FLAP_D_lgt_120	;
self.final_score_121	:= 	woFDN_FLAP_D_lgt_121	;
self.final_score_122	:= 	woFDN_FLAP_D_lgt_122	;
self.final_score_123	:= 	woFDN_FLAP_D_lgt_123	;
self.final_score_124	:= 	woFDN_FLAP_D_lgt_124	;
self.final_score_125	:= 	woFDN_FLAP_D_lgt_125	;
self.final_score_126	:= 	woFDN_FLAP_D_lgt_126	;
self.final_score_127	:= 	woFDN_FLAP_D_lgt_127	;
self.final_score_128	:= 	woFDN_FLAP_D_lgt_128	;
self.final_score_129	:= 	woFDN_FLAP_D_lgt_129	;
self.final_score_130	:= 	woFDN_FLAP_D_lgt_130	;
self.final_score_131	:= 	woFDN_FLAP_D_lgt_131	;
self.final_score_132	:= 	woFDN_FLAP_D_lgt_132	;
self.final_score_133	:= 	woFDN_FLAP_D_lgt_133	;
self.final_score_134	:= 	woFDN_FLAP_D_lgt_134	;
self.final_score_135	:= 	woFDN_FLAP_D_lgt_135	;
self.final_score_136	:= 	woFDN_FLAP_D_lgt_136	;
self.final_score_137	:= 	woFDN_FLAP_D_lgt_137	;
self.final_score_138	:= 	woFDN_FLAP_D_lgt_138	;
self.final_score_139	:= 	woFDN_FLAP_D_lgt_139	;
self.final_score_140	:= 	woFDN_FLAP_D_lgt_140	;
self.final_score_141	:= 	woFDN_FLAP_D_lgt_141	;
self.final_score_142	:= 	woFDN_FLAP_D_lgt_142	;
self.final_score_143	:= 	woFDN_FLAP_D_lgt_143	;
self.final_score_144	:= 	woFDN_FLAP_D_lgt_144	;
self.final_score_145	:= 	woFDN_FLAP_D_lgt_145	;
self.final_score_146	:= 	woFDN_FLAP_D_lgt_146	;
self.final_score_147	:= 	woFDN_FLAP_D_lgt_147	;
self.final_score_148	:= 	woFDN_FLAP_D_lgt_148	;
self.final_score_149	:= 	woFDN_FLAP_D_lgt_149	;
self.final_score_150	:= 	woFDN_FLAP_D_lgt_150	;
self.final_score_151	:= 	woFDN_FLAP_D_lgt_151	;
self.final_score_152	:= 	woFDN_FLAP_D_lgt_152	;
self.final_score_153	:= 	woFDN_FLAP_D_lgt_153	;
self.final_score_154	:= 	woFDN_FLAP_D_lgt_154	;
self.final_score_155	:= 	woFDN_FLAP_D_lgt_155	;
self.final_score_156	:= 	woFDN_FLAP_D_lgt_156	;
self.final_score_157	:= 	woFDN_FLAP_D_lgt_157	;
self.final_score_158	:= 	woFDN_FLAP_D_lgt_158	;
self.final_score_159	:= 	woFDN_FLAP_D_lgt_159	;
self.final_score_160	:= 	woFDN_FLAP_D_lgt_160	;
self.final_score_161	:= 	woFDN_FLAP_D_lgt_161	;
self.final_score_162	:= 	woFDN_FLAP_D_lgt_162	;
self.final_score_163	:= 	woFDN_FLAP_D_lgt_163	;
self.final_score_164	:= 	woFDN_FLAP_D_lgt_164	;
self.final_score_165	:= 	woFDN_FLAP_D_lgt_165	;
self.final_score_166	:= 	woFDN_FLAP_D_lgt_166	;
self.final_score_167	:= 	woFDN_FLAP_D_lgt_167	;
self.final_score_168	:= 	woFDN_FLAP_D_lgt_168	;
self.final_score_169	:= 	woFDN_FLAP_D_lgt_169	;
self.final_score_170	:= 	woFDN_FLAP_D_lgt_170	;
self.final_score_171	:= 	woFDN_FLAP_D_lgt_171	;
self.final_score_172	:= 	woFDN_FLAP_D_lgt_172	;
self.final_score_173	:= 	woFDN_FLAP_D_lgt_173	;
self.final_score_174	:= 	woFDN_FLAP_D_lgt_174	;
self.final_score_175	:= 	woFDN_FLAP_D_lgt_175	;
self.final_score_176	:= 	woFDN_FLAP_D_lgt_176	;
self.final_score_177	:= 	woFDN_FLAP_D_lgt_177	;
self.final_score_178	:= 	woFDN_FLAP_D_lgt_178	;
self.final_score_179	:= 	woFDN_FLAP_D_lgt_179	;
self.final_score_180	:= 	woFDN_FLAP_D_lgt_180	;
self.final_score_181	:= 	woFDN_FLAP_D_lgt_181	;
self.final_score_182	:= 	woFDN_FLAP_D_lgt_182	;
self.final_score_183	:= 	woFDN_FLAP_D_lgt_183	;
self.final_score_184	:= 	woFDN_FLAP_D_lgt_184	;
self.final_score_185	:= 	woFDN_FLAP_D_lgt_185	;
self.final_score_186	:= 	woFDN_FLAP_D_lgt_186	;
self.final_score_187	:= 	woFDN_FLAP_D_lgt_187	;
self.final_score_188	:= 	woFDN_FLAP_D_lgt_188	;
self.final_score_189	:= 	woFDN_FLAP_D_lgt_189	;
self.final_score_190	:= 	woFDN_FLAP_D_lgt_190	;
self.final_score_191	:= 	woFDN_FLAP_D_lgt_191	;
self.final_score_192	:= 	woFDN_FLAP_D_lgt_192	;
self.final_score_193	:= 	woFDN_FLAP_D_lgt_193	;
self.final_score_194	:= 	woFDN_FLAP_D_lgt_194	;
self.final_score_195	:= 	woFDN_FLAP_D_lgt_195	;
self.final_score_196	:= 	woFDN_FLAP_D_lgt_196	;
self.final_score_197	:= 	woFDN_FLAP_D_lgt_197	;
self.final_score_198	:= 	woFDN_FLAP_D_lgt_198	;
self.final_score_199	:= 	woFDN_FLAP_D_lgt_199	;
self.final_score_200	:= 	woFDN_FLAP_D_lgt_200	;
self.final_score_201	:= 	woFDN_FLAP_D_lgt_201	;
self.final_score_202	:= 	woFDN_FLAP_D_lgt_202	;
self.final_score_203	:= 	woFDN_FLAP_D_lgt_203	;
self.final_score_204	:= 	woFDN_FLAP_D_lgt_204	;
self.final_score_205	:= 	woFDN_FLAP_D_lgt_205	;
self.final_score_206	:= 	woFDN_FLAP_D_lgt_206	;
self.final_score_207	:= 	woFDN_FLAP_D_lgt_207	;
self.final_score_208	:= 	woFDN_FLAP_D_lgt_208	;
self.final_score_209	:= 	woFDN_FLAP_D_lgt_209	;
self.final_score_210	:= 	woFDN_FLAP_D_lgt_210	;
self.final_score_211	:= 	woFDN_FLAP_D_lgt_211	;
self.final_score_212	:= 	woFDN_FLAP_D_lgt_212	;
self.final_score_213	:= 	woFDN_FLAP_D_lgt_213	;
self.final_score_214	:= 	woFDN_FLAP_D_lgt_214	;
self.final_score_215	:= 	woFDN_FLAP_D_lgt_215	;
self.final_score_216	:= 	woFDN_FLAP_D_lgt_216	;
self.final_score_217	:= 	woFDN_FLAP_D_lgt_217	;
self.final_score_218	:= 	woFDN_FLAP_D_lgt_218	;
self.final_score_219	:= 	woFDN_FLAP_D_lgt_219	;
self.final_score_220	:= 	woFDN_FLAP_D_lgt_220	;
self.final_score_221	:= 	woFDN_FLAP_D_lgt_221	;
self.final_score_222	:= 	woFDN_FLAP_D_lgt_222	;
self.final_score_223	:= 	woFDN_FLAP_D_lgt_223	;
self.final_score_224	:= 	woFDN_FLAP_D_lgt_224	;
self.final_score_225	:= 	woFDN_FLAP_D_lgt_225	;
self.final_score_226	:= 	woFDN_FLAP_D_lgt_226	;
self.final_score_227	:= 	woFDN_FLAP_D_lgt_227	;
self.final_score_228	:= 	woFDN_FLAP_D_lgt_228	;
self.final_score_229	:= 	woFDN_FLAP_D_lgt_229	;
self.final_score_230	:= 	woFDN_FLAP_D_lgt_230	;
self.final_score_231	:= 	woFDN_FLAP_D_lgt_231	;
self.final_score_232	:= 	woFDN_FLAP_D_lgt_232	;
self.final_score_233	:= 	woFDN_FLAP_D_lgt_233	;
self.final_score_234	:= 	woFDN_FLAP_D_lgt_234	;
self.final_score_235	:= 	woFDN_FLAP_D_lgt_235	;
self.final_score_236	:= 	woFDN_FLAP_D_lgt_236	;
self.final_score_237	:= 	woFDN_FLAP_D_lgt_237	;
self.final_score_238	:= 	woFDN_FLAP_D_lgt_238	;
self.final_score_239	:= 	woFDN_FLAP_D_lgt_239	;
self.final_score_240	:= 	woFDN_FLAP_D_lgt_240	;
self.final_score_241	:= 	woFDN_FLAP_D_lgt_241	;
self.final_score_242	:= 	woFDN_FLAP_D_lgt_242	;
self.final_score_243	:= 	woFDN_FLAP_D_lgt_243	;
self.final_score_244	:= 	woFDN_FLAP_D_lgt_244	;
self.final_score_245	:= 	woFDN_FLAP_D_lgt_245	;
self.final_score_246	:= 	woFDN_FLAP_D_lgt_246	;
self.final_score_247	:= 	woFDN_FLAP_D_lgt_247	;
self.final_score_248	:= 	woFDN_FLAP_D_lgt_248	;
self.final_score_249	:= 	woFDN_FLAP_D_lgt_249	;
self.final_score_250	:= 	woFDN_FLAP_D_lgt_250	;
self.final_score_251	:= 	woFDN_FLAP_D_lgt_251	;
self.final_score_252	:= 	woFDN_FLAP_D_lgt_252	;
self.final_score_253	:= 	woFDN_FLAP_D_lgt_253	;
self.final_score_254	:= 	woFDN_FLAP_D_lgt_254	;
self.final_score_255	:= 	woFDN_FLAP_D_lgt_255	;
self.final_score_256	:= 	woFDN_FLAP_D_lgt_256	;
self.final_score_257	:= 	woFDN_FLAP_D_lgt_257	;
self.final_score_258	:= 	woFDN_FLAP_D_lgt_258	;
self.final_score_259	:= 	woFDN_FLAP_D_lgt_259	;
self.final_score_260	:= 	woFDN_FLAP_D_lgt_260	;
self.final_score_261	:= 	woFDN_FLAP_D_lgt_261	;
self.final_score_262	:= 	woFDN_FLAP_D_lgt_262	;
self.final_score_263	:= 	woFDN_FLAP_D_lgt_263	;
self.final_score_264	:= 	woFDN_FLAP_D_lgt_264	;
self.final_score_265	:= 	woFDN_FLAP_D_lgt_265	;
self.final_score_266	:= 	woFDN_FLAP_D_lgt_266	;
self.final_score_267	:= 	woFDN_FLAP_D_lgt_267	;
self.final_score_268	:= 	woFDN_FLAP_D_lgt_268	;
self.final_score_269	:= 	woFDN_FLAP_D_lgt_269	;
self.final_score_270	:= 	woFDN_FLAP_D_lgt_270	;
self.final_score_271	:= 	woFDN_FLAP_D_lgt_271	;
self.final_score_272	:= 	woFDN_FLAP_D_lgt_272	;
self.final_score_273	:= 	woFDN_FLAP_D_lgt_273	;
self.final_score_274	:= 	woFDN_FLAP_D_lgt_274	;
self.final_score_275	:= 	woFDN_FLAP_D_lgt_275	;
self.final_score_276	:= 	woFDN_FLAP_D_lgt_276	;
self.final_score_277	:= 	woFDN_FLAP_D_lgt_277	;
self.final_score_278	:= 	woFDN_FLAP_D_lgt_278	;
self.final_score_279	:= 	woFDN_FLAP_D_lgt_279	;
self.final_score_280	:= 	woFDN_FLAP_D_lgt_280	;
self.final_score_281	:= 	woFDN_FLAP_D_lgt_281	;
self.final_score_282	:= 	woFDN_FLAP_D_lgt_282	;
self.final_score_283	:= 	woFDN_FLAP_D_lgt_283	;
self.final_score_284	:= 	woFDN_FLAP_D_lgt_284	;
self.final_score_285	:= 	woFDN_FLAP_D_lgt_285	;
self.final_score_286	:= 	woFDN_FLAP_D_lgt_286	;
self.final_score_287	:= 	woFDN_FLAP_D_lgt_287	;
self.final_score_288	:= 	woFDN_FLAP_D_lgt_288	;
self.final_score_289	:= 	woFDN_FLAP_D_lgt_289	;
self.final_score_290	:= 	woFDN_FLAP_D_lgt_290	;
self.final_score_291	:= 	woFDN_FLAP_D_lgt_291	;
self.final_score_292	:= 	woFDN_FLAP_D_lgt_292	;
self.final_score_293	:= 	woFDN_FLAP_D_lgt_293	;
self.final_score_294	:= 	woFDN_FLAP_D_lgt_294	;
self.final_score_295	:= 	woFDN_FLAP_D_lgt_295	;
self.final_score_296	:= 	woFDN_FLAP_D_lgt_296	;
self.final_score_297	:= 	woFDN_FLAP_D_lgt_297	;
self.final_score_298	:= 	woFDN_FLAP_D_lgt_298	;
self.final_score_299	:= 	woFDN_FLAP_D_lgt_299	;
self.final_score_300	:= 	woFDN_FLAP_D_lgt_300	;
self.final_score_301	:= 	woFDN_FLAP_D_lgt_301	;
self.final_score_302	:= 	woFDN_FLAP_D_lgt_302	;
self.final_score_303	:= 	woFDN_FLAP_D_lgt_303	;
self.final_score_304	:= 	woFDN_FLAP_D_lgt_304	;
// self.woFDN_submodel_lgt	:= 	woFDN_FLAP_D_lgt	;
self.FP3_woFDN_LGT		:= 	woFDN_FLAP_D_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
