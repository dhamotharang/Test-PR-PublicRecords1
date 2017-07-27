
export FP31505_FLPSD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   woFDN_FL_PSD_lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FL_PSD_lgt_1 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.2654558727,
      (r_F00_dob_score_d > 92) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 51.05) => 0.1688298852,
         (c_fammar_p > 51.05) => 0.0015945330,
         (c_fammar_p = NULL) => -0.0596624268, 0.0165441686),
      (r_F00_dob_score_d = NULL) => 0.0138593396, 0.0287239593),
   (k_nap_phn_verd_d > 0.5) => -0.0548965313,
   (k_nap_phn_verd_d = NULL) => -0.0220581286, -0.0220581286),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0903425254,
   (f_inq_Communications_count_i > 0.5) => 0.4686572768,
   (f_inq_Communications_count_i = NULL) => 0.1845008635, 0.1845008635),
(f_srchvelocityrisktype_i = NULL) => 0.2504495640, -0.0016766067);

// Tree: 2 
woFDN_FL_PSD_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 0.0056882306,
         (k_inq_per_phone_i > 2.5) => 0.2643382283,
         (k_inq_per_phone_i = NULL) => 0.0144629987, 0.0144629987),
      (f_phone_ver_experian_d > 0.5) => -0.0606845381,
      (f_phone_ver_experian_d = NULL) => -0.0143336658, -0.0269737969),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.1994849717,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0219774013, -0.0219774013),
(f_varrisktype_i > 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.1329866492,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.4169118635,
   (nf_seg_FraudPoint_3_0 = '') => 0.2268297229, 0.2268297229),
(f_varrisktype_i = NULL) => 0.2115505657, -0.0062090817);

// Tree: 3 
woFDN_FL_PSD_lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1895015945,
         (r_F00_dob_score_d > 92) => 0.0099546617,
         (r_F00_dob_score_d = NULL) => -0.0046225162, 0.0173595084),
      (k_nap_phn_verd_d > 0.5) => -0.0470418388,
      (k_nap_phn_verd_d = NULL) => -0.0221065293, -0.0221065293),
   (f_varrisktype_i > 3.5) => 0.1254549155,
   (f_varrisktype_i = NULL) => -0.0147503072, -0.0147503072),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.1112032758,
   (f_srchvelocityrisktype_i > 4.5) => 0.3037746266,
   (f_srchvelocityrisktype_i = NULL) => 0.1888390231, 0.1888390231),
(f_inq_Communications_count_i = NULL) => 0.0962237473, -0.0068806614);

// Tree: 4 
woFDN_FL_PSD_lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0603064581,
         (f_corrphonelastnamecount_d > 0.5) => -0.0357479917,
         (f_corrphonelastnamecount_d = NULL) => 0.0184602149, 0.0184602149),
      (k_inq_per_phone_i > 2.5) => 0.2579515455,
      (k_inq_per_phone_i = NULL) => 0.0271439466, 0.0271439466),
   (f_phone_ver_experian_d > 0.5) => -0.0500971022,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => -0.0135090468,
      (f_rel_felony_count_i > 1.5) => 0.2776303225,
      (f_rel_felony_count_i = NULL) => 0.0015576988, 0.0015576988), -0.0140977712),
(f_srchfraudsrchcount_i > 8.5) => 0.2004278084,
(f_srchfraudsrchcount_i = NULL) => 0.1117038822, -0.0077170326);

// Tree: 5 
woFDN_FL_PSD_lgt_5 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 28.55) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.3149990369,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0260321807,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0240809742, -0.0240809742),
   (c_famotf18_p > 28.55) => 0.1012161054,
   (c_famotf18_p = NULL) => -0.0244441813, -0.0147927778),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0658088196,
   (f_inq_Communications_count_i > 0.5) => 0.1618881569,
   (f_inq_Communications_count_i = NULL) => 0.0900232341, 0.0900232341),
(f_srchvelocityrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0687161338,
   (f_addrs_per_ssn_i > 3.5) => 0.2470853779,
   (f_addrs_per_ssn_i = NULL) => 0.0921638816, 0.0921638816), -0.0047188326);

// Tree: 6 
woFDN_FL_PSD_lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1820985271,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0216143375,
      (f_phone_ver_experian_d > 0.5) => -0.0503553977,
      (f_phone_ver_experian_d = NULL) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0311905121,
         (f_assocrisktype_i > 8.5) => 0.2083626208,
         (f_assocrisktype_i = NULL) => -0.0203535846, -0.0203535846), -0.0209896581),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0161562093, -0.0161562093),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => 0.1040206016,
   (f_inq_count_i > 14.5) => 0.2479071495,
   (f_inq_count_i = NULL) => 0.1294967734, 0.1294967734),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0611018134, -0.0109488471);

// Tree: 7 
woFDN_FL_PSD_lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1285162073,
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0280985191,
      (f_varrisktype_i > 2.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0214604884,
         (f_assocrisktype_i > 4.5) => 
            map(
            (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 0.3369864918,
            (r_Prop_Owner_History_d > 0.5) => 0.0808712036,
            (r_Prop_Owner_History_d = NULL) => 0.1721818716, 0.1721818716),
         (f_assocrisktype_i = NULL) => 0.0520840910, 0.0520840910),
      (f_varrisktype_i = NULL) => -0.0201260365, -0.0201260365),
   (r_F00_dob_score_d = NULL) => -0.0005127623, -0.0148214796),
(f_inq_Communications_count_i > 1.5) => 0.1272279538,
(f_inq_Communications_count_i = NULL) => 0.0584516594, -0.0095965818);

// Tree: 8 
woFDN_FL_PSD_lgt_8 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 61.5) => 0.0956342237,
   (r_I60_inq_comm_recency_d > 61.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => -0.0008017469,
      (f_phone_ver_insurance_d > 3.5) => -0.0547329114,
      (f_phone_ver_insurance_d = NULL) => -0.0269839254, -0.0269839254),
   (r_I60_inq_comm_recency_d = NULL) => -0.0215952246, -0.0215952246),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0408336995,
   (f_assocrisktype_i > 5.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.1048857830,
      (f_varrisktype_i > 2.5) => 0.1981920968,
      (f_varrisktype_i = NULL) => 0.1429590490, 0.1429590490),
   (f_assocrisktype_i = NULL) => 0.0624514742, 0.0624514742),
(f_srchvelocityrisktype_i = NULL) => 0.0438174173, -0.0102075710);

// Tree: 9 
woFDN_FL_PSD_lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 44.35) => 0.0997472164,
   (c_fammar_p > 44.35) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0203356695,
      (k_inq_per_phone_i > 2.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
            map(
            (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 0.0449260934,
            (f_util_add_curr_misc_n > 0.5) => 0.2950098928,
            (f_util_add_curr_misc_n = NULL) => 0.1751780723, 0.1751780723),
         (f_phone_ver_experian_d > 0.5) => 0.0326010934,
         (f_phone_ver_experian_d = NULL) => 0.0907555796, 0.0820873222),
      (k_inq_per_phone_i = NULL) => -0.0155754079, -0.0155754079),
   (c_fammar_p = NULL) => -0.0405815689, -0.0099208448),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1321321863,
(f_inq_PrepaidCards_count_i = NULL) => 0.0908551497, -0.0051873941);

// Tree: 10 
woFDN_FL_PSD_lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0519690640,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 24.65) => 0.0012482976,
      (c_famotf18_p > 24.65) => 
         map(
         (NULL < c_unemp and c_unemp <= 11.35) => 0.0695572716,
         (c_unemp > 11.35) => 0.2358484792,
         (c_unemp = NULL) => 0.0865075557, 0.0865075557),
      (c_famotf18_p = NULL) => -0.0197878640, 0.0107836517),
   (nf_seg_FraudPoint_3_0 = '') => -0.0110981810, -0.0110981810),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1509117123,
   (f_phone_ver_experian_d > 0.5) => -0.0076462649,
   (f_phone_ver_experian_d = NULL) => 0.1552606937, 0.0972915947),
(f_inq_Communications_count_i = NULL) => 0.0302126116, -0.0070331837);

// Tree: 11 
woFDN_FL_PSD_lgt_11 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0246382459,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2530638848,
      (r_C10_M_Hdr_FS_d > 2.5) => 0.0111456658,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0167374495, 0.0167374495),
   (f_assocrisktype_i > 4.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
         map(
         (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0663183080,
         (f_inq_Communications_count_i > 0.5) => 0.1808722491,
         (f_inq_Communications_count_i = NULL) => 0.0859459303, 0.0859459303),
      (f_varrisktype_i > 2.5) => 0.1456946214,
      (f_varrisktype_i = NULL) => 0.1004069476, 0.1004069476),
   (f_assocrisktype_i = NULL) => 0.0265879044, 0.0378198397),
(nf_seg_FraudPoint_3_0 = '') => -0.0078777159, -0.0078777159);

// Tree: 12 
woFDN_FL_PSD_lgt_12 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 24.5) => 0.0466557404,
         (f_rel_homeover150_count_d > 24.5) => 0.2950912589,
         (f_rel_homeover150_count_d = NULL) => 0.0523643781, 0.0523643781),
      (f_phone_ver_experian_d > 0.5) => -0.0444949271,
      (f_phone_ver_experian_d = NULL) => 0.0164219511, 0.0188355319),
   (k_nap_phn_verd_d > 0.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.2157935088,
      (r_D33_Eviction_Recency_d > 79.5) => -0.0389530878,
      (r_D33_Eviction_Recency_d = NULL) => -0.0362460097, -0.0362460097),
   (k_nap_phn_verd_d = NULL) => -0.0139034436, -0.0139034436),
(f_inq_HighRiskCredit_count_i > 2.5) => 0.0819224635,
(f_inq_HighRiskCredit_count_i = NULL) => 0.0626926359, -0.0103217136);

// Tree: 13 
woFDN_FL_PSD_lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.05) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.2164763191,
      (r_F00_dob_score_d > 55) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1040114907,
         (r_D33_Eviction_Recency_d > 79.5) => -0.0150417282,
         (r_D33_Eviction_Recency_d = NULL) => -0.0130245784, -0.0130245784),
      (r_F00_dob_score_d = NULL) => -0.0069838804, -0.0115212537),
   (c_unemp > 11.05) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0695271188,
      (f_rel_criminal_count_i > 2.5) => 0.2483002210,
      (f_rel_criminal_count_i = NULL) => 0.1344660662, 0.1344660662),
   (c_unemp = NULL) => -0.0295413502, -0.0092505589),
(f_assocsuspicousidcount_i > 13.5) => 0.2103767184,
(f_assocsuspicousidcount_i = NULL) => 0.0310196732, -0.0070758890);

// Tree: 14 
woFDN_FL_PSD_lgt_14 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.45) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0159259441,
         (f_varrisktype_i > 2.5) => 0.1020388150,
         (f_varrisktype_i = NULL) => 0.0285215581, 0.0285215581),
      (r_D32_criminal_count_i > 5.5) => 0.2481815253,
      (r_D32_criminal_count_i = NULL) => 0.0351355235, 0.0351355235),
   (c_fammar_p > 59.45) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0090876802,
      (f_corrphonelastnamecount_d > 0.5) => -0.0394232381,
      (f_corrphonelastnamecount_d = NULL) => -0.0189455025, -0.0189455025),
   (c_fammar_p = NULL) => -0.0372078802, -0.0117421525),
(f_inq_PrepaidCards_count_i > 0.5) => 0.0986320646,
(f_inq_PrepaidCards_count_i = NULL) => 0.0039301404, -0.0083879486);

// Tree: 15 
woFDN_FL_PSD_lgt_15 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1449792169,
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 30.65) => 
      map(
      (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 2.5) => 
         map(
         (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1169562648,
         (r_F00_input_dob_match_level_d > 4.5) => -0.0191308539,
         (r_F00_input_dob_match_level_d = NULL) => -0.0166154250, -0.0166154250),
      (f_srchunvrfdphonecount_i > 2.5) => 0.1550405349,
      (f_srchunvrfdphonecount_i = NULL) => -0.0158107403, -0.0158107403),
   (c_famotf18_p > 30.65) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1077340009,
      (k_nap_phn_verd_d > 0.5) => 0.0059514935,
      (k_nap_phn_verd_d = NULL) => 0.0573847842, 0.0573847842),
   (c_famotf18_p = NULL) => -0.0351082555, -0.0112929115),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0657786092, -0.0088485597);

// Tree: 16 
woFDN_FL_PSD_lgt_16 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => -0.0138031909,
   (r_D30_Derog_Count_i > 5.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.95) => 0.0474412415,
      (c_famotf18_p > 29.95) => 0.1924917057,
      (c_famotf18_p = NULL) => 0.0647300847, 0.0647300847),
   (r_D30_Derog_Count_i = NULL) => -0.0102986207, -0.0102986207),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 3.5) => 0.0196925620,
      (r_D30_Derog_Count_i > 3.5) => 0.1365676330,
      (r_D30_Derog_Count_i = NULL) => 0.0289765482, 0.0289765482),
   (f_rel_felony_count_i > 0.5) => 0.1233384714,
   (f_rel_felony_count_i = NULL) => 0.0475143161, 0.0475143161),
(f_varrisktype_i = NULL) => 0.0192579095, -0.0036557355);

// Tree: 17 
woFDN_FL_PSD_lgt_17 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.35) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0665495964,
      (r_D33_Eviction_Recency_d > 549) => 
         map(
         (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0356057116,
         (c_housingcpi > 222.35) => 0.0143739296,
         (c_housingcpi = NULL) => -0.0232964321, -0.0232964321),
      (r_D33_Eviction_Recency_d = NULL) => -0.0201059225, -0.0201059225),
   (c_unemp > 9.35) => 0.0680761711,
   (c_unemp = NULL) => -0.0006267710, -0.0160908652),
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 0.1224620162,
   (k_inf_phn_verd_d > 0.5) => -0.0123753148,
   (k_inf_phn_verd_d = NULL) => 0.0793507607, 0.0793507607),
(f_srchcomponentrisktype_i = NULL) => 0.0175052997, -0.0114178092);

// Tree: 18 
woFDN_FL_PSD_lgt_18 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 
      map(
      (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1742870081,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0116549961,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0108680869, -0.0108680869),
      (f_srchunvrfdaddrcount_i > 0.5) => 
         map(
         (NULL < c_business and c_business <= 31.5) => 0.1544926961,
         (c_business > 31.5) => -0.0232880138,
         (c_business = NULL) => 0.0888603910, 0.0888603910),
      (f_srchunvrfdaddrcount_i = NULL) => -0.0032488421, -0.0084645713),
   (k_inq_per_phone_i > 5.5) => 0.1102236579,
   (k_inq_per_phone_i = NULL) => -0.0065481237, -0.0065481237),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.2509284056,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0055331579, -0.0055331579);

// Tree: 19 
woFDN_FL_PSD_lgt_19 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0115662588,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 11.5) => 0.2089794605,
         (c_many_cars > 11.5) => 0.0487676191,
         (c_many_cars = NULL) => -0.0014659602, 0.0529650644),
      (k_inq_per_phone_i > 2.5) => 0.1367724307,
      (k_inq_per_phone_i = NULL) => 0.0573379369, 0.0573379369),
   (f_corrrisktype_i = NULL) => 0.0273591565, 0.0273591565),
(f_phone_ver_experian_d > 0.5) => -0.0242026556,
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0086221286,
   (f_assocrisktype_i > 8.5) => 0.1259920725,
   (f_assocrisktype_i = NULL) => 0.0103790456, -0.0020063055), -0.0027362254);

// Tree: 20 
woFDN_FL_PSD_lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.0988028534,
   (r_F00_input_dob_match_level_d > 4.5) => -0.0114536276,
   (r_F00_input_dob_match_level_d = NULL) => -0.0092701362, -0.0092701362),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 59.5) => 0.1824917745,
      (c_very_rich > 59.5) => 0.0771514054,
      (c_very_rich = NULL) => 0.1001865230, 0.1001865230),
   (f_phone_ver_experian_d > 0.5) => 0.0059025004,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 179.5) => 0.0136455427,
      (c_rich_blk > 179.5) => 0.1736624507,
      (c_rich_blk = NULL) => 0.0362566275, 0.0362566275), 0.0448067164),
(f_varrisktype_i = NULL) => 0.0365110188, -0.0030455659);

// Tree: 21 
woFDN_FL_PSD_lgt_21 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 21.55) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 31.7) => 0.0224781582,
      (c_famotf18_p > 31.7) => 
         map(
         (NULL < c_incollege and c_incollege <= 3.45) => -0.0083669715,
         (c_incollege > 3.45) => 0.1745111179,
         (c_incollege = NULL) => 0.1083857070, 0.1083857070),
      (c_famotf18_p = NULL) => 0.0415089919, 0.0415089919),
   (c_white_col > 21.55) => -0.0171704912,
   (c_white_col = NULL) => -0.0140566829, -0.0131143141),
(f_assocrisktype_i > 7.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 118.5) => 0.1969604572,
   (f_M_Bureau_ADL_FS_all_d > 118.5) => 0.0281618733,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0488479742, 0.0488479742),
(f_assocrisktype_i = NULL) => -0.0035803618, -0.0090539997);

// Tree: 22 
woFDN_FL_PSD_lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1716962401,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0205032283,
      (f_assocrisktype_i > 3.5) => 
         map(
         (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
            map(
            (NULL < C_INC_15K_P and C_INC_15K_P <= 11.1) => 0.0158439984,
            (C_INC_15K_P > 11.1) => 0.1374170715,
            (C_INC_15K_P = NULL) => -0.0223627094, 0.0690485654),
         (r_Ever_Asset_Owner_d > 0.5) => 0.0125875489,
         (r_Ever_Asset_Owner_d = NULL) => 0.0245658902, 0.0245658902),
      (f_assocrisktype_i = NULL) => -0.0099053641, -0.0099053641),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0089864900, -0.0089864900),
(r_D33_eviction_count_i > 2.5) => 0.1395113969,
(r_D33_eviction_count_i = NULL) => -0.0017500759, -0.0073496260);

// Tree: 23 
woFDN_FL_PSD_lgt_23 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1079009534,
      (r_F00_input_dob_match_level_d > 4.5) => 0.0110496387,
      (r_F00_input_dob_match_level_d = NULL) => 0.0143037778, 0.0143037778),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 10.5) => 0.2060904459,
      (f_prevaddrlenofres_d > 10.5) => 0.0582213699,
      (f_prevaddrlenofres_d = NULL) => 0.0869050034, 0.0869050034),
   (f_rel_felony_count_i = NULL) => 0.0631663016, 0.0191152439),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.0938024157,
   (r_D33_Eviction_Recency_d > 79.5) => -0.0273336021,
   (r_D33_Eviction_Recency_d = NULL) => -0.0255342342, -0.0255342342),
(k_nap_phn_verd_d = NULL) => -0.0075090093, -0.0075090093);

// Tree: 24 
woFDN_FL_PSD_lgt_24 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.1894942299,
(r_D32_Mos_Since_Fel_LS_d > 127.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
         map(
         (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.25) => -0.0018425232,
         (c_pop_0_5_p > 7.25) => 0.1468001199,
         (c_pop_0_5_p = NULL) => 0.0932078745, 0.0932078745),
      (r_D33_Eviction_Recency_d > 549) => 0.0296483949,
      (r_D33_Eviction_Recency_d = NULL) => 0.0375596934, 0.0375596934),
   (r_I60_inq_comm_recency_d > 549) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 5.5) => -0.0129962575,
      (f_varrisktype_i > 5.5) => 0.0962409797,
      (f_varrisktype_i = NULL) => -0.0120030164, -0.0120030164),
   (r_I60_inq_comm_recency_d = NULL) => -0.0073237007, -0.0073237007),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0109319515, -0.0059302014);

// Tree: 25 
woFDN_FL_PSD_lgt_25 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0036026807,
      (f_assocrisktype_i > 3.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 11.4) => 0.1739069122,
         (C_OWNOCC_P > 11.4) => 0.0530255355,
         (C_OWNOCC_P = NULL) => -0.0041222242, 0.0550534968),
      (f_assocrisktype_i = NULL) => 0.0172918102, 0.0172918102),
   (f_inq_Communications_count_i > 3.5) => 0.1667999359,
   (f_inq_Communications_count_i = NULL) => 0.0448032509, 0.0193725627),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0281241892,
   (r_D33_eviction_count_i > 3.5) => 0.1076578443,
   (r_D33_eviction_count_i = NULL) => -0.0271908560, -0.0271908560),
(k_nap_phn_verd_d = NULL) => -0.0084957444, -0.0084957444);

// Tree: 26 
woFDN_FL_PSD_lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_employees and c_employees <= 29.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 0.0418457565,
      (k_inq_per_ssn_i > 3.5) => 0.1589795855,
      (k_inq_per_ssn_i = NULL) => 0.0504932204, 0.0504932204),
   (c_employees > 29.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0092672259,
      (f_assocsuspicousidcount_i > 15.5) => 0.1206078349,
      (f_assocsuspicousidcount_i = NULL) => -0.0085652628, -0.0085652628),
   (c_employees = NULL) => 0.0072226789, -0.0025068318),
(r_D30_Derog_Count_i > 11.5) => 0.1094167700,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0587712760,
   (r_S66_adlperssn_count_i > 1.5) => 0.0789508529,
   (r_S66_adlperssn_count_i = NULL) => 0.0100897884, 0.0100897884), -0.0008810970);

// Tree: 27 
woFDN_FL_PSD_lgt_27 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0641859805,
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 25462.5) => 0.1479996744,
         (r_A46_Curr_AVM_AutoVal_d > 25462.5) => 
            map(
            (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 6.5) => 0.1289036160,
            (f_M_Bureau_ADL_FS_noTU_d > 6.5) => -0.0238119063,
            (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0216859362, -0.0216859362),
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0142197318, -0.0170765974),
      (k_inq_per_ssn_i > 2.5) => 0.0448517416,
      (k_inq_per_ssn_i = NULL) => -0.0098416187, -0.0098416187),
   (r_D33_Eviction_Recency_d = NULL) => -0.0085489192, -0.0070434402),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1898494380,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0062672936, -0.0062672936);

// Tree: 28 
woFDN_FL_PSD_lgt_28 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
            map(
            (NULL < c_sfdu_p and c_sfdu_p <= 15.65) => 0.1060420618,
            (c_sfdu_p > 15.65) => -0.0023830378,
            (c_sfdu_p = NULL) => -0.0006122259, 0.0051122232),
         (k_inq_per_ssn_i > 2.5) => 0.0853797392,
         (k_inq_per_ssn_i = NULL) => 0.0134598771, 0.0134598771),
      (f_phone_ver_experian_d > 0.5) => -0.0363436392,
      (f_phone_ver_experian_d = NULL) => 0.0000131145, -0.0129653752),
   (r_D33_eviction_count_i > 0.5) => 0.0566972274,
   (r_D33_eviction_count_i = NULL) => -0.0153932481, -0.0103008251),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1611963926,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0094896440, -0.0094896440);

// Tree: 29 
woFDN_FL_PSD_lgt_29 := map(
(NULL < c_exp_prod and c_exp_prod <= 32.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08567437715) => 0.0203597608,
   (f_add_curr_nhood_VAC_pct_i > 0.08567437715) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 15.65) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 139.5) => -0.0276802745,
         (c_sub_bus > 139.5) => 0.1428259514,
         (c_sub_bus = NULL) => 0.0437192076, 0.0437192076),
      (c_pop_45_54_p > 15.65) => 0.2854575201,
      (c_pop_45_54_p = NULL) => 0.1047185949, 0.1047185949),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0409444706, 0.0409444706),
(c_exp_prod > 32.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => -0.0093844452,
   (f_srchcomponentrisktype_i > 3.5) => 0.0717517111,
   (f_srchcomponentrisktype_i = NULL) => 0.0003034682, -0.0076547044),
(c_exp_prod = NULL) => -0.0253720774, -0.0047368340);

// Tree: 30 
woFDN_FL_PSD_lgt_30 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 17.95) => 0.0618906142,
   (c_white_col > 17.95) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0550371720,
         (r_F00_dob_score_d > 92) => 
            map(
            (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 2.5) => -0.0181301146,
            (f_srchunvrfdphonecount_i > 2.5) => 0.0948470122,
            (f_srchunvrfdphonecount_i = NULL) => -0.0174537355, -0.0174537355),
         (r_F00_dob_score_d = NULL) => -0.0277788563, -0.0158857047),
      (k_comb_age_d > 68.5) => 0.0700202987,
      (k_comb_age_d = NULL) => -0.0101139975, -0.0101139975),
   (c_white_col = NULL) => -0.0251116016, -0.0079481066),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1191753752,
(f_inq_PrepaidCards_count_i = NULL) => 0.0026943593, -0.0073565111);

// Tree: 31 
woFDN_FL_PSD_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1136614141,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0066334532,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0060185012, -0.0060185012),
   (k_comb_age_d > 69.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0235204631) => 0.0050246749,
         (f_add_curr_nhood_BUS_pct_i > 0.0235204631) => 0.1806150589,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1178341395, 0.1178341395),
      (f_phone_ver_experian_d > 0.5) => 0.0815102536,
      (f_phone_ver_experian_d = NULL) => -0.0305219226, 0.0734014382),
   (k_comb_age_d = NULL) => -0.0009921634, -0.0009921634),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1527082769,
(f_inq_PrepaidCards_count_i = NULL) => -0.0016052247, -0.0003549075);

// Tree: 32 
woFDN_FL_PSD_lgt_32 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 12.85) => 0.1297246985,
   (C_INC_100K_P > 12.85) => 0.0139766845,
   (C_INC_100K_P = NULL) => 0.0776769339, 0.0776769339),
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0319278748,
      (f_hh_members_ct_d > 1.5) => -0.0187464802,
      (f_hh_members_ct_d = NULL) => -0.0083577423, -0.0083577423),
   (f_hh_collections_ct_i > 2.5) => 0.0455799543,
   (f_hh_collections_ct_i = NULL) => -0.0032838574, -0.0032838574),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 29.5) => -0.0672755729,
   (k_comb_age_d > 29.5) => 0.0851189148,
   (k_comb_age_d = NULL) => 0.0096473590, 0.0096473590), -0.0022003116);

// Tree: 33 
woFDN_FL_PSD_lgt_33 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.75) => -0.0150397013,
   (c_unemp > 11.75) => 
      map(
      (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.1928186513,
      (f_property_owners_ct_d > 0.5) => -0.0228577938,
      (f_property_owners_ct_d = NULL) => 0.0831526623, 0.0831526623),
   (c_unemp = NULL) => -0.0157904434, -0.0138189468),
(f_rel_criminal_count_i > 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 126.5) => 0.0129936492,
   (r_pb_order_freq_d > 126.5) => -0.0145624007,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1466741492,
      (r_I60_inq_PrepaidCards_recency_d > 61.5) => 0.0514826788,
      (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0559525392, 0.0559525392), 0.0225118580),
(f_rel_criminal_count_i = NULL) => -0.0216266303, -0.0045200813);

// Tree: 34 
woFDN_FL_PSD_lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1104984858,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 132) => 0.0445614696,
      (c_cartheft > 132) => 0.1566496085,
      (c_cartheft = NULL) => 0.0758567335, 0.0758567335),
   (r_F00_dob_score_d > 95) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 5.45) => -0.0111308591,
      (c_hh7p_p > 5.45) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 2.5) => 0.0282470105,
         (r_D30_Derog_Count_i > 2.5) => 0.1466932730,
         (r_D30_Derog_Count_i = NULL) => 0.0430172878, 0.0430172878),
      (c_hh7p_p = NULL) => 0.0027067731, -0.0070538832),
   (r_F00_dob_score_d = NULL) => 0.0252290213, -0.0034476649),
(r_C10_M_Hdr_FS_d = NULL) => -0.0004472610, -0.0027696904);

// Tree: 35 
woFDN_FL_PSD_lgt_35 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0143291852,
      (f_srchvelocityrisktype_i > 4.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 0.0142708139,
         (k_comb_age_d > 66.5) => 0.1668774244,
         (k_comb_age_d = NULL) => 0.0219158464, 0.0219158464),
      (f_srchvelocityrisktype_i = NULL) => -0.0096299168, -0.0096299168),
   (r_P85_Phn_Disconnected_i > 0.5) => 0.1036829150,
   (r_P85_Phn_Disconnected_i = NULL) => -0.0076005162, -0.0076005162),
(f_hh_tot_derog_i > 5.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => 0.1251069894,
   (r_D31_attr_bankruptcy_recency_d > 9) => -0.0157766278,
   (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0762211441, 0.0762211441),
(f_hh_tot_derog_i = NULL) => 0.0050262057, -0.0050914299);

// Tree: 36 
woFDN_FL_PSD_lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0202731946,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 80) => 0.1512761430,
   (r_F00_dob_score_d > 80) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 14.85) => 
            map(
            (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.1134899742,
            (r_D32_Mos_Since_Crim_LS_d > 10.5) => 0.0039216714,
            (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0094292270, 0.0094292270),
         (c_hh6_p > 14.85) => 0.2116410721,
         (c_hh6_p = NULL) => 0.0121352895, 0.0121352895),
      (f_srchcomponentrisktype_i > 3.5) => 0.1207828455,
      (f_srchcomponentrisktype_i = NULL) => 0.0148053713, 0.0148053713),
   (r_F00_dob_score_d = NULL) => 0.0183161543, 0.0166239435),
(f_hh_criminals_i = NULL) => -0.0006649684, -0.0082057713);

// Tree: 37 
woFDN_FL_PSD_lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0100600547,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 87.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 313) => 0.0370007580,
         (r_C13_Curr_Addr_LRes_d > 313) => 0.3006515885,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0508165220, 0.0508165220),
      (c_born_usa > 87.5) => -0.0090522887,
      (c_born_usa = NULL) => 0.0214058232, 0.0214058232),
   (k_nap_contradictory_i > 0.5) => 0.0983034228,
   (k_nap_contradictory_i = NULL) => 0.0274454118, 0.0274454118),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0898427426,
   (r_S66_adlperssn_count_i > 1.5) => 0.1079973142,
   (r_S66_adlperssn_count_i = NULL) => 0.0054801939, 0.0054801939), 0.0017447150);

// Tree: 38 
woFDN_FL_PSD_lgt_38 := map(
(nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0367358823,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 99.5) => 0.1634805106,
      (c_rest_indx > 99.5) => 0.0030366827,
      (c_rest_indx = NULL) => 0.0756397557, 0.0756397557),
   (r_F00_input_dob_match_level_d > 4.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0256169653,
         (f_phone_ver_experian_d > 0.5) => -0.0052879950,
         (f_phone_ver_experian_d = NULL) => -0.0042170372, 0.0049697010),
      (f_inq_PrepaidCards_count_i > 2.5) => 0.1054584197,
      (f_inq_PrepaidCards_count_i = NULL) => 0.0057306012, 0.0057306012),
   (r_F00_input_dob_match_level_d = NULL) => -0.0009758680, 0.0072466814),
(nf_seg_FraudPoint_3_0 = '') => -0.0078152230, -0.0078152230);

// Tree: 39 
woFDN_FL_PSD_lgt_39 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => -0.0053529560,
   (f_srchcomponentrisktype_i > 3.5) => 0.0808580674,
   (f_srchcomponentrisktype_i = NULL) => -0.0124961183, -0.0040811271),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 0.25) => 
         map(
         (NULL < c_finance and c_finance <= 3.65) => 0.3117420429,
         (c_finance > 3.65) => 0.1038792102,
         (c_finance = NULL) => 0.2228974451, 0.2228974451),
      (c_hval_80k_p > 0.25) => 0.0110231507,
      (c_hval_80k_p = NULL) => 0.1437121027, 0.1437121027),
   (f_srchfraudsrchcount_i > 1.5) => 0.0161376004,
   (f_srchfraudsrchcount_i = NULL) => 0.0571583407, 0.0571583407),
(k_inq_per_phone_i = NULL) => -0.0010541546, -0.0010541546);

// Tree: 40 
woFDN_FL_PSD_lgt_40 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0303964619,
      (f_phone_ver_experian_d > 0.5) => -0.0323503758,
      (f_phone_ver_experian_d = NULL) => 0.0123879010, 0.0060119574),
   (f_corrphonelastnamecount_d > 0.5) => -0.0234614902,
   (f_corrphonelastnamecount_d = NULL) => -0.0083030500, -0.0103863186),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => 
      map(
      (NULL < c_construction and c_construction <= 6.25) => 0.0568969126,
      (c_construction > 6.25) => -0.0251819451,
      (c_construction = NULL) => 0.0204639503, 0.0204639503),
   (k_comb_age_d > 63.5) => 0.1872352465,
   (k_comb_age_d = NULL) => 0.0396016400, 0.0396016400),
(k_inq_per_phone_i = NULL) => -0.0077420995, -0.0077420995);

// Tree: 41 
woFDN_FL_PSD_lgt_41 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 
      map(
      (NULL < c_construction and c_construction <= 5.05) => 0.1586508164,
      (c_construction > 5.05) => 0.0159894640,
      (c_construction = NULL) => 0.0776191682, 0.0776191682),
   (r_I60_inq_comm_recency_d > 4.5) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1211130697,
      (f_attr_arrest_recency_d > 48) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0141257434,
         (k_inq_per_phone_i > 1.5) => 0.0279955700,
         (k_inq_per_phone_i = NULL) => -0.0100671704, -0.0100671704),
      (f_attr_arrest_recency_d = NULL) => -0.0094865400, -0.0094865400),
   (r_I60_inq_comm_recency_d = NULL) => -0.0200584662, -0.0086632494),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1156813754,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0081730861, -0.0081730861);

// Tree: 42 
woFDN_FL_PSD_lgt_42 := map(
(NULL < c_employees and c_employees <= 40.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45378.5) => 
      map(
      (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 0.0441285022,
      (f_vardobcountnew_i > 0.5) => 0.1274787629,
      (f_vardobcountnew_i = NULL) => 0.0650025605, 0.0650025605),
   (f_curraddrmedianincome_d > 45378.5) => 0.0097646819,
   (f_curraddrmedianincome_d = NULL) => 0.0299831618, 0.0299831618),
(c_employees > 40.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0105367033,
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 5.5) => 0.2279639864,
      (f_rel_homeover100_count_d > 5.5) => -0.0045147707,
      (f_rel_homeover100_count_d = NULL) => 0.0829643492, 0.0829643492),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0087967060, -0.0087967060),
(c_employees = NULL) => -0.0385302169, -0.0046951953);

// Tree: 43 
woFDN_FL_PSD_lgt_43 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 68.5) => -0.0079131122,
   (r_pb_order_freq_d > 68.5) => -0.0284563090,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 33.55) => 0.0292614891,
      (c_hh2_p > 33.55) => -0.0172554543,
      (c_hh2_p = NULL) => 0.0075148390, 0.0098271696), -0.0070617091),
(k_inq_per_ssn_i > 3.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 80.5) => 0.1494984480,
      (c_born_usa > 80.5) => 0.0115582245,
      (c_born_usa = NULL) => 0.0809733047, 0.0809733047),
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0263409311,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0355623190, 0.0355623190),
(k_inq_per_ssn_i = NULL) => -0.0038863282, -0.0038863282);

// Tree: 44 
woFDN_FL_PSD_lgt_44 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 58.55) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 0.5) => -0.0001245019,
      (f_rel_ageover40_count_d > 0.5) => 0.1200076528,
      (f_rel_ageover40_count_d = NULL) => 0.0525650396, 0.0525650396),
   (c_high_ed > 58.55) => -0.0881816577,
   (c_high_ed = NULL) => 0.0238743667, 0.0238743667),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 4.35) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 14.5) => 0.0152703381,
      (f_srchfraudsrchcount_i > 14.5) => 0.1401177795,
      (f_srchfraudsrchcount_i = NULL) => 0.0171774458, 0.0171774458),
   (c_newhouse > 4.35) => -0.0157660346,
   (c_newhouse = NULL) => -0.0101713321, -0.0058257630),
(r_C10_M_Hdr_FS_d = NULL) => 0.0204654909, -0.0050047958);

// Tree: 45 
woFDN_FL_PSD_lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 0.0106431150,
      (f_inq_PrepaidCards_count_i > 1.5) => 0.1035517737,
      (f_inq_PrepaidCards_count_i = NULL) => 0.0118787289, 0.0118787289),
   (f_historical_count_d > 0.5) => -0.0188588660,
   (f_historical_count_d = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0656083606,
      (k_comb_age_d > 27.5) => 0.0831654817,
      (k_comb_age_d = NULL) => 0.0102371276, 0.0102371276), -0.0033086466),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 171.5) => 0.0412606383,
   (c_sub_bus > 171.5) => 0.2608054291,
   (c_sub_bus = NULL) => 0.0671041965, 0.0671041965),
(k_comb_age_d = NULL) => 0.0016926913, 0.0016926913);

// Tree: 46 
woFDN_FL_PSD_lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 212.75) => 0.0040008443,
      (c_cpiall > 212.75) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 369.5) => 0.0384638365,
         (r_C13_max_lres_d > 369.5) => 0.2328142197,
         (r_C13_max_lres_d = NULL) => 0.0462738983, 0.0462738983),
      (c_cpiall = NULL) => -0.0207047135, 0.0140613117),
   (k_nap_phn_verd_d > 0.5) => -0.0153136116,
   (k_nap_phn_verd_d = NULL) => -0.0037278352, -0.0037278352),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 134.5) => 0.0350118909,
   (c_asian_lang > 134.5) => 0.1990092919,
   (c_asian_lang = NULL) => 0.0836390273, 0.0836390273),
(r_D32_felony_count_i = NULL) => -0.0127045088, -0.0026118429);

// Tree: 47 
woFDN_FL_PSD_lgt_47 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0062218261,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 2.75) => 
         map(
         (NULL < c_trailer_p and c_trailer_p <= 0.15) => 0.1494307024,
         (c_trailer_p > 0.15) => 0.0227086097,
         (c_trailer_p = NULL) => 0.1107369337, 0.1107369337),
      (c_construction > 2.75) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 35.15) => 0.0086012730,
         (c_rnt1000_p > 35.15) => 0.1746687045,
         (c_rnt1000_p = NULL) => 0.0453666706, 0.0453666706),
      (c_construction = NULL) => 0.0669100780, 0.0669100780),
   (f_historical_count_d > 1.5) => -0.0022344054,
   (f_historical_count_d = NULL) => 0.0284584429, 0.0284584429),
(f_rel_felony_count_i = NULL) => -0.0082189938, -0.0012670757);

// Tree: 48 
woFDN_FL_PSD_lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 29850) => 0.0650115932,
   (r_A46_Curr_AVM_AutoVal_d > 29850) => 0.0024823209,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0158853161, -0.0046319967),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 4.75) => -0.0533343727,
   (c_pop_18_24_p > 4.75) => 
      map(
      (NULL < c_employees and c_employees <= 37.5) => 0.1498525940,
      (c_employees > 37.5) => 
         map(
         (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0215248393,
         (f_hh_payday_loan_users_i > 0.5) => 0.1041105115,
         (f_hh_payday_loan_users_i = NULL) => 0.0359924023, 0.0359924023),
      (c_employees = NULL) => 0.0540801721, 0.0540801721),
   (c_pop_18_24_p = NULL) => 0.0318684407, 0.0318684407),
(k_inq_per_phone_i = NULL) => -0.0028307138, -0.0028307138);

// Tree: 49 
woFDN_FL_PSD_lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 
         map(
         (NULL < c_finance and c_finance <= 4.05) => 
            map(
            (NULL < c_hh1_p and c_hh1_p <= 18.55) => 0.2350101691,
            (c_hh1_p > 18.55) => 0.0582115048,
            (c_hh1_p = NULL) => 0.1239719836, 0.1239719836),
         (c_finance > 4.05) => -0.0426920697,
         (c_finance = NULL) => 0.0707224728, 0.0707224728),
      (r_F00_input_dob_match_level_d > 5.5) => -0.0009221910,
      (r_F00_input_dob_match_level_d = NULL) => 0.0006787377, 0.0006787377),
   (f_varrisktype_i > 3.5) => 0.0507664064,
   (f_varrisktype_i = NULL) => 0.0028809859, 0.0028809859),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0688531100,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0002349796, -0.0000379727);

// Tree: 50 
woFDN_FL_PSD_lgt_50 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 217323.5) => 0.1938871886,
   (r_A46_Curr_AVM_AutoVal_d > 217323.5) => 0.0717667999,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0276056010, 0.0702947510),
(f_M_Bureau_ADL_FS_noTU_d > 8.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 10.65) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0125579077,
      (r_C14_Addr_Stability_v2_d > 5.5) => 0.0119667873,
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0019631392, -0.0019631392),
   (c_unemp > 10.65) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 25500) => 0.1531710310,
      (k_estimated_income_d > 25500) => 0.0185485649,
      (k_estimated_income_d = NULL) => 0.0464978658, 0.0464978658),
   (c_unemp = NULL) => 0.0056097233, -0.0006522074),
(f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0297889515, 0.0010507314);

// Tree: 51 
woFDN_FL_PSD_lgt_51 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 126.5) => -0.0070482647,
(r_pb_order_freq_d > 126.5) => -0.0284331431,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 15.15) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0216822136,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0241606145,
         (nf_seg_FraudPoint_3_0 = '') => 0.0024371465, 0.0024371465),
      (c_hh7p_p > 15.15) => 0.1934501259,
      (c_hh7p_p = NULL) => 0.0246969414, 0.0055021010),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < c_retail and c_retail <= 6.65) => 0.1240482796,
      (c_retail > 6.65) => 0.0255212872,
      (c_retail = NULL) => 0.0727702910, 0.0727702910),
   (f_rel_felony_count_i = NULL) => -0.0046230938, 0.0090412976), -0.0051358369);

// Tree: 52 
woFDN_FL_PSD_lgt_52 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0091046413,
      (f_corrphonelastnamecount_d > 0.5) => -0.0228160564,
      (f_corrphonelastnamecount_d = NULL) => -0.0055227650, -0.0084467335),
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 307790.5) => 0.0296247164,
      (f_prevaddrmedianvalue_d > 307790.5) => 0.2231985968,
      (f_prevaddrmedianvalue_d = NULL) => 0.0745615101, 0.0745615101),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0068584866, -0.0068584866),
(k_comb_age_d > 71.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 29.5) => 0.1860291625,
   (c_born_usa > 29.5) => 0.0476312133,
   (c_born_usa = NULL) => 0.0662081192, 0.0662081192),
(k_comb_age_d = NULL) => -0.0033333181, -0.0033333181);

// Tree: 53 
woFDN_FL_PSD_lgt_53 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 134.5) => 
      map(
      (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0150360620,
      (r_D32_felony_count_i > 0.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 14.15) => -0.0095820285,
         (c_pop_25_34_p > 14.15) => 0.1769940128,
         (c_pop_25_34_p = NULL) => 0.0837059922, 0.0837059922),
      (r_D32_felony_count_i = NULL) => -0.0462840513, -0.0139782321),
   (c_easiqlife > 134.5) => 
      map(
      (NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 0.0161896613,
      (f_attr_arrests_i > 0.5) => 0.1213053082,
      (f_attr_arrests_i = NULL) => 0.0177252810, 0.0177252810),
   (c_easiqlife = NULL) => -0.0074461815, -0.0031075539),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0932122811,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0027203004, -0.0027203004);

// Tree: 54 
woFDN_FL_PSD_lgt_54 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 15.5) => -0.0147014703,
   (f_srchphonesrchcount_i > 15.5) => -0.1229559375,
   (f_srchphonesrchcount_i = NULL) => 0.0099559912, -0.0153686490),
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 16.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 1.65) => 0.1947891448,
         (c_hval_750k_p > 1.65) => 0.0103984211,
         (c_hval_750k_p = NULL) => 0.0864068111, 0.0864068111),
      (r_C21_M_Bureau_ADL_FS_d > 7.5) => 0.0066439556,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0081506381, 0.0081506381),
   (f_inq_HighRiskCredit_count_i > 16.5) => 0.1010635958,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0088631203, 0.0088631203),
(f_util_add_curr_conv_n = NULL) => -0.0019165308, -0.0019165308);

// Tree: 55 
woFDN_FL_PSD_lgt_55 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
      map(
      (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 2.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0075090764,
         (f_util_adl_count_n > 6.5) => 0.0796126673,
         (f_util_adl_count_n = NULL) => 0.0121867097, 0.0121867097),
      (f_inq_Banking_count24_i > 2.5) => 
         map(
         (NULL < c_families and c_families <= 405.5) => 0.1752857835,
         (c_families > 405.5) => 0.0241181522,
         (c_families = NULL) => 0.0983277166, 0.0983277166),
      (f_inq_Banking_count24_i = NULL) => 0.0144426424, 0.0144426424),
   (k_estimated_income_d > 34500) => -0.0194223576,
   (k_estimated_income_d = NULL) => -0.0259295801, -0.0078039581),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1027480952,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0073507330, -0.0073507330);

// Tree: 56 
woFDN_FL_PSD_lgt_56 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 2.75) => 0.1694992246,
      (c_hh4_p > 2.75) => 0.0328285073,
      (c_hh4_p = NULL) => 0.0460263234, 0.0460263234),
   (f_hh_age_18_plus_d > 1.5) => 0.0067953949,
   (f_hh_age_18_plus_d = NULL) => 0.0160070505, 0.0160070505),
(f_phone_ver_experian_d > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => -0.0202575486,
   (f_inq_HighRiskCredit_count_i > 1.5) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.25) => 0.0109379472,
      (c_pop_6_11_p > 9.25) => 0.1495571371,
      (c_pop_6_11_p = NULL) => 0.0637117505, 0.0637117505),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0173854465, -0.0173854465),
(f_phone_ver_experian_d = NULL) => -0.0105431035, -0.0051061914);

// Tree: 57 
woFDN_FL_PSD_lgt_57 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => -0.0065158822,
   (r_D30_Derog_Count_i > 11.5) => 
      map(
      (NULL < c_retail and c_retail <= 16.45) => 0.0056015627,
      (c_retail > 16.45) => 0.1469131993,
      (c_retail = NULL) => 0.0576181161, 0.0576181161),
   (r_D30_Derog_Count_i = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0818966902,
      (f_addrs_per_ssn_i > 3.5) => 0.0536917839,
      (f_addrs_per_ssn_i = NULL) => -0.0153579020, -0.0153579020), -0.0057511451),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 36500) => 0.2674506554,
   (k_estimated_income_d > 36500) => 0.0509083845,
   (k_estimated_income_d = NULL) => 0.1206831162, 0.1206831162),
(f_adls_per_phone_c6_i = NULL) => -0.0039570445, -0.0039570445);

// Tree: 58 
woFDN_FL_PSD_lgt_58 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 62.5) => 0.0977331823,
   (f_mos_liens_unrel_SC_fseen_d > 62.5) => -0.0085513513,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0006689699, -0.0073010850),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
         map(
         (NULL < k_nap_nothing_found_i and k_nap_nothing_found_i <= 0.5) => 0.1298814777,
         (k_nap_nothing_found_i > 0.5) => -0.0623799419,
         (k_nap_nothing_found_i = NULL) => 0.0472691490, 0.0472691490),
      (r_Phn_Cell_n > 0.5) => 0.2167213548,
      (r_Phn_Cell_n = NULL) => 0.1077269711, 0.1077269711),
   (f_srchfraudsrchcount_i > 1.5) => 0.0134069730,
   (f_srchfraudsrchcount_i = NULL) => 0.0430589155, 0.0430589155),
(k_inq_per_phone_i = NULL) => -0.0047801074, -0.0047801074);

// Tree: 59 
woFDN_FL_PSD_lgt_59 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0353323137,
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => -0.0027792591,
      (f_idrisktype_i > 1.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 20.95) => 
            map(
            (NULL < f_util_adl_count_n and f_util_adl_count_n <= 0.5) => 0.0970877365,
            (f_util_adl_count_n > 0.5) => -0.0074175315,
            (f_util_adl_count_n = NULL) => 0.0323687381, 0.0323687381),
         (c_pop_35_44_p > 20.95) => 0.1755788476,
         (c_pop_35_44_p = NULL) => -0.0455150443, 0.0378083512),
      (f_idrisktype_i = NULL) => 0.0002414697, 0.0002414697),
   (f_nae_nothing_found_i > 0.5) => 0.1471439811,
   (f_nae_nothing_found_i = NULL) => 0.0019185985, 0.0019185985),
(f_addrs_per_ssn_i = NULL) => -0.0044655941, -0.0044655941);

// Tree: 60 
woFDN_FL_PSD_lgt_60 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 99.5) => 0.0725885796,
   (f_mos_liens_unrel_SC_fseen_d > 99.5) => -0.0078462243,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0064992975, -0.0064992975),
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 2.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0135805162,
      (f_util_adl_count_n > 6.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 5.35) => 0.1963537860,
         (c_unemp > 5.35) => -0.0096057269,
         (c_unemp = NULL) => 0.0963734399, 0.0963734399),
      (f_util_adl_count_n = NULL) => 0.0212081290, 0.0212081290),
   (f_idrisktype_i > 2.5) => 0.1868079609,
   (f_idrisktype_i = NULL) => 0.0299091371, 0.0299091371),
(f_hh_payday_loan_users_i = NULL) => -0.0133666001, -0.0031660622);

// Tree: 61 
woFDN_FL_PSD_lgt_61 := map(
(NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 17.65) => 0.0118951505,
   (C_INC_15K_P > 17.65) => 
      map(
      (NULL < c_manufacturing and c_manufacturing <= 0.6) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 122.5) => 
            map(
            (NULL < c_preschl and c_preschl <= 144.5) => 0.1490922301,
            (c_preschl > 144.5) => -0.0477633693,
            (c_preschl = NULL) => 0.0873564504, 0.0873564504),
         (c_lar_fam > 122.5) => 0.2034091159,
         (c_lar_fam = NULL) => 0.1181356356, 0.1181356356),
      (c_manufacturing > 0.6) => -0.0683675229,
      (c_manufacturing = NULL) => 0.0800605963, 0.0800605963),
   (C_INC_15K_P = NULL) => 0.0232429696, 0.0232429696),
(r_I60_inq_recency_d > 4.5) => -0.0047858042,
(r_I60_inq_recency_d = NULL) => -0.0125834143, -0.0009588613);

// Tree: 62 
woFDN_FL_PSD_lgt_62 := map(
(NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0078129698,
(r_C14_Addr_Stability_v2_d > 5.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1790) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.1118794571,
         (r_F00_dob_score_d > 98) => 0.0294661824,
         (r_F00_dob_score_d = NULL) => 0.0327551526, 0.0327551526),
      (c_med_rent > 1790) => 
         map(
         (NULL < c_unattach and c_unattach <= 76.5) => 0.0513863234,
         (c_unattach > 76.5) => 0.3913807890,
         (c_unattach = NULL) => 0.2148452011, 0.2148452011),
      (c_med_rent = NULL) => -0.0499870797, 0.0369730253),
   (f_phone_ver_insurance_d > 3.5) => -0.0122179992,
   (f_phone_ver_insurance_d = NULL) => 0.0101792632, 0.0101792632),
(r_C14_Addr_Stability_v2_d = NULL) => 0.0539779771, 0.0002148502);

// Tree: 63 
woFDN_FL_PSD_lgt_63 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 5.75) => -0.0786001756,
      (c_hval_300k_p > 5.75) => 0.0677314537,
      (c_hval_300k_p = NULL) => -0.0237258146, -0.0237258146),
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 5.85) => 0.2355787852,
      (c_bigapt_p > 5.85) => 0.0663531074,
      (c_bigapt_p = NULL) => 0.1509659463, 0.1509659463),
   (k_inq_per_ssn_i = NULL) => 0.0456071022, 0.0456071022),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 19.25) => 0.0011176547,
   (c_hval_80k_p > 19.25) => -0.0413861123,
   (c_hval_80k_p = NULL) => 0.0002763744, -0.0016674506),
(r_C10_M_Hdr_FS_d = NULL) => -0.0004847883, -0.0007002445);

// Tree: 64 
woFDN_FL_PSD_lgt_64 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.0736150714,
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => -0.0069269245,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0125546277, -0.0054737284),
(k_comb_age_d > 69.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 23.2) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 60.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.25) => 0.2901368751,
         (c_pop_55_64_p > 12.25) => 0.0002803475,
         (c_pop_55_64_p = NULL) => 0.1547121040, 0.1547121040),
      (f_prevaddrageoldest_d > 60.5) => 0.0171995598,
      (f_prevaddrageoldest_d = NULL) => 0.0416195458, 0.0416195458),
   (C_INC_15K_P > 23.2) => 0.1761603653,
   (C_INC_15K_P = NULL) => 0.0524115902, 0.0524115902),
(k_comb_age_d = NULL) => -0.0019508694, -0.0019508694);

// Tree: 65 
woFDN_FL_PSD_lgt_65 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 547) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.35) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 160.5) => -0.0199297962,
      (c_lar_fam > 160.5) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 844.5) => 0.1983415704,
         (c_popover18 > 844.5) => 0.0225593146,
         (c_popover18 = NULL) => 0.0591556204, 0.0591556204),
      (c_lar_fam = NULL) => -0.0154460448, -0.0154460448),
   (c_hh4_p > 12.35) => 0.0164227243,
   (c_hh4_p = NULL) => -0.0030239315, 0.0027443988),
(r_C10_M_Hdr_FS_d > 547) => 0.1743375790,
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0909071906,
   (k_comb_age_d > 26.5) => 0.0688472198,
   (k_comb_age_d = NULL) => -0.0110299854, -0.0110299854), 0.0037564009);

// Tree: 66 
woFDN_FL_PSD_lgt_66 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 23.5) => -0.0034738064,
      (f_srchphonesrchcount_i > 23.5) => -0.1003078310,
      (f_srchphonesrchcount_i = NULL) => -0.0039084520, -0.0039084520),
   (r_D33_eviction_count_i > 3.5) => 0.0793098569,
   (r_D33_eviction_count_i = NULL) => -0.0169508549, -0.0034409516),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 2.5) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 176.5) => 0.0063804732,
      (c_blue_empl > 176.5) => 0.1394423045,
      (c_blue_empl = NULL) => 0.0177084817, 0.0177084817),
   (f_srchphonesrchcount_i > 2.5) => 0.1250371387,
   (f_srchphonesrchcount_i = NULL) => 0.0296729877, 0.0296729877),
(k_nap_contradictory_i = NULL) => -0.0009923213, -0.0009923213);

// Tree: 67 
woFDN_FL_PSD_lgt_67 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0038523006,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 61.55) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 34095.5) => 0.1771930923,
      (c_med_hhinc > 34095.5) => 
         map(
         (NULL < k_nap_nothing_found_i and k_nap_nothing_found_i <= 0.5) => 0.0181015208,
         (k_nap_nothing_found_i > 0.5) => 
            map(
            (NULL < c_for_sale and c_for_sale <= 157.5) => 0.1420764442,
            (c_for_sale > 157.5) => -0.0547353324,
            (c_for_sale = NULL) => 0.0958211419, 0.0958211419),
         (k_nap_nothing_found_i = NULL) => 0.0368823201, 0.0368823201),
      (c_med_hhinc = NULL) => 0.0445624887, 0.0445624887),
   (c_low_ed > 61.55) => -0.0323949781,
   (c_low_ed = NULL) => 0.0274328398, 0.0274328398),
(f_hh_collections_ct_i = NULL) => -0.0192441679, -0.0008873494);

// Tree: 68 
woFDN_FL_PSD_lgt_68 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 306.5) => -0.0027365276,
(r_C13_Curr_Addr_LRes_d > 306.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 2.25) => 0.1274251708,
      (c_newhouse > 2.25) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 8015) => -0.0747491425,
         (r_A49_Curr_AVM_Chg_1yr_i > 8015) => 0.1214211571,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0540810216, -0.0059556089),
      (c_newhouse = NULL) => 0.0320953571, 0.0320953571),
   (f_srchunvrfdphonecount_i > 0.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 92.5) => 0.0361402898,
      (c_serv_empl > 92.5) => 0.2690229379,
      (c_serv_empl = NULL) => 0.1502984506, 0.1502984506),
   (f_srchunvrfdphonecount_i = NULL) => 0.0480687481, 0.0480687481),
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0210867632, 0.0002293632);

// Tree: 69 
woFDN_FL_PSD_lgt_69 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0964432156,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => -0.0060622625,
      (k_inq_per_ssn_i > 10.5) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 21.5) => 0.1501821929,
         (c_hh1_p > 21.5) => -0.0187608554,
         (c_hh1_p = NULL) => 0.0564535154, 0.0564535154),
      (k_inq_per_ssn_i = NULL) => -0.0053094864, -0.0053094864),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 7.5) => -0.0166153924,
      (f_rel_count_i > 7.5) => 0.2143202304,
      (f_rel_count_i = NULL) => 0.0916356808, 0.0916356808),
   (f_nae_nothing_found_i = NULL) => -0.0040719543, -0.0040719543),
(f_attr_arrest_recency_d = NULL) => -0.0155106028, -0.0037227053);

// Tree: 70 
woFDN_FL_PSD_lgt_70 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0057479230,
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 0.35) => 0.1410974560,
   (C_INC_150K_P > 0.35) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.85) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 224.5) => 0.0413798174,
         (r_C13_Curr_Addr_LRes_d > 224.5) => 0.2267463018,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0600964333, 0.0600964333),
      (c_pop_6_11_p > 8.85) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 80168.5) => 0.0545706481,
         (f_prevaddrmedianvalue_d > 80168.5) => -0.0567296474,
         (f_prevaddrmedianvalue_d = NULL) => -0.0361443263, -0.0361443263),
      (c_pop_6_11_p = NULL) => 0.0234117202, 0.0234117202),
   (C_INC_150K_P = NULL) => 0.0300731770, 0.0300731770),
(k_nap_contradictory_i = NULL) => -0.0031217013, -0.0031217013);

// Tree: 71 
woFDN_FL_PSD_lgt_71 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 1.65) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => -0.0048176178,
   (f_inq_QuizProvider_count_i > 5.5) => 0.1198176725,
   (f_inq_QuizProvider_count_i = NULL) => -0.0123268452, -0.0034916786),
(c_hh7p_p > 1.65) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 13.5) => 0.0148898586,
   (f_rel_ageover30_count_d > 13.5) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 5.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 11.95) => 0.0564681021,
         (c_hval_250k_p > 11.95) => 0.2701114965,
         (c_hval_250k_p = NULL) => 0.1153208107, 0.1153208107),
      (f_rel_incomeover75_count_d > 5.5) => -0.0101467802,
      (f_rel_incomeover75_count_d = NULL) => 0.0514252783, 0.0514252783),
   (f_rel_ageover30_count_d = NULL) => 0.0856993484, 0.0229173672),
(c_hh7p_p = NULL) => -0.0237623204, 0.0026402952);

// Tree: 72 
woFDN_FL_PSD_lgt_72 := map(
(NULL < r_P85_Phn_Invalid_i and r_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0267624470,
         (f_phone_ver_experian_d > 0.5) => -0.0244675711,
         (f_phone_ver_experian_d = NULL) => 0.0102132050, 0.0052974384),
      (f_corrphonelastnamecount_d > 0.5) => -0.0157755521,
      (f_corrphonelastnamecount_d = NULL) => -0.0067220860, -0.0067220860),
   (f_assocsuspicousidcount_i > 15.5) => 0.0999395671,
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 113.5) => -0.0779683388,
      (c_relig_indx > 113.5) => 0.0640171514,
      (c_relig_indx = NULL) => -0.0036581757, -0.0036581757), -0.0061778520),
(r_P85_Phn_Invalid_i > 0.5) => -0.0762877289,
(r_P85_Phn_Invalid_i = NULL) => -0.0078414762, -0.0078414762);

// Tree: 73 
woFDN_FL_PSD_lgt_73 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 188.5) => -0.0087437499,
      (c_unempl > 188.5) => 0.0868759696,
      (c_unempl = NULL) => 0.0069334484, -0.0072204012),
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 0.0903801295,
      (r_F00_input_dob_match_level_d > 5.5) => 0.0068149999,
      (r_F00_input_dob_match_level_d = NULL) => 0.0083677838, 0.0083677838),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0006079917, -0.0006079917),
(f_inq_PrepaidCards_count_i > 1.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1019.5) => 0.1167153059,
   (c_popover25 > 1019.5) => 0.0011473821,
   (c_popover25 = NULL) => 0.0584968781, 0.0584968781),
(f_inq_PrepaidCards_count_i = NULL) => -0.0023024663, 0.0000172593);

// Tree: 74 
woFDN_FL_PSD_lgt_74 := map(
(NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 107.5) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0150947063,
      (f_util_add_curr_conv_n > 0.5) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 0.0492594365,
         (r_C14_Addr_Stability_v2_d > 1.5) => 0.0143446376,
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0165546228, 0.0165546228),
      (f_util_add_curr_conv_n = NULL) => 0.0028693524, 0.0028693524),
   (c_medi_indx > 107.5) => -0.0229734865,
   (c_medi_indx = NULL) => 0.0397858860, -0.0042081148),
(f_srchphonesrchcountwk_i > 0.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 0.3) => -0.0356120469,
   (c_bigapt_p > 0.3) => 0.1472641191,
   (c_bigapt_p = NULL) => 0.0669094401, 0.0669094401),
(f_srchphonesrchcountwk_i = NULL) => 0.0179594608, -0.0032855941);

// Tree: 75 
woFDN_FL_PSD_lgt_75 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134.5) => 
   map(
   (NULL < c_employees and c_employees <= 40.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 156.5) => 0.0056219379,
      (c_robbery > 156.5) => 
         map(
         (NULL < c_bargains and c_bargains <= 112) => 0.2114351504,
         (c_bargains > 112) => 0.0362689439,
         (c_bargains = NULL) => 0.1102469049, 0.1102469049),
      (c_robbery = NULL) => 0.0260124234, 0.0260124234),
   (c_employees > 40.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 80) => -0.0770185849,
      (r_F00_dob_score_d > 80) => -0.0155597424,
      (r_F00_dob_score_d = NULL) => -0.0627809429, -0.0184913311),
   (c_employees = NULL) => -0.0305205184, -0.0130554916),
(f_prevaddrageoldest_d > 134.5) => 0.0159305001,
(f_prevaddrageoldest_d = NULL) => -0.0253266456, -0.0029721016);

// Tree: 76 
woFDN_FL_PSD_lgt_76 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_professional and c_professional <= 3.05) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 2) => 0.1358767994,
      (r_F00_input_dob_match_level_d > 2) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 0.0543559435,
         (k_estimated_income_d > 32500) => 0.0113478166,
         (k_estimated_income_d = NULL) => 0.0260272371, 0.0260272371),
      (r_F00_input_dob_match_level_d = NULL) => 0.0283272698, 0.0283272698),
   (c_professional > 3.05) => -0.0022550354,
   (c_professional = NULL) => -0.0172343714, 0.0089998474),
(f_historical_count_d > 0.5) => -0.0153177183,
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.75) => 0.0561812920,
   (c_pop_18_24_p > 7.75) => -0.0329746941,
   (c_pop_18_24_p = NULL) => 0.0083612631, 0.0083612631), -0.0032423143);

// Tree: 77 
woFDN_FL_PSD_lgt_77 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0137742970,
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.55) => 0.0087815521,
   (c_unemp > 8.55) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 114.5) => -0.0155182644,
      (f_curraddrmurderindex_i > 114.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 279.5) => 
            map(
            (NULL < c_pop_12_17_p and c_pop_12_17_p <= 7.5) => 0.2869027866,
            (c_pop_12_17_p > 7.5) => 0.0796586633,
            (c_pop_12_17_p = NULL) => 0.1525993324, 0.1525993324),
         (r_C21_M_Bureau_ADL_FS_d > 279.5) => -0.0223719889,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.1049445416, 0.1049445416),
      (f_curraddrmurderindex_i = NULL) => 0.0526055294, 0.0526055294),
   (c_unemp = NULL) => 0.0434757292, 0.0119732323),
(f_util_add_curr_conv_n = NULL) => 0.0005334944, 0.0005334944);

// Tree: 78 
woFDN_FL_PSD_lgt_78 := map(
(NULL < c_easiqlife and c_easiqlife <= 121.5) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 77.1) => -0.0166404406,
   (c_high_hval > 77.1) => 0.1029056073,
   (c_high_hval = NULL) => -0.0128701951, -0.0128701951),
(c_easiqlife > 121.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
         map(
         (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => -0.0574017367,
         (f_mos_inq_banko_om_lseen_d > 5.5) => 0.0238802800,
         (f_mos_inq_banko_om_lseen_d = NULL) => 0.0195198301, 0.0195198301),
      (f_varrisktype_i > 4.5) => 0.1023972701,
      (f_varrisktype_i = NULL) => 0.0212450998, 0.0212450998),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0725034606,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0166652293, 0.0166652293),
(c_easiqlife = NULL) => -0.0151677331, -0.0002558488);

// Tree: 79 
woFDN_FL_PSD_lgt_79 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => -0.0095682038,
   (f_srchcomponentrisktype_i > 3.5) => 0.0696342128,
   (f_srchcomponentrisktype_i = NULL) => -0.0081387577, -0.0081387577),
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0407232132) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 61.5) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 9.75) => 0.0532306867,
         (c_rnt1250_p > 9.75) => 0.2061462873,
         (c_rnt1250_p = NULL) => 0.1019299226, 0.1019299226),
      (r_I61_inq_collection_recency_d > 61.5) => 0.0338522029,
      (r_I61_inq_collection_recency_d = NULL) => 0.0527099685, 0.0527099685),
   (f_add_curr_nhood_BUS_pct_i > 0.0407232132) => -0.0023666763,
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0345542155, 0.0229441664),
(f_inq_Communications_count_i = NULL) => -0.0032550988, -0.0052246806);

// Tree: 80 
woFDN_FL_PSD_lgt_80 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => -0.0129302569,
      (f_inq_HighRiskCredit_count_i > 4.5) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 14.5) => 0.0988486507,
         (f_rel_educationover12_count_d > 14.5) => -0.0396497644,
         (f_rel_educationover12_count_d = NULL) => 0.0509356855, 0.0509356855),
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0112906233, -0.0112906233),
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 6.5) => 0.0962319248,
      (r_F00_input_dob_match_level_d > 6.5) => 0.0102885057,
      (r_F00_input_dob_match_level_d = NULL) => 0.0129808265, 0.0129808265),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0010055843, -0.0010055843),
(f_rel_felony_count_i > 4.5) => 0.0816883940,
(f_rel_felony_count_i = NULL) => 0.0087995170, -0.0005084150);

// Tree: 81 
woFDN_FL_PSD_lgt_81 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 22.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 
      map(
      (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0124153202,
      (f_inq_Other_count_i > 0.5) => 
         map(
         (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 59.5) => 0.1614868381,
         (f_mos_liens_unrel_SC_fseen_d > 59.5) => 0.0169298292,
         (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0195610089, 0.0195610089),
      (f_inq_Other_count_i = NULL) => -0.0053343870, -0.0053343870),
   (k_inq_per_phone_i > 6.5) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 73.7) => 0.0034265719,
      (c_oldhouse > 73.7) => 0.1307301802,
      (c_oldhouse = NULL) => 0.0745044199, 0.0745044199),
   (k_inq_per_phone_i = NULL) => -0.0045631516, -0.0045631516),
(f_srchphonesrchcount_i > 22.5) => -0.1174970939,
(f_srchphonesrchcount_i = NULL) => -0.0189599925, -0.0051786167);

// Tree: 82 
woFDN_FL_PSD_lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 41.65) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => -0.0102511168,
      (f_srchphonesrchcount_i > 1.5) => 0.0224990056,
      (f_srchphonesrchcount_i = NULL) => -0.0032800311, -0.0032800311),
   (c_hval_500k_p > 41.65) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 153.5) => 0.0314756250,
      (f_prevaddrageoldest_d > 153.5) => 0.3080496807,
      (f_prevaddrageoldest_d = NULL) => 0.1046864045, 0.1046864045),
   (c_hval_500k_p = NULL) => -0.0042498347, -0.0015355415),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 7.25) => -0.0008138585,
   (c_pop_12_17_p > 7.25) => -0.1181331707,
   (c_pop_12_17_p = NULL) => -0.0723053144, -0.0723053144),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0250455786, -0.0020380119);

// Tree: 83 
woFDN_FL_PSD_lgt_83 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0097786664,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
      map(
      (NULL < c_employees and c_employees <= 342.5) => 0.1729592895,
      (c_employees > 342.5) => 0.0131992247,
      (c_employees = NULL) => 0.0915431026, 0.0915431026),
   (r_C10_M_Hdr_FS_d > 10.5) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 41.5) => 
         map(
         (NULL < c_unattach and c_unattach <= 153.5) => 0.0110615266,
         (c_unattach > 153.5) => 0.0817669931,
         (c_unattach = NULL) => 0.1347172524, 0.0166535803),
      (f_rel_ageover20_count_d > 41.5) => -0.1049549237,
      (f_rel_ageover20_count_d = NULL) => -0.0633689690, 0.0144198054),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0160149409, 0.0160149409),
(k_inq_per_ssn_i = NULL) => 0.0006668804, 0.0006668804);

// Tree: 84 
woFDN_FL_PSD_lgt_84 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 7.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 12.5) => -0.0062772713,
      (f_srchphonesrchcount_i > 12.5) => -0.0812503386,
      (f_srchphonesrchcount_i = NULL) => -0.0072641691, -0.0072641691),
   (r_C14_Addr_Stability_v2_d > 5.5) => 0.0110608416,
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0004382229, 0.0004382229),
(f_hh_tot_derog_i > 7.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 36.45) => -0.0174275517,
   (c_med_age > 36.45) => 0.1831607519,
   (c_med_age = NULL) => 0.0863856932, 0.0863856932),
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.1003042995,
   (k_comb_age_d > 25.5) => 0.1076333377,
   (k_comb_age_d = NULL) => 0.0075878707, 0.0075878707), 0.0012771525);

// Tree: 85 
woFDN_FL_PSD_lgt_85 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 41.55) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 7.5) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 2.75) => -0.0265731528,
         (c_femdiv_p > 2.75) => 0.0368181793,
         (c_femdiv_p = NULL) => 0.0223046542, 0.0223046542),
      (r_I60_Inq_Count12_i > 7.5) => -0.1255939988,
      (r_I60_Inq_Count12_i = NULL) => 0.0194656000, 0.0194656000),
   (f_hh_age_18_plus_d > 1.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 16.5) => -0.0577626945,
      (f_mos_inq_banko_om_fseen_d > 16.5) => -0.0067774834,
      (f_mos_inq_banko_om_fseen_d = NULL) => -0.0099019102, -0.0099019102),
   (f_hh_age_18_plus_d = NULL) => 0.0048393253, -0.0031611541),
(c_hval_80k_p > 41.55) => -0.0938816271,
(c_hval_80k_p = NULL) => 0.0179449621, -0.0034714614);

// Tree: 86 
woFDN_FL_PSD_lgt_86 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 4.75) => 0.0138582838,
   (c_pop_85p_p > 4.75) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 0.0522450034,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 0.2102692031,
      (nf_seg_FraudPoint_3_0 = '') => 0.0979297246, 0.0979297246),
   (c_pop_85p_p = NULL) => 0.0494155055, 0.0220711033),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 4.5) => -0.0099467833,
   (r_S66_adlperssn_count_i > 4.5) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 63.45) => 0.2158965847,
      (c_sfdu_p > 63.45) => 0.0173338643,
      (c_sfdu_p = NULL) => 0.0846826232, 0.0846826232),
   (r_S66_adlperssn_count_i = NULL) => -0.0083133106, -0.0083133106),
(f_hh_members_ct_d = NULL) => -0.0094214478, -0.0024532929);

// Tree: 87 
woFDN_FL_PSD_lgt_87 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 24.55) => -0.0100118829,
   (c_famotf18_p > 24.55) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 31.95) => 0.0002073958,
      (c_rnt1000_p > 31.95) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 109.5) => 
            map(
            (NULL < c_assault and c_assault <= 76) => 0.2551454302,
            (c_assault > 76) => 0.0674370299,
            (c_assault = NULL) => 0.1297296406, 0.1297296406),
         (c_relig_indx > 109.5) => 0.0042297846,
         (c_relig_indx = NULL) => 0.0843511616, 0.0843511616),
      (c_rnt1000_p = NULL) => 0.0210519676, 0.0210519676),
   (c_famotf18_p = NULL) => 0.0026484365, -0.0062120337),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0920299913,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0058247968, -0.0058247968);

// Tree: 88 
woFDN_FL_PSD_lgt_88 := map(
(NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 2.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0045856134,
   (k_inq_per_ssn_i > 1.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.05) => 
         map(
         (NULL < k_inq_lnames_per_ssn_i and k_inq_lnames_per_ssn_i <= 0.5) => 0.1009910505,
         (k_inq_lnames_per_ssn_i > 0.5) => 0.0072808259,
         (k_inq_lnames_per_ssn_i = NULL) => 0.0249971868, 0.0249971868),
      (c_unemp > 9.05) => 
         map(
         (NULL < c_young and c_young <= 27.15) => 0.0348374273,
         (c_young > 27.15) => 0.1875151077,
         (c_young = NULL) => 0.0994318306, 0.0994318306),
      (c_unemp = NULL) => 0.0288038365, 0.0288038365),
   (k_inq_per_ssn_i = NULL) => 0.0022534780, 0.0022534780),
(f_srchphonesrchcountmo_i > 2.5) => -0.1042841641,
(f_srchphonesrchcountmo_i = NULL) => -0.0265907966, 0.0016448098);

// Tree: 89 
woFDN_FL_PSD_lgt_89 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 20.15) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 4.6) => 0.2408018998,
         (c_femdiv_p > 4.6) => 0.0147775944,
         (c_femdiv_p = NULL) => 0.1267335587, 0.1267335587),
      (r_F00_dob_score_d > 98) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 134.5) => -0.0036772406,
         (c_easiqlife > 134.5) => 0.0741688845,
         (c_easiqlife = NULL) => 0.0210181492, 0.0210181492),
      (r_F00_dob_score_d = NULL) => 0.0252153843, 0.0252153843),
   (r_C14_addrs_10yr_i > 0.5) => -0.0065086767,
   (r_C14_addrs_10yr_i = NULL) => 0.0226663265, 0.0012125230),
(c_hval_80k_p > 20.15) => -0.0413539893,
(c_hval_80k_p = NULL) => 0.0089296902, -0.0011385451);

// Tree: 90 
woFDN_FL_PSD_lgt_90 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.0973110016,
   (r_D32_Mos_Since_Fel_LS_d > 117) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.4) => -0.0054249976,
      (r_C12_source_profile_d > 81.4) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 149.5) => 0.0163668163,
         (c_sub_bus > 149.5) => 
            map(
            (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.3625413867,
            (f_inq_count_i > 2.5) => 0.0234119107,
            (f_inq_count_i = NULL) => 0.2130039799, 0.2130039799),
         (c_sub_bus = NULL) => 0.0489260338, 0.0489260338),
      (r_C12_source_profile_d = NULL) => -0.0020302370, -0.0020302370),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0014994241, -0.0014994241),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0915089083,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0128513304, -0.0019711265);

// Tree: 91 
woFDN_FL_PSD_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_health and c_health <= 2.35) => 0.1577567255,
   (c_health > 2.35) => 0.0379483805,
   (c_health = NULL) => 0.0732190615, 0.0732190615),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0097853939,
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 25.5) => 0.1395769004,
      (c_born_usa > 25.5) => 0.0185133871,
      (c_born_usa = NULL) => 0.0330468220, 0.0330468220),
   (k_comb_age_d = NULL) => -0.0068167559, -0.0068167559),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 11.35) => -0.0472011392,
   (c_rnt1000_p > 11.35) => 0.0735372794,
   (c_rnt1000_p = NULL) => 0.0137657850, 0.0137657850), -0.0052804710);

// Tree: 92 
woFDN_FL_PSD_lgt_92 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => -0.0343881027,
(f_mos_inq_banko_om_fseen_d > 21.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 33.95) => -0.0056515169,
         (c_fammar18_p > 33.95) => 0.1284740196,
         (c_fammar18_p = NULL) => 0.0593393935, 0.0593393935),
      (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0002517712,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0034120823, 0.0034120823),
   (r_D30_Derog_Count_i > 11.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.8) => 0.0008081338,
      (c_pop_45_54_p > 13.8) => 0.1419916354,
      (c_pop_45_54_p = NULL) => 0.0719306496, 0.0719306496),
   (r_D30_Derog_Count_i = NULL) => 0.0041950848, 0.0041950848),
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0199363893, 0.0013863845);

// Tree: 93 
woFDN_FL_PSD_lgt_93 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.12874731295) => -0.0033327547,
   (f_add_curr_nhood_BUS_pct_i > 0.12874731295) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 15.85) => 0.0007945594,
      (c_hh3_p > 15.85) => 
         map(
         (NULL < c_hval_500k_p and c_hval_500k_p <= 20.15) => 0.0468771807,
         (c_hval_500k_p > 20.15) => 0.2066092285,
         (c_hval_500k_p = NULL) => 0.0717243881, 0.0717243881),
      (c_hh3_p = NULL) => 0.0311545051, 0.0311545051),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0009982440, 0.0012798200),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < c_employees and c_employees <= 146.5) => -0.0193047249,
   (c_employees > 146.5) => 0.1231156702,
   (c_employees = NULL) => 0.0579776600, 0.0579776600),
(r_D33_eviction_count_i = NULL) => 0.0093623731, 0.0019182236);

// Tree: 94 
woFDN_FL_PSD_lgt_94 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 19.25) => 0.0141445388,
   (C_INC_50K_P > 19.25) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 88.5) => 0.2294485524,
      (f_curraddrmurderindex_i > 88.5) => 0.0490619830,
      (f_curraddrmurderindex_i = NULL) => 0.1063000291, 0.1063000291),
   (C_INC_50K_P = NULL) => 0.0092921378, 0.0261108372),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 27.5) => -0.1276530053,
   (f_mos_liens_unrel_OT_fseen_d > 27.5) => -0.0017962196,
   (f_mos_liens_unrel_OT_fseen_d = NULL) => -0.0025119460, -0.0025119460),
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0624459804,
   (c_rnt1000_p > 10.8) => 0.0609887631,
   (c_rnt1000_p = NULL) => -0.0058245384, -0.0058245384), 0.0028155650);

// Tree: 95 
woFDN_FL_PSD_lgt_95 := map(
(NULL < c_incollege and c_incollege <= 5.95) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 5.5) => -0.0142932048,
   (f_srchfraudsrchcountyr_i > 5.5) => -0.1135773900,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0153056826, -0.0153056826),
(c_incollege > 5.95) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0041834655,
   (f_hh_collections_ct_i > 1.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 2.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 14.55) => 0.0260039468,
         (C_INC_150K_P > 14.55) => 0.2226648669,
         (C_INC_150K_P = NULL) => 0.0337161397, 0.0337161397),
      (f_srchfraudsrchcountyr_i > 2.5) => 0.1067350020,
      (f_srchfraudsrchcountyr_i = NULL) => 0.0379922284, 0.0379922284),
   (f_hh_collections_ct_i = NULL) => -0.0033690814, 0.0071419076),
(c_incollege = NULL) => 0.0150536532, -0.0041876611);

// Tree: 96 
woFDN_FL_PSD_lgt_96 := map(
(NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00478183075) => -0.0386101905,
   (f_add_curr_nhood_BUS_pct_i > 0.00478183075) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 38.5) => 0.1639952263,
         (f_mos_inq_banko_cm_lseen_d > 38.5) => 0.0315957429,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0505752889, 0.0505752889),
      (f_corrssnnamecount_d > 1.5) => 
         map(
         (NULL < f_srchcountwk_i and f_srchcountwk_i <= 0.5) => -0.0032198763,
         (f_srchcountwk_i > 0.5) => 0.0665678646,
         (f_srchcountwk_i = NULL) => -0.0018812903, -0.0018812903),
      (f_corrssnnamecount_d = NULL) => 0.0009870032, 0.0009870032),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0309650904, -0.0046978309),
(f_assoccredbureaucountmo_i > 0.5) => 0.1344281618,
(f_assoccredbureaucountmo_i = NULL) => 0.0177332576, -0.0037858017);

// Tree: 97 
woFDN_FL_PSD_lgt_97 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 32.85) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 9.35) => 0.0529290653,
      (c_vacant_p > 9.35) => 0.2231659115,
      (c_vacant_p = NULL) => 0.1082289325, 0.1082289325),
   (c_high_ed > 32.85) => -0.0215088849,
   (c_high_ed = NULL) => 0.0380491190, 0.0380491190),
(r_C10_M_Hdr_FS_d > 13.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0046338826,
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1419027340,
      (r_A50_pb_average_dollars_d > 99) => -0.0156273838,
      (r_A50_pb_average_dollars_d = NULL) => 0.0550751100, 0.0550751100),
   (r_D33_eviction_count_i = NULL) => -0.0040143024, -0.0040143024),
(r_C10_M_Hdr_FS_d = NULL) => 0.0063065903, -0.0027805998);

// Tree: 98 
woFDN_FL_PSD_lgt_98 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 21.65) => 
      map(
      (NULL < c_professional and c_professional <= 7.35) => -0.0577396936,
      (c_professional > 7.35) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 162.5) => 0.1693723880,
         (c_asian_lang > 162.5) => -0.0000044383,
         (c_asian_lang = NULL) => 0.0822643059, 0.0822643059),
      (c_professional = NULL) => 0.0078871812, 0.0078871812),
   (c_famotf18_p > 21.65) => 0.1705581541,
   (c_famotf18_p = NULL) => 0.0385353355, 0.0385353355),
(r_C21_M_Bureau_ADL_FS_d > 8.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => -0.0031135640,
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0701830632,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0053296125, -0.0053296125),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0313015834, -0.0041112734);

// Tree: 99 
woFDN_FL_PSD_lgt_99 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0787455004,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 0.5) => -0.0033859361,
   (f_hh_age_65_plus_d > 0.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 250.95) => 0.0170110965,
      (c_housingcpi > 250.95) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => 0.1990331388,
         (f_rel_incomeover50_count_d > 4.5) => 0.0382399018,
         (f_rel_incomeover50_count_d = NULL) => 0.0969643884, 0.0969643884),
      (c_housingcpi = NULL) => -0.0278892181, 0.0223835783),
   (f_hh_age_65_plus_d = NULL) => 0.0020792017, 0.0020792017),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 93.5) => 0.0476231625,
   (c_apt20 > 93.5) => -0.0410142598,
   (c_apt20 = NULL) => 0.0033044514, 0.0033044514), 0.0024699134);

// Tree: 100 
woFDN_FL_PSD_lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < c_larceny and c_larceny <= 153.5) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 131) => 0.0353726483,
         (f_curraddrmurderindex_i > 131) => -0.0874573351,
         (f_curraddrmurderindex_i = NULL) => 0.0104095108, 0.0104095108),
      (c_larceny > 153.5) => 0.1483783908,
      (c_larceny = NULL) => 0.0397592544, 0.0397592544),
   (r_I60_inq_comm_recency_d > 549) => 0.0032237905,
   (r_I60_inq_comm_recency_d = NULL) => 0.0065361039, 0.0065361039),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 35.85) => -0.0133392369,
   (c_famotf18_p > 35.85) => -0.0641519389,
   (c_famotf18_p = NULL) => -0.0275997073, -0.0156983828),
(f_historical_count_d = NULL) => 0.0304213437, -0.0044607182);

// Tree: 101 
woFDN_FL_PSD_lgt_101 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0050518325,
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 2.5) => -0.0258859060,
      (c_high_hval > 2.5) => 
         map(
         (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0156558527,
         (r_E57_br_source_count_d > 0.5) => 0.3192206789,
         (r_E57_br_source_count_d = NULL) => 0.1730598366, 0.1730598366),
      (c_high_hval = NULL) => 0.0749496074, 0.0749496074),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0035823922, -0.0035823922),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 303) => -0.0277141748,
   (r_C13_max_lres_d > 303) => 0.2194942302,
   (r_C13_max_lres_d = NULL) => 0.0875486398, 0.0875486398),
(k_comb_age_d = NULL) => -0.0024113746, -0.0024113746);

// Tree: 102 
woFDN_FL_PSD_lgt_102 := map(
(NULL < c_hh4_p and c_hh4_p <= 11.55) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 1.5) => -0.0125817272,
   (r_I60_inq_hiRiskCred_count12_i > 1.5) => -0.0782615536,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0134702304, -0.0134702304),
(c_hh4_p > 11.55) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.3) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 5.5) => 0.0081649849,
      (r_E57_br_source_count_d > 5.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 326.5) => 0.2185915224,
         (r_C10_M_Hdr_FS_d > 326.5) => 0.0179419289,
         (r_C10_M_Hdr_FS_d = NULL) => 0.1134317957, 0.1134317957),
      (r_E57_br_source_count_d = NULL) => 0.0101338566, 0.0105056332),
   (c_pop_0_5_p > 19.3) => 0.1940159722,
   (c_pop_0_5_p = NULL) => 0.0118877803, 0.0118877803),
(c_hh4_p = NULL) => 0.0056697118, 0.0021912457);

// Tree: 103 
woFDN_FL_PSD_lgt_103 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
         map(
         (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.0195618656,
         (k_nap_fname_verd_d > 0.5) => 0.1922061380,
         (k_nap_fname_verd_d = NULL) => 0.0617097631, 0.0617097631),
      (r_C10_M_Hdr_FS_d > 15.5) => -0.0019599468,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0008282061, -0.0008282061),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0532603062,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0030048387, -0.0030048387),
(f_rel_felony_count_i > 4.5) => 0.0671555290,
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0732885802,
   (k_comb_age_d > 27.5) => 0.0554929085,
   (k_comb_age_d = NULL) => -0.0076829161, -0.0076829161), -0.0026180454);

// Tree: 104 
woFDN_FL_PSD_lgt_104 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 198.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 6.5) => 0.1207642645,
      (r_C13_max_lres_d > 6.5) => -0.0020876881,
      (r_C13_max_lres_d = NULL) => -0.0170505862, -0.0014180248),
   (c_serv_empl > 198.5) => 0.1489786206,
   (c_serv_empl = NULL) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 15.5) => 0.1479392731,
      (r_C13_Curr_Addr_LRes_d > 15.5) => -0.0422715780,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0072327370, -0.0072327370), -0.0006838100),
(k_inq_per_phone_i > 6.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 12.15) => 0.1252980828,
   (c_newhouse > 12.15) => 0.0056571086,
   (c_newhouse = NULL) => 0.0621335933, 0.0621335933),
(k_inq_per_phone_i = NULL) => 0.0001233825, 0.0001233825);

// Tree: 105 
woFDN_FL_PSD_lgt_105 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
   map(
   (NULL < c_larceny and c_larceny <= 54.5) => -0.0207287275,
   (c_larceny > 54.5) => 
      map(
      (NULL < k_inf_fname_verd_d and k_inf_fname_verd_d <= 0.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.16849280695) => 0.0316297176,
         (f_add_curr_nhood_VAC_pct_i > 0.16849280695) => 
            map(
            (NULL < c_bargains and c_bargains <= 172.5) => 0.0727197780,
            (c_bargains > 172.5) => 0.2212803093,
            (c_bargains = NULL) => 0.1067512654, 0.1067512654),
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0399197474, 0.0399197474),
      (k_inf_fname_verd_d > 0.5) => -0.0311998926,
      (k_inf_fname_verd_d = NULL) => 0.0258122272, 0.0258122272),
   (c_larceny = NULL) => -0.0099115840, 0.0126481206),
(k_estimated_income_d > 32500) => -0.0096407776,
(k_estimated_income_d = NULL) => -0.0296962479, -0.0033822799);

// Tree: 106 
woFDN_FL_PSD_lgt_106 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.45) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 50.85) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 11.05) => -0.0042480633,
      (c_hh6_p > 11.05) => 
         map(
         (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 0.1608112190,
         (r_Prop_Owner_History_d > 1.5) => 
            map(
            (NULL < c_hval_1000k_p and c_hval_1000k_p <= 0.75) => -0.0624033740,
            (c_hval_1000k_p > 0.75) => 0.2064759311,
            (c_hval_1000k_p = NULL) => 0.0194966442, 0.0194966442),
         (r_Prop_Owner_History_d = NULL) => 0.0658740143, 0.0658740143),
      (c_hh6_p = NULL) => -0.0027512233, -0.0027512233),
   (c_hval_500k_p > 50.85) => 0.1306270326,
   (c_hval_500k_p = NULL) => -0.0018088887, -0.0018088887),
(c_hh6_p > 17.45) => -0.1210783531,
(c_hh6_p = NULL) => -0.0284808229, -0.0030561516);

// Tree: 107 
woFDN_FL_PSD_lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0786227932,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 163827.5) => -0.0102678501,
      (f_curraddrmedianvalue_d > 163827.5) => 0.1129485100,
      (f_curraddrmedianvalue_d = NULL) => 0.0525483335, 0.0525483335),
   (r_F00_dob_score_d > 65) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 19.5) => 0.0830145006,
      (k_comb_age_d > 19.5) => -0.0018853783,
      (k_comb_age_d = NULL) => -0.0010138472, -0.0010138472),
   (r_F00_dob_score_d = NULL) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 42.05) => -0.0538757720,
      (c_hh2_p > 42.05) => 0.0921587529,
      (c_hh2_p = NULL) => -0.0325710004, -0.0325710004), -0.0016492656),
(f_attr_arrest_recency_d = NULL) => 0.0017188700, -0.0010508384);

// Tree: 108 
woFDN_FL_PSD_lgt_108 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00940018095) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 1.5) => 0.1994528714,
   (f_phone_ver_insurance_d > 1.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1319420526) => 0.0121077245,
      (f_add_curr_nhood_BUS_pct_i > 0.1319420526) => 0.1857157730,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0222630700, 0.0222630700),
   (f_phone_ver_insurance_d = NULL) => 0.0330290326, 0.0330290326),
(f_add_curr_nhood_MFD_pct_i > 0.00940018095) => 0.0045834621,
(f_add_curr_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0273569326,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 80.05) => 0.1734934604,
      (c_fammar_p > 80.05) => -0.0343258667,
      (c_fammar_p = NULL) => 0.0552222987, 0.0552222987),
   (f_util_adl_count_n = NULL) => -0.0020167423, -0.0216022400), 0.0019520260);

// Tree: 109 
woFDN_FL_PSD_lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 12.5) => 0.0082702447,
   (f_inq_HighRiskCredit_count_i > 12.5) => 0.0820507390,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0086609083, 0.0086609083),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 21.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => -0.0076820920,
      (f_srchvelocityrisktype_i > 2.5) => -0.1237344448,
      (f_srchvelocityrisktype_i = NULL) => -0.0792728291, -0.0792728291),
   (f_mos_inq_banko_cm_lseen_d > 21.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 19.5) => 0.0622836013,
      (r_C13_Curr_Addr_LRes_d > 19.5) => -0.0311189411,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0031524822, -0.0031524822),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0266917059, -0.0266917059),
(r_D33_eviction_count_i = NULL) => 0.0159759165, 0.0073306678);

// Tree: 110 
woFDN_FL_PSD_lgt_110 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 74.5) => -0.0116475520,
(f_prevaddrcartheftindex_i > 74.5) => 
   map(
   (NULL < c_totsales and c_totsales <= 396398.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 14.5) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 89.15) => 0.0126483935,
         (c_lowrent > 89.15) => 0.1541001838,
         (c_lowrent = NULL) => 0.0158265186, 0.0158265186),
      (f_rel_educationover12_count_d > 14.5) => 
         map(
         (NULL < c_assault and c_assault <= 178.5) => -0.0139655133,
         (c_assault > 178.5) => -0.1294969053,
         (c_assault = NULL) => -0.0234647611, -0.0234647611),
      (f_rel_educationover12_count_d = NULL) => -0.0174325902, 0.0100466402),
   (c_totsales > 396398.5) => 0.1783284716,
   (c_totsales = NULL) => 0.0585282546, 0.0122652767),
(f_prevaddrcartheftindex_i = NULL) => -0.0316579305, 0.0008507839);

// Tree: 111 
woFDN_FL_PSD_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2119129411,
   (r_C12_source_profile_d > 57.95) => -0.0451336010,
   (r_C12_source_profile_d = NULL) => 0.0823933656, 0.0823933656),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 35.85) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0072091983,
      (k_inq_per_ssn_i > 0.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0416600700,
         (f_phone_ver_experian_d > 0.5) => -0.0012432258,
         (f_phone_ver_experian_d = NULL) => 0.0140321968, 0.0133543494),
      (k_inq_per_ssn_i = NULL) => 0.0013582369, 0.0013582369),
   (c_hval_60k_p > 35.85) => -0.0844735429,
   (c_hval_60k_p = NULL) => -0.0119720772, 0.0003660475),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0041247850, 0.0011690692);

// Tree: 112 
woFDN_FL_PSD_lgt_112 := map(
(NULL < c_easiqlife and c_easiqlife <= 93.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 4.5) => 0.1399487612,
   (c_no_teens > 4.5) => -0.0218158209,
   (c_no_teens = NULL) => -0.0190812292, -0.0190812292),
(c_easiqlife > 93.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < f_adl_util_inf_n and f_adl_util_inf_n <= 0.5) => 0.0147290408,
      (f_adl_util_inf_n > 0.5) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => 0.3078387986,
         (f_rel_incomeover50_count_d > 4.5) => 0.0015403708,
         (f_rel_incomeover50_count_d = NULL) => 0.1405329347, 0.1405329347),
      (f_adl_util_inf_n = NULL) => 0.0184183940, 0.0184183940),
   (f_phone_ver_insurance_d > 3.5) => -0.0065269417,
   (f_phone_ver_insurance_d = NULL) => 0.0333221009, 0.0063595560),
(c_easiqlife = NULL) => 0.0159716871, -0.0018388275);

// Tree: 113 
woFDN_FL_PSD_lgt_113 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 21.5) => -0.0903234106,
(f_mos_inq_banko_am_fseen_d > 21.5) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 32.15) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 13.15) => -0.0255423875,
      (c_rnt750_p > 13.15) => 0.1730554621,
      (c_rnt750_p = NULL) => 0.0771226025, 0.0771226025),
   (c_civ_emp > 32.15) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 20.5) => -0.0063480960,
      (f_rel_educationover8_count_d > 20.5) => 0.0240292554,
      (f_rel_educationover8_count_d = NULL) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 0.1097500642,
         (r_C14_Addr_Stability_v2_d > 1.5) => -0.0215629652,
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0183458967, 0.0183458967), -0.0035548576),
   (c_civ_emp = NULL) => 0.0334764454, -0.0018966843),
(f_mos_inq_banko_am_fseen_d = NULL) => 0.0309705233, -0.0031658275);

// Tree: 114 
woFDN_FL_PSD_lgt_114 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0966321535,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < c_young and c_young <= 65.05) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 45.5) => -0.0054152975,
      (f_rel_educationover8_count_d > 45.5) => -0.0926481578,
      (f_rel_educationover8_count_d = NULL) => 
         map(
         (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0588686955,
         (k_inf_nothing_found_i > 0.5) => 0.0632805209,
         (k_inf_nothing_found_i = NULL) => 0.0022059127, 0.0022059127), -0.0058086787),
   (c_young > 65.05) => -0.1218562223,
   (c_young = NULL) => -0.0067887782, -0.0067887782),
(C_INC_100K_P = NULL) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0234679833,
   (f_vardobcountnew_i > 0.5) => 0.1517040285,
   (f_vardobcountnew_i = NULL) => 0.0062028461, 0.0062028461), -0.0059668223);

// Tree: 115 
woFDN_FL_PSD_lgt_115 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0622250077,
(r_D33_Eviction_Recency_d > 30) => 
   map(
   (NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
      map(
      (NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 
         map(
         (NULL < f_liens_rel_O_total_amt_i and f_liens_rel_O_total_amt_i <= 29.5) => 0.0063393746,
         (f_liens_rel_O_total_amt_i > 29.5) => -0.1275135307,
         (f_liens_rel_O_total_amt_i = NULL) => 0.0051704276, 0.0051704276),
      (k_inf_phn_verd_d > 0.5) => -0.0228366177,
      (k_inf_phn_verd_d = NULL) => -0.0049911609, -0.0049911609),
   (f_assoccredbureaucountmo_i > 0.5) => 0.1097137116,
   (f_assoccredbureaucountmo_i = NULL) => -0.0043747153, -0.0043747153),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.45) => -0.0625351612,
   (c_rnt1000_p > 10.45) => 0.0468942342,
   (c_rnt1000_p = NULL) => -0.0144239615, -0.0144239615), -0.0039552543);

// Tree: 116 
woFDN_FL_PSD_lgt_116 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 71.5) => -0.1262833530,
   (f_mos_liens_rel_SC_lseen_d > 71.5) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0068088698,
         (r_F04_curr_add_occ_index_d > 2) => 0.0185134167,
         (r_F04_curr_add_occ_index_d = NULL) => -0.0011945007, -0.0011945007),
      (k_inq_adls_per_phone_i > 3.5) => -0.0808160757,
      (k_inq_adls_per_phone_i = NULL) => -0.0015295866, -0.0015295866),
   (f_mos_liens_rel_SC_lseen_d = NULL) => 0.0041195205, -0.0019836791),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 16.25) => 0.0305542819,
   (C_INC_50K_P > 16.25) => 0.2145582474,
   (C_INC_50K_P = NULL) => 0.0860638581, 0.0860638581),
(f_adls_per_phone_c6_i = NULL) => -0.0007342856, -0.0007342856);

// Tree: 117 
woFDN_FL_PSD_lgt_117 := map(
(NULL < c_born_usa and c_born_usa <= 1.5) => 0.1278876455,
(c_born_usa > 1.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 9.65) => -0.0996553627,
         (c_famotf18_p > 9.65) => 
            map(
            (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 1.5) => 0.1171285751,
            (f_mos_inq_banko_om_fseen_d > 1.5) => -0.0185167640,
            (f_mos_inq_banko_om_fseen_d = NULL) => 0.0139815985, 0.0139815985),
         (c_famotf18_p = NULL) => -0.0379054668, -0.0379054668),
      (r_D33_eviction_count_i > 0.5) => -0.0891554835,
      (r_D33_eviction_count_i = NULL) => -0.0442587747, -0.0442587747),
   (f_mos_inq_banko_om_lseen_d > 5.5) => 0.0029347057,
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0163679290, 0.0004710259),
(c_born_usa = NULL) => 0.0110407080, 0.0014835603);

// Tree: 118 
woFDN_FL_PSD_lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
   map(
   (NULL < c_young and c_young <= 32.85) => -0.0003776515,
   (c_young > 32.85) => -0.0348344333,
   (c_young = NULL) => -0.0136516642, -0.0052933671),
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 46.2) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.01071143635) => 0.0934949230,
      (f_add_curr_nhood_BUS_pct_i > 0.01071143635) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 39.95) => -0.0539054035,
         (c_rnt750_p > 39.95) => 0.0813700215,
         (c_rnt750_p = NULL) => -0.0155653098, -0.0155653098),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0074431782, 0.0074431782),
   (c_newhouse > 46.2) => 0.1551843948,
   (c_newhouse = NULL) => 0.0367036139, 0.0367036139),
(f_srchunvrfdaddrcount_i = NULL) => -0.0203860344, -0.0043576638);

// Tree: 119 
woFDN_FL_PSD_lgt_119 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0070085134,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 23.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 39.5) => 0.0732708969,
      (r_A50_pb_total_dollars_d > 39.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 151.5) => -0.0672722442,
         (c_relig_indx > 151.5) => 0.0322780967,
         (c_relig_indx = NULL) => -0.0387461231, -0.0387461231),
      (r_A50_pb_total_dollars_d = NULL) => -0.0194050549, -0.0194050549),
   (f_rel_homeover50_count_d > 23.5) => -0.1331554953,
   (f_rel_homeover50_count_d = NULL) => -0.0351515001, -0.0351515001),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.55) => -0.0771288985,
   (c_pop_55_64_p > 11.55) => 0.0340207936,
   (c_pop_55_64_p = NULL) => -0.0241510079, -0.0241510079), 0.0051230333);

// Tree: 120 
woFDN_FL_PSD_lgt_120 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 25.85) => -0.0782485825,
   (c_fammar_p > 25.85) => -0.0037186400,
   (c_fammar_p = NULL) => -0.0326878425, -0.0052562716),
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 26.7) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 9.75) => 0.0990324590,
         (c_vacant_p > 9.75) => -0.0166947745,
         (c_vacant_p = NULL) => 0.0439713536, 0.0439713536),
      (c_hval_100k_p > 26.7) => 0.1523155578,
      (c_hval_100k_p = NULL) => 0.0586485241, 0.0586485241),
   (k_estimated_income_d > 28500) => 0.0098633342,
   (k_estimated_income_d = NULL) => 0.0209935452, 0.0209935452),
(f_rel_felony_count_i = NULL) => 0.0091039313, -0.0013879582);

// Tree: 121 
woFDN_FL_PSD_lgt_121 := map(
(NULL < c_white_col and c_white_col <= 16.15) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 14.5) => 0.1249104502,
   (f_prevaddrlenofres_d > 14.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 105.5) => -0.1083317398,
      (c_no_labfor > 105.5) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 60.2) => 0.1110418875,
         (c_lowrent > 60.2) => -0.0282269253,
         (c_lowrent = NULL) => 0.0588160827, 0.0588160827),
      (c_no_labfor = NULL) => 0.0015736777, 0.0015736777),
   (f_prevaddrlenofres_d = NULL) => 0.0360592885, 0.0360592885),
(c_white_col > 16.15) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 86.25) => -0.0019016819,
   (c_low_ed > 86.25) => -0.1106488864,
   (c_low_ed = NULL) => -0.0023606828, -0.0023606828),
(c_white_col = NULL) => 0.0102941119, -0.0011385834);

// Tree: 122 
woFDN_FL_PSD_lgt_122 := map(
(NULL < c_popover25 and c_popover25 <= 327.5) => -0.1139313954,
(c_popover25 > 327.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => -0.0011498048,
      (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 0.0717915703,
      (r_C14_Addrs_Per_ADL_c6_i = NULL) => 0.0032737792, 0.0000445032),
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 5.75) => 0.1885579845,
      (c_pop_6_11_p > 5.75) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 87.5) => -0.0809889682,
         (r_A50_pb_average_dollars_d > 87.5) => 0.0919931843,
         (r_A50_pb_average_dollars_d = NULL) => 0.0097732723, 0.0097732723),
      (c_pop_6_11_p = NULL) => 0.0524191670, 0.0524191670),
   (r_P85_Phn_Disconnected_i = NULL) => 0.0009739030, 0.0009739030),
(c_popover25 = NULL) => -0.0016540446, 0.0001298327);

// Tree: 123 
woFDN_FL_PSD_lgt_123 := map(
(NULL < c_low_ed and c_low_ed <= 75.25) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 17.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 73.05) => 0.0031550490,
      (c_low_ed > 73.05) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => 0.0044068257,
         (f_rel_homeover300_count_d > 0.5) => 0.1836408996,
         (f_rel_homeover300_count_d = NULL) => 0.0875808077, 0.0875808077),
      (c_low_ed = NULL) => 0.0042844665, 0.0042844665),
   (f_inq_HighRiskCredit_count_i > 17.5) => 0.0796507120,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0197780568, 0.0047822284),
(c_low_ed > 75.25) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 72.65) => -0.0248694550,
   (c_lowinc > 72.65) => -0.1276127696,
   (c_lowinc = NULL) => -0.0361408735, -0.0361408735),
(c_low_ed = NULL) => 0.0137802284, 0.0034835922);

// Tree: 124 
woFDN_FL_PSD_lgt_124 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 10.5) => 
      map(
      (NULL < r_I60_inq_mortgage_count12_i and r_I60_inq_mortgage_count12_i <= 0.5) => 0.0012833175,
      (r_I60_inq_mortgage_count12_i > 0.5) => -0.0729407014,
      (r_I60_inq_mortgage_count12_i = NULL) => -0.0014243864, -0.0014243864),
   (f_rel_under25miles_cnt_d > 10.5) => -0.0896754632,
   (f_rel_under25miles_cnt_d = NULL) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.2654528774) => 0.0794072209,
      (f_add_curr_nhood_MFD_pct_i > 0.2654528774) => -0.0524117131,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0126451073, -0.0126451073), -0.0020650196),
(f_inq_QuizProvider_count_i > 5.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0238460881,
   (f_inq_Collection_count_i > 1.5) => 0.1801033528,
   (f_inq_Collection_count_i = NULL) => 0.0706002973, 0.0706002973),
(f_inq_QuizProvider_count_i = NULL) => 0.0137773200, -0.0010940845);

// Tree: 125 
woFDN_FL_PSD_lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 345.5) => -0.0083621970,
   (r_C21_M_Bureau_ADL_FS_d > 345.5) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 143.5) => 0.0153092332,
      (c_totcrime > 143.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.06633808995) => 0.2577908228,
         (f_add_curr_nhood_MFD_pct_i > 0.06633808995) => 0.0558579730,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1073714551, 0.1073714551),
      (c_totcrime = NULL) => 0.0288073241, 0.0288073241),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0129166479, -0.0039854707),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 0.5) => 0.0162182939,
   (r_C20_email_domain_free_count_i > 0.5) => 0.2694946987,
   (r_C20_email_domain_free_count_i = NULL) => 0.0945800545, 0.0945800545),
(f_nae_nothing_found_i = NULL) => -0.0025712865, -0.0025712865);

// Tree: 126 
woFDN_FL_PSD_lgt_126 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 2.25) => -0.1211237202,
(c_pop_35_44_p > 2.25) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 169.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 0.0117685868,
      (f_hh_collections_ct_i > 5.5) => 0.1132329215,
      (f_hh_collections_ct_i = NULL) => -0.0216204553, 0.0121505232),
   (c_new_homes > 169.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 7.5) => -0.0995450211,
      (f_mos_inq_banko_cm_lseen_d > 7.5) => -0.0170068956,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0199189008, -0.0199189008),
   (c_new_homes = NULL) => 0.0052246341, 0.0052246341),
(c_pop_35_44_p = NULL) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 51.5) => 0.1323083456,
   (r_C12_source_profile_d > 51.5) => -0.0151697605,
   (r_C12_source_profile_d = NULL) => 0.0102238207, 0.0102238207), 0.0044487886);

// Tree: 127 
woFDN_FL_PSD_lgt_127 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < c_highinc and c_highinc <= 0.55) => -0.0436174792,
   (c_highinc > 0.55) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.95) => 
         map(
         (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 10.5) => 0.0015757728,
         (f_srchssnsrchcount_i > 10.5) => 
            map(
            (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.64188384425) => 0.0326729397,
            (f_add_curr_nhood_SFD_pct_d > 0.64188384425) => -0.0728817194,
            (f_add_curr_nhood_SFD_pct_d = NULL) => -0.0397073979, -0.0397073979),
         (f_srchssnsrchcount_i = NULL) => 0.0008406985, 0.0008406985),
      (c_pop_6_11_p > 15.95) => 0.1416226461,
      (c_pop_6_11_p = NULL) => 0.0015532780, 0.0015532780),
   (c_highinc = NULL) => -0.0165692027, -0.0002188340),
(f_assocsuspicousidcount_i > 16.5) => 0.0839039875,
(f_assocsuspicousidcount_i = NULL) => -0.0276247898, 0.0000177799);

// Tree: 128 
woFDN_FL_PSD_lgt_128 := map(
(NULL < c_rich_blk and c_rich_blk <= 186.5) => -0.0014336920,
(c_rich_blk > 186.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 14.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 11.35) => -0.0237639617,
      (c_rnt750_p > 11.35) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 171.5) => 0.0341806088,
         (c_serv_empl > 171.5) => 0.1426969476,
         (c_serv_empl = NULL) => 0.0492756173, 0.0492756173),
      (c_rnt750_p = NULL) => 0.0119823375, 0.0119823375),
   (f_rel_ageover30_count_d > 14.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 20.3) => 0.0346525893,
      (c_highrent > 20.3) => 0.1985821116,
      (c_highrent = NULL) => 0.0991780396, 0.0991780396),
   (f_rel_ageover30_count_d = NULL) => 0.0228384912, 0.0228384912),
(c_rich_blk = NULL) => -0.0142532560, 0.0011962781);

// Tree: 129 
woFDN_FL_PSD_lgt_129 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 52.35) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0142220719,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 2.45) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 20.95) => 0.0235757719,
         (C_INC_25K_P > 20.95) => 0.1343855007,
         (C_INC_25K_P = NULL) => 0.0260568853, 0.0260568853),
      (c_low_hval > 2.45) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 11.75) => 0.0674647200,
         (c_fammar18_p > 11.75) => -0.0229024042,
         (c_fammar18_p = NULL) => -0.0166353329, -0.0166353329),
      (c_low_hval = NULL) => 0.0069887183, 0.0069887183),
   (k_inf_nothing_found_i = NULL) => -0.0055950058, -0.0055950058),
(c_hval_500k_p > 52.35) => 0.0930833562,
(c_hval_500k_p = NULL) => 0.0361308110, -0.0039747915);

// Tree: 130 
woFDN_FL_PSD_lgt_130 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.35) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 83.5) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 2.5) => -0.0004448306,
      (r_I60_Inq_Count12_i > 2.5) => -0.0285755037,
      (r_I60_Inq_Count12_i = NULL) => 0.0104119043, -0.0032552395),
   (k_comb_age_d > 83.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 7.05) => 0.1926423195,
      (c_hval_250k_p > 7.05) => -0.0239846086,
      (c_hval_250k_p = NULL) => 0.0727238415, 0.0727238415),
   (k_comb_age_d = NULL) => -0.0025624399, -0.0025624399),
(c_hh6_p > 17.35) => -0.0964042875,
(c_hh6_p = NULL) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => -0.0105689221,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity']) => 0.1538177285,
   (nf_seg_FraudPoint_3_0 = '') => 0.0185305781, 0.0185305781), -0.0026188369);

// Tree: 131 
woFDN_FL_PSD_lgt_131 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 22.35) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 5175.5) => -0.0218775039,
   (r_A49_Curr_AVM_Chg_1yr_i > 5175.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 9.5) => 0.0160774107,
      (f_inq_Collection_count_i > 9.5) => 0.1367869979,
      (f_inq_Collection_count_i = NULL) => 0.0193473764, 0.0193473764),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0038597368, -0.0018377752),
(C_INC_50K_P > 22.35) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 24.95) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 73.5) => 0.1266094575,
      (r_D32_Mos_Since_Crim_LS_d > 73.5) => 0.0085575617,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0219339456, 0.0219339456),
   (c_hval_250k_p > 24.95) => 0.1770338218,
   (c_hval_250k_p = NULL) => 0.0376687156, 0.0376687156),
(C_INC_50K_P = NULL) => 0.0069574719, 0.0003126109);

// Tree: 132 
woFDN_FL_PSD_lgt_132 := map(
(NULL < c_food and c_food <= 89.35) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0016169890,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2084366690,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 3.5) => 0.1038292875,
         (c_born_usa > 3.5) => 0.0047111947,
         (c_born_usa = NULL) => 0.0068165352, 0.0068165352),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0610180565,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0043637699, 0.0023406040), 0.0013463112),
(c_food > 89.35) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 39500) => 0.1265121944,
   (k_estimated_income_d > 39500) => -0.0115272197,
   (k_estimated_income_d = NULL) => 0.0647577197, 0.0647577197),
(c_food = NULL) => -0.0373482226, 0.0011716189);

// Tree: 133 
woFDN_FL_PSD_lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 1.95) => -0.0025403063,
   (c_hval_500k_p > 1.95) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 8.95) => 0.0476732859,
      (c_rnt750_p > 8.95) => 0.2576024724,
      (c_rnt750_p = NULL) => 0.1536771325, 0.1536771325),
   (c_hval_500k_p = NULL) => 0.0705058109, 0.0705058109),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 134.5) => 0.0045769350,
   (c_medi_indx > 134.5) => -0.0498458430,
   (c_medi_indx = NULL) => 0.0116684571, 0.0015425532),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0502599789,
   (r_S66_adlperssn_count_i > 1.5) => 0.0719950325,
   (r_S66_adlperssn_count_i = NULL) => 0.0120661053, 0.0120661053), 0.0028069150);

// Tree: 134 
woFDN_FL_PSD_lgt_134 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 24.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 11.05) => -0.0007410068,
   (c_hh6_p > 11.05) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0380056065,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0869934237,
      (nf_seg_FraudPoint_3_0 = '') => 0.0422176517, 0.0422176517),
   (c_hh6_p = NULL) => 0.0029857821, 0.0005529395),
(f_rel_homeover100_count_d > 24.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 37.5) => -0.1397996193,
   (f_mos_inq_banko_om_lseen_d > 37.5) => -0.0223906763,
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0466707127, -0.0466707127),
(f_rel_homeover100_count_d = NULL) => 
   map(
   (NULL < c_murders and c_murders <= 32.5) => 0.1079739784,
   (c_murders > 32.5) => -0.0172069736,
   (c_murders = NULL) => 0.0047196263, 0.0047196263), -0.0006551101);

// Tree: 135 
woFDN_FL_PSD_lgt_135 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 163.5) => -0.0171002673,
   (f_M_Bureau_ADL_FS_noTU_d > 163.5) => 
      map(
      (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.1960942371,
         (r_D30_Derog_Count_i > 1.5) => -0.0690996715,
         (r_D30_Derog_Count_i = NULL) => 0.1104415461, 0.1104415461),
      (f_adl_per_email_i > 0.5) => -0.0701574458,
      (f_adl_per_email_i = NULL) => 0.0068350327, 0.0079594080),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0062649403, -0.0015712635),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < c_unattach and c_unattach <= 80.5) => -0.0700849163,
   (c_unattach > 80.5) => 0.1797445912,
   (c_unattach = NULL) => 0.0848726263, 0.0848726263),
(f_adls_per_phone_c6_i = NULL) => -0.0004672895, -0.0004672895);

// Tree: 136 
woFDN_FL_PSD_lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 3.485) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 208.5) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 94681) => 0.2061890465,
         (f_prevaddrmedianvalue_d > 94681) => 0.0525823186,
         (f_prevaddrmedianvalue_d = NULL) => 0.0892645223, 0.0892645223),
      (c_cpiall > 208.5) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 3.65) => -0.0084657953,
         (c_pop_85p_p > 3.65) => 0.0750420043,
         (c_pop_85p_p = NULL) => 0.0036398623, 0.0036398623),
      (c_cpiall = NULL) => 0.0139117552, 0.0139117552),
   (c_hhsize > 3.485) => 0.1231992636,
   (c_hhsize = NULL) => 0.0634815634, 0.0198830693),
(f_hh_members_ct_d > 1.5) => -0.0064258196,
(f_hh_members_ct_d = NULL) => 0.0004446534, -0.0013991718);

// Tree: 137 
woFDN_FL_PSD_lgt_137 := map(
(NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3104075971) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 26.75) => 0.0219538084,
      (c_hval_100k_p > 26.75) => 0.1649551630,
      (c_hval_100k_p = NULL) => 0.0312938787, 0.0277284414),
   (r_Ever_Asset_Owner_d > 0.5) => -0.0013735802,
   (r_Ever_Asset_Owner_d = NULL) => 0.0040079842, 0.0040079842),
(f_add_curr_mobility_index_i > 0.3104075971) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 32894) => 
      map(
      (NULL < c_retired and c_retired <= 3.6) => -0.0179344355,
      (c_retired > 3.6) => 0.1685700584,
      (c_retired = NULL) => 0.0693970339, 0.0693970339),
   (c_med_hval > 32894) => -0.0228099890,
   (c_med_hval = NULL) => -0.0195907912, -0.0195907912),
(f_add_curr_mobility_index_i = NULL) => 0.0075273867, -0.0027098834);

// Tree: 138 
woFDN_FL_PSD_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 156.5) => -0.0034022117,
   (c_easiqlife > 156.5) => 0.0380937071,
   (c_easiqlife = NULL) => -0.0151151008, -0.0001692855),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 97) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 54.45) => -0.0041581354,
         (c_sfdu_p > 54.45) => 0.1729116269,
         (c_sfdu_p = NULL) => 0.0826741519, 0.0826741519),
      (c_rest_indx > 97) => -0.0672929820,
      (c_rest_indx = NULL) => 0.0029618916, 0.0029618916),
   (f_vardobcountnew_i > 0.5) => 0.1337357140,
   (f_vardobcountnew_i = NULL) => 0.0403859115, 0.0403859115),
(f_curraddrcrimeindex_i = NULL) => -0.0210433617, 0.0006686829);

// Tree: 139 
woFDN_FL_PSD_lgt_139 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 8.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 60.5) => 0.1478333398,
   (f_mos_inq_banko_cm_lseen_d > 60.5) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 74) => 0.0905776541,
      (c_old_homes > 74) => -0.0963199371,
      (c_old_homes = NULL) => 0.0079635015, 0.0079635015),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0470980676, 0.0470980676),
(r_D32_Mos_Since_Crim_LS_d > 8.5) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 54.95) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 297.45) => 0.0002761657,
      (c_oldhouse > 297.45) => 0.1225769228,
      (c_oldhouse = NULL) => 0.0011756124, 0.0011756124),
   (C_RENTOCC_P > 54.95) => -0.0232244100,
   (C_RENTOCC_P = NULL) => -0.0248349319, -0.0031868152),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0215572059, -0.0022325265);

// Tree: 140 
woFDN_FL_PSD_lgt_140 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0112044829,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 37.25) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.55) => -0.0292538754,
         (c_pop_6_11_p > 9.55) => 
            map(
            (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.1549284637,
            (k_nap_phn_verd_d > 0.5) => 0.0171558432,
            (k_nap_phn_verd_d = NULL) => 0.0675824233, 0.0675824233),
         (c_pop_6_11_p = NULL) => -0.0018676394, -0.0018676394),
      (c_med_age > 37.25) => 0.1004167659,
      (c_med_age = NULL) => 0.0438361286, 0.0438361286),
   (f_hh_members_ct_d > 1.5) => 0.0055202983,
   (f_hh_members_ct_d = NULL) => 0.0128548527, 0.0128548527),
(k_inq_per_ssn_i = NULL) => -0.0013569409, -0.0013569409);

// Tree: 141 
woFDN_FL_PSD_lgt_141 := map(
(NULL < c_lowinc and c_lowinc <= 72.85) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => -0.0082438646,
      (r_I60_inq_hiRiskCred_count12_i > 2.5) => -0.0973713415,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0088565649, -0.0088565649),
   (f_hh_collections_ct_i > 1.5) => 
      map(
      (NULL < c_med_inc and c_med_inc <= 16.5) => 0.1109664691,
      (c_med_inc > 16.5) => 0.0120926118,
      (c_med_inc = NULL) => 0.0146984078, 0.0146984078),
   (f_hh_collections_ct_i = NULL) => 0.0028095223, -0.0022439719),
(c_lowinc > 72.85) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 10.1) => -0.0089124313,
   (c_pop_0_5_p > 10.1) => -0.1193618905,
   (c_pop_0_5_p = NULL) => -0.0515040528, -0.0515040528),
(c_lowinc = NULL) => -0.0269671003, -0.0034773955);

// Tree: 142 
woFDN_FL_PSD_lgt_142 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0110636418,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13592516195) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 107.5) => -0.0054497057,
         (c_no_labfor > 107.5) => 0.0491547333,
         (c_no_labfor = NULL) => 0.0143638213, 0.0143638213),
      (f_add_curr_nhood_BUS_pct_i > 0.13592516195) => 
         map(
         (NULL < c_unempl and c_unempl <= 96.5) => 0.0122642574,
         (c_unempl > 96.5) => 0.1257324479,
         (c_unempl = NULL) => 0.0769890703, 0.0769890703),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0433618104, 0.0242691541),
   (f_corrrisktype_i = NULL) => 0.0091080787, 0.0091080787),
(f_phone_ver_experian_d > 0.5) => -0.0064009555,
(f_phone_ver_experian_d = NULL) => -0.0107613580, -0.0023364951);

// Tree: 143 
woFDN_FL_PSD_lgt_143 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 31.9) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < c_child and c_child <= 33.55) => 0.0042451529,
      (c_child > 33.55) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 193.5) => 
            map(
            (NULL < c_low_ed and c_low_ed <= 68.85) => -0.0392227083,
            (c_low_ed > 68.85) => -0.1163328661,
            (c_low_ed = NULL) => -0.0500598116, -0.0500598116),
         (c_span_lang > 193.5) => 0.0696935624,
         (c_span_lang = NULL) => -0.0370745060, -0.0370745060),
      (c_child = NULL) => 0.0014124680, 0.0014124680),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.0771347332,
   (f_inq_PrepaidCards_count_i = NULL) => 0.0073869397, 0.0017805714),
(c_hval_60k_p > 31.9) => -0.0756847791,
(c_hval_60k_p = NULL) => -0.0084935277, 0.0007807774);

// Tree: 144 
woFDN_FL_PSD_lgt_144 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0904190592,
      (C_INC_100K_P > 1.35) => -0.0004813580,
      (C_INC_100K_P = NULL) => -0.0087152244, -0.0003000963),
   (f_assocsuspicousidcount_i > 9.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 170.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 0.0792458139,
         (r_C12_Num_NonDerogs_d > 2.5) => -0.0624710238,
         (r_C12_Num_NonDerogs_d = NULL) => -0.0165817621, -0.0165817621),
      (c_span_lang > 170.5) => -0.1198338502,
      (c_span_lang = NULL) => -0.0485083946, -0.0485083946),
   (f_assocsuspicousidcount_i = NULL) => -0.0015228959, -0.0015228959),
(r_C14_addrs_10yr_i > 10.5) => 0.1143845321,
(r_C14_addrs_10yr_i = NULL) => -0.0175031997, -0.0011894862);

// Tree: 145 
woFDN_FL_PSD_lgt_145 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 57.5) => -0.0075150161,
(k_comb_age_d > 57.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 32.45) => 0.0090966153,
   (c_rnt1000_p > 32.45) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 80.4) => 0.0195237214,
      (c_oldhouse > 80.4) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 72.5) => 0.3634891195,
         (f_prevaddrageoldest_d > 72.5) => 
            map(
            (NULL < c_robbery and c_robbery <= 56.5) => 0.2671664337,
            (c_robbery > 56.5) => 0.0245110998,
            (c_robbery = NULL) => 0.0854737699, 0.0854737699),
         (f_prevaddrageoldest_d = NULL) => 0.1430316353, 0.1430316353),
      (c_oldhouse = NULL) => 0.0795199755, 0.0795199755),
   (c_rnt1000_p = NULL) => 0.0109721087, 0.0238017659),
(k_comb_age_d = NULL) => -0.0012615349, -0.0012615349);

// Tree: 146 
woFDN_FL_PSD_lgt_146 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < r_L75_Add_Curr_Drop_Delivery_i and r_L75_Add_Curr_Drop_Delivery_i <= 0.5) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 30.5) => -0.0038521540,
      (f_rel_incomeover25_count_d > 30.5) => -0.0575456006,
      (f_rel_incomeover25_count_d = NULL) => 
         map(
         (NULL < c_families and c_families <= 460.5) => -0.0219372056,
         (c_families > 460.5) => 0.1480885122,
         (c_families = NULL) => 0.0332307135, 0.0332307135), -0.0039827531),
   (r_L75_Add_Curr_Drop_Delivery_i > 0.5) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 106.5) => 0.2136036890,
      (c_totcrime > 106.5) => -0.0171447564,
      (c_totcrime = NULL) => 0.0919363269, 0.0919363269),
   (r_L75_Add_Curr_Drop_Delivery_i = NULL) => -0.0031373124, -0.0031373124),
(f_assocsuspicousidcount_i > 13.5) => 0.0646829343,
(f_assocsuspicousidcount_i = NULL) => -0.0002208067, -0.0025682888);

// Tree: 147 
woFDN_FL_PSD_lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0019974728,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 158.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 0.0996304560,
         (f_prevaddrlenofres_d > 3.5) => 0.0007270045,
         (f_prevaddrlenofres_d = NULL) => 0.0164616445, 0.0164616445),
      (f_curraddrcartheftindex_i > 158.5) => 0.1276624437,
      (f_curraddrcartheftindex_i = NULL) => 0.0299685635, 0.0299685635),
   (f_hh_tot_derog_i = NULL) => -0.0004389762, -0.0004389762),
(f_prevaddrcartheftindex_i > 194.5) => -0.0800384657,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 408) => -0.0521924748,
   (c_families > 408) => 0.0744089670,
   (c_families = NULL) => 0.0117111101, 0.0117111101), -0.0019115353);

// Tree: 148 
woFDN_FL_PSD_lgt_148 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0037992232,
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 3.35) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 8851) => 0.1281607851,
      (r_A49_Curr_AVM_Chg_1yr_i > 8851) => -0.0197149264,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 18.8) => 
            map(
            (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 1.5) => 0.0947752374,
            (f_srchssnsrchcount_i > 1.5) => -0.0230564239,
            (f_srchssnsrchcount_i = NULL) => 0.0195110349, 0.0195110349),
         (c_hh4_p > 18.8) => 0.1345736152,
         (c_hh4_p = NULL) => 0.0512075193, 0.0512075193), 0.0473352563),
   (c_hval_80k_p > 3.35) => -0.0250178170,
   (c_hval_80k_p = NULL) => 0.0283592202, 0.0283592202),
(k_inq_per_phone_i = NULL) => -0.0021260208, -0.0021260208);

// Tree: 149 
woFDN_FL_PSD_lgt_149 := map(
(NULL < c_hval_100k_p and c_hval_100k_p <= 47.8) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 6516) => -0.0098548116,
   (r_A49_Curr_AVM_Chg_1yr_i > 6516) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 0.0189841670,
      (r_P85_Phn_Disconnected_i > 0.5) => 0.1566645675,
      (r_P85_Phn_Disconnected_i = NULL) => 0.0215311837, 0.0215311837),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 990.5) => -0.0096312177,
      (c_hh00 > 990.5) => 0.0346524043,
      (c_hh00 = NULL) => -0.0020424402, -0.0020424402), 0.0017624173),
(c_hval_100k_p > 47.8) => 0.1025014357,
(c_hval_100k_p = NULL) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0229916115,
   (f_vardobcountnew_i > 0.5) => 0.1265409331,
   (f_vardobcountnew_i = NULL) => 0.0012955215, 0.0012955215), 0.0023305589);

// Tree: 150 
woFDN_FL_PSD_lgt_150 := map(
(NULL < c_unempl and c_unempl <= 22.5) => -0.0775449510,
(c_unempl > 22.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_transport and c_transport <= 7.25) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 0.95) => 
            map(
            (NULL < c_low_hval and c_low_hval <= 2.15) => 0.1769456364,
            (c_low_hval > 2.15) => 0.0148627663,
            (c_low_hval = NULL) => 0.0962054706, 0.0962054706),
         (c_hh6_p > 0.95) => -0.0126838969,
         (c_hh6_p = NULL) => 0.0347897496, 0.0347897496),
      (c_transport > 7.25) => 0.1972398452,
      (c_transport = NULL) => 0.0487484244, 0.0487484244),
   (f_corrssnnamecount_d > 1.5) => -0.0014815288,
   (f_corrssnnamecount_d = NULL) => -0.0155611693, 0.0012633002),
(c_unempl = NULL) => 0.0240393860, -0.0011649573);

// Tree: 151 
woFDN_FL_PSD_lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 367.5) => -0.0024497725,
      (f_prevaddrlenofres_d > 367.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 148.5) => -0.0000853531,
         (c_relig_indx > 148.5) => 0.2195901728,
         (c_relig_indx = NULL) => 0.0727718565, 0.0727718565),
      (f_prevaddrlenofres_d = NULL) => -0.0012127732, -0.0012127732),
   (k_inq_adls_per_phone_i > 3.5) => -0.0946954672,
   (k_inq_adls_per_phone_i = NULL) => -0.0016457017, -0.0016457017),
(r_C14_addrs_10yr_i > 10.5) => 0.1045613807,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 28.5) => -0.0750038362,
   (k_comb_age_d > 28.5) => 0.0529924901,
   (k_comb_age_d = NULL) => -0.0080699775, -0.0080699775), -0.0012655265);

// Tree: 152 
woFDN_FL_PSD_lgt_152 := map(
(NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.30807338675) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3047130295) => 0.0061878952,
   (f_add_curr_mobility_index_i > 0.3047130295) => 
      map(
      (NULL < c_unempl and c_unempl <= 96) => -0.0140940520,
      (c_unempl > 96) => 0.2069433645,
      (c_unempl = NULL) => 0.0982072161, 0.0982072161),
   (f_add_curr_mobility_index_i = NULL) => 0.0074861539, 0.0074861539),
(f_add_curr_mobility_index_i > 0.30807338675) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 46.5) => -0.0597875503,
      (c_ab_av_edu > 46.5) => -0.0071939049,
      (c_ab_av_edu = NULL) => -0.0108785306, -0.0108785306),
   (r_I60_inq_comm_count12_i > 1.5) => -0.0985115669,
   (r_I60_inq_comm_count12_i = NULL) => -0.0120682270, -0.0120682270),
(f_add_curr_mobility_index_i = NULL) => 0.0143775184, 0.0019243940);

// Tree: 153 
woFDN_FL_PSD_lgt_153 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 26.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 35.15) => 0.0023590608,
   (c_hval_60k_p > 35.15) => -0.0820570548,
   (c_hval_60k_p = NULL) => -0.0115196849, 0.0013257767),
(f_rel_homeover300_count_d > 26.5) => -0.1138958908,
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 4.05) => -0.0966458703,
   (c_famotf18_p > 4.05) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 152) => 
         map(
         (NULL < c_robbery and c_robbery <= 74.5) => -0.0873460021,
         (c_robbery > 74.5) => 0.0364134228,
         (c_robbery = NULL) => -0.0105063592, -0.0105063592),
      (c_new_homes > 152) => 0.0994454343,
      (c_new_homes = NULL) => 0.0164112998, 0.0164112998),
   (c_famotf18_p = NULL) => -0.0095954614, -0.0095954614), 0.0003128012);

// Tree: 154 
woFDN_FL_PSD_lgt_154 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0032639546,
(f_util_adl_count_n > 6.5) => 
   map(
   (NULL < c_unattach and c_unattach <= 153.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 2.85) => -0.0167676591,
         (c_hval_150k_p > 2.85) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 89) => -0.0219136875,
            (r_C13_max_lres_d > 89) => 0.1727970547,
            (r_C13_max_lres_d = NULL) => 0.1025952225, 0.1025952225),
         (c_hval_150k_p = NULL) => 0.0531380923, 0.0531380923),
      (f_phone_ver_experian_d > 0.5) => -0.0338724662,
      (f_phone_ver_experian_d = NULL) => 0.0839793772, 0.0086090899),
   (c_unattach > 153.5) => 0.1571712238,
   (c_unattach = NULL) => 0.0211233491, 0.0211233491),
(f_util_adl_count_n = NULL) => -0.0195006831, -0.0017571451);

// Tree: 155 
woFDN_FL_PSD_lgt_155 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 19.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 9.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 7.25) => -0.0113100693,
         (c_hh5_p > 7.25) => 
            map(
            (NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => 0.0392710917,
            (k_estimated_income_d > 30500) => 0.0016506967,
            (k_estimated_income_d = NULL) => 0.0086766715, 0.0086766715),
         (c_hh5_p = NULL) => 0.0083816794, -0.0032306189),
      (f_srchssnsrchcount_i > 22.5) => 0.0718697369,
      (f_srchssnsrchcount_i = NULL) => -0.0029173745, -0.0029173745),
   (k_inq_per_phone_i > 9.5) => 0.0911641086,
   (k_inq_per_phone_i = NULL) => -0.0025265895, -0.0025265895),
(f_srchphonesrchcount_i > 19.5) => -0.0672971928,
(f_srchphonesrchcount_i = NULL) => 0.0245200821, -0.0027517085);

// Tree: 156 
woFDN_FL_PSD_lgt_156 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0016403980,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 6.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 18.6) => 
         map(
         (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
            map(
            (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 37) => 0.0816875751,
            (f_fp_prevaddrburglaryindex_i > 37) => -0.0706361819,
            (f_fp_prevaddrburglaryindex_i = NULL) => -0.0312905620, -0.0312905620),
         (r_I61_inq_collection_count12_i > 0.5) => 0.0579062083,
         (r_I61_inq_collection_count12_i = NULL) => -0.0086842180, -0.0086842180),
      (c_pop_45_54_p > 18.6) => -0.1429796553,
      (c_pop_45_54_p = NULL) => -0.0296093211, -0.0296093211),
   (r_D30_Derog_Count_i > 6.5) => -0.1056411453,
   (r_D30_Derog_Count_i = NULL) => -0.0388814947, -0.0388814947),
(f_srchssnsrchcount_i = NULL) => 0.0089000219, 0.0001202241);

// Tree: 157 
woFDN_FL_PSD_lgt_157 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 56.6) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 39.55) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.95) => 0.0000481741,
         (c_pop_6_11_p > 15.95) => 0.1101537527,
         (c_pop_6_11_p = NULL) => 0.0006181930, 0.0006181930),
      (c_hval_80k_p > 39.55) => -0.0749351587,
      (c_hval_80k_p = NULL) => -0.0002671492, -0.0002671492),
   (c_trailer_p > 56.6) => 0.1217241984,
   (c_trailer_p = NULL) => -0.0031094995, 0.0003422959),
(f_inq_HighRiskCredit_count24_i > 8.5) => 0.0684512788,
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 0.05) => 0.0427395253,
   (c_bigapt_p > 0.05) => -0.0705166347,
   (c_bigapt_p = NULL) => -0.0138885547, -0.0138885547), 0.0006133301);

// Tree: 158 
woFDN_FL_PSD_lgt_158 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 5.55) => 0.1184823313,
      (c_hh2_p > 5.55) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.55) => 0.0052669129,
         (c_pop_18_24_p > 11.55) => -0.0205108422,
         (c_pop_18_24_p = NULL) => 0.0000633355, 0.0000633355),
      (c_hh2_p = NULL) => -0.0229278975, 0.0000051164),
   (r_D33_eviction_count_i > 3.5) => 0.0754313952,
   (r_D33_eviction_count_i = NULL) => 0.0004537215, 0.0004537215),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 543) => -0.1637703096,
   (r_A50_pb_total_dollars_d > 543) => -0.0034579493,
   (r_A50_pb_total_dollars_d = NULL) => -0.0693397412, -0.0693397412),
(r_I60_inq_comm_count12_i = NULL) => 0.0010446425, -0.0003450587);

// Tree: 159 
woFDN_FL_PSD_lgt_159 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.1025996390,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 17.5) => 
      map(
      (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0009345553,
      (f_srchunvrfdaddrcount_i > 0.5) => 0.0402290525,
      (f_srchunvrfdaddrcount_i = NULL) => 0.0000508630, 0.0000508630),
   (f_rel_homeover500_count_d > 17.5) => 0.1229525033,
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_families and c_families <= 426.5) => -0.0311966878,
      (c_families > 426.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 108.5) => 0.1458970752,
         (c_exp_prod > 108.5) => 0.0169125334,
         (c_exp_prod = NULL) => 0.0739853395, 0.0739853395),
      (c_families = NULL) => 0.0066554430, 0.0066554430), 0.0008077651),
(C_INC_100K_P = NULL) => 0.0077138185, 0.0014702508);

// Tree: 160 
woFDN_FL_PSD_lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.55) => -0.0042491487,
(r_C12_source_profile_d > 79.55) => 
   map(
   (NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 84.15) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 62500) => 0.0567908887,
         (k_estimated_income_d > 62500) => 
            map(
            (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.3043705315,
            (k_nap_phn_verd_d > 0.5) => 0.1405238776,
            (k_nap_phn_verd_d = NULL) => 0.2102694127, 0.2102694127),
         (k_estimated_income_d = NULL) => 0.0960898879, 0.0960898879),
      (c_fammar_p > 84.15) => 0.0013786060,
      (c_fammar_p = NULL) => 0.0597401422, 0.0597401422),
   (r_D31_MostRec_Bk_i > 0.5) => -0.0679127767,
   (r_D31_MostRec_Bk_i = NULL) => 0.0410814268, 0.0410814268),
(r_C12_source_profile_d = NULL) => -0.0075523447, -0.0002640951);

// Tree: 161 
woFDN_FL_PSD_lgt_161 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 25.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 0.5) => -0.0262406732,
   (f_inq_HighRiskCredit_count_i > 0.5) => -0.1034657091,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0401529697, -0.0401529697),
(f_mos_inq_banko_cm_fseen_d > 25.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0051319971,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 178.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 0.1079250446,
         (f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0026661270,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0207160064, 0.0207160064),
      (c_bargains > 178.5) => 0.1608628675,
      (c_bargains = NULL) => 0.0331248431, 0.0331248431),
   (f_hh_tot_derog_i = NULL) => -0.0032696407, -0.0032696407),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0114895352, -0.0052357006);

// Tree: 162 
woFDN_FL_PSD_lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0002417071,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 43.8) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 19.35) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 6.5) => 0.0090952649,
         (f_rel_homeover150_count_d > 6.5) => 0.1229619428,
         (f_rel_homeover150_count_d = NULL) => 0.0605189259, 0.0605189259),
      (c_newhouse > 19.35) => -0.0911456417,
      (c_newhouse = NULL) => 0.0080442654, 0.0080442654),
   (c_fammar18_p > 43.8) => 0.1357619340,
   (c_fammar18_p = NULL) => 0.0328058542, 0.0328058542),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 60.5) => 0.0631570160,
   (c_larceny > 60.5) => -0.0375272263,
   (c_larceny = NULL) => 0.0118277944, 0.0118277944), 0.0006310051);

// Tree: 163 
woFDN_FL_PSD_lgt_163 := map(
(NULL < c_civ_emp and c_civ_emp <= 42.25) => -0.0476024098,
(c_civ_emp > 42.25) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 14.65) => -0.0025916603,
   (c_hval_200k_p > 14.65) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 113261) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 35489.5) => 0.2377781062,
         (f_prevaddrmedianincome_d > 35489.5) => 0.0552022695,
         (f_prevaddrmedianincome_d = NULL) => 0.0994134586, 0.0994134586),
      (r_A46_Curr_AVM_AutoVal_d > 113261) => -0.0100854519,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0417775261, 0.0261791957),
   (c_hval_200k_p = NULL) => 0.0008150668, 0.0008150668),
(c_civ_emp = NULL) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => -0.1101050449,
   (r_F00_dob_score_d > 98) => -0.0124004661,
   (r_F00_dob_score_d = NULL) => 0.1380775650, -0.0053176121), -0.0008987709);

// Tree: 164 
woFDN_FL_PSD_lgt_164 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0002788438,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 152.5) => 0.0445708182,
      (c_work_home > 152.5) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 5.6) => 0.3408428565,
         (c_hh5_p > 5.6) => 0.0610423874,
         (c_hh5_p = NULL) => 0.1997864216, 0.1997864216),
      (c_work_home = NULL) => 0.0885546309, 0.0885546309),
   (f_inq_count_i > 3.5) => 
      map(
      (NULL < c_employees and c_employees <= 3350.5) => -0.0075008808,
      (c_employees > 3350.5) => 0.1438306860,
      (c_employees = NULL) => 0.0048329191, 0.0048329191),
   (f_inq_count_i = NULL) => 0.0286212078, 0.0286212078),
(k_inq_per_ssn_i = NULL) => 0.0032251593, 0.0032251593);

// Tree: 165 
woFDN_FL_PSD_lgt_165 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 9.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < c_employees and c_employees <= 18.5) => 
         map(
         (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 73.5) => -0.0142380708,
         (f_curraddrburglaryindex_i > 73.5) => 
            map(
            (NULL < c_famotf18_p and c_famotf18_p <= 8.1) => 0.2827789192,
            (c_famotf18_p > 8.1) => 0.0616554523,
            (c_famotf18_p = NULL) => 0.1275220169, 0.1275220169),
         (f_curraddrburglaryindex_i = NULL) => 0.0737186833, 0.0737186833),
      (c_employees > 18.5) => 0.0148463669,
      (c_employees = NULL) => 0.0061126988, 0.0184835107),
   (f_corrphonelastnamecount_d > 0.5) => -0.0084327778,
   (f_corrphonelastnamecount_d = NULL) => 0.0032946491, 0.0032946491),
(f_rel_incomeover50_count_d > 9.5) => -0.0193361826,
(f_rel_incomeover50_count_d = NULL) => 0.0240139134, -0.0004600773);

// Tree: 166 
woFDN_FL_PSD_lgt_166 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_health and c_health <= 2.3) => 0.1375120360,
   (c_health > 2.3) => 0.0017191666,
   (c_health = NULL) => 0.0443594396, 0.0443594396),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 8.25) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 27.15) => 0.0196731973,
      (c_hh3_p > 27.15) => 
         map(
         (NULL < c_preschl and c_preschl <= 104) => 0.2880159796,
         (c_preschl > 104) => 0.0552048478,
         (c_preschl = NULL) => 0.1479655331, 0.1479655331),
      (c_hh3_p = NULL) => 0.0404861491, 0.0404861491),
   (c_hh1_p > 8.25) => -0.0060138290,
   (c_hh1_p = NULL) => 0.0124623779, -0.0026015851),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0336333972, -0.0020847137);

// Tree: 167 
woFDN_FL_PSD_lgt_167 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
      map(
      (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.05) => -0.0042883237,
      (c_hval_1000k_p > 41.05) => 0.1001161534,
      (c_hval_1000k_p = NULL) => 0.0139274393, -0.0027155868),
   (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0686899564,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0030403739, -0.0030403739),
(f_hh_collections_ct_i > 4.5) => 
   map(
   (NULL < c_hval_400k_p and c_hval_400k_p <= 16.6) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 1.5) => 0.1725311784,
      (r_C18_invalid_addrs_per_adl_i > 1.5) => 0.0057312856,
      (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0958570341, 0.0958570341),
   (c_hval_400k_p > 16.6) => -0.0432694921,
   (c_hval_400k_p = NULL) => 0.0480092870, 0.0480092870),
(f_hh_collections_ct_i = NULL) => -0.0312293057, -0.0024943539);

// Tree: 168 
woFDN_FL_PSD_lgt_168 := map(
(NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0003236875,
   (f_assocsuspicousidcount_i > 13.5) => 0.0776813146,
   (f_assocsuspicousidcount_i = NULL) => 0.0001850258, 0.0001850258),
(r_D31_attr_bankruptcy_recency_d > 9) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 83.15) => -0.0519073504,
   (c_fammar_p > 83.15) => 
      map(
      (NULL < c_health and c_health <= 10.85) => -0.0320859537,
      (c_health > 10.85) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 35.6) => -0.0342007302,
         (c_low_ed > 35.6) => 0.2608499759,
         (c_low_ed = NULL) => 0.0874232250, 0.0874232250),
      (c_health = NULL) => 0.0081600679, 0.0081600679),
   (c_fammar_p = NULL) => -0.0327703924, -0.0327703924),
(r_D31_attr_bankruptcy_recency_d = NULL) => 0.0297821865, -0.0028324720);

// Tree: 169 
woFDN_FL_PSD_lgt_169 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 
   map(
   (NULL < c_assault and c_assault <= 80.5) => 0.1352124613,
   (c_assault > 80.5) => -0.0183289861,
   (c_assault = NULL) => 0.0621997450, 0.0621997450),
(f_mos_liens_unrel_SC_fseen_d > 66.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 16.05) => -0.0082101052,
   (c_hval_150k_p > 16.05) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0029311362) => 0.1722752622,
         (f_add_curr_nhood_MFD_pct_i > 0.0029311362) => 0.0231710630,
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0387691997, 0.0163926132),
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.0839555791,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0192908574, 0.0192908574),
   (c_hval_150k_p = NULL) => 0.0129041416, -0.0037378255),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0076920229, -0.0030207868);

// Tree: 170 
woFDN_FL_PSD_lgt_170 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0024287865,
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 148.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 8.65) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 147.5) => 0.0385723525,
         (r_C13_Curr_Addr_LRes_d > 147.5) => -0.0551887803,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0240504262, 0.0240504262),
      (c_femdiv_p > 8.65) => -0.0847984681,
      (c_femdiv_p = NULL) => 0.0125753921, 0.0125753921),
   (c_born_usa > 148.5) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.05) => -0.0025999697,
      (c_pop_6_11_p > 7.05) => 0.1408950772,
      (c_pop_6_11_p = NULL) => 0.0890293976, 0.0890293976),
   (c_born_usa = NULL) => 0.0234973929, 0.0234973929),
(f_inq_Communications_count_i = NULL) => 0.0080437424, 0.0000748629);

// Tree: 171 
woFDN_FL_PSD_lgt_171 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 12.95) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 81.85) => 
      map(
      (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 1.5) => -0.0003222939,
      (f_inq_Other_count_i > 1.5) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 22.95) => 0.0224251383,
         (c_hval_125k_p > 22.95) => 0.1316062132,
         (c_hval_125k_p = NULL) => 0.0309081286, 0.0309081286),
      (f_inq_Other_count_i = NULL) => 0.0074826049, 0.0025821156),
   (c_low_ed > 81.85) => -0.0575645127,
   (c_low_ed = NULL) => 0.0016300694, 0.0016300694),
(c_femdiv_p > 12.95) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04861726755) => 0.1468386352,
   (f_add_curr_nhood_BUS_pct_i > 0.04861726755) => -0.0290745957,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0687647855, 0.0687647855),
(c_femdiv_p = NULL) => 0.0185475162, 0.0030225641);

// Tree: 172 
woFDN_FL_PSD_lgt_172 := map(
(NULL < c_med_hhinc and c_med_hhinc <= 27878) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 25140) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 163.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 10.95) => 0.1179553059,
         (c_pop_25_34_p > 10.95) => 0.0108622944,
         (c_pop_25_34_p = NULL) => 0.0518334844, 0.0518334844),
      (f_prevaddrmurderindex_i > 163.5) => -0.0520819144,
      (f_prevaddrmurderindex_i = NULL) => 0.0182608171, 0.0182608171),
   (f_curraddrmedianincome_d > 25140) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','6: Other']) => 0.0198156397,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 0.1499920869,
      (nf_seg_FraudPoint_3_0 = '') => 0.0936746168, 0.0936746168),
   (f_curraddrmedianincome_d = NULL) => 0.0382859504, 0.0382859504),
(c_med_hhinc > 27878) => -0.0039586212,
(c_med_hhinc = NULL) => -0.0041784445, -0.0021720267);

// Tree: 173 
woFDN_FL_PSD_lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0079290944,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 3.05) => 0.1732775640,
      (c_construction > 3.05) => 0.0317454926,
      (c_construction = NULL) => 0.0956227992, 0.0956227992),
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 153.5) => 0.0009261638,
      (r_C13_Curr_Addr_LRes_d > 153.5) => 
         map(
         (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 20.5) => 0.0467021337,
         (f_rel_ageover20_count_d > 20.5) => 0.1590707531,
         (f_rel_ageover20_count_d = NULL) => 0.0679273173, 0.0679273173),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0152324599, 0.0152324599),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0204074207, 0.0204074207),
(f_rel_felony_count_i = NULL) => 0.0075845886, -0.0037838251);

// Tree: 174 
woFDN_FL_PSD_lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 21.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 37.85) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 25.5) => 
            map(
            (NULL < f_rel_count_i and f_rel_count_i <= 1.5) => 0.1649840138,
            (f_rel_count_i > 1.5) => 0.0310678849,
            (f_rel_count_i = NULL) => 0.0531150525, 0.0531150525),
         (r_C13_max_lres_d > 25.5) => 0.0019345134,
         (r_C13_max_lres_d = NULL) => 0.0033784508, 0.0033784508),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0542753503,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0008965233, 0.0008965233),
   (c_hval_20k_p > 37.85) => 0.1341223979,
   (c_hval_20k_p = NULL) => -0.0118679331, 0.0011818895),
(f_srchphonesrchcount_i > 21.5) => -0.1065902839,
(f_srchphonesrchcount_i = NULL) => -0.0192412749, 0.0004427109);

// Tree: 175 
woFDN_FL_PSD_lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => 
   map(
   (NULL < c_retail and c_retail <= 13.15) => -0.0213067052,
   (c_retail > 13.15) => 0.0067738962,
   (c_retail = NULL) => 0.0134495577, -0.0097146639),
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.1685204056,
   (f_adl_per_email_i > 0.5) => -0.0802115995,
   (f_adl_per_email_i = NULL) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 11.05) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 88.15) => 0.0152083701,
         (r_C12_source_profile_d > 88.15) => 0.1953585288,
         (r_C12_source_profile_d = NULL) => 0.0189659294, 0.0189659294),
      (c_femdiv_p > 11.05) => 0.1606455138,
      (c_femdiv_p = NULL) => -0.0037157847, 0.0225805462), 0.0233515919),
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0008952010, -0.0023536177);

// Tree: 176 
woFDN_FL_PSD_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.35) => 
   map(
   (NULL < c_food and c_food <= 97.95) => 0.0046275179,
   (c_food > 97.95) => 0.1218717452,
   (c_food = NULL) => 0.0055774967, 0.0055774967),
(c_pop_18_24_p > 11.35) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.15) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.15) => -0.0859046264,
      (c_incollege > 6.15) => -0.0298158461,
      (c_incollege = NULL) => -0.0476754405, -0.0476754405),
   (c_hval_175k_p > 2.15) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 15.5) => 0.0973982865,
      (r_C21_M_Bureau_ADL_FS_d > 15.5) => -0.0013276315,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0037369676, 0.0037369676),
   (c_hval_175k_p = NULL) => -0.0189610636, -0.0189610636),
(c_pop_18_24_p = NULL) => 0.0131689629, 0.0006673449);

// Tree: 177 
woFDN_FL_PSD_lgt_177 := map(
(NULL < C_INC_15K_P and C_INC_15K_P <= 35.05) => 
   map(
   (NULL < c_retired and c_retired <= 1.15) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 4.2) => -0.0061196878,
      (c_lowrent > 4.2) => 0.1682734780,
      (c_lowrent = NULL) => 0.0735599483, 0.0735599483),
   (c_retired > 1.15) => 0.0041903108,
   (c_retired = NULL) => 0.0048563328, 0.0048563328),
(C_INC_15K_P > 35.05) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 2.5) => -0.0440932779,
      (r_C14_Addr_Stability_v2_d > 2.5) => -0.0152807841,
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0214548899, -0.0214548899),
   (f_assocrisktype_i > 4.5) => -0.1171450956,
   (f_assocrisktype_i = NULL) => -0.0410998991, -0.0410998991),
(C_INC_15K_P = NULL) => -0.0005259912, 0.0036281098);

// Tree: 178 
woFDN_FL_PSD_lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0073591536,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 18.95) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 394) => 0.0158158011,
      (r_pb_order_freq_d > 394) => 0.1229277301,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 4.45) => 
            map(
            (NULL < c_retail and c_retail <= 10.75) => 0.0412246904,
            (c_retail > 10.75) => 0.2113594528,
            (c_retail = NULL) => 0.1245145442, 0.1245145442),
         (c_hh6_p > 4.45) => -0.0002474947,
         (c_hh6_p = NULL) => 0.0802829158, 0.0802829158), 0.0446673825),
   (c_hh1_p > 18.95) => -0.0012559264,
   (c_hh1_p = NULL) => 0.0171696790, 0.0171696790),
(c_rnt1250_p = NULL) => 0.0028506923, -0.0004796738);

// Tree: 179 
woFDN_FL_PSD_lgt_179 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 51) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 1.95) => -0.0714642422,
      (c_high_ed > 1.95) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 11.85) => -0.0005926480,
         (c_hh6_p > 11.85) => 0.0598619652,
         (c_hh6_p = NULL) => 0.0007324678, 0.0007324678),
      (c_high_ed = NULL) => -0.0000915456, -0.0000915456),
   (C_INC_15K_P > 51) => 0.1097015761,
   (C_INC_15K_P = NULL) => 0.0100503694, 0.0006133239),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 2.35) => -0.1156890738,
   (c_hval_300k_p > 2.35) => 0.0212884493,
   (c_hval_300k_p = NULL) => -0.0501355449, -0.0501355449),
(r_I60_inq_comm_count12_i = NULL) => 0.0460651224, 0.0004115374);

// Tree: 180 
woFDN_FL_PSD_lgt_180 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 75.8) => 
   map(
   (NULL < k_inq_adls_per_ssn_i and k_inq_adls_per_ssn_i <= 1.5) => 
      map(
      (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
         map(
         (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 3.5) => -0.0156034371,
         (f_rel_incomeover25_count_d > 3.5) => 0.0118267772,
         (f_rel_incomeover25_count_d = NULL) => 0.0586319530, 0.0069536364),
      (f_dl_addrs_per_adl_i > 0.5) => -0.0166152502,
      (f_dl_addrs_per_adl_i = NULL) => -0.0084486275, -0.0026872914),
   (k_inq_adls_per_ssn_i > 1.5) => 0.1268845717,
   (k_inq_adls_per_ssn_i = NULL) => -0.0021130235, -0.0021130235),
(c_rnt1000_p > 75.8) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 0.2236279947,
   (f_phone_ver_insurance_d > 2.5) => 0.0218708907,
   (f_phone_ver_insurance_d = NULL) => 0.0779145307, 0.0779145307),
(c_rnt1000_p = NULL) => 0.0270056110, -0.0001643194);

// Tree: 181 
woFDN_FL_PSD_lgt_181 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 6.45) => -0.0159613432,
   (c_lowrent > 6.45) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.85) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1064652208) => -0.0009456063,
         (f_add_curr_nhood_VAC_pct_i > 0.1064652208) => 0.0783053261,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0185862483, 0.0185862483),
      (c_incollege > 6.85) => 
         map(
         (NULL < c_rich_blk and c_rich_blk <= 174) => 0.0660362763,
         (c_rich_blk > 174) => 0.2221338796,
         (c_rich_blk = NULL) => 0.0859387207, 0.0859387207),
      (c_incollege = NULL) => 0.0390425801, 0.0390425801),
   (c_lowrent = NULL) => -0.0303543261, 0.0160799145),
(k_estimated_income_d > 28500) => -0.0072423351,
(k_estimated_income_d = NULL) => 0.0238367684, -0.0030229453);

// Tree: 182 
woFDN_FL_PSD_lgt_182 := map(
(NULL < c_preschl and c_preschl <= 196.5) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 0.0022287794,
   (f_inq_Other_count24_i > 3.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 1.5) => -0.0271771826,
      (f_assocrisktype_i > 1.5) => 0.1252248447,
      (f_assocrisktype_i = NULL) => 0.0592363380, 0.0592363380),
   (f_inq_Other_count24_i = NULL) => -0.0118676633, 0.0030265725),
(c_preschl > 196.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 22.5) => -0.1346757173,
   (c_white_col > 22.5) => -0.0348497705,
   (c_white_col = NULL) => -0.0677038796, -0.0677038796),
(c_preschl = NULL) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 1.5) => -0.0391351700,
   (f_hh_tot_derog_i > 1.5) => 0.1600282567,
   (f_hh_tot_derog_i = NULL) => -0.0038666465, -0.0038666465), 0.0019879880);

// Tree: 183 
woFDN_FL_PSD_lgt_183 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 15.75) => 0.0675874853,
   (c_fammar_p > 15.75) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => -0.0058536468,
      (k_inq_per_ssn_i > 7.5) => 
         map(
         (NULL < f_inq_count24_i and f_inq_count24_i <= 12.5) => 
            map(
            (NULL < c_hh3_p and c_hh3_p <= 17.05) => 0.0299072677,
            (c_hh3_p > 17.05) => 0.1879262591,
            (c_hh3_p = NULL) => 0.0914881982, 0.0914881982),
         (f_inq_count24_i > 12.5) => -0.0734221721,
         (f_inq_count24_i = NULL) => 0.0465126426, 0.0465126426),
      (k_inq_per_ssn_i = NULL) => -0.0050445502, -0.0050445502),
   (c_fammar_p = NULL) => -0.0069183746, -0.0046451068),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0804421363,
(f_srchfraudsrchcountyr_i = NULL) => 0.0063916096, -0.0051207667);

// Tree: 184 
woFDN_FL_PSD_lgt_184 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => -0.0015838329,
(f_util_adl_count_n > 7.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 39.5) => 0.1820409980,
      (r_A50_pb_average_dollars_d > 39.5) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 77.85) => -0.0453229338,
         (c_sfdu_p > 77.85) => 0.1212087554,
         (c_sfdu_p = NULL) => 0.0236315938, 0.0236315938),
      (r_A50_pb_average_dollars_d = NULL) => 0.0697295685, 0.0697295685),
   (f_phone_ver_experian_d > 0.5) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 16.25) => -0.0621253099,
      (C_INC_100K_P > 16.25) => 0.1127013372,
      (C_INC_100K_P = NULL) => -0.0091475381, -0.0091475381),
   (f_phone_ver_experian_d = NULL) => 0.0880962139, 0.0289718650),
(f_util_adl_count_n = NULL) => 0.0024279737, -0.0001984579);

// Tree: 185 
woFDN_FL_PSD_lgt_185 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 56.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 11.5) => -0.0906144211,
   (c_burglary > 11.5) => -0.0021248224,
   (c_burglary = NULL) => -0.0438519266, -0.0096754965),
(r_C13_Curr_Addr_LRes_d > 56.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
         map(
         (NULL < c_wholesale and c_wholesale <= 13.65) => 0.0339701613,
         (c_wholesale > 13.65) => -0.0626750667,
         (c_wholesale = NULL) => 0.0141186466, 0.0280039690),
      (f_srchunvrfdaddrcount_i > 0.5) => 0.1039746051,
      (f_srchunvrfdaddrcount_i = NULL) => 0.0299275844, 0.0299275844),
   (f_phone_ver_insurance_d > 3.5) => -0.0073168473,
   (f_phone_ver_insurance_d = NULL) => 0.0099290160, 0.0099290160),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0023727130, 0.0008339299);

// Tree: 186 
woFDN_FL_PSD_lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 14.45) => 
      map(
      (NULL < c_robbery and c_robbery <= 108.5) => -0.0030122642,
      (c_robbery > 108.5) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 1.5) => 0.0074848055,
         (f_assocsuspicousidcount_i > 1.5) => 
            map(
            (NULL < c_rental and c_rental <= 157.5) => 0.0459975427,
            (c_rental > 157.5) => 0.1209892294,
            (c_rental = NULL) => 0.0657776803, 0.0657776803),
         (f_assocsuspicousidcount_i = NULL) => 0.0377753812, 0.0377753812),
      (c_robbery = NULL) => 0.0136282980, 0.0136282980),
   (C_INC_75K_P > 14.45) => -0.0065803524,
   (C_INC_75K_P = NULL) => 0.0110031820, -0.0002380620),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0781047120,
(f_inq_PrepaidCards_count_i = NULL) => 0.0290049808, 0.0002906556);

// Tree: 187 
woFDN_FL_PSD_lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 2.45) => -0.0296820536,
   (c_unemp > 2.45) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 19.25) => 
         map(
         (NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 0.0162724976,
         (k_inf_phn_verd_d > 0.5) => -0.0146954587,
         (k_inf_phn_verd_d = NULL) => 0.0049984646, 0.0049984646),
      (c_hval_80k_p > 19.25) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 7.5) => -0.0473397521,
         (f_rel_homeover150_count_d > 7.5) => 0.0695136536,
         (f_rel_homeover150_count_d = NULL) => -0.0375748436, -0.0375748436),
      (c_hval_80k_p = NULL) => 0.0018568898, 0.0018568898),
   (c_unemp = NULL) => -0.0099770898, -0.0041829198),
(f_rel_bankrupt_count_i > 7.5) => -0.0799774811,
(f_rel_bankrupt_count_i = NULL) => 0.0052878267, -0.0050672665);

// Tree: 188 
woFDN_FL_PSD_lgt_188 := map(
(NULL < c_sfdu_p and c_sfdu_p <= 6.85) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 155.5) => -0.0670525051,
   (c_for_sale > 155.5) => 0.0366354213,
   (c_for_sale = NULL) => -0.0434870673, -0.0434870673),
(c_sfdu_p > 6.85) => 
   map(
   (NULL < f_validationrisktype_i and f_validationrisktype_i <= 3.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 0.0011642428,
      (f_srchfraudsrchcount_i > 12.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 59.5) => 0.1188187203,
         (c_burglary > 59.5) => 0.0022606589,
         (c_burglary = NULL) => 0.0368214794, 0.0368214794),
      (f_srchfraudsrchcount_i = NULL) => 0.0016899624, 0.0016899624),
   (f_validationrisktype_i > 3.5) => 0.0766964000,
   (f_validationrisktype_i = NULL) => 0.0040908432, 0.0021966271),
(c_sfdu_p = NULL) => -0.0242253966, -0.0004090205);

// Tree: 189 
woFDN_FL_PSD_lgt_189 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0231722502,
(f_addrs_per_ssn_i > 4.5) => 
   map(
   (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 1.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 12.95) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 240853) => -0.0445719978,
         (f_prevaddrmedianvalue_d > 240853) => 0.1517666928,
         (f_prevaddrmedianvalue_d = NULL) => 0.0271863053, 0.0271863053),
      (C_INC_25K_P > 12.95) => 0.2101182618,
      (C_INC_25K_P = NULL) => 0.0639196299, 0.0639196299),
   (r_C20_email_verification_d > 1.5) => -0.0269421296,
   (r_C20_email_verification_d = NULL) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 0.0012365191,
      (f_inq_QuizProvider_count_i > 5.5) => 0.0891161359,
      (f_inq_QuizProvider_count_i = NULL) => 0.0022853397, 0.0022853397), 0.0035257422),
(f_addrs_per_ssn_i = NULL) => -0.0030829844, -0.0030829844);

// Tree: 190 
woFDN_FL_PSD_lgt_190 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 47645.5) => -0.0486786669,
(r_A46_Curr_AVM_AutoVal_d > 47645.5) => 
   map(
   (NULL < c_murders and c_murders <= 188.5) => -0.0045784033,
   (c_murders > 188.5) => 0.1324306318,
   (c_murders = NULL) => -0.0030344106, -0.0030344106),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 3.75) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 116.5) => 0.0128781995,
      (c_exp_prod > 116.5) => 0.2100473757,
      (c_exp_prod = NULL) => 0.0776755814, 0.0776755814),
   (c_pop_25_34_p > 3.75) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1433.5) => -0.0124389320,
      (c_med_rent > 1433.5) => 0.0636946266,
      (c_med_rent = NULL) => -0.0077581612, -0.0077581612),
   (c_pop_25_34_p = NULL) => 0.0014539992, -0.0040462540), -0.0046917335);

// Tree: 191 
woFDN_FL_PSD_lgt_191 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 5.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 640.5) => -0.1435774216,
   (c_popover25 > 640.5) => 
      map(
      (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 2.5) => -0.0488315717,
      (f_assoccredbureaucount_i > 2.5) => 0.0634152186,
      (f_assoccredbureaucount_i = NULL) => -0.0230048766, -0.0230048766),
   (c_popover25 = NULL) => -0.0426537357, -0.0426537357),
(f_mos_inq_banko_cm_lseen_d > 5.5) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.85) => 
      map(
      (NULL < c_armforce and c_armforce <= 126.5) => 0.0131064724,
      (c_armforce > 126.5) => -0.0179120573,
      (c_armforce = NULL) => 0.0049202029, 0.0049202029),
   (c_manufacturing > 16.85) => -0.0444389122,
   (c_manufacturing = NULL) => -0.0297185487, 0.0004349397),
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0406098000, -0.0013055871);

// Tree: 192 
woFDN_FL_PSD_lgt_192 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 5.45) => 
   map(
   (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 
      map(
      (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 224) => 0.0971816329,
      (r_D32_Mos_Since_Fel_LS_d > 224) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 56.35) => -0.0429234202,
         (c_fammar_p > 56.35) => -0.0080583223,
         (c_fammar_p = NULL) => -0.0110483782, -0.0110483782),
      (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0043329132, -0.0101953125),
   (k_inq_addrs_per_ssn_i > 2.5) => -0.1190780449,
   (k_inq_addrs_per_ssn_i = NULL) => -0.0108745809, -0.0108745809),
(c_femdiv_p > 5.45) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 152.5) => 0.0042884571,
   (c_easiqlife > 152.5) => 0.0612697811,
   (c_easiqlife = NULL) => 0.0123667878, 0.0123667878),
(c_femdiv_p = NULL) => -0.0114780574, -0.0031734406);

// Tree: 193 
woFDN_FL_PSD_lgt_193 := map(
(NULL < c_hh2_p and c_hh2_p <= 16.85) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 65.5) => -0.0348296026,
   (r_A50_pb_average_dollars_d > 65.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 46.65) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 0.0529944446,
         (r_C14_Addr_Stability_v2_d > 5.5) => 
            map(
            (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 131.5) => 0.1844423159,
            (f_prevaddrcartheftindex_i > 131.5) => -0.0184546604,
            (f_prevaddrcartheftindex_i = NULL) => 0.0948877885, 0.0948877885),
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0677743348, 0.0677743348),
      (c_white_col > 46.65) => -0.1011170496,
      (c_white_col = NULL) => 0.0472480898, 0.0472480898),
   (r_A50_pb_average_dollars_d = NULL) => 0.0241205317, 0.0241205317),
(c_hh2_p > 16.85) => -0.0039608008,
(c_hh2_p = NULL) => -0.0202652271, -0.0028945416);

// Tree: 194 
woFDN_FL_PSD_lgt_194 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 12.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.8657834043) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 25303.5) => 0.1240240873,
      (c_med_hval > 25303.5) => 0.0023544572,
      (c_med_hval = NULL) => 0.0031598722, 0.0031598722),
   (f_add_curr_nhood_MFD_pct_i > 0.8657834043) => -0.0372660001,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 18.3) => 
         map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => -0.0075526583,
         (f_sourcerisktype_i > 4.5) => 0.1796190896,
         (f_sourcerisktype_i = NULL) => 0.0664454746, 0.0664454746),
      (c_fammar18_p > 18.3) => -0.0195404043,
      (c_fammar18_p = NULL) => -0.0183929732, -0.0149796104), -0.0025435452),
(r_C14_addrs_15yr_i > 12.5) => 0.1068941145,
(r_C14_addrs_15yr_i = NULL) => 0.0077744922, -0.0020033295);

// Tree: 195 
woFDN_FL_PSD_lgt_195 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 3.95) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 12.5) => 
      map(
      (NULL < c_rape and c_rape <= 72.5) => 0.1514138794,
      (c_rape > 72.5) => 0.0167401493,
      (c_rape = NULL) => 0.0606711521, 0.0606711521),
   (r_C21_M_Bureau_ADL_FS_d > 12.5) => -0.0139733042,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0312316965, -0.0119432953),
(c_rnt1250_p > 3.95) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 4.55) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.55) => 0.2260402336,
      (c_pop_18_24_p > 7.55) => 0.0023398618,
      (c_pop_18_24_p = NULL) => 0.1024575107, 0.1024575107),
   (c_rnt1250_p > 4.55) => 0.0108311042,
   (c_rnt1250_p = NULL) => 0.0130399000, 0.0130399000),
(c_rnt1250_p = NULL) => 0.0250989009, 0.0006713499);

// Tree: 196 
woFDN_FL_PSD_lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 22.5) => -0.0920773851,
(f_mos_inq_banko_am_lseen_d > 22.5) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 88.35) => -0.0032292402,
   (c_lowrent > 88.35) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03763570665) => 
            map(
            (NULL < C_INC_35K_P and C_INC_35K_P <= 11.3) => -0.0850267808,
            (C_INC_35K_P > 11.3) => 0.2153837577,
            (C_INC_35K_P = NULL) => 0.0481987624, 0.0481987624),
         (f_add_curr_nhood_BUS_pct_i > 0.03763570665) => -0.0308686912,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0130576719, 0.0130576719),
      (f_util_adl_count_n > 2.5) => 0.2232830026,
      (f_util_adl_count_n = NULL) => 0.0582759506, 0.0582759506),
   (c_lowrent = NULL) => -0.0031260087, -0.0019041052),
(f_mos_inq_banko_am_lseen_d = NULL) => 0.0128119427, -0.0035761423);

// Tree: 197 
woFDN_FL_PSD_lgt_197 := map(
(NULL < c_hh1_p and c_hh1_p <= 19.65) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 122.5) => 
         map(
         (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 101) => 0.1272530852,
         (f_mos_liens_unrel_SC_fseen_d > 101) => 
            map(
            (NULL < C_RENTOCC_P and C_RENTOCC_P <= 3.15) => -0.0417948351,
            (C_RENTOCC_P > 3.15) => 0.0406332156,
            (C_RENTOCC_P = NULL) => 0.0308390321, 0.0308390321),
         (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0325259145, 0.0325259145),
      (c_rest_indx > 122.5) => -0.0151525633,
      (c_rest_indx = NULL) => 0.0195541020, 0.0195541020),
   (f_assocsuspicousidcount_i > 9.5) => -0.0635880308,
   (f_assocsuspicousidcount_i = NULL) => 0.0170915500, 0.0170915500),
(c_hh1_p > 19.65) => -0.0091028995,
(c_hh1_p = NULL) => 0.0013640141, 0.0009273448);

// Tree: 198 
woFDN_FL_PSD_lgt_198 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 109.5) => -0.0091125069,
   (c_sub_bus > 109.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 132348) => 
         map(
         (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 0.0576633458,
         (f_rel_incomeover100_count_d > 0.5) => 0.0009083300,
         (f_rel_incomeover100_count_d = NULL) => 0.0401707987, 0.0401707987),
      (r_A46_Curr_AVM_AutoVal_d > 132348) => 0.0102041650,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0090696919, 0.0140212373),
   (c_sub_bus = NULL) => -0.0161422812, 0.0024463525),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 2.2) => -0.0952555059,
   (c_hval_300k_p > 2.2) => 0.0058966669,
   (c_hval_300k_p = NULL) => -0.0478186249, -0.0478186249),
(r_I60_inq_comm_count12_i = NULL) => 0.0037755643, 0.0018699542);

// Tree: 199 
woFDN_FL_PSD_lgt_199 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 18.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 11.05) => -0.0012636849,
   (c_hh6_p > 11.05) => 
      map(
      (NULL < c_larceny and c_larceny <= 150.5) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 75372.5) => 
            map(
            (NULL < c_popover25 and c_popover25 <= 713) => -0.0976423640,
            (c_popover25 > 713) => 0.0303369166,
            (c_popover25 = NULL) => -0.0075004359, -0.0075004359),
         (f_prevaddrmedianincome_d > 75372.5) => 0.1608869211,
         (f_prevaddrmedianincome_d = NULL) => 0.0264109068, 0.0264109068),
      (c_larceny > 150.5) => 0.1682988000,
      (c_larceny = NULL) => 0.0484638638, 0.0484638638),
   (c_hh6_p = NULL) => -0.0233882155, -0.0004492363),
(r_D30_Derog_Count_i > 18.5) => -0.0839907687,
(r_D30_Derog_Count_i = NULL) => -0.0137494308, -0.0009055281);

// Tree: 200 
woFDN_FL_PSD_lgt_200 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => 
   map(
   (NULL < c_rnt250_p and c_rnt250_p <= 1.55) => -0.0811331255,
   (c_rnt250_p > 1.55) => 
      map(
      (NULL < c_rnt250_p and c_rnt250_p <= 11.15) => 0.1044776799,
      (c_rnt250_p > 11.15) => -0.0647401336,
      (c_rnt250_p = NULL) => 0.0128569853, 0.0128569853),
   (c_rnt250_p = NULL) => -0.0502018345, -0.0502018345),
(f_mos_inq_banko_om_fseen_d > 5.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.34) => -0.0011580593,
   (c_hhsize > 4.34) => 
      map(
      (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 1.5) => 0.1428131040,
      (f_property_owners_ct_d > 1.5) => -0.0111772133,
      (f_property_owners_ct_d = NULL) => 0.0687792976, 0.0687792976),
   (c_hhsize = NULL) => -0.0469788062, -0.0016922114),
(f_mos_inq_banko_om_fseen_d = NULL) => 0.0161005124, -0.0037346615);

// Tree: 201 
woFDN_FL_PSD_lgt_201 := map(
(NULL < c_relig_indx and c_relig_indx <= 99.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 4.5) => 0.1529069126,
   (f_mos_acc_lseen_d > 4.5) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 895.5) => -0.0176643467,
         (c_popover18 > 895.5) => 
            map(
            (NULL < c_newhouse and c_newhouse <= 12.9) => 0.1031877231,
            (c_newhouse > 12.9) => 0.0109137934,
            (c_newhouse = NULL) => 0.0556694120, 0.0556694120),
         (c_popover18 = NULL) => 0.0307800271, 0.0307800271),
      (f_hh_age_18_plus_d > 1.5) => 0.0002171841,
      (f_hh_age_18_plus_d = NULL) => 0.0071033576, 0.0071033576),
   (f_mos_acc_lseen_d = NULL) => 0.0089002324, 0.0089002324),
(c_relig_indx > 99.5) => -0.0119584494,
(c_relig_indx = NULL) => 0.0054883706, -0.0021085010);

// Tree: 202 
woFDN_FL_PSD_lgt_202 := map(
(NULL < c_hval_1001k_p and c_hval_1001k_p <= 68.3) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 14.5) => -0.0370655392,
   (f_mos_inq_banko_om_fseen_d > 14.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.05) => -0.0216164576,
         (c_pop_35_44_p > 14.05) => 0.1023861373,
         (c_pop_35_44_p = NULL) => 0.0485516774, 0.0485516774),
      (f_mos_inq_banko_om_fseen_d > 36.5) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 7.5) => 0.0003826050,
         (f_srchfraudsrchcount_i > 7.5) => -0.0524124693,
         (f_srchfraudsrchcount_i = NULL) => -0.0009545413, -0.0009545413),
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0022639686, 0.0022639686),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0260891683, -0.0003770126),
(c_hval_1001k_p > 68.3) => 0.1661844091,
(c_hval_1001k_p = NULL) => 0.0333369107, 0.0014265352);

// Tree: 203 
woFDN_FL_PSD_lgt_203 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => -0.0045373528,
(r_C13_Curr_Addr_LRes_d > 310.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 43.55) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 64.5) => -0.0668251263,
      (c_span_lang > 64.5) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 64.5) => -0.0132049370,
         (f_fp_prevaddrcrimeindex_i > 64.5) => 0.1106277620,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0558607949, 0.0558607949),
      (c_span_lang = NULL) => 0.0194119914, 0.0194119914),
   (c_hval_750k_p > 43.55) => 0.1697420471,
   (c_hval_750k_p = NULL) => 0.0303023789, 0.0303023789),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 107.5) => 0.0478966221,
   (c_sub_bus > 107.5) => -0.0574438668,
   (c_sub_bus = NULL) => -0.0028583407, -0.0028583407), -0.0025450268);

// Tree: 204 
woFDN_FL_PSD_lgt_204 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 198.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => -0.0123202538,
      (f_sourcerisktype_i > 3.5) => 0.0113295118,
      (f_sourcerisktype_i = NULL) => 0.0025019688, 0.0025019688),
   (f_prevaddrcartheftindex_i > 198.5) => -0.1184211250,
   (f_prevaddrcartheftindex_i = NULL) => 0.0018622682, 0.0018622682),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 6.1) => -0.0815705186,
   (c_wholesale > 6.1) => 0.0208598305,
   (c_wholesale = NULL) => -0.0626925703, -0.0626925703),
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 3.75) => 0.0481158808,
   (c_hval_125k_p > 3.75) => -0.0624773370,
   (c_hval_125k_p = NULL) => -0.0071807281, -0.0071807281), 0.0002919415);

// Tree: 205 
woFDN_FL_PSD_lgt_205 := map(
(NULL < c_for_sale and c_for_sale <= 108.5) => -0.0086520175,
(c_for_sale > 108.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 0.0098456164,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 27.4) => 0.1356031772,
      (c_white_col > 27.4) => 
         map(
         (NULL < c_incollege and c_incollege <= 7.15) => -0.0107472329,
         (c_incollege > 7.15) => 
            map(
            (NULL < c_highrent and c_highrent <= 14.3) => 0.0017102003,
            (c_highrent > 14.3) => 0.1993908173,
            (c_highrent = NULL) => 0.0921742115, 0.0921742115),
         (c_incollege = NULL) => 0.0252905429, 0.0252905429),
      (c_white_col = NULL) => 0.0487448647, 0.0487448647),
   (k_nap_contradictory_i = NULL) => 0.0125553948, 0.0125553948),
(c_for_sale = NULL) => -0.0144163332, 0.0014775931);

// Tree: 206 
woFDN_FL_PSD_lgt_206 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184.5) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 4.4) => -0.1415749884,
   (c_pop_75_84_p > 4.4) => 0.0295545060,
   (c_pop_75_84_p = NULL) => -0.0728639035, -0.0728639035),
(f_mos_liens_unrel_FT_lseen_d > 184.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 16.75) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 1.25) => -0.0818897766,
      (c_pop_0_5_p > 1.25) => 
         map(
         (NULL < c_retired and c_retired <= 1.15) => 0.1089797519,
         (c_retired > 1.15) => -0.0022641531,
         (c_retired = NULL) => -0.0014085754, -0.0014085754),
      (c_pop_0_5_p = NULL) => -0.0030673635, -0.0030673635),
   (c_pop_12_17_p > 16.75) => 0.0822237171,
   (c_pop_12_17_p = NULL) => 0.0118085825, -0.0021142107),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0224225875, -0.0030024721);

// Tree: 207 
woFDN_FL_PSD_lgt_207 := map(
(NULL < c_unemp and c_unemp <= 9.75) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 4.5) => 0.0014237995,
   (f_srchfraudsrchcountyr_i > 4.5) => 
      map(
      (NULL < c_professional and c_professional <= 0.45) => -0.1305177324,
      (c_professional > 0.45) => 
         map(
         (NULL < c_hval_400k_p and c_hval_400k_p <= 6.6) => 0.0633810739,
         (c_hval_400k_p > 6.6) => -0.0967459414,
         (c_hval_400k_p = NULL) => -0.0159981303, -0.0159981303),
      (c_professional = NULL) => -0.0502854363, -0.0502854363),
   (f_srchfraudsrchcountyr_i = NULL) => -0.0090306954, 0.0006222331),
(c_unemp > 9.75) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1116935484) => -0.0618309044,
   (f_add_curr_nhood_VAC_pct_i > 0.1116935484) => 0.0238897652,
   (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0408812341, -0.0408812341),
(c_unemp = NULL) => 0.0392961188, 0.0000802256);

// Tree: 208 
woFDN_FL_PSD_lgt_208 := map(
(NULL < c_totsales and c_totsales <= 969.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => -0.0177610931,
   (f_inq_HighRiskCredit_count24_i > 2.5) => -0.0947517466,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0192690710, -0.0192690710),
(c_totsales > 969.5) => 
   map(
   (NULL < c_employees and c_employees <= 18.5) => 0.1809803998,
   (c_employees > 18.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 17.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => -0.0003544186,
         (r_S66_adlperssn_count_i > 3.5) => 0.0501359251,
         (r_S66_adlperssn_count_i = NULL) => 0.0020363244, 0.0020363244),
      (f_srchssnsrchcount_i > 17.5) => 0.0679508689,
      (f_srchssnsrchcount_i = NULL) => -0.0027909611, 0.0025396628),
   (c_employees = NULL) => 0.0034681712, 0.0034681712),
(c_totsales = NULL) => -0.0036651471, -0.0016800663);

// Tree: 209 
woFDN_FL_PSD_lgt_209 := map(
(NULL < c_popover25 and c_popover25 <= 6354) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 12.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 17.85) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 162.5) => 0.0503435780,
         (c_blue_empl > 162.5) => -0.0381005760,
         (c_blue_empl = NULL) => 0.0318454543, 0.0318454543),
      (c_hh2_p > 17.85) => 0.0002932351,
      (c_hh2_p = NULL) => 0.0022955120, 0.0022955120),
   (f_inq_count24_i > 12.5) => -0.0681816063,
   (f_inq_count24_i = NULL) => -0.0032404708, 0.0013412895),
(c_popover25 > 6354) => 0.1573940678,
(c_popover25 = NULL) => 
   map(
   (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => -0.0348455111,
   (f_property_owners_ct_d > 0.5) => 0.1287289321,
   (f_property_owners_ct_d = NULL) => 0.0143337332, 0.0143337332), 0.0024451163);

// Tree: 210 
woFDN_FL_PSD_lgt_210 := map(
(NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 4.5) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 2.65) => 0.1596082254,
   (c_hval_125k_p > 2.65) => -0.0246847200,
   (c_hval_125k_p = NULL) => 0.0770721210, 0.0770721210),
(r_I60_inq_retail_recency_d > 4.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => -0.0000236104,
   (f_srchfraudsrchcount_i > 6.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 84453) => 
         map(
         (NULL < c_med_age and c_med_age <= 31.35) => 0.0198478300,
         (c_med_age > 31.35) => -0.0722776047,
         (c_med_age = NULL) => -0.0470062884, -0.0470062884),
      (f_prevaddrmedianincome_d > 84453) => 0.0516535680,
      (f_prevaddrmedianincome_d = NULL) => -0.0299266799, -0.0299266799),
   (f_srchfraudsrchcount_i = NULL) => -0.0012042478, -0.0012042478),
(r_I60_inq_retail_recency_d = NULL) => -0.0141304956, -0.0002716663);

// Tree: 211 
woFDN_FL_PSD_lgt_211 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 10.35) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 31.5) => 0.0329574213,
      (c_famotf18_p > 31.5) => 0.0944895251,
      (c_famotf18_p = NULL) => 0.0387114765, 0.0387114765),
   (c_pop_25_34_p > 10.35) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 2089) => -0.0064975990,
      (c_hh00 > 2089) => 0.1993729728,
      (c_hh00 = NULL) => -0.0029966323, -0.0029966323),
   (c_pop_25_34_p = NULL) => 0.0419396616, 0.0104977829),
(k_estimated_income_d > 34500) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 55.55) => -0.0510382495,
   (c_fammar_p > 55.55) => -0.0062461068,
   (c_fammar_p = NULL) => -0.1136408196, -0.0101883278),
(k_estimated_income_d = NULL) => -0.0114436946, -0.0030096640);

// Tree: 212 
woFDN_FL_PSD_lgt_212 := map(
(NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0050860809,
(r_F04_curr_add_occ_index_d > 2) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 6.05) => 0.0036193113,
   (c_femdiv_p > 6.05) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 154.5) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 131.5) => 0.0060349218,
         (c_bel_edu > 131.5) => 
            map(
            (NULL < c_young and c_young <= 20.25) => 0.2051289074,
            (c_young > 20.25) => 0.0396319143,
            (c_young = NULL) => 0.1070856651, 0.1070856651),
         (c_bel_edu = NULL) => 0.0352427394, 0.0352427394),
      (c_easiqlife > 154.5) => 0.2483891265,
      (c_easiqlife = NULL) => 0.0572381897, 0.0572381897),
   (c_femdiv_p = NULL) => 0.0174371365, 0.0199364095),
(r_F04_curr_add_occ_index_d = NULL) => 0.0023534138, 0.0004251126);

// Tree: 213 
woFDN_FL_PSD_lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 149006.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 176.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 70.5) => -0.0177187418,
      (c_work_home > 70.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 6.95) => 0.1410827617,
         (c_hh3_p > 6.95) => 0.0327985699,
         (c_hh3_p = NULL) => 0.0410093609, 0.0410093609),
      (c_work_home = NULL) => 0.0208090909, 0.0208090909),
   (c_sub_bus > 176.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 4.2) => -0.0106326927,
      (c_hval_175k_p > 4.2) => 0.2012011449,
      (c_hval_175k_p = NULL) => 0.1041780131, 0.1041780131),
   (c_sub_bus = NULL) => 0.0252075318, 0.0252075318),
(r_A46_Curr_AVM_AutoVal_d > 149006.5) => -0.0099829882,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0034370702, 0.0027411811);

// Tree: 214 
woFDN_FL_PSD_lgt_214 := map(
(NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.95) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0087219205,
   (c_hh4_p > 11.55) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 89.85) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 169.5) => 0.0244379699,
         (c_mort_indx > 169.5) => 0.2119325428,
         (c_mort_indx = NULL) => 0.0280928349, 0.0280928349),
      (c_fammar_p > 89.85) => -0.0238984830,
      (c_fammar_p = NULL) => 0.0188443793, 0.0188443793),
   (c_hh4_p = NULL) => 0.0074478210, 0.0074478210),
(c_pop_6_11_p > 10.95) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 58.5) => -0.0180141531,
   (f_liens_unrel_SC_total_amt_i > 58.5) => -0.1018945977,
   (f_liens_unrel_SC_total_amt_i = NULL) => -0.0215783396, -0.0215783396),
(c_pop_6_11_p = NULL) => -0.0020181046, 0.0032541753);

// Tree: 215 
woFDN_FL_PSD_lgt_215 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 42.5) => 0.1234118946,
(f_mos_liens_unrel_FT_fseen_d > 42.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 64.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 10.75) => -0.0256789854,
      (c_hh6_p > 10.75) => 0.0887417963,
      (c_hh6_p = NULL) => -0.0155870096, -0.0221190302),
   (r_C13_max_lres_d > 64.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 2.5) => 
         map(
         (NULL < c_business and c_business <= 17.5) => 0.1352374591,
         (c_business > 17.5) => -0.0078700167,
         (c_business = NULL) => 0.0622807067, 0.0622807067),
      (r_F00_input_dob_match_level_d > 2.5) => 0.0056829096,
      (r_F00_input_dob_match_level_d = NULL) => 0.0063134480, 0.0063134480),
   (r_C13_max_lres_d = NULL) => 0.0008694613, 0.0008694613),
(f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0213661564, 0.0012289607);

// Tree: 216 
woFDN_FL_PSD_lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184) => -0.0821685837,
(f_mos_liens_unrel_FT_lseen_d > 184) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0174834283,
      (f_addrs_per_ssn_i > 4.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 171.5) => 
            map(
            (NULL < C_RENTOCC_P and C_RENTOCC_P <= 71.85) => 0.0084667266,
            (C_RENTOCC_P > 71.85) => 0.0558671094,
            (C_RENTOCC_P = NULL) => 0.0109106115, 0.0109106115),
         (c_rest_indx > 171.5) => -0.0578358687,
         (c_rest_indx = NULL) => 0.0255313995, 0.0082613566),
      (f_addrs_per_ssn_i = NULL) => 0.0018986961, 0.0018986961),
   (k_inq_adls_per_phone_i > 2.5) => -0.0653081951,
   (k_inq_adls_per_phone_i = NULL) => 0.0013531330, 0.0013531330),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 0.0052738217, 0.0004218075);

// Tree: 217 
woFDN_FL_PSD_lgt_217 := map(
(NULL < c_unempl and c_unempl <= 58.5) => -0.0253432941,
(c_unempl > 58.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 41.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 1.5) => 0.0618116769,
         (f_rel_homeover500_count_d > 1.5) => -0.0361488434,
         (f_rel_homeover500_count_d = NULL) => 0.0408619360, 0.0408619360),
      (f_phone_ver_experian_d > 0.5) => 0.0111184736,
      (f_phone_ver_experian_d = NULL) => -0.0151607356, 0.0170199184),
   (r_pb_order_freq_d > 41.5) => -0.0151160846,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 173.5) => 0.0112913780,
      (c_no_labfor > 173.5) => -0.0728621586,
      (c_no_labfor = NULL) => 0.0075039086, 0.0075039086), 0.0022897989),
(c_unempl = NULL) => 0.0157648393, -0.0033551481);

// Tree: 218 
woFDN_FL_PSD_lgt_218 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1327163091,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 88.5) => 
         map(
         (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 0.5) => -0.0130962321,
         (f_inq_QuizProvider_count24_i > 0.5) => 0.0702193205,
         (f_inq_QuizProvider_count24_i = NULL) => -0.0081908780, -0.0081908780),
      (c_no_car > 88.5) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 0.1115296492,
         (r_D32_Mos_Since_Crim_LS_d > 9.5) => 0.0149570705,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0166917931, 0.0166917931),
      (c_no_car = NULL) => 0.0253757300, 0.0042750029),
   (f_rel_ageover50_count_d > 1.5) => -0.0261949391,
   (f_rel_ageover50_count_d = NULL) => -0.0268253265, 0.0001920656),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0251872251, 0.0005781557);

// Tree: 219 
woFDN_FL_PSD_lgt_219 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < c_transport and c_transport <= 29.05) => 
      map(
      (NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 3749.5) => 0.0004529317,
      (f_liens_unrel_ST_total_amt_i > 3749.5) => 0.1013350532,
      (f_liens_unrel_ST_total_amt_i = NULL) => -0.0170928836, 0.0007806029),
   (c_transport > 29.05) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 149) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.15) => 0.2240180930,
         (c_pop_75_84_p > 3.15) => 0.0145734952,
         (c_pop_75_84_p = NULL) => 0.1192957941, 0.1192957941),
      (c_blue_empl > 149) => -0.0161665108,
      (c_blue_empl = NULL) => 0.0605336070, 0.0605336070),
   (c_transport = NULL) => -0.0126941043, 0.0014811056),
(k_inq_adls_per_phone_i > 2.5) => -0.0711654815,
(k_inq_adls_per_phone_i = NULL) => 0.0008969549, 0.0008969549);

// Tree: 220 
woFDN_FL_PSD_lgt_220 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 181.5) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 1.25) => -0.1054624654,
   (c_high_hval > 1.25) => 0.0050222176,
   (c_high_hval = NULL) => -0.0528507116, -0.0528507116),
(r_D32_Mos_Since_Fel_LS_d > 181.5) => 
   map(
   (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.35) => -0.0016066922,
   (c_hval_1000k_p > 41.35) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.1557754182,
      (k_nap_fname_verd_d > 0.5) => -0.0081854139,
      (k_nap_fname_verd_d = NULL) => 0.0737950021, 0.0737950021),
   (c_hval_1000k_p = NULL) => -0.0282309011, -0.0014114491),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.55) => -0.0469323452,
   (c_pop_55_64_p > 11.55) => 0.0795810194,
   (c_pop_55_64_p = NULL) => 0.0175646642, 0.0175646642), -0.0016816585);

// Tree: 221 
woFDN_FL_PSD_lgt_221 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 75.2) => 0.0013420533,
   (c_rnt1000_p > 75.2) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 109.35) => 0.0528781943,
      (c_oldhouse > 109.35) => 0.2619648872,
      (c_oldhouse = NULL) => 0.1083703972, 0.1083703972),
   (c_rnt1000_p = NULL) => -0.0234273228, 0.0026292133),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 137.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 15.55) => -0.0231083258,
      (C_INC_125K_P > 15.55) => 0.0926773333,
      (C_INC_125K_P = NULL) => -0.0113747887, -0.0113747887),
   (c_bel_edu > 137.5) => -0.0860377512,
   (c_bel_edu = NULL) => -0.0304127805, -0.0304127805),
(f_varrisktype_i = NULL) => 0.0098358938, 0.0008025136);

// Tree: 222 
woFDN_FL_PSD_lgt_222 := map(
(NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 15776.5) => -0.0911754323,
   (c_med_hhinc > 15776.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 7.05) => 
         map(
         (NULL < C_INC_100K_P and C_INC_100K_P <= 5.05) => 0.1328377863,
         (C_INC_100K_P > 5.05) => 0.0295175856,
         (C_INC_100K_P = NULL) => 0.0484040739, 0.0484040739),
      (c_fammar18_p > 7.05) => -0.0001233624,
      (c_fammar18_p = NULL) => 0.0011611873, 0.0011611873),
   (c_med_hhinc = NULL) => 0.0043349937, 0.0006846211),
(f_rel_ageover50_count_d > 1.5) => -0.0337555221,
(f_rel_ageover50_count_d = NULL) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 0.0940933582,
   (r_C10_M_Hdr_FS_d > 11.5) => -0.0176005846,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0322776247, 0.0192780260), -0.0027860533);

// Tree: 223 
woFDN_FL_PSD_lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 44948.5) => -0.0427115056,
(r_A46_Curr_AVM_AutoVal_d > 44948.5) => 0.0030117171,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 7.55) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 11.05) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 17.55) => 
            map(
            (NULL < c_hval_150k_p and c_hval_150k_p <= 6.6) => 0.0013836231,
            (c_hval_150k_p > 6.6) => 0.1523684983,
            (c_hval_150k_p = NULL) => 0.0551048334, 0.0551048334),
         (C_INC_50K_P > 17.55) => -0.0620419648,
         (C_INC_50K_P = NULL) => 0.0146202781, 0.0146202781),
      (c_rnt1250_p > 11.05) => 0.1241036078,
      (c_rnt1250_p = NULL) => 0.0320021676, 0.0320021676),
   (c_high_ed > 7.55) => -0.0041260972,
   (c_high_ed = NULL) => 0.0247338500, 0.0005545148), 0.0007194681);

// Tree: 224 
woFDN_FL_PSD_lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 0.85) => 0.0073756443,
   (c_low_hval > 0.85) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 17.85) => 0.0282547994,
      (C_INC_75K_P > 17.85) => 0.1786981163,
      (C_INC_75K_P = NULL) => 0.1069914886, 0.1069914886),
   (c_low_hval = NULL) => 0.0505290667, 0.0505290667),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0065010400,
      (f_hh_payday_loan_users_i > 0.5) => 0.0754991782,
      (f_hh_payday_loan_users_i = NULL) => 0.0002878936, 0.0002878936),
   (r_C14_Addr_Stability_v2_d > 3.5) => 0.0008853219,
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0007435667, 0.0007435667),
(r_C10_M_Hdr_FS_d = NULL) => 0.0307387151, 0.0019721864);

// Tree: 225 
woFDN_FL_PSD_lgt_225 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 14799) => -0.0959436955,
(r_A46_Curr_AVM_AutoVal_d > 14799) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
      map(
      (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0044413856,
      (k_inf_nothing_found_i > 0.5) => 0.0313323391,
      (k_inf_nothing_found_i = NULL) => 0.0095635589, 0.0095635589),
   (f_inq_Communications_count24_i > 1.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 5.25) => 0.1486153096,
      (c_hval_150k_p > 5.25) => -0.0029031190,
      (c_hval_150k_p = NULL) => 0.0748324226, 0.0748324226),
   (f_inq_Communications_count24_i = NULL) => 0.0106324736, 0.0106324736),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => -0.0095166744,
   (f_adls_per_phone_c6_i > 1.5) => 0.1528758150,
   (f_adls_per_phone_c6_i = NULL) => -0.0073464256, -0.0073464256), 0.0022498984);

// Tree: 226 
woFDN_FL_PSD_lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => 0.0157757569,
   (f_inq_Collection_count_i > 1.5) => -0.1518773424,
   (f_inq_Collection_count_i = NULL) => -0.0704923427, -0.0704923427),
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 54.5) => 0.1214490591,
      (r_C12_source_profile_d > 54.5) => -0.0242803636,
      (r_C12_source_profile_d = NULL) => 0.0491865354, 0.0491865354),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 5.5) => -0.0034353749,
      (f_inq_HighRiskCredit_count24_i > 5.5) => 0.0614378324,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0029527732, -0.0029527732),
   (r_D33_Eviction_Recency_d = NULL) => -0.0024475797, -0.0024475797),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0065220392, -0.0029336235);

// Tree: 227 
woFDN_FL_PSD_lgt_227 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0040294917,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 41.65) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 1.95) => -0.0186488574,
      (c_hval_150k_p > 1.95) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 316.5) => 
            map(
            (NULL < c_mil_emp and c_mil_emp <= 0.15) => 0.0300611209,
            (c_mil_emp > 0.15) => 0.1287380728,
            (c_mil_emp = NULL) => 0.0615714081, 0.0615714081),
         (r_C21_M_Bureau_ADL_FS_d > 316.5) => -0.0362685273,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0393350591, 0.0393350591),
      (c_hval_150k_p = NULL) => 0.0132879206, 0.0132879206),
   (c_hval_750k_p > 41.65) => 0.1206432632,
   (c_hval_750k_p = NULL) => 0.0213164803, 0.0213164803),
(k_inq_per_ssn_i = NULL) => -0.0009783841, -0.0009783841);

// Tree: 228 
woFDN_FL_PSD_lgt_228 := map(
(NULL < c_span_lang and c_span_lang <= 158.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 43.45) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 9.5) => -0.0086610326,
      (f_inq_HighRiskCredit_count_i > 9.5) => -0.0794161508,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0092917508, -0.0092917508),
   (c_low_ed > 43.45) => 
      map(
      (NULL < c_retired and c_retired <= 2.95) => 0.1170834634,
      (c_retired > 2.95) => 0.0138694434,
      (c_retired = NULL) => 0.0156739877, 0.0156739877),
   (c_low_ed = NULL) => -0.0003192063, -0.0003192063),
(c_span_lang > 158.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 80500) => -0.0224668397,
   (k_estimated_income_d > 80500) => 0.0957854816,
   (k_estimated_income_d = NULL) => -0.0185087890, -0.0185087890),
(c_span_lang = NULL) => -0.0193450451, -0.0046081654);

// Tree: 229 
woFDN_FL_PSD_lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 25.35) => -0.0019085991,
   (c_hval_500k_p > 25.35) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 508922.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0026033211,
         (r_D30_Derog_Count_i > 1.5) => 
            map(
            (NULL < c_robbery and c_robbery <= 60) => -0.0392000961,
            (c_robbery > 60) => 0.1395749666,
            (c_robbery = NULL) => 0.0699846737, 0.0699846737),
         (r_D30_Derog_Count_i = NULL) => 0.0137710870, 0.0137710870),
      (c_med_hval > 508922.5) => 0.1780020337,
      (c_med_hval = NULL) => 0.0291677383, 0.0291677383),
   (c_hval_500k_p = NULL) => 0.0164316755, 0.0011056358),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0638150527,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0423903844, -0.0018881310);

// Tree: 230 
woFDN_FL_PSD_lgt_230 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
   map(
   (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 198.5) => 0.0006569428,
      (c_bel_edu > 198.5) => -0.1108761430,
      (c_bel_edu = NULL) => -0.0096310732, -0.0001395029),
   (f_acc_damage_amt_total_i > 275) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 6.5) => 0.2139005483,
      (f_rel_educationover12_count_d > 6.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 105.55) => -0.1087041974,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 105.55) => 0.0752493579,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0490747568, 0.0148661007),
      (f_rel_educationover12_count_d = NULL) => 0.0713395426, 0.0713395426),
   (f_acc_damage_amt_total_i = NULL) => 0.0015181478, 0.0015181478),
(f_inq_count24_i > 14.5) => -0.0970838016,
(f_inq_count24_i = NULL) => -0.0053899096, 0.0007117267);

// Tree: 231 
woFDN_FL_PSD_lgt_231 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0653515946,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 12.5) => -0.0000677404,
   (f_srchssnsrchcount_i > 12.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 12.95) => 
         map(
         (NULL < c_health and c_health <= 7.9) => -0.0539842356,
         (c_health > 7.9) => 0.0769062283,
         (c_health = NULL) => 0.0029246618, 0.0029246618),
      (c_hval_150k_p > 12.95) => 0.1148736329,
      (c_hval_150k_p = NULL) => 0.0377830240, 0.0377830240),
   (f_srchssnsrchcount_i = NULL) => 0.0004402018, 0.0004402018),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.85) => -0.0360021754,
   (c_pop_55_64_p > 11.85) => 0.0624890674,
   (c_pop_55_64_p = NULL) => 0.0137124519, 0.0137124519), 0.0008499979);

// Tree: 232 
woFDN_FL_PSD_lgt_232 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1201871910,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 2.75) => 
      map(
      (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 221.5) => 0.0980354904,
      (r_D32_Mos_Since_Fel_LS_d > 221.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0215990334,
         (f_phone_ver_experian_d > 0.5) => -0.0062937317,
         (f_phone_ver_experian_d = NULL) => -0.0064491707, 0.0024029388),
      (r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0032704578, 0.0032704578),
   (c_hh6_p > 2.75) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID']) => -0.0608418005,
      (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0098916857,
      (nf_seg_FraudPoint_3_0 = '') => -0.0152241372, -0.0152241372),
   (c_hh6_p = NULL) => -0.0045812973, -0.0025938387),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0127783281, -0.0021732150);

// Tree: 233 
woFDN_FL_PSD_lgt_233 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => 0.0031593369,
(r_C14_addrs_10yr_i > 2.5) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 22.55) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 37.5) => -0.0231679845,
      (f_rel_incomeover25_count_d > 37.5) => -0.1217300039,
      (f_rel_incomeover25_count_d = NULL) => -0.0249569718, -0.0249569718),
   (c_hval_250k_p > 22.55) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 0.0125921681,
      (f_hh_lienholders_i > 1.5) => 0.1154198132,
      (f_hh_lienholders_i = NULL) => 0.0243813248, 0.0243813248),
   (c_hval_250k_p = NULL) => -0.0175302100, -0.0175302100),
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 6.2) => 0.0751624545,
   (c_construction > 6.2) => -0.0317630713,
   (c_construction = NULL) => 0.0201425237, 0.0201425237), -0.0035754379);

// Tree: 234 
woFDN_FL_PSD_lgt_234 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 17.95) => -0.0089021202,
   (c_pop_18_24_p > 17.95) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 2.5) => 0.0073551606,
      (f_assocsuspicousidcount_i > 2.5) => 0.1012922867,
      (f_assocsuspicousidcount_i = NULL) => 0.0323777138, 0.0323777138),
   (c_pop_18_24_p = NULL) => -0.0180208716, -0.0068272314),
(f_srchcomponentrisktype_i > 3.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 65.65) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 132.5) => -0.0573555317,
      (c_for_sale > 132.5) => 0.1078040553,
      (c_for_sale = NULL) => -0.0042685216, -0.0042685216),
   (r_C12_source_profile_d > 65.65) => 0.1271102084,
   (r_C12_source_profile_d = NULL) => 0.0418644676, 0.0418644676),
(f_srchcomponentrisktype_i = NULL) => 0.0285613162, -0.0056039337);

// Tree: 235 
woFDN_FL_PSD_lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08241820445) => 0.0078411560,
   (f_add_curr_nhood_VAC_pct_i > 0.08241820445) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 3.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => 0.0056727531,
         (f_addrs_per_ssn_i > 5.5) => 
            map(
            (NULL < k_comb_age_d and k_comb_age_d <= 49.5) => 0.2472847874,
            (k_comb_age_d > 49.5) => 0.0877739995,
            (k_comb_age_d = NULL) => 0.1870251564, 0.1870251564),
         (f_addrs_per_ssn_i = NULL) => 0.1144841951, 0.1144841951),
      (r_C14_addrs_15yr_i > 3.5) => 0.0128832859,
      (r_C14_addrs_15yr_i = NULL) => 0.0694679507, 0.0694679507),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0183418835, 0.0183418835),
(f_hh_members_ct_d > 1.5) => -0.0064467451,
(f_hh_members_ct_d = NULL) => 0.0173585330, -0.0016201166);

// Tree: 236 
woFDN_FL_PSD_lgt_236 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 29.05) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 171.5) => -0.1002580972,
   (f_mos_liens_unrel_CJ_lseen_d > 171.5) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 3.5) => 0.0990264005,
      (f_mos_inq_banko_om_lseen_d > 3.5) => -0.0238448514,
      (f_mos_inq_banko_om_lseen_d = NULL) => -0.0179895498, -0.0179895498),
   (f_mos_liens_unrel_CJ_lseen_d = NULL) => -0.0228689257, -0.0228689257),
(C_OWNOCC_P > 29.05) => 0.0048494236,
(C_OWNOCC_P = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => -0.0644143085,
   (f_util_adl_count_n > 1.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 25500) => 0.2396477792,
      (k_estimated_income_d > 25500) => -0.0363462398,
      (k_estimated_income_d = NULL) => 0.0795291117, 0.0795291117),
   (f_util_adl_count_n = NULL) => -0.0051168618, -0.0051168618), 0.0013908535);

// Tree: 237 
woFDN_FL_PSD_lgt_237 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 14.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.65) => 
      map(
      (NULL < c_retired and c_retired <= 6.85) => -0.1031159345,
      (c_retired > 6.85) => 0.0234513480,
      (c_retired = NULL) => -0.0221368675, -0.0221368675),
   (c_pop_6_11_p > 7.65) => 
      map(
      (NULL < c_robbery and c_robbery <= 112.5) => 0.0343539155,
      (c_robbery > 112.5) => 0.1677487623,
      (c_robbery = NULL) => 0.0810845943, 0.0810845943),
   (c_pop_6_11_p = NULL) => 0.0219005496, 0.0219005496),
(r_C10_M_Hdr_FS_d > 14.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 15.25) => -0.0012276450,
   (c_pop_0_5_p > 15.25) => -0.0522900668,
   (c_pop_0_5_p = NULL) => -0.0037894904, -0.0030420034),
(r_C10_M_Hdr_FS_d = NULL) => -0.0013760076, -0.0022919002);

// Tree: 238 
woFDN_FL_PSD_lgt_238 := map(
(NULL < C_INC_150K_P and C_INC_150K_P <= 0.65) => 
   map(
   (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 11.5) => -0.1377324657,
      (f_mos_inq_banko_cm_lseen_d > 11.5) => -0.0459056442,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0545293805, -0.0545293805),
   (r_F04_curr_add_occ_index_d > 2) => 
      map(
      (NULL < c_rnt250_p and c_rnt250_p <= 18.75) => 
         map(
         (NULL < c_professional and c_professional <= 3.85) => -0.0005658031,
         (c_professional > 3.85) => 0.1626428337,
         (c_professional = NULL) => 0.0517841370, 0.0517841370),
      (c_rnt250_p > 18.75) => -0.0763345335,
      (c_rnt250_p = NULL) => 0.0206696027, 0.0206696027),
   (r_F04_curr_add_occ_index_d = NULL) => -0.0344124551, -0.0344124551),
(C_INC_150K_P > 0.65) => -0.0019625778,
(C_INC_150K_P = NULL) => 0.0054856290, -0.0038086072);

// Tree: 239 
woFDN_FL_PSD_lgt_239 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 97.25) => -0.0076979806,
   (c_sfdu_p > 97.25) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 72) => 0.1540102341,
      (f_mos_liens_unrel_CJ_lseen_d > 72) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 9) => 
            map(
            (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 0.1816899599,
            (r_Prop_Owner_History_d > 1.5) => 0.0346130581,
            (r_Prop_Owner_History_d = NULL) => 0.0596003166, 0.0596003166),
         (r_I60_inq_recency_d > 9) => -0.0032961661,
         (r_I60_inq_recency_d = NULL) => 0.0118576497, 0.0118576497),
      (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0155871827, 0.0155871827),
   (c_sfdu_p = NULL) => 0.0123364528, -0.0034826591),
(f_prevaddrcartheftindex_i > 194.5) => -0.0655877822,
(f_prevaddrcartheftindex_i = NULL) => 0.0304200257, -0.0044705538);

// Tree: 240 
woFDN_FL_PSD_lgt_240 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 27.25) => 0.0005505114,
(c_hval_500k_p > 27.25) => 
   map(
   (NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 18) => -0.0975524926,
   (r_I60_inq_retail_recency_d > 18) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 166.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 8.25) => 0.0945512480,
         (c_hh6_p > 8.25) => -0.0639084263,
         (c_hh6_p = NULL) => 0.0722757666, 0.0722757666),
      (c_ab_av_edu > 166.5) => -0.0584176444,
      (c_ab_av_edu = NULL) => 0.0496590733, 0.0496590733),
   (r_I60_inq_retail_recency_d = NULL) => 0.0378535285, 0.0378535285),
(c_hval_500k_p = NULL) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => -0.0741021320,
   (f_phone_ver_insurance_d > 2.5) => 0.1041987668,
   (f_phone_ver_insurance_d = NULL) => -0.0132908983, -0.0132908983), 0.0026673252);

// Tree: 241 
woFDN_FL_PSD_lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0021989803,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 142) => 
      map(
      (NULL < c_young and c_young <= 26.15) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 100.5) => 0.0733625667,
         (r_pb_order_freq_d > 100.5) => -0.0268136999,
         (r_pb_order_freq_d = NULL) => 0.1172443070, 0.0504827657),
      (c_young > 26.15) => -0.0779420149,
      (c_young = NULL) => 0.0258281516, 0.0258281516),
   (f_curraddrcrimeindex_i > 142) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 0.0569284588,
      (r_C14_addrs_15yr_i > 1.5) => 0.2427703444,
      (r_C14_addrs_15yr_i = NULL) => 0.1289421894, 0.1289421894),
   (f_curraddrcrimeindex_i = NULL) => 0.0445336460, 0.0445336460),
(k_comb_age_d = NULL) => 0.0010577514, 0.0010577514);

// Tree: 242 
woFDN_FL_PSD_lgt_242 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 848.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 0.5) => -0.0150848659,
      (f_inq_HighRiskCredit_count_i > 0.5) => -0.0613566500,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0181231939, -0.0181231939),
   (c_popover25 > 848.5) => 0.0076065754,
   (c_popover25 = NULL) => -0.0407498734, -0.0013401554),
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 41.65) => 0.0227899180,
   (c_hval_750k_p > 41.65) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 10) => 0.0031219792,
      (C_INC_125K_P > 10) => 0.1855241824,
      (C_INC_125K_P = NULL) => 0.0993499131, 0.0993499131),
   (c_hval_750k_p = NULL) => 0.0292205526, 0.0292205526),
(k_inq_per_ssn_i = NULL) => 0.0023507397, 0.0023507397);

// Tree: 243 
woFDN_FL_PSD_lgt_243 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 376.5) => 0.0016314283,
   (r_C13_max_lres_d > 376.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 1.95) => 0.1793709198,
      (c_femdiv_p > 1.95) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 4.5) => 0.1502350448,
         (f_prevaddrcartheftindex_i > 4.5) => -0.0076888037,
         (f_prevaddrcartheftindex_i = NULL) => 0.0160728865, 0.0160728865),
      (c_femdiv_p = NULL) => 0.0413185707, 0.0413185707),
   (r_C13_max_lres_d = NULL) => 0.0059651337, 0.0032929712),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 240.5) => 0.2052986155,
   (f_M_Bureau_ADL_FS_noTU_d > 240.5) => 0.0159498332,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0772419246, 0.0772419246),
(f_adls_per_phone_c6_i = NULL) => 0.0043014985, 0.0043014985);

// Tree: 244 
woFDN_FL_PSD_lgt_244 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => -0.0115777139,
(f_curraddrcrimeindex_i > 121) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 97.1) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 
         map(
         (NULL < c_professional and c_professional <= 4.05) => 0.1210031329,
         (c_professional > 4.05) => -0.0153841389,
         (c_professional = NULL) => 0.0572707629, 0.0572707629),
      (r_F00_dob_score_d > 98) => 0.0079979395,
      (r_F00_dob_score_d = NULL) => 0.0247513497, 0.0102060968),
   (c_lowrent > 97.1) => 0.1865313419,
   (c_lowrent = NULL) => 0.0148631388, 0.0148631388),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 102.5) => -0.0694121145,
   (c_medi_indx > 102.5) => 0.0518830716,
   (c_medi_indx = NULL) => -0.0087645215, -0.0087645215), -0.0046879086);

// Tree: 245 
woFDN_FL_PSD_lgt_245 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 47004) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 3.5) => 0.0060120638,
   (f_rel_under25miles_cnt_d > 3.5) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 166.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 183.5) => 0.0176762949,
         (c_born_usa > 183.5) => 0.1690471829,
         (c_born_usa = NULL) => 0.0322421728, 0.0322421728),
      (c_very_rich > 166.5) => 0.1789660767,
      (c_very_rich = NULL) => 0.0533381784, 0.0533381784),
   (f_rel_under25miles_cnt_d = NULL) => 0.0146443191, 0.0128722724),
(f_prevaddrmedianincome_d > 47004) => -0.0086831940,
(f_prevaddrmedianincome_d = NULL) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 6.4) => -0.0005266207,
   (c_vacant_p > 6.4) => -0.0907756197,
   (c_vacant_p = NULL) => -0.0465188990, -0.0465188990), -0.0011737251);

// Tree: 246 
woFDN_FL_PSD_lgt_246 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 8.65) => 
      map(
      (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 21.5) => -0.0926198696,
      (f_mos_inq_banko_am_lseen_d > 21.5) => 0.0031580194,
      (f_mos_inq_banko_am_lseen_d = NULL) => 0.0013784592, 0.0013784592),
   (c_pop_85p_p > 8.65) => -0.0754509936,
   (c_pop_85p_p = NULL) => -0.0061662826, -0.0005410826),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 95.75) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 10) => 0.1122691806,
      (C_INC_100K_P > 10) => -0.0230204830,
      (C_INC_100K_P = NULL) => 0.0157343686, 0.0157343686),
   (c_occunit_p > 95.75) => 0.1763805883,
   (c_occunit_p = NULL) => 0.0582040588, 0.0582040588),
(f_assoccredbureaucountnew_i = NULL) => -0.0206497771, 0.0005479867);

// Tree: 247 
woFDN_FL_PSD_lgt_247 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 0.5) => -0.0066940576,
      (f_addrs_per_ssn_c6_i > 0.5) => 
         map(
         (NULL < c_rnt250_p and c_rnt250_p <= 1.85) => 0.0006012588,
         (c_rnt250_p > 1.85) => 
            map(
            (NULL < c_housingcpi and c_housingcpi <= 213.1) => 0.2074812000,
            (c_housingcpi > 213.1) => 0.0346316535,
            (c_housingcpi = NULL) => 0.0614774958, 0.0614774958),
         (c_rnt250_p = NULL) => 0.0182905533, 0.0182905533),
      (f_addrs_per_ssn_c6_i = NULL) => -0.0040899486, -0.0040899486),
   (r_D33_eviction_count_i > 3.5) => 0.0738632675,
   (r_D33_eviction_count_i = NULL) => -0.0036483754, -0.0036483754),
(f_inq_HighRiskCredit_count_i > 21.5) => -0.0792104669,
(f_inq_HighRiskCredit_count_i = NULL) => -0.0068350013, -0.0039715882);

// Tree: 248 
woFDN_FL_PSD_lgt_248 := map(
(NULL < c_many_cars and c_many_cars <= 134.5) => -0.0125988126,
(c_many_cars > 134.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 18.85) => 
      map(
      (NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => 0.0056522839,
      (f_srchunvrfdssncount_i > 0.5) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 55) => 0.2292519678,
         (c_span_lang > 55) => 
            map(
            (NULL < c_femdiv_p and c_femdiv_p <= 4.95) => -0.0404872395,
            (c_femdiv_p > 4.95) => 0.1493849447,
            (c_femdiv_p = NULL) => 0.0259016361, 0.0259016361),
         (c_span_lang = NULL) => 0.0793597130, 0.0793597130),
      (f_srchunvrfdssncount_i = NULL) => 0.0097307896, 0.0097307896),
   (C_INC_25K_P > 18.85) => 0.2016948945,
   (C_INC_25K_P = NULL) => 0.0124608982, 0.0124608982),
(c_many_cars = NULL) => 0.0376722698, -0.0043058048);

// Tree: 249 
woFDN_FL_PSD_lgt_249 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 10.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0062186020,
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 104.15) => 0.0014190123,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 104.15) => 0.0719126689,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0169906426, 0.0253612016),
      (k_nap_phn_verd_d > 0.5) => -0.0038164284,
      (k_nap_phn_verd_d = NULL) => 0.0056052856, 0.0056052856),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0011981080, -0.0011981080),
(f_inq_HighRiskCredit_count24_i > 10.5) => 0.0588397170,
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 69.25) => -0.0983110006,
   (C_OWNOCC_P > 69.25) => 0.0116417183,
   (C_OWNOCC_P = NULL) => -0.0428008901, -0.0428008901), -0.0012730681);

// Tree: 250 
woFDN_FL_PSD_lgt_250 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => -0.0025947249,
(C_INC_50K_P > 19.85) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 44.85) => 0.1475654230,
   (c_civ_emp > 44.85) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 20.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 3.5) => 0.1107604533,
         (r_C13_Curr_Addr_LRes_d > 3.5) => 0.0013803632,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0103868588, 0.0103868588),
      (f_rel_ageover20_count_d > 20.5) => 
         map(
         (NULL < c_highinc and c_highinc <= 4.9) => 0.0004160387,
         (c_highinc > 4.9) => 0.1596493014,
         (c_highinc = NULL) => 0.0785582880, 0.0785582880),
      (f_rel_ageover20_count_d = NULL) => 0.0169840938, 0.0169840938),
   (c_civ_emp = NULL) => 0.0258801455, 0.0258801455),
(C_INC_50K_P = NULL) => -0.0015549221, 0.0001984839);

// Tree: 251 
woFDN_FL_PSD_lgt_251 := map(
(NULL < C_INC_125K_P and C_INC_125K_P <= 1.85) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1096.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 9.15) => 0.0253125509,
      (C_INC_50K_P > 9.15) => -0.0663233869,
      (C_INC_50K_P = NULL) => -0.0469388616, -0.0469388616),
   (c_popover25 > 1096.5) => 0.0660718449,
   (c_popover25 = NULL) => -0.0290522749, -0.0290522749),
(C_INC_125K_P > 1.85) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 10.95) => 
      map(
      (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 1.5) => 0.1150457202,
      (f_property_owners_ct_d > 1.5) => -0.0319594417,
      (f_property_owners_ct_d = NULL) => 0.0568561769, 0.0568561769),
   (c_hh2_p > 10.95) => 0.0064787370,
   (c_hh2_p = NULL) => 0.0070965776, 0.0070965776),
(C_INC_125K_P = NULL) => -0.0178769137, 0.0049096914);

// Tree: 252 
woFDN_FL_PSD_lgt_252 := map(
(NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 3.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 120) => 0.1003067065,
   (r_D32_Mos_Since_Fel_LS_d > 120) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
         map(
         (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 113.5) => 0.0090866875,
         (f_fp_prevaddrburglaryindex_i > 113.5) => 0.1051168566,
         (f_fp_prevaddrburglaryindex_i = NULL) => 0.0398789700, 0.0398789700),
      (r_F00_dob_score_d > 95) => 0.0043700660,
      (r_F00_dob_score_d = NULL) => -0.0175596302, 0.0047666989),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0052720722, 0.0052720722),
(r_C14_addrs_5yr_i > 3.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 6.55) => -0.0014873951,
   (c_hval_100k_p > 6.55) => -0.0721484509,
   (c_hval_100k_p = NULL) => -0.0212561529, -0.0212561529),
(r_C14_addrs_5yr_i = NULL) => 0.0258451115, 0.0036088015);

// Tree: 253 
woFDN_FL_PSD_lgt_253 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 5.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 208.5) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 17.5) => 
         map(
         (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 32.5) => 0.1277916841,
         (f_mos_inq_banko_om_fseen_d > 32.5) => 0.0222753801,
         (f_mos_inq_banko_om_fseen_d = NULL) => 0.0314824815, 0.0314824815),
      (f_rel_ageover30_count_d > 17.5) => -0.0521336399,
      (f_rel_ageover30_count_d = NULL) => 0.0240440757, 0.0240440757),
   (c_cpiall > 208.5) => -0.0065895253,
   (c_cpiall = NULL) => 0.0031089110, -0.0023853174),
(r_D34_unrel_liens_ct_i > 5.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 102) => -0.1239193621,
   (c_rich_wht > 102) => -0.0237384575,
   (c_rich_wht = NULL) => -0.0748511639, -0.0748511639),
(r_D34_unrel_liens_ct_i = NULL) => -0.0054544087, -0.0032537848);

// Tree: 254 
woFDN_FL_PSD_lgt_254 := map(
(NULL < c_hh4_p and c_hh4_p <= 17.45) => -0.0103887229,
(c_hh4_p > 17.45) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 32.8) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 39.05) => 
         map(
         (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 1.5) => 0.0031669676,
         (f_inq_HighRiskCredit_count24_i > 1.5) => 0.0604751611,
         (f_inq_HighRiskCredit_count24_i = NULL) => 0.0047017571, 0.0047017571),
      (c_hval_500k_p > 39.05) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 26.05) => -0.0418506439,
         (c_hh2_p > 26.05) => 0.2427717238,
         (c_hh2_p = NULL) => 0.1229307269, 0.1229307269),
      (c_hval_500k_p = NULL) => 0.0084182432, 0.0084182432),
   (c_hh3_p > 32.8) => 0.1810239342,
   (c_hh3_p = NULL) => 0.0104341938, 0.0104341938),
(c_hh4_p = NULL) => 0.0401872835, -0.0020973945);

// Tree: 255 
woFDN_FL_PSD_lgt_255 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 11.15) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => -0.1060319312,
      (r_D33_Eviction_Recency_d > 79.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 57.15) => -0.0288737525,
         (c_hval_750k_p > 57.15) => 0.1287321961,
         (c_hval_750k_p = NULL) => -0.0251863680, -0.0251863680),
      (r_D33_Eviction_Recency_d = NULL) => -0.0268008874, -0.0268008874),
   (r_S66_adlperssn_count_i > 3.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 11.55) => 0.0049191041,
      (c_hh4_p > 11.55) => 0.1486909166,
      (c_hh4_p = NULL) => 0.0656426025, 0.0656426025),
   (r_S66_adlperssn_count_i = NULL) => -0.0216473549, -0.0216473549),
(c_pop_35_44_p > 11.15) => 0.0056865552,
(c_pop_35_44_p = NULL) => 0.0127711739, -0.0003734861);

// Tree: 256 
woFDN_FL_PSD_lgt_256 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 5.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 14.95) => 0.0890977584,
      (c_hh2_p > 14.95) => -0.0377606206,
      (c_hh2_p = NULL) => -0.0603227866, -0.0348298951),
   (f_rel_incomeover50_count_d > 0.5) => 0.0062279167,
   (f_rel_incomeover50_count_d = NULL) => -0.0478829425, 0.0021482729),
(f_varrisktype_i > 5.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 12.55) => -0.1048660945,
   (c_rnt1000_p > 12.55) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 81.5) => 0.0627363999,
      (c_new_homes > 81.5) => -0.0646610644,
      (c_new_homes = NULL) => -0.0039956052, -0.0039956052),
   (c_rnt1000_p = NULL) => -0.0482275845, -0.0482275845),
(f_varrisktype_i = NULL) => 0.0296747701, 0.0016165001);

// Tree: 257 
woFDN_FL_PSD_lgt_257 := map(
(NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 804) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.05) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 11.5) => 0.0005403833,
      (f_rel_incomeover100_count_d > 11.5) => 0.1198358370,
      (f_rel_incomeover100_count_d = NULL) => 
         map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 7.5) => -0.0411045468,
         (f_sourcerisktype_i > 7.5) => 0.0859803270,
         (f_sourcerisktype_i = NULL) => 0.0156931622, 0.0156931622), 0.0015545272),
   (c_manufacturing > 16.05) => -0.0507916445,
   (c_manufacturing = NULL) => 0.0175101207, -0.0019960090),
(f_liens_unrel_O_total_amt_i > 804) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 1.4) => -0.0959208148,
   (c_trailer_p > 1.4) => 0.0559284887,
   (c_trailer_p = NULL) => -0.0556195778, -0.0556195778),
(f_liens_unrel_O_total_amt_i = NULL) => 0.0311354982, -0.0026466858);

// Tree: 258 
woFDN_FL_PSD_lgt_258 := map(
(NULL < c_construction and c_construction <= 27.35) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 3166.5) => 0.0029395655,
   (f_liens_unrel_SC_total_amt_i > 3166.5) => -0.0655898962,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0140087369, 0.0023422592),
(c_construction > 27.35) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 0.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 138.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.4) => 0.1576046433,
         (c_pop_35_44_p > 15.4) => -0.0600135881,
         (c_pop_35_44_p = NULL) => 0.0676905237, 0.0676905237),
      (c_new_homes > 138.5) => -0.1010644930,
      (c_new_homes = NULL) => -0.0083602568, -0.0083602568),
   (f_assocsuspicousidcount_i > 0.5) => -0.0521435631,
   (f_assocsuspicousidcount_i = NULL) => -0.0412067306, -0.0412067306),
(c_construction = NULL) => 0.0256102328, -0.0013469220);

// Tree: 259 
woFDN_FL_PSD_lgt_259 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 15.5) => 
   map(
   (NULL < r_D31_bk_chapter_n and r_D31_bk_chapter_n <= 9) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.40099696835) => -0.0498401438,
      (f_add_curr_mobility_index_i > 0.40099696835) => 0.0859736633,
      (f_add_curr_mobility_index_i = NULL) => -0.0383375459, -0.0383375459),
   (r_D31_bk_chapter_n > 9) => -0.0415183741,
   (r_D31_bk_chapter_n = NULL) => -0.0029390031, -0.0066143259),
(f_rel_homeover500_count_d > 15.5) => 0.1018083343,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.11244913925) => -0.0353862076,
   (f_add_curr_nhood_BUS_pct_i > 0.11244913925) => 0.1114377881,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 34.5) => -0.0504564295,
      (k_comb_age_d > 34.5) => 0.0591373420,
      (k_comb_age_d = NULL) => -0.0083049789, -0.0083049789), -0.0016540352), -0.0060183101);

// Tree: 260 
woFDN_FL_PSD_lgt_260 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 26.15) => -0.0027998249,
(c_hval_750k_p > 26.15) => 
   map(
   (NULL < c_med_yearblt and c_med_yearblt <= 1971.5) => 
      map(
      (NULL < c_professional and c_professional <= 1.75) => 
         map(
         (NULL < c_exp_homes and c_exp_homes <= 159) => 0.0512154626,
         (c_exp_homes > 159) => 0.2715153044,
         (c_exp_homes = NULL) => 0.1092728216, 0.1092728216),
      (c_professional > 1.75) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 6.5) => -0.0307930416,
         (f_rel_educationover12_count_d > 6.5) => 0.0846659855,
         (f_rel_educationover12_count_d = NULL) => 0.0237971026, 0.0237971026),
      (c_professional = NULL) => 0.0484091340, 0.0484091340),
   (c_med_yearblt > 1971.5) => -0.0118884484,
   (c_med_yearblt = NULL) => 0.0194662945, 0.0194662945),
(c_hval_750k_p = NULL) => -0.0245154995, -0.0001088728);

// Tree: 261 
woFDN_FL_PSD_lgt_261 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 20.85) => -0.0006604072,
(C_INC_50K_P > 20.85) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.1094746753,
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 32499) => 
         map(
         (NULL < c_rape and c_rape <= 36.5) => 0.2583035425,
         (c_rape > 36.5) => 
            map(
            (NULL < c_food and c_food <= 37.15) => 0.0689013738,
            (c_food > 37.15) => -0.1167656616,
            (c_food = NULL) => 0.0256315139, 0.0256315139),
         (c_rape = NULL) => 0.0663084420, 0.0663084420),
      (r_A49_Curr_AVM_Chg_1yr_i > 32499) => -0.1238540012,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0202402181, 0.0270562010),
   (r_D33_Eviction_Recency_d = NULL) => 0.0320914133, 0.0320914133),
(C_INC_50K_P = NULL) => 0.0185319938, 0.0022194408);

// Tree: 262 
woFDN_FL_PSD_lgt_262 := map(
(NULL < c_hval_100k_p and c_hval_100k_p <= 47.85) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => -0.0030676416,
   (f_util_adl_count_n > 3.5) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 59.5) => 0.1074430001,
      (f_mos_liens_unrel_CJ_lseen_d > 59.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 21.5) => 0.1160464493,
         (k_comb_age_d > 21.5) => 
            map(
            (NULL < r_C18_Inv_Add_Per_ADL_c6_i and r_C18_Inv_Add_Per_ADL_c6_i <= 0.5) => 0.0189431246,
            (r_C18_Inv_Add_Per_ADL_c6_i > 0.5) => -0.0790953627,
            (r_C18_Inv_Add_Per_ADL_c6_i = NULL) => 0.0125513997, 0.0125513997),
         (k_comb_age_d = NULL) => 0.0151721535, 0.0151721535),
      (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0179928463, 0.0179928463),
   (f_util_adl_count_n = NULL) => -0.0074213003, 0.0005949250),
(c_hval_100k_p > 47.85) => 0.0986538556,
(c_hval_100k_p = NULL) => -0.0000558753, 0.0011352947);

// Tree: 263 
woFDN_FL_PSD_lgt_263 := map(
(NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 104) => -0.0914517086,
(f_mos_liens_rel_SC_lseen_d > 104) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 7.35) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 0.05) => 0.0140364908,
      (c_hh7p_p > 0.05) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 2.95) => 
            map(
            (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 19) => 0.1998824288,
            (r_pb_order_freq_d > 19) => 0.0502686141,
            (r_pb_order_freq_d = NULL) => 0.1568693846, 0.1259275490),
         (c_hh6_p > 2.95) => -0.0175532397,
         (c_hh6_p = NULL) => 0.0734033317, 0.0734033317),
      (c_hh7p_p = NULL) => 0.0290006757, 0.0290006757),
   (c_hh3_p > 7.35) => 0.0010873720,
   (c_hh3_p = NULL) => 0.0022298269, 0.0040895528),
(f_mos_liens_rel_SC_lseen_d = NULL) => -0.0223751808, 0.0033511487);

// Tree: 264 
woFDN_FL_PSD_lgt_264 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 81.5) => 0.1410751689,
   (c_work_home > 81.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 0.5) => -0.0833053114,
      (f_inq_Collection_count_i > 0.5) => 0.0667322131,
      (f_inq_Collection_count_i = NULL) => -0.0113278503, -0.0113278503),
   (c_work_home = NULL) => 0.0455003941, 0.0455003941),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < r_P85_Phn_Invalid_i and r_P85_Phn_Invalid_i <= 0.5) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 0.0042954139,
      (f_addrs_per_ssn_c6_i > 1.5) => 0.0807555275,
      (f_addrs_per_ssn_c6_i = NULL) => 0.0052768895, 0.0052768895),
   (r_P85_Phn_Invalid_i > 0.5) => -0.0552370260,
   (r_P85_Phn_Invalid_i = NULL) => 0.0039294137, 0.0039294137),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0100288192, 0.0045982679);

// Tree: 265 
woFDN_FL_PSD_lgt_265 := map(
(NULL < c_hval_1001k_p and c_hval_1001k_p <= 65.3) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 268.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 12.9) => 0.1113146876,
      (c_white_col > 12.9) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 35.85) => 0.0035201703,
         (c_hval_200k_p > 35.85) => 0.1589359685,
         (c_hval_200k_p = NULL) => 0.0042198633, 0.0042198633),
      (c_white_col = NULL) => 0.0047476130, 0.0047476130),
   (c_oldhouse > 268.5) => -0.0266092616,
   (c_oldhouse = NULL) => 0.0018508570, 0.0018508570),
(c_hval_1001k_p > 65.3) => 0.1335995840,
(c_hval_1001k_p = NULL) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 316.5) => -0.0189187291,
   (r_C10_M_Hdr_FS_d > 316.5) => 0.1591330298,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0122862183, 0.0122862183), 0.0030690183);

// Tree: 266 
woFDN_FL_PSD_lgt_266 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 40.45) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 34.05) => 0.0007419156,
   (c_hval_40k_p > 34.05) => 0.1053880076,
   (c_hval_40k_p = NULL) => 0.0012394821, 0.0012394821),
(c_famotf18_p > 40.45) => 
   map(
   (NULL < c_mort_indx and c_mort_indx <= 118.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 88.5) => 
         map(
         (NULL < c_child and c_child <= 27.05) => -0.1269806443,
         (c_child > 27.05) => 0.0156967166,
         (c_child = NULL) => -0.0371213449, -0.0371213449),
      (r_C13_Curr_Addr_LRes_d > 88.5) => -0.1124327100,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0623855408, -0.0623855408),
   (c_mort_indx > 118.5) => 0.0392394172,
   (c_mort_indx = NULL) => -0.0446541028, -0.0446541028),
(c_famotf18_p = NULL) => -0.0175967083, -0.0006145868);

// Tree: 267 
woFDN_FL_PSD_lgt_267 := map(
(NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 25.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 0.5) => 0.2010723167,
      (f_phone_ver_insurance_d > 0.5) => 0.0517428942,
      (f_phone_ver_insurance_d = NULL) => 0.0954691892, 0.0954691892),
   (r_C13_max_lres_d > 25.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 188.5) => 0.0000610683,
      (c_sub_bus > 188.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0043957955) => 0.1673926630,
         (f_add_curr_nhood_VAC_pct_i > 0.0043957955) => 0.0253789993,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0578272251, 0.0578272251),
      (c_sub_bus = NULL) => 0.0317434534, 0.0037790966),
   (r_C13_max_lres_d = NULL) => 0.0153620962, 0.0063531028),
(r_Phn_Cell_n > 0.5) => -0.0145668213,
(r_Phn_Cell_n = NULL) => -0.0034809932, -0.0034809932);

// Tree: 268 
woFDN_FL_PSD_lgt_268 := map(
(NULL < c_mining and c_mining <= 4.25) => 
   map(
   (NULL < f_nae_email_verd_d and f_nae_email_verd_d <= 0.5) => 
      map(
      (NULL < r_I60_inq_mortgage_recency_d and r_I60_inq_mortgage_recency_d <= 18) => -0.0569014412,
      (r_I60_inq_mortgage_recency_d > 18) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 9.5) => 
            map(
            (NULL < c_bel_edu and c_bel_edu <= 190.5) => 0.0220485638,
            (c_bel_edu > 190.5) => 0.1498928869,
            (c_bel_edu = NULL) => 0.0258997513, 0.0258997513),
         (r_C13_Curr_Addr_LRes_d > 9.5) => 0.0007584611,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0045348966, 0.0045348966),
      (r_I60_inq_mortgage_recency_d = NULL) => -0.0000720903, 0.0023430198),
   (f_nae_email_verd_d > 0.5) => -0.0620084679,
   (f_nae_email_verd_d = NULL) => 0.0002658013, 0.0002658013),
(c_mining > 4.25) => -0.0768261090,
(c_mining = NULL) => -0.0351306252, -0.0017785522);

// Tree: 269 
woFDN_FL_PSD_lgt_269 := map(
(NULL < c_retail and c_retail <= 17.45) => -0.0107167387,
(c_retail > 17.45) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 69) => -0.0070914315,
   (f_prevaddrmurderindex_i > 69) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 164.5) => 0.0225677881,
      (c_sub_bus > 164.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 22.05) => 
            map(
            (NULL < c_pop_25_34_p and c_pop_25_34_p <= 17.95) => 0.1024269515,
            (c_pop_25_34_p > 17.95) => -0.0424457640,
            (c_pop_25_34_p = NULL) => 0.0433150074, 0.0433150074),
         (C_INC_75K_P > 22.05) => 0.2412315107,
         (C_INC_75K_P = NULL) => 0.0812935796, 0.0812935796),
      (c_sub_bus = NULL) => 0.0342812883, 0.0342812883),
   (f_prevaddrmurderindex_i = NULL) => 0.0154148428, 0.0154148428),
(c_retail = NULL) => -0.0082157383, -0.0035978400);

// Tree: 270 
woFDN_FL_PSD_lgt_270 := map(
(NULL < c_many_cars and c_many_cars <= 25.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 170.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 25.45) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 78.5) => 
            map(
            (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 2.5) => -0.0240149556,
            (r_C14_Addr_Stability_v2_d > 2.5) => 0.0050094604,
            (r_C14_Addr_Stability_v2_d = NULL) => -0.0012548020, -0.0012548020),
         (c_civ_emp > 78.5) => 0.2146927721,
         (c_civ_emp = NULL) => 0.0122419213, 0.0122419213),
      (c_hh4_p > 25.45) => 0.1473008307,
      (c_hh4_p = NULL) => 0.0186732980, 0.0186732980),
   (f_fp_prevaddrburglaryindex_i > 170.5) => 0.1302936674,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0279515655, 0.0279515655),
(c_many_cars > 25.5) => -0.0027467150,
(c_many_cars = NULL) => -0.0134965973, -0.0001111789);

// Tree: 271 
woFDN_FL_PSD_lgt_271 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0058069800,
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 2.55) => 
      map(
      (NULL < r_wealth_index_d and r_wealth_index_d <= 1.5) => 0.1813400698,
      (r_wealth_index_d > 1.5) => 0.0625277809,
      (r_wealth_index_d = NULL) => 0.0862902387, 0.0862902387),
   (c_femdiv_p > 2.55) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 17.75) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 88.2) => 0.1864845644,
         (c_sfdu_p > 88.2) => -0.0173846382,
         (c_sfdu_p = NULL) => 0.1005562228, 0.1005562228),
      (c_oldhouse > 17.75) => -0.0153635488,
      (c_oldhouse = NULL) => 0.0004674810, 0.0004674810),
   (c_femdiv_p = NULL) => 0.0193545315, 0.0193545315),
(f_hh_payday_loan_users_i = NULL) => -0.0246435282, -0.0036704196);

// Tree: 272 
woFDN_FL_PSD_lgt_272 := map(
(NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 1.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 41.75) => -0.0021495344,
   (c_rnt1000_p > 41.75) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 113.5) => -0.0219253830,
      (c_asian_lang > 113.5) => 
         map(
         (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 4.5) => 0.0432413892,
         (f_inq_Collection_count_i > 4.5) => 
            map(
            (NULL < c_hval_100k_p and c_hval_100k_p <= 0.65) => 0.0186825076,
            (c_hval_100k_p > 0.65) => 0.2181396992,
            (c_hval_100k_p = NULL) => 0.1236599769, 0.1236599769),
         (f_inq_Collection_count_i = NULL) => 0.0528081801, 0.0528081801),
      (c_asian_lang = NULL) => 0.0261206915, 0.0261206915),
   (c_rnt1000_p = NULL) => 0.0030889808, 0.0019144472),
(f_vardobcountnew_i > 1.5) => 0.0992365974,
(f_vardobcountnew_i = NULL) => -0.0193956549, 0.0024446250);

// Tree: 273 
woFDN_FL_PSD_lgt_273 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 6.5) => 0.0028626545,
(f_assocsuspicousidcount_i > 6.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 3.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 119.5) => -0.0138576328,
      (c_unattach > 119.5) => 0.1275891000,
      (c_unattach = NULL) => 0.0411964847, 0.0411964847),
   (r_C12_source_profile_index_d > 3.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 30.5) => -0.1135349710,
      (c_many_cars > 30.5) => -0.0343763542,
      (c_many_cars = NULL) => -0.0415218429, -0.0415218429),
   (r_C12_source_profile_index_d = NULL) => -0.0261044760, -0.0261044760),
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 11.35) => -0.0331276112,
   (c_rnt1000_p > 11.35) => 0.0653610511,
   (c_rnt1000_p = NULL) => 0.0142227072, 0.0142227072), 0.0009106054);

// Tree: 274 
woFDN_FL_PSD_lgt_274 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 12.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 20.5) => 0.0032135916,
   (f_rel_educationover8_count_d > 20.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 114.5) => 
         map(
         (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 0.5) => 0.1971148977,
         (r_C20_email_domain_free_count_i > 0.5) => 0.0353882158,
         (r_C20_email_domain_free_count_i = NULL) => 0.1155604171, 0.1155604171),
      (c_bargains > 114.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 5.05) => 0.0662756859,
         (c_hval_150k_p > 5.05) => -0.0607983025,
         (c_hval_150k_p = NULL) => -0.0022672533, -0.0022672533),
      (c_bargains = NULL) => 0.0466186950, 0.0466186950),
   (f_rel_educationover8_count_d = NULL) => 0.0043257397, 0.0043257397),
(f_rel_incomeover50_count_d > 12.5) => -0.0239910221,
(f_rel_incomeover50_count_d = NULL) => -0.0143941748, 0.0009795446);

// Tree: 275 
woFDN_FL_PSD_lgt_275 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 76.5) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 0.95) => 0.1522713021,
   (c_pop_65_74_p > 0.95) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 169680) => 0.0146103703,
         (f_prevaddrmedianvalue_d > 169680) => 0.1453445497,
         (f_prevaddrmedianvalue_d = NULL) => 0.0780735642, 0.0780735642),
      (r_D32_Mos_Since_Crim_LS_d > 14.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 22.75) => -0.0040608356,
         (c_hval_250k_p > 22.75) => 0.0687684197,
         (c_hval_250k_p = NULL) => 0.0055931287, 0.0055931287),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0086793151, 0.0086793151),
   (c_pop_65_74_p = NULL) => 0.0610272980, 0.0143319412),
(f_mos_inq_banko_cm_fseen_d > 76.5) => -0.0097404458,
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0007958034, -0.0047781364);

// Tree: 276 
woFDN_FL_PSD_lgt_276 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 24.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 196.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 7.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
            map(
            (NULL < C_INC_100K_P and C_INC_100K_P <= 3.35) => 0.0969549681,
            (C_INC_100K_P > 3.35) => 0.0113991082,
            (C_INC_100K_P = NULL) => 0.0131189392, 0.0131189392),
         (f_phone_ver_experian_d > 0.5) => -0.0033992688,
         (f_phone_ver_experian_d = NULL) => -0.0067522400, 0.0012090350),
      (f_rel_under25miles_cnt_d > 7.5) => -0.0448248624,
      (f_rel_under25miles_cnt_d = NULL) => -0.0044055149, 0.0001742072),
   (c_bel_edu > 196.5) => -0.0748381584,
   (c_bel_edu = NULL) => -0.0087241010, -0.0006915689),
(f_srchphonesrchcount_i > 24.5) => -0.0888973977,
(f_srchphonesrchcount_i = NULL) => 0.0349180999, -0.0007976961);

// Tree: 277 
woFDN_FL_PSD_lgt_277 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 3.5) => -0.0008864226,
   (f_rel_ageover50_count_d > 3.5) => -0.0614470750,
   (f_rel_ageover50_count_d = NULL) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 126.5) => -0.0504716637,
      (c_relig_indx > 126.5) => 0.0353377531,
      (c_relig_indx = NULL) => -0.0161478970, -0.0161478970), -0.0031658268),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 379602) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 11.5) => -0.0452417452,
      (f_rel_educationover12_count_d > 11.5) => 0.1164653945,
      (f_rel_educationover12_count_d = NULL) => -0.0035646473, -0.0035646473),
   (f_prevaddrmedianvalue_d > 379602) => 0.1421064238,
   (f_prevaddrmedianvalue_d = NULL) => 0.0268566205, 0.0268566205),
(r_P85_Phn_Disconnected_i = NULL) => -0.0025623011, -0.0025623011);

// Tree: 278 
woFDN_FL_PSD_lgt_278 := map(
(NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1288195275) => -0.0047748170,
(f_add_curr_nhood_BUS_pct_i > 0.1288195275) => 
   map(
   (NULL < f_vardobcount_i and f_vardobcount_i <= 2.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0031592673,
      (f_rel_felony_count_i > 0.5) => 
         map(
         (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 0.1298329635,
         (r_Prop_Owner_History_d > 1.5) => 
            map(
            (NULL < c_assault and c_assault <= 93) => 0.1232389053,
            (c_assault > 93) => -0.0716030402,
            (c_assault = NULL) => 0.0054274964, 0.0054274964),
         (r_Prop_Owner_History_d = NULL) => 0.0558776397, 0.0558776397),
      (f_rel_felony_count_i = NULL) => 0.0109787388, 0.0109787388),
   (f_vardobcount_i > 2.5) => 0.1639752965,
   (f_vardobcount_i = NULL) => 0.0204919863, 0.0204919863),
(f_add_curr_nhood_BUS_pct_i = NULL) => 0.0027874664, -0.0011881959);

// Tree: 279 
woFDN_FL_PSD_lgt_279 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 2.65) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 17.5) => -0.0359328680,
      (f_mos_inq_banko_om_lseen_d > 17.5) => 0.0112898925,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0077855687, 0.0077855687),
   (c_hh6_p > 2.65) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.05) => -0.0188111282,
      (c_pop_6_11_p > 15.05) => 0.0983862266,
      (c_pop_6_11_p = NULL) => -0.0165779469, -0.0165779469),
   (c_hh6_p = NULL) => 0.0058315769, 0.0000801551),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0789582240,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 16.05) => -0.0752713434,
   (c_hh3_p > 16.05) => 0.0171951980,
   (c_hh3_p = NULL) => -0.0308162755, -0.0308162755), -0.0005106964);

// Tree: 280 
woFDN_FL_PSD_lgt_280 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 6.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 2.95) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 0.1051240560,
      (r_C12_Num_NonDerogs_d > 2.5) => -0.0329683929,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0082800010, 0.0082800010),
   (c_low_hval > 2.95) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.05) => -0.1129833618,
      (r_C12_source_profile_d > 75.05) => 0.0303350728,
      (r_C12_source_profile_d = NULL) => -0.0793346858, -0.0793346858),
   (c_low_hval = NULL) => -0.0354323157, -0.0354323157),
(f_mos_inq_banko_cm_lseen_d > 6.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 9.5) => -0.0016739411,
   (k_inq_per_phone_i > 9.5) => 0.0671076538,
   (k_inq_per_phone_i = NULL) => -0.0011452455, -0.0011452455),
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0305832935, -0.0022087585);

// Tree: 281 
woFDN_FL_PSD_lgt_281 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 16.85) => -0.0010991936,
(C_INC_25K_P > 16.85) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 131.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 145.5) => -0.0045953652,
      (c_rich_fam > 145.5) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 27.45) => 0.1780412939,
         (c_hh2_p > 27.45) => -0.0054359024,
         (c_hh2_p = NULL) => 0.0798751506, 0.0798751506),
      (c_rich_fam = NULL) => 0.0093498198, 0.0093498198),
   (c_many_cars > 131.5) => 
      map(
      (NULL < c_pop_85p_p and c_pop_85p_p <= 1.15) => 0.2712100301,
      (c_pop_85p_p > 1.15) => 0.0699216437,
      (c_pop_85p_p = NULL) => 0.1573665984, 0.1573665984),
   (c_many_cars = NULL) => 0.0261793138, 0.0261793138),
(C_INC_25K_P = NULL) => -0.0162605594, 0.0008389204);

// Tree: 282 
woFDN_FL_PSD_lgt_282 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0049191645,
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 2.5) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 83.15) => -0.0791464748,
      (c_occunit_p > 83.15) => 
         map(
         (NULL < c_retired and c_retired <= 5.95) => -0.0432091801,
         (c_retired > 5.95) => 
            map(
            (NULL < c_oldhouse and c_oldhouse <= 14.85) => 0.2196767014,
            (c_oldhouse > 14.85) => 0.0357047270,
            (c_oldhouse = NULL) => 0.0483686302, 0.0483686302),
         (c_retired = NULL) => 0.0303291821, 0.0303291821),
      (c_occunit_p = NULL) => 0.0202406407, 0.0202406407),
   (f_idrisktype_i > 2.5) => 0.1549189756,
   (f_idrisktype_i = NULL) => 0.0278378801, 0.0278378801),
(f_hh_payday_loan_users_i = NULL) => 0.0158688616, -0.0017536077);

// Tree: 283 
woFDN_FL_PSD_lgt_283 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 208.5) => -0.0882704935,
   (f_mos_liens_unrel_FT_fseen_d > 208.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.35) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 194.5) => 
            map(
            (NULL < c_many_cars and c_many_cars <= 93.5) => -0.0336741668,
            (c_many_cars > 93.5) => -0.0013081007,
            (c_many_cars = NULL) => -0.0166208509, -0.0166208509),
         (c_blue_empl > 194.5) => 0.1264349864,
         (c_blue_empl = NULL) => -0.0146245801, -0.0146245801),
      (c_pop_35_44_p > 13.35) => 0.0098930634,
      (c_pop_35_44_p = NULL) => 0.0061139503, 0.0005852256),
   (f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0003161064, -0.0003161064),
(r_D34_unrel_liens_ct_i > 7.5) => 0.0928768895,
(r_D34_unrel_liens_ct_i = NULL) => -0.0077461177, 0.0001663160);

// Tree: 284 
woFDN_FL_PSD_lgt_284 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 10.5) => 
   map(
   (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 2) => 0.0472601678,
   (r_I60_inq_banking_recency_d > 2) => -0.0046593627,
   (r_I60_inq_banking_recency_d = NULL) => -0.0035377887, -0.0035377887),
(f_historical_count_d > 10.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 83.5) => -0.0376385778,
   (c_blue_empl > 83.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 121.5) => 0.0536826392,
      (c_rest_indx > 121.5) => 0.2138080389,
      (c_rest_indx = NULL) => 0.1058974434, 0.1058974434),
   (c_blue_empl = NULL) => 0.0550953685, 0.0550953685),
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 106) => -0.0431084326,
   (c_no_teens > 106) => 0.0526049212,
   (c_no_teens = NULL) => 0.0047482443, 0.0047482443), -0.0018058467);

// Tree: 285 
woFDN_FL_PSD_lgt_285 := map(
(NULL < c_mining and c_mining <= 2.35) => 
   map(
   (NULL < c_rich_blk and c_rich_blk <= 198.5) => -0.0003502068,
   (c_rich_blk > 198.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 90.5) => -0.0126929895,
      (f_curraddrmurderindex_i > 90.5) => 0.2017094424,
      (f_curraddrmurderindex_i = NULL) => 0.0821753432, 0.0821753432),
   (c_rich_blk = NULL) => 0.0004253197, 0.0004253197),
(c_mining > 2.35) => -0.1004602701,
(c_mining = NULL) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 2.5) => -0.0300488284,
   (f_corrssnnamecount_d > 2.5) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 1.5) => 0.1785023964,
      (f_rel_homeover150_count_d > 1.5) => -0.0439341949,
      (f_rel_homeover150_count_d = NULL) => 0.0773948549, 0.0773948549),
   (f_corrssnnamecount_d = NULL) => 0.0199934350, 0.0199934350), -0.0011889670);

// Tree: 286 
woFDN_FL_PSD_lgt_286 := map(
(NULL < f_liens_unrel_FT_total_amt_i and f_liens_unrel_FT_total_amt_i <= 31704) => 
   map(
   (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 19.15) => -0.0064451654,
      (c_pop_45_54_p > 19.15) => 0.0225724712,
      (c_pop_45_54_p = NULL) => 0.0197111838, -0.0007392485),
   (f_addrs_per_ssn_c6_i > 1.5) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 0.65) => 
         map(
         (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 9.5) => -0.0756591765,
         (f_rel_incomeover25_count_d > 9.5) => 0.1142819562,
         (f_rel_incomeover25_count_d = NULL) => 0.0064340249, 0.0064340249),
      (c_hval_40k_p > 0.65) => 0.1744373982,
      (c_hval_40k_p = NULL) => 0.0552722148, 0.0552722148),
   (f_addrs_per_ssn_c6_i = NULL) => 0.0000526701, 0.0000526701),
(f_liens_unrel_FT_total_amt_i > 31704) => -0.1009911470,
(f_liens_unrel_FT_total_amt_i = NULL) => 0.0060210321, -0.0004175738);

// Tree: 287 
woFDN_FL_PSD_lgt_287 := map(
(NULL < c_hh1_p and c_hh1_p <= 47.15) => 
   map(
   (NULL < c_larceny and c_larceny <= 158.5) => -0.0045830972,
   (c_larceny > 158.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 31.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 10.05) => 0.1363281276,
         (c_hh3_p > 10.05) => 0.0291170235,
         (c_hh3_p = NULL) => 0.0575753967, 0.0575753967),
      (r_C13_Curr_Addr_LRes_d > 31.5) => -0.0034897721,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0213257205, 0.0213257205),
   (c_larceny = NULL) => -0.0011755468, -0.0011755468),
(c_hh1_p > 47.15) => -0.0390970224,
(c_hh1_p = NULL) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2063427743) => 0.1117488865,
   (f_add_curr_mobility_index_i > 0.2063427743) => -0.1086687742,
   (f_add_curr_mobility_index_i = NULL) => 0.0228984887, 0.0147584504), -0.0039343644);

// Tree: 288 
woFDN_FL_PSD_lgt_288 := map(
(NULL < c_fammar_p and c_fammar_p <= 19.6) => -0.0620382153,
(c_fammar_p > 19.6) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.3) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 3.635) => 0.0022790021,
      (c_hhsize > 3.635) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 176.5) => -0.1220809362,
         (c_span_lang > 176.5) => 
            map(
            (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00470629925) => 0.0827334386,
            (f_add_curr_nhood_VAC_pct_i > 0.00470629925) => -0.0317379111,
            (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0050589515, -0.0050589515),
         (c_span_lang = NULL) => -0.0399212885, -0.0399212885),
      (c_hhsize = NULL) => 0.0004551909, 0.0004551909),
   (c_pop_0_5_p > 19.3) => 0.0790548130,
   (c_pop_0_5_p = NULL) => 0.0009611284, 0.0009611284),
(c_fammar_p = NULL) => -0.0031800161, 0.0003301486);

// Tree: 289 
woFDN_FL_PSD_lgt_289 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 65.5) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 53.3) => -0.0213101535,
      (c_low_hval > 53.3) => 0.1049117512,
      (c_low_hval = NULL) => 0.0068758902, -0.0181014684),
   (r_C13_max_lres_d > 65.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 0.0029628107,
      (f_util_adl_count_n > 4.5) => 
         map(
         (NULL < f_accident_count_i and f_accident_count_i <= 1.5) => 0.0518389348,
         (f_accident_count_i > 1.5) => -0.0948751780,
         (f_accident_count_i = NULL) => 0.0424932714, 0.0424932714),
      (f_util_adl_count_n = NULL) => 0.0074691181, 0.0074691181),
   (r_C13_max_lres_d = NULL) => 0.0024371307, 0.0024371307),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0860792137,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0161347540, 0.0021442079);

// Tree: 290 
woFDN_FL_PSD_lgt_290 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 11.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.69) => -0.0077664721,
   (c_hhsize > 2.69) => 0.1284313669,
   (c_hhsize = NULL) => 0.0533222645, 0.0533222645),
(r_C13_max_lres_d > 11.5) => 
   map(
   (NULL < c_employees and c_employees <= 6892) => 
      map(
      (NULL < c_highinc and c_highinc <= 0.45) => -0.0449388116,
      (c_highinc > 0.45) => 0.0076414010,
      (c_highinc = NULL) => 0.0062923806, 0.0062923806),
   (c_employees > 6892) => -0.0511480672,
   (c_employees = NULL) => -0.0144115760, 0.0035811547),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 90.5) => -0.0501273465,
   (c_old_homes > 90.5) => 0.0635611616,
   (c_old_homes = NULL) => 0.0056023143, 0.0056023143), 0.0041976774);

// Tree: 291 
woFDN_FL_PSD_lgt_291 := map(
(NULL < c_hh3_p and c_hh3_p <= 31.15) => -0.0001820266,
(c_hh3_p > 31.15) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 160) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 43.05) => 0.1021544242,
         (C_OWNOCC_P > 43.05) => -0.0570305916,
         (C_OWNOCC_P = NULL) => 0.0082467171, 0.0082467171),
      (r_C14_Addr_Stability_v2_d > 4.5) => -0.0250325963,
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0092984992, -0.0092984992),
   (r_C13_Curr_Addr_LRes_d > 160) => 0.1991086857,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0364628668, 0.0364628668),
(c_hh3_p = NULL) => 
   map(
   (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => 0.1175601462,
   (f_validationrisktype_i > 1.5) => -0.0192812098,
   (f_validationrisktype_i = NULL) => 0.0269552893, 0.0269552893), 0.0015518599);

// Tree: 292 
woFDN_FL_PSD_lgt_292 := map(
(NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => -0.0023591114,
(f_inq_Collection_count24_i > 2.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 85.05) => 
      map(
      (NULL < c_trailer_p and c_trailer_p <= 1.85) => 
         map(
         (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 2.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.06791341415) => 0.0735820053,
            (f_add_curr_nhood_BUS_pct_i > 0.06791341415) => 0.2069897873,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1258256123, 0.1258256123),
         (r_A50_pb_total_orders_d > 2.5) => 0.0012364313,
         (r_A50_pb_total_orders_d = NULL) => 0.0829980813, 0.0829980813),
      (c_trailer_p > 1.85) => -0.0349341677,
      (c_trailer_p = NULL) => 0.0465992390, 0.0465992390),
   (c_fammar_p > 85.05) => -0.0724417247,
   (c_fammar_p = NULL) => 0.0166328070, 0.0166328070),
(f_inq_Collection_count24_i = NULL) => 0.0327516306, -0.0013890707);

// Tree: 293 
woFDN_FL_PSD_lgt_293 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 194.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 370.3) => -0.0036865988,
      (c_newhouse > 370.3) => 0.1027324966,
      (c_newhouse = NULL) => -0.0030909695, -0.0030909695),
   (c_relig_indx > 194.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 152.5) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => -0.0375122129,
         (f_rel_incomeover50_count_d > 8.5) => 0.1146802169,
         (f_rel_incomeover50_count_d = NULL) => -0.0025828028, -0.0025828028),
      (c_easiqlife > 152.5) => 0.1989403835,
      (c_easiqlife = NULL) => 0.0447184830, 0.0447184830),
   (c_relig_indx = NULL) => -0.0071992335, -0.0016351518),
(r_D34_unrel_liens_ct_i > 7.5) => 0.0873070477,
(r_D34_unrel_liens_ct_i = NULL) => 0.0035441496, -0.0010671560);

// Tree: 294 
woFDN_FL_PSD_lgt_294 := map(
(NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 108.5) => -0.0540737744,
(f_mos_liens_rel_CJ_lseen_d > 108.5) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 72.55) => -0.0015956355,
   (c_civ_emp > 72.55) => 
      map(
      (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 2.5) => 
         map(
         (NULL < c_hval_40k_p and c_hval_40k_p <= 5.1) => 
            map(
            (NULL < f_current_count_d and f_current_count_d <= 1.5) => -0.0101501627,
            (f_current_count_d > 1.5) => 0.1129735014,
            (f_current_count_d = NULL) => 0.0206016323, 0.0206016323),
         (c_hval_40k_p > 5.1) => 0.2234441885,
         (c_hval_40k_p = NULL) => 0.0309804704, 0.0309804704),
      (f_hh_members_w_derog_i > 2.5) => 0.1361610684,
      (f_hh_members_w_derog_i = NULL) => 0.0371152644, 0.0371152644),
   (c_civ_emp = NULL) => 0.0094293348, 0.0023686879),
(f_mos_liens_rel_CJ_lseen_d = NULL) => -0.0014635820, 0.0014862792);

// Tree: 295 
woFDN_FL_PSD_lgt_295 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 8118) => -0.0103207855,
   (r_A49_Curr_AVM_Chg_1yr_i > 8118) => 0.0216775821,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0009046260, 0.0018221598),
(r_D32_criminal_count_i > 5.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
      map(
      (NULL < c_trailer and c_trailer <= 122.5) => 0.1338831623,
      (c_trailer > 122.5) => 0.0026032286,
      (c_trailer = NULL) => 0.0873299943, 0.0873299943),
   (r_E57_br_source_count_d > 0.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1977.5) => -0.0946828112,
      (c_med_yearblt > 1977.5) => 0.0445027228,
      (c_med_yearblt = NULL) => -0.0191249499, -0.0191249499),
   (r_E57_br_source_count_d = NULL) => 0.0342906052, 0.0342906052),
(r_D32_criminal_count_i = NULL) => -0.0203127680, 0.0023702830);

// Tree: 296 
woFDN_FL_PSD_lgt_296 := map(
(NULL < c_span_lang and c_span_lang <= 184.5) => 0.0023381414,
(c_span_lang > 184.5) => 
   map(
   (NULL < c_retired2 and c_retired2 <= 48.5) => 0.0220989695,
   (c_retired2 > 48.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 141.5) => 
         map(
         (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 127) => -0.1023668819,
         (f_curraddrburglaryindex_i > 127) => -0.0141867862,
         (f_curraddrburglaryindex_i = NULL) => -0.0796275265, -0.0796275265),
      (c_rich_fam > 141.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 138.5) => -0.0364451835,
         (r_C13_max_lres_d > 138.5) => 0.1297937554,
         (r_C13_max_lres_d = NULL) => 0.0237863161, 0.0237863161),
      (c_rich_fam = NULL) => -0.0573537758, -0.0573537758),
   (c_retired2 = NULL) => -0.0349035520, -0.0349035520),
(c_span_lang = NULL) => -0.0158620965, -0.0007651182);

// Tree: 297 
woFDN_FL_PSD_lgt_297 := map(
(NULL < c_families and c_families <= 116.5) => -0.0849546990,
(c_families > 116.5) => 
   map(
   (NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 1.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 18.85) => 0.0029632347,
      (c_pop_55_64_p > 18.85) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 20.2) => 
            map(
            (NULL < c_employees and c_employees <= 18.5) => 0.1829594203,
            (c_employees > 18.5) => 0.0237101104,
            (c_employees = NULL) => 0.0362998616, 0.0362998616),
         (c_famotf18_p > 20.2) => 0.1575396853,
         (c_famotf18_p = NULL) => 0.0458999498, 0.0458999498),
      (c_pop_55_64_p = NULL) => 0.0058435849, 0.0058435849),
   (r_I60_inq_auto_count12_i > 1.5) => -0.0552965321,
   (r_I60_inq_auto_count12_i = NULL) => -0.0130695136, 0.0037760607),
(c_families = NULL) => -0.0138572998, 0.0017404217);

// Tree: 298 
woFDN_FL_PSD_lgt_298 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 25.05) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 0.35) => 0.0810921569,
      (c_hh5_p > 0.35) => 0.0006505751,
      (c_hh5_p = NULL) => 0.0101443873, 0.0101443873),
   (c_hval_250k_p > 25.05) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 15.55) => -0.0660582688,
      (c_high_ed > 15.55) => 
         map(
         (NULL < c_for_sale and c_for_sale <= 141.5) => 0.0968495735,
         (c_for_sale > 141.5) => 0.3147619461,
         (c_for_sale = NULL) => 0.1781601603, 0.1781601603),
      (c_high_ed = NULL) => 0.1052782207, 0.1052782207),
   (c_hval_250k_p = NULL) => 0.1335752319, 0.0262053009),
(f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0052749729,
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0046974146, -0.0010321999);

// Tree: 299 
woFDN_FL_PSD_lgt_299 := map(
(NULL < f_inq_count_i and f_inq_count_i <= 23.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 15.45) => -0.0064083307,
   (c_pop_18_24_p > 15.45) => 
      map(
      (NULL < c_preschl and c_preschl <= 149.5) => 0.0001920729,
      (c_preschl > 149.5) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 37) => 0.1982007603,
         (f_prevaddrmurderindex_i > 37) => 
            map(
            (NULL < c_pop_0_5_p and c_pop_0_5_p <= 14.85) => 0.0016437464,
            (c_pop_0_5_p > 14.85) => 0.1386596343,
            (c_pop_0_5_p = NULL) => 0.0363464604, 0.0363464604),
         (f_prevaddrmurderindex_i = NULL) => 0.0758752333, 0.0758752333),
      (c_preschl = NULL) => 0.0222420706, 0.0222420706),
   (c_pop_18_24_p = NULL) => -0.0213092454, -0.0043738904),
(f_inq_count_i > 23.5) => -0.0929534275,
(f_inq_count_i = NULL) => 0.0057660622, -0.0050255716);

// Tree: 300 
woFDN_FL_PSD_lgt_300 := map(
(NULL < f_inq_Retail_count_i and f_inq_Retail_count_i <= 1.5) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 18.75) => 0.0073061448,
   (c_hh5_p > 18.75) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 160.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 225) => -0.0359483229,
         (r_C13_max_lres_d > 225) => 0.1508282470,
         (r_C13_max_lres_d = NULL) => 0.0036940511, 0.0036940511),
      (c_lar_fam > 160.5) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 5.3) => 0.2278644748,
         (c_newhouse > 5.3) => 0.0413086133,
         (c_newhouse = NULL) => 0.1162136183, 0.1162136183),
      (c_lar_fam = NULL) => 0.0430908227, 0.0430908227),
   (c_hh5_p = NULL) => 0.0123172527, 0.0086158421),
(f_inq_Retail_count_i > 1.5) => -0.0279002138,
(f_inq_Retail_count_i = NULL) => 0.0053902503, 0.0051516625);

// Tree: 301 
woFDN_FL_PSD_lgt_301 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 9.5) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 20026.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 168) => 0.1042036810,
      (f_prevaddrcartheftindex_i > 168) => -0.0655840405,
      (f_prevaddrcartheftindex_i = NULL) => 0.0504199928, 0.0504199928),
   (c_med_hhinc > 20026.5) => -0.0045516571,
   (c_med_hhinc = NULL) => -0.0013728770, -0.0037526672),
(f_srchphonesrchcount_i > 9.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 94.85) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 5.15) => -0.0621687303,
      (c_pop_65_74_p > 5.15) => 0.0691157317,
      (c_pop_65_74_p = NULL) => 0.0082301841, 0.0082301841),
   (c_occunit_p > 94.85) => 0.1602651403,
   (c_occunit_p = NULL) => 0.0579196576, 0.0579196576),
(f_srchphonesrchcount_i = NULL) => -0.0035548857, -0.0027495553);

// Tree: 302 
woFDN_FL_PSD_lgt_302 := map(
(NULL < c_retail and c_retail <= 48.55) => 
   map(
   (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0047809507,
   (r_F04_curr_add_occ_index_d > 2) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 13.75) => -0.0048262920,
      (C_INC_50K_P > 13.75) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 1012.5) => 0.0261145603,
         (c_hh00 > 1012.5) => 
            map(
            (NULL < c_assault and c_assault <= 45) => 0.2915677645,
            (c_assault > 45) => 0.0814238689,
            (c_assault = NULL) => 0.1467734950, 0.1467734950),
         (c_hh00 = NULL) => 0.0444708361, 0.0444708361),
      (C_INC_50K_P = NULL) => 0.0154647748, 0.0154647748),
   (r_F04_curr_add_occ_index_d = NULL) => -0.0209093205, -0.0005726481),
(c_retail > 48.55) => -0.0865902163,
(c_retail = NULL) => -0.0195725829, -0.0022003187);

// Tree: 303 
woFDN_FL_PSD_lgt_303 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201) => -0.0547852887,
(r_D32_Mos_Since_Fel_LS_d > 201) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 92.85) => 
      map(
      (NULL < c_bargains and c_bargains <= 76.5) => -0.0194684608,
      (c_bargains > 76.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 26.65) => -0.0249586862,
         (C_OWNOCC_P > 26.65) => 0.0118625349,
         (C_OWNOCC_P = NULL) => 0.0061058095, 0.0061058095),
      (c_bargains = NULL) => -0.0035474442, -0.0035474442),
   (C_OWNOCC_P > 92.85) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0154096542,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.1508258202,
      (nf_seg_FraudPoint_3_0 = '') => 0.0321883781, 0.0321883781),
   (C_OWNOCC_P = NULL) => 0.0005028235, -0.0011612944),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0373916651, -0.0018357131);

// Tree: 304 
woFDN_FL_PSD_lgt_304 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 0.5) => -0.0870332589,
(f_vardobcount_i > 0.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0002732079,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_health and c_health <= 23.35) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 61.2) => -0.0443303536,
         (c_sfdu_p > 61.2) => 0.0424524785,
         (c_sfdu_p = NULL) => 0.0148298728, 0.0148298728),
      (c_health > 23.35) => 
         map(
         (NULL < c_preschl and c_preschl <= 112) => -0.0114680014,
         (c_preschl > 112) => 0.2012287939,
         (c_preschl = NULL) => 0.0896501472, 0.0896501472),
      (c_health = NULL) => 0.0247516918, 0.0247516918),
   (k_nap_contradictory_i = NULL) => 0.0016227699, 0.0016227699),
(f_vardobcount_i = NULL) => -0.0206657230, 0.0006538255);

// Tree: 305 
woFDN_FL_PSD_lgt_305 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 26.5) => 
   map(
   (NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 2.95) => -0.0232230615,
      (c_incollege > 2.95) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 7.5) => 0.0808395888,
         (c_serv_empl > 7.5) => 0.0052780222,
         (c_serv_empl = NULL) => 0.0080894401, 0.0080894401),
      (c_incollege = NULL) => -0.0140665013, 0.0023548703),
   (f_assoccredbureaucountmo_i > 0.5) => 0.0967734519,
   (f_assoccredbureaucountmo_i = NULL) => 0.0046449635, 0.0029007285),
(f_addrs_per_ssn_i > 26.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['3: Derog']) => -0.1274545983,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0219714116,
   (nf_seg_FraudPoint_3_0 = '') => -0.0639998689, -0.0639998689),
(f_addrs_per_ssn_i = NULL) => 0.0022256574, 0.0022256574);

// Tree: 306 
woFDN_FL_PSD_lgt_306 := map(
(NULL < c_work_home and c_work_home <= 67.5) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 29.1) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 369.5) => 0.0029188717,
         (r_pb_order_freq_d > 369.5) => 0.1915879337,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < c_hval_300k_p and c_hval_300k_p <= 15.4) => 0.0208827572,
            (c_hval_300k_p > 15.4) => 0.1510083175,
            (c_hval_300k_p = NULL) => 0.0370565557, 0.0370565557), 0.0276632998),
      (c_hval_80k_p > 29.1) => 0.1339221190,
      (c_hval_80k_p = NULL) => 0.0337141492, 0.0337141492),
   (r_A44_curr_add_naprop_d > 2.5) => -0.0055732052,
   (r_A44_curr_add_naprop_d = NULL) => 0.0124726609, 0.0124726609),
(c_work_home > 67.5) => -0.0040368762,
(c_work_home = NULL) => -0.0032044922, 0.0000919100);

// Tree: 307 
woFDN_FL_PSD_lgt_307 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 111.5) => -0.0121081080,
(f_prevaddrageoldest_d > 111.5) => 
   map(
   (NULL < c_rental and c_rental <= 130.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1658.5) => 
         map(
         (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 3.5) => 0.0185045123,
         (f_inq_QuizProvider_count_i > 3.5) => 0.1495069849,
         (f_inq_QuizProvider_count_i = NULL) => 0.0212726970, 0.0212726970),
      (f_liens_unrel_SC_total_amt_i > 1658.5) => 0.1468374392,
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0235262426, 0.0235262426),
   (c_rental > 130.5) => -0.0169168399,
   (c_rental = NULL) => 0.0458901876, 0.0116249552),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_work_home and c_work_home <= 99) => 0.0289718548,
   (c_work_home > 99) => -0.0542577604,
   (c_work_home = NULL) => -0.0157255311, -0.0157255311), -0.0022330559);

// Tree: 308 
woFDN_FL_PSD_lgt_308 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 6.5) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 3092) => -0.0128537478,
   (f_liens_unrel_CJ_total_amt_i > 3092) => 0.1077666135,
   (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0109282489, -0.0114052124),
(f_addrs_per_ssn_i > 6.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 
         map(
         (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 9.5) => 0.0120831925,
         (f_hh_members_ct_d > 9.5) => -0.0478182427,
         (f_hh_members_ct_d = NULL) => 0.0102920930, 0.0102920930),
      (f_inq_QuizProvider_count_i > 5.5) => 0.0947792778,
      (f_inq_QuizProvider_count_i = NULL) => 0.0114540432, 0.0114540432),
   (f_nae_nothing_found_i > 0.5) => 0.1117987725,
   (f_nae_nothing_found_i = NULL) => 0.0124346106, 0.0124346106),
(f_addrs_per_ssn_i = NULL) => 0.0030189612, 0.0030189612);

// Tree: 309 
woFDN_FL_PSD_lgt_309 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 27.55) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 8.25) => -0.0278740074,
   (c_pop_45_54_p > 8.25) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 21.35) => -0.0008984448,
      (c_pop_18_24_p > 21.35) => 
         map(
         (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => -0.0466946659,
         (f_phone_ver_insurance_d > 2.5) => 0.2149272864,
         (f_phone_ver_insurance_d = NULL) => 0.1179357333, 0.1179357333),
      (c_pop_18_24_p = NULL) => 0.0013146614, 0.0013146614),
   (c_pop_45_54_p = NULL) => -0.0013355981, -0.0013355981),
(c_pop_45_54_p > 27.55) => -0.1081192986,
(c_pop_45_54_p = NULL) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3.5) => -0.0565310610,
   (r_A44_curr_add_naprop_d > 3.5) => 0.0653434514,
   (r_A44_curr_add_naprop_d = NULL) => -0.0339028942, -0.0339028942), -0.0033942041);

// Tree: 310 
woFDN_FL_PSD_lgt_310 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 3.5) => -0.0002981376,
(f_srchphonesrchcount_i > 3.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 5.25) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => 0.0333780935,
      (k_inq_per_ssn_i > 1.5) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 5.35) => 0.2041157644,
         (c_pop_65_74_p > 5.35) => 0.0250281558,
         (c_pop_65_74_p = NULL) => 0.1268382347, 0.1268382347),
      (k_inq_per_ssn_i = NULL) => 0.0744780351, 0.0744780351),
   (c_vacant_p > 5.25) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 0.0359805249,
      (f_inq_count_i > 7.5) => -0.0566316004,
      (f_inq_count_i = NULL) => 0.0052134095, 0.0052134095),
   (c_vacant_p = NULL) => 0.0299934264, 0.0299934264),
(f_srchphonesrchcount_i = NULL) => 0.0512375734, 0.0023284629);

// Tree: 311 
woFDN_FL_PSD_lgt_311 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 187) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 1206.5) => -0.0018680728,
   (c_hh00 > 1206.5) => 0.0347495786,
   (c_hh00 = NULL) => -0.0223804425, 0.0010268478),
(f_fp_prevaddrcrimeindex_i > 187) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 122.5) => -0.0176820704,
      (c_retired2 > 122.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 116.15) => -0.0060008327,
         (c_oldhouse > 116.15) => 0.1657836345,
         (c_oldhouse = NULL) => 0.0852226430, 0.0852226430),
      (c_retired2 = NULL) => 0.0185343943, 0.0185343943),
   (f_varrisktype_i > 2.5) => 0.1251311173,
   (f_varrisktype_i = NULL) => 0.0313260011, 0.0313260011),
(f_fp_prevaddrcrimeindex_i = NULL) => -0.0352715727, 0.0018981638);

// Tree: 312 
woFDN_FL_PSD_lgt_312 := map(
(NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1212842966) => -0.0031599640,
(f_add_curr_nhood_VAC_pct_i > 0.1212842966) => 
   map(
   (NULL < c_food and c_food <= 25.35) => 0.0015149074,
   (c_food > 25.35) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 0.85) => -0.0430948167,
      (c_hh5_p > 0.85) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1538929989) => 0.2211697446,
         (f_add_curr_nhood_VAC_pct_i > 0.1538929989) => 0.0818589851,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1088534575, 0.1088534575),
      (c_hh5_p = NULL) => 0.0788858812, 0.0788858812),
   (c_food = NULL) => 0.0233095479, 0.0233095479),
(f_add_curr_nhood_VAC_pct_i = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 9.85) => -0.0468520237,
   (C_INC_125K_P > 9.85) => 0.0706873191,
   (C_INC_125K_P = NULL) => 0.0091190919, 0.0091190919), -0.0003801481);

// Tree: 313 
woFDN_FL_PSD_lgt_313 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 928792.5) => 
   map(
   (NULL < c_professional and c_professional <= 2.65) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 33500) => 
         map(
         (NULL < c_retired and c_retired <= 5.55) => 
            map(
            (NULL < c_no_teens and c_no_teens <= 66.5) => 0.1204646974,
            (c_no_teens > 66.5) => 0.0176502444,
            (c_no_teens = NULL) => 0.0633056134, 0.0633056134),
         (c_retired > 5.55) => 0.0222276150,
         (c_retired = NULL) => 0.0287945840, 0.0287945840),
      (k_estimated_income_d > 33500) => -0.0099672836,
      (k_estimated_income_d = NULL) => 0.0051011608, 0.0051011608),
   (c_professional > 2.65) => -0.0105065163,
   (c_professional = NULL) => -0.0244697444, -0.0051096085),
(f_curraddrmedianvalue_d > 928792.5) => 0.1507458994,
(f_curraddrmedianvalue_d = NULL) => 0.0129345900, -0.0043644101);

// Tree: 314 
woFDN_FL_PSD_lgt_314 := map(
(NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 4.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 90.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 4.5) => 0.0847448906,
         (c_no_teens > 4.5) => -0.0194046306,
         (c_no_teens = NULL) => -0.0175432836, -0.0175432836),
      (f_varrisktype_i > 3.5) => -0.0669258715,
      (f_varrisktype_i = NULL) => -0.0199089940, -0.0199089940),
   (c_easiqlife > 90.5) => 0.0045706694,
   (c_easiqlife = NULL) => 0.0016453087, -0.0029957540),
(f_inq_Other_count24_i > 4.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 91.5) => -0.0325243765,
   (c_no_teens > 91.5) => 0.1661096853,
   (c_no_teens = NULL) => 0.0714336371, 0.0714336371),
(f_inq_Other_count24_i = NULL) => 0.0206336044, -0.0021779267);

// Tree: 315 
woFDN_FL_PSD_lgt_315 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 50.85) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0430948240,
   (f_mos_inq_banko_om_fseen_d > 5.5) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => -0.0030834781,
      (f_inq_Collection_count24_i > 2.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 65.5) => -0.0289567444,
         (r_pb_order_freq_d > 65.5) => 0.0557949296,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < c_hh6_p and c_hh6_p <= 1.15) => 0.1801111777,
            (c_hh6_p > 1.15) => 0.0017444684,
            (c_hh6_p = NULL) => 0.0888211296, 0.0888211296), 0.0348522486),
      (f_inq_Collection_count24_i = NULL) => -0.0019748719, -0.0019748719),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0130788373, -0.0037629301),
(c_hval_500k_p > 50.85) => 0.0778311939,
(c_hval_500k_p = NULL) => 0.0174477945, -0.0026864996);

// Tree: 316 
woFDN_FL_PSD_lgt_316 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 0.0025086350,
(r_I60_Inq_Count12_i > 1.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 6.15) => 
      map(
      (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 2.5) => -0.0163105175,
      (r_C20_email_domain_free_count_i > 2.5) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 5.25) => -0.0558159893,
         (c_hh5_p > 5.25) => 
            map(
            (NULL < c_rnt1250_p and c_rnt1250_p <= 1.15) => 0.2521798053,
            (c_rnt1250_p > 1.15) => 0.0317516879,
            (c_rnt1250_p = NULL) => 0.1408957072, 0.1408957072),
         (c_hh5_p = NULL) => 0.0555098609, 0.0555098609),
      (r_C20_email_domain_free_count_i = NULL) => -0.0069538183, -0.0069538183),
   (c_hval_750k_p > 6.15) => -0.0503263637,
   (c_hval_750k_p = NULL) => -0.0240621912, -0.0240621912),
(r_I60_Inq_Count12_i = NULL) => -0.0032778060, -0.0024191895);

// Tree: 317 
woFDN_FL_PSD_lgt_317 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
   map(
   (NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 656.5) => 
      map(
      (NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 230.5) => 
         map(
         (NULL < c_food and c_food <= 5.35) => -0.0216358668,
         (c_food > 5.35) => 0.0026728940,
         (c_food = NULL) => -0.0089593816, -0.0027961296),
      (f_liens_unrel_O_total_amt_i > 230.5) => 0.0852052097,
      (f_liens_unrel_O_total_amt_i = NULL) => -0.0024174294, -0.0024174294),
   (f_liens_unrel_O_total_amt_i > 656.5) => -0.0624211966,
   (f_liens_unrel_O_total_amt_i = NULL) => -0.0034375270, -0.0034375270),
(f_inq_PrepaidCards_count24_i > 1.5) => 0.0704501098,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_highrent and c_highrent <= 0.7) => 0.0584764182,
   (c_highrent > 0.7) => -0.0340966504,
   (c_highrent = NULL) => 0.0126481664, 0.0126481664), -0.0030027561);

// Tree: 318 
woFDN_FL_PSD_lgt_318 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 1.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 9.65) => 
      map(
      (NULL < c_incollege and c_incollege <= 7.05) => 0.0328616779,
      (c_incollege > 7.05) => 
         map(
         (NULL < c_retail and c_retail <= 1.75) => 0.0519672109,
         (c_retail > 1.75) => 0.2786456716,
         (c_retail = NULL) => 0.1733383552, 0.1733383552),
      (c_incollege = NULL) => 0.0835450246, 0.0835450246),
   (c_hh1_p > 9.65) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 9.95) => 0.0240968977,
      (c_hval_300k_p > 9.95) => -0.0360731393,
      (c_hval_300k_p = NULL) => 0.0063260011, 0.0063260011),
   (c_hh1_p = NULL) => -0.0334690151, 0.0126315065),
(f_srchvelocityrisktype_i > 1.5) => -0.0107118874,
(f_srchvelocityrisktype_i = NULL) => -0.0005988871, -0.0037347129);

// Tree: 319 
woFDN_FL_PSD_lgt_319 := map(
(NULL < c_wholesale and c_wholesale <= 1.95) => 0.0036142884,
(c_wholesale > 1.95) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 800.5) => -0.0455220403,
   (c_hh00 > 800.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.0393956450,
      (f_prevaddrstatus_i > 2.5) => 
         map(
         (NULL < c_rich_old and c_rich_old <= 170.5) => -0.0495562524,
         (c_rich_old > 170.5) => 0.1481168461,
         (c_rich_old = NULL) => -0.0184616076, -0.0184616076),
      (f_prevaddrstatus_i = NULL) => 
         map(
         (NULL < C_INC_200K_P and C_INC_200K_P <= 1.55) => 0.1870468850,
         (C_INC_200K_P > 1.55) => 0.0138461262,
         (C_INC_200K_P = NULL) => 0.0277021869, 0.0277021869), -0.0024870922),
   (c_hh00 = NULL) => -0.0237170653, -0.0237170653),
(c_wholesale = NULL) => 0.0206423874, -0.0042031545);

// Tree: 320 
woFDN_FL_PSD_lgt_320 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 90.1) => 
      map(
      (NULL < c_white_col and c_white_col <= 11.85) => 0.1029450125,
      (c_white_col > 11.85) => 0.0013821490,
      (c_white_col = NULL) => 0.0018989558, 0.0018989558),
   (c_bigapt_p > 90.1) => 0.1229639045,
   (c_bigapt_p = NULL) => -0.0171754024, 0.0024440547),
(r_I60_Inq_Count12_i > 1.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 10.5) => 0.0892426863,
   (r_A50_pb_average_dollars_d > 10.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => -0.0180242257,
      (f_srchfraudsrchcount_i > 4.5) => -0.0449556709,
      (f_srchfraudsrchcount_i = NULL) => -0.0241073994, -0.0241073994),
   (r_A50_pb_average_dollars_d = NULL) => -0.0204984314, -0.0204984314),
(r_I60_Inq_Count12_i = NULL) => 0.0222273941, -0.0017249873);

// Tree: 321 
woFDN_FL_PSD_lgt_321 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 176.5) => -0.0051334778,
   (c_sub_bus > 176.5) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 138.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => 0.0170895692,
         (f_srchvelocityrisktype_i > 6.5) => -0.0842954024,
         (f_srchvelocityrisktype_i = NULL) => 0.0128418194, 0.0128418194),
      (c_retired2 > 138.5) => 
         map(
         (NULL < c_med_rent and c_med_rent <= 612.5) => 0.2786255241,
         (c_med_rent > 612.5) => 0.0538943500,
         (c_med_rent = NULL) => 0.0943136259, 0.0943136259),
      (c_retired2 = NULL) => 0.0275204728, 0.0275204728),
   (c_sub_bus = NULL) => -0.0035850095, -0.0010674323),
(f_fp_prevaddrcrimeindex_i > 197.5) => -0.1030564955,
(f_fp_prevaddrcrimeindex_i = NULL) => 0.0156235384, -0.0015227815);

// Tree: 322 
woFDN_FL_PSD_lgt_322 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 19.75) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.005878034) => -0.0283422054,
      (f_add_curr_nhood_BUS_pct_i > 0.005878034) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.01099133425) => 
            map(
            (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.77458101655) => 0.0641167776,
            (f_add_curr_nhood_MFD_pct_i > 0.77458101655) => 0.1376269629,
            (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0127501919, 0.0546263995),
         (f_add_curr_nhood_BUS_pct_i > 0.01099133425) => 0.0028669476,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0078568840, 0.0078568840),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0267690493, 0.0044640351),
   (f_assocsuspicousidcount_i > 16.5) => 0.0795450361,
   (f_assocsuspicousidcount_i = NULL) => -0.0292709404, 0.0046168937),
(C_INC_100K_P > 19.75) => -0.0337060846,
(C_INC_100K_P = NULL) => 0.0174163253, 0.0006165200);

// Tree: 323 
woFDN_FL_PSD_lgt_323 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0000552544,
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
         map(
         (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 11.5) => 0.0440528952,
         (f_rel_homeover100_count_d > 11.5) => -0.0996024577,
         (f_rel_homeover100_count_d = NULL) => 0.0166899708, 0.0166899708),
      (r_Phn_Cell_n > 0.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 125) => 0.0723925899,
         (c_many_cars > 125) => 0.2425312785,
         (c_many_cars = NULL) => 0.1213854060, 0.1213854060),
      (r_Phn_Cell_n = NULL) => 0.0544747895, 0.0544747895),
   (r_I60_Inq_Count12_i > 1.5) => -0.0024258653,
   (r_I60_Inq_Count12_i = NULL) => 0.0222852762, 0.0222852762),
(k_inq_per_phone_i = NULL) => 0.0021145157, 0.0021145157);

// Tree: 324 
woFDN_FL_PSD_lgt_324 := map(
(NULL < c_exp_prod and c_exp_prod <= 78.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 17.95) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 15.5) => -0.1027917192,
      (r_D32_Mos_Since_Crim_LS_d > 15.5) => 0.0018101756,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0006750624, -0.0006750624),
   (C_INC_75K_P > 17.95) => -0.0485970896,
   (C_INC_75K_P = NULL) => -0.0141227919, -0.0141227919),
(c_exp_prod > 78.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.07264627005) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 74.5) => 0.0264813690,
      (k_comb_age_d > 74.5) => 0.1414262329,
      (k_comb_age_d = NULL) => 0.0300797852, 0.0300797852),
   (f_add_curr_nhood_MFD_pct_i > 0.07264627005) => 0.0049773783,
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0157163022, 0.0084283212),
(c_exp_prod = NULL) => 0.0194864856, 0.0028159654);

// Tree: 325 
woFDN_FL_PSD_lgt_325 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 36.65) => 
   map(
   (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 99.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 24.95) => 0.0156069087,
         (C_INC_50K_P > 24.95) => 0.1199410434,
         (C_INC_50K_P = NULL) => 0.0181516437, 0.0181516437),
      (c_relig_indx > 99.5) => -0.0069127736,
      (c_relig_indx = NULL) => 0.0044530199, 0.0044530199),
   (r_D31_ALL_Bk_i > 1.5) => 
      map(
      (NULL < r_C20_email_count_i and r_C20_email_count_i <= 6.5) => -0.0431393550,
      (r_C20_email_count_i > 6.5) => 0.0857085202,
      (r_C20_email_count_i = NULL) => -0.0332188953, -0.0332188953),
   (r_D31_ALL_Bk_i = NULL) => -0.0123259535, 0.0008583378),
(c_famotf18_p > 36.65) => -0.0297725485,
(c_famotf18_p = NULL) => -0.0318592335, -0.0012112094);

// Tree: 326 
woFDN_FL_PSD_lgt_326 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 4.5) => 
   map(
   (NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 3749.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 8.5) => 0.0006193478,
      (f_srchvelocityrisktype_i > 8.5) => -0.0749028059,
      (f_srchvelocityrisktype_i = NULL) => 0.0001547466, 0.0001547466),
   (f_liens_unrel_ST_total_amt_i > 3749.5) => 0.1131039563,
   (f_liens_unrel_ST_total_amt_i = NULL) => 0.0006916034, 0.0006916034),
(f_dl_addrs_per_adl_i > 4.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 106) => 
      map(
      (NULL < c_pop_85p_p and c_pop_85p_p <= 0.95) => 0.0441569546,
      (c_pop_85p_p > 0.95) => 0.1847335575,
      (c_pop_85p_p = NULL) => 0.1132121279, 0.1132121279),
   (c_many_cars > 106) => -0.1004809046,
   (c_many_cars = NULL) => 0.0356140994, 0.0356140994),
(f_dl_addrs_per_adl_i = NULL) => -0.0183978710, 0.0010487037);

// Tree: 327 
woFDN_FL_PSD_lgt_327 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 4.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 62.35) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 25.25) => -0.0463669011,
      (c_hh1_p > 25.25) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 97.5) => 
            map(
            (NULL < C_INC_35K_P and C_INC_35K_P <= 12.25) => 0.0695776485,
            (C_INC_35K_P > 12.25) => -0.0150095837,
            (C_INC_35K_P = NULL) => 0.0220900795, 0.0220900795),
         (c_rich_wht > 97.5) => -0.0520961127,
         (c_rich_wht = NULL) => -0.0057666879, -0.0057666879),
      (c_hh1_p = NULL) => -0.0217814885, -0.0217814885),
   (c_fammar_p > 62.35) => 0.0137715066,
   (c_fammar_p = NULL) => -0.0041303872, 0.0070627037),
(r_C14_addrs_15yr_i > 4.5) => -0.0176004396,
(r_C14_addrs_15yr_i = NULL) => 0.0390813760, 0.0014060869);

// Tree: 328 
woFDN_FL_PSD_lgt_328 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.15) => -0.0089029500,
(c_pop_35_44_p > 14.15) => 
   map(
   (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 1.5) => 0.0105758980,
   (f_divssnidmsrcurelcount_i > 1.5) => 
      map(
      (NULL < c_finance and c_finance <= 8.55) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 116.5) => -0.0274203466,
         (c_rest_indx > 116.5) => 0.1549930919,
         (c_rest_indx = NULL) => 0.0362303000, 0.0362303000),
      (c_finance > 8.55) => 0.2228301173,
      (c_finance = NULL) => 0.0695050926, 0.0695050926),
   (f_divssnidmsrcurelcount_i = NULL) => 0.0249027094, 0.0131848552),
(c_pop_35_44_p = NULL) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 36.5) => 0.0967081267,
   (f_prevaddrlenofres_d > 36.5) => -0.0643924539,
   (f_prevaddrlenofres_d = NULL) => 0.0089360863, 0.0089360863), 0.0032643035);

// Tree: 329 
woFDN_FL_PSD_lgt_329 := map(
(NULL < c_hval_20k_p and c_hval_20k_p <= 37.85) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0155624270,
   (f_addrs_per_ssn_i > 4.5) => 
      map(
      (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 0.0025421821,
      (f_inq_Other_count_i > 0.5) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 85776.5) => 0.0109058387,
         (f_prevaddrmedianincome_d > 85776.5) => 0.0885532839,
         (f_prevaddrmedianincome_d = NULL) => 0.0287055284, 0.0287055284),
      (f_inq_Other_count_i = NULL) => 0.0092044067, 0.0092044067),
   (f_addrs_per_ssn_i = NULL) => 0.0031803138, 0.0031803138),
(c_hval_20k_p > 37.85) => 0.0903236335,
(c_hval_20k_p = NULL) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 1.5) => 0.0475234431,
   (f_assocsuspicousidcount_i > 1.5) => -0.0554955042,
   (f_assocsuspicousidcount_i = NULL) => -0.0090552168, -0.0090552168), 0.0033348222);

// Tree: 330 
woFDN_FL_PSD_lgt_330 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 918617) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 13.05) => -0.0538592987,
   (c_low_ed > 13.05) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 22.75) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 13.5) => -0.0602984229,
         (c_exp_prod > 13.5) => 0.0012188144,
         (c_exp_prod = NULL) => 0.0002565647, 0.0002565647),
      (c_pop_18_24_p > 22.75) => 
         map(
         (NULL < c_bargains and c_bargains <= 48.5) => 0.2057529896,
         (c_bargains > 48.5) => 0.0348764110,
         (c_bargains = NULL) => 0.0654543250, 0.0654543250),
      (c_pop_18_24_p = NULL) => 0.0018944106, 0.0018944106),
   (c_low_ed = NULL) => -0.0011405825, -0.0021244243),
(f_curraddrmedianvalue_d > 918617) => 0.1600632583,
(f_curraddrmedianvalue_d = NULL) => -0.0138355589, -0.0015116823);

// Tree: 331 
woFDN_FL_PSD_lgt_331 := map(
(NULL < r_C22_stl_inq_Count24_i and r_C22_stl_inq_Count24_i <= 0.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 39.8) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 75.25) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 599.05) => -0.0009181113,
         (c_oldhouse > 599.05) => -0.0488622967,
         (c_oldhouse = NULL) => -0.0024051286, -0.0024051286),
      (c_rnt1000_p > 75.25) => 
         map(
         (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 0.1728645501,
         (f_phone_ver_insurance_d > 2.5) => -0.0061234821,
         (f_phone_ver_insurance_d = NULL) => 0.0550612024, 0.0550612024),
      (c_rnt1000_p = NULL) => -0.0014712591, -0.0014712591),
   (c_hval_80k_p > 39.8) => -0.0851129022,
   (c_hval_80k_p = NULL) => -0.0010110162, -0.0023827023),
(r_C22_stl_inq_Count24_i > 0.5) => -0.0645426199,
(r_C22_stl_inq_Count24_i = NULL) => 0.0026834375, -0.0027253846);

// Tree: 332 
woFDN_FL_PSD_lgt_332 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 105.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 2.5) => 0.0886786506,
      (f_mos_inq_banko_om_fseen_d > 2.5) => -0.0004514344,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0016450115, 0.0016450115),
   (f_historical_count_d > 0.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
         map(
         (NULL < c_apt20 and c_apt20 <= 194.5) => -0.0303569561,
         (c_apt20 > 194.5) => 0.1661636251,
         (c_apt20 = NULL) => -0.0253817515, -0.0253817515),
      (f_varrisktype_i > 3.5) => -0.0639186186,
      (f_varrisktype_i = NULL) => -0.0278456169, -0.0278456169),
   (f_historical_count_d = NULL) => -0.0122619647, -0.0122619647),
(r_C13_Curr_Addr_LRes_d > 105.5) => 0.0131012688,
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0399010884, -0.0035099129);

// Tree: 333 
woFDN_FL_PSD_lgt_333 := map(
(NULL < c_low_hval and c_low_hval <= 72.1) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 29.5) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 5.35) => 0.0860370930,
      (C_INC_100K_P > 5.35) => 
         map(
         (NULL < c_rental and c_rental <= 93.5) => 
            map(
            (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 61) => 0.0339129967,
            (f_mos_inq_banko_cm_fseen_d > 61) => 0.1797455857,
            (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0482383983, 0.0482383983),
         (c_rental > 93.5) => -0.0108168962,
         (c_rental = NULL) => 0.0142742098, 0.0142742098),
      (C_INC_100K_P = NULL) => 0.0189239516, 0.0189239516),
   (f_mos_inq_banko_cm_lseen_d > 29.5) => -0.0053146433,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0080647961, -0.0026792153),
(c_low_hval > 72.1) => -0.0777329336,
(c_low_hval = NULL) => 0.0088152429, -0.0029094946);

// Tree: 334 
woFDN_FL_PSD_lgt_334 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 3749.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 9.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 13.5) => -0.0091960042,
      (f_rel_educationover12_count_d > 13.5) => 
         map(
         (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0071922103,
         (f_hh_lienholders_i > 0.5) => -0.1167842764,
         (f_hh_lienholders_i = NULL) => -0.0740166408, -0.0740166408),
      (f_rel_educationover12_count_d = NULL) => -0.0269432236, -0.0269432236),
   (f_mos_inq_banko_cm_lseen_d > 9.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 17.5) => 0.0026259205,
      (f_inq_HighRiskCredit_count_i > 17.5) => 0.0819092376,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0029915572, 0.0029915572),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0015531202, 0.0015531202),
(f_liens_unrel_ST_total_amt_i > 3749.5) => 0.0908918608,
(f_liens_unrel_ST_total_amt_i = NULL) => 0.0168518196, 0.0021043523);

// Tree: 335 
woFDN_FL_PSD_lgt_335 := map(
(NULL < c_hh00 and c_hh00 <= 278.5) => -0.0451801181,
(c_hh00 > 278.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 9.95) => -0.0061380970,
      (c_hval_20k_p > 9.95) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 44.2) => 
            map(
            (NULL < c_rnt500_p and c_rnt500_p <= 50.2) => -0.0127937619,
            (c_rnt500_p > 50.2) => 0.1243683750,
            (c_rnt500_p = NULL) => 0.0220589123, 0.0220589123),
         (c_newhouse > 44.2) => 0.1704516806,
         (c_newhouse = NULL) => 0.0445113833, 0.0445113833),
      (c_hval_20k_p = NULL) => -0.0029107642, -0.0029107642),
   (f_inq_Other_count_i > 0.5) => 0.0196911602,
   (f_inq_Other_count_i = NULL) => -0.0195738663, 0.0021130109),
(c_hh00 = NULL) => -0.0095886169, -0.0002626344);

// Tree: 336 
woFDN_FL_PSD_lgt_336 := map(
(NULL < c_rnt250_p and c_rnt250_p <= 43.05) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 1.5) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 23.75) => 0.0046755827,
      (c_pop_25_34_p > 23.75) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 45.15) => -0.0434287841,
         (c_hh2_p > 45.15) => 0.1062508792,
         (c_hh2_p = NULL) => -0.0332724032, -0.0332724032),
      (c_pop_25_34_p = NULL) => 0.0009409687, 0.0009409687),
   (f_srchfraudsrchcountmo_i > 1.5) => 0.0584460703,
   (f_srchfraudsrchcountmo_i = NULL) => 0.0059643648, 0.0014217727),
(c_rnt250_p > 43.05) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 135) => 0.0135921953,
   (c_relig_indx > 135) => 0.1690123716,
   (c_relig_indx = NULL) => 0.0677933492, 0.0677933492),
(c_rnt250_p = NULL) => -0.0022767008, 0.0025839620);

// Tree: 337 
woFDN_FL_PSD_lgt_337 := map(
(NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 118.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 12.5) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 3.05) => -0.0585785151,
      (c_hval_300k_p > 3.05) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.27622511015) => 
            map(
            (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0025891797,
            (r_Phn_Cell_n > 0.5) => 0.2099685557,
            (r_Phn_Cell_n = NULL) => 0.1035260441, 0.1035260441),
         (f_add_curr_mobility_index_i > 0.27622511015) => -0.0627220149,
         (f_add_curr_mobility_index_i = NULL) => 0.0410682098, 0.0410682098),
      (c_hval_300k_p = NULL) => -0.0048997734, -0.0048997734),
   (f_rel_ageover30_count_d > 12.5) => -0.0751830795,
   (f_rel_ageover30_count_d = NULL) => -0.0291400659, -0.0291400659),
(f_mos_liens_unrel_CJ_fseen_d > 118.5) => 0.0060729654,
(f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0258347370, 0.0047933848);

// Tree: 338 
woFDN_FL_PSD_lgt_338 := map(
(NULL < c_professional and c_professional <= 37.45) => 
   map(
   (NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i <= 4.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 2.55) => 0.0738948378,
         (c_hh6_p > 2.55) => -0.0501244155,
         (c_hh6_p = NULL) => 0.0331213846, 0.0331213846),
      (f_corrssnnamecount_d > 1.5) => -0.0026331998,
      (f_corrssnnamecount_d = NULL) => -0.0006741671, -0.0006741671),
   (r_C12_NonDerog_Recency_i > 4.5) => 0.0965487254,
   (r_C12_NonDerog_Recency_i = NULL) => 0.0129023874, -0.0001727216),
(c_professional > 37.45) => -0.0683547112,
(c_professional = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => -0.0526036798,
   (f_util_adl_count_n > 1.5) => 0.1141514959,
   (f_util_adl_count_n = NULL) => 0.0215756688, 0.0215756688), -0.0011228780);

// Tree: 339 
woFDN_FL_PSD_lgt_339 := map(
(NULL < c_professional and c_professional <= 16.65) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 19.55) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 8.5) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 123.5) => 0.0067514836,
         (c_blue_empl > 123.5) => 0.0370390964,
         (c_blue_empl = NULL) => 0.0136048850, 0.0136048850),
      (f_srchvelocityrisktype_i > 8.5) => -0.0655494710,
      (f_srchvelocityrisktype_i = NULL) => -0.0047848085, 0.0129149252),
   (c_blue_col > 19.55) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 0.05) => 0.0836754207,
      (c_hh5_p > 0.05) => -0.0312645964,
      (c_hh5_p = NULL) => -0.0235521710, -0.0235521710),
   (c_blue_col = NULL) => 0.0082531105, 0.0082531105),
(c_professional > 16.65) => -0.0295349525,
(c_professional = NULL) => 0.0001024874, 0.0035035376);

// Tree: 340 
woFDN_FL_PSD_lgt_340 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 4.5) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 14939.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly']) => -0.0263413580,
      (nf_seg_FraudPoint_3_0 in ['3: Derog','6: Other']) => 0.1245671138,
      (nf_seg_FraudPoint_3_0 = '') => 0.0477155773, 0.0477155773),
   (c_med_hval > 14939.5) => -0.0043968191,
   (c_med_hval = NULL) => 0.0246644919, -0.0032360929),
(f_srchfraudsrchcountyr_i > 4.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 135) => -0.0042774651,
   (c_asian_lang > 135) => 0.0982207065,
   (c_asian_lang = NULL) => 0.0424161464, 0.0424161464),
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 30.5) => -0.0624675068,
   (k_comb_age_d > 30.5) => 0.0365100177,
   (k_comb_age_d = NULL) => -0.0180982717, -0.0180982717), -0.0027098021);

// Tree: 341 
woFDN_FL_PSD_lgt_341 := map(
(NULL < c_totsales and c_totsales <= 932) => 
   map(
   (NULL < c_med_age and c_med_age <= 26.05) => -0.0742620685,
   (c_med_age > 26.05) => -0.0120943536,
   (c_med_age = NULL) => -0.0153829356, -0.0153829356),
(c_totsales > 932) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 0.0013972139,
   (f_hh_criminals_i > 0.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 10.45) => 0.0199317450,
      (c_femdiv_p > 10.45) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 139.5) => 0.0285552669,
         (c_asian_lang > 139.5) => 0.2113506629,
         (c_asian_lang = NULL) => 0.0946727506, 0.0946727506),
      (c_femdiv_p = NULL) => 0.0232997481, 0.0232997481),
   (f_hh_criminals_i = NULL) => -0.0171621868, 0.0083956714),
(c_totsales = NULL) => 0.0190790624, 0.0034964858);

// Tree: 342 
woFDN_FL_PSD_lgt_342 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => -0.0057190631,
(f_util_adl_count_n > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 16.4) => 0.1764163292,
      (C_INC_75K_P > 16.4) => 0.0334396665,
      (C_INC_75K_P = NULL) => 0.0892005649, 0.0892005649),
   (k_comb_age_d > 24.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 12222) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0967495681,
         (f_phone_ver_experian_d > 0.5) => 0.0272895804,
         (f_phone_ver_experian_d = NULL) => -0.0120574421, 0.0449784627),
      (r_A49_Curr_AVM_Chg_1yr_i > 12222) => -0.0411575099,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0073981225, 0.0057364640),
   (k_comb_age_d = NULL) => 0.0131571279, 0.0131571279),
(f_util_adl_count_n = NULL) => 0.0283818449, -0.0020854650);

// Tree: 343 
woFDN_FL_PSD_lgt_343 := map(
(NULL < c_sfdu_p and c_sfdu_p <= 94.95) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_rental and c_rental <= 115.5) => -0.0025266782,
      (c_rental > 115.5) => 
         map(
         (NULL < f_hh_college_attendees_d and f_hh_college_attendees_d <= 0.5) => 
            map(
            (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0275724774,
            (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.1027423753,
            (nf_seg_FraudPoint_3_0 = '') => 0.0364002685, 0.0364002685),
         (f_hh_college_attendees_d > 0.5) => 0.2881165294,
         (f_hh_college_attendees_d = NULL) => 0.0874731330, 0.0874731330),
      (c_rental = NULL) => 0.0433034840, 0.0433034840),
   (f_corrssnnamecount_d > 1.5) => 0.0022300071,
   (f_corrssnnamecount_d = NULL) => 0.0182640072, 0.0046477685),
(c_sfdu_p > 94.95) => -0.0252061734,
(c_sfdu_p = NULL) => -0.0055446082, -0.0018897677);

// Final Score Sum 

   woFDN_FL_PSD_lgt := sum(
      woFDN_FL_PSD_lgt_0, woFDN_FL_PSD_lgt_1, woFDN_FL_PSD_lgt_2, woFDN_FL_PSD_lgt_3, woFDN_FL_PSD_lgt_4, 
      woFDN_FL_PSD_lgt_5, woFDN_FL_PSD_lgt_6, woFDN_FL_PSD_lgt_7, woFDN_FL_PSD_lgt_8, woFDN_FL_PSD_lgt_9, 
      woFDN_FL_PSD_lgt_10, woFDN_FL_PSD_lgt_11, woFDN_FL_PSD_lgt_12, woFDN_FL_PSD_lgt_13, woFDN_FL_PSD_lgt_14, 
      woFDN_FL_PSD_lgt_15, woFDN_FL_PSD_lgt_16, woFDN_FL_PSD_lgt_17, woFDN_FL_PSD_lgt_18, woFDN_FL_PSD_lgt_19, 
      woFDN_FL_PSD_lgt_20, woFDN_FL_PSD_lgt_21, woFDN_FL_PSD_lgt_22, woFDN_FL_PSD_lgt_23, woFDN_FL_PSD_lgt_24, 
      woFDN_FL_PSD_lgt_25, woFDN_FL_PSD_lgt_26, woFDN_FL_PSD_lgt_27, woFDN_FL_PSD_lgt_28, woFDN_FL_PSD_lgt_29, 
      woFDN_FL_PSD_lgt_30, woFDN_FL_PSD_lgt_31, woFDN_FL_PSD_lgt_32, woFDN_FL_PSD_lgt_33, woFDN_FL_PSD_lgt_34, 
      woFDN_FL_PSD_lgt_35, woFDN_FL_PSD_lgt_36, woFDN_FL_PSD_lgt_37, woFDN_FL_PSD_lgt_38, woFDN_FL_PSD_lgt_39, 
      woFDN_FL_PSD_lgt_40, woFDN_FL_PSD_lgt_41, woFDN_FL_PSD_lgt_42, woFDN_FL_PSD_lgt_43, woFDN_FL_PSD_lgt_44, 
      woFDN_FL_PSD_lgt_45, woFDN_FL_PSD_lgt_46, woFDN_FL_PSD_lgt_47, woFDN_FL_PSD_lgt_48, woFDN_FL_PSD_lgt_49, 
      woFDN_FL_PSD_lgt_50, woFDN_FL_PSD_lgt_51, woFDN_FL_PSD_lgt_52, woFDN_FL_PSD_lgt_53, woFDN_FL_PSD_lgt_54, 
      woFDN_FL_PSD_lgt_55, woFDN_FL_PSD_lgt_56, woFDN_FL_PSD_lgt_57, woFDN_FL_PSD_lgt_58, woFDN_FL_PSD_lgt_59, 
      woFDN_FL_PSD_lgt_60, woFDN_FL_PSD_lgt_61, woFDN_FL_PSD_lgt_62, woFDN_FL_PSD_lgt_63, woFDN_FL_PSD_lgt_64, 
      woFDN_FL_PSD_lgt_65, woFDN_FL_PSD_lgt_66, woFDN_FL_PSD_lgt_67, woFDN_FL_PSD_lgt_68, woFDN_FL_PSD_lgt_69, 
      woFDN_FL_PSD_lgt_70, woFDN_FL_PSD_lgt_71, woFDN_FL_PSD_lgt_72, woFDN_FL_PSD_lgt_73, woFDN_FL_PSD_lgt_74, 
      woFDN_FL_PSD_lgt_75, woFDN_FL_PSD_lgt_76, woFDN_FL_PSD_lgt_77, woFDN_FL_PSD_lgt_78, woFDN_FL_PSD_lgt_79, 
      woFDN_FL_PSD_lgt_80, woFDN_FL_PSD_lgt_81, woFDN_FL_PSD_lgt_82, woFDN_FL_PSD_lgt_83, woFDN_FL_PSD_lgt_84, 
      woFDN_FL_PSD_lgt_85, woFDN_FL_PSD_lgt_86, woFDN_FL_PSD_lgt_87, woFDN_FL_PSD_lgt_88, woFDN_FL_PSD_lgt_89, 
      woFDN_FL_PSD_lgt_90, woFDN_FL_PSD_lgt_91, woFDN_FL_PSD_lgt_92, woFDN_FL_PSD_lgt_93, woFDN_FL_PSD_lgt_94, 
      woFDN_FL_PSD_lgt_95, woFDN_FL_PSD_lgt_96, woFDN_FL_PSD_lgt_97, woFDN_FL_PSD_lgt_98, woFDN_FL_PSD_lgt_99, 
      woFDN_FL_PSD_lgt_100, woFDN_FL_PSD_lgt_101, woFDN_FL_PSD_lgt_102, woFDN_FL_PSD_lgt_103, woFDN_FL_PSD_lgt_104, 
      woFDN_FL_PSD_lgt_105, woFDN_FL_PSD_lgt_106, woFDN_FL_PSD_lgt_107, woFDN_FL_PSD_lgt_108, woFDN_FL_PSD_lgt_109, 
      woFDN_FL_PSD_lgt_110, woFDN_FL_PSD_lgt_111, woFDN_FL_PSD_lgt_112, woFDN_FL_PSD_lgt_113, woFDN_FL_PSD_lgt_114, 
      woFDN_FL_PSD_lgt_115, woFDN_FL_PSD_lgt_116, woFDN_FL_PSD_lgt_117, woFDN_FL_PSD_lgt_118, woFDN_FL_PSD_lgt_119, 
      woFDN_FL_PSD_lgt_120, woFDN_FL_PSD_lgt_121, woFDN_FL_PSD_lgt_122, woFDN_FL_PSD_lgt_123, woFDN_FL_PSD_lgt_124, 
      woFDN_FL_PSD_lgt_125, woFDN_FL_PSD_lgt_126, woFDN_FL_PSD_lgt_127, woFDN_FL_PSD_lgt_128, woFDN_FL_PSD_lgt_129, 
      woFDN_FL_PSD_lgt_130, woFDN_FL_PSD_lgt_131, woFDN_FL_PSD_lgt_132, woFDN_FL_PSD_lgt_133, woFDN_FL_PSD_lgt_134, 
      woFDN_FL_PSD_lgt_135, woFDN_FL_PSD_lgt_136, woFDN_FL_PSD_lgt_137, woFDN_FL_PSD_lgt_138, woFDN_FL_PSD_lgt_139, 
      woFDN_FL_PSD_lgt_140, woFDN_FL_PSD_lgt_141, woFDN_FL_PSD_lgt_142, woFDN_FL_PSD_lgt_143, woFDN_FL_PSD_lgt_144, 
      woFDN_FL_PSD_lgt_145, woFDN_FL_PSD_lgt_146, woFDN_FL_PSD_lgt_147, woFDN_FL_PSD_lgt_148, woFDN_FL_PSD_lgt_149, 
      woFDN_FL_PSD_lgt_150, woFDN_FL_PSD_lgt_151, woFDN_FL_PSD_lgt_152, woFDN_FL_PSD_lgt_153, woFDN_FL_PSD_lgt_154, 
      woFDN_FL_PSD_lgt_155, woFDN_FL_PSD_lgt_156, woFDN_FL_PSD_lgt_157, woFDN_FL_PSD_lgt_158, woFDN_FL_PSD_lgt_159, 
      woFDN_FL_PSD_lgt_160, woFDN_FL_PSD_lgt_161, woFDN_FL_PSD_lgt_162, woFDN_FL_PSD_lgt_163, woFDN_FL_PSD_lgt_164, 
      woFDN_FL_PSD_lgt_165, woFDN_FL_PSD_lgt_166, woFDN_FL_PSD_lgt_167, woFDN_FL_PSD_lgt_168, woFDN_FL_PSD_lgt_169, 
      woFDN_FL_PSD_lgt_170, woFDN_FL_PSD_lgt_171, woFDN_FL_PSD_lgt_172, woFDN_FL_PSD_lgt_173, woFDN_FL_PSD_lgt_174, 
      woFDN_FL_PSD_lgt_175, woFDN_FL_PSD_lgt_176, woFDN_FL_PSD_lgt_177, woFDN_FL_PSD_lgt_178, woFDN_FL_PSD_lgt_179, 
      woFDN_FL_PSD_lgt_180, woFDN_FL_PSD_lgt_181, woFDN_FL_PSD_lgt_182, woFDN_FL_PSD_lgt_183, woFDN_FL_PSD_lgt_184, 
      woFDN_FL_PSD_lgt_185, woFDN_FL_PSD_lgt_186, woFDN_FL_PSD_lgt_187, woFDN_FL_PSD_lgt_188, woFDN_FL_PSD_lgt_189, 
      woFDN_FL_PSD_lgt_190, woFDN_FL_PSD_lgt_191, woFDN_FL_PSD_lgt_192, woFDN_FL_PSD_lgt_193, woFDN_FL_PSD_lgt_194, 
      woFDN_FL_PSD_lgt_195, woFDN_FL_PSD_lgt_196, woFDN_FL_PSD_lgt_197, woFDN_FL_PSD_lgt_198, woFDN_FL_PSD_lgt_199, 
      woFDN_FL_PSD_lgt_200, woFDN_FL_PSD_lgt_201, woFDN_FL_PSD_lgt_202, woFDN_FL_PSD_lgt_203, woFDN_FL_PSD_lgt_204, 
      woFDN_FL_PSD_lgt_205, woFDN_FL_PSD_lgt_206, woFDN_FL_PSD_lgt_207, woFDN_FL_PSD_lgt_208, woFDN_FL_PSD_lgt_209, 
      woFDN_FL_PSD_lgt_210, woFDN_FL_PSD_lgt_211, woFDN_FL_PSD_lgt_212, woFDN_FL_PSD_lgt_213, woFDN_FL_PSD_lgt_214, 
      woFDN_FL_PSD_lgt_215, woFDN_FL_PSD_lgt_216, woFDN_FL_PSD_lgt_217, woFDN_FL_PSD_lgt_218, woFDN_FL_PSD_lgt_219, 
      woFDN_FL_PSD_lgt_220, woFDN_FL_PSD_lgt_221, woFDN_FL_PSD_lgt_222, woFDN_FL_PSD_lgt_223, woFDN_FL_PSD_lgt_224, 
      woFDN_FL_PSD_lgt_225, woFDN_FL_PSD_lgt_226, woFDN_FL_PSD_lgt_227, woFDN_FL_PSD_lgt_228, woFDN_FL_PSD_lgt_229, 
      woFDN_FL_PSD_lgt_230, woFDN_FL_PSD_lgt_231, woFDN_FL_PSD_lgt_232, woFDN_FL_PSD_lgt_233, woFDN_FL_PSD_lgt_234, 
      woFDN_FL_PSD_lgt_235, woFDN_FL_PSD_lgt_236, woFDN_FL_PSD_lgt_237, woFDN_FL_PSD_lgt_238, woFDN_FL_PSD_lgt_239, 
      woFDN_FL_PSD_lgt_240, woFDN_FL_PSD_lgt_241, woFDN_FL_PSD_lgt_242, woFDN_FL_PSD_lgt_243, woFDN_FL_PSD_lgt_244, 
      woFDN_FL_PSD_lgt_245, woFDN_FL_PSD_lgt_246, woFDN_FL_PSD_lgt_247, woFDN_FL_PSD_lgt_248, woFDN_FL_PSD_lgt_249, 
      woFDN_FL_PSD_lgt_250, woFDN_FL_PSD_lgt_251, woFDN_FL_PSD_lgt_252, woFDN_FL_PSD_lgt_253, woFDN_FL_PSD_lgt_254, 
      woFDN_FL_PSD_lgt_255, woFDN_FL_PSD_lgt_256, woFDN_FL_PSD_lgt_257, woFDN_FL_PSD_lgt_258, woFDN_FL_PSD_lgt_259, 
      woFDN_FL_PSD_lgt_260, woFDN_FL_PSD_lgt_261, woFDN_FL_PSD_lgt_262, woFDN_FL_PSD_lgt_263, woFDN_FL_PSD_lgt_264, 
      woFDN_FL_PSD_lgt_265, woFDN_FL_PSD_lgt_266, woFDN_FL_PSD_lgt_267, woFDN_FL_PSD_lgt_268, woFDN_FL_PSD_lgt_269, 
      woFDN_FL_PSD_lgt_270, woFDN_FL_PSD_lgt_271, woFDN_FL_PSD_lgt_272, woFDN_FL_PSD_lgt_273, woFDN_FL_PSD_lgt_274, 
      woFDN_FL_PSD_lgt_275, woFDN_FL_PSD_lgt_276, woFDN_FL_PSD_lgt_277, woFDN_FL_PSD_lgt_278, woFDN_FL_PSD_lgt_279, 
      woFDN_FL_PSD_lgt_280, woFDN_FL_PSD_lgt_281, woFDN_FL_PSD_lgt_282, woFDN_FL_PSD_lgt_283, woFDN_FL_PSD_lgt_284, 
      woFDN_FL_PSD_lgt_285, woFDN_FL_PSD_lgt_286, woFDN_FL_PSD_lgt_287, woFDN_FL_PSD_lgt_288, woFDN_FL_PSD_lgt_289, 
      woFDN_FL_PSD_lgt_290, woFDN_FL_PSD_lgt_291, woFDN_FL_PSD_lgt_292, woFDN_FL_PSD_lgt_293, woFDN_FL_PSD_lgt_294, 
      woFDN_FL_PSD_lgt_295, woFDN_FL_PSD_lgt_296, woFDN_FL_PSD_lgt_297, woFDN_FL_PSD_lgt_298, woFDN_FL_PSD_lgt_299, 
      woFDN_FL_PSD_lgt_300, woFDN_FL_PSD_lgt_301, woFDN_FL_PSD_lgt_302, woFDN_FL_PSD_lgt_303, woFDN_FL_PSD_lgt_304, 
      woFDN_FL_PSD_lgt_305, woFDN_FL_PSD_lgt_306, woFDN_FL_PSD_lgt_307, woFDN_FL_PSD_lgt_308, woFDN_FL_PSD_lgt_309, 
      woFDN_FL_PSD_lgt_310, woFDN_FL_PSD_lgt_311, woFDN_FL_PSD_lgt_312, woFDN_FL_PSD_lgt_313, woFDN_FL_PSD_lgt_314, 
      woFDN_FL_PSD_lgt_315, woFDN_FL_PSD_lgt_316, woFDN_FL_PSD_lgt_317, woFDN_FL_PSD_lgt_318, woFDN_FL_PSD_lgt_319, 
      woFDN_FL_PSD_lgt_320, woFDN_FL_PSD_lgt_321, woFDN_FL_PSD_lgt_322, woFDN_FL_PSD_lgt_323, woFDN_FL_PSD_lgt_324, 
      woFDN_FL_PSD_lgt_325, woFDN_FL_PSD_lgt_326, woFDN_FL_PSD_lgt_327, woFDN_FL_PSD_lgt_328, woFDN_FL_PSD_lgt_329, 
      woFDN_FL_PSD_lgt_330, woFDN_FL_PSD_lgt_331, woFDN_FL_PSD_lgt_332, woFDN_FL_PSD_lgt_333, woFDN_FL_PSD_lgt_334, 
      woFDN_FL_PSD_lgt_335, woFDN_FL_PSD_lgt_336, woFDN_FL_PSD_lgt_337, woFDN_FL_PSD_lgt_338, woFDN_FL_PSD_lgt_339, 
      woFDN_FL_PSD_lgt_340, woFDN_FL_PSD_lgt_341, woFDN_FL_PSD_lgt_342, woFDN_FL_PSD_lgt_343); 


// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_woFDN_LGT := woFDN_FL_PSD_lgt;
			
self.final_score_0	:= 	woFDN_FL_PSD_lgt_0	;
self.final_score_1	:= 	woFDN_FL_PSD_lgt_1	;
self.final_score_2	:= 	woFDN_FL_PSD_lgt_2	;
self.final_score_3	:= 	woFDN_FL_PSD_lgt_3	;
self.final_score_4	:= 	woFDN_FL_PSD_lgt_4	;
self.final_score_5	:= 	woFDN_FL_PSD_lgt_5	;
self.final_score_6	:= 	woFDN_FL_PSD_lgt_6	;
self.final_score_7	:= 	woFDN_FL_PSD_lgt_7	;
self.final_score_8	:= 	woFDN_FL_PSD_lgt_8	;
self.final_score_9	:= 	woFDN_FL_PSD_lgt_9	;
self.final_score_10	:= 	woFDN_FL_PSD_lgt_10	;
self.final_score_11	:= 	woFDN_FL_PSD_lgt_11	;
self.final_score_12	:= 	woFDN_FL_PSD_lgt_12	;
self.final_score_13	:= 	woFDN_FL_PSD_lgt_13	;
self.final_score_14	:= 	woFDN_FL_PSD_lgt_14	;
self.final_score_15	:= 	woFDN_FL_PSD_lgt_15	;
self.final_score_16	:= 	woFDN_FL_PSD_lgt_16	;
self.final_score_17	:= 	woFDN_FL_PSD_lgt_17	;
self.final_score_18	:= 	woFDN_FL_PSD_lgt_18	;
self.final_score_19	:= 	woFDN_FL_PSD_lgt_19	;
self.final_score_20	:= 	woFDN_FL_PSD_lgt_20	;
self.final_score_21	:= 	woFDN_FL_PSD_lgt_21	;
self.final_score_22	:= 	woFDN_FL_PSD_lgt_22	;
self.final_score_23	:= 	woFDN_FL_PSD_lgt_23	;
self.final_score_24	:= 	woFDN_FL_PSD_lgt_24	;
self.final_score_25	:= 	woFDN_FL_PSD_lgt_25	;
self.final_score_26	:= 	woFDN_FL_PSD_lgt_26	;
self.final_score_27	:= 	woFDN_FL_PSD_lgt_27	;
self.final_score_28	:= 	woFDN_FL_PSD_lgt_28	;
self.final_score_29	:= 	woFDN_FL_PSD_lgt_29	;
self.final_score_30	:= 	woFDN_FL_PSD_lgt_30	;
self.final_score_31	:= 	woFDN_FL_PSD_lgt_31	;
self.final_score_32	:= 	woFDN_FL_PSD_lgt_32	;
self.final_score_33	:= 	woFDN_FL_PSD_lgt_33	;
self.final_score_34	:= 	woFDN_FL_PSD_lgt_34	;
self.final_score_35	:= 	woFDN_FL_PSD_lgt_35	;
self.final_score_36	:= 	woFDN_FL_PSD_lgt_36	;
self.final_score_37	:= 	woFDN_FL_PSD_lgt_37	;
self.final_score_38	:= 	woFDN_FL_PSD_lgt_38	;
self.final_score_39	:= 	woFDN_FL_PSD_lgt_39	;
self.final_score_40	:= 	woFDN_FL_PSD_lgt_40	;
self.final_score_41	:= 	woFDN_FL_PSD_lgt_41	;
self.final_score_42	:= 	woFDN_FL_PSD_lgt_42	;
self.final_score_43	:= 	woFDN_FL_PSD_lgt_43	;
self.final_score_44	:= 	woFDN_FL_PSD_lgt_44	;
self.final_score_45	:= 	woFDN_FL_PSD_lgt_45	;
self.final_score_46	:= 	woFDN_FL_PSD_lgt_46	;
self.final_score_47	:= 	woFDN_FL_PSD_lgt_47	;
self.final_score_48	:= 	woFDN_FL_PSD_lgt_48	;
self.final_score_49	:= 	woFDN_FL_PSD_lgt_49	;
self.final_score_50	:= 	woFDN_FL_PSD_lgt_50	;
self.final_score_51	:= 	woFDN_FL_PSD_lgt_51	;
self.final_score_52	:= 	woFDN_FL_PSD_lgt_52	;
self.final_score_53	:= 	woFDN_FL_PSD_lgt_53	;
self.final_score_54	:= 	woFDN_FL_PSD_lgt_54	;
self.final_score_55	:= 	woFDN_FL_PSD_lgt_55	;
self.final_score_56	:= 	woFDN_FL_PSD_lgt_56	;
self.final_score_57	:= 	woFDN_FL_PSD_lgt_57	;
self.final_score_58	:= 	woFDN_FL_PSD_lgt_58	;
self.final_score_59	:= 	woFDN_FL_PSD_lgt_59	;
self.final_score_60	:= 	woFDN_FL_PSD_lgt_60	;
self.final_score_61	:= 	woFDN_FL_PSD_lgt_61	;
self.final_score_62	:= 	woFDN_FL_PSD_lgt_62	;
self.final_score_63	:= 	woFDN_FL_PSD_lgt_63	;
self.final_score_64	:= 	woFDN_FL_PSD_lgt_64	;
self.final_score_65	:= 	woFDN_FL_PSD_lgt_65	;
self.final_score_66	:= 	woFDN_FL_PSD_lgt_66	;
self.final_score_67	:= 	woFDN_FL_PSD_lgt_67	;
self.final_score_68	:= 	woFDN_FL_PSD_lgt_68	;
self.final_score_69	:= 	woFDN_FL_PSD_lgt_69	;
self.final_score_70	:= 	woFDN_FL_PSD_lgt_70	;
self.final_score_71	:= 	woFDN_FL_PSD_lgt_71	;
self.final_score_72	:= 	woFDN_FL_PSD_lgt_72	;
self.final_score_73	:= 	woFDN_FL_PSD_lgt_73	;
self.final_score_74	:= 	woFDN_FL_PSD_lgt_74	;
self.final_score_75	:= 	woFDN_FL_PSD_lgt_75	;
self.final_score_76	:= 	woFDN_FL_PSD_lgt_76	;
self.final_score_77	:= 	woFDN_FL_PSD_lgt_77	;
self.final_score_78	:= 	woFDN_FL_PSD_lgt_78	;
self.final_score_79	:= 	woFDN_FL_PSD_lgt_79	;
self.final_score_80	:= 	woFDN_FL_PSD_lgt_80	;
self.final_score_81	:= 	woFDN_FL_PSD_lgt_81	;
self.final_score_82	:= 	woFDN_FL_PSD_lgt_82	;
self.final_score_83	:= 	woFDN_FL_PSD_lgt_83	;
self.final_score_84	:= 	woFDN_FL_PSD_lgt_84	;
self.final_score_85	:= 	woFDN_FL_PSD_lgt_85	;
self.final_score_86	:= 	woFDN_FL_PSD_lgt_86	;
self.final_score_87	:= 	woFDN_FL_PSD_lgt_87	;
self.final_score_88	:= 	woFDN_FL_PSD_lgt_88	;
self.final_score_89	:= 	woFDN_FL_PSD_lgt_89	;
self.final_score_90	:= 	woFDN_FL_PSD_lgt_90	;
self.final_score_91	:= 	woFDN_FL_PSD_lgt_91	;
self.final_score_92	:= 	woFDN_FL_PSD_lgt_92	;
self.final_score_93	:= 	woFDN_FL_PSD_lgt_93	;
self.final_score_94	:= 	woFDN_FL_PSD_lgt_94	;
self.final_score_95	:= 	woFDN_FL_PSD_lgt_95	;
self.final_score_96	:= 	woFDN_FL_PSD_lgt_96	;
self.final_score_97	:= 	woFDN_FL_PSD_lgt_97	;
self.final_score_98	:= 	woFDN_FL_PSD_lgt_98	;
self.final_score_99	:= 	woFDN_FL_PSD_lgt_99	;
self.final_score_100	:= 	woFDN_FL_PSD_lgt_100	;
self.final_score_101	:= 	woFDN_FL_PSD_lgt_101	;
self.final_score_102	:= 	woFDN_FL_PSD_lgt_102	;
self.final_score_103	:= 	woFDN_FL_PSD_lgt_103	;
self.final_score_104	:= 	woFDN_FL_PSD_lgt_104	;
self.final_score_105	:= 	woFDN_FL_PSD_lgt_105	;
self.final_score_106	:= 	woFDN_FL_PSD_lgt_106	;
self.final_score_107	:= 	woFDN_FL_PSD_lgt_107	;
self.final_score_108	:= 	woFDN_FL_PSD_lgt_108	;
self.final_score_109	:= 	woFDN_FL_PSD_lgt_109	;
self.final_score_110	:= 	woFDN_FL_PSD_lgt_110	;
self.final_score_111	:= 	woFDN_FL_PSD_lgt_111	;
self.final_score_112	:= 	woFDN_FL_PSD_lgt_112	;
self.final_score_113	:= 	woFDN_FL_PSD_lgt_113	;
self.final_score_114	:= 	woFDN_FL_PSD_lgt_114	;
self.final_score_115	:= 	woFDN_FL_PSD_lgt_115	;
self.final_score_116	:= 	woFDN_FL_PSD_lgt_116	;
self.final_score_117	:= 	woFDN_FL_PSD_lgt_117	;
self.final_score_118	:= 	woFDN_FL_PSD_lgt_118	;
self.final_score_119	:= 	woFDN_FL_PSD_lgt_119	;
self.final_score_120	:= 	woFDN_FL_PSD_lgt_120	;
self.final_score_121	:= 	woFDN_FL_PSD_lgt_121	;
self.final_score_122	:= 	woFDN_FL_PSD_lgt_122	;
self.final_score_123	:= 	woFDN_FL_PSD_lgt_123	;
self.final_score_124	:= 	woFDN_FL_PSD_lgt_124	;
self.final_score_125	:= 	woFDN_FL_PSD_lgt_125	;
self.final_score_126	:= 	woFDN_FL_PSD_lgt_126	;
self.final_score_127	:= 	woFDN_FL_PSD_lgt_127	;
self.final_score_128	:= 	woFDN_FL_PSD_lgt_128	;
self.final_score_129	:= 	woFDN_FL_PSD_lgt_129	;
self.final_score_130	:= 	woFDN_FL_PSD_lgt_130	;
self.final_score_131	:= 	woFDN_FL_PSD_lgt_131	;
self.final_score_132	:= 	woFDN_FL_PSD_lgt_132	;
self.final_score_133	:= 	woFDN_FL_PSD_lgt_133	;
self.final_score_134	:= 	woFDN_FL_PSD_lgt_134	;
self.final_score_135	:= 	woFDN_FL_PSD_lgt_135	;
self.final_score_136	:= 	woFDN_FL_PSD_lgt_136	;
self.final_score_137	:= 	woFDN_FL_PSD_lgt_137	;
self.final_score_138	:= 	woFDN_FL_PSD_lgt_138	;
self.final_score_139	:= 	woFDN_FL_PSD_lgt_139	;
self.final_score_140	:= 	woFDN_FL_PSD_lgt_140	;
self.final_score_141	:= 	woFDN_FL_PSD_lgt_141	;
self.final_score_142	:= 	woFDN_FL_PSD_lgt_142	;
self.final_score_143	:= 	woFDN_FL_PSD_lgt_143	;
self.final_score_144	:= 	woFDN_FL_PSD_lgt_144	;
self.final_score_145	:= 	woFDN_FL_PSD_lgt_145	;
self.final_score_146	:= 	woFDN_FL_PSD_lgt_146	;
self.final_score_147	:= 	woFDN_FL_PSD_lgt_147	;
self.final_score_148	:= 	woFDN_FL_PSD_lgt_148	;
self.final_score_149	:= 	woFDN_FL_PSD_lgt_149	;
self.final_score_150	:= 	woFDN_FL_PSD_lgt_150	;
self.final_score_151	:= 	woFDN_FL_PSD_lgt_151	;
self.final_score_152	:= 	woFDN_FL_PSD_lgt_152	;
self.final_score_153	:= 	woFDN_FL_PSD_lgt_153	;
self.final_score_154	:= 	woFDN_FL_PSD_lgt_154	;
self.final_score_155	:= 	woFDN_FL_PSD_lgt_155	;
self.final_score_156	:= 	woFDN_FL_PSD_lgt_156	;
self.final_score_157	:= 	woFDN_FL_PSD_lgt_157	;
self.final_score_158	:= 	woFDN_FL_PSD_lgt_158	;
self.final_score_159	:= 	woFDN_FL_PSD_lgt_159	;
self.final_score_160	:= 	woFDN_FL_PSD_lgt_160	;
self.final_score_161	:= 	woFDN_FL_PSD_lgt_161	;
self.final_score_162	:= 	woFDN_FL_PSD_lgt_162	;
self.final_score_163	:= 	woFDN_FL_PSD_lgt_163	;
self.final_score_164	:= 	woFDN_FL_PSD_lgt_164	;
self.final_score_165	:= 	woFDN_FL_PSD_lgt_165	;
self.final_score_166	:= 	woFDN_FL_PSD_lgt_166	;
self.final_score_167	:= 	woFDN_FL_PSD_lgt_167	;
self.final_score_168	:= 	woFDN_FL_PSD_lgt_168	;
self.final_score_169	:= 	woFDN_FL_PSD_lgt_169	;
self.final_score_170	:= 	woFDN_FL_PSD_lgt_170	;
self.final_score_171	:= 	woFDN_FL_PSD_lgt_171	;
self.final_score_172	:= 	woFDN_FL_PSD_lgt_172	;
self.final_score_173	:= 	woFDN_FL_PSD_lgt_173	;
self.final_score_174	:= 	woFDN_FL_PSD_lgt_174	;
self.final_score_175	:= 	woFDN_FL_PSD_lgt_175	;
self.final_score_176	:= 	woFDN_FL_PSD_lgt_176	;
self.final_score_177	:= 	woFDN_FL_PSD_lgt_177	;
self.final_score_178	:= 	woFDN_FL_PSD_lgt_178	;
self.final_score_179	:= 	woFDN_FL_PSD_lgt_179	;
self.final_score_180	:= 	woFDN_FL_PSD_lgt_180	;
self.final_score_181	:= 	woFDN_FL_PSD_lgt_181	;
self.final_score_182	:= 	woFDN_FL_PSD_lgt_182	;
self.final_score_183	:= 	woFDN_FL_PSD_lgt_183	;
self.final_score_184	:= 	woFDN_FL_PSD_lgt_184	;
self.final_score_185	:= 	woFDN_FL_PSD_lgt_185	;
self.final_score_186	:= 	woFDN_FL_PSD_lgt_186	;
self.final_score_187	:= 	woFDN_FL_PSD_lgt_187	;
self.final_score_188	:= 	woFDN_FL_PSD_lgt_188	;
self.final_score_189	:= 	woFDN_FL_PSD_lgt_189	;
self.final_score_190	:= 	woFDN_FL_PSD_lgt_190	;
self.final_score_191	:= 	woFDN_FL_PSD_lgt_191	;
self.final_score_192	:= 	woFDN_FL_PSD_lgt_192	;
self.final_score_193	:= 	woFDN_FL_PSD_lgt_193	;
self.final_score_194	:= 	woFDN_FL_PSD_lgt_194	;
self.final_score_195	:= 	woFDN_FL_PSD_lgt_195	;
self.final_score_196	:= 	woFDN_FL_PSD_lgt_196	;
self.final_score_197	:= 	woFDN_FL_PSD_lgt_197	;
self.final_score_198	:= 	woFDN_FL_PSD_lgt_198	;
self.final_score_199	:= 	woFDN_FL_PSD_lgt_199	;
self.final_score_200	:= 	woFDN_FL_PSD_lgt_200	;
self.final_score_201	:= 	woFDN_FL_PSD_lgt_201	;
self.final_score_202	:= 	woFDN_FL_PSD_lgt_202	;
self.final_score_203	:= 	woFDN_FL_PSD_lgt_203	;
self.final_score_204	:= 	woFDN_FL_PSD_lgt_204	;
self.final_score_205	:= 	woFDN_FL_PSD_lgt_205	;
self.final_score_206	:= 	woFDN_FL_PSD_lgt_206	;
self.final_score_207	:= 	woFDN_FL_PSD_lgt_207	;
self.final_score_208	:= 	woFDN_FL_PSD_lgt_208	;
self.final_score_209	:= 	woFDN_FL_PSD_lgt_209	;
self.final_score_210	:= 	woFDN_FL_PSD_lgt_210	;
self.final_score_211	:= 	woFDN_FL_PSD_lgt_211	;
self.final_score_212	:= 	woFDN_FL_PSD_lgt_212	;
self.final_score_213	:= 	woFDN_FL_PSD_lgt_213	;
self.final_score_214	:= 	woFDN_FL_PSD_lgt_214	;
self.final_score_215	:= 	woFDN_FL_PSD_lgt_215	;
self.final_score_216	:= 	woFDN_FL_PSD_lgt_216	;
self.final_score_217	:= 	woFDN_FL_PSD_lgt_217	;
self.final_score_218	:= 	woFDN_FL_PSD_lgt_218	;
self.final_score_219	:= 	woFDN_FL_PSD_lgt_219	;
self.final_score_220	:= 	woFDN_FL_PSD_lgt_220	;
self.final_score_221	:= 	woFDN_FL_PSD_lgt_221	;
self.final_score_222	:= 	woFDN_FL_PSD_lgt_222	;
self.final_score_223	:= 	woFDN_FL_PSD_lgt_223	;
self.final_score_224	:= 	woFDN_FL_PSD_lgt_224	;
self.final_score_225	:= 	woFDN_FL_PSD_lgt_225	;
self.final_score_226	:= 	woFDN_FL_PSD_lgt_226	;
self.final_score_227	:= 	woFDN_FL_PSD_lgt_227	;
self.final_score_228	:= 	woFDN_FL_PSD_lgt_228	;
self.final_score_229	:= 	woFDN_FL_PSD_lgt_229	;
self.final_score_230	:= 	woFDN_FL_PSD_lgt_230	;
self.final_score_231	:= 	woFDN_FL_PSD_lgt_231	;
self.final_score_232	:= 	woFDN_FL_PSD_lgt_232	;
self.final_score_233	:= 	woFDN_FL_PSD_lgt_233	;
self.final_score_234	:= 	woFDN_FL_PSD_lgt_234	;
self.final_score_235	:= 	woFDN_FL_PSD_lgt_235	;
self.final_score_236	:= 	woFDN_FL_PSD_lgt_236	;
self.final_score_237	:= 	woFDN_FL_PSD_lgt_237	;
self.final_score_238	:= 	woFDN_FL_PSD_lgt_238	;
self.final_score_239	:= 	woFDN_FL_PSD_lgt_239	;
self.final_score_240	:= 	woFDN_FL_PSD_lgt_240	;
self.final_score_241	:= 	woFDN_FL_PSD_lgt_241	;
self.final_score_242	:= 	woFDN_FL_PSD_lgt_242	;
self.final_score_243	:= 	woFDN_FL_PSD_lgt_243	;
self.final_score_244	:= 	woFDN_FL_PSD_lgt_244	;
self.final_score_245	:= 	woFDN_FL_PSD_lgt_245	;
self.final_score_246	:= 	woFDN_FL_PSD_lgt_246	;
self.final_score_247	:= 	woFDN_FL_PSD_lgt_247	;
self.final_score_248	:= 	woFDN_FL_PSD_lgt_248	;
self.final_score_249	:= 	woFDN_FL_PSD_lgt_249	;
self.final_score_250	:= 	woFDN_FL_PSD_lgt_250	;
self.final_score_251	:= 	woFDN_FL_PSD_lgt_251	;
self.final_score_252	:= 	woFDN_FL_PSD_lgt_252	;
self.final_score_253	:= 	woFDN_FL_PSD_lgt_253	;
self.final_score_254	:= 	woFDN_FL_PSD_lgt_254	;
self.final_score_255	:= 	woFDN_FL_PSD_lgt_255	;
self.final_score_256	:= 	woFDN_FL_PSD_lgt_256	;
self.final_score_257	:= 	woFDN_FL_PSD_lgt_257	;
self.final_score_258	:= 	woFDN_FL_PSD_lgt_258	;
self.final_score_259	:= 	woFDN_FL_PSD_lgt_259	;
self.final_score_260	:= 	woFDN_FL_PSD_lgt_260	;
self.final_score_261	:= 	woFDN_FL_PSD_lgt_261	;
self.final_score_262	:= 	woFDN_FL_PSD_lgt_262	;
self.final_score_263	:= 	woFDN_FL_PSD_lgt_263	;
self.final_score_264	:= 	woFDN_FL_PSD_lgt_264	;
self.final_score_265	:= 	woFDN_FL_PSD_lgt_265	;
self.final_score_266	:= 	woFDN_FL_PSD_lgt_266	;
self.final_score_267	:= 	woFDN_FL_PSD_lgt_267	;
self.final_score_268	:= 	woFDN_FL_PSD_lgt_268	;
self.final_score_269	:= 	woFDN_FL_PSD_lgt_269	;
self.final_score_270	:= 	woFDN_FL_PSD_lgt_270	;
self.final_score_271	:= 	woFDN_FL_PSD_lgt_271	;
self.final_score_272	:= 	woFDN_FL_PSD_lgt_272	;
self.final_score_273	:= 	woFDN_FL_PSD_lgt_273	;
self.final_score_274	:= 	woFDN_FL_PSD_lgt_274	;
self.final_score_275	:= 	woFDN_FL_PSD_lgt_275	;
self.final_score_276	:= 	woFDN_FL_PSD_lgt_276	;
self.final_score_277	:= 	woFDN_FL_PSD_lgt_277	;
self.final_score_278	:= 	woFDN_FL_PSD_lgt_278	;
self.final_score_279	:= 	woFDN_FL_PSD_lgt_279	;
self.final_score_280	:= 	woFDN_FL_PSD_lgt_280	;
self.final_score_281	:= 	woFDN_FL_PSD_lgt_281	;
self.final_score_282	:= 	woFDN_FL_PSD_lgt_282	;
self.final_score_283	:= 	woFDN_FL_PSD_lgt_283	;
self.final_score_284	:= 	woFDN_FL_PSD_lgt_284	;
self.final_score_285	:= 	woFDN_FL_PSD_lgt_285	;
self.final_score_286	:= 	woFDN_FL_PSD_lgt_286	;
self.final_score_287	:= 	woFDN_FL_PSD_lgt_287	;
self.final_score_288	:= 	woFDN_FL_PSD_lgt_288	;
self.final_score_289	:= 	woFDN_FL_PSD_lgt_289	;
self.final_score_290	:= 	woFDN_FL_PSD_lgt_290	;
self.final_score_291	:= 	woFDN_FL_PSD_lgt_291	;
self.final_score_292	:= 	woFDN_FL_PSD_lgt_292	;
self.final_score_293	:= 	woFDN_FL_PSD_lgt_293	;
self.final_score_294	:= 	woFDN_FL_PSD_lgt_294	;
self.final_score_295	:= 	woFDN_FL_PSD_lgt_295	;
self.final_score_296	:= 	woFDN_FL_PSD_lgt_296	;
self.final_score_297	:= 	woFDN_FL_PSD_lgt_297	;
self.final_score_298	:= 	woFDN_FL_PSD_lgt_298	;
self.final_score_299	:= 	woFDN_FL_PSD_lgt_299	;
self.final_score_300	:= 	woFDN_FL_PSD_lgt_300	;
self.final_score_301	:= 	woFDN_FL_PSD_lgt_301	;
self.final_score_302	:= 	woFDN_FL_PSD_lgt_302	;
self.final_score_303	:= 	woFDN_FL_PSD_lgt_303	;
self.final_score_304	:= 	woFDN_FL_PSD_lgt_304	;
self.final_score_305	:= 	woFDN_FL_PSD_lgt_305	;
self.final_score_306	:= 	woFDN_FL_PSD_lgt_306	;
self.final_score_307	:= 	woFDN_FL_PSD_lgt_307	;
self.final_score_308	:= 	woFDN_FL_PSD_lgt_308	;
self.final_score_309	:= 	woFDN_FL_PSD_lgt_309	;
self.final_score_310	:= 	woFDN_FL_PSD_lgt_310	;
self.final_score_311	:= 	woFDN_FL_PSD_lgt_311	;
self.final_score_312	:= 	woFDN_FL_PSD_lgt_312	;
self.final_score_313	:= 	woFDN_FL_PSD_lgt_313	;
self.final_score_314	:= 	woFDN_FL_PSD_lgt_314	;
self.final_score_315	:= 	woFDN_FL_PSD_lgt_315	;
self.final_score_316	:= 	woFDN_FL_PSD_lgt_316	;
self.final_score_317	:= 	woFDN_FL_PSD_lgt_317	;
self.final_score_318	:= 	woFDN_FL_PSD_lgt_318	;
self.final_score_319	:= 	woFDN_FL_PSD_lgt_319	;
self.final_score_320	:= 	woFDN_FL_PSD_lgt_320	;
self.final_score_321	:= 	woFDN_FL_PSD_lgt_321	;
self.final_score_322	:= 	woFDN_FL_PSD_lgt_322	;
self.final_score_323	:= 	woFDN_FL_PSD_lgt_323	;
self.final_score_324	:= 	woFDN_FL_PSD_lgt_324	;
self.final_score_325	:= 	woFDN_FL_PSD_lgt_325	;
self.final_score_326	:= 	woFDN_FL_PSD_lgt_326	;
self.final_score_327	:= 	woFDN_FL_PSD_lgt_327	;
self.final_score_328	:= 	woFDN_FL_PSD_lgt_328	;
self.final_score_329	:= 	woFDN_FL_PSD_lgt_329	;
self.final_score_330	:= 	woFDN_FL_PSD_lgt_330	;
self.final_score_331	:= 	woFDN_FL_PSD_lgt_331	;
self.final_score_332	:= 	woFDN_FL_PSD_lgt_332	;
self.final_score_333	:= 	woFDN_FL_PSD_lgt_333	;
self.final_score_334	:= 	woFDN_FL_PSD_lgt_334	;
self.final_score_335	:= 	woFDN_FL_PSD_lgt_335	;
self.final_score_336	:= 	woFDN_FL_PSD_lgt_336	;
self.final_score_337	:= 	woFDN_FL_PSD_lgt_337	;
self.final_score_338	:= 	woFDN_FL_PSD_lgt_338	;
self.final_score_339	:= 	woFDN_FL_PSD_lgt_339	;
self.final_score_340	:= 	woFDN_FL_PSD_lgt_340	;
self.final_score_341	:= 	woFDN_FL_PSD_lgt_341	;
self.final_score_342	:= 	woFDN_FL_PSD_lgt_342	;
self.final_score_343	:= 	woFDN_FL_PSD_lgt_343	;
// self.woFDN_submodel_lgt	:= 	woFDN_FL_PSD_lgt	;
self.FP3_woFDN_LGT		:= 	woFDN_FL_PSD_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
