
export FP3FDN1505_FLAPD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FLAP_D_lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FLAP_D_lgt_1 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 0.4584876928,
(nf_vf_hi_risk_index > 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 0.5) => 
      map(
      (NULL < r_nas_addr_verd_d and r_nas_addr_verd_d <= 0.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 50.85) => 0.4163796803,
         (c_fammar_p > 50.85) => 0.0614759577,
         (c_fammar_p = NULL) => 0.0009265458, 0.1050828001),
      (r_nas_addr_verd_d > 0.5) => -0.0361604102,
      (r_nas_addr_verd_d = NULL) => -0.0265293461, -0.0265293461),
   (f_inq_HighRiskCredit_count_i > 0.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 0.1016541803,
      (f_inq_Communications_count_i > 1.5) => 0.5562991298,
      (f_inq_Communications_count_i = NULL) => 0.1552023963, 0.1552023963),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0134596989, -0.0134596989),
(nf_vf_hi_risk_index = NULL) => 0.2204202967, -0.0016766067);

// Tree: 2 
wFDN_FLAP_D_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1343050582,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0378376338,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.2017430103,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0325562537, -0.0325562537),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0232294831, -0.0232294831),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0640785650,
   (f_rel_under500miles_cnt_d > 5.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.2076402352,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.4779632298,
      (nf_seg_FraudPoint_3_0 = '') => 0.3532542216, 0.3532542216),
   (f_rel_under500miles_cnt_d = NULL) => 0.1159723803, 0.2197359511),
(f_varrisktype_i = NULL) => 0.1316883272, -0.0071897114);

// Tree: 3 
wFDN_FLAP_D_lgt_3 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0868938683,
   (f_inq_Communications_count_i > 0.5) => 0.3086719113,
   (f_inq_Communications_count_i = NULL) => 0.1362716628, 0.1362716628),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 0.0041175029,
      (f_phone_ver_insurance_d > 3.5) => -0.0545848387,
      (f_phone_ver_insurance_d = NULL) => -0.0252363034, -0.0252363034),
   (f_inq_Communications_count_i > 1.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0720102212,
      (f_srchvelocityrisktype_i > 4.5) => 0.2657355146,
      (f_srchvelocityrisktype_i = NULL) => 0.1379468422, 0.1379468422),
   (f_inq_Communications_count_i = NULL) => -0.0205125433, -0.0205125433),
(nf_vf_hi_risk_hit_type = NULL) => 0.1173649122, -0.0057289422);

// Tree: 4 
wFDN_FLAP_D_lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < c_med_inc and c_med_inc <= 54.5) => 0.1298012101,
         (c_med_inc > 54.5) => 0.0011978057,
         (c_med_inc = NULL) => -0.0463812583, 0.0210994917),
      (k_inq_per_phone_i > 2.5) => 0.3097286648,
      (k_inq_per_phone_i = NULL) => 0.0319112148, 0.0319112148),
   (f_phone_ver_experian_d > 0.5) => -0.0525230144,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => -0.0140892303,
      (f_rel_felony_count_i > 1.5) => 0.2587523832,
      (f_rel_felony_count_i = NULL) => -0.0001851104, -0.0001851104), -0.0141532401),
(f_srchfraudsrchcount_i > 8.5) => 0.1972016798,
(f_srchfraudsrchcount_i = NULL) => 0.1134604197, -0.0068735595);

// Tree: 5 
wFDN_FLAP_D_lgt_5 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => -0.0306670479,
   (k_inq_ssns_per_addr_i > 2.5) => 0.1013717541,
   (k_inq_ssns_per_addr_i = NULL) => -0.0253382480, -0.0253382480),
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 27.25) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0191303360,
      (f_varrisktype_i > 2.5) => 
         map(
         (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 0.5) => 0.0437150247,
         (f_rel_bankrupt_count_i > 0.5) => 0.2046497503,
         (f_rel_bankrupt_count_i = NULL) => 0.1302390707, 0.1302390707),
      (f_varrisktype_i = NULL) => 0.0606564285, 0.0437989968),
   (c_famotf18_p > 27.25) => 0.2199361000,
   (c_famotf18_p = NULL) => -0.0350406100, 0.0645952431),
(nf_seg_FraudPoint_3_0 = '') => -0.0051466373, -0.0051466373);

// Tree: 6 
wFDN_FLAP_D_lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1662830437,
      (f_phone_ver_experian_d > 0.5) => -0.0250404732,
      (f_phone_ver_experian_d = NULL) => 0.0405895064, 0.0722498536),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0286359776,
      (r_D33_eviction_count_i > 2.5) => 0.2871701626,
      (r_D33_eviction_count_i = NULL) => -0.0264038248, -0.0264038248),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0166518895, -0.0166518895),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.2022816081,
   (r_I60_inq_comm_recency_d > 549) => 0.0856056492,
   (r_I60_inq_comm_recency_d = NULL) => 0.1320466943, 0.1320466943),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0708630148, -0.0106252410);

// Tree: 7 
wFDN_FLAP_D_lgt_7 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.2495710099,
   (r_F01_inp_addr_address_score_d > 75) => 0.0664151924,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0889048557, 0.0889048557),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0123199116,
      (k_nap_phn_verd_d > 0.5) => -0.0548025154,
      (k_nap_phn_verd_d = NULL) => -0.0303480323, -0.0303480323),
   (f_srchvelocityrisktype_i > 4.5) => 0.0512712061,
   (f_srchvelocityrisktype_i = NULL) => -0.0208289869, -0.0208289869),
(nf_vf_hi_risk_hit_type = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.031302406) => -0.0242004122,
   (f_add_input_nhood_VAC_pct_i > 0.031302406) => 0.2172717186,
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0554201283, 0.0554201283), -0.0109019178);

// Tree: 8 
wFDN_FLAP_D_lgt_8 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0536996039,
      (f_rel_felony_count_i > 1.5) => 0.2620571937,
      (f_rel_felony_count_i = NULL) => 0.0695725544, 0.0695725544),
   (r_F01_inp_addr_address_score_d > 95) => -0.0304112335,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0211139605, -0.0211139605),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0474222437,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 3.5) => 0.1433820916,
      (f_assoccredbureaucount_i > 3.5) => 0.2983058423,
      (f_assoccredbureaucount_i = NULL) => 0.1754561494, 0.1754561494),
   (f_rel_felony_count_i = NULL) => 0.0717734174, 0.0717734174),
(f_varrisktype_i = NULL) => 0.0371224793, -0.0104313456);

// Tree: 9 
wFDN_FLAP_D_lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.1603829404,
      (k_estimated_income_d > 26500) => 0.0433904943,
      (k_estimated_income_d = NULL) => 0.0626590647, 0.0626590647),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0299187483,
      (k_inq_per_phone_i > 2.5) => 0.0847589629,
      (k_inq_per_phone_i = NULL) => -0.0248442112, -0.0248442112),
   (c_fammar_p = NULL) => -0.0418754720, -0.0123927830),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1533595448,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1452963719,
   (k_nap_phn_verd_d > 0.5) => -0.0932572578,
   (k_nap_phn_verd_d = NULL) => 0.0734868609, 0.0734868609), -0.0063748487);

// Tree: 10 
wFDN_FLAP_D_lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 0.1041468092,
   (nf_vf_hi_risk_index > 4.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0570467334,
         (f_phone_ver_experian_d > 0.5) => -0.0404959902,
         (f_phone_ver_experian_d = NULL) => 0.0076345723, 0.0121159589),
      (f_corrphonelastnamecount_d > 0.5) => -0.0380269107,
      (f_corrphonelastnamecount_d = NULL) => -0.0162790667, -0.0162790667),
   (nf_vf_hi_risk_index = NULL) => -0.0135457425, -0.0135457425),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1787461709,
   (f_phone_ver_experian_d > 0.5) => 0.0031825047,
   (f_phone_ver_experian_d = NULL) => 0.1676667205, 0.1163398148),
(f_inq_Communications_count_i = NULL) => 0.0419415386, -0.0083130303);

// Tree: 11 
wFDN_FLAP_D_lgt_11 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3723439315,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => -0.0241139995,
      (k_inq_ssns_per_addr_i > 2.5) => 0.0882215769,
      (k_inq_ssns_per_addr_i = NULL) => -0.0196269580, -0.0196269580),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0174128241, -0.0174128241),
(f_inq_Communications_count_i > 0.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0319519059,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 29.15) => 0.1793170996,
      (c_hh1_p > 29.15) => 0.0495696979,
      (c_hh1_p = NULL) => 0.1245799145, 0.1245799145),
   (nf_seg_FraudPoint_3_0 = '') => 0.0681432713, 0.0681432713),
(f_inq_Communications_count_i = NULL) => 0.0444249093, -0.0085916662);

// Tree: 12 
wFDN_FLAP_D_lgt_12 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0231181615,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 56.2) => 0.1506049190,
      (c_fammar_p > 56.2) => 0.0409992128,
      (c_fammar_p = NULL) => -0.0560969119, 0.0465330529),
   (f_corrrisktype_i = NULL) => -0.0126059661, -0.0126059661),
(f_inq_HighRiskCredit_count_i > 2.5) => 0.0936571925,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 15.65) => 0.1926677952,
      (c_newhouse > 15.65) => 0.0546060442,
      (c_newhouse = NULL) => 0.1269241042, 0.1269241042),
   (k_nap_phn_verd_d > 0.5) => -0.0940501216,
   (k_nap_phn_verd_d = NULL) => 0.0575081171, 0.0575081171), -0.0081826646);

// Tree: 13 
wFDN_FLAP_D_lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 51.45) => 0.0693215784,
   (c_fammar_p > 51.45) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0160758913,
         (f_phone_ver_experian_d > 0.5) => -0.0432528655,
         (f_phone_ver_experian_d = NULL) => -0.0247839735, -0.0210677889),
      (f_inq_PrepaidCards_count_i > 1.5) => 0.1473638030,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0195783199, -0.0195783199),
   (c_fammar_p = NULL) => -0.0501437232, -0.0128044365),
(f_assocsuspicousidcount_i > 13.5) => 0.2240970504,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 71.6) => 0.1443896598,
   (c_fammar_p > 71.6) => -0.0159777142,
   (c_fammar_p = NULL) => 0.0442877321, 0.0442877321), -0.0098576113);

// Tree: 14 
wFDN_FLAP_D_lgt_14 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0288422711,
   (r_C23_inp_addr_occ_index_d > 2) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 36562.5) => 0.2149561472,
      (f_curraddrmedianincome_d > 36562.5) => 0.0728248978,
      (f_curraddrmedianincome_d = NULL) => 0.1141123815, 0.1141123815),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0591622646, 0.0591622646),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0914747424,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 20500) => 0.0685171379,
      (k_estimated_income_d > 20500) => -0.0213413255,
      (k_estimated_income_d = NULL) => -0.0185783086, -0.0185783086),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0161470498, -0.0161470498),
(nf_vf_hi_risk_hit_type = NULL) => 0.0135477213, -0.0092177757);

// Tree: 15 
wFDN_FLAP_D_lgt_15 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 61.05) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 75.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.2716445169,
         (r_F00_dob_score_d > 92) => 0.0348904388,
         (r_F00_dob_score_d = NULL) => 0.0238913542, 0.0408244928),
      (k_comb_age_d > 75.5) => 0.3481344600,
      (k_comb_age_d = NULL) => 0.0487842736, 0.0487842736),
   (c_fammar_p > 61.05) => -0.0213505713,
   (c_fammar_p = NULL) => -0.0293618714, -0.0103428296),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.1487646278,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 70) => -0.0294975612,
   (c_burglary > 70) => 0.1171195570,
   (c_burglary = NULL) => 0.0584727097, 0.0584727097), -0.0075144032);

// Tree: 16 
wFDN_FLAP_D_lgt_16 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
         map(
         (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => -0.0210301205,
         (f_inq_Communications_count_i > 3.5) => 0.1577157376,
         (f_inq_Communications_count_i = NULL) => -0.0200742603, -0.0200742603),
      (r_F01_inp_addr_not_verified_i > 0.5) => 0.0504346441,
      (r_F01_inp_addr_not_verified_i = NULL) => -0.0153033587, -0.0153033587),
   (f_varrisktype_i > 3.5) => 0.0602647053,
   (f_varrisktype_i = NULL) => -0.0111404418, -0.0111404418),
(r_D30_Derog_Count_i > 5.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1695465815,
   (r_I60_inq_comm_recency_d > 549) => 0.0735018388,
   (r_I60_inq_comm_recency_d = NULL) => 0.0946721548, 0.0946721548),
(r_D30_Derog_Count_i = NULL) => 0.0165260541, -0.0056054786);

// Tree: 17 
wFDN_FLAP_D_lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => -0.0253775688,
      (r_D33_eviction_count_i > 0.5) => 0.0593929413,
      (r_D33_eviction_count_i = NULL) => -0.0231436482, -0.0223166538),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.2239070969,
      (k_estimated_income_d > 28500) => 0.0283435296,
      (k_estimated_income_d = NULL) => 0.1108645724, 0.1108645724),
   (k_nap_contradictory_i = NULL) => -0.0201337419, -0.0201337419),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0338754803,
   (f_hh_payday_loan_users_i > 0.5) => 0.1341122496,
   (f_hh_payday_loan_users_i = NULL) => 0.0503279363, 0.0503279363),
(k_inq_per_addr_i = NULL) => -0.0123682373, -0.0123682373);

// Tree: 18 
wFDN_FLAP_D_lgt_18 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 4.5) => 0.1798428896,
      (f_M_Bureau_ADL_FS_noTU_d > 4.5) => 0.0113261878,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0146333845, 0.0146333845),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => 0.1555319836,
      (f_corraddrnamecount_d > 6.5) => -0.0103941933,
      (f_corraddrnamecount_d = NULL) => 0.0988742647, 0.0988742647),
   (f_rel_felony_count_i = NULL) => 0.0418913254, 0.0202806898),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0269336147,
   (r_D33_eviction_count_i > 2.5) => 0.1343574573,
   (r_D33_eviction_count_i = NULL) => -0.0755264416, -0.0256568130),
(k_nap_phn_verd_d = NULL) => -0.0079155574, -0.0079155574);

// Tree: 19 
wFDN_FLAP_D_lgt_19 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0147551542,
      (f_rel_felony_count_i > 1.5) => 0.1125235682,
      (f_rel_felony_count_i = NULL) => 0.0373318671, 0.0207513245),
   (k_nap_phn_verd_d > 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0268144323,
      (r_D33_eviction_count_i > 2.5) => 0.1569195390,
      (r_D33_eviction_count_i = NULL) => -0.0255626680, -0.0255626680),
   (k_nap_phn_verd_d = NULL) => -0.0076939142, -0.0076939142),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1487823046,
   (f_phone_ver_experian_d > 0.5) => 0.0313715411,
   (f_phone_ver_experian_d = NULL) => 0.0630094410, 0.0715509561),
(k_inq_per_phone_i = NULL) => -0.0035957956, -0.0035957956);

// Tree: 20 
wFDN_FLAP_D_lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0176702128,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2.5) => 0.0268292062,
      (f_idverrisktype_i > 2.5) => 0.1406551409,
      (f_idverrisktype_i = NULL) => 0.0559524304, 0.0559524304),
   (k_inq_per_addr_i = NULL) => -0.0106109605, -0.0106109605),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1092141937,
   (f_phone_ver_experian_d > 0.5) => 0.0060229717,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 4.5) => 0.0120017793,
      (f_assocsuspicousidcount_i > 4.5) => 0.1618909395,
      (f_assocsuspicousidcount_i = NULL) => 0.0363427540, 0.0363427540), 0.0475039092),
(f_varrisktype_i = NULL) => 0.0069705410, -0.0040848657);

// Tree: 21 
wFDN_FLAP_D_lgt_21 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 45.75) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 0.0877269194,
         (f_M_Bureau_ADL_FS_noTU_d > 7.5) => -0.0227638217,
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0205713770, -0.0205713770),
      (c_famotf18_p > 45.75) => 0.0924813372,
      (c_famotf18_p = NULL) => -0.0163284019, -0.0186046645),
   (f_srchvelocityrisktype_i > 4.5) => 0.0310228834,
   (f_srchvelocityrisktype_i = NULL) => -0.0122709323, -0.0122709323),
(f_assocsuspicousidcount_i > 16.5) => 0.1666271790,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.85) => -0.0360983977,
   (c_pop_35_44_p > 16.85) => 0.0834296426,
   (c_pop_35_44_p = NULL) => 0.0067512771, 0.0067512771), -0.0110648098);

// Tree: 22 
wFDN_FLAP_D_lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1797484082,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0261472769,
      (f_hh_lienholders_i > 0.5) => 0.0218787085,
      (f_hh_lienholders_i = NULL) => -0.0116786889, -0.0116786889),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0108583560, -0.0108583560),
(f_assocrisktype_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 0.2021054993,
   (r_C12_source_profile_index_d > 1.5) => 0.0662253774,
   (r_C12_source_profile_index_d = NULL) => 0.0775298801, 0.0775298801),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 60.5) => -0.0711880601,
   (c_bel_edu > 60.5) => 0.0591372396,
   (c_bel_edu = NULL) => 0.0086361860, 0.0086361860), -0.0063893902);

// Tree: 23 
wFDN_FLAP_D_lgt_23 := map(
(NULL < c_fammar_p and c_fammar_p <= 58.25) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -15421) => 0.1584908800,
   (f_addrchangeincomediff_d > -15421) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0182113679,
      (f_crim_rel_under25miles_cnt_i > 0.5) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 478) => 
            map(
            (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.1975110171,
            (f_property_owners_ct_d > 0.5) => 0.0694271329,
            (f_property_owners_ct_d = NULL) => 0.1184003828, 0.1184003828),
         (c_hh00 > 478) => 0.0200717733,
         (c_hh00 = NULL) => 0.0609133249, 0.0609133249),
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.0196021842, 0.0196021842),
   (f_addrchangeincomediff_d = NULL) => 0.0446808413, 0.0332737348),
(c_fammar_p > 58.25) => -0.0104013744,
(c_fammar_p = NULL) => -0.0358302278, -0.0049800426);

// Tree: 24 
wFDN_FLAP_D_lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => -0.0158423030,
   (c_unemp > 8.95) => 0.0769403860,
   (c_unemp = NULL) => -0.0361063481, -0.0121505381),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < nf_vf_lexid_lo_summary and nf_vf_lexid_lo_summary <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 60.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 99750) => 0.1436638773,
         (r_L80_Inp_AVM_AutoVal_d > 99750) => 0.0477939536,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0205885351, 0.0486429023),
      (k_comb_age_d > 60.5) => 0.2233567136,
      (k_comb_age_d = NULL) => 0.0669114567, 0.0669114567),
   (nf_vf_lexid_lo_summary > 0.5) => -0.0282946494,
   (nf_vf_lexid_lo_summary = NULL) => 0.0456764168, 0.0456764168),
(k_inq_per_addr_i = NULL) => -0.0059233705, -0.0059233705);

// Tree: 25 
wFDN_FLAP_D_lgt_25 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 0.1233666884,
   (r_I60_inq_recency_d > 2) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 6.5) => 0.0363351930,
         (f_srchaddrsrchcount_i > 6.5) => 
            map(
            (NULL < c_unemp and c_unemp <= 5.45) => 0.0463352331,
            (c_unemp > 5.45) => 0.2302275136,
            (c_unemp = NULL) => 0.1202919111, 0.1202919111),
         (f_srchaddrsrchcount_i = NULL) => 0.0438320483, 0.0438320483),
      (k_nap_phn_verd_d > 0.5) => -0.0209294634,
      (k_nap_phn_verd_d = NULL) => 0.0141637283, 0.0141637283),
   (r_I60_inq_recency_d = NULL) => 0.0208822698, 0.0208822698),
(f_phone_ver_experian_d > 0.5) => -0.0309936335,
(f_phone_ver_experian_d = NULL) => -0.0004939815, -0.0075947185);

// Tree: 26 
wFDN_FLAP_D_lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62494) => 0.0852936174,
   (f_addrchangevaluediff_d > -62494) => -0.0098295143,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => -0.0148584098,
      (f_phones_per_addr_curr_i > 4.5) => 
         map(
         (NULL < c_housingcpi and c_housingcpi <= 215.95) => 
            map(
            (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.140427134) => 0.0097764750,
            (f_add_curr_nhood_VAC_pct_i > 0.140427134) => 0.2491442348,
            (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0306637141, 0.0306637141),
         (c_housingcpi > 215.95) => 0.1473042484,
         (c_housingcpi = NULL) => 0.0652980813, 0.0652980813),
      (f_phones_per_addr_curr_i = NULL) => 0.0107324488, 0.0107324488), -0.0033342144),
(r_D30_Derog_Count_i > 11.5) => 0.1145451217,
(r_D30_Derog_Count_i = NULL) => 0.0184771113, -0.0014273720);

// Tree: 27 
wFDN_FLAP_D_lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1340555692) => 0.0339841441,
   (f_add_curr_nhood_VAC_pct_i > 0.1340555692) => 0.1468645689,
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0506099431, 0.0506099431),
(c_fammar_p > 50.45) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
      map(
      (NULL < c_med_age and c_med_age <= 31.25) => 0.1784702467,
      (c_med_age > 31.25) => 0.0351835100,
      (c_med_age = NULL) => 0.0664929512, 0.0664929512),
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1257612982,
      (r_F00_dob_score_d > 92) => -0.0184619898,
      (r_F00_dob_score_d = NULL) => 0.0175800243, -0.0142792400),
   (r_D33_Eviction_Recency_d = NULL) => 0.0142520448, -0.0111918820),
(c_fammar_p = NULL) => -0.0195392180, -0.0062848537);

// Tree: 28 
wFDN_FLAP_D_lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62814) => 0.1551760916,
      (f_addrchangevaluediff_d > -62814) => 0.0103613610,
      (f_addrchangevaluediff_d = NULL) => 0.0289152276, 0.0189860774),
   (f_phone_ver_experian_d > 0.5) => -0.0371312467,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.1379467823,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0071374628,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0030767283, -0.0030767283), -0.0122757234),
(r_D33_eviction_count_i > 0.5) => 0.0636168356,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 99.5) => -0.0249663020,
   (c_burglary > 99.5) => 0.0919939289,
   (c_burglary = NULL) => 0.0266971129, 0.0266971129), -0.0087212438);

// Tree: 29 
wFDN_FLAP_D_lgt_29 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0112641815,
      (k_comb_age_d > 68.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 182.5) => 0.0558764029,
         (c_sub_bus > 182.5) => 0.2671700483,
         (c_sub_bus = NULL) => 0.0703451531, 0.0703451531),
      (k_comb_age_d = NULL) => -0.0054601698, -0.0054601698),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1199066323,
   (f_inq_PrepaidCards_count_i = NULL) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0736119564,
      (c_pop_35_44_p > 15.55) => 0.0498910366,
      (c_pop_35_44_p = NULL) => -0.0148832604, -0.0148832604), -0.0050418322),
(k_nap_contradictory_i > 0.5) => 0.0990337162,
(k_nap_contradictory_i = NULL) => -0.0032450214, -0.0032450214);

// Tree: 30 
wFDN_FLAP_D_lgt_30 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 12.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0197896021,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < c_employees and c_employees <= 20.5) => 0.1184678032,
      (c_employees > 20.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 127.5) => 0.0052418323,
         (r_C13_Curr_Addr_LRes_d > 127.5) => 0.1554321809,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0206305972, 0.0206305972),
      (c_employees = NULL) => -0.0230345821, 0.0247015069),
   (f_corrrisktype_i = NULL) => -0.0128772783, -0.0128772783),
(f_srchaddrsrchcount_i > 12.5) => 0.0558678655,
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 78.5) => -0.0734717646,
   (c_unempl > 78.5) => 0.0695604841,
   (c_unempl = NULL) => 0.0156911956, 0.0156911956), -0.0095160645);

// Tree: 31 
wFDN_FLAP_D_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1318453910,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0090195847,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0084001578, -0.0084001578),
      (k_comb_age_d > 69.5) => 0.0835464694,
      (k_comb_age_d = NULL) => -0.0025435429, -0.0025435429),
   (f_assocsuspicousidcount_i > 15.5) => 0.1466410628,
   (f_assocsuspicousidcount_i = NULL) => -0.0017171349, -0.0017171349),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1704259005,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.4) => -0.0675212531,
   (c_pop_35_44_p > 13.4) => 0.0611651202,
   (c_pop_35_44_p = NULL) => 0.0179817734, 0.0179817734), -0.0007245776);

// Tree: 32 
wFDN_FLAP_D_lgt_32 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.255) => -0.0096646847,
   (c_hhsize > 4.255) => 0.1557088676,
   (c_hhsize = NULL) => -0.0108782744, -0.0080732068),
(f_phones_per_addr_curr_i > 8.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0273581384,
   (f_assocrisktype_i > 5.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0259628006) => 0.1868005195,
      (f_add_input_nhood_BUS_pct_i > 0.0259628006) => 0.0743563346,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.1079006083, 0.1079006083),
   (f_assocrisktype_i = NULL) => 0.0417449339, 0.0417449339),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.8) => 0.0759655219,
   (c_construction > 4.8) => -0.0393898467,
   (c_construction = NULL) => 0.0131116352, 0.0131116352), -0.0024011854);

// Tree: 33 
wFDN_FLAP_D_lgt_33 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 23.55) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 119.5) => 0.1879840685,
   (r_D32_Mos_Since_Fel_LS_d > 119.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => -0.0127301195,
      (k_inq_per_phone_i > 4.5) => 
         map(
         (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 1.5) => 0.1674055748,
         (f_srchfraudsrchcountyr_i > 1.5) => -0.0023064816,
         (f_srchfraudsrchcountyr_i = NULL) => 0.0703144914, 0.0703144914),
      (k_inq_per_phone_i = NULL) => -0.0110447701, -0.0110447701),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0309731173, -0.0103520039),
(c_famotf18_p > 23.55) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 0.1122568094,
   (f_prevaddrlenofres_d > 1.5) => 0.0233289836,
   (f_prevaddrlenofres_d = NULL) => 0.0304586850, 0.0304586850),
(c_famotf18_p = NULL) => -0.0425079852, -0.0057696275);

// Tree: 34 
wFDN_FLAP_D_lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1181531091,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
      map(
      (NULL < c_construction and c_construction <= 4.45) => 0.1835936807,
      (c_construction > 4.45) => 0.0329268544,
      (c_construction = NULL) => 0.1013594968, 0.1013594968),
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.0310605835,
      (r_I60_inq_comm_recency_d > 549) => -0.0125284625,
      (r_I60_inq_comm_recency_d = NULL) => -0.0082963719, -0.0082963719),
   (r_F00_dob_score_d = NULL) => 0.0419835688, -0.0039844458),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.3) => -0.0591028900,
   (c_hh4_p > 11.3) => 0.0734574468,
   (c_hh4_p = NULL) => 0.0196917158, 0.0196917158), -0.0029953135);

// Tree: 35 
wFDN_FLAP_D_lgt_35 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1791168263,
      (f_hh_age_18_plus_d > 0.5) => -0.0142577722,
      (f_hh_age_18_plus_d = NULL) => -0.0133252737, -0.0133252737),
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 270.5) => 0.0181176988,
      (f_prevaddrageoldest_d > 270.5) => 0.1671377515,
      (f_prevaddrageoldest_d = NULL) => 0.0274493059, 0.0274493059),
   (f_srchvelocityrisktype_i = NULL) => -0.0080693461, -0.0080693461),
(f_hh_tot_derog_i > 5.5) => 0.0848279817,
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 24.95) => 0.0854131953,
   (C_RENTOCC_P > 24.95) => -0.0395017239,
   (C_RENTOCC_P = NULL) => 0.0162035779, 0.0162035779), -0.0050537861);

// Tree: 36 
wFDN_FLAP_D_lgt_36 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 1.55) => 0.0617297622,
   (c_hh7p_p > 1.55) => 0.2703859416,
   (c_hh7p_p = NULL) => 0.1131229098, 0.1131229098),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0422941535,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 11.15) => 0.0016975777,
         (c_hh6_p > 11.15) => 0.1040512472,
         (c_hh6_p = NULL) => -0.0501982885, 0.0033688654),
      (f_rel_felony_count_i > 4.5) => 0.1327492653,
      (f_rel_felony_count_i = NULL) => 0.0043147013, 0.0043147013),
   (nf_seg_FraudPoint_3_0 = '') => -0.0127678908, -0.0127678908),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0099255861, -0.0107045529);

// Tree: 37 
wFDN_FLAP_D_lgt_37 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 1.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 212.75) => 0.0028737196,
         (c_cpiall > 212.75) => 0.1025007314,
         (c_cpiall = NULL) => 0.0313050882, 0.0277972116),
      (k_inq_per_addr_i > 1.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 39) => 0.0025373082,
         (c_burglary > 39) => 0.1245049737,
         (c_burglary = NULL) => 0.0931227824, 0.0931227824),
      (k_inq_per_addr_i = NULL) => 0.0436311293, 0.0436311293),
   (f_phone_ver_experian_d > 0.5) => -0.0123451835,
   (f_phone_ver_experian_d = NULL) => 0.0133230979, 0.0177741130),
(f_corrphonelastnamecount_d > 0.5) => -0.0162104718,
(f_corrphonelastnamecount_d = NULL) => 0.0034160582, -0.0011867203);

// Tree: 38 
wFDN_FLAP_D_lgt_38 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1123262590,
(r_F00_input_dob_match_level_d > 4.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => 
         map(
         (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => -0.0187502494,
         (f_hh_lienholders_i > 3.5) => 0.1642839135,
         (f_hh_lienholders_i = NULL) => -0.0171694132, -0.0171694132),
      (f_crim_rel_under500miles_cnt_i > 2.5) => 0.0242594957,
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0016468333, -0.0086796787),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1156205044,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0080118334, -0.0080118334),
(r_F00_input_dob_match_level_d = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 114.5) => 0.0901320641,
   (c_employees > 114.5) => -0.0213654121,
   (c_employees = NULL) => 0.0211796775, 0.0211796775), -0.0055154284);

// Tree: 39 
wFDN_FLAP_D_lgt_39 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => -0.0075004160,
   (k_comb_age_d > 69.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1237859814,
      (f_phone_ver_experian_d > 0.5) => 0.0758806775,
      (f_phone_ver_experian_d = NULL) => -0.0597782381, 0.0635746471),
   (k_comb_age_d = NULL) => -0.0031590072, -0.0031590072),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 90.5) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.8087860432) => 0.0629523645,
      (f_add_input_nhood_SFD_pct_d > 0.8087860432) => 0.2250408065,
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.1047816398, 0.1047816398),
   (c_lux_prod > 90.5) => 0.0179268600,
   (c_lux_prod = NULL) => 0.0520631285, 0.0520631285),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0003249820, -0.0003249820);

// Tree: 40 
wFDN_FLAP_D_lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 55.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.0840986389,
   (r_F00_dob_score_d > 98) => -0.0086386850,
   (r_F00_dob_score_d = NULL) => 0.0031266019, -0.0059923891),
(f_addrchangecrimediff_i > 55.5) => 0.0780903788,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => -0.0038167818,
      (f_srchcomponentrisktype_i > 2.5) => 0.1140798285,
      (f_srchcomponentrisktype_i = NULL) => 
         map(
         (NULL < c_burglary and c_burglary <= 89.5) => -0.0508244930,
         (c_burglary > 89.5) => 0.0762832618,
         (c_burglary = NULL) => 0.0039455152, 0.0039455152), 0.0006630393),
   (k_nap_contradictory_i > 0.5) => 0.1328772649,
   (k_nap_contradictory_i = NULL) => 0.0044625587, 0.0044625587), -0.0023172120);

// Tree: 41 
wFDN_FLAP_D_lgt_41 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1375018713,
   (f_attr_arrest_recency_d > 48) => -0.0108453171,
   (f_attr_arrest_recency_d = NULL) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 8.05) => -0.0328025496,
      (c_hval_300k_p > 8.05) => 0.0694839880,
      (c_hval_300k_p = NULL) => 0.0089764587, 0.0089764587), -0.0099237128),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 3.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 6.95) => 0.0584018889,
      (c_pop_65_74_p > 6.95) => -0.0435035874,
      (c_pop_65_74_p = NULL) => 0.0266550882, 0.0266550882),
   (k_inq_ssns_per_addr_i > 3.5) => 0.1524371355,
   (k_inq_ssns_per_addr_i = NULL) => 0.0383015741, 0.0383015741),
(k_inq_per_phone_i = NULL) => -0.0074601743, -0.0074601743);

// Tree: 42 
wFDN_FLAP_D_lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1448612708,
(r_D32_Mos_Since_Fel_LS_d > 125) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < c_employees and c_employees <= 40.5) => 0.0346054530,
      (c_employees > 40.5) => -0.0112939110,
      (c_employees = NULL) => -0.0362814029, -0.0062322652),
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.25) => 0.1661774457,
      (c_pop_0_5_p > 8.25) => 0.0109442985,
      (c_pop_0_5_p = NULL) => 0.0726744389, 0.0726744389),
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0051338697, -0.0051338697),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 97.5) => -0.0337266884,
   (c_unempl > 97.5) => 0.0577450629,
   (c_unempl = NULL) => 0.0025168357, 0.0025168357), -0.0041821404);

// Tree: 43 
wFDN_FLAP_D_lgt_43 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => -0.0073988687,
(f_phones_per_addr_curr_i > 7.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.1326146074,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 8.5) => -0.0004079510,
      (f_rel_ageover20_count_d > 8.5) => 
         map(
         (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 4.5) => 0.0703829357,
         (r_A50_pb_total_orders_d > 4.5) => -0.0580115298,
         (r_A50_pb_total_orders_d = NULL) => 0.0452459185, 0.0452459185),
      (f_rel_ageover20_count_d = NULL) => 0.0234248217, 0.0234248217),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0278505803, 0.0278505803),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 0.2) => -0.0637234199,
   (c_high_hval > 0.2) => 0.0620374859,
   (c_high_hval = NULL) => 0.0082581512, 0.0082581512), -0.0023825948);

// Tree: 44 
wFDN_FLAP_D_lgt_44 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => -0.0089666279,
   (r_L79_adls_per_addr_curr_i > 5.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 3.5) => 0.1753949831,
      (f_prevaddrageoldest_d > 3.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 26.05) => -0.0700682964,
         (C_OWNOCC_P > 26.05) => 0.0391122814,
         (C_OWNOCC_P = NULL) => 0.0242969394, 0.0242969394),
      (f_prevaddrageoldest_d = NULL) => 0.0356532006, 0.0356532006),
   (r_L79_adls_per_addr_curr_i = NULL) => -0.0044358227, -0.0044358227),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1029381022,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 91.5) => 0.0613341773,
   (c_many_cars > 91.5) => -0.0383320391,
   (c_many_cars = NULL) => 0.0076179697, 0.0076179697), -0.0037447232);

// Tree: 45 
wFDN_FLAP_D_lgt_45 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 2.05) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 139.5) => 0.0062394456,
      (c_serv_empl > 139.5) => 
         map(
         (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 4.5) => 0.0827708549,
         (f_rel_homeover200_count_d > 4.5) => 0.1969428068,
         (f_rel_homeover200_count_d = NULL) => 0.1258889856, 0.1258889856),
      (c_serv_empl = NULL) => 0.0434176150, 0.0434176150),
   (f_corraddrnamecount_d > 1.5) => -0.0106805975,
   (f_corraddrnamecount_d = NULL) => 0.0077904545, -0.0068942792),
(c_hh7p_p > 2.05) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 11.5) => 0.0261770334,
   (k_inq_per_addr_i > 11.5) => 0.1353383210,
   (k_inq_per_addr_i = NULL) => 0.0285544117, 0.0285544117),
(c_hh7p_p = NULL) => -0.0586367324, -0.0003823289);

// Tree: 46 
wFDN_FLAP_D_lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 31.25) => 0.1177461677,
      (c_newhouse > 31.25) => -0.0539991245,
      (c_newhouse = NULL) => 0.0690422789, 0.0690422789),
   (r_F00_input_dob_match_level_d > 4.5) => -0.0024664141,
   (r_F00_input_dob_match_level_d = NULL) => -0.0012009790, -0.0012009790),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 7.05) => 0.1900809900,
   (C_INC_25K_P > 7.05) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 886.5) => 0.1294207709,
      (c_popover25 > 886.5) => -0.0359628900,
      (c_popover25 = NULL) => 0.0358841103, 0.0358841103),
   (C_INC_25K_P = NULL) => 0.0813409939, 0.0813409939),
(r_D32_felony_count_i = NULL) => -0.0215420857, -0.0003847451);

// Tree: 47 
wFDN_FLAP_D_lgt_47 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0177843381,
   (f_crim_rel_under25miles_cnt_i > 0.5) => 
      map(
      (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 0.5) => 
         map(
         (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 0.0402565241,
         (f_hh_lienholders_i > 1.5) => 0.1628153856,
         (f_hh_lienholders_i = NULL) => 0.0488156125, 0.0488156125),
      (f_hh_workers_paw_d > 0.5) => -0.0004479338,
      (f_hh_workers_paw_d = NULL) => 0.0131538576, 0.0131538576),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0053894508, -0.0048477549),
(f_srchfraudsrchcountmo_i > 0.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 15.45) => 0.0414337761,
   (C_INC_125K_P > 15.45) => 0.2162695997,
   (C_INC_125K_P = NULL) => 0.0607338346, 0.0607338346),
(f_srchfraudsrchcountmo_i = NULL) => -0.0121270234, -0.0025291925);

// Tree: 48 
wFDN_FLAP_D_lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 29850) => 0.0888315118,
   (r_A46_Curr_AVM_AutoVal_d > 29850) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 0.1162187259,
      (r_C13_max_lres_d > 18.5) => -0.0030374805,
      (r_C13_max_lres_d = NULL) => -0.0009663841, -0.0009663841),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0157915824, -0.0062772081),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 29.55) => 0.0112226337,
   (c_rnt1000_p > 29.55) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 77.5) => 0.2253432075,
      (c_rest_indx > 77.5) => 0.0734463007,
      (c_rest_indx = NULL) => 0.1182251576, 0.1182251576),
   (c_rnt1000_p = NULL) => 0.0412736672, 0.0412736672),
(k_inq_per_phone_i = NULL) => -0.0039305902, -0.0039305902);

// Tree: 49 
wFDN_FLAP_D_lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 0.0918869310,
      (r_F00_input_dob_match_level_d > 5.5) => -0.0020920673,
      (r_F00_input_dob_match_level_d = NULL) => -0.0002165823, -0.0002165823),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 33) => 0.1602540230,
      (r_C10_M_Hdr_FS_d > 33) => 0.0316827128,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0599587341, 0.0599587341),
   (f_varrisktype_i = NULL) => 0.0024496348, 0.0024496348),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0736673504,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 7.3) => 0.0755463554,
   (c_rnt500_p > 7.3) => -0.0629021913,
   (c_rnt500_p = NULL) => 0.0164878844, 0.0164878844), -0.0004034020);

// Tree: 50 
wFDN_FLAP_D_lgt_50 := map(
(NULL < c_unemp and c_unemp <= 8.65) => -0.0016585311,
(c_unemp > 8.65) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 204.35) => 
      map(
      (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.2326750247,
      (f_property_owners_ct_d > 0.5) => 0.0672560020,
      (f_property_owners_ct_d = NULL) => 0.1349274204, 0.1349274204),
   (c_housingcpi > 204.35) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 22.65) => -0.0115536993,
      (c_rnt1000_p > 22.65) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 36921.5) => 0.2008996660,
         (f_curraddrmedianincome_d > 36921.5) => 0.0642982261,
         (f_curraddrmedianincome_d = NULL) => 0.0962144504, 0.0962144504),
      (c_rnt1000_p = NULL) => 0.0256846582, 0.0256846582),
   (c_housingcpi = NULL) => 0.0447770200, 0.0447770200),
(c_unemp = NULL) => -0.0076230916, 0.0010016909);

// Tree: 51 
wFDN_FLAP_D_lgt_51 := map(
(NULL < c_employees and c_employees <= 71.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 160.5) => 0.0135747733,
   (f_curraddrcrimeindex_i > 160.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 171.5) => 0.1477281017,
      (f_M_Bureau_ADL_FS_all_d > 171.5) => 0.0336345347,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0762593786, 0.0762593786),
   (f_curraddrcrimeindex_i = NULL) => 0.0221183106, 0.0221183106),
(c_employees > 71.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 6.1) => -0.0288240665,
      (c_hval_175k_p > 6.1) => 0.1539310164,
      (c_hval_175k_p = NULL) => 0.0735817989, 0.0735817989),
   (r_D33_Eviction_Recency_d > 48) => -0.0119718521,
   (r_D33_Eviction_Recency_d = NULL) => -0.0276183101, -0.0111572033),
(c_employees = NULL) => -0.0176606873, -0.0043647904);

// Tree: 52 
wFDN_FLAP_D_lgt_52 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => -0.0061000479,
   (k_comb_age_d > 71.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 175) => 0.0461379718,
      (c_sub_bus > 175) => 0.2517899807,
      (c_sub_bus = NULL) => 0.0639279380, 0.0639279380),
   (k_comb_age_d = NULL) => -0.0027702113, -0.0027702113),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 4.75) => 0.0409277438,
   (c_femdiv_p > 4.75) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.26110471735) => 0.4207277332,
      (f_add_curr_mobility_index_i > 0.26110471735) => 0.0454994436,
      (f_add_curr_mobility_index_i = NULL) => 0.2243465723, 0.2243465723),
   (c_femdiv_p = NULL) => 0.1266723181, 0.1266723181),
(r_P85_Phn_Disconnected_i = NULL) => -0.0001578906, -0.0001578906);

// Tree: 53 
wFDN_FLAP_D_lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 136.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0166759980,
   (r_D32_felony_count_i > 0.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.5) => -0.0095529636,
      (c_hval_125k_p > 4.5) => 0.1676333191,
      (c_hval_125k_p = NULL) => 0.0798241879, 0.0798241879),
   (r_D32_felony_count_i = NULL) => 0.0406667232, -0.0146641744),
(c_easiqlife > 136.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -16060.5) => 0.1009524583,
   (f_addrchangeincomediff_d > -16060.5) => 0.0134056000,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 3.145) => 0.0196196910,
      (c_hhsize > 3.145) => 0.1378445721,
      (c_hhsize = NULL) => 0.0427836666, 0.0427836666), 0.0219525546),
(c_easiqlife = NULL) => -0.0201780422, -0.0027688997);

// Tree: 54 
wFDN_FLAP_D_lgt_54 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 141.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 2.65) => -0.0476953484,
      (c_hh5_p > 2.65) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 9.5) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 143.5) => -0.0832585142,
            (c_span_lang > 143.5) => 0.0922328552,
            (c_span_lang = NULL) => -0.0189695967, -0.0189695967),
         (f_addrchangecrimediff_i > 9.5) => 0.1239248082,
         (f_addrchangecrimediff_i = NULL) => 0.0541187324, 0.0355100784),
      (c_hh5_p = NULL) => 0.0081548696, 0.0081548696),
   (f_prevaddrageoldest_d > 141.5) => 0.1481744215,
   (f_prevaddrageoldest_d = NULL) => 0.0309487501, 0.0309487501),
(r_F01_inp_addr_address_score_d > 25) => -0.0056819197,
(r_F01_inp_addr_address_score_d = NULL) => -0.0052333244, -0.0035644927);

// Tree: 55 
wFDN_FLAP_D_lgt_55 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1375550241,
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 65.5) => -0.0096981105,
   (k_comb_age_d > 65.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 3.5) => 
         map(
         (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 4.5) => 0.0173899900,
         (f_srchphonesrchcount_i > 4.5) => 0.2416816017,
         (f_srchphonesrchcount_i = NULL) => 0.0285653588, 0.0285653588),
      (f_srchvelocityrisktype_i > 3.5) => 0.1569620698,
      (f_srchvelocityrisktype_i = NULL) => 0.0376396999, 0.0376396999),
   (k_comb_age_d = NULL) => -0.0050054994, -0.0050054994),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 124.5) => -0.0408763046,
   (c_totcrime > 124.5) => 0.0589956414,
   (c_totcrime = NULL) => -0.0121774695, -0.0121774695), -0.0044246166);

// Tree: 56 
wFDN_FLAP_D_lgt_56 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
      map(
      (NULL < c_food and c_food <= 62.6) => 0.0086259465,
      (c_food > 62.6) => 0.1166831048,
      (c_food = NULL) => 0.0114051808, 0.0128869989),
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 3726) => 0.0711907478,
      (r_A49_Curr_AVM_Chg_1yr_i > 3726) => 0.3034844760,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0714979438, 0.1059414137),
   (r_L70_Add_Standardized_i = NULL) => 0.0207815486, 0.0207815486),
(f_phone_ver_experian_d > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => -0.0247062462,
   (f_inq_HighRiskCredit_count_i > 1.5) => 0.0706692495,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0213958552, -0.0213958552),
(f_phone_ver_experian_d = NULL) => -0.0098313336, -0.0053537823);

// Tree: 57 
wFDN_FLAP_D_lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 0.0102845324,
   (f_historical_count_d > 0.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 241.75) => -0.0270682003,
      (c_housingcpi > 241.75) => 0.0705175930,
      (c_housingcpi = NULL) => -0.0400599257, -0.0213374820),
   (f_historical_count_d = NULL) => -0.0056546236, -0.0056546236),
(r_D30_Derog_Count_i > 11.5) => 0.0663221620,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => -0.0965861726,
   (k_comb_age_d > 24.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0275968386,
      (c_pop_35_44_p > 16.05) => 0.0982588386,
      (c_pop_35_44_p = NULL) => 0.0334981503, 0.0334981503),
   (k_comb_age_d = NULL) => -0.0050184369, -0.0050184369), -0.0046980106);

// Tree: 58 
wFDN_FLAP_D_lgt_58 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0097250732,
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 55.95) => 0.1421075448,
      (c_low_ed > 55.95) => -0.0676557812,
      (c_low_ed = NULL) => 0.0972863213, 0.0972863213),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0075493229, -0.0075493229),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0431400013,
      (r_Phn_Cell_n > 0.5) => 0.2514873450,
      (r_Phn_Cell_n = NULL) => 0.1167353317, 0.1167353317),
   (f_srchfraudsrchcount_i > 1.5) => 0.0148114907,
   (f_srchfraudsrchcount_i = NULL) => 0.0471759331, 0.0471759331),
(k_inq_per_phone_i = NULL) => -0.0048098245, -0.0048098245);

// Tree: 59 
wFDN_FLAP_D_lgt_59 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0071696960,
   (f_nae_nothing_found_i > 0.5) => 0.1099237636,
   (f_nae_nothing_found_i = NULL) => -0.0055855356, -0.0055855356),
(f_divaddrsuspidcountnew_i > 2.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.95) => -0.0301273645,
   (c_pop_35_44_p > 12.95) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.35745001815) => 0.1892727780,
      (f_add_input_nhood_MFD_pct_i > 0.35745001815) => 0.0698056133,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.1280642924, 0.1280642924),
   (c_pop_35_44_p = NULL) => 0.0684856164, 0.0684856164),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 99.5) => -0.0687242995,
   (c_assault > 99.5) => 0.0436165213,
   (c_assault = NULL) => -0.0203656680, -0.0203656680), -0.0039629130);

// Tree: 60 
wFDN_FLAP_D_lgt_60 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_adl_util_inf_n and f_adl_util_inf_n <= 0.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 112.5) => -0.0022360392,
      (f_prevaddrageoldest_d > 112.5) => 0.0496697689,
      (f_prevaddrageoldest_d = NULL) => 0.0115597493, 0.0115597493),
   (f_adl_util_inf_n > 0.5) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 1.35) => 0.2549731116,
      (c_rnt1250_p > 1.35) => 0.0266900035,
      (c_rnt1250_p = NULL) => 0.1188812587, 0.1188812587),
   (f_adl_util_inf_n = NULL) => 0.0146088765, 0.0146088765),
(f_corrphonelastnamecount_d > 0.5) => -0.0177827420,
(f_corrphonelastnamecount_d = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 10.85) => 0.0598829900,
   (c_pop_25_34_p > 10.85) => -0.0575930953,
   (c_pop_25_34_p = NULL) => -0.0072462016, -0.0072462016), -0.0035298581);

// Tree: 61 
wFDN_FLAP_D_lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 9) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.01919518585) => 0.0040739378,
      (f_add_curr_nhood_BUS_pct_i > 0.01919518585) => 0.1400328019,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0916406638, 0.0916406638),
   (c_low_hval > 9) => -0.0540002340,
   (c_low_hval = NULL) => 0.0549295284, 0.0549295284),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0036439755,
   (c_lar_fam > 181.5) => 0.1169500845,
   (c_lar_fam = NULL) => -0.0205467919, -0.0026760652),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 95.5) => 0.0566014244,
   (c_rest_indx > 95.5) => -0.0386723045,
   (c_rest_indx = NULL) => -0.0075251239, -0.0075251239), -0.0016341815);

// Tree: 62 
wFDN_FLAP_D_lgt_62 := map(
(NULL < c_easiqlife and c_easiqlife <= 135.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.0198853119,
   (f_corraddrnamecount_d > 3.5) => -0.0185144489,
   (f_corraddrnamecount_d = NULL) => 0.0366156980, -0.0116662736),
(c_easiqlife > 135.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 79.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 12.5) => 0.0178505423,
      (f_crim_rel_under500miles_cnt_i > 12.5) => -0.0795829270,
      (f_crim_rel_under500miles_cnt_i = NULL) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 51.25) => -0.0477087043,
         (c_sfdu_p > 51.25) => 0.1397601870,
         (c_sfdu_p = NULL) => 0.0665301513, 0.0665301513), 0.0181277922),
   (k_comb_age_d > 79.5) => 0.1722646668,
   (k_comb_age_d = NULL) => 0.0207256047, 0.0207256047),
(c_easiqlife = NULL) => -0.0284167686, -0.0011404194);

// Tree: 63 
wFDN_FLAP_D_lgt_63 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0286281026) => -0.0330021192,
   (f_add_input_nhood_BUS_pct_i > 0.0286281026) => 0.0969170857,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0426567119, 0.0426567119),
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1049144623,
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0112519976,
      (f_prevaddrageoldest_d > 151.5) => 0.0262392298,
      (f_prevaddrageoldest_d = NULL) => -0.0023275517, -0.0023275517),
   (f_hh_age_18_plus_d = NULL) => -0.0017970812, -0.0017970812),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 4.05) => 0.0346343566,
   (c_pop_75_84_p > 4.05) => -0.0538704935,
   (c_pop_75_84_p = NULL) => -0.0036989543, -0.0036989543), -0.0012031835);

// Tree: 64 
wFDN_FLAP_D_lgt_64 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 
   map(
   (NULL < c_retail and c_retail <= 12.8) => 0.0014521499,
   (c_retail > 12.8) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 34.2) => 0.2123716076,
      (c_high_ed > 34.2) => 0.0242771596,
      (c_high_ed = NULL) => 0.1240489972, 0.1240489972),
   (c_retail = NULL) => 0.0507480850, 0.0507480850),
(r_C21_M_Bureau_ADL_FS_d > 8.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => -0.0066204649,
   (f_prevaddrageoldest_d > 271.5) => 0.0550755157,
   (f_prevaddrageoldest_d = NULL) => -0.0012520805, -0.0012520805),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 1.85) => -0.0525197755,
   (c_hh6_p > 1.85) => 0.0441514128,
   (c_hh6_p = NULL) => -0.0120387154, -0.0120387154), -0.0002149374);

// Tree: 65 
wFDN_FLAP_D_lgt_65 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 1.55) => 0.0356111562,
   (c_hh7p_p > 1.55) => 0.1666528265,
   (c_hh7p_p = NULL) => 0.0705174526, 0.0705174526),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0066707915,
   (f_prevaddrageoldest_d > 151.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 0.0230753557,
      (f_corrrisktype_i > 8.5) => 0.1148646687,
      (f_corrrisktype_i = NULL) => 0.0283337943, 0.0283337943),
   (f_prevaddrageoldest_d = NULL) => 0.0017533828, 0.0017533828),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.8) => 0.0572607052,
   (c_construction > 4.8) => -0.0513429208,
   (c_construction = NULL) => -0.0009198087, -0.0009198087), 0.0029586738);

// Tree: 66 
wFDN_FLAP_D_lgt_66 := map(
(NULL < c_born_usa and c_born_usa <= 34.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6423) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 75.5) => -0.0083358228,
      (r_C13_Curr_Addr_LRes_d > 75.5) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 529252) => 0.0265307513,
         (c_med_hval > 529252) => 0.1782442002,
         (c_med_hval = NULL) => 0.0644591135, 0.0644591135),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0206012947, 0.0206012947),
   (f_addrchangeincomediff_d > 6423) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 292750) => 0.2105870136,
      (f_curraddrmedianvalue_d > 292750) => 0.0165639845,
      (f_curraddrmedianvalue_d = NULL) => 0.1089559031, 0.1089559031),
   (f_addrchangeincomediff_d = NULL) => 0.0283265880, 0.0261771799),
(c_born_usa > 34.5) => -0.0076057859,
(c_born_usa = NULL) => -0.0109572167, -0.0002349808);

// Tree: 67 
wFDN_FLAP_D_lgt_67 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 13.5) => -0.0042462532,
(f_addrchangecrimediff_i > 13.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0199084457,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.0993772874,
      (nf_seg_FraudPoint_3_0 = '') => 0.0128159589, 0.0128159589),
   (r_L79_adls_per_addr_c6_i > 2.5) => 0.1396741036,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0352932516, 0.0352932516),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 131314.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 0.5) => 0.1979846627,
      (f_prevaddrlenofres_d > 0.5) => 0.0385713875,
      (f_prevaddrlenofres_d = NULL) => 0.0586993263, 0.0586993263),
   (r_L80_Inp_AVM_AutoVal_d > 131314.5) => 0.0082248501,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0159987768, 0.0019305327), -0.0015552788);

// Tree: 68 
wFDN_FLAP_D_lgt_68 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.15) => -0.0015350765,
   (c_pop_6_11_p > 8.15) => 0.1776426380,
   (c_pop_6_11_p = NULL) => 0.0866754906, 0.0866754906),
(f_attr_arrest_recency_d > 99.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.39166436105) => 
      map(
      (NULL < c_unempl and c_unempl <= 192.5) => 0.0041948280,
      (c_unempl > 192.5) => 0.1112623272,
      (c_unempl = NULL) => 0.0206953075, 0.0050324737),
   (f_add_input_mobility_index_i > 0.39166436105) => -0.0332929590,
   (f_add_input_mobility_index_i = NULL) => 0.0188075775, -0.0008706417),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0526516751,
   (c_pop_35_44_p > 16.05) => 0.0434444674,
   (c_pop_35_44_p = NULL) => -0.0070996076, -0.0070996076), -0.0000657579);

// Tree: 69 
wFDN_FLAP_D_lgt_69 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => -0.0071329429,
   (f_inq_Communications_count24_i > 2.5) => 0.0927034340,
   (f_inq_Communications_count24_i = NULL) => -0.0065991464, -0.0065991464),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 11.5) => 0.1327846350,
      (f_rel_ageover20_count_d > 11.5) => 0.0006334168,
      (f_rel_ageover20_count_d = NULL) => 0.0759288783, 0.0759288783),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0337669611,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0486616268, 0.0486616268),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0283134311,
   (k_nap_phn_verd_d > 0.5) => -0.1075362620,
   (k_nap_phn_verd_d = NULL) => -0.0174786003, -0.0174786003), -0.0052270748);

// Tree: 70 
wFDN_FLAP_D_lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 65.95) => -0.0053489719,
      (C_RENTOCC_P > 65.95) => -0.0446336851,
      (C_RENTOCC_P = NULL) => -0.0086846993, -0.0086846993),
   (f_phones_per_addr_curr_i > 50.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 130) => 0.0082111241,
      (r_C13_max_lres_d > 130) => 0.2077214070,
      (r_C13_max_lres_d = NULL) => 0.0865901638, 0.0865901638),
   (f_phones_per_addr_curr_i = NULL) => 0.0005201242, -0.0071714126),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.1298907699,
   (r_F01_inp_addr_address_score_d > 75) => 0.0451242929,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0496653542, 0.0496653542),
(c_hval_750k_p = NULL) => 0.0159265247, -0.0023640898);

// Tree: 71 
wFDN_FLAP_D_lgt_71 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 23.5) => -0.0335046681,
   (f_mos_inq_banko_om_fseen_d > 23.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 88.35) => 0.1811257369,
         (c_occunit_p > 88.35) => 0.0754113389,
         (c_occunit_p = NULL) => 0.0988502778, 0.0988502778),
      (f_current_count_d > 0.5) => 0.0041751782,
      (f_current_count_d = NULL) => 0.0567337813, 0.0567337813),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0309739437, 0.0309739437),
(r_I60_inq_comm_recency_d > 549) => 0.0007931074,
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 14.65) => -0.0423589463,
   (c_hh4_p > 14.65) => 0.0546599733,
   (c_hh4_p = NULL) => -0.0055163186, -0.0055163186), 0.0034162082);

// Tree: 72 
wFDN_FLAP_D_lgt_72 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i <= 48) => 
      map(
      (NULL < r_P85_Phn_Not_Issued_i and r_P85_Phn_Not_Issued_i <= 0.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0137218534,
         (f_corrphonelastnamecount_d > 0.5) => -0.0187014834,
         (f_corrphonelastnamecount_d = NULL) => -0.0048625820, -0.0048625820),
      (r_P85_Phn_Not_Issued_i > 0.5) => -0.0723048565,
      (r_P85_Phn_Not_Issued_i = NULL) => -0.0064614643, -0.0064614643),
   (r_C12_NonDerog_Recency_i > 48) => 0.1376186041,
   (r_C12_NonDerog_Recency_i = NULL) => -0.0058577931, -0.0058577931),
(f_assocsuspicousidcount_i > 15.5) => 0.1070505649,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0977158452,
   (k_comb_age_d > 25.5) => 0.0118322423,
   (k_comb_age_d = NULL) => -0.0227339018, -0.0227339018), -0.0055368230);

// Tree: 73 
wFDN_FLAP_D_lgt_73 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.15) => -0.0082396702,
   (c_pop_12_17_p > 10.15) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.1639059874,
      (r_C10_M_Hdr_FS_d > 13.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 138) => 0.0096068038,
         (f_curraddrcrimeindex_i > 138) => 
            map(
            (NULL < c_employees and c_employees <= 40.5) => 0.1643448598,
            (c_employees > 40.5) => 0.0357222004,
            (c_employees = NULL) => 0.0720003864, 0.0720003864),
         (f_curraddrcrimeindex_i = NULL) => 0.0196034476, 0.0196034476),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0224604442, 0.0224604442),
   (c_pop_12_17_p = NULL) => -0.0004994007, -0.0006892606),
(f_inq_PrepaidCards_count_i > 1.5) => 0.0682051936,
(f_inq_PrepaidCards_count_i = NULL) => -0.0076100003, -0.0000292590);

// Tree: 74 
wFDN_FLAP_D_lgt_74 := map(
(NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 4.25) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.0917959958,
      (r_C12_Num_NonDerogs_d > 3.5) => -0.0441555328,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0395069463, 0.0395069463),
   (c_high_ed > 4.25) => -0.0061849904,
   (c_high_ed = NULL) => 0.0517004853, -0.0036246505),
(f_srchphonesrchcountwk_i > 0.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 0.45) => -0.0129759911,
   (c_bigapt_p > 0.45) => 0.1615266848,
   (c_bigapt_p = NULL) => 0.0802697136, 0.0802697136),
(f_srchphonesrchcountwk_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0452348987,
   (c_assault > 90) => 0.0628363948,
   (c_assault = NULL) => -0.0013798810, -0.0013798810), -0.0027092203);

// Tree: 75 
wFDN_FLAP_D_lgt_75 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 28.75) => -0.0096856566,
      (c_hval_20k_p > 28.75) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 72.5) => 0.1829416492,
         (c_many_cars > 72.5) => -0.0066300172,
         (c_many_cars = NULL) => 0.0845789921, 0.0845789921),
      (c_hval_20k_p = NULL) => -0.0229139763, -0.0091041273),
   (f_bus_addr_match_count_d > 52.5) => 0.2062461398,
   (f_bus_addr_match_count_d = NULL) => -0.0078980470, -0.0078980470),
(f_prevaddroccupantowned_i > 0.5) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 3.5) => 0.0252443046,
   (f_assoccredbureaucount_i > 3.5) => 0.1308289639,
   (f_assoccredbureaucount_i = NULL) => 0.0328852997, 0.0328852997),
(f_prevaddroccupantowned_i = NULL) => -0.0281917189, -0.0052330593);

// Tree: 76 
wFDN_FLAP_D_lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0114047929,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => -0.0015915863,
         (f_prevaddrlenofres_d > 123.5) => 
            map(
            (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0423250229,
            (f_rel_homeover500_count_d > 3.5) => 0.1977438625,
            (f_rel_homeover500_count_d = NULL) => 0.0674815091, 0.0674815091),
         (f_prevaddrlenofres_d = NULL) => 0.0171114096, 0.0171114096),
      (f_inq_Communications_count24_i > 1.5) => 0.1215589257,
      (f_inq_Communications_count24_i = NULL) => 0.0193115914, 0.0193115914),
   (f_nae_nothing_found_i > 0.5) => 0.2175862112,
   (f_nae_nothing_found_i = NULL) => 0.0224105127, 0.0224105127),
(c_rnt1250_p = NULL) => -0.0019969958, -0.0018199916);

// Tree: 77 
wFDN_FLAP_D_lgt_77 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 64.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.75) => 0.2236946466,
   (r_C12_source_profile_d > 57.75) => -0.0232601761,
   (r_C12_source_profile_d = NULL) => 0.0913397743, 0.0913397743),
(f_mos_liens_unrel_SC_fseen_d > 64.5) => 
   map(
   (NULL < c_transport and c_transport <= 29.05) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27836.5) => 0.0402106799,
      (f_curraddrmedianincome_d > 27836.5) => -0.0063744455,
      (f_curraddrmedianincome_d = NULL) => -0.0033458247, -0.0033458247),
   (c_transport > 29.05) => 0.1110620400,
   (c_transport = NULL) => 0.0001284890, -0.0014373801),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 111.5) => -0.0406786512,
   (c_for_sale > 111.5) => 0.0662591166,
   (c_for_sale = NULL) => 0.0066067564, 0.0066067564), -0.0002054715);

// Tree: 78 
wFDN_FLAP_D_lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0450298596,
         (f_varrisktype_i > 2.5) => 0.1809085497,
         (f_varrisktype_i = NULL) => 0.0989127884, 0.0989127884),
      (r_C13_max_lres_d > 18.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 0.0001923407,
         (f_varrisktype_i > 4.5) => 0.0627788683,
         (f_varrisktype_i = NULL) => 0.0013388728, 0.0013388728),
      (r_C13_max_lres_d = NULL) => 0.0027909650, 0.0027909650),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0597339524,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0195283178, 0.0003801574),
(r_L77_Add_PO_Box_i > 0.5) => -0.1039298083,
(r_L77_Add_PO_Box_i = NULL) => -0.0020538788, -0.0020538788);

// Tree: 79 
wFDN_FLAP_D_lgt_79 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30362.5) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 64002) => -0.0491825351,
   (c_med_hval > 64002) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 47.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
            map(
            (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 0.1567207304,
            (r_Prop_Owner_History_d > 0.5) => -0.0042301518,
            (r_Prop_Owner_History_d = NULL) => 0.0705423053, 0.0705423053),
         (f_srchvelocityrisktype_i > 4.5) => 0.2041660609,
         (f_srchvelocityrisktype_i = NULL) => 0.1082891289, 0.1082891289),
      (f_mos_inq_banko_cm_lseen_d > 47.5) => 0.0303643419,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0478013676, 0.0478013676),
   (c_med_hval = NULL) => 0.0087923984, 0.0263585403),
(f_curraddrmedianincome_d > 30362.5) => -0.0064875106,
(f_curraddrmedianincome_d = NULL) => -0.0179627640, -0.0036083426);

// Tree: 80 
wFDN_FLAP_D_lgt_80 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0103736428,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 26.5) => 0.2123539784,
      (c_born_usa > 26.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 10.5) => 0.0122827746,
         (f_rel_under25miles_cnt_d > 10.5) => 0.1439094071,
         (f_rel_under25miles_cnt_d = NULL) => 0.0408018783, 0.0408018783),
      (c_born_usa = NULL) => 0.0731484022, 0.0731484022),
   (f_prevaddrlenofres_d > 3.5) => 0.0132609454,
   (f_prevaddrlenofres_d = NULL) => 0.0177716753, 0.0177716753),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 6.35) => -0.0269371857,
   (c_hval_250k_p > 6.35) => 0.0617947641,
   (c_hval_250k_p = NULL) => 0.0171349748, 0.0171349748), -0.0011502028);

// Tree: 81 
wFDN_FLAP_D_lgt_81 := map(
(NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0125512953,
(f_inq_Other_count_i > 0.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 3.455) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 17.15) => -0.0076222207,
      (c_hh3_p > 17.15) => 0.0465951168,
      (c_hh3_p = NULL) => 0.0148586404, 0.0148586404),
   (c_hhsize > 3.455) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 8.15) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 32.75) => 0.2797302402,
         (C_RENTOCC_P > 32.75) => 0.0549779746,
         (C_RENTOCC_P = NULL) => 0.1644225561, 0.1644225561),
      (C_INC_200K_P > 8.15) => -0.0640181803,
      (C_INC_200K_P = NULL) => 0.0923549428, 0.0923549428),
   (c_hhsize = NULL) => 0.0195017855, 0.0195017855),
(f_inq_Other_count_i = NULL) => -0.0156988860, -0.0054520154);

// Tree: 82 
wFDN_FLAP_D_lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => -0.0027849574,
   (f_inq_HighRiskCredit_count_i > 4.5) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 3.05) => 0.1047533904,
      (c_low_hval > 3.05) => -0.0245135176,
      (c_low_hval = NULL) => 0.0568767578, 0.0568767578),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0020015159, -0.0020015159),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0691786655,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.45223816965) => -0.0290430860,
      (f_add_input_nhood_SFD_pct_d > 0.45223816965) => 0.0713121007,
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.0268067570, 0.0268067570),
   (k_nap_phn_verd_d > 0.5) => -0.1108462922,
   (k_nap_phn_verd_d = NULL) => -0.0224099757, -0.0224099757), -0.0027820117);

// Tree: 83 
wFDN_FLAP_D_lgt_83 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0028313926,
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 24.85) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 258.5) => -0.0173210129,
         (r_C21_M_Bureau_ADL_FS_d > 258.5) => 0.1304081485,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0353035381, 0.0353035381),
      (c_highrent > 24.85) => 0.1711495388,
      (c_highrent = NULL) => 0.0728510352, 0.0728510352),
   (f_phone_ver_experian_d > 0.5) => 0.0203356900,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 43.6) => 0.0807357455,
      (C_OWNOCC_P > 43.6) => -0.0521426079,
      (C_OWNOCC_P = NULL) => -0.0066021393, -0.0066021393), 0.0291089429),
(k_inq_per_phone_i = NULL) => 0.0003437562, 0.0003437562);

// Tree: 84 
wFDN_FLAP_D_lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 309.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 67.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 2) => 0.1391160099,
         (r_I60_inq_banking_recency_d > 2) => 0.0094527281,
         (r_I60_inq_banking_recency_d = NULL) => 0.0121561324, 0.0121561324),
      (f_phone_ver_experian_d > 0.5) => -0.0237136372,
      (f_phone_ver_experian_d = NULL) => -0.0060090696, -0.0080328904),
   (f_bus_addr_match_count_d > 67.5) => 0.1754570922,
   (f_bus_addr_match_count_d = NULL) => -0.0070512439, -0.0070512439),
(r_C13_Curr_Addr_LRes_d > 309.5) => 0.0694328176,
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0962449824,
   (k_comb_age_d > 25.5) => 0.0535106349,
   (k_comb_age_d = NULL) => 0.0038590398, 0.0038590398), -0.0025371157);

// Tree: 85 
wFDN_FLAP_D_lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0107663814,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < c_health and c_health <= 2.25) => 
         map(
         (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 1.5) => 0.1769070222,
         (f_addrchangeecontrajindex_d > 1.5) => 
            map(
            (NULL < c_easiqlife and c_easiqlife <= 144.5) => -0.0536360598,
            (c_easiqlife > 144.5) => 0.1590177866,
            (c_easiqlife = NULL) => 0.0172485557, 0.0172485557),
         (f_addrchangeecontrajindex_d = NULL) => 0.0800088691, 0.0639532126),
      (c_health > 2.25) => -0.0009038158,
      (c_health = NULL) => 0.0165177660, 0.0165177660),
   (r_F01_inp_addr_not_verified_i > 0.5) => 0.1246787279,
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0228021343, 0.0228021343),
(f_util_adl_count_n = NULL) => -0.0020268707, -0.0065296645);

// Tree: 86 
wFDN_FLAP_D_lgt_86 := map(
(NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 0.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => -0.0020531386,
   (f_phones_per_addr_curr_i > 13.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 134) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 222.95) => -0.0162730850,
         (c_cpiall > 222.95) => 0.0981422389,
         (c_cpiall = NULL) => 0.0139023851, 0.0139023851),
      (f_curraddrcrimeindex_i > 134) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 0.0599433800,
         (f_rel_under25miles_cnt_d > 4.5) => 0.1947778293,
         (f_rel_under25miles_cnt_d = NULL) => 0.1221011049, 0.1221011049),
      (f_curraddrcrimeindex_i = NULL) => 0.0394766279, 0.0394766279),
   (f_phones_per_addr_curr_i = NULL) => -0.0000019092, -0.0000019092),
(nf_vf_lexid_hi_summary > 0.5) => -0.0571750087,
(nf_vf_lexid_hi_summary = NULL) => -0.0115364496, -0.0013158148);

// Tree: 87 
wFDN_FLAP_D_lgt_87 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 48.5) => 0.1901621056,
   (c_exp_prod > 48.5) => 0.0222456804,
   (c_exp_prod = NULL) => 0.0571530376, 0.0571530376),
(r_F00_dob_score_d > 92) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2586) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 103) => -0.0137729067,
      (f_addrchangecrimediff_i > 103) => 0.1252663998,
      (f_addrchangecrimediff_i = NULL) => -0.0129340811, -0.0129340811),
   (f_addrchangeincomediff_d > 2586) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 153.5) => 0.0230225930,
      (c_easiqlife > 153.5) => 0.2182413880,
      (c_easiqlife = NULL) => 0.0449349067, 0.0449349067),
   (f_addrchangeincomediff_d = NULL) => -0.0057598781, -0.0090115964),
(r_F00_dob_score_d = NULL) => -0.0078872674, -0.0073540094);

// Tree: 88 
wFDN_FLAP_D_lgt_88 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 107) => -0.0120621212,
   (c_rich_fam > 107) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 9.05) => 0.2075201612,
      (c_high_hval > 9.05) => 0.0527852999,
      (c_high_hval = NULL) => 0.1308497344, 0.1308497344),
   (c_rich_fam = NULL) => 0.0613786935, 0.0613786935),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => -0.0175544651,
   (f_crim_rel_under500miles_cnt_i > 0.5) => 0.0125306818,
   (f_crim_rel_under500miles_cnt_i = NULL) => 0.0001308972, -0.0016103850),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 16.35) => -0.0374859401,
   (c_retail > 16.35) => 0.0848482443,
   (c_retail = NULL) => 0.0065191622, 0.0065191622), -0.0004158842);

// Tree: 89 
wFDN_FLAP_D_lgt_89 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 137.5) => -0.0009125970,
   (c_easiqlife > 137.5) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 163.5) => 0.0403196497,
      (c_very_rich > 163.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 78) => 0.3230296093,
         (c_burglary > 78) => 0.0180678029,
         (c_burglary = NULL) => 0.1712998436, 0.1712998436),
      (c_very_rich = NULL) => 0.0707418229, 0.0707418229),
   (c_easiqlife = NULL) => 0.0588989306, 0.0215818811),
(r_C14_addrs_10yr_i > 0.5) => -0.0084557964,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1173.5) => 0.0522260280,
   (c_popover25 > 1173.5) => -0.0351121406,
   (c_popover25 = NULL) => 0.0094132003, 0.0094132003), -0.0010135938);

// Tree: 90 
wFDN_FLAP_D_lgt_90 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 14.5) => 
   map(
   (NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => -0.0006937284,
      (k_inq_adls_per_addr_i > 4.5) => -0.0893994387,
      (k_inq_adls_per_addr_i = NULL) => -0.0015531259, -0.0015531259),
   (f_srchphonesrchcountwk_i > 0.5) => 0.1027908209,
   (f_srchphonesrchcountwk_i = NULL) => -0.0006353168, -0.0006353168),
(f_srchphonesrchcount_i > 14.5) => 
   map(
   (NULL < c_professional and c_professional <= 4.45) => -0.1427669059,
   (c_professional > 4.45) => 0.0189820485,
   (c_professional = NULL) => -0.0728913576, -0.0728913576),
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 329.5) => -0.0586185968,
   (c_employees > 329.5) => 0.0387245401,
   (c_employees = NULL) => -0.0146789864, -0.0146789864), -0.0015333335);

// Tree: 91 
wFDN_FLAP_D_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.45) => 0.0333139764,
   (c_retired > 15.45) => 0.2037520285,
   (c_retired = NULL) => 0.0777071434, 0.0777071434),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => -0.0086856638,
   (c_food > 65.55) => 
      map(
      (NULL < nf_vf_level and nf_vf_level <= 0.5) => 0.0233716078,
      (nf_vf_level > 0.5) => 0.1341332520,
      (nf_vf_level = NULL) => 0.0464892904, 0.0464892904),
   (c_food = NULL) => -0.0007089418, -0.0065621647),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0927119875,
   (k_comb_age_d > 25.5) => 0.0288724546,
   (k_comb_age_d = NULL) => -0.0084318628, -0.0084318628), -0.0051598127);

// Tree: 92 
wFDN_FLAP_D_lgt_92 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 28.5) => -0.0368117934,
   (f_mos_inq_banko_om_fseen_d > 28.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.1008186251,
      (r_D33_Eviction_Recency_d > 30) => 
         map(
         (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => 0.0008963883,
         (r_D32_criminal_count_i > 10.5) => 0.1136727798,
         (r_D32_criminal_count_i = NULL) => 0.0016246215, 0.0016246215),
      (r_D33_Eviction_Recency_d = NULL) => 0.0023302876, 0.0023302876),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0278933899, -0.0009478065),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 8.25) => 0.1690047388,
   (c_newhouse > 8.25) => 0.0123190772,
   (c_newhouse = NULL) => 0.0700870231, 0.0700870231),
(k_nap_contradictory_i = NULL) => 0.0002673735, 0.0002673735);

// Tree: 93 
wFDN_FLAP_D_lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0016441103,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_food and c_food <= 18.7) => 0.1379928847,
         (c_food > 18.7) => -0.0044082451,
         (c_food = NULL) => 0.0742871161, 0.0742871161),
      (r_D33_eviction_count_i = NULL) => 0.0023558070, 0.0023558070),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 58.5) => 0.0977721407,
      (r_pb_order_freq_d > 58.5) => -0.0488228971,
      (r_pb_order_freq_d = NULL) => 0.1312687805, 0.0780562650),
   (f_curraddrcartheftindex_i = NULL) => 0.0076672457, 0.0038135729),
(c_cartheft > 189.5) => -0.0602844971,
(c_cartheft = NULL) => -0.0115760164, 0.0014055583);

// Tree: 94 
wFDN_FLAP_D_lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 0.85) => -0.0087086210,
   (c_hh7p_p > 0.85) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 0.1137349486,
      (r_C21_M_Bureau_ADL_FS_d > 6.5) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.69301788395) => 0.0420244243,
         (f_add_curr_nhood_SFD_pct_d > 0.69301788395) => 0.0002657122,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0133773638, 0.0133773638),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0181477858, 0.0149413628),
   (c_hh7p_p = NULL) => -0.0001974800, -0.0001974800),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 0.0052898521,
   (f_sourcerisktype_i > 5.5) => 0.1257830453,
   (f_sourcerisktype_i = NULL) => 0.0573429116, 0.0573429116),
(c_famotf18_p = NULL) => 0.0005677613, 0.0004095263);

// Tree: 95 
wFDN_FLAP_D_lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => -0.0099265420,
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 30.65) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.4362033712) => 0.0148801172,
         (f_add_curr_mobility_index_i > 0.4362033712) => -0.0685371891,
         (f_add_curr_mobility_index_i = NULL) => 0.0071703359, 0.0071703359),
      (C_INC_75K_P > 30.65) => 0.1825252445,
      (C_INC_75K_P = NULL) => 0.0141591185, 0.0141591185),
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 32.7) => 0.2530824673,
      (c_fammar18_p > 32.7) => 0.0564805964,
      (c_fammar18_p = NULL) => 0.1257240226, 0.1257240226),
   (f_hh_collections_ct_i = NULL) => 0.0256853171, 0.0256853171),
(c_rnt1000_p = NULL) => -0.0209089901, -0.0057799202);

// Tree: 96 
wFDN_FLAP_D_lgt_96 := map(
(NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0138979258,
(k_inf_nothing_found_i > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 0.0039658834,
      (k_inq_per_addr_i > 6.5) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 66.3) => 0.0088152508,
         (c_sfdu_p > 66.3) => 0.1579131507,
         (c_sfdu_p = NULL) => 0.0881597472, 0.0881597472),
      (k_inq_per_addr_i = NULL) => 0.0068558712, 0.0068558712),
   (f_srchfraudsrchcountmo_i > 0.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 13.5) => 0.0603359512,
      (f_rel_educationover12_count_d > 13.5) => 0.1859838812,
      (f_rel_educationover12_count_d = NULL) => 0.0952381540, 0.0952381540),
   (f_srchfraudsrchcountmo_i = NULL) => 0.0022358170, 0.0098422006),
(k_inf_nothing_found_i = NULL) => -0.0039583270, -0.0039583270);

// Tree: 97 
wFDN_FLAP_D_lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.55) => -0.0058620541,
   (c_unemp > 8.55) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 68391) => 
         map(
         (NULL < c_blue_col and c_blue_col <= 13.6) => 0.1939922720,
         (c_blue_col > 13.6) => 0.0209429422,
         (c_blue_col = NULL) => 0.1051704921, 0.1051704921),
      (r_A46_Curr_AVM_AutoVal_d > 68391) => -0.0089375027,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0356964863, 0.0308578685),
   (c_unemp = NULL) => 0.0133753757, -0.0032235177),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 6.5) => 0.0050486095,
   (c_rnt1250_p > 6.5) => 0.1233471675,
   (c_rnt1250_p = NULL) => 0.0582371084, 0.0582371084),
(r_D33_eviction_count_i = NULL) => -0.0157436026, -0.0027751672);

// Tree: 98 
wFDN_FLAP_D_lgt_98 := map(
(NULL < c_hh4_p and c_hh4_p <= 10.15) => -0.0197502282,
(c_hh4_p > 10.15) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 0.0001903250,
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < c_preschl and c_preschl <= 178.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 10.8) => 
            map(
            (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 7.5) => -0.0102478679,
            (f_rel_homeover100_count_d > 7.5) => 0.0979263597,
            (f_rel_homeover100_count_d = NULL) => 0.0473127303, 0.0473127303),
         (c_incollege > 10.8) => -0.0893091642,
         (c_incollege = NULL) => 0.0262339237, 0.0262339237),
      (c_preschl > 178.5) => 0.1422993871,
      (c_preschl = NULL) => 0.0438593737, 0.0438593737),
   (f_phones_per_addr_curr_i = NULL) => 0.0272606705, 0.0037034994),
(c_hh4_p = NULL) => -0.0178815193, -0.0042159440);

// Tree: 99 
wFDN_FLAP_D_lgt_99 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0116859955,
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 0.0113594121,
   (f_prevaddroccupantowned_i > 0.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 62.25) => 0.2160377848,
         (c_fammar_p > 62.25) => 
            map(
            (NULL < c_hval_175k_p and c_hval_175k_p <= 9.75) => 0.0258253670,
            (c_hval_175k_p > 9.75) => 0.2042960604,
            (c_hval_175k_p = NULL) => 0.0746699778, 0.0746699778),
         (c_fammar_p = NULL) => 0.1064056080, 0.1064056080),
      (f_phone_ver_insurance_d > 2.5) => 0.0127168912,
      (f_phone_ver_insurance_d = NULL) => 0.0498901562, 0.0498901562),
   (f_prevaddroccupantowned_i = NULL) => 0.0147942160, 0.0147942160),
(f_util_add_curr_conv_n = NULL) => 0.0028327172, 0.0028327172);

// Tree: 100 
wFDN_FLAP_D_lgt_100 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0859761045,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.85) => -0.0753795170,
   (C_OWNOCC_P > 1.85) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
         map(
         (NULL < c_transport and c_transport <= 26.6) => 0.0069482483,
         (c_transport > 26.6) => 0.1473623472,
         (c_transport = NULL) => 0.0096211972, 0.0096211972),
      (f_historical_count_d > 0.5) => -0.0176240075,
      (f_historical_count_d = NULL) => -0.0044038370, -0.0044038370),
   (C_OWNOCC_P = NULL) => 0.0191754019, -0.0049349170),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.55) => -0.0678922660,
   (c_pop_35_44_p > 14.55) => 0.0535472268,
   (c_pop_35_44_p = NULL) => 0.0030153573, 0.0030153573), -0.0041926767);

// Tree: 101 
wFDN_FLAP_D_lgt_101 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0046158564,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 2.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 7.85) => 0.1078921044,
         (C_INC_35K_P > 7.85) => -0.1132734014,
         (C_INC_35K_P = NULL) => -0.0134553413, -0.0134553413),
      (f_assocrisktype_i > 2.5) => 0.2207226717,
      (f_assocrisktype_i = NULL) => 0.0623081335, 0.0623081335),
   (f_nae_nothing_found_i = NULL) => -0.0037072166, -0.0037072166),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 303) => -0.0152361679,
   (r_C13_max_lres_d > 303) => 0.2230000932,
   (r_C13_max_lres_d = NULL) => 0.0972231852, 0.0972231852),
(k_comb_age_d = NULL) => -0.0024101766, -0.0024101766);

// Tree: 102 
wFDN_FLAP_D_lgt_102 := map(
(NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 4.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 6.35) => 
      map(
      (NULL < r_A41_Prop_Owner_Inp_Only_d and r_A41_Prop_Owner_Inp_Only_d <= 0.5) => 0.1777521144,
      (r_A41_Prop_Owner_Inp_Only_d > 0.5) => 0.0428351043,
      (r_A41_Prop_Owner_Inp_Only_d = NULL) => 0.0853726329, 0.0853726329),
   (c_vacant_p > 6.35) => -0.0068394291,
   (c_vacant_p = NULL) => 0.0388302673, 0.0388302673),
(r_I60_inq_banking_recency_d > 4.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 67.15) => -0.0001189722,
   (c_low_hval > 67.15) => -0.0957709652,
   (c_low_hval = NULL) => 0.0214648882, -0.0006174109),
(r_I60_inq_banking_recency_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0487242159,
   (c_assault > 90) => 0.0512115143,
   (c_assault = NULL) => -0.0038255545, -0.0038255545), 0.0013451559);

// Tree: 103 
wFDN_FLAP_D_lgt_103 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
      map(
      (NULL < c_families and c_families <= 375.5) => 0.1039799009,
      (c_families > 375.5) => -0.0165068224,
      (c_families = NULL) => 0.0427154653, 0.0427154653),
   (r_F00_dob_score_d > 92) => -0.0014196413,
   (r_F00_dob_score_d = NULL) => -0.0137870601, -0.0006754619),
(f_srchaddrsrchcount_i > 32.5) => -0.0864662080,
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.45) => -0.0697803555,
   (c_pop_35_44_p > 13.45) => 
      map(
      (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0924371087,
      (k_nap_lname_verd_d > 0.5) => -0.0063476063,
      (k_nap_lname_verd_d = NULL) => 0.0420948981, 0.0420948981),
   (c_pop_35_44_p = NULL) => 0.0003101649, 0.0003101649), -0.0012420979);

// Tree: 104 
wFDN_FLAP_D_lgt_104 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 
   map(
   (NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 13.5) => -0.0001042141,
      (f_rel_homeover500_count_d > 13.5) => 0.1021684683,
      (f_rel_homeover500_count_d = NULL) => 0.0119723310, 0.0013823502),
   (r_L77_Add_PO_Box_i > 0.5) => -0.0995148496,
   (r_L77_Add_PO_Box_i = NULL) => -0.0008165151, -0.0008165151),
(k_inq_per_phone_i > 5.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 3.55) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.15) => 0.0425855931,
      (c_incollege > 6.15) => 0.1786564254,
      (c_incollege = NULL) => 0.1075001186, 0.1075001186),
   (c_hval_150k_p > 3.55) => -0.0227769576,
   (c_hval_150k_p = NULL) => 0.0478708101, 0.0478708101),
(k_inq_per_phone_i = NULL) => -0.0000335262, -0.0000335262);

// Tree: 105 
wFDN_FLAP_D_lgt_105 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 6.05) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 42727) => 0.2132338346,
      (f_prevaddrmedianincome_d > 42727) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.265) => -0.0259688841,
         (c_hhsize > 2.265) => 0.1530772581,
         (c_hhsize = NULL) => 0.0587866862, 0.0587866862),
      (f_prevaddrmedianincome_d = NULL) => 0.1007270756, 0.1007270756),
   (c_pop_12_17_p > 6.05) => 0.0093501659,
   (c_pop_12_17_p = NULL) => 0.0170496010, 0.0322301078),
(f_corraddrnamecount_d > 1.5) => -0.0039173618,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 75.5) => -0.0776646694,
   (c_unempl > 75.5) => 0.0461999819,
   (c_unempl = NULL) => -0.0057138793, -0.0057138793), -0.0011640641);

// Tree: 106 
wFDN_FLAP_D_lgt_106 := map(
(NULL < c_hh3_p and c_hh3_p <= 21.55) => -0.0094240898,
(c_hh3_p > 21.55) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => -0.0821900492,
   (nf_vf_hi_risk_index > 3.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 73.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 27.5) => 0.1973098580,
         (c_many_cars > 27.5) => 
            map(
            (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 88490.5) => -0.0868885471,
            (r_A46_Curr_AVM_AutoVal_d > 88490.5) => 0.0438584165,
            (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0981912297, 0.0476869028),
         (c_many_cars = NULL) => 0.0634366876, 0.0634366876),
      (f_mos_inq_banko_cm_fseen_d > 73.5) => 0.0129802225,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0235632115, 0.0235632115),
   (nf_vf_hi_risk_index = NULL) => 0.0212017692, 0.0212017692),
(c_hh3_p = NULL) => -0.0327190895, -0.0034113855);

// Tree: 107 
wFDN_FLAP_D_lgt_107 := map(
(NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 160.5) => -0.0040005970,
   (r_pb_order_freq_d > 160.5) => -0.0334133285,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3282313423) => 0.0211431640,
      (f_add_input_mobility_index_i > 0.3282313423) => -0.0183814025,
      (f_add_input_mobility_index_i = NULL) => 0.0091742192, 0.0091742192), -0.0038640828),
(f_attr_arrests_i > 0.5) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 93.5) => 0.1464784194,
   (c_lux_prod > 93.5) => -0.0038445038,
   (c_lux_prod = NULL) => 0.0696215865, 0.0696215865),
(f_attr_arrests_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 16.75) => -0.0153021366,
   (c_hh4_p > 16.75) => 0.0875948907,
   (c_hh4_p = NULL) => 0.0255747647, 0.0255747647), -0.0027176353);

// Tree: 108 
wFDN_FLAP_D_lgt_108 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 0.0105577534,
   (f_srchcomponentrisktype_i > 1.5) => 
      map(
      (NULL < c_employees and c_employees <= 37.5) => 0.1695950094,
      (c_employees > 37.5) => 
         map(
         (NULL < c_rnt250_p and c_rnt250_p <= 9.2) => 
            map(
            (NULL < c_retail and c_retail <= 1.75) => -0.0414880817,
            (c_retail > 1.75) => 0.1042308112,
            (c_retail = NULL) => 0.0692170843, 0.0692170843),
         (c_rnt250_p > 9.2) => -0.0758062425,
         (c_rnt250_p = NULL) => 0.0459789251, 0.0459789251),
      (c_employees = NULL) => 0.0646614567, 0.0646614567),
   (f_srchcomponentrisktype_i = NULL) => 0.0145348087, 0.0145348087),
(f_corrphonelastnamecount_d > 0.5) => -0.0117413725,
(f_corrphonelastnamecount_d = NULL) => -0.0152947952, -0.0004088573);

// Tree: 109 
wFDN_FLAP_D_lgt_109 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 21.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => -0.0088583683,
      (f_srchvelocityrisktype_i > 2.5) => -0.1259016047,
      (f_srchvelocityrisktype_i = NULL) => -0.0815322732, -0.0815322732),
   (f_mos_inq_banko_cm_lseen_d > 21.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 20.5) => 0.0581019455,
      (r_C13_Curr_Addr_LRes_d > 20.5) => -0.0372733212,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0073299235, -0.0073299235),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0301729004, -0.0301729004),
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 12.5) => 0.0078056706,
   (f_inq_HighRiskCredit_count_i > 12.5) => 0.0857298103,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0082147723, 0.0082147723),
(r_D33_Eviction_Recency_d = NULL) => 0.0121626142, 0.0067692477);

// Tree: 110 
wFDN_FLAP_D_lgt_110 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 64.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 18.5) => -0.0014328212,
   (f_srchphonesrchcount_i > 18.5) => -0.0843549473,
   (f_srchphonesrchcount_i = NULL) => -0.0124650072, -0.0021616674),
(k_comb_age_d > 64.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 120.5) => 0.0068385574,
   (r_A50_pb_average_dollars_d > 120.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 174.5) => 
         map(
         (NULL < f_historical_count_d and f_historical_count_d <= 5.5) => 0.0308918813,
         (f_historical_count_d > 5.5) => 0.2758687369,
         (f_historical_count_d = NULL) => 0.0697296755, 0.0697296755),
      (c_serv_empl > 174.5) => 0.2064559847,
      (c_serv_empl = NULL) => 0.0859016045, 0.0859016045),
   (r_A50_pb_average_dollars_d = NULL) => 0.0351709370, 0.0351709370),
(k_comb_age_d = NULL) => 0.0018588575, 0.0018588575);

// Tree: 111 
wFDN_FLAP_D_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.75) => 0.2012634964,
   (r_C12_source_profile_d > 57.75) => -0.0062411195,
   (r_C12_source_profile_d = NULL) => 0.0958643264, 0.0958643264),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 51.15) => 0.1501829283,
         (r_C12_source_profile_d > 51.15) => -0.0097927415,
         (r_C12_source_profile_d = NULL) => 0.0694333045, 0.0694333045),
      (r_D33_Eviction_Recency_d > 30) => 0.0047439449,
      (r_D33_Eviction_Recency_d = NULL) => 0.0053042800, 0.0053042800),
   (k_inq_adls_per_addr_i > 3.5) => -0.0517196206,
   (k_inq_adls_per_addr_i = NULL) => 0.0040708333, 0.0040708333),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0251970080, 0.0045926870);

// Tree: 112 
wFDN_FLAP_D_lgt_112 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 8.5) => -0.0027200370,
   (f_util_adl_count_n > 8.5) => 0.0555203289,
   (f_util_adl_count_n = NULL) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 59.5) => -0.0429359013,
      (c_serv_empl > 59.5) => 0.0743472662,
      (c_serv_empl = NULL) => 0.0287840213, 0.0287840213), -0.0004047460),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 132.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.45088523275) => 0.0716233210,
      (f_add_input_nhood_MFD_pct_i > 0.45088523275) => -0.0561746532,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0216154181, 0.0216154181),
   (c_bel_edu > 132.5) => 0.1474568154,
   (c_bel_edu = NULL) => 0.0538212733, 0.0538212733),
(k_nap_contradictory_i = NULL) => 0.0005570872, 0.0005570872);

// Tree: 113 
wFDN_FLAP_D_lgt_113 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 21.5) => -0.0953156001,
(f_mos_inq_banko_am_fseen_d > 21.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 946) => -0.0030537739,
   (f_addrchangevaluediff_d > 946) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 10.65) => 0.0119978144,
      (c_hval_150k_p > 10.65) => 
         map(
         (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 0.0238422697,
         (r_F01_inp_addr_not_verified_i > 0.5) => 0.1753415276,
         (r_F01_inp_addr_not_verified_i = NULL) => 0.1094722850, 0.1094722850),
      (c_hval_150k_p = NULL) => 0.0334310154, 0.0334310154),
   (f_addrchangevaluediff_d = NULL) => -0.0040270337, -0.0017076535),
(f_mos_inq_banko_am_fseen_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.4) => -0.0560666492,
   (c_pop_35_44_p > 13.4) => 0.0529457878,
   (c_pop_35_44_p = NULL) => 0.0161270177, 0.0161270177), -0.0030362380);

// Tree: 114 
wFDN_FLAP_D_lgt_114 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0054975278) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.1770566651,
   (f_hh_members_ct_d > 1.5) => 0.0316545276,
   (f_hh_members_ct_d = NULL) => 0.0509789407, 0.0509789407),
(f_add_input_nhood_MFD_pct_i > 0.0054975278) => 
   map(
   (NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 0.5) => -0.0075735145,
   (nf_vf_hi_summary > 0.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 19.45) => -0.0263515752,
      (C_INC_50K_P > 19.45) => -0.0868028329,
      (C_INC_50K_P = NULL) => -0.0360745047, -0.0360745047),
   (nf_vf_hi_summary = NULL) => 0.0194440533, -0.0094169647),
(f_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 18.5) => -0.0083430545,
   (f_srchaddrsrchcount_i > 18.5) => 0.1350679319,
   (f_srchaddrsrchcount_i = NULL) => -0.0162170128, -0.0054450819), -0.0049238674);

// Tree: 115 
wFDN_FLAP_D_lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13229074905) => -0.0082580898,
   (f_add_curr_nhood_BUS_pct_i > 0.13229074905) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0023184991,
      (c_easiqlife > 132.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => 0.0492300658,
         (f_corrrisktype_i > 7.5) => 
            map(
            (NULL < c_hval_175k_p and c_hval_175k_p <= 4.55) => 0.0602998468,
            (c_hval_175k_p > 4.55) => 0.2470917173,
            (c_hval_175k_p = NULL) => 0.1271915302, 0.1271915302),
         (f_corrrisktype_i = NULL) => 0.0688530194, 0.0688530194),
      (c_easiqlife = NULL) => 0.0268648014, 0.0268648014),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0042056364, -0.0039397823),
(c_pop_0_5_p > 21.15) => 0.1796873428,
(c_pop_0_5_p = NULL) => 0.0122279659, -0.0027621510);

// Tree: 116 
wFDN_FLAP_D_lgt_116 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.45) => -0.0849236998,
(C_OWNOCC_P > 1.45) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -110409) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => -0.0217441380,
      (r_L79_adls_per_addr_c6_i > 0.5) => 0.1194580575,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0528036050, 0.0528036050),
   (f_addrchangevaluediff_d > -110409) => -0.0025891801,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 494.5) => -0.0016807616,
      (f_M_Bureau_ADL_FS_all_d > 494.5) => 0.1600702287,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 
         map(
         (NULL < c_rnt500_p and c_rnt500_p <= 11) => 0.0439492008,
         (c_rnt500_p > 11) => -0.0872772935,
         (c_rnt500_p = NULL) => -0.0009913794, -0.0009913794), 0.0021938476), -0.0008271428),
(C_OWNOCC_P = NULL) => 0.0060414743, -0.0016929763);

// Tree: 117 
wFDN_FLAP_D_lgt_117 := map(
(NULL < c_hh3_p and c_hh3_p <= 24.05) => -0.0037397148,
(c_hh3_p > 24.05) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 11.25) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.75) => -0.0236511581,
      (C_INC_200K_P > 0.75) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 151.5) => 
            map(
            (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 68.65) => 0.1117659430,
            (r_C12_source_profile_d > 68.65) => 0.3626884833,
            (r_C12_source_profile_d = NULL) => 0.1834580973, 0.1834580973),
         (c_relig_indx > 151.5) => -0.0187545277,
         (c_relig_indx = NULL) => 0.1265479573, 0.1265479573),
      (C_INC_200K_P = NULL) => 0.0846998237, 0.0846998237),
   (C_INC_100K_P > 11.25) => 0.0119591473,
   (C_INC_100K_P = NULL) => 0.0327357871, 0.0327357871),
(c_hh3_p = NULL) => -0.0030312142, 0.0009368587);

// Tree: 118 
wFDN_FLAP_D_lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0065275357,
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 724) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0333244262) => 0.0445686402,
      (f_add_curr_nhood_BUS_pct_i > 0.0333244262) => -0.0506033723,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0075367075, -0.0075367075),
   (c_hh00 > 724) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 2.35) => 0.1943583226,
      (c_hval_125k_p > 2.35) => 0.0524798489,
      (c_hval_125k_p = NULL) => 0.1177690580, 0.1177690580),
   (c_hh00 = NULL) => 0.0391944856, 0.0391944856),
(f_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 83.75) => 0.0421109599,
   (c_fammar_p > 83.75) => -0.0688260695,
   (c_fammar_p = NULL) => 0.0046943287, 0.0046943287), -0.0052179331);

// Tree: 119 
wFDN_FLAP_D_lgt_119 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 11.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 0.5) => 0.0115895657,
   (f_srchphonesrchcount_i > 0.5) => 0.1270216372,
   (f_srchphonesrchcount_i = NULL) => 0.0548765925, 0.0548765925),
(r_D32_Mos_Since_Crim_LS_d > 11.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
      map(
      (NULL < c_employees and c_employees <= 270) => -0.0679937926,
      (c_employees > 270) => -0.0059816393,
      (c_employees = NULL) => -0.0425189508, -0.0425189508),
   (f_mos_inq_banko_om_fseen_d > 21.5) => 0.0077345266,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0044129993, 0.0044129993),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 68.4) => 0.0508762377,
   (c_fammar_p > 68.4) => -0.0521138094,
   (c_fammar_p = NULL) => -0.0193144314, -0.0193144314), 0.0050591624);

// Tree: 120 
wFDN_FLAP_D_lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1906.5) => -0.0069250664,
(c_popover18 > 1906.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 22.75) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 141.5) => 0.1543572676,
      (f_mos_liens_unrel_SC_fseen_d > 141.5) => 
         map(
         (NULL < c_low_hval and c_low_hval <= 30.7) => 0.0061084008,
         (c_low_hval > 30.7) => 0.1671850467,
         (c_low_hval = NULL) => 0.0101186078, 0.0101186078),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0134321986, 0.0134321986),
   (c_hval_150k_p > 22.75) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 18.5) => 0.3041133087,
      (c_hh1_p > 18.5) => 0.0454623928,
      (c_hh1_p = NULL) => 0.1536255031, 0.1536255031),
   (c_hval_150k_p = NULL) => 0.0230066586, 0.0230066586),
(c_popover18 = NULL) => -0.0351242851, -0.0018489082);

// Tree: 121 
wFDN_FLAP_D_lgt_121 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0022034348,
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 2.4) => -0.0221019337,
   (c_hval_100k_p > 2.4) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.35502917855) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 24.25) => 0.1043516096,
         (c_famotf18_p > 24.25) => 0.2092006886,
         (c_famotf18_p = NULL) => 0.1543713537, 0.1543713537),
      (f_add_curr_mobility_index_i > 0.35502917855) => -0.0120013983,
      (f_add_curr_mobility_index_i = NULL) => 0.0999407620, 0.0999407620),
   (c_hval_100k_p = NULL) => 0.0424855968, 0.0424855968),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.31495204255) => 0.0484714097,
   (f_add_input_mobility_index_i > 0.31495204255) => -0.0387682325,
   (f_add_input_mobility_index_i = NULL) => 0.0123722474, 0.0123722474), -0.0009090777);

// Tree: 122 
wFDN_FLAP_D_lgt_122 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 11.95) => 0.0459417208,
      (c_hh3_p > 11.95) => -0.0725109073,
      (c_hh3_p = NULL) => -0.0397805758, -0.0397805758),
   (nf_vf_hi_risk_index > 3.5) => 0.0007273399,
   (nf_vf_hi_risk_index = NULL) => -0.0041971564, -0.0000927899),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 93) => -0.0253512886,
   (c_ab_av_edu > 93) => 
      map(
      (NULL < c_robbery and c_robbery <= 104) => 0.0711435015,
      (c_robbery > 104) => 0.2758175483,
      (c_robbery = NULL) => 0.1466943241, 0.1466943241),
   (c_ab_av_edu = NULL) => 0.0880770136, 0.0880770136),
(r_P85_Phn_Disconnected_i = NULL) => 0.0015614800, 0.0015614800);

// Tree: 123 
wFDN_FLAP_D_lgt_123 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 1.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -3.5) => 0.1284453555,
      (f_addrchangecrimediff_i > -3.5) => 0.0220926904,
      (f_addrchangecrimediff_i = NULL) => 0.0333370071, 0.0303882617),
   (r_I60_inq_comm_recency_d > 549) => 0.0011156082,
   (r_I60_inq_comm_recency_d = NULL) => 0.0037780517, 0.0037780517),
(f_vf_AltLexID_addr_hi_risk_ct_i > 1.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2647339958) => 0.0309490364,
   (f_add_curr_mobility_index_i > 0.2647339958) => -0.0885069961,
   (f_add_curr_mobility_index_i = NULL) => -0.0477985158, -0.0477985158),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.555) => 0.0691669450,
   (c_hhsize > 2.555) => -0.0378510018,
   (c_hhsize = NULL) => 0.0105804777, 0.0105804777), 0.0031309095);

// Tree: 124 
wFDN_FLAP_D_lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 21.55) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0116843313,
         (f_srchvelocityrisktype_i > 5.5) => 0.1016506502,
         (f_srchvelocityrisktype_i = NULL) => 0.0194245757, 0.0194245757),
      (c_vacant_p > 21.55) => 0.1782836932,
      (c_vacant_p = NULL) => 0.0299658675, 0.0299658675),
   (r_C12_source_profile_index_d > 1.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 159.5) => -0.0063460510,
      (r_C13_Curr_Addr_LRes_d > 159.5) => 0.0380372428,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0046291194, 0.0046291194),
   (r_C12_source_profile_index_d = NULL) => 0.0198197359, 0.0073064273),
(c_high_ed > 42.55) => -0.0284933110,
(c_high_ed = NULL) => -0.0341374522, -0.0037977508);

// Tree: 125 
wFDN_FLAP_D_lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 345.5) => -0.0093210143,
      (r_C21_M_Bureau_ADL_FS_d > 345.5) => 0.0309728238,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0045691339, -0.0045691339),
   (f_hh_collections_ct_i > 5.5) => 0.0945495982,
   (f_hh_collections_ct_i = NULL) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 7) => 0.0576939729,
      (c_hh5_p > 7) => -0.0353301473,
      (c_hh5_p = NULL) => 0.0197499239, 0.0197499239), -0.0035053925),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.0217066790,
   (f_inq_count_i > 2.5) => 0.2154264214,
   (f_inq_count_i = NULL) => 0.0869934430, 0.0869934430),
(f_nae_nothing_found_i = NULL) => -0.0022069465, -0.0022069465);

// Tree: 126 
wFDN_FLAP_D_lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.55) => -0.0834055242,
      (C_OWNOCC_P > 1.55) => 0.0037920625,
      (C_OWNOCC_P = NULL) => -0.0106472044, 0.0024091529),
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 3.35) => -0.0511492858,
      (c_rnt1000_p > 3.35) => 0.0884562857,
      (c_rnt1000_p = NULL) => 0.0413282902, 0.0413282902),
   (f_inq_PrepaidCards_count24_i = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 0.0553975902,
      (c_bigapt_p > 1.15) => -0.0488803774,
      (c_bigapt_p = NULL) => 0.0067868083, 0.0067868083), 0.0029578250),
(r_L72_Add_Vacant_i > 0.5) => 0.1022876724,
(r_L72_Add_Vacant_i = NULL) => 0.0036392930, 0.0036392930);

// Tree: 127 
wFDN_FLAP_D_lgt_127 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < nf_altlexid_phone_hi_no_hi_lexid and nf_altlexid_phone_hi_no_hi_lexid <= 0.5) => -0.0021848031,
      (nf_altlexid_phone_hi_no_hi_lexid > 0.5) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 70) => -0.0602207436,
         (f_fp_prevaddrcrimeindex_i > 70) => 0.1465347114,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0524146908, 0.0524146908),
      (nf_altlexid_phone_hi_no_hi_lexid = NULL) => -0.0015920996, -0.0015920996),
   (k_inq_adls_per_phone_i > 2.5) => -0.0767759877,
   (k_inq_adls_per_phone_i = NULL) => -0.0021902837, -0.0021902837),
(f_assocsuspicousidcount_i > 16.5) => 0.0928037394,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 77.2) => 0.0314653042,
   (c_fammar_p > 77.2) => -0.0629527180,
   (c_fammar_p = NULL) => -0.0179322041, -0.0179322041), -0.0019319032);

// Tree: 128 
wFDN_FLAP_D_lgt_128 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 54.5) => -0.0113680762,
(r_C13_Curr_Addr_LRes_d > 54.5) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 870) => 0.0016231150,
   (r_P88_Phn_Dst_to_Inp_Add_i > 870) => 0.1451146120,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 186.4) => 0.2126004409,
      (c_housingcpi > 186.4) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 10.5) => 0.1248038358,
         (c_born_usa > 10.5) => 
            map(
            (NULL < c_high_ed and c_high_ed <= 4.05) => 0.1386152753,
            (c_high_ed > 4.05) => 0.0186163132,
            (c_high_ed = NULL) => 0.0236124149, 0.0236124149),
         (c_born_usa = NULL) => 0.0311241264, 0.0311241264),
      (c_housingcpi = NULL) => -0.0547718141, 0.0350036104), 0.0105541630),
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0059563372, 0.0003805209);

// Tree: 129 
wFDN_FLAP_D_lgt_129 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => -0.0087119783,
(f_util_adl_count_n > 3.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -49272.5) => 0.1489306882,
   (f_addrchangevaluediff_d > -49272.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 180.5) => 
         map(
         (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 1.5) => -0.0035408412,
         (f_inq_HighRiskCredit_count24_i > 1.5) => 0.1038979222,
         (f_inq_HighRiskCredit_count24_i = NULL) => 0.0006879027, 0.0006879027),
      (c_born_usa > 180.5) => 0.2029043313,
      (c_born_usa = NULL) => 0.0103233742, 0.0103233742),
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 3.75) => -0.0053503259,
      (c_hh7p_p > 3.75) => 0.1366787224,
      (c_hh7p_p = NULL) => 0.0030102700, 0.0098892119), 0.0134649533),
(f_util_adl_count_n = NULL) => -0.0165762160, -0.0048926449);

// Tree: 130 
wFDN_FLAP_D_lgt_130 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 48.45) => 
   map(
   (NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 1900) => -0.0066217547,
   (f_acc_damage_amt_last_i > 1900) => 0.1217161846,
   (f_acc_damage_amt_last_i = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 99.5) => 0.0367486136,
      (c_many_cars > 99.5) => -0.0611094238,
      (c_many_cars = NULL) => -0.0065347491, -0.0065347491), -0.0055273555),
(c_rnt2001_p > 48.45) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 143.5) => 0.0409305669,
   (c_lar_fam > 143.5) => 0.2332233213,
   (c_lar_fam = NULL) => 0.0745979852, 0.0745979852),
(c_rnt2001_p = NULL) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 3.5) => 0.1817595238,
   (r_C18_invalid_addrs_per_adl_i > 3.5) => -0.0662303801,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0550091285, 0.0550091285), -0.0022339726);

// Tree: 131 
wFDN_FLAP_D_lgt_131 := map(
(NULL < c_white_col and c_white_col <= 11.65) => -0.1085518141,
(c_white_col > 11.65) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 16750) => 0.1183430993,
   (r_L80_Inp_AVM_AutoVal_d > 16750) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1070054083,
      (r_C10_M_Hdr_FS_d > 7.5) => 0.0017484878,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0255669164, 0.0031245576),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 7019) => -0.0221604460,
      (r_A49_Curr_AVM_Chg_1yr_i > 7019) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 178) => 0.0350499298,
         (r_C13_Curr_Addr_LRes_d > 178) => 0.2537338934,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0819778190, 0.0819778190),
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0051047618, -0.0022975074), 0.0013167245),
(c_white_col = NULL) => -0.0038103222, 0.0005758985);

// Tree: 132 
wFDN_FLAP_D_lgt_132 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0030119583,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2285468762,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61) => -0.0021417690,
   (f_addrchangecrimediff_i > 61) => 
      map(
      (NULL < c_child and c_child <= 19.95) => -0.0521560195,
      (c_child > 19.95) => 0.1609287049,
      (c_child = NULL) => 0.0672449036, 0.0672449036),
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => -0.0174835677,
      (f_phones_per_addr_curr_i > 4.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.11290128835) => 0.0243831979,
         (f_add_curr_nhood_VAC_pct_i > 0.11290128835) => 0.2159559425,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0447214003, 0.0447214003),
      (f_phones_per_addr_curr_i = NULL) => 0.0096736336, 0.0021698130), 0.0003568400), -0.0002480594);

// Tree: 133 
wFDN_FLAP_D_lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 127.5) => 
   map(
   (NULL < c_rape and c_rape <= 66) => 
      map(
      (NULL < c_child and c_child <= 24.5) => 0.0400551824,
      (c_child > 24.5) => 0.2140667085,
      (c_child = NULL) => 0.1298230332, 0.1298230332),
   (c_rape > 66) => 0.0008851934,
   (c_rape = NULL) => 0.0518136191, 0.0518136191),
(f_mos_liens_unrel_SC_fseen_d > 127.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 20.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 66) => 0.1310278044,
      (c_work_home > 66) => 0.0194255589,
      (c_work_home = NULL) => 0.0512110086, 0.0512110086),
   (k_comb_age_d > 20.5) => -0.0003613111,
   (k_comb_age_d = NULL) => 0.0009809241, 0.0009809241),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0123363160, 0.0020740990);

// Tree: 134 
wFDN_FLAP_D_lgt_134 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 31.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 0.0000277689,
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 60.5) => 0.1532716555,
      (c_retired2 > 60.5) => 0.0225962351,
      (c_retired2 = NULL) => 0.0602307562, 0.0602307562),
   (f_assoccredbureaucountnew_i = NULL) => 0.0012904905, 0.0012904905),
(f_rel_under100miles_cnt_d > 31.5) => -0.0726802749,
(f_rel_under100miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 226530.5) => 0.0818072808,
   (r_L80_Inp_AVM_AutoVal_d > 226530.5) => -0.0254272783,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 164.5) => -0.0460096638,
      (c_cartheft > 164.5) => 0.0692569253,
      (c_cartheft = NULL) => -0.0176985717, -0.0176985717), 0.0037473671), 0.0004197769);

// Tree: 135 
wFDN_FLAP_D_lgt_135 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => -0.0063888964,
   (f_adls_per_phone_c6_i > 1.5) => 
      map(
      (NULL < c_young and c_young <= 23.2) => 0.0367418207,
      (c_young > 23.2) => 0.2761518501,
      (c_young = NULL) => 0.1222454026, 0.1222454026),
   (f_adls_per_phone_c6_i = NULL) => -0.0048520860, -0.0048520860),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 156.5) => 0.0275221197,
   (f_curraddrmurderindex_i > 156.5) => 
      map(
      (NULL < c_larceny and c_larceny <= 155.5) => 0.2731832468,
      (c_larceny > 155.5) => 0.0255698374,
      (c_larceny = NULL) => 0.1434809847, 0.1434809847),
   (f_curraddrmurderindex_i = NULL) => 0.0415217093, 0.0415217093),
(k_comb_age_d = NULL) => -0.0016274181, -0.0016274181);

// Tree: 136 
wFDN_FLAP_D_lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.25) => 0.0201163625,
   (c_hh7p_p > 7.25) => 
      map(
      (NULL < c_pop00 and c_pop00 <= 1370.5) => 0.0173782787,
      (c_pop00 > 1370.5) => 0.2211074645,
      (c_pop00 = NULL) => 0.1192428716, 0.1192428716),
   (c_hh7p_p = NULL) => 0.0754581993, 0.0258512126),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -29731.5) => -0.0900707200,
   (f_addrchangeincomediff_d > -29731.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 201458.5) => -0.0084074710,
      (f_addrchangevaluediff_d > 201458.5) => 0.1232748721,
      (f_addrchangevaluediff_d = NULL) => -0.0071911214, -0.0071911214),
   (f_addrchangeincomediff_d = NULL) => -0.0053177793, -0.0078361994),
(f_hh_members_ct_d = NULL) => -0.0044661652, -0.0014088849);

// Tree: 137 
wFDN_FLAP_D_lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => -0.0399125073,
   (nf_vf_hi_risk_index > 3.5) => 0.0016745028,
   (nf_vf_hi_risk_index = NULL) => 0.0009867502, 0.0009867502),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.25) => -0.1172145423,
   (C_INC_75K_P > 15.25) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 100.5) => -0.0671843201,
      (c_blue_empl > 100.5) => 0.0527979263,
      (c_blue_empl = NULL) => -0.0036175671, -0.0036175671),
   (C_INC_75K_P = NULL) => -0.0366833533, -0.0366833533),
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 100.5) => -0.0559856654,
   (c_bel_edu > 100.5) => 0.0369224789,
   (c_bel_edu = NULL) => -0.0173220277, -0.0173220277), 0.0000683488);

// Tree: 138 
wFDN_FLAP_D_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 75.45) => 0.0015246807,
   (c_low_ed > 75.45) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.3276004819) => -0.0909236511,
      (f_add_curr_nhood_MFD_pct_i > 0.3276004819) => -0.0219081329,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0664527748, -0.0664527748),
   (c_low_ed = NULL) => -0.0067839246, -0.0009065398),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 0.0059272948,
   (f_vardobcountnew_i > 0.5) => 0.1586627812,
   (f_vardobcountnew_i = NULL) => 0.0499952384, 0.0499952384),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0293950756,
   (c_construction > 7.45) => -0.0701654968,
   (c_construction = NULL) => -0.0096219055, -0.0096219055), 0.0001936791);

// Tree: 139 
wFDN_FLAP_D_lgt_139 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 5.95) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 1.5) => -0.0350330347,
      (f_assocrisktype_i > 1.5) => 0.1007335473,
      (f_assocrisktype_i = NULL) => 0.0079213641, 0.0079213641),
   (c_hval_200k_p > 5.95) => 0.1190835326,
   (c_hval_200k_p = NULL) => 0.0384454022, 0.0384454022),
(r_C21_M_Bureau_ADL_FS_d > 7.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 113500) => -0.0068686865,
   (k_estimated_income_d > 113500) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 0.9) => 0.0304107929,
      (c_hval_20k_p > 0.9) => 0.2598930525,
      (c_hval_20k_p = NULL) => 0.0494436817, 0.0494436817),
   (k_estimated_income_d = NULL) => -0.0029882457, -0.0029882457),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0072717965, -0.0022348056);

// Tree: 140 
wFDN_FLAP_D_lgt_140 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 40.95) => 0.0009646887,
   (c_hval_80k_p > 40.95) => -0.0915790368,
   (c_hval_80k_p = NULL) => -0.0311894993, -0.0004911117),
(f_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.0971717481,
      (f_adl_util_conv_n > 0.5) => -0.1084407503,
      (f_adl_util_conv_n = NULL) => 0.0107799421, 0.0107799421),
   (r_C23_inp_addr_occ_index_d > 2) => 0.1293734384,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0509699603, 0.0509699603),
(f_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 31.85) => -0.0664559045,
   (c_low_ed > 31.85) => 0.0281553876,
   (c_low_ed = NULL) => -0.0064735821, -0.0064735821), 0.0001561155);

// Tree: 141 
wFDN_FLAP_D_lgt_141 := map(
(NULL < c_cpiall and c_cpiall <= 208.9) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.25) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 194.5) => -0.0024215811,
         (c_new_homes > 194.5) => 
            map(
            (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => -0.0069796015,
            (f_sourcerisktype_i > 3.5) => 0.2952919765,
            (f_sourcerisktype_i = NULL) => 0.1263055037, 0.1263055037),
         (c_new_homes = NULL) => 0.0073972416, 0.0073972416),
      (k_inq_ssns_per_addr_i > 2.5) => 0.1037527501,
      (k_inq_ssns_per_addr_i = NULL) => 0.0121297223, 0.0121297223),
   (c_unemp > 11.25) => 0.1280452659,
   (c_unemp = NULL) => 0.0154728217, 0.0154728217),
(c_cpiall > 208.9) => -0.0068999175,
(c_cpiall = NULL) => -0.0283864216, -0.0042297866);

// Tree: 142 
wFDN_FLAP_D_lgt_142 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 25.5) => 0.0053664451,
   (f_rel_under500miles_cnt_d > 25.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 117.5) => -0.0910646842,
      (c_rest_indx > 117.5) => 
         map(
         (NULL < c_highinc and c_highinc <= 12.45) => 0.1344437590,
         (c_highinc > 12.45) => -0.0601212750,
         (c_highinc = NULL) => 0.0204408094, 0.0204408094),
      (c_rest_indx = NULL) => -0.0516373273, -0.0516373273),
   (f_rel_under500miles_cnt_d = NULL) => 0.0150184598, 0.0037062496),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0530430093,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 0.9) => -0.0567633870,
   (c_hval_150k_p > 0.9) => 0.0409983465,
   (c_hval_150k_p = NULL) => -0.0034388051, -0.0034388051), 0.0012292462);

// Tree: 143 
wFDN_FLAP_D_lgt_143 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.0821211978,
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 7.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0044551744,
      (c_hval_200k_p > 16.45) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 117378) => 0.0956074626,
         (r_A46_Curr_AVM_AutoVal_d > 117378) => -0.0214110164,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0562715695, 0.0276352468),
      (c_hval_200k_p = NULL) => 0.0225465197, -0.0010782343),
   (f_inq_QuizProvider_count_i > 7.5) => 0.1068523764,
   (f_inq_QuizProvider_count_i = NULL) => -0.0004625286, -0.0004625286),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 1.7) => -0.0444264367,
   (c_hh6_p > 1.7) => 0.0394471103,
   (c_hh6_p = NULL) => -0.0040239354, -0.0040239354), -0.0001561190);

// Tree: 144 
wFDN_FLAP_D_lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 53) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 23.5) => -0.0003231324,
   (f_rel_homeover50_count_d > 23.5) => -0.0392948787,
   (f_rel_homeover50_count_d = NULL) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 10.7) => 0.0927836738,
      (C_RENTOCC_P > 10.7) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 121) => -0.0599973693,
         (c_relig_indx > 121) => 0.0385619027,
         (c_relig_indx = NULL) => -0.0208304925, -0.0208304925),
      (C_RENTOCC_P = NULL) => -0.0002284570, -0.0002284570), -0.0021391908),
(c_rnt2001_p > 53) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => 0.0092716649,
   (k_inf_nothing_found_i > 0.5) => 0.2040654033,
   (k_inf_nothing_found_i = NULL) => 0.0823193168, 0.0823193168),
(c_rnt2001_p = NULL) => 0.0057054627, -0.0002609310);

// Tree: 145 
wFDN_FLAP_D_lgt_145 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 18.55) => -0.0776595687,
   (c_fammar_p > 18.55) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 328.5) => -0.0033153593,
      (r_C13_Curr_Addr_LRes_d > 328.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 128) => 0.1045925709,
         (c_relig_indx > 128) => -0.0183459864,
         (c_relig_indx = NULL) => 0.0525801043, 0.0525801043),
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0008988610, -0.0008988610),
   (c_fammar_p = NULL) => 0.0250835174, -0.0009549452),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < c_health and c_health <= 5.65) => 0.1830388345,
   (c_health > 5.65) => 0.0097762233,
   (c_health = NULL) => 0.0734757127, 0.0734757127),
(f_hh_lienholders_i = NULL) => -0.0170858222, -0.0003807603);

// Tree: 146 
wFDN_FLAP_D_lgt_146 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0051755477,
   (f_curraddrcrimeindex_i > 189) => 
      map(
      (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 1.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 135) => 0.0253971730,
         (c_no_labfor > 135) => 0.2200190880,
         (c_no_labfor = NULL) => 0.1163419931, 0.1163419931),
      (f_addrchangeecontrajindex_d > 1.5) => -0.0059443546,
      (f_addrchangeecontrajindex_d = NULL) => 0.0317389969, 0.0442874342),
   (f_curraddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 11.15) => -0.0180520245,
      (c_high_hval > 11.15) => 0.0893757490,
      (c_high_hval = NULL) => 0.0191615180, 0.0191615180), -0.0035690387),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1045858262,
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0027931544, -0.0027931544);

// Tree: 147 
wFDN_FLAP_D_lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 17.05) => 
      map(
      (NULL < c_construction and c_construction <= 22.75) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 126) => 0.0030217711,
         (r_pb_order_freq_d > 126) => -0.0886109718,
         (r_pb_order_freq_d = NULL) => 0.0556797469, 0.0164039776),
      (c_construction > 22.75) => 0.1822540758,
      (c_construction = NULL) => 0.0375392975, 0.0375392975),
   (c_hh2_p > 17.05) => -0.0010652472,
   (c_hh2_p = NULL) => -0.0308923179, 0.0004329735),
(f_prevaddrcartheftindex_i > 194.5) => -0.0760582954,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 7.35) => -0.0156300684,
   (c_professional > 7.35) => 0.0982426013,
   (c_professional = NULL) => 0.0188768012, 0.0188768012), -0.0004123594);

// Tree: 148 
wFDN_FLAP_D_lgt_148 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0045507189,
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_highinc and c_highinc <= 3.85) => -0.0629609147,
   (c_highinc > 3.85) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 131.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 18.85) => 
            map(
            (NULL < c_pop_75_84_p and c_pop_75_84_p <= 4.35) => 0.0198886325,
            (c_pop_75_84_p > 4.35) => 0.1464997988,
            (c_pop_75_84_p = NULL) => 0.0517037461, 0.0517037461),
         (c_hval_150k_p > 18.85) => 0.1564822482,
         (c_hval_150k_p = NULL) => 0.0646538980, 0.0646538980),
      (c_mort_indx > 131.5) => -0.0584679800,
      (c_mort_indx = NULL) => 0.0402513637, 0.0402513637),
   (c_highinc = NULL) => 0.0247616190, 0.0247616190),
(k_inq_per_phone_i = NULL) => -0.0030255992, -0.0030255992);

// Tree: 149 
wFDN_FLAP_D_lgt_149 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 0.5) => 0.0058526111,
(f_vf_AltLexID_addr_hi_risk_ct_i > 0.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 5.95) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 18.75) => -0.0264060668,
      (c_pop_35_44_p > 18.75) => 0.0993985032,
      (c_pop_35_44_p = NULL) => -0.0074023553, -0.0074023553),
   (c_hval_500k_p > 5.95) => -0.0884811327,
   (c_hval_500k_p = NULL) => -0.0365718962, -0.0365718962),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 151) => 
      map(
      (NULL < c_finance and c_finance <= 2.55) => 0.1067632303,
      (c_finance > 2.55) => -0.0224232771,
      (c_finance = NULL) => 0.0404242130, 0.0404242130),
   (c_asian_lang > 151) => -0.0704982062,
   (c_asian_lang = NULL) => 0.0045773336, 0.0045773336), 0.0040745233);

// Tree: 150 
wFDN_FLAP_D_lgt_150 := map(
(NULL < c_trailer_p and c_trailer_p <= 2.75) => 
   map(
   (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => 0.0006683730,
   (f_inq_Collection_count24_i > 1.5) => 
      map(
      (NULL < c_assault and c_assault <= 19.5) => 0.1875353645,
      (c_assault > 19.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 0.0040147868,
         (f_util_adl_count_n > 4.5) => 
            map(
            (NULL < c_hval_300k_p and c_hval_300k_p <= 2.5) => -0.0111842374,
            (c_hval_300k_p > 2.5) => 0.1792517577,
            (c_hval_300k_p = NULL) => 0.0830910077, 0.0830910077),
         (f_util_adl_count_n = NULL) => 0.0210439943, 0.0210439943),
      (c_assault = NULL) => 0.0470957015, 0.0470957015),
   (f_inq_Collection_count24_i = NULL) => 0.0219920085, 0.0037761089),
(c_trailer_p > 2.75) => -0.0206067094,
(c_trailer_p = NULL) => 0.0025483805, -0.0026714503);

// Tree: 151 
wFDN_FLAP_D_lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
      map(
      (NULL < nf_altlexid_phone_hi_no_hi_lexid and nf_altlexid_phone_hi_no_hi_lexid <= 0.5) => -0.0015314516,
      (nf_altlexid_phone_hi_no_hi_lexid > 0.5) => 0.0638349707,
      (nf_altlexid_phone_hi_no_hi_lexid = NULL) => -0.0007496324, -0.0007496324),
   (k_inq_adls_per_phone_i > 3.5) => -0.1006873273,
   (k_inq_adls_per_phone_i = NULL) => -0.0012158797, -0.0012158797),
(r_C14_addrs_10yr_i > 10.5) => 0.1021349337,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 9.95) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => -0.0222996923,
      (c_hval_250k_p > 8.05) => 0.1038887040,
      (c_hval_250k_p = NULL) => 0.0322393603, 0.0322393603),
   (c_construction > 9.95) => -0.0743806415,
   (c_construction = NULL) => 0.0000640935, 0.0000640935), -0.0007638822);

// Tree: 152 
wFDN_FLAP_D_lgt_152 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37763534975) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 153.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 11.7) => 0.0080753789,
         (c_pop_35_44_p > 11.7) => 0.1833815704,
         (c_pop_35_44_p = NULL) => 0.1220244034, 0.1220244034),
      (c_asian_lang > 153.5) => -0.0268901324,
      (c_asian_lang = NULL) => 0.0536042113, 0.0536042113),
   (r_C10_M_Hdr_FS_d > 15.5) => 0.0039305215,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0112945848, 0.0054496689),
(f_add_input_mobility_index_i > 0.37763534975) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.585) => -0.0069401886,
   (c_hhsize > 2.585) => -0.0622831513,
   (c_hhsize = NULL) => 0.0493501218, -0.0232771714),
(f_add_input_mobility_index_i = NULL) => 0.0695477529, 0.0009429774);

// Tree: 153 
wFDN_FLAP_D_lgt_153 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00963856045) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_assault and c_assault <= 80.5) => 0.2165543608,
      (c_assault > 80.5) => 0.0132464527,
      (c_assault = NULL) => 0.1337789982, 0.1337789982),
   (f_hh_members_ct_d > 1.5) => 0.0247716353,
   (f_hh_members_ct_d = NULL) => 0.0375103923, 0.0375103923),
(f_add_input_nhood_MFD_pct_i > 0.00963856045) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.4) => -0.0061921676,
   (r_C12_source_profile_d > 81.4) => 
      map(
      (NULL < c_no_car and c_no_car <= 170.5) => 0.0517532604,
      (c_no_car > 170.5) => 0.1872944476,
      (c_no_car = NULL) => 0.0671741141, 0.0671741141),
   (r_C12_source_profile_d = NULL) => -0.0225873229, -0.0022814092),
(f_add_input_nhood_MFD_pct_i = NULL) => -0.0104205777, -0.0000747889);

// Tree: 154 
wFDN_FLAP_D_lgt_154 := map(
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => -0.0985157944,
(nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 16.15) => -0.0061556494,
   (c_hval_500k_p > 16.15) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 13.6) => 0.1318531874,
         (c_fammar18_p > 13.6) => 0.0110365450,
         (c_fammar18_p = NULL) => 0.0168434864, 0.0168434864),
      (k_comb_age_d > 71.5) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1974.5) => 0.2707700407,
         (c_med_yearblt > 1974.5) => -0.0616464379,
         (c_med_yearblt = NULL) => 0.1139698149, 0.1139698149),
      (k_comb_age_d = NULL) => 0.0212189182, 0.0212189182),
   (c_hval_500k_p = NULL) => 0.0077001992, -0.0007352438),
(nf_seg_FraudPoint_3_0 = '') => -0.0012208705, -0.0012208705);

// Tree: 155 
wFDN_FLAP_D_lgt_155 := map(
(NULL < c_unempl and c_unempl <= 184.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 34062.5) => -0.0039677827,
   (f_addrchangevaluediff_d > 34062.5) => 0.0378582124,
   (f_addrchangevaluediff_d = NULL) => -0.0105308208, -0.0040359583),
(c_unempl > 184.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 33500) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 26.75) => 0.1643306956,
      (c_hh2_p > 26.75) => 0.0115308724,
      (c_hh2_p = NULL) => 0.0906593523, 0.0906593523),
   (k_estimated_income_d > 33500) => 
      map(
      (NULL < c_white_col and c_white_col <= 26.8) => -0.0964824682,
      (c_white_col > 26.8) => 0.0699396048,
      (c_white_col = NULL) => -0.0041702246, -0.0041702246),
   (k_estimated_income_d = NULL) => 0.0400835780, 0.0400835780),
(c_unempl = NULL) => 0.0147309535, -0.0027656598);

// Tree: 156 
wFDN_FLAP_D_lgt_156 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0018554221,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 32396) => 0.0548363261,
   (f_curraddrmedianincome_d > 32396) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 14.55) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 49) => -0.0822157699,
         (f_mos_inq_banko_cm_fseen_d > 49) => 
            map(
            (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0335944943,
            (f_srchfraudsrchcountmo_i > 0.5) => 0.0818644673,
            (f_srchfraudsrchcountmo_i = NULL) => -0.0124270180, -0.0124270180),
         (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0321281489, -0.0321281489),
      (C_INC_25K_P > 14.55) => -0.1321139823,
      (C_INC_25K_P = NULL) => -0.0450429857, -0.0450429857),
   (f_curraddrmedianincome_d = NULL) => -0.0331307742, -0.0331307742),
(f_srchfraudsrchcount_i = NULL) => -0.0011433791, 0.0003116088);

// Tree: 157 
wFDN_FLAP_D_lgt_157 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => -0.0002034299,
      (k_inq_adls_per_phone_i > 3.5) => -0.0975250759,
      (k_inq_adls_per_phone_i = NULL) => -0.0006495671, -0.0006495671),
   (f_prevaddrmedianvalue_d > 809865.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 56044) => 0.2759364665,
      (r_A49_Curr_AVM_Chg_1yr_i > 56044) => 0.0938354321,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0207130925, 0.1016390960),
   (f_prevaddrmedianvalue_d = NULL) => 0.0010872083, 0.0010872083),
(f_inq_HighRiskCredit_count24_i > 8.5) => 0.0779300976,
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0594461333,
   (k_nap_lname_verd_d > 0.5) => -0.0438669750,
   (k_nap_lname_verd_d = NULL) => 0.0038591892, 0.0038591892), 0.0015756922);

// Tree: 158 
wFDN_FLAP_D_lgt_158 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0037004034,
      (k_inq_per_phone_i > 2.5) => 0.0285839872,
      (k_inq_per_phone_i = NULL) => -0.0021409232, -0.0021409232),
   (r_D33_eviction_count_i > 3.5) => 0.0712636122,
   (r_D33_eviction_count_i = NULL) => -0.0016900427, -0.0016900427),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < r_has_pb_record_d and r_has_pb_record_d <= 0.5) => 0.0029755059,
   (r_has_pb_record_d > 0.5) => -0.1448352450,
   (r_has_pb_record_d = NULL) => -0.0668240153, -0.0668240153),
(r_I60_inq_comm_count12_i = NULL) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 1.85) => 0.0494163050,
   (c_hval_80k_p > 1.85) => -0.0550026151,
   (c_hval_80k_p = NULL) => 0.0131597355, 0.0131597355), -0.0022327726);

// Tree: 159 
wFDN_FLAP_D_lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 2095) => -0.0041634246,
   (c_popover18 > 2095) => 0.0325066090,
   (c_popover18 = NULL) => 0.0192851382, 0.0013859832),
(f_rel_homeover500_count_d > 19.5) => 0.1063137913,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.75395861565) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1130731364) => -0.0829369621,
      (f_add_curr_nhood_BUS_pct_i > 0.1130731364) => 0.0782047555,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0341061386, -0.0341061386),
   (f_add_curr_nhood_SFD_pct_d > 0.75395861565) => 0.1277884790,
   (f_add_curr_nhood_SFD_pct_d = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 91.5) => 0.0538022541,
      (c_many_cars > 91.5) => -0.0418073950,
      (c_many_cars = NULL) => 0.0092635977, 0.0092635977), 0.0087755422), 0.0021652895);

// Tree: 160 
wFDN_FLAP_D_lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.55) => -0.0044860585,
(r_C12_source_profile_d > 79.55) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 49.85) => 0.0106413394,
      (C_RENTOCC_P > 49.85) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 20.35) => 0.0111565332,
         (c_rnt1000_p > 20.35) => 0.2135269165,
         (c_rnt1000_p = NULL) => 0.1188398564, 0.1188398564),
      (C_RENTOCC_P = NULL) => 0.0222150768, 0.0222150768),
   (f_srchcomponentrisktype_i > 1.5) => 0.1462466367,
   (f_srchcomponentrisktype_i = NULL) => 0.0303557079, 0.0303557079),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 85.5) => 0.0532609803,
   (c_very_rich > 85.5) => -0.0452669794,
   (c_very_rich = NULL) => -0.0078738381, -0.0078738381), -0.0015242167);

// Tree: 161 
wFDN_FLAP_D_lgt_161 := map(
(NULL < c_easiqlife and c_easiqlife <= 146.5) => -0.0107745599,
(c_easiqlife > 146.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -2.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 99.5) => 0.0068118446,
      (c_unattach > 99.5) => 0.1591204455,
      (c_unattach = NULL) => 0.0859643459, 0.0859643459),
   (f_addrchangecrimediff_i > -2.5) => 0.0080774784,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0255231591) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.9) => 0.0147842432,
         (c_pop_55_64_p > 11.9) => 0.2041661553,
         (c_pop_55_64_p = NULL) => 0.0833224590, 0.0833224590),
      (f_add_input_nhood_BUS_pct_i > 0.0255231591) => -0.0150841824,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0203017674, 0.0203017674), 0.0139574172),
(c_easiqlife = NULL) => -0.0381591844, -0.0056111141);

// Tree: 162 
wFDN_FLAP_D_lgt_162 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 44.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0056804740,
   (f_hh_payday_loan_users_i > 0.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 190.5) => 0.0251741272,
      (c_asian_lang > 190.5) => 0.1596424579,
      (c_asian_lang = NULL) => 0.0329641820, 0.0329641820),
   (f_hh_payday_loan_users_i = NULL) => -0.0021218837, -0.0021218837),
(f_phones_per_addr_curr_i > 44.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 56.5) => 0.1714408754,
   (f_mos_inq_banko_cm_lseen_d > 56.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 21.45) => -0.0504206635,
      (C_INC_75K_P > 21.45) => 0.1604024493,
      (C_INC_75K_P = NULL) => 0.0227220491, 0.0227220491),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0649067162, 0.0649067162),
(f_phones_per_addr_curr_i = NULL) => 0.0110464901, -0.0008317828);

// Tree: 163 
wFDN_FLAP_D_lgt_163 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 33431.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.35) => -0.0165278343,
   (c_pop_35_44_p > 13.35) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 36.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 49.5) => 0.0868269351,
         (f_M_Bureau_ADL_FS_all_d > 49.5) => 0.2637184857,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1706979289, 0.1706979289),
      (r_C13_Curr_Addr_LRes_d > 36.5) => 0.0175980914,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0931707771, 0.0931707771),
   (c_pop_35_44_p = NULL) => 0.0069453624, 0.0298647156),
(f_curraddrmedianvalue_d > 33431.5) => 
   map(
   (NULL < c_young and c_young <= 33.35) => 0.0013008166,
   (c_young > 33.35) => -0.0344521686,
   (c_young = NULL) => -0.0032901986, -0.0032901986),
(f_curraddrmedianvalue_d = NULL) => -0.0183308521, -0.0017541098);

// Tree: 164 
wFDN_FLAP_D_lgt_164 := map(
(NULL < c_hh2_p and c_hh2_p <= 52.55) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 102) => -0.0093302839,
   (f_curraddrcartheftindex_i > 102) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 19060.5) => 0.0133698413,
      (f_addrchangeincomediff_d > 19060.5) => 0.0961075788,
      (f_addrchangeincomediff_d = NULL) => 0.0003305546, 0.0129372674),
   (f_curraddrcartheftindex_i = NULL) => 0.0074571238, -0.0005526862),
(c_hh2_p > 52.55) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 22.1) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 17.5) => -0.0053048740,
      (C_INC_50K_P > 17.5) => 0.2042070344,
      (C_INC_50K_P = NULL) => 0.0334230848, 0.0334230848),
   (c_trailer_p > 22.1) => 0.2762205220,
   (c_trailer_p = NULL) => 0.0670216858, 0.0670216858),
(c_hh2_p = NULL) => 0.0282852771, 0.0021377862);

// Tree: 165 
wFDN_FLAP_D_lgt_165 := map(
(NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 25.05) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 13.75) => 0.0035198100,
         (C_INC_50K_P > 13.75) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 221) => 0.0314904007,
            (r_C13_max_lres_d > 221) => 0.1207248967,
            (r_C13_max_lres_d = NULL) => 0.0514845293, 0.0514845293),
         (C_INC_50K_P = NULL) => 0.0228914766, 0.0228914766),
      (f_phone_ver_experian_d > 0.5) => -0.0034362962,
      (f_phone_ver_experian_d = NULL) => -0.0013126132, 0.0062323398),
   (c_pop_55_64_p > 25.05) => 0.1757908060,
   (c_pop_55_64_p = NULL) => -0.0029772874, 0.0074805687),
(k_inf_lname_verd_d > 0.5) => -0.0239425696,
(k_inf_lname_verd_d = NULL) => -0.0029013291, -0.0029013291);

// Tree: 166 
wFDN_FLAP_D_lgt_166 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 11.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 45.5) => 0.1208767704,
   (f_mos_inq_banko_cm_lseen_d > 45.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 39.5) => 0.1274564262,
      (f_prevaddrlenofres_d > 39.5) => -0.0655601337,
      (f_prevaddrlenofres_d = NULL) => 0.0212402127, 0.0212402127),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0489170343, 0.0489170343),
(r_D32_Mos_Since_Crim_LS_d > 11.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 44.35) => -0.0078508547,
   (c_fammar18_p > 44.35) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 11766) => 0.0124410515,
      (f_addrchangevaluediff_d > 11766) => 0.0977996386,
      (f_addrchangevaluediff_d = NULL) => 0.0265373422, 0.0179735716),
   (c_fammar18_p = NULL) => 0.0280796886, -0.0005610408),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0269375229, -0.0000038874);

// Tree: 167 
wFDN_FLAP_D_lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 206.5) => -0.0754944026,
   (f_mos_liens_unrel_CJ_lseen_d > 206.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 57.25) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 74.05) => 0.0215608865,
         (r_C12_source_profile_d > 74.05) => 
            map(
            (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 86.5) => 0.2397122660,
            (f_fp_prevaddrburglaryindex_i > 86.5) => 0.0258102419,
            (f_fp_prevaddrburglaryindex_i = NULL) => 0.1275862050, 0.1275862050),
         (r_C12_source_profile_d = NULL) => 0.0355175101, 0.0355175101),
      (c_rnt750_p > 57.25) => 0.1762502977,
      (c_rnt750_p = NULL) => 0.0447321569, 0.0447321569),
   (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0363029886, 0.0363029886),
(c_many_cars > 22.5) => -0.0075263801,
(c_many_cars = NULL) => 0.0009159559, -0.0035359684);

// Tree: 168 
wFDN_FLAP_D_lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0060947321,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.05) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 127.5) => -0.0031505867,
      (c_easiqlife > 127.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 76.35) => 
            map(
            (NULL < c_hh4_p and c_hh4_p <= 11.45) => 0.0291368654,
            (c_hh4_p > 11.45) => 0.2060010133,
            (c_hh4_p = NULL) => 0.1316668062, 0.1316668062),
         (c_fammar_p > 76.35) => -0.0163951545,
         (c_fammar_p = NULL) => 0.0748215892, 0.0748215892),
      (c_easiqlife = NULL) => 0.0190987985, 0.0190987985),
   (r_C12_source_profile_d > 81.05) => 0.1995569345,
   (r_C12_source_profile_d = NULL) => 0.0357885683, 0.0357885683),
(c_hval_150k_p = NULL) => -0.0117800129, -0.0033432986);

// Tree: 169 
wFDN_FLAP_D_lgt_169 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.1258939528,
   (r_C12_source_profile_d > 57.95) => -0.0052344982,
   (r_C12_source_profile_d = NULL) => 0.0552863254, 0.0552863254),
(f_mos_liens_unrel_SC_fseen_d > 66.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 36.25) => -0.0057217170,
   (c_hval_500k_p > 36.25) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 114.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 20.5) => -0.0137764367,
         (c_pop_35_44_p > 20.5) => 0.1823425452,
         (c_pop_35_44_p = NULL) => 0.0222748468, 0.0222748468),
      (c_no_labfor > 114.5) => 0.1640943236,
      (c_no_labfor = NULL) => 0.0578273878, 0.0578273878),
   (c_hval_500k_p = NULL) => 0.0078687190, -0.0035760040),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0016706221, -0.0028860032);

// Tree: 170 
wFDN_FLAP_D_lgt_170 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0860909441,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => 0.0015719460,
      (r_D32_criminal_count_i > 5.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 13.55) => -0.0136050517,
         (C_INC_50K_P > 13.55) => 0.1113630231,
         (C_INC_50K_P = NULL) => 0.0498477305, 0.0498477305),
      (r_D32_criminal_count_i = NULL) => 0.0026090112, 0.0026090112),
   (f_util_adl_count_n > 13.5) => 0.1204243472,
   (f_util_adl_count_n = NULL) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 7.75) => -0.0263397137,
      (C_INC_150K_P > 7.75) => 0.0820097904,
      (C_INC_150K_P = NULL) => 0.0108846558, 0.0108846558), 0.0035455516),
(c_pop_45_54_p = NULL) => -0.0376931132, 0.0015311004);

// Tree: 171 
wFDN_FLAP_D_lgt_171 := map(
(NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 1.5) => 0.0011541178,
(f_inq_Other_count24_i > 1.5) => 
   map(
   (NULL < c_families and c_families <= 174.5) => -0.0945417366,
   (c_families > 174.5) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 34) => 
         map(
         (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 1.5) => 0.0233765116,
         (f_hh_members_w_derog_i > 1.5) => 0.1955294126,
         (f_hh_members_w_derog_i = NULL) => 0.0989558340, 0.0989558340),
      (f_mos_inq_banko_om_lseen_d > 34) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 111500) => 0.1524569468,
         (r_A46_Curr_AVM_AutoVal_d > 111500) => 0.0254201559,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0012954681, 0.0283515228),
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0423585071, 0.0423585071),
   (c_families = NULL) => 0.0304629042, 0.0304629042),
(f_inq_Other_count24_i = NULL) => -0.0087371802, 0.0025832596);

// Tree: 172 
wFDN_FLAP_D_lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.55) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 20247.5) => 0.0775514089,
      (r_L80_Inp_AVM_AutoVal_d > 20247.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.74120745405) => 0.0005166055,
         (f_add_curr_nhood_MFD_pct_i > 0.74120745405) => 0.0718923667,
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0167563704, -0.0005250958),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0007227376, 0.0004348513),
   (c_manufacturing > 16.55) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => -0.1175460661,
      (nf_vf_hi_risk_index > 6.5) => -0.0462919876,
      (nf_vf_hi_risk_index = NULL) => -0.0508498178, -0.0508498178),
   (c_manufacturing = NULL) => -0.0035168215, -0.0035168215),
(c_pop_0_5_p > 20.55) => 0.1602495102,
(c_pop_0_5_p = NULL) => 0.0025045739, -0.0026450841);

// Tree: 173 
wFDN_FLAP_D_lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0078498321,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 119.5) => 0.2073067141,
      (c_easiqlife > 119.5) => 0.0371778814,
      (c_easiqlife = NULL) => 0.1152186304, 0.1152186304),
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 15.35) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.75) => 0.0731905272,
         (c_pop_55_64_p > 8.75) => 0.0025382629,
         (c_pop_55_64_p = NULL) => 0.0279442193, 0.0279442193),
      (C_INC_25K_P > 15.35) => -0.0411275659,
      (C_INC_25K_P = NULL) => 0.0156114500, 0.0156114500),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0217951173, 0.0217951173),
(f_rel_felony_count_i = NULL) => -0.0188092326, -0.0038198635);

// Tree: 174 
wFDN_FLAP_D_lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 19.5) => 
   map(
   (NULL < c_info and c_info <= 27.55) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13087120455) => -0.0038892412,
      (f_add_curr_nhood_BUS_pct_i > 0.13087120455) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0053932894,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.0796209491,
         (nf_seg_FraudPoint_3_0 = '') => 0.0233015391, 0.0233015391),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0081810776, -0.0001756873),
   (c_info > 27.55) => 0.1884642504,
   (c_info = NULL) => 0.0032400141, 0.0009018708),
(f_srchphonesrchcount_i > 19.5) => -0.1024059667,
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 3.95) => 0.0423650706,
   (c_femdiv_p > 3.95) => -0.0609904964,
   (c_femdiv_p = NULL) => -0.0207581280, -0.0207581280), -0.0000566183);

// Tree: 175 
wFDN_FLAP_D_lgt_175 := map(
(NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 18.95) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 18.5) => -0.0422309035,
      (f_mos_inq_banko_om_fseen_d > 18.5) => 0.0113534328,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0414827619, 0.0072323520),
   (c_pop_0_5_p > 18.95) => 0.1519551217,
   (c_pop_0_5_p = NULL) => 0.0174916164, 0.0086087778),
(r_Phn_Cell_n > 0.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 15.35) => 0.1017740937,
   (c_white_col > 15.35) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 14.5) => -0.0168793534,
      (f_rel_criminal_count_i > 14.5) => -0.1112968788,
      (f_rel_criminal_count_i = NULL) => -0.0523990740, -0.0182057532),
   (c_white_col = NULL) => 0.0027989031, -0.0158038456),
(r_Phn_Cell_n = NULL) => -0.0029403079, -0.0029403079);

// Tree: 176 
wFDN_FLAP_D_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0048078054,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 353.5) => 0.1928318239,
         (r_A50_pb_total_dollars_d > 353.5) => 0.0293643385,
         (r_A50_pb_total_dollars_d = NULL) => 0.1058249365, 0.1058249365),
      (f_phone_ver_experian_d > 0.5) => 0.0020679459,
      (f_phone_ver_experian_d = NULL) => 0.0952154605, 0.0432224742),
   (f_util_adl_count_n = NULL) => 0.0130787196, 0.0073531794),
(c_pop_18_24_p > 11.15) => -0.0246465675,
(c_pop_18_24_p = NULL) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 6.5) => 0.1433453919,
   (r_F00_input_dob_match_level_d > 6.5) => 0.0034595803,
   (r_F00_input_dob_match_level_d = NULL) => 0.0356172381, 0.0356172381), 0.0007103719);

// Tree: 177 
wFDN_FLAP_D_lgt_177 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 104.5) => -0.0036955162,
(f_prevaddrageoldest_d > 104.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 120.5) => 0.0068038202,
      (c_ab_av_edu > 120.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 71500) => 
            map(
            (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.05) => 0.2601506033,
            (c_pop_45_54_p > 12.05) => 0.0464950213,
            (c_pop_45_54_p = NULL) => 0.0787706518, 0.0787706518),
         (r_A49_Curr_AVM_Chg_1yr_i > 71500) => 0.2369917845,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0610598789, 0.0869748918),
      (c_ab_av_edu = NULL) => -0.0096500500, 0.0386817946),
   (f_phone_ver_insurance_d > 3.5) => -0.0060398250,
   (f_phone_ver_insurance_d = NULL) => 0.0138122110, 0.0138122110),
(f_prevaddrageoldest_d = NULL) => -0.0237794494, 0.0022489058);

// Tree: 178 
wFDN_FLAP_D_lgt_178 := map(
(NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0103314671,
(f_phones_per_addr_c6_i > 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1.5) => 
      map(
      (NULL < nf_altlexid_phone_hi_no_hi_lexid and nf_altlexid_phone_hi_no_hi_lexid <= 0.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 23.75) => -0.0071101653,
         (c_hh3_p > 23.75) => 0.0753576142,
         (c_hh3_p = NULL) => 0.0028737053, 0.0028737053),
      (nf_altlexid_phone_hi_no_hi_lexid > 0.5) => 0.1445815318,
      (nf_altlexid_phone_hi_no_hi_lexid = NULL) => 0.0051751256, 0.0051751256),
   (f_addrchangeincomediff_d > 1.5) => 
      map(
      (NULL < c_rental and c_rental <= 162.5) => 0.0356502659,
      (c_rental > 162.5) => 0.1741715220,
      (c_rental = NULL) => 0.0706234543, 0.0706234543),
   (f_addrchangeincomediff_d = NULL) => 0.0253795659, 0.0125273740),
(f_phones_per_addr_c6_i = NULL) => -0.0021934674, -0.0021934674);

// Tree: 179 
wFDN_FLAP_D_lgt_179 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 51.7) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 191) => 0.0335050909,
         (f_curraddrcartheftindex_i > 191) => 0.1476424227,
         (f_curraddrcartheftindex_i = NULL) => 0.0387441816, 0.0387441816),
      (c_hh2_p > 51.7) => 0.3305510700,
      (c_hh2_p = NULL) => 0.0504531913, 0.0504531913),
   (r_C14_addrs_10yr_i > 2.5) => -0.0134861930,
   (r_C14_addrs_10yr_i = NULL) => 0.0228574277, 0.0228574277),
(f_hh_members_ct_d > 1.5) => -0.0072932147,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < C_INC_200K_P and C_INC_200K_P <= 2.65) => 0.0838979676,
   (C_INC_200K_P > 2.65) => -0.0049299691,
   (C_INC_200K_P = NULL) => 0.0246793432, 0.0246793432), -0.0012970212);

// Tree: 180 
wFDN_FLAP_D_lgt_180 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 148.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 46.5) => 0.0044147607,
   (c_famotf18_p > 46.5) => 0.1427920725,
   (c_famotf18_p = NULL) => 0.0414268033, 0.0060270430),
(f_prevaddrcartheftindex_i > 148.5) => 
   map(
   (NULL < c_retail and c_retail <= 46.35) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 119643) => -0.0504768756,
      (c_med_hval > 119643) => -0.0064042071,
      (c_med_hval = NULL) => -0.0220499056, -0.0220499056),
   (c_retail > 46.35) => 0.1088925418,
   (c_retail = NULL) => -0.0188436192, -0.0188436192),
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 7.05) => -0.0297317974,
   (c_professional > 7.05) => 0.0580436700,
   (c_professional = NULL) => 0.0034805417, 0.0034805417), 0.0014963753);

// Tree: 181 
wFDN_FLAP_D_lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 9.35) => -0.0127068881,
   (C_INC_35K_P > 9.35) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0614611819) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 101.5) => 
            map(
            (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 0.5) => 0.0237748791,
            (f_assocsuspicousidcount_i > 0.5) => 0.2218554318,
            (f_assocsuspicousidcount_i = NULL) => 0.1246158877, 0.1246158877),
         (c_bel_edu > 101.5) => -0.0211031081,
         (c_bel_edu = NULL) => 0.0437919913, 0.0437919913),
      (f_add_input_nhood_VAC_pct_i > 0.0614611819) => 0.1675137143,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0768334010, 0.0768334010),
   (C_INC_35K_P = NULL) => 0.0274195446, 0.0274195446),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0054894984,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0060195442, -0.0033516470);

// Tree: 182 
wFDN_FLAP_D_lgt_182 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 6.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0053817474,
   (k_inq_per_addr_i > 3.5) => 0.0216877202,
   (k_inq_per_addr_i = NULL) => -0.0024793271, -0.0024793271),
(f_hh_tot_derog_i > 6.5) => 
   map(
   (NULL < c_rnt1500_p and c_rnt1500_p <= 7.6) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 5.75) => 0.1802081902,
      (c_newhouse > 5.75) => 0.0265526753,
      (c_newhouse = NULL) => 0.0950747293, 0.0950747293),
   (c_rnt1500_p > 7.6) => -0.0948018147,
   (c_rnt1500_p = NULL) => 0.0464129014, 0.0464129014),
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 0.0384968656,
   (f_bus_name_nover_i > 0.5) => -0.0582414161,
   (f_bus_name_nover_i = NULL) => 0.0036260897, 0.0036260897), -0.0016179663);

// Tree: 183 
wFDN_FLAP_D_lgt_183 := map(
(NULL < c_oldhouse and c_oldhouse <= 613.2) => 
   map(
   (NULL < c_transport and c_transport <= 26.65) => -0.0053368338,
   (c_transport > 26.65) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 109) => 0.2548078292,
         (c_lar_fam > 109) => 0.0386698725,
         (c_lar_fam = NULL) => 0.1435912107, 0.1435912107),
      (f_rel_incomeover50_count_d > 4.5) => 0.0017571926,
      (f_rel_incomeover50_count_d = NULL) => 0.0644563508, 0.0644563508),
   (c_transport = NULL) => -0.0038958823, -0.0038958823),
(c_oldhouse > 613.2) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => -0.1160046384,
   (nf_vf_hi_risk_index > 6.5) => -0.0376747765,
   (nf_vf_hi_risk_index = NULL) => -0.0530972364, -0.0530972364),
(c_oldhouse = NULL) => 0.0095556388, -0.0051035366);

// Tree: 184 
wFDN_FLAP_D_lgt_184 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 92.2) => 
   map(
   (NULL < c_robbery and c_robbery <= 11) => -0.0427870709,
   (c_robbery > 11) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 80) => -0.0901274531,
         (r_F00_dob_score_d > 80) => 0.0055234946,
         (r_F00_dob_score_d = NULL) => 0.0009993945, 0.0048185226),
      (f_phones_per_addr_curr_i > 50.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 130) => 0.0060379628,
         (r_C13_max_lres_d > 130) => 0.1575751560,
         (r_C13_max_lres_d = NULL) => 0.0648700496, 0.0648700496),
      (f_phones_per_addr_curr_i = NULL) => -0.0007384540, 0.0056472337),
   (c_robbery = NULL) => 0.0021547723, 0.0021547723),
(C_RENTOCC_P > 92.2) => -0.0928250331,
(C_RENTOCC_P = NULL) => 0.0145954396, 0.0017046880);

// Tree: 185 
wFDN_FLAP_D_lgt_185 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 0.0058365113,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.18579139885) => 0.1988546573,
      (f_add_curr_mobility_index_i > 0.18579139885) => 
         map(
         (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 2.5) => 
            map(
            (NULL < c_hh7p_p and c_hh7p_p <= 0.7) => 0.1344792486,
            (c_hh7p_p > 0.7) => 0.0097130392,
            (c_hh7p_p = NULL) => 0.0660395318, 0.0660395318),
         (f_rel_ageover40_count_d > 2.5) => -0.0284812288,
         (f_rel_ageover40_count_d = NULL) => 0.0221722044, 0.0221722044),
      (f_add_curr_mobility_index_i = NULL) => 0.0450462720, 0.0450462720),
   (f_hh_tot_derog_i = NULL) => 0.0073870244, 0.0073870244),
(r_D31_ALL_Bk_i > 1.5) => -0.0375483301,
(r_D31_ALL_Bk_i = NULL) => 0.0006368262, 0.0034036291);

// Tree: 186 
wFDN_FLAP_D_lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3923820453) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.75) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30263) => 0.0389776161,
         (f_curraddrmedianincome_d > 30263) => 0.0022089176,
         (f_curraddrmedianincome_d = NULL) => 0.0045556299, 0.0045556299),
      (c_pop_6_11_p > 15.75) => 0.1609596694,
      (c_pop_6_11_p = NULL) => -0.0370201035, 0.0049783427),
   (f_add_input_mobility_index_i > 0.3923820453) => -0.0272016505,
   (f_add_input_mobility_index_i = NULL) => -0.0021546789, 0.0001736413),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0794262992,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 9.8) => -0.0583517953,
   (c_hh4_p > 9.8) => 0.0521946295,
   (c_hh4_p = NULL) => 0.0122750872, 0.0122750872), 0.0006866485);

// Tree: 187 
wFDN_FLAP_D_lgt_187 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => -0.0011993110,
   (r_L72_Add_Vacant_i > 0.5) => 0.1069635442,
   (r_L72_Add_Vacant_i = NULL) => -0.0005156469, -0.0005156469),
(f_rel_incomeover50_count_d > 22.5) => -0.0723462244,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 101.5) => -0.0484879028,
   (c_preschl > 101.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 9.85) => -0.0689635825,
      (c_hh4_p > 9.85) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1216622529,
         (r_Phn_Cell_n > 0.5) => -0.0031528828,
         (r_Phn_Cell_n = NULL) => 0.0648498463, 0.0648498463),
      (c_hh4_p = NULL) => 0.0300310460, 0.0300310460),
   (c_preschl = NULL) => -0.0077743738, -0.0077743738), -0.0021477883);

// Tree: 188 
wFDN_FLAP_D_lgt_188 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 136.5) => -0.0807347069,
   (c_serv_empl > 136.5) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.05) => 0.0784308998,
      (c_pop_75_84_p > 2.05) => -0.0498176968,
      (c_pop_75_84_p = NULL) => 0.0070577678, 0.0070577678),
   (c_serv_empl = NULL) => -0.0377724321, -0.0377724321),
(nf_vf_hi_risk_index > 3.5) => 
   map(
   (NULL < c_info and c_info <= 24.5) => 0.0017282441,
   (c_info > 24.5) => 0.1240165813,
   (c_info = NULL) => -0.0225175686, 0.0020059379),
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 16.15) => 0.0826223639,
   (C_INC_75K_P > 16.15) => -0.0130296715,
   (C_INC_75K_P = NULL) => 0.0263208494, 0.0263208494), 0.0016224044);

// Tree: 189 
wFDN_FLAP_D_lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 44.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0047674492,
   (f_rel_homeover500_count_d > 14.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 45.5) => 0.1749790483,
      (f_fp_prevaddrburglaryindex_i > 45.5) => -0.0406640259,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0681651891, 0.0681651891),
   (f_rel_homeover500_count_d = NULL) => 0.0086443258, -0.0038936527),
(f_phones_per_addr_curr_i > 44.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 0.0102879518,
   (f_rel_under25miles_cnt_d > 5.5) => 0.1555337240,
   (f_rel_under25miles_cnt_d = NULL) => 0.0640826822, 0.0640826822),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 28.7) => 0.0825383270,
   (c_fammar18_p > 28.7) => -0.0216788365,
   (c_fammar18_p = NULL) => 0.0155415791, 0.0155415791), -0.0025889928);

// Tree: 190 
wFDN_FLAP_D_lgt_190 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 0.5) => -0.0025084734,
(f_vf_AltLexID_addr_hi_risk_ct_i > 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 0.1) => 0.0468309155,
      (c_hh5_p > 0.1) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 176.5) => -0.0714834919,
         (c_new_homes > 176.5) => 0.0224058529,
         (c_new_homes = NULL) => -0.0561546193, -0.0561546193),
      (c_hh5_p = NULL) => -0.0432814275, -0.0432814275),
   (f_srchcomponentrisktype_i > 2.5) => 0.0427204403,
   (f_srchcomponentrisktype_i = NULL) => -0.0333123528, -0.0333123528),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 54.5) => -0.0778141765,
   (c_burglary > 54.5) => 0.0273548500,
   (c_burglary = NULL) => -0.0125827550, -0.0125827550), -0.0040582022);

// Tree: 191 
wFDN_FLAP_D_lgt_191 := map(
(NULL < c_totcrime and c_totcrime <= 163.5) => -0.0039756993,
(c_totcrime > 163.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 21.5) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 161.5) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.2254753662,
         (f_corraddrnamecount_d > 3.5) => 0.0499923320,
         (f_corraddrnamecount_d = NULL) => 0.0801020215, 0.0801020215),
      (c_cartheft > 161.5) => -0.0045906785,
      (c_cartheft = NULL) => 0.0223176495, 0.0223176495),
   (f_rel_educationover8_count_d > 21.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 5.85) => 0.2002521653,
      (c_unemp > 5.85) => 0.0193588933,
      (c_unemp = NULL) => 0.1080661709, 0.1080661709),
   (f_rel_educationover8_count_d = NULL) => 0.0212481562, 0.0289693714),
(c_totcrime = NULL) => -0.0366840520, -0.0012614604);

// Tree: 192 
wFDN_FLAP_D_lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 120) => 0.0738267830,
(r_D32_Mos_Since_Fel_LS_d > 120) => 
   map(
   (NULL < c_unempl and c_unempl <= 165.5) => -0.0017047184,
   (c_unempl > 165.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.33755250655) => -0.0891204682,
         (f_add_curr_mobility_index_i > 0.33755250655) => -0.0325887000,
         (f_add_curr_mobility_index_i = NULL) => -0.0740105947, -0.0740105947),
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0145368512,
      (nf_seg_FraudPoint_3_0 = '') => -0.0297543114, -0.0297543114),
   (c_unempl = NULL) => 0.0030236890, -0.0035340106),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 1.85) => -0.0486796503,
   (c_high_hval > 1.85) => 0.0507822321,
   (c_high_hval = NULL) => 0.0029162012, 0.0029162012), -0.0030069356);

// Tree: 193 
wFDN_FLAP_D_lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0079938674,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.2263890073,
   (f_adl_per_email_i > 0.5) => -0.0335731856,
   (f_adl_per_email_i = NULL) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 12.15) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 0.0175852172,
         (f_corrrisktype_i > 8.5) => 
            map(
            (NULL < c_sfdu_p and c_sfdu_p <= 72.15) => 0.1652511674,
            (c_sfdu_p > 72.15) => 0.0105196111,
            (c_sfdu_p = NULL) => 0.0853897190, 0.0853897190),
         (f_corrrisktype_i = NULL) => 0.0207869530, 0.0207869530),
      (c_hval_40k_p > 12.15) => -0.0952144705,
      (c_hval_40k_p = NULL) => 0.0141249905, 0.0141249905), 0.0176247303),
(f_prevaddrageoldest_d = NULL) => -0.0178753106, -0.0021891681);

// Tree: 194 
wFDN_FLAP_D_lgt_194 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 79.3) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 99.5) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 1.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 0.0680409546,
         (f_mos_inq_banko_cm_lseen_d > 35.5) => 0.0195027976,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0244861813, 0.0244861813),
      (r_C18_invalid_addrs_per_adl_i > 1.5) => -0.0169492871,
      (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0215703266, 0.0066065769),
   (c_no_teens > 99.5) => -0.0139797224,
   (c_no_teens = NULL) => -0.0036781440, -0.0036781440),
(c_rnt1000_p > 79.3) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 703.5) => -0.0083482478,
   (r_A50_pb_total_dollars_d > 703.5) => 0.1869066758,
   (r_A50_pb_total_dollars_d = NULL) => 0.0797667947, 0.0797667947),
(c_rnt1000_p = NULL) => -0.0090269645, -0.0025056108);

// Tree: 195 
wFDN_FLAP_D_lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 2.15) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 4.5) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 39.5) => 0.1365071163,
         (r_A50_pb_total_dollars_d > 39.5) => -0.0584467744,
         (r_A50_pb_total_dollars_d = NULL) => -0.0376303425, -0.0376303425),
      (f_inq_Collection_count_i > 4.5) => -0.1687246823,
      (f_inq_Collection_count_i = NULL) => -0.0500575011, -0.0500575011),
   (c_pop_18_24_p > 2.15) => 0.0063039254,
   (c_pop_18_24_p = NULL) => 0.0037854925, 0.0037854925),
(c_hval_80k_p > 40.05) => -0.1115844114,
(c_hval_80k_p = NULL) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 26.5) => 0.1810000709,
   (f_mos_inq_banko_cm_lseen_d > 26.5) => -0.0104896075,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0242005517, 0.0242005517), 0.0032106323);

// Tree: 196 
wFDN_FLAP_D_lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0889602564,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 44.45) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 25.95) => -0.0014705340,
      (c_hval_60k_p > 25.95) => 0.0763653778,
      (c_hval_60k_p = NULL) => -0.0003430473, -0.0003430473),
   (c_hval_60k_p > 44.45) => -0.1172585474,
   (c_hval_60k_p = NULL) => 0.0228907551, -0.0003518978),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0100067257) => -0.0504858345,
   (f_add_input_nhood_VAC_pct_i > 0.0100067257) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 1.85) => -0.0142701663,
      (c_hval_150k_p > 1.85) => 0.0888305983,
      (c_hval_150k_p = NULL) => 0.0406526709, 0.0406526709),
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0010479801, 0.0010479801), -0.0025451555);

// Tree: 197 
wFDN_FLAP_D_lgt_197 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -91324) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 6.6) => -0.0535853460,
      (c_hval_125k_p > 6.6) => 0.1017011539,
      (c_hval_125k_p = NULL) => 0.0006585683, 0.0006585683),
   (r_L79_adls_per_addr_c6_i > 1.5) => 0.1277198725,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0410331883, 0.0410331883),
(f_addrchangevaluediff_d > -91324) => -0.0003214577,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 10.45) => -0.0146706481,
   (c_hh5_p > 10.45) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 14.75) => -0.0024826816,
      (C_INC_100K_P > 14.75) => 0.1143482104,
      (C_INC_100K_P = NULL) => 0.0494915175, 0.0494915175),
   (c_hh5_p = NULL) => -0.0114374856, -0.0026759410), -0.0001596524);

// Tree: 198 
wFDN_FLAP_D_lgt_198 := map(
(NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.0100332058) => -0.0433460256,
(f_add_input_nhood_SFD_pct_d > 0.0100332058) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 24.5) => -0.0307734281,
   (r_A50_pb_average_dollars_d > 24.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 26.85) => 
         map(
         (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 9.5) => -0.0042674756,
         (f_rel_ageover20_count_d > 9.5) => -0.0996923217,
         (f_rel_ageover20_count_d = NULL) => -0.0488409235, -0.0488409235),
      (c_fammar_p > 26.85) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 22.5) => 0.0531544047,
         (c_many_cars > 22.5) => 0.0078467850,
         (c_many_cars = NULL) => 0.0105653304, 0.0105653304),
      (c_fammar_p = NULL) => 0.0096775657, 0.0096775657),
   (r_A50_pb_average_dollars_d = NULL) => 0.0069907743, 0.0050552948),
(f_add_input_nhood_SFD_pct_d = NULL) => 0.0024263228, 0.0024263228);

// Tree: 199 
wFDN_FLAP_D_lgt_199 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 27.65) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 5.5) => 0.0015418803,
      (f_idverrisktype_i > 5.5) => -0.0337356311,
      (f_idverrisktype_i = NULL) => -0.0134483272, -0.0013197438),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 309375) => 
         map(
         (NULL < c_med_age and c_med_age <= 35.1) => -0.0151176742,
         (c_med_age > 35.1) => 0.1696739927,
         (c_med_age = NULL) => 0.0823708430, 0.0823708430),
      (f_prevaddrmedianvalue_d > 309375) => -0.0535661227,
      (f_prevaddrmedianvalue_d = NULL) => 0.0382636360, 0.0382636360),
   (k_nap_contradictory_i = NULL) => -0.0006669878, -0.0006669878),
(C_INC_25K_P > 27.65) => 0.0821292302,
(C_INC_25K_P = NULL) => -0.0414873395, -0.0010064247);

// Tree: 200 
wFDN_FLAP_D_lgt_200 := map(
(NULL < c_unempl and c_unempl <= 184.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0540921673,
   (f_mos_inq_banko_om_fseen_d > 5.5) => -0.0028817026,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0147207010, -0.0049026608),
(c_unempl > 184.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.1093464527,
   (k_estimated_income_d > 28500) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 277) => 
         map(
         (NULL < c_apt20 and c_apt20 <= 114.5) => -0.0324741333,
         (c_apt20 > 114.5) => 0.1637046769,
         (c_apt20 = NULL) => 0.0638944050, 0.0638944050),
      (r_C21_M_Bureau_ADL_FS_d > 277) => -0.1000209329,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0032185617, 0.0032185617),
   (k_estimated_income_d = NULL) => 0.0334209655, 0.0334209655),
(c_unempl = NULL) => -0.0315362540, -0.0047525682);

// Tree: 201 
wFDN_FLAP_D_lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 0.5) => -0.0026525254,
   (f_vf_AltLexID_addr_hi_risk_ct_i > 0.5) => -0.0355133817,
   (f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => -0.0124101056, -0.0041904753),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 13.5) => 0.0305525549,
   (f_addrchangecrimediff_i > 13.5) => 0.1215915692,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 502) => -0.0989353805,
      (c_hh00 > 502) => 
         map(
         (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => -0.0145006873,
         (f_util_add_input_misc_n > 0.5) => 0.1840429661,
         (f_util_add_input_misc_n = NULL) => 0.0545579747, 0.0545579747),
      (c_hh00 = NULL) => 0.0915849552, 0.0266126021), 0.0361014716),
(r_L70_Add_Standardized_i = NULL) => -0.0008426068, -0.0008426068);

// Tree: 202 
wFDN_FLAP_D_lgt_202 := map(
(NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 448.5) => -0.0009908381,
(r_P88_Phn_Dst_to_Inp_Add_i > 448.5) => -0.0642583582,
(r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 8.55) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 372) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 102) => 0.0015447838,
         (c_cartheft > 102) => 
            map(
            (NULL < c_pop_35_44_p and c_pop_35_44_p <= 10.25) => -0.0467561414,
            (c_pop_35_44_p > 10.25) => 0.1195422344,
            (c_pop_35_44_p = NULL) => 0.0796151185, 0.0796151185),
         (c_cartheft = NULL) => 0.0254166110, 0.0254166110),
      (r_C21_M_Bureau_ADL_FS_d > 372) => 0.1638045129,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0318138764, 0.0318138764),
   (c_famotf18_p > 8.55) => -0.0105982607,
   (c_famotf18_p = NULL) => -0.0023425967, 0.0080735949), 0.0002141014);

// Tree: 203 
wFDN_FLAP_D_lgt_203 := map(
(NULL < c_hh1_p and c_hh1_p <= 13.95) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.0881468592,
   (r_F00_dob_score_d > 98) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.83040046205) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.219626445) => 0.0021854884,
         (f_add_curr_mobility_index_i > 0.219626445) => 
            map(
            (NULL < c_assault and c_assault <= 8) => 0.1844107544,
            (c_assault > 8) => 0.0240439664,
            (c_assault = NULL) => 0.0380781998, 0.0380781998),
         (f_add_curr_mobility_index_i = NULL) => 0.0241668417, 0.0241668417),
      (f_add_curr_nhood_MFD_pct_i > 0.83040046205) => 0.1322374953,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0025692405, 0.0197396382),
   (r_F00_dob_score_d = NULL) => -0.0497945668, 0.0184319534),
(c_hh1_p > 13.95) => -0.0066995134,
(c_hh1_p = NULL) => -0.0105742287, -0.0018287006);

// Tree: 204 
wFDN_FLAP_D_lgt_204 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 41) => 0.1453786588,
      (f_curraddrmurderindex_i > 41) => -0.0034420037,
      (f_curraddrmurderindex_i = NULL) => 0.0519699451, 0.0519699451),
   (r_C10_M_Hdr_FS_d > 11.5) => 0.0021176035,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0028849393, 0.0028849393),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.25) => -0.0319762143,
   (c_pop_0_5_p > 8.25) => -0.1172348975,
   (c_pop_0_5_p = NULL) => -0.0660796876, -0.0660796876),
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 0.45) => 0.0454242366,
   (c_wholesale > 0.45) => -0.0491579840,
   (c_wholesale = NULL) => 0.0019996950, 0.0019996950), 0.0013171306);

// Tree: 205 
wFDN_FLAP_D_lgt_205 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 52.5) => -0.0096575835,
(f_prevaddrageoldest_d > 52.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 15.35) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 0.0088066640,
      (r_P85_Phn_Disconnected_i > 0.5) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 123) => -0.0289338837,
         (c_ab_av_edu > 123) => 0.2828153020,
         (c_ab_av_edu = NULL) => 0.1242532162, 0.1242532162),
      (r_P85_Phn_Disconnected_i = NULL) => 0.0108222871, 0.0108222871),
   (c_hh6_p > 15.35) => 0.1364440288,
   (c_hh6_p = NULL) => 0.0236627805, 0.0123724858),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 119) => -0.0332306339,
   (c_rich_fam > 119) => 0.0528202551,
   (c_rich_fam = NULL) => 0.0021015192, 0.0021015192), 0.0024150650);

// Tree: 206 
wFDN_FLAP_D_lgt_206 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 186.5) => -0.0831642793,
(f_mos_liens_unrel_FT_fseen_d > 186.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0045021595,
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 0.4) => -0.0351082541,
      (c_low_hval > 0.4) => 0.1103408591,
      (c_low_hval = NULL) => 0.0459523189, 0.0459523189),
   (f_assoccredbureaucountnew_i = NULL) => -0.0034453289, -0.0034453289),
(f_mos_liens_unrel_FT_fseen_d = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 9.35) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 92.4) => 0.0160883080,
      (c_occunit_p > 92.4) => -0.0994682835,
      (c_occunit_p = NULL) => -0.0416899878, -0.0416899878),
   (c_high_hval > 9.35) => 0.0598790375,
   (c_high_hval = NULL) => -0.0044690406, -0.0044690406), -0.0042652405);

// Tree: 207 
wFDN_FLAP_D_lgt_207 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5701) => 
      map(
      (NULL < c_rnt2001_p and c_rnt2001_p <= 82.7) => -0.0032530886,
      (c_rnt2001_p > 82.7) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.2816592990,
         (r_Phn_Cell_n > 0.5) => -0.0493460677,
         (r_Phn_Cell_n = NULL) => 0.1161566157, 0.1161566157),
      (c_rnt2001_p = NULL) => 0.0270521198, -0.0016488536),
   (f_liens_unrel_SC_total_amt_i > 5701) => 0.1194071157,
   (f_liens_unrel_SC_total_amt_i = NULL) => -0.0011026337, -0.0011026337),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 12.75) => 0.0129128601,
   (C_INC_100K_P > 12.75) => -0.1191720753,
   (C_INC_100K_P = NULL) => -0.0556217762, -0.0556217762),
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0076995155, -0.0016455825);

// Tree: 208 
wFDN_FLAP_D_lgt_208 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 103.5) => -0.0026942204,
(f_addrchangecrimediff_i > 103.5) => 0.0778511397,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 130141) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 21.35) => 0.0138602932,
      (c_hval_250k_p > 21.35) => 0.1800241684,
      (c_hval_250k_p = NULL) => 0.0392935394, 0.0392935394),
   (r_L80_Inp_AVM_AutoVal_d > 130141) => -0.0049462927,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 132.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 36368) => 0.0512476632,
         (f_curraddrmedianincome_d > 36368) => -0.0212361252,
         (f_curraddrmedianincome_d = NULL) => -0.0100241453, -0.0000279262),
      (c_mort_indx > 132.5) => -0.0780251807,
      (c_mort_indx = NULL) => -0.0061612790, -0.0150911303), -0.0046552778), -0.0026934367);

// Tree: 209 
wFDN_FLAP_D_lgt_209 := map(
(NULL < c_hh2_p and c_hh2_p <= 17.65) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.10033912975) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 14.85) => -0.0088082231,
      (c_pop_0_5_p > 14.85) => 0.1470957760,
      (c_pop_0_5_p = NULL) => 0.0107527655, 0.0107527655),
   (f_add_input_nhood_BUS_pct_i > 0.10033912975) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 5.05) => 
         map(
         (NULL < f_inputaddractivephonelist_d and f_inputaddractivephonelist_d <= 0.5) => -0.0644072084,
         (f_inputaddractivephonelist_d > 0.5) => 0.1219889745,
         (f_inputaddractivephonelist_d = NULL) => 0.0147473350, 0.0147473350),
      (c_pop_75_84_p > 5.05) => 0.2116334821,
      (c_pop_75_84_p = NULL) => 0.0749069911, 0.0749069911),
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0292291825, 0.0292291825),
(c_hh2_p > 17.65) => -0.0003387795,
(c_hh2_p = NULL) => 0.0036021011, 0.0015691373);

// Tree: 210 
wFDN_FLAP_D_lgt_210 := map(
(NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 4.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 11.35) => 0.1968655517,
   (c_hh3_p > 11.35) => 0.0287923918,
   (c_hh3_p = NULL) => 0.0824543043, 0.0824543043),
(r_I60_inq_retail_recency_d > 4.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => -0.0002812407,
   (f_srchfraudsrchcount_i > 6.5) => 
      map(
      (NULL < c_young and c_young <= 30.35) => -0.0456828063,
      (c_young > 30.35) => 0.0385209832,
      (c_young = NULL) => -0.0293964767, -0.0293964767),
   (f_srchfraudsrchcount_i = NULL) => -0.0014372799, -0.0014372799),
(r_I60_inq_retail_recency_d = NULL) => 
   map(
   (NULL < k_nap_addr_verd_d and k_nap_addr_verd_d <= 0.5) => 0.0466477390,
   (k_nap_addr_verd_d > 0.5) => -0.0565549315,
   (k_nap_addr_verd_d = NULL) => -0.0106870779, -0.0106870779), -0.0004510139);

// Tree: 211 
wFDN_FLAP_D_lgt_211 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => -0.0041714145,
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 38.05) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 67.55) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.21913901465) => 0.1975431742,
         (f_add_curr_mobility_index_i > 0.21913901465) => 
            map(
            (NULL < c_low_hval and c_low_hval <= 2.8) => 0.1045138609,
            (c_low_hval > 2.8) => -0.0018740045,
            (c_low_hval = NULL) => 0.0560544667, 0.0560544667),
         (f_add_curr_mobility_index_i = NULL) => 0.0854089703, 0.0854089703),
      (c_low_ed > 67.55) => -0.0359781174,
      (c_low_ed = NULL) => 0.0625979740, 0.0625979740),
   (c_high_ed > 38.05) => -0.0284320997,
   (c_high_ed = NULL) => 0.0364649385, 0.0364649385),
(f_srchaddrsrchcount_i = NULL) => 0.0052762949, -0.0026903935);

// Tree: 212 
wFDN_FLAP_D_lgt_212 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 22.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00477897935) => -0.0401177795,
   (f_add_curr_nhood_BUS_pct_i > 0.00477897935) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => 0.0028892529,
      (f_assocsuspicousidcount_i > 14.5) => 0.0946587092,
      (f_assocsuspicousidcount_i = NULL) => 0.0033658398, 0.0033658398),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0167995813, -0.0021317289),
(f_srchaddrsrchcount_i > 22.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.23162687135) => 0.0426657543,
   (f_add_curr_nhood_MFD_pct_i > 0.23162687135) => 0.0117636957,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0271066759, 0.0271066759),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 8.05) => -0.0248114917,
   (c_hval_300k_p > 8.05) => 0.0697730248,
   (c_hval_300k_p = NULL) => 0.0124699965, 0.0124699965), -0.0015280501);

// Tree: 213 
wFDN_FLAP_D_lgt_213 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 74.5) => 
   map(
   (NULL < nf_max_altlexid_hi_no_hi_lexid and nf_max_altlexid_hi_no_hi_lexid <= 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125511) => 0.0328966459,
      (r_A46_Curr_AVM_AutoVal_d > 125511) => -0.0067931973,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0019531308, 0.0029330081),
   (nf_max_altlexid_hi_no_hi_lexid > 0.5) => -0.0349058029,
   (nf_max_altlexid_hi_no_hi_lexid = NULL) => 0.0093997005, 0.0012659100),
(k_comb_age_d > 74.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0303781824) => 0.2209444204,
   (f_add_input_nhood_MFD_pct_i > 0.0303781824) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 149) => -0.0202424362,
      (c_sub_bus > 149) => 0.0981609298,
      (c_sub_bus = NULL) => 0.0110596031, 0.0110596031),
   (f_add_input_nhood_MFD_pct_i = NULL) => -0.0234779235, 0.0459565528),
(k_comb_age_d = NULL) => 0.0027527794, 0.0027527794);

// Tree: 214 
wFDN_FLAP_D_lgt_214 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 6.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 76) => 0.1788719582,
   (c_totcrime > 76) => -0.0085542387,
   (c_totcrime = NULL) => 0.0704240959, 0.0704240959),
(r_D32_Mos_Since_Crim_LS_d > 6.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0005654194,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 107.5) => 0.0115428212,
      (f_curraddrburglaryindex_i > 107.5) => 0.0879070736,
      (f_curraddrburglaryindex_i = NULL) => 0.0399834665, 0.0399834665),
   (r_L70_Add_Standardized_i = NULL) => 0.0027961293, 0.0027961293),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 92.5) => 0.0549017155,
   (c_very_rich > 92.5) => -0.0494304541,
   (c_very_rich = NULL) => -0.0062356068, -0.0062356068), 0.0035113791);

// Tree: 215 
wFDN_FLAP_D_lgt_215 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 42.5) => 0.1449929054,
(f_mos_liens_unrel_FT_fseen_d > 42.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1327013824) => -0.0016971855,
   (f_add_curr_nhood_BUS_pct_i > 0.1327013824) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 
         map(
         (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => 0.0037427405,
         (f_crim_rel_under25miles_cnt_i > 4.5) => 0.1432711102,
         (f_crim_rel_under25miles_cnt_i = NULL) => 0.0107469535, 0.0107469535),
      (f_hh_lienholders_i > 1.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly','6: Other']) => -0.0116143887,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity']) => 0.1729496492,
         (nf_seg_FraudPoint_3_0 = '') => 0.0923354718, 0.0923354718),
      (f_hh_lienholders_i = NULL) => 0.0204705166, 0.0204705166),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0255188004, -0.0004199522),
(f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0076505890, 0.0000850038);

// Tree: 216 
wFDN_FLAP_D_lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 180.5) => -0.0852700534,
(f_mos_liens_unrel_FT_lseen_d > 180.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0026239689,
      (r_L79_adls_per_addr_c6_i > 4.5) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.080982906) => 0.0725986144,
         (f_add_input_nhood_BUS_pct_i > 0.080982906) => -0.0344077595,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0383565748, 0.0383565748),
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0042840203, 0.0042840203),
   (c_asian_lang > 181.5) => -0.0276913429,
   (c_asian_lang = NULL) => 0.0346373484, 0.0003597916),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 8.05) => 0.0446482780,
   (c_pop_18_24_p > 8.05) => -0.0502823503,
   (c_pop_18_24_p = NULL) => 0.0023143492, 0.0023143492), -0.0005919093);

// Tree: 217 
wFDN_FLAP_D_lgt_217 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 13.45) => -0.0099064234,
(C_INC_50K_P > 13.45) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 0.0033430867,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 79.75) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 57.5) => 
            map(
            (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => -0.0685596447,
            (f_util_add_input_conv_n > 0.5) => 0.0464767253,
            (f_util_add_input_conv_n = NULL) => 0.0133483376, 0.0133483376),
         (k_comb_age_d > 57.5) => 0.1335657336,
         (k_comb_age_d = NULL) => 0.0296130441, 0.0296130441),
      (C_OWNOCC_P > 79.75) => 0.2077252366,
      (C_OWNOCC_P = NULL) => 0.0516475422, 0.0516475422),
   (k_inq_per_addr_i = NULL) => 0.0089045493, 0.0089045493),
(C_INC_50K_P = NULL) => 0.0166915070, -0.0018231055);

// Tree: 218 
wFDN_FLAP_D_lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_hval_1001k_p and c_hval_1001k_p <= 14.35) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => -0.0004781373,
      (f_inq_count_i > 5.5) => 0.1468863611,
      (f_inq_count_i = NULL) => 0.0169855126, 0.0169855126),
   (c_hval_1001k_p > 14.35) => 0.2811015460,
   (c_hval_1001k_p = NULL) => 0.0724021420, 0.0431046470),
(f_rel_incomeover25_count_d > 1.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0087343628,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -12573) => 0.0946062531,
      (f_addrchangeincomediff_d > -12573) => 0.0095866942,
      (f_addrchangeincomediff_d = NULL) => 0.0326768884, 0.0169317787),
   (f_inq_Other_count_i = NULL) => -0.0027337295, -0.0027337295),
(f_rel_incomeover25_count_d = NULL) => -0.0155668097, -0.0002281572);

// Tree: 219 
wFDN_FLAP_D_lgt_219 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 145) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 13.25) => 0.1429760217,
      (c_lowinc > 13.25) => -0.0322836656,
      (c_lowinc = NULL) => 0.0198409828, 0.0198409828),
   (f_fp_prevaddrburglaryindex_i > 145) => 0.1454734631,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0399100691, 0.0399100691),
(r_F00_dob_score_d > 92) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 10.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 15.45) => 0.0016471785,
      (c_femdiv_p > 15.45) => 0.1118348066,
      (c_femdiv_p = NULL) => -0.0232268127, 0.0018704490),
   (f_srchfraudsrchcountyr_i > 10.5) => -0.0774261602,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0014991470, 0.0014991470),
(r_F00_dob_score_d = NULL) => -0.0151709252, 0.0016242675);

// Tree: 220 
wFDN_FLAP_D_lgt_220 := map(
(NULL < c_food and c_food <= 61.05) => -0.0047182835,
(c_food > 61.05) => 
   map(
   (NULL < c_totsales and c_totsales <= 366.5) => -0.0842841297,
   (c_totsales > 366.5) => 
      map(
      (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 1.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 23.75) => 0.1887182159,
         (C_RENTOCC_P > 23.75) => 
            map(
            (NULL < c_rnt1000_p and c_rnt1000_p <= 23.95) => -0.0279477630,
            (c_rnt1000_p > 23.95) => 0.1249411675,
            (c_rnt1000_p = NULL) => 0.0321473079, 0.0321473079),
         (C_RENTOCC_P = NULL) => 0.1001993692, 0.1001993692),
      (r_A50_pb_total_orders_d > 1.5) => -0.0012639596,
      (r_A50_pb_total_orders_d = NULL) => 0.0612064199, 0.0612064199),
   (c_totsales = NULL) => 0.0441348493, 0.0441348493),
(c_food = NULL) => -0.0144522806, -0.0027356149);

// Tree: 221 
wFDN_FLAP_D_lgt_221 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 11.25) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 42.05) => 
      map(
      (NULL < C_INC_201K_P and C_INC_201K_P <= 18.4) => 0.0172743672,
      (C_INC_201K_P > 18.4) => 0.1682356825,
      (C_INC_201K_P = NULL) => 0.0194027499, 0.0194027499),
   (c_high_ed > 42.05) => -0.0169165379,
   (c_high_ed = NULL) => 0.0063390252, 0.0063390252),
(C_INC_25K_P > 11.25) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => -0.0094764214,
   (f_inq_count_i > 5.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.40412079635) => -0.0717864322,
      (f_add_curr_mobility_index_i > 0.40412079635) => 0.0327941791,
      (f_add_curr_mobility_index_i = NULL) => -0.0548457284, -0.0548457284),
   (f_inq_count_i = NULL) => -0.0161298217, -0.0161298217),
(C_INC_25K_P = NULL) => -0.0140336040, 0.0002033657);

// Tree: 222 
wFDN_FLAP_D_lgt_222 := map(
(NULL < c_hh6_p and c_hh6_p <= 18.05) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0026233286,
   (f_addrchangecrimediff_i > 61.5) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 12.5) => 
         map(
         (NULL < c_health and c_health <= 11.25) => -0.0714388810,
         (c_health > 11.25) => 0.1080786536,
         (c_health = NULL) => 0.0063049332, 0.0063049332),
      (f_rel_ageover20_count_d > 12.5) => 0.1446726066,
      (f_rel_ageover20_count_d = NULL) => 0.0459496037, 0.0459496037),
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 130.5) => -0.0240501010,
      (c_span_lang > 130.5) => 0.0278438508,
      (c_span_lang = NULL) => -0.0031814323, -0.0031814323), -0.0020356311),
(c_hh6_p > 18.05) => -0.1021166770,
(c_hh6_p = NULL) => 0.0116231634, -0.0023043296);

// Tree: 223 
wFDN_FLAP_D_lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 44948.5) => -0.0471249629,
(r_A46_Curr_AVM_AutoVal_d > 44948.5) => 0.0021725730,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => -0.0148095001,
   (f_rel_under25miles_cnt_d > 5.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 116.5) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 12.35) => -0.0165167296,
         (c_hh5_p > 12.35) => 0.0884426922,
         (c_hh5_p = NULL) => -0.0013795476, -0.0023722104),
      (f_prevaddrcartheftindex_i > 116.5) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 37) => 0.2021203613,
         (r_A50_pb_total_dollars_d > 37) => 0.0403354726,
         (r_A50_pb_total_dollars_d = NULL) => 0.0577828625, 0.0577828625),
      (f_prevaddrcartheftindex_i = NULL) => 0.0207709011, 0.0207709011),
   (f_rel_under25miles_cnt_d = NULL) => 0.0050442610, -0.0001374251), -0.0001504559);

// Tree: 224 
wFDN_FLAP_D_lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 7.9) => -0.0217482557,
         (c_famotf18_p > 7.9) => 0.1094810490,
         (c_famotf18_p = NULL) => 0.0526803052, 0.0526803052),
      (f_idverrisktype_i > 2.5) => -0.0703021159,
      (f_idverrisktype_i = NULL) => 0.0120961062, 0.0120961062),
   (c_hval_20k_p > 0.65) => 0.1669298480,
   (c_hval_20k_p = NULL) => 0.0440459260, 0.0440459260),
(r_C10_M_Hdr_FS_d > 10.5) => 0.0019634772,
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 67.5) => -0.0559061984,
   (c_serv_empl > 67.5) => 0.0507158278,
   (c_serv_empl = NULL) => 0.0056642675, 0.0056642675), 0.0028686964);

// Tree: 225 
wFDN_FLAP_D_lgt_225 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < c_rape and c_rape <= 98.5) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 1503) => -0.0000217464,
      (r_P88_Phn_Dst_to_Inp_Add_i > 1503) => 0.0633305365,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 111.5) => 0.0144626732,
         (f_prevaddrageoldest_d > 111.5) => 0.0783397880,
         (f_prevaddrageoldest_d = NULL) => 0.0302024140, 0.0302024140), 0.0084866394),
   (c_rape > 98.5) => -0.0149130825,
   (c_rape = NULL) => -0.0090568781, -0.0007420292),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 240.5) => 0.2672826743,
   (f_M_Bureau_ADL_FS_noTU_d > 240.5) => 0.0134479125,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0906374307, 0.0906374307),
(f_adls_per_phone_c6_i = NULL) => 0.0004898106, 0.0004898106);

// Tree: 226 
wFDN_FLAP_D_lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => -0.0834575354,
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 755.5) => -0.0047286944,
         (c_hh00 > 755.5) => 
            map(
            (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 1.5) => 0.0140972203,
            (k_inq_adls_per_addr_i > 1.5) => 0.0746768170,
            (k_inq_adls_per_addr_i = NULL) => 0.0231296968, 0.0231296968),
         (c_hh00 = NULL) => 0.0050678119, 0.0050678119),
      (k_inq_adls_per_phone_i > 2.5) => -0.0795256302,
      (k_inq_adls_per_phone_i = NULL) => 0.0044388947, 0.0044388947),
   (c_asian_lang > 181.5) => -0.0304094743,
   (c_asian_lang = NULL) => 0.0110818971, -0.0004272773),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0061235449, -0.0011976350);

// Tree: 227 
wFDN_FLAP_D_lgt_227 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 26965.5) => 0.0008772200,
(f_addrchangeincomediff_d > 26965.5) => -0.0595631901,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 112.65) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0092239411) => 0.1581815152,
      (f_add_curr_nhood_MFD_pct_i > 0.0092239411) => 0.0093283505,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0561424756, 0.0125491386),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 112.65) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 15.45) => 0.1825620180,
      (c_hh1_p > 15.45) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 66.5) => -0.0898489024,
         (c_old_homes > 66.5) => 0.1446236034,
         (c_old_homes = NULL) => 0.0287046118, 0.0287046118),
      (c_hh1_p = NULL) => 0.0772288707, 0.0772288707),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0066326296, 0.0047989155), 0.0008822187);

// Tree: 228 
wFDN_FLAP_D_lgt_228 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => -0.0025911254,
(f_assocsuspicousidcount_i > 9.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 282.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 15.75) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => -0.0358542660,
         (r_L79_adls_per_addr_c6_i > 1.5) => 0.1083252252,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0426825300, 0.0426825300),
      (c_highrent > 15.75) => -0.0727888517,
      (c_highrent = NULL) => 0.0011850022, 0.0011850022),
   (r_C10_M_Hdr_FS_d > 282.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 2.5) => -0.0518873854,
      (f_inq_Collection_count_i > 2.5) => -0.1585991072,
      (f_inq_Collection_count_i = NULL) => -0.1007682386, -0.1007682386),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0438370842, -0.0438370842),
(f_assocsuspicousidcount_i = NULL) => -0.0003984164, -0.0037016519);

// Tree: 229 
wFDN_FLAP_D_lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 32.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 0.0005190870,
      (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0790490669,
      (f_inq_HighRiskCredit_count24_i = NULL) => 0.0009610944, 0.0009610944),
   (f_rel_homeover150_count_d > 32.5) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 3.5) => -0.1499737834,
      (f_rel_incomeover100_count_d > 3.5) => -0.0089209419,
      (f_rel_incomeover100_count_d = NULL) => -0.0676929592, -0.0676929592),
   (f_rel_homeover150_count_d = NULL) => 
      map(
      (NULL < c_robbery and c_robbery <= 90.5) => -0.0493345106,
      (c_robbery > 90.5) => 0.0882311611,
      (c_robbery = NULL) => 0.0230684745, 0.0230684745), 0.0005319726),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0634295325,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0269801400, -0.0024725013);

// Tree: 230 
wFDN_FLAP_D_lgt_230 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 17.15) => 0.0038269569,
         (c_hh6_p > 17.15) => -0.1027529830,
         (c_hh6_p = NULL) => -0.0090340004, 0.0030139012),
      (f_inq_count24_i > 14.5) => -0.0872263862,
      (f_inq_count24_i = NULL) => 0.0023001363, 0.0023001363),
   (f_fp_prevaddrcrimeindex_i > 197.5) => -0.0974882735,
   (f_fp_prevaddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 0.95) => -0.0465317465,
      (c_hh6_p > 0.95) => 0.0402920933,
      (c_hh6_p = NULL) => -0.0011465575, -0.0011465575), 0.0016800344),
(f_bus_addr_match_count_d > 52.5) => 0.1231213413,
(f_bus_addr_match_count_d = NULL) => 0.0023023194, 0.0023023194);

// Tree: 231 
wFDN_FLAP_D_lgt_231 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0008943948,
(f_srchvelocityrisktype_i > 6.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 37.5) => -0.0633725998,
   (f_mos_inq_banko_cm_fseen_d > 37.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 15.4) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 142.5) => -0.0114871130,
         (c_exp_prod > 142.5) => 0.1357136225,
         (c_exp_prod = NULL) => 0.0246390748, 0.0246390748),
      (c_rnt500_p > 15.4) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03975503185) => 0.2060300118,
         (f_add_curr_nhood_BUS_pct_i > 0.03975503185) => 0.0461827485,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1221101986, 0.1221101986),
      (c_rnt500_p = NULL) => 0.0547440801, 0.0547440801),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0328081253, 0.0328081253),
(f_srchvelocityrisktype_i = NULL) => 0.0085853393, 0.0005449828);

// Tree: 232 
wFDN_FLAP_D_lgt_232 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1424875982,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.0683361831,
   (r_D32_Mos_Since_Fel_LS_d > 127.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 555) => -0.0035053768,
      (r_C13_max_lres_d > 555) => 0.1422066607,
      (r_C13_max_lres_d = NULL) => -0.0028927948, -0.0028927948),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0024691876, -0.0024691876),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 23.5) => -0.0863425338,
   (k_comb_age_d > 23.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.26608784095) => 0.0666050776,
      (f_add_input_mobility_index_i > 0.26608784095) => -0.0252670048,
      (f_add_input_mobility_index_i = NULL) => 0.0148844978, 0.0148844978),
   (k_comb_age_d = NULL) => -0.0135019184, -0.0135019184), -0.0020402137);

// Tree: 233 
wFDN_FLAP_D_lgt_233 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 9.5) => -0.0017736086,
(f_rel_homeover300_count_d > 9.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.06035954035) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0317052221) => 0.1369312151,
         (f_add_curr_nhood_BUS_pct_i > 0.0317052221) => -0.0786247268,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0503941581, 0.0503941581),
      (f_add_input_nhood_MFD_pct_i > 0.06035954035) => -0.0229187657,
      (f_add_input_nhood_MFD_pct_i = NULL) => -0.0617760962, -0.0180536776),
   (f_inq_Collection_count_i > 3.5) => -0.0873941070,
   (f_inq_Collection_count_i = NULL) => -0.0329750358, -0.0329750358),
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 230470) => 0.0695439689,
   (r_L80_Inp_AVM_AutoVal_d > 230470) => -0.0557624234,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0219654709, -0.0082585443), -0.0045195595);

// Tree: 234 
wFDN_FLAP_D_lgt_234 := map(
(NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 30.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0045654429,
      (f_hh_collections_ct_i > 2.5) => 0.1500914970,
      (f_hh_collections_ct_i = NULL) => 0.0143095455, 0.0143095455),
   (f_prevaddrmurderindex_i > 30.5) => -0.0302635383,
   (f_prevaddrmurderindex_i = NULL) => 0.0146630666, -0.0184202917),
(f_util_add_input_conv_n > 0.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 418.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','5: Vuln Vic/Friendly','6: Other']) => -0.0088858142,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity']) => 0.1707373123,
      (nf_seg_FraudPoint_3_0 = '') => 0.0774446807, 0.0774446807),
   (c_popover25 > 418.5) => 0.0056643092,
   (c_popover25 = NULL) => 0.0122831134, 0.0070479802),
(f_util_add_input_conv_n = NULL) => -0.0042255198, -0.0042255198);

// Tree: 235 
wFDN_FLAP_D_lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0794253224) => 0.0106267720,
   (f_add_curr_nhood_VAC_pct_i > 0.0794253224) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 57.5) => -0.0329667449,
      (c_span_lang > 57.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 7.5) => 0.2026732430,
         (r_C13_Curr_Addr_LRes_d > 7.5) => 
            map(
            (NULL < c_civ_emp and c_civ_emp <= 56.75) => 0.1543091206,
            (c_civ_emp > 56.75) => 0.0071050871,
            (c_civ_emp = NULL) => 0.0590594519, 0.0590594519),
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0920580899, 0.0920580899),
      (c_span_lang = NULL) => 0.0603488927, 0.0603488927),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0194012639, 0.0194012639),
(f_hh_members_ct_d > 1.5) => -0.0062312849,
(f_hh_members_ct_d = NULL) => 0.0035847050, -0.0013078018);

// Tree: 236 
wFDN_FLAP_D_lgt_236 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 6.65) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 5.5) => -0.0682536084,
   (f_hh_age_18_plus_d > 5.5) => 0.0895448333,
   (f_hh_age_18_plus_d = NULL) => -0.0548458976, -0.0548458976),
(c_pop_45_54_p > 6.65) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 23.95) => -0.0015820856,
   (c_hh3_p > 23.95) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 20.4) => 0.0113798770,
      (c_hval_750k_p > 20.4) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 84.55) => 0.0275253371,
         (c_fammar_p > 84.55) => 0.2253514570,
         (c_fammar_p = NULL) => 0.0927367173, 0.0927367173),
      (c_hval_750k_p = NULL) => 0.0302672206, 0.0302672206),
   (c_hh3_p = NULL) => 0.0026310723, 0.0026310723),
(c_pop_45_54_p = NULL) => 0.0095616735, -0.0000037584);

// Tree: 237 
wFDN_FLAP_D_lgt_237 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 12.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => -0.0020875502,
   (r_D33_eviction_count_i > 1.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 7.5) => 
         map(
         (NULL < c_health and c_health <= 10.95) => 0.0517777918,
         (c_health > 10.95) => -0.0953022742,
         (c_health = NULL) => -0.0023558436, -0.0023558436),
      (r_D30_Derog_Count_i > 7.5) => -0.0957117837,
      (r_D30_Derog_Count_i = NULL) => -0.0367501373, -0.0367501373),
   (r_D33_eviction_count_i = NULL) => -0.0027291373, -0.0027291373),
(f_hh_members_ct_d > 12.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 9.05) => 0.0107620339,
   (c_pop_0_5_p > 9.05) => 0.1634359494,
   (c_pop_0_5_p = NULL) => 0.0677848217, 0.0677848217),
(f_hh_members_ct_d = NULL) => -0.0027678791, -0.0017458018);

// Tree: 238 
wFDN_FLAP_D_lgt_238 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 10.5) => -0.0066585826,
(f_rel_criminal_count_i > 10.5) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 64.95) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 7.9) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 31.45) => -0.0513990964,
         (c_hh2_p > 31.45) => 0.1423813691,
         (c_hh2_p = NULL) => 0.0428244327, 0.0428244327),
      (c_hval_300k_p > 7.9) => -0.1124171289,
      (c_hval_300k_p = NULL) => -0.0066588151, -0.0066588151),
   (c_civ_emp > 64.95) => 0.1185981319,
   (c_civ_emp = NULL) => 0.0387530661, 0.0387530661),
(f_rel_criminal_count_i = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0228003880,
   (k_nap_phn_verd_d > 0.5) => -0.1030714946,
   (k_nap_phn_verd_d = NULL) => -0.0191569062, -0.0191569062), -0.0059367425);

// Tree: 239 
wFDN_FLAP_D_lgt_239 := map(
(NULL < nf_vf_hi_addr_add_entries and nf_vf_hi_addr_add_entries <= 2.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0019042434,
   (k_inq_adls_per_addr_i > 3.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 9.85) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.04698822465) => 0.0076373971,
         (f_add_input_nhood_BUS_pct_i > 0.04698822465) => -0.0462800689,
         (f_add_input_nhood_BUS_pct_i = NULL) => -0.0221101703, -0.0221101703),
      (C_INC_35K_P > 9.85) => -0.1152904309,
      (C_INC_35K_P = NULL) => -0.0629864167, -0.0629864167),
   (k_inq_adls_per_addr_i = NULL) => -0.0029600089, -0.0029600089),
(nf_vf_hi_addr_add_entries > 2.5) => 0.0683131852,
(nf_vf_hi_addr_add_entries = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 87.25) => 0.0026874093,
   (c_sfdu_p > 87.25) => 0.1108538820,
   (c_sfdu_p = NULL) => 0.0382684858, 0.0382684858), -0.0020088800);

// Tree: 240 
wFDN_FLAP_D_lgt_240 := map(
(NULL < c_hval_100k_p and c_hval_100k_p <= 6.95) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 49.45) => 
      map(
      (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.0552563914,
      (f_adl_per_email_i > 0.5) => -0.0983517230,
      (f_adl_per_email_i = NULL) => 0.0098525797, 0.0098047353),
   (c_famotf18_p > 49.45) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 151) => 0.1379519616,
      (f_fp_prevaddrburglaryindex_i > 151) => -0.0001316723,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0761777044, 0.0761777044),
   (c_famotf18_p = NULL) => 0.0106970596, 0.0106970596),
(c_hval_100k_p > 6.95) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => -0.0166955056,
   (r_D30_Derog_Count_i > 11.5) => 0.0673702763,
   (r_D30_Derog_Count_i = NULL) => -0.0149124509, -0.0149124509),
(c_hval_100k_p = NULL) => -0.0301556206, 0.0032050043);

// Tree: 241 
wFDN_FLAP_D_lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0011203795,
(k_comb_age_d > 67.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 142) => 
      map(
      (NULL < c_young and c_young <= 26.15) => 0.0500763607,
      (c_young > 26.15) => -0.0651162172,
      (c_young = NULL) => 0.0295585988, 0.0295585988),
   (f_curraddrcrimeindex_i > 142) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 149.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 330.5) => 0.0621247086,
         (r_C21_M_Bureau_ADL_FS_d > 330.5) => 0.2917114869,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.1679342673, 0.1679342673),
      (c_for_sale > 149.5) => -0.0421501002,
      (c_for_sale = NULL) => 0.0999657955, 0.0999657955),
   (f_curraddrcrimeindex_i = NULL) => 0.0418439361, 0.0418439361),
(k_comb_age_d = NULL) => 0.0022194830, 0.0022194830);

// Tree: 242 
wFDN_FLAP_D_lgt_242 := map(
(NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 4.05) => -0.0168818195,
   (c_incollege > 4.05) => 0.0098138451,
   (c_incollege = NULL) => -0.0158421428, 0.0018228341),
(f_inq_Other_count24_i > 3.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.04230879865) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 212) => 0.1433553051,
      (r_A50_pb_total_dollars_d > 212) => -0.0400234832,
      (r_A50_pb_total_dollars_d = NULL) => 0.0287435624, 0.0287435624),
   (f_add_curr_nhood_VAC_pct_i > 0.04230879865) => 0.1854134108,
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0675232278, 0.0675232278),
(f_inq_Other_count24_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => -0.0311455066,
   (c_hval_250k_p > 8.05) => 0.0634682638,
   (c_hval_250k_p = NULL) => 0.0097520587, 0.0097520587), 0.0029853344);

// Tree: 243 
wFDN_FLAP_D_lgt_243 := map(
(NULL < c_cartheft and c_cartheft <= 4.5) => -0.0624471775,
(c_cartheft > 4.5) => 
   map(
   (NULL < c_info and c_info <= 27.85) => 
      map(
      (NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
         map(
         (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
            map(
            (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 415.5) => 0.0072546360,
            (r_C21_M_Bureau_ADL_FS_d > 415.5) => 0.0778488249,
            (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0086096232, 0.0086096232),
         (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0484750633,
         (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0080619569, 0.0061854422),
      (r_L77_Add_PO_Box_i > 0.5) => -0.0984640004,
      (r_L77_Add_PO_Box_i = NULL) => 0.0043182823, 0.0043182823),
   (c_info > 27.85) => 0.1738771685,
   (c_info = NULL) => 0.0051174152, 0.0051174152),
(c_cartheft = NULL) => 0.0195780769, 0.0027737955);

// Tree: 244 
wFDN_FLAP_D_lgt_244 := map(
(NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => -0.0107332558,
      (f_curraddrcrimeindex_i > 121) => 0.0139660413,
      (f_curraddrcrimeindex_i = NULL) => -0.0042698137, -0.0042698137),
   (f_assocsuspicousidcount_i > 16.5) => 0.0955744127,
   (f_assocsuspicousidcount_i = NULL) => -0.0038437130, -0.0038437130),
(f_hh_workers_paw_d > 4.5) => -0.0907002993,
(f_hh_workers_paw_d = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 1.8) => -0.0057724570,
      (c_high_hval > 1.8) => 0.0779040067,
      (c_high_hval = NULL) => 0.0352454173, 0.0352454173),
   (k_nap_phn_verd_d > 0.5) => -0.0993227139,
   (k_nap_phn_verd_d = NULL) => -0.0096106264, -0.0096106264), -0.0045144037);

// Tree: 245 
wFDN_FLAP_D_lgt_245 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 16) => -0.0295120464,
(f_curraddrburglaryindex_i > 16) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 18.65) => 0.0031808809,
   (c_hh5_p > 18.65) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.80155440415) => 
            map(
            (NULL < c_sub_bus and c_sub_bus <= 133) => 0.2028194735,
            (c_sub_bus > 133) => 0.0001971086,
            (c_sub_bus = NULL) => 0.0911378550, 0.0911378550),
         (f_add_curr_nhood_SFD_pct_d > 0.80155440415) => -0.0487297503,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0156296188, 0.0156296188),
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.1480949617,
      (nf_seg_FraudPoint_3_0 = '') => 0.0451078219, 0.0451078219),
   (c_hh5_p = NULL) => 0.0045825255, 0.0045825255),
(f_curraddrburglaryindex_i = NULL) => -0.0197925079, -0.0007342286);

// Tree: 246 
wFDN_FLAP_D_lgt_246 := map(
(NULL < c_hhsize and c_hhsize <= 4.255) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 14.5) => 0.0020527960,
   (f_rel_homeover200_count_d > 14.5) => -0.0326917953,
   (f_rel_homeover200_count_d = NULL) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 40.55) => 
         map(
         (NULL < c_families and c_families <= 736) => -0.0284907016,
         (c_families > 736) => 0.1083337725,
         (c_families = NULL) => -0.0056160217, -0.0056160217),
      (c_lowrent > 40.55) => 0.1151155487,
      (c_lowrent = NULL) => 0.0143499228, 0.0143499228), 0.0004095599),
(c_hhsize > 4.255) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0057693161) => 0.1771510577,
   (f_add_input_nhood_VAC_pct_i > 0.0057693161) => 0.0055865004,
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0731316017, 0.0731316017),
(c_hhsize = NULL) => -0.0270113100, 0.0004567121);

// Tree: 247 
wFDN_FLAP_D_lgt_247 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 208.9) => 
         map(
         (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 0.0602855473,
         (f_historical_count_d > 0.5) => 0.0037985783,
         (f_historical_count_d = NULL) => 0.0191090194, 0.0191090194),
      (c_cpiall > 208.9) => -0.0083516169,
      (c_cpiall = NULL) => 0.0013257972, -0.0041913965),
   (r_D33_eviction_count_i > 3.5) => 0.0804909179,
   (r_D33_eviction_count_i = NULL) => -0.0037084692, -0.0037084692),
(f_inq_HighRiskCredit_count_i > 21.5) => -0.0828936768,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_incollege and c_incollege <= 4.55) => 0.0565039254,
   (c_incollege > 4.55) => -0.0272358221,
   (c_incollege = NULL) => -0.0005671127, -0.0005671127), -0.0039747766);

// Tree: 248 
wFDN_FLAP_D_lgt_248 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 40.45) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 13.5) => -0.0008408740,
   (f_rel_homeover300_count_d > 13.5) => -0.0398596640,
   (f_rel_homeover300_count_d = NULL) => 0.0058797500, -0.0023736787),
(c_famotf18_p > 40.45) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 36.5) => -0.1276532840,
      (f_mos_inq_banko_cm_lseen_d > 36.5) => -0.0569073426,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0778095526, -0.0778095526),
   (f_sourcerisktype_i > 5.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 183.5) => -0.0424867698,
      (f_prevaddrcartheftindex_i > 183.5) => 0.0773711206,
      (f_prevaddrcartheftindex_i = NULL) => -0.0005784165, -0.0005784165),
   (f_sourcerisktype_i = NULL) => -0.0473851656, -0.0473851656),
(c_famotf18_p = NULL) => 0.0278795784, -0.0030021032);

// Tree: 249 
wFDN_FLAP_D_lgt_249 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30896.5) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 13.85) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 47134.5) => 
         map(
         (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 7.5) => 0.0311852576,
         (f_rel_ageover20_count_d > 7.5) => 
            map(
            (NULL < c_hval_80k_p and c_hval_80k_p <= 18.5) => 0.1720370691,
            (c_hval_80k_p > 18.5) => 0.0049252279,
            (c_hval_80k_p = NULL) => 0.1192649087, 0.1192649087),
         (f_rel_ageover20_count_d = NULL) => 0.0671318456, 0.0671318456),
      (f_prevaddrmedianincome_d > 47134.5) => -0.0492038311,
      (f_prevaddrmedianincome_d = NULL) => 0.0509303587, 0.0509303587),
   (c_pop_25_34_p > 13.85) => -0.0088413401,
   (c_pop_25_34_p = NULL) => 0.0127186035, 0.0210191762),
(f_curraddrmedianincome_d > 30896.5) => -0.0024569682,
(f_curraddrmedianincome_d = NULL) => -0.0155115653, -0.0004477051);

// Tree: 250 
wFDN_FLAP_D_lgt_250 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 20.05) => -0.0022219062,
(C_INC_50K_P > 20.05) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 2.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 18.5) => 0.1200593961,
      (c_many_cars > 18.5) => 0.0034157076,
      (c_many_cars = NULL) => 0.0131360150, 0.0131360150),
   (f_crim_rel_under25miles_cnt_i > 2.5) => 
      map(
      (NULL < c_rental and c_rental <= 146.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03963624435) => 0.0131766441,
         (f_add_curr_nhood_BUS_pct_i > 0.03963624435) => -0.0107980764,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0005107540, 0.0005107540),
      (c_rental > 146.5) => 0.1605763433,
      (c_rental = NULL) => 0.0607601612, 0.0607601612),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0205074046, 0.0205074046),
(C_INC_50K_P = NULL) => 0.0031613266, 0.0000385759);

// Tree: 251 
wFDN_FLAP_D_lgt_251 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1334) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 1.85) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 39.25) => -0.0133773222,
      (c_famotf18_p > 39.25) => -0.0730674152,
      (c_famotf18_p = NULL) => -0.0285259443, -0.0285259443),
   (C_INC_125K_P > 1.85) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 4.5) => 0.0094371860,
      (k_inq_ssns_per_addr_i > 4.5) => -0.0661413977,
      (k_inq_ssns_per_addr_i = NULL) => 0.0088284125, 0.0088284125),
   (C_INC_125K_P = NULL) => -0.0247366533, 0.0065522726),
(f_liens_rel_SC_total_amt_i > 1334) => -0.1203094497,
(f_liens_rel_SC_total_amt_i = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 114.5) => 0.0613834143,
   (c_employees > 114.5) => -0.0405720917,
   (c_employees = NULL) => -0.0072532989, -0.0072532989), 0.0058474129);

// Tree: 252 
wFDN_FLAP_D_lgt_252 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => -0.0019937551,
   (f_divaddrsuspidcountnew_i > 0.5) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 3.5) => -0.0038547619,
      (r_P88_Phn_Dst_to_Inp_Add_i > 3.5) => 0.0535355012,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0262615493, 0.0180498878),
   (f_divaddrsuspidcountnew_i = NULL) => -0.0156742138, 0.0016583053),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 4.15) => 0.1259734904,
   (c_newhouse > 4.15) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 2.65) => 0.0983328335,
      (c_hval_300k_p > 2.65) => -0.0388226090,
      (c_hval_300k_p = NULL) => 0.0164648562, 0.0164648562),
   (c_newhouse = NULL) => 0.0487788794, 0.0487788794),
(k_nap_contradictory_i = NULL) => 0.0023975244, 0.0023975244);

// Tree: 253 
wFDN_FLAP_D_lgt_253 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 5.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 31.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01708840145) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 73.05) => 0.0090422879,
         (c_low_ed > 73.05) => 0.0905660443,
         (c_low_ed = NULL) => 0.0306099466, 0.0121302511),
      (f_add_curr_nhood_VAC_pct_i > 0.01708840145) => -0.0118842530,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0001879463, 0.0001879463),
   (f_rel_under25miles_cnt_d > 31.5) => -0.0838087183,
   (f_rel_under25miles_cnt_d = NULL) => 0.0084398210, -0.0003066274),
(r_D34_unrel_liens_ct_i > 5.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 33.85) => -0.1177345555,
   (c_hh2_p > 33.85) => -0.0049502042,
   (c_hh2_p = NULL) => -0.0655055606, -0.0655055606),
(r_D34_unrel_liens_ct_i = NULL) => -0.0236921627, -0.0014186624);

// Tree: 254 
wFDN_FLAP_D_lgt_254 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 23.65) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 19.85) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 64.5) => -0.1036637206,
      (c_rest_indx > 64.5) => -0.0368664663,
      (c_rest_indx = NULL) => -0.0465293701, -0.0465293701),
   (C_INC_25K_P > 19.85) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 145) => 0.1626730704,
      (f_prevaddrmurderindex_i > 145) => -0.0129072002,
      (f_prevaddrmurderindex_i = NULL) => 0.0466286387, 0.0466286387),
   (C_INC_25K_P = NULL) => -0.0327367451, -0.0327367451),
(C_OWNOCC_P > 23.65) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0023478515,
   (r_L70_Add_Standardized_i > 0.5) => 0.0405502025,
   (r_L70_Add_Standardized_i = NULL) => 0.0006968238, 0.0006968238),
(C_OWNOCC_P = NULL) => 0.0388641867, -0.0015780263);

// Tree: 255 
wFDN_FLAP_D_lgt_255 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 189.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 43.6) => -0.0279374336,
      (c_hval_250k_p > 43.6) => 0.1713957528,
      (c_hval_250k_p = NULL) => -0.0242406015, -0.0242406015),
   (c_apt20 > 189.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 128.5) => -0.0071580446,
      (r_C13_max_lres_d > 128.5) => 
         map(
         (NULL < c_health and c_health <= 7.15) => 0.0046405548,
         (c_health > 7.15) => 0.2249584794,
         (c_health = NULL) => 0.1137088343, 0.1137088343),
      (r_C13_max_lres_d = NULL) => 0.0385631343, 0.0385631343),
   (c_apt20 = NULL) => -0.0252581966, -0.0188763476),
(r_L79_adls_per_addr_curr_i > 1.5) => 0.0074819937,
(r_L79_adls_per_addr_curr_i = NULL) => 0.0029717888, 0.0009711267);

// Tree: 256 
wFDN_FLAP_D_lgt_256 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 72.5) => -0.0228090765,
(r_C13_max_lres_d > 72.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 55.85) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0013431425,
      (f_util_adl_count_n > 4.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 4.15) => -0.0233592431,
         (c_incollege > 4.15) => 0.0762680018,
         (c_incollege = NULL) => 0.0436332380, 0.0436332380),
      (f_util_adl_count_n = NULL) => 0.0036244735, 0.0036244735),
   (c_rnt1000_p > 55.85) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0375418671,
      (f_hh_collections_ct_i > 2.5) => 0.1631097556,
      (f_hh_collections_ct_i = NULL) => 0.0552274852, 0.0552274852),
   (c_rnt1000_p = NULL) => -0.0453703126, 0.0056426317),
(r_C13_max_lres_d = NULL) => 0.0150375729, -0.0006320318);

// Tree: 257 
wFDN_FLAP_D_lgt_257 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 33.5) => 0.0760290649,
(f_mos_liens_unrel_SC_fseen_d > 33.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 184.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 191.5) => -0.0010112067,
      (c_unempl > 191.5) => 0.0653759234,
      (c_unempl = NULL) => -0.0004830673, -0.0004830673),
   (c_span_lang > 184.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.48283511925) => -0.0286719224,
      (f_add_curr_mobility_index_i > 0.48283511925) => -0.1178675294,
      (f_add_curr_mobility_index_i = NULL) => -0.0339064064, -0.0339064064),
   (c_span_lang = NULL) => 0.0210710801, -0.0023346542),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0692257585,
   (k_nap_lname_verd_d > 0.5) => -0.0259601304,
   (k_nap_lname_verd_d = NULL) => 0.0192921774, 0.0192921774), -0.0015407968);

// Tree: 258 
wFDN_FLAP_D_lgt_258 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.19628412385) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => -0.0338624206,
   (f_inq_count_i > 14.5) => 0.0913674265,
   (f_inq_count_i = NULL) => -0.0313740935, -0.0313740935),
(f_add_input_mobility_index_i > 0.19628412385) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 26.35) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 3.55) => -0.0900661152,
      (c_pop_35_44_p > 3.55) => 0.0025869134,
      (c_pop_35_44_p = NULL) => 0.0013451718, 0.0013451718),
   (C_INC_25K_P > 26.35) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.85) => 0.1323535934,
      (c_pop_6_11_p > 8.85) => -0.0180530510,
      (c_pop_6_11_p = NULL) => 0.0639869368, 0.0639869368),
   (C_INC_25K_P = NULL) => -0.0301850649, 0.0016132272),
(f_add_input_mobility_index_i = NULL) => 0.1113712787, -0.0045469734);

// Final Score Sum 

   wFDN_FLAP_D_lgt := sum(
      wFDN_FLAP_D_lgt_0, wFDN_FLAP_D_lgt_1, wFDN_FLAP_D_lgt_2, wFDN_FLAP_D_lgt_3, wFDN_FLAP_D_lgt_4, 
      wFDN_FLAP_D_lgt_5, wFDN_FLAP_D_lgt_6, wFDN_FLAP_D_lgt_7, wFDN_FLAP_D_lgt_8, wFDN_FLAP_D_lgt_9, 
      wFDN_FLAP_D_lgt_10, wFDN_FLAP_D_lgt_11, wFDN_FLAP_D_lgt_12, wFDN_FLAP_D_lgt_13, wFDN_FLAP_D_lgt_14, 
      wFDN_FLAP_D_lgt_15, wFDN_FLAP_D_lgt_16, wFDN_FLAP_D_lgt_17, wFDN_FLAP_D_lgt_18, wFDN_FLAP_D_lgt_19, 
      wFDN_FLAP_D_lgt_20, wFDN_FLAP_D_lgt_21, wFDN_FLAP_D_lgt_22, wFDN_FLAP_D_lgt_23, wFDN_FLAP_D_lgt_24, 
      wFDN_FLAP_D_lgt_25, wFDN_FLAP_D_lgt_26, wFDN_FLAP_D_lgt_27, wFDN_FLAP_D_lgt_28, wFDN_FLAP_D_lgt_29, 
      wFDN_FLAP_D_lgt_30, wFDN_FLAP_D_lgt_31, wFDN_FLAP_D_lgt_32, wFDN_FLAP_D_lgt_33, wFDN_FLAP_D_lgt_34, 
      wFDN_FLAP_D_lgt_35, wFDN_FLAP_D_lgt_36, wFDN_FLAP_D_lgt_37, wFDN_FLAP_D_lgt_38, wFDN_FLAP_D_lgt_39, 
      wFDN_FLAP_D_lgt_40, wFDN_FLAP_D_lgt_41, wFDN_FLAP_D_lgt_42, wFDN_FLAP_D_lgt_43, wFDN_FLAP_D_lgt_44, 
      wFDN_FLAP_D_lgt_45, wFDN_FLAP_D_lgt_46, wFDN_FLAP_D_lgt_47, wFDN_FLAP_D_lgt_48, wFDN_FLAP_D_lgt_49, 
      wFDN_FLAP_D_lgt_50, wFDN_FLAP_D_lgt_51, wFDN_FLAP_D_lgt_52, wFDN_FLAP_D_lgt_53, wFDN_FLAP_D_lgt_54, 
      wFDN_FLAP_D_lgt_55, wFDN_FLAP_D_lgt_56, wFDN_FLAP_D_lgt_57, wFDN_FLAP_D_lgt_58, wFDN_FLAP_D_lgt_59, 
      wFDN_FLAP_D_lgt_60, wFDN_FLAP_D_lgt_61, wFDN_FLAP_D_lgt_62, wFDN_FLAP_D_lgt_63, wFDN_FLAP_D_lgt_64, 
      wFDN_FLAP_D_lgt_65, wFDN_FLAP_D_lgt_66, wFDN_FLAP_D_lgt_67, wFDN_FLAP_D_lgt_68, wFDN_FLAP_D_lgt_69, 
      wFDN_FLAP_D_lgt_70, wFDN_FLAP_D_lgt_71, wFDN_FLAP_D_lgt_72, wFDN_FLAP_D_lgt_73, wFDN_FLAP_D_lgt_74, 
      wFDN_FLAP_D_lgt_75, wFDN_FLAP_D_lgt_76, wFDN_FLAP_D_lgt_77, wFDN_FLAP_D_lgt_78, wFDN_FLAP_D_lgt_79, 
      wFDN_FLAP_D_lgt_80, wFDN_FLAP_D_lgt_81, wFDN_FLAP_D_lgt_82, wFDN_FLAP_D_lgt_83, wFDN_FLAP_D_lgt_84, 
      wFDN_FLAP_D_lgt_85, wFDN_FLAP_D_lgt_86, wFDN_FLAP_D_lgt_87, wFDN_FLAP_D_lgt_88, wFDN_FLAP_D_lgt_89, 
      wFDN_FLAP_D_lgt_90, wFDN_FLAP_D_lgt_91, wFDN_FLAP_D_lgt_92, wFDN_FLAP_D_lgt_93, wFDN_FLAP_D_lgt_94, 
      wFDN_FLAP_D_lgt_95, wFDN_FLAP_D_lgt_96, wFDN_FLAP_D_lgt_97, wFDN_FLAP_D_lgt_98, wFDN_FLAP_D_lgt_99, 
      wFDN_FLAP_D_lgt_100, wFDN_FLAP_D_lgt_101, wFDN_FLAP_D_lgt_102, wFDN_FLAP_D_lgt_103, wFDN_FLAP_D_lgt_104, 
      wFDN_FLAP_D_lgt_105, wFDN_FLAP_D_lgt_106, wFDN_FLAP_D_lgt_107, wFDN_FLAP_D_lgt_108, wFDN_FLAP_D_lgt_109, 
      wFDN_FLAP_D_lgt_110, wFDN_FLAP_D_lgt_111, wFDN_FLAP_D_lgt_112, wFDN_FLAP_D_lgt_113, wFDN_FLAP_D_lgt_114, 
      wFDN_FLAP_D_lgt_115, wFDN_FLAP_D_lgt_116, wFDN_FLAP_D_lgt_117, wFDN_FLAP_D_lgt_118, wFDN_FLAP_D_lgt_119, 
      wFDN_FLAP_D_lgt_120, wFDN_FLAP_D_lgt_121, wFDN_FLAP_D_lgt_122, wFDN_FLAP_D_lgt_123, wFDN_FLAP_D_lgt_124, 
      wFDN_FLAP_D_lgt_125, wFDN_FLAP_D_lgt_126, wFDN_FLAP_D_lgt_127, wFDN_FLAP_D_lgt_128, wFDN_FLAP_D_lgt_129, 
      wFDN_FLAP_D_lgt_130, wFDN_FLAP_D_lgt_131, wFDN_FLAP_D_lgt_132, wFDN_FLAP_D_lgt_133, wFDN_FLAP_D_lgt_134, 
      wFDN_FLAP_D_lgt_135, wFDN_FLAP_D_lgt_136, wFDN_FLAP_D_lgt_137, wFDN_FLAP_D_lgt_138, wFDN_FLAP_D_lgt_139, 
      wFDN_FLAP_D_lgt_140, wFDN_FLAP_D_lgt_141, wFDN_FLAP_D_lgt_142, wFDN_FLAP_D_lgt_143, wFDN_FLAP_D_lgt_144, 
      wFDN_FLAP_D_lgt_145, wFDN_FLAP_D_lgt_146, wFDN_FLAP_D_lgt_147, wFDN_FLAP_D_lgt_148, wFDN_FLAP_D_lgt_149, 
      wFDN_FLAP_D_lgt_150, wFDN_FLAP_D_lgt_151, wFDN_FLAP_D_lgt_152, wFDN_FLAP_D_lgt_153, wFDN_FLAP_D_lgt_154, 
      wFDN_FLAP_D_lgt_155, wFDN_FLAP_D_lgt_156, wFDN_FLAP_D_lgt_157, wFDN_FLAP_D_lgt_158, wFDN_FLAP_D_lgt_159, 
      wFDN_FLAP_D_lgt_160, wFDN_FLAP_D_lgt_161, wFDN_FLAP_D_lgt_162, wFDN_FLAP_D_lgt_163, wFDN_FLAP_D_lgt_164, 
      wFDN_FLAP_D_lgt_165, wFDN_FLAP_D_lgt_166, wFDN_FLAP_D_lgt_167, wFDN_FLAP_D_lgt_168, wFDN_FLAP_D_lgt_169, 
      wFDN_FLAP_D_lgt_170, wFDN_FLAP_D_lgt_171, wFDN_FLAP_D_lgt_172, wFDN_FLAP_D_lgt_173, wFDN_FLAP_D_lgt_174, 
      wFDN_FLAP_D_lgt_175, wFDN_FLAP_D_lgt_176, wFDN_FLAP_D_lgt_177, wFDN_FLAP_D_lgt_178, wFDN_FLAP_D_lgt_179, 
      wFDN_FLAP_D_lgt_180, wFDN_FLAP_D_lgt_181, wFDN_FLAP_D_lgt_182, wFDN_FLAP_D_lgt_183, wFDN_FLAP_D_lgt_184, 
      wFDN_FLAP_D_lgt_185, wFDN_FLAP_D_lgt_186, wFDN_FLAP_D_lgt_187, wFDN_FLAP_D_lgt_188, wFDN_FLAP_D_lgt_189, 
      wFDN_FLAP_D_lgt_190, wFDN_FLAP_D_lgt_191, wFDN_FLAP_D_lgt_192, wFDN_FLAP_D_lgt_193, wFDN_FLAP_D_lgt_194, 
      wFDN_FLAP_D_lgt_195, wFDN_FLAP_D_lgt_196, wFDN_FLAP_D_lgt_197, wFDN_FLAP_D_lgt_198, wFDN_FLAP_D_lgt_199, 
      wFDN_FLAP_D_lgt_200, wFDN_FLAP_D_lgt_201, wFDN_FLAP_D_lgt_202, wFDN_FLAP_D_lgt_203, wFDN_FLAP_D_lgt_204, 
      wFDN_FLAP_D_lgt_205, wFDN_FLAP_D_lgt_206, wFDN_FLAP_D_lgt_207, wFDN_FLAP_D_lgt_208, wFDN_FLAP_D_lgt_209, 
      wFDN_FLAP_D_lgt_210, wFDN_FLAP_D_lgt_211, wFDN_FLAP_D_lgt_212, wFDN_FLAP_D_lgt_213, wFDN_FLAP_D_lgt_214, 
      wFDN_FLAP_D_lgt_215, wFDN_FLAP_D_lgt_216, wFDN_FLAP_D_lgt_217, wFDN_FLAP_D_lgt_218, wFDN_FLAP_D_lgt_219, 
      wFDN_FLAP_D_lgt_220, wFDN_FLAP_D_lgt_221, wFDN_FLAP_D_lgt_222, wFDN_FLAP_D_lgt_223, wFDN_FLAP_D_lgt_224, 
      wFDN_FLAP_D_lgt_225, wFDN_FLAP_D_lgt_226, wFDN_FLAP_D_lgt_227, wFDN_FLAP_D_lgt_228, wFDN_FLAP_D_lgt_229, 
      wFDN_FLAP_D_lgt_230, wFDN_FLAP_D_lgt_231, wFDN_FLAP_D_lgt_232, wFDN_FLAP_D_lgt_233, wFDN_FLAP_D_lgt_234, 
      wFDN_FLAP_D_lgt_235, wFDN_FLAP_D_lgt_236, wFDN_FLAP_D_lgt_237, wFDN_FLAP_D_lgt_238, wFDN_FLAP_D_lgt_239, 
      wFDN_FLAP_D_lgt_240, wFDN_FLAP_D_lgt_241, wFDN_FLAP_D_lgt_242, wFDN_FLAP_D_lgt_243, wFDN_FLAP_D_lgt_244, 
      wFDN_FLAP_D_lgt_245, wFDN_FLAP_D_lgt_246, wFDN_FLAP_D_lgt_247, wFDN_FLAP_D_lgt_248, wFDN_FLAP_D_lgt_249, 
      wFDN_FLAP_D_lgt_250, wFDN_FLAP_D_lgt_251, wFDN_FLAP_D_lgt_252, wFDN_FLAP_D_lgt_253, wFDN_FLAP_D_lgt_254, 
      wFDN_FLAP_D_lgt_255, wFDN_FLAP_D_lgt_256, wFDN_FLAP_D_lgt_257, wFDN_FLAP_D_lgt_258); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FLAP_D_lgt;
			
self.final_score_0	:= 	wFDN_FLAP_D_lgt_0	;
self.final_score_1	:= 	wFDN_FLAP_D_lgt_1	;
self.final_score_2	:= 	wFDN_FLAP_D_lgt_2	;
self.final_score_3	:= 	wFDN_FLAP_D_lgt_3	;
self.final_score_4	:= 	wFDN_FLAP_D_lgt_4	;
self.final_score_5	:= 	wFDN_FLAP_D_lgt_5	;
self.final_score_6	:= 	wFDN_FLAP_D_lgt_6	;
self.final_score_7	:= 	wFDN_FLAP_D_lgt_7	;
self.final_score_8	:= 	wFDN_FLAP_D_lgt_8	;
self.final_score_9	:= 	wFDN_FLAP_D_lgt_9	;
self.final_score_10	:= 	wFDN_FLAP_D_lgt_10	;
self.final_score_11	:= 	wFDN_FLAP_D_lgt_11	;
self.final_score_12	:= 	wFDN_FLAP_D_lgt_12	;
self.final_score_13	:= 	wFDN_FLAP_D_lgt_13	;
self.final_score_14	:= 	wFDN_FLAP_D_lgt_14	;
self.final_score_15	:= 	wFDN_FLAP_D_lgt_15	;
self.final_score_16	:= 	wFDN_FLAP_D_lgt_16	;
self.final_score_17	:= 	wFDN_FLAP_D_lgt_17	;
self.final_score_18	:= 	wFDN_FLAP_D_lgt_18	;
self.final_score_19	:= 	wFDN_FLAP_D_lgt_19	;
self.final_score_20	:= 	wFDN_FLAP_D_lgt_20	;
self.final_score_21	:= 	wFDN_FLAP_D_lgt_21	;
self.final_score_22	:= 	wFDN_FLAP_D_lgt_22	;
self.final_score_23	:= 	wFDN_FLAP_D_lgt_23	;
self.final_score_24	:= 	wFDN_FLAP_D_lgt_24	;
self.final_score_25	:= 	wFDN_FLAP_D_lgt_25	;
self.final_score_26	:= 	wFDN_FLAP_D_lgt_26	;
self.final_score_27	:= 	wFDN_FLAP_D_lgt_27	;
self.final_score_28	:= 	wFDN_FLAP_D_lgt_28	;
self.final_score_29	:= 	wFDN_FLAP_D_lgt_29	;
self.final_score_30	:= 	wFDN_FLAP_D_lgt_30	;
self.final_score_31	:= 	wFDN_FLAP_D_lgt_31	;
self.final_score_32	:= 	wFDN_FLAP_D_lgt_32	;
self.final_score_33	:= 	wFDN_FLAP_D_lgt_33	;
self.final_score_34	:= 	wFDN_FLAP_D_lgt_34	;
self.final_score_35	:= 	wFDN_FLAP_D_lgt_35	;
self.final_score_36	:= 	wFDN_FLAP_D_lgt_36	;
self.final_score_37	:= 	wFDN_FLAP_D_lgt_37	;
self.final_score_38	:= 	wFDN_FLAP_D_lgt_38	;
self.final_score_39	:= 	wFDN_FLAP_D_lgt_39	;
self.final_score_40	:= 	wFDN_FLAP_D_lgt_40	;
self.final_score_41	:= 	wFDN_FLAP_D_lgt_41	;
self.final_score_42	:= 	wFDN_FLAP_D_lgt_42	;
self.final_score_43	:= 	wFDN_FLAP_D_lgt_43	;
self.final_score_44	:= 	wFDN_FLAP_D_lgt_44	;
self.final_score_45	:= 	wFDN_FLAP_D_lgt_45	;
self.final_score_46	:= 	wFDN_FLAP_D_lgt_46	;
self.final_score_47	:= 	wFDN_FLAP_D_lgt_47	;
self.final_score_48	:= 	wFDN_FLAP_D_lgt_48	;
self.final_score_49	:= 	wFDN_FLAP_D_lgt_49	;
self.final_score_50	:= 	wFDN_FLAP_D_lgt_50	;
self.final_score_51	:= 	wFDN_FLAP_D_lgt_51	;
self.final_score_52	:= 	wFDN_FLAP_D_lgt_52	;
self.final_score_53	:= 	wFDN_FLAP_D_lgt_53	;
self.final_score_54	:= 	wFDN_FLAP_D_lgt_54	;
self.final_score_55	:= 	wFDN_FLAP_D_lgt_55	;
self.final_score_56	:= 	wFDN_FLAP_D_lgt_56	;
self.final_score_57	:= 	wFDN_FLAP_D_lgt_57	;
self.final_score_58	:= 	wFDN_FLAP_D_lgt_58	;
self.final_score_59	:= 	wFDN_FLAP_D_lgt_59	;
self.final_score_60	:= 	wFDN_FLAP_D_lgt_60	;
self.final_score_61	:= 	wFDN_FLAP_D_lgt_61	;
self.final_score_62	:= 	wFDN_FLAP_D_lgt_62	;
self.final_score_63	:= 	wFDN_FLAP_D_lgt_63	;
self.final_score_64	:= 	wFDN_FLAP_D_lgt_64	;
self.final_score_65	:= 	wFDN_FLAP_D_lgt_65	;
self.final_score_66	:= 	wFDN_FLAP_D_lgt_66	;
self.final_score_67	:= 	wFDN_FLAP_D_lgt_67	;
self.final_score_68	:= 	wFDN_FLAP_D_lgt_68	;
self.final_score_69	:= 	wFDN_FLAP_D_lgt_69	;
self.final_score_70	:= 	wFDN_FLAP_D_lgt_70	;
self.final_score_71	:= 	wFDN_FLAP_D_lgt_71	;
self.final_score_72	:= 	wFDN_FLAP_D_lgt_72	;
self.final_score_73	:= 	wFDN_FLAP_D_lgt_73	;
self.final_score_74	:= 	wFDN_FLAP_D_lgt_74	;
self.final_score_75	:= 	wFDN_FLAP_D_lgt_75	;
self.final_score_76	:= 	wFDN_FLAP_D_lgt_76	;
self.final_score_77	:= 	wFDN_FLAP_D_lgt_77	;
self.final_score_78	:= 	wFDN_FLAP_D_lgt_78	;
self.final_score_79	:= 	wFDN_FLAP_D_lgt_79	;
self.final_score_80	:= 	wFDN_FLAP_D_lgt_80	;
self.final_score_81	:= 	wFDN_FLAP_D_lgt_81	;
self.final_score_82	:= 	wFDN_FLAP_D_lgt_82	;
self.final_score_83	:= 	wFDN_FLAP_D_lgt_83	;
self.final_score_84	:= 	wFDN_FLAP_D_lgt_84	;
self.final_score_85	:= 	wFDN_FLAP_D_lgt_85	;
self.final_score_86	:= 	wFDN_FLAP_D_lgt_86	;
self.final_score_87	:= 	wFDN_FLAP_D_lgt_87	;
self.final_score_88	:= 	wFDN_FLAP_D_lgt_88	;
self.final_score_89	:= 	wFDN_FLAP_D_lgt_89	;
self.final_score_90	:= 	wFDN_FLAP_D_lgt_90	;
self.final_score_91	:= 	wFDN_FLAP_D_lgt_91	;
self.final_score_92	:= 	wFDN_FLAP_D_lgt_92	;
self.final_score_93	:= 	wFDN_FLAP_D_lgt_93	;
self.final_score_94	:= 	wFDN_FLAP_D_lgt_94	;
self.final_score_95	:= 	wFDN_FLAP_D_lgt_95	;
self.final_score_96	:= 	wFDN_FLAP_D_lgt_96	;
self.final_score_97	:= 	wFDN_FLAP_D_lgt_97	;
self.final_score_98	:= 	wFDN_FLAP_D_lgt_98	;
self.final_score_99	:= 	wFDN_FLAP_D_lgt_99	;
self.final_score_100	:= 	wFDN_FLAP_D_lgt_100	;
self.final_score_101	:= 	wFDN_FLAP_D_lgt_101	;
self.final_score_102	:= 	wFDN_FLAP_D_lgt_102	;
self.final_score_103	:= 	wFDN_FLAP_D_lgt_103	;
self.final_score_104	:= 	wFDN_FLAP_D_lgt_104	;
self.final_score_105	:= 	wFDN_FLAP_D_lgt_105	;
self.final_score_106	:= 	wFDN_FLAP_D_lgt_106	;
self.final_score_107	:= 	wFDN_FLAP_D_lgt_107	;
self.final_score_108	:= 	wFDN_FLAP_D_lgt_108	;
self.final_score_109	:= 	wFDN_FLAP_D_lgt_109	;
self.final_score_110	:= 	wFDN_FLAP_D_lgt_110	;
self.final_score_111	:= 	wFDN_FLAP_D_lgt_111	;
self.final_score_112	:= 	wFDN_FLAP_D_lgt_112	;
self.final_score_113	:= 	wFDN_FLAP_D_lgt_113	;
self.final_score_114	:= 	wFDN_FLAP_D_lgt_114	;
self.final_score_115	:= 	wFDN_FLAP_D_lgt_115	;
self.final_score_116	:= 	wFDN_FLAP_D_lgt_116	;
self.final_score_117	:= 	wFDN_FLAP_D_lgt_117	;
self.final_score_118	:= 	wFDN_FLAP_D_lgt_118	;
self.final_score_119	:= 	wFDN_FLAP_D_lgt_119	;
self.final_score_120	:= 	wFDN_FLAP_D_lgt_120	;
self.final_score_121	:= 	wFDN_FLAP_D_lgt_121	;
self.final_score_122	:= 	wFDN_FLAP_D_lgt_122	;
self.final_score_123	:= 	wFDN_FLAP_D_lgt_123	;
self.final_score_124	:= 	wFDN_FLAP_D_lgt_124	;
self.final_score_125	:= 	wFDN_FLAP_D_lgt_125	;
self.final_score_126	:= 	wFDN_FLAP_D_lgt_126	;
self.final_score_127	:= 	wFDN_FLAP_D_lgt_127	;
self.final_score_128	:= 	wFDN_FLAP_D_lgt_128	;
self.final_score_129	:= 	wFDN_FLAP_D_lgt_129	;
self.final_score_130	:= 	wFDN_FLAP_D_lgt_130	;
self.final_score_131	:= 	wFDN_FLAP_D_lgt_131	;
self.final_score_132	:= 	wFDN_FLAP_D_lgt_132	;
self.final_score_133	:= 	wFDN_FLAP_D_lgt_133	;
self.final_score_134	:= 	wFDN_FLAP_D_lgt_134	;
self.final_score_135	:= 	wFDN_FLAP_D_lgt_135	;
self.final_score_136	:= 	wFDN_FLAP_D_lgt_136	;
self.final_score_137	:= 	wFDN_FLAP_D_lgt_137	;
self.final_score_138	:= 	wFDN_FLAP_D_lgt_138	;
self.final_score_139	:= 	wFDN_FLAP_D_lgt_139	;
self.final_score_140	:= 	wFDN_FLAP_D_lgt_140	;
self.final_score_141	:= 	wFDN_FLAP_D_lgt_141	;
self.final_score_142	:= 	wFDN_FLAP_D_lgt_142	;
self.final_score_143	:= 	wFDN_FLAP_D_lgt_143	;
self.final_score_144	:= 	wFDN_FLAP_D_lgt_144	;
self.final_score_145	:= 	wFDN_FLAP_D_lgt_145	;
self.final_score_146	:= 	wFDN_FLAP_D_lgt_146	;
self.final_score_147	:= 	wFDN_FLAP_D_lgt_147	;
self.final_score_148	:= 	wFDN_FLAP_D_lgt_148	;
self.final_score_149	:= 	wFDN_FLAP_D_lgt_149	;
self.final_score_150	:= 	wFDN_FLAP_D_lgt_150	;
self.final_score_151	:= 	wFDN_FLAP_D_lgt_151	;
self.final_score_152	:= 	wFDN_FLAP_D_lgt_152	;
self.final_score_153	:= 	wFDN_FLAP_D_lgt_153	;
self.final_score_154	:= 	wFDN_FLAP_D_lgt_154	;
self.final_score_155	:= 	wFDN_FLAP_D_lgt_155	;
self.final_score_156	:= 	wFDN_FLAP_D_lgt_156	;
self.final_score_157	:= 	wFDN_FLAP_D_lgt_157	;
self.final_score_158	:= 	wFDN_FLAP_D_lgt_158	;
self.final_score_159	:= 	wFDN_FLAP_D_lgt_159	;
self.final_score_160	:= 	wFDN_FLAP_D_lgt_160	;
self.final_score_161	:= 	wFDN_FLAP_D_lgt_161	;
self.final_score_162	:= 	wFDN_FLAP_D_lgt_162	;
self.final_score_163	:= 	wFDN_FLAP_D_lgt_163	;
self.final_score_164	:= 	wFDN_FLAP_D_lgt_164	;
self.final_score_165	:= 	wFDN_FLAP_D_lgt_165	;
self.final_score_166	:= 	wFDN_FLAP_D_lgt_166	;
self.final_score_167	:= 	wFDN_FLAP_D_lgt_167	;
self.final_score_168	:= 	wFDN_FLAP_D_lgt_168	;
self.final_score_169	:= 	wFDN_FLAP_D_lgt_169	;
self.final_score_170	:= 	wFDN_FLAP_D_lgt_170	;
self.final_score_171	:= 	wFDN_FLAP_D_lgt_171	;
self.final_score_172	:= 	wFDN_FLAP_D_lgt_172	;
self.final_score_173	:= 	wFDN_FLAP_D_lgt_173	;
self.final_score_174	:= 	wFDN_FLAP_D_lgt_174	;
self.final_score_175	:= 	wFDN_FLAP_D_lgt_175	;
self.final_score_176	:= 	wFDN_FLAP_D_lgt_176	;
self.final_score_177	:= 	wFDN_FLAP_D_lgt_177	;
self.final_score_178	:= 	wFDN_FLAP_D_lgt_178	;
self.final_score_179	:= 	wFDN_FLAP_D_lgt_179	;
self.final_score_180	:= 	wFDN_FLAP_D_lgt_180	;
self.final_score_181	:= 	wFDN_FLAP_D_lgt_181	;
self.final_score_182	:= 	wFDN_FLAP_D_lgt_182	;
self.final_score_183	:= 	wFDN_FLAP_D_lgt_183	;
self.final_score_184	:= 	wFDN_FLAP_D_lgt_184	;
self.final_score_185	:= 	wFDN_FLAP_D_lgt_185	;
self.final_score_186	:= 	wFDN_FLAP_D_lgt_186	;
self.final_score_187	:= 	wFDN_FLAP_D_lgt_187	;
self.final_score_188	:= 	wFDN_FLAP_D_lgt_188	;
self.final_score_189	:= 	wFDN_FLAP_D_lgt_189	;
self.final_score_190	:= 	wFDN_FLAP_D_lgt_190	;
self.final_score_191	:= 	wFDN_FLAP_D_lgt_191	;
self.final_score_192	:= 	wFDN_FLAP_D_lgt_192	;
self.final_score_193	:= 	wFDN_FLAP_D_lgt_193	;
self.final_score_194	:= 	wFDN_FLAP_D_lgt_194	;
self.final_score_195	:= 	wFDN_FLAP_D_lgt_195	;
self.final_score_196	:= 	wFDN_FLAP_D_lgt_196	;
self.final_score_197	:= 	wFDN_FLAP_D_lgt_197	;
self.final_score_198	:= 	wFDN_FLAP_D_lgt_198	;
self.final_score_199	:= 	wFDN_FLAP_D_lgt_199	;
self.final_score_200	:= 	wFDN_FLAP_D_lgt_200	;
self.final_score_201	:= 	wFDN_FLAP_D_lgt_201	;
self.final_score_202	:= 	wFDN_FLAP_D_lgt_202	;
self.final_score_203	:= 	wFDN_FLAP_D_lgt_203	;
self.final_score_204	:= 	wFDN_FLAP_D_lgt_204	;
self.final_score_205	:= 	wFDN_FLAP_D_lgt_205	;
self.final_score_206	:= 	wFDN_FLAP_D_lgt_206	;
self.final_score_207	:= 	wFDN_FLAP_D_lgt_207	;
self.final_score_208	:= 	wFDN_FLAP_D_lgt_208	;
self.final_score_209	:= 	wFDN_FLAP_D_lgt_209	;
self.final_score_210	:= 	wFDN_FLAP_D_lgt_210	;
self.final_score_211	:= 	wFDN_FLAP_D_lgt_211	;
self.final_score_212	:= 	wFDN_FLAP_D_lgt_212	;
self.final_score_213	:= 	wFDN_FLAP_D_lgt_213	;
self.final_score_214	:= 	wFDN_FLAP_D_lgt_214	;
self.final_score_215	:= 	wFDN_FLAP_D_lgt_215	;
self.final_score_216	:= 	wFDN_FLAP_D_lgt_216	;
self.final_score_217	:= 	wFDN_FLAP_D_lgt_217	;
self.final_score_218	:= 	wFDN_FLAP_D_lgt_218	;
self.final_score_219	:= 	wFDN_FLAP_D_lgt_219	;
self.final_score_220	:= 	wFDN_FLAP_D_lgt_220	;
self.final_score_221	:= 	wFDN_FLAP_D_lgt_221	;
self.final_score_222	:= 	wFDN_FLAP_D_lgt_222	;
self.final_score_223	:= 	wFDN_FLAP_D_lgt_223	;
self.final_score_224	:= 	wFDN_FLAP_D_lgt_224	;
self.final_score_225	:= 	wFDN_FLAP_D_lgt_225	;
self.final_score_226	:= 	wFDN_FLAP_D_lgt_226	;
self.final_score_227	:= 	wFDN_FLAP_D_lgt_227	;
self.final_score_228	:= 	wFDN_FLAP_D_lgt_228	;
self.final_score_229	:= 	wFDN_FLAP_D_lgt_229	;
self.final_score_230	:= 	wFDN_FLAP_D_lgt_230	;
self.final_score_231	:= 	wFDN_FLAP_D_lgt_231	;
self.final_score_232	:= 	wFDN_FLAP_D_lgt_232	;
self.final_score_233	:= 	wFDN_FLAP_D_lgt_233	;
self.final_score_234	:= 	wFDN_FLAP_D_lgt_234	;
self.final_score_235	:= 	wFDN_FLAP_D_lgt_235	;
self.final_score_236	:= 	wFDN_FLAP_D_lgt_236	;
self.final_score_237	:= 	wFDN_FLAP_D_lgt_237	;
self.final_score_238	:= 	wFDN_FLAP_D_lgt_238	;
self.final_score_239	:= 	wFDN_FLAP_D_lgt_239	;
self.final_score_240	:= 	wFDN_FLAP_D_lgt_240	;
self.final_score_241	:= 	wFDN_FLAP_D_lgt_241	;
self.final_score_242	:= 	wFDN_FLAP_D_lgt_242	;
self.final_score_243	:= 	wFDN_FLAP_D_lgt_243	;
self.final_score_244	:= 	wFDN_FLAP_D_lgt_244	;
self.final_score_245	:= 	wFDN_FLAP_D_lgt_245	;
self.final_score_246	:= 	wFDN_FLAP_D_lgt_246	;
self.final_score_247	:= 	wFDN_FLAP_D_lgt_247	;
self.final_score_248	:= 	wFDN_FLAP_D_lgt_248	;
self.final_score_249	:= 	wFDN_FLAP_D_lgt_249	;
self.final_score_250	:= 	wFDN_FLAP_D_lgt_250	;
self.final_score_251	:= 	wFDN_FLAP_D_lgt_251	;
self.final_score_252	:= 	wFDN_FLAP_D_lgt_252	;
self.final_score_253	:= 	wFDN_FLAP_D_lgt_253	;
self.final_score_254	:= 	wFDN_FLAP_D_lgt_254	;
self.final_score_255	:= 	wFDN_FLAP_D_lgt_255	;
self.final_score_256	:= 	wFDN_FLAP_D_lgt_256	;
self.final_score_257	:= 	wFDN_FLAP_D_lgt_257	;
self.final_score_258	:= 	wFDN_FLAP_D_lgt_258	;
// self.wFDN_submodel_lgt	:= 	wFDN_FLAP_D_lgt	;
self.FP3_wFDN_LGT		:= 	wFDN_FLAP_D_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
