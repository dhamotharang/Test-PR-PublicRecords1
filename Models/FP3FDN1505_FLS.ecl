
export FP3FDN1505_FLS( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FL__S__lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FL__S__lgt_1 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08442415105) => 0.0153361608,
      (f_add_curr_nhood_VAC_pct_i > 0.08442415105) => 0.1972725273,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0379946303, 0.0379946303),
   (r_Ever_Asset_Owner_d > 0.5) => -0.0390975394,
   (r_Ever_Asset_Owner_d = NULL) => -0.0225975119, -0.0225975119),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 0.4047724862,
      (nf_vf_hi_risk_index > 6.5) => 0.0440731744,
      (nf_vf_hi_risk_index = NULL) => 0.0883467361, 0.0883467361),
   (f_inq_Communications_count_i > 0.5) => 0.4731802205,
   (f_inq_Communications_count_i = NULL) => 0.1837715096, 0.1837715096),
(f_srchvelocityrisktype_i = NULL) => 0.2508879082, -0.0017531027);

// Tree: 2 
wFDN_FL__S__lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 27.85) => -0.0347752579,
      (c_famotf18_p > 27.85) => 0.0744418993,
      (c_famotf18_p = NULL) => -0.0490700725, -0.0260697303),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.1944405703,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0213035502, -0.0213035502),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 0.0872126630,
      (f_rel_criminal_count_i > 1.5) => 0.3107983930,
      (f_rel_criminal_count_i = NULL) => 0.1667684624, 0.1667684624),
   (f_hh_payday_loan_users_i > 0.5) => 0.4839085152,
   (f_hh_payday_loan_users_i = NULL) => 0.2167720787, 0.2167720787),
(f_varrisktype_i = NULL) => 0.1614618475, -0.0061167861);

// Tree: 3 
wFDN_FL__S__lgt_3 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 
   map(
   (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => 0.1511952577,
   (f_inq_Collection_count24_i > 1.5) => 0.3915530868,
   (f_inq_Collection_count24_i = NULL) => 0.1847675051, 0.1847675051),
(nf_vf_hi_risk_index > 6.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => -0.0243972509,
      (f_rel_felony_count_i > 1.5) => 0.1170656227,
      (f_rel_felony_count_i = NULL) => -0.0186427062, -0.0186427062),
   (f_inq_Communications_count_i > 1.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => 0.1199323582,
      (f_inq_HighRiskCredit_count_i > 1.5) => 0.3379333494,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.1583302601, 0.1583302601),
   (f_inq_Communications_count_i = NULL) => -0.0134850242, -0.0134850242),
(nf_vf_hi_risk_index = NULL) => 0.1077896855, -0.0046840157);

// Tree: 4 
wFDN_FL__S__lgt_4 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.35) => 0.0874542061,
      (c_fammar_p > 44.35) => -0.0304419419,
      (c_fammar_p = NULL) => -0.0256152747, -0.0242364887),
   (f_assocsuspicousidcount_i > 14.5) => 0.3811130115,
   (f_assocsuspicousidcount_i = NULL) => -0.0221262575, -0.0221262575),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0461367304,
   (f_assocrisktype_i > 4.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.1467553902,
      (f_varrisktype_i > 2.5) => 0.2792124592,
      (f_varrisktype_i = NULL) => 0.1987814173, 0.1987814173),
   (f_assocrisktype_i = NULL) => 0.0883211323, 0.0883211323),
(f_srchvelocityrisktype_i = NULL) => 0.0981872260, -0.0069075851);

// Tree: 5 
wFDN_FL__S__lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 27.35) => -0.0246775842,
   (c_famotf18_p > 27.35) => 0.0705353631,
   (c_famotf18_p = NULL) => -0.0154728684, -0.0166098320),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0493144516,
   (f_assocrisktype_i > 4.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0760515840,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.2364130269,
      (nf_seg_FraudPoint_3_0 = '') => 0.1797583854, 0.1797583854),
   (f_assocrisktype_i = NULL) => 0.0804791683, 0.0804791683),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0270242902,
   (f_addrs_per_ssn_i > 5.5) => 0.2467532592,
   (f_addrs_per_ssn_i = NULL) => 0.0914764401, 0.0914764401), -0.0047679729);

// Tree: 6 
wFDN_FL__S__lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2825450063,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0333166837,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.0330566075,
         (nf_seg_FraudPoint_3_0 = '') => -0.0205266416, -0.0205266416),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0189179539, -0.0189179539),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.1785405915,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0142718705, -0.0142718705),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1870834919,
   (r_I60_inq_comm_recency_d > 549) => 0.0849467930,
   (r_I60_inq_comm_recency_d = NULL) => 0.1254935227, 0.1254935227),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0618134211, -0.0090948989);

// Tree: 7 
wFDN_FL__S__lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0260975390,
   (f_assocrisktype_i > 3.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 133282.5) => 0.2676969345,
         (c_med_hval > 133282.5) => 0.1061382253,
         (c_med_hval = NULL) => 0.0088073044, 0.1356109207),
      (r_Ever_Asset_Owner_d > 0.5) => 0.0058683004,
      (r_Ever_Asset_Owner_d = NULL) => 0.0308861423, 0.0308861423),
   (f_assocrisktype_i = NULL) => -0.0128828436, -0.0128828436),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 4.5) => 0.0979612524,
   (r_C14_addrs_5yr_i > 4.5) => 0.2549776438,
   (r_C14_addrs_5yr_i = NULL) => 0.1185599374, 0.1185599374),
(f_inq_Communications_count_i = NULL) => 0.0496780327, -0.0080159705);

// Tree: 8 
wFDN_FL__S__lgt_8 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 0.1032016341,
   (nf_vf_hi_risk_index > 6.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
         map(
         (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0300610425,
         (f_hh_tot_derog_i > 4.5) => 0.0811987757,
         (f_hh_tot_derog_i = NULL) => -0.0253177374, -0.0253177374),
      (f_srchvelocityrisktype_i > 4.5) => 0.0437863354,
      (f_srchvelocityrisktype_i = NULL) => -0.0175807151, -0.0175807151),
   (nf_vf_hi_risk_index = NULL) => -0.0135576169, -0.0135576169),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 2.65) => 0.0720370236,
   (c_hh6_p > 2.65) => 0.2113485986,
   (c_hh6_p = NULL) => 0.1219921844, 0.1219921844),
(f_inq_Communications_count_i = NULL) => 0.0416094108, -0.0087416466);

// Tree: 9 
wFDN_FL__S__lgt_9 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 9.05) => -0.0185303858,
         (c_unemp > 9.05) => 0.0897659986,
         (c_unemp = NULL) => -0.0323739440, -0.0142826822),
      (r_D32_felony_count_i > 0.5) => 0.1826981211,
      (r_D32_felony_count_i = NULL) => -0.0118408396, -0.0118408396),
   (f_inq_PrepaidCards_count24_i > 0.5) => 0.1683042425,
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0098708992, -0.0098708992),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 0.0920441309,
   (r_D30_Derog_Count_i > 11.5) => 0.2794314222,
   (r_D30_Derog_Count_i = NULL) => 0.1128221878, 0.1128221878),
(r_D33_eviction_count_i = NULL) => 0.0799905718, -0.0042608132);

// Tree: 10 
wFDN_FL__S__lgt_10 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 63.55) => 0.0320913339,
      (c_fammar_p > 63.55) => -0.0253691184,
      (c_fammar_p = NULL) => -0.0330793849, -0.0151501077),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.2471803030,
      (f_corrssnnamecount_d > 3.5) => 0.0545871998,
      (f_corrssnnamecount_d = NULL) => 0.0857206713, 0.0857206713),
   (f_rel_felony_count_i = NULL) => -0.0107471496, -0.0107471496),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1609466026,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0635760500,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.1033137620, 0.1033137620),
(f_srchfraudsrchcount_i = NULL) => 0.0251968960, -0.0070603201);

// Tree: 11 
wFDN_FL__S__lgt_11 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 61.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0578025873,
   (f_assocrisktype_i > 4.5) => 0.1235544953,
   (f_assocrisktype_i = NULL) => 0.0785712494, 0.0785712494),
(r_I60_inq_comm_recency_d > 61.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2785611223,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.05) => 
         map(
         (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 18.5) => -0.0191363186,
         (f_srchssnsrchcount_i > 18.5) => 0.1744077110,
         (f_srchssnsrchcount_i = NULL) => -0.0181316733, -0.0181316733),
      (c_unemp > 9.05) => 0.0813389515,
      (c_unemp = NULL) => -0.0298511968, -0.0141234175),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0125675044, -0.0125675044),
(r_I60_inq_comm_recency_d = NULL) => 0.0235702486, -0.0071304060);

// Tree: 12 
wFDN_FL__S__lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 51.2) => 0.2316585348,
      (c_high_ed > 51.2) => -0.0374175334,
      (c_high_ed = NULL) => 0.1406075420, 0.1406075420),
   (r_C10_M_Hdr_FS_d > 7.5) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1391202600,
      (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0131661411,
      (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0117067298, -0.0117067298),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0091974954, -0.0091974954),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1434903097,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0400999988,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0818085902, 0.0818085902),
(f_srchfraudsrchcount_i = NULL) => 0.0561162567, -0.0059924850);

// Tree: 13 
wFDN_FL__S__lgt_13 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.05) => -0.0128904887,
   (c_unemp > 11.05) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.2520872554,
      (k_estimated_income_d > 28500) => 0.0409491951,
      (k_estimated_income_d = NULL) => 0.1187369015, 0.1187369015),
   (c_unemp = NULL) => -0.0270126855, -0.0109485755),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 0.0250062928,
   (f_rel_criminal_count_i > 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 6.05) => 0.1680622256,
      (c_construction > 6.05) => 0.0423160681,
      (c_construction = NULL) => 0.1099919514, 0.1099919514),
   (f_rel_criminal_count_i = NULL) => 0.0617160744, 0.0617160744),
(f_varrisktype_i = NULL) => 0.0173948206, -0.0067946480);

// Tree: 14 
wFDN_FL__S__lgt_14 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 24.6) => 0.0657126303,
   (c_famotf18_p > 24.6) => 0.1660965656,
   (c_famotf18_p = NULL) => 0.0870925759, 0.0870925759),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.45) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0846000416) => 0.0133464874,
         (f_add_curr_nhood_VAC_pct_i > 0.0846000416) => 0.1337299557,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0502151977, 0.0502151977),
      (c_fammar_p > 44.45) => -0.0170825920,
      (c_fammar_p = NULL) => -0.0352784918, -0.0141522333),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.0860597133,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0117753369, -0.0117753369),
(nf_vf_hi_risk_hit_type = NULL) => 0.0085276608, -0.0076626394);

// Tree: 15 
wFDN_FL__S__lgt_15 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0846830141,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 30.85) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 83.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0206431359,
         (f_varrisktype_i > 4.5) => 0.0700004508,
         (f_varrisktype_i = NULL) => -0.0186313885, -0.0186313885),
      (k_comb_age_d > 83.5) => 0.2507662600,
      (k_comb_age_d = NULL) => -0.0164047617, -0.0164047617),
   (c_famotf18_p > 30.85) => 0.0656803437,
   (c_famotf18_p = NULL) => -0.0286104282, -0.0113253208),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0757615898,
   (r_S66_adlperssn_count_i > 1.5) => 0.1482676223,
   (r_S66_adlperssn_count_i = NULL) => 0.0448695244, 0.0448695244), -0.0081731176);

// Tree: 16 
wFDN_FL__S__lgt_16 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => 0.0282054860,
      (f_inq_HighRiskCredit_count_i > 4.5) => 0.1159715296,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0349827867, 0.0349827867),
   (r_D30_Derog_Count_i > 5.5) => 0.1493073020,
   (r_D30_Derog_Count_i = NULL) => 0.0476418961, 0.0476418961),
(r_I60_inq_comm_recency_d > 549) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => -0.0249777115,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0118463736,
      (f_varrisktype_i > 3.5) => 0.1035171234,
      (f_varrisktype_i = NULL) => 0.0152452674, 0.0152452674),
   (nf_seg_FraudPoint_3_0 = '') => -0.0086979064, -0.0086979064),
(r_I60_inq_comm_recency_d = NULL) => 0.0099633429, -0.0033397254);

// Tree: 17 
wFDN_FL__S__lgt_17 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 173.5) => -0.0323087172,
   (r_A50_pb_average_dollars_d > 173.5) => 
      map(
      (NULL < c_employees and c_employees <= 33.5) => 0.0870921435,
      (c_employees > 33.5) => 0.0012244649,
      (c_employees = NULL) => 0.0194007964, 0.0125006092),
   (r_A50_pb_average_dollars_d = NULL) => -0.0132479504, -0.0132479504),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < c_health and c_health <= 25.15) => 0.0442866178,
   (c_health > 25.15) => 0.2074160567,
   (c_health = NULL) => 0.0673520508, 0.0673520508),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0638596466,
   (f_addrs_per_ssn_i > 3.5) => 0.1144870056,
   (f_addrs_per_ssn_i = NULL) => 0.0224827803, 0.0224827803), -0.0097668883);

// Tree: 18 
wFDN_FL__S__lgt_18 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
      map(
      (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
         map(
         (NULL < c_white_col and c_white_col <= 20.05) => 0.0587090450,
         (c_white_col > 20.05) => 
            map(
            (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 0.0886622432,
            (f_M_Bureau_ADL_FS_noTU_d > 7.5) => -0.0177796192,
            (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0158436121, -0.0158436121),
         (c_white_col = NULL) => -0.0062968457, -0.0117291243),
      (f_srchunvrfdaddrcount_i > 0.5) => 0.0751649107,
      (f_srchunvrfdaddrcount_i = NULL) => -0.0096592060, -0.0096592060),
   (f_hh_collections_ct_i > 4.5) => 0.1391096249,
   (f_hh_collections_ct_i = NULL) => -0.0076124227, -0.0076124227),
(r_D33_eviction_count_i > 2.5) => 0.1132520475,
(r_D33_eviction_count_i = NULL) => 0.0107255447, -0.0061916134);

// Tree: 19 
wFDN_FL__S__lgt_19 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 36.5) => 0.1621988135,
   (r_D32_Mos_Since_Crim_LS_d > 36.5) => 0.0334553191,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0444390298, 0.0444390298),
(f_mos_inq_banko_cm_lseen_d > 44.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0223476839,
      (k_comb_age_d > 70.5) => 0.0808318664,
      (k_comb_age_d = NULL) => -0.0163681865, -0.0163681865),
   (f_varrisktype_i > 2.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.0308011249,
      (f_assocrisktype_i > 7.5) => 0.1392074083,
      (f_assocrisktype_i = NULL) => 0.0384662157, 0.0384662157),
   (f_varrisktype_i = NULL) => -0.0106319075, -0.0106319075),
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0043853733, -0.0011656555);

// Tree: 20 
wFDN_FL__S__lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0115176362,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 168) => 0.0410648191,
      (c_sub_bus > 168) => 0.3024831353,
      (c_sub_bus = NULL) => 0.0769881970, 0.0769881970),
   (k_comb_age_d = NULL) => -0.0065843946, -0.0065843946),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 10.75) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 11.5) => 0.0310977441,
      (f_assocsuspicousidcount_i > 11.5) => 0.1504434601,
      (f_assocsuspicousidcount_i = NULL) => 0.0361405208, 0.0361405208),
   (c_unemp > 10.75) => 0.1749580332,
   (c_unemp = NULL) => 0.0415679724, 0.0415679724),
(f_varrisktype_i = NULL) => 0.0339723029, -0.0010183750);

// Tree: 21 
wFDN_FL__S__lgt_21 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 60.5) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => 0.0153964632,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.1141813997,
         (nf_seg_FraudPoint_3_0 = '') => 0.0674630460, 0.0674630460),
      (r_Prop_Owner_History_d > 1.5) => -0.0070092810,
      (r_Prop_Owner_History_d = NULL) => 0.0209122840, 0.0209122840),
   (c_ab_av_edu > 60.5) => -0.0196436615,
   (c_ab_av_edu = NULL) => -0.0072108026, -0.0135660569),
(f_assocrisktype_i > 7.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 120) => 0.1969057668,
   (f_M_Bureau_ADL_FS_all_d > 120) => 0.0274020010,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0492734547, 0.0492734547),
(f_assocrisktype_i = NULL) => 0.0015340123, -0.0094149371);

// Tree: 22 
wFDN_FL__S__lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0158474558,
(f_assocrisktype_i > 3.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0471191261,
      (f_rel_criminal_count_i > 2.5) => 0.2583221432,
      (f_rel_criminal_count_i = NULL) => 0.1508679766, 0.1508679766),
   (r_C12_source_profile_index_d > 1.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0177245143,
      (r_D33_eviction_count_i > 0.5) => 
         map(
         (NULL < c_apt20 and c_apt20 <= 91.5) => 0.0168099744,
         (c_apt20 > 91.5) => 0.1425700578,
         (c_apt20 = NULL) => 0.0884519891, 0.0884519891),
      (r_D33_eviction_count_i = NULL) => 0.0237664359, 0.0237664359),
   (r_C12_source_profile_index_d = NULL) => 0.0286254486, 0.0286254486),
(f_assocrisktype_i = NULL) => 0.0084653791, -0.0051397305);

// Tree: 23 
wFDN_FL__S__lgt_23 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 40.5) => 0.0039801235,
(r_pb_order_freq_d > 40.5) => -0.0285487649,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
      map(
      (NULL < c_professional and c_professional <= 1.35) => 0.0481631689,
      (c_professional > 1.35) => -0.0118408904,
      (c_professional = NULL) => -0.0215379614, 0.0062244772),
   (f_assocrisktype_i > 7.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 72) => 0.2143770413,
         (f_prevaddrageoldest_d > 72) => 0.0168969607,
         (f_prevaddrageoldest_d = NULL) => 0.1525887952, 0.1525887952),
      (r_C12_Num_NonDerogs_d > 2.5) => 0.0290727891,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0824762612, 0.0824762612),
   (f_assocrisktype_i = NULL) => 0.0113951578, 0.0122054536), -0.0042801708);

// Tree: 24 
wFDN_FL__S__lgt_24 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 115) => 0.1751175722,
(r_D32_Mos_Since_Fel_LS_d > 115) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 86.5) => -0.0058461889,
   (r_pb_order_freq_d > 86.5) => -0.0354738837,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 5.5) => 0.0059891328,
         (k_inq_per_ssn_i > 5.5) => 0.1125508137,
         (k_inq_per_ssn_i = NULL) => 0.0093849494, 0.0093849494),
      (f_rel_criminal_count_i > 6.5) => 
         map(
         (NULL < C_INC_15K_P and C_INC_15K_P <= 6.55) => 0.0181677459,
         (C_INC_15K_P > 6.55) => 0.1322512720,
         (C_INC_15K_P = NULL) => 0.0884545004, 0.0884545004),
      (f_rel_criminal_count_i = NULL) => 0.0147598927, 0.0147598927), -0.0058955556),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0056617772, -0.0047961367);

// Tree: 25 
wFDN_FL__S__lgt_25 := map(
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.65) => -0.0160885787,
   (c_pop_0_5_p > 19.65) => 0.2531862055,
   (c_pop_0_5_p = NULL) => -0.0228683783, -0.0147424311),
(nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => 0.0212146511,
   (C_INC_50K_P > 19.85) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 69) => 0.2347316246,
      (r_D32_Mos_Since_Crim_LS_d > 69) => 
         map(
         (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 134.5) => -0.0794023780,
         (f_mos_liens_unrel_CJ_lseen_d > 134.5) => 0.1153163900,
         (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0775572372, 0.0775572372),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.1051489792, 0.1051489792),
   (C_INC_50K_P = NULL) => -0.0069682709, 0.0295628358),
(nf_seg_FraudPoint_3_0 = '') => -0.0048754718, -0.0048754718);

// Tree: 26 
wFDN_FL__S__lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_employees and c_employees <= 29.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 5.15) => 0.0267731553,
      (c_hh7p_p > 5.15) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => 0.0629318831,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.2107630113,
         (nf_seg_FraudPoint_3_0 = '') => 0.1262880809, 0.1262880809),
      (c_hh7p_p = NULL) => 0.0426585615, 0.0426585615),
   (c_employees > 29.5) => -0.0064715291,
   (c_employees = NULL) => 0.0176984574, -0.0011714981),
(r_D30_Derog_Count_i > 11.5) => 0.1036535601,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => -0.0444050265,
   (f_addrs_per_ssn_i > 7.5) => 0.0827590094,
   (f_addrs_per_ssn_i = NULL) => 0.0026927646, 0.0026927646), 0.0002744566);

// Tree: 27 
wFDN_FL__S__lgt_27 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0606740873,
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 25462.5) => 0.1269208862,
      (r_A46_Curr_AVM_AutoVal_d > 25462.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 6.5) => 0.1514778763,
         (f_M_Bureau_ADL_FS_noTU_d > 6.5) => -0.0214027099,
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0190274262, -0.0190274262),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0120645766, -0.0148341280),
   (k_inq_per_ssn_i > 2.5) => 0.0438093797,
   (k_inq_per_ssn_i = NULL) => -0.0079554371, -0.0079554371),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 11.9) => 0.0658904985,
   (C_INC_50K_P > 11.9) => -0.0547995319,
   (C_INC_50K_P = NULL) => 0.0123586302, 0.0123586302), -0.0052108215);

// Tree: 28 
wFDN_FL__S__lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 29.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 6.5) => -0.0110276923,
      (f_inq_HighRiskCredit_count_i > 6.5) => 0.1364431821,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0083060835, -0.0083060835),
   (r_pb_order_freq_d > 29.5) => -0.0271987682,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0034344481,
      (f_assocrisktype_i > 4.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 71.5) => 0.1292780125,
         (c_rest_indx > 71.5) => 0.0404864714,
         (c_rest_indx = NULL) => 0.0631261056, 0.0631261056),
      (f_assocrisktype_i = NULL) => 0.0140648152, 0.0140648152), -0.0070365667),
(r_D33_eviction_count_i > 2.5) => 0.0951050368,
(r_D33_eviction_count_i = NULL) => -0.0037399365, -0.0059152209);

// Tree: 29 
wFDN_FL__S__lgt_29 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 173.5) => -0.0132590380,
   (c_sub_bus > 173.5) => 0.0314436250,
   (c_sub_bus = NULL) => -0.0431134823, -0.0078970265),
(k_inq_per_ssn_i > 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0088107254,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 76.5) => -0.0254487039,
      (c_span_lang > 76.5) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.05) => 0.0177526713,
         (c_pop_45_54_p > 13.05) => 0.1739820203,
         (c_pop_45_54_p = NULL) => 0.1007730983, 0.1007730983),
      (c_span_lang = NULL) => 0.0681997300, 0.0681997300),
   (nf_seg_FraudPoint_3_0 = '') => 0.0267465810, 0.0267465810),
(k_inq_per_ssn_i = NULL) => -0.0053107044, -0.0053107044);

// Tree: 30 
wFDN_FL__S__lgt_30 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.35) => 0.0212706887,
   (c_unemp > 11.35) => 0.1472406417,
   (c_unemp = NULL) => 0.0595476181, 0.0251382238),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
      map(
      (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 2.5) => -0.0192341262,
      (f_srchunvrfdphonecount_i > 2.5) => 0.0942403057,
      (f_srchunvrfdphonecount_i = NULL) => -0.0186098637, -0.0186098637),
   (f_hh_tot_derog_i > 5.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 7.55) => 0.0319463963,
      (c_femdiv_p > 7.55) => 0.2067831318,
      (c_femdiv_p = NULL) => 0.0597286721, 0.0597286721),
   (f_hh_tot_derog_i = NULL) => -0.0157200387, -0.0157200387),
(f_hh_members_ct_d = NULL) => -0.0060526181, -0.0073690311);

// Tree: 31 
wFDN_FL__S__lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1248260425,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => -0.0052753611,
      (k_comb_age_d > 71.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 1.95) => 0.1985576629,
         (C_INC_150K_P > 1.95) => 0.0488456941,
         (C_INC_150K_P = NULL) => 0.0728968949, 0.0728968949),
      (k_comb_age_d = NULL) => -0.0017040717, -0.0017040717),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0011065628, -0.0011065628),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1627652021,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_health and c_health <= 11.85) => -0.0458008689,
   (c_health > 11.85) => 0.0692265403,
   (c_health = NULL) => -0.0018198007, -0.0018198007), -0.0004426139);

// Tree: 32 
wFDN_FL__S__lgt_32 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 43.75) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 73.45) => 0.0504868136,
         (c_sfdu_p > 73.45) => 0.1926042620,
         (c_sfdu_p = NULL) => 0.0679682309, 0.0679682309),
      (r_A44_curr_add_naprop_d > 2.5) => -0.0349458288,
      (r_A44_curr_add_naprop_d = NULL) => 0.0349911251, 0.0349911251),
   (c_fammar_p > 43.75) => -0.0047608268,
   (c_fammar_p = NULL) => -0.0011390896, -0.0025998626),
(f_inq_PrepaidCards_count24_i > 0.5) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 1.35) => 0.1224712941,
   (c_pop_85p_p > 1.35) => 0.0035078555,
   (c_pop_85p_p = NULL) => 0.0732450436, 0.0732450436),
(f_inq_PrepaidCards_count24_i = NULL) => 0.0218649490, -0.0014428240);

// Tree: 33 
wFDN_FL__S__lgt_33 := map(
(NULL < c_white_col and c_white_col <= 16.15) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 139.5) => 0.0385323522,
   (c_old_homes > 139.5) => 0.1525523063,
   (c_old_homes = NULL) => 0.0738242427, 0.0738242427),
(c_white_col > 16.15) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0133669201,
   (f_rel_criminal_count_i > 2.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
         map(
         (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1276215140,
         (r_I60_inq_PrepaidCards_recency_d > 549) => 0.0399344124,
         (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0449944284, 0.0449944284),
      (r_C12_Num_NonDerogs_d > 3.5) => -0.0050102240,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0186432291, 0.0186432291),
   (f_rel_criminal_count_i = NULL) => -0.0258693621, -0.0052408909),
(c_white_col = NULL) => -0.0104086261, -0.0035355053);

// Tree: 34 
wFDN_FL__S__lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1130763320,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 2.95) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 0.0700041407,
      (f_corrssnnamecount_d > 1.5) => -0.0127007001,
      (f_corrssnnamecount_d = NULL) => -0.0085795715, -0.0085795715),
   (c_hh7p_p > 2.95) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 34.5) => 0.0229514856,
      (r_pb_order_freq_d > 34.5) => -0.0183603363,
      (r_pb_order_freq_d = NULL) => 0.0634256719, 0.0286984250),
   (c_hh7p_p = NULL) => -0.0066853764, -0.0027522085),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0771018203,
   (f_addrs_per_ssn_i > 4.5) => 0.0568366922,
   (f_addrs_per_ssn_i = NULL) => -0.0071780380, -0.0071780380), -0.0021513482);

// Tree: 35 
wFDN_FL__S__lgt_35 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 13.4) => 0.1621668547,
         (C_RENTOCC_P > 13.4) => 0.0328793670,
         (C_RENTOCC_P = NULL) => 0.0574487604, 0.0574487604),
      (r_I60_inq_comm_recency_d > 549) => 0.0047710589,
      (r_I60_inq_comm_recency_d = NULL) => 0.0095607198, 0.0095607198),
   (f_historical_count_d > 0.5) => -0.0190981128,
   (f_historical_count_d = NULL) => -0.0049265933, -0.0049265933),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < c_child and c_child <= 24.85) => 0.0017421390,
   (c_child > 24.85) => 0.1892953542,
   (c_child = NULL) => 0.0992107390, 0.0992107390),
(f_hh_lienholders_i = NULL) => 0.0117764437, -0.0037056087);

// Tree: 36 
wFDN_FL__S__lgt_36 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 17.85) => 0.0341980522,
      (c_hh2_p > 17.85) => -0.0142583251,
      (c_hh2_p = NULL) => -0.0398910683, -0.0119028198),
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 3.55) => 0.2879694957,
      (c_hval_175k_p > 3.55) => -0.0150821245,
      (c_hval_175k_p = NULL) => 0.0977327122, 0.0977327122),
   (k_comb_age_d = NULL) => -0.0105988460, -0.0105988460),
(r_D32_criminal_count_i > 2.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 65959.5) => 0.1621693456,
   (r_A46_Curr_AVM_AutoVal_d > 65959.5) => 0.0360968318,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0370674581, 0.0459018757),
(r_D32_criminal_count_i = NULL) => -0.0108022691, -0.0074472257);

// Tree: 37 
wFDN_FL__S__lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0081350248,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 87.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => 0.0416199346,
      (r_C13_Curr_Addr_LRes_d > 310.5) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 1.15) => 0.3914500176,
         (c_pop_85p_p > 1.15) => 0.0818837454,
         (c_pop_85p_p = NULL) => 0.2336902827, 0.2336902827),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0520345937, 0.0520345937),
   (c_born_usa > 87.5) => 0.0022163435,
   (c_born_usa = NULL) => 0.0276086910, 0.0276086910),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0625301404,
   (r_S66_adlperssn_count_i > 1.5) => 0.0873692843,
   (r_S66_adlperssn_count_i = NULL) => 0.0172035961, 0.0172035961), 0.0028626967);

// Tree: 38 
wFDN_FL__S__lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0028541213,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.1814217328,
      (nf_seg_FraudPoint_3_0 = '') => 0.0692561477, 0.0692561477),
   (r_D32_Mos_Since_Crim_LS_d > 9.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0322304684,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1278483934) => -0.0001061861,
         (f_add_curr_nhood_BUS_pct_i > 0.1278483934) => 0.0468784357,
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0004291559, 0.0059624205),
      (nf_seg_FraudPoint_3_0 = '') => -0.0073741872, -0.0073741872),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0061538418, -0.0061538418),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1105185269,
(f_inq_PrepaidCards_count_i = NULL) => -0.0040217766, -0.0055532112);

// Tree: 39 
wFDN_FL__S__lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0042241228,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 56.3) => 
         map(
         (NULL < c_rnt2000_p and c_rnt2000_p <= 1.1) => 0.2621638311,
         (c_rnt2000_p > 1.1) => 0.0959225229,
         (c_rnt2000_p = NULL) => 0.1822157211, 0.1822157211),
      (C_OWNOCC_P > 56.3) => 0.0584008206,
      (C_OWNOCC_P = NULL) => 0.1119313551, 0.1119313551),
   (f_inq_count_i > 2.5) => 
      map(
      (NULL < c_pop00 and c_pop00 <= 1141.5) => 0.0679447337,
      (c_pop00 > 1141.5) => -0.0047688427,
      (c_pop00 = NULL) => 0.0117734959, 0.0117734959),
   (f_inq_count_i = NULL) => 0.0319368544, 0.0319368544),
(k_inq_per_ssn_i = NULL) => 0.0001146243, 0.0001146243);

// Tree: 40 
wFDN_FL__S__lgt_40 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0078999765,
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 61.5) => 0.1086878373,
      (r_I61_inq_collection_recency_d > 61.5) => 0.0234753124,
      (r_I61_inq_collection_recency_d = NULL) => 0.0427513952, 0.0427513952),
   (f_inq_Communications_count_i = NULL) => 0.0109783527, 0.0109783527),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => -0.0167570260,
   (f_inq_QuizProvider_count_i > 6.5) => 0.1404554876,
   (f_inq_QuizProvider_count_i = NULL) => -0.0155029376, -0.0155029376),
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_rape and c_rape <= 73) => 0.0846252176,
   (c_rape > 73) => -0.0525942440,
   (c_rape = NULL) => 0.0097782385, 0.0097782385), -0.0021172674);

// Tree: 41 
wFDN_FL__S__lgt_41 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 
   map(
   (NULL < c_construction and c_construction <= 5.05) => 0.1683375171,
   (c_construction > 5.05) => 0.0072995553,
   (c_construction = NULL) => 0.0761302970, 0.0761302970),
(r_I60_inq_comm_recency_d > 4.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1172742793,
   (f_attr_arrest_recency_d > 48) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 21.85) => -0.0148955511,
      (c_hh3_p > 21.85) => 0.0214285509,
      (c_hh3_p = NULL) => -0.0127868527, -0.0076465449),
   (f_attr_arrest_recency_d = NULL) => -0.0070941090, -0.0070941090),
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 86) => 0.0531194655,
   (c_larceny > 86) => -0.0663355950,
   (c_larceny = NULL) => -0.0055782798, -0.0055782798), -0.0062399802);

// Tree: 42 
wFDN_FL__S__lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 222) => 0.0836115080,
(r_D32_Mos_Since_Fel_LS_d > 222) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 5.25) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 2.5) => 0.0123617439,
      (f_hh_lienholders_i > 2.5) => 
         map(
         (NULL < c_families and c_families <= 322) => 0.2171207389,
         (c_families > 322) => 0.0616252382,
         (c_families = NULL) => 0.1307343496, 0.1307343496),
      (f_hh_lienholders_i = NULL) => 0.0167985417, 0.0167985417),
   (c_newhouse > 5.25) => -0.0154863258,
   (c_newhouse = NULL) => -0.0318813377, -0.0053007276),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 0.65) => -0.0698368391,
   (c_hval_80k_p > 0.65) => 0.0526314572,
   (c_hval_80k_p = NULL) => -0.0196923398, -0.0196923398), -0.0046842101);

// Tree: 43 
wFDN_FL__S__lgt_43 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 41.75) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0237511547,
      (f_hh_members_ct_d > 1.5) => -0.0081878455,
      (f_hh_members_ct_d = NULL) => -0.0016305700, -0.0016305700),
   (f_assocsuspicousidcount_i > 13.5) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 109.3) => -0.0104676071,
      (c_oldhouse > 109.3) => 0.1634535019,
      (c_oldhouse = NULL) => 0.0693127181, 0.0693127181),
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 127.5) => 0.0329535531,
      (c_very_rich > 127.5) => -0.0843735045,
      (c_very_rich = NULL) => -0.0171862151, -0.0171862151), -0.0011508290),
(c_hval_60k_p > 41.75) => -0.1069877226,
(c_hval_60k_p = NULL) => 0.0178436599, -0.0011530135);

// Tree: 44 
wFDN_FL__S__lgt_44 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0857050353,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 452.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 7.55) => -0.0088520145,
         (c_hh7p_p > 7.55) => 0.0518012560,
         (c_hh7p_p = NULL) => -0.0036857985, -0.0062510217),
      (r_C13_Curr_Addr_LRes_d > 452.5) => 0.1447901629,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0051318377, -0.0051318377),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.0910536307,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0046846427, -0.0046846427),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 3.65) => 0.0741626822,
   (c_hval_125k_p > 3.65) => -0.0528019918,
   (c_hval_125k_p = NULL) => 0.0102101057, 0.0102101057), -0.0040036000);

// Tree: 45 
wFDN_FL__S__lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0031631864,
(k_comb_age_d > 67.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 19.5) => 0.2304916523,
   (c_born_usa > 19.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 155.5) => 0.0137269426,
      (f_curraddrmurderindex_i > 155.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 74.5) => -0.0373762032,
         (c_exp_prod > 74.5) => 0.2877095450,
         (c_exp_prod = NULL) => 0.1378874176, 0.1378874176),
      (f_curraddrmurderindex_i = NULL) => 0.0317780862, 0.0317780862),
   (c_born_usa = NULL) => 0.0526598508, 0.0526598508),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 11.35) => -0.0556796502,
   (c_rnt1000_p > 11.35) => 0.1044681206,
   (c_rnt1000_p = NULL) => 0.0225604821, 0.0225604821), 0.0011409402);

// Tree: 46 
wFDN_FL__S__lgt_46 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1033100350,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 222.35) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 64.9) => 0.1576596056,
         (r_C12_source_profile_d > 64.9) => -0.0301712723,
         (r_C12_source_profile_d = NULL) => 0.0682641610, 0.0682641610),
      (f_mos_liens_unrel_SC_fseen_d > 87.5) => -0.0103291356,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0087340687, -0.0087340687),
   (c_housingcpi > 222.35) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 71703.5) => 0.1710704367,
      (r_A46_Curr_AVM_AutoVal_d > 71703.5) => 0.0308262451,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0201969726, 0.0289949248),
   (c_housingcpi = NULL) => -0.0074451444, 0.0002105734),
(f_attr_arrest_recency_d = NULL) => -0.0271995087, 0.0006437712);

// Tree: 47 
wFDN_FL__S__lgt_47 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0073748729,
   (k_comb_age_d > 67.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 16.5) => 0.2135478694,
      (c_born_usa > 16.5) => 
         map(
         (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 6.5) => 0.0150077978,
         (f_hh_members_ct_d > 6.5) => 0.1946594889,
         (f_hh_members_ct_d = NULL) => 0.0339302188, 0.0339302188),
      (c_born_usa = NULL) => 0.0467452871, 0.0467452871),
   (k_comb_age_d = NULL) => -0.0033525495, -0.0033525495),
(f_srchfraudsrchcountmo_i > 0.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 179.5) => 0.0364594182,
   (f_prevaddrlenofres_d > 179.5) => 0.2281715623,
   (f_prevaddrlenofres_d = NULL) => 0.0572976948, 0.0572976948),
(f_srchfraudsrchcountmo_i = NULL) => 0.0071492043, -0.0010496853);

// Tree: 48 
wFDN_FL__S__lgt_48 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 124975.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.1818779664,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => 0.0179003079,
      (r_D32_criminal_count_i > 5.5) => 0.1158737378,
      (r_D32_criminal_count_i = NULL) => 0.0212768828, 0.0212768828),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0255696790, 0.0255696790),
(r_A46_Curr_AVM_AutoVal_d > 124975.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1291930291,
   (r_C10_M_Hdr_FS_d > 7.5) => -0.0059684562,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0044629762, -0.0044629762),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 6.5) => -0.0380181696,
   (f_addrs_per_ssn_i > 6.5) => 0.0081507628,
   (f_addrs_per_ssn_i = NULL) => -0.0105948347, -0.0105948347), -0.0025946497);

// Tree: 49 
wFDN_FL__S__lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_nas_lname_verd_d and r_nas_lname_verd_d <= 0.5) => 0.2126550957,
   (r_nas_lname_verd_d > 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 14.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 20.5) => 0.1955603218,
         (r_C13_max_lres_d > 20.5) => -0.0202559965,
         (r_C13_max_lres_d = NULL) => 0.0818367529, 0.0818367529),
      (r_C10_M_Hdr_FS_d > 14.5) => 0.0022464896,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0033550446, 0.0033550446),
   (r_nas_lname_verd_d = NULL) => 0.0042761525, 0.0042761525),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0705239135,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 425) => -0.0644903783,
   (c_families > 425) => 0.0831380177,
   (c_families = NULL) => -0.0007149112, -0.0007149112), 0.0011948683);

// Tree: 50 
wFDN_FL__S__lgt_50 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 235.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0158902907,
   (f_nae_nothing_found_i > 0.5) => 0.2759991912,
   (f_nae_nothing_found_i = NULL) => -0.0134338337, -0.0134338337),
(r_A50_pb_average_dollars_d > 235.5) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 0.0148822877,
   (f_hh_members_w_derog_i > 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 91.5) => 0.1964190669,
      (c_easiqlife > 91.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 2.8) => -0.0238794955,
         (c_hh7p_p > 2.8) => 0.1491362336,
         (c_hh7p_p = NULL) => 0.0327042649, 0.0327042649),
      (c_easiqlife = NULL) => 0.0807272735, 0.0807272735),
   (f_hh_members_w_derog_i = NULL) => 0.0178728775, 0.0178728775),
(r_A50_pb_average_dollars_d = NULL) => 0.0296747061, -0.0004770471);

// Tree: 51 
wFDN_FL__S__lgt_51 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0104797638,
(f_rel_criminal_count_i > 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 37.5) => 0.0207992096,
   (r_pb_order_freq_d > 37.5) => -0.0147249899,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 26.15) => 0.0332168901,
      (C_INC_75K_P > 26.15) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 94) => 0.1962684542,
         (c_new_homes > 94) => 0.0182458180,
         (c_new_homes = NULL) => 0.1175772889, 0.1175772889),
      (C_INC_75K_P = NULL) => 0.0428381587, 0.0428381587), 0.0162717301),
(f_rel_criminal_count_i = NULL) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 33.15) => -0.0634654695,
   (c_hh2_p > 33.15) => 0.0623250041,
   (c_hh2_p = NULL) => 0.0028426871, 0.0028426871), -0.0033522105);

// Tree: 52 
wFDN_FL__S__lgt_52 := map(
(NULL < c_sub_bus and c_sub_bus <= 118.5) => -0.0135888218,
(c_sub_bus > 118.5) => 
   map(
   (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 32.75) => 
         map(
         (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 350) => 
            map(
            (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 192.5) => 0.0292592667,
            (f_curraddrmurderindex_i > 192.5) => -0.0632214611,
            (f_curraddrmurderindex_i = NULL) => 0.0264200980, 0.0264200980),
         (f_acc_damage_amt_total_i > 350) => 0.1967818578,
         (f_acc_damage_amt_total_i = NULL) => 0.0299784052, 0.0299784052),
      (c_high_ed > 32.75) => -0.0121027784,
      (c_high_ed = NULL) => 0.0093145192, 0.0093145192),
   (f_inq_Collection_count24_i > 2.5) => 0.0917108965,
   (f_inq_Collection_count24_i = NULL) => 0.0058042534, 0.0120153334),
(c_sub_bus = NULL) => 0.0036663337, -0.0018808327);

// Tree: 53 
wFDN_FL__S__lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 134.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 31500) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 47.65) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 17448.5) => -0.0532152177,
         (f_curraddrmedianincome_d > 17448.5) => 0.1054211828,
         (f_curraddrmedianincome_d = NULL) => 0.0709587923, 0.0709587923),
      (c_civ_emp > 47.65) => 0.0034826953,
      (c_civ_emp = NULL) => 0.0122145419, 0.0122145419),
   (k_estimated_income_d > 31500) => -0.0264499728,
   (k_estimated_income_d = NULL) => -0.0361994946, -0.0158632157),
(c_easiqlife > 134.5) => 
   map(
   (NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 0.0197030767,
   (f_attr_arrests_i > 0.5) => 0.1159219277,
   (f_attr_arrests_i = NULL) => 0.0210630605, 0.0210630605),
(c_easiqlife = NULL) => 0.0033569018, -0.0029345858);

// Tree: 54 
wFDN_FL__S__lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1294068149,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 38.3) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 23.15) => -0.0018846396,
      (C_INC_25K_P > 23.15) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3083443751) => 
            map(
            (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 6.5) => 0.0070231214,
            (f_addrs_per_ssn_i > 6.5) => 0.1851233902,
            (f_addrs_per_ssn_i = NULL) => 0.1141323740, 0.1141323740),
         (f_add_curr_mobility_index_i > 0.3083443751) => -0.0174284391,
         (f_add_curr_mobility_index_i = NULL) => 0.0612878633, 0.0612878633),
      (C_INC_25K_P = NULL) => -0.0006383971, -0.0006383971),
   (c_hval_60k_p > 38.3) => -0.1026628097,
   (c_hval_60k_p = NULL) => -0.0215540235, -0.0018799749),
(f_attr_arrest_recency_d = NULL) => 0.0099032819, -0.0012603062);

// Tree: 55 
wFDN_FL__S__lgt_55 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.11136374205) => 0.0092719283,
   (f_add_curr_nhood_VAC_pct_i > 0.11136374205) => 
      map(
      (NULL < c_unemp and c_unemp <= 11.5) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 60.5) => 0.1503395898,
         (c_mort_indx > 60.5) => 
            map(
            (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.35) => 0.0721094951,
            (c_pop_6_11_p > 8.35) => -0.0642988573,
            (c_pop_6_11_p = NULL) => 0.0166114503, 0.0166114503),
         (c_mort_indx = NULL) => 0.0357505234, 0.0357505234),
      (c_unemp > 11.5) => 0.1299873377,
      (c_unemp = NULL) => 0.0445313248, 0.0445313248),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0140974880, 0.0140974880),
(k_estimated_income_d > 34500) => -0.0179461480,
(k_estimated_income_d = NULL) => 0.0029997106, -0.0065774793);

// Tree: 56 
wFDN_FL__S__lgt_56 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0045420986,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 52.5) => 
         map(
         (NULL < c_assault and c_assault <= 154.5) => -0.0070916497,
         (c_assault > 154.5) => 0.0743461273,
         (c_assault = NULL) => 0.0041810151, 0.0041810151),
      (k_comb_age_d > 52.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 19.85) => 0.0501234000,
         (c_pop_35_44_p > 19.85) => 0.2570355844,
         (c_pop_35_44_p = NULL) => 0.0812848735, 0.0812848735),
      (k_comb_age_d = NULL) => 0.0216690263, 0.0216690263),
   (f_hh_tot_derog_i > 5.5) => 0.1269902911,
   (f_hh_tot_derog_i = NULL) => 0.0255799788, 0.0255799788),
(k_inq_per_ssn_i = NULL) => -0.0008899303, -0.0008899303);

// Tree: 57 
wFDN_FL__S__lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 1654.5) => -0.0075989931,
   (c_med_rent > 1654.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 13.95) => 0.0304882167,
      (c_hh5_p > 13.95) => 0.1868563430,
      (c_hh5_p = NULL) => 0.0532959285, 0.0532959285),
   (c_med_rent = NULL) => -0.0190684469, -0.0039194405),
(r_D30_Derog_Count_i > 11.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 103.5) => 0.1158691756,
   (c_medi_indx > 103.5) => -0.0182575530,
   (c_medi_indx = NULL) => 0.0488058113, 0.0488058113),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_highrent and c_highrent <= 0.7) => 0.0572004794,
   (c_highrent > 0.7) => -0.0539326947,
   (c_highrent = NULL) => -0.0054686038, -0.0054686038), -0.0032668525);

// Tree: 58 
wFDN_FL__S__lgt_58 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 68.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.6) => 0.1906422938,
   (r_C12_source_profile_d > 60.6) => -0.0247954774,
   (r_C12_source_profile_d = NULL) => 0.0732480592, 0.0732480592),
(f_mos_liens_unrel_SC_fseen_d > 68.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => -0.0044210227,
      (r_S66_adlperssn_count_i > 3.5) => 0.0497223452,
      (r_S66_adlperssn_count_i = NULL) => -0.0017560647, -0.0017560647),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0607589484,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0042789794, -0.0042789794),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.85) => -0.0577598028,
   (C_INC_75K_P > 15.85) => 0.0560519439,
   (C_INC_75K_P = NULL) => 0.0068621212, 0.0068621212), -0.0031502943);

// Tree: 59 
wFDN_FL__S__lgt_59 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0356111748,
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 9.5) => 0.0891145563,
      (r_C21_M_Bureau_ADL_FS_d > 9.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 218.4) => -0.0087013061,
         (c_cpiall > 218.4) => 0.0266864226,
         (c_cpiall = NULL) => -0.0094029589, -0.0009055341),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0220539234, 0.0001543593),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 89.5) => 0.2530093349,
      (c_mort_indx > 89.5) => 0.0183751301,
      (c_mort_indx = NULL) => 0.1298263774, 0.1298263774),
   (f_nae_nothing_found_i = NULL) => 0.0016347743, 0.0016347743),
(f_addrs_per_ssn_i = NULL) => -0.0047485677, -0.0047485677);

// Tree: 60 
wFDN_FL__S__lgt_60 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => -0.0046528043,
   (k_inq_per_ssn_i > 3.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 19.25) => 0.0156605704,
      (c_hh4_p > 19.25) => 
         map(
         (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => 0.2189410871,
         (f_inq_count_i > 5.5) => 0.0194050833,
         (f_inq_count_i = NULL) => 0.0960895083, 0.0960895083),
      (c_hh4_p = NULL) => 0.0400185029, 0.0400185029),
   (k_inq_per_ssn_i = NULL) => -0.0015939579, -0.0015939579),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0779612152,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 11.75) => 0.0437072101,
   (C_INC_50K_P > 11.75) => -0.0711300187,
   (C_INC_50K_P = NULL) => -0.0084038013, -0.0084038013), -0.0020217431);

// Tree: 61 
wFDN_FL__S__lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 43.3) => 0.1504302966,
   (r_C12_source_profile_d > 43.3) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 53) => -0.0454379813,
      (f_mos_inq_banko_cm_fseen_d > 53) => 0.0780293500,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0213558209, 0.0213558209),
   (r_C12_source_profile_d = NULL) => 0.0528243914, 0.0528243914),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 41.55) => -0.0043819622,
   (c_hval_750k_p > 41.55) => 0.0476647978,
   (c_hval_750k_p = NULL) => -0.0094278157, -0.0012099799),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0882787466,
   (c_rnt1000_p > 10.8) => 0.0277329419,
   (c_rnt1000_p = NULL) => -0.0282012651, -0.0282012651), -0.0004280849);

// Tree: 62 
wFDN_FL__S__lgt_62 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 438.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 40.65) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 9.45) => 
         map(
         (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 15.5) => 0.0271607360,
         (f_rel_ageover30_count_d > 15.5) => 0.1127868580,
         (f_rel_ageover30_count_d = NULL) => 0.0377940453, 0.0377940453),
      (c_hh1_p > 9.45) => -0.0019110014,
      (c_hh1_p = NULL) => 0.0016588403, 0.0016588403),
   (c_hval_80k_p > 40.65) => -0.0940261623,
   (c_hval_80k_p = NULL) => -0.0038009561, 0.0006742629),
(f_prevaddrlenofres_d > 438.5) => 0.2113356502,
(f_prevaddrlenofres_d = NULL) => 
   map(
   (NULL < c_work_home and c_work_home <= 134) => 0.0771428793,
   (c_work_home > 134) => -0.0336626462,
   (c_work_home = NULL) => 0.0270395113, 0.0270395113), 0.0018474416);

// Tree: 63 
wFDN_FL__S__lgt_63 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 20.55) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
      map(
      (NULL < r_nas_fname_verd_d and r_nas_fname_verd_d <= 0.5) => 0.2010317480,
      (r_nas_fname_verd_d > 0.5) => 0.0004816910,
      (r_nas_fname_verd_d = NULL) => 0.0015021229, 0.0015021229),
   (r_D32_felony_count_i > 0.5) => 0.0680268450,
   (r_D32_felony_count_i = NULL) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 94) => -0.0739860697,
      (c_no_teens > 94) => 0.0532245235,
      (c_no_teens = NULL) => -0.0029601551, -0.0029601551), 0.0022042058),
(c_hval_80k_p > 20.55) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 23.5) => 0.0614650318,
   (k_comb_age_d > 23.5) => -0.0616142378,
   (k_comb_age_d = NULL) => -0.0456783544, -0.0456783544),
(c_hval_80k_p = NULL) => 0.0212169630, -0.0000994815);

// Tree: 64 
wFDN_FL__S__lgt_64 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0750496224,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 270.5) => -0.0055586929,
   (r_C13_Curr_Addr_LRes_d > 270.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 233.45) => 
         map(
         (NULL < c_rich_fam and c_rich_fam <= 146.5) => -0.0108232913,
         (c_rich_fam > 146.5) => 0.1065060081,
         (c_rich_fam = NULL) => 0.0249273541, 0.0249273541),
      (c_cpiall > 233.45) => 0.2197281093,
      (c_cpiall = NULL) => 0.0418428259, 0.0418428259),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0014011317, -0.0014011317),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 101) => 0.0349629237,
   (c_apt20 > 101) => -0.0694193699,
   (c_apt20 = NULL) => -0.0052435894, -0.0052435894), -0.0010093025);

// Tree: 65 
wFDN_FL__S__lgt_65 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 63.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.35) => 
      map(
      (NULL < r_C20_email_domain_ISP_count_i and r_C20_email_domain_ISP_count_i <= 4.5) => -0.0197072151,
      (r_C20_email_domain_ISP_count_i > 4.5) => 0.1409509522,
      (r_C20_email_domain_ISP_count_i = NULL) => -0.0173477023, -0.0173477023),
   (c_hh4_p > 12.35) => 0.0116933808,
   (c_hh4_p = NULL) => 0.0064658809, -0.0003301672),
(k_comb_age_d > 63.5) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 11.1) => 0.0326939439,
   (c_femdiv_p > 11.1) => 0.2035907906,
   (c_femdiv_p = NULL) => 0.0397102367, 0.0397102367),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 102.5) => 0.0641187129,
   (c_robbery > 102.5) => -0.0668182983,
   (c_robbery = NULL) => 0.0077150773, 0.0077150773), 0.0042029851);

// Tree: 66 
wFDN_FL__S__lgt_66 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0045973908,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 32.5) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 15.7) => 0.1385941928,
         (c_rnt1250_p > 15.7) => -0.0410840673,
         (c_rnt1250_p = NULL) => 0.0779710400, 0.0779710400),
      (c_born_usa > 32.5) => 0.0071278921,
      (c_born_usa = NULL) => 0.0172896498, 0.0172896498),
   (f_srchfraudsrchcountmo_i > 0.5) => 0.1041832003,
   (f_srchfraudsrchcountmo_i = NULL) => 0.0213200519, 0.0213200519),
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 110.5) => 0.0513532569,
   (c_sub_bus > 110.5) => -0.0586885920,
   (c_sub_bus = NULL) => 0.0023565213, 0.0023565213), -0.0008210342);

// Tree: 67 
wFDN_FL__S__lgt_67 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 33500) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 6.5) => 0.0252617636,
      (f_prevaddrlenofres_d > 6.5) => -0.0535195556,
      (f_prevaddrlenofres_d = NULL) => -0.0058558362, -0.0058558362),
   (k_estimated_income_d > 33500) => -0.0603797306,
   (k_estimated_income_d = NULL) => -0.0830726065, -0.0321388016),
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 19.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 8.85) => 0.0162545095,
      (c_rnt1000_p > 8.85) => 0.1946391318,
      (c_rnt1000_p = NULL) => 0.1185836727, 0.1185836727),
   (k_comb_age_d > 19.5) => 0.0035701745,
   (k_comb_age_d = NULL) => 0.0303955495, 0.0052025611),
(f_addrs_per_ssn_i = NULL) => -0.0012501206, -0.0012501206);

// Tree: 68 
wFDN_FL__S__lgt_68 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.38161842995) => 0.0024421377,
   (f_add_curr_mobility_index_i > 0.38161842995) => -0.0277518791,
   (f_add_curr_mobility_index_i = NULL) => 0.0718771585, -0.0013578987),
(k_comb_age_d > 73.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0303677827) => 0.2285606700,
   (f_add_curr_nhood_MFD_pct_i > 0.0303677827) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 135.5) => -0.0190183246,
      (c_exp_prod > 135.5) => 0.1466676338,
      (c_exp_prod = NULL) => 0.0114257384, 0.0114257384),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0330221942, 0.0539983840),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_highrent and c_highrent <= 0.15) => 0.0363372863,
   (c_highrent > 0.15) => -0.0696045740,
   (c_highrent = NULL) => -0.0186867807, -0.0186867807), 0.0005215458);

// Tree: 69 
wFDN_FL__S__lgt_69 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0072200253,
      (f_nae_nothing_found_i > 0.5) => 0.0952257834,
      (f_nae_nothing_found_i = NULL) => -0.0058894523, -0.0058894523),
   (f_inq_Communications_count24_i > 2.5) => 0.0707634636,
   (f_inq_Communications_count24_i = NULL) => 
      map(
      (NULL < C_INC_201K_P and C_INC_201K_P <= 2.75) => -0.0870152077,
      (C_INC_201K_P > 2.75) => 0.0358510590,
      (C_INC_201K_P = NULL) => -0.0186460754, -0.0186460754), -0.0055069722),
(k_inq_per_ssn_i > 10.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 21.5) => 0.1487696156,
   (c_hh1_p > 21.5) => 0.0075368669,
   (c_hh1_p = NULL) => 0.0696792764, 0.0696792764),
(k_inq_per_ssn_i = NULL) => -0.0046001140, -0.0046001140);

// Tree: 70 
wFDN_FL__S__lgt_70 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 155.5) => -0.0155946669,
(r_A50_pb_average_dollars_d > 155.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 74.5) => -0.0021020549,
   (r_C13_Curr_Addr_LRes_d > 74.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 53.45) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 93.5) => -0.0201171361,
         (c_easiqlife > 93.5) => 0.0532695643,
         (c_easiqlife = NULL) => 0.0266626275, 0.0266626275),
      (c_hval_750k_p > 53.45) => 0.2232644559,
      (c_hval_750k_p = NULL) => 0.0424384551, 0.0334691029),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0113403477, 0.0113403477),
(r_A50_pb_average_dollars_d = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 129) => -0.0381526725,
   (c_asian_lang > 129) => 0.0831587603,
   (c_asian_lang = NULL) => 0.0103719006, 0.0103719006), -0.0035165985);

// Tree: 71 
wFDN_FL__S__lgt_71 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.565) => 0.0024912998,
   (c_hhsize > 2.565) => 0.0374998823,
   (c_hhsize = NULL) => -0.0144864964, 0.0175584668),
(k_estimated_income_d > 34500) => 
   map(
   (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => -0.0095472935,
   (f_validationrisktype_i > 1.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 7.95) => 0.1853529396,
      (c_pop_65_74_p > 7.95) => -0.0113935153,
      (c_pop_65_74_p = NULL) => 0.0860057198, 0.0860057198),
   (f_validationrisktype_i = NULL) => -0.0083602266, -0.0083602266),
(k_estimated_income_d = NULL) => 
   map(
   (NULL < c_mort_indx and c_mort_indx <= 107) => -0.0605378081,
   (c_mort_indx > 107) => 0.0612258120,
   (c_mort_indx = NULL) => -0.0098841421, -0.0098841421), 0.0006677239);

// Tree: 72 
wFDN_FL__S__lgt_72 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0076389454,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 113.5) => 
      map(
      (NULL < c_retail and c_retail <= 1.55) => -0.0346478152,
      (c_retail > 1.55) => 
         map(
         (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 94.5) => 0.0905545859,
         (f_fp_prevaddrburglaryindex_i > 94.5) => 0.2173791465,
         (f_fp_prevaddrburglaryindex_i = NULL) => 0.1318463033, 0.1318463033),
      (c_retail = NULL) => 0.0862854128, 0.0862854128),
   (f_M_Bureau_ADL_FS_all_d > 113.5) => 
      map(
      (NULL < c_apt20 and c_apt20 <= 118.5) => -0.0278463789,
      (c_apt20 > 118.5) => 0.0630451173,
      (c_apt20 = NULL) => 0.0029860721, 0.0029860721),
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0242752689, 0.0242752689),
(f_hh_collections_ct_i = NULL) => 0.0040524264, -0.0045726836);

// Tree: 73 
wFDN_FL__S__lgt_73 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 48.5) => -0.0681353525,
   (f_mos_inq_banko_am_lseen_d > 48.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 40.5) => -0.0071622859,
      (k_comb_age_d > 40.5) => 0.0152937143,
      (k_comb_age_d = NULL) => 0.0037446996, 0.0037446996),
   (f_mos_inq_banko_am_lseen_d = NULL) => 0.0011393010, 0.0011393010),
(f_inq_PrepaidCards_count_i > 1.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1019.5) => 0.1158595924,
   (c_popover25 > 1019.5) => -0.0098003688,
   (c_popover25 = NULL) => 0.0510963817, 0.0510963817),
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.65) => -0.0531530132,
   (c_pop_55_64_p > 12.65) => 0.0726290408,
   (c_pop_55_64_p = NULL) => -0.0049207970, -0.0049207970), 0.0016020583);

// Tree: 74 
wFDN_FL__S__lgt_74 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 39.45) => 
      map(
      (NULL < c_robbery and c_robbery <= 125) => -0.0177414723,
      (c_robbery > 125) => 0.1400129820,
      (c_robbery = NULL) => 0.0807067962, 0.0807067962),
   (c_fammar_p > 39.45) => 0.0134700803,
   (c_fammar_p = NULL) => 0.0596629857, 0.0181817917),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 1.5) => -0.0099502166,
   (f_vardobcountnew_i > 1.5) => 0.1481258055,
   (f_vardobcountnew_i = NULL) => -0.0089190101, -0.0089190101),
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 3.65) => 0.0853315352,
   (c_hval_125k_p > 3.65) => -0.0149330619,
   (c_hval_125k_p = NULL) => 0.0286245090, 0.0286245090), -0.0030011932);

// Tree: 75 
wFDN_FL__S__lgt_75 := map(
(NULL < c_employees and c_employees <= 37.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 118.5) => 0.0185194164,
      (c_unempl > 118.5) => 0.1808281186,
      (c_unempl = NULL) => 0.1069568503, 0.1069568503),
   (f_rel_incomeover50_count_d > 0.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 23.85) => 0.0083481806,
      (C_INC_25K_P > 23.85) => 0.1247641110,
      (C_INC_25K_P = NULL) => 0.0131193253, 0.0131193253),
   (f_rel_incomeover50_count_d = NULL) => -0.0193137404, 0.0214492424),
(c_employees > 37.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134.5) => -0.0194001084,
   (f_prevaddrageoldest_d > 134.5) => 0.0155416443,
   (f_prevaddrageoldest_d = NULL) => -0.0142293103, -0.0071092409),
(c_employees = NULL) => -0.0066121448, -0.0036052748);

// Tree: 76 
wFDN_FL__S__lgt_76 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 43.5) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 
      map(
      (NULL < c_work_home and c_work_home <= 113.5) => 0.0850408021,
      (c_work_home > 113.5) => -0.0218253166,
      (c_work_home = NULL) => 0.0367667968, 0.0367667968),
   (r_I61_inq_collection_recency_d > 9) => -0.0042664712,
   (r_I61_inq_collection_recency_d = NULL) => -0.0022726129, -0.0022726129),
(f_rel_incomeover25_count_d > 43.5) => -0.0703541544,
(f_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 23.35) => 
      map(
      (NULL < c_hval_1001k_p and c_hval_1001k_p <= 0.85) => -0.0241661361,
      (c_hval_1001k_p > 0.85) => 0.0958651376,
      (c_hval_1001k_p = NULL) => 0.0046915569, 0.0046915569),
   (c_hh3_p > 23.35) => 0.1550681486,
   (c_hh3_p = NULL) => 0.0306932730, 0.0306932730), -0.0017982727);

// Tree: 77 
wFDN_FL__S__lgt_77 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0150158132,
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 128) => 0.1793567672,
      (c_asian_lang > 128) => 0.0138332162,
      (c_asian_lang = NULL) => 0.0746874629, 0.0746874629),
   (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 96) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2053266326,
         (r_C12_source_profile_d > 57.95) => -0.0064393013,
         (r_C12_source_profile_d = NULL) => 0.0726000966, 0.0726000966),
      (f_mos_liens_unrel_SC_fseen_d > 96) => 0.0081992897,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0095300397, 0.0095300397),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0108127394, 0.0108127394),
(f_util_add_curr_conv_n = NULL) => -0.0007424073, -0.0007424073);

// Tree: 78 
wFDN_FL__S__lgt_78 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.1041765717,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 121.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 90.75) => -0.0155705819,
      (c_high_hval > 90.75) => 0.1711140533,
      (c_high_hval = NULL) => -0.0132184366, -0.0132184366),
   (c_easiqlife > 121.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 0.1176963752,
         (r_C13_max_lres_d > 18.5) => 0.0146203137,
         (r_C13_max_lres_d = NULL) => 0.0167433005, 0.0167433005),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0693815915,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0125487499, 0.0125487499),
   (c_easiqlife = NULL) => -0.0019023890, -0.0019023890),
(C_INC_100K_P = NULL) => -0.0102113005, -0.0015154811);

// Tree: 79 
wFDN_FL__S__lgt_79 := map(
(NULL < c_unattach and c_unattach <= 85.5) => -0.0213163020,
(c_unattach > 85.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 0.0009342463,
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < c_highinc and c_highinc <= 1.35) => -0.0875998444,
      (c_highinc > 1.35) => 
         map(
         (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 0.1312926705,
         (r_I61_inq_collection_recency_d > 9) => 
            map(
            (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.9928737173) => 0.0255746015,
            (f_add_curr_nhood_SFD_pct_d > 0.9928737173) => 0.1678683464,
            (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0346221807, 0.0346221807),
         (r_I61_inq_collection_recency_d = NULL) => 0.0422405153, 0.0422405153),
      (c_highinc = NULL) => 0.0353034800, 0.0353034800),
   (k_inq_per_ssn_i = NULL) => 0.0052331090, 0.0052331090),
(c_unattach = NULL) => 0.0139634425, -0.0038463817);

// Tree: 80 
wFDN_FL__S__lgt_80 := map(
(NULL < c_med_rent and c_med_rent <= 1523.5) => -0.0034113958,
(c_med_rent > 1523.5) => 
   map(
   (NULL < c_armforce and c_armforce <= 138.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 215) => 0.0160244614,
      (f_M_Bureau_ADL_FS_all_d > 215) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 252240.5) => -0.0455551994,
         (r_A46_Curr_AVM_AutoVal_d > 252240.5) => 0.1186071944,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.2406695490, 0.1164343877),
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0685465767, 0.0685465767),
   (c_armforce > 138.5) => -0.0693919740,
   (c_armforce = NULL) => 0.0463778811, 0.0463778811),
(c_med_rent = NULL) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => -0.0062879274,
   (f_srchfraudsrchcountyr_i > 0.5) => 0.1352269422,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0158770522, 0.0158770522), 0.0010514063);

// Tree: 81 
wFDN_FL__S__lgt_81 := map(
(NULL < c_easiqlife and c_easiqlife <= 134.5) => -0.0138424432,
(c_easiqlife > 134.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 121.5) => -0.0035919106,
   (r_C13_Curr_Addr_LRes_d > 121.5) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 26.5) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 3.55) => 
            map(
            (NULL < c_pop_35_44_p and c_pop_35_44_p <= 18.95) => 0.1921025411,
            (c_pop_35_44_p > 18.95) => -0.0032494052,
            (c_pop_35_44_p = NULL) => 0.1252320672, 0.1252320672),
         (c_pop_65_74_p > 3.55) => 0.0151710558,
         (c_pop_65_74_p = NULL) => 0.0403610760, 0.0403610760),
      (f_rel_educationover8_count_d > 26.5) => 0.2492724739,
      (f_rel_educationover8_count_d = NULL) => 0.0498410891, 0.0498410891),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0113798358, 0.0113798358),
(c_easiqlife = NULL) => 0.0374098581, -0.0040424324);

// Tree: 82 
wFDN_FL__S__lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 18.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 11.45) => -0.0028597230,
      (c_hh6_p > 11.45) => 0.0596949554,
      (c_hh6_p = NULL) => -0.0118221084, -0.0015109236),
   (f_srchssnsrchcount_i > 18.5) => 0.0981465506,
   (f_srchssnsrchcount_i = NULL) => -0.0010939803, -0.0010939803),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => -0.1176139772,
   (f_mos_inq_banko_cm_lseen_d > 27.5) => -0.0092572863,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0586679373, -0.0586679373),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 8.15) => 0.0655898440,
   (c_hval_250k_p > 8.15) => -0.0426307288,
   (c_hval_250k_p = NULL) => 0.0190888166, 0.0190888166), -0.0014528922);

// Tree: 83 
wFDN_FL__S__lgt_83 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 0.5) => -0.0019932929,
   (f_addrs_per_ssn_c6_i > 0.5) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 10.45) => -0.0074313996,
      (C_INC_15K_P > 10.45) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 14.95) => 0.0572673027,
         (c_pop_55_64_p > 14.95) => 0.2429620072,
         (c_pop_55_64_p = NULL) => 0.0817503774, 0.0817503774),
      (C_INC_15K_P = NULL) => 0.0261309027, 0.0261309027),
   (f_addrs_per_ssn_c6_i = NULL) => 0.0010136541, 0.0010136541),
(f_rel_felony_count_i > 4.5) => 0.0741603558,
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 3.65) => -0.0450381523,
   (c_rnt500_p > 3.65) => 0.0553170811,
   (c_rnt500_p = NULL) => 0.0058562875, 0.0058562875), 0.0014430614);

// Tree: 84 
wFDN_FL__S__lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 308.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 77.45) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => -0.0008636494,
      (f_hh_lienholders_i > 3.5) => 0.0839017074,
      (f_hh_lienholders_i = NULL) => -0.0000687613, -0.0000687613),
   (c_low_ed > 77.45) => -0.0524370286,
   (c_low_ed = NULL) => -0.0063228138, -0.0016776237),
(r_C13_Curr_Addr_LRes_d > 308.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 0.0276009167,
   (f_srchunvrfdphonecount_i > 0.5) => 0.1589337359,
   (f_srchunvrfdphonecount_i = NULL) => 0.0454208379, 0.0454208379),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 104.05) => 0.0659586355,
   (c_oldhouse > 104.05) => -0.0638283474,
   (c_oldhouse = NULL) => 0.0178893826, 0.0178893826), 0.0012732143);

// Tree: 85 
wFDN_FL__S__lgt_85 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 41.55) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 0.1466701168,
      (f_mos_inq_banko_cm_lseen_d > 37.5) => 0.0176051431,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0485156620, 0.0485156620),
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 12.15) => -0.0058840091,
      (c_unemp > 12.15) => 0.0509884261,
      (c_unemp = NULL) => -0.0051656205, -0.0051656205),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 62.65) => -0.0737825566,
      (C_OWNOCC_P > 62.65) => 0.0407203867,
      (C_OWNOCC_P = NULL) => -0.0069128377, -0.0069128377), -0.0041394934),
(c_hval_80k_p > 41.55) => -0.0854541039,
(c_hval_80k_p = NULL) => 0.0100318662, -0.0045283580);

// Tree: 86 
wFDN_FL__S__lgt_86 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 5.45) => -0.0567117982,
   (c_pop_18_24_p > 5.45) => 0.0809648553,
   (c_pop_18_24_p = NULL) => 0.0483241897, 0.0483241897),
(r_I61_inq_collection_recency_d > 4.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 14.5) => -0.0010482621,
   (f_rel_homeover300_count_d > 14.5) => -0.0589188943,
   (f_rel_homeover300_count_d = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 0.9) => 0.1201504754,
      (c_bigapt_p > 0.9) => -0.0459034581,
      (c_bigapt_p = NULL) => 0.0078886612, 0.0078886612), -0.0026093991),
(r_I61_inq_collection_recency_d = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 11.7) => -0.0759211357,
   (c_pop_25_34_p > 11.7) => 0.0319419351,
   (c_pop_25_34_p = NULL) => -0.0148823437, -0.0148823437), -0.0013859033);

// Tree: 87 
wFDN_FL__S__lgt_87 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 25.75) => -0.0082472249,
(c_famotf18_p > 25.75) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 32.55) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 0.0279033668,
      (f_historical_count_d > 1.5) => -0.0461239136,
      (f_historical_count_d = NULL) => 0.0000851821, 0.0000851821),
   (c_rnt1000_p > 32.55) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 109.5) => 
         map(
         (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 0.0582083529,
         (f_hh_lienholders_i > 0.5) => 0.1879128094,
         (f_hh_lienholders_i = NULL) => 0.1196828609, 0.1196828609),
      (c_relig_indx > 109.5) => 0.0020827871,
      (c_relig_indx = NULL) => 0.0766396966, 0.0766396966),
   (c_rnt1000_p = NULL) => 0.0184726872, 0.0184726872),
(c_famotf18_p = NULL) => -0.0000550388, -0.0053770074);

// Tree: 88 
wFDN_FL__S__lgt_88 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 93) => -0.0286460990,
   (c_lar_fam > 93) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 13.45) => 0.0043398553,
      (c_rnt750_p > 13.45) => 0.2008896897,
      (c_rnt750_p = NULL) => 0.1133506878, 0.1133506878),
   (c_lar_fam = NULL) => 0.0495836122, 0.0495836122),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 74.8) => -0.0003297953,
   (c_rnt1000_p > 74.8) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1740034562) => 0.0935502335,
      (f_add_curr_nhood_MFD_pct_i > 0.1740034562) => 0.2671072521,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0076956479, 0.1041762451),
   (c_rnt1000_p = NULL) => -0.0135004383, 0.0012920079),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0155849544, 0.0019689271);

// Tree: 89 
wFDN_FL__S__lgt_89 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 20.15) => 
   map(
   (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 1.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 47.5) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 156.5) => -0.0524576479,
         (f_prevaddrcartheftindex_i > 156.5) => 0.1194002600,
         (f_prevaddrcartheftindex_i = NULL) => -0.0226400298, -0.0226400298),
      (k_comb_age_d > 47.5) => 0.2202839384,
      (k_comb_age_d = NULL) => 0.0272841942, 0.0272841942),
   (r_C20_email_verification_d > 1.5) => -0.1143659597,
   (r_C20_email_verification_d = NULL) => 0.0015140013, 0.0010581544),
(c_hval_80k_p > 20.15) => 
   map(
   (NULL < c_no_labfor and c_no_labfor <= 142.5) => -0.0637222172,
   (c_no_labfor > 142.5) => 0.0239321433,
   (c_no_labfor = NULL) => -0.0382332519, -0.0382332519),
(c_hval_80k_p = NULL) => 0.0107022026, -0.0010427522);

// Tree: 90 
wFDN_FL__S__lgt_90 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.0726859302,
(r_D32_Mos_Since_Fel_LS_d > 117) => 
   map(
   (NULL < c_retail and c_retail <= 66.6) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 32.25) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0041877384,
         (f_curraddrcrimeindex_i > 189) => 0.0396841959,
         (f_curraddrcrimeindex_i = NULL) => -0.0031249953, -0.0031249953),
      (c_hval_60k_p > 32.25) => -0.0803107065,
      (c_hval_60k_p = NULL) => -0.0039072185, -0.0039072185),
   (c_retail > 66.6) => 0.1157333998,
   (c_retail = NULL) => 0.0010320297, -0.0032788284),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 283) => -0.0626048770,
   (c_employees > 283) => 0.0417178971,
   (c_employees = NULL) => -0.0180224949, -0.0180224949), -0.0030122442);

// Tree: 91 
wFDN_FL__S__lgt_91 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 8.5) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 15.1) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0328326478,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','6: Other']) => 0.1954028797,
         (nf_seg_FraudPoint_3_0 = '') => 0.1163549688, 0.1163549688),
      (c_blue_col > 15.1) => -0.0352756284,
      (c_blue_col = NULL) => 0.0608158547, 0.0608158547),
   (r_D32_Mos_Since_Crim_LS_d > 8.5) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0083617381,
      (f_srchfraudsrchcountmo_i > 0.5) => 0.0362176323,
      (f_srchfraudsrchcountmo_i = NULL) => -0.0068454083, -0.0068454083),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0058954146, -0.0058954146),
(r_D33_eviction_count_i > 3.5) => 0.0655302768,
(r_D33_eviction_count_i = NULL) => 0.0035544316, -0.0053106027);

// Tree: 92 
wFDN_FL__S__lgt_92 := map(
(NULL < c_rich_blk and c_rich_blk <= 181.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 0.0570679935,
   (f_corrssnnamecount_d > 1.5) => -0.0063552027,
   (f_corrssnnamecount_d = NULL) => -0.0140504746, -0.0033964597),
(c_rich_blk > 181.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 18.95) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
         map(
         (NULL < r_C20_email_count_i and r_C20_email_count_i <= 0.5) => 0.2046237721,
         (r_C20_email_count_i > 0.5) => 0.0679444515,
         (r_C20_email_count_i = NULL) => 0.1414526576, 0.1414526576),
      (f_current_count_d > 0.5) => -0.0366391514,
      (f_current_count_d = NULL) => 0.0798054929, 0.0798054929),
   (c_fammar18_p > 18.95) => 0.0175184658,
   (c_fammar18_p = NULL) => 0.0243985840, 0.0243985840),
(c_rich_blk = NULL) => -0.0162155104, 0.0000135793);

// Tree: 93 
wFDN_FL__S__lgt_93 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0053883357,
(f_hh_collections_ct_i > 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 6.45) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 4.5) => 
         map(
         (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => 0.1137047777,
         (r_I60_inq_hiRiskCred_recency_d > 9) => 0.0275413899,
         (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0293560381, 0.0293560381),
      (f_inq_QuizProvider_count_i > 4.5) => 0.1999038818,
      (f_inq_QuizProvider_count_i = NULL) => 0.0331808243, 0.0331808243),
   (c_unemp > 6.45) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 5.5) => 0.0125228428,
      (f_corrssnnamecount_d > 5.5) => -0.0752119118,
      (f_corrssnnamecount_d = NULL) => -0.0275061390, -0.0275061390),
   (c_unemp = NULL) => 0.0446437409, 0.0221175160),
(f_hh_collections_ct_i = NULL) => 0.0089321844, 0.0021888243);

// Tree: 94 
wFDN_FL__S__lgt_94 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 19.95) => 0.0156419382,
   (C_INC_50K_P > 19.95) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 71) => 0.1961430168,
      (f_mos_inq_banko_cm_fseen_d > 71) => 0.0248250374,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0764634355, 0.0764634355),
   (C_INC_50K_P = NULL) => 0.0089720149, 0.0220713358),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 11.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 32.5) => 0.1166516672,
      (f_mos_liens_unrel_SC_fseen_d > 32.5) => -0.0061307729,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0054215513, -0.0054215513),
   (f_rel_incomeover100_count_d > 11.5) => 0.1470206340,
   (f_rel_incomeover100_count_d = NULL) => -0.0043782674, -0.0043782674),
(f_hh_members_ct_d = NULL) => -0.0030266859, 0.0010437625);

// Tree: 95 
wFDN_FL__S__lgt_95 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 28.15) => -0.0072018309,
(c_hval_500k_p > 28.15) => 
   map(
   (NULL < f_hh_bankruptcies_i and f_hh_bankruptcies_i <= 1.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 17.55) => -0.0041083074,
      (c_hh3_p > 17.55) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 114) => 0.2832872461,
         (c_sub_bus > 114) => 
            map(
            (NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0699265336,
            (c_hh4_p > 11.55) => 0.1192924693,
            (c_hh4_p = NULL) => 0.0733392829, 0.0733392829),
         (c_sub_bus = NULL) => 0.1153288755, 0.1153288755),
      (c_hh3_p = NULL) => 0.0539514343, 0.0539514343),
   (f_hh_bankruptcies_i > 1.5) => -0.1053073404,
   (f_hh_bankruptcies_i = NULL) => 0.0436099554, 0.0436099554),
(c_hval_500k_p = NULL) => 0.0095027835, -0.0036720931);

// Tree: 96 
wFDN_FL__S__lgt_96 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 0.35) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 71033.5) => 0.1696387298,
      (c_med_hval > 71033.5) => 0.0042688560,
      (c_med_hval = NULL) => 0.0741813230, 0.0741813230),
   (C_INC_125K_P > 0.35) => -0.0062155391,
   (C_INC_125K_P = NULL) => -0.0282243883, -0.0059574346),
(f_srchcomponentrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 13.5) => 0.0068504919,
   (f_rel_educationover12_count_d > 13.5) => 0.1225754330,
   (f_rel_educationover12_count_d = NULL) => 0.0358521195, 0.0358521195),
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 78.6) => -0.0565555540,
   (c_oldhouse > 78.6) => 0.0680150500,
   (c_oldhouse = NULL) => 0.0168348794, 0.0168348794), -0.0043425368);

// Tree: 97 
wFDN_FL__S__lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0044560253,
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 9.5) => -0.0335053780,
      (f_rel_count_i > 9.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 79.5) => 0.1946296583,
         (c_exp_prod > 79.5) => 0.0443322806,
         (c_exp_prod = NULL) => 0.1006937972, 0.1006937972),
      (f_rel_count_i = NULL) => 0.0491708996, 0.0491708996),
   (f_assoccredbureaucountnew_i = NULL) => -0.0034894634, -0.0034894634),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1552419502,
   (r_A50_pb_average_dollars_d > 99) => -0.0224129727,
   (r_A50_pb_average_dollars_d = NULL) => 0.0578182828, 0.0578182828),
(r_D33_eviction_count_i = NULL) => -0.0082897043, -0.0029404899);

// Tree: 98 
wFDN_FL__S__lgt_98 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 16.3) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 95) => 0.0125351802,
      (c_lar_fam > 95) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1979.5) => 0.0540327476,
         (c_med_yearblt > 1979.5) => 0.2588978722,
         (c_med_yearblt = NULL) => 0.1420739582, 0.1420739582),
      (c_lar_fam = NULL) => 0.0737624932, 0.0737624932),
   (r_C12_source_profile_d > 16.3) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 48.5) => -0.0203093478,
      (r_C13_Curr_Addr_LRes_d > 48.5) => 0.0423541599,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0105746157, 0.0105746157),
   (r_C12_source_profile_d = NULL) => 0.0169475364, 0.0169475364),
(f_hh_members_ct_d > 1.5) => -0.0100486465,
(f_hh_members_ct_d = NULL) => 0.0242301946, -0.0042591582);

// Tree: 99 
wFDN_FL__S__lgt_99 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 0.0002178840,
(k_comb_age_d > 67.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 125.5) => 0.0106481585,
   (f_curraddrmurderindex_i > 125.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 95) => 0.0005388471,
      (f_prevaddrmurderindex_i > 95) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2864145592) => 0.2897229743,
         (f_add_curr_mobility_index_i > 0.2864145592) => 0.0586819451,
         (f_add_curr_mobility_index_i = NULL) => 0.1855651333, 0.1855651333),
      (f_prevaddrmurderindex_i = NULL) => 0.1060211224, 0.1060211224),
   (f_curraddrmurderindex_i = NULL) => 0.0330273408, 0.0330273408),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 95) => 0.0904642612,
   (c_preschl > 95) => -0.0475254917,
   (c_preschl = NULL) => 0.0146225649, 0.0146225649), 0.0027337745);

// Tree: 100 
wFDN_FL__S__lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.25) => 0.0010207686,
      (c_incollege > 6.25) => 
         map(
         (NULL < c_construction and c_construction <= 4.65) => 0.1756856488,
         (c_construction > 4.65) => 0.0395261989,
         (c_construction = NULL) => 0.1053257416, 0.1053257416),
      (c_incollege = NULL) => 0.0447953457, 0.0447953457),
   (f_mos_inq_banko_cm_lseen_d > 27.5) => 0.0033309622,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0069203766, 0.0069203766),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 33.05) => -0.0124696002,
   (c_famotf18_p > 33.05) => -0.0582273863,
   (c_famotf18_p = NULL) => -0.0374077149, -0.0152112325),
(f_historical_count_d = NULL) => 0.0308338475, -0.0038740143);

// Tree: 101 
wFDN_FL__S__lgt_101 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 19.5) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 3.85) => -0.0617312771,
   (C_OWNOCC_P > 3.85) => 
      map(
      (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
         map(
         (NULL < f_accident_count_i and f_accident_count_i <= 2.5) => 0.0021724017,
         (f_accident_count_i > 2.5) => 0.1039232156,
         (f_accident_count_i = NULL) => 0.0034835028, 0.0034835028),
      (r_D31_ALL_Bk_i > 1.5) => -0.0338919138,
      (r_D31_ALL_Bk_i = NULL) => 0.0000162276, 0.0000162276),
   (C_OWNOCC_P = NULL) => 0.0175179844, -0.0006687906),
(r_D30_Derog_Count_i > 19.5) => -0.0972765676,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.85) => -0.0543298258,
   (c_pop_55_64_p > 11.85) => 0.0333281350,
   (c_pop_55_64_p = NULL) => -0.0171416000, -0.0171416000), -0.0012299163);

// Tree: 102 
wFDN_FL__S__lgt_102 := map(
(NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0145452614,
(c_hh4_p > 11.55) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 185.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 37651) => -0.0588817691,
      (f_prevaddrmedianincome_d > 37651) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0302962144,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
            map(
            (NULL < c_rich_wht and c_rich_wht <= 110.5) => 0.2121543192,
            (c_rich_wht > 110.5) => 0.0550142692,
            (c_rich_wht = NULL) => 0.1418884432, 0.1418884432),
         (nf_seg_FraudPoint_3_0 = '') => 0.0817604675, 0.0817604675),
      (f_prevaddrmedianincome_d = NULL) => 0.0509586554, 0.0509586554),
   (f_mos_liens_unrel_SC_fseen_d > 185.5) => 0.0101249457,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0041240610, 0.0113777489),
(c_hh4_p = NULL) => 0.0035519169, 0.0014177261);

// Tree: 103 
wFDN_FL__S__lgt_103 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 11.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => -0.0006533544,
      (f_rel_felony_count_i > 4.5) => 0.0851344627,
      (f_rel_felony_count_i = NULL) => -0.0002406345, -0.0002406345),
   (f_rel_ageover40_count_d > 11.5) => -0.0542702421,
   (f_rel_ageover40_count_d = NULL) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0410938254) => -0.0516075750,
      (f_add_curr_nhood_VAC_pct_i > 0.0410938254) => 0.0829004392,
      (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0091007134, -0.0091007134), -0.0021131035),
(r_D34_unrel_liens_ct_i > 7.5) => 0.0978568016,
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.75) => -0.0562818055,
   (c_pop_6_11_p > 7.75) => 0.0422122449,
   (c_pop_6_11_p = NULL) => -0.0048296896, -0.0048296896), -0.0015912046);

// Tree: 104 
wFDN_FL__S__lgt_104 := map(
(NULL < c_serv_empl and c_serv_empl <= 198.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 809865.5) => 
      map(
      (NULL < r_nas_fname_verd_d and r_nas_fname_verd_d <= 0.5) => 0.1265382954,
      (r_nas_fname_verd_d > 0.5) => -0.0012921843,
      (r_nas_fname_verd_d = NULL) => -0.0006617406, -0.0006617406),
   (f_curraddrmedianvalue_d > 809865.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00956241355) => -0.0667273982,
      (f_add_curr_nhood_BUS_pct_i > 0.00956241355) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 25.5) => 0.0420783644,
         (c_serv_empl > 25.5) => 0.3048380080,
         (c_serv_empl = NULL) => 0.1684436892, 0.1684436892),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0928965005, 0.0928965005),
   (f_curraddrmedianvalue_d = NULL) => 0.0104765116, 0.0010364309),
(c_serv_empl > 198.5) => 0.1316554668,
(c_serv_empl = NULL) => -0.0028407783, 0.0017030544);

// Tree: 105 
wFDN_FL__S__lgt_105 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 33176) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 11.65) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 59.95) => 
            map(
            (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 68.5) => 0.1120005967,
            (f_mos_inq_banko_cm_fseen_d > 68.5) => 0.0374779071,
            (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0595375376, 0.0595375376),
         (c_civ_emp > 59.95) => -0.0217075538,
         (c_civ_emp = NULL) => 0.0396734423, 0.0396734423),
      (c_hh5_p > 11.65) => -0.0491810480,
      (c_hh5_p = NULL) => 0.0280409310, 0.0280409310),
   (c_med_hhinc > 33176) => -0.0051577464,
   (c_med_hhinc = NULL) => -0.0005581920, -0.0024080784),
(f_hh_collections_ct_i > 5.5) => 0.0804438271,
(f_hh_collections_ct_i = NULL) => -0.0270044543, -0.0021671250);

// Tree: 106 
wFDN_FL__S__lgt_106 := map(
(NULL < c_low_ed and c_low_ed <= 75.55) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 73.05) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 50.85) => -0.0022099541,
      (c_hval_500k_p > 50.85) => 0.1386897670,
      (c_hval_500k_p = NULL) => -0.0012301561, -0.0012301561),
   (c_low_ed > 73.05) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 132) => 
         map(
         (NULL < c_hval_20k_p and c_hval_20k_p <= 2.35) => 0.2393907499,
         (c_hval_20k_p > 2.35) => 0.0508377848,
         (c_hval_20k_p = NULL) => 0.1451142673, 0.1451142673),
      (c_lar_fam > 132) => -0.0191077635,
      (c_lar_fam = NULL) => 0.0816419487, 0.0816419487),
   (c_low_ed = NULL) => -0.0001002395, -0.0001002395),
(c_low_ed > 75.55) => -0.0476451472,
(c_low_ed = NULL) => -0.0301679871, -0.0024092551);

// Tree: 107 
wFDN_FL__S__lgt_107 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 
   map(
   (NULL < c_totsales and c_totsales <= 2407) => 0.1866270082,
   (c_totsales > 2407) => 0.0186579381,
   (c_totsales = NULL) => 0.0852492263, 0.0852492263),
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 
      map(
      (NULL < c_retired and c_retired <= 10.85) => -0.0006929616,
      (c_retired > 10.85) => 0.1312821076,
      (c_retired = NULL) => 0.0592957062, 0.0592957062),
   (f_attr_arrest_recency_d > 99.5) => -0.0020915451,
   (f_attr_arrest_recency_d = NULL) => -0.0014872326, -0.0014872326),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 3.2) => -0.0585206039,
   (c_hval_200k_p > 3.2) => 0.0456252292,
   (c_hval_200k_p = NULL) => -0.0091883672, -0.0091883672), -0.0003542184);

// Tree: 108 
wFDN_FL__S__lgt_108 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00940018095) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1319420526) => 0.0288471318,
   (f_add_curr_nhood_BUS_pct_i > 0.1319420526) => 0.2129677064,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0394974017, 0.0394974017),
(f_add_curr_nhood_MFD_pct_i > 0.00940018095) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 0.0017708012,
   (k_comb_age_d > 67.5) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 23.95) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 2.65) => 0.1849397510,
         (C_INC_25K_P > 2.65) => -0.0013770611,
         (C_INC_25K_P = NULL) => 0.0217848095, 0.0217848095),
      (C_INC_15K_P > 23.95) => 0.1471775840,
      (C_INC_15K_P = NULL) => 0.0336182336, 0.0336182336),
   (k_comb_age_d = NULL) => 0.0039306148, 0.0039306148),
(f_add_curr_nhood_MFD_pct_i = NULL) => -0.0139958994, 0.0035846257);

// Tree: 109 
wFDN_FL__S__lgt_109 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 93.35) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 36.5) => -0.0975588371,
      (f_mos_inq_banko_cm_lseen_d > 36.5) => -0.0195250335,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0591943919, -0.0591943919),
   (c_occunit_p > 93.35) => 
      map(
      (NULL < c_assault and c_assault <= 72.5) => 0.0722544504,
      (c_assault > 72.5) => -0.0561151384,
      (c_assault = NULL) => 0.0171392465, 0.0171392465),
   (c_occunit_p = NULL) => -0.0301149106, -0.0301149106),
(r_D33_Eviction_Recency_d > 549) => 0.0087406487,
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.3) => 0.0681910206,
   (c_bigapt_p > 1.3) => -0.0627148946,
   (c_bigapt_p = NULL) => 0.0182772544, 0.0182772544), 0.0073495434);

// Tree: 110 
wFDN_FL__S__lgt_110 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 376.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 2.05) => -0.0071972234,
   (c_hh7p_p > 2.05) => 0.0174435967,
   (c_hh7p_p = NULL) => -0.0025299732, -0.0018097670),
(r_C13_max_lres_d > 376.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 9.15) => 0.2129114170,
   (c_pop_35_44_p > 9.15) => 
      map(
      (NULL < c_food and c_food <= 34.45) => -0.0129178120,
      (c_food > 34.45) => 0.1268338101,
      (c_food = NULL) => 0.0118400511, 0.0118400511),
   (c_pop_35_44_p = NULL) => 0.0447640174, 0.0447640174),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.3) => 0.0130950600,
   (c_bigapt_p > 1.3) => -0.0947956307,
   (c_bigapt_p = NULL) => -0.0293815899, -0.0293815899), -0.0001999787);

// Tree: 111 
wFDN_FL__S__lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.1636555786,
   (r_C12_source_profile_d > 57.95) => -0.0223077144,
   (r_C12_source_profile_d = NULL) => 0.0635214978, 0.0635214978),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 54676.5) => 0.1199137932,
      (c_med_hhinc > 54676.5) => -0.0087289465,
      (c_med_hhinc = NULL) => 0.0597231535, 0.0597231535),
   (r_D33_Eviction_Recency_d > 30) => 0.0016988640,
   (r_D33_Eviction_Recency_d = NULL) => 0.0022123119, 0.0022123119),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_highrent and c_highrent <= 0.7) => 0.0493662139,
   (c_highrent > 0.7) => -0.0643180655,
   (c_highrent = NULL) => -0.0088852350, -0.0088852350), 0.0027321463);

// Tree: 112 
wFDN_FL__S__lgt_112 := map(
(NULL < c_easiqlife and c_easiqlife <= 93.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 4.5) => 0.1288020687,
   (c_no_teens > 4.5) => -0.0203002157,
   (c_no_teens = NULL) => -0.0177814762, -0.0177814762),
(c_easiqlife > 93.5) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0067649681,
   (f_srchunvrfddobcount_i > 0.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 82) => -0.0109233636,
      (f_prevaddrcartheftindex_i > 82) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.2615695179,
         (f_varrisktype_i > 2.5) => 0.0388278099,
         (f_varrisktype_i = NULL) => 0.1166532260, 0.1166532260),
      (f_prevaddrcartheftindex_i = NULL) => 0.0596690160, 0.0596690160),
   (f_srchunvrfddobcount_i = NULL) => 0.0503931647, 0.0091203651),
(c_easiqlife = NULL) => 0.0072877078, 0.0001636127);

// Tree: 113 
wFDN_FL__S__lgt_113 := map(
(NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 11.5) => 
   map(
   (NULL < c_larceny and c_larceny <= 14) => -0.0512017162,
   (c_larceny > 14) => -0.0004871381,
   (c_larceny = NULL) => 0.0247516979, -0.0045627222),
(f_rel_incomeover100_count_d > 11.5) => 0.0974323543,
(f_rel_incomeover100_count_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 168.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.2485250992) => 0.1535918886,
      (f_add_curr_nhood_MFD_pct_i > 0.2485250992) => -0.0423996790,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 6.5) => -0.0802243476,
         (C_INC_25K_P > 6.5) => 0.0343830988,
         (C_INC_25K_P = NULL) => -0.0245272709, -0.0245272709), 0.0047546316),
   (c_new_homes > 168.5) => 0.1124967952,
   (c_new_homes = NULL) => 0.0297383217, 0.0297383217), -0.0029193999);

// Tree: 114 
wFDN_FL__S__lgt_114 := map(
(NULL < c_rich_blk and c_rich_blk <= 197.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 19.5) => -0.0059047668,
   (r_D30_Derog_Count_i > 19.5) => -0.0848996012,
   (r_D30_Derog_Count_i = NULL) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 111.5) => -0.0680612627,
      (c_no_teens > 111.5) => 0.0326912258,
      (c_no_teens = NULL) => -0.0194526060, -0.0194526060), -0.0063637300),
(c_rich_blk > 197.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 108) => -0.0014293308,
   (f_curraddrcartheftindex_i > 108) => 0.1733172441,
   (f_curraddrcartheftindex_i = NULL) => 0.0649591059, 0.0649591059),
(c_rich_blk = NULL) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0265218336,
   (f_vardobcountnew_i > 0.5) => 0.1433474149,
   (f_vardobcountnew_i = NULL) => 0.0021573902, 0.0021573902), -0.0048559930);

// Tree: 115 
wFDN_FL__S__lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.05) => 
   map(
   (NULL < r_I60_inq_mortgage_recency_d and r_I60_inq_mortgage_recency_d <= 9) => -0.1060405210,
   (r_I60_inq_mortgage_recency_d > 9) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0578157298,
      (r_D33_Eviction_Recency_d > 30) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 19.25) => -0.0615937221,
         (c_fammar_p > 19.25) => -0.0004666846,
         (c_fammar_p = NULL) => -0.0009568981, -0.0009568981),
      (r_D33_Eviction_Recency_d = NULL) => -0.0004746712, -0.0004746712),
   (r_I60_inq_mortgage_recency_d = NULL) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 83) => -0.0734441224,
      (c_lar_fam > 83) => 0.0431552639,
      (c_lar_fam = NULL) => -0.0023664143, -0.0023664143), -0.0022825986),
(c_pop_0_5_p > 21.05) => 0.1224928473,
(c_pop_0_5_p = NULL) => 0.0004124535, -0.0017095529);

// Tree: 116 
wFDN_FL__S__lgt_116 := map(
(NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 71.5) => -0.1283285401,
(f_mos_liens_rel_SC_lseen_d > 71.5) => 
   map(
   (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0071607933,
   (r_F04_curr_add_occ_index_d > 2) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 4.65) => -0.0113542912,
      (c_femdiv_p > 4.65) => 
         map(
         (NULL < f_rel_count_i and f_rel_count_i <= 17.5) => 0.0152856888,
         (f_rel_count_i > 17.5) => 0.1098207937,
         (f_rel_count_i = NULL) => 0.0373319887, 0.0373319887),
      (c_femdiv_p = NULL) => 0.0559959143, 0.0141440643),
   (r_F04_curr_add_occ_index_d = NULL) => -0.0023835677, -0.0023835677),
(f_mos_liens_rel_SC_lseen_d = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 8.1) => 0.0610435090,
   (c_hval_250k_p > 8.1) => -0.0510989658,
   (c_hval_250k_p = NULL) => 0.0095410391, 0.0095410391), -0.0027602014);

// Tree: 117 
wFDN_FL__S__lgt_117 := map(
(NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 37.5) => -0.0047113295,
   (f_rel_incomeover25_count_d > 37.5) => -0.0916642804,
   (f_rel_incomeover25_count_d = NULL) => 0.0322881900, -0.0048388466),
(r_F04_curr_add_occ_index_d > 2) => 
   map(
   (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0372805926,
      (f_varrisktype_i > 2.5) => 0.1507406232,
      (f_varrisktype_i = NULL) => 0.0794477304, 0.0794477304),
   (r_I60_inq_banking_recency_d > 9) => 0.0138067406,
   (r_I60_inq_banking_recency_d = NULL) => 0.0200389335, 0.0200389335),
(r_F04_curr_add_occ_index_d = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 11.3) => -0.0735898264,
   (c_pop_25_34_p > 11.3) => 0.0320481420,
   (c_pop_25_34_p = NULL) => -0.0147096473, -0.0147096473), 0.0004544365);

// Tree: 118 
wFDN_FL__S__lgt_118 := map(
(NULL < c_hh6_p and c_hh6_p <= 11.05) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 101.5) => -0.0195912569,
      (c_many_cars > 101.5) => 0.0070808083,
      (c_many_cars = NULL) => -0.0061736445, -0.0061736445),
   (f_inq_Communications_count_i > 3.5) => 0.0675005134,
   (f_inq_Communications_count_i = NULL) => -0.0314956733, -0.0058630363),
(c_hh6_p > 11.05) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 137) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 31500) => 0.1398622989,
      (k_estimated_income_d > 31500) => 0.0413290393,
      (k_estimated_income_d = NULL) => 0.0729276364, 0.0729276364),
   (f_prevaddrlenofres_d > 137) => -0.0742661385,
   (f_prevaddrlenofres_d = NULL) => 0.0470014601, 0.0470014601),
(c_hh6_p = NULL) => -0.0132912826, -0.0045804081);

// Tree: 119 
wFDN_FL__S__lgt_119 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_vf_LexID_ssn_hi_risk_ct_i and f_vf_LexID_ssn_hi_risk_ct_i <= 0.5) => 0.0043135003,
   (f_vf_LexID_ssn_hi_risk_ct_i > 0.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 17.8) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 131.5) => 0.1234768475,
         (r_C10_M_Hdr_FS_d > 131.5) => 0.0182107085,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0554072240, 0.0554072240),
      (c_pop_45_54_p > 17.8) => -0.0708064145,
      (c_pop_45_54_p = NULL) => 0.0348695018, 0.0348695018),
   (f_vf_LexID_ssn_hi_risk_ct_i = NULL) => 0.0051914732, 0.0051914732),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0499326407,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.55) => -0.0537896911,
   (c_pop_55_64_p > 12.55) => 0.0476107971,
   (c_pop_55_64_p = NULL) => -0.0163937664, -0.0163937664), 0.0026258799);

// Tree: 120 
wFDN_FL__S__lgt_120 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 7.5) => 0.0040812997,
(f_sourcerisktype_i > 7.5) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 30735) => -0.1036168734,
   (c_med_hhinc > 30735) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 4.5) => -0.0348372208,
      (f_rel_ageover40_count_d > 4.5) => 0.0818408234,
      (f_rel_ageover40_count_d = NULL) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 216.55) => 0.1359927159,
         (c_cpiall > 216.55) => -0.0571615134,
         (c_cpiall = NULL) => 0.0394156012, 0.0394156012), -0.0159382861),
   (c_med_hhinc = NULL) => -0.0710492416, -0.0287210755),
(f_sourcerisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0319466531,
   (f_addrs_per_ssn_i > 5.5) => 0.0713766294,
   (f_addrs_per_ssn_i = NULL) => 0.0128267693, 0.0128267693), 0.0008669858);

// Tree: 121 
wFDN_FL__S__lgt_121 := map(
(NULL < c_business and c_business <= 21.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 3.5) => 0.1073829042,
   (c_born_usa > 3.5) => 0.0087219619,
   (c_born_usa = NULL) => 0.0107525750, 0.0107525750),
(c_business > 21.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 5.5) => -0.0081405403,
   (f_rel_criminal_count_i > 5.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 0.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 9.15) => -0.0692500230,
         (c_incollege > 9.15) => 0.0597005793,
         (c_incollege = NULL) => -0.0430608291, -0.0430608291),
      (f_inq_HighRiskCredit_count24_i > 0.5) => -0.1304182562,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0510442847, -0.0510442847),
   (f_rel_criminal_count_i = NULL) => -0.0100269261, -0.0119090427),
(c_business = NULL) => 0.0031605907, -0.0010522511);

// Tree: 122 
wFDN_FL__S__lgt_122 := map(
(NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 37.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 382) => 0.0227596010,
      (r_C13_max_lres_d > 382) => 0.1627749570,
      (r_C13_max_lres_d = NULL) => 0.0292478010, 0.0292478010),
   (c_exp_prod > 37.5) => -0.0042593721,
   (c_exp_prod = NULL) => -0.0064521969, -0.0013889957),
(r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 80) => 0.1760433318,
   (c_new_homes > 80) => 0.0070139167,
   (c_new_homes = NULL) => 0.0622071951, 0.0622071951),
(r_C14_Addrs_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 75.5) => 0.0689531441,
   (c_larceny > 75.5) => -0.0576342764,
   (c_larceny = NULL) => 0.0017644363, 0.0017644363), -0.0003682739);

// Tree: 123 
wFDN_FL__S__lgt_123 := map(
(NULL < c_low_hval and c_low_hval <= 71.35) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 178.5) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 21.45) => 
            map(
            (NULL < c_rich_hisp and c_rich_hisp <= 184) => 0.0275219297,
            (c_rich_hisp > 184) => 0.1601856377,
            (c_rich_hisp = NULL) => 0.0498451498, 0.0498451498),
         (c_hh1_p > 21.45) => -0.0090032599,
         (c_hh1_p = NULL) => 0.0146498207, 0.0146498207),
      (c_born_usa > 178.5) => 0.1356882809,
      (c_born_usa = NULL) => 0.0223174155, 0.0223174155),
   (r_I60_inq_comm_recency_d > 549) => 0.0012764749,
   (r_I60_inq_comm_recency_d = NULL) => 0.0144459496, 0.0033075096),
(c_low_hval > 71.35) => -0.0755313052,
(c_low_hval = NULL) => 0.0088613778, 0.0028424736);

// Tree: 124 
wFDN_FL__S__lgt_124 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 10.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 3.25) => -0.0697749884,
   (C_INC_50K_P > 3.25) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 188.5) => 0.0048486900,
      (c_span_lang > 188.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity']) => -0.0595157246,
         (nf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly','6: Other']) => 0.0060790483,
         (nf_seg_FraudPoint_3_0 = '') => -0.0289802269, -0.0289802269),
      (c_span_lang = NULL) => 0.0029719205, 0.0029719205),
   (C_INC_50K_P = NULL) => -0.0017472183, -0.0000084878),
(f_rel_under25miles_cnt_d > 10.5) => -0.0967055132,
(f_rel_under25miles_cnt_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 167.5) => -0.0259824001,
   (c_new_homes > 167.5) => 0.0834353866,
   (c_new_homes = NULL) => -0.0034357047, -0.0034357047), -0.0005822150);

// Tree: 125 
wFDN_FL__S__lgt_125 := map(
(NULL < c_lowinc and c_lowinc <= 79.25) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 11.45) => 0.0001457554,
         (c_unemp > 11.45) => 0.0557052052,
         (c_unemp = NULL) => 0.0010091463, 0.0010091463),
      (f_nae_nothing_found_i > 0.5) => 
         map(
         (NULL < c_white_col and c_white_col <= 41.65) => 0.0125394131,
         (c_white_col > 41.65) => 0.2337437854,
         (c_white_col = NULL) => 0.0920140379, 0.0920140379),
      (f_nae_nothing_found_i = NULL) => 0.0023241776, 0.0023241776),
   (f_inq_Auto_count24_i > 1.5) => -0.0501061585,
   (f_inq_Auto_count24_i = NULL) => 0.0034990426, -0.0004054678),
(c_lowinc > 79.25) => -0.0944349160,
(c_lowinc = NULL) => -0.0138601018, -0.0012827762);

// Tree: 126 
wFDN_FL__S__lgt_126 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00279349225) => 0.1738332411,
      (f_add_curr_nhood_MFD_pct_i > 0.00279349225) => 0.0078578707,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 65.7) => -0.0179169324,
         (c_low_ed > 65.7) => 0.1139836306,
         (c_low_ed = NULL) => 0.0110122408, 0.0066230701), 0.0100624933),
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 29.5) => 0.2571315039,
      (r_A50_pb_average_dollars_d > 29.5) => 0.0489419660,
      (r_A50_pb_average_dollars_d = NULL) => 0.0887760653, 0.0887760653),
   (f_util_adl_count_n = NULL) => 0.0150829076, 0.0150829076),
(k_estimated_income_d > 34500) => -0.0051362466,
(k_estimated_income_d = NULL) => 0.0041391937, 0.0018717955);

// Tree: 127 
wFDN_FL__S__lgt_127 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 0.5) => -0.0031109040,
   (f_inq_Communications_count24_i > 0.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 8.05) => 0.0521655549,
      (c_pop_65_74_p > 8.05) => -0.0370975612,
      (c_pop_65_74_p = NULL) => 0.0294910013, 0.0294910013),
   (f_inq_Communications_count24_i = NULL) => -0.0014369805, -0.0014369805),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 280.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02418081525) => -0.0946029614,
      (f_add_curr_nhood_BUS_pct_i > 0.02418081525) => 0.0393738503,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0067638597, -0.0067638597),
   (r_C21_M_Bureau_ADL_FS_d > 280.5) => -0.1168528637,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0366451608, -0.0366451608),
(f_inq_HighRiskCredit_count24_i = NULL) => -0.0151345895, -0.0021569895);

// Tree: 128 
wFDN_FL__S__lgt_128 := map(
(NULL < c_rich_blk and c_rich_blk <= 186.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 147.5) => 0.0050404424,
      (c_rich_fam > 147.5) => 0.1536058386,
      (c_rich_fam = NULL) => 0.0484888130, 0.0484888130),
   (f_corrssnnamecount_d > 1.5) => -0.0045031634,
   (f_corrssnnamecount_d = NULL) => 0.0222957020, -0.0016339305),
(c_rich_blk > 186.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 14.5) => 0.0211978300,
   (f_rel_ageover30_count_d > 14.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0322967267) => 0.1363378662,
      (f_add_curr_nhood_BUS_pct_i > 0.0322967267) => 0.0578763658,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0936199382, 0.0936199382),
   (f_rel_ageover30_count_d = NULL) => 0.0301246107, 0.0301246107),
(c_rich_blk = NULL) => -0.0211136514, 0.0017366266);

// Tree: 129 
wFDN_FL__S__lgt_129 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 52.35) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 254.5) => -0.0662031523,
   (f_mos_liens_unrel_FT_lseen_d > 254.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 12.5) => -0.0043139169,
      (f_srchssnsrchcount_i > 12.5) => 
         map(
         (NULL < c_assault and c_assault <= 103.5) => -0.0114517143,
         (c_assault > 103.5) => 0.1185829210,
         (c_assault = NULL) => 0.0412003466, 0.0412003466),
      (f_srchssnsrchcount_i = NULL) => -0.0036955269, -0.0036955269),
   (f_mos_liens_unrel_FT_lseen_d = NULL) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 75) => -0.0837730567,
      (c_born_usa > 75) => 0.0245050556,
      (c_born_usa = NULL) => -0.0152228848, -0.0152228848), -0.0046592304),
(c_hval_500k_p > 52.35) => 0.0892773010,
(c_hval_500k_p = NULL) => 0.0369045373, -0.0030591817);

// Tree: 130 
wFDN_FL__S__lgt_130 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.35) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 9.5) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 4.5) => -0.0028316710,
      (f_inq_Other_count24_i > 4.5) => 0.0934785217,
      (f_inq_Other_count24_i = NULL) => -0.0022564940, -0.0022564940),
   (r_I60_Inq_Count12_i > 9.5) => -0.0741224205,
   (r_I60_Inq_Count12_i = NULL) => 
      map(
      (NULL < c_larceny and c_larceny <= 65) => 0.0716911197,
      (c_larceny > 65) => -0.0225801750,
      (c_larceny = NULL) => 0.0195736560, 0.0195736560), -0.0026230942),
(c_hh6_p > 17.35) => -0.1042732913,
(c_hh6_p = NULL) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => -0.0154890663,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity']) => 0.1642080669,
   (nf_seg_FraudPoint_3_0 = '') => 0.0125370921, 0.0125370921), -0.0028653476);

// Tree: 131 
wFDN_FL__S__lgt_131 := map(
(NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 2) => 0.1312016016,
(r_I60_inq_retail_recency_d > 2) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 918617) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 22.35) => -0.0031480834,
      (C_INC_50K_P > 22.35) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 20.65) => 0.0160801152,
         (c_hval_250k_p > 20.65) => 0.1405453560,
         (c_hval_250k_p = NULL) => 0.0340652403, 0.0340652403),
      (C_INC_50K_P = NULL) => 0.0045625335, -0.0011335403),
   (f_curraddrmedianvalue_d > 918617) => 0.1602511323,
   (f_curraddrmedianvalue_d = NULL) => -0.0004360237, -0.0004360237),
(r_I60_inq_retail_recency_d = NULL) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 0.1) => -0.0283659397,
   (c_hh7p_p > 0.1) => 0.0743114463,
   (c_hh7p_p = NULL) => 0.0102345814, 0.0102345814), 0.0002292240);

// Tree: 132 
wFDN_FL__S__lgt_132 := map(
(NULL < c_food and c_food <= 89.35) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.35) => 0.0018485410,
      (r_C12_source_profile_d > 79.35) => 0.0537674992,
      (r_C12_source_profile_d = NULL) => 0.0073018923, 0.0073018923),
   (r_D31_attr_bankruptcy_recency_d > 9) => -0.0309542000,
   (r_D31_attr_bankruptcy_recency_d = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => 0.0526103448,
      (c_hval_250k_p > 8.05) => -0.0625348415,
      (c_hval_250k_p = NULL) => 0.0007006297, 0.0007006297), 0.0034207232),
(c_food > 89.35) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => -0.0087103128,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.1366978503,
   (nf_seg_FraudPoint_3_0 = '') => 0.0533305034, 0.0533305034),
(c_food = NULL) => -0.0380859785, 0.0029900079);

// Tree: 133 
wFDN_FL__S__lgt_133 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0590262770,
   (r_I60_inq_hiRiskCred_recency_d > 9) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 0.25) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 20.85) => 0.1519441407,
         (C_INC_75K_P > 20.85) => -0.0200824194,
         (C_INC_75K_P = NULL) => 0.0967145609, 0.0967145609),
      (c_hh5_p > 0.25) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 35821) => 0.1214580537,
         (r_A46_Curr_AVM_AutoVal_d > 35821) => 0.0247928406,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0085131836, 0.0211166838),
      (c_hh5_p = NULL) => 0.0589219048, 0.0314050165),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0267462779, 0.0267462779),
(f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0016124378,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0006097416, 0.0023044768);

// Tree: 134 
wFDN_FL__S__lgt_134 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 86.5) => -0.0094536319,
(r_C13_Curr_Addr_LRes_d > 86.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 18.65) => 
      map(
      (NULL < c_rich_hisp and c_rich_hisp <= 195.5) => 0.0192681171,
      (c_rich_hisp > 195.5) => 0.1496445512,
      (c_rich_hisp = NULL) => 0.0230775492, 0.0230775492),
   (c_hval_80k_p > 18.65) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.25) => -0.0334445325,
      (c_unemp > 9.25) => -0.1219050976,
      (c_unemp = NULL) => -0.0463074208, -0.0463074208),
   (c_hval_80k_p = NULL) => 0.0257135426, 0.0179631112),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.3) => 0.0367098997,
   (c_bigapt_p > 1.3) => -0.0704908590,
   (c_bigapt_p = NULL) => -0.0096904287, -0.0096904287), 0.0018887444);

// Tree: 135 
wFDN_FL__S__lgt_135 := map(
(NULL < c_no_teens and c_no_teens <= 48.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1990.5) => 0.0063409098,
   (c_popover18 > 1990.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 112403) => 0.2386386699,
      (r_A46_Curr_AVM_AutoVal_d > 112403) => 
         map(
         (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 12.5) => 
            map(
            (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => 0.0023563531,
            (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.2245682994,
            (nf_seg_FraudPoint_3_0 = '') => 0.0870908695, 0.0870908695),
         (f_rel_ageover30_count_d > 12.5) => -0.0154158205,
         (f_rel_ageover30_count_d = NULL) => 0.0676889724, 0.0676889724),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0125822985, 0.0726751483),
   (c_popover18 = NULL) => 0.0178869160, 0.0178869160),
(c_no_teens > 48.5) => -0.0074659923,
(c_no_teens = NULL) => -0.0085980900, -0.0015001459);

// Tree: 136 
wFDN_FL__S__lgt_136 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 0.5) => -0.0064286601,
(r_D32_criminal_count_i > 0.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 16.65) => 
      map(
      (NULL < c_totsales and c_totsales <= 1924) => 0.0410189589,
      (c_totsales > 1924) => 0.2234607725,
      (c_totsales = NULL) => 0.1292972558, 0.1292972558),
   (c_hh2_p > 16.65) => 
      map(
      (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 1.5) => 0.0104963357,
      (f_inq_QuizProvider_count24_i > 1.5) => 0.1491967560,
      (f_inq_QuizProvider_count24_i = NULL) => 0.0142358078, 0.0142358078),
   (c_hh2_p = NULL) => 0.0208289777, 0.0208289777),
(r_D32_criminal_count_i = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 101.5) => -0.0419714362,
   (c_no_car > 101.5) => 0.0741237061,
   (c_no_car = NULL) => 0.0099658643, 0.0099658643), -0.0015977762);

// Tree: 137 
wFDN_FL__S__lgt_137 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0994507671,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.45) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.31605129115) => 0.0025917561,
      (f_add_curr_mobility_index_i > 0.31605129115) => -0.0229962286,
      (f_add_curr_mobility_index_i = NULL) => -0.0046230817, -0.0046230817),
   (r_C12_source_profile_d > 81.45) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 147) => 0.0081275531,
      (c_sub_bus > 147) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 328.5) => 0.2731564649,
         (f_M_Bureau_ADL_FS_all_d > 328.5) => 0.0531675648,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1433493499, 0.1433493499),
      (c_sub_bus = NULL) => 0.0302973182, 0.0302973182),
   (r_C12_source_profile_d = NULL) => -0.0228462834, -0.0020188414),
(C_INC_100K_P = NULL) => 0.0202939811, -0.0009297768);

// Tree: 138 
wFDN_FL__S__lgt_138 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 186.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 200.5) => -0.0670113070,
   (r_D32_Mos_Since_Fel_LS_d > 200.5) => 0.0009677611,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0003795405, 0.0003795405),
(f_curraddrcartheftindex_i > 186.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0237910852) => -0.0563914487,
   (f_add_curr_nhood_BUS_pct_i > 0.0237910852) => 
      map(
      (NULL < c_construction and c_construction <= 14.4) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0169001957,
         (f_srchvelocityrisktype_i > 4.5) => 0.1307374437,
         (f_srchvelocityrisktype_i = NULL) => 0.0354248923, 0.0354248923),
      (c_construction > 14.4) => 0.2030174487,
      (c_construction = NULL) => 0.0562294855, 0.0562294855),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0351788436, 0.0351788436),
(f_curraddrcartheftindex_i = NULL) => -0.0202282293, 0.0016475130);

// Tree: 139 
wFDN_FL__S__lgt_139 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 54.95) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 183.5) => 
         map(
         (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 0.0869648559,
         (nf_vf_hi_risk_hit_type > 3.5) => 0.0081397934,
         (nf_vf_hi_risk_hit_type = NULL) => 0.0110688690, 0.0110688690),
      (c_bel_edu > 183.5) => 
         map(
         (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.1497607042,
         (f_property_owners_ct_d > 0.5) => 0.0244355910,
         (f_property_owners_ct_d = NULL) => 0.0790497458, 0.0790497458),
      (c_bel_edu = NULL) => 0.0141783594, 0.0141783594),
   (f_historical_count_d > 0.5) => -0.0114094313,
   (f_historical_count_d = NULL) => 0.0062666522, 0.0004455101),
(C_RENTOCC_P > 54.95) => -0.0224952270,
(C_RENTOCC_P = NULL) => -0.0134203652, -0.0033861845);

// Tree: 140 
wFDN_FL__S__lgt_140 := map(
(NULL < c_employees and c_employees <= 40.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 0.5) => 0.1503640495,
   (f_rel_homeover100_count_d > 0.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 162.5) => -0.0008409460,
      (c_robbery > 162.5) => 
         map(
         (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 1.5) => 0.1249488605,
         (r_C18_invalid_addrs_per_adl_i > 1.5) => -0.0129990305,
         (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0722423550, 0.0722423550),
      (c_robbery = NULL) => 0.0095644669, 0.0095644669),
   (f_rel_homeover100_count_d = NULL) => 0.0209080116, 0.0175326852),
(c_employees > 40.5) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 60.5) => -0.0597603369,
   (c_rest_indx > 60.5) => 0.0000873904,
   (c_rest_indx = NULL) => -0.0036583103, -0.0036583103),
(c_employees = NULL) => -0.0319376354, -0.0016124691);

// Tree: 141 
wFDN_FL__S__lgt_141 := map(
(NULL < c_fammar_p and c_fammar_p <= 25.85) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 152.5) => 0.0126004087,
   (c_bel_edu > 152.5) => -0.0931187526,
   (c_bel_edu = NULL) => -0.0402591719, -0.0402591719),
(c_fammar_p > 25.85) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 14939.5) => 0.0922955223,
   (c_med_hval > 14939.5) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 0.45) => -0.0399773265,
      (C_INC_150K_P > 0.45) => 
         map(
         (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0026748486,
         (f_assoccredbureaucountnew_i > 0.5) => 0.0636353416,
         (f_assoccredbureaucountnew_i = NULL) => 0.0050089582, -0.0012366992),
      (C_INC_150K_P = NULL) => -0.0029096264, -0.0029096264),
   (c_med_hval = NULL) => -0.0021347736, -0.0021347736),
(c_fammar_p = NULL) => -0.0261972155, -0.0033336939);

// Tree: 142 
wFDN_FL__S__lgt_142 := map(
(NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 1.5) => -0.0058641518,
(f_hh_members_w_derog_i > 1.5) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 158.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2397417113) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 22.1) => 0.0295042302,
         (c_hval_150k_p > 22.1) => 0.2200706822,
         (c_hval_150k_p = NULL) => 0.0413357566, 0.0413357566),
      (f_add_curr_mobility_index_i > 0.2397417113) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 147.1) => 0.0017782754,
         (c_oldhouse > 147.1) => -0.0739495805,
         (c_oldhouse = NULL) => -0.0158552220, -0.0158552220),
      (f_add_curr_mobility_index_i = NULL) => 0.0130634478, 0.0130634478),
   (c_apt20 > 158.5) => 0.0703957833,
   (c_apt20 = NULL) => 0.0233442720, 0.0233442720),
(f_hh_members_w_derog_i = NULL) => 0.0096188535, 0.0011037136);

// Tree: 143 
wFDN_FL__S__lgt_143 := map(
(NULL < c_child and c_child <= 33.45) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 0.0033448570,
   (f_assocsuspicousidcount_i > 15.5) => 0.0931602827,
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.15) => 0.0538615679,
      (c_hval_250k_p > 8.15) => -0.0609018505,
      (c_hval_250k_p = NULL) => 0.0068273800, 0.0068273800), 0.0038657978),
(c_child > 33.45) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 28.85) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 4.25) => 0.1166576623,
      (c_hh6_p > 4.25) => -0.0429000872,
      (c_hh6_p = NULL) => 0.0382542854, 0.0382542854),
   (r_C12_source_profile_d > 28.85) => -0.0521705812,
   (r_C12_source_profile_d = NULL) => -0.0400020376, -0.0400020376),
(c_child = NULL) => -0.0073732219, 0.0005901789);

// Tree: 144 
wFDN_FL__S__lgt_144 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 23.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 11.5) => -0.0002724565,
   (f_srchssnsrchcount_i > 11.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 69.5) => 0.1403761023,
      (f_prevaddrcartheftindex_i > 69.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 113) => -0.0641980701,
         (c_sub_bus > 113) => 0.0793701109,
         (c_sub_bus = NULL) => 0.0101497379, 0.0101497379),
      (f_prevaddrcartheftindex_i = NULL) => 0.0503430603, 0.0503430603),
   (f_srchssnsrchcount_i = NULL) => 0.0004227291, 0.0004227291),
(f_rel_incomeover25_count_d > 23.5) => 
   map(
   (NULL < c_no_labfor and c_no_labfor <= 155.5) => -0.0519995473,
   (c_no_labfor > 155.5) => 0.0857609035,
   (c_no_labfor = NULL) => -0.0391247388, -0.0391247388),
(f_rel_incomeover25_count_d = NULL) => -0.0095820471, -0.0015321955);

// Tree: 145 
wFDN_FL__S__lgt_145 := map(
(NULL < c_retired2 and c_retired2 <= 122.5) => -0.0095826114,
(c_retired2 > 122.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 27.95) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 31860) => 0.0704295943,
      (c_med_hhinc > 31860) => -0.0003287918,
      (c_med_hhinc = NULL) => 0.0047301967, 0.0047301967),
   (c_hval_750k_p > 27.95) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 254.5) => 0.0163407644,
      (f_M_Bureau_ADL_FS_all_d > 254.5) => 
         map(
         (NULL < c_med_rent and c_med_rent <= 1319.5) => 0.0635633075,
         (c_med_rent > 1319.5) => 0.2577938032,
         (c_med_rent = NULL) => 0.1517645954, 0.1517645954),
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0766262118, 0.0766262118),
   (c_hval_750k_p = NULL) => 0.0141588569, 0.0141588569),
(c_retired2 = NULL) => 0.0138355853, -0.0022146963);

// Tree: 146 
wFDN_FL__S__lgt_146 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 180.5) => 0.0110024985,
   (r_C13_Curr_Addr_LRes_d > 180.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81) => 0.0536141739,
      (r_C12_source_profile_d > 81) => 0.2759685543,
      (r_C12_source_profile_d = NULL) => 0.0989241231, 0.0989241231),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0201108763, 0.0201108763),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0143583562,
   (f_hh_payday_loan_users_i > 0.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 6.55) => 0.0553778153,
      (c_unemp > 6.55) => -0.0480913727,
      (c_unemp = NULL) => 0.0353065102, 0.0353065102),
   (f_hh_payday_loan_users_i = NULL) => -0.0094983227, -0.0094983227),
(f_hh_members_ct_d = NULL) => 0.0064095744, -0.0033459724);

// Tree: 147 
wFDN_FL__S__lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 103.5) => -0.0093681856,
   (f_prevaddrcartheftindex_i > 103.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 27.75) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 126.5) => 0.0182931626,
         (r_pb_order_freq_d > 126.5) => -0.0237100364,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < c_pop_12_17_p and c_pop_12_17_p <= 14.25) => 0.0190613863,
            (c_pop_12_17_p > 14.25) => 0.1281451857,
            (c_pop_12_17_p = NULL) => 0.0233170939, 0.0233170939), 0.0118651087),
      (c_pop_35_44_p > 27.75) => 0.1908252453,
      (c_pop_35_44_p = NULL) => 0.0137960554, 0.0137960554),
   (f_prevaddrcartheftindex_i = NULL) => -0.0005597798, -0.0005597798),
(f_prevaddrcartheftindex_i > 194.5) => -0.0753567208,
(f_prevaddrcartheftindex_i = NULL) => 0.0111434361, -0.0019060207);

// Tree: 148 
wFDN_FL__S__lgt_148 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 91) => 0.0879217135,
(r_D32_Mos_Since_Fel_LS_d > 91) => 
   map(
   (NULL < r_nas_lname_verd_d and r_nas_lname_verd_d <= 0.5) => 0.0989955408,
   (r_nas_lname_verd_d > 0.5) => 
      map(
      (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0040411911,
      (f_assoccredbureaucountnew_i > 0.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 68) => 0.1415197193,
         (f_mos_inq_banko_cm_fseen_d > 68) => 0.0121023273,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0395253435, 0.0395253435),
      (f_assoccredbureaucountnew_i = NULL) => -0.0030988901, -0.0030988901),
   (r_nas_lname_verd_d = NULL) => -0.0026005895, -0.0026005895),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_med_inc and c_med_inc <= 124) => -0.0653970121,
   (c_med_inc > 124) => 0.0392253642,
   (c_med_inc = NULL) => -0.0050379489, -0.0050379489), -0.0022627766);

// Tree: 149 
wFDN_FL__S__lgt_149 := map(
(NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 197.5) => -0.0104008415,
   (c_serv_empl > 197.5) => 0.1088073815,
   (c_serv_empl = NULL) => -0.0001863261, -0.0088851915),
(f_util_add_curr_misc_n > 0.5) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 927.5) => 0.0089794701,
      (c_hh00 > 927.5) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 4.55) => 0.1937673047,
         (C_INC_125K_P > 4.55) => 0.0485169309,
         (C_INC_125K_P = NULL) => 0.0568309254, 0.0568309254),
      (c_hh00 = NULL) => 0.0211878941, 0.0197115363),
   (f_inq_Auto_count24_i > 1.5) => -0.0478982274,
   (f_inq_Auto_count24_i = NULL) => 0.0152908532, 0.0152908532),
(f_util_add_curr_misc_n = NULL) => 0.0022203515, 0.0022203515);

// Tree: 150 
wFDN_FL__S__lgt_150 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0023812046,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 47337) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 6.15) => -0.0054209896,
      (c_vacant_p > 6.15) => -0.1113420936,
      (c_vacant_p = NULL) => -0.0723185290, -0.0723185290),
   (f_prevaddrmedianincome_d > 47337) => 
      map(
      (NULL < c_rental and c_rental <= 159.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 2.5) => -0.0571958266,
         (r_S66_adlperssn_count_i > 2.5) => 0.0784127260,
         (r_S66_adlperssn_count_i = NULL) => -0.0272489379, -0.0272489379),
      (c_rental > 159.5) => 0.0850520527,
      (c_rental = NULL) => -0.0027402527, -0.0027402527),
   (f_prevaddrmedianincome_d = NULL) => -0.0308391720, -0.0308391720),
(f_srchfraudsrchcount_i = NULL) => -0.0118011278, 0.0008785188);

// Tree: 151 
wFDN_FL__S__lgt_151 := map(
(NULL < c_hh6_p and c_hh6_p <= 2.35) => 
   map(
   (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 13.65) => 0.0063413128,
      (c_pop_55_64_p > 13.65) => 0.1604037924,
      (c_pop_55_64_p = NULL) => 0.0464843532, 0.0464843532),
   (nf_vf_hi_risk_hit_type > 3.5) => 0.0076359973,
   (nf_vf_hi_risk_hit_type = NULL) => 0.0079467308, 0.0090378462),
(c_hh6_p > 2.35) => 
   map(
   (NULL < f_current_count_d and f_current_count_d <= 5.5) => -0.0194111694,
   (f_current_count_d > 5.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 123.5) => -0.0039341078,
      (c_rich_wht > 123.5) => 0.2639362259,
      (c_rich_wht = NULL) => 0.1004565370, 0.1004565370),
   (f_current_count_d = NULL) => -0.0157387189, -0.0157387189),
(c_hh6_p = NULL) => -0.0122564262, -0.0002427307);

// Tree: 152 
wFDN_FL__S__lgt_152 := map(
(NULL < c_fammar_p and c_fammar_p <= 18.85) => -0.0651409968,
(c_fammar_p > 18.85) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 14.5) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 76) => -0.0300729740,
         (f_prevaddrcartheftindex_i > 76) => 0.0749662053,
         (f_prevaddrcartheftindex_i = NULL) => 0.0366618045, 0.0366618045),
      (c_many_cars > 14.5) => -0.0004175903,
      (c_many_cars = NULL) => 0.0014740904, 0.0014740904),
   (f_srchfraudsrchcountyr_i > 7.5) => -0.0710118089,
   (f_srchfraudsrchcountyr_i = NULL) => 
      map(
      (NULL < c_preschl and c_preschl <= 122) => 0.0380342558,
      (c_preschl > 122) => -0.0734041441,
      (c_preschl = NULL) => -0.0118901474, -0.0118901474), 0.0009486855),
(c_fammar_p = NULL) => 0.0151539283, 0.0007699626);

// Tree: 153 
wFDN_FL__S__lgt_153 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 26.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 35.15) => 0.0023377899,
   (c_hval_60k_p > 35.15) => -0.0923834848,
   (c_hval_60k_p = NULL) => -0.0038720527, 0.0014217721),
(f_rel_homeover300_count_d > 26.5) => -0.1106934004,
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 4.15) => -0.0952846588,
   (c_famotf18_p > 4.15) => 
      map(
      (NULL < c_rnt250_p and c_rnt250_p <= 6.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0204091675,
         (r_S66_adlperssn_count_i > 1.5) => 0.1266018784,
         (r_S66_adlperssn_count_i = NULL) => 0.0502268253, 0.0502268253),
      (c_rnt250_p > 6.5) => -0.0680722001,
      (c_rnt250_p = NULL) => 0.0205429370, 0.0205429370),
   (c_famotf18_p = NULL) => -0.0073595091, -0.0073595091), 0.0004680952);

// Tree: 154 
wFDN_FL__S__lgt_154 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.95) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 18.15) => -0.0189786597,
   (c_vacant_p > 18.15) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 3.5) => 0.0844820236,
      (f_rel_incomeover50_count_d > 3.5) => -0.0130117864,
      (f_rel_incomeover50_count_d = NULL) => 0.0300465211, 0.0300465211),
   (c_vacant_p = NULL) => -0.0136649627, -0.0136649627),
(c_pop_35_44_p > 13.95) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 44522) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.1717073910,
      (f_hh_age_18_plus_d > 1.5) => 0.0297522525,
      (f_hh_age_18_plus_d = NULL) => 0.0813144329, 0.0813144329),
   (f_curraddrmedianvalue_d > 44522) => 0.0075992111,
   (f_curraddrmedianvalue_d = NULL) => -0.0257502815, 0.0096357106),
(c_pop_35_44_p = NULL) => -0.0067131582, -0.0007391489);

// Tree: 155 
wFDN_FL__S__lgt_155 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0052386360,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 107.8) => 
      map(
      (NULL < c_rnt2001_p and c_rnt2001_p <= 4.7) => 0.0348994975,
      (c_rnt2001_p > 4.7) => 0.2695415883,
      (c_rnt2001_p = NULL) => 0.0695625337, 0.0695625337),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 107.8) => -0.0327486011,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < C_INC_201K_P and C_INC_201K_P <= 0.55) => 
         map(
         (NULL < c_retail and c_retail <= 13.75) => 0.0519165995,
         (c_retail > 13.75) => 0.1878251713,
         (c_retail = NULL) => 0.0981255139, 0.0981255139),
      (C_INC_201K_P > 0.55) => -0.0126939921,
      (C_INC_201K_P = NULL) => 0.0212303465, 0.0212303465), 0.0227449930),
(f_hh_collections_ct_i = NULL) => 0.0148348642, -0.0025367308);

// Final Score Sum 

   wFDN_FL__S__lgt := sum(
      wFDN_FL__S__lgt_0, wFDN_FL__S__lgt_1, wFDN_FL__S__lgt_2, wFDN_FL__S__lgt_3, wFDN_FL__S__lgt_4, 
      wFDN_FL__S__lgt_5, wFDN_FL__S__lgt_6, wFDN_FL__S__lgt_7, wFDN_FL__S__lgt_8, wFDN_FL__S__lgt_9, 
      wFDN_FL__S__lgt_10, wFDN_FL__S__lgt_11, wFDN_FL__S__lgt_12, wFDN_FL__S__lgt_13, wFDN_FL__S__lgt_14, 
      wFDN_FL__S__lgt_15, wFDN_FL__S__lgt_16, wFDN_FL__S__lgt_17, wFDN_FL__S__lgt_18, wFDN_FL__S__lgt_19, 
      wFDN_FL__S__lgt_20, wFDN_FL__S__lgt_21, wFDN_FL__S__lgt_22, wFDN_FL__S__lgt_23, wFDN_FL__S__lgt_24, 
      wFDN_FL__S__lgt_25, wFDN_FL__S__lgt_26, wFDN_FL__S__lgt_27, wFDN_FL__S__lgt_28, wFDN_FL__S__lgt_29, 
      wFDN_FL__S__lgt_30, wFDN_FL__S__lgt_31, wFDN_FL__S__lgt_32, wFDN_FL__S__lgt_33, wFDN_FL__S__lgt_34, 
      wFDN_FL__S__lgt_35, wFDN_FL__S__lgt_36, wFDN_FL__S__lgt_37, wFDN_FL__S__lgt_38, wFDN_FL__S__lgt_39, 
      wFDN_FL__S__lgt_40, wFDN_FL__S__lgt_41, wFDN_FL__S__lgt_42, wFDN_FL__S__lgt_43, wFDN_FL__S__lgt_44, 
      wFDN_FL__S__lgt_45, wFDN_FL__S__lgt_46, wFDN_FL__S__lgt_47, wFDN_FL__S__lgt_48, wFDN_FL__S__lgt_49, 
      wFDN_FL__S__lgt_50, wFDN_FL__S__lgt_51, wFDN_FL__S__lgt_52, wFDN_FL__S__lgt_53, wFDN_FL__S__lgt_54, 
      wFDN_FL__S__lgt_55, wFDN_FL__S__lgt_56, wFDN_FL__S__lgt_57, wFDN_FL__S__lgt_58, wFDN_FL__S__lgt_59, 
      wFDN_FL__S__lgt_60, wFDN_FL__S__lgt_61, wFDN_FL__S__lgt_62, wFDN_FL__S__lgt_63, wFDN_FL__S__lgt_64, 
      wFDN_FL__S__lgt_65, wFDN_FL__S__lgt_66, wFDN_FL__S__lgt_67, wFDN_FL__S__lgt_68, wFDN_FL__S__lgt_69, 
      wFDN_FL__S__lgt_70, wFDN_FL__S__lgt_71, wFDN_FL__S__lgt_72, wFDN_FL__S__lgt_73, wFDN_FL__S__lgt_74, 
      wFDN_FL__S__lgt_75, wFDN_FL__S__lgt_76, wFDN_FL__S__lgt_77, wFDN_FL__S__lgt_78, wFDN_FL__S__lgt_79, 
      wFDN_FL__S__lgt_80, wFDN_FL__S__lgt_81, wFDN_FL__S__lgt_82, wFDN_FL__S__lgt_83, wFDN_FL__S__lgt_84, 
      wFDN_FL__S__lgt_85, wFDN_FL__S__lgt_86, wFDN_FL__S__lgt_87, wFDN_FL__S__lgt_88, wFDN_FL__S__lgt_89, 
      wFDN_FL__S__lgt_90, wFDN_FL__S__lgt_91, wFDN_FL__S__lgt_92, wFDN_FL__S__lgt_93, wFDN_FL__S__lgt_94, 
      wFDN_FL__S__lgt_95, wFDN_FL__S__lgt_96, wFDN_FL__S__lgt_97, wFDN_FL__S__lgt_98, wFDN_FL__S__lgt_99, 
      wFDN_FL__S__lgt_100, wFDN_FL__S__lgt_101, wFDN_FL__S__lgt_102, wFDN_FL__S__lgt_103, wFDN_FL__S__lgt_104, 
      wFDN_FL__S__lgt_105, wFDN_FL__S__lgt_106, wFDN_FL__S__lgt_107, wFDN_FL__S__lgt_108, wFDN_FL__S__lgt_109, 
      wFDN_FL__S__lgt_110, wFDN_FL__S__lgt_111, wFDN_FL__S__lgt_112, wFDN_FL__S__lgt_113, wFDN_FL__S__lgt_114, 
      wFDN_FL__S__lgt_115, wFDN_FL__S__lgt_116, wFDN_FL__S__lgt_117, wFDN_FL__S__lgt_118, wFDN_FL__S__lgt_119, 
      wFDN_FL__S__lgt_120, wFDN_FL__S__lgt_121, wFDN_FL__S__lgt_122, wFDN_FL__S__lgt_123, wFDN_FL__S__lgt_124, 
      wFDN_FL__S__lgt_125, wFDN_FL__S__lgt_126, wFDN_FL__S__lgt_127, wFDN_FL__S__lgt_128, wFDN_FL__S__lgt_129, 
      wFDN_FL__S__lgt_130, wFDN_FL__S__lgt_131, wFDN_FL__S__lgt_132, wFDN_FL__S__lgt_133, wFDN_FL__S__lgt_134, 
      wFDN_FL__S__lgt_135, wFDN_FL__S__lgt_136, wFDN_FL__S__lgt_137, wFDN_FL__S__lgt_138, wFDN_FL__S__lgt_139, 
      wFDN_FL__S__lgt_140, wFDN_FL__S__lgt_141, wFDN_FL__S__lgt_142, wFDN_FL__S__lgt_143, wFDN_FL__S__lgt_144, 
      wFDN_FL__S__lgt_145, wFDN_FL__S__lgt_146, wFDN_FL__S__lgt_147, wFDN_FL__S__lgt_148, wFDN_FL__S__lgt_149, 
      wFDN_FL__S__lgt_150, wFDN_FL__S__lgt_151, wFDN_FL__S__lgt_152, wFDN_FL__S__lgt_153, wFDN_FL__S__lgt_154, 
      wFDN_FL__S__lgt_155); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FL__S__lgt;
			
self.final_score_0	:= 	wFDN_FL__S__lgt_0	;
self.final_score_1	:= 	wFDN_FL__S__lgt_1	;
self.final_score_2	:= 	wFDN_FL__S__lgt_2	;
self.final_score_3	:= 	wFDN_FL__S__lgt_3	;
self.final_score_4	:= 	wFDN_FL__S__lgt_4	;
self.final_score_5	:= 	wFDN_FL__S__lgt_5	;
self.final_score_6	:= 	wFDN_FL__S__lgt_6	;
self.final_score_7	:= 	wFDN_FL__S__lgt_7	;
self.final_score_8	:= 	wFDN_FL__S__lgt_8	;
self.final_score_9	:= 	wFDN_FL__S__lgt_9	;
self.final_score_10	:= 	wFDN_FL__S__lgt_10	;
self.final_score_11	:= 	wFDN_FL__S__lgt_11	;
self.final_score_12	:= 	wFDN_FL__S__lgt_12	;
self.final_score_13	:= 	wFDN_FL__S__lgt_13	;
self.final_score_14	:= 	wFDN_FL__S__lgt_14	;
self.final_score_15	:= 	wFDN_FL__S__lgt_15	;
self.final_score_16	:= 	wFDN_FL__S__lgt_16	;
self.final_score_17	:= 	wFDN_FL__S__lgt_17	;
self.final_score_18	:= 	wFDN_FL__S__lgt_18	;
self.final_score_19	:= 	wFDN_FL__S__lgt_19	;
self.final_score_20	:= 	wFDN_FL__S__lgt_20	;
self.final_score_21	:= 	wFDN_FL__S__lgt_21	;
self.final_score_22	:= 	wFDN_FL__S__lgt_22	;
self.final_score_23	:= 	wFDN_FL__S__lgt_23	;
self.final_score_24	:= 	wFDN_FL__S__lgt_24	;
self.final_score_25	:= 	wFDN_FL__S__lgt_25	;
self.final_score_26	:= 	wFDN_FL__S__lgt_26	;
self.final_score_27	:= 	wFDN_FL__S__lgt_27	;
self.final_score_28	:= 	wFDN_FL__S__lgt_28	;
self.final_score_29	:= 	wFDN_FL__S__lgt_29	;
self.final_score_30	:= 	wFDN_FL__S__lgt_30	;
self.final_score_31	:= 	wFDN_FL__S__lgt_31	;
self.final_score_32	:= 	wFDN_FL__S__lgt_32	;
self.final_score_33	:= 	wFDN_FL__S__lgt_33	;
self.final_score_34	:= 	wFDN_FL__S__lgt_34	;
self.final_score_35	:= 	wFDN_FL__S__lgt_35	;
self.final_score_36	:= 	wFDN_FL__S__lgt_36	;
self.final_score_37	:= 	wFDN_FL__S__lgt_37	;
self.final_score_38	:= 	wFDN_FL__S__lgt_38	;
self.final_score_39	:= 	wFDN_FL__S__lgt_39	;
self.final_score_40	:= 	wFDN_FL__S__lgt_40	;
self.final_score_41	:= 	wFDN_FL__S__lgt_41	;
self.final_score_42	:= 	wFDN_FL__S__lgt_42	;
self.final_score_43	:= 	wFDN_FL__S__lgt_43	;
self.final_score_44	:= 	wFDN_FL__S__lgt_44	;
self.final_score_45	:= 	wFDN_FL__S__lgt_45	;
self.final_score_46	:= 	wFDN_FL__S__lgt_46	;
self.final_score_47	:= 	wFDN_FL__S__lgt_47	;
self.final_score_48	:= 	wFDN_FL__S__lgt_48	;
self.final_score_49	:= 	wFDN_FL__S__lgt_49	;
self.final_score_50	:= 	wFDN_FL__S__lgt_50	;
self.final_score_51	:= 	wFDN_FL__S__lgt_51	;
self.final_score_52	:= 	wFDN_FL__S__lgt_52	;
self.final_score_53	:= 	wFDN_FL__S__lgt_53	;
self.final_score_54	:= 	wFDN_FL__S__lgt_54	;
self.final_score_55	:= 	wFDN_FL__S__lgt_55	;
self.final_score_56	:= 	wFDN_FL__S__lgt_56	;
self.final_score_57	:= 	wFDN_FL__S__lgt_57	;
self.final_score_58	:= 	wFDN_FL__S__lgt_58	;
self.final_score_59	:= 	wFDN_FL__S__lgt_59	;
self.final_score_60	:= 	wFDN_FL__S__lgt_60	;
self.final_score_61	:= 	wFDN_FL__S__lgt_61	;
self.final_score_62	:= 	wFDN_FL__S__lgt_62	;
self.final_score_63	:= 	wFDN_FL__S__lgt_63	;
self.final_score_64	:= 	wFDN_FL__S__lgt_64	;
self.final_score_65	:= 	wFDN_FL__S__lgt_65	;
self.final_score_66	:= 	wFDN_FL__S__lgt_66	;
self.final_score_67	:= 	wFDN_FL__S__lgt_67	;
self.final_score_68	:= 	wFDN_FL__S__lgt_68	;
self.final_score_69	:= 	wFDN_FL__S__lgt_69	;
self.final_score_70	:= 	wFDN_FL__S__lgt_70	;
self.final_score_71	:= 	wFDN_FL__S__lgt_71	;
self.final_score_72	:= 	wFDN_FL__S__lgt_72	;
self.final_score_73	:= 	wFDN_FL__S__lgt_73	;
self.final_score_74	:= 	wFDN_FL__S__lgt_74	;
self.final_score_75	:= 	wFDN_FL__S__lgt_75	;
self.final_score_76	:= 	wFDN_FL__S__lgt_76	;
self.final_score_77	:= 	wFDN_FL__S__lgt_77	;
self.final_score_78	:= 	wFDN_FL__S__lgt_78	;
self.final_score_79	:= 	wFDN_FL__S__lgt_79	;
self.final_score_80	:= 	wFDN_FL__S__lgt_80	;
self.final_score_81	:= 	wFDN_FL__S__lgt_81	;
self.final_score_82	:= 	wFDN_FL__S__lgt_82	;
self.final_score_83	:= 	wFDN_FL__S__lgt_83	;
self.final_score_84	:= 	wFDN_FL__S__lgt_84	;
self.final_score_85	:= 	wFDN_FL__S__lgt_85	;
self.final_score_86	:= 	wFDN_FL__S__lgt_86	;
self.final_score_87	:= 	wFDN_FL__S__lgt_87	;
self.final_score_88	:= 	wFDN_FL__S__lgt_88	;
self.final_score_89	:= 	wFDN_FL__S__lgt_89	;
self.final_score_90	:= 	wFDN_FL__S__lgt_90	;
self.final_score_91	:= 	wFDN_FL__S__lgt_91	;
self.final_score_92	:= 	wFDN_FL__S__lgt_92	;
self.final_score_93	:= 	wFDN_FL__S__lgt_93	;
self.final_score_94	:= 	wFDN_FL__S__lgt_94	;
self.final_score_95	:= 	wFDN_FL__S__lgt_95	;
self.final_score_96	:= 	wFDN_FL__S__lgt_96	;
self.final_score_97	:= 	wFDN_FL__S__lgt_97	;
self.final_score_98	:= 	wFDN_FL__S__lgt_98	;
self.final_score_99	:= 	wFDN_FL__S__lgt_99	;
self.final_score_100	:= 	wFDN_FL__S__lgt_100	;
self.final_score_101	:= 	wFDN_FL__S__lgt_101	;
self.final_score_102	:= 	wFDN_FL__S__lgt_102	;
self.final_score_103	:= 	wFDN_FL__S__lgt_103	;
self.final_score_104	:= 	wFDN_FL__S__lgt_104	;
self.final_score_105	:= 	wFDN_FL__S__lgt_105	;
self.final_score_106	:= 	wFDN_FL__S__lgt_106	;
self.final_score_107	:= 	wFDN_FL__S__lgt_107	;
self.final_score_108	:= 	wFDN_FL__S__lgt_108	;
self.final_score_109	:= 	wFDN_FL__S__lgt_109	;
self.final_score_110	:= 	wFDN_FL__S__lgt_110	;
self.final_score_111	:= 	wFDN_FL__S__lgt_111	;
self.final_score_112	:= 	wFDN_FL__S__lgt_112	;
self.final_score_113	:= 	wFDN_FL__S__lgt_113	;
self.final_score_114	:= 	wFDN_FL__S__lgt_114	;
self.final_score_115	:= 	wFDN_FL__S__lgt_115	;
self.final_score_116	:= 	wFDN_FL__S__lgt_116	;
self.final_score_117	:= 	wFDN_FL__S__lgt_117	;
self.final_score_118	:= 	wFDN_FL__S__lgt_118	;
self.final_score_119	:= 	wFDN_FL__S__lgt_119	;
self.final_score_120	:= 	wFDN_FL__S__lgt_120	;
self.final_score_121	:= 	wFDN_FL__S__lgt_121	;
self.final_score_122	:= 	wFDN_FL__S__lgt_122	;
self.final_score_123	:= 	wFDN_FL__S__lgt_123	;
self.final_score_124	:= 	wFDN_FL__S__lgt_124	;
self.final_score_125	:= 	wFDN_FL__S__lgt_125	;
self.final_score_126	:= 	wFDN_FL__S__lgt_126	;
self.final_score_127	:= 	wFDN_FL__S__lgt_127	;
self.final_score_128	:= 	wFDN_FL__S__lgt_128	;
self.final_score_129	:= 	wFDN_FL__S__lgt_129	;
self.final_score_130	:= 	wFDN_FL__S__lgt_130	;
self.final_score_131	:= 	wFDN_FL__S__lgt_131	;
self.final_score_132	:= 	wFDN_FL__S__lgt_132	;
self.final_score_133	:= 	wFDN_FL__S__lgt_133	;
self.final_score_134	:= 	wFDN_FL__S__lgt_134	;
self.final_score_135	:= 	wFDN_FL__S__lgt_135	;
self.final_score_136	:= 	wFDN_FL__S__lgt_136	;
self.final_score_137	:= 	wFDN_FL__S__lgt_137	;
self.final_score_138	:= 	wFDN_FL__S__lgt_138	;
self.final_score_139	:= 	wFDN_FL__S__lgt_139	;
self.final_score_140	:= 	wFDN_FL__S__lgt_140	;
self.final_score_141	:= 	wFDN_FL__S__lgt_141	;
self.final_score_142	:= 	wFDN_FL__S__lgt_142	;
self.final_score_143	:= 	wFDN_FL__S__lgt_143	;
self.final_score_144	:= 	wFDN_FL__S__lgt_144	;
self.final_score_145	:= 	wFDN_FL__S__lgt_145	;
self.final_score_146	:= 	wFDN_FL__S__lgt_146	;
self.final_score_147	:= 	wFDN_FL__S__lgt_147	;
self.final_score_148	:= 	wFDN_FL__S__lgt_148	;
self.final_score_149	:= 	wFDN_FL__S__lgt_149	;
self.final_score_150	:= 	wFDN_FL__S__lgt_150	;
self.final_score_151	:= 	wFDN_FL__S__lgt_151	;
self.final_score_152	:= 	wFDN_FL__S__lgt_152	;
self.final_score_153	:= 	wFDN_FL__S__lgt_153	;
self.final_score_154	:= 	wFDN_FL__S__lgt_154	;
self.final_score_155	:= 	wFDN_FL__S__lgt_155	;
self.FP3_wFDN_LGT		:= 	wFDN_FL__S__lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
