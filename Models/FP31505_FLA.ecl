
export FP31505_FLA( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   woFDN_FLA____lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FLA____lgt_1 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 50.45) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 35) => 0.4632690744,
      (r_F01_inp_addr_address_score_d > 35) => 0.0823342255,
      (r_F01_inp_addr_address_score_d = NULL) => 0.1318342341, 0.1318342341),
   (c_fammar_p > 50.45) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0354986324,
      (f_varrisktype_i > 3.5) => 0.1276228385,
      (f_varrisktype_i = NULL) => -0.0286838065, -0.0286838065),
   (c_fammar_p = NULL) => -0.0424770385, -0.0171474015),
(f_inq_HighRiskCredit_count_i > 1.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.1704663700,
   (f_inq_Communications_count_i > 0.5) => 0.5745962886,
   (f_inq_Communications_count_i = NULL) => 0.2992727185, 0.2992727185),
(f_inq_HighRiskCredit_count_i = NULL) => 0.2137423010, -0.0016766067);

// Tree: 2 
woFDN_FLA____lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 35) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0984588491,
      (f_rel_felony_count_i > 1.5) => 0.4778483111,
      (f_rel_felony_count_i = NULL) => 0.1329986411, 0.1329986411),
   (r_F01_inp_addr_address_score_d > 35) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0363143983,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1594523411,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0321089209, -0.0321089209),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0224024871, -0.0224024871),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0480224389,
   (f_rel_under500miles_cnt_d > 5.5) => 0.3257655997,
   (f_rel_under500miles_cnt_d = NULL) => 0.0943682239, 0.2027475474),
(f_varrisktype_i = NULL) => 0.1231609134, -0.0073652517);

// Tree: 3 
woFDN_FLA____lgt_3 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 50.5) => 0.0308324554,
      (c_low_ed > 50.5) => 0.2276230535,
      (c_low_ed = NULL) => 0.0068731181, 0.0957983794),
   (r_F01_inp_addr_address_score_d > 75) => -0.0285353851,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0205050648, -0.0205050648),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.1770093939,
      (f_assocrisktype_i > 5.5) => 0.3679836068,
      (f_assocrisktype_i = NULL) => 0.2561768858, 0.2561768858),
   (r_I60_inq_comm_recency_d > 549) => 0.0758135352,
   (r_I60_inq_comm_recency_d = NULL) => 0.1207817323, 0.1207817323),
(f_srchvelocityrisktype_i = NULL) => 0.0923682684, -0.0068138292);

// Tree: 4 
woFDN_FLA____lgt_4 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0330854585,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 21.95) => 0.0154442789,
         (c_famotf18_p > 21.95) => 0.1545375356,
         (c_famotf18_p = NULL) => -0.0165122867, 0.0400829169),
      (nf_seg_FraudPoint_3_0 = '') => -0.0173273343, -0.0173273343),
   (f_assocsuspicousidcount_i > 15.5) => 0.3754589162,
   (f_assocsuspicousidcount_i = NULL) => -0.0149223879, -0.0149223879),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.1026606930,
   (f_varrisktype_i > 2.5) => 0.2785754544,
   (f_varrisktype_i = NULL) => 0.1781122850, 0.1781122850),
(f_inq_Communications_count_i = NULL) => 0.1159683813, -0.0066741973);

// Tree: 5 
woFDN_FLA____lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
         map(
         (NULL < c_highinc and c_highinc <= 8.75) => 0.1456399754,
         (c_highinc > 8.75) => -0.0005299286,
         (c_highinc = NULL) => 0.0137464327, 0.0567462009),
      (r_F01_inp_addr_address_score_d > 95) => -0.0312589963,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0225060732, -0.0225060732),
   (k_inq_per_addr_i > 3.5) => 0.0907589642,
   (k_inq_per_addr_i = NULL) => -0.0110704365, -0.0110704365),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 0.5) => 0.0615380843,
   (f_rel_bankrupt_count_i > 0.5) => 0.2352304769,
   (f_rel_bankrupt_count_i = NULL) => 0.1460114337, 0.1460114337),
(f_varrisktype_i = NULL) => 0.0801080906, -0.0052730865);

// Tree: 6 
woFDN_FLA____lgt_6 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 10.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
         map(
         (NULL < c_unemp and c_unemp <= 8.65) => 0.0421333243,
         (c_unemp > 8.65) => 0.2277668888,
         (c_unemp = NULL) => -0.0140066083, 0.0586773116),
      (k_estimated_income_d > 27500) => -0.0294672565,
      (k_estimated_income_d = NULL) => -0.0210675537, -0.0210675537),
   (f_srchfraudsrchcount_i > 10.5) => 0.1464528399,
   (f_srchfraudsrchcount_i = NULL) => -0.0184393443, -0.0184393443),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.1078903854,
   (f_inq_Communications_count_i > 0.5) => 0.2362252774,
   (f_inq_Communications_count_i = NULL) => 0.1487581956, 0.1487581956),
(r_D33_eviction_count_i = NULL) => 0.0645793813, -0.0104274219);

// Tree: 7 
woFDN_FLA____lgt_7 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 30.35) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1509082551,
   (r_D33_Eviction_Recency_d > 79.5) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1225326971,
      (r_I60_inq_PrepaidCards_recency_d > 549) => -0.0223808300,
      (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0192170057, -0.0192170057),
   (r_D33_Eviction_Recency_d = NULL) => 0.0115914544, -0.0159240198),
(c_famotf18_p > 30.35) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 0.0509865455,
      (k_inq_ssns_per_addr_i > 1.5) => 0.2435372905,
      (k_inq_ssns_per_addr_i = NULL) => 0.0780897716, 0.0780897716),
   (f_rel_felony_count_i > 2.5) => 0.2866424865,
   (f_rel_felony_count_i = NULL) => 0.0903434449, 0.0903434449),
(c_famotf18_p = NULL) => -0.0240016349, -0.0086760130);

// Tree: 8 
woFDN_FLA____lgt_8 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0462163405,
      (f_rel_felony_count_i > 1.5) => 0.2030336817,
      (f_rel_felony_count_i = NULL) => 0.0591433833, 0.0591433833),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0306913144,
      (r_D33_eviction_count_i > 2.5) => 0.1698304976,
      (r_D33_eviction_count_i = NULL) => -0.0290441143, -0.0290441143),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0209650834, -0.0209650834),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0444631006,
   (f_rel_felony_count_i > 0.5) => 0.1803949428,
   (f_rel_felony_count_i = NULL) => 0.0718457605, 0.0718457605),
(f_varrisktype_i = NULL) => 0.0327767899, -0.0101156238);

// Tree: 9 
woFDN_FLA____lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.1269942573,
      (k_estimated_income_d > 26500) => 0.0387869141,
      (k_estimated_income_d = NULL) => 0.0554400651, 0.0554400651),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 3.5) => -0.0353516978,
      (f_assocsuspicousidcount_i > 3.5) => 0.0268857254,
      (f_assocsuspicousidcount_i = NULL) => -0.0222000806, -0.0222000806),
   (c_fammar_p = NULL) => -0.0389530174, -0.0111764997),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 76.65) => 0.1855232374,
   (c_fammar_p > 76.65) => 0.0414725329,
   (c_fammar_p = NULL) => 0.1305674773, 0.1305674773),
(f_inq_PrepaidCards_count_i = NULL) => 0.0756253180, -0.0060053344);

// Tree: 10 
woFDN_FLA____lgt_10 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2780168077,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0239510991,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0224349423, -0.0224349423),
      (r_D30_Derog_Count_i > 5.5) => 0.0917117156,
      (r_D30_Derog_Count_i = NULL) => -0.0174998586, -0.0174998586),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 61.5) => 0.2286880587,
      (r_I60_inq_comm_recency_d > 61.5) => 0.0469975530,
      (r_I60_inq_comm_recency_d = NULL) => 0.0641954294, 0.0641954294),
   (r_F01_inp_addr_not_verified_i = NULL) => -0.0114563321, -0.0114563321),
(f_srchfraudsrchcount_i > 8.5) => 0.1114086884,
(f_srchfraudsrchcount_i = NULL) => 0.0255586846, -0.0073852587);

// Tree: 11 
woFDN_FLA____lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3074533353,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0228954978,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0212292115, -0.0212292115),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => 0.0483515451,
      (r_D33_eviction_count_i > 1.5) => 0.1936322519,
      (r_D33_eviction_count_i = NULL) => 0.0574754542, 0.0574754542),
   (f_inq_Communications_count_i = NULL) => 0.0211827809, -0.0139472272),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 5.5) => 0.2402873479,
   (f_prevaddrlenofres_d > 5.5) => 0.0998458870,
   (f_prevaddrlenofres_d = NULL) => 0.1212121947, 0.1212121947),
(k_inq_ssns_per_addr_i = NULL) => -0.0076607425, -0.0076607425);

// Tree: 12 
woFDN_FLA____lgt_12 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1715643526,
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 61.05) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.2641946312,
         (r_C21_M_Bureau_ADL_FS_d > 7.5) => 0.0273999132,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0345368907, 0.0345368907),
      (c_fammar_p > 61.05) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 12.5) => -0.0242882328,
         (f_assocsuspicousidcount_i > 12.5) => 0.1531397685,
         (f_assocsuspicousidcount_i = NULL) => -0.0226505466, -0.0226505466),
      (c_fammar_p = NULL) => -0.0526447187, -0.0144620230),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0126182000, -0.0126182000),
(f_inq_HighRiskCredit_count_i > 2.5) => 0.0930485372,
(f_inq_HighRiskCredit_count_i = NULL) => 0.0398379775, -0.0085584859);

// Tree: 13 
woFDN_FLA____lgt_13 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 3.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0162757420,
      (r_D33_eviction_count_i > 2.5) => 0.1462888899,
      (r_D33_eviction_count_i = NULL) => -0.0151030989, -0.0151030989),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 2767) => 0.0100937659,
      (r_A50_pb_total_dollars_d > 2767) => 0.1478091695,
      (r_A50_pb_total_dollars_d = NULL) => 0.0734672259, 0.0734672259),
   (f_rel_felony_count_i = NULL) => -0.0110046359, -0.0110046359),
(f_srchfraudsrchcountyr_i > 3.5) => 0.0990952459,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 78.5) => 0.1487591100,
   (c_fammar_p > 78.5) => -0.0640796199,
   (c_fammar_p = NULL) => 0.0595546423, 0.0595546423), -0.0074055328);

// Tree: 14 
woFDN_FLA____lgt_14 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0993199618,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 145.5) => 0.0059572849,
         (c_span_lang > 145.5) => 0.1344017869,
         (c_span_lang = NULL) => 0.0519144920, 0.0519144920),
      (r_F01_inp_addr_address_score_d > 25) => -0.0244896993,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0204249650, -0.0204249650),
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 20.5) => 0.0295070191,
      (f_rel_ageover20_count_d > 20.5) => 0.1333499031,
      (f_rel_ageover20_count_d = NULL) => 0.0435682930, 0.0435682930),
   (f_srchvelocityrisktype_i = NULL) => -0.0129793576, -0.0129793576),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0163944937, -0.0093940161);

// Tree: 15 
woFDN_FLA____lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 60.85) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 74.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0323734571,
      (r_L79_adls_per_addr_c6_i > 4.5) => 0.1454843902,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0407219832, 0.0407219832),
   (k_comb_age_d > 74.5) => 0.3837113453,
   (k_comb_age_d = NULL) => 0.0492924320, 0.0492924320),
(c_fammar_p > 60.85) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0217796146,
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 3.5) => -0.0313676790,
      (f_rel_homeover100_count_d > 3.5) => 0.1180901596,
      (f_rel_homeover100_count_d = NULL) => 0.0652585515, 0.0652585515),
   (f_varrisktype_i = NULL) => 0.0449631205, -0.0191759315),
(c_fammar_p = NULL) => -0.0365412852, -0.0086249479);

// Tree: 16 
woFDN_FLA____lgt_16 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 191.5) => -0.0133644970,
      (c_unempl > 191.5) => 0.1787412283,
      (c_unempl = NULL) => -0.0269063364, -0.0123192774),
   (f_phones_per_addr_curr_i > 8.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0285499342,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1185516895,
      (nf_seg_FraudPoint_3_0 = '') => 0.0511179419, 0.0511179419),
   (f_phones_per_addr_curr_i = NULL) => -0.0053806687, -0.0053806687),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 0.0001560696,
   (f_inq_count_i > 3.5) => 0.1182192348,
   (f_inq_count_i = NULL) => 0.0764693619, 0.0764693619),
(f_inq_PrepaidCards_count_i = NULL) => 0.0194745538, -0.0028390880);

// Tree: 17 
woFDN_FLA____lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 22500) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 78.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 42.5) => 0.2842046399,
         (c_born_usa > 42.5) => 0.0760288235,
         (c_born_usa = NULL) => 0.1419727156, 0.1419727156),
      (c_rest_indx > 78.5) => 0.0245244143,
      (c_rest_indx = NULL) => -0.0184102142, 0.0499848354),
   (k_estimated_income_d > 22500) => -0.0242579870,
   (k_estimated_income_d = NULL) => -0.0099636136, -0.0197494763),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0364519478,
   (f_hh_payday_loan_users_i > 0.5) => 0.1187796219,
   (f_hh_payday_loan_users_i = NULL) => 0.0488574878, 0.0488574878),
(k_inq_per_addr_i = NULL) => -0.0121883777, -0.0121883777);

// Tree: 18 
woFDN_FLA____lgt_18 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 9.5) => -0.0154863647,
      (f_srchaddrsrchcount_i > 9.5) => 0.0568133240,
      (f_srchaddrsrchcount_i = NULL) => -0.0114113248, -0.0114113248),
   (r_D33_eviction_count_i > 2.5) => 0.0997979507,
   (r_D33_eviction_count_i = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 85.5) => 0.1026952498,
      (c_many_cars > 85.5) => -0.0674071245,
      (c_many_cars = NULL) => 0.0149004759, 0.0149004759), -0.0098981072),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 6058) => 0.0121328798,
   (r_A50_pb_total_dollars_d > 6058) => 0.1224799575,
   (r_A50_pb_total_dollars_d = NULL) => 0.0677478069, 0.0677478069),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0059867364, -0.0059867364);

// Tree: 19 
woFDN_FLA____lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 2.5) => -0.0074983462,
   (k_inq_per_addr_i > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 62.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1827554517,
         (r_C10_M_Hdr_FS_d > 7.5) => 0.0226773553,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0278746961, 0.0278746961),
      (k_comb_age_d > 62.5) => 
         map(
         (NULL < c_finance and c_finance <= 0.45) => 0.3241649931,
         (c_finance > 0.45) => 0.0880356399,
         (c_finance = NULL) => 0.1653398924, 0.1653398924),
      (k_comb_age_d = NULL) => 0.0395173650, 0.0395173650),
   (k_inq_per_addr_i = NULL) => 0.0001163434, 0.0001163434),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1788689653,
(f_inq_PrepaidCards_count_i = NULL) => 0.0049395476, 0.0009263191);

// Tree: 20 
woFDN_FLA____lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0159287714,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -3.5) => 0.1978988023,
      (f_addrchangecrimediff_i > -3.5) => 0.0196041786,
      (f_addrchangecrimediff_i = NULL) => 0.1124681516, 0.0475738386),
   (k_inq_per_addr_i = NULL) => -0.0098887949, -0.0098887949),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 6.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 37) => 0.1536806073,
      (c_fammar_p > 37) => 0.0366366993,
      (c_fammar_p = NULL) => 0.0427251634, 0.0427251634),
   (r_L79_adls_per_addr_c6_i > 6.5) => 0.1782386813,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0504104240, 0.0504104240),
(f_varrisktype_i = NULL) => 0.0130052428, -0.0029439905);

// Tree: 21 
woFDN_FLA____lgt_21 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0211875595,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 7.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 48.5) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 12.95) => 0.0427322071,
         (c_vacant_p > 12.95) => 0.1656014318,
         (c_vacant_p = NULL) => 0.0818269604, 0.0818269604),
      (c_ab_av_edu > 48.5) => 0.0084447138,
      (c_ab_av_edu = NULL) => -0.0235326960, 0.0148030251),
   (f_assocsuspicousidcount_i > 7.5) => 0.0955888991,
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 7.05) => -0.0483902193,
      (c_pop_12_17_p > 7.05) => 0.0800138339,
      (c_pop_12_17_p = NULL) => 0.0217251518, 0.0217251518), 0.0224292013),
(nf_seg_FraudPoint_3_0 = '') => -0.0108515735, -0.0108515735);

// Tree: 22 
woFDN_FLA____lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 47) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 0.0680251539,
      (r_Prop_Owner_History_d > 1.5) => -0.0001676851,
      (r_Prop_Owner_History_d = NULL) => 0.0261107453, 0.0261107453),
   (c_rich_wht > 47) => -0.0184993138,
   (c_rich_wht = NULL) => -0.0327096139, -0.0106093666),
(f_assocrisktype_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 0.1895015786,
   (r_C12_source_profile_index_d > 1.5) => 0.0605455239,
   (r_C12_source_profile_index_d = NULL) => 0.0741972235, 0.0741972235),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 120.5) => -0.0586971337,
   (c_cartheft > 120.5) => 0.0876075862,
   (c_cartheft = NULL) => 0.0078050117, 0.0078050117), -0.0062460236);

// Tree: 23 
woFDN_FLA____lgt_23 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 24.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.0956380059,
      (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0186363072,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0162659885, -0.0162659885),
   (f_inq_Communications_count24_i > 1.5) => 0.0723539041,
   (f_inq_Communications_count24_i = NULL) => -0.0144280305, -0.0144280305),
(f_addrchangecrimediff_i > 24.5) => 0.0854011465,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 52.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => 0.0400189149,
      (f_crim_rel_under25miles_cnt_i > 4.5) => 0.2129998140,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.1378459258, 0.0593166255),
   (c_born_usa > 52.5) => -0.0077060401,
   (c_born_usa = NULL) => -0.0272666653, 0.0102954395), -0.0057687820);

// Tree: 24 
woFDN_FLA____lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => -0.0142441430,
   (c_unemp > 8.95) => 
      map(
      (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.1145008275,
      (f_curraddractivephonelist_d > 0.5) => 0.0033241000,
      (f_curraddractivephonelist_d = NULL) => 0.0657470987, 0.0657470987),
   (c_unemp = NULL) => -0.0273726652, -0.0109577822),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 59.5) => 0.0291972569,
   (k_comb_age_d > 59.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 80) => 0.2574679431,
      (c_lux_prod > 80) => 0.0749115241,
      (c_lux_prod = NULL) => 0.1438489131, 0.1438489131),
   (k_comb_age_d = NULL) => 0.0414843893, 0.0414843893),
(k_inq_per_addr_i = NULL) => -0.0053104817, -0.0053104817);

// Tree: 25 
woFDN_FLA____lgt_25 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 0.0016198176,
      (r_L79_adls_per_addr_c6_i > 3.5) => 0.0865629308,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0093055136, 0.0093055136),
   (f_historical_count_d > 0.5) => -0.0373368855,
   (f_historical_count_d = NULL) => -0.0132874436, -0.0132874436),
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 0.0336189837,
   (f_srchfraudsrchcountmo_i > 0.5) => 0.1756233419,
   (f_srchfraudsrchcountmo_i = NULL) => 0.0413306850, 0.0413306850),
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 97.5) => -0.0526043157,
   (c_burglary > 97.5) => 0.0919240363,
   (c_burglary = NULL) => 0.0180539897, 0.0180539897), -0.0050279618);

// Tree: 26 
woFDN_FLA____lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 10.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62485) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 137.5) => 0.0386884755,
      (c_lar_fam > 137.5) => 0.2253546149,
      (c_lar_fam = NULL) => 0.0750782644, 0.0750782644),
   (f_addrchangevaluediff_d > -62485) => -0.0083655818,
   (f_addrchangevaluediff_d = NULL) => 0.0127288086, -0.0018319134),
(r_D30_Derog_Count_i > 10.5) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 1.5) => 0.0262543289,
   (f_assoccredbureaucount_i > 1.5) => 0.1549797180,
   (f_assoccredbureaucount_i = NULL) => 0.0909136257, 0.0909136257),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 63.5) => -0.0589002990,
   (c_burglary > 63.5) => 0.0758526283,
   (c_burglary = NULL) => 0.0219514574, 0.0219514574), 0.0000696545);

// Tree: 27 
woFDN_FLA____lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1340555692) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 21.5) => 0.0263123614,
      (f_rel_under100miles_cnt_d > 21.5) => 0.1841405565,
      (f_rel_under100miles_cnt_d = NULL) => 0.0359225091, 0.0359225091),
   (f_add_curr_nhood_VAC_pct_i > 0.1340555692) => 0.1354828538,
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0500899656, 0.0500899656),
(c_fammar_p > 50.45) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.0936244872,
   (r_D33_Eviction_Recency_d > 48) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1418281081,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0116264920,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0109086403, -0.0109086403),
   (r_D33_Eviction_Recency_d = NULL) => -0.0054849655, -0.0097103173),
(c_fammar_p = NULL) => -0.0083445603, -0.0047537775);

// Tree: 28 
woFDN_FLA____lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 30.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 5.5) => -0.0120196469,
      (f_inq_HighRiskCredit_count_i > 5.5) => 0.1329424613,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0088438677, -0.0088438677),
   (r_pb_order_freq_d > 30.5) => -0.0318241312,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.1543800668,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => 
         map(
         (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 0.0098819683,
         (r_D32_criminal_count_i > 2.5) => 0.1096912849,
         (r_D32_criminal_count_i = NULL) => 0.0157621055, 0.0157621055),
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0178256738, 0.0178256738), -0.0076949321),
(r_D33_eviction_count_i > 2.5) => 0.0939309083,
(r_D33_eviction_count_i = NULL) => 0.0103628114, -0.0063208242);

// Tree: 29 
woFDN_FLA____lgt_29 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 192.5) => 0.0035722552,
      (c_serv_empl > 192.5) => 0.1303831535,
      (c_serv_empl = NULL) => -0.0214044580, 0.0066198013),
   (f_hh_lienholders_i > 0.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.12223169115) => 0.0676134037,
      (f_add_curr_nhood_BUS_pct_i > 0.12223169115) => 0.2220726292,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0870178290, 0.0870178290),
   (f_hh_lienholders_i = NULL) => 0.0300023493, 0.0300023493),
(f_corraddrnamecount_d > 3.5) => -0.0119932676,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 78.5) => 0.0432300735,
   (c_fammar_p > 78.5) => -0.0816769161,
   (c_fammar_p = NULL) => -0.0108077021, -0.0108077021), -0.0046808896);

// Tree: 30 
woFDN_FLA____lgt_30 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 79.5) => 0.1849882143,
(r_D32_Mos_Since_Fel_LS_d > 79.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 7863.5) => -0.0143681527,
   (f_addrchangeincomediff_d > 7863.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 85.5) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => 0.0546228691,
         (f_srchfraudsrchcount_i > 0.5) => 0.2412026752,
         (f_srchfraudsrchcount_i = NULL) => 0.1395406014, 0.1395406014),
      (c_work_home > 85.5) => -0.0003836953,
      (c_work_home = NULL) => 0.0475903493, 0.0475903493),
   (f_addrchangeincomediff_d = NULL) => 0.0064974518, -0.0074340309),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_med_yearblt and c_med_yearblt <= 1966.5) => 0.0805691610,
   (c_med_yearblt > 1966.5) => -0.0379117794,
   (c_med_yearblt = NULL) => 0.0069188467, 0.0069188467), -0.0064331811);

// Tree: 31 
woFDN_FLA____lgt_31 := map(
(NULL < c_unemp and c_unemp <= 8.35) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0104429900,
      (f_assocsuspicousidcount_i > 15.5) => 0.1212235206,
      (f_assocsuspicousidcount_i = NULL) => -0.0096657234, -0.0096657234),
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 7.5) => 0.0570131765,
      (f_srchaddrsrchcount_i > 7.5) => 0.2294909747,
      (f_srchaddrsrchcount_i = NULL) => 0.0688045541, 0.0688045541),
   (k_comb_age_d = NULL) => 0.0126281744, -0.0043455784),
(c_unemp > 8.35) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0219413294,
   (f_rel_criminal_count_i > 2.5) => 0.0930262766,
   (f_rel_criminal_count_i = NULL) => 0.0450460453, 0.0450460453),
(c_unemp = NULL) => -0.0328087002, -0.0016615005);

// Tree: 32 
woFDN_FLA____lgt_32 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 15.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0097187513,
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 8.5) => 0.0301902674,
      (f_assocsuspicousidcount_i > 8.5) => 0.1643856251,
      (f_assocsuspicousidcount_i = NULL) => 0.0395558457, 0.0395558457),
   (f_phones_per_addr_curr_i = NULL) => -0.0056497227, -0.0056497227),
(f_srchaddrsrchcount_i > 15.5) => 
   map(
   (NULL < c_employees and c_employees <= 23.5) => 0.1902066396,
   (c_employees > 23.5) => 0.0493950112,
   (c_employees = NULL) => 0.0710280826, 0.0710280826),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.270139601) => -0.0861100458,
   (f_add_input_nhood_SFD_pct_d > 0.270139601) => 0.0560942149,
   (f_add_input_nhood_SFD_pct_d = NULL) => 0.0134329367, 0.0134329367), -0.0032088705);

// Tree: 33 
woFDN_FLA____lgt_33 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 24.45) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 139.5) => -0.0263843146,
      (c_easiqlife > 139.5) => 0.0165860514,
      (c_easiqlife = NULL) => -0.0124415583, -0.0124415583),
   (f_hh_tot_derog_i > 4.5) => 0.0669578512,
   (f_hh_tot_derog_i = NULL) => -0.0324158299, -0.0091484783),
(c_famotf18_p > 24.45) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 73) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 5.5) => 0.1966107348,
      (f_prevaddrlenofres_d > 5.5) => 0.0436168960,
      (f_prevaddrlenofres_d = NULL) => 0.0643201907, 0.0643201907),
   (f_mos_inq_banko_cm_fseen_d > 73) => 0.0093029797,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0255107527, 0.0255107527),
(c_famotf18_p = NULL) => -0.0306395551, -0.0054886129);

// Tree: 34 
woFDN_FLA____lgt_34 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 43.5) => -0.0023595889,
(r_pb_order_freq_d > 43.5) => -0.0252276178,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 121.5) => -0.0107674306,
      (f_prevaddrageoldest_d > 121.5) => 0.0611596499,
      (f_prevaddrageoldest_d = NULL) => -0.0188154974, 0.0064342589),
   (r_L79_adls_per_addr_c6_i > 2.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 7.5) => 0.0274768846,
         (r_L79_adls_per_addr_curr_i > 7.5) => 0.1492094997,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0450980111, 0.0450980111),
      (k_inq_ssns_per_addr_i > 2.5) => 0.1390950468,
      (k_inq_ssns_per_addr_i = NULL) => 0.0568955982, 0.0568955982),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0166263679, 0.0166263679), -0.0030891206);

// Tree: 35 
woFDN_FLA____lgt_35 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0103994313,
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 7.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -14958) => 0.1112449268,
         (f_addrchangevaluediff_d > -14958) => 0.0234256059,
         (f_addrchangevaluediff_d = NULL) => -0.0159383821, 0.0180601477),
      (k_comb_age_d > 66.5) => 0.2045700956,
      (k_comb_age_d = NULL) => 0.0261692759, 0.0261692759),
   (f_rel_homeover500_count_d > 7.5) => 0.1781702439,
   (f_rel_homeover500_count_d = NULL) => 0.0324120039, 0.0324120039),
(f_srchvelocityrisktype_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 24.95) => 0.1223549587,
   (C_RENTOCC_P > 24.95) => -0.0318252708,
   (C_RENTOCC_P = NULL) => 0.0334048263, 0.0334048263), -0.0043188774);

// Tree: 36 
woFDN_FLA____lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0200087089,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
         map(
         (NULL < f_liens_unrel_ST_ct_i and f_liens_unrel_ST_ct_i <= 1.5) => 0.0075144091,
         (f_liens_unrel_ST_ct_i > 1.5) => 0.1620926655,
         (f_liens_unrel_ST_ct_i = NULL) => 0.0103622339, 0.0103622339),
      (f_inq_PrepaidCards_count24_i > 0.5) => 0.1249542364,
      (f_inq_PrepaidCards_count24_i = NULL) => 0.0122553072, 0.0122553072),
   (k_inq_per_addr_i > 6.5) => 0.0862242073,
   (k_inq_per_addr_i = NULL) => 0.0161749310, 0.0161749310),
(f_hh_criminals_i = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 117.5) => -0.0566893229,
   (c_cartheft > 117.5) => 0.0886346354,
   (c_cartheft = NULL) => 0.0043888625, 0.0043888625), -0.0083927710);

// Tree: 37 
woFDN_FLA____lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.65) => -0.0140424270,
   (c_unemp > 8.65) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 142.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 14.1) => 0.1183001559,
         (c_fammar18_p > 14.1) => -0.0187039035,
         (c_fammar18_p = NULL) => 0.0127912826, 0.0127912826),
      (c_no_labfor > 142.5) => 0.2148933207,
      (c_no_labfor = NULL) => 0.0482309764, 0.0482309764),
   (c_unemp = NULL) => -0.0041844638, -0.0107555260),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 5.5) => 0.0211542311,
   (f_util_adl_count_n > 5.5) => 0.0808014504,
   (f_util_adl_count_n = NULL) => 0.0269549851, 0.0269549851),
(f_hh_lienholders_i = NULL) => 0.0089964349, 0.0009786933);

// Tree: 38 
woFDN_FLA____lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0346169700,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.1739760762,
      (nf_seg_FraudPoint_3_0 = '') => 0.0834280275, 0.0834280275),
   (r_D32_Mos_Since_Crim_LS_d > 9.5) => 
      map(
      (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0156202774,
      (f_inq_Other_count_i > 0.5) => 0.0216840322,
      (f_inq_Other_count_i = NULL) => -0.0071731571, -0.0071731571),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0057397783, -0.0057397783),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1393308986,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 51) => 0.0943850861,
   (c_born_usa > 51) => -0.0301628975,
   (c_born_usa = NULL) => 0.0165425963, 0.0165425963), -0.0047497041);

// Tree: 39 
woFDN_FLA____lgt_39 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0145765900,
(f_crim_rel_under25miles_cnt_i > 0.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00992720485) => -0.0231929380,
      (f_add_curr_nhood_BUS_pct_i > 0.00992720485) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 31500) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 0.1982462864,
            (f_prevaddrlenofres_d > 2.5) => 0.0722668316,
            (f_prevaddrlenofres_d = NULL) => 0.0894458482, 0.0894458482),
         (k_estimated_income_d > 31500) => 0.0345150897,
         (k_estimated_income_d = NULL) => 0.0471759245, 0.0471759245),
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0139089835, 0.0317468630),
   (f_corraddrnamecount_d > 6.5) => -0.0063325186,
   (f_corraddrnamecount_d = NULL) => 0.0115517100, 0.0115517100),
(f_crim_rel_under25miles_cnt_i = NULL) => 0.0160979349, -0.0028184956);

// Tree: 40 
woFDN_FLA____lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98) => -0.0034679842,
(f_addrchangecrimediff_i > 98) => 0.1174142741,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 1.5) => -0.0127966415,
      (k_inq_adls_per_addr_i > 1.5) => 0.0643336862,
      (k_inq_adls_per_addr_i = NULL) => -0.0032057531, -0.0032057531),
   (r_L79_adls_per_addr_c6_i > 3.5) => 
      map(
      (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 86.5) => 0.0045283615,
         (c_mort_indx > 86.5) => 0.1999751844,
         (c_mort_indx = NULL) => 0.1022517729, 0.1022517729),
      (f_curraddractivephonelist_d > 0.5) => -0.0437818881,
      (f_curraddractivephonelist_d = NULL) => 0.1295202039, 0.0701160804),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0040697063, 0.0040697063), -0.0008818251);

// Tree: 41 
woFDN_FLA____lgt_41 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 
   map(
   (NULL < c_construction and c_construction <= 5) => 0.1892476485,
   (c_construction > 5) => -0.0040096387,
   (c_construction = NULL) => 0.0902999175, 0.0902999175),
(r_I60_inq_comm_recency_d > 4.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1134949604,
   (f_attr_arrest_recency_d > 48) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0922855625,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0085896371,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0081647618, -0.0081647618),
   (f_attr_arrest_recency_d = NULL) => -0.0075958918, -0.0075958918),
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 1) => -0.0488941712,
   (c_hh6_p > 1) => 0.0601627499,
   (c_hh6_p = NULL) => 0.0094386005, 0.0094386005), -0.0064025972);

// Tree: 42 
woFDN_FLA____lgt_42 := map(
(NULL < c_business and c_business <= 5.5) => 
   map(
   (NULL < c_trailer and c_trailer <= 131.5) => 0.0530917526,
   (c_trailer > 131.5) => -0.0292529433,
   (c_trailer = NULL) => 0.0301173914, 0.0301173914),
(c_business > 5.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 75.5) => -0.0234042887,
   (f_prevaddrageoldest_d > 75.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.0875166787,
      (r_F01_inp_addr_address_score_d > 25) => 
         map(
         (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 51.5) => 0.0023235847,
         (f_bus_addr_match_count_d > 51.5) => 0.3336744321,
         (f_bus_addr_match_count_d = NULL) => 0.0059065307, 0.0059065307),
      (r_F01_inp_addr_address_score_d = NULL) => 0.0091926180, 0.0091926180),
   (f_prevaddrageoldest_d = NULL) => -0.0032742379, -0.0084624788),
(c_business = NULL) => -0.0381179846, -0.0038714019);

// Tree: 43 
woFDN_FLA____lgt_43 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -108.5) => 0.1467300812,
(f_addrchangecrimediff_i > -108.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 82.5) => -0.0033390289,
   (k_comb_age_d > 82.5) => 0.1742416586,
   (k_comb_age_d = NULL) => -0.0017808212, -0.0017808212),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => -0.0042361924,
   (f_srchunvrfddobcount_i > 0.5) => 0.1179791992,
   (f_srchunvrfddobcount_i = NULL) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3854396998) => 
         map(
         (NULL < c_med_age and c_med_age <= 37.85) => 0.0993967739,
         (c_med_age > 37.85) => -0.0320137930,
         (c_med_age = NULL) => 0.0311643642, 0.0311643642),
      (f_add_input_mobility_index_i > 0.3854396998) => -0.0913382087,
      (f_add_input_mobility_index_i = NULL) => -0.0068799131, -0.0068799131), -0.0003376559), -0.0006863690);

// Tree: 44 
woFDN_FLA____lgt_44 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0153971707,
   (c_easiqlife > 132.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 7.5) => 0.0105659373,
      (f_crim_rel_under500miles_cnt_i > 7.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 44.5) => 
            map(
            (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 2740.5) => 0.0408629613,
            (r_A50_pb_average_dollars_d > 2740.5) => 0.2461869792,
            (r_A50_pb_average_dollars_d = NULL) => 0.1335899371, 0.1335899371),
         (c_born_usa > 44.5) => -0.0211116280,
         (c_born_usa = NULL) => 0.0559285088, 0.0559285088),
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0942339646, 0.0148704239),
   (c_easiqlife = NULL) => 0.0022711057, -0.0044440667),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1158793863,
(f_inq_PrepaidCards_count_i = NULL) => 0.0001613611, -0.0038683145);

// Tree: 45 
woFDN_FLA____lgt_45 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 2.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 0.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 6.85) => 0.0157034924,
      (c_pop_0_5_p > 6.85) => 0.2441998629,
      (c_pop_0_5_p = NULL) => 0.1426459204, 0.1426459204),
   (f_rel_under25miles_cnt_d > 0.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 184.5) => 0.0240583455,
      (c_sub_bus > 184.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 55.4) => 0.0363430531,
         (r_C12_source_profile_d > 55.4) => 0.2656042515,
         (r_C12_source_profile_d = NULL) => 0.1186833427, 0.1186833427),
      (c_sub_bus = NULL) => -0.0316246922, 0.0277080935),
   (f_rel_under25miles_cnt_d = NULL) => 0.0379998043, 0.0379998043),
(f_corraddrnamecount_d > 2.5) => -0.0041252376,
(f_corraddrnamecount_d = NULL) => -0.0153040078, 0.0004667206);

// Tree: 46 
woFDN_FLA____lgt_46 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.85) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => -0.0145707133,
      (r_C14_Addr_Stability_v2_d > 4.5) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 353909.5) => 0.0285256927,
         (c_med_hval > 353909.5) => 0.2377624091,
         (c_med_hval = NULL) => 0.0884632937, 0.0884632937),
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0385367480, 0.0385367480),
   (c_unemp > 8.85) => 0.1602310070,
   (c_unemp = NULL) => 0.0011963341, 0.0399005054),
(f_corraddrnamecount_d > 1.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 224) => 0.1006776916,
   (r_D32_Mos_Since_Fel_LS_d > 224) => -0.0046592415,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0036003953, -0.0036003953),
(f_corraddrnamecount_d = NULL) => -0.0214338959, -0.0005731716);

// Tree: 47 
woFDN_FLA____lgt_47 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => -0.0099621288,
      (f_addrchangecrimediff_i > 98.5) => 0.1100027370,
      (f_addrchangecrimediff_i = NULL) => -0.0031629177, -0.0076483325),
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 23.4) => 0.0480434095,
      (c_hval_500k_p > 23.4) => 0.2952595308,
      (c_hval_500k_p = NULL) => 0.0703122246, 0.0703122246),
   (k_comb_age_d = NULL) => -0.0025612785, -0.0025612785),
(f_srchfraudsrchcountmo_i > 0.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 15.45) => 0.0449189287,
   (C_INC_125K_P > 15.45) => 0.2479982184,
   (C_INC_125K_P = NULL) => 0.0682982600, 0.0682982600),
(f_srchfraudsrchcountmo_i = NULL) => -0.0046140606, -0.0000914838);

// Tree: 48 
woFDN_FLA____lgt_48 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 124975.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.2032313528,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 39055) => 0.0226320541,
      (f_addrchangevaluediff_d > 39055) => 0.1669146691,
      (f_addrchangevaluediff_d = NULL) => 0.0028399789, 0.0232353926),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0280643216, 0.0280643216),
(r_A46_Curr_AVM_AutoVal_d > 124975.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1410728332,
   (r_C10_M_Hdr_FS_d > 7.5) => -0.0067502076,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0052497481, -0.0052497481),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 73.5) => 0.0224314922,
   (f_mos_inq_banko_cm_fseen_d > 73.5) => -0.0270854104,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0025615665, -0.0153025734), -0.0045874376);

// Tree: 49 
woFDN_FLA____lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => -0.0000863484,
      (f_hh_criminals_i > 3.5) => 0.1370311625,
      (f_hh_criminals_i = NULL) => 0.0013476669, 0.0013476669),
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 6.85) => 0.1149774988,
      (c_rnt500_p > 6.85) => 0.0159626113,
      (c_rnt500_p = NULL) => 0.0688713298, 0.0688713298),
   (f_varrisktype_i = NULL) => 0.0028520597, 0.0028520597),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0691263595,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 8.95) => -0.0323621657,
   (C_INC_125K_P > 8.95) => 0.0819114309,
   (C_INC_125K_P = NULL) => 0.0208492037, 0.0208492037), 0.0002717068);

// Tree: 50 
woFDN_FLA____lgt_50 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 153.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0168856869,
   (f_nae_nothing_found_i > 0.5) => 0.2334064473,
   (f_nae_nothing_found_i = NULL) => -0.0144965986, -0.0144965986),
(r_A50_pb_average_dollars_d > 153.5) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 0.0168261839,
   (f_hh_members_w_derog_i > 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 84.5) => 0.2626768414,
      (c_easiqlife > 84.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 3.05) => -0.0056642228,
         (c_hh7p_p > 3.05) => 0.1961194917,
         (c_hh7p_p = NULL) => 0.0544174450, 0.0544174450),
      (c_easiqlife = NULL) => 0.1015021781, 0.1015021781),
   (f_hh_members_w_derog_i = NULL) => 0.0205227952, 0.0205227952),
(r_A50_pb_average_dollars_d = NULL) => -0.0020940463, 0.0005382497);

// Tree: 51 
woFDN_FLA____lgt_51 := map(
(NULL < c_employees and c_employees <= 71.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 149.5) => 0.0135223256,
   (f_curraddrmurderindex_i > 149.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 0.0254734492,
      (f_corrrisktype_i > 8.5) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.6) => 0.0555097575,
         (c_pop_6_11_p > 7.6) => 0.2074044024,
         (c_pop_6_11_p = NULL) => 0.1358218686, 0.1358218686),
      (f_corrrisktype_i = NULL) => 0.0641064974, 0.0641064974),
   (f_curraddrmurderindex_i = NULL) => 0.0231252031, 0.0231252031),
(c_employees > 71.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.0957499254,
   (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0101307415,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0282175464, -0.0097791598),
(c_employees = NULL) => -0.0074562351, -0.0028591134);

// Tree: 52 
woFDN_FLA____lgt_52 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0082108971,
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.65) => 0.0153922620,
      (c_pop_6_11_p > 10.65) => 
         map(
         (NULL < c_preschl and c_preschl <= 126) => 0.2109982374,
         (c_preschl > 126) => 0.0555091071,
         (c_preschl = NULL) => 0.1141842506, 0.1141842506),
      (c_pop_6_11_p = NULL) => 0.0296721949, 0.0296721949),
   (f_phones_per_addr_curr_i = NULL) => -0.0046753538, -0.0046753538),
(k_comb_age_d > 70.5) => 
   map(
   (NULL < c_murders and c_murders <= 124.5) => 0.0421878496,
   (c_murders > 124.5) => 0.1688254138,
   (c_murders = NULL) => 0.0731531899, 0.0731531899),
(k_comb_age_d = NULL) => 0.0062609360, -0.0008167245);

// Tree: 53 
woFDN_FLA____lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 129.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0152805247,
   (r_D32_felony_count_i > 0.5) => 0.0936462719,
   (r_D32_felony_count_i = NULL) => 0.0230855493, -0.0134978902),
(c_easiqlife > 129.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 37.35) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 118.5) => 0.0112586217,
      (c_sub_bus > 118.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -14111) => 0.1417757538,
         (f_addrchangeincomediff_d > -14111) => 0.0456355280,
         (f_addrchangeincomediff_d = NULL) => 0.0917946246, 0.0601283405),
      (c_sub_bus = NULL) => 0.0311576689, 0.0311576689),
   (c_high_ed > 37.35) => -0.0129873096,
   (c_high_ed = NULL) => 0.0152827810, 0.0152827810),
(c_easiqlife = NULL) => -0.0121510309, -0.0028179581);

// Tree: 54 
woFDN_FLA____lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1421802230,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0107843200,
   (c_housingcpi > 222.35) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 336.5) => 0.0146242539,
      (r_C13_max_lres_d > 336.5) => 
         map(
         (NULL < c_totcrime and c_totcrime <= 102) => 0.0694168206,
         (c_totcrime > 102) => 0.2536050979,
         (c_totcrime = NULL) => 0.1114009132, 0.1114009132),
      (r_C13_max_lres_d = NULL) => 0.0235686139, 0.0235686139),
   (c_housingcpi = NULL) => -0.0021827137, -0.0024953439),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.6) => -0.0430004927,
   (c_pop_35_44_p > 14.6) => 0.0650107811,
   (c_pop_35_44_p = NULL) => 0.0105928874, 0.0105928874), -0.0017465266);

// Tree: 55 
woFDN_FLA____lgt_55 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 118.5) => 0.0004525848,
      (f_prevaddrageoldest_d > 118.5) => 0.0770976338,
      (f_prevaddrageoldest_d = NULL) => 0.0128421528, 0.0128421528),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.45) => 0.1163603269,
      (c_pop_55_64_p > 11.45) => -0.0257178694,
      (c_pop_55_64_p = NULL) => 0.0705536953, 0.0705536953),
   (f_rel_felony_count_i = NULL) => 0.0158332998, 0.0158332998),
(f_corraddrnamecount_d > 4.5) => -0.0148224596,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0339725057,
   (c_construction > 7.45) => -0.0881555429,
   (c_construction = NULL) => -0.0098683323, -0.0098683323), -0.0060296053);

// Tree: 56 
woFDN_FLA____lgt_56 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < c_health and c_health <= 2.35) => 0.0684599524,
      (c_health > 2.35) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 6.75) => 0.2144625158,
         (c_hh1_p > 6.75) => 0.0116808925,
         (c_hh1_p = NULL) => 0.0196916305, 0.0196916305),
      (c_health = NULL) => 0.0263901728, 0.0329557711),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0798583911,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0230832464, 0.0230832464),
(f_corraddrnamecount_d > 3.5) => -0.0062193576,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 18.75) => -0.0214418859,
   (c_rnt1000_p > 18.75) => 0.0830885941,
   (c_rnt1000_p = NULL) => 0.0194271740, 0.0194271740), -0.0008276857);

// Tree: 57 
woFDN_FLA____lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 178.5) => -0.0084308666,
      (c_lar_fam > 178.5) => 0.0957103380,
      (c_lar_fam = NULL) => -0.0179654308, -0.0069490370),
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1249) => 0.1814548628,
      (c_popover25 > 1249) => -0.0327225062,
      (c_popover25 = NULL) => 0.0998634841, 0.0998634841),
   (k_comb_age_d = NULL) => -0.0056402087, -0.0056402087),
(r_D30_Derog_Count_i > 11.5) => 0.0726115993,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 0.0271178774,
   (r_L77_Apartment_i > 0.5) => -0.1118035013,
   (r_L77_Apartment_i = NULL) => -0.0119049818, -0.0119049818), -0.0046424012);

// Tree: 58 
woFDN_FLA____lgt_58 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 75) => 0.2024027863,
   (c_born_usa > 75) => 0.0282393972,
   (c_born_usa = NULL) => 0.0827966034, 0.0827966034),
(f_mos_liens_unrel_SC_fseen_d > 66.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 26.65) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.33936895935) => 0.0090493974,
      (f_add_curr_nhood_MFD_pct_i > 0.33936895935) => 0.0435544656,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0160744256, 0.0090705248),
   (c_hh1_p > 26.65) => -0.0220084256,
   (c_hh1_p = NULL) => -0.0290727741, -0.0040822796),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0539059313,
   (c_assault > 90) => 0.0544017616,
   (c_assault = NULL) => -0.0066740051, -0.0066740051), -0.0029701742);

// Tree: 59 
woFDN_FLA____lgt_59 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0069026458,
   (f_nae_nothing_found_i > 0.5) => 0.1012621630,
   (f_nae_nothing_found_i = NULL) => -0.0054151141, -0.0054151141),
(f_divaddrsuspidcountnew_i > 2.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.95) => -0.0382900363,
   (c_pop_35_44_p > 12.95) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.35745001815) => 0.1897327827,
      (f_add_input_nhood_MFD_pct_i > 0.35745001815) => 0.0583389981,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.1216026722, 0.1216026722),
   (c_pop_35_44_p = NULL) => 0.0617080094, 0.0617080094),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 13.3) => 0.0404858916,
   (c_hh3_p > 13.3) => -0.0915604455,
   (c_hh3_p = NULL) => -0.0265226974, -0.0265226974), -0.0040253999);

// Tree: 60 
woFDN_FLA____lgt_60 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0066530936,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 20.55) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 29.2) => -0.0001102980,
      (c_rnt1000_p > 29.2) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 15.8) => 0.1429495604,
         (c_hval_250k_p > 15.8) => -0.0188125473,
         (c_hval_250k_p = NULL) => 0.0844747445, 0.0844747445),
      (c_rnt1000_p = NULL) => 0.0249018624, 0.0249018624),
   (c_hval_100k_p > 20.55) => 0.1314440959,
   (c_hval_100k_p = NULL) => 0.0342255218, 0.0342255218),
(f_hh_collections_ct_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 15.5) => -0.0578869293,
   (c_retail > 15.5) => 0.0766908857,
   (c_retail = NULL) => -0.0094776433, -0.0094776433), -0.0030904181);

// Tree: 61 
woFDN_FLA____lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 8.95) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => 0.0104202279,
      (f_mos_inq_banko_cm_fseen_d > 41.5) => 0.1458505140,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0892972077, 0.0892972077),
   (c_low_hval > 8.95) => -0.0683249326,
   (c_low_hval = NULL) => 0.0502173382, 0.0502173382),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 18.65) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -69530) => 0.1221943140,
      (f_addrchangevaluediff_d > -69530) => 0.0138138559,
      (f_addrchangevaluediff_d = NULL) => 0.0329652044, 0.0192256799),
   (c_hh1_p > 18.65) => -0.0134052362,
   (c_hh1_p = NULL) => -0.0157820021, -0.0022475806),
(r_D33_Eviction_Recency_d = NULL) => -0.0305404728, -0.0016089760);

// Tree: 62 
woFDN_FLA____lgt_62 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0008243730,
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => -0.0217603849,
   (f_rel_incomeover75_count_d > 0.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 84.5) => -0.0112419085,
      (c_unattach > 84.5) => 
         map(
         (NULL < c_families and c_families <= 389.5) => 0.0842453962,
         (c_families > 389.5) => 0.2562889077,
         (c_families = NULL) => 0.1702671519, 0.1702671519),
      (c_unattach = NULL) => 0.1111470580, 0.1111470580),
   (f_rel_incomeover75_count_d = NULL) => 0.0678630248, 0.0678630248),
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 206426.5) => -0.0298647818,
   (c_med_hval > 206426.5) => 0.0759652588,
   (c_med_hval = NULL) => 0.0202652375, 0.0202652375), 0.0008565760);

// Tree: 63 
woFDN_FLA____lgt_63 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 19) => -0.0479013920,
   (c_low_ed > 19) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 2.5) => 0.0850796445,
      (f_rel_incomeover25_count_d > 2.5) => 0.0132532767,
      (f_rel_incomeover25_count_d = NULL) => 0.0491664606, 0.0491664606),
   (c_low_ed = NULL) => 0.0219463750, 0.0219463750),
(r_C10_M_Hdr_FS_d > 8.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 0.5) => 0.1723097217,
      (f_rel_under100miles_cnt_d > 0.5) => 0.0269278881,
      (f_rel_under100miles_cnt_d = NULL) => 0.0360142527, 0.0360142527),
   (f_corraddrnamecount_d > 1.5) => -0.0052691600,
   (f_corraddrnamecount_d = NULL) => -0.0022727022, -0.0022727022),
(r_C10_M_Hdr_FS_d = NULL) => -0.0229849150, -0.0021899553);

// Tree: 64 
woFDN_FLA____lgt_64 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0871650929,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => -0.0055898762,
   (f_prevaddrageoldest_d > 271.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 24.5) => 0.2311296864,
      (f_mos_inq_banko_cm_lseen_d > 24.5) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 14.25) => 0.0083854877,
         (c_rnt1250_p > 14.25) => 0.1520521424,
         (c_rnt1250_p = NULL) => 0.0432680824, 0.0432680824),
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0518228002, 0.0518228002),
   (f_prevaddrageoldest_d = NULL) => -0.0005297447, -0.0005297447),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0746162389,
   (c_rich_nfam > 124) => -0.0500623493,
   (c_rich_nfam = NULL) => 0.0113465076, 0.0113465076), 0.0000653124);

// Tree: 65 
woFDN_FLA____lgt_65 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0051399933,
(f_prevaddrageoldest_d > 151.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.2416792497,
   (f_adl_per_email_i > 0.5) => -0.0548351875,
   (f_adl_per_email_i = NULL) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 45.45) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 150) => 0.1425377900,
         (f_prevaddrlenofres_d > 150) => 0.0129761231,
         (f_prevaddrlenofres_d = NULL) => 0.0158425316, 0.0158425316),
      (c_hval_750k_p > 45.45) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 546840.5) => 0.2870677118,
         (f_curraddrmedianvalue_d > 546840.5) => 0.0642711004,
         (f_curraddrmedianvalue_d = NULL) => 0.1313785135, 0.1313785135),
      (c_hval_750k_p = NULL) => 0.0225065250, 0.0225065250), 0.0257870349),
(f_prevaddrageoldest_d = NULL) => 0.0123085755, 0.0025353649);

// Tree: 66 
woFDN_FLA____lgt_66 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 34.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -9.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.05) => 0.0300756954,
         (c_pop_55_64_p > 9.05) => 0.1950225333,
         (c_pop_55_64_p = NULL) => 0.1069682063, 0.1069682063),
      (f_addrchangecrimediff_i > -9.5) => 0.0151604512,
      (f_addrchangecrimediff_i = NULL) => 0.0283415923, 0.0222004523),
   (c_born_usa > 34.5) => -0.0080916716,
   (c_born_usa = NULL) => -0.0072600642, -0.0014190356),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1108074352,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0510885259,
   (c_pop_35_44_p > 15.55) => 0.0635306531,
   (c_pop_35_44_p = NULL) => 0.0102008962, 0.0102008962), -0.0007944087);

// Tree: 67 
woFDN_FLA____lgt_67 := map(
(NULL < c_pop_55_64_p and c_pop_55_64_p <= 18.95) => -0.0022834954,
(c_pop_55_64_p > 18.95) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 149.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 13.55) => -0.0424076520,
         (C_INC_35K_P > 13.55) => 0.1593747580,
         (C_INC_35K_P = NULL) => -0.0116092841, -0.0116092841),
      (c_easiqlife > 149.5) => 
         map(
         (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 0.3990977606,
         (f_rel_criminal_count_i > 1.5) => 0.0426651343,
         (f_rel_criminal_count_i = NULL) => 0.2463409208, 0.2463409208),
      (c_easiqlife = NULL) => 0.0353916858, 0.0353916858),
   (k_inq_per_addr_i > 3.5) => 0.1523989739,
   (k_inq_per_addr_i = NULL) => 0.0486406026, 0.0486406026),
(c_pop_55_64_p = NULL) => -0.0054640019, 0.0008002031);

// Tree: 68 
woFDN_FLA____lgt_68 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 73) => 0.1460726008,
      (c_serv_empl > 73) => 0.0262461380,
      (c_serv_empl = NULL) => 0.0632605951, 0.0632605951),
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 2.5) => 0.0084768521,
      (f_hh_lienholders_i > 2.5) => 0.0871092436,
      (f_hh_lienholders_i = NULL) => 0.0109570327, 0.0109570327),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0126561476, 0.0126561476),
(f_historical_count_d > 0.5) => -0.0151259694,
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 11.85) => 0.0409133137,
   (c_newhouse > 11.85) => -0.0681618860,
   (c_newhouse = NULL) => -0.0128561509, -0.0128561509), -0.0017461971);

// Tree: 69 
woFDN_FLA____lgt_69 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 19.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => -0.0023145998,
   (f_inq_HighRiskCredit_count_i > 4.5) => 
      map(
      (NULL < c_young and c_young <= 29.15) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 81.5) => -0.1404731378,
         (r_C13_max_lres_d > 81.5) => -0.0341308657,
         (r_C13_max_lres_d = NULL) => -0.0646889899, -0.0646889899),
      (c_young > 29.15) => 0.0300902377,
      (c_young = NULL) => -0.0422412781, -0.0422412781),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0030484047, -0.0030484047),
(f_inq_HighRiskCredit_count_i > 19.5) => 0.0725086789,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_business and c_business <= 41.5) => -0.0450343846,
   (c_business > 41.5) => 0.0715704226,
   (c_business = NULL) => -0.0028581777, -0.0028581777), -0.0026647800);

// Tree: 70 
woFDN_FLA____lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0098974158,
   (f_srchfraudsrchcountmo_i > 0.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 11.05) => 
         map(
         (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 61.5) => 0.0986247153,
         (r_I61_inq_collection_recency_d > 61.5) => -0.0076776208,
         (r_I61_inq_collection_recency_d = NULL) => 0.0166896769, 0.0166896769),
      (c_hh5_p > 11.05) => 0.1536148903,
      (c_hh5_p = NULL) => 0.0390180090, 0.0390180090),
   (f_srchfraudsrchcountmo_i = NULL) => 0.0019579320, -0.0079704677),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 62500) => 0.1423732538,
   (k_estimated_income_d > 62500) => 0.0374730609,
   (k_estimated_income_d = NULL) => 0.0429825248, 0.0429825248),
(c_hval_750k_p = NULL) => 0.0206467432, -0.0034936764);

// Tree: 71 
woFDN_FLA____lgt_71 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0004793173,
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 25.65) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 97.5) => 0.1440959611,
         (r_D32_Mos_Since_Crim_LS_d > 97.5) => 0.0284817330,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0489526627, 0.0489526627),
      (C_INC_15K_P > 25.65) => 0.1453332123,
      (C_INC_15K_P = NULL) => 0.0624592795, 0.0624592795),
   (f_current_count_d > 0.5) => -0.0078869188,
   (f_current_count_d = NULL) => 0.0292629023, 0.0292629023),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 9.95) => -0.0495818841,
   (C_INC_125K_P > 9.95) => 0.0564524500,
   (C_INC_125K_P = NULL) => -0.0084665301, -0.0084665301), 0.0028967467);

// Tree: 72 
woFDN_FLA____lgt_72 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 86.25) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 157.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 39.75) => 0.1407418233,
         (c_civ_emp > 39.75) => -0.0021022333,
         (c_civ_emp = NULL) => 0.0151880156, 0.0151880156),
      (c_serv_empl > 157.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly','6: Other']) => 0.0250749089,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity']) => 0.1783980245,
         (nf_seg_FraudPoint_3_0 = '') => 0.1078857895, 0.1078857895),
      (c_serv_empl = NULL) => 0.0391306727, 0.0391306727),
   (c_occunit_p > 86.25) => 0.0030457624,
   (c_occunit_p = NULL) => -0.0084952384, 0.0069723150),
(f_historical_count_d > 0.5) => -0.0158905211,
(f_historical_count_d = NULL) => -0.0169641955, -0.0050001473);

// Tree: 73 
woFDN_FLA____lgt_73 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.15) => -0.0083775802,
   (c_pop_12_17_p > 10.15) => 0.0248529833,
   (c_pop_12_17_p = NULL) => 0.0173058744, 0.0001147129),
(f_hh_collections_ct_i > 4.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 11.7) => -0.0718352681,
   (c_pop_45_54_p > 11.7) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 12.75) => 0.0598160227,
      (c_pop_25_34_p > 12.75) => 0.2360549325,
      (c_pop_25_34_p = NULL) => 0.1338094581, 0.1338094581),
   (c_pop_45_54_p = NULL) => 0.0670279233, 0.0670279233),
(f_hh_collections_ct_i = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 101.5) => -0.0594519680,
   (c_span_lang > 101.5) => 0.0552807303,
   (c_span_lang = NULL) => 0.0046400910, 0.0046400910), 0.0012321416);

// Tree: 74 
woFDN_FLA____lgt_74 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 32392.5) => 
   map(
   (NULL < c_robbery and c_robbery <= 168.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0133529548,
         (f_rel_felony_count_i > 0.5) => 
            map(
            (NULL < c_med_hval and c_med_hval <= 79370.5) => -0.0028901142,
            (c_med_hval > 79370.5) => 0.1655128220,
            (c_med_hval = NULL) => 0.1071771643, 0.1071771643),
         (f_rel_felony_count_i = NULL) => 0.0323915543, 0.0323915543),
      (r_L79_adls_per_addr_c6_i > 4.5) => 0.1214743005,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0401566363, 0.0401566363),
   (c_robbery > 168.5) => -0.0287253212,
   (c_robbery = NULL) => 0.0415260282, 0.0244634525),
(f_curraddrmedianincome_d > 32392.5) => -0.0060586404,
(f_curraddrmedianincome_d = NULL) => 0.0191969000, -0.0024877062);

// Tree: 75 
woFDN_FLA____lgt_75 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 32.5) => -0.0200170862,
(k_comb_age_d > 32.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 118.75) => -0.0070272538,
   (c_oldhouse > 118.75) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 15.5) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0236858159,
         (r_C23_inp_addr_occ_index_d > 2) => 
            map(
            (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 153.5) => 0.0524958858,
            (f_curraddrcartheftindex_i > 153.5) => 0.1785623785,
            (f_curraddrcartheftindex_i = NULL) => 0.0878788605, 0.0878788605),
         (r_C23_inp_addr_occ_index_d = NULL) => 0.0404507955, 0.0404507955),
      (f_rel_under500miles_cnt_d > 15.5) => -0.0287464695,
      (f_rel_under500miles_cnt_d = NULL) => 0.0285748983, 0.0285748983),
   (c_oldhouse = NULL) => -0.0275478966, 0.0033080345),
(k_comb_age_d = NULL) => -0.0293601221, -0.0047342740);

// Tree: 76 
woFDN_FLA____lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0109493037,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 135.5) => 0.0025345446,
      (f_prevaddrlenofres_d > 135.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0456074901,
         (f_rel_homeover500_count_d > 3.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03648382765) => 0.0802241565,
            (f_add_curr_nhood_BUS_pct_i > 0.03648382765) => 0.2317475267,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1512507363, 0.1512507363),
         (f_rel_homeover500_count_d = NULL) => 0.0619919751, 0.0619919751),
      (f_prevaddrlenofres_d = NULL) => 0.0176158368, 0.0176158368),
   (f_nae_nothing_found_i > 0.5) => 0.2034944415,
   (f_nae_nothing_found_i = NULL) => 0.0205210153, 0.0205210153),
(c_rnt1250_p = NULL) => 0.0023966161, -0.0019286079);

// Tree: 77 
woFDN_FLA____lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 64.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.1) => 0.2102671741,
      (r_C12_source_profile_d > 60.1) => -0.0217274228,
      (r_C12_source_profile_d = NULL) => 0.0738919719, 0.0738919719),
   (f_mos_liens_unrel_SC_fseen_d > 64.5) => -0.0020601830,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 110.5) => -0.0531888424,
      (c_for_sale > 110.5) => 0.0948998109,
      (c_for_sale = NULL) => 0.0033335443, 0.0033335443), -0.0010790302),
(c_transport > 29.05) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.1836706363,
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0202872111,
   (r_C12_Num_NonDerogs_d = NULL) => 0.1015804276, 0.1015804276),
(c_transport = NULL) => -0.0066744170, 0.0004805130);

// Tree: 78 
woFDN_FLA____lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 23.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0234434856,
         (f_varrisktype_i > 2.5) => 
            map(
            (NULL < c_hval_400k_p and c_hval_400k_p <= 5.55) => 0.2497691255,
            (c_hval_400k_p > 5.55) => 0.0758922700,
            (c_hval_400k_p = NULL) => 0.1575387934, 0.1575387934),
         (f_varrisktype_i = NULL) => 0.0839178401, 0.0839178401),
      (r_C13_max_lres_d > 23.5) => 0.0020172819,
      (r_C13_max_lres_d = NULL) => 0.0037984880, 0.0037984880),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0589036873,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0170615814, 0.0014312372),
(r_L77_Add_PO_Box_i > 0.5) => -0.1026315274,
(r_L77_Add_PO_Box_i = NULL) => -0.0009970307, -0.0009970307);

// Tree: 79 
woFDN_FLA____lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 8.5) => 
         map(
         (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 1.5) => -0.0356218809,
         (k_inq_adls_per_addr_i > 1.5) => 0.0958041699,
         (k_inq_adls_per_addr_i = NULL) => -0.0018930714, -0.0018930714),
      (c_hval_200k_p > 8.5) => 0.2034166538,
      (c_hval_200k_p = NULL) => 0.0445125514, 0.0445125514),
   (r_C10_M_Hdr_FS_d > 11.5) => -0.0052660644,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0040732091, -0.0040732091),
(f_inq_PrepaidCards_count_i > 1.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 8.65) => 0.1327851614,
   (c_pop_12_17_p > 8.65) => -0.0000628552,
   (c_pop_12_17_p = NULL) => 0.0557556392, 0.0557556392),
(f_inq_PrepaidCards_count_i = NULL) => -0.0074490568, -0.0035278235);

// Tree: 80 
woFDN_FLA____lgt_80 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 63.65) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 107.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 147.5) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 87.5) => 0.1256078130,
         (f_curraddrmurderindex_i > 87.5) => -0.0613749602,
         (f_curraddrmurderindex_i = NULL) => 0.0305495316, 0.0305495316),
      (c_span_lang > 147.5) => 0.1441912061,
      (c_span_lang = NULL) => 0.0583605743, 0.0583605743),
   (f_mos_liens_unrel_SC_fseen_d > 107.5) => 0.0029215711,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 92) => 0.0623566369,
      (c_many_cars > 92) => -0.0425676951,
      (c_many_cars = NULL) => 0.0082550282, 0.0082550282), 0.0041646438),
(C_RENTOCC_P > 63.65) => -0.0286214216,
(C_RENTOCC_P = NULL) => 0.0270618480, 0.0014164585);

// Tree: 81 
woFDN_FLA____lgt_81 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 35.6) => 
   map(
   (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => -0.0054853144,
   (f_srchaddrsrchcountmo_i > 0.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 53.5) => -0.1076567690,
      (c_lar_fam > 53.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 7.45) => 0.2124091904,
         (c_hh3_p > 7.45) => 
            map(
            (NULL < c_high_ed and c_high_ed <= 15.45) => -0.0356080926,
            (c_high_ed > 15.45) => 0.0758800566,
            (c_high_ed = NULL) => 0.0487059835, 0.0487059835),
         (c_hh3_p = NULL) => 0.0613179409, 0.0613179409),
      (c_lar_fam = NULL) => 0.0474558006, 0.0474558006),
   (f_srchaddrsrchcountmo_i = NULL) => -0.0230106502, -0.0026297751),
(c_hval_80k_p > 35.6) => -0.0867875080,
(c_hval_80k_p = NULL) => 0.0164857271, -0.0034014232);

// Tree: 82 
woFDN_FLA____lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0048197072,
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 149319) => -0.0246333734,
         (f_prevaddrmedianvalue_d > 149319) => 
            map(
            (NULL < c_unempl and c_unempl <= 84.5) => 0.3186767605,
            (c_unempl > 84.5) => 0.0868508799,
            (c_unempl = NULL) => 0.1757374870, 0.1757374870),
         (f_prevaddrmedianvalue_d = NULL) => 0.0999562000, 0.0999562000),
      (k_nap_fname_verd_d > 0.5) => 0.0083448953,
      (k_nap_fname_verd_d = NULL) => 0.0340719224, 0.0340719224),
   (f_hh_collections_ct_i = NULL) => -0.0013396330, -0.0013396330),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0698733088,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0051260775, -0.0019048314);

// Tree: 83 
woFDN_FLA____lgt_83 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0079903735,
   (f_srchaddrsrchcount_i > 1.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 112.5) => 0.1683628816,
         (c_rest_indx > 112.5) => 0.0237724473,
         (c_rest_indx = NULL) => 0.0960676644, 0.0960676644),
      (r_C10_M_Hdr_FS_d > 10.5) => 0.0135127128,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0151014502, 0.0151014502),
   (f_srchaddrsrchcount_i = NULL) => 
      map(
      (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 0.0563551117,
      (r_L77_Apartment_i > 0.5) => -0.0562157879,
      (r_L77_Apartment_i = NULL) => 0.0162613666, 0.0162613666), 0.0026561157),
(r_L77_Add_PO_Box_i > 0.5) => -0.0886478676,
(r_L77_Add_PO_Box_i = NULL) => 0.0005471628, 0.0005471628);

// Tree: 84 
woFDN_FLA____lgt_84 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0029635074,
   (k_comb_age_d > 67.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 37.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 26.95) => 0.0370381886,
         (C_RENTOCC_P > 26.95) => 0.2113141409,
         (C_RENTOCC_P = NULL) => 0.1253537050, 0.1253537050),
      (c_born_usa > 37.5) => 0.0287544973,
      (c_born_usa = NULL) => 0.0455543595, 0.0455543595),
   (k_comb_age_d = NULL) => 0.0052256944, 0.0005101208),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.45) => 0.0042316753,
   (c_pop_45_54_p > 14.45) => 0.2087514317,
   (c_pop_45_54_p = NULL) => 0.0993154217, 0.0993154217),
(r_L71_Add_HiRisk_Comm_i = NULL) => 0.0014136616, 0.0014136616);

// Tree: 85 
woFDN_FLA____lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0101386047,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 8.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3815154375) => 0.0211803866,
      (f_add_curr_mobility_index_i > 0.3815154375) => -0.0220651743,
      (f_add_curr_mobility_index_i = NULL) => 0.0123660047, 0.0123660047),
   (f_inq_Collection_count_i > 8.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 11.85) => -0.0020174764,
      (c_hh4_p > 11.85) => 0.1589771143,
      (c_hh4_p = NULL) => 0.0899794326, 0.0899794326),
   (f_inq_Collection_count_i = NULL) => 0.0191453408, 0.0191453408),
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_med_age and c_med_age <= 37.25) => 0.0757212365,
   (c_med_age > 37.25) => -0.0517360863,
   (c_med_age = NULL) => 0.0068253863, 0.0068253863), -0.0063021376);

// Tree: 86 
woFDN_FLA____lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => -0.0034044614,
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45337) => 
      map(
      (NULL < c_food and c_food <= 6.35) => 0.1832056039,
      (c_food > 6.35) => 0.0488293939,
      (c_food = NULL) => 0.0856634819, 0.0856634819),
   (f_curraddrmedianincome_d > 45337) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 138) => -0.0124076814,
      (r_C13_Curr_Addr_LRes_d > 138) => 0.1646336888,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0090874077, 0.0090874077),
   (f_curraddrmedianincome_d = NULL) => 0.0327839672, 0.0327839672),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.25) => -0.0481595118,
   (c_pop_55_64_p > 11.25) => 0.0717085480,
   (c_pop_55_64_p = NULL) => -0.0031027234, -0.0031027234), -0.0015290180);

// Tree: 87 
woFDN_FLA____lgt_87 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 115.5) => 
   map(
   (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 12.5) => -0.0084620249,
      (f_hh_members_ct_d > 12.5) => 0.0833080143,
      (f_hh_members_ct_d = NULL) => -0.0073263515, -0.0073263515),
   (r_L72_Add_Vacant_i > 0.5) => 0.1334722913,
   (r_L72_Add_Vacant_i = NULL) => -0.0064677345, -0.0064677345),
(f_addrchangecrimediff_i > 115.5) => 0.1099796879,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 460.5) => -0.0126138874,
   (f_M_Bureau_ADL_FS_all_d > 460.5) => 0.1554749505,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 139) => -0.0287530783,
      (c_cartheft > 139) => 0.0773804579,
      (c_cartheft = NULL) => 0.0107564863, 0.0107564863), -0.0057847324), -0.0058494157);

// Tree: 88 
woFDN_FLA____lgt_88 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 3.35) => -0.0607253427,
(C_OWNOCC_P > 3.35) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 42.5) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 60553.5) => 0.1293869100,
         (r_A46_Curr_AVM_AutoVal_d > 60553.5) => 0.0458627260,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 
            map(
            (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 159.5) => 0.1800048442,
            (f_mos_acc_lseen_d > 159.5) => 0.0141675249,
            (f_mos_acc_lseen_d = NULL) => 0.0297616309, 0.0297616309), 0.0445369792),
      (f_inq_QuizProvider_count_i > 1.5) => -0.0766333733,
      (f_inq_QuizProvider_count_i = NULL) => 0.0317359178, 0.0317359178),
   (c_exp_prod > 42.5) => -0.0003789256,
   (c_exp_prod = NULL) => 0.0029406628, 0.0029406628),
(C_OWNOCC_P = NULL) => -0.0373399005, 0.0009204189);

// Tree: 89 
woFDN_FLA____lgt_89 := map(
(NULL < c_newhouse and c_newhouse <= 8.95) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 17258) => 0.0098684934,
   (f_addrchangeincomediff_d > 17258) => 0.0886769731,
   (f_addrchangeincomediff_d = NULL) => 0.0074661698, 0.0112022721),
(c_newhouse > 8.95) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 6.5) => -0.0135275397,
   (f_crim_rel_under25miles_cnt_i > 6.5) => 
      map(
      (NULL < C_INC_201K_P and C_INC_201K_P <= 0.85) => -0.1599369349,
      (C_INC_201K_P > 0.85) => -0.0319042778,
      (C_INC_201K_P = NULL) => -0.0716659725, -0.0716659725),
   (f_crim_rel_under25miles_cnt_i = NULL) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1985.5) => -0.0393471935,
      (c_med_yearblt > 1985.5) => 0.0807286189,
      (c_med_yearblt = NULL) => 0.0081694382, 0.0081694382), -0.0142831614),
(c_newhouse = NULL) => 0.0101739114, -0.0029216692);

// Tree: 90 
woFDN_FLA____lgt_90 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 48.95) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => -0.0028116712,
      (r_D32_criminal_count_i > 5.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 142.5) => 0.1729310638,
         (f_M_Bureau_ADL_FS_all_d > 142.5) => 
            map(
            (NULL < c_pop_18_24_p and c_pop_18_24_p <= 6.45) => -0.0813531757,
            (c_pop_18_24_p > 6.45) => 0.0657685807,
            (c_pop_18_24_p = NULL) => 0.0139256761, 0.0139256761),
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0459685869, 0.0459685869),
      (r_D32_criminal_count_i = NULL) => -0.0132119461, -0.0018776420),
   (c_hval_80k_p > 48.95) => -0.1248575042,
   (c_hval_80k_p = NULL) => -0.0019046720, -0.0024658152),
(k_inq_adls_per_addr_i > 4.5) => -0.0799144795,
(k_inq_adls_per_addr_i = NULL) => -0.0032412177, -0.0032412177);

// Tree: 91 
woFDN_FLA____lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.45) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 121.5) => -0.0337865757,
      (c_lar_fam > 121.5) => 0.1320987515,
      (c_lar_fam = NULL) => 0.0347080110, 0.0347080110),
   (c_retired > 15.45) => 0.2127686318,
   (c_retired = NULL) => 0.0800792269, 0.0800792269),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0102064948,
      (r_D33_eviction_count_i > 3.5) => 0.0653117942,
      (r_D33_eviction_count_i = NULL) => -0.0096802124, -0.0096802124),
   (c_food > 65.55) => 0.0577761915,
   (c_food = NULL) => -0.0006641390, -0.0071098331),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0085471609, -0.0054733375);

// Tree: 92 
woFDN_FLA____lgt_92 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.15) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0049292482,
   (f_assocsuspicousidcount_i > 15.5) => 0.0945525018,
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.25) => -0.0568520442,
      (c_pop_55_64_p > 11.25) => 0.0655243793,
      (c_pop_55_64_p = NULL) => -0.0019936475, -0.0019936475), -0.0043454638),
(c_hh3_p > 23.15) => 
   map(
   (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 194.5) => 0.0381551303,
      (c_asian_lang > 194.5) => -0.0786967509,
      (c_asian_lang = NULL) => 0.0296452651, 0.0296452651),
   (f_acc_damage_amt_total_i > 275) => 0.1916022483,
   (f_acc_damage_amt_total_i = NULL) => 0.0341797184, 0.0341797184),
(c_hh3_p = NULL) => -0.0428158132, 0.0005698058);

// Tree: 93 
woFDN_FLA____lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 0.0016943743,
      (r_D33_eviction_count_i > 3.5) => 0.0875878032,
      (r_D33_eviction_count_i = NULL) => 0.0021814826, 0.0021814826),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 45.5) => 0.0888922294,
      (r_pb_order_freq_d > 45.5) => -0.0023031229,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 144) => 0.2214904756,
         (f_fp_prevaddrcrimeindex_i > 144) => 0.0588748471,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.1266313590, 0.1266313590), 0.0829390279),
   (f_curraddrcartheftindex_i = NULL) => 0.0081084976, 0.0038260690),
(c_cartheft > 189.5) => -0.0599527930,
(c_cartheft = NULL) => 0.0016208907, 0.0017121450);

// Tree: 94 
woFDN_FLA____lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 0.85) => -0.0092851861,
   (c_hh7p_p > 0.85) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 775223) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 0.1225991215,
         (r_C21_M_Bureau_ADL_FS_d > 6.5) => 0.0104224405,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0119887893, 0.0119887893),
      (f_curraddrmedianvalue_d > 775223) => 0.2628399346,
      (f_curraddrmedianvalue_d = NULL) => 0.0237674455, 0.0156609016),
   (c_hh7p_p = NULL) => -0.0003076040, -0.0003076040),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 29500) => 0.1161973461,
   (k_estimated_income_d > 29500) => 0.0200846417,
   (k_estimated_income_d = NULL) => 0.0662490115, 0.0662490115),
(c_famotf18_p = NULL) => 0.0133153320, 0.0006827108);

// Tree: 95 
woFDN_FLA____lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => -0.0097798960,
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 31289) => 0.1356941267,
   (f_curraddrmedianincome_d > 31289) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => -0.0064376620,
         (k_comb_age_d > 66.5) => 0.1592692362,
         (k_comb_age_d = NULL) => 0.0054264826, 0.0054264826),
      (f_rel_felony_count_i > 0.5) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 0.55) => 0.2049815415,
         (c_pop_85p_p > 0.55) => 0.0277826974,
         (c_pop_85p_p = NULL) => 0.1022575739, 0.1022575739),
      (f_rel_felony_count_i = NULL) => 0.0189880766, 0.0189880766),
   (f_curraddrmedianincome_d = NULL) => 0.0244092608, 0.0244092608),
(c_rnt1000_p = NULL) => -0.0125674383, -0.0056267255);

// Tree: 96 
woFDN_FLA____lgt_96 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45600) => 
   map(
   (NULL < c_construction and c_construction <= 40.1) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 193.5) => 0.0218786032,
      (c_asian_lang > 193.5) => -0.0768361366,
      (c_asian_lang = NULL) => 0.0169010841, 0.0169010841),
   (c_construction > 40.1) => 0.1352422807,
   (c_construction = NULL) => -0.0059842134, 0.0192576508),
(f_curraddrmedianincome_d > 45600) => 
   map(
   (NULL < c_transport and c_transport <= 29.05) => -0.0115571585,
   (c_transport > 29.05) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 15.15) => 0.2171665410,
      (C_INC_100K_P > 15.15) => -0.0261475930,
      (C_INC_100K_P = NULL) => 0.0889334163, 0.0889334163),
   (c_transport = NULL) => -0.0099798327, -0.0099798327),
(f_curraddrmedianincome_d = NULL) => -0.0118143952, -0.0029468568);

// Tree: 97 
woFDN_FLA____lgt_97 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0002260539,
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1362165769,
      (r_A50_pb_average_dollars_d > 99) => 0.0101483306,
      (r_A50_pb_average_dollars_d = NULL) => 0.0680157223, 0.0680157223),
   (r_D33_eviction_count_i = NULL) => 
      map(
      (NULL < c_incollege and c_incollege <= 7.25) => -0.0544883676,
      (c_incollege > 7.25) => 0.0553573472,
      (c_incollege = NULL) => -0.0143378650, -0.0143378650), 0.0002485792),
(k_inq_adls_per_addr_i > 3.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 48) => -0.1138794315,
   (f_curraddrmurderindex_i > 48) => -0.0314346109,
   (f_curraddrmurderindex_i = NULL) => -0.0603063380, -0.0603063380),
(k_inq_adls_per_addr_i = NULL) => -0.0009830462, -0.0009830462);

// Tree: 98 
woFDN_FLA____lgt_98 := map(
(NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 
   map(
   (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0176271679,
      (f_hh_members_ct_d > 1.5) => -0.0116727542,
      (f_hh_members_ct_d = NULL) => -0.0055576555, -0.0055576555),
   (r_L72_Add_Vacant_i > 0.5) => 0.1209790335,
   (r_L72_Add_Vacant_i = NULL) => -0.0048498297, -0.0048498297),
(f_inq_Other_count24_i > 3.5) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 782.5) => 0.0158488150,
   (c_hh00 > 782.5) => 0.1974369402,
   (c_hh00 = NULL) => 0.0750179794, 0.0750179794),
(f_inq_Other_count24_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 2.05) => -0.0658746200,
   (c_hval_125k_p > 2.05) => 0.0477923016,
   (c_hval_125k_p = NULL) => 0.0036827499, 0.0036827499), -0.0036075369);

// Tree: 99 
woFDN_FLA____lgt_99 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 116.5) => 0.1019128213,
(r_D32_Mos_Since_Fel_LS_d > 116.5) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 14.05) => -0.0380366737,
   (C_OWNOCC_P > 14.05) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 0.0024694504,
      (k_comb_age_d > 67.5) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 162.5) => 0.0242339025,
         (f_curraddrmurderindex_i > 162.5) => 0.1956707195,
         (f_curraddrmurderindex_i = NULL) => 0.0426745057, 0.0426745057),
      (k_comb_age_d = NULL) => 0.0054074721, 0.0054074721),
   (C_OWNOCC_P = NULL) => 0.0112107639, 0.0033790815),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_transport and c_transport <= 0.05) => -0.0422002424,
   (c_transport > 0.05) => 0.0753706838,
   (c_transport = NULL) => -0.0013770041, -0.0013770041), 0.0038098527);

// Tree: 100 
woFDN_FLA____lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_transport and c_transport <= 26.6) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 45073.5) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 131.5) => 0.0118215718,
         (c_blue_empl > 131.5) => 0.0819968845,
         (c_blue_empl = NULL) => 0.0344935959, 0.0344935959),
      (f_prevaddrmedianincome_d > 45073.5) => -0.0046818037,
      (f_prevaddrmedianincome_d = NULL) => 0.0044575605, 0.0044575605),
   (c_transport > 26.6) => 0.1484403143,
   (c_transport = NULL) => 0.0209706846, 0.0075042840),
(f_historical_count_d > 0.5) => -0.0169749907,
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.65) => -0.0560778853,
   (c_pop_35_44_p > 14.65) => 0.0644977136,
   (c_pop_35_44_p = NULL) => 0.0100154060, 0.0100154060), -0.0047756507);

// Tree: 101 
woFDN_FLA____lgt_101 := map(
(NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2840699251) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 23.15) => -0.0024275539,
   (c_hh3_p > 23.15) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 106.5) => 0.0131741972,
      (f_prevaddrcartheftindex_i > 106.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 110.5) => 
            map(
            (NULL < C_RENTOCC_P and C_RENTOCC_P <= 11) => 0.3918505444,
            (C_RENTOCC_P > 11) => 0.0908302900,
            (C_RENTOCC_P = NULL) => 0.1631785056, 0.1631785056),
         (c_old_homes > 110.5) => 0.0205573233,
         (c_old_homes = NULL) => 0.0962537595, 0.0962537595),
      (f_prevaddrcartheftindex_i = NULL) => 0.0421431629, 0.0421431629),
   (c_hh3_p = NULL) => -0.0041540110, 0.0046551037),
(f_add_curr_mobility_index_i > 0.2840699251) => -0.0145476221,
(f_add_curr_mobility_index_i = NULL) => 0.0236505159, -0.0018177202);

// Tree: 102 
woFDN_FLA____lgt_102 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0004546731,
(f_srchfraudsrchcountmo_i > 0.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 38.15) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 25.75) => -0.0372688349,
      (c_rnt500_p > 25.75) => 0.1043523698,
      (c_rnt500_p = NULL) => -0.0011693121, -0.0011693121),
   (c_fammar18_p > 38.15) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 30.15) => 
         map(
         (NULL < c_incollege and c_incollege <= 5.95) => -0.0576284746,
         (c_incollege > 5.95) => 0.1166564637,
         (c_incollege = NULL) => 0.0400205334, 0.0400205334),
      (c_rnt1000_p > 30.15) => 0.2568322709,
      (c_rnt1000_p = NULL) => 0.0976111512, 0.0976111512),
   (c_fammar18_p = NULL) => 0.0412598802, 0.0412598802),
(f_srchfraudsrchcountmo_i = NULL) => -0.0096392726, 0.0009002202);

// Tree: 103 
woFDN_FLA____lgt_103 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 25.05) => -0.0045656128,
(c_rnt2001_p > 25.05) => 
   map(
   (NULL < c_unempl and c_unempl <= 97.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 7.55) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 209.5) => -0.0494874851,
         (f_M_Bureau_ADL_FS_all_d > 209.5) => 0.2093278625,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1112148549, 0.1112148549),
      (C_RENTOCC_P > 7.55) => -0.0421947982,
      (C_RENTOCC_P = NULL) => 0.0052672701, 0.0052672701),
   (c_unempl > 97.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 68.5) => 0.2397876081,
      (r_pb_order_freq_d > 68.5) => -0.0487445105,
      (r_pb_order_freq_d = NULL) => 0.1733316710, 0.1335246419),
   (c_unempl = NULL) => 0.0436547912, 0.0436547912),
(c_rnt2001_p = NULL) => 0.0336209491, -0.0009415100);

// Tree: 104 
woFDN_FLA____lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 58) => 
      map(
      (NULL < c_totsales and c_totsales <= 5278) => -0.0242722529,
      (c_totsales > 5278) => 0.1574462401,
      (c_totsales = NULL) => 0.0686999993, 0.0686999993),
   (f_mos_liens_unrel_SC_fseen_d > 58) => -0.0011450501,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0004010510, -0.0004010510),
(f_prevaddrmedianvalue_d > 809865.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 0.5) => 0.0243546363,
   (f_bus_addr_match_count_d > 0.5) => 0.3135002167,
   (f_bus_addr_match_count_d = NULL) => 0.1394514207, 0.1394514207),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.5) => -0.0542202017,
   (c_pop_35_44_p > 16.5) => 0.0436467471,
   (c_pop_35_44_p = NULL) => -0.0158669380, -0.0158669380), 0.0016494247);

// Tree: 105 
woFDN_FLA____lgt_105 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.15) => -0.0526082994,
   (c_pop_45_54_p > 7.15) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 84.55) => 
         map(
         (NULL < c_assault and c_assault <= 149.5) => 0.0113933069,
         (c_assault > 149.5) => 0.0634322644,
         (c_assault = NULL) => 0.0210527121, 0.0210527121),
      (r_C12_source_profile_d > 84.55) => 0.1898233330,
      (r_C12_source_profile_d = NULL) => 0.0244812109, 0.0244812109),
   (c_pop_45_54_p = NULL) => 0.0091589720, 0.0168122183),
(f_corraddrnamecount_d > 4.5) => -0.0091600170,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 72.5) => -0.0934026950,
   (c_unempl > 72.5) => 0.0482430982,
   (c_unempl = NULL) => -0.0071372119, -0.0071372119), -0.0018300645);

// Tree: 106 
woFDN_FLA____lgt_106 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 30.5) => 0.0978478259,
   (f_mos_liens_unrel_SC_fseen_d > 30.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 36.15) => -0.0063201858,
      (c_hh3_p > 36.15) => 0.0942193723,
      (c_hh3_p = NULL) => -0.0229854165, -0.0057335520),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0051318691, -0.0051318691),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 94.5) => 0.3244145751,
   (c_medi_indx > 94.5) => -0.0151456142,
   (c_medi_indx = NULL) => 0.1354419480, 0.1354419480),
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 91.5) => -0.0413192401,
   (c_assault > 91.5) => 0.0510554519,
   (c_assault = NULL) => 0.0023372924, 0.0023372924), -0.0037544081);

// Tree: 107 
woFDN_FLA____lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0942984832,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 22.15) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => -0.0040552072,
      (r_D32_criminal_count_i > 10.5) => 0.0860564968,
      (r_D32_criminal_count_i = NULL) => -0.0034965856, -0.0034965856),
   (c_hval_40k_p > 22.15) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.15) => -0.0646134717,
      (c_pop_65_74_p > 4.15) => 
         map(
         (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => 0.2648000860,
         (f_crim_rel_under100miles_cnt_i > 0.5) => 0.0388984058,
         (f_crim_rel_under100miles_cnt_i = NULL) => 0.1378226710, 0.1378226710),
      (c_pop_65_74_p = NULL) => 0.0718108853, 0.0718108853),
   (c_hval_40k_p = NULL) => 0.0271544090, -0.0014753255),
(f_attr_arrest_recency_d = NULL) => -0.0122020155, -0.0009261572);

// Tree: 108 
woFDN_FLA____lgt_108 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => -0.0017087319,
(f_phones_per_addr_curr_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.95) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 54430.5) => 
            map(
            (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => 0.1626187941,
            (r_F03_address_match_d > 3) => 0.0267565160,
            (r_F03_address_match_d = NULL) => 0.0800262581, 0.0800262581),
         (f_curraddrmedianincome_d > 54430.5) => 0.0213834165,
         (f_curraddrmedianincome_d = NULL) => 0.0473431458, 0.0473431458),
      (c_pop_75_84_p > 2.95) => -0.0055146609,
      (c_pop_75_84_p = NULL) => 0.0192760057, 0.0192760057),
   (r_C12_source_profile_d > 81.3) => 0.1721750773,
   (r_C12_source_profile_d = NULL) => 0.0263095794, 0.0263095794),
(f_phones_per_addr_curr_i = NULL) => -0.0178391609, 0.0011960928);

// Tree: 109 
woFDN_FLA____lgt_109 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 4.95) => -0.1378830148,
      (C_INC_125K_P > 4.95) => -0.0452932719,
      (C_INC_125K_P = NULL) => -0.0728056526, -0.0728056526),
   (f_mos_inq_banko_cm_lseen_d > 27.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.95) => 0.0523273672,
      (c_pop_55_64_p > 8.95) => -0.0446891400,
      (c_pop_55_64_p = NULL) => -0.0033187375, -0.0033187375),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0272890299, -0.0272890299),
(r_D33_Eviction_Recency_d > 549) => 0.0084764528,
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 121) => -0.0234027664,
   (c_totcrime > 121) => 0.0806102166,
   (c_totcrime = NULL) => 0.0153331032, 0.0153331032), 0.0071167193);

// Tree: 110 
woFDN_FLA____lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 121.5) => -0.0071859834,
(f_prevaddrageoldest_d > 121.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 16.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 0.0395336028,
      (f_hh_lienholders_i > 0.5) => 
         map(
         (NULL < c_blue_col and c_blue_col <= 15.05) => 0.2523945651,
         (c_blue_col > 15.05) => 0.0385807906,
         (c_blue_col = NULL) => 0.1454876778, 0.1454876778),
      (f_hh_lienholders_i = NULL) => 0.0746388686, 0.0746388686),
   (c_born_usa > 16.5) => 0.0148582493,
   (c_born_usa = NULL) => -0.0235065392, 0.0193250329),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 9.8) => -0.1005970560,
   (c_hh4_p > 9.8) => 0.0264678197,
   (c_hh4_p = NULL) => -0.0202090734, -0.0202090734), 0.0007507283);

// Tree: 111 
woFDN_FLA____lgt_111 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 19.5) => 
   map(
   (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 2.5) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 2.95) => -0.0131478680,
      (C_INC_150K_P > 2.95) => 0.2169122211,
      (C_INC_150K_P = NULL) => 0.1194291325, 0.1194291325),
   (f_addrchangeecontrajindex_d > 2.5) => -0.0515880097,
   (f_addrchangeecontrajindex_d = NULL) => 0.1039321323, 0.0465007869),
(k_comb_age_d > 19.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0005537069,
      (k_inq_ssns_per_addr_i > 1.5) => 0.0353014965,
      (k_inq_ssns_per_addr_i = NULL) => 0.0035349123, 0.0035349123),
   (k_inq_adls_per_addr_i > 3.5) => -0.0555936925,
   (k_inq_adls_per_addr_i = NULL) => 0.0022763400, 0.0022763400),
(k_comb_age_d = NULL) => -0.0263517180, 0.0031024427);

// Tree: 112 
woFDN_FLA____lgt_112 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
      map(
      (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 3.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 284.5) => -0.0003340872,
         (r_C21_M_Bureau_ADL_FS_d > 284.5) => 0.0680473120,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0183986832, 0.0183986832),
      (r_C20_email_domain_free_count_i > 3.5) => 0.1480023216,
      (r_C20_email_domain_free_count_i = NULL) => 0.0225694055, 0.0225694055),
   (f_corraddrnamecount_d > 3.5) => -0.0029378406,
   (f_corraddrnamecount_d = NULL) => 0.0013941674, 0.0013941674),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0608050691,
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_med_age and c_med_age <= 36.85) => 0.0796640884,
   (c_med_age > 36.85) => -0.0186615702,
   (c_med_age = NULL) => 0.0322697062, 0.0322697062), 0.0005673631);

// Tree: 113 
woFDN_FLA____lgt_113 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30022.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 24466.5) => -0.0155319223,
      (f_prevaddrmedianincome_d > 24466.5) => 
         map(
         (NULL < c_med_age and c_med_age <= 32.95) => 0.0131331775,
         (c_med_age > 32.95) => 0.1089792050,
         (c_med_age = NULL) => 0.0682802549, 0.0682802549),
      (f_prevaddrmedianincome_d = NULL) => 0.0214282510, 0.0214282510),
   (f_curraddrmedianincome_d > 30022.5) => -0.0041454106,
   (f_curraddrmedianincome_d = NULL) => 
      map(
      (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => 0.0717897568,
      (f_phones_per_addr_c6_i > 0.5) => -0.0426441306,
      (f_phones_per_addr_c6_i = NULL) => 0.0280130348, 0.0280130348), -0.0015058604),
(r_L77_Add_PO_Box_i > 0.5) => -0.0973475362,
(r_L77_Add_PO_Box_i = NULL) => -0.0036214039, -0.0036214039);

// Tree: 114 
woFDN_FLA____lgt_114 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 32.5) => 
   map(
   (NULL < c_retail and c_retail <= 28.85) => -0.0097973148,
   (c_retail > 28.85) => 0.0307283711,
   (c_retail = NULL) => 0.0371912381, -0.0047398143),
(f_rel_under500miles_cnt_d > 32.5) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 106.5) => -0.1208962550,
   (c_for_sale > 106.5) => 0.0030669388,
   (c_for_sale = NULL) => -0.0589146581, -0.0589146581),
(f_rel_under500miles_cnt_d = NULL) => 
   map(
   (NULL < c_child and c_child <= 22.95) => -0.0328531151,
   (c_child > 22.95) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 212835.5) => 0.1418364137,
      (c_med_hval > 212835.5) => 0.0007504249,
      (c_med_hval = NULL) => 0.0667127054, 0.0667127054),
   (c_child = NULL) => 0.0123773756, 0.0123773756), -0.0050933414);

// Tree: 115 
woFDN_FLA____lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 363.75) => 0.0009057333,
   (c_oldhouse > 363.75) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 114.5) => -0.0772851411,
         (f_M_Bureau_ADL_FS_all_d > 114.5) => 
            map(
            (NULL < c_retired2 and c_retired2 <= 36.5) => 0.1912378758,
            (c_retired2 > 36.5) => 0.0057899825,
            (c_retired2 = NULL) => 0.0422954733, 0.0422954733),
         (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0069761687, -0.0069761687),
      (r_I60_Inq_Count12_i > 0.5) => -0.0862062511,
      (r_I60_Inq_Count12_i = NULL) => -0.0391905978, -0.0391905978),
   (c_oldhouse = NULL) => -0.0015048025, -0.0015048025),
(c_pop_0_5_p > 21.15) => 0.1462947387,
(c_pop_0_5_p = NULL) => 0.0079755243, -0.0006458730);

// Tree: 116 
woFDN_FLA____lgt_116 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 11.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 131739.5) => -0.0792440508,
   (r_A46_Curr_AVM_AutoVal_d > 131739.5) => 0.1596387160,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0416883907) => -0.0154891115,
      (f_add_input_nhood_BUS_pct_i > 0.0416883907) => 0.1487787222,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0642981220, 0.0642981220), 0.0615829155),
(r_D32_Mos_Since_Crim_LS_d > 11.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 202) => -0.0788139322,
   (r_D32_Mos_Since_Fel_LS_d > 202) => -0.0015963067,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0022939428, -0.0022939428),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 187276.5) => -0.0708972790,
   (c_med_hval > 187276.5) => 0.0560633636,
   (c_med_hval = NULL) => -0.0017321528, -0.0017321528), -0.0010833432);

// Tree: 117 
woFDN_FLA____lgt_117 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 105.5) => -0.0042438212,
   (c_rich_fam > 105.5) => 0.1303634807,
   (c_rich_fam = NULL) => 0.0634276093, 0.0634276093),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.85) => -0.0102656830,
   (c_pop_35_44_p > 15.85) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 14.5) => 0.0109844566,
      (f_bus_addr_match_count_d > 14.5) => 0.1274065023,
      (f_bus_addr_match_count_d = NULL) => 0.0149482653, 0.0149482653),
   (c_pop_35_44_p = NULL) => 0.0021161014, 0.0000080848),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 1.2) => -0.0878693217,
   (c_hval_125k_p > 1.2) => 0.0158209273,
   (c_hval_125k_p = NULL) => -0.0280771343, -0.0280771343), 0.0005948268);

// Tree: 118 
woFDN_FLA____lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => -0.0072496130,
   (k_comb_age_d > 84.5) => 0.0953715264,
   (k_comb_age_d = NULL) => -0.0064920751, -0.0064920751),
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 0.1) => -0.0269674054,
   (c_hval_250k_p > 0.1) => 
      map(
      (NULL < c_work_home and c_work_home <= 81.5) => 0.1513173534,
      (c_work_home > 81.5) => 0.0508196626,
      (c_work_home = NULL) => 0.0807112834, 0.0807112834),
   (c_hval_250k_p = NULL) => 0.0461940731, 0.0461940731),
(f_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0346625799,
   (k_nap_lname_verd_d > 0.5) => -0.0656665115,
   (k_nap_lname_verd_d = NULL) => -0.0064296543, -0.0064296543), -0.0052534304);

// Tree: 119 
woFDN_FLA____lgt_119 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 150.5) => 0.0994010234,
   (c_rich_wht > 150.5) => -0.0369691064,
   (c_rich_wht = NULL) => 0.0613156718, 0.0613156718),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 5.35) => 0.0878446663,
      (c_hh3_p > 5.35) => -0.0526246764,
      (c_hh3_p = NULL) => -0.0438781420, -0.0438781420),
   (f_mos_inq_banko_om_fseen_d > 21.5) => 0.0071677163,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0037790554, 0.0037790554),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 95.5) => 0.0308743395,
   (c_born_usa > 95.5) => -0.0785800084,
   (c_born_usa = NULL) => -0.0147316388, -0.0147316388), 0.0045364696);

// Tree: 120 
woFDN_FLA____lgt_120 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 12.55) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 9) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 19.75) => -0.0206580390,
      (c_high_ed > 19.75) => 0.1197086594,
      (c_high_ed = NULL) => 0.0562094387, 0.0562094387),
   (r_I60_inq_comm_recency_d > 9) => 0.0028007229,
   (r_I60_inq_comm_recency_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 2.8) => -0.0406552306,
      (c_hval_200k_p > 2.8) => 0.0806928492,
      (c_hval_200k_p = NULL) => 0.0188952160, 0.0188952160), 0.0038385978),
(c_pop_18_24_p > 12.55) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => -0.0162932191,
   (r_F01_inp_addr_not_verified_i > 0.5) => -0.0603011512,
   (r_F01_inp_addr_not_verified_i = NULL) => -0.0206274961, -0.0206274961),
(c_pop_18_24_p = NULL) => -0.0300118981, -0.0009315018);

// Tree: 121 
woFDN_FLA____lgt_121 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 131959) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 15.5) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 0.85) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 7.5) => 0.0461772522,
         (f_rel_under25miles_cnt_d > 7.5) => 0.2224187845,
         (f_rel_under25miles_cnt_d = NULL) => 0.0988471354, 0.0988471354),
      (c_pop_75_84_p > 0.85) => 0.0000145192,
      (c_pop_75_84_p = NULL) => 0.0094065865, 0.0094065865),
   (f_rel_homeover100_count_d > 15.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 157466.5) => 0.1386742575,
      (f_curraddrmedianvalue_d > 157466.5) => -0.0104009730,
      (f_curraddrmedianvalue_d = NULL) => 0.0557772836, 0.0557772836),
   (f_rel_homeover100_count_d = NULL) => 0.0142472349, 0.0142472349),
(r_L80_Inp_AVM_AutoVal_d > 131959) => -0.0054298512,
(r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0057128766, -0.0022999710);

// Tree: 122 
woFDN_FLA____lgt_122 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0034399476,
(f_prevaddroccupantowned_i > 0.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 20.5) => 0.1623780623,
   (c_many_cars > 20.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 165156.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 5.5) => 0.2126398115,
         (f_prevaddrlenofres_d > 5.5) => 0.0415295425,
         (f_prevaddrlenofres_d = NULL) => 0.0754999635, 0.0754999635),
      (r_L80_Inp_AVM_AutoVal_d > 165156.5) => -0.0262104029,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0134820996, 0.0185376272),
   (c_many_cars = NULL) => 0.0313303774, 0.0313303774),
(f_prevaddroccupantowned_i = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.5) => 0.0786776129,
   (C_INC_75K_P > 15.5) => -0.0215862789,
   (C_INC_75K_P = NULL) => 0.0118350184, 0.0118350184), -0.0006782897);

// Tree: 123 
woFDN_FLA____lgt_123 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 24.15) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.0222813185,
   (r_I60_inq_comm_recency_d > 549) => -0.0033742016,
   (r_I60_inq_comm_recency_d = NULL) => 0.0174115747, -0.0008127719),
(c_hval_150k_p > 24.15) => 
   map(
   (NULL < c_families and c_families <= 787.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 29500) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => -0.0102548026,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.1770951415,
         (nf_seg_FraudPoint_3_0 = '') => 0.0825447024, 0.0825447024),
      (k_estimated_income_d > 29500) => 0.0050801029,
      (k_estimated_income_d = NULL) => 0.0172514863, 0.0172514863),
   (c_families > 787.5) => 0.2317069483,
   (c_families = NULL) => 0.0424171783, 0.0424171783),
(c_hval_150k_p = NULL) => -0.0137265296, 0.0015628196);

// Tree: 124 
woFDN_FLA____lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => -0.0090138984,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 1.55) => 
            map(
            (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0589810158,
            (f_varrisktype_i > 2.5) => 0.1783307496,
            (f_varrisktype_i = NULL) => 0.1129423316, 0.1129423316),
         (c_hval_750k_p > 1.55) => 0.0097622102,
         (c_hval_750k_p = NULL) => 0.0709542065, 0.0709542065),
      (nf_seg_FraudPoint_3_0 = '') => 0.0291062358, 0.0291062358),
   (f_prevaddrlenofres_d > 2.5) => 0.0034738450,
   (f_prevaddrlenofres_d = NULL) => -0.0057873446, 0.0053028426),
(c_high_ed > 42.55) => -0.0278187178,
(c_high_ed = NULL) => -0.0275357781, -0.0048534616);

// Tree: 125 
woFDN_FLA____lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5693) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 281.5) => -0.0074460316,
      (f_prevaddrageoldest_d > 281.5) => 0.0381858320,
      (f_prevaddrageoldest_d = NULL) => -0.0036842651, -0.0036842651),
   (f_liens_unrel_SC_total_amt_i > 5693) => 0.1300763198,
   (f_liens_unrel_SC_total_amt_i = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 3.75) => -0.0401061958,
      (c_high_hval > 3.75) => 0.0674176524,
      (c_high_hval = NULL) => 0.0060836263, 0.0060836263), -0.0029346198),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 61500) => 0.0157511003,
   (k_estimated_income_d > 61500) => 0.2046018795,
   (k_estimated_income_d = NULL) => 0.0902705970, 0.0902705970),
(f_nae_nothing_found_i = NULL) => -0.0015679529, -0.0015679529);

// Tree: 126 
woFDN_FLA____lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 6.5) => 0.0015325850,
   (r_L79_adls_per_addr_curr_i > 6.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00943851735) => 0.1958751962,
      (f_add_curr_nhood_MFD_pct_i > 0.00943851735) => 
         map(
         (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 0.1260632599,
         (r_C14_addrs_10yr_i > 0.5) => -0.0030725957,
         (r_C14_addrs_10yr_i = NULL) => 0.0187773874, 0.0187773874),
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0204684024, 0.0342369039),
   (r_L79_adls_per_addr_curr_i = NULL) => 
      map(
      (NULL < c_totsales and c_totsales <= 12027.5) => -0.0569854019,
      (c_totsales > 12027.5) => 0.0657418291,
      (c_totsales = NULL) => -0.0013910152, -0.0013910152), 0.0034165364),
(r_L72_Add_Vacant_i > 0.5) => 0.1041431873,
(r_L72_Add_Vacant_i = NULL) => 0.0041075875, 0.0041075875);

// Tree: 127 
woFDN_FLA____lgt_127 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => -0.0036631406,
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 4.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 48.45) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 38.5) => -0.0071768376,
         (r_A50_pb_average_dollars_d > 38.5) => 
            map(
            (NULL < c_hh4_p and c_hh4_p <= 15.75) => 0.0649600282,
            (c_hh4_p > 15.75) => 0.1741267052,
            (c_hh4_p = NULL) => 0.1079968912, 0.1079968912),
         (r_A50_pb_average_dollars_d = NULL) => 0.0793074065, 0.0793074065),
      (c_white_col > 48.45) => -0.0798821143,
      (c_white_col = NULL) => 0.0529356485, 0.0529356485),
   (f_historical_count_d > 4.5) => -0.0637112884,
   (f_historical_count_d = NULL) => 0.0288875833, 0.0288875833),
(f_inq_Communications_count_i = NULL) => -0.0192267244, -0.0027949673);

// Tree: 128 
woFDN_FLA____lgt_128 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1906.5) => -0.0067310048,
   (c_popover18 > 1906.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 22.55) => 0.0193355656,
      (c_hval_150k_p > 22.55) => 0.1309882456,
      (c_hval_150k_p = NULL) => 0.0269342167, 0.0269342167),
   (c_popover18 = NULL) => -0.0054753157, -0.0002950716),
(f_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < c_rental and c_rental <= 127.5) => 0.0116039869,
   (c_rental > 127.5) => 0.1313586830,
   (c_rental = NULL) => 0.0588014260, 0.0588014260),
(f_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 1.15) => 0.0796849189,
   (c_wholesale > 1.15) => -0.0264025614,
   (c_wholesale = NULL) => 0.0309632613, 0.0309632613), 0.0009150239);

// Tree: 129 
woFDN_FLA____lgt_129 := map(
(NULL < c_low_hval and c_low_hval <= 67.2) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.005) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 0.0027077074,
      (c_pop_18_24_p > 11.15) => -0.0231635470,
      (c_pop_18_24_p = NULL) => -0.0030345639, -0.0030345639),
   (c_hhsize > 4.005) => 
      map(
      (NULL < c_construction and c_construction <= 11.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 0.1247606272,
         (r_L79_adls_per_addr_curr_i > 4.5) => -0.0575131828,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0186609468, 0.0186609468),
      (c_construction > 11.5) => 0.1824489400,
      (c_construction = NULL) => 0.0708123476, 0.0708123476),
   (c_hhsize = NULL) => -0.0018267171, -0.0018267171),
(c_low_hval > 67.2) => -0.0914284842,
(c_low_hval = NULL) => 0.0143846493, -0.0022632313);

// Tree: 130 
woFDN_FLA____lgt_130 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1528.5) => -0.0097573131,
(f_addrchangeincomediff_d > 1528.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.58298875155) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 363.5) => 
         map(
         (NULL < c_unattach and c_unattach <= 99.5) => 0.0378065784,
         (c_unattach > 99.5) => 0.2242787173,
         (c_unattach = NULL) => 0.1277826454, 0.1277826454),
      (r_A50_pb_total_dollars_d > 363.5) => 0.0198329813,
      (r_A50_pb_total_dollars_d = NULL) => 0.0596185534, 0.0596185534),
   (f_add_curr_nhood_MFD_pct_i > 0.58298875155) => 0.0022347083,
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0604777232, 0.0304695464),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => -0.0003565020,
   (f_bus_addr_match_count_d > 6.5) => 0.1125342696,
   (f_bus_addr_match_count_d = NULL) => 0.0079056057, 0.0079056057), -0.0036689453);

// Tree: 131 
woFDN_FLA____lgt_131 := map(
(NULL < c_white_col and c_white_col <= 12.05) => -0.1073200805,
(c_white_col > 12.05) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 813323.5) => -0.0000681971,
   (f_prevaddrmedianvalue_d > 813323.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.65) => 
         map(
         (NULL < c_rich_asian and c_rich_asian <= 178.5) => 0.0605810431,
         (c_rich_asian > 178.5) => 0.2981576916,
         (c_rich_asian = NULL) => 0.1610942406, 0.1610942406),
      (c_pop_0_5_p > 7.65) => -0.0527099283,
      (c_pop_0_5_p = NULL) => 0.0935771346, 0.0935771346),
   (f_prevaddrmedianvalue_d = NULL) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 119.5) => -0.0457708046,
      (c_easiqlife > 119.5) => 0.0548908157,
      (c_easiqlife = NULL) => -0.0023032867, -0.0023032867), 0.0013528685),
(c_white_col = NULL) => 0.0042054523, 0.0007155857);

// Tree: 132 
woFDN_FLA____lgt_132 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 120.5) => -0.0023938886,
(f_addrchangecrimediff_i > 120.5) => 0.0806569776,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 53.65) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 24.5) => 
         map(
         (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => -0.0067426776,
         (f_inq_QuizProvider_count_i > 1.5) => 0.0662313486,
         (f_inq_QuizProvider_count_i = NULL) => 0.0007426149, 0.0007426149),
      (f_phones_per_addr_curr_i > 24.5) => 0.0991875122,
      (f_phones_per_addr_curr_i = NULL) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 15.05) => 0.0592382578,
         (c_hh3_p > 15.05) => -0.0380236217,
         (c_hh3_p = NULL) => 0.0057442241, 0.0057442241), 0.0045102325),
   (c_construction > 53.65) => 0.1853916493,
   (c_construction = NULL) => -0.0179406964, 0.0059094583), -0.0001027888);

// Tree: 133 
woFDN_FLA____lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.25) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 71) => 0.1157360900,
      (c_rich_fam > 71) => -0.0433924512,
      (c_rich_fam = NULL) => 0.0134391707, 0.0134391707),
   (c_hval_20k_p > 0.25) => 0.1445202522,
   (c_hval_20k_p = NULL) => 0.0633195822, 0.0633195822),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => -0.0095582504,
   (f_bus_name_nover_i > 0.5) => 0.0175537187,
   (f_bus_name_nover_i = NULL) => 0.0014551594, 0.0014551594),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 15.8) => 0.0483531086,
   (c_hh3_p > 15.8) => -0.0547613557,
   (c_hh3_p = NULL) => -0.0006077162, -0.0006077162), 0.0025389758);

// Tree: 134 
woFDN_FLA____lgt_134 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 37.5) => -0.0007844703,
   (f_rel_count_i > 37.5) => -0.0604458334,
   (f_rel_count_i = NULL) => -0.0147443124, -0.0022309994),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.05) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 0.0045191542,
      (f_divrisktype_i > 1.5) => 0.1253773202,
      (f_divrisktype_i = NULL) => 0.0123979768, 0.0123979768),
   (c_pop_6_11_p > 10.05) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 12.7) => 0.2435771834,
      (C_INC_100K_P > 12.7) => -0.0015519582,
      (C_INC_100K_P = NULL) => 0.1088278307, 0.1088278307),
   (c_pop_6_11_p = NULL) => 0.0523650825, 0.0310581429),
(r_L70_Add_Standardized_i = NULL) => 0.0006557216, 0.0006557216);

// Tree: 135 
woFDN_FLA____lgt_135 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 19.85) => -0.0046128254,
(c_hval_150k_p > 19.85) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 9363) => -0.0229614175,
      (r_A49_Curr_AVM_Chg_1yr_i > 9363) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 127.5) => 0.0407543427,
         (c_easiqlife > 127.5) => 0.3481920579,
         (c_easiqlife = NULL) => 0.1405717827, 0.1405717827),
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0024251177, 0.0147746435),
   (k_inq_ssns_per_addr_i > 1.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 17.35) => 0.0546600728,
      (c_hh4_p > 17.35) => 0.2599110830,
      (c_hh4_p = NULL) => 0.1226328100, 0.1226328100),
   (k_inq_ssns_per_addr_i = NULL) => 0.0287798354, 0.0287798354),
(c_hval_150k_p = NULL) => 0.0124891269, -0.0011011061);

// Tree: 136 
woFDN_FLA____lgt_136 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0125632168,
   (f_hh_criminals_i > 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 12.5) => 0.0142246069,
      (k_inq_per_addr_i > 12.5) => 0.1178286238,
      (k_inq_per_addr_i = NULL) => 0.0159375124, 0.0159375124),
   (f_hh_criminals_i = NULL) => -0.0034977836, -0.0034977836),
(f_rel_homeover500_count_d > 14.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 44.1) => 0.1719061102,
   (c_white_col > 44.1) => 0.0049348361,
   (c_white_col = NULL) => 0.0870290459, 0.0870290459),
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 187000) => 0.0900515025,
   (r_L80_Inp_AVM_AutoVal_d > 187000) => 0.0172125261,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0333525323, -0.0041714994), -0.0026623794);

// Tree: 137 
woFDN_FLA____lgt_137 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 41.3) => 
   map(
   (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => -0.0037362369,
   (f_srchaddrsrchcountmo_i > 0.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 55.5) => 0.1378112365,
      (c_rest_indx > 55.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151) => -0.0161005193,
         (f_prevaddrageoldest_d > 151) => 0.1289396059,
         (f_prevaddrageoldest_d = NULL) => 0.0114912890, 0.0114912890),
      (c_rest_indx = NULL) => 0.0268141229, 0.0268141229),
   (f_srchaddrsrchcountmo_i = NULL) => -0.0078963331, -0.0021064984),
(c_hval_80k_p > 41.3) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 36360.5) => -0.1527970554,
   (f_prevaddrmedianincome_d > 36360.5) => 0.0049615655,
   (f_prevaddrmedianincome_d = NULL) => -0.0739177449, -0.0739177449),
(c_hval_80k_p = NULL) => 0.0220176458, -0.0021379871);

// Tree: 138 
woFDN_FLA____lgt_138 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 3.55) => -0.0878890105,
(c_pop_35_44_p > 3.55) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 192) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 75.45) => 0.0039519205,
      (c_low_ed > 75.45) => -0.0455068916,
      (c_low_ed = NULL) => 0.0022338514, 0.0022338514),
   (f_curraddrcrimeindex_i > 192) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 26.55) => 0.0033991647,
      (c_famotf18_p > 26.55) => 0.1337800755,
      (c_famotf18_p = NULL) => 0.0530075112, 0.0530075112),
   (f_curraddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 63.55) => 0.0517759031,
      (c_civ_emp > 63.55) => -0.0564792617,
      (c_civ_emp = NULL) => 0.0067417546, 0.0067417546), 0.0031296783),
(c_pop_35_44_p = NULL) => -0.0255901607, 0.0013495692);

// Tree: 139 
woFDN_FLA____lgt_139 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02591901475) => -0.0222725561,
   (f_add_curr_nhood_BUS_pct_i > 0.02591901475) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.45142931765) => 0.0197890317,
      (f_add_input_nhood_MFD_pct_i > 0.45142931765) => 0.1056471521,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0600108539, 0.0600108539),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0321259205, 0.0321259205),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0037629352,
   (c_lar_fam > 181.5) => 0.0908344536,
   (c_lar_fam = NULL) => -0.0317364943, -0.0033925069),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 5.95) => -0.0967653949,
   (C_INC_25K_P > 5.95) => 0.0261214824,
   (C_INC_25K_P = NULL) => -0.0199610966, -0.0199610966), -0.0030769469);

// Tree: 140 
woFDN_FLA____lgt_140 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 18.85) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 18.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 121.5) => 0.0209788207,
         (c_rest_indx > 121.5) => 
            map(
            (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','6: Other']) => 0.0979530264,
            (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.2842303700,
            (nf_seg_FraudPoint_3_0 = '') => 0.1772933764, 0.1772933764),
         (c_rest_indx = NULL) => 0.0901672306, 0.0901672306),
      (c_fammar18_p > 18.5) => 0.0165824847,
      (c_fammar18_p = NULL) => 0.0278558280, 0.0278558280),
   (c_pop_18_24_p > 18.85) => -0.0734896236,
   (c_pop_18_24_p = NULL) => 0.0331735785, 0.0207158639),
(f_hh_members_ct_d > 1.5) => -0.0058157223,
(f_hh_members_ct_d = NULL) => -0.0164278247, -0.0004345200);

// Tree: 141 
woFDN_FLA____lgt_141 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -281708.5) => -0.0790199928,
   (f_addrchangevaluediff_d > -281708.5) => -0.0031964493,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 858.5) => -0.0439120699,
      (c_popover25 > 858.5) => 0.0146281399,
      (c_popover25 = NULL) => -0.0344043495, -0.0069586402), -0.0043867369),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < c_pop00 and c_pop00 <= 2231.5) => -0.0024601610,
   (c_pop00 > 2231.5) => 0.1611649737,
   (c_pop00 = NULL) => 0.0522913264, 0.0522913264),
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0555134197,
   (c_pop_35_44_p > 16.05) => 0.0524205899,
   (c_pop_35_44_p = NULL) => -0.0098187295, -0.0098187295), -0.0032678321);

// Tree: 142 
woFDN_FLA____lgt_142 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -56.5) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 76) => 0.0085712652,
   (c_cartheft > 76) => 0.1549774710,
   (c_cartheft = NULL) => 0.0519245591, 0.0519245591),
(f_addrchangecrimediff_i > -56.5) => -0.0039719865,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -6952.5) => -0.0491988544,
   (r_A49_Curr_AVM_Chg_1yr_i > -6952.5) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1674) => 0.0160571279,
      (c_popover25 > 1674) => 0.1821772956,
      (c_popover25 = NULL) => 0.0508580796, 0.0508580796),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 5.5) => 0.1166887469,
      (c_born_usa > 5.5) => -0.0119830932,
      (c_born_usa = NULL) => 0.0312020805, -0.0026255406), 0.0051704365), -0.0009517949);

// Tree: 143 
woFDN_FLA____lgt_143 := map(
(NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 0.0034744435,
   (f_inq_PrepaidCards_count_i > 2.5) => 0.0801506791,
   (f_inq_PrepaidCards_count_i = NULL) => 0.0038305652, 0.0038305652),
(f_inq_Auto_count24_i > 1.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 129.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 299500) => -0.0860372009,
      (r_L80_Inp_AVM_AutoVal_d > 299500) => 0.0529170070,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0052984804, -0.0248840919),
   (c_bel_edu > 129.5) => -0.1010189735,
   (c_bel_edu = NULL) => -0.0444029296, -0.0444029296),
(f_inq_Auto_count24_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1377) => 0.0295691617,
   (c_popover18 > 1377) => -0.0548861792,
   (c_popover18 = NULL) => -0.0071022363, -0.0071022363), 0.0011279702);

// Tree: 144 
woFDN_FLA____lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49.85) => 
   map(
   (NULL < c_employees and c_employees <= 82.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 8.95) => 0.0075768228,
      (c_unemp > 8.95) => 0.0611876250,
      (c_unemp = NULL) => 0.0129807061, 0.0129807061),
   (c_employees > 82.5) => -0.0119192539,
   (c_employees = NULL) => -0.0057394917, -0.0057394917),
(c_rnt2001_p > 49.85) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 52.5) => -0.0210248656,
   (r_C13_Curr_Addr_LRes_d > 52.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 32.5) => 0.2728167254,
      (c_born_usa > 32.5) => 0.0666960648,
      (c_born_usa = NULL) => 0.1288777166, 0.1288777166),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0711832520, 0.0711832520),
(c_rnt2001_p = NULL) => 0.0111380760, -0.0035901750);

// Tree: 145 
woFDN_FLA____lgt_145 := map(
(NULL < c_med_hhinc and c_med_hhinc <= 21102.5) => -0.0680931391,
(c_med_hhinc > 21102.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 75) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30362.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 5.85) => 
            map(
            (NULL < c_sfdu_p and c_sfdu_p <= 69.05) => 0.0199381286,
            (c_sfdu_p > 69.05) => 0.2357668836,
            (c_sfdu_p = NULL) => 0.1035926848, 0.1035926848),
         (c_high_ed > 5.85) => 0.0173989589,
         (c_high_ed = NULL) => 0.0316176170, 0.0316176170),
      (f_curraddrmedianincome_d > 30362.5) => -0.0012919571,
      (f_curraddrmedianincome_d = NULL) => -0.0017209977, 0.0008190065),
   (c_low_hval > 75) => -0.1096483407,
   (c_low_hval = NULL) => 0.0002767467, 0.0002767467),
(c_med_hhinc = NULL) => 0.0102346803, -0.0005214452);

// Tree: 146 
woFDN_FLA____lgt_146 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 31.45) => 0.2017550160,
      (c_high_ed > 31.45) => 0.0334339213,
      (c_high_ed = NULL) => 0.0639559448, 0.0975427862),
   (f_prevaddrmurderindex_i > 5) => 0.0126040624,
   (f_prevaddrmurderindex_i = NULL) => 0.0197856609, 0.0197856609),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => -0.0093205559,
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1167650377,
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0085314072, -0.0085314072),
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0303274953,
   (c_high_hval > 3.7) => 0.0621303415,
   (c_high_hval = NULL) => 0.0121531324, 0.0121531324), -0.0024342709);

// Tree: 147 
woFDN_FLA____lgt_147 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 56.85) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 63.5) => -0.0635459075,
   (f_mos_inq_banko_am_lseen_d > 63.5) => 0.0001040570,
   (f_mos_inq_banko_am_lseen_d = NULL) => 0.0133764219, -0.0024683357),
(c_fammar18_p > 56.85) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 165.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 42) => 0.1234793741,
      (f_mos_inq_banko_cm_lseen_d > 42) => -0.0175580609,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0044790383, 0.0044790383),
   (c_lar_fam > 165.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 39) => 0.0143208973,
      (f_curraddrcrimeindex_i > 39) => 0.2767488249,
      (f_curraddrcrimeindex_i = NULL) => 0.1559486677, 0.1559486677),
   (c_lar_fam = NULL) => 0.0319995766, 0.0319995766),
(c_fammar18_p = NULL) => -0.0412776459, -0.0013712852);

// Tree: 148 
woFDN_FLA____lgt_148 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 61.5) => -0.0630063562,
(f_mos_inq_banko_am_fseen_d > 61.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 15.55) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 52.05) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 36.25) => 0.0450063666,
         (C_RENTOCC_P > 36.25) => -0.1035821716,
         (C_RENTOCC_P = NULL) => 0.0073829867, 0.0073829867),
      (C_RENTOCC_P > 52.05) => 0.0905158816,
      (C_RENTOCC_P = NULL) => 0.0393571771, 0.0393571771),
   (c_hh2_p > 15.55) => -0.0003094629,
   (c_hh2_p = NULL) => 0.0106970152, 0.0015954896),
(f_mos_inq_banko_am_fseen_d = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 10.85) => 0.0269917116,
   (c_rnt500_p > 10.85) => -0.0666388997,
   (c_rnt500_p = NULL) => -0.0066883644, -0.0066883644), -0.0013330066);

// Tree: 149 
woFDN_FLA____lgt_149 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0085561595) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.1403813689,
   (f_hh_age_18_plus_d > 1.5) => 0.0286331640,
   (f_hh_age_18_plus_d = NULL) => 0.0477465596, 0.0477465596),
(f_add_input_nhood_MFD_pct_i > 0.0085561595) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 820276.5) => -0.0041647222,
   (f_prevaddrmedianvalue_d > 820276.5) => 
      map(
      (NULL < c_rich_asian and c_rich_asian <= 176.5) => 0.0118683113,
      (c_rich_asian > 176.5) => 0.2737205930,
      (c_rich_asian = NULL) => 0.1334425849, 0.1334425849),
   (f_prevaddrmedianvalue_d = NULL) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 62.1) => 0.0492039060,
      (c_civ_emp > 62.1) => -0.0852883932,
      (c_civ_emp = NULL) => -0.0149575578, -0.0149575578), -0.0026078982),
(f_add_input_nhood_MFD_pct_i = NULL) => 0.0074903818, 0.0035114896);

// Tree: 150 
woFDN_FLA____lgt_150 := map(
(NULL < c_low_ed and c_low_ed <= 77.75) => 
   map(
   (NULL < c_unempl and c_unempl <= 184.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0010949592,
      (f_srchfraudsrchcount_i > 6.5) => -0.0276012757,
      (f_srchfraudsrchcount_i = NULL) => 0.0140429184, 0.0000412487),
   (c_unempl > 184.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 101) => -0.0674112504,
      (f_fp_prevaddrburglaryindex_i > 101) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => -0.0155810298,
         (f_rel_under25miles_cnt_d > 4.5) => 0.1345906924,
         (f_rel_under25miles_cnt_d = NULL) => 0.0691312237, 0.0691312237),
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0340385318, 0.0340385318),
   (c_unempl = NULL) => 0.0006451683, 0.0006451683),
(c_low_ed > 77.75) => -0.0498307070,
(c_low_ed = NULL) => 0.0042161739, -0.0006835108);

// Tree: 151 
woFDN_FLA____lgt_151 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.99061691115) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 1.15) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1528.5) => 0.0129627431,
      (f_addrchangeincomediff_d > 1528.5) => 0.0636661103,
      (f_addrchangeincomediff_d = NULL) => 
         map(
         (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 1.5) => -0.0039863497,
         (f_inq_Other_count_i > 1.5) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 123.5) => 0.0109034117,
            (c_span_lang > 123.5) => 0.2144600567,
            (c_span_lang = NULL) => 0.1098804959, 0.1098804959),
         (f_inq_Other_count_i = NULL) => 0.0074107910, 0.0074107910), 0.0144156671),
   (c_pop_85p_p > 1.15) => -0.0097328807,
   (c_pop_85p_p = NULL) => 0.0030252544, 0.0030252544),
(f_add_curr_nhood_MFD_pct_i > 0.99061691115) => -0.0723247823,
(f_add_curr_nhood_MFD_pct_i = NULL) => -0.0169412555, -0.0015932370);

// Tree: 152 
woFDN_FLA____lgt_152 := map(
(NULL < c_white_col and c_white_col <= 30.85) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 1.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 111.5) => -0.0272249545,
      (c_many_cars > 111.5) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 4.5) => 0.0294837265,
         (f_rel_incomeover75_count_d > 4.5) => -0.0538422413,
         (f_rel_incomeover75_count_d = NULL) => 0.0194299177, 0.0194299177),
      (c_many_cars = NULL) => -0.0117178060, -0.0117178060),
   (r_I60_inq_hiRiskCred_count12_i > 1.5) => -0.0990183028,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0132709047, -0.0132709047),
(c_white_col > 30.85) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 19.5) => 0.1116442930,
   (f_mos_liens_unrel_CJ_lseen_d > 19.5) => 0.0076334095,
   (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0178071007, 0.0085743081),
(c_white_col = NULL) => 0.0256447901, 0.0033687758);

// Tree: 153 
woFDN_FLA____lgt_153 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00501882845) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 33.65) => 0.2616523778,
      (c_hh2_p > 33.65) => 0.0452652950,
      (c_hh2_p = NULL) => 0.1555802784, 0.1555802784),
   (f_hh_members_ct_d > 1.5) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 7.65) => 0.0024799798,
      (c_pop_75_84_p > 7.65) => 0.2396854148,
      (c_pop_75_84_p = NULL) => 0.0260434336, 0.0260434336),
   (f_hh_members_ct_d = NULL) => 0.0447055214, 0.0447055214),
(f_add_input_nhood_MFD_pct_i > 0.00501882845) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0116844122,
   (f_hh_criminals_i > 0.5) => 0.0162578020,
   (f_hh_criminals_i = NULL) => -0.0221064061, -0.0033771911),
(f_add_input_nhood_MFD_pct_i = NULL) => -0.0073064896, -0.0014378890);

// Tree: 154 
woFDN_FLA____lgt_154 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 31.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 16.15) => -0.0049152202,
   (c_hval_500k_p > 16.15) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 0.0214200566,
      (k_comb_age_d > 70.5) => 0.1466972661,
      (k_comb_age_d = NULL) => 0.0269568619, 0.0269568619),
   (c_hval_500k_p = NULL) => 0.0133969682, 0.0013777740),
(f_rel_under500miles_cnt_d > 31.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 12.8) => -0.0258211491,
   (C_INC_25K_P > 12.8) => -0.1234260667,
   (C_INC_25K_P = NULL) => -0.0502223785, -0.0502223785),
(f_rel_under500miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 229750) => 0.0687421135,
   (r_L80_Inp_AVM_AutoVal_d > 229750) => -0.0765219313,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0038043771, 0.0006511428), 0.0005238250);

// Tree: 155 
woFDN_FLA____lgt_155 := map(
(NULL < f_inq_Auto_count_i and f_inq_Auto_count_i <= 6.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 190.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -15521.5) => 0.0412586013,
      (f_addrchangeincomediff_d > -15521.5) => -0.0003395641,
      (f_addrchangeincomediff_d = NULL) => -0.0169048592, -0.0026686904),
   (c_unempl > 190.5) => 
      map(
      (NULL < c_burglary and c_burglary <= 130) => -0.0306462831,
      (c_burglary > 130) => 0.1413547201,
      (c_burglary = NULL) => 0.0649098298, 0.0649098298),
   (c_unempl = NULL) => 0.0283878563, -0.0013889783),
(f_inq_Auto_count_i > 6.5) => -0.1187395328,
(f_inq_Auto_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 98.5) => -0.0341008482,
   (c_burglary > 98.5) => 0.0674803777,
   (c_burglary = NULL) => 0.0099674777, 0.0099674777), -0.0017897616);

// Tree: 156 
woFDN_FLA____lgt_156 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => -0.0018009704,
   (f_inq_Communications_count24_i > 1.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 143.5) => -0.0093773688,
      (f_curraddrcartheftindex_i > 143.5) => 0.1461090538,
      (f_curraddrcartheftindex_i = NULL) => 0.0547162710, 0.0547162710),
   (f_inq_Communications_count24_i = NULL) => -0.0012035076, -0.0012035076),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 81) => -0.1336791193,
   (c_asian_lang > 81) => 0.0126307597,
   (c_asian_lang = NULL) => -0.0593811339, -0.0593811339),
(r_I60_inq_comm_count12_i = NULL) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 0.5) => 0.0360663719,
   (k_inq_per_addr_i > 0.5) => -0.0578855333,
   (k_inq_per_addr_i = NULL) => 0.0034123561, 0.0034123561), -0.0017354676);

// Tree: 157 
woFDN_FLA____lgt_157 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 15.5) => 0.0000735218,
(f_srchaddrsrchcount_i > 15.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 0.3) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 0.0244906844,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 0.1389130240,
      (nf_seg_FraudPoint_3_0 = '') => 0.0865366010, 0.0865366010),
   (c_low_hval > 0.3) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.89637166115) => -0.0543454026,
      (f_add_input_nhood_SFD_pct_d > 0.89637166115) => 0.0677378291,
      (f_add_input_nhood_SFD_pct_d = NULL) => -0.0068033749, -0.0068033749),
   (c_low_hval = NULL) => 0.0310659868, 0.0310659868),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0385480884,
   (k_nap_lname_verd_d > 0.5) => -0.0542817744,
   (k_nap_lname_verd_d = NULL) => -0.0008657081, -0.0008657081), 0.0009178445);

// Tree: 158 
woFDN_FLA____lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 14.5) => -0.0220584444,
   (r_C13_Curr_Addr_LRes_d > 14.5) => 
      map(
      (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0028146514,
      (f_srchunvrfddobcount_i > 0.5) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 1.35) => -0.0499035239,
         (c_newhouse > 1.35) => 
            map(
            (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 0.5) => 0.0663360235,
            (f_inq_QuizProvider_count_i > 0.5) => 0.2176913685,
            (f_inq_QuizProvider_count_i = NULL) => 0.1108064084, 0.1108064084),
         (c_newhouse = NULL) => 0.0738176144, 0.0738176144),
      (f_srchunvrfddobcount_i = NULL) => 0.0047169025, 0.0047169025),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0008644313, -0.0008644313),
(r_D33_eviction_count_i > 3.5) => 0.0694974730,
(r_D33_eviction_count_i = NULL) => 0.0003159300, -0.0004388894);

// Tree: 159 
woFDN_FLA____lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 144.5) => -0.0107551795,
   (r_A50_pb_average_dollars_d > 144.5) => 0.0117818776,
   (r_A50_pb_average_dollars_d = NULL) => -0.0009675310, -0.0009675310),
(f_rel_homeover500_count_d > 19.5) => 0.0990894522,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.14038461535) => 
      map(
      (NULL < c_burglary and c_burglary <= 94.5) => -0.0613944892,
      (c_burglary > 94.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0354313819,
         (c_hh4_p > 11.55) => 0.0919482137,
         (c_hh4_p = NULL) => 0.0261702258, 0.0261702258),
      (c_burglary = NULL) => -0.0237786609, -0.0237786609),
   (f_add_input_nhood_BUS_pct_i > 0.14038461535) => 0.1074269839,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0114538041, 0.0013783674), -0.0003256341);

// Tree: 160 
woFDN_FLA____lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => -0.0047961802,
(r_C12_source_profile_d > 81.3) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 38.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 0.2) => 0.2560744510,
      (c_hh6_p > 0.2) => 0.0324584447,
      (c_hh6_p = NULL) => 0.1481218962, 0.1481218962),
   (C_OWNOCC_P > 38.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 140.5) => -0.0077008549,
      (c_sub_bus > 140.5) => 
         map(
         (NULL < c_rape and c_rape <= 72.5) => 0.2261789882,
         (c_rape > 72.5) => -0.0001743864,
         (c_rape = NULL) => 0.1170156586, 0.1170156586),
      (c_sub_bus = NULL) => 0.0131098296, 0.0131098296),
   (C_OWNOCC_P = NULL) => 0.0294068116, 0.0294068116),
(r_C12_source_profile_d = NULL) => -0.0055763900, -0.0022054739);

// Tree: 161 
woFDN_FLA____lgt_161 := map(
(NULL < c_med_age and c_med_age <= 28.05) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 28.5) => -0.1177310034,
   (f_mos_inq_banko_cm_fseen_d > 28.5) => -0.0266710885,
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0324858979, -0.0324858979),
(c_med_age > 28.05) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 142.5) => -0.0104908541,
   (c_easiqlife > 142.5) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 6.5) => 
         map(
         (NULL < C_INC_200K_P and C_INC_200K_P <= 1.25) => 0.0706369808,
         (C_INC_200K_P > 1.25) => 0.0158252131,
         (C_INC_200K_P = NULL) => 0.0219272008, 0.0219272008),
      (f_hh_age_18_plus_d > 6.5) => -0.0631778451,
      (f_hh_age_18_plus_d = NULL) => 0.0178733341, 0.0178733341),
   (c_easiqlife = NULL) => -0.0024419870, -0.0024419870),
(c_med_age = NULL) => -0.0334142268, -0.0050303277);

// Tree: 162 
woFDN_FLA____lgt_162 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0031899737,
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 6.45) => 
      map(
      (NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.405) => 0.0112457270,
         (c_hhsize > 2.405) => 0.1484826565,
         (c_hhsize = NULL) => 0.0941597052, 0.0941597052),
      (r_A41_Prop_Owner_d > 0.5) => 
         map(
         (NULL < c_apt20 and c_apt20 <= 173.5) => 0.0138371744,
         (c_apt20 > 173.5) => 0.2035995516,
         (c_apt20 = NULL) => 0.0291772468, 0.0291772468),
      (r_A41_Prop_Owner_d = NULL) => 0.0436849585, 0.0436849585),
   (c_unemp > 6.45) => -0.0356879373,
   (c_unemp = NULL) => 0.0268791483, 0.0268791483),
(f_hh_payday_loan_users_i = NULL) => 0.0081466820, -0.0004218872);

// Tree: 163 
woFDN_FLA____lgt_163 := map(
(NULL < c_high_ed and c_high_ed <= 4.15) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1580502968) => -0.0284128738,
   (f_add_curr_nhood_MFD_pct_i > 0.1580502968) => 
      map(
      (NULL < c_unemp and c_unemp <= 6.25) => 0.1763735393,
      (c_unemp > 6.25) => 0.0208101703,
      (c_unemp = NULL) => 0.0837990191, 0.0837990191),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0271814683, 0.0271814683),
(c_high_ed > 4.15) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 31.55) => -0.0048842742,
   (C_INC_75K_P > 31.55) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.02429763595) => 0.1475886375,
      (f_add_input_nhood_BUS_pct_i > 0.02429763595) => -0.0097115336,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0543737213, 0.0543737213),
   (C_INC_75K_P = NULL) => -0.0037555974, -0.0037555974),
(c_high_ed = NULL) => 0.0082001062, -0.0025690252);

// Tree: 164 
woFDN_FLA____lgt_164 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 8.5) => 0.0072768998,
   (f_hh_tot_derog_i > 8.5) => 0.1039911856,
   (f_hh_tot_derog_i = NULL) => 0.0076914010, 0.0076914010),
(f_assocsuspicousidcount_i > 9.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 26.5) => -0.1214529702,
   (f_mos_inq_banko_om_lseen_d > 26.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 8.05) => -0.0477097877,
      (c_pop_65_74_p > 8.05) => 0.0864248804,
      (c_pop_65_74_p = NULL) => -0.0175519932, -0.0175519932),
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0364182232, -0.0364182232),
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 10.05) => 0.0378608128,
   (c_rnt500_p > 10.05) => -0.0700087861,
   (c_rnt500_p = NULL) => -0.0043818273, -0.0043818273), 0.0062063200);

// Tree: 165 
woFDN_FLA____lgt_165 := map(
(NULL < f_liens_rel_O_total_amt_i and f_liens_rel_O_total_amt_i <= 29.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 50.35) => 0.0004878327,
   (c_hh2_p > 50.35) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 115.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 16.5) => 0.2593931882,
         (f_prevaddrlenofres_d > 16.5) => 0.0750664942,
         (f_prevaddrlenofres_d = NULL) => 0.1098628599, 0.1098628599),
      (c_serv_empl > 115.5) => -0.0336950066,
      (c_serv_empl = NULL) => 0.0629968898, 0.0629968898),
   (c_hh2_p = NULL) => 0.0181166146, 0.0037870883),
(f_liens_rel_O_total_amt_i > 29.5) => -0.1013203778,
(f_liens_rel_O_total_amt_i = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 142.5) => 0.0439491101,
   (c_no_teens > 142.5) => -0.0657440464,
   (c_no_teens = NULL) => 0.0017024215, 0.0017024215), 0.0027305403);

// Tree: 166 
woFDN_FLA____lgt_166 := map(
(NULL < c_asian_lang and c_asian_lang <= 194.5) => 
   map(
   (NULL < c_info and c_info <= 23.35) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 10.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1130) => -0.0025969991,
         (f_addrchangeincomediff_d > 1130) => 0.0322097446,
         (f_addrchangeincomediff_d = NULL) => 0.0083199948, 0.0012190878),
      (f_srchfraudsrchcountyr_i > 10.5) => -0.0815381413,
      (f_srchfraudsrchcountyr_i = NULL) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 2) => 0.0583139254,
         (c_hval_300k_p > 2) => -0.0453782321,
         (c_hval_300k_p = NULL) => 0.0021143591, 0.0021143591), 0.0008707864),
   (c_info > 23.35) => 0.1263771042,
   (c_info = NULL) => 0.0017593268, 0.0017593268),
(c_asian_lang > 194.5) => -0.0539192802,
(c_asian_lang = NULL) => 0.0074755649, -0.0005234529);

// Tree: 167 
woFDN_FLA____lgt_167 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 123.5) => 0.0807202525,
   (r_D32_Mos_Since_Fel_LS_d > 123.5) => -0.0075112557,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0102860685, -0.0070500632),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 111.5) => 0.0029892137,
   (r_C13_Curr_Addr_LRes_d > 111.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 63.25) => -0.0100371930,
      (c_civ_emp > 63.25) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 126.5) => 0.1498420291,
         (c_sub_bus > 126.5) => 0.3330711548,
         (c_sub_bus = NULL) => 0.2285732941, 0.2285732941),
      (c_civ_emp = NULL) => 0.1043528533, 0.1043528533),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0318388649, 0.0318388649),
(r_L70_Add_Standardized_i = NULL) => -0.0037758515, -0.0037758515);

// Tree: 168 
woFDN_FLA____lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0051319920,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.05) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.55) => 
         map(
         (NULL < c_totsales and c_totsales <= 1734.5) => -0.0421480362,
         (c_totsales > 1734.5) => 
            map(
            (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => 0.0770833462,
            (f_inq_Collection_count_i > 1.5) => 0.2348063019,
            (f_inq_Collection_count_i = NULL) => 0.1098649802, 0.1098649802),
         (c_totsales = NULL) => 0.0623353039, 0.0623353039),
      (r_C12_source_profile_d > 60.55) => -0.0270304660,
      (r_C12_source_profile_d = NULL) => 0.0161960016, 0.0161960016),
   (r_C12_source_profile_d > 81.05) => 0.1857754076,
   (r_C12_source_profile_d = NULL) => 0.0352344303, 0.0352344303),
(c_hval_150k_p = NULL) => -0.0136241353, -0.0025485653);

// Tree: 169 
woFDN_FLA____lgt_169 := map(
(NULL < c_transport and c_transport <= 46.8) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 36.85) => -0.0057285350,
   (c_hval_500k_p > 36.85) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 47) => 0.2155712500,
         (c_rich_wht > 47) => 
            map(
            (NULL < c_femdiv_p and c_femdiv_p <= 4.25) => -0.0635647069,
            (c_femdiv_p > 4.25) => 0.1895124166,
            (c_femdiv_p = NULL) => 0.0594911421, 0.0594911421),
         (c_rich_wht = NULL) => 0.1099021086, 0.1099021086),
      (f_rel_incomeover100_count_d > 0.5) => -0.0113864691,
      (f_rel_incomeover100_count_d = NULL) => 0.0458788125, 0.0458788125),
   (c_hval_500k_p = NULL) => -0.0042608685, -0.0042608685),
(c_transport > 46.8) => 0.0907953915,
(c_transport = NULL) => 0.0034876033, -0.0033761099);

// Tree: 170 
woFDN_FLA____lgt_170 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0852781705,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 37500) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.0134759443,
      (f_assocrisktype_i > 7.5) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.03327757115) => 0.0884050274,
         (f_add_input_nhood_BUS_pct_i > 0.03327757115) => 0.0375196843,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0581161327, 0.0581161327),
      (f_assocrisktype_i = NULL) => 0.0165161071, 0.0165161071),
   (k_estimated_income_d > 37500) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0062961817,
      (f_nae_nothing_found_i > 0.5) => 0.1269289057,
      (f_nae_nothing_found_i = NULL) => -0.0048027944, -0.0048027944),
   (k_estimated_income_d = NULL) => 0.0059259423, 0.0008837739),
(c_pop_45_54_p = NULL) => -0.0340458074, -0.0009556697);

// Tree: 171 
woFDN_FLA____lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 11.5) => 0.1306863114,
   (r_D32_Mos_Since_Crim_LS_d > 11.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.10707073735) => 0.0036942075,
      (f_add_input_nhood_BUS_pct_i > 0.10707073735) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 34.6) => -0.0106416015,
         (C_RENTOCC_P > 34.6) => 
            map(
            (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.1492079086) => 0.1926547058,
            (f_add_input_nhood_BUS_pct_i > 0.1492079086) => 0.0708986781,
            (f_add_input_nhood_BUS_pct_i = NULL) => 0.1129261395, 0.1129261395),
         (C_RENTOCC_P = NULL) => 0.0626802207, 0.0626802207),
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0593941995, 0.0184317882),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0220509231, 0.0220509231),
(f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0019560881,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0052172592, 0.0014640896);

// Tree: 172 
woFDN_FLA____lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.75) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 15.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 20247.5) => 0.0840750257,
         (r_L80_Inp_AVM_AutoVal_d > 20247.5) => -0.0016619339,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0025213374, 0.0005626488),
      (f_inq_count24_i > 15.5) => -0.1004494866,
      (f_inq_count24_i = NULL) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.35) => -0.0321184718,
         (c_pop_6_11_p > 8.35) => 0.0749394153,
         (c_pop_6_11_p = NULL) => 0.0137634798, 0.0137634798), -0.0000172120),
   (c_manufacturing > 16.55) => -0.0504043902,
   (c_manufacturing = NULL) => -0.0038994160, -0.0038994160),
(c_pop_0_5_p > 20.75) => 0.1258428215,
(c_pop_0_5_p = NULL) => 0.0033635489, -0.0031777813);

// Tree: 173 
woFDN_FLA____lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0077839054,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 118.5) => 0.1965737612,
      (c_easiqlife > 118.5) => 0.0578854341,
      (c_easiqlife = NULL) => 0.1231505292, 0.1231505292),
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 134.5) => -0.0088303558,
      (c_exp_prod > 134.5) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00782781865) => 0.2070508664,
         (f_add_input_nhood_MFD_pct_i > 0.00782781865) => 0.0609472515,
         (f_add_input_nhood_MFD_pct_i = NULL) => -0.0313412126, 0.0590293677),
      (c_exp_prod = NULL) => 0.0128166528, 0.0128166528),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0202741226, 0.0202741226),
(f_rel_felony_count_i = NULL) => -0.0166386229, -0.0039079888);

// Tree: 174 
woFDN_FLA____lgt_174 := map(
(NULL < c_info and c_info <= 27.55) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 35.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 146.5) => 
         map(
         (NULL < c_rich_blk and c_rich_blk <= 198.5) => 
            map(
            (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0026822404,
            (f_hh_lienholders_i > 0.5) => 0.0246544970,
            (f_hh_lienholders_i = NULL) => 0.0059815956, 0.0059815956),
         (c_rich_blk > 198.5) => 0.1416169647,
         (c_rich_blk = NULL) => 0.0068577709, 0.0068577709),
      (c_new_homes > 146.5) => -0.0150994884,
      (c_new_homes = NULL) => -0.0007893875, -0.0007893875),
   (f_srchaddrsrchcount_i > 35.5) => -0.0691052512,
   (f_srchaddrsrchcount_i = NULL) => -0.0269192623, -0.0014440246),
(c_info > 27.55) => 0.1877461722,
(c_info = NULL) => -0.0058589850, -0.0005651267);

// Tree: 175 
woFDN_FLA____lgt_175 := map(
(NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2843546681) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0018875434,
   (k_comb_age_d > 56.5) => 0.0373063082,
   (k_comb_age_d = NULL) => 0.0066638424, 0.0066638424),
(f_add_curr_mobility_index_i > 0.2843546681) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 19999.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 29.6) => -0.1054181626,
      (c_white_col > 29.6) => -0.0297753902,
      (c_white_col = NULL) => -0.0548823529, -0.0548823529),
   (k_estimated_income_d > 19999.5) => -0.0146320154,
   (k_estimated_income_d = NULL) => -0.0168341076, -0.0168341076),
(f_add_curr_mobility_index_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 12.65) => -0.0266081478,
   (c_famotf18_p > 12.65) => 0.0782527409,
   (c_famotf18_p = NULL) => 0.0402551688, 0.0173000997), -0.0014975623);

// Tree: 176 
woFDN_FLA____lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0047610693,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 91.5) => -0.0215885875,
         (c_many_cars > 91.5) => 
            map(
            (NULL < c_rape and c_rape <= 112.5) => 0.0524424806,
            (c_rape > 112.5) => 0.2496000359,
            (c_rape = NULL) => 0.0912983492, 0.0912983492),
         (c_many_cars = NULL) => 0.0339428679, 0.0339428679),
      (c_pop_55_64_p > 17.45) => 0.2333080031,
      (c_pop_55_64_p = NULL) => 0.0512647567, 0.0512647567),
   (f_util_adl_count_n = NULL) => 0.0149701577, 0.0078486099),
(c_pop_18_24_p > 11.15) => -0.0216257170,
(c_pop_18_24_p = NULL) => 0.0153341610, 0.0013133280);

// Tree: 177 
woFDN_FLA____lgt_177 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 48.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -79750.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 0.0111220782,
         (f_util_adl_count_n > 3.5) => 0.1633204014,
         (f_util_adl_count_n = NULL) => 0.0445314662, 0.0445314662),
      (f_addrchangevaluediff_d > -79750.5) => -0.0009229723,
      (f_addrchangevaluediff_d = NULL) => 0.0007274377, 0.0003466484),
   (c_hval_100k_p > 48.5) => 0.1155858483,
   (c_hval_100k_p = NULL) => 0.0168251351, 0.0012169907),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 123.5) => -0.0137030713,
   (c_easiqlife > 123.5) => 0.1729588954,
   (c_easiqlife = NULL) => 0.0657787984, 0.0657787984),
(k_comb_age_d = NULL) => -0.0157145515, 0.0017993293);

// Tree: 178 
woFDN_FLA____lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 14.55) => -0.0073854503,
(c_rnt1250_p > 14.55) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.35) => 0.0042840582,
   (c_pop_6_11_p > 9.35) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 118891.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 70238) => 0.2269384952,
         (f_curraddrmedianincome_d > 70238) => 0.0397945071,
         (f_curraddrmedianincome_d = NULL) => 0.1442469656, 0.1442469656),
      (r_A46_Curr_AVM_AutoVal_d > 118891.5) => 
         map(
         (NULL < c_rich_old and c_rich_old <= 169.5) => 0.0190432999,
         (c_rich_old > 169.5) => 0.2231864364,
         (c_rich_old = NULL) => 0.0419844667, 0.0419844667),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0554569941, 0.0584085474),
   (c_pop_6_11_p = NULL) => 0.0201778744, 0.0201778744),
(c_rnt1250_p = NULL) => -0.0044251698, 0.0006601349);

// Tree: 179 
woFDN_FLA____lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => -0.0004946450,
   (k_comb_age_d > 84.5) => 0.0813572105,
   (k_comb_age_d = NULL) => 0.0000573490, 0.0000573490),
(f_rel_incomeover50_count_d > 22.5) => -0.0645037800,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.85) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 158.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 9.85) => 0.0163531776,
         (c_hh4_p > 9.85) => 0.1543447159,
         (c_hh4_p = NULL) => 0.1025978891, 0.1025978891),
      (c_asian_lang > 158.5) => -0.0259594063,
      (c_asian_lang = NULL) => 0.0509725185, 0.0509725185),
   (c_pop_45_54_p > 16.85) => -0.0754631497,
   (c_pop_45_54_p = NULL) => 0.0173537859, 0.0173537859), -0.0008335881);

// Tree: 180 
woFDN_FLA____lgt_180 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 0.0091069613,
   (f_dl_addrs_per_adl_i > 0.5) => -0.0168115703,
   (f_dl_addrs_per_adl_i = NULL) => -0.0013184403, -0.0013184403),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 21.8) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 13.95) => -0.0631095930,
      (C_INC_50K_P > 13.95) => 0.1030980610,
      (C_INC_50K_P = NULL) => 0.0137924559, 0.0137924559),
   (C_INC_75K_P > 21.8) => 0.2237446359,
   (C_INC_75K_P = NULL) => 0.0716711650, 0.0716711650),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 107.5) => -0.0543590181,
   (c_lux_prod > 107.5) => 0.0486943996,
   (c_lux_prod = NULL) => 0.0006028047, 0.0006028047), -0.0002123018);

// Tree: 181 
woFDN_FLA____lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 17.5) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 3.9) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.75310017755) => 
         map(
         (NULL < c_child and c_child <= 21.95) => 0.0163598504,
         (c_child > 21.95) => 
            map(
            (NULL < c_oldhouse and c_oldhouse <= 98.15) => 0.0785652324,
            (c_oldhouse > 98.15) => 0.2314013111,
            (c_oldhouse = NULL) => 0.1549832718, 0.1549832718),
         (c_child = NULL) => 0.1023063717, 0.1023063717),
      (f_add_curr_nhood_MFD_pct_i > 0.75310017755) => -0.0746377810,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0635998383, 0.0635998383),
   (c_high_hval > 3.9) => -0.0147931213,
   (c_high_hval = NULL) => 0.0230735910, 0.0230735910),
(r_C21_M_Bureau_ADL_FS_d > 17.5) => -0.0041237927,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0204539868, -0.0024423348);

// Tree: 182 
woFDN_FLA____lgt_182 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37644446705) => 
   map(
   (NULL < c_incollege and c_incollege <= 26.65) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 0.0001601737,
      (k_inq_per_addr_i > 3.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0365790614) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 20565.5) => 0.0658507998,
            (r_A49_Curr_AVM_Chg_1yr_i > 20565.5) => -0.0330740093,
            (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0853604936, 0.0539379371),
         (f_add_curr_nhood_BUS_pct_i > 0.0365790614) => -0.0125810794,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0657553491, 0.0244327984),
      (k_inq_per_addr_i = NULL) => 0.0028071107, 0.0028071107),
   (c_incollege > 26.65) => 0.1853616545,
   (c_incollege = NULL) => -0.0226914284, 0.0036227608),
(f_add_input_mobility_index_i > 0.37644446705) => -0.0224863269,
(f_add_input_mobility_index_i = NULL) => 0.0554971148, -0.0004403909);

// Tree: 183 
woFDN_FLA____lgt_183 := map(
(NULL < c_transport and c_transport <= 26.65) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0113054032,
      (k_inq_adls_per_addr_i > 3.5) => -0.0746471930,
      (k_inq_adls_per_addr_i = NULL) => -0.0124501343, -0.0124501343),
   (f_vardobcountnew_i > 0.5) => 0.0133929743,
   (f_vardobcountnew_i = NULL) => -0.0147970212, -0.0070526986),
(c_transport > 26.65) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0180790922) => 0.1836196646,
      (f_add_curr_nhood_VAC_pct_i > 0.0180790922) => 0.0088883802,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0969419408, 0.0969419408),
   (r_C12_Num_NonDerogs_d > 3.5) => -0.0168858564,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0421187568, 0.0421187568),
(c_transport = NULL) => 0.0208728468, -0.0054406899);

// Tree: 184 
woFDN_FLA____lgt_184 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 92.2) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => 0.0003010417,
   (f_util_adl_count_n > 7.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 3.5) => 0.1740348008,
      (f_rel_homeover100_count_d > 3.5) => 
         map(
         (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.91368439925) => -0.0208880859,
         (f_add_input_nhood_SFD_pct_d > 0.91368439925) => 
            map(
            (NULL < c_hh7p_p and c_hh7p_p <= 1.05) => 0.0193679424,
            (c_hh7p_p > 1.05) => 0.1952105149,
            (c_hh7p_p = NULL) => 0.0970127147, 0.0970127147),
         (f_add_input_nhood_SFD_pct_d = NULL) => 0.0179914072, 0.0179914072),
      (f_rel_homeover100_count_d = NULL) => 0.0424964166, 0.0424964166),
   (f_util_adl_count_n = NULL) => 0.0024583727, 0.0022328118),
(C_RENTOCC_P > 92.2) => -0.0881385249,
(C_RENTOCC_P = NULL) => 0.0203846228, 0.0019409670);

// Tree: 185 
woFDN_FLA____lgt_185 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 5.15) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 109.5) => -0.0167653262,
      (f_curraddrmurderindex_i > 109.5) => 
         map(
         (NULL < c_hval_80k_p and c_hval_80k_p <= 12.35) => 
            map(
            (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 154.5) => 0.2221810172,
            (f_prevaddrcartheftindex_i > 154.5) => 0.0797817885,
            (f_prevaddrcartheftindex_i = NULL) => 0.1379887725, 0.1379887725),
         (c_hval_80k_p > 12.35) => 0.0359405001,
         (c_hval_80k_p = NULL) => 0.0890987256, 0.0890987256),
      (f_curraddrmurderindex_i = NULL) => 0.0433691136, 0.0433691136),
   (c_high_ed > 5.15) => 0.0063527999,
   (c_high_ed = NULL) => -0.0085647266, 0.0075329024),
(r_D31_ALL_Bk_i > 1.5) => -0.0368670362,
(r_D31_ALL_Bk_i = NULL) => 0.0005773431, 0.0034802104);

// Tree: 186 
woFDN_FLA____lgt_186 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 187) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3923820453) => 0.0062483178,
   (f_add_input_mobility_index_i > 0.3923820453) => -0.0295758485,
   (f_add_input_mobility_index_i = NULL) => -0.0136948186, 0.0010414822),
(f_fp_prevaddrcrimeindex_i > 187) => 
   map(
   (NULL < c_food and c_food <= 20.7) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 6.25) => 0.2190539441,
      (c_pop_55_64_p > 6.25) => 0.0587049235,
      (c_pop_55_64_p = NULL) => 0.0995630874, 0.0995630874),
   (c_food > 20.7) => -0.0223864578,
   (c_food = NULL) => 0.0448960499, 0.0448960499),
(f_fp_prevaddrcrimeindex_i = NULL) => 
   map(
   (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 0.0345538053,
   (r_L77_Apartment_i > 0.5) => -0.0805754501,
   (r_L77_Apartment_i = NULL) => -0.0009220699, -0.0009220699), 0.0023216790);

// Tree: 187 
woFDN_FLA____lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 80.45) => -0.0027902085,
   (c_high_hval > 80.45) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 102.5) => 0.0099050990,
      (r_C13_Curr_Addr_LRes_d > 102.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 33.5) => 0.2101553943,
         (c_born_usa > 33.5) => 0.0290256086,
         (c_born_usa = NULL) => 0.0964909539, 0.0964909539),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0431142701, 0.0431142701),
   (c_high_hval = NULL) => -0.0085107823, -0.0005157128),
(f_rel_bankrupt_count_i > 7.5) => -0.0753207951,
(f_rel_bankrupt_count_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.4) => 0.0500857011,
   (c_construction > 7.4) => -0.0644205420,
   (c_construction = NULL) => 0.0093552925, 0.0093552925), -0.0013305282);

// Tree: 188 
woFDN_FLA____lgt_188 := map(
(NULL < c_pop_25_34_p and c_pop_25_34_p <= 17.75) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 120.5) => -0.0053213320,
   (c_span_lang > 120.5) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => 
         map(
         (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.0478124810,
         (f_prevaddrstatus_i > 2.5) => -0.0012537604,
         (f_prevaddrstatus_i = NULL) => 0.0088471649, 0.0162894459),
      (f_inq_Collection_count24_i > 2.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 57762.5) => 0.1875521199,
         (f_curraddrmedianincome_d > 57762.5) => 0.0307470074,
         (f_curraddrmedianincome_d = NULL) => 0.0985187085, 0.0985187085),
      (f_inq_Collection_count24_i = NULL) => 0.0190234704, 0.0190234704),
   (c_span_lang = NULL) => 0.0042822617, 0.0042822617),
(c_pop_25_34_p > 17.75) => -0.0146656843,
(c_pop_25_34_p = NULL) => -0.0229927823, -0.0012641442);

// Tree: 189 
woFDN_FLA____lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 38.5) => -0.0041484169,
(f_phones_per_addr_curr_i > 38.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 7.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 104) => 0.1784071056,
      (c_easiqlife > 104) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.48874413255) => -0.0790266513,
         (f_add_curr_nhood_MFD_pct_i > 0.48874413255) => -0.0514299167,
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0652282840, -0.0652282840),
      (c_easiqlife = NULL) => 0.0188330493, 0.0188330493),
   (f_rel_under25miles_cnt_d > 7.5) => 0.1641337798,
   (f_rel_under25miles_cnt_d = NULL) => 0.0519149120, 0.0519149120),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 26.65) => 0.0292251395,
   (c_rnt750_p > 26.65) => -0.0797309403,
   (c_rnt750_p = NULL) => -0.0120225193, -0.0120225193), -0.0032216803);

// Tree: 190 
woFDN_FLA____lgt_190 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -308170) => -0.0861129103,
(f_addrchangevaluediff_d > -308170) => -0.0043010673,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 51.2) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 63.75) => 
         map(
         (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 1.5) => -0.0158723721,
         (f_inq_Other_count_i > 1.5) => 0.0466048259,
         (f_inq_Other_count_i = NULL) => -0.0047020247, -0.0093356204),
      (c_lowinc > 63.75) => -0.0885352597,
      (c_lowinc = NULL) => -0.0123889503, -0.0123889503),
   (c_hh2_p > 51.2) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 8.55) => 0.0083902937,
      (C_INC_125K_P > 8.55) => 0.2287114789,
      (C_INC_125K_P = NULL) => 0.1185508863, 0.1185508863),
   (c_hh2_p = NULL) => -0.0248476338, -0.0089921472), -0.0057487501);

// Tree: 191 
woFDN_FLA____lgt_191 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 169.5) => -0.0045041248,
(f_fp_prevaddrcrimeindex_i > 169.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 9.5) => -0.0700045477,
   (f_mos_inq_banko_cm_lseen_d > 9.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0315690459,
      (f_assocrisktype_i > 4.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 138.5) => 0.0226592129,
         (c_born_usa > 138.5) => 0.1774516290,
         (c_born_usa = NULL) => 0.0935280299, 0.0935280299),
      (f_assocrisktype_i = NULL) => 0.0423924249, 0.0423924249),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0330170303, 0.0330170303),
(f_fp_prevaddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 85.5) => 0.0493699216,
   (c_many_cars > 85.5) => -0.0797995197,
   (c_many_cars = NULL) => -0.0187193963, -0.0187193963), -0.0015960797);

// Tree: 192 
woFDN_FLA____lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 120) => 0.0735825517,
(r_D32_Mos_Since_Fel_LS_d > 120) => 
   map(
   (NULL < c_unempl and c_unempl <= 169.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => -0.0012918010,
      (f_rel_homeover500_count_d > 19.5) => 0.0733335815,
      (f_rel_homeover500_count_d = NULL) => 0.0484897561, -0.0000783176),
   (c_unempl > 169.5) => 
      map(
      (NULL < c_rental and c_rental <= 190.5) => -0.0482782438,
      (c_rental > 190.5) => 0.0786326261,
      (c_rental = NULL) => -0.0374508829, -0.0374508829),
   (c_unempl = NULL) => 0.0072157756, -0.0020753211),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_med_age and c_med_age <= 36.3) => 0.0635770434,
   (c_med_age > 36.3) => -0.0170792186,
   (c_med_age = NULL) => 0.0198100795, 0.0198100795), -0.0013825569);

// Tree: 193 
woFDN_FLA____lgt_193 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 37.5) => 
   map(
   (NULL < c_rape and c_rape <= 97) => 0.0094933150,
   (c_rape > 97) => -0.0134595932,
   (c_rape = NULL) => -0.0162424720, 0.0000646235),
(f_rel_incomeover25_count_d > 37.5) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 1.35) => 0.0217648122,
   (c_lowrent > 1.35) => -0.1071665462,
   (c_lowrent = NULL) => -0.0569335494, -0.0569335494),
(f_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 92.3) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 174.5) => -0.0564529490,
      (c_relig_indx > 174.5) => 0.0662000477,
      (c_relig_indx = NULL) => -0.0342624397, -0.0342624397),
   (c_sfdu_p > 92.3) => 0.0604752368,
   (c_sfdu_p = NULL) => -0.0188643049, -0.0188643049), -0.0012167999);

// Tree: 194 
woFDN_FLA____lgt_194 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 331.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.8657834043) => 0.0083762163,
   (f_add_input_nhood_MFD_pct_i > 0.8657834043) => -0.0424488576,
   (f_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
         map(
         (NULL < c_food and c_food <= 68.8) => -0.0142457664,
         (c_food > 68.8) => 0.1974217156,
         (c_food = NULL) => -0.0095371506, -0.0062437813),
      (f_srchaddrsrchcount_i > 14.5) => 0.1221549001,
      (f_srchaddrsrchcount_i = NULL) => -0.0021890861, -0.0021890861), 0.0032366700),
(f_M_Bureau_ADL_FS_noTU_d > 331.5) => -0.0294790576,
(f_M_Bureau_ADL_FS_noTU_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.9) => 0.0589777224,
   (c_bigapt_p > 1.9) => -0.0375360757,
   (c_bigapt_p = NULL) => 0.0132606602, 0.0132606602), -0.0027769552);

// Tree: 195 
woFDN_FLA____lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.99435015955) => 0.0100950407,
      (f_add_curr_nhood_MFD_pct_i > 0.99435015955) => -0.0968930807,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0079083082, 0.0061942521),
   (f_inq_Auto_count24_i > 1.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 7.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 225.85) => -0.0410108574,
         (c_cpiall > 225.85) => 0.1347108802,
         (c_cpiall = NULL) => -0.0229513640, -0.0229513640),
      (k_inq_per_addr_i > 7.5) => -0.1140826578,
      (k_inq_per_addr_i = NULL) => -0.0318094868, -0.0318094868),
   (f_inq_Auto_count24_i = NULL) => 0.0074343086, 0.0041043197),
(c_hval_80k_p > 40.05) => -0.1105039375,
(c_hval_80k_p = NULL) => 0.0206650260, 0.0034441139);

// Tree: 196 
woFDN_FLA____lgt_196 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 22.05) => 0.0618038086,
      (c_white_col > 22.05) => -0.0561494259,
      (c_white_col = NULL) => -0.0433927282, -0.0433927282),
   (f_mos_inq_banko_om_lseen_d > 5.5) => 
      map(
      (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 8051) => 0.0005449385,
      (f_liens_unrel_CJ_total_amt_i > 8051) => 0.0695670226,
      (f_liens_unrel_CJ_total_amt_i = NULL) => 0.0015625070, 0.0015625070),
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0008508523, -0.0008508523),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0756689056,
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 15) => -0.0341838256,
   (c_retail > 15) => 0.0660254446,
   (c_retail = NULL) => -0.0022700453, -0.0022700453), -0.0023105871);

// Tree: 197 
woFDN_FLA____lgt_197 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0870049810,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 68.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 12.45) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 8.45) => -0.0328465333,
         (C_INC_50K_P > 8.45) => 0.1189927676,
         (C_INC_50K_P = NULL) => 0.0449929244, 0.0449929244),
      (C_RENTOCC_P > 12.45) => -0.0333875599,
      (C_RENTOCC_P = NULL) => -0.0194368600, -0.0194368600),
   (r_C13_max_lres_d > 68.5) => 0.0050647615,
   (r_C13_max_lres_d = NULL) => 0.0056138595, 0.0002202018),
(C_INC_100K_P = NULL) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.206052191) => 0.1534254462,
   (f_add_curr_mobility_index_i > 0.206052191) => -0.1036584595,
   (f_add_curr_mobility_index_i = NULL) => -0.0080963670, 0.0021441046), 0.0007335208);

// Tree: 198 
woFDN_FLA____lgt_198 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 39.25) => 0.0042281011,
(c_famotf18_p > 39.25) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.26517838485) => 0.0520273784,
      (f_add_curr_nhood_MFD_pct_i > 0.26517838485) => -0.0262928297,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0048996341, 0.0048996341),
   (r_I60_Inq_Count12_i > 0.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 20.5) => -0.0025602485,
      (c_many_cars > 20.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.05000649505) => -0.1379245098,
         (f_add_curr_nhood_BUS_pct_i > 0.05000649505) => -0.1059715399,
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.1210604424, -0.1210604424),
      (c_many_cars = NULL) => -0.0799046864, -0.0799046864),
   (r_I60_Inq_Count12_i = NULL) => -0.0292264418, -0.0292264418),
(c_famotf18_p = NULL) => -0.0307811128, 0.0023069897);

// Tree: 199 
woFDN_FLA____lgt_199 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 17.75) => -0.0091327604,
   (C_INC_75K_P > 17.75) => 0.1319005052,
   (C_INC_75K_P = NULL) => 0.0606992449, 0.0606992449),
(r_D33_Eviction_Recency_d > 30) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 27.65) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0095471816,
      (f_hh_collections_ct_i > 1.5) => 0.0144507988,
      (f_hh_collections_ct_i = NULL) => -0.0030941438, -0.0030941438),
   (C_INC_25K_P > 27.65) => 0.0812048476,
   (C_INC_25K_P = NULL) => -0.0379222444, -0.0032176437),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.35) => -0.0500437569,
   (c_pop_35_44_p > 14.35) => 0.0406445739,
   (c_pop_35_44_p = NULL) => -0.0012596893, -0.0012596893), -0.0026719468);

// Tree: 200 
woFDN_FLA____lgt_200 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 12.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 32.5) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 22.85) => -0.0031103718,
      (c_hval_40k_p > 22.85) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 71.35) => 0.1204529974,
         (c_low_ed > 71.35) => -0.0428325878,
         (c_low_ed = NULL) => 0.0631460372, 0.0631460372),
      (c_hval_40k_p = NULL) => -0.0402194160, -0.0027611035),
   (f_rel_homeover300_count_d > 32.5) => -0.1049485849,
   (f_rel_homeover300_count_d = NULL) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 8.75) => -0.0506847749,
      (c_pop_12_17_p > 8.75) => 0.0855047324,
      (c_pop_12_17_p = NULL) => -0.0152632887, -0.0152632887), -0.0034878418),
(f_inq_HighRiskCredit_count_i > 12.5) => -0.0706069146,
(f_inq_HighRiskCredit_count_i = NULL) => -0.0108764787, -0.0040420043);

// Tree: 201 
woFDN_FLA____lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.0142192506,
   (f_hh_age_18_plus_d > 1.5) => -0.0130602847,
   (f_hh_age_18_plus_d = NULL) => -0.0334357657, -0.0066123741),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 5.15) => -0.0000432701,
   (c_finance > 5.15) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 9.5) => 
         map(
         (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => 0.0618993231,
         (f_crim_rel_under500miles_cnt_i > 0.5) => 0.2343833830,
         (f_crim_rel_under500miles_cnt_i = NULL) => 0.1366873334, 0.1366873334),
      (f_rel_homeover150_count_d > 9.5) => -0.0615777549,
      (f_rel_homeover150_count_d = NULL) => 0.0995519677, 0.0995519677),
   (c_finance = NULL) => 0.0895333244, 0.0391090933),
(r_L70_Add_Standardized_i = NULL) => -0.0028133653, -0.0028133653);

// Tree: 202 
woFDN_FLA____lgt_202 := map(
(NULL < c_bel_edu and c_bel_edu <= 196.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 5.25) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 60062.5) => 0.1116879828,
      (r_L80_Inp_AVM_AutoVal_d > 60062.5) => -0.0207956053,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 108.5) => -0.0524445579,
         (f_curraddrmurderindex_i > 108.5) => 0.0803875696,
         (f_curraddrmurderindex_i = NULL) => 0.0340017473, 0.0340017473), 0.0300699655),
   (c_high_ed > 5.25) => -0.0001571677,
   (c_high_ed = NULL) => 0.0009934739, 0.0009934739),
(c_bel_edu > 196.5) => 
   map(
   (NULL < r_wealth_index_d and r_wealth_index_d <= 3.5) => -0.1171370019,
   (r_wealth_index_d > 3.5) => 0.0087722457,
   (r_wealth_index_d = NULL) => -0.0651744553, -0.0651744553),
(c_bel_edu = NULL) => 0.0202063851, 0.0007635201);

// Tree: 203 
woFDN_FLA____lgt_203 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 122.5) => -0.0039228507,
   (f_addrchangecrimediff_i > 122.5) => 0.0895389709,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < c_wholesale and c_wholesale <= 21.5) => -0.0164185881,
      (c_wholesale > 21.5) => 0.1219250791,
      (c_wholesale = NULL) => -0.0326350641, -0.0142594029), -0.0058422385),
(r_C13_Curr_Addr_LRes_d > 310.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 40.3) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 19.95) => 0.0156794932,
      (c_pop_25_34_p > 19.95) => 0.1787719031,
      (c_pop_25_34_p = NULL) => 0.0315037959, 0.0315037959),
   (c_hval_750k_p > 40.3) => 0.1840165369,
   (c_hval_750k_p = NULL) => 0.0461726310, 0.0461726310),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0067740818, -0.0027200471);

// Tree: 204 
woFDN_FLA____lgt_204 := map(
(NULL < c_fammar_p and c_fammar_p <= 30.25) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 45) => -0.1514920204,
      (f_mos_inq_banko_cm_lseen_d > 45) => -0.0540431997,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0867357073, -0.0867357073),
   (f_sourcerisktype_i > 5.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 136) => -0.0616891052,
      (f_curraddrcrimeindex_i > 136) => 0.0679464805,
      (f_curraddrcrimeindex_i = NULL) => 0.0110887675, 0.0110887675),
   (f_sourcerisktype_i = NULL) => -0.0452784949, -0.0452784949),
(c_fammar_p > 30.25) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 0.0025316839,
   (f_assocsuspicousidcount_i > 16.5) => 0.0760958934,
   (f_assocsuspicousidcount_i = NULL) => 0.0023697717, 0.0029242270),
(c_fammar_p = NULL) => -0.0068736990, 0.0016507880);

// Tree: 205 
woFDN_FLA____lgt_205 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 549) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 101.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
         map(
         (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 7.5) => 0.0456219745,
         (f_rel_ageover30_count_d > 7.5) => -0.0653260611,
         (f_rel_ageover30_count_d = NULL) => -0.0206888282, -0.0206888282),
      (f_phones_per_addr_curr_i > 9.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 14.75) => -0.0288779444,
         (c_pop_25_34_p > 14.75) => 0.1027950077,
         (c_pop_25_34_p = NULL) => 0.0525032552, 0.0525032552),
      (f_phones_per_addr_curr_i = NULL) => -0.0027030602, -0.0027030602),
   (c_many_cars > 101.5) => 0.0614888425,
   (c_many_cars = NULL) => 0.0240595340, 0.0240595340),
(r_I60_inq_hiRiskCred_recency_d > 549) => -0.0008129351,
(r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0227956721, 0.0008843825);

// Tree: 206 
woFDN_FLA____lgt_206 := map(
(NULL < f_mos_liens_rel_OT_fseen_d and f_mos_liens_rel_OT_fseen_d <= 42.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 26.05) => -0.0042965148,
   (C_INC_25K_P > 26.05) => 0.0752515035,
   (C_INC_25K_P = NULL) => 0.0146035329, -0.0031518339),
(f_mos_liens_rel_OT_fseen_d > 42.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.55) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 82.5) => 0.1141428265,
      (c_rest_indx > 82.5) => -0.0952705860,
      (c_rest_indx = NULL) => -0.0211033358, -0.0211033358),
   (c_bigapt_p > 1.55) => -0.1312775690,
   (c_bigapt_p = NULL) => -0.0673054336, -0.0673054336),
(f_mos_liens_rel_OT_fseen_d = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 138.5) => 0.0310051449,
   (c_span_lang > 138.5) => -0.0793829536,
   (c_span_lang = NULL) => -0.0073240560, -0.0073240560), -0.0044730948);

// Tree: 207 
woFDN_FLA____lgt_207 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 3.5) => 0.0003667520,
(f_srchfraudsrchcountyr_i > 3.5) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 20.85) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 40.5) => 0.0212583932,
      (f_prevaddrmurderindex_i > 40.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 86) => -0.1562870312,
         (c_robbery > 86) => -0.0572147525,
         (c_robbery = NULL) => -0.0933543259, -0.0933543259),
      (f_prevaddrmurderindex_i = NULL) => -0.0655198084, -0.0655198084),
   (c_pop_25_34_p > 20.85) => 0.0568642882,
   (c_pop_25_34_p = NULL) => -0.0397547354, -0.0397547354),
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 0.1) => 0.0485077459,
   (c_hval_100k_p > 0.1) => -0.0495505997,
   (c_hval_100k_p = NULL) => -0.0047848332, -0.0047848332), -0.0005530240);

// Tree: 208 
woFDN_FLA____lgt_208 := map(
(NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => -0.0025291006,
   (f_rel_ageover50_count_d > 4.5) => -0.0730618801,
   (f_rel_ageover50_count_d = NULL) => 0.0430522082, -0.0032168230),
(f_srchunvrfddobcount_i > 0.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 45.55) => 0.1617701610,
   (c_oldhouse > 45.55) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0241804296,
      (f_srchfraudsrchcountmo_i > 0.5) => 0.0804484870,
      (f_srchfraudsrchcountmo_i = NULL) => -0.0072501842, -0.0072501842),
   (c_oldhouse = NULL) => 0.0315275509, 0.0315275509),
(f_srchunvrfddobcount_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 361.5) => -0.0380816323,
   (c_families > 361.5) => 0.0589085111,
   (c_families = NULL) => 0.0162038957, 0.0162038957), -0.0018296950);

// Tree: 209 
woFDN_FLA____lgt_209 := map(
(NULL < c_hh2_p and c_hh2_p <= 17.65) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.12860321405) => 
      map(
      (NULL < c_bargains and c_bargains <= 136.5) => -0.0260865212,
      (c_bargains > 136.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 5.95) => 0.1318930331,
         (c_incollege > 5.95) => -0.0278677110,
         (c_incollege = NULL) => 0.0598580547, 0.0598580547),
      (c_bargains = NULL) => 0.0067660129, 0.0067660129),
   (f_add_input_nhood_BUS_pct_i > 0.12860321405) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.178974359) => 0.1882975691,
      (f_add_input_nhood_BUS_pct_i > 0.178974359) => 0.0015221785,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0721323872, 0.0721323872),
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0210594601, 0.0210594601),
(c_hh2_p > 17.65) => -0.0004920895,
(c_hh2_p = NULL) => 0.0094724257, 0.0010601339);

// Tree: 210 
woFDN_FLA____lgt_210 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0003303250,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 10.5) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 21.75) => 0.0303064554,
         (c_lowinc > 21.75) => -0.0693260591,
         (c_lowinc = NULL) => -0.0344872387, -0.0344872387),
      (f_rel_homeover200_count_d > 10.5) => -0.1334871038,
      (f_rel_homeover200_count_d = NULL) => -0.0498632395, -0.0498632395),
   (f_inq_QuizProvider_count_i > 1.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 23.95) => -0.0383194300,
      (c_rnt1000_p > 23.95) => 0.0964775490,
      (c_rnt1000_p = NULL) => 0.0148899038, 0.0148899038),
   (f_inq_QuizProvider_count_i = NULL) => -0.0308474412, -0.0308474412),
(f_srchfraudsrchcount_i = NULL) => 0.0105735811, -0.0008307010);

// Tree: 211 
woFDN_FLA____lgt_211 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 9.5) => 0.0021846517,
   (k_inq_per_addr_i > 9.5) => 0.0500497808,
   (k_inq_per_addr_i = NULL) => 0.0032330202, 0.0032330202),
(r_D34_unrel_liens_ct_i > 0.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 18.5) => 
      map(
      (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0252007840,
      (f_vardobcountnew_i > 0.5) => 
         map(
         (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 0.0046140059,
         (r_I61_inq_collection_count12_i > 0.5) => 0.1241637092,
         (r_I61_inq_collection_count12_i = NULL) => 0.0406030169, 0.0406030169),
      (f_vardobcountnew_i = NULL) => -0.0115291100, -0.0115291100),
   (f_rel_educationover8_count_d > 18.5) => -0.0626124279,
   (f_rel_educationover8_count_d = NULL) => -0.0218454198, -0.0218454198),
(r_D34_unrel_liens_ct_i = NULL) => -0.0080602454, -0.0003681156);

// Tree: 212 
woFDN_FLA____lgt_212 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 20.5) => -0.0005924082,
(f_srchaddrsrchcount_i > 20.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 161.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 10.2) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 62.3) => 0.0589597464,
         (C_OWNOCC_P > 62.3) => 0.1885120399,
         (C_OWNOCC_P = NULL) => 0.1202026487, 0.1202026487),
      (c_high_hval > 10.2) => -0.0115147440,
      (c_high_hval = NULL) => 0.0790409635, 0.0790409635),
   (c_new_homes > 161.5) => -0.0461437735,
   (c_new_homes = NULL) => 0.0474522916, 0.0474522916),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 3.25) => -0.0527287945,
   (c_hval_200k_p > 3.25) => 0.0507079796,
   (c_hval_200k_p = NULL) => 0.0001561727, 0.0001561727), 0.0002312918);

// Tree: 213 
woFDN_FLA____lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125002.5) => 
   map(
   (NULL < c_families and c_families <= 1369) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 11.55) => 0.0131651050,
      (c_femdiv_p > 11.55) => 0.1344234340,
      (c_femdiv_p = NULL) => 0.0175756956, 0.0175756956),
   (c_families > 1369) => 0.1842831327,
   (c_families = NULL) => 0.0231734270, 0.0231734270),
(r_A46_Curr_AVM_AutoVal_d > 125002.5) => -0.0059739877,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 155.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 87) => -0.0925043367,
      (c_rich_wht > 87) => 0.0099633144,
      (c_rich_wht = NULL) => -0.0420076885, -0.0420076885),
   (f_mos_liens_unrel_CJ_fseen_d > 155.5) => 0.0071319546,
   (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0185050974, 0.0049851873), 0.0031725063);

// Tree: 214 
woFDN_FLA____lgt_214 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 107.5) => 0.0049141737,
      (c_blue_empl > 107.5) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 1.6) => 0.2294075969,
         (c_lowrent > 1.6) => 0.0484056316,
         (c_lowrent = NULL) => 0.0952046189, 0.0952046189),
      (c_blue_empl = NULL) => 0.0374880929, 0.0374880929),
   (r_I60_inq_recency_d > 2) => 0.0015858777,
   (r_I60_inq_recency_d = NULL) => 0.0036932004, 0.0036932004),
(f_inq_PrepaidCards_count24_i > 1.5) => 0.0955371956,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 7.65) => 0.0243009472,
   (c_pop_65_74_p > 7.65) => -0.0897926789,
   (c_pop_65_74_p = NULL) => -0.0182713013, -0.0182713013), 0.0038071346);

// Tree: 215 
woFDN_FLA____lgt_215 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125594) => 
   map(
   (NULL < c_assault and c_assault <= 74.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 5.45) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 118222) => 
            map(
            (NULL < c_pop_65_74_p and c_pop_65_74_p <= 5.15) => 0.3000981248,
            (c_pop_65_74_p > 5.15) => 0.0927393534,
            (c_pop_65_74_p = NULL) => 0.1805788330, 0.1805788330),
         (f_prevaddrmedianvalue_d > 118222) => 0.0656548731,
         (f_prevaddrmedianvalue_d = NULL) => 0.0913921207, 0.0913921207),
      (c_bigapt_p > 5.45) => -0.0232369554,
      (c_bigapt_p = NULL) => 0.0659960905, 0.0659960905),
   (c_assault > 74.5) => -0.0008999997,
   (c_assault = NULL) => 0.0271773227, 0.0271773227),
(r_A46_Curr_AVM_AutoVal_d > 125594) => -0.0019234514,
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0043095683, 0.0015736198);

// Tree: 216 
woFDN_FLA____lgt_216 := map(
(NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 3.5) => 
   map(
   (NULL < c_trailer and c_trailer <= 193.5) => -0.0010748599,
   (c_trailer > 193.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 5.5) => 
         map(
         (NULL < c_hval_60k_p and c_hval_60k_p <= 6.25) => 0.3254178501,
         (c_hval_60k_p > 6.25) => 0.0230346804,
         (c_hval_60k_p = NULL) => 0.1492089527, 0.1492089527),
      (f_rel_incomeover50_count_d > 5.5) => -0.0652987857,
      (f_rel_incomeover50_count_d = NULL) => 0.0684078315, 0.0684078315),
   (c_trailer = NULL) => 0.0408818691, 0.0010663511),
(f_inq_Communications_count24_i > 3.5) => -0.0785985231,
(f_inq_Communications_count24_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4) => 0.0394662336,
   (c_construction > 4) => -0.0466821356,
   (c_construction = NULL) => -0.0075793297, -0.0075793297), 0.0005353071);

// Tree: 217 
woFDN_FLA____lgt_217 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -33052.5) => -0.0586250949,
(f_addrchangeincomediff_d > -33052.5) => 0.0011578504,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 30.65) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 47.25) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 15.5) => 0.0443629825,
         (c_born_usa > 15.5) => -0.0208320768,
         (c_born_usa = NULL) => -0.0140905278, -0.0140905278),
      (c_hh2_p > 47.25) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 112) => -0.0035140416,
         (f_curraddrcrimeindex_i > 112) => 0.2003422140,
         (f_curraddrcrimeindex_i = NULL) => 0.0662262564, 0.0662262564),
      (c_hh2_p = NULL) => -0.0080271590, -0.0080271590),
   (c_hval_150k_p > 30.65) => 0.1102347091,
   (c_hval_150k_p = NULL) => 0.0196492724, -0.0021399562), -0.0002533468);

// Tree: 218 
woFDN_FLA____lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_exp_homes and c_exp_homes <= 188.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 174.5) => 0.0018953524,
      (c_no_car > 174.5) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.8178434449) => 0.1180294119,
         (f_add_input_nhood_MFD_pct_i > 0.8178434449) => 0.0416338755,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0774930048, 0.0774930048),
      (c_no_car = NULL) => 0.0206687694, 0.0206687694),
   (c_exp_homes > 188.5) => 0.3185703899,
   (c_exp_homes = NULL) => 0.0630046964, 0.0480907663),
(f_rel_incomeover25_count_d > 1.5) => -0.0022677735,
(f_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 12.95) => -0.0300043154,
   (c_vacant_p > 12.95) => 0.0620767771,
   (c_vacant_p = NULL) => -0.0115367982, -0.0115367982), 0.0006040743);

// Tree: 219 
woFDN_FLA____lgt_219 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 15.45) => 
   map(
   (NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 4533) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 13.5) => 
         map(
         (NULL < f_divrisktype_i and f_divrisktype_i <= 3.5) => 0.0000757804,
         (f_divrisktype_i > 3.5) => -0.0523188087,
         (f_divrisktype_i = NULL) => -0.0007542243, -0.0007542243),
      (r_L79_adls_per_addr_curr_i > 13.5) => 0.0685978481,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0002460459, -0.0002460459),
   (f_liens_unrel_ST_total_amt_i > 4533) => 0.1074792690,
   (f_liens_unrel_ST_total_amt_i = NULL) => 
      map(
      (NULL < c_finance and c_finance <= 2.55) => 0.0501559050,
      (c_finance > 2.55) => -0.0473855038,
      (c_finance = NULL) => -0.0004762767, -0.0004762767), 0.0002145235),
(c_femdiv_p > 15.45) => 0.1161749810,
(c_femdiv_p = NULL) => 0.0011850365, 0.0008761599);

// Tree: 220 
woFDN_FLA____lgt_220 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 39.5) => -0.0915336121,
(f_mos_inq_banko_am_lseen_d > 39.5) => 
   map(
   (NULL < c_food and c_food <= 62.65) => -0.0034061163,
   (c_food > 62.65) => 
      map(
      (NULL < c_no_car and c_no_car <= 166.5) => 
         map(
         (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 2.5) => 0.1687200815,
         (f_rel_under100miles_cnt_d > 2.5) => 0.0532794671,
         (f_rel_under100miles_cnt_d = NULL) => 0.0749627571, 0.0749627571),
      (c_no_car > 166.5) => -0.0482139941,
      (c_no_car = NULL) => 0.0461552911, 0.0461552911),
   (c_food = NULL) => -0.0296923718, -0.0019267729),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 23.3) => -0.0511431776,
   (c_lowinc > 23.3) => 0.0712780883,
   (c_lowinc = NULL) => 0.0232697487, 0.0232697487), -0.0033988105);

// Tree: 221 
woFDN_FLA____lgt_221 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 198.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 13.95) => 0.0057197997,
   (C_INC_25K_P > 13.95) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 191.5) => -0.0210253163,
         (c_sub_bus > 191.5) => 0.1081244761,
         (c_sub_bus = NULL) => -0.0108292801, -0.0108292801),
      (r_I60_Inq_Count12_i > 0.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 10.5) => -0.0430141496,
         (f_srchaddrsrchcount_i > 10.5) => -0.1265276618,
         (f_srchaddrsrchcount_i = NULL) => -0.0543730199, -0.0543730199),
      (r_I60_Inq_Count12_i = NULL) => -0.0259515558, -0.0259515558),
   (C_INC_25K_P = NULL) => 0.0067442895, 0.0010041787),
(f_curraddrburglaryindex_i > 198.5) => 0.1230625812,
(f_curraddrburglaryindex_i = NULL) => -0.0274500713, 0.0011809359);

// Tree: 222 
woFDN_FLA____lgt_222 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 55.5) => -0.0037652774,
(f_addrchangecrimediff_i > 55.5) => 
   map(
   (NULL < c_health and c_health <= 8.6) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 12.5) => -0.0701048568,
      (f_rel_count_i > 12.5) => 0.0682433262,
      (f_rel_count_i = NULL) => -0.0104720193, -0.0104720193),
   (c_health > 8.6) => 0.1147865261,
   (c_health = NULL) => 0.0472051714, 0.0472051714),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 984.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 61.5) => -0.1007587598,
      (r_I60_inq_hiRiskCred_recency_d > 61.5) => -0.0339946914,
      (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0491879034, -0.0330743704),
   (c_popover18 > 984.5) => 0.0152290832,
   (c_popover18 = NULL) => 0.0165023526, 0.0009086853), -0.0018026126);

// Tree: 223 
woFDN_FLA____lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 44948.5) => 
   map(
   (NULL < c_retail and c_retail <= 22.3) => -0.0766330593,
   (c_retail > 22.3) => 0.0748525880,
   (c_retail = NULL) => -0.0519098825, -0.0519098825),
(r_A46_Curr_AVM_AutoVal_d > 44948.5) => 0.0025006563,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => -0.0127907501,
   (f_rel_under25miles_cnt_d > 5.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 10.05) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 155.5) => 0.0799556339,
         (c_old_homes > 155.5) => -0.0114168982,
         (c_old_homes = NULL) => 0.0505566241, 0.0505566241),
      (c_newhouse > 10.05) => -0.0020541893,
      (c_newhouse = NULL) => 0.0001550494, 0.0200818322),
   (f_rel_under25miles_cnt_d = NULL) => -0.0017384411, 0.0004436272), 0.0001443809);

// Tree: 224 
woFDN_FLA____lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 5.95) => -0.0354257601,
      (C_INC_150K_P > 5.95) => 0.0926045382,
      (C_INC_150K_P = NULL) => 0.0231412912, 0.0231412912),
   (c_hval_20k_p > 0.65) => 0.1660910793,
   (c_hval_20k_p = NULL) => 0.0531727593, 0.0531727593),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 20.5) => -0.0003244956,
   (f_srchaddrsrchcount_i > 20.5) => 0.0422553296,
   (f_srchaddrsrchcount_i = NULL) => 0.0004382110, 0.0004382110),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 71) => -0.0339614493,
   (c_serv_empl > 71) => 0.0634759569,
   (c_serv_empl = NULL) => 0.0181043403, 0.0181043403), 0.0016712481);

// Tree: 225 
woFDN_FLA____lgt_225 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 43340) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 2.15) => -0.0878406302,
   (C_INC_150K_P > 2.15) => 0.0186399501,
   (C_INC_150K_P = NULL) => -0.0233824863, -0.0233824863),
(r_A46_Curr_AVM_AutoVal_d > 43340) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0111790444,
   (f_srchunvrfddobcount_i > 0.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 53) => -0.0389661740,
      (c_bargains > 53) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 7.2) => 0.2594863216,
         (C_INC_35K_P > 7.2) => 0.0342126424,
         (C_INC_35K_P = NULL) => 0.1261243035, 0.1261243035),
      (c_bargains = NULL) => 0.0769681501, 0.0769681501),
   (f_srchunvrfddobcount_i = NULL) => 0.0129077809, 0.0129077809),
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0066024421, 0.0034181694);

// Tree: 226 
woFDN_FLA____lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 240.5) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 94.5) => -0.1350170090,
   (c_apt20 > 94.5) => 0.0059649923,
   (c_apt20 = NULL) => -0.0754148621, -0.0754148621),
(r_D32_Mos_Since_Fel_LS_d > 240.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 16.55) => 0.0084889493,
      (c_hval_80k_p > 16.55) => -0.0312894395,
      (c_hval_80k_p = NULL) => 0.0047089460, 0.0047089460),
   (c_asian_lang > 181.5) => -0.0292620745,
   (c_asian_lang = NULL) => 0.0138113574, 0.0000229535),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.35) => -0.0602902183,
   (c_pop_55_64_p > 9.35) => 0.0328080620,
   (c_pop_55_64_p = NULL) => -0.0036500058, -0.0036500058), -0.0007592001);

// Tree: 227 
woFDN_FLA____lgt_227 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 26965.5) => 0.0012745574,
(f_addrchangeincomediff_d > 26965.5) => -0.0619191039,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 112.65) => 0.0003113074,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 112.65) => 
      map(
      (NULL < c_exp_homes and c_exp_homes <= 169.5) => 
         map(
         (NULL < c_hval_1000k_p and c_hval_1000k_p <= 0.05) => 
            map(
            (NULL < C_INC_35K_P and C_INC_35K_P <= 7.35) => 0.2462921237,
            (C_INC_35K_P > 7.35) => 0.0261885844,
            (C_INC_35K_P = NULL) => 0.1015665088, 0.1015665088),
         (c_hval_1000k_p > 0.05) => -0.0958856331,
         (c_hval_1000k_p = NULL) => 0.0363529573, 0.0363529573),
      (c_exp_homes > 169.5) => 0.2719996792,
      (c_exp_homes = NULL) => 0.0885318743, 0.0885318743),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0044781673, 0.0053407455), 0.0012168720);

// Tree: 228 
woFDN_FLA____lgt_228 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < c_murders and c_murders <= 44.5) => 0.1377658404,
   (c_murders > 44.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 192.5) => 0.0880038481,
      (f_M_Bureau_ADL_FS_noTU_d > 192.5) => -0.0856425453,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0205251478, -0.0205251478),
   (c_murders = NULL) => 0.0231413317, 0.0231413317),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 4.25) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 40.5) => -0.0126830640,
      (k_comb_age_d > 40.5) => 0.0316652932,
      (k_comb_age_d = NULL) => 0.0087315981, 0.0087315981),
   (c_hh5_p > 4.25) => -0.0148087955,
   (c_hh5_p = NULL) => -0.0052623444, -0.0054355849),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0159122102, -0.0050377182);

// Tree: 229 
woFDN_FLA____lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 297159) => -0.0129471771,
   (r_L80_Inp_AVM_AutoVal_d > 297159) => 
      map(
      (NULL < c_finance and c_finance <= 1.95) => 0.0596160989,
      (c_finance > 1.95) => -0.0175284359,
      (c_finance = NULL) => 0.0144631569, 0.0144631569),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 7971) => -0.0134807113,
      (r_A49_Curr_AVM_Chg_1yr_i > 7971) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 68.5) => 0.2229208517,
         (c_mort_indx > 68.5) => 0.0332487667,
         (c_mort_indx = NULL) => 0.0755862857, 0.0755862857),
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0030019082, 0.0051414731), -0.0008453758),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0628985563,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0304392270, -0.0036617953);

// Tree: 230 
woFDN_FLA____lgt_230 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 189) => 0.0008865777,
         (f_fp_prevaddrcrimeindex_i > 189) => 0.0698313419,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0023768514, 0.0023768514),
      (f_fp_prevaddrcrimeindex_i > 197.5) => -0.0904659197,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0018442638, 0.0018442638),
   (f_bus_addr_match_count_d > 52.5) => 0.1101225193,
   (f_bus_addr_match_count_d = NULL) => 0.0024359007, 0.0024359007),
(f_inq_count24_i > 14.5) => -0.0911487110,
(f_inq_count24_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 8.65) => -0.0589052276,
   (c_famotf18_p > 8.65) => 0.0549401783,
   (c_famotf18_p = NULL) => -0.0014960058, -0.0014960058), 0.0016618151);

// Tree: 231 
woFDN_FLA____lgt_231 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 25.05) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0036924408,
   (f_srchvelocityrisktype_i > 6.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 12.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 30.5) => -0.0639414657,
         (f_mos_inq_banko_cm_fseen_d > 30.5) => 0.0657631844,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0474673144, 0.0474673144),
      (f_rel_homeover200_count_d > 12.5) => -0.0747599740,
      (f_rel_homeover200_count_d = NULL) => 0.0302708344, 0.0302708344),
   (f_srchvelocityrisktype_i = NULL) => 0.0258179318, -0.0020271199),
(c_pop_35_44_p > 25.05) => 
   map(
   (NULL < c_med_yearblt and c_med_yearblt <= 1953.5) => 0.1623200741,
   (c_med_yearblt > 1953.5) => 0.0193015077,
   (c_med_yearblt = NULL) => 0.0548312774, 0.0548312774),
(c_pop_35_44_p = NULL) => -0.0155220696, -0.0008942969);

// Tree: 232 
woFDN_FLA____lgt_232 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 2.25) => -0.1306921303,
(c_pop_35_44_p > 2.25) => 
   map(
   (NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 52.5) => 0.1255741847,
   (f_mos_liens_unrel_FT_fseen_d > 52.5) => 
      map(
      (NULL < c_rnt1500_p and c_rnt1500_p <= 6.15) => 
         map(
         (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 23.5) => 0.0055915598,
         (f_rel_homeover200_count_d > 23.5) => 0.1063613412,
         (f_rel_homeover200_count_d = NULL) => -0.0004953068, 0.0069148314),
      (c_rnt1500_p > 6.15) => -0.0168175857,
      (c_rnt1500_p = NULL) => -0.0004299374, -0.0004299374),
   (f_mos_liens_unrel_FT_fseen_d = NULL) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.35) => -0.0597827423,
      (c_pop_55_64_p > 9.35) => 0.0416100456,
      (c_pop_55_64_p = NULL) => 0.0029842217, 0.0029842217), 0.0001224491),
(c_pop_35_44_p = NULL) => -0.0004058061, -0.0007557562);

// Tree: 233 
woFDN_FLA____lgt_233 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.35) => 
   map(
   (NULL < c_business and c_business <= 371.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 26.5) => -0.0009376187,
      (f_rel_homeover200_count_d > 26.5) => -0.0621699231,
      (f_rel_homeover200_count_d = NULL) => 
         map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 7.5) => -0.0532236196,
         (f_sourcerisktype_i > 7.5) => 
            map(
            (NULL < c_asian_lang and c_asian_lang <= 153.5) => 0.1530557805,
            (c_asian_lang > 153.5) => -0.0483154315,
            (c_asian_lang = NULL) => 0.0513732873, 0.0513732873),
         (f_sourcerisktype_i = NULL) => -0.0095493442, -0.0048617085), -0.0019157989),
   (c_business > 371.5) => -0.0650106661,
   (c_business = NULL) => -0.0043484213, -0.0043484213),
(c_hh6_p > 17.35) => -0.1131321556,
(c_hh6_p = NULL) => -0.0042892458, -0.0049217295);

// Tree: 234 
woFDN_FLA____lgt_234 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 146.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 185.5) => -0.0453609146,
      (c_unempl > 185.5) => 0.0776933626,
      (c_unempl = NULL) => 0.0052085688, -0.0412121428),
   (r_C13_max_lres_d > 146.5) => 
      map(
      (NULL < c_child and c_child <= 35.85) => 0.0002865210,
      (c_child > 35.85) => 0.1751754248,
      (c_child = NULL) => -0.0384455679, 0.0023328704),
   (r_C13_max_lres_d = NULL) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 9.95) => -0.0392929151,
      (C_INC_125K_P > 9.95) => 0.0809606319,
      (C_INC_125K_P = NULL) => 0.0051486131, 0.0051486131), -0.0189215452),
(f_util_add_curr_conv_n > 0.5) => 0.0085468455,
(f_util_add_curr_conv_n = NULL) => -0.0038718554, -0.0038718554);

// Tree: 235 
woFDN_FLA____lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.09970357025) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 2.75) => 0.0299711412,
      (c_low_hval > 2.75) => -0.0282900720,
      (c_low_hval = NULL) => 0.0760760666, 0.0109825088),
   (f_add_curr_nhood_VAC_pct_i > 0.09970357025) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 11.5) => 0.1668486261,
      (r_C13_Curr_Addr_LRes_d > 11.5) => 0.0386198535,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0763341984, 0.0763341984),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0198098085, 0.0198098085),
(f_hh_members_ct_d > 1.5) => -0.0062945972,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0575566429,
   (c_pop_35_44_p > 15.55) => 0.0589373339,
   (c_pop_35_44_p = NULL) => -0.0039694136, -0.0039694136), -0.0008235013);

// Tree: 236 
woFDN_FLA____lgt_236 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.25) => -0.0421002435,
(c_pop_45_54_p > 7.25) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => -0.0003835432,
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 33.5) => 0.1161763256,
      (f_prevaddrmurderindex_i > 33.5) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 102) => -0.0359114675,
         (c_cartheft > 102) => 
            map(
            (NULL < c_hval_150k_p and c_hval_150k_p <= 12.35) => 0.0130849836,
            (c_hval_150k_p > 12.35) => 0.1365804598,
            (c_hval_150k_p = NULL) => 0.0485777779, 0.0485777779),
         (c_cartheft = NULL) => 0.0102396472, 0.0102396472),
      (f_prevaddrmurderindex_i = NULL) => 0.0274185680, 0.0274185680),
   (f_rel_felony_count_i = NULL) => -0.0054563329, 0.0008868436),
(c_pop_45_54_p = NULL) => 0.0081743997, -0.0015918898);

// Tree: 237 
woFDN_FLA____lgt_237 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => -0.0018587199,
   (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0814006401,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0014579774, -0.0014579774),
(r_D33_eviction_count_i > 1.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 161.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 102) => -0.0239830788,
      (r_A50_pb_average_dollars_d > 102) => -0.1154942677,
      (r_A50_pb_average_dollars_d = NULL) => -0.0665578030, -0.0665578030),
   (c_span_lang > 161.5) => 0.0484545759,
   (c_span_lang = NULL) => -0.0411592360, -0.0411592360),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.01602086255) => -0.0503167838,
   (f_add_input_nhood_VAC_pct_i > 0.01602086255) => 0.0427394410,
   (f_add_input_nhood_VAC_pct_i = NULL) => -0.0060279923, -0.0060279923), -0.0022764949);

// Tree: 238 
woFDN_FLA____lgt_238 := map(
(NULL < c_span_lang and c_span_lang <= 181.5) => -0.0009611409,
(c_span_lang > 181.5) => 
   map(
   (NULL < c_totsales and c_totsales <= 2038.5) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0040093203) => 0.0585944300,
      (f_add_input_nhood_VAC_pct_i > 0.0040093203) => -0.0839140920,
      (f_add_input_nhood_VAC_pct_i = NULL) => -0.0609816862, -0.0609816862),
   (c_totsales > 2038.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 18.5) => -0.0818348214,
      (f_mos_inq_banko_cm_lseen_d > 18.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => -0.0350899363,
         (f_rel_under25miles_cnt_d > 5.5) => 0.0404654641,
         (f_rel_under25miles_cnt_d = NULL) => 0.0040438865, 0.0040438865),
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0053709645, -0.0053709645),
   (c_totsales = NULL) => -0.0269120722, -0.0269120722),
(c_span_lang = NULL) => -0.0149806027, -0.0035846046);

// Tree: 239 
woFDN_FLA____lgt_239 := map(
(NULL < c_old_homes and c_old_homes <= 164.5) => 
   map(
   (NULL < r_L70_inp_addr_dirty_i and r_L70_inp_addr_dirty_i <= 0.5) => 
      map(
      (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0052109730,
      (f_inq_Other_count_i > 0.5) => 
         map(
         (NULL < c_rnt2000_p and c_rnt2000_p <= 33.85) => 0.0293386976,
         (c_rnt2000_p > 33.85) => -0.0666509306,
         (c_rnt2000_p = NULL) => 0.0218370531, 0.0218370531),
      (f_inq_Other_count_i = NULL) => 0.0010567217, 0.0010567217),
   (r_L70_inp_addr_dirty_i > 0.5) => -0.0752230311,
   (r_L70_inp_addr_dirty_i = NULL) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 84) => 0.0766131582,
      (c_blue_empl > 84) => -0.0369292416,
      (c_blue_empl = NULL) => 0.0300793878, 0.0300793878), 0.0004173028),
(c_old_homes > 164.5) => -0.0286718347,
(c_old_homes = NULL) => 0.0133223372, -0.0029712750);

// Tree: 240 
woFDN_FLA____lgt_240 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 53.55) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => 0.0047512907,
   (f_rel_ageover50_count_d > 4.5) => -0.0776073416,
   (f_rel_ageover50_count_d = NULL) => 
      map(
      (NULL < c_pop00 and c_pop00 <= 1247) => -0.0627463208,
      (c_pop00 > 1247) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 20.55) => 0.0595342826,
         (c_bigapt_p > 20.55) => -0.0820563376,
         (c_bigapt_p = NULL) => 0.0269506671, 0.0269506671),
      (c_pop00 = NULL) => -0.0006084075, -0.0006084075), 0.0029273211),
(c_famotf18_p > 53.55) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.0111323196,
   (f_sourcerisktype_i > 5.5) => 0.1358579476,
   (f_sourcerisktype_i = NULL) => 0.0476637873, 0.0476637873),
(c_famotf18_p = NULL) => -0.0278139634, 0.0026874117);

// Tree: 241 
woFDN_FLA____lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0014694919,
(k_comb_age_d > 67.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 10.35) => 0.0131012947,
   (C_INC_25K_P > 10.35) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 4.5) => 
         map(
         (NULL < c_finance and c_finance <= 2.4) => -0.0184711869,
         (c_finance > 2.4) => 0.1509710282,
         (c_finance = NULL) => 0.0626827161, 0.0626827161),
      (r_C12_Num_NonDerogs_d > 4.5) => 0.2195758985,
      (r_C12_Num_NonDerogs_d = NULL) => 0.1049231883, 0.1049231883),
   (C_INC_25K_P = NULL) => 0.0405423204, 0.0405423204),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 15.05) => 0.0339180025,
   (c_hh3_p > 15.05) => -0.0687332953,
   (c_hh3_p = NULL) => -0.0139009251, -0.0139009251), 0.0012971944);

// Tree: 242 
woFDN_FLA____lgt_242 := map(
(NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 72.75) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.1696666826) => -0.0594585389,
      (f_add_curr_mobility_index_i > 0.1696666826) => 
         map(
         (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 0.0101268215,
         (f_prevaddroccupantowned_i > 0.5) => 0.1265610099,
         (f_prevaddroccupantowned_i = NULL) => 0.0195975450, 0.0195975450),
      (f_add_curr_mobility_index_i = NULL) => 0.0125358904, 0.0125358904),
   (c_civ_emp > 72.75) => 0.1691267404,
   (c_civ_emp = NULL) => 0.0275661581, 0.0275661581),
(r_I60_inq_banking_recency_d > 9) => -0.0000935515,
(r_I60_inq_banking_recency_d = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 283) => -0.0275595162,
   (c_employees > 283) => 0.0727900772,
   (c_employees = NULL) => 0.0222322667, 0.0222322667), 0.0024396722);

// Tree: 243 
woFDN_FLA____lgt_243 := map(
(NULL < c_info and c_info <= 27.85) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 415.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
         map(
         (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0058749653,
         (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0492364182,
         (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0036009406, 0.0036009406),
      (r_C23_inp_addr_occ_index_d > 4.5) => -0.0999247557,
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0019927578, 0.0019927578),
   (f_M_Bureau_ADL_FS_noTU_d > 415.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 3.6) => 0.2268369805,
      (c_hval_125k_p > 3.6) => -0.0612316771,
      (c_hval_125k_p = NULL) => 0.0875096559, 0.0875096559),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0119258083, 0.0029029474),
(c_info > 27.85) => 0.1426638524,
(c_info = NULL) => 0.0212531705, 0.0040061230);

// Tree: 244 
woFDN_FLA____lgt_244 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 4.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 55.55) => -0.0407250761,
      (c_fammar_p > 55.55) => -0.0078073375,
      (c_fammar_p = NULL) => 0.0125327486, -0.0096031085),
   (f_curraddrcrimeindex_i > 121) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 18.05) => 0.0604580752,
      (c_hh2_p > 18.05) => 0.0065495300,
      (c_hh2_p = NULL) => 0.0108142357, 0.0108142357),
   (f_curraddrcrimeindex_i = NULL) => -0.0042846905, -0.0042846905),
(f_inq_Communications_count_i > 4.5) => 0.0665113762,
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 63.1) => 0.0463135207,
   (c_civ_emp > 63.1) => -0.0567923399,
   (c_civ_emp = NULL) => -0.0077281718, -0.0077281718), -0.0039398914);

// Tree: 245 
woFDN_FLA____lgt_245 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 47829) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 27.85) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 23.5) => 0.0087565888,
      (f_rel_educationover12_count_d > 23.5) => 0.0959153984,
      (f_rel_educationover12_count_d = NULL) => 0.0425076733, 0.0123950971),
   (C_INC_75K_P > 27.85) => 0.1257827374,
   (C_INC_75K_P = NULL) => -0.0115269784, 0.0138941232),
(f_curraddrmedianincome_d > 47829) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 46.3) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 6.5) => -0.0753923530,
      (f_mos_inq_banko_om_fseen_d > 6.5) => -0.0068259167,
      (f_mos_inq_banko_om_fseen_d = NULL) => -0.0097310163, -0.0097310163),
   (c_famotf18_p > 46.3) => 0.0929124986,
   (c_famotf18_p = NULL) => -0.0091649259, -0.0091649259),
(f_curraddrmedianincome_d = NULL) => -0.0058517938, -0.0028906040);

// Tree: 246 
woFDN_FLA____lgt_246 := map(
(NULL < c_hhsize and c_hhsize <= 4.385) => 
   map(
   (NULL < c_amus_indx and c_amus_indx <= 118.5) => 
      map(
      (NULL < f_varmsrcssncount_i and f_varmsrcssncount_i <= 0.5) => -0.0831071121,
      (f_varmsrcssncount_i > 0.5) => 
         map(
         (NULL < c_amus_indx and c_amus_indx <= 115.5) => 0.0026531740,
         (c_amus_indx > 115.5) => 0.0538206515,
         (c_amus_indx = NULL) => 0.0078172592, 0.0078172592),
      (f_varmsrcssncount_i = NULL) => 
         map(
         (NULL < k_nap_nothing_found_i and k_nap_nothing_found_i <= 0.5) => -0.0566694867,
         (k_nap_nothing_found_i > 0.5) => 0.0465191061,
         (k_nap_nothing_found_i = NULL) => -0.0041700272, -0.0041700272), 0.0065483149),
   (c_amus_indx > 118.5) => -0.0273607447,
   (c_amus_indx = NULL) => -0.0004592630, -0.0004592630),
(c_hhsize > 4.385) => 0.0919709714,
(c_hhsize = NULL) => -0.0260837116, -0.0004742024);

// Tree: 247 
woFDN_FLA____lgt_247 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 187) => -0.0063203152,
      (f_fp_prevaddrcrimeindex_i > 187) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 
            map(
            (NULL < c_femdiv_p and c_femdiv_p <= 9.15) => -0.0120978056,
            (c_femdiv_p > 9.15) => 0.1534687891,
            (c_femdiv_p = NULL) => 0.0142663019, 0.0142663019),
         (r_F04_curr_add_occ_index_d > 2) => 0.1379270587,
         (r_F04_curr_add_occ_index_d = NULL) => 0.0415083993, 0.0415083993),
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0047608930, -0.0047608930),
   (r_D33_eviction_count_i > 3.5) => 0.0703938235,
   (r_D33_eviction_count_i = NULL) => -0.0043327125, -0.0043327125),
(f_inq_HighRiskCredit_count_i > 21.5) => -0.0866245817,
(f_inq_HighRiskCredit_count_i = NULL) => -0.0049945920, -0.0046725414);

// Tree: 248 
woFDN_FLA____lgt_248 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 11.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 53517.5) => -0.0104181846,
   (r_A49_Curr_AVM_Chg_1yr_i > 53517.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 67.65) => 0.0140113071,
      (c_civ_emp > 67.65) => 0.1568848365,
      (c_civ_emp = NULL) => 0.0553984003, 0.0553984003),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0035829828, 0.0013031147),
(f_rel_under100miles_cnt_d > 11.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 13.35) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0957240990,
      (r_I60_inq_hiRiskCred_recency_d > 9) => -0.0292884043,
      (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0314767974, -0.0314767974),
   (c_pop_0_5_p > 13.35) => 0.0579983672,
   (c_pop_0_5_p = NULL) => -0.0227794778, -0.0227794778),
(f_rel_under100miles_cnt_d = NULL) => 0.0039561705, -0.0029628877);

// Tree: 249 
woFDN_FLA____lgt_249 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 7.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 29.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30896.5) => 0.0281358078,
      (f_curraddrmedianincome_d > 30896.5) => -0.0000666443,
      (f_curraddrmedianincome_d = NULL) => 0.0024652820, 0.0024652820),
   (f_rel_homeover200_count_d > 29.5) => -0.0668362476,
   (f_rel_homeover200_count_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 4) => -0.0474239683,
      (c_hval_200k_p > 4) => 0.1089772603,
      (c_hval_200k_p = NULL) => 0.0121232885, 0.0121232885), 0.0019789956),
(r_I60_Inq_Count12_i > 7.5) => -0.0489669123,
(r_I60_Inq_Count12_i = NULL) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 4.85) => -0.0433298588,
   (c_hval_750k_p > 4.85) => 0.0531015605,
   (c_hval_750k_p = NULL) => -0.0093316020, -0.0093316020), 0.0010304251);

// Tree: 250 
woFDN_FLA____lgt_250 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => -0.0026123195,
(C_INC_50K_P > 19.85) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 3.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 18.5) => 0.1120571440,
      (c_many_cars > 18.5) => 
         map(
         (NULL < c_work_home and c_work_home <= 137.5) => -0.0132463424,
         (c_work_home > 137.5) => 0.0972697888,
         (c_work_home = NULL) => 0.0101051673, 0.0101051673),
      (c_many_cars = NULL) => 0.0182357461, 0.0182357461),
   (f_crim_rel_under25miles_cnt_i > 3.5) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 54.5) => 0.1837383668,
      (c_very_rich > 54.5) => 0.0187121267,
      (c_very_rich = NULL) => 0.0871376409, 0.0871376409),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0250758858, 0.0250758858),
(C_INC_50K_P = NULL) => 0.0004636139, 0.0002410102);

// Tree: 251 
woFDN_FLA____lgt_251 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1251) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 0.5) => -0.0477370687,
   (f_rel_homeover100_count_d > 0.5) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 0.0064809733,
      (f_inq_Other_count24_i > 3.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.22773155165) => 0.1305271771,
         (f_add_curr_nhood_MFD_pct_i > 0.22773155165) => 0.0553249943,
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0450586801, 0.0605882754),
      (f_inq_Other_count24_i = NULL) => 0.0074924982, 0.0074924982),
   (f_rel_homeover100_count_d = NULL) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 0.0994911326,
      (r_C10_M_Hdr_FS_d > 11.5) => -0.0565034989,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0129516982, -0.0129516982), 0.0044841041),
(f_liens_rel_SC_total_amt_i > 1251) => -0.1263251384,
(f_liens_rel_SC_total_amt_i = NULL) => -0.0078233451, 0.0037185107);

// Tree: 252 
woFDN_FLA____lgt_252 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 119.5) => 0.0794610668,
(r_D32_Mos_Since_Fel_LS_d > 119.5) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 54.4) => 
      map(
      (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => -0.0019809930,
      (f_divaddrsuspidcountnew_i > 0.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 0.5) => 0.0984059397,
         (f_rel_under25miles_cnt_d > 0.5) => 0.0149798623,
         (f_rel_under25miles_cnt_d = NULL) => 0.0569565267, 0.0201551618),
      (f_divaddrsuspidcountnew_i = NULL) => 0.0023381231, 0.0023381231),
   (c_trailer_p > 54.4) => 0.1182236542,
   (c_trailer_p = NULL) => 0.0079309507, 0.0031542025),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_rnt2000_p and c_rnt2000_p <= 1.4) => 0.0279189049,
   (c_rnt2000_p > 1.4) => -0.0633631525,
   (c_rnt2000_p = NULL) => -0.0035363987, -0.0035363987), 0.0034814042);

// Tree: 253 
woFDN_FLA____lgt_253 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 5.5) => 0.0024779294,
(r_C14_addrs_15yr_i > 5.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 3880) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 147.5) => -0.0284424933,
      (c_mort_indx > 147.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0061208741,
         (f_assocrisktype_i > 3.5) => 0.1720857650,
         (f_assocrisktype_i = NULL) => 0.0722747117, 0.0722747117),
      (c_mort_indx = NULL) => -0.0183918581, -0.0183918581),
   (f_addrchangeincomediff_d > 3880) => -0.0837738057,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 3.85) => 0.0698871771,
      (C_INC_25K_P > 3.85) => -0.0490321738,
      (C_INC_25K_P = NULL) => -0.0225521564, -0.0225521564), -0.0229873131),
(r_C14_addrs_15yr_i = NULL) => -0.0052981959, -0.0017569541);

// Tree: 254 
woFDN_FLA____lgt_254 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 37.45) => -0.0126658032,
(c_fammar18_p > 37.45) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 69.5) => 0.0118187352,
      (f_addrchangecrimediff_i > 69.5) => 0.1170676132,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 127.5) => -0.0189307151,
         (f_prevaddrageoldest_d > 127.5) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 119.5) => -0.0038121793,
            (c_span_lang > 119.5) => 0.1921593886,
            (c_span_lang = NULL) => 0.0795972071, 0.0795972071),
         (f_prevaddrageoldest_d = NULL) => 0.0037560187, 0.0037560187), 0.0112208072),
   (r_D32_felony_count_i > 0.5) => 0.1244584916,
   (r_D32_felony_count_i = NULL) => 0.0336654790, 0.0125299234),
(c_fammar18_p = NULL) => 0.0333493927, -0.0006862668);

// Tree: 255 
woFDN_FLA____lgt_255 := map(
(NULL < c_pop_12_17_p and c_pop_12_17_p <= 13.75) => 
   map(
   (NULL < c_hval_1001k_p and c_hval_1001k_p <= 55.75) => 
      map(
      (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 185.5) => -0.0699114708,
      (f_mos_liens_unrel_FT_lseen_d > 185.5) => 0.0032202892,
      (f_mos_liens_unrel_FT_lseen_d = NULL) => 0.0013330778, 0.0023909180),
   (c_hval_1001k_p > 55.75) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01315146565) => -0.0080524371,
      (f_add_curr_nhood_VAC_pct_i > 0.01315146565) => 0.2204605039,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1225263863, 0.1225263863),
   (c_hval_1001k_p = NULL) => 0.0036110281, 0.0036110281),
(c_pop_12_17_p > 13.75) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 20.75) => 0.0906509225,
   (c_oldhouse > 20.75) => -0.0586768073,
   (c_oldhouse = NULL) => -0.0338908521, -0.0338908521),
(c_pop_12_17_p = NULL) => 0.0165927529, 0.0024579268);

// Tree: 256 
woFDN_FLA____lgt_256 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 82.5) => -0.0216277185,
(r_C13_max_lres_d > 82.5) => 
   map(
   (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 4.5) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 93.75) => 
         map(
         (NULL < c_burglary and c_burglary <= 133) => -0.1157280380,
         (c_burglary > 133) => 0.1187529712,
         (c_burglary = NULL) => -0.0173972922, -0.0173972922),
      (c_occunit_p > 93.75) => 
         map(
         (NULL < c_med_rent and c_med_rent <= 711.5) => 0.0062231180,
         (c_med_rent > 711.5) => 0.2553164092,
         (c_med_rent = NULL) => 0.1488662848, 0.1488662848),
      (c_occunit_p = NULL) => 0.0633198800, 0.0633198800),
   (r_C20_email_verification_d > 4.5) => -0.0793492334,
   (r_C20_email_verification_d = NULL) => 0.0068254552, 0.0072495054),
(r_C13_max_lres_d = NULL) => 0.0139815380, -0.0001965040);

// Tree: 257 
woFDN_FLA____lgt_257 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.96576211295) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 2.85) => -0.0559085258,
      (c_femdiv_p > 2.85) => 0.0297647073,
      (c_femdiv_p = NULL) => 0.0099722112, 0.0099722112),
   (f_add_curr_nhood_SFD_pct_d > 0.96576211295) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 8.1) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 44) => 0.0864068979,
         (f_curraddrcartheftindex_i > 44) => 0.2121338552,
         (f_curraddrcartheftindex_i = NULL) => 0.1537606250, 0.1537606250),
      (c_hval_400k_p > 8.1) => -0.0187576133,
      (c_hval_400k_p = NULL) => 0.0745855881, 0.0745855881),
   (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0214528713, 0.0214528713),
(f_prevaddrlenofres_d > 3.5) => -0.0060454967,
(f_prevaddrlenofres_d = NULL) => 0.0193487352, -0.0031655218);

// Final Score Sum 

   woFDN_FLA____lgt := sum(
      woFDN_FLA____lgt_0, woFDN_FLA____lgt_1, woFDN_FLA____lgt_2, woFDN_FLA____lgt_3, woFDN_FLA____lgt_4, 
      woFDN_FLA____lgt_5, woFDN_FLA____lgt_6, woFDN_FLA____lgt_7, woFDN_FLA____lgt_8, woFDN_FLA____lgt_9, 
      woFDN_FLA____lgt_10, woFDN_FLA____lgt_11, woFDN_FLA____lgt_12, woFDN_FLA____lgt_13, woFDN_FLA____lgt_14, 
      woFDN_FLA____lgt_15, woFDN_FLA____lgt_16, woFDN_FLA____lgt_17, woFDN_FLA____lgt_18, woFDN_FLA____lgt_19, 
      woFDN_FLA____lgt_20, woFDN_FLA____lgt_21, woFDN_FLA____lgt_22, woFDN_FLA____lgt_23, woFDN_FLA____lgt_24, 
      woFDN_FLA____lgt_25, woFDN_FLA____lgt_26, woFDN_FLA____lgt_27, woFDN_FLA____lgt_28, woFDN_FLA____lgt_29, 
      woFDN_FLA____lgt_30, woFDN_FLA____lgt_31, woFDN_FLA____lgt_32, woFDN_FLA____lgt_33, woFDN_FLA____lgt_34, 
      woFDN_FLA____lgt_35, woFDN_FLA____lgt_36, woFDN_FLA____lgt_37, woFDN_FLA____lgt_38, woFDN_FLA____lgt_39, 
      woFDN_FLA____lgt_40, woFDN_FLA____lgt_41, woFDN_FLA____lgt_42, woFDN_FLA____lgt_43, woFDN_FLA____lgt_44, 
      woFDN_FLA____lgt_45, woFDN_FLA____lgt_46, woFDN_FLA____lgt_47, woFDN_FLA____lgt_48, woFDN_FLA____lgt_49, 
      woFDN_FLA____lgt_50, woFDN_FLA____lgt_51, woFDN_FLA____lgt_52, woFDN_FLA____lgt_53, woFDN_FLA____lgt_54, 
      woFDN_FLA____lgt_55, woFDN_FLA____lgt_56, woFDN_FLA____lgt_57, woFDN_FLA____lgt_58, woFDN_FLA____lgt_59, 
      woFDN_FLA____lgt_60, woFDN_FLA____lgt_61, woFDN_FLA____lgt_62, woFDN_FLA____lgt_63, woFDN_FLA____lgt_64, 
      woFDN_FLA____lgt_65, woFDN_FLA____lgt_66, woFDN_FLA____lgt_67, woFDN_FLA____lgt_68, woFDN_FLA____lgt_69, 
      woFDN_FLA____lgt_70, woFDN_FLA____lgt_71, woFDN_FLA____lgt_72, woFDN_FLA____lgt_73, woFDN_FLA____lgt_74, 
      woFDN_FLA____lgt_75, woFDN_FLA____lgt_76, woFDN_FLA____lgt_77, woFDN_FLA____lgt_78, woFDN_FLA____lgt_79, 
      woFDN_FLA____lgt_80, woFDN_FLA____lgt_81, woFDN_FLA____lgt_82, woFDN_FLA____lgt_83, woFDN_FLA____lgt_84, 
      woFDN_FLA____lgt_85, woFDN_FLA____lgt_86, woFDN_FLA____lgt_87, woFDN_FLA____lgt_88, woFDN_FLA____lgt_89, 
      woFDN_FLA____lgt_90, woFDN_FLA____lgt_91, woFDN_FLA____lgt_92, woFDN_FLA____lgt_93, woFDN_FLA____lgt_94, 
      woFDN_FLA____lgt_95, woFDN_FLA____lgt_96, woFDN_FLA____lgt_97, woFDN_FLA____lgt_98, woFDN_FLA____lgt_99, 
      woFDN_FLA____lgt_100, woFDN_FLA____lgt_101, woFDN_FLA____lgt_102, woFDN_FLA____lgt_103, woFDN_FLA____lgt_104, 
      woFDN_FLA____lgt_105, woFDN_FLA____lgt_106, woFDN_FLA____lgt_107, woFDN_FLA____lgt_108, woFDN_FLA____lgt_109, 
      woFDN_FLA____lgt_110, woFDN_FLA____lgt_111, woFDN_FLA____lgt_112, woFDN_FLA____lgt_113, woFDN_FLA____lgt_114, 
      woFDN_FLA____lgt_115, woFDN_FLA____lgt_116, woFDN_FLA____lgt_117, woFDN_FLA____lgt_118, woFDN_FLA____lgt_119, 
      woFDN_FLA____lgt_120, woFDN_FLA____lgt_121, woFDN_FLA____lgt_122, woFDN_FLA____lgt_123, woFDN_FLA____lgt_124, 
      woFDN_FLA____lgt_125, woFDN_FLA____lgt_126, woFDN_FLA____lgt_127, woFDN_FLA____lgt_128, woFDN_FLA____lgt_129, 
      woFDN_FLA____lgt_130, woFDN_FLA____lgt_131, woFDN_FLA____lgt_132, woFDN_FLA____lgt_133, woFDN_FLA____lgt_134, 
      woFDN_FLA____lgt_135, woFDN_FLA____lgt_136, woFDN_FLA____lgt_137, woFDN_FLA____lgt_138, woFDN_FLA____lgt_139, 
      woFDN_FLA____lgt_140, woFDN_FLA____lgt_141, woFDN_FLA____lgt_142, woFDN_FLA____lgt_143, woFDN_FLA____lgt_144, 
      woFDN_FLA____lgt_145, woFDN_FLA____lgt_146, woFDN_FLA____lgt_147, woFDN_FLA____lgt_148, woFDN_FLA____lgt_149, 
      woFDN_FLA____lgt_150, woFDN_FLA____lgt_151, woFDN_FLA____lgt_152, woFDN_FLA____lgt_153, woFDN_FLA____lgt_154, 
      woFDN_FLA____lgt_155, woFDN_FLA____lgt_156, woFDN_FLA____lgt_157, woFDN_FLA____lgt_158, woFDN_FLA____lgt_159, 
      woFDN_FLA____lgt_160, woFDN_FLA____lgt_161, woFDN_FLA____lgt_162, woFDN_FLA____lgt_163, woFDN_FLA____lgt_164, 
      woFDN_FLA____lgt_165, woFDN_FLA____lgt_166, woFDN_FLA____lgt_167, woFDN_FLA____lgt_168, woFDN_FLA____lgt_169, 
      woFDN_FLA____lgt_170, woFDN_FLA____lgt_171, woFDN_FLA____lgt_172, woFDN_FLA____lgt_173, woFDN_FLA____lgt_174, 
      woFDN_FLA____lgt_175, woFDN_FLA____lgt_176, woFDN_FLA____lgt_177, woFDN_FLA____lgt_178, woFDN_FLA____lgt_179, 
      woFDN_FLA____lgt_180, woFDN_FLA____lgt_181, woFDN_FLA____lgt_182, woFDN_FLA____lgt_183, woFDN_FLA____lgt_184, 
      woFDN_FLA____lgt_185, woFDN_FLA____lgt_186, woFDN_FLA____lgt_187, woFDN_FLA____lgt_188, woFDN_FLA____lgt_189, 
      woFDN_FLA____lgt_190, woFDN_FLA____lgt_191, woFDN_FLA____lgt_192, woFDN_FLA____lgt_193, woFDN_FLA____lgt_194, 
      woFDN_FLA____lgt_195, woFDN_FLA____lgt_196, woFDN_FLA____lgt_197, woFDN_FLA____lgt_198, woFDN_FLA____lgt_199, 
      woFDN_FLA____lgt_200, woFDN_FLA____lgt_201, woFDN_FLA____lgt_202, woFDN_FLA____lgt_203, woFDN_FLA____lgt_204, 
      woFDN_FLA____lgt_205, woFDN_FLA____lgt_206, woFDN_FLA____lgt_207, woFDN_FLA____lgt_208, woFDN_FLA____lgt_209, 
      woFDN_FLA____lgt_210, woFDN_FLA____lgt_211, woFDN_FLA____lgt_212, woFDN_FLA____lgt_213, woFDN_FLA____lgt_214, 
      woFDN_FLA____lgt_215, woFDN_FLA____lgt_216, woFDN_FLA____lgt_217, woFDN_FLA____lgt_218, woFDN_FLA____lgt_219, 
      woFDN_FLA____lgt_220, woFDN_FLA____lgt_221, woFDN_FLA____lgt_222, woFDN_FLA____lgt_223, woFDN_FLA____lgt_224, 
      woFDN_FLA____lgt_225, woFDN_FLA____lgt_226, woFDN_FLA____lgt_227, woFDN_FLA____lgt_228, woFDN_FLA____lgt_229, 
      woFDN_FLA____lgt_230, woFDN_FLA____lgt_231, woFDN_FLA____lgt_232, woFDN_FLA____lgt_233, woFDN_FLA____lgt_234, 
      woFDN_FLA____lgt_235, woFDN_FLA____lgt_236, woFDN_FLA____lgt_237, woFDN_FLA____lgt_238, woFDN_FLA____lgt_239, 
      woFDN_FLA____lgt_240, woFDN_FLA____lgt_241, woFDN_FLA____lgt_242, woFDN_FLA____lgt_243, woFDN_FLA____lgt_244, 
      woFDN_FLA____lgt_245, woFDN_FLA____lgt_246, woFDN_FLA____lgt_247, woFDN_FLA____lgt_248, woFDN_FLA____lgt_249, 
      woFDN_FLA____lgt_250, woFDN_FLA____lgt_251, woFDN_FLA____lgt_252, woFDN_FLA____lgt_253, woFDN_FLA____lgt_254, 
      woFDN_FLA____lgt_255, woFDN_FLA____lgt_256, woFDN_FLA____lgt_257); 


// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_woFDN_LGT := woFDN_FLA____lgt;
			
self.final_score_0	:= 	woFDN_FLA____lgt_0	;
self.final_score_1	:= 	woFDN_FLA____lgt_1	;
self.final_score_2	:= 	woFDN_FLA____lgt_2	;
self.final_score_3	:= 	woFDN_FLA____lgt_3	;
self.final_score_4	:= 	woFDN_FLA____lgt_4	;
self.final_score_5	:= 	woFDN_FLA____lgt_5	;
self.final_score_6	:= 	woFDN_FLA____lgt_6	;
self.final_score_7	:= 	woFDN_FLA____lgt_7	;
self.final_score_8	:= 	woFDN_FLA____lgt_8	;
self.final_score_9	:= 	woFDN_FLA____lgt_9	;
self.final_score_10	:= 	woFDN_FLA____lgt_10	;
self.final_score_11	:= 	woFDN_FLA____lgt_11	;
self.final_score_12	:= 	woFDN_FLA____lgt_12	;
self.final_score_13	:= 	woFDN_FLA____lgt_13	;
self.final_score_14	:= 	woFDN_FLA____lgt_14	;
self.final_score_15	:= 	woFDN_FLA____lgt_15	;
self.final_score_16	:= 	woFDN_FLA____lgt_16	;
self.final_score_17	:= 	woFDN_FLA____lgt_17	;
self.final_score_18	:= 	woFDN_FLA____lgt_18	;
self.final_score_19	:= 	woFDN_FLA____lgt_19	;
self.final_score_20	:= 	woFDN_FLA____lgt_20	;
self.final_score_21	:= 	woFDN_FLA____lgt_21	;
self.final_score_22	:= 	woFDN_FLA____lgt_22	;
self.final_score_23	:= 	woFDN_FLA____lgt_23	;
self.final_score_24	:= 	woFDN_FLA____lgt_24	;
self.final_score_25	:= 	woFDN_FLA____lgt_25	;
self.final_score_26	:= 	woFDN_FLA____lgt_26	;
self.final_score_27	:= 	woFDN_FLA____lgt_27	;
self.final_score_28	:= 	woFDN_FLA____lgt_28	;
self.final_score_29	:= 	woFDN_FLA____lgt_29	;
self.final_score_30	:= 	woFDN_FLA____lgt_30	;
self.final_score_31	:= 	woFDN_FLA____lgt_31	;
self.final_score_32	:= 	woFDN_FLA____lgt_32	;
self.final_score_33	:= 	woFDN_FLA____lgt_33	;
self.final_score_34	:= 	woFDN_FLA____lgt_34	;
self.final_score_35	:= 	woFDN_FLA____lgt_35	;
self.final_score_36	:= 	woFDN_FLA____lgt_36	;
self.final_score_37	:= 	woFDN_FLA____lgt_37	;
self.final_score_38	:= 	woFDN_FLA____lgt_38	;
self.final_score_39	:= 	woFDN_FLA____lgt_39	;
self.final_score_40	:= 	woFDN_FLA____lgt_40	;
self.final_score_41	:= 	woFDN_FLA____lgt_41	;
self.final_score_42	:= 	woFDN_FLA____lgt_42	;
self.final_score_43	:= 	woFDN_FLA____lgt_43	;
self.final_score_44	:= 	woFDN_FLA____lgt_44	;
self.final_score_45	:= 	woFDN_FLA____lgt_45	;
self.final_score_46	:= 	woFDN_FLA____lgt_46	;
self.final_score_47	:= 	woFDN_FLA____lgt_47	;
self.final_score_48	:= 	woFDN_FLA____lgt_48	;
self.final_score_49	:= 	woFDN_FLA____lgt_49	;
self.final_score_50	:= 	woFDN_FLA____lgt_50	;
self.final_score_51	:= 	woFDN_FLA____lgt_51	;
self.final_score_52	:= 	woFDN_FLA____lgt_52	;
self.final_score_53	:= 	woFDN_FLA____lgt_53	;
self.final_score_54	:= 	woFDN_FLA____lgt_54	;
self.final_score_55	:= 	woFDN_FLA____lgt_55	;
self.final_score_56	:= 	woFDN_FLA____lgt_56	;
self.final_score_57	:= 	woFDN_FLA____lgt_57	;
self.final_score_58	:= 	woFDN_FLA____lgt_58	;
self.final_score_59	:= 	woFDN_FLA____lgt_59	;
self.final_score_60	:= 	woFDN_FLA____lgt_60	;
self.final_score_61	:= 	woFDN_FLA____lgt_61	;
self.final_score_62	:= 	woFDN_FLA____lgt_62	;
self.final_score_63	:= 	woFDN_FLA____lgt_63	;
self.final_score_64	:= 	woFDN_FLA____lgt_64	;
self.final_score_65	:= 	woFDN_FLA____lgt_65	;
self.final_score_66	:= 	woFDN_FLA____lgt_66	;
self.final_score_67	:= 	woFDN_FLA____lgt_67	;
self.final_score_68	:= 	woFDN_FLA____lgt_68	;
self.final_score_69	:= 	woFDN_FLA____lgt_69	;
self.final_score_70	:= 	woFDN_FLA____lgt_70	;
self.final_score_71	:= 	woFDN_FLA____lgt_71	;
self.final_score_72	:= 	woFDN_FLA____lgt_72	;
self.final_score_73	:= 	woFDN_FLA____lgt_73	;
self.final_score_74	:= 	woFDN_FLA____lgt_74	;
self.final_score_75	:= 	woFDN_FLA____lgt_75	;
self.final_score_76	:= 	woFDN_FLA____lgt_76	;
self.final_score_77	:= 	woFDN_FLA____lgt_77	;
self.final_score_78	:= 	woFDN_FLA____lgt_78	;
self.final_score_79	:= 	woFDN_FLA____lgt_79	;
self.final_score_80	:= 	woFDN_FLA____lgt_80	;
self.final_score_81	:= 	woFDN_FLA____lgt_81	;
self.final_score_82	:= 	woFDN_FLA____lgt_82	;
self.final_score_83	:= 	woFDN_FLA____lgt_83	;
self.final_score_84	:= 	woFDN_FLA____lgt_84	;
self.final_score_85	:= 	woFDN_FLA____lgt_85	;
self.final_score_86	:= 	woFDN_FLA____lgt_86	;
self.final_score_87	:= 	woFDN_FLA____lgt_87	;
self.final_score_88	:= 	woFDN_FLA____lgt_88	;
self.final_score_89	:= 	woFDN_FLA____lgt_89	;
self.final_score_90	:= 	woFDN_FLA____lgt_90	;
self.final_score_91	:= 	woFDN_FLA____lgt_91	;
self.final_score_92	:= 	woFDN_FLA____lgt_92	;
self.final_score_93	:= 	woFDN_FLA____lgt_93	;
self.final_score_94	:= 	woFDN_FLA____lgt_94	;
self.final_score_95	:= 	woFDN_FLA____lgt_95	;
self.final_score_96	:= 	woFDN_FLA____lgt_96	;
self.final_score_97	:= 	woFDN_FLA____lgt_97	;
self.final_score_98	:= 	woFDN_FLA____lgt_98	;
self.final_score_99	:= 	woFDN_FLA____lgt_99	;
self.final_score_100	:= 	woFDN_FLA____lgt_100	;
self.final_score_101	:= 	woFDN_FLA____lgt_101	;
self.final_score_102	:= 	woFDN_FLA____lgt_102	;
self.final_score_103	:= 	woFDN_FLA____lgt_103	;
self.final_score_104	:= 	woFDN_FLA____lgt_104	;
self.final_score_105	:= 	woFDN_FLA____lgt_105	;
self.final_score_106	:= 	woFDN_FLA____lgt_106	;
self.final_score_107	:= 	woFDN_FLA____lgt_107	;
self.final_score_108	:= 	woFDN_FLA____lgt_108	;
self.final_score_109	:= 	woFDN_FLA____lgt_109	;
self.final_score_110	:= 	woFDN_FLA____lgt_110	;
self.final_score_111	:= 	woFDN_FLA____lgt_111	;
self.final_score_112	:= 	woFDN_FLA____lgt_112	;
self.final_score_113	:= 	woFDN_FLA____lgt_113	;
self.final_score_114	:= 	woFDN_FLA____lgt_114	;
self.final_score_115	:= 	woFDN_FLA____lgt_115	;
self.final_score_116	:= 	woFDN_FLA____lgt_116	;
self.final_score_117	:= 	woFDN_FLA____lgt_117	;
self.final_score_118	:= 	woFDN_FLA____lgt_118	;
self.final_score_119	:= 	woFDN_FLA____lgt_119	;
self.final_score_120	:= 	woFDN_FLA____lgt_120	;
self.final_score_121	:= 	woFDN_FLA____lgt_121	;
self.final_score_122	:= 	woFDN_FLA____lgt_122	;
self.final_score_123	:= 	woFDN_FLA____lgt_123	;
self.final_score_124	:= 	woFDN_FLA____lgt_124	;
self.final_score_125	:= 	woFDN_FLA____lgt_125	;
self.final_score_126	:= 	woFDN_FLA____lgt_126	;
self.final_score_127	:= 	woFDN_FLA____lgt_127	;
self.final_score_128	:= 	woFDN_FLA____lgt_128	;
self.final_score_129	:= 	woFDN_FLA____lgt_129	;
self.final_score_130	:= 	woFDN_FLA____lgt_130	;
self.final_score_131	:= 	woFDN_FLA____lgt_131	;
self.final_score_132	:= 	woFDN_FLA____lgt_132	;
self.final_score_133	:= 	woFDN_FLA____lgt_133	;
self.final_score_134	:= 	woFDN_FLA____lgt_134	;
self.final_score_135	:= 	woFDN_FLA____lgt_135	;
self.final_score_136	:= 	woFDN_FLA____lgt_136	;
self.final_score_137	:= 	woFDN_FLA____lgt_137	;
self.final_score_138	:= 	woFDN_FLA____lgt_138	;
self.final_score_139	:= 	woFDN_FLA____lgt_139	;
self.final_score_140	:= 	woFDN_FLA____lgt_140	;
self.final_score_141	:= 	woFDN_FLA____lgt_141	;
self.final_score_142	:= 	woFDN_FLA____lgt_142	;
self.final_score_143	:= 	woFDN_FLA____lgt_143	;
self.final_score_144	:= 	woFDN_FLA____lgt_144	;
self.final_score_145	:= 	woFDN_FLA____lgt_145	;
self.final_score_146	:= 	woFDN_FLA____lgt_146	;
self.final_score_147	:= 	woFDN_FLA____lgt_147	;
self.final_score_148	:= 	woFDN_FLA____lgt_148	;
self.final_score_149	:= 	woFDN_FLA____lgt_149	;
self.final_score_150	:= 	woFDN_FLA____lgt_150	;
self.final_score_151	:= 	woFDN_FLA____lgt_151	;
self.final_score_152	:= 	woFDN_FLA____lgt_152	;
self.final_score_153	:= 	woFDN_FLA____lgt_153	;
self.final_score_154	:= 	woFDN_FLA____lgt_154	;
self.final_score_155	:= 	woFDN_FLA____lgt_155	;
self.final_score_156	:= 	woFDN_FLA____lgt_156	;
self.final_score_157	:= 	woFDN_FLA____lgt_157	;
self.final_score_158	:= 	woFDN_FLA____lgt_158	;
self.final_score_159	:= 	woFDN_FLA____lgt_159	;
self.final_score_160	:= 	woFDN_FLA____lgt_160	;
self.final_score_161	:= 	woFDN_FLA____lgt_161	;
self.final_score_162	:= 	woFDN_FLA____lgt_162	;
self.final_score_163	:= 	woFDN_FLA____lgt_163	;
self.final_score_164	:= 	woFDN_FLA____lgt_164	;
self.final_score_165	:= 	woFDN_FLA____lgt_165	;
self.final_score_166	:= 	woFDN_FLA____lgt_166	;
self.final_score_167	:= 	woFDN_FLA____lgt_167	;
self.final_score_168	:= 	woFDN_FLA____lgt_168	;
self.final_score_169	:= 	woFDN_FLA____lgt_169	;
self.final_score_170	:= 	woFDN_FLA____lgt_170	;
self.final_score_171	:= 	woFDN_FLA____lgt_171	;
self.final_score_172	:= 	woFDN_FLA____lgt_172	;
self.final_score_173	:= 	woFDN_FLA____lgt_173	;
self.final_score_174	:= 	woFDN_FLA____lgt_174	;
self.final_score_175	:= 	woFDN_FLA____lgt_175	;
self.final_score_176	:= 	woFDN_FLA____lgt_176	;
self.final_score_177	:= 	woFDN_FLA____lgt_177	;
self.final_score_178	:= 	woFDN_FLA____lgt_178	;
self.final_score_179	:= 	woFDN_FLA____lgt_179	;
self.final_score_180	:= 	woFDN_FLA____lgt_180	;
self.final_score_181	:= 	woFDN_FLA____lgt_181	;
self.final_score_182	:= 	woFDN_FLA____lgt_182	;
self.final_score_183	:= 	woFDN_FLA____lgt_183	;
self.final_score_184	:= 	woFDN_FLA____lgt_184	;
self.final_score_185	:= 	woFDN_FLA____lgt_185	;
self.final_score_186	:= 	woFDN_FLA____lgt_186	;
self.final_score_187	:= 	woFDN_FLA____lgt_187	;
self.final_score_188	:= 	woFDN_FLA____lgt_188	;
self.final_score_189	:= 	woFDN_FLA____lgt_189	;
self.final_score_190	:= 	woFDN_FLA____lgt_190	;
self.final_score_191	:= 	woFDN_FLA____lgt_191	;
self.final_score_192	:= 	woFDN_FLA____lgt_192	;
self.final_score_193	:= 	woFDN_FLA____lgt_193	;
self.final_score_194	:= 	woFDN_FLA____lgt_194	;
self.final_score_195	:= 	woFDN_FLA____lgt_195	;
self.final_score_196	:= 	woFDN_FLA____lgt_196	;
self.final_score_197	:= 	woFDN_FLA____lgt_197	;
self.final_score_198	:= 	woFDN_FLA____lgt_198	;
self.final_score_199	:= 	woFDN_FLA____lgt_199	;
self.final_score_200	:= 	woFDN_FLA____lgt_200	;
self.final_score_201	:= 	woFDN_FLA____lgt_201	;
self.final_score_202	:= 	woFDN_FLA____lgt_202	;
self.final_score_203	:= 	woFDN_FLA____lgt_203	;
self.final_score_204	:= 	woFDN_FLA____lgt_204	;
self.final_score_205	:= 	woFDN_FLA____lgt_205	;
self.final_score_206	:= 	woFDN_FLA____lgt_206	;
self.final_score_207	:= 	woFDN_FLA____lgt_207	;
self.final_score_208	:= 	woFDN_FLA____lgt_208	;
self.final_score_209	:= 	woFDN_FLA____lgt_209	;
self.final_score_210	:= 	woFDN_FLA____lgt_210	;
self.final_score_211	:= 	woFDN_FLA____lgt_211	;
self.final_score_212	:= 	woFDN_FLA____lgt_212	;
self.final_score_213	:= 	woFDN_FLA____lgt_213	;
self.final_score_214	:= 	woFDN_FLA____lgt_214	;
self.final_score_215	:= 	woFDN_FLA____lgt_215	;
self.final_score_216	:= 	woFDN_FLA____lgt_216	;
self.final_score_217	:= 	woFDN_FLA____lgt_217	;
self.final_score_218	:= 	woFDN_FLA____lgt_218	;
self.final_score_219	:= 	woFDN_FLA____lgt_219	;
self.final_score_220	:= 	woFDN_FLA____lgt_220	;
self.final_score_221	:= 	woFDN_FLA____lgt_221	;
self.final_score_222	:= 	woFDN_FLA____lgt_222	;
self.final_score_223	:= 	woFDN_FLA____lgt_223	;
self.final_score_224	:= 	woFDN_FLA____lgt_224	;
self.final_score_225	:= 	woFDN_FLA____lgt_225	;
self.final_score_226	:= 	woFDN_FLA____lgt_226	;
self.final_score_227	:= 	woFDN_FLA____lgt_227	;
self.final_score_228	:= 	woFDN_FLA____lgt_228	;
self.final_score_229	:= 	woFDN_FLA____lgt_229	;
self.final_score_230	:= 	woFDN_FLA____lgt_230	;
self.final_score_231	:= 	woFDN_FLA____lgt_231	;
self.final_score_232	:= 	woFDN_FLA____lgt_232	;
self.final_score_233	:= 	woFDN_FLA____lgt_233	;
self.final_score_234	:= 	woFDN_FLA____lgt_234	;
self.final_score_235	:= 	woFDN_FLA____lgt_235	;
self.final_score_236	:= 	woFDN_FLA____lgt_236	;
self.final_score_237	:= 	woFDN_FLA____lgt_237	;
self.final_score_238	:= 	woFDN_FLA____lgt_238	;
self.final_score_239	:= 	woFDN_FLA____lgt_239	;
self.final_score_240	:= 	woFDN_FLA____lgt_240	;
self.final_score_241	:= 	woFDN_FLA____lgt_241	;
self.final_score_242	:= 	woFDN_FLA____lgt_242	;
self.final_score_243	:= 	woFDN_FLA____lgt_243	;
self.final_score_244	:= 	woFDN_FLA____lgt_244	;
self.final_score_245	:= 	woFDN_FLA____lgt_245	;
self.final_score_246	:= 	woFDN_FLA____lgt_246	;
self.final_score_247	:= 	woFDN_FLA____lgt_247	;
self.final_score_248	:= 	woFDN_FLA____lgt_248	;
self.final_score_249	:= 	woFDN_FLA____lgt_249	;
self.final_score_250	:= 	woFDN_FLA____lgt_250	;
self.final_score_251	:= 	woFDN_FLA____lgt_251	;
self.final_score_252	:= 	woFDN_FLA____lgt_252	;
self.final_score_253	:= 	woFDN_FLA____lgt_253	;
self.final_score_254	:= 	woFDN_FLA____lgt_254	;
self.final_score_255	:= 	woFDN_FLA____lgt_255	;
self.final_score_256	:= 	woFDN_FLA____lgt_256	;
self.final_score_257	:= 	woFDN_FLA____lgt_257	;
// self.woFDN_submodel_lgt	:= 	woFDN_FLA____lgt	;
self.FP3_woFDN_LGT		:= 	woFDN_FLA____lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
