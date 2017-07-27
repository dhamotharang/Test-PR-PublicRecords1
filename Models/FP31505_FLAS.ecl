
export FP31505_FLAS( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   woFDN_FLA_S__lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FLA_S__lgt_1 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0431288035,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 51.15) => 0.2803104221,
      (c_fammar_p > 51.15) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0241375999,
         (f_varrisktype_i > 3.5) => 0.2621095181,
         (f_varrisktype_i = NULL) => 0.0459654359, 0.0459654359),
      (c_fammar_p = NULL) => -0.0363853074, 0.0714493552),
   (nf_seg_FraudPoint_3_0 = '') => -0.0153006626, -0.0153006626),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.1874858118,
   (f_inq_Communications_count_i > 0.5) => 0.5826761441,
   (f_inq_Communications_count_i = NULL) => 0.3288385251, 0.3288385251),
(f_inq_HighRiskCredit_count_i = NULL) => 0.3050346590, -0.0016766067);

// Tree: 2 
woFDN_FLA_S__lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1513638597,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0370168143,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1637336919,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0326441020, -0.0326441020),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0225818944, -0.0225818944),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0598900440,
   (f_rel_under500miles_cnt_d > 5.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.2091937645,
      (f_srchvelocityrisktype_i > 4.5) => 0.4518861985,
      (f_srchvelocityrisktype_i = NULL) => 0.3321579311, 0.3321579311),
   (f_rel_under500miles_cnt_d = NULL) => 0.1111038825, 0.2069046555),
(f_varrisktype_i = NULL) => 0.2009486335, -0.0076911719);

// Tree: 3 
woFDN_FLA_S__lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0388557032,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 28.75) => 0.0171869881,
      (c_famotf18_p > 28.75) => 0.1777432309,
      (c_famotf18_p = NULL) => -0.0385429368, 0.0321135743),
   (nf_seg_FraudPoint_3_0 = '') => -0.0213036249, -0.0213036249),
(f_inq_Communications_count_i > 0.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0362858094,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 0.1818362238,
      (f_inq_count_i > 8.5) => 0.3455875692,
      (f_inq_count_i = NULL) => 0.2324564530, 0.2324564530),
   (nf_seg_FraudPoint_3_0 = '') => 0.1145591953, 0.1145591953),
(f_inq_Communications_count_i = NULL) => 0.1293081745, -0.0071898799);

// Tree: 4 
woFDN_FLA_S__lgt_4 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.0907649823,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => -0.0337120508,
      (f_assocsuspicousidcount_i > 14.5) => 0.3860441473,
      (f_assocsuspicousidcount_i = NULL) => -0.0316783483, -0.0316783483),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0248659815, -0.0248659815),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0308332642,
      (f_assocrisktype_i > 4.5) => 0.1815869758,
      (f_assocrisktype_i = NULL) => 0.0694320406, 0.0694320406),
   (f_varrisktype_i > 4.5) => 0.2572888336,
   (f_varrisktype_i = NULL) => 0.0897783763, 0.0897783763),
(f_srchvelocityrisktype_i = NULL) => 0.1366215674, -0.0086519029);

// Tree: 5 
woFDN_FLA_S__lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
         map(
         (NULL < c_highinc and c_highinc <= 8.5) => 0.1451430176,
         (c_highinc > 8.5) => 0.0003432556,
         (c_highinc = NULL) => 0.0383312455, 0.0580420073),
      (r_F01_inp_addr_address_score_d > 95) => -0.0377684559,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0290455265, -0.0290455265),
   (k_inq_per_addr_i > 3.5) => 0.0855336052,
   (k_inq_per_addr_i = NULL) => -0.0186647126, -0.0186647126),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0508979945,
   (f_rel_felony_count_i > 0.5) => 0.2166677673,
   (f_rel_felony_count_i = NULL) => 0.0839810568, 0.0839810568),
(f_varrisktype_i = NULL) => 0.1011741847, -0.0061497581);

// Tree: 6 
woFDN_FLA_S__lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0322985693,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 66.15) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0955336752,
         (f_rel_felony_count_i > 2.5) => 0.3441537161,
         (f_rel_felony_count_i = NULL) => 0.1170193577, 0.1170193577),
      (c_fammar_p > 66.15) => 0.0095327031,
      (c_fammar_p = NULL) => 0.0215912119, 0.0421418592),
   (nf_seg_FraudPoint_3_0 = '') => -0.0173957890, -0.0173957890),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => 0.0946158000,
   (f_inq_count_i > 14.5) => 0.2244877386,
   (f_inq_count_i = NULL) => 0.1178187270, 0.1178187270),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0788108609, -0.0121595987);

// Tree: 7 
woFDN_FLA_S__lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.0678826639,
   (f_corrssnaddrcount_d > 2.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.15) => -0.0288485554,
      (c_famotf18_p > 29.15) => 0.0644978959,
      (c_famotf18_p = NULL) => -0.0524046327, -0.0226426567),
   (f_corrssnaddrcount_d = NULL) => -0.0141813013, -0.0141813013),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < c_employees and c_employees <= 38.5) => 0.2985940255,
   (c_employees > 38.5) => 0.0828572766,
   (c_employees = NULL) => 0.1242242746, 0.1242242746),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0361108554) => -0.0502568267,
   (f_add_input_nhood_VAC_pct_i > 0.0361108554) => 0.2235115063,
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0614406532, 0.0614406532), -0.0088862387);

// Tree: 8 
woFDN_FLA_S__lgt_8 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0313337580,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 22.15) => 
         map(
         (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 0.0085032563,
         (f_srchcomponentrisktype_i > 3.5) => 0.1951492510,
         (f_srchcomponentrisktype_i = NULL) => 0.0146305238, 0.0146305238),
      (c_famotf18_p > 22.15) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0650329653,
         (f_assocrisktype_i > 5.5) => 0.1969399250,
         (f_assocrisktype_i = NULL) => 0.0963749609, 0.0963749609),
      (c_famotf18_p = NULL) => -0.0512496928, 0.0269763352),
   (nf_seg_FraudPoint_3_0 = '') => -0.0164494404, -0.0164494404),
(f_inq_Communications_count_i > 1.5) => 0.1263431846,
(f_inq_Communications_count_i = NULL) => 0.0417612302, -0.0113647838);

// Tree: 9 
woFDN_FLA_S__lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 2.55) => 0.0286875047,
         (c_hh5_p > 2.55) => 0.2109568697,
         (c_hh5_p = NULL) => 0.1365612106, 0.1365612106),
      (r_F01_inp_addr_address_score_d > 75) => 0.0440673349,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0542121584, 0.0542121584),
   (c_fammar_p > 59.25) => -0.0211495497,
   (c_fammar_p = NULL) => -0.0369195018, -0.0105113574),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 15.5) => 0.1019326645,
   (f_rel_under500miles_cnt_d > 15.5) => 0.2214086644,
   (f_rel_under500miles_cnt_d = NULL) => 0.1369925733, 0.1369925733),
(f_inq_PrepaidCards_count_i = NULL) => 0.0988751830, -0.0054002844);

// Tree: 10 
woFDN_FLA_S__lgt_10 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134) => 0.0279716587,
         (f_prevaddrageoldest_d > 134) => 0.2146546416,
         (f_prevaddrageoldest_d = NULL) => 0.0595498747, 0.0595498747),
      (r_F01_inp_addr_address_score_d > 25) => -0.0212121816,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0170308885, -0.0170308885),
   (f_rel_felony_count_i > 1.5) => 0.1022695872,
   (f_rel_felony_count_i = NULL) => -0.0118069071, -0.0118069071),
(f_srchfraudsrchcount_i > 8.5) => 0.1121385878,
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0764573170,
   (f_addrs_per_ssn_i > 4.5) => 0.1695137353,
   (f_addrs_per_ssn_i = NULL) => 0.0349654674, 0.0349654674), -0.0077309088);

// Tree: 11 
woFDN_FLA_S__lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3222115721,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 61.5) => 0.0701313094,
      (r_I60_inq_comm_recency_d > 61.5) => 
         map(
         (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => -0.0227629542,
         (f_inq_PrepaidCards_count24_i > 0.5) => 0.1479267605,
         (f_inq_PrepaidCards_count24_i = NULL) => -0.0211475465, -0.0211475465),
      (r_I60_inq_comm_recency_d = NULL) => -0.0164385040, -0.0164385040),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0127324112, -0.0143556694),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => 0.1120705471,
   (c_unemp > 8.95) => 0.2986023990,
   (c_unemp = NULL) => 0.1292594890, 0.1292594890),
(k_inq_ssns_per_addr_i = NULL) => -0.0076758945, -0.0076758945);

// Tree: 12 
woFDN_FLA_S__lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2208503122,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 9.5) => -0.0182795764,
      (f_addrchangecrimediff_i > 9.5) => 0.0913826128,
      (f_addrchangecrimediff_i = NULL) => -0.0060204468, -0.0118709160),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0105748436, -0.0105748436),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1543424772,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0356588791,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0841352783, 0.0841352783),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0382844069,
   (f_addrs_per_ssn_i > 3.5) => 0.1531956440,
   (f_addrs_per_ssn_i = NULL) => 0.0606469527, 0.0606469527), -0.0072505465);

// Tree: 13 
woFDN_FLA_S__lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 51.45) => 0.0645017816,
   (c_fammar_p > 51.45) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
         map(
         (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.2106767342,
         (r_I60_inq_comm_recency_d > 549) => 0.0375530533,
         (r_I60_inq_comm_recency_d = NULL) => 0.0928274816, 0.0928274816),
      (r_D33_Eviction_Recency_d > 79.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72313) => 0.0992479701,
         (f_addrchangevaluediff_d > -72313) => -0.0249846577,
         (f_addrchangevaluediff_d = NULL) => -0.0043309955, -0.0186174690),
      (r_D33_Eviction_Recency_d = NULL) => -0.0169562027, -0.0169562027),
   (c_fammar_p = NULL) => -0.0492758967, -0.0109397557),
(f_assocsuspicousidcount_i > 13.5) => 0.1923249356,
(f_assocsuspicousidcount_i = NULL) => 0.0420230671, -0.0087463877);

// Tree: 14 
woFDN_FLA_S__lgt_14 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => 0.0946726394,
      (r_L79_adls_per_addr_c6_i > 1.5) => 0.2272099168,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.1612742863, 0.1612742863),
   (f_historical_count_d > 0.5) => 0.0426046023,
   (f_historical_count_d = NULL) => 0.1062576134, 0.1062576134),
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => -0.0200332142,
      (r_L79_adls_per_addr_c6_i > 4.5) => 0.0715710968,
      (r_L79_adls_per_addr_c6_i = NULL) => -0.0161238627, -0.0161238627),
   (f_srchcomponentrisktype_i > 1.5) => 0.0737365582,
   (f_srchcomponentrisktype_i = NULL) => -0.0101498647, -0.0101498647),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0227780102, -0.0064467603);

// Tree: 15 
woFDN_FLA_S__lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 61.05) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0311125573,
      (r_L79_adls_per_addr_c6_i > 4.5) => 0.1477592532,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0397018866, 0.0397018866),
   (k_comb_age_d > 68.5) => 0.2887878341,
   (k_comb_age_d = NULL) => 0.0510851756, 0.0510851756),
(c_fammar_p > 61.05) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0251180492,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 3.5) => 0.0208835938,
      (f_srchssnsrchcount_i > 3.5) => 0.1412146651,
      (f_srchssnsrchcount_i = NULL) => 0.0498300344, 0.0498300344),
   (f_varrisktype_i = NULL) => 0.0326874005, -0.0210088812),
(c_fammar_p = NULL) => -0.0246997404, -0.0094151716);

// Tree: 16 
woFDN_FLA_S__lgt_16 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 39.5) => 0.0129554433,
      (k_comb_age_d > 39.5) => 
         map(
         (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 3.5) => 0.2771601902,
         (f_componentcharrisktype_i > 3.5) => 0.0756804482,
         (f_componentcharrisktype_i = NULL) => 0.1342055161, 0.1342055161),
      (k_comb_age_d = NULL) => 0.0584242206, 0.0584242206),
   (r_F01_inp_addr_address_score_d > 25) => -0.0150033876,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0113195083, -0.0113195083),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0334706706,
   (f_rel_felony_count_i > 0.5) => 0.1095809640,
   (f_rel_felony_count_i = NULL) => 0.0484768136, 0.0484768136),
(f_varrisktype_i = NULL) => 0.0198768153, -0.0044121670);

// Tree: 17 
woFDN_FLA_S__lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 53.5) => 0.1319253989,
      (c_born_usa > 53.5) => 0.0102734487,
      (c_born_usa = NULL) => 0.0336164842, 0.0523863707),
   (f_corrssnaddrcount_d > 1.5) => -0.0235206420,
   (f_corrssnaddrcount_d = NULL) => -0.0013883215, -0.0195324009),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0372484168,
   (f_hh_payday_loan_users_i > 0.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 7.95) => 0.1625150888,
      (c_pop_65_74_p > 7.95) => -0.0208593422,
      (c_pop_65_74_p = NULL) => 0.1200055616, 0.1200055616),
   (f_hh_payday_loan_users_i = NULL) => 0.0505732134, 0.0505732134),
(k_inq_per_addr_i = NULL) => -0.0118061377, -0.0118061377);

// Tree: 18 
woFDN_FLA_S__lgt_18 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0195446637,
      (f_hh_collections_ct_i > 2.5) => 0.0491542282,
      (f_hh_collections_ct_i = NULL) => -0.0132529335, -0.0132529335),
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => 0.0243642448,
      (f_crim_rel_under500miles_cnt_i > 2.5) => 0.1194771630,
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0488761039, 0.0488761039),
   (f_phones_per_addr_curr_i = NULL) => -0.0076239099, -0.0076239099),
(r_D33_eviction_count_i > 2.5) => 0.1288604601,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0765562853,
   (f_addrs_per_ssn_i > 3.5) => 0.1131109171,
   (f_addrs_per_ssn_i = NULL) => 0.0216048107, 0.0216048107), -0.0059409764);

// Tree: 19 
woFDN_FLA_S__lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 2.5) => -0.0092170765,
   (k_inq_per_addr_i > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 62.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1784393397,
         (r_C10_M_Hdr_FS_d > 7.5) => 0.0242365388,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0295655440, 0.0295655440),
      (k_comb_age_d > 62.5) => 0.1929668997,
      (k_comb_age_d = NULL) => 0.0431275278, 0.0431275278),
   (k_inq_per_addr_i = NULL) => -0.0008500207, -0.0008500207),
(f_inq_PrepaidCards_count_i > 1.5) => 0.1350733643,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 91.5) => -0.0933367762,
   (c_burglary > 91.5) => 0.0912100839,
   (c_burglary = NULL) => 0.0005843937, 0.0005843937), 0.0005457075);

// Tree: 20 
woFDN_FLA_S__lgt_20 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0171361519,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 1.5) => 0.1287527428,
      (f_addrchangeecontrajindex_d > 1.5) => 0.0148481402,
      (f_addrchangeecontrajindex_d = NULL) => 0.0999884640, 0.0469661683),
   (k_inq_per_addr_i = NULL) => -0.0120186401, -0.0120186401),
(f_divrisktype_i > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -580) => 0.1576777002,
   (f_addrchangeincomediff_d > -580) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.0984706536,
      (f_prevaddrstatus_i > 2.5) => 0.0106680076,
      (f_prevaddrstatus_i = NULL) => -0.0033938402, 0.0305967210),
   (f_addrchangeincomediff_d = NULL) => 0.1013583238, 0.0525227395),
(f_divrisktype_i = NULL) => 0.0219489164, -0.0027582126);

// Tree: 21 
woFDN_FLA_S__lgt_21 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 155.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 5.5) => 0.0569537986,
      (f_rel_criminal_count_i > 5.5) => 0.1702602310,
      (f_rel_criminal_count_i = NULL) => 0.0708538442, 0.0708538442),
   (c_relig_indx > 155.5) => -0.0211851595,
   (c_relig_indx = NULL) => -0.0068251027, 0.0436549446),
(f_corrssnaddrcount_d > 2.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 147.5) => -0.0254384095,
   (c_bel_edu > 147.5) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 0.0224943019,
      (r_D32_criminal_count_i > 2.5) => 0.1515255083,
      (r_D32_criminal_count_i = NULL) => 0.0309297560, 0.0309297560),
   (c_bel_edu = NULL) => -0.0286403490, -0.0152769640),
(f_corrssnaddrcount_d = NULL) => -0.0037542549, -0.0097472250);

// Tree: 22 
woFDN_FLA_S__lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0236355252,
   (f_hh_lienholders_i > 0.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => 0.0082280094,
      (f_corrrisktype_i > 7.5) => 0.0767153744,
      (f_corrrisktype_i = NULL) => 0.0199974927, 0.0199974927),
   (f_hh_lienholders_i = NULL) => -0.0105033285, -0.0105033285),
(f_assocrisktype_i > 8.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 0.2140527109,
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 70) => 0.1549661630,
      (r_F01_inp_addr_address_score_d > 70) => 0.0420930901,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0535344152, 0.0535344152),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0756191471, 0.0756191471),
(f_assocrisktype_i = NULL) => -0.0026621167, -0.0063821001);

// Tree: 23 
woFDN_FLA_S__lgt_23 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1018007473,
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 2.5) => 0.0435857811,
         (f_assocrisktype_i > 2.5) => 0.2512245708,
         (f_assocrisktype_i = NULL) => 0.0832471229, 0.0832471229),
      (r_C21_M_Bureau_ADL_FS_d > 7.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0133195239,
         (k_comb_age_d > 70.5) => 0.0867893566,
         (k_comb_age_d = NULL) => -0.0083078671, -0.0083078671),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0063294613, -0.0063294613),
   (r_D33_eviction_count_i > 3.5) => 0.1286423468,
   (r_D33_eviction_count_i = NULL) => -0.0054935545, -0.0054935545),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0204083045, -0.0040293566);

// Tree: 24 
woFDN_FLA_S__lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => -0.0162280640,
   (c_unemp > 8.95) => 
      map(
      (NULL < f_inputaddractivephonelist_d and f_inputaddractivephonelist_d <= 0.5) => 0.1248160478,
      (f_inputaddractivephonelist_d > 0.5) => 0.0005145673,
      (f_inputaddractivephonelist_d = NULL) => 0.0707719259, 0.0707719259),
   (c_unemp = NULL) => -0.0202888498, -0.0124071242),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => 0.0147095168,
   (f_srchvelocityrisktype_i > 2.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 13.75) => 0.0417479231,
      (c_famotf18_p > 13.75) => 0.1157530506,
      (c_famotf18_p = NULL) => 0.0732968602, 0.0732968602),
   (f_srchvelocityrisktype_i = NULL) => 0.0425547191, 0.0425547191),
(k_inq_per_addr_i = NULL) => -0.0064884897, -0.0064884897);

// Tree: 25 
woFDN_FLA_S__lgt_25 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0165265552,
(f_assocrisktype_i > 3.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0053833652,
   (f_sourcerisktype_i > 4.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 110.5) => 0.0251141001,
      (f_prevaddrcartheftindex_i > 110.5) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
            map(
            (NULL < c_occunit_p and c_occunit_p <= 87.55) => 0.1874479077,
            (c_occunit_p > 87.55) => 0.0611025738,
            (c_occunit_p = NULL) => 0.0882319400, 0.0882319400),
         (f_phones_per_addr_curr_i > 9.5) => 0.2063187429,
         (f_phones_per_addr_curr_i = NULL) => 0.1084125950, 0.1084125950),
      (f_prevaddrcartheftindex_i = NULL) => 0.0632764338, 0.0632764338),
   (f_sourcerisktype_i = NULL) => 0.0294200753, 0.0294200753),
(f_assocrisktype_i = NULL) => 0.0099734540, -0.0050302855);

// Tree: 26 
woFDN_FLA_S__lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33412) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 26.35) => 0.0400425240,
      (c_hh3_p > 26.35) => 0.1963113602,
      (c_hh3_p = NULL) => -0.0003022387, 0.0435745984),
   (f_curraddrmedianincome_d > 33412) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -63311.5) => 0.0682826264,
      (f_addrchangevaluediff_d > -63311.5) => -0.0132293480,
      (f_addrchangevaluediff_d = NULL) => -0.0034035168, -0.0096387234),
   (f_curraddrmedianincome_d = NULL) => -0.0035621053, -0.0035621053),
(r_D30_Derog_Count_i > 11.5) => 0.1245022243,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 96) => -0.0501690533,
   (c_burglary > 96) => 0.0807796992,
   (c_burglary = NULL) => 0.0098991818, 0.0098991818), -0.0017057246);

// Tree: 27 
woFDN_FLA_S__lgt_27 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 46.15) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1312148297) => 0.0359318496,
      (f_add_curr_nhood_VAC_pct_i > 0.1312148297) => 
         map(
         (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3292805956) => 0.2638098222,
         (f_add_input_mobility_index_i > 0.3292805956) => 0.0214435290,
         (f_add_input_mobility_index_i = NULL) => 0.1565680995, 0.1565680995),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0556026956, 0.0556026956),
   (c_fammar_p > 46.15) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0214337402,
      (k_inq_ssns_per_addr_i > 1.5) => 0.0361877112,
      (k_inq_ssns_per_addr_i = NULL) => -0.0140783609, -0.0140783609),
   (c_fammar_p = NULL) => -0.0156466999, -0.0101213542),
(r_D33_eviction_count_i > 0.5) => 0.0734556013,
(r_D33_eviction_count_i = NULL) => 0.0264886125, -0.0066516269);

// Tree: 28 
woFDN_FLA_S__lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1456826883,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 0.5) => 0.1857381716,
         (f_rel_under25miles_cnt_d > 0.5) => 0.0301699749,
         (f_rel_under25miles_cnt_d = NULL) => 0.0499246666, 0.0499246666),
      (f_corrssnaddrcount_d > 1.5) => -0.0102066692,
      (f_corrssnaddrcount_d = NULL) => -0.0070925687, -0.0070925687),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0062198482, -0.0062198482),
(r_D33_eviction_count_i > 2.5) => 0.1074951515,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 110.5) => -0.0635637638,
   (c_cartheft > 110.5) => 0.0968811629,
   (c_cartheft = NULL) => 0.0080634356, 0.0080634356), -0.0048577145);

// Tree: 29 
woFDN_FLA_S__lgt_29 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 157.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 0.0616948818,
   (f_corrssnaddrcount_d > 1.5) => -0.0251914424,
   (f_corrssnaddrcount_d = NULL) => -0.0218849351, -0.0218849351),
(r_A50_pb_average_dollars_d > 157.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 9.75) => -0.0028223766,
      (c_hh6_p > 9.75) => 0.1359737396,
      (c_hh6_p = NULL) => -0.0130199382, 0.0024087017),
   (f_crim_rel_under25miles_cnt_i > 1.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 105.5) => 0.0080112778,
      (c_unempl > 105.5) => 0.1015782406,
      (c_unempl = NULL) => 0.0552563003, 0.0552563003),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0111134271, 0.0136612290),
(r_A50_pb_average_dollars_d = NULL) => -0.0017045526, -0.0066552718);

// Tree: 30 
woFDN_FLA_S__lgt_30 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 92) => 0.1632769730,
   (r_D32_Mos_Since_Fel_LS_d > 92) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 10698.5) => -0.0171064659,
         (f_addrchangeincomediff_d > 10698.5) => 0.0561205553,
         (f_addrchangeincomediff_d = NULL) => -0.0026031006, -0.0116742043),
      (f_srchaddrsrchcount_i > 14.5) => 
         map(
         (NULL < c_popover25 and c_popover25 <= 613) => 0.1710154878,
         (c_popover25 > 613) => 0.0277683972,
         (c_popover25 = NULL) => 0.0487922239, 0.0487922239),
      (f_srchaddrsrchcount_i = NULL) => -0.0097185084, -0.0097185084),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0088894566, -0.0088894566),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1301788065,
(f_inq_PrepaidCards_count_i = NULL) => -0.0044801224, -0.0082800909);

// Tree: 31 
woFDN_FLA_S__lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.35) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1243039055,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0128303431,
         (k_comb_age_d > 67.5) => 0.0657461267,
         (k_comb_age_d = NULL) => -0.0071222402, -0.0071222402),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0064652247, -0.0064652247),
   (c_unemp > 8.35) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 207.35) => 0.1389158275,
      (c_cpiall > 207.35) => 0.0305089006,
      (c_cpiall = NULL) => 0.0477968158, 0.0477968158),
   (c_unemp = NULL) => -0.0346201320, -0.0034718872),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1530621118,
(f_inq_PrepaidCards_count_i = NULL) => 0.0073412248, -0.0027164231);

// Tree: 32 
woFDN_FLA_S__lgt_32 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => -0.0087950388,
(f_phones_per_addr_curr_i > 7.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.1029544903,
      (r_D33_Eviction_Recency_d > 549) => 0.0248919839,
      (r_D33_Eviction_Recency_d = NULL) => 0.0293820981, 0.0293820981),
   (f_inq_Communications_count_i > 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 7.85) => 0.1462175049,
      (c_construction > 7.85) => 0.0015883881,
      (c_construction = NULL) => 0.0939903238, 0.0939903238),
   (f_inq_Communications_count_i = NULL) => 0.0345136947, 0.0345136947),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0694531491,
   (r_S66_adlperssn_count_i > 1.5) => 0.0672481633,
   (r_S66_adlperssn_count_i = NULL) => 0.0130016108, 0.0130016108), -0.0023886445);

// Tree: 33 
woFDN_FLA_S__lgt_33 := map(
(NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0213588937,
(f_crim_rel_under100miles_cnt_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 34044) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 21.55) => 0.0901244842,
         (c_hh3_p > 21.55) => 0.2332772489,
         (c_hh3_p = NULL) => 0.1194590671, 0.1194590671),
      (f_curraddrmedianincome_d > 34044) => 0.0411823201,
      (f_curraddrmedianincome_d = NULL) => 0.0534781109, 0.0534781109),
   (r_C12_Num_NonDerogs_d > 2.5) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 6.5) => -0.0045265231,
      (r_D32_criminal_count_i > 6.5) => 0.1160917278,
      (r_D32_criminal_count_i = NULL) => -0.0009883877, -0.0009883877),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0143498791, 0.0143498791),
(f_crim_rel_under100miles_cnt_i = NULL) => 0.0095070430, -0.0043992615);

// Tree: 34 
woFDN_FLA_S__lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1058533749,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 78.5) => -0.0051541930,
   (r_pb_order_freq_d > 78.5) => -0.0268281823,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 0.0078489140,
      (r_L79_adls_per_addr_c6_i > 3.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 13.4) => 
            map(
            (NULL < c_preschl and c_preschl <= 141.5) => 0.2603333055,
            (c_preschl > 141.5) => 0.0588003390,
            (c_preschl = NULL) => 0.1580628449, 0.1580628449),
         (c_high_ed > 13.4) => 0.0494396229,
         (c_high_ed = NULL) => 0.0792664912, 0.0792664912),
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0155585926, 0.0155585926), -0.0036007797),
(r_C10_M_Hdr_FS_d = NULL) => -0.0089375363, -0.0029929653);

// Tree: 35 
woFDN_FLA_S__lgt_35 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 32.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 83.5) => -0.0320646377,
      (r_C13_max_lres_d > 83.5) => 0.0648071764,
      (r_C13_max_lres_d = NULL) => 0.0278756448, 0.0278756448),
   (c_born_usa > 32.5) => -0.0212493925,
   (c_born_usa = NULL) => 0.0145886510, -0.0107424146),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 8.05) => 0.0182657690,
      (c_hh7p_p > 8.05) => 0.1379832124,
      (c_hh7p_p = NULL) => 0.0235529747, 0.0235529747),
   (k_comb_age_d > 68.5) => 0.1916525883,
   (k_comb_age_d = NULL) => 0.0293285491, 0.0293285491),
(f_srchvelocityrisktype_i = NULL) => 0.0019074316, -0.0053960518);

// Tree: 36 
woFDN_FLA_S__lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 8.5) => -0.0232143116,
   (f_crim_rel_under500miles_cnt_i > 8.5) => 0.0923590295,
   (f_crim_rel_under500miles_cnt_i = NULL) => 0.0415401412, -0.0207754604),
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 0.0099848055,
      (f_inq_PrepaidCards_count24_i > 0.5) => 0.1202491288,
      (f_inq_PrepaidCards_count24_i = NULL) => 0.0118657684, 0.0118657684),
   (k_inq_per_addr_i > 6.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 102.5) => 0.1434710431,
      (c_for_sale > 102.5) => 0.0290026237,
      (c_for_sale = NULL) => 0.0777576912, 0.0777576912),
   (k_inq_per_addr_i = NULL) => 0.0153956928, 0.0153956928),
(f_hh_criminals_i = NULL) => -0.0134272077, -0.0090583226);

// Tree: 37 
woFDN_FLA_S__lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 185.5) => -0.0118724949,
   (c_unempl > 185.5) => 0.0990815618,
   (c_unempl = NULL) => -0.0115537551, -0.0100095154),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6742) => 0.0207029315,
   (f_addrchangeincomediff_d > 6742) => 0.1044890837,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 116.55) => -0.0153881401,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 116.55) => 0.2002818017,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0264152768, 0.0276356587), 0.0251473201),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0520881523,
   (f_addrs_per_ssn_i > 5.5) => 0.0776852318,
   (f_addrs_per_ssn_i = NULL) => 0.0045047520, 0.0045047520), 0.0010458562);

// Tree: 38 
woFDN_FLA_S__lgt_38 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4) => 0.0491795344,
   (f_srchvelocityrisktype_i > 4) => 0.1980424253,
   (f_srchvelocityrisktype_i = NULL) => 0.0883539794, 0.0883539794),
(r_D32_Mos_Since_Crim_LS_d > 9.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0138432717,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 0.5) => 0.1714191283,
      (f_corrssnnamecount_d > 0.5) => 0.0183627460,
      (f_corrssnnamecount_d = NULL) => 0.0226127790, 0.0226127790),
   (f_inq_Other_count_i = NULL) => -0.0056629327, -0.0056629327),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1262) => 0.0694255278,
   (c_popover18 > 1262) => -0.0625965020,
   (c_popover18 = NULL) => 0.0010569766, 0.0010569766), -0.0040513849);

// Tree: 39 
woFDN_FLA_S__lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0055955368,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 100.5) => 
            map(
            (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.3031537243,
            (f_curraddractivephonelist_d > 0.5) => 0.1035668237,
            (f_curraddractivephonelist_d = NULL) => 0.2091334488, 0.2091334488),
         (c_medi_indx > 100.5) => 0.0281699219,
         (c_medi_indx = NULL) => 0.1112790972, 0.1112790972),
      (f_inq_count_i > 2.5) => 0.0132071400,
      (f_inq_count_i = NULL) => 0.0315408667, 0.0315408667),
   (k_comb_age_d > 68.5) => 0.2811416109,
   (k_comb_age_d = NULL) => 0.0422145828, 0.0422145828),
(k_inq_per_ssn_i = NULL) => 0.0001409237, 0.0001409237);

// Tree: 40 
woFDN_FLA_S__lgt_40 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 28.5) => 0.0033631232,
      (r_pb_order_freq_d > 28.5) => -0.0306434166,
      (r_pb_order_freq_d = NULL) => 0.0111791051, -0.0071594830),
   (f_addrchangecrimediff_i > 98.5) => 0.1064355499,
   (f_addrchangecrimediff_i = NULL) => 0.0056795019, -0.0036253131),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 2.5) => -0.0235778507,
   (f_rel_ageover30_count_d > 2.5) => 0.2360089694,
   (f_rel_ageover30_count_d = NULL) => 0.1340971067, 0.1340971067),
(k_comb_age_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0743266417,
   (k_nap_lname_verd_d > 0.5) => -0.0553996754,
   (k_nap_lname_verd_d = NULL) => 0.0135539526, 0.0135539526), -0.0019658480);

// Tree: 41 
woFDN_FLA_S__lgt_41 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 36.5) => -0.0054592761,
(r_pb_order_freq_d > 36.5) => -0.0304258633,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 26.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 0.1211940944,
      (r_D32_Mos_Since_Crim_LS_d > 14.5) => 0.0024972213,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0058335366, 0.0058335366),
   (f_rel_homeover50_count_d > 26.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.95) => 0.0394126792,
      (c_pop_35_44_p > 16.95) => 0.2016233360,
      (c_pop_35_44_p = NULL) => 0.0891818580, 0.0891818580),
   (f_rel_homeover50_count_d = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 180836) => 0.1442738482,
      (r_L80_Inp_AVM_AutoVal_d > 180836) => 0.0350678060,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0212495885, 0.0224810223), 0.0098276401), -0.0087193012);

// Tree: 42 
woFDN_FLA_S__lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 222) => 
   map(
   (NULL < c_rape and c_rape <= 98.5) => 0.2050777843,
   (c_rape > 98.5) => -0.0042857936,
   (c_rape = NULL) => 0.1061059111, 0.1061059111),
(r_D32_Mos_Since_Fel_LS_d > 222) => 
   map(
   (NULL < c_employees and c_employees <= 40.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.75) => 0.0239390618,
      (c_unemp > 9.75) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 34.5) => 0.1674581637,
         (f_prevaddrlenofres_d > 34.5) => 0.0242911051,
         (f_prevaddrlenofres_d = NULL) => 0.0847187597, 0.0847187597),
      (c_unemp = NULL) => 0.0301377860, 0.0301377860),
   (c_employees > 40.5) => -0.0094991982,
   (c_employees = NULL) => -0.0369414679, -0.0052981334),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0099959988, -0.0043757765);

// Tree: 43 
woFDN_FLA_S__lgt_43 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -108.5) => 0.1569822321,
(f_addrchangecrimediff_i > -108.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 0.1137831097,
      (f_attr_arrest_recency_d > 99.5) => -0.0051037812,
      (f_attr_arrest_recency_d = NULL) => -0.0039768913, -0.0039768913),
   (f_assocsuspicousidcount_i > 13.5) => 0.0956349723,
   (f_assocsuspicousidcount_i = NULL) => -0.0030717911, -0.0030717911),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => -0.0056671593,
   (f_srchunvrfddobcount_i > 0.5) => 0.1079388155,
   (f_srchunvrfddobcount_i = NULL) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 8.4) => -0.0773904311,
      (c_famotf18_p > 8.4) => 0.0537456385,
      (c_famotf18_p = NULL) => -0.0059681075, -0.0059681075), -0.0018339567), -0.0021136977);

// Tree: 44 
woFDN_FLA_S__lgt_44 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => -0.0363650883,
      (r_C14_Addr_Stability_v2_d > 3.5) => 0.0370808260,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0059579959, 0.0059579959),
   (f_util_add_input_conv_n > 0.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -16076) => 0.1533746089,
      (f_addrchangevaluediff_d > -16076) => 0.0469727019,
      (f_addrchangevaluediff_d = NULL) => 0.1136338486, 0.0786417771),
   (f_util_add_input_conv_n = NULL) => 0.0329759298, 0.0329759298),
(f_corrssnaddrcount_d > 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1060581518,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0096155631,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0090569982, -0.0090569982),
(f_corrssnaddrcount_d = NULL) => 0.0047358671, -0.0050196884);

// Tree: 45 
woFDN_FLA_S__lgt_45 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 3.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 312) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 0.0099037787,
         (f_addrchangecrimediff_i > 98.5) => 0.1126655870,
         (f_addrchangecrimediff_i = NULL) => -0.0064883695, 0.0075059087),
      (r_C13_Curr_Addr_LRes_d > 312) => 0.1969785306,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0109379889, 0.0109379889),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < c_pop_85p_p and c_pop_85p_p <= 0.85) => 0.1219224832,
      (c_pop_85p_p > 0.85) => 0.0240609636,
      (c_pop_85p_p = NULL) => 0.0704722534, 0.0704722534),
   (f_inq_Communications_count_i = NULL) => 0.0168852524, 0.0168852524),
(f_corrssnaddrcount_d > 3.5) => -0.0110202334,
(f_corrssnaddrcount_d = NULL) => 0.0053447665, -0.0023599214);

// Tree: 46 
woFDN_FLA_S__lgt_46 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1098087286,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 222.35) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0141618276,
      (f_srchcomponentrisktype_i > 1.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 2.55) => 0.0834738009,
         (c_hval_750k_p > 2.55) => -0.0296885268,
         (c_hval_750k_p = NULL) => 0.0399927094, 0.0399927094),
      (f_srchcomponentrisktype_i = NULL) => -0.0105817025, -0.0105817025),
   (c_housingcpi > 222.35) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 71703.5) => 0.1725412372,
      (r_A46_Curr_AVM_AutoVal_d > 71703.5) => 0.0270362649,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0189916807, 0.0269847826),
   (c_housingcpi = NULL) => -0.0008692114, -0.0014208883),
(f_attr_arrest_recency_d = NULL) => -0.0169385109, -0.0007936020);

// Tree: 47 
woFDN_FLA_S__lgt_47 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0110193777,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_idrisktype_i and f_idrisktype_i <= 2.5) => 0.0200192545,
      (f_idrisktype_i > 2.5) => 0.1582422022,
      (f_idrisktype_i = NULL) => 0.0249241992, 0.0249241992),
   (f_rel_felony_count_i = NULL) => -0.0057743005, -0.0057743005),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 23.1) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 58.95) => 0.0153933608,
      (c_low_ed > 58.95) => 0.1652482836,
      (c_low_ed = NULL) => 0.0406935426, 0.0406935426),
   (c_hval_500k_p > 23.1) => 0.2972271273,
   (c_hval_500k_p = NULL) => 0.0648378800, 0.0648378800),
(k_comb_age_d = NULL) => -0.0014346201, -0.0013530259);

// Tree: 48 
woFDN_FLA_S__lgt_48 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 124896) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.1845962287,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 0.0229049560,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0274560114, 0.0274560114),
(r_L80_Inp_AVM_AutoVal_d > 124896) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 7.5) => 0.1440172007,
   (f_M_Bureau_ADL_FS_all_d > 7.5) => -0.0067183746,
   (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0048748667, -0.0048748667),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 101.75) => -0.0026918154,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 101.75) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45990) => 0.2176612162,
      (f_curraddrmedianincome_d > 45990) => 0.0365485795,
      (f_curraddrmedianincome_d = NULL) => 0.0726487335, 0.0726487335),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0157299192, -0.0102817935), -0.0023808753);

// Tree: 49 
woFDN_FLA_S__lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => 
         map(
         (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => -0.0026411123,
         (f_bus_addr_match_count_d > 52.5) => 0.2044879723,
         (f_bus_addr_match_count_d = NULL) => -0.0012780622, -0.0012780622),
      (f_hh_criminals_i > 3.5) => 0.1350698258,
      (f_hh_criminals_i = NULL) => 0.0002713456, 0.0002713456),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 20.5) => 0.1610024055,
      (r_C13_max_lres_d > 20.5) => 0.0374114321,
      (r_C13_max_lres_d = NULL) => 0.0540442360, 0.0540442360),
   (f_varrisktype_i = NULL) => 0.0026561998, 0.0026561998),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0732232093,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0151766471, -0.0003188264);

// Tree: 50 
woFDN_FLA_S__lgt_50 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.0736756830,
(r_C21_M_Bureau_ADL_FS_d > 7.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 158.5) => -0.0083741819,
   (f_prevaddrageoldest_d > 158.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 14.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 101) => 0.2923373488,
         (c_robbery > 101) => 0.0650765072,
         (c_robbery = NULL) => 0.1506185094, 0.1506185094),
      (c_born_usa > 14.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 176.5) => 0.2020796077,
         (r_C10_M_Hdr_FS_d > 176.5) => 0.0163565517,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0212782850, 0.0212782850),
      (c_born_usa = NULL) => 0.0373974346, 0.0298203047),
   (f_prevaddrageoldest_d = NULL) => 0.0003018746, 0.0003018746),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0312399857, 0.0020101691);

// Tree: 51 
woFDN_FLA_S__lgt_51 := map(
(NULL < c_employees and c_employees <= 71.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0045605334,
   (f_corrrisktype_i > 6.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 0.0147086363,
      (f_rel_criminal_count_i > 1.5) => 0.1029925756,
      (f_rel_criminal_count_i = NULL) => 0.0512185832, 0.0512185832),
   (f_corrrisktype_i = NULL) => 0.0198045374, 0.0198045374),
(c_employees > 71.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 6.3) => -0.0278996462,
      (c_hval_175k_p > 6.3) => 0.1542707037,
      (c_hval_175k_p = NULL) => 0.0720522272, 0.0720522272),
   (r_D33_Eviction_Recency_d > 48) => -0.0110308418,
   (r_D33_Eviction_Recency_d = NULL) => -0.0360832571, -0.0102907918),
(c_employees = NULL) => -0.0120117322, -0.0040510427);

// Tree: 52 
woFDN_FLA_S__lgt_52 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 19.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 191.5) => -0.0082923145,
      (c_unempl > 191.5) => 0.1110929857,
      (c_unempl = NULL) => 0.0107482068, -0.0070376949),
   (f_srchaddrsrchcount_i > 19.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 64.5) => -0.0176237297,
      (C_OWNOCC_P > 64.5) => 0.1634180602,
      (C_OWNOCC_P = NULL) => 0.0904803607, 0.0904803607),
   (f_srchaddrsrchcount_i = NULL) => -0.0058503254, -0.0058503254),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.65) => 0.0225468204,
   (c_pop_6_11_p > 10.65) => 0.1160344779,
   (c_pop_6_11_p = NULL) => 0.0359022000, 0.0359022000),
(f_phones_per_addr_curr_i = NULL) => 0.0102257749, -0.0018920360);

// Tree: 53 
woFDN_FLA_S__lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 129.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0149840843,
   (r_D32_felony_count_i > 0.5) => 0.0769634215,
   (r_D32_felony_count_i = NULL) => 0.0027693939, -0.0136255422),
(c_easiqlife > 129.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 133) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 0.1470034433,
         (r_C21_M_Bureau_ADL_FS_d > 20.5) => 0.0089392540,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0362246669, 0.0362246669),
      (c_blue_empl > 133) => 0.2150470614,
      (c_blue_empl = NULL) => 0.0691049136, 0.0691049136),
   (f_prevaddrlenofres_d > 1.5) => 0.0155143900,
   (f_prevaddrlenofres_d = NULL) => 0.0190870916, 0.0190870916),
(c_easiqlife = NULL) => -0.0128502384, -0.0015057313);

// Tree: 54 
woFDN_FLA_S__lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1549192405,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0138413922,
   (f_corrrisktype_i > 6.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310) => 
         map(
         (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 0.0054615350,
         (f_inq_Communications_count_i > 1.5) => 
            map(
            (NULL < c_rest_indx and c_rest_indx <= 104.5) => 0.1249486522,
            (c_rest_indx > 104.5) => -0.0178346481,
            (c_rest_indx = NULL) => 0.0651232470, 0.0651232470),
         (f_inq_Communications_count_i = NULL) => 0.0081218892, 0.0081218892),
      (r_C13_Curr_Addr_LRes_d > 310) => 0.1549686674,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0113415993, 0.0113415993),
   (f_corrrisktype_i = NULL) => -0.0054102239, -0.0054102239),
(f_attr_arrest_recency_d = NULL) => 0.0137773349, -0.0046128454);

// Tree: 55 
woFDN_FLA_S__lgt_55 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 48.5) => 0.1936954920,
   (c_no_teens > 48.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 3.15) => -0.0672654511,
      (c_femdiv_p > 3.15) => 0.0674752858,
      (c_femdiv_p = NULL) => 0.0175327732, 0.0175327732),
   (c_no_teens = NULL) => 0.0488505899, 0.0488505899),
(r_C10_M_Hdr_FS_d > 11.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 65.5) => -0.0105048361,
   (k_comb_age_d > 65.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 56.6) => 0.0274549295,
      (c_rnt500_p > 56.6) => 0.2522769756,
      (c_rnt500_p = NULL) => 0.0422075776, 0.0422075776),
   (k_comb_age_d = NULL) => -0.0057343454, -0.0057343454),
(r_C10_M_Hdr_FS_d = NULL) => -0.0051945826, -0.0043476860);

// Tree: 56 
woFDN_FLA_S__lgt_56 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00563981495) => 0.1679217696,
   (f_add_curr_nhood_MFD_pct_i > 0.00563981495) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 162.5) => 0.0079665305,
      (c_rich_wht > 162.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0300184948) => 0.0363970530,
         (f_add_curr_nhood_VAC_pct_i > 0.0300184948) => 0.2161210791,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1091966585, 0.1091966585),
      (c_rich_wht = NULL) => 0.0272833907, 0.0272833907),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0131117473, 0.0318706922),
(f_corrssnaddrcount_d > 2.5) => -0.0044457744,
(f_corrssnaddrcount_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0622605891,
   (f_addrs_per_ssn_i > 5.5) => 0.0559933261,
   (f_addrs_per_ssn_i = NULL) => -0.0042706884, -0.0042706884), -0.0010488853);

// Tree: 57 
woFDN_FLA_S__lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 19.5) => 0.1750649225,
         (r_C13_max_lres_d > 19.5) => 0.0140163066,
         (r_C13_max_lres_d = NULL) => 0.0802632549, 0.0802632549),
      (f_M_Bureau_ADL_FS_noTU_d > 7.5) => -0.0038362261,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0028358020, -0.0028358020),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0594338949,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0053063175, -0.0053063175),
(r_D30_Derog_Count_i > 11.5) => 0.0641176379,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 83.5) => 0.0632699338,
   (c_very_rich > 83.5) => -0.0702996409,
   (c_very_rich = NULL) => -0.0130555375, -0.0130555375), -0.0044802591);

// Tree: 58 
woFDN_FLA_S__lgt_58 := map(
(NULL < c_hh1_p and c_hh1_p <= 25.95) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.33923651595) => 0.0099116554,
   (f_add_curr_nhood_MFD_pct_i > 0.33923651595) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 64.75) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -2.5) => 0.1398888214,
         (f_addrchangecrimediff_i > -2.5) => 0.0175387690,
         (f_addrchangecrimediff_i = NULL) => 0.0502540832, 0.0358032392),
      (c_rnt1000_p > 64.75) => 0.2915632124,
      (c_rnt1000_p = NULL) => 0.0466681488, 0.0466681488),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0113311100, 0.0108638190),
(c_hh1_p > 25.95) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => -0.0221760498,
   (f_hh_collections_ct_i > 4.5) => 0.1336847826,
   (f_hh_collections_ct_i = NULL) => -0.0204671786, -0.0204671786),
(c_hh1_p = NULL) => -0.0343202823, -0.0032549790);

// Tree: 59 
woFDN_FLA_S__lgt_59 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => -0.0155331648,
   (r_L79_adls_per_addr_curr_i > 3.5) => 
      map(
      (NULL < r_nas_addr_verd_d and r_nas_addr_verd_d <= 0.5) => 0.0669583765,
      (r_nas_addr_verd_d > 0.5) => 0.0122080968,
      (r_nas_addr_verd_d = NULL) => 0.0143439027, 0.0143439027),
   (r_L79_adls_per_addr_curr_i = NULL) => 
      map(
      (NULL < c_assault and c_assault <= 89) => -0.0695629211,
      (c_assault > 89) => 0.0562097838,
      (c_assault = NULL) => -0.0090056928, -0.0090056928), -0.0065986813),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0079812465,
   (f_addrs_per_ssn_i > 5.5) => 0.2736785441,
   (f_addrs_per_ssn_i = NULL) => 0.1295735349, 0.1295735349),
(f_nae_nothing_found_i = NULL) => -0.0047522784, -0.0047522784);

// Tree: 60 
woFDN_FLA_S__lgt_60 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 50) => 0.2346494487,
   (f_curraddrmurderindex_i > 50) => 
      map(
      (NULL < c_professional and c_professional <= 5.2) => 0.0768995833,
      (c_professional > 5.2) => -0.0870612450,
      (c_professional = NULL) => 0.0175517988, 0.0175517988),
   (f_curraddrmurderindex_i = NULL) => 0.0745276527, 0.0745276527),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => -0.0044306168,
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 37.85) => 0.1405452917,
      (C_OWNOCC_P > 37.85) => 0.0097754107,
      (C_OWNOCC_P = NULL) => 0.0548380049, 0.0548380049),
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0037160170, -0.0037160170),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0149415951, -0.0024466485);

// Tree: 61 
woFDN_FLA_S__lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 8.95) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.01919518585) => 0.0068325441,
      (f_add_curr_nhood_BUS_pct_i > 0.01919518585) => 0.1285689355,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0847985476, 0.0847985476),
   (c_low_hval > 8.95) => -0.0481390033,
   (c_low_hval = NULL) => 0.0514273928, 0.0514273928),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0032106451,
   (c_lar_fam > 181.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.0119866390,
      (k_inq_per_ssn_i > 0.5) => 0.2088024105,
      (k_inq_per_ssn_i = NULL) => 0.0999573247, 0.0999573247),
   (c_lar_fam = NULL) => -0.0278404935, -0.0026355224),
(r_D33_Eviction_Recency_d = NULL) => -0.0199066254, -0.0017354888);

// Tree: 62 
woFDN_FLA_S__lgt_62 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0061368583,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 12.65) => 0.2399367752,
   (c_hh2_p > 12.65) => 
      map(
      (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 24.55) => -0.0229494600,
         (c_high_ed > 24.55) => 0.0549680925,
         (c_high_ed = NULL) => 0.0204412464, 0.0204412464),
      (r_F01_inp_addr_not_verified_i > 0.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 9.85) => 0.0077176354,
         (C_INC_35K_P > 9.85) => 0.1503357260,
         (C_INC_35K_P = NULL) => 0.0775713940, 0.0775713940),
      (r_F01_inp_addr_not_verified_i = NULL) => 0.0233212641, 0.0233212641),
   (c_hh2_p = NULL) => -0.0068272698, 0.0266247405),
(f_prevaddrageoldest_d = NULL) => 0.0399827264, 0.0020275362);

// Tree: 63 
woFDN_FLA_S__lgt_63 := map(
(NULL < f_mos_liens_rel_SC_fseen_d and f_mos_liens_rel_SC_fseen_d <= 273) => -0.0971876401,
(f_mos_liens_rel_SC_fseen_d > 273) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0032163182,
   (c_hval_200k_p > 16.45) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 3.5) => 0.0203777519,
      (f_assocsuspicousidcount_i > 3.5) => 
         map(
         (NULL < c_hval_60k_p and c_hval_60k_p <= 0.1) => 0.0662409763,
         (c_hval_60k_p > 0.1) => 0.2702965658,
         (c_hval_60k_p = NULL) => 0.1160106322, 0.1160106322),
      (f_assocsuspicousidcount_i = NULL) => 0.0386999393, 0.0386999393),
   (c_hval_200k_p = NULL) => 0.0218507344, 0.0009270005),
(f_mos_liens_rel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0606225562,
   (c_pop_35_44_p > 16.05) => 0.0449955212,
   (c_pop_35_44_p = NULL) => -0.0133949606, -0.0133949606), -0.0002152935);

// Tree: 64 
woFDN_FLA_S__lgt_64 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.0371045660,
   (k_estimated_income_d > 28500) => -0.0080941333,
   (k_estimated_income_d = NULL) => -0.0052276825, -0.0052276825),
(f_prevaddrageoldest_d > 271.5) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 6.05) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 0.5) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 7.45) => 0.0368388163,
         (c_pop_75_84_p > 7.45) => 0.2912487635,
         (c_pop_75_84_p = NULL) => 0.0686400597, 0.0686400597),
      (r_C14_addrs_5yr_i > 0.5) => 0.2231646430,
      (r_C14_addrs_5yr_i = NULL) => 0.0935842796, 0.0935842796),
   (c_pop_65_74_p > 6.05) => 0.0004633421,
   (c_pop_65_74_p = NULL) => 0.0422102286, 0.0422102286),
(f_prevaddrageoldest_d = NULL) => -0.0024311343, -0.0011856868);

// Tree: 65 
woFDN_FLA_S__lgt_65 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0049337005,
(f_prevaddrageoldest_d > 151.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.2485531157,
      (f_adl_per_email_i > 0.5) => -0.0786972641,
      (f_adl_per_email_i = NULL) => 0.0193494432, 0.0220766117),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < c_assault and c_assault <= 77.5) => -0.0051613421,
      (c_assault > 77.5) => 0.1558611922,
      (c_assault = NULL) => 0.0829658558, 0.0829658558),
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0252887988, 0.0252887988),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0457874093,
   (f_addrs_per_ssn_i > 3.5) => 0.0731324293,
   (f_addrs_per_ssn_i = NULL) => 0.0136725100, 0.0136725100), 0.0023750830);

// Tree: 66 
woFDN_FLA_S__lgt_66 := map(
(NULL < c_span_lang and c_span_lang <= 132.5) => -0.0113566383,
(c_span_lang > 132.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1182) => 0.0077074837,
   (f_addrchangeincomediff_d > 1182) => 
      map(
      (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 0.0143151304,
      (f_bus_name_nover_i > 0.5) => 0.1581179833,
      (f_bus_name_nover_i = NULL) => 0.0740068806, 0.0740068806),
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 11.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 1.5) => 0.1151970627,
         (f_prevaddrageoldest_d > 1.5) => 0.0049533143,
         (f_prevaddrageoldest_d = NULL) => 0.0198380355, 0.0198380355),
      (f_srchaddrsrchcount_i > 11.5) => 0.1325889727,
      (f_srchaddrsrchcount_i = NULL) => 0.0093612687, 0.0262468101), 0.0146335850),
(c_span_lang = NULL) => -0.0063802652, -0.0014646750);

// Tree: 67 
woFDN_FLA_S__lgt_67 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 0.0557626730,
   (f_corrssnaddrcount_d > 1.5) => -0.0351133489,
   (f_corrssnaddrcount_d = NULL) => -0.0299965510, -0.0299965510),
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 19.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.2505340322) => -0.0103477645,
      (f_add_input_mobility_index_i > 0.2505340322) => 0.1423951139,
      (f_add_input_mobility_index_i = NULL) => 0.0886124102, 0.0886124102),
   (k_comb_age_d > 19.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 19.45) => 0.0003982000,
      (c_pop_55_64_p > 19.45) => 0.0798264154,
      (c_pop_55_64_p = NULL) => -0.0125856996, 0.0044142703),
   (k_comb_age_d = NULL) => 0.0278349520, 0.0057202078),
(f_addrs_per_ssn_i = NULL) => -0.0004517382, -0.0004517382);

// Tree: 68 
woFDN_FLA_S__lgt_68 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 80.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 4.5) => -0.0045474637,
   (k_inq_per_ssn_i > 4.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 62.25) => 0.0620312090,
      (c_low_ed > 62.25) => -0.0706713572,
      (c_low_ed = NULL) => 0.0441093146, 0.0441093146),
   (k_inq_per_ssn_i = NULL) => -0.0019215050, -0.0019215050),
(k_comb_age_d > 80.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1394.5) => 0.1715450528,
   (c_popover18 > 1394.5) => -0.0520019343,
   (c_popover18 = NULL) => 0.0946562802, 0.0946562802),
(k_comb_age_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0886737660,
   (f_addrs_per_ssn_i > 3.5) => 0.0418728661,
   (f_addrs_per_ssn_i = NULL) => -0.0244203455, -0.0244203455), -0.0009227527);

// Tree: 69 
woFDN_FLA_S__lgt_69 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => -0.0065538520,
   (f_inq_Communications_count24_i > 2.5) => 0.0884988767,
   (f_inq_Communications_count24_i = NULL) => -0.0060480454, -0.0060480454),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 16.1) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 57.5) => -0.0265370198,
      (r_C13_max_lres_d > 57.5) => 
         map(
         (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 1.5) => -0.0017299029,
         (k_inq_addrs_per_ssn_i > 1.5) => 0.1578845082,
         (k_inq_addrs_per_ssn_i = NULL) => 0.0707001660, 0.0707001660),
      (r_C13_max_lres_d = NULL) => 0.0132266404, 0.0132266404),
   (C_INC_25K_P > 16.1) => 0.1302873488,
   (C_INC_25K_P = NULL) => 0.0312621565, 0.0312621565),
(f_varrisktype_i = NULL) => -0.0158179646, -0.0050961731);

// Tree: 70 
woFDN_FLA_S__lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => -0.0076746291,
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 54.9) => 0.0156781894,
      (c_low_ed > 54.9) => 
         map(
         (NULL < c_rnt1500_p and c_rnt1500_p <= 7) => 0.2916892136,
         (c_rnt1500_p > 7) => 0.0108119961,
         (c_rnt1500_p = NULL) => 0.1423941160, 0.1423941160),
      (c_low_ed = NULL) => 0.0329152823, 0.0329152823),
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00758090935) => 0.0392206789,
      (f_add_curr_nhood_VAC_pct_i > 0.00758090935) => 0.2202218892,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1364934382, 0.1364934382),
   (k_inq_per_ssn_i = NULL) => 0.0488173229, 0.0488173229),
(c_hval_750k_p = NULL) => 0.0176316322, -0.0028448596);

// Tree: 71 
woFDN_FLA_S__lgt_71 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 0.85) => -0.0067700183,
(c_hh7p_p > 0.85) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 0.0159404810,
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.03796423945) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 19.25) => 
            map(
            (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.1) => 0.1900311842,
            (c_pop_65_74_p > 4.1) => -0.0292940556,
            (c_pop_65_74_p = NULL) => 0.0694023023, 0.0694023023),
         (c_famotf18_p > 19.25) => 0.2328460993,
         (c_famotf18_p = NULL) => 0.1232748387, 0.1232748387),
      (f_add_input_nhood_BUS_pct_i > 0.03796423945) => 0.0218434736,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0643638820, 0.0643638820),
   (f_phones_per_addr_curr_i = NULL) => 0.0207739928, 0.0207739928),
(c_hh7p_p = NULL) => -0.0216203203, 0.0025125637);

// Tree: 72 
woFDN_FLA_S__lgt_72 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 72.5) => 0.0050736268,
      (k_comb_age_d > 72.5) => 
         map(
         (NULL < c_unempl and c_unempl <= 73.5) => -0.0257642320,
         (c_unempl > 73.5) => 0.2123592648,
         (c_unempl = NULL) => 0.1161228257, 0.1161228257),
      (k_comb_age_d = NULL) => 0.0086064566, 0.0086064566),
   (r_C12_Num_NonDerogs_d > 3.5) => -0.0174782102,
   (r_C12_Num_NonDerogs_d = NULL) => -0.0041625969, -0.0041625969),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0926230392,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0969726677,
   (r_S66_adlperssn_count_i > 1.5) => 0.0242133830,
   (r_S66_adlperssn_count_i = NULL) => -0.0259652161, -0.0259652161), -0.0039782135);

// Tree: 73 
woFDN_FLA_S__lgt_73 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.15) => -0.0073622115,
   (c_pop_12_17_p > 10.15) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.1338356503,
      (r_C10_M_Hdr_FS_d > 13.5) => 0.0194704950,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0218313324, 0.0218313324),
   (c_pop_12_17_p = NULL) => 0.0001974308, -0.0002117641),
(f_hh_collections_ct_i > 4.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 11.7) => -0.0449272926,
   (c_pop_45_54_p > 11.7) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 12.75) => 0.0353010048,
      (c_pop_25_34_p > 12.75) => 0.2329247539,
      (c_pop_25_34_p = NULL) => 0.1220279738, 0.1220279738),
   (c_pop_45_54_p = NULL) => 0.0661099420, 0.0661099420),
(f_hh_collections_ct_i = NULL) => 0.0004727209, 0.0009239822);

// Tree: 74 
woFDN_FLA_S__lgt_74 := map(
(NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 1.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0057605487,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 7.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.05) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3526274965) => 0.0558789113,
            (f_add_curr_mobility_index_i > 0.3526274965) => -0.0110518358,
            (f_add_curr_mobility_index_i = NULL) => 0.0372371260, 0.0372371260),
         (c_pop_55_64_p > 17.05) => 0.2563314869,
         (c_pop_55_64_p = NULL) => 0.0559688576, 0.0559688576),
      (f_rel_homeover300_count_d > 7.5) => -0.0648296501,
      (f_rel_homeover300_count_d = NULL) => 0.0399762531, 0.0399762531),
   (f_util_adl_count_n = NULL) => -0.0028685519, -0.0028685519),
(f_vardobcountnew_i > 1.5) => 0.1012732029,
(f_vardobcountnew_i = NULL) => 0.0238971371, -0.0018278953);

// Tree: 75 
woFDN_FLA_S__lgt_75 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 84) => 
   map(
   (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0071765503,
   (f_prevaddroccupantowned_i > 0.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 138.5) => 
         map(
         (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 0.0318164415,
         (k_inq_ssns_per_addr_i > 1.5) => 
            map(
            (NULL < c_blue_empl and c_blue_empl <= 105.5) => 0.1996924616,
            (c_blue_empl > 105.5) => 0.0289213661,
            (c_blue_empl = NULL) => 0.1226187813, 0.1226187813),
         (k_inq_ssns_per_addr_i = NULL) => 0.0494767933, 0.0494767933),
      (c_work_home > 138.5) => -0.0273824889,
      (c_work_home = NULL) => 0.0225674473, 0.0225674473),
   (f_prevaddroccupantowned_i = NULL) => -0.0214291117, -0.0051660934),
(f_bus_addr_match_count_d > 84) => 0.1854853708,
(f_bus_addr_match_count_d = NULL) => -0.0043995798, -0.0043995798);

// Tree: 76 
woFDN_FLA_S__lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0117368253,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => -0.0035376492,
         (f_prevaddrlenofres_d > 123.5) => 
            map(
            (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0431089643,
            (f_rel_homeover500_count_d > 3.5) => 0.1957984251,
            (f_rel_homeover500_count_d = NULL) => 0.0677793139, 0.0677793139),
         (f_prevaddrlenofres_d = NULL) => 0.0159992107, 0.0159992107),
      (f_inq_Communications_count24_i > 1.5) => 0.1159655263,
      (f_inq_Communications_count24_i = NULL) => 0.0181236768, 0.0181236768),
   (f_nae_nothing_found_i > 0.5) => 0.2279086758,
   (f_nae_nothing_found_i = NULL) => 0.0214024989, 0.0214024989),
(c_rnt1250_p = NULL) => 0.0005202172, -0.0022758491);

// Tree: 77 
woFDN_FLA_S__lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => -0.0157056546,
   (c_pop_35_44_p > 14.75) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 0.0043989279,
      (f_divrisktype_i > 1.5) => 
         map(
         (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 
            map(
            (NULL < c_health and c_health <= 18.3) => 0.0637833507,
            (c_health > 18.3) => 0.2244447497,
            (c_health = NULL) => 0.0961599824, 0.0961599824),
         (f_prevaddrstatus_i > 2.5) => 0.0220362898,
         (f_prevaddrstatus_i = NULL) => 0.0368797348, 0.0518343351),
      (f_divrisktype_i = NULL) => 0.0395607178, 0.0112389017),
   (c_pop_35_44_p = NULL) => -0.0021359919, -0.0021359919),
(c_transport > 29.05) => 0.1149825620,
(c_transport = NULL) => -0.0033433199, -0.0002350723);

// Tree: 78 
woFDN_FLA_S__lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0049474389,
      (f_corrrisktype_i > 7.5) => 
         map(
         (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 125.5) => 0.0179306277,
         (f_curraddrburglaryindex_i > 125.5) => 
            map(
            (NULL < c_employees and c_employees <= 40.5) => 0.1610628088,
            (c_employees > 40.5) => 0.0527032075,
            (c_employees = NULL) => 0.0683243909, 0.0683243909),
         (f_curraddrburglaryindex_i = NULL) => 0.0311046921, 0.0311046921),
      (f_corrrisktype_i = NULL) => 0.0015725947, 0.0015725947),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0568708987,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0248121750, -0.0007354784),
(r_L77_Add_PO_Box_i > 0.5) => -0.1025605517,
(r_L77_Add_PO_Box_i = NULL) => -0.0031115305, -0.0031115305);

// Tree: 79 
woFDN_FLA_S__lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 
      map(
      (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
         map(
         (NULL < c_hval_40k_p and c_hval_40k_p <= 3.6) => 
            map(
            (NULL < c_lux_prod and c_lux_prod <= 132.5) => 0.0912786114,
            (c_lux_prod > 132.5) => -0.0132703113,
            (c_lux_prod = NULL) => 0.0425683179, 0.0425683179),
         (c_hval_40k_p > 3.6) => -0.0792756227,
         (c_hval_40k_p = NULL) => 0.0173213753, 0.0173213753),
      (r_F01_inp_addr_not_verified_i > 0.5) => 0.1239421914,
      (r_F01_inp_addr_not_verified_i = NULL) => 0.0282393468, 0.0282393468),
   (r_I61_inq_collection_recency_d > 9) => -0.0055568492,
   (r_I61_inq_collection_recency_d = NULL) => -0.0038705469, -0.0038705469),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1021576415,
(f_inq_PrepaidCards_count_i = NULL) => -0.0071847699, -0.0034810980);

// Tree: 80 
woFDN_FLA_S__lgt_80 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.45) => -0.0782081824,
   (C_OWNOCC_P > 1.45) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0009584331,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 100.5) => -0.0231951961,
         (c_easiqlife > 100.5) => 0.1142031373,
         (c_easiqlife = NULL) => 0.0547613051, 0.0547613051),
      (r_D33_eviction_count_i = NULL) => -0.0003075771, -0.0003075771),
   (C_OWNOCC_P = NULL) => 0.0376092232, -0.0002880985),
(f_rel_felony_count_i > 4.5) => 0.0795456977,
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 8.75) => 0.0536460770,
   (C_INC_35K_P > 8.75) => -0.0545912364,
   (C_INC_35K_P = NULL) => 0.0057534604, 0.0057534604), 0.0001771834);

// Tree: 81 
woFDN_FLA_S__lgt_81 := map(
(NULL < c_easiqlife and c_easiqlife <= 142.5) => -0.0143203204,
(c_easiqlife > 142.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 126.5) => 0.0023045160,
   (r_C13_Curr_Addr_LRes_d > 126.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 76.5) => 
         map(
         (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
            map(
            (NULL < C_RENTOCC_P and C_RENTOCC_P <= 62.05) => 0.0310721859,
            (C_RENTOCC_P > 62.05) => 0.2051033729,
            (C_RENTOCC_P = NULL) => 0.0435029849, 0.0435029849),
         (r_L70_Add_Standardized_i > 0.5) => 0.2097810987,
         (r_L70_Add_Standardized_i = NULL) => 0.0556332626, 0.0556332626),
      (k_comb_age_d > 76.5) => 0.2419625632,
      (k_comb_age_d = NULL) => 0.0657211547, 0.0657211547),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0191691213, 0.0191691213),
(c_easiqlife = NULL) => 0.0123798365, -0.0042995156);

// Tree: 82 
woFDN_FLA_S__lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0035024791,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 46.5) => -0.0320336540,
      (f_mos_inq_banko_cm_fseen_d > 46.5) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 6.65) => -0.0176005785,
         (c_pop_6_11_p > 6.65) => 
            map(
            (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 60.5) => 0.0546383010,
            (r_C13_Curr_Addr_LRes_d > 60.5) => 0.2058556452,
            (r_C13_Curr_Addr_LRes_d = NULL) => 0.1254464225, 0.1254464225),
         (c_pop_6_11_p = NULL) => 0.0842294900, 0.0842294900),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0413523021, 0.0413523021),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0024886086, -0.0024886086),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0696918656,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0041987705, -0.0029201551);

// Tree: 83 
woFDN_FLA_S__lgt_83 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => -0.0005879760,
(f_srchcomponentrisktype_i > 2.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.14194323535) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 9.55) => 
         map(
         (NULL < c_rape and c_rape <= 99.5) => 0.0652875904,
         (c_rape > 99.5) => -0.1552678957,
         (c_rape = NULL) => -0.0281681240, -0.0281681240),
      (c_hval_150k_p > 9.55) => 0.1270555797,
      (c_hval_150k_p = NULL) => 0.0211804523, 0.0211804523),
   (f_add_curr_nhood_MFD_pct_i > 0.14194323535) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 16.65) => 0.0406765226,
      (c_hh4_p > 16.65) => 0.1789411921,
      (c_hh4_p = NULL) => 0.0826286231, 0.0826286231),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0340767626, 0.0384838535),
(f_srchcomponentrisktype_i = NULL) => -0.0030448609, 0.0009640807);

// Tree: 84 
woFDN_FLA_S__lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 308.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => -0.0030911063,
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < c_no_move and c_no_move <= 65.5) => 0.1766920302,
      (c_no_move > 65.5) => -0.0126757459,
      (c_no_move = NULL) => 0.0811702316, 0.0811702316),
   (f_hh_lienholders_i = NULL) => -0.0022643160, -0.0022643160),
(r_C13_Curr_Addr_LRes_d > 308.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 159.9) => 0.0290539996,
   (c_oldhouse > 159.9) => 0.1534470514,
   (c_oldhouse = NULL) => 0.0506428764, 0.0506428764),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 9.95) => -0.0326836008,
   (C_INC_125K_P > 9.95) => 0.0763939627,
   (C_INC_125K_P = NULL) => 0.0153844780, 0.0153844780), 0.0009849035);

// Tree: 85 
woFDN_FLA_S__lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0091179289,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0113605077,
      (f_hh_lienholders_i > 0.5) => 
         map(
         (NULL < c_health and c_health <= 2.45) => 0.1241388843,
         (c_health > 2.45) => 
            map(
            (NULL < f_historical_count_d and f_historical_count_d <= 4.5) => 0.0574792439,
            (f_historical_count_d > 4.5) => -0.0860607170,
            (f_historical_count_d = NULL) => 0.0224098216, 0.0224098216),
         (c_health = NULL) => 0.0510600474, 0.0510600474),
      (f_hh_lienholders_i = NULL) => 0.0095456946, 0.0095456946),
   (r_F01_inp_addr_not_verified_i > 0.5) => 0.1276961679,
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0162363263, 0.0162363263),
(f_util_adl_count_n = NULL) => 0.0088360502, -0.0058380157);

// Tree: 86 
woFDN_FLA_S__lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => -0.0033337336,
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 128.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 222.95) => -0.0167388450,
      (c_cpiall > 222.95) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 92.65) => 0.2269155088,
         (c_occunit_p > 92.65) => -0.0108730450,
         (c_occunit_p = NULL) => 0.0899493018, 0.0899493018),
      (c_cpiall = NULL) => 0.0115754190, 0.0115754190),
   (f_curraddrcrimeindex_i > 128.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 37.15) => 0.0433125056,
      (C_OWNOCC_P > 37.15) => 0.1720392364,
      (C_OWNOCC_P = NULL) => 0.1007668092, 0.1007668092),
   (f_curraddrcrimeindex_i = NULL) => 0.0357652051, 0.0357652051),
(f_phones_per_addr_curr_i = NULL) => -0.0193111515, -0.0014493042);

// Tree: 87 
woFDN_FLA_S__lgt_87 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 32.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2586) => -0.0073874860,
      (f_addrchangeincomediff_d > 2586) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 102) => -0.0181862822,
         (f_curraddrcartheftindex_i > 102) => 0.0955748159,
         (f_curraddrcartheftindex_i = NULL) => 0.0343015116, 0.0343015116),
      (f_addrchangeincomediff_d = NULL) => -0.0081151845, -0.0058075602),
   (f_rel_under500miles_cnt_d > 32.5) => -0.0723687458,
   (f_rel_under500miles_cnt_d = NULL) => -0.0000700871, -0.0065589108),
(f_hh_collections_ct_i > 5.5) => 0.0930188186,
(f_hh_collections_ct_i = NULL) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 27.15) => 0.0650996724,
   (c_fammar18_p > 27.15) => -0.0333545398,
   (c_fammar18_p = NULL) => 0.0080127762, 0.0080127762), -0.0058097175);

// Tree: 88 
woFDN_FLA_S__lgt_88 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 42.5) => 0.0288259445,
   (c_exp_prod > 42.5) => -0.0061233985,
   (c_exp_prod = NULL) => -0.0467383936, -0.0032969815),
(k_inq_per_ssn_i > 3.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => 0.0051419003,
      (r_D34_UnRel_Lien60_Count_i > 0.5) => 0.1011694386,
      (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0134433464, 0.0134433464),
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 0.1367495542,
      (f_current_count_d > 0.5) => -0.0101979240,
      (f_current_count_d = NULL) => 0.0853693170, 0.0853693170),
   (f_varrisktype_i = NULL) => 0.0237390559, 0.0237390559),
(k_inq_per_ssn_i = NULL) => -0.0011677737, -0.0011677737);

// Tree: 89 
woFDN_FLA_S__lgt_89 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0002434121,
   (r_D33_eviction_count_i > 2.5) => 0.0726210421,
   (r_D33_eviction_count_i = NULL) => 0.0007782068, 0.0007782068),
(f_srchfraudsrchcount_i > 4.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 18.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 164.5) => -0.0504592605,
      (c_robbery > 164.5) => 0.0289315366,
      (c_robbery = NULL) => -0.0390503692, -0.0390503692),
   (f_phones_per_addr_curr_i > 18.5) => 0.0576713047,
   (f_phones_per_addr_curr_i = NULL) => -0.0309031872, -0.0309031872),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1173.5) => 0.0703065477,
   (c_popover25 > 1173.5) => -0.0602096265,
   (c_popover25 = NULL) => 0.0010059243, 0.0010059243), -0.0015323682);

// Tree: 90 
woFDN_FLA_S__lgt_90 := map(
(NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 2746.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0015784575,
   (r_D32_felony_count_i > 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 229) => 0.1537614791,
      (f_M_Bureau_ADL_FS_all_d > 229) => -0.0191074276,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0726189311, 0.0726189311),
   (r_D32_felony_count_i = NULL) => -0.0006754093, -0.0006754093),
(f_liens_unrel_CJ_total_amt_i > 2746.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.23833242805) => 0.0170229296,
   (f_add_input_mobility_index_i > 0.23833242805) => 
      map(
      (NULL < c_armforce and c_armforce <= 124.5) => -0.1083449151,
      (c_armforce > 124.5) => 0.0245717315,
      (c_armforce = NULL) => -0.0782171419, -0.0782171419),
   (f_add_input_mobility_index_i = NULL) => -0.0406576771, -0.0406576771),
(f_liens_unrel_CJ_total_amt_i = NULL) => -0.0286857867, -0.0024867039);

// Tree: 91 
woFDN_FLA_S__lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.45) => 0.0280456238,
   (c_retired > 15.45) => 0.2002948022,
   (c_retired = NULL) => 0.0739250779, 0.0739250779),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 15.8) => 0.0980034594,
   (c_fammar_p > 15.8) => 
      map(
      (NULL < c_food and c_food <= 65.55) => 
         map(
         (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0125791449,
         (f_srchfraudsrchcountmo_i > 0.5) => 0.0406802383,
         (f_srchfraudsrchcountmo_i = NULL) => -0.0106896666, -0.0106896666),
      (c_food > 65.55) => 0.0547472448,
      (c_food = NULL) => -0.0083267728, -0.0083267728),
   (c_fammar_p = NULL) => -0.0032127077, -0.0077225561),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0077763309, -0.0061920785);

// Tree: 92 
woFDN_FLA_S__lgt_92 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.05) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 26.15) => -0.0053844510,
   (C_INC_25K_P > 26.15) => 0.0869992968,
   (C_INC_25K_P = NULL) => -0.0045432303, -0.0045432303),
(c_hh3_p > 23.05) => 
   map(
   (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 114.5) => 0.0026835696,
         (c_no_labfor > 114.5) => 0.0717444929,
         (c_no_labfor = NULL) => 0.0191468899, 0.0191468899),
      (k_comb_age_d > 69.5) => 0.1486638637,
      (k_comb_age_d = NULL) => 0.0254227390, 0.0254227390),
   (f_acc_damage_amt_total_i > 275) => 0.1909945773,
   (f_acc_damage_amt_total_i = NULL) => 0.0298814317, 0.0298814317),
(c_hh3_p = NULL) => -0.0429321290, -0.0001709930);

// Tree: 93 
woFDN_FLA_S__lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 0.0017125538,
      (r_D33_eviction_count_i > 3.5) => 0.0821778411,
      (r_D33_eviction_count_i = NULL) => 0.0021877832, 0.0021877832),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.1619544007,
      (f_prevaddrstatus_i > 2.5) => 0.0723858243,
      (f_prevaddrstatus_i = NULL) => 0.0275139302, 0.0851178987),
   (f_curraddrcartheftindex_i = NULL) => -0.0029933017, 0.0036730753),
(c_cartheft > 189.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 33.25) => -0.1083546310,
   (c_hh1_p > 33.25) => -0.0287151191,
   (c_hh1_p = NULL) => -0.0504173705, -0.0504173705),
(c_cartheft = NULL) => -0.0002960938, 0.0018350969);

// Tree: 94 
woFDN_FLA_S__lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < c_child and c_child <= 5.55) => -0.0824310558,
   (c_child > 5.55) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 8.35) => 0.0230905687,
         (c_hh7p_p > 8.35) => 0.1481516301,
         (c_hh7p_p = NULL) => 0.0274349779, 0.0274349779),
      (f_hh_members_ct_d > 1.5) => -0.0044523860,
      (f_hh_members_ct_d = NULL) => 0.0091542154, 0.0014126547),
   (c_child = NULL) => -0.0004259332, -0.0004259332),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => 0.1179000788,
   (f_rel_incomeover75_count_d > 0.5) => -0.0101514868,
   (f_rel_incomeover75_count_d = NULL) => 0.0648055273, 0.0648055273),
(c_famotf18_p = NULL) => 0.0132253378, 0.0005525182);

// Tree: 95 
woFDN_FLA_S__lgt_95 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0537406354,
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 57.5) => 
         map(
         (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 0.5) => 0.0436913333,
         (f_hh_workers_paw_d > 0.5) => 0.1618730616,
         (f_hh_workers_paw_d = NULL) => 0.1052239687, 0.1052239687),
      (c_born_usa > 57.5) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 3.5) => -0.0573316492,
         (f_phones_per_addr_curr_i > 3.5) => 0.0829069074,
         (f_phones_per_addr_curr_i = NULL) => -0.0088541234, -0.0088541234),
      (c_born_usa = NULL) => 0.0399213153, 0.0399213153),
   (f_corrssnaddrcount_d > 1.5) => -0.0042412048,
   (f_corrssnaddrcount_d = NULL) => -0.0031106788, -0.0031106788),
(f_corrssnaddrcount_d = NULL) => -0.0223420368, -0.0044909640);

// Tree: 96 
woFDN_FLA_S__lgt_96 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45599.5) => 
   map(
   (NULL < c_construction and c_construction <= 45.5) => 0.0157668674,
   (c_construction > 45.5) => 0.1681322821,
   (c_construction = NULL) => -0.0192115917, 0.0169824076),
(f_curraddrmedianincome_d > 45599.5) => 
   map(
   (NULL < c_transport and c_transport <= 29.05) => -0.0125453177,
   (c_transport > 29.05) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => 0.2202150761,
      (f_rel_incomeover50_count_d > 4.5) => 0.0106730193,
      (f_rel_incomeover50_count_d = NULL) => 0.0927908523, 0.0927908523),
   (c_transport = NULL) => -0.0108704793, -0.0108704793),
(f_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.26693968695) => -0.0739065103,
   (f_add_input_mobility_index_i > 0.26693968695) => 0.0382335652,
   (f_add_input_mobility_index_i = NULL) => -0.0101026743, -0.0101026743), -0.0040455826);

// Tree: 97 
woFDN_FLA_S__lgt_97 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0000215499,
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1413353895,
      (r_A50_pb_average_dollars_d > 99) => -0.0070828264,
      (r_A50_pb_average_dollars_d = NULL) => 0.0604896946, 0.0604896946),
   (r_D33_eviction_count_i = NULL) => 
      map(
      (NULL < c_health and c_health <= 9.05) => 0.0364177861,
      (c_health > 9.05) => -0.0825311988,
      (c_health = NULL) => -0.0183197999, -0.0183197999), 0.0004414645),
(k_inq_adls_per_addr_i > 3.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 3.5) => -0.0361150571,
   (f_rel_criminal_count_i > 3.5) => -0.1025173583,
   (f_rel_criminal_count_i = NULL) => -0.0557515353, -0.0557515353),
(k_inq_adls_per_addr_i = NULL) => -0.0007014440, -0.0007014440);

// Tree: 98 
woFDN_FLA_S__lgt_98 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0045546402,
(f_rel_homeover500_count_d > 14.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.24094392385) => 0.2048847761,
   (f_add_input_mobility_index_i > 0.24094392385) => -0.0312694145,
   (f_add_input_mobility_index_i = NULL) => 0.0813913003, 0.0813913003),
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 172.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 56.5) => 0.1993598576,
      (c_no_labfor > 56.5) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 8.35) => -0.0229261368,
         (c_pop_18_24_p > 8.35) => 0.0865420047,
         (c_pop_18_24_p = NULL) => 0.0304564754, 0.0304564754),
      (c_no_labfor = NULL) => 0.0726823210, 0.0726823210),
   (c_no_teens > 172.5) => -0.1074133134,
   (c_no_teens = NULL) => 0.0249018465, 0.0249018465), -0.0031125098);

// Tree: 99 
woFDN_FLA_S__lgt_99 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.38111460565) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 235.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0029253190,
      (f_nae_nothing_found_i > 0.5) => 0.2194954529,
      (f_nae_nothing_found_i = NULL) => -0.0011709353, -0.0011709353),
   (r_A50_pb_average_dollars_d > 235.5) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 5.5) => 0.0160261041,
      (f_bus_addr_match_count_d > 5.5) => 0.1054162259,
      (f_bus_addr_match_count_d = NULL) => 0.0233632770, 0.0233632770),
   (r_A50_pb_average_dollars_d = NULL) => 0.0503808302, 0.0087438820),
(f_add_input_mobility_index_i > 0.38111460565) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0620052362,
   (r_I60_inq_PrepaidCards_recency_d > 549) => -0.0305681386,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0272508891, -0.0272508891),
(f_add_input_mobility_index_i = NULL) => 0.0087719360, 0.0027198673);

// Tree: 100 
woFDN_FLA_S__lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_transport and c_transport <= 26.6) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 17.9) => 0.0317110807,
         (c_vacant_p > 17.9) => 0.1705080299,
         (c_vacant_p = NULL) => 0.0579200791, 0.0579200791),
      (k_estimated_income_d > 30500) => 0.0016248973,
      (k_estimated_income_d = NULL) => 0.0052125224, 0.0052125224),
   (c_transport > 26.6) => 0.1597224590,
   (c_transport = NULL) => -0.0030671983, 0.0076985681),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 39.35) => -0.0141921658,
   (c_famotf18_p > 39.35) => -0.0695844323,
   (c_famotf18_p = NULL) => 0.0944578104, -0.0151050182),
(f_historical_count_d = NULL) => 0.0113863379, -0.0037176149);

// Tree: 101 
woFDN_FLA_S__lgt_101 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 2.45) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => -0.0215925946,
      (r_D34_UnRel_Lien60_Count_i > 0.5) => -0.1332096669,
      (r_D34_UnRel_Lien60_Count_i = NULL) => -0.0296203785, -0.0296203785),
   (C_INC_125K_P > 2.45) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.0411819322,
      (k_estimated_income_d > 28500) => -0.0027030454,
      (k_estimated_income_d = NULL) => 0.0086199414, -0.0008114760),
   (C_INC_125K_P = NULL) => 0.0154288756, -0.0021426567),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => -0.0067513716,
   (f_addrs_per_ssn_i > 7.5) => 0.2108596168,
   (f_addrs_per_ssn_i = NULL) => 0.0674923774, 0.0674923774),
(f_nae_nothing_found_i = NULL) => -0.0012094319, -0.0012094319);

// Tree: 102 
woFDN_FLA_S__lgt_102 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0102268621,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 44) => -0.1182760353,
   (f_mos_inq_banko_am_fseen_d > 44) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 79.25) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 8.05) => 0.0130323631,
         (c_hh7p_p > 8.05) => 
            map(
            (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => -0.0034394988,
            (f_rel_under25miles_cnt_d > 5.5) => 0.1387015030,
            (f_rel_under25miles_cnt_d = NULL) => 0.0756211768, 0.0756211768),
         (c_hh7p_p = NULL) => 0.0152892021, 0.0152892021),
      (c_rnt1000_p > 79.25) => 0.1783161250,
      (c_rnt1000_p = NULL) => 0.0402568428, 0.0182213556),
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0147777963, 0.0147777963),
(k_inq_per_ssn_i = NULL) => -0.0000397060, -0.0000397060);

// Tree: 103 
woFDN_FLA_S__lgt_103 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 691) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 76) => 0.2048362016,
         (c_no_teens > 76) => 0.0325671715,
         (c_no_teens = NULL) => 0.1000164214, 0.1000164214),
      (c_popover25 > 691) => -0.0157404195,
      (c_popover25 = NULL) => 0.1183167391, 0.0462903723),
   (k_estimated_income_d > 27500) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 123.5) => 0.0629880950,
      (f_mos_liens_unrel_SC_fseen_d > 123.5) => -0.0042545513,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0028015153, -0.0028015153),
   (k_estimated_income_d = NULL) => -0.0003414103, -0.0003414103),
(f_srchaddrsrchcount_i > 32.5) => -0.0882951533,
(f_srchaddrsrchcount_i = NULL) => -0.0051257982, -0.0009856073);

// Tree: 104 
woFDN_FLA_S__lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => -0.0021538194,
   (k_inq_per_ssn_i > 7.5) => 
      map(
      (NULL < c_highinc and c_highinc <= 5.5) => -0.0755168073,
      (c_highinc > 5.5) => 0.0985497808,
      (c_highinc = NULL) => 0.0583805682, 0.0583805682),
   (k_inq_per_ssn_i = NULL) => -0.0009337236, -0.0009337236),
(f_prevaddrmedianvalue_d > 809865.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 0.5) => 0.0362653406,
   (f_bus_addr_match_count_d > 0.5) => 0.3094543128,
   (f_bus_addr_match_count_d = NULL) => 0.1431653732, 0.1431653732),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 8.05) => -0.0550431694,
   (C_INC_25K_P > 8.05) => 0.0311118958,
   (C_INC_25K_P = NULL) => -0.0123338208, -0.0123338208), 0.0013063159);

// Tree: 105 
woFDN_FLA_S__lgt_105 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0104492840,
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 85) => -0.0022334554,
   (f_curraddrcrimeindex_i > 85) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 186) => 
         map(
         (NULL < C_INC_200K_P and C_INC_200K_P <= 4.95) => 0.0409061639,
         (C_INC_200K_P > 4.95) => -0.0322012863,
         (C_INC_200K_P = NULL) => 0.0186618848, 0.0186618848),
      (c_rich_blk > 186) => 
         map(
         (NULL < c_very_rich and c_very_rich <= 128.5) => 0.0637869993,
         (c_very_rich > 128.5) => 0.2525000435,
         (c_very_rich = NULL) => 0.1210925310, 0.1210925310),
      (c_rich_blk = NULL) => 0.0293468949, 0.0293468949),
   (f_curraddrcrimeindex_i = NULL) => 0.0115913868, 0.0115913868),
(f_corrrisktype_i = NULL) => -0.0133336346, -0.0031594881);

// Tree: 106 
woFDN_FLA_S__lgt_106 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 36.15) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 55.5) => -0.0121503611,
      (k_comb_age_d > 55.5) => 0.0206144160,
      (k_comb_age_d = NULL) => -0.0049079932, -0.0049079932),
   (c_hh3_p > 36.15) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 33.75) => -0.0027832853,
      (c_fammar18_p > 33.75) => 0.2411962618,
      (c_fammar18_p = NULL) => 0.1032947787, 0.1032947787),
   (c_hh3_p = NULL) => -0.0317958632, -0.0045282937),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 126.5) => -0.0175472503,
   (c_blue_empl > 126.5) => 0.3001392390,
   (c_blue_empl = NULL) => 0.1544114916, 0.1544114916),
(f_historical_count_d = NULL) => 0.0021602535, -0.0030950599);

// Tree: 107 
woFDN_FLA_S__lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0794970905,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 111.5) => -0.0050286094,
      (f_addrchangecrimediff_i > 111.5) => 0.0805185072,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 51000) => 0.0162490714,
         (r_A49_Curr_AVM_Chg_1yr_i > 51000) => 0.1213910751,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0081497134, 0.0034770810), -0.0028369874),
   (r_D32_criminal_count_i > 10.5) => 0.0846175060,
   (r_D32_criminal_count_i = NULL) => -0.0022906594, -0.0022906594),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 4.15) => 0.0731807587,
   (c_femdiv_p > 4.15) => -0.0507918396,
   (c_femdiv_p = NULL) => 0.0093890334, 0.0093890334), -0.0016044874);

// Tree: 108 
woFDN_FLA_S__lgt_108 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => -0.0010870645,
(f_phones_per_addr_curr_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.05) => -0.0240618970,
      (c_pop_35_44_p > 12.05) => 
         map(
         (NULL < c_lux_prod and c_lux_prod <= 69.5) => 
            map(
            (NULL < c_pop00 and c_pop00 <= 1094.5) => 0.1991004919,
            (c_pop00 > 1094.5) => 0.0618319841,
            (c_pop00 = NULL) => 0.0993189662, 0.0993189662),
         (c_lux_prod > 69.5) => 0.0161138793,
         (c_lux_prod = NULL) => 0.0380377593, 0.0380377593),
      (c_pop_35_44_p = NULL) => 0.0193435581, 0.0193435581),
   (r_C12_source_profile_d > 81.3) => 0.2246779921,
   (r_C12_source_profile_d = NULL) => 0.0277186616, 0.0277186616),
(f_phones_per_addr_curr_i = NULL) => -0.0201415298, 0.0019723433);

// Tree: 109 
woFDN_FLA_S__lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0080496840,
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 21.5) => -0.0869583625,
   (f_mos_inq_banko_cm_lseen_d > 21.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 24.9) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 124.35) => -0.0005744710,
         (c_oldhouse > 124.35) => -0.1332951360,
         (c_oldhouse = NULL) => -0.0474170586, -0.0474170586),
      (c_rnt750_p > 24.9) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 65.5) => 0.1464574318,
         (c_born_usa > 65.5) => -0.0110245776,
         (c_born_usa = NULL) => 0.0464350745, 0.0464350745),
      (c_rnt750_p = NULL) => -0.0059540267, -0.0059540267),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0312169483, -0.0312169483),
(r_D33_eviction_count_i = NULL) => 0.0224842780, 0.0066523149);

// Tree: 110 
woFDN_FLA_S__lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 103.5) => -0.0085517433,
(f_prevaddrageoldest_d > 103.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 85) => 0.1061759818,
   (f_prevaddrlenofres_d > 85) => 
      map(
      (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.35) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 46.35) => 0.0098135025,
         (c_hval_750k_p > 46.35) => 
            map(
            (NULL < c_new_homes and c_new_homes <= 104.5) => 0.0339890891,
            (c_new_homes > 104.5) => 0.3142646457,
            (c_new_homes = NULL) => 0.1043721885, 0.1043721885),
         (c_hval_750k_p = NULL) => 0.0146856344, 0.0146856344),
      (c_hval_1000k_p > 41.35) => 0.1868860323,
      (c_hval_1000k_p = NULL) => 0.0196765265, 0.0172035920),
   (f_prevaddrlenofres_d = NULL) => 0.0186893976, 0.0186893976),
(f_prevaddrageoldest_d = NULL) => -0.0310353932, 0.0010017813);

// Tree: 111 
woFDN_FLA_S__lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2170819191,
   (r_C12_source_profile_d > 57.95) => -0.0194131857,
   (r_C12_source_profile_d = NULL) => 0.0915575943, 0.0915575943),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 21.55) => -0.0003285428,
   (c_hval_150k_p > 21.55) => 
      map(
      (NULL < c_families and c_families <= 849.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 9.5) => 0.0094913400,
         (f_srchaddrsrchcount_i > 9.5) => 0.1203556845,
         (f_srchaddrsrchcount_i = NULL) => 0.0175700198, 0.0175700198),
      (c_families > 849.5) => 0.2690651718,
      (c_families = NULL) => 0.0403866034, 0.0403866034),
   (c_hval_150k_p = NULL) => -0.0046346091, 0.0027845964),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0299460995, 0.0034260231);

// Tree: 112 
woFDN_FLA_S__lgt_112 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 42.45) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 229788) => 0.0135444911,
         (f_curraddrmedianvalue_d > 229788) => 0.1227542400,
         (f_curraddrmedianvalue_d = NULL) => 0.0458148679, 0.0458148679),
      (f_prevaddrlenofres_d > 2.5) => 0.0030174694,
      (f_prevaddrlenofres_d = NULL) => 0.0061823604, 0.0061823604),
   (c_high_ed > 42.45) => -0.0225038739,
   (c_high_ed = NULL) => 0.0123433832, -0.0017211863),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 82.5) => 0.1736714647,
   (c_rich_fam > 82.5) => -0.0213624941,
   (c_rich_fam = NULL) => 0.0572802312, 0.0572802312),
(f_hh_lienholders_i = NULL) => 0.0232875467, -0.0009150236);

// Tree: 113 
woFDN_FLA_S__lgt_113 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0103629036,
   (f_corrrisktype_i > 6.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 68.5) => -0.0005541035,
      (r_C13_Curr_Addr_LRes_d > 68.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6910.5) => 0.0275097581,
         (f_addrchangeincomediff_d > 6910.5) => 0.1480186633,
         (f_addrchangeincomediff_d = NULL) => 0.0416216023, 0.0411235655),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0116014559, 0.0116014559),
   (f_corrrisktype_i = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 0.95) => 0.0881332703,
      (c_bigapt_p > 0.95) => -0.0327877278,
      (c_bigapt_p = NULL) => 0.0248475143, 0.0248475143), -0.0028538711),
(r_L77_Add_PO_Box_i > 0.5) => -0.0977164070,
(r_L77_Add_PO_Box_i = NULL) => -0.0049478017, -0.0049478017);

// Tree: 114 
woFDN_FLA_S__lgt_114 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00501882845) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.1860098308,
   (f_hh_members_ct_d > 1.5) => 0.0281249412,
   (f_hh_members_ct_d = NULL) => 0.0486610178, 0.0486610178),
(f_add_input_nhood_MFD_pct_i > 0.00501882845) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => -0.0102854602,
      (k_inq_per_ssn_i > 7.5) => 0.1013552415,
      (k_inq_per_ssn_i = NULL) => -0.0090703734, -0.0090703734),
   (f_srchssnsrchcount_i > 6.5) => -0.0404812281,
   (f_srchssnsrchcount_i = NULL) => 0.0037381855, -0.0102009990),
(f_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 18.5) => -0.0047101904,
   (f_srchaddrsrchcount_i > 18.5) => 0.1185633947,
   (f_srchaddrsrchcount_i = NULL) => -0.0020235909, -0.0020235909), -0.0052998086);

// Tree: 115 
woFDN_FLA_S__lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13229074905) => -0.0075880670,
   (f_add_curr_nhood_BUS_pct_i > 0.13229074905) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0036355439,
      (c_easiqlife > 132.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.01879119585) => 
            map(
            (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 0.5) => 0.0712043405,
            (f_bus_addr_match_count_d > 0.5) => 0.3583576999,
            (f_bus_addr_match_count_d = NULL) => 0.1476891138, 0.1476891138),
         (f_add_input_nhood_VAC_pct_i > 0.01879119585) => 0.0321860191,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0740094747, 0.0740094747),
      (c_easiqlife = NULL) => 0.0282534109, 0.0282534109),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0095821822, -0.0034998642),
(c_pop_0_5_p > 21.15) => 0.1446544816,
(c_pop_0_5_p = NULL) => 0.0125516119, -0.0024708647);

// Tree: 116 
woFDN_FLA_S__lgt_116 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.45) => -0.0870047191,
(C_OWNOCC_P > 1.45) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 231294.5) => -0.0024899760,
   (f_addrchangevaluediff_d > 231294.5) => 0.0843959285,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 58305) => 
         map(
         (NULL < f_prevaddrdwelltype_sfd_n and f_prevaddrdwelltype_sfd_n <= 0.5) => 0.0252845854,
         (f_prevaddrdwelltype_sfd_n > 0.5) => 0.2023223557,
         (f_prevaddrdwelltype_sfd_n = NULL) => 0.0674364355, 0.0674364355),
      (f_curraddrmedianvalue_d > 58305) => -0.0078105061,
      (f_curraddrmedianvalue_d = NULL) => 
         map(
         (NULL < c_robbery and c_robbery <= 86) => 0.0766978599,
         (c_robbery > 86) => -0.0554720914,
         (c_robbery = NULL) => 0.0086880791, 0.0086880791), 0.0025593350), -0.0008171739),
(C_OWNOCC_P = NULL) => 0.0137807509, -0.0015461179);

// Tree: 117 
woFDN_FLA_S__lgt_117 := map(
(NULL < c_young and c_young <= 29.65) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 0.1169948327,
      (r_C21_M_Bureau_ADL_FS_d > 6.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 16.5) => 0.0144417165,
         (f_addrs_per_ssn_i > 16.5) => 
            map(
            (NULL < c_robbery and c_robbery <= 134) => 0.0301693243,
            (c_robbery > 134) => 0.1937515096,
            (c_robbery = NULL) => 0.0896537553, 0.0896537553),
         (f_addrs_per_ssn_i = NULL) => 0.0230040185, 0.0230040185),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0278477169, 0.0278477169),
   (r_Ever_Asset_Owner_d > 0.5) => 0.0009259651,
   (r_Ever_Asset_Owner_d = NULL) => -0.0023276608, 0.0053310664),
(c_young > 29.65) => -0.0214208491,
(c_young = NULL) => 0.0030987422, -0.0000172730);

// Tree: 118 
woFDN_FLA_S__lgt_118 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => 
      map(
      (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0078339684,
      (f_srchunvrfdaddrcount_i > 0.5) => 0.0390359211,
      (f_srchunvrfdaddrcount_i = NULL) => -0.0067047560, -0.0067047560),
   (k_comb_age_d > 84.5) => 0.0976271179,
   (k_comb_age_d = NULL) => -0.0060259704, -0.0060259704),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 3.5) => 0.0049501448,
   (c_hval_175k_p > 3.5) => 0.1385313980,
   (c_hval_175k_p = NULL) => 0.0735790455, 0.0735790455),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0264776839,
   (k_nap_lname_verd_d > 0.5) => -0.0687395904,
   (k_nap_lname_verd_d = NULL) => -0.0191636542, -0.0191636542), -0.0054609808);

// Tree: 119 
woFDN_FLA_S__lgt_119 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.0721253273,
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => -0.0384416539,
      (f_mos_inq_banko_om_fseen_d > 21.5) => 0.0105072067,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0071287073, 0.0071287073),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0083016193, 0.0083016193),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 6.65) => -0.0989199917,
   (c_vacant_p > 6.65) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.0754367006,
      (r_C10_M_Hdr_FS_d > 13.5) => -0.0842278417,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0270345729, -0.0270345729),
   (c_vacant_p = NULL) => -0.0627749781, -0.0627749781),
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0280298153, 0.0049486304);

// Tree: 120 
woFDN_FLA_S__lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1920.5) => -0.0064535512,
(c_popover18 > 1920.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 7.5) => 0.2041479002,
      (f_mos_inq_banko_cm_lseen_d > 7.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 22.75) => -0.0051163970,
         (c_hval_150k_p > 22.75) => 0.1650916830,
         (c_hval_150k_p = NULL) => 0.0054664888, 0.0054664888),
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0104836961, 0.0104836961),
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.3975714647) => 0.0454562970,
      (f_add_curr_nhood_MFD_pct_i > 0.3975714647) => 0.2335189842,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0317872965, 0.0758202164),
   (f_rel_felony_count_i = NULL) => 0.0202743555, 0.0202743555),
(c_popover18 = NULL) => -0.0289437133, -0.0020019662);

// Tree: 121 
woFDN_FLA_S__lgt_121 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 197.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => -0.0018356033,
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 171.5) => 0.2184833911,
      (f_curraddrmurderindex_i > 171.5) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 6.55) => -0.0147975888,
         (c_pop_75_84_p > 6.55) => 0.1669947568,
         (c_pop_75_84_p = NULL) => 0.0259828563, 0.0259828563),
      (f_curraddrmurderindex_i = NULL) => 0.0541107883, 0.0541107883),
   (f_curraddrcartheftindex_i = NULL) => 0.0001296321, 0.0001296321),
(f_prevaddrcartheftindex_i > 197.5) => -0.0877531791,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 100) => 0.0772041392,
   (c_robbery > 100) => -0.0283630217,
   (c_robbery = NULL) => 0.0219992936, 0.0219992936), -0.0003718384);

// Tree: 122 
woFDN_FLA_S__lgt_122 := map(
(NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 9.5) => 0.0000783755,
   (r_I60_Inq_Count12_i > 9.5) => -0.0763387749,
   (r_I60_Inq_Count12_i = NULL) => -0.0006448152, -0.0006448152),
(r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 144.5) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 12.8) => 0.1758667636,
      (c_hval_400k_p > 12.8) => 0.0084523460,
      (c_hval_400k_p = NULL) => 0.1017260929, 0.1017260929),
   (c_rest_indx > 144.5) => -0.0465570300,
   (c_rest_indx = NULL) => 0.0567247472, 0.0567247472),
(r_C14_Addrs_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 9.95) => -0.0482917017,
   (c_retail > 9.95) => 0.0457558825,
   (c_retail = NULL) => 0.0033096276, 0.0033096276), 0.0003061651);

// Tree: 123 
woFDN_FLA_S__lgt_123 := map(
(NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0056282963,
(c_easiqlife > 132.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 14.5) => 
      map(
      (NULL < c_rnt2001_p and c_rnt2001_p <= 72.5) => 0.0245254181,
      (c_rnt2001_p > 72.5) => 0.2523344179,
      (c_rnt2001_p = NULL) => 0.0278850517, 0.0278850517),
   (f_rel_under500miles_cnt_d > 14.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 178.5) => -0.0081337818,
      (f_fp_prevaddrburglaryindex_i > 178.5) => -0.1523074712,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.0174059863, -0.0174059863),
   (f_rel_under500miles_cnt_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 1.25) => -0.0060428626,
      (c_hval_200k_p > 1.25) => 0.1392069210,
      (c_hval_200k_p = NULL) => 0.0620831421, 0.0620831421), 0.0206532356),
(c_easiqlife = NULL) => -0.0092646979, 0.0034704755);

// Tree: 124 
woFDN_FLA_S__lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 187) => -0.0848944058,
   (f_mos_liens_unrel_FT_fseen_d > 187) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 452) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 1.55) => -0.0808191074,
         (c_sfdu_p > 1.55) => 
            map(
            (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 0.0068484449,
            (f_rel_homeover500_count_d > 14.5) => 0.1009771117,
            (f_rel_homeover500_count_d = NULL) => 0.0231421275, 0.0077995446),
         (c_sfdu_p = NULL) => 0.0066265438, 0.0066265438),
      (r_C13_Curr_Addr_LRes_d > 452) => 0.1439887272,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0077753505, 0.0077753505),
   (f_mos_liens_unrel_FT_fseen_d = NULL) => 0.0079626337, 0.0067443566),
(c_high_ed > 42.55) => -0.0259152007,
(c_high_ed = NULL) => -0.0309892977, -0.0033842207);

// Tree: 125 
woFDN_FLA_S__lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => -0.0001494493,
   (f_inq_Auto_count24_i > 1.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 132) => -0.0211123574,
      (c_bel_edu > 132) => -0.1117217172,
      (c_bel_edu = NULL) => -0.0429257218, -0.0429257218),
   (f_inq_Auto_count24_i = NULL) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.260400711) => -0.0491890478,
      (f_add_input_mobility_index_i > 0.260400711) => 0.0747999693,
      (f_add_input_mobility_index_i = NULL) => 0.0150598065, 0.0150598065), -0.0022438821),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 61500) => 0.0009940811,
   (k_estimated_income_d > 61500) => 0.1890966247,
   (k_estimated_income_d = NULL) => 0.0778978834, 0.0778978834),
(f_nae_nothing_found_i = NULL) => -0.0010940357, -0.0010940357);

// Tree: 126 
woFDN_FLA_S__lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.75) => 
      map(
      (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 0.5) => 
         map(
         (NULL < c_med_inc and c_med_inc <= 34.5) => -0.0621606560,
         (c_med_inc > 34.5) => 0.0041529339,
         (c_med_inc = NULL) => 0.0004880163, 0.0004880163),
      (r_C14_Addrs_Per_ADL_c6_i > 0.5) => 
         map(
         (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 16.5) => 0.0322975217,
         (f_rel_homeover50_count_d > 16.5) => 0.1594270707,
         (f_rel_homeover50_count_d = NULL) => 0.0664054495, 0.0664054495),
      (r_C14_Addrs_Per_ADL_c6_i = NULL) => 0.0028150482, 0.0028150482),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.75) => 0.1607654307,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0024815040, 0.0032762770),
(r_L72_Add_Vacant_i > 0.5) => 0.1263971728,
(r_L72_Add_Vacant_i = NULL) => 0.0041209673, 0.0041209673);

// Tree: 127 
woFDN_FLA_S__lgt_127 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 195.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 5.5) => 0.1132774430,
      (r_C13_max_lres_d > 5.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 3.455) => -0.0052129684,
         (c_hhsize > 3.455) => 0.0358328642,
         (c_hhsize = NULL) => -0.0027753479, -0.0027753479),
      (r_C13_max_lres_d = NULL) => -0.0021112541, -0.0021112541),
   (c_bel_edu > 195.5) => -0.0701234355,
   (c_bel_edu = NULL) => -0.0120631908, -0.0032769764),
(f_assocsuspicousidcount_i > 16.5) => 0.0855388088,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0825514379,
   (r_S66_adlperssn_count_i > 1.5) => 0.0453286162,
   (r_S66_adlperssn_count_i = NULL) => -0.0107591268, -0.0107591268), -0.0029031152);

// Tree: 128 
woFDN_FLA_S__lgt_128 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 10.95) => -0.0178874711,
   (c_hh4_p > 10.95) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -148689.5) => 0.1022550341,
      (f_addrchangevaluediff_d > -148689.5) => 0.0091944673,
      (f_addrchangevaluediff_d = NULL) => 0.0059919946, 0.0093337559),
   (c_hh4_p = NULL) => -0.0062314461, -0.0006240849),
(f_srchcomponentrisktype_i > 2.5) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 169) => 
      map(
      (NULL < c_rich_asian and c_rich_asian <= 184.5) => -0.0030201265,
      (c_rich_asian > 184.5) => 0.1492705768,
      (c_rich_asian = NULL) => 0.0190810186, 0.0190810186),
   (c_for_sale > 169) => 0.1661097916,
   (c_for_sale = NULL) => 0.0372038495, 0.0372038495),
(f_srchcomponentrisktype_i = NULL) => 0.0214753288, 0.0010812204);

// Tree: 129 
woFDN_FLA_S__lgt_129 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
   map(
   (NULL < c_totsales and c_totsales <= 33963.5) => 
      map(
      (NULL < c_professional and c_professional <= 4.25) => -0.0375106304,
      (c_professional > 4.25) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 102.5) => 0.1966718485,
         (c_easiqlife > 102.5) => 0.0146485425,
         (c_easiqlife = NULL) => 0.0941881384, 0.0941881384),
      (c_professional = NULL) => 0.0182621578, 0.0182621578),
   (c_totsales > 33963.5) => 0.2283664187,
   (c_totsales = NULL) => 0.0562401875, 0.0562401875),
(r_I61_inq_collection_recency_d > 4.5) => -0.0047909163,
(r_I61_inq_collection_recency_d = NULL) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.4) => -0.0800557941,
   (c_hval_175k_p > 2.4) => 0.0259188203,
   (c_hval_175k_p = NULL) => -0.0210786174, -0.0210786174), -0.0032552788);

// Tree: 130 
woFDN_FLA_S__lgt_130 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 48.45) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0122994625,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13212450645) => 0.0032695654,
      (f_add_curr_nhood_BUS_pct_i > 0.13212450645) => 0.0456713599,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0957972456, 0.0126134999),
   (f_inq_Other_count_i = NULL) => 
      map(
      (NULL < c_no_car and c_no_car <= 102) => -0.0489200892,
      (c_no_car > 102) => 0.0620620196,
      (c_no_car = NULL) => 0.0050977514, 0.0050977514), -0.0064243184),
(c_rnt2001_p > 48.45) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 143.5) => 0.0377791804,
   (c_lar_fam > 143.5) => 0.2255471614,
   (c_lar_fam = NULL) => 0.0706543824, 0.0706543824),
(c_rnt2001_p = NULL) => 0.0319335290, -0.0037154993);

// Tree: 131 
woFDN_FLA_S__lgt_131 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 813323.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 11.65) => -0.1064787829,
   (c_white_col > 11.65) => 0.0008353146,
   (c_white_col = NULL) => -0.0027667970, 0.0001452161),
(f_prevaddrmedianvalue_d > 813323.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.65) => 
      map(
      (NULL < c_rich_asian and c_rich_asian <= 178.5) => 0.0626577635,
      (c_rich_asian > 178.5) => 0.3142461420,
      (c_rich_asian = NULL) => 0.1679738289, 0.1679738289),
   (c_pop_0_5_p > 7.65) => -0.0530558129,
   (c_pop_0_5_p = NULL) => 0.0962259871, 0.0962259871),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 114.5) => -0.0408390650,
   (c_easiqlife > 114.5) => 0.0573290626,
   (c_easiqlife = NULL) => 0.0022171313, 0.0022171313), 0.0016116827);

// Tree: 132 
woFDN_FLA_S__lgt_132 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0010341029,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.1676869283,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0123749106,
   (f_crim_rel_under25miles_cnt_i > 0.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 56.5) => 0.1209009104,
         (c_mort_indx > 56.5) => 0.0215747287,
         (c_mort_indx = NULL) => 0.0324619938, 0.0324619938),
      (c_pop_18_24_p > 11.15) => -0.0193626786,
      (c_pop_18_24_p = NULL) => 0.0194638963, 0.0194638963),
   (f_crim_rel_under25miles_cnt_i = NULL) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 10.95) => -0.0483490075,
      (c_hh4_p > 10.95) => 0.0558141457,
      (c_hh4_p = NULL) => 0.0099823583, 0.0099823583), 0.0002049184), 0.0003355269);

// Tree: 133 
woFDN_FLA_S__lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 61.6) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 4.25) => 0.2057225464,
      (c_hval_200k_p > 4.25) => 0.0346630891,
      (c_hval_200k_p = NULL) => 0.1210232035, 0.1210232035),
   (r_C12_source_profile_d > 61.6) => -0.0120223758,
   (r_C12_source_profile_d = NULL) => 0.0517666006, 0.0517666006),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 12.5) => -0.0123199622,
      (k_inq_per_addr_i > 12.5) => 0.0873998516,
      (k_inq_per_addr_i = NULL) => -0.0112865963, -0.0112865963),
   (f_bus_name_nover_i > 0.5) => 0.0172898001,
   (f_bus_name_nover_i = NULL) => 0.0003101930, 0.0003101930),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0013449445, 0.0012085948);

// Tree: 134 
woFDN_FLA_S__lgt_134 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 44.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 29.5) => 0.0494927326,
      (f_M_Bureau_ADL_FS_all_d > 29.5) => 0.0014093296,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0036131691, 0.0036131691),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0484343841,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0013923951, 0.0013923951),
(f_rel_count_i > 44.5) => 
   map(
   (NULL < r_C20_email_count_i and r_C20_email_count_i <= 0.5) => 0.0413258436,
   (r_C20_email_count_i > 0.5) => -0.1222475485,
   (r_C20_email_count_i = NULL) => -0.0687144383, -0.0687144383),
(f_rel_count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 74.5) => -0.0634504215,
   (c_assault > 74.5) => 0.0467735136,
   (c_assault = NULL) => -0.0055361505, -0.0055361505), 0.0004138448);

// Tree: 135 
woFDN_FLA_S__lgt_135 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 19.85) => -0.0048879990,
(c_hval_150k_p > 19.85) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 9363) => -0.0156548053,
      (r_A49_Curr_AVM_Chg_1yr_i > 9363) => 0.1500404895,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0013520954, 0.0178301628),
   (k_inq_ssns_per_addr_i > 1.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 17.35) => 
         map(
         (NULL < c_food and c_food <= 18.95) => 0.1287235990,
         (c_food > 18.95) => -0.0490509997,
         (c_food = NULL) => 0.0389733161, 0.0389733161),
      (c_hh4_p > 17.35) => 0.2357165622,
      (c_hh4_p = NULL) => 0.1041285470, 0.1041285470),
   (k_inq_ssns_per_addr_i = NULL) => 0.0290358552, 0.0290358552),
(c_hval_150k_p = NULL) => 0.0142397876, -0.0012774450);

// Tree: 136 
woFDN_FLA_S__lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 9.45) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 1.1) => 0.0459211490,
      (c_low_hval > 1.1) => 0.2891948209,
      (c_low_hval = NULL) => 0.1259453832, 0.1259453832),
   (c_hh1_p > 9.45) => 0.0176300411,
   (c_hh1_p = NULL) => 0.0877801372, 0.0265647334),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -33816.5) => -0.0841366232,
   (f_addrchangeincomediff_d > -33816.5) => 
      map(
      (NULL < c_employees and c_employees <= 27.5) => 0.0394913389,
      (c_employees > 27.5) => -0.0120489783,
      (c_employees = NULL) => -0.0071098597, -0.0071098597),
   (f_addrchangeincomediff_d = NULL) => -0.0035076488, -0.0071490887),
(f_hh_members_ct_d = NULL) => -0.0065911955, -0.0007448666);

// Tree: 137 
woFDN_FLA_S__lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 40.1) => 0.0009794812,
   (c_hval_80k_p > 40.1) => -0.0795709981,
   (c_hval_80k_p = NULL) => 0.0262439453, 0.0008096810),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.25) => -0.1052724903,
   (C_INC_75K_P > 15.25) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 100.5) => -0.0698680943,
      (c_blue_empl > 100.5) => 0.0479479813,
      (c_blue_empl = NULL) => -0.0061837291, -0.0061837291),
   (C_INC_75K_P = NULL) => -0.0354385062, -0.0354385062),
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 0.1) => -0.0593622544,
   (c_hval_80k_p > 0.1) => 0.0486553107,
   (c_hval_80k_p = NULL) => -0.0101756845, -0.0101756845), 0.0001028137);

// Tree: 138 
woFDN_FLA_S__lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => -0.0019471919,
   (f_bus_addr_match_count_d > 52.5) => 0.1039918532,
   (f_bus_addr_match_count_d = NULL) => -0.0012218186, -0.0012218186),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < c_larceny and c_larceny <= 131.5) => -0.1006356593,
      (c_larceny > 131.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.31149303095) => 0.1694749901,
         (f_add_curr_mobility_index_i > 0.31149303095) => -0.0382144997,
         (f_add_curr_mobility_index_i = NULL) => 0.0627050411, 0.0627050411),
      (c_larceny = NULL) => 0.0067457271, 0.0067457271),
   (f_vardobcountnew_i > 0.5) => 0.1685340418,
   (f_vardobcountnew_i = NULL) => 0.0538685372, 0.0538685372),
(f_curraddrcrimeindex_i = NULL) => -0.0265689037, -0.0000956511);

// Tree: 139 
woFDN_FLA_S__lgt_139 := map(
(NULL < c_hval_40k_p and c_hval_40k_p <= 36.05) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 118500) => -0.0025751302,
   (k_estimated_income_d > 118500) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 3.5) => 0.0053920549,
      (f_bus_addr_match_count_d > 3.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 13.75) => 
            map(
            (NULL < c_hval_250k_p and c_hval_250k_p <= 0.15) => 0.4126437461,
            (c_hval_250k_p > 0.15) => 0.1499161522,
            (c_hval_250k_p = NULL) => 0.2789341670, 0.2789341670),
         (c_pop_55_64_p > 13.75) => -0.0214491124,
         (c_pop_55_64_p = NULL) => 0.1537744673, 0.1537744673),
      (f_bus_addr_match_count_d = NULL) => 0.0467410000, 0.0467410000),
   (k_estimated_income_d = NULL) => -0.0009410286, 0.0001921711),
(c_hval_40k_p > 36.05) => -0.1281987301,
(c_hval_40k_p = NULL) => -0.0294214865, -0.0010586675);

// Tree: 140 
woFDN_FLA_S__lgt_140 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 198.5) => -0.0013848668,
   (c_work_home > 198.5) => 0.1647245196,
   (c_work_home = NULL) => -0.0335479105, -0.0012086857),
(f_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.0978184046,
      (f_adl_util_conv_n > 0.5) => -0.1329151028,
      (f_adl_util_conv_n = NULL) => -0.0024182830, -0.0024182830),
   (r_C23_inp_addr_occ_index_d > 2) => 0.1564554560,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0487743662, 0.0487743662),
(f_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.75) => -0.0756070856,
   (c_pop_45_54_p > 12.75) => 0.0395530805,
   (c_pop_45_54_p = NULL) => -0.0148281091, -0.0148281091), -0.0006239717);

// Tree: 141 
woFDN_FLA_S__lgt_141 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 1.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 0.0411045205,
      (f_corrssnnamecount_d > 1.5) => -0.0076056171,
      (f_corrssnnamecount_d = NULL) => -0.0045013047, -0.0045013047),
   (f_divsrchaddrsuspidcount_i > 1.5) => -0.0761807741,
   (f_divsrchaddrsuspidcount_i = NULL) => -0.0050960099, -0.0050960099),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < c_pop00 and c_pop00 <= 2238.5) => 0.0019434482,
   (c_pop00 > 2238.5) => 0.1679833928,
   (c_pop00 = NULL) => 0.0583463301, 0.0583463301),
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0585087576,
   (c_pop_35_44_p > 16.05) => 0.0565365964,
   (c_pop_35_44_p = NULL) => -0.0089202430, -0.0089202430), -0.0037980280);

// Tree: 142 
woFDN_FLA_S__lgt_142 := map(
(NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 1.5) => -0.0064585237,
(f_hh_members_w_derog_i > 1.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1235374542) => 0.0072262154,
   (f_add_curr_nhood_BUS_pct_i > 0.1235374542) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.55) => 
         map(
         (NULL < c_bargains and c_bargains <= 77.5) => 0.2283755756,
         (c_bargains > 77.5) => 0.0532374470,
         (c_bargains = NULL) => 0.1124057337, 0.1124057337),
      (c_pop_6_11_p > 10.55) => -0.0632681825,
      (c_pop_6_11_p = NULL) => 0.0807746962, 0.0807746962),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0449259357, 0.0177632900),
(f_hh_members_w_derog_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 0.1) => -0.0471019101,
   (c_hval_125k_p > 0.1) => 0.0562102477,
   (c_hval_125k_p = NULL) => 0.0099916508, 0.0099916508), -0.0004504060);

// Tree: 143 
woFDN_FLA_S__lgt_143 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 7.5) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0013807302,
      (c_hval_200k_p > 16.45) => 0.0394390120,
      (c_hval_200k_p = NULL) => 0.0053986514, 0.0023720347),
   (f_inq_Auto_count24_i > 1.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 1.5) => 0.0100004787,
      (f_assocsuspicousidcount_i > 1.5) => -0.0681956130,
      (f_assocsuspicousidcount_i = NULL) => -0.0360730806, -0.0360730806),
   (f_inq_Auto_count24_i = NULL) => 0.0003184676, 0.0003184676),
(f_inq_QuizProvider_count_i > 7.5) => 0.1080607565,
(f_inq_QuizProvider_count_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1281) => 0.0475325879,
   (c_popover18 > 1281) => -0.0607367876,
   (c_popover18 = NULL) => -0.0079668399, -0.0079668399), 0.0008660081);

// Tree: 144 
woFDN_FLA_S__lgt_144 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 23718.5) => 0.0831123413,
(r_L80_Inp_AVM_AutoVal_d > 23718.5) => 
   map(
   (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 3.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62892.5) => 0.0699836389,
      (f_addrchangevaluediff_d > -62892.5) => -0.0018551336,
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 629999.5) => -0.0043420662,
         (f_prevaddrmedianvalue_d > 629999.5) => 0.1941941803,
         (f_prevaddrmedianvalue_d = NULL) => 0.0046010079, 0.0046010079), 0.0000433851),
   (f_hh_workers_paw_d > 3.5) => -0.0784210588,
   (f_hh_workers_paw_d = NULL) => 0.0129220279, -0.0020673800),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.0671693324,
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0057043464,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0315191874, -0.0050030081), -0.0027203449);

// Tree: 145 
woFDN_FLA_S__lgt_145 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0067863594,
(k_comb_age_d > 56.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 4.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 229.85) => 0.0089556354,
      (c_cpiall > 229.85) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 377.5) => 0.2253073732,
         (f_M_Bureau_ADL_FS_all_d > 377.5) => -0.0373493655,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1152940795, 0.1152940795),
      (c_cpiall = NULL) => 0.0040398372, 0.0172485401),
   (k_inq_per_addr_i > 4.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 13.95) => -0.0063524501,
      (C_INC_50K_P > 13.95) => 0.1934058827,
      (C_INC_50K_P = NULL) => 0.0758062190, 0.0758062190),
   (k_inq_per_addr_i = NULL) => 0.0201325866, 0.0201325866),
(k_comb_age_d = NULL) => -0.0134341663, -0.0014628122);

// Tree: 146 
woFDN_FLA_S__lgt_146 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0052334275,
   (f_curraddrcrimeindex_i > 189) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 208.95) => 0.1874694560,
      (c_housingcpi > 208.95) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.75) => -0.0330150767,
         (c_pop_55_64_p > 12.75) => 0.1750659045,
         (c_pop_55_64_p = NULL) => 0.0396972364, 0.0396972364),
      (c_housingcpi = NULL) => 0.0628590263, 0.0628590263),
   (f_curraddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0531519081,
      (c_high_hval > 3.7) => 0.0803535441,
      (c_high_hval = NULL) => 0.0142132283, 0.0142132283), -0.0033241535),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 0.0935511765,
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0026291866, -0.0026291866);

// Tree: 147 
woFDN_FLA_S__lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 118.5) => -0.0097629976,
   (c_sub_bus > 118.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 42.65) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 52.4) => 0.0200184504,
         (c_hh2_p > 52.4) => 0.1859813753,
         (c_hh2_p = NULL) => 0.0223946742, 0.0223946742),
      (c_high_ed > 42.65) => -0.0158991712,
      (c_high_ed = NULL) => 0.0092117782, 0.0092117782),
   (c_sub_bus = NULL) => -0.0378317618, -0.0020311180),
(f_prevaddrcartheftindex_i > 194.5) => -0.0688966579,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 38.6) => 0.0878084665,
   (c_low_ed > 38.6) => -0.0235169774,
   (c_low_ed = NULL) => 0.0217372681, 0.0217372681), -0.0027962104);

// Tree: 148 
woFDN_FLA_S__lgt_148 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 53.5) => -0.0658036206,
(f_mos_inq_banko_am_fseen_d > 53.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0054120790,
   (k_inq_per_ssn_i > 1.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 115.5) => 0.1393145705,
      (f_mos_liens_unrel_SC_fseen_d > 115.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 23.25) => 0.0036414787,
         (c_pop_25_34_p > 23.25) => 0.0767955222,
         (c_pop_25_34_p = NULL) => 0.0135679861, 0.0135679861),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0166374715, 0.0166374715),
   (k_inq_per_ssn_i = NULL) => -0.0009214173, -0.0009214173),
(f_mos_inq_banko_am_fseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 13.35) => 0.0566177897,
   (c_hh3_p > 13.35) => -0.0427735535,
   (c_hh3_p = NULL) => 0.0004400740, 0.0004400740), -0.0034507384);

// Tree: 149 
woFDN_FLA_S__lgt_149 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0892753399,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 183.5) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 184.5) => 0.0036717330,
      (c_cartheft > 184.5) => -0.0820908405,
      (c_cartheft = NULL) => 0.0024568812, 0.0024568812),
   (f_curraddrcartheftindex_i > 183.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 141.5) => 0.0148838529,
      (c_no_labfor > 141.5) => 0.1201773035,
      (c_no_labfor = NULL) => 0.0432991384, 0.0432991384),
   (f_curraddrcartheftindex_i = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 91.5) => 0.0646870781,
      (c_many_cars > 91.5) => -0.0619698337,
      (c_many_cars = NULL) => 0.0031016072, 0.0031016072), 0.0044813492),
(c_pop_45_54_p = NULL) => 0.0095536966, 0.0033038608);

// Tree: 150 
woFDN_FLA_S__lgt_150 := map(
(NULL < c_low_ed and c_low_ed <= 77.75) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 32.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0500821683,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
            map(
            (NULL < C_INC_75K_P and C_INC_75K_P <= 18.05) => 0.2312524034,
            (C_INC_75K_P > 18.05) => 0.0208593263,
            (C_INC_75K_P = NULL) => 0.1231064292, 0.1231064292),
         (nf_seg_FraudPoint_3_0 = '') => 0.0662259615, 0.0662259615),
      (c_newhouse > 32.5) => -0.0396035511,
      (c_newhouse = NULL) => 0.0371902782, 0.0371902782),
   (f_corrssnnamecount_d > 1.5) => -0.0028459547,
   (f_corrssnnamecount_d = NULL) => 0.0067065845, -0.0005458398),
(c_low_ed > 77.75) => -0.0508957123,
(c_low_ed = NULL) => 0.0049325496, -0.0018278670);

// Tree: 151 
woFDN_FLA_S__lgt_151 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 17.35) => 0.0337875566,
      (c_hh2_p > 17.35) => -0.0047888623,
      (c_hh2_p = NULL) => -0.0178074050, -0.0028787670),
   (r_C14_addrs_10yr_i > 10.5) => 0.0980763415,
   (r_C14_addrs_10yr_i = NULL) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.75) => -0.0605246160,
      (c_pop_75_84_p > 3.75) => 0.0502438468,
      (c_pop_75_84_p = NULL) => -0.0070836910, -0.0070836910), -0.0025103393),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 37.75) => -0.0278401051,
   (c_low_ed > 37.75) => 0.1426599471,
   (c_low_ed = NULL) => 0.0482759897, 0.0482759897),
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0020539229, -0.0020539229);

// Tree: 152 
woFDN_FLA_S__lgt_152 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37763534975) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 153.5) => 
         map(
         (NULL < c_rental and c_rental <= 127) => 0.0575644460,
         (c_rental > 127) => 0.1900309997,
         (c_rental = NULL) => 0.0985086535, 0.0985086535),
      (c_asian_lang > 153.5) => -0.0187795937,
      (c_asian_lang = NULL) => 0.0450902439, 0.0450902439),
   (r_C10_M_Hdr_FS_d > 15.5) => 0.0036205594,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0459721491, 0.0051660359),
(f_add_input_mobility_index_i > 0.37763534975) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 121.5) => -0.0353294026,
   (f_prevaddrlenofres_d > 121.5) => 0.0359827375,
   (f_prevaddrlenofres_d = NULL) => -0.0222244664, -0.0222244664),
(f_add_input_mobility_index_i = NULL) => 0.0478809854, 0.0007500378);

// Tree: 153 
woFDN_FLA_S__lgt_153 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00501882845) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.1662195895,
   (f_hh_members_ct_d > 1.5) => 0.0328253666,
   (f_hh_members_ct_d = NULL) => 0.0488628616, 0.0488628616),
(f_add_input_nhood_MFD_pct_i > 0.00501882845) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 18.5) => 0.0041361834,
   (f_rel_incomeover25_count_d > 18.5) => 
      map(
      (NULL < c_food and c_food <= 41.6) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 19.95) => -0.0312417164,
         (c_hval_150k_p > 19.95) => 0.1084703905,
         (c_hval_150k_p = NULL) => -0.0192442779, -0.0192442779),
      (c_food > 41.6) => -0.1136557514,
      (c_food = NULL) => -0.0335557703, -0.0335557703),
   (f_rel_incomeover25_count_d = NULL) => -0.0201506847, 0.0000412669),
(f_add_input_nhood_MFD_pct_i = NULL) => -0.0097031516, 0.0008757541);

// Tree: 154 
woFDN_FLA_S__lgt_154 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 16.15) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.86465236285) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 14.5) => 0.0663232135,
      (c_many_cars > 14.5) => -0.0043389684,
      (c_many_cars = NULL) => -0.0019260687, -0.0019260687),
   (f_add_curr_nhood_MFD_pct_i > 0.86465236285) => -0.0571783592,
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0150342819, -0.0070332137),
(c_hval_500k_p > 16.15) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 0.0173988253,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1975.5) => 0.2290166442,
      (c_med_yearblt > 1975.5) => -0.0652654793,
      (c_med_yearblt = NULL) => 0.0915016332, 0.0915016332),
   (k_comb_age_d = NULL) => 0.0207901856, 0.0207901856),
(c_hval_500k_p = NULL) => 0.0201920232, -0.0012277733);

// Tree: 155 
woFDN_FLA_S__lgt_155 := map(
(NULL < c_unempl and c_unempl <= 190.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 32461.5) => -0.0019530369,
   (f_addrchangevaluediff_d > 32461.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 0.8) => 0.1049538294,
      (c_high_hval > 0.8) => 0.0039538131,
      (c_high_hval = NULL) => 0.0321098279, 0.0321098279),
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => -0.0446244101,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0007499280,
      (nf_seg_FraudPoint_3_0 = '') => -0.0097377069, -0.0097377069), -0.0024647830),
(c_unempl > 190.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 135) => -0.0216610077,
   (f_fp_prevaddrburglaryindex_i > 135) => 0.1484049673,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0640865427, 0.0640865427),
(c_unempl = NULL) => 0.0251593360, -0.0012102082);

// Tree: 156 
woFDN_FLA_S__lgt_156 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0010111789,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 4.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 39) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 0.05) => -0.0358312029,
         (c_hh7p_p > 0.05) => 0.1256843610,
         (c_hh7p_p = NULL) => 0.0456674762, 0.0456674762),
      (f_fp_prevaddrburglaryindex_i > 39) => -0.0445067687,
      (f_fp_prevaddrburglaryindex_i = NULL) => -0.0205609764, -0.0205609764),
   (f_crim_rel_under100miles_cnt_i > 4.5) => -0.1132131095,
   (f_crim_rel_under100miles_cnt_i = NULL) => -0.0341751674, -0.0341751674),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 2.15) => -0.0483097525,
   (c_high_hval > 2.15) => 0.0502056918,
   (c_high_hval = NULL) => 0.0000523747, 0.0000523747), -0.0003622499);

// Tree: 157 
woFDN_FLA_S__lgt_157 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21894) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 13.2) => 0.1791643571,
   (c_blue_col > 13.2) => -0.0201684457,
   (c_blue_col = NULL) => 0.0688194127, 0.0688194127),
(r_A46_Curr_AVM_AutoVal_d > 21894) => 0.0061993640,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0123778662,
   (f_util_adl_count_n > 4.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0152189784,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.0756467526,
      (nf_seg_FraudPoint_3_0 = '') => 0.0333553356, 0.0333553356),
   (f_util_adl_count_n = NULL) => 
      map(
      (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0583047114,
      (k_nap_lname_verd_d > 0.5) => -0.0691119559,
      (k_nap_lname_verd_d = NULL) => -0.0108026336, -0.0108026336), -0.0061730314), 0.0013097683);

// Tree: 158 
woFDN_FLA_S__lgt_158 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 82.5) => 0.1446697161,
      (c_old_homes > 82.5) => -0.0132300878,
      (c_old_homes = NULL) => 0.0649819646, 0.0649819646),
   (r_D33_Eviction_Recency_d > 30) => -0.0005068083,
   (r_D33_Eviction_Recency_d = NULL) => 0.0000569779, 0.0000569779),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 543) => -0.1588580031,
   (r_A50_pb_total_dollars_d > 543) => 0.0018691189,
   (r_A50_pb_total_dollars_d = NULL) => -0.0641831230, -0.0641831230),
(r_I60_inq_comm_count12_i = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 99) => 0.0486779821,
   (c_rental > 99) => -0.0424574029,
   (c_rental = NULL) => 0.0017830753, 0.0017830753), -0.0006674355);

// Tree: 159 
woFDN_FLA_S__lgt_159 := map(
(NULL < c_retail and c_retail <= 0.05) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 46.25) => -0.0209761075,
   (c_famotf18_p > 46.25) => 0.0686208337,
   (c_famotf18_p = NULL) => -0.0184494589, -0.0184494589),
(c_retail > 0.05) => 
   map(
   (NULL < c_retail and c_retail <= 1.85) => 
      map(
      (NULL < f_hh_college_attendees_d and f_hh_college_attendees_d <= 0.5) => 
         map(
         (NULL < c_food and c_food <= 13.05) => 0.0809555383,
         (c_food > 13.05) => 0.3347294283,
         (c_food = NULL) => 0.1425511427, 0.1425511427),
      (f_hh_college_attendees_d > 0.5) => -0.0382774783,
      (f_hh_college_attendees_d = NULL) => 0.0854789866, 0.0854789866),
   (c_retail > 1.85) => 0.0062785560,
   (c_retail = NULL) => 0.0090040038, 0.0090040038),
(c_retail = NULL) => 0.0210740403, 0.0014537693);

// Tree: 160 
woFDN_FLA_S__lgt_160 := map(
(NULL < c_hval_40k_p and c_hval_40k_p <= 21.75) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 4.25) => 0.0501383383,
   (c_high_ed > 4.25) => -0.0048494828,
   (c_high_ed = NULL) => -0.0034174611, -0.0034174611),
(c_hval_40k_p > 21.75) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 3.35) => -0.0833192701,
   (c_pop_65_74_p > 3.35) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 57.4) => 0.2022868188,
      (c_low_hval > 57.4) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 66.2) => 0.1247184235,
         (c_low_ed > 66.2) => -0.0744762193,
         (c_low_ed = NULL) => 0.0203783725, 0.0203783725),
      (c_low_hval = NULL) => 0.1067848845, 0.1067848845),
   (c_pop_65_74_p = NULL) => 0.0629146950, 0.0629146950),
(c_hval_40k_p = NULL) => -0.0159190271, -0.0023446660);

// Tree: 161 
woFDN_FLA_S__lgt_161 := map(
(NULL < c_rape and c_rape <= 123.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 33.15) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 3.5) => -0.0001096725,
      (f_inq_Collection_count24_i > 3.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 108.5) => -0.0358377517,
         (c_sub_bus > 108.5) => 0.1337850150,
         (c_sub_bus = NULL) => 0.0622100903, 0.0622100903),
      (f_inq_Collection_count24_i = NULL) => -0.0150451238, 0.0009519250),
   (c_hval_20k_p > 33.15) => 0.1543884982,
   (c_hval_20k_p = NULL) => 0.0018157013, 0.0018157013),
(c_rape > 123.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 11.5) => -0.0780807856,
   (f_mos_inq_banko_cm_lseen_d > 11.5) => -0.0178392542,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0215514558, -0.0215514558),
(c_rape = NULL) => -0.0293395974, -0.0047127136);

// Tree: 162 
woFDN_FLA_S__lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0014547588,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_rental and c_rental <= 123.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 11.5) => 0.0312383643,
      (f_rel_educationover12_count_d > 11.5) => 0.1744341520,
      (f_rel_educationover12_count_d = NULL) => 0.0984166351, 0.0984166351),
   (c_rental > 123.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 4.65) => 0.0458908913,
      (c_hval_150k_p > 4.65) => -0.0875506523,
      (c_hval_150k_p = NULL) => -0.0239574167, -0.0239574167),
   (c_rental = NULL) => 0.0444032605, 0.0444032605),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.45) => -0.0424042592,
   (c_pop_55_64_p > 9.45) => 0.0621553818,
   (c_pop_55_64_p = NULL) => 0.0154924015, 0.0154924015), -0.0002308026);

// Tree: 163 
woFDN_FLA_S__lgt_163 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 107.5) => -0.0238577772,
   (c_many_cars > 107.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 9.5) => 0.0053840082,
      (f_util_adl_count_n > 9.5) => 0.2000566421,
      (f_util_adl_count_n = NULL) => 0.0089273761, 0.0089273761),
   (c_many_cars = NULL) => -0.0093547366, -0.0093547366),
(c_pop_35_44_p > 14.75) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27707.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => 0.0371574682,
      (f_corrrisktype_i > 7.5) => 0.1222828964,
      (f_corrrisktype_i = NULL) => 0.0672017370, 0.0672017370),
   (f_curraddrmedianincome_d > 27707.5) => 0.0059405137,
   (f_curraddrmedianincome_d = NULL) => 0.0325821258, 0.0088925315),
(c_pop_35_44_p = NULL) => 0.0089675629, -0.0001035251);

// Tree: 164 
woFDN_FLA_S__lgt_164 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0000230778,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_rich_blk and c_rich_blk <= 181.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 108.5) => 0.1410265886,
         (c_bel_edu > 108.5) => 0.0037393582,
         (c_bel_edu = NULL) => 0.0755906189, 0.0755906189),
      (r_F01_inp_addr_address_score_d > 25) => 0.0151791095,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0226433491, 0.0226433491),
   (c_rich_blk > 181.5) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 105.5) => 0.0169629217,
      (c_no_teens > 105.5) => 0.2185618586,
      (c_no_teens = NULL) => 0.1234680205, 0.1234680205),
   (c_rich_blk = NULL) => 0.0449977733, 0.0345925482),
(r_L70_Add_Standardized_i = NULL) => 0.0029499688, 0.0029499688);

// Tree: 165 
woFDN_FLA_S__lgt_165 := map(
(NULL < f_liens_rel_O_total_amt_i and f_liens_rel_O_total_amt_i <= 29.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 20.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 47.5) => 0.0271152109,
      (c_exp_prod > 47.5) => -0.0003405437,
      (c_exp_prod = NULL) => 0.0104273004, 0.0033523431),
   (f_rel_incomeover50_count_d > 20.5) => -0.0462290313,
   (f_rel_incomeover50_count_d = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 93.5) => -0.0266071156,
      (c_many_cars > 93.5) => 0.1502085926,
      (c_many_cars = NULL) => 0.0278621784, 0.0278621784), 0.0024932836),
(f_liens_rel_O_total_amt_i > 29.5) => -0.1089096617,
(f_liens_rel_O_total_amt_i = NULL) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.4) => -0.0503336125,
   (c_hval_175k_p > 2.4) => 0.0549730775,
   (c_hval_175k_p = NULL) => -0.0001407042, -0.0001407042), 0.0013814425);

// Tree: 166 
woFDN_FLA_S__lgt_166 := map(
(NULL < c_asian_lang and c_asian_lang <= 194.5) => 
   map(
   (NULL < c_info and c_info <= 23.35) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 3.65) => -0.0188770516,
         (c_femdiv_p > 3.65) => 0.1040385370,
         (c_femdiv_p = NULL) => 0.0557284300, 0.0557284300),
      (r_D32_Mos_Since_Crim_LS_d > 10.5) => -0.0000929831,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0005761236, 0.0008652566),
   (c_info > 23.35) => 0.1376812595,
   (c_info = NULL) => 0.0018338655, 0.0018338655),
(c_asian_lang > 194.5) => -0.0514077917,
(c_asian_lang = NULL) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 0.1112977292,
   (k_estimated_income_d > 27500) => -0.0459811104,
   (k_estimated_income_d = NULL) => 0.0197473599, 0.0197473599), -0.0000820949);

// Tree: 167 
woFDN_FLA_S__lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 57.25) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00180917015) => 0.1064717058,
         (f_add_curr_nhood_VAC_pct_i > 0.00180917015) => 0.0003643760,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0103599940, 0.0103599940),
      (c_rnt750_p > 57.25) => 0.1314513343,
      (c_rnt750_p = NULL) => 0.0184327500, 0.0184327500),
   (r_C12_source_profile_d > 81.3) => 0.1919181341,
   (r_C12_source_profile_d = NULL) => 0.0267319588, 0.0267319588),
(c_many_cars > 22.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.49) => -0.0066135385,
   (c_hhsize > 4.49) => -0.1157121646,
   (c_hhsize = NULL) => -0.0071928745, -0.0071928745),
(c_many_cars = NULL) => 0.0098744868, -0.0038662224);

// Tree: 168 
woFDN_FLA_S__lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0055286964,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.05) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 127.5) => -0.0064779962,
      (c_easiqlife > 127.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 76.3) => 0.1258158919,
         (c_fammar_p > 76.3) => -0.0164318939,
         (c_fammar_p = NULL) => 0.0720632724, 0.0720632724),
      (c_easiqlife = NULL) => 0.0157719454, 0.0157719454),
   (r_C12_source_profile_d > 81.05) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 1.05) => 0.2820430734,
      (c_hval_80k_p > 1.05) => 0.0220606953,
      (c_hval_80k_p = NULL) => 0.1520518844, 0.1520518844),
   (r_C12_source_profile_d = NULL) => 0.0315086589, 0.0315086589),
(c_hval_150k_p = NULL) => -0.0096851463, -0.0030763646);

// Tree: 169 
woFDN_FLA_S__lgt_169 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 36.85) => -0.0049230193,
(c_hval_500k_p > 36.85) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 47) => 0.2181572287,
      (c_rich_wht > 47) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 4.25) => -0.0620901506,
         (c_femdiv_p > 4.25) => 0.1747950778,
         (c_femdiv_p = NULL) => 0.0552658341, 0.0552658341),
      (c_rich_wht = NULL) => 0.1078767193, 0.1078767193),
   (f_rel_incomeover100_count_d > 0.5) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0059791935) => 0.1317442716,
      (f_add_input_nhood_VAC_pct_i > 0.0059791935) => -0.0760495978,
      (f_add_input_nhood_VAC_pct_i = NULL) => -0.0101914315, -0.0101914315),
   (f_rel_incomeover100_count_d = NULL) => 0.0450672088, 0.0450672088),
(c_hval_500k_p = NULL) => 0.0001578087, -0.0034177307);

// Tree: 170 
woFDN_FLA_S__lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 96.5) => -0.0138248292,
   (c_easiqlife > 96.5) => 
      map(
      (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 2.5) => 
         map(
         (NULL < c_highrent and c_highrent <= 99.95) => 0.0141398346,
         (c_highrent > 99.95) => 
            map(
            (NULL < c_bargains and c_bargains <= 28.5) => 0.0311323237,
            (c_bargains > 28.5) => 0.2511821817,
            (c_bargains = NULL) => 0.1139962870, 0.1139962870),
         (c_highrent = NULL) => 0.0175786952, 0.0175786952),
      (f_hh_members_w_derog_i > 2.5) => -0.0277260623,
      (f_hh_members_w_derog_i = NULL) => 0.0131814340, 0.0131814340),
   (c_easiqlife = NULL) => -0.0320243345, 0.0024517955),
(f_util_adl_count_n > 13.5) => 0.1285892855,
(f_util_adl_count_n = NULL) => 0.0090994389, 0.0034959771);

// Tree: 171 
woFDN_FLA_S__lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 40.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 16) => 
      map(
      (NULL < c_construction and c_construction <= 5.15) => 0.1315722906,
      (c_construction > 5.15) => -0.0003788953,
      (c_construction = NULL) => 0.0679362577, 0.0679362577),
   (r_F01_inp_addr_address_score_d > 16) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0562029553) => -0.0038042151,
      (f_add_curr_nhood_BUS_pct_i > 0.0562029553) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33207) => 0.1222102049,
         (f_curraddrmedianincome_d > 33207) => 0.0266089935,
         (f_curraddrmedianincome_d = NULL) => 0.0461738926, 0.0461738926),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0603766235, 0.0174723837),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0212753132, 0.0212753132),
(f_mos_inq_banko_cm_lseen_d > 40.5) => -0.0017773580,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0151854250, 0.0017788736);

// Tree: 172 
woFDN_FLA_S__lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.55) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 15.5) => 
         map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0388486953,
         (f_corrssnaddrcount_d > 0.5) => 0.0027726512,
         (f_corrssnaddrcount_d = NULL) => 0.0018164350, 0.0018164350),
      (f_inq_count24_i > 15.5) => -0.0920980793,
      (f_inq_count24_i = NULL) => 0.0171969085, 0.0012859717),
   (c_manufacturing > 16.55) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0405825159,
      (f_varrisktype_i > 2.5) => -0.0952017015,
      (f_varrisktype_i = NULL) => -0.0459863289, -0.0459863289),
   (c_manufacturing = NULL) => -0.0023574171, -0.0023574171),
(c_pop_0_5_p > 20.55) => 0.1344892551,
(c_pop_0_5_p = NULL) => 0.0009086267, -0.0016642511);

// Tree: 173 
woFDN_FLA_S__lgt_173 := map(
(NULL < c_low_hval and c_low_hval <= 71.55) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0057033088,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 0.1061741228,
      (r_C12_Num_NonDerogs_d > 1.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 167.5) => -0.0026852974,
         (r_C13_Curr_Addr_LRes_d > 167.5) => 
            map(
            (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 19.5) => 0.0367392391,
            (f_rel_under500miles_cnt_d > 19.5) => 0.2147177875,
            (f_rel_under500miles_cnt_d = NULL) => 0.0689448812, 0.0689448812),
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0110144635, 0.0110144635),
      (r_C12_Num_NonDerogs_d = NULL) => 0.0174266943, 0.0174266943),
   (f_rel_felony_count_i = NULL) => 0.0042155624, -0.0023070597),
(c_low_hval > 71.55) => -0.1021799370,
(c_low_hval = NULL) => -0.0399357246, -0.0037693428);

// Tree: 174 
woFDN_FLA_S__lgt_174 := map(
(NULL < c_info and c_info <= 27.55) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 1.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 26.5) => 0.1999198647,
         (r_C13_max_lres_d > 26.5) => 0.0480859614,
         (r_C13_max_lres_d = NULL) => 0.0729553076, 0.0729553076),
      (f_rel_count_i > 1.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 37815.5) => -0.0564161543,
         (r_L80_Inp_AVM_AutoVal_d > 37815.5) => 0.0050225505,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0014700510, 0.0011925388),
      (f_rel_count_i = NULL) => 0.0033297612, 0.0033297612),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0530212800,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0311185601, 0.0006408648),
(c_info > 27.55) => 0.2012286047,
(c_info = NULL) => -0.0052952609, 0.0015422608);

// Tree: 175 
woFDN_FLA_S__lgt_175 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0117398375,
(f_hh_collections_ct_i > 1.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0111736487,
      (f_hh_collections_ct_i > 2.5) => 
         map(
         (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 
            map(
            (NULL < c_retail and c_retail <= 4.15) => -0.0349281542,
            (c_retail > 4.15) => 0.1323522416,
            (c_retail = NULL) => 0.0797398590, 0.0797398590),
         (f_inq_Other_count_i > 0.5) => 0.2159484254,
         (f_inq_Other_count_i = NULL) => 0.1063984164, 0.1063984164),
      (f_hh_collections_ct_i = NULL) => 0.0436773011, 0.0436773011),
   (k_nap_fname_verd_d > 0.5) => 0.0004153398,
   (k_nap_fname_verd_d = NULL) => 0.0120998504, 0.0120998504),
(f_hh_collections_ct_i = NULL) => 0.0016601765, -0.0049522636);

// Tree: 176 
woFDN_FLA_S__lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 24.75) => 0.0036864647,
      (c_hval_40k_p > 24.75) => 0.0951638251,
      (c_hval_40k_p = NULL) => 0.0048779809, 0.0048779809),
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_robbery and c_robbery <= 165.5) => 0.0189895723,
         (c_robbery > 165.5) => 0.1629199062,
         (c_robbery = NULL) => 0.0323784405, 0.0323784405),
      (c_pop_55_64_p > 17.45) => 0.2069718831,
      (c_pop_55_64_p = NULL) => 0.0474984609, 0.0474984609),
   (f_util_adl_count_n = NULL) => 0.0107815580, 0.0076652219),
(c_pop_18_24_p > 11.15) => -0.0236602094,
(c_pop_18_24_p = NULL) => 0.0204921488, 0.0008324239);

// Tree: 177 
woFDN_FLA_S__lgt_177 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 104.5) => -0.0052002417,
(f_prevaddrageoldest_d > 104.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 556.25) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 113500) => 0.0110711728,
      (k_estimated_income_d > 113500) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 35.5) => 0.1676599021,
         (c_born_usa > 35.5) => 0.0271012622,
         (c_born_usa = NULL) => 0.0703221360, 0.0703221360),
      (k_estimated_income_d = NULL) => 0.0163279639, 0.0163279639),
   (c_oldhouse > 556.25) => 0.0958943083,
   (c_oldhouse = NULL) => 0.0458061994, 0.0182758768),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 114.5) => -0.0582244076,
   (c_new_homes > 114.5) => 0.0406015531,
   (c_new_homes = NULL) => -0.0092565892, -0.0092565892), 0.0031577555);

// Tree: 178 
woFDN_FLA_S__lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 14.55) => -0.0080398975,
(c_rnt1250_p > 14.55) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.35) => 0.0070710195,
   (c_pop_6_11_p > 9.35) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 116105.5) => 0.1480801620,
      (r_A46_Curr_AVM_AutoVal_d > 116105.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 19.95) => 0.1088557215,
         (c_hh4_p > 19.95) => -0.0143967664,
         (c_hh4_p = NULL) => 0.0424889972, 0.0424889972),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_retail and c_retail <= 28.4) => 0.0190147321,
         (c_retail > 28.4) => 0.1993163420,
         (c_retail = NULL) => 0.0488839747, 0.0488839747), 0.0564085284),
   (c_pop_6_11_p = NULL) => 0.0215591248, 0.0215591248),
(c_rnt1250_p = NULL) => 0.0025332383, 0.0007735225);

// Tree: 179 
woFDN_FLA_S__lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0010499355,
   (f_assocsuspicousidcount_i > 13.5) => 0.0977176524,
   (f_assocsuspicousidcount_i = NULL) => -0.0005685802, -0.0005685802),
(f_rel_incomeover50_count_d > 22.5) => -0.0600433961,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.85) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 158.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0405233617) => 0.0730529805,
         (f_add_input_nhood_VAC_pct_i > 0.0405233617) => 0.1643848993,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.1105769471, 0.1105769471),
      (c_asian_lang > 158.5) => -0.0207161018,
      (c_asian_lang = NULL) => 0.0548946272, 0.0548946272),
   (c_pop_45_54_p > 16.85) => -0.0899646148,
   (c_pop_45_54_p = NULL) => 0.0160761375, 0.0160761375), -0.0013810379);

// Tree: 180 
woFDN_FLA_S__lgt_180 := map(
(NULL < k_inq_adls_per_ssn_i and k_inq_adls_per_ssn_i <= 1.5) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 78.5) => 0.0028258244,
      (f_addrchangecrimediff_i > 78.5) => 0.0936128738,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < c_rnt500_p and c_rnt500_p <= 1.65) => 
            map(
            (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => 0.0138683518,
            (f_phones_per_addr_curr_i > 4.5) => 0.1268312702,
            (f_phones_per_addr_curr_i = NULL) => 0.0522467792, 0.0522467792),
         (c_rnt500_p > 1.65) => -0.0211120592,
         (c_rnt500_p = NULL) => 0.0292780817, 0.0068344812), 0.0045938206),
   (f_rel_incomeover100_count_d > 0.5) => -0.0137142866,
   (f_rel_incomeover100_count_d = NULL) => 0.0233873649, -0.0020562061),
(k_inq_adls_per_ssn_i > 1.5) => 0.1261527299,
(k_inq_adls_per_ssn_i = NULL) => -0.0015104211, -0.0015104211);

// Tree: 181 
woFDN_FLA_S__lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 5.35) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1951.5) => 0.1082890856,
      (c_med_yearblt > 1951.5) => -0.0273485408,
      (c_med_yearblt = NULL) => -0.0027102454, -0.0027102454),
   (c_hval_200k_p > 5.35) => 
      map(
      (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 2.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 15.5) => 0.2306364779,
         (f_M_Bureau_ADL_FS_all_d > 15.5) => 0.0503675503,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1474354344, 0.1474354344),
      (f_addrchangeecontrajindex_d > 2.5) => -0.0049525840,
      (f_addrchangeecontrajindex_d = NULL) => 0.0828769635, 0.0828769635),
   (c_hval_200k_p = NULL) => 0.0242074262, 0.0242074262),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0040704448,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0210484623, -0.0020848493);

// Tree: 182 
woFDN_FLA_S__lgt_182 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0018830005,
(f_hh_tot_derog_i > 4.5) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.65) => -0.0230977112,
   (c_hval_175k_p > 2.65) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.2064969155,
      (r_D30_Derog_Count_i > 0.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 55.25) => -0.0819114141,
         (c_civ_emp > 55.25) => 
            map(
            (NULL < c_hh5_p and c_hh5_p <= 8.35) => 0.0211992047,
            (c_hh5_p > 8.35) => 0.1623094156,
            (c_hh5_p = NULL) => 0.0704546557, 0.0704546557),
         (c_civ_emp = NULL) => 0.0368444932, 0.0368444932),
      (r_D30_Derog_Count_i = NULL) => 0.0772379271, 0.0772379271),
   (c_hval_175k_p = NULL) => 0.0355272035, 0.0355272035),
(f_hh_tot_derog_i = NULL) => 0.0013373605, -0.0000272544);

// Tree: 183 
woFDN_FLA_S__lgt_183 := map(
(NULL < c_oldhouse and c_oldhouse <= 613.2) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 189) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0038445198,
      (k_inq_adls_per_addr_i > 3.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 43.3) => 0.0098325788,
         (r_C12_source_profile_d > 43.3) => -0.0894158013,
         (r_C12_source_profile_d = NULL) => -0.0521976587, -0.0521976587),
      (k_inq_adls_per_addr_i = NULL) => -0.0048105917, -0.0048105917),
   (c_totcrime > 189) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 0.1404339239,
      (r_C12_Num_NonDerogs_d > 2.5) => 0.0210338489,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0566085288, 0.0566085288),
   (c_totcrime = NULL) => -0.0032916077, -0.0032916077),
(c_oldhouse > 613.2) => -0.0552329340,
(c_oldhouse = NULL) => 0.0169136470, -0.0044273009);

// Tree: 184 
woFDN_FLA_S__lgt_184 := map(
(NULL < c_families and c_families <= 106) => -0.0707784380,
(c_families > 106) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -13335) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 35.2) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -17980) => -0.0199277940,
         (f_addrchangeincomediff_d > -17980) => 0.1339310781,
         (f_addrchangeincomediff_d = NULL) => 0.0131810772, 0.0131810772),
      (c_rnt1000_p > 35.2) => 0.1408017136,
      (c_rnt1000_p = NULL) => 0.0372192108, 0.0372192108),
   (f_addrchangeincomediff_d > -13335) => -0.0014242873,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0017629818,
      (f_util_adl_count_n > 6.5) => 0.0810535533,
      (f_util_adl_count_n = NULL) => 0.0013272359, 0.0086134606), 0.0015773772),
(c_families = NULL) => 0.0222358965, 0.0009162046);

// Tree: 185 
woFDN_FLA_S__lgt_185 := map(
(NULL < c_high_ed and c_high_ed <= 4.25) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < c_retired and c_retired <= 11.45) => 
         map(
         (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 0.5) => 0.1303313170,
         (r_C14_addrs_5yr_i > 0.5) => -0.0097707823,
         (r_C14_addrs_5yr_i = NULL) => 0.0372095624, 0.0372095624),
      (c_retired > 11.45) => 0.1872455838,
      (c_retired = NULL) => 0.0824086985, 0.0824086985),
   (r_C12_Num_NonDerogs_d > 3.5) => -0.0269579069,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0390487060, 0.0390487060),
(c_high_ed > 4.25) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 0.0011845504,
   (f_rel_felony_count_i > 4.5) => 0.0769821699,
   (f_rel_felony_count_i = NULL) => -0.0120690505, 0.0014676669),
(c_high_ed = NULL) => -0.0106243441, 0.0023628297);

// Tree: 186 
woFDN_FLA_S__lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 133.6) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.99152143005) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 236.5) => -0.0046877322,
         (c_oldhouse > 236.5) => 0.0588558146,
         (c_oldhouse = NULL) => 0.0000374817, 0.0000374817),
      (f_add_input_nhood_SFD_pct_d > 0.99152143005) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.9919696628) => 0.2082131481,
         (f_add_curr_nhood_SFD_pct_d > 0.9919696628) => 0.0512604791,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0692402322, 0.0692402322),
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.0097939781, 0.0097939781),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 133.6) => -0.0424174221,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0007585277, 0.0019314872),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0747210084,
(f_inq_PrepaidCards_count_i = NULL) => 0.0256036894, 0.0024279677);

// Tree: 187 
woFDN_FLA_S__lgt_187 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 80.45) => -0.0041876450,
      (c_high_hval > 80.45) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00279031755) => -0.0966769799,
         (f_add_curr_nhood_BUS_pct_i > 0.00279031755) => 0.0524437276,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0387056390, 0.0387056390),
      (c_high_hval = NULL) => -0.0052434570, -0.0019750428),
   (f_rel_bankrupt_count_i > 7.5) => -0.0805789310,
   (f_rel_bankrupt_count_i = NULL) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.85) => -0.0536471288,
      (c_pop_0_5_p > 7.85) => 0.0368709669,
      (c_pop_0_5_p = NULL) => -0.0083880810, -0.0083880810), -0.0030276759),
(r_L72_Add_Vacant_i > 0.5) => 0.1133170144,
(r_L72_Add_Vacant_i = NULL) => -0.0022566950, -0.0022566950);

// Tree: 188 
woFDN_FLA_S__lgt_188 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 11.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 0.0003330927,
   (f_srchfraudsrchcount_i > 12.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.15) => 
         map(
         (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0503171703,
         (r_E57_br_source_count_d > 0.5) => -0.0809429314,
         (r_E57_br_source_count_d = NULL) => -0.0140975092, -0.0140975092),
      (c_pop_45_54_p > 14.15) => 0.1293735379,
      (c_pop_45_54_p = NULL) => 0.0418318820, 0.0418318820),
   (f_srchfraudsrchcount_i = NULL) => 0.0009269812, 0.0009269812),
(r_L79_adls_per_addr_curr_i > 11.5) => -0.0621745703,
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 90.5) => -0.0428026475,
   (c_burglary > 90.5) => 0.0502853959,
   (c_burglary = NULL) => 0.0028951193, 0.0028951193), 0.0002830601);

// Tree: 189 
woFDN_FLA_S__lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 38.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0054546130,
   (f_rel_homeover500_count_d > 14.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 45.5) => 0.1811144387,
      (f_fp_prevaddrburglaryindex_i > 45.5) => -0.0414487434,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0719325003, 0.0719325003),
   (f_rel_homeover500_count_d = NULL) => 0.0056376248, -0.0046098018),
(f_phones_per_addr_curr_i > 38.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 55.5) => 0.0769284263,
      (c_many_cars > 55.5) => -0.0855955959,
      (c_many_cars = NULL) => -0.0130848783, -0.0130848783),
   (f_rel_under25miles_cnt_d > 4.5) => 0.1429493750,
   (f_rel_under25miles_cnt_d = NULL) => 0.0514092797, 0.0514092797),
(f_phones_per_addr_curr_i = NULL) => -0.0049200953, -0.0035833544);

// Tree: 190 
woFDN_FLA_S__lgt_190 := map(
(NULL < c_hh2_p and c_hh2_p <= 51.15) => -0.0075893207,
(c_hh2_p > 51.15) => 
   map(
   (NULL < c_rape and c_rape <= 14.5) => 0.2674862576,
   (c_rape > 14.5) => 
      map(
      (NULL < f_varmsrcssnunrelcount_i and f_varmsrcssnunrelcount_i <= 0.5) => 0.1765260094,
      (f_varmsrcssnunrelcount_i > 0.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 12.8) => -0.0657913857,
         (c_hh3_p > 12.8) => 
            map(
            (NULL < c_mort_indx and c_mort_indx <= 100.5) => 0.1929010404,
            (c_mort_indx > 100.5) => -0.0259823718,
            (c_mort_indx = NULL) => 0.0719391547, 0.0719391547),
         (c_hh3_p = NULL) => -0.0218102047, -0.0218102047),
      (f_varmsrcssnunrelcount_i = NULL) => 0.0181232612, 0.0181232612),
   (c_rape = NULL) => 0.0443980899, 0.0443980899),
(c_hh2_p = NULL) => -0.0255426227, -0.0059425450);

// Tree: 191 
woFDN_FLA_S__lgt_191 := map(
(NULL < c_totcrime and c_totcrime <= 163.5) => -0.0053922000,
(c_totcrime > 163.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 13.5) => 0.0001418114,
      (f_rel_ageover30_count_d > 13.5) => 0.0869520365,
      (f_rel_ageover30_count_d = NULL) => 0.0127368670, 0.0127368670),
   (f_varrisktype_i > 2.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 4.55) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0386106142) => -0.0435478605,
         (f_add_curr_nhood_BUS_pct_i > 0.0386106142) => 0.0436019196,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0090186735, 0.0090186735),
      (c_hval_175k_p > 4.55) => 0.1539665670,
      (c_hval_175k_p = NULL) => 0.0656173748, 0.0656173748),
   (f_varrisktype_i = NULL) => 0.0211880897, 0.0211880897),
(c_totcrime = NULL) => -0.0326120953, -0.0032234040);

// Tree: 192 
woFDN_FLA_S__lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 238) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 114.5) => 0.1675014332,
   (c_bel_edu > 114.5) => -0.0290505425,
   (c_bel_edu = NULL) => 0.0717891668, 0.0717891668),
(r_D32_Mos_Since_Fel_LS_d > 238) => 
   map(
   (NULL < c_unempl and c_unempl <= 165.5) => -0.0000097793,
   (c_unempl > 165.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog']) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.33252650905) => -0.0951085451,
         (f_add_curr_mobility_index_i > 0.33252650905) => -0.0424781083,
         (f_add_curr_mobility_index_i = NULL) => -0.0801117002, -0.0801117002),
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0140054195,
      (nf_seg_FraudPoint_3_0 = '') => -0.0285317115, -0.0285317115),
   (c_unempl = NULL) => -0.0030968877, -0.0020272451),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0025373188, -0.0013624214);

// Tree: 193 
woFDN_FLA_S__lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0082766361,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 14.35) => 0.1985437108,
      (C_INC_75K_P > 14.35) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0744772866) => 0.2454640826,
         (f_add_input_nhood_MFD_pct_i > 0.0744772866) => -0.0124879517,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0713860226, 0.0713860226),
      (C_INC_75K_P = NULL) => 0.1075770570, 0.1075770570),
   (f_hh_members_ct_d > 1.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 92.25) => 0.0071932903,
      (c_highrent > 92.25) => 0.1272176704,
      (c_highrent = NULL) => 0.0120811610, 0.0120811610),
   (f_hh_members_ct_d = NULL) => 0.0207128305, 0.0207128305),
(f_prevaddrageoldest_d = NULL) => -0.0171733196, -0.0015812754);

// Tree: 194 
woFDN_FLA_S__lgt_194 := map(
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 356) => -0.1100092690,
   (c_med_rent > 356) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 15.5) => -0.0339952393,
      (c_vacant_p > 15.5) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 3.15) => -0.0141085356,
         (c_hh5_p > 3.15) => 0.1160381059,
         (c_hh5_p = NULL) => 0.0487208775, 0.0487208775),
      (c_vacant_p = NULL) => -0.0216463724, -0.0216463724),
   (c_med_rent = NULL) => -0.0124730708, -0.0261014508),
(nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 331.5) => 0.0100967483,
   (f_M_Bureau_ADL_FS_noTU_d > 331.5) => -0.0281318183,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0115563394, 0.0026538878),
(nf_seg_FraudPoint_3_0 = '') => 0.0006409007, 0.0006409007);

// Tree: 195 
woFDN_FLA_S__lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 2.35) => 
         map(
         (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 4.5) => -0.0335410856,
         (f_inq_Collection_count_i > 4.5) => -0.1565077509,
         (f_inq_Collection_count_i = NULL) => -0.0447198734, -0.0447198734),
      (c_pop_18_24_p > 2.35) => 0.0071940659,
      (c_pop_18_24_p = NULL) => 0.0045006410, 0.0045006410),
   (f_fp_prevaddrcrimeindex_i > 197.5) => -0.0956027658,
   (f_fp_prevaddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_assault and c_assault <= 93) => -0.0686359271,
      (c_assault > 93) => 0.0310077291,
      (c_assault = NULL) => -0.0248270783, -0.0248270783), 0.0037090127),
(c_hval_80k_p > 40.05) => -0.1109975437,
(c_hval_80k_p = NULL) => 0.0201331908, 0.0030446282);

// Tree: 196 
woFDN_FLA_S__lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0813244573,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 25.75) => -0.0281357110,
      (c_vacant_p > 25.75) => 0.1456549824,
      (c_vacant_p = NULL) => -0.0728706520, -0.0239050455),
   (f_addrs_per_ssn_i > 4.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 176.5) => 0.0032843160,
      (c_unempl > 176.5) => 0.0462197714,
      (c_unempl = NULL) => 0.0290079515, 0.0055025686),
   (f_addrs_per_ssn_i = NULL) => -0.0016127965, -0.0016127965),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.595) => 0.0824642092,
   (c_hhsize > 2.595) => -0.0313204220,
   (c_hhsize = NULL) => 0.0201300199, 0.0201300199), -0.0034036855);

// Tree: 197 
woFDN_FLA_S__lgt_197 := map(
(NULL < f_liens_unrel_FT_total_amt_i and f_liens_unrel_FT_total_amt_i <= 32380) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.29930675705) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 23.75) => 0.0009789300,
      (c_hh3_p > 23.75) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 44815) => 0.1176436796,
         (f_curraddrmedianincome_d > 44815) => 0.0276258152,
         (f_curraddrmedianincome_d = NULL) => 0.0429723722, 0.0429723722),
      (c_hh3_p = NULL) => -0.0745451197, 0.0060515472),
   (f_add_input_mobility_index_i > 0.29930675705) => -0.0118145835,
   (f_add_input_mobility_index_i = NULL) => 0.0947750341, 0.0006005383),
(f_liens_unrel_FT_total_amt_i > 32380) => -0.1193246080,
(f_liens_unrel_FT_total_amt_i = NULL) => 
   map(
   (NULL < c_incollege and c_incollege <= 5.65) => -0.0451988070,
   (c_incollege > 5.65) => 0.0490722515,
   (c_incollege = NULL) => -0.0020578141, -0.0020578141), -0.0000113921);

// Tree: 198 
woFDN_FLA_S__lgt_198 := map(
(NULL < c_blue_col and c_blue_col <= 29.95) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 24.5) => -0.0323589639,
   (r_A50_pb_average_dollars_d > 24.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 26.85) => 
         map(
         (NULL < f_rel_count_i and f_rel_count_i <= 8.5) => 0.0165827809,
         (f_rel_count_i > 8.5) => -0.0831461994,
         (f_rel_count_i = NULL) => -0.0368631367, -0.0368631367),
      (c_fammar_p > 26.85) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 0.0089888906,
         (f_rel_felony_count_i > 4.5) => 0.0761016766,
         (f_rel_felony_count_i = NULL) => 0.0093298211, 0.0093298211),
      (c_fammar_p = NULL) => 0.0085564490, 0.0085564490),
   (r_A50_pb_average_dollars_d = NULL) => 0.0016876712, 0.0038322077),
(c_blue_col > 29.95) => -0.1097253796,
(c_blue_col = NULL) => -0.0325591417, 0.0023438682);

// Tree: 199 
woFDN_FLA_S__lgt_199 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 93.25) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 184.5) => -0.0025264029,
   (c_sub_bus > 184.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 18774.5) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 438826) => 0.0003478537,
         (f_curraddrmedianvalue_d > 438826) => 0.2653098602,
         (f_curraddrmedianvalue_d = NULL) => 0.1024840462, 0.1024840462),
      (r_A49_Curr_AVM_Chg_1yr_i > 18774.5) => -0.0549261332,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
         map(
         (NULL < c_young and c_young <= 16.65) => 0.1269731077,
         (c_young > 16.65) => 0.0153516603,
         (c_young = NULL) => 0.0258025630, 0.0258025630), 0.0287224205),
   (c_sub_bus = NULL) => 0.0002097393, 0.0002097393),
(C_RENTOCC_P > 93.25) => -0.1109926905,
(C_RENTOCC_P = NULL) => -0.0385960807, -0.0013257319);

// Tree: 200 
woFDN_FLA_S__lgt_200 := map(
(NULL < c_hval_40k_p and c_hval_40k_p <= 22.85) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => -0.0053944288,
   (f_phones_per_addr_curr_i > 50.5) => 
      map(
      (NULL < c_apt20 and c_apt20 <= 186.5) => 
         map(
         (NULL < c_bargains and c_bargains <= 128) => -0.0774546079,
         (c_bargains > 128) => 0.0800774381,
         (c_bargains = NULL) => 0.0107163134, 0.0107163134),
      (c_apt20 > 186.5) => 0.1697388297,
      (c_apt20 = NULL) => 0.0545549530, 0.0545549530),
   (f_phones_per_addr_curr_i = NULL) => 0.0064860114, -0.0043938735),
(c_hval_40k_p > 22.85) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => 0.0066593715,
   (f_rel_under100miles_cnt_d > 8.5) => 0.1351448541,
   (f_rel_under100miles_cnt_d = NULL) => 0.0581747772, 0.0581747772),
(c_hval_40k_p = NULL) => -0.0313698456, -0.0039184702);

// Tree: 201 
woFDN_FLA_S__lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0061858824,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_larceny and c_larceny <= 178.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -16129) => 0.0995942075,
      (f_addrchangevaluediff_d > -16129) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 38.5) => 0.1210503486,
         (f_prevaddrmurderindex_i > 38.5) => -0.0258898681,
         (f_prevaddrmurderindex_i = NULL) => 0.0097076707, 0.0097076707),
      (f_addrchangevaluediff_d = NULL) => -0.0084170240, 0.0133297882),
   (c_larceny > 178.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 4.55) => -0.0090433213,
      (c_hval_175k_p > 4.55) => 0.2533955242,
      (c_hval_175k_p = NULL) => 0.1210545679, 0.1210545679),
   (c_larceny = NULL) => 0.0914327991, 0.0324757002),
(r_L70_Add_Standardized_i = NULL) => -0.0029734813, -0.0029734813);

// Tree: 202 
woFDN_FLA_S__lgt_202 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 0.75) => -0.0941015315,
(c_pop_0_5_p > 0.75) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 0.95) => 0.1866470353,
   (c_pop_25_34_p > 0.95) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 14.5) => 
         map(
         (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 1.5) => -0.0607688630,
         (f_phones_per_addr_c6_i > 1.5) => 0.0763143819,
         (f_phones_per_addr_c6_i = NULL) => -0.0444581560, -0.0444581560),
      (f_mos_inq_banko_om_fseen_d > 14.5) => 
         map(
         (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 0.0392946598,
         (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0010143383,
         (f_mos_inq_banko_om_fseen_d = NULL) => 0.0016128046, 0.0016128046),
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0028005963, -0.0012100175),
   (c_pop_25_34_p = NULL) => -0.0001350568, -0.0001350568),
(c_pop_0_5_p = NULL) => 0.0204656849, -0.0008731665);

// Tree: 203 
woFDN_FLA_S__lgt_203 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 16.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 32.05) => 
      map(
      (NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 2) => 0.1377143131,
      (r_I60_inq_retail_recency_d > 2) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 14.55) => -0.0106684417,
         (c_rnt1250_p > 14.55) => 0.0139221974,
         (c_rnt1250_p = NULL) => -0.0033940536, -0.0033940536),
      (r_I60_inq_retail_recency_d = NULL) => -0.0027831949, -0.0027831949),
   (C_INC_75K_P > 32.05) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 154408) => 0.1782210702,
      (r_L80_Inp_AVM_AutoVal_d > 154408) => -0.0352356432,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0650334976, 0.0685141114),
   (C_INC_75K_P = NULL) => -0.0126122955, -0.0018971871),
(f_inq_count24_i > 16.5) => -0.1139634955,
(f_inq_count24_i = NULL) => -0.0119825224, -0.0026711759);

// Tree: 204 
woFDN_FLA_S__lgt_204 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 81.45) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 109.5) => 0.0048636744,
   (f_addrchangecrimediff_i > 109.5) => 0.0844700576,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 14.5) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 148.5) => 
            map(
            (NULL < c_cartheft and c_cartheft <= 113) => 0.0480330306,
            (c_cartheft > 113) => 0.1909422420,
            (c_cartheft = NULL) => 0.0922049687, 0.0922049687),
         (c_cartheft > 148.5) => -0.0519721289,
         (c_cartheft = NULL) => 0.0571527385, 0.0571527385),
      (c_born_usa > 14.5) => -0.0107601129,
      (c_born_usa = NULL) => -0.0048920980, -0.0048920980), 0.0031465061),
(C_RENTOCC_P > 81.45) => -0.0499776889,
(C_RENTOCC_P = NULL) => -0.0052670303, 0.0013422514);

// Tree: 205 
woFDN_FLA_S__lgt_205 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5922.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 23374.5) => -0.0376130675,
   (f_prevaddrmedianincome_d > 23374.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 12.55) => 0.0025143558,
      (c_hh6_p > 12.55) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 0.5) => 0.1514251395,
         (f_util_adl_count_n > 0.5) => 0.0033835041,
         (f_util_adl_count_n = NULL) => 0.0627431937, 0.0627431937),
      (c_hh6_p = NULL) => 0.0035799430, 0.0035799430),
   (f_prevaddrmedianincome_d = NULL) => 0.0009769975, 0.0009769975),
(f_liens_unrel_ST_total_amt_i > 5922.5) => 0.1452122972,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 91.5) => 0.0549292123,
   (c_rich_nfam > 91.5) => -0.0399899421,
   (c_rich_nfam = NULL) => 0.0070420714, 0.0070420714), 0.0016014657);

// Tree: 206 
woFDN_FLA_S__lgt_206 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 30) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 35.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 28.45) => -0.0046133988,
      (c_hval_20k_p > 28.45) => 0.0798308479,
      (c_hval_20k_p = NULL) => 0.0120890714, -0.0034017607),
   (f_srchaddrsrchcount_i > 35.5) => -0.0783847226,
   (f_srchaddrsrchcount_i = NULL) => -0.0037792632, -0.0037792632),
(f_rel_homeover300_count_d > 30) => -0.0987565192,
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 51.55) => 0.0790924734,
   (c_fammar_p > 51.55) => 
      map(
      (NULL < c_larceny and c_larceny <= 29) => 0.0692823525,
      (c_larceny > 29) => -0.0536060291,
      (c_larceny = NULL) => -0.0258570397, -0.0258570397),
   (c_fammar_p = NULL) => -0.0070912328, -0.0070912328), -0.0042805391);

// Tree: 207 
woFDN_FLA_S__lgt_207 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.33268323845) => -0.0030934307,
      (f_add_curr_mobility_index_i > 0.33268323845) => -0.0729887929,
      (f_add_curr_mobility_index_i = NULL) => -0.0216894445, -0.0216894445),
   (r_F01_inp_addr_address_score_d > 75) => 0.0033915058,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0018311192, 0.0018311192),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.25) => -0.1131881782,
   (c_bigapt_p > 1.25) => 0.0057081833,
   (c_bigapt_p = NULL) => -0.0503750061, -0.0503750061),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 11.5) => 0.0336385941,
   (c_newhouse > 11.5) => -0.0666168887,
   (c_newhouse = NULL) => -0.0146325643, -0.0146325643), 0.0012482066);

// Tree: 208 
woFDN_FLA_S__lgt_208 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0105610607,
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 20.5) => -0.0562193036,
   (c_bel_edu > 20.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 38.7) => 0.0125881356,
         (c_fammar18_p > 38.7) => 
            map(
            (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => 0.0789825957,
            (f_crim_rel_under100miles_cnt_i > 0.5) => 0.1909860074,
            (f_crim_rel_under100miles_cnt_i = NULL) => 0.1185797614, 0.1185797614),
         (c_fammar18_p = NULL) => 0.0493179069, 0.0493179069),
      (f_prevaddrlenofres_d > 3.5) => 0.0094500997,
      (f_prevaddrlenofres_d = NULL) => 0.0162942615, 0.0162942615),
   (c_bel_edu = NULL) => 0.0236641850, 0.0084229864),
(f_corrrisktype_i = NULL) => -0.0122977849, -0.0042496994);

// Tree: 209 
woFDN_FLA_S__lgt_209 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => 
      map(
      (NULL < c_employees and c_employees <= 23.5) => 0.1352385589,
      (c_employees > 23.5) => 
         map(
         (NULL < c_murders and c_murders <= 98) => 0.1023694920,
         (c_murders > 98) => -0.0508425524,
         (c_murders = NULL) => -0.0130790203, -0.0130790203),
      (c_employees = NULL) => 0.0189319193, 0.0141303091),
   (f_rel_homeover200_count_d > 0.5) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 7.85) => 0.0121110493,
      (c_hval_60k_p > 7.85) => 0.1627216170,
      (c_hval_60k_p = NULL) => 0.0707456977, 0.0707456977),
   (f_rel_homeover200_count_d = NULL) => 0.0283082685, 0.0283082685),
(k_estimated_income_d > 27500) => 0.0005337276,
(k_estimated_income_d = NULL) => 0.0102054932, 0.0019483800);

// Tree: 210 
woFDN_FLA_S__lgt_210 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0012475994,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 25.35) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 9.95) => -0.0701342664,
      (C_INC_150K_P > 9.95) => 0.0323827520,
      (C_INC_150K_P = NULL) => -0.0514948085, -0.0514948085),
   (c_rnt1000_p > 25.35) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => -0.0307037773,
      (f_inq_QuizProvider_count_i > 1.5) => 0.1114217051,
      (f_inq_QuizProvider_count_i = NULL) => 0.0172421686, 0.0172421686),
   (c_rnt1000_p = NULL) => -0.0289892105, -0.0289892105),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 31.9) => 0.0543027010,
   (c_hh2_p > 31.9) => -0.0515914583,
   (c_hh2_p = NULL) => 0.0013556214, 0.0013556214), 0.0000280478);

// Tree: 211 
woFDN_FLA_S__lgt_211 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 18.5) => 0.0002629220,
   (f_rel_under100miles_cnt_d > 18.5) => -0.0428525332,
   (f_rel_under100miles_cnt_d = NULL) => 0.0094156523, -0.0020965623),
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 9.65) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.21552758275) => -0.0180931938,
      (f_add_curr_nhood_MFD_pct_i > 0.21552758275) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 406.5) => -0.0808842448,
         (r_A50_pb_total_dollars_d > 406.5) => 0.0577204565,
         (r_A50_pb_total_dollars_d = NULL) => 0.0033656716, 0.0033656716),
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1109471650, 0.0148673372),
   (c_pop_65_74_p > 9.65) => 0.1505882740,
   (c_pop_65_74_p = NULL) => 0.0346262325, 0.0346262325),
(f_srchaddrsrchcount_i = NULL) => -0.0200532436, -0.0010462311);

// Tree: 212 
woFDN_FLA_S__lgt_212 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 22.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0047953418) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 13.5) => 
         map(
         (NULL < c_no_car and c_no_car <= 7.5) => 0.1961587492,
         (c_no_car > 7.5) => -0.0307000334,
         (c_no_car = NULL) => -0.0148506711, -0.0148506711),
      (f_rel_ageover20_count_d > 13.5) => -0.0868625071,
      (f_rel_ageover20_count_d = NULL) => -0.0298087947, -0.0298087947),
   (f_add_curr_nhood_BUS_pct_i > 0.0047953418) => 0.0047005162,
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0239735683, -0.0004282381),
(f_srchaddrsrchcount_i > 22.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.23162687135) => 0.0431050007,
   (f_add_curr_nhood_MFD_pct_i > 0.23162687135) => 0.0065196198,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0246843893, 0.0246843893),
(f_srchaddrsrchcount_i = NULL) => 0.0230837058, 0.0001248356);

// Tree: 213 
woFDN_FLA_S__lgt_213 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 149006.5) => 0.0235248367,
   (r_A46_Curr_AVM_AutoVal_d > 149006.5) => -0.0122170073,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0005076757, -0.0001487117),
(k_comb_age_d > 73.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 165.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.03988102855) => 0.1676904829,
      (f_add_input_nhood_MFD_pct_i > 0.03988102855) => -0.0109247441,
      (f_add_input_nhood_MFD_pct_i = NULL) => -0.0113500613, 0.0332702373),
   (c_sub_bus > 165.5) => 0.1648702334,
   (c_sub_bus = NULL) => 0.0500839960, 0.0500839960),
(k_comb_age_d = NULL) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 8.95) => 0.0341887519,
   (C_INC_35K_P > 8.95) => -0.0438854757,
   (C_INC_35K_P = NULL) => 0.0004448061, 0.0004448061), 0.0015162401);

// Tree: 214 
woFDN_FLA_S__lgt_214 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0016646291,
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 8.5) => 0.0089722899,
      (f_rel_educationover12_count_d > 8.5) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 3.15) => -0.0997037175,
         (c_pop_18_24_p > 3.15) => 
            map(
            (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => 0.1586110865,
            (k_comb_age_d > 25.5) => 0.0426040494,
            (k_comb_age_d = NULL) => 0.0527567456, 0.0527567456),
         (c_pop_18_24_p = NULL) => 0.0412312199, 0.0412312199),
      (f_rel_educationover12_count_d = NULL) => 0.0242528357, 0.0242528357),
   (f_srchvelocityrisktype_i = NULL) => 0.0046106032, 0.0046106032),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0706727634,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0152301251, 0.0041180701);

// Tree: 215 
woFDN_FLA_S__lgt_215 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 67.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 171.5) => -0.0277399974,
   (c_exp_prod > 171.5) => 0.1052146013,
   (c_exp_prod = NULL) => 0.0480607130, -0.0201422695),
(r_C13_max_lres_d > 67.5) => 
   map(
   (NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 43.5) => 0.1225914669,
   (f_mos_liens_unrel_FT_fseen_d > 43.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 18.45) => 0.0019195021,
      (C_INC_50K_P > 18.45) => 
         map(
         (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 0.0243142387,
         (f_hh_members_w_derog_i > 3.5) => 0.1370818518,
         (f_hh_members_w_derog_i = NULL) => 0.0301390121, 0.0301390121),
      (C_INC_50K_P = NULL) => 0.0372926478, 0.0068105736),
   (f_mos_liens_unrel_FT_fseen_d = NULL) => 0.0073875740, 0.0073875740),
(r_C13_max_lres_d = NULL) => -0.0092096480, 0.0017190718);

// Tree: 216 
woFDN_FLA_S__lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184) => -0.0828244222,
(f_mos_liens_unrel_FT_lseen_d > 184) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 5.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
         map(
         (NULL < c_rich_blk and c_rich_blk <= 122) => -0.0031147590,
         (c_rich_blk > 122) => 0.0280696743,
         (c_rich_blk = NULL) => 0.0049963436, 0.0049963436),
      (c_asian_lang > 181.5) => -0.0263829169,
      (c_asian_lang = NULL) => 0.0156253430, 0.0007634885),
   (f_srchcomponentrisktype_i > 5.5) => 0.0713752096,
   (f_srchcomponentrisktype_i = NULL) => 0.0012012232, 0.0012012232),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 8.05) => 0.0491406676,
   (c_pop_18_24_p > 8.05) => -0.0425100866,
   (c_pop_18_24_p = NULL) => 0.0077761679, 0.0077761679), 0.0003095638);

// Tree: 217 
woFDN_FLA_S__lgt_217 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -45425.5) => -0.0922382485,
(f_addrchangeincomediff_d > -45425.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0014829987,
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 11.55) => -0.0467786118,
      (c_pop_25_34_p > 11.55) => 0.1080786858,
      (c_pop_25_34_p = NULL) => 0.0564595866, 0.0564595866),
   (f_assoccredbureaucountnew_i = NULL) => -0.0003018362, -0.0003018362),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 33.35) => -0.0054905792,
   (c_retail > 33.35) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 111) => -0.0015037872,
      (c_for_sale > 111) => 0.1616180685,
      (c_for_sale = NULL) => 0.0782243108, 0.0782243108),
   (c_retail = NULL) => 0.0208532752, 0.0022045951), -0.0002878815);

// Tree: 218 
woFDN_FLA_S__lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
      map(
      (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 
         map(
         (NULL < c_assault and c_assault <= 179) => -0.0166875661,
         (c_assault > 179) => 0.1522109870,
         (c_assault = NULL) => 0.0230204881, 0.0056773308),
      (f_prevaddroccupantowned_i > 0.5) => 0.1400169291,
      (f_prevaddroccupantowned_i = NULL) => 0.0194328482, 0.0194328482),
   (k_inq_per_ssn_i > 2.5) => 0.1724312123,
   (k_inq_per_ssn_i = NULL) => 0.0343102401, 0.0343102401),
(f_rel_incomeover25_count_d > 1.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.0246153671,
   (f_corrssnaddrcount_d > 2.5) => -0.0047838052,
   (f_corrssnaddrcount_d = NULL) => -0.0022892372, -0.0022892372),
(f_rel_incomeover25_count_d = NULL) => -0.0232705159, -0.0004250301);

// Tree: 219 
woFDN_FLA_S__lgt_219 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 15.45) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 6.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 64.5) => -0.0194425810,
      (r_C13_max_lres_d > 64.5) => 0.0104558066,
      (r_C13_max_lres_d = NULL) => 0.0044340001, 0.0044340001),
   (f_assocsuspicousidcount_i > 6.5) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 168.5) => -0.0356156141,
      (c_old_homes > 168.5) => 0.0863493700,
      (c_old_homes = NULL) => -0.0267531066, -0.0267531066),
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 0.1) => 0.0466839913,
      (c_hval_100k_p > 0.1) => -0.0638336136,
      (c_hval_100k_p = NULL) => -0.0121235416, -0.0121235416), 0.0020948554),
(c_femdiv_p > 15.45) => 0.1000878837,
(c_femdiv_p = NULL) => -0.0037294985, 0.0025052137);

// Tree: 220 
woFDN_FLA_S__lgt_220 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 42.75) => -0.0019264039,
   (c_famotf18_p > 42.75) => 
      map(
      (NULL < c_business and c_business <= 20.5) => -0.0606731089,
      (c_business > 20.5) => 0.0682144922,
      (c_business = NULL) => -0.0369998761, -0.0369998761),
   (c_famotf18_p = NULL) => -0.0162598955, -0.0030729057),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 119.5) => -0.0295673802,
   (c_easiqlife > 119.5) => 0.1475300690,
   (c_easiqlife = NULL) => 0.0604571565, 0.0604571565),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 9.95) => -0.0370762931,
   (c_retail > 9.95) => 0.0675867286,
   (c_retail = NULL) => 0.0148365657, 0.0148365657), -0.0022733449);

// Tree: 221 
woFDN_FLA_S__lgt_221 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 11.25) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 49.75) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 165.5) => 
            map(
            (NULL < c_asian_lang and c_asian_lang <= 123.5) => 0.0772265035,
            (c_asian_lang > 123.5) => 0.2560954488,
            (c_asian_lang = NULL) => 0.1395596208, 0.1395596208),
         (c_asian_lang > 165.5) => -0.0178330849,
         (c_asian_lang = NULL) => 0.0920919794, 0.0920919794),
      (c_newhouse > 49.75) => -0.0836943656,
      (c_newhouse = NULL) => 0.0613869410, 0.0613869410),
   (f_corrssnnamecount_d > 1.5) => 0.0046542279,
   (f_corrssnnamecount_d = NULL) => -0.0168358762, 0.0072933810),
(C_INC_25K_P > 11.25) => -0.0181926741,
(C_INC_25K_P = NULL) => -0.0121689480, 0.0004171542);

// Tree: 222 
woFDN_FLA_S__lgt_222 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0047662080,
(f_addrchangecrimediff_i > 61.5) => 
   map(
   (NULL < c_health and c_health <= 11.15) => -0.0045515892,
   (c_health > 11.15) => 0.1422541660,
   (c_health = NULL) => 0.0546858208, 0.0546858208),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 984.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 21.5) => -0.0790972141,
      (f_prevaddrageoldest_d > 21.5) => -0.0183568556,
      (f_prevaddrageoldest_d = NULL) => -0.0420893522, -0.0420893522),
   (c_popover18 > 984.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => -0.0278257201,
      (r_L79_adls_per_addr_c6_i > 0.5) => 0.0420880602,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0165286191, 0.0165286191),
   (c_popover18 = NULL) => 0.0164682375, -0.0008618078), -0.0030773879);

// Tree: 223 
woFDN_FLA_S__lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 44948.5) => 
   map(
   (NULL < c_retail and c_retail <= 22.3) => -0.0663516285,
   (c_retail > 22.3) => 0.0669324548,
   (c_retail = NULL) => -0.0446633901, -0.0446633901),
(r_A46_Curr_AVM_AutoVal_d > 44948.5) => 
   map(
   (NULL < r_nas_ssn_verd_d and r_nas_ssn_verd_d <= 0.5) => 
      map(
      (NULL < c_rental and c_rental <= 92.5) => -0.0099199626,
      (c_rental > 92.5) => 0.1834831407,
      (c_rental = NULL) => 0.0955726392, 0.0955726392),
   (r_nas_ssn_verd_d > 0.5) => -0.0014681833,
   (r_nas_ssn_verd_d = NULL) => 0.0001172643, 0.0001172643),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 75.5) => 0.0272861469,
   (f_mos_inq_banko_cm_fseen_d > 75.5) => -0.0055572234,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0029521295, 0.0014915380), -0.0004852571);

// Tree: 224 
woFDN_FLA_S__lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.55) => 0.0118421946,
   (c_hval_20k_p > 0.55) => 0.1764716486,
   (c_hval_20k_p = NULL) => 0.0445067688, 0.0445067688),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
      map(
      (NULL < c_food and c_food <= 47.75) => -0.0029068924,
      (c_food > 47.75) => 
         map(
         (NULL < c_incollege and c_incollege <= 3.95) => -0.0179777788,
         (c_incollege > 3.95) => 0.0653951132,
         (c_incollege = NULL) => 0.0374243555, 0.0374243555),
      (c_food = NULL) => 0.0057322635, 0.0008582825),
   (f_srchssnsrchcount_i > 22.5) => 0.0741870978,
   (f_srchssnsrchcount_i = NULL) => 0.0012213259, 0.0012213259),
(r_C10_M_Hdr_FS_d = NULL) => 0.0247629695, 0.0022984294);

// Tree: 225 
woFDN_FLA_S__lgt_225 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 124634.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0102686801,
   (f_corrrisktype_i > 5.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 3.65) => -0.0065622855,
      (c_incollege > 3.65) => 
         map(
         (NULL < f_rel_count_i and f_rel_count_i <= 18.5) => 
            map(
            (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 1489.5) => -0.0192234466,
            (r_A50_pb_total_dollars_d > 1489.5) => 0.0864240246,
            (r_A50_pb_total_dollars_d = NULL) => 0.0404278467, 0.0404278467),
         (f_rel_count_i > 18.5) => 0.1637608592,
         (f_rel_count_i = NULL) => 0.0619071915, 0.0619071915),
      (c_incollege = NULL) => 0.0416734675, 0.0416734675),
   (f_corrrisktype_i = NULL) => 0.0105355890, 0.0105355890),
(r_L80_Inp_AVM_AutoVal_d > 124634.5) => 0.0075055976,
(r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0082484579, 0.0009924703);

// Tree: 226 
woFDN_FLA_S__lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 13.5) => -0.0192273713,
   (f_addrs_per_ssn_i > 13.5) => -0.1429232042,
   (f_addrs_per_ssn_i = NULL) => -0.0798625835, -0.0798625835),
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.6) => 0.1141816175,
      (r_C12_source_profile_d > 60.6) => -0.0376240961,
      (r_C12_source_profile_d = NULL) => 0.0512377850, 0.0512377850),
   (r_D33_Eviction_Recency_d > 30) => -0.0019365387,
   (r_D33_Eviction_Recency_d = NULL) => -0.0014119184, -0.0014119184),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.260400711) => -0.0241505351,
   (f_add_input_mobility_index_i > 0.260400711) => 0.0353809741,
   (f_add_input_mobility_index_i = NULL) => 0.0066782822, 0.0066782822), -0.0019687575);

// Tree: 227 
woFDN_FLA_S__lgt_227 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -100) => -0.0775016184,
(f_addrchangecrimediff_i > -100) => 0.0000644116,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 112.65) => 
      map(
      (NULL < c_finance and c_finance <= 2.75) => 
         map(
         (NULL < c_totsales and c_totsales <= 9851) => 0.0109487187,
         (c_totsales > 9851) => 0.1765763361,
         (c_totsales = NULL) => 0.0659726587, 0.0659726587),
      (c_finance > 2.75) => -0.0409647399,
      (c_finance = NULL) => 0.0148449708, 0.0148449708),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 112.65) => 
      map(
      (NULL < c_construction and c_construction <= 2.5) => 0.1682257396,
      (c_construction > 2.5) => 0.0250811040,
      (c_construction = NULL) => 0.0676966825, 0.0676966825),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0055663167, 0.0053754591), 0.0008039981);

// Tree: 228 
woFDN_FLA_S__lgt_228 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 13.5) => -0.0437458205,
   (c_no_teens > 13.5) => 0.0004508460,
   (c_no_teens = NULL) => -0.0025936920, -0.0019503264),
(f_assocsuspicousidcount_i > 9.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 278.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.11232741045) => 0.0728627448,
      (f_add_input_nhood_MFD_pct_i > 0.11232741045) => -0.0505841650,
      (f_add_input_nhood_MFD_pct_i = NULL) => -0.0080162651, -0.0080162651),
   (f_M_Bureau_ADL_FS_noTU_d > 278.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0190177164,
      (f_inq_Collection_count_i > 1.5) => -0.1397166661,
      (f_inq_Collection_count_i = NULL) => -0.0931018993, -0.0931018993),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0432660278, -0.0432660278),
(f_assocsuspicousidcount_i = NULL) => -0.0042744312, -0.0031097155);

// Tree: 229 
woFDN_FLA_S__lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 19.45) => -0.0020612221,
   (C_INC_35K_P > 19.45) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 154.5) => 
         map(
         (NULL < c_health and c_health <= 17.75) => 
            map(
            (NULL < c_medi_indx and c_medi_indx <= 94) => 0.0434238558,
            (c_medi_indx > 94) => 0.2078061764,
            (c_medi_indx = NULL) => 0.1079183548, 0.1079183548),
         (c_health > 17.75) => -0.0628422583,
         (c_health = NULL) => 0.0708242890, 0.0708242890),
      (f_curraddrburglaryindex_i > 154.5) => -0.0449739428,
      (f_curraddrburglaryindex_i = NULL) => 0.0357522397, 0.0357522397),
   (C_INC_35K_P = NULL) => 0.0090551070, -0.0006029362),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0617854535,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0180609040, -0.0032789518);

// Tree: 230 
woFDN_FLA_S__lgt_230 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 189) => 0.0007839934,
   (f_fp_prevaddrcrimeindex_i > 189) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1954.5) => 0.1587550780,
      (c_med_yearblt > 1954.5) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 166182.5) => 
            map(
            (NULL < r_wealth_index_d and r_wealth_index_d <= 2.5) => -0.0311737396,
            (r_wealth_index_d > 2.5) => 0.1714084747,
            (r_wealth_index_d = NULL) => 0.0637866734, 0.0637866734),
         (f_prevaddrmedianvalue_d > 166182.5) => -0.1089768030,
         (f_prevaddrmedianvalue_d = NULL) => 0.0125271804, 0.0125271804),
      (c_med_yearblt = NULL) => 0.0605503645, 0.0605503645),
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0020781753, 0.0020781753),
(f_fp_prevaddrcrimeindex_i > 197.5) => -0.1015233774,
(f_fp_prevaddrcrimeindex_i = NULL) => -0.0052107558, 0.0014186363);

// Tree: 231 
woFDN_FLA_S__lgt_231 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 12.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 25.05) => -0.0017282352,
   (c_pop_35_44_p > 25.05) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1953.5) => 0.1804095191,
      (c_med_yearblt > 1953.5) => 0.0228208108,
      (c_med_yearblt = NULL) => 0.0617063363, 0.0617063363),
   (c_pop_35_44_p = NULL) => -0.0168141196, -0.0004769309),
(f_srchssnsrchcount_i > 12.5) => 
   map(
   (NULL < c_employees and c_employees <= 471.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 90) => 0.1490198877,
      (f_fp_prevaddrburglaryindex_i > 90) => 0.0212273858,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0868822492, 0.0868822492),
   (c_employees > 471.5) => -0.0268257585,
   (c_employees = NULL) => 0.0482904405, 0.0482904405),
(f_srchssnsrchcount_i = NULL) => 0.0109293568, 0.0002786454);

// Tree: 232 
woFDN_FLA_S__lgt_232 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 221.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 7.65) => -0.0078664895,
   (c_hval_150k_p > 7.65) => 0.1285213986,
   (c_hval_150k_p = NULL) => 0.0549905372, 0.0549905372),
(r_D32_Mos_Since_Fel_LS_d > 221.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 24.5) => -0.0022007025,
   (f_rel_homeover200_count_d > 24.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0407333665) => -0.0258888346,
      (f_add_curr_nhood_BUS_pct_i > 0.0407333665) => 0.1228799424,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0518015267, 0.0518015267),
   (f_rel_homeover200_count_d = NULL) => -0.0231586037, -0.0016978770),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 13.35) => -0.0564367170,
   (c_hh4_p > 13.35) => 0.0565584812,
   (c_hh4_p = NULL) => -0.0059924321, -0.0059924321), -0.0012194302);

// Tree: 233 
woFDN_FLA_S__lgt_233 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0559983764,
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 15.75) => 0.0083443148,
      (c_hval_250k_p > 15.75) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.0077473364,
         (f_corrssnnamecount_d > 3.5) => 
            map(
            (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0700422379,
            (r_S66_adlperssn_count_i > 1.5) => 0.2160168372,
            (r_S66_adlperssn_count_i = NULL) => 0.1417711358, 0.1417711358),
         (f_corrssnnamecount_d = NULL) => 0.0814286669, 0.0814286669),
      (c_hval_250k_p = NULL) => 0.0133672697, 0.0262104234),
   (f_corrssnaddrcount_d > 2.5) => -0.0082586558,
   (f_corrssnaddrcount_d = NULL) => -0.0057819032, -0.0057819032),
(f_corrssnaddrcount_d = NULL) => 0.0010202392, -0.0069269861);

// Tree: 234 
woFDN_FLA_S__lgt_234 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 155.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0374215581,
   (f_util_add_curr_conv_n > 0.5) => 0.0033990246,
   (f_util_add_curr_conv_n = NULL) => -0.0140202022, -0.0140202022),
(r_C13_max_lres_d > 155.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 24.05) => 0.1715740220,
   (c_med_age > 24.05) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
         map(
         (NULL < c_unattach and c_unattach <= 140.5) => 0.0237394746,
         (c_unattach > 140.5) => 0.1543574903,
         (c_unattach = NULL) => 0.0395865132, 0.0395865132),
      (f_corraddrnamecount_d > 3.5) => 0.0002490506,
      (f_corraddrnamecount_d = NULL) => 0.0043020013, 0.0043020013),
   (c_med_age = NULL) => -0.0357539611, 0.0054574460),
(r_C13_max_lres_d = NULL) => 0.0286760184, -0.0053038125);

// Tree: 235 
woFDN_FLA_S__lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0630942593) => 0.0072650906,
   (f_add_curr_nhood_VAC_pct_i > 0.0630942593) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 30.5) => 0.1970716696,
      (f_mos_inq_banko_cm_fseen_d > 30.5) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 0.0179621906,
         (r_F04_curr_add_occ_index_d > 2) => 0.1396572423,
         (r_F04_curr_add_occ_index_d = NULL) => 0.0561718197, 0.0561718197),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0710746885, 0.0710746885),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0212419191, 0.0212419191),
(f_hh_members_ct_d > 1.5) => -0.0074359965,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0607910084,
   (c_pop_35_44_p > 15.55) => 0.0536363930,
   (c_pop_35_44_p = NULL) => -0.0059812447, -0.0059812447), -0.0020548135);

// Tree: 236 
woFDN_FLA_S__lgt_236 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.25) => -0.0418655024,
(c_pop_45_54_p > 7.25) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => -0.0004385891,
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.1314912985,
      (f_corrssnnamecount_d > 3.5) => 
         map(
         (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
            map(
            (NULL < c_retired2 and c_retired2 <= 52) => 0.0821779285,
            (c_retired2 > 52) => -0.0285656546,
            (c_retired2 = NULL) => -0.0074186387, -0.0074186387),
         (r_F01_inp_addr_not_verified_i > 0.5) => 0.1056782954,
         (r_F01_inp_addr_not_verified_i = NULL) => 0.0082484690, 0.0082484690),
      (f_corrssnnamecount_d = NULL) => 0.0285289346, 0.0285289346),
   (f_rel_felony_count_i = NULL) => 0.0038187941, 0.0009835934),
(c_pop_45_54_p = NULL) => 0.0167794159, -0.0012774385);

// Tree: 237 
woFDN_FLA_S__lgt_237 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 1.5) => 0.0010388959,
(r_D34_unrel_liens_ct_i > 1.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 59.5) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 121) => 0.0349477073,
         (c_lar_fam > 121) => -0.1072007676,
         (c_lar_fam = NULL) => -0.0263712426, -0.0263712426),
      (f_historical_count_d > 1.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 95.5) => 0.1844184038,
         (c_relig_indx > 95.5) => 0.0029014245,
         (c_relig_indx = NULL) => 0.0890450757, 0.0890450757),
      (f_historical_count_d = NULL) => 0.0235725460, 0.0235725460),
   (f_curraddrburglaryindex_i > 59.5) => -0.0563713042,
   (f_curraddrburglaryindex_i = NULL) => -0.0301680160, -0.0301680160),
(r_D34_unrel_liens_ct_i = NULL) => -0.0065801571, -0.0010960389);

// Tree: 238 
woFDN_FLA_S__lgt_238 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 37.5) => 0.0518814682,
   (r_A50_pb_average_dollars_d > 37.5) => -0.0661358510,
   (r_A50_pb_average_dollars_d = NULL) => -0.0427660848, -0.0427660848),
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => -0.0048574990,
   (f_addrs_per_ssn_c6_i > 1.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.45) => 0.1652094580,
      (c_pop_55_64_p > 8.45) => 0.0095580374,
      (c_pop_55_64_p = NULL) => 0.0666609255, 0.0666609255),
   (f_addrs_per_ssn_c6_i = NULL) => -0.0038432186, -0.0038432186),
(f_corrssnaddrcount_d = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 85.5) => 0.0585112103,
   (c_many_cars > 85.5) => -0.0361986404,
   (c_many_cars = NULL) => 0.0085732890, 0.0085732890), -0.0046623407);

// Tree: 239 
woFDN_FLA_S__lgt_239 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 30.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 23.5) => -0.0027146134,
   (f_rel_homeover300_count_d > 23.5) => 0.1265938220,
   (f_rel_homeover300_count_d = NULL) => -0.0021668748, -0.0021668748),
(f_rel_homeover200_count_d > 30.5) => -0.0840446632,
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 33.45) => -0.0950425721,
   (c_sfdu_p > 33.45) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 17.25) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 11.3) => -0.0233829229,
         (c_hval_750k_p > 11.3) => 0.1106354766,
         (c_hval_750k_p = NULL) => 0.0204139397, 0.0204139397),
      (c_famotf18_p > 17.25) => 0.1128059181,
      (c_famotf18_p = NULL) => 0.0454917624, 0.0454917624),
   (c_sfdu_p = NULL) => 0.0014025594, 0.0014025594), -0.0026984503);

// Tree: 240 
woFDN_FLA_S__lgt_240 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
   map(
   (NULL < c_rnt1500_p and c_rnt1500_p <= 11.85) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 152.5) => 0.0159813379,
      (c_easiqlife > 152.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 99955) => 
            map(
            (NULL < c_lowinc and c_lowinc <= 18.55) => 0.1956245444,
            (c_lowinc > 18.55) => 0.0563312794,
            (c_lowinc = NULL) => 0.1020282793, 0.1020282793),
         (f_curraddrmedianincome_d > 99955) => -0.0166795456,
         (f_curraddrmedianincome_d = NULL) => 0.0678016913, 0.0678016913),
      (c_easiqlife = NULL) => 0.0226283290, 0.0226283290),
   (c_rnt1500_p > 11.85) => -0.0162019449,
   (c_rnt1500_p = NULL) => -0.0258771167, 0.0120272372),
(f_dl_addrs_per_adl_i > 0.5) => -0.0120420897,
(f_dl_addrs_per_adl_i = NULL) => -0.0013519427, 0.0023697102);

// Tree: 241 
woFDN_FLA_S__lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0022518654,
(k_comb_age_d > 67.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 142) => 
      map(
      (NULL < c_young and c_young <= 27.85) => 0.0429547141,
      (c_young > 27.85) => -0.0889091272,
      (c_young = NULL) => 0.0254356609, 0.0254356609),
   (f_curraddrcrimeindex_i > 142) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 94.5) => 0.2348102088,
      (c_retired2 > 94.5) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.14949217805) => 0.0285467840,
         (f_add_input_nhood_MFD_pct_i > 0.14949217805) => 0.0309348341,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0297408091, 0.0297408091),
      (c_retired2 = NULL) => 0.0968075310, 0.0968075310),
   (f_curraddrcrimeindex_i = NULL) => 0.0384271276, 0.0384271276),
(k_comb_age_d = NULL) => -0.0002082767, 0.0005874228);

// Tree: 242 
woFDN_FLA_S__lgt_242 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0029533042,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 26.25) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 4.5) => 0.0980992999,
      (r_I60_inq_hiRiskCred_recency_d > 4.5) => 0.0003186997,
      (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0055778157, 0.0055778157),
   (c_rnt1000_p > 26.25) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 22.05) => 0.0485472615,
      (c_pop_25_34_p > 22.05) => 
         map(
         (NULL < c_young and c_young <= 35.7) => 0.2392890830,
         (c_young > 35.7) => 0.0670762934,
         (c_young = NULL) => 0.1508127875, 0.1508127875),
      (c_pop_25_34_p = NULL) => 0.0703186333, 0.0703186333),
   (c_rnt1000_p = NULL) => 0.0274283751, 0.0274283751),
(k_inq_per_ssn_i = NULL) => 0.0007159691, 0.0007159691);

// Tree: 243 
woFDN_FLA_S__lgt_243 := map(
(NULL < c_info and c_info <= 27.85) => 
   map(
   (NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 19.5) => 
            map(
            (NULL < f_idrisktype_i and f_idrisktype_i <= 3.5) => -0.0307861034,
            (f_idrisktype_i > 3.5) => 0.1644439213,
            (f_idrisktype_i = NULL) => 0.0704064225, 0.0704064225),
         (r_C13_max_lres_d > 19.5) => 0.0057846542,
         (r_C13_max_lres_d = NULL) => 0.0068589651, 0.0068589651),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0484820449,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0130586407, 0.0045315278),
   (r_L77_Add_PO_Box_i > 0.5) => -0.0997869870,
   (r_L77_Add_PO_Box_i = NULL) => 0.0026862311, 0.0026862311),
(c_info > 27.85) => 0.1359865554,
(c_info = NULL) => 0.0205678511, 0.0037501496);

// Tree: 244 
woFDN_FLA_S__lgt_244 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 56.05) => -0.0431029799,
   (c_fammar_p > 56.05) => -0.0074555780,
   (c_fammar_p = NULL) => 0.0078453420, -0.0097606057),
(f_curraddrcrimeindex_i > 121) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 23.55) => 0.0090464044,
   (c_hh4_p > 23.55) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 215.95) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 100.5) => -0.1072069926,
         (r_A50_pb_average_dollars_d > 100.5) => 0.1115732155,
         (r_A50_pb_average_dollars_d = NULL) => -0.0000801321, -0.0000801321),
      (c_housingcpi > 215.95) => 0.1660698326,
      (c_housingcpi = NULL) => 0.0560618651, 0.0560618651),
   (c_hh4_p = NULL) => 0.0121845897, 0.0121845897),
(f_curraddrcrimeindex_i = NULL) => -0.0001557718, -0.0039791948);

// Final Score Sum 

   woFDN_FLA_S__lgt := sum(
      woFDN_FLA_S__lgt_0, woFDN_FLA_S__lgt_1, woFDN_FLA_S__lgt_2, woFDN_FLA_S__lgt_3, woFDN_FLA_S__lgt_4, 
      woFDN_FLA_S__lgt_5, woFDN_FLA_S__lgt_6, woFDN_FLA_S__lgt_7, woFDN_FLA_S__lgt_8, woFDN_FLA_S__lgt_9, 
      woFDN_FLA_S__lgt_10, woFDN_FLA_S__lgt_11, woFDN_FLA_S__lgt_12, woFDN_FLA_S__lgt_13, woFDN_FLA_S__lgt_14, 
      woFDN_FLA_S__lgt_15, woFDN_FLA_S__lgt_16, woFDN_FLA_S__lgt_17, woFDN_FLA_S__lgt_18, woFDN_FLA_S__lgt_19, 
      woFDN_FLA_S__lgt_20, woFDN_FLA_S__lgt_21, woFDN_FLA_S__lgt_22, woFDN_FLA_S__lgt_23, woFDN_FLA_S__lgt_24, 
      woFDN_FLA_S__lgt_25, woFDN_FLA_S__lgt_26, woFDN_FLA_S__lgt_27, woFDN_FLA_S__lgt_28, woFDN_FLA_S__lgt_29, 
      woFDN_FLA_S__lgt_30, woFDN_FLA_S__lgt_31, woFDN_FLA_S__lgt_32, woFDN_FLA_S__lgt_33, woFDN_FLA_S__lgt_34, 
      woFDN_FLA_S__lgt_35, woFDN_FLA_S__lgt_36, woFDN_FLA_S__lgt_37, woFDN_FLA_S__lgt_38, woFDN_FLA_S__lgt_39, 
      woFDN_FLA_S__lgt_40, woFDN_FLA_S__lgt_41, woFDN_FLA_S__lgt_42, woFDN_FLA_S__lgt_43, woFDN_FLA_S__lgt_44, 
      woFDN_FLA_S__lgt_45, woFDN_FLA_S__lgt_46, woFDN_FLA_S__lgt_47, woFDN_FLA_S__lgt_48, woFDN_FLA_S__lgt_49, 
      woFDN_FLA_S__lgt_50, woFDN_FLA_S__lgt_51, woFDN_FLA_S__lgt_52, woFDN_FLA_S__lgt_53, woFDN_FLA_S__lgt_54, 
      woFDN_FLA_S__lgt_55, woFDN_FLA_S__lgt_56, woFDN_FLA_S__lgt_57, woFDN_FLA_S__lgt_58, woFDN_FLA_S__lgt_59, 
      woFDN_FLA_S__lgt_60, woFDN_FLA_S__lgt_61, woFDN_FLA_S__lgt_62, woFDN_FLA_S__lgt_63, woFDN_FLA_S__lgt_64, 
      woFDN_FLA_S__lgt_65, woFDN_FLA_S__lgt_66, woFDN_FLA_S__lgt_67, woFDN_FLA_S__lgt_68, woFDN_FLA_S__lgt_69, 
      woFDN_FLA_S__lgt_70, woFDN_FLA_S__lgt_71, woFDN_FLA_S__lgt_72, woFDN_FLA_S__lgt_73, woFDN_FLA_S__lgt_74, 
      woFDN_FLA_S__lgt_75, woFDN_FLA_S__lgt_76, woFDN_FLA_S__lgt_77, woFDN_FLA_S__lgt_78, woFDN_FLA_S__lgt_79, 
      woFDN_FLA_S__lgt_80, woFDN_FLA_S__lgt_81, woFDN_FLA_S__lgt_82, woFDN_FLA_S__lgt_83, woFDN_FLA_S__lgt_84, 
      woFDN_FLA_S__lgt_85, woFDN_FLA_S__lgt_86, woFDN_FLA_S__lgt_87, woFDN_FLA_S__lgt_88, woFDN_FLA_S__lgt_89, 
      woFDN_FLA_S__lgt_90, woFDN_FLA_S__lgt_91, woFDN_FLA_S__lgt_92, woFDN_FLA_S__lgt_93, woFDN_FLA_S__lgt_94, 
      woFDN_FLA_S__lgt_95, woFDN_FLA_S__lgt_96, woFDN_FLA_S__lgt_97, woFDN_FLA_S__lgt_98, woFDN_FLA_S__lgt_99, 
      woFDN_FLA_S__lgt_100, woFDN_FLA_S__lgt_101, woFDN_FLA_S__lgt_102, woFDN_FLA_S__lgt_103, woFDN_FLA_S__lgt_104, 
      woFDN_FLA_S__lgt_105, woFDN_FLA_S__lgt_106, woFDN_FLA_S__lgt_107, woFDN_FLA_S__lgt_108, woFDN_FLA_S__lgt_109, 
      woFDN_FLA_S__lgt_110, woFDN_FLA_S__lgt_111, woFDN_FLA_S__lgt_112, woFDN_FLA_S__lgt_113, woFDN_FLA_S__lgt_114, 
      woFDN_FLA_S__lgt_115, woFDN_FLA_S__lgt_116, woFDN_FLA_S__lgt_117, woFDN_FLA_S__lgt_118, woFDN_FLA_S__lgt_119, 
      woFDN_FLA_S__lgt_120, woFDN_FLA_S__lgt_121, woFDN_FLA_S__lgt_122, woFDN_FLA_S__lgt_123, woFDN_FLA_S__lgt_124, 
      woFDN_FLA_S__lgt_125, woFDN_FLA_S__lgt_126, woFDN_FLA_S__lgt_127, woFDN_FLA_S__lgt_128, woFDN_FLA_S__lgt_129, 
      woFDN_FLA_S__lgt_130, woFDN_FLA_S__lgt_131, woFDN_FLA_S__lgt_132, woFDN_FLA_S__lgt_133, woFDN_FLA_S__lgt_134, 
      woFDN_FLA_S__lgt_135, woFDN_FLA_S__lgt_136, woFDN_FLA_S__lgt_137, woFDN_FLA_S__lgt_138, woFDN_FLA_S__lgt_139, 
      woFDN_FLA_S__lgt_140, woFDN_FLA_S__lgt_141, woFDN_FLA_S__lgt_142, woFDN_FLA_S__lgt_143, woFDN_FLA_S__lgt_144, 
      woFDN_FLA_S__lgt_145, woFDN_FLA_S__lgt_146, woFDN_FLA_S__lgt_147, woFDN_FLA_S__lgt_148, woFDN_FLA_S__lgt_149, 
      woFDN_FLA_S__lgt_150, woFDN_FLA_S__lgt_151, woFDN_FLA_S__lgt_152, woFDN_FLA_S__lgt_153, woFDN_FLA_S__lgt_154, 
      woFDN_FLA_S__lgt_155, woFDN_FLA_S__lgt_156, woFDN_FLA_S__lgt_157, woFDN_FLA_S__lgt_158, woFDN_FLA_S__lgt_159, 
      woFDN_FLA_S__lgt_160, woFDN_FLA_S__lgt_161, woFDN_FLA_S__lgt_162, woFDN_FLA_S__lgt_163, woFDN_FLA_S__lgt_164, 
      woFDN_FLA_S__lgt_165, woFDN_FLA_S__lgt_166, woFDN_FLA_S__lgt_167, woFDN_FLA_S__lgt_168, woFDN_FLA_S__lgt_169, 
      woFDN_FLA_S__lgt_170, woFDN_FLA_S__lgt_171, woFDN_FLA_S__lgt_172, woFDN_FLA_S__lgt_173, woFDN_FLA_S__lgt_174, 
      woFDN_FLA_S__lgt_175, woFDN_FLA_S__lgt_176, woFDN_FLA_S__lgt_177, woFDN_FLA_S__lgt_178, woFDN_FLA_S__lgt_179, 
      woFDN_FLA_S__lgt_180, woFDN_FLA_S__lgt_181, woFDN_FLA_S__lgt_182, woFDN_FLA_S__lgt_183, woFDN_FLA_S__lgt_184, 
      woFDN_FLA_S__lgt_185, woFDN_FLA_S__lgt_186, woFDN_FLA_S__lgt_187, woFDN_FLA_S__lgt_188, woFDN_FLA_S__lgt_189, 
      woFDN_FLA_S__lgt_190, woFDN_FLA_S__lgt_191, woFDN_FLA_S__lgt_192, woFDN_FLA_S__lgt_193, woFDN_FLA_S__lgt_194, 
      woFDN_FLA_S__lgt_195, woFDN_FLA_S__lgt_196, woFDN_FLA_S__lgt_197, woFDN_FLA_S__lgt_198, woFDN_FLA_S__lgt_199, 
      woFDN_FLA_S__lgt_200, woFDN_FLA_S__lgt_201, woFDN_FLA_S__lgt_202, woFDN_FLA_S__lgt_203, woFDN_FLA_S__lgt_204, 
      woFDN_FLA_S__lgt_205, woFDN_FLA_S__lgt_206, woFDN_FLA_S__lgt_207, woFDN_FLA_S__lgt_208, woFDN_FLA_S__lgt_209, 
      woFDN_FLA_S__lgt_210, woFDN_FLA_S__lgt_211, woFDN_FLA_S__lgt_212, woFDN_FLA_S__lgt_213, woFDN_FLA_S__lgt_214, 
      woFDN_FLA_S__lgt_215, woFDN_FLA_S__lgt_216, woFDN_FLA_S__lgt_217, woFDN_FLA_S__lgt_218, woFDN_FLA_S__lgt_219, 
      woFDN_FLA_S__lgt_220, woFDN_FLA_S__lgt_221, woFDN_FLA_S__lgt_222, woFDN_FLA_S__lgt_223, woFDN_FLA_S__lgt_224, 
      woFDN_FLA_S__lgt_225, woFDN_FLA_S__lgt_226, woFDN_FLA_S__lgt_227, woFDN_FLA_S__lgt_228, woFDN_FLA_S__lgt_229, 
      woFDN_FLA_S__lgt_230, woFDN_FLA_S__lgt_231, woFDN_FLA_S__lgt_232, woFDN_FLA_S__lgt_233, woFDN_FLA_S__lgt_234, 
      woFDN_FLA_S__lgt_235, woFDN_FLA_S__lgt_236, woFDN_FLA_S__lgt_237, woFDN_FLA_S__lgt_238, woFDN_FLA_S__lgt_239, 
      woFDN_FLA_S__lgt_240, woFDN_FLA_S__lgt_241, woFDN_FLA_S__lgt_242, woFDN_FLA_S__lgt_243, woFDN_FLA_S__lgt_244); 


// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_woFDN_LGT := woFDN_FLA_S__lgt;
			
self.final_score_0	:= 	woFDN_FLA_S__lgt_0	;
self.final_score_1	:= 	woFDN_FLA_S__lgt_1	;
self.final_score_2	:= 	woFDN_FLA_S__lgt_2	;
self.final_score_3	:= 	woFDN_FLA_S__lgt_3	;
self.final_score_4	:= 	woFDN_FLA_S__lgt_4	;
self.final_score_5	:= 	woFDN_FLA_S__lgt_5	;
self.final_score_6	:= 	woFDN_FLA_S__lgt_6	;
self.final_score_7	:= 	woFDN_FLA_S__lgt_7	;
self.final_score_8	:= 	woFDN_FLA_S__lgt_8	;
self.final_score_9	:= 	woFDN_FLA_S__lgt_9	;
self.final_score_10	:= 	woFDN_FLA_S__lgt_10	;
self.final_score_11	:= 	woFDN_FLA_S__lgt_11	;
self.final_score_12	:= 	woFDN_FLA_S__lgt_12	;
self.final_score_13	:= 	woFDN_FLA_S__lgt_13	;
self.final_score_14	:= 	woFDN_FLA_S__lgt_14	;
self.final_score_15	:= 	woFDN_FLA_S__lgt_15	;
self.final_score_16	:= 	woFDN_FLA_S__lgt_16	;
self.final_score_17	:= 	woFDN_FLA_S__lgt_17	;
self.final_score_18	:= 	woFDN_FLA_S__lgt_18	;
self.final_score_19	:= 	woFDN_FLA_S__lgt_19	;
self.final_score_20	:= 	woFDN_FLA_S__lgt_20	;
self.final_score_21	:= 	woFDN_FLA_S__lgt_21	;
self.final_score_22	:= 	woFDN_FLA_S__lgt_22	;
self.final_score_23	:= 	woFDN_FLA_S__lgt_23	;
self.final_score_24	:= 	woFDN_FLA_S__lgt_24	;
self.final_score_25	:= 	woFDN_FLA_S__lgt_25	;
self.final_score_26	:= 	woFDN_FLA_S__lgt_26	;
self.final_score_27	:= 	woFDN_FLA_S__lgt_27	;
self.final_score_28	:= 	woFDN_FLA_S__lgt_28	;
self.final_score_29	:= 	woFDN_FLA_S__lgt_29	;
self.final_score_30	:= 	woFDN_FLA_S__lgt_30	;
self.final_score_31	:= 	woFDN_FLA_S__lgt_31	;
self.final_score_32	:= 	woFDN_FLA_S__lgt_32	;
self.final_score_33	:= 	woFDN_FLA_S__lgt_33	;
self.final_score_34	:= 	woFDN_FLA_S__lgt_34	;
self.final_score_35	:= 	woFDN_FLA_S__lgt_35	;
self.final_score_36	:= 	woFDN_FLA_S__lgt_36	;
self.final_score_37	:= 	woFDN_FLA_S__lgt_37	;
self.final_score_38	:= 	woFDN_FLA_S__lgt_38	;
self.final_score_39	:= 	woFDN_FLA_S__lgt_39	;
self.final_score_40	:= 	woFDN_FLA_S__lgt_40	;
self.final_score_41	:= 	woFDN_FLA_S__lgt_41	;
self.final_score_42	:= 	woFDN_FLA_S__lgt_42	;
self.final_score_43	:= 	woFDN_FLA_S__lgt_43	;
self.final_score_44	:= 	woFDN_FLA_S__lgt_44	;
self.final_score_45	:= 	woFDN_FLA_S__lgt_45	;
self.final_score_46	:= 	woFDN_FLA_S__lgt_46	;
self.final_score_47	:= 	woFDN_FLA_S__lgt_47	;
self.final_score_48	:= 	woFDN_FLA_S__lgt_48	;
self.final_score_49	:= 	woFDN_FLA_S__lgt_49	;
self.final_score_50	:= 	woFDN_FLA_S__lgt_50	;
self.final_score_51	:= 	woFDN_FLA_S__lgt_51	;
self.final_score_52	:= 	woFDN_FLA_S__lgt_52	;
self.final_score_53	:= 	woFDN_FLA_S__lgt_53	;
self.final_score_54	:= 	woFDN_FLA_S__lgt_54	;
self.final_score_55	:= 	woFDN_FLA_S__lgt_55	;
self.final_score_56	:= 	woFDN_FLA_S__lgt_56	;
self.final_score_57	:= 	woFDN_FLA_S__lgt_57	;
self.final_score_58	:= 	woFDN_FLA_S__lgt_58	;
self.final_score_59	:= 	woFDN_FLA_S__lgt_59	;
self.final_score_60	:= 	woFDN_FLA_S__lgt_60	;
self.final_score_61	:= 	woFDN_FLA_S__lgt_61	;
self.final_score_62	:= 	woFDN_FLA_S__lgt_62	;
self.final_score_63	:= 	woFDN_FLA_S__lgt_63	;
self.final_score_64	:= 	woFDN_FLA_S__lgt_64	;
self.final_score_65	:= 	woFDN_FLA_S__lgt_65	;
self.final_score_66	:= 	woFDN_FLA_S__lgt_66	;
self.final_score_67	:= 	woFDN_FLA_S__lgt_67	;
self.final_score_68	:= 	woFDN_FLA_S__lgt_68	;
self.final_score_69	:= 	woFDN_FLA_S__lgt_69	;
self.final_score_70	:= 	woFDN_FLA_S__lgt_70	;
self.final_score_71	:= 	woFDN_FLA_S__lgt_71	;
self.final_score_72	:= 	woFDN_FLA_S__lgt_72	;
self.final_score_73	:= 	woFDN_FLA_S__lgt_73	;
self.final_score_74	:= 	woFDN_FLA_S__lgt_74	;
self.final_score_75	:= 	woFDN_FLA_S__lgt_75	;
self.final_score_76	:= 	woFDN_FLA_S__lgt_76	;
self.final_score_77	:= 	woFDN_FLA_S__lgt_77	;
self.final_score_78	:= 	woFDN_FLA_S__lgt_78	;
self.final_score_79	:= 	woFDN_FLA_S__lgt_79	;
self.final_score_80	:= 	woFDN_FLA_S__lgt_80	;
self.final_score_81	:= 	woFDN_FLA_S__lgt_81	;
self.final_score_82	:= 	woFDN_FLA_S__lgt_82	;
self.final_score_83	:= 	woFDN_FLA_S__lgt_83	;
self.final_score_84	:= 	woFDN_FLA_S__lgt_84	;
self.final_score_85	:= 	woFDN_FLA_S__lgt_85	;
self.final_score_86	:= 	woFDN_FLA_S__lgt_86	;
self.final_score_87	:= 	woFDN_FLA_S__lgt_87	;
self.final_score_88	:= 	woFDN_FLA_S__lgt_88	;
self.final_score_89	:= 	woFDN_FLA_S__lgt_89	;
self.final_score_90	:= 	woFDN_FLA_S__lgt_90	;
self.final_score_91	:= 	woFDN_FLA_S__lgt_91	;
self.final_score_92	:= 	woFDN_FLA_S__lgt_92	;
self.final_score_93	:= 	woFDN_FLA_S__lgt_93	;
self.final_score_94	:= 	woFDN_FLA_S__lgt_94	;
self.final_score_95	:= 	woFDN_FLA_S__lgt_95	;
self.final_score_96	:= 	woFDN_FLA_S__lgt_96	;
self.final_score_97	:= 	woFDN_FLA_S__lgt_97	;
self.final_score_98	:= 	woFDN_FLA_S__lgt_98	;
self.final_score_99	:= 	woFDN_FLA_S__lgt_99	;
self.final_score_100	:= 	woFDN_FLA_S__lgt_100	;
self.final_score_101	:= 	woFDN_FLA_S__lgt_101	;
self.final_score_102	:= 	woFDN_FLA_S__lgt_102	;
self.final_score_103	:= 	woFDN_FLA_S__lgt_103	;
self.final_score_104	:= 	woFDN_FLA_S__lgt_104	;
self.final_score_105	:= 	woFDN_FLA_S__lgt_105	;
self.final_score_106	:= 	woFDN_FLA_S__lgt_106	;
self.final_score_107	:= 	woFDN_FLA_S__lgt_107	;
self.final_score_108	:= 	woFDN_FLA_S__lgt_108	;
self.final_score_109	:= 	woFDN_FLA_S__lgt_109	;
self.final_score_110	:= 	woFDN_FLA_S__lgt_110	;
self.final_score_111	:= 	woFDN_FLA_S__lgt_111	;
self.final_score_112	:= 	woFDN_FLA_S__lgt_112	;
self.final_score_113	:= 	woFDN_FLA_S__lgt_113	;
self.final_score_114	:= 	woFDN_FLA_S__lgt_114	;
self.final_score_115	:= 	woFDN_FLA_S__lgt_115	;
self.final_score_116	:= 	woFDN_FLA_S__lgt_116	;
self.final_score_117	:= 	woFDN_FLA_S__lgt_117	;
self.final_score_118	:= 	woFDN_FLA_S__lgt_118	;
self.final_score_119	:= 	woFDN_FLA_S__lgt_119	;
self.final_score_120	:= 	woFDN_FLA_S__lgt_120	;
self.final_score_121	:= 	woFDN_FLA_S__lgt_121	;
self.final_score_122	:= 	woFDN_FLA_S__lgt_122	;
self.final_score_123	:= 	woFDN_FLA_S__lgt_123	;
self.final_score_124	:= 	woFDN_FLA_S__lgt_124	;
self.final_score_125	:= 	woFDN_FLA_S__lgt_125	;
self.final_score_126	:= 	woFDN_FLA_S__lgt_126	;
self.final_score_127	:= 	woFDN_FLA_S__lgt_127	;
self.final_score_128	:= 	woFDN_FLA_S__lgt_128	;
self.final_score_129	:= 	woFDN_FLA_S__lgt_129	;
self.final_score_130	:= 	woFDN_FLA_S__lgt_130	;
self.final_score_131	:= 	woFDN_FLA_S__lgt_131	;
self.final_score_132	:= 	woFDN_FLA_S__lgt_132	;
self.final_score_133	:= 	woFDN_FLA_S__lgt_133	;
self.final_score_134	:= 	woFDN_FLA_S__lgt_134	;
self.final_score_135	:= 	woFDN_FLA_S__lgt_135	;
self.final_score_136	:= 	woFDN_FLA_S__lgt_136	;
self.final_score_137	:= 	woFDN_FLA_S__lgt_137	;
self.final_score_138	:= 	woFDN_FLA_S__lgt_138	;
self.final_score_139	:= 	woFDN_FLA_S__lgt_139	;
self.final_score_140	:= 	woFDN_FLA_S__lgt_140	;
self.final_score_141	:= 	woFDN_FLA_S__lgt_141	;
self.final_score_142	:= 	woFDN_FLA_S__lgt_142	;
self.final_score_143	:= 	woFDN_FLA_S__lgt_143	;
self.final_score_144	:= 	woFDN_FLA_S__lgt_144	;
self.final_score_145	:= 	woFDN_FLA_S__lgt_145	;
self.final_score_146	:= 	woFDN_FLA_S__lgt_146	;
self.final_score_147	:= 	woFDN_FLA_S__lgt_147	;
self.final_score_148	:= 	woFDN_FLA_S__lgt_148	;
self.final_score_149	:= 	woFDN_FLA_S__lgt_149	;
self.final_score_150	:= 	woFDN_FLA_S__lgt_150	;
self.final_score_151	:= 	woFDN_FLA_S__lgt_151	;
self.final_score_152	:= 	woFDN_FLA_S__lgt_152	;
self.final_score_153	:= 	woFDN_FLA_S__lgt_153	;
self.final_score_154	:= 	woFDN_FLA_S__lgt_154	;
self.final_score_155	:= 	woFDN_FLA_S__lgt_155	;
self.final_score_156	:= 	woFDN_FLA_S__lgt_156	;
self.final_score_157	:= 	woFDN_FLA_S__lgt_157	;
self.final_score_158	:= 	woFDN_FLA_S__lgt_158	;
self.final_score_159	:= 	woFDN_FLA_S__lgt_159	;
self.final_score_160	:= 	woFDN_FLA_S__lgt_160	;
self.final_score_161	:= 	woFDN_FLA_S__lgt_161	;
self.final_score_162	:= 	woFDN_FLA_S__lgt_162	;
self.final_score_163	:= 	woFDN_FLA_S__lgt_163	;
self.final_score_164	:= 	woFDN_FLA_S__lgt_164	;
self.final_score_165	:= 	woFDN_FLA_S__lgt_165	;
self.final_score_166	:= 	woFDN_FLA_S__lgt_166	;
self.final_score_167	:= 	woFDN_FLA_S__lgt_167	;
self.final_score_168	:= 	woFDN_FLA_S__lgt_168	;
self.final_score_169	:= 	woFDN_FLA_S__lgt_169	;
self.final_score_170	:= 	woFDN_FLA_S__lgt_170	;
self.final_score_171	:= 	woFDN_FLA_S__lgt_171	;
self.final_score_172	:= 	woFDN_FLA_S__lgt_172	;
self.final_score_173	:= 	woFDN_FLA_S__lgt_173	;
self.final_score_174	:= 	woFDN_FLA_S__lgt_174	;
self.final_score_175	:= 	woFDN_FLA_S__lgt_175	;
self.final_score_176	:= 	woFDN_FLA_S__lgt_176	;
self.final_score_177	:= 	woFDN_FLA_S__lgt_177	;
self.final_score_178	:= 	woFDN_FLA_S__lgt_178	;
self.final_score_179	:= 	woFDN_FLA_S__lgt_179	;
self.final_score_180	:= 	woFDN_FLA_S__lgt_180	;
self.final_score_181	:= 	woFDN_FLA_S__lgt_181	;
self.final_score_182	:= 	woFDN_FLA_S__lgt_182	;
self.final_score_183	:= 	woFDN_FLA_S__lgt_183	;
self.final_score_184	:= 	woFDN_FLA_S__lgt_184	;
self.final_score_185	:= 	woFDN_FLA_S__lgt_185	;
self.final_score_186	:= 	woFDN_FLA_S__lgt_186	;
self.final_score_187	:= 	woFDN_FLA_S__lgt_187	;
self.final_score_188	:= 	woFDN_FLA_S__lgt_188	;
self.final_score_189	:= 	woFDN_FLA_S__lgt_189	;
self.final_score_190	:= 	woFDN_FLA_S__lgt_190	;
self.final_score_191	:= 	woFDN_FLA_S__lgt_191	;
self.final_score_192	:= 	woFDN_FLA_S__lgt_192	;
self.final_score_193	:= 	woFDN_FLA_S__lgt_193	;
self.final_score_194	:= 	woFDN_FLA_S__lgt_194	;
self.final_score_195	:= 	woFDN_FLA_S__lgt_195	;
self.final_score_196	:= 	woFDN_FLA_S__lgt_196	;
self.final_score_197	:= 	woFDN_FLA_S__lgt_197	;
self.final_score_198	:= 	woFDN_FLA_S__lgt_198	;
self.final_score_199	:= 	woFDN_FLA_S__lgt_199	;
self.final_score_200	:= 	woFDN_FLA_S__lgt_200	;
self.final_score_201	:= 	woFDN_FLA_S__lgt_201	;
self.final_score_202	:= 	woFDN_FLA_S__lgt_202	;
self.final_score_203	:= 	woFDN_FLA_S__lgt_203	;
self.final_score_204	:= 	woFDN_FLA_S__lgt_204	;
self.final_score_205	:= 	woFDN_FLA_S__lgt_205	;
self.final_score_206	:= 	woFDN_FLA_S__lgt_206	;
self.final_score_207	:= 	woFDN_FLA_S__lgt_207	;
self.final_score_208	:= 	woFDN_FLA_S__lgt_208	;
self.final_score_209	:= 	woFDN_FLA_S__lgt_209	;
self.final_score_210	:= 	woFDN_FLA_S__lgt_210	;
self.final_score_211	:= 	woFDN_FLA_S__lgt_211	;
self.final_score_212	:= 	woFDN_FLA_S__lgt_212	;
self.final_score_213	:= 	woFDN_FLA_S__lgt_213	;
self.final_score_214	:= 	woFDN_FLA_S__lgt_214	;
self.final_score_215	:= 	woFDN_FLA_S__lgt_215	;
self.final_score_216	:= 	woFDN_FLA_S__lgt_216	;
self.final_score_217	:= 	woFDN_FLA_S__lgt_217	;
self.final_score_218	:= 	woFDN_FLA_S__lgt_218	;
self.final_score_219	:= 	woFDN_FLA_S__lgt_219	;
self.final_score_220	:= 	woFDN_FLA_S__lgt_220	;
self.final_score_221	:= 	woFDN_FLA_S__lgt_221	;
self.final_score_222	:= 	woFDN_FLA_S__lgt_222	;
self.final_score_223	:= 	woFDN_FLA_S__lgt_223	;
self.final_score_224	:= 	woFDN_FLA_S__lgt_224	;
self.final_score_225	:= 	woFDN_FLA_S__lgt_225	;
self.final_score_226	:= 	woFDN_FLA_S__lgt_226	;
self.final_score_227	:= 	woFDN_FLA_S__lgt_227	;
self.final_score_228	:= 	woFDN_FLA_S__lgt_228	;
self.final_score_229	:= 	woFDN_FLA_S__lgt_229	;
self.final_score_230	:= 	woFDN_FLA_S__lgt_230	;
self.final_score_231	:= 	woFDN_FLA_S__lgt_231	;
self.final_score_232	:= 	woFDN_FLA_S__lgt_232	;
self.final_score_233	:= 	woFDN_FLA_S__lgt_233	;
self.final_score_234	:= 	woFDN_FLA_S__lgt_234	;
self.final_score_235	:= 	woFDN_FLA_S__lgt_235	;
self.final_score_236	:= 	woFDN_FLA_S__lgt_236	;
self.final_score_237	:= 	woFDN_FLA_S__lgt_237	;
self.final_score_238	:= 	woFDN_FLA_S__lgt_238	;
self.final_score_239	:= 	woFDN_FLA_S__lgt_239	;
self.final_score_240	:= 	woFDN_FLA_S__lgt_240	;
self.final_score_241	:= 	woFDN_FLA_S__lgt_241	;
self.final_score_242	:= 	woFDN_FLA_S__lgt_242	;
self.final_score_243	:= 	woFDN_FLA_S__lgt_243	;
self.final_score_244	:= 	woFDN_FLA_S__lgt_244	;
// self.woFDN_submodel_lgt	:= 	woFDN_FLA_S__lgt	;
self.FP3_woFDN_LGT		:= 	woFDN_FLA_S__lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
