
export FP31505_FLSD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   woFDN_FL__SD_lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FL__SD_lgt_1 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08442415105) => 0.0201244909,
      (f_add_curr_nhood_VAC_pct_i > 0.08442415105) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 55) => 0.4016729385,
         (c_rich_wht > 55) => 0.0664498002,
         (c_rich_wht = NULL) => 0.2153116006, 0.2153116006),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0439003693, 0.0439003693),
   (r_Ever_Asset_Owner_d > 0.5) => -0.0398719332,
   (r_Ever_Asset_Owner_d = NULL) => -0.0221117957, -0.0221117957),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0903425254,
   (f_inq_Communications_count_i > 0.5) => 0.4686572768,
   (f_inq_Communications_count_i = NULL) => 0.1845008635, 0.1845008635),
(f_srchvelocityrisktype_i = NULL) => 0.2544948542, -0.0016508818);

// Tree: 2 
woFDN_FL__SD_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 0.1462271991,
      (r_F00_dob_score_d > 95) => -0.0335009963,
      (r_F00_dob_score_d = NULL) => -0.0014473819, -0.0264870955),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.1973241382,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0215675459, -0.0215675459),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 1.5) => 0.0890105315,
      (f_rel_criminal_count_i > 1.5) => 0.3123259530,
      (f_rel_criminal_count_i = NULL) => 0.1662106350, 0.1662106350),
   (f_hh_payday_loan_users_i > 0.5) => 0.5089677717,
   (f_hh_payday_loan_users_i = NULL) => 0.2230957857, 0.2230957857),
(f_varrisktype_i = NULL) => 0.2164417253, -0.0059777504);

// Tree: 3 
woFDN_FL__SD_lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.45) => -0.0277028017,
      (c_famotf18_p > 29.45) => 0.0897941235,
      (c_famotf18_p = NULL) => -0.0515413364, -0.0203607848),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 26.35) => 0.0857749675,
      (c_famotf18_p > 26.35) => 0.3236016704,
      (c_famotf18_p = NULL) => 0.1195206483, 0.1195206483),
   (f_varrisktype_i = NULL) => -0.0133770679, -0.0133770679),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.1091117697,
   (f_srchvelocityrisktype_i > 4.5) => 0.2935612495,
   (f_srchvelocityrisktype_i = NULL) => 0.1829750230, 0.1829750230),
(f_inq_Communications_count_i = NULL) => 0.1039648280, -0.0057490280);

// Tree: 4 
woFDN_FL__SD_lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1700360286,
      (r_F00_input_dob_match_level_d > 4.5) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => -0.0281710474,
         (r_D33_eviction_count_i > 0.5) => 0.1222465165,
         (r_D33_eviction_count_i = NULL) => -0.0233519973, -0.0233519973),
      (r_F00_input_dob_match_level_d = NULL) => -0.0191619510, -0.0191619510),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0842543932,
      (f_varrisktype_i > 2.5) => 0.3136182488,
      (f_varrisktype_i = NULL) => 0.1239744497, 0.1239744497),
   (f_rel_felony_count_i = NULL) => -0.0122886965, -0.0122886965),
(f_srchfraudsrchcount_i > 8.5) => 0.1932684653,
(f_srchfraudsrchcount_i = NULL) => 0.1087949638, -0.0061382042);

// Tree: 5 
woFDN_FL__SD_lgt_5 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3826681422,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 27.35) => -0.0285741146,
      (c_famotf18_p > 27.35) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.0466100775,
         (f_assocrisktype_i > 7.5) => 0.3041695084,
         (f_assocrisktype_i = NULL) => 0.0707293553, 0.0707293553),
      (c_famotf18_p = NULL) => -0.0201382500, -0.0201945234),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0183229625, -0.0183229625),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0450420510,
   (f_assocrisktype_i > 4.5) => 0.1735435966,
   (f_assocrisktype_i = NULL) => 0.0796941532, 0.0796941532),
(f_srchvelocityrisktype_i = NULL) => 0.0919966659, -0.0050311233);

// Tree: 6 
woFDN_FL__SD_lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1806773836,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0236110126,
      (f_assocrisktype_i > 8.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 116.5) => 0.3321472802,
         (r_C10_M_Hdr_FS_d > 116.5) => 0.0626313777,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0950380994, 0.0950380994),
      (f_assocrisktype_i = NULL) => -0.0186336350, -0.0186336350),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0138900818, -0.0138900818),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1868003260,
   (r_I60_inq_comm_recency_d > 549) => 0.0790557248,
   (r_I60_inq_comm_recency_d = NULL) => 0.1219391482, 0.1219391482),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0595449060, -0.0090181875);

// Tree: 7 
woFDN_FL__SD_lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1447503283,
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0277712530,
      (f_varrisktype_i > 2.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0233872027,
         (f_assocrisktype_i > 4.5) => 
            map(
            (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 0.2893136107,
            (r_Prop_Owner_History_d > 0.5) => 0.0587573739,
            (r_Prop_Owner_History_d = NULL) => 0.1409556844, 0.1409556844),
         (f_assocrisktype_i = NULL) => 0.0472959125, 0.0472959125),
      (f_varrisktype_i = NULL) => -0.0203120222, -0.0203120222),
   (r_F00_dob_score_d = NULL) => -0.0059436868, -0.0146158760),
(f_inq_Communications_count_i > 1.5) => 0.1268143109,
(f_inq_Communications_count_i = NULL) => 0.0550263698, -0.0094345399);

// Tree: 8 
woFDN_FL__SD_lgt_8 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0984921710,
      (r_F00_dob_score_d > 92) => -0.0360688751,
      (r_F00_dob_score_d = NULL) => -0.0439461545, -0.0320631963),
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 55.35) => 0.1352079966,
      (c_fammar_p > 55.35) => 0.0169577773,
      (c_fammar_p = NULL) => -0.0241293839, 0.0330778275),
   (nf_seg_FraudPoint_3_0 = '') => -0.0195128780, -0.0195128780),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0434714438,
   (f_rel_felony_count_i > 0.5) => 0.1651100248,
   (f_rel_felony_count_i = NULL) => 0.0667390896, 0.0667390896),
(f_varrisktype_i = NULL) => 0.0428064534, -0.0098199511);

// Tree: 9 
woFDN_FL__SD_lgt_9 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 19.5) => 0.0844745547,
   (f_rel_count_i > 19.5) => 0.2048846987,
   (f_rel_count_i = NULL) => 0.1226946285, 0.1226946285),
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 44.35) => 0.0936727334,
   (c_fammar_p > 44.35) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0312667416,
      (f_hh_lienholders_i > 0.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0115150556,
         (f_varrisktype_i > 2.5) => 0.1045467326,
         (f_varrisktype_i = NULL) => 0.0203608700, 0.0203608700),
      (f_hh_lienholders_i = NULL) => -0.0156788830, -0.0156788830),
   (c_fammar_p = NULL) => -0.0346053825, -0.0101933963),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0853954108, -0.0057405258);

// Tree: 10 
woFDN_FL__SD_lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 5.25) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27887) => 0.2301240170,
         (f_curraddrmedianincome_d > 27887) => 0.0283460460,
         (f_curraddrmedianincome_d = NULL) => 0.0825683201, 0.0825683201),
      (c_high_ed > 5.25) => -0.0184916834,
      (c_high_ed = NULL) => -0.0295795986, -0.0148180587),
   (r_D30_Derog_Count_i > 5.5) => 0.0909455385,
   (r_D30_Derog_Count_i = NULL) => -0.0100561287, -0.0100561287),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0484738528,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.1557498892,
   (nf_seg_FraudPoint_3_0 = '') => 0.0969684994, 0.0969684994),
(f_inq_Communications_count_i = NULL) => 0.0290970271, -0.0060581944);

// Tree: 11 
woFDN_FL__SD_lgt_11 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0244541925,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 2.5) => 0.0037859571,
      (f_srchssnsrchcount_i > 2.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 0.1353350021,
         (k_estimated_income_d > 32500) => 0.0239610969,
         (k_estimated_income_d = NULL) => 0.0714415513, 0.0714415513),
      (f_srchssnsrchcount_i = NULL) => 0.0169611156, 0.0169611156),
   (f_assocrisktype_i > 5.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 25.7) => 0.0883258705,
      (c_famotf18_p > 25.7) => 0.1736121211,
      (c_famotf18_p = NULL) => 0.1055484575, 0.1055484575),
   (f_assocrisktype_i = NULL) => 0.0257662552, 0.0325595938),
(nf_seg_FraudPoint_3_0 = '') => -0.0080399751, -0.0080399751);

// Tree: 12 
woFDN_FL__SD_lgt_12 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2069847466,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 3.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 12.05) => -0.0150816776,
         (c_unemp > 12.05) => 0.1312639216,
         (c_unemp = NULL) => -0.0263654868, -0.0136788365),
      (f_srchfraudsrchcountyr_i > 3.5) => 0.0945699501,
      (f_srchfraudsrchcountyr_i = NULL) => -0.0116073872, -0.0116073872),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0104288966, -0.0104288966),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 0.1735354131,
   (r_I60_inq_recency_d > 4.5) => 0.0624355480,
   (r_I60_inq_recency_d = NULL) => 0.0969927735, 0.0969927735),
(f_inq_PrepaidCards_count_i = NULL) => 0.0596743915, -0.0069686460);

// Tree: 13 
woFDN_FL__SD_lgt_13 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 0.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 13.25) => -0.0164617810,
         (c_unemp > 13.25) => 0.1370354016,
         (c_unemp = NULL) => -0.0209446941, -0.0155072463),
      (f_inq_Communications_count24_i > 0.5) => 
         map(
         (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 1.5) => 0.0312379988,
         (f_assoccredbureaucount_i > 1.5) => 0.1411571268,
         (f_assoccredbureaucount_i = NULL) => 0.0651182321, 0.0651182321),
      (f_inq_Communications_count24_i = NULL) => -0.0108595162, -0.0108595162),
   (f_assocsuspicousidcount_i > 13.5) => 0.1936556265,
   (f_assocsuspicousidcount_i = NULL) => -0.0025004708, -0.0090690692),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.3325223847,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0076955936, -0.0076955936);

// Tree: 14 
woFDN_FL__SD_lgt_14 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0852528968,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.1646661025,
      (r_F00_dob_score_d > 55) => 
         map(
         (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => -0.0170582667,
         (f_hh_members_w_derog_i > 3.5) => 
            map(
            (NULL < c_many_cars and c_many_cars <= 43.5) => 0.2525300473,
            (c_many_cars > 43.5) => 0.0447722570,
            (c_many_cars = NULL) => 0.0763642921, 0.0763642921),
         (f_hh_members_w_derog_i = NULL) => -0.0138064240, -0.0138064240),
      (r_F00_dob_score_d = NULL) => -0.0089823798, -0.0125617852),
   (f_srchfraudsrchcountmo_i > 0.5) => 0.0853296860,
   (f_srchfraudsrchcountmo_i = NULL) => -0.0092207520, -0.0092207520),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0060312205, -0.0063422409);

// Tree: 15 
woFDN_FL__SD_lgt_15 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 23.45) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 30.95) => 0.0363064757,
      (c_famotf18_p > 30.95) => 0.1256952237,
      (c_famotf18_p = NULL) => 0.0570788609, 0.0570788609),
   (c_white_col > 23.45) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => -0.0191357687,
         (k_comb_age_d > 84.5) => 0.2232429780,
         (k_comb_age_d = NULL) => -0.0172799166, -0.0172799166),
      (r_D33_eviction_count_i > 2.5) => 0.1110903787,
      (r_D33_eviction_count_i = NULL) => -0.0159091651, -0.0159091651),
   (c_white_col = NULL) => -0.0319792543, -0.0092931969),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.1345644162,
(f_inq_PrepaidCards_count24_i = NULL) => 0.0667506966, -0.0069964960);

// Tree: 16 
woFDN_FL__SD_lgt_16 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.0874851154,
   (r_C10_M_Hdr_FS_d > 13.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0736198013,
      (r_F00_dob_score_d > 92) => -0.0158736549,
      (r_F00_dob_score_d = NULL) => -0.0096485187, -0.0128193548),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0096010295, -0.0096010295),
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => 0.0282563684,
      (f_inq_HighRiskCredit_count_i > 4.5) => 0.1206226982,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0352058351, 0.0352058351),
   (r_D30_Derog_Count_i > 5.5) => 0.1423595383,
   (r_D30_Derog_Count_i = NULL) => 0.0474132191, 0.0474132191),
(f_inq_Communications_count_i = NULL) => 0.0255121969, -0.0040174730);

// Tree: 17 
woFDN_FL__SD_lgt_17 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.35) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0362382209,
      (c_housingcpi > 222.35) => 0.0203636729,
      (c_housingcpi = NULL) => -0.0222351052, -0.0222351052),
   (c_unemp > 9.35) => 0.0740367547,
   (c_unemp = NULL) => -0.0145177960, -0.0184407734),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 2.5) => 0.0058134401,
   (f_assocsuspicousidcount_i > 2.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 72675.5) => 0.1474002341,
      (r_A46_Curr_AVM_AutoVal_d > 72675.5) => 0.0250427454,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0946087871, 0.0665950122),
   (f_assocsuspicousidcount_i = NULL) => 0.0326868603, 0.0326868603),
(f_srchvelocityrisktype_i = NULL) => 0.0156744768, -0.0116060663);

// Tree: 18 
woFDN_FL__SD_lgt_18 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.1067831901,
      (r_C21_M_Bureau_ADL_FS_d > 7.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0421670382,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
            map(
            (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= -0.5) => 0.0114705376,
            (r_pb_order_freq_d > -0.5) => -0.0249545393,
            (r_pb_order_freq_d = NULL) => 0.0418049328, 0.0059508326),
         (nf_seg_FraudPoint_3_0 = '') => -0.0133268005, -0.0133268005),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0110094397, -0.0110094397),
   (f_srchunvrfdaddrcount_i > 0.5) => 0.0901971087,
   (f_srchunvrfdaddrcount_i = NULL) => -0.0029458888, -0.0084158132),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.2092554271,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0075577588, -0.0075577588);

// Tree: 19 
woFDN_FL__SD_lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 36.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 16.55) => 0.0701302878,
         (c_hh4_p > 16.55) => 0.2547633935,
         (c_hh4_p = NULL) => 0.1448133418, 0.1448133418),
      (r_D32_Mos_Since_Crim_LS_d > 36.5) => 0.0259647278,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0361372198, 0.0361372198),
   (f_mos_inq_banko_cm_lseen_d > 44.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1192978882,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0096943463,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0089346894, -0.0089346894),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0013280587, -0.0013280587),
(f_inq_PrepaidCards_count_i > 1.5) => 0.1123622731,
(f_inq_PrepaidCards_count_i = NULL) => 0.0182339009, -0.0000179627);

// Tree: 20 
woFDN_FL__SD_lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < f_validationrisktype_i and f_validationrisktype_i <= 3.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => -0.0134350920,
      (k_comb_age_d > 71.5) => 0.0770112360,
      (k_comb_age_d = NULL) => -0.0084680108, -0.0084680108),
   (f_validationrisktype_i > 3.5) => 0.1790678765,
   (f_validationrisktype_i = NULL) => -0.0073472451, -0.0073472451),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 10.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 45.65) => 0.0310427828,
      (c_famotf18_p > 45.65) => 0.1706925613,
      (c_famotf18_p = NULL) => 0.0364935939, 0.0364935939),
   (f_assocsuspicousidcount_i > 10.5) => 0.1488948776,
   (f_assocsuspicousidcount_i = NULL) => 0.0419586780, 0.0419586780),
(f_varrisktype_i = NULL) => 0.0386797973, -0.0016426997);

// Tree: 21 
woFDN_FL__SD_lgt_21 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 5.5) => 0.1036971746,
(r_C21_M_Bureau_ADL_FS_d > 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0195143867,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 
         map(
         (NULL < c_professional and c_professional <= 2.85) => 0.0473712724,
         (c_professional > 2.85) => -0.0204873367,
         (c_professional = NULL) => -0.0361639043, 0.0084259544),
      (k_inq_per_ssn_i > 3.5) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 8.35) => 0.0270446723,
         (c_hh5_p > 8.35) => 0.1582351746,
         (c_hh5_p = NULL) => 0.0703046228, 0.0703046228),
      (k_inq_per_ssn_i = NULL) => 0.0152169364, 0.0152169364),
   (nf_seg_FraudPoint_3_0 = '') => -0.0122228514, -0.0122228514),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0065681429, -0.0106064765);

// Tree: 22 
woFDN_FL__SD_lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0175697203,
   (f_assocrisktype_i > 3.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
         map(
         (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 0.1967009466,
         (r_F00_input_dob_match_level_d > 5.5) => 
            map(
            (NULL < c_med_hhinc and c_med_hhinc <= 46209) => 0.1001193215,
            (c_med_hhinc > 46209) => 0.0426372415,
            (c_med_hhinc = NULL) => -0.0310381100, 0.0544111054),
         (r_F00_input_dob_match_level_d = NULL) => 0.0594822318, 0.0594822318),
      (r_C12_Num_NonDerogs_d > 3.5) => -0.0040300058,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0270315157, 0.0270315157),
   (f_assocrisktype_i = NULL) => -0.0070883761, -0.0070883761),
(r_D33_eviction_count_i > 2.5) => 0.1212841541,
(r_D33_eviction_count_i = NULL) => -0.0014870956, -0.0056784574);

// Tree: 23 
woFDN_FL__SD_lgt_23 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 0.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 4.5) => 0.0563381402,
      (f_rel_educationover12_count_d > 4.5) => 0.2928754575,
      (f_rel_educationover12_count_d = NULL) => 0.1790697671, 0.1790697671),
   (f_util_adl_count_n > 0.5) => 0.0018643928,
   (f_util_adl_count_n = NULL) => 0.0826071641, 0.0826071641),
(r_F00_input_dob_match_level_d > 4.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.0805998519,
   (r_D33_Eviction_Recency_d > 79.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.0810394906,
      (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0094767182,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0076707224, -0.0076707224),
   (r_D33_Eviction_Recency_d = NULL) => -0.0060771070, -0.0060771070),
(r_F00_input_dob_match_level_d = NULL) => 0.0147167834, -0.0042039355);

// Tree: 24 
woFDN_FL__SD_lgt_24 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 122) => 0.1944164536,
(r_D32_Mos_Since_Fel_LS_d > 122) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 90.5) => -0.0060964491,
   (r_pb_order_freq_d > 90.5) => -0.0366065438,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => 0.0108315436,
      (f_rel_criminal_count_i > 6.5) => 
         map(
         (NULL < C_INC_100K_P and C_INC_100K_P <= 12.85) => 
            map(
            (NULL < c_asian_lang and c_asian_lang <= 123) => 0.0406361982,
            (c_asian_lang > 123) => 0.3178836936,
            (c_asian_lang = NULL) => 0.1566090067, 0.1566090067),
         (C_INC_100K_P > 12.85) => 0.0420980880,
         (C_INC_100K_P = NULL) => 0.0966780586, 0.0966780586),
      (f_rel_criminal_count_i = NULL) => 0.0166752579, 0.0166752579), -0.0054150411),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0114379534, -0.0041217484);

// Tree: 25 
woFDN_FL__SD_lgt_25 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 80) => 0.1410634804,
      (r_F00_dob_score_d > 80) => 0.0057449083,
      (r_F00_dob_score_d = NULL) => -0.0094460268, 0.0065366495),
   (f_historical_count_d > 0.5) => -0.0334457305,
   (f_historical_count_d = NULL) => -0.0126534093, -0.0126534093),
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1272897644) => 0.0160717652,
      (f_add_curr_nhood_BUS_pct_i > 0.1272897644) => 0.1343553288,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0246990594, 0.0307838533),
   (f_srchcomponentrisktype_i > 3.5) => 0.1498233715,
   (f_srchcomponentrisktype_i = NULL) => 0.0371080335, 0.0371080335),
(f_rel_felony_count_i = NULL) => 0.0090627792, -0.0053970346);

// Tree: 26 
woFDN_FL__SD_lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_employees and c_employees <= 29.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 5.35) => 0.0342187977,
      (c_hh7p_p > 5.35) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly','6: Other']) => 0.0316309934,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity']) => 0.2101765752,
         (nf_seg_FraudPoint_3_0 = '') => 0.1295430866, 0.1295430866),
      (c_hh7p_p = NULL) => 0.0491057144, 0.0491057144),
   (c_employees > 29.5) => -0.0074572666,
   (c_employees = NULL) => 0.0123315284, -0.0015441076),
(r_D30_Derog_Count_i > 11.5) => 0.1073788580,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 28.5) => -0.0808789116,
   (k_comb_age_d > 28.5) => 0.1239953160,
   (k_comb_age_d = NULL) => 0.0195496313, 0.0195496313), 0.0001110154);

// Tree: 27 
woFDN_FL__SD_lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 43.75) => 0.0591030207,
(c_fammar_p > 43.75) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 130) => -0.0091698631,
      (r_C13_max_lres_d > 130) => 
         map(
         (NULL < c_incollege and c_incollege <= 6.25) => 0.0397603586,
         (c_incollege > 6.25) => 0.2822241617,
         (c_incollege = NULL) => 0.1326188364, 0.1326188364),
      (r_C13_max_lres_d = NULL) => 0.0685452258, 0.0685452258),
   (r_F00_dob_score_d > 98) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0178338249,
      (k_inq_per_ssn_i > 2.5) => 0.0365384375,
      (k_inq_per_ssn_i = NULL) => -0.0110497445, -0.0110497445),
   (r_F00_dob_score_d = NULL) => -0.0110728353, -0.0087115387),
(c_fammar_p = NULL) => -0.0161521454, -0.0050817126);

// Tree: 28 
woFDN_FL__SD_lgt_28 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0307610932,
      (f_inq_Communications_count_i > 0.5) => 0.1042427117,
      (f_inq_Communications_count_i = NULL) => 0.0533358585, 0.0533358585),
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.0769404566,
      (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1014516139,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0108047433,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0101538998, -0.0101538998),
      (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0090841044, -0.0090841044),
   (r_D33_Eviction_Recency_d = NULL) => -0.0105261208, -0.0066965829),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1538787532,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0059370622, -0.0059370622);

// Tree: 29 
woFDN_FL__SD_lgt_29 := map(
(NULL < c_exp_prod and c_exp_prod <= 32.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08567437715) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 179.5) => -0.0160996891,
      (c_span_lang > 179.5) => 0.1127022900,
      (c_span_lang = NULL) => 0.0144009304, 0.0144009304),
   (f_add_curr_nhood_VAC_pct_i > 0.08567437715) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 15.65) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 139.5) => -0.0392049094,
         (c_sub_bus > 139.5) => 0.1445362534,
         (c_sub_bus = NULL) => 0.0377367026, 0.0377367026),
      (c_pop_45_54_p > 15.65) => 0.2889626171,
      (c_pop_45_54_p = NULL) => 0.1011301576, 0.1011301576),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0355640486, 0.0355640486),
(c_exp_prod > 32.5) => -0.0066877810,
(c_exp_prod = NULL) => -0.0246108304, -0.0042171472);

// Tree: 30 
woFDN_FL__SD_lgt_30 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 92) => 0.1383968061,
(r_D32_Mos_Since_Fel_LS_d > 92) => 
   map(
   (NULL < c_employees and c_employees <= 39.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 224.5) => 0.0095794013,
      (r_pb_order_freq_d > 224.5) => -0.0693580070,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
            map(
            (NULL < c_born_usa and c_born_usa <= 181.5) => 0.0277648121,
            (c_born_usa > 181.5) => 0.2333356952,
            (c_born_usa = NULL) => 0.0477791390, 0.0477791390),
         (f_hh_payday_loan_users_i > 0.5) => 0.1978931317,
         (f_hh_payday_loan_users_i = NULL) => 0.0654781687, 0.0654781687), 0.0254398304),
   (c_employees > 39.5) => -0.0129617052,
   (c_employees = NULL) => -0.0189346203, -0.0081607484),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0032964995, -0.0073551946);

// Tree: 31 
woFDN_FL__SD_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0064367513,
      (f_assocsuspicousidcount_i > 15.5) => 0.1334746652,
      (f_assocsuspicousidcount_i = NULL) => -0.0057027188, -0.0057027188),
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 28.55) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0265730686) => 0.0215140553,
         (f_add_curr_nhood_BUS_pct_i > 0.0265730686) => 0.2256527279,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1483852864, 0.1483852864),
      (c_hh2_p > 28.55) => 0.0322502156,
      (c_hh2_p = NULL) => 0.0621437532, 0.0621437532),
   (k_comb_age_d = NULL) => -0.0008182493, -0.0008182493),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1588435966,
(f_inq_PrepaidCards_count_i = NULL) => -0.0016013114, -0.0001575144);

// Tree: 32 
woFDN_FL__SD_lgt_32 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 12.85) => 0.1145552252,
   (C_INC_100K_P > 12.85) => -0.0002957838,
   (C_INC_100K_P = NULL) => 0.0629108118, 0.0629108118),
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0334546799,
   (f_hh_members_ct_d > 1.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0180300811,
      (f_hh_collections_ct_i > 2.5) => 0.0412060650,
      (f_hh_collections_ct_i = NULL) => -0.0111967163, -0.0111967163),
   (f_hh_members_ct_d = NULL) => -0.0029254108, -0.0029254108),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0683587191,
   (r_S66_adlperssn_count_i > 1.5) => 0.1110176803,
   (r_S66_adlperssn_count_i = NULL) => 0.0187669606, 0.0187669606), -0.0019517694);

// Tree: 33 
woFDN_FL__SD_lgt_33 := map(
(NULL < c_white_col and c_white_col <= 17.95) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 139.5) => 0.0270040788,
   (c_old_homes > 139.5) => 0.1326023657,
   (c_old_homes = NULL) => 0.0593809120, 0.0593809120),
(c_white_col > 17.95) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 3204) => -0.0182326756,
   (r_A50_pb_total_dollars_d > 3204) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 133) => 0.0298596780,
         (f_fp_prevaddrburglaryindex_i > 133) => 0.1325815970,
         (f_fp_prevaddrburglaryindex_i = NULL) => 0.0578367860, 0.0578367860),
      (r_I60_inq_comm_recency_d > 549) => 0.0064763571,
      (r_I60_inq_comm_recency_d = NULL) => 0.0119411778, 0.0119411778),
   (r_A50_pb_total_dollars_d = NULL) => -0.0202146029, -0.0065753863),
(c_white_col = NULL) => -0.0095794569, -0.0044437177);

// Tree: 34 
woFDN_FL__SD_lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1038799192,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 3.45) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 1217) => 0.0824623056,
         (c_popover18 > 1217) => -0.0877313112,
         (c_popover18 = NULL) => 0.0015165610, 0.0015165610),
      (c_rnt1250_p > 3.45) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 37.5) => 0.1908721115,
         (k_comb_age_d > 37.5) => 0.0572383240,
         (k_comb_age_d = NULL) => 0.1170951246, 0.1170951246),
      (c_rnt1250_p = NULL) => 0.0638510672, 0.0638510672),
   (r_F00_dob_score_d > 95) => -0.0048121121,
   (r_F00_dob_score_d = NULL) => 0.0186714375, -0.0019034266),
(r_C10_M_Hdr_FS_d = NULL) => 0.0050786453, -0.0012418213);

// Tree: 35 
woFDN_FL__SD_lgt_35 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0111968000,
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 
         map(
         (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 14.5) => 0.0096560377,
         (f_inq_Collection_count_i > 14.5) => 0.1169121086,
         (f_inq_Collection_count_i = NULL) => 0.0138115836, 0.0138115836),
      (k_comb_age_d > 66.5) => 0.1873365352,
      (k_comb_age_d = NULL) => 0.0225098521, 0.0225098521),
   (f_srchvelocityrisktype_i = NULL) => -0.0068518234, -0.0068518234),
(f_hh_tot_derog_i > 5.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => 0.1159628522,
   (r_D31_attr_bankruptcy_recency_d > 9) => -0.0272495122,
   (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0658776537, 0.0658776537),
(f_hh_tot_derog_i = NULL) => 0.0081956311, -0.0046430413);

// Tree: 36 
woFDN_FL__SD_lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0190197499,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 80) => 0.1295131323,
   (r_F00_dob_score_d > 80) => 
      map(
      (NULL < f_srchssnsrchcountwk_i and f_srchssnsrchcountwk_i <= 0.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 14.85) => 
            map(
            (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.1040751176,
            (r_D32_Mos_Since_Crim_LS_d > 10.5) => 0.0045822955,
            (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0095897076, 0.0095897076),
         (c_hh6_p > 14.85) => 0.2148084735,
         (c_hh6_p = NULL) => 0.0123636550, 0.0123636550),
      (f_srchssnsrchcountwk_i > 0.5) => 0.1649156743,
      (f_srchssnsrchcountwk_i = NULL) => 0.0144539390, 0.0144539390),
   (r_F00_dob_score_d = NULL) => 0.0008973015, 0.0156499421),
(f_hh_criminals_i = NULL) => -0.0002736348, -0.0076826337);

// Tree: 37 
woFDN_FL__SD_lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0080003908,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 87.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => 0.0405758678,
      (r_C13_Curr_Addr_LRes_d > 310.5) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 1.15) => 0.4064598650,
         (c_pop_85p_p > 1.15) => 0.0839487435,
         (c_pop_85p_p = NULL) => 0.2467113656, 0.2467113656),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0515930997, 0.0515930997),
   (c_born_usa > 87.5) => -0.0021354714,
   (c_born_usa = NULL) => 0.0254098805, 0.0254098805),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0938773420,
   (r_S66_adlperssn_count_i > 1.5) => 0.1216026971,
   (r_S66_adlperssn_count_i = NULL) => 0.0119387486, 0.0119387486), 0.0025661606);

// Tree: 38 
woFDN_FL__SD_lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 
      map(
      (NULL < c_business and c_business <= 21.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 45) => 0.2559282724,
         (f_prevaddrlenofres_d > 45) => 0.0590672974,
         (f_prevaddrlenofres_d = NULL) => 0.1630693219, 0.1630693219),
      (c_business > 21.5) => -0.0249815709,
      (c_business = NULL) => 0.0732124914, 0.0732124914),
   (r_D32_Mos_Since_Crim_LS_d > 9.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.0547481273,
      (r_F00_input_dob_match_level_d > 4.5) => -0.0071123339,
      (r_F00_input_dob_match_level_d = NULL) => -0.0059021406, -0.0059021406),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0046133612, -0.0046133612),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1059786025,
(f_inq_PrepaidCards_count_i = NULL) => 0.0060720037, -0.0039492089);

// Tree: 39 
woFDN_FL__SD_lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0048767981,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
      map(
      (NULL < c_no_move and c_no_move <= 95.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.12835303335) => -0.0098389141,
         (f_add_curr_nhood_BUS_pct_i > 0.12835303335) => 0.1383615425,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0079629425, 0.0079629425),
      (c_no_move > 95.5) => 
         map(
         (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.2163428995,
         (f_inq_count_i > 2.5) => 0.0505297162,
         (f_inq_count_i = NULL) => 0.0817463791, 0.0817463791),
      (c_no_move = NULL) => 0.0289049450, 0.0289049450),
   (k_comb_age_d > 69.5) => 0.2742476133,
   (k_comb_age_d = NULL) => 0.0392215881, 0.0392215881),
(k_inq_per_ssn_i = NULL) => 0.0004143130, 0.0004143130);

// Tree: 40 
woFDN_FL__SD_lgt_40 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0062736873,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_construction and c_construction <= 6.25) => 
      map(
      (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 4.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 6.85) => 0.0696920077,
         (c_incollege > 6.85) => 0.2520093180,
         (c_incollege = NULL) => 0.1453708912, 0.1453708912),
      (r_I60_inq_banking_recency_d > 4.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 22.2) => 0.0251706216,
         (c_pop_35_44_p > 22.2) => 0.2145995587,
         (c_pop_35_44_p = NULL) => 0.0424475279, 0.0424475279),
      (r_I60_inq_banking_recency_d = NULL) => 0.0636180515, 0.0636180515),
   (c_construction > 6.25) => -0.0075641230,
   (c_construction = NULL) => 0.0280039578, 0.0280039578),
(k_inq_per_ssn_i = NULL) => -0.0020501194, -0.0020501194);

// Tree: 41 
woFDN_FL__SD_lgt_41 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1457569131,
   (f_attr_arrest_recency_d > 48) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 
         map(
         (NULL < c_construction and c_construction <= 5.05) => 0.1615176921,
         (c_construction > 5.05) => 0.0151257405,
         (c_construction = NULL) => 0.0788770743, 0.0788770743),
      (r_I60_inq_comm_recency_d > 4.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 41.5) => -0.0088960403,
         (r_pb_order_freq_d > 41.5) => -0.0311657231,
         (r_pb_order_freq_d = NULL) => 0.0084303534, -0.0104656635),
      (r_I60_inq_comm_recency_d = NULL) => -0.0095508670, -0.0095508670),
   (f_attr_arrest_recency_d = NULL) => -0.0188409691, -0.0089321160),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1083627953,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0084697425, -0.0084697425);

// Tree: 42 
woFDN_FL__SD_lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 222) => 0.0882621674,
(r_D32_Mos_Since_Fel_LS_d > 222) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 5.25) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 2.5) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0005884825,
         (r_F04_curr_add_occ_index_d > 2) => 0.0556744585,
         (r_F04_curr_add_occ_index_d = NULL) => 0.0110279241, 0.0110279241),
      (f_hh_lienholders_i > 2.5) => 0.1282336741,
      (f_hh_lienholders_i = NULL) => 0.0155049312, 0.0155049312),
   (c_newhouse > 5.25) => -0.0156985256,
   (c_newhouse = NULL) => -0.0360796802, -0.0059792612),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0889096332,
   (k_comb_age_d > 27.5) => 0.0665733726,
   (k_comb_age_d = NULL) => -0.0104133584, -0.0104133584), -0.0051980358);

// Tree: 43 
woFDN_FL__SD_lgt_43 := map(
(NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0121259450,
   (c_housingcpi > 222.35) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 480.5) => 
         map(
         (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 0.0144175573,
         (r_D32_criminal_count_i > 2.5) => 0.1229813474,
         (r_D32_criminal_count_i = NULL) => 0.0183155106, 0.0183155106),
      (r_C10_M_Hdr_FS_d > 480.5) => 0.2307233195,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0231127683, 0.0231127683),
   (c_housingcpi = NULL) => -0.0021755066, -0.0035620140),
(f_srchunvrfddobcount_i > 0.5) => 
   map(
   (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 1.5) => 0.0234973450,
   (k_inq_addrs_per_ssn_i > 1.5) => 0.1137832390,
   (k_inq_addrs_per_ssn_i = NULL) => 0.0442673394, 0.0442673394),
(f_srchunvrfddobcount_i = NULL) => -0.0006851180, -0.0019355774);

// Tree: 44 
woFDN_FL__SD_lgt_44 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 22.05) => 0.0126020021,
   (c_famotf18_p > 22.05) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0433253422,
      (f_rel_felony_count_i > 0.5) => 0.1606844553,
      (f_rel_felony_count_i = NULL) => 0.0661135195, 0.0661135195),
   (c_famotf18_p = NULL) => 0.0439588274, 0.0225980244),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 5.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 58.5) => 0.1035479934,
      (f_mos_liens_unrel_SC_fseen_d > 58.5) => -0.0160627703,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0149487731, -0.0149487731),
   (f_rel_homeover500_count_d > 5.5) => 0.0577400131,
   (f_rel_homeover500_count_d = NULL) => -0.0106477038, -0.0106477038),
(f_hh_members_ct_d = NULL) => 0.0223552254, -0.0040423870);

// Tree: 45 
woFDN_FL__SD_lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0033226477,
   (f_assocsuspicousidcount_i > 13.5) => 0.0848932825,
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0672700217,
      (k_comb_age_d > 27.5) => 0.0862091638,
      (k_comb_age_d = NULL) => 0.0094695710, 0.0094695710), -0.0025232017),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 171.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 73.5) => -0.0471235652,
      (c_unempl > 73.5) => 0.0814409920,
      (c_unempl = NULL) => 0.0341452222, 0.0341452222),
   (c_sub_bus > 171.5) => 0.2318966035,
   (c_sub_bus = NULL) => 0.0574233848, 0.0574233848),
(k_comb_age_d = NULL) => 0.0017347308, 0.0017347308);

// Tree: 46 
woFDN_FL__SD_lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 0.15) => 0.0210611638,
   (c_finance > 0.15) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 64.9) => 0.1974580015,
         (r_C12_source_profile_d > 64.9) => -0.0143176409,
         (r_C12_source_profile_d = NULL) => 0.0983289774, 0.0983289774),
      (f_mos_liens_unrel_SC_fseen_d > 87.5) => -0.0141953117,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0122568969, -0.0122568969),
   (c_finance = NULL) => -0.0144002452, -0.0018009342),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 132.5) => 0.0145490942,
   (c_serv_empl > 132.5) => 0.1474376338,
   (c_serv_empl = NULL) => 0.0709494628, 0.0709494628),
(r_D32_felony_count_i = NULL) => -0.0092460075, -0.0008708324);

// Tree: 47 
woFDN_FL__SD_lgt_47 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0057106567,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 0.1407719380,
   (r_C12_source_profile_index_d > 1.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
         map(
         (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
            map(
            (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 0.0399455889,
            (f_historical_count_d > 1.5) => -0.0234521444,
            (f_historical_count_d = NULL) => 0.0041899037, 0.0041899037),
         (f_srchfraudsrchcountmo_i > 0.5) => 0.0968821316,
         (f_srchfraudsrchcountmo_i = NULL) => 0.0089348630, 0.0089348630),
      (f_hh_collections_ct_i > 4.5) => 0.1620679628,
      (f_hh_collections_ct_i = NULL) => 0.0135323925, 0.0135323925),
   (r_C12_source_profile_index_d = NULL) => 0.0195514249, 0.0195514249),
(f_rel_felony_count_i = NULL) => -0.0039768023, -0.0020765916);

// Tree: 48 
woFDN_FL__SD_lgt_48 := map(
(NULL < c_unemp and c_unemp <= 11.45) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0885798403,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0055928156,
      (f_nae_nothing_found_i > 0.5) => 0.1211072282,
      (f_nae_nothing_found_i = NULL) => -0.0038373267, -0.0038373267),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0131068480, -0.0032980242),
(c_unemp > 11.45) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 166.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.04667936855) => 0.0192632424,
      (f_add_curr_nhood_VAC_pct_i > 0.04667936855) => 0.1755384903,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1140128021, 0.1140128021),
   (f_curraddrmurderindex_i > 166.5) => -0.0157979279,
   (f_curraddrmurderindex_i = NULL) => 0.0658157489, 0.0658157489),
(c_unemp = NULL) => -0.0007661560, -0.0021278563);

// Tree: 49 
woFDN_FL__SD_lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 97) => 0.1340615188,
         (c_rest_indx > 97) => -0.0022826742,
         (c_rest_indx = NULL) => 0.0653260165, 0.0653260165),
      (r_F00_input_dob_match_level_d > 5.5) => -0.0014491595,
      (r_F00_input_dob_match_level_d = NULL) => 0.0000491313, 0.0000491313),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 2.5) => 0.1466553829,
      (f_prevaddrageoldest_d > 2.5) => 0.0309288918,
      (f_prevaddrageoldest_d = NULL) => 0.0498540887, 0.0498540887),
   (f_varrisktype_i = NULL) => 0.0022434366, 0.0022434366),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0702271336,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0028465600, -0.0007316136);

// Tree: 50 
woFDN_FL__SD_lgt_50 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 235.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0153909562,
   (f_nae_nothing_found_i > 0.5) => 0.2442204147,
   (f_nae_nothing_found_i = NULL) => -0.0131888186, -0.0131888186),
(r_A50_pb_average_dollars_d > 235.5) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 0.0158491363,
   (f_hh_members_w_derog_i > 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 85.5) => 0.2261332251,
      (c_easiqlife > 85.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 4.4) => -0.0486807493,
         (c_rnt1000_p > 4.4) => 0.1056132011,
         (c_rnt1000_p = NULL) => 0.0454216050, 0.0454216050),
      (c_easiqlife = NULL) => 0.0855797428, 0.0855797428),
   (f_hh_members_w_derog_i = NULL) => 0.0191564621, 0.0191564621),
(r_A50_pb_average_dollars_d = NULL) => 0.0213601332, -0.0000648680);

// Tree: 51 
woFDN_FL__SD_lgt_51 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0108334977,
(f_rel_criminal_count_i > 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 37.5) => 0.0191851046,
   (r_pb_order_freq_d > 37.5) => -0.0140737471,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 26.15) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 3.5) => 0.0268335240,
         (f_rel_felony_count_i > 3.5) => 0.1159531738,
         (f_rel_felony_count_i = NULL) => 0.0322473345, 0.0322473345),
      (C_INC_75K_P > 26.15) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 0.2129739352,
         (k_estimated_income_d > 34500) => 0.0526991907,
         (k_estimated_income_d = NULL) => 0.1213883669, 0.1213883669),
      (C_INC_75K_P = NULL) => 0.0421024943, 0.0421024943), 0.0155617467),
(f_rel_criminal_count_i = NULL) => -0.0004886039, -0.0038066069);

// Tree: 52 
woFDN_FL__SD_lgt_52 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 
   map(
   (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 0.0284317802,
   (f_prevaddroccupantowned_i > 0.5) => 0.1775392424,
   (f_prevaddroccupantowned_i = NULL) => 0.0436892879, 0.0436892879),
(r_I61_inq_collection_recency_d > 9) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0133565854,
      (r_C13_Curr_Addr_LRes_d > 158.5) => 0.0263397704,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0043292873, -0.0043292873),
   (k_inq_per_ssn_i > 7.5) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 90.15) => -0.0340538446,
      (c_occunit_p > 90.15) => 0.1055102797,
      (c_occunit_p = NULL) => 0.0632892001, 0.0632892001),
   (k_inq_per_ssn_i = NULL) => -0.0029420381, -0.0029420381),
(r_I61_inq_collection_recency_d = NULL) => 0.0105179259, -0.0004669667);

// Tree: 53 
woFDN_FL__SD_lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 134.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 0.0102768893,
      (k_estimated_income_d > 32500) => -0.0300469788,
      (k_estimated_income_d = NULL) => -0.0175887015, -0.0175887015),
   (r_D32_felony_count_i > 0.5) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 14.15) => -0.0118484691,
      (c_pop_25_34_p > 14.15) => 0.1719504209,
      (c_pop_25_34_p = NULL) => 0.0809098492, 0.0809098492),
   (r_D32_felony_count_i = NULL) => -0.0281275045, -0.0163733702),
(c_easiqlife > 134.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 0.1510115939,
   (f_attr_arrest_recency_d > 99.5) => 0.0180977883,
   (f_attr_arrest_recency_d = NULL) => 0.0200303999, 0.0200303999),
(c_easiqlife = NULL) => -0.0012150367, -0.0036968584);

// Tree: 54 
woFDN_FL__SD_lgt_54 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 20.05) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 29500) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 11.05) => 
         map(
         (NULL < c_food and c_food <= 31.35) => -0.0045817223,
         (c_food > 31.35) => 0.0642950056,
         (c_food = NULL) => 0.0119423001, 0.0119423001),
      (c_hh6_p > 11.05) => 0.1500098711,
      (c_hh6_p = NULL) => 0.0163460726, 0.0163460726),
   (k_estimated_income_d > 29500) => -0.0142500196,
   (k_estimated_income_d = NULL) => 0.0126422579, -0.0077350752),
(c_hval_500k_p > 20.05) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 0.1891391776,
   (r_I61_inq_collection_recency_d > 9) => 0.0238002608,
   (r_I61_inq_collection_recency_d = NULL) => 0.0321077309, 0.0321077309),
(c_hval_500k_p = NULL) => -0.0232641487, -0.0029673229);

// Tree: 55 
woFDN_FL__SD_lgt_55 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
      map(
      (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 2.5) => 0.0127220274,
      (f_inq_Banking_count24_i > 2.5) => 
         map(
         (NULL < c_families and c_families <= 405.5) => 0.1772687851,
         (c_families > 405.5) => 0.0123969526,
         (c_families = NULL) => 0.0918887290, 0.0918887290),
      (f_inq_Banking_count24_i = NULL) => 0.0148191585, 0.0148191585),
   (k_estimated_income_d > 34500) => -0.0191867081,
   (k_estimated_income_d = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.1213851055,
      (k_comb_age_d > 27.5) => 0.0436237150,
      (k_comb_age_d = NULL) => -0.0412837363, -0.0412837363), -0.0075784358),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1069604032,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0071088663, -0.0071088663);

// Tree: 56 
woFDN_FL__SD_lgt_56 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 5.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 19.55) => 0.0151655953,
      (C_INC_50K_P > 19.55) => 0.0957019457,
      (C_INC_50K_P = NULL) => -0.0005588551, 0.0238339967),
   (f_hh_members_ct_d > 1.5) => -0.0084171277,
   (f_hh_members_ct_d = NULL) => -0.0022983785, -0.0022983785),
(f_inq_HighRiskCredit_count_i > 5.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 135549.5) => -0.0257077850,
   (f_prevaddrmedianvalue_d > 135549.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 249.5) => 0.1346875067,
      (r_C10_M_Hdr_FS_d > 249.5) => 0.0114798505,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0877090479, 0.0877090479),
   (f_prevaddrmedianvalue_d = NULL) => 0.0453054572, 0.0453054572),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0009271499, -0.0014431422);

// Tree: 57 
woFDN_FL__SD_lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 3.85) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 79.5) => -0.0119723583,
      (k_comb_age_d > 79.5) => 0.0893576119,
      (k_comb_age_d = NULL) => -0.0100981677, -0.0100981677),
   (c_hh7p_p > 3.85) => 0.0272213085,
   (c_hh7p_p = NULL) => -0.0204042681, -0.0060288668),
(r_D30_Derog_Count_i > 11.5) => 
   map(
   (NULL < c_retail and c_retail <= 16.2) => 0.0008861602,
   (c_retail > 16.2) => 0.1418460966,
   (c_retail = NULL) => 0.0543830036, 0.0543830036),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0903255058,
   (f_addrs_per_ssn_i > 3.5) => 0.0633750434,
   (f_addrs_per_ssn_i = NULL) => -0.0134752312, -0.0134752312), -0.0052969334);

// Tree: 58 
woFDN_FL__SD_lgt_58 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_rental and c_rental <= 119.5) => 0.0282329929,
      (c_rental > 119.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 39.5) => 0.1976123792,
         (f_prevaddrageoldest_d > 39.5) => 0.0758565486,
         (f_prevaddrageoldest_d = NULL) => 0.1170886028, 0.1170886028),
      (c_rental = NULL) => -0.0364789253, 0.0492889694),
   (f_corrssnnamecount_d > 1.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 464.5) => -0.0038214527,
      (f_prevaddrageoldest_d > 464.5) => 0.1798392997,
      (f_prevaddrageoldest_d = NULL) => -0.0027046295, -0.0027046295),
   (f_corrssnnamecount_d = NULL) => 0.0003773986, 0.0003773986),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0585529145,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0001572916, -0.0020956764);

// Tree: 59 
woFDN_FL__SD_lgt_59 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0367382424,
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0014597488,
      (f_nae_nothing_found_i > 0.5) => 0.1306979126,
      (f_nae_nothing_found_i = NULL) => 0.0000613792, 0.0000613792),
   (f_validationrisktype_i > 1.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 214) => -0.0717639491,
      (r_C10_M_Hdr_FS_d > 214) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 65) => 0.2628239502,
         (c_born_usa > 65) => 0.0638415211,
         (c_born_usa = NULL) => 0.1431461124, 0.1431461124),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0705004579, 0.0705004579),
   (f_validationrisktype_i = NULL) => 0.0014950652, 0.0014950652),
(f_addrs_per_ssn_i = NULL) => -0.0050574938, -0.0050574938);

// Tree: 60 
woFDN_FL__SD_lgt_60 := map(
(NULL < c_hh1_p and c_hh1_p <= 19.85) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.81425564445) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 0.0384926449,
      (r_C14_Addr_Stability_v2_d > 5.5) => 
         map(
         (NULL < c_rape and c_rape <= 103.5) => 0.1212895226,
         (c_rape > 103.5) => -0.0449182450,
         (c_rape = NULL) => 0.0682295376, 0.0682295376),
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0494642130, 0.0494642130),
   (f_add_curr_nhood_SFD_pct_d > 0.81425564445) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 4.5) => -0.0072450265,
      (f_rel_incomeover100_count_d > 4.5) => 0.0478623041,
      (f_rel_incomeover100_count_d = NULL) => -0.0006196756, -0.0006196756),
   (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0126581863, 0.0126581863),
(c_hh1_p > 19.85) => -0.0118363030,
(c_hh1_p = NULL) => 0.0112313889, -0.0018413207);

// Tree: 61 
woFDN_FL__SD_lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 43.3) => 0.1486588349,
   (r_C12_source_profile_d > 43.3) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 53) => -0.0365834397,
      (f_mos_inq_banko_cm_fseen_d > 53) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 72.3) => 0.1509553678,
         (c_fammar_p > 72.3) => -0.0068776365,
         (c_fammar_p = NULL) => 0.0720388656, 0.0720388656),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0215033546, 0.0215033546),
   (r_C12_source_profile_d = NULL) => 0.0512077086, 0.0512077086),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 41.55) => -0.0046712652,
   (c_hval_750k_p > 41.55) => 0.0467785208,
   (c_hval_750k_p = NULL) => -0.0094866057, -0.0015150833),
(r_D33_Eviction_Recency_d = NULL) => -0.0198307380, -0.0006308932);

// Tree: 62 
woFDN_FL__SD_lgt_62 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.0857149882,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0104481024,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0095905971, -0.0095905971),
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1765.5) => 0.0079394058,
      (c_med_rent > 1765.5) => 0.1326498987,
      (c_med_rent = NULL) => -0.0309705593, 0.0125032999),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0001594228, -0.0001594228),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 3.45) => 0.1754137278,
   (c_newhouse > 3.45) => 0.0307227543,
   (c_newhouse = NULL) => 0.0761489902, 0.0761489902),
(f_assoccredbureaucountnew_i = NULL) => 0.0244201942, 0.0015777063);

// Tree: 63 
woFDN_FL__SD_lgt_63 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 5.6) => -0.0691286707,
      (c_hval_300k_p > 5.6) => 0.0856223254,
      (c_hval_300k_p = NULL) => -0.0076011662, -0.0076011662),
   (k_inq_per_ssn_i > 0.5) => 0.1518134192,
   (k_inq_per_ssn_i = NULL) => 0.0503134959, 0.0503134959),
(f_M_Bureau_ADL_FS_noTU_d > 8.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 0.0648176460,
   (r_F00_dob_score_d > 65) => -0.0045886056,
   (r_F00_dob_score_d = NULL) => 0.0065018552, -0.0035761824),
(f_M_Bureau_ADL_FS_noTU_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.1) => -0.0681203036,
   (c_pop_55_64_p > 11.1) => 0.0355853423,
   (c_pop_55_64_p = NULL) => -0.0162674807, -0.0162674807), -0.0025449376);

// Tree: 64 
woFDN_FL__SD_lgt_64 := map(
(NULL < c_housingcpi and c_housingcpi <= 236.4) => -0.0064172493,
(c_housingcpi > 236.4) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 297.5) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0053528964,
      (f_hh_payday_loan_users_i > 0.5) => 0.1011584217,
      (f_hh_payday_loan_users_i = NULL) => 0.0119566707, 0.0119566707),
   (r_C13_max_lres_d > 297.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 59.65) => 0.2618084067,
      (c_civ_emp > 59.65) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 67) => 0.0270107168,
         (r_pb_order_freq_d > 67) => -0.0208432472,
         (r_pb_order_freq_d = NULL) => 0.0023586748, 0.0023586748),
      (c_civ_emp = NULL) => 0.0908531570, 0.0908531570),
   (r_C13_max_lres_d = NULL) => 0.0214507441, 0.0214507441),
(c_housingcpi = NULL) => -0.0333233614, -0.0022850400);

// Tree: 65 
woFDN_FL__SD_lgt_65 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 11.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 76.15) => 0.1381693025,
         (c_fammar_p > 76.15) => 0.0045061469,
         (c_fammar_p = NULL) => 0.0705606133, 0.0705606133),
      (r_D32_Mos_Since_Crim_LS_d > 11.5) => -0.0082325740,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0063091713, -0.0063091713),
   (r_C14_Addr_Stability_v2_d > 5.5) => 0.0149784627,
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0028170253, 0.0028170253),
(f_srchssnsrchcount_i > 21.5) => 0.0689610602,
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.1036044638,
   (k_comb_age_d > 25.5) => 0.0635123216,
   (k_comb_age_d = NULL) => -0.0168322868, -0.0168322868), 0.0031200045);

// Tree: 66 
woFDN_FL__SD_lgt_66 := map(
(NULL < c_easiqlife and c_easiqlife <= 134.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 7.5) => -0.0109692705,
   (f_hh_age_18_plus_d > 7.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 178.5) => -0.0381203179,
      (r_A50_pb_average_dollars_d > 178.5) => 0.1243752350,
      (r_A50_pb_average_dollars_d = NULL) => 0.0634394027, 0.0634394027),
   (f_hh_age_18_plus_d = NULL) => -0.0217522736, -0.0098068267),
(c_easiqlife > 134.5) => 
   map(
   (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => 0.0151977118,
   (f_validationrisktype_i > 1.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 300) => 0.0111616458,
      (r_C21_M_Bureau_ADL_FS_d > 300) => 0.1815996790,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0911016083, 0.0911016083),
   (f_validationrisktype_i = NULL) => 0.0171808656, 0.0171808656),
(c_easiqlife = NULL) => -0.0024641260, -0.0003614203);

// Tree: 67 
woFDN_FL__SD_lgt_67 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 3.5) => -0.0739774461,
   (f_M_Bureau_ADL_FS_noTU_d > 3.5) => -0.0242118774,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0256946504, -0.0256946504),
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 20.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 5.8) => -0.0143731192,
      (c_rnt1000_p > 5.8) => 0.1802571498,
      (c_rnt1000_p = NULL) => 0.1076339151, 0.1076339151),
   (k_comb_age_d > 20.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 0.0032477758,
      (r_D33_eviction_count_i > 3.5) => 0.0667759338,
      (r_D33_eviction_count_i = NULL) => 0.0037402422, 0.0037402422),
   (k_comb_age_d = NULL) => 0.0050868103, 0.0050868103),
(f_addrs_per_ssn_i = NULL) => -0.0002323038, -0.0002323038);

// Tree: 68 
woFDN_FL__SD_lgt_68 := map(
(NULL < c_hh2_p and c_hh2_p <= 18.05) => 0.0371375370,
(c_hh2_p > 18.05) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 21.85) => 0.0001804674,
      (c_pop_25_34_p > 21.85) => -0.0405136702,
      (c_pop_25_34_p = NULL) => -0.0052336478, -0.0052336478),
   (f_srchunvrfddobcount_i > 0.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 13.5) => 
         map(
         (NULL < c_no_move and c_no_move <= 13.5) => 0.1547812853,
         (c_no_move > 13.5) => -0.0251224821,
         (c_no_move = NULL) => 0.0071992117, 0.0071992117),
      (f_addrs_per_ssn_i > 13.5) => 0.1441269119,
      (f_addrs_per_ssn_i = NULL) => 0.0394800944, 0.0394800944),
   (f_srchunvrfddobcount_i = NULL) => -0.0261317346, -0.0039106347),
(c_hh2_p = NULL) => 0.0290285712, -0.0004166118);

// Tree: 69 
woFDN_FL__SD_lgt_69 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1010924519,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.85) => -0.0174913441,
   (c_hh4_p > 12.85) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 33.25) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => 
            map(
            (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 157.5) => -0.0155629194,
            (r_A50_pb_average_dollars_d > 157.5) => 0.0233185519,
            (r_A50_pb_average_dollars_d = NULL) => 0.0005728912, 0.0005728912),
         (k_inq_per_ssn_i > 10.5) => 0.0902686630,
         (k_inq_per_ssn_i = NULL) => 0.0017001271, 0.0017001271),
      (c_hh3_p > 33.25) => 0.1888953966,
      (c_hh3_p = NULL) => 0.0042144842, 0.0042144842),
   (c_hh4_p = NULL) => -0.0007283615, -0.0053702550),
(f_attr_arrest_recency_d = NULL) => -0.0173028068, -0.0050008377);

// Tree: 70 
woFDN_FL__SD_lgt_70 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0723901164,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0061471977,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0026324826, -0.0057333290),
(k_comb_age_d > 69.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 9.95) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 17.15) => 0.0479364627,
      (c_pop_45_54_p > 17.15) => 0.2728301965,
      (c_pop_45_54_p = NULL) => 0.1224325120, 0.1224325120),
   (C_INC_100K_P > 9.95) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => -0.0161831581,
      (r_C13_Curr_Addr_LRes_d > 310.5) => 0.1124503722,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0174465230, 0.0174465230),
   (C_INC_100K_P = NULL) => 0.0391771287, 0.0391771287),
(k_comb_age_d = NULL) => -0.0029470042, -0.0029470042);

// Tree: 71 
woFDN_FL__SD_lgt_71 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 1.65) => -0.0029733301,
(c_hh7p_p > 1.65) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 13.5) => 0.0125939437,
   (f_rel_ageover30_count_d > 13.5) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 5.5) => 
         map(
         (NULL < c_hval_100k_p and c_hval_100k_p <= 6.55) => 
            map(
            (NULL < c_med_hval and c_med_hval <= 220242) => 0.2705578499,
            (c_med_hval > 220242) => 0.0696862666,
            (c_med_hval = NULL) => 0.1544697271, 0.1544697271),
         (c_hval_100k_p > 6.55) => 0.0282746676,
         (c_hval_100k_p = NULL) => 0.1016106644, 0.1016106644),
      (f_rel_incomeover75_count_d > 5.5) => -0.0098070439,
      (f_rel_incomeover75_count_d = NULL) => 0.0448701648, 0.0448701648),
   (f_rel_ageover30_count_d = NULL) => 0.0936461772, 0.0201417230),
(c_hh7p_p = NULL) => -0.0183200632, 0.0024481367);

// Tree: 72 
woFDN_FL__SD_lgt_72 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 118.5) => -0.0166280431,
   (c_sub_bus > 118.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.45) => 0.0041277283,
      (r_C12_source_profile_d > 81.45) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 28.6) => -0.0310225822,
         (c_low_ed > 28.6) => 0.1699904638,
         (c_low_ed = NULL) => 0.0916403308, 0.0916403308),
      (r_C12_source_profile_d = NULL) => 0.0091472344, 0.0091472344),
   (c_sub_bus = NULL) => 0.0059464670, -0.0048110004),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0848588452,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 113.5) => -0.0837221628,
   (c_relig_indx > 113.5) => 0.0583884257,
   (c_relig_indx = NULL) => -0.0101291795, -0.0101291795), -0.0044849780);

// Tree: 73 
woFDN_FL__SD_lgt_73 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0921680882,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 186.5) => -0.0066909100,
      (c_unempl > 186.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['3: Derog','5: Vuln Vic/Friendly','6: Other']) => 0.0151667900,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity']) => 0.1849875069,
         (nf_seg_FraudPoint_3_0 = '') => 0.0891912050, 0.0891912050),
      (c_unempl = NULL) => 0.0236497220, -0.0044313338),
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 3.5) => -0.0031254228,
      (f_rel_under25miles_cnt_d > 3.5) => 0.0475368703,
      (f_rel_under25miles_cnt_d = NULL) => 0.0052090929, 0.0052090929),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0003628827, -0.0003628827),
(f_attr_arrest_recency_d = NULL) => -0.0037443533, 0.0000048972);

// Tree: 74 
woFDN_FL__SD_lgt_74 := map(
(NULL < C_INC_125K_P and C_INC_125K_P <= 0.35) => 
   map(
   (NULL < c_retired and c_retired <= 11.45) => 0.0032367549,
   (c_retired > 11.45) => 0.1724220043,
   (c_retired = NULL) => 0.0669877184, 0.0669877184),
(C_INC_125K_P > 0.35) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0146834802,
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 11.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 112.5) => -0.0302420460,
         (c_robbery > 112.5) => 0.1777745928,
         (c_robbery = NULL) => 0.0590827460, 0.0590827460),
      (r_C21_M_Bureau_ADL_FS_d > 11.5) => 0.0071355494,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0088971738, 0.0088971738),
   (k_inq_per_ssn_i = NULL) => -0.0050034878, -0.0050034878),
(C_INC_125K_P = NULL) => 0.0489122626, -0.0029196876);

// Tree: 75 
woFDN_FL__SD_lgt_75 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1450) => 
   map(
   (NULL < c_employees and c_employees <= 37.5) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 121) => -0.0000936128,
      (c_totcrime > 121) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
            map(
            (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 31.5) => 0.1078955319,
            (r_C13_Curr_Addr_LRes_d > 31.5) => 0.0073276053,
            (r_C13_Curr_Addr_LRes_d = NULL) => 0.0373324394, 0.0373324394),
         (f_util_adl_count_n > 3.5) => 0.1753550016,
         (f_util_adl_count_n = NULL) => 0.0586959316, 0.0586959316),
      (c_totcrime = NULL) => 0.0219285293, 0.0219285293),
   (c_employees > 37.5) => -0.0071546911,
   (c_employees = NULL) => -0.0105485855, -0.0036766760),
(f_liens_rel_SC_total_amt_i > 1450) => -0.1265782250,
(f_liens_rel_SC_total_amt_i = NULL) => -0.0254839085, -0.0043705288);

// Tree: 76 
woFDN_FL__SD_lgt_76 := map(
(NULL < c_hval_20k_p and c_hval_20k_p <= 40.4) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 33.5) => -0.0043311274,
      (f_rel_educationover12_count_d > 33.5) => -0.0893980146,
      (f_rel_educationover12_count_d = NULL) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 23.35) => 
            map(
            (NULL < c_finance and c_finance <= 3.55) => -0.0524018343,
            (c_finance > 3.55) => 0.0757560902,
            (c_finance = NULL) => 0.0048602171, 0.0048602171),
         (c_hh3_p > 23.35) => 0.1644700704,
         (c_hh3_p = NULL) => 0.0328619457, 0.0328619457), -0.0042759386),
   (r_S66_adlperssn_count_i > 3.5) => 0.0443228132,
   (r_S66_adlperssn_count_i = NULL) => -0.0018729850, -0.0018729850),
(c_hval_20k_p > 40.4) => 0.1357611058,
(c_hval_20k_p = NULL) => -0.0065076853, -0.0014393575);

// Tree: 77 
woFDN_FL__SD_lgt_77 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0144884217,
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 125) => 0.2098450275,
      (c_asian_lang > 125) => 0.0105459010,
      (c_asian_lang = NULL) => 0.0807216498, 0.0807216498),
   (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 
      map(
      (NULL < c_transport and c_transport <= 31.75) => 0.0088266777,
      (c_transport > 31.75) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 111.5) => -0.0012120480,
         (c_sub_bus > 111.5) => 0.2199075546,
         (c_sub_bus = NULL) => 0.1154899645, 0.1154899645),
      (c_transport = NULL) => 0.0380409677, 0.0109056784),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0123321115, 0.0123321115),
(f_util_add_curr_conv_n = NULL) => 0.0004135190, 0.0004135190);

// Tree: 78 
woFDN_FL__SD_lgt_78 := map(
(NULL < c_easiqlife and c_easiqlife <= 121.5) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 90.75) => -0.0135002411,
   (c_high_hval > 90.75) => 0.1514586888,
   (c_high_hval = NULL) => -0.0112681784, -0.0112681784),
(c_easiqlife > 121.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 0.1363606968,
      (r_C13_max_lres_d > 18.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 0.0146033489,
         (f_varrisktype_i > 4.5) => 0.0802124875,
         (f_varrisktype_i = NULL) => 0.0158089703, 0.0158089703),
      (r_C13_max_lres_d = NULL) => 0.0176156038, 0.0176156038),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0695357180,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0133564500, 0.0133564500),
(c_easiqlife = NULL) => -0.0105930962, -0.0006957500);

// Tree: 79 
woFDN_FL__SD_lgt_79 := map(
(NULL < c_unattach and c_unattach <= 85.5) => -0.0223096860,
(c_unattach > 85.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 0.0016084586,
   (k_inq_per_ssn_i > 3.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 17.55) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 12.5) => -0.0035500475,
         (f_rel_incomeover50_count_d > 12.5) => 0.1178993184,
         (f_rel_incomeover50_count_d = NULL) => 0.0125690903, 0.0125690903),
      (c_hh4_p > 17.55) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0527440696,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1690321808,
         (nf_seg_FraudPoint_3_0 = '') => 0.1008385354, 0.1008385354),
      (c_hh4_p = NULL) => 0.0357451845, 0.0357451845),
   (k_inq_per_ssn_i = NULL) => 0.0042671761, 0.0042671761),
(c_unattach = NULL) => 0.0129992939, -0.0048518715);

// Tree: 80 
woFDN_FL__SD_lgt_80 := map(
(NULL < c_med_rent and c_med_rent <= 1523.5) => -0.0027936005,
(c_med_rent > 1523.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 18.65) => 
      map(
      (NULL < c_retail and c_retail <= 29.4) => -0.0039676158,
      (c_retail > 29.4) => 0.2432407833,
      (c_retail = NULL) => 0.0142193782, 0.0142193782),
   (c_pop_45_54_p > 18.65) => 
      map(
      (NULL < c_robbery and c_robbery <= 127.5) => 0.0910247490,
      (c_robbery > 127.5) => 0.2807521341,
      (c_robbery = NULL) => 0.1278582707, 0.1278582707),
   (c_pop_45_54_p = NULL) => 0.0450271415, 0.0450271415),
(c_med_rent = NULL) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => -0.0073544325,
   (f_srchfraudsrchcountyr_i > 0.5) => 0.1323950030,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0146001616, 0.0146001616), 0.0014578946);

// Tree: 81 
woFDN_FL__SD_lgt_81 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 52.3) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0123547453,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 58.5) => 0.1238992271,
      (f_mos_liens_unrel_SC_fseen_d > 58.5) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 787022.5) => 0.0088008123,
         (f_curraddrmedianvalue_d > 787022.5) => 0.2444760600,
         (f_curraddrmedianvalue_d = NULL) => 0.0131842687, 0.0131842687),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0152059167, 0.0152059167),
   (f_inq_Other_count_i = NULL) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 9.85) => -0.0749679993,
      (C_INC_125K_P > 9.85) => 0.0410132433,
      (C_INC_125K_P = NULL) => -0.0169773780, -0.0169773780), -0.0061383302),
(c_hval_500k_p > 52.3) => 0.1308478332,
(c_hval_500k_p = NULL) => 0.0402177163, -0.0041996834);

// Tree: 82 
woFDN_FL__SD_lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 11.45) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 82.35) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 30002.5) => 0.0746835590,
         (r_A46_Curr_AVM_AutoVal_d > 30002.5) => -0.0036601766,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0017542298, -0.0018322651),
      (c_low_ed > 82.35) => -0.0868334182,
      (c_low_ed = NULL) => -0.0028446109, -0.0028446109),
   (c_hh6_p > 11.45) => 0.0604625661,
   (c_hh6_p = NULL) => -0.0115394678, -0.0014668141),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => -0.1229981497,
   (f_mos_inq_banko_cm_lseen_d > 27.5) => -0.0162456874,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0646178969, -0.0646178969),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0240799600, -0.0019026565);

// Tree: 83 
woFDN_FL__SD_lgt_83 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 63.35) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 0.0021138858,
      (f_rel_felony_count_i > 4.5) => 0.0846537019,
      (f_rel_felony_count_i = NULL) => 0.0025124629, 0.0025124629),
   (c_low_hval > 63.35) => -0.0647330778,
   (c_low_hval = NULL) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => -0.0506031154,
      (r_I60_Inq_Count12_i > 0.5) => 0.1211525774,
      (r_I60_Inq_Count12_i = NULL) => -0.0134076151, -0.0134076151), 0.0013826834),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.68) => -0.0138537517,
   (c_hhsize > 2.68) => 0.1465077394,
   (c_hhsize = NULL) => 0.0611777717, 0.0611777717),
(f_inq_Communications_count_i = NULL) => -0.0056376045, 0.0018375613);

// Tree: 84 
woFDN_FL__SD_lgt_84 := map(
(NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 23.45) => -0.0000525217,
   (c_pop_25_34_p > 23.45) => -0.0490372809,
   (c_pop_25_34_p = NULL) => -0.0205375303, -0.0069712853),
(r_C14_Addr_Stability_v2_d > 5.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 197.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 87.15) => -0.0529962333,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 87.15) => 0.0232798330,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0074164844, 0.0112971656),
   (c_sub_bus > 197.5) => 0.1922690588,
   (c_sub_bus = NULL) => 0.0151808154, 0.0132715650),
(r_C14_Addr_Stability_v2_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0449504214,
   (k_comb_age_d > 25.5) => 0.1087450104,
   (k_comb_age_d = NULL) => 0.0293357040, 0.0293357040), 0.0018219927);

// Tree: 85 
woFDN_FL__SD_lgt_85 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 41.55) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 198.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 16.5) => 
         map(
         (NULL < f_validationrisktype_i and f_validationrisktype_i <= 3.5) => 
            map(
            (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.0155508518,
            (f_hh_age_18_plus_d > 1.5) => -0.0108356011,
            (f_hh_age_18_plus_d = NULL) => -0.0048674475, -0.0048674475),
         (f_validationrisktype_i > 3.5) => 0.0829695712,
         (f_validationrisktype_i = NULL) => -0.0043693723, -0.0043693723),
      (f_inq_count24_i > 16.5) => -0.0916612110,
      (f_inq_count24_i = NULL) => -0.0021503277, -0.0049039334),
   (c_serv_empl > 198.5) => 0.1169341385,
   (c_serv_empl = NULL) => -0.0041673909, -0.0041673909),
(c_hval_80k_p > 41.55) => -0.0905115664,
(c_hval_80k_p = NULL) => 0.0110989148, -0.0045862642);

// Tree: 86 
woFDN_FL__SD_lgt_86 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 35.5) => 0.1630418842,
   (c_many_cars > 35.5) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => -0.0914492095,
      (f_rel_incomeover75_count_d > 0.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 21.75) => 0.0073380418,
         (C_INC_75K_P > 21.75) => 0.1940127315,
         (C_INC_75K_P = NULL) => 0.0546289632, 0.0546289632),
      (f_rel_incomeover75_count_d = NULL) => 0.0242817372, 0.0242817372),
   (c_many_cars = NULL) => 0.0449922069, 0.0449922069),
(r_I61_inq_collection_recency_d > 4.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 14.5) => -0.0012413204,
   (f_rel_homeover300_count_d > 14.5) => -0.0549306962,
   (f_rel_homeover300_count_d = NULL) => 0.0241545020, -0.0024216276),
(r_I61_inq_collection_recency_d = NULL) => -0.0106424572, -0.0012024297);

// Tree: 87 
woFDN_FL__SD_lgt_87 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 24.55) => -0.0103520118,
   (c_famotf18_p > 24.55) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 31.95) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 75.55) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 127.5) => -0.0215169592,
            (c_span_lang > 127.5) => 0.0547049389,
            (c_span_lang = NULL) => 0.0116997416, 0.0116997416),
         (c_low_ed > 75.55) => -0.0739650887,
         (c_low_ed = NULL) => 0.0018092026, 0.0018092026),
      (c_rnt1000_p > 31.95) => 0.0923434299,
      (c_rnt1000_p = NULL) => 0.0242525614, 0.0242525614),
   (c_famotf18_p = NULL) => -0.0019492841, -0.0062508238),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0843578588,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0058936748, -0.0058936748);

// Tree: 88 
woFDN_FL__SD_lgt_88 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 46.5) => -0.0710772263,
(f_mos_inq_banko_am_lseen_d > 46.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0022439205,
   (k_inq_per_ssn_i > 1.5) => 
      map(
      (NULL < k_inq_lnames_per_ssn_i and k_inq_lnames_per_ssn_i <= 0.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 2.55) => 0.2498206059,
         (C_INC_150K_P > 2.55) => 0.0626864087,
         (C_INC_150K_P = NULL) => 0.0965675475, 0.0965675475),
      (k_inq_lnames_per_ssn_i > 0.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 2.35) => -0.0153010611,
         (c_hval_150k_p > 2.35) => 0.0347431455,
         (c_hval_150k_p = NULL) => 0.0104852641, 0.0104852641),
      (k_inq_lnames_per_ssn_i = NULL) => 0.0269611550, 0.0269611550),
   (k_inq_per_ssn_i = NULL) => 0.0037855451, 0.0037855451),
(f_mos_inq_banko_am_lseen_d = NULL) => -0.0288296717, 0.0016363885);

// Tree: 89 
woFDN_FL__SD_lgt_89 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => 0.0011173900,
(f_srchfraudsrchcount_i > 4.5) => 
   map(
   (NULL < c_highinc and c_highinc <= 1.35) => -0.1359239587,
   (c_highinc > 1.35) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 32.35) => 0.0623861531,
      (C_OWNOCC_P > 32.35) => 
         map(
         (NULL < c_work_home and c_work_home <= 107.5) => 
            map(
            (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.0627668539,
            (k_estimated_income_d > 28500) => -0.0258679903,
            (k_estimated_income_d = NULL) => -0.0041562849, -0.0041562849),
         (c_work_home > 107.5) => -0.0671176662,
         (c_work_home = NULL) => -0.0376337265, -0.0376337265),
      (C_OWNOCC_P = NULL) => -0.0235938130, -0.0235938130),
   (c_highinc = NULL) => -0.0304461966, -0.0304461966),
(f_srchfraudsrchcount_i = NULL) => 0.0220147679, -0.0010261342);

// Tree: 90 
woFDN_FL__SD_lgt_90 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 50.35) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 42.05) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0041132946,
         (k_comb_age_d > 68.5) => 
            map(
            (NULL < c_born_usa and c_born_usa <= 16.5) => 0.1681086880,
            (c_born_usa > 16.5) => 0.0245725067,
            (c_born_usa = NULL) => 0.0340496855, 0.0340496855),
         (k_comb_age_d = NULL) => -0.0014886445, -0.0014886445),
      (c_hval_60k_p > 42.05) => -0.1007825324,
      (c_hval_60k_p = NULL) => -0.0020186685, -0.0020186685),
   (c_hval_100k_p > 50.35) => 0.1402083397,
   (c_hval_100k_p = NULL) => -0.0012289826, -0.0013190756),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0926286792,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0148583663, -0.0018049088);

// Tree: 91 
woFDN_FL__SD_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_health and c_health <= 5.15) => 0.1222812251,
   (c_health > 5.15) => 0.0193350439,
   (c_health = NULL) => 0.0602248822, 0.0602248822),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0096570350,
      (k_comb_age_d > 68.5) => 0.0317737389,
      (k_comb_age_d = NULL) => -0.0067721656, -0.0067721656),
   (r_D33_eviction_count_i > 3.5) => 0.0568880816,
   (r_D33_eviction_count_i = NULL) => -0.0063294013, -0.0063294013),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 12.25) => -0.0447687814,
   (c_rnt1000_p > 12.25) => 0.0631440504,
   (c_rnt1000_p = NULL) => 0.0097218565, 0.0097218565), -0.0050605357);

// Tree: 92 
woFDN_FL__SD_lgt_92 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 21.55) => -0.0048577200,
   (c_hh3_p > 21.55) => 
      map(
      (NULL < f_inq_Auto_count_i and f_inq_Auto_count_i <= 1.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 8.15) => 
            map(
            (NULL < c_asian_lang and c_asian_lang <= 192.5) => 0.0330199152,
            (c_asian_lang > 192.5) => -0.0728209672,
            (c_asian_lang = NULL) => 0.0247319899, 0.0247319899),
         (c_hh7p_p > 8.15) => 0.1308992114,
         (c_hh7p_p = NULL) => 0.0285846561, 0.0285846561),
      (f_inq_Auto_count_i > 1.5) => -0.0605141427,
      (f_inq_Auto_count_i = NULL) => 0.0212356065, 0.0212356065),
   (c_hh3_p = NULL) => -0.0162478440, 0.0003694507),
(f_assocsuspicousidcount_i > 15.5) => 0.0771963656,
(f_assocsuspicousidcount_i = NULL) => -0.0161071978, 0.0006821237);

// Tree: 93 
woFDN_FL__SD_lgt_93 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => 
      map(
      (NULL < c_employees and c_employees <= 20.5) => 
         map(
         (NULL < c_totsales and c_totsales <= 558.5) => 0.0236559081,
         (c_totsales > 558.5) => 0.2232894775,
         (c_totsales = NULL) => 0.0423408235, 0.0423408235),
      (c_employees > 20.5) => -0.0117484648,
      (c_employees = NULL) => -0.0083089916, -0.0079748371),
   (f_hh_collections_ct_i > 1.5) => 0.0191892784,
   (f_hh_collections_ct_i = NULL) => -0.0002843306, -0.0002843306),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < c_employees and c_employees <= 146.5) => -0.0301148449,
   (c_employees > 146.5) => 0.1222917250,
   (c_employees = NULL) => 0.0525863946, 0.0525863946),
(r_D33_eviction_count_i = NULL) => 0.0071689117, 0.0003103865);

// Tree: 94 
woFDN_FL__SD_lgt_94 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 28.5) => -0.1051603530,
(f_mos_liens_unrel_OT_fseen_d > 28.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 25.05) => 0.0134872315,
      (c_hval_250k_p > 25.05) => 
         map(
         (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 0.0441321306,
         (f_vardobcountnew_i > 0.5) => 0.2384228906,
         (f_vardobcountnew_i = NULL) => 0.0976700289, 0.0976700289),
      (c_hval_250k_p = NULL) => 0.0477414025, 0.0242812620),
   (f_mos_inq_banko_cm_lseen_d > 44.5) => -0.0014860602,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0026699595, 0.0026699595),
(f_mos_liens_unrel_OT_fseen_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0621801345,
   (c_rnt1000_p > 10.8) => 0.0605333092,
   (c_rnt1000_p = NULL) => -0.0048374038, -0.0048374038), 0.0019078077);

// Tree: 95 
woFDN_FL__SD_lgt_95 := map(
(NULL < c_incollege and c_incollege <= 5.95) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 5.5) => -0.0139796464,
   (f_srchfraudsrchcountyr_i > 5.5) => -0.1013274192,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0148702617, -0.0148702617),
(c_incollege > 5.95) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 10.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
         map(
         (NULL < c_hval_500k_p and c_hval_500k_p <= 19.55) => -0.0185793075,
         (c_hval_500k_p > 19.55) => 0.0448665198,
         (c_hval_500k_p = NULL) => -0.0070679144, -0.0070679144),
      (f_rel_criminal_count_i > 2.5) => 0.0360557225,
      (f_rel_criminal_count_i = NULL) => 0.0034659878, 0.0034659878),
   (f_srchfraudsrchcount_i > 10.5) => 0.0713590279,
   (f_srchfraudsrchcount_i = NULL) => 0.0049752420, 0.0049752420),
(c_incollege = NULL) => 0.0111834934, -0.0050638031);

// Tree: 96 
woFDN_FL__SD_lgt_96 := map(
(NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00478183075) => -0.0376984140,
   (f_add_curr_nhood_BUS_pct_i > 0.00478183075) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
         map(
         (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => -0.0024417173,
         (f_inq_Communications_count24_i > 2.5) => 0.0939484545,
         (f_inq_Communications_count24_i = NULL) => -0.0016878593, -0.0016878593),
      (f_srchcomponentrisktype_i > 3.5) => 
         map(
         (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 18.5) => 0.0202520445,
         (f_rel_ageover20_count_d > 18.5) => 0.1401467416,
         (f_rel_ageover20_count_d = NULL) => 0.0407468645, 0.0407468645),
      (f_srchcomponentrisktype_i = NULL) => -0.0002529267, -0.0002529267),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0324441862, -0.0057383817),
(f_assoccredbureaucountmo_i > 0.5) => 0.1086721437,
(f_assoccredbureaucountmo_i = NULL) => 0.0110643405, -0.0049965780);

// Tree: 97 
woFDN_FL__SD_lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0043730832,
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 6.5) => -0.0353241244,
      (f_rel_incomeover25_count_d > 6.5) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 42859) => 0.1914373371,
         (f_prevaddrmedianincome_d > 42859) => 0.0290406341,
         (f_prevaddrmedianincome_d = NULL) => 0.0942129952, 0.0942129952),
      (f_rel_incomeover25_count_d = NULL) => 0.0502830155, 0.0502830155),
   (f_assoccredbureaucountnew_i = NULL) => -0.0033641825, -0.0033641825),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1379658727,
   (r_A50_pb_average_dollars_d > 99) => -0.0170973201,
   (r_A50_pb_average_dollars_d = NULL) => 0.0524979712, 0.0524979712),
(r_D33_eviction_count_i = NULL) => 0.0092920962, -0.0027071223);

// Tree: 98 
woFDN_FL__SD_lgt_98 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 11.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => -0.0091496249,
   (C_INC_50K_P > 19.85) => 0.0288250650,
   (C_INC_50K_P = NULL) => -0.0088639439, -0.0053200501),
(f_rel_homeover500_count_d > 11.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.23119878345) => 0.1745267028,
   (f_add_curr_mobility_index_i > 0.23119878345) => -0.0152707115,
   (f_add_curr_mobility_index_i = NULL) => 0.0538697751, 0.0538697751),
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.3) => 
      map(
      (NULL < c_business and c_business <= 22.5) => 0.0268946937,
      (c_business > 22.5) => 0.1877160078,
      (c_business = NULL) => 0.1080169495, 0.1080169495),
   (c_bigapt_p > 1.3) => -0.0184148620,
   (c_bigapt_p = NULL) => 0.0324278238, 0.0324278238), -0.0038157169);

// Tree: 99 
woFDN_FL__SD_lgt_99 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 39.7) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 0.0011414515,
   (f_idrisktype_i > 1.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 8.5) => 0.0039559994,
         (f_addrs_per_ssn_i > 8.5) => 0.0908073860,
         (f_addrs_per_ssn_i = NULL) => 0.0180075652, 0.0180075652),
      (f_rel_felony_count_i > 0.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 14.05) => 0.0288682430,
         (c_hh4_p > 14.05) => 0.2144687530,
         (c_hh4_p = NULL) => 0.1173320375, 0.1173320375),
      (f_rel_felony_count_i = NULL) => 0.0259564945, 0.0259564945),
   (f_idrisktype_i = NULL) => 0.0067437176, 0.0038973540),
(c_hval_80k_p > 39.7) => -0.0731740608,
(c_hval_80k_p = NULL) => -0.0042370466, 0.0028444414);

// Tree: 100 
woFDN_FL__SD_lgt_100 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 32.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.55) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => -0.0324319342,
      (r_C14_Addr_Stability_v2_d > 3.5) => 
         map(
         (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => -0.0165245063,
         (f_validationrisktype_i > 1.5) => 0.0967347030,
         (f_validationrisktype_i = NULL) => -0.0134839906, -0.0134839906),
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0186630672, -0.0186630672),
   (c_hh4_p > 11.55) => 0.0103515351,
   (c_hh4_p = NULL) => -0.0096021912, -0.0008903308),
(f_rel_count_i > 32.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 39.5) => -0.0871111604,
   (f_mos_inq_banko_cm_lseen_d > 39.5) => -0.0164419493,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0443250394, -0.0443250394),
(f_rel_count_i = NULL) => 0.0272575052, -0.0021873363);

// Tree: 101 
woFDN_FL__SD_lgt_101 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 38.3) => 
   map(
   (NULL < f_inq_Auto_count_i and f_inq_Auto_count_i <= 0.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 0.0014557416,
      (f_nae_nothing_found_i > 0.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0442469520,
         (f_addrs_per_ssn_i > 4.5) => 0.2059036069,
         (f_addrs_per_ssn_i = NULL) => 0.0817029798, 0.0817029798),
      (f_nae_nothing_found_i = NULL) => 0.0025231172, 0.0025231172),
   (f_inq_Auto_count_i > 0.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 29.15) => -0.0963147229,
      (c_med_age > 29.15) => -0.0202632576,
      (c_med_age = NULL) => -0.0280299939, -0.0280299939),
   (f_inq_Auto_count_i = NULL) => 0.0034875531, -0.0010906216),
(c_hval_60k_p > 38.3) => -0.0908645475,
(c_hval_60k_p = NULL) => 0.0210466950, -0.0011137619);

// Tree: 102 
woFDN_FL__SD_lgt_102 := map(
(NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0145095413,
   (c_hh4_p > 11.55) => 
      map(
      (NULL < k_inq_lnames_per_ssn_i and k_inq_lnames_per_ssn_i <= 1.5) => 0.0072686442,
      (k_inq_lnames_per_ssn_i > 1.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 107.5) => 0.0114061719,
         (f_prevaddrlenofres_d > 107.5) => 0.2397841919,
         (f_prevaddrlenofres_d = NULL) => 0.0836776972, 0.0836776972),
      (k_inq_lnames_per_ssn_i = NULL) => 0.0088869592, 0.0088869592),
   (c_hh4_p = NULL) => 0.0003031081, -0.0001376102),
(f_addrs_per_ssn_c6_i > 1.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 98.5) => 0.0052198245,
   (f_prevaddrcartheftindex_i > 98.5) => 0.1877274358,
   (f_prevaddrcartheftindex_i = NULL) => 0.0754150596, 0.0754150596),
(f_addrs_per_ssn_c6_i = NULL) => 0.0009523495, 0.0009523495);

// Tree: 103 
woFDN_FL__SD_lgt_103 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 11.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 7.75) => 0.1003668536,
   (c_hh2_p > 7.75) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 111.5) => 0.0879420159,
         (c_exp_prod > 111.5) => -0.0167648570,
         (c_exp_prod = NULL) => 0.0357394539, 0.0357394539),
      (r_F00_dob_score_d > 92) => -0.0010008307,
      (r_F00_dob_score_d = NULL) => -0.0343892693, -0.0009004691),
   (c_hh2_p = NULL) => -0.0041955865, -0.0003719322),
(f_rel_ageover40_count_d > 11.5) => -0.0555305476,
(f_rel_ageover40_count_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 168.5) => -0.0287473400,
   (c_new_homes > 168.5) => 0.0999196982,
   (c_new_homes = NULL) => -0.0013198836, -0.0013198836), -0.0021187575);

// Tree: 104 
woFDN_FL__SD_lgt_104 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 6.5) => 0.1037866387,
(r_C13_max_lres_d > 6.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 198.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0066963792,
      (r_C14_Addr_Stability_v2_d > 5.5) => 
         map(
         (NULL < c_totcrime and c_totcrime <= 193.5) => 0.0079082881,
         (c_totcrime > 193.5) => 0.1430625222,
         (c_totcrime = NULL) => 0.0096223887, 0.0096223887),
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0003133499, 0.0003133499),
   (c_serv_empl > 198.5) => 0.1151346765,
   (c_serv_empl = NULL) => -0.0059410951, 0.0008587863),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 25.65) => 0.0424502082,
   (c_lowinc > 25.65) => -0.0835706326,
   (c_lowinc = NULL) => -0.0205602122, -0.0205602122), 0.0014638251);

// Tree: 105 
woFDN_FL__SD_lgt_105 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
   map(
   (NULL < c_larceny and c_larceny <= 54.5) => -0.0209296487,
   (c_larceny > 54.5) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.785) => 0.0307115264,
         (c_hhsize > 2.785) => 
            map(
            (NULL < c_blue_col and c_blue_col <= 17.3) => 0.1495137040,
            (c_blue_col > 17.3) => -0.0091517349,
            (c_blue_col = NULL) => 0.1047737401, 0.1047737401),
         (c_hhsize = NULL) => 0.0514924411, 0.0514924411),
      (f_historical_count_d > 0.5) => 0.0014571286,
      (f_historical_count_d = NULL) => 0.0251326566, 0.0251326566),
   (c_larceny = NULL) => -0.0096641116, 0.0120915931),
(k_estimated_income_d > 32500) => -0.0085430933,
(k_estimated_income_d = NULL) => -0.0285723467, -0.0026953104);

// Tree: 106 
woFDN_FL__SD_lgt_106 := map(
(NULL < c_low_ed and c_low_ed <= 75.55) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 73.35) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 36.5) => 0.1073633461,
      (f_mos_liens_unrel_SC_fseen_d > 36.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0098425623,
         (k_comb_age_d > 56.5) => 0.0239379660,
         (k_comb_age_d = NULL) => -0.0023105942, -0.0023105942),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0051996480, -0.0015054418),
   (c_low_ed > 73.35) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 136585) => 0.0213519820,
      (f_curraddrmedianvalue_d > 136585) => 0.1871682990,
      (f_curraddrmedianvalue_d = NULL) => 0.0858979309, 0.0858979309),
   (c_low_ed = NULL) => -0.0004085119, -0.0004085119),
(c_low_ed > 75.55) => -0.0490109500,
(c_low_ed = NULL) => -0.0293067684, -0.0027401164);

// Tree: 107 
woFDN_FL__SD_lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0756350195,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < c_trailer and c_trailer <= 192.5) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 3.75) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 19.9) => 0.0248267239,
         (c_vacant_p > 19.9) => 0.1251377917,
         (c_vacant_p = NULL) => 0.0410059283, 0.0410059283),
      (C_INC_100K_P > 3.75) => -0.0054652286,
      (C_INC_100K_P = NULL) => -0.0042592970, -0.0042592970),
   (c_trailer > 192.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 53.6) => 0.0317312872,
      (c_rnt500_p > 53.6) => 0.2629784605,
      (c_rnt500_p = NULL) => 0.0759403056, 0.0759403056),
   (c_trailer = NULL) => 0.0229366303, -0.0018807596),
(f_attr_arrest_recency_d = NULL) => 0.0004031320, -0.0013095509);

// Tree: 108 
woFDN_FL__SD_lgt_108 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0081291095) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1319420526) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 28.2) => 
         map(
         (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0117140069,
         (f_vardobcountnew_i > 0.5) => 0.1100139943,
         (f_vardobcountnew_i = NULL) => 0.0087684470, 0.0087684470),
      (C_INC_75K_P > 28.2) => 0.2434313077,
      (C_INC_75K_P = NULL) => 0.0208571398, 0.0208571398),
   (f_add_curr_nhood_BUS_pct_i > 0.1319420526) => 0.2043970824,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0314895581, 0.0314895581),
(f_add_curr_nhood_MFD_pct_i > 0.0081291095) => 0.0052619991,
(f_add_curr_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0264926732,
   (f_util_adl_count_n > 6.5) => 0.0972961201,
   (f_util_adl_count_n = NULL) => -0.0063440703, -0.0185058318), 0.0027070086);

// Tree: 109 
woFDN_FL__SD_lgt_109 := map(
(NULL < c_young and c_young <= 53.35) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 29.15) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 249362) => 
         map(
         (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 42749.5) => 0.2097411370,
            (f_prevaddrmedianincome_d > 42749.5) => 0.0542467715,
            (f_prevaddrmedianincome_d = NULL) => 0.1441712238, 0.1441712238),
         (r_A44_curr_add_naprop_d > 2.5) => 0.0534495487,
         (r_A44_curr_add_naprop_d = NULL) => 0.0904515096, 0.0904515096),
      (r_A46_Curr_AVM_AutoVal_d > 249362) => -0.0259501496,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0189891361, 0.0307433362),
   (r_C12_source_profile_d > 29.15) => 0.0036802169,
   (r_C12_source_profile_d = NULL) => 0.0145204774, 0.0068523316),
(c_young > 53.35) => -0.0767067907,
(c_young = NULL) => -0.0242809758, 0.0044043772);

// Tree: 110 
woFDN_FL__SD_lgt_110 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 376.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 387.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 28.75) => 0.1292836891,
      (c_civ_emp > 28.75) => 0.0010465227,
      (c_civ_emp = NULL) => -0.0047990363, 0.0015474140),
   (r_C10_M_Hdr_FS_d > 387.5) => -0.0475065979,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0022773016, -0.0022773016),
(r_C13_max_lres_d > 376.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 9.15) => 0.1985123387,
   (c_pop_35_44_p > 9.15) => 0.0201071760,
   (c_pop_35_44_p = NULL) => 0.0488711562, 0.0488711562),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 4.05) => 0.0169815525,
   (c_femdiv_p > 4.05) => -0.0892653470,
   (c_femdiv_p = NULL) => -0.0356261356, -0.0356261356), -0.0004404735);

// Tree: 111 
woFDN_FL__SD_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2083004656,
   (r_C12_source_profile_d > 57.95) => -0.0309734521,
   (r_C12_source_profile_d = NULL) => 0.0803167422, 0.0803167422),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 4.4) => 0.0013402914,
      (c_hhsize > 4.4) => 0.0860303726,
      (c_hhsize = NULL) => -0.0114243465, 0.0016381267),
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 2.25) => 0.1327151791,
      (c_hh6_p > 2.25) => -0.0210862298,
      (c_hh6_p = NULL) => 0.0683331940, 0.0683331940),
   (f_hh_lienholders_i = NULL) => 0.0023335915, 0.0023335915),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0073051555, 0.0030590135);

// Tree: 112 
woFDN_FL__SD_lgt_112 := map(
(NULL < c_easiqlife and c_easiqlife <= 95.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 4.5) => 0.1368506140,
   (c_no_teens > 4.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 21.9) => -0.0798922943,
      (c_fammar_p > 21.9) => -0.0178976490,
      (c_fammar_p = NULL) => -0.0190266432, -0.0190266432),
   (c_no_teens = NULL) => -0.0163427575, -0.0163427575),
(c_easiqlife > 95.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
      map(
      (NULL < c_mining and c_mining <= 2.35) => 0.0111259697,
      (c_mining > 2.35) => -0.0796838044,
      (c_mining = NULL) => 0.0083983247, 0.0083983247),
   (f_srchssnsrchcount_i > 22.5) => 0.0764941569,
   (f_srchssnsrchcount_i = NULL) => 0.0187812502, 0.0089415025),
(c_easiqlife = NULL) => 0.0164982476, 0.0003202671);

// Tree: 113 
woFDN_FL__SD_lgt_113 := map(
(NULL < f_mos_liens_rel_OT_lseen_d and f_mos_liens_rel_OT_lseen_d <= 238) => -0.0621870904,
(f_mos_liens_rel_OT_lseen_d > 238) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 11.5) => 
      map(
      (NULL < c_larceny and c_larceny <= 14) => -0.0465375884,
      (c_larceny > 14) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 0.0474207350,
         (f_corrssnnamecount_d > 1.5) => -0.0024435285,
         (f_corrssnnamecount_d = NULL) => 0.0002233120, 0.0002233120),
      (c_larceny = NULL) => 0.0317863226, -0.0033820975),
   (f_rel_incomeover100_count_d > 11.5) => 0.1137537477,
   (f_rel_incomeover100_count_d = NULL) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 0.1023630410,
      (r_C14_Addr_Stability_v2_d > 1.5) => -0.0153115008,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0202645235, 0.0202645235), -0.0021865174),
(f_mos_liens_rel_OT_lseen_d = NULL) => 0.0370605471, -0.0032515696);

// Tree: 114 
woFDN_FL__SD_lgt_114 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0873141355,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => -0.0118257969,
      (f_srchfraudsrchcount_i > 6.5) => -0.0392463050,
      (f_srchfraudsrchcount_i = NULL) => -0.0132256531, -0.0132256531),
   (f_prevaddrageoldest_d > 134.5) => 
      map(
      (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0065305197,
      (f_srchunvrfddobcount_i > 0.5) => 0.1188580550,
      (f_srchunvrfddobcount_i = NULL) => 0.0087376025, 0.0087376025),
   (f_prevaddrageoldest_d = NULL) => -0.0163982903, -0.0055331339),
(C_INC_100K_P = NULL) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0245618565,
   (f_vardobcountnew_i > 0.5) => 0.1620273411,
   (f_vardobcountnew_i = NULL) => 0.0070428285, 0.0070428285), -0.0047656644);

// Tree: 115 
woFDN_FL__SD_lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.2) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0631030773,
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 1.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 2.75) => 0.0036464021,
         (c_hh6_p > 2.75) => -0.0197278322,
         (c_hh6_p = NULL) => -0.0036219042, -0.0036219042),
      (f_vardobcountnew_i > 1.5) => 0.1026646315,
      (f_vardobcountnew_i = NULL) => -0.0029008406, -0.0029008406),
   (r_D33_Eviction_Recency_d = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0805901230,
      (f_addrs_per_ssn_i > 3.5) => 0.0432248644,
      (f_addrs_per_ssn_i = NULL) => -0.0261542234, -0.0261542234), -0.0025942808),
(c_pop_0_5_p > 21.2) => 0.1295100232,
(c_pop_0_5_p = NULL) => 0.0071236575, -0.0018176938);

// Tree: 116 
woFDN_FL__SD_lgt_116 := map(
(NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 71.5) => -0.1289530750,
(f_mos_liens_rel_SC_lseen_d > 71.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.2010080418) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 5.65) => -0.0488668752,
         (c_hval_300k_p > 5.65) => 
            map(
            (NULL < c_finance and c_finance <= 3.15) => -0.0385262360,
            (c_finance > 3.15) => 0.0906445972,
            (c_finance = NULL) => 0.0256529830, 0.0256529830),
         (c_hval_300k_p = NULL) => -0.0180109964, -0.0180109964),
      (f_add_curr_nhood_BUS_pct_i > 0.2010080418) => 0.1067146004,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0088774293, -0.0088774293),
   (r_C14_Addr_Stability_v2_d > 1.5) => -0.0004218175,
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0010081309, -0.0010081309),
(f_mos_liens_rel_SC_lseen_d = NULL) => 0.0014995194, -0.0014922828);

// Tree: 117 
woFDN_FL__SD_lgt_117 := map(
(NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => -0.0817901250,
   (r_D33_Eviction_Recency_d > 30) => -0.0044713801,
   (r_D33_Eviction_Recency_d = NULL) => -0.0050114138, -0.0050114138),
(r_F04_curr_add_occ_index_d > 2) => 
   map(
   (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 13.15) => 0.0258192353,
      (c_blue_col > 13.15) => 0.1747658467,
      (c_blue_col = NULL) => 0.0814568800, 0.0814568800),
   (r_I60_inq_banking_recency_d > 9) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 21.65) => 0.0104893387,
      (C_INC_25K_P > 21.65) => 0.1138976080,
      (C_INC_25K_P = NULL) => 0.0326774901, 0.0144434308),
   (r_I60_inq_banking_recency_d = NULL) => 0.0209988255, 0.0209988255),
(r_F04_curr_add_occ_index_d = NULL) => -0.0113760137, 0.0004946463);

// Tree: 118 
woFDN_FL__SD_lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
   map(
   (NULL < c_young and c_young <= 32.85) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 1.5) => 0.0485366998,
      (f_rel_ageover30_count_d > 1.5) => -0.0041430832,
      (f_rel_ageover30_count_d = NULL) => -0.0037648698, -0.0010595193),
   (c_young > 32.85) => -0.0331174579,
   (c_young = NULL) => -0.0151422347, -0.0056778560),
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_retail and c_retail <= 16.35) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 0.55) => -0.0284923344,
      (c_hval_20k_p > 0.55) => 0.0941289581,
      (c_hval_20k_p = NULL) => 0.0059772455, 0.0059772455),
   (c_retail > 16.35) => 0.1182605351,
   (c_retail = NULL) => 0.0396622324, 0.0396622324),
(f_srchunvrfdaddrcount_i = NULL) => -0.0221962915, -0.0046623581);

// Tree: 119 
woFDN_FL__SD_lgt_119 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => -0.0340105807,
   (f_mos_inq_banko_om_fseen_d > 21.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.131894159) => 0.0042747558,
         (f_add_curr_nhood_BUS_pct_i > 0.131894159) => 0.0422331226,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0152339040, 0.0092113623),
      (f_rel_homeover500_count_d > 14.5) => 0.1370527101,
      (f_rel_homeover500_count_d = NULL) => 0.0416672362, 0.0101777536),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0070872496, 0.0070872496),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0507625992,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.75) => -0.0806375729,
   (c_pop_55_64_p > 11.75) => 0.0424869559,
   (c_pop_55_64_p = NULL) => -0.0241584312, -0.0241584312), 0.0043760682);

// Tree: 120 
woFDN_FL__SD_lgt_120 := map(
(NULL < c_rich_blk and c_rich_blk <= 178.5) => -0.0046690685,
(c_rich_blk > 178.5) => 
   map(
   (NULL < r_wealth_index_d and r_wealth_index_d <= 2.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 22.25) => 
         map(
         (NULL < c_very_rich and c_very_rich <= 89.5) => 0.2089366869,
         (c_very_rich > 89.5) => 
            map(
            (NULL < c_hval_125k_p and c_hval_125k_p <= 1.25) => -0.0239889850,
            (c_hval_125k_p > 1.25) => 0.0664711069,
            (c_hval_125k_p = NULL) => 0.0287151912, 0.0287151912),
         (c_very_rich = NULL) => 0.0438976573, 0.0438976573),
      (c_pop_35_44_p > 22.25) => 0.2416756089,
      (c_pop_35_44_p = NULL) => 0.0582086524, 0.0582086524),
   (r_wealth_index_d > 2.5) => 0.0043744123,
   (r_wealth_index_d = NULL) => 0.0228724033, 0.0228724033),
(c_rich_blk = NULL) => -0.0285907986, -0.0008332558);

// Tree: 121 
woFDN_FL__SD_lgt_121 := map(
(NULL < c_white_col and c_white_col <= 16.15) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 66.15) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 50.45) => 
         map(
         (NULL < c_food and c_food <= 12.2) => 0.0394488017,
         (c_food > 12.2) => 0.2684009605,
         (c_food = NULL) => 0.1401877516, 0.1401877516),
      (C_RENTOCC_P > 50.45) => -0.0025971072,
      (C_RENTOCC_P = NULL) => 0.0750033595, 0.0750033595),
   (c_lowrent > 66.15) => -0.0524728696,
   (c_lowrent = NULL) => 0.0433425968, 0.0433425968),
(c_white_col > 16.15) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 0.0509099965,
   (r_F00_dob_score_d > 65) => -0.0025882593,
   (r_F00_dob_score_d = NULL) => -0.0190863989, -0.0028178230),
(c_white_col = NULL) => 0.0113785556, -0.0013730287);

// Tree: 122 
woFDN_FL__SD_lgt_122 := map(
(NULL < c_popover25 and c_popover25 <= 325.5) => -0.1120120859,
(c_popover25 > 325.5) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0178691286,
      (f_addrs_per_ssn_i > 5.5) => 
         map(
         (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 0.0071314198,
         (f_nae_nothing_found_i > 0.5) => 0.1197543186,
         (f_nae_nothing_found_i = NULL) => 0.0082628922, 0.0082628922),
      (f_addrs_per_ssn_i = NULL) => -0.0000861076, -0.0000861076),
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 80) => 0.1880532005,
      (c_new_homes > 80) => 0.0088244733,
      (c_new_homes = NULL) => 0.0670276167, 0.0670276167),
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => 0.0175245378, 0.0011141126),
(c_popover25 = NULL) => -0.0011800928, 0.0002992835);

// Tree: 123 
woFDN_FL__SD_lgt_123 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 51.65) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 45.55) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 75.6) => 0.0048977471,
      (c_lowinc > 75.6) => -0.0988296479,
      (c_lowinc = NULL) => 0.0043752126, 0.0043752126),
   (c_famotf18_p > 45.55) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 29.65) => 0.0069060197,
      (C_OWNOCC_P > 29.65) => 0.1369797235,
      (C_OWNOCC_P = NULL) => 0.0712989424, 0.0712989424),
   (c_famotf18_p = NULL) => 0.0049287995, 0.0049287995),
(c_famotf18_p > 51.65) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 10.1) => 0.0400566451,
   (C_INC_35K_P > 10.1) => -0.1094291843,
   (C_INC_35K_P = NULL) => -0.0556142857, -0.0556142857),
(c_famotf18_p = NULL) => 0.0157306027, 0.0044896291);

// Tree: 124 
woFDN_FL__SD_lgt_124 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 188.5) => 
      map(
      (NULL < r_I60_inq_mortgage_recency_d and r_I60_inq_mortgage_recency_d <= 18) => -0.0741595392,
      (r_I60_inq_mortgage_recency_d > 18) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0033022509,
         (k_inq_per_ssn_i > 1.5) => 0.0243530438,
         (k_inq_per_ssn_i = NULL) => 0.0018083474, 0.0018083474),
      (r_I60_inq_mortgage_recency_d = NULL) => -0.0010180260, -0.0010180260),
   (c_span_lang > 188.5) => -0.0407567609,
   (c_span_lang = NULL) => -0.0026164541, -0.0031835428),
(f_inq_QuizProvider_count_i > 5.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0206640827,
   (f_inq_Collection_count_i > 1.5) => 0.1874720743,
   (f_inq_Collection_count_i = NULL) => 0.0757211175, 0.0757211175),
(f_inq_QuizProvider_count_i = NULL) => 0.0176774129, -0.0021037743);

// Tree: 125 
woFDN_FL__SD_lgt_125 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 4.5) => 
   map(
   (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 0.0013399755,
   (f_acc_damage_amt_total_i > 275) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 4.7) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 5.85) => 0.3058160392,
         (c_hval_150k_p > 5.85) => 0.0835869626,
         (c_hval_150k_p = NULL) => 0.1936630472, 0.1936630472),
      (C_INC_200K_P > 4.7) => -0.0153942857,
      (C_INC_200K_P = NULL) => 0.0849157350, 0.0849157350),
   (f_acc_damage_amt_total_i = NULL) => 0.0030540361, 0.0030540361),
(f_rel_criminal_count_i > 4.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 39.65) => -0.0322123306,
   (c_hh1_p > 39.65) => 0.0448255540,
   (c_hh1_p = NULL) => -0.0226464450, -0.0226464450),
(f_rel_criminal_count_i = NULL) => 0.0153714842, -0.0002541524);

// Tree: 126 
woFDN_FL__SD_lgt_126 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00264561835) => 0.1975280702,
      (f_add_curr_nhood_MFD_pct_i > 0.00264561835) => 0.0093247373,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0117734860, 0.0122813066),
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 29.5) => 0.2564427831,
      (r_A50_pb_average_dollars_d > 29.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 18) => 0.0084928414,
         (c_hh4_p > 18) => 0.1620045384,
         (c_hh4_p = NULL) => 0.0455975644, 0.0455975644),
      (r_A50_pb_average_dollars_d = NULL) => 0.0864063164, 0.0864063164),
   (f_util_adl_count_n = NULL) => 0.0170519819, 0.0170519819),
(k_estimated_income_d > 34500) => -0.0051829739,
(k_estimated_income_d = NULL) => 0.0017761211, 0.0024628295);

// Tree: 127 
woFDN_FL__SD_lgt_127 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 47.8) => 0.1096508921,
      (c_low_ed > 47.8) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 30.6) => -0.1076324049,
         (c_lowinc > 30.6) => 
            map(
            (NULL < c_old_homes and c_old_homes <= 129.5) => 0.1268436255,
            (c_old_homes > 129.5) => -0.0160531503,
            (c_old_homes = NULL) => 0.0553952376, 0.0553952376),
         (c_lowinc = NULL) => 0.0077228945, 0.0077228945),
      (c_low_ed = NULL) => 0.0566789309, 0.0566789309),
   (r_I60_inq_comm_recency_d > 549) => 0.0025844101,
   (r_I60_inq_comm_recency_d = NULL) => 0.0073735321, 0.0073735321),
(f_historical_count_d > 0.5) => -0.0144510793,
(f_historical_count_d = NULL) => -0.0278748809, -0.0038210862);

// Tree: 128 
woFDN_FL__SD_lgt_128 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 54.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1994) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 5.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 55097.5) => 0.0537814150,
         (f_curraddrmedianincome_d > 55097.5) => -0.0167084589,
         (f_curraddrmedianincome_d = NULL) => 0.0125052589, 0.0125052589),
      (r_C13_Curr_Addr_LRes_d > 5.5) => -0.0267644011,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0179151224, -0.0179151224),
   (c_popover25 > 1994) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 3.55) => 0.0259244965,
      (c_hh7p_p > 3.55) => 0.1707975823,
      (c_hh7p_p = NULL) => 0.0421432686, 0.0421432686),
   (c_popover25 = NULL) => -0.0269736112, -0.0112363130),
(r_C13_Curr_Addr_LRes_d > 54.5) => 0.0130995842,
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0201157271, 0.0020838748);

// Tree: 129 
woFDN_FL__SD_lgt_129 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 52.35) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 19.6) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0511660983,
         (r_F04_curr_add_occ_index_d > 2) => 0.1026734275,
         (r_F04_curr_add_occ_index_d = NULL) => -0.0064824186, -0.0064824186),
      (c_hh3_p > 19.6) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.45) => 0.0386372494,
         (c_pop_18_24_p > 7.45) => 0.2018588165,
         (c_pop_18_24_p = NULL) => 0.1194556953, 0.1194556953),
      (c_hh3_p = NULL) => 0.0312257957, 0.0312257957),
   (r_I61_inq_collection_recency_d > 4.5) => -0.0063468458,
   (r_I61_inq_collection_recency_d = NULL) => -0.0049018318, -0.0052834876),
(c_hval_500k_p > 52.35) => 0.1087521621,
(c_hval_500k_p = NULL) => 0.0294620964, -0.0037308421);

// Tree: 130 
woFDN_FL__SD_lgt_130 := map(
(NULL < c_hh6_p and c_hh6_p <= 16.45) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 12.5) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 4.5) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0086382731,
         (r_C14_Addr_Stability_v2_d > 5.5) => 0.0033532346,
         (r_C14_Addr_Stability_v2_d = NULL) => -0.0034600764, -0.0034600764),
      (f_inq_Other_count24_i > 4.5) => 0.0874533522,
      (f_inq_Other_count24_i = NULL) => -0.0028863473, -0.0028863473),
   (f_inq_count24_i > 12.5) => -0.0721986409,
   (f_inq_count24_i = NULL) => 0.0122661198, -0.0034754814),
(c_hh6_p > 16.45) => -0.0889058527,
(c_hh6_p = NULL) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => -0.0157262928,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity']) => 0.1408032625,
   (nf_seg_FraudPoint_3_0 = '') => 0.0095517720, 0.0095517720), -0.0038182691);

// Tree: 131 
woFDN_FL__SD_lgt_131 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 22.35) => -0.0015752107,
(C_INC_50K_P > 22.35) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 24.95) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 169.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 61.35) => -0.0461332187,
         (c_civ_emp > 61.35) => 
            map(
            (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0270769413,
            (r_D30_Derog_Count_i > 1.5) => 0.1754266682,
            (r_D30_Derog_Count_i = NULL) => 0.0629339843, 0.0629339843),
         (c_civ_emp = NULL) => 0.0015131164, 0.0015131164),
      (f_prevaddrmurderindex_i > 169.5) => 0.1207933772,
      (f_prevaddrmurderindex_i = NULL) => 0.0173600451, 0.0173600451),
   (c_hval_250k_p > 24.95) => 0.1557725596,
   (c_hval_250k_p = NULL) => 0.0313793191, 0.0313793191),
(C_INC_50K_P = NULL) => 0.0033910379, 0.0001628411);

// Tree: 132 
woFDN_FL__SD_lgt_132 := map(
(NULL < c_food and c_food <= 89.35) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 181.5) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 36.75) => 0.0991558386,
         (c_hh2_p > 36.75) => -0.0453652553,
         (c_hh2_p = NULL) => 0.0524475003, 0.0524475003),
      (f_mos_liens_unrel_SC_fseen_d > 181.5) => 0.0041822077,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0053460265, 0.0053460265),
   (r_D31_attr_bankruptcy_recency_d > 9) => -0.0308394341,
   (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0014440250, 0.0016956987),
(c_food > 89.35) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => -0.0057846860,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.1384037321,
   (nf_seg_FraudPoint_3_0 = '') => 0.0545294235, 0.0545294235),
(c_food = NULL) => -0.0398543167, 0.0013240909);

// Tree: 133 
woFDN_FL__SD_lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 127.5) => 
   map(
   (NULL < c_hval_400k_p and c_hval_400k_p <= 6.55) => 
      map(
      (NULL < c_rape and c_rape <= 66) => 0.0806576522,
      (c_rape > 66) => -0.0535330506,
      (c_rape = NULL) => -0.0083392906, -0.0083392906),
   (c_hval_400k_p > 6.55) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 16) => 0.0378407425,
      (c_hh3_p > 16) => 0.2056234194,
      (c_hh3_p = NULL) => 0.1217320810, 0.1217320810),
   (c_hval_400k_p = NULL) => 0.0435271753, 0.0435271753),
(f_mos_liens_unrel_SC_fseen_d > 127.5) => 0.0012425798,
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0545832445,
   (f_addrs_per_ssn_i > 3.5) => 0.0739009687,
   (f_addrs_per_ssn_i = NULL) => 0.0077877328, 0.0077877328), 0.0023724241);

// Tree: 134 
woFDN_FL__SD_lgt_134 := map(
(NULL < c_hh2_p and c_hh2_p <= 36.35) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 5.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 122.5) => 0.1162750560,
         (c_rest_indx > 122.5) => -0.0526737223,
         (c_rest_indx = NULL) => 0.0499787000, 0.0499787000),
      (f_M_Bureau_ADL_FS_noTU_d > 8.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 8.5) => -0.0047016714,
         (f_rel_under25miles_cnt_d > 8.5) => -0.0871703768,
         (f_rel_under25miles_cnt_d = NULL) => -0.0203895256, -0.0060574145),
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0048872181, -0.0048872181),
   (f_idverrisktype_i > 5.5) => -0.0558869322,
   (f_idverrisktype_i = NULL) => -0.0277281018, -0.0079332412),
(c_hh2_p > 36.35) => 0.0186317729,
(c_hh2_p = NULL) => 0.0068868447, 0.0014098654);

// Tree: 135 
woFDN_FL__SD_lgt_135 := map(
(NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.31649573815) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 25.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.04760077475) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 32.9) => -0.0153806388,
         (c_rnt750_p > 32.9) => 0.1380966889,
         (c_rnt750_p = NULL) => 0.0140490344, 0.0140490344),
      (f_add_curr_nhood_VAC_pct_i > 0.04760077475) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 13.1) => 0.1861262122,
         (C_INC_75K_P > 13.1) => 0.0526225278,
         (C_INC_75K_P = NULL) => 0.1085497469, 0.1085497469),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0361439877, 0.0361439877),
   (c_many_cars > 25.5) => 0.0018612877,
   (c_many_cars = NULL) => -0.0131199009, 0.0040224308),
(f_add_curr_mobility_index_i > 0.31649573815) => -0.0188700703,
(f_add_curr_mobility_index_i = NULL) => -0.0028206004, -0.0022112288);

// Tree: 136 
woFDN_FL__SD_lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.65) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 208.95) => 
         map(
         (NULL < f_inq_count_i and f_inq_count_i <= 0.5) => 0.2374160654,
         (f_inq_count_i > 0.5) => 0.0421742170,
         (f_inq_count_i = NULL) => 0.0903338730, 0.0903338730),
      (c_housingcpi > 208.95) => 
         map(
         (NULL < c_retired2 and c_retired2 <= 124.5) => -0.0151159270,
         (c_retired2 > 124.5) => 0.0502979187,
         (c_retired2 = NULL) => 0.0043241980, 0.0043241980),
      (c_housingcpi = NULL) => 0.0157667268, 0.0157667268),
   (c_hh7p_p > 7.65) => 0.1375616876,
   (c_hh7p_p = NULL) => 0.0788920638, 0.0217761285),
(f_hh_members_ct_d > 1.5) => -0.0066863153,
(f_hh_members_ct_d = NULL) => 0.0040330213, -0.0012196057);

// Tree: 137 
woFDN_FL__SD_lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0781434606,
   (C_INC_100K_P > 1.35) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.45) => -0.0040949641,
      (r_C12_source_profile_d > 81.45) => 0.0433594507,
      (r_C12_source_profile_d = NULL) => -0.0001635015, -0.0001635015),
   (C_INC_100K_P = NULL) => 0.0199852817, 0.0007589086),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 5.5) => -0.1147580404,
   (f_inq_HighRiskCredit_count_i > 5.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 22.5) => -0.0822657610,
      (f_mos_inq_banko_cm_lseen_d > 22.5) => 0.0337737874,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0094409409, -0.0094409409),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0423837303, -0.0423837303),
(f_inq_HighRiskCredit_count24_i = NULL) => -0.0043449383, 0.0000022535);

// Tree: 138 
woFDN_FL__SD_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 87.5) => 0.0099597775,
   (c_old_homes > 87.5) => -0.0116267150,
   (c_old_homes = NULL) => -0.0165449382, 0.0002505787),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.350936958) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 142) => -0.0450490486,
         (f_fp_prevaddrcrimeindex_i > 142) => 0.1395344589,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0533056671, 0.0533056671),
      (f_add_curr_mobility_index_i > 0.350936958) => -0.0855293682,
      (f_add_curr_mobility_index_i = NULL) => 0.0001481085, 0.0001481085),
   (f_vardobcountnew_i > 0.5) => 0.1264160576,
   (f_vardobcountnew_i = NULL) => 0.0362826663, 0.0362826663),
(f_curraddrcrimeindex_i = NULL) => -0.0223242855, 0.0009666956);

// Tree: 139 
woFDN_FL__SD_lgt_139 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0191560653,
(f_addrs_per_ssn_i > 5.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 91.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 45) => -0.0512660713,
         (c_robbery > 45) => 
            map(
            (NULL < c_rape and c_rape <= 57.5) => 0.1697287589,
            (c_rape > 57.5) => 0.0252023578,
            (c_rape = NULL) => 0.0575520675, 0.0575520675),
         (c_robbery = NULL) => 0.0298576552, 0.0298576552),
      (r_C21_M_Bureau_ADL_FS_d > 91.5) => -0.0015923569,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0015745232, 0.0015745232),
   (f_nae_nothing_found_i > 0.5) => 0.1211870498,
   (f_nae_nothing_found_i = NULL) => 0.0027702314, 0.0027702314),
(f_addrs_per_ssn_i = NULL) => -0.0042855939, -0.0042855939);

// Tree: 140 
woFDN_FL__SD_lgt_140 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 25.35) => -0.0030004959,
(c_hval_500k_p > 25.35) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 3.5) => 0.1805592799,
   (c_born_usa > 3.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 10.45) => 
            map(
            (NULL < c_assault and c_assault <= 55.5) => 0.0093883159,
            (c_assault > 55.5) => 0.2966229802,
            (c_assault = NULL) => 0.1212586589, 0.1212586589),
         (c_hh1_p > 10.45) => 0.0146784821,
         (c_hh1_p = NULL) => 0.0373044414, 0.0373044414),
      (f_varrisktype_i > 2.5) => -0.0717800655,
      (f_varrisktype_i = NULL) => 0.0262426591, 0.0262426591),
   (c_born_usa = NULL) => 0.0347996898, 0.0347996898),
(c_hval_500k_p = NULL) => -0.0304215323, -0.0004826997);

// Tree: 141 
woFDN_FL__SD_lgt_141 := map(
(NULL < c_lowinc and c_lowinc <= 72.85) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => -0.0071551605,
      (r_I60_inq_hiRiskCred_count12_i > 2.5) => -0.0976018767,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0077767874, -0.0077767874),
   (f_hh_collections_ct_i > 1.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 5.75) => -0.0069405694,
      (c_incollege > 5.75) => 0.0368285373,
      (c_incollege = NULL) => 0.0143209362, 0.0143209362),
   (f_hh_collections_ct_i = NULL) => 0.0002682474, -0.0016038836),
(c_lowinc > 72.85) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 10.1) => -0.0117396343,
   (c_pop_0_5_p > 10.1) => -0.1218735105,
   (c_pop_0_5_p = NULL) => -0.0542095604, -0.0542095604),
(c_lowinc = NULL) => -0.0284343518, -0.0029321503);

// Tree: 142 
woFDN_FL__SD_lgt_142 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 17.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 112.5) => 0.0056370173,
      (c_robbery > 112.5) => 0.1802980012,
      (c_robbery = NULL) => 0.0814090618, 0.0814090618),
   (r_C13_max_lres_d > 17.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 75.7) => -0.0001091681,
      (C_RENTOCC_P > 75.7) => 
         map(
         (NULL < c_robbery and c_robbery <= 64.5) => 0.1428763467,
         (c_robbery > 64.5) => 0.0164883479,
         (c_robbery = NULL) => 0.0479594631, 0.0479594631),
      (C_RENTOCC_P = NULL) => -0.0060148233, 0.0017793849),
   (r_C13_max_lres_d = NULL) => 0.0027717787, 0.0027717787),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0465251684,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0072401243, 0.0007031281);

// Tree: 143 
woFDN_FL__SD_lgt_143 := map(
(NULL < c_child and c_child <= 33.45) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => 0.0029111931,
   (f_inq_QuizProvider_count_i > 6.5) => 0.0867264424,
   (f_inq_QuizProvider_count_i = NULL) => 0.0150037622, 0.0036748422),
(c_child > 33.45) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 6.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.55) => -0.0501162300,
      (c_incollege > 6.55) => 
         map(
         (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 1.5) => -0.0086242579,
         (f_srchssnsrchcount_i > 1.5) => 0.1389855243,
         (f_srchssnsrchcount_i = NULL) => 0.0397450493, 0.0397450493),
      (c_incollege = NULL) => -0.0243792617, -0.0243792617),
   (f_corrssnnamecount_d > 6.5) => -0.0940939170,
   (f_corrssnnamecount_d = NULL) => -0.0444011177, -0.0444011177),
(c_child = NULL) => -0.0071036570, 0.0001166961);

// Tree: 144 
woFDN_FL__SD_lgt_144 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 34.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 11.5) => -0.0008435698,
   (f_srchssnsrchcount_i > 11.5) => 
      map(
      (NULL < c_rnt1500_p and c_rnt1500_p <= 5.05) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 140273) => 0.0031208179,
         (f_prevaddrmedianvalue_d > 140273) => 0.1389132624,
         (f_prevaddrmedianvalue_d = NULL) => 0.0797216840, 0.0797216840),
      (c_rnt1500_p > 5.05) => -0.0444744110,
      (c_rnt1500_p = NULL) => 0.0420192980, 0.0420192980),
   (f_srchssnsrchcount_i = NULL) => -0.0002551598, -0.0002551598),
(f_rel_count_i > 34.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 7.5) => 0.0591656795,
   (c_hh4_p > 7.5) => -0.0683627994,
   (c_hh4_p = NULL) => -0.0431580558, -0.0431580558),
(f_rel_count_i = NULL) => -0.0181015660, -0.0015714391);

// Tree: 145 
woFDN_FL__SD_lgt_145 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 57.5) => -0.0078531371,
(k_comb_age_d > 57.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 43.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 241.75) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 8.25) => 0.1037925835,
         (C_INC_125K_P > 8.25) => -0.0149121715,
         (C_INC_125K_P = NULL) => 0.0333052505, 0.0333052505),
      (c_housingcpi > 241.75) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 170.5) => 0.2650138425,
         (c_asian_lang > 170.5) => 0.0415025930,
         (c_asian_lang = NULL) => 0.1613858996, 0.1613858996),
      (c_housingcpi = NULL) => 0.0536943552, 0.0536943552),
   (f_prevaddrlenofres_d > 43.5) => 0.0058686020,
   (f_prevaddrlenofres_d = NULL) => 0.0196710462, 0.0196710462),
(k_comb_age_d = NULL) => -0.0023569797, -0.0023569797);

// Tree: 146 
woFDN_FL__SD_lgt_146 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.0174542446,
(f_hh_age_18_plus_d > 1.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 38.75) => -0.0502090148,
   (c_fammar_p > 38.75) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0117071467,
      (f_hh_payday_loan_users_i > 0.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 17.85) => 0.0076919061,
         (c_hval_250k_p > 17.85) => 
            map(
            (NULL < c_construction and c_construction <= 8.25) => 0.2159123426,
            (c_construction > 8.25) => -0.0411398029,
            (c_construction = NULL) => 0.1045625652, 0.1045625652),
         (c_hval_250k_p = NULL) => 0.0305159376, 0.0305159376),
      (f_hh_payday_loan_users_i = NULL) => -0.0074641068, -0.0074641068),
   (c_fammar_p = NULL) => -0.0249397509, -0.0093324678),
(f_hh_age_18_plus_d = NULL) => 0.0038493564, -0.0031870564);

// Tree: 147 
woFDN_FL__SD_lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 103.5) => -0.0098215416,
   (f_prevaddrcartheftindex_i > 103.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 27.75) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0106260605,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0247041117,
         (nf_seg_FraudPoint_3_0 = '') => 0.0111091285, 0.0111091285),
      (c_pop_35_44_p > 27.75) => 0.1876616672,
      (c_pop_35_44_p = NULL) => 0.0129949707, 0.0129949707),
   (f_prevaddrcartheftindex_i = NULL) => -0.0010851144, -0.0010851144),
(f_prevaddrcartheftindex_i > 194.5) => -0.0808758131,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 408) => -0.0444283264,
   (c_families > 408) => 0.0649904617,
   (c_families = NULL) => 0.0128862769, 0.0128862769), -0.0025460940);

// Tree: 148 
woFDN_FL__SD_lgt_148 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 91) => 0.0848988103,
(r_D32_Mos_Since_Fel_LS_d > 91) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 47.05) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 153.5) => 0.0053559622,
         (c_span_lang > 153.5) => -0.0339900506,
         (c_span_lang = NULL) => -0.0063657639, -0.0063657639),
      (r_C14_Addr_Stability_v2_d > 3.5) => -0.0007170983,
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0021514722, -0.0021514722),
   (c_hval_500k_p > 47.05) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 5.5) => 0.0241166323,
      (f_rel_homeover300_count_d > 5.5) => 0.1512176331,
      (f_rel_homeover300_count_d = NULL) => 0.0823712576, 0.0823712576),
   (c_hval_500k_p = NULL) => -0.0070376764, -0.0014275387),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0018443562, -0.0010468334);

// Tree: 149 
woFDN_FL__SD_lgt_149 := map(
(NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 197.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 18.75) => -0.0128878435,
      (c_hh5_p > 18.75) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 89) => -0.0438799017,
         (c_medi_indx > 89) => 0.1622512910,
         (c_medi_indx = NULL) => 0.0659812285, 0.0659812285),
      (c_hh5_p = NULL) => -0.0107083459, -0.0107083459),
   (c_serv_empl > 197.5) => 0.1078001422,
   (c_serv_empl = NULL) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => -0.0633194032,
      (f_srchfraudsrchcount_i > 0.5) => 0.1296026957,
      (f_srchfraudsrchcount_i = NULL) => -0.0085000090, -0.0085000090), -0.0094361342),
(f_util_add_curr_misc_n > 0.5) => 0.0140489924,
(f_util_add_curr_misc_n = NULL) => 0.0013853530, 0.0013853530);

// Tree: 150 
woFDN_FL__SD_lgt_150 := map(
(NULL < c_unempl and c_unempl <= 22.5) => -0.0752561283,
(c_unempl > 22.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_transport and c_transport <= 7.25) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 0.95) => 
            map(
            (NULL < c_low_hval and c_low_hval <= 2.15) => 0.1701930752,
            (c_low_hval > 2.15) => 0.0145821920,
            (c_low_hval = NULL) => 0.0932553523, 0.0932553523),
         (c_hh6_p > 0.95) => -0.0108712532,
         (c_hh6_p = NULL) => 0.0346735547, 0.0346735547),
      (c_transport > 7.25) => 0.2105583093,
      (c_transport = NULL) => 0.0498315276, 0.0498315276),
   (f_corrssnnamecount_d > 1.5) => -0.0022304050,
   (f_corrssnnamecount_d = NULL) => -0.0157273215, 0.0006152630),
(c_unempl = NULL) => 0.0267764598, -0.0016266844);

// Tree: 151 
woFDN_FL__SD_lgt_151 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 367.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 198.5) => -0.0013052453,
      (c_bel_edu > 198.5) => -0.1226427440,
      (c_bel_edu = NULL) => -0.0290444314, -0.0025038345),
   (r_C14_addrs_10yr_i > 10.5) => 0.1068153088,
   (r_C14_addrs_10yr_i = NULL) => -0.0020442505, -0.0020442505),
(f_prevaddrlenofres_d > 367.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 148.5) => 0.0057031552,
   (c_relig_indx > 148.5) => 0.2487225766,
   (c_relig_indx = NULL) => 0.0855005771, 0.0855005771),
(f_prevaddrlenofres_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 28.5) => -0.0712318168,
   (k_comb_age_d > 28.5) => 0.0567031956,
   (k_comb_age_d = NULL) => -0.0043300213, -0.0043300213), -0.0006352926);

// Tree: 152 
woFDN_FL__SD_lgt_152 := map(
(NULL < c_fammar_p and c_fammar_p <= 18.85) => -0.0739459354,
(c_fammar_p > 18.85) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
      map(
      (NULL < c_young and c_young <= 41.35) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.0150630171,
         (k_inq_per_ssn_i > 0.5) => 
            map(
            (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.1661232220,
            (r_C16_Inv_SSN_Per_ADL_i > 0.5) => 0.0388244328,
            (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0981731926, 0.0981731926),
         (k_inq_per_ssn_i = NULL) => 0.0506130344, 0.0506130344),
      (c_young > 41.35) => -0.0763665827,
      (c_young = NULL) => 0.0274985414, 0.0274985414),
   (r_C10_M_Hdr_FS_d > 15.5) => 0.0000571689,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0015564556, 0.0009896489),
(c_fammar_p = NULL) => 0.0125252396, 0.0006817198);

// Tree: 153 
woFDN_FL__SD_lgt_153 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 26.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 35.15) => 0.0022947709,
   (c_hval_60k_p > 35.15) => -0.0809254929,
   (c_hval_60k_p = NULL) => -0.0037785196, 0.0014583291),
(f_rel_homeover300_count_d > 26.5) => -0.1048501943,
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 4.05) => -0.0982929250,
   (c_famotf18_p > 4.05) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 61.6) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 0.65) => 0.0372105912,
         (c_hh6_p > 0.65) => -0.0948680007,
         (c_hh6_p = NULL) => -0.0205191245, -0.0205191245),
      (C_OWNOCC_P > 61.6) => 0.0727046351,
      (C_OWNOCC_P = NULL) => 0.0140513530, 0.0140513530),
   (c_famotf18_p = NULL) => -0.0118742496, -0.0118742496), 0.0004421093);

// Tree: 154 
woFDN_FL__SD_lgt_154 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.95) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 35.25) => -0.0107590646,
   (c_famotf18_p > 35.25) => -0.0481721368,
   (c_famotf18_p = NULL) => -0.0131668025, -0.0131668025),
(c_pop_35_44_p > 13.95) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 44522) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 48.5) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 2.5) => 0.1091534531,
         (f_rel_homeover150_count_d > 2.5) => 0.1304534917,
         (f_rel_homeover150_count_d = NULL) => 0.1198034724, 0.1198034724),
      (r_C13_Curr_Addr_LRes_d > 48.5) => -0.0101024625,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0613458017, 0.0613458017),
   (f_curraddrmedianvalue_d > 44522) => 0.0083703636,
   (f_curraddrmedianvalue_d = NULL) => -0.0050729628, 0.0097921146),
(c_pop_35_44_p = NULL) => -0.0038604658, -0.0003578389);

// Tree: 155 
woFDN_FL__SD_lgt_155 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < c_unemp and c_unemp <= 12.95) => 
      map(
      (NULL < c_bargains and c_bargains <= 93.5) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 4.65) => -0.0587573340,
         (c_pop_18_24_p > 4.65) => 
            map(
            (NULL < c_very_rich and c_very_rich <= 117.5) => 0.0812543262,
            (c_very_rich > 117.5) => 0.0049363513,
            (c_very_rich = NULL) => 0.0505196448, 0.0505196448),
         (c_pop_18_24_p = NULL) => 0.0292775763, 0.0292775763),
      (c_bargains > 93.5) => -0.0058059182,
      (c_bargains = NULL) => 0.0067355512, 0.0067355512),
   (c_unemp > 12.95) => 0.0744041251,
   (c_unemp = NULL) => 0.0218186337, 0.0088481056),
(k_estimated_income_d > 34500) => -0.0102960579,
(k_estimated_income_d = NULL) => 0.0283614621, -0.0033813746);

// Tree: 156 
woFDN_FL__SD_lgt_156 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => 0.0013301659,
   (f_hh_criminals_i > 3.5) => 0.0789461322,
   (f_hh_criminals_i = NULL) => 0.0021318512, 0.0021318512),
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 57) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => -0.0850118851,
      (f_varrisktype_i > 1.5) => 0.0654364355,
      (f_varrisktype_i = NULL) => 0.0052571073, 0.0052571073),
   (f_prevaddrcartheftindex_i > 57) => 
      map(
      (NULL < c_finance and c_finance <= 8.35) => -0.0783783734,
      (c_finance > 8.35) => 0.0339130414,
      (c_finance = NULL) => -0.0592304154, -0.0592304154),
   (f_prevaddrcartheftindex_i = NULL) => -0.0402249463, -0.0402249463),
(f_srchssnsrchcount_i = NULL) => 0.0101445885, 0.0005464838);

// Tree: 157 
woFDN_FL__SD_lgt_157 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 20986.5) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 44) => 0.1327110675,
   (c_lowrent > 44) => -0.0243387650,
   (c_lowrent = NULL) => 0.0585486466, 0.0585486466),
(r_A46_Curr_AVM_AutoVal_d > 20986.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 0.0738157056,
   (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 0.0048012344,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0059751512, 0.0059751512),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 1.5) => -0.0100068741,
   (f_divssnidmsrcurelcount_i > 1.5) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 11.05) => 0.0235458803,
      (c_rnt1250_p > 11.05) => 0.2322503183,
      (c_rnt1250_p = NULL) => 0.0763714849, 0.0763714849),
   (f_divssnidmsrcurelcount_i = NULL) => -0.0032493043, -0.0055640158), 0.0013458919);

// Tree: 158 
woFDN_FL__SD_lgt_158 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 4.8) => 0.0083005753,
      (c_hval_175k_p > 4.8) => 0.1483253843,
      (c_hval_175k_p = NULL) => 0.0756710023, 0.0756710023),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => -0.0011094147,
      (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0636045336,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0007736744, -0.0007736744),
   (r_D33_Eviction_Recency_d = NULL) => -0.0001163104, -0.0001163104),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 543) => -0.1607306565,
   (r_A50_pb_total_dollars_d > 543) => 0.0033798151,
   (r_A50_pb_total_dollars_d = NULL) => -0.0640628445, -0.0640628445),
(r_I60_inq_comm_count12_i = NULL) => 0.0069472812, -0.0007988558);

// Tree: 159 
woFDN_FL__SD_lgt_159 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0956862856,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 17.5) => 
      map(
      (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0008992954,
      (f_srchunvrfdaddrcount_i > 0.5) => 0.0401567145,
      (f_srchunvrfdaddrcount_i = NULL) => 0.0000837116, 0.0000837116),
   (f_rel_homeover500_count_d > 17.5) => 0.1216986520,
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_families and c_families <= 426.5) => -0.0350004426,
      (c_families > 426.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 108.5) => 0.1517941311,
         (c_exp_prod > 108.5) => 0.0094126987,
         (c_exp_prod = NULL) => 0.0718606954, 0.0718606954),
      (c_families = NULL) => 0.0036731121, 0.0036731121), 0.0007579500),
(C_INC_100K_P = NULL) => 0.0098683012, 0.0014470254);

// Tree: 160 
woFDN_FL__SD_lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 76.45) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 21.35) => -0.0083555088,
   (c_hval_40k_p > 21.35) => 0.0609944159,
   (c_hval_40k_p = NULL) => 0.0104261544, -0.0066214386),
(r_C12_source_profile_d > 76.45) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 193.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 29.05) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 90.95) => 0.0147427049,
         (c_lowrent > 90.95) => 0.2522674240,
         (c_lowrent = NULL) => 0.0209933554, 0.0209933554),
      (c_hval_500k_p > 29.05) => 0.1504038117,
      (c_hval_500k_p = NULL) => 0.0260243006, 0.0260243006),
   (c_rich_wht > 193.5) => 0.2054544130,
   (c_rich_wht = NULL) => -0.0469746401, 0.0286450775),
(r_C12_source_profile_d = NULL) => -0.0045347851, -0.0002449361);

// Tree: 161 
woFDN_FL__SD_lgt_161 := map(
(NULL < c_unemp and c_unemp <= 13.8) => 
   map(
   (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => -0.0057152287,
   (f_inq_Collection_count24_i > 1.5) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 0.25) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 321666) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 70251.5) => 0.0692402317,
            (f_prevaddrmedianincome_d > 70251.5) => 0.2756804475,
            (f_prevaddrmedianincome_d = NULL) => 0.1376235532, 0.1376235532),
         (c_med_hval > 321666) => 0.0021580589,
         (c_med_hval = NULL) => 0.0784766472, 0.0784766472),
      (c_low_hval > 0.25) => -0.0089742808,
      (c_low_hval = NULL) => 0.0248162819, 0.0248162819),
   (f_inq_Collection_count24_i = NULL) => -0.0194605746, -0.0039954100),
(c_unemp > 13.8) => -0.0629364853,
(c_unemp = NULL) => -0.0321589840, -0.0051026911);

// Tree: 162 
woFDN_FL__SD_lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => -0.0083850923,
   (r_C14_Addr_Stability_v2_d > 4.5) => 0.0036066107,
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0007490323, -0.0007490323),
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 89.25) => 0.1096182956,
   (c_occunit_p > 89.25) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 15.65) => -0.0439299309,
      (C_INC_100K_P > 15.65) => 0.0812122645,
      (C_INC_100K_P = NULL) => 0.0090148441, 0.0090148441),
   (c_occunit_p = NULL) => 0.0384430646, 0.0384430646),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 65) => 0.0618966201,
   (c_larceny > 65) => -0.0443314178,
   (c_larceny = NULL) => 0.0108254480, 0.0108254480), 0.0002653112);

// Tree: 163 
woFDN_FL__SD_lgt_163 := map(
(NULL < c_civ_emp and c_civ_emp <= 41.55) => -0.0478735874,
(c_civ_emp > 41.55) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 3.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => -0.0229521274,
      (r_D33_eviction_count_i > 0.5) => -0.0976067243,
      (r_D33_eviction_count_i = NULL) => -0.0307962699, -0.0307962699),
   (f_mos_inq_banko_om_lseen_d > 3.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => -0.0124131047,
      (r_C14_Addr_Stability_v2_d > 1.5) => 0.0048773278,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0037487970, 0.0037487970),
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0003288218, 0.0021345324),
(c_civ_emp = NULL) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => -0.1094165258,
   (r_F00_dob_score_d > 98) => -0.0142716458,
   (r_F00_dob_score_d = NULL) => 0.1608585903, -0.0019896759), 0.0006033378);

// Tree: 164 
woFDN_FL__SD_lgt_164 := map(
(NULL < c_assault and c_assault <= 158.5) => -0.0010279496,
(c_assault > 158.5) => 
   map(
   (NULL < c_families and c_families <= 571.5) => 
      map(
      (NULL < c_trailer_p and c_trailer_p <= 16.85) => 0.0085709058,
      (c_trailer_p > 16.85) => 
         map(
         (NULL < c_rape and c_rape <= 156.5) => 0.2657647565,
         (c_rape > 156.5) => 0.0128154105,
         (c_rape = NULL) => 0.1014780679, 0.1014780679),
      (c_trailer_p = NULL) => 0.0205868988, 0.0205868988),
   (c_families > 571.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 1.5) => 0.0595607575,
      (f_current_count_d > 1.5) => 0.2873123756,
      (f_current_count_d = NULL) => 0.1494627120, 0.1494627120),
   (c_families = NULL) => 0.0325155130, 0.0325155130),
(c_assault = NULL) => 0.0387499313, 0.0043215216);

// Tree: 165 
woFDN_FL__SD_lgt_165 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 9.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 20.5) => 0.0059319044,
   (f_rel_ageover20_count_d > 20.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 129.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 39.5) => 0.0216859399,
         (f_mos_inq_banko_cm_lseen_d > 39.5) => 0.2128910323,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.1273519120, 0.1273519120),
      (c_for_sale > 129.5) => -0.0187288736,
      (c_for_sale = NULL) => 0.0680065928, 0.0680065928),
   (f_rel_ageover20_count_d = NULL) => 0.0071362738, 0.0071362738),
(f_rel_incomeover50_count_d > 9.5) => -0.0209338681,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_rape and c_rape <= 19.5) => 0.1262964480,
   (c_rape > 19.5) => -0.0031808814,
   (c_rape = NULL) => 0.0192794717, 0.0192794717), 0.0021562544);

// Tree: 166 
woFDN_FL__SD_lgt_166 := map(
(NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 8.15) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 27.15) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 12.1) => -0.0097269103,
         (c_lowrent > 12.1) => 0.1215494038,
         (c_lowrent = NULL) => 0.0176043879, 0.0176043879),
      (c_hh3_p > 27.15) => 
         map(
         (NULL < c_preschl and c_preschl <= 112.5) => 0.2819105366,
         (c_preschl > 112.5) => 0.0660306219,
         (c_preschl = NULL) => 0.1567364684, 0.1567364684),
      (c_hh3_p = NULL) => 0.0403159346, 0.0403159346),
   (c_hh1_p > 8.15) => -0.0019257136,
   (c_hh1_p = NULL) => 0.0074183491, 0.0008922364),
(f_inq_Auto_count24_i > 1.5) => -0.0397009570,
(f_inq_Auto_count24_i = NULL) => -0.0313892240, -0.0015004909);

// Tree: 167 
woFDN_FL__SD_lgt_167 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
      map(
      (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.05) => -0.0042178227,
      (c_hval_1000k_p > 41.05) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 141.5) => -0.0372138386,
         (r_C13_max_lres_d > 141.5) => 0.1916168459,
         (r_C13_max_lres_d = NULL) => 0.0858693326, 0.0858693326),
      (c_hval_1000k_p = NULL) => 0.0118134748, -0.0028643448),
   (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0688243305,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0031863583, -0.0031863583),
(f_hh_collections_ct_i > 5.5) => 0.0706215161,
(f_hh_collections_ct_i = NULL) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 79) => 0.0059816746,
   (c_blue_empl > 79) => -0.0700088594,
   (c_blue_empl = NULL) => -0.0320135924, -0.0320135924), -0.0029142196);

// Tree: 168 
woFDN_FL__SD_lgt_168 := map(
(NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 38.5) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 9.55) => 0.0639304325,
   (c_pop_25_34_p > 9.55) => -0.0915081739,
   (c_pop_25_34_p = NULL) => -0.0554242117, -0.0554242117),
(f_mos_liens_unrel_CJ_lseen_d > 38.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 56.25) => 
      map(
      (NULL < f_liens_unrel_FT_total_amt_i and f_liens_unrel_FT_total_amt_i <= 16426) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0046455015,
         (f_rel_felony_count_i > 0.5) => 0.0201814552,
         (f_rel_felony_count_i = NULL) => -0.0010773180, -0.0010773180),
      (f_liens_unrel_FT_total_amt_i > 16426) => -0.1025699469,
      (f_liens_unrel_FT_total_amt_i = NULL) => -0.0017303037, -0.0017303037),
   (c_famotf18_p > 56.25) => -0.0668710042,
   (c_famotf18_p = NULL) => 0.0008658993, -0.0021392494),
(f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0386111226, -0.0027814289);

// Tree: 169 
woFDN_FL__SD_lgt_169 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 18.75) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 9.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0577769894,
      (r_D33_Eviction_Recency_d > 30) => -0.0010532769,
      (r_D33_Eviction_Recency_d = NULL) => -0.0005410345, -0.0005410345),
   (f_inq_HighRiskCredit_count24_i > 9.5) => 0.0688842631,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0087554000, -0.0002818498),
(c_hval_80k_p > 18.75) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 2.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.0529361266,
      (f_sourcerisktype_i > 5.5) => 0.0188106669,
      (f_sourcerisktype_i = NULL) => -0.0320210097, -0.0320210097),
   (f_srchfraudsrchcountyr_i > 2.5) => -0.1196253527,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0370965800, -0.0370965800),
(c_hval_80k_p = NULL) => 0.0132855411, -0.0024801130);

// Tree: 170 
woFDN_FL__SD_lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < c_amus_indx and c_amus_indx <= 168.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 47.35) => -0.0604085757,
         (r_C12_source_profile_d > 47.35) => 0.0605513438,
         (r_C12_source_profile_d = NULL) => 0.0303113639, 0.0303113639),
      (r_F00_dob_score_d > 98) => -0.0019016518,
      (r_F00_dob_score_d = NULL) => 0.0023215251, -0.0006773276),
   (c_amus_indx > 168.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 59.5) => 0.2559705571,
      (f_prevaddrcartheftindex_i > 59.5) => -0.0024432623,
      (f_prevaddrcartheftindex_i = NULL) => 0.1099105723, 0.1099105723),
   (c_amus_indx = NULL) => -0.0175278412, -0.0000248205),
(f_util_adl_count_n > 13.5) => 0.0997391639,
(f_util_adl_count_n = NULL) => 0.0156956386, 0.0008636552);

// Tree: 171 
woFDN_FL__SD_lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 38.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 15.75) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 0.1282286029,
      (f_prevaddrlenofres_d > 2.5) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 2.65) => -0.0111612279,
         (c_pop_85p_p > 2.65) => 0.0737110978,
         (c_pop_85p_p = NULL) => 0.0061942103, 0.0061942103),
      (f_prevaddrlenofres_d = NULL) => 0.0130855642, 0.0130855642),
   (c_pop_18_24_p > 15.75) => 
      map(
      (NULL < c_food and c_food <= 22.75) => 0.1672687933,
      (c_food > 22.75) => 0.0009371678,
      (c_food = NULL) => 0.0980500423, 0.0980500423),
   (c_pop_18_24_p = NULL) => 0.0340900260, 0.0209514415),
(f_mos_inq_banko_cm_lseen_d > 38.5) => -0.0007044032,
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0120470602, 0.0026928213);

// Tree: 172 
woFDN_FL__SD_lgt_172 := map(
(NULL < c_med_hhinc and c_med_hhinc <= 27732) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 34.6) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 123.5) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 0.5) => -0.0177869663,
         (f_hh_collections_ct_i > 0.5) => 
            map(
            (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.1482381890,
            (f_assocrisktype_i > 4.5) => -0.0101465880,
            (f_assocrisktype_i = NULL) => 0.0986822159, 0.0986822159),
         (f_hh_collections_ct_i = NULL) => 0.0512474944, 0.0512474944),
      (r_C13_Curr_Addr_LRes_d > 123.5) => 0.1735905740,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0743447130, 0.0743447130),
   (c_rnt500_p > 34.6) => -0.0193290686,
   (c_rnt500_p = NULL) => 0.0412937750, 0.0412937750),
(c_med_hhinc > 27732) => -0.0042725165,
(c_med_hhinc = NULL) => -0.0013393594, -0.0023007007);

// Tree: 173 
woFDN_FL__SD_lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0067166524,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 12.5) => 0.1715607952,
   (c_serv_empl > 12.5) => 
      map(
      (NULL < f_hh_bankruptcies_i and f_hh_bankruptcies_i <= 0.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 43.75) => 0.0933194749,
         (c_fammar_p > 43.75) => 
            map(
            (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 177.5) => 0.0139228051,
            (f_curraddrcrimeindex_i > 177.5) => 0.1533562485,
            (f_curraddrcrimeindex_i = NULL) => 0.0215683191, 0.0215683191),
         (c_fammar_p = NULL) => 0.0288751981, 0.0288751981),
      (f_hh_bankruptcies_i > 0.5) => -0.0261158770,
      (f_hh_bankruptcies_i = NULL) => 0.0122529687, 0.0122529687),
   (c_serv_empl = NULL) => 0.0183218382, 0.0183218382),
(f_rel_felony_count_i = NULL) => 0.0041723668, -0.0030730457);

// Tree: 174 
woFDN_FL__SD_lgt_174 := map(
(NULL < c_asian_lang and c_asian_lang <= 108.5) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 3760.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.15) => -0.0299632161,
      (c_pop_35_44_p > 13.15) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 17.35) => 
            map(
            (NULL < c_hval_200k_p and c_hval_200k_p <= 10.65) => -0.0100639174,
            (c_hval_200k_p > 10.65) => 0.0672045779,
            (c_hval_200k_p = NULL) => 0.0068681813, 0.0068681813),
         (c_pop_18_24_p > 17.35) => 0.1232966743,
         (c_pop_18_24_p = NULL) => 0.0103319406, 0.0103319406),
      (c_pop_35_44_p = NULL) => -0.0075977185, -0.0075977185),
   (f_liens_unrel_CJ_total_amt_i > 3760.5) => -0.0745514213,
   (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0101499562, -0.0101499562),
(c_asian_lang > 108.5) => 0.0110856570,
(c_asian_lang = NULL) => -0.0083575804, 0.0026176473);

// Tree: 175 
woFDN_FL__SD_lgt_175 := map(
(NULL < c_retail and c_retail <= 13.15) => -0.0118149472,
(c_retail > 13.15) => 
   map(
   (NULL < c_white_col and c_white_col <= 18.45) => 
      map(
      (NULL < c_finance and c_finance <= 2.4) => 0.1722003966,
      (c_finance > 2.4) => 0.0036628976,
      (c_finance = NULL) => 0.1025870818, 0.1025870818),
   (c_white_col > 18.45) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 7.5) => 0.0027688278,
      (f_hh_members_ct_d > 7.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 56.65) => -0.0648594483,
         (c_civ_emp > 56.65) => 0.1088245464,
         (c_civ_emp = NULL) => 0.0701178276, 0.0701178276),
      (f_hh_members_ct_d = NULL) => 0.0078965524, 0.0078965524),
   (c_white_col = NULL) => 0.0106348787, 0.0106348787),
(c_retail = NULL) => 0.0144207951, -0.0027345418);

// Tree: 176 
woFDN_FL__SD_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 0.0076575048,
(c_pop_18_24_p > 11.15) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 34.3) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 2.15) => 
         map(
         (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 0.5) => 
            map(
            (NULL < c_med_yearblt and c_med_yearblt <= 1975.5) => -0.0382565278,
            (c_med_yearblt > 1975.5) => 0.1509165776,
            (c_med_yearblt = NULL) => 0.0297275570, 0.0297275570),
         (f_divssnidmsrcurelcount_i > 0.5) => -0.0654810205,
         (f_divssnidmsrcurelcount_i = NULL) => -0.0497223594, -0.0497223594),
      (c_hval_175k_p > 2.15) => -0.0066816862,
      (c_hval_175k_p = NULL) => -0.0252685155, -0.0252685155),
   (c_hh3_p > 34.3) => 0.0980973565,
   (c_hh3_p = NULL) => -0.0223757371, -0.0223757371),
(c_pop_18_24_p = NULL) => 0.0144111627, 0.0012557871);

// Tree: 177 
woFDN_FL__SD_lgt_177 := map(
(NULL < C_INC_15K_P and C_INC_15K_P <= 35.05) => 
   map(
   (NULL < c_totsales and c_totsales <= 197722) => 0.0070355054,
   (c_totsales > 197722) => -0.0483587212,
   (c_totsales = NULL) => 0.0045594784, 0.0045594784),
(C_INC_15K_P > 35.05) => 
   map(
   (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','6: Other']) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0772174434) => -0.1132406345,
         (f_add_curr_nhood_VAC_pct_i > 0.0772174434) => 0.0356373371,
         (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0621198852, -0.0621198852),
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0468169257,
      (nf_seg_FraudPoint_3_0 = '') => -0.0246594008, -0.0246594008),
   (r_D34_unrel_liens_ct_i > 0.5) => -0.1265394339,
   (r_D34_unrel_liens_ct_i = NULL) => -0.0414712875, -0.0414712875),
(C_INC_15K_P = NULL) => -0.0050993322, 0.0032250386);

// Tree: 178 
woFDN_FL__SD_lgt_178 := map(
(NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 3.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 14.05) => -0.0047125150,
   (c_rnt1250_p > 14.05) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 532) => 0.0044865028,
      (r_pb_order_freq_d > 532) => 0.1350518076,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 18.95) => 0.0739229381,
         (c_hh1_p > 18.95) => 0.0083385794,
         (c_hh1_p = NULL) => 0.0329082422, 0.0329082422), 0.0184426129),
   (c_rnt1250_p = NULL) => -0.0026647961, 0.0020455449),
(f_rel_ageover50_count_d > 3.5) => -0.0615742186,
(f_rel_ageover50_count_d = NULL) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 9.35) => -0.0118617117,
   (C_INC_150K_P > 9.35) => 0.0891205447,
   (C_INC_150K_P = NULL) => 0.0073574920, 0.0073574920), 0.0002189629);

// Tree: 179 
woFDN_FL__SD_lgt_179 := map(
(NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 3.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 51) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 1.95) => -0.0685936402,
      (c_high_ed > 1.95) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 5.5) => -0.0019963566,
         (f_rel_homeover500_count_d > 5.5) => 0.0283926208,
         (f_rel_homeover500_count_d = NULL) => 0.0441091233, 0.0004051764),
      (c_high_ed = NULL) => -0.0003942347, -0.0003942347),
   (C_INC_15K_P > 51) => 0.0962176674,
   (C_INC_15K_P = NULL) => 0.0110657924, 0.0002985620),
(r_D34_UnRel_Lien60_Count_i > 3.5) => -0.0959431022,
(r_D34_UnRel_Lien60_Count_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 6.55) => 0.0930949027,
   (c_hval_250k_p > 6.55) => -0.0151272785,
   (c_hval_250k_p = NULL) => 0.0395195655, 0.0395195655), 0.0001707973);

// Tree: 180 
woFDN_FL__SD_lgt_180 := map(
(NULL < c_civ_emp and c_civ_emp <= 43.65) => -0.0372732527,
(c_civ_emp > 43.65) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 1.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 65.55) => 
         map(
         (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 21.5) => 0.0053165607,
         (f_rel_ageover30_count_d > 21.5) => -0.0264954574,
         (f_rel_ageover30_count_d = NULL) => 
            map(
            (NULL < c_no_car and c_no_car <= 94) => 0.1529495886,
            (c_no_car > 94) => -0.0106415380,
            (c_no_car = NULL) => 0.0532781738, 0.0532781738), 0.0047428643),
      (c_high_ed > 65.55) => -0.0512707636,
      (c_high_ed = NULL) => 0.0006006237, 0.0006006237),
   (f_srchfraudsrchcountmo_i > 1.5) => 0.0741799840,
   (f_srchfraudsrchcountmo_i = NULL) => -0.0089475003, 0.0010805209),
(c_civ_emp = NULL) => 0.0291014372, 0.0002116679);

// Tree: 181 
woFDN_FL__SD_lgt_181 := map(
(NULL < c_rnt250_p and c_rnt250_p <= 18.85) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.15) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 6.45) => -0.0176611540,
         (c_lowrent > 6.45) => 0.0484712595,
         (c_lowrent = NULL) => 0.0222470168, 0.0222470168),
      (k_estimated_income_d > 28500) => -0.0042256753,
      (k_estimated_income_d = NULL) => 0.0318682342, 0.0000184967),
   (c_unemp > 11.15) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 1.5) => 0.1040221588,
      (r_C18_invalid_addrs_per_adl_i > 1.5) => -0.0123599257,
      (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0671360336, 0.0671360336),
   (c_unemp = NULL) => 0.0011156730, 0.0011156730),
(c_rnt250_p > 18.85) => -0.0368660569,
(c_rnt250_p = NULL) => -0.0200463712, -0.0025813140);

// Tree: 182 
woFDN_FL__SD_lgt_182 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 18.85) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 0.0017445321,
   (f_inq_Other_count24_i > 3.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 1.5) => -0.0297799776,
      (f_assocrisktype_i > 1.5) => 0.1037637856,
      (f_assocrisktype_i = NULL) => 0.0455524016, 0.0455524016),
   (f_inq_Other_count24_i = NULL) => -0.0109009020, 0.0023437276),
(c_pop_0_5_p > 18.85) => 
   map(
   (NULL < c_construction and c_construction <= 6.25) => -0.1463888973,
   (c_construction > 6.25) => 0.0047281057,
   (c_construction = NULL) => -0.0715784998, -0.0715784998),
(c_pop_0_5_p = NULL) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 1.5) => -0.0395049982,
   (f_hh_tot_derog_i > 1.5) => 0.1496206644,
   (f_hh_tot_derog_i = NULL) => -0.0053573091, -0.0053573091), 0.0015790886);

// Tree: 183 
woFDN_FL__SD_lgt_183 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 15.75) => 0.0742431849,
   (c_fammar_p > 15.75) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => -0.0058573532,
      (k_inq_per_ssn_i > 7.5) => 
         map(
         (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 0.1548945973,
         (f_inq_count_i > 7.5) => 
            map(
            (NULL < c_murders and c_murders <= 84) => 0.0630587788,
            (c_murders > 84) => -0.0901814469,
            (c_murders = NULL) => 0.0013052550, 0.0013052550),
         (f_inq_count_i = NULL) => 0.0448359243, 0.0448359243),
      (k_inq_per_ssn_i = NULL) => -0.0050741706, -0.0050741706),
   (c_fammar_p = NULL) => -0.0041354835, -0.0045615863),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0736511435,
(f_srchfraudsrchcountyr_i = NULL) => 0.0088999676, -0.0049715451);

// Tree: 184 
woFDN_FL__SD_lgt_184 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => -0.0014746883,
(f_util_adl_count_n > 7.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 35500) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.75) => 0.0238244872,
      (c_pop_55_64_p > 9.75) => 0.1730446417,
      (c_pop_55_64_p = NULL) => 0.0891547041, 0.0891547041),
   (k_estimated_income_d > 35500) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 20.65) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 21.2) => -0.0460958342,
         (c_oldhouse > 21.2) => 0.1816735717,
         (c_oldhouse = NULL) => 0.0859068896, 0.0859068896),
      (c_lowinc > 20.65) => -0.0571945178,
      (c_lowinc = NULL) => 0.0160201558, 0.0160201558),
   (k_estimated_income_d = NULL) => 0.0436082772, 0.0436082772),
(f_util_adl_count_n = NULL) => 0.0020668323, 0.0005508789);

// Tree: 185 
woFDN_FL__SD_lgt_185 := map(
(NULL < c_for_sale and c_for_sale <= 163.5) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 6.45) => -0.0447647411,
      (c_pop_0_5_p > 6.45) => 
         map(
         (NULL < c_retired and c_retired <= 7.6) => -0.0057762489,
         (c_retired > 7.6) => 
            map(
            (NULL < c_blue_col and c_blue_col <= 12.55) => 0.0372907477,
            (c_blue_col > 12.55) => 0.2234144780,
            (c_blue_col = NULL) => 0.1472063365, 0.1472063365),
         (c_retired = NULL) => 0.0948910482, 0.0948910482),
      (c_pop_0_5_p = NULL) => 0.0546949170, 0.0546949170),
   (r_I61_inq_collection_recency_d > 4.5) => 0.0067938965,
   (r_I61_inq_collection_recency_d = NULL) => -0.0051026893, 0.0079806925),
(c_for_sale > 163.5) => -0.0215495952,
(c_for_sale = NULL) => -0.0022077073, 0.0024617416);

// Tree: 186 
woFDN_FL__SD_lgt_186 := map(
(NULL < C_INC_75K_P and C_INC_75K_P <= 14.45) => 
   map(
   (NULL < c_robbery and c_robbery <= 117.5) => 0.0042747072,
   (c_robbery > 117.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 4.5) => 0.0308089250,
      (f_rel_homeover300_count_d > 4.5) => 
         map(
         (NULL < c_retired2 and c_retired2 <= 113.5) => 0.0471223787,
         (c_retired2 > 113.5) => 
            map(
            (NULL < c_retired and c_retired <= 16.8) => 0.3735356329,
            (c_retired > 16.8) => 0.0758135811,
            (c_retired = NULL) => 0.2018564935, 0.2018564935),
         (c_retired2 = NULL) => 0.1139948511, 0.1139948511),
      (f_rel_homeover300_count_d = NULL) => 0.0509694285, 0.0509694285),
   (c_robbery = NULL) => 0.0212363577, 0.0212363577),
(C_INC_75K_P > 14.45) => -0.0066557298,
(C_INC_75K_P = NULL) => 0.0143637997, 0.0020171208);

// Tree: 187 
woFDN_FL__SD_lgt_187 := map(
(NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 1.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 52.5) => 
      map(
      (NULL < c_child and c_child <= 30.8) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => -0.1091226321,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0032100894,
         (nf_seg_FraudPoint_3_0 = '') => -0.0260644987, -0.0260644987),
      (c_child > 30.8) => 0.1227470876,
      (c_child = NULL) => -0.0058074241, -0.0058074241),
   (k_comb_age_d > 52.5) => 0.2078058240,
   (k_comb_age_d = NULL) => 0.0238876911, 0.0238876911),
(r_C20_email_verification_d > 1.5) => -0.1000685790,
(r_C20_email_verification_d = NULL) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => -0.0004651830,
   (f_rel_bankrupt_count_i > 7.5) => -0.0702538565,
   (f_rel_bankrupt_count_i = NULL) => -0.0028386717, -0.0013613468), -0.0017264073);

// Tree: 188 
woFDN_FL__SD_lgt_188 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 29.75) => -0.0224567201,
(C_OWNOCC_P > 29.75) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 4.5) => -0.0422852294,
   (f_mos_inq_banko_om_lseen_d > 4.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 0.0835306028,
      (r_F00_dob_score_d > 65) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0006128954,
         (f_srchvelocityrisktype_i > 4.5) => 
            map(
            (NULL < k_comb_age_d and k_comb_age_d <= 23.5) => 0.1317845965,
            (k_comb_age_d > 23.5) => 0.0220028903,
            (k_comb_age_d = NULL) => 0.0284983080, 0.0284983080),
         (f_srchvelocityrisktype_i = NULL) => 0.0040032191, 0.0040032191),
      (r_F00_dob_score_d = NULL) => -0.0167304200, 0.0039988404),
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0114037075, 0.0018469749),
(C_OWNOCC_P = NULL) => -0.0248854913, -0.0017626177);

// Tree: 189 
woFDN_FL__SD_lgt_189 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 108500) => 
   map(
   (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 0.5) => 
      map(
      (NULL < c_hval_1001k_p and c_hval_1001k_p <= 36.5) => -0.0024775992,
      (c_hval_1001k_p > 36.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 0.25) => 0.0202442746,
         (c_hh7p_p > 0.25) => 0.2131200734,
         (c_hh7p_p = NULL) => 0.0650991115, 0.0650991115),
      (c_hval_1001k_p = NULL) => -0.0194850065, -0.0014310026),
   (r_S65_SSN_Problem_i > 0.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 32.5) => 0.0354456800,
      (c_no_labfor > 32.5) => -0.0583567161,
      (c_no_labfor = NULL) => -0.0446373181, -0.0446373181),
   (r_S65_SSN_Problem_i = NULL) => -0.0034677684, -0.0034677684),
(k_estimated_income_d > 108500) => 0.1529677319,
(k_estimated_income_d = NULL) => -0.0088555261, -0.0028800192);

// Tree: 190 
woFDN_FL__SD_lgt_190 := map(
(NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 7.5) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 3.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 17849) => -0.0942932678,
         (r_A46_Curr_AVM_AutoVal_d > 17849) => -0.0050792762,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0066984297, -0.0062748421),
      (f_inq_PrepaidCards_count_i > 2.5) => 0.0715946961,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0059474740, -0.0059474740),
   (f_inq_Banking_count24_i > 3.5) => 
      map(
      (NULL < c_professional and c_professional <= 2.85) => 0.1459398175,
      (c_professional > 2.85) => 0.0097406757,
      (c_professional = NULL) => 0.0577596039, 0.0577596039),
   (f_inq_Banking_count24_i = NULL) => -0.0051389311, -0.0051389311),
(f_inq_Banking_count24_i > 7.5) => -0.1087631961,
(f_inq_Banking_count24_i = NULL) => -0.0060919541, -0.0056444549);

// Tree: 191 
woFDN_FL__SD_lgt_191 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2313064621) => -0.0199517592,
   (f_add_curr_mobility_index_i > 0.2313064621) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 18.4) => 0.1844418918,
      (c_lowinc > 18.4) => 
         map(
         (NULL < c_rnt1500_p and c_rnt1500_p <= 4.45) => -0.0524612259,
         (c_rnt1500_p > 4.45) => 0.0786033313,
         (c_rnt1500_p = NULL) => 0.0120140805, 0.0120140805),
      (c_lowinc = NULL) => 0.0622644712, 0.0622644712),
   (f_add_curr_mobility_index_i = NULL) => 0.0380637260, 0.0380637260),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 30.75) => -0.0003137608,
   (c_manufacturing > 30.75) => -0.0665915655,
   (c_manufacturing = NULL) => -0.0317573974, -0.0032352873),
(r_C10_M_Hdr_FS_d = NULL) => -0.0389841279, -0.0026919003);

// Tree: 192 
woFDN_FL__SD_lgt_192 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 5.25) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 224) => 0.0756825775,
   (r_D32_Mos_Since_Fel_LS_d > 224) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 56.35) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 166) => 
            map(
            (NULL < c_popover18 and c_popover18 <= 682.5) => 0.0444269382,
            (c_popover18 > 682.5) => -0.0435971920,
            (c_popover18 = NULL) => -0.0260261564, -0.0260261564),
         (f_prevaddrageoldest_d > 166) => -0.1010028979,
         (f_prevaddrageoldest_d = NULL) => -0.0419955228, -0.0419955228),
      (c_fammar_p > 56.35) => -0.0101167959,
      (c_fammar_p = NULL) => -0.0128388025, -0.0128388025),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0042615451, -0.0120735457),
(c_femdiv_p > 5.25) => 0.0118010863,
(c_femdiv_p = NULL) => -0.0114896192, -0.0035752063);

// Tree: 193 
woFDN_FL__SD_lgt_193 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 2) => -0.0671711890,
(r_I60_inq_comm_recency_d > 2) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 236.4) => -0.0060997767,
   (c_housingcpi > 236.4) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 260.5) => 0.0037547755,
      (r_C13_max_lres_d > 260.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 191.5) => 
            map(
            (NULL < c_asian_lang and c_asian_lang <= 137) => -0.0534124541,
            (c_asian_lang > 137) => 0.0951997026,
            (c_asian_lang = NULL) => 0.0469616583, 0.0469616583),
         (c_sub_bus > 191.5) => 0.2213473062,
         (c_sub_bus = NULL) => 0.0719438719, 0.0719438719),
      (r_C13_max_lres_d = NULL) => 0.0150351279, 0.0150351279),
   (c_housingcpi = NULL) => -0.0244130565, -0.0029077393),
(r_I60_inq_comm_recency_d = NULL) => 0.0001106528, -0.0031700253);

// Tree: 194 
woFDN_FL__SD_lgt_194 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 339.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 36.25) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 0.0045869162,
      (r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0632218661,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0040378834, 0.0040378834),
   (c_hval_20k_p > 36.25) => 0.0995587940,
   (c_hval_20k_p = NULL) => -0.0227622891, 0.0039175998),
(f_M_Bureau_ADL_FS_noTU_d > 339.5) => 
   map(
   (NULL < c_rape and c_rape <= 64.5) => -0.0702387903,
   (c_rape > 64.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 28.25) => -0.0162268999,
      (C_INC_75K_P > 28.25) => 0.1437192684,
      (C_INC_75K_P = NULL) => -0.0081732157, -0.0081732157),
   (c_rape = NULL) => -0.0346138680, -0.0346138680),
(f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0048087681, -0.0014121597);

// Tree: 195 
woFDN_FL__SD_lgt_195 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 3.95) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 12.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 1.5) => 0.0145506807,
      (f_assocrisktype_i > 1.5) => 0.1322701274,
      (f_assocrisktype_i = NULL) => 0.0479150159, 0.0479150159),
   (r_C21_M_Bureau_ADL_FS_d > 12.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 101.5) => -0.0303493463,
      (c_many_cars > 101.5) => 0.0040332631,
      (c_many_cars = NULL) => -0.0107409913, -0.0107409913),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0395408290, -0.0092736592),
(c_rnt1250_p > 3.95) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 4.55) => 0.1258602472,
   (c_rnt1250_p > 4.55) => 0.0094870184,
   (c_rnt1250_p = NULL) => 0.0122928474, 0.0122928474),
(c_rnt1250_p = NULL) => 0.0284148788, 0.0017577633);

// Tree: 196 
woFDN_FL__SD_lgt_196 := map(
(NULL < c_lowrent and c_lowrent <= 90.35) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 74.85) => -0.0055593161,
   (c_rnt1000_p > 74.85) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 8.5) => 0.0267422206,
      (f_rel_homeover50_count_d > 8.5) => 0.1923673093,
      (f_rel_homeover50_count_d = NULL) => 0.0910259308, 0.0910259308),
   (c_rnt1000_p = NULL) => -0.0037841154, -0.0037841154),
(c_lowrent > 90.35) => 
   map(
   (NULL < c_food and c_food <= 1.05) => 0.2004073554,
   (c_food > 1.05) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 321) => -0.0502442060,
      (f_M_Bureau_ADL_FS_all_d > 321) => 0.1931493642,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0295569645, 0.0295569645),
   (c_food = NULL) => 0.0703360702, 0.0703360702),
(c_lowrent = NULL) => 0.0013270930, -0.0022397269);

// Tree: 197 
woFDN_FL__SD_lgt_197 := map(
(NULL < c_rest_indx and c_rest_indx <= 112.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 10.25) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0016171852,
      (f_assocrisktype_i > 4.5) => -0.0574107417,
      (f_assocrisktype_i = NULL) => -0.0087051344, -0.0087051344),
   (c_hh4_p > 10.25) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 186) => 0.0209125978,
      (f_curraddrcartheftindex_i > 186) => 
         map(
         (NULL < c_no_car and c_no_car <= 167.5) => 0.2162918442,
         (c_no_car > 167.5) => 0.0188359936,
         (c_no_car = NULL) => 0.0936298764, 0.0936298764),
      (f_curraddrcartheftindex_i = NULL) => 0.0228691165, 0.0228691165),
   (c_hh4_p = NULL) => 0.0138681260, 0.0138681260),
(c_rest_indx > 112.5) => -0.0152298415,
(c_rest_indx = NULL) => 0.0015204670, 0.0010275641);

// Tree: 198 
woFDN_FL__SD_lgt_198 := map(
(NULL < c_unempl and c_unempl <= 188.5) => 
   map(
   (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 
      map(
      (NULL < f_mos_foreclosure_lseen_d and f_mos_foreclosure_lseen_d <= 20.5) => 0.1512111994,
      (f_mos_foreclosure_lseen_d > 20.5) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 24.5) => -0.0322063560,
         (r_A50_pb_average_dollars_d > 24.5) => 0.0056714532,
         (r_A50_pb_average_dollars_d = NULL) => 0.0013365168, 0.0013365168),
      (f_mos_foreclosure_lseen_d = NULL) => 0.0089264034, 0.0021096296),
   (k_inq_addrs_per_ssn_i > 2.5) => -0.0714768077,
   (k_inq_addrs_per_ssn_i = NULL) => 0.0016102286, 0.0016102286),
(c_unempl > 188.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 188) => 0.1093941916,
   (f_M_Bureau_ADL_FS_all_d > 188) => -0.0130036731,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0540024572, 0.0540024572),
(c_unempl = NULL) => -0.0171989267, 0.0017157727);

// Tree: 199 
woFDN_FL__SD_lgt_199 := map(
(NULL < c_hh6_p and c_hh6_p <= 11.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 18.5) => -0.0012585606,
   (r_D30_Derog_Count_i > 18.5) => -0.0770955807,
   (r_D30_Derog_Count_i = NULL) => -0.0222127842, -0.0017607577),
(c_hh6_p > 11.05) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 54.5) => -0.0694882580,
   (c_rest_indx > 54.5) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 0.1684705235,
      (r_Prop_Owner_History_d > 0.5) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 74750) => -0.0041928816,
         (f_prevaddrmedianincome_d > 74750) => 0.1807155462,
         (f_prevaddrmedianincome_d = NULL) => 0.0402562597, 0.0402562597),
      (r_Prop_Owner_History_d = NULL) => 0.0739011374, 0.0739011374),
   (c_rest_indx = NULL) => 0.0492364892, 0.0492364892),
(c_hh6_p = NULL) => -0.0188861008, -0.0007962661);

// Tree: 200 
woFDN_FL__SD_lgt_200 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 40.5) => -0.0867143431,
(f_mos_inq_banko_am_lseen_d > 40.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 178.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 0.35) => 
         map(
         (NULL < c_food and c_food <= 17.05) => 0.1295566535,
         (c_food > 17.05) => 0.0039289495,
         (c_food = NULL) => 0.0672986763, 0.0672986763),
      (C_INC_125K_P > 0.35) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 19.6) => -0.0818569881,
         (c_fammar_p > 19.6) => 0.0026821224,
         (c_fammar_p = NULL) => 0.0022665234, 0.0022665234),
      (C_INC_125K_P = NULL) => 0.0029410813, 0.0029410813),
   (c_serv_empl > 178.5) => -0.0244399062,
   (c_serv_empl = NULL) => -0.0561723169, -0.0010373620),
(f_mos_inq_banko_am_lseen_d = NULL) => 0.0175178377, -0.0027404885);

// Tree: 201 
woFDN_FL__SD_lgt_201 := map(
(NULL < f_varmsrcssncount_i and f_varmsrcssncount_i <= 1.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 47.85) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 99.5) => 0.0076573880,
      (c_relig_indx > 99.5) => -0.0152308394,
      (c_relig_indx = NULL) => -0.0046532562, -0.0046532562),
   (c_hval_100k_p > 47.85) => 0.1021502146,
   (c_hval_100k_p = NULL) => 0.0029266132, -0.0039101546),
(f_varmsrcssncount_i > 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0081216921) => -0.0734455345,
   (f_add_curr_nhood_VAC_pct_i > 0.0081216921) => 
      map(
      (NULL < c_white_col and c_white_col <= 30.6) => -0.0277562865,
      (c_white_col > 30.6) => 0.2419623128,
      (c_white_col = NULL) => 0.1396552579, 0.1396552579),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0761348294, 0.0761348294),
(f_varmsrcssncount_i = NULL) => 0.0000502842, -0.0025676588);

// Tree: 202 
woFDN_FL__SD_lgt_202 := map(
(NULL < c_hval_1001k_p and c_hval_1001k_p <= 68.3) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 14.5) => -0.0348684057,
   (f_mos_inq_banko_om_fseen_d > 14.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.05) => -0.0205768075,
         (c_pop_35_44_p > 14.05) => 
            map(
            (NULL < c_unattach and c_unattach <= 63.5) => 0.3521487067,
            (c_unattach > 63.5) => 0.0755376858,
            (c_unattach = NULL) => 0.1110174842, 0.1110174842),
         (c_pop_35_44_p = NULL) => 0.0538871667, 0.0538871667),
      (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0027560577,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0009270885, 0.0009270885),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0212885496, -0.0014518185),
(c_hval_1001k_p > 68.3) => 0.1314722051,
(c_hval_1001k_p = NULL) => 0.0349568328, 0.0002219920);

// Tree: 203 
woFDN_FL__SD_lgt_203 := map(
(NULL < c_fammar_p and c_fammar_p <= 93.15) => 
   map(
   (NULL < r_D31_bk_chapter_n and r_D31_bk_chapter_n <= 9) => -0.0237239706,
   (r_D31_bk_chapter_n > 9) => -0.0428537934,
   (r_D31_bk_chapter_n = NULL) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 4.5) => 0.0028658657,
      (r_E57_br_source_count_d > 4.5) => 
         map(
         (NULL < c_food and c_food <= 28.15) => 0.0408348680,
         (c_food > 28.15) => 0.2310606182,
         (c_food = NULL) => 0.0863373730, 0.0863373730),
      (r_E57_br_source_count_d = NULL) => 
         map(
         (NULL < c_child and c_child <= 24.65) => 0.0652350019,
         (c_child > 24.65) => -0.0497726424,
         (c_child = NULL) => 0.0094060483, 0.0094060483), 0.0054186623), 0.0019179180),
(c_fammar_p > 93.15) => -0.0424141104,
(c_fammar_p = NULL) => -0.0260491408, -0.0025733064);

// Tree: 204 
woFDN_FL__SD_lgt_204 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 198.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 0.0185192360,
      (r_C14_Addr_Stability_v2_d > 1.5) => 0.0021565664,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0030725325, 0.0030725325),
   (f_prevaddrcartheftindex_i > 198.5) => -0.1176096135,
   (f_prevaddrcartheftindex_i = NULL) => 0.0024339507, 0.0024339507),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 41.35) => -0.0761680555,
   (c_med_age > 41.35) => 0.0145484839,
   (c_med_age = NULL) => -0.0603778046, -0.0603778046),
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 101) => 0.0425645446,
   (c_robbery > 101) => -0.0692567237,
   (c_robbery = NULL) => -0.0117486429, -0.0117486429), 0.0008585314);

// Tree: 205 
woFDN_FL__SD_lgt_205 := map(
(NULL < c_for_sale and c_for_sale <= 108.5) => -0.0095460214,
(c_for_sale > 108.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21111.5) => 0.1148349624,
   (r_A46_Curr_AVM_AutoVal_d > 21111.5) => 0.0119765513,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 27.5) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 5.5) => 0.0246197374,
         (f_corrssnnamecount_d > 5.5) => 
            map(
            (NULL < c_rich_nfam and c_rich_nfam <= 133.5) => 0.2220104457,
            (c_rich_nfam > 133.5) => 0.0385452732,
            (c_rich_nfam = NULL) => 0.1237255318, 0.1237255318),
         (f_corrssnnamecount_d = NULL) => 0.0563335916, 0.0563335916),
      (c_born_usa > 27.5) => 0.0074221183,
      (c_born_usa = NULL) => 0.0147849115, 0.0147849115), 0.0139521345),
(c_for_sale = NULL) => -0.0134469384, 0.0017409460);

// Final Score Sum 

   woFDN_FL__SD_lgt := sum(
      woFDN_FL__SD_lgt_0, woFDN_FL__SD_lgt_1, woFDN_FL__SD_lgt_2, woFDN_FL__SD_lgt_3, woFDN_FL__SD_lgt_4, 
      woFDN_FL__SD_lgt_5, woFDN_FL__SD_lgt_6, woFDN_FL__SD_lgt_7, woFDN_FL__SD_lgt_8, woFDN_FL__SD_lgt_9, 
      woFDN_FL__SD_lgt_10, woFDN_FL__SD_lgt_11, woFDN_FL__SD_lgt_12, woFDN_FL__SD_lgt_13, woFDN_FL__SD_lgt_14, 
      woFDN_FL__SD_lgt_15, woFDN_FL__SD_lgt_16, woFDN_FL__SD_lgt_17, woFDN_FL__SD_lgt_18, woFDN_FL__SD_lgt_19, 
      woFDN_FL__SD_lgt_20, woFDN_FL__SD_lgt_21, woFDN_FL__SD_lgt_22, woFDN_FL__SD_lgt_23, woFDN_FL__SD_lgt_24, 
      woFDN_FL__SD_lgt_25, woFDN_FL__SD_lgt_26, woFDN_FL__SD_lgt_27, woFDN_FL__SD_lgt_28, woFDN_FL__SD_lgt_29, 
      woFDN_FL__SD_lgt_30, woFDN_FL__SD_lgt_31, woFDN_FL__SD_lgt_32, woFDN_FL__SD_lgt_33, woFDN_FL__SD_lgt_34, 
      woFDN_FL__SD_lgt_35, woFDN_FL__SD_lgt_36, woFDN_FL__SD_lgt_37, woFDN_FL__SD_lgt_38, woFDN_FL__SD_lgt_39, 
      woFDN_FL__SD_lgt_40, woFDN_FL__SD_lgt_41, woFDN_FL__SD_lgt_42, woFDN_FL__SD_lgt_43, woFDN_FL__SD_lgt_44, 
      woFDN_FL__SD_lgt_45, woFDN_FL__SD_lgt_46, woFDN_FL__SD_lgt_47, woFDN_FL__SD_lgt_48, woFDN_FL__SD_lgt_49, 
      woFDN_FL__SD_lgt_50, woFDN_FL__SD_lgt_51, woFDN_FL__SD_lgt_52, woFDN_FL__SD_lgt_53, woFDN_FL__SD_lgt_54, 
      woFDN_FL__SD_lgt_55, woFDN_FL__SD_lgt_56, woFDN_FL__SD_lgt_57, woFDN_FL__SD_lgt_58, woFDN_FL__SD_lgt_59, 
      woFDN_FL__SD_lgt_60, woFDN_FL__SD_lgt_61, woFDN_FL__SD_lgt_62, woFDN_FL__SD_lgt_63, woFDN_FL__SD_lgt_64, 
      woFDN_FL__SD_lgt_65, woFDN_FL__SD_lgt_66, woFDN_FL__SD_lgt_67, woFDN_FL__SD_lgt_68, woFDN_FL__SD_lgt_69, 
      woFDN_FL__SD_lgt_70, woFDN_FL__SD_lgt_71, woFDN_FL__SD_lgt_72, woFDN_FL__SD_lgt_73, woFDN_FL__SD_lgt_74, 
      woFDN_FL__SD_lgt_75, woFDN_FL__SD_lgt_76, woFDN_FL__SD_lgt_77, woFDN_FL__SD_lgt_78, woFDN_FL__SD_lgt_79, 
      woFDN_FL__SD_lgt_80, woFDN_FL__SD_lgt_81, woFDN_FL__SD_lgt_82, woFDN_FL__SD_lgt_83, woFDN_FL__SD_lgt_84, 
      woFDN_FL__SD_lgt_85, woFDN_FL__SD_lgt_86, woFDN_FL__SD_lgt_87, woFDN_FL__SD_lgt_88, woFDN_FL__SD_lgt_89, 
      woFDN_FL__SD_lgt_90, woFDN_FL__SD_lgt_91, woFDN_FL__SD_lgt_92, woFDN_FL__SD_lgt_93, woFDN_FL__SD_lgt_94, 
      woFDN_FL__SD_lgt_95, woFDN_FL__SD_lgt_96, woFDN_FL__SD_lgt_97, woFDN_FL__SD_lgt_98, woFDN_FL__SD_lgt_99, 
      woFDN_FL__SD_lgt_100, woFDN_FL__SD_lgt_101, woFDN_FL__SD_lgt_102, woFDN_FL__SD_lgt_103, woFDN_FL__SD_lgt_104, 
      woFDN_FL__SD_lgt_105, woFDN_FL__SD_lgt_106, woFDN_FL__SD_lgt_107, woFDN_FL__SD_lgt_108, woFDN_FL__SD_lgt_109, 
      woFDN_FL__SD_lgt_110, woFDN_FL__SD_lgt_111, woFDN_FL__SD_lgt_112, woFDN_FL__SD_lgt_113, woFDN_FL__SD_lgt_114, 
      woFDN_FL__SD_lgt_115, woFDN_FL__SD_lgt_116, woFDN_FL__SD_lgt_117, woFDN_FL__SD_lgt_118, woFDN_FL__SD_lgt_119, 
      woFDN_FL__SD_lgt_120, woFDN_FL__SD_lgt_121, woFDN_FL__SD_lgt_122, woFDN_FL__SD_lgt_123, woFDN_FL__SD_lgt_124, 
      woFDN_FL__SD_lgt_125, woFDN_FL__SD_lgt_126, woFDN_FL__SD_lgt_127, woFDN_FL__SD_lgt_128, woFDN_FL__SD_lgt_129, 
      woFDN_FL__SD_lgt_130, woFDN_FL__SD_lgt_131, woFDN_FL__SD_lgt_132, woFDN_FL__SD_lgt_133, woFDN_FL__SD_lgt_134, 
      woFDN_FL__SD_lgt_135, woFDN_FL__SD_lgt_136, woFDN_FL__SD_lgt_137, woFDN_FL__SD_lgt_138, woFDN_FL__SD_lgt_139, 
      woFDN_FL__SD_lgt_140, woFDN_FL__SD_lgt_141, woFDN_FL__SD_lgt_142, woFDN_FL__SD_lgt_143, woFDN_FL__SD_lgt_144, 
      woFDN_FL__SD_lgt_145, woFDN_FL__SD_lgt_146, woFDN_FL__SD_lgt_147, woFDN_FL__SD_lgt_148, woFDN_FL__SD_lgt_149, 
      woFDN_FL__SD_lgt_150, woFDN_FL__SD_lgt_151, woFDN_FL__SD_lgt_152, woFDN_FL__SD_lgt_153, woFDN_FL__SD_lgt_154, 
      woFDN_FL__SD_lgt_155, woFDN_FL__SD_lgt_156, woFDN_FL__SD_lgt_157, woFDN_FL__SD_lgt_158, woFDN_FL__SD_lgt_159, 
      woFDN_FL__SD_lgt_160, woFDN_FL__SD_lgt_161, woFDN_FL__SD_lgt_162, woFDN_FL__SD_lgt_163, woFDN_FL__SD_lgt_164, 
      woFDN_FL__SD_lgt_165, woFDN_FL__SD_lgt_166, woFDN_FL__SD_lgt_167, woFDN_FL__SD_lgt_168, woFDN_FL__SD_lgt_169, 
      woFDN_FL__SD_lgt_170, woFDN_FL__SD_lgt_171, woFDN_FL__SD_lgt_172, woFDN_FL__SD_lgt_173, woFDN_FL__SD_lgt_174, 
      woFDN_FL__SD_lgt_175, woFDN_FL__SD_lgt_176, woFDN_FL__SD_lgt_177, woFDN_FL__SD_lgt_178, woFDN_FL__SD_lgt_179, 
      woFDN_FL__SD_lgt_180, woFDN_FL__SD_lgt_181, woFDN_FL__SD_lgt_182, woFDN_FL__SD_lgt_183, woFDN_FL__SD_lgt_184, 
      woFDN_FL__SD_lgt_185, woFDN_FL__SD_lgt_186, woFDN_FL__SD_lgt_187, woFDN_FL__SD_lgt_188, woFDN_FL__SD_lgt_189, 
      woFDN_FL__SD_lgt_190, woFDN_FL__SD_lgt_191, woFDN_FL__SD_lgt_192, woFDN_FL__SD_lgt_193, woFDN_FL__SD_lgt_194, 
      woFDN_FL__SD_lgt_195, woFDN_FL__SD_lgt_196, woFDN_FL__SD_lgt_197, woFDN_FL__SD_lgt_198, woFDN_FL__SD_lgt_199, 
      woFDN_FL__SD_lgt_200, woFDN_FL__SD_lgt_201, woFDN_FL__SD_lgt_202, woFDN_FL__SD_lgt_203, woFDN_FL__SD_lgt_204, 
      woFDN_FL__SD_lgt_205); 
 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_woFDN_LGT := woFDN_FL__SD_lgt;
			
self.final_score_0	:= 	woFDN_FL__SD_lgt_0	;
self.final_score_1	:= 	woFDN_FL__SD_lgt_1	;
self.final_score_2	:= 	woFDN_FL__SD_lgt_2	;
self.final_score_3	:= 	woFDN_FL__SD_lgt_3	;
self.final_score_4	:= 	woFDN_FL__SD_lgt_4	;
self.final_score_5	:= 	woFDN_FL__SD_lgt_5	;
self.final_score_6	:= 	woFDN_FL__SD_lgt_6	;
self.final_score_7	:= 	woFDN_FL__SD_lgt_7	;
self.final_score_8	:= 	woFDN_FL__SD_lgt_8	;
self.final_score_9	:= 	woFDN_FL__SD_lgt_9	;
self.final_score_10	:= 	woFDN_FL__SD_lgt_10	;
self.final_score_11	:= 	woFDN_FL__SD_lgt_11	;
self.final_score_12	:= 	woFDN_FL__SD_lgt_12	;
self.final_score_13	:= 	woFDN_FL__SD_lgt_13	;
self.final_score_14	:= 	woFDN_FL__SD_lgt_14	;
self.final_score_15	:= 	woFDN_FL__SD_lgt_15	;
self.final_score_16	:= 	woFDN_FL__SD_lgt_16	;
self.final_score_17	:= 	woFDN_FL__SD_lgt_17	;
self.final_score_18	:= 	woFDN_FL__SD_lgt_18	;
self.final_score_19	:= 	woFDN_FL__SD_lgt_19	;
self.final_score_20	:= 	woFDN_FL__SD_lgt_20	;
self.final_score_21	:= 	woFDN_FL__SD_lgt_21	;
self.final_score_22	:= 	woFDN_FL__SD_lgt_22	;
self.final_score_23	:= 	woFDN_FL__SD_lgt_23	;
self.final_score_24	:= 	woFDN_FL__SD_lgt_24	;
self.final_score_25	:= 	woFDN_FL__SD_lgt_25	;
self.final_score_26	:= 	woFDN_FL__SD_lgt_26	;
self.final_score_27	:= 	woFDN_FL__SD_lgt_27	;
self.final_score_28	:= 	woFDN_FL__SD_lgt_28	;
self.final_score_29	:= 	woFDN_FL__SD_lgt_29	;
self.final_score_30	:= 	woFDN_FL__SD_lgt_30	;
self.final_score_31	:= 	woFDN_FL__SD_lgt_31	;
self.final_score_32	:= 	woFDN_FL__SD_lgt_32	;
self.final_score_33	:= 	woFDN_FL__SD_lgt_33	;
self.final_score_34	:= 	woFDN_FL__SD_lgt_34	;
self.final_score_35	:= 	woFDN_FL__SD_lgt_35	;
self.final_score_36	:= 	woFDN_FL__SD_lgt_36	;
self.final_score_37	:= 	woFDN_FL__SD_lgt_37	;
self.final_score_38	:= 	woFDN_FL__SD_lgt_38	;
self.final_score_39	:= 	woFDN_FL__SD_lgt_39	;
self.final_score_40	:= 	woFDN_FL__SD_lgt_40	;
self.final_score_41	:= 	woFDN_FL__SD_lgt_41	;
self.final_score_42	:= 	woFDN_FL__SD_lgt_42	;
self.final_score_43	:= 	woFDN_FL__SD_lgt_43	;
self.final_score_44	:= 	woFDN_FL__SD_lgt_44	;
self.final_score_45	:= 	woFDN_FL__SD_lgt_45	;
self.final_score_46	:= 	woFDN_FL__SD_lgt_46	;
self.final_score_47	:= 	woFDN_FL__SD_lgt_47	;
self.final_score_48	:= 	woFDN_FL__SD_lgt_48	;
self.final_score_49	:= 	woFDN_FL__SD_lgt_49	;
self.final_score_50	:= 	woFDN_FL__SD_lgt_50	;
self.final_score_51	:= 	woFDN_FL__SD_lgt_51	;
self.final_score_52	:= 	woFDN_FL__SD_lgt_52	;
self.final_score_53	:= 	woFDN_FL__SD_lgt_53	;
self.final_score_54	:= 	woFDN_FL__SD_lgt_54	;
self.final_score_55	:= 	woFDN_FL__SD_lgt_55	;
self.final_score_56	:= 	woFDN_FL__SD_lgt_56	;
self.final_score_57	:= 	woFDN_FL__SD_lgt_57	;
self.final_score_58	:= 	woFDN_FL__SD_lgt_58	;
self.final_score_59	:= 	woFDN_FL__SD_lgt_59	;
self.final_score_60	:= 	woFDN_FL__SD_lgt_60	;
self.final_score_61	:= 	woFDN_FL__SD_lgt_61	;
self.final_score_62	:= 	woFDN_FL__SD_lgt_62	;
self.final_score_63	:= 	woFDN_FL__SD_lgt_63	;
self.final_score_64	:= 	woFDN_FL__SD_lgt_64	;
self.final_score_65	:= 	woFDN_FL__SD_lgt_65	;
self.final_score_66	:= 	woFDN_FL__SD_lgt_66	;
self.final_score_67	:= 	woFDN_FL__SD_lgt_67	;
self.final_score_68	:= 	woFDN_FL__SD_lgt_68	;
self.final_score_69	:= 	woFDN_FL__SD_lgt_69	;
self.final_score_70	:= 	woFDN_FL__SD_lgt_70	;
self.final_score_71	:= 	woFDN_FL__SD_lgt_71	;
self.final_score_72	:= 	woFDN_FL__SD_lgt_72	;
self.final_score_73	:= 	woFDN_FL__SD_lgt_73	;
self.final_score_74	:= 	woFDN_FL__SD_lgt_74	;
self.final_score_75	:= 	woFDN_FL__SD_lgt_75	;
self.final_score_76	:= 	woFDN_FL__SD_lgt_76	;
self.final_score_77	:= 	woFDN_FL__SD_lgt_77	;
self.final_score_78	:= 	woFDN_FL__SD_lgt_78	;
self.final_score_79	:= 	woFDN_FL__SD_lgt_79	;
self.final_score_80	:= 	woFDN_FL__SD_lgt_80	;
self.final_score_81	:= 	woFDN_FL__SD_lgt_81	;
self.final_score_82	:= 	woFDN_FL__SD_lgt_82	;
self.final_score_83	:= 	woFDN_FL__SD_lgt_83	;
self.final_score_84	:= 	woFDN_FL__SD_lgt_84	;
self.final_score_85	:= 	woFDN_FL__SD_lgt_85	;
self.final_score_86	:= 	woFDN_FL__SD_lgt_86	;
self.final_score_87	:= 	woFDN_FL__SD_lgt_87	;
self.final_score_88	:= 	woFDN_FL__SD_lgt_88	;
self.final_score_89	:= 	woFDN_FL__SD_lgt_89	;
self.final_score_90	:= 	woFDN_FL__SD_lgt_90	;
self.final_score_91	:= 	woFDN_FL__SD_lgt_91	;
self.final_score_92	:= 	woFDN_FL__SD_lgt_92	;
self.final_score_93	:= 	woFDN_FL__SD_lgt_93	;
self.final_score_94	:= 	woFDN_FL__SD_lgt_94	;
self.final_score_95	:= 	woFDN_FL__SD_lgt_95	;
self.final_score_96	:= 	woFDN_FL__SD_lgt_96	;
self.final_score_97	:= 	woFDN_FL__SD_lgt_97	;
self.final_score_98	:= 	woFDN_FL__SD_lgt_98	;
self.final_score_99	:= 	woFDN_FL__SD_lgt_99	;
self.final_score_100	:= 	woFDN_FL__SD_lgt_100	;
self.final_score_101	:= 	woFDN_FL__SD_lgt_101	;
self.final_score_102	:= 	woFDN_FL__SD_lgt_102	;
self.final_score_103	:= 	woFDN_FL__SD_lgt_103	;
self.final_score_104	:= 	woFDN_FL__SD_lgt_104	;
self.final_score_105	:= 	woFDN_FL__SD_lgt_105	;
self.final_score_106	:= 	woFDN_FL__SD_lgt_106	;
self.final_score_107	:= 	woFDN_FL__SD_lgt_107	;
self.final_score_108	:= 	woFDN_FL__SD_lgt_108	;
self.final_score_109	:= 	woFDN_FL__SD_lgt_109	;
self.final_score_110	:= 	woFDN_FL__SD_lgt_110	;
self.final_score_111	:= 	woFDN_FL__SD_lgt_111	;
self.final_score_112	:= 	woFDN_FL__SD_lgt_112	;
self.final_score_113	:= 	woFDN_FL__SD_lgt_113	;
self.final_score_114	:= 	woFDN_FL__SD_lgt_114	;
self.final_score_115	:= 	woFDN_FL__SD_lgt_115	;
self.final_score_116	:= 	woFDN_FL__SD_lgt_116	;
self.final_score_117	:= 	woFDN_FL__SD_lgt_117	;
self.final_score_118	:= 	woFDN_FL__SD_lgt_118	;
self.final_score_119	:= 	woFDN_FL__SD_lgt_119	;
self.final_score_120	:= 	woFDN_FL__SD_lgt_120	;
self.final_score_121	:= 	woFDN_FL__SD_lgt_121	;
self.final_score_122	:= 	woFDN_FL__SD_lgt_122	;
self.final_score_123	:= 	woFDN_FL__SD_lgt_123	;
self.final_score_124	:= 	woFDN_FL__SD_lgt_124	;
self.final_score_125	:= 	woFDN_FL__SD_lgt_125	;
self.final_score_126	:= 	woFDN_FL__SD_lgt_126	;
self.final_score_127	:= 	woFDN_FL__SD_lgt_127	;
self.final_score_128	:= 	woFDN_FL__SD_lgt_128	;
self.final_score_129	:= 	woFDN_FL__SD_lgt_129	;
self.final_score_130	:= 	woFDN_FL__SD_lgt_130	;
self.final_score_131	:= 	woFDN_FL__SD_lgt_131	;
self.final_score_132	:= 	woFDN_FL__SD_lgt_132	;
self.final_score_133	:= 	woFDN_FL__SD_lgt_133	;
self.final_score_134	:= 	woFDN_FL__SD_lgt_134	;
self.final_score_135	:= 	woFDN_FL__SD_lgt_135	;
self.final_score_136	:= 	woFDN_FL__SD_lgt_136	;
self.final_score_137	:= 	woFDN_FL__SD_lgt_137	;
self.final_score_138	:= 	woFDN_FL__SD_lgt_138	;
self.final_score_139	:= 	woFDN_FL__SD_lgt_139	;
self.final_score_140	:= 	woFDN_FL__SD_lgt_140	;
self.final_score_141	:= 	woFDN_FL__SD_lgt_141	;
self.final_score_142	:= 	woFDN_FL__SD_lgt_142	;
self.final_score_143	:= 	woFDN_FL__SD_lgt_143	;
self.final_score_144	:= 	woFDN_FL__SD_lgt_144	;
self.final_score_145	:= 	woFDN_FL__SD_lgt_145	;
self.final_score_146	:= 	woFDN_FL__SD_lgt_146	;
self.final_score_147	:= 	woFDN_FL__SD_lgt_147	;
self.final_score_148	:= 	woFDN_FL__SD_lgt_148	;
self.final_score_149	:= 	woFDN_FL__SD_lgt_149	;
self.final_score_150	:= 	woFDN_FL__SD_lgt_150	;
self.final_score_151	:= 	woFDN_FL__SD_lgt_151	;
self.final_score_152	:= 	woFDN_FL__SD_lgt_152	;
self.final_score_153	:= 	woFDN_FL__SD_lgt_153	;
self.final_score_154	:= 	woFDN_FL__SD_lgt_154	;
self.final_score_155	:= 	woFDN_FL__SD_lgt_155	;
self.final_score_156	:= 	woFDN_FL__SD_lgt_156	;
self.final_score_157	:= 	woFDN_FL__SD_lgt_157	;
self.final_score_158	:= 	woFDN_FL__SD_lgt_158	;
self.final_score_159	:= 	woFDN_FL__SD_lgt_159	;
self.final_score_160	:= 	woFDN_FL__SD_lgt_160	;
self.final_score_161	:= 	woFDN_FL__SD_lgt_161	;
self.final_score_162	:= 	woFDN_FL__SD_lgt_162	;
self.final_score_163	:= 	woFDN_FL__SD_lgt_163	;
self.final_score_164	:= 	woFDN_FL__SD_lgt_164	;
self.final_score_165	:= 	woFDN_FL__SD_lgt_165	;
self.final_score_166	:= 	woFDN_FL__SD_lgt_166	;
self.final_score_167	:= 	woFDN_FL__SD_lgt_167	;
self.final_score_168	:= 	woFDN_FL__SD_lgt_168	;
self.final_score_169	:= 	woFDN_FL__SD_lgt_169	;
self.final_score_170	:= 	woFDN_FL__SD_lgt_170	;
self.final_score_171	:= 	woFDN_FL__SD_lgt_171	;
self.final_score_172	:= 	woFDN_FL__SD_lgt_172	;
self.final_score_173	:= 	woFDN_FL__SD_lgt_173	;
self.final_score_174	:= 	woFDN_FL__SD_lgt_174	;
self.final_score_175	:= 	woFDN_FL__SD_lgt_175	;
self.final_score_176	:= 	woFDN_FL__SD_lgt_176	;
self.final_score_177	:= 	woFDN_FL__SD_lgt_177	;
self.final_score_178	:= 	woFDN_FL__SD_lgt_178	;
self.final_score_179	:= 	woFDN_FL__SD_lgt_179	;
self.final_score_180	:= 	woFDN_FL__SD_lgt_180	;
self.final_score_181	:= 	woFDN_FL__SD_lgt_181	;
self.final_score_182	:= 	woFDN_FL__SD_lgt_182	;
self.final_score_183	:= 	woFDN_FL__SD_lgt_183	;
self.final_score_184	:= 	woFDN_FL__SD_lgt_184	;
self.final_score_185	:= 	woFDN_FL__SD_lgt_185	;
self.final_score_186	:= 	woFDN_FL__SD_lgt_186	;
self.final_score_187	:= 	woFDN_FL__SD_lgt_187	;
self.final_score_188	:= 	woFDN_FL__SD_lgt_188	;
self.final_score_189	:= 	woFDN_FL__SD_lgt_189	;
self.final_score_190	:= 	woFDN_FL__SD_lgt_190	;
self.final_score_191	:= 	woFDN_FL__SD_lgt_191	;
self.final_score_192	:= 	woFDN_FL__SD_lgt_192	;
self.final_score_193	:= 	woFDN_FL__SD_lgt_193	;
self.final_score_194	:= 	woFDN_FL__SD_lgt_194	;
self.final_score_195	:= 	woFDN_FL__SD_lgt_195	;
self.final_score_196	:= 	woFDN_FL__SD_lgt_196	;
self.final_score_197	:= 	woFDN_FL__SD_lgt_197	;
self.final_score_198	:= 	woFDN_FL__SD_lgt_198	;
self.final_score_199	:= 	woFDN_FL__SD_lgt_199	;
self.final_score_200	:= 	woFDN_FL__SD_lgt_200	;
self.final_score_201	:= 	woFDN_FL__SD_lgt_201	;
self.final_score_202	:= 	woFDN_FL__SD_lgt_202	;
self.final_score_203	:= 	woFDN_FL__SD_lgt_203	;
self.final_score_204	:= 	woFDN_FL__SD_lgt_204	;
self.final_score_205	:= 	woFDN_FL__SD_lgt_205	;
// self.woFDN_submodel_lgt	:= 	woFDN_FL__SD_lgt	;
self.FP3_woFDN_LGT		:= 	woFDN_FL__SD_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
