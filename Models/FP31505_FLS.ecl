
export FP31505_FLS( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   woFDN_FL__S__lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FL__S__lgt_1 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08442415105) => 0.0153361608,
      (f_add_curr_nhood_VAC_pct_i > 0.08442415105) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 55) => 0.3792197143,
         (c_rich_wht > 55) => 0.0498564611,
         (c_rich_wht = NULL) => 0.1982866114, 0.1982866114),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0381209249, 0.0381209249),
   (r_Ever_Asset_Owner_d > 0.5) => -0.0390975394,
   (r_Ever_Asset_Owner_d = NULL) => -0.0225704810, -0.0225704810),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0883467361,
   (f_inq_Communications_count_i > 0.5) => 0.4731802205,
   (f_inq_Communications_count_i = NULL) => 0.1837715096, 0.1837715096),
(f_srchvelocityrisktype_i = NULL) => 0.2508879082, -0.0017287100);

// Tree: 2 
woFDN_FL__S__lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 27.85) => -0.0348220695,
      (c_famotf18_p > 27.85) => 0.0721965260,
      (c_famotf18_p = NULL) => -0.0491233720, -0.0262986417),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.1927892272,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0215632065, -0.0215632065),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 0.0903666526,
      (f_rel_criminal_count_i > 1.5) => 0.3150418630,
      (f_rel_criminal_count_i = NULL) => 0.1703101086, 0.1703101086),
   (f_hh_payday_loan_users_i > 0.5) => 0.4948993982,
   (f_hh_payday_loan_users_i = NULL) => 0.2214882494, 0.2214882494),
(f_varrisktype_i = NULL) => 0.1614618475, -0.0060974866);

// Tree: 3 
woFDN_FL__S__lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.45) => -0.0273238330,
      (c_famotf18_p > 29.45) => 0.0795474904,
      (c_famotf18_p = NULL) => -0.0490320718, -0.0205857658),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 0.0669587665,
      (k_inq_per_ssn_i > 3.5) => 0.2589230695,
      (k_inq_per_ssn_i = NULL) => 0.1191679634, 0.1191679634),
   (f_varrisktype_i = NULL) => -0.0136452701, -0.0136452701),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.1096540265,
   (f_srchvelocityrisktype_i > 4.5) => 0.2926189850,
   (f_srchvelocityrisktype_i = NULL) => 0.1824145100, 0.1824145100),
(f_inq_Communications_count_i = NULL) => 0.1077896855, -0.0059174140);

// Tree: 4 
woFDN_FL__S__lgt_4 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.1308295785,
      (r_D33_Eviction_Recency_d > 549) => -0.0283986340,
      (r_D33_Eviction_Recency_d = NULL) => -0.0238521803, -0.0238521803),
   (f_assocsuspicousidcount_i > 14.5) => 0.4038744227,
   (f_assocsuspicousidcount_i = NULL) => -0.0216254549, -0.0216254549),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0441309129,
   (f_assocrisktype_i > 4.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.1484552162,
      (f_varrisktype_i > 2.5) => 0.2892145081,
      (f_varrisktype_i = NULL) => 0.2037421616, 0.2037421616),
   (f_assocrisktype_i = NULL) => 0.0882405718, 0.0882405718),
(f_srchvelocityrisktype_i = NULL) => 0.0981872260, -0.0064855000);

// Tree: 5 
woFDN_FL__S__lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 43.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 27.55) => 0.0244755374,
      (c_famotf18_p > 27.55) => 0.1650810056,
      (c_famotf18_p = NULL) => 0.0529976843, 0.0442542356),
   (f_mos_inq_banko_cm_lseen_d > 43.5) => -0.0278939509,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0165538836, -0.0165538836),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0461135621,
   (f_assocrisktype_i > 4.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0762813566,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.2329786193,
      (nf_seg_FraudPoint_3_0 = '') => 0.1776185085, 0.1776185085),
   (f_assocrisktype_i = NULL) => 0.0775317681, 0.0775317681),
(f_varrisktype_i = NULL) => 0.0914764401, -0.0050436113);

// Tree: 6 
woFDN_FL__S__lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1755331850,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0235193996,
      (f_assocrisktype_i > 8.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 116.5) => 0.3095921786,
         (f_M_Bureau_ADL_FS_all_d > 116.5) => 0.0583686267,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0923040662, 0.0923040662),
      (f_assocrisktype_i = NULL) => -0.0186791908, -0.0186791908),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0141094878, -0.0141094878),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1863490331,
   (r_I60_inq_comm_recency_d > 549) => 0.0833800273,
   (r_I60_inq_comm_recency_d = NULL) => 0.1242571703, 0.1242571703),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0600828325, -0.0089961006);

// Tree: 7 
woFDN_FL__S__lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0260603197,
   (f_assocrisktype_i > 3.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 133282.5) => 0.2586020647,
         (c_med_hval > 133282.5) => 0.1065085876,
         (c_med_hval = NULL) => 0.0092786510, 0.1336562664),
      (r_Ever_Asset_Owner_d > 0.5) => 0.0056928385,
      (r_Ever_Asset_Owner_d = NULL) => 0.0303676047, 0.0303676047),
   (f_assocrisktype_i = NULL) => -0.0129745061, -0.0129745061),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 4.5) => 0.0948529609,
   (r_C14_addrs_5yr_i > 4.5) => 0.2557269884,
   (r_C14_addrs_5yr_i = NULL) => 0.1159577219, 0.1159577219),
(f_inq_Communications_count_i = NULL) => 0.0489993253, -0.0081939772);

// Tree: 8 
woFDN_FL__S__lgt_8 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 61.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 13.5) => 0.0936394422,
   (f_srchfraudsrchcount_i > 13.5) => 0.1782943928,
   (f_srchfraudsrchcount_i = NULL) => 0.1001419239, 0.1001419239),
(r_I60_inq_comm_recency_d > 61.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
      map(
      (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0290332557,
      (f_hh_tot_derog_i > 4.5) => 0.0882333381,
      (f_hh_tot_derog_i = NULL) => -0.0240682265, -0.0240682265),
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 1.5) => 0.0392269687,
      (f_srchunvrfdphonecount_i > 1.5) => 0.1588595874,
      (f_srchunvrfdphonecount_i = NULL) => 0.0503813267, 0.0503813267),
   (f_srchvelocityrisktype_i = NULL) => -0.0152544734, -0.0152544734),
(r_I60_inq_comm_recency_d = NULL) => 0.0424829334, -0.0083994347);

// Tree: 9 
woFDN_FL__S__lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 35.15) => 0.1313751937,
   (c_fammar_p > 35.15) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0197115559,
      (f_varrisktype_i > 2.5) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0339823891,
         (r_D33_eviction_count_i > 0.5) => 0.1812246450,
         (r_D33_eviction_count_i = NULL) => 0.0424920116, 0.0424920116),
      (f_varrisktype_i = NULL) => -0.0135564156, -0.0135564156),
   (c_fammar_p = NULL) => -0.0297609423, -0.0097956440),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0561614010,
   (f_rel_criminal_count_i > 2.5) => 0.1808679762,
   (f_rel_criminal_count_i = NULL) => 0.1170894706, 0.1170894706),
(f_inq_PrepaidCards_count_i = NULL) => 0.0804512321, -0.0053911392);

// Tree: 10 
woFDN_FL__S__lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','6: Other']) => -0.0371317790,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 0.0105173742,
      (nf_seg_FraudPoint_3_0 = '') => -0.0149491443, -0.0149491443),
   (f_rel_felony_count_i > 1.5) => 0.0947212015,
   (f_rel_felony_count_i = NULL) => -0.0102815512, -0.0102815512),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0436060739,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.1562151690,
   (nf_seg_FraudPoint_3_0 = '') => 0.0952401982, 0.0952401982),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0981092979,
   (r_S66_adlperssn_count_i > 1.5) => 0.1249895710,
   (r_S66_adlperssn_count_i = NULL) => 0.0231018986, 0.0231018986), -0.0063370390);

// Tree: 11 
woFDN_FL__S__lgt_11 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0228628375,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3476694525,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 1.5) => 
            map(
            (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => -0.0046220692,
            (f_assocrisktype_i > 5.5) => 0.0840031265,
            (f_assocrisktype_i = NULL) => 0.0087972457, 0.0087972457),
         (f_inq_HighRiskCredit_count24_i > 1.5) => 0.0999691822,
         (f_inq_HighRiskCredit_count24_i = NULL) => 0.0152010874, 0.0152010874),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0215206524, 0.0215206524),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.1366139455,
   (f_inq_PrepaidCards_count_i = NULL) => 0.0228268843, 0.0280013411),
(nf_seg_FraudPoint_3_0 = '') => -0.0080185971, -0.0080185971);

// Tree: 12 
woFDN_FL__S__lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 51.2) => 0.2251564782,
      (c_high_ed > 51.2) => -0.0351674269,
      (c_high_ed = NULL) => 0.1370670760, 0.1370670760),
   (r_C10_M_Hdr_FS_d > 7.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 12.05) => -0.0136061147,
      (c_unemp > 12.05) => 0.1549708581,
      (c_unemp = NULL) => -0.0115990068, -0.0116002431),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0091510888, -0.0091510888),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1514863367,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0365027635,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0828881822, 0.0828881822),
(f_srchfraudsrchcount_i = NULL) => 0.0548199771, -0.0059313802);

// Tree: 13 
woFDN_FL__S__lgt_13 := map(
(NULL < c_unemp and c_unemp <= 11.05) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.0932708090,
      (r_D33_Eviction_Recency_d > 79.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 98.5) => -0.0172447252,
         (r_pb_order_freq_d > 98.5) => -0.0422271081,
         (r_pb_order_freq_d = NULL) => 0.0133596121, -0.0125248533),
      (r_D33_Eviction_Recency_d = NULL) => -0.0107377344, -0.0107377344),
   (f_assocsuspicousidcount_i > 13.5) => 0.1581300265,
   (f_assocsuspicousidcount_i = NULL) => 0.0154223845, -0.0091762394),
(c_unemp > 11.05) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0751363287,
   (f_rel_criminal_count_i > 2.5) => 0.2300623162,
   (f_rel_criminal_count_i = NULL) => 0.1311733880, 0.1311733880),
(c_unemp = NULL) => -0.0150980846, -0.0067007465);

// Tree: 14 
woFDN_FL__S__lgt_14 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 44.45) => 0.0677793822,
   (c_fammar_p > 44.45) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0202276949,
      (k_inq_per_ssn_i > 2.5) => 0.0370270630,
      (k_inq_per_ssn_i = NULL) => -0.0135994807, -0.0135994807),
   (c_fammar_p = NULL) => -0.0306286549, -0.0097817373),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 0.1528896170,
   (f_historical_count_d > 0.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 19.5) => -0.0514783722,
      (f_rel_count_i > 19.5) => 0.1083009971,
      (f_rel_count_i = NULL) => 0.0150963650, 0.0150963650),
   (f_historical_count_d = NULL) => 0.0896402554, 0.0896402554),
(f_inq_PrepaidCards_count_i = NULL) => 0.0078401401, -0.0067394681);

// Tree: 15 
woFDN_FL__S__lgt_15 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1299498448,
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 29.25) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0179600495,
         (r_D33_eviction_count_i > 2.5) => 0.1209665474,
         (r_D33_eviction_count_i = NULL) => -0.0166818146, -0.0166818146),
      (k_comb_age_d > 84.5) => 0.2829075725,
      (k_comb_age_d = NULL) => -0.0146952900, -0.0146952900),
   (c_famotf18_p > 29.25) => 0.0609712276,
   (c_famotf18_p = NULL) => -0.0285403416, -0.0091582060),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0745055131,
   (r_S66_adlperssn_count_i > 1.5) => 0.1442226572,
   (r_S66_adlperssn_count_i = NULL) => 0.0432711940, 0.0432711940), -0.0070077398);

// Tree: 16 
woFDN_FL__S__lgt_16 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => 0.0294003690,
      (f_inq_HighRiskCredit_count_i > 4.5) => 0.1140794764,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0359392962, 0.0359392962),
   (r_D30_Derog_Count_i > 5.5) => 0.1434780645,
   (r_D30_Derog_Count_i = NULL) => 0.0478470225, 0.0478470225),
(r_I60_inq_comm_recency_d > 549) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.05) => -0.0113013981,
   (c_unemp > 9.05) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 86.2) => 0.1639398837,
      (c_occunit_p > 86.2) => 0.0195690939,
      (c_occunit_p = NULL) => 0.0662073943, 0.0662073943),
   (c_unemp = NULL) => -0.0047671559, -0.0078293311),
(r_I60_inq_comm_recency_d = NULL) => 0.0107819927, -0.0025325737);

// Tree: 17 
woFDN_FL__S__lgt_17 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.35) => -0.0215118284,
   (c_unemp > 9.35) => 0.0655072005,
   (c_unemp = NULL) => -0.0129981630, -0.0180622216),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < c_health and c_health <= 43.05) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 2.5) => -0.0047355757,
      (f_assocsuspicousidcount_i > 2.5) => 0.0590677049,
      (f_assocsuspicousidcount_i = NULL) => 0.0234594772, 0.0234594772),
   (c_health > 43.05) => 0.1902833582,
   (c_health = NULL) => 0.0290378151, 0.0290378151),
(f_srchvelocityrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0651895922,
   (f_addrs_per_ssn_i > 3.5) => 0.1166337090,
   (f_addrs_per_ssn_i = NULL) => 0.0228359743, 0.0228359743), -0.0116928222);

// Tree: 18 
woFDN_FL__S__lgt_18 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 184.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => -0.0127943127,
      (f_hh_collections_ct_i > 4.5) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 320.5) => 0.0048648813,
         (r_A50_pb_average_dollars_d > 320.5) => 0.2504682463,
         (r_A50_pb_average_dollars_d = NULL) => 0.1353953410, 0.1353953410),
      (f_hh_collections_ct_i = NULL) => -0.0109305378, -0.0109305378),
   (c_bel_edu > 184.5) => 0.0760797018,
   (c_bel_edu = NULL) => -0.0031013877, -0.0065935650),
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_business and c_business <= 31.5) => 0.1394016008,
   (c_business > 31.5) => -0.0037842538,
   (c_business = NULL) => 0.0857069053, 0.0857069053),
(f_srchunvrfdaddrcount_i = NULL) => 0.0112431769, -0.0041607250);

// Tree: 19 
woFDN_FL__S__lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1679182321,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0066245052,
         (k_comb_age_d > 70.5) => 
            map(
            (NULL < c_born_usa and c_born_usa <= 25.5) => 0.3379665522,
            (c_born_usa > 25.5) => 0.0562525164,
            (c_born_usa = NULL) => 0.0942959503, 0.0942959503),
         (k_comb_age_d = NULL) => -0.0016466999, -0.0016466999),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0008036433, -0.0008036433),
   (r_D32_felony_count_i > 0.5) => 0.1318863742,
   (r_D32_felony_count_i = NULL) => 0.0009150286, 0.0009150286),
(f_inq_PrepaidCards_count_i > 1.5) => 0.1084330963,
(f_inq_PrepaidCards_count_i = NULL) => 0.0039797734, 0.0020059372);

// Tree: 20 
woFDN_FL__S__lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => -0.0124970341,
   (k_comb_age_d > 69.5) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 23) => 0.0495982261,
      (C_INC_15K_P > 23) => 0.3030091205,
      (C_INC_15K_P = NULL) => 0.0684532034, 0.0684532034),
   (k_comb_age_d = NULL) => -0.0074787701, -0.0074787701),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 10.75) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 10.5) => 0.0351704103,
      (f_assocsuspicousidcount_i > 10.5) => 0.1281077472,
      (f_assocsuspicousidcount_i = NULL) => 0.0398972702, 0.0398972702),
   (c_unemp > 10.75) => 0.1780169133,
   (c_unemp = NULL) => 0.0452974367, 0.0452974367),
(f_varrisktype_i = NULL) => 0.0338654575, -0.0014088887);

// Tree: 21 
woFDN_FL__S__lgt_21 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 5.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 7.55) => -0.0009647015,
   (c_famotf18_p > 7.55) => 0.1879620346,
   (c_famotf18_p = NULL) => 0.1082941339, 0.1082941339),
(r_C21_M_Bureau_ADL_FS_d > 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0214720232,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_professional and c_professional <= 2.85) => 
         map(
         (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 0.5) => 0.1044117604,
         (f_hh_workers_paw_d > 0.5) => 0.0284163870,
         (f_hh_workers_paw_d = NULL) => 0.0581790802, 0.0581790802),
      (c_professional > 2.85) => -0.0037599505,
      (c_professional = NULL) => 0.0016969230, 0.0239702893),
   (nf_seg_FraudPoint_3_0 = '') => -0.0117721337, -0.0117721337),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0008817112, -0.0100303736);

// Tree: 22 
woFDN_FL__S__lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1649912807,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0195951644,
      (f_rel_criminal_count_i > 2.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
            map(
            (NULL < c_sub_bus and c_sub_bus <= 127.5) => 0.0640699547,
            (c_sub_bus > 127.5) => 0.1958526356,
            (c_sub_bus = NULL) => 0.1068910273, 0.1068910273),
         (k_estimated_income_d > 28500) => 0.0113598306,
         (k_estimated_income_d = NULL) => 0.0233573282, 0.0233573282),
      (f_rel_criminal_count_i = NULL) => -0.0084991038, -0.0084991038),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0076331882, -0.0076331882),
(r_D33_eviction_count_i > 2.5) => 0.1198596766,
(r_D33_eviction_count_i = NULL) => 0.0084879713, -0.0061487926);

// Tree: 23 
woFDN_FL__S__lgt_23 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 29500) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0192047912,
      (f_rel_felony_count_i > 2.5) => 0.1399950275,
      (f_rel_felony_count_i = NULL) => 0.0237990316, 0.0237990316),
   (k_estimated_income_d > 29500) => -0.0138581307,
   (k_estimated_income_d = NULL) => -0.0060909755, -0.0060909755),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 78.75) => 0.0273985363,
   (c_sfdu_p > 78.75) => 0.1490647981,
   (c_sfdu_p = NULL) => 0.0593359300, 0.0593359300),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0839083815,
   (r_S66_adlperssn_count_i > 1.5) => 0.0730139493,
   (r_S66_adlperssn_count_i = NULL) => 0.0016856171, 0.0016856171), -0.0043301899);

// Tree: 24 
woFDN_FL__S__lgt_24 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 115) => 0.1842417644,
(r_D32_Mos_Since_Fel_LS_d > 115) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 86.5) => -0.0073816309,
   (r_pb_order_freq_d > 86.5) => -0.0362327912,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0214278512,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0370276712,
         (nf_seg_FraudPoint_3_0 = '') => 0.0106203627, 0.0106203627),
      (f_rel_criminal_count_i > 6.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 0.2314082151,
         (r_C12_Num_NonDerogs_d > 1.5) => 0.0682457746,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0938497268, 0.0938497268),
      (f_rel_criminal_count_i = NULL) => 0.0162780794, 0.0162780794), -0.0060540815),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0060159860, -0.0048990762);

// Tree: 25 
woFDN_FL__S__lgt_25 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 0.0090643999,
   (f_historical_count_d > 0.5) => -0.0350396769,
   (f_historical_count_d = NULL) => -0.0119154793, -0.0119154793),
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1272897644) => 0.0155214677,
      (f_add_curr_nhood_BUS_pct_i > 0.1272897644) => 0.1215630652,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0429891494, 0.0294455734),
   (f_srchcomponentrisktype_i > 3.5) => 0.1531925152,
   (f_srchcomponentrisktype_i = NULL) => 0.0359912078, 0.0359912078),
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0562335608,
   (f_addrs_per_ssn_i > 5.5) => 0.0909351797,
   (f_addrs_per_ssn_i = NULL) => 0.0006270889, 0.0006270889), -0.0050021148);

// Tree: 26 
woFDN_FL__S__lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 158.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0215466647,
      (f_nae_nothing_found_i > 0.5) => 0.2785166700,
      (f_nae_nothing_found_i = NULL) => -0.0187267615, -0.0187267615),
   (r_A50_pb_average_dollars_d > 158.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 8.5) => 0.0152751415,
      (f_rel_criminal_count_i > 8.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 92.5) => 0.0117040013,
         (c_oldhouse > 92.5) => 0.1939158787,
         (c_oldhouse = NULL) => 0.1066867884, 0.1066867884),
      (f_rel_criminal_count_i = NULL) => 0.0185343583, 0.0185343583),
   (r_A50_pb_average_dollars_d = NULL) => -0.0026033512, -0.0026033512),
(r_D30_Derog_Count_i > 11.5) => 0.1145759197,
(r_D30_Derog_Count_i = NULL) => 0.0107196825, -0.0008911647);

// Tree: 27 
woFDN_FL__S__lgt_27 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 25462.5) => 0.1356997638,
      (r_A46_Curr_AVM_AutoVal_d > 25462.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 6.5) => 0.1361976276,
         (f_M_Bureau_ADL_FS_noTU_d > 6.5) => -0.0210959080,
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0189347818, -0.0189347818),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0120192980, -0.0146883751),
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < c_employees and c_employees <= 40.5) => 0.1205955924,
      (c_employees > 40.5) => 0.0240246875,
      (c_employees = NULL) => 0.0367441195, 0.0367441195),
   (k_inq_per_ssn_i = NULL) => -0.0086555124, -0.0086555124),
(r_D33_eviction_count_i > 0.5) => 0.0625176552,
(r_D33_eviction_count_i = NULL) => 0.0188074917, -0.0057456403);

// Tree: 28 
woFDN_FL__S__lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 29.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 6.5) => -0.0099305393,
      (f_inq_HighRiskCredit_count_i > 6.5) => 0.1529522134,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0069245008, -0.0069245008),
   (r_pb_order_freq_d > 29.5) => -0.0269083485,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0026595102,
      (f_assocrisktype_i > 4.5) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 20.65) => 0.1929227992,
         (c_sfdu_p > 20.65) => 0.0534412358,
         (c_sfdu_p = NULL) => 0.0643707613, 0.0643707613),
      (f_assocrisktype_i = NULL) => 0.0136495427, 0.0136495427), -0.0067577246),
(r_D33_eviction_count_i > 2.5) => 0.0919845056,
(r_D33_eviction_count_i = NULL) => -0.0045432786, -0.0056838178);

// Tree: 29 
woFDN_FL__S__lgt_29 := map(
(NULL < c_exp_prod and c_exp_prod <= 33.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08567437715) => 0.0195015504,
   (f_add_curr_nhood_VAC_pct_i > 0.08567437715) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 139.5) => 0.0209406249,
      (c_sub_bus > 139.5) => 0.1701887032,
      (c_sub_bus = NULL) => 0.0898243533, 0.0898243533),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0365611985, 0.0365611985),
(c_exp_prod > 33.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0115636424,
   (k_comb_age_d > 67.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 180.5) => 0.0348365903,
      (c_sub_bus > 180.5) => 0.2692996692,
      (c_sub_bus = NULL) => 0.0537255596, 0.0537255596),
   (k_comb_age_d = NULL) => 0.0116409479, -0.0068543755),
(c_exp_prod = NULL) => -0.0251674681, -0.0041969780);

// Tree: 30 
woFDN_FL__S__lgt_30 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.35) => 0.0218574594,
   (c_unemp > 11.35) => 0.1417917766,
   (c_unemp = NULL) => 0.0526469558, 0.0253964232),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
      map(
      (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 2.5) => -0.0194565486,
      (f_srchunvrfdphonecount_i > 2.5) => 0.0994626399,
      (f_srchunvrfdphonecount_i = NULL) => -0.0188023326, -0.0188023326),
   (f_hh_tot_derog_i > 5.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 17.7) => 0.0263978228,
      (c_pop_45_54_p > 17.7) => 0.2069758954,
      (c_pop_45_54_p = NULL) => 0.0620187029, 0.0620187029),
   (f_hh_tot_derog_i = NULL) => -0.0158209308, -0.0158209308),
(f_hh_members_ct_d = NULL) => -0.0072892852, -0.0074077881);

// Tree: 31 
woFDN_FL__S__lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1006874146,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => -0.0051582913,
      (k_comb_age_d > 71.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 24.8) => 0.0467963916,
         (c_hh3_p > 24.8) => 0.2398054602,
         (c_hh3_p = NULL) => 0.0642159827, 0.0642159827),
      (k_comb_age_d = NULL) => -0.0019889365, -0.0019889365),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0015040714, -0.0015040714),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1623679580,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_health and c_health <= 11.85) => -0.0472194489,
   (c_health > 11.85) => 0.0662913334,
   (c_health = NULL) => -0.0038182674, -0.0038182674), -0.0008576645);

// Tree: 32 
woFDN_FL__S__lgt_32 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 11.25) => 0.0227703793,
         (c_unemp > 11.25) => 0.1254089711,
         (c_unemp = NULL) => 0.0393498253, 0.0258828364),
      (f_hh_members_ct_d > 1.5) => -0.0120701687,
      (f_hh_members_ct_d = NULL) => -0.0042415479, -0.0042415479),
   (f_hh_collections_ct_i > 4.5) => 0.1007650026,
   (f_hh_collections_ct_i = NULL) => -0.0029541632, -0.0029541632),
(f_inq_PrepaidCards_count24_i > 0.5) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 1.35) => 0.1261735285,
   (c_pop_85p_p > 1.35) => 0.0055493445,
   (c_pop_85p_p = NULL) => 0.0762600731, 0.0762600731),
(f_inq_PrepaidCards_count24_i = NULL) => 0.0197759205, -0.0017764199);

// Tree: 33 
woFDN_FL__S__lgt_33 := map(
(NULL < c_white_col and c_white_col <= 18.75) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 65.75) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 77.5) => 0.0201933890,
      (f_fp_prevaddrcrimeindex_i > 77.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 3.75) => 0.0765237587,
         (c_incollege > 3.75) => 
            map(
            (NULL < c_vacant_p and c_vacant_p <= 10.2) => 0.1277723101,
            (c_vacant_p > 10.2) => 0.2979372859,
            (c_vacant_p = NULL) => 0.2120742247, 0.2120742247),
         (c_incollege = NULL) => 0.1446113200, 0.1446113200),
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0923824024, 0.0923824024),
   (c_lowrent > 65.75) => -0.0338851370,
   (c_lowrent = NULL) => 0.0603779568, 0.0603779568),
(c_white_col > 18.75) => -0.0041942415,
(c_white_col = NULL) => -0.0135803790, -0.0018544319);

// Tree: 34 
woFDN_FL__S__lgt_34 := map(
(NULL < c_hhsize and c_hhsize <= 3.305) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 0.5) => 0.1023597999,
      (r_S65_SSN_Problem_i > 0.5) => -0.1061810199,
      (r_S65_SSN_Problem_i = NULL) => 0.0783683781, 0.0783683781),
   (f_corrssnnamecount_d > 1.5) => -0.0099101066,
   (f_corrssnnamecount_d = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => -0.0654246665,
      (f_addrs_per_ssn_i > 7.5) => 0.0746626156,
      (f_addrs_per_ssn_i = NULL) => -0.0080118460, -0.0080118460), -0.0054416804),
(c_hhsize > 3.305) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 15.65) => 0.0356673625,
   (c_pop_55_64_p > 15.65) => 0.3328603405,
   (c_pop_55_64_p = NULL) => 0.0500354709, 0.0500354709),
(c_hhsize = NULL) => -0.0064153851, -0.0003078026);

// Tree: 35 
woFDN_FL__S__lgt_35 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 134.5) => -0.0145754728,
   (c_easiqlife > 134.5) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 0.1642526180,
      (f_attr_arrest_recency_d > 99.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 2.5) => 0.0015765431,
         (r_S66_adlperssn_count_i > 2.5) => 0.0672725683,
         (r_S66_adlperssn_count_i = NULL) => 0.0127404709, 0.0127404709),
      (f_attr_arrest_recency_d = NULL) => 0.0149528479, 0.0149528479),
   (c_easiqlife = NULL) => -0.0011313103, -0.0041646800),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < c_child and c_child <= 24.85) => -0.0012747952,
   (c_child > 24.85) => 0.1897199880,
   (c_child = NULL) => 0.0979823362, 0.0979823362),
(f_hh_lienholders_i = NULL) => 0.0085895015, -0.0030022260);

// Tree: 36 
woFDN_FL__S__lgt_36 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 16.85) => 0.0428731264,
   (c_hh2_p > 16.85) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
         map(
         (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 4.5) => 
            map(
            (NULL < c_medi_indx and c_medi_indx <= 103.5) => 0.0677174979,
            (c_medi_indx > 103.5) => -0.1070332233,
            (c_medi_indx = NULL) => -0.0144569484, -0.0144569484),
         (f_rel_homeover100_count_d > 4.5) => 0.1069745197,
         (f_rel_homeover100_count_d = NULL) => 0.1491713653, 0.0445023881),
      (r_C10_M_Hdr_FS_d > 11.5) => -0.0149788146,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0134330000, -0.0134330000),
   (c_hh2_p = NULL) => -0.0419609189, -0.0112920428),
(r_D32_criminal_count_i > 2.5) => 0.0515894098,
(r_D32_criminal_count_i = NULL) => -0.0134634041, -0.0078027502);

// Tree: 37 
woFDN_FL__S__lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0083520866,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 87.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => 0.0436690483,
      (r_C13_Curr_Addr_LRes_d > 310.5) => 0.2296067316,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0537511750, 0.0537511750),
   (c_born_usa > 87.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 23.5) => 0.1118159828,
      (k_comb_age_d > 23.5) => -0.0097197447,
      (k_comb_age_d = NULL) => 0.0006881929, 0.0006881929),
   (c_born_usa = NULL) => 0.0277343794, 0.0277343794),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0344156202,
   (f_addrs_per_ssn_i > 5.5) => 0.0910139866,
   (f_addrs_per_ssn_i = NULL) => 0.0154003938, 0.0154003938), 0.0027307616);

// Tree: 38 
woFDN_FL__S__lgt_38 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0175471874,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.1957086598,
   (nf_seg_FraudPoint_3_0 = '') => 0.0827282139, 0.0827282139),
(r_D32_Mos_Since_Crim_LS_d > 9.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0247219075,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 44.5) => 0.0519640020,
      (c_exp_prod > 44.5) => 
         map(
         (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0126206931,
         (f_inq_Other_count_i > 0.5) => 0.0341071289,
         (f_inq_Other_count_i = NULL) => 0.0001093738, 0.0001093738),
      (c_exp_prod = NULL) => -0.0007927357, 0.0059205079),
   (nf_seg_FraudPoint_3_0 = '') => -0.0070691577, -0.0070691577),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0072427608, -0.0056196830);

// Tree: 39 
woFDN_FL__S__lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0041006390,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 56.3) => 
         map(
         (NULL < c_rnt2000_p and c_rnt2000_p <= 1.1) => 0.2791394627,
         (c_rnt2000_p > 1.1) => 0.1004574876,
         (c_rnt2000_p = NULL) => 0.1932084365, 0.1932084365),
      (C_OWNOCC_P > 56.3) => 0.0510954695,
      (C_OWNOCC_P = NULL) => 0.1125370493, 0.1125370493),
   (f_inq_count_i > 2.5) => 
      map(
      (NULL < c_pop00 and c_pop00 <= 1141.5) => 0.0673502415,
      (c_pop00 > 1141.5) => -0.0038694668,
      (c_pop00 = NULL) => 0.0123330168, 0.0123330168),
   (f_inq_count_i = NULL) => 0.0325056707, 0.0325056707),
(k_inq_per_ssn_i = NULL) => 0.0002915410, 0.0002915410);

// Tree: 40 
woFDN_FL__S__lgt_40 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => -0.0072129146,
   (f_inq_count_i > 14.5) => 0.1095832636,
   (f_inq_count_i = NULL) => 0.0079021647, -0.0059187730),
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 
      map(
      (NULL < c_construction and c_construction <= 3.25) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.99215638025) => 0.0455089152,
         (f_add_curr_nhood_SFD_pct_d > 0.99215638025) => 0.2245729572,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0634872327, 0.0634872327),
      (c_construction > 3.25) => -0.0060617552,
      (c_construction = NULL) => 0.0171523172, 0.0171523172),
   (k_comb_age_d > 70.5) => 0.2367953803,
   (k_comb_age_d = NULL) => 0.0246097690, 0.0246097690),
(k_inq_per_ssn_i = NULL) => -0.0021571561, -0.0021571561);

// Tree: 41 
woFDN_FL__S__lgt_41 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 41.5) => -0.0031962893,
(r_pb_order_freq_d > 41.5) => -0.0295596773,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 29.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
            map(
            (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 0.5) => 0.1856291848,
            (f_rel_under25miles_cnt_d > 0.5) => 0.0395840181,
            (f_rel_under25miles_cnt_d = NULL) => 0.1126066015, 0.1126066015),
         (r_C10_M_Hdr_FS_d > 15.5) => 0.0346096573,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0596195470, 0.0596195470),
      (r_C13_max_lres_d > 29.5) => 0.0111737299,
      (r_C13_max_lres_d = NULL) => 0.0153101709, 0.0153101709),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0559322603,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0027172446, 0.0083368971), -0.0080230853);

// Tree: 42 
woFDN_FL__S__lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 222) => 0.0935390006,
(r_D32_Mos_Since_Fel_LS_d > 222) => 
   map(
   (NULL < c_employees and c_employees <= 40.5) => 
      map(
      (NULL < c_med_inc and c_med_inc <= 67.5) => 
         map(
         (NULL < c_pop_12_17_p and c_pop_12_17_p <= 9.95) => 
            map(
            (NULL < C_INC_25K_P and C_INC_25K_P <= 8.95) => 0.2399760445,
            (C_INC_25K_P > 8.95) => -0.0022404449,
            (C_INC_25K_P = NULL) => 0.0336695579, 0.0336695579),
         (c_pop_12_17_p > 9.95) => 0.1185415402,
         (c_pop_12_17_p = NULL) => 0.0653612817, 0.0653612817),
      (c_med_inc > 67.5) => 0.0080329240,
      (c_med_inc = NULL) => 0.0286171414, 0.0286171414),
   (c_employees > 40.5) => -0.0096860137,
   (c_employees = NULL) => -0.0326853396, -0.0055459100),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0196559221, -0.0048390946);

// Tree: 43 
woFDN_FL__S__lgt_43 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 41.75) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 5.45) => 0.0311865531,
      (c_hh7p_p > 5.45) => 0.1758283489,
      (c_hh7p_p = NULL) => 0.0441578140, 0.0441578140),
   (r_I61_inq_collection_recency_d > 9) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 218.4) => -0.0118909114,
      (c_cpiall > 218.4) => 
         map(
         (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 0.0189140943,
         (r_D32_criminal_count_i > 2.5) => 0.1270997793,
         (r_D32_criminal_count_i = NULL) => 0.0223720843, 0.0223720843),
      (c_cpiall = NULL) => -0.0034940147, -0.0034940147),
   (r_I61_inq_collection_recency_d = NULL) => -0.0179414936, -0.0013461952),
(c_hval_60k_p > 41.75) => -0.1111351790,
(c_hval_60k_p = NULL) => 0.0156057465, -0.0014146265);

// Tree: 44 
woFDN_FL__S__lgt_44 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.55) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 452.5) => -0.0077890672,
      (r_C13_Curr_Addr_LRes_d > 452.5) => 0.1316768044,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0067253546, -0.0067253546),
   (c_hh7p_p > 7.55) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 0.1525804386,
      (f_mos_inq_banko_cm_lseen_d > 37.5) => 0.0331835227,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0507763885, 0.0507763885),
   (c_hh7p_p = NULL) => -0.0046726317, -0.0043308963),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1014958404,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 3.65) => 0.0769326564,
   (c_hval_125k_p > 3.65) => -0.0550491551,
   (c_hval_125k_p = NULL) => 0.0104529291, 0.0104529291), -0.0036873540);

// Tree: 45 
woFDN_FL__S__lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0026210657,
(k_comb_age_d > 67.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 19.5) => 0.1872627347,
   (c_born_usa > 19.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 155.5) => 0.0096184769,
      (f_curraddrmurderindex_i > 155.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 74.5) => -0.0403517134,
         (c_exp_prod > 74.5) => 0.2730024334,
         (c_exp_prod = NULL) => 0.1285870440, 0.1285870440),
      (f_curraddrmurderindex_i = NULL) => 0.0269147920, 0.0269147920),
   (c_born_usa = NULL) => 0.0437649147, 0.0437649147),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 11.35) => -0.0575789175,
   (c_rnt1000_p > 11.35) => 0.1010331912,
   (c_rnt1000_p = NULL) => 0.0199109677, 0.0199109677), 0.0009681135);

// Tree: 46 
woFDN_FL__S__lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 2.05) => -0.0005573318,
      (c_hval_500k_p > 2.05) => 0.1992292086,
      (c_hval_500k_p = NULL) => 0.0846596759, 0.0846596759),
   (f_mos_liens_unrel_SC_fseen_d > 87.5) => 
      map(
      (NULL < c_finance and c_finance <= 0.15) => 0.0207560200,
      (c_finance > 0.15) => -0.0134401377,
      (c_finance = NULL) => -0.0130577191, -0.0026331204),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0011402136, -0.0011402136),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 132.5) => 0.0066534597,
   (c_serv_empl > 132.5) => 0.1411211889,
   (c_serv_empl = NULL) => 0.0641667656, 0.0641667656),
(r_D32_felony_count_i = NULL) => -0.0281609119, -0.0005475914);

// Tree: 47 
woFDN_FL__S__lgt_47 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => -0.0081560356,
   (f_hh_lienholders_i > 1.5) => 0.0327133114,
   (f_hh_lienholders_i = NULL) => -0.0038259114, -0.0038259114),
(f_srchfraudsrchcountmo_i > 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 179.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.25) => -0.0143053830,
      (c_incollege > 6.25) => 0.0936079073,
      (c_incollege = NULL) => 0.0337455597, 0.0337455597),
   (f_prevaddrlenofres_d > 179.5) => 0.2208854505,
   (f_prevaddrlenofres_d = NULL) => 0.0540868522, 0.0540868522),
(f_srchfraudsrchcountmo_i = NULL) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1091) => -0.0547201729,
   (c_popover25 > 1091) => 0.0460448983,
   (c_popover25 = NULL) => -0.0022557143, -0.0022557143), -0.0017103304);

// Tree: 48 
woFDN_FL__S__lgt_48 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 124975.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.1791525529,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => 0.0169733664,
      (r_D32_criminal_count_i > 5.5) => 0.1220592887,
      (r_D32_criminal_count_i = NULL) => 0.0205950676, 0.0205950676),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0248332393, 0.0248332393),
(r_A46_Curr_AVM_AutoVal_d > 124975.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1291044586,
   (r_C10_M_Hdr_FS_d > 7.5) => -0.0062771217,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0047691901, -0.0047691901),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 6.5) => -0.0364644556,
   (f_addrs_per_ssn_i > 6.5) => 0.0077219353,
   (f_addrs_per_ssn_i = NULL) => -0.0102187070, -0.0102187070), -0.0026707997);

// Tree: 49 
woFDN_FL__S__lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 0.0026274377,
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1019) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 91.5) => 0.1114219300,
         (c_medi_indx > 91.5) => -0.0243233273,
         (c_medi_indx = NULL) => 0.0204278565, 0.0204278565),
      (c_med_rent > 1019) => 0.1603851303,
      (c_med_rent = NULL) => 0.0559907703, 0.0559907703),
   (f_varrisktype_i = NULL) => 0.0037219111, 0.0037219111),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0669840555,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 425) => -0.0646242162,
   (c_families > 425) => 0.0837016306,
   (c_families = NULL) => -0.0005474504, -0.0005474504), 0.0008138035);

// Tree: 50 
woFDN_FL__S__lgt_50 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1093915368,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 14.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 235.5) => -0.0142830534,
      (r_A50_pb_average_dollars_d > 235.5) => 0.0156671150,
      (r_A50_pb_average_dollars_d = NULL) => -0.0022399331, -0.0022399331),
   (f_srchssnsrchcount_i > 14.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 31.55) => -0.0234895032,
      (c_fammar18_p > 31.55) => 0.1176703580,
      (c_fammar18_p = NULL) => 0.0654605463, 0.0654605463),
   (f_srchssnsrchcount_i = NULL) => -0.0014435843, -0.0014435843),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.35) => -0.0225645124,
   (c_pop_55_64_p > 12.35) => 0.0919978144,
   (c_pop_55_64_p = NULL) => 0.0245037304, 0.0245037304), -0.0007043530);

// Tree: 51 
woFDN_FL__S__lgt_51 := map(
(NULL < c_employees and c_employees <= 55.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 37.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 331.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','6: Other']) => -0.0164128199,
         (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
            map(
            (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 0.1769277645,
            (k_estimated_income_d > 32500) => 0.0508171283,
            (k_estimated_income_d = NULL) => 0.0860329286, 0.0860329286),
         (nf_seg_FraudPoint_3_0 = '') => 0.0334002505, 0.0334002505),
      (r_C13_max_lres_d > 331.5) => 0.3387984627,
      (r_C13_max_lres_d = NULL) => 0.0600010998, 0.0600010998),
   (c_born_usa > 37.5) => 0.0087480720,
   (c_born_usa = NULL) => 0.0230204689, 0.0230204689),
(c_employees > 55.5) => -0.0075659482,
(c_employees = NULL) => -0.0003120267, -0.0021564354);

// Tree: 52 
woFDN_FL__S__lgt_52 := map(
(NULL < c_sub_bus and c_sub_bus <= 118.5) => -0.0141607796,
(c_sub_bus > 118.5) => 
   map(
   (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 32.75) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 192.5) => 
            map(
            (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 350) => 0.0297512919,
            (f_acc_damage_amt_total_i > 350) => 0.2035075684,
            (f_acc_damage_amt_total_i = NULL) => 0.0333013633, 0.0333013633),
         (f_curraddrmurderindex_i > 192.5) => -0.0685010093,
         (f_curraddrmurderindex_i = NULL) => 0.0301293686, 0.0301293686),
      (c_high_ed > 32.75) => -0.0116564781,
      (c_high_ed = NULL) => 0.0096105073, 0.0096105073),
   (f_inq_Collection_count24_i > 2.5) => 0.0951247149,
   (f_inq_Collection_count24_i = NULL) => 0.0095100006, 0.0124482932),
(c_sub_bus = NULL) => 0.0040214808, -0.0019875011);

// Tree: 53 
woFDN_FL__S__lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 134.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 47.65) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 17448.5) => -0.0573515084,
         (f_curraddrmedianincome_d > 17448.5) => 0.1053206711,
         (f_curraddrmedianincome_d = NULL) => 0.0708786787, 0.0708786787),
      (c_civ_emp > 47.65) => 0.0021996407,
      (c_civ_emp = NULL) => 0.0106098779, 0.0106098779),
   (k_estimated_income_d > 32500) => -0.0267556919,
   (k_estimated_income_d = NULL) => -0.0342865230, -0.0152748898),
(c_easiqlife > 134.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 0.1136485129,
   (f_attr_arrest_recency_d > 99.5) => 0.0179024718,
   (f_attr_arrest_recency_d = NULL) => 0.0192557727, 0.0192557727),
(c_easiqlife = NULL) => 0.0026752933, -0.0031855675);

// Tree: 54 
woFDN_FL__S__lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1482849192,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 38.3) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 20.05) => 
         map(
         (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.0138476578,
         (f_property_owners_ct_d > 0.5) => -0.0177432378,
         (f_property_owners_ct_d = NULL) => -0.0076807741, -0.0076807741),
      (c_hval_500k_p > 20.05) => 
         map(
         (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 0.1861633308,
         (r_I61_inq_collection_recency_d > 9) => 0.0252869282,
         (r_I61_inq_collection_recency_d = NULL) => 0.0331031864, 0.0331031864),
      (c_hval_500k_p = NULL) => -0.0022070044, -0.0022070044),
   (c_hval_60k_p > 38.3) => -0.1048261465,
   (c_hval_60k_p = NULL) => -0.0220635072, -0.0034252681),
(f_attr_arrest_recency_d = NULL) => 0.0123674573, -0.0026903285);

// Tree: 55 
woFDN_FL__S__lgt_55 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 2.5) => 
      map(
      (NULL < r_nas_lname_verd_d and r_nas_lname_verd_d <= 0.5) => 0.1831961664,
      (r_nas_lname_verd_d > 0.5) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0976949298,
         (r_D33_Eviction_Recency_d > 30) => 0.0076840360,
         (r_D33_Eviction_Recency_d = NULL) => 0.0088958029, 0.0088958029),
      (r_nas_lname_verd_d = NULL) => 0.0112912656, 0.0112912656),
   (f_inq_Banking_count24_i > 2.5) => 
      map(
      (NULL < c_families and c_families <= 405.5) => 0.1958889289,
      (c_families > 405.5) => 0.0093912163,
      (c_families = NULL) => 0.0992492051, 0.0992492051),
   (f_inq_Banking_count24_i = NULL) => 0.0135665560, 0.0135665560),
(k_estimated_income_d > 34500) => -0.0177237373,
(k_estimated_income_d = NULL) => 0.0039705885, -0.0066083561);

// Tree: 56 
woFDN_FL__S__lgt_56 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0825891087) => 0.0125686617,
   (f_add_curr_nhood_VAC_pct_i > 0.0825891087) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 2.25) => 0.1797026125,
      (c_pop_65_74_p > 2.25) => 
         map(
         (NULL < c_health and c_health <= 0.6) => 0.1325794213,
         (c_health > 0.6) => -0.0018215861,
         (c_health = NULL) => 0.0384620946, 0.0384620946),
      (c_pop_65_74_p = NULL) => 0.0580235747, 0.0580235747),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0199570317, 0.0199570317),
(f_hh_members_ct_d > 1.5) => -0.0063117013,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 17.4) => -0.0413063037,
   (C_INC_75K_P > 17.4) => 0.0686990374,
   (C_INC_75K_P = NULL) => 0.0093156232, 0.0093156232), -0.0007224591);

// Tree: 57 
woFDN_FL__S__lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0002781983,
      (f_rel_felony_count_i > 0.5) => 0.0456687882,
      (f_rel_felony_count_i = NULL) => 0.0045990262, 0.0045990262),
   (f_dl_addrs_per_adl_i > 0.5) => -0.0226965718,
   (f_dl_addrs_per_adl_i = NULL) => -0.0060697893, -0.0060697893),
(r_D30_Derog_Count_i > 11.5) => 
   map(
   (NULL < c_employees and c_employees <= 216.5) => 0.1326652433,
   (c_employees > 216.5) => 0.0030683174,
   (c_employees = NULL) => 0.0581470109, 0.0581470109),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 69.25) => -0.0667415431,
   (C_OWNOCC_P > 69.25) => 0.0413985253,
   (C_OWNOCC_P = NULL) => -0.0065733847, -0.0065733847), -0.0052601388);

// Tree: 58 
woFDN_FL__S__lgt_58 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 62.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.6) => 0.2027457319,
   (r_C12_source_profile_d > 60.6) => -0.0332726874,
   (r_C12_source_profile_d = NULL) => 0.0740084122, 0.0740084122),
(f_mos_liens_unrel_SC_fseen_d > 62.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 55.5) => -0.0117110701,
   (k_comb_age_d > 55.5) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
         map(
         (NULL < c_murders and c_murders <= 150.5) => 0.0069328695,
         (c_murders > 150.5) => 0.0912373966,
         (c_murders = NULL) => -0.0849930549, 0.0163130676),
      (f_srchfraudsrchcountmo_i > 0.5) => 0.1603368076,
      (f_srchfraudsrchcountmo_i = NULL) => 0.0193641989, 0.0193641989),
   (k_comb_age_d = NULL) => -0.0047339156, -0.0047339156),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0106157147, -0.0036291207);

// Tree: 59 
woFDN_FL__S__lgt_59 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0361363441,
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 0.0955119768,
      (r_C10_M_Hdr_FS_d > 10.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 80.5) => -0.0020331791,
         (k_comb_age_d > 80.5) => 0.0941730229,
         (k_comb_age_d = NULL) => -0.0006628273, -0.0006628273),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0227460917, 0.0001567658),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 89.5) => 0.2596096620,
      (c_mort_indx > 89.5) => 0.0211584770,
      (c_mort_indx = NULL) => 0.1344227899, 0.1344227899),
   (f_nae_nothing_found_i = NULL) => 0.0016896288, 0.0016896288),
(f_addrs_per_ssn_i = NULL) => -0.0047931197, -0.0047931197);

// Tree: 60 
woFDN_FL__S__lgt_60 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 19.85) => 0.0142774850,
   (c_hh1_p > 19.85) => -0.0170701038,
   (c_hh1_p = NULL) => 0.0007698338, -0.0047881242),
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.25) => -0.0003862236,
   (c_bigapt_p > 1.25) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0406369951,
      (f_rel_felony_count_i > 0.5) => 0.1542711545,
      (f_rel_felony_count_i = NULL) => 0.0635067630, 0.0635067630),
   (c_bigapt_p = NULL) => 0.0271697932, 0.0271697932),
(f_hh_collections_ct_i = NULL) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 11.75) => 0.0467801817,
   (C_INC_50K_P > 11.75) => -0.0745078486,
   (C_INC_50K_P = NULL) => -0.0082580842, -0.0082580842), -0.0019777013);

// Tree: 61 
woFDN_FL__S__lgt_61 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 2.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 28.5) => -0.0220799476,
      (f_fp_prevaddrburglaryindex_i > 28.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 4.95) => 0.0161301418,
         (c_incollege > 4.95) => 
            map(
            (NULL < c_professional and c_professional <= 7.65) => 0.1403621450,
            (c_professional > 7.65) => 0.0161778049,
            (c_professional = NULL) => 0.0993011939, 0.0993011939),
         (c_incollege = NULL) => 0.0666850950, 0.0666850950),
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0475507937, 0.0475507937),
   (f_historical_count_d > 2.5) => -0.0256768746,
   (f_historical_count_d = NULL) => 0.0241586219, 0.0241586219),
(r_I60_inq_comm_recency_d > 549) => -0.0042252536,
(r_I60_inq_comm_recency_d = NULL) => -0.0227443829, -0.0018183568);

// Tree: 62 
woFDN_FL__S__lgt_62 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 438.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 38) => 
      map(
      (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 0.0004866813,
      (f_assoccredbureaucountnew_i > 0.5) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 84.5) => 0.1471860685,
         (c_new_homes > 84.5) => 0.0136550348,
         (c_new_homes = NULL) => 0.0669575462, 0.0669575462),
      (f_assoccredbureaucountnew_i = NULL) => 0.0018266863, 0.0018266863),
   (c_hval_80k_p > 38) => -0.0834080584,
   (c_hval_80k_p = NULL) => -0.0055963589, 0.0006407788),
(f_prevaddrlenofres_d > 438.5) => 0.1841077476,
(f_prevaddrlenofres_d = NULL) => 
   map(
   (NULL < c_work_home and c_work_home <= 134) => 0.0792845870,
   (c_work_home > 134) => -0.0364786298,
   (c_work_home = NULL) => 0.0269394803, 0.0269394803), 0.0016932895);

// Tree: 63 
woFDN_FL__S__lgt_63 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 20.55) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
      map(
      (NULL < r_nas_fname_verd_d and r_nas_fname_verd_d <= 0.5) => 0.1924249033,
      (r_nas_fname_verd_d > 0.5) => 0.0009565518,
      (r_nas_fname_verd_d = NULL) => 0.0019307745, 0.0019307745),
   (r_D32_felony_count_i > 0.5) => 0.0665911548,
   (r_D32_felony_count_i = NULL) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 94) => -0.0774156462,
      (c_no_teens > 94) => 0.0541343864,
      (c_no_teens = NULL) => -0.0039668780, -0.0039668780), 0.0025971085),
(c_hval_80k_p > 20.55) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 23.5) => 0.0656234568,
   (k_comb_age_d > 23.5) => -0.0622033856,
   (k_comb_age_d = NULL) => -0.0456528027, -0.0456528027),
(c_hval_80k_p = NULL) => 0.0188528058, 0.0002061780);

// Tree: 64 
woFDN_FL__S__lgt_64 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0711768597,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 38) => -0.0247992524,
   (f_curraddrcartheftindex_i > 38) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.23903401545) => 0.0063710083,
         (f_add_curr_nhood_MFD_pct_i > 0.23903401545) => 0.0882843814,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0461051072, 0.0461051072),
      (r_D32_Mos_Since_Crim_LS_d > 10.5) => 0.0037749529,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0045110474, 0.0045110474),
   (f_curraddrcartheftindex_i = NULL) => -0.0037183016, -0.0037183016),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 64) => 0.0602130318,
   (c_cartheft > 64) => -0.0468761522,
   (c_cartheft = NULL) => -0.0064202382, -0.0064202382), -0.0033228043);

// Tree: 65 
woFDN_FL__S__lgt_65 := map(
(NULL < c_hh4_p and c_hh4_p <= 12.35) => 
   map(
   (NULL < r_C20_email_domain_ISP_count_i and r_C20_email_domain_ISP_count_i <= 4.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 160.5) => -0.0199997051,
      (c_lar_fam > 160.5) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 27.75) => 
            map(
            (NULL < c_construction and c_construction <= 10.25) => -0.0545939462,
            (c_construction > 10.25) => 0.1267611362,
            (c_construction = NULL) => 0.0184404535, 0.0184404535),
         (c_hh1_p > 27.75) => 0.1710130453,
         (c_hh1_p = NULL) => 0.0574825982, 0.0574825982),
      (c_lar_fam = NULL) => -0.0155060039, -0.0155060039),
   (r_C20_email_domain_ISP_count_i > 4.5) => 0.1188146377,
   (r_C20_email_domain_ISP_count_i = NULL) => 0.0329236638, -0.0130814065),
(c_hh4_p > 12.35) => 0.0157388201,
(c_hh4_p = NULL) => 0.0029078149, 0.0034783209);

// Tree: 66 
woFDN_FL__S__lgt_66 := map(
(NULL < c_easiqlife and c_easiqlife <= 134.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 7.5) => 
      map(
      (NULL < c_finance and c_finance <= 0.35) => 0.0108437023,
      (c_finance > 0.35) => -0.0235150729,
      (c_finance = NULL) => -0.0122368336, -0.0122368336),
   (f_hh_age_18_plus_d > 7.5) => 0.0870433581,
   (f_hh_age_18_plus_d = NULL) => -0.0111469009, -0.0106525703),
(c_easiqlife > 134.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 0.0117883366,
      (f_nae_nothing_found_i > 0.5) => 0.1572759249,
      (f_nae_nothing_found_i = NULL) => 0.0136022256, 0.0136022256),
   (k_comb_age_d > 81.5) => 0.1626163235,
   (k_comb_age_d = NULL) => 0.0155055640, 0.0155055640),
(c_easiqlife = NULL) => -0.0075358436, -0.0016095192);

// Tree: 67 
woFDN_FL__S__lgt_67 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0284725876,
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 19.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 5.8) => -0.0056435980,
      (c_rnt1000_p > 5.8) => 0.1952604990,
      (c_rnt1000_p = NULL) => 0.1173906939, 0.1173906939),
   (k_comb_age_d > 19.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 241.75) => -0.0023689224,
      (c_housingcpi > 241.75) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 0.0259675994,
         (k_comb_age_d > 70.5) => 0.1405002794,
         (k_comb_age_d = NULL) => 0.0305722955, 0.0305722955),
      (c_housingcpi = NULL) => -0.0014648265, 0.0026670967),
   (k_comb_age_d = NULL) => 0.0326541280, 0.0043150651),
(f_addrs_per_ssn_i = NULL) => -0.0013507240, -0.0013507240);

// Tree: 68 
woFDN_FL__S__lgt_68 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 307.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.38394986375) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 0.0786052128,
      (f_mos_liens_unrel_SC_fseen_d > 87.5) => -0.0013328310,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0000272378, 0.0000272378),
   (f_add_curr_mobility_index_i > 0.38394986375) => -0.0315744859,
   (f_add_curr_mobility_index_i = NULL) => 0.0704948686, -0.0039947751),
(r_C13_max_lres_d > 307.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 50.85) => 0.0305558226,
   (c_hval_750k_p > 50.85) => 0.2724059366,
   (c_hval_750k_p = NULL) => 0.0394473709, 0.0394473709),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_highrent and c_highrent <= 0.15) => 0.0368138666,
   (c_highrent > 0.15) => -0.0780363629,
   (c_highrent = NULL) => -0.0233030504, -0.0233030504), 0.0005661393);

// Tree: 69 
woFDN_FL__S__lgt_69 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => -0.0063693183,
      (k_inq_per_ssn_i > 10.5) => 0.0679214983,
      (k_inq_per_ssn_i = NULL) => -0.0056333476, -0.0056333476),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 84.1) => 0.0107478073,
      (c_sfdu_p > 84.1) => 0.2387710321,
      (c_sfdu_p = NULL) => 0.0843950600, 0.0843950600),
   (f_nae_nothing_found_i = NULL) => -0.0044715511, -0.0044715511),
(f_srchssnsrchcount_i > 22.5) => 0.0712968860,
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < C_INC_201K_P and C_INC_201K_P <= 2.75) => -0.0880038275,
   (C_INC_201K_P > 2.75) => 0.0252859612,
   (C_INC_201K_P = NULL) => -0.0249635419, -0.0249635419), -0.0042020983);

// Tree: 70 
woFDN_FL__S__lgt_70 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 169.5) => -0.0075157070,
(r_pb_order_freq_d > 169.5) => -0.0291333900,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1452539836,
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.0019079100,
      (f_assocrisktype_i > 7.5) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 38.85) => 0.0299427813,
         (c_hh1_p > 38.85) => 0.1399183158,
         (c_hh1_p = NULL) => 0.0468121848, 0.0468121848),
      (f_assocrisktype_i = NULL) => 0.0052773916, 0.0052773916),
   (f_hh_age_18_plus_d = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 129) => -0.0389758690,
      (c_asian_lang > 129) => 0.0744119107,
      (c_asian_lang = NULL) => 0.0063792429, 0.0063792429), 0.0078493535), -0.0047880717);

// Tree: 71 
woFDN_FL__S__lgt_71 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 11.25) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 1.25) => 0.0161850265,
      (c_hh7p_p > 1.25) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 31.5) => 0.0069220394,
         (c_born_usa > 31.5) => 0.0944807533,
         (c_born_usa = NULL) => 0.0609577316, 0.0609577316),
      (c_hh7p_p = NULL) => 0.0302979954, 0.0302979954),
   (c_hval_125k_p > 11.25) => -0.0092313207,
   (c_hval_125k_p = NULL) => -0.0123557901, 0.0167334882),
(k_estimated_income_d > 34500) => -0.0062415540,
(k_estimated_income_d = NULL) => 
   map(
   (NULL < c_mort_indx and c_mort_indx <= 107) => -0.0641167438,
   (c_mort_indx > 107) => 0.0603300494,
   (c_mort_indx = NULL) => -0.0123468778, -0.0123468778), 0.0017127188);

// Tree: 72 
woFDN_FL__S__lgt_72 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 59.2) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 105.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0166827728,
      (f_hh_collections_ct_i > 2.5) => 0.0311508715,
      (f_hh_collections_ct_i = NULL) => -0.0124733630, -0.0124733630),
   (r_C13_Curr_Addr_LRes_d > 105.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 11.5) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 13.85) => 0.0111932289,
         (c_rnt750_p > 13.85) => 0.2304238673,
         (c_rnt750_p = NULL) => 0.1286382138, 0.1286382138),
      (c_many_cars > 11.5) => 0.0111779118,
      (c_many_cars = NULL) => 0.0141987048, 0.0141987048),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0055342685, -0.0028116483),
(c_famotf18_p > 59.2) => -0.0787608038,
(c_famotf18_p = NULL) => 0.0027753039, -0.0031255658);

// Tree: 73 
woFDN_FL__S__lgt_73 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 48.5) => -0.0670612545,
   (f_mos_inq_banko_am_lseen_d > 48.5) => 
      map(
      (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 0.0091839086,
      (r_E55_College_Ind_d > 0.5) => -0.0258585531,
      (r_E55_College_Ind_d = NULL) => 0.0021256276, 0.0021256276),
   (f_mos_inq_banko_am_lseen_d = NULL) => -0.0003821531, -0.0003821531),
(f_inq_PrepaidCards_count_i > 1.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1019.5) => 0.1122933437,
   (c_popover25 > 1019.5) => -0.0053209647,
   (c_popover25 = NULL) => 0.0516767386, 0.0516767386),
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.65) => -0.0525483694,
   (c_pop_55_64_p > 12.65) => 0.0651991102,
   (c_pop_55_64_p = NULL) => -0.0073970802, -0.0073970802), 0.0000925699);

// Tree: 74 
woFDN_FL__S__lgt_74 := map(
(NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 1.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 231.75) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 335.5) => -0.0083748387,
         (r_pb_order_freq_d > 335.5) => 0.0523005041,
         (r_pb_order_freq_d = NULL) => 0.0396047150, 0.0151323596),
      (f_hh_members_ct_d > 1.5) => -0.0089306593,
      (f_hh_members_ct_d = NULL) => -0.0040403877, -0.0040403877),
   (c_newhouse > 231.75) => -0.0900728325,
   (c_newhouse = NULL) => 0.0395309909, -0.0039579809),
(f_vardobcountnew_i > 1.5) => 0.0973501977,
(f_vardobcountnew_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 3.65) => 0.0773053813,
   (c_hval_125k_p > 3.65) => -0.0151817178,
   (c_hval_125k_p = NULL) => 0.0249971039, 0.0249971039), -0.0028934015);

// Tree: 75 
woFDN_FL__S__lgt_75 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 32.5) => -0.0200334465,
(k_comb_age_d > 32.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 5.85) => 
      map(
      (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 
         map(
         (NULL < c_families and c_families <= 170.5) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 85.5) => 0.2733984515,
            (f_prevaddrlenofres_d > 85.5) => -0.0013085355,
            (f_prevaddrlenofres_d = NULL) => 0.1336352476, 0.1336352476),
         (c_families > 170.5) => 0.0163748251,
         (c_families = NULL) => 0.0425859784, 0.0425859784),
      (f_prevaddroccupantowned_i > 0.5) => 0.2629544284,
      (f_prevaddroccupantowned_i = NULL) => 0.0629759417, 0.0629759417),
   (c_hh3_p > 5.85) => 0.0024981080,
   (c_hh3_p = NULL) => -0.0160925914, 0.0061278990),
(k_comb_age_d = NULL) => -0.0181542479, -0.0030285501);

// Tree: 76 
woFDN_FL__S__lgt_76 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 33.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 21.5) => -0.0051423069,
      (f_rel_homeover300_count_d > 21.5) => 0.1305186470,
      (f_rel_homeover300_count_d = NULL) => -0.0042899012, -0.0042899012),
   (f_rel_educationover12_count_d > 33.5) => -0.0892428775,
   (f_rel_educationover12_count_d = NULL) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 24.15) => 0.0041196659,
      (c_hh3_p > 24.15) => 0.1586141027,
      (c_hh3_p = NULL) => 0.0288970756, 0.0288970756), -0.0042028822),
(r_S66_adlperssn_count_i > 3.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 8.05) => 0.1711012139,
   (c_pop_35_44_p > 8.05) => 0.0283962002,
   (c_pop_35_44_p = NULL) => 0.0417091065, 0.0417091065),
(r_S66_adlperssn_count_i = NULL) => -0.0019371427, -0.0019371427);

// Tree: 77 
woFDN_FL__S__lgt_77 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0146920209,
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 128) => 0.1940916813,
      (c_asian_lang > 128) => 0.0113808318,
      (c_asian_lang = NULL) => 0.0785539383, 0.0785539383),
   (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 
      map(
      (NULL < c_transport and c_transport <= 31.75) => 0.0083332720,
      (c_transport > 31.75) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 111.5) => -0.0206435366,
         (c_sub_bus > 111.5) => 0.2149857811,
         (c_sub_bus = NULL) => 0.1048786233, 0.1048786233),
      (c_transport = NULL) => 0.0363150570, 0.0102355665),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0115804930, 0.0115804930),
(f_util_add_curr_conv_n = NULL) => -0.0001732726, -0.0001732726);

// Tree: 78 
woFDN_FL__S__lgt_78 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 27.5) => 
      map(
      (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 0.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 27.5) => 0.0766879471,
         (r_C13_max_lres_d > 27.5) => -0.0496333295,
         (r_C13_max_lres_d = NULL) => 0.0044467059, 0.0044467059),
      (k_inq_addrs_per_ssn_i > 0.5) => 0.1780323038,
      (k_inq_addrs_per_ssn_i = NULL) => 0.0445377285, 0.0445377285),
   (r_C10_M_Hdr_FS_d > 27.5) => -0.0006554217,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0008764857, 0.0008764857),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0553328135,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 7.35) => -0.0367145505,
   (c_rnt500_p > 7.35) => 0.0709925314,
   (c_rnt500_p = NULL) => 0.0140170461, 0.0140170461), -0.0013515179);

// Tree: 79 
woFDN_FL__S__lgt_79 := map(
(NULL < c_unattach and c_unattach <= 85.5) => -0.0218937511,
(c_unattach > 85.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 0.0006602617,
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.68242835595) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 6.35) => 0.0149508259,
         (c_bigapt_p > 6.35) => 0.0949152728,
         (c_bigapt_p = NULL) => 0.0448495560, 0.0448495560),
      (f_add_curr_nhood_MFD_pct_i > 0.68242835595) => -0.0314312520,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 57) => -0.0188424806,
         (f_curraddrcartheftindex_i > 57) => 0.1621358904,
         (f_curraddrcartheftindex_i = NULL) => 0.0744309875, 0.0744309875), 0.0349915952),
   (k_inq_per_ssn_i = NULL) => 0.0049543839, 0.0049543839),
(c_unattach = NULL) => 0.0112772902, -0.0042890925);

// Tree: 80 
woFDN_FL__S__lgt_80 := map(
(NULL < c_med_rent and c_med_rent <= 1523.5) => -0.0035099873,
(c_med_rent > 1523.5) => 
   map(
   (NULL < c_armforce and c_armforce <= 138.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 215) => 0.0202511582,
      (f_M_Bureau_ADL_FS_all_d > 215) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 252240.5) => -0.0455731361,
         (r_A46_Curr_AVM_AutoVal_d > 252240.5) => 0.1317611820,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.2578286102, 0.1281960168),
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0767146227, 0.0767146227),
   (c_armforce > 138.5) => -0.0703593015,
   (c_armforce = NULL) => 0.0530777420, 0.0530777420),
(c_med_rent = NULL) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => -0.0099092417,
   (f_srchfraudsrchcountyr_i > 0.5) => 0.1446848278,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0143042872, 0.0143042872), 0.0014543473);

// Tree: 81 
woFDN_FL__S__lgt_81 := map(
(NULL < c_easiqlife and c_easiqlife <= 119.5) => -0.0157790338,
(c_easiqlife > 119.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 121.5) => -0.0037976872,
   (r_C13_Curr_Addr_LRes_d > 121.5) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 26.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 58212) => 0.0173881579,
         (r_A49_Curr_AVM_Chg_1yr_i > 58212) => 
            map(
            (NULL < c_popover25 and c_popover25 <= 1347.5) => 0.2550117180,
            (c_popover25 > 1347.5) => -0.0355217381,
            (c_popover25 = NULL) => 0.1428522908, 0.1428522908),
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0036563801, 0.0313442594),
      (f_rel_educationover8_count_d > 26.5) => 0.1931368646,
      (f_rel_educationover8_count_d = NULL) => 0.0381893312, 0.0381893312),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0080125731, 0.0080125731),
(c_easiqlife = NULL) => 0.0352048338, -0.0040092512);

// Tree: 82 
woFDN_FL__S__lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 18.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0074280944,
      (r_C13_Curr_Addr_LRes_d > 158.5) => 0.0249516342,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0001744490, -0.0001744490),
   (f_srchssnsrchcount_i > 18.5) => 0.0982073574,
   (f_srchssnsrchcount_i = NULL) => 0.0002371572, 0.0002371572),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => -0.1235523898,
   (f_mos_inq_banko_cm_lseen_d > 27.5) => -0.0124726235,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0631249969, -0.0631249969),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 66) => 0.0778600059,
   (c_larceny > 66) => -0.0284780643,
   (c_larceny = NULL) => 0.0130602443, 0.0130602443), -0.0002547974);

// Tree: 83 
woFDN_FL__S__lgt_83 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 9) => 0.0863806691,
(r_I60_inq_PrepaidCards_recency_d > 9) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 50.85) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 0.5) => -0.0029987183,
      (f_addrs_per_ssn_c6_i > 0.5) => 
         map(
         (NULL < C_INC_15K_P and C_INC_15K_P <= 10.45) => -0.0123191481,
         (C_INC_15K_P > 10.45) => 0.0844947456,
         (C_INC_15K_P = NULL) => 0.0240882256, 0.0240882256),
      (f_addrs_per_ssn_c6_i = NULL) => -0.0000811116, -0.0000811116),
   (c_hval_500k_p > 50.85) => 0.1090443348,
   (c_hval_500k_p = NULL) => -0.0106884432, 0.0003694321),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 3.65) => -0.0479577360,
   (c_rnt500_p > 3.65) => 0.0489561796,
   (c_rnt500_p = NULL) => 0.0011914641, 0.0011914641), 0.0007177263);

// Tree: 84 
woFDN_FL__S__lgt_84 := map(
(NULL < c_low_ed and c_low_ed <= 77.45) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 7.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 193.5) => 0.0002221923,
      (c_span_lang > 193.5) => 0.0615194004,
      (c_span_lang = NULL) => 0.0015423119, 0.0015423119),
   (f_hh_tot_derog_i > 7.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 36.45) => -0.0154835479,
      (c_med_age > 36.45) => 0.1655855098,
      (c_med_age = NULL) => 0.0776879090, 0.0776879090),
   (f_hh_tot_derog_i = NULL) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 103.35) => 0.0600236680,
      (c_oldhouse > 103.35) => -0.0536067958,
      (c_oldhouse = NULL) => 0.0176242412, 0.0176242412), 0.0023733297),
(c_low_ed > 77.45) => -0.0486970453,
(c_low_ed = NULL) => -0.0032973785, 0.0008175768);

// Tree: 85 
woFDN_FL__S__lgt_85 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 41.55) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 16.5) => 
      map(
      (NULL < r_nas_lname_verd_d and r_nas_lname_verd_d <= 0.5) => 0.1111708246,
      (r_nas_lname_verd_d > 0.5) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 5.05) => -0.0126448212,
         (c_femdiv_p > 5.05) => 0.0126082956,
         (c_femdiv_p = NULL) => -0.0027949878, -0.0027949878),
      (r_nas_lname_verd_d = NULL) => -0.0021890385, -0.0021890385),
   (f_inq_count24_i > 16.5) => -0.0972777680,
   (f_inq_count24_i = NULL) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 62.65) => -0.0759328514,
      (C_OWNOCC_P > 62.65) => 0.0377286910,
      (C_OWNOCC_P = NULL) => -0.0095545107, -0.0095545107), -0.0028547867),
(c_hval_80k_p > 41.55) => -0.0907589935,
(c_hval_80k_p = NULL) => 0.0074805341, -0.0034044419);

// Tree: 86 
woFDN_FL__S__lgt_86 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 14.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 218.4) => -0.0059535683,
   (c_cpiall > 218.4) => 0.0226347143,
   (c_cpiall = NULL) => -0.0153854524, 0.0001573197),
(f_rel_homeover300_count_d > 14.5) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 107.5) => -0.1045494522,
   (c_lux_prod > 107.5) => -0.0209717176,
   (c_lux_prod = NULL) => -0.0479465420, -0.0479465420),
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.7261866328) => -0.0316883040,
   (f_add_curr_nhood_SFD_pct_d > 0.7261866328) => 0.1105472947,
   (f_add_curr_nhood_SFD_pct_d = NULL) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 11.7) => -0.0779567315,
      (c_pop_25_34_p > 11.7) => 0.0282835645,
      (c_pop_25_34_p = NULL) => -0.0174814861, -0.0174814861), 0.0027561253), -0.0012075983);

// Tree: 87 
woFDN_FL__S__lgt_87 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 25.75) => -0.0082836750,
(c_famotf18_p > 25.75) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 32.55) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 0.0303240158,
      (f_historical_count_d > 1.5) => -0.0472760622,
      (f_historical_count_d = NULL) => 0.0011632350, 0.0011632350),
   (c_rnt1000_p > 32.55) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 109.5) => 
         map(
         (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 0.0650920292,
         (f_hh_lienholders_i > 0.5) => 0.1878047371,
         (f_hh_lienholders_i = NULL) => 0.1232527397, 0.1232527397),
      (c_relig_indx > 109.5) => 0.0062471743,
      (c_relig_indx = NULL) => 0.0804271733, 0.0804271733),
   (c_rnt1000_p = NULL) => 0.0202015121, 0.0202015121),
(c_famotf18_p = NULL) => -0.0005334186, -0.0052462329);

// Tree: 88 
woFDN_FL__S__lgt_88 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0047046563,
(k_inq_per_ssn_i > 1.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 3.5) => -0.0982335964,
   (f_mos_inq_banko_cm_lseen_d > 3.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 20.95) => -0.0049332397,
      (C_RENTOCC_P > 20.95) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 11.6) => -0.0611313108,
         (C_OWNOCC_P > 11.6) => 
            map(
            (NULL < c_unemp and c_unemp <= 8.75) => 0.0482297961,
            (c_unemp > 8.75) => 0.1177804063,
            (c_unemp = NULL) => 0.0531938428, 0.0531938428),
         (C_OWNOCC_P = NULL) => 0.0427200796, 0.0427200796),
      (C_RENTOCC_P = NULL) => 0.0218788380, 0.0218788380),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0194812002, 0.0194812002),
(k_inq_per_ssn_i = NULL) => 0.0002678872, 0.0002678872);

// Tree: 89 
woFDN_FL__S__lgt_89 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 20.15) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 7.5) => 0.0173159053,
      (f_rel_homeover500_count_d > 7.5) => 0.1136064326,
      (f_rel_homeover500_count_d = NULL) => 0.0210516146, 0.0210516146),
   (r_C14_addrs_10yr_i > 0.5) => -0.0060522409,
   (r_C14_addrs_10yr_i = NULL) => 0.0077073504, 0.0006322033),
(c_hval_80k_p > 20.15) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 51.7) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 26044.5) => 0.1237454041,
      (f_prevaddrmedianincome_d > 26044.5) => -0.0157880499,
      (f_prevaddrmedianincome_d = NULL) => 0.0183201277, 0.0183201277),
   (c_civ_emp > 51.7) => -0.0716200135,
   (c_civ_emp = NULL) => -0.0447563134, -0.0447563134),
(c_hval_80k_p = NULL) => 0.0110681023, -0.0018132140);

// Tree: 90 
woFDN_FL__S__lgt_90 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.0844625620,
   (r_D32_Mos_Since_Fel_LS_d > 117) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0034369406,
      (f_curraddrcrimeindex_i > 189) => 
         map(
         (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 0.5) => 0.0852821665,
         (r_C20_email_domain_free_count_i > 0.5) => -0.0427316876,
         (r_C20_email_domain_free_count_i = NULL) => 0.0286136133, 0.0286136133),
      (f_curraddrcrimeindex_i = NULL) => -0.0026281425, -0.0026281425),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0021686712, -0.0021686712),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0816801335,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 283) => -0.0682390474,
   (c_employees > 283) => 0.0360788741,
   (c_employees = NULL) => -0.0236587391, -0.0236587391), -0.0027121412);

// Tree: 91 
woFDN_FL__S__lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < r_C20_email_count_i and r_C20_email_count_i <= 1.5) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 93.15) => -0.0670638709,
      (c_occunit_p > 93.15) => 0.0975318514,
      (c_occunit_p = NULL) => 0.0056325731, 0.0056325731),
   (r_C20_email_count_i > 1.5) => 0.2019319010,
   (r_C20_email_count_i = NULL) => 0.0878913391, 0.0878913391),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0061865031,
   (r_D33_eviction_count_i > 3.5) => 0.0621620343,
   (r_D33_eviction_count_i = NULL) => -0.0057212456, -0.0057212456),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 2.45) => 0.0356606683,
   (c_bigapt_p > 2.45) => -0.0638310365,
   (c_bigapt_p = NULL) => -0.0027793086, -0.0027793086), -0.0041401810);

// Tree: 92 
woFDN_FL__S__lgt_92 := map(
(NULL < c_rich_blk and c_rich_blk <= 181.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0789008950,
   (r_D33_Eviction_Recency_d > 30) => -0.0040065368,
   (r_D33_Eviction_Recency_d = NULL) => -0.0185689139, -0.0034695926),
(c_rich_blk > 181.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 18.95) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
         map(
         (NULL < r_C20_email_count_i and r_C20_email_count_i <= 0.5) => 0.2018447258,
         (r_C20_email_count_i > 0.5) => 0.0570335343,
         (r_C20_email_count_i = NULL) => 0.1349151835, 0.1349151835),
      (f_current_count_d > 0.5) => -0.0324713242,
      (f_current_count_d = NULL) => 0.0769737000, 0.0769737000),
   (c_fammar18_p > 18.95) => 0.0179309711,
   (c_fammar18_p = NULL) => 0.0244527297, 0.0244527297),
(c_rich_blk = NULL) => -0.0166986575, -0.0000526901);

// Tree: 93 
woFDN_FL__S__lgt_93 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0053615895,
(f_hh_collections_ct_i > 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 6.45) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 4.5) => 0.0299717029,
      (f_inq_QuizProvider_count_i > 4.5) => 0.1951049632,
      (f_inq_QuizProvider_count_i = NULL) => 0.0336750591, 0.0336750591),
   (c_unemp > 6.45) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 5.5) => 
         map(
         (NULL < c_retail and c_retail <= 12.55) => -0.0261440182,
         (c_retail > 12.55) => 0.0960139957,
         (c_retail = NULL) => 0.0191386939, 0.0191386939),
      (f_corrssnnamecount_d > 5.5) => -0.0759194731,
      (f_corrssnnamecount_d = NULL) => -0.0242315948, -0.0242315948),
   (c_unemp = NULL) => 0.0459848647, 0.0231481712),
(f_hh_collections_ct_i = NULL) => 0.0064596104, 0.0024644868);

// Tree: 94 
woFDN_FL__S__lgt_94 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 28.5) => -0.1041042042,
(f_mos_liens_unrel_OT_fseen_d > 28.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 232.5) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 0.95) => 0.0082248992,
         (c_bigapt_p > 0.95) => 0.0778591899,
         (c_bigapt_p = NULL) => 0.0424471787, 0.0424471787),
      (f_M_Bureau_ADL_FS_noTU_d > 232.5) => 
         map(
         (NULL < c_info and c_info <= 2.55) => -0.0199116490,
         (c_info > 2.55) => 0.1500831287,
         (c_info = NULL) => -0.0044240554, -0.0044240554),
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0200427288, 0.0200427288),
   (f_mos_inq_banko_cm_lseen_d > 44.5) => -0.0015059474,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0019526316, 0.0019526316),
(f_mos_liens_unrel_OT_fseen_d = NULL) => -0.0047181534, 0.0012080403);

// Tree: 95 
woFDN_FL__S__lgt_95 := map(
(NULL < c_incollege and c_incollege <= 5.95) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 5.5) => -0.0128089815,
   (f_srchfraudsrchcountyr_i > 5.5) => -0.1237613033,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0546971827, -0.0143019494),
(c_incollege > 5.95) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 4.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0066894279,
      (f_rel_criminal_count_i > 2.5) => 
         map(
         (NULL < c_armforce and c_armforce <= 143.5) => 0.0499838322,
         (c_armforce > 143.5) => -0.0463033975,
         (c_armforce = NULL) => 0.0348351948, 0.0348351948),
      (f_rel_criminal_count_i = NULL) => 0.0034353356, 0.0034353356),
   (f_inq_HighRiskCredit_count24_i > 4.5) => 0.0856811434,
   (f_inq_HighRiskCredit_count24_i = NULL) => 0.0051523587, 0.0045226909),
(c_incollege = NULL) => 0.0079276963, -0.0050574345);

// Tree: 96 
woFDN_FL__S__lgt_96 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 0.35) => 0.0791398212,
   (C_INC_125K_P > 0.35) => -0.0064808885,
   (C_INC_125K_P = NULL) => -0.0287505859, -0.0061764344),
(f_srchcomponentrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 13.5) => 
      map(
      (NULL < c_larceny and c_larceny <= 99.5) => -0.0477652444,
      (c_larceny > 99.5) => 0.0673149017,
      (c_larceny = NULL) => 0.0017725669, 0.0017725669),
   (f_rel_educationover12_count_d > 13.5) => 0.1221081762,
   (f_rel_educationover12_count_d = NULL) => 0.0319296660, 0.0319296660),
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 78.6) => -0.0585300179,
   (c_oldhouse > 78.6) => 0.0721784338,
   (c_oldhouse = NULL) => 0.0184765118, 0.0184765118), -0.0046642122);

// Tree: 97 
woFDN_FL__S__lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0037216776,
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 9.5) => -0.0388941382,
      (f_rel_count_i > 9.5) => 0.1006905836,
      (f_rel_count_i = NULL) => 0.0471000208, 0.0471000208),
   (f_assoccredbureaucountnew_i = NULL) => -0.0028056766, -0.0028056766),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1484276280,
   (r_A50_pb_average_dollars_d > 99) => -0.0204251608,
   (r_A50_pb_average_dollars_d = NULL) => 0.0558309373, 0.0558309373),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 11.7) => -0.0632200144,
   (c_pop_25_34_p > 11.7) => 0.0369998060,
   (c_pop_25_34_p = NULL) => -0.0076293328, -0.0076293328), -0.0022830598);

// Tree: 98 
woFDN_FL__S__lgt_98 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 21.65) => 
      map(
      (NULL < c_professional and c_professional <= 3.6) => -0.0858875268,
      (c_professional > 3.6) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 158.5) => 0.1519117847,
         (c_asian_lang > 158.5) => -0.0060195326,
         (c_asian_lang = NULL) => 0.0645455241, 0.0645455241),
      (c_professional = NULL) => 0.0105263831, 0.0105263831),
   (c_famotf18_p > 21.65) => 0.1613963305,
   (c_famotf18_p = NULL) => 0.0393691672, 0.0393691672),
(r_C21_M_Bureau_ADL_FS_d > 8.5) => -0.0050027732,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 98) => 0.0748781974,
   (c_apt20 > 98) => -0.0394017408,
   (c_apt20 = NULL) => 0.0221336106, 0.0221336106), -0.0037876153);

// Tree: 99 
woFDN_FL__S__lgt_99 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0000673781,
(k_comb_age_d > 67.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 106) => 0.0027596958,
   (f_prevaddrmurderindex_i > 106) => 
      map(
      (NULL < c_trailer and c_trailer <= 158) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 138.5) => 0.0088975328,
         (c_sub_bus > 138.5) => 0.1531428598,
         (c_sub_bus = NULL) => 0.0571830448, 0.0571830448),
      (c_trailer > 158) => 0.3095394675,
      (c_trailer = NULL) => 0.1048792759, 0.1048792759),
   (f_prevaddrmurderindex_i = NULL) => 0.0358674676, 0.0358674676),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 95) => 0.0935409340,
   (c_preschl > 95) => -0.0511303580,
   (c_preschl = NULL) => 0.0140269415, 0.0140269415), 0.0026701340);

// Tree: 100 
woFDN_FL__S__lgt_100 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 32.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 179.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 63) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 14.95) => 0.0453646765,
         (c_hh4_p > 14.95) => 0.1959304106,
         (c_hh4_p = NULL) => 0.1092410485, 0.1092410485),
      (r_C12_source_profile_d > 63) => 
         map(
         (NULL < c_assault and c_assault <= 60.5) => 0.0770411024,
         (c_assault > 60.5) => -0.0682284106,
         (c_assault = NULL) => -0.0109793415, -0.0109793415),
      (r_C12_source_profile_d = NULL) => 0.0428119920, 0.0428119920),
   (f_mos_liens_unrel_SC_fseen_d > 179.5) => -0.0032341862,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0018258488, -0.0018258488),
(f_rel_count_i > 32.5) => -0.0461417896,
(f_rel_count_i = NULL) => 0.0319418916, -0.0029953314);

// Tree: 101 
woFDN_FL__S__lgt_101 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 32.25) => 
   map(
   (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0008625090,
      (f_hh_payday_loan_users_i > 0.5) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 24.5) => 0.1496432520,
         (r_D32_Mos_Since_Crim_LS_d > 24.5) => 0.0263147717,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0335616375, 0.0335616375),
      (f_hh_payday_loan_users_i = NULL) => 0.0020648101, 0.0020648101),
   (r_D31_ALL_Bk_i > 1.5) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 26.65) => -0.0492088110,
      (c_rnt2000_p > 26.65) => 0.0817178323,
      (c_rnt2000_p = NULL) => -0.0379463041, -0.0379463041),
   (r_D31_ALL_Bk_i = NULL) => -0.0140225012, -0.0017500723),
(c_hval_60k_p > 32.25) => -0.0775474469,
(c_hval_60k_p = NULL) => 0.0192459197, -0.0020270033);

// Tree: 102 
woFDN_FL__S__lgt_102 := map(
(NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0159679421,
(c_hh4_p > 11.55) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 24.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => 0.0150699269,
      (k_inq_per_ssn_i > 7.5) => 0.0843516104,
      (k_inq_per_ssn_i = NULL) => 0.0163383539, 0.0163383539),
   (f_rel_ageover20_count_d > 24.5) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 0.0669339032,
      (r_I60_inq_recency_d > 4.5) => -0.0720986594,
      (r_I60_inq_recency_d = NULL) => -0.0475635013, -0.0475635013),
   (f_rel_ageover20_count_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 3.5) => -0.0356325055,
      (c_hval_200k_p > 3.5) => 0.0991407236,
      (c_hval_200k_p = NULL) => 0.0156732124, 0.0156732124), 0.0134497404),
(c_hh4_p = NULL) => 0.0032793062, 0.0021107163);

// Tree: 103 
woFDN_FL__S__lgt_103 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < f_accident_count_i and f_accident_count_i <= 2.5) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 11.5) => -0.0015372848,
      (f_rel_ageover40_count_d > 11.5) => -0.0614523802,
      (f_rel_ageover40_count_d = NULL) => 0.0042547301, -0.0032594862),
   (f_accident_count_i > 2.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.2730372573) => 0.0025209391,
      (f_add_curr_nhood_MFD_pct_i > 0.2730372573) => 0.1948018384,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0823109721, 0.0823109721),
   (f_accident_count_i = NULL) => -0.0020111836, -0.0020111836),
(r_D34_unrel_liens_ct_i > 7.5) => 0.1051090140,
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.75) => -0.0590603650,
   (c_pop_6_11_p > 7.75) => 0.0382427162,
   (c_pop_6_11_p = NULL) => -0.0082303972, -0.0082303972), -0.0014882082);

// Tree: 104 
woFDN_FL__S__lgt_104 := map(
(NULL < c_serv_empl and c_serv_empl <= 198.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 809865.5) => -0.0006006416,
   (f_curraddrmedianvalue_d > 809865.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00956241355) => -0.0638469297,
      (f_add_curr_nhood_BUS_pct_i > 0.00956241355) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 25.5) => 0.0375828473,
         (c_serv_empl > 25.5) => 0.2909476810,
         (c_serv_empl = NULL) => 0.1594300574, 0.1594300574),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0877037714, 0.0877037714),
   (f_curraddrmedianvalue_d = NULL) => 
      map(
      (NULL < c_preschl and c_preschl <= 98) => 0.0654509868,
      (c_preschl > 98) => -0.0409472956,
      (c_preschl = NULL) => 0.0064331896, 0.0064331896), 0.0009659612),
(c_serv_empl > 198.5) => 0.1269406375,
(c_serv_empl = NULL) => -0.0035481337, 0.0015898263);

// Tree: 105 
woFDN_FL__S__lgt_105 := map(
(NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 0.5) => -0.0041954870,
(r_C14_Addrs_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 124809.5) => 
      map(
      (NULL < c_retail and c_retail <= 16.6) => 0.0379456934,
      (c_retail > 16.6) => 0.2008415836,
      (c_retail = NULL) => 0.0901953186, 0.0901953186),
   (r_A46_Curr_AVM_AutoVal_d > 124809.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 0.1152918356,
      (f_prevaddrlenofres_d > 2.5) => -0.0189803318,
      (f_prevaddrlenofres_d = NULL) => 0.0058365085, 0.0058365085),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 8.65) => -0.0130523191,
      (c_pop_75_84_p > 8.65) => 0.1343593569,
      (c_pop_75_84_p = NULL) => 0.0025306891, 0.0025306891), 0.0154898222),
(r_C14_Addrs_Per_ADL_c6_i = NULL) => -0.0272734670, -0.0019833815);

// Tree: 106 
woFDN_FL__S__lgt_106 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 75.55) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 73.05) => -0.0026983993,
      (c_low_ed > 73.05) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 0.5) => -0.0108841389,
         (f_hh_collections_ct_i > 0.5) => 0.1457416861,
         (f_hh_collections_ct_i = NULL) => 0.0810703777, 0.0810703777),
      (c_low_ed = NULL) => -0.0015908193, -0.0015908193),
   (c_low_ed > 75.55) => -0.0462484601,
   (c_low_ed = NULL) => -0.0295366441, -0.0037447512),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 124.5) => -0.0108201013,
   (c_blue_empl > 124.5) => 0.2973768076,
   (c_blue_empl = NULL) => 0.1432783532, 0.1432783532),
(f_historical_count_d = NULL) => 0.0014567270, -0.0024244104);

// Tree: 107 
woFDN_FL__S__lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0807064781,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 
      map(
      (NULL < c_totsales and c_totsales <= 2407) => 0.1790640186,
      (c_totsales > 2407) => 0.0073876381,
      (c_totsales = NULL) => 0.0756445123, 0.0756445123),
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => -0.0027903169,
      (f_rel_felony_count_i > 4.5) => 0.0696215029,
      (f_rel_felony_count_i = NULL) => -0.0024079326, -0.0024079326),
   (f_hh_age_18_plus_d = NULL) => -0.0013261290, -0.0013261290),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 102.5) => 0.0380782705,
   (c_robbery > 102.5) => -0.0614425458,
   (c_robbery = NULL) => -0.0073171896, -0.0073171896), -0.0008182950);

// Tree: 108 
woFDN_FL__S__lgt_108 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00940018095) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1319420526) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 28.2) => 0.0201364824,
      (C_INC_75K_P > 28.2) => 0.2313490681,
      (C_INC_75K_P = NULL) => 0.0311596928, 0.0311596928),
   (f_add_curr_nhood_BUS_pct_i > 0.1319420526) => 0.2251270214,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0423795383, 0.0423795383),
(f_add_curr_nhood_MFD_pct_i > 0.00940018095) => 0.0042659677,
(f_add_curr_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0240140634,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 48) => 0.2627803321,
      (r_A50_pb_average_dollars_d > 48) => 0.0106307728,
      (r_A50_pb_average_dollars_d = NULL) => 0.0941240044, 0.0941240044),
   (f_util_adl_count_n = NULL) => -0.0038440239, -0.0161503780), 0.0036494964);

// Tree: 109 
woFDN_FL__S__lgt_109 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 93.35) => -0.0612497906,
   (c_occunit_p > 93.35) => 
      map(
      (NULL < c_assault and c_assault <= 72.5) => 0.0762454964,
      (c_assault > 72.5) => -0.0575678959,
      (c_assault = NULL) => 0.0187930073, 0.0187930073),
   (c_occunit_p = NULL) => -0.0307572961, -0.0307572961),
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 20) => -0.0178840650,
   (f_curraddrburglaryindex_i > 20) => 0.0139591170,
   (f_curraddrburglaryindex_i = NULL) => 0.0079592940, 0.0079592940),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.3) => 0.0608464295,
   (c_bigapt_p > 1.3) => -0.0618900059,
   (c_bigapt_p = NULL) => 0.0140476448, 0.0140476448), 0.0065349451);

// Tree: 110 
woFDN_FL__S__lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 121.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 16.45) => 
      map(
      (NULL < r_I60_inq_auto_recency_d and r_I60_inq_auto_recency_d <= 18) => -0.0546347505,
      (r_I60_inq_auto_recency_d > 18) => -0.0053966713,
      (r_I60_inq_auto_recency_d = NULL) => -0.0083799937, -0.0083799937),
   (c_pop_12_17_p > 16.45) => 0.0932122273,
   (c_pop_12_17_p = NULL) => -0.0052088561, -0.0073195046),
(f_prevaddrageoldest_d > 121.5) => 
   map(
   (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.3) => 0.0147380865,
   (c_hval_1000k_p > 41.3) => 0.2623063787,
   (c_hval_1000k_p = NULL) => 0.0387426860, 0.0179491118),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.25) => 0.0129308417,
   (c_pop_35_44_p > 15.25) => -0.0920495088,
   (c_pop_35_44_p = NULL) => -0.0308798558, -0.0308798558), 0.0020904527);

// Tree: 111 
woFDN_FL__S__lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.1795422114,
   (r_C12_source_profile_d > 57.95) => -0.0267225821,
   (r_C12_source_profile_d = NULL) => 0.0684765534, 0.0684765534),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 0.0020253877,
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < C_INC_201K_P and C_INC_201K_P <= 2.2) => 0.1418664610,
      (C_INC_201K_P > 2.2) => 0.0031309565,
      (C_INC_201K_P = NULL) => 0.0707788471, 0.0707788471),
   (f_hh_lienholders_i = NULL) => 0.0027001461, 0.0027001461),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 4) => 0.0453936614,
   (c_hval_500k_p > 4) => -0.0674301942,
   (c_hval_500k_p = NULL) => -0.0124169092, -0.0124169092), 0.0032264700);

// Tree: 112 
woFDN_FL__S__lgt_112 := map(
(NULL < c_easiqlife and c_easiqlife <= 93.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 4.5) => 0.1293233651,
   (c_no_teens > 4.5) => -0.0194089309,
   (c_no_teens = NULL) => -0.0168964415, -0.0168964415),
(c_easiqlife > 93.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 2.5) => 
      map(
      (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 0.5) => 
         map(
         (NULL < c_child and c_child <= 21.75) => 0.1445310344,
         (c_child > 21.75) => 0.0312773155,
         (c_child = NULL) => 0.0696654626, 0.0696654626),
      (r_S65_SSN_Problem_i > 0.5) => -0.0640564796,
      (r_S65_SSN_Problem_i = NULL) => 0.0450633030, 0.0450633030),
   (f_corrssnnamecount_d > 2.5) => 0.0046200312,
   (f_corrssnnamecount_d = NULL) => 0.0480397663, 0.0089828460),
(c_easiqlife = NULL) => 0.0089586622, 0.0004075305);

// Tree: 113 
woFDN_FL__S__lgt_113 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 11.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 7.65) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.0177394699,
      (f_assocrisktype_i > 7.5) => 0.1680468024,
      (f_assocrisktype_i = NULL) => 0.0270197462, 0.0270197462),
   (c_pop_35_44_p > 7.65) => -0.0084217322,
   (c_pop_35_44_p = NULL) => 0.0250764843, -0.0049682023),
(f_rel_incomeover100_count_d > 11.5) => 0.1263565369,
(f_rel_incomeover100_count_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 168.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.34299195545) => 0.1312798699,
      (f_add_curr_nhood_MFD_pct_i > 0.34299195545) => -0.0479666948,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0249698444, 0.0052849645),
   (c_new_homes > 168.5) => 0.1110224456,
   (c_new_homes = NULL) => 0.0298038007, 0.0298038007), -0.0031129660);

// Tree: 114 
woFDN_FL__S__lgt_114 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0841729978,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < c_rich_blk and c_rich_blk <= 197.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134.5) => -0.0156556155,
      (f_prevaddrageoldest_d > 134.5) => 0.0086212978,
      (f_prevaddrageoldest_d = NULL) => -0.0165201469, -0.0071822305),
   (c_rich_blk > 197.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 108) => 0.0002503162,
      (f_curraddrcartheftindex_i > 108) => 0.1723199805,
      (f_curraddrcartheftindex_i = NULL) => 0.0656217607, 0.0656217607),
   (c_rich_blk = NULL) => -0.0058160467, -0.0058160467),
(C_INC_100K_P = NULL) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0253408650,
   (f_vardobcountnew_i > 0.5) => 0.1427685307,
   (f_vardobcountnew_i = NULL) => 0.0030412408, 0.0030412408), -0.0051448670);

// Tree: 115 
woFDN_FL__S__lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.05) => 
   map(
   (NULL < r_I60_inq_mortgage_recency_d and r_I60_inq_mortgage_recency_d <= 9) => -0.1051870961,
   (r_I60_inq_mortgage_recency_d > 9) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 0.25) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 0.0067857213,
         (f_assocsuspicousidcount_i > 13.5) => 0.0881778745,
         (f_assocsuspicousidcount_i = NULL) => 0.0074517436, 0.0074517436),
      (c_rnt2000_p > 0.25) => -0.0153830025,
      (c_rnt2000_p = NULL) => -0.0006639209, -0.0006639209),
   (r_I60_inq_mortgage_recency_d = NULL) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 83) => -0.0761621722,
      (c_lar_fam > 83) => 0.0406941157,
      (c_lar_fam = NULL) => -0.0049278597, -0.0049278597), -0.0024823756),
(c_pop_0_5_p > 21.05) => 0.1247928219,
(c_pop_0_5_p = NULL) => 0.0027033763, -0.0018333060);

// Tree: 116 
woFDN_FL__S__lgt_116 := map(
(NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 71.5) => -0.1254620317,
(f_mos_liens_rel_SC_lseen_d > 71.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 5.65) => -0.0528248710,
   (c_pop_35_44_p > 5.65) => 
      map(
      (NULL < c_unemp and c_unemp <= 2.35) => -0.0294728434,
      (c_unemp > 2.35) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 0.0053100724,
         (f_rel_homeover500_count_d > 14.5) => 0.1439455557,
         (f_rel_homeover500_count_d = NULL) => -0.0011000211, 0.0060660145),
      (c_unemp = NULL) => 0.0000189058, 0.0000189058),
   (c_pop_35_44_p = NULL) => 0.0184557487, -0.0014133267),
(f_mos_liens_rel_SC_lseen_d = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 8.1) => 0.0695893382,
   (c_hval_250k_p > 8.1) => -0.0585250275,
   (c_hval_250k_p = NULL) => 0.0107516295, 0.0107516295), -0.0017797217);

// Tree: 117 
woFDN_FL__S__lgt_117 := map(
(NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 24.05) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => -0.0884318136,
      (r_D33_Eviction_Recency_d > 30) => -0.0103644523,
      (r_D33_Eviction_Recency_d = NULL) => -0.0109565838, -0.0109565838),
   (c_hh3_p > 24.05) => 0.0321462175,
   (c_hh3_p = NULL) => -0.0253965922, -0.0055391095),
(r_F04_curr_add_occ_index_d > 2) => 
   map(
   (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 115024) => 0.2092684055,
      (f_curraddrmedianvalue_d > 115024) => 0.0583610905,
      (f_curraddrmedianvalue_d = NULL) => 0.0890051047, 0.0890051047),
   (r_I60_inq_banking_recency_d > 9) => 0.0167828392,
   (r_I60_inq_banking_recency_d = NULL) => 0.0236398823, 0.0236398823),
(r_F04_curr_add_occ_index_d = NULL) => -0.0085183536, 0.0007547544);

// Tree: 118 
woFDN_FL__S__lgt_118 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 11.05) => -0.0079119049,
   (c_hh6_p > 11.05) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 136) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 2.5) => 0.1345029555,
         (f_rel_incomeover75_count_d > 2.5) => 0.0024034132,
         (f_rel_incomeover75_count_d = NULL) => 0.0850844217, 0.0850844217),
      (f_prevaddrlenofres_d > 136) => -0.0740933209,
      (f_prevaddrlenofres_d = NULL) => 0.0567758436, 0.0567758436),
   (c_hh6_p = NULL) => -0.0149941121, -0.0063123823),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 28.65) => 0.1382511546,
   (c_hh2_p > 28.65) => 0.0014240451,
   (c_hh2_p = NULL) => 0.0685467780, 0.0685467780),
(f_inq_Communications_count_i = NULL) => -0.0277546409, -0.0059192746);

// Tree: 119 
woFDN_FL__S__lgt_119 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.55) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 54.5) => 0.1535699703,
      (r_C13_max_lres_d > 54.5) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 134.5) => -0.0745835860,
         (f_prevaddrcartheftindex_i > 134.5) => 0.0542378376,
         (f_prevaddrcartheftindex_i = NULL) => -0.0321518849, -0.0321518849),
      (r_C13_max_lres_d = NULL) => -0.0110825988, -0.0110825988),
   (c_pop_6_11_p > 8.55) => -0.0709914642,
   (c_pop_6_11_p = NULL) => -0.0366340908, -0.0366340908),
(f_mos_inq_banko_om_fseen_d > 21.5) => 0.0072861224,
(f_mos_inq_banko_om_fseen_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.85) => -0.0663650156,
   (c_pop_55_64_p > 11.85) => 0.0401815634,
   (c_pop_55_64_p = NULL) => -0.0202703963, -0.0202703963), 0.0040475951);

// Tree: 120 
woFDN_FL__S__lgt_120 := map(
(NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 54.95) => 0.0021534635,
   (C_RENTOCC_P > 54.95) => -0.0304537424,
   (C_RENTOCC_P = NULL) => -0.0301021914, -0.0035540634),
(r_I61_inq_collection_count12_i > 0.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 39.95) => 0.0175793656,
   (c_hh1_p > 39.95) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 0.15) => 0.1477688911,
      (c_hval_750k_p > 0.15) => -0.0112703669,
      (c_hval_750k_p = NULL) => 0.0870949545, 0.0870949545),
   (c_hh1_p = NULL) => 0.0279646824, 0.0279646824),
(r_I61_inq_collection_count12_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0342712159,
   (f_addrs_per_ssn_i > 5.5) => 0.0790661839,
   (f_addrs_per_ssn_i = NULL) => 0.0148416574, 0.0148416574), -0.0004505484);

// Tree: 121 
woFDN_FL__S__lgt_121 := map(
(NULL < c_white_col and c_white_col <= 16.15) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 66.15) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 50.45) => 
         map(
         (NULL < c_food and c_food <= 12.2) => 0.0585943543,
         (c_food > 12.2) => 0.2395208418,
         (c_food = NULL) => 0.1412221990, 0.1412221990),
      (C_RENTOCC_P > 50.45) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 29) => 0.0790193055,
         (c_exp_prod > 29) => -0.0823762758,
         (c_exp_prod = NULL) => -0.0055212371, -0.0055212371),
      (C_RENTOCC_P = NULL) => 0.0748081439, 0.0748081439),
   (c_lowrent > 66.15) => -0.0530501898,
   (c_lowrent = NULL) => 0.0426373373, 0.0426373373),
(c_white_col > 16.15) => -0.0030454847,
(c_white_col = NULL) => 0.0065608179, -0.0017033993);

// Tree: 122 
woFDN_FL__S__lgt_122 := map(
(NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 43.5) => -0.0129058806,
   (r_C13_Curr_Addr_LRes_d > 43.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 197.5) => 0.0088208286,
      (c_sub_bus > 197.5) => 0.1395818927,
      (c_sub_bus = NULL) => -0.0270807964, 0.0092018347),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0003716342, 0.0003716342),
(r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 80) => 0.1691698087,
   (c_new_homes > 80) => 0.0079681508,
   (c_new_homes = NULL) => 0.0606054268, 0.0606054268),
(r_C14_Addrs_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 75.5) => 0.0610975035,
   (c_larceny > 75.5) => -0.0553674463,
   (c_larceny = NULL) => -0.0007185083, -0.0007185083), 0.0012956443);

// Tree: 123 
woFDN_FL__S__lgt_123 := map(
(NULL < c_low_hval and c_low_hval <= 71.35) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 50.25) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 28.85) => -0.0432704599,
      (c_fammar_p > 28.85) => 0.0046527681,
      (c_fammar_p = NULL) => 0.0038822597, 0.0038822597),
   (c_low_hval > 50.25) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 36.95) => 
         map(
         (NULL < c_health and c_health <= 11.75) => -0.0344387687,
         (c_health > 11.75) => 0.1462640442,
         (c_health = NULL) => 0.0189948588, 0.0189948588),
      (c_rnt750_p > 36.95) => 0.1423041867,
      (c_rnt750_p = NULL) => 0.0520068048, 0.0520068048),
   (c_low_hval = NULL) => 0.0048794561, 0.0048794561),
(c_low_hval > 71.35) => -0.0761573253,
(c_low_hval = NULL) => 0.0131102788, 0.0044668693);

// Tree: 124 
woFDN_FL__S__lgt_124 := map(
(NULL < c_span_lang and c_span_lang <= 188.5) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 60790.5) => 0.0103417090,
      (f_curraddrmedianincome_d > 60790.5) => -0.0102506313,
      (f_curraddrmedianincome_d = NULL) => -0.0015101789, -0.0015101789),
   (f_inq_QuizProvider_count_i > 5.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0137813993,
      (f_inq_Collection_count_i > 1.5) => 0.1709894887,
      (f_inq_Collection_count_i = NULL) => 0.0693655003, 0.0693655003),
   (f_inq_QuizProvider_count_i = NULL) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 124.5) => -0.0510796219,
      (c_relig_indx > 124.5) => 0.0801416213,
      (c_relig_indx = NULL) => 0.0076246185, 0.0076246185), -0.0005729279),
(c_span_lang > 188.5) => -0.0376594561,
(c_span_lang = NULL) => 0.0021318986, -0.0024861391);

// Tree: 125 
woFDN_FL__S__lgt_125 := map(
(NULL < c_lowinc and c_lowinc <= 79.25) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 11.45) => 0.0000663946,
         (c_unemp > 11.45) => 0.0530199465,
         (c_unemp = NULL) => 0.0008892900, 0.0008892900),
      (f_inq_Auto_count24_i > 1.5) => -0.0490020456,
      (f_inq_Auto_count24_i = NULL) => 0.0057467781, -0.0016614142),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => 0.0087263594,
      (f_addrs_per_ssn_i > 7.5) => 0.1913590060,
      (f_addrs_per_ssn_i = NULL) => 0.0746770374, 0.0746770374),
   (f_nae_nothing_found_i = NULL) => -0.0005459891, -0.0005459891),
(c_lowinc > 79.25) => -0.0983127453,
(c_lowinc = NULL) => -0.0100629115, -0.0013562714);

// Tree: 126 
woFDN_FL__S__lgt_126 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00279349225) => 0.1619206989,
      (f_add_curr_nhood_MFD_pct_i > 0.00279349225) => 0.0080356456,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0185820803, 0.0120090534),
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 29.5) => 0.2452541398,
      (r_A50_pb_average_dollars_d > 29.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 18) => 0.0075136266,
         (c_hh4_p > 18) => 0.1613728921,
         (c_hh4_p = NULL) => 0.0456121114, 0.0456121114),
      (r_A50_pb_average_dollars_d = NULL) => 0.0838107667, 0.0838107667),
   (f_util_adl_count_n = NULL) => 0.0165886238, 0.0165886238),
(k_estimated_income_d > 34500) => -0.0050252781,
(k_estimated_income_d = NULL) => 0.0053156545, 0.0024701153);

// Tree: 127 
woFDN_FL__S__lgt_127 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0052497441,
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 17.35) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 47.85) => 
            map(
            (NULL < c_young and c_young <= 18.8) => 0.0719081385,
            (c_young > 18.8) => 0.2058580422,
            (c_young = NULL) => 0.1470334813, 0.1470334813),
         (c_low_ed > 47.85) => 0.0385385883,
         (c_low_ed = NULL) => 0.0887972520, 0.0887972520),
      (c_pop_25_34_p > 17.35) => -0.0057602936,
      (c_pop_25_34_p = NULL) => 0.0567672244, 0.0567672244),
   (f_current_count_d > 0.5) => -0.0235824926,
   (f_current_count_d = NULL) => 0.0210094969, 0.0210094969),
(f_inq_Communications_count_i = NULL) => -0.0180870972, -0.0030059328);

// Tree: 128 
woFDN_FL__S__lgt_128 := map(
(NULL < c_rich_blk and c_rich_blk <= 186.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 147.5) => 0.0080224388,
      (c_rich_fam > 147.5) => 0.1539615171,
      (c_rich_fam = NULL) => 0.0507027353, 0.0507027353),
   (f_corrssnnamecount_d > 1.5) => -0.0049154237,
   (f_corrssnnamecount_d = NULL) => 0.0214431833, -0.0019219815),
(c_rich_blk > 186.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 14.5) => 0.0196852971,
   (f_rel_ageover30_count_d > 14.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0322967267) => 0.1405657780,
      (f_add_curr_nhood_BUS_pct_i > 0.0322967267) => 0.0501847045,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0913583047, 0.0913583047),
   (f_rel_ageover30_count_d = NULL) => 0.0285197434, 0.0285197434),
(c_rich_blk = NULL) => -0.0202869770, 0.0013166631);

// Tree: 129 
woFDN_FL__S__lgt_129 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 52.35) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 153.5) => -0.0164601865,
   (r_A50_pb_average_dollars_d > 153.5) => 
      map(
      (NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 226.5) => -0.0950742060,
      (f_mos_liens_unrel_FT_fseen_d > 226.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3405378758) => 0.0186344706,
         (f_add_curr_mobility_index_i > 0.3405378758) => -0.0210031587,
         (f_add_curr_mobility_index_i = NULL) => 0.0094750567, 0.0094750567),
      (f_mos_liens_unrel_FT_fseen_d = NULL) => 0.0081311343, 0.0081311343),
   (r_A50_pb_average_dollars_d = NULL) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 115) => 0.0323759196,
      (c_very_rich > 115) => -0.0811299107,
      (c_very_rich = NULL) => -0.0117198706, -0.0117198706), -0.0058303499),
(c_hval_500k_p > 52.35) => 0.1110312816,
(c_hval_500k_p = NULL) => 0.0364675120, -0.0040645709);

// Tree: 130 
woFDN_FL__S__lgt_130 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.35) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 12.5) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 4.5) => -0.0027222938,
      (f_inq_Other_count24_i > 4.5) => 0.0869759866,
      (f_inq_Other_count24_i = NULL) => -0.0021559039, -0.0021559039),
   (f_inq_count24_i > 12.5) => -0.0745439494,
   (f_inq_count24_i = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0324661461,
      (c_rnt1000_p > 10.8) => 0.0689401490,
      (c_rnt1000_p = NULL) => 0.0170003393, 0.0170003393), -0.0026714465),
(c_hh6_p > 17.35) => -0.1058220275,
(c_hh6_p = NULL) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => -0.0166328345,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity']) => 0.1797027890,
   (nf_seg_FraudPoint_3_0 = '') => 0.0139883178, 0.0139883178), -0.0028843872);

// Tree: 131 
woFDN_FL__S__lgt_131 := map(
(NULL < c_hh00 and c_hh00 <= 268.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 162.5) => -0.0805661850,
   (c_sub_bus > 162.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 22) => 0.1095157186,
      (f_prevaddrlenofres_d > 22) => -0.0415288274,
      (f_prevaddrlenofres_d = NULL) => 0.0214064001, 0.0214064001),
   (c_sub_bus = NULL) => -0.0501815772, -0.0501815772),
(c_hh00 > 268.5) => 
   map(
   (NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 2) => 0.1384228775,
   (r_I60_inq_retail_recency_d > 2) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 918617) => 0.0016114867,
      (f_curraddrmedianvalue_d > 918617) => 0.1687388877,
      (f_curraddrmedianvalue_d = NULL) => 0.0023655947, 0.0023655947),
   (r_I60_inq_retail_recency_d = NULL) => 0.0140805883, 0.0030636590),
(c_hh00 = NULL) => 0.0043698959, 0.0012366054);

// Tree: 132 
woFDN_FL__S__lgt_132 := map(
(NULL < c_hh3_p and c_hh3_p <= 17.45) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0091502126,
   (k_comb_age_d > 81.5) => 0.1073072083,
   (k_comb_age_d = NULL) => -0.0155570303, -0.0077869360),
(c_hh3_p > 17.45) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.95) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 77.75) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => 0.1714046386,
         (f_rel_incomeover50_count_d > 4.5) => 0.0074730557,
         (f_rel_incomeover50_count_d = NULL) => 0.0951573907, 0.0951573907),
      (c_occunit_p > 77.75) => 0.0040102008,
      (c_occunit_p = NULL) => 0.0066223217, 0.0066223217),
   (r_C12_source_profile_d > 78.95) => 0.0788734642,
   (r_C12_source_profile_d = NULL) => 0.0392912694, 0.0143901756),
(c_hh3_p = NULL) => -0.0362334131, 0.0005940350);

// Tree: 133 
woFDN_FL__S__lgt_133 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0624831190,
   (r_I60_inq_hiRiskCred_recency_d > 9) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 0.25) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 92.5) => 0.1963288543,
         (c_easiqlife > 92.5) => 0.0314750022,
         (c_easiqlife = NULL) => 0.0965488912, 0.0965488912),
      (c_hh5_p > 0.25) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 35821) => 0.1126475607,
         (r_A46_Curr_AVM_AutoVal_d > 35821) => 0.0211644915,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0072009563, 0.0183305901),
      (c_hh5_p = NULL) => 0.0588127818, 0.0290340981),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0243194161, 0.0243194161),
(f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0008194688,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0013102144, 0.0026371694);

// Tree: 134 
woFDN_FL__S__lgt_134 := map(
(NULL < c_rich_hisp and c_rich_hisp <= 195.5) => 
   map(
   (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 23.5) => -0.0001342999,
   (f_rel_homeover150_count_d > 23.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 2.5) => -0.0276237625,
      (f_srchssnsrchcount_i > 2.5) => -0.1463420314,
      (f_srchssnsrchcount_i = NULL) => -0.0593423840, -0.0593423840),
   (f_rel_homeover150_count_d = NULL) => -0.0022830046, -0.0014886526),
(c_rich_hisp > 195.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 33.6) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 1.25) => -0.0144877675,
      (c_hval_20k_p > 1.25) => 0.1945549513,
      (c_hval_20k_p = NULL) => 0.0263517041, 0.0263517041),
   (c_hval_750k_p > 33.6) => 0.2147853637,
   (c_hval_750k_p = NULL) => 0.0588758700, 0.0588758700),
(c_rich_hisp = NULL) => 0.0077924718, 0.0004838797);

// Tree: 135 
woFDN_FL__S__lgt_135 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 13.5) => 0.0277467357,
   (f_addrs_per_ssn_i > 13.5) => -0.1313664991,
   (f_addrs_per_ssn_i = NULL) => -0.0503633977, -0.0503633977),
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 48.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.05) => -0.0022616973,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.05) => 0.0682536663,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0054636956, 0.0228434287),
   (c_no_teens > 48.5) => -0.0065290535,
   (c_no_teens = NULL) => -0.0107695028, 0.0003068412),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 6.45) => 0.0392620470,
   (c_hval_300k_p > 6.45) => -0.0698470850,
   (c_hval_300k_p = NULL) => -0.0030788102, -0.0030788102), -0.0001696533);

// Tree: 136 
woFDN_FL__S__lgt_136 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 0.5) => -0.0058521300,
(r_D32_criminal_count_i > 0.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 16.65) => 
      map(
      (NULL < c_totsales and c_totsales <= 1924) => 0.0400231797,
      (c_totsales > 1924) => 0.2213918873,
      (c_totsales = NULL) => 0.1277822318, 0.1277822318),
   (c_hh2_p > 16.65) => 
      map(
      (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 1.5) => 0.0096793568,
      (f_inq_QuizProvider_count24_i > 1.5) => 0.1438144908,
      (f_inq_QuizProvider_count24_i = NULL) => 0.0132957452, 0.0132957452),
   (c_hh2_p = NULL) => 0.0198559690, 0.0198559690),
(r_D32_criminal_count_i = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 101.5) => -0.0457158909,
   (c_no_car > 101.5) => 0.0738165831,
   (c_no_car = NULL) => 0.0077591633, 0.0077591633), -0.0013126546);

// Tree: 137 
woFDN_FL__S__lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0037058099,
   (r_F04_curr_add_occ_index_d > 2) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 50.5) => 0.0557143645,
      (c_lux_prod > 50.5) => 0.0023032765,
      (c_lux_prod = NULL) => 0.0598121971, 0.0138389261),
   (r_F04_curr_add_occ_index_d = NULL) => 0.0001098078, 0.0001098078),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 5.5) => -0.1097374911,
   (f_inq_HighRiskCredit_count_i > 5.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 22.5) => -0.0831893922,
      (f_mos_inq_banko_cm_lseen_d > 22.5) => 0.0310444684,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0112939554, -0.0112939554),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0427021311, -0.0427021311),
(f_inq_HighRiskCredit_count24_i = NULL) => -0.0199075146, -0.0008009312);

// Tree: 138 
woFDN_FL__S__lgt_138 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 190.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 13.75) => 
      map(
      (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 0.0016712322,
      (f_assoccredbureaucountnew_i > 0.5) => 0.0553681148,
      (f_assoccredbureaucountnew_i = NULL) => 0.0028102286, 0.0028102286),
   (c_pop_12_17_p > 13.75) => -0.0458380785,
   (c_pop_12_17_p = NULL) => -0.0127597830, 0.0005644282),
(f_curraddrcartheftindex_i > 190.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 40.15) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.0538544182,
      (f_prevaddrstatus_i > 2.5) => 0.0083832223,
      (f_prevaddrstatus_i = NULL) => 0.1748333770, 0.0703427597),
   (c_white_col > 40.15) => -0.0434866360,
   (c_white_col = NULL) => 0.0367595529, 0.0367595529),
(f_curraddrcartheftindex_i = NULL) => -0.0168124604, 0.0013078723);

// Tree: 139 
woFDN_FL__S__lgt_139 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 105500) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 69787.5) => -0.0088628997,
   (f_curraddrmedianincome_d > 69787.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 40.15) => -0.0031740049,
         (c_hval_750k_p > 40.15) => 0.0605631805,
         (c_hval_750k_p = NULL) => 0.0038164458, 0.0038164458),
      (f_nae_nothing_found_i > 0.5) => 0.1287512016,
      (f_nae_nothing_found_i = NULL) => 0.0053858585, 0.0053858585),
   (f_curraddrmedianincome_d = NULL) => -0.0028685867, -0.0028685867),
(k_estimated_income_d > 105500) => 0.1685894217,
(k_estimated_income_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 9.9) => -0.0488182078,
   (c_rnt1000_p > 9.9) => 0.0550660059,
   (c_rnt1000_p = NULL) => 0.0010462148, 0.0010462148), -0.0019498879);

// Tree: 140 
woFDN_FL__S__lgt_140 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0109108793,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 7.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < c_trailer and c_trailer <= 173.5) => 0.0348785096,
         (c_trailer > 173.5) => 0.1732071788,
         (c_trailer = NULL) => 0.0444275644, 0.0444275644),
      (f_hh_members_ct_d > 1.5) => 0.0076360526,
      (f_hh_members_ct_d = NULL) => 0.0155435268, 0.0155435268),
   (f_rel_criminal_count_i > 7.5) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 77.75) => 0.0015844406,
      (c_sfdu_p > 77.75) => -0.0911372518,
      (c_sfdu_p = NULL) => -0.0461707167, -0.0461707167),
   (f_rel_criminal_count_i = NULL) => 0.0123343384, 0.0123343384),
(k_inq_per_ssn_i = NULL) => -0.0013965577, -0.0013965577);

// Tree: 141 
woFDN_FL__S__lgt_141 := map(
(NULL < c_fammar_p and c_fammar_p <= 25.85) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 152.5) => 0.0083064369,
   (c_bel_edu > 152.5) => -0.0896469182,
   (c_bel_edu = NULL) => -0.0406702407, -0.0406702407),
(c_fammar_p > 25.85) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => -0.0037076044,
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.46160918205) => -0.0051208727,
      (f_add_curr_nhood_MFD_pct_i > 0.46160918205) => 0.1483805041,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0482709106, 0.0482709106),
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 78.8) => -0.0621199171,
      (c_oldhouse > 78.8) => 0.0400722623,
      (c_oldhouse = NULL) => -0.0003470325, -0.0003470325), -0.0028458673),
(c_fammar_p = NULL) => -0.0261433751, -0.0040203337);

// Tree: 142 
woFDN_FL__S__lgt_142 := map(
(NULL < c_highinc and c_highinc <= 0.55) => -0.0409469782,
(c_highinc > 0.55) => 
   map(
   (NULL < C_INC_200K_P and C_INC_200K_P <= 0.25) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 65.5) => 0.1584686561,
      (r_D32_Mos_Since_Crim_LS_d > 65.5) => 
         map(
         (NULL < c_assault and c_assault <= 180.5) => 
            map(
            (NULL < c_child and c_child <= 23.15) => 0.0965328906,
            (c_child > 23.15) => -0.0244431528,
            (c_child = NULL) => 0.0191408089, 0.0191408089),
         (c_assault > 180.5) => 0.1479185398,
         (c_assault = NULL) => 0.0357572903, 0.0357572903),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0452221724, 0.0452221724),
   (C_INC_200K_P > 0.25) => 0.0003521110,
   (C_INC_200K_P = NULL) => 0.0031399510, 0.0031399510),
(c_highinc = NULL) => -0.0021736397, 0.0018362090);

// Tree: 143 
woFDN_FL__S__lgt_143 := map(
(NULL < c_child and c_child <= 33.45) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0022202256,
   (f_srchunvrfddobcount_i > 0.5) => 
      map(
      (NULL < c_retired and c_retired <= 6.25) => 0.1538114453,
      (c_retired > 6.25) => 0.0029743410,
      (c_retired = NULL) => 0.0413692403, 0.0413692403),
   (f_srchunvrfddobcount_i = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.15) => 0.0612184409,
      (c_hval_250k_p > 8.15) => -0.0690934321,
      (c_hval_250k_p = NULL) => 0.0078119356, 0.0078119356), 0.0035895919),
(c_child > 33.45) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 14.95) => 0.0669781708,
   (r_C12_source_profile_d > 14.95) => -0.0471108744,
   (r_C12_source_profile_d = NULL) => -0.0375813950, -0.0375813950),
(c_child = NULL) => -0.0074611587, 0.0005029439);

// Tree: 144 
woFDN_FL__S__lgt_144 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0976882386,
   (C_INC_100K_P > 1.35) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 10.05) => -0.0001361899,
         (c_hh7p_p > 10.05) => 0.0585423297,
         (c_hh7p_p = NULL) => 0.0011206662, 0.0011206662),
      (r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0698081252,
      (r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => -0.0004660009, -0.0004660009),
   (C_INC_100K_P = NULL) => -0.0032683554, -0.0001061725),
(f_assocsuspicousidcount_i > 9.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => -0.0680804788,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => 0.0622459532,
   (nf_seg_FraudPoint_3_0 = '') => -0.0395212915, -0.0395212915),
(f_assocsuspicousidcount_i = NULL) => -0.0129827091, -0.0012458907);

// Tree: 145 
woFDN_FL__S__lgt_145 := map(
(NULL < c_low_hval and c_low_hval <= 72.6) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0064860819,
   (k_comb_age_d > 56.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 32.45) => 0.0065394467,
      (c_rnt1000_p > 32.45) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
            map(
            (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 323.5) => 0.1564476708,
            (f_M_Bureau_ADL_FS_all_d > 323.5) => 0.0117097616,
            (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0470270728, 0.0470270728),
         (f_rel_felony_count_i > 0.5) => 0.1899632900,
         (f_rel_felony_count_i = NULL) => 0.0684675054, 0.0684675054),
      (c_rnt1000_p = NULL) => 0.0201278871, 0.0201278871),
   (k_comb_age_d = NULL) => -0.0151983294, -0.0012421338),
(c_low_hval > 72.6) => -0.0891379103,
(c_low_hval = NULL) => 0.0121798860, -0.0014727865);

// Tree: 146 
woFDN_FL__S__lgt_146 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 180.5) => 0.0091161478,
   (r_C13_Curr_Addr_LRes_d > 180.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81) => 0.0586966852,
      (r_C12_source_profile_d > 81) => 0.2874031251,
      (r_C12_source_profile_d = NULL) => 0.1053010164, 0.1053010164),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0190805693, 0.0190805693),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0141303150,
   (f_hh_payday_loan_users_i > 0.5) => 0.0273520039,
   (f_hh_payday_loan_users_i = NULL) => -0.0100709975, -0.0100709975),
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 8.05) => 0.0476876512,
   (c_professional > 8.05) => -0.0629761444,
   (c_professional = NULL) => 0.0034221329, 0.0034221329), -0.0040378448);

// Final Score Sum 

   woFDN_FL__S__lgt := sum(
      woFDN_FL__S__lgt_0, woFDN_FL__S__lgt_1, woFDN_FL__S__lgt_2, woFDN_FL__S__lgt_3, woFDN_FL__S__lgt_4, 
      woFDN_FL__S__lgt_5, woFDN_FL__S__lgt_6, woFDN_FL__S__lgt_7, woFDN_FL__S__lgt_8, woFDN_FL__S__lgt_9, 
      woFDN_FL__S__lgt_10, woFDN_FL__S__lgt_11, woFDN_FL__S__lgt_12, woFDN_FL__S__lgt_13, woFDN_FL__S__lgt_14, 
      woFDN_FL__S__lgt_15, woFDN_FL__S__lgt_16, woFDN_FL__S__lgt_17, woFDN_FL__S__lgt_18, woFDN_FL__S__lgt_19, 
      woFDN_FL__S__lgt_20, woFDN_FL__S__lgt_21, woFDN_FL__S__lgt_22, woFDN_FL__S__lgt_23, woFDN_FL__S__lgt_24, 
      woFDN_FL__S__lgt_25, woFDN_FL__S__lgt_26, woFDN_FL__S__lgt_27, woFDN_FL__S__lgt_28, woFDN_FL__S__lgt_29, 
      woFDN_FL__S__lgt_30, woFDN_FL__S__lgt_31, woFDN_FL__S__lgt_32, woFDN_FL__S__lgt_33, woFDN_FL__S__lgt_34, 
      woFDN_FL__S__lgt_35, woFDN_FL__S__lgt_36, woFDN_FL__S__lgt_37, woFDN_FL__S__lgt_38, woFDN_FL__S__lgt_39, 
      woFDN_FL__S__lgt_40, woFDN_FL__S__lgt_41, woFDN_FL__S__lgt_42, woFDN_FL__S__lgt_43, woFDN_FL__S__lgt_44, 
      woFDN_FL__S__lgt_45, woFDN_FL__S__lgt_46, woFDN_FL__S__lgt_47, woFDN_FL__S__lgt_48, woFDN_FL__S__lgt_49, 
      woFDN_FL__S__lgt_50, woFDN_FL__S__lgt_51, woFDN_FL__S__lgt_52, woFDN_FL__S__lgt_53, woFDN_FL__S__lgt_54, 
      woFDN_FL__S__lgt_55, woFDN_FL__S__lgt_56, woFDN_FL__S__lgt_57, woFDN_FL__S__lgt_58, woFDN_FL__S__lgt_59, 
      woFDN_FL__S__lgt_60, woFDN_FL__S__lgt_61, woFDN_FL__S__lgt_62, woFDN_FL__S__lgt_63, woFDN_FL__S__lgt_64, 
      woFDN_FL__S__lgt_65, woFDN_FL__S__lgt_66, woFDN_FL__S__lgt_67, woFDN_FL__S__lgt_68, woFDN_FL__S__lgt_69, 
      woFDN_FL__S__lgt_70, woFDN_FL__S__lgt_71, woFDN_FL__S__lgt_72, woFDN_FL__S__lgt_73, woFDN_FL__S__lgt_74, 
      woFDN_FL__S__lgt_75, woFDN_FL__S__lgt_76, woFDN_FL__S__lgt_77, woFDN_FL__S__lgt_78, woFDN_FL__S__lgt_79, 
      woFDN_FL__S__lgt_80, woFDN_FL__S__lgt_81, woFDN_FL__S__lgt_82, woFDN_FL__S__lgt_83, woFDN_FL__S__lgt_84, 
      woFDN_FL__S__lgt_85, woFDN_FL__S__lgt_86, woFDN_FL__S__lgt_87, woFDN_FL__S__lgt_88, woFDN_FL__S__lgt_89, 
      woFDN_FL__S__lgt_90, woFDN_FL__S__lgt_91, woFDN_FL__S__lgt_92, woFDN_FL__S__lgt_93, woFDN_FL__S__lgt_94, 
      woFDN_FL__S__lgt_95, woFDN_FL__S__lgt_96, woFDN_FL__S__lgt_97, woFDN_FL__S__lgt_98, woFDN_FL__S__lgt_99, 
      woFDN_FL__S__lgt_100, woFDN_FL__S__lgt_101, woFDN_FL__S__lgt_102, woFDN_FL__S__lgt_103, woFDN_FL__S__lgt_104, 
      woFDN_FL__S__lgt_105, woFDN_FL__S__lgt_106, woFDN_FL__S__lgt_107, woFDN_FL__S__lgt_108, woFDN_FL__S__lgt_109, 
      woFDN_FL__S__lgt_110, woFDN_FL__S__lgt_111, woFDN_FL__S__lgt_112, woFDN_FL__S__lgt_113, woFDN_FL__S__lgt_114, 
      woFDN_FL__S__lgt_115, woFDN_FL__S__lgt_116, woFDN_FL__S__lgt_117, woFDN_FL__S__lgt_118, woFDN_FL__S__lgt_119, 
      woFDN_FL__S__lgt_120, woFDN_FL__S__lgt_121, woFDN_FL__S__lgt_122, woFDN_FL__S__lgt_123, woFDN_FL__S__lgt_124, 
      woFDN_FL__S__lgt_125, woFDN_FL__S__lgt_126, woFDN_FL__S__lgt_127, woFDN_FL__S__lgt_128, woFDN_FL__S__lgt_129, 
      woFDN_FL__S__lgt_130, woFDN_FL__S__lgt_131, woFDN_FL__S__lgt_132, woFDN_FL__S__lgt_133, woFDN_FL__S__lgt_134, 
      woFDN_FL__S__lgt_135, woFDN_FL__S__lgt_136, woFDN_FL__S__lgt_137, woFDN_FL__S__lgt_138, woFDN_FL__S__lgt_139, 
      woFDN_FL__S__lgt_140, woFDN_FL__S__lgt_141, woFDN_FL__S__lgt_142, woFDN_FL__S__lgt_143, woFDN_FL__S__lgt_144, 
      woFDN_FL__S__lgt_145, woFDN_FL__S__lgt_146); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_woFDN_LGT := woFDN_FL__S__lgt;
			
self.final_score_0	:= 	woFDN_FL__S__lgt_0	;
self.final_score_1	:= 	woFDN_FL__S__lgt_1	;
self.final_score_2	:= 	woFDN_FL__S__lgt_2	;
self.final_score_3	:= 	woFDN_FL__S__lgt_3	;
self.final_score_4	:= 	woFDN_FL__S__lgt_4	;
self.final_score_5	:= 	woFDN_FL__S__lgt_5	;
self.final_score_6	:= 	woFDN_FL__S__lgt_6	;
self.final_score_7	:= 	woFDN_FL__S__lgt_7	;
self.final_score_8	:= 	woFDN_FL__S__lgt_8	;
self.final_score_9	:= 	woFDN_FL__S__lgt_9	;
self.final_score_10	:= 	woFDN_FL__S__lgt_10	;
self.final_score_11	:= 	woFDN_FL__S__lgt_11	;
self.final_score_12	:= 	woFDN_FL__S__lgt_12	;
self.final_score_13	:= 	woFDN_FL__S__lgt_13	;
self.final_score_14	:= 	woFDN_FL__S__lgt_14	;
self.final_score_15	:= 	woFDN_FL__S__lgt_15	;
self.final_score_16	:= 	woFDN_FL__S__lgt_16	;
self.final_score_17	:= 	woFDN_FL__S__lgt_17	;
self.final_score_18	:= 	woFDN_FL__S__lgt_18	;
self.final_score_19	:= 	woFDN_FL__S__lgt_19	;
self.final_score_20	:= 	woFDN_FL__S__lgt_20	;
self.final_score_21	:= 	woFDN_FL__S__lgt_21	;
self.final_score_22	:= 	woFDN_FL__S__lgt_22	;
self.final_score_23	:= 	woFDN_FL__S__lgt_23	;
self.final_score_24	:= 	woFDN_FL__S__lgt_24	;
self.final_score_25	:= 	woFDN_FL__S__lgt_25	;
self.final_score_26	:= 	woFDN_FL__S__lgt_26	;
self.final_score_27	:= 	woFDN_FL__S__lgt_27	;
self.final_score_28	:= 	woFDN_FL__S__lgt_28	;
self.final_score_29	:= 	woFDN_FL__S__lgt_29	;
self.final_score_30	:= 	woFDN_FL__S__lgt_30	;
self.final_score_31	:= 	woFDN_FL__S__lgt_31	;
self.final_score_32	:= 	woFDN_FL__S__lgt_32	;
self.final_score_33	:= 	woFDN_FL__S__lgt_33	;
self.final_score_34	:= 	woFDN_FL__S__lgt_34	;
self.final_score_35	:= 	woFDN_FL__S__lgt_35	;
self.final_score_36	:= 	woFDN_FL__S__lgt_36	;
self.final_score_37	:= 	woFDN_FL__S__lgt_37	;
self.final_score_38	:= 	woFDN_FL__S__lgt_38	;
self.final_score_39	:= 	woFDN_FL__S__lgt_39	;
self.final_score_40	:= 	woFDN_FL__S__lgt_40	;
self.final_score_41	:= 	woFDN_FL__S__lgt_41	;
self.final_score_42	:= 	woFDN_FL__S__lgt_42	;
self.final_score_43	:= 	woFDN_FL__S__lgt_43	;
self.final_score_44	:= 	woFDN_FL__S__lgt_44	;
self.final_score_45	:= 	woFDN_FL__S__lgt_45	;
self.final_score_46	:= 	woFDN_FL__S__lgt_46	;
self.final_score_47	:= 	woFDN_FL__S__lgt_47	;
self.final_score_48	:= 	woFDN_FL__S__lgt_48	;
self.final_score_49	:= 	woFDN_FL__S__lgt_49	;
self.final_score_50	:= 	woFDN_FL__S__lgt_50	;
self.final_score_51	:= 	woFDN_FL__S__lgt_51	;
self.final_score_52	:= 	woFDN_FL__S__lgt_52	;
self.final_score_53	:= 	woFDN_FL__S__lgt_53	;
self.final_score_54	:= 	woFDN_FL__S__lgt_54	;
self.final_score_55	:= 	woFDN_FL__S__lgt_55	;
self.final_score_56	:= 	woFDN_FL__S__lgt_56	;
self.final_score_57	:= 	woFDN_FL__S__lgt_57	;
self.final_score_58	:= 	woFDN_FL__S__lgt_58	;
self.final_score_59	:= 	woFDN_FL__S__lgt_59	;
self.final_score_60	:= 	woFDN_FL__S__lgt_60	;
self.final_score_61	:= 	woFDN_FL__S__lgt_61	;
self.final_score_62	:= 	woFDN_FL__S__lgt_62	;
self.final_score_63	:= 	woFDN_FL__S__lgt_63	;
self.final_score_64	:= 	woFDN_FL__S__lgt_64	;
self.final_score_65	:= 	woFDN_FL__S__lgt_65	;
self.final_score_66	:= 	woFDN_FL__S__lgt_66	;
self.final_score_67	:= 	woFDN_FL__S__lgt_67	;
self.final_score_68	:= 	woFDN_FL__S__lgt_68	;
self.final_score_69	:= 	woFDN_FL__S__lgt_69	;
self.final_score_70	:= 	woFDN_FL__S__lgt_70	;
self.final_score_71	:= 	woFDN_FL__S__lgt_71	;
self.final_score_72	:= 	woFDN_FL__S__lgt_72	;
self.final_score_73	:= 	woFDN_FL__S__lgt_73	;
self.final_score_74	:= 	woFDN_FL__S__lgt_74	;
self.final_score_75	:= 	woFDN_FL__S__lgt_75	;
self.final_score_76	:= 	woFDN_FL__S__lgt_76	;
self.final_score_77	:= 	woFDN_FL__S__lgt_77	;
self.final_score_78	:= 	woFDN_FL__S__lgt_78	;
self.final_score_79	:= 	woFDN_FL__S__lgt_79	;
self.final_score_80	:= 	woFDN_FL__S__lgt_80	;
self.final_score_81	:= 	woFDN_FL__S__lgt_81	;
self.final_score_82	:= 	woFDN_FL__S__lgt_82	;
self.final_score_83	:= 	woFDN_FL__S__lgt_83	;
self.final_score_84	:= 	woFDN_FL__S__lgt_84	;
self.final_score_85	:= 	woFDN_FL__S__lgt_85	;
self.final_score_86	:= 	woFDN_FL__S__lgt_86	;
self.final_score_87	:= 	woFDN_FL__S__lgt_87	;
self.final_score_88	:= 	woFDN_FL__S__lgt_88	;
self.final_score_89	:= 	woFDN_FL__S__lgt_89	;
self.final_score_90	:= 	woFDN_FL__S__lgt_90	;
self.final_score_91	:= 	woFDN_FL__S__lgt_91	;
self.final_score_92	:= 	woFDN_FL__S__lgt_92	;
self.final_score_93	:= 	woFDN_FL__S__lgt_93	;
self.final_score_94	:= 	woFDN_FL__S__lgt_94	;
self.final_score_95	:= 	woFDN_FL__S__lgt_95	;
self.final_score_96	:= 	woFDN_FL__S__lgt_96	;
self.final_score_97	:= 	woFDN_FL__S__lgt_97	;
self.final_score_98	:= 	woFDN_FL__S__lgt_98	;
self.final_score_99	:= 	woFDN_FL__S__lgt_99	;
self.final_score_100	:= 	woFDN_FL__S__lgt_100	;
self.final_score_101	:= 	woFDN_FL__S__lgt_101	;
self.final_score_102	:= 	woFDN_FL__S__lgt_102	;
self.final_score_103	:= 	woFDN_FL__S__lgt_103	;
self.final_score_104	:= 	woFDN_FL__S__lgt_104	;
self.final_score_105	:= 	woFDN_FL__S__lgt_105	;
self.final_score_106	:= 	woFDN_FL__S__lgt_106	;
self.final_score_107	:= 	woFDN_FL__S__lgt_107	;
self.final_score_108	:= 	woFDN_FL__S__lgt_108	;
self.final_score_109	:= 	woFDN_FL__S__lgt_109	;
self.final_score_110	:= 	woFDN_FL__S__lgt_110	;
self.final_score_111	:= 	woFDN_FL__S__lgt_111	;
self.final_score_112	:= 	woFDN_FL__S__lgt_112	;
self.final_score_113	:= 	woFDN_FL__S__lgt_113	;
self.final_score_114	:= 	woFDN_FL__S__lgt_114	;
self.final_score_115	:= 	woFDN_FL__S__lgt_115	;
self.final_score_116	:= 	woFDN_FL__S__lgt_116	;
self.final_score_117	:= 	woFDN_FL__S__lgt_117	;
self.final_score_118	:= 	woFDN_FL__S__lgt_118	;
self.final_score_119	:= 	woFDN_FL__S__lgt_119	;
self.final_score_120	:= 	woFDN_FL__S__lgt_120	;
self.final_score_121	:= 	woFDN_FL__S__lgt_121	;
self.final_score_122	:= 	woFDN_FL__S__lgt_122	;
self.final_score_123	:= 	woFDN_FL__S__lgt_123	;
self.final_score_124	:= 	woFDN_FL__S__lgt_124	;
self.final_score_125	:= 	woFDN_FL__S__lgt_125	;
self.final_score_126	:= 	woFDN_FL__S__lgt_126	;
self.final_score_127	:= 	woFDN_FL__S__lgt_127	;
self.final_score_128	:= 	woFDN_FL__S__lgt_128	;
self.final_score_129	:= 	woFDN_FL__S__lgt_129	;
self.final_score_130	:= 	woFDN_FL__S__lgt_130	;
self.final_score_131	:= 	woFDN_FL__S__lgt_131	;
self.final_score_132	:= 	woFDN_FL__S__lgt_132	;
self.final_score_133	:= 	woFDN_FL__S__lgt_133	;
self.final_score_134	:= 	woFDN_FL__S__lgt_134	;
self.final_score_135	:= 	woFDN_FL__S__lgt_135	;
self.final_score_136	:= 	woFDN_FL__S__lgt_136	;
self.final_score_137	:= 	woFDN_FL__S__lgt_137	;
self.final_score_138	:= 	woFDN_FL__S__lgt_138	;
self.final_score_139	:= 	woFDN_FL__S__lgt_139	;
self.final_score_140	:= 	woFDN_FL__S__lgt_140	;
self.final_score_141	:= 	woFDN_FL__S__lgt_141	;
self.final_score_142	:= 	woFDN_FL__S__lgt_142	;
self.final_score_143	:= 	woFDN_FL__S__lgt_143	;
self.final_score_144	:= 	woFDN_FL__S__lgt_144	;
self.final_score_145	:= 	woFDN_FL__S__lgt_145	;
self.final_score_146	:= 	woFDN_FL__S__lgt_146	;
// self.woFDN_submodel_lgt	:= 	woFDN_FL__S__lgt	;
self.FP3_woFDN_LGT		:= 	woFDN_FL__S__lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
