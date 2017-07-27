
export FP3FDN1505_FLAPSD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FLAPSD_lgt_0 :=  -2.2011724703;

// Tree: 1 
wFDN_FLAPSD_lgt_1 := map(
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
wFDN_FLAPSD_lgt_2 := map(
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
wFDN_FLAPSD_lgt_3 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.3763765427,
   (f_phone_ver_experian_d > 0.5) => 0.0814198143,
   (f_phone_ver_experian_d = NULL) => 0.3190782941, 0.2608343885),
(nf_vf_hi_risk_index > 4.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0352625012,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1887769583,
      (r_I60_inq_comm_recency_d > 549) => 
         map(
         (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.2977941581,
         (r_F00_input_dob_match_level_d > 4.5) => 0.0222068474,
         (r_F00_input_dob_match_level_d = NULL) => 0.0303196984, 0.0303196984),
      (r_I60_inq_comm_recency_d = NULL) => 0.0534816645, 0.0534816645),
   (nf_seg_FraudPoint_3_0 = '') => -0.0164485635, -0.0164485635),
(nf_vf_hi_risk_index = NULL) => 0.1602896218, -0.0066988403);

// Tree: 4 
wFDN_FLAPSD_lgt_4 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0628663833,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.2309253417,
   (nf_seg_FraudPoint_3_0 = '') => 0.1220355281, 0.1220355281),
(nf_vf_hi_risk_index > 6.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0619745593,
         (f_phone_ver_experian_d > 0.5) => -0.0511668740,
         (f_phone_ver_experian_d = NULL) => 0.0118790736, 0.0208190203),
      (k_nap_phn_verd_d > 0.5) => -0.0483716685,
      (k_nap_phn_verd_d = NULL) => -0.0228262432, -0.0228262432),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.1468230842,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0180584077, -0.0180584077),
(nf_vf_hi_risk_index = NULL) => 0.1820196375, -0.0043879094);

// Tree: 5 
wFDN_FLAPSD_lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 85) => 0.0662732586,
   (r_F01_inp_addr_address_score_d > 85) => -0.0314763402,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0234217383, -0.0234217383),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.3101543770,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 34.05) => 
         map(
         (NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 2.5) => 0.1128143134,
         (nf_vf_hi_summary > 2.5) => 0.2849363674,
         (nf_vf_hi_summary = NULL) => 0.1397904466, 0.1397904466),
      (c_high_ed > 34.05) => 0.0044815436,
      (c_high_ed = NULL) => 0.0819698034, 0.0819698034),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.1003612847, 0.1003612847),
(f_varrisktype_i = NULL) => 0.1127299523, -0.0085493192);

// Tree: 6 
wFDN_FLAPSD_lgt_6 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 49.25) => 0.2170000348,
      (c_fammar_p > 49.25) => 0.0464816924,
      (c_fammar_p = NULL) => 0.1152287676, 0.0729256848),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0266206896,
      (k_inq_per_phone_i > 2.5) => 0.1075529912,
      (k_inq_per_phone_i = NULL) => -0.0205474878, -0.0205474878),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0109765945, -0.0109765945),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.95) => 0.1464060871,
   (c_unemp > 7.95) => 0.3374307270,
   (c_unemp = NULL) => 0.1778754642, 0.1778754642),
(f_inq_PrepaidCards_count_i = NULL) => 0.0873996532, -0.0048823720);

// Tree: 7 
wFDN_FLAPSD_lgt_7 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 61.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0408312381,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1561468258,
   (nf_seg_FraudPoint_3_0 = '') => 0.0966974056, 0.0966974056),
(r_I60_inq_comm_recency_d > 61.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.0559997061,
      (r_F01_inp_addr_address_score_d > 95) => -0.0289199513,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0210793791, -0.0210793791),
   (k_inq_ssns_per_addr_i > 2.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 128.5) => 0.2181016296,
      (c_lux_prod > 128.5) => -0.0017555689,
      (c_lux_prod = NULL) => 0.1239464497, 0.1239464497),
   (k_inq_ssns_per_addr_i = NULL) => -0.0155174479, -0.0155174479),
(r_I60_inq_comm_recency_d = NULL) => 0.0977347503, -0.0082454246);

// Tree: 8 
wFDN_FLAPSD_lgt_8 := map(
(NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 16.5) => 0.0126392720,
         (f_phones_per_addr_curr_i > 16.5) => 0.2285285491,
         (f_phones_per_addr_curr_i = NULL) => 0.0198771098, 0.0198771098),
      (k_inq_per_addr_i > 3.5) => 0.1565906344,
      (k_inq_per_addr_i = NULL) => 0.0330494086, 0.0330494086),
   (f_phone_ver_experian_d > 0.5) => -0.0470617687,
   (f_phone_ver_experian_d = NULL) => -0.0082860368, -0.0123825933),
(nf_vf_hi_summary > 2.5) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.2090223730,
   (f_prevaddrstatus_i > 2.5) => 0.1580353765,
   (f_prevaddrstatus_i = NULL) => 0.0319743700, 0.1264560645),
(nf_vf_hi_summary = NULL) => 0.0472783688, -0.0063504393);

// Tree: 9 
wFDN_FLAPSD_lgt_9 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 0.1463797019,
   (r_F00_input_dob_match_level_d > 5.5) => 
      map(
      (NULL < nf_max_altlexid_hi_no_hi_lexid and nf_max_altlexid_hi_no_hi_lexid <= 3.5) => -0.0239608081,
      (nf_max_altlexid_hi_no_hi_lexid > 3.5) => 0.2122910399,
      (nf_max_altlexid_hi_no_hi_lexid = NULL) => -0.0227258159, -0.0227258159),
   (r_F00_input_dob_match_level_d = NULL) => -0.0187135532, -0.0187135532),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 71) => 0.1392861592,
      (c_rich_wht > 71) => 0.0149683433,
      (c_rich_wht = NULL) => 0.0450765643, 0.0450765643),
   (f_srchfraudsrchcount_i > 6.5) => 0.1449718177,
   (f_srchfraudsrchcount_i = NULL) => 0.0610172962, 0.0610172962),
(f_varrisktype_i = NULL) => 0.0613350122, -0.0091821661);

// Tree: 10 
wFDN_FLAPSD_lgt_10 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 61.95) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 45) => 0.1287204374,
      (r_F01_inp_addr_address_score_d > 45) => 0.0282244943,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0375055049, 0.0375055049),
   (c_fammar_p > 61.95) => -0.0282908292,
   (c_fammar_p = NULL) => -0.0389324205, -0.0170386778),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0760624895,
   (f_assocrisktype_i > 5.5) => 0.1935182052,
   (f_assocrisktype_i = NULL) => 0.0989806779, 0.0989806779),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0729056002,
   (r_S66_adlperssn_count_i > 1.5) => 0.1471640990,
   (r_S66_adlperssn_count_i = NULL) => 0.0454512128, 0.0454512128), -0.0104525529);

// Tree: 11 
wFDN_FLAPSD_lgt_11 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.2243438574,
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 3.5) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0121415944,
         (f_rel_felony_count_i > 1.5) => 0.1378646678,
         (f_rel_felony_count_i = NULL) => 0.0200271507, 0.0200271507),
      (k_inq_per_phone_i > 3.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0675770582,
         (r_Phn_Cell_n > 0.5) => 0.4219269725,
         (r_Phn_Cell_n = NULL) => 0.2211286877, 0.2211286877),
      (k_inq_per_phone_i = NULL) => 0.0252370350, 0.0252370350),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0471976550, 0.0293234242),
(k_nap_phn_verd_d > 0.5) => -0.0308204834,
(k_nap_phn_verd_d = NULL) => -0.0080667891, -0.0080667891);

// Tree: 12 
wFDN_FLAPSD_lgt_12 := map(
(nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0213163234,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 11.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => 0.0054885297,
      (f_corrrisktype_i > 5.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 51.85) => 0.1573862938,
         (c_fammar_p > 51.85) => 
            map(
            (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.2095693585,
            (r_F00_input_dob_match_level_d > 4.5) => 0.0456070943,
            (r_F00_input_dob_match_level_d = NULL) => 0.0552628562, 0.0552628562),
         (c_fammar_p = NULL) => 0.0426350056, 0.0700129970),
      (f_corrrisktype_i = NULL) => 0.0333936860, 0.0333936860),
   (f_srchfraudsrchcount_i > 11.5) => 0.1284517864,
   (f_srchfraudsrchcount_i = NULL) => 0.0392618936, 0.0392618936),
(nf_seg_FraudPoint_3_0 = '') => -0.0080593166, -0.0080593166);

// Tree: 13 
wFDN_FLAPSD_lgt_13 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0178705995,
      (k_nap_phn_verd_d > 0.5) => -0.0372387515,
      (k_nap_phn_verd_d = NULL) => -0.0171093055, -0.0171093055),
   (f_inq_Communications_count_i > 1.5) => 0.0936265316,
   (f_inq_Communications_count_i = NULL) => -0.0140717110, -0.0140717110),
(f_assocrisktype_i > 7.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0795593453,
   (f_varrisktype_i > 3.5) => 0.1714999519,
   (f_varrisktype_i = NULL) => 0.0916567936, 0.0916567936),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 98.5) => -0.0514441907,
   (c_larceny > 98.5) => 0.1688271141,
   (c_larceny = NULL) => 0.0607310109, 0.0607310109), -0.0067599844);

// Tree: 14 
wFDN_FLAPSD_lgt_14 := map(
(NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 7.5) => 
         map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 0.1209408424,
         (f_corrssnaddrcount_d > 1.5) => 0.0036930220,
         (f_corrssnaddrcount_d = NULL) => 0.0111302652, 0.0111302652),
      (f_srchaddrsrchcount_i > 7.5) => 0.1234399146,
      (f_srchaddrsrchcount_i = NULL) => 0.0207098633, 0.0207098633),
   (f_phone_ver_experian_d > 0.5) => -0.0350187868,
   (f_phone_ver_experian_d = NULL) => -0.0059138583, -0.0105093078),
(nf_vf_hi_summary > 2.5) => 
   map(
   (NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 5.5) => 0.1410453117,
   (nf_vf_lexid_hi_summary > 5.5) => -0.0014972102,
   (nf_vf_lexid_hi_summary = NULL) => 0.0940431439, 0.0940431439),
(nf_vf_hi_summary = NULL) => 0.0320392529, -0.0062857669);

// Tree: 15 
wFDN_FLAPSD_lgt_15 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 4.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 61.35) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 0.0314350529,
      (f_inq_PrepaidCards_count_i > 0.5) => 0.1547337609,
      (f_inq_PrepaidCards_count_i = NULL) => 0.0380127739, 0.0380127739),
   (c_fammar_p > 61.35) => -0.0221537907,
   (c_fammar_p = NULL) => -0.0482786384, -0.0132095510),
(k_inq_per_addr_i > 4.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1241692852,
   (f_phone_ver_experian_d > 0.5) => 0.0076957529,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < c_rental and c_rental <= 124.5) => 0.0049728253,
      (c_rental > 124.5) => 0.1950118018,
      (c_rental = NULL) => 0.0944029319, 0.0944029319), 0.0657463193),
(k_inq_per_addr_i = NULL) => -0.0071906053, -0.0071906053);

// Tree: 16 
wFDN_FLAPSD_lgt_16 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => -0.0141514640,
(f_assocrisktype_i > 4.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 14.65) => 0.2409864797,
   (r_C12_source_profile_d > 14.65) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 0.2281647216,
      (r_D32_Mos_Since_Crim_LS_d > 14.5) => 
         map(
         (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 3.5) => 0.0238705039,
         (f_srchphonesrchcount_i > 3.5) => 0.1334637408,
         (f_srchphonesrchcount_i = NULL) => 0.0353433752, 0.0353433752),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0418450584, 0.0418450584),
   (r_C12_source_profile_d = NULL) => 0.0470757899, 0.0470757899),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0548471142,
   (k_comb_age_d > 27.5) => 0.1402807320,
   (k_comb_age_d = NULL) => 0.0529866955, 0.0529866955), -0.0032574746);

// Tree: 17 
wFDN_FLAPSD_lgt_17 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 16.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 11.25) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
            map(
            (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -61620.5) => 0.2024052368,
            (f_addrchangevaluediff_d > -61620.5) => 0.0351858917,
            (f_addrchangevaluediff_d = NULL) => 0.0746937741, 0.0503181704),
         (f_phone_ver_experian_d > 0.5) => -0.0275121518,
         (f_phone_ver_experian_d = NULL) => 0.0217521138, 0.0174945675),
      (c_unemp > 11.25) => 0.1602889030,
      (c_unemp = NULL) => -0.0583910606, 0.0168124986),
   (f_corrphonelastnamecount_d > 0.5) => -0.0313912857,
   (f_corrphonelastnamecount_d = NULL) => -0.0103531934, -0.0103531934),
(f_inq_HighRiskCredit_count_i > 16.5) => 0.1604375671,
(f_inq_HighRiskCredit_count_i = NULL) => 0.0263402709, -0.0091117699);

// Tree: 18 
wFDN_FLAPSD_lgt_18 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 5.75) => 0.0178042843,
      (c_unemp > 5.75) => 0.1484842596,
      (c_unemp = NULL) => 0.0185782092, 0.0484936492),
   (f_corrssnaddrcount_d > 1.5) => -0.0185165887,
   (f_corrssnaddrcount_d = NULL) => -0.0149282985, -0.0149282985),
(f_divrisktype_i > 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.65) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 8.5) => 0.0250745321,
      (f_assocsuspicousidcount_i > 8.5) => 0.1504482218,
      (f_assocsuspicousidcount_i = NULL) => 0.0350017321, 0.0350017321),
   (c_unemp > 7.65) => 0.1312671805,
   (c_unemp = NULL) => 0.0483577849, 0.0483577849),
(f_divrisktype_i = NULL) => 0.0273778680, -0.0059520169);

// Tree: 19 
wFDN_FLAPSD_lgt_19 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 168.5) => -0.0134507521,
      (c_unempl > 168.5) => 0.0616270782,
      (c_unempl = NULL) => -0.0460036168, -0.0097658433),
   (f_srchcomponentrisktype_i > 1.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.1490239111,
      (f_corrphonelastnamecount_d > 0.5) => 0.0099705942,
      (f_corrphonelastnamecount_d = NULL) => 0.0740354982, 0.0740354982),
   (f_srchcomponentrisktype_i = NULL) => -0.0065850526, -0.0065850526),
(r_D30_Derog_Count_i > 11.5) => 0.1348816137,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0558232033,
   (r_S66_adlperssn_count_i > 1.5) => 0.1162133658,
   (r_S66_adlperssn_count_i = NULL) => 0.0369269470, 0.0369269470), -0.0043950634);

// Tree: 20 
wFDN_FLAPSD_lgt_20 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 8.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 
      map(
      (NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 1.5) => -0.0183733540,
      (nf_vf_hi_summary > 1.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1311194529,
         (f_phone_ver_experian_d > 0.5) => 0.0124866177,
         (f_phone_ver_experian_d = NULL) => 0.0077278981, 0.0481239488),
      (nf_vf_hi_summary = NULL) => -0.0154525940, -0.0154525940),
   (f_hh_tot_derog_i > 4.5) => 0.0850525122,
   (f_hh_tot_derog_i = NULL) => 0.0233741485, -0.0104840424),
(k_inq_per_addr_i > 8.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1356434849,
   (f_phone_ver_experian_d > 0.5) => 0.0234766535,
   (f_phone_ver_experian_d = NULL) => 0.1269383883, 0.0864707754),
(k_inq_per_addr_i = NULL) => -0.0076331046, -0.0076331046);

// Tree: 21 
wFDN_FLAPSD_lgt_21 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 14.35) => 0.1465141522,
      (c_hh2_p > 14.35) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.1663986503,
         (r_F00_dob_score_d > 55) => 0.0111813217,
         (r_F00_dob_score_d = NULL) => 0.0303429554, 0.0140325289),
      (c_hh2_p = NULL) => -0.0050263475, 0.0179275580),
   (f_varrisktype_i > 3.5) => 0.0909068822,
   (f_varrisktype_i = NULL) => 0.0457009743, 0.0237104699),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => -0.0234108626,
   (r_D30_Derog_Count_i > 11.5) => 0.1394173960,
   (r_D30_Derog_Count_i = NULL) => -0.0215083734, -0.0215083734),
(k_nap_phn_verd_d = NULL) => -0.0044938256, -0.0044938256);

// Tree: 22 
wFDN_FLAPSD_lgt_22 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.2238391729,
   (f_attr_arrest_recency_d > 79.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 66.5) => 0.0873542334,
         (c_born_usa > 66.5) => 0.0129308184,
         (c_born_usa = NULL) => 0.0092704947, 0.0435078364),
      (f_phone_ver_experian_d > 0.5) => -0.0217132913,
      (f_phone_ver_experian_d = NULL) => 0.0111336072, 0.0144705429),
   (f_attr_arrest_recency_d = NULL) => 0.0165918823, 0.0165918823),
(f_corrphonelastnamecount_d > 0.5) => -0.0291716014,
(f_corrphonelastnamecount_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0728734485,
   (r_S66_adlperssn_count_i > 1.5) => 0.0893996305,
   (r_S66_adlperssn_count_i = NULL) => 0.0052013348, 0.0052013348), -0.0089446952);

// Tree: 23 
wFDN_FLAPSD_lgt_23 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0203781870,
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.0689372399,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0182785925, -0.0182785925),
(f_divrisktype_i > 1.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0270582602,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 84.5) => -0.0165699442,
      (c_unattach > 84.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1112547446,
         (f_phone_ver_experian_d > 0.5) => 0.0907279650,
         (f_phone_ver_experian_d = NULL) => 0.2651880566, 0.1412982775),
      (c_unattach = NULL) => 0.1012047609, 0.1012047609),
   (f_rel_felony_count_i = NULL) => 0.0403482740, 0.0403482740),
(f_divrisktype_i = NULL) => 0.0203185396, -0.0097744514);

// Tree: 24 
wFDN_FLAPSD_lgt_24 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 34.65) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 77.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 2.5) => 0.1930622809,
         (f_M_Bureau_ADL_FS_all_d > 2.5) => -0.0125439813,
         (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0295434794, -0.0113750157),
      (k_comb_age_d > 77.5) => 0.1780901685,
      (k_comb_age_d = NULL) => -0.0073788923, -0.0073788923),
   (c_famotf18_p > 34.65) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0373874507,
      (f_rel_felony_count_i > 0.5) => 0.1215144274,
      (f_rel_felony_count_i = NULL) => 0.0583861780, 0.0583861780),
   (c_famotf18_p = NULL) => -0.0166716352, -0.0042049798),
(k_inq_per_ssn_i > 10.5) => 0.1349658476,
(k_inq_per_ssn_i = NULL) => -0.0026360852, -0.0026360852);

// Tree: 25 
wFDN_FLAPSD_lgt_25 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 6.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 104.5) => 0.1869988962,
   (r_D32_Mos_Since_Fel_LS_d > 104.5) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.0437570368,
      (f_corrssnaddrcount_d > 2.5) => -0.0201776358,
      (f_corrssnaddrcount_d = NULL) => -0.0140177542, -0.0140177542),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0076792190, -0.0128096817),
(f_phones_per_addr_curr_i > 6.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0254524935,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 39629) => 0.1742981732,
      (f_curraddrmedianincome_d > 39629) => 0.0665070496,
      (f_curraddrmedianincome_d = NULL) => 0.0916212702, 0.0916212702),
   (f_rel_felony_count_i = NULL) => 0.0392199138, 0.0392199138),
(f_phones_per_addr_curr_i = NULL) => -0.0031748753, -0.0031748753);

// Tree: 26 
wFDN_FLAPSD_lgt_26 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.15) => -0.0227437524,
   (c_unemp > 9.15) => 0.0737605659,
   (c_unemp = NULL) => -0.0424537468, -0.0193540670),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0161954787,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 0.0825771568,
      (nf_seg_FraudPoint_3_0 = '') => 0.0204362454, 0.0204362454),
   (r_D33_eviction_count_i > 3.5) => 0.1337102897,
   (r_D33_eviction_count_i = NULL) => 0.0230585937, 0.0230585937),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 77.5) => -0.0634865369,
   (c_bel_edu > 77.5) => 0.0917826059,
   (c_bel_edu = NULL) => 0.0266697396, 0.0266697396), -0.0056061019);

// Tree: 27 
wFDN_FLAPSD_lgt_27 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1743899831,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 6.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => 0.0093315149,
         (k_inq_per_phone_i > 1.5) => 0.1042958104,
         (k_inq_per_phone_i = NULL) => 0.0165363439, 0.0165363439),
      (f_phone_ver_experian_d > 0.5) => -0.0309807451,
      (f_phone_ver_experian_d = NULL) => -0.0076128068, -0.0105767037),
   (f_varrisktype_i > 6.5) => 0.1377011661,
   (f_varrisktype_i = NULL) => -0.0095911925, -0.0095911925),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0575612268,
   (r_S66_adlperssn_count_i > 1.5) => 0.0920098408,
   (r_S66_adlperssn_count_i = NULL) => 0.0186624903, 0.0186624903), -0.0080106933);

// Tree: 28 
wFDN_FLAPSD_lgt_28 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 117.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 52291.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 119.75) => 0.0088692248,
         (c_oldhouse > 119.75) => 0.1918484645,
         (c_oldhouse = NULL) => 0.1126054867, 0.1126054867),
      (r_A46_Curr_AVM_AutoVal_d > 52291.5) => 0.0016283833,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0044709186, 0.0025386968),
   (r_C13_Curr_Addr_LRes_d > 117.5) => 
      map(
      (NULL < c_apt20 and c_apt20 <= 184.5) => 0.0611631388,
      (c_apt20 > 184.5) => 0.2399916369,
      (c_apt20 = NULL) => -0.0085460902, 0.0675828729),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0168314326, 0.0176571897),
(k_nap_phn_verd_d > 0.5) => -0.0208125292,
(k_nap_phn_verd_d = NULL) => -0.0064466594, -0.0064466594);

// Tree: 29 
wFDN_FLAPSD_lgt_29 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => -0.0140681804,
   (k_inq_ssns_per_addr_i > 2.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.1391894326,
      (f_prevaddrstatus_i > 2.5) => -0.0249376743,
      (f_prevaddrstatus_i = NULL) => 0.0445578377, 0.0573273064),
   (k_inq_ssns_per_addr_i = NULL) => -0.0112191310, -0.0112191310),
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 14.55) => 0.1410772500,
   (c_hh2_p > 14.55) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1408723667,
      (r_F00_dob_score_d > 92) => 0.0213421908,
      (r_F00_dob_score_d = NULL) => 0.0210467648, 0.0268334852),
   (c_hh2_p = NULL) => -0.0199418023, 0.0285993409),
(f_corrrisktype_i = NULL) => 0.0032637987, -0.0033998013);

// Tree: 30 
wFDN_FLAPSD_lgt_30 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 8.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0213976994,
      (k_inq_per_ssn_i > 1.5) => 0.0295090905,
      (k_inq_per_ssn_i = NULL) => -0.0132707132, -0.0132707132),
   (r_D32_criminal_count_i > 8.5) => 0.1570019207,
   (r_D32_criminal_count_i = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 29.5) => -0.0688455294,
      (k_comb_age_d > 29.5) => 0.1068281804,
      (k_comb_age_d = NULL) => 0.0124848918, 0.0124848918), -0.0119104357),
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < c_retail and c_retail <= 2.25) => 0.1031720887,
   (c_retail > 2.25) => 0.0211763357,
   (c_retail = NULL) => 0.0466802524, 0.0466802524),
(k_inq_per_phone_i = NULL) => -0.0061275787, -0.0061275787);

// Tree: 31 
wFDN_FLAPSD_lgt_31 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 25.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 19.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0133660021,
      (f_corrrisktype_i > 7.5) => 
         map(
         (NULL < c_unempl and c_unempl <= 94.5) => -0.0050671743,
         (c_unempl > 94.5) => 0.0598074039,
         (c_unempl = NULL) => 0.0018579235, 0.0259297414),
      (f_corrrisktype_i = NULL) => -0.0086777006, -0.0086777006),
   (k_inq_per_addr_i > 19.5) => 0.1281904604,
   (k_inq_per_addr_i = NULL) => -0.0079330186, -0.0079330186),
(f_srchssnsrchcount_i > 25.5) => 0.1133639748,
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 76.5) => -0.0802729623,
   (c_bel_edu > 76.5) => 0.0791452626,
   (c_bel_edu = NULL) => 0.0125032178, 0.0125032178), -0.0071387779);

// Tree: 32 
wFDN_FLAPSD_lgt_32 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 0.5) => -0.0158676687,
   (f_hh_age_65_plus_d > 0.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1192103191,
      (r_F01_inp_addr_address_score_d > 25) => 0.0247151782,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0283550968, 0.0283550968),
   (f_hh_age_65_plus_d = NULL) => -0.0062249469, -0.0062249469),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 2.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => 0.0332028571,
      (f_phones_per_addr_curr_i > 4.5) => 0.1370443235,
      (f_phones_per_addr_curr_i = NULL) => 0.0853044988, 0.0853044988),
   (f_historical_count_d > 2.5) => -0.0218042636,
   (f_historical_count_d = NULL) => 0.0531718701, 0.0531718701),
(f_inq_Communications_count_i = NULL) => 0.0078410874, -0.0041853862);

// Tree: 33 
wFDN_FLAPSD_lgt_33 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => -0.0162545884,
(f_rel_criminal_count_i > 1.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 15.5) => 0.1801453798,
   (f_M_Bureau_ADL_FS_all_d > 15.5) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 8331.5) => 0.0043015670,
         (f_addrchangeincomediff_d > 8331.5) => 
            map(
            (NULL < c_construction and c_construction <= 5) => 0.2336440926,
            (c_construction > 5) => 0.0111619789,
            (c_construction = NULL) => 0.1051871579, 0.1051871579),
         (f_addrchangeincomediff_d = NULL) => 0.0193875350, 0.0116854565),
      (f_hh_payday_loan_users_i > 0.5) => 0.0692579336,
      (f_hh_payday_loan_users_i = NULL) => 0.0185195140, 0.0185195140),
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0205945964, 0.0205945964),
(f_rel_criminal_count_i = NULL) => 0.0028021336, -0.0018543163);

// Tree: 34 
wFDN_FLAPSD_lgt_34 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 2.5) => 0.1428778564,
   (f_M_Bureau_ADL_FS_all_d > 2.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => -0.0154777583,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0863990329,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0190773630, -0.0190773630),
   (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0179936756, -0.0179936756),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 67908.5) => 0.0140806382,
   (f_addrchangevaluediff_d > 67908.5) => 0.1434451296,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => -0.0034583678,
      (r_L79_adls_per_addr_curr_i > 2.5) => 0.1012658159,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0412806033, 0.0412806033), 0.0223648827),
(f_hh_lienholders_i = NULL) => 0.0004659823, -0.0054031001);

// Tree: 35 
wFDN_FLAPSD_lgt_35 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => -0.0078982002,
      (f_inq_PrepaidCards_count_i > 2.5) => 0.1259806477,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0073182035, -0.0073182035),
   (f_assocsuspicousidcount_i > 14.5) => 0.1068110924,
   (f_assocsuspicousidcount_i = NULL) => -0.0031545496, -0.0064211861),
(k_comb_age_d > 73.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
      map(
      (NULL < c_med_inc and c_med_inc <= 48.5) => 0.2242886843,
      (c_med_inc > 48.5) => 0.0366525364,
      (c_med_inc = NULL) => 0.0617010513, 0.0617010513),
   (f_util_adl_count_n > 3.5) => 0.3517608925,
   (f_util_adl_count_n = NULL) => 0.0984098694, 0.0984098694),
(k_comb_age_d = NULL) => -0.0024295897, -0.0024295897);

// Tree: 36 
wFDN_FLAPSD_lgt_36 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 0.1273400872,
      (r_I60_inq_comm_recency_d > 4.5) => -0.0133632210,
      (r_I60_inq_comm_recency_d = NULL) => -0.0124793573, -0.0124793573),
   (f_assocsuspicousidcount_i > 13.5) => 0.1544289331,
   (f_assocsuspicousidcount_i = NULL) => 0.0157028608, -0.0111225605),
(k_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 80178) => 0.1283627190,
   (r_L80_Inp_AVM_AutoVal_d > 80178) => 0.0225398096,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 37.5) => 0.1356326111,
      (f_mos_inq_banko_om_lseen_d > 37.5) => 0.0169270891,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0369953272, 0.0369953272), 0.0383856096),
(k_inq_ssns_per_addr_i = NULL) => -0.0045266750, -0.0045266750);

// Tree: 37 
wFDN_FLAPSD_lgt_37 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0061914340,
   (r_D33_eviction_count_i > 3.5) => 0.1139684054,
   (r_D33_eviction_count_i = NULL) => -0.0054763135, -0.0054763135),
(f_divaddrsuspidcountnew_i > 2.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.55) => 0.0124882364,
   (c_pop_6_11_p > 7.55) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 125) => 0.1850029911,
      (c_lux_prod > 125) => 0.0122237522,
      (c_lux_prod = NULL) => 0.1319202128, 0.1319202128),
   (c_pop_6_11_p = NULL) => 0.0768574185, 0.0768574185),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0888567379,
   (k_comb_age_d > 26.5) => 0.0658313517,
   (k_comb_age_d = NULL) => -0.0072158017, -0.0072158017), -0.0034725354);

// Tree: 38 
wFDN_FLAPSD_lgt_38 := map(
(NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 5.5) => 
   map(
   (NULL < c_child and c_child <= 23.5) => 0.0105983285,
   (c_child > 23.5) => 0.2269532843,
   (c_child = NULL) => 0.1187758064, 0.1187758064),
(f_M_Bureau_ADL_FS_all_d > 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','6: Other']) => -0.0304684598,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1093014630,
      (r_F00_input_dob_match_level_d > 4.5) => 0.0128008902,
      (r_F00_input_dob_match_level_d = NULL) => 0.0145377527, 0.0145377527),
   (nf_seg_FraudPoint_3_0 = '') => -0.0020530287, -0.0020530287),
(f_M_Bureau_ADL_FS_all_d = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 95) => -0.0665785750,
   (c_larceny > 95) => 0.0768461257,
   (c_larceny = NULL) => -0.0007874279, -0.0007874279), -0.0004513234);

// Tree: 39 
wFDN_FLAPSD_lgt_39 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 18) => 0.1277491832,
   (r_D33_Eviction_Recency_d > 18) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 88.5) => -0.0036961774,
         (f_prevaddrageoldest_d > 88.5) => 
            map(
            (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.2403547670,
            (f_corrphonelastnamecount_d > 0.5) => 0.0165167564,
            (f_corrphonelastnamecount_d = NULL) => 0.1324810270, 0.1324810270),
         (f_prevaddrageoldest_d = NULL) => 0.0539707000, 0.0539707000),
      (r_F00_dob_score_d > 92) => -0.0103270633,
      (r_F00_dob_score_d = NULL) => -0.0276671669, -0.0088156335),
   (r_D33_Eviction_Recency_d = NULL) => -0.0148123493, -0.0081933603),
(k_nap_contradictory_i > 0.5) => 0.0869460971,
(k_nap_contradictory_i = NULL) => -0.0065208259, -0.0065208259);

// Tree: 40 
wFDN_FLAPSD_lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 19.5) => -0.0077236306,
   (k_inq_per_addr_i > 19.5) => 0.1346033098,
   (k_inq_per_addr_i = NULL) => -0.0069201346, -0.0069201346),
(f_addrchangecrimediff_i > 2.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 2.5) => 0.0306929941,
   (f_crim_rel_under100miles_cnt_i > 2.5) => 0.1363835288,
   (f_crim_rel_under100miles_cnt_i = NULL) => 0.0489818844, 0.0489818844),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 0.0033260654,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 0.2202105276,
      (r_Prop_Owner_History_d > 0.5) => 0.0372331031,
      (r_Prop_Owner_History_d = NULL) => 0.1023190326, 0.1023190326),
   (k_inq_per_phone_i = NULL) => 0.0084826558, 0.0084826558), -0.0009266884);

// Tree: 41 
wFDN_FLAPSD_lgt_41 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 83.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 5.75) => -0.0641716296,
      (c_pop_12_17_p > 5.75) => 0.1099843938,
      (c_pop_12_17_p = NULL) => 0.0686592357, 0.0686592357),
   (r_F00_input_dob_match_level_d > 4.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 14.75) => 0.0645004166,
      (c_hh2_p > 14.75) => -0.0079122982,
      (c_hh2_p = NULL) => -0.0306210528, -0.0056965681),
   (r_F00_input_dob_match_level_d = NULL) => 
      map(
      (NULL < c_larceny and c_larceny <= 86.5) => -0.0837583801,
      (c_larceny > 86.5) => 0.0580400490,
      (c_larceny = NULL) => -0.0219488085, -0.0219488085), -0.0043123011),
(k_comb_age_d > 83.5) => 0.1519724156,
(k_comb_age_d = NULL) => -0.0027352855, -0.0027352855);

// Tree: 42 
wFDN_FLAPSD_lgt_42 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 
      map(
      (NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => -0.0106398014,
      (f_attr_arrests_i > 0.5) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.45) => 0.2014509566,
         (c_pop_45_54_p > 12.45) => 0.0112215976,
         (c_pop_45_54_p = NULL) => 0.0836223238, 0.0836223238),
      (f_attr_arrests_i = NULL) => 0.0109846875, -0.0094180906),
   (k_comb_age_d > 73.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 146.5) => 0.0319966420,
      (c_span_lang > 146.5) => 0.1857458528,
      (c_span_lang = NULL) => 0.0713432142, 0.0713432142),
   (k_comb_age_d = NULL) => -0.0063947351, -0.0063947351),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1343358817,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0058400223, -0.0058400223);

// Tree: 43 
wFDN_FLAPSD_lgt_43 := map(
(NULL < c_unemp and c_unemp <= 10.85) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 81.5) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1955.5) => 0.1558196624,
         (c_med_yearblt > 1955.5) => 0.0227757547,
         (c_med_yearblt = NULL) => 0.0484818785, 0.0484818785),
      (r_I60_inq_recency_d > 2) => -0.0112679928,
      (r_I60_inq_recency_d = NULL) => -0.0046075531, -0.0078585122),
   (f_phones_per_addr_curr_i > 81.5) => 0.1686058459,
   (f_phones_per_addr_curr_i = NULL) => -0.0070441731, -0.0070441731),
(c_unemp > 10.85) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0294210508,
   (f_idverrisktype_i > 1.5) => 0.1018477415,
   (f_idverrisktype_i = NULL) => 0.0584132146, 0.0584132146),
(c_unemp = NULL) => -0.0399361581, -0.0063459361);

// Tree: 44 
wFDN_FLAPSD_lgt_44 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -89081.5) => 0.1070267193,
   (f_addrchangevaluediff_d > -89081.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.75) => 0.0038401627,
      (r_C12_source_profile_d > 78.75) => 
         map(
         (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 0.5) => 0.0303735654,
         (k_inq_per_addr_i > 0.5) => 0.2100992018,
         (k_inq_per_addr_i = NULL) => 0.1011011743, 0.1011011743),
      (r_C12_source_profile_d = NULL) => 0.0160388900, 0.0160388900),
   (f_addrchangevaluediff_d = NULL) => 0.0275660463, 0.0215873926),
(f_phone_ver_experian_d > 0.5) => -0.0127405623,
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 29.5) => -0.0042209606,
   (f_rel_homeover50_count_d > 29.5) => 0.1667779453,
   (f_rel_homeover50_count_d = NULL) => -0.0306484142, -0.0031046772), 0.0004188481);

// Tree: 45 
wFDN_FLAPSD_lgt_45 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => -0.0027065227,
(r_L79_adls_per_addr_c6_i > 3.5) => 
   map(
   (NULL < c_professional and c_professional <= 1.45) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 121.5) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 94) => 0.0695934655,
         (f_curraddrcartheftindex_i > 94) => 0.2769578483,
         (f_curraddrcartheftindex_i = NULL) => 0.1949765807, 0.1949765807),
      (f_M_Bureau_ADL_FS_all_d > 121.5) => 0.0502221189,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1085762613, 0.1085762613),
   (c_professional > 1.45) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0047977125,
      (f_hh_collections_ct_i > 2.5) => 0.1148533842,
      (f_hh_collections_ct_i = NULL) => 0.0110556407, 0.0110556407),
   (c_professional = NULL) => 0.0412693696, 0.0412693696),
(r_L79_adls_per_addr_c6_i = NULL) => 0.0009890470, 0.0009890470);

// Tree: 46 
wFDN_FLAPSD_lgt_46 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1231688852,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0077152058,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 114.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.85) => 0.0302236373,
         (c_pop_35_44_p > 13.85) => 
            map(
            (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 4.5) => 0.2647020555,
            (f_srchaddrsrchcount_i > 4.5) => 0.0458028188,
            (f_srchaddrsrchcount_i = NULL) => 0.1645520779, 0.1645520779),
         (c_pop_35_44_p = NULL) => 0.0906714356, 0.0906714356),
      (c_many_cars > 114.5) => -0.0077199265,
      (c_many_cars = NULL) => 0.0457194714, 0.0457194714),
   (f_hh_tot_derog_i = NULL) => -0.0050114368, -0.0050114368),
(r_C10_M_Hdr_FS_d = NULL) => 0.0133901762, -0.0041344680);

// Tree: 47 
wFDN_FLAPSD_lgt_47 := map(
(NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1111608295,
   (f_attr_arrest_recency_d > 79.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0105293600,
      (k_inq_per_phone_i > 2.5) => 
         map(
         (NULL < nf_vf_type and nf_vf_type <= 0.5) => 
            map(
            (NULL < c_no_teens and c_no_teens <= 115.5) => 0.1425327047,
            (c_no_teens > 115.5) => 0.0006773851,
            (c_no_teens = NULL) => 0.0904883829, 0.0904883829),
         (nf_vf_type > 0.5) => -0.0358962014,
         (nf_vf_type = NULL) => 0.0395464199, 0.0395464199),
      (k_inq_per_phone_i = NULL) => -0.0082996803, -0.0082996803),
   (f_attr_arrest_recency_d = NULL) => -0.0075287710, -0.0075287710),
(f_srchunvrfdssncount_i > 0.5) => 0.0522623718,
(f_srchunvrfdssncount_i = NULL) => -0.0052520055, -0.0037249596);

// Tree: 48 
wFDN_FLAPSD_lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 2.5) => 0.1045560580,
   (f_M_Bureau_ADL_FS_all_d > 2.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 39.75) => -0.0094109786,
      (c_hh3_p > 39.75) => 0.1929162968,
      (c_hh3_p = NULL) => -0.0299735511, -0.0089798588),
   (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0226042005, -0.0085326848),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0059525751,
   (f_idverrisktype_i > 1.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 3.35) => 0.1525263281,
      (c_rnt500_p > 3.35) => 0.0278153936,
      (c_rnt500_p = NULL) => 0.0846186617, 0.0846186617),
   (f_idverrisktype_i = NULL) => 0.0365928308, 0.0365928308),
(k_inq_per_phone_i = NULL) => -0.0062915280, -0.0062915280);

// Tree: 49 
wFDN_FLAPSD_lgt_49 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 67343.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 6.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 66349.5) => -0.0002751946,
      (r_L80_Inp_AVM_AutoVal_d > 66349.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','6: Other']) => 0.0555707304,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 0.2519922876,
         (nf_seg_FraudPoint_3_0 = '') => 0.1487877406, 0.1487877406),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0179889624, 0.0320758007),
   (f_sourcerisktype_i > 6.5) => 0.1672983871,
   (f_sourcerisktype_i = NULL) => 0.0483992426, 0.0483992426),
(r_A46_Curr_AVM_AutoVal_d > 67343.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0192017197,
   (r_L70_Add_Standardized_i > 0.5) => 0.0817453963,
   (r_L70_Add_Standardized_i = NULL) => -0.0135518659, -0.0135518659),
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0062450095, -0.0071522079);

// Tree: 50 
wFDN_FLAPSD_lgt_50 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 412731) => -0.0288599134,
   (f_curraddrmedianvalue_d > 412731) => 0.0357493788,
   (f_curraddrmedianvalue_d = NULL) => -0.0165495277, -0.0165495277),
(f_crim_rel_under25miles_cnt_i > 0.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 54.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 0.0349834866,
      (f_phone_ver_insurance_d > 3.5) => -0.0100485187,
      (f_phone_ver_insurance_d = NULL) => 0.0123307560, 0.0123307560),
   (f_phones_per_addr_curr_i > 54.5) => 0.1851963362,
   (f_phones_per_addr_curr_i = NULL) => 0.0142726897, 0.0142726897),
(f_crim_rel_under25miles_cnt_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.65) => -0.0380862341,
   (c_pop_6_11_p > 9.65) => 0.1092712273,
   (c_pop_6_11_p = NULL) => -0.0156914831, -0.0156914831), -0.0039815916);

// Tree: 51 
wFDN_FLAPSD_lgt_51 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 19.5) => 
   map(
   (NULL < r_C15_ssns_per_adl_c6_i and r_C15_ssns_per_adl_c6_i <= 0.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0179912304,
      (f_crim_rel_under100miles_cnt_i > 0.5) => 0.0148746758,
      (f_crim_rel_under100miles_cnt_i = NULL) => -0.0443378602, -0.0031126039),
   (r_C15_ssns_per_adl_c6_i > 0.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 34.1) => 0.1650275455,
      (c_high_ed > 34.1) => -0.0419677911,
      (c_high_ed = NULL) => 0.0604049026, 0.0604049026),
   (r_C15_ssns_per_adl_c6_i = NULL) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 111.5) => -0.0520912728,
      (c_easiqlife > 111.5) => 0.0929349956,
      (c_easiqlife = NULL) => 0.0183098284, 0.0183098284), -0.0019887704),
(k_inq_per_ssn_i > 19.5) => 0.1304148551,
(k_inq_per_ssn_i = NULL) => -0.0013833774, -0.0013833774);

// Tree: 52 
wFDN_FLAPSD_lgt_52 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -89306.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 20.5) => 0.2196712675,
      (c_born_usa > 20.5) => 0.0097369733,
      (c_born_usa = NULL) => 0.0678255887, 0.0678255887),
   (f_addrchangevaluediff_d > -89306.5) => -0.0128096815,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0012835685,
      (k_inq_per_phone_i > 2.5) => 0.0913618961,
      (k_inq_per_phone_i = NULL) => 0.0029402827, 0.0029402827), -0.0079747117),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < c_totsales and c_totsales <= 32708) => 0.0702195811,
   (c_totsales > 32708) => -0.0499218607,
   (c_totsales = NULL) => 0.0473808119, 0.0473808119),
(r_D33_eviction_count_i = NULL) => 0.0078334030, -0.0056382367);

// Tree: 53 
wFDN_FLAPSD_lgt_53 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 1.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0134948231,
   (f_crim_rel_under25miles_cnt_i > 0.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 5.5) => 0.0135452121,
      (k_inq_per_ssn_i > 5.5) => 
         map(
         (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 0.1315793949,
         (r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0474194883,
         (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0908629108, 0.0908629108),
      (k_inq_per_ssn_i = NULL) => 0.0170692778, 0.0170692778),
   (f_crim_rel_under25miles_cnt_i = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 141.5) => 0.1087519824,
      (c_asian_lang > 141.5) => -0.0851089321,
      (c_asian_lang = NULL) => -0.0079320752, -0.0079320752), -0.0009031162),
(f_hh_payday_loan_users_i > 1.5) => 0.1186216781,
(f_hh_payday_loan_users_i = NULL) => 0.0130552145, -0.0000786857);

// Tree: 54 
wFDN_FLAPSD_lgt_54 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 3.5) => -0.0284062029,
(f_corrrisktype_i > 3.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 128.5) => -0.0001859297,
   (f_prevaddrageoldest_d > 128.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < c_med_rent and c_med_rent <= 853.5) => 0.0380085223,
         (c_med_rent > 853.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02759615385) => 0.1026713833,
            (f_add_curr_nhood_BUS_pct_i > 0.02759615385) => 0.2325395592,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1652394518, 0.1652394518),
         (c_med_rent = NULL) => 0.0936587786, 0.0936587786),
      (f_phone_ver_experian_d > 0.5) => 0.0157081483,
      (f_phone_ver_experian_d = NULL) => 0.0642476473, 0.0607515291),
   (f_prevaddrageoldest_d = NULL) => 0.0106583257, 0.0106583257),
(f_corrrisktype_i = NULL) => -0.0006332357, -0.0048876766);

// Tree: 55 
wFDN_FLAPSD_lgt_55 := map(
(NULL < c_hval_40k_p and c_hval_40k_p <= 35.05) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.15) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
         map(
         (NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 3.5) => 0.0039317838,
         (nf_vf_lexid_hi_summary > 3.5) => 0.0730729672,
         (nf_vf_lexid_hi_summary = NULL) => 0.0061730873, 0.0061730873),
      (f_phone_ver_insurance_d > 3.5) => -0.0240007660,
      (f_phone_ver_insurance_d = NULL) => -0.0066953908, -0.0091581879),
   (c_hh7p_p > 7.15) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.1463325904,
      (r_F01_inp_addr_address_score_d > 95) => 0.0306625072,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0438249650, 0.0438249650),
   (c_hh7p_p = NULL) => -0.0066464642, -0.0066464642),
(c_hval_40k_p > 35.05) => -0.1356219865,
(c_hval_40k_p = NULL) => 0.0031224363, -0.0072015687);

// Tree: 56 
wFDN_FLAPSD_lgt_56 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.0646495920,
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 15.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 51.5) => 
         map(
         (NULL < c_no_car and c_no_car <= 175.5) => 0.0160375923,
         (c_no_car > 175.5) => 
            map(
            (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.1708317968,
            (f_property_owners_ct_d > 0.5) => 0.0184953289,
            (f_property_owners_ct_d = NULL) => 0.1048427277, 0.1048427277),
         (c_no_car = NULL) => 0.0325647916, 0.0325647916),
      (c_ab_av_edu > 51.5) => -0.0095156878,
      (c_ab_av_edu = NULL) => -0.0069440685, -0.0054634673),
   (k_inq_per_ssn_i > 15.5) => 0.1115134681,
   (k_inq_per_ssn_i = NULL) => -0.0048287528, -0.0048287528),
(r_D33_Eviction_Recency_d = NULL) => 0.0248946805, -0.0033590159);

// Tree: 57 
wFDN_FLAPSD_lgt_57 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 
         map(
         (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => -0.0152287377,
         (r_I60_inq_hiRiskCred_count12_i > 2.5) => -0.1130643322,
         (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0160997223, -0.0160997223),
      (f_util_add_input_misc_n > 0.5) => 0.0128548631,
      (f_util_add_input_misc_n = NULL) => -0.0023985633, -0.0023985633),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1002552624,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0045974674, -0.0019240134),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 5.2) => 0.0086030393,
   (c_hval_150k_p > 5.2) => 0.2556987389,
   (c_hval_150k_p = NULL) => 0.1258953018, 0.1258953018),
(f_nae_nothing_found_i = NULL) => -0.0003117871, -0.0003117871);

// Tree: 58 
wFDN_FLAPSD_lgt_58 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 13.5) => 
   map(
   (NULL < f_srchfraudsrchcountwk_i and f_srchfraudsrchcountwk_i <= 0.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 2.5) => -0.0150699555,
      (f_srchaddrsrchcount_i > 2.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 13.5) => 0.1302497392,
         (r_C13_max_lres_d > 13.5) => 0.0132061537,
         (r_C13_max_lres_d = NULL) => 0.0147898427, 0.0147898427),
      (f_srchaddrsrchcount_i = NULL) => -0.0056124614, -0.0056124614),
   (f_srchfraudsrchcountwk_i > 0.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => 0.2155692165,
      (f_inq_count_i > 5.5) => -0.0196377928,
      (f_inq_count_i = NULL) => 0.1035658787, 0.1035658787),
   (f_srchfraudsrchcountwk_i = NULL) => -0.0118446425, -0.0045660924),
(r_L79_adls_per_addr_curr_i > 13.5) => 0.1147309996,
(r_L79_adls_per_addr_curr_i = NULL) => -0.0036444436, -0.0036444436);

// Tree: 59 
wFDN_FLAPSD_lgt_59 := map(
(NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0176460351,
   (f_nae_nothing_found_i > 0.5) => 0.2074599641,
   (f_nae_nothing_found_i = NULL) => -0.0159738765, -0.0159738765),
(f_util_add_input_misc_n > 0.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0002431004,
   (r_C23_inp_addr_occ_index_d > 2) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 104.5) => 0.1022425477,
      (c_ab_av_edu > 104.5) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 133.5) => -0.0193622353,
         (f_prevaddrcartheftindex_i > 133.5) => 0.0920884565,
         (f_prevaddrcartheftindex_i = NULL) => 0.0097915331, 0.0097915331),
      (c_ab_av_edu = NULL) => 0.0164009939, 0.0473772672),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0100100690, 0.0100100690),
(f_util_add_input_misc_n = NULL) => -0.0037777069, -0.0037777069);

// Tree: 60 
wFDN_FLAPSD_lgt_60 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 135.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 8.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0185849306,
      (f_util_adl_count_n > 4.5) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 11.5) => 0.0168791803,
         (f_srchfraudsrchcount_i > 11.5) => 0.1134376601,
         (f_srchfraudsrchcount_i = NULL) => 0.0234575576, 0.0234575576),
      (f_util_adl_count_n = NULL) => -0.0126308153, -0.0126308153),
   (r_D32_criminal_count_i > 8.5) => 0.1135402615,
   (r_D32_criminal_count_i = NULL) => -0.0114250943, -0.0114250943),
(f_prevaddrageoldest_d > 135.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 10229) => 0.0206872866,
   (f_addrchangeincomediff_d > 10229) => 0.1614975270,
   (f_addrchangeincomediff_d = NULL) => 0.0577251073, 0.0299115413),
(f_prevaddrageoldest_d = NULL) => -0.0134942717, -0.0001115518);

// Tree: 61 
wFDN_FLAPSD_lgt_61 := map(
(NULL < c_unempl and c_unempl <= 52.5) => -0.0315399458,
(c_unempl > 52.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.1066916233,
   (r_F00_dob_score_d > 55) => 
      map(
      (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 5.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 52315) => 
            map(
            (NULL < c_asian_lang and c_asian_lang <= 146.5) => 0.0349066364,
            (c_asian_lang > 146.5) => 0.2143148884,
            (c_asian_lang = NULL) => 0.0637488350, 0.0637488350),
         (r_A46_Curr_AVM_AutoVal_d > 52315) => 0.0087401912,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0000816119, 0.0072539648),
      (f_divaddrsuspidcountnew_i > 5.5) => 0.1403525972,
      (f_divaddrsuspidcountnew_i = NULL) => 0.0079615672, 0.0079615672),
   (r_F00_dob_score_d = NULL) => -0.0054054316, 0.0080381577),
(c_unempl = NULL) => -0.0127857452, 0.0003141635);

// Tree: 62 
wFDN_FLAPSD_lgt_62 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.905) => -0.0131433803,
   (c_hhsize > 2.905) => 
      map(
      (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.0484980748,
      (f_curraddractivephonelist_d > 0.5) => 0.0037544244,
      (f_curraddractivephonelist_d = NULL) => 0.0228840580, 0.0228840580),
   (c_hhsize = NULL) => -0.0431698993, -0.0044509641),
(f_inq_PrepaidCards_count24_i > 0.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 46.5) => 0.1444683953,
   (c_born_usa > 46.5) => 0.0281609198,
   (c_born_usa = NULL) => 0.0695146889, 0.0695146889),
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 6.45) => -0.0484943093,
   (C_INC_15K_P > 6.45) => 0.0813066047,
   (C_INC_15K_P = NULL) => 0.0169908365, 0.0169908365), -0.0031812307);

// Tree: 63 
wFDN_FLAPSD_lgt_63 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 3.5) => -0.0039662838,
(f_srchphonesrchcount_i > 3.5) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 0.55) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 3.5) => 
         map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.2536491715,
         (f_corrssnaddrcount_d > 2.5) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 278) => 0.0461257305,
            (r_C13_max_lres_d > 278) => 0.2932692989,
            (r_C13_max_lres_d = NULL) => 0.1009582264, 0.1009582264),
         (f_corrssnaddrcount_d = NULL) => 0.1221065567, 0.1221065567),
      (f_inq_count24_i > 3.5) => -0.0031950852,
      (f_inq_count24_i = NULL) => 0.0767234532, 0.0767234532),
   (c_wholesale > 0.55) => -0.0189732744,
   (c_wholesale = NULL) => 0.0359601412, 0.0359601412),
(f_srchphonesrchcount_i = NULL) => 0.0025432623, -0.0007853637);

// Tree: 64 
wFDN_FLAPSD_lgt_64 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => -0.0057734704,
   (f_inq_Communications_count_i > 1.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 54.5) => 0.1279000200,
      (c_mort_indx > 54.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 120.5) => -0.0161474684,
         (c_no_labfor > 120.5) => 0.0793856908,
         (c_no_labfor = NULL) => 0.0173877704, 0.0173877704),
      (c_mort_indx = NULL) => 0.0342408884, 0.0342408884),
   (f_inq_Communications_count_i = NULL) => -0.0520235195, -0.0048370329),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 43) => 0.0109203329,
   (r_C13_Curr_Addr_LRes_d > 43) => 0.1499994654,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0737302637, 0.0737302637),
(k_nap_contradictory_i = NULL) => -0.0034372529, -0.0034372529);

// Tree: 65 
wFDN_FLAPSD_lgt_65 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0067157489,
   (r_D33_eviction_count_i > 3.5) => 0.0895044269,
   (r_D33_eviction_count_i = NULL) => -0.0131193123, -0.0061590631),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 85.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.2274371861,
         (f_corrphonelastnamecount_d > 0.5) => 0.0610850548,
         (f_corrphonelastnamecount_d = NULL) => 0.1552223074, 0.1552223074),
      (c_mort_indx > 85.5) => 0.0222124736,
      (c_mort_indx = NULL) => 0.0779211377, 0.0779211377),
   (f_phone_ver_experian_d > 0.5) => 0.0056659334,
   (f_phone_ver_experian_d = NULL) => 0.0323464374, 0.0360253334),
(r_L70_Add_Standardized_i = NULL) => -0.0026472994, -0.0026472994);

// Tree: 66 
wFDN_FLAPSD_lgt_66 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 81.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 2.285) => -0.0355381290,
      (c_hhsize > 2.285) => 
         map(
         (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 25.5) => -0.0066891658,
         (r_P88_Phn_Dst_to_Inp_Add_i > 25.5) => -0.0445380858,
         (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0210029565, -0.0010580381),
      (c_hhsize = NULL) => 0.0116355419, -0.0088680920),
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_child and c_child <= 20.85) => 0.2979758395,
      (c_child > 20.85) => 0.0311158523,
      (c_child = NULL) => 0.0993540226, 0.0993540226),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0069210032, -0.0069210032),
(f_phones_per_addr_curr_i > 81.5) => 0.1205620968,
(f_phones_per_addr_curr_i = NULL) => -0.0062376093, -0.0062376093);

// Tree: 67 
wFDN_FLAPSD_lgt_67 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.1111533196,
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 8296.5) => -0.0110970526,
   (f_addrchangeincomediff_d > 8296.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1090491764,
      (r_Phn_Cell_n > 0.5) => -0.0034324936,
      (r_Phn_Cell_n = NULL) => 0.0482555119, 0.0482555119),
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 126666.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => 0.0328888887,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity']) => 0.2051695584,
         (nf_seg_FraudPoint_3_0 = '') => 0.0759590561, 0.0759590561),
      (r_L80_Inp_AVM_AutoVal_d > 126666.5) => 0.0067129633,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0125377054, 0.0051403901), -0.0055060681),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0192469824, -0.0036365838);

// Tree: 68 
wFDN_FLAPSD_lgt_68 := map(
(NULL < f_vf_AltLexID_phn_hi_risk_ct_i and f_vf_AltLexID_phn_hi_risk_ct_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 460.5) => -0.0073949129,
   (r_C10_M_Hdr_FS_d > 460.5) => 0.0844205846,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0041950682, -0.0041950682),
(f_vf_AltLexID_phn_hi_risk_ct_i > 0.5) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 40.65) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 18.5) => 0.0954260208,
      (f_prevaddrlenofres_d > 18.5) => -0.0832823748,
      (f_prevaddrlenofres_d = NULL) => -0.0078277189, -0.0078277189),
   (c_lowinc > 40.65) => 0.1596309340,
   (c_lowinc = NULL) => 0.0493532845, 0.0493532845),
(f_vf_AltLexID_phn_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_child and c_child <= 24.45) => -0.0547732811,
   (c_child > 24.45) => 0.0749142953,
   (c_child = NULL) => 0.0076688853, 0.0076688853), -0.0032141386);

// Tree: 69 
wFDN_FLAPSD_lgt_69 := map(
(NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0107198454,
(f_phones_per_addr_c6_i > 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 126.5) => -0.0011988434,
   (c_easiqlife > 126.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 25.6) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
            map(
            (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 113239) => 0.1610705179,
            (r_A46_Curr_AVM_AutoVal_d > 113239) => 0.0732777825,
            (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0327087219, 0.0619404425),
         (f_corrphonelastnamecount_d > 0.5) => 0.0119609404,
         (f_corrphonelastnamecount_d = NULL) => 0.0330633968, 0.0330633968),
      (C_INC_50K_P > 25.6) => 0.2302627781,
      (C_INC_50K_P = NULL) => 0.0384321758, 0.0384321758),
   (c_easiqlife = NULL) => -0.0260645299, 0.0152067007),
(f_phones_per_addr_c6_i = NULL) => -0.0014876650, -0.0014876650);

// Tree: 70 
wFDN_FLAPSD_lgt_70 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 59.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0023631219,
   (r_D32_felony_count_i > 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 184) => 0.1802602440,
      (f_M_Bureau_ADL_FS_noTU_d > 184) => 0.0069666968,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0630322562, 0.0630322562),
   (r_D32_felony_count_i = NULL) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 33.7) => 0.0370773268,
      (c_high_ed > 33.7) => -0.0752492626,
      (c_high_ed = NULL) => -0.0172445484, -0.0172445484), -0.0016229020),
(f_phones_per_addr_curr_i > 59.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 4.5) => 0.0440191027,
   (f_rel_homeover200_count_d > 4.5) => 0.2317123642,
   (f_rel_homeover200_count_d = NULL) => 0.1254448559, 0.1254448559),
(f_phones_per_addr_curr_i = NULL) => -0.0002305158, -0.0002305158);

// Tree: 71 
wFDN_FLAPSD_lgt_71 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.327944776) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 145.5) => -0.0164983613,
      (c_easiqlife > 145.5) => 0.0397464918,
      (c_easiqlife = NULL) => -0.0531513020, -0.0045050361),
   (f_srchaddrsrchcount_i > 3.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 4.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.0334757098,
         (k_inq_per_ssn_i > 0.5) => 0.1803243619,
         (k_inq_per_ssn_i = NULL) => 0.1171452907, 0.1171452907),
      (f_prevaddrlenofres_d > 4.5) => 0.0286809988,
      (f_prevaddrlenofres_d = NULL) => 0.0354436025, 0.0354436025),
   (f_srchaddrsrchcount_i = NULL) => 0.0067122031, 0.0052850257),
(f_add_input_mobility_index_i > 0.327944776) => -0.0185050820,
(f_add_input_mobility_index_i = NULL) => 0.0748951868, -0.0004494665);

// Tree: 72 
wFDN_FLAPSD_lgt_72 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21648) => 0.1175518133,
(r_A46_Curr_AVM_AutoVal_d > 21648) => -0.0006588593,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 29.55) => -0.0429056269,
   (c_low_ed > 29.55) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 63871) => 0.0087418184,
      (f_addrchangevaluediff_d > 63871) => 0.1219565523,
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 129616.5) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 175.5) => -0.0085499535,
            (r_C13_max_lres_d > 175.5) => 0.2527714292,
            (r_C13_max_lres_d = NULL) => 0.0821125670, 0.0821125670),
         (r_L80_Inp_AVM_AutoVal_d > 129616.5) => -0.0548000700,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0048628171, 0.0063163113), 0.0102958100),
   (c_low_ed = NULL) => 0.0252572078, -0.0032786182), -0.0009412988);

// Tree: 73 
wFDN_FLAPSD_lgt_73 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 105.95) => -0.0056561627,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 105.95) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2.5) => 0.0099857404,
      (f_idverrisktype_i > 2.5) => 
         map(
         (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
            map(
            (NULL < c_cpiall and c_cpiall <= 209.3) => 0.2510866384,
            (c_cpiall > 209.3) => 0.0979577612,
            (c_cpiall = NULL) => 0.1287065317, 0.1287065317),
         (f_phone_ver_insurance_d > 3.5) => 0.0260561996,
         (f_phone_ver_insurance_d = NULL) => 0.0763789210, 0.0763789210),
      (f_idverrisktype_i = NULL) => 0.0227507830, 0.0227507830),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0106156858, -0.0022366990),
(f_historical_count_d > 16.5) => 0.1635283694,
(f_historical_count_d = NULL) => 0.0084944988, -0.0010016671);

// Tree: 74 
wFDN_FLAPSD_lgt_74 := map(
(NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 4.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03724691115) => 0.1007952935,
      (f_add_curr_nhood_BUS_pct_i > 0.03724691115) => 0.0124192922,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0622085887, 0.0622085887),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 9) => 0.0657020184,
      (r_I60_inq_comm_recency_d > 9) => -0.0020592128,
      (r_I60_inq_comm_recency_d = NULL) => -0.0009926317, -0.0009926317),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0002299377, -0.0002299377),
(nf_vf_lexid_hi_summary > 4.5) => -0.0560090184,
(nf_vf_lexid_hi_summary = NULL) => 
   map(
   (NULL < c_highrent and c_highrent <= 2.25) => -0.0714373055,
   (c_highrent > 2.25) => 0.0414872769,
   (c_highrent = NULL) => -0.0123365895, -0.0123365895), -0.0013340520);

// Tree: 75 
wFDN_FLAPSD_lgt_75 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 6.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 29.2) => -0.0318770661,
   (c_low_ed > 29.2) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 14.5) => 0.1757029516,
      (r_C13_max_lres_d > 14.5) => 0.0286650062,
      (r_C13_max_lres_d = NULL) => 0.1050116317, 0.1050116317),
   (c_low_ed = NULL) => 0.0533709852, 0.0533709852),
(r_C10_M_Hdr_FS_d > 6.5) => 
   map(
   (NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => -0.0047762158,
   (f_srchunvrfdssncount_i > 0.5) => 0.0386389556,
   (f_srchunvrfdssncount_i = NULL) => -0.0018895687, -0.0018895687),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 79.5) => -0.0611990905,
   (c_larceny > 79.5) => 0.0781967876,
   (c_larceny = NULL) => 0.0045536822, 0.0045536822), -0.0011061813);

// Tree: 76 
wFDN_FLAPSD_lgt_76 := map(
(NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 
   map(
   (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 59.5) => -0.0040793590,
      (f_phones_per_addr_curr_i > 59.5) => 0.0851310829,
      (f_phones_per_addr_curr_i = NULL) => -0.0030876193, -0.0030876193),
   (f_prevaddroccupantowned_i > 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 32.2) => 0.0272390730,
      (c_famotf18_p > 32.2) => 0.1566428421,
      (c_famotf18_p = NULL) => 0.0352988233, 0.0352988233),
   (f_prevaddroccupantowned_i = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 139.5) => 0.0698924351,
      (c_asian_lang > 139.5) => -0.0604412369,
      (c_asian_lang = NULL) => 0.0105440666, 0.0105440666), -0.0002989753),
(k_inq_addrs_per_ssn_i > 2.5) => 0.0881100944,
(k_inq_addrs_per_ssn_i = NULL) => 0.0003422257, 0.0003422257);

// Tree: 77 
wFDN_FLAPSD_lgt_77 := map(
(NULL < c_sub_bus and c_sub_bus <= 162.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 11.5) => -0.0117031376,
   (k_inq_per_ssn_i > 11.5) => 0.0806540018,
   (k_inq_per_ssn_i = NULL) => -0.0109594608, -0.0109594608),
(c_sub_bus > 162.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1949.5) => 0.1957137855,
      (c_med_yearblt > 1949.5) => 0.0332223037,
      (c_med_yearblt = NULL) => 0.0922089375, 0.0922089375),
   (f_corrssnaddrcount_d > 1.5) => 
      map(
      (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 0.0096064101,
      (f_hh_tot_derog_i > 4.5) => 0.0962652978,
      (f_hh_tot_derog_i = NULL) => 0.0131588862, 0.0131588862),
   (f_corrssnaddrcount_d = NULL) => 0.0176654491, 0.0176654491),
(c_sub_bus = NULL) => -0.0094421641, -0.0050787720);

// Tree: 78 
wFDN_FLAPSD_lgt_78 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 23.5) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1541.5) => -0.0013749068,
      (f_liens_unrel_SC_total_amt_i > 1541.5) => -0.0683911786,
      (f_liens_unrel_SC_total_amt_i = NULL) => -0.0026838184, -0.0026838184),
   (f_inq_Other_count24_i > 3.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 26.6) => 0.0243920374,
      (c_rnt750_p > 26.6) => 0.1912481867,
      (c_rnt750_p = NULL) => 0.0805533754, 0.0805533754),
   (f_inq_Other_count24_i = NULL) => -0.0013179635, -0.0013179635),
(f_srchssnsrchcount_i > 23.5) => 0.0887330023,
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0859259395,
   (k_comb_age_d > 25.5) => 0.0473891599,
   (k_comb_age_d = NULL) => -0.0105264161, -0.0105264161), -0.0009095964);

// Tree: 79 
wFDN_FLAPSD_lgt_79 := map(
(NULL < C_INC_75K_P and C_INC_75K_P <= 31.95) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 34.75) => -0.0023025564,
   (c_hh3_p > 34.75) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','6: Other']) => -0.0084169855,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.2209765344,
      (nf_seg_FraudPoint_3_0 = '') => 0.0824466815, 0.0824466815),
   (c_hh3_p = NULL) => -0.0012315419, -0.0012315419),
(C_INC_75K_P > 31.95) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 43.5) => 0.2596287380,
   (c_no_teens > 43.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 101) => -0.0565641911,
      (f_curraddrburglaryindex_i > 101) => 0.2050149230,
      (f_curraddrburglaryindex_i = NULL) => 0.0422139359, 0.0422139359),
   (c_no_teens = NULL) => 0.1038688798, 0.1038688798),
(C_INC_75K_P = NULL) => -0.0148964590, 0.0001128050);

// Tree: 80 
wFDN_FLAPSD_lgt_80 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 6.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 77.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 187.5) => 0.0228587896,
      (r_D32_Mos_Since_Crim_LS_d > 187.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 18.5) => -0.0062299201,
         (f_addrs_per_ssn_i > 18.5) => -0.0621977560,
         (f_addrs_per_ssn_i = NULL) => -0.0098232911, -0.0098232911),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0048187471, -0.0048187471),
   (k_comb_age_d > 77.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.0127519031,
      (k_inq_per_ssn_i > 0.5) => 0.2090206686,
      (k_inq_per_ssn_i = NULL) => 0.0694517687, 0.0694517687),
   (k_comb_age_d = NULL) => -0.0032121906, -0.0032121906),
(f_varrisktype_i > 6.5) => 0.0854955026,
(f_varrisktype_i = NULL) => 0.0203046551, -0.0023887358);

// Tree: 81 
wFDN_FLAPSD_lgt_81 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21625) => 0.1433847642,
(r_A46_Curr_AVM_AutoVal_d > 21625) => -0.0058763065,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.34805944345) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 481.4) => 0.0275268484,
         (c_oldhouse > 481.4) => 0.1631585954,
         (c_oldhouse = NULL) => 0.0388068434, 0.0388068434),
      (f_hh_age_18_plus_d > 1.5) => -0.0062779525,
      (f_hh_age_18_plus_d = NULL) => 0.0085770860, 0.0059174766),
   (f_add_input_mobility_index_i > 0.34805944345) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 9.5) => -0.0441639484,
      (r_C14_addrs_15yr_i > 9.5) => 0.0699362854,
      (r_C14_addrs_15yr_i = NULL) => -0.0399324166, -0.0399324166),
   (f_add_input_mobility_index_i = NULL) => 0.1074854414, -0.0057022633), -0.0048827369);

// Tree: 82 
wFDN_FLAPSD_lgt_82 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.15) => -0.0055881009,
(r_C12_source_profile_d > 78.15) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 2.5) => 0.0298321812,
   (r_P88_Phn_Dst_to_Inp_Add_i > 2.5) => -0.0256570942,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 7.75) => 0.0148356669,
      (c_rnt1000_p > 7.75) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.15) => 0.0963955154,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.15) => 0.3091755979,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0827571975, 0.1405383082),
      (c_rnt1000_p = NULL) => 0.0849808445, 0.0849808445), 0.0346789867),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 95) => -0.0384283088,
   (c_larceny > 95) => 0.0811074163,
   (c_larceny = NULL) => 0.0160967588, 0.0160967588), 0.0000716087);

// Tree: 83 
wFDN_FLAPSD_lgt_83 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 74.5) => -0.0088089119,
   (k_comb_age_d > 74.5) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 13.15) => 0.2277003810,
      (c_hh1_p > 13.15) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 97) => -0.0214712803,
         (r_A50_pb_average_dollars_d > 97) => 0.1279067860,
         (r_A50_pb_average_dollars_d = NULL) => 0.0313917351, 0.0313917351),
      (c_hh1_p = NULL) => 0.0597574339, 0.0597574339),
   (k_comb_age_d = NULL) => -0.0063735999, -0.0063735999),
(f_inq_HighRiskCredit_count_i > 21.5) => 0.1180369759,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 0.95) => 0.0661964962,
   (c_pop_85p_p > 0.95) => -0.0845826131,
   (c_pop_85p_p = NULL) => -0.0113888707, -0.0113888707), -0.0059251246);

// Tree: 84 
wFDN_FLAPSD_lgt_84 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 3.5) => -0.0108542523,
(f_srchaddrsrchcount_i > 3.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 33.45) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 27.5) => 0.0118386652,
      (f_addrchangecrimediff_i > 27.5) => 0.1344493734,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 3.8) => 0.0011293621,
         (c_pop_85p_p > 3.8) => 0.1693970195,
         (c_pop_85p_p = NULL) => 0.0168303936, 0.0168303936), 0.0151255196),
   (c_hval_100k_p > 33.45) => 0.1413721105,
   (c_hval_100k_p = NULL) => 0.0188311381, 0.0188311381),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0712421264,
   (k_comb_age_d > 26.5) => 0.0608889882,
   (k_comb_age_d = NULL) => 0.0005187376, 0.0005187376), -0.0037600838);

// Tree: 85 
wFDN_FLAPSD_lgt_85 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 66.5) => -0.0750793956,
   (c_lar_fam > 66.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 94.5) => 0.0130328801,
      (c_work_home > 94.5) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 101.5) => 0.2270992612,
         (c_lar_fam > 101.5) => 0.0696912951,
         (c_lar_fam = NULL) => 0.1382399255, 0.1382399255),
      (c_work_home = NULL) => 0.0826547349, 0.0826547349),
   (c_lar_fam = NULL) => 0.0523652099, 0.0523652099),
(r_F00_input_dob_match_level_d > 4.5) => -0.0022592813,
(r_F00_input_dob_match_level_d = NULL) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 2.1) => 0.0331438495,
   (c_hval_750k_p > 2.1) => -0.0723964030,
   (c_hval_750k_p = NULL) => -0.0148289925, -0.0148289925), -0.0011214575);

// Tree: 86 
wFDN_FLAPSD_lgt_86 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 3.35) => 
         map(
         (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
            map(
            (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 168.5) => 0.0341952499,
            (f_M_Bureau_ADL_FS_all_d > 168.5) => 0.1441743890,
            (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0988724623, 0.0988724623),
         (k_nap_phn_verd_d > 0.5) => -0.0185371048,
         (k_nap_phn_verd_d = NULL) => 0.0686909069, 0.0686909069),
      (c_rnt500_p > 3.35) => 0.0050312619,
      (c_rnt500_p = NULL) => 0.0451180994, 0.0362667849),
   (f_corrphonelastnamecount_d > 0.5) => -0.0161609843,
   (f_corrphonelastnamecount_d = NULL) => 0.0134392605, 0.0134392605),
(f_phone_ver_experian_d > 0.5) => -0.0138905105,
(f_phone_ver_experian_d = NULL) => -0.0079501952, -0.0037945602);

// Tree: 87 
wFDN_FLAPSD_lgt_87 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 178.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 65.5) => -0.0099707904,
      (f_addrchangecrimediff_i > 65.5) => 0.1198998994,
      (f_addrchangecrimediff_i = NULL) => -0.0040849565, -0.0073230412),
   (r_A50_pb_average_dollars_d > 178.5) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 7.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 25.5) => 0.0870461078,
         (r_C13_max_lres_d > 25.5) => 0.0160629210,
         (r_C13_max_lres_d = NULL) => 0.0197232231, 0.0197232231),
      (r_D32_criminal_count_i > 7.5) => 0.1070967784,
      (r_D32_criminal_count_i = NULL) => 0.0211761605, 0.0211761605),
   (r_A50_pb_average_dollars_d = NULL) => 0.0042001273, 0.0042001273),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0644709939,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0099410823, 0.0012535254);

// Tree: 88 
wFDN_FLAPSD_lgt_88 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.6545498226) => 
         map(
         (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 
            map(
            (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 12) => 0.1630570921,
            (r_C10_M_Hdr_FS_d > 12) => 0.0390311088,
            (r_C10_M_Hdr_FS_d = NULL) => 0.0450537697, 0.0450537697),
         (f_srchssnsrchcount_i > 6.5) => 0.1454359077,
         (f_srchssnsrchcount_i = NULL) => 0.0520482372, 0.0520482372),
      (f_add_curr_nhood_MFD_pct_i > 0.6545498226) => 0.0006454811,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0322116442, 0.0236743248),
   (r_Ever_Asset_Owner_d > 0.5) => -0.0050923874,
   (r_Ever_Asset_Owner_d = NULL) => 0.0004785215, 0.0004785215),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0584022572,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0046286153, -0.0019562175);

// Tree: 89 
wFDN_FLAPSD_lgt_89 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 111.5) => 0.0847526310,
(r_D32_Mos_Since_Fel_LS_d > 111.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 218.4) => -0.0108399033,
   (c_cpiall > 218.4) => 
      map(
      (NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 1.5) => 0.0169244772,
      (nf_vf_hi_summary > 1.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 14.8) => -0.0025386646,
         (c_hh4_p > 14.8) => 0.1657086588,
         (c_hh4_p = NULL) => 0.0788713306, 0.0788713306),
      (nf_vf_hi_summary = NULL) => 0.0201411479, 0.0201411479),
   (c_cpiall = NULL) => -0.0190146316, -0.0036405751),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_work_home and c_work_home <= 102) => 0.0788489137,
   (c_work_home > 102) => -0.0425111030,
   (c_work_home = NULL) => 0.0164351908, 0.0164351908), -0.0030268426);

// Tree: 90 
wFDN_FLAPSD_lgt_90 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 57) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 470.5) => 0.2105605622,
   (c_hh00 > 470.5) => 0.0246119254,
   (c_hh00 = NULL) => 0.0854028259, 0.0854028259),
(f_mos_liens_unrel_OT_fseen_d > 57) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0029856364,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.2009019872,
      (f_phone_ver_experian_d > 0.5) => 0.0328139420,
      (f_phone_ver_experian_d = NULL) => 0.0982527993, 0.0982527993),
   (f_nae_nothing_found_i = NULL) => -0.0015670918, -0.0015670918),
(f_mos_liens_unrel_OT_fseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 15.8) => 0.0596822586,
   (c_hh3_p > 15.8) => -0.0580441415,
   (c_hh3_p = NULL) => 0.0041509378, 0.0041509378), -0.0004346903);

// Tree: 91 
wFDN_FLAPSD_lgt_91 := map(
(NULL < c_unemp and c_unemp <= 14.45) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -162573.5) => 
      map(
      (NULL < c_young and c_young <= 30.05) => 0.1072159427,
      (c_young > 30.05) => -0.0433084201,
      (c_young = NULL) => 0.0519601639, 0.0519601639),
   (f_addrchangevaluediff_d > -162573.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 0.5) => 0.1212889672,
      (r_C13_Curr_Addr_LRes_d > 0.5) => -0.0080605491,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0073484348, -0.0073484348),
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 8.65) => -0.0164323309,
      (c_hh5_p > 8.65) => 0.0379958772,
      (c_hh5_p = NULL) => -0.0015979761, -0.0015979761), -0.0053999607),
(c_unemp > 14.45) => 0.0861098005,
(c_unemp = NULL) => -0.0234371500, -0.0052413047);

// Tree: 92 
wFDN_FLAPSD_lgt_92 := map(
(NULL < nf_vf_hi_addr_add_entries and nf_vf_hi_addr_add_entries <= 0.5) => 
   map(
   (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 0.5) => -0.0050823003,
   (f_divsrchaddrsuspidcount_i > 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 8) => -0.0366226056,
      (r_pb_order_freq_d > 8) => 0.0001733279,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 157122.5) => 0.1831993456,
         (r_A46_Curr_AVM_AutoVal_d > 157122.5) => 0.0308732077,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0537093666, 0.0716040341), 0.0303379123),
   (f_divsrchaddrsuspidcount_i = NULL) => -0.0027729093, -0.0027729093),
(nf_vf_hi_addr_add_entries > 0.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 128.5) => 0.0008928637,
   (c_bel_edu > 128.5) => -0.1034980526,
   (c_bel_edu = NULL) => -0.0468880532, -0.0468880532),
(nf_vf_hi_addr_add_entries = NULL) => 0.0086701925, -0.0033750189);

// Tree: 93 
wFDN_FLAPSD_lgt_93 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 5.5) => -0.0041230569,
   (f_srchfraudsrchcountyr_i > 5.5) => -0.0606779879,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0231544926, -0.0044990034),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 88.5) => 0.1646743816,
   (r_D32_Mos_Since_Crim_LS_d > 88.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => 0.0097831686,
      (k_comb_age_d > 63.5) => 
         map(
         (NULL < c_construction and c_construction <= 7.2) => 0.3535968333,
         (c_construction > 7.2) => 0.0075323539,
         (c_construction = NULL) => 0.1758022384, 0.1758022384),
      (k_comb_age_d = NULL) => 0.0301867728, 0.0301867728),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0419205910, 0.0419205910),
(r_L70_Add_Standardized_i = NULL) => -0.0006639435, -0.0006639435);

// Tree: 94 
wFDN_FLAPSD_lgt_94 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0010543011,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 130.5) => 
            map(
            (NULL < c_femdiv_p and c_femdiv_p <= 4.55) => -0.0440904442,
            (c_femdiv_p > 4.55) => 0.1406093055,
            (c_femdiv_p = NULL) => 0.0610463364, 0.0610463364),
         (c_no_teens > 130.5) => -0.0660253786,
         (c_no_teens = NULL) => 0.0182568813, 0.0182568813),
      (f_rel_incomeover100_count_d > 0.5) => 0.1363865765,
      (f_rel_incomeover100_count_d = NULL) => 0.0579004062, 0.0579004062),
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0003472476, 0.0003472476),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0755703365,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0037031459, -0.0000519135);

// Tree: 95 
wFDN_FLAPSD_lgt_95 := map(
(NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 4.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 80.2) => 0.0150076395,
      (C_OWNOCC_P > 80.2) => 0.1516351482,
      (C_OWNOCC_P = NULL) => 0.0526979868, 0.0526979868),
   (r_I60_inq_banking_recency_d > 4.5) => -0.0101424925,
   (r_I60_inq_banking_recency_d = NULL) => -0.0071640592, -0.0071640592),
(f_hh_age_65_plus_d > 0.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 250.95) => 0.0184279048,
   (c_housingcpi > 250.95) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 0.5) => 0.0274127307,
      (r_P88_Phn_Dst_to_Inp_Add_i > 0.5) => 0.1803403118,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.1728609007, 0.0945630672),
   (c_housingcpi = NULL) => 0.0609147289, 0.0263819096),
(f_hh_age_65_plus_d = NULL) => -0.0047580720, 0.0000282345);

// Tree: 96 
wFDN_FLAPSD_lgt_96 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 1.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 54.35) => 0.0503529260,
         (C_RENTOCC_P > 54.35) => -0.0140814847,
         (C_RENTOCC_P = NULL) => 0.0029629176, 0.0210812912),
      (r_Ever_Asset_Owner_d > 0.5) => -0.0176930990,
      (r_Ever_Asset_Owner_d = NULL) => -0.0086950792, -0.0086950792),
   (r_I60_inq_hiRiskCred_count12_i > 1.5) => -0.0832044712,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0094791280, -0.0094791280),
(f_hh_collections_ct_i > 1.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 9.5) => 0.0163323497,
   (r_L79_adls_per_addr_curr_i > 9.5) => 0.1049715937,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0186814021, 0.0186814021),
(f_hh_collections_ct_i = NULL) => -0.0043860916, -0.0015606704);

// Tree: 97 
wFDN_FLAPSD_lgt_97 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => -0.0158246311,
(r_L79_adls_per_addr_curr_i > 2.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 238) => 
      map(
      (NULL < c_unempl and c_unempl <= 144.5) => 
         map(
         (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 2.5) => 0.2247126153,
         (f_hh_tot_derog_i > 2.5) => 
            map(
            (NULL < c_ab_av_edu and c_ab_av_edu <= 106.5) => -0.0592352972,
            (c_ab_av_edu > 106.5) => 0.1697871082,
            (c_ab_av_edu = NULL) => 0.0582631543, 0.0582631543),
         (f_hh_tot_derog_i = NULL) => 0.1326852691, 0.1326852691),
      (c_unempl > 144.5) => -0.0410599527,
      (c_unempl = NULL) => 0.0984728895, 0.0984728895),
   (f_mos_liens_unrel_SC_fseen_d > 238) => 0.0132479699,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0167658734, 0.0167658734),
(r_L79_adls_per_addr_curr_i = NULL) => 0.0004924595, 0.0004924595);

// Tree: 98 
wFDN_FLAPSD_lgt_98 := map(
(NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 4.5) => 
   map(
   (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => -0.0156911200,
   (f_util_add_input_misc_n > 0.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 184.5) => 
         map(
         (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 0.0072352935,
         (r_P85_Phn_Disconnected_i > 0.5) => 0.1348095506,
         (r_P85_Phn_Disconnected_i = NULL) => 0.0092391956, 0.0092391956),
      (c_unempl > 184.5) => 0.1181881699,
      (c_unempl = NULL) => -0.0450084182, 0.0100771023),
   (f_util_add_input_misc_n = NULL) => -0.0034213326, -0.0034213326),
(nf_vf_lexid_hi_summary > 4.5) => -0.0637160065,
(nf_vf_lexid_hi_summary = NULL) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 31.9) => 0.0717930801,
   (c_high_ed > 31.9) => -0.0552663172,
   (c_high_ed = NULL) => 0.0133232689, 0.0133232689), -0.0042949058);

// Tree: 99 
wFDN_FLAPSD_lgt_99 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 50.1) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 53.5) => -0.0662086461,
   (f_mos_inq_banko_am_lseen_d > 53.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < c_rental and c_rental <= 112.5) => -0.0039576385,
         (c_rental > 112.5) => 0.0390727193,
         (c_rental = NULL) => 0.0158247362, 0.0158247362),
      (f_phone_ver_experian_d > 0.5) => -0.0074798665,
      (f_phone_ver_experian_d = NULL) => -0.0069346605, 0.0001906441),
   (f_mos_inq_banko_am_lseen_d = NULL) => 0.0057867769, -0.0024252024),
(c_hval_500k_p > 50.1) => 
   map(
   (NULL < c_med_yearblt and c_med_yearblt <= 1955.5) => 0.2074559223,
   (c_med_yearblt > 1955.5) => 0.0073389617,
   (c_med_yearblt = NULL) => 0.1045386283, 0.1045386283),
(c_hval_500k_p = NULL) => 0.0070618740, -0.0013206761);

// Tree: 100 
wFDN_FLAPSD_lgt_100 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 58.05) => 
   map(
   (NULL < r_L70_Add_Invalid_i and r_L70_Add_Invalid_i <= 0.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 0.0176043234,
      (f_corraddrnamecount_d > 4.5) => 
         map(
         (NULL < nf_vf_hi_addr_add_entries and nf_vf_hi_addr_add_entries <= 1.5) => -0.0073893903,
         (nf_vf_hi_addr_add_entries > 1.5) => -0.1115583887,
         (nf_vf_hi_addr_add_entries = NULL) => -0.0080247950, -0.0080247950),
      (f_corraddrnamecount_d = NULL) => -0.0186903093, -0.0011532904),
   (r_L70_Add_Invalid_i > 0.5) => -0.0628764139,
   (r_L70_Add_Invalid_i = NULL) => -0.0021044044, -0.0021044044),
(c_rnt1000_p > 58.05) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.1190634430,
   (r_F01_inp_addr_address_score_d > 95) => 0.0353519673,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0431650383, 0.0431650383),
(c_rnt1000_p = NULL) => -0.0128472048, -0.0001731313);

// Tree: 101 
wFDN_FLAPSD_lgt_101 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 2.5) => -0.0397551555,
(f_addrs_per_ssn_i > 2.5) => 
   map(
   (NULL < r_C15_ssns_per_adl_c6_i and r_C15_ssns_per_adl_c6_i <= 0.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0102357863,
      (f_crim_rel_under25miles_cnt_i > 0.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => -0.0232062782,
         (f_mos_inq_banko_cm_fseen_d > 41.5) => 
            map(
            (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.1203581076,
            (k_estimated_income_d > 26500) => 0.0211635275,
            (k_estimated_income_d = NULL) => 0.0240048425, 0.0240048425),
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0152985535, 0.0152985535),
      (f_crim_rel_under25miles_cnt_i = NULL) => -0.0261487014, 0.0006273326),
   (r_C15_ssns_per_adl_c6_i > 0.5) => 0.0906776008,
   (r_C15_ssns_per_adl_c6_i = NULL) => 0.0103563241, 0.0013751715),
(f_addrs_per_ssn_i = NULL) => -0.0028659375, -0.0028659375);

// Tree: 102 
wFDN_FLAPSD_lgt_102 := map(
(NULL < c_cpiall and c_cpiall <= 208.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1317665067,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < c_unemp and c_unemp <= 11.25) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.55) => -0.0038184650,
         (r_C12_source_profile_d > 75.55) => 
            map(
            (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 0.0356838836,
            (f_inq_count_i > 3.5) => 0.2686517447,
            (f_inq_count_i = NULL) => 0.1027373639, 0.1027373639),
         (r_C12_source_profile_d = NULL) => 0.0148961362, 0.0148961362),
      (c_unemp > 11.25) => 0.1631214861,
      (c_unemp = NULL) => 0.0198184066, 0.0198184066),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0245221083, 0.0245221083),
(c_cpiall > 208.5) => -0.0045728481,
(c_cpiall = NULL) => -0.0356049179, -0.0014116823);

// Tree: 103 
wFDN_FLAPSD_lgt_103 := map(
(NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 4.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 122.25) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -107298) => 0.0568170222,
      (f_addrchangevaluediff_d > -107298) => -0.0163615304,
      (f_addrchangevaluediff_d = NULL) => 0.0324483155, -0.0081708429),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 122.25) => 0.0411849413,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0095828828, -0.0050497285),
(f_inq_Other_count_i > 4.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 317.5) => 0.1041044751,
   (r_C21_M_Bureau_ADL_FS_d > 317.5) => -0.0889273942,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0551668181, 0.0551668181),
(f_inq_Other_count_i = NULL) => 
   map(
   (NULL < c_totsales and c_totsales <= 4840) => -0.0742510910,
   (c_totsales > 4840) => 0.0433373633,
   (c_totsales = NULL) => -0.0089241720, -0.0089241720), -0.0040758663);

// Tree: 104 
wFDN_FLAPSD_lgt_104 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 62.5) => -0.0051974336,
(f_addrchangecrimediff_i > 62.5) => 0.0475211214,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 77.5) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => 
         map(
         (NULL < c_retail and c_retail <= 1.05) => 
            map(
            (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 41069) => 0.1951826700,
            (f_curraddrmedianincome_d > 41069) => 0.0413925695,
            (f_curraddrmedianincome_d = NULL) => 0.0941764599, 0.0941764599),
         (c_retail > 1.05) => 0.0003917779,
         (c_retail = NULL) => 0.0304477731, 0.0304477731),
      (f_bus_addr_match_count_d > 6.5) => 0.1986587609,
      (f_bus_addr_match_count_d = NULL) => 0.0449592921, 0.0449592921),
   (c_new_homes > 77.5) => -0.0082954379,
   (c_new_homes = NULL) => 0.0040437957, 0.0080132191), -0.0014271218);

// Tree: 105 
wFDN_FLAPSD_lgt_105 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 57.5) => -0.0065403345,
(k_comb_age_d > 57.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 30.05) => 0.0135914264,
      (C_INC_75K_P > 30.05) => 0.1630123384,
      (C_INC_75K_P = NULL) => -0.0785760260, 0.0150204863),
   (f_hh_payday_loan_users_i > 0.5) => 
      map(
      (NULL < r_C20_email_domain_ISP_count_i and r_C20_email_domain_ISP_count_i <= 1.5) => 
         map(
         (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.1009592555,
         (f_rel_criminal_count_i > 2.5) => 0.2372022655,
         (f_rel_criminal_count_i = NULL) => 0.1448597809, 0.1448597809),
      (r_C20_email_domain_ISP_count_i > 1.5) => -0.0805079843,
      (r_C20_email_domain_ISP_count_i = NULL) => 0.0850683330, 0.0850683330),
   (f_hh_payday_loan_users_i = NULL) => 0.0218496635, 0.0218496635),
(k_comb_age_d = NULL) => -0.0009003822, -0.0009003822);

// Tree: 106 
wFDN_FLAPSD_lgt_106 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0033401326,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32939559275) => 0.0737541557,
      (f_add_input_mobility_index_i > 0.32939559275) => 0.0136898944,
      (f_add_input_mobility_index_i = NULL) => 0.0491824124, 0.0491824124),
   (k_nap_contradictory_i = NULL) => -0.0024956508, -0.0024956508),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 84) => -0.0403491232,
   (c_ab_av_edu > 84) => 0.1478002253,
   (c_ab_av_edu = NULL) => 0.0635542484, 0.0635542484),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 11.05) => -0.0593851429,
   (c_blue_col > 11.05) => 0.0418203922,
   (c_blue_col = NULL) => -0.0078452870, -0.0078452870), -0.0018395273);

// Tree: 107 
wFDN_FLAPSD_lgt_107 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => -0.0076967080,
      (f_addrs_per_ssn_c6_i > 1.5) => 0.1273327778,
      (f_addrs_per_ssn_c6_i = NULL) => -0.0059526818, -0.0059526818),
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 0.0174868145,
      (f_phones_per_addr_curr_i > 9.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 155.5) => 0.0992163313,
         (c_relig_indx > 155.5) => -0.0349149383,
         (c_relig_indx = NULL) => 0.0704125010, 0.0704125010),
      (f_phones_per_addr_curr_i = NULL) => 0.0234202727, 0.0234202727),
   (f_inq_Other_count_i = NULL) => 0.0006073802, 0.0006073802),
(r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.0583792622,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0127391701, 0.0002833874);

// Tree: 108 
wFDN_FLAPSD_lgt_108 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 3.75) => -0.0898404829,
(c_pop_35_44_p > 3.75) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 82) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 66) => 0.0040497166,
      (f_phones_per_addr_curr_i > 66) => 0.1037773436,
      (f_phones_per_addr_curr_i = NULL) => 0.0048197337, 0.0048197337),
   (f_addrchangecrimediff_i > 82) => 0.0797796990,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 32.95) => 
         map(
         (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => -0.0338552258,
         (f_util_add_input_conv_n > 0.5) => 0.0234205336,
         (f_util_add_input_conv_n = NULL) => -0.0037127511, -0.0037127511),
      (c_hval_750k_p > 32.95) => 0.0796591367,
      (c_hval_750k_p = NULL) => 0.0046045557, 0.0046045557), 0.0053714865),
(c_pop_35_44_p = NULL) => 0.0230543751, 0.0042539846);

// Tree: 109 
wFDN_FLAPSD_lgt_109 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 360.5) => -0.0110656716,
   (r_pb_order_freq_d > 360.5) => 0.0444564440,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21939) => 0.1324917655,
      (r_A46_Curr_AVM_AutoVal_d > 21939) => 0.0087435864,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0085653411, 0.0099613724), -0.0001287453),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 14.55) => 0.0126154125,
   (c_blue_col > 14.55) => -0.1532060059,
   (c_blue_col = NULL) => -0.0547495387, -0.0547495387),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 151.5) => 0.0781985822,
   (c_asian_lang > 151.5) => -0.0374469534,
   (c_asian_lang = NULL) => 0.0251943784, 0.0251943784), -0.0004363559);

// Tree: 110 
wFDN_FLAPSD_lgt_110 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
      map(
      (NULL < c_construction and c_construction <= 2.15) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 158.5) => 0.0147265908,
         (c_easiqlife > 158.5) => 0.1442672831,
         (c_easiqlife = NULL) => 0.0201421059, 0.0201421059),
      (c_construction > 2.15) => -0.0082835003,
      (c_construction = NULL) => -0.0125209773, -0.0008216718),
   (r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0673288468,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 68.45) => -0.0722531019,
      (C_OWNOCC_P > 68.45) => 0.0364112925,
      (C_OWNOCC_P = NULL) => -0.0168760547, -0.0168760547), -0.0014998464),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1126549518,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0010408874, -0.0010408874);

// Tree: 111 
wFDN_FLAPSD_lgt_111 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 111693.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0613891068,
   (r_F00_dob_score_d > 92) => -0.0043136064,
   (r_F00_dob_score_d = NULL) => 0.0128311175, -0.0019302581),
(f_addrchangevaluediff_d > 111693.5) => 
   map(
   (NULL < c_construction and c_construction <= 3.75) => 0.1496037505,
   (c_construction > 3.75) => -0.0050619650,
   (c_construction = NULL) => 0.0585765325, 0.0585765325),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => -0.0152272539,
   (f_bus_addr_match_count_d > 6.5) => 
      map(
      (NULL < c_rnt1500_p and c_rnt1500_p <= 10.35) => 0.0304430010,
      (c_rnt1500_p > 10.35) => 0.2297391461,
      (c_rnt1500_p = NULL) => 0.0765025545, 0.0765025545),
   (f_bus_addr_match_count_d = NULL) => -0.0078220650, -0.0078220650), -0.0023665014);

// Tree: 112 
wFDN_FLAPSD_lgt_112 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 9) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 0.45) => -0.0614506680,
         (C_INC_150K_P > 0.45) => 
            map(
            (NULL < C_RENTOCC_P and C_RENTOCC_P <= 78.2) => 0.0245707758,
            (C_RENTOCC_P > 78.2) => 0.1378447498,
            (C_RENTOCC_P = NULL) => 0.0282276877, 0.0282276877),
         (C_INC_150K_P = NULL) => 0.0237777390, 0.0237777390),
      (f_corrrisktype_i > 8.5) => 0.1152884299,
      (f_corrrisktype_i = NULL) => 0.0262853392, 0.0262853392),
   (r_I60_inq_recency_d > 9) => -0.0048382267,
   (r_I60_inq_recency_d = NULL) => 0.0022111940, 0.0022111940),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0594410829,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0038923491, -0.0002454878);

// Tree: 113 
wFDN_FLAPSD_lgt_113 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_mos_liens_unrel_ST_lseen_d and f_mos_liens_unrel_ST_lseen_d <= 116.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 20.5) => -0.0377449122,
      (f_rel_count_i > 20.5) => -0.1392412674,
      (f_rel_count_i = NULL) => -0.0591125659, -0.0591125659),
   (f_mos_liens_unrel_ST_lseen_d > 116.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => -0.0054688653,
      (f_inq_PrepaidCards_count24_i > 1.5) => 0.0856929136,
      (f_inq_PrepaidCards_count24_i = NULL) => -0.0050530084, -0.0050530084),
   (f_mos_liens_unrel_ST_lseen_d = NULL) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 10.85) => -0.0869150285,
      (c_pop_55_64_p > 10.85) => 0.0542947073,
      (c_pop_55_64_p = NULL) => -0.0203066625, -0.0203066625), -0.0062427981),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1019504136,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0057992784, -0.0057992784);

// Tree: 114 
wFDN_FLAPSD_lgt_114 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 15.85) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 14.5) => 0.1470260375,
      (r_C13_max_lres_d > 14.5) => 0.0171022481,
      (r_C13_max_lres_d = NULL) => 0.0149038052, 0.0184371100),
   (r_Phn_Cell_n > 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 179.5) => -0.0211104924,
         (f_curraddrcrimeindex_i > 179.5) => 0.0768208774,
         (f_curraddrcrimeindex_i = NULL) => -0.0165146402, -0.0165146402),
      (k_inq_per_phone_i > 4.5) => 0.0771100414,
      (k_inq_per_phone_i = NULL) => -0.0147720488, -0.0147720488),
   (r_Phn_Cell_n = NULL) => 0.0024733038, 0.0024733038),
(C_INC_25K_P > 15.85) => -0.0306043401,
(C_INC_25K_P = NULL) => 0.0083885936, -0.0008718917);

// Tree: 115 
wFDN_FLAPSD_lgt_115 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 24.65) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0003237951,
      (f_nae_nothing_found_i > 0.5) => 0.0973056742,
      (f_nae_nothing_found_i = NULL) => 0.0009599024, 0.0009599024),
   (C_INC_15K_P > 24.65) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 280.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 25.05) => -0.1152357143,
         (c_fammar_p > 25.05) => -0.0408918303,
         (c_fammar_p = NULL) => -0.0497796364, -0.0497796364),
      (f_M_Bureau_ADL_FS_noTU_d > 280.5) => 0.0286853115,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0306011688, -0.0306011688),
   (C_INC_15K_P = NULL) => 0.0020185111, -0.0013875903),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0840174997,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0010509256, -0.0010509256);

// Tree: 116 
wFDN_FLAPSD_lgt_116 := map(
(NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => -0.0046841391,
   (f_util_adl_count_n > 3.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 13.85) => 
         map(
         (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 72) => 0.1194135070,
         (f_mos_liens_unrel_CJ_lseen_d > 72) => 
            map(
            (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 0.0103710983,
            (k_comb_age_d > 73.5) => 0.1483074681,
            (k_comb_age_d = NULL) => 0.0138264182, 0.0138264182),
         (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0176501901, 0.0176501901),
      (c_hval_20k_p > 13.85) => 0.1803424462,
      (c_hval_20k_p = NULL) => 0.0234092080, 0.0234092080),
   (f_util_adl_count_n = NULL) => 0.0059581510, 0.0003021624),
(k_inq_addrs_per_ssn_i > 2.5) => 0.0927590952,
(k_inq_addrs_per_ssn_i = NULL) => 0.0008998343, 0.0008998343);

// Tree: 117 
wFDN_FLAPSD_lgt_117 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 121.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 4.5) => 0.1048315142,
   (r_D32_Mos_Since_Crim_LS_d > 4.5) => -0.0114852786,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0104060506, -0.0104060506),
(r_C13_Curr_Addr_LRes_d > 121.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 1.85) => -0.0112863468,
      (c_high_hval > 1.85) => 0.0994326838,
      (c_high_hval = NULL) => 0.0118821911, 0.0468663485),
   (f_corrphonelastnamecount_d > 0.5) => -0.0002612987,
   (f_corrphonelastnamecount_d = NULL) => 0.0161346587, 0.0161346587),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 15.75) => 0.0903067807,
   (c_hh3_p > 15.75) => -0.0158344710,
   (c_hh3_p = NULL) => 0.0343413934, 0.0343413934), -0.0019702871);

// Tree: 118 
wFDN_FLAPSD_lgt_118 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0028981667,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 749.5) => -0.0162218019,
   (c_med_rent > 749.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => 0.0270033758,
      (f_rel_criminal_count_i > 0.5) => 
         map(
         (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 0.5) => 
            map(
            (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => 0.1150188974,
            (r_C14_Addr_Stability_v2_d > 4.5) => 0.2642320605,
            (r_C14_Addr_Stability_v2_d = NULL) => 0.1890471333, 0.1890471333),
         (r_C20_email_domain_free_count_i > 0.5) => 0.0585211482,
         (r_C20_email_domain_free_count_i = NULL) => 0.1248119044, 0.1248119044),
      (f_rel_criminal_count_i = NULL) => 0.0786527859, 0.0786527859),
   (c_med_rent = NULL) => 0.0351397347, 0.0313846656),
(r_L70_Add_Standardized_i = NULL) => 0.0000206712, 0.0000206712);

// Tree: 119 
wFDN_FLAPSD_lgt_119 := map(
(NULL < c_rape and c_rape <= 122.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 16.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 101) => -0.0001659690,
      (f_fp_prevaddrburglaryindex_i > 101) => 
         map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => -0.0078339487,
         (f_sourcerisktype_i > 3.5) => 
            map(
            (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.65) => 0.0130806317,
            (c_pop_35_44_p > 13.65) => 0.0965598255,
            (c_pop_35_44_p = NULL) => 0.0587386397, 0.0587386397),
         (f_sourcerisktype_i = NULL) => 0.0322568768, 0.0322568768),
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0086523225, 0.0086523225),
   (f_inq_HighRiskCredit_count_i > 16.5) => 0.1173541731,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0172790546, 0.0094048397),
(c_rape > 122.5) => -0.0221010218,
(c_rape = NULL) => 0.0292172686, 0.0015966591);

// Tree: 120 
wFDN_FLAPSD_lgt_120 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 197.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1991.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 278) => 0.0015607940,
      (f_liens_unrel_SC_total_amt_i > 278) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 86.5) => 0.1588891995,
         (c_born_usa > 86.5) => -0.0050104154,
         (c_born_usa = NULL) => 0.0592497861, 0.0592497861),
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0026288484, 0.0026288484),
   (f_liens_unrel_SC_total_amt_i > 1991.5) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 0.5) => -0.0276264878,
      (f_inq_Collection_count24_i > 0.5) => -0.1368233566,
      (f_inq_Collection_count24_i = NULL) => -0.0625694858, -0.0625694858),
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0015869254, 0.0015869254),
(f_curraddrcrimeindex_i > 197.5) => 0.1226514392,
(f_curraddrcrimeindex_i = NULL) => 0.0028311714, 0.0022553622);

// Tree: 121 
wFDN_FLAPSD_lgt_121 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.3) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 25.5) => 
      map(
      (NULL < f_vf_LexID_phn_hi_risk_ct_i and f_vf_LexID_phn_hi_risk_ct_i <= 0.5) => -0.0027086714,
      (f_vf_LexID_phn_hi_risk_ct_i > 0.5) => 
         map(
         (NULL < C_INC_15K_P and C_INC_15K_P <= 12.75) => -0.0175218777,
         (C_INC_15K_P > 12.75) => -0.1370762764,
         (C_INC_15K_P = NULL) => -0.0582638795, -0.0582638795),
      (f_vf_LexID_phn_hi_risk_ct_i = NULL) => -0.0035245203, -0.0035245203),
   (f_srchssnsrchcount_i > 25.5) => 0.0891858046,
   (f_srchssnsrchcount_i = NULL) => 
      map(
      (NULL < c_larceny and c_larceny <= 86.5) => -0.0419969877,
      (c_larceny > 86.5) => 0.0571241004,
      (c_larceny = NULL) => 0.0038924050, 0.0038924050), -0.0030468571),
(c_pop_0_5_p > 21.3) => 0.1545576573,
(c_pop_0_5_p = NULL) => 0.0253283355, -0.0017925878);

// Tree: 122 
wFDN_FLAPSD_lgt_122 := map(
(NULL < c_unemp and c_unemp <= 14.45) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 76.35) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => -0.0030339289,
      (f_srchfraudsrchcount_i > 8.5) => -0.0385397851,
      (f_srchfraudsrchcount_i = NULL) => -0.0041457389, -0.0041457389),
   (r_C12_source_profile_d > 76.35) => 0.0363046206,
   (r_C12_source_profile_d = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 135) => 0.0552833059,
      (c_asian_lang > 135) => -0.0572868226,
      (c_asian_lang = NULL) => 0.0003710481, 0.0003710481), 0.0019734762),
(c_unemp > 14.45) => 0.0866105536,
(c_unemp = NULL) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 24) => 0.1451174431,
   (f_mos_inq_banko_cm_lseen_d > 24) => -0.0514815976,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0169905378, -0.0169905378), 0.0020648456);

// Tree: 123 
wFDN_FLAPSD_lgt_123 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 0.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < c_child and c_child <= 29.65) => -0.0075230917,
      (c_child > 29.65) => 0.1081268114,
      (c_child = NULL) => 0.0242012949, 0.0141504735),
   (f_rel_felony_count_i > 0.5) => 0.1523675450,
   (f_rel_felony_count_i = NULL) => 0.0344137787, 0.0344137787),
(f_prevaddrlenofres_d > 0.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 115.5) => -0.0188877448,
   (c_sub_bus > 115.5) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 0.0644415367,
      (f_corrssnaddrcount_d > 1.5) => 0.0079958120,
      (f_corrssnaddrcount_d = NULL) => 0.0104949965, 0.0104949965),
   (c_sub_bus = NULL) => 0.0000868787, -0.0045755463),
(f_prevaddrlenofres_d = NULL) => 0.0220163227, -0.0023762812);

// Tree: 124 
wFDN_FLAPSD_lgt_124 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.35) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 3.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.28110323465) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1777086037) => 0.0104199975,
         (f_add_curr_nhood_BUS_pct_i > 0.1777086037) => 
            map(
            (NULL < c_old_homes and c_old_homes <= 29) => -0.0943146211,
            (c_old_homes > 29) => 0.1431688632,
            (c_old_homes = NULL) => 0.0995025451, 0.0995025451),
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0080057957, 0.0133224433),
      (f_add_input_mobility_index_i > 0.28110323465) => -0.0150259839,
      (f_add_input_mobility_index_i = NULL) => 0.0017810032, 0.0017810032),
   (f_inq_Auto_count24_i > 3.5) => -0.0893383853,
   (f_inq_Auto_count24_i = NULL) => -0.0091163690, 0.0004187590),
(c_pop_0_5_p > 19.35) => 0.1158097045,
(c_pop_0_5_p = NULL) => -0.0283378267, 0.0006138663);

// Tree: 125 
wFDN_FLAPSD_lgt_125 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 2.5) => -0.0402880997,
(f_addrs_per_ssn_i > 2.5) => 
   map(
   (NULL < r_C15_ssns_per_adl_c6_i and r_C15_ssns_per_adl_c6_i <= 0.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 33.85) => -0.0179943716,
      (c_med_age > 33.85) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.18364809175) => 0.0065066603,
         (f_add_curr_nhood_BUS_pct_i > 0.18364809175) => 
            map(
            (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 2.5) => -0.0268734030,
            (f_phones_per_addr_curr_i > 2.5) => 0.1361164732,
            (f_phones_per_addr_curr_i = NULL) => 0.0698710909, 0.0698710909),
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0089056107, 0.0100025107),
      (c_med_age = NULL) => 0.0409121518, 0.0022213714),
   (r_C15_ssns_per_adl_c6_i > 0.5) => 0.0940020244,
   (r_C15_ssns_per_adl_c6_i = NULL) => -0.0022648221, 0.0027730054),
(f_addrs_per_ssn_i = NULL) => -0.0018437154, -0.0018437154);

// Tree: 126 
wFDN_FLAPSD_lgt_126 := map(
(NULL < nf_max_altlexid_hi_no_hi_lexid and nf_max_altlexid_hi_no_hi_lexid <= 1.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5271.5) => -0.0006036314,
   (f_liens_unrel_SC_total_amt_i > 5271.5) => 0.1261872925,
   (f_liens_unrel_SC_total_amt_i = NULL) => -0.0000697316, -0.0000697316),
(nf_max_altlexid_hi_no_hi_lexid > 1.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 55.55) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 2.3) => -0.0725045326,
      (c_hval_125k_p > 2.3) => 0.0813322989,
      (c_hval_125k_p = NULL) => 0.0073164648, 0.0073164648),
   (r_C12_source_profile_d > 55.55) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.30390227855) => -0.1480580840,
      (f_add_input_mobility_index_i > 0.30390227855) => -0.0207237102,
      (f_add_input_mobility_index_i = NULL) => -0.0942256658, -0.0942256658),
   (r_C12_source_profile_d = NULL) => -0.0469865007, -0.0469865007),
(nf_max_altlexid_hi_no_hi_lexid = NULL) => 0.0045509004, -0.0008817986);

// Tree: 127 
wFDN_FLAPSD_lgt_127 := map(
(NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 36.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0009324759,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 0.5) => 0.1758444798,
      (f_rel_under100miles_cnt_d > 0.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','6: Other']) => -0.0055847934,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0866831807,
         (nf_seg_FraudPoint_3_0 = '') => 0.0311148405, 0.0311148405),
      (f_rel_under100miles_cnt_d = NULL) => 0.0388206780, 0.0388206780),
   (r_L70_Add_Standardized_i = NULL) => 0.0024404201, 0.0024404201),
(f_rel_ageover20_count_d > 36.5) => -0.0635344787,
(f_rel_ageover20_count_d = NULL) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 18.85) => 0.0603110888,
   (c_fammar18_p > 18.85) => -0.0529002122,
   (c_fammar18_p = NULL) => -0.0340316621, -0.0340316621), 0.0005740230);

// Tree: 128 
wFDN_FLAPSD_lgt_128 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 3.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 4.5) => 0.0021421840,
   (r_C14_addrs_15yr_i > 4.5) => -0.0280703646,
   (r_C14_addrs_15yr_i = NULL) => -0.0142121237, -0.0048986852),
(k_inq_per_phone_i > 3.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 16.5) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 2.5) => 0.1703906422,
      (r_C14_addrs_5yr_i > 2.5) => 0.0229952233,
      (r_C14_addrs_5yr_i = NULL) => 0.1044505863, 0.1044505863),
   (r_C13_Curr_Addr_LRes_d > 16.5) => 
      map(
      (NULL < c_finance and c_finance <= 0.75) => 0.0880083812,
      (c_finance > 0.75) => -0.0476002047,
      (c_finance = NULL) => 0.0006044098, 0.0006044098),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0323429195, 0.0323429195),
(k_inq_per_phone_i = NULL) => -0.0038006671, -0.0038006671);

// Tree: 129 
wFDN_FLAPSD_lgt_129 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 5.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 11.55) => 0.0120340398,
      (C_INC_35K_P > 11.55) => 0.1453186491,
      (C_INC_35K_P = NULL) => 0.0542950135, 0.0542950135),
   (f_M_Bureau_ADL_FS_noTU_d > 8.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 24.95) => -0.0065571766,
      (c_hval_750k_p > 24.95) => 
         map(
         (NULL < f_inq_count24_i and f_inq_count24_i <= 5.5) => 0.0218509183,
         (f_inq_count24_i > 5.5) => 0.1210998478,
         (f_inq_count24_i = NULL) => 0.0292551171, 0.0292551171),
      (c_hval_750k_p = NULL) => 0.0190781520, -0.0005874779),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0014069875, 0.0006764154),
(k_inq_adls_per_addr_i > 5.5) => -0.0804374246,
(k_inq_adls_per_addr_i = NULL) => 0.0001776468, 0.0001776468);

// Tree: 130 
wFDN_FLAPSD_lgt_130 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 13) => 0.1381972492,
      (f_mos_inq_banko_om_lseen_d > 13) => -0.0045355360,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0109452433, 0.0109452433),
   (f_srchphonesrchcount_i > 1.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 11.35) => 0.0113832796,
      (c_vacant_p > 11.35) => 0.1791812360,
      (c_vacant_p = NULL) => 0.0976793715, 0.0976793715),
   (f_srchphonesrchcount_i = NULL) => 0.0275312433, 0.0275312433),
(k_estimated_income_d > 27500) => 
   map(
   (NULL < r_L70_inp_addr_dirty_i and r_L70_inp_addr_dirty_i <= 0.5) => -0.0031811385,
   (r_L70_inp_addr_dirty_i > 0.5) => -0.0588739337,
   (r_L70_inp_addr_dirty_i = NULL) => -0.0042062162, -0.0042062162),
(k_estimated_income_d = NULL) => 0.0239586376, -0.0025491806);

// Tree: 131 
wFDN_FLAPSD_lgt_131 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 140) => -0.0063869384,
(f_curraddrcrimeindex_i > 140) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 13.95) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 25.15) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 32.2) => 0.0380491632,
         (c_famotf18_p > 32.2) => 0.1351280051,
         (c_famotf18_p = NULL) => 0.0513818796, 0.0513818796),
      (c_hh1_p > 25.15) => -0.0015731224,
      (c_hh1_p = NULL) => 0.0152368442, 0.0152368442),
   (c_femdiv_p > 13.95) => 0.2046347709,
   (c_femdiv_p = NULL) => 0.0194419491, 0.0194419491),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0902490903,
   (k_comb_age_d > 26.5) => 0.0631437767,
   (k_comb_age_d = NULL) => -0.0068248995, -0.0068248995), -0.0017850452);

// Tree: 132 
wFDN_FLAPSD_lgt_132 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => -0.0077070728,
   (f_hh_criminals_i > 3.5) => -0.1286895555,
   (f_hh_criminals_i = NULL) => -0.0084620019, -0.0084620019),
(r_D32_criminal_count_i > 2.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.01019172205) => 0.1419873900,
   (f_add_curr_nhood_MFD_pct_i > 0.01019172205) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 209.3) => 0.1279565837,
      (c_cpiall > 209.3) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 28.95) => -0.0432318212,
         (c_rnt1000_p > 28.95) => 0.0820624859,
         (c_rnt1000_p = NULL) => -0.0107372696, -0.0107372696),
      (c_cpiall = NULL) => 0.0068117486, 0.0068117486),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0250273762, 0.0265587622),
(r_D32_criminal_count_i = NULL) => -0.0254686499, -0.0066327440);

// Tree: 133 
wFDN_FLAPSD_lgt_133 := map(
(NULL < c_easiqlife and c_easiqlife <= 136.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 7.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 446.5) => -0.0110652471,
      (f_M_Bureau_ADL_FS_all_d > 446.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.23396014975) => 0.1389962605,
         (f_add_curr_mobility_index_i > 0.23396014975) => 0.0167671537,
         (f_add_curr_mobility_index_i = NULL) => 0.0880025886, 0.0880025886),
      (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0070743329, -0.0070743329),
   (f_srchfraudsrchcount_i > 7.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 0.5) => 0.0353870947,
      (c_rnt1000_p > 0.5) => -0.0940588066,
      (c_rnt1000_p = NULL) => -0.0532884440, -0.0532884440),
   (f_srchfraudsrchcount_i = NULL) => -0.0227135427, -0.0086458369),
(c_easiqlife > 136.5) => 0.0146020931,
(c_easiqlife = NULL) => 0.0358470167, 0.0000484707);

// Tree: 134 
wFDN_FLAPSD_lgt_134 := map(
(NULL < c_unempl and c_unempl <= 184.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 36.5) => -0.0145272249,
   (k_comb_age_d > 36.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 4.5) => -0.0007917886,
      (f_corrrisktype_i > 4.5) => 0.0331716125,
      (f_corrrisktype_i = NULL) => 0.0089468039, 0.0089468039),
   (k_comb_age_d = NULL) => -0.0007206753, -0.0007206753),
(c_unempl > 184.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 96) => -0.0619428803,
   (f_fp_prevaddrburglaryindex_i > 96) => 
      map(
      (NULL < c_murders and c_murders <= 166.5) => 0.1999730592,
      (c_murders > 166.5) => 0.0207196466,
      (c_murders = NULL) => 0.1163886028, 0.1163886028),
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0737109829, 0.0737109829),
(c_unempl = NULL) => -0.0058657460, 0.0005489086);

// Tree: 135 
wFDN_FLAPSD_lgt_135 := map(
(NULL < c_hh6_p and c_hh6_p <= 5.45) => -0.0066223694,
(c_hh6_p > 5.45) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 3.5) => 
      map(
      (NULL < r_D31_bk_disposed_hist_count_i and r_D31_bk_disposed_hist_count_i <= 0.5) => 0.0100329443,
      (r_D31_bk_disposed_hist_count_i > 0.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => -0.0268086626,
         (f_corrphonelastnamecount_d > 0.5) => 0.2234337705,
         (f_corrphonelastnamecount_d = NULL) => 0.1206209879, 0.1206209879),
      (r_D31_bk_disposed_hist_count_i = NULL) => 0.0193387875, 0.0193387875),
   (r_E57_br_source_count_d > 3.5) => 0.1450983683,
   (r_E57_br_source_count_d = NULL) => 0.0254277057, 0.0254277057),
(c_hh6_p = NULL) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.0963264905,
   (k_estimated_income_d > 28500) => -0.0581978557,
   (k_estimated_income_d = NULL) => 0.0110538580, 0.0110538580), -0.0020921355);

// Tree: 136 
wFDN_FLAPSD_lgt_136 := map(
(NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 1.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 139272) => 
      map(
      (NULL < k_inq_lnames_per_addr_i and k_inq_lnames_per_addr_i <= 2.5) => 0.0256711066,
      (k_inq_lnames_per_addr_i > 2.5) => 0.1171053698,
      (k_inq_lnames_per_addr_i = NULL) => 0.0292683709, 0.0292683709),
   (r_L80_Inp_AVM_AutoVal_d > 139272) => 
      map(
      (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.35) => -0.0150374243,
      (c_hval_1000k_p > 41.35) => 0.1790562306,
      (c_hval_1000k_p = NULL) => -0.0114259699, -0.0114259699),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0090333153,
      (f_assocrisktype_i > 3.5) => 0.0335912096,
      (f_assocrisktype_i = NULL) => 0.0002164557, 0.0002164557), 0.0008147808),
(r_D31_MostRec_Bk_i > 1.5) => -0.0348082096,
(r_D31_MostRec_Bk_i = NULL) => 0.0194267030, -0.0023689854);

// Tree: 137 
wFDN_FLAPSD_lgt_137 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0877022936,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_mos_liens_unrel_ST_lseen_d and f_mos_liens_unrel_ST_lseen_d <= 28) => -0.1374566230,
   (f_mos_liens_unrel_ST_lseen_d > 28) => 
      map(
      (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
         map(
         (NULL < f_liens_rel_CJ_total_amt_i and f_liens_rel_CJ_total_amt_i <= 1692) => -0.0031356000,
         (f_liens_rel_CJ_total_amt_i > 1692) => -0.0787830900,
         (f_liens_rel_CJ_total_amt_i = NULL) => -0.0042040151, -0.0042040151),
      (f_srchaddrsrchcountmo_i > 1.5) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 111) => 0.1293361102,
         (c_asian_lang > 111) => -0.0109973604,
         (c_asian_lang = NULL) => 0.0497086915, 0.0497086915),
      (f_srchaddrsrchcountmo_i = NULL) => -0.0034275125, -0.0034275125),
   (f_mos_liens_unrel_ST_lseen_d = NULL) => -0.0042101799, -0.0042101799),
(r_C10_M_Hdr_FS_d = NULL) => -0.0115946970, -0.0037615133);

// Tree: 138 
wFDN_FLAPSD_lgt_138 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 1.5) => -0.0238624496,
(f_phones_per_addr_curr_i > 1.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 85.5) => 0.1477791244,
      (c_span_lang > 85.5) => 0.0127384711,
      (c_span_lang = NULL) => 0.0617238061, 0.0617238061),
   (r_F00_dob_score_d > 92) => 0.0036113989,
   (r_F00_dob_score_d = NULL) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 10.35) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 6.4) => -0.0183166064,
         (c_rnt1250_p > 6.4) => 0.1272261576,
         (c_rnt1250_p = NULL) => 0.0441430413, 0.0441430413),
      (c_pop_18_24_p > 10.35) => -0.0805085434,
      (c_pop_18_24_p = NULL) => 0.0031570583, 0.0031570583), 0.0053982135),
(f_phones_per_addr_curr_i = NULL) => -0.0007537919, -0.0007537919);

// Tree: 139 
wFDN_FLAPSD_lgt_139 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 130.5) => -0.0091206946,
(f_prevaddrageoldest_d > 130.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 3.5) => 0.0002511829,
   (f_corrrisktype_i > 3.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 121.5) => 0.0078088333,
      (c_asian_lang > 121.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 3.75) => 0.1631876200,
         (c_hval_250k_p > 3.75) => 0.0464242567,
         (c_hval_250k_p = NULL) => 0.0879314988, 0.0879314988),
      (c_asian_lang = NULL) => 0.0757204689, 0.0469172345),
   (f_corrrisktype_i = NULL) => 0.0179840180, 0.0179840180),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_retired2 and c_retired2 <= 104.5) => 0.0518978761,
   (c_retired2 > 104.5) => -0.0795983004,
   (c_retired2 = NULL) => -0.0132240399, -0.0132240399), -0.0016150289);

// Tree: 140 
wFDN_FLAPSD_lgt_140 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 16.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.31571103515) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 0.5) => 0.0680443381,
      (f_rel_under100miles_cnt_d > 0.5) => 0.0070075941,
      (f_rel_under100miles_cnt_d = NULL) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 114) => 0.1992703183,
         (c_old_homes > 114) => -0.0334925978,
         (c_old_homes = NULL) => 0.0892369398, 0.0892369398), 0.0093169754),
   (f_add_input_mobility_index_i > 0.31571103515) => -0.0190646020,
   (f_add_input_mobility_index_i = NULL) => 0.0044031435, 0.0008547606),
(f_hh_members_ct_d > 16.5) => -0.1104520776,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_totsales and c_totsales <= 5091.5) => -0.0606737954,
   (c_totsales > 5091.5) => 0.0645730520,
   (c_totsales = NULL) => 0.0059713161, 0.0059713161), 0.0003914081);

// Tree: 141 
wFDN_FLAPSD_lgt_141 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 20.5) => 
   map(
   (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 0.5) => -0.0091076414,
   (f_addrs_per_ssn_c6_i > 0.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 204.35) => 
         map(
         (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 7.5) => 0.0323348187,
         (f_rel_under100miles_cnt_d > 7.5) => 0.2049808130,
         (f_rel_under100miles_cnt_d = NULL) => 0.1029193689, 0.1029193689),
      (c_housingcpi > 204.35) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.09618628795) => -0.0092992222,
         (f_add_input_nhood_BUS_pct_i > 0.09618628795) => 0.0667958598,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0082130707, 0.0082130707),
      (c_housingcpi = NULL) => 0.0215076906, 0.0215076906),
   (f_addrs_per_ssn_c6_i = NULL) => -0.0057716529, -0.0057716529),
(f_inq_HighRiskCredit_count_i > 20.5) => 0.0962807453,
(f_inq_HighRiskCredit_count_i = NULL) => 0.0006529103, -0.0052770047);

// Tree: 142 
wFDN_FLAPSD_lgt_142 := map(
(NULL < c_construction and c_construction <= 2.15) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6564) => 0.0096129077,
   (f_addrchangeincomediff_d > 6564) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 55.5) => -0.0348086745,
      (c_many_cars > 55.5) => 0.1956818554,
      (c_many_cars = NULL) => 0.0986332112, 0.0986332112),
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 389.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 117.45) => -0.0171165613,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 117.45) => 0.1640808699,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0017674211, 0.0080495866),
      (f_M_Bureau_ADL_FS_all_d > 389.5) => 0.1934543946,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0211488393, 0.0211488393), 0.0155659005),
(c_construction > 2.15) => -0.0079776406,
(c_construction = NULL) => -0.0253540264, -0.0019045188);

// Tree: 143 
wFDN_FLAPSD_lgt_143 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.1) => -0.0026237599,
(r_C12_source_profile_d > 78.1) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 106.5) => 
            map(
            (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 98.5) => 0.1701303605,
            (f_fp_prevaddrburglaryindex_i > 98.5) => 0.0260844157,
            (f_fp_prevaddrburglaryindex_i = NULL) => 0.1008355310, 0.1008355310),
         (c_exp_prod > 106.5) => 0.0019429893,
         (c_exp_prod = NULL) => 0.0523438213, 0.0523438213),
      (k_inq_per_addr_i > 3.5) => 0.1464521667,
      (k_inq_per_addr_i = NULL) => 0.0608561340, 0.0608561340),
   (f_phone_ver_experian_d > 0.5) => 0.0177707458,
   (f_phone_ver_experian_d = NULL) => -0.0140530875, 0.0279337829),
(r_C12_source_profile_d = NULL) => 0.0149107933, 0.0016394271);

// Tree: 144 
wFDN_FLAPSD_lgt_144 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 134.5) => -0.0052885368,
(f_prevaddrcartheftindex_i > 134.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 185.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 479) => 0.1493660321,
      (c_popover18 > 479) => 
         map(
         (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.0556692752,
         (f_hh_age_18_plus_d > 1.5) => 0.0057296428,
         (f_hh_age_18_plus_d = NULL) => 0.0218537305, 0.0218537305),
      (c_popover18 = NULL) => 0.0248191328, 0.0248191328),
   (c_blue_empl > 185.5) => -0.0640586793,
   (c_blue_empl = NULL) => 0.0193524420, 0.0193524420),
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 68.5) => 0.0615087393,
   (c_old_homes > 68.5) => -0.0280317854,
   (c_old_homes = NULL) => 0.0121070705, 0.0121070705), 0.0007591453);

// Tree: 145 
wFDN_FLAPSD_lgt_145 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 55.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0086396716) => 0.1601695808,
   (f_add_curr_nhood_MFD_pct_i > 0.0086396716) => 
      map(
      (NULL < c_young and c_young <= 36.35) => 
         map(
         (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2568152617) => -0.0000633869,
            (f_add_curr_mobility_index_i > 0.2568152617) => 0.1807079995,
            (f_add_curr_mobility_index_i = NULL) => 0.0940367868, 0.0940367868),
         (k_nap_fname_verd_d > 0.5) => 0.0130658609,
         (k_nap_fname_verd_d = NULL) => 0.0341761380, 0.0341761380),
      (c_young > 36.35) => -0.1002182941,
      (c_young = NULL) => 0.0184897216, 0.0184897216),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0057695876, 0.0298958116),
(r_D32_Mos_Since_Crim_LS_d > 55.5) => -0.0023964052,
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0063495821, -0.0000102333);

// Tree: 146 
wFDN_FLAPSD_lgt_146 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -74295) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0608730092) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.1594965302,
         (f_corrphonelastnamecount_d > 0.5) => 0.0133064695,
         (f_corrphonelastnamecount_d = NULL) => 0.1008146044, 0.1008146044),
      (f_add_input_nhood_BUS_pct_i > 0.0608730092) => -0.0347237539,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0419553174, 0.0419553174),
   (f_addrchangevaluediff_d > -74295) => -0.0046784209,
   (f_addrchangevaluediff_d = NULL) => -0.0022339554, -0.0031592504),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1119293996,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.55) => -0.0626300374,
   (c_pop_35_44_p > 14.55) => 0.0303930332,
   (c_pop_35_44_p = NULL) => -0.0161185021, -0.0161185021), -0.0027302028);

// Tree: 147 
wFDN_FLAPSD_lgt_147 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 27.95) => 
   map(
   (NULL < c_young and c_young <= 49.95) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 5.05) => -0.0642814027,
      (c_fammar18_p > 5.05) => 
         map(
         (NULL < c_med_age and c_med_age <= 24.45) => 0.0705131148,
         (c_med_age > 24.45) => 0.0006134894,
         (c_med_age = NULL) => 0.0016568564, 0.0016568564),
      (c_fammar18_p = NULL) => 0.0004477398, 0.0004477398),
   (c_young > 49.95) => -0.0745950346,
   (c_young = NULL) => -0.0017658574, -0.0017658574),
(C_INC_50K_P > 27.95) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 68.8) => 0.2026953716,
   (c_sfdu_p > 68.8) => -0.0023239352,
   (c_sfdu_p = NULL) => 0.1011620006, 0.1011620006),
(C_INC_50K_P = NULL) => 0.0073936112, -0.0007160253);

// Tree: 148 
wFDN_FLAPSD_lgt_148 := map(
(NULL < C_INC_35K_P and C_INC_35K_P <= 23.45) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 89.15) => -0.0044230771,
   (c_lowrent > 89.15) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 5.75) => 0.1922821792,
      (c_pop_6_11_p > 5.75) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 35.65) => -0.0710226170,
         (c_hh2_p > 35.65) => 0.2027268666,
         (c_hh2_p = NULL) => 0.0538921959, 0.0538921959),
      (c_pop_6_11_p = NULL) => 0.0817847506, 0.0817847506),
   (c_lowrent = NULL) => -0.0026095073, -0.0026095073),
(C_INC_35K_P > 23.45) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12) => -0.0412304271,
   (c_pop_35_44_p > 12) => 0.1563364850,
   (c_pop_35_44_p = NULL) => 0.0858755583, 0.0858755583),
(C_INC_35K_P = NULL) => 0.0111320612, -0.0013108459);

// Tree: 149 
wFDN_FLAPSD_lgt_149 := map(
(NULL < r_P85_Phn_Not_Issued_i and r_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 3.5) => 0.0006383749,
      (r_D30_Derog_Count_i > 3.5) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 22.35) => 0.0271505424,
         (c_hval_300k_p > 22.35) => 0.2130109812,
         (c_hval_300k_p = NULL) => 0.0391570307, 0.0391570307),
      (r_D30_Derog_Count_i = NULL) => 0.0032428392, 0.0032428392),
   (f_rel_criminal_count_i > 6.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 75.5) => -0.0881922046,
      (r_pb_order_freq_d > 75.5) => 0.0086104281,
      (r_pb_order_freq_d = NULL) => 0.0007478508, -0.0305970633),
   (f_rel_criminal_count_i = NULL) => 0.0016741737, 0.0011762658),
(r_P85_Phn_Not_Issued_i > 0.5) => -0.0591717796,
(r_P85_Phn_Not_Issued_i = NULL) => -0.0002842663, -0.0002842663);

// Tree: 150 
wFDN_FLAPSD_lgt_150 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 23.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 1.5) => -0.0030640439,
   (f_inq_HighRiskCredit_count24_i > 1.5) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 2.6) => 0.0089868062,
      (c_rnt2000_p > 2.6) => 0.1533866847,
      (c_rnt2000_p = NULL) => 0.0426968823, 0.0426968823),
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0019980349, -0.0019980349),
(f_srchaddrsrchcount_i > 23.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => 0.0120536014,
   (f_phones_per_addr_curr_i > 7.5) => -0.1083246267,
   (f_phones_per_addr_curr_i = NULL) => -0.0570392278, -0.0570392278),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 83.5) => -0.0461908672,
   (c_bel_edu > 83.5) => 0.0858226064,
   (c_bel_edu = NULL) => 0.0229002965, 0.0229002965), -0.0025154290);

// Tree: 151 
wFDN_FLAPSD_lgt_151 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 2.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 173.5) => -0.0126763649,
      (c_rich_wht > 173.5) => 0.1063713553,
      (c_rich_wht = NULL) => 0.0051992215, 0.0051992215),
   (f_addrchangecrimediff_i > 2.5) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 4.65) => 
         map(
         (NULL < c_unempl and c_unempl <= 119.5) => 0.0620807819,
         (c_unempl > 119.5) => 0.1806265541,
         (c_unempl = NULL) => 0.1178670276, 0.1178670276),
      (c_pop_75_84_p > 4.65) => -0.0137320609,
      (c_pop_75_84_p = NULL) => 0.0695673622, 0.0695673622),
   (f_addrchangecrimediff_i = NULL) => 0.0252533630, 0.0215303811),
(f_corrssnaddrcount_d > 2.5) => -0.0011867815,
(f_corrssnaddrcount_d = NULL) => -0.0233633861, 0.0008643996);

// Tree: 152 
wFDN_FLAPSD_lgt_152 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 37.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 10.5) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 2.5) => -0.0090717654,
         (f_rel_homeover300_count_d > 2.5) => 0.0172809306,
         (f_rel_homeover300_count_d = NULL) => 0.0005045181, 0.0005045181),
      (f_crim_rel_under100miles_cnt_i > 10.5) => 0.1138253748,
      (f_crim_rel_under100miles_cnt_i = NULL) => -0.0210513137, 0.0006192840),
   (f_rel_count_i > 37.5) => -0.0560791511,
   (f_rel_count_i = NULL) => 
      map(
      (NULL < c_larceny and c_larceny <= 86.5) => -0.0675695203,
      (c_larceny > 86.5) => 0.0551495496,
      (c_larceny = NULL) => -0.0079631149, -0.0079631149), -0.0006305598),
(r_L77_Add_PO_Box_i > 0.5) => -0.0893820162,
(r_L77_Add_PO_Box_i = NULL) => -0.0025266296, -0.0025266296);

// Tree: 153 
wFDN_FLAPSD_lgt_153 := map(
(NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.1050351495) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 19.5) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 23.5) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 181.5) => 0.0083371317,
         (c_lar_fam > 181.5) => 0.1168041943,
         (c_lar_fam = NULL) => 0.0092825088, 0.0092825088),
      (f_rel_under500miles_cnt_d > 23.5) => -0.0456908598,
      (f_rel_under500miles_cnt_d = NULL) => -0.0056386165, 0.0068832027),
   (k_inq_per_addr_i > 19.5) => 0.0879805782,
   (k_inq_per_addr_i = NULL) => 0.0073246736, 0.0073246736),
(f_add_input_nhood_BUS_pct_i > 0.1050351495) => -0.0233178615,
(f_add_input_nhood_BUS_pct_i = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 28.5) => 0.1175246929,
   (c_born_usa > 28.5) => -0.0047536725,
   (c_born_usa = NULL) => -0.0137296413, 0.0061855233), 0.0018778549);

// Tree: 154 
wFDN_FLAPSD_lgt_154 := map(
(NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 27647) => -0.0356472332,
   (c_med_hhinc > 27647) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30401) => 
         map(
         (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.4082121103) => 0.0660253480,
         (f_add_input_mobility_index_i > 0.4082121103) => -0.0438455306,
         (f_add_input_mobility_index_i = NULL) => 0.0424530504, 0.0424530504),
      (f_curraddrmedianincome_d > 30401) => 0.0028461806,
      (f_curraddrmedianincome_d = NULL) => 0.0047141088, 0.0047141088),
   (c_med_hhinc = NULL) => -0.0007483018, 0.0029591213),
(f_inq_Communications_count24_i > 2.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 102.5) => -0.0070369330,
   (c_relig_indx > 102.5) => 0.1463925649,
   (c_relig_indx = NULL) => 0.0581706036, 0.0581706036),
(f_inq_Communications_count24_i = NULL) => -0.0192657995, 0.0032983032);

// Tree: 155 
wFDN_FLAPSD_lgt_155 := map(
(NULL < c_lar_fam and c_lar_fam <= 59.5) => -0.0315539938,
(c_lar_fam > 59.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0077058152,
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 0.1593038505,
         (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 
            map(
            (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 538) => 0.1184557798,
            (f_mos_inq_banko_cm_fseen_d > 538) => 0.0191455504,
            (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0373490547, 0.0373490547),
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0488245060, 0.0488245060),
      (r_C12_Num_NonDerogs_d > 1.5) => 0.0120043612,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0166834980, 0.0166834980),
   (k_inq_per_ssn_i = NULL) => 0.0022679255, 0.0022679255),
(c_lar_fam = NULL) => 0.0405812293, -0.0020202357);

// Tree: 156 
wFDN_FLAPSD_lgt_156 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 8.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 82.55) => -0.0512396714,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 82.55) => 0.0101869903,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0055204215, -0.0007516446),
(f_srchssnsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => -0.1065439099,
   (f_mos_inq_banko_cm_fseen_d > 41.5) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => -0.0517217928,
      (r_D34_UnRel_Lien60_Count_i > 0.5) => 0.0770588411,
      (r_D34_UnRel_Lien60_Count_i = NULL) => -0.0198392087, -0.0198392087),
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0434302405, -0.0434302405),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 7.9) => -0.0155283247,
   (C_INC_15K_P > 7.9) => 0.0892815133,
   (C_INC_15K_P = NULL) => 0.0363577337, 0.0363577337), -0.0014053999);

// Tree: 157 
wFDN_FLAPSD_lgt_157 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 71.25) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 62.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 24568.5) => -0.0639045501,
      (f_curraddrmedianincome_d > 24568.5) => -0.0006942863,
      (f_curraddrmedianincome_d = NULL) => -0.0025039055, -0.0025039055),
   (f_addrchangecrimediff_i > 62.5) => 
      map(
      (NULL < c_retail and c_retail <= 7.25) => -0.0134972251,
      (c_retail > 7.25) => 0.1163334185,
      (c_retail = NULL) => 0.0472422573, 0.0472422573),
   (f_addrchangecrimediff_i = NULL) => -0.0002056061, -0.0013240801),
(c_rnt2001_p > 71.25) => 
   map(
   (NULL < c_food and c_food <= 12.75) => -0.0348526443,
   (c_food > 12.75) => 0.2987736339,
   (c_food = NULL) => 0.1342773439, 0.1342773439),
(c_rnt2001_p = NULL) => 0.0137992832, 0.0005395509);

// Tree: 158 
wFDN_FLAPSD_lgt_158 := map(
(NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 0.5) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 35.05) => 0.0006803037,
   (c_hval_40k_p > 35.05) => -0.1165845326,
   (c_hval_40k_p = NULL) => 0.0133504056, 0.0002953069),
(f_acc_damage_amt_total_i > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 2.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 119.5) => -0.0417605147,
      (c_no_car > 119.5) => 0.1367342727,
      (c_no_car = NULL) => 0.0143571647, 0.0143571647),
   (r_D30_Derog_Count_i > 2.5) => 0.1740268370,
   (r_D30_Derog_Count_i = NULL) => 0.0449322083, 0.0449322083),
(f_acc_damage_amt_total_i = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 110.5) => -0.0722896028,
   (c_span_lang > 110.5) => 0.0397886339,
   (c_span_lang = NULL) => -0.0196032522, -0.0196032522), 0.0012679132);

// Tree: 159 
wFDN_FLAPSD_lgt_159 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 75.85) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 0.0004090672,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_no_move and c_no_move <= 91) => 0.0038082987,
      (c_no_move > 91) => 0.1207812722,
      (c_no_move = NULL) => 0.0451902469, 0.0451902469),
   (k_nap_contradictory_i = NULL) => 0.0011885737, 0.0011885737),
(c_rnt1000_p > 75.85) => 
   map(
   (NULL < c_work_home and c_work_home <= 63.5) => 0.2398484915,
   (c_work_home > 63.5) => 
      map(
      (NULL < c_health and c_health <= 13.35) => -0.0379711018,
      (c_health > 13.35) => 0.1834593782,
      (c_health = NULL) => 0.0367447043, 0.0367447043),
   (c_work_home = NULL) => 0.0900479607, 0.0900479607),
(c_rnt1000_p = NULL) => -0.0107623807, 0.0024681876);

// Tree: 160 
wFDN_FLAPSD_lgt_160 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 0.0009874590,
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 162) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 0.5) => 
         map(
         (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 4.5) => 0.0981154323,
         (f_rel_under500miles_cnt_d > 4.5) => -0.0489461578,
         (f_rel_under500miles_cnt_d = NULL) => -0.0047127889, -0.0047127889),
      (f_inq_QuizProvider_count_i > 0.5) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 95) => 0.0427898557,
         (c_blue_empl > 95) => 0.1766048182,
         (c_blue_empl = NULL) => 0.0995273998, 0.0995273998),
      (f_inq_QuizProvider_count_i = NULL) => 0.0289565227, 0.0289565227),
   (f_curraddrcrimeindex_i > 162) => 0.1438915335,
   (f_curraddrcrimeindex_i = NULL) => 0.0423393664, 0.0423393664),
(f_srchcomponentrisktype_i = NULL) => 0.0062851096, 0.0024620725);

// Tree: 161 
wFDN_FLAPSD_lgt_161 := map(
(NULL < c_hh6_p and c_hh6_p <= 12.95) => 
   map(
   (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 15.5) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.1826948166) => 0.1594676739,
         (f_add_input_nhood_MFD_pct_i > 0.1826948166) => 0.0543358687,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.1028582403, 0.1028582403),
      (r_D32_Mos_Since_Crim_LS_d > 15.5) => -0.0171247293,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0131522840, -0.0139759127),
   (f_util_add_input_misc_n > 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 4.5) => 0.0890362350,
      (f_mos_inq_banko_cm_lseen_d > 4.5) => 0.0108325254,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0119473905, 0.0119473905),
   (f_util_add_input_misc_n = NULL) => -0.0016820147, -0.0016820147),
(c_hh6_p > 12.95) => -0.0738801626,
(c_hh6_p = NULL) => -0.0137537720, -0.0032432753);

// Tree: 162 
wFDN_FLAPSD_lgt_162 := map(
(NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 0.0029977557,
      (r_D31_ALL_Bk_i > 1.5) => -0.0418626029,
      (r_D31_ALL_Bk_i = NULL) => -0.0011176390, -0.0011176390),
   (f_assocsuspicousidcount_i > 15.5) => 0.1099517934,
   (f_assocsuspicousidcount_i = NULL) => -0.0005867660, -0.0005867660),
(nf_vf_lexid_hi_summary > 4.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 170.5) => -0.0876418934,
   (c_new_homes > 170.5) => 0.0821673485,
   (c_new_homes = NULL) => -0.0518171588, -0.0518171588),
(nf_vf_lexid_hi_summary = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 139.5) => 0.0521860769,
   (c_asian_lang > 139.5) => -0.0472930909,
   (c_asian_lang = NULL) => 0.0019540219, 0.0019540219), -0.0015230972);

// Tree: 163 
wFDN_FLAPSD_lgt_163 := map(
(NULL < c_pop_55_64_p and c_pop_55_64_p <= 2.05) => -0.0796366598,
(c_pop_55_64_p > 2.05) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 50.85) => -0.0019352018,
   (c_hval_750k_p > 50.85) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0234525055,
      (f_idverrisktype_i > 1.5) => 
         map(
         (NULL < c_unempl and c_unempl <= 98.5) => 
            map(
            (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 2.5) => 0.0810060301,
            (f_hh_age_18_plus_d > 2.5) => 0.3278147093,
            (f_hh_age_18_plus_d = NULL) => 0.1924680143, 0.1924680143),
         (c_unempl > 98.5) => 0.0149205529,
         (c_unempl = NULL) => 0.1082082021, 0.1082082021),
      (f_idverrisktype_i = NULL) => 0.0425176155, 0.0425176155),
   (c_hval_750k_p = NULL) => -0.0002055910, -0.0002055910),
(c_pop_55_64_p = NULL) => -0.0066573297, -0.0015873322);

// Tree: 164 
wFDN_FLAPSD_lgt_164 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 6.5) => 
      map(
      (NULL < c_totsales and c_totsales <= 56413.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 153.7) => 0.0015137831,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 153.7) => 0.0871594978,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0048428581, -0.0002252679),
      (c_totsales > 56413.5) => -0.0446626408,
      (c_totsales = NULL) => 0.0045000215, -0.0050711832),
   (f_divaddrsuspidcountnew_i > 6.5) => 0.0933070957,
   (f_divaddrsuspidcountnew_i = NULL) => 0.0135752767, -0.0044747423),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0638581564,
   (f_idverrisktype_i > 1.5) => 0.1548838879,
   (f_idverrisktype_i = NULL) => 0.0742130631, 0.0742130631),
(f_nae_nothing_found_i = NULL) => -0.0035876823, -0.0035876823);

// Tree: 165 
wFDN_FLAPSD_lgt_165 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 22160) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 8.95) => 0.0055115494,
   (c_pop_12_17_p > 8.95) => 0.1562860363,
   (c_pop_12_17_p = NULL) => 0.0735602116, 0.0735602116),
(r_A46_Curr_AVM_AutoVal_d > 22160) => -0.0033912678,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 59.5) => -0.0249845285,
      (r_A50_pb_average_dollars_d > 59.5) => 
         map(
         (NULL < c_construction and c_construction <= 44) => 0.0086045948,
         (c_construction > 44) => 0.1290393270,
         (c_construction = NULL) => 0.0037263236, 0.0119928972),
      (r_A50_pb_average_dollars_d = NULL) => 0.0248511430, 0.0009512997),
   (k_inq_per_ssn_i > 10.5) => 0.0928170785,
   (k_inq_per_ssn_i = NULL) => 0.0019478213, 0.0019478213), -0.0004104421);

// Tree: 166 
wFDN_FLAPSD_lgt_166 := map(
(NULL < c_unempl and c_unempl <= 29.5) => -0.0610136458,
(c_unempl > 29.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 2.5) => -0.0158933531,
   (f_phones_per_addr_curr_i > 2.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0096584154,
      (f_idverrisktype_i > 1.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 23.15) => 
            map(
            (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0666283965) => 0.0107217653,
            (f_add_curr_nhood_VAC_pct_i > 0.0666283965) => 0.0600614836,
            (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0198577233, 0.0198577233),
         (C_INC_35K_P > 23.15) => 0.1567111265,
         (C_INC_35K_P = NULL) => 0.0219031381, 0.0219031381),
      (f_idverrisktype_i = NULL) => -0.0006002963, 0.0058556573),
   (f_phones_per_addr_curr_i = NULL) => -0.0019989887, -0.0019989887),
(c_unempl = NULL) => -0.0259193443, -0.0065203171);

// Tree: 167 
wFDN_FLAPSD_lgt_167 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 59.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 6.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 85) => -0.0196890703,
         (c_lowrent > 85) => 0.0714565964,
         (c_lowrent = NULL) => 0.0444378734, -0.0146308017),
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0053519173,
      (nf_seg_FraudPoint_3_0 = '') => 0.0002752178, 0.0002752178),
   (f_idrisktype_i > 6.5) => 0.0793748143,
   (f_idrisktype_i = NULL) => -0.0132915923, 0.0008034536),
(f_phones_per_addr_curr_i > 59.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.1) => 0.0068562754,
   (c_hh4_p > 12.1) => 0.1411501537,
   (c_hh4_p = NULL) => 0.0588093816, 0.0588093816),
(f_phones_per_addr_curr_i = NULL) => 0.0014344996, 0.0014344996);

// Tree: 168 
wFDN_FLAPSD_lgt_168 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 61.5) => -0.0656440876,
(f_mos_inq_banko_am_fseen_d > 61.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 3.45) => -0.0360243555,
   (c_pop_18_24_p > 3.45) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0027081935) => -0.0440766072,
      (f_add_input_nhood_BUS_pct_i > 0.0027081935) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 34.5) => -0.0084759973,
         (k_comb_age_d > 34.5) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 4.5) => 0.0749193647,
            (f_prevaddrlenofres_d > 4.5) => 0.0152931389,
            (f_prevaddrlenofres_d = NULL) => 0.0190077912, 0.0190077912),
         (k_comb_age_d = NULL) => 0.0083527307, 0.0083527307),
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0572393647, 0.0075134699),
   (c_pop_18_24_p = NULL) => 0.0042511095, 0.0029090831),
(f_mos_inq_banko_am_fseen_d = NULL) => -0.0111564627, -0.0001259301);

// Tree: 169 
wFDN_FLAPSD_lgt_169 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0050315167,
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 1.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.62402385985) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 2.55) => 0.0815280936,
         (c_hh6_p > 2.55) => -0.0689200768,
         (c_hh6_p = NULL) => 0.0335830723, 0.0335830723),
      (f_add_curr_nhood_MFD_pct_i > 0.62402385985) => 0.1800692593,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0918868432, 0.0629825844),
   (f_inq_count24_i > 1.5) => 
      map(
      (NULL < c_highinc and c_highinc <= 4.05) => -0.0801215970,
      (c_highinc > 4.05) => 0.0228972893,
      (c_highinc = NULL) => 0.0079236139, 0.0079236139),
   (f_inq_count24_i = NULL) => 0.0250911239, 0.0250911239),
(k_inq_per_phone_i = NULL) => -0.0020465613, -0.0020465613);

// Tree: 170 
wFDN_FLAPSD_lgt_170 := map(
(NULL < c_hh6_p and c_hh6_p <= 12.35) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 26.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.15) => -0.0032019965,
      (r_C12_source_profile_d > 78.15) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 11.95) => 
            map(
            (NULL < c_famotf18_p and c_famotf18_p <= 11.95) => 0.1347820710,
            (c_famotf18_p > 11.95) => -0.0214310793,
            (c_famotf18_p = NULL) => 0.0803378095, 0.0803378095),
         (c_newhouse > 11.95) => -0.0054035684,
         (c_newhouse = NULL) => 0.0344488104, 0.0344488104),
      (r_C12_source_profile_d = NULL) => 0.0018337989, 0.0018337989),
   (f_srchssnsrchcount_i > 26.5) => 0.0954952377,
   (f_srchssnsrchcount_i = NULL) => -0.0060778986, 0.0021974687),
(c_hh6_p > 12.35) => -0.0722782530,
(c_hh6_p = NULL) => 0.0197425414, 0.0011027855);

// Tree: 171 
wFDN_FLAPSD_lgt_171 := map(
(NULL < k_inq_lnames_per_addr_i and k_inq_lnames_per_addr_i <= 4.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 50.5) => 0.1616191879,
      (f_mos_inq_banko_cm_fseen_d > 50.5) => -0.0043800599,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0419800904, 0.0419800904),
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => -0.0009610812,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 6.2) => -0.0440709760,
      (c_hval_250k_p > 6.2) => 0.0502721946,
      (c_hval_250k_p = NULL) => 0.0035255785, 0.0035255785), -0.0001605629),
(k_inq_lnames_per_addr_i > 4.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 17.35) => -0.1260664774,
   (c_hh3_p > 17.35) => -0.0015566466,
   (c_hh3_p = NULL) => -0.0785436412, -0.0785436412),
(k_inq_lnames_per_addr_i = NULL) => -0.0009762166, -0.0009762166);

// Tree: 172 
wFDN_FLAPSD_lgt_172 := map(
(NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 7.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 37.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 2.5) => -0.0418723383,
      (f_addrs_per_ssn_i > 2.5) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 165.5) => 
            map(
            (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => -0.0329826800,
            (r_F01_inp_addr_address_score_d > 75) => 0.0060439585,
            (r_F01_inp_addr_address_score_d = NULL) => 0.0037450123, 0.0037450123),
         (c_serv_empl > 165.5) => 0.0301417082,
         (c_serv_empl = NULL) => -0.0007430440, 0.0075891425),
      (f_addrs_per_ssn_i = NULL) => 0.0029495940, 0.0029495940),
   (f_rel_educationover8_count_d > 37.5) => -0.0886192099,
   (f_rel_educationover8_count_d = NULL) => -0.0113349715, 0.0018885689),
(f_assoccredbureaucount_i > 7.5) => 0.0933904604,
(f_assoccredbureaucount_i = NULL) => 0.0054429585, 0.0023993263);

// Tree: 173 
wFDN_FLAPSD_lgt_173 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0118062081,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < c_transport and c_transport <= 25.85) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 13.5) => 0.1145071181,
      (f_M_Bureau_ADL_FS_all_d > 13.5) => 
         map(
         (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 26) => 
            map(
            (NULL < c_rich_old and c_rich_old <= 191.5) => 0.0008942868,
            (c_rich_old > 191.5) => 0.1099834086,
            (c_rich_old = NULL) => 0.0050554800, 0.0050554800),
         (f_acc_damage_amt_total_i > 26) => 0.1191776703,
         (f_acc_damage_amt_total_i = NULL) => 0.0081629182, 0.0081629182),
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0103320729, 0.0103320729),
   (c_transport > 25.85) => 0.1219645893,
   (c_transport = NULL) => 0.0132323573, 0.0132323573),
(f_hh_lienholders_i = NULL) => 0.0132425210, -0.0037843077);

// Tree: 174 
wFDN_FLAPSD_lgt_174 := map(
(NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 15.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 10.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
         map(
         (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 7.5) => 0.0048357331,
         (f_inq_Collection_count_i > 7.5) => -0.0533268911,
         (f_inq_Collection_count_i = NULL) => 0.0034301483, 0.0034301483),
      (f_srchfraudsrchcountyr_i > 7.5) => -0.0795440149,
      (f_srchfraudsrchcountyr_i = NULL) => 0.0030377715, 0.0030377715),
   (f_inq_Collection_count_i > 10.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.65) => -0.0410615096,
      (c_pop_65_74_p > 4.65) => 0.1392569312,
      (c_pop_65_74_p = NULL) => 0.0657938627, 0.0657938627),
   (f_inq_Collection_count_i = NULL) => 0.0038558681, 0.0038558681),
(f_inq_Collection_count_i > 15.5) => -0.0731231266,
(f_inq_Collection_count_i = NULL) => -0.0117678306, 0.0028415932);

// Tree: 175 
wFDN_FLAPSD_lgt_175 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 3.5) => -0.0045208089,
   (f_srchfraudsrchcountyr_i > 3.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 15.4) => -0.0167479522,
      (c_famotf18_p > 15.4) => -0.1342981332,
      (c_famotf18_p = NULL) => -0.0583943021, -0.0583943021),
   (f_srchfraudsrchcountyr_i = NULL) => -0.0054335674, -0.0054335674),
(f_util_adl_count_n > 3.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_I60_inq_retpymt_recency_d and r_I60_inq_retpymt_recency_d <= 61.5) => 0.1609925178,
      (r_I60_inq_retpymt_recency_d > 61.5) => 0.0298987107,
      (r_I60_inq_retpymt_recency_d = NULL) => 0.0412981722, 0.0412981722),
   (f_phone_ver_experian_d > 0.5) => -0.0062100267,
   (f_phone_ver_experian_d = NULL) => 0.0384670441, 0.0152366868),
(f_util_adl_count_n = NULL) => -0.0130578661, -0.0019225748);

// Tree: 176 
wFDN_FLAPSD_lgt_176 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 0.5) => 
   map(
   (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 3.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 1.15) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 24.5) => 0.1722090074,
         (c_no_teens > 24.5) => 0.0191222971,
         (c_no_teens = NULL) => 0.0474716879, 0.0474716879),
      (C_INC_125K_P > 1.15) => -0.0027962222,
      (C_INC_125K_P = NULL) => -0.0057583553, -0.0016119785),
   (f_hh_age_65_plus_d > 3.5) => 0.1411450067,
   (f_hh_age_65_plus_d = NULL) => -0.0007923552, -0.0007923552),
(f_vf_AltLexID_addr_hi_risk_ct_i > 0.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 179.5) => -0.0199532203,
   (c_sub_bus > 179.5) => -0.0919419216,
   (c_sub_bus = NULL) => -0.0370870625, -0.0370870625),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => -0.0118018104, -0.0024675776);

// Tree: 177 
wFDN_FLAPSD_lgt_177 := map(
(NULL < C_INC_35K_P and C_INC_35K_P <= 26.45) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0024744701,
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 43.5) => 0.2934261457,
      (c_no_car > 43.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04605384475) => -0.0724225692,
         (f_add_curr_nhood_BUS_pct_i > 0.04605384475) => 0.1029123348,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0116907969, 0.0116907969),
      (c_no_car = NULL) => 0.0797428135, 0.0797428135),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0010979756, -0.0010979756),
(C_INC_35K_P > 26.45) => 0.1236320768,
(C_INC_35K_P = NULL) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => -0.0603344247,
   (f_srchfraudsrchcount_i > 0.5) => 0.0895985544,
   (f_srchfraudsrchcount_i = NULL) => -0.0139810991, -0.0139810991), -0.0008164734);

// Tree: 178 
wFDN_FLAPSD_lgt_178 := map(
(NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 6.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 6.5) => 
         map(
         (NULL < f_util_add_curr_inf_n and f_util_add_curr_inf_n <= 0.5) => 0.0178061140,
         (f_util_add_curr_inf_n > 0.5) => 
            map(
            (NULL < c_hh3_p and c_hh3_p <= 13.7) => -0.0207474099,
            (c_hh3_p > 13.7) => 0.2451627189,
            (c_hh3_p = NULL) => 0.1404736918, 0.1404736918),
         (f_util_add_curr_inf_n = NULL) => 0.0219231283, 0.0219231283),
      (f_rel_homeover500_count_d > 6.5) => 0.1227895388,
      (f_rel_homeover500_count_d = NULL) => 0.0453907579, 0.0270037622),
   (f_corrssnnamecount_d > 6.5) => -0.0096697444,
   (f_corrssnnamecount_d = NULL) => 0.0391859093, 0.0133977629),
(r_Phn_Cell_n > 0.5) => -0.0107330366,
(r_Phn_Cell_n = NULL) => 0.0017613340, 0.0017613340);

// Tree: 179 
wFDN_FLAPSD_lgt_179 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -94327.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0949520966,
   (f_phone_ver_experian_d > 0.5) => -0.0258949878,
   (f_phone_ver_experian_d = NULL) => 0.0017198385, 0.0354202421),
(f_addrchangevaluediff_d > -94327.5) => -0.0020361554,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 3.05) => -0.0079292356,
   (c_hh7p_p > 3.05) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1176) => 
         map(
         (NULL < c_med_rent and c_med_rent <= 998.5) => 0.0525999831,
         (c_med_rent > 998.5) => 0.2260283737,
         (c_med_rent = NULL) => 0.0782550705, 0.0782550705),
      (c_med_rent > 1176) => -0.0650919557,
      (c_med_rent = NULL) => 0.0499942554, 0.0499942554),
   (c_hh7p_p = NULL) => -0.0115068464, 0.0001714540), -0.0007864869);

// Tree: 180 
wFDN_FLAPSD_lgt_180 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0332386476) => 0.0731919199,
   (f_add_input_nhood_BUS_pct_i > 0.0332386476) => -0.0049180407,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0325747404, 0.0325747404),
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 4.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 3.35) => -0.0210869508,
      (c_incollege > 3.35) => 0.0066099906,
      (c_incollege = NULL) => 0.0192784859, 0.0012473495),
   (f_inq_Banking_count24_i > 4.5) => -0.0816503138,
   (f_inq_Banking_count24_i = NULL) => 0.0004191743, 0.0004191743),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 65) => 0.0437950838,
   (c_old_homes > 65) => -0.0656745915,
   (c_old_homes = NULL) => -0.0144548352, -0.0144548352), 0.0006959703);

// Tree: 181 
wFDN_FLAPSD_lgt_181 := map(
(NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 198.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 93.5) => -0.0160078129,
   (c_new_homes > 93.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 5.5) => 0.0025235326,
      (f_srchssnsrchcount_i > 5.5) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 131) => 0.0244562375,
         (c_mort_indx > 131) => 0.1682483626,
         (c_mort_indx = NULL) => 0.0470752235, 0.0470752235),
      (f_srchssnsrchcount_i = NULL) => 0.0046732211, 0.0046732211),
   (c_new_homes = NULL) => -0.0038544718, -0.0035477193),
(f_curraddrmurderindex_i > 198.5) => 0.1450596194,
(f_curraddrmurderindex_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 399.5) => -0.0239858318,
   (c_families > 399.5) => 0.0629446881,
   (c_families = NULL) => 0.0144790000, 0.0144790000), -0.0027751017);

// Tree: 182 
wFDN_FLAPSD_lgt_182 := map(
(NULL < c_unempl and c_unempl <= 40.5) => -0.0433106401,
(c_unempl > 40.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1991.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 153) => 0.0027769705,
      (f_liens_unrel_SC_total_amt_i > 153) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 37.5) => 0.1508982813,
         (f_prevaddrageoldest_d > 37.5) => -0.0012010020,
         (f_prevaddrageoldest_d = NULL) => 0.0559222583, 0.0559222583),
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0038821844, 0.0038821844),
   (f_liens_unrel_SC_total_amt_i > 1991.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.05) => -0.1061007389,
      (c_pop_55_64_p > 12.05) => 0.0794238795,
      (c_pop_55_64_p = NULL) => -0.0526615825, -0.0526615825),
   (f_liens_unrel_SC_total_amt_i = NULL) => -0.0199432249, 0.0027269069),
(c_unempl = NULL) => 0.0030983128, -0.0027234060);

// Tree: 183 
wFDN_FLAPSD_lgt_183 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 126021) => -0.0226799674,
(f_prevaddrmedianvalue_d > 126021) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.028477754) => -0.0058044046,
   (f_add_curr_nhood_VAC_pct_i > 0.028477754) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
         map(
         (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => 0.0186272832,
         (f_divaddrsuspidcountnew_i > 0.5) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 120) => 0.2781692129,
            (c_span_lang > 120) => 0.0904465859,
            (c_span_lang = NULL) => 0.1617811842, 0.1617811842),
         (f_divaddrsuspidcountnew_i = NULL) => 0.0729394416, 0.0729394416),
      (r_C12_Num_NonDerogs_d > 1.5) => 0.0205299519,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0275132049, 0.0275132049),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0048679493, 0.0048679493),
(f_prevaddrmedianvalue_d = NULL) => -0.0139693518, -0.0023513413);

// Tree: 184 
wFDN_FLAPSD_lgt_184 := map(
(NULL < c_transport and c_transport <= 28.25) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 23.35) => 0.0443311214,
      (c_white_col > 23.35) => 0.0042274452,
      (c_white_col = NULL) => 0.0082628463, 0.0082628463),
   (r_C14_addrs_10yr_i > 2.5) => -0.0142148461,
   (r_C14_addrs_10yr_i = NULL) => 0.0068678921, 0.0008067565),
(c_transport > 28.25) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 117) => -0.0469103871,
      (c_no_car > 117) => 0.1279201941,
      (c_no_car = NULL) => 0.0135656001, 0.0135656001),
   (f_util_adl_count_n > 1.5) => 0.1601194386,
   (f_util_adl_count_n = NULL) => 0.0638299331, 0.0638299331),
(c_transport = NULL) => 0.0020192304, 0.0020579257);

// Tree: 185 
wFDN_FLAPSD_lgt_185 := map(
(NULL < c_unemp and c_unemp <= 10.35) => 
   map(
   (NULL < r_L71_Add_Curr_Business_i and r_L71_Add_Curr_Business_i <= 0.5) => 
      map(
      (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 0.5) => 0.0011725655,
      (r_S65_SSN_Problem_i > 0.5) => -0.0495468585,
      (r_S65_SSN_Problem_i = NULL) => -0.0011241147, -0.0011241147),
   (r_L71_Add_Curr_Business_i > 0.5) => 0.0937684304,
   (r_L71_Add_Curr_Business_i = NULL) => 0.0028784596, -0.0003143293),
(c_unemp > 10.35) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 40.5) => 0.0559841218,
   (f_M_Bureau_ADL_FS_noTU_d > 40.5) => -0.0582116369,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0416134161, -0.0416134161),
(c_unemp = NULL) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.1770672256,
   (r_F01_inp_addr_address_score_d > 95) => -0.0288086628,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0184415411, 0.0184415411), -0.0010534264);

// Tree: 186 
wFDN_FLAPSD_lgt_186 := map(
(NULL < r_C22_stl_inq_Count24_i and r_C22_stl_inq_Count24_i <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 13.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 149.5) => -0.0035057306,
      (f_prevaddrmurderindex_i > 149.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 30.1) => 0.0184406857,
         (C_INC_75K_P > 30.1) => 0.1983149569,
         (C_INC_75K_P = NULL) => 0.0227583590, 0.0227583590),
      (f_prevaddrmurderindex_i = NULL) => 0.0009178510, 0.0009178510),
   (k_inq_per_ssn_i > 13.5) => 0.0938202692,
   (k_inq_per_ssn_i = NULL) => 0.0015280231, 0.0015280231),
(r_C22_stl_inq_Count24_i > 0.5) => -0.0644540807,
(r_C22_stl_inq_Count24_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0515789383) => 0.0611987452,
   (f_add_input_nhood_BUS_pct_i > 0.0515789383) => -0.0354935426,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0133130408, 0.0133130408), 0.0011620761);

// Tree: 187 
wFDN_FLAPSD_lgt_187 := map(
(NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.2688741879) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 27.65) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 11.5) => 0.0024855945,
      (f_crim_rel_under100miles_cnt_i > 11.5) => 0.1179754901,
      (f_crim_rel_under100miles_cnt_i = NULL) => 
         map(
         (NULL < c_unattach and c_unattach <= 80.5) => 0.1072251801,
         (c_unattach > 80.5) => -0.0261069352,
         (c_unattach = NULL) => -0.0030728156, -0.0030728156), 0.0029681635),
   (C_INC_50K_P > 27.65) => 0.0963531782,
   (C_INC_50K_P = NULL) => 0.0038225924, 0.0038225924),
(f_add_input_nhood_BUS_pct_i > 0.2688741879) => -0.0603977515,
(f_add_input_nhood_BUS_pct_i = NULL) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0091829369,
   (f_srchvelocityrisktype_i > 4.5) => 0.1050499232,
   (f_srchvelocityrisktype_i = NULL) => 0.0002318593, 0.0002318593), 0.0013925776);

// Tree: 188 
wFDN_FLAPSD_lgt_188 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 8.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 65.5) => 0.1458634210,
      (c_retired2 > 65.5) => -0.0055351303,
      (c_retired2 = NULL) => 0.0507278448, 0.0507278448),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0013322597,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0006953090, -0.0006953090),
(f_srchssnsrchcount_i > 8.5) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 0.5) => -0.1127084211,
   (f_inq_QuizProvider_count_i > 0.5) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 79) => 0.0451338073,
      (c_old_homes > 79) => -0.0829541542,
      (c_old_homes = NULL) => -0.0117941756, -0.0117941756),
   (f_inq_QuizProvider_count_i = NULL) => -0.0648555369, -0.0648555369),
(f_srchssnsrchcount_i = NULL) => -0.0051039001, -0.0023032443);

// Tree: 189 
wFDN_FLAPSD_lgt_189 := map(
(NULL < c_hval_20k_p and c_hval_20k_p <= 12.95) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 15.5) => -0.0436070356,
   (f_mos_inq_banko_om_fseen_d > 15.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 11.95) => 0.0033440508,
      (c_hh6_p > 11.95) => -0.0767951761,
      (c_hh6_p = NULL) => 0.0015515678, 0.0015515678),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0043577689, -0.0012258469),
(c_hval_20k_p > 12.95) => 
   map(
   (NULL < c_white_col and c_white_col <= 27.5) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.7422605416) => 0.1724645833,
      (f_add_curr_nhood_SFD_pct_d > 0.7422605416) => 0.0519176260,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0919564368, 0.0919564368),
   (c_white_col > 27.5) => -0.0309632762,
   (c_white_col = NULL) => 0.0347190132, 0.0347190132),
(c_hval_20k_p = NULL) => -0.0226745462, -0.0002144578);

// Tree: 190 
wFDN_FLAPSD_lgt_190 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37472740295) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 166.5) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 2137) => 0.0137370193,
         (c_popover18 > 2137) => 
            map(
            (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.45) => 0.0217591749,
            (c_pop_18_24_p > 7.45) => 0.2734489966,
            (c_pop_18_24_p = NULL) => 0.1247231929, 0.1247231929),
         (c_popover18 = NULL) => 0.0246374470, 0.0246374470),
      (c_lar_fam > 166.5) => 0.1336050467,
      (c_lar_fam = NULL) => 0.0301781724, 0.0301781724),
   (f_hh_age_18_plus_d > 1.5) => -0.0025765988,
   (f_hh_age_18_plus_d = NULL) => -0.0066554767, 0.0042409682),
(f_add_input_mobility_index_i > 0.37472740295) => -0.0156258416,
(f_add_input_mobility_index_i = NULL) => 0.0931088548, 0.0013522274);

// Tree: 191 
wFDN_FLAPSD_lgt_191 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 24) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 87109) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 168) => -0.0744510662,
      (f_mos_liens_unrel_CJ_fseen_d > 168) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 0.0184551569,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 
            map(
            (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 55992.5) => 0.1391698408,
            (f_prevaddrmedianvalue_d > 55992.5) => 0.0364162592,
            (f_prevaddrmedianvalue_d = NULL) => 0.0763620281, 0.0763620281),
         (nf_seg_FraudPoint_3_0 = '') => 0.0409043610, 0.0409043610),
      (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0331528026, 0.0331528026),
   (f_curraddrmedianvalue_d > 87109) => -0.0011633749,
   (f_curraddrmedianvalue_d = NULL) => 0.0042657923, 0.0020911267),
(c_hval_60k_p > 24) => -0.0570016519,
(c_hval_60k_p = NULL) => -0.0572723354, -0.0006678159);

// Tree: 192 
wFDN_FLAPSD_lgt_192 := map(
(NULL < c_unempl and c_unempl <= 193.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 2.5) => -0.0336204773,
   (f_addrs_per_ssn_i > 2.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
         map(
         (NULL < f_prevaddrdwelltype_sfd_n and f_prevaddrdwelltype_sfd_n <= 0.5) => -0.0063056803,
         (f_prevaddrdwelltype_sfd_n > 0.5) => 0.1445288208,
         (f_prevaddrdwelltype_sfd_n = NULL) => 0.0676886033, 0.0676886033),
      (r_C21_M_Bureau_ADL_FS_d > 6.5) => 
         map(
         (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 1.5) => 0.0611944477,
         (r_C20_email_verification_d > 1.5) => -0.0643165693,
         (r_C20_email_verification_d = NULL) => 0.0038390978, 0.0048472755),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0088006031, 0.0053750836),
   (f_addrs_per_ssn_i = NULL) => 0.0012963536, 0.0012963536),
(c_unempl > 193.5) => -0.0880124277,
(c_unempl = NULL) => 0.0002006117, 0.0008442511);

// Tree: 193 
wFDN_FLAPSD_lgt_193 := map(
(NULL < c_rnt1500_p and c_rnt1500_p <= 30.25) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -163485.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 61000.5) => 0.1489885445,
      (f_curraddrmedianincome_d > 61000.5) => -0.0146232569,
      (f_curraddrmedianincome_d = NULL) => 0.0576979017, 0.0576979017),
   (f_addrchangevaluediff_d > -163485.5) => 0.0023402746,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 39.35) => -0.0147378769,
      (c_rnt500_p > 39.35) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 157.5) => 0.0083056466,
         (f_curraddrmurderindex_i > 157.5) => 0.1405998130,
         (f_curraddrmurderindex_i = NULL) => 0.0411173923, 0.0411173923),
      (c_rnt500_p = NULL) => -0.0056709125, -0.0056709125), 0.0013261501),
(c_rnt1500_p > 30.25) => -0.0501397487,
(c_rnt1500_p = NULL) => 0.0038687108, -0.0019417971);

// Tree: 194 
wFDN_FLAPSD_lgt_194 := map(
(NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 37) => -0.1344641761,
(f_mos_liens_rel_CJ_lseen_d > 37) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => -0.0022725765,
   (f_phones_per_addr_curr_i > 8.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 21.65) => 0.0138487119,
      (c_hval_500k_p > 21.65) => 
         map(
         (NULL < c_rental and c_rental <= 99.5) => 0.0025009334,
         (c_rental > 99.5) => 0.1865064147,
         (c_rental = NULL) => 0.1086204967, 0.1086204967),
      (c_hval_500k_p = NULL) => 0.0269326179, 0.0269326179),
   (f_phones_per_addr_curr_i = NULL) => 0.0009462505, 0.0009462505),
(f_mos_liens_rel_CJ_lseen_d = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 105) => 0.0596412536,
   (c_many_cars > 105) => -0.0593697190,
   (c_many_cars = NULL) => -0.0008559908, -0.0008559908), 0.0003845000);

// Tree: 195 
wFDN_FLAPSD_lgt_195 := map(
(NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 4.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => -0.0015327977,
   (f_inq_PrepaidCards_count24_i > 0.5) => 0.0467730491,
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0009026023, -0.0009026023),
(nf_vf_lexid_hi_summary > 4.5) => 
   map(
   (NULL < c_business and c_business <= 9.5) => -0.1457339455,
   (c_business > 9.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 4.95) => 0.0734278536,
      (c_hval_250k_p > 4.95) => -0.0716988637,
      (c_hval_250k_p = NULL) => -0.0192236665, -0.0192236665),
   (c_business = NULL) => -0.0496295705, -0.0496295705),
(nf_vf_lexid_hi_summary = NULL) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 8.05) => -0.0498521326,
   (C_INC_35K_P > 8.05) => 0.0622542857,
   (C_INC_35K_P = NULL) => 0.0036298284, 0.0036298284), -0.0017621642);

// Tree: 196 
wFDN_FLAPSD_lgt_196 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 3.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0010128489,
   (r_D33_eviction_count_i > 0.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 133) => -0.0001500424,
      (f_curraddrburglaryindex_i > 133) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 131.5) => 0.1566613368,
         (c_span_lang > 131.5) => 0.0230728288,
         (c_span_lang = NULL) => 0.1008169605, 0.1008169605),
      (f_curraddrburglaryindex_i = NULL) => 0.0333241931, 0.0333241931),
   (r_D33_eviction_count_i = NULL) => 0.0022037399, 0.0022037399),
(r_C18_invalid_addrs_per_adl_i > 3.5) => -0.0300737372,
(r_C18_invalid_addrs_per_adl_i = NULL) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 8.7) => -0.0437645603,
   (C_INC_15K_P > 8.7) => 0.0621420094,
   (C_INC_15K_P = NULL) => 0.0020086181, 0.0020086181), -0.0041543797);

// Tree: 197 
wFDN_FLAPSD_lgt_197 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 2.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 1.5) => -0.0012505831,
   (f_inq_HighRiskCredit_count24_i > 1.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 129) => 0.1343492469,
      (f_curraddrcartheftindex_i > 129) => -0.0292357687,
      (f_curraddrcartheftindex_i = NULL) => 0.0731519748, 0.0731519748),
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0003943191, -0.0003943191),
(f_srchfraudsrchcountyr_i > 2.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 2.35) => 0.0626951904,
   (C_INC_25K_P > 2.35) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 3.5) => 0.0000666053,
      (f_srchaddrsrchcount_i > 3.5) => -0.0754871966,
      (f_srchaddrsrchcount_i = NULL) => -0.0479806115, -0.0479806115),
   (C_INC_25K_P = NULL) => -0.0311241768, -0.0311241768),
(f_srchfraudsrchcountyr_i = NULL) => -0.0134447088, -0.0017170625);

// Tree: 198 
wFDN_FLAPSD_lgt_198 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 6.5) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 6.5) => 0.0092411731,
   (f_assoccredbureaucount_i > 6.5) => 0.0940721865,
   (f_assoccredbureaucount_i = NULL) => 0.0099269282, 0.0099269282),
(f_inq_count_i > 6.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 0.0100536712,
   (f_srchunvrfdphonecount_i > 0.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 114.5) => -0.0580443785,
      (c_born_usa > 114.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 209.3) => 0.1467245429,
         (c_cpiall > 209.3) => -0.0346597098,
         (c_cpiall = NULL) => 0.0163284902, 0.0163284902),
      (c_born_usa = NULL) => -0.0383867506, -0.0383867506),
   (f_srchunvrfdphonecount_i = NULL) => -0.0136927596, -0.0136927596),
(f_inq_count_i = NULL) => 0.0184092616, 0.0068605985);

// Tree: 199 
wFDN_FLAPSD_lgt_199 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 874.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => -0.0063944165,
      (f_rel_criminal_count_i > 6.5) => -0.0593260525,
      (f_rel_criminal_count_i = NULL) => -0.0097555926, -0.0097555926),
   (r_pb_order_freq_d > 874.5) => 0.1178260129,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < c_white_col and c_white_col <= 33.35) => -0.0157354245,
      (c_white_col > 33.35) => 0.0247438417,
      (c_white_col = NULL) => 0.0393141037, 0.0100038617), -0.0014503648),
(f_inq_HighRiskCredit_count_i > 21.5) => 0.0893219566,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 15.75) => 0.0593563254,
   (c_hh3_p > 15.75) => -0.0456601853,
   (c_hh3_p = NULL) => 0.0068480700, 0.0068480700), -0.0010127996);

// Tree: 200 
wFDN_FLAPSD_lgt_200 := map(
(NULL < c_child and c_child <= 37.95) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => -0.0069836071,
   (f_util_adl_count_n > 3.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 25.05) => 0.0107434705,
      (C_INC_75K_P > 25.05) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => 0.1475244500,
         (f_rel_incomeover75_count_d > 1.5) => 0.0223375404,
         (f_rel_incomeover75_count_d = NULL) => 0.0851671969, 0.0851671969),
      (C_INC_75K_P = NULL) => 0.0201957757, 0.0201957757),
   (f_util_adl_count_n = NULL) => -0.0178807891, -0.0023567594),
(c_child > 37.95) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 13.05) => -0.0077327434,
   (C_INC_25K_P > 13.05) => 0.1660623156,
   (C_INC_25K_P = NULL) => 0.0509925277, 0.0509925277),
(c_child = NULL) => 0.0022090190, -0.0013345696);

// Tree: 201 
wFDN_FLAPSD_lgt_201 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 54.45) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 194.5) => 0.0021536317,
      (f_curraddrcartheftindex_i > 194.5) => 0.1193118323,
      (f_curraddrcartheftindex_i = NULL) => 0.0030303893, 0.0030303893),
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < c_assault and c_assault <= 42.5) => -0.0547237199,
      (c_assault > 42.5) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 124.5) => 0.1553278478,
         (c_bel_edu > 124.5) => 0.0066001275,
         (c_bel_edu = NULL) => 0.0976579154, 0.0976579154),
      (c_assault = NULL) => 0.0514378933, 0.0514378933),
   (f_varrisktype_i = NULL) => 0.0067843377, 0.0040546726),
(C_RENTOCC_P > 54.45) => -0.0214372491,
(C_RENTOCC_P = NULL) => -0.0343663709, -0.0009491105);

// Tree: 202 
wFDN_FLAPSD_lgt_202 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 105) => -0.0018238342,
(f_addrchangecrimediff_i > 105) => -0.0815724032,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 40.5) => -0.0410166535,
   (c_serv_empl > 40.5) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 12.25) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 408.5) => 0.0092256925,
         (f_M_Bureau_ADL_FS_all_d > 408.5) => 0.1214294111,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0108218901, 0.0161097841),
      (c_pop_6_11_p > 12.25) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 8.45) => 0.0418789284,
         (c_hval_150k_p > 8.45) => 0.2606221737,
         (c_hval_150k_p = NULL) => 0.1369846872, 0.1369846872),
      (c_pop_6_11_p = NULL) => 0.0229776764, 0.0229776764),
   (c_serv_empl = NULL) => -0.0034899670, 0.0068331613), -0.0002390154);

// Tree: 203 
wFDN_FLAPSD_lgt_203 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 3.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 145.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 0.0145668479,
      (r_Ever_Asset_Owner_d > 0.5) => -0.0196007615,
      (r_Ever_Asset_Owner_d = NULL) => -0.0104015080, -0.0104015080),
   (f_prevaddrageoldest_d > 145.5) => 0.0211631531,
   (f_prevaddrageoldest_d = NULL) => -0.0025580139, -0.0025580139),
(f_inq_HighRiskCredit_count24_i > 3.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 10.45) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 14.95) => -0.0712256532,
      (c_pop_25_34_p > 14.95) => 0.0737921190,
      (c_pop_25_34_p = NULL) => 0.0019737937, 0.0019737937),
   (C_INC_125K_P > 10.45) => 0.1255570828,
   (C_INC_125K_P = NULL) => 0.0501137959, 0.0501137959),
(f_inq_HighRiskCredit_count24_i = NULL) => 0.0113765719, -0.0017361660);

// Tree: 204 
wFDN_FLAPSD_lgt_204 := map(
(NULL < c_hval_125k_p and c_hval_125k_p <= 43.85) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 14.45) => 0.0012642041,
   (C_INC_25K_P > 14.45) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 5.5) => 
         map(
         (NULL < c_retired and c_retired <= 3.35) => 0.0682856165,
         (c_retired > 3.35) => -0.0296333068,
         (c_retired = NULL) => -0.0210661552, -0.0210661552),
      (k_inq_per_addr_i > 5.5) => -0.0817135969,
      (k_inq_per_addr_i = NULL) => -0.0252739192, -0.0252739192),
   (C_INC_25K_P = NULL) => -0.0025035008, -0.0025035008),
(c_hval_125k_p > 43.85) => 
   map(
   (NULL < c_white_col and c_white_col <= 36.05) => 0.1938566268,
   (c_white_col > 36.05) => 0.0004372235,
   (c_white_col = NULL) => 0.0891617204, 0.0891617204),
(c_hval_125k_p = NULL) => 0.0093350856, -0.0014433213);

// Tree: 205 
wFDN_FLAPSD_lgt_205 := map(
(NULL < f_srchaddrsrchcountwk_i and f_srchaddrsrchcountwk_i <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.09382681685) => 0.0212505434,
   (f_add_curr_nhood_MFD_pct_i > 0.09382681685) => -0.0044325236,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 76.5) => 0.1690620683,
      (f_mos_liens_unrel_CJ_lseen_d > 76.5) => -0.0233949447,
      (f_mos_liens_unrel_CJ_lseen_d = NULL) => -0.0194848062, -0.0194848062), 0.0007021409),
(f_srchaddrsrchcountwk_i > 0.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 115.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 8.65) => 0.0296730561,
      (c_famotf18_p > 8.65) => 0.1697928307,
      (c_famotf18_p = NULL) => 0.1058785475, 0.1058785475),
   (c_new_homes > 115.5) => -0.0232956693,
   (c_new_homes = NULL) => 0.0448796118, 0.0448796118),
(f_srchaddrsrchcountwk_i = NULL) => 0.0228175754, 0.0016444157);

// Tree: 206 
wFDN_FLAPSD_lgt_206 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -168409) => -0.0647580137,
(f_addrchangevaluediff_d > -168409) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 18.5) => 0.0009140856,
   (k_inq_per_addr_i > 18.5) => 0.0971065805,
   (k_inq_per_addr_i = NULL) => 0.0014382954, 0.0014382954),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 1049.15) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => -0.0316794177,
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 29.05) => 0.0072203492,
         (C_INC_75K_P > 29.05) => 0.1719678571,
         (C_INC_75K_P = NULL) => 0.0129298771, 0.0129298771),
      (nf_seg_FraudPoint_3_0 = '') => -0.0014384065, -0.0014384065),
   (c_oldhouse > 1049.15) => 0.1467571799,
   (c_oldhouse = NULL) => -0.0083967909, 0.0003072660), 0.0004296951);

// Tree: 207 
wFDN_FLAPSD_lgt_207 := map(
(NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 3.5) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 23.45) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => -0.0043953918,
      (f_inq_PrepaidCards_count_i > 2.5) => 0.0814833776,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0039980056, -0.0039980056),
   (C_INC_35K_P > 23.45) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.05) => -0.0544541857,
      (c_pop_35_44_p > 12.05) => 0.1448170719,
      (c_pop_35_44_p = NULL) => 0.0708020333, 0.0708020333),
   (C_INC_35K_P = NULL) => 0.0011213940, -0.0030373146),
(f_hh_workers_paw_d > 3.5) => -0.0750756708,
(f_hh_workers_paw_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 104.5) => -0.0453768080,
   (c_no_teens > 104.5) => 0.0573793816,
   (c_no_teens = NULL) => 0.0069354340, 0.0069354340), -0.0045662100);

// Tree: 208 
wFDN_FLAPSD_lgt_208 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 15.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -22.5) => -0.0425740020,
   (f_addrchangecrimediff_i > -22.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => -0.0064607461,
      (r_C23_inp_addr_occ_index_d > 2) => 
         map(
         (NULL < C_INC_201K_P and C_INC_201K_P <= 6.25) => 
            map(
            (NULL < c_old_homes and c_old_homes <= 144.5) => 0.0355587146,
            (c_old_homes > 144.5) => 0.1097315463,
            (c_old_homes = NULL) => 0.0512875067, 0.0512875067),
         (C_INC_201K_P > 6.25) => -0.0265469641,
         (C_INC_201K_P = NULL) => 0.0267776844, 0.0267776844),
      (r_C23_inp_addr_occ_index_d = NULL) => -0.0016428614, -0.0016428614),
   (f_addrchangecrimediff_i = NULL) => 0.0030231961, -0.0017704258),
(k_inq_per_ssn_i > 15.5) => 0.0821938293,
(k_inq_per_ssn_i = NULL) => -0.0013137026, -0.0013137026);

// Tree: 209 
wFDN_FLAPSD_lgt_209 := map(
(NULL < nf_altlexid_addr_hi_no_hi_lexid and nf_altlexid_addr_hi_no_hi_lexid <= 0.5) => 
   map(
   (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 0.0015366478,
   (k_inq_addrs_per_ssn_i > 2.5) => 0.0903988332,
   (k_inq_addrs_per_ssn_i = NULL) => 0.0020801923, 0.0020801923),
(nf_altlexid_addr_hi_no_hi_lexid > 0.5) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 19.85) => 
      map(
      (NULL < c_food and c_food <= 26.95) => -0.0302441840,
      (c_food > 26.95) => -0.1103687077,
      (c_food = NULL) => -0.0531644204, -0.0531644204),
   (c_hval_175k_p > 19.85) => 0.0659730628,
   (c_hval_175k_p = NULL) => -0.0399269222, -0.0399269222),
(nf_altlexid_addr_hi_no_hi_lexid = NULL) => 
   map(
   (NULL < c_families and c_families <= 379.5) => -0.0462562743,
   (c_families > 379.5) => 0.0629515412,
   (c_families = NULL) => 0.0113811839, 0.0113811839), 0.0005893237);

// Tree: 210 
wFDN_FLAPSD_lgt_210 := map(
(NULL < c_incollege and c_incollege <= 7.95) => -0.0097269481,
(c_incollege > 7.95) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => 0.0053033707,
   (f_srchphonesrchcount_i > 1.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 14.25) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 25.65) => 0.0234573276,
         (c_hval_250k_p > 25.65) => 0.2024062790,
         (c_hval_250k_p = NULL) => 0.0418567223, 0.0418567223),
      (c_pop_55_64_p > 14.25) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 5.25) => 0.0801318079,
         (c_hval_300k_p > 5.25) => 0.3382238719,
         (c_hval_300k_p = NULL) => 0.1910474056, 0.1910474056),
      (c_pop_55_64_p = NULL) => 0.0667905243, 0.0667905243),
   (f_srchphonesrchcount_i = NULL) => 0.0184623122, 0.0184623122),
(c_incollege = NULL) => 0.0115070775, -0.0016296274);

// Tree: 211 
wFDN_FLAPSD_lgt_211 := map(
(NULL < c_food and c_food <= 40.75) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5731) => -0.0066272491,
   (f_liens_unrel_SC_total_amt_i > 5731) => 0.1247517633,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0147319049, -0.0057932200),
(c_food > 40.75) => 
   map(
   (NULL < c_families and c_families <= 635.5) => 
      map(
      (NULL < c_assault and c_assault <= 168.5) => 0.0111015624,
      (c_assault > 168.5) => 
         map(
         (NULL < r_A41_Prop_Owner_Inp_Only_d and r_A41_Prop_Owner_Inp_Only_d <= 0.5) => 0.2067594771,
         (r_A41_Prop_Owner_Inp_Only_d > 0.5) => 0.0174891922,
         (r_A41_Prop_Owner_Inp_Only_d = NULL) => 0.1062430546, 0.1062430546),
      (c_assault = NULL) => 0.0225236463, 0.0225236463),
   (c_families > 635.5) => 0.1916650202,
   (c_families = NULL) => 0.0315445195, 0.0315445195),
(c_food = NULL) => -0.0123742728, -0.0013030612);

// Tree: 212 
wFDN_FLAPSD_lgt_212 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 841775.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 74.05) => -0.0623695766,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 74.05) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0020610636,
      (f_varrisktype_i > 2.5) => 
         map(
         (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 0.1403006751,
         (r_I60_inq_banking_recency_d > 9) => 0.0122561848,
         (r_I60_inq_banking_recency_d = NULL) => 0.0484759410, 0.0484759410),
      (f_varrisktype_i = NULL) => 0.0002183233, 0.0002183233),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0006263354, -0.0010270013),
(f_curraddrmedianvalue_d > 841775.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1929405544,
   (k_nap_phn_verd_d > 0.5) => 0.0218143834,
   (k_nap_phn_verd_d = NULL) => 0.0851076247, 0.0851076247),
(f_curraddrmedianvalue_d = NULL) => 0.0254370754, 0.0002063836);

// Tree: 213 
wFDN_FLAPSD_lgt_213 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0013230446) => 0.1400976158,
(f_add_curr_nhood_MFD_pct_i > 0.0013230446) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0870281352,
   (f_attr_arrest_recency_d > 79.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 3.55) => -0.0293849130,
      (C_INC_125K_P > 3.55) => 
         map(
         (NULL < c_unempl and c_unempl <= 175.5) => 0.0009005869,
         (c_unempl > 175.5) => 0.0586408009,
         (c_unempl = NULL) => 0.0028795328, 0.0028795328),
      (C_INC_125K_P = NULL) => -0.0212876488, -0.0010662469),
   (f_attr_arrest_recency_d = NULL) => -0.0004163631, -0.0004163631),
(f_add_curr_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_has_relatives_n and f_has_relatives_n <= 0.5) => 0.0928319926,
   (f_has_relatives_n > 0.5) => -0.0142565995,
   (f_has_relatives_n = NULL) => -0.0117008858, -0.0117008858), -0.0016046067);

// Tree: 214 
wFDN_FLAPSD_lgt_214 := map(
(NULL < f_hh_age_30_plus_d and f_hh_age_30_plus_d <= 7.5) => 
   map(
   (NULL < f_mos_foreclosure_lseen_d and f_mos_foreclosure_lseen_d <= 18.5) => -0.1156573832,
   (f_mos_foreclosure_lseen_d > 18.5) => 
      map(
      (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => -0.0104828019,
      (f_util_add_input_misc_n > 0.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 5.55) => 0.0047103832,
         (c_hh6_p > 5.55) => 0.0490802287,
         (c_hh6_p = NULL) => -0.0297030631, 0.0100802974),
      (f_util_add_input_misc_n = NULL) => -0.0006623120, -0.0006623120),
   (f_mos_foreclosure_lseen_d = NULL) => -0.0011417270, -0.0011417270),
(f_hh_age_30_plus_d > 7.5) => -0.0784367810,
(f_hh_age_30_plus_d = NULL) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 25.85) => 0.0456642528,
   (c_hh1_p > 25.85) => -0.0720853772,
   (c_hh1_p = NULL) => -0.0132105622, -0.0132105622), -0.0018422029);

// Tree: 215 
wFDN_FLAPSD_lgt_215 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 135.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => -0.0343531874,
   (r_F01_inp_addr_address_score_d > 75) => -0.0071666708,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0090858935, -0.0090858935),
(f_prevaddrageoldest_d > 135.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < c_unattach and c_unattach <= 113.5) => -0.0108765701,
      (c_unattach > 113.5) => 0.1172646256,
      (c_unattach = NULL) => 0.0448369932, 0.0448369932),
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < nf_vf_lo_addr_add_entries and nf_vf_lo_addr_add_entries <= 1.5) => 0.0115241156,
      (nf_vf_lo_addr_add_entries > 1.5) => 0.1591044495,
      (nf_vf_lo_addr_add_entries = NULL) => 0.0143069564, 0.0143069564),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0153733123, 0.0153733123),
(f_prevaddrageoldest_d = NULL) => -0.0222795924, -0.0026196413);

// Tree: 216 
wFDN_FLAPSD_lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 225.5) => -0.0694426733,
(f_mos_liens_unrel_FT_lseen_d > 225.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 57.1) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -4902.5) => 
         map(
         (NULL < r_I60_inq_auto_recency_d and r_I60_inq_auto_recency_d <= 9) => 0.2016865910,
         (r_I60_inq_auto_recency_d > 9) => -0.0239858636,
         (r_I60_inq_auto_recency_d = NULL) => -0.0172893516, -0.0172893516),
      (r_A49_Curr_AVM_Chg_1yr_i > -4902.5) => 0.0134618847,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0084912669, -0.0024398962),
   (c_hval_500k_p > 57.1) => 0.1058145873,
   (c_hval_500k_p = NULL) => 0.0049487467, -0.0018363025),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 308) => -0.0564177794,
   (c_employees > 308) => 0.0395583689,
   (c_employees = NULL) => -0.0032881259, -0.0032881259), -0.0027717196);

// Tree: 217 
wFDN_FLAPSD_lgt_217 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 44.5) => -0.0851606411,
(f_mos_inq_banko_am_lseen_d > 44.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 20.95) => -0.0069357569,
   (c_hh3_p > 20.95) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 9.5) => 0.0123708405,
      (f_srchaddrsrchcount_i > 9.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 64.5) => 0.1374955051,
         (c_old_homes > 64.5) => 
            map(
            (NULL < c_retired and c_retired <= 9.85) => -0.0778078363,
            (c_retired > 9.85) => 0.0958143341,
            (c_retired = NULL) => -0.0009838671, -0.0009838671),
         (c_old_homes = NULL) => 0.0619004855, 0.0619004855),
      (f_srchaddrsrchcount_i = NULL) => 0.0159924005, 0.0159924005),
   (c_hh3_p = NULL) => 0.0365109810, -0.0007528413),
(f_mos_inq_banko_am_lseen_d = NULL) => -0.0239953422, -0.0029809163);

// Tree: 218 
wFDN_FLAPSD_lgt_218 := map(
(NULL < f_mos_liens_unrel_OT_lseen_d and f_mos_liens_unrel_OT_lseen_d <= 28.5) => -0.0842380182,
(f_mos_liens_unrel_OT_lseen_d > 28.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 10.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 12.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 14.5) => 0.0011820502,
         (r_D30_Derog_Count_i > 14.5) => 0.0657378106,
         (r_D30_Derog_Count_i = NULL) => 0.0015589265, 0.0015589265),
      (k_inq_per_phone_i > 12.5) => -0.0728934194,
      (k_inq_per_phone_i = NULL) => 0.0012403431, 0.0012403431),
   (f_hh_age_18_plus_d > 10.5) => -0.0782621832,
   (f_hh_age_18_plus_d = NULL) => 0.0007428144, 0.0007428144),
(f_mos_liens_unrel_OT_lseen_d = NULL) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 5.35) => 0.0557976839,
   (c_hval_750k_p > 5.35) => -0.0775108864,
   (c_hval_750k_p = NULL) => 0.0000703307, 0.0000703307), 0.0000731143);

// Tree: 219 
wFDN_FLAPSD_lgt_219 := map(
(NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 4.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 36.35) => -0.0133029418,
   (c_med_age > 36.35) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 33.5) => -0.0190959337,
      (f_prevaddrageoldest_d > 33.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 21.25) => 0.0173188497,
         (c_pop_25_34_p > 21.25) => 0.1689602897,
         (c_pop_25_34_p = NULL) => 0.0214240949, 0.0214240949),
      (f_prevaddrageoldest_d = NULL) => 0.0097431321, 0.0097431321),
   (c_med_age = NULL) => 0.0171095956, -0.0001488715),
(f_inq_Banking_count24_i > 4.5) => -0.0714117254,
(f_inq_Banking_count24_i = NULL) => 
   map(
   (NULL < c_retired and c_retired <= 10.65) => 0.0118687429,
   (c_retired > 10.65) => -0.0835649397,
   (c_retired = NULL) => -0.0376487339, -0.0376487339), -0.0011703805);

// Tree: 220 
wFDN_FLAPSD_lgt_220 := map(
(NULL < c_info and c_info <= 26.65) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 35.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 
         map(
         (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 162.5) => -0.1032476968,
         (f_mos_liens_unrel_SC_fseen_d > 162.5) => -0.0181670394,
         (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0208355686, -0.0208355686),
      (r_L79_adls_per_addr_curr_i > 1.5) => 
         map(
         (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 0.0256402951,
         (r_Ever_Asset_Owner_d > 0.5) => -0.0019706623,
         (r_Ever_Asset_Owner_d = NULL) => 0.0028891071, 0.0028891071),
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0029548029, -0.0029548029),
   (f_srchaddrsrchcount_i > 35.5) => -0.0803606030,
   (f_srchaddrsrchcount_i = NULL) => -0.0174470935, -0.0035103430),
(c_info > 26.65) => 0.1785562293,
(c_info = NULL) => -0.0202787016, -0.0028274267);

// Tree: 221 
wFDN_FLAPSD_lgt_221 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => 
   map(
   (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0047050841,
   (f_phones_per_addr_c6_i > 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => 0.0126413163,
      (k_inq_per_phone_i > 1.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.5217676716) => 0.0893507708,
         (f_add_curr_nhood_MFD_pct_i > 0.5217676716) => -0.0475639049,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1022594324, 0.0519951675),
      (k_inq_per_phone_i = NULL) => 0.0169034663, 0.0169034663),
   (f_phones_per_addr_c6_i = NULL) => 0.0028869611, 0.0028869611),
(f_vardobcount_i > 2.5) => -0.0406759056,
(f_vardobcount_i = NULL) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.15) => -0.0541144091,
   (c_pop_0_5_p > 8.15) => 0.0393012953,
   (c_pop_0_5_p = NULL) => -0.0120352630, -0.0120352630), 0.0001921160);

// Tree: 222 
wFDN_FLAPSD_lgt_222 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 70.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 169.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 28.65) => 0.0353129650,
         (c_hval_250k_p > 28.65) => 0.1618931378,
         (c_hval_250k_p = NULL) => 0.0483070358, 0.0483070358),
      (f_M_Bureau_ADL_FS_all_d > 169.5) => 0.0019069822,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0131711805, 0.0131711805),
   (f_mos_inq_banko_cm_fseen_d > 70.5) => -0.0092195913,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0077162227, -0.0047356619),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 7.25) => -0.0163363919,
   (c_pop_12_17_p > 7.25) => 0.1737092252,
   (c_pop_12_17_p = NULL) => 0.0924483406, 0.0924483406),
(f_nae_nothing_found_i = NULL) => -0.0036171073, -0.0036171073);

// Tree: 223 
wFDN_FLAPSD_lgt_223 := map(
(NULL < r_C20_email_count_i and r_C20_email_count_i <= 10.5) => 
   map(
   (NULL < c_young and c_young <= 29.65) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
         map(
         (NULL < c_amus_indx and c_amus_indx <= 143.5) => 0.0082604096,
         (c_amus_indx > 143.5) => -0.0780184573,
         (c_amus_indx = NULL) => 0.0049596336, 0.0049596336),
      (f_hh_collections_ct_i > 4.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 55.5) => 0.1963698834,
         (r_C13_Curr_Addr_LRes_d > 55.5) => -0.0032537292,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0779265400, 0.0779265400),
      (f_hh_collections_ct_i = NULL) => 0.0060830080, 0.0060830080),
   (c_young > 29.65) => -0.0205535151,
   (c_young = NULL) => 0.0032401011, 0.0007917296),
(r_C20_email_count_i > 10.5) => 0.1300036124,
(r_C20_email_count_i = NULL) => -0.0043569106, 0.0017029611);

// Tree: 224 
wFDN_FLAPSD_lgt_224 := map(
(NULL < c_lowrent and c_lowrent <= 80.85) => 
   map(
   (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => -0.0152991674,
   (f_util_add_curr_misc_n > 0.5) => 0.0071288260,
   (f_util_add_curr_misc_n = NULL) => -0.0046801300, -0.0046801300),
(c_lowrent > 80.85) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 5.75) => 0.1675442796,
   (c_pop_6_11_p > 5.75) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 72) => 0.1511150831,
      (r_C13_max_lres_d > 72) => -0.0079390227,
      (r_C13_max_lres_d = NULL) => 0.0136760224, 0.0136760224),
   (c_pop_6_11_p = NULL) => 0.0402945817, 0.0402945817),
(c_lowrent = NULL) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 23.5) => 0.1568886262,
   (f_mos_inq_banko_cm_lseen_d > 23.5) => -0.0519746561,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0139995139, -0.0139995139), -0.0032052711);

// Tree: 225 
wFDN_FLAPSD_lgt_225 := map(
(NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 120.5) => 
   map(
   (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => -0.0594361492,
   (f_inq_Collection_count24_i > 1.5) => 
      map(
      (NULL < c_rape and c_rape <= 89.5) => 0.1324731462,
      (c_rape > 89.5) => -0.0427217895,
      (c_rape = NULL) => 0.0441004795, 0.0441004795),
   (f_inq_Collection_count24_i = NULL) => -0.0386192609, -0.0386192609),
(f_mos_liens_unrel_CJ_lseen_d > 120.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0183858895,
   (f_phone_ver_experian_d > 0.5) => -0.0093460865,
   (f_phone_ver_experian_d = NULL) => -0.0048390129, 0.0006513438),
(f_mos_liens_unrel_CJ_lseen_d = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 81.5) => -0.0622173537,
   (c_bel_edu > 81.5) => 0.0690361832,
   (c_bel_edu = NULL) => 0.0003427433, 0.0003427433), -0.0011066679);

// Tree: 226 
wFDN_FLAPSD_lgt_226 := map(
(NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 2.5) => 
   map(
   (NULL < r_C22_stl_inq_Count24_i and r_C22_stl_inq_Count24_i <= 0.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 0.0059938768,
      (r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0604186746,
      (r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 0.0044521861, 0.0044521861),
   (r_C22_stl_inq_Count24_i > 0.5) => -0.0676985360,
   (r_C22_stl_inq_Count24_i = NULL) => 0.0039409373, 0.0039409373),
(f_hh_age_65_plus_d > 2.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 116.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1971) => 0.0596221817,
      (c_med_yearblt > 1971) => 0.3015580444,
      (c_med_yearblt = NULL) => 0.1688835391, 0.1688835391),
   (c_easiqlife > 116.5) => 0.0094971017,
   (c_easiqlife = NULL) => 0.0793342686, 0.0793342686),
(f_hh_age_65_plus_d = NULL) => -0.0004336440, 0.0056682227);

// Tree: 227 
wFDN_FLAPSD_lgt_227 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0005091348,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 7.5) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 141.5) => 
            map(
            (NULL < c_rich_old and c_rich_old <= 145.5) => -0.0035496468,
            (c_rich_old > 145.5) => 0.1374090630,
            (c_rich_old = NULL) => 0.0326482092, 0.0326482092),
         (c_lar_fam > 141.5) => 0.1553054582,
         (c_lar_fam = NULL) => 0.0584091589, 0.0584091589),
      (f_rel_homeover300_count_d > 7.5) => -0.0605522427,
      (f_rel_homeover300_count_d = NULL) => 0.0361181123, 0.0361181123),
   (f_hh_tot_derog_i = NULL) => 0.0010307406, 0.0010307406),
(f_hh_criminals_i > 3.5) => -0.0815541114,
(f_hh_criminals_i = NULL) => 0.0054547603, 0.0002313508);

// Tree: 228 
wFDN_FLAPSD_lgt_228 := map(
(NULL < c_lowinc and c_lowinc <= 77.15) => 
   map(
   (NULL < r_C22_stl_inq_Count24_i and r_C22_stl_inq_Count24_i <= 0.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 184.5) => -0.0037297906,
      (c_unempl > 184.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 89.05) => 
            map(
            (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 0.5) => 0.2020084678,
            (f_hh_members_w_derog_i > 0.5) => 0.0257690868,
            (f_hh_members_w_derog_i = NULL) => 0.0905629769, 0.0905629769),
         (c_occunit_p > 89.05) => -0.0208318953,
         (c_occunit_p = NULL) => 0.0468007057, 0.0468007057),
      (c_unempl = NULL) => -0.0027965866, -0.0027965866),
   (r_C22_stl_inq_Count24_i > 0.5) => -0.0633777833,
   (r_C22_stl_inq_Count24_i = NULL) => -0.0012068277, -0.0032166710),
(c_lowinc > 77.15) => -0.1016371780,
(c_lowinc = NULL) => 0.0092934643, -0.0035611047);

// Tree: 229 
wFDN_FLAPSD_lgt_229 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 377) => -0.0103501800,
(r_pb_order_freq_d > 377) => 
   map(
   (NULL < c_health and c_health <= 28.65) => 0.0148512432,
   (c_health > 28.65) => 0.2331290016,
   (c_health = NULL) => 0.0347301105, 0.0347301105),
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1676.5) => 0.0014444388,
   (c_popover25 > 1676.5) => 
      map(
      (NULL < c_families and c_families <= 829.5) => 
         map(
         (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 0.0521264236,
         (f_hh_lienholders_i > 0.5) => 0.1518009897,
         (f_hh_lienholders_i = NULL) => 0.0833677056, 0.0833677056),
      (c_families > 829.5) => 0.0086540695,
      (c_families = NULL) => 0.0475202539, 0.0475202539),
   (c_popover25 = NULL) => 0.0265149795, 0.0101076061), -0.0006142785);

// Tree: 230 
wFDN_FLAPSD_lgt_230 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 196.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 13.75) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 35.5) => 0.1000021075,
      (f_mos_liens_unrel_SC_fseen_d > 35.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 33.55) => -0.0016778071,
         (C_INC_75K_P > 33.55) => 0.0889569814,
         (C_INC_75K_P = NULL) => -0.0009122849, -0.0009122849),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0002583033, -0.0002583033),
   (c_hh7p_p > 13.75) => -0.0680557108,
   (c_hh7p_p = NULL) => 0.0029241592, -0.0010313963),
(f_curraddrburglaryindex_i > 196.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 31433.5) => 0.1848633066,
   (f_curraddrmedianincome_d > 31433.5) => -0.0149697652,
   (f_curraddrmedianincome_d = NULL) => 0.0839767072, 0.0839767072),
(f_curraddrburglaryindex_i = NULL) => 0.0027936071, -0.0003058653);

// Tree: 231 
wFDN_FLAPSD_lgt_231 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 7.5) => -0.0050372651,
(f_srchaddrsrchcount_i > 7.5) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0052255235) => -0.0424793645,
   (f_add_input_nhood_BUS_pct_i > 0.0052255235) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 19.5) => 
         map(
         (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 0.0019530470,
         (f_hh_lienholders_i > 0.5) => 
            map(
            (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 209268) => 0.0511083578,
            (r_L80_Inp_AVM_AutoVal_d > 209268) => -0.0200500578,
            (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.1115026011, 0.0599166359),
         (f_hh_lienholders_i = NULL) => 0.0287153699, 0.0287153699),
      (f_rel_under25miles_cnt_d > 19.5) => -0.0802475826,
      (f_rel_under25miles_cnt_d = NULL) => 0.0226618726, 0.0226618726),
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.1247932000, 0.0198518622),
(f_srchaddrsrchcount_i = NULL) => -0.0356363361, -0.0030437927);

// Tree: 232 
wFDN_FLAPSD_lgt_232 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.35) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 1.5) => -0.0010165831,
   (f_inq_Other_count24_i > 1.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 3.15) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 4.5) => 0.0596839693,
         (r_D30_Derog_Count_i > 4.5) => 0.1797489474,
         (r_D30_Derog_Count_i = NULL) => 0.0749594118, 0.0749594118),
      (c_bigapt_p > 3.15) => -0.0265359693,
      (c_bigapt_p = NULL) => 0.0303651502, 0.0303651502),
   (f_inq_Other_count24_i = NULL) => 
      map(
      (NULL < c_larceny and c_larceny <= 94.5) => -0.0836805612,
      (c_larceny > 94.5) => 0.0559629515,
      (c_larceny = NULL) => -0.0229659905, -0.0229659905), 0.0005655449),
(c_pop_0_5_p > 19.35) => 0.1138238571,
(c_pop_0_5_p = NULL) => -0.0186565297, 0.0008312864);

// Tree: 233 
wFDN_FLAPSD_lgt_233 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 17.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 24.85) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0484142567,
      (f_mos_inq_banko_om_fseen_d > 5.5) => 
         map(
         (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 6.5) => 0.0036036483,
         (f_crim_rel_under25miles_cnt_i > 6.5) => -0.0580780110,
         (f_crim_rel_under25miles_cnt_i = NULL) => -0.0073375538, 0.0021078129),
      (f_mos_inq_banko_om_fseen_d = NULL) => -0.0134016681, -0.0003037097),
   (c_hval_20k_p > 24.85) => 
      map(
      (NULL < c_rental and c_rental <= 131.5) => -0.0146485565,
      (c_rental > 131.5) => 0.1944686326,
      (c_rental = NULL) => 0.0708993845, 0.0708993845),
   (c_hval_20k_p = NULL) => -0.0026624893, 0.0003894464),
(k_inq_per_addr_i > 17.5) => -0.0728381375,
(k_inq_per_addr_i = NULL) => -0.0001416484, -0.0001416484);

// Tree: 234 
wFDN_FLAPSD_lgt_234 := map(
(NULL < c_unempl and c_unempl <= 188.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 71.1) => 0.0154107247,
      (c_lowrent > 71.1) => 
         map(
         (NULL < c_retired and c_retired <= 11.85) => -0.0160506211,
         (c_retired > 11.85) => 0.1755983514,
         (c_retired = NULL) => 0.1048189013, 0.1048189013),
      (c_lowrent = NULL) => 0.0211747683, 0.0211747683),
   (f_hh_age_18_plus_d > 1.5) => -0.0033984833,
   (f_hh_age_18_plus_d = NULL) => 0.0170834575, 0.0022615182),
(c_unempl > 188.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 0.0173374142,
   (r_C12_Num_NonDerogs_d > 2.5) => -0.1078771002,
   (r_C12_Num_NonDerogs_d = NULL) => -0.0587131191, -0.0587131191),
(c_unempl = NULL) => -0.0048437369, 0.0013298046);

// Final Score Sum 

   wFDN_FLAPSD_lgt := sum(
      wFDN_FLAPSD_lgt_0, wFDN_FLAPSD_lgt_1, wFDN_FLAPSD_lgt_2, wFDN_FLAPSD_lgt_3, wFDN_FLAPSD_lgt_4, 
      wFDN_FLAPSD_lgt_5, wFDN_FLAPSD_lgt_6, wFDN_FLAPSD_lgt_7, wFDN_FLAPSD_lgt_8, wFDN_FLAPSD_lgt_9, 
      wFDN_FLAPSD_lgt_10, wFDN_FLAPSD_lgt_11, wFDN_FLAPSD_lgt_12, wFDN_FLAPSD_lgt_13, wFDN_FLAPSD_lgt_14, 
      wFDN_FLAPSD_lgt_15, wFDN_FLAPSD_lgt_16, wFDN_FLAPSD_lgt_17, wFDN_FLAPSD_lgt_18, wFDN_FLAPSD_lgt_19, 
      wFDN_FLAPSD_lgt_20, wFDN_FLAPSD_lgt_21, wFDN_FLAPSD_lgt_22, wFDN_FLAPSD_lgt_23, wFDN_FLAPSD_lgt_24, 
      wFDN_FLAPSD_lgt_25, wFDN_FLAPSD_lgt_26, wFDN_FLAPSD_lgt_27, wFDN_FLAPSD_lgt_28, wFDN_FLAPSD_lgt_29, 
      wFDN_FLAPSD_lgt_30, wFDN_FLAPSD_lgt_31, wFDN_FLAPSD_lgt_32, wFDN_FLAPSD_lgt_33, wFDN_FLAPSD_lgt_34, 
      wFDN_FLAPSD_lgt_35, wFDN_FLAPSD_lgt_36, wFDN_FLAPSD_lgt_37, wFDN_FLAPSD_lgt_38, wFDN_FLAPSD_lgt_39, 
      wFDN_FLAPSD_lgt_40, wFDN_FLAPSD_lgt_41, wFDN_FLAPSD_lgt_42, wFDN_FLAPSD_lgt_43, wFDN_FLAPSD_lgt_44, 
      wFDN_FLAPSD_lgt_45, wFDN_FLAPSD_lgt_46, wFDN_FLAPSD_lgt_47, wFDN_FLAPSD_lgt_48, wFDN_FLAPSD_lgt_49, 
      wFDN_FLAPSD_lgt_50, wFDN_FLAPSD_lgt_51, wFDN_FLAPSD_lgt_52, wFDN_FLAPSD_lgt_53, wFDN_FLAPSD_lgt_54, 
      wFDN_FLAPSD_lgt_55, wFDN_FLAPSD_lgt_56, wFDN_FLAPSD_lgt_57, wFDN_FLAPSD_lgt_58, wFDN_FLAPSD_lgt_59, 
      wFDN_FLAPSD_lgt_60, wFDN_FLAPSD_lgt_61, wFDN_FLAPSD_lgt_62, wFDN_FLAPSD_lgt_63, wFDN_FLAPSD_lgt_64, 
      wFDN_FLAPSD_lgt_65, wFDN_FLAPSD_lgt_66, wFDN_FLAPSD_lgt_67, wFDN_FLAPSD_lgt_68, wFDN_FLAPSD_lgt_69, 
      wFDN_FLAPSD_lgt_70, wFDN_FLAPSD_lgt_71, wFDN_FLAPSD_lgt_72, wFDN_FLAPSD_lgt_73, wFDN_FLAPSD_lgt_74, 
      wFDN_FLAPSD_lgt_75, wFDN_FLAPSD_lgt_76, wFDN_FLAPSD_lgt_77, wFDN_FLAPSD_lgt_78, wFDN_FLAPSD_lgt_79, 
      wFDN_FLAPSD_lgt_80, wFDN_FLAPSD_lgt_81, wFDN_FLAPSD_lgt_82, wFDN_FLAPSD_lgt_83, wFDN_FLAPSD_lgt_84, 
      wFDN_FLAPSD_lgt_85, wFDN_FLAPSD_lgt_86, wFDN_FLAPSD_lgt_87, wFDN_FLAPSD_lgt_88, wFDN_FLAPSD_lgt_89, 
      wFDN_FLAPSD_lgt_90, wFDN_FLAPSD_lgt_91, wFDN_FLAPSD_lgt_92, wFDN_FLAPSD_lgt_93, wFDN_FLAPSD_lgt_94, 
      wFDN_FLAPSD_lgt_95, wFDN_FLAPSD_lgt_96, wFDN_FLAPSD_lgt_97, wFDN_FLAPSD_lgt_98, wFDN_FLAPSD_lgt_99, 
      wFDN_FLAPSD_lgt_100, wFDN_FLAPSD_lgt_101, wFDN_FLAPSD_lgt_102, wFDN_FLAPSD_lgt_103, wFDN_FLAPSD_lgt_104, 
      wFDN_FLAPSD_lgt_105, wFDN_FLAPSD_lgt_106, wFDN_FLAPSD_lgt_107, wFDN_FLAPSD_lgt_108, wFDN_FLAPSD_lgt_109, 
      wFDN_FLAPSD_lgt_110, wFDN_FLAPSD_lgt_111, wFDN_FLAPSD_lgt_112, wFDN_FLAPSD_lgt_113, wFDN_FLAPSD_lgt_114, 
      wFDN_FLAPSD_lgt_115, wFDN_FLAPSD_lgt_116, wFDN_FLAPSD_lgt_117, wFDN_FLAPSD_lgt_118, wFDN_FLAPSD_lgt_119, 
      wFDN_FLAPSD_lgt_120, wFDN_FLAPSD_lgt_121, wFDN_FLAPSD_lgt_122, wFDN_FLAPSD_lgt_123, wFDN_FLAPSD_lgt_124, 
      wFDN_FLAPSD_lgt_125, wFDN_FLAPSD_lgt_126, wFDN_FLAPSD_lgt_127, wFDN_FLAPSD_lgt_128, wFDN_FLAPSD_lgt_129, 
      wFDN_FLAPSD_lgt_130, wFDN_FLAPSD_lgt_131, wFDN_FLAPSD_lgt_132, wFDN_FLAPSD_lgt_133, wFDN_FLAPSD_lgt_134, 
      wFDN_FLAPSD_lgt_135, wFDN_FLAPSD_lgt_136, wFDN_FLAPSD_lgt_137, wFDN_FLAPSD_lgt_138, wFDN_FLAPSD_lgt_139, 
      wFDN_FLAPSD_lgt_140, wFDN_FLAPSD_lgt_141, wFDN_FLAPSD_lgt_142, wFDN_FLAPSD_lgt_143, wFDN_FLAPSD_lgt_144, 
      wFDN_FLAPSD_lgt_145, wFDN_FLAPSD_lgt_146, wFDN_FLAPSD_lgt_147, wFDN_FLAPSD_lgt_148, wFDN_FLAPSD_lgt_149, 
      wFDN_FLAPSD_lgt_150, wFDN_FLAPSD_lgt_151, wFDN_FLAPSD_lgt_152, wFDN_FLAPSD_lgt_153, wFDN_FLAPSD_lgt_154, 
      wFDN_FLAPSD_lgt_155, wFDN_FLAPSD_lgt_156, wFDN_FLAPSD_lgt_157, wFDN_FLAPSD_lgt_158, wFDN_FLAPSD_lgt_159, 
      wFDN_FLAPSD_lgt_160, wFDN_FLAPSD_lgt_161, wFDN_FLAPSD_lgt_162, wFDN_FLAPSD_lgt_163, wFDN_FLAPSD_lgt_164, 
      wFDN_FLAPSD_lgt_165, wFDN_FLAPSD_lgt_166, wFDN_FLAPSD_lgt_167, wFDN_FLAPSD_lgt_168, wFDN_FLAPSD_lgt_169, 
      wFDN_FLAPSD_lgt_170, wFDN_FLAPSD_lgt_171, wFDN_FLAPSD_lgt_172, wFDN_FLAPSD_lgt_173, wFDN_FLAPSD_lgt_174, 
      wFDN_FLAPSD_lgt_175, wFDN_FLAPSD_lgt_176, wFDN_FLAPSD_lgt_177, wFDN_FLAPSD_lgt_178, wFDN_FLAPSD_lgt_179, 
      wFDN_FLAPSD_lgt_180, wFDN_FLAPSD_lgt_181, wFDN_FLAPSD_lgt_182, wFDN_FLAPSD_lgt_183, wFDN_FLAPSD_lgt_184, 
      wFDN_FLAPSD_lgt_185, wFDN_FLAPSD_lgt_186, wFDN_FLAPSD_lgt_187, wFDN_FLAPSD_lgt_188, wFDN_FLAPSD_lgt_189, 
      wFDN_FLAPSD_lgt_190, wFDN_FLAPSD_lgt_191, wFDN_FLAPSD_lgt_192, wFDN_FLAPSD_lgt_193, wFDN_FLAPSD_lgt_194, 
      wFDN_FLAPSD_lgt_195, wFDN_FLAPSD_lgt_196, wFDN_FLAPSD_lgt_197, wFDN_FLAPSD_lgt_198, wFDN_FLAPSD_lgt_199, 
      wFDN_FLAPSD_lgt_200, wFDN_FLAPSD_lgt_201, wFDN_FLAPSD_lgt_202, wFDN_FLAPSD_lgt_203, wFDN_FLAPSD_lgt_204, 
      wFDN_FLAPSD_lgt_205, wFDN_FLAPSD_lgt_206, wFDN_FLAPSD_lgt_207, wFDN_FLAPSD_lgt_208, wFDN_FLAPSD_lgt_209, 
      wFDN_FLAPSD_lgt_210, wFDN_FLAPSD_lgt_211, wFDN_FLAPSD_lgt_212, wFDN_FLAPSD_lgt_213, wFDN_FLAPSD_lgt_214, 
      wFDN_FLAPSD_lgt_215, wFDN_FLAPSD_lgt_216, wFDN_FLAPSD_lgt_217, wFDN_FLAPSD_lgt_218, wFDN_FLAPSD_lgt_219, 
      wFDN_FLAPSD_lgt_220, wFDN_FLAPSD_lgt_221, wFDN_FLAPSD_lgt_222, wFDN_FLAPSD_lgt_223, wFDN_FLAPSD_lgt_224, 
      wFDN_FLAPSD_lgt_225, wFDN_FLAPSD_lgt_226, wFDN_FLAPSD_lgt_227, wFDN_FLAPSD_lgt_228, wFDN_FLAPSD_lgt_229, 
      wFDN_FLAPSD_lgt_230, wFDN_FLAPSD_lgt_231, wFDN_FLAPSD_lgt_232, wFDN_FLAPSD_lgt_233, wFDN_FLAPSD_lgt_234); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FLAPSD_lgt;
			
self.final_score_0	:= 	wFDN_FLAPSD_lgt_0	;
self.final_score_1	:= 	wFDN_FLAPSD_lgt_1	;
self.final_score_2	:= 	wFDN_FLAPSD_lgt_2	;
self.final_score_3	:= 	wFDN_FLAPSD_lgt_3	;
self.final_score_4	:= 	wFDN_FLAPSD_lgt_4	;
self.final_score_5	:= 	wFDN_FLAPSD_lgt_5	;
self.final_score_6	:= 	wFDN_FLAPSD_lgt_6	;
self.final_score_7	:= 	wFDN_FLAPSD_lgt_7	;
self.final_score_8	:= 	wFDN_FLAPSD_lgt_8	;
self.final_score_9	:= 	wFDN_FLAPSD_lgt_9	;
self.final_score_10	:= 	wFDN_FLAPSD_lgt_10	;
self.final_score_11	:= 	wFDN_FLAPSD_lgt_11	;
self.final_score_12	:= 	wFDN_FLAPSD_lgt_12	;
self.final_score_13	:= 	wFDN_FLAPSD_lgt_13	;
self.final_score_14	:= 	wFDN_FLAPSD_lgt_14	;
self.final_score_15	:= 	wFDN_FLAPSD_lgt_15	;
self.final_score_16	:= 	wFDN_FLAPSD_lgt_16	;
self.final_score_17	:= 	wFDN_FLAPSD_lgt_17	;
self.final_score_18	:= 	wFDN_FLAPSD_lgt_18	;
self.final_score_19	:= 	wFDN_FLAPSD_lgt_19	;
self.final_score_20	:= 	wFDN_FLAPSD_lgt_20	;
self.final_score_21	:= 	wFDN_FLAPSD_lgt_21	;
self.final_score_22	:= 	wFDN_FLAPSD_lgt_22	;
self.final_score_23	:= 	wFDN_FLAPSD_lgt_23	;
self.final_score_24	:= 	wFDN_FLAPSD_lgt_24	;
self.final_score_25	:= 	wFDN_FLAPSD_lgt_25	;
self.final_score_26	:= 	wFDN_FLAPSD_lgt_26	;
self.final_score_27	:= 	wFDN_FLAPSD_lgt_27	;
self.final_score_28	:= 	wFDN_FLAPSD_lgt_28	;
self.final_score_29	:= 	wFDN_FLAPSD_lgt_29	;
self.final_score_30	:= 	wFDN_FLAPSD_lgt_30	;
self.final_score_31	:= 	wFDN_FLAPSD_lgt_31	;
self.final_score_32	:= 	wFDN_FLAPSD_lgt_32	;
self.final_score_33	:= 	wFDN_FLAPSD_lgt_33	;
self.final_score_34	:= 	wFDN_FLAPSD_lgt_34	;
self.final_score_35	:= 	wFDN_FLAPSD_lgt_35	;
self.final_score_36	:= 	wFDN_FLAPSD_lgt_36	;
self.final_score_37	:= 	wFDN_FLAPSD_lgt_37	;
self.final_score_38	:= 	wFDN_FLAPSD_lgt_38	;
self.final_score_39	:= 	wFDN_FLAPSD_lgt_39	;
self.final_score_40	:= 	wFDN_FLAPSD_lgt_40	;
self.final_score_41	:= 	wFDN_FLAPSD_lgt_41	;
self.final_score_42	:= 	wFDN_FLAPSD_lgt_42	;
self.final_score_43	:= 	wFDN_FLAPSD_lgt_43	;
self.final_score_44	:= 	wFDN_FLAPSD_lgt_44	;
self.final_score_45	:= 	wFDN_FLAPSD_lgt_45	;
self.final_score_46	:= 	wFDN_FLAPSD_lgt_46	;
self.final_score_47	:= 	wFDN_FLAPSD_lgt_47	;
self.final_score_48	:= 	wFDN_FLAPSD_lgt_48	;
self.final_score_49	:= 	wFDN_FLAPSD_lgt_49	;
self.final_score_50	:= 	wFDN_FLAPSD_lgt_50	;
self.final_score_51	:= 	wFDN_FLAPSD_lgt_51	;
self.final_score_52	:= 	wFDN_FLAPSD_lgt_52	;
self.final_score_53	:= 	wFDN_FLAPSD_lgt_53	;
self.final_score_54	:= 	wFDN_FLAPSD_lgt_54	;
self.final_score_55	:= 	wFDN_FLAPSD_lgt_55	;
self.final_score_56	:= 	wFDN_FLAPSD_lgt_56	;
self.final_score_57	:= 	wFDN_FLAPSD_lgt_57	;
self.final_score_58	:= 	wFDN_FLAPSD_lgt_58	;
self.final_score_59	:= 	wFDN_FLAPSD_lgt_59	;
self.final_score_60	:= 	wFDN_FLAPSD_lgt_60	;
self.final_score_61	:= 	wFDN_FLAPSD_lgt_61	;
self.final_score_62	:= 	wFDN_FLAPSD_lgt_62	;
self.final_score_63	:= 	wFDN_FLAPSD_lgt_63	;
self.final_score_64	:= 	wFDN_FLAPSD_lgt_64	;
self.final_score_65	:= 	wFDN_FLAPSD_lgt_65	;
self.final_score_66	:= 	wFDN_FLAPSD_lgt_66	;
self.final_score_67	:= 	wFDN_FLAPSD_lgt_67	;
self.final_score_68	:= 	wFDN_FLAPSD_lgt_68	;
self.final_score_69	:= 	wFDN_FLAPSD_lgt_69	;
self.final_score_70	:= 	wFDN_FLAPSD_lgt_70	;
self.final_score_71	:= 	wFDN_FLAPSD_lgt_71	;
self.final_score_72	:= 	wFDN_FLAPSD_lgt_72	;
self.final_score_73	:= 	wFDN_FLAPSD_lgt_73	;
self.final_score_74	:= 	wFDN_FLAPSD_lgt_74	;
self.final_score_75	:= 	wFDN_FLAPSD_lgt_75	;
self.final_score_76	:= 	wFDN_FLAPSD_lgt_76	;
self.final_score_77	:= 	wFDN_FLAPSD_lgt_77	;
self.final_score_78	:= 	wFDN_FLAPSD_lgt_78	;
self.final_score_79	:= 	wFDN_FLAPSD_lgt_79	;
self.final_score_80	:= 	wFDN_FLAPSD_lgt_80	;
self.final_score_81	:= 	wFDN_FLAPSD_lgt_81	;
self.final_score_82	:= 	wFDN_FLAPSD_lgt_82	;
self.final_score_83	:= 	wFDN_FLAPSD_lgt_83	;
self.final_score_84	:= 	wFDN_FLAPSD_lgt_84	;
self.final_score_85	:= 	wFDN_FLAPSD_lgt_85	;
self.final_score_86	:= 	wFDN_FLAPSD_lgt_86	;
self.final_score_87	:= 	wFDN_FLAPSD_lgt_87	;
self.final_score_88	:= 	wFDN_FLAPSD_lgt_88	;
self.final_score_89	:= 	wFDN_FLAPSD_lgt_89	;
self.final_score_90	:= 	wFDN_FLAPSD_lgt_90	;
self.final_score_91	:= 	wFDN_FLAPSD_lgt_91	;
self.final_score_92	:= 	wFDN_FLAPSD_lgt_92	;
self.final_score_93	:= 	wFDN_FLAPSD_lgt_93	;
self.final_score_94	:= 	wFDN_FLAPSD_lgt_94	;
self.final_score_95	:= 	wFDN_FLAPSD_lgt_95	;
self.final_score_96	:= 	wFDN_FLAPSD_lgt_96	;
self.final_score_97	:= 	wFDN_FLAPSD_lgt_97	;
self.final_score_98	:= 	wFDN_FLAPSD_lgt_98	;
self.final_score_99	:= 	wFDN_FLAPSD_lgt_99	;
self.final_score_100	:= 	wFDN_FLAPSD_lgt_100	;
self.final_score_101	:= 	wFDN_FLAPSD_lgt_101	;
self.final_score_102	:= 	wFDN_FLAPSD_lgt_102	;
self.final_score_103	:= 	wFDN_FLAPSD_lgt_103	;
self.final_score_104	:= 	wFDN_FLAPSD_lgt_104	;
self.final_score_105	:= 	wFDN_FLAPSD_lgt_105	;
self.final_score_106	:= 	wFDN_FLAPSD_lgt_106	;
self.final_score_107	:= 	wFDN_FLAPSD_lgt_107	;
self.final_score_108	:= 	wFDN_FLAPSD_lgt_108	;
self.final_score_109	:= 	wFDN_FLAPSD_lgt_109	;
self.final_score_110	:= 	wFDN_FLAPSD_lgt_110	;
self.final_score_111	:= 	wFDN_FLAPSD_lgt_111	;
self.final_score_112	:= 	wFDN_FLAPSD_lgt_112	;
self.final_score_113	:= 	wFDN_FLAPSD_lgt_113	;
self.final_score_114	:= 	wFDN_FLAPSD_lgt_114	;
self.final_score_115	:= 	wFDN_FLAPSD_lgt_115	;
self.final_score_116	:= 	wFDN_FLAPSD_lgt_116	;
self.final_score_117	:= 	wFDN_FLAPSD_lgt_117	;
self.final_score_118	:= 	wFDN_FLAPSD_lgt_118	;
self.final_score_119	:= 	wFDN_FLAPSD_lgt_119	;
self.final_score_120	:= 	wFDN_FLAPSD_lgt_120	;
self.final_score_121	:= 	wFDN_FLAPSD_lgt_121	;
self.final_score_122	:= 	wFDN_FLAPSD_lgt_122	;
self.final_score_123	:= 	wFDN_FLAPSD_lgt_123	;
self.final_score_124	:= 	wFDN_FLAPSD_lgt_124	;
self.final_score_125	:= 	wFDN_FLAPSD_lgt_125	;
self.final_score_126	:= 	wFDN_FLAPSD_lgt_126	;
self.final_score_127	:= 	wFDN_FLAPSD_lgt_127	;
self.final_score_128	:= 	wFDN_FLAPSD_lgt_128	;
self.final_score_129	:= 	wFDN_FLAPSD_lgt_129	;
self.final_score_130	:= 	wFDN_FLAPSD_lgt_130	;
self.final_score_131	:= 	wFDN_FLAPSD_lgt_131	;
self.final_score_132	:= 	wFDN_FLAPSD_lgt_132	;
self.final_score_133	:= 	wFDN_FLAPSD_lgt_133	;
self.final_score_134	:= 	wFDN_FLAPSD_lgt_134	;
self.final_score_135	:= 	wFDN_FLAPSD_lgt_135	;
self.final_score_136	:= 	wFDN_FLAPSD_lgt_136	;
self.final_score_137	:= 	wFDN_FLAPSD_lgt_137	;
self.final_score_138	:= 	wFDN_FLAPSD_lgt_138	;
self.final_score_139	:= 	wFDN_FLAPSD_lgt_139	;
self.final_score_140	:= 	wFDN_FLAPSD_lgt_140	;
self.final_score_141	:= 	wFDN_FLAPSD_lgt_141	;
self.final_score_142	:= 	wFDN_FLAPSD_lgt_142	;
self.final_score_143	:= 	wFDN_FLAPSD_lgt_143	;
self.final_score_144	:= 	wFDN_FLAPSD_lgt_144	;
self.final_score_145	:= 	wFDN_FLAPSD_lgt_145	;
self.final_score_146	:= 	wFDN_FLAPSD_lgt_146	;
self.final_score_147	:= 	wFDN_FLAPSD_lgt_147	;
self.final_score_148	:= 	wFDN_FLAPSD_lgt_148	;
self.final_score_149	:= 	wFDN_FLAPSD_lgt_149	;
self.final_score_150	:= 	wFDN_FLAPSD_lgt_150	;
self.final_score_151	:= 	wFDN_FLAPSD_lgt_151	;
self.final_score_152	:= 	wFDN_FLAPSD_lgt_152	;
self.final_score_153	:= 	wFDN_FLAPSD_lgt_153	;
self.final_score_154	:= 	wFDN_FLAPSD_lgt_154	;
self.final_score_155	:= 	wFDN_FLAPSD_lgt_155	;
self.final_score_156	:= 	wFDN_FLAPSD_lgt_156	;
self.final_score_157	:= 	wFDN_FLAPSD_lgt_157	;
self.final_score_158	:= 	wFDN_FLAPSD_lgt_158	;
self.final_score_159	:= 	wFDN_FLAPSD_lgt_159	;
self.final_score_160	:= 	wFDN_FLAPSD_lgt_160	;
self.final_score_161	:= 	wFDN_FLAPSD_lgt_161	;
self.final_score_162	:= 	wFDN_FLAPSD_lgt_162	;
self.final_score_163	:= 	wFDN_FLAPSD_lgt_163	;
self.final_score_164	:= 	wFDN_FLAPSD_lgt_164	;
self.final_score_165	:= 	wFDN_FLAPSD_lgt_165	;
self.final_score_166	:= 	wFDN_FLAPSD_lgt_166	;
self.final_score_167	:= 	wFDN_FLAPSD_lgt_167	;
self.final_score_168	:= 	wFDN_FLAPSD_lgt_168	;
self.final_score_169	:= 	wFDN_FLAPSD_lgt_169	;
self.final_score_170	:= 	wFDN_FLAPSD_lgt_170	;
self.final_score_171	:= 	wFDN_FLAPSD_lgt_171	;
self.final_score_172	:= 	wFDN_FLAPSD_lgt_172	;
self.final_score_173	:= 	wFDN_FLAPSD_lgt_173	;
self.final_score_174	:= 	wFDN_FLAPSD_lgt_174	;
self.final_score_175	:= 	wFDN_FLAPSD_lgt_175	;
self.final_score_176	:= 	wFDN_FLAPSD_lgt_176	;
self.final_score_177	:= 	wFDN_FLAPSD_lgt_177	;
self.final_score_178	:= 	wFDN_FLAPSD_lgt_178	;
self.final_score_179	:= 	wFDN_FLAPSD_lgt_179	;
self.final_score_180	:= 	wFDN_FLAPSD_lgt_180	;
self.final_score_181	:= 	wFDN_FLAPSD_lgt_181	;
self.final_score_182	:= 	wFDN_FLAPSD_lgt_182	;
self.final_score_183	:= 	wFDN_FLAPSD_lgt_183	;
self.final_score_184	:= 	wFDN_FLAPSD_lgt_184	;
self.final_score_185	:= 	wFDN_FLAPSD_lgt_185	;
self.final_score_186	:= 	wFDN_FLAPSD_lgt_186	;
self.final_score_187	:= 	wFDN_FLAPSD_lgt_187	;
self.final_score_188	:= 	wFDN_FLAPSD_lgt_188	;
self.final_score_189	:= 	wFDN_FLAPSD_lgt_189	;
self.final_score_190	:= 	wFDN_FLAPSD_lgt_190	;
self.final_score_191	:= 	wFDN_FLAPSD_lgt_191	;
self.final_score_192	:= 	wFDN_FLAPSD_lgt_192	;
self.final_score_193	:= 	wFDN_FLAPSD_lgt_193	;
self.final_score_194	:= 	wFDN_FLAPSD_lgt_194	;
self.final_score_195	:= 	wFDN_FLAPSD_lgt_195	;
self.final_score_196	:= 	wFDN_FLAPSD_lgt_196	;
self.final_score_197	:= 	wFDN_FLAPSD_lgt_197	;
self.final_score_198	:= 	wFDN_FLAPSD_lgt_198	;
self.final_score_199	:= 	wFDN_FLAPSD_lgt_199	;
self.final_score_200	:= 	wFDN_FLAPSD_lgt_200	;
self.final_score_201	:= 	wFDN_FLAPSD_lgt_201	;
self.final_score_202	:= 	wFDN_FLAPSD_lgt_202	;
self.final_score_203	:= 	wFDN_FLAPSD_lgt_203	;
self.final_score_204	:= 	wFDN_FLAPSD_lgt_204	;
self.final_score_205	:= 	wFDN_FLAPSD_lgt_205	;
self.final_score_206	:= 	wFDN_FLAPSD_lgt_206	;
self.final_score_207	:= 	wFDN_FLAPSD_lgt_207	;
self.final_score_208	:= 	wFDN_FLAPSD_lgt_208	;
self.final_score_209	:= 	wFDN_FLAPSD_lgt_209	;
self.final_score_210	:= 	wFDN_FLAPSD_lgt_210	;
self.final_score_211	:= 	wFDN_FLAPSD_lgt_211	;
self.final_score_212	:= 	wFDN_FLAPSD_lgt_212	;
self.final_score_213	:= 	wFDN_FLAPSD_lgt_213	;
self.final_score_214	:= 	wFDN_FLAPSD_lgt_214	;
self.final_score_215	:= 	wFDN_FLAPSD_lgt_215	;
self.final_score_216	:= 	wFDN_FLAPSD_lgt_216	;
self.final_score_217	:= 	wFDN_FLAPSD_lgt_217	;
self.final_score_218	:= 	wFDN_FLAPSD_lgt_218	;
self.final_score_219	:= 	wFDN_FLAPSD_lgt_219	;
self.final_score_220	:= 	wFDN_FLAPSD_lgt_220	;
self.final_score_221	:= 	wFDN_FLAPSD_lgt_221	;
self.final_score_222	:= 	wFDN_FLAPSD_lgt_222	;
self.final_score_223	:= 	wFDN_FLAPSD_lgt_223	;
self.final_score_224	:= 	wFDN_FLAPSD_lgt_224	;
self.final_score_225	:= 	wFDN_FLAPSD_lgt_225	;
self.final_score_226	:= 	wFDN_FLAPSD_lgt_226	;
self.final_score_227	:= 	wFDN_FLAPSD_lgt_227	;
self.final_score_228	:= 	wFDN_FLAPSD_lgt_228	;
self.final_score_229	:= 	wFDN_FLAPSD_lgt_229	;
self.final_score_230	:= 	wFDN_FLAPSD_lgt_230	;
self.final_score_231	:= 	wFDN_FLAPSD_lgt_231	;
self.final_score_232	:= 	wFDN_FLAPSD_lgt_232	;
self.final_score_233	:= 	wFDN_FLAPSD_lgt_233	;
self.final_score_234	:= 	wFDN_FLAPSD_lgt_234	;
// self.wFDN_submodel_lgt	:= 	wFDN_FLAPSD_lgt	;
self.FP3_wFDN_LGT		:= 	wFDN_FLAPSD_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
