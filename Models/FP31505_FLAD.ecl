
export FP31505_FLAD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   woFDN_FLA__D_lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FLA__D_lgt_1 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 51.85) => 0.4528145455,
      (c_fammar_p > 51.85) => 0.0923465848,
      (c_fammar_p = NULL) => 0.1566308314, 0.1566308314),
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0358052230,
      (f_varrisktype_i > 3.5) => 0.1560571553,
      (f_varrisktype_i = NULL) => -0.0276126587, -0.0276126587),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0153907167, -0.0153907167),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.1926921169,
   (f_inq_Communications_count_i > 0.5) => 0.5856528605,
   (f_inq_Communications_count_i = NULL) => 0.3328252499, 0.3328252499),
(f_inq_HighRiskCredit_count_i = NULL) => 0.2096712380, -0.0011005263);

// Tree: 2 
woFDN_FLA__D_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1270877651,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0370692169,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1617523518,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0326847629, -0.0326847629),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0237127434, -0.0237127434),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0486324315,
   (f_rel_under500miles_cnt_d > 5.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.1862981537,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.4555476173,
      (nf_seg_FraudPoint_3_0 = '') => 0.3359607545, 0.3359607545),
   (f_rel_under500miles_cnt_d = NULL) => 0.1039424878, 0.2037686082),
(f_varrisktype_i = NULL) => 0.1325655406, -0.0084948990);

// Tree: 3 
woFDN_FLA__D_lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 1.75) => 0.2815280596,
      (C_INC_150K_P > 1.75) => 0.0505040019,
      (C_INC_150K_P = NULL) => -0.0145173653, 0.0914296156),
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0304477213,
      (f_varrisktype_i > 3.5) => 0.0940136264,
      (f_varrisktype_i = NULL) => -0.0245183615, -0.0245183615),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0169602997, -0.0169602997),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.1099041063,
   (f_srchvelocityrisktype_i > 4.5) => 0.3263269987,
   (f_srchvelocityrisktype_i = NULL) => 0.1978411732, 0.1978411732),
(f_inq_Communications_count_i = NULL) => 0.1160023766, -0.0076663564);

// Tree: 4 
woFDN_FLA__D_lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 61.05) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0240929623,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.1475651814,
         (nf_seg_FraudPoint_3_0 = '') => 0.0606820453, 0.0606820453),
      (c_fammar_p > 61.05) => -0.0305146281,
      (c_fammar_p = NULL) => -0.0366127271, -0.0160408582),
   (f_assocsuspicousidcount_i > 15.5) => 0.4271720907,
   (f_assocsuspicousidcount_i = NULL) => -0.0136734622, -0.0136734622),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 35.5) => 0.2311445656,
   (r_pb_order_freq_d > 35.5) => 0.0423250714,
   (r_pb_order_freq_d = NULL) => 0.2775876627, 0.1891803860),
(f_srchfraudsrchcount_i = NULL) => 0.1159769979, -0.0065182441);

// Tree: 5 
woFDN_FLA__D_lgt_5 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.35) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0497652741,
      (f_rel_felony_count_i > 2.5) => 0.3671597521,
      (f_rel_felony_count_i = NULL) => 0.0615206252, 0.0615206252),
   (c_fammar_p > 59.35) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.3306836230,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0316640541,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0295876712, -0.0295876712),
   (c_fammar_p = NULL) => -0.0274422974, -0.0172260108),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1845063780,
   (r_I60_inq_comm_recency_d > 549) => 0.0652623485,
   (r_I60_inq_comm_recency_d = NULL) => 0.0957741571, 0.0957741571),
(f_srchvelocityrisktype_i = NULL) => 0.0736380757, -0.0059910912);

// Tree: 6 
woFDN_FLA__D_lgt_6 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.1072853795,
   (f_inq_Communications_count_i > 0.5) => 0.2323151876,
   (f_inq_Communications_count_i = NULL) => 0.1469582994, 0.1469582994),
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.0509197383,
      (r_F01_inp_addr_address_score_d > 95) => -0.0377479180,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0293461606, -0.0293461606),
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0418913305,
      (f_rel_felony_count_i > 0.5) => 0.2311273492,
      (f_rel_felony_count_i = NULL) => 0.0735988127, 0.0735988127),
   (k_inq_per_addr_i = NULL) => -0.0180625184, -0.0180625184),
(r_D33_Eviction_Recency_d = NULL) => 0.0661236867, -0.0100633493);

// Tree: 7 
woFDN_FLA__D_lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 3.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1180212369,
      (r_F00_dob_score_d > 92) => -0.0300269118,
      (r_F00_dob_score_d = NULL) => 0.0269693375, -0.0240263427),
   (f_srchvelocityrisktype_i > 3.5) => 0.0536333911,
   (f_srchvelocityrisktype_i = NULL) => -0.0140681533, -0.0140681533),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < c_employees and c_employees <= 38.5) => 0.2942450683,
   (c_employees > 38.5) => 0.0759658147,
   (c_employees = NULL) => 0.1180245002, 0.1180245002),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.031302406) => -0.0286435698,
   (f_add_input_nhood_VAC_pct_i > 0.031302406) => 0.2219272195,
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0531216351, 0.0531216351), -0.0087402454);

// Tree: 8 
woFDN_FLA__D_lgt_8 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0506704482,
      (f_rel_felony_count_i > 1.5) => 0.2699886882,
      (f_rel_felony_count_i = NULL) => 0.0673462335, 0.0673462335),
   (r_F01_inp_addr_address_score_d > 95) => -0.0297642382,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0207175440, -0.0207175440),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0416887742,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 3.5) => 0.1499755759,
      (f_assoccredbureaucount_i > 3.5) => 0.3126648837,
      (f_assoccredbureaucount_i = NULL) => 0.1836573467, 0.1836573467),
   (f_rel_felony_count_i = NULL) => 0.0687304071, 0.0687304071),
(f_varrisktype_i = NULL) => 0.0355224165, -0.0104334510);

// Tree: 9 
woFDN_FLA__D_lgt_9 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1559630712,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 58.25) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 1.95) => -0.0016061045,
         (c_hh5_p > 1.95) => 0.1953617831,
         (c_hh5_p = NULL) => 0.1289921688, 0.1289921688),
      (r_F01_inp_addr_address_score_d > 75) => 0.0440038626,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0535217253, 0.0535217253),
   (c_fammar_p > 58.25) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0352112264,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.0272158991,
      (nf_seg_FraudPoint_3_0 = '') => -0.0234461378, -0.0234461378),
   (c_fammar_p = NULL) => -0.0425760924, -0.0134377028),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0696342582, -0.0072941507);

// Tree: 10 
woFDN_FLA__D_lgt_10 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.1051525766,
   (f_rel_felony_count_i > 1.5) => 0.2885485989,
   (f_rel_felony_count_i = NULL) => 0.1340013891, 0.1340013891),
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 2.5) => -0.0219507366,
   (k_inq_per_addr_i > 2.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 85.5) => 0.1233020049,
      (c_lux_prod > 85.5) => 0.0135031970,
      (c_lux_prod = NULL) => 0.0476778645, 0.0476778645),
   (k_inq_per_addr_i = NULL) => -0.0107070070, -0.0107070070),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0244162218,
   (c_pop_35_44_p > 16.05) => 0.1584321345,
   (c_pop_35_44_p = NULL) => 0.0610713214, 0.0610713214), -0.0056329423);

// Tree: 11 
woFDN_FLA__D_lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2670374181,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0239560090,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0222967068, -0.0222967068),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => 0.0483576425,
      (r_D33_eviction_count_i > 1.5) => 0.2083218345,
      (r_D33_eviction_count_i = NULL) => 0.0580893044, 0.0580893044),
   (f_inq_Communications_count_i = NULL) => 0.0338482858, -0.0145157450),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => 0.1011764706,
   (r_C23_inp_addr_occ_index_d > 3.5) => 0.2613582508,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.1151172058, 0.1151172058),
(k_inq_ssns_per_addr_i = NULL) => -0.0084863055, -0.0084863055);

// Tree: 12 
woFDN_FLA__D_lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 9.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => -0.0290370000,
      (f_assocrisktype_i > 4.5) => 0.0368442775,
      (f_assocrisktype_i = NULL) => -0.0188656515, -0.0188656515),
   (f_addrchangecrimediff_i > 9.5) => 0.0987672830,
   (f_addrchangecrimediff_i = NULL) => -0.0008175424, -0.0108731429),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 0.1513497817,
   (f_mos_inq_banko_om_fseen_d > 36.5) => 0.0421579518,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0871015503, 0.0871015503),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_rural_p and c_rural_p <= 0.1) => 0.1006491798,
   (c_rural_p > 0.1) => -0.0491609793,
   (c_rural_p = NULL) => 0.0546951433, 0.0546951433), -0.0070588905);

// Tree: 13 
woFDN_FLA__D_lgt_13 := map(
(NULL < c_fammar_p and c_fammar_p <= 51.45) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0403913062,
   (f_rel_criminal_count_i > 2.5) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.1754719491,
      (r_E57_br_source_count_d > 0.5) => 0.0285960647,
      (r_E57_br_source_count_d = NULL) => 0.1191545088, 0.1191545088),
   (f_rel_criminal_count_i = NULL) => 0.0648687171, 0.0648687171),
(c_fammar_p > 51.45) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => -0.0176274136,
      (f_inq_PrepaidCards_count_i > 1.5) => 0.1316811370,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0163070528, -0.0163070528),
   (f_assocsuspicousidcount_i > 13.5) => 0.1795641714,
   (f_assocsuspicousidcount_i = NULL) => 0.0230685740, -0.0142369783),
(c_fammar_p = NULL) => -0.0557723261, -0.0085692047);

// Tree: 14 
woFDN_FLA__D_lgt_14 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.75) => 0.0683460069,
   (c_unemp > 7.75) => 0.1871727560,
   (c_unemp = NULL) => 0.0915876024, 0.0915876024),
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => -0.0170681218,
      (r_L79_adls_per_addr_c6_i > 4.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 95506) => 0.2668341885,
         (r_L80_Inp_AVM_AutoVal_d > 95506) => 0.0852355657,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0266472526, 0.0695579610),
      (r_L79_adls_per_addr_c6_i = NULL) => -0.0131487241, -0.0131487241),
   (f_srchfraudsrchcountmo_i > 0.5) => 0.0902883293,
   (f_srchfraudsrchcountmo_i = NULL) => -0.0096342869, -0.0096342869),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0135178932, -0.0063245510);

// Tree: 15 
woFDN_FLA__D_lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1944086323) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => 0.0233285517,
      (f_crim_rel_under500miles_cnt_i > 2.5) => 0.1146567771,
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0492216090, 0.0492216090),
   (f_add_curr_nhood_VAC_pct_i > 0.1944086323) => 0.2080619090,
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0619718458, 0.0619718458),
(c_fammar_p > 50.45) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1546958398,
      (r_F00_input_dob_match_level_d > 4.5) => -0.0199052865,
      (r_F00_input_dob_match_level_d = NULL) => -0.0170215314, -0.0170215314),
   (f_srchfraudsrchcount_i > 12.5) => 0.0916488279,
   (f_srchfraudsrchcount_i = NULL) => 0.0469092722, -0.0147948624),
(c_fammar_p = NULL) => -0.0395295462, -0.0089890359);

// Tree: 16 
woFDN_FLA__D_lgt_16 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 6.5) => -0.0147574665,
      (f_varrisktype_i > 6.5) => 0.1280251974,
      (f_varrisktype_i = NULL) => -0.0138124860, -0.0138124860),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 87.05) => 0.1398034893,
      (c_occunit_p > 87.05) => 0.0405341404,
      (c_occunit_p = NULL) => -0.0675791829, 0.0557065726),
   (r_F01_inp_addr_not_verified_i = NULL) => -0.0088547827, -0.0088547827),
(r_D30_Derog_Count_i > 5.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.95) => 0.0770117397,
   (c_unemp > 7.95) => 0.2243335452,
   (c_unemp = NULL) => 0.0948251606, 0.0948251606),
(r_D30_Derog_Count_i = NULL) => 0.0195703407, -0.0033912882);

// Tree: 17 
woFDN_FLA__D_lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 22500) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 78.5) => 0.1534552436,
      (c_rest_indx > 78.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => -0.0053310056,
         (f_srchvelocityrisktype_i > 5.5) => 0.1705382451,
         (f_srchvelocityrisktype_i = NULL) => 0.0139578799, 0.0139578799),
      (c_rest_indx = NULL) => 0.0496692050, 0.0496692050),
   (k_estimated_income_d > 22500) => -0.0238391392,
   (k_estimated_income_d = NULL) => -0.0124402927, -0.0192809545),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0305464164,
   (f_hh_payday_loan_users_i > 0.5) => 0.1249815013,
   (f_hh_payday_loan_users_i = NULL) => 0.0460466075, 0.0460466075),
(k_inq_per_addr_i = NULL) => -0.0120812752, -0.0120812752);

// Tree: 18 
woFDN_FLA__D_lgt_18 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 0.0334359310,
      (f_assocrisktype_i > 8.5) => 0.1771707262,
      (f_assocrisktype_i = NULL) => 0.0398039282, 0.0398039282),
   (r_C12_source_profile_index_d > 1.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0172419414,
      (f_varrisktype_i > 4.5) => 0.0827160178,
      (f_varrisktype_i = NULL) => -0.0156893738, -0.0156893738),
   (r_C12_source_profile_index_d = NULL) => -0.0093085639, -0.0093085639),
(r_D33_eviction_count_i > 2.5) => 0.1258280745,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_unemp and c_unemp <= 4.15) => -0.0376460182,
   (c_unemp > 4.15) => 0.1541611926,
   (c_unemp = NULL) => 0.0451201070, 0.0451201070), -0.0070851589);

// Tree: 19 
woFDN_FLA__D_lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.2144283796,
      (f_hh_age_18_plus_d > 0.5) => -0.0052507849,
      (f_hh_age_18_plus_d = NULL) => -0.0041703650, -0.0041703650),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 0.5) => 0.1644559138,
      (f_hh_workers_paw_d > 0.5) => 0.0337074289,
      (f_hh_workers_paw_d = NULL) => 0.0681507039, 0.0681507039),
   (f_rel_felony_count_i = NULL) => -0.0007969409, -0.0007969409),
(f_inq_PrepaidCards_count_i > 1.5) => 0.1285693605,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 101) => -0.0517370666,
   (c_burglary > 101) => 0.1001337650,
   (c_burglary = NULL) => 0.0140413827, 0.0140413827), 0.0007723373);

// Tree: 20 
woFDN_FLA__D_lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0176494905,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2) => 0.0210316830,
      (f_idverrisktype_i > 2) => 0.1440813055,
      (f_idverrisktype_i = NULL) => 0.0524879775, 0.0524879775),
   (k_inq_per_addr_i = NULL) => -0.0109378918, -0.0109378918),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 5.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 37) => 0.1617900898,
      (c_fammar_p > 37) => 0.0356068273,
      (c_fammar_p = NULL) => 0.0421831537, 0.0421831537),
   (r_L79_adls_per_addr_c6_i > 5.5) => 0.1723194863,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0534787216, 0.0534787216),
(f_varrisktype_i = NULL) => 0.0100174884, -0.0036535815);

// Tree: 21 
woFDN_FLA__D_lgt_21 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.45) => 0.2241849709,
      (r_C12_source_profile_d > 57.45) => -0.0032432265,
      (r_C12_source_profile_d = NULL) => 0.1093668518, 0.1093668518),
   (r_D33_Eviction_Recency_d > 30) => -0.0126679873,
   (r_D33_Eviction_Recency_d = NULL) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 82.5) => 0.0643614456,
      (c_born_usa > 82.5) => -0.0748919605,
      (c_born_usa = NULL) => 0.0004574852, 0.0004574852), -0.0114320705),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 58.25) => 0.1288210414,
   (c_fammar_p > 58.25) => 0.0360330588,
   (c_fammar_p = NULL) => 0.0580327902, 0.0580327902),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0079547204, -0.0079547204);

// Tree: 22 
woFDN_FLA__D_lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1830987115,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0261008121,
      (f_hh_lienholders_i > 0.5) => 0.0233069180,
      (f_hh_lienholders_i = NULL) => -0.0112158988, -0.0112158988),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0103662217, -0.0103662217),
(f_assocrisktype_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 0.1804489885,
   (r_C12_source_profile_index_d > 1.5) => 0.0671976977,
   (r_C12_source_profile_index_d = NULL) => 0.0791978345, 0.0791978345),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 60.5) => -0.0689839851,
   (c_bel_edu > 60.5) => 0.0605308053,
   (c_bel_edu = NULL) => 0.0096783722, 0.0096783722), -0.0058029487);

// Tree: 23 
woFDN_FLA__D_lgt_23 := map(
(NULL < c_fammar_p and c_fammar_p <= 58.25) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -15421) => 0.1279806501,
   (f_addrchangeincomediff_d > -15421) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 477.5) => 0.0741004462,
      (c_hh00 > 477.5) => -0.0153954851,
      (c_hh00 = NULL) => 0.0220090391, 0.0220090391),
   (f_addrchangeincomediff_d = NULL) => 0.0451068996, 0.0334282574),
(c_fammar_p > 58.25) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 140.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.1375481112,
      (r_D33_Eviction_Recency_d > 30) => -0.0275212201,
      (r_D33_Eviction_Recency_d = NULL) => -0.0255379030, -0.0262261644),
   (c_easiqlife > 140.5) => 0.0207801546,
   (c_easiqlife = NULL) => -0.0112958877, -0.0112958877),
(c_fammar_p = NULL) => -0.0337303218, -0.0056598670);

// Tree: 24 
woFDN_FLA__D_lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => -0.0153342146,
   (c_unemp > 8.95) => 0.0752981743,
   (c_unemp = NULL) => -0.0331350991, -0.0116799274),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_inq_Auto_count_i and f_inq_Auto_count_i <= 1.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 55.5) => 0.0407242571,
      (k_comb_age_d > 55.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.35) => 0.2924277816,
         (c_pop_55_64_p > 8.35) => 0.1034280331,
         (c_pop_55_64_p = NULL) => 0.1609914082, 0.1609914082),
      (k_comb_age_d = NULL) => 0.0613887161, 0.0613887161),
   (f_inq_Auto_count_i > 1.5) => -0.0417017004,
   (f_inq_Auto_count_i = NULL) => 0.0469225572, 0.0469225572),
(k_inq_per_addr_i = NULL) => -0.0053692460, -0.0053692460);

// Tree: 25 
woFDN_FLA__D_lgt_25 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0164633395,
(f_assocrisktype_i > 3.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 24.85) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1168735977,
      (r_D33_Eviction_Recency_d > 79.5) => 0.0173400646,
      (r_D33_Eviction_Recency_d = NULL) => 0.0204869094, 0.0204869094),
   (c_famotf18_p > 24.85) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 19.5) => 0.1776809218,
      (f_prevaddrlenofres_d > 19.5) => 0.0459416964,
      (f_prevaddrlenofres_d = NULL) => 0.0827337324, 0.0827337324),
   (c_famotf18_p = NULL) => -0.0060048196, 0.0288462937),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.6) => -0.0427780224,
   (c_pop_35_44_p > 15.6) => 0.0917631228,
   (c_pop_35_44_p = NULL) => 0.0191817156, 0.0191817156), -0.0049547785);

// Tree: 26 
woFDN_FLA__D_lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62494) => 0.0819307322,
   (f_addrchangevaluediff_d > -62494) => -0.0094152317,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 5.5) => -0.0064325522,
      (f_phones_per_addr_curr_i > 5.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 59180) => 0.1300860740,
         (f_curraddrmedianincome_d > 59180) => 0.0047344907,
         (f_curraddrmedianincome_d = NULL) => 0.0666412542, 0.0666412542),
      (f_phones_per_addr_curr_i = NULL) => 0.0115531487, 0.0115531487), -0.0029169509),
(r_D30_Derog_Count_i > 11.5) => 0.1239048026,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 72.5) => -0.0553874471,
   (c_burglary > 72.5) => 0.0862547552,
   (c_burglary = NULL) => 0.0226054111, 0.0226054111), -0.0008271238);

// Tree: 27 
woFDN_FLA__D_lgt_27 := map(
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1159555649,
   (r_F00_dob_score_d > 92) => -0.0192978522,
   (r_F00_dob_score_d = NULL) => -0.0099480889, -0.0160517974),
(nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 21.95) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.12781293955) => 0.0044775371,
      (f_add_curr_nhood_BUS_pct_i > 0.12781293955) => 0.1134476536,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0210132209, 0.0205039943),
   (c_famotf18_p > 21.95) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 0.1477285924,
      (r_I60_inq_recency_d > 4.5) => 0.0573739285,
      (r_I60_inq_recency_d = NULL) => 0.0711485052, 0.0711485052),
   (c_famotf18_p = NULL) => -0.0245408830, 0.0287397429),
(nf_seg_FraudPoint_3_0 = '') => -0.0060553566, -0.0060553566);

// Tree: 28 
woFDN_FLA__D_lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 29.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 6.5) => -0.0121603688,
      (f_inq_HighRiskCredit_count_i > 6.5) => 0.1307064174,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0093196854, -0.0093196854),
   (r_pb_order_freq_d > 29.5) => -0.0325430268,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0056372661,
      (f_assocrisktype_i > 4.5) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 0.0467973675,
         (f_phones_per_addr_curr_i > 9.5) => 0.1662030778,
         (f_phones_per_addr_curr_i = NULL) => 0.0638960372, 0.0638960372),
      (f_assocrisktype_i = NULL) => 0.0161093490, 0.0161093490), -0.0086881626),
(r_D33_eviction_count_i > 2.5) => 0.1045009759,
(r_D33_eviction_count_i = NULL) => 0.0114245057, -0.0071339176);

// Tree: 29 
woFDN_FLA__D_lgt_29 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1832053749,
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0343257281,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 51.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 0.0376335782,
         (r_L79_adls_per_addr_c6_i > 3.5) => 0.1340386884,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0500766986, 0.0500766986),
      (c_ab_av_edu > 51.5) => 0.0027421518,
      (c_ab_av_edu = NULL) => -0.0244406626, 0.0070693774),
   (nf_seg_FraudPoint_3_0 = '') => -0.0074430248, -0.0074430248),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 75.5) => -0.0831316411,
   (c_unempl > 75.5) => 0.0482329014,
   (c_unempl = NULL) => -0.0024837891, -0.0024837891), -0.0065733565);

// Tree: 30 
woFDN_FLA__D_lgt_30 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 12.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6762.5) => -0.0177423653,
   (f_addrchangeincomediff_d > 6762.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0278853144,
      (f_inq_Communications_count_i > 0.5) => 0.1783277543,
      (f_inq_Communications_count_i = NULL) => 0.0469554829, 0.0469554829),
   (f_addrchangeincomediff_d = NULL) => 0.0032471036, -0.0108036374),
(f_srchaddrsrchcount_i > 12.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 60.5) => 0.0327098292,
   (k_comb_age_d > 60.5) => 0.2424718992,
   (k_comb_age_d = NULL) => 0.0546482475, 0.0546482475),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.7) => 0.0709278420,
   (c_construction > 4.7) => -0.0388865007,
   (c_construction = NULL) => 0.0082773516, 0.0082773516), -0.0077132740);

// Tree: 31 
woFDN_FLA__D_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1481976450,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => -0.0076395385,
      (k_comb_age_d > 69.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 59.45) => 0.2124621118,
         (c_fammar_p > 59.45) => 0.0647380457,
         (c_fammar_p = NULL) => 0.0818269480, 0.0818269480),
      (k_comb_age_d = NULL) => -0.0019166279, -0.0019166279),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0012775872, -0.0012775872),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1603554757,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 105) => -0.0361398903,
   (c_assault > 105) => 0.0836627117,
   (c_assault = NULL) => 0.0082902138, 0.0082902138), -0.0004649824);

// Tree: 32 
woFDN_FLA__D_lgt_32 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => -0.0077259845,
(f_phones_per_addr_curr_i > 8.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 12.5) => 0.0160388511,
   (f_rel_count_i > 12.5) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.9813037139) => 
         map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0130352161,
         (f_sourcerisktype_i > 4.5) => 0.1223194915,
         (f_sourcerisktype_i = NULL) => 0.0599657618, 0.0599657618),
      (f_add_input_nhood_SFD_pct_d > 0.9813037139) => 0.2556762888,
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.0795012953, 0.0795012953),
   (f_rel_count_i = NULL) => 0.0406121517, 0.0406121517),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.8) => 0.0750860181,
   (c_construction > 4.8) => -0.0363861408,
   (c_construction = NULL) => 0.0139561245, 0.0139561245), -0.0019872097);

// Tree: 33 
woFDN_FLA__D_lgt_33 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 24.45) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 119.5) => 0.1952172158,
   (r_D32_Mos_Since_Fel_LS_d > 119.5) => 
      map(
      (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0278176659,
      (f_crim_rel_under100miles_cnt_i > 0.5) => 0.0068428410,
      (f_crim_rel_under100miles_cnt_i = NULL) => 0.0499157164, -0.0106439935),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0379502609, -0.0099926445),
(c_famotf18_p > 24.45) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 1.5) => 0.0556740463,
      (k_inq_per_addr_i > 1.5) => 0.1920657697,
      (k_inq_per_addr_i = NULL) => 0.0988647587, 0.0988647587),
   (f_prevaddrlenofres_d > 3.5) => 0.0237489992,
   (f_prevaddrlenofres_d = NULL) => 0.0328908766, 0.0328908766),
(c_famotf18_p = NULL) => -0.0389169565, -0.0055126401);

// Tree: 34 
woFDN_FLA__D_lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1183404603,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 112) => 0.0331351589,
      (f_fp_prevaddrburglaryindex_i > 112) => 0.2270561928,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0851139927, 0.0851139927),
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 78.5) => -0.0100547139,
      (r_pb_order_freq_d > 78.5) => -0.0310818084,
      (r_pb_order_freq_d = NULL) => 0.0151899059, -0.0070813414),
   (r_F00_dob_score_d = NULL) => 0.0315607653, -0.0035875780),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.3) => -0.0584103139,
   (c_hh4_p > 11.3) => 0.0729664781,
   (c_hh4_p = NULL) => 0.0184495780, 0.0184495780), -0.0026020320);

// Tree: 35 
woFDN_FLA__D_lgt_35 := map(
(NULL < c_born_usa and c_born_usa <= 34.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 123.5) => -0.0016728756,
   (r_C13_max_lres_d > 123.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -1) => 0.2345462089,
      (f_addrchangecrimediff_i > -1) => 0.0521156137,
      (f_addrchangecrimediff_i = NULL) => 0.1060631655, 0.0721471481),
   (r_C13_max_lres_d = NULL) => 0.0313857759, 0.0313857759),
(c_born_usa > 34.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0211762700,
   (k_inq_ssns_per_addr_i > 1.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 652.5) => -0.0079846728,
      (r_A50_pb_total_dollars_d > 652.5) => 0.0673643879,
      (r_A50_pb_total_dollars_d = NULL) => 0.0294982921, 0.0294982921),
   (k_inq_ssns_per_addr_i = NULL) => -0.0149526186, -0.0149526186),
(c_born_usa = NULL) => -0.0084912174, -0.0048488406);

// Tree: 36 
woFDN_FLA__D_lgt_36 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4) => 0.0562278823,
   (f_srchvelocityrisktype_i > 4) => 0.2231638001,
   (f_srchvelocityrisktype_i = NULL) => 0.0969439599, 0.0969439599),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => -0.0188129648,
   (f_crim_rel_under500miles_cnt_i > 2.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 34.5) => 0.0313126501,
      (r_pb_order_freq_d > 34.5) => -0.0253407449,
      (r_pb_order_freq_d = NULL) => 0.0396073546, 0.0129955216),
   (f_crim_rel_under500miles_cnt_i = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 0.1843734275,
      (c_bigapt_p > 1.15) => -0.0198502580,
      (c_bigapt_p = NULL) => 0.0383714068, 0.0383714068), -0.0115408587),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0063908636, -0.0097149827);

// Tree: 37 
woFDN_FLA__D_lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0093504060,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 14.35) => 0.0092999399,
      (c_hh5_p > 14.35) => 0.1152021295,
      (c_hh5_p = NULL) => 0.0193990183, 0.0193990183),
   (f_varrisktype_i > 2.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 3.35) => 0.1248005704,
      (c_rnt500_p > 3.35) => 0.0185578501,
      (c_rnt500_p = NULL) => 0.0656954249, 0.0656954249),
   (f_varrisktype_i = NULL) => 0.0246205063, 0.0246205063),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0755485428,
   (k_comb_age_d > 26.5) => 0.0489305799,
   (k_comb_age_d = NULL) => 0.0046994196, 0.0046994196), 0.0013630209);

// Tree: 38 
woFDN_FLA__D_lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 
      map(
      (NULL < c_employees and c_employees <= 79.5) => 0.1901215770,
      (c_employees > 79.5) => 0.0416510998,
      (c_employees = NULL) => 0.0777168027, 0.0777168027),
   (r_F00_input_dob_match_level_d > 5.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4) => 0.0336581449,
         (f_srchvelocityrisktype_i > 4) => 0.1868909149,
         (f_srchvelocityrisktype_i = NULL) => 0.0727325012, 0.0727325012),
      (r_D32_Mos_Since_Crim_LS_d > 9.5) => -0.0088109807,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0074706868, -0.0074706868),
   (r_F00_input_dob_match_level_d = NULL) => -0.0056616861, -0.0056616861),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1186253597,
(f_inq_PrepaidCards_count_i = NULL) => 0.0071815549, -0.0048081174);

// Tree: 39 
woFDN_FLA__D_lgt_39 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0061048443,
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1317648583) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 166.5) => 
         map(
         (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => -0.0020884763,
         (f_inq_Collection_count24_i > 2.5) => 0.0968783994,
         (f_inq_Collection_count24_i = NULL) => 0.0054149979, 0.0054149979),
      (c_born_usa > 166.5) => 0.1121575422,
      (c_born_usa = NULL) => 0.0149566643, 0.0149566643),
   (f_add_curr_nhood_BUS_pct_i > 0.1317648583) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 6290) => 0.0412786808,
      (r_A50_pb_total_dollars_d > 6290) => 0.1971193763,
      (r_A50_pb_total_dollars_d = NULL) => 0.1042291095, 0.1042291095),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0544336853, 0.0275830852),
(f_srchvelocityrisktype_i = NULL) => -0.0024356653, -0.0016626734);

// Tree: 40 
woFDN_FLA__D_lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 2.1) => 0.1967819112,
      (c_hval_400k_p > 2.1) => 0.0280270555,
      (c_hval_400k_p = NULL) => 0.0859057870, 0.0859057870),
   (r_F00_dob_score_d > 98) => -0.0074342533,
   (r_F00_dob_score_d = NULL) => 0.0062780482, -0.0047231071),
(f_addrchangecrimediff_i > 98) => 0.1198398512,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => -0.0021525351,
   (r_L79_adls_per_addr_c6_i > 3.5) => 
      map(
      (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.0791469919,
      (f_curraddractivephonelist_d > 0.5) => -0.0441230114,
      (f_curraddractivephonelist_d = NULL) => 0.1347319031, 0.0579691544),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0037876933, 0.0037876933), -0.0019455890);

// Tree: 41 
woFDN_FLA__D_lgt_41 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1433625437,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 
      map(
      (NULL < c_construction and c_construction <= 5) => 0.1797892545,
      (c_construction > 5) => 0.0221179590,
      (c_construction = NULL) => 0.0939032643, 0.0939032643),
   (r_I60_inq_comm_recency_d > 4.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0096572144,
      (f_nae_nothing_found_i > 0.5) => 0.1286082236,
      (f_nae_nothing_found_i = NULL) => -0.0080202736, -0.0080202736),
   (r_I60_inq_comm_recency_d = NULL) => -0.0069894206, -0.0069894206),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.05) => -0.0520883547,
   (c_hh4_p > 11.05) => 0.0578128567,
   (c_hh4_p = NULL) => 0.0186699595, 0.0186699595), -0.0059797664);

// Tree: 42 
woFDN_FLA__D_lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1488174519,
(r_D32_Mos_Since_Fel_LS_d > 125) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.25) => 0.1866305937,
      (c_pop_0_5_p > 8.25) => 0.0115469094,
      (c_pop_0_5_p = NULL) => 0.0811708307, 0.0811708307),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < c_employees and c_employees <= 40.5) => 0.0351333736,
      (c_employees > 40.5) => -0.0120007730,
      (c_employees = NULL) => -0.0375580124, -0.0067929210),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0055680555, -0.0055680555),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_mort_indx and c_mort_indx <= 73) => 0.0750521096,
   (c_mort_indx > 73) => -0.0248629656,
   (c_mort_indx = NULL) => 0.0076094338, 0.0076094338), -0.0045065581);

// Tree: 43 
woFDN_FLA__D_lgt_43 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0060092211,
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 10.05) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 70.05) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 1497.5) => 0.0344869988,
         (r_A50_pb_total_dollars_d > 1497.5) => 0.1194322534,
         (r_A50_pb_total_dollars_d = NULL) => 0.0820058789, 0.0820058789),
      (c_fammar_p > 70.05) => 0.0257787358,
      (c_fammar_p = NULL) => 0.0510465509, 0.0510465509),
   (c_incollege > 10.05) => -0.0335297067,
   (c_incollege = NULL) => 0.0324148342, 0.0324148342),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 0.2) => -0.0586728203,
   (c_high_hval > 0.2) => 0.0612108573,
   (c_high_hval = NULL) => 0.0098321383, 0.0098321383), -0.0022658742);

// Tree: 44 
woFDN_FLA__D_lgt_44 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => -0.0101141436,
   (r_L79_adls_per_addr_curr_i > 5.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 3.5) => 0.1766183963,
      (f_prevaddrageoldest_d > 3.5) => 0.0210643746,
      (f_prevaddrageoldest_d = NULL) => 0.0322196431, 0.0322196431),
   (r_L79_adls_per_addr_curr_i = NULL) => -0.0058125565, -0.0058125565),
(f_inq_PrepaidCards_count24_i > 0.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 90) => 0.1479064126,
   (c_burglary > 90) => 0.0249608898,
   (c_burglary = NULL) => 0.0678680521, 0.0678680521),
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => -0.0335903615,
   (c_hval_250k_p > 8.05) => 0.0720289584,
   (c_hval_250k_p = NULL) => 0.0145399615, 0.0145399615), -0.0046334522);

// Tree: 45 
woFDN_FLA__D_lgt_45 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 2.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 76.65) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -15303) => 0.1402672045,
      (f_addrchangeincomediff_d > -15303) => 0.0463872318,
      (f_addrchangeincomediff_d = NULL) => 
         map(
         (NULL < c_hval_100k_p and c_hval_100k_p <= 1.95) => 0.2016164937,
         (c_hval_100k_p > 1.95) => -0.0283449721,
         (c_hval_100k_p = NULL) => 0.0807393130, 0.0807393130), 0.0678704530),
   (c_fammar_p > 76.65) => 0.0124567665,
   (c_fammar_p = NULL) => -0.0251377411, 0.0324354844),
(f_corraddrnamecount_d > 2.5) => -0.0045817333,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13) => -0.0776802707,
   (c_pop_35_44_p > 13) => 0.0373502941,
   (c_pop_35_44_p = NULL) => 0.0011771605, 0.0011771605), -0.0002699382);

// Tree: 46 
woFDN_FLA__D_lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.15) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => -0.0123236568,
         (r_C14_Addr_Stability_v2_d > 4.5) => 0.0847749341,
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0357802323, 0.0357802323),
      (c_unemp > 9.15) => 0.1725505574,
      (c_unemp = NULL) => 0.0041587641, 0.0384391337),
   (f_corraddrnamecount_d > 1.5) => -0.0052372284,
   (f_corraddrnamecount_d = NULL) => -0.0017970277, -0.0017970277),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 7.05) => 0.1954624160,
   (C_INC_25K_P > 7.05) => 0.0392179532,
   (C_INC_25K_P = NULL) => 0.0850137441, 0.0850137441),
(r_D32_felony_count_i = NULL) => -0.0178337485, -0.0008540339);

// Tree: 47 
woFDN_FLA__D_lgt_47 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
      map(
      (NULL < c_rnt250_p and c_rnt250_p <= 12.25) => 0.0448590477,
      (c_rnt250_p > 12.25) => -0.0456915595,
      (c_rnt250_p = NULL) => -0.0140933516, 0.0293699261),
   (f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0116011379,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0079013741, -0.0058096060),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 4.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 241.75) => 0.0273324506,
      (c_housingcpi > 241.75) => 0.2640250076,
      (c_housingcpi = NULL) => 0.0593335150, 0.0593335150),
   (k_inq_per_addr_i > 4.5) => 0.2031729296,
   (k_inq_per_addr_i = NULL) => 0.0678229236, 0.0678229236),
(k_comb_age_d = NULL) => -0.0005969918, -0.0005969918);

// Tree: 48 
woFDN_FLA__D_lgt_48 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 124896) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 26.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -25287) => 0.1433526333,
      (f_addrchangevaluediff_d > -25287) => 0.0090995344,
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0037768021,
         (f_corrrisktype_i > 8.5) => 0.1498553840,
         (f_corrrisktype_i = NULL) => 0.0289108971, 0.0289108971), 0.0167003787),
   (f_rel_homeover50_count_d > 26.5) => 0.0989540017,
   (f_rel_homeover50_count_d = NULL) => 0.1440913172, 0.0234071265),
(r_L80_Inp_AVM_AutoVal_d > 124896) => -0.0053317451,
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => -0.0029958256,
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0876302102,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0153901831, -0.0081121466), -0.0022329704);

// Tree: 49 
woFDN_FLA__D_lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.0824811696,
      (r_F00_input_dob_match_level_d > 4.5) => -0.0002721700,
      (r_F00_input_dob_match_level_d = NULL) => 0.0011506043, 0.0011506043),
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 6.85) => 0.1353738502,
      (c_rnt500_p > 6.85) => 0.0086001391,
      (c_rnt500_p = NULL) => 0.0735205476, 0.0735205476),
   (f_varrisktype_i = NULL) => 0.0026702465, 0.0026702465),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0700671345,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 7.3) => 0.0665415413,
   (c_rnt500_p > 7.3) => -0.0457396009,
   (c_rnt500_p = NULL) => 0.0197577321, 0.0197577321), -0.0000126875);

// Tree: 50 
woFDN_FLA__D_lgt_50 := map(
(NULL < c_unemp and c_unemp <= 8.65) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 0.0802830872,
   (r_C10_M_Hdr_FS_d > 8.5) => -0.0040858428,
   (r_C10_M_Hdr_FS_d = NULL) => 
      map(
      (NULL < c_young and c_young <= 21.05) => 0.0830041572,
      (c_young > 21.05) => -0.0421954425,
      (c_young = NULL) => 0.0124218325, 0.0124218325), -0.0025866737),
(c_unemp > 8.65) => 
   map(
   (NULL < c_employees and c_employees <= 45.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.3) => 0.0377381678,
      (c_pop_35_44_p > 14.3) => 0.2131273070,
      (c_pop_35_44_p = NULL) => 0.1090118419, 0.1090118419),
   (c_employees > 45.5) => 0.0171037391,
   (c_employees = NULL) => 0.0474177125, 0.0474177125),
(c_unemp = NULL) => -0.0134399021, 0.0001856069);

// Tree: 51 
woFDN_FLA__D_lgt_51 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < c_employees and c_employees <= 71.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 160.5) => 0.0118331194,
      (f_curraddrcrimeindex_i > 160.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 171.5) => 
            map(
            (NULL < c_famotf18_p and c_famotf18_p <= 28.9) => 0.0850471326,
            (c_famotf18_p > 28.9) => 0.2627999636,
            (c_famotf18_p = NULL) => 0.1518715052, 0.1518715052),
         (f_M_Bureau_ADL_FS_all_d > 171.5) => 0.0345794240,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0785226545, 0.0785226545),
      (f_curraddrcrimeindex_i = NULL) => 0.0209563506, 0.0209563506),
   (c_employees > 71.5) => -0.0103539173,
   (c_employees = NULL) => -0.0235066322, -0.0041233290),
(f_bus_addr_match_count_d > 52.5) => 0.1996292847,
(f_bus_addr_match_count_d = NULL) => -0.0027580179, -0.0027580179);

// Tree: 52 
woFDN_FLA__D_lgt_52 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 19.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 191.5) => 
         map(
         (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 0.0049483704,
         (f_dl_addrs_per_adl_i > 0.5) => -0.0328679226,
         (f_dl_addrs_per_adl_i = NULL) => -0.0100476860, -0.0100476860),
      (c_unempl > 191.5) => 0.1128146559,
      (c_unempl = NULL) => 0.0179117642, -0.0086353449),
   (f_srchaddrsrchcount_i > 19.5) => 0.0872864859,
   (f_srchaddrsrchcount_i = NULL) => -0.0074594798, -0.0074594798),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.45) => 0.0251737750,
   (c_unemp > 9.45) => 0.1389516679,
   (c_unemp = NULL) => 0.0322351652, 0.0322351652),
(f_phones_per_addr_curr_i = NULL) => -0.0038535911, -0.0037880467);

// Tree: 53 
woFDN_FLA__D_lgt_53 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 120176) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 9.15) => 0.0476864173,
         (c_hval_200k_p > 9.15) => 0.2113050381,
         (c_hval_200k_p = NULL) => 0.0980306083, 0.0980306083),
      (r_L80_Inp_AVM_AutoVal_d > 120176) => 0.0368515050,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0042217904, 0.0184435753),
   (r_Ever_Asset_Owner_d > 0.5) => -0.0153028423,
   (r_Ever_Asset_Owner_d = NULL) => 0.0080862060, -0.0072024998),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 16.5) => 0.2291819982,
   (c_born_usa > 16.5) => 0.0482833232,
   (c_born_usa = NULL) => 0.0607734504, 0.0607734504),
(k_comb_age_d = NULL) => -0.0024331978, -0.0024331978);

// Tree: 54 
woFDN_FLA__D_lgt_54 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 142) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 113.5) => -0.0257916593,
      (c_rich_wht > 113.5) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.90454004005) => 
            map(
            (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 6.5) => 0.0493591654,
            (f_rel_homeover150_count_d > 6.5) => 0.1742751379,
            (f_rel_homeover150_count_d = NULL) => 0.0958964885, 0.0958964885),
         (f_add_curr_nhood_SFD_pct_d > 0.90454004005) => -0.0356908342,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0555803726, 0.0555803726),
      (c_rich_wht = NULL) => 0.0068962509, 0.0068962509),
   (f_prevaddrageoldest_d > 142) => 0.1311567983,
   (f_prevaddrageoldest_d = NULL) => 0.0271247121, 0.0271247121),
(r_F01_inp_addr_address_score_d > 25) => -0.0049205539,
(r_F01_inp_addr_address_score_d = NULL) => -0.0040447251, -0.0030611044);

// Tree: 55 
woFDN_FLA__D_lgt_55 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 40627.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 79.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.15327988195) => -0.0523686726,
         (f_add_curr_nhood_MFD_pct_i > 0.15327988195) => 0.0898795573,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0592494640, 0.0592494640),
      (r_I60_inq_comm_recency_d > 549) => 0.0103918786,
      (r_I60_inq_comm_recency_d = NULL) => 0.0170697931, 0.0170697931),
   (k_comb_age_d > 79.5) => 0.2628852230,
   (k_comb_age_d = NULL) => 0.0225276933, 0.0225276933),
(f_curraddrmedianincome_d > 40627.5) => -0.0127018901,
(f_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 114) => -0.0482495300,
   (c_totcrime > 114) => 0.0690928466,
   (c_totcrime = NULL) => -0.0100450353, -0.0100450353), -0.0061539744);

// Tree: 56 
woFDN_FLA__D_lgt_56 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 15.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 229.5) => 0.0096396428,
         (r_C21_M_Bureau_ADL_FS_d > 229.5) => 
            map(
            (NULL < c_fammar_p and c_fammar_p <= 63.75) => 0.1362287238,
            (c_fammar_p > 63.75) => 0.0643997432,
            (c_fammar_p = NULL) => 0.0191161416, 0.0697753471),
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0319934291, 0.0319934291),
      (f_srchaddrsrchcount_i > 15.5) => 0.1332849229,
      (f_srchaddrsrchcount_i = NULL) => 0.0354150990, 0.0354150990),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0807209125,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0249670582, 0.0249670582),
(f_corraddrnamecount_d > 3.5) => -0.0066631207,
(f_corraddrnamecount_d = NULL) => -0.0131810956, -0.0012389381);

// Tree: 57 
woFDN_FLA__D_lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 241.75) => -0.0119458976,
   (c_housingcpi > 241.75) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => 0.0815955962,
      (r_F03_address_match_d > 3) => 0.0038883625,
      (r_F03_address_match_d = NULL) => 0.0227253449, 0.0227253449),
   (c_housingcpi = NULL) => -0.0220247699, -0.0063279241),
(r_D30_Derog_Count_i > 11.5) => 0.0724918675,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => -0.0899982118,
   (k_comb_age_d > 24.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0270985607,
      (c_pop_35_44_p > 16.05) => 0.0892289527,
      (c_pop_35_44_p = NULL) => 0.0294033744, 0.0294033744),
   (k_comb_age_d = NULL) => -0.0045249452, -0.0045249452), -0.0052640965);

// Tree: 58 
woFDN_FLA__D_lgt_58 := map(
(NULL < c_hhsize and c_hhsize <= 2.615) => -0.0183144285,
(c_hhsize > 2.615) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -26.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 124.5) => 0.0234859554,
      (f_curraddrcartheftindex_i > 124.5) => 0.1848158706,
      (f_curraddrcartheftindex_i = NULL) => 0.0821513791, 0.0821513791),
   (f_addrchangecrimediff_i > -26.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 0.1815428218,
      (f_mos_liens_unrel_SC_fseen_d > 66.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 13.5) => 0.0063462333,
         (f_rel_homeover500_count_d > 13.5) => 0.1563327828,
         (f_rel_homeover500_count_d = NULL) => 0.0857778796, 0.0094521914),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0113796646, 0.0113796646),
   (f_addrchangecrimediff_i = NULL) => 0.0047552551, 0.0119674615),
(c_hhsize = NULL) => -0.0463874982, -0.0042894187);

// Tree: 59 
woFDN_FLA__D_lgt_59 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0071351808,
   (f_nae_nothing_found_i > 0.5) => 0.1129859681,
   (f_nae_nothing_found_i = NULL) => -0.0055097921, -0.0055097921),
(f_divaddrsuspidcountnew_i > 2.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.95) => -0.0400946593,
   (c_pop_35_44_p > 12.95) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.3487641756) => 0.1884299613,
      (f_add_input_nhood_MFD_pct_i > 0.3487641756) => 0.0570335111,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.1202984686, 0.1202984686),
   (c_pop_35_44_p = NULL) => 0.0598906672, 0.0598906672),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 105) => -0.0694391333,
   (c_assault > 105) => 0.0514244077,
   (c_assault = NULL) => -0.0209346859, -0.0209346859), -0.0041124951);

// Tree: 60 
woFDN_FLA__D_lgt_60 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0064141253,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => 0.0149383353,
   (r_C13_Curr_Addr_LRes_d > 158.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 13.25) => 0.0662256840,
      (c_hval_175k_p > 13.25) => 0.3167783358,
      (c_hval_175k_p = NULL) => 0.1128803157, 0.1128803157),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0390358201, 0.0390358201),
(f_hh_collections_ct_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => -0.1135821785,
   (k_comb_age_d > 24.5) => 
      map(
      (NULL < c_young and c_young <= 21.2) => 0.0885873977,
      (c_young > 21.2) => -0.0292362755,
      (c_young = NULL) => 0.0296755611, 0.0296755611),
   (k_comb_age_d = NULL) => -0.0116020927, -0.0116020927), -0.0021905373);

// Tree: 61 
woFDN_FLA__D_lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 9) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0177409879) => -0.0041874463,
      (f_add_curr_nhood_BUS_pct_i > 0.0177409879) => 0.1287028677,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0851568891, 0.0851568891),
   (c_low_hval > 9) => -0.0445825656,
   (c_low_hval = NULL) => 0.0524539687, 0.0524539687),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0035232982,
   (c_lar_fam > 181.5) => 0.1180599618,
   (c_lar_fam = NULL) => -0.0207131021, -0.0025441835),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 95.5) => 0.0564066532,
   (c_rest_indx > 95.5) => -0.0463503033,
   (c_rest_indx = NULL) => -0.0135965234, -0.0135965234), -0.0016492290);

// Tree: 62 
woFDN_FLA__D_lgt_62 := map(
(NULL < c_easiqlife and c_easiqlife <= 135.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => -0.0216417204,
      (r_C14_Addr_Stability_v2_d > 3.5) => 0.0591666260,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0175324932, 0.0175324932),
   (f_corraddrnamecount_d > 3.5) => -0.0183208447,
   (f_corraddrnamecount_d = NULL) => 0.0359171589, -0.0118854231),
(c_easiqlife > 135.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 79.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 24.85) => 0.0153915229,
      (C_INC_25K_P > 24.85) => 0.1601444778,
      (C_INC_25K_P = NULL) => 0.0171147724, 0.0171147724),
   (k_comb_age_d > 79.5) => 0.1903790690,
   (k_comb_age_d = NULL) => 0.0200349572, 0.0200349572),
(c_easiqlife = NULL) => -0.0293494451, -0.0015332937);

// Tree: 63 
woFDN_FLA__D_lgt_63 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 6.65) => 0.0102973545,
   (c_hh5_p > 6.65) => 0.1419547975,
   (c_hh5_p = NULL) => 0.0564292932, 0.0564292932),
(f_M_Bureau_ADL_FS_noTU_d > 8.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0073705911,
   (c_hval_200k_p > 16.45) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 3.5) => 0.0210248462,
      (f_assocsuspicousidcount_i > 3.5) => 
         map(
         (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 4.5) => 0.1790925123,
         (f_rel_criminal_count_i > 4.5) => -0.0030301213,
         (f_rel_criminal_count_i = NULL) => 0.1163220901, 0.1163220901),
      (f_assocsuspicousidcount_i = NULL) => 0.0395274213, 0.0395274213),
   (c_hval_200k_p = NULL) => 0.0162366080, -0.0028435537),
(f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0081661869, -0.0017050262);

// Tree: 64 
woFDN_FLA__D_lgt_64 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 
   map(
   (NULL < c_retail and c_retail <= 12.8) => -0.0005052461,
   (c_retail > 12.8) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 34.2) => 0.2085867695,
      (c_high_ed > 34.2) => 0.0253668867,
      (c_high_ed = NULL) => 0.1225530854, 0.1225530854),
   (c_retail = NULL) => 0.0488038414, 0.0488038414),
(r_C21_M_Bureau_ADL_FS_d > 8.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => -0.0061322604,
   (k_comb_age_d > 69.5) => 0.0606342594,
   (k_comb_age_d = NULL) => -0.0019569588, -0.0019569588),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 1.85) => -0.0442504708,
   (c_hh6_p > 1.85) => 0.0464009493,
   (c_hh6_p = NULL) => -0.0053998622, -0.0053998622), -0.0008363187);

// Tree: 65 
woFDN_FLA__D_lgt_65 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 3.75) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 64.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 31164) => 0.0852963565,
      (r_A46_Curr_AVM_AutoVal_d > 31164) => -0.0071975909,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0115446092, -0.0078422113),
   (k_comb_age_d > 64.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 21.55) => 0.1663088628,
      (c_white_col > 21.55) => 0.0276041072,
      (c_white_col = NULL) => 0.0379841506, 0.0379841506),
   (k_comb_age_d = NULL) => -0.0026815467, -0.0026815467),
(c_hh7p_p > 3.75) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 0.0291618382,
   (f_srchfraudsrchcountmo_i > 0.5) => 0.1464301396,
   (f_srchfraudsrchcountmo_i = NULL) => 0.0337181225, 0.0337181225),
(c_hh7p_p = NULL) => -0.0103824978, 0.0017151734);

// Tree: 66 
woFDN_FLA__D_lgt_66 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 7.5) => -0.0078378707,
   (f_hh_age_18_plus_d > 7.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 14.85) => -0.0012460444,
      (C_INC_50K_P > 14.85) => 0.1557642621,
      (C_INC_50K_P = NULL) => 0.0623530670, 0.0623530670),
   (f_hh_age_18_plus_d = NULL) => 0.0060713959, -0.0060632026),
(c_hh3_p > 23.25) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -3931) => 0.1172044881,
   (f_addrchangeincomediff_d > -3931) => 0.0272284161,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 2.2) => 0.1562661148,
      (c_rnt750_p > 2.2) => -0.0044817632,
      (c_rnt750_p = NULL) => 0.0462376691, 0.0462376691), 0.0343699936),
(c_hh3_p = NULL) => -0.0082759474, 0.0000323715);

// Tree: 67 
woFDN_FLA__D_lgt_67 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6942.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 0.1144197903,
   (f_attr_arrest_recency_d > 99.5) => -0.0054700948,
   (f_attr_arrest_recency_d = NULL) => -0.0043461671, -0.0043461671),
(f_addrchangeincomediff_d > 6942.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.29619634885) => 0.0309587579,
   (f_add_curr_nhood_MFD_pct_i > 0.29619634885) => 
      map(
      (NULL < c_bargains and c_bargains <= 59) => 0.2488011378,
      (c_bargains > 59) => 0.0492602021,
      (c_bargains = NULL) => 0.1157738473, 0.1157738473),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0682625003, 0.0502329386),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 3.5) => 0.1028307282,
   (c_employees > 3.5) => 0.0011653463,
   (c_employees = NULL) => -0.0087219248, 0.0032445200), -0.0008761310);

// Tree: 68 
woFDN_FLA__D_lgt_68 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.15) => -0.0003357604,
   (c_pop_6_11_p > 8.15) => 0.1535727131,
   (c_pop_6_11_p = NULL) => 0.0760310394, 0.0760310394),
(f_attr_arrest_recency_d > 99.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 280.5) => -0.0050743577,
   (r_C13_Curr_Addr_LRes_d > 280.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.1884051757,
      (f_corraddrnamecount_d > 3.5) => 0.0341569509,
      (f_corraddrnamecount_d = NULL) => 0.0494041362, 0.0494041362),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0004808481, -0.0004808481),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_health and c_health <= 8.15) => 0.0400852148,
   (c_health > 8.15) => -0.0551412264,
   (c_health = NULL) => -0.0054318263, -0.0054318263), 0.0002328031);

// Tree: 69 
woFDN_FLA__D_lgt_69 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => -0.0069126158,
   (f_inq_Communications_count24_i > 2.5) => 0.0839197734,
   (f_inq_Communications_count24_i = NULL) => -0.0064117294, -0.0064117294),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 2.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 15.85) => 
         map(
         (NULL < c_rich_fam and c_rich_fam <= 127.5) => -0.0438949922,
         (c_rich_fam > 127.5) => 0.0604801607,
         (c_rich_fam = NULL) => -0.0050777866, -0.0050777866),
      (C_INC_25K_P > 15.85) => 0.1193290424,
      (C_INC_25K_P = NULL) => 0.0165766444, 0.0165766444),
   (f_inq_Banking_count24_i > 2.5) => 0.1413512495,
   (f_inq_Banking_count24_i = NULL) => 0.0346547832, 0.0346547832),
(f_varrisktype_i = NULL) => -0.0071747090, -0.0052831691);

// Tree: 70 
woFDN_FLA__D_lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 4.75) => -0.0833676463,
   (c_pop_35_44_p > 4.75) => -0.0051651734,
   (c_pop_35_44_p = NULL) => -0.0070155943, -0.0070155943),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.1445692679,
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 6.5) => 0.0265498429,
      (f_hh_members_ct_d > 6.5) => 
         map(
         (NULL < c_white_col and c_white_col <= 38.55) => 0.2793645455,
         (c_white_col > 38.55) => 0.0451509937,
         (c_white_col = NULL) => 0.1397670643, 0.1397670643),
      (f_hh_members_ct_d = NULL) => 0.0455240942, 0.0455240942),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0508300857, 0.0508300857),
(c_hval_750k_p = NULL) => 0.0148994056, -0.0021565911);

// Tree: 71 
woFDN_FLA__D_lgt_71 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0004049035,
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 24.5) => -0.0221673485,
      (f_mos_inq_banko_om_fseen_d > 24.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 88.35) => 0.1720438951,
         (c_occunit_p > 88.35) => 0.0739856955,
         (c_occunit_p = NULL) => 0.0956030713, 0.0956030713),
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0635011343, 0.0635011343),
   (f_current_count_d > 0.5) => -0.0127539021,
   (f_current_count_d = NULL) => 0.0285731281, 0.0285731281),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < c_finance and c_finance <= 5.3) => 0.0348793638,
   (c_finance > 5.3) => -0.0670939748,
   (c_finance = NULL) => -0.0027233048, -0.0027233048), 0.0028976670);

// Tree: 72 
woFDN_FLA__D_lgt_72 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 58.5) => 0.1108787105,
      (c_easiqlife > 58.5) => 0.0058106491,
      (c_easiqlife = NULL) => -0.0002502326, 0.0089979380),
   (f_historical_count_d > 0.5) => -0.0180089914,
   (f_historical_count_d = NULL) => -0.0048505971, -0.0048505971),
(f_assocsuspicousidcount_i > 15.5) => 0.0922715373,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 69.05) => 0.0542961854,
   (c_fammar_p > 69.05) => 
      map(
      (NULL < c_unattach and c_unattach <= 94.5) => 0.0126439295,
      (c_unattach > 94.5) => -0.1080436747,
      (c_unattach = NULL) => -0.0371636532, -0.0371636532),
   (c_fammar_p = NULL) => -0.0111807445, -0.0111807445), -0.0044439072);

// Tree: 73 
woFDN_FLA__D_lgt_73 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 156.5) => -0.0111654087,
(r_A50_pb_average_dollars_d > 156.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 53.5) => 
      map(
      (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => 0.0179847984,
      (f_phones_per_addr_c6_i > 0.5) => 
         map(
         (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 3.5) => 
            map(
            (NULL < c_newhouse and c_newhouse <= 53.55) => 0.0503338139,
            (c_newhouse > 53.55) => 0.1917919801,
            (c_newhouse = NULL) => 0.0745025458, 0.0745025458),
         (f_hh_tot_derog_i > 3.5) => 0.2521614673,
         (f_hh_tot_derog_i = NULL) => 0.0991133055, 0.0991133055),
      (f_phones_per_addr_c6_i = NULL) => 0.0448724385, 0.0448724385),
   (c_no_teens > 53.5) => 0.0015095305,
   (c_no_teens = NULL) => 0.0341045320, 0.0135695870),
(r_A50_pb_average_dollars_d = NULL) => -0.0051362635, -0.0004170563);

// Tree: 74 
woFDN_FLA__D_lgt_74 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 5.35) => 0.0034813796,
      (c_hval_125k_p > 5.35) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 48.5) => 0.1608723589,
         (r_C10_M_Hdr_FS_d > 48.5) => 0.0413514049,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0580665878, 0.0580665878),
      (c_hval_125k_p = NULL) => 0.0895663002, 0.0248273232),
   (f_hh_members_ct_d > 1.5) => -0.0061490110,
   (f_hh_members_ct_d = NULL) => 
      map(
      (NULL < c_assault and c_assault <= 90) => -0.0329787810,
      (c_assault > 90) => 0.0884819777,
      (c_assault = NULL) => 0.0154228747, 0.0154228747), -0.0001702057),
(r_L77_Add_PO_Box_i > 0.5) => -0.0879378287,
(r_L77_Add_PO_Box_i = NULL) => -0.0021490421, -0.0021490421);

// Tree: 75 
woFDN_FLA__D_lgt_75 := map(
(NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 81.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 4.55) => 
         map(
         (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 0.0910012249,
         (r_D32_criminal_count_i > 2.5) => 0.2374822309,
         (r_D32_criminal_count_i = NULL) => 0.1480857346, 0.1480857346),
      (c_hval_750k_p > 4.55) => -0.0279333132,
      (c_hval_750k_p = NULL) => 0.0860599749, 0.0860599749),
   (r_D32_Mos_Since_Crim_LS_d > 81.5) => 0.0104977404,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0197834897, 0.0197834897),
(r_I60_inq_recency_d > 4.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => -0.0100869762,
   (f_bus_addr_match_count_d > 52.5) => 0.1687491350,
   (f_bus_addr_match_count_d = NULL) => -0.0090270104, -0.0090270104),
(r_I60_inq_recency_d = NULL) => -0.0276831497, -0.0053773387);

// Tree: 76 
woFDN_FLA__D_lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0113559994,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 0.5) => 0.1451902114,
         (f_rel_educationover12_count_d > 0.5) => -0.0041568739,
         (f_rel_educationover12_count_d = NULL) => 0.0456317487, 0.0009032084),
      (f_prevaddrlenofres_d > 123.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0526597017,
         (f_rel_homeover500_count_d > 3.5) => 0.1972151085,
         (f_rel_homeover500_count_d = NULL) => 0.0759087661, 0.0759087661),
      (f_prevaddrlenofres_d = NULL) => 0.0210539552, 0.0210539552),
   (f_nae_nothing_found_i > 0.5) => 0.2062864221,
   (f_nae_nothing_found_i = NULL) => 0.0239490350, 0.0239490350),
(c_rnt1250_p = NULL) => -0.0016415642, -0.0013512784);

// Tree: 77 
woFDN_FLA__D_lgt_77 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2107300471,
   (r_C12_source_profile_d > 57.95) => -0.0078948447,
   (r_C12_source_profile_d = NULL) => 0.0709362461, 0.0709362461),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < c_transport and c_transport <= 29.05) => -0.0023133479,
   (c_transport > 29.05) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0218720102) => 0.2073805470,
      (f_add_input_nhood_BUS_pct_i > 0.0218720102) => 0.0430354651,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.1053136014, 0.1053136014),
   (c_transport = NULL) => -0.0000010473, -0.0005568135),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 111.5) => -0.0435248558,
   (c_for_sale > 111.5) => 0.0600937566,
   (c_for_sale = NULL) => 0.0031378306, 0.0031378306), 0.0006690730);

// Tree: 78 
woFDN_FLA__D_lgt_78 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0197053922,
      (f_varrisktype_i > 2.5) => 0.1785011534,
      (f_varrisktype_i = NULL) => 0.0777424217, 0.0777424217),
   (r_C13_max_lres_d > 18.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
         map(
         (NULL < c_incollege and c_incollege <= 6.25) => -0.0142125209,
         (c_incollege > 6.25) => 0.1358814029,
         (c_incollege = NULL) => 0.0553162820, 0.0553162820),
      (r_F00_dob_score_d > 95) => -0.0015947767,
      (r_F00_dob_score_d = NULL) => -0.0017554098, -0.0001680471),
   (r_C13_max_lres_d = NULL) => 0.0011148318, 0.0011148318),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0603225898,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0023053524, -0.0014095123);

// Tree: 79 
woFDN_FLA__D_lgt_79 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30362.5) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 25190) => -0.0014074263,
   (f_prevaddrmedianincome_d > 25190) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 63990) => -0.0621464228,
      (c_med_hval > 63990) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','6: Other']) => 0.0303237814,
         (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
            map(
            (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 35) => 0.2845498468,
            (r_pb_order_freq_d > 35) => 0.0907272473,
            (r_pb_order_freq_d = NULL) => 0.1043079256, 0.1441542408),
         (nf_seg_FraudPoint_3_0 = '') => 0.1001675358, 0.1001675358),
      (c_med_hval = NULL) => 0.0738847504, 0.0738847504),
   (f_prevaddrmedianincome_d = NULL) => 0.0282376729, 0.0282376729),
(f_curraddrmedianincome_d > 30362.5) => -0.0069658552,
(f_curraddrmedianincome_d = NULL) => -0.0153519201, -0.0038185701);

// Tree: 80 
woFDN_FLA__D_lgt_80 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0892453496,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 28.85) => -0.0132350410,
      (c_hval_20k_p > 28.85) => 0.1239939944,
      (c_hval_20k_p = NULL) => 0.0404595802, -0.0108638652),
   (r_C14_Addr_Stability_v2_d > 4.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 38.95) => 0.0045008747,
      (c_hval_750k_p > 38.95) => 0.0724475321,
      (c_hval_750k_p = NULL) => 0.0389048890, 0.0101016697),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0001311005, 0.0001311005),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 84) => -0.0382085831,
   (c_relig_indx > 84) => 0.0524095864,
   (c_relig_indx = NULL) => 0.0185008520, 0.0185008520), 0.0007965461);

// Tree: 81 
woFDN_FLA__D_lgt_81 := map(
(NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0122797991,
(f_inq_Other_count_i > 0.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 3.455) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 14.5) => 0.0203995268,
      (f_rel_ageover40_count_d > 14.5) => -0.1052292531,
      (f_rel_ageover40_count_d = NULL) => -0.0769266724, 0.0154649639),
   (c_hhsize > 3.455) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 8.15) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 31.1) => 0.2884220788,
         (C_RENTOCC_P > 31.1) => 0.0474297023,
         (C_RENTOCC_P = NULL) => 0.1604615249, 0.1604615249),
      (C_INC_200K_P > 8.15) => -0.0619079153,
      (C_INC_200K_P = NULL) => 0.0894640530, 0.0894640530),
   (c_hhsize = NULL) => 0.0198411124, 0.0198411124),
(f_inq_Other_count_i = NULL) => -0.0121160310, -0.0051086852);

// Tree: 82 
woFDN_FLA__D_lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3696198472) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 22.5) => -0.0001071318,
      (f_addrchangecrimediff_i > 22.5) => 
         map(
         (NULL < c_low_hval and c_low_hval <= 23.05) => 0.0227168145,
         (c_low_hval > 23.05) => 0.1878791070,
         (c_low_hval = NULL) => 0.0602536992, 0.0602536992),
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 3.655) => 0.0026694237,
         (c_hhsize > 3.655) => 0.1244538682,
         (c_hhsize = NULL) => -0.0623594594, 0.0044564801), 0.0020896712),
   (f_add_input_mobility_index_i > 0.3696198472) => -0.0246894846,
   (f_add_input_mobility_index_i = NULL) => 0.1432887017, -0.0018057936),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0727831100,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0055297884, -0.0023784196);

// Tree: 83 
woFDN_FLA__D_lgt_83 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0091574657,
   (f_srchaddrsrchcount_i > 1.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 7.35) => 0.1972347635,
         (c_incollege > 7.35) => 0.0129095127,
         (c_incollege = NULL) => 0.1017806157, 0.1017806157),
      (r_C10_M_Hdr_FS_d > 10.5) => 0.0138746948,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0156609507, 0.0156609507),
   (f_srchaddrsrchcount_i = NULL) => 
      map(
      (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 0.0551891392,
      (r_L77_Apartment_i > 0.5) => -0.0677211181,
      (r_L77_Apartment_i = NULL) => 0.0196659434, 0.0196659434), 0.0023823716),
(r_L77_Add_PO_Box_i > 0.5) => -0.0904983163,
(r_L77_Add_PO_Box_i = NULL) => 0.0002369997, 0.0002369997);

// Tree: 84 
woFDN_FLA__D_lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 309.5) => -0.0020163665,
(r_C13_Curr_Addr_LRes_d > 309.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 159.9) => 0.0367464739,
   (c_oldhouse > 159.9) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.75) => 0.0414925115,
      (r_C12_source_profile_d > 75.75) => 0.3079058070,
      (r_C12_source_profile_d = NULL) => 0.1581859385, 0.1581859385),
   (c_oldhouse = NULL) => 0.0573554153, 0.0573554153),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0902611560,
   (k_comb_age_d > 25.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 9.95) => 0.0120552782,
      (C_INC_125K_P > 9.95) => 0.1157111531,
      (C_INC_125K_P = NULL) => 0.0633988424, 0.0633988424),
   (k_comb_age_d = NULL) => 0.0129918588, 0.0129918588), 0.0015912293);

// Tree: 85 
woFDN_FLA__D_lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => -0.0082567188,
   (f_srchfraudsrchcount_i > 8.5) => -0.0481706604,
   (f_srchfraudsrchcount_i = NULL) => -0.0090484305, -0.0090484305),
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 7.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 25500) => 0.1395556501,
      (k_estimated_income_d > 25500) => 0.0054148082,
      (k_estimated_income_d = NULL) => 0.0126370358, 0.0126370358),
   (f_inq_Collection_count_i > 7.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 10.8) => 0.0197071340,
      (c_hval_250k_p > 10.8) => 0.1787083431,
      (c_hval_250k_p = NULL) => 0.0908392538, 0.0908392538),
   (f_inq_Collection_count_i = NULL) => 0.0204673613, 0.0204673613),
(f_util_adl_count_n = NULL) => -0.0009920936, -0.0053213872);

// Tree: 86 
woFDN_FLA__D_lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => -0.0032699045,
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 20.45) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 170.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 21.75) => 0.0002035579,
         (c_pop_35_44_p > 21.75) => 0.1627054909,
         (c_pop_35_44_p = NULL) => 0.0152500332, 0.0152500332),
      (f_curraddrcrimeindex_i > 170.5) => 0.1420930158,
      (f_curraddrcrimeindex_i = NULL) => 0.0269750148, 0.0269750148),
   (c_hval_300k_p > 20.45) => 0.1929799427,
   (c_hval_300k_p = NULL) => 0.0410215856, 0.0410215856),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0330330153,
   (c_construction > 7.45) => -0.0791058806,
   (c_construction = NULL) => -0.0096521128, -0.0096521128), -0.0010595055);

// Tree: 87 
woFDN_FLA__D_lgt_87 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 48.5) => 0.1771557645,
   (c_exp_prod > 48.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 5.45) => 0.1099711052,
      (c_newhouse > 5.45) => -0.0319960244,
      (c_newhouse = NULL) => 0.0157565556, 0.0157565556),
   (c_exp_prod = NULL) => 0.0503421003, 0.0503421003),
(r_F00_dob_score_d > 92) => -0.0069862409,
(r_F00_dob_score_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 155.5) => -0.0309906136,
   (c_totcrime > 155.5) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 820) => -0.0192662871,
      (c_popover25 > 820) => 0.1392464294,
      (c_popover25 = NULL) => 0.0607747876, 0.0607747876),
   (c_totcrime = NULL) => -0.0029650271, -0.0130337455), -0.0058998650);

// Tree: 88 
woFDN_FLA__D_lgt_88 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 107) => -0.0119643900,
   (c_rich_fam > 107) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 9.05) => 0.1911563594,
      (c_high_hval > 9.05) => 0.0397668533,
      (c_high_hval = NULL) => 0.1168132984, 0.1168132984),
   (c_rich_fam = NULL) => 0.0545015137, 0.0545015137),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => -0.0176248029,
   (f_crim_rel_under500miles_cnt_i > 0.5) => 0.0123847089,
   (f_crim_rel_under500miles_cnt_i = NULL) => 0.0031418876, -0.0016721304),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 16.7) => -0.0400093701,
   (c_retail > 16.7) => 0.0923341783,
   (c_retail = NULL) => 0.0075962229, 0.0075962229), -0.0005736817);

// Tree: 89 
woFDN_FLA__D_lgt_89 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 99.05) => 0.0151803196,
      (c_highrent > 99.05) => 
         map(
         (NULL < c_rental and c_rental <= 65.5) => 0.0371187027,
         (c_rental > 65.5) => 0.3971701790,
         (c_rental = NULL) => 0.2171444409, 0.2171444409),
      (c_highrent = NULL) => 0.0529634725, 0.0241963432),
   (r_C14_addrs_10yr_i > 0.5) => -0.0098848312,
   (r_C14_addrs_10yr_i = NULL) => -0.0015647892, -0.0015647892),
(r_D33_eviction_count_i > 3.5) => 0.0680810654,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1173.5) => 0.0591750648,
   (c_popover25 > 1173.5) => -0.0338919425,
   (c_popover25 = NULL) => 0.0144545548, 0.0144545548), -0.0009265721);

// Tree: 90 
woFDN_FLA__D_lgt_90 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 118) => 0.0812885512,
   (r_D32_Mos_Since_Fel_LS_d > 118) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 48.95) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 0.65) => 0.1333593701,
         (c_pop_25_34_p > 0.65) => -0.0020806320,
         (c_pop_25_34_p = NULL) => -0.0011670211, -0.0011670211),
      (c_hval_80k_p > 48.95) => -0.1249616089,
      (c_hval_80k_p = NULL) => 0.0016250843, -0.0016927944),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => 
      map(
      (NULL < c_employees and c_employees <= 436.5) => -0.0532203077,
      (c_employees > 436.5) => 0.0419338178,
      (c_employees = NULL) => -0.0155418284, -0.0155418284), -0.0014485647),
(k_inq_adls_per_addr_i > 4.5) => -0.0798283232,
(k_inq_adls_per_addr_i = NULL) => -0.0022332891, -0.0022332891);

// Tree: 91 
woFDN_FLA__D_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_child and c_child <= 24.25) => 0.1306058853,
      (c_child > 24.25) => -0.1307142332,
      (c_child = NULL) => 0.0108341643, 0.0108341643),
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','6: Other']) => 0.1242522352,
   (nf_seg_FraudPoint_3_0 = '') => 0.0612421958, 0.0612421958),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 62) => -0.0067175259,
   (c_famotf18_p > 62) => 0.1115710634,
   (c_famotf18_p = NULL) => -0.0037943614, -0.0061753532),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0866287789,
   (k_comb_age_d > 25.5) => 0.0332486987,
   (k_comb_age_d = NULL) => -0.0033805306, -0.0033805306), -0.0049877096);

// Tree: 92 
woFDN_FLA__D_lgt_92 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 94.35) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 141.5) => -0.0040646154,
   (f_curraddrcartheftindex_i > 141.5) => 
      map(
      (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 50.15) => 0.0688594587,
         (c_civ_emp > 50.15) => 0.0049491559,
         (c_civ_emp = NULL) => 0.0157401940, 0.0157401940),
      (f_hh_tot_derog_i > 4.5) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 41093) => -0.0114977326,
         (f_prevaddrmedianincome_d > 41093) => 0.2182176024,
         (f_prevaddrmedianincome_d = NULL) => 0.1202769557, 0.1202769557),
      (f_hh_tot_derog_i = NULL) => 0.0208251270, 0.0208251270),
   (f_curraddrcartheftindex_i = NULL) => -0.0109930784, 0.0012028482),
(C_RENTOCC_P > 94.35) => -0.1300149733,
(C_RENTOCC_P = NULL) => -0.0491082975, -0.0005973249);

// Tree: 93 
woFDN_FLA__D_lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0017853841,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_food and c_food <= 18.7) => 0.1396247677,
         (c_food > 18.7) => -0.0003275547,
         (c_food = NULL) => 0.0764604452, 0.0764604452),
      (r_D33_eviction_count_i = NULL) => 0.0025107586, 0.0025107586),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 58.5) => 0.0868051864,
      (r_pb_order_freq_d > 58.5) => -0.0462091627,
      (r_pb_order_freq_d = NULL) => 0.1260899455, 0.0735424884),
   (f_curraddrcartheftindex_i = NULL) => 0.0035241072, 0.0038312298),
(c_cartheft > 189.5) => -0.0567787239,
(c_cartheft = NULL) => -0.0097100310, 0.0015760106);

// Tree: 94 
woFDN_FLA__D_lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 0.85) => -0.0087905582,
   (c_hh7p_p > 0.85) => 
      map(
      (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.1335479860,
         (r_C21_M_Bureau_ADL_FS_d > 7.5) => 0.0382386393,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0429692090, 0.0429692090),
      (f_property_owners_ct_d > 0.5) => 0.0025979318,
      (f_property_owners_ct_d = NULL) => 0.0204779474, 0.0140709421),
   (c_hh7p_p = NULL) => -0.0005631761, -0.0005631761),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 61.5) => 0.0102841616,
   (r_I60_inq_recency_d > 61.5) => 0.1363476859,
   (r_I60_inq_recency_d = NULL) => 0.0647436041, 0.0647436041),
(c_famotf18_p = NULL) => -0.0020711940, 0.0000719899);

// Tree: 95 
woFDN_FLA__D_lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => -0.0092633130,
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2693884254) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 55.75) => 0.1408209085,
         (c_fammar_p > 55.75) => 0.0053620231,
         (c_fammar_p = NULL) => 0.0157659314, 0.0157659314),
      (f_add_curr_mobility_index_i > 0.2693884254) => -0.0142045629,
      (f_add_curr_mobility_index_i = NULL) => 0.0027613430, 0.0027613430),
   (f_rel_criminal_count_i > 2.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 32.5) => 0.2077847883,
      (c_born_usa > 32.5) => 0.0596089540,
      (c_born_usa = NULL) => 0.0869348871, 0.0869348871),
   (f_rel_criminal_count_i = NULL) => 0.0238184024, 0.0238184024),
(c_rnt1000_p = NULL) => -0.0180031517, -0.0053787905);

// Tree: 96 
woFDN_FLA__D_lgt_96 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => -0.0059496778,
   (f_inq_Communications_count24_i > 2.5) => 0.0960306562,
   (f_inq_Communications_count24_i = NULL) => -0.0052393670, -0.0052393670),
(f_srchfraudsrchcountmo_i > 0.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 14.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 327.5) => -0.0115789489,
      (f_M_Bureau_ADL_FS_all_d > 327.5) => 0.1479772841,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0202373237, 0.0202373237),
   (f_rel_educationover12_count_d > 14.5) => 0.1195107005,
   (f_rel_educationover12_count_d = NULL) => 0.0431815138, 0.0431815138),
(f_srchfraudsrchcountmo_i = NULL) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 21.8) => -0.0622043532,
   (c_hh1_p > 21.8) => 0.0476637004,
   (c_hh1_p = NULL) => 0.0002548828, 0.0002548828), -0.0034593762);

// Tree: 97 
woFDN_FLA__D_lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0019895670,
      (k_inq_adls_per_addr_i > 3.5) => -0.0640345003,
      (k_inq_adls_per_addr_i = NULL) => -0.0032214692, -0.0032214692),
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 9.8) => 0.1652202694,
      (C_INC_100K_P > 9.8) => 0.0211303855,
      (C_INC_100K_P = NULL) => 0.0590487760, 0.0590487760),
   (f_assoccredbureaucountnew_i = NULL) => -0.0020486483, -0.0020486483),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 11.5) => 0.1445164350,
   (f_rel_under500miles_cnt_d > 11.5) => 0.0099456593,
   (f_rel_under500miles_cnt_d = NULL) => 0.0683639805, 0.0683639805),
(r_D33_eviction_count_i = NULL) => -0.0182667809, -0.0015691154);

// Tree: 98 
woFDN_FLA__D_lgt_98 := map(
(NULL < c_hh4_p and c_hh4_p <= 10.15) => -0.0204467509,
(c_hh4_p > 10.15) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0015574603,
      (f_phones_per_addr_curr_i > 9.5) => 0.0402385952,
      (f_phones_per_addr_curr_i = NULL) => 0.0016870296, 0.0016870296),
   (f_rel_homeover500_count_d > 14.5) => 0.1106359028,
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 35.2) => 0.1470884834,
      (c_oldhouse > 35.2) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 1518) => 0.0494024438,
         (c_popover18 > 1518) => -0.1033023570,
         (c_popover18 = NULL) => -0.0024780334, -0.0024780334),
      (c_oldhouse = NULL) => 0.0338245193, 0.0338245193), 0.0035819081),
(c_hh4_p = NULL) => -0.0198966665, -0.0045591818);

// Tree: 99 
woFDN_FLA__D_lgt_99 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.38111460565) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 522392) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => -0.0085237803,
         (f_phones_per_addr_curr_i > 4.5) => 0.0510520751,
         (f_phones_per_addr_curr_i = NULL) => 0.0139107541, 0.0139107541),
      (c_med_hval > 522392) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 150.5) => 0.0583478490,
         (c_span_lang > 150.5) => 0.2211069609,
         (c_span_lang = NULL) => 0.1094328257, 0.1094328257),
      (c_med_hval = NULL) => -0.0296674394, 0.0229008685),
   (r_F03_address_match_d > 3.5) => 0.0017941544,
   (r_F03_address_match_d = NULL) => 0.0104750798, 0.0070697441),
(f_add_input_mobility_index_i > 0.38111460565) => -0.0250537917,
(f_add_input_mobility_index_i = NULL) => -0.0110939767, 0.0015774676);

// Tree: 100 
woFDN_FLA__D_lgt_100 := map(
(NULL < c_transport and c_transport <= 26.7) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 34.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0003822864,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0642123985,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0023441844, -0.0023441844),
   (f_rel_count_i > 34.5) => -0.0463436609,
   (f_rel_count_i = NULL) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.3) => -0.0814083167,
      (c_pop_35_44_p > 14.3) => 0.0410553138,
      (c_pop_35_44_p = NULL) => -0.0046529427, -0.0046529427), -0.0036608489),
(c_transport > 26.7) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => -0.0216053883,
   (f_sourcerisktype_i > 4.5) => 0.1650636952,
   (f_sourcerisktype_i = NULL) => 0.0474151132, 0.0474151132),
(c_transport = NULL) => 0.0181930844, -0.0022247048);

// Tree: 101 
woFDN_FLA__D_lgt_101 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0041619074,
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 303) => -0.0301831676,
      (r_C13_max_lres_d > 303) => 0.2037543358,
      (r_C13_max_lres_d = NULL) => 0.0802469583, 0.0802469583),
   (k_comb_age_d = NULL) => -0.0030624472, -0.0030624472),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 2.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 7.85) => 0.1301944241,
      (C_INC_35K_P > 7.85) => -0.1011527603,
      (C_INC_35K_P = NULL) => 0.0032605707, 0.0032605707),
   (f_assocrisktype_i > 2.5) => 0.2116530079,
   (f_assocrisktype_i = NULL) => 0.0706816533, 0.0706816533),
(f_nae_nothing_found_i = NULL) => -0.0020741542, -0.0020741542);

// Tree: 102 
woFDN_FLA__D_lgt_102 := map(
(NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 4.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 93.65) => -0.0012885316,
   (c_occunit_p > 93.65) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.3347268673) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 9.5) => -0.0579620236,
         (f_rel_educationover12_count_d > 9.5) => 0.1043993582,
         (f_rel_educationover12_count_d = NULL) => 0.0051136211, 0.0051136211),
      (f_add_curr_nhood_MFD_pct_i > 0.3347268673) => 0.2160525246,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0797252953, 0.0833103238),
   (c_occunit_p = NULL) => 0.0405460672, 0.0405460672),
(r_I60_inq_banking_recency_d > 4.5) => -0.0014592298,
(r_I60_inq_banking_recency_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0356275443,
   (k_nap_lname_verd_d > 0.5) => -0.0673578600,
   (k_nap_lname_verd_d = NULL) => -0.0144268142, -0.0144268142), 0.0005035794);

// Tree: 103 
woFDN_FLA__D_lgt_103 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0128348334,
   (f_crim_rel_under25miles_cnt_i > 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 10.5) => 0.0107388456,
      (r_D30_Derog_Count_i > 10.5) => 0.0760930571,
      (r_D30_Derog_Count_i = NULL) => 0.0125769328, 0.0125769328),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0096716244, -0.0019002460),
(f_srchaddrsrchcount_i > 32.5) => -0.0814126203,
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.45) => -0.0724884800,
   (c_pop_35_44_p > 13.45) => 
      map(
      (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.1101344009,
      (k_nap_lname_verd_d > 0.5) => -0.0174168640,
      (k_nap_lname_verd_d = NULL) => 0.0481468703, 0.0481468703),
   (c_pop_35_44_p = NULL) => 0.0038901146, 0.0038901146), -0.0023489313);

// Tree: 104 
woFDN_FLA__D_lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
   map(
   (NULL < r_L75_Add_Curr_Drop_Delivery_i and r_L75_Add_Curr_Drop_Delivery_i <= 0.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.25) => -0.0161662864,
      (c_pop_35_44_p > 13.25) => 0.0087783597,
      (c_pop_35_44_p = NULL) => 0.0123257991, -0.0003720555),
   (r_L75_Add_Curr_Drop_Delivery_i > 0.5) => 0.0966674576,
   (r_L75_Add_Curr_Drop_Delivery_i = NULL) => 0.0004492425, 0.0004492425),
(f_prevaddrmedianvalue_d > 809865.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 77750) => 0.3288890187,
   (r_A49_Curr_AVM_Chg_1yr_i > 77750) => 0.0005965383,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0583917960, 0.1181873159),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 55.45) => 0.0741147369,
   (c_oldhouse > 55.45) => -0.0335874130,
   (c_oldhouse = NULL) => 0.0013986357, 0.0013986357), 0.0023663563);

// Tree: 105 
woFDN_FLA__D_lgt_105 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 6.05) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 42727) => 0.2412259360,
      (f_prevaddrmedianincome_d > 42727) => 
         map(
         (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 1.5) => 0.0065745919,
         (r_A50_pb_total_orders_d > 1.5) => 0.2359596590,
         (r_A50_pb_total_orders_d = NULL) => 0.0770483173, 0.0770483173),
      (f_prevaddrmedianincome_d = NULL) => 0.1222150858, 0.1222150858),
   (c_pop_12_17_p > 6.05) => 0.0064333988,
   (c_pop_12_17_p = NULL) => 0.0393227148, 0.0385466439),
(f_corraddrnamecount_d > 1.5) => -0.0043302169,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 28.55) => 0.0662921017,
   (c_fammar18_p > 28.55) => -0.0515018253,
   (c_fammar18_p = NULL) => -0.0062621287, -0.0062621287), -0.0010827779);

// Tree: 106 
woFDN_FLA__D_lgt_106 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 0.85) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.2102159881) => 0.0837697811,
      (f_add_curr_nhood_MFD_pct_i > 0.2102159881) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2814460625) => 0.2133593875,
         (f_add_curr_mobility_index_i > 0.2814460625) => 0.0555652640,
         (f_add_curr_mobility_index_i = NULL) => 0.1108434602, 0.1108434602),
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0982274941, 0.0982274941),
   (c_hval_80k_p > 0.85) => -0.0182005556,
   (c_hval_80k_p = NULL) => 0.0436001153, 0.0436001153),
(r_I61_inq_collection_recency_d > 9) => -0.0059706353,
(r_I61_inq_collection_recency_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 17.1) => -0.0528189218,
   (c_rnt1000_p > 17.1) => 0.0580963592,
   (c_rnt1000_p = NULL) => 0.0015513140, 0.0015513140), -0.0033214413);

// Tree: 107 
woFDN_FLA__D_lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 167.5) => 0.0093791818,
   (c_span_lang > 167.5) => 0.1658277056,
   (c_span_lang = NULL) => 0.0677554967, 0.0677554967),
(f_attr_arrest_recency_d > 99.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 189.5) => -0.0039749053,
   (c_unempl > 189.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.85) => -0.0172261374,
      (c_hval_125k_p > 4.85) => 0.1237018440,
      (c_hval_125k_p = NULL) => 0.0541773732, 0.0541773732),
   (c_unempl = NULL) => 0.0290976137, -0.0025840890),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 16.75) => -0.0184140568,
   (c_hh4_p > 16.75) => 0.0726704128,
   (c_hh4_p = NULL) => 0.0186269608, 0.0186269608), -0.0015601267);

// Tree: 108 
woFDN_FLA__D_lgt_108 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => 0.0007584888,
(f_srchaddrsrchcountmo_i > 0.5) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 4.75) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 0.65) => 0.0446128087,
      (c_hval_40k_p > 0.65) => -0.0815868144,
      (c_hval_40k_p = NULL) => 0.0110772445, 0.0110772445),
   (c_hval_125k_p > 4.75) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => 0.1794607616,
      (k_comb_age_d > 27.5) => 
         map(
         (NULL < f_historical_count_d and f_historical_count_d <= 3.5) => 0.0108663079,
         (f_historical_count_d > 3.5) => 0.2204153048,
         (f_historical_count_d = NULL) => 0.0732199119, 0.0732199119),
      (k_comb_age_d = NULL) => 0.0972744439, 0.0972744439),
   (c_hval_125k_p = NULL) => 0.0439911607, 0.0439911607),
(f_srchaddrsrchcountmo_i = NULL) => -0.0158881907, 0.0029132236);

// Tree: 109 
woFDN_FLA__D_lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0087713383,
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => -0.0812916066,
   (f_mos_inq_banko_cm_lseen_d > 27.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 2.5) => 0.0491005080,
      (r_C14_Addr_Stability_v2_d > 2.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.015817356) => -0.1132196081,
         (f_add_curr_nhood_BUS_pct_i > 0.015817356) => 
            map(
            (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 67) => -0.0718233666,
            (f_prevaddrageoldest_d > 67) => 0.0767579090,
            (f_prevaddrageoldest_d = NULL) => 0.0024672712, 0.0024672712),
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0252766410, -0.0252766410),
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0038615486, -0.0038615486),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0308140637, -0.0308140637),
(r_D33_eviction_count_i = NULL) => 0.0121013759, 0.0072715679);

// Tree: 110 
woFDN_FLA__D_lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 121.5) => -0.0075310379,
(f_prevaddrageoldest_d > 121.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6907) => 0.0141525033,
   (f_addrchangeincomediff_d > 6907) => 0.1159220667,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 458951.5) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 10.8) => -0.0245192756,
         (c_hval_175k_p > 10.8) => 0.1590445363,
         (c_hval_175k_p = NULL) => 0.0313130436, 0.0313130436),
      (c_med_hval > 458951.5) => 0.1837093493,
      (c_med_hval = NULL) => -0.0133201381, 0.0464590796), 0.0216759710),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 2.25) => 0.0230400893,
   (c_hval_500k_p > 2.25) => -0.0711010522,
   (c_hval_500k_p = NULL) => -0.0194935590, -0.0194935590), 0.0010616106);

// Tree: 111 
woFDN_FLA__D_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2080857025,
   (r_C12_source_profile_d > 57.95) => 0.0011903284,
   (r_C12_source_profile_d = NULL) => 0.0964278816, 0.0964278816),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 0.0012393381,
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 5.1) => 0.1894000114,
      (C_INC_200K_P > 5.1) => -0.0300634869,
      (C_INC_200K_P = NULL) => 0.0855317908, 0.0855317908),
   (f_hh_lienholders_i = NULL) => 0.0021443184, 0.0021443184),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 26.9) => 0.0178085907,
   (c_newhouse > 26.9) => -0.0859174917,
   (c_newhouse = NULL) => -0.0182074101, -0.0182074101), 0.0028064850);

// Tree: 112 
woFDN_FLA__D_lgt_112 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 452) => 
      map(
      (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 35.35) => 0.0149522715,
         (c_famotf18_p > 35.35) => -0.0515683571,
         (c_famotf18_p = NULL) => 0.0283041093, 0.0120010116),
      (f_inq_PrepaidCards_count24_i > 0.5) => 0.0824359047,
      (f_inq_PrepaidCards_count24_i = NULL) => 0.0135932104, 0.0135932104),
   (f_M_Bureau_ADL_FS_all_d > 452) => 0.1610256363,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0166128615, 0.0166128615),
(f_corraddrnamecount_d > 4.5) => -0.0074769849,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 127.5) => 0.0795032379,
   (c_ab_av_edu > 127.5) => -0.0236928673,
   (c_ab_av_edu = NULL) => 0.0387506359, 0.0387506359), 0.0000695194);

// Tree: 113 
woFDN_FLA__D_lgt_113 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 31.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0038701782,
   (f_assocsuspicousidcount_i > 13.5) => 0.0869364180,
   (f_assocsuspicousidcount_i = NULL) => -0.0032144811, -0.0032144811),
(f_rel_homeover200_count_d > 31.5) => -0.0699341820,
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.09892355515) => -0.0119578221,
   (f_add_curr_nhood_BUS_pct_i > 0.09892355515) => 0.1719518002,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.15) => -0.0632218988,
      (c_pop_35_44_p > 13.15) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 15.05) => 0.1081224569,
         (c_hh3_p > 15.05) => 0.0052712210,
         (c_hh3_p = NULL) => 0.0538918052, 0.0538918052),
      (c_pop_35_44_p = NULL) => 0.0162997521, 0.0162997521), 0.0271126223), -0.0027353684);

// Tree: 114 
woFDN_FLA__D_lgt_114 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0054975278) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 39.5) => 0.0441602538,
      (c_no_car > 39.5) => 0.2796606226,
      (c_no_car = NULL) => 0.1596016110, 0.1596016110),
   (f_hh_members_ct_d > 1.5) => 0.0281604735,
   (f_hh_members_ct_d = NULL) => 0.0454598232, 0.0454598232),
(f_add_input_nhood_MFD_pct_i > 0.0054975278) => -0.0105232977,
(f_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 18.5) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 8.05) => 0.0926031938,
      (C_INC_100K_P > 8.05) => -0.0228515230,
      (C_INC_100K_P = NULL) => 0.0264287948, -0.0097868385),
   (f_srchaddrsrchcount_i > 18.5) => 0.1222148047,
   (f_srchaddrsrchcount_i = NULL) => -0.0217487598, -0.0072545201), -0.0064370296);

// Tree: 115 
woFDN_FLA__D_lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 64.35) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 190328) => 
         map(
         (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 1.5) => 0.0076556891,
         (f_rel_incomeover100_count_d > 1.5) => -0.0333117448,
         (f_rel_incomeover100_count_d = NULL) => 
            map(
            (NULL < c_hval_200k_p and c_hval_200k_p <= 3.45) => -0.0776836829,
            (c_hval_200k_p > 3.45) => 0.1752156875,
            (c_hval_200k_p = NULL) => 0.0292331241, 0.0292331241), -0.0034632415),
      (f_addrchangevaluediff_d > 190328) => 0.1011192557,
      (f_addrchangevaluediff_d = NULL) => 0.0053436132, -0.0007547895),
   (C_RENTOCC_P > 64.35) => -0.0317008320,
   (C_RENTOCC_P = NULL) => -0.0038041436, -0.0038041436),
(c_pop_0_5_p > 21.15) => 0.1568619478,
(c_pop_0_5_p = NULL) => 0.0032264116, -0.0029543887);

// Tree: 116 
woFDN_FLA__D_lgt_116 := map(
(NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 100) => -0.1193748357,
(f_mos_liens_rel_SC_lseen_d > 100) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 5.5) => -0.0043207944,
   (f_bus_addr_match_count_d > 5.5) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 773049.5) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0111453104,
         (r_C23_inp_addr_occ_index_d > 2) => 0.1155104328,
         (r_C23_inp_addr_occ_index_d = NULL) => 0.0262319430, 0.0262319430),
      (c_med_hval > 773049.5) => 0.1816177293,
      (c_med_hval = NULL) => 0.0364581870, 0.0364581870),
   (f_bus_addr_match_count_d = NULL) => -0.0004609745, -0.0004609745),
(f_mos_liens_rel_SC_lseen_d = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 11.1) => 0.0457167502,
   (c_rnt500_p > 11.1) => -0.0837561350,
   (c_rnt500_p = NULL) => 0.0028449339, 0.0028449339), -0.0010895394);

// Tree: 117 
woFDN_FLA__D_lgt_117 := map(
(NULL < c_hh3_p and c_hh3_p <= 24.05) => -0.0038277311,
(c_hh3_p > 24.05) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 0.1285801410,
   (r_F00_dob_score_d > 95) => 
      map(
      (NULL < c_med_age and c_med_age <= 28.75) => -0.0697775234,
      (c_med_age > 28.75) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 114.5) => 0.0122976844,
         (c_no_labfor > 114.5) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 41.5) => 0.1687343879,
            (f_prevaddrlenofres_d > 41.5) => 0.0369578473,
            (f_prevaddrlenofres_d = NULL) => 0.0857775685, 0.0857775685),
         (c_no_labfor = NULL) => 0.0320131391, 0.0320131391),
      (c_med_age = NULL) => 0.0212017060, 0.0212017060),
   (r_F00_dob_score_d = NULL) => 0.0659119793, 0.0265791365),
(c_hh3_p = NULL) => -0.0084929539, -0.0000408171);

// Tree: 118 
woFDN_FLA__D_lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0067099598,
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0333244262) => 
      map(
      (NULL < c_construction and c_construction <= 8.8) => 0.1720226954,
      (c_construction > 8.8) => -0.0011758768,
      (c_construction = NULL) => 0.1075473145, 0.1075473145),
   (f_add_curr_nhood_BUS_pct_i > 0.0333244262) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 142.5) => -0.0751124018,
      (f_curraddrcartheftindex_i > 142.5) => 0.0901057753,
      (f_curraddrcartheftindex_i = NULL) => -0.0175034321, -0.0175034321),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0422287114, 0.0422287114),
(f_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 83.75) => 0.0485040724,
   (c_fammar_p > 83.75) => -0.0759832750,
   (c_fammar_p = NULL) => 0.0036307262, 0.0036307262), -0.0053306201);

// Tree: 119 
woFDN_FLA__D_lgt_119 := map(
(NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => 
   map(
   (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 1.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 0.0255161749,
      (k_comb_age_d > 70.5) => 0.1557263343,
      (k_comb_age_d = NULL) => 0.0332870869, 0.0332870869),
   (f_addrchangeecontrajindex_d > 1.5) => 0.0008016523,
   (f_addrchangeecontrajindex_d = NULL) => 0.0175378551, 0.0082782548),
(r_D31_attr_bankruptcy_recency_d > 9) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.16692287985) => 0.0522804485,
   (f_add_curr_mobility_index_i > 0.16692287985) => -0.0404459117,
   (f_add_curr_mobility_index_i = NULL) => -0.0321667724, -0.0321667724),
(r_D31_attr_bankruptcy_recency_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 68.4) => 0.0514479590,
   (c_fammar_p > 68.4) => -0.0480883032,
   (c_fammar_p = NULL) => -0.0167875918, -0.0167875918), 0.0039467528);

// Tree: 120 
woFDN_FLA__D_lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1906.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 37.5) => -0.1220857824,
   (f_mos_inq_banko_am_fseen_d > 37.5) => -0.0052507368,
   (f_mos_inq_banko_am_fseen_d = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 1.05) => -0.0479517553,
      (c_high_hval > 1.05) => 0.0754776448,
      (c_high_hval = NULL) => 0.0101326683, 0.0101326683), -0.0069858511),
(c_popover18 > 1906.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 22.75) => 0.0174737698,
   (c_hval_150k_p > 22.75) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 18.5) => 0.3077452501,
      (c_hh1_p > 18.5) => 0.0442134450,
      (c_hh1_p = NULL) => 0.1544176544, 0.1544176544),
   (c_hval_150k_p = NULL) => 0.0268263116, 0.0268263116),
(c_popover18 = NULL) => -0.0368082904, -0.0012065780);

// Tree: 121 
woFDN_FLA__D_lgt_121 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 26.95) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 15.45) => 0.0002179471,
      (c_pop_25_34_p > 15.45) => -0.1163833090,
      (c_pop_25_34_p = NULL) => -0.0470528324, -0.0470528324),
   (c_fammar_p > 26.95) => 0.0006092464,
   (c_fammar_p = NULL) => 0.0065327422, 0.0000123443),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0844988666,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 4.35) => 0.0845753091,
   (C_INC_15K_P > 4.35) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 5.85) => 0.0306614993,
      (c_pop_65_74_p > 5.85) => -0.0661806707,
      (c_pop_65_74_p = NULL) => -0.0177595857, -0.0177595857),
   (C_INC_15K_P = NULL) => 0.0163520459, 0.0163520459), 0.0006663826);

// Tree: 122 
woFDN_FLA__D_lgt_122 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0029060537,
(f_hh_tot_derog_i > 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 144.5) => 
         map(
         (NULL < c_retired and c_retired <= 14.55) => -0.0049284294,
         (c_retired > 14.55) => 0.1043647040,
         (c_retired = NULL) => 0.0329220064, 0.0329220064),
      (c_lar_fam > 144.5) => 0.1357383544,
      (c_lar_fam = NULL) => 0.0529837329, 0.0529837329),
   (f_assocsuspicousidcount_i > 9.5) => -0.0734364650,
   (f_assocsuspicousidcount_i = NULL) => 0.0420166810, 0.0420166810),
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => -0.0326911517,
   (c_hval_250k_p > 8.05) => 0.0631062819,
   (c_hval_250k_p = NULL) => 0.0084453934, 0.0084453934), -0.0004836177);

// Tree: 123 
woFDN_FLA__D_lgt_123 := map(
(NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0059038900,
(c_easiqlife > 132.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72571) => 0.1375765924,
   (f_addrchangevaluediff_d > -72571) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 12.5) => 
         map(
         (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 16) => 0.0835562006,
         (r_F01_inp_addr_address_score_d > 16) => 0.0199650992,
         (r_F01_inp_addr_address_score_d = NULL) => 0.0224716097, 0.0224716097),
      (f_rel_under100miles_cnt_d > 12.5) => -0.0266622833,
      (f_rel_under100miles_cnt_d = NULL) => 0.0813406211, 0.0151028347),
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 24.05) => 0.0100110058,
      (c_hval_150k_p > 24.05) => 0.1994386313,
      (c_hval_150k_p = NULL) => 0.0202765111, 0.0202765111), 0.0183999485),
(c_easiqlife = NULL) => -0.0172326397, 0.0023286110);

// Tree: 124 
woFDN_FLA__D_lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
      map(
      (NULL < c_med_inc and c_med_inc <= 138.5) => 
         map(
         (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 3.5) => 0.0451774058,
         (f_crim_rel_under500miles_cnt_i > 3.5) => 0.1603547220,
         (f_crim_rel_under500miles_cnt_i = NULL) => 0.0622140505, 0.0622140505),
      (c_med_inc > 138.5) => -0.0491384570,
      (c_med_inc = NULL) => 0.0376187917, 0.0376187917),
   (f_prevaddrlenofres_d > 2.5) => 0.0032073146,
   (f_prevaddrlenofres_d = NULL) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 25.2) => 0.0821597272,
      (C_RENTOCC_P > 25.2) => -0.0438827210,
      (C_RENTOCC_P = NULL) => 0.0142907167, 0.0142907167), 0.0059416196),
(c_high_ed > 42.55) => -0.0285879371,
(c_high_ed = NULL) => -0.0328210360, -0.0047428085);

// Tree: 125 
woFDN_FLA__D_lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5693) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 281.5) => -0.0075713028,
      (f_prevaddrageoldest_d > 281.5) => 0.0396960291,
      (f_prevaddrageoldest_d = NULL) => -0.0037248581, -0.0037248581),
   (f_liens_unrel_SC_total_amt_i > 5693) => 0.1193025538,
   (f_liens_unrel_SC_total_amt_i = NULL) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 7) => 0.0612843532,
      (c_hh5_p > 7) => -0.0433515992,
      (c_hh5_p = NULL) => 0.0174047602, 0.0174047602), -0.0028564143),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 7.5) => -0.0060303780,
   (f_rel_count_i > 7.5) => 0.1805991401,
   (f_rel_count_i = NULL) => 0.0795511137, 0.0795511137),
(f_nae_nothing_found_i = NULL) => -0.0016740595, -0.0016740595);

// Tree: 126 
woFDN_FLA__D_lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < c_child and c_child <= 2.75) => -0.1140134708,
   (c_child > 2.75) => 
      map(
      (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0015132946,
      (r_L70_Add_Standardized_i > 0.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 102.45) => 0.0096756731,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 102.45) => 
            map(
            (NULL < C_INC_35K_P and C_INC_35K_P <= 9.1) => 0.2884430429,
            (C_INC_35K_P > 9.1) => -0.0224666274,
            (C_INC_35K_P = NULL) => 0.1650930107, 0.1650930107),
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0225261600, 0.0480169446),
      (r_L70_Add_Standardized_i = NULL) => 0.0051560869, 0.0051560869),
   (c_child = NULL) => -0.0089159198, 0.0039587533),
(r_L72_Add_Vacant_i > 0.5) => 0.1231980860,
(r_L72_Add_Vacant_i = NULL) => 0.0047768136, 0.0047768136);

// Tree: 127 
woFDN_FLA__D_lgt_127 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0051112252,
(f_prevaddroccupantowned_i > 0.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 7.45) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 45.1) => 0.2116628714,
      (c_hh1_p > 45.1) => 0.0043131856,
      (c_hh1_p = NULL) => 0.1170823130, 0.1170823130),
   (c_hh3_p > 7.45) => 
      map(
      (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => -0.0007900299,
      (f_divaddrsuspidcountnew_i > 0.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 63.65) => 0.1399863633,
         (c_fammar_p > 63.65) => 0.0247974377,
         (c_fammar_p = NULL) => 0.0592596982, 0.0592596982),
      (f_divaddrsuspidcountnew_i = NULL) => 0.0180188708, 0.0180188708),
   (c_hh3_p = NULL) => 0.0306652677, 0.0306652677),
(f_prevaddroccupantowned_i = NULL) => -0.0208618135, -0.0028069932);

// Tree: 128 
woFDN_FLA__D_lgt_128 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 54.5) => -0.0104289635,
(r_C13_Curr_Addr_LRes_d > 54.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 12.5) => 
      map(
      (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 4.5) => 
         map(
         (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0141551404,
         (f_phones_per_addr_c6_i > 0.5) => 0.2447387235,
         (f_phones_per_addr_c6_i = NULL) => 0.0990140336, 0.0990140336),
      (r_C20_email_verification_d > 4.5) => -0.0750294083,
      (r_C20_email_verification_d = NULL) => 0.0109609362, 0.0119891452),
   (k_inq_per_addr_i > 12.5) => 0.0997346365,
   (k_inq_per_addr_i = NULL) => 0.0127432181, 0.0127432181),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 68.35) => 0.0562345202,
   (c_fammar_p > 68.35) => -0.0376393356,
   (c_fammar_p = NULL) => -0.0086659233, -0.0086659233), 0.0019265210);

// Tree: 129 
woFDN_FLA__D_lgt_129 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 31.9) => 
      map(
      (NULL < c_professional and c_professional <= 4.25) => -0.0493853375,
      (c_professional > 4.25) => 0.1170851590,
      (c_professional = NULL) => 0.0190452223, 0.0190452223),
   (c_rnt1000_p > 31.9) => 0.1615335252,
   (c_rnt1000_p = NULL) => 0.0542432257, 0.0542432257),
(r_I61_inq_collection_recency_d > 4.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.005) => -0.0072496790,
   (c_hhsize > 4.005) => 
      map(
      (NULL < c_construction and c_construction <= 11.5) => 0.0027182128,
      (c_construction > 11.5) => 0.1959067859,
      (c_construction = NULL) => 0.0624672560, 0.0624672560),
   (c_hhsize = NULL) => 0.0267419083, -0.0054556379),
(r_I61_inq_collection_recency_d = NULL) => -0.0165252448, -0.0040038921);

// Tree: 130 
woFDN_FLA__D_lgt_130 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.0939854301,
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 12.45) => -0.0916049018,
      (c_white_col > 12.45) => -0.0045365424,
      (c_white_col = NULL) => -0.0051433913, -0.0051433913),
   (c_lar_fam > 181.5) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 7.65) => -0.0525452651,
      (C_INC_15K_P > 7.65) => 0.1706578026,
      (C_INC_15K_P = NULL) => 0.0806844730, 0.0806844730),
   (c_lar_fam = NULL) => 0.0402318724, -0.0033051658),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 99.5) => 0.0445584678,
   (c_many_cars > 99.5) => -0.0578893369,
   (c_many_cars = NULL) => -0.0025800927, -0.0025800927), -0.0029029774);

// Tree: 131 
woFDN_FLA__D_lgt_131 := map(
(NULL < c_white_col and c_white_col <= 11.65) => -0.1087456767,
(c_white_col > 11.65) => 
   map(
   (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1343516791) => -0.0045141810,
      (f_add_curr_nhood_BUS_pct_i > 0.1343516791) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
            map(
            (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 2.5) => 0.1002303113,
            (f_corraddrnamecount_d > 2.5) => 0.0043676747,
            (f_corraddrnamecount_d = NULL) => 0.0147632591, 0.0147632591),
         (r_D30_Derog_Count_i > 5.5) => 0.1278001645,
         (r_D30_Derog_Count_i = NULL) => 0.0206140306, 0.0206140306),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0211580196, -0.0001875864),
   (r_L72_Add_Vacant_i > 0.5) => 0.0892012307,
   (r_L72_Add_Vacant_i = NULL) => 0.0005380310, 0.0005380310),
(c_white_col = NULL) => -0.0046579431, -0.0002010513);

// Tree: 132 
woFDN_FLA__D_lgt_132 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => 
   map(
   (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.35) => -0.0030082932,
   (c_hval_1000k_p > 41.35) => 0.1400300819,
   (c_hval_1000k_p = NULL) => -0.0010703059, -0.0010703059),
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2384210044,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 0.65) => -0.1178299057,
   (c_pop_0_5_p > 0.65) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0015171778,
      (f_hh_collections_ct_i > 2.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 130.5) => 0.0144961844,
         (c_rest_indx > 130.5) => 0.1622619868,
         (c_rest_indx = NULL) => 0.0479632951, 0.0479632951),
      (f_hh_collections_ct_i = NULL) => 0.0136879349, 0.0028127881),
   (c_pop_0_5_p = NULL) => -0.0129474230, 0.0006526982), 0.0008211023);

// Tree: 133 
woFDN_FLA__D_lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 124.5) => 
   map(
   (NULL < c_rape and c_rape <= 66) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.28762863355) => 0.2261418421,
      (f_add_curr_mobility_index_i > 0.28762863355) => 0.0298757097,
      (f_add_curr_mobility_index_i = NULL) => 0.1417960662, 0.1417960662),
   (c_rape > 66) => 0.0051692340,
   (c_rape = NULL) => 0.0582535446, 0.0582535446),
(f_mos_liens_unrel_SC_fseen_d > 124.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 12.5) => -0.0123289935,
      (k_inq_per_addr_i > 12.5) => 0.1008635672,
      (k_inq_per_addr_i = NULL) => -0.0111704528, -0.0111704528),
   (f_bus_name_nover_i > 0.5) => 0.0174704521,
   (f_bus_name_nover_i = NULL) => 0.0004707195, 0.0004707195),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0135085813, 0.0017029832);

// Tree: 134 
woFDN_FLA__D_lgt_134 := map(
(NULL < f_idverrisktype_i and f_idverrisktype_i <= 5.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.25) => 0.0056621912,
      (c_pop_75_84_p > 3.25) => 0.1338008131,
      (c_pop_75_84_p = NULL) => 0.0561957322, 0.0561957322),
   (r_C10_M_Hdr_FS_d > 10.5) => 0.0025741336,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0035923548, 0.0035923548),
(f_idverrisktype_i > 5.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 19.05) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.30097863295) => -0.0061314033,
      (f_add_input_mobility_index_i > 0.30097863295) => -0.0651306587,
      (f_add_input_mobility_index_i = NULL) => -0.0342119087, -0.0342119087),
   (c_hval_200k_p > 19.05) => 0.0743974008,
   (c_hval_200k_p = NULL) => 0.0606078894, -0.0204977396),
(f_idverrisktype_i = NULL) => -0.0040206732, 0.0013357441);

// Tree: 135 
woFDN_FLA__D_lgt_135 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0043412358,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 111.5) => 0.0109276896,
   (c_bel_edu > 111.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 156.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 27.6) => 
            map(
            (NULL < C_INC_50K_P and C_INC_50K_P <= 16.95) => -0.0482717348,
            (C_INC_50K_P > 16.95) => 0.1583914502,
            (C_INC_50K_P = NULL) => 0.0188608922, 0.0188608922),
         (c_rnt1000_p > 27.6) => 0.1826944132,
         (c_rnt1000_p = NULL) => 0.0590316113, 0.0590316113),
      (f_curraddrmurderindex_i > 156.5) => 0.2128136483,
      (f_curraddrmurderindex_i = NULL) => 0.0888343316, 0.0888343316),
   (c_bel_edu = NULL) => 0.0344449627, 0.0344449627),
(k_comb_age_d = NULL) => -0.0016441822, -0.0016441822);

// Tree: 136 
woFDN_FLA__D_lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 3181.5) => -0.0012772992,
   (r_A50_pb_total_dollars_d > 3181.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0303287238,
      (f_rel_criminal_count_i > 2.5) => 0.1099730647,
      (f_rel_criminal_count_i = NULL) => 0.0472207997, 0.0472207997),
   (r_A50_pb_total_dollars_d = NULL) => 0.0210290078, 0.0210290078),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -33816.5) => -0.0943391305,
   (f_addrchangeincomediff_d > -33816.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 201458.5) => -0.0079618766,
      (f_addrchangevaluediff_d > 201458.5) => 0.1145046918,
      (f_addrchangevaluediff_d = NULL) => -0.0068945287, -0.0068945287),
   (f_addrchangeincomediff_d = NULL) => -0.0071649848, -0.0078585639),
(f_hh_members_ct_d = NULL) => -0.0033542158, -0.0023135988);

// Tree: 137 
woFDN_FLA__D_lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => -0.0001905607,
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.25) => -0.1148658710,
   (C_INC_75K_P > 15.25) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.85) => -0.0696905893,
      (c_pop_45_54_p > 12.85) => 0.0499115591,
      (c_pop_45_54_p = NULL) => -0.0010001663, -0.0010001663),
   (C_INC_75K_P = NULL) => -0.0346176600, -0.0346176600),
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 
      map(
      (NULL < c_assault and c_assault <= 88) => -0.0382179351,
      (c_assault > 88) => 0.0840657701,
      (c_assault = NULL) => 0.0126520862, 0.0126520862),
   (r_L77_Apartment_i > 0.5) => -0.1001023573,
   (r_L77_Apartment_i = NULL) => -0.0172278413, -0.0172278413), -0.0010318357);

// Tree: 138 
woFDN_FLA__D_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => -0.0021392772,
   (f_bus_addr_match_count_d > 52.5) => 0.0916218448,
   (f_bus_addr_match_count_d = NULL) => -0.0015009232, -0.0015009232),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 26.55) => -0.0614343475,
      (c_famotf18_p > 26.55) => 0.0863760106,
      (c_famotf18_p = NULL) => -0.0027246258, -0.0027246258),
   (f_vardobcountnew_i > 0.5) => 0.1465328036,
   (f_vardobcountnew_i = NULL) => 0.0406868487, 0.0406868487),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 11.05) => 0.0527531239,
   (c_pop_25_34_p > 11.05) => -0.0380642994,
   (c_pop_25_34_p = NULL) => -0.0061879853, -0.0061879853), -0.0005526938);

// Tree: 139 
woFDN_FLA__D_lgt_139 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.5) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 101.5) => 0.1420301095,
      (c_old_homes > 101.5) => 0.0058758277,
      (c_old_homes = NULL) => 0.0829981831, 0.0829981831),
   (c_pop_45_54_p > 16.5) => -0.0438224316,
   (c_pop_45_54_p = NULL) => 0.0455142576, 0.0455142576),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 118500) => -0.0062424169,
   (k_estimated_income_d > 118500) => 0.0631139743,
   (k_estimated_income_d = NULL) => -0.0024369620, -0.0024369620),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 17.65) => 0.0315664066,
   (c_hh3_p > 17.65) => -0.0624741602,
   (c_hh3_p = NULL) => -0.0046479731, -0.0046479731), -0.0016803762);

// Tree: 140 
woFDN_FLA__D_lgt_140 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 198.5) => -0.0016017390,
   (c_work_home > 198.5) => 0.1774246477,
   (c_work_home = NULL) => -0.0342700322, -0.0013056049),
(f_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.1086062010,
      (f_adl_util_conv_n > 0.5) => -0.1163009702,
      (f_adl_util_conv_n = NULL) => 0.0141073896, 0.0141073896),
   (r_C23_inp_addr_occ_index_d > 2) => 0.1555419486,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0620379901, 0.0620379901),
(f_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 3.35) => 0.0266811235,
   (c_bigapt_p > 3.35) => -0.0641728384,
   (c_bigapt_p = NULL) => -0.0076803108, -0.0076803108), -0.0004992272);

// Tree: 141 
woFDN_FLA__D_lgt_141 := map(
(NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i <= 9) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 204.35) => 
      map(
      (NULL < c_unemp and c_unemp <= 8.55) => 0.0163286357,
      (c_unemp > 8.55) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 129) => 0.1653296787,
         (f_M_Bureau_ADL_FS_all_d > 129) => 0.0383029302,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0903630730, 0.0903630730),
      (c_unemp = NULL) => 0.0214229399, 0.0214229399),
   (c_housingcpi > 204.35) => -0.0087254544,
   (c_housingcpi = NULL) => -0.0294495982, -0.0048497623),
(r_C12_NonDerog_Recency_i > 9) => 0.0951763751,
(r_C12_NonDerog_Recency_i = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 11.45) => 0.0567737953,
   (c_newhouse > 11.45) => -0.0401738100,
   (c_newhouse = NULL) => 0.0044220884, 0.0044220884), -0.0041216743);

// Tree: 142 
woFDN_FLA__D_lgt_142 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 17.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 7.7) => -0.0276669125,
      (c_famotf18_p > 7.7) => 0.1097706135,
      (c_famotf18_p = NULL) => 0.0532778881, 0.0532778881),
   (r_C13_max_lres_d > 17.5) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 25.5) => 0.0040188561,
      (f_rel_incomeover25_count_d > 25.5) => -0.0449380768,
      (f_rel_incomeover25_count_d = NULL) => -0.0221337906, 0.0021709498),
   (r_C13_max_lres_d = NULL) => 0.0029190021, 0.0029190021),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0498252562,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 0.55) => -0.0339916795,
   (c_hval_40k_p > 0.55) => 0.0591143843,
   (c_hval_40k_p = NULL) => -0.0046491624, -0.0046491624), 0.0005965329);

// Tree: 143 
woFDN_FLA__D_lgt_143 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 16.5) => 
      map(
      (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => -0.0012440715,
      (f_srchunvrfddobcount_i > 0.5) => 0.0432412175,
      (f_srchunvrfddobcount_i = NULL) => 0.0001937347, 0.0001937347),
   (f_srchfraudsrchcount_i > 16.5) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 72) => 0.0383288138,
      (c_old_homes > 72) => -0.1329136451,
      (c_old_homes = NULL) => -0.0507729534, -0.0507729534),
   (f_srchfraudsrchcount_i = NULL) => -0.0003224874, -0.0003224874),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0733795010,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 110.5) => -0.0404307107,
   (c_larceny > 110.5) => 0.0463280281,
   (c_larceny = NULL) => -0.0010433078, -0.0010433078), 0.0000097432);

// Tree: 144 
woFDN_FLA__D_lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1147226683,
   (f_mos_liens_unrel_FT_lseen_d > 39.5) => -0.0046883297,
   (f_mos_liens_unrel_FT_lseen_d = NULL) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 61.95) => -0.0412052164,
      (C_OWNOCC_P > 61.95) => 0.0450494742,
      (C_OWNOCC_P = NULL) => 0.0016474324, 0.0016474324), -0.0040930490),
(c_rnt2001_p > 49) => 
   map(
   (NULL < c_rnt1500_p and c_rnt1500_p <= 9.15) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.55) => -0.0940467879,
      (c_pop_45_54_p > 13.55) => 0.1018907243,
      (c_pop_45_54_p = NULL) => 0.0493221234, 0.0493221234),
   (c_rnt1500_p > 9.15) => 0.2526742022,
   (c_rnt1500_p = NULL) => 0.0875764749, 0.0875764749),
(c_rnt2001_p = NULL) => 0.0022871055, -0.0017625556);

// Tree: 145 
woFDN_FLA__D_lgt_145 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 57.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 18.55) => -0.0963097205,
      (c_fammar_p > 18.55) => -0.0071027968,
      (c_fammar_p = NULL) => 0.0129934816, -0.0074410323),
   (k_comb_age_d > 57.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 19.55) => 0.0153440621,
      (c_hval_500k_p > 19.55) => 0.1037278049,
      (c_hval_500k_p = NULL) => 0.0401848340, 0.0274308736),
   (k_comb_age_d = NULL) => -0.0004598870, -0.0004598870),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 70) => 0.1791262809,
   (f_prevaddrageoldest_d > 70) => -0.0087235983,
   (f_prevaddrageoldest_d = NULL) => 0.0697808289, 0.0697808289),
(f_hh_lienholders_i = NULL) => -0.0199433718, 0.0000087134);

// Tree: 146 
woFDN_FLA__D_lgt_146 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0052632862,
   (f_curraddrcrimeindex_i > 189) => 
      map(
      (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 1.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 135) => 0.0319213009,
         (c_no_labfor > 135) => 0.2316144635,
         (c_no_labfor = NULL) => 0.1252358628, 0.1252358628),
      (f_addrchangeecontrajindex_d > 1.5) => -0.0103938908,
      (f_addrchangeecontrajindex_d = NULL) => 0.0337503898, 0.0460703781),
   (f_curraddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 8.75) => -0.0104953749,
      (c_hval_750k_p > 8.75) => 0.0943777236,
      (c_hval_750k_p = NULL) => 0.0233346569, 0.0233346569), -0.0035402023),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1057119897,
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0027564460, -0.0027564460);

// Tree: 147 
woFDN_FLA__D_lgt_147 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 56.85) => 
   map(
   (NULL < c_med_age and c_med_age <= 27.95) => -0.0392545535,
   (c_med_age > 27.95) => 0.0007079947,
   (c_med_age = NULL) => -0.0015352892, -0.0015352892),
(c_fammar18_p > 56.85) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 165.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 42) => 0.1200205598,
      (f_mos_inq_banko_cm_lseen_d > 42) => -0.0146631423,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0065781348, 0.0065781348),
   (c_lar_fam > 165.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 39) => 0.0185172547,
      (f_fp_prevaddrcrimeindex_i > 39) => 0.2765140389,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.1566572652, 0.1566572652),
   (c_lar_fam = NULL) => 0.0338460331, 0.0338460331),
(c_fammar18_p = NULL) => -0.0447494340, -0.0004781582);

// Tree: 148 
woFDN_FLA__D_lgt_148 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0062544610,
(k_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 20.45) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 6.5) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 12.5) => 0.0274146790,
         (f_phones_per_addr_curr_i > 12.5) => -0.0473386295,
         (f_phones_per_addr_curr_i = NULL) => 0.0181409649, 0.0181409649),
      (r_D30_Derog_Count_i > 6.5) => -0.0876181268,
      (r_D30_Derog_Count_i = NULL) => 0.0140304337, 0.0140304337),
   (c_hval_150k_p > 20.45) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 71.5) => 0.1871960395,
      (c_old_homes > 71.5) => -0.0046585120,
      (c_old_homes = NULL) => 0.1071585579, 0.1071585579),
   (c_hval_150k_p = NULL) => 0.0229914043, 0.0229914043),
(k_inq_ssns_per_addr_i = NULL) => -0.0023050588, -0.0023050588);

// Tree: 149 
woFDN_FLA__D_lgt_149 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0085561595) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0284225807,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 7.35) => 0.0283179851,
      (c_vacant_p > 7.35) => 0.2056785654,
      (c_vacant_p = NULL) => 0.0935540606, 0.0935540606),
   (nf_seg_FraudPoint_3_0 = '') => 0.0393195783, 0.0393195783),
(f_add_input_nhood_MFD_pct_i > 0.0085561595) => 
   map(
   (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 4.5) => 0.0063064615,
   (r_A50_pb_total_orders_d > 4.5) => -0.0406263405,
   (r_A50_pb_total_orders_d = NULL) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 0.1) => -0.0463999695,
      (c_low_hval > 0.1) => 0.0593355371,
      (c_low_hval = NULL) => 0.0042084781, 0.0042084781), -0.0043295365),
(f_add_input_nhood_MFD_pct_i = NULL) => 0.0029371059, 0.0006818117);

// Tree: 150 
woFDN_FLA__D_lgt_150 := map(
(NULL < c_low_ed and c_low_ed <= 77.75) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 3.15) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => 0.0040704805,
      (f_inq_Collection_count24_i > 1.5) => 
         map(
         (NULL < c_assault and c_assault <= 19.5) => 0.1771893334,
         (c_assault > 19.5) => 
            map(
            (NULL < c_rnt750_p and c_rnt750_p <= 7.45) => -0.0434348395,
            (c_rnt750_p > 7.45) => 0.0499468444,
            (c_rnt750_p = NULL) => 0.0178597460, 0.0178597460),
         (c_assault = NULL) => 0.0437287565, 0.0437287565),
      (f_inq_Collection_count24_i = NULL) => 0.0227932642, 0.0066943294),
   (c_trailer_p > 3.15) => -0.0212508342,
   (c_trailer_p = NULL) => -0.0004270827, -0.0004270827),
(c_low_ed > 77.75) => -0.0500060801,
(c_low_ed = NULL) => -0.0004674953, -0.0018115874);

// Tree: 151 
woFDN_FLA__D_lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 9.5) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => -0.0023982310,
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 0.0817138500,
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0016438321, -0.0016438321),
(r_C14_addrs_10yr_i > 9.5) => 
   map(
   (NULL < c_families and c_families <= 452) => -0.0074180588,
   (c_families > 452) => 0.1639606490,
   (c_families = NULL) => 0.0766234229, 0.0766234229),
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 9.95) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => -0.0218274042,
      (c_hval_250k_p > 8.05) => 0.0858449811,
      (c_hval_250k_p = NULL) => 0.0253348803, 0.0253348803),
   (c_construction > 9.95) => -0.0687412500,
   (c_construction = NULL) => -0.0021727602, -0.0021727602), -0.0010106934);

// Tree: 152 
woFDN_FLA__D_lgt_152 := map(
(NULL < c_white_col and c_white_col <= 30.85) => 
   map(
   (NULL < r_I60_inq_auto_recency_d and r_I60_inq_auto_recency_d <= 9) => -0.0995969263,
   (r_I60_inq_auto_recency_d > 9) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 111.5) => -0.0248097419,
      (c_many_cars > 111.5) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 1.5) => 
            map(
            (NULL < C_INC_200K_P and C_INC_200K_P <= 0.95) => 0.1784364761,
            (C_INC_200K_P > 0.95) => -0.0145631493,
            (C_INC_200K_P = NULL) => 0.0619565260, 0.0619565260),
         (f_rel_incomeover50_count_d > 1.5) => 0.0088554989,
         (f_rel_incomeover50_count_d = NULL) => 0.0207782814, 0.0207782814),
      (c_many_cars = NULL) => -0.0097513881, -0.0097513881),
   (r_I60_inq_auto_recency_d = NULL) => -0.0129471420, -0.0129471420),
(c_white_col > 30.85) => 0.0086517102,
(c_white_col = NULL) => 0.0185648529, 0.0033448192);

// Tree: 153 
woFDN_FLA__D_lgt_153 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 10.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 194.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.85) => 0.0166314754,
         (r_C12_source_profile_d > 79.85) => 0.1620645699,
         (r_C12_source_profile_d = NULL) => 0.0255864360, 0.0255864360),
      (c_relig_indx > 194.5) => 0.2546829218,
      (c_relig_indx = NULL) => 0.0343449973, 0.0343449973),
   (r_I60_inq_recency_d > 4.5) => 0.0003866609,
   (r_I60_inq_recency_d = NULL) => 0.0048577477, 0.0048577477),
(f_rel_incomeover50_count_d > 10.5) => -0.0226537136,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 46.5) => 0.0584441229,
   (c_no_teens > 46.5) => -0.0373018210,
   (c_no_teens = NULL) => -0.0199151198, -0.0199151198), -0.0003871064);

// Tree: 154 
woFDN_FLA__D_lgt_154 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 16.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 8.5) => -0.0109322537,
   (f_util_adl_count_n > 8.5) => 
      map(
      (NULL < c_medi_indx and c_medi_indx <= 102.5) => 0.1036406581,
      (c_medi_indx > 102.5) => -0.0105188105,
      (c_medi_indx = NULL) => 0.0494469778, 0.0494469778),
   (f_util_adl_count_n = NULL) => 0.0000014701, -0.0086427033),
(c_hval_500k_p > 16.15) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 0.0188119106,
   (k_comb_age_d > 71.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1974.5) => 0.2498924398,
      (c_med_yearblt > 1974.5) => -0.0592775389,
      (c_med_yearblt = NULL) => 0.1040575442, 0.1040575442),
   (k_comb_age_d = NULL) => 0.0226358790, 0.0226358790),
(c_hval_500k_p = NULL) => 0.0067844041, -0.0024633123);

// Tree: 155 
woFDN_FLA__D_lgt_155 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72593) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1033474154) => -0.0623870126,
   (f_add_curr_nhood_MFD_pct_i > 0.1033474154) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 91.5) => 0.1610194294,
      (c_easiqlife > 91.5) => 0.0232395813,
      (c_easiqlife = NULL) => 0.0764511089, 0.0764511089),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0387764427, 0.0387764427),
(f_addrchangevaluediff_d > -72593) => -0.0003070417,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 79.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => -0.0498860911,
      (f_srchfraudsrchcount_i > 4.5) => -0.1127974603,
      (f_srchfraudsrchcount_i = NULL) => -0.0552828997, -0.0552828997),
   (c_span_lang > 79.5) => 0.0071510723,
   (c_span_lang = NULL) => 0.0154063418, -0.0105245193), -0.0018955526);

// Tree: 156 
woFDN_FLA__D_lgt_156 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0020898723,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 3.5) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 39) => 0.0509662927,
      (c_totcrime > 39) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33130) => 0.0620765059,
         (f_curraddrmedianincome_d > 33130) => -0.0554105288,
         (f_curraddrmedianincome_d = NULL) => -0.0375009199, -0.0375009199),
      (c_totcrime = NULL) => -0.0148324504, -0.0148324504),
   (f_crim_rel_under25miles_cnt_i > 3.5) => -0.1012009254,
   (f_crim_rel_under25miles_cnt_i = NULL) => -0.0307090083, -0.0307090083),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 113) => -0.0473893357,
   (c_preschl > 113) => 0.0495412986,
   (c_preschl = NULL) => 0.0033227180, 0.0033227180), 0.0006953137);

// Tree: 157 
woFDN_FLA__D_lgt_157 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 39.6) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 25297.5) => 
         map(
         (NULL < c_blue_col and c_blue_col <= 13.2) => 0.1534481171,
         (c_blue_col > 13.2) => -0.0237705057,
         (c_blue_col = NULL) => 0.0586206084, 0.0586206084),
      (r_A46_Curr_AVM_AutoVal_d > 25297.5) => 0.0062480628,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0043198390, 0.0022602089),
   (c_hval_80k_p > 39.6) => -0.0914420681,
   (c_hval_80k_p = NULL) => 0.0080836251, 0.0013476909),
(f_inq_HighRiskCredit_count24_i > 8.5) => 0.0713925412,
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0517385644,
   (k_nap_lname_verd_d > 0.5) => -0.0439018769,
   (k_nap_lname_verd_d = NULL) => 0.0044217145, 0.0044217145), 0.0017968307);

// Tree: 158 
woFDN_FLA__D_lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 0.0007702364,
      (r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0641184614,
      (r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => -0.0007395397, -0.0007395397),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 5728) => -0.1493768387,
      (r_A50_pb_total_dollars_d > 5728) => 0.0140780856,
      (r_A50_pb_total_dollars_d = NULL) => -0.0619738583, -0.0619738583),
   (r_I60_inq_comm_count12_i = NULL) => -0.0014485894, -0.0014485894),
(r_D33_eviction_count_i > 3.5) => 0.0790609170,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 1.6) => 0.0536174912,
   (c_hval_80k_p > 1.6) => -0.0510997004,
   (c_hval_80k_p = NULL) => 0.0177554393, 0.0177554393), -0.0006994900);

// Tree: 159 
woFDN_FLA__D_lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 2095) => -0.0043748073,
   (c_popover18 > 2095) => 0.0361363983,
   (c_popover18 = NULL) => 0.0198081830, 0.0017149352),
(f_rel_homeover500_count_d > 19.5) => 0.1090129310,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.14038461535) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.75395861565) => -0.0840713933,
      (f_add_curr_nhood_SFD_pct_d > 0.75395861565) => 0.0822492855,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 
         map(
         (NULL < c_burglary and c_burglary <= 97.5) => -0.0492148193,
         (c_burglary > 97.5) => 0.0615353105,
         (c_burglary = NULL) => 0.0000074606, 0.0000074606), -0.0194022462),
   (f_add_input_nhood_BUS_pct_i > 0.14038461535) => 0.1003434076,
   (f_add_input_nhood_BUS_pct_i = NULL) => -0.0159765959, -0.0020332338), 0.0021289369);

// Tree: 160 
woFDN_FLA__D_lgt_160 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 205) => -0.0811663816,
(f_mos_liens_unrel_FT_fseen_d > 205) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.95) => -0.0040990723,
   (r_C12_source_profile_d > 78.95) => 
      map(
      (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 229.7) => 0.0180358598,
         (c_oldhouse > 229.7) => 0.1380137306,
         (c_oldhouse = NULL) => 0.0267019981, 0.0267019981),
      (f_srchaddrsrchcountmo_i > 0.5) => 0.1706143522,
      (f_srchaddrsrchcountmo_i = NULL) => 0.0338047339, 0.0338047339),
   (r_C12_source_profile_d = NULL) => -0.0000576771, -0.0000576771),
(f_mos_liens_unrel_FT_fseen_d = NULL) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 140.5) => -0.0376170698,
   (c_sub_bus > 140.5) => 0.0537352545,
   (c_sub_bus = NULL) => -0.0095086623, -0.0095086623), -0.0010683961);

// Tree: 161 
woFDN_FLA__D_lgt_161 := map(
(NULL < c_easiqlife and c_easiqlife <= 146.5) => -0.0104626371,
(c_easiqlife > 146.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -2.5) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 117.5) => 0.0356115430,
      (c_relig_indx > 117.5) => 0.1990804018,
      (c_relig_indx = NULL) => 0.1023068374, 0.1023068374),
   (f_addrchangecrimediff_i > -2.5) => 0.0079011211,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0255231591) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.9) => 0.0084187341,
         (c_pop_55_64_p > 11.9) => 0.1881724927,
         (c_pop_55_64_p = NULL) => 0.0731641637, 0.0731641637),
      (f_add_input_nhood_BUS_pct_i > 0.0255231591) => -0.0177106200,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0148992089, 0.0148992089), 0.0133468301),
(c_easiqlife = NULL) => -0.0364128403, -0.0054804327);

// Tree: 162 
woFDN_FLA__D_lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0008693079,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_rental and c_rental <= 119) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 76) => 0.0112404196,
      (c_cartheft > 76) => 0.1760195911,
      (c_cartheft = NULL) => 0.0941417419, 0.0941417419),
   (c_rental > 119) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 137378) => 0.0490896791,
      (f_prevaddrmedianvalue_d > 137378) => -0.0863966269,
      (f_prevaddrmedianvalue_d = NULL) => -0.0196645658, -0.0196645658),
   (c_rental = NULL) => 0.0424466733, 0.0424466733),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 92.5) => 0.0641677193,
   (c_very_rich > 92.5) => -0.0313214456,
   (c_very_rich = NULL) => 0.0101708701, 0.0101708701), 0.0003076889);

// Tree: 163 
woFDN_FLA__D_lgt_163 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.5141160012) => 
      map(
      (NULL < c_incollege and c_incollege <= 8.35) => 0.0088359104,
      (c_incollege > 8.35) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 100.5) => 0.0030995065,
         (f_M_Bureau_ADL_FS_all_d > 100.5) => 
            map(
            (NULL < c_many_cars and c_many_cars <= 96) => 0.2238644227,
            (c_many_cars > 96) => 0.0348826952,
            (c_many_cars = NULL) => 0.1332146509, 0.1332146509),
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0860226297, 0.0860226297),
      (c_incollege = NULL) => -0.0152239015, 0.0248512181),
   (f_add_input_mobility_index_i > 0.5141160012) => -0.0331463210,
   (f_add_input_mobility_index_i = NULL) => 0.0158961577, 0.0158961577),
(f_corraddrnamecount_d > 1.5) => -0.0041228765,
(f_corraddrnamecount_d = NULL) => -0.0175755493, -0.0027729370);

// Tree: 164 
woFDN_FLA__D_lgt_164 := map(
(NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 4.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0012001758,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 186.5) => 
         map(
         (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.0791091525,
         (r_F01_inp_addr_address_score_d > 25) => 0.0106646818,
         (r_F01_inp_addr_address_score_d = NULL) => 0.0193585522, 0.0193585522),
      (c_rich_blk > 186.5) => 0.1493883801,
      (c_rich_blk = NULL) => 0.0941215634, 0.0368031900),
   (r_L70_Add_Standardized_i = NULL) => 0.0019798040, 0.0019798040),
(f_inq_Other_count24_i > 4.5) => 0.0930065389,
(f_inq_Other_count24_i = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 69.5) => -0.0501196540,
   (c_serv_empl > 69.5) => 0.0503353560,
   (c_serv_empl = NULL) => 0.0063452536, 0.0063452536), 0.0028181272);

// Tree: 165 
woFDN_FLA__D_lgt_165 := map(
(NULL < c_hh2_p and c_hh2_p <= 50.35) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 22.5) => -0.0362208997,
   (f_mos_inq_banko_om_fseen_d > 22.5) => 0.0019937175,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0168706057, -0.0005614047),
(c_hh2_p > 50.35) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.2134160859,
   (f_hh_members_ct_d > 1.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 101.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 12.8) => 0.0576580513,
         (C_INC_35K_P > 12.8) => 0.2826165054,
         (C_INC_35K_P = NULL) => 0.1086101798, 0.1086101798),
      (c_rest_indx > 101.5) => -0.0415208065,
      (c_rest_indx = NULL) => 0.0293071184, 0.0293071184),
   (f_hh_members_ct_d = NULL) => 0.0575832397, 0.0575832397),
(c_hh2_p = NULL) => 0.0024303733, 0.0022283141);

// Tree: 166 
woFDN_FLA__D_lgt_166 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 8.95) => 0.1764456991,
   (c_pop_25_34_p > 8.95) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 10.05) => -0.0300151380,
      (c_hval_400k_p > 10.05) => 0.1014740221,
      (c_hval_400k_p = NULL) => 0.0215492385, 0.0215492385),
   (c_pop_25_34_p = NULL) => 0.0646572157, 0.0646572157),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_info and c_info <= 23.35) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 41.85) => -0.0101950690,
      (c_fammar18_p > 41.85) => 0.0156771938,
      (c_fammar18_p = NULL) => -0.0018932761, -0.0018932761),
   (c_info > 23.35) => 0.1300480388,
   (c_info = NULL) => 0.0206253773, -0.0004648049),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0265806973, 0.0002653254);

// Tree: 167 
woFDN_FLA__D_lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 57.25) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 206.5) => -0.0833407752,
      (f_mos_liens_unrel_CJ_lseen_d > 206.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 77.3) => 
            map(
            (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0060734059,
            (f_hh_collections_ct_i > 2.5) => 0.1151426033,
            (f_hh_collections_ct_i = NULL) => 0.0158254753, 0.0158254753),
         (r_C12_source_profile_d > 77.3) => 0.1370380934,
         (r_C12_source_profile_d = NULL) => 0.0275474182, 0.0275474182),
      (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0198696995, 0.0198696995),
   (c_rnt750_p > 57.25) => 0.1723567785,
   (c_rnt750_p = NULL) => 0.0301279212, 0.0301279212),
(c_many_cars > 22.5) => -0.0075947474,
(c_many_cars = NULL) => 0.0010089742, -0.0041302621);

// Tree: 168 
woFDN_FLA__D_lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 4.5) => -0.0076751875,
   (f_idrisktype_i > 4.5) => 0.1217544814,
   (f_idrisktype_i = NULL) => 0.0058689519, -0.0068931948),
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.05) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 17.5) => 0.0136619155,
      (f_rel_under500miles_cnt_d > 17.5) => 0.1353406951,
      (f_rel_under500miles_cnt_d = NULL) => 0.0253899906, 0.0253899906),
   (r_C12_source_profile_d > 81.05) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 1.05) => 0.2976813931,
      (c_hval_80k_p > 1.05) => 0.0268239876,
      (c_hval_80k_p = NULL) => 0.1635935686, 0.1635935686),
   (r_C12_source_profile_d = NULL) => 0.0415270558, 0.0415270558),
(c_hval_150k_p = NULL) => -0.0135496362, -0.0037142139);

// Tree: 169 
woFDN_FLA__D_lgt_169 := map(
(NULL < c_unempl and c_unempl <= 189.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 12.05) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 36.25) => -0.0046968038,
      (c_hval_500k_p > 36.25) => 
         map(
         (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 0.1328866717,
         (f_rel_incomeover100_count_d > 0.5) => -0.0035097161,
         (f_rel_incomeover100_count_d = NULL) => 0.0594424629, 0.0594424629),
      (c_hval_500k_p = NULL) => -0.0027834541, -0.0027834541),
   (c_unemp > 12.05) => -0.1046997443,
   (c_unemp = NULL) => -0.0032656029, -0.0032656029),
(c_unempl > 189.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 69.5) => 0.1446689538,
   (c_blue_empl > 69.5) => -0.0134131433,
   (c_blue_empl = NULL) => 0.0556086174, 0.0556086174),
(c_unempl = NULL) => 0.0044955116, -0.0024333968);

// Tree: 170 
woFDN_FLA__D_lgt_170 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 0.1325745252,
   (f_prevaddrlenofres_d > 2.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 152.5) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 7.95) => 0.0243649350,
         (c_femdiv_p > 7.95) => -0.0832686346,
         (c_femdiv_p = NULL) => 0.0079961536, 0.0079961536),
      (c_born_usa > 152.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.85) => 0.1830514852,
         (c_pop_35_44_p > 12.85) => 0.0297662311,
         (c_pop_35_44_p = NULL) => 0.0991588799, 0.0991588799),
      (c_born_usa = NULL) => 0.0207005637, 0.0207005637),
   (f_prevaddrlenofres_d = NULL) => 0.0298176268, 0.0298176268),
(r_I60_inq_comm_recency_d > 549) => -0.0020463236,
(r_I60_inq_comm_recency_d = NULL) => -0.0011112660, 0.0009265991);

// Tree: 171 
woFDN_FLA__D_lgt_171 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 183.5) => 0.0000064499,
(f_curraddrcartheftindex_i > 183.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 17.85) => -0.0241702404,
      (C_INC_25K_P > 17.85) => 0.0898005723,
      (C_INC_25K_P = NULL) => 0.0046275238, 0.0046275238),
   (r_C23_inp_addr_occ_index_d > 2) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08050052365) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.01668869625) => 0.1598704000,
         (f_add_input_nhood_VAC_pct_i > 0.01668869625) => -0.0137837576,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0495936722, 0.0495936722),
      (f_add_curr_nhood_VAC_pct_i > 0.08050052365) => 0.1715065027,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0884116879, 0.0884116879),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0298003444, 0.0298003444),
(f_curraddrcartheftindex_i = NULL) => -0.0121630908, 0.0013916469);

// Tree: 172 
woFDN_FLA__D_lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.95) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27836.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 25140) => 
            map(
            (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.15) => -0.0245479062,
            (c_pop_35_44_p > 15.15) => 0.0793192898,
            (c_pop_35_44_p = NULL) => 0.0112441681, 0.0112441681),
         (f_curraddrmedianincome_d > 25140) => 0.1055589733,
         (f_curraddrmedianincome_d = NULL) => 0.0272499064, 0.0272499064),
      (f_curraddrmedianincome_d > 27836.5) => -0.0027187697,
      (f_curraddrmedianincome_d = NULL) => 0.0068868102, -0.0007266245),
   (c_manufacturing > 16.55) => -0.0516097633,
   (c_manufacturing = NULL) => -0.0046441978, -0.0046441978),
(c_pop_0_5_p > 19.95) => 0.1196999572,
(c_pop_0_5_p = NULL) => -0.0005383305, -0.0038349832);

// Tree: 173 
woFDN_FLA__D_lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 70.55) => -0.0061671601,
   (c_low_hval > 70.55) => -0.1275662862,
   (c_low_hval = NULL) => -0.0462000083, -0.0077660807),
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 119.5) => 0.2029339422,
      (c_easiqlife > 119.5) => 0.0306079442,
      (c_easiqlife = NULL) => 0.1105045433, 0.1105045433),
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 15.35) => 0.0288432677,
      (C_INC_25K_P > 15.35) => -0.0395588264,
      (C_INC_25K_P = NULL) => 0.0166037548, 0.0166037548),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0224791114, 0.0224791114),
(f_rel_felony_count_i = NULL) => -0.0193359866, -0.0036595753);

// Tree: 174 
woFDN_FLA__D_lgt_174 := map(
(NULL < c_info and c_info <= 27.55) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 25.5) => 
         map(
         (NULL < c_exp_homes and c_exp_homes <= 173.5) => 
            map(
            (NULL < c_hh6_p and c_hh6_p <= 2.95) => 0.0569762197,
            (c_hh6_p > 2.95) => -0.0497574972,
            (c_hh6_p = NULL) => 0.0309259566, 0.0309259566),
         (c_exp_homes > 173.5) => 0.2083637879,
         (c_exp_homes = NULL) => 0.0588090444, 0.0588090444),
      (r_C13_max_lres_d > 25.5) => -0.0000444243,
      (r_C13_max_lres_d = NULL) => 0.0017234022, 0.0017234022),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0488095651,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0284325103, -0.0007550819),
(c_info > 27.55) => 0.1888830139,
(c_info = NULL) => -0.0093200775, 0.0000276919);

// Tree: 175 
woFDN_FLA__D_lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 16.35) => 0.0544808743,
   (c_white_col > 16.35) => -0.0129863168,
   (c_white_col = NULL) => 0.0427001189, -0.0102295326),
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 0.0081994536,
   (r_F03_input_add_not_most_rec_i > 0.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 136.5) => 0.0444812046,
      (c_serv_empl > 136.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 100.5) => 0.3134720014,
         (f_curraddrcrimeindex_i > 100.5) => 0.0747184615,
         (f_curraddrcrimeindex_i = NULL) => 0.2010013256, 0.2010013256),
      (c_serv_empl = NULL) => 0.0934190202, 0.0934190202),
   (r_F03_input_add_not_most_rec_i = NULL) => 0.0204610418, 0.0204610418),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0003371972, -0.0033383620);

// Tree: 176 
woFDN_FLA__D_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 46900.5) => 0.0283757890,
      (f_curraddrmedianincome_d > 46900.5) => -0.0039389262,
      (f_curraddrmedianincome_d = NULL) => 0.0028392286, 0.0028392286),
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_robbery and c_robbery <= 165.5) => 0.0179222217,
         (c_robbery > 165.5) => 0.2022497703,
         (c_robbery = NULL) => 0.0347996094, 0.0347996094),
      (c_pop_55_64_p > 17.45) => 0.2568207130,
      (c_pop_55_64_p = NULL) => 0.0537570764, 0.0537570764),
   (f_util_adl_count_n = NULL) => 0.0152538350, 0.0062417064),
(c_pop_18_24_p > 11.15) => -0.0246576365,
(c_pop_18_24_p = NULL) => 0.0101618981, -0.0006977772);

// Tree: 177 
woFDN_FLA__D_lgt_177 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72490) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
      map(
      (NULL < c_medi_indx and c_medi_indx <= 102.5) => -0.0387549267,
      (c_medi_indx > 102.5) => 0.1097976157,
      (c_medi_indx = NULL) => 0.0209804871, 0.0209804871),
   (f_util_adl_count_n > 3.5) => 0.1621366330,
   (f_util_adl_count_n = NULL) => 0.0532447490, 0.0532447490),
(f_addrchangevaluediff_d > -72490) => 0.0020571112,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -5253) => -0.0397970709,
   (r_A49_Curr_AVM_Chg_1yr_i > -5253) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 2.965) => 0.0165697106,
      (c_hhsize > 2.965) => 0.1241979316,
      (c_hhsize = NULL) => 0.0431324342, 0.0431324342),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0085157422, -0.0010653243), 0.0023321629);

// Tree: 178 
woFDN_FLA__D_lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 14.55) => -0.0072531306,
(c_rnt1250_p > 14.55) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.35) => 0.0046676084,
   (c_pop_6_11_p > 9.35) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 160454) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 137688) => 0.0706965120,
         (f_curraddrmedianvalue_d > 137688) => 0.2553358282,
         (f_curraddrmedianvalue_d = NULL) => 0.1381045163, 0.1381045163),
      (f_curraddrmedianvalue_d > 160454) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 86.5) => 0.1721327002,
         (c_easiqlife > 86.5) => 0.0248134435,
         (c_easiqlife = NULL) => 0.0489724501, 0.0489724501),
      (f_curraddrmedianvalue_d = NULL) => 0.0648498870, 0.0648498870),
   (c_pop_6_11_p = NULL) => 0.0223403124, 0.0223403124),
(c_rnt1250_p = NULL) => -0.0005102512, 0.0014679320);

// Tree: 179 
woFDN_FLA__D_lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 0.0005696724,
(f_rel_incomeover50_count_d > 22.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 212918.5) => -0.1573020705,
   (r_A46_Curr_AVM_AutoVal_d > 212918.5) => -0.0161646375,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0382389755, -0.0572153464),
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.85) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 158.5) => 
         map(
         (NULL < c_low_hval and c_low_hval <= 2.35) => 0.1587530268,
         (c_low_hval > 2.35) => 0.0470349939,
         (c_low_hval = NULL) => 0.0951161726, 0.0951161726),
      (c_asian_lang > 158.5) => -0.0226384738,
      (c_asian_lang = NULL) => 0.0486459482, 0.0486459482),
   (c_pop_45_54_p > 16.85) => -0.0625989453,
   (c_pop_45_54_p = NULL) => 0.0167314296, 0.0167314296), -0.0001001891);

// Tree: 180 
woFDN_FLA__D_lgt_180 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < c_retail and c_retail <= 46.65) => -0.0037323656,
   (c_retail > 46.65) => 0.0707026330,
   (c_retail = NULL) => 0.0421269854, -0.0016142331),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 17.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 23.25) => 0.0913768839,
      (c_newhouse > 23.25) => -0.0779848008,
      (c_newhouse = NULL) => 0.0141678806, 0.0141678806),
   (C_INC_50K_P > 17.5) => 0.2013983495,
   (C_INC_50K_P = NULL) => 0.0652307358, 0.0652307358),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 5.75) => -0.0390774481,
   (c_professional > 5.75) => 0.0459697720,
   (c_professional = NULL) => -0.0008347384, -0.0008347384), -0.0006021925);

// Tree: 181 
woFDN_FLA__D_lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 194481.5) => 
      map(
      (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => 
         map(
         (NULL < c_rape and c_rape <= 110) => -0.0800527344,
         (c_rape > 110) => 0.1197264138,
         (c_rape = NULL) => 0.0222438174, 0.0222438174),
      (f_divaddrsuspidcountnew_i > 0.5) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 7.25) => 0.0732552238,
         (C_INC_125K_P > 7.25) => 0.2321584404,
         (C_INC_125K_P = NULL) => 0.1373291015, 0.1373291015),
      (f_divaddrsuspidcountnew_i = NULL) => 0.0714526975, 0.0714526975),
   (c_med_hval > 194481.5) => -0.0007512756,
   (c_med_hval = NULL) => 0.0271304184, 0.0271304184),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0056265008,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0036497659, -0.0035279541);

// Tree: 182 
woFDN_FLA__D_lgt_182 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 6.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3773325748) => 0.0042591612,
   (f_add_input_mobility_index_i > 0.3773325748) => -0.0232643427,
   (f_add_input_mobility_index_i = NULL) => 0.0518499582, -0.0000303086),
(f_hh_tot_derog_i > 6.5) => 
   map(
   (NULL < c_rnt1500_p and c_rnt1500_p <= 6.35) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 5.75) => 0.1672494268,
      (c_newhouse > 5.75) => 0.0219949971,
      (c_newhouse = NULL) => 0.0880197379, 0.0880197379),
   (c_rnt1500_p > 6.35) => -0.0857937690,
   (c_rnt1500_p = NULL) => 0.0391073943, 0.0391073943),
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 99.5) => 0.0695627600,
   (c_easiqlife > 99.5) => -0.0390180463,
   (c_easiqlife = NULL) => 0.0013329290, 0.0013329290), 0.0006119546);

// Tree: 183 
woFDN_FLA__D_lgt_183 := map(
(NULL < c_oldhouse and c_oldhouse <= 613.2) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 189) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0035554130,
      (k_inq_adls_per_addr_i > 3.5) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 12.25) => -0.0136263885,
         (C_INC_25K_P > 12.25) => -0.1335065882,
         (C_INC_25K_P = NULL) => -0.0428279756, -0.0428279756),
      (k_inq_adls_per_addr_i = NULL) => -0.0043398586, -0.0043398586),
   (c_totcrime > 189) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 0.1447249674,
      (r_C12_Num_NonDerogs_d > 2.5) => 0.0165269635,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0557352877, 0.0557352877),
   (c_totcrime = NULL) => -0.0028544841, -0.0028544841),
(c_oldhouse > 613.2) => -0.0557656216,
(c_oldhouse = NULL) => 0.0131666962, -0.0041183719);

// Tree: 184 
woFDN_FLA__D_lgt_184 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 92.2) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => 0.0010751985,
   (f_util_adl_count_n > 7.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 165.5) => 
         map(
         (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 3.5) => 0.2342098119,
         (f_rel_ageover30_count_d > 3.5) => 
            map(
            (NULL < c_no_labfor and c_no_labfor <= 90.5) => -0.0097793777,
            (c_no_labfor > 90.5) => 0.1117566834,
            (c_no_labfor = NULL) => 0.0458169056, 0.0458169056),
         (f_rel_ageover30_count_d = NULL) => 0.0728527896, 0.0728527896),
      (c_sub_bus > 165.5) => -0.0721695671,
      (c_sub_bus = NULL) => 0.0458283283, 0.0458283283),
   (f_util_adl_count_n = NULL) => -0.0029547873, 0.0029939667),
(C_RENTOCC_P > 92.2) => -0.0929540677,
(C_RENTOCC_P = NULL) => 0.0194548016, 0.0026220941);

// Tree: 185 
woFDN_FLA__D_lgt_185 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 4.25) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.15703172865) => -0.0047280918,
      (f_add_curr_nhood_MFD_pct_i > 0.15703172865) => 0.1105741209,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0489345732, 0.0489345732),
   (c_high_ed > 4.25) => 0.0068920963,
   (c_high_ed = NULL) => -0.0127433162, 0.0077794121),
(r_D31_ALL_Bk_i > 1.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 132.5) => -0.0917372962,
   (r_C13_max_lres_d > 132.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 27.65) => -0.0221248337,
      (C_INC_75K_P > 27.65) => 0.1972095400,
      (C_INC_75K_P = NULL) => -0.0056747556, -0.0056747556),
   (r_C13_max_lres_d = NULL) => -0.0340478854, -0.0340478854),
(r_D31_ALL_Bk_i = NULL) => 0.0016400208, 0.0040777884);

// Tree: 186 
woFDN_FLA__D_lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3923820453) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.75) => 0.0059940204,
      (c_pop_6_11_p > 15.75) => 0.1347275776,
      (c_pop_6_11_p = NULL) => -0.0252261662, 0.0063723492),
   (f_add_input_mobility_index_i > 0.3923820453) => 
      map(
      (NULL < c_bargains and c_bargains <= 117.5) => -0.0650407200,
      (c_bargains > 117.5) => -0.0024632190,
      (c_bargains = NULL) => 0.0059718307, -0.0244791884),
   (f_add_input_mobility_index_i = NULL) => -0.0132293994, 0.0016901830),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0789883890,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 9.8) => -0.0671259068,
   (c_hh4_p > 9.8) => 0.0414259390,
   (c_hh4_p = NULL) => 0.0022881987, 0.0022881987), 0.0020397258);

// Tree: 187 
woFDN_FLA__D_lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => -0.0006174308,
      (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0705949837,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0009656915, -0.0009656915),
   (r_L72_Add_Vacant_i > 0.5) => 0.1108083927,
   (r_L72_Add_Vacant_i = NULL) => -0.0002588914, -0.0002588914),
(f_rel_bankrupt_count_i > 7.5) => 
   map(
   (NULL < c_mort_indx and c_mort_indx <= 94.5) => -0.1159191037,
   (c_mort_indx > 94.5) => -0.0122065182,
   (c_mort_indx = NULL) => -0.0743019516, -0.0743019516),
(f_rel_bankrupt_count_i = NULL) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.85) => -0.0454263820,
   (c_pop_0_5_p > 7.85) => 0.0434011561,
   (c_pop_0_5_p = NULL) => -0.0018401987, -0.0018401987), -0.0012101701);

// Tree: 188 
woFDN_FLA__D_lgt_188 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 12.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 1.05) => -0.0063479389,
      (c_hval_20k_p > 1.05) => 0.0184637702,
      (c_hval_20k_p = NULL) => -0.0257332401, 0.0001438148),
   (f_srchfraudsrchcount_i > 12.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.15) => 0.0001286237,
      (c_pop_45_54_p > 14.15) => 0.1359815095,
      (c_pop_45_54_p = NULL) => 0.0620615569, 0.0620615569),
   (f_srchfraudsrchcount_i = NULL) => 0.0008253861, 0.0008253861),
(f_inq_count24_i > 12.5) => -0.0668856980,
(f_inq_count24_i = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 16.15) => 0.0787164170,
   (C_INC_75K_P > 16.15) => -0.0090615834,
   (C_INC_75K_P = NULL) => 0.0266998241, 0.0266998241), 0.0004803930);

// Tree: 189 
woFDN_FLA__D_lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 38.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 160500) => -0.0055426007,
   (k_estimated_income_d > 160500) => 0.1713443563,
   (k_estimated_income_d = NULL) => -0.0045775794, -0.0045775794),
(f_phones_per_addr_curr_i > 38.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 49) => 0.0777243337,
      (c_many_cars > 49) => -0.0813700211,
      (c_many_cars = NULL) => -0.0140608710, -0.0140608710),
   (f_rel_under25miles_cnt_d > 4.5) => 0.1432708659,
   (f_rel_under25miles_cnt_d = NULL) => 0.0513779931, 0.0513779931),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 28.7) => 0.0675969768,
   (c_fammar18_p > 28.7) => -0.0260831753,
   (c_fammar18_p = NULL) => 0.0082222325, 0.0082222325), -0.0033738291);

// Tree: 190 
woFDN_FLA__D_lgt_190 := map(
(NULL < c_asian_lang and c_asian_lang <= 194.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 9.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 16.65) => -0.0079303148,
      (c_hval_200k_p > 16.65) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3248205253) => 0.0119220259,
         (f_add_curr_mobility_index_i > 0.3248205253) => 0.0674095937,
         (f_add_curr_mobility_index_i = NULL) => 0.0285574588, 0.0285574588),
      (c_hval_200k_p = NULL) => -0.0046901122, -0.0046901122),
   (r_C14_addrs_10yr_i > 9.5) => 0.0719586829,
   (r_C14_addrs_10yr_i = NULL) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 136.5) => 0.0233370952,
      (c_ab_av_edu > 136.5) => -0.0732106410,
      (c_ab_av_edu = NULL) => -0.0088454836, -0.0088454836), -0.0041094079),
(c_asian_lang > 194.5) => -0.0489887866,
(c_asian_lang = NULL) => -0.0293387887, -0.0067209761);

// Tree: 191 
woFDN_FLA__D_lgt_191 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 12.05) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => 0.0086459431,
      (f_srchaddrsrchcount_i > 1.5) => 0.1449589343,
      (f_srchaddrsrchcount_i = NULL) => 0.0726295921, 0.0726295921),
   (c_incollege > 12.05) => -0.1131694143,
   (c_incollege = NULL) => 0.0330820124, 0.0330820124),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 163.5) => -0.0053114527,
   (c_totcrime > 163.5) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 161.5) => 0.0954144679,
      (c_cartheft > 161.5) => 0.0022433642,
      (c_cartheft = NULL) => 0.0310232059, 0.0310232059),
   (c_totcrime = NULL) => -0.0429536105, -0.0022928679),
(r_C10_M_Hdr_FS_d = NULL) => -0.0170124263, -0.0017822681);

// Tree: 192 
woFDN_FLA__D_lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 120) => 0.0764083356,
(r_D32_Mos_Since_Fel_LS_d > 120) => 
   map(
   (NULL < c_unempl and c_unempl <= 170.5) => -0.0010155013,
   (c_unempl > 170.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 52.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.11163922155) => -0.1008717840,
         (f_add_curr_nhood_VAC_pct_i > 0.11163922155) => 0.0237389032,
         (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0679008629, -0.0679008629),
      (c_civ_emp > 52.5) => -0.0093138654,
      (c_civ_emp = NULL) => -0.0316534179, -0.0316534179),
   (c_unempl = NULL) => 0.0050861166, -0.0025571716),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 15.05) => -0.0281835799,
   (c_hh4_p > 15.05) => 0.0571304879,
   (c_hh4_p = NULL) => 0.0063607666, 0.0063607666), -0.0019794019);

// Tree: 193 
woFDN_FLA__D_lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0080484547,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.1776713385,
   (f_adl_per_email_i > 0.5) => -0.0326847562,
   (f_adl_per_email_i = NULL) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 233.1) => 0.0034735867,
      (c_housingcpi > 233.1) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity']) => -0.0420858537,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => 
            map(
            (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 7.5) => 0.0827228557,
            (f_hh_members_ct_d > 7.5) => 0.2073443578,
            (f_hh_members_ct_d = NULL) => 0.0995392512, 0.0995392512),
         (nf_seg_FraudPoint_3_0 = '') => 0.0647767254, 0.0647767254),
      (c_housingcpi = NULL) => 0.0155844798, 0.0155844798), 0.0180542113),
(f_prevaddrageoldest_d = NULL) => -0.0154794734, -0.0021067196);

// Tree: 194 
woFDN_FLA__D_lgt_194 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 45) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 15.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 105149) => 0.0949333171,
      (r_L80_Inp_AVM_AutoVal_d > 105149) => -0.0164237541,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.21537352115) => 0.0378411564,
         (f_add_curr_mobility_index_i > 0.21537352115) => -0.0386853736,
         (f_add_curr_mobility_index_i = NULL) => -0.0187675096, -0.0187675096), -0.0073015116),
   (f_rel_educationover12_count_d > 15.5) => -0.0841771809,
   (f_rel_educationover12_count_d = NULL) => -0.0194079162, -0.0194079162),
(r_F01_inp_addr_address_score_d > 45) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 28.55) => 0.0001045383,
   (c_hval_20k_p > 28.55) => 0.1164811802,
   (c_hval_20k_p = NULL) => 0.0147387375, 0.0013435970),
(r_F01_inp_addr_address_score_d = NULL) => 0.0016818143, 0.0000415711);

// Tree: 195 
woFDN_FLA__D_lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 2.15) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 4.5) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 39.5) => 0.1452862489,
         (r_A50_pb_total_dollars_d > 39.5) => -0.0595166032,
         (r_A50_pb_total_dollars_d = NULL) => -0.0376485368, -0.0376485368),
      (f_inq_Collection_count_i > 4.5) => -0.1722939273,
      (f_inq_Collection_count_i = NULL) => -0.0504123192, -0.0504123192),
   (c_pop_18_24_p > 2.15) => 
      map(
      (NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 0.5) => 0.0088109750,
      (r_I60_inq_auto_count12_i > 0.5) => -0.0334074542,
      (r_I60_inq_auto_count12_i = NULL) => 0.0121033417, 0.0064709426),
   (c_pop_18_24_p = NULL) => 0.0039291922, 0.0039291922),
(c_hval_80k_p > 40.05) => -0.1201480611,
(c_hval_80k_p = NULL) => 0.0184238219, 0.0031321349);

// Tree: 196 
woFDN_FLA__D_lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0901549116,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 44.35) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 25.95) => -0.0023014334,
      (c_hval_60k_p > 25.95) => 0.0715429974,
      (c_hval_60k_p = NULL) => -0.0012438468, -0.0012438468),
   (c_hval_60k_p > 44.35) => -0.1134432980,
   (c_hval_60k_p = NULL) => 0.0226557139, -0.0012454473),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 13.75) => 0.0623285063,
   (c_hh3_p > 13.75) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.6) => -0.0951723717,
      (c_hval_125k_p > 4.6) => 0.0274138970,
      (c_hval_125k_p = NULL) => -0.0315218091, -0.0315218091),
   (c_hh3_p = NULL) => 0.0042306920, 0.0042306920), -0.0033822625);

// Tree: 197 
woFDN_FLA__D_lgt_197 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -91324) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => 0.0064736954,
   (r_L79_adls_per_addr_c6_i > 1.5) => 0.1340259194,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0470043086, 0.0470043086),
(f_addrchangevaluediff_d > -91324) => -0.0009610995,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 11.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => -0.0043599216,
      (f_srchfraudsrchcount_i > 6.5) => -0.0907353936,
      (f_srchfraudsrchcount_i = NULL) => -0.0069541791, -0.0069541791),
   (f_inq_count_i > 11.5) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 14.3) => -0.0019215559,
      (C_INC_100K_P > 14.3) => 0.1818079395,
      (C_INC_100K_P = NULL) => 0.0881765621, 0.0881765621),
   (f_inq_count_i = NULL) => 0.0114969652, -0.0022179917), -0.0004382631);

// Tree: 198 
woFDN_FLA__D_lgt_198 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0961084311,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5693) => 0.0046304096,
      (f_liens_unrel_SC_total_amt_i > 5693) => 0.1090924097,
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0051469848, 0.0051469848),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 2.5) => 0.0392897736,
      (f_srchaddrsrchcount_i > 2.5) => -0.0980142873,
      (f_srchaddrsrchcount_i = NULL) => -0.0471253697, -0.0471253697),
   (r_I60_inq_comm_count12_i = NULL) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 8.85) => 0.0398373025,
      (c_pop_12_17_p > 8.85) => -0.0593068252,
      (c_pop_12_17_p = NULL) => 0.0016052533, 0.0016052533), 0.0044913185),
(c_pop_45_54_p = NULL) => -0.0342313763, 0.0022688340);

// Tree: 199 
woFDN_FLA__D_lgt_199 := map(
(NULL < c_food and c_food <= 68.7) => 
   map(
   (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0052923661,
   (f_prevaddroccupantowned_i > 0.5) => 0.0293475585,
   (f_prevaddroccupantowned_i = NULL) => -0.0070252600, -0.0028065039),
(c_food > 68.7) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 106.2) => 0.1804045747,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 106.2) => -0.0150064691,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.1184535933,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 7.35) => 0.0006900191,
         (c_hh5_p > 7.35) => 0.1457420320,
         (c_hh5_p = NULL) => 0.0623134233, 0.0623134233),
      (nf_seg_FraudPoint_3_0 = '') => 0.0089996488, 0.0089996488), 0.0407982482),
(c_food = NULL) => -0.0393819530, -0.0022360725);

// Tree: 200 
woFDN_FLA__D_lgt_200 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 9.5) => 
   map(
   (NULL < c_food and c_food <= 68.85) => -0.0044033333,
   (c_food > 68.85) => 
      map(
      (NULL < c_retail and c_retail <= 0.05) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 57.5) => 0.1313619515,
         (f_fp_prevaddrcrimeindex_i > 57.5) => -0.0316618300,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0250643134, 0.0250643134),
      (c_retail > 0.05) => 0.2108698739,
      (c_retail = NULL) => 0.0511071413, 0.0511071413),
   (c_food = NULL) => -0.0309188002, -0.0033057654),
(f_inq_HighRiskCredit_count_i > 9.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 38) => 0.0024145129,
   (r_C13_Curr_Addr_LRes_d > 38) => -0.1156151439,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0603219713, -0.0603219713),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0038988946, -0.0037115387);

// Tree: 201 
woFDN_FLA__D_lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0063588975,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 5.15) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => -0.0304604740,
      (r_L79_adls_per_addr_curr_i > 2.5) => 0.0545182668,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0030921195, -0.0030921195),
   (c_finance > 5.15) => 
      map(
      (NULL < c_larceny and c_larceny <= 158.5) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 1.45) => 0.1793196254,
         (c_pop_75_84_p > 1.45) => 0.0188213266,
         (c_pop_75_84_p = NULL) => 0.0505403579, 0.0505403579),
      (c_larceny > 158.5) => 0.2366914310,
      (c_larceny = NULL) => 0.0935418216, 0.0935418216),
   (c_finance = NULL) => 0.1030990235, 0.0366429139),
(r_L70_Add_Standardized_i = NULL) => -0.0027858656, -0.0027858656);

// Tree: 202 
woFDN_FLA__D_lgt_202 := map(
(NULL < c_rich_nfam and c_rich_nfam <= 182.5) => -0.0038338694,
(c_rich_nfam > 182.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 7.55) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.9609480239) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 387788) => -0.0045996038,
         (f_prevaddrmedianvalue_d > 387788) => 0.1984748460,
         (f_prevaddrmedianvalue_d = NULL) => 0.0437181101, 0.0437181101),
      (f_add_curr_nhood_SFD_pct_d > 0.9609480239) => 0.2928452443,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0840392647, 0.0840392647),
   (C_INC_125K_P > 7.55) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 61) => 0.0587959875,
      (f_curraddrcrimeindex_i > 61) => -0.0369471878,
      (f_curraddrcrimeindex_i = NULL) => 0.0120070415, 0.0120070415),
   (C_INC_125K_P = NULL) => 0.0303291913, 0.0303291913),
(c_rich_nfam = NULL) => 0.0153133188, 0.0003081809);

// Tree: 203 
woFDN_FLA__D_lgt_203 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 37441.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0020859544,
   (r_D33_eviction_count_i > 3.5) => 0.0766118519,
   (r_D33_eviction_count_i = NULL) => -0.0016162670, -0.0016162670),
(f_addrchangevaluediff_d > 37441.5) => 
   map(
   (NULL < c_hval_400k_p and c_hval_400k_p <= 11.35) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 3.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.2152395915) => 0.0623918183,
         (f_add_curr_nhood_MFD_pct_i > 0.2152395915) => 0.1902164642,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1269014527, 0.1269014527),
      (f_rel_homeover300_count_d > 3.5) => 0.0071924547,
      (f_rel_homeover300_count_d = NULL) => 0.0854637226, 0.0854637226),
   (c_hval_400k_p > 11.35) => -0.0082683566,
   (c_hval_400k_p = NULL) => 0.0368800794, 0.0368800794),
(f_addrchangevaluediff_d = NULL) => -0.0084688496, -0.0020343936);

// Tree: 204 
woFDN_FLA__D_lgt_204 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 47409) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => -0.0099346288,
   (f_inq_count_i > 3.5) => -0.1055305193,
   (f_inq_count_i = NULL) => -0.0414040835, -0.0414040835),
(r_L80_Inp_AVM_AutoVal_d > 47409) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.7398458792) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 0.5) => 0.1077162248,
      (f_corraddrnamecount_d > 0.5) => 0.0064732451,
      (f_corraddrnamecount_d = NULL) => 0.0090546892, 0.0090546892),
   (f_add_curr_nhood_MFD_pct_i > 0.7398458792) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 21.05) => 0.1707076906,
      (c_hh1_p > 21.05) => 0.0109988212,
      (c_hh1_p = NULL) => 0.0549693011, 0.0549693011),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0086555493, 0.0067922908),
(r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0023338278, 0.0015711464);

// Tree: 205 
woFDN_FLA__D_lgt_205 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 51.15) => 0.1294449225,
   (r_C12_source_profile_d > 51.15) => -0.0162301226,
   (r_C12_source_profile_d = NULL) => 0.0503283032, 0.0503283032),
(r_D33_Eviction_Recency_d > 30) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 52.5) => -0.0115304394,
   (f_prevaddrageoldest_d > 52.5) => 0.0130011606,
   (f_prevaddrageoldest_d = NULL) => 0.0019754108, 0.0019754108),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.26641059835) => -0.0865521321,
   (f_add_input_nhood_SFD_pct_d > 0.26641059835) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0733542717,
      (k_comb_age_d > 25.5) => 0.0575013014,
      (k_comb_age_d = NULL) => 0.0067820870, 0.0067820870),
   (f_add_input_nhood_SFD_pct_d = NULL) => -0.0214704334, -0.0214704334), 0.0020756437);

// Tree: 206 
woFDN_FLA__D_lgt_206 := map(
(NULL < f_mos_liens_rel_OT_fseen_d and f_mos_liens_rel_OT_fseen_d <= 42.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 26.05) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 27.15) => -0.0599192462,
      (c_fammar_p > 27.15) => -0.0024515484,
      (c_fammar_p = NULL) => -0.0032156565, -0.0032156565),
   (C_INC_25K_P > 26.05) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 1.5) => 0.2001434761,
      (f_assocsuspicousidcount_i > 1.5) => -0.0202551409,
      (f_assocsuspicousidcount_i = NULL) => 0.0731341036, 0.0731341036),
   (C_INC_25K_P = NULL) => 0.0143852540, -0.0021305297),
(f_mos_liens_rel_OT_fseen_d > 42.5) => -0.0686970534,
(f_mos_liens_rel_OT_fseen_d = NULL) => 
   map(
   (NULL < c_hval_1000k_p and c_hval_1000k_p <= 1) => -0.0389613928,
   (c_hval_1000k_p > 1) => 0.0773846583,
   (c_hval_1000k_p = NULL) => -0.0008975613, -0.0008975613), -0.0034078442);

// Tree: 207 
woFDN_FLA__D_lgt_207 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 1.35) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0878593915) => -0.0389899949,
      (f_add_curr_nhood_BUS_pct_i > 0.0878593915) => -0.1321272185,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0614835130, -0.0614835130),
   (c_hval_250k_p > 1.35) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00830164955) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 120.5) => -0.0198981032,
         (r_C13_max_lres_d > 120.5) => 0.1267633781,
         (r_C13_max_lres_d = NULL) => 0.0422937908, 0.0422937908),
      (f_add_curr_nhood_VAC_pct_i > 0.00830164955) => -0.0307572734,
      (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0062518209, -0.0062518209),
   (c_hval_250k_p = NULL) => 0.0293632871, -0.0227186538),
(r_F01_inp_addr_address_score_d > 75) => 0.0016351427,
(r_F01_inp_addr_address_score_d = NULL) => -0.0122968077, -0.0001119022);

// Tree: 208 
woFDN_FLA__D_lgt_208 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 103.5) => 
      map(
      (NULL < c_transport and c_transport <= 17.5) => -0.0046309194,
      (c_transport > 17.5) => 0.0633055246,
      (c_transport = NULL) => -0.0023867094, -0.0023867094),
   (f_addrchangecrimediff_i > 103.5) => 0.0751894632,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0086884956,
      (f_srchfraudsrchcountmo_i > 0.5) => 0.0625679791,
      (f_srchfraudsrchcountmo_i = NULL) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 8.15) => -0.0298069936,
         (c_hval_250k_p > 8.15) => 0.0568080616,
         (c_hval_250k_p = NULL) => 0.0049610215, 0.0049610215), -0.0052046148), -0.0025843362),
(r_L72_Add_Vacant_i > 0.5) => 0.0961789107,
(r_L72_Add_Vacant_i = NULL) => -0.0019455457, -0.0019455457);

// Tree: 209 
woFDN_FLA__D_lgt_209 := map(
(NULL < c_hh2_p and c_hh2_p <= 17.85) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 11.5) => 0.1351708128,
   (f_mos_inq_banko_cm_lseen_d > 11.5) => 0.0276870476,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0358503715, 0.0358503715),
(c_hh2_p > 17.85) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 22401) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 36.7) => -0.0272833294,
      (c_famotf18_p > 36.7) => -0.1173882370,
      (c_famotf18_p = NULL) => -0.0436123847, -0.0436123847),
   (f_prevaddrmedianincome_d > 22401) => 0.0021382712,
   (f_prevaddrmedianincome_d = NULL) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 66.5) => -0.0589513976,
      (c_serv_empl > 66.5) => 0.0456954636,
      (c_serv_empl = NULL) => 0.0013658904, 0.0013658904), 0.0003212244),
(c_hh2_p = NULL) => 0.0044148828, 0.0026635951);

// Tree: 210 
woFDN_FLA__D_lgt_210 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0008160864,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < r_C20_email_count_i and r_C20_email_count_i <= 6.5) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.06070219565) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0476781612,
         (f_varrisktype_i > 4.5) => 0.0767985829,
         (f_varrisktype_i = NULL) => -0.0290614047, -0.0290614047),
      (f_add_input_nhood_VAC_pct_i > 0.06070219565) => -0.1022522197,
      (f_add_input_nhood_VAC_pct_i = NULL) => -0.0466663224, -0.0466663224),
   (r_C20_email_count_i > 6.5) => 0.0510285992,
   (r_C20_email_count_i = NULL) => -0.0346452675, -0.0346452675),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < k_nap_addr_verd_d and k_nap_addr_verd_d <= 0.5) => 0.0521236659,
   (k_nap_addr_verd_d > 0.5) => -0.0707407124,
   (k_nap_addr_verd_d = NULL) => -0.0129221815, -0.0129221815), -0.0007809312);

// Tree: 211 
woFDN_FLA__D_lgt_211 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => -0.0039658558,
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.21816826905) => 0.1152631385,
   (f_add_curr_mobility_index_i > 0.21816826905) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 44) => -0.0785840746,
      (f_curraddrcartheftindex_i > 44) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 101.5) => 0.0328504796,
         (r_pb_order_freq_d > 101.5) => -0.0500011471,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 0.1376011481,
            (f_srchunvrfdphonecount_i > 0.5) => 0.0003954254,
            (f_srchunvrfdphonecount_i = NULL) => 0.0739875858, 0.0739875858), 0.0314748573),
      (f_curraddrcartheftindex_i = NULL) => 0.0094630709, 0.0094630709),
   (f_add_curr_mobility_index_i = NULL) => 0.0315364663, 0.0315364663),
(f_srchaddrsrchcount_i = NULL) => -0.0032665232, -0.0027798450);

// Tree: 212 
woFDN_FLA__D_lgt_212 := map(
(NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00477897935) => -0.0370525786,
(f_add_curr_nhood_BUS_pct_i > 0.00477897935) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0001641576,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 5.95) => 0.0008670660,
      (c_incollege > 5.95) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => 
            map(
            (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.24176587335) => 0.1607310490,
            (f_add_input_nhood_MFD_pct_i > 0.24176587335) => 0.0328022637,
            (f_add_input_nhood_MFD_pct_i = NULL) => 0.0855024866, 0.0855024866),
         (f_corraddrnamecount_d > 6.5) => 0.0154884602,
         (f_corraddrnamecount_d = NULL) => 0.0515101694, 0.0515101694),
      (c_incollege = NULL) => 0.0231526153, 0.0231526153),
   (f_rel_felony_count_i = NULL) => 0.0035906569, 0.0035906569),
(f_add_curr_nhood_BUS_pct_i = NULL) => -0.0085256175, -0.0012366685);

// Tree: 213 
woFDN_FLA__D_lgt_213 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 74.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125511) => 
      map(
      (NULL < c_families and c_families <= 1369) => 0.0192793877,
      (c_families > 1369) => 0.1920961182,
      (c_families = NULL) => 0.0251644980, 0.0251644980),
   (r_A46_Curr_AVM_AutoVal_d > 125511) => -0.0121678064,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0031570681, 0.0001544657),
(k_comb_age_d > 74.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 19.1) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 136) => -0.0182228979,
      (c_totcrime > 136) => 0.1390826319,
      (c_totcrime = NULL) => 0.0177450332, 0.0177450332),
   (c_hval_500k_p > 19.1) => 0.2504716769,
   (c_hval_500k_p = NULL) => 0.0459201716, 0.0459201716),
(k_comb_age_d = NULL) => 0.0016771027, 0.0016771027);

// Tree: 214 
woFDN_FLA__D_lgt_214 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 6.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 76) => 0.2115046903,
   (c_totcrime > 76) => -0.0055756437,
   (c_totcrime = NULL) => 0.0858984593, 0.0858984593),
(r_D32_Mos_Since_Crim_LS_d > 6.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0006437328,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 2.5) => 0.0702928174,
      (r_C14_Addr_Stability_v2_d > 2.5) => 0.0209564428,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0349003838, 0.0349003838),
   (r_L70_Add_Standardized_i = NULL) => 0.0034794747, 0.0034794747),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 92.5) => 0.0426539980,
   (c_very_rich > 92.5) => -0.0499546015,
   (c_very_rich = NULL) => -0.0122251721, -0.0122251721), 0.0042748493);

// Tree: 215 
woFDN_FLA__D_lgt_215 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 42.5) => 0.1183572534,
(f_mos_liens_unrel_FT_fseen_d > 42.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1288079234) => -0.0029788477,
   (f_add_curr_nhood_BUS_pct_i > 0.1288079234) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 0.0124785679,
      (f_hh_lienholders_i > 1.5) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 10.45) => 0.0416112472,
         (c_hval_175k_p > 10.45) => 0.2311137959,
         (c_hval_175k_p = NULL) => 0.0996010982, 0.0996010982),
      (f_hh_lienholders_i = NULL) => 0.0228046191, 0.0228046191),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0256240517, -0.0010358508),
(f_mos_liens_unrel_FT_fseen_d = NULL) => 
   map(
   (NULL < c_incollege and c_incollege <= 4.45) => 0.0631797814,
   (c_incollege > 4.45) => -0.0400594020,
   (c_incollege = NULL) => -0.0051812995, -0.0051812995), -0.0005974648);

// Tree: 216 
woFDN_FLA__D_lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184) => -0.0790931549,
(f_mos_liens_unrel_FT_lseen_d > 184) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1908.5) => -0.0007392662,
      (c_popover18 > 1908.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 29.2) => 0.0301017558,
         (c_famotf18_p > 29.2) => 0.1557875268,
         (c_famotf18_p = NULL) => 0.0342313360, 0.0342313360),
      (c_popover18 = NULL) => 0.0056494962, 0.0056494962),
   (c_asian_lang > 181.5) => -0.0259597057,
   (c_asian_lang = NULL) => 0.0428009285, 0.0019053356),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.09428104575) => 0.0774424097,
   (f_add_input_nhood_MFD_pct_i > 0.09428104575) => -0.0214451437,
   (f_add_input_nhood_MFD_pct_i = NULL) => -0.0430153751, -0.0011522632), 0.0009228160);

// Tree: 217 
woFDN_FLA__D_lgt_217 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -45425.5) => -0.0903076308,
(f_addrchangeincomediff_d > -45425.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 
      map(
      (NULL < c_health and c_health <= 2.25) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 0.15) => 0.1137754895,
         (c_hh6_p > 0.15) => 0.0207246568,
         (c_hh6_p = NULL) => 0.0568230139, 0.0568230139),
      (c_health > 2.25) => 0.0035493179,
      (c_health = NULL) => 0.0175368713, 0.0175368713),
   (r_C12_Num_NonDerogs_d > 2.5) => -0.0075496129,
   (r_C12_Num_NonDerogs_d = NULL) => -0.0000036732, -0.0000036732),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 30.65) => -0.0065804630,
   (c_hval_150k_p > 30.65) => 0.1007768465,
   (c_hval_150k_p = NULL) => 0.0176615425, -0.0012892261), -0.0008855826);

// Tree: 218 
woFDN_FLA__D_lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_hval_1001k_p and c_hval_1001k_p <= 14.35) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => 0.0031769624,
      (f_inq_count_i > 5.5) => 0.1718402281,
      (f_inq_count_i = NULL) => 0.0229229057, 0.0229229057),
   (c_hval_1001k_p > 14.35) => 0.3180739117,
   (c_hval_1001k_p = NULL) => 0.0716408393, 0.0497551376),
(f_rel_incomeover25_count_d > 1.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0093322003,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -12573) => 0.0916882919,
      (f_addrchangeincomediff_d > -12573) => 0.0103436096,
      (f_addrchangeincomediff_d = NULL) => 0.0290291919, 0.0166875144),
   (f_inq_Other_count_i = NULL) => -0.0032427697, -0.0032427697),
(f_rel_incomeover25_count_d = NULL) => -0.0121594850, -0.0001698324);

// Tree: 219 
woFDN_FLA__D_lgt_219 := map(
(NULL < f_vardobcount_i and f_vardobcount_i <= 0.5) => 
   map(
   (NULL < c_totsales and c_totsales <= 8502.5) => -0.1089949503,
   (c_totsales > 8502.5) => -0.0034350048,
   (c_totsales = NULL) => -0.0642543112, -0.0642543112),
(f_vardobcount_i > 0.5) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 15.45) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 25.35) => 0.0037988624,
      (c_pop_45_54_p > 25.35) => -0.0768205699,
      (c_pop_45_54_p = NULL) => 0.0016942314, 0.0016942314),
   (c_femdiv_p > 15.45) => 0.1073002753,
   (c_femdiv_p = NULL) => -0.0069435644, 0.0020939261),
(f_vardobcount_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 86.5) => 0.0524546663,
   (c_very_rich > 86.5) => -0.0360911224,
   (c_very_rich = NULL) => 0.0008029562, 0.0008029562), 0.0012436606);

// Tree: 220 
woFDN_FLA__D_lgt_220 := map(
(NULL < c_food and c_food <= 60.15) => -0.0053276499,
(c_food > 60.15) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 9.45) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.55) => 0.2342762887,
      (c_pop_45_54_p > 13.55) => 0.0604245617,
      (c_pop_45_54_p = NULL) => 0.1195341489, 0.1195341489),
   (c_pop_25_34_p > 9.45) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 58.5) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 42.9) => 0.0324713102,
         (c_low_ed > 42.9) => 0.2017654232,
         (c_low_ed = NULL) => 0.0988866930, 0.0988866930),
      (c_no_labfor > 58.5) => -0.0260028846,
      (c_no_labfor = NULL) => 0.0106464271, 0.0106464271),
   (c_pop_25_34_p = NULL) => 0.0381896957, 0.0381896957),
(c_food = NULL) => -0.0172249540, -0.0035568463);

// Tree: 221 
woFDN_FLA__D_lgt_221 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 13.95) => 0.0051522837,
(C_INC_25K_P > 13.95) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 18) => 
      map(
      (NULL < c_child and c_child <= 24.55) => -0.0270796269,
      (c_child > 24.55) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.88059762345) => -0.1105397893,
         (f_add_curr_nhood_SFD_pct_d > 0.88059762345) => -0.0022783098,
         (f_add_curr_nhood_SFD_pct_d = NULL) => -0.0824060496, -0.0824060496),
      (c_child = NULL) => -0.0522958675, -0.0522958675),
   (r_I60_inq_recency_d > 18) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 191.5) => -0.0171598588,
      (c_sub_bus > 191.5) => 0.1163058352,
      (c_sub_bus = NULL) => -0.0068094581, -0.0068094581),
   (r_I60_inq_recency_d = NULL) => -0.0228451003, -0.0228451003),
(C_INC_25K_P = NULL) => -0.0132400844, 0.0005066089);

// Tree: 222 
woFDN_FLA__D_lgt_222 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0038807818,
(f_addrchangecrimediff_i > 61.5) => 
   map(
   (NULL < c_food and c_food <= 23.7) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 81.5) => 0.0207962510,
      (c_mort_indx > 81.5) => 0.1781720285,
      (c_mort_indx = NULL) => 0.1080802956, 0.1080802956),
   (c_food > 23.7) => -0.0379620613,
   (c_food = NULL) => 0.0580547369, 0.0580547369),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 984.5) => -0.0375595575,
   (c_popover18 > 984.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1957.5) => 0.0792453191,
      (c_med_yearblt > 1957.5) => 0.0064073997,
      (c_med_yearblt = NULL) => 0.0159224502, 0.0159224502),
   (c_popover18 = NULL) => 0.0131489727, -0.0004076589), -0.0021939865);

// Tree: 223 
woFDN_FLA__D_lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 41670.5) => 
   map(
   (NULL < c_retail and c_retail <= 21.65) => -0.0734170743,
   (c_retail > 21.65) => 0.0799504556,
   (c_retail = NULL) => -0.0473341610, -0.0473341610),
(r_A46_Curr_AVM_AutoVal_d > 41670.5) => 0.0013509222,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => -0.0127218329,
   (f_rel_under25miles_cnt_d > 5.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 2.5) => 0.0104845337,
      (r_D30_Derog_Count_i > 2.5) => 
         map(
         (NULL < c_hval_60k_p and c_hval_60k_p <= 11.25) => 0.0357367524,
         (c_hval_60k_p > 11.25) => 0.1780916621,
         (c_hval_60k_p = NULL) => 0.0596688822, 0.0596688822),
      (r_D30_Derog_Count_i = NULL) => 0.0185117906, 0.0185117906),
   (f_rel_under25miles_cnt_d = NULL) => 0.0062653660, 0.0002457760), -0.0002755430);

// Tree: 224 
woFDN_FLA__D_lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 7.9) => -0.0194706506,
         (c_famotf18_p > 7.9) => 0.1144403104,
         (c_famotf18_p = NULL) => 0.0564788497, 0.0564788497),
      (f_idverrisktype_i > 2) => -0.0638343205,
      (f_idverrisktype_i = NULL) => 0.0167755035, 0.0167755035),
   (c_hval_20k_p > 0.65) => 0.1614194755,
   (c_hval_20k_p = NULL) => 0.0466226724, 0.0466226724),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 26.5) => 0.0008473384,
   (f_srchaddrsrchcount_i > 26.5) => 0.0605353741,
   (f_srchaddrsrchcount_i = NULL) => 0.0014319421, 0.0014319421),
(r_C10_M_Hdr_FS_d = NULL) => 0.0086905411, 0.0024512139);

// Tree: 225 
woFDN_FLA__D_lgt_225 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0664864570,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0039949410,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0186779888, -0.0033051574),
(c_hh3_p > 23.25) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 59.85) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 1.5) => 
         map(
         (NULL < c_rental and c_rental <= 186.5) => 0.0262518143,
         (c_rental > 186.5) => 0.1272449970,
         (c_rental = NULL) => 0.0303968114, 0.0303968114),
      (f_hh_criminals_i > 1.5) => -0.0473380076,
      (f_hh_criminals_i = NULL) => 0.0213964089, 0.0213964089),
   (c_fammar18_p > 59.85) => 0.1529161942,
   (c_fammar18_p = NULL) => 0.0277545083, 0.0277545083),
(c_hh3_p = NULL) => -0.0073344860, 0.0011127018);

// Tree: 226 
woFDN_FLA__D_lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0119644176,
   (f_inq_Collection_count_i > 1.5) => -0.1347314703,
   (f_inq_Collection_count_i = NULL) => -0.0751017590, -0.0751017590),
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 16.55) => 0.0081166533,
      (c_hval_80k_p > 16.55) => -0.0308539915,
      (c_hval_80k_p = NULL) => 0.0044065968, 0.0044065968),
   (c_asian_lang > 181.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 46.75) => 0.0995152948,
      (c_civ_emp > 46.75) => -0.0329740577,
      (c_civ_emp = NULL) => -0.0279126667, -0.0279126667),
   (c_asian_lang = NULL) => 0.0054223554, -0.0002153293),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0061279267, -0.0009232959);

// Tree: 227 
woFDN_FLA__D_lgt_227 := map(
(NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 1900) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 38.95) => -0.0032401621,
   (c_hval_750k_p > 38.95) => 0.0325584159,
   (c_hval_750k_p = NULL) => 0.0043409727, -0.0003337493),
(f_acc_damage_amt_last_i > 1900) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 24.25) => -0.0241114999,
   (c_lowinc > 24.25) => 0.1995188180,
   (c_lowinc = NULL) => 0.0928327948, 0.0928327948),
(f_acc_damage_amt_last_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0682205460,
   (k_comb_age_d > 27.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 2.55) => -0.0162182488,
      (c_hval_125k_p > 2.55) => 0.0692684323,
      (c_hval_125k_p = NULL) => 0.0269400757, 0.0269400757),
   (k_comb_age_d = NULL) => -0.0042921284, -0.0042921284), 0.0004206537);

// Tree: 228 
woFDN_FLA__D_lgt_228 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < c_pop00 and c_pop00 <= 2277.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 192.5) => 0.0838670436,
      (f_M_Bureau_ADL_FS_noTU_d > 192.5) => -0.0565619637,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0080186032, -0.0080186032),
   (c_pop00 > 2277.5) => 0.1582920243,
   (c_pop00 = NULL) => 0.0352677245, 0.0352677245),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 8.5) => -0.0040010716,
   (f_assocsuspicousidcount_i > 8.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 284.5) => 0.0019051182,
      (r_C10_M_Hdr_FS_d > 284.5) => -0.1003998457,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0430201051, -0.0430201051),
   (f_assocsuspicousidcount_i = NULL) => -0.0054628157, -0.0054628157),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0018957272, -0.0046982493);

// Tree: 229 
woFDN_FLA__D_lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 9.55) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 610.5) => -0.0089629222,
      (c_med_rent > 610.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 39.5) => 
            map(
            (NULL < C_INC_50K_P and C_INC_50K_P <= 12.45) => 0.0243905572,
            (C_INC_50K_P > 12.45) => 0.2029346413,
            (C_INC_50K_P = NULL) => 0.1274428473, 0.1274428473),
         (f_mos_inq_banko_cm_fseen_d > 39.5) => 0.0291413737,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0410591277, 0.0410591277),
      (c_med_rent = NULL) => 0.0178011611, 0.0178011611),
   (C_INC_100K_P > 9.55) => -0.0051683331,
   (C_INC_100K_P = NULL) => 0.0199003831, -0.0002423457),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0607198659,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0244471986, -0.0030573637);

// Tree: 230 
woFDN_FLA__D_lgt_230 := map(
(NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
      map(
      (NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 1925) => 
         map(
         (NULL < c_totcrime and c_totcrime <= 189) => 0.0013610614,
         (c_totcrime > 189) => 
            map(
            (NULL < c_med_yearblt and c_med_yearblt <= 1954.5) => 0.1417254712,
            (c_med_yearblt > 1954.5) => 0.0084685474,
            (c_med_yearblt = NULL) => 0.0543359668, 0.0543359668),
         (c_totcrime = NULL) => -0.0110730430, 0.0022954047),
      (f_acc_damage_amt_last_i > 1925) => 0.1089208117,
      (f_acc_damage_amt_last_i = NULL) => 0.0031412956, 0.0031412956),
   (f_inq_count24_i > 14.5) => -0.0919994059,
   (f_inq_count24_i = NULL) => 0.0023772974, 0.0023772974),
(f_fp_prevaddrcrimeindex_i > 197.5) => -0.1035944842,
(f_fp_prevaddrcrimeindex_i = NULL) => -0.0085882579, 0.0016300003);

// Tree: 231 
woFDN_FLA__D_lgt_231 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0021399232,
(f_srchvelocityrisktype_i > 6.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 37.5) => -0.0597361919,
   (f_mos_inq_banko_cm_fseen_d > 37.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 5.95) => 0.1639463551,
      (c_famotf18_p > 5.95) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 124676.5) => 0.0993714971,
         (r_A46_Curr_AVM_AutoVal_d > 124676.5) => -0.0371891066,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 
            map(
            (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.4833595465) => 0.0667034710,
            (f_add_curr_nhood_MFD_pct_i > 0.4833595465) => -0.0379884497,
            (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0187811129, 0.0187811129), 0.0199175674),
      (c_famotf18_p = NULL) => 0.0537425100, 0.0537425100),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0328994831, 0.0328994831),
(f_srchvelocityrisktype_i = NULL) => 0.0116674594, -0.0005806875);

// Tree: 232 
woFDN_FLA__D_lgt_232 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 135.5) => 0.0632382099,
(r_D32_Mos_Since_Fel_LS_d > 135.5) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 8.85) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 24.5) => 0.0012522006,
      (f_rel_homeover200_count_d > 24.5) => 0.0630485641,
      (f_rel_homeover200_count_d = NULL) => -0.0107855011, 0.0020515320),
   (c_pop_75_84_p > 8.85) => -0.0369567356,
   (c_pop_75_84_p = NULL) => -0.0006888698, -0.0018306990),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 9.25) => 
      map(
      (NULL < c_no_car and c_no_car <= 100) => -0.0930289507,
      (c_no_car > 100) => 0.0184097329,
      (c_no_car = NULL) => -0.0392309655, -0.0392309655),
   (c_hval_750k_p > 9.25) => 0.0629122042,
   (c_hval_750k_p = NULL) => -0.0084649505, -0.0084649505), -0.0015284920);

// Tree: 233 
woFDN_FLA__D_lgt_233 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.45) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0453551854,
   (f_mos_inq_banko_om_fseen_d > 5.5) => 
      map(
      (NULL < c_business and c_business <= 371.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 0.0025918431,
         (f_varrisktype_i > 4.5) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.22589496305) => -0.1019248609,
            (f_add_curr_mobility_index_i > 0.22589496305) => -0.0236316371,
            (f_add_curr_mobility_index_i = NULL) => -0.0387310445, -0.0387310445),
         (f_varrisktype_i = NULL) => 0.0015551739, 0.0015551739),
      (c_business > 371.5) => -0.0605877693,
      (c_business = NULL) => -0.0008449913, -0.0008449913),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0035972729, -0.0027892306),
(c_hh6_p > 17.45) => -0.1130623139,
(c_hh6_p = NULL) => -0.0041856856, -0.0033929247);

// Tree: 234 
woFDN_FLA__D_lgt_234 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 146.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 187) => -0.0405256276,
      (c_unempl > 187) => 0.0855990774,
      (c_unempl = NULL) => -0.0034803872, -0.0370234301),
   (r_C13_max_lres_d > 146.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 77.85) => -0.0019863804,
      (c_rnt1000_p > 77.85) => 0.2160369955,
      (c_rnt1000_p = NULL) => -0.0314773971, 0.0012574539),
   (r_C13_max_lres_d = NULL) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 9.95) => -0.0315035293,
      (C_INC_125K_P > 9.95) => 0.0707228603,
      (C_INC_125K_P = NULL) => 0.0121963013, 0.0121963013), -0.0175670600),
(f_util_add_curr_conv_n > 0.5) => 0.0073676338,
(f_util_add_curr_conv_n = NULL) => -0.0039134232, -0.0039134232);

// Final Score Sum 

   woFDN_FLA__D_lgt := sum(
      woFDN_FLA__D_lgt_0, woFDN_FLA__D_lgt_1, woFDN_FLA__D_lgt_2, woFDN_FLA__D_lgt_3, woFDN_FLA__D_lgt_4, 
      woFDN_FLA__D_lgt_5, woFDN_FLA__D_lgt_6, woFDN_FLA__D_lgt_7, woFDN_FLA__D_lgt_8, woFDN_FLA__D_lgt_9, 
      woFDN_FLA__D_lgt_10, woFDN_FLA__D_lgt_11, woFDN_FLA__D_lgt_12, woFDN_FLA__D_lgt_13, woFDN_FLA__D_lgt_14, 
      woFDN_FLA__D_lgt_15, woFDN_FLA__D_lgt_16, woFDN_FLA__D_lgt_17, woFDN_FLA__D_lgt_18, woFDN_FLA__D_lgt_19, 
      woFDN_FLA__D_lgt_20, woFDN_FLA__D_lgt_21, woFDN_FLA__D_lgt_22, woFDN_FLA__D_lgt_23, woFDN_FLA__D_lgt_24, 
      woFDN_FLA__D_lgt_25, woFDN_FLA__D_lgt_26, woFDN_FLA__D_lgt_27, woFDN_FLA__D_lgt_28, woFDN_FLA__D_lgt_29, 
      woFDN_FLA__D_lgt_30, woFDN_FLA__D_lgt_31, woFDN_FLA__D_lgt_32, woFDN_FLA__D_lgt_33, woFDN_FLA__D_lgt_34, 
      woFDN_FLA__D_lgt_35, woFDN_FLA__D_lgt_36, woFDN_FLA__D_lgt_37, woFDN_FLA__D_lgt_38, woFDN_FLA__D_lgt_39, 
      woFDN_FLA__D_lgt_40, woFDN_FLA__D_lgt_41, woFDN_FLA__D_lgt_42, woFDN_FLA__D_lgt_43, woFDN_FLA__D_lgt_44, 
      woFDN_FLA__D_lgt_45, woFDN_FLA__D_lgt_46, woFDN_FLA__D_lgt_47, woFDN_FLA__D_lgt_48, woFDN_FLA__D_lgt_49, 
      woFDN_FLA__D_lgt_50, woFDN_FLA__D_lgt_51, woFDN_FLA__D_lgt_52, woFDN_FLA__D_lgt_53, woFDN_FLA__D_lgt_54, 
      woFDN_FLA__D_lgt_55, woFDN_FLA__D_lgt_56, woFDN_FLA__D_lgt_57, woFDN_FLA__D_lgt_58, woFDN_FLA__D_lgt_59, 
      woFDN_FLA__D_lgt_60, woFDN_FLA__D_lgt_61, woFDN_FLA__D_lgt_62, woFDN_FLA__D_lgt_63, woFDN_FLA__D_lgt_64, 
      woFDN_FLA__D_lgt_65, woFDN_FLA__D_lgt_66, woFDN_FLA__D_lgt_67, woFDN_FLA__D_lgt_68, woFDN_FLA__D_lgt_69, 
      woFDN_FLA__D_lgt_70, woFDN_FLA__D_lgt_71, woFDN_FLA__D_lgt_72, woFDN_FLA__D_lgt_73, woFDN_FLA__D_lgt_74, 
      woFDN_FLA__D_lgt_75, woFDN_FLA__D_lgt_76, woFDN_FLA__D_lgt_77, woFDN_FLA__D_lgt_78, woFDN_FLA__D_lgt_79, 
      woFDN_FLA__D_lgt_80, woFDN_FLA__D_lgt_81, woFDN_FLA__D_lgt_82, woFDN_FLA__D_lgt_83, woFDN_FLA__D_lgt_84, 
      woFDN_FLA__D_lgt_85, woFDN_FLA__D_lgt_86, woFDN_FLA__D_lgt_87, woFDN_FLA__D_lgt_88, woFDN_FLA__D_lgt_89, 
      woFDN_FLA__D_lgt_90, woFDN_FLA__D_lgt_91, woFDN_FLA__D_lgt_92, woFDN_FLA__D_lgt_93, woFDN_FLA__D_lgt_94, 
      woFDN_FLA__D_lgt_95, woFDN_FLA__D_lgt_96, woFDN_FLA__D_lgt_97, woFDN_FLA__D_lgt_98, woFDN_FLA__D_lgt_99, 
      woFDN_FLA__D_lgt_100, woFDN_FLA__D_lgt_101, woFDN_FLA__D_lgt_102, woFDN_FLA__D_lgt_103, woFDN_FLA__D_lgt_104, 
      woFDN_FLA__D_lgt_105, woFDN_FLA__D_lgt_106, woFDN_FLA__D_lgt_107, woFDN_FLA__D_lgt_108, woFDN_FLA__D_lgt_109, 
      woFDN_FLA__D_lgt_110, woFDN_FLA__D_lgt_111, woFDN_FLA__D_lgt_112, woFDN_FLA__D_lgt_113, woFDN_FLA__D_lgt_114, 
      woFDN_FLA__D_lgt_115, woFDN_FLA__D_lgt_116, woFDN_FLA__D_lgt_117, woFDN_FLA__D_lgt_118, woFDN_FLA__D_lgt_119, 
      woFDN_FLA__D_lgt_120, woFDN_FLA__D_lgt_121, woFDN_FLA__D_lgt_122, woFDN_FLA__D_lgt_123, woFDN_FLA__D_lgt_124, 
      woFDN_FLA__D_lgt_125, woFDN_FLA__D_lgt_126, woFDN_FLA__D_lgt_127, woFDN_FLA__D_lgt_128, woFDN_FLA__D_lgt_129, 
      woFDN_FLA__D_lgt_130, woFDN_FLA__D_lgt_131, woFDN_FLA__D_lgt_132, woFDN_FLA__D_lgt_133, woFDN_FLA__D_lgt_134, 
      woFDN_FLA__D_lgt_135, woFDN_FLA__D_lgt_136, woFDN_FLA__D_lgt_137, woFDN_FLA__D_lgt_138, woFDN_FLA__D_lgt_139, 
      woFDN_FLA__D_lgt_140, woFDN_FLA__D_lgt_141, woFDN_FLA__D_lgt_142, woFDN_FLA__D_lgt_143, woFDN_FLA__D_lgt_144, 
      woFDN_FLA__D_lgt_145, woFDN_FLA__D_lgt_146, woFDN_FLA__D_lgt_147, woFDN_FLA__D_lgt_148, woFDN_FLA__D_lgt_149, 
      woFDN_FLA__D_lgt_150, woFDN_FLA__D_lgt_151, woFDN_FLA__D_lgt_152, woFDN_FLA__D_lgt_153, woFDN_FLA__D_lgt_154, 
      woFDN_FLA__D_lgt_155, woFDN_FLA__D_lgt_156, woFDN_FLA__D_lgt_157, woFDN_FLA__D_lgt_158, woFDN_FLA__D_lgt_159, 
      woFDN_FLA__D_lgt_160, woFDN_FLA__D_lgt_161, woFDN_FLA__D_lgt_162, woFDN_FLA__D_lgt_163, woFDN_FLA__D_lgt_164, 
      woFDN_FLA__D_lgt_165, woFDN_FLA__D_lgt_166, woFDN_FLA__D_lgt_167, woFDN_FLA__D_lgt_168, woFDN_FLA__D_lgt_169, 
      woFDN_FLA__D_lgt_170, woFDN_FLA__D_lgt_171, woFDN_FLA__D_lgt_172, woFDN_FLA__D_lgt_173, woFDN_FLA__D_lgt_174, 
      woFDN_FLA__D_lgt_175, woFDN_FLA__D_lgt_176, woFDN_FLA__D_lgt_177, woFDN_FLA__D_lgt_178, woFDN_FLA__D_lgt_179, 
      woFDN_FLA__D_lgt_180, woFDN_FLA__D_lgt_181, woFDN_FLA__D_lgt_182, woFDN_FLA__D_lgt_183, woFDN_FLA__D_lgt_184, 
      woFDN_FLA__D_lgt_185, woFDN_FLA__D_lgt_186, woFDN_FLA__D_lgt_187, woFDN_FLA__D_lgt_188, woFDN_FLA__D_lgt_189, 
      woFDN_FLA__D_lgt_190, woFDN_FLA__D_lgt_191, woFDN_FLA__D_lgt_192, woFDN_FLA__D_lgt_193, woFDN_FLA__D_lgt_194, 
      woFDN_FLA__D_lgt_195, woFDN_FLA__D_lgt_196, woFDN_FLA__D_lgt_197, woFDN_FLA__D_lgt_198, woFDN_FLA__D_lgt_199, 
      woFDN_FLA__D_lgt_200, woFDN_FLA__D_lgt_201, woFDN_FLA__D_lgt_202, woFDN_FLA__D_lgt_203, woFDN_FLA__D_lgt_204, 
      woFDN_FLA__D_lgt_205, woFDN_FLA__D_lgt_206, woFDN_FLA__D_lgt_207, woFDN_FLA__D_lgt_208, woFDN_FLA__D_lgt_209, 
      woFDN_FLA__D_lgt_210, woFDN_FLA__D_lgt_211, woFDN_FLA__D_lgt_212, woFDN_FLA__D_lgt_213, woFDN_FLA__D_lgt_214, 
      woFDN_FLA__D_lgt_215, woFDN_FLA__D_lgt_216, woFDN_FLA__D_lgt_217, woFDN_FLA__D_lgt_218, woFDN_FLA__D_lgt_219, 
      woFDN_FLA__D_lgt_220, woFDN_FLA__D_lgt_221, woFDN_FLA__D_lgt_222, woFDN_FLA__D_lgt_223, woFDN_FLA__D_lgt_224, 
      woFDN_FLA__D_lgt_225, woFDN_FLA__D_lgt_226, woFDN_FLA__D_lgt_227, woFDN_FLA__D_lgt_228, woFDN_FLA__D_lgt_229, 
      woFDN_FLA__D_lgt_230, woFDN_FLA__D_lgt_231, woFDN_FLA__D_lgt_232, woFDN_FLA__D_lgt_233, woFDN_FLA__D_lgt_234); 


// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_woFDN_LGT := woFDN_FLA__D_lgt;
			
self.final_score_0	:= 	woFDN_FLA__D_lgt_0	;
self.final_score_1	:= 	woFDN_FLA__D_lgt_1	;
self.final_score_2	:= 	woFDN_FLA__D_lgt_2	;
self.final_score_3	:= 	woFDN_FLA__D_lgt_3	;
self.final_score_4	:= 	woFDN_FLA__D_lgt_4	;
self.final_score_5	:= 	woFDN_FLA__D_lgt_5	;
self.final_score_6	:= 	woFDN_FLA__D_lgt_6	;
self.final_score_7	:= 	woFDN_FLA__D_lgt_7	;
self.final_score_8	:= 	woFDN_FLA__D_lgt_8	;
self.final_score_9	:= 	woFDN_FLA__D_lgt_9	;
self.final_score_10	:= 	woFDN_FLA__D_lgt_10	;
self.final_score_11	:= 	woFDN_FLA__D_lgt_11	;
self.final_score_12	:= 	woFDN_FLA__D_lgt_12	;
self.final_score_13	:= 	woFDN_FLA__D_lgt_13	;
self.final_score_14	:= 	woFDN_FLA__D_lgt_14	;
self.final_score_15	:= 	woFDN_FLA__D_lgt_15	;
self.final_score_16	:= 	woFDN_FLA__D_lgt_16	;
self.final_score_17	:= 	woFDN_FLA__D_lgt_17	;
self.final_score_18	:= 	woFDN_FLA__D_lgt_18	;
self.final_score_19	:= 	woFDN_FLA__D_lgt_19	;
self.final_score_20	:= 	woFDN_FLA__D_lgt_20	;
self.final_score_21	:= 	woFDN_FLA__D_lgt_21	;
self.final_score_22	:= 	woFDN_FLA__D_lgt_22	;
self.final_score_23	:= 	woFDN_FLA__D_lgt_23	;
self.final_score_24	:= 	woFDN_FLA__D_lgt_24	;
self.final_score_25	:= 	woFDN_FLA__D_lgt_25	;
self.final_score_26	:= 	woFDN_FLA__D_lgt_26	;
self.final_score_27	:= 	woFDN_FLA__D_lgt_27	;
self.final_score_28	:= 	woFDN_FLA__D_lgt_28	;
self.final_score_29	:= 	woFDN_FLA__D_lgt_29	;
self.final_score_30	:= 	woFDN_FLA__D_lgt_30	;
self.final_score_31	:= 	woFDN_FLA__D_lgt_31	;
self.final_score_32	:= 	woFDN_FLA__D_lgt_32	;
self.final_score_33	:= 	woFDN_FLA__D_lgt_33	;
self.final_score_34	:= 	woFDN_FLA__D_lgt_34	;
self.final_score_35	:= 	woFDN_FLA__D_lgt_35	;
self.final_score_36	:= 	woFDN_FLA__D_lgt_36	;
self.final_score_37	:= 	woFDN_FLA__D_lgt_37	;
self.final_score_38	:= 	woFDN_FLA__D_lgt_38	;
self.final_score_39	:= 	woFDN_FLA__D_lgt_39	;
self.final_score_40	:= 	woFDN_FLA__D_lgt_40	;
self.final_score_41	:= 	woFDN_FLA__D_lgt_41	;
self.final_score_42	:= 	woFDN_FLA__D_lgt_42	;
self.final_score_43	:= 	woFDN_FLA__D_lgt_43	;
self.final_score_44	:= 	woFDN_FLA__D_lgt_44	;
self.final_score_45	:= 	woFDN_FLA__D_lgt_45	;
self.final_score_46	:= 	woFDN_FLA__D_lgt_46	;
self.final_score_47	:= 	woFDN_FLA__D_lgt_47	;
self.final_score_48	:= 	woFDN_FLA__D_lgt_48	;
self.final_score_49	:= 	woFDN_FLA__D_lgt_49	;
self.final_score_50	:= 	woFDN_FLA__D_lgt_50	;
self.final_score_51	:= 	woFDN_FLA__D_lgt_51	;
self.final_score_52	:= 	woFDN_FLA__D_lgt_52	;
self.final_score_53	:= 	woFDN_FLA__D_lgt_53	;
self.final_score_54	:= 	woFDN_FLA__D_lgt_54	;
self.final_score_55	:= 	woFDN_FLA__D_lgt_55	;
self.final_score_56	:= 	woFDN_FLA__D_lgt_56	;
self.final_score_57	:= 	woFDN_FLA__D_lgt_57	;
self.final_score_58	:= 	woFDN_FLA__D_lgt_58	;
self.final_score_59	:= 	woFDN_FLA__D_lgt_59	;
self.final_score_60	:= 	woFDN_FLA__D_lgt_60	;
self.final_score_61	:= 	woFDN_FLA__D_lgt_61	;
self.final_score_62	:= 	woFDN_FLA__D_lgt_62	;
self.final_score_63	:= 	woFDN_FLA__D_lgt_63	;
self.final_score_64	:= 	woFDN_FLA__D_lgt_64	;
self.final_score_65	:= 	woFDN_FLA__D_lgt_65	;
self.final_score_66	:= 	woFDN_FLA__D_lgt_66	;
self.final_score_67	:= 	woFDN_FLA__D_lgt_67	;
self.final_score_68	:= 	woFDN_FLA__D_lgt_68	;
self.final_score_69	:= 	woFDN_FLA__D_lgt_69	;
self.final_score_70	:= 	woFDN_FLA__D_lgt_70	;
self.final_score_71	:= 	woFDN_FLA__D_lgt_71	;
self.final_score_72	:= 	woFDN_FLA__D_lgt_72	;
self.final_score_73	:= 	woFDN_FLA__D_lgt_73	;
self.final_score_74	:= 	woFDN_FLA__D_lgt_74	;
self.final_score_75	:= 	woFDN_FLA__D_lgt_75	;
self.final_score_76	:= 	woFDN_FLA__D_lgt_76	;
self.final_score_77	:= 	woFDN_FLA__D_lgt_77	;
self.final_score_78	:= 	woFDN_FLA__D_lgt_78	;
self.final_score_79	:= 	woFDN_FLA__D_lgt_79	;
self.final_score_80	:= 	woFDN_FLA__D_lgt_80	;
self.final_score_81	:= 	woFDN_FLA__D_lgt_81	;
self.final_score_82	:= 	woFDN_FLA__D_lgt_82	;
self.final_score_83	:= 	woFDN_FLA__D_lgt_83	;
self.final_score_84	:= 	woFDN_FLA__D_lgt_84	;
self.final_score_85	:= 	woFDN_FLA__D_lgt_85	;
self.final_score_86	:= 	woFDN_FLA__D_lgt_86	;
self.final_score_87	:= 	woFDN_FLA__D_lgt_87	;
self.final_score_88	:= 	woFDN_FLA__D_lgt_88	;
self.final_score_89	:= 	woFDN_FLA__D_lgt_89	;
self.final_score_90	:= 	woFDN_FLA__D_lgt_90	;
self.final_score_91	:= 	woFDN_FLA__D_lgt_91	;
self.final_score_92	:= 	woFDN_FLA__D_lgt_92	;
self.final_score_93	:= 	woFDN_FLA__D_lgt_93	;
self.final_score_94	:= 	woFDN_FLA__D_lgt_94	;
self.final_score_95	:= 	woFDN_FLA__D_lgt_95	;
self.final_score_96	:= 	woFDN_FLA__D_lgt_96	;
self.final_score_97	:= 	woFDN_FLA__D_lgt_97	;
self.final_score_98	:= 	woFDN_FLA__D_lgt_98	;
self.final_score_99	:= 	woFDN_FLA__D_lgt_99	;
self.final_score_100	:= 	woFDN_FLA__D_lgt_100	;
self.final_score_101	:= 	woFDN_FLA__D_lgt_101	;
self.final_score_102	:= 	woFDN_FLA__D_lgt_102	;
self.final_score_103	:= 	woFDN_FLA__D_lgt_103	;
self.final_score_104	:= 	woFDN_FLA__D_lgt_104	;
self.final_score_105	:= 	woFDN_FLA__D_lgt_105	;
self.final_score_106	:= 	woFDN_FLA__D_lgt_106	;
self.final_score_107	:= 	woFDN_FLA__D_lgt_107	;
self.final_score_108	:= 	woFDN_FLA__D_lgt_108	;
self.final_score_109	:= 	woFDN_FLA__D_lgt_109	;
self.final_score_110	:= 	woFDN_FLA__D_lgt_110	;
self.final_score_111	:= 	woFDN_FLA__D_lgt_111	;
self.final_score_112	:= 	woFDN_FLA__D_lgt_112	;
self.final_score_113	:= 	woFDN_FLA__D_lgt_113	;
self.final_score_114	:= 	woFDN_FLA__D_lgt_114	;
self.final_score_115	:= 	woFDN_FLA__D_lgt_115	;
self.final_score_116	:= 	woFDN_FLA__D_lgt_116	;
self.final_score_117	:= 	woFDN_FLA__D_lgt_117	;
self.final_score_118	:= 	woFDN_FLA__D_lgt_118	;
self.final_score_119	:= 	woFDN_FLA__D_lgt_119	;
self.final_score_120	:= 	woFDN_FLA__D_lgt_120	;
self.final_score_121	:= 	woFDN_FLA__D_lgt_121	;
self.final_score_122	:= 	woFDN_FLA__D_lgt_122	;
self.final_score_123	:= 	woFDN_FLA__D_lgt_123	;
self.final_score_124	:= 	woFDN_FLA__D_lgt_124	;
self.final_score_125	:= 	woFDN_FLA__D_lgt_125	;
self.final_score_126	:= 	woFDN_FLA__D_lgt_126	;
self.final_score_127	:= 	woFDN_FLA__D_lgt_127	;
self.final_score_128	:= 	woFDN_FLA__D_lgt_128	;
self.final_score_129	:= 	woFDN_FLA__D_lgt_129	;
self.final_score_130	:= 	woFDN_FLA__D_lgt_130	;
self.final_score_131	:= 	woFDN_FLA__D_lgt_131	;
self.final_score_132	:= 	woFDN_FLA__D_lgt_132	;
self.final_score_133	:= 	woFDN_FLA__D_lgt_133	;
self.final_score_134	:= 	woFDN_FLA__D_lgt_134	;
self.final_score_135	:= 	woFDN_FLA__D_lgt_135	;
self.final_score_136	:= 	woFDN_FLA__D_lgt_136	;
self.final_score_137	:= 	woFDN_FLA__D_lgt_137	;
self.final_score_138	:= 	woFDN_FLA__D_lgt_138	;
self.final_score_139	:= 	woFDN_FLA__D_lgt_139	;
self.final_score_140	:= 	woFDN_FLA__D_lgt_140	;
self.final_score_141	:= 	woFDN_FLA__D_lgt_141	;
self.final_score_142	:= 	woFDN_FLA__D_lgt_142	;
self.final_score_143	:= 	woFDN_FLA__D_lgt_143	;
self.final_score_144	:= 	woFDN_FLA__D_lgt_144	;
self.final_score_145	:= 	woFDN_FLA__D_lgt_145	;
self.final_score_146	:= 	woFDN_FLA__D_lgt_146	;
self.final_score_147	:= 	woFDN_FLA__D_lgt_147	;
self.final_score_148	:= 	woFDN_FLA__D_lgt_148	;
self.final_score_149	:= 	woFDN_FLA__D_lgt_149	;
self.final_score_150	:= 	woFDN_FLA__D_lgt_150	;
self.final_score_151	:= 	woFDN_FLA__D_lgt_151	;
self.final_score_152	:= 	woFDN_FLA__D_lgt_152	;
self.final_score_153	:= 	woFDN_FLA__D_lgt_153	;
self.final_score_154	:= 	woFDN_FLA__D_lgt_154	;
self.final_score_155	:= 	woFDN_FLA__D_lgt_155	;
self.final_score_156	:= 	woFDN_FLA__D_lgt_156	;
self.final_score_157	:= 	woFDN_FLA__D_lgt_157	;
self.final_score_158	:= 	woFDN_FLA__D_lgt_158	;
self.final_score_159	:= 	woFDN_FLA__D_lgt_159	;
self.final_score_160	:= 	woFDN_FLA__D_lgt_160	;
self.final_score_161	:= 	woFDN_FLA__D_lgt_161	;
self.final_score_162	:= 	woFDN_FLA__D_lgt_162	;
self.final_score_163	:= 	woFDN_FLA__D_lgt_163	;
self.final_score_164	:= 	woFDN_FLA__D_lgt_164	;
self.final_score_165	:= 	woFDN_FLA__D_lgt_165	;
self.final_score_166	:= 	woFDN_FLA__D_lgt_166	;
self.final_score_167	:= 	woFDN_FLA__D_lgt_167	;
self.final_score_168	:= 	woFDN_FLA__D_lgt_168	;
self.final_score_169	:= 	woFDN_FLA__D_lgt_169	;
self.final_score_170	:= 	woFDN_FLA__D_lgt_170	;
self.final_score_171	:= 	woFDN_FLA__D_lgt_171	;
self.final_score_172	:= 	woFDN_FLA__D_lgt_172	;
self.final_score_173	:= 	woFDN_FLA__D_lgt_173	;
self.final_score_174	:= 	woFDN_FLA__D_lgt_174	;
self.final_score_175	:= 	woFDN_FLA__D_lgt_175	;
self.final_score_176	:= 	woFDN_FLA__D_lgt_176	;
self.final_score_177	:= 	woFDN_FLA__D_lgt_177	;
self.final_score_178	:= 	woFDN_FLA__D_lgt_178	;
self.final_score_179	:= 	woFDN_FLA__D_lgt_179	;
self.final_score_180	:= 	woFDN_FLA__D_lgt_180	;
self.final_score_181	:= 	woFDN_FLA__D_lgt_181	;
self.final_score_182	:= 	woFDN_FLA__D_lgt_182	;
self.final_score_183	:= 	woFDN_FLA__D_lgt_183	;
self.final_score_184	:= 	woFDN_FLA__D_lgt_184	;
self.final_score_185	:= 	woFDN_FLA__D_lgt_185	;
self.final_score_186	:= 	woFDN_FLA__D_lgt_186	;
self.final_score_187	:= 	woFDN_FLA__D_lgt_187	;
self.final_score_188	:= 	woFDN_FLA__D_lgt_188	;
self.final_score_189	:= 	woFDN_FLA__D_lgt_189	;
self.final_score_190	:= 	woFDN_FLA__D_lgt_190	;
self.final_score_191	:= 	woFDN_FLA__D_lgt_191	;
self.final_score_192	:= 	woFDN_FLA__D_lgt_192	;
self.final_score_193	:= 	woFDN_FLA__D_lgt_193	;
self.final_score_194	:= 	woFDN_FLA__D_lgt_194	;
self.final_score_195	:= 	woFDN_FLA__D_lgt_195	;
self.final_score_196	:= 	woFDN_FLA__D_lgt_196	;
self.final_score_197	:= 	woFDN_FLA__D_lgt_197	;
self.final_score_198	:= 	woFDN_FLA__D_lgt_198	;
self.final_score_199	:= 	woFDN_FLA__D_lgt_199	;
self.final_score_200	:= 	woFDN_FLA__D_lgt_200	;
self.final_score_201	:= 	woFDN_FLA__D_lgt_201	;
self.final_score_202	:= 	woFDN_FLA__D_lgt_202	;
self.final_score_203	:= 	woFDN_FLA__D_lgt_203	;
self.final_score_204	:= 	woFDN_FLA__D_lgt_204	;
self.final_score_205	:= 	woFDN_FLA__D_lgt_205	;
self.final_score_206	:= 	woFDN_FLA__D_lgt_206	;
self.final_score_207	:= 	woFDN_FLA__D_lgt_207	;
self.final_score_208	:= 	woFDN_FLA__D_lgt_208	;
self.final_score_209	:= 	woFDN_FLA__D_lgt_209	;
self.final_score_210	:= 	woFDN_FLA__D_lgt_210	;
self.final_score_211	:= 	woFDN_FLA__D_lgt_211	;
self.final_score_212	:= 	woFDN_FLA__D_lgt_212	;
self.final_score_213	:= 	woFDN_FLA__D_lgt_213	;
self.final_score_214	:= 	woFDN_FLA__D_lgt_214	;
self.final_score_215	:= 	woFDN_FLA__D_lgt_215	;
self.final_score_216	:= 	woFDN_FLA__D_lgt_216	;
self.final_score_217	:= 	woFDN_FLA__D_lgt_217	;
self.final_score_218	:= 	woFDN_FLA__D_lgt_218	;
self.final_score_219	:= 	woFDN_FLA__D_lgt_219	;
self.final_score_220	:= 	woFDN_FLA__D_lgt_220	;
self.final_score_221	:= 	woFDN_FLA__D_lgt_221	;
self.final_score_222	:= 	woFDN_FLA__D_lgt_222	;
self.final_score_223	:= 	woFDN_FLA__D_lgt_223	;
self.final_score_224	:= 	woFDN_FLA__D_lgt_224	;
self.final_score_225	:= 	woFDN_FLA__D_lgt_225	;
self.final_score_226	:= 	woFDN_FLA__D_lgt_226	;
self.final_score_227	:= 	woFDN_FLA__D_lgt_227	;
self.final_score_228	:= 	woFDN_FLA__D_lgt_228	;
self.final_score_229	:= 	woFDN_FLA__D_lgt_229	;
self.final_score_230	:= 	woFDN_FLA__D_lgt_230	;
self.final_score_231	:= 	woFDN_FLA__D_lgt_231	;
self.final_score_232	:= 	woFDN_FLA__D_lgt_232	;
self.final_score_233	:= 	woFDN_FLA__D_lgt_233	;
self.final_score_234	:= 	woFDN_FLA__D_lgt_234	;
// self.woFDN_submodel_lgt	:= 	woFDN_FLA__D_lgt	;
self.FP3_woFDN_LGT		:= 	woFDN_FLA__D_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
