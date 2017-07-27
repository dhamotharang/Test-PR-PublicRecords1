
export FP3FDN1505_FLASD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FLA_SD_lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FLA_SD_lgt_1 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 0.4486687841,
(nf_vf_hi_risk_index > 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0443053528,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 50.45) => 0.2239806171,
         (c_fammar_p > 50.45) => 0.0294572334,
         (c_fammar_p = NULL) => -0.0415916125, 0.0457669548),
      (f_inq_Communications_count_i > 0.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.1668452121,
         (f_srchvelocityrisktype_i > 5.5) => 0.4855337887,
         (f_srchvelocityrisktype_i = NULL) => 0.2853774889, 0.2853774889),
      (f_inq_Communications_count_i = NULL) => 0.0798668374, 0.0798668374),
   (nf_seg_FraudPoint_3_0 = '') => -0.0125861996, -0.0125861996),
(nf_vf_hi_risk_index = NULL) => 0.3008293658, -0.0016766067);

// Tree: 2 
wFDN_FLA_SD_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < nf_vf_level and nf_vf_level <= 3.5) => 0.1120191516,
      (nf_vf_level > 3.5) => 0.4862087155,
      (nf_vf_level = NULL) => 0.1474386218, 0.1474386218),
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0378428753,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1969440609,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0327278742, -0.0327278742),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0227735043, -0.0227735043),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0690175906,
   (f_rel_under500miles_cnt_d > 5.5) => 0.3529591375,
   (f_rel_under500miles_cnt_d = NULL) => 0.1256192300, 0.2208101070),
(f_varrisktype_i = NULL) => 0.2137325290, -0.0070685168);

// Tree: 3 
wFDN_FLA_SD_lgt_3 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0537407276,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.2677210063,
   (nf_seg_FraudPoint_3_0 = '') => 0.1321063121, 0.1321063121),
(nf_vf_hi_risk_index > 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0387429211,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0192911501,
      (f_inq_Communications_count_i > 0.5) => 
         map(
         (NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 0.0961963075,
         (f_inq_count_i > 8.5) => 0.3144130501,
         (f_inq_count_i = NULL) => 0.1503443826, 0.1503443826),
      (f_inq_Communications_count_i = NULL) => 0.0372491415, 0.0372491415),
   (nf_seg_FraudPoint_3_0 = '') => -0.0196082759, -0.0196082759),
(nf_vf_hi_risk_index = NULL) => 0.1108194097, -0.0077443831);

// Tree: 4 
wFDN_FLA_SD_lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0354979276,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 23.55) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0003104825,
         (f_varrisktype_i > 2.5) => 0.1088068814,
         (f_varrisktype_i = NULL) => 0.0202677011, 0.0202677011),
      (c_famotf18_p > 23.55) => 0.1514887355,
      (c_famotf18_p = NULL) => -0.0323638852, 0.0398586492),
   (nf_seg_FraudPoint_3_0 = '') => -0.0162572959, -0.0162572959),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < nf_vf_type and nf_vf_type <= 2.5) => 0.1610034507,
   (nf_vf_type > 2.5) => 0.3377238954,
   (nf_vf_type = NULL) => 0.1949250222, 0.1949250222),
(f_srchfraudsrchcount_i = NULL) => 0.1251960619, -0.0095975383);

// Tree: 5 
wFDN_FLA_SD_lgt_5 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.35) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0538950442,
      (f_rel_felony_count_i > 2.5) => 0.3430260863,
      (f_rel_felony_count_i = NULL) => 0.0643748748, 0.0643748748),
   (c_fammar_p > 59.35) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.3012880501,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0311037321,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0291377331, -0.0291377331),
   (c_fammar_p = NULL) => -0.0256293466, -0.0164447580),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1704818615,
   (r_I60_inq_comm_recency_d > 549) => 0.0640051930,
   (r_I60_inq_comm_recency_d = NULL) => 0.0907923801, 0.0907923801),
(f_srchvelocityrisktype_i = NULL) => 0.0940619328, -0.0060501763);

// Tree: 6 
wFDN_FLA_SD_lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.0990179615,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.2279988033,
      (r_D33_Eviction_Recency_d > 48) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => -0.0278521884,
         (f_assocsuspicousidcount_i > 14.5) => 0.2657498668,
         (f_assocsuspicousidcount_i = NULL) => -0.0259403129, -0.0259403129),
      (r_D33_Eviction_Recency_d = NULL) => -0.0236374120, -0.0236374120),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0166668665, -0.0166668665),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => 0.2270649596,
   (nf_vf_hi_risk_index > 5.5) => 0.0958750705,
   (nf_vf_hi_risk_index = NULL) => 0.1285907536, 0.1285907536),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0761563168, -0.0112261258);

// Tree: 7 
wFDN_FLA_SD_lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 50) => 0.3797528021,
      (r_F01_inp_addr_address_score_d > 50) => 0.1056640974,
      (r_F01_inp_addr_address_score_d = NULL) => 0.1457397305, 0.1457397305),
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => -0.0304576467,
      (f_divrisktype_i > 1.5) => 0.0517777238,
      (f_divrisktype_i = NULL) => -0.0198870083, -0.0198870083),
   (r_F00_dob_score_d = NULL) => 0.0066041721, -0.0137570656),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < c_employees and c_employees <= 38.5) => 0.3184818439,
   (c_employees > 38.5) => 0.0838064954,
   (c_employees = NULL) => 0.1295968073, 0.1295968073),
(f_inq_Communications_count_i = NULL) => 0.0548959527, -0.0084555560);

// Tree: 8 
wFDN_FLA_SD_lgt_8 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.1973618185,
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 13.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 0.5) => 0.2511968050,
         (f_srchaddrsrchcount_i > 0.5) => 0.0274061170,
         (f_srchaddrsrchcount_i = NULL) => 0.0483506301, 0.0483506301),
      (f_srchfraudsrchcount_i > 13.5) => 0.1955519635,
      (f_srchfraudsrchcount_i = NULL) => 0.0575507134, 0.0575507134),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0746584014, 0.0746584014),
(nf_vf_hi_risk_index > 6.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.2180422191,
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0176747950,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0153634463, -0.0153634463),
(nf_vf_hi_risk_index = NULL) => 0.0510246100, -0.0080548309);

// Tree: 9 
wFDN_FLA_SD_lgt_9 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1359598293,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0410399605,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 0.1566628884,
      (nf_seg_FraudPoint_3_0 = '') => 0.0547984429, 0.0547984429),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 3.5) => -0.0349142770,
      (f_assocsuspicousidcount_i > 3.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0091054395,
         (f_varrisktype_i > 2.5) => 0.1188708067,
         (f_varrisktype_i = NULL) => 0.0212840933, 0.0212840933),
      (f_assocsuspicousidcount_i = NULL) => -0.0233162912, -0.0233162912),
   (c_fammar_p = NULL) => -0.0396430168, -0.0122743402),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0896011075, -0.0072395251);

// Tree: 10 
wFDN_FLA_SD_lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0280534389,
      (k_inq_per_addr_i > 3.5) => 0.0549501147,
      (k_inq_per_addr_i = NULL) => -0.0192694107, -0.0192694107),
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.15) => 0.0574928380,
      (c_unemp > 9.15) => 0.2438197588,
      (c_unemp = NULL) => -0.0279825744, 0.0667797708),
   (nf_seg_FraudPoint_3_0 = '') => -0.0132917049, -0.0132917049),
(f_inq_Communications_count_i > 1.5) => 0.1235014819,
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0726727422,
   (f_addrs_per_ssn_i > 4.5) => 0.1744126590,
   (f_addrs_per_ssn_i = NULL) => 0.0386269881, 0.0386269881), -0.0081032789);

// Tree: 11 
wFDN_FLA_SD_lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1307832981,
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3128311972,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
            map(
            (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1365255838,
            (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0271273949,
            (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0253832066, -0.0253832066),
         (f_inq_HighRiskCredit_count_i > 2.5) => 0.0782586635,
         (f_inq_HighRiskCredit_count_i = NULL) => -0.0225040086, -0.0225040086),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0209832816, -0.0209832816),
   (r_F00_dob_score_d = NULL) => 0.0123079766, -0.0151396732),
(k_inq_ssns_per_addr_i > 2.5) => 0.1148639157,
(k_inq_ssns_per_addr_i = NULL) => -0.0090929947, -0.0090929947);

// Tree: 12 
wFDN_FLA_SD_lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 7.5) => 0.0246012816,
      (f_addrchangecrimediff_i > 7.5) => 0.1671547304,
      (f_addrchangecrimediff_i = NULL) => 0.0641032627, 0.0606537614),
   (f_corrssnaddrcount_d > 2.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1397319001,
      (r_C10_M_Hdr_FS_d > 7.5) => -0.0213978926,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0190401086, -0.0190401086),
   (f_corrssnaddrcount_d = NULL) => -0.0115704392, -0.0115704392),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1599787629,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0383925401,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0876383566, 0.0876383566),
(f_srchfraudsrchcount_i = NULL) => 0.0653095705, -0.0080977999);

// Tree: 13 
wFDN_FLA_SD_lgt_13 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 51.45) => 0.0589273212,
   (c_fammar_p > 51.45) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0240464039,
      (f_varrisktype_i > 3.5) => 
         map(
         (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 5.5) => 0.0255727204,
         (f_srchssnsrchcount_i > 5.5) => 0.1567256918,
         (f_srchssnsrchcount_i = NULL) => 0.0453081199, 0.0453081199),
      (f_varrisktype_i = NULL) => -0.0206555373, -0.0206555373),
   (c_fammar_p = NULL) => -0.0503049108, -0.0151347644),
(f_rel_felony_count_i > 1.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 121.5) => 0.0589780425,
   (r_pb_order_freq_d > 121.5) => -0.0133687133,
   (r_pb_order_freq_d = NULL) => 0.1696725321, 0.0951183117),
(f_rel_felony_count_i = NULL) => 0.0448679988, -0.0093875906);

// Tree: 14 
wFDN_FLA_SD_lgt_14 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => 0.1123558285,
   (r_F03_address_match_d > 3.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0176308306,
      (f_varrisktype_i > 2.5) => 0.0814957745,
      (f_varrisktype_i = NULL) => 0.0141526205, 0.0141526205),
   (r_F03_address_match_d = NULL) => 0.0509788235, 0.0509788235),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0950705628,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1042660381,
      (r_F00_input_dob_match_level_d > 4.5) => -0.0187895699,
      (r_F00_input_dob_match_level_d = NULL) => -0.0163743684, -0.0163743684),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0138796201, -0.0138796201),
(nf_vf_hi_risk_hit_type = NULL) => 0.0119071792, -0.0085081973);

// Tree: 15 
wFDN_FLA_SD_lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 61.05) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0783675229,
      (r_L79_adls_per_addr_c6_i > 4.5) => 0.2086777366,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0913985443, 0.0913985443),
   (r_F03_address_match_d > 3) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 0.0137621440,
      (r_D30_Derog_Count_i > 5.5) => 0.1459346022,
      (r_D30_Derog_Count_i = NULL) => 0.0234380195, 0.0234380195),
   (r_F03_address_match_d = NULL) => 0.0458022393, 0.0458022393),
(c_fammar_p > 61.05) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => -0.0213748075,
   (f_srchfraudsrchcount_i > 12.5) => 0.0837373536,
   (f_srchfraudsrchcount_i = NULL) => 0.0386122132, -0.0195382522),
(c_fammar_p = NULL) => -0.0284259310, -0.0091507664);

// Tree: 16 
wFDN_FLA_SD_lgt_16 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0239641413,
   (f_corrrisktype_i > 6.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0202837687,
      (f_rel_felony_count_i > 1.5) => 0.1627635817,
      (f_rel_felony_count_i = NULL) => 0.0254994531, 0.0254994531),
   (f_corrrisktype_i = NULL) => -0.0072516800, -0.0072516800),
(r_D30_Derog_Count_i > 5.5) => 
   map(
   (NULL < nf_vf_level and nf_vf_level <= 2.5) => 0.0704423050,
   (nf_vf_level > 2.5) => 0.1807555519,
   (nf_vf_level = NULL) => 0.0846357032, 0.0846357032),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0807509844,
   (r_S66_adlperssn_count_i > 1.5) => 0.1161398592,
   (r_S66_adlperssn_count_i = NULL) => 0.0205071637, 0.0205071637), -0.0025742238);

// Tree: 17 
wFDN_FLA_SD_lgt_17 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 50.5) => 0.1621872909,
      (c_born_usa > 50.5) => 0.0013140038,
      (c_born_usa = NULL) => 0.0473871628, 0.0567405766),
   (f_corrssnaddrcount_d > 1.5) => -0.0254593912,
   (f_corrssnaddrcount_d = NULL) => -0.0213144764, -0.0213144764),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 2.5) => 0.0111751603,
   (f_assocsuspicousidcount_i > 2.5) => 0.0791893704,
   (f_assocsuspicousidcount_i = NULL) => 0.0412231048, 0.0412231048),
(f_srchvelocityrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0963376314,
   (f_addrs_per_ssn_i > 3.5) => 0.1190156755,
   (f_addrs_per_ssn_i = NULL) => 0.0113390220, 0.0113390220), -0.0129957847);

// Tree: 18 
wFDN_FLA_SD_lgt_18 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 169.5) => -0.0063064263,
      (f_prevaddrageoldest_d > 169.5) => 0.1602834656,
      (f_prevaddrageoldest_d = NULL) => 0.0133936413, 0.0133936413),
   (f_hh_criminals_i > 0.5) => 0.1104456143,
   (f_hh_criminals_i = NULL) => 0.0441457959, 0.0441457959),
(r_F01_inp_addr_address_score_d > 95) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0183789820,
      (r_D33_eviction_count_i > 2.5) => 0.1071440130,
      (r_D33_eviction_count_i = NULL) => -0.0171404946, -0.0171404946),
   (f_srchaddrsrchcount_i > 14.5) => 0.0848531716,
   (f_srchaddrsrchcount_i = NULL) => -0.0140415640, -0.0140415640),
(r_F01_inp_addr_address_score_d = NULL) => 0.0191931019, -0.0078759922);

// Tree: 19 
wFDN_FLA_SD_lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 2.5) => -0.0085974060,
   (k_inq_per_addr_i > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => 0.0301862417,
      (k_comb_age_d > 63.5) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 5) => 0.0815557876,
         (c_hval_125k_p > 5) => 0.3477674962,
         (c_hval_125k_p = NULL) => 0.1830490015, 0.1830490015),
      (k_comb_age_d = NULL) => 0.0427071612, 0.0427071612),
   (k_inq_per_addr_i = NULL) => -0.0003949404, -0.0003949404),
(f_inq_PrepaidCards_count_i > 1.5) => 0.1304869347,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 106) => -0.0784597145,
   (c_burglary > 106) => 0.0865514181,
   (c_burglary = NULL) => 0.0040458518, 0.0040458518), 0.0009941562);

// Tree: 20 
wFDN_FLA_SD_lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1220218927,
   (r_F00_input_dob_match_level_d > 4.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0209604355,
      (k_inq_per_addr_i > 3.5) => 0.0510021894,
      (k_inq_per_addr_i = NULL) => -0.0140640446, -0.0140640446),
   (r_F00_input_dob_match_level_d = NULL) => -0.0112686739, -0.0112686739),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 11.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45373.5) => 0.0976163557,
      (f_curraddrmedianincome_d > 45373.5) => 0.0189618149,
      (f_curraddrmedianincome_d = NULL) => 0.0434744252, 0.0434744252),
   (f_assocsuspicousidcount_i > 11.5) => 0.1935232769,
   (f_assocsuspicousidcount_i = NULL) => 0.0495722014, 0.0495722014),
(f_varrisktype_i = NULL) => 0.0271009270, -0.0043266651);

// Tree: 21 
wFDN_FLA_SD_lgt_21 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.0395202488,
   (f_corrssnaddrcount_d > 2.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 147.5) => -0.0295400324,
      (c_bel_edu > 147.5) => 0.0241911169,
      (c_bel_edu = NULL) => -0.0406610543, -0.0204147257),
   (f_corrssnaddrcount_d = NULL) => -0.0149721143, -0.0149721143),
(f_assocrisktype_i > 7.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 118.5) => 0.1979951630,
   (f_M_Bureau_ADL_FS_all_d > 118.5) => 0.0294453293,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0501771661, 0.0501771661),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0858876724,
   (r_S66_adlperssn_count_i > 1.5) => 0.0635184193,
   (r_S66_adlperssn_count_i = NULL) => -0.0091656253, -0.0091656253), -0.0107457931);

// Tree: 22 
wFDN_FLA_SD_lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1701830813,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 2.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0227349201,
         (f_assocrisktype_i > 3.5) => 
            map(
            (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.0957804832,
            (r_F01_inp_addr_address_score_d > 25) => 0.0172229212,
            (r_F01_inp_addr_address_score_d = NULL) => 0.0226608781, 0.0226608781),
         (f_assocrisktype_i = NULL) => -0.0122214246, -0.0122214246),
      (f_inq_Communications_count_i > 2.5) => 0.0896314457,
      (f_inq_Communications_count_i = NULL) => -0.0106981602, -0.0106981602),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0097381922, -0.0097381922),
(r_D33_eviction_count_i > 2.5) => 0.1306209048,
(r_D33_eviction_count_i = NULL) => -0.0084248493, -0.0082326188);

// Tree: 23 
wFDN_FLA_SD_lgt_23 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 0.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 4.5) => 0.0464799249,
      (f_rel_educationover12_count_d > 4.5) => 0.3555446911,
      (f_rel_educationover12_count_d = NULL) => 0.2054275189, 0.2054275189),
   (f_util_adl_count_n > 0.5) => 0.0120093592,
   (f_util_adl_count_n = NULL) => 0.0974551326, 0.0974551326),
(r_F00_input_dob_match_level_d > 4.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => -0.0078273441,
      (f_assocsuspicousidcount_i > 16.5) => 0.1474018360,
      (f_assocsuspicousidcount_i = NULL) => -0.0070929810, -0.0070929810),
   (r_D33_eviction_count_i > 3.5) => 0.1186014026,
   (r_D33_eviction_count_i = NULL) => -0.0062781065, -0.0062781065),
(r_F00_input_dob_match_level_d = NULL) => 0.0235837471, -0.0040158823);

// Tree: 24 
wFDN_FLA_SD_lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => -0.0159396038,
   (c_unemp > 8.95) => 0.0765900278,
   (c_unemp = NULL) => -0.0298672498, -0.0121101063),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < nf_vf_lexid_lo_summary and nf_vf_lexid_lo_summary <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 60.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 99750) => 0.1498861349,
         (r_L80_Inp_AVM_AutoVal_d > 99750) => 0.0456062798,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0208914329, 0.0487362397),
      (k_comb_age_d > 60.5) => 0.2153559450,
      (k_comb_age_d = NULL) => 0.0659727609, 0.0659727609),
   (nf_vf_lexid_lo_summary > 0.5) => -0.0252749077,
   (nf_vf_lexid_lo_summary = NULL) => 0.0449777221, 0.0449777221),
(k_inq_per_addr_i = NULL) => -0.0059625325, -0.0059625325);

// Tree: 25 
wFDN_FLA_SD_lgt_25 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0114835573,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1279229021) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 16.5) => 0.1750670329,
         (r_D32_Mos_Since_Crim_LS_d > 16.5) => 0.0068390663,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0136958632, 0.0136958632),
      (f_add_curr_nhood_BUS_pct_i > 0.1279229021) => 0.1302910925,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0414252865, 0.0289982968),
   (f_srchcomponentrisktype_i > 2.5) => 0.1653834801,
   (f_srchcomponentrisktype_i = NULL) => 0.0373098593, 0.0373098593),
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 82) => -0.0655799941,
   (c_assault > 82) => 0.0863861622,
   (c_assault = NULL) => 0.0118929483, 0.0118929483), -0.0043396743);

// Tree: 26 
wFDN_FLA_SD_lgt_26 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 27.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => -0.0082062797,
   (r_D30_Derog_Count_i > 11.5) => 0.1087073643,
   (r_D30_Derog_Count_i = NULL) => -0.0118749030, -0.0067801962),
(c_famotf18_p > 27.05) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 38500) => 
      map(
      (NULL < c_robbery and c_robbery <= 172.5) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 22.5) => 0.0891201790,
         (c_vacant_p > 22.5) => 0.2865259253,
         (c_vacant_p = NULL) => 0.1147008748, 0.1147008748),
      (c_robbery > 172.5) => 0.0055469455,
      (c_robbery = NULL) => 0.0812146693, 0.0812146693),
   (k_estimated_income_d > 38500) => 0.0124823600,
   (k_estimated_income_d = NULL) => 0.0481168613, 0.0481168613),
(c_famotf18_p = NULL) => 0.0011062680, -0.0016125308);

// Tree: 27 
wFDN_FLA_SD_lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 151.5) => 0.0226017387,
      (c_born_usa > 151.5) => 0.1246912985,
      (c_born_usa = NULL) => 0.0433958251, 0.0433958251),
   (f_srchcomponentrisktype_i > 2.5) => 0.1787914202,
   (f_srchcomponentrisktype_i = NULL) => 0.0509832111, 0.0509832111),
(c_fammar_p > 50.45) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0876920806,
      (r_F00_dob_score_d > 92) => -0.0174860158,
      (r_F00_dob_score_d = NULL) => -0.0139275042, -0.0146084049),
   (r_D33_eviction_count_i > 0.5) => 0.0671030811,
   (r_D33_eviction_count_i = NULL) => 0.0038918669, -0.0116792915),
(c_fammar_p = NULL) => -0.0173331306, -0.0066427970);

// Tree: 28 
wFDN_FLA_SD_lgt_28 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1244003608,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 4.5) => 0.0985944686,
         (r_I60_inq_hiRiskCred_recency_d > 4.5) => -0.0110900981,
         (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0101736161, -0.0101736161),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0093910793, -0.0093910793),
   (r_D33_eviction_count_i > 0.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => 0.0322364565,
      (f_phones_per_addr_curr_i > 8.5) => 0.1339328591,
      (f_phones_per_addr_curr_i = NULL) => 0.0537893978, 0.0537893978),
   (r_D33_eviction_count_i = NULL) => -0.0076802773, -0.0069452573),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.2024106560,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0059550046, -0.0059550046);

// Tree: 29 
wFDN_FLA_SD_lgt_29 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 29.45) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 118.5) => 0.0055559980,
      (c_born_usa > 118.5) => 0.2002811504,
      (c_born_usa = NULL) => 0.0894892533, 0.0894892533),
   (c_fammar_p > 29.45) => -0.0180058073,
   (c_fammar_p = NULL) => -0.0394265529, -0.0171877371),
(f_hh_lienholders_i > 0.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0110673980,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID']) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 135.5) => 0.0476585248,
      (f_prevaddrageoldest_d > 135.5) => 0.1794512858,
      (f_prevaddrageoldest_d = NULL) => 0.0713596753, 0.0713596753),
   (nf_seg_FraudPoint_3_0 = '') => 0.0166934508, 0.0166934508),
(f_hh_lienholders_i = NULL) => -0.0088784055, -0.0066120871);

// Tree: 30 
wFDN_FLA_SD_lgt_30 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 92) => 0.1671945614,
(r_D32_Mos_Since_Fel_LS_d > 92) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 29.5) => -0.0146903944,
      (f_addrchangecrimediff_i > 29.5) => 
         map(
         (NULL < c_child and c_child <= 27.65) => 0.0281531331,
         (c_child > 27.65) => 0.1821820933,
         (c_child = NULL) => 0.0534197133, 0.0534197133),
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => -0.0030072365,
         (f_srchaddrsrchcountmo_i > 0.5) => 0.1134489055,
         (f_srchaddrsrchcountmo_i = NULL) => 0.0023617624, 0.0023617624), -0.0092208365),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1290185289,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0086686741, -0.0086686741),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0016127139, -0.0077109565);

// Tree: 31 
wFDN_FLA_SD_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1114764706,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 8.35) => -0.0122479273,
         (c_unemp > 8.35) => 0.0430467406,
         (c_unemp = NULL) => -0.0408678173, -0.0091799368),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0085524288, -0.0085524288),
   (k_comb_age_d > 69.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 59.45) => 0.2124558110,
      (c_fammar_p > 59.45) => 0.0635007062,
      (c_fammar_p = NULL) => 0.0807320165, 0.0807320165),
   (k_comb_age_d = NULL) => -0.0028981751, -0.0028981751),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1555125605,
(f_inq_PrepaidCards_count_i = NULL) => 0.0061023865, -0.0021464809);

// Tree: 32 
wFDN_FLA_SD_lgt_32 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 4.255) => -0.0120593704,
      (c_hhsize > 4.255) => 0.1638978298,
      (c_hhsize = NULL) => -0.0203115136, -0.0105914062),
   (f_srchaddrsrchcount_i > 14.5) => 0.0611871291,
   (f_srchaddrsrchcount_i = NULL) => -0.0089342542, -0.0089342542),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => 0.0224018760,
   (f_rel_under100miles_cnt_d > 8.5) => 0.1060155231,
   (f_rel_under100miles_cnt_d = NULL) => 0.0516779414, 0.0516779414),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0718528560,
   (k_comb_age_d > 27.5) => 0.0977734858,
   (k_comb_age_d = NULL) => 0.0258979173, 0.0258979173), -0.0032012466);

// Tree: 33 
wFDN_FLA_SD_lgt_33 := map(
(NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0217821218,
(f_crim_rel_under100miles_cnt_i > 0.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 36.5) => 0.0111239090,
   (r_pb_order_freq_d > 36.5) => -0.0152571875,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 5.5) => 0.0213253415,
         (f_srchaddrsrchcount_i > 5.5) => 
            map(
            (NULL < c_hh00 and c_hh00 <= 350.5) => 0.2244241885,
            (c_hh00 > 350.5) => 0.0567612277,
            (c_hh00 = NULL) => 0.0918656601, 0.0918656601),
         (f_srchaddrsrchcount_i = NULL) => 0.0331003454, 0.0331003454),
      (r_L79_adls_per_addr_c6_i > 4.5) => 0.1477528484,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0421345685, 0.0421345685), 0.0127129740),
(f_crim_rel_under100miles_cnt_i = NULL) => 0.0117374762, -0.0052921272);

// Tree: 34 
wFDN_FLA_SD_lgt_34 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
   map(
   (NULL < c_unempl and c_unempl <= 71) => -0.0104295312,
   (c_unempl > 71) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => -0.0008147043,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 
         map(
         (NULL < c_young and c_young <= 20.3) => 0.3331298244,
         (c_young > 20.3) => 0.0956366729,
         (c_young = NULL) => 0.1919176802, 0.1919176802),
      (nf_seg_FraudPoint_3_0 = '') => 0.1180369328, 0.1180369328),
   (c_unempl = NULL) => 0.0771612397, 0.0771612397),
(r_F00_dob_score_d > 95) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1359842542,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0055692892,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0049191326, -0.0049191326),
(r_F00_dob_score_d = NULL) => 0.0152725818, -0.0015294388);

// Tree: 35 
wFDN_FLA_SD_lgt_35 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 632) => -0.0181120822,
      (c_med_rent > 632) => 
         map(
         (NULL < c_hval_400k_p and c_hval_400k_p <= 21.8) => 
            map(
            (NULL < r_L70_inp_addr_dirty_i and r_L70_inp_addr_dirty_i <= 0.5) => 0.1751672441,
            (r_L70_inp_addr_dirty_i > 0.5) => -0.0021907024,
            (r_L70_inp_addr_dirty_i = NULL) => 0.1335266827, 0.1335266827),
         (c_hval_400k_p > 21.8) => -0.0357009494,
         (c_hval_400k_p = NULL) => 0.0868431980, 0.0868431980),
      (c_med_rent = NULL) => 0.0426176798, 0.0433451287),
   (f_corrssnaddrcount_d > 1.5) => -0.0092115382,
   (f_corrssnaddrcount_d = NULL) => -0.0065865020, -0.0065865020),
(f_hh_tot_derog_i > 5.5) => 0.0767085796,
(f_hh_tot_derog_i = NULL) => 0.0033688001, -0.0040884380);

// Tree: 36 
wFDN_FLA_SD_lgt_36 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.0997647809,
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => -0.0130786995,
      (f_rel_felony_count_i > 4.5) => 0.1225711410,
      (f_rel_felony_count_i = NULL) => -0.0123806532, -0.0123806532),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0106023404, -0.0106023404),
(f_srchcomponentrisktype_i > 2.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 2037) => 
      map(
      (NULL < c_food and c_food <= 0.35) => 0.1713327620,
      (c_food > 0.35) => 0.0076176791,
      (c_food = NULL) => 0.0265358665, 0.0265358665),
   (c_popover18 > 2037) => 0.1885721049,
   (c_popover18 = NULL) => 0.0527875476, 0.0527875476),
(f_srchcomponentrisktype_i = NULL) => -0.0141841996, -0.0079162333);

// Tree: 37 
wFDN_FLA_SD_lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0097080886,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0215846281,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 3.3) => 0.1569814065,
      (c_rnt500_p > 3.3) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 2.95) => 0.0879981638,
         (c_rnt1250_p > 2.95) => -0.0754422146,
         (c_rnt1250_p = NULL) => 0.0171739998, 0.0171739998),
      (c_rnt500_p = NULL) => 0.0778451386, 0.0778451386),
   (f_varrisktype_i = NULL) => 0.0246673958, 0.0246673958),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0863940507,
   (k_comb_age_d > 26.5) => 0.0667141416,
   (k_comb_age_d = NULL) => 0.0009254652, 0.0009254652), 0.0010817620);

// Tree: 38 
wFDN_FLA_SD_lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 95.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 109) => 0.0914439878,
         (c_burglary > 109) => 0.2348506747,
         (c_burglary = NULL) => 0.1537947212, 0.1537947212),
      (c_rest_indx > 95.5) => 0.0027605057,
      (c_rest_indx = NULL) => 0.0652386884, 0.0652386884),
   (r_F00_input_dob_match_level_d > 5.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0224882311,
      (f_crim_rel_under25miles_cnt_i > 0.5) => 0.0126452046,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.0137472280, -0.0076921417),
   (r_F00_input_dob_match_level_d = NULL) => -0.0059662442, -0.0059662442),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1080610166,
(f_inq_PrepaidCards_count_i = NULL) => 0.0057654109, -0.0052541745);

// Tree: 39 
wFDN_FLA_SD_lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0057945084,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 100.5) => 
            map(
            (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.3020093377,
            (f_curraddractivephonelist_d > 0.5) => 0.1103152507,
            (f_curraddractivephonelist_d = NULL) => 0.2118003556, 0.2118003556),
         (c_medi_indx > 100.5) => 0.0153519656,
         (c_medi_indx = NULL) => 0.1059081008, 0.1059081008),
      (f_inq_count_i > 2.5) => 0.0129670152,
      (f_inq_count_i = NULL) => 0.0302658024, 0.0302658024),
   (k_comb_age_d > 69.5) => 0.2970989565,
   (k_comb_age_d = NULL) => 0.0414861190, 0.0414861190),
(k_inq_per_ssn_i = NULL) => -0.0001215786, -0.0001215786);

// Tree: 40 
wFDN_FLA_SD_lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 28.5) => 0.0055369647,
   (r_pb_order_freq_d > 28.5) => -0.0299274027,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 8.5) => 0.0070932505,
      (f_crim_rel_under500miles_cnt_i > 8.5) => 0.1210723746,
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0386372436, 0.0105916831), -0.0066001569),
(f_addrchangecrimediff_i > 98.5) => 0.1099156007,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0009012296,
   (r_L79_adls_per_addr_c6_i > 4.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 56309.5) => 0.1198772777,
      (f_curraddrmedianincome_d > 56309.5) => -0.0092280971,
      (f_curraddrmedianincome_d = NULL) => 0.0658331673, 0.0658331673),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0049921463, 0.0049921463), -0.0032176946);

// Tree: 41 
wFDN_FLA_SD_lgt_41 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 36.5) => -0.0078550832,
   (r_pb_order_freq_d > 36.5) => -0.0313384656,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 0.5) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 0.1270905232,
         (r_D32_Mos_Since_Crim_LS_d > 14.5) => 
            map(
            (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 16.5) => 0.0098330126,
            (f_rel_homeover300_count_d > 16.5) => 0.1408920615,
            (f_rel_homeover300_count_d = NULL) => 0.1188058810, 0.0153932867),
         (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0005374032, 0.0184701792),
      (r_S65_SSN_Problem_i > 0.5) => -0.0607400748,
      (r_S65_SSN_Problem_i = NULL) => 0.0108499941, 0.0108499941), -0.0093161627),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1425412917,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0087175446, -0.0087175446);

// Tree: 42 
wFDN_FLA_SD_lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1316720227,
(r_D32_Mos_Since_Fel_LS_d > 125) => 
   map(
   (NULL < c_employees and c_employees <= 40.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.75) => 0.0241298509,
      (c_unemp > 9.75) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 7764) => -0.0101340801,
         (r_A50_pb_total_dollars_d > 7764) => 0.1532222029,
         (r_A50_pb_total_dollars_d = NULL) => 0.0949549937, 0.0949549937),
      (c_unemp = NULL) => 0.0314453426, 0.0314453426),
   (c_employees > 40.5) => -0.0097677914,
   (c_employees = NULL) => -0.0441031611, -0.0055075423),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 98.5) => 0.0564744460,
   (c_many_cars > 98.5) => -0.0758293183,
   (c_many_cars = NULL) => -0.0127119262, -0.0127119262), -0.0047839791);

// Tree: 43 
wFDN_FLA_SD_lgt_43 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0060316807,
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 11.5) => 0.1693265342,
   (r_C21_M_Bureau_ADL_FS_d > 11.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => 0.0029986029,
      (f_crim_rel_under100miles_cnt_i > 0.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 9.25) => 
            map(
            (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.05072530865) => 0.0804669777,
            (f_add_input_nhood_VAC_pct_i > 0.05072530865) => -0.0455149546,
            (f_add_input_nhood_VAC_pct_i = NULL) => 0.0476771597, 0.0476771597),
         (c_unemp > 9.25) => 0.1418578223,
         (c_unemp = NULL) => 0.0562238035, 0.0562238035),
      (f_crim_rel_under100miles_cnt_i = NULL) => 0.0303147268, 0.0303147268),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0366118429, 0.0366118429),
(f_phones_per_addr_curr_i = NULL) => -0.0008627606, -0.0020556729);

// Tree: 44 
wFDN_FLA_SD_lgt_44 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -42987.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 44.5) => 0.0127148558,
   (k_comb_age_d > 44.5) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 102.5) => 0.2801712921,
      (c_retired2 > 102.5) => 0.0585228179,
      (c_retired2 = NULL) => 0.1715200793, 0.1715200793),
   (k_comb_age_d = NULL) => 0.0627090928, 0.0627090928),
(f_addrchangevaluediff_d > -42987.5) => 
   map(
   (NULL < r_L70_inp_addr_dnd_i and r_L70_inp_addr_dnd_i <= 0.5) => -0.0116672626,
   (r_L70_inp_addr_dnd_i > 0.5) => -0.0011237301,
   (r_L70_inp_addr_dnd_i = NULL) => 0.0450732303, -0.0065956735),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => -0.0141251137,
   (r_L79_adls_per_addr_curr_i > 5.5) => 0.0869350114,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0086260767, -0.0056573298), -0.0046139307);

// Tree: 45 
wFDN_FLA_SD_lgt_45 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0075439195,
(f_corrrisktype_i > 7.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1956.5) => 0.1713508348,
         (c_med_yearblt > 1956.5) => 
            map(
            (NULL < c_bel_edu and c_bel_edu <= 124.5) => 0.1131856595,
            (c_bel_edu > 124.5) => -0.0352270705,
            (c_bel_edu = NULL) => 0.0556047643, 0.0556047643),
         (c_med_yearblt = NULL) => 0.0882860077, 0.0882860077),
      (r_I60_inq_comm_recency_d > 549) => 0.0094618099,
      (r_I60_inq_comm_recency_d = NULL) => 0.0184889795, 0.0184889795),
   (r_C12_source_profile_d > 81.3) => 0.1590200044,
   (r_C12_source_profile_d = NULL) => 0.0237645052, 0.0237645052),
(f_corrrisktype_i = NULL) => 0.0051470766, -0.0012486290);

// Tree: 46 
wFDN_FLA_SD_lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 222.35) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0154740448,
      (f_srchcomponentrisktype_i > 1.5) => 0.0475882340,
      (f_srchcomponentrisktype_i = NULL) => -0.0113416408, -0.0113416408),
   (c_housingcpi > 222.35) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 71703.5) => 0.1809313161,
      (r_A46_Curr_AVM_AutoVal_d > 71703.5) => 0.0263276738,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0177973030, 0.0262252219),
   (c_housingcpi = NULL) => -0.0066738345, -0.0022579871),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 7.05) => 0.1894127599,
   (C_INC_15K_P > 7.05) => 0.0262792157,
   (C_INC_15K_P = NULL) => 0.0771995127, 0.0771995127),
(r_D32_felony_count_i = NULL) => -0.0189219269, -0.0013148963);

// Tree: 47 
wFDN_FLA_SD_lgt_47 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 0.0264735405,
   (f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0112484520,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0036780737, -0.0058281888),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 23.1) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 57.25) => 0.0136415259,
      (c_low_ed > 57.25) => 
         map(
         (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 0.5) => 0.0688680487,
         (k_inq_per_addr_i > 0.5) => 0.2935002424,
         (k_inq_per_addr_i = NULL) => 0.1400248305, 0.1400248305),
      (c_low_ed = NULL) => 0.0391399120, 0.0391399120),
   (c_hval_500k_p > 23.1) => 0.3422372880,
   (c_hval_500k_p = NULL) => 0.0654962055, 0.0654962055),
(k_comb_age_d = NULL) => -0.0007789727, -0.0007789727);

// Tree: 48 
wFDN_FLA_SD_lgt_48 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 124896) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.2046256718,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -30664) => 0.1240234097,
      (f_addrchangevaluediff_d > -30664) => 0.0070550251,
      (f_addrchangevaluediff_d = NULL) => 0.0454209440, 0.0175504560),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0228076069, 0.0228076069),
(r_L80_Inp_AVM_AutoVal_d > 124896) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 7.5) => 0.1373879362,
   (f_M_Bureau_ADL_FS_all_d > 7.5) => -0.0071273244,
   (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0053595537, -0.0053595537),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 91.1) => -0.0283162443,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 91.1) => 0.0569384273,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0147457638, -0.0091621588), -0.0027914848);

// Tree: 49 
wFDN_FLA_SD_lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => -0.0017145671,
      (f_hh_criminals_i > 3.5) => 0.1296558543,
      (f_hh_criminals_i = NULL) => -0.0002222392, -0.0002222392),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 33) => 0.1461303732,
      (r_C10_M_Hdr_FS_d > 33) => 0.0310060365,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0567092186, 0.0567092186),
   (f_varrisktype_i = NULL) => 0.0022928430, 0.0022928430),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0721494407,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0771606821,
   (k_comb_age_d > 27.5) => 0.0866566282,
   (k_comb_age_d = NULL) => 0.0070882203, 0.0070882203), -0.0006897555);

// Tree: 50 
wFDN_FLA_SD_lgt_50 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 153.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0173230331,
   (f_nae_nothing_found_i > 0.5) => 0.2706011977,
   (f_nae_nothing_found_i = NULL) => -0.0147247320, -0.0147247320),
(r_A50_pb_average_dollars_d > 153.5) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 0.0136705992,
   (f_hh_members_w_derog_i > 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 85.5) => 0.2664490291,
      (c_easiqlife > 85.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 0.05) => -0.0461007338,
         (c_hh7p_p > 0.05) => 0.1371130863,
         (c_hh7p_p = NULL) => 0.0564230619, 0.0564230619),
      (c_easiqlife = NULL) => 0.1043089824, 0.1043089824),
   (f_hh_members_w_derog_i = NULL) => 0.0179032563, 0.0179032563),
(r_A50_pb_average_dollars_d = NULL) => 0.0227299199, -0.0002963443);

// Tree: 51 
wFDN_FLA_SD_lgt_51 := map(
(NULL < c_employees and c_employees <= 71.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 3.1) => 0.0407929788,
      (c_hh7p_p > 3.1) => 0.2198911292,
      (c_hh7p_p = NULL) => 0.0851712815, 0.0851712815),
   (f_prevaddrlenofres_d > 3.5) => 0.0177670288,
   (f_prevaddrlenofres_d = NULL) => 0.0235768538, 0.0235768538),
(c_employees > 71.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 135.5) => -0.0246954564,
   (c_easiqlife > 135.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62054.5) => 0.1289944141,
      (f_addrchangevaluediff_d > -62054.5) => 0.0072124969,
      (f_addrchangevaluediff_d = NULL) => 0.0226836952, 0.0130523922),
   (c_easiqlife = NULL) => -0.0113649360, -0.0113649360),
(c_employees = NULL) => -0.0172267537, -0.0042108203);

// Tree: 52 
wFDN_FLA_SD_lgt_52 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0019450771,
      (f_rel_felony_count_i > 0.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 207.55) => 0.2200637043,
         (c_cpiall > 207.55) => 0.0362335704,
         (c_cpiall = NULL) => 0.0495897889, 0.0495897889),
      (f_rel_felony_count_i = NULL) => 0.0071908704, 0.0071908704),
   (f_dl_addrs_per_adl_i > 0.5) => -0.0274130977,
   (f_dl_addrs_per_adl_i = NULL) => -0.0063797292, -0.0063797292),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.45) => 0.0240081588,
   (c_unemp > 9.45) => 0.1359877167,
   (c_unemp = NULL) => 0.0310251546, 0.0310251546),
(f_phones_per_addr_curr_i = NULL) => 0.0109111280, -0.0028074315);

// Tree: 53 
wFDN_FLA_SD_lgt_53 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 0.0189502211,
      (r_Ever_Asset_Owner_d > 0.5) => -0.0157658878,
      (r_Ever_Asset_Owner_d = NULL) => 0.0005448343, -0.0075689285),
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 16.5) => 0.2363048804,
      (c_born_usa > 16.5) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 162.5) => 0.0248047754,
         (f_curraddrmurderindex_i > 162.5) => 0.1957574849,
         (f_curraddrmurderindex_i = NULL) => 0.0421539365, 0.0421539365),
      (c_born_usa = NULL) => 0.0555590650, 0.0555590650),
   (k_comb_age_d = NULL) => -0.0031218876, -0.0031218876),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1178821675,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0026353912, -0.0026353912);

// Tree: 54 
wFDN_FLA_SD_lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1703144834,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_unempl and c_unempl <= 190.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 28.05) => -0.0096760943,
      (c_hval_750k_p > 28.05) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 29.45) => 0.0230648943,
         (c_hh3_p > 29.45) => 0.2003046714,
         (c_hh3_p = NULL) => 0.0322107191, 0.0322107191),
      (c_hval_750k_p = NULL) => -0.0038492653, -0.0038492653),
   (c_unempl > 190.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 140.5) => -0.0144543288,
      (f_fp_prevaddrburglaryindex_i > 140.5) => 0.1607737066,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0759410863, 0.0759410863),
   (c_unempl = NULL) => -0.0214146311, -0.0034593637),
(f_attr_arrest_recency_d = NULL) => 0.0076956548, -0.0026908639);

// Tree: 55 
wFDN_FLA_SD_lgt_55 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 40627.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 79.5) => 
         map(
         (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
            map(
            (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => 0.1689234967,
            (k_comb_age_d > 24.5) => 0.0338720729,
            (k_comb_age_d = NULL) => 0.0625325036, 0.0625325036),
         (r_I60_inq_comm_recency_d > 549) => 0.0052310973,
         (r_I60_inq_comm_recency_d = NULL) => 0.0129792440, 0.0129792440),
      (k_comb_age_d > 79.5) => 0.2597854348,
      (k_comb_age_d = NULL) => 0.0183331852, 0.0183331852),
   (f_curraddrmedianincome_d > 40627.5) => -0.0126349875,
   (f_curraddrmedianincome_d = NULL) => -0.0368258993, -0.0070858431),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1251627537,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0065436697, -0.0065436697);

// Tree: 56 
wFDN_FLA_SD_lgt_56 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00563981495) => 0.1880745735,
   (f_add_curr_nhood_MFD_pct_i > 0.00563981495) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 162.5) => 0.0109985747,
      (c_rich_wht > 162.5) => 
         map(
         (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => 0.0466847181,
         (f_phones_per_addr_c6_i > 0.5) => 0.2246731899,
         (f_phones_per_addr_c6_i = NULL) => 0.1100931112, 0.1100931112),
      (c_rich_wht = NULL) => 0.0301011360, 0.0301011360),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < c_unattach and c_unattach <= 112.5) => -0.0409895379,
      (c_unattach > 112.5) => 0.0948503725,
      (c_unattach = NULL) => 0.0405672385, 0.0107600364), 0.0344157114),
(f_corrssnaddrcount_d > 2.5) => -0.0050428249,
(f_corrssnaddrcount_d = NULL) => -0.0044377721, -0.0013394024);

// Tree: 57 
wFDN_FLA_SD_lgt_57 := map(
(NULL < c_lar_fam and c_lar_fam <= 181.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1685.5) => -0.0095858712,
      (c_med_rent > 1685.5) => 0.0581264432,
      (c_med_rent = NULL) => -0.0054685740, -0.0054685740),
   (r_D30_Derog_Count_i > 11.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 0.0148742855,
      (f_hh_lienholders_i > 1.5) => 0.1333607984,
      (f_hh_lienholders_i = NULL) => 0.0546062898, 0.0546062898),
   (r_D30_Derog_Count_i = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0803499696,
      (f_addrs_per_ssn_i > 4.5) => 0.0575474876,
      (f_addrs_per_ssn_i = NULL) => -0.0138636956, -0.0138636956), -0.0047274386),
(c_lar_fam > 181.5) => 0.1244313397,
(c_lar_fam = NULL) => -0.0173032537, -0.0037665210);

// Tree: 58 
wFDN_FLA_SD_lgt_58 := map(
(NULL < c_hhsize and c_hhsize <= 2.625) => -0.0167078822,
(c_hhsize > 2.625) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 127.5) => 0.1023286113,
   (f_mos_liens_unrel_SC_fseen_d > 127.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -27.5) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 124.5) => 0.0322842959,
         (f_curraddrcartheftindex_i > 124.5) => 0.1625594473,
         (f_curraddrcartheftindex_i = NULL) => 0.0810324171, 0.0810324171),
      (f_addrchangecrimediff_i > -27.5) => 0.0075404065,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < c_work_home and c_work_home <= 129.5) => 0.0441909609,
         (c_work_home > 129.5) => -0.0622345977,
         (c_work_home = NULL) => 0.0051384450, 0.0051384450), 0.0090621944),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0113082533, 0.0113082533),
(c_hhsize = NULL) => -0.0381014184, -0.0039373628);

// Tree: 59 
wFDN_FLA_SD_lgt_59 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => -0.0140811385,
(r_L79_adls_per_addr_curr_i > 3.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.0980466158,
   (r_C10_M_Hdr_FS_d > 7.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0053461535,
      (f_srchvelocityrisktype_i > 4.5) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 70.25) => 0.0704457116,
         (c_low_ed > 70.25) => -0.0796671771,
         (c_low_ed = NULL) => 0.0551280699, 0.0551280699),
      (f_srchvelocityrisktype_i = NULL) => 0.0126421266, 0.0126421266),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0144693225, 0.0144693225),
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 89) => -0.0936914577,
   (c_assault > 89) => 0.0503916908,
   (c_assault = NULL) => -0.0244207132, -0.0244207132), -0.0056495506);

// Tree: 60 
wFDN_FLA_SD_lgt_60 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0053224943,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 18.95) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => 0.0035225177,
      (r_C13_Curr_Addr_LRes_d > 158.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 1.85) => 0.0094108136,
         (c_hh6_p > 1.85) => 
            map(
            (NULL < c_fammar_p and c_fammar_p <= 79.55) => 0.0437599195,
            (c_fammar_p > 79.55) => 0.4229109867,
            (c_fammar_p = NULL) => 0.2134499076, 0.2134499076),
         (c_hh6_p = NULL) => 0.1155111425, 0.1155111425),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0306802530, 0.0306802530),
   (C_INC_35K_P > 18.95) => 0.1506718789,
   (C_INC_35K_P = NULL) => 0.0357474669, 0.0357474669),
(f_hh_collections_ct_i = NULL) => -0.0175603148, -0.0015152926);

// Tree: 61 
wFDN_FLA_SD_lgt_61 := map(
(NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 149.5) => 0.0404763728,
   (r_pb_order_freq_d > 149.5) => -0.0361757852,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => -0.0684523919,
      (f_rel_incomeover50_count_d > 0.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.078500788) => 
            map(
            (NULL < c_ab_av_edu and c_ab_av_edu <= 129.5) => 0.1347392620,
            (c_ab_av_edu > 129.5) => 0.0190805345,
            (c_ab_av_edu = NULL) => 0.0883653569, 0.0883653569),
         (f_add_input_nhood_VAC_pct_i > 0.078500788) => -0.0421795391,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0674781736, 0.0674781736),
      (f_rel_incomeover50_count_d = NULL) => 0.0489315161, 0.0489315161), 0.0287546826),
(r_I60_inq_recency_d > 4.5) => -0.0060879852,
(r_I60_inq_recency_d = NULL) => -0.0155961949, -0.0013453736);

// Tree: 62 
wFDN_FLA_SD_lgt_62 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0093598759,
   (f_assoccredbureaucountnew_i > 0.5) => 0.0696713445,
   (f_assoccredbureaucountnew_i = NULL) => -0.0074453679, -0.0074453679),
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 241.75) => 0.0078348116,
      (c_housingcpi > 241.75) => 0.1090004454,
      (c_housingcpi = NULL) => 0.0229593613, 0.0229593613),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < c_finance and c_finance <= 1.75) => 0.1911524188,
      (c_finance > 1.75) => 0.0411139679,
      (c_finance = NULL) => 0.1052751475, 0.1052751475),
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0274597273, 0.0274597273),
(f_prevaddrageoldest_d = NULL) => 0.0294821483, 0.0011212110);

// Tree: 63 
wFDN_FLA_SD_lgt_63 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 0.5) => 0.0063549289,
   (f_srchaddrsrchcount_i > 0.5) => 0.1575880374,
   (f_srchaddrsrchcount_i = NULL) => 0.0852591594, 0.0852591594),
(r_F00_dob_score_d > 65) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 8.5) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 5.75) => 0.0134087227,
      (c_hval_300k_p > 5.75) => 0.1407229659,
      (c_hval_300k_p = NULL) => 0.0608395192, 0.0608395192),
   (f_M_Bureau_ADL_FS_all_d > 8.5) => -0.0041282667,
   (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0029993785, -0.0029993785),
(r_F00_dob_score_d = NULL) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 1.05) => 0.1109121889,
   (C_INC_150K_P > 1.05) => -0.0267307210,
   (C_INC_150K_P = NULL) => -0.0012021183, -0.0107277343), -0.0025294563);

// Tree: 64 
wFDN_FLA_SD_lgt_64 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => -0.0041131148,
(f_prevaddrageoldest_d > 271.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 14.25) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => 0.0042847201,
      (f_inq_Collection_count_i > 3.5) => 0.1450252308,
      (f_inq_Collection_count_i = NULL) => 0.0165455499, 0.0165455499),
   (c_rnt1250_p > 14.25) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 30.5) => 0.1867381490,
      (r_pb_order_freq_d > 30.5) => 0.0518496565,
      (r_pb_order_freq_d = NULL) => 0.2809228886, 0.1418659809),
   (c_rnt1250_p = NULL) => 0.0455111212, 0.0455111212),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0929478618,
   (k_comb_age_d > 25.5) => 0.0389032898,
   (k_comb_age_d = NULL) => -0.0264061591, -0.0264061591), -0.0001152766);

// Tree: 65 
wFDN_FLA_SD_lgt_65 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 3.75) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 3.5) => 0.0665397943,
      (r_C21_M_Bureau_ADL_FS_d > 3.5) => -0.0085066860,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0252872307, -0.0075064674),
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 21.55) => 0.2223244004,
      (c_white_col > 21.55) => 0.0365571373,
      (c_white_col = NULL) => 0.0503805498, 0.0503805498),
   (k_comb_age_d = NULL) => -0.0033992559, -0.0033992559),
(c_hh7p_p > 3.75) => 
   map(
   (NULL < f_srchssnsrchcountmo_i and f_srchssnsrchcountmo_i <= 0.5) => 0.0306047383,
   (f_srchssnsrchcountmo_i > 0.5) => 0.1461457017,
   (f_srchssnsrchcountmo_i = NULL) => 0.0345561075, 0.0345561075),
(c_hh7p_p = NULL) => -0.0065526066, 0.0012968900);

// Tree: 66 
wFDN_FLA_SD_lgt_66 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 3278) => -0.0111473259,
   (f_addrchangeincomediff_d > 3278) => 
      map(
      (NULL < c_rental and c_rental <= 97.5) => -0.0180264755,
      (c_rental > 97.5) => 
         map(
         (NULL < c_construction and c_construction <= 4.25) => 0.2030302785,
         (c_construction > 4.25) => 0.0271232944,
         (c_construction = NULL) => 0.1110789005, 0.1110789005),
      (c_rental = NULL) => 0.0452322833, 0.0452322833),
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => -0.0129850731,
      (f_inq_QuizProvider_count_i > 1.5) => 0.0893982883,
      (f_inq_QuizProvider_count_i = NULL) => -0.0010560005, -0.0026673928), -0.0069509192),
(c_hh3_p > 23.25) => 0.0363218303,
(c_hh3_p = NULL) => -0.0100260065, -0.0004434450);

// Tree: 67 
wFDN_FLA_SD_lgt_67 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6942.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 0.1087624372,
   (f_attr_arrest_recency_d > 99.5) => -0.0064446419,
   (f_attr_arrest_recency_d = NULL) => -0.0053589335, -0.0053589335),
(f_addrchangeincomediff_d > 6942.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 76322) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 148.5) => 0.0544075476,
      (c_easiqlife > 148.5) => 0.2247685717,
      (c_easiqlife = NULL) => 0.0856608290, 0.0856608290),
   (f_curraddrmedianincome_d > 76322) => -0.0410703257,
   (f_curraddrmedianincome_d = NULL) => 0.0444424438, 0.0444424438),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 3.5) => -0.0162462041,
   (f_phones_per_addr_curr_i > 3.5) => 0.0334999839,
   (f_phones_per_addr_curr_i = NULL) => -0.0195612809, 0.0046264949), -0.0015144759);

// Tree: 68 
wFDN_FLA_SD_lgt_68 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 306.5) => -0.0047647009,
   (r_C13_Curr_Addr_LRes_d > 306.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0298149808,
      (f_corrrisktype_i > 6.5) => 0.2004812293,
      (f_corrrisktype_i = NULL) => 0.0501008915, 0.0501008915),
   (r_C13_Curr_Addr_LRes_d = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0953986516,
      (f_addrs_per_ssn_i > 3.5) => 0.0566297463,
      (f_addrs_per_ssn_i = NULL) => -0.0253333900, -0.0253333900), -0.0015589634),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 2.5) => 0.0315861140,
   (f_assocsuspicousidcount_i > 2.5) => 0.2567725319,
   (f_assocsuspicousidcount_i = NULL) => 0.0962948548, 0.0962948548),
(f_nae_nothing_found_i = NULL) => -0.0002012755, -0.0002012755);

// Tree: 69 
wFDN_FLA_SD_lgt_69 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => -0.0065998321,
   (f_inq_Communications_count24_i > 2.5) => 0.0919708473,
   (f_inq_Communications_count24_i = NULL) => -0.0060754770, -0.0060754770),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 16.1) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 57.5) => -0.0257438989,
      (r_C13_max_lres_d > 57.5) => 
         map(
         (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 1.5) => -0.0000993900,
         (k_inq_addrs_per_ssn_i > 1.5) => 0.1598414422,
         (k_inq_addrs_per_ssn_i = NULL) => 0.0737194556, 0.0737194556),
      (r_C13_max_lres_d = NULL) => 0.0145232723, 0.0145232723),
   (C_INC_25K_P > 16.1) => 0.1402383809,
   (C_INC_25K_P = NULL) => 0.0343151553, 0.0343151553),
(f_varrisktype_i = NULL) => -0.0073385470, -0.0049627324);

// Tree: 70 
wFDN_FLA_SD_lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 4.75) => -0.0888681838,
   (c_pop_35_44_p > 4.75) => -0.0048593508,
   (c_pop_35_44_p = NULL) => -0.0068473349, -0.0068473349),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < c_med_inc and c_med_inc <= 45.5) => 0.1805117512,
   (c_med_inc > 45.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','6: Other']) => 0.0102249644,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly']) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1959.5) => 0.2434989208,
         (c_med_yearblt > 1959.5) => 0.0425652393,
         (c_med_yearblt = NULL) => 0.1017689133, 0.1017689133),
      (nf_seg_FraudPoint_3_0 = '') => 0.0329839484, 0.0329839484),
   (c_med_inc = NULL) => 0.0426252882, 0.0426252882),
(c_hval_750k_p = NULL) => 0.0086957554, -0.0027580404);

// Tree: 71 
wFDN_FLA_SD_lgt_71 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 0.85) => -0.0061965298,
(c_hh7p_p > 0.85) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
      map(
      (NULL < c_hval_1001k_p and c_hval_1001k_p <= 24.7) => 0.0118492332,
      (c_hval_1001k_p > 24.7) => 0.2317706719,
      (c_hval_1001k_p = NULL) => 0.0159682376, 0.0159682376),
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.03796423945) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 14.8) => 0.0512299611,
         (c_famotf18_p > 14.8) => 0.2134288077,
         (c_famotf18_p = NULL) => 0.1237210657, 0.1237210657),
      (f_add_input_nhood_BUS_pct_i > 0.03796423945) => 0.0188150880,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0626893170, 0.0626893170),
   (f_phones_per_addr_curr_i = NULL) => 0.0206403456, 0.0206403456),
(c_hh7p_p = NULL) => -0.0210480947, 0.0028392373);

// Tree: 72 
wFDN_FLA_SD_lgt_72 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 6.45) => -0.0502811717,
   (c_pop_45_54_p > 6.45) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 74.5) => -0.0023810690,
      (k_comb_age_d > 74.5) => 
         map(
         (NULL < c_murders and c_murders <= 139) => 
            map(
            (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.03105516945) => 0.2532006202,
            (f_add_input_nhood_MFD_pct_i > 0.03105516945) => -0.0190331514,
            (f_add_input_nhood_MFD_pct_i = NULL) => -0.0391529559, 0.0358548046),
         (c_murders > 139) => 0.2047666016,
         (c_murders = NULL) => 0.0672990054, 0.0672990054),
      (k_comb_age_d = NULL) => 0.0001205119, 0.0001205119),
   (c_pop_45_54_p = NULL) => -0.0255338114, -0.0026690136),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0911663922,
(f_inq_PrepaidCards_count_i = NULL) => -0.0121734118, -0.0023639637);

// Tree: 73 
wFDN_FLA_SD_lgt_73 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.15) => -0.0076880395,
   (c_pop_12_17_p > 10.15) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.1417558647,
      (r_C10_M_Hdr_FS_d > 13.5) => 0.0206291582,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0231278830, 0.0231278830),
   (c_pop_12_17_p = NULL) => -0.0001310188, -0.0001481335),
(f_hh_collections_ct_i > 4.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 11.75) => -0.0486997190,
   (c_pop_45_54_p > 11.75) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 12.75) => 0.0328980295,
      (c_pop_25_34_p > 12.75) => 0.2463168559,
      (c_pop_25_34_p = NULL) => 0.1267417688, 0.1267417688),
   (c_pop_45_54_p = NULL) => 0.0674376039, 0.0674376039),
(f_hh_collections_ct_i = NULL) => 0.0005922800, 0.0010303897);

// Tree: 74 
wFDN_FLA_SD_lgt_74 := map(
(NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 1.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 53.5) => 
      map(
      (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0073160205,
      (f_prevaddroccupantowned_i > 0.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 0.1295471728,
         (f_prevaddrlenofres_d > 1.5) => 
            map(
            (NULL < c_pop_18_24_p and c_pop_18_24_p <= 3.55) => 0.1631465659,
            (c_pop_18_24_p > 3.55) => 0.0031358698,
            (c_pop_18_24_p = NULL) => 0.0198651553, 0.0198651553),
         (f_prevaddrlenofres_d = NULL) => 0.0313853672, 0.0313853672),
      (f_prevaddroccupantowned_i = NULL) => -0.0044665708, -0.0044665708),
   (f_bus_addr_match_count_d > 53.5) => 0.1599585460,
   (f_bus_addr_match_count_d = NULL) => -0.0035839105, -0.0035839105),
(f_vardobcountnew_i > 1.5) => 0.1010648314,
(f_vardobcountnew_i = NULL) => 0.0232585511, -0.0025449918);

// Tree: 75 
wFDN_FLA_SD_lgt_75 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 84) => 
   map(
   (NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1450) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 94.4) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33419) => 
            map(
            (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 0.0115939304,
            (f_util_adl_count_n > 3.5) => 0.1152587855,
            (f_util_adl_count_n = NULL) => 0.0289272301, 0.0289272301),
         (f_curraddrmedianincome_d > 33419) => -0.0071561476,
         (f_curraddrmedianincome_d = NULL) => -0.0034813186, -0.0034813186),
      (C_RENTOCC_P > 94.4) => -0.1199569849,
      (C_RENTOCC_P = NULL) => -0.0272212885, -0.0045413491),
   (f_liens_rel_SC_total_amt_i > 1450) => -0.1340168069,
   (f_liens_rel_SC_total_amt_i = NULL) => -0.0223511652, -0.0052435272),
(f_bus_addr_match_count_d > 84) => 0.1999891684,
(f_bus_addr_match_count_d = NULL) => -0.0044183899, -0.0044183899);

// Tree: 76 
wFDN_FLA_SD_lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0104084321,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => 
         map(
         (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => -0.0045995944,
         (f_inq_Communications_count24_i > 1.5) => 0.1121680373,
         (f_inq_Communications_count24_i = NULL) => -0.0017095373, -0.0017095373),
      (f_prevaddrlenofres_d > 123.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0476377077,
         (f_rel_homeover500_count_d > 3.5) => 0.1803731437,
         (f_rel_homeover500_count_d = NULL) => 0.0690188752, 0.0690188752),
      (f_prevaddrlenofres_d = NULL) => 0.0174396399, 0.0174396399),
   (f_nae_nothing_found_i > 0.5) => 0.2082133420,
   (f_nae_nothing_found_i = NULL) => 0.0204213261, 0.0204213261),
(c_rnt1250_p = NULL) => 0.0020227920, -0.0015843590);

// Tree: 77 
wFDN_FLA_SD_lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => -0.0148452721,
   (c_pop_35_44_p > 14.75) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 33916.5) => 0.1199668053,
      (f_curraddrmedianvalue_d > 33916.5) => 
         map(
         (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 0.0004229538,
         (f_divrisktype_i > 1.5) => 0.0481226780,
         (f_divrisktype_i = NULL) => 0.0069899555, 0.0069899555),
      (f_curraddrmedianvalue_d = NULL) => 0.0104078674, 0.0104078674),
   (c_pop_35_44_p = NULL) => -0.0021274309, -0.0021274309),
(c_transport > 29.05) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.1805490245,
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0262411722,
   (r_C12_Num_NonDerogs_d = NULL) => 0.1048932328, 0.1048932328),
(c_transport = NULL) => -0.0042831181, -0.0004154639);

// Tree: 78 
wFDN_FLA_SD_lgt_78 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0050673247,
      (f_varrisktype_i > 2.5) => 0.1758338878,
      (f_varrisktype_i = NULL) => 0.0783908207, 0.0783908207),
   (r_C13_max_lres_d > 18.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0068514826,
      (f_corrrisktype_i > 7.5) => 
         map(
         (NULL < nf_vf_type and nf_vf_type <= 2.5) => 0.0159397044,
         (nf_vf_type > 2.5) => 0.0993987818,
         (nf_vf_type = NULL) => 0.0204755239, 0.0204755239),
      (f_corrrisktype_i = NULL) => -0.0019738828, -0.0019738828),
   (r_C13_max_lres_d = NULL) => -0.0007916560, -0.0007916560),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0612634509,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0172277088, -0.0031930434);

// Tree: 79 
wFDN_FLA_SD_lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => -0.0040925384,
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 53.55) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 16.5) => 
         map(
         (NULL < c_food and c_food <= 8.35) => 0.0875880884,
         (c_food > 8.35) => 
            map(
            (NULL < c_med_yearblt and c_med_yearblt <= 1975.5) => -0.0889753269,
            (c_med_yearblt > 1975.5) => 0.0438536155,
            (c_med_yearblt = NULL) => -0.0371013021, -0.0371013021),
         (c_food = NULL) => -0.0064856035, -0.0064856035),
      (f_addrs_per_ssn_i > 16.5) => 0.1087150054,
      (f_addrs_per_ssn_i = NULL) => 0.0162241939, 0.0162241939),
   (c_newhouse > 53.55) => 0.1573046291,
   (c_newhouse = NULL) => 0.0391021023, 0.0391021023),
(f_inq_PrepaidCards_count_i = NULL) => -0.0072648040, -0.0029549773);

// Tree: 80 
wFDN_FLA_SD_lgt_80 := map(
(NULL < c_bel_edu and c_bel_edu <= 196.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0961775457,
   (f_attr_arrest_recency_d > 48) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => -0.0118503736,
      (r_C14_Addr_Stability_v2_d > 4.5) => 
         map(
         (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 6.5) => 
            map(
            (NULL < c_vacant_p and c_vacant_p <= 4.35) => 0.2612279966,
            (c_vacant_p > 4.35) => 0.0451724248,
            (c_vacant_p = NULL) => 0.1013909665, 0.1013909665),
         (r_F00_input_dob_match_level_d > 6.5) => 0.0097020998,
         (r_F00_input_dob_match_level_d = NULL) => 0.0125469657, 0.0125469657),
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0009087946, 0.0009087946),
   (f_attr_arrest_recency_d = NULL) => 0.0067109149, 0.0013606387),
(c_bel_edu > 196.5) => -0.0762299939,
(c_bel_edu = NULL) => 0.0340272905, 0.0012778295);

// Tree: 81 
wFDN_FLA_SD_lgt_81 := map(
(NULL < c_easiqlife and c_easiqlife <= 142.5) => -0.0143335657,
(c_easiqlife > 142.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 126.5) => 0.0013564910,
   (r_C13_Curr_Addr_LRes_d > 126.5) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 23.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 5.85) => 0.1674156057,
         (c_pop_55_64_p > 5.85) => 
            map(
            (NULL < c_very_rich and c_very_rich <= 162.5) => 0.0072317746,
            (c_very_rich > 162.5) => 0.1495639504,
            (c_very_rich = NULL) => 0.0463554199, 0.0463554199),
         (c_pop_55_64_p = NULL) => 0.0573110928, 0.0573110928),
      (f_rel_under500miles_cnt_d > 23.5) => 0.1842854268,
      (f_rel_under500miles_cnt_d = NULL) => 0.0644932057, 0.0644932057),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0181193955, 0.0181193955),
(c_easiqlife = NULL) => 0.0143062295, -0.0045622810);

// Tree: 82 
wFDN_FLA_SD_lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 29953.5) => 0.0739922226,
      (r_A46_Curr_AVM_AutoVal_d > 29953.5) => 
         map(
         (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 11.5) => -0.0086984958,
         (f_rel_incomeover100_count_d > 11.5) => 0.1064943586,
         (f_rel_incomeover100_count_d = NULL) => 0.1111710198, -0.0064513468),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0033207350, -0.0041101041),
   (f_inq_HighRiskCredit_count_i > 4.5) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 3.05) => 0.0985129268,
      (c_low_hval > 3.05) => -0.0256969945,
      (c_low_hval = NULL) => 0.0510441671, 0.0510441671),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0034118369, -0.0034118369),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0695954352,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0019723684, -0.0038495226);

// Tree: 83 
wFDN_FLA_SD_lgt_83 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0119630215,
(f_srchaddrsrchcount_i > 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 3) => 0.0164941439,
      (c_hval_175k_p > 3) => 0.1698849607,
      (c_hval_175k_p = NULL) => 0.0822330654, 0.0822330654),
   (r_C10_M_Hdr_FS_d > 10.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 356) => 0.2219777820,
         (r_A50_pb_total_dollars_d > 356) => 0.0189172232,
         (r_A50_pb_total_dollars_d = NULL) => 0.0861888193, 0.0861888193),
      (r_F00_dob_score_d > 95) => 0.0110583458,
      (r_F00_dob_score_d = NULL) => -0.0151890191, 0.0125867057),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0140815301, 0.0140815301),
(f_srchaddrsrchcount_i = NULL) => -0.0003142202, -0.0003680008);

// Tree: 84 
wFDN_FLA_SD_lgt_84 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 38.35) => 0.0019483323,
      (c_hval_60k_p > 38.35) => -0.1209522321,
      (c_hval_60k_p = NULL) => -0.0114282592, 0.0009411341),
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 169.5) => 0.0320414884,
      (c_totcrime > 169.5) => 0.1658143285,
      (c_totcrime = NULL) => 0.0392988432, 0.0484321989),
   (r_L70_Add_Standardized_i = NULL) => 0.0047197727, 0.0047197727),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0570557878,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0935055760,
   (k_comb_age_d > 25.5) => 0.0758935038,
   (k_comb_age_d = NULL) => 0.0009135832, 0.0009135832), 0.0021994817);

// Tree: 85 
wFDN_FLA_SD_lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => -0.0070806655,
   (f_srchssnsrchcount_i > 6.5) => -0.0511928976,
   (f_srchssnsrchcount_i = NULL) => -0.0084024704, -0.0084024704),
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 8.5) => 0.0089079537,
      (f_inq_Collection_count_i > 8.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 10.8) => 0.0159338760,
         (c_hval_250k_p > 10.8) => 0.1727156928,
         (c_hval_250k_p = NULL) => 0.0854632034, 0.0854632034),
      (f_inq_Collection_count_i = NULL) => 0.0150094280, 0.0150094280),
   (r_F01_inp_addr_not_verified_i > 0.5) => 0.1485081230,
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0226403746, 0.0226403746),
(f_util_adl_count_n = NULL) => 0.0071526009, -0.0044487046);

// Tree: 86 
wFDN_FLA_SD_lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => -0.0033262266,
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 5.5) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 47.5) => 0.1172708029,
      (c_no_teens > 47.5) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => -0.0378451385,
         (r_C23_inp_addr_occ_index_d > 2) => 
            map(
            (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.4778864051) => 0.1743905677,
            (f_add_curr_nhood_SFD_pct_d > 0.4778864051) => -0.0036849770,
            (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0559703305, 0.0559703305),
         (r_C23_inp_addr_occ_index_d = NULL) => 0.0002138753, 0.0002138753),
      (c_no_teens = NULL) => 0.0184539102, 0.0184539102),
   (f_srchssnsrchcount_i > 5.5) => 0.1118437211,
   (f_srchssnsrchcount_i = NULL) => 0.0281732118, 0.0281732118),
(f_phones_per_addr_curr_i = NULL) => -0.0192325277, -0.0018190506);

// Tree: 87 
wFDN_FLA_SD_lgt_87 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -84810) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 15.9) => 0.1117561576,
      (c_high_ed > 15.9) => 0.0033723382,
      (c_high_ed = NULL) => 0.0428300420, 0.0428300420),
   (f_addrchangevaluediff_d > -84810) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 58.5) => 0.1205238640,
      (f_mos_liens_unrel_SC_fseen_d > 58.5) => 
         map(
         (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => -0.0539247622,
         (nf_vf_hi_risk_index > 4.5) => -0.0069158192,
         (nf_vf_hi_risk_index = NULL) => -0.0080957526, -0.0080957526),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0067933095, -0.0067933095),
   (f_addrchangevaluediff_d = NULL) => -0.0070443052, -0.0059974495),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1001529512,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0055790404, -0.0055790404);

// Tree: 88 
wFDN_FLA_SD_lgt_88 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 42.5) => 0.0291687318,
   (c_exp_prod > 42.5) => -0.0065920207,
   (c_exp_prod = NULL) => -0.0480219808, -0.0036970157),
(k_inq_per_ssn_i > 3.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => 0.0080519353,
      (r_D34_UnRel_Lien60_Count_i > 0.5) => 0.1039035272,
      (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0163478625, 0.0163478625),
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 4.5) => 0.1506412093,
      (f_srchfraudsrchcountyr_i > 4.5) => 0.0201228748,
      (f_srchfraudsrchcountyr_i = NULL) => 0.0835692874, 0.0835692874),
   (f_varrisktype_i = NULL) => 0.0260374373, 0.0260374373),
(k_inq_per_ssn_i = NULL) => -0.0013552957, -0.0013552957);

// Tree: 89 
wFDN_FLA_SD_lgt_89 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 283.5) => -0.0071006856,
   (r_C13_Curr_Addr_LRes_d > 283.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 43.65) => 0.0236361097,
      (c_hval_750k_p > 43.65) => 0.2233543898,
      (c_hval_750k_p = NULL) => 0.0379017012, 0.0379017012),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0035154002, -0.0035154002),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 235.5) => 0.1266542106,
   (f_M_Bureau_ADL_FS_all_d > 235.5) => -0.0266129708,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0505968123, 0.0505968123),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1173.5) => 0.0765913739,
   (c_popover25 > 1173.5) => -0.0637131807,
   (c_popover25 = NULL) => 0.0037918409, 0.0037918409), -0.0028829491);

// Tree: 90 
wFDN_FLA_SD_lgt_90 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => 
      map(
      (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.0869218708,
      (r_D32_Mos_Since_Fel_LS_d > 117) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 0.65) => 0.1518484167,
         (c_pop_25_34_p > 0.65) => -0.0019250251,
         (c_pop_25_34_p = NULL) => -0.0034655265, -0.0009495426),
      (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0004748684, -0.0004748684),
   (k_inq_adls_per_addr_i > 4.5) => -0.0786117159,
   (k_inq_adls_per_addr_i = NULL) => -0.0012483153, -0.0012483153),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0864164062,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 39) => 0.0202292474,
   (c_low_ed > 39) => -0.0860790315,
   (c_low_ed = NULL) => -0.0329248920, -0.0329248920), -0.0018705810);

// Tree: 91 
wFDN_FLA_SD_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.45) => 0.0312464639,
   (c_retired > 15.45) => 0.1883069937,
   (c_retired = NULL) => 0.0726929926, 0.0726929926),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0117309005,
      (f_srchfraudsrchcountmo_i > 0.5) => 
         map(
         (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 0.5) => 0.0223383129,
         (f_inq_QuizProvider_count24_i > 0.5) => 0.1796698221,
         (f_inq_QuizProvider_count24_i = NULL) => 0.0444332948, 0.0444332948),
      (f_srchfraudsrchcountmo_i = NULL) => -0.0097395017, -0.0097395017),
   (c_food > 65.55) => 0.0583901094,
   (c_food = NULL) => -0.0032167252, -0.0071859067),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0098394087, -0.0056731372);

// Tree: 92 
wFDN_FLA_SD_lgt_92 := map(
(NULL < c_hh3_p and c_hh3_p <= 21.55) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 26.15) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0080416573,
      (f_nae_nothing_found_i > 0.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 106) => -0.0093645846,
         (c_easiqlife > 106) => 0.1986029206,
         (c_easiqlife = NULL) => 0.0874752460, 0.0874752460),
      (f_nae_nothing_found_i = NULL) => -0.0067463453, -0.0067463453),
   (C_INC_25K_P > 26.15) => 0.1027962572,
   (C_INC_25K_P = NULL) => -0.0057463153, -0.0057463153),
(c_hh3_p > 21.55) => 
   map(
   (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 0.0215225894,
   (f_acc_damage_amt_total_i > 275) => 0.1757608659,
   (f_acc_damage_amt_total_i = NULL) => 0.0260659510, 0.0260659510),
(c_hh3_p = NULL) => -0.0421162068, -0.0000118557);

// Tree: 93 
wFDN_FLA_SD_lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0018618734,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_food and c_food <= 18.7) => 0.1322774816,
         (c_food > 18.7) => -0.0052199592,
         (c_food = NULL) => 0.0702211145, 0.0702211145),
      (r_D33_eviction_count_i = NULL) => 0.0025227730, 0.0025227730),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 55.5) => 0.1003304027,
      (r_pb_order_freq_d > 55.5) => -0.0560772617,
      (r_pb_order_freq_d = NULL) => 0.1377108295, 0.0806652939),
   (f_curraddrcartheftindex_i = NULL) => -0.0114827526, 0.0038697678),
(c_cartheft > 189.5) => -0.0556429927,
(c_cartheft = NULL) => 0.0007569395, 0.0018745335);

// Tree: 94 
wFDN_FLA_SD_lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.13661234025) => 0.0177141866,
         (f_add_curr_nhood_VAC_pct_i > 0.13661234025) => 0.1236806731,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0273122489, 0.0273122489),
      (f_hh_members_ct_d > 1.5) => -0.0039407396,
      (f_hh_members_ct_d = NULL) => 0.0001718313, 0.0017762619),
   (r_L77_Add_PO_Box_i > 0.5) => -0.0964691771,
   (r_L77_Add_PO_Box_i = NULL) => -0.0001218525, -0.0001218525),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => 0.1177422405,
   (f_rel_incomeover75_count_d > 0.5) => 0.0010364589,
   (f_rel_incomeover75_count_d = NULL) => 0.0682589891, 0.0682589891),
(c_famotf18_p = NULL) => 0.0094579817, 0.0007964370);

// Tree: 95 
wFDN_FLA_SD_lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0643502648,
   (f_corrssnaddrcount_d > 0.5) => -0.0072030591,
   (f_corrssnaddrcount_d = NULL) => -0.0192101466, -0.0085050985),
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 30.45) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30897.5) => 0.1441454316,
      (f_curraddrmedianincome_d > 30897.5) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0048464178,
         (f_hh_collections_ct_i > 2.5) => 0.1053926416,
         (f_hh_collections_ct_i = NULL) => 0.0150702624, 0.0150702624),
      (f_curraddrmedianincome_d = NULL) => 0.0201985015, 0.0201985015),
   (C_INC_75K_P > 30.45) => 0.1872856383,
   (C_INC_75K_P = NULL) => 0.0275699928, 0.0275699928),
(c_rnt1000_p = NULL) => -0.0024354112, -0.0039213197);

// Tree: 96 
wFDN_FLA_SD_lgt_96 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45599.5) => 
   map(
   (NULL < c_construction and c_construction <= 40.1) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.55) => -0.0022451885,
      (c_pop_35_44_p > 14.55) => 0.0425759891,
      (c_pop_35_44_p = NULL) => 0.0140786746, 0.0140786746),
   (c_construction > 40.1) => 0.1548717259,
   (c_construction = NULL) => -0.0166278075, 0.0164658676),
(f_curraddrmedianincome_d > 45599.5) => 
   map(
   (NULL < c_transport and c_transport <= 29.05) => -0.0122283579,
   (c_transport > 29.05) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => 0.2123950258,
      (f_rel_incomeover50_count_d > 4.5) => 0.0143598016,
      (f_rel_incomeover50_count_d = NULL) => 0.0919682003, 0.0919682003),
   (c_transport = NULL) => -0.0105719904, -0.0105719904),
(f_curraddrmedianincome_d = NULL) => -0.0075301166, -0.0039164613);

// Tree: 97 
wFDN_FLA_SD_lgt_97 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0000819019,
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1443722566,
      (r_A50_pb_average_dollars_d > 99) => -0.0005474173,
      (r_A50_pb_average_dollars_d = NULL) => 0.0642540629, 0.0642540629),
   (r_D33_eviction_count_i = NULL) => 
      map(
      (NULL < c_burglary and c_burglary <= 96.5) => -0.0720088072,
      (c_burglary > 96.5) => 0.0444436528,
      (c_burglary = NULL) => -0.0126408864, -0.0126408864), 0.0006044471),
(k_inq_adls_per_addr_i > 3.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 3.5) => -0.0395772236,
   (f_rel_criminal_count_i > 3.5) => -0.0980054581,
   (f_rel_criminal_count_i = NULL) => -0.0566282648, -0.0566282648),
(k_inq_adls_per_addr_i = NULL) => -0.0005596080, -0.0005596080);

// Tree: 98 
wFDN_FLA_SD_lgt_98 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 10.15) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => -0.0469331709,
      (nf_vf_hi_risk_index > 5.5) => -0.0151805517,
      (nf_vf_hi_risk_index = NULL) => -0.0177117898, -0.0177117898),
   (c_hh4_p > 10.15) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 0.0022227008,
      (f_rel_homeover500_count_d > 14.5) => 0.1164149329,
      (f_rel_homeover500_count_d = NULL) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 18.85) => 0.1700403228,
         (C_RENTOCC_P > 18.85) => 0.0051685953,
         (C_RENTOCC_P = NULL) => 0.0652982842, 0.0652982842), 0.0046040688),
   (c_hh4_p = NULL) => -0.0119149104, -0.0028185672),
(r_L72_Add_Vacant_i > 0.5) => 0.1223039813,
(r_L72_Add_Vacant_i = NULL) => -0.0020683255, -0.0020683255);

// Tree: 99 
wFDN_FLA_SD_lgt_99 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37732321285) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 522392) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 13.55) => -0.0105479743,
         (C_INC_50K_P > 13.55) => 0.0507383142,
         (C_INC_50K_P = NULL) => 0.0169136414, 0.0169136414),
      (c_med_hval > 522392) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 150.5) => 0.0647126650,
         (c_span_lang > 150.5) => 0.2096996924,
         (c_span_lang = NULL) => 0.1098197402, 0.1098197402),
      (c_med_hval = NULL) => -0.0435420118, 0.0250551868),
   (r_F03_address_match_d > 3.5) => 0.0026239478,
   (r_F03_address_match_d = NULL) => 0.0425279104, 0.0083828572),
(f_add_input_mobility_index_i > 0.37732321285) => -0.0246624205,
(f_add_input_mobility_index_i = NULL) => 0.0145229886, 0.0027586488);

// Tree: 100 
wFDN_FLA_SD_lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_transport and c_transport <= 26.6) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 17.9) => 0.0360887012,
         (c_vacant_p > 17.9) => 0.1599743148,
         (c_vacant_p = NULL) => 0.0594819952, 0.0594819952),
      (k_estimated_income_d > 30500) => 0.0022901219,
      (k_estimated_income_d = NULL) => 0.0059410802, 0.0059410802),
   (c_transport > 26.6) => 0.1561390636,
   (c_transport = NULL) => -0.0009430890, 0.0084001072),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 39.35) => -0.0149535849,
   (c_famotf18_p > 39.35) => -0.0762024563,
   (c_famotf18_p = NULL) => 0.1013925029, -0.0159909346),
(f_historical_count_d = NULL) => 0.0150484405, -0.0038107389);

// Tree: 101 
wFDN_FLA_SD_lgt_101 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0181059108,
   (f_corrrisktype_i > 5.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0140483694,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0504235801,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0087254781, 0.0087254781),
   (f_corrrisktype_i = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0754537987,
      (f_addrs_per_ssn_i > 3.5) => 0.0619510148,
      (f_addrs_per_ssn_i = NULL) => -0.0099617848, -0.0099617848), -0.0048520410),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 303) => -0.0285263766,
   (r_C13_max_lres_d > 303) => 0.2052548483,
   (r_C13_max_lres_d = NULL) => 0.0804759123, 0.0804759123),
(k_comb_age_d = NULL) => -0.0037555919, -0.0037555919);

// Tree: 102 
wFDN_FLA_SD_lgt_102 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0102985035,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 44) => -0.1200594110,
   (f_mos_inq_banko_am_fseen_d > 44) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 79.25) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 9.55) => 0.0135502733,
         (c_hh7p_p > 9.55) => 
            map(
            (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => -0.0228205486,
            (f_rel_under25miles_cnt_d > 5.5) => 0.1565583358,
            (f_rel_under25miles_cnt_d = NULL) => 0.0774621348, 0.0774621348),
         (c_hh7p_p = NULL) => 0.0153045112, 0.0153045112),
      (c_rnt1000_p > 79.25) => 0.1877274493,
      (c_rnt1000_p = NULL) => 0.0288119926, 0.0182484233),
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0147860304, 0.0147860304),
(k_inq_per_ssn_i = NULL) => -0.0000788053, -0.0000788053);

// Tree: 103 
wFDN_FLA_SD_lgt_103 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
         map(
         (NULL < c_popover25 and c_popover25 <= 681.5) => 
            map(
            (NULL < c_no_teens and c_no_teens <= 76) => 0.2010705652,
            (c_no_teens > 76) => 0.0349277843,
            (c_no_teens = NULL) => 0.1006339689, 0.1006339689),
         (c_popover25 > 681.5) => -0.0148503127,
         (c_popover25 = NULL) => 0.1136400088, 0.0444383787),
      (k_estimated_income_d > 27500) => -0.0040542008,
      (k_estimated_income_d = NULL) => -0.0016315256, -0.0016315256),
   (f_srchaddrsrchcount_i > 32.5) => -0.0792095048,
   (f_srchaddrsrchcount_i = NULL) => -0.0021530999, -0.0021530999),
(r_D34_unrel_liens_ct_i > 7.5) => 0.0930395882,
(r_D34_unrel_liens_ct_i = NULL) => -0.0003085918, -0.0016102009);

// Tree: 104 
wFDN_FLA_SD_lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => -0.0011239798,
   (k_inq_per_ssn_i > 7.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 280.5) => 0.0935626693,
      (f_M_Bureau_ADL_FS_noTU_d > 280.5) => -0.0559622917,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0491255323, 0.0491255323),
   (k_inq_per_ssn_i = NULL) => -0.0001120811, -0.0001120811),
(f_prevaddrmedianvalue_d > 809865.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 77750) => 0.3121417432,
   (r_A49_Curr_AVM_Chg_1yr_i > 77750) => 0.0027867735,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0593391097, 0.1143358605),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 65) => -0.0621115855,
   (c_born_usa > 65) => 0.0251693463,
   (c_born_usa = NULL) => -0.0164318455, -0.0164318455), 0.0015998482);

// Tree: 105 
wFDN_FLA_SD_lgt_105 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0106400543,
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 85) => -0.0046575384,
   (f_curraddrcrimeindex_i > 85) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 186) => 
         map(
         (NULL < C_INC_200K_P and C_INC_200K_P <= 4.95) => 0.0424497564,
         (C_INC_200K_P > 4.95) => -0.0353165653,
         (C_INC_200K_P = NULL) => 0.0188353489, 0.0188353489),
      (c_rich_blk > 186) => 
         map(
         (NULL < c_very_rich and c_very_rich <= 128.5) => 0.0679077433,
         (c_very_rich > 128.5) => 0.2530722839,
         (c_very_rich = NULL) => 0.1248072636, 0.1248072636),
      (c_rich_blk = NULL) => 0.0299415758, 0.0299415758),
   (f_curraddrcrimeindex_i = NULL) => 0.0104862467, 0.0104862467),
(f_corrrisktype_i = NULL) => -0.0144757871, -0.0036558460);

// Tree: 106 
wFDN_FLA_SD_lgt_106 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 30.5) => 0.1151121256,
(f_mos_liens_unrel_SC_fseen_d > 30.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0115976624,
   (k_comb_age_d > 56.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 193.5) => 
         map(
         (NULL < c_murders and c_murders <= 146.5) => 0.0025125563,
         (c_murders > 146.5) => 
            map(
            (NULL < c_hval_200k_p and c_hval_200k_p <= 12.55) => 0.0524920574,
            (c_hval_200k_p > 12.55) => 0.3081569587,
            (c_hval_200k_p = NULL) => 0.0848547032, 0.0848547032),
         (c_murders = NULL) => 0.0148560660, 0.0148560660),
      (c_sub_bus > 193.5) => 0.1830447724,
      (c_sub_bus = NULL) => -0.0280575884, 0.0179100164),
   (k_comb_age_d = NULL) => -0.0050183592, -0.0050183592),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0009862185, -0.0042896395);

// Tree: 107 
wFDN_FLA_SD_lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0944321427,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.0761099312,
   (r_F00_dob_score_d > 55) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 12.1) => 
            map(
            (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0782844194,
            (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0662187472,
            (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0068268095, 0.0068268095),
         (C_INC_35K_P > 12.1) => 0.1386751341,
         (C_INC_35K_P = NULL) => 0.0430719665, 0.0430719665),
      (r_C21_M_Bureau_ADL_FS_d > 8.5) => -0.0026377889,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0016657276, -0.0016657276),
   (r_F00_dob_score_d = NULL) => -0.0307464626, -0.0022167243),
(f_attr_arrest_recency_d = NULL) => 0.0045020409, -0.0014643856);

// Tree: 108 
wFDN_FLA_SD_lgt_108 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 20.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 8.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.9413317504) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0073016482) => 0.0498012947,
         (f_add_input_nhood_MFD_pct_i > 0.0073016482) => 0.0017416360,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0591686045, 0.0085179247),
      (f_add_curr_nhood_MFD_pct_i > 0.9413317504) => -0.0418885593,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0234059939, 0.0009882010),
   (r_D32_criminal_count_i > 8.5) => 
      map(
      (NULL < c_retired and c_retired <= 13.2) => 0.1406234374,
      (c_retired > 13.2) => -0.0259073075,
      (c_retired = NULL) => 0.0697353501, 0.0697353501),
   (r_D32_criminal_count_i = NULL) => 0.0018218366, 0.0018218366),
(f_srchaddrsrchcount_i > 20.5) => 0.0587009951,
(f_srchaddrsrchcount_i = NULL) => -0.0186077682, 0.0025943643);

// Tree: 109 
wFDN_FLA_SD_lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0080140820,
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => -0.0818715915,
   (f_mos_inq_banko_cm_lseen_d > 27.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 24.9) => -0.0496220011,
      (c_rnt750_p > 24.9) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 65.5) => 0.1512746162,
         (c_born_usa > 65.5) => 0.0001651130,
         (c_born_usa = NULL) => 0.0556081681, 0.0556081681),
      (c_rnt750_p = NULL) => -0.0036251661, -0.0036251661),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0309167621, -0.0309167621),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 30.5) => -0.0497416640,
   (k_comb_age_d > 30.5) => 0.0650098972,
   (k_comb_age_d = NULL) => 0.0076341166, 0.0076341166), 0.0064883008);

// Tree: 110 
wFDN_FLA_SD_lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 105.5) => -0.0089830848,
(f_prevaddrageoldest_d > 105.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 792966) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6907) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.0994224308,
         (r_F00_dob_score_d > 98) => 0.0055402790,
         (r_F00_dob_score_d = NULL) => 0.0084525849, 0.0084525849),
      (f_addrchangeincomediff_d > 6907) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 22.15) => -0.0365871617,
         (c_lowinc > 22.15) => 0.1752684811,
         (c_lowinc = NULL) => 0.0748196849, 0.0748196849),
      (f_addrchangeincomediff_d = NULL) => 0.0357705770, 0.0145704574),
   (f_curraddrmedianvalue_d > 792966) => 0.1759610986,
   (f_curraddrmedianvalue_d = NULL) => 0.0180922305, 0.0180922305),
(f_prevaddrageoldest_d = NULL) => -0.0258797599, 0.0004468191);

// Tree: 111 
wFDN_FLA_SD_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2216267463,
   (r_C12_source_profile_d > 57.95) => -0.0237622318,
   (r_C12_source_profile_d = NULL) => 0.0903721766, 0.0903721766),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0005254268,
      (k_inq_ssns_per_addr_i > 1.5) => 
         map(
         (NULL < c_families and c_families <= 511.5) => 0.0033235501,
         (c_families > 511.5) => 0.1004452845,
         (c_families = NULL) => 0.0403555783, 0.0403555783),
      (k_inq_ssns_per_addr_i = NULL) => 0.0041775492, 0.0041775492),
   (k_inq_adls_per_addr_i > 3.5) => -0.0505509022,
   (k_inq_adls_per_addr_i = NULL) => 0.0029999318, 0.0029999318),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0248170015, 0.0036669802);

// Tree: 112 
wFDN_FLA_SD_lgt_112 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 18.95) => -0.0025376122,
(c_hval_150k_p > 18.95) => 
   map(
   (NULL < c_retail and c_retail <= 33.1) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.09775374295) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0184814431) => 0.1295693309,
         (f_add_input_nhood_MFD_pct_i > 0.0184814431) => -0.0171754094,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0451232989, 0.0153699094),
      (f_add_curr_nhood_VAC_pct_i > 0.09775374295) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 132.5) => 0.0051839298,
         (c_cartheft > 132.5) => 0.2244328611,
         (c_cartheft = NULL) => 0.0996050024, 0.0996050024),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0247369611, 0.0247369611),
   (c_retail > 33.1) => 0.2248166434,
   (c_retail = NULL) => 0.0338385041, 0.0338385041),
(c_hval_150k_p = NULL) => 0.0172355375, 0.0016072749);

// Tree: 113 
wFDN_FLA_SD_lgt_113 := map(
(NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => -0.0414215206,
(f_mos_inq_banko_om_lseen_d > 5.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 17714) => -0.0019126501,
   (f_addrchangeincomediff_d > 17714) => 0.0687006620,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 51113.5) => -0.0939996591,
      (r_L80_Inp_AVM_AutoVal_d > 51113.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 151.5) => 
            map(
            (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0680839121) => -0.0240727010,
            (f_add_curr_nhood_VAC_pct_i > 0.0680839121) => 0.1259015332,
            (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0008928531, 0.0008928531),
         (c_robbery > 151.5) => 0.1181072646,
         (c_robbery = NULL) => 0.0174121898, 0.0174121898),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0124952883, -0.0030031974), -0.0005830488),
(f_mos_inq_banko_om_lseen_d = NULL) => 0.0328553139, -0.0024015287);

// Tree: 114 
wFDN_FLA_SD_lgt_114 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 29.5) => -0.0048905882,
(f_rel_under100miles_cnt_d > 29.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.03831902075) => -0.1016728094,
   (f_add_curr_nhood_VAC_pct_i > 0.03831902075) => 0.0364917367,
   (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0604404579, -0.0604404579),
(f_rel_under100miles_cnt_d = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 44.5) => -0.0808262761,
   (c_bel_edu > 44.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 18.5) => 0.0990545571,
         (f_prevaddrageoldest_d > 18.5) => -0.0823560332,
         (f_prevaddrageoldest_d = NULL) => 0.0044729673, 0.0044729673),
      (f_addrs_per_ssn_i > 5.5) => 0.0849459416,
      (f_addrs_per_ssn_i = NULL) => 0.0261095688, 0.0261095688),
   (c_bel_edu = NULL) => -0.0031879229, -0.0031879229), -0.0056862062);

// Tree: 115 
wFDN_FLA_SD_lgt_115 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.1010251073,
(r_F00_dob_score_d > 55) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.25) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0706295869,
      (r_D33_Eviction_Recency_d > 30) => -0.0055607544,
      (r_D33_Eviction_Recency_d = NULL) => -0.0049511279, -0.0049511279),
   (c_pop_0_5_p > 21.25) => 0.1550729020,
   (c_pop_0_5_p = NULL) => 0.0035753592, -0.0041030796),
(r_F00_dob_score_d = NULL) => 
   map(
   (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 0.5) => -0.0302990567,
   (f_hh_age_65_plus_d > 0.5) => 0.2152558787,
   (f_hh_age_65_plus_d = NULL) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 14.75) => -0.0519262390,
      (c_hh4_p > 14.75) => 0.0556335859,
      (c_hh4_p = NULL) => -0.0060810677, -0.0060810677), -0.0017379991), -0.0034435866);

// Tree: 116 
wFDN_FLA_SD_lgt_116 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.45) => -0.0862433365,
(C_OWNOCC_P > 1.45) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13468999415) => -0.0054951112,
   (f_add_curr_nhood_BUS_pct_i > 0.13468999415) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33439.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 92.5) => 0.2103353646,
         (c_burglary > 92.5) => 
            map(
            (NULL < c_hval_200k_p and c_hval_200k_p <= 0.2) => -0.0633985934,
            (c_hval_200k_p > 0.2) => 0.1397274385,
            (c_hval_200k_p = NULL) => 0.0294590212, 0.0294590212),
         (c_burglary = NULL) => 0.0843518418, 0.0843518418),
      (f_curraddrmedianincome_d > 33439.5) => 0.0119641752,
      (f_curraddrmedianincome_d = NULL) => 0.0220753087, 0.0220753087),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0121316485, -0.0014410959),
(C_OWNOCC_P = NULL) => 0.0177549489, -0.0020577443);

// Tree: 117 
wFDN_FLA_SD_lgt_117 := map(
(NULL < c_young and c_young <= 31.45) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 0.1146195709,
      (r_C21_M_Bureau_ADL_FS_d > 6.5) => 
         map(
         (NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => 0.0147158673,
         (f_srchunvrfdssncount_i > 0.5) => 0.0828059855,
         (f_srchunvrfdssncount_i = NULL) => 0.0213811954, 0.0213811954),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0261027826, 0.0261027826),
   (r_Ever_Asset_Owner_d > 0.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 2.5) => 0.0023245191,
      (f_inq_Communications_count_i > 2.5) => -0.0921018506,
      (f_inq_Communications_count_i = NULL) => 0.0013675703, 0.0013675703),
   (r_Ever_Asset_Owner_d = NULL) => -0.0009310412, 0.0056352428),
(c_young > 31.45) => -0.0252266862,
(c_young = NULL) => 0.0059129238, 0.0006780733);

// Tree: 118 
wFDN_FLA_SD_lgt_118 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 85.5) => 
   map(
   (NULL < nf_altlexid_addr_hi_no_hi_lexid and nf_altlexid_addr_hi_no_hi_lexid <= 0.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 4.5) => -0.0056821908,
      (k_inq_per_ssn_i > 4.5) => 0.0347775058,
      (k_inq_per_ssn_i = NULL) => -0.0034834407, -0.0034834407),
   (nf_altlexid_addr_hi_no_hi_lexid > 0.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 14.15) => 
         map(
         (NULL < c_unempl and c_unempl <= 166) => -0.0457109104,
         (c_unempl > 166) => -0.1462951501,
         (c_unempl = NULL) => -0.0595478958, -0.0595478958),
      (c_hval_175k_p > 14.15) => 0.0534145953,
      (c_hval_175k_p = NULL) => -0.0388096415, -0.0388096415),
   (nf_altlexid_addr_hi_no_hi_lexid = NULL) => -0.0153906396, -0.0049051785),
(k_comb_age_d > 85.5) => 0.1003647174,
(k_comb_age_d = NULL) => -0.0041997831, -0.0041997831);

// Tree: 119 
wFDN_FLA_SD_lgt_119 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0082988653,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 23.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 39.5) => 0.0873370120,
      (r_A50_pb_total_dollars_d > 39.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 0.95) => -0.0040968639,
         (c_hh7p_p > 0.95) => -0.0842664208,
         (c_hh7p_p = NULL) => -0.0336210633, -0.0336210633),
      (r_A50_pb_total_dollars_d = NULL) => -0.0134613841, -0.0134613841),
   (f_rel_incomeover25_count_d > 23.5) => -0.1584053274,
   (f_rel_incomeover25_count_d = NULL) => -0.0308306996, -0.0308306996),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0264216394,
   (c_rich_nfam > 124) => -0.0811289711,
   (c_rich_nfam = NULL) => -0.0245233866, -0.0245233866), 0.0064891973);

// Tree: 120 
wFDN_FLA_SD_lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1920.5) => -0.0062976947,
(c_popover18 > 1920.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 2.25) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 22.65) => 0.0133303112,
         (c_hval_150k_p > 22.65) => 0.1895516231,
         (c_hval_150k_p = NULL) => 0.0421063347, 0.0421063347),
      (f_rel_felony_count_i > 0.5) => 
         map(
         (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => 0.2029760325,
         (r_A44_curr_add_naprop_d > 1.5) => 0.0637273146,
         (r_A44_curr_add_naprop_d = NULL) => 0.1245965146, 0.1245965146),
      (f_rel_felony_count_i = NULL) => 0.0581434244, 0.0581434244),
   (c_hval_500k_p > 2.25) => -0.0029005460,
   (c_hval_500k_p = NULL) => 0.0196727350, 0.0196727350),
(c_popover18 = NULL) => -0.0288291457, -0.0019873565);

// Tree: 121 
wFDN_FLA_SD_lgt_121 := map(
(NULL < c_hh3_p and c_hh3_p <= 40) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0485647185,
   (f_mos_inq_banko_om_fseen_d > 5.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 3.5) => 0.0503029877,
         (f_rel_homeover300_count_d > 3.5) => -0.0240998516,
         (f_rel_homeover300_count_d = NULL) => 0.0298847449, 0.0298847449),
      (r_I60_inq_comm_recency_d > 549) => -0.0022827333,
      (r_I60_inq_comm_recency_d = NULL) => 0.0003972049, 0.0003972049),
   (f_mos_inq_banko_om_fseen_d = NULL) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 12.25) => -0.0493632987,
      (c_hh4_p > 12.25) => 0.0609473337,
      (c_hh4_p = NULL) => 0.0052459253, 0.0052459253), -0.0016382470),
(c_hh3_p > 40) => 0.1538915308,
(c_hh3_p = NULL) => 0.0067494086, -0.0008460087);

// Tree: 122 
wFDN_FLA_SD_lgt_122 := map(
(NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.00940684675) => -0.1466492153,
      (f_add_input_nhood_BUS_pct_i > 0.00940684675) => -0.0140771523,
      (f_add_input_nhood_BUS_pct_i = NULL) => -0.0362463936, -0.0362463936),
   (nf_vf_hi_risk_index > 4.5) => 0.0009457519,
   (nf_vf_hi_risk_index = NULL) => 0.0000076800, 0.0000076800),
(r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 21.9) => 0.1567208702,
   (c_high_ed > 21.9) => 
      map(
      (NULL < c_professional and c_professional <= 7.05) => -0.0921527437,
      (c_professional > 7.05) => 0.0933455391,
      (c_professional = NULL) => 0.0183839043, 0.0183839043),
   (c_high_ed = NULL) => 0.0552274178, 0.0552274178),
(r_C14_Addrs_Per_ADL_c6_i = NULL) => 0.0039896430, 0.0009144103);

// Tree: 123 
wFDN_FLA_SD_lgt_123 := map(
(NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0060994908,
(c_easiqlife > 132.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 25.85) => 
      map(
      (NULL < c_transport and c_transport <= 28.7) => 0.0100467341,
      (c_transport > 28.7) => 0.1703501376,
      (c_transport = NULL) => 0.0120450313, 0.0120450313),
   (C_INC_75K_P > 25.85) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 100725.5) => 0.1920015799,
      (r_L80_Inp_AVM_AutoVal_d > 100725.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 17.5) => 0.2340630356,
         (c_born_usa > 17.5) => 0.0244720107,
         (c_born_usa = NULL) => 0.0771278840, 0.0771278840),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0136694782, 0.0688365050),
   (C_INC_75K_P = NULL) => 0.0174397087, 0.0174397087),
(c_easiqlife = NULL) => -0.0077702180, 0.0020863886);

// Tree: 124 
wFDN_FLA_SD_lgt_124 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 2.5) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 16.05) => -0.0119600296,
   (c_blue_col > 16.05) => -0.1308573378,
   (c_blue_col = NULL) => -0.0513493219, -0.0513493219),
(nf_vf_hi_risk_index > 2.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 42.55) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => 0.0019932383,
      (k_inq_per_ssn_i > 1.5) => 0.0307150107,
      (k_inq_per_ssn_i = NULL) => 0.0075548817, 0.0075548817),
   (c_high_ed > 42.55) => -0.0266500651,
   (c_high_ed = NULL) => -0.0205241522, -0.0028643568),
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 90) => 0.0555135161,
   (c_very_rich > 90) => -0.0541258348,
   (c_very_rich = NULL) => -0.0013748263, -0.0013748263), -0.0034782855);

// Tree: 125 
wFDN_FLA_SD_lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 81.5) => -0.0138439004,
   (f_prevaddrageoldest_d > 81.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 0.0704946343,
      (r_F00_dob_score_d > 95) => 0.0078725438,
      (r_F00_dob_score_d = NULL) => -0.0048774950, 0.0099746362),
   (f_prevaddrageoldest_d = NULL) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.26975069405) => -0.0375510309,
      (f_add_input_mobility_index_i > 0.26975069405) => 0.0836832842,
      (f_add_input_mobility_index_i = NULL) => 0.0230661267, 0.0230661267), -0.0031983081),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => 0.0069361141,
   (f_addrs_per_ssn_i > 7.5) => 0.2229067512,
   (f_addrs_per_ssn_i = NULL) => 0.0840684845, 0.0840684845),
(f_nae_nothing_found_i = NULL) => -0.0019462343, -0.0019462343);

// Tree: 126 
wFDN_FLA_SD_lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 3.35) => -0.0534069541,
      (c_rnt1000_p > 3.35) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.67) => 0.1399698203,
         (c_hhsize > 2.67) => 0.0217313598,
         (c_hhsize = NULL) => 0.0825081386, 0.0825081386),
      (c_rnt1000_p = NULL) => 0.0374862641, 0.0374862641),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.55) => -0.0763423074,
      (C_OWNOCC_P > 1.55) => 0.0040192405,
      (C_OWNOCC_P = NULL) => -0.0217279547, 0.0024488242),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0000688198, 0.0028847272),
(r_L72_Add_Vacant_i > 0.5) => 0.1064422481,
(r_L72_Add_Vacant_i = NULL) => 0.0035951999, 0.0035951999);

// Tree: 127 
wFDN_FLA_SD_lgt_127 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0055283409,
(f_prevaddroccupantowned_i > 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 66832) => 0.1391323756,
   (r_A46_Curr_AVM_AutoVal_d > 66832) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 10.45) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 102.5) => -0.0296597079,
         (c_mort_indx > 102.5) => 0.2471716473,
         (c_mort_indx = NULL) => 0.1202906095, 0.1202906095),
      (c_hh3_p > 10.45) => -0.0002272378,
      (c_hh3_p = NULL) => 0.0267041247, 0.0267041247),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 150.5) => -0.0438321573,
      (c_sub_bus > 150.5) => 0.1137368212,
      (c_sub_bus = NULL) => 0.0105019732, 0.0105019732), 0.0299636297),
(f_prevaddroccupantowned_i = NULL) => -0.0077899625, -0.0030317061);

// Tree: 128 
wFDN_FLA_SD_lgt_128 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 54.5) => -0.0110076755,
(r_C13_Curr_Addr_LRes_d > 54.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 41.45) => 0.0094345891,
   (c_hval_750k_p > 41.45) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 17.45) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 512101) => 0.2478510488,
         (f_prevaddrmedianvalue_d > 512101) => 
            map(
            (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 113.5) => -0.0076589573,
            (r_A50_pb_average_dollars_d > 113.5) => 0.1556450484,
            (r_A50_pb_average_dollars_d = NULL) => 0.0705779428, 0.0705779428),
         (f_prevaddrmedianvalue_d = NULL) => 0.1057082839, 0.1057082839),
      (c_pop_25_34_p > 17.45) => -0.0594812492,
      (c_pop_25_34_p = NULL) => 0.0662314349, 0.0662314349),
   (c_hval_750k_p = NULL) => -0.0230904807, 0.0122424052),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0193526371, 0.0017152580);

// Tree: 129 
wFDN_FLA_SD_lgt_129 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 31.9) => 
      map(
      (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 3.5) => 0.1503454324,
      (r_C12_source_profile_index_d > 3.5) => -0.0298814058,
      (r_C12_source_profile_index_d = NULL) => 0.0120318124, 0.0120318124),
   (c_rnt1000_p > 31.9) => 0.1633612760,
   (c_rnt1000_p = NULL) => 0.0495332830, 0.0495332830),
(r_I61_inq_collection_recency_d > 4.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.005) => -0.0072801481,
   (c_hhsize > 4.005) => 0.0609264017,
   (c_hhsize = NULL) => 0.0271982458, -0.0054345338),
(r_I61_inq_collection_recency_d = NULL) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.6) => -0.0843445101,
   (c_hval_175k_p > 2.6) => 0.0308374483,
   (c_hval_175k_p = NULL) => -0.0205830688, -0.0205830688), -0.0040525199);

// Tree: 130 
wFDN_FLA_SD_lgt_130 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 48.45) => 
   map(
   (NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 1900) => -0.0065933001,
   (f_acc_damage_amt_last_i > 1900) => 0.1119495488,
   (f_acc_damage_amt_last_i = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 98.5) => 0.0457332600,
      (c_many_cars > 98.5) => -0.0640648906,
      (c_many_cars = NULL) => -0.0055742870, -0.0055742870), -0.0055546671),
(c_rnt2001_p > 48.45) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 143.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 179.5) => -0.0251387793,
      (c_work_home > 179.5) => 0.1898277584,
      (c_work_home = NULL) => 0.0327705737, 0.0327705737),
   (c_lar_fam > 143.5) => 0.2366067715,
   (c_lar_fam = NULL) => 0.0684590663, 0.0684590663),
(c_rnt2001_p = NULL) => 0.0288915497, -0.0030098112);

// Tree: 131 
wFDN_FLA_SD_lgt_131 := map(
(NULL < c_white_col and c_white_col <= 11.65) => -0.1055882800,
(c_white_col > 11.65) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 29947) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 2.5) => 0.1635439132,
      (r_C14_addrs_15yr_i > 2.5) => -0.0370039430,
      (r_C14_addrs_15yr_i = NULL) => 0.0611057996, 0.0611057996),
   (r_L80_Inp_AVM_AutoVal_d > 29947) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.0860283850,
      (r_C10_M_Hdr_FS_d > 7.5) => 0.0001230722,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0612398386, 0.0014991847),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 13.5) => -0.0022252239,
      (f_srchaddrsrchcount_i > 13.5) => 0.0511475544,
      (f_srchaddrsrchcount_i = NULL) => -0.0512740059, -0.0009362931), 0.0011469144),
(c_white_col = NULL) => -0.0002681505, 0.0005085121);

// Tree: 132 
wFDN_FLA_SD_lgt_132 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0012792746,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2151892900,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 0.0003478880,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < c_rental and c_rental <= 121.5) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 6.9) => 0.1591982883,
         (c_pop_65_74_p > 6.9) => 0.0406854721,
         (c_pop_65_74_p = NULL) => 0.1030606385, 0.1030606385),
      (c_rental > 121.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 64.5) => 0.0499177852,
         (c_no_labfor > 64.5) => -0.0898232465,
         (c_no_labfor = NULL) => -0.0268768358, -0.0268768358),
      (c_rental = NULL) => 0.0389581512, 0.0389581512),
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0045853027, 0.0016971931), 0.0012214541);

// Tree: 133 
wFDN_FLA_SD_lgt_133 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 78.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 61.6) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 4.25) => 0.2180318150,
         (c_hval_200k_p > 4.25) => 0.0334559791,
         (c_hval_200k_p = NULL) => 0.1275534641, 0.1275534641),
      (r_C12_source_profile_d > 61.6) => -0.0113589444,
      (r_C12_source_profile_d = NULL) => 0.0552165877, 0.0552165877),
   (f_mos_liens_unrel_SC_fseen_d > 87.5) => 
      map(
      (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => -0.0101621659,
      (f_bus_name_nover_i > 0.5) => 0.0166393008,
      (f_bus_name_nover_i = NULL) => 0.0006729793, 0.0006729793),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0068120270, 0.0016641575),
(f_bus_addr_match_count_d > 78.5) => 0.1609818670,
(f_bus_addr_match_count_d = NULL) => 0.0022921343, 0.0022921343);

// Tree: 134 
wFDN_FLA_SD_lgt_134 := map(
(NULL < f_idverrisktype_i and f_idverrisktype_i <= 5.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 0.0573723656,
   (f_M_Bureau_ADL_FS_noTU_d > 8.5) => 0.0028415709,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0039340237, 0.0039340237),
(f_idverrisktype_i > 5.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 19.05) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3192899688) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 55.95) => -0.0216893690,
         (c_lowinc > 55.95) => 0.0857528458,
         (c_lowinc = NULL) => -0.0130939918, -0.0130939918),
      (f_add_input_mobility_index_i > 0.3192899688) => -0.0653995583,
      (f_add_input_mobility_index_i = NULL) => -0.0348252613, -0.0348252613),
   (c_hval_200k_p > 19.05) => 0.0614933859,
   (c_hval_200k_p = NULL) => 0.0406654722, -0.0231462599),
(f_idverrisktype_i = NULL) => -0.0026176745, 0.0011163614);

// Tree: 135 
wFDN_FLA_SD_lgt_135 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => -0.0035650834,
(f_srchcomponentrisktype_i > 2.5) => 
   map(
   (NULL < c_food and c_food <= 3.45) => 0.1466975781,
   (c_food > 3.45) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 4.95) => -0.0300272115,
      (c_hval_150k_p > 4.95) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 38.5) => 0.1900788548,
         (f_prevaddrmurderindex_i > 38.5) => 
            map(
            (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 87) => 0.1227286533,
            (r_A50_pb_average_dollars_d > 87) => -0.0449306645,
            (r_A50_pb_average_dollars_d = NULL) => 0.0251564274, 0.0251564274),
         (f_prevaddrmurderindex_i = NULL) => 0.0730989935, 0.0730989935),
      (c_hval_150k_p = NULL) => 0.0124074949, 0.0124074949),
   (c_food = NULL) => 0.0348783454, 0.0348783454),
(f_srchcomponentrisktype_i = NULL) => 0.0037207984, -0.0019499678);

// Tree: 136 
wFDN_FLA_SD_lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.25) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 23.45) => 0.0079466781,
      (c_hh3_p > 23.45) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 66) => 0.1907780829,
         (f_prevaddrcartheftindex_i > 66) => 0.0251184805,
         (f_prevaddrcartheftindex_i = NULL) => 0.0810845623, 0.0810845623),
      (c_hh3_p = NULL) => 0.0176156436, 0.0176156436),
   (c_hh7p_p > 7.25) => 0.1414633046,
   (c_hh7p_p = NULL) => 0.0805298275, 0.0242422795),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0200768081,
   (f_hh_criminals_i > 0.5) => 0.0110091364,
   (f_hh_criminals_i = NULL) => -0.0090753362, -0.0090753362),
(f_hh_members_ct_d = NULL) => -0.0043719444, -0.0027303984);

// Tree: 137 
wFDN_FLA_SD_lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 40.1) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0598674257,
      (r_D33_Eviction_Recency_d > 30) => -0.0001822398,
      (r_D33_Eviction_Recency_d = NULL) => 0.0002094867, 0.0002094867),
   (c_hval_80k_p > 40.1) => -0.0791538967,
   (c_hval_80k_p = NULL) => 0.0268403124, 0.0000831056),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.25) => -0.1139533056,
   (C_INC_75K_P > 15.25) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 100.5) => -0.0691655694,
      (c_blue_empl > 100.5) => 0.0528191788,
      (c_blue_empl = NULL) => -0.0040520889, -0.0040520889),
   (C_INC_75K_P = NULL) => -0.0364991148, -0.0364991148),
(f_inq_HighRiskCredit_count24_i = NULL) => -0.0092921205, -0.0006066952);

// Tree: 138 
wFDN_FLA_SD_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 59.45) => 0.0015997693,
   (c_lowinc > 59.45) => -0.0415299726,
   (c_lowinc = NULL) => -0.0226857523, -0.0004766203),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 64.1) => 
         map(
         (NULL < c_no_car and c_no_car <= 178.5) => 0.1743293511,
         (c_no_car > 178.5) => -0.0091536639,
         (c_no_car = NULL) => 0.0752809979, 0.0752809979),
      (c_fammar_p > 64.1) => -0.0881643368,
      (c_fammar_p = NULL) => -0.0026582127, -0.0026582127),
   (f_vardobcountnew_i > 0.5) => 0.1608009946,
   (f_vardobcountnew_i = NULL) => 0.0449512652, 0.0449512652),
(f_curraddrcrimeindex_i = NULL) => -0.0275691842, 0.0004121282);

// Tree: 139 
wFDN_FLA_SD_lgt_139 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 113500) => -0.0040556645,
(k_estimated_income_d > 113500) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 3.5) => 0.0087261087,
   (f_bus_addr_match_count_d > 3.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 13.85) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 624459) => 0.1659956710,
         (f_prevaddrmedianvalue_d > 624459) => 0.4124523782,
         (f_prevaddrmedianvalue_d = NULL) => 0.2572759329, 0.2572759329),
      (c_pop_55_64_p > 13.85) => -0.0348599372,
      (c_pop_55_64_p = NULL) => 0.1404215849, 0.1404215849),
   (f_bus_addr_match_count_d = NULL) => 0.0429426008, 0.0429426008),
(k_estimated_income_d = NULL) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 7.05) => -0.0518864508,
   (C_INC_25K_P > 7.05) => 0.0694207591,
   (C_INC_25K_P = NULL) => 0.0065615685, 0.0065615685), -0.0007508572);

// Tree: 140 
wFDN_FLA_SD_lgt_140 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => -0.0022123895,
   (f_inq_Communications_count24_i > 2.5) => 0.0627691914,
   (f_inq_Communications_count24_i = NULL) => -0.0017510811, -0.0017510811),
(f_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.0990924731,
      (f_adl_util_conv_n > 0.5) => -0.1077221523,
      (f_adl_util_conv_n = NULL) => 0.0109419770, 0.0109419770),
   (r_C23_inp_addr_occ_index_d > 2) => 0.1435594598,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0536742770, 0.0536742770),
(f_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 1.45) => -0.0685053902,
   (c_hval_125k_p > 1.45) => 0.0420709907,
   (c_hval_125k_p = NULL) => -0.0126697919, -0.0126697919), -0.0010584185);

// Tree: 141 
wFDN_FLA_SD_lgt_141 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 8.65) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 7.45) => 0.0073240698,
      (c_rnt2000_p > 7.45) => 0.1828553756,
      (c_rnt2000_p = NULL) => 0.0460442108, 0.0460442108),
   (c_fammar18_p > 8.65) => -0.0070375585,
   (c_fammar18_p = NULL) => -0.0321949823, -0.0055744344),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < c_pop00 and c_pop00 <= 2238.5) => 0.0026961825,
   (c_pop00 > 2238.5) => 0.1542436400,
   (c_pop00 = NULL) => 0.0535976186, 0.0535976186),
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.8) => -0.0498784698,
   (c_pop_35_44_p > 15.8) => 0.0561268467,
   (c_pop_35_44_p = NULL) => 0.0002331343, 0.0002331343), -0.0042749286);

// Tree: 142 
wFDN_FLA_SD_lgt_142 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 68.5) => 0.0063223206,
   (c_work_home > 68.5) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 6.85) => -0.0153357874,
      (c_lowrent > 6.85) => -0.1156400866,
      (c_lowrent = NULL) => -0.0627432920, -0.0627432920),
   (c_work_home = NULL) => -0.0351170470, -0.0351170470),
(nf_vf_hi_risk_index > 4.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 187) => 0.0002013147,
   (f_fp_prevaddrcrimeindex_i > 187) => 0.0520359739,
   (f_fp_prevaddrcrimeindex_i = NULL) => 0.0017185094, 0.0017185094),
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 0.5) => -0.0578981599,
   (c_hval_125k_p > 0.5) => 0.0536851378,
   (c_hval_125k_p = NULL) => 0.0018786067, 0.0018786067), 0.0007355498);

// Tree: 143 
wFDN_FLA_SD_lgt_143 := map(
(NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 0.0022965223,
   (f_inq_PrepaidCards_count_i > 2.5) => 0.0799758549,
   (f_inq_PrepaidCards_count_i = NULL) => 0.0026559370, 0.0026559370),
(f_inq_Auto_count24_i > 1.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 129.5) => 
      map(
      (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 0.0789684650,
      (r_I60_inq_banking_recency_d > 9) => -0.0402658982,
      (r_I60_inq_banking_recency_d = NULL) => -0.0233006882, -0.0233006882),
   (c_bel_edu > 129.5) => -0.0993044934,
   (c_bel_edu = NULL) => -0.0431179766, -0.0431179766),
(f_inq_Auto_count24_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1281) => 0.0569846470,
   (c_popover18 > 1281) => -0.0542776843,
   (c_popover18 = NULL) => 0.0008611702, 0.0008611702), 0.0001854567);

// Tree: 144 
wFDN_FLA_SD_lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1169677400,
   (f_mos_liens_unrel_FT_lseen_d > 39.5) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 28.5) => -0.0014162670,
      (f_rel_under500miles_cnt_d > 28.5) => -0.0588347823,
      (f_rel_under500miles_cnt_d = NULL) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 102.5) => -0.0556802105,
         (c_many_cars > 102.5) => 0.1317373265,
         (c_many_cars = NULL) => -0.0071940815, -0.0071940815), -0.0026283892),
   (f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0115105359, -0.0021878286),
(c_rnt2001_p > 49) => 
   map(
   (NULL < c_rnt1500_p and c_rnt1500_p <= 9.15) => 0.0319027263,
   (c_rnt1500_p > 9.15) => 0.2241463170,
   (c_rnt1500_p = NULL) => 0.0680673622, 0.0680673622),
(c_rnt2001_p = NULL) => 0.0094640432, -0.0002506468);

// Tree: 145 
wFDN_FLA_SD_lgt_145 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 57.5) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 21102.5) => -0.0765901667,
      (c_med_hhinc > 21102.5) => -0.0069487832,
      (c_med_hhinc = NULL) => 0.0112858784, -0.0076713364),
   (k_comb_age_d > 57.5) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 0.0211273847,
      (f_srchcomponentrisktype_i > 2.5) => 0.1304992650,
      (f_srchcomponentrisktype_i = NULL) => 0.0242848728, 0.0242848728),
   (k_comb_age_d = NULL) => -0.0012687990, -0.0012687990),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 70) => 0.1885384366,
   (f_prevaddrageoldest_d > 70) => -0.0210094597,
   (f_prevaddrageoldest_d = NULL) => 0.0656456854, 0.0656456854),
(f_hh_lienholders_i = NULL) => -0.0115898070, -0.0006518308);

// Tree: 146 
wFDN_FLA_SD_lgt_146 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 190.5) => -0.0056926099,
         (f_curraddrcrimeindex_i > 190.5) => 0.0658429246,
         (f_curraddrcrimeindex_i = NULL) => -0.0043140304, -0.0043140304),
      (f_fp_prevaddrcrimeindex_i > 197.5) => -0.1045626055,
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0047504560, -0.0047504560),
   (f_assocsuspicousidcount_i > 14.5) => 0.0732891984,
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0481366230,
      (c_high_hval > 3.7) => 0.0771207589,
      (c_high_hval = NULL) => 0.0151001135, 0.0151001135), -0.0040813489),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1117660121,
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0032502799, -0.0032502799);

// Tree: 147 
wFDN_FLA_SD_lgt_147 := map(
(NULL < c_hh5_p and c_hh5_p <= 10.55) => -0.0054139404,
(c_hh5_p > 10.55) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 113.85) => 0.1389730454,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 113.85) => -0.0625351092,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 143.5) => 0.0224733293,
         (c_easiqlife > 143.5) => 0.1541009903,
         (c_easiqlife = NULL) => 0.0584709493, 0.0584709493), 0.0590906079),
   (f_prevaddrstatus_i > 2.5) => 0.0087103022,
   (f_prevaddrstatus_i = NULL) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.6648632063) => 0.0020261607,
      (f_add_curr_nhood_MFD_pct_i > 0.6648632063) => 0.1928321386,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0136752424, 0.0034454521), 0.0162007935),
(c_hh5_p = NULL) => -0.0424324589, -0.0018842791);

// Tree: 148 
wFDN_FLA_SD_lgt_148 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0072600766,
(k_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 20.45) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 6.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.1062366385,
         (r_C21_M_Bureau_ADL_FS_d > 7.5) => 0.0108639745,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0141145765, 0.0141145765),
      (r_D30_Derog_Count_i > 6.5) => -0.0931315088,
      (r_D30_Derog_Count_i = NULL) => 0.0101034040, 0.0101034040),
   (c_hval_150k_p > 20.45) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 71.5) => 0.1742295849,
      (c_old_homes > 71.5) => -0.0085814181,
      (c_old_homes = NULL) => 0.0979648720, 0.0979648720),
   (c_hval_150k_p = NULL) => 0.0185576067, 0.0185576067),
(k_inq_ssns_per_addr_i = NULL) => -0.0037736208, -0.0037736208);

// Tree: 149 
wFDN_FLA_SD_lgt_149 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 68.5) => -0.0994855706,
   (f_mos_inq_banko_cm_fseen_d > 68.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 34.55) => -0.0789902765,
      (C_OWNOCC_P > 34.55) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 13.65) => -0.0206529623,
         (c_pop_25_34_p > 13.65) => 0.0985401716,
         (c_pop_25_34_p = NULL) => 0.0393916992, 0.0393916992),
      (C_OWNOCC_P = NULL) => -0.0040150253, -0.0040150253),
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0336965730, -0.0336965730),
(nf_vf_hi_risk_index > 4.5) => 0.0054387774,
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 4.55) => -0.0494742702,
   (c_femdiv_p > 4.55) => 0.0646450245,
   (c_femdiv_p = NULL) => 0.0039209961, 0.0039209961), 0.0044628042);

// Tree: 150 
wFDN_FLA_SD_lgt_150 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0167774853,
(f_corrrisktype_i > 5.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 22.85) => 
      map(
      (NULL < c_unempl and c_unempl <= 33.5) => -0.0670547682,
      (c_unempl > 33.5) => 0.0099333515,
      (c_unempl = NULL) => 0.0038635793, 0.0038635793),
   (C_INC_50K_P > 22.85) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.4105308332) => 
         map(
         (NULL < c_rental and c_rental <= 67.5) => 0.1569068008,
         (c_rental > 67.5) => 0.0016795605,
         (c_rental = NULL) => 0.0547659327, 0.0547659327),
      (f_add_curr_mobility_index_i > 0.4105308332) => 0.1522201811,
      (f_add_curr_mobility_index_i = NULL) => 0.0721065463, 0.0721065463),
   (C_INC_50K_P = NULL) => 0.0086463730, 0.0071750751),
(f_corrrisktype_i = NULL) => -0.0012827420, -0.0049753462);

// Tree: 151 
wFDN_FLA_SD_lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 17.35) => 0.0338903425,
      (c_hh2_p > 17.35) => -0.0053054352,
      (c_hh2_p = NULL) => -0.0186647447, -0.0033654467),
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 37.2) => -0.0336094532,
      (c_low_ed > 37.2) => 0.1429285081,
      (c_low_ed = NULL) => 0.0473712630, 0.0473712630),
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0029154088, -0.0029154088),
(r_C14_addrs_10yr_i > 10.5) => 0.1056934732,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.695) => 0.0390153173,
   (c_hhsize > 2.695) => -0.0662474480,
   (c_hhsize = NULL) => -0.0092703548, -0.0092703548), -0.0025207389);

// Tree: 152 
wFDN_FLA_SD_lgt_152 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 0.0080485956,
(c_pop_18_24_p > 11.15) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 7.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 43521) => 0.0548629045,
      (r_L80_Inp_AVM_AutoVal_d > 43521) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 44.65) => 
            map(
            (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 0.0306092410,
            (f_historical_count_d > 0.5) => -0.0563290331,
            (f_historical_count_d = NULL) => -0.0077640469, -0.0077640469),
         (c_hh2_p > 44.65) => 0.1693318517,
         (c_hh2_p = NULL) => 0.0014783316, 0.0014783316),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0362532767, -0.0170309498),
   (f_inq_Collection_count_i > 7.5) => -0.0845912302,
   (f_inq_Collection_count_i = NULL) => -0.0205017598, -0.0205017598),
(c_pop_18_24_p = NULL) => 0.0236176741, 0.0020335676);

// Tree: 153 
wFDN_FLA_SD_lgt_153 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 15.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0001201826,
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < c_construction and c_construction <= 6.85) => 0.0656898848,
      (c_construction > 6.85) => 0.0003151464,
      (c_construction = NULL) => 0.0346340710, 0.0346340710),
   (k_inq_per_ssn_i = NULL) => 0.0037134633, 0.0037134633),
(f_rel_incomeover25_count_d > 15.5) => -0.0220503421,
(f_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.15) => -0.0913364971,
   (c_pop_35_44_p > 13.15) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 36.4) => -0.0689839107,
      (c_sfdu_p > 36.4) => 0.0665799847,
      (c_sfdu_p = NULL) => 0.0172840227, 0.0172840227),
   (c_pop_35_44_p = NULL) => -0.0243369241, -0.0243369241), -0.0004937764);

// Tree: 154 
wFDN_FLA_SD_lgt_154 := map(
(NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 16.15) => -0.0072503582,
   (c_hval_500k_p > 16.15) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 0.0147818993,
      (k_comb_age_d > 71.5) => 0.1242183785,
      (k_comb_age_d = NULL) => 0.0197798600, 0.0197798600),
   (c_hval_500k_p = NULL) => 0.0107218216, -0.0017978891),
(f_attr_arrests_i > 0.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 126.5) => -0.0116087533,
   (c_burglary > 126.5) => 0.1477424072,
   (c_burglary = NULL) => 0.0516258342, 0.0516258342),
(f_attr_arrests_i = NULL) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.45) => -0.0708646292,
   (c_pop_75_84_p > 3.45) => 0.0222182468,
   (c_pop_75_84_p = NULL) => -0.0239113201, -0.0239113201), -0.0014764246);

// Tree: 155 
wFDN_FLA_SD_lgt_155 := map(
(NULL < c_unempl and c_unempl <= 190.5) => 
   map(
   (NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 19.5) => -0.1002997155,
   (f_mos_liens_unrel_OT_fseen_d > 19.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 34701) => -0.0013957995,
      (f_addrchangevaluediff_d > 34701) => 
         map(
         (NULL < c_lux_prod and c_lux_prod <= 112.5) => 0.1026318887,
         (c_lux_prod > 112.5) => -0.0031122577,
         (c_lux_prod = NULL) => 0.0301057988, 0.0301057988),
      (f_addrchangevaluediff_d = NULL) => -0.0128538469, -0.0026623938),
   (f_mos_liens_unrel_OT_fseen_d = NULL) => 0.0189569403, -0.0029863927),
(c_unempl > 190.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.27882212485) => -0.0234982467,
   (f_add_curr_mobility_index_i > 0.27882212485) => 0.1488286115,
   (f_add_curr_mobility_index_i = NULL) => 0.0685067708, 0.0685067708),
(c_unempl = NULL) => 0.0211067337, -0.0017649574);

// Tree: 156 
wFDN_FLA_SD_lgt_156 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0019406922,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 4.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 39.5) => 0.0640576259,
      (r_A50_pb_total_dollars_d > 39.5) => 
         map(
         (NULL < c_unempl and c_unempl <= 114.5) => 
            map(
            (NULL < c_hh4_p and c_hh4_p <= 21.05) => -0.0388236129,
            (c_hh4_p > 21.05) => 0.0950165898,
            (c_hh4_p = NULL) => -0.0031328922, -0.0031328922),
         (c_unempl > 114.5) => -0.0919792495,
         (c_unempl = NULL) => -0.0383650684, -0.0383650684),
      (r_A50_pb_total_dollars_d = NULL) => -0.0214579729, -0.0214579729),
   (f_crim_rel_under100miles_cnt_i > 4.5) => -0.1109408284,
   (f_crim_rel_under100miles_cnt_i = NULL) => -0.0346064741, -0.0346064741),
(f_srchssnsrchcount_i = NULL) => 0.0009035578, 0.0005143448);

// Tree: 157 
wFDN_FLA_SD_lgt_157 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0143880360,
   (f_util_add_curr_conv_n > 0.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -170627.5) => 0.1217379961,
      (f_addrchangevaluediff_d > -170627.5) => 
         map(
         (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 15.5) => 0.0066078194,
         (f_srchssnsrchcount_i > 15.5) => 0.0938876269,
         (f_srchssnsrchcount_i = NULL) => 0.0074949958, 0.0074949958),
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < c_robbery and c_robbery <= 180.5) => 0.0138490019,
         (c_robbery > 180.5) => 0.1347222062,
         (c_robbery = NULL) => 0.0147203228, 0.0229010724), 0.0112388252),
   (f_util_add_curr_conv_n = NULL) => 0.0000443176, 0.0000443176),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0895901928,
(r_S65_SSN_Prior_DoB_i = NULL) => 0.0004114246, 0.0004114246);

// Tree: 158 
wFDN_FLA_SD_lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 9.95) => -0.0006397766,
         (c_hh6_p > 9.95) => 0.0454424323,
         (c_hh6_p = NULL) => -0.0104722592, 0.0007468023),
      (r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0616054496,
      (r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => -0.0007260061, -0.0007260061),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 2825) => -0.1448707857,
      (r_A50_pb_average_dollars_d > 2825) => 0.0134995186,
      (r_A50_pb_average_dollars_d = NULL) => -0.0590868709, -0.0590868709),
   (r_I60_inq_comm_count12_i = NULL) => -0.0013980007, -0.0013980007),
(r_D33_eviction_count_i > 3.5) => 0.0728736701,
(r_D33_eviction_count_i = NULL) => 0.0187533658, -0.0007936556);

// Tree: 159 
wFDN_FLA_SD_lgt_159 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 4.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 144.5) => -0.0088630424,
   (r_A50_pb_average_dollars_d > 144.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.35078159785) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 0.0176834024,
         (f_hh_collections_ct_i > 4.5) => 0.1074015506,
         (f_hh_collections_ct_i = NULL) => 0.0195206341, 0.0195206341),
      (f_add_curr_mobility_index_i > 0.35078159785) => -0.0193960577,
      (f_add_curr_mobility_index_i = NULL) => 0.1207654614, 0.0125494945),
   (r_A50_pb_average_dollars_d = NULL) => 0.0007074663, 0.0007074663),
(r_D33_eviction_count_i > 4.5) => -0.0768020561,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0484564681,
   (c_assault > 90) => 0.0631440132,
   (c_assault = NULL) => 0.0015713339, 0.0015713339), 0.0004043522);

// Tree: 160 
wFDN_FLA_SD_lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.95) => -0.0056101283,
(r_C12_source_profile_d > 78.95) => 
   map(
   (NULL < c_bargains and c_bargains <= 184.5) => 
      map(
      (NULL < nf_vf_lo_addr_add_entries and nf_vf_lo_addr_add_entries <= 0.5) => 
         map(
         (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 9.5) => 0.0448032798,
         (f_rel_homeover200_count_d > 9.5) => -0.0710500674,
         (f_rel_homeover200_count_d = NULL) => 0.0273923381, 0.0273923381),
      (nf_vf_lo_addr_add_entries > 0.5) => 0.2016363162,
      (nf_vf_lo_addr_add_entries = NULL) => 0.0343078578, 0.0343078578),
   (c_bargains > 184.5) => 0.1734812255,
   (c_bargains = NULL) => 0.0409105973, 0.0409105973),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.75) => -0.0353978593,
   (c_pop_35_44_p > 15.75) => 0.0640592360,
   (c_pop_35_44_p = NULL) => 0.0133743701, 0.0133743701), -0.0004748519);

// Tree: 161 
wFDN_FLA_SD_lgt_161 := map(
(NULL < c_med_age and c_med_age <= 28.05) => -0.0362888353,
(c_med_age > 28.05) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 129.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 5.45) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 50.55) => 
            map(
            (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0224027220,
            (f_sourcerisktype_i > 4.5) => 0.1896306457,
            (f_sourcerisktype_i = NULL) => 0.1076561733, 0.1076561733),
         (c_civ_emp > 50.55) => 0.0006629374,
         (c_civ_emp = NULL) => 0.0370335753, 0.0370335753),
      (c_high_ed > 5.45) => -0.0164579148,
      (c_high_ed = NULL) => -0.0142321634, -0.0142321634),
   (c_easiqlife > 129.5) => 0.0163951187,
   (c_easiqlife = NULL) => -0.0028330793, -0.0028330793),
(c_med_age = NULL) => -0.0318198711, -0.0055958613);

// Tree: 162 
wFDN_FLA_SD_lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => -0.0024173278,
   (f_util_adl_count_n > 13.5) => 0.1145872602,
   (f_util_adl_count_n = NULL) => -0.0015018885, -0.0015018885),
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_rental and c_rental <= 119) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 11.5) => 0.0315366188,
      (f_rel_educationover12_count_d > 11.5) => 0.1627112588,
      (f_rel_educationover12_count_d = NULL) => 0.0934575669, 0.0934575669),
   (c_rental > 119) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 4.65) => 0.0507861789,
      (c_hval_150k_p > 4.65) => -0.0821954750,
      (c_hval_150k_p = NULL) => -0.0186818493, -0.0186818493),
   (c_rental = NULL) => 0.0425196626, 0.0425196626),
(r_D30_Derog_Count_i = NULL) => 0.0116847583, -0.0003485243);

// Tree: 163 
wFDN_FLA_SD_lgt_163 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => -0.0132998491,
(c_pop_35_44_p > 14.75) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 23.85) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','6: Other']) => -0.0028122115,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly']) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 316.5) => 
            map(
            (NULL < c_fammar18_p and c_fammar18_p <= 53.35) => 0.0361312270,
            (c_fammar18_p > 53.35) => -0.0829292195,
            (c_fammar18_p = NULL) => 0.0198010328, 0.0198010328),
         (f_prevaddrageoldest_d > 316.5) => 0.1511070537,
         (f_prevaddrageoldest_d = NULL) => 0.0291068561, 0.0291068561),
      (nf_seg_FraudPoint_3_0 = '') => 0.0052989745, 0.0052989745),
   (C_INC_25K_P > 23.85) => 0.1472288323,
   (C_INC_25K_P = NULL) => 0.0068936920, 0.0068936920),
(c_pop_35_44_p = NULL) => 0.0078063499, -0.0030429924);

// Tree: 164 
wFDN_FLA_SD_lgt_164 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6436) => 0.0019461317,
(f_addrchangeincomediff_d > 6436) => 
   map(
   (NULL < f_inq_Banking_count_i and f_inq_Banking_count_i <= 1.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.71521062195) => 
         map(
         (NULL < c_construction and c_construction <= 3.05) => 0.1578366603,
         (c_construction > 3.05) => 0.0126031825,
         (c_construction = NULL) => 0.0606660600, 0.0606660600),
      (f_add_curr_nhood_MFD_pct_i > 0.71521062195) => 0.1578722304,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0493065947, 0.0588800752),
   (f_inq_Banking_count_i > 1.5) => -0.0892565751,
   (f_inq_Banking_count_i = NULL) => 0.0366922068, 0.0366922068),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 130500) => -0.0019984872,
   (k_estimated_income_d > 130500) => 0.2107738621,
   (k_estimated_income_d = NULL) => 0.0045101122, 0.0034284481), 0.0035248468);

// Tree: 165 
wFDN_FLA_SD_lgt_165 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 62.4) => 
      map(
      (NULL < c_rental and c_rental <= 177.5) => -0.0370222863,
      (c_rental > 177.5) => 0.0958021454,
      (c_rental = NULL) => -0.0213958826, -0.0213958826),
   (c_low_ed > 62.4) => -0.0960580238,
   (c_low_ed = NULL) => -0.0352726546, -0.0352726546),
(f_mos_inq_banko_om_fseen_d > 21.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 0.0048228970,
   (r_D32_felony_count_i > 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 241) => 0.1450742524,
      (r_C10_M_Hdr_FS_d > 241) => -0.0283889934,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0577526185, 0.0577526185),
   (r_D32_felony_count_i = NULL) => 0.0054885943, 0.0054885943),
(f_mos_inq_banko_om_fseen_d = NULL) => 0.0062047963, 0.0026184117);

// Tree: 166 
wFDN_FLA_SD_lgt_166 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 45.5) => 0.1384534648,
   (f_mos_inq_banko_cm_lseen_d > 45.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 82.5) => 0.1482954912,
      (c_rich_fam > 82.5) => -0.0516772783,
      (c_rich_fam = NULL) => 0.0241293925, 0.0241293925),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0542146746, 0.0542146746),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 194.5) => 0.0010944107,
   (c_asian_lang > 194.5) => -0.0539667488,
   (c_asian_lang = NULL) => 0.0210641055, -0.0008657910),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.95) => -0.0617627217,
   (c_pop_6_11_p > 7.95) => 0.0362499886,
   (c_pop_6_11_p = NULL) => -0.0091262662, -0.0091262662), -0.0000312113);

// Tree: 167 
wFDN_FLA_SD_lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.85) => 0.0027736324,
      (c_hval_125k_p > 4.85) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 1.5) => 0.1559168627,
         (f_rel_incomeover50_count_d > 1.5) => 0.0209900420,
         (f_rel_incomeover50_count_d = NULL) => 0.0738908659, 0.0738908659),
      (c_hval_125k_p = NULL) => 0.0188145960, 0.0188145960),
   (r_C12_source_profile_d > 81.3) => 0.1783932885,
   (r_C12_source_profile_d = NULL) => 0.0268815336, 0.0268815336),
(c_many_cars > 22.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.49) => -0.0066204857,
   (c_hhsize > 4.49) => -0.1163830301,
   (c_hhsize = NULL) => -0.0072033473, -0.0072033473),
(c_many_cars = NULL) => 0.0087421842, -0.0038881095);

// Tree: 168 
wFDN_FLA_SD_lgt_168 := map(
(NULL < f_hh_age_30_plus_d and f_hh_age_30_plus_d <= 5.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0050197590,
   (c_hval_150k_p > 23.15) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 17.5) => 
         map(
         (NULL < c_manufacturing and c_manufacturing <= 3.2) => 0.0051413545,
         (c_manufacturing > 3.2) => 
            map(
            (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.02364786605) => 0.0098061636,
            (f_add_input_nhood_BUS_pct_i > 0.02364786605) => 0.2291147290,
            (f_add_input_nhood_BUS_pct_i = NULL) => 0.1439157179, 0.1439157179),
         (c_manufacturing = NULL) => 0.0308063623, 0.0308063623),
      (f_rel_under500miles_cnt_d > 17.5) => 0.1488229920,
      (f_rel_under500miles_cnt_d = NULL) => 0.0410562988, 0.0410562988),
   (c_hval_150k_p = NULL) => 0.0000498539, -0.0017094479),
(f_hh_age_30_plus_d > 5.5) => -0.0506920104,
(f_hh_age_30_plus_d = NULL) => 0.0316588872, -0.0029416712);

// Tree: 169 
wFDN_FLA_SD_lgt_169 := map(
(NULL < f_mos_liens_rel_OT_lseen_d and f_mos_liens_rel_OT_lseen_d <= 55.5) => -0.1005263759,
(f_mos_liens_rel_OT_lseen_d > 55.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 192.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 36.85) => -0.0044060386,
      (c_hval_500k_p > 36.85) => 
         map(
         (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 0.1319094307,
         (f_rel_incomeover100_count_d > 0.5) => -0.0153546606,
         (f_rel_incomeover100_count_d = NULL) => 0.0535408207, 0.0535408207),
      (c_hval_500k_p = NULL) => -0.0027423551, -0.0027423551),
   (c_unempl > 192.5) => 0.0731301696,
   (c_unempl = NULL) => 0.0028713433, -0.0021144041),
(f_mos_liens_rel_OT_lseen_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.85) => -0.0634834923,
   (c_pop_35_44_p > 15.85) => 0.0454927822,
   (c_pop_35_44_p = NULL) => -0.0095348416, -0.0095348416), -0.0029241178);

// Tree: 170 
wFDN_FLA_SD_lgt_170 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0018346550,
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 7.95) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
         map(
         (NULL < c_rnt1500_p and c_rnt1500_p <= 1.6) => 0.1303257769,
         (c_rnt1500_p > 1.6) => -0.0056320875,
         (c_rnt1500_p = NULL) => 0.0790039340, 0.0790039340),
      (r_F01_inp_addr_address_score_d > 95) => 0.0297729856,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0374210033, 0.0374210033),
   (c_femdiv_p > 7.95) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 132.5) => -0.1043621761,
      (c_relig_indx > 132.5) => 0.0250722378,
      (c_relig_indx = NULL) => -0.0510238187, -0.0510238187),
   (c_femdiv_p = NULL) => 0.0234842435, 0.0234842435),
(f_inq_Communications_count_i = NULL) => 0.0108441626, 0.0006265397);

// Tree: 171 
wFDN_FLA_SD_lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 183.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 82.5) => 
         map(
         (NULL < c_hval_100k_p and c_hval_100k_p <= 2.65) => 
            map(
            (NULL < C_INC_75K_P and C_INC_75K_P <= 18.35) => 0.0469879264,
            (C_INC_75K_P > 18.35) => 0.2069159531,
            (C_INC_75K_P = NULL) => 0.1226295606, 0.1226295606),
         (c_hval_100k_p > 2.65) => 0.0064560658,
         (c_hval_100k_p = NULL) => 0.0645428132, 0.0645428132),
      (r_D32_Mos_Since_Crim_LS_d > 82.5) => 0.0020118667,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0129648562, 0.0129648562),
   (f_curraddrcartheftindex_i > 183.5) => 0.0882179832,
   (f_curraddrcartheftindex_i = NULL) => 0.0184422701, 0.0184422701),
(f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0016550336,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0128196715, 0.0011693140);

// Tree: 172 
wFDN_FLA_SD_lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.55) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 3.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27836.5) => 0.0313497353,
         (f_curraddrmedianincome_d > 27836.5) => -0.0005809840,
         (f_curraddrmedianincome_d = NULL) => 0.0014200923, 0.0014200923),
      (f_hh_workers_paw_d > 3.5) => -0.0587135588,
      (f_hh_workers_paw_d = NULL) => 0.0226398122, 0.0002877739),
   (c_manufacturing > 16.55) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 4.5) => -0.0425969503,
      (r_D30_Derog_Count_i > 4.5) => -0.1161766468,
      (r_D30_Derog_Count_i = NULL) => -0.0465066048, -0.0465066048),
   (c_manufacturing = NULL) => -0.0033187803, -0.0033187803),
(c_pop_0_5_p > 20.55) => 0.1457221642,
(c_pop_0_5_p = NULL) => 0.0020700202, -0.0025260140);

// Tree: 173 
wFDN_FLA_SD_lgt_173 := map(
(NULL < c_low_hval and c_low_hval <= 71.55) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 142732.5) => 
      map(
      (NULL < c_food and c_food <= 3.95) => 
         map(
         (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 549) => -0.1035513374,
         (r_I60_inq_hiRiskCred_recency_d > 549) => -0.0149292147,
         (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0259602384, -0.0259602384),
      (c_food > 3.95) => 0.0384887736,
      (c_food = NULL) => 0.0255177330, 0.0255177330),
   (r_L80_Inp_AVM_AutoVal_d > 142732.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 10.5) => -0.0071701126,
      (r_L79_adls_per_addr_curr_i > 10.5) => -0.1078395929,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0086549132, -0.0086549132),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0028784426, 0.0003640293),
(c_low_hval > 71.55) => -0.1110995776,
(c_low_hval = NULL) => -0.0402576641, -0.0012387141);

// Tree: 174 
wFDN_FLA_SD_lgt_174 := map(
(NULL < c_info and c_info <= 27.55) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => -0.0329614685,
   (nf_vf_hi_risk_index > 4.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 9.5) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 135.5) => 0.0134311546,
         (c_new_homes > 135.5) => 
            map(
            (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => -0.0482041903,
            (r_L79_adls_per_addr_curr_i > 1.5) => -0.0021858793,
            (r_L79_adls_per_addr_curr_i = NULL) => -0.0141055953, -0.0141055953),
         (c_new_homes = NULL) => 0.0022069612, 0.0022069612),
      (f_inq_HighRiskCredit_count24_i > 9.5) => 0.0773868061,
      (f_inq_HighRiskCredit_count24_i = NULL) => 0.0025359758, 0.0025359758),
   (nf_vf_hi_risk_index = NULL) => -0.0320071232, 0.0012954669),
(c_info > 27.55) => 0.2154025806,
(c_info = NULL) => -0.0070627553, 0.0022091579);

// Tree: 175 
wFDN_FLA_SD_lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0091058796,
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2) => 0.0076838489,
   (f_idverrisktype_i > 2) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 136.5) => 0.0234745798,
      (c_serv_empl > 136.5) => 
         map(
         (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 
            map(
            (NULL < c_bargains and c_bargains <= 107.5) => -0.0261356574,
            (c_bargains > 107.5) => 0.1843151737,
            (c_bargains = NULL) => 0.0780479224, 0.0780479224),
         (f_util_add_input_misc_n > 0.5) => 0.2546932971,
         (f_util_add_input_misc_n = NULL) => 0.1438784968, 0.1438784968),
      (c_serv_empl = NULL) => 0.0612621639, 0.0612621639),
   (f_idverrisktype_i = NULL) => 0.0180928024, 0.0180928024),
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0075920718, -0.0031005385);

// Tree: 176 
wFDN_FLA_SD_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.05) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0043481344,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 91.5) => -0.0131767973,
         (c_many_cars > 91.5) => 
            map(
            (NULL < c_rape and c_rape <= 112.5) => 0.0621391339,
            (c_rape > 112.5) => 0.2591540058,
            (c_rape = NULL) => 0.1011010302, 0.1011010302),
         (c_many_cars = NULL) => 0.0425076714, 0.0425076714),
      (c_pop_55_64_p > 17.45) => 0.2556210702,
      (c_pop_55_64_p = NULL) => 0.0612390315, 0.0612390315),
   (f_util_adl_count_n = NULL) => 0.0083482658, 0.0080118230),
(c_pop_18_24_p > 11.05) => -0.0233604144,
(c_pop_18_24_p = NULL) => 0.0198174607, 0.0009598689);

// Tree: 177 
wFDN_FLA_SD_lgt_177 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 104.5) => -0.0047674839,
(f_prevaddrageoldest_d > 104.5) => 
   map(
   (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 5.5) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 1.5) => -0.0222777950,
      (r_C18_invalid_addrs_per_adl_i > 1.5) => 0.2930470749,
      (r_C18_invalid_addrs_per_adl_i = NULL) => 0.1338236257, 0.1338236257),
   (r_C20_email_verification_d > 5.5) => -0.1091071085,
   (r_C20_email_verification_d = NULL) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 105.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01676029965) => 0.2125114213,
         (f_add_curr_nhood_VAC_pct_i > 0.01676029965) => -0.0157268850,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1080633828, 0.1080633828),
      (f_prevaddrlenofres_d > 105.5) => 0.0145595071,
      (f_prevaddrlenofres_d = NULL) => 0.0170756889, 0.0170756889), 0.0181720921),
(f_prevaddrageoldest_d = NULL) => -0.0146746064, 0.0033622158);

// Tree: 178 
wFDN_FLA_SD_lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 14.55) => -0.0077491721,
(c_rnt1250_p > 14.55) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.35) => 0.0049366462,
   (c_pop_6_11_p > 9.35) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 15.15) => 
         map(
         (NULL < c_retail and c_retail <= 28.45) => 
            map(
            (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => 0.0633556913,
            (f_inq_Collection_count_i > 3.5) => 0.1524208835,
            (f_inq_Collection_count_i = NULL) => 0.0741402031, 0.0741402031),
         (c_retail > 28.45) => 0.2464321436,
         (c_retail = NULL) => 0.0948528954, 0.0948528954),
      (c_hval_400k_p > 15.15) => 0.0183943279,
      (c_hval_400k_p = NULL) => 0.0573328748, 0.0573328748),
   (c_pop_6_11_p = NULL) => 0.0203229536, 0.0203229536),
(c_rnt1250_p = NULL) => 0.0030495625, 0.0006276507);

// Tree: 179 
wFDN_FLA_SD_lgt_179 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 180.5) => -0.0728566568,
(f_mos_liens_unrel_FT_lseen_d > 180.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0028030580,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 22.75) => 
         map(
         (NULL < c_health and c_health <= 26.85) => 0.0146181944,
         (c_health > 26.85) => 0.1551699490,
         (c_health = NULL) => 0.0273814766, 0.0273814766),
      (C_INC_50K_P > 22.75) => 0.1577717757,
      (C_INC_50K_P = NULL) => 0.0239460300, 0.0335463612),
   (r_L70_Add_Standardized_i = NULL) => 0.0002626262, 0.0002626262),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 7.15) => -0.0211195762,
   (c_vacant_p > 7.15) => 0.0887257105,
   (c_vacant_p = NULL) => 0.0288100996, 0.0288100996), -0.0002925873);

// Tree: 180 
wFDN_FLA_SD_lgt_180 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 20.5) => -0.0013214693,
   (f_rel_incomeover50_count_d > 20.5) => -0.0455854319,
   (f_rel_incomeover50_count_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 6.65) => -0.0174661455,
      (c_hval_200k_p > 6.65) => 0.1730643660,
      (c_hval_200k_p = NULL) => 0.0334778415, 0.0334778415), -0.0019089943),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 104.5) => 0.2254567447,
   (c_easiqlife > 104.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 0.5) => 0.0627900004,
      (f_rel_homeover500_count_d > 0.5) => -0.0453311067,
      (f_rel_homeover500_count_d = NULL) => 0.0157808234, 0.0157808234),
   (c_easiqlife = NULL) => 0.0712506438, 0.0712506438),
(f_phones_per_addr_curr_i = NULL) => 0.0071013893, -0.0007299088);

// Tree: 181 
wFDN_FLA_SD_lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 5.45) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1008.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => -0.0004434840,
         (r_L79_adls_per_addr_c6_i > 2.5) => 0.1898663240,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0558611929, 0.0558611929),
      (c_popover18 > 1008.5) => -0.0370594351,
      (c_popover18 = NULL) => -0.0075414161, -0.0075414161),
   (c_hval_200k_p > 5.45) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0623861375) => 0.0711001479,
      (f_add_input_nhood_VAC_pct_i > 0.0623861375) => 0.2531891977,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.1096335153, 0.1096335153),
   (c_hval_200k_p = NULL) => 0.0289904836, 0.0289904836),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0052243085,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0128040205, -0.0029682257);

// Tree: 182 
wFDN_FLA_SD_lgt_182 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0041213599,
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03655072715) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 1.25) => 0.0154836711,
      (c_hval_100k_p > 1.25) => 
         map(
         (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 0.0598989484,
         (f_inq_Other_count_i > 0.5) => 0.1616322766,
         (f_inq_Other_count_i = NULL) => 0.0964650201, 0.0964650201),
      (c_hval_100k_p = NULL) => 0.0504387541, 0.0504387541),
   (f_add_curr_nhood_BUS_pct_i > 0.03655072715) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 15.5) => 0.0072927440,
      (f_rel_homeover50_count_d > 15.5) => -0.0726525043,
      (f_rel_homeover50_count_d = NULL) => -0.0095510662, -0.0095510662),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0709044224, 0.0229923018),
(k_inq_per_addr_i = NULL) => -0.0011759420, -0.0011759420);

// Tree: 183 
wFDN_FLA_SD_lgt_183 := map(
(NULL < c_oldhouse and c_oldhouse <= 613.2) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 189) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0034744700,
      (k_inq_adls_per_addr_i > 3.5) => -0.0460655064,
      (k_inq_adls_per_addr_i = NULL) => -0.0043254179, -0.0043254179),
   (c_totcrime > 189) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => -0.0104446564,
      (f_sourcerisktype_i > 4.5) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.3936338435) => 0.1704534365,
         (f_add_input_nhood_MFD_pct_i > 0.3936338435) => 0.0520204655,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.1096145815, 0.1096145815),
      (f_sourcerisktype_i = NULL) => 0.0501996003, 0.0501996003),
   (c_totcrime = NULL) => -0.0029769351, -0.0029769351),
(c_oldhouse > 613.2) => -0.0573203980,
(c_oldhouse = NULL) => 0.0175868346, -0.0041781811);

// Tree: 184 
wFDN_FLA_SD_lgt_184 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < c_robbery and c_robbery <= 13) => -0.0423675723,
   (c_robbery > 13) => 
      map(
      (NULL < c_rape and c_rape <= 105) => 
         map(
         (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 229) => 0.1161898451,
         (r_D32_Mos_Since_Fel_LS_d > 229) => 0.0126309002,
         (r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0134449265, 0.0134449265),
      (c_rape > 105) => -0.0116739286,
      (c_rape = NULL) => 0.0040424828, 0.0040424828),
   (c_robbery = NULL) => 0.0180171134, 0.0004643318),
(f_util_adl_count_n > 13.5) => 0.1016204743,
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 106.5) => 0.0416631865,
   (c_rental > 106.5) => -0.0623176419,
   (c_rental = NULL) => -0.0103272277, -0.0103272277), 0.0010998307);

// Tree: 185 
wFDN_FLA_SD_lgt_185 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 88.5) => 0.0683847378,
      (c_ab_av_edu > 88.5) => -0.0273681110,
      (c_ab_av_edu = NULL) => 0.0496962797, 0.0410682418),
   (k_estimated_income_d > 27500) => 0.0050603312,
   (k_estimated_income_d = NULL) => 0.0067670609, 0.0067670609),
(r_D31_ALL_Bk_i > 1.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 120.5) => -0.0955029301,
   (r_C13_max_lres_d > 120.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 27.65) => -0.0220097169,
      (C_INC_75K_P > 27.65) => 0.1441713865,
      (C_INC_75K_P = NULL) => -0.0090169950, -0.0090169950),
   (r_C13_max_lres_d = NULL) => -0.0326958193, -0.0326958193),
(r_D31_ALL_Bk_i = NULL) => -0.0047270505, 0.0031972169);

// Tree: 186 
wFDN_FLA_SD_lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.99152143005) => -0.0017609028,
   (f_add_input_nhood_SFD_pct_d > 0.99152143005) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 101.5) => -0.0047874708,
      (r_C13_Curr_Addr_LRes_d > 101.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 29.5) => 0.2362023069,
         (c_born_usa > 29.5) => 
            map(
            (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.99603135545) => 0.2174485295,
            (f_add_input_nhood_SFD_pct_d > 0.99603135545) => -0.0170250210,
            (f_add_input_nhood_SFD_pct_d = NULL) => 0.0656269055, 0.0656269055),
         (c_born_usa = NULL) => 0.0943516613, 0.0943516613),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0363251254, 0.0363251254),
   (f_add_input_nhood_SFD_pct_d = NULL) => 0.0018356722, 0.0018356722),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0690116961,
(f_inq_PrepaidCards_count_i = NULL) => 0.0271986214, 0.0023141811);

// Tree: 187 
wFDN_FLA_SD_lgt_187 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 18.5) => 0.0004938708,
(f_rel_homeover300_count_d > 18.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 89) => -0.1274292435,
   (r_pb_order_freq_d > 89) => -0.0763233167,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 25.65) => 0.0862812771,
      (c_hh2_p > 25.65) => -0.0885038702,
      (c_hh2_p = NULL) => -0.0019765695, -0.0019765695), -0.0643371063),
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 9.85) => -0.0767313975,
   (c_hh4_p > 9.85) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 785) => 0.0825591124,
      (c_med_rent > 785) => -0.0248571128,
      (c_med_rent = NULL) => 0.0224293776, 0.0224293776),
   (c_hh4_p = NULL) => -0.0171053105, -0.0171053105), -0.0012069249);

// Tree: 188 
wFDN_FLA_SD_lgt_188 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 19.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog','6: Other']) => -0.0143448772,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0099187687,
      (nf_seg_FraudPoint_3_0 = '') => -0.0015770169, -0.0015770169),
   (f_srchfraudsrchcount_i > 12.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.15) => -0.0090891938,
      (c_pop_45_54_p > 14.15) => 0.1113948217,
      (c_pop_45_54_p = NULL) => 0.0433915737, 0.0433915737),
   (f_srchfraudsrchcount_i = NULL) => -0.0009917035, -0.0009917035),
(f_inq_count24_i > 19.5) => -0.1148116401,
(f_inq_count24_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 96.5) => -0.0491210568,
   (c_burglary > 96.5) => 0.0578863317,
   (c_burglary = NULL) => 0.0023636301, 0.0023636301), -0.0014291926);

// Tree: 189 
wFDN_FLA_SD_lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 38.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => -0.0030469476,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0674598643,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0053462630, -0.0053462630),
   (f_rel_homeover500_count_d > 14.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 45.5) => 0.2097961391,
      (f_fp_prevaddrburglaryindex_i > 45.5) => -0.0490177096,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0840865554, 0.0840865554),
   (f_rel_homeover500_count_d = NULL) => 0.0006358096, -0.0044886819),
(f_phones_per_addr_curr_i > 38.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 0.0025452778,
   (f_rel_under25miles_cnt_d > 4.5) => 0.1465695895,
   (f_rel_under25miles_cnt_d = NULL) => 0.0618119193, 0.0618119193),
(f_phones_per_addr_curr_i = NULL) => 0.0041379990, -0.0031983088);

// Tree: 190 
wFDN_FLA_SD_lgt_190 := map(
(NULL < c_hh2_p and c_hh2_p <= 51.15) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 47645.5) => -0.0549328142,
   (r_A46_Curr_AVM_AutoVal_d > 47645.5) => -0.0058583849,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 0.55) => -0.1018219080,
      (c_sfdu_p > 0.55) => -0.0036000918,
      (c_sfdu_p = NULL) => -0.0065484807, -0.0065484807), -0.0074874924),
(c_hh2_p > 51.15) => 
   map(
   (NULL < c_rape and c_rape <= 17) => 0.2342819371,
   (c_rape > 17) => 
      map(
      (NULL < f_varmsrcssnunrelcount_i and f_varmsrcssnunrelcount_i <= 0.5) => 0.1569290554,
      (f_varmsrcssnunrelcount_i > 0.5) => -0.0094276941,
      (f_varmsrcssnunrelcount_i = NULL) => 0.0242217393, 0.0242217393),
   (c_rape = NULL) => 0.0492786217, 0.0492786217),
(c_hh2_p = NULL) => -0.0272259947, -0.0056924609);

// Tree: 191 
wFDN_FLA_SD_lgt_191 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 163.5) => -0.0046322332,
   (c_totcrime > 163.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 161.5) => 0.0959394552,
         (c_cartheft > 161.5) => 
            map(
            (NULL < c_hh3_p and c_hh3_p <= 8.45) => 0.0661858639,
            (c_hh3_p > 8.45) => -0.0337833413,
            (c_hh3_p = NULL) => -0.0037683741, -0.0037683741),
         (c_cartheft = NULL) => 0.0280427800, 0.0280427800),
      (f_crim_rel_under25miles_cnt_i > 4.5) => 0.1207720846,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.0326211077, 0.0326211077),
   (c_totcrime = NULL) => -0.0380852923, -0.0014758668),
(f_assocsuspicousidcount_i > 16.5) => 0.0866224028,
(f_assocsuspicousidcount_i = NULL) => -0.0331372983, -0.0012959553);

// Tree: 192 
wFDN_FLA_SD_lgt_192 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.9743808524) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 208.5) => 0.1553347011,
         (c_cpiall > 208.5) => 0.0220139066,
         (c_cpiall = NULL) => 0.0401904133, 0.0373200840),
      (r_C14_addrs_10yr_i > 2.5) => -0.0288343428,
      (r_C14_addrs_10yr_i = NULL) => 0.0091010362, 0.0091010362),
   (f_add_input_nhood_SFD_pct_d > 0.9743808524) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 60993) => 0.2198008256,
      (f_curraddrmedianincome_d > 60993) => 0.0248881184,
      (f_curraddrmedianincome_d = NULL) => 0.0898590208, 0.0898590208),
   (f_add_input_nhood_SFD_pct_d = NULL) => 0.0185389342, 0.0185389342),
(f_hh_members_ct_d > 1.5) => -0.0088677417,
(f_hh_members_ct_d = NULL) => -0.0001029586, -0.0037481282);

// Tree: 193 
wFDN_FLA_SD_lgt_193 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 36.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 26.5) => 0.0215667733,
   (c_born_usa > 26.5) => -0.0049687973,
   (c_born_usa = NULL) => -0.0268793063, -0.0011299558),
(f_rel_incomeover25_count_d > 36.5) => 
   map(
   (NULL < c_preschl and c_preschl <= 115) => 0.0102047561,
   (c_preschl > 115) => -0.1298907086,
   (c_preschl = NULL) => -0.0541634304, -0.0541634304),
(f_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 87.85) => 
      map(
      (NULL < c_larceny and c_larceny <= 170.5) => -0.0767034636,
      (c_larceny > 170.5) => 0.0513256525,
      (c_larceny = NULL) => -0.0470768913, -0.0470768913),
   (c_sfdu_p > 87.85) => 0.0648412432,
   (c_sfdu_p = NULL) => -0.0233808693, -0.0233808693), -0.0023071947);

// Tree: 194 
wFDN_FLA_SD_lgt_194 := map(
(NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 0.0026010820,
(r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 356) => -0.1231004596,
   (c_med_rent > 356) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 3.45) => -0.0601025271,
      (c_hh5_p > 3.45) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 29.35) => -0.0370992514,
         (c_lowinc > 29.35) => 
            map(
            (NULL < c_sfdu_p and c_sfdu_p <= 56.15) => 0.1028799230,
            (c_sfdu_p > 56.15) => -0.0099243943,
            (c_sfdu_p = NULL) => 0.0536780399, 0.0536780399),
         (c_lowinc = NULL) => 0.0020432504, 0.0020432504),
      (c_hh5_p = NULL) => -0.0231372352, -0.0231372352),
   (c_med_rent = NULL) => -0.0037340956, -0.0277136912),
(r_F00_Addr_Not_Ver_w_SSN_i = NULL) => 0.0001560987, 0.0005657302);

// Tree: 195 
wFDN_FLA_SD_lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 0.5) => 0.0060482803,
   (r_I60_inq_auto_count12_i > 0.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 152.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 14.85) => 
            map(
            (NULL < c_oldhouse and c_oldhouse <= 63) => -0.0572492933,
            (c_oldhouse > 63) => 0.1144412572,
            (c_oldhouse = NULL) => 0.0412949872, 0.0412949872),
         (C_INC_75K_P > 14.85) => -0.0514076016,
         (C_INC_75K_P = NULL) => -0.0233812375, -0.0233812375),
      (c_bel_edu > 152.5) => -0.1179004825,
      (c_bel_edu = NULL) => -0.0404279635, -0.0404279635),
   (r_I60_inq_auto_count12_i = NULL) => -0.0049136202, 0.0033681007),
(c_hval_80k_p > 40.05) => -0.1170284739,
(c_hval_80k_p = NULL) => 0.0187372521, 0.0026259504);

// Tree: 196 
wFDN_FLA_SD_lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0834841705,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 185.5) => -0.0133096053,
      (c_span_lang > 185.5) => -0.0679404242,
      (c_span_lang = NULL) => -0.0877340671, -0.0191067302),
   (f_addrs_per_ssn_i > 5.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 2.35) => -0.0549670966,
      (c_pop_18_24_p > 2.35) => 0.0100289323,
      (c_pop_18_24_p = NULL) => 0.0421050947, 0.0074325777),
   (f_addrs_per_ssn_i = NULL) => -0.0009740281, -0.0009740281),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.595) => 0.0760135171,
   (c_hhsize > 2.595) => -0.0355815189,
   (c_hhsize = NULL) => 0.0146865153, 0.0146865153), -0.0029045328);

// Tree: 197 
wFDN_FLA_SD_lgt_197 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -91324) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 609039.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.95) => 0.0009160567,
      (c_pop_18_24_p > 7.95) => 0.1432481203,
      (c_pop_18_24_p = NULL) => 0.0818833983, 0.0818833983),
   (f_prevaddrmedianvalue_d > 609039.5) => -0.0638611205,
   (f_prevaddrmedianvalue_d = NULL) => 0.0483017119, 0.0483017119),
(f_addrchangevaluediff_d > -91324) => -0.0011226564,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 10.05) => -0.0131843470,
   (c_hh5_p > 10.05) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 162.5) => 0.0257388558,
      (c_many_cars > 162.5) => 0.2227533172,
      (c_many_cars = NULL) => 0.0492098927, 0.0492098927),
   (c_hh5_p = NULL) => -0.0012221274, 0.0002170327), 0.0000209802);

// Tree: 198 
wFDN_FLA_SD_lgt_198 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0964078248,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 24.5) => -0.0315633051,
   (r_A50_pb_average_dollars_d > 24.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0106462333,
      (f_srchssnsrchcount_i > 6.5) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 8.45) => -0.0769465587,
         (c_pop_18_24_p > 8.45) => 
            map(
            (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 33.5) => 0.0883665162,
            (f_mos_inq_banko_om_lseen_d > 33.5) => -0.0272684514,
            (f_mos_inq_banko_om_lseen_d = NULL) => 0.0152639505, 0.0152639505),
         (c_pop_18_24_p = NULL) => -0.0345004513, -0.0345004513),
      (f_srchssnsrchcount_i = NULL) => 0.0090572718, 0.0090572718),
   (r_A50_pb_average_dollars_d = NULL) => 0.0114242293, 0.0044711131),
(c_pop_45_54_p = NULL) => -0.0312996689, 0.0023065220);

// Tree: 199 
wFDN_FLA_SD_lgt_199 := map(
(NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 41.5) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 93.25) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0997136042) => 0.0083896164,
         (f_add_curr_nhood_VAC_pct_i > 0.0997136042) => 0.0746404235,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0167350534, 0.0167350534),
      (r_Ever_Asset_Owner_d > 0.5) => -0.0058831857,
      (r_Ever_Asset_Owner_d = NULL) => -0.0014887634, -0.0014887634),
   (C_RENTOCC_P > 93.25) => -0.1173225579,
   (C_RENTOCC_P = NULL) => -0.0357420377, -0.0028826770),
(f_rel_homeover150_count_d > 41.5) => 0.1050134304,
(f_rel_homeover150_count_d = NULL) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.06105912915) => -0.0519759382,
   (f_add_curr_nhood_VAC_pct_i > 0.06105912915) => 0.1015335899,
   (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0034807841, -0.0115216681), -0.0026654518);

// Tree: 200 
wFDN_FLA_SD_lgt_200 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 9.5) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 22.85) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 14.5) => -0.0063587811,
      (f_phones_per_addr_curr_i > 14.5) => 0.0326225136,
      (f_phones_per_addr_curr_i = NULL) => -0.0044603520, -0.0044603520),
   (c_hval_40k_p > 22.85) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => 0.0126899245,
      (f_rel_under100miles_cnt_d > 8.5) => 0.1544779148,
      (f_rel_under100miles_cnt_d = NULL) => 0.0698083092, 0.0698083092),
   (c_hval_40k_p = NULL) => -0.0344621596, -0.0038601401),
(f_inq_HighRiskCredit_count_i > 9.5) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 730) => -0.1105733176,
   (c_med_rent > 730) => 0.0023445044,
   (c_med_rent = NULL) => -0.0571939836, -0.0571939836),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0117817838, -0.0042042551);

// Tree: 201 
wFDN_FLA_SD_lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0061473014,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 5.15) => -0.0021459216,
   (c_finance > 5.15) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 9.5) => 
         map(
         (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => 0.0569465667,
         (f_crim_rel_under500miles_cnt_i > 0.5) => 
            map(
            (NULL < c_rnt1250_p and c_rnt1250_p <= 4.8) => 0.3444820846,
            (c_rnt1250_p > 4.8) => 0.1249402436,
            (c_rnt1250_p = NULL) => 0.2212305248, 0.2212305248),
         (f_crim_rel_under500miles_cnt_i = NULL) => 0.1292568803, 0.1292568803),
      (f_rel_homeover150_count_d > 9.5) => -0.0591121014,
      (f_rel_homeover150_count_d = NULL) => 0.0943079183, 0.0943079183),
   (c_finance = NULL) => 0.0861031596, 0.0359001567),
(r_L70_Add_Standardized_i = NULL) => -0.0026535670, -0.0026535670);

// Tree: 202 
wFDN_FLA_SD_lgt_202 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 0.75) => -0.0900955489,
(c_pop_0_5_p > 0.75) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 0.95) => 0.1602762480,
   (c_pop_25_34_p > 0.95) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 14.5) => 
         map(
         (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 1.5) => -0.0639577370,
         (f_phones_per_addr_c6_i > 1.5) => 0.0879645334,
         (f_phones_per_addr_c6_i = NULL) => -0.0462876333, -0.0462876333),
      (f_mos_inq_banko_om_fseen_d > 14.5) => 
         map(
         (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 0.0445484811,
         (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0003486614,
         (f_mos_inq_banko_om_fseen_d = NULL) => 0.0025600893, 0.0025600893),
      (f_mos_inq_banko_om_fseen_d = NULL) => -0.0004253423, -0.0004687379),
   (c_pop_25_34_p = NULL) => 0.0004510814, 0.0004510814),
(c_pop_0_5_p = NULL) => 0.0211714324, -0.0002403588);

// Tree: 203 
wFDN_FLA_SD_lgt_203 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 111) => -0.0009454633,
(f_addrchangecrimediff_i > 111) => 0.0724928645,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 55.45) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => -0.0055857793,
      (r_L79_adls_per_addr_c6_i > 4.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 112.5) => 0.0094477619,
         (c_relig_indx > 112.5) => 0.1542100768,
         (c_relig_indx = NULL) => 0.0680420322, 0.0680420322),
      (r_L79_adls_per_addr_c6_i = NULL) => -0.0015870275, -0.0015870275),
   (c_rnt750_p > 55.45) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 19.4) => -0.1147752753,
      (c_hval_100k_p > 19.4) => 0.0768166734,
      (c_hval_100k_p = NULL) => -0.0776450527, -0.0776450527),
   (c_rnt750_p = NULL) => -0.0095383893, -0.0092323284), -0.0024439787);

// Tree: 204 
wFDN_FLA_SD_lgt_204 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 47409) => -0.0394238954,
(r_L80_Inp_AVM_AutoVal_d > 47409) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.7398458792) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 0.5) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 6.7) => 0.0276441166,
         (c_rnt1250_p > 6.7) => 0.2442954108,
         (c_rnt1250_p = NULL) => 0.1234959013, 0.1234959013),
      (f_corrssnnamecount_d > 0.5) => 0.0027532243,
      (f_corrssnnamecount_d = NULL) => 0.0068694520, 0.0068694520),
   (f_add_curr_nhood_MFD_pct_i > 0.7398458792) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 21.05) => 0.1780034162,
      (c_hh1_p > 21.05) => 0.0116052801,
      (c_hh1_p = NULL) => 0.0572222146, 0.0572222146),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0049200197, 0.0063517455),
(r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0031008447, 0.0010509989);

// Tree: 205 
wFDN_FLA_SD_lgt_205 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5922.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 2916) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 23374.5) => -0.0344106612,
      (f_prevaddrmedianincome_d > 23374.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 12.55) => 0.0041248391,
         (c_hh6_p > 12.55) => 0.0708790138,
         (c_hh6_p = NULL) => 0.0053126563, 0.0053126563),
      (f_prevaddrmedianincome_d = NULL) => 0.0027864700, 0.0027864700),
   (f_liens_unrel_SC_total_amt_i > 2916) => -0.0688192504,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0020373605, 0.0020373605),
(f_liens_unrel_ST_total_amt_i > 5922.5) => 0.1486876297,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 93) => 0.0537491923,
   (c_rich_nfam > 93) => -0.0305892317,
   (c_rich_nfam = NULL) => 0.0107843347, 0.0107843347), 0.0027041973);

// Tree: 206 
wFDN_FLA_SD_lgt_206 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184.5) => 
   map(
   (NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 104) => -0.0343320762,
   (f_mos_liens_unrel_FT_fseen_d > 104) => -0.1514381923,
   (f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0780283882, -0.0780283882),
(f_mos_liens_unrel_FT_lseen_d > 184.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 28.45) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 25.6) => -0.0493898882,
      (c_fammar_p > 25.6) => -0.0032466025,
      (c_fammar_p = NULL) => -0.0038247336, -0.0038247336),
   (c_hval_20k_p > 28.45) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.26363592095) => -0.0495559125,
      (f_add_curr_mobility_index_i > 0.26363592095) => 0.1652062453,
      (f_add_curr_mobility_index_i = NULL) => 0.0806542147, 0.0806542147),
   (c_hval_20k_p = NULL) => 0.0185324973, -0.0024729548),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0079489406, -0.0033138338);

// Tree: 207 
wFDN_FLA_SD_lgt_207 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5701) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 37.5) => -0.0881158447,
         (c_blue_empl > 37.5) => -0.0117130927,
         (c_blue_empl = NULL) => 0.0434267850, -0.0252085221),
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0026805664,
      (nf_seg_FraudPoint_3_0 = '') => 0.0007207198, 0.0007207198),
   (f_liens_unrel_SC_total_amt_i > 5701) => 0.1334976782,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0013059685, 0.0013059685),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < c_bargains and c_bargains <= 117.5) => -0.1118922930,
   (c_bargains > 117.5) => 0.0047425109,
   (c_bargains = NULL) => -0.0535748910, -0.0535748910),
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0145959856, 0.0007268979);

// Tree: 208 
wFDN_FLA_SD_lgt_208 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => -0.0040078021,
   (f_srchssnsrchcount_i > 22.5) => 0.0700256623,
   (f_srchssnsrchcount_i = NULL) => -0.0035841052, -0.0035841052),
(f_addrchangecrimediff_i > 98.5) => 0.0778214911,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.1813063561) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 9.5) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 25.05) => 0.0414466608,
         (c_hh2_p > 25.05) => -0.0092169012,
         (c_hh2_p = NULL) => 0.0012234280, 0.0012234280),
      (k_inq_per_addr_i > 9.5) => 0.0951268254,
      (k_inq_per_addr_i = NULL) => 0.0033443639, 0.0033443639),
   (f_add_input_nhood_BUS_pct_i > 0.1813063561) => -0.0777450024,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0097006277, -0.0024986246), -0.0028167309);

// Tree: 209 
wFDN_FLA_SD_lgt_209 := map(
(NULL < c_hh2_p and c_hh2_p <= 17.85) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 11.5) => 0.1284634099,
   (f_mos_inq_banko_cm_lseen_d > 11.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 86.5) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 0.1987084213,
         (f_corraddrnamecount_d > 4.5) => 0.0262312610,
         (f_corraddrnamecount_d = NULL) => 0.0869626555, 0.0869626555),
      (c_easiqlife > 86.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity']) => -0.0358370899,
         (nf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly','6: Other']) => 0.0616527162,
         (nf_seg_FraudPoint_3_0 = '') => 0.0129078132, 0.0129078132),
      (c_easiqlife = NULL) => 0.0273130017, 0.0273130017),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0352313417, 0.0352313417),
(c_hh2_p > 17.85) => -0.0004314260,
(c_hh2_p = NULL) => 0.0113449735, 0.0020953662);

// Tree: 210 
wFDN_FLA_SD_lgt_210 := map(
(NULL < f_idverrisktype_i and f_idverrisktype_i <= 7.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0000193141,
   (f_srchfraudsrchcount_i > 6.5) => 
      map(
      (NULL < r_C20_email_count_i and r_C20_email_count_i <= 6.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0549741892) => 
            map(
            (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => -0.0517974282,
            (f_inq_Collection_count24_i > 1.5) => 0.0554407697,
            (f_inq_Collection_count24_i = NULL) => -0.0277100791, -0.0277100791),
         (f_add_input_nhood_VAC_pct_i > 0.0549741892) => -0.1008264018,
         (f_add_input_nhood_VAC_pct_i = NULL) => -0.0473065710, -0.0473065710),
      (r_C20_email_count_i > 6.5) => 0.0549869747,
      (r_C20_email_count_i = NULL) => -0.0342435446, -0.0342435446),
   (f_srchfraudsrchcount_i = NULL) => -0.0013770983, -0.0013770983),
(f_idverrisktype_i > 7.5) => 0.0620490683,
(f_idverrisktype_i = NULL) => 0.0011126890, -0.0008630502);

// Tree: 211 
wFDN_FLA_SD_lgt_211 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 9.5) => 
   map(
   (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.0117593872,
   (f_property_owners_ct_d > 0.5) => -0.0109044422,
   (f_property_owners_ct_d = NULL) => -0.0297278986, -0.0041741305),
(k_inq_per_addr_i > 9.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 140.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.26378247385) => 0.0860054892,
      (f_add_curr_mobility_index_i > 0.26378247385) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.65) => -0.1071673672,
         (c_pop_35_44_p > 14.65) => 0.0196918482,
         (c_pop_35_44_p = NULL) => -0.0477021100, -0.0477021100),
      (f_add_curr_mobility_index_i = NULL) => 0.0074982750, 0.0074982750),
   (c_exp_prod > 140.5) => 0.1390288670,
   (c_exp_prod = NULL) => 0.0370812801, 0.0370812801),
(k_inq_per_addr_i = NULL) => -0.0032212069, -0.0032212069);

// Tree: 212 
wFDN_FLA_SD_lgt_212 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 22.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00477897935) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 13.5) => -0.0190002284,
      (f_rel_ageover20_count_d > 13.5) => -0.0899795707,
      (f_rel_ageover20_count_d = NULL) => -0.0338509310, -0.0338509310),
   (f_add_curr_nhood_BUS_pct_i > 0.00477897935) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 0.0031299254,
      (f_assocsuspicousidcount_i > 13.5) => 0.0796240175,
      (f_assocsuspicousidcount_i = NULL) => 0.0037160308, 0.0037160308),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0234931208, -0.0016204944),
(f_srchaddrsrchcount_i > 22.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.23162687135) => 0.0411235281,
   (f_add_curr_nhood_MFD_pct_i > 0.23162687135) => 0.0065168711,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0239412019, 0.0239412019),
(f_srchaddrsrchcount_i = NULL) => 0.0111054205, -0.0011554280);

// Tree: 213 
wFDN_FLA_SD_lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 149006.5) => 
   map(
   (NULL < c_rental and c_rental <= 187.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.04359340365) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 31.7) => 0.0325541745,
         (c_famotf18_p > 31.7) => 0.1559947246,
         (c_famotf18_p = NULL) => 0.0381521702, 0.0381521702),
      (f_add_input_nhood_BUS_pct_i > 0.04359340365) => -0.0187590411,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0742571863, 0.0156167637),
   (c_rental > 187.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 7.5) => 0.1548845391,
      (f_corraddrnamecount_d > 7.5) => -0.0285707036,
      (f_corraddrnamecount_d = NULL) => 0.0796546913, 0.0796546913),
   (c_rental = NULL) => 0.0191987645, 0.0191987645),
(r_A46_Curr_AVM_AutoVal_d > 149006.5) => -0.0076240655,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0024644247, 0.0020237543);

// Tree: 214 
wFDN_FLA_SD_lgt_214 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 6.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 76) => 0.2045971204,
   (c_totcrime > 76) => -0.0121947402,
   (c_totcrime = NULL) => 0.0789406916, 0.0789406916),
(r_D32_Mos_Since_Crim_LS_d > 6.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 48.95) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 0.0370219148,
      (r_I60_inq_recency_d > 2) => 0.0013642493,
      (r_I60_inq_recency_d = NULL) => 0.0035358705, 0.0035358705),
   (c_hval_80k_p > 48.95) => -0.1199968208,
   (c_hval_80k_p = NULL) => -0.0004251369, 0.0029088864),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 12.1) => 0.0324689818,
   (C_INC_100K_P > 12.1) => -0.0705139163,
   (C_INC_100K_P = NULL) => -0.0185126510, -0.0185126510), 0.0036692245);

// Tree: 215 
wFDN_FLA_SD_lgt_215 := map(
(NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1327013824) => 
   map(
   (NULL < c_food and c_food <= 51.65) => -0.0063644345,
   (c_food > 51.65) => 
      map(
      (NULL < c_rich_asian and c_rich_asian <= 126.5) => 0.0178228155,
      (c_rich_asian > 126.5) => 0.1554424008,
      (c_rich_asian = NULL) => 0.0447642158, 0.0447642158),
   (c_food = NULL) => 0.0937908374, -0.0020992571),
(f_add_curr_nhood_BUS_pct_i > 0.1327013824) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 0.0161661833,
   (f_hh_lienholders_i > 1.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => 0.0094484234,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.1724147941,
      (nf_seg_FraudPoint_3_0 = '') => 0.0969846453, 0.0969846453),
   (f_hh_lienholders_i = NULL) => 0.0258005368, 0.0258005368),
(f_add_curr_nhood_BUS_pct_i = NULL) => -0.0257484648, -0.0003917960);

// Tree: 216 
wFDN_FLA_SD_lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 180.5) => -0.0784747121,
(f_mos_liens_unrel_FT_lseen_d > 180.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 5.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
         map(
         (NULL < c_rich_blk and c_rich_blk <= 122) => -0.0020844579,
         (c_rich_blk > 122) => 
            map(
            (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -32.5) => 0.1187107363,
            (f_addrchangecrimediff_i > -32.5) => 0.0224825752,
            (f_addrchangecrimediff_i = NULL) => 0.0359510127, 0.0276756399),
         (c_rich_blk = NULL) => 0.0056516654, 0.0056516654),
      (c_asian_lang > 181.5) => -0.0271009490,
      (c_asian_lang = NULL) => 0.0165199868, 0.0012235892),
   (f_srchcomponentrisktype_i > 5.5) => 0.0697646272,
   (f_srchcomponentrisktype_i = NULL) => 0.0016481797, 0.0016481797),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 0.0118290404, 0.0008277130);

// Tree: 217 
wFDN_FLA_SD_lgt_217 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -45425.5) => -0.0986400659,
(f_addrchangeincomediff_d > -45425.5) => 0.0012028053,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 30.1) => 
      map(
      (NULL < c_retail and c_retail <= 34.35) => -0.0124653401,
      (c_retail > 34.35) => 
         map(
         (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => -0.0158197379,
         (r_A44_curr_add_naprop_d > 2.5) => 0.1696137141,
         (r_A44_curr_add_naprop_d = NULL) => 0.0689147534, 0.0689147534),
      (c_retail = NULL) => -0.0072777645, -0.0072777645),
   (c_hval_150k_p > 30.1) => 0.0954397302,
   (c_hval_150k_p = NULL) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2067873879) => 0.1480928712,
      (f_add_curr_mobility_index_i > 0.2067873879) => -0.0792564181,
      (f_add_curr_mobility_index_i = NULL) => 0.0309029524, 0.0274873585), -0.0006545342), 0.0001749065);

// Tree: 218 
wFDN_FLA_SD_lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_exp_homes and c_exp_homes <= 188.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 24.65) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 8.75) => 0.0169624731,
         (c_newhouse > 8.75) => 0.2007068067,
         (c_newhouse = NULL) => 0.1079917760, 0.1079917760),
      (c_white_col > 24.65) => 0.0061438759,
      (c_white_col = NULL) => 0.0243131412, 0.0243131412),
   (c_exp_homes > 188.5) => 0.2867294442,
   (c_exp_homes = NULL) => 0.0305260356, 0.0423266414),
(f_rel_incomeover25_count_d > 1.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0081177901,
   (f_inq_Other_count_i > 0.5) => 0.0189764540,
   (f_inq_Other_count_i = NULL) => -0.0017968173, -0.0017968173),
(f_rel_incomeover25_count_d = NULL) => -0.0253608211, 0.0004979054);

// Tree: 219 
wFDN_FLA_SD_lgt_219 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 15.45) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 25.35) => 
      map(
      (NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
         map(
         (NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 164.5) => 
            map(
            (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0397699089,
            (r_F00_dob_score_d > 92) => 0.0040056846,
            (r_F00_dob_score_d = NULL) => -0.0194666508, 0.0043512060),
         (f_liens_rel_SC_total_amt_i > 164.5) => -0.0820571440,
         (f_liens_rel_SC_total_amt_i = NULL) => 0.0005690422, 0.0033589179),
      (r_L77_Add_PO_Box_i > 0.5) => -0.0893217448,
      (r_L77_Add_PO_Box_i = NULL) => 0.0016144497, 0.0016144497),
   (c_pop_45_54_p > 25.35) => -0.0778824045,
   (c_pop_45_54_p = NULL) => -0.0004743493, -0.0004743493),
(c_femdiv_p > 15.45) => 0.1250513868,
(c_femdiv_p = NULL) => -0.0033368025, 0.0001542565);

// Tree: 220 
wFDN_FLA_SD_lgt_220 := map(
(NULL < c_food and c_food <= 62.65) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 176.5) => -0.0004110710,
   (c_for_sale > 176.5) => -0.0409257897,
   (c_for_sale = NULL) => -0.0046400865, -0.0046400865),
(c_food > 62.65) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 77556) => 0.1507100312,
   (r_A46_Curr_AVM_AutoVal_d > 77556) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 9.95) => -0.0168644355,
      (c_rnt1250_p > 9.95) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 7.5) => 0.2334697300,
         (f_rel_educationover12_count_d > 7.5) => 0.0112112150,
         (f_rel_educationover12_count_d = NULL) => 0.1181469156, 0.1181469156),
      (c_rnt1250_p = NULL) => 0.0395660901, 0.0395660901),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0010996464, 0.0360438382),
(c_food = NULL) => -0.0083231818, -0.0030769382);

// Tree: 221 
wFDN_FLA_SD_lgt_221 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 13.95) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.0659110774,
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 0.0037379816,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0065809133, 0.0042851076),
(C_INC_25K_P > 13.95) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 191.5) => -0.0172830877,
      (c_sub_bus > 191.5) => 0.1057846159,
      (c_sub_bus = NULL) => -0.0077312643, -0.0077312643),
   (r_I60_Inq_Count12_i > 0.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => -0.0773427830,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0411876600,
      (nf_seg_FraudPoint_3_0 = '') => -0.0523081807, -0.0523081807),
   (r_I60_Inq_Count12_i = NULL) => -0.0235458477, -0.0235458477),
(C_INC_25K_P = NULL) => -0.0141390459, -0.0003376188);

// Tree: 222 
wFDN_FLA_SD_lgt_222 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0041387943,
(f_addrchangecrimediff_i > 61.5) => 
   map(
   (NULL < c_health and c_health <= 11.15) => -0.0063596234,
   (c_health > 11.15) => 0.1510400760,
   (c_health = NULL) => 0.0567781091, 0.0567781091),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 130.5) => -0.0206721542,
   (c_span_lang > 130.5) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 625.5) => -0.0875410529,
      (f_mos_liens_unrel_CJ_fseen_d > 625.5) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 41.5) => -0.0743492940,
         (c_ab_av_edu > 41.5) => 0.0580128675,
         (c_ab_av_edu = NULL) => 0.0475102177, 0.0475102177),
      (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0375819773, 0.0375819773),
   (c_span_lang = NULL) => 0.0145777791, 0.0040623318), -0.0014345671);

// Tree: 223 
wFDN_FLA_SD_lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 41670.5) => 
   map(
   (NULL < c_retail and c_retail <= 21.8) => -0.0715777961,
   (c_retail > 21.8) => 0.0814703672,
   (c_retail = NULL) => -0.0458121120, -0.0458121120),
(r_A46_Curr_AVM_AutoVal_d > 41670.5) => 0.0005061356,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 165) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 92.5) => -0.0325211456,
      (c_no_labfor > 92.5) => 0.1456703854,
      (c_no_labfor = NULL) => 0.0607673618, 0.0607673618),
   (f_mos_liens_unrel_SC_fseen_d > 165) => -0.0007218618,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 
      map(
      (NULL < c_incollege and c_incollege <= 5.75) => -0.0485744125,
      (c_incollege > 5.75) => 0.0815443518,
      (c_incollege = NULL) => 0.0117533782, 0.0117533782), 0.0014571436), -0.0001735005);

// Tree: 224 
wFDN_FLA_SD_lgt_224 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 26.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 10.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.23685364235) => -0.0444110993,
         (f_add_curr_mobility_index_i > 0.23685364235) => 0.0255799889,
         (f_add_curr_mobility_index_i = NULL) => 0.0064344446, 0.0064344446),
      (c_hval_20k_p > 0.65) => 0.1598125243,
      (c_hval_20k_p = NULL) => 0.0421526275, 0.0421526275),
   (f_M_Bureau_ADL_FS_all_d > 10.5) => 0.0011803741,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0021606030, 0.0021606030),
(f_srchaddrsrchcount_i > 26.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 130.5) => 0.1054559176,
   (c_new_homes > 130.5) => -0.0116651566,
   (c_new_homes = NULL) => 0.0492378020, 0.0492378020),
(f_srchaddrsrchcount_i = NULL) => 0.0137881932, 0.0027198399);

// Tree: 225 
wFDN_FLA_SD_lgt_225 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 65039) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.15) => -0.0422929693,
   (c_unemp > 8.15) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 117) => -0.0263605342,
      (c_no_labfor > 117) => 0.1249236061,
      (c_no_labfor = NULL) => 0.0424049841, 0.0424049841),
   (c_unemp = NULL) => -0.0268165991, -0.0268165991),
(r_A46_Curr_AVM_AutoVal_d > 65039) => 0.0146229330,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_liens_unrel_OT_lseen_d and f_mos_liens_unrel_OT_lseen_d <= 210.5) => -0.0881596128,
   (f_mos_liens_unrel_OT_lseen_d > 210.5) => -0.0050709077,
   (f_mos_liens_unrel_OT_lseen_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 3.35) => -0.0510642624,
      (c_hval_200k_p > 3.35) => 0.0688384918,
      (c_hval_200k_p = NULL) => 0.0066666933, 0.0066666933), -0.0074424546), 0.0028964761);

// Tree: 226 
wFDN_FLA_SD_lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 13.5) => -0.0100493091,
   (f_addrs_per_ssn_i > 13.5) => -0.1326422165,
   (f_addrs_per_ssn_i = NULL) => -0.0695604292, -0.0695604292),
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 52.95) => 0.1280245513,
      (r_C12_source_profile_d > 52.95) => -0.0125966551,
      (r_C12_source_profile_d = NULL) => 0.0513220751, 0.0513220751),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 126.5) => 0.0066102592,
      (c_serv_empl > 126.5) => -0.0168740906,
      (c_serv_empl = NULL) => -0.0064274738, -0.0011542994),
   (r_D33_Eviction_Recency_d = NULL) => -0.0006454325, -0.0006454325),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0103967442, -0.0011144793);

// Tree: 227 
wFDN_FLA_SD_lgt_227 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -100) => -0.0786262381,
(f_addrchangecrimediff_i > -100) => -0.0005566242,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 112.65) => 0.0103633543,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 112.65) => 
      map(
      (NULL < c_exp_homes and c_exp_homes <= 167.5) => 
         map(
         (NULL < c_hval_1000k_p and c_hval_1000k_p <= 0.05) => 
            map(
            (NULL < c_rich_fam and c_rich_fam <= 100.5) => 0.1604284808,
            (c_rich_fam > 100.5) => -0.0018200309,
            (c_rich_fam = NULL) => 0.0867926178, 0.0867926178),
         (c_hval_1000k_p > 0.05) => -0.0907040023,
         (c_hval_1000k_p = NULL) => 0.0264257470, 0.0264257470),
      (c_exp_homes > 167.5) => 0.2434232434,
      (c_exp_homes = NULL) => 0.0808813925, 0.0808813925),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0052977342, 0.0059219692), 0.0004306497);

// Tree: 228 
wFDN_FLA_SD_lgt_228 := map(
(NULL < nf_vf_hi_addr_add_entries and nf_vf_hi_addr_add_entries <= 2.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 77.5) => -0.0016137534,
      (f_addrchangecrimediff_i > 77.5) => -0.0568325953,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 43.45) => 0.0023785141,
         (c_famotf18_p > 43.45) => -0.0866497605,
         (c_famotf18_p = NULL) => -0.0063888993, -0.0010943245), -0.0020853857),
   (f_assocsuspicousidcount_i > 9.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 37000) => 0.0394798220,
      (k_estimated_income_d > 37000) => -0.0655657423,
      (k_estimated_income_d = NULL) => -0.0459862437, -0.0459862437),
   (f_assocsuspicousidcount_i = NULL) => -0.0032700955, -0.0032700955),
(nf_vf_hi_addr_add_entries > 2.5) => 0.0758338852,
(nf_vf_hi_addr_add_entries = NULL) => 0.0040708559, -0.0028437201);

// Tree: 229 
wFDN_FLA_SD_lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 11.5) => 0.0006297121,
      (f_crim_rel_under100miles_cnt_i > 11.5) => 0.0865023466,
      (f_crim_rel_under100miles_cnt_i = NULL) => 0.0287894112, 0.0014005864),
   (k_inq_adls_per_addr_i > 3.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 40.5) => -0.1191260157,
      (c_born_usa > 40.5) => 
         map(
         (NULL < c_retail and c_retail <= 15.55) => 0.0520923184,
         (c_retail > 15.55) => -0.1010432208,
         (c_retail = NULL) => -0.0013036261, -0.0013036261),
      (c_born_usa = NULL) => -0.0448147990, -0.0448147990),
   (k_inq_adls_per_addr_i = NULL) => 0.0004655488, 0.0004655488),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0646319909,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0218280959, -0.0024111702);

// Tree: 230 
wFDN_FLA_SD_lgt_230 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 3.5) => 0.0060490832,
      (f_inq_count24_i > 3.5) => 
         map(
         (NULL < c_hval_80k_p and c_hval_80k_p <= 14.25) => 
            map(
            (NULL < c_famotf18_p and c_famotf18_p <= 24.75) => -0.0279662857,
            (c_famotf18_p > 24.75) => 0.0487134941,
            (c_famotf18_p = NULL) => -0.0199003902, -0.0199003902),
         (c_hval_80k_p > 14.25) => -0.0914209685,
         (c_hval_80k_p = NULL) => -0.0257068289, -0.0257068289),
      (f_inq_count24_i = NULL) => 0.0020464513, 0.0020464513),
   (f_fp_prevaddrcrimeindex_i > 197.5) => -0.0981315488,
   (f_fp_prevaddrcrimeindex_i = NULL) => -0.0077172573, 0.0013894065),
(f_bus_addr_match_count_d > 52.5) => 0.1071117114,
(f_bus_addr_match_count_d = NULL) => 0.0019311448, 0.0019311448);

// Tree: 231 
wFDN_FLA_SD_lgt_231 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0009343960,
(f_srchvelocityrisktype_i > 6.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => 0.1769081657,
      (f_crim_rel_under25miles_cnt_i > 0.5) => 0.0341975856,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.1105311517, 0.1105311517),
   (r_L79_adls_per_addr_c6_i > 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 3533) => 0.0102909452,
      (r_A49_Curr_AVM_Chg_1yr_i > 3533) => -0.0883293393,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 127.5) => 0.0010717542,
         (c_many_cars > 127.5) => 0.1347547638,
         (c_many_cars = NULL) => 0.0307790897, 0.0307790897), 0.0058911788),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0343906836, 0.0343906836),
(f_srchvelocityrisktype_i = NULL) => 0.0171021250, 0.0006020811);

// Tree: 232 
wFDN_FLA_SD_lgt_232 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1215252290,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 10.5) => -0.0483113412,
   (c_no_teens > 10.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 35.5) => 0.1368550615,
         (k_comb_age_d > 35.5) => -0.0020020471,
         (k_comb_age_d = NULL) => 0.0667524436, 0.0667524436),
      (r_F00_dob_score_d > 65) => 0.0000794325,
      (r_F00_dob_score_d = NULL) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00296366445) => 0.1140769943,
         (f_add_curr_nhood_VAC_pct_i > 0.00296366445) => -0.0413162813,
         (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0051884329, -0.0051884329), 0.0005049545),
   (c_no_teens = NULL) => 0.0039927175, -0.0014213761),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0036469298, -0.0009282125);

// Tree: 233 
wFDN_FLA_SD_lgt_233 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0504726334,
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 15.65) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 6.5) => 0.0233516881,
         (f_addrchangecrimediff_i > 6.5) => 0.0732471650,
         (f_addrchangecrimediff_i = NULL) => 
            map(
            (NULL < c_employees and c_employees <= 94.5) => 0.1912253487,
            (c_employees > 94.5) => 0.0492776788,
            (c_employees = NULL) => 0.0882742914, 0.0882742914), 0.0470950202),
      (C_INC_35K_P > 15.65) => -0.0471422006,
      (C_INC_35K_P = NULL) => 0.0140506445, 0.0328221744),
   (f_corrssnaddrcount_d > 2.5) => -0.0085917525,
   (f_corrssnaddrcount_d = NULL) => -0.0056007842, -0.0056007842),
(f_corrssnaddrcount_d = NULL) => 0.0052186397, -0.0065897816);

// Tree: 234 
wFDN_FLA_SD_lgt_234 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 155.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0361938847,
   (f_util_add_curr_conv_n > 0.5) => 0.0026073866,
   (f_util_add_curr_conv_n = NULL) => -0.0139680196, -0.0139680196),
(r_C13_max_lres_d > 155.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 140.5) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 83404) => -0.1041163573,
         (f_curraddrmedianvalue_d > 83404) => 0.0596823868,
         (f_curraddrmedianvalue_d = NULL) => 0.0375563468, 0.0375563468),
      (c_unattach > 140.5) => 0.1481896387,
      (c_unattach = NULL) => -0.0434266795, 0.0368108630),
   (f_corraddrnamecount_d > 3.5) => 0.0013741894,
   (f_corraddrnamecount_d = NULL) => 0.0056662088, 0.0056662088),
(r_C13_max_lres_d = NULL) => 0.0416299513, -0.0051007288);

// Final Score Sum 

   wFDN_FLA_SD_lgt := sum(
      wFDN_FLA_SD_lgt_0, wFDN_FLA_SD_lgt_1, wFDN_FLA_SD_lgt_2, wFDN_FLA_SD_lgt_3, wFDN_FLA_SD_lgt_4, 
      wFDN_FLA_SD_lgt_5, wFDN_FLA_SD_lgt_6, wFDN_FLA_SD_lgt_7, wFDN_FLA_SD_lgt_8, wFDN_FLA_SD_lgt_9, 
      wFDN_FLA_SD_lgt_10, wFDN_FLA_SD_lgt_11, wFDN_FLA_SD_lgt_12, wFDN_FLA_SD_lgt_13, wFDN_FLA_SD_lgt_14, 
      wFDN_FLA_SD_lgt_15, wFDN_FLA_SD_lgt_16, wFDN_FLA_SD_lgt_17, wFDN_FLA_SD_lgt_18, wFDN_FLA_SD_lgt_19, 
      wFDN_FLA_SD_lgt_20, wFDN_FLA_SD_lgt_21, wFDN_FLA_SD_lgt_22, wFDN_FLA_SD_lgt_23, wFDN_FLA_SD_lgt_24, 
      wFDN_FLA_SD_lgt_25, wFDN_FLA_SD_lgt_26, wFDN_FLA_SD_lgt_27, wFDN_FLA_SD_lgt_28, wFDN_FLA_SD_lgt_29, 
      wFDN_FLA_SD_lgt_30, wFDN_FLA_SD_lgt_31, wFDN_FLA_SD_lgt_32, wFDN_FLA_SD_lgt_33, wFDN_FLA_SD_lgt_34, 
      wFDN_FLA_SD_lgt_35, wFDN_FLA_SD_lgt_36, wFDN_FLA_SD_lgt_37, wFDN_FLA_SD_lgt_38, wFDN_FLA_SD_lgt_39, 
      wFDN_FLA_SD_lgt_40, wFDN_FLA_SD_lgt_41, wFDN_FLA_SD_lgt_42, wFDN_FLA_SD_lgt_43, wFDN_FLA_SD_lgt_44, 
      wFDN_FLA_SD_lgt_45, wFDN_FLA_SD_lgt_46, wFDN_FLA_SD_lgt_47, wFDN_FLA_SD_lgt_48, wFDN_FLA_SD_lgt_49, 
      wFDN_FLA_SD_lgt_50, wFDN_FLA_SD_lgt_51, wFDN_FLA_SD_lgt_52, wFDN_FLA_SD_lgt_53, wFDN_FLA_SD_lgt_54, 
      wFDN_FLA_SD_lgt_55, wFDN_FLA_SD_lgt_56, wFDN_FLA_SD_lgt_57, wFDN_FLA_SD_lgt_58, wFDN_FLA_SD_lgt_59, 
      wFDN_FLA_SD_lgt_60, wFDN_FLA_SD_lgt_61, wFDN_FLA_SD_lgt_62, wFDN_FLA_SD_lgt_63, wFDN_FLA_SD_lgt_64, 
      wFDN_FLA_SD_lgt_65, wFDN_FLA_SD_lgt_66, wFDN_FLA_SD_lgt_67, wFDN_FLA_SD_lgt_68, wFDN_FLA_SD_lgt_69, 
      wFDN_FLA_SD_lgt_70, wFDN_FLA_SD_lgt_71, wFDN_FLA_SD_lgt_72, wFDN_FLA_SD_lgt_73, wFDN_FLA_SD_lgt_74, 
      wFDN_FLA_SD_lgt_75, wFDN_FLA_SD_lgt_76, wFDN_FLA_SD_lgt_77, wFDN_FLA_SD_lgt_78, wFDN_FLA_SD_lgt_79, 
      wFDN_FLA_SD_lgt_80, wFDN_FLA_SD_lgt_81, wFDN_FLA_SD_lgt_82, wFDN_FLA_SD_lgt_83, wFDN_FLA_SD_lgt_84, 
      wFDN_FLA_SD_lgt_85, wFDN_FLA_SD_lgt_86, wFDN_FLA_SD_lgt_87, wFDN_FLA_SD_lgt_88, wFDN_FLA_SD_lgt_89, 
      wFDN_FLA_SD_lgt_90, wFDN_FLA_SD_lgt_91, wFDN_FLA_SD_lgt_92, wFDN_FLA_SD_lgt_93, wFDN_FLA_SD_lgt_94, 
      wFDN_FLA_SD_lgt_95, wFDN_FLA_SD_lgt_96, wFDN_FLA_SD_lgt_97, wFDN_FLA_SD_lgt_98, wFDN_FLA_SD_lgt_99, 
      wFDN_FLA_SD_lgt_100, wFDN_FLA_SD_lgt_101, wFDN_FLA_SD_lgt_102, wFDN_FLA_SD_lgt_103, wFDN_FLA_SD_lgt_104, 
      wFDN_FLA_SD_lgt_105, wFDN_FLA_SD_lgt_106, wFDN_FLA_SD_lgt_107, wFDN_FLA_SD_lgt_108, wFDN_FLA_SD_lgt_109, 
      wFDN_FLA_SD_lgt_110, wFDN_FLA_SD_lgt_111, wFDN_FLA_SD_lgt_112, wFDN_FLA_SD_lgt_113, wFDN_FLA_SD_lgt_114, 
      wFDN_FLA_SD_lgt_115, wFDN_FLA_SD_lgt_116, wFDN_FLA_SD_lgt_117, wFDN_FLA_SD_lgt_118, wFDN_FLA_SD_lgt_119, 
      wFDN_FLA_SD_lgt_120, wFDN_FLA_SD_lgt_121, wFDN_FLA_SD_lgt_122, wFDN_FLA_SD_lgt_123, wFDN_FLA_SD_lgt_124, 
      wFDN_FLA_SD_lgt_125, wFDN_FLA_SD_lgt_126, wFDN_FLA_SD_lgt_127, wFDN_FLA_SD_lgt_128, wFDN_FLA_SD_lgt_129, 
      wFDN_FLA_SD_lgt_130, wFDN_FLA_SD_lgt_131, wFDN_FLA_SD_lgt_132, wFDN_FLA_SD_lgt_133, wFDN_FLA_SD_lgt_134, 
      wFDN_FLA_SD_lgt_135, wFDN_FLA_SD_lgt_136, wFDN_FLA_SD_lgt_137, wFDN_FLA_SD_lgt_138, wFDN_FLA_SD_lgt_139, 
      wFDN_FLA_SD_lgt_140, wFDN_FLA_SD_lgt_141, wFDN_FLA_SD_lgt_142, wFDN_FLA_SD_lgt_143, wFDN_FLA_SD_lgt_144, 
      wFDN_FLA_SD_lgt_145, wFDN_FLA_SD_lgt_146, wFDN_FLA_SD_lgt_147, wFDN_FLA_SD_lgt_148, wFDN_FLA_SD_lgt_149, 
      wFDN_FLA_SD_lgt_150, wFDN_FLA_SD_lgt_151, wFDN_FLA_SD_lgt_152, wFDN_FLA_SD_lgt_153, wFDN_FLA_SD_lgt_154, 
      wFDN_FLA_SD_lgt_155, wFDN_FLA_SD_lgt_156, wFDN_FLA_SD_lgt_157, wFDN_FLA_SD_lgt_158, wFDN_FLA_SD_lgt_159, 
      wFDN_FLA_SD_lgt_160, wFDN_FLA_SD_lgt_161, wFDN_FLA_SD_lgt_162, wFDN_FLA_SD_lgt_163, wFDN_FLA_SD_lgt_164, 
      wFDN_FLA_SD_lgt_165, wFDN_FLA_SD_lgt_166, wFDN_FLA_SD_lgt_167, wFDN_FLA_SD_lgt_168, wFDN_FLA_SD_lgt_169, 
      wFDN_FLA_SD_lgt_170, wFDN_FLA_SD_lgt_171, wFDN_FLA_SD_lgt_172, wFDN_FLA_SD_lgt_173, wFDN_FLA_SD_lgt_174, 
      wFDN_FLA_SD_lgt_175, wFDN_FLA_SD_lgt_176, wFDN_FLA_SD_lgt_177, wFDN_FLA_SD_lgt_178, wFDN_FLA_SD_lgt_179, 
      wFDN_FLA_SD_lgt_180, wFDN_FLA_SD_lgt_181, wFDN_FLA_SD_lgt_182, wFDN_FLA_SD_lgt_183, wFDN_FLA_SD_lgt_184, 
      wFDN_FLA_SD_lgt_185, wFDN_FLA_SD_lgt_186, wFDN_FLA_SD_lgt_187, wFDN_FLA_SD_lgt_188, wFDN_FLA_SD_lgt_189, 
      wFDN_FLA_SD_lgt_190, wFDN_FLA_SD_lgt_191, wFDN_FLA_SD_lgt_192, wFDN_FLA_SD_lgt_193, wFDN_FLA_SD_lgt_194, 
      wFDN_FLA_SD_lgt_195, wFDN_FLA_SD_lgt_196, wFDN_FLA_SD_lgt_197, wFDN_FLA_SD_lgt_198, wFDN_FLA_SD_lgt_199, 
      wFDN_FLA_SD_lgt_200, wFDN_FLA_SD_lgt_201, wFDN_FLA_SD_lgt_202, wFDN_FLA_SD_lgt_203, wFDN_FLA_SD_lgt_204, 
      wFDN_FLA_SD_lgt_205, wFDN_FLA_SD_lgt_206, wFDN_FLA_SD_lgt_207, wFDN_FLA_SD_lgt_208, wFDN_FLA_SD_lgt_209, 
      wFDN_FLA_SD_lgt_210, wFDN_FLA_SD_lgt_211, wFDN_FLA_SD_lgt_212, wFDN_FLA_SD_lgt_213, wFDN_FLA_SD_lgt_214, 
      wFDN_FLA_SD_lgt_215, wFDN_FLA_SD_lgt_216, wFDN_FLA_SD_lgt_217, wFDN_FLA_SD_lgt_218, wFDN_FLA_SD_lgt_219, 
      wFDN_FLA_SD_lgt_220, wFDN_FLA_SD_lgt_221, wFDN_FLA_SD_lgt_222, wFDN_FLA_SD_lgt_223, wFDN_FLA_SD_lgt_224, 
      wFDN_FLA_SD_lgt_225, wFDN_FLA_SD_lgt_226, wFDN_FLA_SD_lgt_227, wFDN_FLA_SD_lgt_228, wFDN_FLA_SD_lgt_229, 
      wFDN_FLA_SD_lgt_230, wFDN_FLA_SD_lgt_231, wFDN_FLA_SD_lgt_232, wFDN_FLA_SD_lgt_233, wFDN_FLA_SD_lgt_234); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FLA_SD_lgt;
			
self.final_score_0	:= 	wFDN_FLA_SD_lgt_0	;
self.final_score_1	:= 	wFDN_FLA_SD_lgt_1	;
self.final_score_2	:= 	wFDN_FLA_SD_lgt_2	;
self.final_score_3	:= 	wFDN_FLA_SD_lgt_3	;
self.final_score_4	:= 	wFDN_FLA_SD_lgt_4	;
self.final_score_5	:= 	wFDN_FLA_SD_lgt_5	;
self.final_score_6	:= 	wFDN_FLA_SD_lgt_6	;
self.final_score_7	:= 	wFDN_FLA_SD_lgt_7	;
self.final_score_8	:= 	wFDN_FLA_SD_lgt_8	;
self.final_score_9	:= 	wFDN_FLA_SD_lgt_9	;
self.final_score_10	:= 	wFDN_FLA_SD_lgt_10	;
self.final_score_11	:= 	wFDN_FLA_SD_lgt_11	;
self.final_score_12	:= 	wFDN_FLA_SD_lgt_12	;
self.final_score_13	:= 	wFDN_FLA_SD_lgt_13	;
self.final_score_14	:= 	wFDN_FLA_SD_lgt_14	;
self.final_score_15	:= 	wFDN_FLA_SD_lgt_15	;
self.final_score_16	:= 	wFDN_FLA_SD_lgt_16	;
self.final_score_17	:= 	wFDN_FLA_SD_lgt_17	;
self.final_score_18	:= 	wFDN_FLA_SD_lgt_18	;
self.final_score_19	:= 	wFDN_FLA_SD_lgt_19	;
self.final_score_20	:= 	wFDN_FLA_SD_lgt_20	;
self.final_score_21	:= 	wFDN_FLA_SD_lgt_21	;
self.final_score_22	:= 	wFDN_FLA_SD_lgt_22	;
self.final_score_23	:= 	wFDN_FLA_SD_lgt_23	;
self.final_score_24	:= 	wFDN_FLA_SD_lgt_24	;
self.final_score_25	:= 	wFDN_FLA_SD_lgt_25	;
self.final_score_26	:= 	wFDN_FLA_SD_lgt_26	;
self.final_score_27	:= 	wFDN_FLA_SD_lgt_27	;
self.final_score_28	:= 	wFDN_FLA_SD_lgt_28	;
self.final_score_29	:= 	wFDN_FLA_SD_lgt_29	;
self.final_score_30	:= 	wFDN_FLA_SD_lgt_30	;
self.final_score_31	:= 	wFDN_FLA_SD_lgt_31	;
self.final_score_32	:= 	wFDN_FLA_SD_lgt_32	;
self.final_score_33	:= 	wFDN_FLA_SD_lgt_33	;
self.final_score_34	:= 	wFDN_FLA_SD_lgt_34	;
self.final_score_35	:= 	wFDN_FLA_SD_lgt_35	;
self.final_score_36	:= 	wFDN_FLA_SD_lgt_36	;
self.final_score_37	:= 	wFDN_FLA_SD_lgt_37	;
self.final_score_38	:= 	wFDN_FLA_SD_lgt_38	;
self.final_score_39	:= 	wFDN_FLA_SD_lgt_39	;
self.final_score_40	:= 	wFDN_FLA_SD_lgt_40	;
self.final_score_41	:= 	wFDN_FLA_SD_lgt_41	;
self.final_score_42	:= 	wFDN_FLA_SD_lgt_42	;
self.final_score_43	:= 	wFDN_FLA_SD_lgt_43	;
self.final_score_44	:= 	wFDN_FLA_SD_lgt_44	;
self.final_score_45	:= 	wFDN_FLA_SD_lgt_45	;
self.final_score_46	:= 	wFDN_FLA_SD_lgt_46	;
self.final_score_47	:= 	wFDN_FLA_SD_lgt_47	;
self.final_score_48	:= 	wFDN_FLA_SD_lgt_48	;
self.final_score_49	:= 	wFDN_FLA_SD_lgt_49	;
self.final_score_50	:= 	wFDN_FLA_SD_lgt_50	;
self.final_score_51	:= 	wFDN_FLA_SD_lgt_51	;
self.final_score_52	:= 	wFDN_FLA_SD_lgt_52	;
self.final_score_53	:= 	wFDN_FLA_SD_lgt_53	;
self.final_score_54	:= 	wFDN_FLA_SD_lgt_54	;
self.final_score_55	:= 	wFDN_FLA_SD_lgt_55	;
self.final_score_56	:= 	wFDN_FLA_SD_lgt_56	;
self.final_score_57	:= 	wFDN_FLA_SD_lgt_57	;
self.final_score_58	:= 	wFDN_FLA_SD_lgt_58	;
self.final_score_59	:= 	wFDN_FLA_SD_lgt_59	;
self.final_score_60	:= 	wFDN_FLA_SD_lgt_60	;
self.final_score_61	:= 	wFDN_FLA_SD_lgt_61	;
self.final_score_62	:= 	wFDN_FLA_SD_lgt_62	;
self.final_score_63	:= 	wFDN_FLA_SD_lgt_63	;
self.final_score_64	:= 	wFDN_FLA_SD_lgt_64	;
self.final_score_65	:= 	wFDN_FLA_SD_lgt_65	;
self.final_score_66	:= 	wFDN_FLA_SD_lgt_66	;
self.final_score_67	:= 	wFDN_FLA_SD_lgt_67	;
self.final_score_68	:= 	wFDN_FLA_SD_lgt_68	;
self.final_score_69	:= 	wFDN_FLA_SD_lgt_69	;
self.final_score_70	:= 	wFDN_FLA_SD_lgt_70	;
self.final_score_71	:= 	wFDN_FLA_SD_lgt_71	;
self.final_score_72	:= 	wFDN_FLA_SD_lgt_72	;
self.final_score_73	:= 	wFDN_FLA_SD_lgt_73	;
self.final_score_74	:= 	wFDN_FLA_SD_lgt_74	;
self.final_score_75	:= 	wFDN_FLA_SD_lgt_75	;
self.final_score_76	:= 	wFDN_FLA_SD_lgt_76	;
self.final_score_77	:= 	wFDN_FLA_SD_lgt_77	;
self.final_score_78	:= 	wFDN_FLA_SD_lgt_78	;
self.final_score_79	:= 	wFDN_FLA_SD_lgt_79	;
self.final_score_80	:= 	wFDN_FLA_SD_lgt_80	;
self.final_score_81	:= 	wFDN_FLA_SD_lgt_81	;
self.final_score_82	:= 	wFDN_FLA_SD_lgt_82	;
self.final_score_83	:= 	wFDN_FLA_SD_lgt_83	;
self.final_score_84	:= 	wFDN_FLA_SD_lgt_84	;
self.final_score_85	:= 	wFDN_FLA_SD_lgt_85	;
self.final_score_86	:= 	wFDN_FLA_SD_lgt_86	;
self.final_score_87	:= 	wFDN_FLA_SD_lgt_87	;
self.final_score_88	:= 	wFDN_FLA_SD_lgt_88	;
self.final_score_89	:= 	wFDN_FLA_SD_lgt_89	;
self.final_score_90	:= 	wFDN_FLA_SD_lgt_90	;
self.final_score_91	:= 	wFDN_FLA_SD_lgt_91	;
self.final_score_92	:= 	wFDN_FLA_SD_lgt_92	;
self.final_score_93	:= 	wFDN_FLA_SD_lgt_93	;
self.final_score_94	:= 	wFDN_FLA_SD_lgt_94	;
self.final_score_95	:= 	wFDN_FLA_SD_lgt_95	;
self.final_score_96	:= 	wFDN_FLA_SD_lgt_96	;
self.final_score_97	:= 	wFDN_FLA_SD_lgt_97	;
self.final_score_98	:= 	wFDN_FLA_SD_lgt_98	;
self.final_score_99	:= 	wFDN_FLA_SD_lgt_99	;
self.final_score_100	:= 	wFDN_FLA_SD_lgt_100	;
self.final_score_101	:= 	wFDN_FLA_SD_lgt_101	;
self.final_score_102	:= 	wFDN_FLA_SD_lgt_102	;
self.final_score_103	:= 	wFDN_FLA_SD_lgt_103	;
self.final_score_104	:= 	wFDN_FLA_SD_lgt_104	;
self.final_score_105	:= 	wFDN_FLA_SD_lgt_105	;
self.final_score_106	:= 	wFDN_FLA_SD_lgt_106	;
self.final_score_107	:= 	wFDN_FLA_SD_lgt_107	;
self.final_score_108	:= 	wFDN_FLA_SD_lgt_108	;
self.final_score_109	:= 	wFDN_FLA_SD_lgt_109	;
self.final_score_110	:= 	wFDN_FLA_SD_lgt_110	;
self.final_score_111	:= 	wFDN_FLA_SD_lgt_111	;
self.final_score_112	:= 	wFDN_FLA_SD_lgt_112	;
self.final_score_113	:= 	wFDN_FLA_SD_lgt_113	;
self.final_score_114	:= 	wFDN_FLA_SD_lgt_114	;
self.final_score_115	:= 	wFDN_FLA_SD_lgt_115	;
self.final_score_116	:= 	wFDN_FLA_SD_lgt_116	;
self.final_score_117	:= 	wFDN_FLA_SD_lgt_117	;
self.final_score_118	:= 	wFDN_FLA_SD_lgt_118	;
self.final_score_119	:= 	wFDN_FLA_SD_lgt_119	;
self.final_score_120	:= 	wFDN_FLA_SD_lgt_120	;
self.final_score_121	:= 	wFDN_FLA_SD_lgt_121	;
self.final_score_122	:= 	wFDN_FLA_SD_lgt_122	;
self.final_score_123	:= 	wFDN_FLA_SD_lgt_123	;
self.final_score_124	:= 	wFDN_FLA_SD_lgt_124	;
self.final_score_125	:= 	wFDN_FLA_SD_lgt_125	;
self.final_score_126	:= 	wFDN_FLA_SD_lgt_126	;
self.final_score_127	:= 	wFDN_FLA_SD_lgt_127	;
self.final_score_128	:= 	wFDN_FLA_SD_lgt_128	;
self.final_score_129	:= 	wFDN_FLA_SD_lgt_129	;
self.final_score_130	:= 	wFDN_FLA_SD_lgt_130	;
self.final_score_131	:= 	wFDN_FLA_SD_lgt_131	;
self.final_score_132	:= 	wFDN_FLA_SD_lgt_132	;
self.final_score_133	:= 	wFDN_FLA_SD_lgt_133	;
self.final_score_134	:= 	wFDN_FLA_SD_lgt_134	;
self.final_score_135	:= 	wFDN_FLA_SD_lgt_135	;
self.final_score_136	:= 	wFDN_FLA_SD_lgt_136	;
self.final_score_137	:= 	wFDN_FLA_SD_lgt_137	;
self.final_score_138	:= 	wFDN_FLA_SD_lgt_138	;
self.final_score_139	:= 	wFDN_FLA_SD_lgt_139	;
self.final_score_140	:= 	wFDN_FLA_SD_lgt_140	;
self.final_score_141	:= 	wFDN_FLA_SD_lgt_141	;
self.final_score_142	:= 	wFDN_FLA_SD_lgt_142	;
self.final_score_143	:= 	wFDN_FLA_SD_lgt_143	;
self.final_score_144	:= 	wFDN_FLA_SD_lgt_144	;
self.final_score_145	:= 	wFDN_FLA_SD_lgt_145	;
self.final_score_146	:= 	wFDN_FLA_SD_lgt_146	;
self.final_score_147	:= 	wFDN_FLA_SD_lgt_147	;
self.final_score_148	:= 	wFDN_FLA_SD_lgt_148	;
self.final_score_149	:= 	wFDN_FLA_SD_lgt_149	;
self.final_score_150	:= 	wFDN_FLA_SD_lgt_150	;
self.final_score_151	:= 	wFDN_FLA_SD_lgt_151	;
self.final_score_152	:= 	wFDN_FLA_SD_lgt_152	;
self.final_score_153	:= 	wFDN_FLA_SD_lgt_153	;
self.final_score_154	:= 	wFDN_FLA_SD_lgt_154	;
self.final_score_155	:= 	wFDN_FLA_SD_lgt_155	;
self.final_score_156	:= 	wFDN_FLA_SD_lgt_156	;
self.final_score_157	:= 	wFDN_FLA_SD_lgt_157	;
self.final_score_158	:= 	wFDN_FLA_SD_lgt_158	;
self.final_score_159	:= 	wFDN_FLA_SD_lgt_159	;
self.final_score_160	:= 	wFDN_FLA_SD_lgt_160	;
self.final_score_161	:= 	wFDN_FLA_SD_lgt_161	;
self.final_score_162	:= 	wFDN_FLA_SD_lgt_162	;
self.final_score_163	:= 	wFDN_FLA_SD_lgt_163	;
self.final_score_164	:= 	wFDN_FLA_SD_lgt_164	;
self.final_score_165	:= 	wFDN_FLA_SD_lgt_165	;
self.final_score_166	:= 	wFDN_FLA_SD_lgt_166	;
self.final_score_167	:= 	wFDN_FLA_SD_lgt_167	;
self.final_score_168	:= 	wFDN_FLA_SD_lgt_168	;
self.final_score_169	:= 	wFDN_FLA_SD_lgt_169	;
self.final_score_170	:= 	wFDN_FLA_SD_lgt_170	;
self.final_score_171	:= 	wFDN_FLA_SD_lgt_171	;
self.final_score_172	:= 	wFDN_FLA_SD_lgt_172	;
self.final_score_173	:= 	wFDN_FLA_SD_lgt_173	;
self.final_score_174	:= 	wFDN_FLA_SD_lgt_174	;
self.final_score_175	:= 	wFDN_FLA_SD_lgt_175	;
self.final_score_176	:= 	wFDN_FLA_SD_lgt_176	;
self.final_score_177	:= 	wFDN_FLA_SD_lgt_177	;
self.final_score_178	:= 	wFDN_FLA_SD_lgt_178	;
self.final_score_179	:= 	wFDN_FLA_SD_lgt_179	;
self.final_score_180	:= 	wFDN_FLA_SD_lgt_180	;
self.final_score_181	:= 	wFDN_FLA_SD_lgt_181	;
self.final_score_182	:= 	wFDN_FLA_SD_lgt_182	;
self.final_score_183	:= 	wFDN_FLA_SD_lgt_183	;
self.final_score_184	:= 	wFDN_FLA_SD_lgt_184	;
self.final_score_185	:= 	wFDN_FLA_SD_lgt_185	;
self.final_score_186	:= 	wFDN_FLA_SD_lgt_186	;
self.final_score_187	:= 	wFDN_FLA_SD_lgt_187	;
self.final_score_188	:= 	wFDN_FLA_SD_lgt_188	;
self.final_score_189	:= 	wFDN_FLA_SD_lgt_189	;
self.final_score_190	:= 	wFDN_FLA_SD_lgt_190	;
self.final_score_191	:= 	wFDN_FLA_SD_lgt_191	;
self.final_score_192	:= 	wFDN_FLA_SD_lgt_192	;
self.final_score_193	:= 	wFDN_FLA_SD_lgt_193	;
self.final_score_194	:= 	wFDN_FLA_SD_lgt_194	;
self.final_score_195	:= 	wFDN_FLA_SD_lgt_195	;
self.final_score_196	:= 	wFDN_FLA_SD_lgt_196	;
self.final_score_197	:= 	wFDN_FLA_SD_lgt_197	;
self.final_score_198	:= 	wFDN_FLA_SD_lgt_198	;
self.final_score_199	:= 	wFDN_FLA_SD_lgt_199	;
self.final_score_200	:= 	wFDN_FLA_SD_lgt_200	;
self.final_score_201	:= 	wFDN_FLA_SD_lgt_201	;
self.final_score_202	:= 	wFDN_FLA_SD_lgt_202	;
self.final_score_203	:= 	wFDN_FLA_SD_lgt_203	;
self.final_score_204	:= 	wFDN_FLA_SD_lgt_204	;
self.final_score_205	:= 	wFDN_FLA_SD_lgt_205	;
self.final_score_206	:= 	wFDN_FLA_SD_lgt_206	;
self.final_score_207	:= 	wFDN_FLA_SD_lgt_207	;
self.final_score_208	:= 	wFDN_FLA_SD_lgt_208	;
self.final_score_209	:= 	wFDN_FLA_SD_lgt_209	;
self.final_score_210	:= 	wFDN_FLA_SD_lgt_210	;
self.final_score_211	:= 	wFDN_FLA_SD_lgt_211	;
self.final_score_212	:= 	wFDN_FLA_SD_lgt_212	;
self.final_score_213	:= 	wFDN_FLA_SD_lgt_213	;
self.final_score_214	:= 	wFDN_FLA_SD_lgt_214	;
self.final_score_215	:= 	wFDN_FLA_SD_lgt_215	;
self.final_score_216	:= 	wFDN_FLA_SD_lgt_216	;
self.final_score_217	:= 	wFDN_FLA_SD_lgt_217	;
self.final_score_218	:= 	wFDN_FLA_SD_lgt_218	;
self.final_score_219	:= 	wFDN_FLA_SD_lgt_219	;
self.final_score_220	:= 	wFDN_FLA_SD_lgt_220	;
self.final_score_221	:= 	wFDN_FLA_SD_lgt_221	;
self.final_score_222	:= 	wFDN_FLA_SD_lgt_222	;
self.final_score_223	:= 	wFDN_FLA_SD_lgt_223	;
self.final_score_224	:= 	wFDN_FLA_SD_lgt_224	;
self.final_score_225	:= 	wFDN_FLA_SD_lgt_225	;
self.final_score_226	:= 	wFDN_FLA_SD_lgt_226	;
self.final_score_227	:= 	wFDN_FLA_SD_lgt_227	;
self.final_score_228	:= 	wFDN_FLA_SD_lgt_228	;
self.final_score_229	:= 	wFDN_FLA_SD_lgt_229	;
self.final_score_230	:= 	wFDN_FLA_SD_lgt_230	;
self.final_score_231	:= 	wFDN_FLA_SD_lgt_231	;
self.final_score_232	:= 	wFDN_FLA_SD_lgt_232	;
self.final_score_233	:= 	wFDN_FLA_SD_lgt_233	;
self.final_score_234	:= 	wFDN_FLA_SD_lgt_234	;
// self.wFDN_submodel_lgt	:= 	wFDN_FLA_SD_lgt	;
self.FP3_wFDN_LGT		:= 	wFDN_FLA_SD_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
