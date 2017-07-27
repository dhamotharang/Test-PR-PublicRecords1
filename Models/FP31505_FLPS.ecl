
export FP31505_FLPS( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   woFDN_FL_PS__lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FL_PS__lgt_1 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0586892107,
      (f_phone_ver_experian_d > 0.5) => -0.0532990463,
      (f_phone_ver_experian_d = NULL) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 0.0252530939,
         (f_assocrisktype_i > 8.5) => 0.3398425456,
         (f_assocrisktype_i = NULL) => 0.0413058511, 0.0413058511), 0.0276347636),
   (k_nap_phn_verd_d > 0.5) => -0.0546385881,
   (k_nap_phn_verd_d = NULL) => -0.0223171709, -0.0223171709),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0876296291,
   (f_inq_Communications_count_i > 0.5) => 0.4689469651,
   (f_inq_Communications_count_i = NULL) => 0.1824436694, 0.1824436694),
(f_srchvelocityrisktype_i = NULL) => 0.2475345755, -0.0016766067);

// Tree: 2 
woFDN_FL_PS__lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0031005692,
         (f_rel_felony_count_i > 1.5) => 0.1948831005,
         (f_rel_felony_count_i = NULL) => 0.0134001571, 0.0134001571),
      (k_nap_phn_verd_d > 0.5) => -0.0534045651,
      (k_nap_phn_verd_d = NULL) => -0.0271137488, -0.0271137488),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.1918153443,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0223652656, -0.0223652656),
(f_varrisktype_i > 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.1310699300,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.4138036852,
   (nf_seg_FraudPoint_3_0 = '') => 0.2249134743, 0.2249134743),
(f_varrisktype_i = NULL) => 0.1678129452, -0.0066581424);

// Tree: 3 
woFDN_FL_PS__lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.45) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0101827606,
         (f_phone_ver_experian_d > 0.5) => -0.0582986753,
         (f_phone_ver_experian_d = NULL) => -0.0191675964, -0.0289581197),
      (c_famotf18_p > 29.45) => 0.0944125429,
      (c_famotf18_p = NULL) => -0.0509721612, -0.0211191881),
   (f_varrisktype_i > 3.5) => 0.1252885539,
   (f_varrisktype_i = NULL) => -0.0138626872, -0.0138626872),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => 0.1546232701,
   (f_inq_HighRiskCredit_count_i > 1.5) => 0.3392643745,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.1966066303, 0.1966066303),
(f_inq_Communications_count_i = NULL) => 0.0949524262, -0.0057850909);

// Tree: 4 
woFDN_FL_PS__lgt_4 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0527333491,
      (f_corrrisktype_i > 8.5) => 0.0102669155,
      (f_corrrisktype_i = NULL) => -0.0251002333, -0.0251002333),
   (f_assocsuspicousidcount_i > 14.5) => 0.3503270680,
   (f_assocsuspicousidcount_i = NULL) => -0.0230432853, -0.0230432853),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0457099676,
   (f_assocrisktype_i > 4.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.1445290577,
      (f_varrisktype_i > 2.5) => 0.2987758079,
      (f_varrisktype_i = NULL) => 0.2049771085, 0.2049771085),
   (f_assocrisktype_i = NULL) => 0.0896867155, 0.0896867155),
(f_srchvelocityrisktype_i = NULL) => 0.0998422111, -0.0075325707);

// Tree: 5 
woFDN_FL_PS__lgt_5 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.1551766624,
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 28.55) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3098309296,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => -0.0246937128,
         (f_srchcomponentrisktype_i > 3.5) => 0.1409041636,
         (f_srchcomponentrisktype_i = NULL) => -0.0212997473, -0.0212997473),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0195889513, -0.0195889513),
   (c_famotf18_p > 28.55) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0630808003,
      (f_varrisktype_i > 2.5) => 0.2235495964,
      (f_varrisktype_i = NULL) => 0.0912547111, 0.0912547111),
   (c_famotf18_p = NULL) => -0.0172042315, -0.0111057333),
(r_D33_Eviction_Recency_d = NULL) => 0.0844533323, -0.0037631741);

// Tree: 6 
woFDN_FL_PS__lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1802709777,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0566385041,
         (f_corrphonelastnamecount_d > 0.5) => -0.0267265279,
         (f_corrphonelastnamecount_d = NULL) => 0.0208823078, 0.0208823078),
      (f_phone_ver_experian_d > 0.5) => -0.0524341789,
      (f_phone_ver_experian_d = NULL) => -0.0151285091, -0.0210555009),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0162876343, -0.0162876343),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => 0.1074751453,
   (f_inq_count_i > 14.5) => 0.2532025129,
   (f_inq_count_i = NULL) => 0.1331701472, 0.1331701472),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0641296456, -0.0108049592);

// Tree: 7 
woFDN_FL_PS__lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0335890734,
         (f_corrrisktype_i > 8.5) => 0.0441745171,
         (f_corrrisktype_i = NULL) => 0.0105578550, 0.0105578550),
      (k_inq_per_phone_i > 2.5) => 0.2623163477,
      (k_inq_per_phone_i = NULL) => 0.0208457476, 0.0208457476),
   (f_phone_ver_experian_d > 0.5) => -0.0458032464,
   (f_phone_ver_experian_d = NULL) => -0.0023360802, -0.0154445710),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 4.5) => 0.0985752914,
   (r_C14_addrs_5yr_i > 4.5) => 0.2718813370,
   (r_C14_addrs_5yr_i = NULL) => 0.1209782680, 0.1209782680),
(f_inq_Communications_count_i = NULL) => 0.0485346804, -0.0103693936);

// Tree: 8 
woFDN_FL_PS__lgt_8 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0220310433,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0552592413,
      (f_rel_felony_count_i > 0.5) => 0.2476413040,
      (f_rel_felony_count_i = NULL) => 0.0887479708, 0.0887479708),
   (k_inq_per_phone_i = NULL) => -0.0167891341, -0.0167891341),
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 46.5) => 0.2046559577,
      (c_fammar_p > 46.5) => 0.0455062974,
      (c_fammar_p = NULL) => 0.0642297868, 0.0642297868),
   (r_D33_eviction_count_i > 0.5) => 0.1900130731,
   (r_D33_eviction_count_i = NULL) => 0.0791439341, 0.0791439341),
(f_inq_Communications_count_i = NULL) => 0.0452863670, -0.0074981020);

// Tree: 9 
woFDN_FL_PS__lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.35) => 0.0884227026,
      (c_fammar_p > 44.35) => -0.0200361549,
      (c_fammar_p = NULL) => -0.0394071720, -0.0147735116),
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 0.0705304424,
         (f_util_add_curr_misc_n > 0.5) => 0.3109952159,
         (f_util_add_curr_misc_n = NULL) => 0.1952158805, 0.1952158805),
      (f_phone_ver_experian_d > 0.5) => 0.0339382258,
      (f_phone_ver_experian_d = NULL) => 0.1006766282, 0.0924490725),
   (k_inq_per_phone_i = NULL) => -0.0097529388, -0.0097529388),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1283021845,
(f_inq_PrepaidCards_count_i = NULL) => 0.0890158988, -0.0050110107);

// Tree: 10 
woFDN_FL_PS__lgt_10 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.55) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => -0.0014625923,
         (f_assocrisktype_i > 4.5) => 0.0785852769,
         (f_assocrisktype_i = NULL) => 0.0124959329, 0.0124959329),
      (c_famotf18_p > 29.55) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 54.05) => 0.2003535377,
         (c_civ_emp > 54.05) => 0.0469951270,
         (c_civ_emp = NULL) => 0.1113389819, 0.1113389819),
      (c_famotf18_p = NULL) => -0.0346549740, 0.0198994561),
   (k_nap_phn_verd_d > 0.5) => -0.0355056439,
   (k_nap_phn_verd_d = NULL) => -0.0133526942, -0.0133526942),
(f_srchfraudsrchcount_i > 8.5) => 0.1164030776,
(f_srchfraudsrchcount_i = NULL) => 0.0255526893, -0.0091845579);

// Tree: 11 
woFDN_FL_PS__lgt_11 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0232630098,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2680741554,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => 0.0112633346,
         (f_srchfraudsrchcount_i > 4.5) => 
            map(
            (NULL < c_white_col and c_white_col <= 36) => 0.1563526597,
            (c_white_col > 36) => 0.0263924448,
            (c_white_col = NULL) => 0.0890325484, 0.0890325484),
         (f_srchfraudsrchcount_i = NULL) => 0.0204936478, 0.0204936478),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0255820076, 0.0255820076),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.1461366126,
   (f_inq_PrepaidCards_count_i = NULL) => 0.0204515981, 0.0323804145),
(nf_seg_FraudPoint_3_0 = '') => -0.0081908138, -0.0081908138);

// Tree: 12 
woFDN_FL_PS__lgt_12 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 12.05) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 0.0148717210,
         (f_inq_Communications_count_i > 1.5) => 0.1255976998,
         (f_inq_Communications_count_i = NULL) => 0.0191181909, 0.0191181909),
      (f_phone_ver_experian_d > 0.5) => -0.0378318387,
      (f_phone_ver_experian_d = NULL) => -0.0140337588, -0.0144393314),
   (c_unemp > 12.05) => 0.1572647525,
   (c_unemp = NULL) => -0.0239428147, -0.0126340712),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.1400252549,
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0312398688,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0936409505, 0.0936409505),
(f_varrisktype_i = NULL) => 0.0642508567, -0.0090553634);

// Tree: 13 
woFDN_FL_PS__lgt_13 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0157025289,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1326123202,
      (r_Phn_Cell_n > 0.5) => 0.0093373269,
      (r_Phn_Cell_n = NULL) => 0.0559927893, 0.0559927893),
   (f_varrisktype_i = NULL) => -0.0120299936, -0.0120299936),
(f_rel_felony_count_i > 1.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 4.85) => 0.0477299778,
   (c_bigapt_p > 4.85) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 95) => 0.2810069517,
      (r_C13_max_lres_d > 95) => 0.1136257992,
      (r_C13_max_lres_d = NULL) => 0.1786592406, 0.1786592406),
   (c_bigapt_p = NULL) => 0.0822776992, 0.0822776992),
(f_rel_felony_count_i = NULL) => 0.0246083592, -0.0072193290);

// Tree: 14 
woFDN_FL_PS__lgt_14 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0918096718,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 185.5) => 0.0041565618,
         (c_bel_edu > 185.5) => 0.1195732021,
         (c_bel_edu = NULL) => -0.0401496031, 0.0087316430),
      (k_nap_phn_verd_d > 0.5) => -0.0400723477,
      (k_nap_phn_verd_d = NULL) => -0.0200641135, -0.0200641135),
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0824677854,
      (f_phone_ver_experian_d > 0.5) => 0.0088140896,
      (f_phone_ver_experian_d = NULL) => 0.1030964043, 0.0420932938),
   (k_inq_per_ssn_i = NULL) => -0.0129079840, -0.0129079840),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0098294170, -0.0096513769);

// Tree: 15 
woFDN_FL_PS__lgt_15 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1325181536,
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 29.25) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 12.5) => -0.0162633274,
      (f_srchssnsrchcount_i > 12.5) => 0.0946013519,
      (f_srchssnsrchcount_i = NULL) => -0.0149928996, -0.0149928996),
   (c_famotf18_p > 29.25) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0987267477,
      (k_nap_phn_verd_d > 0.5) => 0.0041270526,
      (k_nap_phn_verd_d = NULL) => 0.0518698748, 0.0518698748),
   (c_famotf18_p = NULL) => -0.0320099007, -0.0102206093),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0787045878,
   (r_S66_adlperssn_count_i > 1.5) => 0.1506704440,
   (r_S66_adlperssn_count_i = NULL) => 0.0454525395, 0.0454525395), -0.0080205775);

// Tree: 16 
woFDN_FL_PS__lgt_16 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 44.55) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0855606527) => 0.0195471320,
      (f_add_curr_nhood_VAC_pct_i > 0.0855606527) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 122.5) => 0.2007520149,
         (f_prevaddrageoldest_d > 122.5) => -0.0099566153,
         (f_prevaddrageoldest_d = NULL) => 0.1384736020, 0.1384736020),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0576261121, 0.0576261121),
   (c_fammar_p > 44.55) => -0.0097390731,
   (c_fammar_p = NULL) => -0.0133126260, -0.0062582776),
(r_D30_Derog_Count_i > 5.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 29.95) => 0.0653281092,
   (c_famotf18_p > 29.95) => 0.2073730271,
   (c_famotf18_p = NULL) => 0.0837326003, 0.0837326003),
(r_D30_Derog_Count_i = NULL) => 0.0131311058, -0.0017716863);

// Tree: 17 
woFDN_FL_PS__lgt_17 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0258631832,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 4.5) => 0.0078684531,
      (f_assocsuspicousidcount_i > 4.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 106.5) => 0.2483098031,
         (r_C10_M_Hdr_FS_d > 106.5) => 0.0536298901,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0769313469, 0.0769313469),
      (f_assocsuspicousidcount_i = NULL) => 0.0238321207, 0.0238321207),
   (nf_seg_FraudPoint_3_0 = '') => -0.0165608798, -0.0165608798),
(f_srchcomponentrisktype_i > 1.5) => 0.0813196853,
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0691239483,
   (f_addrs_per_ssn_i > 3.5) => 0.1056845512,
   (f_addrs_per_ssn_i = NULL) => 0.0196676705, 0.0196676705), -0.0116715862);

// Tree: 18 
woFDN_FL_PS__lgt_18 := map(
(nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0417326253,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0239590836,
      (f_assocrisktype_i > 4.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 8.5) => 0.2202047873,
         (f_prevaddrageoldest_d > 8.5) => 0.0560122325,
         (f_prevaddrageoldest_d = NULL) => 0.0746364206, 0.0746364206),
      (f_assocrisktype_i = NULL) => 0.0483170307, 0.0357036850),
   (k_nap_phn_verd_d > 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0120072727,
      (r_D33_eviction_count_i > 2.5) => 0.1458095423,
      (r_D33_eviction_count_i = NULL) => -0.0097435069, -0.0097435069),
   (k_nap_phn_verd_d = NULL) => 0.0091229971, 0.0091229971),
(nf_seg_FraudPoint_3_0 = '') => -0.0080279964, -0.0080279964);

// Tree: 19 
woFDN_FL_PS__lgt_19 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0124185499,
      (f_rel_felony_count_i > 1.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 40.1) => 0.2249799058,
         (C_OWNOCC_P > 40.1) => 0.0578112962,
         (C_OWNOCC_P = NULL) => 0.0959486216, 0.0959486216),
      (f_rel_felony_count_i = NULL) => 0.0502196441, 0.0175459137),
   (k_nap_phn_verd_d > 0.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.1630437997,
      (r_D33_Eviction_Recency_d > 48) => -0.0263784654,
      (r_D33_Eviction_Recency_d = NULL) => -0.0249367737, -0.0249367737),
   (k_nap_phn_verd_d = NULL) => -0.0076385608, -0.0076385608),
(k_inq_per_phone_i > 2.5) => 0.0725427336,
(k_inq_per_phone_i = NULL) => -0.0034920154, -0.0034920154);

// Tree: 20 
woFDN_FL_PS__lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0136501522,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 168) => 0.0648680792,
      (c_sub_bus > 168) => 0.3562889614,
      (c_sub_bus = NULL) => 0.1045405019, 0.1045405019),
   (k_comb_age_d = NULL) => -0.0071519870, -0.0071519870),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 59.5) => 0.1929220439,
      (c_very_rich > 59.5) => 0.0823391412,
      (c_very_rich = NULL) => 0.1063909226, 0.1063909226),
   (f_phone_ver_experian_d > 0.5) => 0.0086962638,
   (f_phone_ver_experian_d = NULL) => 0.0369535886, 0.0477667358),
(f_varrisktype_i = NULL) => 0.0262918773, -0.0009545598);

// Tree: 21 
woFDN_FL_PS__lgt_21 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 5.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 7.55) => 0.0047581994,
   (c_famotf18_p > 7.55) => 0.1940408442,
   (c_famotf18_p = NULL) => 0.1135673844, 0.1135673844),
(r_C21_M_Bureau_ADL_FS_d > 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0197015666,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_professional and c_professional <= 2.85) => 
         map(
         (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 0.5) => 0.1013963109,
         (f_hh_workers_paw_d > 0.5) => 0.0255144176,
         (f_hh_workers_paw_d = NULL) => 0.0538464839, 0.0538464839),
      (c_professional > 2.85) => -0.0058470500,
      (c_professional = NULL) => 0.0027469009, 0.0213995095),
   (nf_seg_FraudPoint_3_0 = '') => -0.0117786275, -0.0117786275),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0044028161, -0.0100156381);

// Tree: 22 
woFDN_FL_PS__lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1723973856,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0206063414,
      (f_rel_criminal_count_i > 2.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
            map(
            (NULL < c_sub_bus and c_sub_bus <= 127.5) => 0.0641274940,
            (c_sub_bus > 127.5) => 0.1871871715,
            (c_sub_bus = NULL) => 0.1053572069, 0.1053572069),
         (k_estimated_income_d > 28500) => 0.0125485618,
         (k_estimated_income_d = NULL) => 0.0240189670, 0.0240189670),
      (f_rel_criminal_count_i = NULL) => -0.0090701054, -0.0090701054),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0081500626, -0.0081500626),
(r_D33_eviction_count_i > 2.5) => 0.1258932627,
(r_D33_eviction_count_i = NULL) => 0.0044895029, -0.0066286638);

// Tree: 23 
woFDN_FL_PS__lgt_23 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 0.0173987022,
   (k_inq_per_phone_i > 5.5) => 0.1810785582,
   (k_inq_per_phone_i = NULL) => 0.0200406666, 0.0200406666),
(f_phone_ver_experian_d > 0.5) => -0.0299384478,
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 8.25) => -0.0152897481,
      (c_unemp > 8.25) => 0.1121387641,
      (c_unemp = NULL) => -0.1087353723, -0.0069200133),
   (f_assocrisktype_i > 8.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 49.5) => 0.2010645863,
      (f_prevaddrlenofres_d > 49.5) => 0.0090853853,
      (f_prevaddrlenofres_d = NULL) => 0.1185846333, 0.1185846333),
   (f_assocrisktype_i = NULL) => 0.0113671403, -0.0001807342), -0.0074612598);

// Tree: 24 
woFDN_FL_PS__lgt_24 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.1672438067,
(r_D32_Mos_Since_Fel_LS_d > 127.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => -0.0070202727,
   (f_inq_Communications_count_i > 1.5) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 2.85) => 0.0027978365,
      (c_hval_300k_p > 2.85) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 3.5) => 0.0618940564,
         (f_srchvelocityrisktype_i > 3.5) => 0.1876381106,
         (f_srchvelocityrisktype_i = NULL) => 0.1086825416, 0.1086825416),
      (c_hval_300k_p = NULL) => 0.0557401891, 0.0557401891),
   (f_inq_Communications_count_i = NULL) => -0.0048434640, -0.0048434640),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 127.5) => -0.0745465580,
   (c_new_homes > 127.5) => 0.0681259977,
   (c_new_homes = NULL) => -0.0068375485, -0.0068375485), -0.0037771891);

// Tree: 25 
woFDN_FL_PS__lgt_25 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0043157310,
      (f_assocrisktype_i > 3.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.0880246884,
         (r_C12_Num_NonDerogs_d > 3.5) => 0.0026515713,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0508945732, 0.0508945732),
      (f_assocrisktype_i = NULL) => 0.0165975739, 0.0165975739),
   (f_inq_Communications_count_i > 3.5) => 0.1634192315,
   (f_inq_Communications_count_i = NULL) => 0.0476094709, 0.0187630828),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0272098811,
   (r_D33_eviction_count_i > 3.5) => 0.1125671268,
   (r_D33_eviction_count_i = NULL) => -0.0262655670, -0.0262655670),
(k_nap_phn_verd_d = NULL) => -0.0081618134, -0.0081618134);

// Tree: 26 
woFDN_FL_PS__lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_employees and c_employees <= 29.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 5.15) => 0.0306880036,
      (c_hh7p_p > 5.15) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => 0.0571641407,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.2187089980,
         (nf_seg_FraudPoint_3_0 = '') => 0.1267659143, 0.1267659143),
      (c_hh7p_p = NULL) => 0.0459178916, 0.0459178916),
   (c_employees > 29.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0087985118,
      (f_assocsuspicousidcount_i > 15.5) => 0.1261746382,
      (f_assocsuspicousidcount_i = NULL) => -0.0080923002, -0.0080923002),
   (c_employees = NULL) => 0.0127890052, -0.0024047686),
(r_D30_Derog_Count_i > 11.5) => 0.1048494143,
(r_D30_Derog_Count_i = NULL) => 0.0085089975, -0.0008488027);

// Tree: 27 
woFDN_FL_PS__lgt_27 := map(
(nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0384381561,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 2.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 368) => -0.0070884476,
      (r_C13_Curr_Addr_LRes_d > 368) => 0.2037594545,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0016212760, -0.0016212760),
   (f_assocsuspicousidcount_i > 2.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 26.45) => 0.0275467235,
      (c_famotf18_p > 26.45) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 19.5) => 0.1857567777,
         (r_C13_Curr_Addr_LRes_d > 19.5) => 0.0500684675,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0906652395, 0.0906652395),
      (c_famotf18_p = NULL) => -0.0151589564, 0.0344260473),
   (f_assocsuspicousidcount_i = NULL) => 0.0108953347, 0.0113660432),
(nf_seg_FraudPoint_3_0 = '') => -0.0057562361, -0.0057562361);

// Tree: 28 
woFDN_FL_PS__lgt_28 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 15.65) => 0.1173017360,
      (c_sfdu_p > 15.65) => 0.0046582694,
      (c_sfdu_p = NULL) => 0.0000279780, 0.0122982859),
   (k_inq_per_ssn_i > 2.5) => 0.0791982339,
   (k_inq_per_ssn_i = NULL) => 0.0195240094, 0.0195240094),
(f_phone_ver_experian_d > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => -0.0389735236,
   (f_inq_HighRiskCredit_count_i > 1.5) => 0.0639723691,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0352993959, -0.0352993959),
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 7.5) => -0.0001932943,
   (f_assocsuspicousidcount_i > 7.5) => 0.0937500588,
   (f_assocsuspicousidcount_i = NULL) => -0.0093997632, 0.0037073624), -0.0092551463);

// Tree: 29 
woFDN_FL_PS__lgt_29 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1092959818,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0085442871,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0079285906, -0.0079285906),
(k_comb_age_d > 67.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 29.5) => 
      map(
      (NULL < c_professional and c_professional <= 5.9) => 0.3023461110,
      (c_professional > 5.9) => 0.0574578435,
      (c_professional = NULL) => 0.1921463907, 0.1921463907),
   (c_born_usa > 29.5) => 0.0460180157,
   (c_born_usa = NULL) => 0.0665512768, 0.0665512768),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 64) => 0.0878937860,
   (c_larceny > 64) => -0.0731086994,
   (c_larceny = NULL) => -0.0019992683, -0.0019992683), -0.0026792964);

// Tree: 30 
woFDN_FL_PS__lgt_30 := map(
(NULL < c_white_col and c_white_col <= 20.35) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.45) => 0.0359212502,
   (c_unemp > 11.45) => 0.1498029848,
   (c_unemp = NULL) => 0.0488587264, 0.0488587264),
(c_white_col > 20.35) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => -0.0152191804,
   (k_inq_per_ssn_i > 3.5) => 
      map(
      (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 2.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 0.0157425863,
         (k_comb_age_d > 66.5) => 0.2585248433,
         (k_comb_age_d = NULL) => 0.0296000211, 0.0296000211),
      (f_srchunvrfdphonecount_i > 2.5) => 0.1171727692,
      (f_srchunvrfdphonecount_i = NULL) => 0.0352136588, 0.0352136588),
   (k_inq_per_ssn_i = NULL) => -0.0111631054, -0.0111631054),
(c_white_col = NULL) => -0.0209209715, -0.0080270876);

// Tree: 31 
woFDN_FL_PS__lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.35) => -0.0061207594,
      (c_unemp > 9.35) => 
         map(
         (NULL < c_employees and c_employees <= 14.5) => 0.1344181827,
         (c_employees > 14.5) => 0.0321478382,
         (c_employees = NULL) => 0.0494273070, 0.0494273070),
      (c_unemp = NULL) => -0.0213130970, -0.0042030297),
   (k_comb_age_d > 81.5) => 0.1643527821,
   (k_comb_age_d = NULL) => -0.0022204961, -0.0022204961),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1655490696,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_health and c_health <= 11.7) => -0.0510389205,
   (c_health > 11.7) => 0.0729882539,
   (c_health = NULL) => -0.0025908055, -0.0025908055), -0.0015233517);

// Tree: 32 
woFDN_FL_PS__lgt_32 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.0884528854,
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 3.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 11.25) => 0.0183458862,
         (c_unemp > 11.25) => 0.1572152950,
         (c_unemp = NULL) => 0.0517220408, 0.0229870647),
      (k_inq_per_phone_i > 3.5) => 0.1441459811,
      (k_inq_per_phone_i = NULL) => 0.0272181690, 0.0272181690),
   (f_hh_members_ct_d > 1.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0193329881,
      (f_hh_collections_ct_i > 2.5) => 0.0435311818,
      (f_hh_collections_ct_i = NULL) => -0.0122576948, -0.0122576948),
   (f_hh_members_ct_d = NULL) => -0.0045108390, -0.0045108390),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0226788874, -0.0031234227);

// Tree: 33 
woFDN_FL_PS__lgt_33 := map(
(NULL < c_white_col and c_white_col <= 18.75) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 65.75) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 132) => 0.0408469574,
      (c_totcrime > 132) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 16.05) => 0.0830728599,
         (C_INC_50K_P > 16.05) => 0.2968892351,
         (C_INC_50K_P = NULL) => 0.1551737306, 0.1551737306),
      (c_totcrime = NULL) => 0.0927314033, 0.0927314033),
   (c_lowrent > 65.75) => -0.0293608556,
   (c_lowrent = NULL) => 0.0620876940, 0.0620876940),
(c_white_col > 18.75) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 82.5) => -0.0055613157,
   (k_comb_age_d > 82.5) => 0.1440631724,
   (k_comb_age_d = NULL) => -0.0221653025, -0.0043999281),
(c_white_col = NULL) => -0.0115508227, -0.0019225171);

// Tree: 34 
woFDN_FL_PS__lgt_34 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 78.5) => -0.0052834493,
(r_pb_order_freq_d > 78.5) => -0.0291355443,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 49.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 38990.5) => 0.1122814543,
      (f_curraddrmedianincome_d > 38990.5) => 0.0540615036,
      (f_curraddrmedianincome_d = NULL) => 0.0675048315, 0.0675048315),
   (c_no_teens > 49.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 21.5) => -0.0013658142,
      (f_rel_homeover200_count_d > 21.5) => 0.1479842158,
      (f_rel_homeover200_count_d = NULL) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0423640618,
         (f_addrs_per_ssn_i > 5.5) => 0.1171238472,
         (f_addrs_per_ssn_i = NULL) => 0.0030013878, 0.0030013878), 0.0021171631),
   (c_no_teens = NULL) => 0.0029845761, 0.0175797234), -0.0031601406);

// Tree: 35 
woFDN_FL_PS__lgt_35 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0209339995,
      (k_inq_per_ssn_i > 0.5) => 0.0119171812,
      (k_inq_per_ssn_i = NULL) => -0.0077316369, -0.0077316369),
   (f_hh_tot_derog_i > 5.5) => 0.0761732931,
   (f_hh_tot_derog_i = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0858963149,
      (f_addrs_per_ssn_i > 4.5) => 0.0469244908,
      (f_addrs_per_ssn_i = NULL) => -0.0201065700, -0.0201065700), -0.0054863187),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 99.5) => 0.1559657775,
   (f_curraddrburglaryindex_i > 99.5) => -0.0041774939,
   (f_curraddrburglaryindex_i = NULL) => 0.1023463786, 0.1023463786),
(r_P85_Phn_Disconnected_i = NULL) => -0.0035056313, -0.0035056313);

// Tree: 36 
woFDN_FL_PS__lgt_36 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
      map(
      (NULL < c_medi_indx and c_medi_indx <= 90.5) => 0.2542719164,
      (c_medi_indx > 90.5) => 0.0369622151,
      (c_medi_indx = NULL) => 0.0969487472, 0.0969487472),
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => -0.0103278779,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0086531798, -0.0086531798),
(f_srchcomponentrisktype_i > 3.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 1.5) => 0.1917988040,
      (f_rel_homeover200_count_d > 1.5) => 0.0616755156,
      (f_rel_homeover200_count_d = NULL) => 0.1084881620, 0.1084881620),
   (f_util_adl_count_n > 2.5) => -0.0228779240,
   (f_util_adl_count_n = NULL) => 0.0585593544, 0.0585593544),
(f_srchcomponentrisktype_i = NULL) => -0.0149037728, -0.0072739304);

// Tree: 37 
woFDN_FL_PS__lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.05) => -0.0143622444,
   (c_unemp > 9.05) => 
      map(
      (NULL < c_rental and c_rental <= 165.5) => 0.0103814928,
      (c_rental > 165.5) => 0.1721373254,
      (c_rental = NULL) => 0.0558753207, 0.0558753207),
   (c_unemp = NULL) => -0.0079239906, -0.0113288665),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0196433409,
   (f_varrisktype_i > 2.5) => 0.0613980585,
   (f_varrisktype_i = NULL) => 0.0242261758, 0.0242261758),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0689066692,
   (r_S66_adlperssn_count_i > 1.5) => 0.0812350634,
   (r_S66_adlperssn_count_i = NULL) => 0.0111689215, 0.0111689215), -0.0002869797);

// Tree: 38 
woFDN_FL_PS__lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => 0.0056476970,
      (k_inq_per_ssn_i > 1.5) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 161.5) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 231.5) => 0.0032564916,
            (r_C13_max_lres_d > 231.5) => 0.1328313763,
            (r_C13_max_lres_d = NULL) => 0.0322522700, 0.0322522700),
         (c_serv_empl > 161.5) => 0.1330930756,
         (c_serv_empl = NULL) => 0.0486407464, 0.0486407464),
      (k_inq_per_ssn_i = NULL) => 0.0130469989, 0.0130469989),
   (f_phone_ver_experian_d > 0.5) => -0.0198181553,
   (f_phone_ver_experian_d = NULL) => -0.0077781449, -0.0067283976),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1087311318,
(f_inq_PrepaidCards_count_i = NULL) => -0.0139805163, -0.0062167581);

// Tree: 39 
woFDN_FL_PS__lgt_39 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => -0.0045193946,
   (f_srchcomponentrisktype_i > 3.5) => 0.0809790383,
   (f_srchcomponentrisktype_i = NULL) => -0.0010079817, -0.0031555954),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 0.25) => 0.2121916957,
      (c_hval_80k_p > 0.25) => 0.0081719503,
      (c_hval_80k_p = NULL) => 0.1335694524, 0.1335694524),
   (f_srchfraudsrchcount_i > 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 8.05) => 0.0472052981,
      (c_construction > 8.05) => -0.0580027073,
      (c_construction = NULL) => 0.0069183302, 0.0069183302),
   (f_srchfraudsrchcount_i = NULL) => 0.0490674979, 0.0490674979),
(k_inq_per_phone_i = NULL) => -0.0005742884, -0.0005742884);

// Tree: 40 
woFDN_FL_PS__lgt_40 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.0058824646,
      (k_inq_per_ssn_i > 0.5) => 0.1611881924,
      (k_inq_per_ssn_i = NULL) => 0.0767362298, 0.0767362298),
   (r_C10_M_Hdr_FS_d > 10.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0153025906,
      (r_C13_Curr_Addr_LRes_d > 158.5) => 0.0234335647,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0064054382, -0.0064054382),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0156348604, -0.0049404523),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 2.5) => 0.0351915425,
   (f_srchphonesrchcount_i > 2.5) => 0.1408290558,
   (f_srchphonesrchcount_i = NULL) => 0.0456755244, 0.0456755244),
(k_nap_contradictory_i = NULL) => -0.0011776721, -0.0011776721);

// Tree: 41 
woFDN_FL_PS__lgt_41 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 41.5) => -0.0027311066,
(r_pb_order_freq_d > 41.5) => -0.0309438893,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 9.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 207.35) => 0.1556304367,
         (c_cpiall > 207.35) => 0.0344853983,
         (c_cpiall = NULL) => 0.0622667794, 0.0496856154),
      (f_hh_members_ct_d > 1.5) => -0.0080149831,
      (f_hh_members_ct_d = NULL) => 0.0055786732, 0.0055786732),
   (f_rel_criminal_count_i > 9.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 89) => 0.0186474358,
      (c_robbery > 89) => 0.1510226872,
      (c_robbery = NULL) => 0.0905549797, 0.0905549797),
   (f_rel_criminal_count_i = NULL) => 0.0015880732, 0.0083537218), -0.0084165602);

// Tree: 42 
woFDN_FL_PS__lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 222) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 16.45) => 0.1699242976,
   (c_hh3_p > 16.45) => 0.0038525851,
   (c_hh3_p = NULL) => 0.0823592128, 0.0823592128),
(r_D32_Mos_Since_Fel_LS_d > 222) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 5.25) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 2.5) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0000040402,
         (r_F04_curr_add_occ_index_d > 2) => 0.0543273046,
         (r_F04_curr_add_occ_index_d = NULL) => 0.0113138356, 0.0113138356),
      (f_hh_lienholders_i > 2.5) => 0.1284132703,
      (f_hh_lienholders_i = NULL) => 0.0157657395, 0.0157657395),
   (c_newhouse > 5.25) => -0.0148231390,
   (c_newhouse = NULL) => -0.0348264592, -0.0052986155),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0161136194, -0.0046441969);

// Tree: 43 
woFDN_FL_PS__lgt_43 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => -0.0078027034,
   (k_inq_per_ssn_i > 3.5) => 0.0357527556,
   (k_inq_per_ssn_i = NULL) => -0.0046161642, -0.0046161642),
(f_hh_tot_derog_i > 4.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 145.5) => 0.0171482600,
   (f_prevaddrcartheftindex_i > 145.5) => 
      map(
      (NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 0.5) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 31.9) => 0.1087759090,
         (c_lowinc > 31.9) => 0.2504040043,
         (c_lowinc = NULL) => 0.1809517653, 0.1809517653),
      (r_D31_MostRec_Bk_i > 0.5) => 0.0205229045,
      (r_D31_MostRec_Bk_i = NULL) => 0.1248016640, 0.1248016640),
   (f_prevaddrcartheftindex_i = NULL) => 0.0435258169, 0.0435258169),
(f_hh_tot_derog_i = NULL) => -0.0108102368, -0.0021930832);

// Tree: 44 
woFDN_FL_PS__lgt_44 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 58.55) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 0.5) => -0.0023359243,
      (f_rel_ageover40_count_d > 0.5) => 0.1273570277,
      (f_rel_ageover40_count_d = NULL) => 0.0549702638, 0.0549702638),
   (c_high_ed > 58.55) => -0.0799978887,
   (c_high_ed = NULL) => 0.0280800572, 0.0280800572),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.55) => -0.0081976166,
   (c_hh7p_p > 7.55) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0347051702,
      (nf_seg_FraudPoint_3_0 in ['3: Derog']) => 0.1414461446,
      (nf_seg_FraudPoint_3_0 = '') => 0.0528554573, 0.0528554573),
   (c_hh7p_p = NULL) => -0.0048984375, -0.0056605599),
(r_C10_M_Hdr_FS_d = NULL) => 0.0083201210, -0.0048150722);

// Tree: 45 
woFDN_FL_PS__lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 0.0111125497,
      (f_inq_PrepaidCards_count_i > 1.5) => 0.1098885837,
      (f_inq_PrepaidCards_count_i = NULL) => 0.0123765323, 0.0123765323),
   (f_historical_count_d > 0.5) => -0.0204540713,
   (f_historical_count_d = NULL) => -0.0039202882, -0.0039202882),
(k_comb_age_d > 67.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 20.5) => 0.2047955387,
   (c_born_usa > 20.5) => 0.0403156304,
   (c_born_usa = NULL) => 0.0580921848, 0.0580921848),
(k_comb_age_d = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0897615132,
   (k_nap_phn_verd_d > 0.5) => -0.1045486025,
   (k_nap_phn_verd_d = NULL) => 0.0179512531, 0.0179512531), 0.0007614312);

// Tree: 46 
woFDN_FL_PS__lgt_46 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 148.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 57.5) => -0.0120410513,
         (r_C13_Curr_Addr_LRes_d > 57.5) => 0.0602433619,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0258078106, 0.0258078106),
      (c_no_car > 148.5) => 0.0709727405,
      (c_no_car = NULL) => 0.0084669703, 0.0349353883),
   (f_phone_ver_experian_d > 0.5) => -0.0268681138,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0094738150,
      (f_rel_felony_count_i > 1.5) => 0.0947356807,
      (f_rel_felony_count_i = NULL) => 0.0148238000, 0.0148238000), 0.0101438878),
(f_corrphonelastnamecount_d > 0.5) => -0.0146869859,
(f_corrphonelastnamecount_d = NULL) => -0.0305570545, -0.0040101902);

// Tree: 47 
woFDN_FL_PS__lgt_47 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => -0.0068609028,
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.75) => -0.0087459641,
      (c_pop_45_54_p > 12.75) => 0.1295656877,
      (c_pop_45_54_p = NULL) => 0.0637029963, 0.0637029963),
   (f_inq_PrepaidCards_count24_i = NULL) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1095.5) => -0.0758200870,
      (c_popover25 > 1095.5) => 0.0526677498,
      (c_popover25 = NULL) => -0.0109973946, -0.0109973946), -0.0060990906),
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.0846649314,
   (k_nap_fname_verd_d > 0.5) => 0.0152561217,
   (k_nap_fname_verd_d = NULL) => 0.0367684736, 0.0367684736),
(k_inq_per_phone_i = NULL) => -0.0018140239, -0.0018140239);

// Tree: 48 
woFDN_FL_PS__lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0045795291,
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 4.75) => -0.0449369990,
   (c_pop_18_24_p > 4.75) => 
      map(
      (NULL < f_hh_college_attendees_d and f_hh_college_attendees_d <= 0.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.4961033634) => 
            map(
            (NULL < c_hhsize and c_hhsize <= 2.575) => -0.0020006980,
            (c_hhsize > 2.575) => 0.1375953283,
            (c_hhsize = NULL) => 0.0803950053, 0.0803950053),
         (f_add_curr_nhood_MFD_pct_i > 0.4961033634) => 0.0142601201,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1949886812, 0.0766392957),
      (f_hh_college_attendees_d > 0.5) => -0.0304147791,
      (f_hh_college_attendees_d = NULL) => 0.0503145232, 0.0503145232),
   (c_pop_18_24_p = NULL) => 0.0307718038, 0.0307718038),
(k_inq_per_phone_i = NULL) => -0.0028349540, -0.0028349540);

// Tree: 49 
woFDN_FL_PS__lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => 
         map(
         (NULL < r_nas_lname_verd_d and r_nas_lname_verd_d <= 0.5) => 0.2130334399,
         (r_nas_lname_verd_d > 0.5) => -0.0010901120,
         (r_nas_lname_verd_d = NULL) => -0.0000945380, -0.0000945380),
      (f_hh_criminals_i > 3.5) => 0.1161960939,
      (f_hh_criminals_i = NULL) => 0.0011967955, 0.0011967955),
   (f_varrisktype_i > 3.5) => 0.0498413314,
   (f_varrisktype_i = NULL) => 0.0033158115, 0.0033158115),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0669819873,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 413.5) => -0.0743499067,
   (c_families > 413.5) => 0.0875043249,
   (c_families = NULL) => 0.0037866189, 0.0037866189), 0.0004717404);

// Tree: 50 
woFDN_FL_PS__lgt_50 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1227795488,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 10.65) => -0.0014606952,
   (c_unemp > 10.65) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 25500) => 0.1558256609,
      (k_estimated_income_d > 25500) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 280.5) => 0.0646540005,
         (r_C10_M_Hdr_FS_d > 280.5) => -0.0764058152,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0200453408, 0.0200453408),
      (k_estimated_income_d = NULL) => 0.0484858133, 0.0484858133),
   (c_unemp = NULL) => 0.0052816003, -0.0001227265),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.35) => -0.0283754414,
   (c_pop_55_64_p > 12.35) => 0.0918017033,
   (c_pop_55_64_p = NULL) => 0.0206568337, 0.0206568337), 0.0006053731);

// Tree: 51 
woFDN_FL_PS__lgt_51 := map(
(NULL < c_employees and c_employees <= 55.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 12.65) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 37.5) => 0.0648689132,
      (c_born_usa > 37.5) => 0.0033838876,
      (c_born_usa = NULL) => 0.0210307359, 0.0210307359),
   (c_unemp > 12.65) => 0.1030462141,
   (c_unemp = NULL) => 0.0238666791, 0.0238666791),
(c_employees > 55.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 11.85) => -0.0109342530,
   (c_hh6_p > 11.85) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 127.25) => 0.0144502641,
      (c_oldhouse > 127.25) => 0.2064254808,
      (c_oldhouse = NULL) => 0.0887321319, 0.0887321319),
   (c_hh6_p = NULL) => -0.0089905436, -0.0089905436),
(c_employees = NULL) => -0.0026829508, -0.0032171668);

// Tree: 52 
woFDN_FL_PS__lgt_52 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0046031469,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 87) => 0.2245136811,
         (c_rich_wht > 87) => 0.0647218074,
         (c_rich_wht = NULL) => 0.1304426587, 0.1304426587),
      (f_phone_ver_experian_d > 0.5) => 0.0583378594,
      (f_phone_ver_experian_d = NULL) => -0.0081600744, 0.0608989046),
   (k_comb_age_d = NULL) => -0.0245601242, -0.0016592564),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 307790.5) => 0.0324943583,
   (f_prevaddrmedianvalue_d > 307790.5) => 0.2123197066,
   (f_prevaddrmedianvalue_d = NULL) => 0.0746291680, 0.0746291680),
(r_P85_Phn_Disconnected_i = NULL) => -0.0001677681, -0.0001677681);

// Tree: 53 
woFDN_FL_PS__lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 134.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 47.65) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 17448.5) => -0.0599485726,
         (f_curraddrmedianincome_d > 17448.5) => 0.1083657579,
         (f_curraddrmedianincome_d = NULL) => 0.0728448765, 0.0728448765),
      (c_civ_emp > 47.65) => 0.0016377736,
      (c_civ_emp = NULL) => 0.0104991020, 0.0104991020),
   (k_estimated_income_d > 32500) => -0.0285234615,
   (k_estimated_income_d = NULL) => -0.0359698332, -0.0166762441),
(c_easiqlife > 134.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 0.1313396287,
   (f_attr_arrest_recency_d > 99.5) => 0.0206114924,
   (f_attr_arrest_recency_d = NULL) => 0.0222007668, 0.0222007668),
(c_easiqlife = NULL) => -0.0014131388, -0.0031747185);

// Tree: 54 
woFDN_FL_PS__lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1517002889,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 38.3) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => -0.0220353562,
      (f_sourcerisktype_i > 3.5) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0039808846,
         (f_rel_felony_count_i > 0.5) => 
            map(
            (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 117.5) => 0.1854127372,
            (f_mos_liens_unrel_SC_fseen_d > 117.5) => 0.0309315709,
            (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0400773881, 0.0400773881),
         (f_rel_felony_count_i = NULL) => 0.0084206638, 0.0084206638),
      (f_sourcerisktype_i = NULL) => -0.0030477938, -0.0030477938),
   (c_hval_60k_p > 38.3) => -0.1109876496,
   (c_hval_60k_p = NULL) => -0.0228631995, -0.0043085637),
(f_attr_arrest_recency_d = NULL) => 0.0062382649, -0.0036021708);

// Tree: 55 
woFDN_FL_PS__lgt_55 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 2.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1019020648) => 0.0038309322,
      (f_add_curr_nhood_VAC_pct_i > 0.1019020648) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 10.55) => 0.0114429204,
         (c_hval_150k_p > 10.55) => 0.1438034339,
         (c_hval_150k_p = NULL) => 0.0479137740, 0.0479137740),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0105333446, 0.0105333446),
   (f_inq_Banking_count24_i > 2.5) => 
      map(
      (NULL < c_families and c_families <= 405.5) => 0.1863181410,
      (c_families > 405.5) => 0.0204768288,
      (c_families = NULL) => 0.1011152650, 0.1011152650),
   (f_inq_Banking_count24_i = NULL) => 0.0128724115, 0.0128724115),
(k_estimated_income_d > 34500) => -0.0165664352,
(k_estimated_income_d = NULL) => -0.0007825387, -0.0062340973);

// Tree: 56 
woFDN_FL_PS__lgt_56 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 5.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0157924690,
   (f_phone_ver_experian_d > 0.5) => -0.0171887850,
   (f_phone_ver_experian_d = NULL) => -0.0102949335, -0.0050878970),
(f_inq_HighRiskCredit_count_i > 5.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => -0.0391443043,
   (f_mos_inq_banko_cm_fseen_d > 41.5) => 
      map(
      (NULL < c_rental and c_rental <= 141.5) => 0.1310753597,
      (c_rental > 141.5) => -0.0109325036,
      (c_rental = NULL) => 0.0818459671, 0.0818459671),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0438990183, 0.0438990183),
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 17.4) => -0.0398957078,
   (C_INC_75K_P > 17.4) => 0.0780403421,
   (C_INC_75K_P = NULL) => 0.0137115876, 0.0137115876), -0.0040708325);

// Tree: 57 
woFDN_FL_PS__lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
      map(
      (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 0.0047486127,
      (f_dl_addrs_per_adl_i > 0.5) => -0.0254880647,
      (f_dl_addrs_per_adl_i = NULL) => -0.0070495571, -0.0070495571),
   (f_adls_per_phone_c6_i > 1.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 68.5) => -0.0167029723,
      (r_pb_order_freq_d > 68.5) => 0.2164586540,
      (r_pb_order_freq_d = NULL) => 0.1015198241, 0.1015198241),
   (f_adls_per_phone_c6_i = NULL) => -0.0054990665, -0.0054990665),
(r_D30_Derog_Count_i > 11.5) => 
   map(
   (NULL < c_retail and c_retail <= 16.45) => 0.0304267405,
   (c_retail > 16.45) => 0.1688780084,
   (c_retail = NULL) => 0.0837433778, 0.0837433778),
(r_D30_Derog_Count_i = NULL) => -0.0033009855, -0.0043369989);

// Tree: 58 
woFDN_FL_PS__lgt_58 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 93.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 77.5) => 0.1671195414,
   (c_born_usa > 77.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 82.5) => 0.1298750023,
      (c_bargains > 82.5) => -0.0648228450,
      (c_bargains = NULL) => 0.0105440636, 0.0105440636),
   (c_born_usa = NULL) => 0.0638463539, 0.0638463539),
(f_mos_liens_unrel_SC_fseen_d > 93.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => -0.0071671267,
   (k_inq_per_phone_i > 5.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 20.5) => 0.1103994219,
      (f_srchphonesrchcount_i > 20.5) => -0.0827296815,
      (f_srchphonesrchcount_i = NULL) => 0.0616294463, 0.0616294463),
   (k_inq_per_phone_i = NULL) => -0.0060624538, -0.0060624538),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0079835444, -0.0046267605);

// Tree: 59 
woFDN_FL_PS__lgt_59 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0353535220,
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 0.1121485020,
   (r_C10_M_Hdr_FS_d > 10.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 218.4) => 
            map(
            (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 6.5) => -0.0100050555,
            (f_inq_Other_count_i > 6.5) => 0.1267086040,
            (f_inq_Other_count_i = NULL) => -0.0089273179, -0.0089273179),
         (c_cpiall > 218.4) => 0.0281551974,
         (c_cpiall = NULL) => -0.0126419568, -0.0008299376),
      (f_nae_nothing_found_i > 0.5) => 0.1423167282,
      (f_nae_nothing_found_i = NULL) => 0.0007987681, 0.0007987681),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0302999051, 0.0017679390),
(f_addrs_per_ssn_i = NULL) => -0.0045940678, -0.0045940678);

// Tree: 60 
woFDN_FL_PS__lgt_60 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 93.5) => 
         map(
         (NULL < c_murders and c_murders <= 50) => 0.2184546147,
         (c_murders > 50) => 0.0152491781,
         (c_murders = NULL) => 0.0671501338, 0.0671501338),
      (f_mos_liens_unrel_SC_fseen_d > 93.5) => -0.0031829182,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0018581324, -0.0018581324),
   (k_inq_per_phone_i > 6.5) => 0.0856044271,
   (k_inq_per_phone_i = NULL) => -0.0010386305, -0.0010386305),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0718271298,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 11.75) => 0.0416149994,
   (C_INC_50K_P > 11.75) => -0.0791572643,
   (C_INC_50K_P = NULL) => -0.0127869212, -0.0127869212), -0.0016036647);

// Tree: 61 
woFDN_FL_PS__lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 5.35) => 0.0008389572,
   (c_incollege > 5.35) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1736193590,
      (r_I60_inq_comm_recency_d > 549) => 0.0489499904,
      (r_I60_inq_comm_recency_d = NULL) => 0.1039223104, 0.1039223104),
   (c_incollege = NULL) => 0.0551608902, 0.0551608902),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0070132412,
   (r_C13_Curr_Addr_LRes_d > 158.5) => 0.0229220808,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0002171534, -0.0002171534),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0949925867,
   (c_rnt1000_p > 10.8) => 0.0372470915,
   (c_rnt1000_p = NULL) => -0.0245471506, -0.0245471506), 0.0006288777);

// Tree: 62 
woFDN_FL_PS__lgt_62 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.0902808249,
(f_M_Bureau_ADL_FS_noTU_d > 2.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 20.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 0.0001406992,
         (k_nap_contradictory_i > 0.5) => 0.0468064307,
         (k_nap_contradictory_i = NULL) => 0.0035105888, 0.0035105888),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0599900982,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0009106975, 0.0009106975),
   (f_srchphonesrchcount_i > 20.5) => -0.0868774112,
   (f_srchphonesrchcount_i = NULL) => 0.0003982199, 0.0003982199),
(f_M_Bureau_ADL_FS_noTU_d = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 65.5) => 0.0902974753,
   (c_rental > 65.5) => -0.0347944062,
   (c_rental = NULL) => 0.0301571476, 0.0301571476), 0.0011712399);

// Tree: 63 
woFDN_FL_PS__lgt_63 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 242079.5) => 0.1843880640,
   (r_A46_Curr_AVM_AutoVal_d > 242079.5) => 0.0522574631,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0120770568, 0.0576569207),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < r_nas_fname_verd_d and r_nas_fname_verd_d <= 0.5) => 0.1618836771,
   (r_nas_fname_verd_d > 0.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 19.25) => 0.0006290849,
      (c_hval_80k_p > 19.25) => -0.0456827663,
      (c_hval_80k_p = NULL) => 0.0033424061, -0.0022834333),
   (r_nas_fname_verd_d = NULL) => -0.0016164669, -0.0016164669),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 94) => -0.0796007232,
   (c_no_teens > 94) => 0.0497312745,
   (c_no_teens = NULL) => -0.0069182782, -0.0069182782), -0.0004916056);

// Tree: 64 
woFDN_FL_PS__lgt_64 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 195500) => 0.1508368064,
      (r_A46_Curr_AVM_AutoVal_d > 195500) => 0.0683850635,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0046291097, 0.0481705899),
   (r_C10_M_Hdr_FS_d > 10.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 74.5) => 0.0326576981,
      (r_D32_Mos_Since_Crim_LS_d > 74.5) => -0.0094229349,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0054058479, -0.0054058479),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0042571953, -0.0042571953),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 815) => 0.0224630003,
   (c_med_rent > 815) => 0.2173809592,
   (c_med_rent = NULL) => 0.0998350145, 0.0998350145),
(k_comb_age_d = NULL) => -0.0091968102, -0.0031878893);

// Tree: 65 
woFDN_FL_PS__lgt_65 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 73.5) => -0.0025040736,
   (r_C13_Curr_Addr_LRes_d > 73.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 49.5) => 0.0095810948,
      (k_comb_age_d > 49.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
            map(
            (NULL < C_INC_35K_P and C_INC_35K_P <= 14.45) => 0.1386676573,
            (C_INC_35K_P > 14.45) => -0.0682566665,
            (C_INC_35K_P = NULL) => 0.1156038787, 0.1156038787),
         (f_corrphonelastnamecount_d > 0.5) => 0.0316621504,
         (f_corrphonelastnamecount_d = NULL) => 0.0773936039, 0.0773936039),
      (k_comb_age_d = NULL) => 0.0410106968, 0.0410106968),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0157790446, 0.0157790446),
(f_phone_ver_insurance_d > 3.5) => -0.0136451769,
(f_phone_ver_insurance_d = NULL) => 0.0120432904, 0.0015038918);

// Tree: 66 
woFDN_FL_PS__lgt_66 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0049389992,
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 42633.5) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 3.5) => 0.0462066432,
         (f_rel_homeover300_count_d > 3.5) => 0.2114480957,
         (f_rel_homeover300_count_d = NULL) => 0.0848801746, 0.0848801746),
      (c_med_hhinc > 42633.5) => 0.0149697723,
      (c_med_hhinc = NULL) => 0.0287178431, 0.0287178431),
   (f_hh_collections_ct_i = NULL) => -0.0016642940, -0.0016642940),
(r_D33_eviction_count_i > 3.5) => 0.0796028533,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 97.5) => -0.0724669640,
   (c_medi_indx > 97.5) => 0.0490384389,
   (c_medi_indx = NULL) => 0.0033597160, 0.0033597160), -0.0010790820);

// Tree: 67 
woFDN_FL_PS__lgt_67 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0042638766,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 23) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 17.05) => 0.0607849249,
         (c_hh3_p > 17.05) => 0.2929107969,
         (c_hh3_p = NULL) => 0.1834530687, 0.1834530687),
      (r_pb_order_freq_d > 23) => 0.0161761765,
      (r_pb_order_freq_d = NULL) => 0.0360330879, 0.0676623114),
   (f_phone_ver_experian_d > 0.5) => -0.0016426082,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 6.95) => -0.0902905441,
      (c_pop_18_24_p > 6.95) => 0.0929951821,
      (c_pop_18_24_p = NULL) => 0.0228006487, 0.0228006487), 0.0227682477),
(f_util_adl_count_n = NULL) => -0.0089262426, -0.0010093661);

// Tree: 68 
woFDN_FL_PS__lgt_68 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 306.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0071618127,
   (k_nap_contradictory_i > 0.5) => 0.0347209949,
   (k_nap_contradictory_i = NULL) => -0.0038470388, -0.0038470388),
(r_C13_Curr_Addr_LRes_d > 306.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 0.0328257736,
   (f_srchunvrfdphonecount_i > 0.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 94.5) => 0.0363102958,
      (c_serv_empl > 94.5) => 0.2860931697,
      (c_serv_empl = NULL) => 0.1587528811, 0.1587528811),
   (f_srchunvrfdphonecount_i = NULL) => 0.0497774996, 0.0497774996),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_highrent and c_highrent <= 0.15) => 0.0380999379,
   (c_highrent > 0.15) => -0.0734779307,
   (c_highrent = NULL) => -0.0203456123, -0.0203456123), -0.0007174508);

// Tree: 69 
woFDN_FL_PS__lgt_69 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 133.5) => 
      map(
      (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 224) => 0.0829588382,
      (r_D32_Mos_Since_Fel_LS_d > 224) => -0.0156050134,
      (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0146306179, -0.0146306179),
   (c_easiqlife > 133.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 492.5) => -0.0042232588,
      (r_pb_order_freq_d > 492.5) => 0.0856387003,
      (r_pb_order_freq_d = NULL) => 0.0326971386, 0.0124945800),
   (c_easiqlife = NULL) => -0.0052319248, -0.0050619631),
(f_srchssnsrchcount_i > 22.5) => 0.0760501995,
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < C_INC_201K_P and C_INC_201K_P <= 2.75) => -0.0898833766,
   (C_INC_201K_P > 2.75) => 0.0302230584,
   (C_INC_201K_P = NULL) => -0.0247409034, -0.0247409034), -0.0047412329);

// Tree: 70 
woFDN_FL_PS__lgt_70 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0052838849,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 9.95) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 17.15) => 0.0613745949,
      (c_pop_45_54_p > 17.15) => 0.2907505177,
      (c_pop_45_54_p = NULL) => 0.1359908590, 0.1359908590),
   (C_INC_100K_P > 9.95) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => -0.0179461869,
      (r_C13_Curr_Addr_LRes_d > 310.5) => 0.1015470307,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0136959316, 0.0136959316),
   (C_INC_100K_P = NULL) => 0.0398907160, 0.0398907160),
(k_comb_age_d = NULL) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 14.45) => -0.0478839592,
   (C_INC_100K_P > 14.45) => 0.0753388429,
   (C_INC_100K_P = NULL) => 0.0056081099, 0.0056081099), -0.0023411841);

// Tree: 71 
woFDN_FL_PS__lgt_71 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 1.65) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 0.5) => 0.1157348772,
   (r_C12_source_profile_index_d > 0.5) => -0.0052830951,
   (r_C12_source_profile_index_d = NULL) => -0.0085723726, -0.0040350562),
(c_hh7p_p > 1.65) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 20.9) => 
         map(
         (NULL < C_INC_100K_P and C_INC_100K_P <= 8.25) => -0.0093181455,
         (C_INC_100K_P > 8.25) => 0.2361076653,
         (C_INC_100K_P = NULL) => 0.1220061919, 0.1220061919),
      (c_fammar18_p > 20.9) => 0.0397892477,
      (c_fammar18_p = NULL) => 0.0524380083, 0.0524380083),
   (r_Ever_Asset_Owner_d > 0.5) => 0.0121471116,
   (r_Ever_Asset_Owner_d = NULL) => 0.0215920829, 0.0215920829),
(c_hh7p_p = NULL) => -0.0228476483, 0.0019598334);

// Tree: 72 
woFDN_FL_PS__lgt_72 := map(
(NULL < r_P85_Phn_Invalid_i and r_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0151988161,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 3.5) => 0.1823254264,
         (c_born_usa > 3.5) => 
            map(
            (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 82.05) => 0.0147124733,
            (r_C12_source_profile_d > 82.05) => 0.1505528633,
            (r_C12_source_profile_d = NULL) => 0.0226627686, 0.0226627686),
         (c_born_usa = NULL) => 0.0319949107, 0.0268545643),
      (f_phone_ver_experian_d > 0.5) => -0.0195834047,
      (f_phone_ver_experian_d = NULL) => 0.0122951091, 0.0075638058),
   (f_corrrisktype_i = NULL) => 0.0090283567, -0.0052502914),
(r_P85_Phn_Invalid_i > 0.5) => -0.0763921954,
(r_P85_Phn_Invalid_i = NULL) => -0.0069384044, -0.0069384044);

// Tree: 73 
woFDN_FL_PS__lgt_73 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0025993307,
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 56.5) => -0.0073365635,
      (f_fp_prevaddrburglaryindex_i > 56.5) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 0.7) => 0.1658352707,
         (c_newhouse > 0.7) => 0.0794975417,
         (c_newhouse = NULL) => 0.0997496016, 0.0997496016),
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0611448712, 0.0611448712),
   (f_current_count_d > 0.5) => -0.0190644984,
   (f_current_count_d = NULL) => 0.0249747252, 0.0249747252),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.55) => -0.0581493599,
   (c_pop_55_64_p > 12.55) => 0.0652040678,
   (c_pop_55_64_p = NULL) => -0.0074152888, -0.0074152888), -0.0001216463);

// Tree: 74 
woFDN_FL_PS__lgt_74 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 20.5) => -0.0961805359,
(f_mos_inq_banko_am_fseen_d > 20.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0163627209,
   (f_util_add_curr_conv_n > 0.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
         map(
         (NULL < c_rnt250_p and c_rnt250_p <= 43.1) => 0.0073758552,
         (c_rnt250_p > 43.1) => 
            map(
            (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.1932540339,
            (r_C12_Num_NonDerogs_d > 3.5) => 0.0015199476,
            (r_C12_Num_NonDerogs_d = NULL) => 0.0973869908, 0.0973869908),
         (c_rnt250_p = NULL) => 0.0842412862, 0.0099759734),
      (f_assocsuspicousidcount_i > 13.5) => 0.1119323632,
      (f_assocsuspicousidcount_i = NULL) => 0.0109510671, 0.0109510671),
   (f_util_add_curr_conv_n = NULL) => -0.0011088202, -0.0011088202),
(f_mos_inq_banko_am_fseen_d = NULL) => 0.0315130885, -0.0023792715);

// Tree: 75 
woFDN_FL_PS__lgt_75 := map(
(NULL < c_employees and c_employees <= 37.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 118.5) => 0.0194648635,
      (c_unempl > 118.5) => 0.1772832726,
      (c_unempl = NULL) => 0.1049079512, 0.1049079512),
   (f_rel_incomeover50_count_d > 0.5) => 0.0156913743,
   (f_rel_incomeover50_count_d = NULL) => -0.0086989073, 0.0238887411),
(c_employees > 37.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134.5) => 
      map(
      (NULL < c_rnt250_p and c_rnt250_p <= 20.85) => -0.0149375056,
      (c_rnt250_p > 20.85) => -0.0703073185,
      (c_rnt250_p = NULL) => -0.0185739469, -0.0185739469),
   (f_prevaddrageoldest_d > 134.5) => 0.0137522241,
   (f_prevaddrageoldest_d = NULL) => -0.0167952786, -0.0071680783),
(c_employees = NULL) => -0.0065518098, -0.0033483917);

// Tree: 76 
woFDN_FL_PS__lgt_76 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 33.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 21.5) => -0.0056737374,
      (f_rel_homeover300_count_d > 21.5) => 0.1357418394,
      (f_rel_homeover300_count_d = NULL) => -0.0047860138, -0.0047860138),
   (f_rel_educationover12_count_d > 33.5) => -0.0843228601,
   (f_rel_educationover12_count_d = NULL) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 23.35) => 0.0068242985,
      (c_hh3_p > 23.35) => 0.1674506739,
      (c_hh3_p = NULL) => 0.0351701295, 0.0351701295), -0.0045007955),
(r_S66_adlperssn_count_i > 3.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 7.5) => 0.0334254716,
   (f_rel_under25miles_cnt_d > 7.5) => 0.1647848287,
   (f_rel_under25miles_cnt_d = NULL) => 0.0466495680, 0.0466495680),
(r_S66_adlperssn_count_i = NULL) => -0.0019765442, -0.0019765442);

// Tree: 77 
woFDN_FL_PS__lgt_77 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 16) => -0.0129105329,
   (f_srchphonesrchcount_i > 16) => -0.1222840640,
   (f_srchphonesrchcount_i = NULL) => -0.0064864109, -0.0137337196),
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 128) => 0.2048600573,
      (c_asian_lang > 128) => 0.0124405277,
      (c_asian_lang = NULL) => 0.0826666334, 0.0826666334),
   (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 
      map(
      (NULL < c_transport and c_transport <= 31.75) => 0.0085425926,
      (c_transport > 31.75) => 0.1338996356,
      (c_transport = NULL) => 0.0253953022, 0.0107352261),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0121584952, 0.0121584952),
(f_util_add_curr_conv_n = NULL) => 0.0006054849, 0.0006054849);

// Tree: 78 
woFDN_FL_PS__lgt_78 := map(
(NULL < c_easiqlife and c_easiqlife <= 121.5) => -0.0128127709,
(c_easiqlife > 121.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0328493570,
         (f_varrisktype_i > 3.5) => 
            map(
            (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1731529561,
            (r_Phn_Cell_n > 0.5) => 0.0141078611,
            (r_Phn_Cell_n = NULL) => 0.0876160982, 0.0876160982),
         (f_varrisktype_i = NULL) => 0.0354730455, 0.0354730455),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0729664329,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0278810641, 0.0278810641),
   (f_phone_ver_insurance_d > 3.5) => -0.0050097352,
   (f_phone_ver_insurance_d = NULL) => 0.0113013166, 0.0113013166),
(c_easiqlife = NULL) => -0.0146407123, -0.0025262977);

// Tree: 79 
woFDN_FL_PS__lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0078400230,
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 9.15) => 0.0064254453,
      (c_incollege > 9.15) => 
         map(
         (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 10.5) => 0.0553095202,
         (f_rel_homeover200_count_d > 10.5) => 0.1983428541,
         (f_rel_homeover200_count_d = NULL) => 0.0794641560, 0.0794641560),
      (c_incollege = NULL) => 0.0218408980, 0.0218408980),
   (k_inq_per_ssn_i = NULL) => -0.0042882773, -0.0042882773),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0969907457,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 60) => -0.0649799392,
   (c_old_homes > 60) => 0.0368420188,
   (c_old_homes = NULL) => -0.0055837970, -0.0055837970), -0.0039018358);

// Tree: 80 
woFDN_FL_PS__lgt_80 := map(
(NULL < c_med_rent and c_med_rent <= 1523.5) => -0.0038577658,
(c_med_rent > 1523.5) => 
   map(
   (NULL < c_armforce and c_armforce <= 138.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 215) => 0.0198819224,
      (f_M_Bureau_ADL_FS_all_d > 215) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 252240.5) => -0.0427393850,
         (r_A46_Curr_AVM_AutoVal_d > 252240.5) => 0.1219700345,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.2520517873, 0.1214689556),
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0730884327, 0.0730884327),
   (c_armforce > 138.5) => -0.0732596978,
   (c_armforce = NULL) => 0.0496436078, 0.0496436078),
(c_med_rent = NULL) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => -0.0079819303,
   (f_srchfraudsrchcountyr_i > 0.5) => 0.1608179780,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0175165453, 0.0175165453), 0.0009404330);

// Tree: 81 
woFDN_FL_PS__lgt_81 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 22.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0060106889,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 46.65) => 
         map(
         (NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => 
            map(
            (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.1825152656,
            (f_hh_age_18_plus_d > 1.5) => 0.0292763587,
            (f_hh_age_18_plus_d = NULL) => 0.0653726345, 0.0653726345),
         (f_inq_count24_i > 2.5) => -0.0095826968,
         (f_inq_count24_i = NULL) => 0.0220588596, 0.0220588596),
      (c_rnt1000_p > 46.65) => 0.1327184005,
      (c_rnt1000_p = NULL) => 0.0340870706, 0.0340870706),
   (k_inq_per_phone_i = NULL) => -0.0040701126, -0.0040701126),
(f_srchphonesrchcount_i > 22.5) => -0.1025739865,
(f_srchphonesrchcount_i = NULL) => -0.0148607363, -0.0046138585);

// Tree: 82 
woFDN_FL_PS__lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => -0.0076838725,
   (f_srchphonesrchcount_i > 1.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 0.0199943623,
      (f_inq_HighRiskCredit_count_i > 2.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 32.05) => 0.0039344103,
         (c_fammar18_p > 32.05) => 0.1984389204,
         (c_fammar18_p = NULL) => 0.0916208698, 0.0916208698),
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0233283699, 0.0233283699),
   (f_srchphonesrchcount_i = NULL) => -0.0011467093, -0.0011467093),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 92.5) => 0.0127113885,
   (c_new_homes > 92.5) => -0.1177806747,
   (c_new_homes = NULL) => -0.0624520399, -0.0624520399),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0161181408, -0.0015793301);

// Tree: 83 
woFDN_FL_PS__lgt_83 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 241.75) => 
      map(
      (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0262824577,
      (k_nap_contradictory_i > 0.5) => 
         map(
         (NULL < c_unattach and c_unattach <= 93.5) => -0.0239304811,
         (c_unattach > 93.5) => 0.0741714294,
         (c_unattach = NULL) => 0.0333711894, 0.0333711894),
      (k_nap_contradictory_i = NULL) => -0.0210679444, -0.0210679444),
   (c_housingcpi > 241.75) => 0.0344337736,
   (c_housingcpi = NULL) => -0.0466963289, -0.0136546415),
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.76799475115) => 0.0156506681,
   (f_add_curr_mobility_index_i > 0.76799475115) => -0.1055382734,
   (f_add_curr_mobility_index_i = NULL) => 0.1285710561, 0.0158934760),
(k_inq_per_ssn_i = NULL) => -0.0016886439, -0.0016886439);

// Tree: 84 
woFDN_FL_PS__lgt_84 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 7.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 77.45) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 193.5) => -0.0002891099,
      (c_span_lang > 193.5) => 0.0697420191,
      (c_span_lang = NULL) => 0.0012185954, 0.0012185954),
   (c_low_ed > 77.45) => -0.0517837606,
   (c_low_ed = NULL) => 0.0081995996, -0.0001032764),
(f_hh_tot_derog_i > 7.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 36.55) => -0.0052754015,
   (c_med_age > 36.55) => 0.1796661910,
   (c_med_age = NULL) => 0.0871953947, 0.0871953947),
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 9.6) => -0.0437062627,
   (c_newhouse > 9.6) => 0.0634155939,
   (c_newhouse = NULL) => 0.0152522785, 0.0152522785), 0.0008216303);

// Tree: 85 
woFDN_FL_PS__lgt_85 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 2.5) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.7954753738) => 0.0127481105,
      (f_add_curr_nhood_SFD_pct_d > 0.7954753738) => 0.2078727386,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.1049888438, 0.1049888438),
   (r_C13_max_lres_d > 2.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 5.05) => -0.0144743753,
      (c_femdiv_p > 5.05) => 0.0110958273,
      (c_femdiv_p = NULL) => 0.0178279804, -0.0038815452),
   (r_C13_max_lres_d = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0713627967,
      (f_addrs_per_ssn_i > 3.5) => 0.0412051548,
      (f_addrs_per_ssn_i = NULL) => -0.0196922616, -0.0196922616), -0.0030741912),
(k_inq_adls_per_phone_i > 2.5) => -0.0759395103,
(k_inq_adls_per_phone_i = NULL) => -0.0036830776, -0.0036830776);

// Tree: 86 
woFDN_FL_PS__lgt_86 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 4.75) => 0.0129409520,
   (c_pop_85p_p > 4.75) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1860644631,
      (f_phone_ver_experian_d > 0.5) => 0.0215664702,
      (f_phone_ver_experian_d = NULL) => 0.0838135688, 0.0927224739),
   (c_pop_85p_p = NULL) => 0.0419559192, 0.0204165997),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 4.5) => -0.0103017942,
   (r_S66_adlperssn_count_i > 4.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 72.5) => -0.0176356143,
      (c_no_car > 72.5) => 0.1642880984,
      (c_no_car = NULL) => 0.0863207929, 0.0863207929),
   (r_S66_adlperssn_count_i = NULL) => -0.0087730170, -0.0087730170),
(f_hh_members_ct_d = NULL) => -0.0119676439, -0.0028839858);

// Tree: 87 
woFDN_FL_PS__lgt_87 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 22.5) => -0.0024414689,
   (f_rel_ageover30_count_d > 22.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 549) => -0.1130737212,
      (r_I60_inq_hiRiskCred_recency_d > 549) => -0.0359790310,
      (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0488281460, -0.0488281460),
   (f_rel_ageover30_count_d = NULL) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0405233617) => -0.0453853443,
      (f_add_curr_nhood_VAC_pct_i > 0.0405233617) => 0.1082289379,
      (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0041370648, -0.0041370648), -0.0038898596),
(f_hh_collections_ct_i > 4.5) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 9.75) => 0.1712951119,
   (c_blue_col > 9.75) => 0.0195586845,
   (c_blue_col = NULL) => 0.0734006426, 0.0734006426),
(f_hh_collections_ct_i = NULL) => 0.0116118398, -0.0025720719);

// Tree: 88 
woFDN_FL_PS__lgt_88 := map(
(NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 2.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0040514931,
   (k_inq_per_ssn_i > 1.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 6.5) => 0.0174004639,
         (f_varrisktype_i > 6.5) => 0.0968845589,
         (f_varrisktype_i = NULL) => 0.0200064998, 0.0200064998),
      (k_comb_age_d > 69.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 25.7) => 0.0078407324,
         (C_RENTOCC_P > 25.7) => 0.2386561621,
         (C_RENTOCC_P = NULL) => 0.1088224829, 0.1088224829),
      (k_comb_age_d = NULL) => 0.0244663136, 0.0244663136),
   (k_inq_per_ssn_i = NULL) => 0.0018009994, 0.0018009994),
(f_srchphonesrchcountmo_i > 2.5) => -0.1014464847,
(f_srchphonesrchcountmo_i = NULL) => -0.0223072350, 0.0011811731);

// Tree: 89 
woFDN_FL_PS__lgt_89 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 283.5) => -0.0067589428,
   (r_C13_Curr_Addr_LRes_d > 283.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 45.25) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.272280419) => 0.1745715729,
         (f_add_curr_nhood_SFD_pct_d > 0.272280419) => 0.0110953792,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0205956405, 0.0205956405),
      (c_hval_750k_p > 45.25) => 0.2648486339,
      (c_hval_750k_p = NULL) => 0.0349634636, 0.0349634636),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0034369883, -0.0034369883),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 676.5) => 0.1239432366,
   (r_A50_pb_total_dollars_d > 676.5) => -0.0391181268,
   (r_A50_pb_total_dollars_d = NULL) => 0.0517481292, 0.0517481292),
(r_D33_eviction_count_i = NULL) => 0.0159504416, -0.0026852063);

// Tree: 90 
woFDN_FL_PS__lgt_90 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.0900067733,
   (r_D32_Mos_Since_Fel_LS_d > 117) => 
      map(
      (NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => -0.0034880148,
      (f_srchphonesrchcountwk_i > 0.5) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 43.4) => 0.1685230903,
         (c_low_ed > 43.4) => -0.0127504506,
         (c_low_ed = NULL) => 0.0778863199, 0.0778863199),
      (f_srchphonesrchcountwk_i = NULL) => -0.0026774092, -0.0026774092),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0021812175, -0.0021812175),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0951240728,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.75) => -0.0767532839,
   (c_pop_6_11_p > 7.75) => 0.0288278198,
   (c_pop_6_11_p = NULL) => -0.0211346667, -0.0211346667), -0.0027501977);

// Tree: 91 
woFDN_FL_PS__lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_child and c_child <= 23.85) => 0.1074118886,
      (c_child > 23.85) => -0.1168770355,
      (c_child = NULL) => 0.0089435804, 0.0089435804),
   (nf_seg_FraudPoint_3_0 in ['3: Derog','6: Other']) => 0.1527032095,
   (nf_seg_FraudPoint_3_0 = '') => 0.0667225701, 0.0667225701),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 804700) => -0.0066541241,
   (f_curraddrmedianvalue_d > 804700) => 0.0677939116,
   (f_curraddrmedianvalue_d = NULL) => -0.0054119164, -0.0054119164),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0403244303,
   (r_Phn_Cell_n > 0.5) => -0.0577257731,
   (r_Phn_Cell_n = NULL) => 0.0008003173, 0.0008003173), -0.0041602423);

// Tree: 92 
woFDN_FL_PS__lgt_92 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 69.5) => -0.0019745666,
(k_comb_age_d > 69.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 28.85) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 48.5) => -0.0016642402,
      (f_curraddrcartheftindex_i > 48.5) => 
         map(
         (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 2.5) => 0.2830079038,
         (f_hh_members_ct_d > 2.5) => 0.0594000038,
         (f_hh_members_ct_d = NULL) => 0.1455304542, 0.1455304542),
      (f_curraddrcartheftindex_i = NULL) => 0.1057481043, 0.1057481043),
   (c_hh2_p > 28.85) => 0.0185716565,
   (c_hh2_p = NULL) => 0.0421397078, 0.0421397078),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 94.5) => 0.0486914006,
   (c_rental > 94.5) => -0.0680729900,
   (c_rental = NULL) => -0.0121032821, -0.0121032821), 0.0004025246);

// Tree: 93 
woFDN_FL_PS__lgt_93 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0057786000,
   (f_hh_collections_ct_i > 1.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 5.65) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => 0.0305061801,
         (k_inq_per_ssn_i > 1.5) => 0.1055855268,
         (k_inq_per_ssn_i = NULL) => 0.0489218689, 0.0489218689),
      (c_vacant_p > 5.65) => 0.0000841747,
      (c_vacant_p = NULL) => 0.0426880108, 0.0204569822),
   (f_hh_collections_ct_i = NULL) => 0.0014802401, 0.0014802401),
(r_D33_eviction_count_i > 3.5) => 0.0775094327,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 3.55) => 0.0589357394,
   (c_hval_300k_p > 3.55) => -0.0611123471,
   (c_hval_300k_p = NULL) => -0.0033114166, -0.0033114166), 0.0019230393);

// Tree: 94 
woFDN_FL_PS__lgt_94 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 28.5) => -0.1044496386,
(f_mos_liens_unrel_OT_fseen_d > 28.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 70.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 1.45) => 0.1278112712,
      (c_pop_65_74_p > 1.45) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 0.0894903484,
         (r_C12_Num_NonDerogs_d > 1.5) => 
            map(
            (NULL < c_relig_indx and c_relig_indx <= 189.5) => 0.0020060275,
            (c_relig_indx > 189.5) => 0.1345351396,
            (c_relig_indx = NULL) => 0.0096085726, 0.0096085726),
         (r_C12_Num_NonDerogs_d = NULL) => 0.0153401621, 0.0153401621),
      (c_pop_65_74_p = NULL) => 0.0455015159, 0.0224377148),
   (f_mos_inq_banko_cm_lseen_d > 70.5) => -0.0022169082,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0025977061, 0.0025977061),
(f_mos_liens_unrel_OT_fseen_d = NULL) => -0.0097333666, 0.0017631285);

// Tree: 95 
woFDN_FL_PS__lgt_95 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 27.35) => -0.0076994389,
(c_hval_500k_p > 27.35) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 17.15) => -0.0082738266,
   (c_hh3_p > 17.15) => 
      map(
      (NULL < c_pop_85p_p and c_pop_85p_p <= 0.85) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.027422418) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2467854491) => 0.2120206710,
            (f_add_curr_mobility_index_i > 0.2467854491) => 0.0001727040,
            (f_add_curr_mobility_index_i = NULL) => 0.1155244766, 0.1155244766),
         (f_add_curr_nhood_VAC_pct_i > 0.027422418) => 0.3017182687,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1541538941, 0.1541538941),
      (c_pop_85p_p > 0.85) => 0.0031818640,
      (c_pop_85p_p = NULL) => 0.0876000989, 0.0876000989),
   (c_hh3_p = NULL) => 0.0405120788, 0.0405120788),
(c_hval_500k_p = NULL) => 0.0113326438, -0.0039971538);

// Tree: 96 
woFDN_FL_PS__lgt_96 := map(
(NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13918900825) => -0.0056524554,
   (f_add_curr_nhood_BUS_pct_i > 0.13918900825) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0093180378,
      (f_rel_felony_count_i > 0.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 7.55) => 0.0498347652,
         (c_incollege > 7.55) => 0.2145858822,
         (c_incollege = NULL) => 0.0971568946, 0.0971568946),
      (f_rel_felony_count_i = NULL) => 0.0215071302, 0.0215071302),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0330827313, -0.0042480934),
(f_assoccredbureaucountmo_i > 0.5) => 0.1277678705,
(f_assoccredbureaucountmo_i = NULL) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 100.5) => -0.0380459273,
   (c_medi_indx > 100.5) => 0.0630919028,
   (c_medi_indx = NULL) => 0.0137563759, 0.0137563759), -0.0033719694);

// Tree: 97 
woFDN_FL_PS__lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 34) => 0.1053724853,
      (c_high_ed > 34) => -0.0231869806,
      (c_high_ed = NULL) => 0.0388240559, 0.0388240559),
   (r_C10_M_Hdr_FS_d > 13.5) => -0.0039966672,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0028048105, -0.0028048105),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1405986249,
   (r_A50_pb_average_dollars_d > 99) => -0.0160029867,
   (r_A50_pb_average_dollars_d = NULL) => 0.0541545353, 0.0541545353),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < k_nap_nothing_found_i and k_nap_nothing_found_i <= 0.5) => -0.0721674184,
   (k_nap_nothing_found_i > 0.5) => 0.0354629975,
   (k_nap_nothing_found_i = NULL) => -0.0129289725, -0.0129289725), -0.0023464817);

// Tree: 98 
woFDN_FL_PS__lgt_98 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 55065) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 28) => 0.2488017910,
      (c_cartheft > 28) => 0.0344922280,
      (c_cartheft = NULL) => 0.0126428397, 0.0429305858),
   (f_curraddrmedianincome_d > 55065) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 3.5) => 0.0797191770,
      (f_prevaddrageoldest_d > 3.5) => -0.0218254583,
      (f_prevaddrageoldest_d = NULL) => -0.0125530083, -0.0125530083),
   (f_curraddrmedianincome_d = NULL) => 0.0125622797, 0.0125622797),
(f_hh_members_ct_d > 1.5) => -0.0098027847,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 98) => 0.0679263182,
   (c_apt20 > 98) => -0.0404037198,
   (c_apt20 = NULL) => 0.0175623532, 0.0175623532), -0.0052096030);

// Tree: 99 
woFDN_FL_PS__lgt_99 := map(
(NULL < c_bel_edu and c_bel_edu <= 198.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 1.85) => -0.0046308105,
      (c_hh6_p > 1.85) => 0.1733383900,
      (c_hh6_p = NULL) => 0.0892973787, 0.0892973787),
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0119190107,
      (f_util_add_curr_conv_n > 0.5) => 0.0139868393,
      (f_util_add_curr_conv_n = NULL) => 0.0026295878, 0.0026295878),
   (f_hh_age_18_plus_d = NULL) => 
      map(
      (NULL < c_preschl and c_preschl <= 95) => 0.0749939892,
      (c_preschl > 95) => -0.0464924810,
      (c_preschl = NULL) => 0.0103318357, 0.0103318357), 0.0034669285),
(c_bel_edu > 198.5) => -0.1303632570,
(c_bel_edu = NULL) => -0.0048260242, 0.0026932405);

// Tree: 100 
woFDN_FL_PS__lgt_100 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 89.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 52.15) => 0.1326071727,
   (r_C12_source_profile_d > 52.15) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 92.5) => 0.0673923604,
      (c_no_teens > 92.5) => -0.0815477521,
      (c_no_teens = NULL) => -0.0049499800, -0.0049499800),
   (r_C12_source_profile_d = NULL) => 0.0440429785, 0.0440429785),
(f_mos_liens_unrel_SC_fseen_d > 89.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.45) => -0.0187990814,
   (c_hh4_p > 12.45) => 0.0063063716,
   (c_hh4_p = NULL) => -0.0154636384, -0.0046384210),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < k_nap_nothing_found_i and k_nap_nothing_found_i <= 0.5) => -0.0386776633,
   (k_nap_nothing_found_i > 0.5) => 0.0743271057,
   (k_nap_nothing_found_i = NULL) => 0.0243086014, 0.0243086014), -0.0035195591);

// Tree: 101 
woFDN_FL_PS__lgt_101 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 0.0004767954,
   (r_D31_ALL_Bk_i > 1.5) => -0.0372363049,
   (r_D31_ALL_Bk_i = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => 0.0217442819,
      (c_hval_250k_p > 8.05) => -0.0776443236,
      (c_hval_250k_p = NULL) => -0.0206180746, -0.0206180746), -0.0031479272),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 2.35) => -0.0343299594,
   (c_high_hval > 2.35) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0301913091,
      (r_E57_br_source_count_d > 0.5) => 0.3784676659,
      (r_E57_br_source_count_d = NULL) => 0.2027884417, 0.2027884417),
   (c_high_hval = NULL) => 0.0906378466, 0.0906378466),
(r_P85_Phn_Disconnected_i = NULL) => -0.0014252559, -0.0014252559);

// Tree: 102 
woFDN_FL_PS__lgt_102 := map(
(NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0148792429,
(c_hh4_p > 11.55) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.3) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 81.05) => 
         map(
         (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 5.5) => 
            map(
            (NULL < c_hh2_p and c_hh2_p <= 20.75) => 0.0467592774,
            (c_hh2_p > 20.75) => 0.0037853729,
            (c_hh2_p = NULL) => 0.0084029987, 0.0084029987),
         (r_E57_br_source_count_d > 5.5) => 0.1337236922,
         (r_E57_br_source_count_d = NULL) => 0.0102185483, 0.0112314776),
      (c_low_ed > 81.05) => -0.0896935787,
      (c_low_ed = NULL) => 0.0098187152, 0.0098187152),
   (c_pop_0_5_p > 19.3) => 0.1818428744,
   (c_pop_0_5_p = NULL) => 0.0111386519, 0.0111386519),
(c_hh4_p = NULL) => 0.0082356587, 0.0012717273);

// Tree: 103 
woFDN_FL_PS__lgt_103 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < f_accident_count_i and f_accident_count_i <= 2.5) => -0.0036162767,
   (f_accident_count_i > 2.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.05) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 56.65) => 0.0119863613,
         (c_civ_emp > 56.65) => 0.2824019134,
         (c_civ_emp = NULL) => 0.1665095340, 0.1665095340),
      (c_pop_45_54_p > 16.05) => -0.0597908293,
      (c_pop_45_54_p = NULL) => 0.0898188553, 0.0898188553),
   (f_accident_count_i = NULL) => -0.0022535719, -0.0022535719),
(r_D34_unrel_liens_ct_i > 7.5) => 0.0977702005,
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 430) => -0.0537495825,
   (c_families > 430) => 0.0513134878,
   (c_families = NULL) => -0.0056974806, -0.0056974806), -0.0017222177);

// Tree: 104 
woFDN_FL_PS__lgt_104 := map(
(NULL < c_serv_empl and c_serv_empl <= 198.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 3.5) => 
         map(
         (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0479113451,
         (f_mos_inq_banko_om_fseen_d > 5.5) => 0.0024980602,
         (f_mos_inq_banko_om_fseen_d = NULL) => 0.0004168026, 0.0004168026),
      (r_D34_UnRel_Lien60_Count_i > 3.5) => -0.1144899467,
      (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0003246942, -0.0000857414),
   (k_inq_per_phone_i > 6.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 12.15) => 0.1285777614,
      (c_newhouse > 12.15) => -0.0036739185,
      (c_newhouse = NULL) => 0.0595407209, 0.0595407209),
   (k_inq_per_phone_i = NULL) => 0.0006850397, 0.0006850397),
(c_serv_empl > 198.5) => 0.1518846502,
(c_serv_empl = NULL) => -0.0000271551, 0.0015496261);

// Tree: 105 
woFDN_FL_PS__lgt_105 := map(
(NULL < c_finance and c_finance <= 0.15) => 
   map(
   (NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 60.5) => 0.1380624598,
   (f_mos_liens_unrel_OT_fseen_d > 60.5) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 156.5) => -0.0508290943,
      (f_mos_liens_unrel_CJ_fseen_d > 156.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 216.5) => 0.0135287571,
         (r_pb_order_freq_d > 216.5) => -0.0423211901,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1670251829) => 0.0277584910,
            (f_add_curr_nhood_VAC_pct_i > 0.1670251829) => 0.1101387260,
            (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0360961469, 0.0360961469), 0.0173214545),
      (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0135848298, 0.0135848298),
   (f_mos_liens_unrel_OT_fseen_d = NULL) => 0.0151307517, 0.0151307517),
(c_finance > 0.15) => -0.0107239867,
(c_finance = NULL) => 0.0050982759, -0.0020578815);

// Tree: 106 
woFDN_FL_PS__lgt_106 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 50.85) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 55.5) => -0.0103531822,
   (k_comb_age_d > 55.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 191.5) => 
         map(
         (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 7.5) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 49321.5) => 0.0514494305,
            (f_prevaddrmedianincome_d > 49321.5) => -0.0128340246,
            (f_prevaddrmedianincome_d = NULL) => 0.0099101217, 0.0099101217),
         (f_srchphonesrchcount_i > 7.5) => 0.1716718001,
         (f_srchphonesrchcount_i = NULL) => 0.0135376165, 0.0135376165),
      (c_sub_bus > 191.5) => 0.1438659168,
      (c_sub_bus = NULL) => 0.0174301653, 0.0174301653),
   (k_comb_age_d = NULL) => -0.0046483503, -0.0041580116),
(c_hval_500k_p > 50.85) => 0.1236155469,
(c_hval_500k_p = NULL) => -0.0285544881, -0.0038255988);

// Tree: 107 
woFDN_FL_PS__lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0967963327,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 55.5) => 0.0154969609,
      (r_C13_Curr_Addr_LRes_d > 55.5) => 0.2143934155,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.1140157655, 0.1140157655),
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => -0.0029508681,
      (r_D30_Derog_Count_i > 11.5) => 0.0504688766,
      (r_D30_Derog_Count_i = NULL) => -0.0022951465, -0.0022951465),
   (f_hh_age_18_plus_d = NULL) => -0.0012894961, -0.0012894961),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 17.7) => -0.0505770568,
   (c_rnt750_p > 17.7) => 0.0479463495,
   (c_rnt750_p = NULL) => -0.0032100345, -0.0032100345), -0.0006250913);

// Tree: 108 
woFDN_FL_PS__lgt_108 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0109150617,
(f_corrrisktype_i > 8.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0112550543,
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 2.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04046722315) => 0.0300191740,
         (f_add_curr_nhood_BUS_pct_i > 0.04046722315) => 
            map(
            (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 2.5) => 0.2097733204,
            (f_rel_under25miles_cnt_d > 2.5) => 0.0388637298,
            (f_rel_under25miles_cnt_d = NULL) => 0.1250616103, 0.1250616103),
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0771307265, 0.0771307265),
      (f_current_count_d > 2.5) => -0.0501105296,
      (f_current_count_d = NULL) => 0.0491216449, 0.0491216449),
   (f_rel_felony_count_i = NULL) => 0.0134262724, 0.0134262724),
(f_corrrisktype_i = NULL) => -0.0085641115, -0.0002505640);

// Tree: 109 
woFDN_FL_PS__lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 20) => -0.0206952456,
      (f_curraddrburglaryindex_i > 20) => 0.0137709243,
      (f_curraddrburglaryindex_i = NULL) => 0.0073040345, 0.0073040345),
   (f_srchssnsrchcount_i > 22.5) => 0.1155831470,
   (f_srchssnsrchcount_i = NULL) => 0.0077528040, 0.0077528040),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 21.5) => -0.0807376824,
   (f_mos_inq_banko_cm_lseen_d > 21.5) => -0.0024141341,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0268204536, -0.0268204536),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.3) => 0.0614482125,
   (c_bigapt_p > 1.3) => -0.0598092344,
   (c_bigapt_p = NULL) => 0.0137090602, 0.0137090602), 0.0064756139);

// Tree: 110 
woFDN_FL_PS__lgt_110 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 63.5) => -0.0036070839,
(k_comb_age_d > 63.5) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 1.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 1978.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 4.35) => 0.0441212856,
         (c_hval_750k_p > 4.35) => -0.0694794600,
         (c_hval_750k_p = NULL) => -0.0036603108, -0.0036603108),
      (r_A50_pb_average_dollars_d > 1978.5) => 
         map(
         (NULL < c_work_home and c_work_home <= 161.5) => 0.1115135431,
         (c_work_home > 161.5) => -0.0455675833,
         (c_work_home = NULL) => 0.0820608319, 0.0820608319),
      (r_A50_pb_average_dollars_d = NULL) => 0.0195127993, 0.0195127993),
   (f_inq_Other_count24_i > 1.5) => 0.2282522401,
   (f_inq_Other_count24_i = NULL) => 0.0275237988, 0.0275237988),
(k_comb_age_d = NULL) => -0.0248135803, -0.0004369067);

// Tree: 111 
woFDN_FL_PS__lgt_111 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 84) => 0.1687566131,
   (c_rich_fam > 84) => -0.0029736545,
   (c_rich_fam = NULL) => 0.0730131896, 0.0730131896),
(r_D33_Eviction_Recency_d > 30) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 25.5) => 0.1472093148,
      (c_many_cars > 25.5) => 0.0304882496,
      (c_many_cars = NULL) => 0.0410636481, 0.0410636481),
   (r_I61_inq_collection_recency_d > 9) => 0.0008534915,
   (r_I61_inq_collection_recency_d = NULL) => 0.0028202400, 0.0028202400),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 4) => 0.0401505071,
   (c_hval_500k_p > 4) => -0.0700769839,
   (c_hval_500k_p = NULL) => -0.0163764113, -0.0163764113), 0.0032694634);

// Tree: 112 
woFDN_FL_PS__lgt_112 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_adl_util_inf_n and f_adl_util_inf_n <= 0.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0034563290,
      (r_C14_Addr_Stability_v2_d > 5.5) => 0.0266426394,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0082331030, 0.0082331030),
   (f_adl_util_inf_n > 0.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 6.6) => 0.1574370193,
      (c_hval_500k_p > 6.6) => -0.0179688685,
      (c_hval_500k_p = NULL) => 0.0772514706, 0.0772514706),
   (f_adl_util_inf_n = NULL) => 0.0101345532, 0.0101345532),
(f_phone_ver_insurance_d > 3.5) => -0.0160405557,
(f_phone_ver_insurance_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0266063594,
   (c_rnt1000_p > 10.8) => 0.0738866390,
   (c_rnt1000_p = NULL) => 0.0240770659, 0.0240770659), -0.0023352930);

// Tree: 113 
woFDN_FL_PS__lgt_113 := map(
(NULL < c_civ_emp and c_civ_emp <= 32.15) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 42) => 0.1664951739,
   (f_prevaddrlenofres_d > 42) => -0.0108464818,
   (f_prevaddrlenofres_d = NULL) => 0.0793531534, 0.0793531534),
(c_civ_emp > 32.15) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 1.5) => 0.0103487238,
      (f_hh_members_w_derog_i > 1.5) => 0.1180507213,
      (f_hh_members_w_derog_i = NULL) => 0.0382343573, 0.0382343573),
   (f_corrssnnamecount_d > 1.5) => -0.0063590742,
   (f_corrssnnamecount_d = NULL) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 2.625) => 0.0769687382,
      (c_hhsize > 2.625) => -0.0434814714,
      (c_hhsize = NULL) => 0.0197548886, 0.0197548886), -0.0037574071),
(c_civ_emp = NULL) => 0.0274132496, -0.0022339938);

// Tree: 114 
woFDN_FL_PS__lgt_114 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0912805032,
   (C_INC_100K_P > 1.35) => 
      map(
      (NULL < f_liens_rel_O_total_amt_i and f_liens_rel_O_total_amt_i <= 54.5) => 
         map(
         (NULL < c_rich_blk and c_rich_blk <= 181.5) => -0.0096470391,
         (c_rich_blk > 181.5) => 0.0248143138,
         (c_rich_blk = NULL) => -0.0050193553, -0.0050193553),
      (f_liens_rel_O_total_amt_i > 54.5) => -0.0987196774,
      (f_liens_rel_O_total_amt_i = NULL) => -0.0192561931, -0.0060692874),
   (C_INC_100K_P = NULL) => 
      map(
      (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0235915144,
      (f_vardobcountnew_i > 0.5) => 0.1541322573,
      (f_vardobcountnew_i = NULL) => 0.0065115349, 0.0065115349), -0.0052829208),
(k_inq_adls_per_phone_i > 3.5) => -0.0931145319,
(k_inq_adls_per_phone_i = NULL) => -0.0056291235, -0.0056291235);

// Tree: 115 
woFDN_FL_PS__lgt_115 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0626841383,
(r_D33_Eviction_Recency_d > 30) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.05) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3871138769) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 19.1) => -0.0745895227,
         (c_fammar_p > 19.1) => 0.0022591219,
         (c_fammar_p = NULL) => 0.0017415729, 0.0017415729),
      (f_add_curr_mobility_index_i > 0.3871138769) => -0.0251494811,
      (f_add_curr_mobility_index_i = NULL) => -0.0019732278, -0.0019732278),
   (c_pop_0_5_p > 21.05) => 0.1227355313,
   (c_pop_0_5_p = NULL) => 0.0045301466, -0.0012900225),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 83) => -0.0767714001,
   (c_lar_fam > 83) => 0.0373370527,
   (c_lar_fam = NULL) => -0.0074912681, -0.0074912681), -0.0008671541);

// Tree: 116 
woFDN_FL_PS__lgt_116 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 71.5) => -0.1196544955,
   (f_mos_liens_rel_SC_lseen_d > 71.5) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => -0.0007801980,
      (k_inq_adls_per_phone_i > 3.5) => -0.0804458485,
      (k_inq_adls_per_phone_i = NULL) => -0.0011163400, -0.0011163400),
   (f_mos_liens_rel_SC_lseen_d = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 6.3) => 0.0495795500,
      (c_hval_250k_p > 6.3) => -0.0510976235,
      (c_hval_250k_p = NULL) => 0.0028082647, 0.0028082647), -0.0015589827),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 16.25) => 0.0327193682,
   (C_INC_50K_P > 16.25) => 0.2696848820,
   (C_INC_50K_P = NULL) => 0.1042061713, 0.1042061713),
(f_adls_per_phone_c6_i = NULL) => -0.0000581764, -0.0000581764);

// Tree: 117 
woFDN_FL_PS__lgt_117 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 75.25) => 0.1725416558,
   (c_fammar_p > 75.25) => 0.0174041444,
   (c_fammar_p = NULL) => 0.0934519441, 0.0934519441),
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 3.5) => 0.0749591200,
   (r_C21_M_Bureau_ADL_FS_d > 3.5) => 
      map(
      (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0080412711,
      (r_F04_curr_add_occ_index_d > 2) => 0.0206336500,
      (r_F04_curr_add_occ_index_d = NULL) => -0.0017826901, -0.0017826901),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0012159662, -0.0012159662),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_health and c_health <= 8.65) => -0.0648630245,
   (c_health > 8.65) => 0.0279824325,
   (c_health = NULL) => -0.0184402960, -0.0184402960), -0.0005803693);

// Tree: 118 
woFDN_FL_PS__lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0060529827,
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 5.25) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 46.2) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 7.5) => -0.0471965615,
         (c_hval_150k_p > 7.5) => 0.1000738733,
         (c_hval_150k_p = NULL) => -0.0036165348, -0.0036165348),
      (c_newhouse > 46.2) => 0.1577423257,
      (c_newhouse = NULL) => 0.0297004769, 0.0297004769),
   (c_hh6_p > 5.25) => 0.1515210956,
   (c_hh6_p = NULL) => 0.0508866714, 0.0508866714),
(f_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 5.75) => 0.0257771867,
   (c_construction > 5.75) => -0.0665980575,
   (c_construction = NULL) => -0.0281083724, -0.0281083724), -0.0048934478);

// Tree: 119 
woFDN_FL_PS__lgt_119 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0061823407,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 23.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 69.5) => -0.0846506800,
      (c_mort_indx > 69.5) => 
         map(
         (NULL < c_construction and c_construction <= 1.05) => 0.0801242483,
         (c_construction > 1.05) => 
            map(
            (NULL < c_rich_nfam and c_rich_nfam <= 133) => 0.0451037877,
            (c_rich_nfam > 133) => -0.0821675545,
            (c_rich_nfam = NULL) => -0.0223122203, -0.0223122203),
         (c_construction = NULL) => 0.0090171464, 0.0090171464),
      (c_mort_indx = NULL) => -0.0188117006, -0.0188117006),
   (f_rel_homeover50_count_d > 23.5) => -0.1411308689,
   (f_rel_homeover50_count_d = NULL) => -0.0352728723, -0.0352728723),
(f_srchssnsrchcount_i = NULL) => -0.0154152504, 0.0043625136);

// Tree: 120 
woFDN_FL_PS__lgt_120 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 265.85) => 
      map(
      (NULL < c_unattach and c_unattach <= 153.5) => 0.0006951309,
      (c_unattach > 153.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0365748121,
         (f_varrisktype_i > 2.5) => 0.1323980879,
         (f_varrisktype_i = NULL) => 0.0529889843, 0.0529889843),
      (c_unattach = NULL) => 0.0027438246, 0.0027438246),
   (c_oldhouse > 265.85) => -0.0314142381,
   (c_oldhouse = NULL) => -0.0341249438, -0.0013604106),
(f_rel_felony_count_i > 4.5) => 0.0814857793,
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0409670771,
   (f_addrs_per_ssn_i > 5.5) => 0.0794251817,
   (f_addrs_per_ssn_i = NULL) => 0.0128926177, 0.0128926177), -0.0008078014);

// Tree: 121 
woFDN_FL_PS__lgt_121 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0456835764,
(f_mos_inq_banko_om_fseen_d > 5.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 16.15) => 
      map(
      (NULL < c_incollege and c_incollege <= 2.75) => -0.0245443464,
      (c_incollege > 2.75) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 50.45) => 0.1744109223,
         (C_RENTOCC_P > 50.45) => 0.0145065857,
         (C_RENTOCC_P = NULL) => 0.0906962990, 0.0906962990),
      (c_incollege = NULL) => 0.0432442685, 0.0432442685),
   (c_white_col > 16.15) => -0.0011536243,
   (c_white_col = NULL) => 0.0036436080, 0.0000218815),
(f_mos_inq_banko_om_fseen_d = NULL) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 4.55) => 0.0588244736,
   (c_hval_300k_p > 4.55) => -0.0625443720,
   (c_hval_300k_p = NULL) => 0.0068092540, 0.0068092540), -0.0018965486);

// Tree: 122 
woFDN_FL_PS__lgt_122 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => -0.0016792310,
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 80) => 0.1573306929,
      (c_new_homes > 80) => 0.0115217420,
      (c_new_homes = NULL) => 0.0591328280, 0.0591328280),
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => -0.0091436757, -0.0007909431),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 50.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 103.5) => 0.2239881395,
      (c_lar_fam > 103.5) => 0.0247776694,
      (c_lar_fam = NULL) => 0.1416697634, 0.1416697634),
   (k_comb_age_d > 50.5) => -0.0236423472,
   (k_comb_age_d = NULL) => 0.0711365962, 0.0711365962),
(r_P85_Phn_Disconnected_i = NULL) => 0.0005245625, 0.0005245625);

// Tree: 123 
woFDN_FL_PS__lgt_123 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 178.5) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 21.9) => 
         map(
         (NULL < c_rich_hisp and c_rich_hisp <= 184) => 
            map(
            (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 0.0868146630,
            (r_Prop_Owner_History_d > 1.5) => -0.0139757133,
            (r_Prop_Owner_History_d = NULL) => 0.0261207307, 0.0261207307),
         (c_rich_hisp > 184) => 0.1757594212,
         (c_rich_hisp = NULL) => 0.0500903149, 0.0500903149),
      (c_hh1_p > 21.9) => -0.0095703410,
      (c_hh1_p = NULL) => 0.0150488343, 0.0150488343),
   (c_born_usa > 178.5) => 0.1311891815,
   (c_born_usa = NULL) => 0.0225384504, 0.0225384504),
(r_I60_inq_comm_recency_d > 549) => -0.0006730179,
(r_I60_inq_comm_recency_d = NULL) => 0.0218684797, 0.0016554619);

// Tree: 124 
woFDN_FL_PS__lgt_124 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 452) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 10.5) => -0.0028075827,
      (f_rel_under25miles_cnt_d > 10.5) => -0.0960882358,
      (f_rel_under25miles_cnt_d = NULL) => 0.0014424590, -0.0032033751),
   (r_C13_Curr_Addr_LRes_d > 452) => 0.1021267977,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0024229631, -0.0024229631),
(f_inq_QuizProvider_count_i > 5.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0213523823,
   (f_inq_Collection_count_i > 1.5) => 0.1973262385,
   (f_inq_Collection_count_i = NULL) => 0.0791215786, 0.0791215786),
(f_inq_QuizProvider_count_i = NULL) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 115) => -0.0615405730,
   (c_relig_indx > 115) => 0.0675494601,
   (c_relig_indx = NULL) => 0.0018518540, 0.0018518540), -0.0014314538);

// Tree: 125 
woFDN_FL_PS__lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 79.85) => 
      map(
      (NULL < c_unemp and c_unemp <= 11.45) => -0.0035657058,
      (c_unemp > 11.45) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 95.5) => 0.0794427049,
         (c_rest_indx > 95.5) => -0.0712766106,
         (c_rest_indx = NULL) => 0.0369526851, 0.0369526851),
      (c_unemp = NULL) => -0.0029387030, -0.0029387030),
   (c_lowinc > 79.85) => -0.0941309206,
   (c_lowinc = NULL) => -0.0119971270, -0.0036221693),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 0.5) => 0.0196658636,
   (r_C20_email_domain_free_count_i > 0.5) => 0.2980880635,
   (r_C20_email_domain_free_count_i = NULL) => 0.1047393136, 0.1047393136),
(f_nae_nothing_found_i = NULL) => -0.0020674361, -0.0020674361);

// Tree: 126 
woFDN_FL_PS__lgt_126 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 2.25) => -0.1072362416,
   (c_pop_35_44_p > 2.25) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 817635.5) => 
         map(
         (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0087853031,
         (k_inf_nothing_found_i > 0.5) => 0.0176977855,
         (k_inf_nothing_found_i = NULL) => 0.0021826198, 0.0021826198),
      (f_prevaddrmedianvalue_d > 817635.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 125.5) => 0.0306050264,
         (c_robbery > 125.5) => 0.2912726796,
         (c_robbery = NULL) => 0.1102101181, 0.1102101181),
      (f_prevaddrmedianvalue_d = NULL) => 0.0036721007, 0.0036721007),
   (c_pop_35_44_p = NULL) => 0.0187760344, 0.0032373677),
(f_hh_collections_ct_i > 5.5) => 0.0982755841,
(f_hh_collections_ct_i = NULL) => 0.0144799900, 0.0038941140);

// Tree: 127 
woFDN_FL_PS__lgt_127 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 5.5) => 0.0988099861,
(r_C13_max_lres_d > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0069365240,
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 17.35) => 0.0891660659,
         (c_pop_25_34_p > 17.35) => 
            map(
            (NULL < c_burglary and c_burglary <= 114.5) => -0.0640599348,
            (c_burglary > 114.5) => 0.0897047092,
            (c_burglary = NULL) => -0.0101329980, -0.0101329980),
         (c_pop_25_34_p = NULL) => 0.0553177582, 0.0553177582),
      (f_current_count_d > 0.5) => -0.0201634543,
      (f_current_count_d = NULL) => 0.0215221630, 0.0215221630),
   (f_inq_Communications_count_i = NULL) => -0.0043138562, -0.0043138562),
(r_C13_max_lres_d = NULL) => -0.0153125542, -0.0035758948);

// Tree: 128 
woFDN_FL_PS__lgt_128 := map(
(NULL < c_rich_blk and c_rich_blk <= 186.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 0.0491343518,
   (f_corrssnnamecount_d > 1.5) => -0.0044544777,
   (f_corrssnnamecount_d = NULL) => 0.0152724471, -0.0015981819),
(c_rich_blk > 186.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 14.5) => 0.0194523170,
   (f_rel_ageover30_count_d > 14.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 140.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0396703156) => 0.1153475760,
         (f_add_curr_nhood_BUS_pct_i > 0.0396703156) => -0.0294408720,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0345073592, 0.0345073592),
      (c_lar_fam > 140.5) => 0.2154221439,
      (c_lar_fam = NULL) => 0.0951330583, 0.0951330583),
   (f_rel_ageover30_count_d = NULL) => 0.0288685839, 0.0288685839),
(c_rich_blk = NULL) => -0.0155059531, 0.0017621625);

// Tree: 129 
woFDN_FL_PS__lgt_129 := map(
(NULL < c_exp_prod and c_exp_prod <= 33.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 26.25) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 86) => -0.0119050083,
      (r_C13_max_lres_d > 86) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 151.5) => 0.0332709186,
         (c_span_lang > 151.5) => 
            map(
            (NULL < c_white_col and c_white_col <= 28.45) => 0.0622141513,
            (c_white_col > 28.45) => 0.2988761416,
            (c_white_col = NULL) => 0.1265244748, 0.1265244748),
         (c_span_lang = NULL) => 0.0655240283, 0.0655240283),
      (r_C13_max_lres_d = NULL) => 0.0390124793, 0.0390124793),
   (c_hh3_p > 26.25) => -0.0806183222,
   (c_hh3_p = NULL) => 0.0278593302, 0.0278593302),
(c_exp_prod > 33.5) => -0.0063480145,
(c_exp_prod = NULL) => 0.0395434109, -0.0028221241);

// Tree: 130 
woFDN_FL_PS__lgt_130 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.35) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 2.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 8.5) => -0.0002430698,
      (k_inq_per_phone_i > 8.5) => 0.1014296035,
      (k_inq_per_phone_i = NULL) => 0.0003062606, 0.0003062606),
   (r_I60_Inq_Count12_i > 2.5) => -0.0278867699,
   (r_I60_Inq_Count12_i = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 81.5) => -0.0556931020,
      (c_asian_lang > 81.5) => 0.0612821281,
      (c_asian_lang = NULL) => 0.0104650199, 0.0104650199), -0.0024371476),
(c_hh6_p > 17.35) => -0.1043036683,
(c_hh6_p = NULL) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => -0.0107787308,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity']) => 0.1658541263,
   (nf_seg_FraudPoint_3_0 = '') => 0.0191129835, 0.0191129835), -0.0025194229);

// Tree: 131 
woFDN_FL_PS__lgt_131 := map(
(NULL < c_hh00 and c_hh00 <= 268.5) => -0.0476727639,
(c_hh00 > 268.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 5175.5) => -0.0153945628,
   (r_A49_Curr_AVM_Chg_1yr_i > 5175.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 9.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 22.5) => 
            map(
            (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 228278) => 0.2805246653,
            (f_prevaddrmedianvalue_d > 228278) => -0.0136010104,
            (f_prevaddrmedianvalue_d = NULL) => 0.1334618274, 0.1334618274),
         (c_many_cars > 22.5) => 0.0140721934,
         (c_many_cars = NULL) => 0.0183869909, 0.0183869909),
      (f_inq_Collection_count_i > 9.5) => 0.1356436736,
      (f_inq_Collection_count_i = NULL) => 0.0215003446, 0.0215003446),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0017178736, 0.0029949791),
(c_hh00 = NULL) => 0.0069743959, 0.0013157053);

// Tree: 132 
woFDN_FL_PS__lgt_132 := map(
(NULL < c_food and c_food <= 89.35) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 1.5) => 0.0018493466,
      (r_S65_SSN_Problem_i > 1.5) => -0.0654188933,
      (r_S65_SSN_Problem_i = NULL) => 0.0003523788, 0.0003523788),
   (f_assocsuspicousidcount_i > 13.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 103.5) => 0.1526427384,
      (c_many_cars > 103.5) => -0.0253797103,
      (c_many_cars = NULL) => 0.0660813642, 0.0660813642),
   (f_assocsuspicousidcount_i = NULL) => 0.0074902596, 0.0010062652),
(c_food > 89.35) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 3.5) => 0.1412448323,
   (f_hh_members_ct_d > 3.5) => -0.0265919322,
   (f_hh_members_ct_d = NULL) => 0.0770388217, 0.0770388217),
(c_food = NULL) => -0.0354382414, 0.0010089611);

// Tree: 133 
woFDN_FL_PS__lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 1.95) => -0.0027278114,
   (c_hval_500k_p > 1.95) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 8.95) => 0.0380268081,
      (c_rnt750_p > 8.95) => 0.2308115054,
      (c_rnt750_p = NULL) => 0.1353735364, 0.1353735364),
   (c_hval_500k_p = NULL) => 0.0618473559, 0.0618473559),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 0.0001441703,
   (f_addrs_per_ssn_c6_i > 1.5) => 0.0840830997,
   (f_addrs_per_ssn_c6_i = NULL) => 0.0012337556, 0.0012337556),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 105.5) => -0.0419782065,
   (c_lar_fam > 105.5) => 0.0633568676,
   (c_lar_fam = NULL) => -0.0015234316, -0.0015234316), 0.0022397966);

// Tree: 134 
woFDN_FL_PS__lgt_134 := map(
(NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 23.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 11.5) => 0.0010353513,
   (r_C14_addrs_15yr_i > 11.5) => 0.0971731170,
   (r_C14_addrs_15yr_i = NULL) => 0.0016480532, 0.0016480532),
(f_rel_homeover100_count_d > 23.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 4.5) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 5.95) => 0.0703774205,
      (c_pop_6_11_p > 5.95) => -0.0548498856,
      (c_pop_6_11_p = NULL) => -0.0256181513, -0.0256181513),
   (f_srchssnsrchcount_i > 4.5) => -0.1263666863,
   (f_srchssnsrchcount_i = NULL) => -0.0395488129, -0.0395488129),
(f_rel_homeover100_count_d = NULL) => 
   map(
   (NULL < c_murders and c_murders <= 32.5) => 0.0952901400,
   (c_murders > 32.5) => -0.0233862150,
   (c_murders = NULL) => -0.0026868508, -0.0026868508), 0.0002114255);

// Tree: 135 
woFDN_FL_PS__lgt_135 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0036430111,
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 800) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 339.5) => -0.0153879358,
      (r_C21_M_Bureau_ADL_FS_d > 339.5) => 0.1324379098,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0058383395, 0.0058383395),
   (c_hh00 > 800) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 8.1) => 
         map(
         (NULL < c_rape and c_rape <= 73) => 0.2150814782,
         (c_rape > 73) => 0.0885584287,
         (c_rape = NULL) => 0.1495606133, 0.1495606133),
      (C_INC_200K_P > 8.1) => -0.0191046426,
      (C_INC_200K_P = NULL) => 0.0953832887, 0.0953832887),
   (c_hh00 = NULL) => 0.0324598108, 0.0324598108),
(f_srchcomponentrisktype_i = NULL) => 0.0036150609, -0.0019599926);

// Tree: 136 
woFDN_FL_PS__lgt_136 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0104853912,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 16.95) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 118) => 0.1714506419,
      (r_D32_Mos_Since_Crim_LS_d > 118) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => -0.0339875524,
         (f_util_adl_count_n > 1.5) => 0.1197967278,
         (f_util_adl_count_n = NULL) => 0.0255418464, 0.0255418464),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0768235988, 0.0768235988),
   (c_hh2_p > 16.95) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 18.35) => -0.0993141980,
      (c_hh2_p > 18.35) => 0.0147953324,
      (c_hh2_p = NULL) => 0.0129211586, 0.0129211586),
   (c_hh2_p = NULL) => 0.0167847263, 0.0167847263),
(f_hh_criminals_i = NULL) => -0.0023612552, -0.0018409286);

// Tree: 137 
woFDN_FL_PS__lgt_137 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 35.4) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0951402929,
   (C_INC_100K_P > 1.35) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.55) => -0.0045292828,
      (r_C12_source_profile_d > 79.55) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 140.5) => 0.0041409587,
         (c_sub_bus > 140.5) => 
            map(
            (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 41.5) => 0.2954793153,
            (r_C13_Curr_Addr_LRes_d > 41.5) => 0.0673311093,
            (r_C13_Curr_Addr_LRes_d = NULL) => 0.1160807260, 0.1160807260),
         (c_sub_bus = NULL) => 0.0272804512, 0.0272804512),
      (r_C12_source_profile_d = NULL) => -0.0190581071, -0.0017194723),
   (C_INC_100K_P = NULL) => -0.0012454441, -0.0012454441),
(c_hval_60k_p > 35.4) => -0.0898895185,
(c_hval_60k_p = NULL) => 0.0240734280, -0.0013584527);

// Tree: 138 
woFDN_FL_PS__lgt_138 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 186.5) => -0.0002374456,
(f_curraddrcartheftindex_i > 186.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0237910852) => -0.0606085082,
   (f_add_curr_nhood_BUS_pct_i > 0.0237910852) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
         map(
         (NULL < c_work_home and c_work_home <= 57.5) => 
            map(
            (NULL < c_unattach and c_unattach <= 122.5) => 0.1997784085,
            (c_unattach > 122.5) => 0.0137810795,
            (c_unattach = NULL) => 0.1006703427, 0.1006703427),
         (c_work_home > 57.5) => -0.0105233541,
         (c_work_home = NULL) => 0.0315582383, 0.0315582383),
      (f_srchvelocityrisktype_i > 4.5) => 0.1440281457,
      (f_srchvelocityrisktype_i = NULL) => 0.0502168405, 0.0502168405),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0292946719, 0.0292946719),
(f_curraddrcartheftindex_i = NULL) => -0.0162244347, 0.0008625822);

// Tree: 139 
woFDN_FL_PS__lgt_139 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 23.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0092411205) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 132.5) => 0.0268328035,
      (c_cartheft > 132.5) => 0.1500131068,
      (c_cartheft = NULL) => 0.0363881053, 0.0363881053),
   (f_add_curr_nhood_MFD_pct_i > 0.0092411205) => -0.0037354275,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 11.95) => 0.1575759442,
      (c_fammar18_p > 11.95) => -0.0149898299,
      (c_fammar18_p = NULL) => -0.0245851045, -0.0118864667), -0.0015461707),
(f_srchphonesrchcount_i > 23.5) => -0.0844608771,
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 9.9) => -0.0617879644,
   (c_rnt1000_p > 9.9) => 0.0689315985,
   (c_rnt1000_p = NULL) => -0.0018748314, -0.0018748314), -0.0018762312);

// Tree: 140 
woFDN_FL_PS__lgt_140 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0113996382,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_trailer and c_trailer <= 173.5) => 
         map(
         (NULL < c_hval_500k_p and c_hval_500k_p <= 21) => 
            map(
            (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 124946) => 0.1076754575,
            (r_A46_Curr_AVM_AutoVal_d > 124946) => 0.0226447342,
            (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0155728671, 0.0161537464),
         (c_hval_500k_p > 21) => 0.1373030679,
         (c_hval_500k_p = NULL) => 0.0313918627, 0.0313918627),
      (c_trailer > 173.5) => 0.1801905165,
      (c_trailer = NULL) => 0.0420203380, 0.0420203380),
   (f_hh_members_ct_d > 1.5) => 0.0040397203,
   (f_hh_members_ct_d = NULL) => 0.0117460390, 0.0117460390),
(k_inq_per_ssn_i = NULL) => -0.0019260587, -0.0019260587);

// Tree: 141 
woFDN_FL_PS__lgt_141 := map(
(NULL < c_lowinc and c_lowinc <= 72.85) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => -0.0031646854,
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.4859980615) => 0.1503564491,
      (f_add_curr_nhood_SFD_pct_d > 0.4859980615) => 0.0010950133,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0518746770, 0.0518746770),
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => 
      map(
      (NULL < c_preschl and c_preschl <= 79.5) => 0.0453678706,
      (c_preschl > 79.5) => -0.0474760459,
      (c_preschl = NULL) => -0.0104835479, -0.0104835479), -0.0023661919),
(c_lowinc > 72.85) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 11.6) => -0.0176543936,
   (c_pop_0_5_p > 11.6) => -0.1201640729,
   (c_pop_0_5_p = NULL) => -0.0507220321, -0.0507220321),
(c_lowinc = NULL) => -0.0254417170, -0.0035591879);

// Tree: 142 
woFDN_FL_PS__lgt_142 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 37.5) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 161.5) => 0.0229943239,
         (c_span_lang > 161.5) => -0.0615940137,
         (c_span_lang = NULL) => 0.0031307939, 0.0031307939),
      (k_comb_age_d > 37.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 11.3) => 0.1575113736,
         (C_OWNOCC_P > 11.3) => 0.0410568723,
         (C_OWNOCC_P = NULL) => 0.0430436755, 0.0458098317),
      (k_comb_age_d = NULL) => 0.0265904973, 0.0265904973),
   (f_corrphonelastnamecount_d > 0.5) => -0.0118094563,
   (f_corrphonelastnamecount_d = NULL) => 0.0100567921, 0.0100567921),
(f_phone_ver_experian_d > 0.5) => -0.0057036970,
(f_phone_ver_experian_d = NULL) => -0.0118976801, -0.0020160544);

// Tree: 143 
woFDN_FL_PS__lgt_143 := map(
(NULL < c_child and c_child <= 33.25) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 9.45) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 41.5) => 0.0159119235,
         (k_comb_age_d > 41.5) => 0.0864447070,
         (k_comb_age_d = NULL) => 0.0498107584, 0.0498107584),
      (c_hh1_p > 9.45) => -0.0001790136,
      (c_hh1_p = NULL) => 0.0035984840, 0.0035984840),
   (f_assocsuspicousidcount_i > 15.5) => 0.0968470308,
   (f_assocsuspicousidcount_i = NULL) => 0.0186985280, 0.0042430827),
(c_child > 33.25) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 11.5) => -0.0308957922,
   (f_rel_homeover300_count_d > 11.5) => -0.1474816901,
   (f_rel_homeover300_count_d = NULL) => -0.0374585745, -0.0374585745),
(c_child = NULL) => -0.0070705110, 0.0009215012);

// Tree: 144 
woFDN_FL_PS__lgt_144 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 24.5) => -0.0236008211,
   (f_curraddrburglaryindex_i > 24.5) => 0.0064146678,
   (f_curraddrburglaryindex_i = NULL) => 0.0000371125, 0.0000371125),
(f_assocsuspicousidcount_i > 9.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 46.75) => 0.0659448121,
   (r_C12_source_profile_d > 46.75) => 
      map(
      (NULL < c_child and c_child <= 29.05) => -0.0416317089,
      (c_child > 29.05) => -0.1344274920,
      (c_child = NULL) => -0.0695071220, -0.0695071220),
   (r_C12_source_profile_d = NULL) => -0.0449928149, -0.0449928149),
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_bargains and c_bargains <= 86) => -0.0575804422,
   (c_bargains > 86) => 0.0406018237,
   (c_bargains = NULL) => -0.0084893092, -0.0084893092), -0.0012048335);

// Tree: 145 
woFDN_FL_PS__lgt_145 := map(
(NULL < c_low_hval and c_low_hval <= 71.05) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0061704062,
   (k_comb_age_d > 56.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 32.45) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 11.15) => 0.0007088141,
         (c_femdiv_p > 11.15) => 0.1551936864,
         (c_femdiv_p = NULL) => 0.0074851740, 0.0074851740),
      (c_rnt1000_p > 32.45) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 82226.5) => 0.2465824189,
         (f_prevaddrmedianvalue_d > 82226.5) => 0.0614128654,
         (f_prevaddrmedianvalue_d = NULL) => 0.0839522305, 0.0839522305),
      (c_rnt1000_p = NULL) => 0.0241586767, 0.0241586767),
   (k_comb_age_d = NULL) => -0.0126144418, -0.0001809103),
(c_low_hval > 71.05) => -0.0935768118,
(c_low_hval = NULL) => 0.0163221658, -0.0004679529);

// Tree: 146 
woFDN_FL_PS__lgt_146 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 11.5) => 
   map(
   (NULL < r_L75_Add_Curr_Drop_Delivery_i and r_L75_Add_Curr_Drop_Delivery_i <= 0.5) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0054867802,
      (f_hh_payday_loan_users_i > 0.5) => 0.0270107196,
      (f_hh_payday_loan_users_i = NULL) => -0.0027167940, -0.0027167940),
   (r_L75_Add_Curr_Drop_Delivery_i > 0.5) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 106.5) => 0.1882255212,
      (c_totcrime > 106.5) => -0.0086825522,
      (c_totcrime = NULL) => 0.0871576605, 0.0871576605),
   (r_L75_Add_Curr_Drop_Delivery_i = NULL) => -0.0019044589, -0.0019044589),
(f_srchfraudsrchcountyr_i > 11.5) => -0.0857288394,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 8.05) => 0.0453772311,
   (c_professional > 8.05) => -0.0588744913,
   (c_professional = NULL) => 0.0031801053, 0.0031801053), -0.0021819564);

// Tree: 147 
woFDN_FL_PS__lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 43.5) => -0.0917173213,
   (f_mos_inq_banko_am_fseen_d > 43.5) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 10.95) => -0.0057580928,
      (c_rnt1250_p > 10.95) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 3.035) => 0.0053886400,
         (c_hhsize > 3.035) => 
            map(
            (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 14.5) => 0.1348150100,
            (f_mos_inq_banko_cm_lseen_d > 14.5) => 0.0444647520,
            (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0497176739, 0.0497176739),
         (c_hhsize = NULL) => 0.0164441168, 0.0164441168),
      (c_rnt1250_p = NULL) => -0.0300387211, 0.0012992849),
   (f_mos_inq_banko_am_fseen_d = NULL) => -0.0006678793, -0.0006678793),
(f_prevaddrcartheftindex_i > 194.5) => -0.0758774275,
(f_prevaddrcartheftindex_i = NULL) => 0.0135772982, -0.0020129468);

// Tree: 148 
woFDN_FL_PS__lgt_148 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21111.5) => 0.0799896991,
   (r_A46_Curr_AVM_AutoVal_d > 21111.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.7398458792) => -0.0003188381,
      (f_add_curr_nhood_MFD_pct_i > 0.7398458792) => 0.0906764909,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0185950276, -0.0015639828),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0066150906, -0.0031835180),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 46) => 0.1467128215,
   (f_mos_inq_banko_cm_lseen_d > 46) => 0.0232670544,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0508501745, 0.0508501745),
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 65.5) => 0.0547261400,
   (c_rental > 65.5) => -0.0513468031,
   (c_rental = NULL) => -0.0017881330, -0.0017881330), -0.0020065525);

// Tree: 149 
woFDN_FL_PS__lgt_149 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 197.5) => -0.0090089851,
         (c_serv_empl > 197.5) => 0.1176949601,
         (c_serv_empl = NULL) => 0.0107287075, -0.0071519852),
      (k_inq_adls_per_phone_i > 2.5) => -0.1075072509,
      (k_inq_adls_per_phone_i = NULL) => -0.0079955599, -0.0079955599),
   (f_util_add_curr_misc_n > 0.5) => 0.0162193174,
   (f_util_add_curr_misc_n = NULL) => 0.0032316745, 0.0032316745),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 158.5) => 0.0322166806,
   (r_A50_pb_total_dollars_d > 158.5) => -0.1071111026,
   (r_A50_pb_total_dollars_d = NULL) => -0.0531080859, -0.0531080859),
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0100152056, 0.0025177480);

// Tree: 150 
woFDN_FL_PS__lgt_150 := map(
(NULL < c_unempl and c_unempl <= 24.5) => -0.0686318187,
(c_unempl > 24.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 106.8) => 0.1037601195,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 106.8) => -0.0651102378,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 54.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1175317876) => -0.0196153532,
            (f_add_curr_nhood_BUS_pct_i > 0.1175317876) => 0.1914698282,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0172876506, 0.0172876506),
         (k_comb_age_d > 54.5) => 0.1992897640,
         (k_comb_age_d = NULL) => 0.0468435493, 0.0468435493), 0.0388640157),
   (f_corrssnnamecount_d > 1.5) => -0.0008602137,
   (f_corrssnnamecount_d = NULL) => -0.0095695178, 0.0012328584),
(c_unempl = NULL) => 0.0276060149, -0.0012544060);

// Tree: 151 
woFDN_FL_PS__lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0989987796,
   (C_INC_100K_P > 1.35) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 43.25) => -0.0489761128,
      (c_civ_emp > 43.25) => 
         map(
         (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 0.0015576565,
         (k_inq_adls_per_phone_i > 3.5) => -0.1028072849,
         (k_inq_adls_per_phone_i = NULL) => 0.0010666324, 0.0010666324),
      (c_civ_emp = NULL) => -0.0007843597, -0.0007843597),
   (C_INC_100K_P = NULL) => -0.0186935145, -0.0007743146),
(r_C14_addrs_10yr_i > 10.5) => 0.1159265024,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 65.5) => 0.0702514724,
   (c_rental > 65.5) => -0.0326515414,
   (c_rental = NULL) => 0.0112218366, 0.0112218366), -0.0001783961);

// Tree: 152 
woFDN_FL_PS__lgt_152 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.30807338675) => 
      map(
      (NULL < c_white_col and c_white_col <= 19.75) => 
         map(
         (NULL < c_unempl and c_unempl <= 177.5) => 0.0278682415,
         (c_unempl > 177.5) => 0.1234434505,
         (c_unempl = NULL) => 0.0436776746, 0.0436776746),
      (c_white_col > 19.75) => 0.0058908557,
      (c_white_col = NULL) => 0.0008747022, 0.0075366767),
   (f_add_curr_mobility_index_i > 0.30807338675) => -0.0157435393,
   (f_add_curr_mobility_index_i = NULL) => 0.0641412163, 0.0012641227),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0815111621,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 16.5) => -0.0612127967,
   (c_hh3_p > 16.5) => 0.0397567662,
   (c_hh3_p = NULL) => -0.0128141633, -0.0128141633), 0.0007991207);

// Tree: 153 
woFDN_FL_PS__lgt_153 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 26.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 35.15) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0075475122,
      (f_hh_criminals_i > 0.5) => 0.0187479526,
      (f_hh_criminals_i = NULL) => 0.0009861438, 0.0009861438),
   (c_hval_60k_p > 35.15) => -0.0963937839,
   (c_hval_60k_p = NULL) => -0.0062273187, 0.0000265830),
(f_rel_homeover300_count_d > 26.5) => -0.1175109993,
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 4.15) => -0.0904695991,
   (c_famotf18_p > 4.15) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 18.75) => 0.1067221986,
      (C_RENTOCC_P > 18.75) => -0.0012817710,
      (C_RENTOCC_P = NULL) => 0.0224463739, 0.0224463739),
   (c_famotf18_p = NULL) => -0.0052986938, -0.0052986938), -0.0008670774);

// Tree: 154 
woFDN_FL_PS__lgt_154 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 18.75) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 23.5) => 0.0024511668,
   (f_srchssnsrchcount_i > 23.5) => 0.0723906641,
   (f_srchssnsrchcount_i = NULL) => -0.0091494062, 0.0027108177),
(c_hval_80k_p > 18.75) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 59.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 2.5) => -0.0532330104,
      (f_assocsuspicousidcount_i > 2.5) => -0.1673829527,
      (f_assocsuspicousidcount_i = NULL) => -0.1000806746, -0.1000806746),
   (c_born_usa > 59.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 26.95) => -0.0291278787,
      (c_hh3_p > 26.95) => 0.1017946442,
      (c_hh3_p = NULL) => -0.0180557959, -0.0180557959),
   (c_born_usa = NULL) => -0.0349631620, -0.0349631620),
(c_hval_80k_p = NULL) => -0.0056596596, -0.0000198602);

// Tree: 155 
woFDN_FL_PS__lgt_155 := map(
(NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 2) => 0.1506830123,
(r_I60_inq_retail_recency_d > 2) => 
   map(
   (NULL < k_inq_adls_per_ssn_i and k_inq_adls_per_ssn_i <= 1.5) => 
      map(
      (NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 25.5) => -0.0916360837,
      (f_mos_liens_unrel_OT_fseen_d > 25.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
            map(
            (NULL < c_vacant_p and c_vacant_p <= 34.3) => 0.0076559060,
            (c_vacant_p > 34.3) => 0.1835097695,
            (c_vacant_p = NULL) => 0.0248695376, 0.0116768594),
         (k_estimated_income_d > 34500) => -0.0115944006,
         (k_estimated_income_d = NULL) => -0.0034834665, -0.0034834665),
      (f_mos_liens_unrel_OT_fseen_d = NULL) => -0.0040702551, -0.0040702551),
   (k_inq_adls_per_ssn_i > 1.5) => 0.1560965649,
   (k_inq_adls_per_ssn_i = NULL) => -0.0034305602, -0.0034305602),
(r_I60_inq_retail_recency_d = NULL) => 0.0117544807, -0.0026185212);

// Tree: 156 
woFDN_FL_PS__lgt_156 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0014103165,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 23.15) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 40.5) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 50649) => -0.0599062529,
         (f_prevaddrmedianincome_d > 50649) => 0.0596806806,
         (f_prevaddrmedianincome_d = NULL) => 0.0089948280, 0.0089948280),
      (r_A50_pb_average_dollars_d > 40.5) => -0.0763703364,
      (r_A50_pb_average_dollars_d = NULL) => -0.0484090787, -0.0484090787),
   (C_INC_15K_P > 23.15) => 0.0479321320,
   (C_INC_15K_P = NULL) => -0.0360249533, -0.0360249533),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 2.35) => 0.0699328987,
   (c_hval_125k_p > 2.35) => -0.0382261439,
   (c_hval_125k_p = NULL) => 0.0064676754, 0.0064676754), -0.0001132062);

// Tree: 157 
woFDN_FL_PS__lgt_157 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 20986.5) => 0.0610099634,
   (r_A46_Curr_AVM_AutoVal_d > 20986.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 0.0773587890,
      (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 0.0005123059,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0019222186, 0.0019222186),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0135760212, -0.0042406678),
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 10.15) => 0.0192620611,
   (c_unemp > 10.15) => 0.1192759998,
   (c_unemp = NULL) => 0.0226752863, 0.0226752863),
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 24.95) => 0.0507208316,
   (c_lowinc > 24.95) => -0.0686708715,
   (c_lowinc = NULL) => 0.0003987088, 0.0003987088), -0.0008151734);

// Tree: 158 
woFDN_FL_PS__lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 53.05) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 5.35) => -0.0251979131,
         (C_INC_150K_P > 5.35) => 
            map(
            (NULL < c_popover18 and c_popover18 <= 961) => 0.1732716397,
            (c_popover18 > 961) => -0.0362159635,
            (c_popover18 = NULL) => 0.0854219996, 0.0854219996),
         (C_INC_150K_P = NULL) => -0.0113982459, -0.0113982459),
      (f_srchvelocityrisktype_i > 4.5) => -0.0662267807,
      (f_srchvelocityrisktype_i = NULL) => -0.0215183611, -0.0215183611),
   (c_fammar_p > 53.05) => 0.0025090713,
   (c_fammar_p = NULL) => -0.0196060088, -0.0003556699),
(r_D33_eviction_count_i > 3.5) => 0.0722287656,
(r_D33_eviction_count_i = NULL) => 0.0067509334, 0.0001429546);

// Tree: 159 
woFDN_FL_PS__lgt_159 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.1031417325,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 17.5) => 0.0006737328,
   (f_rel_homeover500_count_d > 17.5) => 0.1172288981,
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 137.5) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1970.5) => -0.0384901178,
         (c_med_yearblt > 1970.5) => 
            map(
            (NULL < c_employees and c_employees <= 374.5) => 0.1451214668,
            (c_employees > 374.5) => 0.0200010866,
            (c_employees = NULL) => 0.0858539183, 0.0858539183),
         (c_med_yearblt = NULL) => 0.0453869243, 0.0453869243),
      (c_sub_bus > 137.5) => -0.0429092075,
      (c_sub_bus = NULL) => 0.0007225068, 0.0007225068), 0.0012144753),
(C_INC_100K_P = NULL) => 0.0112515284, 0.0019547850);

// Tree: 160 
woFDN_FL_PS__lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.55) => -0.0037896975,
(r_C12_source_profile_d > 79.55) => 
   map(
   (NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 0.5) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 178.5) => 
         map(
         (NULL < c_retail and c_retail <= 26.8) => 
            map(
            (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 252) => 0.2153328818,
            (r_C21_M_Bureau_ADL_FS_d > 252) => 0.0171973437,
            (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0322587607, 0.0322587607),
         (c_retail > 26.8) => 0.2235341059,
         (c_retail = NULL) => 0.0550085997, 0.0550085997),
      (c_old_homes > 178.5) => 0.2390378910,
      (c_old_homes = NULL) => 0.0654329168, 0.0654329168),
   (r_D31_MostRec_Bk_i > 0.5) => -0.0666513208,
   (r_D31_MostRec_Bk_i = NULL) => 0.0459628108, 0.0459628108),
(r_C12_source_profile_d = NULL) => -0.0086361263, 0.0004741372);

// Tree: 161 
woFDN_FL_PS__lgt_161 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 25.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 30.75) => -0.0126968536,
      (c_famotf18_p > 30.75) => -0.0947640068,
      (c_famotf18_p = NULL) => -0.0241668691, -0.0241668691),
   (f_inq_HighRiskCredit_count_i > 0.5) => -0.1130011885,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0400055462, -0.0400055462),
(f_mos_inq_banko_cm_fseen_d > 25.5) => 
   map(
   (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => -0.0032765885,
   (f_inq_Collection_count24_i > 2.5) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.474102485) => 0.1362030286,
      (f_add_curr_nhood_SFD_pct_d > 0.474102485) => 0.0060275566,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0433474872, 0.0433474872),
   (f_inq_Collection_count24_i = NULL) => -0.0021303513, -0.0021303513),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0174107328, -0.0042031702);

// Tree: 162 
woFDN_FL_PS__lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0002945792,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 43.8) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 23.95) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 67157) => 0.0110713801,
         (f_prevaddrmedianincome_d > 67157) => 0.1499054564,
         (f_prevaddrmedianincome_d = NULL) => 0.0519049319, 0.0519049319),
      (c_newhouse > 23.95) => -0.1072976050,
      (c_newhouse = NULL) => 0.0093594264, 0.0093594264),
   (c_fammar18_p > 43.8) => 0.1472203222,
   (c_fammar18_p = NULL) => 0.0357787618, 0.0357787618),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 65) => 0.0595975361,
   (c_larceny > 65) => -0.0231074077,
   (c_larceny = NULL) => 0.0172364673, 0.0172364673), 0.0007042526);

// Tree: 163 
woFDN_FL_PS__lgt_163 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 23.45) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 37.75) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 834.5) => -0.0015884341,
      (c_oldhouse > 834.5) => -0.0706754307,
      (c_oldhouse = NULL) => -0.0028513146, -0.0028513146),
   (c_hval_20k_p > 37.75) => 0.1187272604,
   (c_hval_20k_p = NULL) => -0.0023306355, -0.0023306355),
(C_INC_25K_P > 23.45) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 152.5) => -0.0483372584,
   (c_cartheft > 152.5) => 
      map(
      (NULL < c_health and c_health <= 1.8) => 0.1620970267,
      (c_health > 1.8) => 0.0340931982,
      (c_health = NULL) => 0.0826175253, 0.0826175253),
   (c_cartheft = NULL) => 0.0376545095, 0.0376545095),
(C_INC_25K_P = NULL) => -0.0053981507, -0.0016711472);

// Tree: 164 
woFDN_FL_PS__lgt_164 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 4.65) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 8.5) => -0.0090629896,
   (f_hh_age_18_plus_d > 8.5) => 0.0965014746,
   (f_hh_age_18_plus_d = NULL) => -0.0232942011, -0.0077737302),
(c_femdiv_p > 4.65) => 
   map(
   (NULL < c_assault and c_assault <= 159.5) => 0.0080633350,
   (c_assault > 159.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0286886918,
      (f_varrisktype_i > 2.5) => 
         map(
         (NULL < c_work_home and c_work_home <= 74) => 0.1645257848,
         (c_work_home > 74) => 0.0338450080,
         (c_work_home = NULL) => 0.1021826619, 0.1021826619),
      (f_varrisktype_i = NULL) => 0.0373117733, 0.0373117733),
   (c_assault = NULL) => 0.0129722005, 0.0129722005),
(c_femdiv_p = NULL) => 0.0368118081, 0.0024481547);

// Tree: 165 
woFDN_FL_PS__lgt_165 := map(
(NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 16.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 2.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 34.7) => 0.0050993412,
         (C_OWNOCC_P > 34.7) => 0.2083027709,
         (C_OWNOCC_P = NULL) => 0.1016209703, 0.1016209703),
      (c_born_usa > 2.5) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 196.5) => 0.0139377010,
         (c_bel_edu > 196.5) => -0.1146877906,
         (c_bel_edu = NULL) => 0.0127913382, 0.0127913382),
      (c_born_usa = NULL) => 0.0125814147, 0.0141935008),
   (f_rel_incomeover50_count_d > 16.5) => -0.0452556547,
   (f_rel_incomeover50_count_d = NULL) => 0.0303565723, 0.0122110495),
(k_inf_phn_verd_d > 0.5) => -0.0199767860,
(k_inf_phn_verd_d = NULL) => 0.0008076492, 0.0008076492);

// Tree: 166 
woFDN_FL_PS__lgt_166 := map(
(NULL < c_hh1_p and c_hh1_p <= 8.25) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 27.15) => 
      map(
      (NULL < c_rnt250_p and c_rnt250_p <= 8.65) => 
         map(
         (NULL < f_hh_criminals_i and f_hh_criminals_i <= 1.5) => 0.0252881525,
         (f_hh_criminals_i > 1.5) => -0.1199060454,
         (f_hh_criminals_i = NULL) => 0.0092341599, 0.0092341599),
      (c_rnt250_p > 8.65) => 0.1563991651,
      (c_rnt250_p = NULL) => 0.0207893381, 0.0207893381),
   (c_hh3_p > 27.15) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 39500) => 0.2752992277,
      (k_estimated_income_d > 39500) => 0.0621353047,
      (k_estimated_income_d = NULL) => 0.1460581090, 0.1460581090),
   (c_hh3_p = NULL) => 0.0407574610, 0.0407574610),
(c_hh1_p > 8.25) => -0.0040921386,
(c_hh1_p = NULL) => 0.0086025454, -0.0009457849);

// Tree: 167 
woFDN_FL_PS__lgt_167 := map(
(NULL < c_hh6_p and c_hh6_p <= 12.85) => 
   map(
   (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 3.5) => 
      map(
      (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0093108205,
      (r_F04_curr_add_occ_index_d > 2) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 22.65) => 0.0076857349,
         (C_INC_50K_P > 22.65) => 0.1179627609,
         (C_INC_50K_P = NULL) => 0.0127454555, 0.0127454555),
      (r_F04_curr_add_occ_index_d = NULL) => -0.0044112685, -0.0044112685),
   (r_D34_UnRel_Lien60_Count_i > 3.5) => -0.0992524388,
   (r_D34_UnRel_Lien60_Count_i = NULL) => -0.0292403143, -0.0050627736),
(c_hh6_p > 12.85) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 161.5) => 0.1440321932,
   (r_C10_M_Hdr_FS_d > 161.5) => -0.0112554118,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0500240018, 0.0500240018),
(c_hh6_p = NULL) => 0.0133654822, -0.0036280378);

// Tree: 168 
woFDN_FL_PS__lgt_168 := map(
(NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 38.5) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 9.55) => 0.0632785835,
   (c_pop_25_34_p > 9.55) => -0.0947262691,
   (c_pop_25_34_p = NULL) => -0.0575486567, -0.0575486567),
(f_mos_liens_unrel_CJ_lseen_d > 38.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 56.25) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0018962575,
      (r_P85_Phn_Disconnected_i > 0.5) => 0.0561508736,
      (r_P85_Phn_Disconnected_i = NULL) => -0.0008708959, -0.0008708959),
   (c_famotf18_p > 56.25) => -0.0829180796,
   (c_famotf18_p = NULL) => 0.0032859120, -0.0013576867),
(f_mos_liens_unrel_CJ_lseen_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0396689388,
   (f_addrs_per_ssn_i > 3.5) => 0.0565766645,
   (f_addrs_per_ssn_i = NULL) => 0.0112846159, 0.0112846159), -0.0022180549);

// Tree: 169 
woFDN_FL_PS__lgt_169 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 0.0028209624,
   (f_util_adl_count_n > 4.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 264046.5) => 
         map(
         (NULL < c_rental and c_rental <= 65.5) => 0.1324796521,
         (c_rental > 65.5) => -0.0101798078,
         (c_rental = NULL) => 0.0425268892, 0.0425268892),
      (r_A46_Curr_AVM_AutoVal_d > 264046.5) => 0.1858039771,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 133) => -0.0182759326,
         (c_many_cars > 133) => 0.1127644241,
         (c_many_cars = NULL) => 0.0190075161, 0.0190075161), 0.0495042573),
   (f_util_adl_count_n = NULL) => 0.0088242482, 0.0088242482),
(f_phone_ver_experian_d > 0.5) => -0.0108447689,
(f_phone_ver_experian_d = NULL) => -0.0121782973, -0.0048391454);

// Tree: 170 
woFDN_FL_PS__lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0030517053,
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 1.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0177511451,
         (f_addrs_per_ssn_i > 5.5) => 0.1684228090,
         (f_addrs_per_ssn_i = NULL) => 0.1015339632, 0.1015339632),
      (f_inq_count_i > 1.5) => 0.0089877749,
      (f_inq_count_i = NULL) => 0.0225568824, 0.0225568824),
   (f_inq_Communications_count_i = NULL) => -0.0007128246, -0.0007128246),
(f_util_adl_count_n > 13.5) => 0.1108654853,
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.95) => 0.0561505690,
   (c_hh4_p > 12.95) => -0.0466930555,
   (c_hh4_p = NULL) => 0.0020223456, 0.0020223456), 0.0001742037);

// Tree: 171 
woFDN_FL_PS__lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 38.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 15.75) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 11.65) => -0.0035633198,
      (c_bigapt_p > 11.65) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 3.3) => 0.0097830272,
         (c_hval_125k_p > 3.3) => 0.1328423653,
         (c_hval_125k_p = NULL) => 0.0630414948, 0.0630414948),
      (c_bigapt_p = NULL) => 0.0084641926, 0.0084641926),
   (c_pop_18_24_p > 15.75) => 
      map(
      (NULL < c_food and c_food <= 22.75) => 0.1827057173,
      (c_food > 22.75) => -0.0053861180,
      (c_food = NULL) => 0.1053261648, 0.1053261648),
   (c_pop_18_24_p = NULL) => 0.0315757048, 0.0173286854),
(f_mos_inq_banko_cm_lseen_d > 38.5) => -0.0009718269,
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0015350905, 0.0018241442);

// Tree: 172 
woFDN_FL_PS__lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 43.5) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 27878) => 
         map(
         (NULL < c_rich_fam and c_rich_fam <= 146.5) => 
            map(
            (NULL < c_serv_empl and c_serv_empl <= 77.5) => 0.1220314174,
            (c_serv_empl > 77.5) => -0.0018923867,
            (c_serv_empl = NULL) => 0.0231250949, 0.0231250949),
         (c_rich_fam > 146.5) => 0.1745013509,
         (c_rich_fam = NULL) => 0.0401549237, 0.0401549237),
      (c_med_hhinc > 27878) => -0.0072425586,
      (c_med_hhinc = NULL) => -0.0053350553, -0.0053350553),
   (f_rel_homeover100_count_d > 43.5) => 0.1020929122,
   (f_rel_homeover100_count_d = NULL) => 0.0174766467, -0.0041092218),
(c_pop_0_5_p > 20) => 0.1333982711,
(c_pop_0_5_p = NULL) => -0.0101001672, -0.0036339627);

// Tree: 173 
woFDN_FL_PS__lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0074975523,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 8.5) => 
         map(
         (NULL < c_finance and c_finance <= 8.35) => 0.0100797252,
         (c_finance > 8.35) => 
            map(
            (NULL < c_hval_175k_p and c_hval_175k_p <= 11.65) => 0.0225860251,
            (c_hval_175k_p > 11.65) => 0.2279768720,
            (c_hval_175k_p = NULL) => 0.0921812707, 0.0921812707),
         (c_finance = NULL) => 0.0222391952, 0.0222391952),
      (f_srchphonesrchcount_i > 8.5) => -0.0971560795,
      (f_srchphonesrchcount_i = NULL) => 0.0187255026, 0.0187255026),
   (f_idrisktype_i > 1.5) => 0.1183017408,
   (f_idrisktype_i = NULL) => 0.0241035065, 0.0241035065),
(f_rel_felony_count_i = NULL) => 0.0176815060, -0.0027930768);

// Tree: 174 
woFDN_FL_PS__lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 21.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 38.35) => 
         map(
         (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
            map(
            (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 0.0600407867,
            (r_C10_M_Hdr_FS_d > 15.5) => 0.0017018908,
            (r_C10_M_Hdr_FS_d = NULL) => 0.0026221264, 0.0026221264),
         (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0572380709,
         (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0000311627, 0.0000311627),
      (c_hval_20k_p > 38.35) => 0.1383636347,
      (c_hval_20k_p = NULL) => -0.0088065786, 0.0003859868),
   (f_srchssnsrchcount_i > 21.5) => 0.0850922791,
   (f_srchssnsrchcount_i = NULL) => 0.0008469735, 0.0008469735),
(f_srchphonesrchcount_i > 21.5) => -0.1004785805,
(f_srchphonesrchcount_i = NULL) => -0.0241149597, 0.0000577061);

// Tree: 175 
woFDN_FL_PS__lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0089606725,
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < c_employees and c_employees <= 47.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 178.5) => -0.0082796274,
      (c_no_car > 178.5) => -0.1088690218,
      (c_no_car = NULL) => -0.0229306914, -0.0229306914),
   (c_employees > 47.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.05) => 0.1529538450,
      (C_INC_200K_P > 0.05) => 0.0310697488,
      (C_INC_200K_P = NULL) => 0.0375046234, 0.0375046234),
   (c_employees = NULL) => -0.0202176015, 0.0260177317),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.85) => -0.0602631474,
   (c_pop_55_64_p > 11.85) => 0.0657220105,
   (c_pop_55_64_p = NULL) => -0.0019559669, -0.0019559669), -0.0012071529);

// Tree: 176 
woFDN_FL_PS__lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.35) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => 0.0020009338,
   (k_inq_per_phone_i > 1.5) => 0.0353449623,
   (k_inq_per_phone_i = NULL) => 0.0053151572, 0.0053151572),
(c_pop_18_24_p > 11.35) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.15) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0441444757,
      (f_varrisktype_i > 4.5) => -0.1331177238,
      (f_varrisktype_i = NULL) => -0.0480196172, -0.0480196172),
   (c_hval_175k_p > 2.15) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 15.5) => 0.1081908091,
      (r_C21_M_Bureau_ADL_FS_d > 15.5) => -0.0046142820,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0010453549, 0.0010453549),
   (c_hval_175k_p = NULL) => -0.0206015056, -0.0206015056),
(c_pop_18_24_p = NULL) => 0.0134192868, 0.0001453584);

// Tree: 177 
woFDN_FL_PS__lgt_177 := map(
(NULL < c_med_hhinc and c_med_hhinc <= 24274) => 
   map(
   (NULL < r_C20_email_domain_ISP_count_i and r_C20_email_domain_ISP_count_i <= 0.5) => -0.0190015016,
   (r_C20_email_domain_ISP_count_i > 0.5) => -0.1273588035,
   (r_C20_email_domain_ISP_count_i = NULL) => -0.0451905776, -0.0451905776),
(c_med_hhinc > 24274) => 
   map(
   (NULL < c_white_col and c_white_col <= 13.85) => 0.0809310381,
   (c_white_col > 13.85) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 0.0038190570,
      (k_comb_age_d > 81.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 339.5) => 0.0019758980,
         (r_C21_M_Bureau_ADL_FS_d > 339.5) => 0.1704300817,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0638570267, 0.0638570267),
      (k_comb_age_d = NULL) => -0.0206819062, 0.0043304023),
   (c_white_col = NULL) => 0.0050170044, 0.0050170044),
(c_med_hhinc = NULL) => 0.0032525744, 0.0036530162);

// Tree: 178 
woFDN_FL_PS__lgt_178 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => -0.0055799073,
(f_srchphonesrchcount_i > 1.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 23.5) => 
      map(
      (NULL < r_A41_Prop_Owner_Inp_Only_d and r_A41_Prop_Owner_Inp_Only_d <= 0.5) => 
         map(
         (NULL < c_retail and c_retail <= 8.6) => 0.0315413616,
         (c_retail > 8.6) => 0.2248145309,
         (c_retail = NULL) => 0.1352489158, 0.1352489158),
      (r_A41_Prop_Owner_Inp_Only_d > 0.5) => 0.0297732733,
      (r_A41_Prop_Owner_Inp_Only_d = NULL) => 0.0808630377, 0.0808630377),
   (k_comb_age_d > 23.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.35) => -0.0704499866,
      (C_INC_200K_P > 0.35) => 0.0182661591,
      (C_INC_200K_P = NULL) => 0.0097407721, 0.0097407721),
   (k_comb_age_d = NULL) => 0.0165753441, 0.0165753441),
(f_srchphonesrchcount_i = NULL) => 0.0274869744, -0.0005890226);

// Tree: 179 
woFDN_FL_PS__lgt_179 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 4.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 51) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 1.95) => -0.0794956662,
      (c_high_ed > 1.95) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 16.5) => 0.0026520647,
         (f_rel_educationover12_count_d > 16.5) => -0.0225606527,
         (f_rel_educationover12_count_d = NULL) => 0.0430612434, 0.0010030568),
      (c_high_ed = NULL) => 0.0000759573, 0.0000759573),
   (C_INC_15K_P > 51) => 0.1073649844,
   (C_INC_15K_P = NULL) => 0.0153159124, 0.0009056939),
(r_D33_eviction_count_i > 4.5) => -0.0739962653,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 4.25) => -0.0123944025,
   (c_low_hval > 4.25) => 0.1054074266,
   (c_low_hval = NULL) => 0.0358850356, 0.0358850356), 0.0009437277);

// Tree: 180 
woFDN_FL_PS__lgt_180 := map(
(NULL < k_inq_adls_per_ssn_i and k_inq_adls_per_ssn_i <= 1.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 44.55) => 
      map(
      (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => -0.0206000359,
         (f_rel_incomeover50_count_d > 0.5) => 0.0150864003,
         (f_rel_incomeover50_count_d = NULL) => 
            map(
            (NULL < c_preschl and c_preschl <= 103.5) => -0.0520331127,
            (c_preschl > 103.5) => 0.1505486412,
            (c_preschl = NULL) => 0.0561249423, 0.0561249423), 0.0133047929),
      (f_dl_addrs_per_adl_i > 0.5) => -0.0134333926,
      (f_dl_addrs_per_adl_i = NULL) => -0.0028921561, 0.0024735910),
   (c_hh1_p > 44.55) => -0.0322394356,
   (c_hh1_p = NULL) => 0.0267415654, -0.0004400163),
(k_inq_adls_per_ssn_i > 1.5) => 0.1216652791,
(k_inq_adls_per_ssn_i = NULL) => 0.0000797855, 0.0000797855);

// Tree: 181 
woFDN_FL_PS__lgt_181 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 14.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 12.5) => -0.0433086078,
   (f_mos_inq_banko_om_fseen_d > 12.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 11.5) => 0.0016549149,
      (f_srchfraudsrchcount_i > 11.5) => -0.0829965846,
      (f_srchfraudsrchcount_i = NULL) => 0.0012011547, 0.0012011547),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0011993558, -0.0011993558),
(f_srchssnsrchcount_i > 14.5) => 
   map(
   (NULL < c_preschl and c_preschl <= 134) => 0.1013648387,
   (c_preschl > 134) => -0.0241628581,
   (c_preschl = NULL) => 0.0498894522, 0.0498894522),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 417.5) => -0.0270943907,
   (c_families > 417.5) => 0.0782835847,
   (c_families = NULL) => 0.0168130990, 0.0168130990), -0.0004622684);

// Tree: 182 
woFDN_FL_PS__lgt_182 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 18.15) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 0.0020805716,
   (f_inq_Other_count24_i > 3.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 1.5) => -0.0288849483,
      (f_assocrisktype_i > 1.5) => 
         map(
         (NULL < c_health and c_health <= 6) => 0.0418261039,
         (c_health > 6) => 0.2133468487,
         (c_health = NULL) => 0.1267849775, 0.1267849775),
      (f_assocrisktype_i = NULL) => 0.0578686041, 0.0578686041),
   (f_inq_Other_count24_i = NULL) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.25) => 0.0336028816,
      (c_pop_35_44_p > 15.25) => -0.0795874757,
      (c_pop_35_44_p = NULL) => -0.0145253018, -0.0145253018), 0.0027817173),
(c_pop_0_5_p > 18.15) => -0.0903185602,
(c_pop_0_5_p = NULL) => 0.0005728651, 0.0018136203);

// Tree: 183 
woFDN_FL_PS__lgt_183 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < r_nas_fname_verd_d and r_nas_fname_verd_d <= 0.5) => 0.0866931667,
   (r_nas_fname_verd_d > 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 15.75) => 0.0627261469,
      (c_fammar_p > 15.75) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => -0.0067591288,
         (k_inq_per_ssn_i > 7.5) => 0.0514228472,
         (k_inq_per_ssn_i = NULL) => -0.0058586589, -0.0058586589),
      (c_fammar_p = NULL) => -0.0061399952, -0.0054515740),
   (r_nas_fname_verd_d = NULL) => -0.0050377724, -0.0050377724),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0831574850,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 125.5) => -0.0441423872,
   (c_ab_av_edu > 125.5) => 0.0440490576,
   (c_ab_av_edu = NULL) => -0.0069707865, -0.0069707865), -0.0056170856);

// Tree: 184 
woFDN_FL_PS__lgt_184 := map(
(NULL < c_burglary and c_burglary <= 4) => -0.0658450551,
(c_burglary > 4) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0040351447,
   (c_rnt1250_p > 15.45) => 
      map(
      (NULL < c_preschl and c_preschl <= 151.5) => 0.0052246166,
      (c_preschl > 151.5) => 
         map(
         (NULL < c_retail and c_retail <= 33.4) => 
            map(
            (NULL < c_low_ed and c_low_ed <= 69.65) => 0.0342375561,
            (c_low_ed > 69.65) => 0.1530381442,
            (c_low_ed = NULL) => 0.0437355727, 0.0437355727),
         (c_retail > 33.4) => 0.2522708644,
         (c_retail = NULL) => 0.0566449002, 0.0566449002),
      (c_preschl = NULL) => 0.0186845849, 0.0186845849),
   (c_rnt1250_p = NULL) => 0.0021070299, 0.0021070299),
(c_burglary = NULL) => 0.0107290677, -0.0004538914);

// Tree: 185 
woFDN_FL_PS__lgt_185 := map(
(NULL < c_for_sale and c_for_sale <= 163.5) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 0.5) => -0.0252835442,
      (f_rel_bankrupt_count_i > 0.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.6) => 0.2032868598,
         (c_pop_35_44_p > 13.6) => 0.0205564890,
         (c_pop_35_44_p = NULL) => 0.1030461993, 0.1030461993),
      (f_rel_bankrupt_count_i = NULL) => 0.0588277109, 0.0588277109),
   (r_I61_inq_collection_recency_d > 4.5) => 
      map(
      (NULL < c_pop00 and c_pop00 <= 8619) => 0.0066014752,
      (c_pop00 > 8619) => 0.1731714371,
      (c_pop00 = NULL) => 0.0078502795, 0.0078502795),
   (r_I61_inq_collection_recency_d = NULL) => -0.0002458578, 0.0091153862),
(c_for_sale > 163.5) => -0.0219783591,
(c_for_sale = NULL) => -0.0056011336, 0.0032081193);

// Tree: 186 
woFDN_FL_PS__lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 14.35) => 
      map(
      (NULL < c_robbery and c_robbery <= 108.5) => -0.0034264180,
      (c_robbery > 108.5) => 
         map(
         (NULL < c_unempl and c_unempl <= 172.5) => 0.0338922669,
         (c_unempl > 172.5) => 0.0892516597,
         (c_unempl = NULL) => 0.0393905468, 0.0393905468),
      (c_robbery = NULL) => 0.0140426184, 0.0140426184),
   (C_INC_75K_P > 14.35) => -0.0059406191,
   (C_INC_75K_P = NULL) => 0.0056559022, 0.0000819456),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0851735729,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 6.15) => 0.0620211943,
   (c_hval_250k_p > 6.15) => -0.0395365485,
   (c_hval_250k_p = NULL) => 0.0141165986, 0.0141165986), 0.0005636713);

// Tree: 187 
woFDN_FL_PS__lgt_187 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 24.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 31.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 41.65) => -0.0003129703,
      (c_hval_80k_p > 41.65) => -0.0928398906,
      (c_hval_80k_p = NULL) => -0.0081504276, -0.0013741619),
   (f_rel_ageover30_count_d > 31.5) => 0.1003690266,
   (f_rel_ageover30_count_d = NULL) => -0.0009561537, -0.0009561537),
(f_rel_incomeover50_count_d > 24.5) => -0.0776663588,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 70.5) => 0.1221714327,
      (c_totcrime > 70.5) => -0.0121060893,
      (c_totcrime = NULL) => 0.0383741822, 0.0383741822),
   (r_Phn_Cell_n > 0.5) => -0.0505760182,
   (r_Phn_Cell_n = NULL) => -0.0143177254, -0.0143177254), -0.0023675744);

// Tree: 188 
woFDN_FL_PS__lgt_188 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 63.95) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
      map(
      (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 129.5) => 
            map(
            (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 1458.5) => 0.0034517891,
            (r_A50_pb_total_dollars_d > 1458.5) => 0.0818354470,
            (r_A50_pb_total_dollars_d = NULL) => 0.0521208396, 0.0521208396),
         (c_no_teens > 129.5) => -0.0027234043,
         (c_no_teens = NULL) => 0.0338008566, 0.0338008566),
      (f_validationrisktype_i > 1.5) => -0.0474443358,
      (f_validationrisktype_i = NULL) => 0.0255838966, 0.0255838966),
   (k_estimated_income_d > 28500) => -0.0009736542,
   (k_estimated_income_d = NULL) => -0.0120243196, 0.0026844242),
(C_RENTOCC_P > 63.95) => -0.0273032536,
(C_RENTOCC_P = NULL) => -0.0241633117, -0.0008549228);

// Tree: 189 
woFDN_FL_PS__lgt_189 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0218298654,
(f_addrs_per_ssn_i > 4.5) => 
   map(
   (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 1.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 12.95) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 240853) => -0.0380201030,
         (f_prevaddrmedianvalue_d > 240853) => 0.1773816272,
         (f_prevaddrmedianvalue_d = NULL) => 0.0407054025, 0.0407054025),
      (C_INC_25K_P > 12.95) => 0.2027088551,
      (C_INC_25K_P = NULL) => 0.0732362162, 0.0732362162),
   (r_C20_email_verification_d > 1.5) => -0.0343676507,
   (r_C20_email_verification_d = NULL) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 0.0006086213,
      (f_inq_QuizProvider_count_i > 5.5) => 0.0925070854,
      (f_inq_QuizProvider_count_i = NULL) => 0.0421260737, 0.0019491175), 0.0033522055),
(f_addrs_per_ssn_i = NULL) => -0.0028812752, -0.0028812752);

// Tree: 190 
woFDN_FL_PS__lgt_190 := map(
(NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 7.5) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 3.5) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 2.35) => 0.0022223516,
      (c_hval_60k_p > 2.35) => 
         map(
         (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => -0.0462269918,
         (f_phone_ver_insurance_d > 2.5) => -0.0027047870,
         (f_phone_ver_insurance_d = NULL) => -0.0198771964, -0.0198771964),
      (c_hval_60k_p = NULL) => -0.0104279190, -0.0036158333),
   (f_inq_Banking_count24_i > 3.5) => 
      map(
      (NULL < c_professional and c_professional <= 2.85) => 0.1385124471,
      (c_professional > 2.85) => 0.0034775903,
      (c_professional = NULL) => 0.0517043249, 0.0517043249),
   (f_inq_Banking_count24_i = NULL) => -0.0029214010, -0.0029214010),
(f_inq_Banking_count24_i > 7.5) => -0.1107598947,
(f_inq_Banking_count24_i = NULL) => -0.0057494584, -0.0034660624);

// Tree: 191 
woFDN_FL_PS__lgt_191 := map(
(NULL < c_manufacturing and c_manufacturing <= 16.85) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 6.5) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 640.5) => -0.1216452742,
      (c_popover25 > 640.5) => -0.0104790321,
      (c_popover25 = NULL) => -0.0306672412, -0.0306672412),
   (f_mos_inq_banko_cm_lseen_d > 6.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 186.5) => 0.0039250017,
      (c_unempl > 186.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 268.5) => 0.1071737205,
         (r_C21_M_Bureau_ADL_FS_d > 268.5) => -0.0416938181,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0542629688, 0.0542629688),
      (c_unempl = NULL) => 0.0046907735, 0.0046907735),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0305190637, 0.0030279555),
(c_manufacturing > 16.85) => -0.0466889338,
(c_manufacturing = NULL) => -0.0213671860, -0.0012016724);

// Tree: 192 
woFDN_FL_PS__lgt_192 := map(
(NULL < c_unemp and c_unemp <= 14.55) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 96) => 0.0727739924,
   (r_D32_Mos_Since_Fel_LS_d > 96) => 
      map(
      (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 3.5) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 5.45) => -0.0120126684,
         (c_femdiv_p > 5.45) => 0.0135839468,
         (c_femdiv_p = NULL) => -0.0033692538, -0.0033692538),
      (f_rel_ageover50_count_d > 3.5) => -0.0557933479,
      (f_rel_ageover50_count_d = NULL) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 4.75) => -0.0144021258,
         (c_hval_125k_p > 4.75) => 0.1789903057,
         (c_hval_125k_p = NULL) => 0.0367598931, 0.0367598931), -0.0043715972),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0041706358, -0.0040503099),
(c_unemp > 14.55) => -0.0712285010,
(c_unemp = NULL) => -0.0102462748, -0.0045511796);

// Tree: 193 
woFDN_FL_PS__lgt_193 := map(
(NULL < C_INC_75K_P and C_INC_75K_P <= 27.85) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 15850) => -0.0813382170,
   (r_A46_Curr_AVM_AutoVal_d > 15850) => 0.0017188815,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0075903852, -0.0026238886),
(C_INC_75K_P > 27.85) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.05) => 
      map(
      (NULL < f_accident_recency_d and f_accident_recency_d <= 61.5) => 0.1192164596,
      (f_accident_recency_d > 61.5) => -0.0042167191,
      (f_accident_recency_d = NULL) => 0.0168516527, 0.0168516527),
   (r_C12_source_profile_d > 75.05) => 
      map(
      (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 0.2401748699,
      (f_dl_addrs_per_adl_i > 0.5) => -0.0005061563,
      (f_dl_addrs_per_adl_i = NULL) => 0.1285863941, 0.1285863941),
   (r_C12_source_profile_d = NULL) => 0.0357897445, 0.0357897445),
(C_INC_75K_P = NULL) => -0.0205562943, -0.0010715397);

// Tree: 194 
woFDN_FL_PS__lgt_194 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 12.5) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 115.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 89273.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => 0.0298163995,
         (f_addrs_per_ssn_i > 7.5) => 
            map(
            (NULL < c_hval_175k_p and c_hval_175k_p <= 4.75) => -0.1201391825,
            (c_hval_175k_p > 4.75) => -0.0409795792,
            (c_hval_175k_p = NULL) => -0.0759360992, -0.0759360992),
         (f_addrs_per_ssn_i = NULL) => -0.0522289456, -0.0522289456),
      (f_prevaddrmedianincome_d > 89273.5) => 0.0981573337,
      (f_prevaddrmedianincome_d = NULL) => -0.0292649328, -0.0292649328),
   (f_mos_liens_unrel_CJ_lseen_d > 115.5) => 0.0006255432,
   (f_mos_liens_unrel_CJ_lseen_d = NULL) => -0.0006586544, -0.0006586544),
(r_C14_addrs_15yr_i > 12.5) => 0.1048424370,
(r_C14_addrs_15yr_i = NULL) => -0.0012874193, -0.0002244461);

// Tree: 195 
woFDN_FL_PS__lgt_195 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 3.95) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 12.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 1.5) => 0.0268558085,
      (f_assocrisktype_i > 1.5) => 0.1470239423,
      (f_assocrisktype_i = NULL) => 0.0596289359, 0.0596289359),
   (r_C21_M_Bureau_ADL_FS_d > 12.5) => -0.0151458167,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0508552700, -0.0133527086),
(c_rnt1250_p > 3.95) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 4.55) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.55) => 0.2397404054,
      (c_pop_18_24_p > 7.55) => 0.0142316565,
      (c_pop_18_24_p = NULL) => 0.1122113198, 0.1122113198),
   (c_rnt1250_p > 4.55) => 0.0119069782,
   (c_rnt1250_p = NULL) => 0.0143550727, 0.0143550727),
(c_rnt1250_p = NULL) => 0.0191710052, 0.0004446519);

// Tree: 196 
woFDN_FL_PS__lgt_196 := map(
(NULL < f_varmsrcssncount_i and f_varmsrcssncount_i <= 0.5) => -0.0936172154,
(f_varmsrcssncount_i > 0.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 74.85) => 
      map(
      (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 22.5) => -0.0964851850,
      (f_mos_inq_banko_am_lseen_d > 22.5) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 88.5) => -0.0030220977,
         (c_lowrent > 88.5) => 0.0773686229,
         (c_lowrent = NULL) => -0.0012560268, -0.0012560268),
      (f_mos_inq_banko_am_lseen_d = NULL) => -0.0031698990, -0.0031698990),
   (c_rnt1000_p > 74.85) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 0.2457811553,
      (f_phone_ver_insurance_d > 2.5) => 0.0261286027,
      (f_phone_ver_insurance_d = NULL) => 0.0966957124, 0.0966957124),
   (c_rnt1000_p = NULL) => 0.0026497979, -0.0012512485),
(f_varmsrcssncount_i = NULL) => 0.0166976088, -0.0020577950);

// Tree: 197 
woFDN_FL_PS__lgt_197 := map(
(NULL < c_hh1_p and c_hh1_p <= 19.65) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 1.85) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 2.5) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 385508.5) => 0.0473876444,
         (f_prevaddrmedianvalue_d > 385508.5) => 0.2825455206,
         (f_prevaddrmedianvalue_d = NULL) => 0.0953790477, 0.0953790477),
      (f_rel_ageover20_count_d > 2.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 54.55) => 0.0311443281,
         (C_RENTOCC_P > 54.55) => -0.0559572029,
         (C_RENTOCC_P = NULL) => 0.0258768489, 0.0258768489),
      (f_rel_ageover20_count_d = NULL) => 0.0459381190, 0.0318771323),
   (c_wholesale > 1.85) => -0.0109841777,
   (c_wholesale = NULL) => 0.0170951853, 0.0170951853),
(c_hh1_p > 19.65) => -0.0094394104,
(c_hh1_p = NULL) => -0.0037880708, 0.0006002953);

// Tree: 198 
woFDN_FL_PS__lgt_198 := map(
(NULL < c_sub_bus and c_sub_bus <= 118.5) => -0.0077083017,
(c_sub_bus > 118.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.4) => 
      map(
      (NULL < c_retail and c_retail <= 12.95) => -0.0025724900,
      (c_retail > 12.95) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 15.5) => 0.0292554997,
         (f_rel_homeover300_count_d > 15.5) => 0.1683358226,
         (f_rel_homeover300_count_d = NULL) => 0.0338501827, 0.0338501827),
      (c_retail = NULL) => 0.0109537579, 0.0109537579),
   (r_C12_source_profile_d > 81.4) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 30.4) => 0.1651002069,
      (c_high_ed > 30.4) => 0.0053322987,
      (c_high_ed = NULL) => 0.0730528524, 0.0730528524),
   (r_C12_source_profile_d = NULL) => 0.0136924294, 0.0136924294),
(c_sub_bus = NULL) => -0.0176496395, 0.0014199869);

// Tree: 199 
woFDN_FL_PS__lgt_199 := map(
(NULL < c_hh6_p and c_hh6_p <= 11.05) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 15.55) => -0.0011645592,
   (c_pop_0_5_p > 15.55) => -0.0569885417,
   (c_pop_0_5_p = NULL) => -0.0027612541, -0.0027612541),
(c_hh6_p > 11.05) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 73718.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01353198495) => -0.0389821998,
      (f_add_curr_nhood_VAC_pct_i > 0.01353198495) => 
         map(
         (NULL < C_INC_15K_P and C_INC_15K_P <= 10.45) => 0.1609889989,
         (C_INC_15K_P > 10.45) => -0.0110187996,
         (C_INC_15K_P = NULL) => 0.0791950807, 0.0791950807),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0226942641, 0.0226942641),
   (f_prevaddrmedianincome_d > 73718.5) => 0.1718695631,
   (f_prevaddrmedianincome_d = NULL) => 0.0537365229, 0.0537365229),
(c_hh6_p = NULL) => -0.0229398290, -0.0017044257);

// Tree: 200 
woFDN_FL_PS__lgt_200 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 34.25) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 40.5) => -0.0959090586,
   (f_mos_inq_banko_am_lseen_d > 40.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
         map(
         (NULL < c_business and c_business <= 0.5) => 0.0981526266,
         (c_business > 0.5) => 
            map(
            (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => -0.0008559836,
            (nf_seg_FraudPoint_3_0 in ['4: Recent Activity']) => 0.0436598928,
            (nf_seg_FraudPoint_3_0 = '') => 0.0062653340, 0.0062653340),
         (c_business = NULL) => 0.0078768481, 0.0078768481),
      (f_phone_ver_insurance_d > 3.5) => -0.0159152097,
      (f_phone_ver_insurance_d = NULL) => -0.0039333071, -0.0039333071),
   (f_mos_inq_banko_am_lseen_d = NULL) => 0.0112463826, -0.0057337392),
(c_hval_80k_p > 34.25) => -0.0554297486,
(c_hval_80k_p = NULL) => -0.0453375317, -0.0076088437);

// Tree: 201 
woFDN_FL_PS__lgt_201 := map(
(NULL < c_relig_indx and c_relig_indx <= 99.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 4.5) => 0.1460892811,
   (f_mos_acc_lseen_d > 4.5) => 0.0094742791,
   (f_mos_acc_lseen_d = NULL) => 0.0023094673, 0.0110764240),
(c_relig_indx > 99.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => -0.0140163512,
      (f_inq_Communications_count_i > 3.5) => -0.0820741834,
      (f_inq_Communications_count_i = NULL) => -0.0145952533, -0.0145952533),
   (f_srchcomponentrisktype_i > 3.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 98) => -0.0102616488,
      (c_robbery > 98) => 0.1255408140,
      (c_robbery = NULL) => 0.0490172040, 0.0490172040),
   (f_srchcomponentrisktype_i = NULL) => 0.0011500969, -0.0132591372),
(c_relig_indx = NULL) => 0.0001041484, -0.0019557788);

// Tree: 202 
woFDN_FL_PS__lgt_202 := map(
(NULL < c_hval_1001k_p and c_hval_1001k_p <= 68.3) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 15.5) => -0.0339029124,
   (f_mos_inq_banko_om_fseen_d > 15.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.45) => -0.0091465329,
         (c_pop_35_44_p > 14.45) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 40926.5) => 0.2501569343,
            (f_prevaddrmedianincome_d > 40926.5) => 0.0875470994,
            (f_prevaddrmedianincome_d = NULL) => 0.1138703625, 0.1138703625),
         (c_pop_35_44_p = NULL) => 0.0561103520, 0.0561103520),
      (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0024829342,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0012279739, 0.0012279739),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0118453516, -0.0011059105),
(c_hval_1001k_p > 68.3) => 0.1488631961,
(c_hval_1001k_p = NULL) => 0.0340606287, 0.0006276361);

// Tree: 203 
woFDN_FL_PS__lgt_203 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 50.85) => 
   map(
   (NULL < f_inq_Auto_count_i and f_inq_Auto_count_i <= 6.5) => 
      map(
      (NULL < c_rape and c_rape <= 195.5) => 
         map(
         (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0024968925,
         (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0484499487,
         (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0003049886, 0.0003049886),
      (c_rape > 195.5) => 
         map(
         (NULL < c_highinc and c_highinc <= 1.35) => -0.1421600165,
         (c_highinc > 1.35) => -0.0213320692,
         (c_highinc = NULL) => -0.0669594060, -0.0669594060),
      (c_rape = NULL) => -0.0004906118, -0.0004906118),
   (f_inq_Auto_count_i > 6.5) => -0.1145755663,
   (f_inq_Auto_count_i = NULL) => -0.0047597647, -0.0012411782),
(c_hval_500k_p > 50.85) => 0.1009410420,
(c_hval_500k_p = NULL) => -0.0263251226, -0.0010954431);

// Tree: 204 
woFDN_FL_PS__lgt_204 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 198.5) => 
   map(
   (NULL < c_young and c_young <= 64.85) => 
      map(
      (NULL < c_retail and c_retail <= 39.25) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 0.0041742024,
         (r_D33_eviction_count_i > 3.5) => 0.0559890004,
         (r_D33_eviction_count_i = NULL) => 0.0045287038, 0.0045287038),
      (c_retail > 39.25) => -0.0486439419,
      (c_retail = NULL) => 0.0028337651, 0.0028337651),
   (c_young > 64.85) => -0.1073402087,
   (c_young = NULL) => 0.0027147679, 0.0019221973),
(f_prevaddrcartheftindex_i > 198.5) => -0.1228341785,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 102.5) => 0.0364649291,
   (c_robbery > 102.5) => -0.0715348705,
   (c_robbery = NULL) => -0.0077972839, -0.0077972839), 0.0011372071);

// Tree: 205 
woFDN_FL_PS__lgt_205 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5922.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 2969.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 118.5) => -0.0071458674,
      (c_for_sale > 118.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 134.5) => 0.0041860956,
         (c_sub_bus > 134.5) => 0.0398054022,
         (c_sub_bus = NULL) => 0.0151324511, 0.0151324511),
      (c_for_sale = NULL) => -0.0182708350, 0.0021254175),
   (f_liens_unrel_SC_total_amt_i > 2969.5) => -0.0750030804,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0013234094, 0.0013234094),
(f_liens_unrel_ST_total_amt_i > 5922.5) => 0.1575577104,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.25) => -0.0611344088,
   (c_pop_6_11_p > 8.25) => 0.0587362926,
   (c_pop_6_11_p = NULL) => -0.0035587176, -0.0035587176), 0.0019007455);

// Tree: 206 
woFDN_FL_PS__lgt_206 := map(
(NULL < c_hh00 and c_hh00 <= 929.5) => -0.0098582050,
(c_hh00 > 929.5) => 
   map(
   (NULL < c_business and c_business <= 158.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 29.5) => 
         map(
         (NULL < c_trailer_p and c_trailer_p <= 3.05) => 
            map(
            (NULL < c_low_hval and c_low_hval <= 0.1) => 0.1603577040,
            (c_low_hval > 0.1) => -0.0471476615,
            (c_low_hval = NULL) => 0.0463089535, 0.0463089535),
         (c_trailer_p > 3.05) => 0.2330296351,
         (c_trailer_p = NULL) => 0.1042906388, 0.1042906388),
      (f_mos_inq_banko_cm_lseen_d > 29.5) => 0.0348640764,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0427346294, 0.0427346294),
   (c_business > 158.5) => -0.0296130972,
   (c_business = NULL) => 0.0170895988, 0.0170895988),
(c_hh00 = NULL) => 0.0170148379, -0.0036589038);

// Tree: 207 
woFDN_FL_PS__lgt_207 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0008468161,
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 23.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.31449654675) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 92) => 
            map(
            (NULL < c_hh2_p and c_hh2_p <= 32.4) => -0.0586148496,
            (c_hh2_p > 32.4) => 0.0886255379,
            (c_hh2_p = NULL) => 0.0114573830, 0.0114573830),
         (f_M_Bureau_ADL_FS_all_d > 92) => -0.0806983301,
         (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0352961020, -0.0352961020),
      (f_add_curr_mobility_index_i > 0.31449654675) => -0.0129197835,
      (f_add_curr_mobility_index_i = NULL) => -0.0262362313, -0.0262362313),
   (f_rel_incomeover25_count_d > 23.5) => -0.1097786263,
   (f_rel_incomeover25_count_d = NULL) => -0.0336037496, -0.0336037496),
(f_varrisktype_i = NULL) => -0.0054879469, -0.0010645410);

// Tree: 208 
woFDN_FL_PS__lgt_208 := map(
(NULL < r_I60_inq_mortgage_recency_d and r_I60_inq_mortgage_recency_d <= 18) => -0.0753373145,
(r_I60_inq_mortgage_recency_d > 18) => 
   map(
   (NULL < c_totsales and c_totsales <= 969.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => -0.0152497897,
      (f_inq_HighRiskCredit_count24_i > 2.5) => -0.0899253829,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0166689382, -0.0166689382),
   (c_totsales > 969.5) => 
      map(
      (NULL < c_employees and c_employees <= 18.5) => 0.1660438917,
      (c_employees > 18.5) => 0.0061594032,
      (c_employees = NULL) => 0.0070327071, 0.0070327071),
   (c_totsales = NULL) => 0.0070610329, 0.0018695086),
(r_I60_inq_mortgage_recency_d = NULL) => 
   map(
   (NULL < c_unemp and c_unemp <= 3.75) => -0.0677394707,
   (c_unemp > 3.75) => 0.0342594694,
   (c_unemp = NULL) => -0.0060833950, -0.0060833950), -0.0010891961);

// Tree: 209 
woFDN_FL_PS__lgt_209 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 130.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 10.75) => -0.0082121753,
   (c_hh6_p > 10.75) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','5: Vuln Vic/Friendly','6: Other']) => -0.0075418378,
      (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity']) => 0.1569637341,
      (nf_seg_FraudPoint_3_0 = '') => 0.0448902170, 0.0448902170),
   (c_hh6_p = NULL) => -0.0040377239, -0.0064343818),
(f_prevaddrageoldest_d > 130.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 2953.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 0.0350963656,
      (f_phone_ver_insurance_d > 3.5) => -0.0057559997,
      (f_phone_ver_insurance_d = NULL) => 0.0122219643, 0.0122219643),
   (f_liens_unrel_SC_total_amt_i > 2953.5) => 0.1543478224,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0139797046, 0.0139797046),
(f_prevaddrageoldest_d = NULL) => -0.0035347856, 0.0008820574);

// Tree: 210 
woFDN_FL_PS__lgt_210 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => 0.0019431919,
(f_srchfraudsrchcount_i > 4.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 84453) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => 0.0450892888,
      (k_comb_age_d > 25.5) => 
         map(
         (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 30.5) => -0.0879286723,
         (f_mos_inq_banko_om_lseen_d > 30.5) => -0.0390665350,
         (f_mos_inq_banko_om_lseen_d = NULL) => -0.0512453860, -0.0512453860),
      (k_comb_age_d = NULL) => -0.0391087341, -0.0391087341),
   (f_prevaddrmedianincome_d > 84453) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 4.5) => -0.0283269776,
      (f_inq_Collection_count_i > 4.5) => 0.1383116480,
      (f_inq_Collection_count_i = NULL) => 0.0299965414, 0.0299965414),
   (f_prevaddrmedianincome_d = NULL) => -0.0271164954, -0.0271164954),
(f_srchfraudsrchcount_i = NULL) => -0.0121229568, -0.0002931849);

// Tree: 211 
woFDN_FL_PS__lgt_211 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 8.25) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 207.35) => 0.1255826921,
   (c_cpiall > 207.35) => 0.0220385899,
   (c_cpiall = NULL) => 0.0376160212, 0.0376160212),
(c_fammar18_p > 8.25) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 3469) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00244108815) => 0.0738700999,
      (f_add_curr_nhood_MFD_pct_i > 0.00244108815) => -0.0017313793,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0160654796, -0.0025397059),
   (f_liens_unrel_CJ_total_amt_i > 3469) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.20681578315) => 0.0544172215,
      (f_add_curr_mobility_index_i > 0.20681578315) => -0.0720678273,
      (f_add_curr_mobility_index_i = NULL) => -0.0386683523, -0.0386683523),
   (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0198464007, -0.0039409515),
(c_fammar18_p = NULL) => 0.0162667106, -0.0019950004);

// Tree: 212 
woFDN_FL_PS__lgt_212 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 18.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00477897935) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 45.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00140450545) => 0.1617750995,
         (f_add_curr_nhood_BUS_pct_i > 0.00140450545) => -0.0301685426,
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0082982885, -0.0082982885),
      (k_comb_age_d > 45.5) => -0.0657902830,
      (k_comb_age_d = NULL) => -0.0311464802, -0.0311464802),
   (f_add_curr_nhood_BUS_pct_i > 0.00477897935) => 0.0057203557,
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0229063149, 0.0003687384),
(f_srchfraudsrchcount_i > 18.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 132.5) => -0.0112919959,
   (c_asian_lang > 132.5) => 0.1218594943,
   (c_asian_lang = NULL) => 0.0552837492, 0.0552837492),
(f_srchfraudsrchcount_i = NULL) => 0.0059326569, 0.0008806424);

// Tree: 213 
woFDN_FL_PS__lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125511) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 9.85) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 2.5) => 0.0127145203,
      (f_inq_Other_count24_i > 2.5) => 0.1393057123,
      (f_inq_Other_count24_i = NULL) => 0.0167241961, 0.0167241961),
   (c_femdiv_p > 9.85) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','6: Other']) => 0.0493342071,
      (nf_seg_FraudPoint_3_0 in ['3: Derog','5: Vuln Vic/Friendly']) => 0.1982078739,
      (nf_seg_FraudPoint_3_0 = '') => 0.1136860502, 0.1136860502),
   (c_femdiv_p = NULL) => 0.0245396342, 0.0245396342),
(r_A46_Curr_AVM_AutoVal_d > 125511) => -0.0076344536,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < c_retired2 and c_retired2 <= 130.5) => -0.0075625464,
   (c_retired2 > 130.5) => 0.0343419043,
   (c_retired2 = NULL) => 0.0301650976, 0.0043806657), 0.0024735057);

// Tree: 214 
woFDN_FL_PS__lgt_214 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 10.15) => 0.0098248956,
   (c_hval_300k_p > 10.15) => -0.0191652712,
   (c_hval_300k_p = NULL) => -0.0050833479, 0.0013875758),
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 12.95) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 4.65) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 3.5) => 0.0318230577,
         (f_rel_incomeover50_count_d > 3.5) => 0.1397209942,
         (f_rel_incomeover50_count_d = NULL) => 0.0884694743, 0.0884694743),
      (c_femdiv_p > 4.65) => -0.0399255351,
      (c_femdiv_p = NULL) => 0.0327190097, 0.0327190097),
   (c_hval_150k_p > 12.95) => 0.1407751490,
   (c_hval_150k_p = NULL) => 0.0524712072, 0.0524712072),
(f_srchunvrfdaddrcount_i = NULL) => -0.0052468486, 0.0024905781);

// Tree: 215 
woFDN_FL_PS__lgt_215 := map(
(NULL < c_food and c_food <= 75.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => -0.0008489067,
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < c_child and c_child <= 24.85) => -0.0310857661,
      (c_child > 24.85) => 0.1712973102,
      (c_child = NULL) => 0.0692258457, 0.0692258457),
   (f_hh_lienholders_i = NULL) => -0.0178673768, -0.0003310957),
(c_food > 75.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00410008235) => 0.2089765569,
   (f_add_curr_nhood_VAC_pct_i > 0.00410008235) => 
      map(
      (NULL < c_unattach and c_unattach <= 102.5) => 0.1474794879,
      (c_unattach > 102.5) => -0.0479643864,
      (c_unattach = NULL) => 0.0307320409, 0.0307320409),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0661281150, 0.0661281150),
(c_food = NULL) => 0.0209595405, 0.0016937236);

// Tree: 216 
woFDN_FL_PS__lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184) => -0.0867460505,
(f_mos_liens_unrel_FT_lseen_d > 184) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.85) => -0.0107837995,
   (c_hh4_p > 12.85) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 88) => 0.0921099529,
      (f_mos_liens_unrel_SC_fseen_d > 88) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 86817.5) => 
            map(
            (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => 0.0782763578,
            (f_inq_Collection_count_i > 1.5) => -0.0296467785,
            (f_inq_Collection_count_i = NULL) => 0.0518316158, 0.0518316158),
         (f_curraddrmedianvalue_d > 86817.5) => 0.0036078434,
         (f_curraddrmedianvalue_d = NULL) => 0.0080418758, 0.0080418758),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0093272819, 0.0093272819),
   (c_hh4_p = NULL) => 0.0073834305, 0.0004754967),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 0.0042972047, -0.0004707084);

// Tree: 217 
woFDN_FL_PS__lgt_217 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 9.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 54.5) => 0.1331051229,
      (r_C12_source_profile_d > 54.5) => -0.0188599596,
      (r_C12_source_profile_d = NULL) => 0.0578748840, 0.0578748840),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => -0.0010344534,
      (k_inq_adls_per_phone_i > 2.5) => -0.0915918058,
      (k_inq_adls_per_phone_i = NULL) => -0.0014151311, -0.0014151311),
   (r_D33_Eviction_Recency_d = NULL) => 
      map(
      (NULL < c_larceny and c_larceny <= 65) => 0.0536961667,
      (c_larceny > 65) => -0.0425542895,
      (c_larceny = NULL) => -0.0007062651, -0.0007062651), -0.0009327742),
(k_inq_per_phone_i > 9.5) => 0.0548156308,
(k_inq_per_phone_i = NULL) => -0.0005196603, -0.0005196603);

// Tree: 218 
woFDN_FL_PS__lgt_218 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1421178728,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 88.5) => 
         map(
         (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 0.5) => -0.0139804428,
         (f_inq_QuizProvider_count24_i > 0.5) => 0.0672491491,
         (f_inq_QuizProvider_count24_i = NULL) => -0.0091736091, -0.0091736091),
      (c_no_car > 88.5) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 0.1179576306,
         (r_D32_Mos_Since_Crim_LS_d > 9.5) => 0.0139869029,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0157763100, 0.0157763100),
      (c_no_car = NULL) => 0.0284245797, 0.0034254628),
   (f_rel_ageover50_count_d > 1.5) => -0.0280187464,
   (f_rel_ageover50_count_d = NULL) => -0.0337336001, -0.0008843805),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0139124013, -0.0004050035);

// Tree: 219 
woFDN_FL_PS__lgt_219 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < c_transport and c_transport <= 29.05) => 0.0010882013,
   (c_transport > 29.05) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 149) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.15) => 0.2416151540,
         (c_pop_75_84_p > 3.15) => 0.0097301919,
         (c_pop_75_84_p = NULL) => 0.1256726729, 0.1256726729),
      (c_blue_empl > 149) => -0.0226475685,
      (c_blue_empl = NULL) => 0.0609511131, 0.0609511131),
   (c_transport = NULL) => -0.0099914109, 0.0018513107),
(k_inq_adls_per_phone_i > 2.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 123.5) => -0.0081357255,
   (c_sub_bus > 123.5) => -0.1276543456,
   (c_sub_bus = NULL) => -0.0684867119, -0.0684867119),
(k_inq_adls_per_phone_i = NULL) => 0.0012857231, 0.0012857231);

// Tree: 220 
woFDN_FL_PS__lgt_220 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 181.5) => -0.0671412665,
(r_D32_Mos_Since_Fel_LS_d > 181.5) => 
   map(
   (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.35) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 25.45) => -0.0468910038,
      (c_fammar_p > 25.45) => -0.0010006815,
      (c_fammar_p = NULL) => -0.0016319365, -0.0016319365),
   (c_hval_1000k_p > 41.35) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 11.8) => -0.0096926354,
      (c_rnt2000_p > 11.8) => 0.2560401265,
      (c_rnt2000_p = NULL) => 0.1231737455, 0.1231737455),
   (c_hval_1000k_p = NULL) => -0.0257828050, -0.0008015707),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.05) => 0.0540770823,
   (c_pop_35_44_p > 15.05) => -0.0391514137,
   (c_pop_35_44_p = NULL) => 0.0123329796, 0.0123329796), -0.0012025767);

// Tree: 221 
woFDN_FL_PS__lgt_221 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0023559019,
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 15.55) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 138.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 127419.5) => 0.0487069689,
         (r_A46_Curr_AVM_AutoVal_d > 127419.5) => -0.0702685775,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0214794282, -0.0241009822),
      (c_bel_edu > 138.5) => -0.0859388690,
      (c_bel_edu = NULL) => -0.0409658604, -0.0409658604),
   (C_INC_125K_P > 15.55) => 0.1000544250,
   (C_INC_125K_P = NULL) => -0.0295867019, -0.0295867019),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 113) => -0.0525474075,
   (c_easiqlife > 113) => 0.0546469925,
   (c_easiqlife = NULL) => -0.0029367761, -0.0029367761), 0.0005070469);

// Tree: 222 
woFDN_FL_PS__lgt_222 := map(
(NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 13.5) => -0.0552687940,
   (c_exp_prod > 13.5) => 0.0026342798,
   (c_exp_prod = NULL) => 0.0095183012, 0.0017697736),
(f_rel_ageover50_count_d > 1.5) => 
   map(
   (NULL < r_I60_inq_retail_count12_i and r_I60_inq_retail_count12_i <= 0.5) => -0.0443405178,
   (r_I60_inq_retail_count12_i > 0.5) => 0.0791079703,
   (r_I60_inq_retail_count12_i = NULL) => -0.0340104576, -0.0340104576),
(f_rel_ageover50_count_d = NULL) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 0.1077067142,
   (r_C10_M_Hdr_FS_d > 11.5) => -0.0223293500,
   (r_C10_M_Hdr_FS_d = NULL) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 117.5) => 0.0732427908,
      (c_for_sale > 117.5) => -0.0242394957,
      (c_for_sale = NULL) => 0.0241178590, 0.0241178590), 0.0168067563), -0.0018975801);

// Tree: 223 
woFDN_FL_PS__lgt_223 := map(
(NULL < c_old_homes and c_old_homes <= 84.5) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 67.75) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 18.25) => 0.0081031523,
         (c_hval_175k_p > 18.25) => 0.0670293569,
         (c_hval_175k_p = NULL) => 0.0159534828, 0.0159534828),
      (c_newhouse > 67.75) => -0.0318980044,
      (c_newhouse = NULL) => 0.0082017482, 0.0082017482),
   (f_srchunvrfddobcount_i > 0.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 109.5) => 0.0039123759,
      (c_unattach > 109.5) => 0.1716889696,
      (c_unattach = NULL) => 0.0644578423, 0.0644578423),
   (f_srchunvrfddobcount_i = NULL) => -0.0038017186, 0.0099744233),
(c_old_homes > 84.5) => -0.0115750406,
(c_old_homes = NULL) => 0.0159179922, 0.0006735605);

// Tree: 224 
woFDN_FL_PS__lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 741) => -0.0387604010,
   (c_popover25 > 741) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 0.45) => 0.0273224434,
      (c_low_hval > 0.45) => 0.1399806875,
      (c_low_hval = NULL) => 0.0787533809, 0.0787533809),
   (c_popover25 = NULL) => 0.0498565493, 0.0498565493),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => -0.0125141104,
   (f_rel_criminal_count_i > 0.5) => 0.0108336637,
   (f_rel_criminal_count_i = NULL) => 0.0017429145, 0.0017429145),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 108.5) => 0.0733218719,
   (c_robbery > 108.5) => -0.0285493859,
   (c_robbery = NULL) => 0.0258990450, 0.0258990450), 0.0029215587);

// Tree: 225 
woFDN_FL_PS__lgt_225 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 14799) => -0.1078841659,
(r_A46_Curr_AVM_AutoVal_d > 14799) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0037096551,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < c_rnt1500_p and c_rnt1500_p <= 35.25) => 0.0245682106,
      (c_rnt1500_p > 35.25) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 15.35) => 0.2458379646,
         (c_pop_45_54_p > 15.35) => -0.0092871708,
         (c_pop_45_54_p = NULL) => 0.1132305496, 0.1132305496),
      (c_rnt1500_p = NULL) => 0.0303124398, 0.0303124398),
   (k_inf_nothing_found_i = NULL) => 0.0095957517, 0.0095957517),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => -0.0083548092,
   (f_adls_per_phone_c6_i > 1.5) => 0.1839455899,
   (f_adls_per_phone_c6_i = NULL) => -0.0058204852, -0.0058204852), 0.0022994454);

// Tree: 226 
woFDN_FL_PS__lgt_226 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 18.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 157.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 927.5) => -0.0154936223,
      (c_hh00 > 927.5) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 78243) => 0.1607101622,
         (c_med_hval > 78243) => 0.0123489308,
         (c_med_hval = NULL) => 0.0164963512, 0.0164963512),
      (c_hh00 = NULL) => -0.0083399092, -0.0083399092),
   (c_rich_wht > 157.5) => 0.0210699028,
   (c_rich_wht = NULL) => 0.0037507816, -0.0008133251),
(r_D30_Derog_Count_i > 18.5) => -0.1097263246,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 77.5) => 0.0532141389,
   (c_sub_bus > 77.5) => -0.0483423379,
   (c_sub_bus = NULL) => -0.0062335548, -0.0062335548), -0.0013651503);

// Tree: 227 
woFDN_FL_PS__lgt_227 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 14.5) => 
   map(
   (NULL < c_employees and c_employees <= 2.5) => -0.0513396350,
   (c_employees > 2.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 97012) => 
         map(
         (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 9.5) => 0.0170091468,
         (f_rel_homeover200_count_d > 9.5) => 0.1386670223,
         (f_rel_homeover200_count_d = NULL) => 0.0248036774, 0.0248036774),
      (r_A46_Curr_AVM_AutoVal_d > 97012) => 0.0016532422,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0070901755, 0.0003084958),
   (c_employees = NULL) => 0.0031382261, -0.0008777148),
(r_D30_Derog_Count_i > 14.5) => 0.0706489049,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 87.5) => -0.0320427182,
   (c_span_lang > 87.5) => 0.0492217960,
   (c_span_lang = NULL) => 0.0085895389, 0.0085895389), -0.0002457633);

// Tree: 228 
woFDN_FL_PS__lgt_228 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 8.5) => -0.0026674366,
(f_assocsuspicousidcount_i > 8.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 170.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 12.75) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1969.5) => 0.0816038085,
         (c_med_yearblt > 1969.5) => -0.0648587550,
         (c_med_yearblt = NULL) => 0.0097040046, 0.0097040046),
      (c_hh3_p > 12.75) => -0.0747805109,
      (c_hh3_p = NULL) => -0.0518906175, -0.0518906175),
   (c_burglary > 170.5) => 0.0751187642,
   (c_burglary = NULL) => -0.0379641502, -0.0379641502),
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 82.5) => -0.0578617802,
   (c_old_homes > 82.5) => 0.0613712718,
   (c_old_homes = NULL) => 0.0023119096, 0.0023119096), -0.0039149705);

// Tree: 229 
woFDN_FL_PS__lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 4.05) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0093823357) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 8.5) => 0.0216170839,
         (f_corrssnnamecount_d > 8.5) => 0.1820357253,
         (f_corrssnnamecount_d = NULL) => 0.0347781392, 0.0347781392),
      (f_add_curr_nhood_MFD_pct_i > 0.0093823357) => -0.0054787259,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 2875) => 0.1360445026,
         (f_curraddrmedianvalue_d > 2875) => -0.0229758304,
         (f_curraddrmedianvalue_d = NULL) => -0.0187612242, -0.0187612242), -0.0037527491),
   (c_pop_85p_p > 4.05) => 0.0327702242,
   (c_pop_85p_p = NULL) => 0.0124738525, 0.0005018382),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0630947556,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0336626312, -0.0024161262);

// Tree: 230 
woFDN_FL_PS__lgt_230 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 59.5) => -0.0221100009,
   (c_unempl > 59.5) => 
      map(
      (NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 1925) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 367.5) => 0.0045225585,
         (r_C13_max_lres_d > 367.5) => 
            map(
            (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 0.0190105014,
            (f_util_add_curr_misc_n > 0.5) => 0.1296391303,
            (f_util_add_curr_misc_n = NULL) => 0.0586563834, 0.0586563834),
         (r_C13_max_lres_d = NULL) => 0.0072568272, 0.0072568272),
      (f_acc_damage_amt_last_i > 1925) => 0.1215743065,
      (f_acc_damage_amt_last_i = NULL) => 0.0082760935, 0.0082760935),
   (c_unempl = NULL) => -0.0103984527, 0.0008287882),
(f_inq_count24_i > 14.5) => -0.1241400742,
(f_inq_count24_i = NULL) => 0.0004609419, -0.0001100815);

// Tree: 231 
woFDN_FL_PS__lgt_231 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0009842574,
(f_srchvelocityrisktype_i > 6.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 37.5) => -0.0544624413,
   (f_mos_inq_banko_cm_fseen_d > 37.5) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 38.3) => 
         map(
         (NULL < c_white_col and c_white_col <= 33.25) => -0.0428271580,
         (c_white_col > 33.25) => 
            map(
            (NULL < c_hval_100k_p and c_hval_100k_p <= 5.15) => 0.0285039126,
            (c_hval_100k_p > 5.15) => 0.1610623762,
            (c_hval_100k_p = NULL) => 0.0589565326, 0.0589565326),
         (c_white_col = NULL) => 0.0293644692, 0.0293644692),
      (c_lowrent > 38.3) => 0.1477304323,
      (c_lowrent = NULL) => 0.0522444878, 0.0522444878),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0318671892, 0.0318671892),
(f_srchvelocityrisktype_i = NULL) => 0.0054286953, 0.0003462297);

// Tree: 232 
woFDN_FL_PS__lgt_232 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1216700134,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 0.55) => 0.0344173112,
      (c_hh6_p > 0.55) => 
         map(
         (NULL < c_families and c_families <= 195.5) => 
            map(
            (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.45) => 0.1819079396,
            (c_pop_45_54_p > 12.45) => -0.0299419475,
            (c_pop_45_54_p = NULL) => 0.0739844122, 0.0739844122),
         (c_families > 195.5) => -0.0076620349,
         (c_families = NULL) => -0.0039823906, -0.0039823906),
      (c_hh6_p = NULL) => 0.0138922662, 0.0115581973),
   (f_phone_ver_experian_d > 0.5) => -0.0106868088,
   (f_phone_ver_experian_d = NULL) => -0.0081216116, -0.0028970290),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0079548753, -0.0024276046);

// Tree: 233 
woFDN_FL_PS__lgt_233 := map(
(NULL < c_hh6_p and c_hh6_p <= 16.85) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 22.55) => -0.0055135325,
   (C_INC_25K_P > 22.55) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 21707.5) => 0.1415343657,
      (f_curraddrmedianincome_d > 21707.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 46.65) => 
            map(
            (NULL < c_ab_av_edu and c_ab_av_edu <= 75) => -0.0852510168,
            (c_ab_av_edu > 75) => 0.0540395031,
            (c_ab_av_edu = NULL) => -0.0301360629, -0.0301360629),
         (C_OWNOCC_P > 46.65) => 0.1218519640,
         (C_OWNOCC_P = NULL) => 0.0187966677, 0.0187966677),
      (f_curraddrmedianincome_d = NULL) => 0.0447604115, 0.0447604115),
   (C_INC_25K_P = NULL) => -0.0044337797, -0.0044337797),
(c_hh6_p > 16.85) => -0.0904679345,
(c_hh6_p = NULL) => 0.0151465305, -0.0045182053);

// Tree: 234 
woFDN_FL_PS__lgt_234 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 17.95) => -0.0084609445,
   (c_pop_18_24_p > 17.95) => 0.0387421217,
   (c_pop_18_24_p = NULL) => -0.0186352222, -0.0060862108),
(f_srchcomponentrisktype_i > 3.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 165.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 140.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 64.7) => -0.0716058278,
         (r_C12_source_profile_d > 64.7) => 0.0472293571,
         (r_C12_source_profile_d = NULL) => -0.0271494997, -0.0271494997),
      (c_for_sale > 140.5) => 0.0940199457,
      (c_for_sale = NULL) => 0.0072026627, 0.0072026627),
   (c_asian_lang > 165.5) => 0.1559476325,
   (c_asian_lang = NULL) => 0.0445324814, 0.0445324814),
(f_srchcomponentrisktype_i = NULL) => 0.0179983663, -0.0048489511);

// Tree: 235 
woFDN_FL_PS__lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_trailer and c_trailer <= 173.5) => 
      map(
      (NULL < c_rental and c_rental <= 147.5) => -0.0096880892,
      (c_rental > 147.5) => 0.0503275454,
      (c_rental = NULL) => 0.0095158455, 0.0095158455),
   (c_trailer > 173.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 13.75) => -0.0145187580,
      (C_INC_50K_P > 13.75) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 9.5) => 0.0883448422,
         (f_addrs_per_ssn_i > 9.5) => 0.2655522766,
         (f_addrs_per_ssn_i = NULL) => 0.1755194672, 0.1755194672),
      (C_INC_50K_P = NULL) => 0.1063260621, 0.1063260621),
   (c_trailer = NULL) => 0.0687381937, 0.0185012852),
(f_hh_members_ct_d > 1.5) => -0.0065969771,
(f_hh_members_ct_d = NULL) => 0.0109435777, -0.0014676006);

// Tree: 236 
woFDN_FL_PS__lgt_236 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => -0.0026782588,
(r_S66_adlperssn_count_i > 3.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 52.5) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 98) => 0.0193319971,
      (c_relig_indx > 98) => 0.1567509510,
      (c_relig_indx = NULL) => 0.0880414741, 0.0880414741),
   (f_mos_inq_banko_cm_lseen_d > 52.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 13) => 0.1076387560,
      (f_fp_prevaddrcrimeindex_i > 13) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 77.5) => 0.0852189042,
         (c_lar_fam > 77.5) => -0.0621829132,
         (c_lar_fam = NULL) => -0.0238584407, -0.0238584407),
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0029116822, 0.0029116822),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0253511660, 0.0253511660),
(r_S66_adlperssn_count_i = NULL) => -0.0012685013, -0.0012685013);

// Tree: 237 
woFDN_FL_PS__lgt_237 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 14.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.1958354109) => -0.0820216902,
   (f_add_curr_mobility_index_i > 0.1958354109) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 3.65) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.0270898446,
         (k_inq_per_ssn_i > 0.5) => 0.2150146906,
         (k_inq_per_ssn_i = NULL) => 0.1130399679, 0.1130399679),
      (c_bigapt_p > 3.65) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.65) => -0.0601838458,
         (c_pop_75_84_p > 3.65) => 0.0814833377,
         (c_pop_75_84_p = NULL) => -0.0112031707, -0.0112031707),
      (c_bigapt_p = NULL) => 0.0393563400, 0.0393563400),
   (f_add_curr_mobility_index_i = NULL) => 0.0222978060, 0.0222978060),
(r_C10_M_Hdr_FS_d > 14.5) => -0.0038357666,
(r_C10_M_Hdr_FS_d = NULL) => -0.0099290564, -0.0031268777);

// Tree: 238 
woFDN_FL_PS__lgt_238 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 37.7) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 73.5) => -0.0144235364,
      (r_C13_Curr_Addr_LRes_d > 73.5) => 
         map(
         (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 0.0244287036,
         (f_phone_ver_insurance_d > 3.5) => -0.0208221510,
         (f_phone_ver_insurance_d = NULL) => 0.0000883501, 0.0000883501),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0096424512, -0.0076600356),
   (c_wholesale > 37.7) => -0.1295343007,
   (c_wholesale = NULL) => -0.0094380508, -0.0083004469),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 310) => 0.2198020535,
   (r_C10_M_Hdr_FS_d > 310) => -0.0131370288,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0845902874, 0.0845902874),
(f_adls_per_phone_c6_i = NULL) => -0.0070262657, -0.0070262657);

// Tree: 239 
woFDN_FL_PS__lgt_239 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 64.5) => 
   map(
   (NULL < c_trailer and c_trailer <= 144.5) => -0.0326548191,
   (c_trailer > 144.5) => 0.0258585543,
   (c_trailer = NULL) => 0.0096083806, -0.0225925359),
(r_C13_max_lres_d > 64.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 7.5) => -0.0004159790,
   (r_C14_addrs_10yr_i > 7.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 69.5) => 0.1627432284,
      (c_born_usa > 69.5) => -0.0012371982,
      (c_born_usa = NULL) => 0.0572587435, 0.0572587435),
   (r_C14_addrs_10yr_i = NULL) => 0.0005668856, 0.0005668856),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 90) => -0.0202538398,
   (c_no_car > 90) => 0.0874401661,
   (c_no_car = NULL) => 0.0283514195, 0.0283514195), -0.0036955328);

// Tree: 240 
woFDN_FL_PS__lgt_240 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 27.15) => -0.0001834676,
(c_hval_500k_p > 27.15) => 
   map(
   (NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 18) => -0.0976867859,
   (r_I60_inq_retail_recency_d > 18) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 79000) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 16.95) => -0.0314807253,
         (C_INC_75K_P > 16.95) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.23677662635) => -0.0084080323,
            (f_add_curr_mobility_index_i > 0.23677662635) => 0.2899908438,
            (f_add_curr_mobility_index_i = NULL) => 0.1293145259, 0.1293145259),
         (C_INC_75K_P = NULL) => 0.0338423455, 0.0338423455),
      (r_A49_Curr_AVM_Chg_1yr_i > 79000) => -0.0986565275,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0759657220, 0.0429307827),
   (r_I60_inq_retail_recency_d = NULL) => 0.0317760236, 0.0317760236),
(c_hval_500k_p = NULL) => -0.0217642196, 0.0014139325);

// Tree: 241 
woFDN_FL_PS__lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0017839053,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 9.05) => 
      map(
      (NULL < k_inf_contradictory_i and k_inf_contradictory_i <= 0.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 8.9) => -0.0068339159,
         (c_rnt1000_p > 8.9) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 318.5) => 0.0327479361,
            (r_C13_max_lres_d > 318.5) => 0.1921922214,
            (r_C13_max_lres_d = NULL) => 0.1034911344, 0.1034911344),
         (c_rnt1000_p = NULL) => 0.0477695296, 0.0477695296),
      (k_inf_contradictory_i > 0.5) => -0.0593136939,
      (k_inf_contradictory_i = NULL) => 0.0322950753, 0.0322950753),
   (c_femdiv_p > 9.05) => 0.1496655973,
   (c_femdiv_p = NULL) => 0.0445939269, 0.0445939269),
(k_comb_age_d = NULL) => -0.0016239895, 0.0011135288);

// Tree: 242 
woFDN_FL_PS__lgt_242 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0026094983,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 41.65) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 170.5) => 
         map(
         (NULL < c_unattach and c_unattach <= 153.5) => 0.0098140102,
         (c_unattach > 153.5) => 0.1136502670,
         (c_unattach = NULL) => 0.0165282343, 0.0165282343),
      (c_lar_fam > 170.5) => 0.1173257543,
      (c_lar_fam = NULL) => 0.0204610855, 0.0204610855),
   (c_hval_750k_p > 41.65) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 10) => 0.0122125392,
      (C_INC_125K_P > 10) => 0.2045285409,
      (C_INC_125K_P = NULL) => 0.1143804151, 0.1143804151),
   (c_hval_750k_p = NULL) => 0.0284119282, 0.0284119282),
(k_inq_per_ssn_i = NULL) => 0.0011370390, 0.0011370390);

// Tree: 243 
woFDN_FL_PS__lgt_243 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 37) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 409.5) => 0.0032144986,
      (f_M_Bureau_ADL_FS_noTU_d > 409.5) => 
         map(
         (NULL < c_hval_400k_p and c_hval_400k_p <= 7.5) => -0.0242961921,
         (c_hval_400k_p > 7.5) => 0.2019378379,
         (c_hval_400k_p = NULL) => 0.0842961423, 0.0842961423),
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0129113103, 0.0043100188),
   (c_hval_60k_p > 37) => -0.0940259049,
   (c_hval_60k_p = NULL) => 0.0012281280, 0.0034857934),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 217.5) => 0.2068611841,
   (r_C21_M_Bureau_ADL_FS_d > 217.5) => 0.0333244203,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0834795543, 0.0834795543),
(f_adls_per_phone_c6_i = NULL) => 0.0045767608, 0.0045767608);

// Tree: 244 
woFDN_FL_PS__lgt_244 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => -0.0120050098,
(f_curraddrcrimeindex_i > 121) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 89.15) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 17.05) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 157.5) => 0.0197212123,
         (f_prevaddrmurderindex_i > 157.5) => 0.1660012186,
         (f_prevaddrmurderindex_i = NULL) => 0.0556606966, 0.0556606966),
      (c_hh2_p > 17.05) => 0.0048126873,
      (c_hh2_p = NULL) => 0.0085900610, 0.0085900610),
   (c_lowrent > 89.15) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 88.5) => -0.0048490779,
      (c_easiqlife > 88.5) => 0.2389494003,
      (c_easiqlife = NULL) => 0.1305945211, 0.1305945211),
   (c_lowrent = NULL) => 0.0142880715, 0.0142880715),
(f_curraddrcrimeindex_i = NULL) => -0.0158949340, -0.0052584686);

// Tree: 245 
woFDN_FL_PS__lgt_245 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 36.5) => 0.0716677236,
(f_mos_liens_unrel_SC_fseen_d > 36.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 32.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 3.5) => 0.0165160152,
      (r_D30_Derog_Count_i > 3.5) => 
         map(
         (NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => -0.0047064531,
         (r_A41_Prop_Owner_d > 0.5) => 0.1801950088,
         (r_A41_Prop_Owner_d = NULL) => 0.0870594576, 0.0870594576),
      (r_D30_Derog_Count_i = NULL) => 0.0227855114, 0.0227855114),
   (c_many_cars > 32.5) => -0.0045862013,
   (c_many_cars = NULL) => -0.0052968527, -0.0012660809),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 16.9) => -0.0619898689,
   (c_hh3_p > 16.9) => 0.0400972854,
   (c_hh3_p = NULL) => -0.0224212044, -0.0224212044), -0.0009589245);

// Tree: 246 
woFDN_FL_PS__lgt_246 := map(
(NULL < c_hh3_p and c_hh3_p <= 14.55) => -0.0132418406,
(c_hh3_p > 14.55) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
      map(
      (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => 0.0107158262,
      (f_rel_ageover50_count_d > 4.5) => -0.1122218970,
      (f_rel_ageover50_count_d = NULL) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.6654460203) => -0.0265197642,
         (f_add_curr_nhood_SFD_pct_d > 0.6654460203) => 0.1648973318,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0583695567, 0.0583695567), 0.0099883312),
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 60.35) => 0.2127903747,
      (c_civ_emp > 60.35) => 0.0245787454,
      (c_civ_emp = NULL) => 0.0890001756, 0.0890001756),
   (f_assoccredbureaucountnew_i = NULL) => -0.0110589689, 0.0114150459),
(c_hh3_p = NULL) => -0.0107797922, 0.0008536022);

// Tree: 247 
woFDN_FL_PS__lgt_247 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 28.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < c_young and c_young <= 8.65) => -0.0654164243,
      (c_young > 8.65) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 5.5) => -0.0781298526,
         (f_mos_inq_banko_cm_fseen_d > 5.5) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 71.5) => -0.0165976055,
            (r_C13_max_lres_d > 71.5) => 0.0072916508,
            (r_C13_max_lres_d = NULL) => 0.0017559049, 0.0017559049),
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0008022703, 0.0008022703),
      (c_young = NULL) => -0.0200007093, -0.0023025151),
   (r_D33_eviction_count_i > 3.5) => 0.0723793028,
   (r_D33_eviction_count_i = NULL) => -0.0018845310, -0.0018845310),
(f_srchfraudsrchcount_i > 28.5) => -0.0933619897,
(f_srchfraudsrchcount_i = NULL) => -0.0214924423, -0.0024656239);

// Tree: 248 
woFDN_FL_PS__lgt_248 := map(
(NULL < c_many_cars and c_many_cars <= 133.5) => -0.0129681277,
(c_many_cars > 133.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 18.85) => 
      map(
      (NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => 0.0027216147,
      (f_srchunvrfdssncount_i > 0.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 2.85) => 
            map(
            (NULL < c_blue_col and c_blue_col <= 14.65) => 0.0664141578,
            (c_blue_col > 14.65) => 0.2487771288,
            (c_blue_col = NULL) => 0.1388420044, 0.1388420044),
         (c_hh6_p > 2.85) => -0.0626907148,
         (c_hh6_p = NULL) => 0.0801038249, 0.0801038249),
      (f_srchunvrfdssncount_i = NULL) => 0.0070158310, 0.0070158310),
   (C_INC_25K_P > 18.85) => 0.2017541862,
   (C_INC_25K_P = NULL) => 0.0099239520, 0.0099239520),
(c_many_cars = NULL) => 0.0369635535, -0.0051131371);

// Tree: 249 
woFDN_FL_PS__lgt_249 := map(
(NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.05) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 8.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 48.5) => -0.0098391694,
      (r_C13_Curr_Addr_LRes_d > 48.5) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => 0.0130292488,
         (r_D33_eviction_count_i > 1.5) => -0.0677645506,
         (r_D33_eviction_count_i = NULL) => 0.0117727173, 0.0117727173),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0024757039, 0.0024757039),
   (f_inq_Banking_count24_i > 8.5) => -0.1233146380,
   (f_inq_Banking_count24_i = NULL) => -0.0097689482, 0.0018047974),
(c_pop_6_11_p > 15.05) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 861.5) => 0.1573532760,
   (c_popover25 > 861.5) => -0.0576094042,
   (c_popover25 = NULL) => 0.0720506252, 0.0720506252),
(c_pop_6_11_p = NULL) => -0.0038526670, 0.0023669657);

// Tree: 250 
woFDN_FL_PS__lgt_250 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => -0.0020622678,
(C_INC_50K_P > 19.85) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 44.85) => 0.1433495413,
   (c_civ_emp > 44.85) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 7.5) => -0.0051935331,
      (c_hval_250k_p > 7.5) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 153.5) => 0.0363218819,
         (c_bel_edu > 153.5) => 
            map(
            (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 145.5) => 0.0209956145,
            (f_M_Bureau_ADL_FS_noTU_d > 145.5) => 0.2502564870,
            (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.1367610056, 0.1367610056),
         (c_bel_edu = NULL) => 0.0591695204, 0.0591695204),
      (c_hval_250k_p = NULL) => 0.0199403242, 0.0199403242),
   (c_civ_emp = NULL) => 0.0283361971, 0.0283361971),
(C_INC_50K_P = NULL) => -0.0032125108, 0.0008330614);

// Tree: 251 
woFDN_FL_PS__lgt_251 := map(
(NULL < C_INC_125K_P and C_INC_125K_P <= 2.15) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1099) => -0.0530389414,
   (c_popover25 > 1099) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 22) => 0.1931285632,
      (c_famotf18_p > 22) => -0.0196624132,
      (c_famotf18_p = NULL) => 0.0857569696, 0.0857569696),
   (c_popover25 = NULL) => -0.0298353306, -0.0298353306),
(C_INC_125K_P > 2.15) => 
   map(
   (NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 938) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 34064) => 0.0322767578,
      (f_curraddrmedianincome_d > 34064) => 0.0060764125,
      (f_curraddrmedianincome_d = NULL) => 0.0081265390, 0.0081265390),
   (f_liens_rel_SC_total_amt_i > 938) => -0.1154330576,
   (f_liens_rel_SC_total_amt_i = NULL) => -0.0056038158, 0.0073339584),
(C_INC_125K_P = NULL) => -0.0208219404, 0.0047442791);

// Tree: 252 
woFDN_FL_PS__lgt_252 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 21.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.1) => -0.1327521605,
         (c_pop_35_44_p > 14.1) => 0.0182041096,
         (c_pop_35_44_p = NULL) => -0.0542058086, -0.0542058086),
      (r_D33_Eviction_Recency_d > 79.5) => 0.0141145838,
      (r_D33_Eviction_Recency_d = NULL) => 0.0127401956, 0.0127401956),
   (f_rel_homeover300_count_d > 21.5) => 0.1158035864,
   (f_rel_homeover300_count_d = NULL) => -0.0047731247, 0.0134462737),
(f_phone_ver_insurance_d > 3.5) => -0.0108718218,
(f_phone_ver_insurance_d = NULL) => 
   map(
   (NULL < c_unemp and c_unemp <= 4.05) => -0.0367137333,
   (c_unemp > 4.05) => 0.0713845296,
   (c_unemp = NULL) => 0.0142594313, 0.0142594313), 0.0016375009);

// Tree: 253 
woFDN_FL_PS__lgt_253 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 5.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 30.5) => 0.0007376159,
   (f_rel_homeover50_count_d > 30.5) => -0.0534183322,
   (f_rel_homeover50_count_d = NULL) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 20.9) => 0.0831317689,
      (C_RENTOCC_P > 20.9) => -0.0312931066,
      (C_RENTOCC_P = NULL) => -0.0046826704, -0.0046826704), -0.0004793614),
(r_D34_unrel_liens_ct_i > 5.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 102) => -0.1268637787,
   (c_rich_wht > 102) => -0.0214144141,
   (c_rich_wht = NULL) => -0.0748420921, -0.0748420921),
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 96.5) => -0.0737452999,
   (c_lar_fam > 96.5) => 0.0317367940,
   (c_lar_fam = NULL) => -0.0173669394, -0.0173669394), -0.0015269811);

// Tree: 254 
woFDN_FL_PS__lgt_254 := map(
(NULL < c_hh4_p and c_hh4_p <= 12.85) => 
   map(
   (NULL < c_unemp and c_unemp <= 13.45) => -0.0145039621,
   (c_unemp > 13.45) => -0.0865525583,
   (c_unemp = NULL) => -0.0152313321, -0.0152313321),
(c_hh4_p > 12.85) => 
   map(
   (NULL < c_rental and c_rental <= 190.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 11.85) => -0.0242165225,
      (c_high_ed > 11.85) => 0.0132810736,
      (c_high_ed = NULL) => 0.0076843342, 0.0076843342),
   (c_rental > 190.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.75) => 0.0013828418,
      (c_pop_55_64_p > 8.75) => 0.1957801514,
      (c_pop_55_64_p = NULL) => 0.0985814966, 0.0985814966),
   (c_rental = NULL) => 0.0090171372, 0.0090171372),
(c_hh4_p = NULL) => 0.0362659214, -0.0009033315);

// Tree: 255 
woFDN_FL_PS__lgt_255 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 10.75) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 56.95) => -0.0287103823,
   (c_hval_750k_p > 56.95) => 0.1471517108,
   (c_hval_750k_p = NULL) => -0.0241162132, -0.0241162132),
(c_pop_35_44_p > 10.75) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 9.5) => 0.0168961537,
      (f_addrs_per_ssn_i > 9.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 83.7) => 0.0547278597,
         (C_OWNOCC_P > 83.7) => 0.2291945548,
         (C_OWNOCC_P = NULL) => 0.0959404649, 0.0959404649),
      (f_addrs_per_ssn_i = NULL) => 0.0307808391, 0.0307808391),
   (f_prevaddrlenofres_d > 3.5) => 0.0006579634,
   (f_prevaddrlenofres_d = NULL) => -0.0180763603, 0.0048913580),
(c_pop_35_44_p = NULL) => 0.0121233711, -0.0008940364);

// Tree: 256 
woFDN_FL_PS__lgt_256 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 5.5) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => -0.0287646121,
   (f_rel_incomeover50_count_d > 0.5) => 0.0052107842,
   (f_rel_incomeover50_count_d = NULL) => -0.0442863609, 0.0017535756),
(f_varrisktype_i > 5.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 12.55) => -0.1000742841,
   (c_rnt1000_p > 12.55) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 81.5) => 0.0689566491,
      (c_new_homes > 81.5) => -0.0747529353,
      (c_new_homes = NULL) => -0.0049910011, -0.0049910011),
   (c_rnt1000_p = NULL) => -0.0459661175, -0.0459661175),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 108) => 0.0692893527,
   (c_sub_bus > 108) => -0.0290718784,
   (c_sub_bus = NULL) => 0.0245070036, 0.0245070036), 0.0012985070);

// Tree: 257 
woFDN_FL_PS__lgt_257 := map(
(NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.4532246566) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 391.5) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 11.5) => 
         map(
         (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 31.5) => 0.0941259148,
         (f_mos_liens_unrel_SC_fseen_d > 31.5) => 0.0019497876,
         (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0025516588, 0.0025516588),
      (f_rel_incomeover100_count_d > 11.5) => 0.1440635709,
      (f_rel_incomeover100_count_d = NULL) => 
         map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 7.5) => -0.0573833559,
         (f_sourcerisktype_i > 7.5) => 0.0923264067,
         (f_sourcerisktype_i = NULL) => 0.0054577790, 0.0054577790), 0.0034869794),
   (f_M_Bureau_ADL_FS_all_d > 391.5) => -0.0410746265,
   (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0002851436, -0.0002851436),
(f_add_curr_mobility_index_i > 0.4532246566) => -0.0376002175,
(f_add_curr_mobility_index_i = NULL) => 0.0222796519, -0.0027775860);

// Tree: 258 
woFDN_FL_PS__lgt_258 := map(
(NULL < c_construction and c_construction <= 27.35) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 0.0000898890,
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 50.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 72) => 0.1972715161,
         (c_old_homes > 72) => 0.0187446850,
         (c_old_homes = NULL) => 0.0962447047, 0.0962447047),
      (k_comb_age_d > 50.5) => -0.0465904638,
      (k_comb_age_d = NULL) => 0.0415709560, 0.0415709560),
   (r_P85_Phn_Disconnected_i = NULL) => 0.0008961763, 0.0008961763),
(c_construction > 27.35) => 
   map(
   (NULL < c_med_age and c_med_age <= 28.25) => 0.0849624762,
   (c_med_age > 28.25) => -0.0466957924,
   (c_med_age = NULL) => -0.0379257047, -0.0379257047),
(c_construction = NULL) => 0.0218149123, -0.0023930079);

// Tree: 259 
woFDN_FL_PS__lgt_259 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 15.5) => 
   map(
   (NULL < r_D31_bk_chapter_n and r_D31_bk_chapter_n <= 9) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 2.5) => 0.1055593354,
      (f_corrssnnamecount_d > 2.5) => -0.0459046020,
      (f_corrssnnamecount_d = NULL) => -0.0346565172, -0.0346565172),
   (r_D31_bk_chapter_n > 9) => -0.0487882154,
   (r_D31_bk_chapter_n = NULL) => 
      map(
      (NULL < c_wholesale and c_wholesale <= 32.95) => 
         map(
         (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 7667) => -0.0025070080,
         (f_liens_unrel_CJ_total_amt_i > 7667) => 0.0734536886,
         (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0015938817, -0.0015938817),
      (c_wholesale > 32.95) => -0.0921274908,
      (c_wholesale = NULL) => -0.0433269689, -0.0034724329), -0.0069519793),
(f_rel_homeover500_count_d > 15.5) => 0.1118344944,
(f_rel_homeover500_count_d = NULL) => 0.0062784794, -0.0060656333);

// Tree: 260 
woFDN_FL_PS__lgt_260 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 26.15) => -0.0021288932,
(c_hval_750k_p > 26.15) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 50.45) => -0.0377395621,
   (c_oldhouse > 50.45) => 
      map(
      (NULL < c_professional and c_professional <= 1.75) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 66) => -0.0703229284,
         (f_curraddrcartheftindex_i > 66) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 107.75) => 0.2536426653,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i > 107.75) => 0.0684829061,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0896828999, 0.1144577660),
         (f_curraddrcartheftindex_i = NULL) => 0.0765262451, 0.0765262451),
      (c_professional > 1.75) => 0.0315118407,
      (c_professional = NULL) => 0.0427983471, 0.0427983471),
   (c_oldhouse = NULL) => 0.0218471657, 0.0218471657),
(c_hval_750k_p = NULL) => -0.0246014580, 0.0007812989);

// Tree: 261 
woFDN_FL_PS__lgt_261 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 23.05) => 0.0010049244,
(C_INC_50K_P > 23.05) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 94.65) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0227285990,
      (f_sourcerisktype_i > 4.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','5: Vuln Vic/Friendly']) => 0.0104783224,
         (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','6: Other']) => 
            map(
            (NULL < c_rich_fam and c_rich_fam <= 59) => 0.2530988129,
            (c_rich_fam > 59) => 0.0928595696,
            (c_rich_fam = NULL) => 0.1706456100, 0.1706456100),
         (nf_seg_FraudPoint_3_0 = '') => 0.1104615383, 0.1104615383),
      (f_sourcerisktype_i = NULL) => 0.0612284261, 0.0612284261),
   (c_occunit_p > 94.65) => -0.0598125629,
   (c_occunit_p = NULL) => 0.0318120901, 0.0318120901),
(C_INC_50K_P = NULL) => 0.0203861018, 0.0026885725);

// Tree: 262 
woFDN_FL_PS__lgt_262 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 69.65) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 157.5) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 18.65) => 0.0028741159,
      (C_INC_15K_P > 18.65) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 7.45) => 0.0154263315,
         (C_INC_125K_P > 7.45) => 
            map(
            (NULL < c_famotf18_p and c_famotf18_p <= 23.7) => 0.0704060390,
            (c_famotf18_p > 23.7) => 0.1872431182,
            (c_famotf18_p = NULL) => 0.0986576278, 0.0986576278),
         (C_INC_125K_P = NULL) => 0.0306729053, 0.0306729053),
      (C_INC_15K_P = NULL) => 0.0064178031, 0.0064178031),
   (f_fp_prevaddrburglaryindex_i > 157.5) => -0.0225792118,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0031110931, 0.0023372223),
(c_hval_750k_p > 69.65) => -0.0887064934,
(c_hval_750k_p = NULL) => 0.0050992978, 0.0015806427);

// Tree: 263 
woFDN_FL_PS__lgt_263 := map(
(NULL < c_hh3_p and c_hh3_p <= 7.35) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 0.05) => 0.0103421694,
   (c_hh7p_p > 0.05) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 2.95) => 
         map(
         (NULL < c_young and c_young <= 26.1) => 
            map(
            (NULL < C_RENTOCC_P and C_RENTOCC_P <= 23.5) => 0.2230723656,
            (C_RENTOCC_P > 23.5) => -0.0305989896,
            (C_RENTOCC_P = NULL) => 0.1077672041, 0.1077672041),
         (c_young > 26.1) => 0.1977433849,
         (c_young = NULL) => 0.1381758208, 0.1381758208),
      (c_hh6_p > 2.95) => -0.0077482195,
      (c_hh6_p = NULL) => 0.0844143323, 0.0844143323),
   (c_hh7p_p = NULL) => 0.0289417874, 0.0289417874),
(c_hh3_p > 7.35) => -0.0003997710,
(c_hh3_p = NULL) => 0.0035815964, 0.0028551756);

// Tree: 264 
woFDN_FL_PS__lgt_264 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 91.05) => -0.0549270697,
   (c_occunit_p > 91.05) => 
      map(
      (NULL < c_work_home and c_work_home <= 83) => 0.2347528960,
      (c_work_home > 83) => 0.0558962013,
      (c_work_home = NULL) => 0.1188044181, 0.1188044181),
   (c_occunit_p = NULL) => 0.0541251629, 0.0541251629),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < r_P85_Phn_Invalid_i and r_P85_Phn_Invalid_i <= 0.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 0.0041462364,
      (f_nae_nothing_found_i > 0.5) => 0.0777829170,
      (f_nae_nothing_found_i = NULL) => 0.0050870850, 0.0050870850),
   (r_P85_Phn_Invalid_i > 0.5) => -0.0555156741,
   (r_P85_Phn_Invalid_i = NULL) => 0.0037448367, 0.0037448367),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0042474737, 0.0045862409);

// Tree: 265 
woFDN_FL_PS__lgt_265 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_hval_1001k_p and c_hval_1001k_p <= 65.3) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 20.5) => 0.0013566307,
      (f_rel_homeover300_count_d > 20.5) => -0.0666831195,
      (f_rel_homeover300_count_d = NULL) => 0.0081884356, 0.0007061221),
   (c_hval_1001k_p > 65.3) => 0.1261365030,
   (c_hval_1001k_p = NULL) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => -0.0528097169,
      (f_adl_util_conv_n > 0.5) => 0.1566522503,
      (f_adl_util_conv_n = NULL) => 0.0071397427, 0.0071397427), 0.0017979198),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0745107664,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 1.3) => -0.0382322705,
   (c_high_hval > 1.3) => 0.0499483814,
   (c_high_hval = NULL) => 0.0089521134, 0.0089521134), 0.0021975015);

// Tree: 266 
woFDN_FL_PS__lgt_266 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 42) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.15) => 0.0005616549,
   (c_pop_0_5_p > 20.15) => 0.1124881157,
   (c_pop_0_5_p = NULL) => 0.0010548460, 0.0010548460),
(c_famotf18_p > 42) => 
   map(
   (NULL < c_mort_indx and c_mort_indx <= 118.5) => 
      map(
      (NULL < c_retired and c_retired <= 5.85) => -0.0016632588,
      (c_retired > 5.85) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0251455872,
         (f_addrs_per_ssn_i > 5.5) => -0.1213512801,
         (f_addrs_per_ssn_i = NULL) => -0.0889341445, -0.0889341445),
      (c_retired = NULL) => -0.0588086074, -0.0588086074),
   (c_mort_indx > 118.5) => 0.0518600653,
   (c_mort_indx = NULL) => -0.0390694582, -0.0390694582),
(c_famotf18_p = NULL) => -0.0191776577, -0.0005293677);

// Tree: 267 
woFDN_FL_PS__lgt_267 := map(
(NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 4) => 0.0368158755,
      (c_femdiv_p > 4) => 0.1484962793,
      (c_femdiv_p = NULL) => 0.0931100628, 0.0931100628),
   (r_C10_M_Hdr_FS_d > 15.5) => 0.0061934671,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0124927096, 0.0078652170),
(r_Phn_Cell_n > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 
      map(
      (NULL < c_construction and c_construction <= 10.95) => 0.0058147933,
      (c_construction > 10.95) => 0.1014671722,
      (c_construction = NULL) => 0.0377615603, 0.0377615603),
   (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0195409971,
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0144865978, -0.0144865978),
(r_Phn_Cell_n = NULL) => -0.0026419861, -0.0026419861);

// Tree: 268 
woFDN_FL_PS__lgt_268 := map(
(NULL < c_incollege and c_incollege <= 6.05) => -0.0071478884,
(c_incollege > 6.05) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 30.05) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 68.05) => 0.0113530034,
      (c_low_ed > 68.05) => -0.0640526345,
      (c_low_ed = NULL) => 0.0089289572, 0.0089289572),
   (C_INC_75K_P > 30.05) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 4.8) => -0.1131482086,
         (c_femdiv_p > 4.8) => 0.1417810514,
         (c_femdiv_p = NULL) => 0.0155076796, 0.0155076796),
      (r_D30_Derog_Count_i > 0.5) => 0.1569185616,
      (r_D30_Derog_Count_i = NULL) => 0.0629374164, 0.0629374164),
   (C_INC_75K_P = NULL) => 0.0105095997, 0.0105095997),
(c_incollege = NULL) => -0.0344323849, 0.0000463195);

// Tree: 269 
woFDN_FL_PS__lgt_269 := map(
(NULL < c_retail and c_retail <= 17.65) => -0.0092205228,
(c_retail > 17.65) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 69) => -0.0080047459,
   (f_prevaddrmurderindex_i > 69) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 164.5) => 0.0194757353,
      (c_sub_bus > 164.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 22.8) => 
            map(
            (NULL < c_med_rent and c_med_rent <= 624) => 0.1700897149,
            (c_med_rent > 624) => 0.0210180252,
            (c_med_rent = NULL) => 0.0481668429, 0.0481668429),
         (C_INC_75K_P > 22.8) => 0.2451754248,
         (C_INC_75K_P = NULL) => 0.0799071144, 0.0799071144),
      (c_sub_bus = NULL) => 0.0315687295, 0.0315687295),
   (f_prevaddrmurderindex_i = NULL) => 0.0133359862, 0.0133359862),
(c_retail = NULL) => -0.0044899668, -0.0031363197);

// Tree: 270 
woFDN_FL_PS__lgt_270 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 809865.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 4.5) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 28.05) => 0.0011406179,
      (C_INC_100K_P > 28.05) => -0.1321340235,
      (C_INC_100K_P = NULL) => -0.0131094102, 0.0001962091),
   (r_D33_eviction_count_i > 4.5) => -0.0654895009,
   (r_D33_eviction_count_i = NULL) => -0.0000803623, -0.0000803623),
(f_curraddrmedianvalue_d > 809865.5) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 184.5) => 0.2279926608,
   (c_lux_prod > 184.5) => 0.0051897151,
   (c_lux_prod = NULL) => 0.0707199933, 0.0707199933),
(f_curraddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_trailer and c_trailer <= 116.5) => 0.0287161367,
   (c_trailer > 116.5) => -0.0592892589,
   (c_trailer = NULL) => -0.0064860215, -0.0064860215), 0.0009920958);

// Tree: 271 
woFDN_FL_PS__lgt_271 := map(
(NULL < r_I60_inq_mortgage_count12_i and r_I60_inq_mortgage_count12_i <= 0.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0029778956,
   (f_hh_payday_loan_users_i > 0.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 2.55) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 118) => 0.1189109918,
         (r_pb_order_freq_d > 118) => -0.0523757619,
         (r_pb_order_freq_d = NULL) => 0.1764449811, 0.0975834094),
      (c_femdiv_p > 2.55) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 12.85) => 0.1238237244,
         (c_oldhouse > 12.85) => -0.0079257749,
         (c_oldhouse = NULL) => 0.0064121392, 0.0064121392),
      (c_femdiv_p = NULL) => 0.0265196578, 0.0265196578),
   (f_hh_payday_loan_users_i = NULL) => -0.0003544795, -0.0003544795),
(r_I60_inq_mortgage_count12_i > 0.5) => -0.0679461685,
(r_I60_inq_mortgage_count12_i = NULL) => -0.0233960421, -0.0031745641);

// Tree: 272 
woFDN_FL_PS__lgt_272 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 55.15) => -0.0009524480,
(c_rnt1000_p > 55.15) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 74.7) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.25) => -0.0153934725,
      (c_hval_125k_p > 4.25) => 
         map(
         (NULL < c_professional and c_professional <= 5.05) => 0.0141373210,
         (c_professional > 5.05) => 
            map(
            (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 6.5) => 0.0617166416,
            (f_rel_homeover100_count_d > 6.5) => 0.2508655895,
            (f_rel_homeover100_count_d = NULL) => 0.1527883573, 0.1527883573),
         (c_professional = NULL) => 0.0762131118, 0.0762131118),
      (c_hval_125k_p = NULL) => 0.0222834291, 0.0222834291),
   (c_civ_emp > 74.7) => 0.2987185446,
   (c_civ_emp = NULL) => 0.0396911820, 0.0396911820),
(c_rnt1000_p = NULL) => 0.0085689627, 0.0018295251);

// Tree: 273 
woFDN_FL_PS__lgt_273 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 10.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 1.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => -0.0004294386,
      (r_C14_addrs_10yr_i > 10.5) => 0.1196713762,
      (r_C14_addrs_10yr_i = NULL) => 0.0000555820, 0.0000555820),
   (r_I60_inq_hiRiskCred_count12_i > 1.5) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 98) => -0.1175537147,
      (c_blue_empl > 98) => 0.0144358189,
      (c_blue_empl = NULL) => -0.0537960586, -0.0537960586),
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0004528181, -0.0004528181),
(f_inq_HighRiskCredit_count24_i > 10.5) => 0.0760370210,
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0459034606,
   (r_Phn_Cell_n > 0.5) => -0.0569334012,
   (r_Phn_Cell_n = NULL) => 0.0028554719, 0.0028554719), -0.0000754677);

// Tree: 274 
woFDN_FL_PS__lgt_274 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 12.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 20.5) => 0.0033084992,
   (f_rel_educationover8_count_d > 20.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 114.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 75.75) => 0.1697191207,
         (c_fammar_p > 75.75) => 0.0429091710,
         (c_fammar_p = NULL) => 0.1141007217, 0.1141007217),
      (c_bargains > 114.5) => -0.0087857376,
      (c_bargains = NULL) => 0.0417884731, 0.0417884731),
   (f_rel_educationover8_count_d = NULL) => 0.0042792844, 0.0042792844),
(f_rel_incomeover50_count_d > 12.5) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 1877) => -0.0305364498,
   (c_med_rent > 1877) => 0.1207522399,
   (c_med_rent = NULL) => -0.0246267353, -0.0246267353),
(f_rel_incomeover50_count_d = NULL) => -0.0079041482, 0.0010209295);

// Tree: 275 
woFDN_FL_PS__lgt_275 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 76.5) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 0.95) => 0.1417472970,
   (c_pop_65_74_p > 0.95) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 0.1041905271,
      (r_D32_Mos_Since_Crim_LS_d > 14.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 22.75) => -0.0049931275,
         (c_hval_250k_p > 22.75) => 
            map(
            (NULL < c_construction and c_construction <= 4.85) => 0.1508958024,
            (c_construction > 4.85) => 0.0025805544,
            (c_construction = NULL) => 0.0595877181, 0.0595877181),
         (c_hval_250k_p = NULL) => 0.0036608749, 0.0036608749),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0078250739, 0.0078250739),
   (c_pop_65_74_p = NULL) => 0.0658494183, 0.0133570705),
(f_mos_inq_banko_cm_fseen_d > 76.5) => -0.0091745038,
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0001347373, -0.0045606239);

// Tree: 276 
woFDN_FL_PS__lgt_276 := map(
(NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 2.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 12.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1294068394) => -0.0033110540,
      (f_add_curr_nhood_BUS_pct_i > 0.1294068394) => 
         map(
         (NULL < c_highinc and c_highinc <= 3.75) => 0.0836855088,
         (c_highinc > 3.75) => 0.0069386814,
         (c_highinc = NULL) => 0.0208736003, 0.0208736003),
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0096545511, -0.0007969691),
   (k_inq_per_ssn_i > 12.5) => 0.0683308853,
   (k_inq_per_ssn_i = NULL) => -0.0002554832, -0.0002554832),
(f_srchphonesrchcountmo_i > 2.5) => -0.0890984318,
(f_srchphonesrchcountmo_i = NULL) => 
   map(
   (NULL < c_med_age and c_med_age <= 37.25) => -0.0447106387,
   (c_med_age > 37.25) => 0.0533880109,
   (c_med_age = NULL) => 0.0101580975, 0.0101580975), -0.0005273502);

// Tree: 277 
woFDN_FL_PS__lgt_277 := map(
(NULL < c_unempl and c_unempl <= 31.5) => -0.0502870056,
(c_unempl > 31.5) => 
   map(
   (NULL < c_employees and c_employees <= 29.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 166.5) => 0.1725987439,
      (c_med_rent > 166.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 92.5) => -0.0137247594,
         (f_curraddrcrimeindex_i > 92.5) => 
            map(
            (NULL < C_INC_125K_P and C_INC_125K_P <= 2.15) => -0.0523135808,
            (C_INC_125K_P > 2.15) => 0.0641155490,
            (C_INC_125K_P = NULL) => 0.0409090615, 0.0409090615),
         (f_curraddrcrimeindex_i = NULL) => 0.0149861205, 0.0149861205),
      (c_med_rent = NULL) => 0.0233163179, 0.0233163179),
   (c_employees > 29.5) => -0.0030392018,
   (c_employees = NULL) => -0.0002969026, -0.0002969026),
(c_unempl = NULL) => 0.0016471817, -0.0038424051);

// Tree: 278 
woFDN_FL_PS__lgt_278 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 24.65) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 0.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 187.5) => 0.0008885450,
         (c_sub_bus > 187.5) => 
            map(
            (NULL < C_OWNOCC_P and C_OWNOCC_P <= 41.9) => 0.0214915844,
            (C_OWNOCC_P > 41.9) => 0.2157803326,
            (C_OWNOCC_P = NULL) => 0.0945647862, 0.0945647862),
         (c_sub_bus = NULL) => 0.0070625988, 0.0070625988),
      (r_Phn_Cell_n > 0.5) => -0.0263881337,
      (r_Phn_Cell_n = NULL) => -0.0099409640, -0.0099409640),
   (f_srchphonesrchcount_i > 0.5) => 0.0145463863,
   (f_srchphonesrchcount_i = NULL) => 0.0100246764, 0.0001252783),
(c_hval_80k_p > 24.65) => -0.0426926413,
(c_hval_80k_p = NULL) => 0.0209003059, -0.0010863706);

// Tree: 279 
woFDN_FL_PS__lgt_279 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 2.65) => 0.0100962273,
      (c_hh6_p > 2.65) => -0.0129630668,
      (c_hh6_p = NULL) => -0.0057043949, 0.0024518791),
   (f_inq_Auto_count24_i > 1.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 156.5) => -0.0642139873,
      (c_born_usa > 156.5) => 0.0482650647,
      (c_born_usa = NULL) => -0.0496459173, -0.0496459173),
   (f_inq_Auto_count24_i = NULL) => -0.0003357954, -0.0003357954),
(r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.0724782476,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 16.65) => -0.0735211880,
   (c_hh3_p > 16.65) => 0.0430956197,
   (c_hh3_p = NULL) => -0.0199150748, -0.0199150748), -0.0009443869);

// Tree: 280 
woFDN_FL_PS__lgt_280 := map(
(NULL < c_cpiall and c_cpiall <= 208.9) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 15.35) => 0.1495161207,
      (c_fammar18_p > 15.35) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2949111321) => 
            map(
            (NULL < c_bargains and c_bargains <= 116) => 0.0620645606,
            (c_bargains > 116) => 0.2703090437,
            (c_bargains = NULL) => 0.1066883784, 0.1066883784),
         (f_add_curr_mobility_index_i > 0.2949111321) => -0.0260335738,
         (f_add_curr_mobility_index_i = NULL) => 0.0457388124, 0.0457388124),
      (c_fammar18_p = NULL) => 0.0561566116, 0.0561566116),
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0018144127,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0175578462, 0.0175578462),
(c_cpiall > 208.9) => -0.0083835796,
(c_cpiall = NULL) => 0.0052381686, -0.0043627008);

// Tree: 281 
woFDN_FL_PS__lgt_281 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => -0.0007712207,
(r_S66_adlperssn_count_i > 3.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 171.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 8.5) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 0.1344985872,
         (r_I60_inq_recency_d > 4.5) => 
            map(
            (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => 0.0756677478,
            (f_rel_incomeover50_count_d > 8.5) => -0.0721529591,
            (f_rel_incomeover50_count_d = NULL) => 0.0281539491, 0.0281539491),
         (r_I60_inq_recency_d = NULL) => 0.0435950910, 0.0435950910),
      (f_assocsuspicousidcount_i > 8.5) => 0.1568927776,
      (f_assocsuspicousidcount_i = NULL) => 0.0563145818, 0.0563145818),
   (c_span_lang > 171.5) => -0.0554021044,
   (c_span_lang = NULL) => 0.0364046773, 0.0364046773),
(r_S66_adlperssn_count_i = NULL) => 0.0011073564, 0.0011073564);

// Tree: 282 
woFDN_FL_PS__lgt_282 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0043947882,
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 2.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 16.85) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2492474537) => 
            map(
            (NULL < c_rnt2001_p and c_rnt2001_p <= 0.5) => 0.0418308291,
            (c_rnt2001_p > 0.5) => 0.2192964702,
            (c_rnt2001_p = NULL) => 0.0661516022, 0.0661516022),
         (f_add_curr_mobility_index_i > 0.2492474537) => -0.0071978717,
         (f_add_curr_mobility_index_i = NULL) => 0.0279707159, 0.0279707159),
      (c_vacant_p > 16.85) => -0.0862024844,
      (c_vacant_p = NULL) => 0.0180193498, 0.0180193498),
   (f_idrisktype_i > 2.5) => 0.1645718180,
   (f_idrisktype_i = NULL) => 0.0263754116, 0.0263754116),
(f_hh_payday_loan_users_i = NULL) => 0.0047909389, -0.0015447481);

// Tree: 283 
woFDN_FL_PS__lgt_283 := map(
(NULL < c_many_cars and c_many_cars <= 91.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.95) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => -0.0600743676,
      (r_D33_Eviction_Recency_d > 549) => 
         map(
         (NULL < c_trailer_p and c_trailer_p <= 2.45) => 
            map(
            (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0195396210,
            (f_inq_HighRiskCredit_count_i > 2.5) => 0.0688498373,
            (f_inq_HighRiskCredit_count_i = NULL) => -0.0167540642, -0.0167540642),
         (c_trailer_p > 2.45) => -0.0750218015,
         (c_trailer_p = NULL) => -0.0280630413, -0.0280630413),
      (r_D33_Eviction_Recency_d = NULL) => -0.0300010489, -0.0300010489),
   (c_pop_35_44_p > 14.95) => 0.0035434610,
   (c_pop_35_44_p = NULL) => -0.0143519924, -0.0143519924),
(c_many_cars > 91.5) => 0.0111552749,
(c_many_cars = NULL) => -0.0013448367, 0.0001563259);

// Tree: 284 
woFDN_FL_PS__lgt_284 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.05) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 3.5) => -0.0005434153,
   (f_hh_collections_ct_i > 3.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 110.5) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 111.5) => 
            map(
            (NULL < c_hval_750k_p and c_hval_750k_p <= 1.85) => 0.1974645569,
            (c_hval_750k_p > 1.85) => -0.0292783474,
            (c_hval_750k_p = NULL) => 0.0712772015, 0.0712772015),
         (c_span_lang > 111.5) => -0.0463982138,
         (c_span_lang = NULL) => 0.0021059896, 0.0021059896),
      (c_unattach > 110.5) => -0.0803095017,
      (c_unattach = NULL) => -0.0279315471, -0.0279315471),
   (f_hh_collections_ct_i = NULL) => 0.0169012875, -0.0013572218),
(c_pop_0_5_p > 20.05) => 0.1024396083,
(c_pop_0_5_p = NULL) => -0.0218742389, -0.0014058205);

// Tree: 285 
woFDN_FL_PS__lgt_285 := map(
(NULL < c_mining and c_mining <= 2.45) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0749916581,
   (f_attr_arrest_recency_d > 79.5) => -0.0003609353,
   (f_attr_arrest_recency_d = NULL) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1978) => 0.0518338260,
      (c_med_yearblt > 1978) => -0.0481196482,
      (c_med_yearblt = NULL) => 0.0082643629, 0.0082643629), 0.0001446402),
(c_mining > 2.45) => -0.0970548385,
(c_mining = NULL) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 2.5) => -0.0319689512,
   (f_corrssnnamecount_d > 2.5) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 1.5) => 0.2038284572,
      (f_rel_homeover150_count_d > 1.5) => -0.0476477342,
      (f_rel_homeover150_count_d = NULL) => 0.0914262201, 0.0914262201),
   (f_corrssnnamecount_d = NULL) => 0.0253066232, 0.0253066232), -0.0012451523);

// Tree: 286 
woFDN_FL_PS__lgt_286 := map(
(NULL < c_work_home and c_work_home <= 194.5) => 
   map(
   (NULL < f_liens_unrel_FT_total_amt_i and f_liens_unrel_FT_total_amt_i <= 31704) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1964.5) => 0.0002506131,
      (f_liens_unrel_SC_total_amt_i > 1964.5) => 0.0548499676,
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0010823769, 0.0010823769),
   (f_liens_unrel_FT_total_amt_i > 31704) => -0.1002805788,
   (f_liens_unrel_FT_total_amt_i = NULL) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 59) => -0.0584468014,
      (c_cartheft > 59) => 0.0718153645,
      (c_cartheft = NULL) => 0.0151796402, 0.0151796402), 0.0006977417),
(c_work_home > 194.5) => -0.0743275485,
(c_work_home = NULL) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2141259506) => 0.0926101883,
   (f_add_curr_mobility_index_i > 0.2141259506) => -0.1097556946,
   (f_add_curr_mobility_index_i = NULL) => 0.0590910554, 0.0232257435), -0.0004285098);

// Tree: 287 
woFDN_FL_PS__lgt_287 := map(
(NULL < c_hh1_p and c_hh1_p <= 47.15) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 62.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 45.6) => -0.0310124065,
      (c_famotf18_p > 45.6) => 0.0463140831,
      (c_famotf18_p = NULL) => -0.0268430516, -0.0268430516),
   (c_rest_indx > 62.5) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 0.0031152214,
      (f_addrs_per_ssn_c6_i > 1.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 56557.5) => 0.1542674556,
         (f_curraddrmedianincome_d > 56557.5) => 0.0501863184,
         (f_curraddrmedianincome_d = NULL) => 0.0988223639, 0.0988223639),
      (f_addrs_per_ssn_c6_i = NULL) => 0.0042306658, 0.0042306658),
   (c_rest_indx = NULL) => -0.0007063312, -0.0007063312),
(c_hh1_p > 47.15) => -0.0372115929,
(c_hh1_p = NULL) => 0.0158599914, -0.0033373221);

// Tree: 288 
woFDN_FL_PS__lgt_288 := map(
(NULL < c_fammar_p and c_fammar_p <= 19.6) => -0.0635421806,
(c_fammar_p > 19.6) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 48.65) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 82.5) => 
            map(
            (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 94.5) => -0.0650312872,
            (f_fp_prevaddrburglaryindex_i > 94.5) => 0.0939036760,
            (f_fp_prevaddrburglaryindex_i = NULL) => -0.0150927059, -0.0150927059),
         (f_prevaddrageoldest_d > 82.5) => 0.1000978158,
         (f_prevaddrageoldest_d = NULL) => 0.0371728443, 0.0371728443),
      (f_corrssnnamecount_d > 1.5) => -0.0032622271,
      (f_corrssnnamecount_d = NULL) => 0.0049626867, -0.0009556715),
   (c_hval_100k_p > 48.65) => 0.1098595899,
   (c_hval_100k_p = NULL) => -0.0003688219, -0.0003688219),
(c_fammar_p = NULL) => -0.0017127275, -0.0009144096);

// Tree: 289 
woFDN_FL_PS__lgt_289 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 38.45) => 0.0050942697,
   (c_famotf18_p > 38.45) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 21.5) => -0.0992549547,
      (c_born_usa > 21.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 82.5) => 0.0789630745,
         (c_burglary > 82.5) => -0.0284475511,
         (c_burglary = NULL) => -0.0126343201, -0.0126343201),
      (c_born_usa = NULL) => -0.0278969948, -0.0278969948),
   (c_famotf18_p = NULL) => 0.0102936493, 0.0040659408),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0963055213,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 2.4) => -0.0341528575,
   (c_hh6_p > 2.4) => 0.0533846095,
   (c_hh6_p = NULL) => -0.0013263074, -0.0013263074), 0.0035554096);

// Tree: 290 
woFDN_FL_PS__lgt_290 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 11.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 3.5) => 0.1363725908,
   (r_C13_Curr_Addr_LRes_d > 3.5) => -0.0061104510,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0457015642, 0.0457015642),
(r_C13_max_lres_d > 11.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 8.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 19.25) => -0.0019963467,
      (c_pop_45_54_p > 19.25) => 0.0270691736,
      (c_pop_45_54_p = NULL) => -0.0165405903, 0.0027277997),
   (k_inq_per_phone_i > 8.5) => 0.0592050944,
   (k_inq_per_phone_i = NULL) => 0.0031384109, 0.0031384109),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 7.65) => 0.0469957674,
   (c_professional > 7.65) => -0.0539243659,
   (c_professional = NULL) => 0.0020605255, 0.0020605255), 0.0036835098);

// Tree: 291 
woFDN_FL_PS__lgt_291 := map(
(NULL < c_asian_lang and c_asian_lang <= 198.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 10.5) => 0.0017236031,
      (f_srchfraudsrchcount_i > 10.5) => 0.0331608119,
      (f_srchfraudsrchcount_i = NULL) => 0.0006889519, 0.0023492562),
   (k_inq_adls_per_phone_i > 2.5) => -0.0621554082,
   (k_inq_adls_per_phone_i = NULL) => 0.0018896030, 0.0018896030),
(c_asian_lang > 198.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.07118920955) => -0.1112331504,
   (f_add_curr_nhood_BUS_pct_i > 0.07118920955) => -0.0338373341,
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0845293307, -0.0845293307),
(c_asian_lang = NULL) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => -0.0136855443,
   (f_rel_incomeover75_count_d > 0.5) => 0.1528058866,
   (f_rel_incomeover75_count_d = NULL) => 0.0304027789, 0.0304027789), 0.0013467852);

// Tree: 292 
woFDN_FL_PS__lgt_292 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 12.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 98.35) => -0.0202630778,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 98.35) => 0.0135441172,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 0.5) => 
         map(
         (NULL < c_health and c_health <= 66.35) => -0.0091798274,
         (c_health > 66.35) => 0.1301633851,
         (c_health = NULL) => -0.0026382254, -0.0076074695),
      (f_addrs_per_ssn_c6_i > 0.5) => 0.0344872247,
      (f_addrs_per_ssn_c6_i = NULL) => -0.0023751086, -0.0023751086), 0.0001216228),
(f_inq_count24_i > 12.5) => -0.0661776162,
(f_inq_count24_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 3.25) => 0.0593454856,
   (c_hval_125k_p > 3.25) => -0.0277542881,
   (c_hval_125k_p = NULL) => 0.0167092327, 0.0167092327), -0.0004074207);

// Tree: 293 
woFDN_FL_PS__lgt_293 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 194.5) => -0.0027237814,
   (c_relig_indx > 194.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 152.5) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => -0.0318696309,
         (f_rel_incomeover50_count_d > 8.5) => 0.1101676067,
         (f_rel_incomeover50_count_d = NULL) => 0.0004754826, 0.0004754826),
      (c_easiqlife > 152.5) => 0.2143807897,
      (c_easiqlife = NULL) => 0.0517290770, 0.0517290770),
   (c_relig_indx = NULL) => -0.0113758719, -0.0011662906),
(r_D34_unrel_liens_ct_i > 7.5) => 0.0971196277,
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 11.6) => 0.0335690146,
   (C_INC_50K_P > 11.6) => -0.0630715815,
   (C_INC_50K_P = NULL) => -0.0104369711, -0.0104369711), -0.0006614738);

// Tree: 294 
woFDN_FL_PS__lgt_294 := map(
(NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 108.5) => -0.0574262904,
(f_mos_liens_rel_CJ_lseen_d > 108.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 156.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 587.5) => 
         map(
         (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 2.5) => -0.0202039701,
         (r_C20_email_domain_free_count_i > 2.5) => 0.0661208473,
         (r_C20_email_domain_free_count_i = NULL) => -0.0147430328, -0.0147430328),
      (f_liens_unrel_SC_total_amt_i > 587.5) => 0.1128765075,
      (f_liens_unrel_SC_total_amt_i = NULL) => -0.0132367038, -0.0132367038),
   (r_C21_M_Bureau_ADL_FS_d > 156.5) => 0.0099005346,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0013502224, 0.0013502224),
(f_mos_liens_rel_CJ_lseen_d = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 11.7) => -0.0595666186,
   (c_pop_25_34_p > 11.7) => 0.0354500555,
   (c_pop_25_34_p = NULL) => -0.0065927206, -0.0065927206), 0.0004018469);

// Tree: 295 
woFDN_FL_PS__lgt_295 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => 0.0019750129,
(r_D32_criminal_count_i > 5.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
      map(
      (NULL < c_families and c_families <= 389) => 0.1621957899,
      (c_families > 389) => 0.0218138029,
      (c_families = NULL) => 0.0869184925, 0.0869184925),
   (r_E57_br_source_count_d > 0.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1977.5) => -0.0827825918,
      (c_med_yearblt > 1977.5) => 0.0497215228,
      (c_med_yearblt = NULL) => -0.0102438429, -0.0102438429),
   (r_E57_br_source_count_d = NULL) => 0.0385127081, 0.0385127081),
(r_D32_criminal_count_i = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 11.35) => -0.0601317788,
   (c_rnt1000_p > 11.35) => 0.0353043173,
   (c_rnt1000_p = NULL) => -0.0166811984, -0.0166811984), 0.0025860971);

// Tree: 296 
woFDN_FL_PS__lgt_296 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 10.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 184.5) => 0.0041332825,
   (c_span_lang > 184.5) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 48.5) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 2.5) => 0.1172203990,
         (f_rel_educationover12_count_d > 2.5) => -0.0129047233,
         (f_rel_educationover12_count_d = NULL) => 0.0292259515, 0.0292259515),
      (c_retired2 > 48.5) => 
         map(
         (NULL < c_rich_fam and c_rich_fam <= 141.5) => -0.0797751134,
         (c_rich_fam > 141.5) => 0.0255735404,
         (c_rich_fam = NULL) => -0.0575183556, -0.0575183556),
      (c_retired2 = NULL) => -0.0331947830, -0.0331947830),
   (c_span_lang = NULL) => -0.0172029498, 0.0009209872),
(f_inq_count24_i > 10.5) => -0.0633194490,
(f_inq_count24_i = NULL) => -0.0126502911, -0.0002397261);

// Tree: 297 
woFDN_FL_PS__lgt_297 := map(
(NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.0754225196) => -0.0290569546,
   (f_add_curr_nhood_SFD_pct_d > 0.0754225196) => 
      map(
      (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0034814211,
      (f_srchunvrfddobcount_i > 0.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0008106381) => 0.1922412737,
         (f_add_curr_nhood_VAC_pct_i > 0.0008106381) => 0.0214935134,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0499514735, 0.0499514735),
      (f_srchunvrfddobcount_i = NULL) => 0.0048570147, 0.0048570147),
   (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0020090215, 0.0020090215),
(r_I60_inq_auto_count12_i > 1.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.18454060485) => 0.0166783220,
   (f_add_curr_mobility_index_i > 0.18454060485) => -0.0642080991,
   (f_add_curr_mobility_index_i = NULL) => -0.0530149390, -0.0530149390),
(r_I60_inq_auto_count12_i = NULL) => -0.0040767846, 0.0002809683);

// Tree: 298 
woFDN_FL_PS__lgt_298 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 0.35) => 
      map(
      (NULL < c_no_move and c_no_move <= 138.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 37.5) => 0.0681494428,
         (f_mos_inq_banko_cm_fseen_d > 37.5) => 0.2238878540,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.1390547357, 0.1390547357),
      (c_no_move > 138.5) => -0.0117088135,
      (c_no_move = NULL) => 0.0853797548, 0.0853797548),
   (c_hh5_p > 0.35) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0400108320,
      (r_E57_br_source_count_d > 0.5) => -0.0160677643,
      (r_E57_br_source_count_d = NULL) => 0.0096515919, 0.0096515919),
   (c_hh5_p = NULL) => 0.1315804859, 0.0235464420),
(f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0054028563,
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0027807363, -0.0015208158);

// Tree: 299 
woFDN_FL_PS__lgt_299 := map(
(NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 14.35) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 62005.5) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 126737.5) => 0.0047736246,
         (f_prevaddrmedianvalue_d > 126737.5) => 0.1432267668,
         (f_prevaddrmedianvalue_d = NULL) => 0.0733280931, 0.0733280931),
      (f_prevaddrmedianincome_d > 62005.5) => -0.0847845494,
      (f_prevaddrmedianincome_d = NULL) => 0.0098991842, 0.0098991842),
   (C_INC_75K_P > 14.35) => -0.0673430824,
   (C_INC_75K_P = NULL) => -0.0457051836, -0.0457051836),
(f_mos_inq_banko_om_lseen_d > 5.5) => -0.0007487357,
(f_mos_inq_banko_om_lseen_d = NULL) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 6.75) => -0.0365935529,
   (c_pop_65_74_p > 6.75) => 0.0554713994,
   (c_pop_65_74_p = NULL) => 0.0038252067, 0.0038252067), -0.0029328794);

// Tree: 300 
woFDN_FL_PS__lgt_300 := map(
(NULL < f_inq_Retail_count_i and f_inq_Retail_count_i <= 1.5) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 17.35) => 
      map(
      (NULL < c_manufacturing and c_manufacturing <= 15.55) => 0.0113330001,
      (c_manufacturing > 15.55) => 0.1276892524,
      (c_manufacturing = NULL) => 0.0123173442, 0.0123173442),
   (c_manufacturing > 17.35) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 25.15) => -0.0491425550,
      (c_hval_125k_p > 25.15) => 0.1386529974,
      (c_hval_125k_p = NULL) => -0.0372004438, -0.0372004438),
   (c_manufacturing = NULL) => 0.0084021369, 0.0087266815),
(f_inq_Retail_count_i > 1.5) => -0.0300311682,
(f_inq_Retail_count_i = NULL) => 
   map(
   (NULL < c_retired2 and c_retired2 <= 88) => -0.0696721345,
   (c_retired2 > 88) => 0.0736204494,
   (c_retired2 = NULL) => 0.0122093420, 0.0122093420), 0.0051311756);

// Tree: 301 
woFDN_FL_PS__lgt_301 := map(
(NULL < c_rest_indx and c_rest_indx <= 161.5) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 69.65) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 10.25) => 0.0119428289,
      (c_famotf18_p > 10.25) => -0.0094373360,
      (c_famotf18_p = NULL) => 0.0023510028, 0.0023510028),
   (c_lowinc > 69.65) => 
      map(
      (NULL < c_med_age and c_med_age <= 26.45) => -0.0292188382,
      (c_med_age > 26.45) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 13.95) => 0.0251829361,
         (c_newhouse > 13.95) => 0.1503336657,
         (c_newhouse = NULL) => 0.0758164374, 0.0758164374),
      (c_med_age = NULL) => 0.0375754390, 0.0375754390),
   (c_lowinc = NULL) => 0.0029963455, 0.0029963455),
(c_rest_indx > 161.5) => -0.0424306565,
(c_rest_indx = NULL) => -0.0011612612, -0.0010774686);

// Tree: 302 
woFDN_FL_PS__lgt_302 := map(
(NULL < c_retail and c_retail <= 48.55) => 
   map(
   (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0046984967,
   (r_F04_curr_add_occ_index_d > 2) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 2.5) => 0.0349610480,
      (f_rel_under25miles_cnt_d > 2.5) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 
            map(
            (NULL < c_hval_400k_p and c_hval_400k_p <= 1.65) => 0.1638004494,
            (c_hval_400k_p > 1.65) => -0.0091303793,
            (c_hval_400k_p = NULL) => 0.0565833356, 0.0565833356),
         (r_I60_inq_recency_d > 4.5) => -0.0337882763,
         (r_I60_inq_recency_d = NULL) => -0.0177838586, -0.0177838586),
      (f_rel_under25miles_cnt_d = NULL) => 0.0178769425, 0.0178769425),
   (r_F04_curr_add_occ_index_d = NULL) => -0.0197656926, 0.0000299014),
(c_retail > 48.55) => -0.0842317573,
(c_retail = NULL) => -0.0200889767, -0.0016043010);

// Tree: 303 
woFDN_FL_PS__lgt_303 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201) => -0.0597703790,
(r_D32_Mos_Since_Fel_LS_d > 201) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 14.95) => -0.0027444097,
      (c_pop_6_11_p > 14.95) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 209186) => 0.1278578829,
         (f_curraddrmedianvalue_d > 209186) => -0.0204097201,
         (f_curraddrmedianvalue_d = NULL) => 0.0537240814, 0.0537240814),
      (c_pop_6_11_p = NULL) => 0.0000699625, -0.0021096283),
   (r_D32_felony_count_i > 0.5) => 0.0813223600,
   (r_D32_felony_count_i = NULL) => -0.0017482770, -0.0017482770),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 7.8) => -0.0815394872,
   (c_rnt750_p > 7.8) => 0.0124914590,
   (c_rnt750_p = NULL) => -0.0254242451, -0.0254242451), -0.0024023984);

// Tree: 304 
woFDN_FL_PS__lgt_304 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 0.5) => -0.0724889463,
(f_vardobcount_i > 0.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0006262383,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_health and c_health <= 23.35) => 
         map(
         (NULL < c_med_age and c_med_age <= 29.05) => 0.1116884102,
         (c_med_age > 29.05) => -0.0038776498,
         (c_med_age = NULL) => 0.0067877388, 0.0067877388),
      (c_health > 23.35) => 
         map(
         (NULL < c_preschl and c_preschl <= 112) => -0.0138337113,
         (c_preschl > 112) => 0.2196531616,
         (c_preschl = NULL) => 0.0990820715, 0.0990820715),
      (c_health = NULL) => 0.0191206069, 0.0191206069),
   (k_nap_contradictory_i = NULL) => 0.0008682895, 0.0008682895),
(f_vardobcount_i = NULL) => -0.0008192816, 0.0000024915);

// Tree: 305 
woFDN_FL_PS__lgt_305 := map(
(NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 7.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 390.5) => 
         map(
         (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 1.5) => 
            map(
            (NULL < c_construction and c_construction <= 9.4) => 0.0141931012,
            (c_construction > 9.4) => 0.2012462784,
            (c_construction = NULL) => 0.0527373923, 0.0527373923),
         (f_hh_tot_derog_i > 1.5) => 0.1868518717,
         (f_hh_tot_derog_i = NULL) => 0.0773029157, 0.0773029157),
      (f_M_Bureau_ADL_FS_all_d > 390.5) => -0.0951960013,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0530796636, 0.0530796636),
   (c_serv_empl > 7.5) => -0.0008299498,
   (c_serv_empl = NULL) => -0.0168720842, 0.0008023408),
(f_assoccredbureaucountmo_i > 0.5) => 0.1037334414,
(f_assoccredbureaucountmo_i = NULL) => 0.0011951265, 0.0013746525);

// Tree: 306 
woFDN_FL_PS__lgt_306 := map(
(NULL < r_A41_Prop_Owner_Inp_Only_d and r_A41_Prop_Owner_Inp_Only_d <= 0.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 66.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 29.1) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 14.2) => 0.0208015381,
         (c_hval_200k_p > 14.2) => 
            map(
            (NULL < C_INC_200K_P and C_INC_200K_P <= 3.35) => 0.0430772804,
            (C_INC_200K_P > 3.35) => 0.2838193445,
            (C_INC_200K_P = NULL) => 0.1151557427, 0.1151557427),
         (c_hval_200k_p = NULL) => 0.0325343394, 0.0325343394),
      (c_hval_80k_p > 29.1) => 0.1410895450,
      (c_hval_80k_p = NULL) => 0.0387091791, 0.0387091791),
   (c_work_home > 66.5) => 0.0011230676,
   (c_work_home = NULL) => 0.0005815184, 0.0115398778),
(r_A41_Prop_Owner_Inp_Only_d > 0.5) => -0.0071766865,
(r_A41_Prop_Owner_Inp_Only_d = NULL) => -0.0022673405, 0.0004355017);

// Tree: 307 
woFDN_FL_PS__lgt_307 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 3.65) => 
   map(
   (NULL < c_bargains and c_bargains <= 131.5) => -0.0049795794,
   (c_bargains > 131.5) => 
      map(
      (NULL < c_health and c_health <= 3.3) => 0.1602086690,
      (c_health > 3.3) => 0.0383302785,
      (c_health = NULL) => 0.0887627160, 0.0887627160),
   (c_bargains = NULL) => 0.0432212462, 0.0432212462),
(C_INC_100K_P > 3.65) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 112.5) => -0.0129686660,
   (f_prevaddrageoldest_d > 112.5) => 
      map(
      (NULL < c_rental and c_rental <= 130.5) => 0.0264055231,
      (c_rental > 130.5) => -0.0206781066,
      (c_rental = NULL) => 0.0118071757, 0.0118071757),
   (f_prevaddrageoldest_d = NULL) => -0.0164468517, -0.0026458299),
(C_INC_100K_P = NULL) => 0.0013526970, -0.0015271817);

// Tree: 308 
woFDN_FL_PS__lgt_308 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 13.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 6.5) => -0.0089124777,
   (f_addrs_per_ssn_i > 6.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 0.0107531417,
         (f_inq_QuizProvider_count_i > 5.5) => 0.1112671742,
         (f_inq_QuizProvider_count_i = NULL) => 0.0121087188, 0.0121087188),
      (f_nae_nothing_found_i > 0.5) => 0.1261972697,
      (f_nae_nothing_found_i = NULL) => 0.0132399512, 0.0132399512),
   (f_addrs_per_ssn_i = NULL) => 0.0045711444, 0.0045711444),
(f_hh_members_ct_d > 13.5) => -0.0648738469,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 11.9) => -0.0685530169,
   (c_pop_25_34_p > 11.9) => 0.0457864947,
   (c_pop_25_34_p = NULL) => -0.0041841067, -0.0041841067), 0.0038189471);

// Tree: 309 
woFDN_FL_PS__lgt_309 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 27.55) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 27.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 8.25) => -0.0303237911,
      (c_pop_45_54_p > 8.25) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 20.85) => 0.0006906110,
         (c_pop_18_24_p > 20.85) => 
            map(
            (NULL < c_rnt250_p and c_rnt250_p <= 3.25) => 0.0310011153,
            (c_rnt250_p > 3.25) => 0.2107548872,
            (c_rnt250_p = NULL) => 0.0829127650, 0.0829127650),
         (c_pop_18_24_p = NULL) => 0.0024211326, 0.0024211326),
      (c_pop_45_54_p = NULL) => -0.0005451182, -0.0005451182),
   (f_addrs_per_ssn_i > 27.5) => -0.0714973004,
   (f_addrs_per_ssn_i = NULL) => -0.0011256941, -0.0011256941),
(c_pop_45_54_p > 27.55) => -0.1083592385,
(c_pop_45_54_p = NULL) => -0.0266280136, -0.0030443345);

// Tree: 310 
woFDN_FL_PS__lgt_310 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 3.5) => -0.0007348854,
(f_srchphonesrchcount_i > 3.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 5.25) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 0.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 11.2) => -0.0396555542,
         (C_RENTOCC_P > 11.2) => 0.1042703315,
         (C_RENTOCC_P = NULL) => 0.0415056595, 0.0415056595),
      (f_inq_Collection_count24_i > 0.5) => 0.1662282246,
      (f_inq_Collection_count24_i = NULL) => 0.0656942782, 0.0656942782),
   (c_vacant_p > 5.25) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 0.0330890240,
      (f_inq_count_i > 7.5) => -0.0583326553,
      (f_inq_count_i = NULL) => 0.0030745363, 0.0030745363),
   (c_vacant_p = NULL) => 0.0253663538, 0.0253663538),
(f_srchphonesrchcount_i = NULL) => 0.0386006672, 0.0015662572);

// Tree: 311 
woFDN_FL_PS__lgt_311 := map(
(NULL < c_no_teens and c_no_teens <= 13.5) => -0.0357602101,
(c_no_teens > 13.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 82.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 3.5) => -0.1078931209,
      (f_mos_inq_banko_cm_lseen_d > 3.5) => -0.0133155370,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0156374624, -0.0156374624),
   (c_easiqlife > 82.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 62.5) => -0.0136083559,
      (r_C13_max_lres_d > 62.5) => 0.0185463678,
      (r_C13_max_lres_d = NULL) => -0.0031769349, 0.0118881591),
   (c_easiqlife = NULL) => 0.0050155798, 0.0050155798),
(c_no_teens = NULL) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 401) => -0.0958718872,
   (r_A50_pb_average_dollars_d > 401) => 0.0315045367,
   (r_A50_pb_average_dollars_d = NULL) => -0.0218722505, -0.0218722505), 0.0021813929);

// Tree: 312 
woFDN_FL_PS__lgt_312 := map(
(NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1340446923) => -0.0034526889,
(f_add_curr_nhood_VAC_pct_i > 0.1340446923) => 
   map(
   (NULL < c_retired and c_retired <= 3.45) => 0.1475854180,
   (c_retired > 3.45) => 
      map(
      (NULL < c_food and c_food <= 25.55) => -0.0024065312,
      (c_food > 25.55) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 18.15) => 
            map(
            (NULL < c_work_home and c_work_home <= 72) => 0.0235292852,
            (c_work_home > 72) => 0.2522361983,
            (c_work_home = NULL) => 0.1499573303, 0.1499573303),
         (C_INC_75K_P > 18.15) => 0.0006666740,
         (C_INC_75K_P = NULL) => 0.0779521906, 0.0779521906),
      (c_food = NULL) => 0.0198081910, 0.0198081910),
   (c_retired = NULL) => 0.0255570815, 0.0255570815),
(f_add_curr_nhood_VAC_pct_i = NULL) => 0.0063704825, -0.0006419274);

// Tree: 313 
woFDN_FL_PS__lgt_313 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.75) => -0.0026222400,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.75) => 0.1511239705,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 2.75) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
         map(
         (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 0.0247471794,
         (k_nap_contradictory_i > 0.5) => 
            map(
            (NULL < c_rental and c_rental <= 65.5) => -0.0136412565,
            (c_rental > 65.5) => 0.1658265320,
            (c_rental = NULL) => 0.0858955001, 0.0858955001),
         (k_nap_contradictory_i = NULL) => 0.0309559253, 0.0309559253),
      (k_estimated_income_d > 32500) => -0.0088809879,
      (k_estimated_income_d = NULL) => 0.0087175279, 0.0087175279),
   (c_professional > 2.75) => -0.0138544711,
   (c_professional = NULL) => -0.0209045212, -0.0052283323), -0.0033851191);

// Final Score Sum 

   woFDN_FL_PS__lgt := sum(
      woFDN_FL_PS__lgt_0, woFDN_FL_PS__lgt_1, woFDN_FL_PS__lgt_2, woFDN_FL_PS__lgt_3, woFDN_FL_PS__lgt_4, 
      woFDN_FL_PS__lgt_5, woFDN_FL_PS__lgt_6, woFDN_FL_PS__lgt_7, woFDN_FL_PS__lgt_8, woFDN_FL_PS__lgt_9, 
      woFDN_FL_PS__lgt_10, woFDN_FL_PS__lgt_11, woFDN_FL_PS__lgt_12, woFDN_FL_PS__lgt_13, woFDN_FL_PS__lgt_14, 
      woFDN_FL_PS__lgt_15, woFDN_FL_PS__lgt_16, woFDN_FL_PS__lgt_17, woFDN_FL_PS__lgt_18, woFDN_FL_PS__lgt_19, 
      woFDN_FL_PS__lgt_20, woFDN_FL_PS__lgt_21, woFDN_FL_PS__lgt_22, woFDN_FL_PS__lgt_23, woFDN_FL_PS__lgt_24, 
      woFDN_FL_PS__lgt_25, woFDN_FL_PS__lgt_26, woFDN_FL_PS__lgt_27, woFDN_FL_PS__lgt_28, woFDN_FL_PS__lgt_29, 
      woFDN_FL_PS__lgt_30, woFDN_FL_PS__lgt_31, woFDN_FL_PS__lgt_32, woFDN_FL_PS__lgt_33, woFDN_FL_PS__lgt_34, 
      woFDN_FL_PS__lgt_35, woFDN_FL_PS__lgt_36, woFDN_FL_PS__lgt_37, woFDN_FL_PS__lgt_38, woFDN_FL_PS__lgt_39, 
      woFDN_FL_PS__lgt_40, woFDN_FL_PS__lgt_41, woFDN_FL_PS__lgt_42, woFDN_FL_PS__lgt_43, woFDN_FL_PS__lgt_44, 
      woFDN_FL_PS__lgt_45, woFDN_FL_PS__lgt_46, woFDN_FL_PS__lgt_47, woFDN_FL_PS__lgt_48, woFDN_FL_PS__lgt_49, 
      woFDN_FL_PS__lgt_50, woFDN_FL_PS__lgt_51, woFDN_FL_PS__lgt_52, woFDN_FL_PS__lgt_53, woFDN_FL_PS__lgt_54, 
      woFDN_FL_PS__lgt_55, woFDN_FL_PS__lgt_56, woFDN_FL_PS__lgt_57, woFDN_FL_PS__lgt_58, woFDN_FL_PS__lgt_59, 
      woFDN_FL_PS__lgt_60, woFDN_FL_PS__lgt_61, woFDN_FL_PS__lgt_62, woFDN_FL_PS__lgt_63, woFDN_FL_PS__lgt_64, 
      woFDN_FL_PS__lgt_65, woFDN_FL_PS__lgt_66, woFDN_FL_PS__lgt_67, woFDN_FL_PS__lgt_68, woFDN_FL_PS__lgt_69, 
      woFDN_FL_PS__lgt_70, woFDN_FL_PS__lgt_71, woFDN_FL_PS__lgt_72, woFDN_FL_PS__lgt_73, woFDN_FL_PS__lgt_74, 
      woFDN_FL_PS__lgt_75, woFDN_FL_PS__lgt_76, woFDN_FL_PS__lgt_77, woFDN_FL_PS__lgt_78, woFDN_FL_PS__lgt_79, 
      woFDN_FL_PS__lgt_80, woFDN_FL_PS__lgt_81, woFDN_FL_PS__lgt_82, woFDN_FL_PS__lgt_83, woFDN_FL_PS__lgt_84, 
      woFDN_FL_PS__lgt_85, woFDN_FL_PS__lgt_86, woFDN_FL_PS__lgt_87, woFDN_FL_PS__lgt_88, woFDN_FL_PS__lgt_89, 
      woFDN_FL_PS__lgt_90, woFDN_FL_PS__lgt_91, woFDN_FL_PS__lgt_92, woFDN_FL_PS__lgt_93, woFDN_FL_PS__lgt_94, 
      woFDN_FL_PS__lgt_95, woFDN_FL_PS__lgt_96, woFDN_FL_PS__lgt_97, woFDN_FL_PS__lgt_98, woFDN_FL_PS__lgt_99, 
      woFDN_FL_PS__lgt_100, woFDN_FL_PS__lgt_101, woFDN_FL_PS__lgt_102, woFDN_FL_PS__lgt_103, woFDN_FL_PS__lgt_104, 
      woFDN_FL_PS__lgt_105, woFDN_FL_PS__lgt_106, woFDN_FL_PS__lgt_107, woFDN_FL_PS__lgt_108, woFDN_FL_PS__lgt_109, 
      woFDN_FL_PS__lgt_110, woFDN_FL_PS__lgt_111, woFDN_FL_PS__lgt_112, woFDN_FL_PS__lgt_113, woFDN_FL_PS__lgt_114, 
      woFDN_FL_PS__lgt_115, woFDN_FL_PS__lgt_116, woFDN_FL_PS__lgt_117, woFDN_FL_PS__lgt_118, woFDN_FL_PS__lgt_119, 
      woFDN_FL_PS__lgt_120, woFDN_FL_PS__lgt_121, woFDN_FL_PS__lgt_122, woFDN_FL_PS__lgt_123, woFDN_FL_PS__lgt_124, 
      woFDN_FL_PS__lgt_125, woFDN_FL_PS__lgt_126, woFDN_FL_PS__lgt_127, woFDN_FL_PS__lgt_128, woFDN_FL_PS__lgt_129, 
      woFDN_FL_PS__lgt_130, woFDN_FL_PS__lgt_131, woFDN_FL_PS__lgt_132, woFDN_FL_PS__lgt_133, woFDN_FL_PS__lgt_134, 
      woFDN_FL_PS__lgt_135, woFDN_FL_PS__lgt_136, woFDN_FL_PS__lgt_137, woFDN_FL_PS__lgt_138, woFDN_FL_PS__lgt_139, 
      woFDN_FL_PS__lgt_140, woFDN_FL_PS__lgt_141, woFDN_FL_PS__lgt_142, woFDN_FL_PS__lgt_143, woFDN_FL_PS__lgt_144, 
      woFDN_FL_PS__lgt_145, woFDN_FL_PS__lgt_146, woFDN_FL_PS__lgt_147, woFDN_FL_PS__lgt_148, woFDN_FL_PS__lgt_149, 
      woFDN_FL_PS__lgt_150, woFDN_FL_PS__lgt_151, woFDN_FL_PS__lgt_152, woFDN_FL_PS__lgt_153, woFDN_FL_PS__lgt_154, 
      woFDN_FL_PS__lgt_155, woFDN_FL_PS__lgt_156, woFDN_FL_PS__lgt_157, woFDN_FL_PS__lgt_158, woFDN_FL_PS__lgt_159, 
      woFDN_FL_PS__lgt_160, woFDN_FL_PS__lgt_161, woFDN_FL_PS__lgt_162, woFDN_FL_PS__lgt_163, woFDN_FL_PS__lgt_164, 
      woFDN_FL_PS__lgt_165, woFDN_FL_PS__lgt_166, woFDN_FL_PS__lgt_167, woFDN_FL_PS__lgt_168, woFDN_FL_PS__lgt_169, 
      woFDN_FL_PS__lgt_170, woFDN_FL_PS__lgt_171, woFDN_FL_PS__lgt_172, woFDN_FL_PS__lgt_173, woFDN_FL_PS__lgt_174, 
      woFDN_FL_PS__lgt_175, woFDN_FL_PS__lgt_176, woFDN_FL_PS__lgt_177, woFDN_FL_PS__lgt_178, woFDN_FL_PS__lgt_179, 
      woFDN_FL_PS__lgt_180, woFDN_FL_PS__lgt_181, woFDN_FL_PS__lgt_182, woFDN_FL_PS__lgt_183, woFDN_FL_PS__lgt_184, 
      woFDN_FL_PS__lgt_185, woFDN_FL_PS__lgt_186, woFDN_FL_PS__lgt_187, woFDN_FL_PS__lgt_188, woFDN_FL_PS__lgt_189, 
      woFDN_FL_PS__lgt_190, woFDN_FL_PS__lgt_191, woFDN_FL_PS__lgt_192, woFDN_FL_PS__lgt_193, woFDN_FL_PS__lgt_194, 
      woFDN_FL_PS__lgt_195, woFDN_FL_PS__lgt_196, woFDN_FL_PS__lgt_197, woFDN_FL_PS__lgt_198, woFDN_FL_PS__lgt_199, 
      woFDN_FL_PS__lgt_200, woFDN_FL_PS__lgt_201, woFDN_FL_PS__lgt_202, woFDN_FL_PS__lgt_203, woFDN_FL_PS__lgt_204, 
      woFDN_FL_PS__lgt_205, woFDN_FL_PS__lgt_206, woFDN_FL_PS__lgt_207, woFDN_FL_PS__lgt_208, woFDN_FL_PS__lgt_209, 
      woFDN_FL_PS__lgt_210, woFDN_FL_PS__lgt_211, woFDN_FL_PS__lgt_212, woFDN_FL_PS__lgt_213, woFDN_FL_PS__lgt_214, 
      woFDN_FL_PS__lgt_215, woFDN_FL_PS__lgt_216, woFDN_FL_PS__lgt_217, woFDN_FL_PS__lgt_218, woFDN_FL_PS__lgt_219, 
      woFDN_FL_PS__lgt_220, woFDN_FL_PS__lgt_221, woFDN_FL_PS__lgt_222, woFDN_FL_PS__lgt_223, woFDN_FL_PS__lgt_224, 
      woFDN_FL_PS__lgt_225, woFDN_FL_PS__lgt_226, woFDN_FL_PS__lgt_227, woFDN_FL_PS__lgt_228, woFDN_FL_PS__lgt_229, 
      woFDN_FL_PS__lgt_230, woFDN_FL_PS__lgt_231, woFDN_FL_PS__lgt_232, woFDN_FL_PS__lgt_233, woFDN_FL_PS__lgt_234, 
      woFDN_FL_PS__lgt_235, woFDN_FL_PS__lgt_236, woFDN_FL_PS__lgt_237, woFDN_FL_PS__lgt_238, woFDN_FL_PS__lgt_239, 
      woFDN_FL_PS__lgt_240, woFDN_FL_PS__lgt_241, woFDN_FL_PS__lgt_242, woFDN_FL_PS__lgt_243, woFDN_FL_PS__lgt_244, 
      woFDN_FL_PS__lgt_245, woFDN_FL_PS__lgt_246, woFDN_FL_PS__lgt_247, woFDN_FL_PS__lgt_248, woFDN_FL_PS__lgt_249, 
      woFDN_FL_PS__lgt_250, woFDN_FL_PS__lgt_251, woFDN_FL_PS__lgt_252, woFDN_FL_PS__lgt_253, woFDN_FL_PS__lgt_254, 
      woFDN_FL_PS__lgt_255, woFDN_FL_PS__lgt_256, woFDN_FL_PS__lgt_257, woFDN_FL_PS__lgt_258, woFDN_FL_PS__lgt_259, 
      woFDN_FL_PS__lgt_260, woFDN_FL_PS__lgt_261, woFDN_FL_PS__lgt_262, woFDN_FL_PS__lgt_263, woFDN_FL_PS__lgt_264, 
      woFDN_FL_PS__lgt_265, woFDN_FL_PS__lgt_266, woFDN_FL_PS__lgt_267, woFDN_FL_PS__lgt_268, woFDN_FL_PS__lgt_269, 
      woFDN_FL_PS__lgt_270, woFDN_FL_PS__lgt_271, woFDN_FL_PS__lgt_272, woFDN_FL_PS__lgt_273, woFDN_FL_PS__lgt_274, 
      woFDN_FL_PS__lgt_275, woFDN_FL_PS__lgt_276, woFDN_FL_PS__lgt_277, woFDN_FL_PS__lgt_278, woFDN_FL_PS__lgt_279, 
      woFDN_FL_PS__lgt_280, woFDN_FL_PS__lgt_281, woFDN_FL_PS__lgt_282, woFDN_FL_PS__lgt_283, woFDN_FL_PS__lgt_284, 
      woFDN_FL_PS__lgt_285, woFDN_FL_PS__lgt_286, woFDN_FL_PS__lgt_287, woFDN_FL_PS__lgt_288, woFDN_FL_PS__lgt_289, 
      woFDN_FL_PS__lgt_290, woFDN_FL_PS__lgt_291, woFDN_FL_PS__lgt_292, woFDN_FL_PS__lgt_293, woFDN_FL_PS__lgt_294, 
      woFDN_FL_PS__lgt_295, woFDN_FL_PS__lgt_296, woFDN_FL_PS__lgt_297, woFDN_FL_PS__lgt_298, woFDN_FL_PS__lgt_299, 
      woFDN_FL_PS__lgt_300, woFDN_FL_PS__lgt_301, woFDN_FL_PS__lgt_302, woFDN_FL_PS__lgt_303, woFDN_FL_PS__lgt_304, 
      woFDN_FL_PS__lgt_305, woFDN_FL_PS__lgt_306, woFDN_FL_PS__lgt_307, woFDN_FL_PS__lgt_308, woFDN_FL_PS__lgt_309, 
      woFDN_FL_PS__lgt_310, woFDN_FL_PS__lgt_311, woFDN_FL_PS__lgt_312, woFDN_FL_PS__lgt_313); 


// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_woFDN_LGT := woFDN_FL_PS__lgt;
			
self.final_score_0	:= 	woFDN_FL_PS__lgt_0	;
self.final_score_1	:= 	woFDN_FL_PS__lgt_1	;
self.final_score_2	:= 	woFDN_FL_PS__lgt_2	;
self.final_score_3	:= 	woFDN_FL_PS__lgt_3	;
self.final_score_4	:= 	woFDN_FL_PS__lgt_4	;
self.final_score_5	:= 	woFDN_FL_PS__lgt_5	;
self.final_score_6	:= 	woFDN_FL_PS__lgt_6	;
self.final_score_7	:= 	woFDN_FL_PS__lgt_7	;
self.final_score_8	:= 	woFDN_FL_PS__lgt_8	;
self.final_score_9	:= 	woFDN_FL_PS__lgt_9	;
self.final_score_10	:= 	woFDN_FL_PS__lgt_10	;
self.final_score_11	:= 	woFDN_FL_PS__lgt_11	;
self.final_score_12	:= 	woFDN_FL_PS__lgt_12	;
self.final_score_13	:= 	woFDN_FL_PS__lgt_13	;
self.final_score_14	:= 	woFDN_FL_PS__lgt_14	;
self.final_score_15	:= 	woFDN_FL_PS__lgt_15	;
self.final_score_16	:= 	woFDN_FL_PS__lgt_16	;
self.final_score_17	:= 	woFDN_FL_PS__lgt_17	;
self.final_score_18	:= 	woFDN_FL_PS__lgt_18	;
self.final_score_19	:= 	woFDN_FL_PS__lgt_19	;
self.final_score_20	:= 	woFDN_FL_PS__lgt_20	;
self.final_score_21	:= 	woFDN_FL_PS__lgt_21	;
self.final_score_22	:= 	woFDN_FL_PS__lgt_22	;
self.final_score_23	:= 	woFDN_FL_PS__lgt_23	;
self.final_score_24	:= 	woFDN_FL_PS__lgt_24	;
self.final_score_25	:= 	woFDN_FL_PS__lgt_25	;
self.final_score_26	:= 	woFDN_FL_PS__lgt_26	;
self.final_score_27	:= 	woFDN_FL_PS__lgt_27	;
self.final_score_28	:= 	woFDN_FL_PS__lgt_28	;
self.final_score_29	:= 	woFDN_FL_PS__lgt_29	;
self.final_score_30	:= 	woFDN_FL_PS__lgt_30	;
self.final_score_31	:= 	woFDN_FL_PS__lgt_31	;
self.final_score_32	:= 	woFDN_FL_PS__lgt_32	;
self.final_score_33	:= 	woFDN_FL_PS__lgt_33	;
self.final_score_34	:= 	woFDN_FL_PS__lgt_34	;
self.final_score_35	:= 	woFDN_FL_PS__lgt_35	;
self.final_score_36	:= 	woFDN_FL_PS__lgt_36	;
self.final_score_37	:= 	woFDN_FL_PS__lgt_37	;
self.final_score_38	:= 	woFDN_FL_PS__lgt_38	;
self.final_score_39	:= 	woFDN_FL_PS__lgt_39	;
self.final_score_40	:= 	woFDN_FL_PS__lgt_40	;
self.final_score_41	:= 	woFDN_FL_PS__lgt_41	;
self.final_score_42	:= 	woFDN_FL_PS__lgt_42	;
self.final_score_43	:= 	woFDN_FL_PS__lgt_43	;
self.final_score_44	:= 	woFDN_FL_PS__lgt_44	;
self.final_score_45	:= 	woFDN_FL_PS__lgt_45	;
self.final_score_46	:= 	woFDN_FL_PS__lgt_46	;
self.final_score_47	:= 	woFDN_FL_PS__lgt_47	;
self.final_score_48	:= 	woFDN_FL_PS__lgt_48	;
self.final_score_49	:= 	woFDN_FL_PS__lgt_49	;
self.final_score_50	:= 	woFDN_FL_PS__lgt_50	;
self.final_score_51	:= 	woFDN_FL_PS__lgt_51	;
self.final_score_52	:= 	woFDN_FL_PS__lgt_52	;
self.final_score_53	:= 	woFDN_FL_PS__lgt_53	;
self.final_score_54	:= 	woFDN_FL_PS__lgt_54	;
self.final_score_55	:= 	woFDN_FL_PS__lgt_55	;
self.final_score_56	:= 	woFDN_FL_PS__lgt_56	;
self.final_score_57	:= 	woFDN_FL_PS__lgt_57	;
self.final_score_58	:= 	woFDN_FL_PS__lgt_58	;
self.final_score_59	:= 	woFDN_FL_PS__lgt_59	;
self.final_score_60	:= 	woFDN_FL_PS__lgt_60	;
self.final_score_61	:= 	woFDN_FL_PS__lgt_61	;
self.final_score_62	:= 	woFDN_FL_PS__lgt_62	;
self.final_score_63	:= 	woFDN_FL_PS__lgt_63	;
self.final_score_64	:= 	woFDN_FL_PS__lgt_64	;
self.final_score_65	:= 	woFDN_FL_PS__lgt_65	;
self.final_score_66	:= 	woFDN_FL_PS__lgt_66	;
self.final_score_67	:= 	woFDN_FL_PS__lgt_67	;
self.final_score_68	:= 	woFDN_FL_PS__lgt_68	;
self.final_score_69	:= 	woFDN_FL_PS__lgt_69	;
self.final_score_70	:= 	woFDN_FL_PS__lgt_70	;
self.final_score_71	:= 	woFDN_FL_PS__lgt_71	;
self.final_score_72	:= 	woFDN_FL_PS__lgt_72	;
self.final_score_73	:= 	woFDN_FL_PS__lgt_73	;
self.final_score_74	:= 	woFDN_FL_PS__lgt_74	;
self.final_score_75	:= 	woFDN_FL_PS__lgt_75	;
self.final_score_76	:= 	woFDN_FL_PS__lgt_76	;
self.final_score_77	:= 	woFDN_FL_PS__lgt_77	;
self.final_score_78	:= 	woFDN_FL_PS__lgt_78	;
self.final_score_79	:= 	woFDN_FL_PS__lgt_79	;
self.final_score_80	:= 	woFDN_FL_PS__lgt_80	;
self.final_score_81	:= 	woFDN_FL_PS__lgt_81	;
self.final_score_82	:= 	woFDN_FL_PS__lgt_82	;
self.final_score_83	:= 	woFDN_FL_PS__lgt_83	;
self.final_score_84	:= 	woFDN_FL_PS__lgt_84	;
self.final_score_85	:= 	woFDN_FL_PS__lgt_85	;
self.final_score_86	:= 	woFDN_FL_PS__lgt_86	;
self.final_score_87	:= 	woFDN_FL_PS__lgt_87	;
self.final_score_88	:= 	woFDN_FL_PS__lgt_88	;
self.final_score_89	:= 	woFDN_FL_PS__lgt_89	;
self.final_score_90	:= 	woFDN_FL_PS__lgt_90	;
self.final_score_91	:= 	woFDN_FL_PS__lgt_91	;
self.final_score_92	:= 	woFDN_FL_PS__lgt_92	;
self.final_score_93	:= 	woFDN_FL_PS__lgt_93	;
self.final_score_94	:= 	woFDN_FL_PS__lgt_94	;
self.final_score_95	:= 	woFDN_FL_PS__lgt_95	;
self.final_score_96	:= 	woFDN_FL_PS__lgt_96	;
self.final_score_97	:= 	woFDN_FL_PS__lgt_97	;
self.final_score_98	:= 	woFDN_FL_PS__lgt_98	;
self.final_score_99	:= 	woFDN_FL_PS__lgt_99	;
self.final_score_100	:= 	woFDN_FL_PS__lgt_100	;
self.final_score_101	:= 	woFDN_FL_PS__lgt_101	;
self.final_score_102	:= 	woFDN_FL_PS__lgt_102	;
self.final_score_103	:= 	woFDN_FL_PS__lgt_103	;
self.final_score_104	:= 	woFDN_FL_PS__lgt_104	;
self.final_score_105	:= 	woFDN_FL_PS__lgt_105	;
self.final_score_106	:= 	woFDN_FL_PS__lgt_106	;
self.final_score_107	:= 	woFDN_FL_PS__lgt_107	;
self.final_score_108	:= 	woFDN_FL_PS__lgt_108	;
self.final_score_109	:= 	woFDN_FL_PS__lgt_109	;
self.final_score_110	:= 	woFDN_FL_PS__lgt_110	;
self.final_score_111	:= 	woFDN_FL_PS__lgt_111	;
self.final_score_112	:= 	woFDN_FL_PS__lgt_112	;
self.final_score_113	:= 	woFDN_FL_PS__lgt_113	;
self.final_score_114	:= 	woFDN_FL_PS__lgt_114	;
self.final_score_115	:= 	woFDN_FL_PS__lgt_115	;
self.final_score_116	:= 	woFDN_FL_PS__lgt_116	;
self.final_score_117	:= 	woFDN_FL_PS__lgt_117	;
self.final_score_118	:= 	woFDN_FL_PS__lgt_118	;
self.final_score_119	:= 	woFDN_FL_PS__lgt_119	;
self.final_score_120	:= 	woFDN_FL_PS__lgt_120	;
self.final_score_121	:= 	woFDN_FL_PS__lgt_121	;
self.final_score_122	:= 	woFDN_FL_PS__lgt_122	;
self.final_score_123	:= 	woFDN_FL_PS__lgt_123	;
self.final_score_124	:= 	woFDN_FL_PS__lgt_124	;
self.final_score_125	:= 	woFDN_FL_PS__lgt_125	;
self.final_score_126	:= 	woFDN_FL_PS__lgt_126	;
self.final_score_127	:= 	woFDN_FL_PS__lgt_127	;
self.final_score_128	:= 	woFDN_FL_PS__lgt_128	;
self.final_score_129	:= 	woFDN_FL_PS__lgt_129	;
self.final_score_130	:= 	woFDN_FL_PS__lgt_130	;
self.final_score_131	:= 	woFDN_FL_PS__lgt_131	;
self.final_score_132	:= 	woFDN_FL_PS__lgt_132	;
self.final_score_133	:= 	woFDN_FL_PS__lgt_133	;
self.final_score_134	:= 	woFDN_FL_PS__lgt_134	;
self.final_score_135	:= 	woFDN_FL_PS__lgt_135	;
self.final_score_136	:= 	woFDN_FL_PS__lgt_136	;
self.final_score_137	:= 	woFDN_FL_PS__lgt_137	;
self.final_score_138	:= 	woFDN_FL_PS__lgt_138	;
self.final_score_139	:= 	woFDN_FL_PS__lgt_139	;
self.final_score_140	:= 	woFDN_FL_PS__lgt_140	;
self.final_score_141	:= 	woFDN_FL_PS__lgt_141	;
self.final_score_142	:= 	woFDN_FL_PS__lgt_142	;
self.final_score_143	:= 	woFDN_FL_PS__lgt_143	;
self.final_score_144	:= 	woFDN_FL_PS__lgt_144	;
self.final_score_145	:= 	woFDN_FL_PS__lgt_145	;
self.final_score_146	:= 	woFDN_FL_PS__lgt_146	;
self.final_score_147	:= 	woFDN_FL_PS__lgt_147	;
self.final_score_148	:= 	woFDN_FL_PS__lgt_148	;
self.final_score_149	:= 	woFDN_FL_PS__lgt_149	;
self.final_score_150	:= 	woFDN_FL_PS__lgt_150	;
self.final_score_151	:= 	woFDN_FL_PS__lgt_151	;
self.final_score_152	:= 	woFDN_FL_PS__lgt_152	;
self.final_score_153	:= 	woFDN_FL_PS__lgt_153	;
self.final_score_154	:= 	woFDN_FL_PS__lgt_154	;
self.final_score_155	:= 	woFDN_FL_PS__lgt_155	;
self.final_score_156	:= 	woFDN_FL_PS__lgt_156	;
self.final_score_157	:= 	woFDN_FL_PS__lgt_157	;
self.final_score_158	:= 	woFDN_FL_PS__lgt_158	;
self.final_score_159	:= 	woFDN_FL_PS__lgt_159	;
self.final_score_160	:= 	woFDN_FL_PS__lgt_160	;
self.final_score_161	:= 	woFDN_FL_PS__lgt_161	;
self.final_score_162	:= 	woFDN_FL_PS__lgt_162	;
self.final_score_163	:= 	woFDN_FL_PS__lgt_163	;
self.final_score_164	:= 	woFDN_FL_PS__lgt_164	;
self.final_score_165	:= 	woFDN_FL_PS__lgt_165	;
self.final_score_166	:= 	woFDN_FL_PS__lgt_166	;
self.final_score_167	:= 	woFDN_FL_PS__lgt_167	;
self.final_score_168	:= 	woFDN_FL_PS__lgt_168	;
self.final_score_169	:= 	woFDN_FL_PS__lgt_169	;
self.final_score_170	:= 	woFDN_FL_PS__lgt_170	;
self.final_score_171	:= 	woFDN_FL_PS__lgt_171	;
self.final_score_172	:= 	woFDN_FL_PS__lgt_172	;
self.final_score_173	:= 	woFDN_FL_PS__lgt_173	;
self.final_score_174	:= 	woFDN_FL_PS__lgt_174	;
self.final_score_175	:= 	woFDN_FL_PS__lgt_175	;
self.final_score_176	:= 	woFDN_FL_PS__lgt_176	;
self.final_score_177	:= 	woFDN_FL_PS__lgt_177	;
self.final_score_178	:= 	woFDN_FL_PS__lgt_178	;
self.final_score_179	:= 	woFDN_FL_PS__lgt_179	;
self.final_score_180	:= 	woFDN_FL_PS__lgt_180	;
self.final_score_181	:= 	woFDN_FL_PS__lgt_181	;
self.final_score_182	:= 	woFDN_FL_PS__lgt_182	;
self.final_score_183	:= 	woFDN_FL_PS__lgt_183	;
self.final_score_184	:= 	woFDN_FL_PS__lgt_184	;
self.final_score_185	:= 	woFDN_FL_PS__lgt_185	;
self.final_score_186	:= 	woFDN_FL_PS__lgt_186	;
self.final_score_187	:= 	woFDN_FL_PS__lgt_187	;
self.final_score_188	:= 	woFDN_FL_PS__lgt_188	;
self.final_score_189	:= 	woFDN_FL_PS__lgt_189	;
self.final_score_190	:= 	woFDN_FL_PS__lgt_190	;
self.final_score_191	:= 	woFDN_FL_PS__lgt_191	;
self.final_score_192	:= 	woFDN_FL_PS__lgt_192	;
self.final_score_193	:= 	woFDN_FL_PS__lgt_193	;
self.final_score_194	:= 	woFDN_FL_PS__lgt_194	;
self.final_score_195	:= 	woFDN_FL_PS__lgt_195	;
self.final_score_196	:= 	woFDN_FL_PS__lgt_196	;
self.final_score_197	:= 	woFDN_FL_PS__lgt_197	;
self.final_score_198	:= 	woFDN_FL_PS__lgt_198	;
self.final_score_199	:= 	woFDN_FL_PS__lgt_199	;
self.final_score_200	:= 	woFDN_FL_PS__lgt_200	;
self.final_score_201	:= 	woFDN_FL_PS__lgt_201	;
self.final_score_202	:= 	woFDN_FL_PS__lgt_202	;
self.final_score_203	:= 	woFDN_FL_PS__lgt_203	;
self.final_score_204	:= 	woFDN_FL_PS__lgt_204	;
self.final_score_205	:= 	woFDN_FL_PS__lgt_205	;
self.final_score_206	:= 	woFDN_FL_PS__lgt_206	;
self.final_score_207	:= 	woFDN_FL_PS__lgt_207	;
self.final_score_208	:= 	woFDN_FL_PS__lgt_208	;
self.final_score_209	:= 	woFDN_FL_PS__lgt_209	;
self.final_score_210	:= 	woFDN_FL_PS__lgt_210	;
self.final_score_211	:= 	woFDN_FL_PS__lgt_211	;
self.final_score_212	:= 	woFDN_FL_PS__lgt_212	;
self.final_score_213	:= 	woFDN_FL_PS__lgt_213	;
self.final_score_214	:= 	woFDN_FL_PS__lgt_214	;
self.final_score_215	:= 	woFDN_FL_PS__lgt_215	;
self.final_score_216	:= 	woFDN_FL_PS__lgt_216	;
self.final_score_217	:= 	woFDN_FL_PS__lgt_217	;
self.final_score_218	:= 	woFDN_FL_PS__lgt_218	;
self.final_score_219	:= 	woFDN_FL_PS__lgt_219	;
self.final_score_220	:= 	woFDN_FL_PS__lgt_220	;
self.final_score_221	:= 	woFDN_FL_PS__lgt_221	;
self.final_score_222	:= 	woFDN_FL_PS__lgt_222	;
self.final_score_223	:= 	woFDN_FL_PS__lgt_223	;
self.final_score_224	:= 	woFDN_FL_PS__lgt_224	;
self.final_score_225	:= 	woFDN_FL_PS__lgt_225	;
self.final_score_226	:= 	woFDN_FL_PS__lgt_226	;
self.final_score_227	:= 	woFDN_FL_PS__lgt_227	;
self.final_score_228	:= 	woFDN_FL_PS__lgt_228	;
self.final_score_229	:= 	woFDN_FL_PS__lgt_229	;
self.final_score_230	:= 	woFDN_FL_PS__lgt_230	;
self.final_score_231	:= 	woFDN_FL_PS__lgt_231	;
self.final_score_232	:= 	woFDN_FL_PS__lgt_232	;
self.final_score_233	:= 	woFDN_FL_PS__lgt_233	;
self.final_score_234	:= 	woFDN_FL_PS__lgt_234	;
self.final_score_235	:= 	woFDN_FL_PS__lgt_235	;
self.final_score_236	:= 	woFDN_FL_PS__lgt_236	;
self.final_score_237	:= 	woFDN_FL_PS__lgt_237	;
self.final_score_238	:= 	woFDN_FL_PS__lgt_238	;
self.final_score_239	:= 	woFDN_FL_PS__lgt_239	;
self.final_score_240	:= 	woFDN_FL_PS__lgt_240	;
self.final_score_241	:= 	woFDN_FL_PS__lgt_241	;
self.final_score_242	:= 	woFDN_FL_PS__lgt_242	;
self.final_score_243	:= 	woFDN_FL_PS__lgt_243	;
self.final_score_244	:= 	woFDN_FL_PS__lgt_244	;
self.final_score_245	:= 	woFDN_FL_PS__lgt_245	;
self.final_score_246	:= 	woFDN_FL_PS__lgt_246	;
self.final_score_247	:= 	woFDN_FL_PS__lgt_247	;
self.final_score_248	:= 	woFDN_FL_PS__lgt_248	;
self.final_score_249	:= 	woFDN_FL_PS__lgt_249	;
self.final_score_250	:= 	woFDN_FL_PS__lgt_250	;
self.final_score_251	:= 	woFDN_FL_PS__lgt_251	;
self.final_score_252	:= 	woFDN_FL_PS__lgt_252	;
self.final_score_253	:= 	woFDN_FL_PS__lgt_253	;
self.final_score_254	:= 	woFDN_FL_PS__lgt_254	;
self.final_score_255	:= 	woFDN_FL_PS__lgt_255	;
self.final_score_256	:= 	woFDN_FL_PS__lgt_256	;
self.final_score_257	:= 	woFDN_FL_PS__lgt_257	;
self.final_score_258	:= 	woFDN_FL_PS__lgt_258	;
self.final_score_259	:= 	woFDN_FL_PS__lgt_259	;
self.final_score_260	:= 	woFDN_FL_PS__lgt_260	;
self.final_score_261	:= 	woFDN_FL_PS__lgt_261	;
self.final_score_262	:= 	woFDN_FL_PS__lgt_262	;
self.final_score_263	:= 	woFDN_FL_PS__lgt_263	;
self.final_score_264	:= 	woFDN_FL_PS__lgt_264	;
self.final_score_265	:= 	woFDN_FL_PS__lgt_265	;
self.final_score_266	:= 	woFDN_FL_PS__lgt_266	;
self.final_score_267	:= 	woFDN_FL_PS__lgt_267	;
self.final_score_268	:= 	woFDN_FL_PS__lgt_268	;
self.final_score_269	:= 	woFDN_FL_PS__lgt_269	;
self.final_score_270	:= 	woFDN_FL_PS__lgt_270	;
self.final_score_271	:= 	woFDN_FL_PS__lgt_271	;
self.final_score_272	:= 	woFDN_FL_PS__lgt_272	;
self.final_score_273	:= 	woFDN_FL_PS__lgt_273	;
self.final_score_274	:= 	woFDN_FL_PS__lgt_274	;
self.final_score_275	:= 	woFDN_FL_PS__lgt_275	;
self.final_score_276	:= 	woFDN_FL_PS__lgt_276	;
self.final_score_277	:= 	woFDN_FL_PS__lgt_277	;
self.final_score_278	:= 	woFDN_FL_PS__lgt_278	;
self.final_score_279	:= 	woFDN_FL_PS__lgt_279	;
self.final_score_280	:= 	woFDN_FL_PS__lgt_280	;
self.final_score_281	:= 	woFDN_FL_PS__lgt_281	;
self.final_score_282	:= 	woFDN_FL_PS__lgt_282	;
self.final_score_283	:= 	woFDN_FL_PS__lgt_283	;
self.final_score_284	:= 	woFDN_FL_PS__lgt_284	;
self.final_score_285	:= 	woFDN_FL_PS__lgt_285	;
self.final_score_286	:= 	woFDN_FL_PS__lgt_286	;
self.final_score_287	:= 	woFDN_FL_PS__lgt_287	;
self.final_score_288	:= 	woFDN_FL_PS__lgt_288	;
self.final_score_289	:= 	woFDN_FL_PS__lgt_289	;
self.final_score_290	:= 	woFDN_FL_PS__lgt_290	;
self.final_score_291	:= 	woFDN_FL_PS__lgt_291	;
self.final_score_292	:= 	woFDN_FL_PS__lgt_292	;
self.final_score_293	:= 	woFDN_FL_PS__lgt_293	;
self.final_score_294	:= 	woFDN_FL_PS__lgt_294	;
self.final_score_295	:= 	woFDN_FL_PS__lgt_295	;
self.final_score_296	:= 	woFDN_FL_PS__lgt_296	;
self.final_score_297	:= 	woFDN_FL_PS__lgt_297	;
self.final_score_298	:= 	woFDN_FL_PS__lgt_298	;
self.final_score_299	:= 	woFDN_FL_PS__lgt_299	;
self.final_score_300	:= 	woFDN_FL_PS__lgt_300	;
self.final_score_301	:= 	woFDN_FL_PS__lgt_301	;
self.final_score_302	:= 	woFDN_FL_PS__lgt_302	;
self.final_score_303	:= 	woFDN_FL_PS__lgt_303	;
self.final_score_304	:= 	woFDN_FL_PS__lgt_304	;
self.final_score_305	:= 	woFDN_FL_PS__lgt_305	;
self.final_score_306	:= 	woFDN_FL_PS__lgt_306	;
self.final_score_307	:= 	woFDN_FL_PS__lgt_307	;
self.final_score_308	:= 	woFDN_FL_PS__lgt_308	;
self.final_score_309	:= 	woFDN_FL_PS__lgt_309	;
self.final_score_310	:= 	woFDN_FL_PS__lgt_310	;
self.final_score_311	:= 	woFDN_FL_PS__lgt_311	;
self.final_score_312	:= 	woFDN_FL_PS__lgt_312	;
self.final_score_313	:= 	woFDN_FL_PS__lgt_313	;
// self.woFDN_submodel_lgt	:= 	woFDN_FL_PS__lgt	;
self.FP3_woFDN_LGT		:= 	woFDN_FL_PS__lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
