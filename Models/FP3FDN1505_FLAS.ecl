
export FP3FDN1505_FLAS( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FLA_S__lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FLA_S__lgt_1 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 0.4486687841,
(nf_vf_hi_risk_index > 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0441981612,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 50.45) => 0.2198953777,
         (c_fammar_p > 50.45) => 0.0285444738,
         (c_fammar_p = NULL) => -0.0410492890, 0.0446877030),
      (f_inq_Communications_count_i > 0.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.1589065200,
         (f_srchvelocityrisktype_i > 5.5) => 0.4953086006,
         (f_srchvelocityrisktype_i = NULL) => 0.2844966300, 0.2844966300),
      (f_inq_Communications_count_i = NULL) => 0.0789896792, 0.0789896792),
   (nf_seg_FraudPoint_3_0 = '') => -0.0128024267, -0.0128024267),
(nf_vf_hi_risk_index = NULL) => 0.3050346590, -0.0016766067);

// Tree: 2 
wFDN_FLA_S__lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < nf_vf_level and nf_vf_level <= 3.5) => 0.1076926207,
      (nf_vf_level > 3.5) => 0.4867486990,
      (nf_vf_level = NULL) => 0.1439603319, 0.1439603319),
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0375120051,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1963313994,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0324184691, -0.0324184691),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0227734511, -0.0227734511),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.1646824449,
   (f_hh_payday_loan_users_i > 0.5) => 0.4903619647,
   (f_hh_payday_loan_users_i = NULL) => 0.2198746324, 0.2198746324),
(f_varrisktype_i = NULL) => 0.2009486335, -0.0071402146);

// Tree: 3 
wFDN_FLA_S__lgt_3 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0512968104,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.2695806750,
   (nf_seg_FraudPoint_3_0 = '') => 0.1310220502, 0.1310220502),
(nf_vf_hi_risk_index > 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0390374998,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0195281776,
      (f_inq_Communications_count_i > 0.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 4.5) => 0.1211632018,
         (k_inq_per_ssn_i > 4.5) => 0.3559897135,
         (k_inq_per_ssn_i = NULL) => 0.1521229161, 0.1521229161),
      (f_inq_Communications_count_i = NULL) => 0.0377141499, 0.0377141499),
   (nf_seg_FraudPoint_3_0 = '') => -0.0197723559, -0.0197723559),
(nf_vf_hi_risk_index = NULL) => 0.1293081745, -0.0078030151);

// Tree: 4 
wFDN_FLA_S__lgt_4 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.0899914653,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => -0.0338647838,
      (f_assocsuspicousidcount_i > 14.5) => 0.3807146448,
      (f_assocsuspicousidcount_i = NULL) => -0.0318561626, -0.0318561626),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0250769388, -0.0250769388),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0300082990,
      (f_assocrisktype_i > 4.5) => 0.1890210154,
      (f_assocrisktype_i = NULL) => 0.0695393933, 0.0695393933),
   (f_inq_Communications_count_i > 1.5) => 0.2494271608,
   (f_inq_Communications_count_i = NULL) => 0.0909045251, 0.0909045251),
(f_srchvelocityrisktype_i = NULL) => 0.1366215674, -0.0086895758);

// Tree: 5 
wFDN_FLA_S__lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0203403747,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1428714639,
      (nf_seg_FraudPoint_3_0 = '') => 0.0598858607, 0.0598858607),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0354114466,
      (k_inq_per_addr_i > 3.5) => 0.0586505948,
      (k_inq_per_addr_i = NULL) => -0.0267190258, -0.0267190258),
   (c_fammar_p = NULL) => -0.0254831745, -0.0147157312),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0749962007,
   (f_assocrisktype_i > 5.5) => 0.2303125970,
   (f_assocrisktype_i = NULL) => 0.1096764372, 0.1096764372),
(f_varrisktype_i = NULL) => 0.1011741847, -0.0064334496);

// Tree: 6 
wFDN_FLA_S__lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0325473259,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 66.15) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0913968511,
         (f_rel_felony_count_i > 2.5) => 0.3372208306,
         (f_rel_felony_count_i = NULL) => 0.1126408987, 0.1126408987),
      (c_fammar_p > 66.15) => 0.0098560025,
      (c_fammar_p = NULL) => 0.0197560058, 0.0409824567),
   (nf_seg_FraudPoint_3_0 = '') => -0.0178268546, -0.0178268546),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => 0.2328421783,
   (nf_vf_hi_risk_index > 5.5) => 0.0971612529,
   (nf_vf_hi_risk_index = NULL) => 0.1311656535, 0.1311656535),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0788108609, -0.0121487263);

// Tree: 7 
wFDN_FLA_S__lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 2.5) => 0.0555541882,
      (nf_vf_hi_summary > 2.5) => 0.2548516647,
      (nf_vf_hi_summary = NULL) => 0.0653873677, 0.0653873677),
   (f_corrssnaddrcount_d > 2.5) => -0.0214165140,
   (f_corrssnaddrcount_d = NULL) => -0.0133029996, -0.0133029996),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < c_employees and c_employees <= 38.5) => 0.2937384897,
   (c_employees > 38.5) => 0.0805480007,
   (c_employees = NULL) => 0.1214267596, 0.1214267596),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0361108554) => -0.0502568267,
   (f_add_input_nhood_VAC_pct_i > 0.0361108554) => 0.2235115063,
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0614406532, 0.0614406532), -0.0081374287);

// Tree: 8 
wFDN_FLA_S__lgt_8 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0458505406,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1390570358,
   (nf_seg_FraudPoint_3_0 = '') => 0.0787815420, 0.0787815420),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly','6: Other']) => -0.0441852024,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity']) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 22.15) => -0.0048900008,
         (c_famotf18_p > 22.15) => 0.0824725666,
         (c_famotf18_p = NULL) => -0.0324127631, 0.0073162361),
      (nf_seg_FraudPoint_3_0 = '') => -0.0216692731, -0.0216692731),
   (f_inq_PrepaidCards_count24_i > 0.5) => 0.2200942587,
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0192967981, -0.0192967981),
(nf_vf_hi_risk_hit_type = NULL) => 0.0417612302, -0.0113806538);

// Tree: 9 
wFDN_FLA_S__lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.1407737887,
      (r_F01_inp_addr_address_score_d > 75) => 0.0410601508,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0519968453, 0.0519968453),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0248805083,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.0812318671,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0226074199, -0.0226074199),
   (c_fammar_p = NULL) => -0.0405421258, -0.0121330138),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 15.5) => 0.0947630936,
   (f_rel_under500miles_cnt_d > 15.5) => 0.2060379732,
   (f_rel_under500miles_cnt_d = NULL) => 0.1274164059, 0.1274164059),
(f_inq_PrepaidCards_count_i = NULL) => 0.0988751830, -0.0072299804);

// Tree: 10 
wFDN_FLA_S__lgt_10 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134) => 0.0316873084,
         (f_prevaddrageoldest_d > 134) => 0.2224810471,
         (f_prevaddrageoldest_d = NULL) => 0.0639608762, 0.0639608762),
      (r_F01_inp_addr_address_score_d > 25) => -0.0213289890,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0169132777, -0.0169132777),
   (f_rel_felony_count_i > 1.5) => 0.1028864649,
   (f_rel_felony_count_i = NULL) => -0.0116674342, -0.0116674342),
(f_srchfraudsrchcount_i > 8.5) => 0.1136921084,
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0764573170,
   (f_addrs_per_ssn_i > 4.5) => 0.1695137353,
   (f_addrs_per_ssn_i = NULL) => 0.0349654674, 0.0349654674), -0.0075511426);

// Tree: 11 
wFDN_FLA_S__lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3435599907,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0223699742,
      (f_inq_Communications_count_i > 0.5) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => 0.0424990119,
         (r_D33_eviction_count_i > 1.5) => 0.2120260829,
         (r_D33_eviction_count_i = NULL) => 0.0527095334, 0.0527095334),
      (f_inq_Communications_count_i = NULL) => -0.0157821741, -0.0157821741),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0127324112, -0.0135940525),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => 0.0948371314,
   (c_unemp > 8.95) => 0.2696088834,
   (c_unemp = NULL) => 0.1109423781, 0.1109423781),
(k_inq_ssns_per_addr_i = NULL) => -0.0078016604, -0.0078016604);

// Tree: 12 
wFDN_FLA_S__lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2342490575,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 9.5) => -0.0185209006,
      (f_addrchangecrimediff_i > 9.5) => 0.0984397330,
      (f_addrchangecrimediff_i = NULL) => -0.0064914572, -0.0119141756),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0105432420, -0.0105432420),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1604919992,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0350282309,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0862739954, 0.0862739954),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0381785193,
   (f_addrs_per_ssn_i > 3.5) => 0.1534194253,
   (f_addrs_per_ssn_i = NULL) => 0.0608137521, 0.0608137521), -0.0071586966);

// Tree: 13 
wFDN_FLA_S__lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 51.45) => 0.0668700713,
   (c_fammar_p > 51.45) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
         map(
         (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1931099936,
         (r_I60_inq_comm_recency_d > 549) => 0.0421640935,
         (r_I60_inq_comm_recency_d = NULL) => 0.0903576641, 0.0903576641),
      (r_D33_Eviction_Recency_d > 79.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72313) => 0.1069407936,
         (f_addrchangevaluediff_d > -72313) => -0.0252154545,
         (f_addrchangevaluediff_d = NULL) => -0.0043555878, -0.0186683327),
      (r_D33_Eviction_Recency_d = NULL) => -0.0170431248, -0.0170431248),
   (c_fammar_p = NULL) => -0.0527747246, -0.0109030113),
(f_assocsuspicousidcount_i > 13.5) => 0.1901973558,
(f_assocsuspicousidcount_i = NULL) => 0.0420928954, -0.0087279618);

// Tree: 14 
wFDN_FLA_S__lgt_14 := map(
(NULL < nf_vf_type and nf_vf_type <= 2.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0213265415,
      (k_inq_ssns_per_addr_i > 1.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 24.15) => 0.0195369353,
         (c_famotf18_p > 24.15) => 0.1276836450,
         (c_famotf18_p = NULL) => 0.0333540218, 0.0333540218),
      (k_inq_ssns_per_addr_i = NULL) => -0.0146028028, -0.0146028028),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.0971901701,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0118422552, -0.0118422552),
(nf_vf_type > 2.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0567318459,
   (r_C23_inp_addr_occ_index_d > 2) => 0.1399596134,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0914100824, 0.0914100824),
(nf_vf_type = NULL) => 0.0228312285, -0.0081010897);

// Tree: 15 
wFDN_FLA_S__lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 61.05) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0293430000,
      (r_L79_adls_per_addr_c6_i > 4.5) => 0.1461996676,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0379477907, 0.0379477907),
   (k_comb_age_d > 68.5) => 0.2853083963,
   (k_comb_age_d = NULL) => 0.0492522311, 0.0492522311),
(c_fammar_p > 61.05) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0245417616,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 3.5) => 0.0238214824,
      (f_srchssnsrchcount_i > 3.5) => 0.1381293149,
      (f_srchssnsrchcount_i = NULL) => 0.0513189928, 0.0513189928),
   (f_varrisktype_i = NULL) => 0.0327961650, -0.0203920566),
(c_fammar_p = NULL) => -0.0263171064, -0.0092434576);

// Tree: 16 
wFDN_FLA_S__lgt_16 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 39.5) => 0.0167215624,
      (k_comb_age_d > 39.5) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 30.85) => 0.0365329778,
         (c_low_ed > 30.85) => 0.1897613224,
         (c_low_ed = NULL) => 0.1441857122, 0.1441857122),
      (k_comb_age_d = NULL) => 0.0645206186, 0.0645206186),
   (r_F01_inp_addr_address_score_d > 25) => -0.0155459953,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0115290356, -0.0115290356),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0323392561,
   (f_rel_felony_count_i > 0.5) => 0.1227885600,
   (f_rel_felony_count_i = NULL) => 0.0501725231, 0.0501725231),
(f_varrisktype_i = NULL) => 0.0199724601, -0.0044073678);

// Tree: 17 
wFDN_FLA_S__lgt_17 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.55) => -0.0245614511,
   (c_unemp > 8.55) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.1982906169,
      (k_estimated_income_d > 28500) => 0.0269457267,
      (k_estimated_income_d = NULL) => 0.0574513894, 0.0574513894),
   (c_unemp = NULL) => -0.0333737589, -0.0202653855),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1324955753,
   (r_F01_inp_addr_address_score_d > 25) => 0.0328797656,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0391977633, 0.0391977633),
(f_srchvelocityrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0856847752,
   (f_addrs_per_ssn_i > 3.5) => 0.0966087802,
   (f_addrs_per_ssn_i = NULL) => 0.0133194834, 0.0133194834), -0.0123407926);

// Tree: 18 
wFDN_FLA_S__lgt_18 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0208577403,
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0034738280,
      (f_hh_lienholders_i > 0.5) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 18) => 0.2736041708,
         (r_D32_Mos_Since_Crim_LS_d > 18) => 0.0557079924,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0661577203, 0.0661577203),
      (f_hh_lienholders_i = NULL) => 0.0159622462, 0.0159622462),
   (f_rel_felony_count_i > 1.5) => 0.1460850507,
   (f_rel_felony_count_i = NULL) => 0.0223717834, 0.0223717834),
(f_corrrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0709466618,
   (f_addrs_per_ssn_i > 3.5) => 0.1015414140,
   (f_addrs_per_ssn_i = NULL) => 0.0183234827, 0.0183234827), -0.0060457948);

// Tree: 19 
wFDN_FLA_S__lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 2.5) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => -0.0142789285,
      (r_D32_criminal_count_i > 2.5) => 0.0674575488,
      (r_D32_criminal_count_i = NULL) => -0.0096089431, -0.0096089431),
   (k_inq_per_addr_i > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 62.5) => 0.0291998885,
      (k_comb_age_d > 62.5) => 0.1871834263,
      (k_comb_age_d = NULL) => 0.0423122043, 0.0423122043),
   (k_inq_per_addr_i = NULL) => -0.0013095750, -0.0013095750),
(f_inq_PrepaidCards_count_i > 1.5) => 0.1278905727,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 91.5) => -0.0951118791,
   (c_burglary > 91.5) => 0.0873867959,
   (c_burglary = NULL) => -0.0022330892, -0.0022330892), -0.0000043389);

// Tree: 20 
wFDN_FLA_S__lgt_20 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0170640220,
   (k_inq_per_addr_i > 3.5) => 0.0546472009,
   (k_inq_per_addr_i = NULL) => -0.0113390649, -0.0113390649),
(f_divrisktype_i > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -580) => 0.1553203852,
   (f_addrchangeincomediff_d > -580) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 12.5) => 
         map(
         (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.0867191978,
         (f_prevaddrstatus_i > 2.5) => 0.0022192668,
         (f_prevaddrstatus_i = NULL) => -0.0141500610, 0.0194281875),
      (f_assocsuspicousidcount_i > 12.5) => 0.1728639815,
      (f_assocsuspicousidcount_i = NULL) => 0.0256420982, 0.0256420982),
   (f_addrchangeincomediff_d = NULL) => 0.1003686482, 0.0485703893),
(f_divrisktype_i = NULL) => 0.0201970218, -0.0027431709);

// Tree: 21 
wFDN_FLA_S__lgt_21 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 155.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 61.5) => 0.2036048210,
      (r_D32_Mos_Since_Crim_LS_d > 61.5) => 0.0610034463,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0742563622, 0.0742563622),
   (c_relig_indx > 155.5) => -0.0203324743,
   (c_relig_indx = NULL) => -0.0079595074, 0.0461057166),
(f_corrssnaddrcount_d > 2.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 147.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.0972187690,
      (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0282062812,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0260007948, -0.0260007948),
   (c_bel_edu > 147.5) => 0.0310160179,
   (c_bel_edu = NULL) => -0.0320746086, -0.0157666884),
(f_corrssnaddrcount_d = NULL) => -0.0048171365, -0.0099718052);

// Tree: 22 
wFDN_FLA_S__lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1786472812,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0210397370,
      (f_assocrisktype_i > 3.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 11948.5) => 
            map(
            (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.0716241678,
            (r_C12_Num_NonDerogs_d > 3.5) => -0.0118407860,
            (r_C12_Num_NonDerogs_d = NULL) => 0.0289491506, 0.0289491506),
         (f_addrchangeincomediff_d > 11948.5) => 0.1676748860,
         (f_addrchangeincomediff_d = NULL) => 0.0067967274, 0.0283846168),
      (f_assocrisktype_i = NULL) => -0.0094351673, -0.0094351673),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0084364995, -0.0084364995),
(r_D33_eviction_count_i > 2.5) => 0.1401595515,
(r_D33_eviction_count_i = NULL) => -0.0046807971, -0.0068309566);

// Tree: 23 
wFDN_FLA_S__lgt_23 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 9.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 29.5) => -0.0191861544,
      (f_addrchangecrimediff_i > 29.5) => 0.0640316211,
      (f_addrchangecrimediff_i = NULL) => -0.0040954687, -0.0139093204),
   (k_inq_per_addr_i > 9.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 30.75) => 0.1280139147,
      (c_high_ed > 30.75) => 0.0002314259,
      (c_high_ed = NULL) => 0.0780395751, 0.0780395751),
   (k_inq_per_addr_i = NULL) => -0.0122702454, -0.0122702454),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 3.5) => 0.0396765820,
   (f_assoccredbureaucount_i > 3.5) => 0.1733132473,
   (f_assoccredbureaucount_i = NULL) => 0.0502546822, 0.0502546822),
(f_phones_per_addr_curr_i = NULL) => 0.0193686527, -0.0064065254);

// Tree: 24 
wFDN_FLA_S__lgt_24 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.1601002567,
   (r_D32_Mos_Since_Fel_LS_d > 127.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.05) => -0.0117883621,
      (c_unemp > 9.05) => 0.0577321693,
      (c_unemp = NULL) => -0.0388752234, -0.0094190778),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0083845708, -0.0083845708),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 3.1) => 0.0135902446,
   (c_hval_300k_p > 3.1) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 3.5) => 0.0827980418,
      (f_srchvelocityrisktype_i > 3.5) => 0.1750072692,
      (f_srchvelocityrisktype_i = NULL) => 0.1189168636, 0.1189168636),
   (c_hval_300k_p = NULL) => 0.0650674435, 0.0650674435),
(f_inq_Communications_count_i = NULL) => 0.0190309235, -0.0055469154);

// Tree: 25 
wFDN_FLA_S__lgt_25 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => -0.0000309489,
      (r_L79_adls_per_addr_c6_i > 3.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 13.65) => 0.1599147216,
         (c_high_ed > 13.65) => 0.0461861516,
         (c_high_ed = NULL) => 0.0737353083, 0.0737353083),
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0066007629, 0.0066007629),
   (f_historical_count_d > 0.5) => -0.0352105881,
   (f_historical_count_d = NULL) => -0.0134755227, -0.0134755227),
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 0.0327043011,
   (f_srchcomponentrisktype_i > 2.5) => 0.1511949628,
   (f_srchcomponentrisktype_i = NULL) => 0.0399213403, 0.0399213403),
(f_rel_felony_count_i = NULL) => 0.0056624713, -0.0056982471);

// Tree: 26 
wFDN_FLA_S__lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 27.05) => -0.0072350334,
   (c_famotf18_p > 27.05) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.45) => 0.0218428419,
      (c_pop_6_11_p > 10.45) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1951.5) => 0.2195713069,
         (c_med_yearblt > 1951.5) => 0.0663877728,
         (c_med_yearblt = NULL) => 0.1004950441, 0.1004950441),
      (c_pop_6_11_p = NULL) => 0.0400480533, 0.0400480533),
   (c_famotf18_p = NULL) => -0.0022142427, -0.0029039096),
(r_D30_Derog_Count_i > 11.5) => 0.1149907374,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 96) => -0.0536149656,
   (c_burglary > 96) => 0.0776590313,
   (c_burglary = NULL) => 0.0066024642, 0.0066024642), -0.0012206538);

// Tree: 27 
wFDN_FLA_S__lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1312148297) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 21.5) => 0.0223183188,
      (f_rel_under100miles_cnt_d > 21.5) => 0.1596431916,
      (f_rel_under100miles_cnt_d = NULL) => 0.0306163858, 0.0306163858),
   (f_add_curr_nhood_VAC_pct_i > 0.1312148297) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32887732625) => 0.2246721857,
      (f_add_input_mobility_index_i > 0.32887732625) => 0.0350111262,
      (f_add_input_mobility_index_i = NULL) => 0.1418455205, 0.1418455205),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0476621697, 0.0476621697),
(c_fammar_p > 50.45) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0665436897,
   (r_D33_Eviction_Recency_d > 549) => -0.0128450953,
   (r_D33_Eviction_Recency_d = NULL) => -0.0007922663, -0.0100365325),
(c_fammar_p = NULL) => -0.0076887759, -0.0052310764);

// Tree: 28 
wFDN_FLA_S__lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.1362331929,
   (f_M_Bureau_ADL_FS_noTU_d > 2.5) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 0.5) => 0.1924007219,
         (f_rel_under25miles_cnt_d > 0.5) => 0.0358780401,
         (f_rel_under25miles_cnt_d = NULL) => 0.0560023849, 0.0560023849),
      (f_corrssnaddrcount_d > 1.5) => -0.0103874338,
      (f_corrssnaddrcount_d = NULL) => -0.0069455963, -0.0069455963),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0059779385, -0.0059779385),
(r_D33_eviction_count_i > 2.5) => 0.1077346967,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 110.5) => -0.0642230311,
   (c_cartheft > 110.5) => 0.0953536097,
   (c_cartheft = NULL) => 0.0070165407, 0.0070165407), -0.0046279208);

// Tree: 29 
wFDN_FLA_S__lgt_29 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 128.5) => -0.0247696888,
   (r_A50_pb_average_dollars_d > 128.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 10.05) => 
         map(
         (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => -0.0071906212,
         (f_crim_rel_under25miles_cnt_i > 1.5) => 0.0462050396,
         (f_crim_rel_under25miles_cnt_i = NULL) => 0.0110130765, 0.0045694172),
      (c_hh6_p > 10.05) => 0.1148026534,
      (c_hh6_p = NULL) => -0.0089201174, 0.0087842581),
   (r_A50_pb_average_dollars_d = NULL) => -0.0092737538, -0.0092737538),
(k_comb_age_d > 70.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 174.5) => 0.0588262530,
   (c_sub_bus > 174.5) => 0.2981957834,
   (c_sub_bus = NULL) => 0.0824825383, 0.0824825383),
(k_comb_age_d = NULL) => -0.0030034733, -0.0048097613);

// Tree: 30 
wFDN_FLA_S__lgt_30 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => -0.0140849858,
      (k_comb_age_d > 66.5) => 0.0545700324,
      (k_comb_age_d = NULL) => -0.0086857868, -0.0086857868),
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < c_health and c_health <= 2.25) => 0.1371654302,
      (c_health > 2.25) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 39964) => 0.1028071451,
         (f_curraddrmedianincome_d > 39964) => -0.0240174616,
         (f_curraddrmedianincome_d = NULL) => 0.0086952346, 0.0086952346),
      (c_health = NULL) => 0.0430535427, 0.0430535427),
   (f_varrisktype_i = NULL) => -0.0072435324, -0.0072435324),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1359039661,
(f_inq_PrepaidCards_count_i = NULL) => -0.0055140314, -0.0066413169);

// Tree: 31 
wFDN_FLA_S__lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1095193075,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 8.35) => -0.0085065418,
         (c_unemp > 8.35) => 
            map(
            (NULL < c_cpiall and c_cpiall <= 207.35) => 0.1299979708,
            (c_cpiall > 207.35) => 0.0217813566,
            (c_cpiall = NULL) => 0.0392228622, 0.0392228622),
         (c_unemp = NULL) => -0.0349086969, -0.0059242596),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0053552964, -0.0053552964),
   (k_comb_age_d > 81.5) => 0.1698966750,
   (k_comb_age_d = NULL) => -0.0034782471, -0.0034782471),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1645172571,
(f_inq_PrepaidCards_count_i = NULL) => 0.0081597654, -0.0026671564);

// Tree: 32 
wFDN_FLA_S__lgt_32 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 15.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 13.7) => 0.1453063691,
      (c_hh4_p > 13.7) => -0.0016821320,
      (c_hh4_p = NULL) => 0.0778005390, 0.0778005390),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 4.255) => -0.0073640056,
      (c_hhsize > 4.255) => 0.1461609274,
      (c_hhsize = NULL) => -0.0245242888, -0.0062251134),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0052746593, -0.0052746593),
(f_srchaddrsrchcount_i > 15.5) => 
   map(
   (NULL < c_employees and c_employees <= 23.5) => 0.1903957856,
   (c_employees > 23.5) => 0.0512161306,
   (c_employees = NULL) => 0.0725984798, 0.0725984798),
(f_srchaddrsrchcount_i = NULL) => 0.0182994400, -0.0028365991);

// Tree: 33 
wFDN_FLA_S__lgt_33 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => -0.0076300498,
   (r_D32_criminal_count_i > 5.5) => 0.0713251477,
   (r_D32_criminal_count_i = NULL) => -0.0238239712, -0.0060666064),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 51) => -0.0376709216,
   (r_pb_order_freq_d > 51) => 0.0291052490,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.1845433109) => 0.1956826683,
      (f_add_input_nhood_MFD_pct_i > 0.1845433109) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 3.5) => 0.0058245325,
         (f_assocsuspicousidcount_i > 3.5) => 0.1547862519,
         (f_assocsuspicousidcount_i = NULL) => 0.0476512222, 0.0476512222),
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0932740285, 0.0932740285), 0.0493336513),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0033064201, -0.0033064201);

// Tree: 34 
wFDN_FLA_S__lgt_34 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 78.5) => -0.0048492455,
(r_pb_order_freq_d > 78.5) => -0.0268457014,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 0.0035220478,
   (r_L79_adls_per_addr_c6_i > 2.5) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 20.15) => 
            map(
            (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 0.1611822006,
            (r_C12_Num_NonDerogs_d > 2.5) => 0.0388530863,
            (r_C12_Num_NonDerogs_d = NULL) => 0.1036563282, 0.1036563282),
         (c_high_ed > 20.15) => 0.0020434147,
         (c_high_ed = NULL) => 0.0445930689, 0.0445930689),
      (f_hh_payday_loan_users_i > 0.5) => 0.1602266379,
      (f_hh_payday_loan_users_i = NULL) => 0.0561204029, 0.0561204029),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0141736473, 0.0141736473), -0.0037542498);

// Tree: 35 
wFDN_FLA_S__lgt_35 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 632) => -0.0140624318,
   (c_med_rent > 632) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 21.8) => 0.1557995186,
      (c_hval_400k_p > 21.8) => -0.0296918922,
      (c_hval_400k_p = NULL) => 0.1055741520, 0.1055741520),
   (c_med_rent = NULL) => 0.0633009807, 0.0563404418),
(f_corrssnaddrcount_d > 1.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => -0.0081986462,
   (f_inq_Communications_count_i > 3.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.03364693285) => 0.1715637528,
      (f_add_input_nhood_BUS_pct_i > 0.03364693285) => 0.0040368568,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0838861250, 0.0838861250),
   (f_inq_Communications_count_i = NULL) => -0.0073588504, -0.0073588504),
(f_corrssnaddrcount_d = NULL) => 0.0017180348, -0.0041344431);

// Tree: 36 
wFDN_FLA_S__lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 151.5) => -0.0253813543,
   (c_easiqlife > 151.5) => 0.0268141839,
   (c_easiqlife = NULL) => -0.0729254450, -0.0196999060),
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 0.0099877499,
      (f_inq_PrepaidCards_count24_i > 0.5) => 0.1205194836,
      (f_inq_PrepaidCards_count24_i = NULL) => 0.0118732744, 0.0118732744),
   (k_inq_per_addr_i > 6.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 76) => 0.1577646627,
      (c_for_sale > 76) => 0.0371301719,
      (c_for_sale = NULL) => 0.0873945431, 0.0873945431),
   (k_inq_per_addr_i = NULL) => 0.0159190567, 0.0159190567),
(f_hh_criminals_i = NULL) => -0.0141636590, -0.0081755789);

// Tree: 37 
wFDN_FLA_S__lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0102800562,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0251995421,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 3.3) => 0.1563345433,
      (c_rnt500_p > 3.3) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 2.95) => 0.0821121192,
         (c_rnt1250_p > 2.95) => -0.0893823872,
         (c_rnt1250_p = NULL) => 0.0069946908, 0.0069946908),
      (c_rnt500_p = NULL) => 0.0714982891, 0.0714982891),
   (f_varrisktype_i = NULL) => 0.0277533876, 0.0277533876),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0800752661,
   (r_S66_adlperssn_count_i > 1.5) => 0.0626532845,
   (r_S66_adlperssn_count_i = NULL) => 0.0036301997, 0.0036301997), 0.0016611051);

// Tree: 38 
wFDN_FLA_S__lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0196095321,
   (f_crim_rel_under25miles_cnt_i > 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 72.5) => 0.0116089783,
      (k_comb_age_d > 72.5) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 1.35) => 0.2737809609,
         (c_bigapt_p > 1.35) => -0.0019607769,
         (c_bigapt_p = NULL) => 0.1485975953, 0.1485975953),
      (k_comb_age_d = NULL) => 0.0160550763, 0.0160550763),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0143676215, -0.0046402238),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1075198615,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1262) => 0.0698763473,
   (c_popover18 > 1262) => -0.0630083504,
   (c_popover18 = NULL) => 0.0010610574, 0.0010610574), -0.0040124621);

// Tree: 39 
wFDN_FLA_S__lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0056148664,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 3.15) => 0.0704525650,
         (c_hh7p_p > 3.15) => 0.2922421923,
         (c_hh7p_p = NULL) => 0.1205605919, 0.1205605919),
      (f_inq_count_i > 2.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 153) => 0.0264751797,
         (c_old_homes > 153) => -0.0701843281,
         (c_old_homes = NULL) => 0.0122654059, 0.0122654059),
      (f_inq_count_i = NULL) => 0.0325102792, 0.0325102792),
   (k_comb_age_d > 68.5) => 0.2584937709,
   (k_comb_age_d = NULL) => 0.0421740469, 0.0421740469),
(k_inq_per_ssn_i = NULL) => 0.0001190497, 0.0001190497);

// Tree: 40 
wFDN_FLA_S__lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0087344374,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < k_nap_addr_verd_d and k_nap_addr_verd_d <= 0.5) => 0.1911725437,
      (k_nap_addr_verd_d > 0.5) => 0.0302669697,
      (k_nap_addr_verd_d = NULL) => 0.0475393195, 0.0475393195),
   (f_hh_tot_derog_i = NULL) => -0.0056659054, -0.0056659054),
(f_addrchangecrimediff_i > 98.5) => 0.0999360595,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0032754318,
   (r_L79_adls_per_addr_c6_i > 4.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 56309.5) => 0.1216912619,
      (f_curraddrmedianincome_d > 56309.5) => -0.0101461494,
      (f_curraddrmedianincome_d = NULL) => 0.0661807729, 0.0661807729),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0072687252, 0.0072687252), -0.0020764893);

// Tree: 41 
wFDN_FLA_S__lgt_41 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 36.5) => -0.0040320869,
(r_pb_order_freq_d > 36.5) => -0.0316738584,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 25.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0158730142,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0780686520,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0081972664, 0.0081972664),
   (f_rel_homeover50_count_d > 25.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 115.5) => 0.0256872037,
      (c_rich_fam > 115.5) => 0.1974180819,
      (c_rich_fam = NULL) => 0.0899761991, 0.0899761991),
   (f_rel_homeover50_count_d = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 180836) => 0.1444171484,
      (r_L80_Inp_AVM_AutoVal_d > 180836) => 0.0311926045,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0192118872, 0.0230242014), 0.0123557199), -0.0078454728);

// Tree: 42 
wFDN_FLA_S__lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1212523725,
(r_D32_Mos_Since_Fel_LS_d > 125) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 
      map(
      (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => -0.0100620867,
      (f_hh_tot_derog_i > 5.5) => 0.0612916670,
      (f_hh_tot_derog_i = NULL) => -0.0080807011, -0.0080807011),
   (f_srchcomponentrisktype_i > 2.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0076372797,
      (r_C23_inp_addr_occ_index_d > 2) => 
         map(
         (NULL < c_robbery and c_robbery <= 136.5) => 0.0598691591,
         (c_robbery > 136.5) => 0.2418659254,
         (c_robbery = NULL) => 0.1252013316, 0.1252013316),
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0420994693, 0.0420994693),
   (f_srchcomponentrisktype_i = NULL) => -0.0059160663, -0.0059160663),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0097905945, -0.0052303010);

// Tree: 43 
wFDN_FLA_S__lgt_43 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0059583864,
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 11.5) => 0.1609951308,
   (r_C21_M_Bureau_ADL_FS_d > 11.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => 0.0045141561,
      (f_crim_rel_under100miles_cnt_i > 0.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 64.4) => 0.0927665812,
         (c_fammar_p > 64.4) => 0.0290327307,
         (c_fammar_p = NULL) => 0.0523222839, 0.0523222839),
      (f_crim_rel_under100miles_cnt_i = NULL) => 0.0290961944, 0.0290961944),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0353125110, 0.0353125110),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 8.4) => -0.0771762776,
   (c_famotf18_p > 8.4) => 0.0538778323,
   (c_famotf18_p = NULL) => -0.0057985927, -0.0057985927), -0.0021600550);

// Tree: 44 
wFDN_FLA_S__lgt_44 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 7.5) => 0.0174522352,
   (f_rel_homeover100_count_d > 7.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.49536460945) => 
         map(
         (NULL < c_wholesale and c_wholesale <= 0.55) => 0.0948081103,
         (c_wholesale > 0.55) => -0.0550462973,
         (c_wholesale = NULL) => 0.0347561602, 0.0347561602),
      (f_add_input_nhood_MFD_pct_i > 0.49536460945) => 0.2116098378,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0701110484, 0.0771178815),
   (f_rel_homeover100_count_d = NULL) => 0.0405825298, 0.0405825298),
(f_corrssnaddrcount_d > 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 0.0728050650,
   (r_C10_M_Hdr_FS_d > 10.5) => -0.0107204651,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0092098190, -0.0092098190),
(f_corrssnaddrcount_d = NULL) => 0.0033632733, -0.0044610530);

// Tree: 45 
wFDN_FLA_S__lgt_45 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 2.05) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0161046815,
   (f_corrrisktype_i > 7.5) => 0.0241732921,
   (f_corrrisktype_i = NULL) => 0.0059716678, -0.0087549588),
(c_hh7p_p > 2.05) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 20.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 0.0156694363,
      (k_comb_age_d > 67.5) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 37) => 0.2374369472,
         (c_rnt750_p > 37) => -0.0290286682,
         (c_rnt750_p = NULL) => 0.1491918408, 0.1491918408),
      (k_comb_age_d = NULL) => 0.0233765016, 0.0233765016),
   (f_srchaddrsrchcount_i > 20.5) => 0.1441056975,
   (f_srchaddrsrchcount_i = NULL) => 0.0258575420, 0.0258575420),
(c_hh7p_p = NULL) => -0.0491176714, -0.0021731060);

// Tree: 46 
wFDN_FLA_S__lgt_46 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1174145622,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 218.4) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0141624517,
      (f_srchcomponentrisktype_i > 1.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 2.55) => 
            map(
            (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 72.3) => 0.0478439921,
            (r_C12_source_profile_d > 72.3) => 0.2267092257,
            (r_C12_source_profile_d = NULL) => 0.0850479607, 0.0850479607),
         (c_hval_750k_p > 2.55) => -0.0295756882,
         (c_hval_750k_p = NULL) => 0.0410053764, 0.0410053764),
      (f_srchcomponentrisktype_i = NULL) => -0.0105153384, -0.0105153384),
   (c_cpiall > 218.4) => 0.0282605458,
   (c_cpiall = NULL) => 0.0051605215, -0.0009228545),
(f_attr_arrest_recency_d = NULL) => -0.0174377193, -0.0002555358);

// Tree: 47 
wFDN_FLA_S__lgt_47 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 15.5) => 0.1528793016,
      (r_D32_Mos_Since_Crim_LS_d > 15.5) => 0.0190339507,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0250744772, 0.0250744772),
   (f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0105274210,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0054379816, -0.0054379816),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 23.1) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 58.95) => 0.0127428751,
      (c_low_ed > 58.95) => 0.1562487104,
      (c_low_ed = NULL) => 0.0369711330, 0.0369711330),
   (c_hval_500k_p > 23.1) => 0.2704563307,
   (c_hval_500k_p = NULL) => 0.0589462104, 0.0589462104),
(k_comb_age_d = NULL) => -0.0010746425, -0.0014028824);

// Tree: 48 
wFDN_FLA_S__lgt_48 := map(
(NULL < c_employees and c_employees <= 31.5) => 
   map(
   (NULL < c_totsales and c_totsales <= 366.5) => 0.0119371164,
   (c_totsales > 366.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 187) => 
         map(
         (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 0.0726210093,
         (f_rel_criminal_count_i > 1.5) => 0.2284413953,
         (f_rel_criminal_count_i = NULL) => 0.1303322634, 0.1303322634),
      (r_C10_M_Hdr_FS_d > 187) => 0.0431031598,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0834119631, 0.0834119631),
   (c_totsales = NULL) => 0.0340526519, 0.0340526519),
(c_employees > 31.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => -0.0090073587,
   (f_phones_per_addr_curr_i > 50.5) => 0.0846460957,
   (f_phones_per_addr_curr_i = NULL) => 0.0176647980, -0.0072194474),
(c_employees = NULL) => 0.0135532849, -0.0024141385);

// Tree: 49 
wFDN_FLA_S__lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => -0.0013615810,
      (f_hh_criminals_i > 3.5) => 0.1248670472,
      (f_hh_criminals_i = NULL) => 0.0000728352, 0.0000728352),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 22.3) => 0.1511811875,
      (c_low_ed > 22.3) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 6.05) => -0.0459538373,
         (c_pop_18_24_p > 6.05) => 0.0618908474,
         (c_pop_18_24_p = NULL) => 0.0312241124, 0.0312241124),
      (c_low_ed = NULL) => 0.0543898191, 0.0543898191),
   (f_varrisktype_i = NULL) => 0.0024818202, 0.0024818202),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0736524269,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0128763719, -0.0005214845);

// Tree: 50 
wFDN_FLA_S__lgt_50 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 0.0190727792,
   (r_L79_adls_per_addr_curr_i > 3.5) => 0.1582168804,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0745041691, 0.0745041691),
(r_C21_M_Bureau_ADL_FS_d > 7.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 34.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -26.5) => 0.1509885202,
         (f_addrchangecrimediff_i > -26.5) => 0.0121946294,
         (f_addrchangecrimediff_i = NULL) => 0.0503603764, 0.0231650962),
      (c_born_usa > 34.5) => -0.0108262947,
      (c_born_usa = NULL) => -0.0019568342, -0.0034125492),
   (f_bus_addr_match_count_d > 52.5) => 0.2087422004,
   (f_bus_addr_match_count_d = NULL) => -0.0020179270, -0.0020179270),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0272393144, -0.0002640813);

// Tree: 51 
wFDN_FLA_S__lgt_51 := map(
(NULL < c_employees and c_employees <= 71.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30293) => 
      map(
      (NULL < c_assault and c_assault <= 176.5) => 0.0461298367,
      (c_assault > 176.5) => 0.1994716653,
      (c_assault = NULL) => 0.0796733617, 0.0796733617),
   (f_curraddrmedianincome_d > 30293) => 0.0154928828,
   (f_curraddrmedianincome_d = NULL) => 0.0225478362, 0.0225478362),
(c_employees > 71.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 6.3) => -0.0307103766,
      (c_hval_175k_p > 6.3) => 0.1403891856,
      (c_hval_175k_p = NULL) => 0.0631672593, 0.0631672593),
   (r_D33_Eviction_Recency_d > 48) => -0.0110266788,
   (r_D33_Eviction_Recency_d = NULL) => -0.0377304509, -0.0104044956),
(c_employees = NULL) => -0.0079503618, -0.0034708180);

// Tree: 52 
wFDN_FLA_S__lgt_52 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 19.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 191.5) => -0.0083335844,
      (c_unempl > 191.5) => 0.1065741544,
      (c_unempl = NULL) => 0.0130895498, -0.0070562695),
   (f_srchaddrsrchcount_i > 19.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 64.5) => -0.0242170303,
      (C_OWNOCC_P > 64.5) => 0.1521829821,
      (C_OWNOCC_P = NULL) => 0.0811153512, 0.0811153512),
   (f_srchaddrsrchcount_i = NULL) => -0.0059827013, -0.0059827013),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.45) => 0.0246716258,
   (c_unemp > 9.45) => 0.1301778737,
   (c_unemp = NULL) => 0.0312887423, 0.0312887423),
(f_phones_per_addr_curr_i = NULL) => 0.0092334004, -0.0024418668);

// Tree: 53 
wFDN_FLA_S__lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 129.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0148652178,
   (r_D32_felony_count_i > 0.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4) => -0.0090877598,
      (c_hval_125k_p > 4) => 0.1513043838,
      (c_hval_125k_p = NULL) => 0.0711083120, 0.0711083120),
   (r_D32_felony_count_i = NULL) => 0.0012226021, -0.0135997261),
(c_easiqlife > 129.5) => 
   map(
   (NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 0.0741621087,
      (f_prevaddrlenofres_d > 1.5) => 0.0112933382,
      (f_prevaddrlenofres_d = NULL) => 0.0154662871, 0.0154662871),
   (f_attr_arrests_i > 0.5) => 0.1282393614,
   (f_attr_arrests_i = NULL) => 0.0171639463, 0.0171639463),
(c_easiqlife = NULL) => -0.0097274994, -0.0021318700);

// Tree: 54 
wFDN_FLA_S__lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1410829029,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_unempl and c_unempl <= 190.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0053223958,
      (f_nae_nothing_found_i > 0.5) => 0.1093317457,
      (f_nae_nothing_found_i = NULL) => -0.0039688466, -0.0039688466),
   (c_unempl > 190.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 140.5) => -0.0203029958,
      (f_fp_prevaddrburglaryindex_i > 140.5) => 0.1562636198,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0707829567, 0.0707829567),
   (c_unempl = NULL) => -0.0135474142, -0.0034420271),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0629847759,
   (k_nap_lname_verd_d > 0.5) => -0.0469280847,
   (k_nap_lname_verd_d = NULL) => 0.0085724687, 0.0085724687), -0.0027653038);

// Tree: 55 
wFDN_FLA_S__lgt_55 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.35) => 0.0213183973,
   (c_pop_12_17_p > 10.35) => 0.2004989892,
   (c_pop_12_17_p = NULL) => 0.0531727247, 0.0531727247),
(r_C10_M_Hdr_FS_d > 11.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33253) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < c_retail and c_retail <= 13.6) => 0.0236764649,
         (c_retail > 13.6) => 0.1783021030,
         (c_retail = NULL) => 0.0811329862, 0.0811329862),
      (r_I60_inq_comm_recency_d > 549) => 0.0154664012,
      (r_I60_inq_comm_recency_d = NULL) => 0.0250613049, 0.0250613049),
   (f_curraddrmedianincome_d > 33253) => -0.0120896832,
   (f_curraddrmedianincome_d = NULL) => -0.0078305856, -0.0078305856),
(r_C10_M_Hdr_FS_d = NULL) => -0.0068636594, -0.0062772631);

// Tree: 56 
wFDN_FLA_S__lgt_56 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00563981495) => 0.1894614044,
   (f_add_curr_nhood_MFD_pct_i > 0.00563981495) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 163.5) => 0.0097415980,
      (c_rich_wht > 163.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0308622377) => 0.0425279365,
         (f_add_curr_nhood_VAC_pct_i > 0.0308622377) => 0.2303077200,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1171424200, 0.1171424200),
      (c_rich_wht = NULL) => 0.0293279798, 0.0293279798),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0126426014, 0.0344210220),
(f_corrssnaddrcount_d > 2.5) => -0.0051194276,
(f_corrssnaddrcount_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0625068583,
   (f_addrs_per_ssn_i > 5.5) => 0.0548457132,
   (f_addrs_per_ssn_i = NULL) => -0.0049589627, -0.0049589627), -0.0014212280);

// Tree: 57 
wFDN_FLA_S__lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0076213623,
      (c_lar_fam > 181.5) => 0.1147738509,
      (c_lar_fam = NULL) => -0.0157506932, -0.0066096119),
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1972.5) => 0.2253839966,
      (c_med_yearblt > 1972.5) => -0.0321179823,
      (c_med_yearblt = NULL) => 0.0947113506, 0.0947113506),
   (k_comb_age_d = NULL) => -0.0054729199, -0.0054729199),
(r_D30_Derog_Count_i > 11.5) => 0.0614801826,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 83.5) => 0.0608351533,
   (c_very_rich > 83.5) => -0.0711957547,
   (c_very_rich = NULL) => -0.0146110799, -0.0146110799), -0.0046927974);

// Tree: 58 
wFDN_FLA_S__lgt_58 := map(
(NULL < c_hh1_p and c_hh1_p <= 26.65) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.33923651595) => 0.0098786894,
   (f_add_curr_nhood_MFD_pct_i > 0.33923651595) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 65.7) => 
         map(
         (NULL < f_rel_count_i and f_rel_count_i <= 6.5) => -0.0227832376,
         (f_rel_count_i > 6.5) => 0.0651080021,
         (f_rel_count_i = NULL) => 0.0323991103, 0.0323991103),
      (c_rnt1000_p > 65.7) => 0.2759922367,
      (c_rnt1000_p = NULL) => 0.0422611802, 0.0422611802),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0119238887, 0.0101262442),
(c_hh1_p > 26.65) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => -0.0233286461,
   (f_hh_collections_ct_i > 4.5) => 0.1419340062,
   (f_hh_collections_ct_i = NULL) => -0.0214603456, -0.0214603456),
(c_hh1_p = NULL) => -0.0325407499, -0.0034228938);

// Tree: 59 
wFDN_FLA_S__lgt_59 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0158444481,
   (f_nae_nothing_found_i > 0.5) => 0.1247555897,
   (f_nae_nothing_found_i = NULL) => -0.0142276197, -0.0142276197),
(r_L79_adls_per_addr_curr_i > 3.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -60905) => 0.1055641870,
   (f_addrchangevaluediff_d > -60905) => 0.0101509365,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1714.5) => 0.0112169741,
      (c_popover25 > 1714.5) => 0.2212959946,
      (c_popover25 = NULL) => 0.0412800064, 0.0412800064), 0.0170199349),
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 98) => -0.0677751143,
   (c_assault > 98) => 0.0515689173,
   (c_assault = NULL) => -0.0124428815, -0.0124428815), -0.0048850678);

// Tree: 60 
wFDN_FLA_S__lgt_60 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 50) => 0.2450789240,
   (f_curraddrmurderindex_i > 50) => 
      map(
      (NULL < c_professional and c_professional <= 5.2) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 69) => -0.0267280854,
         (r_A50_pb_average_dollars_d > 69) => 0.1731126647,
         (r_A50_pb_average_dollars_d = NULL) => 0.0751138353, 0.0751138353),
      (c_professional > 5.2) => -0.0934442994,
      (c_professional = NULL) => 0.0141019952, 0.0141019952),
   (f_curraddrmurderindex_i = NULL) => 0.0747203747, 0.0747203747),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => -0.0027343560,
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 10.85) => -0.0699784377,
   (c_retail > 10.85) => 0.0446548702,
   (c_retail = NULL) => -0.0126617838, -0.0126617838), -0.0014678847);

// Tree: 61 
wFDN_FLA_S__lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 8.95) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.01205486775) => 0.0005068424,
      (f_add_input_nhood_BUS_pct_i > 0.01205486775) => 0.1299011298,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0923117279, 0.0923117279),
   (c_low_hval > 8.95) => -0.0541714587,
   (c_low_hval = NULL) => 0.0555402284, 0.0555402284),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 18.65) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -69530) => 0.1184414543,
      (f_addrchangevaluediff_d > -69530) => 0.0135166391,
      (f_addrchangevaluediff_d = NULL) => 0.0358318366, 0.0192531770),
   (c_hh1_p > 18.65) => -0.0128308410,
   (c_hh1_p = NULL) => -0.0254574568, -0.0021395259),
(r_D33_Eviction_Recency_d = NULL) => -0.0209149836, -0.0011822776);

// Tree: 62 
wFDN_FLA_S__lgt_62 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0067018533,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 34.5) => 
         map(
         (NULL < c_work_home and c_work_home <= 172.5) => 0.0628519544,
         (c_work_home > 172.5) => 0.3368118894,
         (c_work_home = NULL) => 0.0938556507, 0.0938556507),
      (c_born_usa > 34.5) => 0.0054430208,
      (c_born_usa = NULL) => 0.0206854962, 0.0206854962),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 9.85) => 0.0205057037,
      (C_INC_35K_P > 9.85) => 0.1717636941,
      (C_INC_35K_P = NULL) => 0.0961346989, 0.0961346989),
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0247591033, 0.0247591033),
(f_prevaddrageoldest_d = NULL) => 0.0395280508, 0.0011538699);

// Tree: 63 
wFDN_FLA_S__lgt_63 := map(
(NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 8.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 237802) => 0.1827414209,
   (r_A46_Curr_AVM_AutoVal_d > 237802) => 0.0269096337,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0066676140, 0.0548340206),
(f_M_Bureau_ADL_FS_all_d > 8.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0069774001,
   (c_hval_200k_p > 16.45) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 3.5) => 0.0191429178,
      (f_assocsuspicousidcount_i > 3.5) => 0.1172475760,
      (f_assocsuspicousidcount_i = NULL) => 0.0381012288, 0.0381012288),
   (c_hval_200k_p = NULL) => 0.0129058707, -0.0026548573),
(f_M_Bureau_ADL_FS_all_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0607600220,
   (c_pop_35_44_p > 16.05) => 0.0446229836,
   (c_pop_35_44_p = NULL) => -0.0136375398, -0.0136375398), -0.0016598630);

// Tree: 64 
wFDN_FLA_S__lgt_64 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => 0.0212985081,
      (f_crim_rel_under25miles_cnt_i > 4.5) => 0.1430643160,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.0317805002, 0.0317805002),
   (k_estimated_income_d > 28500) => -0.0082093036,
   (k_estimated_income_d = NULL) => -0.0056731952, -0.0056731952),
(f_prevaddrageoldest_d > 271.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 14.25) => 0.0220161299,
   (c_rnt1250_p > 14.25) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 30.5) => 0.1799849148,
      (r_pb_order_freq_d > 30.5) => 0.0421008309,
      (r_pb_order_freq_d = NULL) => 0.3091799225, 0.1377212394),
   (c_rnt1250_p = NULL) => 0.0487674992, 0.0487674992),
(f_prevaddrageoldest_d = NULL) => -0.0015013293, -0.0010257184);

// Tree: 65 
wFDN_FLA_S__lgt_65 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0055329810,
(f_prevaddrageoldest_d > 151.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.2569449510,
      (f_adl_per_email_i > 0.5) => -0.0758495946,
      (f_adl_per_email_i = NULL) => 0.0206560142, 0.0235512869),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 122) => 0.0284769917,
      (c_bargains > 122) => 0.1838004598,
      (c_bargains = NULL) => 0.0977428626, 0.0977428626),
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0274652332, 0.0274652332),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0447907522,
   (f_addrs_per_ssn_i > 3.5) => 0.0717580664,
   (f_addrs_per_ssn_i = NULL) => 0.0134836571, 0.0134836571), 0.0024349823);

// Tree: 66 
wFDN_FLA_S__lgt_66 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1536) => -0.0037410941,
(f_addrchangeincomediff_d > 1536) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.21126426755) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 11.5) => -0.0613038040,
      (f_rel_ageover20_count_d > 11.5) => 0.1450138754,
      (f_rel_ageover20_count_d = NULL) => 0.0161820213, 0.0161820213),
   (f_add_curr_nhood_MFD_pct_i > 0.21126426755) => 
      map(
      (NULL < c_health and c_health <= 4.65) => 0.1819395379,
      (c_health > 4.65) => 0.0275552098,
      (c_health = NULL) => 0.0829905090, 0.0829905090),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0782873564, 0.0345270752),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 11.5) => -0.0020580059,
   (f_srchaddrsrchcount_i > 11.5) => 0.0857117219,
   (f_srchaddrsrchcount_i = NULL) => 0.0005180034, 0.0016786075), -0.0008302458);

// Tree: 67 
wFDN_FLA_S__lgt_67 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6942.5) => -0.0043347321,
(f_addrchangeincomediff_d > 6942.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 76322) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 148.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 147.5) => 0.0179122126,
         (c_old_homes > 147.5) => 0.1563309681,
         (c_old_homes = NULL) => 0.0490876080, 0.0490876080),
      (c_easiqlife > 148.5) => 0.2257520067,
      (c_easiqlife = NULL) => 0.0815626813, 0.0815626813),
   (f_curraddrmedianincome_d > 76322) => -0.0367424900,
   (f_curraddrmedianincome_d = NULL) => 0.0431061616, 0.0431061616),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 3.5) => 0.1250403049,
   (c_employees > 3.5) => -0.0001963084,
   (c_employees = NULL) => -0.0071310677, 0.0027972514), -0.0012268537);

// Tree: 68 
wFDN_FLA_S__lgt_68 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 306.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 4.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0080225779,
      (k_inq_per_addr_i > 3.5) => 0.0291482758,
      (k_inq_per_addr_i = NULL) => -0.0041490876, -0.0041490876),
   (k_inq_ssns_per_addr_i > 4.5) => -0.0760305373,
   (k_inq_ssns_per_addr_i = NULL) => -0.0048082704, -0.0048082704),
(r_C13_Curr_Addr_LRes_d > 306.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0281185185,
   (f_corrrisktype_i > 6.5) => 0.2000693555,
   (f_corrrisktype_i = NULL) => 0.0488142659, 0.0488142659),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0900169508,
   (f_addrs_per_ssn_i > 3.5) => 0.0438091303,
   (f_addrs_per_ssn_i = NULL) => -0.0246845332, -0.0246845332), -0.0017057939);

// Tree: 69 
wFDN_FLA_S__lgt_69 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0166441439,
   (f_corrrisktype_i > 6.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 124382) => 
         map(
         (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 16.5) => 0.0417516632,
         (f_rel_incomeover25_count_d > 16.5) => 0.1465927731,
         (f_rel_incomeover25_count_d = NULL) => 0.0573569437, 0.0573569437),
      (r_L80_Inp_AVM_AutoVal_d > 124382) => 0.0055478465,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 15.75) => -0.0148101144,
         (c_pop_45_54_p > 15.75) => 0.0438863700,
         (c_pop_45_54_p = NULL) => 0.0049248916, 0.0036346066), 0.0105179283),
   (f_corrrisktype_i = NULL) => -0.0074705015, -0.0074705015),
(f_srchssnsrchcount_i > 22.5) => 0.0716575349,
(f_srchssnsrchcount_i = NULL) => -0.0165300741, -0.0070543144);

// Tree: 70 
wFDN_FLA_S__lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 4.75) => -0.0865803062,
   (c_pop_35_44_p > 4.75) => -0.0053412273,
   (c_pop_35_44_p = NULL) => -0.0072636680, -0.0072636680),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 6.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 0.0134436962,
      (k_inq_per_ssn_i > 2.5) => 0.1400217550,
      (k_inq_per_ssn_i = NULL) => 0.0316173722, 0.0316173722),
   (f_hh_members_ct_d > 6.5) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 7.65) => 0.2410842763,
      (C_INC_150K_P > 7.65) => 0.0378318995,
      (C_INC_150K_P = NULL) => 0.1311490285, 0.1311490285),
   (f_hh_members_ct_d = NULL) => 0.0482233883, 0.0482233883),
(c_hval_750k_p = NULL) => 0.0187418342, -0.0024954376);

// Tree: 71 
wFDN_FLA_S__lgt_71 := map(
(NULL < c_hhsize and c_hhsize <= 2.615) => -0.0090815077,
(c_hhsize > 2.615) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0099678327,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 163.5) => 
         map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 3.5) => 
            map(
            (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.9364888959) => 0.1304081352,
            (f_add_curr_nhood_SFD_pct_d > 0.9364888959) => 0.0162278355,
            (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0814015464, 0.0814015464),
         (f_corrssnaddrcount_d > 3.5) => -0.0068304294,
         (f_corrssnaddrcount_d = NULL) => 0.0203363642, 0.0203363642),
      (r_C13_Curr_Addr_LRes_d > 163.5) => 0.1702043159,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0477064579, 0.0477064579),
   (f_rel_felony_count_i = NULL) => -0.0234039850, 0.0152499943),
(c_hhsize = NULL) => -0.0199525265, 0.0023045339);

// Tree: 72 
wFDN_FLA_S__lgt_72 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => -0.0069644541,
   (k_comb_age_d > 63.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 103) => -0.0037530054,
      (f_curraddrmurderindex_i > 103) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.064635476) => 0.1802278543,
         (f_add_curr_nhood_BUS_pct_i > 0.064635476) => -0.0167550482,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1074298251, 0.1074298251),
      (f_curraddrmurderindex_i = NULL) => 0.0296896407, 0.0296896407),
   (k_comb_age_d = NULL) => -0.0028803752, -0.0028803752),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0868896026,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 115) => 0.0248240211,
   (c_robbery > 115) => -0.0705143741,
   (c_robbery = NULL) => -0.0145720100, -0.0145720100), -0.0026232779);

// Tree: 73 
wFDN_FLA_S__lgt_73 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 190.5) => -0.0009385973,
   (f_curraddrcrimeindex_i > 190.5) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 0.1606764436,
      (r_I60_inq_recency_d > 4.5) => 0.0358275437,
      (r_I60_inq_recency_d = NULL) => 0.0572792448, 0.0572792448),
   (f_curraddrcrimeindex_i = NULL) => 0.0004331754, 0.0004331754),
(f_hh_collections_ct_i > 4.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 11.7) => -0.0447128982,
   (c_pop_45_54_p > 11.7) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 12.85) => 0.0342695902,
      (c_pop_25_34_p > 12.85) => 0.2360240346,
      (c_pop_25_34_p = NULL) => 0.1213578396, 0.1213578396),
   (c_pop_45_54_p = NULL) => 0.0657360614, 0.0657360614),
(f_hh_collections_ct_i = NULL) => 0.0018982111, 0.0015588957);

// Tree: 74 
wFDN_FLA_S__lgt_74 := map(
(NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 1.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 5.35) => -0.0025752386,
      (c_hval_125k_p > 5.35) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 24.5) => 0.2260939705,
         (r_C10_M_Hdr_FS_d > 24.5) => 
            map(
            (NULL < C_INC_25K_P and C_INC_25K_P <= 6.55) => 0.1477749825,
            (C_INC_25K_P > 6.55) => 0.0062282110,
            (C_INC_25K_P = NULL) => 0.0458102334, 0.0458102334),
         (r_C10_M_Hdr_FS_d = NULL) => 0.0575395368, 0.0575395368),
      (c_hval_125k_p = NULL) => 0.0708204384, 0.0207082060),
   (f_hh_members_ct_d > 1.5) => -0.0088347133,
   (f_hh_members_ct_d = NULL) => -0.0032684845, -0.0032684845),
(f_vardobcountnew_i > 1.5) => 0.0987948246,
(f_vardobcountnew_i = NULL) => 0.0255330416, -0.0022267161);

// Tree: 75 
wFDN_FLA_S__lgt_75 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 84) => 
   map(
   (NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1450) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0126742916,
      (f_hh_lienholders_i > 0.5) => 
         map(
         (NULL < f_rel_count_i and f_rel_count_i <= 2.5) => 0.1376330060,
         (f_rel_count_i > 2.5) => 
            map(
            (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 27.5) => 0.0117396950,
            (f_addrs_per_ssn_i > 27.5) => -0.1242673144,
            (f_addrs_per_ssn_i = NULL) => 0.0097015916, 0.0097015916),
         (f_rel_count_i = NULL) => 0.0139063767, 0.0139063767),
      (f_hh_lienholders_i = NULL) => -0.0044471447, -0.0044471447),
   (f_liens_rel_SC_total_amt_i > 1450) => -0.1267230235,
   (f_liens_rel_SC_total_amt_i = NULL) => -0.0198957418, -0.0051040718),
(f_bus_addr_match_count_d > 84) => 0.1841417707,
(f_bus_addr_match_count_d = NULL) => -0.0043432095, -0.0043432095);

// Tree: 76 
wFDN_FLA_S__lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0113361715,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => -0.0041562611,
         (f_prevaddrlenofres_d > 123.5) => 
            map(
            (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0413794463,
            (f_rel_homeover500_count_d > 3.5) => 0.1951829497,
            (f_rel_homeover500_count_d = NULL) => 0.0662297940, 0.0662297940),
         (f_prevaddrlenofres_d = NULL) => 0.0151255820, 0.0151255820),
      (f_nae_nothing_found_i > 0.5) => 0.2072815364,
      (f_nae_nothing_found_i = NULL) => 0.0182185225, 0.0182185225),
   (f_inq_Communications_count24_i > 1.5) => 0.1295421170,
   (f_inq_Communications_count24_i = NULL) => 0.0205470676, 0.0205470676),
(c_rnt1250_p = NULL) => -0.0007058692, -0.0022591741);

// Tree: 77 
wFDN_FLA_S__lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => -0.0151158770,
   (c_pop_35_44_p > 14.75) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 0.0047991621,
      (f_divrisktype_i > 1.5) => 
         map(
         (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 
            map(
            (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 292007) => 0.0826260513,
            (r_A46_Curr_AVM_AutoVal_d > 292007) => 0.1686239722,
            (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0102829915, 0.0600968914),
         (f_curraddractivephonelist_d > 0.5) => 0.0374784557,
         (f_curraddractivephonelist_d = NULL) => 0.0489918110, 0.0489918110),
      (f_divrisktype_i = NULL) => 0.0382732891, 0.0111773843),
   (c_pop_35_44_p = NULL) => -0.0018742157, -0.0018742157),
(c_transport > 29.05) => 0.1087456955,
(c_transport = NULL) => -0.0042181481, -0.0001074286);

// Tree: 78 
wFDN_FLA_S__lgt_78 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0086888116,
      (f_varrisktype_i > 2.5) => 0.1795176493,
      (f_varrisktype_i = NULL) => 0.0816269670, 0.0816269670),
   (r_C13_max_lres_d > 18.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0075852982,
      (f_corrrisktype_i > 7.5) => 
         map(
         (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 125.5) => 0.0066253806,
         (f_curraddrburglaryindex_i > 125.5) => 0.0615898877,
         (f_curraddrburglaryindex_i = NULL) => 0.0210363304, 0.0210363304),
      (f_corrrisktype_i = NULL) => -0.0024821422, -0.0024821422),
   (r_C13_max_lres_d = NULL) => -0.0012375316, -0.0012375316),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0611195851,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0187959785, -0.0035909089);

// Tree: 79 
wFDN_FLA_S__lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => -0.0036000774,
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 53.55) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 16.5) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 4.4) => -0.0858599388,
         (C_INC_125K_P > 4.4) => 
            map(
            (NULL < c_hval_750k_p and c_hval_750k_p <= 0.9) => 0.0806942196,
            (c_hval_750k_p > 0.9) => -0.0590663453,
            (c_hval_750k_p = NULL) => 0.0210403200, 0.0210403200),
         (C_INC_125K_P = NULL) => -0.0068885765, -0.0068885765),
      (f_addrs_per_ssn_i > 16.5) => 0.1066533913,
      (f_addrs_per_ssn_i = NULL) => 0.0156558576, 0.0156558576),
   (c_newhouse > 53.55) => 0.1470885169,
   (c_newhouse = NULL) => 0.0370980437, 0.0370980437),
(f_inq_PrepaidCards_count_i = NULL) => -0.0062825164, -0.0025322827);

// Tree: 80 
wFDN_FLA_S__lgt_80 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 38.35) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0174275117,
   (k_comb_age_d > 56.5) => 0.0274593225,
   (k_comb_age_d = NULL) => -0.0271379957, -0.0081256306),
(c_fammar18_p > 38.35) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 18720.5) => 0.1486182584,
      (f_curraddrmedianincome_d > 18720.5) => -0.0067255564,
      (f_curraddrmedianincome_d = NULL) => -0.0027345098, -0.0027345098),
   (f_hh_collections_ct_i > 1.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 123.5) => 0.1750035264,
      (f_mos_liens_unrel_SC_fseen_d > 123.5) => 0.0388922807,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0435857719, 0.0435857719),
   (f_hh_collections_ct_i = NULL) => 0.0110973684, 0.0110973684),
(c_fammar18_p = NULL) => 0.0297354740, 0.0004908992);

// Tree: 81 
wFDN_FLA_S__lgt_81 := map(
(NULL < c_easiqlife and c_easiqlife <= 142.5) => -0.0139685603,
(c_easiqlife > 142.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 126.5) => 0.0008624675,
   (r_C13_Curr_Addr_LRes_d > 126.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 76.5) => 
         map(
         (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
            map(
            (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 16.5) => 0.0307663777,
            (f_rel_homeover300_count_d > 16.5) => 0.1824727381,
            (f_rel_homeover300_count_d = NULL) => 0.0407324890, 0.0407324890),
         (r_L70_Add_Standardized_i > 0.5) => 0.2216369092,
         (r_L70_Add_Standardized_i = NULL) => 0.0539297812, 0.0539297812),
      (k_comb_age_d > 76.5) => 0.2596876615,
      (k_comb_age_d = NULL) => 0.0650695390, 0.0650695390),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0179372753, 0.0179372753),
(c_easiqlife = NULL) => 0.0116177841, -0.0044183466);

// Tree: 82 
wFDN_FLA_S__lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0039276072,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 46.5) => -0.0259151870,
      (f_mos_inq_banko_cm_fseen_d > 46.5) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 6.65) => -0.0115710775,
         (c_pop_6_11_p > 6.65) => 
            map(
            (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 60.5) => 0.0587386206,
            (r_C13_Curr_Addr_LRes_d > 60.5) => 0.2139482578,
            (r_C13_Curr_Addr_LRes_d = NULL) => 0.1314161491, 0.1314161491),
         (c_pop_6_11_p = NULL) => 0.0902164398, 0.0902164398),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0473877547, 0.0473877547),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0027677056, -0.0027677056),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0671003764,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0085972807, -0.0031354313);

// Tree: 83 
wFDN_FLA_S__lgt_83 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0003937273,
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < c_construction and c_construction <= 8.05) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 95) => 0.0238504864,
         (f_curraddrmurderindex_i > 95) => 0.0956138865,
         (f_curraddrmurderindex_i = NULL) => 0.0529887579, 0.0529887579),
      (c_construction > 8.05) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => 0.0270320934,
         (f_srchfraudsrchcount_i > 4.5) => -0.0569580814,
         (f_srchfraudsrchcount_i = NULL) => 0.0018894035, 0.0018894035),
      (c_construction = NULL) => 0.0316255754, 0.0316255754),
   (k_inq_per_ssn_i = NULL) => 0.0034846598, 0.0034846598),
(r_L77_Add_PO_Box_i > 0.5) => -0.0889989216,
(r_L77_Add_PO_Box_i = NULL) => 0.0013484604, 0.0013484604);

// Tree: 84 
wFDN_FLA_S__lgt_84 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => 0.0228744913,
      (k_inq_per_ssn_i > 1.5) => 0.1557831132,
      (k_inq_per_ssn_i = NULL) => 0.0477172244, 0.0477172244),
   (r_C21_M_Bureau_ADL_FS_d > 20.5) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 0.0037712894,
      (k_inq_adls_per_addr_i > 3.5) => -0.0662181144,
      (k_inq_adls_per_addr_i = NULL) => 0.0023982397, 0.0023982397),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0040079098, 0.0040079098),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0545226907,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 9.95) => -0.0318067444,
   (C_INC_125K_P > 9.95) => 0.0804986048,
   (C_INC_125K_P = NULL) => 0.0176837485, 0.0176837485), 0.0017951451);

// Tree: 85 
wFDN_FLA_S__lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0099060308,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 8.5) => 0.0102497019,
      (f_inq_Collection_count_i > 8.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 10.8) => 0.0161499940,
         (c_hval_250k_p > 10.8) => 0.1751864896,
         (c_hval_250k_p = NULL) => 0.0866792225, 0.0866792225),
      (f_inq_Collection_count_i = NULL) => 0.0163494658, 0.0163494658),
   (r_F01_inp_addr_not_verified_i > 0.5) => 0.1346747274,
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0230499954, 0.0230499954),
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 111.5) => -0.0497896675,
   (c_preschl > 111.5) => 0.0533159215,
   (c_preschl = NULL) => 0.0017631270, 0.0017631270), -0.0057531041);

// Tree: 86 
wFDN_FLA_S__lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 45.5) => -0.0033622795,
   (f_rel_under500miles_cnt_d > 45.5) => -0.1299952793,
   (f_rel_under500miles_cnt_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 6.7) => -0.0387360010,
      (c_hval_200k_p > 6.7) => 0.2415045924,
      (c_hval_200k_p = NULL) => 0.0359948239, 0.0359948239), -0.0033532546),
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 5.5) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 47.5) => 0.1149128822,
      (c_no_teens > 47.5) => 0.0094342262,
      (c_no_teens = NULL) => 0.0259549796, 0.0259549796),
   (f_srchssnsrchcount_i > 5.5) => 0.1139042453,
   (f_srchssnsrchcount_i = NULL) => 0.0351496755, 0.0351496755),
(f_phones_per_addr_curr_i = NULL) => -0.0155784491, -0.0014646353);

// Tree: 87 
wFDN_FLA_S__lgt_87 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 3.5) => 0.0942929333,
   (r_D32_Mos_Since_Crim_LS_d > 3.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 19.5) => -0.0055157041,
         (f_rel_homeover150_count_d > 19.5) => -0.0520007110,
         (f_rel_homeover150_count_d = NULL) => -0.0076664807, -0.0073814981),
      (f_hh_collections_ct_i > 5.5) => 0.0866288706,
      (f_hh_collections_ct_i = NULL) => -0.0068040015, -0.0068040015),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1147.5) => 0.0532554066,
      (c_popover25 > 1147.5) => -0.0452916786,
      (c_popover25 = NULL) => 0.0056809517, 0.0056809517), -0.0059112245),
(r_L72_Add_Vacant_i > 0.5) => 0.1185209624,
(r_L72_Add_Vacant_i = NULL) => -0.0050865852, -0.0050865852);

// Tree: 88 
wFDN_FLA_S__lgt_88 := map(
(NULL < c_exp_prod and c_exp_prod <= 42.5) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 171) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 60235) => 0.1276448501,
         (r_A46_Curr_AVM_AutoVal_d > 60235) => 0.0630209629,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0030466098, 0.0322445978),
      (c_born_usa > 171) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 51.75) => 0.1969868289,
         (c_fammar_p > 51.75) => 0.0352517930,
         (c_fammar_p = NULL) => 0.1196975197, 0.1196975197),
      (c_born_usa = NULL) => 0.0404184441, 0.0404184441),
   (f_inq_QuizProvider_count_i > 1.5) => -0.0751934360,
   (f_inq_QuizProvider_count_i = NULL) => 0.0275066103, 0.0275066103),
(c_exp_prod > 42.5) => -0.0015663920,
(c_exp_prod = NULL) => -0.0403139354, 0.0007358241);

// Tree: 89 
wFDN_FLA_S__lgt_89 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 43.05) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0077471654,
   (r_D33_eviction_count_i > 2.5) => 0.0521538638,
   (r_D33_eviction_count_i = NULL) => 0.0082717605, -0.0069265068),
(c_hval_750k_p > 43.05) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 291) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 145.5) => -0.0147688832,
      (c_very_rich > 145.5) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 538194) => 0.2254138268,
         (f_prevaddrmedianvalue_d > 538194) => 0.0483797275,
         (f_prevaddrmedianvalue_d = NULL) => 0.0893405583, 0.0893405583),
      (c_very_rich = NULL) => 0.0224652088, 0.0224652088),
   (r_C13_Curr_Addr_LRes_d > 291) => 0.2184455666,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0402134300, 0.0402134300),
(c_hval_750k_p = NULL) => 0.0127202452, -0.0035313322);

// Tree: 90 
wFDN_FLA_S__lgt_90 := map(
(NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 2340.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0011599310,
   (r_D32_felony_count_i > 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 229) => 0.1452675653,
      (f_M_Bureau_ADL_FS_all_d > 229) => -0.0160619674,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0695414581, 0.0695414581),
   (r_D32_felony_count_i = NULL) => -0.0002962142, -0.0002962142),
(f_liens_unrel_CJ_total_amt_i > 2340.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 0.15) => 0.0044908741,
   (c_hval_80k_p > 0.15) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => -0.0666576193,
      (f_varrisktype_i > 1.5) => -0.1268051020,
      (f_varrisktype_i = NULL) => -0.0819093024, -0.0819093024),
   (c_hval_80k_p = NULL) => -0.0403923345, -0.0403923345),
(f_liens_unrel_CJ_total_amt_i = NULL) => -0.0248445259, -0.0022247524);

// Tree: 91 
wFDN_FLA_S__lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.45) => 0.0283488574,
   (c_retired > 15.45) => 0.1914878257,
   (c_retired = NULL) => 0.0718017602, 0.0718017602),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0115794261,
      (f_srchfraudsrchcountmo_i > 0.5) => 
         map(
         (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 0.5) => 0.0211889744,
         (f_inq_QuizProvider_count24_i > 0.5) => 0.1868361869,
         (f_inq_QuizProvider_count24_i = NULL) => 0.0445082422, 0.0445082422),
      (f_srchfraudsrchcountmo_i = NULL) => -0.0095941925, -0.0095941925),
   (c_food > 65.55) => 0.0534505517,
   (c_food = NULL) => -0.0060295301, -0.0072893969),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0083203043, -0.0058012011);

// Tree: 92 
wFDN_FLA_S__lgt_92 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.05) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 35.5) => -0.0041438298,
      (f_srchaddrsrchcount_i > 35.5) => -0.1030022234,
      (f_srchaddrsrchcount_i = NULL) => -0.0046432602, -0.0046432602),
   (f_assocsuspicousidcount_i > 15.5) => 0.0958162754,
   (f_assocsuspicousidcount_i = NULL) => 0.0063211961, -0.0040329124),
(c_hh3_p > 23.05) => 
   map(
   (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 0.0203328805,
      (k_comb_age_d > 69.5) => 0.1413676809,
      (k_comb_age_d = NULL) => 0.0261977190, 0.0261977190),
   (f_acc_damage_amt_total_i > 275) => 0.1984129282,
   (f_acc_damage_amt_total_i = NULL) => 0.0308353114, 0.0308353114),
(c_hh3_p = NULL) => -0.0444551783, 0.0003589064);

// Tree: 93 
wFDN_FLA_S__lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 0.0015842675,
      (r_D33_eviction_count_i > 3.5) => 0.0992080790,
      (r_D33_eviction_count_i = NULL) => 0.0021608354, 0.0021608354),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.1668789706,
      (f_prevaddrstatus_i > 2.5) => 0.0852128168,
      (f_prevaddrstatus_i = NULL) => 0.0291270605, 0.0908485667),
   (f_curraddrcartheftindex_i = NULL) => -0.0027176162, 0.0037546008),
(c_cartheft > 189.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 33.25) => -0.1080873638,
   (c_hh1_p > 33.25) => -0.0286034147,
   (c_hh1_p = NULL) => -0.0502632743, -0.0502632743),
(c_cartheft = NULL) => 0.0013289898, 0.0019521934);

// Tree: 94 
wFDN_FLA_S__lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 8.15) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00720134655) => 0.1655769453,
         (f_add_curr_nhood_MFD_pct_i > 0.00720134655) => 0.0142997529,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0014300640, 0.0197306410),
      (c_hh7p_p > 8.15) => 0.1404123761,
      (c_hh7p_p = NULL) => 0.0238884039, 0.0238884039),
   (f_hh_members_ct_d > 1.5) => -0.0052060510,
   (f_hh_members_ct_d = NULL) => -0.0002693739, 0.0002115173),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 1990) => 0.0039150088,
   (r_A50_pb_total_dollars_d > 1990) => 0.1163362685,
   (r_A50_pb_total_dollars_d = NULL) => 0.0632734339, 0.0632734339),
(c_famotf18_p = NULL) => 0.0100416882, 0.0010809803);

// Tree: 95 
wFDN_FLA_S__lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0638917621,
   (f_corrssnaddrcount_d > 0.5) => -0.0071284070,
   (f_corrssnaddrcount_d = NULL) => -0.0259066926, -0.0084819515),
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 30.45) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30897.5) => 0.1512585631,
      (f_curraddrmedianincome_d > 30897.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 0.0046012289,
         (k_comb_age_d > 66.5) => 0.1550620627,
         (k_comb_age_d = NULL) => 0.0146389952, 0.0146389952),
      (f_curraddrmedianincome_d = NULL) => 0.0202509774, 0.0202509774),
   (C_INC_75K_P > 30.45) => 0.1849995400,
   (C_INC_75K_P = NULL) => 0.0275192964, 0.0275192964),
(c_rnt1000_p = NULL) => -0.0076150635, -0.0040237609);

// Tree: 96 
wFDN_FLA_S__lgt_96 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45599.5) => 
   map(
   (NULL < c_construction and c_construction <= 40.1) => 0.0147742404,
   (c_construction > 40.1) => 0.1501857612,
   (c_construction = NULL) => -0.0171607133, 0.0168306739),
(f_curraddrmedianincome_d > 45599.5) => 
   map(
   (NULL < c_transport and c_transport <= 29.05) => -0.0131849104,
   (c_transport > 29.05) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => 0.2299600248,
      (f_rel_incomeover50_count_d > 4.5) => 0.0065549985,
      (f_rel_incomeover50_count_d = NULL) => 0.0941056169, 0.0941056169),
   (c_transport = NULL) => -0.0114789979, -0.0114789979),
(f_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.26693968695) => -0.0712796101,
   (f_add_input_mobility_index_i > 0.26693968695) => 0.0395099180,
   (f_add_input_mobility_index_i = NULL) => -0.0082441890, -0.0082441890), -0.0045193417);

// Tree: 97 
wFDN_FLA_S__lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0044986231,
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 8.5) => -0.0298258198,
      (f_rel_homeover50_count_d > 8.5) => 0.1278856271,
      (f_rel_homeover50_count_d = NULL) => 0.0607890905, 0.0607890905),
   (f_assoccredbureaucountnew_i = NULL) => -0.0033015504, -0.0033015504),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 11.5) => 0.1283848523,
   (f_rel_under500miles_cnt_d > 11.5) => -0.0021327294,
   (f_rel_under500miles_cnt_d = NULL) => 0.0554183302, 0.0554183302),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_health and c_health <= 9.05) => 0.0393080975,
   (c_health > 9.05) => -0.0733927876,
   (c_health = NULL) => -0.0130879280, -0.0130879280), -0.0028031502);

// Tree: 98 
wFDN_FLA_S__lgt_98 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0044345713,
(f_rel_homeover500_count_d > 14.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.24094392385) => 0.1795060338,
   (f_add_input_mobility_index_i > 0.24094392385) => -0.0256348690,
   (f_add_input_mobility_index_i = NULL) => 0.0722305158, 0.0722305158),
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 172.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 2.65) => 0.0455871888,
         (c_hval_200k_p > 2.65) => 0.1958571323,
         (c_hval_200k_p = NULL) => 0.1207221605, 0.1207221605),
      (c_bigapt_p > 1.15) => 0.0082491283,
      (c_bigapt_p = NULL) => 0.0603199766, 0.0603199766),
   (c_no_teens > 172.5) => -0.1070559545,
   (c_no_teens = NULL) => 0.0159141173, 0.0159141173), -0.0032897430);

// Tree: 99 
wFDN_FLA_S__lgt_99 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37732321285) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2) => 0.0026202769,
   (f_idverrisktype_i > 2) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 509356.5) => -0.0069930620,
         (c_med_hval > 509356.5) => 0.1093899922,
         (c_med_hval = NULL) => -0.0220900762, 0.0055586667),
      (f_phones_per_addr_curr_i > 4.5) => 0.0588021336,
      (f_phones_per_addr_curr_i = NULL) => 0.0254121628, 0.0254121628),
   (f_idverrisktype_i = NULL) => 0.0454749896, 0.0082555811),
(f_add_input_mobility_index_i > 0.37732321285) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 31.5) => -0.0302218146,
   (f_phones_per_addr_curr_i > 31.5) => 0.0644104747,
   (f_phones_per_addr_curr_i = NULL) => -0.0248810930, -0.0248810930),
(f_add_input_mobility_index_i = NULL) => 0.0040205843, 0.0025494586);

// Tree: 100 
wFDN_FLA_S__lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_transport and c_transport <= 26.6) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 17.9) => 0.0357593034,
         (c_vacant_p > 17.9) => 0.1644224157,
         (c_vacant_p = NULL) => 0.0600547316, 0.0600547316),
      (k_estimated_income_d > 30500) => 0.0027466610,
      (k_estimated_income_d = NULL) => 0.0063988364, 0.0063988364),
   (c_transport > 26.6) => 0.1537702378,
   (c_transport = NULL) => -0.0007675405, 0.0087941257),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 39.35) => -0.0147229529,
   (c_famotf18_p > 39.35) => -0.0735501086,
   (c_famotf18_p = NULL) => 0.0888321473, -0.0157853304),
(f_historical_count_d = NULL) => 0.0082914755, -0.0035471173);

// Tree: 101 
wFDN_FLA_S__lgt_101 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 4.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0030917517,
      (k_comb_age_d > 81.5) => 0.0754195850,
      (k_comb_age_d = NULL) => -0.0022438420, -0.0022438420),
   (f_hh_workers_paw_d > 4.5) => -0.0961143866,
   (f_hh_workers_paw_d = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0782976054,
      (f_addrs_per_ssn_i > 3.5) => 0.0599139490,
      (f_addrs_per_ssn_i = NULL) => -0.0079794462, -0.0079794462), -0.0029261420),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => -0.0212446257,
   (f_addrs_per_ssn_i > 7.5) => 0.2478376233,
   (f_addrs_per_ssn_i = NULL) => 0.0705599063, 0.0705599063),
(f_nae_nothing_found_i = NULL) => -0.0019413073, -0.0019413073);

// Tree: 102 
wFDN_FLA_S__lgt_102 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0092028333,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 44) => -0.1175067775,
   (f_mos_inq_banko_am_fseen_d > 44) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0216961219) => 0.0841046914,
         (f_add_input_nhood_BUS_pct_i > 0.0216961219) => -0.0837539891,
         (f_add_input_nhood_BUS_pct_i = NULL) => -0.0474417031, -0.0474417031),
      (C_INC_150K_P > 0.55) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => 0.0747629490,
         (k_estimated_income_d > 30500) => 0.0172739469,
         (k_estimated_income_d = NULL) => 0.0205457780, 0.0205457780),
      (C_INC_150K_P = NULL) => 0.0390043065, 0.0173455266),
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0139434697, 0.0139434697),
(k_inq_per_ssn_i = NULL) => 0.0002272096, 0.0002272096);

// Tree: 103 
wFDN_FLA_S__lgt_103 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 701.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 76) => 0.1926776711,
         (c_no_teens > 76) => 0.0358291382,
         (c_no_teens = NULL) => 0.0963392321, 0.0963392321),
      (c_popover25 > 701.5) => -0.0188299080,
      (c_popover25 = NULL) => 0.1280732733, 0.0470870863),
   (k_estimated_income_d > 27500) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 21622) => -0.0778370357,
      (c_med_hhinc > 21622) => -0.0002774776,
      (c_med_hhinc = NULL) => -0.0080013253, -0.0013369413),
   (k_estimated_income_d = NULL) => 0.0010896958, 0.0010896958),
(f_srchaddrsrchcount_i > 32.5) => -0.0854629666,
(f_srchaddrsrchcount_i = NULL) => -0.0051541708, 0.0004403855);

// Tree: 104 
wFDN_FLA_S__lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 773816) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => -0.0027040645,
   (k_inq_per_ssn_i > 7.5) => 0.0514375774,
   (k_inq_per_ssn_i = NULL) => -0.0016163878, -0.0016163878),
(f_prevaddrmedianvalue_d > 773816) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 0.5) => 0.0118227883,
   (f_bus_addr_match_count_d > 0.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1065.5) => 0.0744930306,
      (c_popover18 > 1065.5) => 0.4787118865,
      (c_popover18 = NULL) => 0.2766024586, 0.2766024586),
   (f_bus_addr_match_count_d = NULL) => 0.1173364915, 0.1173364915),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.15) => 0.0331394681,
   (c_construction > 4.15) => -0.0518420299,
   (c_construction = NULL) => -0.0147988128, -0.0147988128), 0.0007491499);

// Tree: 105 
wFDN_FLA_S__lgt_105 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0102961446,
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 85) => -0.0029283662,
   (f_curraddrcrimeindex_i > 85) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 186) => 
         map(
         (NULL < C_INC_200K_P and C_INC_200K_P <= 4.95) => 0.0424106431,
         (C_INC_200K_P > 4.95) => -0.0324167947,
         (C_INC_200K_P = NULL) => 0.0196430264, 0.0196430264),
      (c_rich_blk > 186) => 
         map(
         (NULL < c_very_rich and c_very_rich <= 128.5) => 0.0625011993,
         (c_very_rich > 128.5) => 0.2504263335,
         (c_very_rich = NULL) => 0.1195674704, 0.1195674704),
      (c_rich_blk = NULL) => 0.0300666030, 0.0300666030),
   (f_curraddrcrimeindex_i = NULL) => 0.0115157498, 0.0115157498),
(f_corrrisktype_i = NULL) => -0.0139158307, -0.0030887114);

// Tree: 106 
wFDN_FLA_S__lgt_106 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 36.15) => -0.0051855076,
   (c_hh3_p > 36.15) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 33.75) => 0.0087907007,
      (c_fammar18_p > 33.75) => 0.2344590215,
      (c_fammar18_p = NULL) => 0.1069073619, 0.1069073619),
   (c_hh3_p = NULL) => -0.0301557780, -0.0047256576),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 126.5) => -0.0223193401,
   (c_blue_empl > 126.5) => 0.3069408905,
   (c_blue_empl = NULL) => 0.1559040875, 0.1559040875),
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 99.5) => -0.0484392613,
   (c_no_car > 99.5) => 0.0420849577,
   (c_no_car = NULL) => -0.0039071858, -0.0039071858), -0.0033371352);

// Tree: 107 
wFDN_FLA_S__lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0869251590,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0040724188,
   (f_addrchangecrimediff_i > 61.5) => 
      map(
      (NULL < c_families and c_families <= 201) => -0.0699390925,
      (c_families > 201) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0369729591) => 0.0142677897,
         (f_add_input_nhood_VAC_pct_i > 0.0369729591) => 0.1809741397,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0997223053, 0.0997223053),
      (c_families = NULL) => 0.0481293656, 0.0481293656),
   (f_addrchangecrimediff_i = NULL) => 0.0033745406, -0.0017620615),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 4.15) => 0.0734922659,
   (c_femdiv_p > 4.15) => -0.0471274000,
   (c_femdiv_p = NULL) => 0.0114258359, 0.0114258359), -0.0010135530);

// Tree: 108 
wFDN_FLA_S__lgt_108 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 56.25) => -0.0028739849,
   (c_trailer_p > 56.25) => 0.1765132216,
   (c_trailer_p = NULL) => 0.0314439312, -0.0009903581),
(f_phones_per_addr_curr_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 0.0144318612,
      (r_D30_Derog_Count_i > 5.5) => 0.0960350838,
      (r_D30_Derog_Count_i = NULL) => 0.0201153701, 0.0201153701),
   (r_C12_source_profile_d > 81.3) => 0.2502532517,
   (r_C12_source_profile_d = NULL) => 0.0295021472, 0.0295021472),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 74.5) => -0.0904210424,
   (c_assault > 74.5) => 0.0231845614,
   (c_assault = NULL) => -0.0315144330, -0.0315144330), 0.0021559661);

// Tree: 109 
wFDN_FLA_S__lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 0.0067717594,
   (f_srchssnsrchcount_i > 21.5) => 0.0930325024,
   (f_srchssnsrchcount_i = NULL) => 0.0071507232, 0.0071507232),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => -0.0805972076,
   (f_mos_inq_banko_cm_lseen_d > 27.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 24.9) => -0.0496189373,
      (c_rnt750_p > 24.9) => 
         map(
         (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 0.1198655425,
         (f_historical_count_d > 1.5) => -0.0147088099,
         (f_historical_count_d = NULL) => 0.0516171209, 0.0516171209),
      (c_rnt750_p = NULL) => -0.0049090062, -0.0049090062),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0315597813, -0.0315597813),
(r_D33_eviction_count_i = NULL) => 0.0214948569, 0.0057742590);

// Tree: 110 
wFDN_FLA_S__lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 105.5) => -0.0084797917,
(f_prevaddrageoldest_d > 105.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 792966) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 85) => 0.1092641471,
      (f_prevaddrlenofres_d > 85) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 46.35) => 0.0105396191,
         (c_hval_750k_p > 46.35) => 
            map(
            (NULL < c_new_homes and c_new_homes <= 57.5) => -0.0288494956,
            (c_new_homes > 57.5) => 0.1970360964,
            (c_new_homes = NULL) => 0.0973208351, 0.0973208351),
         (c_hval_750k_p = NULL) => 0.0220868713, 0.0152194061),
      (f_prevaddrlenofres_d = NULL) => 0.0167176155, 0.0167176155),
   (f_curraddrmedianvalue_d > 792966) => 0.1790589131,
   (f_curraddrmedianvalue_d = NULL) => 0.0202946884, 0.0202946884),
(f_prevaddrageoldest_d = NULL) => -0.0304103785, 0.0014976893);

// Tree: 111 
wFDN_FLA_S__lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2197279311,
   (r_C12_source_profile_d > 57.95) => -0.0214298804,
   (r_C12_source_profile_d = NULL) => 0.0917287850, 0.0917287850),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 1.5) => -0.0821511326,
   (nf_vf_hi_risk_hit_type > 1.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
         map(
         (NULL < c_totsales and c_totsales <= 4027) => 0.0052931033,
         (c_totsales > 4027) => 0.1419298844,
         (c_totsales = NULL) => 0.0742747792, 0.0742747792),
      (r_D33_Eviction_Recency_d > 30) => 0.0032236591,
      (r_D33_Eviction_Recency_d = NULL) => 0.0038151775, 0.0038151775),
   (nf_vf_hi_risk_hit_type = NULL) => 0.0032697323, 0.0032697323),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0311701518, 0.0038939285);

// Tree: 112 
wFDN_FLA_S__lgt_112 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 137.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.4060666141) => -0.0521918362,
      (f_add_input_nhood_MFD_pct_i > 0.4060666141) => 0.0418207945,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0623889780, -0.0140690842),
   (c_serv_empl > 137.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 14.75) => -0.0430484528,
         (C_INC_50K_P > 14.75) => 0.1291318877,
         (C_INC_50K_P = NULL) => 0.0321900153, 0.0321900153),
      (r_L79_adls_per_addr_curr_i > 1.5) => 0.1637882764,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0884988866, 0.0884988866),
   (c_serv_empl = NULL) => 0.0678296507, 0.0271935721),
(f_corrssnaddrcount_d > 1.5) => -0.0006969700,
(f_corrssnaddrcount_d = NULL) => 0.0243635912, 0.0009618032);

// Tree: 113 
wFDN_FLA_S__lgt_113 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 17532) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 19.5) => -0.0480609542,
         (k_comb_age_d > 19.5) => 
            map(
            (NULL < c_bigapt_p and c_bigapt_p <= 3.5) => 0.1869862180,
            (c_bigapt_p > 3.5) => 0.0301631098,
            (c_bigapt_p = NULL) => 0.0956000902, 0.0956000902),
         (k_comb_age_d = NULL) => 0.0538211130, 0.0538211130),
      (r_C10_M_Hdr_FS_d > 10.5) => -0.0058565480,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0046373671, -0.0046373671),
   (f_addrchangeincomediff_d > 17532) => 0.0589274084,
   (f_addrchangeincomediff_d = NULL) => 0.0031496938, -0.0016407914),
(r_L77_Add_PO_Box_i > 0.5) => -0.0978838151,
(r_L77_Add_PO_Box_i = NULL) => -0.0037651940, -0.0037651940);

// Tree: 114 
wFDN_FLA_S__lgt_114 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 22.65) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => -0.0071861951,
   (f_srchfraudsrchcount_i > 6.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 8.15) => -0.0265286061,
      (c_femdiv_p > 8.15) => -0.1370239481,
      (c_femdiv_p = NULL) => -0.0390375127, -0.0390375127),
   (f_srchfraudsrchcount_i = NULL) => 0.0006131901, -0.0084462787),
(c_hval_150k_p > 22.65) => 
   map(
   (NULL < c_families and c_families <= 761) => 0.0164663031,
   (c_families > 761) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 123.5) => 0.0580743305,
      (r_A50_pb_average_dollars_d > 123.5) => 0.3070681149,
      (r_A50_pb_average_dollars_d = NULL) => 0.1792064418, 0.1792064418),
   (c_families = NULL) => 0.0356426889, 0.0356426889),
(c_hval_150k_p = NULL) => 0.0151729383, -0.0046508362);

// Tree: 115 
wFDN_FLA_S__lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13229074905) => -0.0073881761,
   (f_add_curr_nhood_BUS_pct_i > 0.13229074905) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0039191527,
      (c_easiqlife > 132.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.01879119585) => 
            map(
            (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 0.5) => 0.0680792100,
            (f_bus_addr_match_count_d > 0.5) => 0.3385017380,
            (f_bus_addr_match_count_d = NULL) => 0.1401076404, 0.1401076404),
         (f_add_input_nhood_VAC_pct_i > 0.01879119585) => 0.0303854207,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0701156322, 0.0701156322),
      (c_easiqlife = NULL) => 0.0264870724, 0.0264870724),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0076150811, -0.0034392562),
(c_pop_0_5_p > 21.15) => 0.1494532438,
(c_pop_0_5_p = NULL) => 0.0084344636, -0.0024971681);

// Tree: 116 
wFDN_FLA_S__lgt_116 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.45) => -0.0907033547,
(C_OWNOCC_P > 1.45) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -110409) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 62.1) => 0.1056838467,
      (c_civ_emp > 62.1) => -0.0356247383,
      (c_civ_emp = NULL) => 0.0437523064, 0.0437523064),
   (f_addrchangevaluediff_d > -110409) => -0.0027570697,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 58305) => 
         map(
         (NULL < f_prevaddrdwelltype_sfd_n and f_prevaddrdwelltype_sfd_n <= 0.5) => 0.0150714303,
         (f_prevaddrdwelltype_sfd_n > 0.5) => 0.2018836562,
         (f_prevaddrdwelltype_sfd_n = NULL) => 0.0595505317, 0.0595505317),
      (f_curraddrmedianvalue_d > 58305) => -0.0087278331,
      (f_curraddrmedianvalue_d = NULL) => 0.0077823069, 0.0007426031), -0.0014007515),
(C_OWNOCC_P = NULL) => 0.0111762673, -0.0022090813);

// Tree: 117 
wFDN_FLA_S__lgt_117 := map(
(NULL < c_young and c_young <= 29.65) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 0.1159756298,
      (r_C21_M_Bureau_ADL_FS_d > 6.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 16.5) => 0.0169455815,
         (f_addrs_per_ssn_i > 16.5) => 0.0884542776,
         (f_addrs_per_ssn_i = NULL) => 0.0250862868, 0.0250862868),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0297701548, 0.0297701548),
   (r_Ever_Asset_Owner_d > 0.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 24.85) => -0.0072132415,
      (c_hh3_p > 24.85) => 0.0552450366,
      (c_hh3_p = NULL) => -0.0003922507, -0.0003922507),
   (r_Ever_Asset_Owner_d = NULL) => -0.0000631783, 0.0045788496),
(c_young > 29.65) => -0.0233482947,
(c_young = NULL) => 0.0019639205, -0.0010106367);

// Tree: 118 
wFDN_FLA_S__lgt_118 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 27.65) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => 
         map(
         (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0090232195,
         (f_srchunvrfdaddrcount_i > 0.5) => 0.0396845253,
         (f_srchunvrfdaddrcount_i = NULL) => -0.0078899145, -0.0078899145),
      (k_comb_age_d > 84.5) => 0.0837777040,
      (k_comb_age_d = NULL) => -0.0072974814, -0.0072974814),
   (C_INC_25K_P > 27.65) => 0.0963344080,
   (C_INC_25K_P = NULL) => -0.0072167399, -0.0066048921),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 3.5) => 0.0093771693,
   (c_hval_175k_p > 3.5) => 0.1399467721,
   (c_hval_175k_p = NULL) => 0.0764588001, 0.0764588001),
(f_inq_Communications_count_i = NULL) => -0.0155309310, -0.0059697359);

// Tree: 119 
wFDN_FLA_S__lgt_119 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0075152852,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 23.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 39.5) => 0.0890927494,
      (r_A50_pb_total_dollars_d > 39.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 0.95) => 
            map(
            (NULL < c_pop_18_24_p and c_pop_18_24_p <= 6.95) => -0.0733778465,
            (c_pop_18_24_p > 6.95) => 0.0402026858,
            (c_pop_18_24_p = NULL) => -0.0122582776, -0.0122582776),
         (c_hh7p_p > 0.95) => -0.0828640809,
         (c_hh7p_p = NULL) => -0.0382604147, -0.0382604147),
      (r_A50_pb_total_dollars_d = NULL) => -0.0170348874, -0.0170348874),
   (f_rel_incomeover25_count_d > 23.5) => -0.1669887404,
   (f_rel_incomeover25_count_d = NULL) => -0.0350045640, -0.0350045640),
(f_srchssnsrchcount_i = NULL) => -0.0290660843, 0.0055228612);

// Tree: 120 
wFDN_FLA_S__lgt_120 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0048838498,
      (f_util_adl_count_n > 4.5) => 0.0295246172,
      (f_util_adl_count_n = NULL) => -0.0006451672, -0.0006451672),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 122.5) => 0.0437744829,
      (c_asian_lang > 122.5) => -0.0961869265,
      (c_asian_lang = NULL) => -0.0605158280, -0.0605158280),
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0031092757, -0.0031092757),
(f_rel_felony_count_i > 4.5) => 0.0723600911,
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 1.75) => -0.0404518329,
   (c_hval_200k_p > 1.75) => 0.0880620652,
   (c_hval_200k_p = NULL) => 0.0213336951, 0.0213336951), -0.0025244232);

// Tree: 121 
wFDN_FLA_S__lgt_121 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 178.5) => -0.0023120302,
   (c_lar_fam > 178.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.03674912395) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','5: Vuln Vic/Friendly']) => -0.0981391547,
         (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','6: Other']) => 0.0864057681,
         (nf_seg_FraudPoint_3_0 = '') => 0.0224301949, 0.0224301949),
      (f_add_curr_nhood_VAC_pct_i > 0.03674912395) => 0.1562243616,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0597381837, 0.0597381837),
   (c_lar_fam = NULL) => -0.0099980811, -0.0014418557),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0744668636,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 100) => 0.0742711941,
   (c_robbery > 100) => -0.0314946382,
   (c_robbery = NULL) => 0.0189624561, 0.0189624561), -0.0008918417);

// Tree: 122 
wFDN_FLA_S__lgt_122 := map(
(NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 14.4) => 0.0271640300,
      (c_hh3_p > 14.4) => -0.0778894780,
      (c_hh3_p = NULL) => -0.0367198600, -0.0367198600),
   (nf_vf_hi_risk_index > 3.5) => 0.0011357910,
   (nf_vf_hi_risk_index = NULL) => 0.0004499004, 0.0004499004),
(r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 144.5) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 13.25) => 0.1818665369,
      (c_hval_400k_p > 13.25) => 0.0133499960,
      (c_hval_400k_p = NULL) => 0.1084414727, 0.1084414727),
   (c_rest_indx > 144.5) => -0.0564434470,
   (c_rest_indx = NULL) => 0.0584017707, 0.0584017707),
(r_C14_Addrs_Per_ADL_c6_i = NULL) => 0.0010990955, 0.0013788859);

// Tree: 123 
wFDN_FLA_S__lgt_123 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 24.15) => 
   map(
   (NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 1.5) => 0.0027647952,
   (f_vf_AltLexID_addr_hi_risk_ct_i > 1.5) => -0.0535767631,
   (f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 0.0072496983, 0.0020201208),
(c_hval_150k_p > 24.15) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 130) => 0.1743194860,
   (f_mos_liens_unrel_CJ_lseen_d > 130) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => 
         map(
         (NULL < c_families and c_families <= 468.5) => 0.0203572948,
         (c_families > 468.5) => 0.2222168797,
         (c_families = NULL) => 0.0957058034, 0.0957058034),
      (r_F03_address_match_d > 3) => -0.0091387634,
      (r_F03_address_match_d = NULL) => 0.0222856441, 0.0222856441),
   (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0322904517, 0.0322904517),
(c_hval_150k_p = NULL) => -0.0133299748, 0.0035376385);

// Tree: 124 
wFDN_FLA_S__lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 187) => -0.0859485186,
   (f_mos_liens_unrel_FT_fseen_d > 187) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 452) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 1.55) => -0.0820325753,
         (c_sfdu_p > 1.55) => 
            map(
            (NULL < c_ab_av_edu and c_ab_av_edu <= 101.5) => -0.0031241271,
            (c_ab_av_edu > 101.5) => 0.0285270918,
            (c_ab_av_edu = NULL) => 0.0104208211, 0.0104208211),
         (c_sfdu_p = NULL) => 0.0091970618, 0.0091970618),
      (r_C13_Curr_Addr_LRes_d > 452) => 0.1502169557,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0103764592, 0.0103764592),
   (f_mos_liens_unrel_FT_fseen_d = NULL) => 0.0066547083, 0.0092664946),
(c_high_ed > 42.55) => -0.0271649851,
(c_high_ed = NULL) => -0.0339144957, -0.0020550416);

// Tree: 125 
wFDN_FLA_S__lgt_125 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 81.5) => -0.0123989731,
(f_prevaddrageoldest_d > 81.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 193.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 886.5) => 0.0064844310,
      (f_liens_unrel_SC_total_amt_i > 886.5) => 0.1019141644,
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0091240548, 0.0091240548),
   (c_sub_bus > 193.5) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2) => 0.0198592757,
      (r_A44_curr_add_naprop_d > 2) => 0.2265161185,
      (r_A44_curr_add_naprop_d = NULL) => 0.1049532698, 0.1049532698),
   (c_sub_bus = NULL) => 0.0014202364, 0.0116145937),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.260400711) => -0.0511140414,
   (f_add_input_mobility_index_i > 0.260400711) => 0.0741506968,
   (f_add_input_mobility_index_i = NULL) => 0.0132110945, 0.0132110945), -0.0017816777);

// Tree: 126 
wFDN_FLA_S__lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.55) => -0.0728170024,
      (C_OWNOCC_P > 1.55) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 10.5) => 0.0569914411,
         (c_many_cars > 10.5) => 0.0015181878,
         (c_many_cars = NULL) => 0.0033736676, 0.0033736676),
      (C_OWNOCC_P = NULL) => -0.0261462699, 0.0017694529),
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 18.15) => 0.0868190164,
      (c_hh3_p > 18.15) => -0.0352446707,
      (c_hh3_p = NULL) => 0.0385963252, 0.0385963252),
   (f_inq_PrepaidCards_count24_i = NULL) => 0.0000192796, 0.0022377645),
(r_L72_Add_Vacant_i > 0.5) => 0.1130608069,
(r_L72_Add_Vacant_i = NULL) => 0.0029980834, 0.0029980834);

// Tree: 127 
wFDN_FLA_S__lgt_127 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < c_larceny and c_larceny <= 148.5) => 0.0294010601,
         (c_larceny > 148.5) => 0.1256383242,
         (c_larceny = NULL) => 0.0504355104, 0.0504355104),
      (r_I60_inq_comm_recency_d > 549) => 0.0025628713,
      (r_I60_inq_comm_recency_d = NULL) => 0.0067135886, 0.0067135886),
   (f_historical_count_d > 0.5) => -0.0161067069,
   (f_historical_count_d = NULL) => -0.0048279200, -0.0048279200),
(f_assocsuspicousidcount_i > 16.5) => 0.0934961280,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0848820999,
   (r_S66_adlperssn_count_i > 1.5) => 0.0489517603,
   (r_S66_adlperssn_count_i = NULL) => -0.0097473012, -0.0097473012), -0.0043838044);

// Tree: 128 
wFDN_FLA_S__lgt_128 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => -0.0005841575,
(f_srchcomponentrisktype_i > 2.5) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 169) => 
      map(
      (NULL < c_rich_asian and c_rich_asian <= 184.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 16.85) => 
            map(
            (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 4.5) => -0.0574780928,
            (k_inq_per_ssn_i > 4.5) => 0.0669093583,
            (k_inq_per_ssn_i = NULL) => -0.0303531034, -0.0303531034),
         (c_hval_150k_p > 16.85) => 0.1063214320,
         (c_hval_150k_p = NULL) => -0.0100513157, -0.0100513157),
      (c_rich_asian > 184.5) => 0.1540529911,
      (c_rich_asian = NULL) => 0.0137642753, 0.0137642753),
   (c_for_sale > 169) => 0.1758787758,
   (c_for_sale = NULL) => 0.0337465796, 0.0337465796),
(f_srchcomponentrisktype_i = NULL) => 0.0215656499, 0.0009818112);

// Tree: 129 
wFDN_FLA_S__lgt_129 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 156.5) => -0.0157713920,
(r_A50_pb_average_dollars_d > 156.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32869218605) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => 0.0127048396,
      (r_L79_adls_per_addr_curr_i > 5.5) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 178.5) => 
            map(
            (NULL < c_mort_indx and c_mort_indx <= 67.5) => 0.1904758632,
            (c_mort_indx > 67.5) => 0.0623229818,
            (c_mort_indx = NULL) => 0.0950986548, 0.0950986548),
         (c_asian_lang > 178.5) => -0.0222899363,
         (c_asian_lang = NULL) => 0.0611626802, 0.0611626802),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0196996676, 0.0196996676),
   (f_add_input_mobility_index_i > 0.32869218605) => -0.0185348130,
   (f_add_input_mobility_index_i = NULL) => 0.0084008794, 0.0084008794),
(r_A50_pb_average_dollars_d = NULL) => -0.0227538652, -0.0054193908);

// Tree: 130 
wFDN_FLA_S__lgt_130 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 48.45) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 
      map(
      (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0177570042,
      (r_L70_Add_Standardized_i > 0.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 138) => 0.0034448673,
         (f_curraddrcrimeindex_i > 138) => 0.1297363238,
         (f_curraddrcrimeindex_i = NULL) => 0.0355021129, 0.0355021129),
      (r_L70_Add_Standardized_i = NULL) => -0.0136080704, -0.0136080704),
   (f_inq_Other_count_i > 0.5) => 0.0140197566,
   (f_inq_Other_count_i = NULL) => 0.0064564227, -0.0070854776),
(c_rnt2001_p > 48.45) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 143.5) => 0.0385958781,
   (c_lar_fam > 143.5) => 0.2499321572,
   (c_lar_fam = NULL) => 0.0755975162, 0.0755975162),
(c_rnt2001_p = NULL) => 0.0296464676, -0.0042837669);

// Tree: 131 
wFDN_FLA_S__lgt_131 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 813323.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 41.45) => 0.0006562017,
   (c_hval_60k_p > 41.45) => -0.0953725971,
   (c_hval_60k_p = NULL) => -0.0056294279, -0.0000706684),
(f_prevaddrmedianvalue_d > 813323.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.65) => 
      map(
      (NULL < c_rich_asian and c_rich_asian <= 178.5) => 0.0559013942,
      (c_rich_asian > 178.5) => 0.2857106263,
      (c_rich_asian = NULL) => 0.1521006076, 0.1521006076),
   (c_pop_0_5_p > 7.65) => -0.0507576414,
   (c_pop_0_5_p = NULL) => 0.0862513331, 0.0862513331),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 114.5) => -0.0435099223,
   (c_easiqlife > 114.5) => 0.0555850751,
   (c_easiqlife = NULL) => -0.0000472042, -0.0000472042), 0.0012293191);

// Tree: 132 
wFDN_FLA_S__lgt_132 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0003639961,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2099233630,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 82.5) => -0.0191810213,
      (f_addrchangecrimediff_i > 82.5) => 0.0972479425,
      (f_addrchangecrimediff_i = NULL) => -0.0095442329, -0.0148014146),
   (f_crim_rel_under25miles_cnt_i > 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.0979876573,
      (r_C10_M_Hdr_FS_d > 13.5) => 0.0151695306,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0175975319, 0.0175975319),
   (f_crim_rel_under25miles_cnt_i = NULL) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 10.95) => -0.0492156266,
      (c_hh4_p > 10.95) => 0.0510426329,
      (c_hh4_p = NULL) => 0.0069289987, 0.0069289987), -0.0020426954), -0.0003859369);

// Tree: 133 
wFDN_FLA_S__lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 61.6) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 4.25) => 0.2140220756,
      (c_hval_200k_p > 4.25) => 0.0315280299,
      (c_hval_200k_p = NULL) => 0.1236609462, 0.1236609462),
   (r_C12_source_profile_d > 61.6) => -0.0158114011,
   (r_C12_source_profile_d = NULL) => 0.0510589024, 0.0510589024),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 12.5) => -0.0125205608,
      (k_inq_per_addr_i > 12.5) => 0.0897941573,
      (k_inq_per_addr_i = NULL) => -0.0114603047, -0.0114603047),
   (f_bus_name_nover_i > 0.5) => 0.0176396668,
   (f_bus_name_nover_i = NULL) => 0.0003489603, 0.0003489603),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0013776308, 0.0012344158);

// Tree: 134 
wFDN_FLA_S__lgt_134 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 44.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 86.5) => 
      map(
      (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 4.5) => -0.0098359301,
      (f_dl_addrs_per_adl_i > 4.5) => 0.0855378299,
      (f_dl_addrs_per_adl_i = NULL) => -0.0080434399, -0.0080434399),
   (r_C13_Curr_Addr_LRes_d > 86.5) => 0.0174869956,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0026954875, 0.0026954875),
(f_rel_count_i > 44.5) => 
   map(
   (NULL < r_C20_email_count_i and r_C20_email_count_i <= 0.5) => 0.0360598590,
   (r_C20_email_count_i > 0.5) => -0.1267637411,
   (r_C20_email_count_i = NULL) => -0.0734760175, -0.0734760175),
(f_rel_count_i = NULL) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 92.85) => 0.0518033735,
   (c_occunit_p > 92.85) => -0.0527876739,
   (c_occunit_p = NULL) => -0.0075830686, -0.0075830686), 0.0016058318);

// Tree: 135 
wFDN_FLA_S__lgt_135 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 19.85) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 5.5) => -0.0063705723,
   (f_srchcomponentrisktype_i > 5.5) => 0.0891174667,
   (f_srchcomponentrisktype_i = NULL) => 0.0001375565, -0.0057552453),
(c_hval_150k_p > 19.85) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 2.5) => 0.0131756062,
   (k_inq_per_addr_i > 2.5) => 
      map(
      (NULL < f_vardobcount_i and f_vardobcount_i <= 1.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 18.2) => 0.1703454364,
         (C_RENTOCC_P > 18.2) => -0.0158429965,
         (C_RENTOCC_P = NULL) => 0.0510274970, 0.0510274970),
      (f_vardobcount_i > 1.5) => 0.1986299453,
      (f_vardobcount_i = NULL) => 0.0988225755, 0.0988225755),
   (k_inq_per_addr_i = NULL) => 0.0284129675, 0.0284129675),
(c_hval_150k_p = NULL) => 0.0107558315, -0.0021818733);

// Tree: 136 
wFDN_FLA_S__lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.25) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 23.45) => 0.0084078489,
      (c_hh3_p > 23.45) => 
         map(
         (NULL < c_med_age and c_med_age <= 42.05) => 0.0446778077,
         (c_med_age > 42.05) => 0.2487669930,
         (c_med_age = NULL) => 0.0804105943, 0.0804105943),
      (c_hh3_p = NULL) => 0.0179333791, 0.0179333791),
   (c_hh7p_p > 7.25) => 0.1231200380,
   (c_hh7p_p = NULL) => 0.0768679014, 0.0236706181),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -34939.5) => -0.0858180650,
   (f_addrchangeincomediff_d > -34939.5) => -0.0052687828,
   (f_addrchangeincomediff_d = NULL) => -0.0042682225, -0.0058444970),
(f_hh_members_ct_d = NULL) => -0.0062765482, -0.0002449656);

// Tree: 137 
wFDN_FLA_S__lgt_137 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.65) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 0.0009561572,
   (f_inq_HighRiskCredit_count24_i > 2.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 15.25) => -0.1145860554,
      (C_INC_75K_P > 15.25) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 100.5) => -0.0639542344,
         (c_blue_empl > 100.5) => 0.0568621359,
         (c_blue_empl = NULL) => 0.0009742911, 0.0009742911),
      (C_INC_75K_P = NULL) => -0.0329160028, -0.0329160028),
   (f_inq_HighRiskCredit_count24_i = NULL) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 0.1) => -0.0602842228,
      (c_hval_80k_p > 0.1) => 0.0478435015,
      (c_hval_80k_p = NULL) => -0.0115780407, -0.0115780407), 0.0002687372),
(c_hval_80k_p > 40.65) => -0.0893680965,
(c_hval_80k_p = NULL) => 0.0175819493, -0.0001216697);

// Tree: 138 
wFDN_FLA_S__lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 75.45) => 0.0024381604,
   (c_low_ed > 75.45) => -0.0473506341,
   (c_low_ed = NULL) => -0.0222942718, 0.0002420306),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 64.1) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0616133866) => 0.1387894056,
         (f_add_input_nhood_BUS_pct_i > 0.0616133866) => -0.0079454056,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0726926438, 0.0726926438),
      (c_fammar_p > 64.1) => -0.0923162070,
      (c_fammar_p = NULL) => -0.0067560622, -0.0067560622),
   (f_vardobcountnew_i > 0.5) => 0.1539252489,
   (f_vardobcountnew_i = NULL) => 0.0400443197, 0.0400443197),
(f_curraddrcrimeindex_i = NULL) => -0.0274379381, 0.0009759266);

// Tree: 139 
wFDN_FLA_S__lgt_139 := map(
(NULL < c_old_homes and c_old_homes <= 118.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 3.5) => 0.0847920677,
   (r_C21_M_Bureau_ADL_FS_d > 3.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 8.5) => 0.0910108504,
         (r_D32_Mos_Since_Crim_LS_d > 8.5) => 0.0020722879,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0034830085, 0.0034830085),
      (f_nae_nothing_found_i > 0.5) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0366128037) => -0.0081227873,
         (f_add_input_nhood_BUS_pct_i > 0.0366128037) => 0.2296992763,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.1062147433, 0.1062147433),
      (f_nae_nothing_found_i = NULL) => 0.0048034678, 0.0048034678),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0077405390, 0.0053235961),
(c_old_homes > 118.5) => -0.0169115327,
(c_old_homes = NULL) => -0.0306546100, -0.0019544204);

// Tree: 140 
wFDN_FLA_S__lgt_140 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 198.5) => -0.0009759926,
   (c_work_home > 198.5) => 0.1628681115,
   (c_work_home = NULL) => -0.0327934132, -0.0008042632),
(f_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.1046553334,
      (f_adl_util_conv_n > 0.5) => -0.1350497681,
      (f_adl_util_conv_n = NULL) => 0.0005211500, 0.0005211500),
   (r_C23_inp_addr_occ_index_d > 2) => 0.1519780390,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0493239253, 0.0493239253),
(f_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.75) => -0.0755894619,
   (c_pop_45_54_p > 12.75) => 0.0400852104,
   (c_pop_45_54_p = NULL) => -0.0145389404, -0.0145389404), -0.0002185437);

// Tree: 141 
wFDN_FLA_S__lgt_141 := map(
(NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 1.5) => 
   map(
   (NULL < c_rich_blk and c_rich_blk <= 166.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 0.0526999428,
      (f_corrssnnamecount_d > 1.5) => 
         map(
         (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => -0.0574626896,
         (nf_vf_hi_risk_index > 4.5) => -0.0101033507,
         (nf_vf_hi_risk_index = NULL) => -0.0112394750, -0.0112394750),
      (f_corrssnnamecount_d = NULL) => -0.0077243290, -0.0077243290),
   (c_rich_blk > 166.5) => 0.0169550723,
   (c_rich_blk = NULL) => -0.0304141290, -0.0016489003),
(f_divsrchaddrsuspidcount_i > 1.5) => -0.0667322583,
(f_divsrchaddrsuspidcount_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0562575063,
   (c_pop_35_44_p > 16.05) => 0.0541690290,
   (c_pop_35_44_p = NULL) => -0.0086598618, -0.0086598618), -0.0022920769);

// Tree: 142 
wFDN_FLA_S__lgt_142 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 17.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0101613342,
      (f_corrrisktype_i > 7.5) => 0.1364157366,
      (f_corrrisktype_i = NULL) => 0.0760604722, 0.0760604722),
   (r_C13_max_lres_d > 17.5) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 25.5) => 0.0036483629,
      (f_rel_under500miles_cnt_d > 25.5) => -0.0484490236,
      (f_rel_under500miles_cnt_d = NULL) => -0.0255858309, 0.0018388825),
   (r_C13_max_lres_d = NULL) => 0.0027831619, 0.0027831619),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0518549887,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 2.05) => 0.0640844826,
   (c_bigapt_p > 2.05) => -0.0450787043,
   (c_bigapt_p = NULL) => 0.0142907482, 0.0142907482), 0.0005547433);

// Tree: 143 
wFDN_FLA_S__lgt_143 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 0.0028223895,
   (f_inq_Auto_count24_i > 1.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 129.5) => 
         map(
         (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 0.0847290157,
         (r_I60_inq_banking_recency_d > 9) => -0.0470585163,
         (r_I60_inq_banking_recency_d = NULL) => -0.0283863609, -0.0283863609),
      (c_bel_edu > 129.5) => -0.1002339094,
      (c_bel_edu = NULL) => -0.0470579882, -0.0470579882),
   (f_inq_Auto_count24_i = NULL) => 0.0001693056, 0.0001693056),
(f_inq_QuizProvider_count_i > 6.5) => 0.1040454637,
(f_inq_QuizProvider_count_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1281) => 0.0487683420,
   (c_popover18 > 1281) => -0.0612747976,
   (c_popover18 = NULL) => -0.0076403262, -0.0076403262), 0.0008790980);

// Tree: 144 
wFDN_FLA_S__lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 53) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.65) => -0.0065935814,
   (c_unemp > 8.65) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 51.5) => -0.0769560676,
      (f_fp_prevaddrburglaryindex_i > 51.5) => 
         map(
         (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 0.5) => 0.0261363823,
         (f_addrs_per_ssn_c6_i > 0.5) => 0.1299728569,
         (f_addrs_per_ssn_c6_i = NULL) => 0.0418691815, 0.0418691815),
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0251034272, 0.0251034272),
   (c_unemp = NULL) => -0.0046651966, -0.0046651966),
(c_rnt2001_p > 53) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 629990) => 0.0292585382,
   (f_prevaddrmedianvalue_d > 629990) => 0.1927289437,
   (f_prevaddrmedianvalue_d = NULL) => 0.0824665526, 0.0824665526),
(c_rnt2001_p = NULL) => 0.0125546297, -0.0025239496);

// Tree: 145 
wFDN_FLA_S__lgt_145 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0064652812,
(k_comb_age_d > 56.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 229.85) => 0.0075953791,
      (c_cpiall > 229.85) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 377.5) => 0.2154650201,
         (f_M_Bureau_ADL_FS_all_d > 377.5) => -0.0382517864,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1077035808, 0.1077035808),
      (c_cpiall = NULL) => 0.0052987336, 0.0154292198),
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 1.4) => 0.1418050337,
      (c_rnt2000_p > 1.4) => -0.0270181127,
      (c_rnt2000_p = NULL) => 0.0792076873, 0.0792076873),
   (k_inq_per_addr_i = NULL) => 0.0199273859, 0.0199273859),
(k_comb_age_d = NULL) => -0.0131491663, -0.0012473697);

// Tree: 146 
wFDN_FLA_S__lgt_146 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 190.5) => -0.0046235358,
      (f_fp_prevaddrcrimeindex_i > 190.5) => 
         map(
         (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 1.5) => 0.1811510911,
         (f_addrchangeecontrajindex_d > 1.5) => 0.0200175255,
         (f_addrchangeecontrajindex_d = NULL) => 0.0385493690, 0.0743459216),
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0031679655, -0.0031679655),
   (f_fp_prevaddrcrimeindex_i > 197.5) => -0.1109711933,
   (f_fp_prevaddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0521344272,
      (c_high_hval > 3.7) => 0.0798400242,
      (c_high_hval = NULL) => 0.0144581859, 0.0144581859), -0.0034678496),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1004887512,
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0027220829, -0.0027220829);

// Tree: 147 
wFDN_FLA_S__lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 17.05) => 
      map(
      (NULL < c_construction and c_construction <= 22.75) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 16.35) => -0.0016488957,
         (c_hh2_p > 16.35) => 0.1784044122,
         (c_hh2_p = NULL) => 0.0212444802, 0.0212444802),
      (c_construction > 22.75) => 0.1846565243,
      (c_construction = NULL) => 0.0420691035, 0.0420691035),
   (c_hh2_p > 17.05) => -0.0013980837,
   (c_hh2_p = NULL) => -0.0360286647, 0.0002016640),
(f_prevaddrcartheftindex_i > 194.5) => -0.0719351067,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 38.6) => 0.0970427009,
   (c_low_ed > 38.6) => -0.0252432251,
   (c_low_ed = NULL) => 0.0244665009, 0.0244665009), -0.0006377495);

// Tree: 148 
wFDN_FLA_S__lgt_148 := map(
(NULL < c_hh2_p and c_hh2_p <= 17.05) => 
   map(
   (NULL < c_pop00 and c_pop00 <= 955.5) => 
      map(
      (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 0.5) => 0.1869786034,
      (f_hh_workers_paw_d > 0.5) => 0.0222919990,
      (f_hh_workers_paw_d = NULL) => 0.0956113777, 0.0956113777),
   (c_pop00 > 955.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 70.85) => -0.0160663766,
      (C_RENTOCC_P > 70.85) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 32.1) => 0.1835188460,
         (c_hh1_p > 32.1) => 0.0055502106,
         (c_hh1_p = NULL) => 0.0927897378, 0.0927897378),
      (C_RENTOCC_P = NULL) => 0.0032773929, 0.0032773929),
   (c_pop00 = NULL) => 0.0224073621, 0.0224073621),
(c_hh2_p > 17.05) => -0.0052490144,
(c_hh2_p = NULL) => -0.0030459907, -0.0036217171);

// Tree: 149 
wFDN_FLA_S__lgt_149 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 68.5) => -0.0966189222,
   (f_mos_inq_banko_cm_fseen_d > 68.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 34.55) => -0.0897619399,
      (C_OWNOCC_P > 34.55) => 0.0368482806,
      (C_OWNOCC_P = NULL) => -0.0087554007, -0.0087554007),
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0355947401, -0.0355947401),
(nf_vf_hi_risk_index > 4.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 183.5) => 0.0022309003,
   (f_curraddrcartheftindex_i > 183.5) => 0.0470996974,
   (f_curraddrcartheftindex_i = NULL) => 0.0044269422, 0.0044269422),
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 91.5) => 0.0595913320,
   (c_many_cars > 91.5) => -0.0623489768,
   (c_many_cars = NULL) => 0.0007986831, 0.0007986831), 0.0034128316);

// Tree: 150 
wFDN_FLA_S__lgt_150 := map(
(NULL < c_low_ed and c_low_ed <= 77.75) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0145442870,
   (f_corrrisktype_i > 5.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 22.85) => 0.0071516214,
      (C_INC_50K_P > 22.85) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.40522872735) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 86.5) => -0.0316792744,
            (r_C13_max_lres_d > 86.5) => 0.1289507054,
            (r_C13_max_lres_d = NULL) => 0.0640809058, 0.0640809058),
         (f_add_curr_mobility_index_i > 0.40522872735) => 0.1844036380,
         (f_add_curr_mobility_index_i = NULL) => 0.0873992648, 0.0873992648),
      (C_INC_50K_P = NULL) => 0.0107928757, 0.0107928757),
   (f_corrrisktype_i = NULL) => 0.0057999196, -0.0023146602),
(c_low_ed > 77.75) => -0.0510185163,
(c_low_ed = NULL) => 0.0065504055, -0.0034746619);

// Tree: 151 
wFDN_FLA_S__lgt_151 := map(
(NULL < c_pop_85p_p and c_pop_85p_p <= 1.55) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 16.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 56.35) => -0.0040133451,
         (r_C12_source_profile_d > 56.35) => 
            map(
            (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 6.5) => 0.1368210638,
            (f_assocsuspicousidcount_i > 6.5) => -0.0644708954,
            (f_assocsuspicousidcount_i = NULL) => 0.1026592430, 0.1026592430),
         (r_C12_source_profile_d = NULL) => 0.0414322625, 0.0414322625),
      (c_born_usa > 16.5) => 0.0017923211,
      (c_born_usa = NULL) => 0.0063777633, 0.0063777633),
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1241485144,
   (r_L71_Add_HiRisk_Comm_i = NULL) => 0.0073113933, 0.0073113933),
(c_pop_85p_p > 1.55) => -0.0153887391,
(c_pop_85p_p = NULL) => -0.0068873821, -0.0009710135);

// Tree: 152 
wFDN_FLA_S__lgt_152 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 20.45) => -0.0334897261,
(C_OWNOCC_P > 20.45) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 153.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 14.55) => 
            map(
            (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.82441192415) => 0.2727296136,
            (f_add_curr_nhood_SFD_pct_d > 0.82441192415) => 0.0463639567,
            (f_add_curr_nhood_SFD_pct_d = NULL) => 0.1627805803, 0.1627805803),
         (C_INC_50K_P > 14.55) => 0.0124791346,
         (C_INC_50K_P = NULL) => 0.1001549779, 0.1001549779),
      (c_asian_lang > 153.5) => -0.0116891932,
      (c_asian_lang = NULL) => 0.0478727914, 0.0478727914),
   (r_C10_M_Hdr_FS_d > 15.5) => 0.0014466929,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0158304346, 0.0029374346),
(C_OWNOCC_P = NULL) => 0.0303207634, 0.0007312611);

// Tree: 153 
wFDN_FLA_S__lgt_153 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00501882845) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.1693442508,
   (f_hh_members_ct_d > 1.5) => 0.0315932007,
   (f_hh_members_ct_d = NULL) => 0.0481545009, 0.0481545009),
(f_add_input_nhood_MFD_pct_i > 0.00501882845) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 18.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0079274599,
      (f_hh_criminals_i > 0.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 178.5) => 0.0329813757,
         (c_old_homes > 178.5) => -0.0442411171,
         (c_old_homes = NULL) => 0.0256487671, 0.0256487671),
      (f_hh_criminals_i = NULL) => 0.0022222757, 0.0022222757),
   (f_rel_incomeover25_count_d > 18.5) => -0.0329077733,
   (f_rel_incomeover25_count_d = NULL) => -0.0234511924, -0.0016812490),
(f_add_input_nhood_MFD_pct_i = NULL) => -0.0093453305, -0.0003793547);

// Tree: 154 
wFDN_FLA_S__lgt_154 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 16.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 8.5) => -0.0092081670,
   (f_util_adl_count_n > 8.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 1.95) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 53580.5) => 0.1051793104,
         (f_curraddrmedianincome_d > 53580.5) => -0.0428114382,
         (f_curraddrmedianincome_d = NULL) => 0.0100424006, 0.0100424006),
      (c_hh7p_p > 1.95) => 0.1201281192,
      (c_hh7p_p = NULL) => 0.0376413554, 0.0376413554),
   (f_util_adl_count_n = NULL) => -0.0180499388, -0.0076366870),
(c_hval_500k_p > 16.15) => 
   map(
   (NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 194) => 0.1330614080,
   (f_mos_liens_unrel_OT_fseen_d > 194) => 0.0191913630,
   (f_mos_liens_unrel_OT_fseen_d = NULL) => 0.0220649013, 0.0220649013),
(c_hval_500k_p = NULL) => 0.0197431840, -0.0014778368);

// Tree: 155 
wFDN_FLA_S__lgt_155 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 34701) => -0.0003132237,
(f_addrchangevaluediff_d > 34701) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 112.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 117.5) => 0.0376400458,
      (c_easiqlife > 117.5) => 0.1657017489,
      (c_easiqlife = NULL) => 0.0909990888, 0.0909990888),
   (c_lux_prod > 112.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 27) => 0.1073775674,
      (c_hh2_p > 27) => -0.0421255477,
      (c_hh2_p = NULL) => -0.0074499203, -0.0074499203),
   (c_lux_prod = NULL) => 0.0233957222, 0.0233957222),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 79.5) => -0.0561187354,
   (c_span_lang > 79.5) => 0.0046338171,
   (c_span_lang = NULL) => 0.0230759738, -0.0114986231), -0.0021007541);

// Tree: 156 
wFDN_FLA_S__lgt_156 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0008851563,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 125.5) => 
      map(
      (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 44) => 0.0572313024,
         (f_prevaddrcartheftindex_i > 44) => -0.0734127551,
         (f_prevaddrcartheftindex_i = NULL) => -0.0349242568, -0.0349242568),
      (r_I61_inq_collection_count12_i > 0.5) => 0.0531324722,
      (r_I61_inq_collection_count12_i = NULL) => -0.0117656064, -0.0117656064),
   (c_unempl > 125.5) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 1.5) => -0.0151301085,
      (r_C18_invalid_addrs_per_adl_i > 1.5) => -0.1374146485,
      (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0788981201, -0.0788981201),
   (c_unempl = NULL) => -0.0340974426, -0.0340974426),
(f_srchssnsrchcount_i = NULL) => 0.0074033963, -0.0004125844);

// Tree: 157 
wFDN_FLA_S__lgt_157 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21894) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 13.2) => 0.1825715393,
   (c_blue_col > 13.2) => -0.0252581573,
   (c_blue_col = NULL) => 0.0675229572, 0.0675229572),
(r_A46_Curr_AVM_AutoVal_d > 21894) => 0.0067816257,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0122013375,
   (f_util_adl_count_n > 4.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0116343443,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.0713698196,
      (nf_seg_FraudPoint_3_0 = '') => 0.0295629199, 0.0295629199),
   (f_util_adl_count_n = NULL) => 
      map(
      (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0663619852,
      (k_nap_lname_verd_d > 0.5) => -0.0702963168,
      (k_nap_lname_verd_d = NULL) => -0.0077577718, -0.0077577718), -0.0064714402), 0.0014880444);

// Tree: 158 
wFDN_FLA_S__lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0014013219,
      (f_assocsuspicousidcount_i > 13.5) => 0.0644961225,
      (f_assocsuspicousidcount_i = NULL) => -0.0008679553, -0.0008679553),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_C20_email_count_i and r_C20_email_count_i <= 0.5) => 0.0272587309,
      (r_C20_email_count_i > 0.5) => -0.1221526898,
      (r_C20_email_count_i = NULL) => -0.0603272744, -0.0603272744),
   (r_I60_inq_comm_count12_i = NULL) => -0.0015576834, -0.0015576834),
(r_D33_eviction_count_i > 3.5) => 0.0755963135,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 99) => 0.0525649946,
   (c_rental > 99) => -0.0381573310,
   (c_rental = NULL) => 0.0058826329, 0.0058826329), -0.0010369909);

// Tree: 159 
wFDN_FLA_S__lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 2091.5) => -0.0034778468,
   (c_popover18 > 2091.5) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 34.5) => 0.1210129927,
      (c_no_teens > 34.5) => 0.0138669612,
      (c_no_teens = NULL) => 0.0309043160, 0.0309043160),
   (c_popover18 = NULL) => 0.0196856730, 0.0017969125),
(f_rel_homeover500_count_d > 19.5) => 0.1195535336,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.14038461535) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.72711108105) => -0.1033074332,
      (f_add_curr_nhood_SFD_pct_d > 0.72711108105) => 0.0688432388,
      (f_add_curr_nhood_SFD_pct_d = NULL) => -0.0022722632, -0.0323071585),
   (f_add_input_nhood_BUS_pct_i > 0.14038461535) => 0.1045840413,
   (f_add_input_nhood_BUS_pct_i = NULL) => -0.0063971523, -0.0063971523), 0.0021310429);

// Tree: 160 
wFDN_FLA_S__lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => -0.0043736349,
(r_C12_source_profile_d > 81.3) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 14.65) => -0.0296033104,
   (C_RENTOCC_P > 14.65) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.1661681668,
      (f_corrssnaddrcount_d > 2.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 366.5) => 0.0390965346,
         (f_M_Bureau_ADL_FS_noTU_d > 366.5) => 0.2712198774,
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0712142298, 0.0712142298),
      (f_corrssnaddrcount_d = NULL) => 0.0802231422, 0.0802231422),
   (C_RENTOCC_P = NULL) => 0.0306868360, 0.0306868360),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 7.4) => -0.0510423834,
   (C_INC_25K_P > 7.4) => 0.0642122930,
   (C_INC_25K_P = NULL) => 0.0039891287, 0.0039891287), -0.0016319442);

// Tree: 161 
wFDN_FLA_S__lgt_161 := map(
(NULL < c_med_age and c_med_age <= 28.05) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 28.5) => -0.1087696157,
   (f_mos_inq_banko_cm_fseen_d > 28.5) => -0.0245276993,
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0300797647, -0.0300797647),
(c_med_age > 28.05) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 140.5) => -0.0100891079,
   (c_easiqlife > 140.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 1.25) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 0.0380143503,
         (r_L79_adls_per_addr_c6_i > 2.5) => 0.1267738424,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0570342414, 0.0570342414),
      (C_INC_200K_P > 1.25) => 0.0107493772,
      (C_INC_200K_P = NULL) => 0.0162814327, 0.0162814327),
   (c_easiqlife = NULL) => -0.0020999640, -0.0020999640),
(c_med_age = NULL) => -0.0307642046, -0.0045109362);

// Tree: 162 
wFDN_FLA_S__lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0014846165,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_rental and c_rental <= 123.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 11.5) => 0.0278298158,
      (f_rel_educationover12_count_d > 11.5) => 0.1648206335,
      (f_rel_educationover12_count_d = NULL) => 0.0920971130, 0.0920971130),
   (c_rental > 123.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 4.65) => 0.0470394989,
      (c_hval_150k_p > 4.65) => -0.0950872547,
      (c_hval_150k_p = NULL) => -0.0273549737, -0.0273549737),
   (c_rental = NULL) => 0.0393734334, 0.0393734334),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.45) => -0.0479360856,
   (c_pop_55_64_p > 9.45) => 0.0623458685,
   (c_pop_55_64_p = NULL) => 0.0131291286, 0.0131291286), -0.0003989340);

// Tree: 163 
wFDN_FLA_S__lgt_163 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 107.5) => -0.0233431974,
   (c_many_cars > 107.5) => 0.0066985444,
   (c_many_cars = NULL) => -0.0100537490, -0.0100537490),
(c_pop_35_44_p > 14.75) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 23.85) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27707.5) => 
         map(
         (NULL < c_very_rich and c_very_rich <= 117.5) => 0.0058817309,
         (c_very_rich > 117.5) => 0.1510996287,
         (c_very_rich = NULL) => 0.0563130510, 0.0563130510),
      (f_curraddrmedianincome_d > 27707.5) => 0.0041816978,
      (f_curraddrmedianincome_d = NULL) => 0.0274953046, 0.0064409745),
   (C_INC_25K_P > 23.85) => 0.1502602153,
   (C_INC_25K_P = NULL) => 0.0080569210, 0.0080569210),
(c_pop_35_44_p = NULL) => 0.0085011461, -0.0008633675);

// Tree: 164 
wFDN_FLA_S__lgt_164 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 102) => -0.0054167359,
(f_curraddrcartheftindex_i > 102) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 24627) => 
      map(
      (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 0.0100250144,
      (f_assoccredbureaucountnew_i > 0.5) => 0.1237048452,
      (f_assoccredbureaucountnew_i = NULL) => 0.0129014354, 0.0129014354),
   (f_addrchangeincomediff_d > 24627) => 0.1091501309,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 49.75) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => -0.0411726234,
         (f_phones_per_addr_curr_i > 4.5) => 0.0475217865,
         (f_phones_per_addr_curr_i = NULL) => -0.0079725396, -0.0079725396),
      (c_hh2_p > 49.75) => 0.2176620582,
      (c_hh2_p = NULL) => 0.0036701125, 0.0036701125), 0.0129197402),
(f_curraddrcartheftindex_i = NULL) => -0.0053809325, 0.0015090817);

// Tree: 165 
wFDN_FLA_S__lgt_165 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 62.4) => 
      map(
      (NULL < c_rental and c_rental <= 177.5) => -0.0375896300,
      (c_rental > 177.5) => 0.0863088066,
      (c_rental = NULL) => -0.0232600506, -0.0232600506),
   (c_low_ed > 62.4) => -0.0941453972,
   (c_low_ed = NULL) => -0.0365764272, -0.0365764272),
(f_mos_inq_banko_om_fseen_d > 21.5) => 
   map(
   (NULL < f_liens_rel_O_total_amt_i and f_liens_rel_O_total_amt_i <= 30) => 0.0074106882,
   (f_liens_rel_O_total_amt_i > 30) => -0.1168335141,
   (f_liens_rel_O_total_amt_i = NULL) => 0.0062409807, 0.0062409807),
(f_mos_inq_banko_om_fseen_d = NULL) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.4) => -0.0570263261,
   (c_hval_175k_p > 2.4) => 0.0565427349,
   (c_hval_175k_p = NULL) => -0.0028952783, -0.0028952783), 0.0031542406);

// Tree: 166 
wFDN_FLA_S__lgt_166 := map(
(NULL < c_asian_lang and c_asian_lang <= 194.5) => 
   map(
   (NULL < c_info and c_info <= 23.35) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
         map(
         (NULL < c_bargains and c_bargains <= 113.5) => 
            map(
            (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.1) => 0.2206651650,
            (r_C12_source_profile_d > 60.1) => 0.0108899437,
            (r_C12_source_profile_d = NULL) => 0.1194578214, 0.1194578214),
         (c_bargains > 113.5) => -0.0146158442,
         (c_bargains = NULL) => 0.0614259363, 0.0614259363),
      (r_D32_Mos_Since_Crim_LS_d > 10.5) => 0.0001095607,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0057951856, 0.0012054108),
   (c_info > 23.35) => 0.1308334302,
   (c_info = NULL) => 0.0021231313, 0.0021231313),
(c_asian_lang > 194.5) => -0.0524669060,
(c_asian_lang = NULL) => 0.0108226701, -0.0000486516);

// Tree: 167 
wFDN_FLA_S__lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 194) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.65) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 50.4) => 
            map(
            (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0010006685,
            (f_hh_collections_ct_i > 2.5) => 0.1369759403,
            (f_hh_collections_ct_i = NULL) => 0.0108066208, 0.0108066208),
         (c_rnt750_p > 50.4) => 0.1352664976,
         (c_rnt750_p = NULL) => 0.0230193320, 0.0230193320),
      (r_C12_source_profile_d > 75.65) => 0.1602983822,
      (r_C12_source_profile_d = NULL) => 0.0366518097, 0.0366518097),
   (f_liens_unrel_CJ_total_amt_i > 194) => -0.0739011623,
   (f_liens_unrel_CJ_total_amt_i = NULL) => 0.0285154364, 0.0285154364),
(c_many_cars > 22.5) => -0.0075715894,
(c_many_cars = NULL) => 0.0141607337, -0.0039522617);

// Tree: 168 
wFDN_FLA_S__lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0062645470,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1894.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 13.5) => 0.0054919260,
      (f_corraddrnamecount_d > 13.5) => 0.1839089364,
      (f_corraddrnamecount_d = NULL) => 0.0216185711, 0.0216185711),
   (c_popover18 > 1894.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 117.5) => 
         map(
         (NULL < f_current_count_d and f_current_count_d <= 0.5) => 0.1214254958,
         (f_current_count_d > 0.5) => -0.0448909031,
         (f_current_count_d = NULL) => 0.0451971463, 0.0451971463),
      (c_sub_bus > 117.5) => 0.2864637050,
      (c_sub_bus = NULL) => 0.1157429237, 0.1157429237),
   (c_popover18 = NULL) => 0.0400764430, 0.0400764430),
(c_hval_150k_p = NULL) => -0.0067791020, -0.0030905478);

// Tree: 169 
wFDN_FLA_S__lgt_169 := map(
(NULL < c_unempl and c_unempl <= 192.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 12.05) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 36.25) => -0.0049148518,
      (c_hval_500k_p > 36.25) => 
         map(
         (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
            map(
            (NULL < c_rich_wht and c_rich_wht <= 47) => 0.2195802485,
            (c_rich_wht > 47) => 0.0550983152,
            (c_rich_wht = NULL) => 0.1082540620, 0.1082540620),
         (f_rel_incomeover100_count_d > 0.5) => -0.0030531567,
         (f_rel_incomeover100_count_d = NULL) => 0.0479367423, 0.0479367423),
      (c_hval_500k_p = NULL) => -0.0033286125, -0.0033286125),
   (c_unemp > 12.05) => -0.0786888325,
   (c_unemp = NULL) => -0.0038609989, -0.0038609989),
(c_unempl > 192.5) => 0.0749651140,
(c_unempl = NULL) => 0.0002225133, -0.0032410525);

// Tree: 170 
wFDN_FLA_S__lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 86.25) => -0.0031634773,
   (C_OWNOCC_P > 86.25) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0121419781,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 16.35) => 0.0449712274,
         (C_INC_125K_P > 16.35) => 0.2254257913,
         (C_INC_125K_P = NULL) => 0.0830397244, 0.0830397244),
      (nf_seg_FraudPoint_3_0 = '') => 0.0246251799, 0.0246251799),
   (C_OWNOCC_P = NULL) => -0.0303152388, 0.0009089084),
(f_util_adl_count_n > 13.5) => 0.1263636044,
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_totsales and c_totsales <= 9282.5) => -0.0344244290,
   (c_totsales > 9282.5) => 0.0695558159,
   (c_totsales = NULL) => 0.0111809416, 0.0111809416), 0.0019803334);

// Tree: 171 
wFDN_FLA_S__lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 40.7) => 0.0056360888,
   (C_RENTOCC_P > 40.7) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 25.5) => 0.1385978636,
      (c_exp_prod > 25.5) => 
         map(
         (NULL < c_retired2 and c_retired2 <= 100.5) => 0.0035561706,
         (c_retired2 > 100.5) => 
            map(
            (NULL < c_relig_indx and c_relig_indx <= 150) => 0.0458942906,
            (c_relig_indx > 150) => 0.2807141363,
            (c_relig_indx = NULL) => 0.1246048534, 0.1246048534),
         (c_retired2 = NULL) => 0.0495598101, 0.0495598101),
      (c_exp_prod = NULL) => 0.0607928113, 0.0607928113),
   (C_RENTOCC_P = NULL) => 0.0292988160, 0.0227987675),
(f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0013313916,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0166860623, 0.0020274873);

// Tree: 172 
wFDN_FLA_S__lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.55) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 7.5) => 0.0022303663,
      (r_L79_adls_per_addr_curr_i > 7.5) => 
         map(
         (NULL < c_transport and c_transport <= 5.55) => -0.0519715884,
         (c_transport > 5.55) => 0.0728244134,
         (c_transport = NULL) => -0.0371149215, -0.0371149215),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0170454127, 0.0009134454),
   (c_manufacturing > 16.55) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 4.5) => -0.0430741127,
      (r_D30_Derog_Count_i > 4.5) => -0.1232155559,
      (r_D30_Derog_Count_i = NULL) => -0.0473369554, -0.0473369554),
   (c_manufacturing = NULL) => -0.0028053279, -0.0028053279),
(c_pop_0_5_p > 20.55) => 0.1211665840,
(c_pop_0_5_p = NULL) => 0.0036605090, -0.0021049400);

// Tree: 173 
wFDN_FLA_S__lgt_173 := map(
(NULL < c_low_hval and c_low_hval <= 71.55) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 142732.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.11881492165) => 0.0102716470,
      (f_add_curr_nhood_VAC_pct_i > 0.11881492165) => 0.0873489305,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0199960460, 0.0199960460),
   (r_L80_Inp_AVM_AutoVal_d > 142732.5) => -0.0108295477,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 18.65) => -0.0071801013,
      (c_hval_200k_p > 18.65) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 4.5) => 0.0183085865,
         (f_rel_incomeover75_count_d > 4.5) => 0.2585229478,
         (f_rel_incomeover75_count_d = NULL) => 0.0747768878, 0.0747768878),
      (c_hval_200k_p = NULL) => -0.0028073720, -0.0028073720), -0.0015145183),
(c_low_hval > 71.55) => -0.1006940042,
(c_low_hval = NULL) => -0.0387558826, -0.0029639660);

// Tree: 174 
wFDN_FLA_S__lgt_174 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0048152787,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 6.45) => 0.1401398556,
      (c_high_ed > 6.45) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 46) => 0.1406464013,
         (r_C10_M_Hdr_FS_d > 46) => 
            map(
            (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0562858789) => 0.0999395942,
            (f_add_curr_nhood_MFD_pct_i > 0.0562858789) => -0.0135852913,
            (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0030209824, 0.0187673076),
         (r_C10_M_Hdr_FS_d = NULL) => 0.0266894487, 0.0266894487),
      (c_high_ed = NULL) => 0.0381619617, 0.0381619617),
   (f_rel_felony_count_i = NULL) => 0.0087230931, 0.0087230931),
(f_dl_addrs_per_adl_i > 0.5) => -0.0150333849,
(f_dl_addrs_per_adl_i = NULL) => -0.0315342177, -0.0008011693);

// Tree: 175 
wFDN_FLA_S__lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 16.35) => 0.0479042340,
   (c_white_col > 16.35) => -0.0120150307,
   (c_white_col = NULL) => 0.0226638751, -0.0098059914),
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2) => 0.0070306111,
   (f_idverrisktype_i > 2) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 136.5) => 0.0208455283,
      (c_serv_empl > 136.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 82.5) => 0.2597757820,
         (c_exp_prod > 82.5) => 0.1168149705,
         (c_exp_prod = NULL) => 0.1677325198, 0.1677325198),
      (c_serv_empl = NULL) => 0.0650630556, 0.0650630556),
   (f_idverrisktype_i = NULL) => 0.0176726640, 0.0176726640),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0021628471, -0.0036493637);

// Tree: 176 
wFDN_FLA_S__lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 24.75) => 0.0039167858,
      (c_hval_40k_p > 24.75) => 0.1032818991,
      (c_hval_40k_p = NULL) => 0.0052110420, 0.0052110420),
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_robbery and c_robbery <= 165.5) => 0.0187633950,
         (c_robbery > 165.5) => 0.1860999552,
         (c_robbery = NULL) => 0.0343295867, 0.0343295867),
      (c_pop_55_64_p > 17.45) => 0.2314534830,
      (c_pop_55_64_p = NULL) => 0.0514007738, 0.0514007738),
   (f_util_adl_count_n = NULL) => 0.0114454472, 0.0082304284),
(c_pop_18_24_p > 11.15) => -0.0246080785,
(c_pop_18_24_p = NULL) => 0.0226835520, 0.0010902896);

// Tree: 177 
wFDN_FLA_S__lgt_177 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 104.5) => -0.0052923312,
(f_prevaddrageoldest_d > 104.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 113500) => 0.0120527919,
   (k_estimated_income_d > 113500) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 35.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 314.5) => 0.3106903541,
         (r_C10_M_Hdr_FS_d > 314.5) => 0.0667701188,
         (r_C10_M_Hdr_FS_d = NULL) => 0.1715953439, 0.1715953439),
      (c_born_usa > 35.5) => 0.0330282061,
      (c_born_usa = NULL) => 0.0760195489, 0.0760195489),
   (k_estimated_income_d = NULL) => 0.0175525792, 0.0175525792),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 114.5) => -0.0654751197,
   (c_new_homes > 114.5) => 0.0428018707,
   (c_new_homes = NULL) => -0.0118243587, -0.0118243587), 0.0028175096);

// Tree: 178 
wFDN_FLA_S__lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 14.55) => -0.0078202185,
(c_rnt1250_p > 14.55) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.35) => 0.0058565027,
   (c_pop_6_11_p > 9.35) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 15.15) => 
         map(
         (NULL < c_retail and c_retail <= 28.45) => 
            map(
            (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => 0.0591146631,
            (f_inq_Collection_count_i > 3.5) => 0.1672334262,
            (f_inq_Collection_count_i = NULL) => 0.0722062878, 0.0722062878),
         (c_retail > 28.45) => 0.2311800164,
         (c_retail = NULL) => 0.0913178836, 0.0913178836),
      (c_hval_400k_p > 15.15) => 0.0150115546,
      (c_hval_400k_p = NULL) => 0.0538725700, 0.0538725700),
   (c_pop_6_11_p = NULL) => 0.0199565628, 0.0199565628),
(c_rnt1250_p = NULL) => 0.0006302295, 0.0004161510);

// Tree: 179 
wFDN_FLA_S__lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0009910259,
   (f_assocsuspicousidcount_i > 13.5) => 0.0883448938,
   (f_assocsuspicousidcount_i = NULL) => -0.0005556369, -0.0005556369),
(f_rel_incomeover50_count_d > 22.5) => -0.0576686159,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.85) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 158.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 53.4) => 0.1864300701,
         (C_OWNOCC_P > 53.4) => 0.0760679760,
         (C_OWNOCC_P = NULL) => 0.1196995016, 0.1196995016),
      (c_asian_lang > 158.5) => -0.0202737468,
      (c_asian_lang = NULL) => 0.0603358471, 0.0603358471),
   (c_pop_45_54_p > 16.85) => -0.0866025512,
   (c_pop_45_54_p = NULL) => 0.0209601979, 0.0209601979), -0.0011975826);

// Tree: 180 
wFDN_FLA_S__lgt_180 := map(
(NULL < k_inq_adls_per_ssn_i and k_inq_adls_per_ssn_i <= 1.5) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 78.5) => 0.0028717479,
      (f_addrchangecrimediff_i > 78.5) => 0.0987252950,
      (f_addrchangecrimediff_i = NULL) => 0.0062948473, 0.0045591659),
   (f_rel_incomeover100_count_d > 0.5) => -0.0138248228,
   (f_rel_incomeover100_count_d = NULL) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 119.5) => -0.0190737979,
      (c_for_sale > 119.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 9.65) => 0.1697943177,
         (C_INC_35K_P > 9.65) => 0.0034789096,
         (C_INC_35K_P = NULL) => 0.0887688625, 0.0887688625),
      (c_for_sale = NULL) => 0.0241371311, 0.0241371311), -0.0021014186),
(k_inq_adls_per_ssn_i > 1.5) => 0.1276298286,
(k_inq_adls_per_ssn_i = NULL) => -0.0015491531, -0.0015491531);

// Tree: 181 
wFDN_FLA_S__lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 194481.5) => 
      map(
      (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => 
         map(
         (NULL < c_rape and c_rape <= 110) => -0.0841495432,
         (c_rape > 110) => 0.1144405166,
         (c_rape = NULL) => 0.0163136635, 0.0163136635),
      (f_divaddrsuspidcountnew_i > 0.5) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 7.25) => 0.0667433444,
         (C_INC_125K_P > 7.25) => 0.1941726746,
         (C_INC_125K_P = NULL) => 0.1179157526, 0.1179157526),
      (f_divaddrsuspidcountnew_i = NULL) => 0.0597596747, 0.0597596747),
   (c_med_hval > 194481.5) => -0.0065967734,
   (c_med_hval = NULL) => 0.0187021548, 0.0187021548),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0043273862,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0199206850, -0.0026747485);

// Tree: 182 
wFDN_FLA_S__lgt_182 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0043321232,
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03655072715) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
         map(
         (NULL < k_inq_dobs_per_ssn_i and k_inq_dobs_per_ssn_i <= 0.5) => 
            map(
            (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.96691025515) => 0.1515341231,
            (f_add_input_nhood_SFD_pct_d > 0.96691025515) => 0.0166841130,
            (f_add_input_nhood_SFD_pct_d = NULL) => 0.1121014487, 0.1121014487),
         (k_inq_dobs_per_ssn_i > 0.5) => 0.0275265174,
         (k_inq_dobs_per_ssn_i = NULL) => 0.0724063181, 0.0724063181),
      (c_asian_lang > 181.5) => -0.0438583906,
      (c_asian_lang = NULL) => 0.0496549806, 0.0496549806),
   (f_add_curr_nhood_BUS_pct_i > 0.03655072715) => -0.0118038074,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0715187743, 0.0216735616),
(k_inq_per_addr_i = NULL) => -0.0015070673, -0.0015070673);

// Tree: 183 
wFDN_FLA_S__lgt_183 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0017626874,
   (k_inq_adls_per_addr_i > 3.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 12.25) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 2.5) => -0.0016269433,
         (f_rel_incomeover75_count_d > 2.5) => -0.0698300337,
         (f_rel_incomeover75_count_d = NULL) => -0.0309701334, -0.0309701334),
      (C_INC_25K_P > 12.25) => -0.1072466219,
      (C_INC_25K_P = NULL) => -0.0528957637, -0.0528957637),
   (k_inq_adls_per_addr_i = NULL) => -0.0027868236, -0.0027868236),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0719007993,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 101) => -0.0729239076,
   (c_burglary > 101) => 0.0402553292,
   (c_burglary = NULL) => -0.0136395455, -0.0136395455), -0.0033876434);

// Tree: 184 
wFDN_FLA_S__lgt_184 := map(
(NULL < c_families and c_families <= 106) => -0.0682194327,
(c_families > 106) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -13335) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 35.2) => 0.0163965641,
      (c_rnt1000_p > 35.2) => 0.1372151725,
      (c_rnt1000_p = NULL) => 0.0391534938, 0.0391534938),
   (f_addrchangeincomediff_d > -13335) => -0.0008548726,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0006410936,
      (f_util_adl_count_n > 6.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 24.5) => 0.0193952140,
         (r_C13_Curr_Addr_LRes_d > 24.5) => 0.1731805807,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0755725169, 0.0755725169),
      (f_util_adl_count_n = NULL) => 0.0008591562, 0.0060247717), 0.0015257206),
(c_families = NULL) => 0.0271363024, 0.0010128176);

// Tree: 185 
wFDN_FLA_S__lgt_185 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 41.65) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 3.4) => 0.2031329812,
      (c_hh5_p > 3.4) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 97.5) => -0.0600943560,
         (c_medi_indx > 97.5) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 56) => 0.0182451433,
            (f_prevaddrlenofres_d > 56) => 0.2594077814,
            (f_prevaddrlenofres_d = NULL) => 0.1365513431, 0.1365513431),
         (c_medi_indx = NULL) => 0.0525783148, 0.0525783148),
      (c_hh5_p = NULL) => 0.0960075455, 0.0960075455),
   (c_med_age > 41.65) => -0.0837348686,
   (c_med_age = NULL) => 0.0557667065, 0.0557667065),
(r_I61_inq_collection_recency_d > 4.5) => 0.0015311536,
(r_I61_inq_collection_recency_d = NULL) => -0.0035023443, 0.0029496591);

// Tree: 186 
wFDN_FLA_S__lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3972388293) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.75) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30155.5) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 24274) => -0.0124742425,
            (f_prevaddrmedianincome_d > 24274) => 0.0923394606,
            (f_prevaddrmedianincome_d = NULL) => 0.0391238613, 0.0391238613),
         (f_curraddrmedianincome_d > 30155.5) => 0.0030363703,
         (f_curraddrmedianincome_d = NULL) => 0.0052617885, 0.0052617885),
      (c_pop_6_11_p > 15.75) => 0.1717615123,
      (c_pop_6_11_p = NULL) => -0.0359179261, 0.0057110246),
   (f_add_input_mobility_index_i > 0.3972388293) => -0.0242862213,
   (f_add_input_mobility_index_i = NULL) => 0.0127425572, 0.0014722078),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0722397867,
(f_inq_PrepaidCards_count_i = NULL) => 0.0264976542, 0.0019707489);

// Tree: 187 
wFDN_FLA_S__lgt_187 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 80.45) => 
         map(
         (NULL < c_no_car and c_no_car <= 184.5) => -0.0006809435,
         (c_no_car > 184.5) => -0.0367529462,
         (c_no_car = NULL) => -0.0032441791, -0.0032441791),
      (c_high_hval > 80.45) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00279031755) => -0.0919763274,
         (f_add_curr_nhood_BUS_pct_i > 0.00279031755) => 0.0497607761,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0367029190, 0.0367029190),
      (c_high_hval = NULL) => -0.0001458354, -0.0010927391),
   (f_rel_bankrupt_count_i > 7.5) => -0.0775445883,
   (f_rel_bankrupt_count_i = NULL) => -0.0124375093, -0.0021644137),
(r_L72_Add_Vacant_i > 0.5) => 0.1042665341,
(r_L72_Add_Vacant_i = NULL) => -0.0014591282, -0.0014591282);

// Tree: 188 
wFDN_FLA_S__lgt_188 := map(
(nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','6: Other']) => -0.0078162759,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','5: Vuln Vic/Friendly']) => 
   map(
   (NULL < c_young and c_young <= 28.45) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 175.5) => 0.0217282630,
      (c_sub_bus > 175.5) => 0.0868763040,
      (c_sub_bus = NULL) => 0.0275904806, 0.0275904806),
   (c_young > 28.45) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 54.45) => -0.0342319508,
      (c_rnt750_p > 54.45) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 6.5) => 0.1237476957,
         (f_rel_educationover12_count_d > 6.5) => -0.0036825353,
         (f_rel_educationover12_count_d = NULL) => 0.0552056775, 0.0552056775),
      (c_rnt750_p = NULL) => -0.0213775548, -0.0213775548),
   (c_young = NULL) => -0.0297278202, 0.0135612893),
(nf_seg_FraudPoint_3_0 = '') => -0.0009235489, -0.0009235489);

// Tree: 189 
wFDN_FLA_S__lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 38.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 49.4) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 160500) => -0.0031704443,
      (k_estimated_income_d > 160500) => 0.1668922915,
      (k_estimated_income_d = NULL) => -0.0022234527, -0.0022234527),
   (c_hval_80k_p > 49.4) => -0.1168603355,
   (c_hval_80k_p = NULL) => -0.0210024793, -0.0031246816),
(f_phones_per_addr_curr_i > 38.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 49) => 0.0853506156,
      (c_many_cars > 49) => -0.0777155077,
      (c_many_cars = NULL) => -0.0087259940, -0.0087259940),
   (f_rel_under25miles_cnt_d > 4.5) => 0.1464159814,
   (f_rel_under25miles_cnt_d = NULL) => 0.0553993558, 0.0553993558),
(f_phones_per_addr_curr_i = NULL) => -0.0043796818, -0.0020598936);

// Tree: 190 
wFDN_FLA_S__lgt_190 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 59309) => -0.0466928185,
(r_A46_Curr_AVM_AutoVal_d > 59309) => -0.0023229945,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 58.7) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 0.45) => -0.0977251202,
      (c_sfdu_p > 0.45) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1797367488) => -0.0185529414,
         (f_add_curr_nhood_MFD_pct_i > 0.1797367488) => 
            map(
            (NULL < c_rnt1500_p and c_rnt1500_p <= 6.05) => 0.0308757598,
            (c_rnt1500_p > 6.05) => -0.0230013551,
            (c_rnt1500_p = NULL) => 0.0104818362, 0.0104818362),
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0257127093, -0.0049313794),
      (c_sfdu_p = NULL) => -0.0075442929, -0.0075442929),
   (c_construction > 58.7) => 0.1217198316,
   (c_construction = NULL) => -0.0198503287, -0.0064478887), -0.0058746076);

// Tree: 191 
wFDN_FLA_S__lgt_191 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 169.5) => -0.0039441180,
(f_fp_prevaddrcrimeindex_i > 169.5) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 13.85) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 9.5) => -0.0939560690,
      (f_mos_inq_banko_cm_lseen_d > 9.5) => 
         map(
         (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 1.5) => 0.0098107460,
         (f_assoccredbureaucount_i > 1.5) => 0.0988324737,
         (f_assoccredbureaucount_i = NULL) => 0.0254812374, 0.0254812374),
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0160086235, 0.0160086235),
   (c_trailer_p > 13.85) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 74) => 0.2313513259,
      (c_fammar_p > 74) => 0.0205798245,
      (c_fammar_p = NULL) => 0.1128703044, 0.1128703044),
   (c_trailer_p = NULL) => 0.0317637958, 0.0317637958),
(f_fp_prevaddrcrimeindex_i = NULL) => -0.0244064025, -0.0011924083);

// Tree: 192 
wFDN_FLA_S__lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 238) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 114.5) => 0.1525929565,
   (c_bel_edu > 114.5) => -0.0315587671,
   (c_bel_edu = NULL) => 0.0629190737, 0.0629190737),
(r_D32_Mos_Since_Fel_LS_d > 238) => 
   map(
   (NULL < c_unempl and c_unempl <= 165.5) => -0.0002967302,
   (c_unempl > 165.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog']) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.33252650905) => -0.0988540579,
         (f_add_curr_mobility_index_i > 0.33252650905) => -0.0496033718,
         (f_add_curr_mobility_index_i = NULL) => -0.0848202602, -0.0848202602),
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0125018832,
      (nf_seg_FraudPoint_3_0 = '') => -0.0283932304, -0.0283932304),
   (c_unempl = NULL) => 0.0020587224, -0.0021624103),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0004988326, -0.0015580981);

// Tree: 193 
wFDN_FLA_S__lgt_193 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 0.9) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 12.55) => 0.0677418354,
      (c_hh3_p > 12.55) => 
         map(
         (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 2.5) => -0.0058998758,
         (f_hh_tot_derog_i > 2.5) => -0.1214071422,
         (f_hh_tot_derog_i = NULL) => -0.0441473150, -0.0441473150),
      (c_hh3_p = NULL) => -0.0083629471, -0.0083629471),
   (c_hval_60k_p > 0.9) => -0.0830915159,
   (c_hval_60k_p = NULL) => -0.0331224126, -0.0331224126),
(nf_vf_hi_risk_index > 4.5) => 0.0000527880,
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 2.7) => -0.0658888017,
   (c_high_hval > 2.7) => 0.0407688808,
   (c_high_hval = NULL) => -0.0115903452, -0.0115903452), -0.0009341259);

// Tree: 194 
wFDN_FLA_S__lgt_194 := map(
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 3.15) => -0.0642350612,
   (c_hh5_p > 3.15) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 140.5) => -0.0420830383,
      (c_oldhouse > 140.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0242555398,
         (f_corrrisktype_i > 7.5) => 
            map(
            (NULL < f_prevaddrdwelltype_sfd_n and f_prevaddrdwelltype_sfd_n <= 0.5) => 0.1472403895,
            (f_prevaddrdwelltype_sfd_n > 0.5) => 0.0379649266,
            (f_prevaddrdwelltype_sfd_n = NULL) => 0.0902677122, 0.0902677122),
         (f_corrrisktype_i = NULL) => 0.0523114344, 0.0523114344),
      (c_oldhouse = NULL) => -0.0091109171, -0.0091109171),
   (c_hh5_p = NULL) => -0.0102820839, -0.0294891436),
(nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0022070117,
(nf_seg_FraudPoint_3_0 = '') => -0.0000118441, -0.0000118441);

// Tree: 195 
wFDN_FLA_S__lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 0.0059970100,
   (f_inq_Auto_count24_i > 1.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 7.5) => 
         map(
         (NULL < c_hval_500k_p and c_hval_500k_p <= 21.95) => -0.0450527295,
         (c_hval_500k_p > 21.95) => 0.1320661990,
         (c_hval_500k_p = NULL) => -0.0254049528, -0.0254049528),
      (k_inq_per_addr_i > 7.5) => -0.1093874739,
      (k_inq_per_addr_i = NULL) => -0.0331189028, -0.0331189028),
   (f_inq_Auto_count24_i = NULL) => 
      map(
      (NULL < c_burglary and c_burglary <= 102.5) => -0.0644510309,
      (c_burglary > 102.5) => 0.0355110751,
      (c_burglary = NULL) => -0.0213639162, -0.0213639162), 0.0035853084),
(c_hval_80k_p > 40.05) => -0.1161050677,
(c_hval_80k_p = NULL) => 0.0233485395, 0.0029549771);

// Tree: 196 
wFDN_FLA_S__lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0868162860,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 22.15) => -0.0247678826,
      (c_vacant_p > 22.15) => 
         map(
         (NULL < c_highinc and c_highinc <= 9.9) => 0.2231447906,
         (c_highinc > 9.9) => -0.0709003071,
         (c_highinc = NULL) => 0.0724001519, 0.0724001519),
      (c_vacant_p = NULL) => -0.0852381881, -0.0219175842),
   (f_addrs_per_ssn_i > 5.5) => 0.0075293518,
   (f_addrs_per_ssn_i = NULL) => -0.0018005610, -0.0018005610),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.595) => 0.0826609868,
   (c_hhsize > 2.595) => -0.0337916784,
   (c_hhsize = NULL) => 0.0188651789, 0.0188651789), -0.0037346915);

// Tree: 197 
wFDN_FLA_S__lgt_197 := map(
(NULL < f_liens_unrel_FT_total_amt_i and f_liens_unrel_FT_total_amt_i <= 29000.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -91244) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 609039.5) => 0.0792637943,
      (f_prevaddrmedianvalue_d > 609039.5) => -0.0670557694,
      (f_prevaddrmedianvalue_d = NULL) => 0.0447161195, 0.0447161195),
   (f_addrchangevaluediff_d > -91244) => -0.0006004659,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 10.05) => -0.0158993933,
      (c_hh5_p > 10.05) => 0.0534743727,
      (c_hh5_p = NULL) => 0.0021237758, -0.0006893715), 0.0001636243),
(f_liens_unrel_FT_total_amt_i > 29000.5) => -0.1158464982,
(f_liens_unrel_FT_total_amt_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 9.95) => -0.0444000158,
   (c_retail > 9.95) => 0.0441467528,
   (c_retail = NULL) => -0.0001266315, -0.0001266315), -0.0004427904);

// Tree: 198 
wFDN_FLA_S__lgt_198 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0989838352,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 24.5) => -0.0308916955,
   (r_A50_pb_average_dollars_d > 24.5) => 
      map(
      (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 48) => 
         map(
         (NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 729.5) => 0.0105222020,
         (f_liens_unrel_ST_total_amt_i > 729.5) => 0.1271443540,
         (f_liens_unrel_ST_total_amt_i = NULL) => 0.0114234918, 0.0114234918),
      (r_D31_attr_bankruptcy_recency_d > 48) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 130015) => -0.0890551936,
         (r_A46_Curr_AVM_AutoVal_d > 130015) => -0.0228523621,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0065527590, -0.0269437143),
      (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0082163923, 0.0082163923),
   (r_A50_pb_average_dollars_d = NULL) => 0.0027009890, 0.0037283221),
(c_pop_45_54_p = NULL) => -0.0271862096, 0.0016507121);

// Tree: 199 
wFDN_FLA_S__lgt_199 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0038725487,
(f_prevaddroccupantowned_i > 0.5) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 48.5) => 0.1078846613,
   (c_ab_av_edu > 48.5) => 
      map(
      (NULL < c_retired and c_retired <= 4.15) => -0.0947539339,
      (c_retired > 4.15) => 
         map(
         (NULL < c_murders and c_murders <= 12.5) => 0.1843714739,
         (c_murders > 12.5) => 
            map(
            (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0048157983) => 0.1629620872,
            (f_add_input_nhood_BUS_pct_i > 0.0048157983) => 0.0089335492,
            (f_add_input_nhood_BUS_pct_i = NULL) => 0.0257582049, 0.0257582049),
         (c_murders = NULL) => 0.0387062269, 0.0387062269),
      (c_retired = NULL) => 0.0267990006, 0.0267990006),
   (c_ab_av_edu = NULL) => 0.0354194031, 0.0354194031),
(f_prevaddroccupantowned_i = NULL) => 0.0076051301, -0.0009595716);

// Tree: 200 
wFDN_FLA_S__lgt_200 := map(
(NULL < c_food and c_food <= 68.85) => -0.0048469402,
(c_food > 68.85) => 
   map(
   (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 14.5) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 17.35) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 88.5) => 
            map(
            (NULL < c_many_cars and c_many_cars <= 99.5) => 0.2133077629,
            (c_many_cars > 99.5) => 0.0111112514,
            (c_many_cars = NULL) => 0.1148017701, 0.1148017701),
         (f_prevaddrmurderindex_i > 88.5) => -0.0182920252,
         (f_prevaddrmurderindex_i = NULL) => 0.0427745397, 0.0427745397),
      (c_blue_col > 17.35) => 0.2029574616,
      (c_blue_col = NULL) => 0.0720387274, 0.0720387274),
   (f_rel_homeover150_count_d > 14.5) => -0.1082018575,
   (f_rel_homeover150_count_d = NULL) => 0.0454458542, 0.0454458542),
(c_food = NULL) => -0.0314094360, -0.0039720576);

// Tree: 201 
wFDN_FLA_S__lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0058358176,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 5.55) => 0.0024837861,
   (c_finance > 5.55) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 9.5) => 
         map(
         (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 8.5) => 
            map(
            (NULL < c_relig_indx and c_relig_indx <= 88.5) => 0.2596402999,
            (c_relig_indx > 88.5) => 0.0357106712,
            (c_relig_indx = NULL) => 0.1001930250, 0.1001930250),
         (f_rel_homeover50_count_d > 8.5) => 0.2418059969,
         (f_rel_homeover50_count_d = NULL) => 0.1304970355, 0.1304970355),
      (f_rel_homeover150_count_d > 9.5) => -0.0596807084,
      (f_rel_homeover150_count_d = NULL) => 0.0959192639, 0.0959192639),
   (c_finance = NULL) => 0.0940987529, 0.0380415736),
(r_L70_Add_Standardized_i = NULL) => -0.0021900336, -0.0021900336);

// Tree: 202 
wFDN_FLA_S__lgt_202 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 0.75) => -0.0943078184,
(c_pop_0_5_p > 0.75) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 0.95) => 0.1854822320,
   (c_pop_25_34_p > 0.95) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 14.5) => 
         map(
         (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 1.5) => -0.0615722773,
         (f_phones_per_addr_c6_i > 1.5) => 0.0709804706,
         (f_phones_per_addr_c6_i = NULL) => -0.0458006268, -0.0458006268),
      (f_mos_inq_banko_om_fseen_d > 14.5) => 
         map(
         (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 0.0446740337,
         (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0012441462,
         (f_mos_inq_banko_om_fseen_d = NULL) => 0.0017485756, 0.0017485756),
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0026239698, -0.0011679035),
   (c_pop_25_34_p = NULL) => -0.0000998491, -0.0000998491),
(c_pop_0_5_p = NULL) => 0.0209264762, -0.0008313660);

// Tree: 203 
wFDN_FLA_S__lgt_203 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 119.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 60.35) => 0.0012945795,
   (c_low_hval > 60.35) => -0.0869205157,
   (c_low_hval = NULL) => 0.0002456915, 0.0002456915),
(f_addrchangecrimediff_i > 119.5) => 0.0758098906,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 55.45) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => -0.0231992981,
      (f_phones_per_addr_curr_i > 4.5) => 0.0282655636,
      (f_phones_per_addr_curr_i = NULL) => -0.0129227971, -0.0059921792),
   (c_rnt750_p > 55.45) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 19.4) => -0.1093897676,
      (c_hval_100k_p > 19.4) => 0.0690893637,
      (c_hval_100k_p = NULL) => -0.0750668577, -0.0750668577),
   (c_rnt750_p = NULL) => -0.0088335242, -0.0125140829), -0.0023385050);

// Tree: 204 
wFDN_FLA_S__lgt_204 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 30.25) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 0.0238434063,
      (f_hh_lienholders_i > 0.5) => -0.0884765327,
      (f_hh_lienholders_i = NULL) => -0.0305751688, -0.0305751688),
   (c_fammar_p > 30.25) => 0.0050707255,
   (c_fammar_p = NULL) => -0.0072852066, 0.0040425983),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 3.085) => -0.0473016652,
   (c_hhsize > 3.085) => -0.1113684629,
   (c_hhsize = NULL) => -0.0598078552, -0.0598078552),
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_med_yearblt and c_med_yearblt <= 1973.5) => 0.0621571430,
   (c_med_yearblt > 1973.5) => -0.0443324597,
   (c_med_yearblt = NULL) => 0.0093835346, 0.0093835346), 0.0026174542);

// Tree: 205 
wFDN_FLA_S__lgt_205 := map(
(NULL < C_INC_125K_P and C_INC_125K_P <= 19.45) => 
   map(
   (NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5632.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 2916) => 0.0043834452,
      (f_liens_unrel_SC_total_amt_i > 2916) => -0.0667423906,
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0036233761, 0.0036233761),
   (f_liens_unrel_ST_total_amt_i > 5632.5) => 0.1199454274,
   (f_liens_unrel_ST_total_amt_i = NULL) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 60.95) => 0.0556670603,
      (c_civ_emp > 60.95) => -0.0329460441,
      (c_civ_emp = NULL) => 0.0077021689, 0.0077021689), 0.0041392112),
(C_INC_125K_P > 19.45) => -0.0816955440,
(C_INC_125K_P = NULL) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0377908184,
   (f_inq_Collection_count_i > 1.5) => 0.0861787618,
   (f_inq_Collection_count_i = NULL) => -0.0139341294, -0.0139341294), 0.0020176262);

// Tree: 206 
wFDN_FLA_S__lgt_206 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 30) => 
   map(
   (NULL < f_mos_liens_unrel_OT_lseen_d and f_mos_liens_unrel_OT_lseen_d <= 199.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 30.55) => -0.0888949711,
      (c_hh2_p > 30.55) => -0.0105841394,
      (c_hh2_p = NULL) => -0.0406880435, -0.0406880435),
   (f_mos_liens_unrel_OT_lseen_d > 199.5) => -0.0018828284,
   (f_mos_liens_unrel_OT_lseen_d = NULL) => -0.0031085880, -0.0031085880),
(f_rel_homeover300_count_d > 30) => -0.1072773745,
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 51.55) => 0.0787175598,
   (c_fammar_p > 51.55) => 
      map(
      (NULL < c_larceny and c_larceny <= 29) => 0.0872192700,
      (c_larceny > 29) => -0.0553791943,
      (c_larceny = NULL) => -0.0231795410, -0.0231795410),
   (c_fammar_p = NULL) => -0.0049595296, -0.0049595296), -0.0036142756);

// Tree: 207 
wFDN_FLA_S__lgt_207 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 1.5) => 0.1158195427,
   (c_no_teens > 1.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => -0.0268345073,
      (r_F01_inp_addr_address_score_d > 75) => 0.0026105839,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0008920838, 0.0008920838),
   (c_no_teens = NULL) => 0.0308521822, 0.0020604578),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 12.75) => 0.0113202190,
   (C_INC_100K_P > 12.75) => -0.0996339307,
   (C_INC_100K_P = NULL) => -0.0472970676, -0.0472970676),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 11.5) => 0.0326069398,
   (c_newhouse > 11.5) => -0.0640808774,
   (c_newhouse = NULL) => -0.0139464537, -0.0139464537), 0.0015054181);

// Tree: 208 
wFDN_FLA_S__lgt_208 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 17.5) => -0.0034741069,
      (f_srchssnsrchcount_i > 17.5) => 0.0600199872,
      (f_srchssnsrchcount_i = NULL) => -0.0029394472, -0.0029394472),
   (f_addrchangecrimediff_i > 98.5) => 0.0689721709,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => -0.0017380649,
      (f_srchaddrsrchcountmo_i > 0.5) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 4.4) => 0.0012864649,
         (c_hval_175k_p > 4.4) => 0.1311660920,
         (c_hval_175k_p = NULL) => 0.0617165692, 0.0617165692),
      (f_srchaddrsrchcountmo_i = NULL) => -0.0036592162, 0.0020369705), -0.0014622857),
(r_L77_Add_PO_Box_i > 0.5) => -0.0910518695,
(r_L77_Add_PO_Box_i = NULL) => -0.0035104512, -0.0035104512);

// Tree: 209 
wFDN_FLA_S__lgt_209 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => 
      map(
      (NULL < c_employees and c_employees <= 23.5) => 0.1284986216,
      (c_employees > 23.5) => 
         map(
         (NULL < c_murders and c_murders <= 98) => 0.1115241790,
         (c_murders > 98) => -0.0516727475,
         (c_murders = NULL) => -0.0114481529, -0.0114481529),
      (c_employees = NULL) => 0.0272358374, 0.0160756415),
   (f_rel_homeover200_count_d > 0.5) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 7.85) => 0.0105441900,
      (c_hval_60k_p > 7.85) => 0.1558269994,
      (c_hval_60k_p = NULL) => 0.0671046731, 0.0671046731),
   (f_rel_homeover200_count_d = NULL) => 0.0288546324, 0.0288546324),
(k_estimated_income_d > 27500) => 0.0006917598,
(k_estimated_income_d = NULL) => 0.0133135179, 0.0021523751);

// Tree: 210 
wFDN_FLA_S__lgt_210 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0153485613,
(f_corrrisktype_i > 5.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0148941745,
   (f_addrs_per_ssn_i > 5.5) => 
      map(
      (NULL < c_rich_nfam and c_rich_nfam <= 175.5) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 86.5) => 0.0362519499,
         (c_ab_av_edu > 86.5) => -0.0061856764,
         (c_ab_av_edu = NULL) => 0.0094424656, 0.0094424656),
      (c_rich_nfam > 175.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 38.8) => 0.0470509695,
         (c_rnt1000_p > 38.8) => 0.2088601743,
         (c_rnt1000_p = NULL) => 0.0692086264, 0.0692086264),
      (c_rich_nfam = NULL) => 0.0123303717, 0.0185321317),
   (f_addrs_per_ssn_i = NULL) => 0.0051486366, 0.0051486366),
(f_corrrisktype_i = NULL) => 0.0049351882, -0.0051897768);

// Tree: 211 
wFDN_FLA_S__lgt_211 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 18.5) => 0.0004493162,
   (f_rel_under100miles_cnt_d > 18.5) => -0.0405504814,
   (f_rel_under100miles_cnt_d = NULL) => 0.0144458234, -0.0017033051),
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.40689719715) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => 0.0849122869,
      (f_inq_count24_i > 2.5) => -0.0350173863,
      (f_inq_count24_i = NULL) => 0.0332092722, 0.0332092722),
   (f_add_curr_nhood_MFD_pct_i > 0.40689719715) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04125642885) => 0.0331953621,
      (f_add_curr_nhood_BUS_pct_i > 0.04125642885) => -0.0725592681,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0233286643, -0.0233286643),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1189131447, 0.0329032953),
(f_srchaddrsrchcount_i = NULL) => -0.0187182815, -0.0007143736);

// Tree: 212 
wFDN_FLA_S__lgt_212 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 22.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0047953418) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 13.5) => 
         map(
         (NULL < c_no_car and c_no_car <= 7.5) => 0.1732795049,
         (c_no_car > 7.5) => -0.0325514651,
         (c_no_car = NULL) => -0.0181711992, -0.0181711992),
      (f_rel_ageover20_count_d > 13.5) => -0.0884695638,
      (f_rel_ageover20_count_d = NULL) => -0.0327734047, -0.0327734047),
   (f_add_curr_nhood_BUS_pct_i > 0.0047953418) => 0.0037742679,
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0204297925, -0.0012950305),
(f_srchaddrsrchcount_i > 22.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.4304599763) => 0.0076512901,
   (f_add_curr_nhood_MFD_pct_i > 0.4304599763) => 0.0472220062,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0217639231, 0.0217639231),
(f_srchaddrsrchcount_i = NULL) => 0.0192892163, -0.0007954254);

// Tree: 213 
wFDN_FLA_S__lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 149006.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1761) => 
      map(
      (NULL < c_retired and c_retired <= 4.75) => 
         map(
         (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 4.5) => 0.0392945306,
         (f_rel_criminal_count_i > 4.5) => 0.2112682331,
         (f_rel_criminal_count_i = NULL) => 0.0723891263, 0.0723891263),
      (c_retired > 4.75) => 
         map(
         (NULL < c_hval_80k_p and c_hval_80k_p <= 34.6) => 0.0162295336,
         (c_hval_80k_p > 34.6) => -0.1238421121,
         (c_hval_80k_p = NULL) => 0.0112619904, 0.0112619904),
      (c_retired = NULL) => 0.0185701237, 0.0185701237),
   (f_liens_unrel_SC_total_amt_i > 1761) => 0.1511694741,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0212252969, 0.0212252969),
(r_A46_Curr_AVM_AutoVal_d > 149006.5) => -0.0069717788,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0010175993, 0.0020345922);

// Tree: 214 
wFDN_FLA_S__lgt_214 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 7.45) => 
         map(
         (NULL < c_assault and c_assault <= 35) => -0.0245221289,
         (c_assault > 35) => 0.0859011071,
         (c_assault = NULL) => 0.0546665811, 0.0546665811),
      (c_femdiv_p > 7.45) => -0.0458809839,
      (c_femdiv_p = NULL) => 0.0361123493, 0.0361123493),
   (r_I60_inq_recency_d > 2) => 0.0014631780,
   (r_I60_inq_recency_d = NULL) => 0.0035140636, 0.0035140636),
(f_inq_PrepaidCards_count24_i > 1.5) => 0.0826907901,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.95) => -0.0531132611,
   (c_pop_6_11_p > 7.95) => 0.0439342706,
   (c_pop_6_11_p = NULL) => -0.0064557940, -0.0064557940), 0.0037771469);

// Tree: 215 
wFDN_FLA_S__lgt_215 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 67.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 171.5) => -0.0271003959,
   (c_exp_prod > 171.5) => 0.0979214417,
   (c_exp_prod = NULL) => 0.0402203731, -0.0200506151),
(r_C13_max_lres_d > 67.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0042231235,
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 21.7) => 0.0608702965,
         (c_hh3_p > 21.7) => 0.2173875986,
         (c_hh3_p = NULL) => 0.0950522360, 0.0950522360),
      (k_nap_fname_verd_d > 0.5) => 0.0098646697,
      (k_nap_fname_verd_d = NULL) => 0.0316180650, 0.0316180650),
   (f_hh_collections_ct_i = NULL) => 0.0071529323, 0.0071529323),
(r_C13_max_lres_d = NULL) => -0.0096939867, 0.0015480614);

// Tree: 216 
wFDN_FLA_S__lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 180.5) => -0.0781280986,
(f_mos_liens_unrel_FT_lseen_d > 180.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 197.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1908.5) => -0.0052472635,
      (c_popover18 > 1908.5) => 
         map(
         (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 0.0164308093,
         (f_srchcomponentrisktype_i > 3.5) => 0.1392782376,
         (f_srchcomponentrisktype_i = NULL) => 0.0196832803, 0.0196832803),
      (c_popover18 = NULL) => 0.0203691090, -0.0000004332),
   (f_fp_prevaddrburglaryindex_i > 197.5) => 0.0974504080,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0006507035, 0.0006507035),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 8.1) => 0.0495746631,
   (c_newhouse > 8.1) => -0.0405826139,
   (c_newhouse = NULL) => 0.0009056905, 0.0009056905), -0.0002349702);

// Tree: 217 
wFDN_FLA_S__lgt_217 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -45425.5) => -0.1007645495,
(f_addrchangeincomediff_d > -45425.5) => 0.0016315009,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 33.35) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.99633026285) => -0.0138027674,
      (f_add_input_nhood_SFD_pct_d > 0.99633026285) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 4.5) => 0.2066118310,
         (f_rel_incomeover75_count_d > 4.5) => 0.0026856455,
         (f_rel_incomeover75_count_d = NULL) => 0.1012499685, 0.1012499685),
      (f_add_input_nhood_SFD_pct_d = NULL) => -0.0078542058, -0.0078542058),
   (c_retail > 33.35) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 111) => -0.0058050387,
      (c_for_sale > 111) => 0.1644531557,
      (c_for_sale = NULL) => 0.0774110450, 0.0774110450),
   (c_retail = NULL) => 0.0226283606, 0.0003365829), 0.0007144111);

// Tree: 218 
wFDN_FLA_S__lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_exp_homes and c_exp_homes <= 188.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 24.65) => 
         map(
         (NULL < c_white_col and c_white_col <= 19.05) => 0.0106540005,
         (c_white_col > 19.05) => 0.2231671469,
         (c_white_col = NULL) => 0.1130466983, 0.1130466983),
      (c_white_col > 24.65) => 0.0070720749,
      (c_white_col = NULL) => 0.0260577566, 0.0260577566),
   (c_exp_homes > 188.5) => 0.3094738044,
   (c_exp_homes = NULL) => 0.0373654727, 0.0466702893),
(f_rel_incomeover25_count_d > 1.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0081053005,
   (f_inq_Other_count_i > 0.5) => 0.0179568161,
   (f_inq_Other_count_i = NULL) => -0.0020431337, -0.0020431337),
(f_rel_incomeover25_count_d = NULL) => -0.0210988489, 0.0006660597);

// Tree: 219 
wFDN_FLA_S__lgt_219 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 15.45) => 
   map(
   (NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 164.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 53.55) => 0.0002313324,
      (c_famotf18_p > 53.55) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => -0.0091128462,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => 0.1305909158,
         (nf_seg_FraudPoint_3_0 = '') => 0.0613163231, 0.0613163231),
      (c_famotf18_p = NULL) => 0.0008428899, 0.0008428899),
   (f_liens_rel_SC_total_amt_i > 164.5) => -0.0794898487,
   (f_liens_rel_SC_total_amt_i = NULL) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 0.1) => 0.0451034934,
      (c_hval_100k_p > 0.1) => -0.0677298375,
      (c_hval_100k_p = NULL) => -0.0149362606, -0.0149362606), -0.0001825889),
(c_femdiv_p > 15.45) => 0.1179404832,
(c_femdiv_p = NULL) => 0.0013936034, 0.0005045418);

// Tree: 220 
wFDN_FLA_S__lgt_220 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 181.5) => -0.0669193877,
(r_D32_Mos_Since_Fel_LS_d > 181.5) => 
   map(
   (NULL < c_food and c_food <= 62.65) => -0.0044100867,
   (c_food > 62.65) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.91311896135) => 0.0050483186,
      (f_add_input_nhood_SFD_pct_d > 0.91311896135) => 
         map(
         (NULL < c_rental and c_rental <= 123.5) => 0.0457957113,
         (c_rental > 123.5) => 0.2633798848,
         (c_rental = NULL) => 0.1119124491, 0.1119124491),
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.0433501159, 0.0433501159),
   (c_food = NULL) => -0.0161606351, -0.0027358795),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 9.95) => -0.0300406518,
   (c_retail > 9.95) => 0.0703619426,
   (c_retail = NULL) => 0.0197457586, 0.0197457586), -0.0030387884);

// Tree: 221 
wFDN_FLA_S__lgt_221 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 11.25) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 30.95) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 96.5) => 0.0417311718,
         (c_new_homes > 96.5) => 
            map(
            (NULL < c_unattach and c_unattach <= 85) => 0.0622373913,
            (c_unattach > 85) => 0.2816240876,
            (c_unattach = NULL) => 0.1929358487, 0.1929358487),
         (c_new_homes = NULL) => 0.1071295136, 0.1071295136),
      (c_newhouse > 30.95) => -0.0359384233,
      (c_newhouse = NULL) => 0.0658959598, 0.0658959598),
   (f_corrssnnamecount_d > 1.5) => 0.0035757203,
   (f_corrssnnamecount_d = NULL) => -0.0169462444, 0.0065016407),
(C_INC_25K_P > 11.25) => -0.0179222742,
(C_INC_25K_P = NULL) => -0.0130893571, -0.0001095017);

// Tree: 222 
wFDN_FLA_S__lgt_222 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0033142778,
(f_addrchangecrimediff_i > 61.5) => 
   map(
   (NULL < c_health and c_health <= 11.15) => -0.0176044196,
   (c_health > 11.15) => 0.1398778028,
   (c_health = NULL) => 0.0459410385, 0.0459410385),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 984.5) => 
      map(
      (NULL < nf_vf_level and nf_vf_level <= 3.5) => -0.0338740699,
      (nf_vf_level > 3.5) => -0.0954384441,
      (nf_vf_level = NULL) => -0.0386097910, -0.0386097910),
   (c_popover18 > 984.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => -0.0282470625,
      (r_L79_adls_per_addr_c6_i > 0.5) => 0.0367722280,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0130021398, 0.0130021398),
   (c_popover18 = NULL) => 0.0169246417, -0.0018933182), -0.0023273416);

// Tree: 223 
wFDN_FLA_S__lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 44948.5) => 
   map(
   (NULL < c_pop00 and c_pop00 <= 869.5) => -0.1069533933,
   (c_pop00 > 869.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 81428.5) => -0.1058262570,
      (f_prevaddrmedianvalue_d > 81428.5) => 0.0201260271,
      (f_prevaddrmedianvalue_d = NULL) => -0.0134947022, -0.0134947022),
   (c_pop00 = NULL) => -0.0375506374, -0.0375506374),
(r_A46_Curr_AVM_AutoVal_d > 44948.5) => 
   map(
   (NULL < r_nas_ssn_verd_d and r_nas_ssn_verd_d <= 0.5) => 
      map(
      (NULL < c_rental and c_rental <= 92.5) => -0.0017024062,
      (c_rental > 92.5) => 0.1803393760,
      (c_rental = NULL) => 0.0975931113, 0.0975931113),
   (r_nas_ssn_verd_d > 0.5) => -0.0009265772,
   (r_nas_ssn_verd_d = NULL) => 0.0006830321, 0.0006830321),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0029115019, 0.0006302395);

// Tree: 224 
wFDN_FLA_S__lgt_224 := map(
(NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 8.75) => -0.0435845638,
      (c_rnt1250_p > 8.75) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 5.1) => -0.0127164001,
         (c_hval_300k_p > 5.1) => 0.1218875376,
         (c_hval_300k_p = NULL) => 0.0539445976, 0.0539445976),
      (c_rnt1250_p = NULL) => 0.0011340473, 0.0011340473),
   (c_hval_20k_p > 0.65) => 0.1506181202,
   (c_hval_20k_p = NULL) => 0.0357461313, 0.0357461313),
(f_M_Bureau_ADL_FS_all_d > 10.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 26.5) => 0.0011209350,
   (f_srchaddrsrchcount_i > 26.5) => 0.0537001713,
   (f_srchaddrsrchcount_i = NULL) => 0.0016263810, 0.0016263810),
(f_M_Bureau_ADL_FS_all_d = NULL) => 0.0193551595, 0.0025922190);

// Tree: 225 
wFDN_FLA_S__lgt_225 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 14799) => -0.0660121000,
(r_A46_Curr_AVM_AutoVal_d > 14799) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 12.5) => 0.1008417345,
   (r_C13_max_lres_d > 12.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 0.0091337775,
      (f_inq_Communications_count24_i > 1.5) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 22.8) => 0.1709573258,
         (c_rnt750_p > 22.8) => -0.0304860069,
         (c_rnt750_p = NULL) => 0.0657789485, 0.0657789485),
      (f_inq_Communications_count24_i = NULL) => 0.0100537120, 0.0100537120),
   (r_C13_max_lres_d = NULL) => 0.0109195907, 0.0109195907),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_liens_unrel_OT_lseen_d and f_mos_liens_unrel_OT_lseen_d <= 211.5) => -0.0886730732,
   (f_mos_liens_unrel_OT_lseen_d > 211.5) => -0.0053509035,
   (f_mos_liens_unrel_OT_lseen_d = NULL) => 0.0010820113, -0.0078746305), 0.0022999373);

// Tree: 226 
wFDN_FLA_S__lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 13.5) => -0.0238990241,
   (f_addrs_per_ssn_i > 13.5) => -0.1273461033,
   (f_addrs_per_ssn_i = NULL) => -0.0746083767, -0.0746083767),
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.6) => 0.1099042790,
      (r_C12_source_profile_d > 60.6) => -0.0369672669,
      (r_C12_source_profile_d = NULL) => 0.0490063209, 0.0490063209),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 5.5) => -0.0028068137,
      (f_inq_HighRiskCredit_count24_i > 5.5) => 0.0512061143,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0024086303, -0.0024086303),
   (r_D33_Eviction_Recency_d = NULL) => -0.0019013680, -0.0019013680),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0010233578, -0.0024592589);

// Tree: 227 
wFDN_FLA_S__lgt_227 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0035290024,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.45) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 9.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 1.84) => 0.1599612593,
         (c_hhsize > 1.84) => 0.0137957790,
         (c_hhsize = NULL) => 0.0234726315, 0.0234726315),
      (k_inq_per_addr_i > 9.5) => -0.0646109920,
      (k_inq_per_addr_i = NULL) => 0.0165959824, 0.0165959824),
   (c_unemp > 8.45) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 8.15) => 0.0095816728,
      (c_hval_125k_p > 8.15) => 0.1811626056,
      (c_hval_125k_p = NULL) => 0.0937534511, 0.0937534511),
   (c_unemp = NULL) => 0.0219944587, 0.0219944587),
(k_inq_per_ssn_i = NULL) => -0.0004565290, -0.0004565290);

// Tree: 228 
wFDN_FLA_S__lgt_228 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 43.5) => -0.0014455000,
(f_addrchangecrimediff_i > 43.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2112090633) => -0.0252520687,
   (f_add_curr_mobility_index_i > 0.2112090633) => -0.0571627373,
   (f_add_curr_mobility_index_i = NULL) => -0.0499279298, -0.0499279298),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 19.65) => -0.0194182084,
   (c_pop_25_34_p > 19.65) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 58.95) => -0.0248721292,
      (r_C12_source_profile_d > 58.95) => 
         map(
         (NULL < c_construction and c_construction <= 10.25) => 0.0406384343,
         (c_construction > 10.25) => 0.2458514805,
         (c_construction = NULL) => 0.0929973185, 0.0929973185),
      (r_C12_source_profile_d = NULL) => 0.0287650914, 0.0287650914),
   (c_pop_25_34_p = NULL) => 0.0006214645, -0.0081653000), -0.0039143713);

// Tree: 229 
wFDN_FLA_S__lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 11.5) => 
         map(
         (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 5.5) => -0.0017244712,
         (k_inq_per_addr_i > 5.5) => 0.0411873863,
         (k_inq_per_addr_i = NULL) => -0.0001236679, -0.0001236679),
      (f_crim_rel_under100miles_cnt_i > 11.5) => 0.0883202779,
      (f_crim_rel_under100miles_cnt_i = NULL) => 0.0317413838, 0.0006970729),
   (k_inq_adls_per_addr_i > 3.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 26.5) => -0.0134151290,
      (f_srchaddrsrchcount_i > 26.5) => -0.1275136894,
      (f_srchaddrsrchcount_i = NULL) => -0.0400693009, -0.0400693009),
   (k_inq_adls_per_addr_i = NULL) => -0.0001278562, -0.0001278562),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0645822920,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0203723597, -0.0029617330);

// Tree: 230 
wFDN_FLA_S__lgt_230 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 189) => 0.0006355124,
         (f_fp_prevaddrcrimeindex_i > 189) => 
            map(
            (NULL < c_med_yearblt and c_med_yearblt <= 1954.5) => 0.1786419636,
            (c_med_yearblt > 1954.5) => 0.0135754657,
            (c_med_yearblt = NULL) => 0.0677764053, 0.0677764053),
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0020924969, 0.0020924969),
      (f_fp_prevaddrcrimeindex_i > 197.5) => -0.0978950361,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0014969498, 0.0014969498),
   (f_bus_addr_match_count_d > 52.5) => 0.1166954872,
   (f_bus_addr_match_count_d = NULL) => 0.0020965098, 0.0020965098),
(f_inq_count24_i > 14.5) => -0.0972488141,
(f_inq_count24_i = NULL) => -0.0063038523, 0.0012497643);

// Tree: 231 
wFDN_FLA_S__lgt_231 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 12.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -268669.5) => -0.0887675247,
   (f_addrchangevaluediff_d > -268669.5) => -0.0013923471,
   (f_addrchangevaluediff_d = NULL) => 0.0075395677, 0.0001639843),
(f_srchssnsrchcount_i > 12.5) => 
   map(
   (NULL < c_employees and c_employees <= 471.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 90) => 0.1426122470,
      (f_fp_prevaddrburglaryindex_i > 90) => 0.0163133619,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0812008625, 0.0812008625),
   (c_employees > 471.5) => -0.0223561116,
   (c_employees = NULL) => 0.0460542531, 0.0460542531),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 2.75) => -0.0367532944,
   (c_hval_200k_p > 2.75) => 0.0619650770,
   (c_hval_200k_p = NULL) => 0.0074997687, 0.0074997687), 0.0008423076);

// Tree: 232 
wFDN_FLA_S__lgt_232 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 221.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 7.65) => -0.0110557392,
   (c_hval_150k_p > 7.65) => 0.1241999770,
   (c_hval_150k_p = NULL) => 0.0512795039, 0.0512795039),
(r_D32_Mos_Since_Fel_LS_d > 221.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 24.5) => -0.0021212532,
   (f_rel_homeover200_count_d > 24.5) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 11.5) => 0.1093655355,
      (f_rel_ageover40_count_d > 11.5) => -0.0322334660,
      (f_rel_ageover40_count_d = NULL) => 0.0466784776, 0.0466784776),
   (f_rel_homeover200_count_d = NULL) => -0.0170898377, -0.0016043705),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 13.35) => -0.0551532619,
   (c_hh4_p > 13.35) => 0.0551268039,
   (c_hh4_p = NULL) => -0.0059210897, -0.0059210897), -0.0011609211);

// Tree: 233 
wFDN_FLA_S__lgt_233 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0582035412,
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 15.75) => 0.0106068175,
      (c_hval_250k_p > 15.75) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.0107582822,
         (f_corrssnnamecount_d > 3.5) => 
            map(
            (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0760301811,
            (r_S66_adlperssn_count_i > 1.5) => 0.2081661575,
            (r_S66_adlperssn_count_i = NULL) => 0.1409590661, 0.1409590661),
         (f_corrssnnamecount_d = NULL) => 0.0823378601, 0.0823378601),
      (c_hval_250k_p = NULL) => 0.0220903315, 0.0285889320),
   (f_corrssnaddrcount_d > 2.5) => -0.0081353396,
   (f_corrssnaddrcount_d = NULL) => -0.0054965416, -0.0054965416),
(f_corrssnaddrcount_d = NULL) => 0.0019639083, -0.0066951013);

// Tree: 234 
wFDN_FLA_S__lgt_234 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 155.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0358166753,
   (f_util_add_curr_conv_n > 0.5) => 0.0024794372,
   (f_util_add_curr_conv_n = NULL) => -0.0138625311, -0.0138625311),
(r_C13_max_lres_d > 155.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 140.5) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 83404) => -0.1051497552,
         (f_curraddrmedianvalue_d > 83404) => 0.0571866771,
         (f_curraddrmedianvalue_d = NULL) => 0.0352762384, 0.0352762384),
      (c_unattach > 140.5) => 0.1423464044,
      (c_unattach = NULL) => -0.0391812191, 0.0351382552),
   (f_corraddrnamecount_d > 3.5) => 0.0013133500,
   (f_corraddrnamecount_d = NULL) => 0.0053743196, 0.0053743196),
(r_C13_max_lres_d = NULL) => 0.0269070281, -0.0052645966);

// Tree: 235 
wFDN_FLA_S__lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0630942593) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 1.5) => 0.0557475870,
      (r_C14_addrs_10yr_i > 1.5) => -0.0199924676,
      (r_C14_addrs_10yr_i = NULL) => 0.0083589876, 0.0083589876),
   (f_add_curr_nhood_VAC_pct_i > 0.0630942593) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 30.5) => 0.1950492184,
      (f_mos_inq_banko_cm_fseen_d > 30.5) => 0.0562349442,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0709172232, 0.0709172232),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0220617182, 0.0220617182),
(f_hh_members_ct_d > 1.5) => -0.0069498421,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 9.8) => -0.0662835608,
   (c_hh4_p > 9.8) => 0.0476316919,
   (c_hh4_p = NULL) => -0.0002318597, -0.0002318597), -0.0014551826);

// Tree: 236 
wFDN_FLA_S__lgt_236 := map(
(NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 50.5) => 0.0944901211,
(f_mos_liens_rel_CJ_lseen_d > 50.5) => 
   map(
   (NULL < c_info and c_info <= 23.35) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0011038268,
      (f_varrisktype_i > 3.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 23.95) => 0.0388023686,
         (c_oldhouse > 23.95) => -0.0437180377,
         (c_oldhouse = NULL) => -0.0282994267, -0.0282994267),
      (f_varrisktype_i = NULL) => -0.0005203806, -0.0005203806),
   (c_info > 23.35) => 0.1488099902,
   (c_info = NULL) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 0.1102597897,
      (k_estimated_income_d > 27500) => -0.0737671142,
      (k_estimated_income_d = NULL) => 0.0017936013, 0.0017936013), 0.0004443027),
(f_mos_liens_rel_CJ_lseen_d = NULL) => 0.0120659675, 0.0010982097);

// Tree: 237 
wFDN_FLA_S__lgt_237 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 14.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 48.5) => 0.1150471188,
   (c_no_teens > 48.5) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => -0.0271789820,
      (f_rel_under500miles_cnt_d > 5.5) => 0.1136525362,
      (f_rel_under500miles_cnt_d = NULL) => 0.0361941931, 0.0076835411),
   (c_no_teens = NULL) => 0.0272041916, 0.0272041916),
(r_C10_M_Hdr_FS_d > 14.5) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 0.05) => -0.0777476748,
   (c_pop_75_84_p > 0.05) => 
      map(
      (NULL < c_unattach and c_unattach <= 167.5) => -0.0006569337,
      (c_unattach > 167.5) => -0.0873578199,
      (c_unattach = NULL) => -0.0021066570, -0.0021066570),
   (c_pop_75_84_p = NULL) => 0.0029098866, -0.0034921862),
(r_C10_M_Hdr_FS_d = NULL) => -0.0052435127, -0.0025889172);

// Tree: 238 
wFDN_FLA_S__lgt_238 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 37.5) => 0.0591513148,
   (r_A50_pb_average_dollars_d > 37.5) => -0.0659049076,
   (r_A50_pb_average_dollars_d = NULL) => -0.0411412992, -0.0411412992),
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => -0.0040281522,
   (f_addrs_per_ssn_c6_i > 1.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.85) => 0.1504085421,
      (c_pop_55_64_p > 8.85) => -0.0035284814,
      (c_pop_55_64_p = NULL) => 0.0593215460, 0.0593215460),
   (f_addrs_per_ssn_c6_i = NULL) => -0.0031297214, -0.0031297214),
(f_corrssnaddrcount_d = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 85.5) => 0.0634220656,
   (c_many_cars > 85.5) => -0.0382623169,
   (c_many_cars = NULL) => 0.0098066639, 0.0098066639), -0.0039224448);

// Tree: 239 
wFDN_FLA_S__lgt_239 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 30.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 23.5) => -0.0022074887,
   (f_rel_homeover300_count_d > 23.5) => 0.1462610558,
   (f_rel_homeover300_count_d = NULL) => -0.0015785897, -0.0015785897),
(f_rel_homeover200_count_d > 30.5) => -0.0942319287,
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 33.45) => -0.0968350546,
   (c_sfdu_p > 33.45) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 17.25) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 11.3) => -0.0274720992,
         (c_hval_750k_p > 11.3) => 0.1118655155,
         (c_hval_750k_p = NULL) => 0.0180630690, 0.0180630690),
      (c_famotf18_p > 17.25) => 0.1118064969,
      (c_famotf18_p = NULL) => 0.0435077137, 0.0435077137),
   (c_sfdu_p = NULL) => -0.0005213900, -0.0005213900), -0.0022537033);

// Tree: 240 
wFDN_FLA_S__lgt_240 := map(
(NULL < c_hh2_p and c_hh2_p <= 16.95) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.45) => -0.0070889121,
   (c_pop_75_84_p > 2.45) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
         map(
         (NULL < c_larceny and c_larceny <= 50.5) => 0.2385152602,
         (c_larceny > 50.5) => 
            map(
            (NULL < k_estimated_income_d and k_estimated_income_d <= 37500) => 0.1672041964,
            (k_estimated_income_d > 37500) => 0.0254844149,
            (k_estimated_income_d = NULL) => 0.0774483348, 0.0774483348),
         (c_larceny = NULL) => 0.1146176253, 0.1146176253),
      (r_E57_br_source_count_d > 0.5) => -0.0217546890,
      (r_E57_br_source_count_d = NULL) => 0.0689019063, 0.0689019063),
   (c_pop_75_84_p = NULL) => 0.0313382631, 0.0313382631),
(c_hh2_p > 16.95) => 0.0022613761,
(c_hh2_p = NULL) => -0.0266859127, 0.0032019104);

// Tree: 241 
wFDN_FLA_S__lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0013940234,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 23.8) => 
      map(
      (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 3.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 423) => -0.0093658722,
         (r_C13_max_lres_d > 423) => 0.1626712302,
         (r_C13_max_lres_d = NULL) => 0.0151504716, 0.0151504716),
      (f_addrchangeecontrajindex_d > 3.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 11.5) => 0.0227548622,
         (c_rnt1000_p > 11.5) => 0.2427173397,
         (c_rnt1000_p = NULL) => 0.1074530576, 0.1074530576),
      (f_addrchangeecontrajindex_d = NULL) => 0.0073581896, 0.0360722284),
   (C_INC_15K_P > 23.8) => 0.1289511047,
   (C_INC_15K_P = NULL) => 0.0423527246, 0.0423527246),
(k_comb_age_d = NULL) => -0.0019487600, 0.0013111002);

// Tree: 242 
wFDN_FLA_S__lgt_242 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0022796224,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 25.9) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
         map(
         (NULL < c_retail and c_retail <= 11.55) => 0.1588299052,
         (c_retail > 11.55) => -0.0234698556,
         (c_retail = NULL) => 0.0813252165, 0.0813252165),
      (r_I60_Inq_Count12_i > 0.5) => -0.0070225463,
      (r_I60_Inq_Count12_i = NULL) => 0.0077315301, 0.0077315301),
   (c_rnt1000_p > 25.9) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 204.85) => 0.0522131225,
      (c_oldhouse > 204.85) => 0.1674936347,
      (c_oldhouse = NULL) => 0.0723201886, 0.0723201886),
   (c_rnt1000_p = NULL) => 0.0297010408, 0.0297010408),
(k_inq_per_ssn_i = NULL) => 0.0015827644, 0.0015827644);

// Tree: 243 
wFDN_FLA_S__lgt_243 := map(
(NULL < c_info and c_info <= 27.85) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 17.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 2.5) => 0.1539663221,
         (f_rel_under25miles_cnt_d > 2.5) => -0.0032994548,
         (f_rel_under25miles_cnt_d = NULL) => 0.0632802172, 0.0632802172),
      (r_C13_max_lres_d > 17.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => 0.0006822037,
         (k_comb_age_d > 63.5) => 0.0288922575,
         (k_comb_age_d = NULL) => 0.0039526160, 0.0039526160),
      (r_C13_max_lres_d = NULL) => 0.0047181662, 0.0047181662),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0486550210,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0051729136, 0.0024611612),
(c_info > 27.85) => 0.1301910520,
(c_info = NULL) => 0.0189927054, 0.0034663632);

// Tree: 244 
wFDN_FLA_S__lgt_244 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 56.05) => -0.0439736311,
   (c_fammar_p > 56.05) => -0.0075794126,
   (c_fammar_p = NULL) => 0.0067384902, -0.0099718071),
(f_curraddrcrimeindex_i > 121) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 23.55) => 0.0091835681,
   (c_hh4_p > 23.55) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 215.95) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 100.5) => -0.1082021209,
         (r_A50_pb_average_dollars_d > 100.5) => 0.1104117438,
         (r_A50_pb_average_dollars_d = NULL) => -0.0011567113, -0.0011567113),
      (c_housingcpi > 215.95) => 0.1576055810,
      (c_housingcpi = NULL) => 0.0524889948, 0.0524889948),
   (c_hh4_p = NULL) => 0.0120741163, 0.0120741163),
(f_curraddrcrimeindex_i = NULL) => -0.0009472872, -0.0041699141);

// Final Score Sum 

   wFDN_FLA_S__lgt := sum(
      wFDN_FLA_S__lgt_0, wFDN_FLA_S__lgt_1, wFDN_FLA_S__lgt_2, wFDN_FLA_S__lgt_3, wFDN_FLA_S__lgt_4, 
      wFDN_FLA_S__lgt_5, wFDN_FLA_S__lgt_6, wFDN_FLA_S__lgt_7, wFDN_FLA_S__lgt_8, wFDN_FLA_S__lgt_9, 
      wFDN_FLA_S__lgt_10, wFDN_FLA_S__lgt_11, wFDN_FLA_S__lgt_12, wFDN_FLA_S__lgt_13, wFDN_FLA_S__lgt_14, 
      wFDN_FLA_S__lgt_15, wFDN_FLA_S__lgt_16, wFDN_FLA_S__lgt_17, wFDN_FLA_S__lgt_18, wFDN_FLA_S__lgt_19, 
      wFDN_FLA_S__lgt_20, wFDN_FLA_S__lgt_21, wFDN_FLA_S__lgt_22, wFDN_FLA_S__lgt_23, wFDN_FLA_S__lgt_24, 
      wFDN_FLA_S__lgt_25, wFDN_FLA_S__lgt_26, wFDN_FLA_S__lgt_27, wFDN_FLA_S__lgt_28, wFDN_FLA_S__lgt_29, 
      wFDN_FLA_S__lgt_30, wFDN_FLA_S__lgt_31, wFDN_FLA_S__lgt_32, wFDN_FLA_S__lgt_33, wFDN_FLA_S__lgt_34, 
      wFDN_FLA_S__lgt_35, wFDN_FLA_S__lgt_36, wFDN_FLA_S__lgt_37, wFDN_FLA_S__lgt_38, wFDN_FLA_S__lgt_39, 
      wFDN_FLA_S__lgt_40, wFDN_FLA_S__lgt_41, wFDN_FLA_S__lgt_42, wFDN_FLA_S__lgt_43, wFDN_FLA_S__lgt_44, 
      wFDN_FLA_S__lgt_45, wFDN_FLA_S__lgt_46, wFDN_FLA_S__lgt_47, wFDN_FLA_S__lgt_48, wFDN_FLA_S__lgt_49, 
      wFDN_FLA_S__lgt_50, wFDN_FLA_S__lgt_51, wFDN_FLA_S__lgt_52, wFDN_FLA_S__lgt_53, wFDN_FLA_S__lgt_54, 
      wFDN_FLA_S__lgt_55, wFDN_FLA_S__lgt_56, wFDN_FLA_S__lgt_57, wFDN_FLA_S__lgt_58, wFDN_FLA_S__lgt_59, 
      wFDN_FLA_S__lgt_60, wFDN_FLA_S__lgt_61, wFDN_FLA_S__lgt_62, wFDN_FLA_S__lgt_63, wFDN_FLA_S__lgt_64, 
      wFDN_FLA_S__lgt_65, wFDN_FLA_S__lgt_66, wFDN_FLA_S__lgt_67, wFDN_FLA_S__lgt_68, wFDN_FLA_S__lgt_69, 
      wFDN_FLA_S__lgt_70, wFDN_FLA_S__lgt_71, wFDN_FLA_S__lgt_72, wFDN_FLA_S__lgt_73, wFDN_FLA_S__lgt_74, 
      wFDN_FLA_S__lgt_75, wFDN_FLA_S__lgt_76, wFDN_FLA_S__lgt_77, wFDN_FLA_S__lgt_78, wFDN_FLA_S__lgt_79, 
      wFDN_FLA_S__lgt_80, wFDN_FLA_S__lgt_81, wFDN_FLA_S__lgt_82, wFDN_FLA_S__lgt_83, wFDN_FLA_S__lgt_84, 
      wFDN_FLA_S__lgt_85, wFDN_FLA_S__lgt_86, wFDN_FLA_S__lgt_87, wFDN_FLA_S__lgt_88, wFDN_FLA_S__lgt_89, 
      wFDN_FLA_S__lgt_90, wFDN_FLA_S__lgt_91, wFDN_FLA_S__lgt_92, wFDN_FLA_S__lgt_93, wFDN_FLA_S__lgt_94, 
      wFDN_FLA_S__lgt_95, wFDN_FLA_S__lgt_96, wFDN_FLA_S__lgt_97, wFDN_FLA_S__lgt_98, wFDN_FLA_S__lgt_99, 
      wFDN_FLA_S__lgt_100, wFDN_FLA_S__lgt_101, wFDN_FLA_S__lgt_102, wFDN_FLA_S__lgt_103, wFDN_FLA_S__lgt_104, 
      wFDN_FLA_S__lgt_105, wFDN_FLA_S__lgt_106, wFDN_FLA_S__lgt_107, wFDN_FLA_S__lgt_108, wFDN_FLA_S__lgt_109, 
      wFDN_FLA_S__lgt_110, wFDN_FLA_S__lgt_111, wFDN_FLA_S__lgt_112, wFDN_FLA_S__lgt_113, wFDN_FLA_S__lgt_114, 
      wFDN_FLA_S__lgt_115, wFDN_FLA_S__lgt_116, wFDN_FLA_S__lgt_117, wFDN_FLA_S__lgt_118, wFDN_FLA_S__lgt_119, 
      wFDN_FLA_S__lgt_120, wFDN_FLA_S__lgt_121, wFDN_FLA_S__lgt_122, wFDN_FLA_S__lgt_123, wFDN_FLA_S__lgt_124, 
      wFDN_FLA_S__lgt_125, wFDN_FLA_S__lgt_126, wFDN_FLA_S__lgt_127, wFDN_FLA_S__lgt_128, wFDN_FLA_S__lgt_129, 
      wFDN_FLA_S__lgt_130, wFDN_FLA_S__lgt_131, wFDN_FLA_S__lgt_132, wFDN_FLA_S__lgt_133, wFDN_FLA_S__lgt_134, 
      wFDN_FLA_S__lgt_135, wFDN_FLA_S__lgt_136, wFDN_FLA_S__lgt_137, wFDN_FLA_S__lgt_138, wFDN_FLA_S__lgt_139, 
      wFDN_FLA_S__lgt_140, wFDN_FLA_S__lgt_141, wFDN_FLA_S__lgt_142, wFDN_FLA_S__lgt_143, wFDN_FLA_S__lgt_144, 
      wFDN_FLA_S__lgt_145, wFDN_FLA_S__lgt_146, wFDN_FLA_S__lgt_147, wFDN_FLA_S__lgt_148, wFDN_FLA_S__lgt_149, 
      wFDN_FLA_S__lgt_150, wFDN_FLA_S__lgt_151, wFDN_FLA_S__lgt_152, wFDN_FLA_S__lgt_153, wFDN_FLA_S__lgt_154, 
      wFDN_FLA_S__lgt_155, wFDN_FLA_S__lgt_156, wFDN_FLA_S__lgt_157, wFDN_FLA_S__lgt_158, wFDN_FLA_S__lgt_159, 
      wFDN_FLA_S__lgt_160, wFDN_FLA_S__lgt_161, wFDN_FLA_S__lgt_162, wFDN_FLA_S__lgt_163, wFDN_FLA_S__lgt_164, 
      wFDN_FLA_S__lgt_165, wFDN_FLA_S__lgt_166, wFDN_FLA_S__lgt_167, wFDN_FLA_S__lgt_168, wFDN_FLA_S__lgt_169, 
      wFDN_FLA_S__lgt_170, wFDN_FLA_S__lgt_171, wFDN_FLA_S__lgt_172, wFDN_FLA_S__lgt_173, wFDN_FLA_S__lgt_174, 
      wFDN_FLA_S__lgt_175, wFDN_FLA_S__lgt_176, wFDN_FLA_S__lgt_177, wFDN_FLA_S__lgt_178, wFDN_FLA_S__lgt_179, 
      wFDN_FLA_S__lgt_180, wFDN_FLA_S__lgt_181, wFDN_FLA_S__lgt_182, wFDN_FLA_S__lgt_183, wFDN_FLA_S__lgt_184, 
      wFDN_FLA_S__lgt_185, wFDN_FLA_S__lgt_186, wFDN_FLA_S__lgt_187, wFDN_FLA_S__lgt_188, wFDN_FLA_S__lgt_189, 
      wFDN_FLA_S__lgt_190, wFDN_FLA_S__lgt_191, wFDN_FLA_S__lgt_192, wFDN_FLA_S__lgt_193, wFDN_FLA_S__lgt_194, 
      wFDN_FLA_S__lgt_195, wFDN_FLA_S__lgt_196, wFDN_FLA_S__lgt_197, wFDN_FLA_S__lgt_198, wFDN_FLA_S__lgt_199, 
      wFDN_FLA_S__lgt_200, wFDN_FLA_S__lgt_201, wFDN_FLA_S__lgt_202, wFDN_FLA_S__lgt_203, wFDN_FLA_S__lgt_204, 
      wFDN_FLA_S__lgt_205, wFDN_FLA_S__lgt_206, wFDN_FLA_S__lgt_207, wFDN_FLA_S__lgt_208, wFDN_FLA_S__lgt_209, 
      wFDN_FLA_S__lgt_210, wFDN_FLA_S__lgt_211, wFDN_FLA_S__lgt_212, wFDN_FLA_S__lgt_213, wFDN_FLA_S__lgt_214, 
      wFDN_FLA_S__lgt_215, wFDN_FLA_S__lgt_216, wFDN_FLA_S__lgt_217, wFDN_FLA_S__lgt_218, wFDN_FLA_S__lgt_219, 
      wFDN_FLA_S__lgt_220, wFDN_FLA_S__lgt_221, wFDN_FLA_S__lgt_222, wFDN_FLA_S__lgt_223, wFDN_FLA_S__lgt_224, 
      wFDN_FLA_S__lgt_225, wFDN_FLA_S__lgt_226, wFDN_FLA_S__lgt_227, wFDN_FLA_S__lgt_228, wFDN_FLA_S__lgt_229, 
      wFDN_FLA_S__lgt_230, wFDN_FLA_S__lgt_231, wFDN_FLA_S__lgt_232, wFDN_FLA_S__lgt_233, wFDN_FLA_S__lgt_234, 
      wFDN_FLA_S__lgt_235, wFDN_FLA_S__lgt_236, wFDN_FLA_S__lgt_237, wFDN_FLA_S__lgt_238, wFDN_FLA_S__lgt_239, 
      wFDN_FLA_S__lgt_240, wFDN_FLA_S__lgt_241, wFDN_FLA_S__lgt_242, wFDN_FLA_S__lgt_243, wFDN_FLA_S__lgt_244); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FLA_S__lgt;
			
self.final_score_0	:= 	wFDN_FLA_S__lgt_0	;
self.final_score_1	:= 	wFDN_FLA_S__lgt_1	;
self.final_score_2	:= 	wFDN_FLA_S__lgt_2	;
self.final_score_3	:= 	wFDN_FLA_S__lgt_3	;
self.final_score_4	:= 	wFDN_FLA_S__lgt_4	;
self.final_score_5	:= 	wFDN_FLA_S__lgt_5	;
self.final_score_6	:= 	wFDN_FLA_S__lgt_6	;
self.final_score_7	:= 	wFDN_FLA_S__lgt_7	;
self.final_score_8	:= 	wFDN_FLA_S__lgt_8	;
self.final_score_9	:= 	wFDN_FLA_S__lgt_9	;
self.final_score_10	:= 	wFDN_FLA_S__lgt_10	;
self.final_score_11	:= 	wFDN_FLA_S__lgt_11	;
self.final_score_12	:= 	wFDN_FLA_S__lgt_12	;
self.final_score_13	:= 	wFDN_FLA_S__lgt_13	;
self.final_score_14	:= 	wFDN_FLA_S__lgt_14	;
self.final_score_15	:= 	wFDN_FLA_S__lgt_15	;
self.final_score_16	:= 	wFDN_FLA_S__lgt_16	;
self.final_score_17	:= 	wFDN_FLA_S__lgt_17	;
self.final_score_18	:= 	wFDN_FLA_S__lgt_18	;
self.final_score_19	:= 	wFDN_FLA_S__lgt_19	;
self.final_score_20	:= 	wFDN_FLA_S__lgt_20	;
self.final_score_21	:= 	wFDN_FLA_S__lgt_21	;
self.final_score_22	:= 	wFDN_FLA_S__lgt_22	;
self.final_score_23	:= 	wFDN_FLA_S__lgt_23	;
self.final_score_24	:= 	wFDN_FLA_S__lgt_24	;
self.final_score_25	:= 	wFDN_FLA_S__lgt_25	;
self.final_score_26	:= 	wFDN_FLA_S__lgt_26	;
self.final_score_27	:= 	wFDN_FLA_S__lgt_27	;
self.final_score_28	:= 	wFDN_FLA_S__lgt_28	;
self.final_score_29	:= 	wFDN_FLA_S__lgt_29	;
self.final_score_30	:= 	wFDN_FLA_S__lgt_30	;
self.final_score_31	:= 	wFDN_FLA_S__lgt_31	;
self.final_score_32	:= 	wFDN_FLA_S__lgt_32	;
self.final_score_33	:= 	wFDN_FLA_S__lgt_33	;
self.final_score_34	:= 	wFDN_FLA_S__lgt_34	;
self.final_score_35	:= 	wFDN_FLA_S__lgt_35	;
self.final_score_36	:= 	wFDN_FLA_S__lgt_36	;
self.final_score_37	:= 	wFDN_FLA_S__lgt_37	;
self.final_score_38	:= 	wFDN_FLA_S__lgt_38	;
self.final_score_39	:= 	wFDN_FLA_S__lgt_39	;
self.final_score_40	:= 	wFDN_FLA_S__lgt_40	;
self.final_score_41	:= 	wFDN_FLA_S__lgt_41	;
self.final_score_42	:= 	wFDN_FLA_S__lgt_42	;
self.final_score_43	:= 	wFDN_FLA_S__lgt_43	;
self.final_score_44	:= 	wFDN_FLA_S__lgt_44	;
self.final_score_45	:= 	wFDN_FLA_S__lgt_45	;
self.final_score_46	:= 	wFDN_FLA_S__lgt_46	;
self.final_score_47	:= 	wFDN_FLA_S__lgt_47	;
self.final_score_48	:= 	wFDN_FLA_S__lgt_48	;
self.final_score_49	:= 	wFDN_FLA_S__lgt_49	;
self.final_score_50	:= 	wFDN_FLA_S__lgt_50	;
self.final_score_51	:= 	wFDN_FLA_S__lgt_51	;
self.final_score_52	:= 	wFDN_FLA_S__lgt_52	;
self.final_score_53	:= 	wFDN_FLA_S__lgt_53	;
self.final_score_54	:= 	wFDN_FLA_S__lgt_54	;
self.final_score_55	:= 	wFDN_FLA_S__lgt_55	;
self.final_score_56	:= 	wFDN_FLA_S__lgt_56	;
self.final_score_57	:= 	wFDN_FLA_S__lgt_57	;
self.final_score_58	:= 	wFDN_FLA_S__lgt_58	;
self.final_score_59	:= 	wFDN_FLA_S__lgt_59	;
self.final_score_60	:= 	wFDN_FLA_S__lgt_60	;
self.final_score_61	:= 	wFDN_FLA_S__lgt_61	;
self.final_score_62	:= 	wFDN_FLA_S__lgt_62	;
self.final_score_63	:= 	wFDN_FLA_S__lgt_63	;
self.final_score_64	:= 	wFDN_FLA_S__lgt_64	;
self.final_score_65	:= 	wFDN_FLA_S__lgt_65	;
self.final_score_66	:= 	wFDN_FLA_S__lgt_66	;
self.final_score_67	:= 	wFDN_FLA_S__lgt_67	;
self.final_score_68	:= 	wFDN_FLA_S__lgt_68	;
self.final_score_69	:= 	wFDN_FLA_S__lgt_69	;
self.final_score_70	:= 	wFDN_FLA_S__lgt_70	;
self.final_score_71	:= 	wFDN_FLA_S__lgt_71	;
self.final_score_72	:= 	wFDN_FLA_S__lgt_72	;
self.final_score_73	:= 	wFDN_FLA_S__lgt_73	;
self.final_score_74	:= 	wFDN_FLA_S__lgt_74	;
self.final_score_75	:= 	wFDN_FLA_S__lgt_75	;
self.final_score_76	:= 	wFDN_FLA_S__lgt_76	;
self.final_score_77	:= 	wFDN_FLA_S__lgt_77	;
self.final_score_78	:= 	wFDN_FLA_S__lgt_78	;
self.final_score_79	:= 	wFDN_FLA_S__lgt_79	;
self.final_score_80	:= 	wFDN_FLA_S__lgt_80	;
self.final_score_81	:= 	wFDN_FLA_S__lgt_81	;
self.final_score_82	:= 	wFDN_FLA_S__lgt_82	;
self.final_score_83	:= 	wFDN_FLA_S__lgt_83	;
self.final_score_84	:= 	wFDN_FLA_S__lgt_84	;
self.final_score_85	:= 	wFDN_FLA_S__lgt_85	;
self.final_score_86	:= 	wFDN_FLA_S__lgt_86	;
self.final_score_87	:= 	wFDN_FLA_S__lgt_87	;
self.final_score_88	:= 	wFDN_FLA_S__lgt_88	;
self.final_score_89	:= 	wFDN_FLA_S__lgt_89	;
self.final_score_90	:= 	wFDN_FLA_S__lgt_90	;
self.final_score_91	:= 	wFDN_FLA_S__lgt_91	;
self.final_score_92	:= 	wFDN_FLA_S__lgt_92	;
self.final_score_93	:= 	wFDN_FLA_S__lgt_93	;
self.final_score_94	:= 	wFDN_FLA_S__lgt_94	;
self.final_score_95	:= 	wFDN_FLA_S__lgt_95	;
self.final_score_96	:= 	wFDN_FLA_S__lgt_96	;
self.final_score_97	:= 	wFDN_FLA_S__lgt_97	;
self.final_score_98	:= 	wFDN_FLA_S__lgt_98	;
self.final_score_99	:= 	wFDN_FLA_S__lgt_99	;
self.final_score_100	:= 	wFDN_FLA_S__lgt_100	;
self.final_score_101	:= 	wFDN_FLA_S__lgt_101	;
self.final_score_102	:= 	wFDN_FLA_S__lgt_102	;
self.final_score_103	:= 	wFDN_FLA_S__lgt_103	;
self.final_score_104	:= 	wFDN_FLA_S__lgt_104	;
self.final_score_105	:= 	wFDN_FLA_S__lgt_105	;
self.final_score_106	:= 	wFDN_FLA_S__lgt_106	;
self.final_score_107	:= 	wFDN_FLA_S__lgt_107	;
self.final_score_108	:= 	wFDN_FLA_S__lgt_108	;
self.final_score_109	:= 	wFDN_FLA_S__lgt_109	;
self.final_score_110	:= 	wFDN_FLA_S__lgt_110	;
self.final_score_111	:= 	wFDN_FLA_S__lgt_111	;
self.final_score_112	:= 	wFDN_FLA_S__lgt_112	;
self.final_score_113	:= 	wFDN_FLA_S__lgt_113	;
self.final_score_114	:= 	wFDN_FLA_S__lgt_114	;
self.final_score_115	:= 	wFDN_FLA_S__lgt_115	;
self.final_score_116	:= 	wFDN_FLA_S__lgt_116	;
self.final_score_117	:= 	wFDN_FLA_S__lgt_117	;
self.final_score_118	:= 	wFDN_FLA_S__lgt_118	;
self.final_score_119	:= 	wFDN_FLA_S__lgt_119	;
self.final_score_120	:= 	wFDN_FLA_S__lgt_120	;
self.final_score_121	:= 	wFDN_FLA_S__lgt_121	;
self.final_score_122	:= 	wFDN_FLA_S__lgt_122	;
self.final_score_123	:= 	wFDN_FLA_S__lgt_123	;
self.final_score_124	:= 	wFDN_FLA_S__lgt_124	;
self.final_score_125	:= 	wFDN_FLA_S__lgt_125	;
self.final_score_126	:= 	wFDN_FLA_S__lgt_126	;
self.final_score_127	:= 	wFDN_FLA_S__lgt_127	;
self.final_score_128	:= 	wFDN_FLA_S__lgt_128	;
self.final_score_129	:= 	wFDN_FLA_S__lgt_129	;
self.final_score_130	:= 	wFDN_FLA_S__lgt_130	;
self.final_score_131	:= 	wFDN_FLA_S__lgt_131	;
self.final_score_132	:= 	wFDN_FLA_S__lgt_132	;
self.final_score_133	:= 	wFDN_FLA_S__lgt_133	;
self.final_score_134	:= 	wFDN_FLA_S__lgt_134	;
self.final_score_135	:= 	wFDN_FLA_S__lgt_135	;
self.final_score_136	:= 	wFDN_FLA_S__lgt_136	;
self.final_score_137	:= 	wFDN_FLA_S__lgt_137	;
self.final_score_138	:= 	wFDN_FLA_S__lgt_138	;
self.final_score_139	:= 	wFDN_FLA_S__lgt_139	;
self.final_score_140	:= 	wFDN_FLA_S__lgt_140	;
self.final_score_141	:= 	wFDN_FLA_S__lgt_141	;
self.final_score_142	:= 	wFDN_FLA_S__lgt_142	;
self.final_score_143	:= 	wFDN_FLA_S__lgt_143	;
self.final_score_144	:= 	wFDN_FLA_S__lgt_144	;
self.final_score_145	:= 	wFDN_FLA_S__lgt_145	;
self.final_score_146	:= 	wFDN_FLA_S__lgt_146	;
self.final_score_147	:= 	wFDN_FLA_S__lgt_147	;
self.final_score_148	:= 	wFDN_FLA_S__lgt_148	;
self.final_score_149	:= 	wFDN_FLA_S__lgt_149	;
self.final_score_150	:= 	wFDN_FLA_S__lgt_150	;
self.final_score_151	:= 	wFDN_FLA_S__lgt_151	;
self.final_score_152	:= 	wFDN_FLA_S__lgt_152	;
self.final_score_153	:= 	wFDN_FLA_S__lgt_153	;
self.final_score_154	:= 	wFDN_FLA_S__lgt_154	;
self.final_score_155	:= 	wFDN_FLA_S__lgt_155	;
self.final_score_156	:= 	wFDN_FLA_S__lgt_156	;
self.final_score_157	:= 	wFDN_FLA_S__lgt_157	;
self.final_score_158	:= 	wFDN_FLA_S__lgt_158	;
self.final_score_159	:= 	wFDN_FLA_S__lgt_159	;
self.final_score_160	:= 	wFDN_FLA_S__lgt_160	;
self.final_score_161	:= 	wFDN_FLA_S__lgt_161	;
self.final_score_162	:= 	wFDN_FLA_S__lgt_162	;
self.final_score_163	:= 	wFDN_FLA_S__lgt_163	;
self.final_score_164	:= 	wFDN_FLA_S__lgt_164	;
self.final_score_165	:= 	wFDN_FLA_S__lgt_165	;
self.final_score_166	:= 	wFDN_FLA_S__lgt_166	;
self.final_score_167	:= 	wFDN_FLA_S__lgt_167	;
self.final_score_168	:= 	wFDN_FLA_S__lgt_168	;
self.final_score_169	:= 	wFDN_FLA_S__lgt_169	;
self.final_score_170	:= 	wFDN_FLA_S__lgt_170	;
self.final_score_171	:= 	wFDN_FLA_S__lgt_171	;
self.final_score_172	:= 	wFDN_FLA_S__lgt_172	;
self.final_score_173	:= 	wFDN_FLA_S__lgt_173	;
self.final_score_174	:= 	wFDN_FLA_S__lgt_174	;
self.final_score_175	:= 	wFDN_FLA_S__lgt_175	;
self.final_score_176	:= 	wFDN_FLA_S__lgt_176	;
self.final_score_177	:= 	wFDN_FLA_S__lgt_177	;
self.final_score_178	:= 	wFDN_FLA_S__lgt_178	;
self.final_score_179	:= 	wFDN_FLA_S__lgt_179	;
self.final_score_180	:= 	wFDN_FLA_S__lgt_180	;
self.final_score_181	:= 	wFDN_FLA_S__lgt_181	;
self.final_score_182	:= 	wFDN_FLA_S__lgt_182	;
self.final_score_183	:= 	wFDN_FLA_S__lgt_183	;
self.final_score_184	:= 	wFDN_FLA_S__lgt_184	;
self.final_score_185	:= 	wFDN_FLA_S__lgt_185	;
self.final_score_186	:= 	wFDN_FLA_S__lgt_186	;
self.final_score_187	:= 	wFDN_FLA_S__lgt_187	;
self.final_score_188	:= 	wFDN_FLA_S__lgt_188	;
self.final_score_189	:= 	wFDN_FLA_S__lgt_189	;
self.final_score_190	:= 	wFDN_FLA_S__lgt_190	;
self.final_score_191	:= 	wFDN_FLA_S__lgt_191	;
self.final_score_192	:= 	wFDN_FLA_S__lgt_192	;
self.final_score_193	:= 	wFDN_FLA_S__lgt_193	;
self.final_score_194	:= 	wFDN_FLA_S__lgt_194	;
self.final_score_195	:= 	wFDN_FLA_S__lgt_195	;
self.final_score_196	:= 	wFDN_FLA_S__lgt_196	;
self.final_score_197	:= 	wFDN_FLA_S__lgt_197	;
self.final_score_198	:= 	wFDN_FLA_S__lgt_198	;
self.final_score_199	:= 	wFDN_FLA_S__lgt_199	;
self.final_score_200	:= 	wFDN_FLA_S__lgt_200	;
self.final_score_201	:= 	wFDN_FLA_S__lgt_201	;
self.final_score_202	:= 	wFDN_FLA_S__lgt_202	;
self.final_score_203	:= 	wFDN_FLA_S__lgt_203	;
self.final_score_204	:= 	wFDN_FLA_S__lgt_204	;
self.final_score_205	:= 	wFDN_FLA_S__lgt_205	;
self.final_score_206	:= 	wFDN_FLA_S__lgt_206	;
self.final_score_207	:= 	wFDN_FLA_S__lgt_207	;
self.final_score_208	:= 	wFDN_FLA_S__lgt_208	;
self.final_score_209	:= 	wFDN_FLA_S__lgt_209	;
self.final_score_210	:= 	wFDN_FLA_S__lgt_210	;
self.final_score_211	:= 	wFDN_FLA_S__lgt_211	;
self.final_score_212	:= 	wFDN_FLA_S__lgt_212	;
self.final_score_213	:= 	wFDN_FLA_S__lgt_213	;
self.final_score_214	:= 	wFDN_FLA_S__lgt_214	;
self.final_score_215	:= 	wFDN_FLA_S__lgt_215	;
self.final_score_216	:= 	wFDN_FLA_S__lgt_216	;
self.final_score_217	:= 	wFDN_FLA_S__lgt_217	;
self.final_score_218	:= 	wFDN_FLA_S__lgt_218	;
self.final_score_219	:= 	wFDN_FLA_S__lgt_219	;
self.final_score_220	:= 	wFDN_FLA_S__lgt_220	;
self.final_score_221	:= 	wFDN_FLA_S__lgt_221	;
self.final_score_222	:= 	wFDN_FLA_S__lgt_222	;
self.final_score_223	:= 	wFDN_FLA_S__lgt_223	;
self.final_score_224	:= 	wFDN_FLA_S__lgt_224	;
self.final_score_225	:= 	wFDN_FLA_S__lgt_225	;
self.final_score_226	:= 	wFDN_FLA_S__lgt_226	;
self.final_score_227	:= 	wFDN_FLA_S__lgt_227	;
self.final_score_228	:= 	wFDN_FLA_S__lgt_228	;
self.final_score_229	:= 	wFDN_FLA_S__lgt_229	;
self.final_score_230	:= 	wFDN_FLA_S__lgt_230	;
self.final_score_231	:= 	wFDN_FLA_S__lgt_231	;
self.final_score_232	:= 	wFDN_FLA_S__lgt_232	;
self.final_score_233	:= 	wFDN_FLA_S__lgt_233	;
self.final_score_234	:= 	wFDN_FLA_S__lgt_234	;
self.final_score_235	:= 	wFDN_FLA_S__lgt_235	;
self.final_score_236	:= 	wFDN_FLA_S__lgt_236	;
self.final_score_237	:= 	wFDN_FLA_S__lgt_237	;
self.final_score_238	:= 	wFDN_FLA_S__lgt_238	;
self.final_score_239	:= 	wFDN_FLA_S__lgt_239	;
self.final_score_240	:= 	wFDN_FLA_S__lgt_240	;
self.final_score_241	:= 	wFDN_FLA_S__lgt_241	;
self.final_score_242	:= 	wFDN_FLA_S__lgt_242	;
self.final_score_243	:= 	wFDN_FLA_S__lgt_243	;
self.final_score_244	:= 	wFDN_FLA_S__lgt_244	;
self.FP3_wFDN_LGT		:= 	wFDN_FLA_S__lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
